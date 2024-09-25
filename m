Return-Path: <linux-kernel+bounces-338238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCD4985533
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D847A1F2432E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671E15AD9B;
	Wed, 25 Sep 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqUtiHKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAF15A851
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251855; cv=none; b=j2pfTp0C9FfUXSWWms+4hSPhqDGIii1AqJwC5qGsdNEfVe64U8hITi1qqeE3a01Uc7MR22bWHRlehGvsTkSyCnN1b7+E8rULvxoVikiSRg3ivyOm4vRK4kI9GwFfqVwJQr8L96WhrrX8R433JIrQJ018cnLhffkiH4WEaF+xeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251855; c=relaxed/simple;
	bh=UzK291mxXxbkbGh766qf/zEd99wtKZEiO0xk+CZ/uh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiOKkpz+PPs3oTkiTSEQs05suX2wjxmloLR+eCQa0e7+/Q2vRcBs0A/89vQIFFfgVs1Y18asM++VydanP04NGFPWF44zJiebGQriBKleCKr3v0KiLCWSubrrtAoYtKYteipPNMSuVxX1H2qPM/CMnbYlpR3WwOlKVXzYCagjkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqUtiHKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D6C4CEC3;
	Wed, 25 Sep 2024 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727251854;
	bh=UzK291mxXxbkbGh766qf/zEd99wtKZEiO0xk+CZ/uh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqUtiHKGIYRKEszWIETKHucQ1UCh5d3MVzEDwS2iZrR/UIaxIggYQWrfnpPm8TRZG
	 /m4gZd1jPWaP7jMaA2LZ0kXVrziZupv81rWSfQBN4EwpK6ywpeY7i+ALy2bjouMKRc
	 nYfaUIKL3jHSXte+aMFPs5RoQ0JCAQyxRPbIFKTA=
Date: Wed, 25 Sep 2024 10:10:51 +0200
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
Subject: Re: [PATCH 1/2] mm/slub: Add panic function when slub leaks
Message-ID: <2024092528-primp-ogle-23c4@gregkh>
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <20240925032256.1782-2-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925032256.1782-2-fangzheng.zhang@unisoc.com>

On Wed, Sep 25, 2024 at 11:22:55AM +0800, Fangzheng Zhang wrote:
> Perform real-time memory usage monitoring on the slub page
> allocation paths, ie, kmalloc_large_alloced and alloc_slab_page.
> When the usage exceeds the set threshole value, the panic function
> will be triggered.
> 
> Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
> ---
>  mm/Kconfig | 11 ++++++++
>  mm/slub.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
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
> index 21f71cb6cc06..91049f87ab98 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -42,6 +42,9 @@
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
>  #include <linux/sort.h>
> +#ifdef CONFIG_SLUB_LEAK_PANIC
> +#include <linux/vmstat.h>
> +#endif

Please redo this to not require #ifdef in .c files, otherwise it gets
very unmaintainable over time.

thanks,

greg k-h

