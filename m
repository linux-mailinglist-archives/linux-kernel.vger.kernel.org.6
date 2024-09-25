Return-Path: <linux-kernel+bounces-339111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43F98609D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37731B248CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CCF1A4B8A;
	Wed, 25 Sep 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4nHFf9C"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7215B12B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268943; cv=none; b=HCNmv89mpYMPZqSnBfkQ0/IveCrEt6v2rW/sQfYpAzYriexjDTQgFXFv/HzmHl3L/u8lYiS5xfodMjTUsnzNq4KKAPw+7kahA0XcrKOtNrgmZiq3aYP+yWPKCp9P4NdoS2h51Fu12zPY5LPxEI8UqTYz0RQUfPZRiTHJnqg+AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268943; c=relaxed/simple;
	bh=SqsrNamKhqSmaf/1oFdKI6QM7JNNm91uH+KndaDN+GM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G353YhOan6hmkcLxxDtAfas4ZdFTcF3IrOwBRmKfPdJT/ap5rI0MOY66AJ7XA2WfMjozOrwpIArulOlapvGSihPd6TbtMtZYetI6DUA0MJn1yu3ZEgxqKASLILt/BVfQHqtDdc6+ILur0y1CEDRVk3GBlfTw4JQYO3dRjSaJ+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4nHFf9C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e20b046922so38408447b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727268940; x=1727873740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejU8vvarcUji1scLaHFX1ADT3z35bJpwvhsMj4+OLE4=;
        b=d4nHFf9C6GZ1aBjMSMjzhlY0M0WSlkLd1VfrIvmnTshVasLe3Uom/Z4BAJbPOgC+f6
         jMbpLmgydJcnk1EO+I/aOmJfe9kMhCuk+C+WyaO7O7Vt1jR3trxKz5aR/B+gw3lfWn+B
         eRBdImzYNmKX/8e8Qys30/rryQ6Gk+J8T2NNK0akXyZR+6UjiCf3jjJ4ZvQqNT6xKC1R
         r3yLYsTHZpgmMfVWYilMX6+Ba+UBLrfUXjZhmcggkJTxW3TDacJknXAygVNLnlj0Hozw
         QFBE+Abub0UmpjmIVRTWFDCj8s43li+FzZkzsbwIHxglaE2hT0AqniH7PWuyWe6QHa9n
         DgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268940; x=1727873740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejU8vvarcUji1scLaHFX1ADT3z35bJpwvhsMj4+OLE4=;
        b=OkhwkFrR9m1czoCetZhfr97D9M2x4cfCN96Lg/PN4LCH6N9tjWc84OAeo+cOCgr8cn
         utxav8pOVGgUeF3tyYCtP1THZq4oaLqLmGAy8OBwt8yIVyWrobo9apDNBTH7ghxsPssi
         jPAsEWG1uEOpmnxfnk9pJSpvhjTmtDC6SXxfsLEKnG4w6pZvA+bkY62GrRkVd3LpYK6q
         6aBJetqrZ9kwOijKG4XuCFFMlUwc5iYRG15XiYjCE1TXVLj0+Y2EgSBv1K8vXXgYyy8E
         HMMOweTUcmESTvh7MqZFgs19BvDzUAlF84k2qoaujz8vQoplvcKzviL21MFkh8MXwQ3r
         N0Vg==
X-Gm-Message-State: AOJu0YwDppUPhwaGimq/hrxJPMkY9LtmBND8STRadHYYagd/3kmbQBi/
	nqJVriecbzCMYNlAGSpCHWhax8aejfYyOo2S4tC/zhNreWG3kmihut/Z2yf40pYe/V7avLpDYn8
	Fow==
X-Google-Smtp-Source: AGHT+IHV+hKp0Q9Hx5xYHjlPSEL8B7B2ZZTX/32jkpd2zuCYjaKxoOK6gQ4TjmMkDZqskxjv4Q7RPav9iq0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:580a:b0:6dd:c0f7:2121 with SMTP id
 00721157ae682-6e21d9fc431mr30527b3.5.1727268939762; Wed, 25 Sep 2024 05:55:39
 -0700 (PDT)
Date: Wed, 25 Sep 2024 05:55:38 -0700
In-Reply-To: <ef194c25-22d8-204e-ffb6-8f9f0a0621fb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731150811.156771-1-nikunj@amd.com> <20240731150811.156771-20-nikunj@amd.com>
 <ZuR2t1QrBpPc1Sz2@google.com> <9a218564-b011-4222-187d-cba9e9268e93@amd.com>
 <ZurCbP7MesWXQbqZ@google.com> <2870c470-06c8-aa9c-0257-3f9652a4ccd8@amd.com>
 <Zu0iiMoLJprb4nUP@google.com> <4cc88621-d548-d3a1-d667-13586b7bfea8@amd.com> <ef194c25-22d8-204e-ffb6-8f9f0a0621fb@amd.com>
Message-ID: <ZvQHpbNauYTBgU6M@google.com>
Subject: Re: [PATCH v11 19/20] x86/kvmclock: Skip kvmclock when Secure TSC is available
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, pbonzini@redhat.com, 
	peterz@infradead.org, gautham.shenoy@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 25, 2024, Nikunj A. Dadhania wrote:
> >>>>> Are you suggesting that whenever the guest is either SNP or TDX, kvmclock
> >>>>> should be disabled assuming that timesource is stable and always running?
> >>>>
> >>>> No, I'm saying that the guest should prefer the raw TSC over kvmclock if the TSC
> >>>> is stable, irrespective of SNP or TDX.  This is effectively already done for the
> >>>> timekeeping base (see commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
> >>>> invariant TSC is exposed")), but the scheduler still uses kvmclock thanks to the
> >>>> kvm_sched_clock_init() code.
> >>>
> >>> The kvm-clock and tsc-early both are having the rating of 299. As they are of
> >>> same rating, kvm-clock is being picked up first.
> >>>
> >>> Is it fine to drop the clock rating of kvmclock to 298 ? With this tsc-early will
> >>> be picked up instead.
> >>
> >> IMO, it's ugly, but that's a problem with the rating system inasmuch as anything.
> >>
> >> But the kernel will still be using kvmclock for the scheduler clock, which is
> >> undesirable.
> > 
> > Agree, kvm_sched_clock_init() is still being called. The above hunk was to use
> > tsc-early/tsc as the clocksource and not kvm-clock.
> 
> How about the below patch:
> 
> From: Nikunj A Dadhania <nikunj@amd.com>
> Date: Tue, 28 Nov 2023 18:29:56 +0530
> Subject: [RFC PATCH] x86/kvmclock: Prefer invariant TSC as the clocksource and
>  scheduler clock
> 
> For platforms that support stable and always running TSC, although the
> kvm-clock rating is dropped to 299 to prefer TSC, the guest scheduler clock
> still keeps on using the kvm-clock which is undesirable. Moreover, as the
> kvm-clock and early-tsc clocksource are both registered with 299 rating,
> kvm-clock is being picked up momentarily instead of selecting more stable
> tsc-early clocksource.
> 
>   kvm-clock: Using msrs 4b564d01 and 4b564d00
>   kvm-clock: using sched offset of 1799357702246960 cycles
>   clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>   tsc: Detected 1996.249 MHz processor
>   clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x398cadd9d93, max_idle_ns: 881590552906 ns
>   clocksource: Switched to clocksource kvm-clock
>   clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x398cadd9d93, max_idle_ns: 881590552906 ns
>   clocksource: Switched to clocksource tsc
> 
> Drop the kvm-clock rating to 298, so that tsc-early is picked up before
> kvm-clock and use TSC for scheduler clock as well when the TSC is invariant
> and stable.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> 
> ---
> 
> The issue we see here is that on bare-metal if the TSC is marked unstable,
> then the sched-clock will fall back to jiffies. In the virtualization case,
> do we want to fall back to kvm-clock when TSC is marked unstable?

In the general case, yes.  Though that might be a WARN-able offense if the TSC
is allegedly constant+nonstop.  And for SNP and TDX, it might be a "panic and do
not boot" offense, since using kvmclock undermines the security of the guest.

> ---
>  arch/x86/kernel/kvmclock.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 5b2c15214a6b..c997b2628c4b 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -317,9 +317,6 @@ void __init kvmclock_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
>  		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
>  
> -	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
> -	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> -
>  	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
>  	x86_platform.calibrate_cpu = kvm_get_tsc_khz;
>  	x86_platform.get_wallclock = kvm_get_wallclock;
> @@ -341,8 +338,12 @@ void __init kvmclock_init(void)
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> -	    !check_tsc_unstable())
> -		kvm_clock.rating = 299;
> +	    !check_tsc_unstable()) {
> +		kvm_clock.rating = 298;
> +	} else {
> +		flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
> +		kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> +	}

I would really, really like to fix this in a centralized location, not by having
each PV clocksource muck with their clock's rating.  I'm not even sure the existing
code is entirely correct, as kvmclock_init() runs _before_ tsc_early_init().  Which
is desirable in the legacy case, as it allows calibrating the TSC using kvmclock,

  	x86_platform.calibrate_tsc = kvm_get_tsc_khz;

but on modern setups that's definitely undesirable, as it means the kernel won't
use CPUID.0x15, which every explicitly tells software the frequency of the TSC.

And I don't think we want to simply point at native_calibrate_tsc(), because that
thing is not at all correct for a VM, where checking x86_vendor and x86_vfm is at
best sketchy.  E.g. I would think it's in AMD's interest for Secure TSC to define
the TSC frequency using CPUID.0x15, even if AMD CPUs don't (yet) natively support
CPUID.0x15.

In other words, I think we need to overhaul the PV clock vs. TSC logic so that it
makes sense for modern CPUs+VMs, not just keep hacking away at kvmclock.  I don't
expect the code would be all that complex in the end, the hardest part is likely
just figuring out (and agreeing on) what exactly the kernel should be doing.

>  	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
>  	pv_info.name = "KVM";
> -- 
> 2.34.1
> 

