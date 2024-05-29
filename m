Return-Path: <linux-kernel+bounces-194740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076968D4142
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02EB287D91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524D0169AC6;
	Wed, 29 May 2024 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB0AZcrH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE015B11E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021202; cv=none; b=YBGRDzlnldj3ydGCNY059cHgsoZELr8qPVBJp1Vjxm0oCJTqKDjUrlmO/i2H3mjvTsOe+fgf/J9ZKKm9M7Mj9u2gqamG8ftlhXb3kbh007QymigSys4HSaIjYlbsxnF7uPOV3lKcQ9JLykBKiRRsFC1zax5eEvwF+IWiwUoGqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021202; c=relaxed/simple;
	bh=z0AOYGNnmldkQeJjZHn0aBihDYdO8aNU08quKCIAuWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqLUYezzLLn1FYZgSaWqUO3Jvz/FfK8OHam4mIBjET5m1A8+lqNqQJLQ2CyuZfOofcKE16dV8EVFkwaY98pV1HgSomBs+wyGPlaMwtnggUW7OpsRdj3/bbCqauHYf0hfMm5R4eIfUQOUrxa7kxr2Rz+rJjHmLElW5AcYpPEwyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB0AZcrH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47db642c2so2158485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717021200; x=1717626000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJrQ16Mm4mEHJBUvo1EcXZ5YtU50XKHhoA+vzh0jLKc=;
        b=RB0AZcrHBbyGHKMCC/0cU4UiXyJVmbMRaEesgFVBRlGduRNWsdOJIRfSf2oS1WZs31
         HH+u0wipQkUIOUl/Q+f6y37RLOSqz+CNS4sgXqlHTqgSWqhgCT9reEOUZNIH2Ao3zOC5
         bD2wdOA2X+Uvp57mJQ/MmmvoIgoFYAzJm9YqQEbyOPDj/dIZ3+MY424r+UZl7l70ACpI
         JQq9lydPws11oulQE3UH8XJRy4tpyDrzvWHlibsoGcdoqkakJRBrF9FKSGI8JjQ1lnEK
         ffdDJUICCha/klX8+1tB6acs+x1R8lZdM1T7R9mbndC8ERB9aFglmaD6Gzsl1vKOmRW/
         b1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021200; x=1717626000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJrQ16Mm4mEHJBUvo1EcXZ5YtU50XKHhoA+vzh0jLKc=;
        b=JvrcpOQX7eWx6BL98mWWh0qd+7lhwSuJLbouUtWv0Tb+GFaXNnvRiRFX2rGM5etHO3
         stCbDM5lpXRxQgGLfaIIt0k0vH1MezNXLucCwgDlQ8VsEytNza9arqLfXVbn4aclXwPo
         xkgvD6puj2xKFP0eSlDv7tNc+JX2KJrRXR2OC+nA25MIMVFdSBeWYoR82u02JsElZL6t
         tm5t64vqFycXua8Lrkyy0OVW41VXRWF2YXJyTdA/fNuk+MPvoHvhDd1iNxuHxqGODaU/
         FARC++s7lhP0d5jsXLSW7CPpT6yVSmE9WMXxQgE4at6I2xWdGtcy06gRjt4isoRK5igs
         +k5w==
X-Forwarded-Encrypted: i=1; AJvYcCWG1WkQmECHGdIYe9h3+JbOFUjgxszJUz7cxD4kukZT1CqaGaTFJ4CL8x9dQQke9cPT/VWVBxwRSEjUX+ZQTg/lgcIjByS8n7Hkrf/3
X-Gm-Message-State: AOJu0YxYBVTs6v5z2aNK+/xvTScbaQZGU4HtBaA8QQG0YqvL0ogvf2cf
	2Bk3/H/1l3wXGhcwiH0SzwC0RtMGCNKuVQZkNFjG4WRcwO+zhu/yRwTsMg==
X-Google-Smtp-Source: AGHT+IG5kR8kOYyzVRzRqbZxqWuOKj6SQweoCw18V8qyrX/WdpuKPWyVew4BiSOzbkoQNpLbeJYeng==
X-Received: by 2002:a17:902:ecd1:b0:1e6:7700:1698 with SMTP id d9443c01a7336-1f619624c66mr4414635ad.35.1717021199966;
        Wed, 29 May 2024 15:19:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f476f665b0sm79991985ad.250.2024.05.29.15.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:19:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:19:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64
Message-ID: <109b63cc-1dcd-4f40-881b-0fe88ed9ac9c@roeck-us.net>
References: <20240529162852.1209-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529162852.1209-1-samuel.holland@sifive.com>

On Wed, May 29, 2024 at 09:28:50AM -0700, Samuel Holland wrote:
> When building a 32-bit kernel, some toolchains do not allow mixing soft
> float and hard float object files:
> 
>     LD      vmlinux.o
>   powerpc64le-unknown-linux-musl-ld: lib/test_fpu_impl.o uses hard float, arch/powerpc/kernel/udbg.o uses soft float
>   powerpc64le-unknown-linux-musl-ld: failed to merge target specific data of file lib/test_fpu_impl.o
>   make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1
>   make[1]: *** [Makefile:1152: vmlinux_o] Error 2
>   make: *** [Makefile:240: __sub-make] Error 2
> 
> This is not an issue when building a 64-bit kernel. To unbreak the
> build, limit ARCH_HAS_KERNEL_FPU_SUPPORT to 64-bit kernels. This is okay
> because the only real user of this option, amdgpu, was previously
> limited to PPC64 anyway; see commit a28e4b672f04 ("drm/amd/display: use
> ARCH_HAS_KERNEL_FPU_SUPPORT").
> 
> Fixes: 01db473e1aa3 ("powerpc: implement ARCH_HAS_KERNEL_FPU_SUPPORT")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405250851.Z4daYSWG-lkp@intel.com/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net/
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3c968f2f4ac4..c88c6d46a5bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -137,7 +137,7 @@ config PPC
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
>  	select ARCH_HAS_KCOV
> -	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC_FPU
> +	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC64 && PPC_FPU
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
> -- 
> 2.44.1
> 

