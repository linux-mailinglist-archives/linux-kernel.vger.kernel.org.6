Return-Path: <linux-kernel+bounces-191198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F080A8D07DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927F51F21629
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9E1607B1;
	Mon, 27 May 2024 16:04:13 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1921C15FA61
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825853; cv=none; b=ifxYbWxrsz0yT9c83CEkLcYOx65BtoWNBB8VnmXosmiLmYlpfVNqVb2DT6Ce2Fjw0/XVN6eL8Y5PWFEJ10unDrekTgykdO9yYB7ycL5oTBIrBxFcI8/Zm1d1fRsx8k9Y+0zza/rLaoWkEK8zzX9UHHpSGZjvsJw6fE57tTjOhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825853; c=relaxed/simple;
	bh=h54dWY/zDi3py//moP1826iPuQH0d1/QxOp7rIFQxz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUk79eNlT6GUjtYnXDF0sPr7k+FeGr4aSWch4umDoj+KKGoZGRdiEepNlFEC/bl2MiaWyU1zbZKKX7W34J2RJlXLxw1wpkX0Ke+L587JEbtVJolpzj/7gQOkQujuECpbJ1v2N9fHBDUAgASLHMZjSEX/pZ6ifXkQYeEpGtl/QuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 663494 invoked by uid 1000); 27 May 2024 12:04:10 -0400
Date: Mon, 27 May 2024 12:04:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org, Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: Re: [RFC][PATCH 3/4] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
Message-ID: <42f31a6a-2f99-46fa-9fac-c3ad5174399a@rowland.harvard.edu>
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-4-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152253.195956-4-jonas.oberhauser@huaweicloud.com>

On Mon, May 27, 2024 at 05:22:52PM +0200, Jonas Oberhauser wrote:
> Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
> around them. We emulate this by considering imaginary po-edges before the
> RMW read and before the RMW write, and extending the smp_mb() ordering
> rule, which currently only applies to real po edges that would be found
> around a really inserted smp_mb(), also to cases of the only imagined po
> edges.
> 
> Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.cat | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index adf3c4f41229..3a6e9677abe4 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -34,6 +34,15 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
>  let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> +	(* full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
> +	 * though there were enclosed by smp_mb().
> +	 * The effect of these virtual smp_mb() is formalized by adding
> +	 * Mb tags to the read and write of the operation, and providing
> +	 * the same ordering as though there were additional po edges
> +	 * between the Mb tag and the read resp. write.
> +	 *)

This file's style calls for multiline comments to start with "(*" on a 
line by themselves.

> +	([M] ; po ; [Mb] ; (* po ; *) [R]) |
> +	([W] ; (* po ; *) [Mb] ; po ; [M]) |

Can't these be written as:

	([M] ; po ; [Mb & R]) |
	([Mb & W] ; po ; [M]) |

?  I think this would be easier to understand, even though it doesn't 
correspond as directly to the comment.

Alan

>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -- 
> 2.34.1
> 

