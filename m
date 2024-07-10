Return-Path: <linux-kernel+bounces-246913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9FF92C8DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D95284ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740E17C61;
	Wed, 10 Jul 2024 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nc9HF4+F"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498618651;
	Wed, 10 Jul 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580631; cv=none; b=MaFMr/G86pPQPCYc4g5InKmTV270u2+Wq1lVeetletEkwFX7pU93zD4LdakGqDN85wD2gnMA6zhCJLpq+1yCYE+/WDt0xypbXhHbz4q/TXSxxaFVwF33/la2tFcaJUkZosc/7KU5Ix1DFuBLIyyN0noNtr/qBbgXonaanzOzvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580631; c=relaxed/simple;
	bh=lZL60FD/ZnMauqokW//cEozqbNGygPLb+advuIPrLOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5aU4S8kymXhdxfTIkkG2jBNXt1MV0De2DxxpmARlLvHJbvl5y6ZFb0LGdsGx7yOLolUGD05zzYjaJ925a5q5JeOn4Ewb0vQXe3JzA4bLpTUgVozcNXvIEgYONnHMhpu72bLuuPRTSMLZpUbqsrp+8wWstxNWKuOZiIkbhUR8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nc9HF4+F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4QCXCz0zQ+WlrfEgvyLBZrRzTFdgqTlxMzUM+AKRzos=; b=Nc9HF4+FeXLRBKeWwJ8dE4sC+4
	pTatc1wxGhT87C4gpQ7rzONyvrF+NJLuI382zUE0PHOO5RBDRaAeI7+NUbheXCZ8/MNI/pFVbwoLC
	+5+GT4rp1r6a8iZzRQ3H+eghUm9KMaiBhWgJRJ6yJKgTJUjNruYHo2AVqbjbqxL0V31YOjrQn9GXV
	5DlqZL5vh8X+C1i2jykhPQCpyHWd8OzfSbIuItSotjcqN3Z+ARVkw19rMZLNTb6DxatIe6cCel1Ux
	qOpwXAF7Tt2VvE6XEb+YeuvfJfGS4Q8NIMh+lkcaBEpQcN5z3RlVKZohWehUTb8qgXB8tVeUubGSc
	ajXN6tCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRNcD-00000008drV-0f3I;
	Wed, 10 Jul 2024 03:03:33 +0000
Date: Wed, 10 Jul 2024 04:03:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: sxwjean@me.com
Cc: vbabka@suse.cz, surenb@google.com, cl@linux.co, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, xiongwei.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function
 enabled
Message-ID: <Zo36BTqhzGkukyT_@casper.infradead.org>
References: <20240710025418.394321-1-sxwjean@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710025418.394321-1-sxwjean@me.com>

On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@linux.dev>
> 
> The only user of prepare_slab_obj_exts_hook() is
> alloc_tagging_slab_alloc_hook(), which can build with
> CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
> when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unused"
> for prepare_slab_obj_exts_hook().

Perhaps instead clang can be fixed to match gcc's behaviour?

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/
> Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ce39544acf7c..2e26f20759c0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
>  	return false;
>  }
>  
> -static inline struct slabobj_ext *
> +static inline struct slabobj_ext * __maybe_unused
>  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>  	struct slab *slab;
> @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
>  	return false;
>  }
>  
> -static inline struct slabobj_ext *
> +static inline struct slabobj_ext * __maybe_unused
>  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>  	return NULL;
> -- 
> 2.34.1
> 
> 

