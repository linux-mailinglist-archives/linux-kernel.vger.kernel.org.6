Return-Path: <linux-kernel+bounces-173267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B600C8BFDE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EB11C210F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550F76A343;
	Wed,  8 May 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VRkJfiJf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GTCzv/Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AE79DD5;
	Wed,  8 May 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173387; cv=none; b=L1mOJ4XlvEvRv03tgGY5bl8q3KNYYuHVITbU/xB4trVbTxszbsTJbCsoICMkegCAbPrAkpvTgZyryZ4j9CaCb5kBuGipKt+pwBMCaUnPh1xQ+D9+N8AAEnZFEoWPKNiLNQFlR7kIwFhL43VLmQYDCiFHc3DSMo2CYhrON7C46EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173387; c=relaxed/simple;
	bh=A5opIo9FDKeD8ue/wvAEY7f6wkl1IuKrnCZpbn1EUaE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=o5UYbs+LM8LuazimlzU9UsYfgD8aYoYQUT3unCqLlGKfphL/3agGNN91xwDNeuEHcqigrsHVCXPd8Fk+fYQoDOXI5vd0BGoMKpAqhgNdOXWr/OWSA+HemGrv5XN6hI+ogmV7hsMKyyYzu9XEIn1K57voL2frUcaY3kZbeuNx4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VRkJfiJf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GTCzv/Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715173375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9VFXYNnmWVAd3Sn8DKCZ8yiqWzSwEdQ+Pabjj2q4hB0=;
	b=VRkJfiJfWZ6AookMVOKv9e9HzbGtO1L0xsXLM+GqeVg04zUbQMgxteMJClaRvAfOdTALkg
	O9e4scpjuaBKPVzCRsySOt2lcD/606KGBScnWIFENihZmILKnD8lPngsC4/1t7lLE3EQtQ
	WqCSYCpDoVPzPxiwh7uI/C2lO0S/rW6cs0YHp0w/d1kqCl/FWExNg8YEtVfO5e6ojMBhcg
	Yh/9LNILDkGQV9e8JyAZH3hTuwDmYPp5+7K8FYP17a9Sp/Qkc5sxOc1Plgtp+ZAvkpERQa
	fj3HGUhWKvZhW6RRYmpeTusXkOdHJgvak/KrTiZacBCE3zHNRbq0UyyEQ0DxRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715173375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9VFXYNnmWVAd3Sn8DKCZ8yiqWzSwEdQ+Pabjj2q4hB0=;
	b=4GTCzv/ZQ4stwae37N//lUQMPYDxwL6kuSxLgbdpRlqjBvrmic4aq21mLw+5OMsTsGEaq/
	AXZPI3MF3nY9IhDw==
To: Vignesh Balasubramanian <vigbalas@amd.com>,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
 ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
 jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
 jhb@FreeBSD.org, felix.willgerodt@intel.com, Vignesh Balasubramanian
 <vigbalas@amd.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
In-Reply-To: <20240507095330.2674-2-vigbalas@amd.com>
Date: Wed, 08 May 2024 15:02:55 +0200
Message-ID: <87wmo4o3r4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 15:23, Vignesh Balasubramanian wrote:
> +struct xfeat_component {
> +	u32 xfeat_type;
> +	u32 xfeat_sz;
> +	u32 xfeat_off;
> +	u32 xfeat_flags;
> +} __packed;

Why repeating xfeat_ for all member names?

    u32       type;
    u32       size;
    u32       offset;
    u32       flags;

is sufficient and obvious, no?

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

Why can't this use the existing 'enum xfeature' which is providing
exactly the same information already?

> +#ifdef CONFIG_COREDUMP
> +static int get_sub_leaf(int custom_xfeat)
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
> +		return 0;
> +	}
> +}

This function then maps the identical enums one to one. The only actual
"functionality" is the default case and that's completely pointless.

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

Why does this need to re-evaluate CPUID instead of just using the
existing fpu_user_cfg.max_features?

> +	for (i = FEATURE_XSAVE_EXTENDED_START;
> +			i <= FEATURE_XSAVE_EXTENDED_END; i++) {

Please use the full 100 character line width.

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

sizeof(xc), no?

> +				return 0;
> +			num_records++;
> +		}
> +	}

This whole thing can be written as:

	for_each_extended_xfeature(i, fpu_user_cfg.max_features) {
		struct xfeat_component xc = {
                	.type	= i,
                        .size	= xstate_sizes[i],
                        .offset	= xstate_offsets[i],
		};

		if (!dump_emit(cprm, &xc, sizeof(xc)))
			return 0;
                num_records++;
	}

It omits the features which are supported by the CPU, but not enabled by
the kernel. That's perfectly fine because:

  1) the corresponding xfeature bits of those component in the actual
     XSAVE dump are guaranteed to be zero

  2) the corresponding regions in the actual XSAVE dump are zeroed

So there is absolutely no point in having notes for the not enabled
features at all.

Hmm?

> +
> +	return num_records;
> +}
> +
> +static int get_xsave_desc_size(void)
> +{
> +	int supported_features = 0;
> +	int xfeatures_count = 0;
> +	u32 eax, ebx, ecx, edx;
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
> +		if (supported_features & (1U << sub_leaf))
> +			xfeatures_count++;
> +	}
> +	return xfeatures_count * (sizeof(struct xfeat_component));

Then this can be replaced by:

	int i, cnt = 0;

	for_each_extended_xfeature(i, fpu_user_cfg.max_features)
        	cnt++;

        return cnt * sizeof(struct xfeat_component);

In fact the number of extended features can be calculated once during
boot during xstate initialization.

No?

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
> +		return 1;

This is going to trigger on all systems which do not support XSAVE. So
why emitting this note in the first place on such systems?

The function should have

	if (!fpu_kernel_cfg.max_features)
        	return 0;

right at the beginning.

Aside of that, these warnings are pointless noise in the case that
dump_emit() caused the function to return early. Dumps can be truncated.

> +/*
> + * Return the size of new note.

Which new note? This is extra notes, no?

> + */
> +int elf_coredump_extra_notes_size(void)
> +{
> +	int size = 0;

	int size;

> +
> +	/* NOTE Header */

  Note header ?

> +	size += sizeof(struct elf_note);

	size = ....

> +	/* name + align */

  Name plus alignment to 4 bytes ?

> +	size += roundup(sizeof(owner_name), 4);
> +	size += get_xsave_desc_size();
> +
> +	return size;
> +}

And like the write function this wants:

	if (!fpu_kernel_cfg.max_features)
        	return 0;

at the beginning. No point in emitting useless notes and headers.

Thanks,

        tglx

