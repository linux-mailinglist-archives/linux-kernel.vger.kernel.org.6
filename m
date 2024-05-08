Return-Path: <linux-kernel+bounces-172877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C88BF7F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D2E28609A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1503EA9C;
	Wed,  8 May 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gptV/mWD"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C03D96D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155477; cv=none; b=Ayhs6cJk1NUARLD6tmzZSQK+dybtxGEQtO+4fYjodXjDjMm1GQTMhGk1e4upb4xQQXjV5yNhmrnKB+8/x2ZLkC9TG74TEDGww7A0EL+7Fa/nwm/WHj7dTZ17vu2q7ZRs8KFd+UDrbMG6xv8UcSYGuMufnQFhamnBSw1hyXbdJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155477; c=relaxed/simple;
	bh=HlL1SQzg7ruG3GbnT2244vswJjDne2MZ8l7gpQueiCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0XFsK9wvpIt1MS8fSR7pf55c9wTggGPcefQswk2VqozZ1VLj0TtWkzhdvDFFvHlY4dLMEYLLLl5/O85JPoHN/eNnD444utneE9EMXPQFqtez4r2JtM3zimiuT2uwIOKhtQruVRklJwv3U/j3ZxEZ3xThE0ruHKla0W5uMapJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gptV/mWD; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9691460b9so1657942b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715155475; x=1715760275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6EJLX/g+mtUojj2Iv/MkNkp9Pc492RGZqRm8bYlqdU=;
        b=gptV/mWDDjUC3SYB1hh8ljmbAQk32G3noU7e5tRkG2H6EcJy1F8L7wa057i812KrSk
         cMA5FjT6WExAiBI3dw+vSETVoYzr1UBN05zky5jqbdeSDEfHhC8lanUBXabD7zqxL7Mm
         MfpGzaG8KsGvzSSk4h9z8GrP/5qcWOkLjsHfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715155475; x=1715760275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6EJLX/g+mtUojj2Iv/MkNkp9Pc492RGZqRm8bYlqdU=;
        b=bz01tTfab/Spnw+B4mZq5sgXQ+1dTLxCwhQLxF28pGj3VWFhz2xBICOROG43c8j0/J
         FV402oD5Ipj2nqfZDSb/3uZNLsLJ5qOIkeIFk8cqCTEic4tHpQ2xFL6EuaOScrOeEDEz
         2Q12xiUnmkVwDcxiahIVIbBEnrEr6gdVEmRYjpJxw5O75lee6LAe1b8s/6lmjIs5s54/
         BjzlOc2Zoo6MpXmbQwa1TxcDas4GjucGdc49xRDcv1k03pLWDLpUtg0J56RvrSp0vbg8
         y0XVJ92su2AnFekow5b8l2UdpYYoGNCfTyNeFNBRvmqI0qYkJDVlivwQT3vkSlrCQ1wv
         IMzg==
X-Gm-Message-State: AOJu0Yw+aPzJTAfUllaMeOk5NcEyMmQ6ZpS1Ktl199oFGrwWDfqOxm9h
	eKPxHgVEWIYPZ7lpOS+aklMLEsazP1fQT/r0oG0Uv7vhna5tvx9jI+6QjKfmYg==
X-Google-Smtp-Source: AGHT+IFUmdDASdFHNuEcG9nOH4SDdUFpg4trPBVbjPrOf0+LaQdNF0jK/JNzlvznjX7HLZafo1ThYg==
X-Received: by 2002:a05:6808:7c9:b0:3c9:6d23:fdd7 with SMTP id 5614622812f47-3c9852b7240mr2014216b6e.24.1715155474512;
        Wed, 08 May 2024 01:04:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a056a00008600b006e6fc52ecd0sm9580410pfj.123.2024.05.08.01.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:04:33 -0700 (PDT)
Date: Wed, 8 May 2024 01:04:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Vignesh Balasubramanian <vigbalas@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <202405080052.21E569F@keescook>
References: <20240507095330.2674-1-vigbalas@amd.com>
 <20240507095330.2674-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507095330.2674-2-vigbalas@amd.com>

On Tue, May 07, 2024 at 03:23:31PM +0530, Vignesh Balasubramanian wrote:
> Add a new .note section containing type, size, offset and flags of
> every xfeature that is present.
> 
> This information will be used by the debuggers to understand the XSAVE
> layout of the machine where the core file is dumped, and to read XSAVE
> registers, especially during cross-platform debugging.
> 
> Some background:
> 
> The XSAVE layouts of modern AMD and Intel CPUs differ, especially since
> Memory Protection Keys and the AVX-512 features have been inculcated into
> the AMD CPUs.
> This is since AMD never adopted (and hence never left room in the XSAVE
> layout for) the Intel MPX feature. Tools like GDB had assumed a fixed XSAVE
> layout matching that of Intel (based on the XCR0 mask).
> Hence, the core dumps from AMD CPUs didn't match the known size for the
> XCR0 mask. This resulted in GDB and other tools not being able to access
> the values of the AVX-512 and PKRU registers on AMD CPUs.
> To solve this, an interim solution has been accepted into GDB, and is
> already a part of GDB 14, thanks to these series of patches
> [ https://sourceware.org/pipermail/gdb-patches/2023-March/198081.html ].
> But this patch series depends on heuristics based on the total XSAVE
> register set size and the XCR0 mask to infer the layouts of the various
> register blocks for core dumps, and hence, is not a foolproof mechanism to
> determine the layout of the XSAVE area.
> 
> Hence this new core dump note has been proposed as a more sturdy mechanism
> to allow GDB/LLDB and other relevant tools to determine the layout of the
> XSAVE area of the machine where the corefile was dumped.
> The new core dump note (which is being proposed as a per-process .note
> section), NT_X86_XSAVE_LAYOUT (0x205) contains an array of structures.
> Each structure describes an individual extended feature containing offset,
> size and flags (that is obtained through CPUID instruction) in a format
> roughly matching the follow C structure:
> 
> struct xfeat_component {
>        u32 xfeat_type;
>        u32 xfeat_sz;
>        u32 xfeat_off;
>        u32 xfeat_flags;
> };
> 
> Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
> ---
> v1->v2: Removed kernel internal defn dependency, code improvements
> 
>  arch/x86/Kconfig             |   1 +
>  arch/x86/include/asm/elf.h   |  34 +++++++++
>  arch/x86/kernel/fpu/xstate.c | 141 +++++++++++++++++++++++++++++++++++
>  fs/binfmt_elf.c              |   4 +-
>  include/uapi/linux/elf.h     |   1 +
>  5 files changed, 179 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 928820e61cb5..cc67daab3396 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -105,6 +105,7 @@ config X86
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_HAS_ZONE_DMA_SET if EXPERT
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> +	select ARCH_HAVE_EXTRA_ELF_NOTES
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 1fb83d47711f..5952574db64b 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -13,6 +13,40 @@
>  #include <asm/auxvec.h>
>  #include <asm/fsgsbase.h>
>  
> +struct xfeat_component {
> +	u32 xfeat_type;
> +	u32 xfeat_sz;
> +	u32 xfeat_off;
> +	u32 xfeat_flags;
> +} __packed;
> +
> +_Static_assert(sizeof(struct xfeat_component)%4 == 0, "xfeat_component is not aligned");
> +
> +enum custom_feature {
> +	FEATURE_XSAVE_FP = 0,
> +	FEATURE_XSAVE_SSE = 1,
> +	FEATURE_XSAVE_YMM = 2,
> +	FEATURE_XSAVE_BNDREGS = 3,
> +	FEATURE_XSAVE_BNDCSR = 4,
> +	FEATURE_XSAVE_OPMASK = 5,
> +	FEATURE_XSAVE_ZMM_Hi256 = 6,
> +	FEATURE_XSAVE_Hi16_ZMM = 7,
> +	FEATURE_XSAVE_PT = 8,
> +	FEATURE_XSAVE_PKRU = 9,
> +	FEATURE_XSAVE_PASID = 10,
> +	FEATURE_XSAVE_CET_USER = 11,
> +	FEATURE_XSAVE_CET_SHADOW_STACK = 12,
> +	FEATURE_XSAVE_HDC = 13,
> +	FEATURE_XSAVE_UINTR = 14,
> +	FEATURE_XSAVE_LBR = 15,
> +	FEATURE_XSAVE_HWP = 16,
> +	FEATURE_XSAVE_XTILE_CFG = 17,
> +	FEATURE_XSAVE_XTILE_DATA = 18,
> +	FEATURE_MAX,
> +	FEATURE_XSAVE_EXTENDED_START = FEATURE_XSAVE_YMM,
> +	FEATURE_XSAVE_EXTENDED_END = FEATURE_XSAVE_XTILE_DATA,
> +};
> +
>  typedef unsigned long elf_greg_t;
>  
>  #define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 33a214b1a4ce..3d1c3c96e34d 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -13,6 +13,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
>  #include <linux/vmalloc.h>
> +#include <linux/coredump.h>
>  
>  #include <asm/fpu/api.h>
>  #include <asm/fpu/regset.h>
> @@ -87,6 +88,8 @@ static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
>  #define XSTATE_FLAG_SUPERVISOR	BIT(0)
>  #define XSTATE_FLAG_ALIGNED64	BIT(1)
>  
> +static const char owner_name[] = "LINUX";

This needs to move under the CONFIG_COREDUMP below (so says the build
bots).

> +
>  /*
>   * Return whether the system supports a given xfeature.
>   *
> @@ -1837,3 +1840,141 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>  	return 0;
>  }
>  #endif /* CONFIG_PROC_PID_ARCH_STATUS */
> +
> +#ifdef CONFIG_COREDUMP
> +static int get_sub_leaf(int custom_xfeat)

Why is this "int"? I don't imagine there are negative features?

> +{
> +	switch (custom_xfeat) {
> +	case FEATURE_XSAVE_YMM:			return XFEATURE_YMM;
> +	case FEATURE_XSAVE_BNDREGS:		return XFEATURE_BNDREGS;
> +	case FEATURE_XSAVE_BNDCSR:		return XFEATURE_BNDCSR;
> +	case FEATURE_XSAVE_OPMASK:		return XFEATURE_OPMASK;
> +	case FEATURE_XSAVE_ZMM_Hi256:		return XFEATURE_ZMM_Hi256;
> +	case FEATURE_XSAVE_Hi16_ZMM:		return XFEATURE_Hi16_ZMM;
> +	case FEATURE_XSAVE_PT:			return XFEATURE_PT_UNIMPLEMENTED_SO_FAR;
> +	case FEATURE_XSAVE_PKRU:		return XFEATURE_PKRU;
> +	case FEATURE_XSAVE_PASID:		return XFEATURE_PASID;
> +	case FEATURE_XSAVE_CET_USER:		return XFEATURE_CET_USER;
> +	case FEATURE_XSAVE_CET_SHADOW_STACK:	return XFEATURE_CET_KERNEL_UNUSED;
> +	case FEATURE_XSAVE_HDC:			return XFEATURE_RSRVD_COMP_13;
> +	case FEATURE_XSAVE_UINTR:		return XFEATURE_RSRVD_COMP_14;
> +	case FEATURE_XSAVE_LBR:			return XFEATURE_LBR;
> +	case FEATURE_XSAVE_HWP:			return XFEATURE_RSRVD_COMP_16;
> +	case FEATURE_XSAVE_XTILE_CFG:		return XFEATURE_XTILE_CFG;
> +	case FEATURE_XSAVE_XTILE_DATA:		return XFEATURE_XTILE_DATA;
> +	default:
> +		pr_warn_ratelimited("Not a valid XSAVE Feature.");

This isn't very friendly; it's keeping secrets about the unknown value. :)
Also it's missing a newline. How about:

		pr_warn_ratelimited("Not a known XSAVE Feature: %u\n",
				    custom_xfeat);

> +		return 0;
> +	}
> +}
> +
> +/*
> + * Dump type, size, offset and flag values for every xfeature that is present.
> + */
> +static int dump_xsave_layout_desc(struct coredump_params *cprm)
> +{
> +	u32 supported_features = 0;
> +	struct xfeat_component xc;
> +	u32 eax, ebx, ecx, edx;
> +	int num_records = 0;
> +	int sub_leaf = 0;
> +	int i;
> +
> +	/* Find supported extended features */
> +	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> +	supported_features = eax;
> +
> +	for (i = FEATURE_XSAVE_EXTENDED_START;
> +			i <= FEATURE_XSAVE_EXTENDED_END; i++) {
> +		sub_leaf = get_sub_leaf(i);
> +		if (!sub_leaf)
> +			continue;
> +		if (supported_features & (1U << sub_leaf)) {
> +			cpuid_count(XSTATE_CPUID, sub_leaf, &eax, &ebx, &ecx, &edx);
> +			xc.xfeat_type = i;
> +			xc.xfeat_sz = eax;
> +			xc.xfeat_off = ebx;
> +			/* Reserved for future use */
> +			xc.xfeat_flags = 0;
> +
> +			if (!dump_emit(cprm, &xc,
> +				       sizeof(struct xfeat_component)))
> +				return 0;
> +			num_records++;
> +		}
> +	}
> +
> +	return num_records;
> +}
> +
> +static int get_xsave_desc_size(void)

This can return u32: never negative.

> +{
> +	int supported_features = 0;
> +	int xfeatures_count = 0;
> +	u32 eax, ebx, ecx, edx;
> +	int sub_leaf = 0;
> +	int i;

"i" can be u32 and then we can fix the get_sub_leaf() arg type.

> +
> +	/* Find supported extended features */
> +	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> +	supported_features = eax;
> +
> +	for (i = FEATURE_XSAVE_EXTENDED_START;
> +			i <= FEATURE_XSAVE_EXTENDED_END; i++) {
> +		sub_leaf = get_sub_leaf(i);
> +		if (!sub_leaf)
> +			continue;
> +		if (supported_features & (1U << sub_leaf))
> +			xfeatures_count++;
> +	}
> +
> +	return xfeatures_count * (sizeof(struct xfeat_component));
> +}
> +
> +int elf_coredump_extra_notes_write(struct coredump_params *cprm)
> +{
> +	int num_records = 0;
> +	struct elf_note en;
> +
> +	en.n_namesz = sizeof(owner_name);
> +	en.n_descsz = get_xsave_desc_size();
> +	en.n_type = NT_X86_XSAVE_LAYOUT;
> +
> +	if (!dump_emit(cprm, &en, sizeof(en)))
> +		return 1;
> +	if (!dump_emit(cprm, owner_name, en.n_namesz))
> +		return 1;
> +	if (!dump_align(cprm, 4))
> +		return 1;
> +
> +	num_records = dump_xsave_layout_desc(cprm);
> +	if (!num_records) {
> +		pr_warn_ratelimited("Error adding XSTATE layout ELF note. XSTATE buffer in the core file will be unparseable.");

Missing trailing newline.

> +		return 1;
> +	}
> +
> +	/* Total size should be equal to the number of records */
> +	if ((sizeof(struct xfeat_component) * num_records) != en.n_descsz) {
> +		pr_warn_ratelimited("Error adding XSTATE layout ELF note. The size of the .note section does not match with the total size of the records.");

Same.

> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Return the size of new note.
> + */
> +int elf_coredump_extra_notes_size(void)
> +{
> +	int size = 0;
> +
> +	/* NOTE Header */
> +	size += sizeof(struct elf_note);
> +	/* name + align */
> +	size += roundup(sizeof(owner_name), 4);
> +	size += get_xsave_desc_size();
> +
> +	return size;
> +}
> +#endif

Since it's a long if/endif, add: /* CONFIG_COREDUMP */ after the endif
here.

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..833bcb7e957b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2000,7 +2000,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	{
>  		size_t sz = info.size;
>  
> -		/* For cell spufs */
> +		/* For cell spufs and x86 xstate */
>  		sz += elf_coredump_extra_notes_size();
>  
>  		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
> @@ -2064,7 +2064,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	if (!write_note_info(&info, cprm))
>  		goto end_coredump;
>  
> -	/* For cell spufs */
> +	/* For cell spufs and x86 xstate */
>  	if (elf_coredump_extra_notes_write(cprm))
>  		goto end_coredump;
>  
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b54b313bcf07..e30a9b47dc87 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -411,6 +411,7 @@ typedef struct elf64_shdr {
>  #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
>  /* Old binutils treats 0x203 as a CET state */
>  #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
> +#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
>  #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
>  #define NT_S390_TIMER	0x301		/* s390 timer register */
>  #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
> -- 
> 2.34.1
> 

Otherwise looks good. I'd like to see feedback from Intel folks too.

Thanks for working on this!

-Kees

-- 
Kees Cook

