Return-Path: <linux-kernel+bounces-173593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5438C0291
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6CB1F22D48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192F10A11;
	Wed,  8 May 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mgLcIuTE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D510953
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187936; cv=none; b=YUDn6nBO21vLqu2g9UqWnngZUPCbCndS7TlGCRc/hvzqbijj8o8S2+kyMfx3EeWzdMxg/UNxfwQXcvUjzi7Cf9o92A323AZaJ8t1FV+4+c6Fn997ddmyfX0f8Zfc85i4lV9L0lkiwA4ew4sun+BrNrDa8k5YwQo/j+ZzwTdmEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187936; c=relaxed/simple;
	bh=JvbzMcqTDU7UqThEDKgsAHD40j4VZ8mm2M0mjTdiwJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoDnKGxxzqPCeqSRvYBaqq5Jou/2dCZ/gdGQ84dprWePj/rm9b6a6hd8UMu3EQRK6KkMd5nQE/dnu5q/t2XXrmMFdHa1n3c7wdi1+cwfLHPAJ7wDAIVSHsjd+oT8fZlDyWtEwa28SvDOJugqx+vShn+QvoY7M96VIDLfciI9Cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mgLcIuTE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so134595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715187933; x=1715792733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NSwC0XUWH2/jAZekAHNFl+y4/f7gtwIOhD7wWr4LzY=;
        b=mgLcIuTEY+MnLLQOegAl4oWbJSWP7BWzG2Bl0COFSvhQ9Gjr83tBGb6lvCpVAT6ZWs
         QMVGKWhEIb0FvE/mkQ4x3HbWNtrN8gChXGZieDRAydckIMhyI5ZJ2UVyA+Xx+yc6CLpO
         XWXXdQacqfe6OkX6kt4EotYsWRSkM7NWHHZ58iT2Sn3c8bRIGFKo5v2IwiPD0YnzK00V
         Blvcb6jdgpvz73Akt6bdnaj1RlcTStxy/4FYiXj20wAJYZcb/1YY2vRvvjyWQyY4suS8
         6ZwBeYODDYwlYUnWQVho0XQsWMk1ltHkT9YMjjoM/CzXWcrYqad56/jI1acvWJVSs0Ph
         Vx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187933; x=1715792733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NSwC0XUWH2/jAZekAHNFl+y4/f7gtwIOhD7wWr4LzY=;
        b=uoQA7ENMiCdJ0fIOyMZBg70yg+tBXs4V2V5TP+QJn16zmRvsySg8HK2L/vT1HHZHzR
         lGLrZ4nTAaEmOEqrTMsKcTFUTOa/vg67ipSrtidpU90UAO5dipZCvpUv5A9g4tlhNJcc
         AXzPjFzWE5VS6aLuZe+9owyhtIVrgjIWyR7pZzDB87PmlTvYuA/VXL58zUZG/pP10Lk8
         xPugojGTivQymcE/PR17zRru1/3Kus8xCAsBOmwGaj5GIHV4qFcuYbCV7cvpKPZb4egw
         BLbwReX861WIL/cx2P8smJTSS13g9qGaXJ6RUHEDPtYiBbPiH0cVUMJVbAda3+GHm4S/
         PJXw==
X-Forwarded-Encrypted: i=1; AJvYcCXup2K2SvddZ/8xR56k6nlqdgTV8epQ19srRu1tQk60JV0CQTQmDPgbCGDv3vYmK3DujjBPgZQwlRokicizVtuZgWK9fuF/jFLuTAuL
X-Gm-Message-State: AOJu0Yx134KgC8NVlD4Dc1WVfK0Ye9wgEGLQPdeaqsq8/b7jOqUYjvwl
	KbBaW22NV8fig9vHV6xv6Alq7nf+shlLoAD/BJrnMMGjUovi5wgdS59rpIcD9gM=
X-Google-Smtp-Source: AGHT+IGgz0QEZsH36hv/uUgJ9K6WhGuMsBxbHUfds4fIdLNeyAsKU2bNpkZPr42Zsg1brC4AQL33vQ==
X-Received: by 2002:a17:902:da84:b0:1e2:a5db:30d1 with SMTP id d9443c01a7336-1eefa138b68mr3407615ad.13.1715187933343;
        Wed, 08 May 2024 10:05:33 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1d01:8836:5e9d:e040])
        by smtp.gmail.com with ESMTPSA id jx7-20020a170903138700b001e469386fddsm12124945plb.40.2024.05.08.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:05:32 -0700 (PDT)
Date: Wed, 8 May 2024 10:05:30 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
 Kconfig option
Message-ID: <Zjuw2t6vL6yIcPR9@ghost>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-3-722c21c328c6@rivosinc.com>
 <b3ff587a-61f5-4abf-b71f-7ad48ff66969@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ff587a-61f5-4abf-b71f-7ad48ff66969@codethink.co.uk>

On Wed, May 08, 2024 at 10:00:48AM +0100, Ben Dooks wrote:
> On 08/05/2024 02:36, Charlie Jenkins wrote:
> > The existing "RISCV_ISA_SVNAPOT" option is repurposed to be used to by
> > kernel code to determine if either
> > PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT or
> > PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT has been set.
> > 
> > PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT will check if the hardware
> > supports Svnapot before using it, while
> > PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT will assume that the hardware
> > supports Svnapot.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/riscv/Kconfig               | 19 -----------------
> >   arch/riscv/Kconfig.isa           | 44 ++++++++++++++++++++++++++++++++++++++++
> >   arch/riscv/include/asm/pgtable.h |  3 ++-
> >   3 files changed, 46 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c2e9eded0a7d..3c1960e8cd7c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -484,25 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
> >   	help
> >   	  Allows early patching of the kernel for special errata
> > -config RISCV_ISA_SVNAPOT
> > -	bool "Svnapot extension support for supervisor mode NAPOT pages"
> > -	depends on 64BIT && MMU
> > -	depends on RISCV_ALTERNATIVE
> > -	default y
> > -	help
> > -	  Add support for the Svnapot ISA-extension in the kernel when it
> > -	  is detected at boot.
> > -
> > -	  The Svnapot extension is used to mark contiguous PTEs as a range
> > -	  of contiguous virtual-to-physical translations for a naturally
> > -	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
> > -	  size. When HUGETLBFS is also selected this option unconditionally
> > -	  allocates some memory for each NAPOT page size supported by the kernel.
> > -	  When optimizing for low memory consumption and for platforms without
> > -	  the Svnapot extension, it may be better to say N here.
> > -
> > -	  If you don't know what to do here, say Y.
> > -
> >   config RISCV_ISA_SVPBMT
> >   	bool "Svpbmt extension support for supervisor mode page-based memory types"
> >   	depends on 64BIT && MMU
> > diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
> > index 0663c98b5b17..37585bcd763e 100644
> > --- a/arch/riscv/Kconfig.isa
> > +++ b/arch/riscv/Kconfig.isa
> > @@ -124,3 +124,47 @@ config RISCV_ISA_V_PREEMPTIVE
> >   	  This config allows kernel to run SIMD without explicitly disable
> >   	  preemption. Enabling this config will result in higher memory
> >   	  consumption due to the allocation of per-task's kernel Vector context.
> > +
> > +config RISCV_ISA_SVNAPOT
> > +	bool
> > +
> > +choice
> > +	prompt "Svnapot extension support for supervisor mode NAPOT pages"
> > +	default PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
> > +	help
> > +	  This selects the level of support for Svnapot in the Linux Kernel.
> > +
> > +	  The Svnapot extension is used to mark contiguous PTEs as a range
> > +	  of contiguous virtual-to-physical translations for a naturally
> > +	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
> > +	  size. When HUGETLBFS is also selected this option unconditionally
> > +	  allocates some memory for each NAPOT page size supported by the kernel.
> > +	  When optimizing for low memory consumption and for platforms without
> > +	  the Svnapot extension, it may be better to prohibit Svnapot.
> > +
> > +config PROHIBIT_RISCV_ISA_SVNAPOT
> > +	bool "Prohibit Svnapot extension"
> > +	help
> > +	  Regardless of if the platform supports Svnapot, prohibit the kernel
> > +	  from using Svnapot.
> > +
> > +config PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
> > +	bool "Allow Svnapot extension if supported"
> > +	depends on 64BIT && MMU
> > +	depends on RISCV_ALTERNATIVE
> > +	select RISCV_ISA_SVNAPOT
> > +	help
> > +	  Add support for the Svnapot ISA-extension in the kernel when it
> > +	  is detected at boot.
> > +
> > +config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
> > +	bool "Emit Svnapot mappings when building Linux"
> > +	depends on 64BIT && MMU
> > +	depends on NONPORTABLE
> > +	select RISCV_ISA_SVNAPOT
> > +	help
> > +	  Compile a kernel that assumes that the platform supports Svnapot.
> > +	  This option produces a kernel that will not run on systems that do
> > +	  not support Svnapot.
> > +
> > +endchoice
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 6afd6bb4882e..432be9691b78 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -289,7 +289,8 @@ static inline pte_t pud_pte(pud_t pud)
> >   static __always_inline bool has_svnapot(void)
> >   {
> > -	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
> > +	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT) ||
> > +	       riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
> 
> could you add the IS_ENABLED(*) check into riscv_has_extension_likely
> and other such functions?

I wasn't sure how to support that. An option I was debating about this
was fixing up riscv_has_extension_likely() so that it's a macro and
SVNAPOT could be expanded to both
CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT and RISCV_ISA_EXT_SVNAPOT.

- Charlie

> 
> 
> -- 
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius
> 
> https://www.codethink.co.uk/privacy.html
> 

