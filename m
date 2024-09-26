Return-Path: <linux-kernel+bounces-340117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C7986EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA644B241E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7B1A4B8F;
	Thu, 26 Sep 2024 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FB37s9Nf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0B188CB8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339178; cv=none; b=dHRl069sLMK8J5DFSDKC0x6xWlxaKPasRFhjmJW4qQgs16Sd2WIWlhRgAXZWnp9l1dTVuS3usk4C+7AsQb/FcAHFTayNOnRosukBtJ+zEnE4h/A6Y8kNy6nLLMCZ59rFc56kRQH3FEBfFAkFDyxnOUdBOfq+KJiDL3nl96F1UhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339178; c=relaxed/simple;
	bh=ieSjn7eGJQi1Ofr5bhV0UVau9UldQEjlxk00g/CD90c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjMUD+Xf+1/GJvhsAEeLrLDkV+zpHqtD9wSfycZhkRHSU+sb3VafxuuubvN5SNjKN5psF8ZQTz4Aeac4k3St9gk3+oTqN8chftE0br3sSefv67XBYmFon+nnSI70WpnA0zuKBedVQHpwQckgNY8gDjnjNJV20ubJ9xFsuNlR2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FB37s9Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95C9C4CEC5;
	Thu, 26 Sep 2024 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727339177;
	bh=ieSjn7eGJQi1Ofr5bhV0UVau9UldQEjlxk00g/CD90c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB37s9NfypzXVwr34K5o2rx+p2KhdhQh+xjPlclXdyLYsUVFOI2StPmEyHeUDuzbb
	 TyIOnzjylOXqA6zQfQn5wffgtwrnt/XiYYiLd5uIJB8aLdjv2IqbHucMfc8Sv3jQPn
	 sgNjct5HzFyi2DwUl2pXEbJWW0UmXSXkms79h1mc=
Date: Thu, 26 Sep 2024 10:26:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tkjos@google.com,
	Fangzheng Zhang <fangzheng.zhang1003@gmail.com>,
	Yuming Han <yuming.han@unisoc.com>
Subject: Re: [PATCH V2 1/2] mm/slub: Add panic function when slub leaks
Message-ID: <2024092602-porcupine-pacifier-a795@gregkh>
References: <20240925132505.21278-1-fangzheng.zhang@unisoc.com>
 <20240925132505.21278-2-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925132505.21278-2-fangzheng.zhang@unisoc.com>

On Wed, Sep 25, 2024 at 09:25:04PM +0800, Fangzheng Zhang wrote:
> Perform real-time memory usage monitoring on the slub page
> allocation paths, ie, kmalloc_large_alloced and alloc_slab_page.
> When the usage exceeds the set threshole value, the panic function
> will be triggered.
> 
> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> ---
>  mm/Kconfig | 11 ++++++++
>  mm/slub.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09aebca1cae3..60cf72d4f0da 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -255,6 +255,17 @@ config SLUB_TINY
>  
>  	   If unsure, say N.
>  
> +config SLUB_LEAK_PANIC
> +	bool "Trigger panic when slub leaks"
> +	default y

Again, only use "default y" if you can not boot a machine without your
option enabled.  That is not the case here so please remove this line.

> +	help
> +	  Detect slub leaks by monitoring its usage in real time on the page
> +	  allocation path of the slub. When the slub occupancy exceeds the
> +	  user-set value, it is considered that the slub is leaking at this
> +	  time, and a panic operation will be triggered immediately. Uers
> +	  can enable and set leak threshold by using the kernel command line
> +	  parameters "slub.leak_panic" and "slub.leak_panic_threshold".
> +
>  config SLAB_MERGE_DEFAULT
>  	bool "Allow slab caches to be merged"
>  	default y
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06..a0b514626de1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -42,6 +42,7 @@
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
>  #include <linux/sort.h>
> +#include <linux/vmstat.h>
>  
>  #include <linux/debugfs.h>
>  #include <trace/events/kmem.h>
> @@ -218,6 +219,15 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>  #endif
>  #endif		/* CONFIG_SLUB_DEBUG */
>  
> +/* Internal slub_leak_panic definitions */
> +#ifdef CONFIG_SLUB_LEAK_PANIC
> +#define K(x) ((x) << (PAGE_SHIFT-10))

That is a very bad macro name, can you not use something more
descriptive?

> +static bool __read_mostly slub_leak_panic_enabled;
> +static unsigned int __read_mostly slub_leak_panic_threshold;
> +static long max_slab_count, temp_slab_count;
> +#endif

Also, again, please remove #ifdef from .c files as asked for before.

thanks,

greg k-h

