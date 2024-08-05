Return-Path: <linux-kernel+bounces-275355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498919483D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848921C21FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCE16B388;
	Mon,  5 Aug 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Auhdec/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEF143C4B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891908; cv=none; b=U7QtlXskWDPt0WnVIuKSadj0zuhSvLNnAStAKeXZocvJCZZl7ia5grMK86r5UgrsGN/pqg6or78VEbWuMLBHvOzIvUaJjPJUSVeUNQw4hoZTyd2cq9/PvsTN57Zww9KrUy9Ymz5Ckk1WcYJqlvxKNSE2/Mb6jHVJs794b9Dk1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891908; c=relaxed/simple;
	bh=hNEorLFNFU6XziMXB83XWj4mCvVyNc1nseFYZY1J8Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p69FAxPxpfD6DxzmlUBpvyfmg2t+OzrDOfhIjEW3PmmYFd0WIXVzZs86h0QEhzcYXWSqTcz3FB/hPUsgs7mIEiN1BZT+5YHsZZd34BP8GGbDfOYjnpX7qq9uTGWSvABD/vB8gjlmRJaKI5bMO90m+8NsLmcZMkLzM/Szhp0oHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Auhdec/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A383C4AF0E;
	Mon,  5 Aug 2024 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722891907;
	bh=hNEorLFNFU6XziMXB83XWj4mCvVyNc1nseFYZY1J8Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Auhdec/wyq7LGcHWI7/O+VlKCfOppR2w2Z9hc+ucl5PqwwqUaUSNi7PLygqIXCQ1u
	 2P+VPexYHtAa1nq3Zkau7gf2aGnvk4x8HcKAaUUHeckM7UjLs0oFfcYITYaArVniLd
	 RgoJ7jaXWTtejKbmGVdUuXlmjY8EGpA2ceV1illlFx7F1a8KWrXqMovJgmCfwFmzpd
	 gRIKPtJWMdAR33X4pZaPfTJvg2WHSym7hMf18RSDEfGpT56JNa9f8nrBpryXVhAQ+E
	 xKIQgtqW5iZs8zDWw/YEUDCWp0A47MNMrcDnly0kIUy9RvgIurISzrR4m7nI8cdCQY
	 HZBx30DXnxAJA==
Date: Mon, 5 Aug 2024 14:05:06 -0700
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	adhemerval.zanella@linaro.org, ojeda@kernel.org,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org
Subject: Re: [RFC PATCH v1 1/1] binfmt_elf: mseal address zero
Message-ID: <202408051402.9C0FA18A12@keescook>
References: <20240801170838.356177-1-jeffxu@google.com>
 <20240801170838.356177-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801170838.356177-2-jeffxu@google.com>

On Thu, Aug 01, 2024 at 05:08:33PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Some legacy SVr4 apps might depend on page on address zero
> to be readable, however I can't find a reason that the page
> ever becomes writeable, so seal it.
> 
> If there is a compain, we can make this configurable.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  fs/binfmt_elf.c    | 4 ++++
>  include/linux/mm.h | 4 ++++
>  mm/mseal.c         | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 19fa49cd9907..e4d35d6f5d65 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1314,6 +1314,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		   emulate the SVr4 behavior. Sigh. */
>  		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>  				MAP_FIXED | MAP_PRIVATE, 0);
> +
> +#ifdef CONFIG_64BIT
> +		do_mseal(0, PAGE_SIZE, 0);
> +#endif

Instead of wrapping this in #ifdefs, does it make more sense to adjust
the mm.h declaration instead, like this below...

>  	}
>  
>  	regs = current_pt_regs();
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c4b238a20b76..b5fed60ddcd9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4201,4 +4201,8 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
>  
>  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
>  
> +#ifdef CONFIG_64BIT
> +int do_mseal(unsigned long start, size_t len_in, unsigned long flags);

#else
static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
{
	return -ENOTSUPP;
}

> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/mseal.c b/mm/mseal.c
> index bf783bba8ed0..7a40a84569c8 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -248,7 +248,7 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
>   *
>   *  unseal() is not supported.
>   */
> -static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> +int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>  {
>  	size_t len;
>  	int ret = 0;
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

And if it returns an error code, should we check it when used in
load_elf_binary()? (And if so, should the mm.h return 0 for non-64bit?)

-- 
Kees Cook

