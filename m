Return-Path: <linux-kernel+bounces-328640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C69786CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322DC1F2220C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ABC74076;
	Fri, 13 Sep 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+6dicoP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6D84D0E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248636; cv=none; b=ip28bQjvTjpk5yNwQX4/KzBC1b4RcgZwehpSqidzpVo0mbXSZwfVXgM64zGELg2MZUSHKRyIvmMsCrSaphE2yaejNUYCCw3M8w7ofBrQl0KaUPzWo+2pE8lk6Jg+WnS+4ow9b+vJi7rYj9zM4eOWG8J31eLYemCPhxPt7lkLpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248636; c=relaxed/simple;
	bh=avuE8sDdkBwyoDjtRSEJc0iN1R8TiV1WBhRrowcs5G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlE3t7buBpFyD33zIYI8V8RwxrQtKZ56pUmmG65i4GCWdKVIDv3LJrVYwgQkJk4QBiBSSLuOCfhOiTAJsGuXcV9bTGToA3xsngjg6YlPvAwQ9sLpnNFW46bpvyjJaTtcnw4vKXT9zbVpCbpwPJLBnZlBbejPghS+2c2d5Qcikmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+6dicoP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d683cfa528so40411347b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726248633; x=1726853433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muv8DD4FcvEwNrsCNMD3J/XvZ3CY/Fmbm537cj+6e7A=;
        b=r+6dicoPY0VMNyhsZHTOICbjhbqsEpP2edYoH6TczkPvQW62yxwY7SOZaOFCaBdYBR
         +A7ccrVNKtJos2Xk0kVDTU6YYtvvRFnupPxHNtVMftt66Jtoa1AwfEJJeOG3cZh+VWFW
         dLKA5/8oy5/4/3RCO+cIw5GwoGltfaGjef+J8+X2CpQbzw/CzKdy6MYOejx/+V5OIGia
         DcMWTpaIIHXnSGGN9ihWmGQ22HujnbOySZ3Iemc3eWRYeNXVs8h5G+ZDgOkiZ4RUIdi8
         boIndmo6zuY9kt2ogO9yCigu+jvsfzjQycnIwuOhRkSuNIf7zawvqoFo7lnw8qKaEZpR
         3wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726248633; x=1726853433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muv8DD4FcvEwNrsCNMD3J/XvZ3CY/Fmbm537cj+6e7A=;
        b=FTuCrxjufj2vXJpulxbJNsPlS0153Uq7et3xgNovQqBWJKemjjKBwAfd+oKlyAuNB+
         UjCWfh0Vc5RdbZ0yFUm+hHPQGIKB17gia84oK/Ro4fq3tdKWDubA451JpeGRrh2V9eEZ
         W1XGKqilJMgUI83NjrHLyWiXAMuQdybXCQ8KsaMb/10Em79e9JvjenC7Ge3WnRwe+cpn
         g7vqGp1R3I6VvqsCsN2wMhnPWCqZbE4j4o9O6NqPikYIuABiARoHmDddWDKs3EOsfalY
         PLa5FZpk7cOIdbatIdih0YOGTdPF9bVohaERcUvBru4f9zgb9qLrwt0KbOPH6vo1cifm
         2gwQ==
X-Gm-Message-State: AOJu0YwIakU/XTqdCn9aVx1m400FtYVfAFCwQFK2a2xAmJ6t3PEjy5h1
	hCEobD+T3MYs1NCUF80e+c42M5q0p2zYkXLFxZ0V+Z2Lw0ZOaEyz4HcPhiivlRm1kQ+tytf1iYw
	GVQ==
X-Google-Smtp-Source: AGHT+IE+5iuXvCyAMuKaKT0gEL+Uw6Gkh8WoLyy+tvqvUhOnFfag/tsvUh5cZQ1p1B+I9A3G/dwbMGpEuM4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:c087:0:b0:6d4:d6de:3e35 with SMTP id
 00721157ae682-6dbb6ba2a49mr1266217b3.8.1726248633303; Fri, 13 Sep 2024
 10:30:33 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:30:31 -0700
In-Reply-To: <20240731150811.156771-20-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731150811.156771-1-nikunj@amd.com> <20240731150811.156771-20-nikunj@amd.com>
Message-ID: <ZuR2t1QrBpPc1Sz2@google.com>
Subject: Re: [PATCH v11 19/20] x86/kvmclock: Skip kvmclock when Secure TSC is available
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, bp@alien8.de, 
	x86@kernel.org, kvm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, pgonda@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 31, 2024, Nikunj A Dadhania wrote:
> For AMD SNP guests with SecureTSC enabled, kvm-clock is being picked up
> momentarily instead of selecting more stable TSC clocksource.
> 
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000001] kvm-clock: using sched offset of 1799357702246960 cycles
> [    0.001493] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.006289] tsc: Detected 1996.249 MHz processor
> [    0.305123] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x398cadd9d93, max_idle_ns: 881590552906 ns
> [    1.045759] clocksource: Switched to clocksource kvm-clock
> [    1.141326] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x398cadd9d93, max_idle_ns: 881590552906 ns
> [    1.144634] clocksource: Switched to clocksource tsc
> 
> When Secure TSC is enabled, skip using the kvmclock. The guest kernel will
> fallback and use Secure TSC based clocksource.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Tested-by: Peter Gonda <pgonda@google.com>
> ---
>  arch/x86/kernel/kvmclock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 5b2c15214a6b..3d03b4c937b9 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -289,7 +289,7 @@ void __init kvmclock_init(void)
>  {
>  	u8 flags;
>  
> -	if (!kvm_para_available() || !kvmclock)
> +	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))

I would much prefer we solve the kvmclock vs. TSC fight in a generic way.  Unless
I've missed something, the fact that the TSC is more trusted in the SNP/TDX world
is simply what's forcing the issue, but it's not actually the reason why Linux
should prefer the TSC over kvmclock.  The underlying reason is that platforms that
support SNP/TDX are guaranteed to have a stable, always running TSC, i.e. that the
TSC is a superior timesource purely from a functionality perspective.  That it's
more secure is icing on the cake.

>  		return;
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
> -- 
> 2.34.1
> 

