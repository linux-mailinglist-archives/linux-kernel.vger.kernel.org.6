Return-Path: <linux-kernel+bounces-297875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156395BEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0461AB23534
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D81D04A5;
	Thu, 22 Aug 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PtGPXCWI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91663A8D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354509; cv=none; b=AyOI3t7+7vcWI6d83zgsBRGI77rnIhuwCrnYg2UXRbE77r9MgpYojZbrmEveT72XjddDPU5IjyoFTq8uzd5Gtlszz3jgL8xGATXZilg+8nemoF+eyKRZg49VA/Di/AZsnWfcI+bFWMwsFAMF7vO94CaykkuA3wVQk3SCdQxa3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354509; c=relaxed/simple;
	bh=65hbsHwKSt85JtL4UmAe+Is1vNsDFMWsOoXnFhSU9r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXPlrco8U6ggatN0cF1POt/PPVMi7vOM2RaSc/r5v4U7IKMU8HHyK4EpjGf3tgsbTrAthgTr+HiGG8NP3h2BsZWz8Mff8W0GeAfyMVz5j2w/M4opIl6Ek0Tl1xTzBxJp37ZDqMfQI1y8Je+4XCwdyDegz2UcAe/L/0J9Z+RjFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PtGPXCWI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o+kzwnlrYPI986XZaYIi/iuBCYvOnpv7zBcQt10AKTg=; b=PtGPXCWI/x1D3a2uxfwSgicySr
	OsK31hPjnji0GWIxsBHXRpB0bPAwDvFV+zzOGOZBFSVGfnz8NeQvYSLjCTA5D6aehd7JUjojmqHOM
	hGw+oF8fAz9ZE6GJb/f9Kw3sVu+3Du7q3Y0/P0OJIAL2HVQAGMskF47YdWb6wqDRcr08cyxgMH+24
	/JRq+BjHL9Sk6YkkG/FO8KqL0o28GpeIcjCjFAgbHuE1XyecSjmGmCy2dzxqPaI0y7ePAmKsLveBI
	kUu70pwqW8z2qE5YM2e/oW0cvb4tDNU0Gjc8nfCLTHhRLLwm/mfEPEPbXyQ7nqhIq3iPLMf+Ap+fu
	awcASOIw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shDNM-0000000Aqzc-3DXZ;
	Thu, 22 Aug 2024 19:21:40 +0000
Date: Thu, 22 Aug 2024 20:21:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] maple_tree: Allow external locks to be configured
 with their map
Message-ID: <ZsePxD2FtYcBIaD5@casper.infradead.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
 <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>

On Thu, Aug 22, 2024 at 08:13:35PM +0100, Mark Brown wrote:
> Currently the maple tree code allows external locks to be configured by
> passing the lock itself. This is generally helpful and convenient but is

No, it's a really bad idea.  Stop doing it.  Use the internal lock.
It's a temporary hack we put in and I'm really regretting allowing it.

> not ideal for situations like the regmap maple tree cache where we support
> configurable locking at the regmap level and don't have the lock type when
> we are configuring the maple tree. Add a helper that allows us to pass the
> dep map directly to help with these situations. Since such code is already
> peering at the lockdep internals enough to be looking at the map no stub
> is provided.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/maple_tree.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index a53ad4dabd7e..bdc6b133abdc 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -193,6 +193,9 @@ typedef struct lockdep_map *lockdep_map_p;
>  #define mt_set_external_lock(mt, lock)					\
>  	(mt)->ma_external_lock = &(lock)->dep_map
>  
> +#define mt_set_external_lock_dep_map(mt, dep_map)			\
> +	(mt)->ma_external_lock = dep_map
> +
>  #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
>  #else
>  typedef struct { /* nothing */ } lockdep_map_p;
> 
> -- 
> 2.39.2
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree

