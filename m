Return-Path: <linux-kernel+bounces-191191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F98D0850
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8980B309D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334F15FD01;
	Mon, 27 May 2024 15:59:58 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B61F315FD04
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825598; cv=none; b=dSw3VMEGBUjD44FWrgcXvhKU9cJyqNuFttMxn6mAFhAdcOMs4IFdw/xh+aKUuJU3ZKQcILoTdVRK1pbhax5HWdVkrPOsGCpUMUH/pqsb0mYuQFGIchNVVE2AbJFbtfhlSSws344gsJxlpuXMzEEEqcAz9dhgAkL4m1vCcB8UYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825598; c=relaxed/simple;
	bh=ffEWuxCllktJhS6CvvMULqiZ+vYepD6NCdO09y7vhNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ4UwCcnIJDM4cIk4+x6PpHKTthQhXRzQJIUXnGKK51qlOYgP9LAE7dAG1adjnswCqVNYfqrbpbS9k+oA/yTA9LyFyzvzQWiig/EXqFPtQ3AnL8ws4pMuFFZM8Q69SGd1MkYUgO2QEhSkNdQVe0EV5kJaxDuj0AiUJUBMwzxVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 663339 invoked by uid 1000); 27 May 2024 11:59:55 -0400
Date: Mon, 27 May 2024 11:59:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] tools/memory-model: Define applicable tags on
 operation in tools/...
Message-ID: <2094aee7-4597-4f7e-b08f-9829f70aa8ff@rowland.harvard.edu>
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-3-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152253.195956-3-jonas.oberhauser@huaweicloud.com>

On Mon, May 27, 2024 at 05:22:51PM +0200, Jonas Oberhauser wrote:
> Herd7 transforms reads, writes, and read-modify-writes by eliminating
> 'acquire tags from writes, 'release tags from reads, and 'acquire,
> 'release, and 'mb tags from failed read-modify-writes. We emulate this
> behavior by redefining Acquire, Release, and Mb sets in linux-kernel.bell
> to explicitly exclude those combinations.
> 
> Herd7 furthermore adds 'noreturn tag to certain reads. Currently herd7
> does not allow specifying the 'noreturn tag manually, but such manual
> declaration (e.g., through a syntax __atomic_op{noreturn}) would add
> invalid 'noreturn tags to writes; in preparation, we already also exclude
> this combination.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.bell | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 1b2444cdf8d1..08fa1ccb1328 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -36,6 +36,13 @@ enum Barriers = 'wmb (*smp_wmb*) ||
>  		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
>  instructions F[Barriers]
>  
> +(* Remove impossible tags, such as Acquire on a store or failed RMW *)
> +let FailedRMW = RMW \ (domain(rmw) | range(rmw))
> +let Acquire = Acquire \ W \ FailedRMW
> +let Release = Release \ R \ FailedRMW
> +let Mb = Mb \ FailedRMW
> +let Noreturn = Noreturn \ W
> +
>  (* SRCU *)
>  enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
>  instructions SRCU[SRCU]
> @@ -82,4 +89,4 @@ let Plain = M \ Marked
>  let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
>  let addr = carry-dep ; addr
>  let ctrl = carry-dep ; ctrl
> -let data = carry-dep ; data
> +let data = carry-dep ; data
> \ No newline at end of file

It looks like the final newline was accidentally deleted.

Alan

