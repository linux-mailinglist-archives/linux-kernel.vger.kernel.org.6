Return-Path: <linux-kernel+bounces-191172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22B8D0798
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F941F2179D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947015F41D;
	Mon, 27 May 2024 15:58:04 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 46B4516F0DC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825484; cv=none; b=LTWceDW77P3adxyPhLCpXasXGhVN0WEvu2OQMRW5MC2uwOdT6sroa38n/LfOejTWyCfMqISjM0kS+D31Cu3nDwwb1aTMNqLtdq9/T5hNuJ243KM6w5U76qTDw6DvFLToH2eHORCI0ivH03cW0PK8vCfn/l41IBX/W5rEuiBRgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825484; c=relaxed/simple;
	bh=k6N9dn7iRJq8ZaIqt4CaMWQZbxwAmp4kdB6ZdQ6EO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdnUZ752tsTPUmxR4EAmwWGYmvP7VJ8NV9Y3Ef0kTF9b/MCnBpYgSk++RElrDLlKhGcqZWUNB9Pm3+GneBUuGmNrvXFhhq8RTjeooEjG/Gq5y1DGMRpDB0yM/+TPmHV39p26B4+NXiI0CgVWF3mW8G00hYChkhbkxD6SU60jqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 663299 invoked by uid 1000); 27 May 2024 11:58:01 -0400
Date: Mon, 27 May 2024 11:58:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] tools/memory-model: Legitimize current use of
 tags in LKMM macros
Message-ID: <aacd17e1-15b3-4bd9-9052-9c7e309fb2d8@rowland.harvard.edu>
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-2-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152253.195956-2-jonas.oberhauser@huaweicloud.com>

On Mon, May 27, 2024 at 05:22:50PM +0200, Jonas Oberhauser wrote:
> The current macros in linux-kernel.def reference instructions such as
> __xchg{mb} or __cmpxchg{acquire}, which are invalid combinations of tags
> and instructions according to the declarations in linux-kernel.bell.
> This works with current herd7 because herd7 removes these tags anyways
> and does not actually enforce validity of combinations at all.
> 
> If a future herd7 version no longer applies these hardcoded
> transformations, then all currently invalid combinations will actually
> appear on some instruction.
> 
> We therefore adjust the declarations to make the resulting combinations
> valid, by adding the 'mb tag to the set of Accesses and allowing all
> Accesses to appear on all read, write, and RMW instructions.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.bell | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index ce068700939c..1b2444cdf8d1 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -16,10 +16,11 @@
>  enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
>  		'release (*smp_store_release*) ||
>  		'acquire (*smp_load_acquire*) ||
> -		'noreturn (* R of non-return RMW *)
> -instructions R[{'once,'acquire,'noreturn}]
> -instructions W[{'once,'release}]
> -instructions RMW[{'once,'acquire,'release}]
> +		'noreturn (* R of non-return RMW *) ||
> +		'mb (*xchg(),compare_exchange(),...*)

It would be better to write cmpxchg() instead of compare_exchange().

Alan

> +instructions R[Accesses]
> +instructions W[Accesses]
> +instructions RMW[Accesses]
>  
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
> -- 
> 2.34.1
> 

