Return-Path: <linux-kernel+bounces-417164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF59D4FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A6F1F2321B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329B1547DC;
	Thu, 21 Nov 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUIsUuOT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070541C79
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203235; cv=none; b=d6NUuL0lcrA7hQjJBMjpGpwFa5agmwbS0UYdWVz1eEcF5+m+Kr0JfsyDirppY5bFA+sqz3bqtCUQG68eZWCAPnc7n/x7eG3nL5fvpq80zVuQcVaUASMsp5vOlLsBORTRJf3LFtXJEHpvk4NZmjb1LLo+nUruPCFK80B2+NuFOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203235; c=relaxed/simple;
	bh=2wYis2CcVS+AEm1sKOYpMzoJcS/Y7dYAcB3rmtlsOFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gt+aZigU9+K/JfGSdK5c1vJFTOLEDLI0troUBEt5G4EY4jAv3W9VCVnEaDnIXoUiu9VYFKov9x3UGffGJEw8BapgEldywPsbNIK/WvCOoUaBH7mRzS4sEjGspLNPCONJFl+Cx9qpEcUFImjAnELHdyHYzyUq5flP8WDptirhv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUIsUuOT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so1874013276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203233; x=1732808033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEFzF2xxQ+qEwiOOhab/3lZ/XHVMqHcWPe4CNNiZQKs=;
        b=BUIsUuOTYXViENX+sr65eeWWsU6PyXyolzd8GHx2dcWD8Ur2lvTqEL1/VMs2wcmTlT
         pnADXfISypE8fpoFXhg0+ywiKbMpRjRGh9RsxIfcztNu+ANIMrlaE7LYwWffPYqNWJXu
         gv4JsNHxy+DwSu5gGudbXUVRtfx0vSebKUgHlDRy0WHWUOshlnT7XeCv/+cADIXM3axF
         8NPQeVH5DZLHOJYUvgNxE9aavVKTYW0+hj2IpSRpJdpFAMoKfsKMczVUJG0jQrCLzvpp
         hfFkTKn/jNhOGQJvhjovcnk9M8WSr2V8ARLInI6yG9eRQphT3yNhC1LcBnwp6EE37paJ
         J/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203233; x=1732808033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEFzF2xxQ+qEwiOOhab/3lZ/XHVMqHcWPe4CNNiZQKs=;
        b=Kl5zF27fphekiiJ9HOCU8EPa8b24DUhS6C4jun7WGk/eaRJJjv3TPbu69HzSuvzZR/
         3qMDkpCTmBmv/vNg1zIWpD7mtrLgVHtrybls+Ts0ko4b6IJfpfyPbX270xfaurpKeg08
         oyJDaj/r+4FYuspWU6Q+jZPaIJnWeV2oI+X8ivKIwfH0QVlqltLn9BECfby+Rqa8G+qK
         JLlXPXDwswuKsTLVXlnzsvV/t5MBWD2Pa460J8iCLGR3titdnHeEODKvrKgzLUx5mxb5
         EncXCAF2ceD5XkB2OcAbvhWrE5+EsVoVRBwTsKB2w+zKqCwUsqTUljMnXDDJgWdo8534
         zuSA==
X-Gm-Message-State: AOJu0Yx3oW7o7w4yF+FB4TnSRdHxkTbqUegFstYNm2kJC+f8bXM81frb
	6Rwq2ue8jfsK+3qdYVjXMs/W7iUpziAcCEvAYkff35W+iHtheH7RrGNueFnRK5vhxz2s/zx8v0l
	4aA==
X-Google-Smtp-Source: AGHT+IEOQakgtbziExv8TTrXV78ZqZCv68evwQ2ecJe2ogMIhs7z4oXH3t4MAp/OyAc+KJVf5fopVWawPWc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:dc08:0:b0:e38:b2cf:4958 with SMTP id
 3f1490d57ef6-e38cb58b2d4mr2926276.3.1732203232767; Thu, 21 Nov 2024 07:33:52
 -0800 (PST)
Date: Thu, 21 Nov 2024 07:33:51 -0800
In-Reply-To: <20241120195332.929A7C44@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com> <20241120195332.929A7C44@davehans-spike.ostc.intel.com>
Message-ID: <Zz9S352550TZSKBQ@google.com>
Subject: Re: [PATCH 04/11] x86/acpi: Check MWAIT feature instead of CPUID level
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org, dave.jiang@intel.com, 
	irenic.rajneesh@gmail.com, david.e.box@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 20, 2024, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I think this code is possibly buggy.  The CPU could have a high
> c->cpuid_level and not support MWAIT at all.

Reading CPUID.0x5 is totally fine in that case though.  Wasteful and pointless,
but functionally ok.  If the CPU provides non-zero values when MWAIT is unsupported,
then that's a broken CPU.

> It is much more clear to
> just check for MWAIT support directly.  Also, because of the CPU level
> dependency code, any CPU that has X86_FEATURE_MWAIT also has a
> high-enough CPUID level.

No?  The MWAIT feature flag is in leaf 1.  1 < 5, and I don't see any cpuid_level
magic that would force it beyond '5'.

Why not check both?

> Check X86_FEATURE_MWAIT instead of the CPUID level.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/kernel/acpi/cstate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3 arch/x86/kernel/acpi/cstate.c
> --- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3	2024-11-20 11:44:17.225650902 -0800
> +++ b/arch/x86/kernel/acpi/cstate.c	2024-11-20 11:44:17.225650902 -0800
> @@ -173,7 +173,7 @@ int acpi_processor_ffh_cstate_probe(unsi
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	long retval;
>  
> -	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF)
> +	if (!cpu_cstate_entry || cpu_has(c, X86_FEATURE_MWAIT))

Someone didn't test this :-)

>  		return -1;
>  
>  	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
> _

