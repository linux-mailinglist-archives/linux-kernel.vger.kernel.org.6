Return-Path: <linux-kernel+bounces-422629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9259D9C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B6283A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397311DB344;
	Tue, 26 Nov 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvQnWaD5"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEAE1DA0E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641119; cv=none; b=k+fE5UyPQUAUjgGYGHJY2r6oxWvEQktsyyc68ulN0i+oc6XuxxbQ/qWg4TS/+gcwHSXQA5NCJmqPVivWge/wRwQsdgaBQ3MaZ12ztl3wZRlnOvDhxWs5kB2hNt++Gc9U6hDgLeOmZ3LURz4s/pUGwvWjhmQIbJCJxJE5iZAlxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641119; c=relaxed/simple;
	bh=Kpa0SGmAtBSOWgE9EWnrR0Cz5g3upyJ5yOXSyzWFaMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhgltDvjVjsRz69XWeXWLRHuhCUah0byorjiBOWd6fWPrPzjtwY7W/BZ+yY+azckkwcYsL8F1hNPb+J2nQUH3eFOXHczrt8By0O0DpjSVGKeZGLfNtVqZgg7KMfvfiC90zftgU8+KFnTOnuNuHZEukq3Voyp79uKwBvvOehkdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvQnWaD5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a77ab3ebfaso189515ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732641117; x=1733245917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QaYp5eenirWa9o/YHPO7HxLmbRG5J5BQfp0x2GG4oM=;
        b=ZvQnWaD5v2NwwU91AsAFj+IfntgBS0lYPpr99ZQSUaSQhUuZgdj8VQuwXg6abLF/so
         0ph7zyoOGRHoPhRvI1vvpqJ546TslpgnABwaX43d+68SewO73YSjLpi0vcLqCNgR8XLz
         zm+PWkhuBYO2taAycEfXlGbD5ksLYLnoEMyTZvG8xTLcO/CJpJmx9is7cHhDGwrZ/FxV
         kGtRs9iZr6UBR8r2YagnA9oI0B1NYUvG6QzLeicp0WOrGqebRVCenXV3xeoSgkZ5LnK/
         6PCaoGA+s5JdcmlzYM1Rp7Om7KZgON+1kHbs8n4SDKk8YD71spxGyrc8d6zVH2IHMA+K
         EuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641117; x=1733245917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QaYp5eenirWa9o/YHPO7HxLmbRG5J5BQfp0x2GG4oM=;
        b=wRSvTUsqz64oJHWcH/t1ZlBFHInpxC6o9uulqEY1bR978B0RHyrL4JJTfAo7oYpoba
         921TTR30y45Sil17PV2AFGnd0jm/D24CZ4ZnG9KlnxUMJScNuaXbj4C04tPM7uKAK06l
         McYLGO6xKJ8VLQYapQcK1S4eCW7OsNHrg7OpQTTB65gNvAYRarlvvehyTmOXCOiNOyVO
         uVXZUdBoZLpwvOhzo1+L7ZHpJ7RRS87sHWKkDbsnZyZwJJ3S8LwEzizE2YM8ThFsJzCg
         Gh9sJUQRg9UnWkX0vJzkEvSzv2Xj64erSsNpQb0Dxh6in3Okh455u/SFmZBWrqSt8MgA
         XRYw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ljhM2X7NU0HCwpPsk2iJxDDNp4rVLouYkeBivSlJfp/rvNotYdUZ8WLr0YCensmemEj7/5It6+Svsi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrAMEOmlTZT47hR0uFf2Jx/yac3g6wax9Uigp+LOx2TNvGELp
	cj37Gri+mZzqshGPMk4AjTkIrnB3IH+cgb5eURBZFY6g9TuV+gSYq/uxQklCO2vIICwg1AXqWIV
	A2gGHOVfkgm5ttpU7pnulQDHJ258gBcm+Fm0A
X-Gm-Gg: ASbGncu/KwGpA2XwzdFleO3GpBsmgHaCmVpQQFOqeOv8VukXY6FhLMu59lpwKNGnIqP
	iMA7gjAAA3UB0nindPxU8YC6qSiWJVg==
X-Google-Smtp-Source: AGHT+IG1zEQQQxwR899WiiyYURNNaFBKiXZE2REAZFJuNim29X2rB9W67xYgfPXwaIykVzcHpMw4kc/jkA2JKCVED1U=
X-Received: by 2002:a05:6e02:1f86:b0:3a7:8c71:3cc3 with SMTP id
 e9e14a558f8ab-3a7bc8aaeaemr4276525ab.26.1732641116947; Tue, 26 Nov 2024
 09:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126094424.943192-1-davydov-max@yandex-team.ru> <20241126094424.943192-3-davydov-max@yandex-team.ru>
In-Reply-To: <20241126094424.943192-3-davydov-max@yandex-team.ru>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 26 Nov 2024 09:11:46 -0800
Message-ID: <CALMp9eS5VzbqthF03tQoXkKK+hRYsH4sxuL3hwY-vud6Vez8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86: KVM: Advertise AMD's speculation control features
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	babu.moger@amd.com, seanjc@google.com, mingo@redhat.com, bp@alien8.de, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:45=E2=80=AFAM Maksim Davydov
<davydov-max@yandex-team.ru> wrote:
>
> It seems helpful to expose to userspace some speculation control features
> from 0x80000008_EBX function:
> * 16 bit. IBRS always on. Indicates whether processor prefers that
>   IBRS is always on. It simplifies speculation managing.
> * 18 bit. IBRS is preferred over software solution. Indicates that
>   software mitigations can be replaced with more performant IBRS.
> * 19 bit. IBRS provides Same Mode Protection. Indicates that when IBRS
>   is set indirect branch predictions are not influenced by any prior
>   indirect branches.
> * 29 bit. BTC_NO. Indicates that processor isn't affected by branch type
>   confusion. It's used during mitigations setting up.
> * 30 bit. IBPB clears return address predictor. It's used during
>   mitigations setting up.
>
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  arch/x86/include/asm/cpufeatures.h | 3 +++
>  arch/x86/kvm/cpuid.c               | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index f6be4fd2ead0..ba371d364c58 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -340,7 +340,10 @@
>  #define X86_FEATURE_AMD_IBPB           (13*32+12) /* Indirect Branch Pre=
diction Barrier */
>  #define X86_FEATURE_AMD_IBRS           (13*32+14) /* Indirect Branch Res=
tricted Speculation */
>  #define X86_FEATURE_AMD_STIBP          (13*32+15) /* Single Thread Indir=
ect Branch Predictors */
> +#define X86_FEATURE_AMD_IBRS_ALWAYS_ON (13*32+16) /* Indirect Branch Res=
tricted Speculation always-on preferred */
>  #define X86_FEATURE_AMD_STIBP_ALWAYS_ON        (13*32+17) /* Single Thre=
ad Indirect Branch Predictors always-on preferred */
> +#define X86_FEATURE_AMD_IBRS_PREFERRED (13*32+18) /* Indirect Branch Res=
tricted Speculation is preferred over SW solution */
> +#define X86_FEATURE_AMD_IBRS_SMP       (13*32+19) /* Indirect Branch Res=
tricted Speculation provides Same Mode Protection */

"SMP" is an unfortunate overloading of an acronym with another
well-known meaning. Perhaps "SAME_MODE"?

>  #define X86_FEATURE_AMD_PPIN           (13*32+23) /* "amd_ppin" Protecte=
d Processor Inventory Number */
>  #define X86_FEATURE_AMD_SSBD           (13*32+24) /* Speculative Store B=
ypass Disable */
>  #define X86_FEATURE_VIRT_SSBD          (13*32+25) /* "virt_ssbd" Virtual=
ized Speculative Store Bypass Disable */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 30ce1bcfc47f..5b2d52913b18 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -754,8 +754,9 @@ void kvm_set_cpu_caps(void)
>         kvm_cpu_cap_mask(CPUID_8000_0008_EBX,
>                 F(CLZERO) | F(XSAVEERPTR) |
>                 F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F=
(VIRT_SSBD) |
> -               F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
> -               F(AMD_PSFD)
> +               F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_IBRS_ALWAYS_ON) |
> +               F(AMD_STIBP_ALWAYS_ON) | F(AMD_IBRS_PREFERRED) |
> +               F(AMD_IBRS_SMP) | F(AMD_PSFD) | F(BTC_NO) | F(AMD_IBPB_RE=
T)
>         );

Reviewed-by: Jim Mattson <jmattson@google.com>

