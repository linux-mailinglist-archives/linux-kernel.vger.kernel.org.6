Return-Path: <linux-kernel+bounces-357446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E317399714A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050FD1C22679
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE451E47AC;
	Wed,  9 Oct 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwveNC6M"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBD126C17
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490594; cv=none; b=SreQOB0cCVD6U4W1tAEsveDhn080IWN6n02gBqlAZtGjhsPVZR2mi8zxgznafXjvzJZqcRAhEHiELBBa4UEsruKZy2IY2bPQU7YZHmD8FiNR5RqeDxTFccPS2n0EAjNkFakWdwyX8HuNsSrefTjVOl1dpyDiAluBbeWR4AQ3vT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490594; c=relaxed/simple;
	bh=1/i6AjbUFHfkNU2q1347LNLBp7bGot3M/VerO1zyb7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=awwL6coRJj0siUt/rX7jJBSIK1GgG74uRVE9rYpRpnx0ew/WdAIWHk7s5lUyP24/U8matNOxesoOxNE1mjBTdJM7NDag4eXXJR4ds01/qGfVIZf9ZgihPO8mZpQ7rIPXHoL7sYX0zuoZiSvWBL0QDKoaeEHHQ8pJaRF6ha4UQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwveNC6M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21dcc7044so690867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490592; x=1729095392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiMyXfkIJ0KpLA/8Mu/QL9lOaau9EYIb5Ph9Zdtjz6M=;
        b=gwveNC6MFw+blMJnBZcncIRo57Cq/D3UsOc6BlKly5zSaUMLi6+g57bhLAlJVUvK8i
         Z9hYVv9671VIeO4zdJEaBimR84FU8SBjoYjqXoOnRy4RNeh1FcWZtp4oQwMn8+BfR39R
         e0QD1BnyPnrEXJaSQ5KzZc+ilKF7ktcHOr1U5T2Gc6gwE206FlJ+pT0z0kDT0p4VMH4t
         rSkHCTaywJXFulA4FLqV78UJD4khnaSz+gS5lUwS77tpT2JgNlE3IIYVwnI8xARcnDix
         WZSE3kWV+29NMKizHFogTL5S0GS+T4s0huhvix9G5wE8jV4LERSbTlmjcL0PbluT6+YR
         PRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490592; x=1729095392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiMyXfkIJ0KpLA/8Mu/QL9lOaau9EYIb5Ph9Zdtjz6M=;
        b=FHX1mJp+8ZHkkopAhcll3Tmsk1D3fGBu66nD3Ay3wJI6CtiCMFZoG9eYey120M9Z8x
         BL9yp2Yzs8I2bL26vMPis1ZqozxosKxwplcS6g+7TfWvNAjNEoYtlLKPq82jx5Q0ypH5
         36HTOabk1gHtZ/fvxIs9I73Cjxm+ScIUIlxaKb9T0f2FNq/6OW9d9eVmJmtbQzmF0d3q
         Bd971uyAlTcf00Dor0dek+gdzx5OrCCfR9DBWEYYRep3e6LZwfLTsDeZeDQhF7SbqXvG
         g3AOehlec00YAjMXOydR+kNVuAwakyX5EdqWOcSwQxqjqVhWMxgaKiAZjIMQLI5qWaLZ
         bLkQ==
X-Gm-Message-State: AOJu0YxkmGZCwaBokrWXl5O25rsWtgQTixdHg2T16Of15bEXt3SNCaxy
	inRTQhbbFnt+jLhxZ/1A88TQLQRBwYcGO204DDL3xHlPw7rjti1GYvvyAqsJtA73oCxG3kM4G5U
	ZMg==
X-Google-Smtp-Source: AGHT+IHDg8stp6UcMsgIAPMCmvDepgyuJjKptz1kBnuCpGE/lsZDNgE5UrEc9f5lUeuznGWGExf5ahzsptQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4ac:b0:e28:fe07:e7d8 with SMTP id
 3f1490d57ef6-e28fe439b20mr44444276.10.1728490591634; Wed, 09 Oct 2024
 09:16:31 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:16:30 -0700
In-Reply-To: <20241009092850.197575-16-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009092850.197575-1-nikunj@amd.com> <20241009092850.197575-16-nikunj@amd.com>
Message-ID: <ZwasXk_jZAtO6W1G@google.com>
Subject: Re: [PATCH v12 15/19] tsc: Upgrade TSC clocksource rating
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 09, 2024, Nikunj A Dadhania wrote:
> In virtualized environments running on modern CPUs, the underlying
> platforms guarantees to have a stable, always running TSC, i.e. that the
> TSC is a superior timesource as compared to other clock sources (such as
> kvmclock, HPET, ACPI timer, APIC, etc.).
> 
> Upgrade the rating of the early and regular clock source to prefer TSC over
> other clock sources when TSC is invariant, non-stop and stable.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/kernel/tsc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index c83f1091bb4f..8150f2104474 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1264,6 +1264,21 @@ static void __init check_system_tsc_reliable(void)
>  		tsc_disable_clocksource_watchdog();
>  }
>  
> +static void __init upgrade_clock_rating(struct clocksource *tsc_early,
> +					struct clocksource *tsc)
> +{
> +	/*
> +	 * Upgrade the clock rating for TSC early and regular clocksource when
> +	 * the underlying platform provides non-stop, invaraint and stable TSC.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +	    !tsc_unstable) {

Somewhat of a side topic, should KVM (as a hypervisor) be enumerating something
to guests to inform them that the TSC is reliable, i.e. that X86_FEATURE_TSC_RELIABLE
can be forced?  Or, should KVM (as the guest) infer X86_FEATURE_TSC_RELIABLE if
INVARIANT_TSC is advertised by KVM (the hyperivosor)?

Also, why on earth is 0x8000_0007.EDX manually scattered via x86_power?

> +		tsc_early->rating = 499;
> +		tsc->rating = 500;
> +	}
> +}

