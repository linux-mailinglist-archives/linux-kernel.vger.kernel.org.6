Return-Path: <linux-kernel+bounces-435295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97C9E75B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F014328B967
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709014F9CC;
	Fri,  6 Dec 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdaHuQRv"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF02154BEA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502009; cv=none; b=ZvrU/o8EpVJooQrA1MGOM9v8+qOBwM5wa9UBCcHQ0n8VznWwhphjcro8EySg5yDPum+XmABGf2L53y6oOcgr8sOSFX0UjVDWHxy+ehSc3HgiOidkTjxhfHkaMfUybVUSwED+1iiQWLrum+jCcVkYhNCsw681vfFy+AE+6LogJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502009; c=relaxed/simple;
	bh=2uBIz0l+rdJ8wNGt2EYoUYNtmyuPT97Q2on0gtITs2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OF84bhgP8yOuE+2sVQV9vxQiP/PihtFcIWumRbECD62BYcDq37Zz0JtmUuft15FXNCGdYbEKWjeibBj+x/INutGA6yJ+3yp+3AOa2gTxmWjTZQiyUrtE5vjBwrOGqDqqcuBCU6rrzCohWUAsjLQ1JJtX0FRXiI+BxEtkRrUOwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdaHuQRv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so317371a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733502008; x=1734106808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+H1coxCLEnSNmORX7OfnAxVzTHRPtf7no40m4N/V/uk=;
        b=pdaHuQRv/hmBzRrY9gKS45/pBng90v9AgPWPWX4nAlxXCFdKANpSuWX4kugOgDUoOQ
         7P4ohQx9aVBR0iEL6eYAlEvGx6jr/ZbBEwDYlHpMSOwCcpcf5Ad4B+Il5W0nshEFmUiI
         P4mp7MKGljl0Aej3Cww9MV/eFuKurV10O8CisjgsNtpk4mh6hFw/Kp0ej83cvUCVOuu+
         96k/rN8f24tdIOSH3cZaR2drgz6OIOuolIczHfkPdT3RZAdOzp8kyBGSgmN1L/iTYQIE
         BjAG+qUr2UCk/67okJecQfJ3WcOudhGMYAuYyiCRU3izrvs7jF9dRAlVhqU7oXIyURJn
         698A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502008; x=1734106808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H1coxCLEnSNmORX7OfnAxVzTHRPtf7no40m4N/V/uk=;
        b=fRN7U+51xgvcVAKzh0J8EkHyMSPh206mpC2ZtKox3JJvw/PqBZOA/2xs//0+RZDD6d
         7nisA8NyE5f64abSr4lb/3EEr8XCezUqRQ6SwYmkdZCVrA0LFSNg/qHMu7Gzkg1mqAac
         AH7CRfw7jKVZe5LBU65+Y0auoNYsnvDEkHOv5a4ygDJp5gSDjuNMt5cRHET4g6qYWNjr
         N4qZG1Du3iNGxaw1d8ilS8OZIaRiHO9YOAJ+Y68FCiWOGgS0fSeBBv2OrmatsjCfzVe1
         CIxHLryDptjg8uCiVbeRY3ljGxUK0F7uTIbv5D3Ou/7iWaAqoQGo5/robvO8oo3EkxH6
         bBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW40qIk7+6xhObApNgdw4f9WCOEvbGXebvhFd9pgtYcTva/ymQ/iOoeP4l9t1+SRpN0bC1N+bfPGMFjXwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6opsmDeYBefI+ELFG77xy27stAlxqBSMOpj3D6Q2oAzFVOci
	czmArl7gBFbhp2SPyjmliIwU5r+hanaLv11+oaaaJnno2jYf/PiHiBItfPwdaLoc2Z41ezoxRFQ
	8xA==
X-Google-Smtp-Source: AGHT+IGeogtZGyGkhzocM8bBJCfu17eckQUvvO4h21X0DlxsLUMn7utLtFZJXoJK59nGBhJIwLTR9Ti29eU=
X-Received: from pjbmf11.prod.google.com ([2002:a17:90b:184b:b0:2ea:83a6:9386])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcd:b0:2ea:4a6b:79d1
 with SMTP id 98e67ed59e1d1-2ef69e16bf5mr4580955a91.11.1733502007810; Fri, 06
 Dec 2024 08:20:07 -0800 (PST)
Date: Fri, 6 Dec 2024 08:20:06 -0800
In-Reply-To: <20241205220604.GA2054199@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205220604.GA2054199@thelio-3990X>
Message-ID: <Z1MkNofJjt7Oq0G6@google.com>
Subject: Re: Hitting AUTOIBRS WARN_ON_ONCE() in init_amd() booting 32-bit
 kernel under KVM
From: Sean Christopherson <seanjc@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kim Phillips <kim.phillips@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 05, 2024, Nathan Chancellor wrote:
> Hi Boris and x86 + KVM folks,
> 
> I got access to a new box that has an EPYC 9454P in it and I noticed
> that I hit the warning from
> 
>         /*
>          * Make sure EFER[AIBRSE - Automatic IBRS Enable] is set. The APs are brought up
>          * using the trampoline code and as part of it, MSR_EFER gets prepared there in
>          * order to be replicated onto them. Regardless, set it here again, if not set,
>          * to protect against any future refactoring/code reorganization which might
>          * miss setting this important bit.
>          */
>         if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
>             cpu_has(c, X86_FEATURE_AUTOIBRS))
>                 WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
> 
> that was added by commit 8cc68c9c9e92 ("x86/CPU/AMD: Make sure
> EFER[AIBRSE] is set") when booting a 32-bit kernel in QEMU with KVM. I
> do not see this without KVM, so maybe this has something to do with
> commit 8c19b6f257fa ("KVM: x86: Propagate the AMD Automatic IBRS feature
> to the guest") as well?

This is a bug in the above code.  msr_set_bit() returns '1' on a successful write.
Presumably spectre_v2_select_mitigation() sets EFER.AUTOIBRS when booting on bare
metal, in which case msr_set_bit() returns '0' because the bit is already set.

--
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 6 Dec 2024 08:14:45 -0800
Subject: [PATCH] x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if
 the WRMSR fails

When ensuring EFER.AUTOIBRS is set, WARN only on a negative return code
from msr_set_bit(), as '1' is used to indicate the WRMSR was successful
('0' indicates the MSR bit was already set).

Fixes: 8cc68c9c9e92 ("x86/CPU/AMD: Make sure EFER[AIBRSE] is set")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20241205220604.GA2054199@thelio-3990X
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d8408aafeed9..79d2e17f6582 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1065,7 +1065,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 */
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
-		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
+		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS) < 0);
 
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);

base-commit: b8f52214c61a5b99a54168145378e91b40d10c90
-- 

