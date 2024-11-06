Return-Path: <linux-kernel+bounces-398421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28A9BF113
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F47B21E14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB31E0480;
	Wed,  6 Nov 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aq2Q79fz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01339537FF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905398; cv=none; b=I8Y2amrXo1/0MNo58IRK0OGvur0ZFr5FjfXfWoNFa5clRDIdDm3q+f5k/9WrvDF6rDdTY+Wd2Brt4acrX1HniQb/2S9OHgbm+vSD2Bz9BTp7YbYefPE1lrR03kEW2gxssz7Bx/TpuJ3E2PJJx0LNduCbixt2DmggfgZe6G2bljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905398; c=relaxed/simple;
	bh=7mskR3JbIFxLTES60DnCyg1iGln2tKO42FQ/t4vQnxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RP8EhZFIFup4tS4aPE/3TvCbTU5DSAZxZegG2mxXompUPVjheB9cV1y8siqjBPsQ2F9oEne1cMFqXRUjGlUa6j5P2APl1so2XQBRmeRRF6YF+c/IrCA+9KI9vmn1sx7wozfEJJ+Hrx5v/Z0m2UFdAf4GzivzkzUR4c7RLFcWudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aq2Q79fz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20e5ab8e022so73109395ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730905396; x=1731510196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hflnxKg+bZsrisTzBdaOMATh7WIEr10IKb+rd9v6h2M=;
        b=Aq2Q79fzuU8Hj1Gmn9pktO3+P5oP7LSDZ98M6vp2KakSRzvZqr1MUouHmOifY4vDUI
         wWgwusH4QsfaK6w0R5YBbg2zX5Ol8PJghnXYNOmbNk+cjIItCPGdFR4yjA7gRFsQNIRo
         1JOL/6ZcWVDobVbPFjK1r7QTIg6PPVe/Mv8wCXgjZ9IrrIiFCCyuh8EH8SkNOpJ9btm7
         4v6ninN4yqjSVgzwczi717U2TNoBVnnHm5ntuILpusWLwx/2rf5h5spivUEAi0l3Szr4
         JDIA7rGlt5/3LxA5Ni1bApFe8lc/pTBejII1SPuOZN3+A6xD46kxM9ng5wbor/C1eryw
         T2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905396; x=1731510196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hflnxKg+bZsrisTzBdaOMATh7WIEr10IKb+rd9v6h2M=;
        b=tQHIOD3owiPQHHOSFBkwu+Cpg7GoDzzm+SOLar7+uMS2L9tgTKXMUDAkxowgemolwX
         04QFJZ/w3ciZvN5UMf7xgM0Yw9jSTa/QS/8M3RJy6l1Rk1YSSTxv7Ua5iOt297/pdqqV
         VFqrfwCxYAW8zVxC9aebys0/nr1n2dch/rgJywZbKw5zV44jQHEMN3/VrXCbIJ3pAq4a
         l2sR60JFUwHFbQq+HBjHzltYOGvi6YHcfAvKt7XelbPs+wQaLFANxZ2pdDnLY7bYA6A0
         s8kSwUQ1MuamuHLMQG6oW6qot8Eg9XFi/xbTz/rYrnzd+ahPzzfjoECf7L+zWpo2NtK4
         FWVg==
X-Forwarded-Encrypted: i=1; AJvYcCV6yFI2xK1L/iAQjwjFwKsHLU3r5Fj0xp+X4Di+AOk5GM3SwiFNBn6WgZIIvVydYTlA8lslVf5AAEqb/18=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMZMPNAqs1EAkpFCY/Y+tu/N4BRmtgMGO9dMBxtIm0rXlwWqP
	neIZGJF4CaRpf4s7aN7wy6bVuGJTL5nr0UVoBRkzrM5i/yyp/1d0W0IWV90GtmMZ16eoFwf4S/r
	L8w==
X-Google-Smtp-Source: AGHT+IHwIFs1+hd+w3m+efJcHtnNN4sJzJdSBWQ+cawiDwh+0SfyGDAKfXLwD0PDPV12ch/2yvmAAQbZ0Jw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e810:b0:20e:5792:32ee with SMTP id
 d9443c01a7336-210c6d4e614mr6082805ad.10.1730905396372; Wed, 06 Nov 2024
 07:03:16 -0800 (PST)
Date: Wed, 6 Nov 2024 07:03:14 -0800
In-Reply-To: <20241105160234.1300702-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105160234.1300702-1-superm1@kernel.org>
Message-ID: <ZyuFMtYSneOFrsvs@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client
From: Sean Christopherson <seanjc@google.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+KVM, given that this quite obviously affects KVM...

On Tue, Nov 05, 2024, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A number of Zen4 client SoCs advertise the ability to use virtualized
> VMLOAD/VMSAVE, but using these instructions is reported to be a cause
> of a random host reboot.
> 
> These instructions aren't intended to be advertised on Zen4 client
> so clear the capability.
> 
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219009
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 015971adadfc7..ecd42c2b3242e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -924,6 +924,17 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
>  {
>  	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
>  		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
> +
> +	/*
> +	 * These Zen4 SoCs advertise support for virtualized VMLOAD/VMSAVE
> +	 * in some BIOS versions but they can lead to random host reboots.

Uh, CPU bug?  Erratum?

> +	 */
> +	switch (c->x86_model) {
> +	case 0x18 ... 0x1f:
> +	case 0x60 ... 0x7f:
> +		clear_cpu_cap(c, X86_FEATURE_V_VMSAVE_VMLOAD);
> +		break;
> +	}
>  }
>  
>  static void init_amd_zen5(struct cpuinfo_x86 *c)
> -- 
> 2.43.0
> 

