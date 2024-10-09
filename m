Return-Path: <linux-kernel+bounces-357770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E59975B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F561C22E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636B1E133F;
	Wed,  9 Oct 2024 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELKKzw4W"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3D1E1312
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502480; cv=none; b=ZKIic84mGS9mtPleAp2nwTP25pX7qJurLIgufDW0/dFoAD5rg+pcg2Pm5yZLSCghA4Vwyvb7eIRTp6ufC0ICyMFMCDyep9ZNE8wu6PqpDNPs0ag9nk/2a8pzJSTSUdASYTPXPL5DMp4dw/wPsG4yktwBDuaJN8sbAbkPFVltd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502480; c=relaxed/simple;
	bh=qK5hOnw9jfx2BfY4OtrYNRGZWBgC9fK10OTGA6+wTxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxPCkpvhl53Br/jiXgELhnRmiynrcEsvBRmnYtSqLwyoLoQSXFHag9376KQB7VLHc4BPuWt/gCHry3Vr5YjpAWvfwSA6dUFv2iCUu53h7T8uC2Hr9xDbvtP3jUjbS0fSPrDGiKs2Yg4Cx1MNZ3c+JbqJkg9i8jDHvYZJ+yV75sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELKKzw4W; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e123d3d22so161931b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728502478; x=1729107278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyAVjnacB7jC3cIomKyX/c7gAMM1T7N80hTnVLZyTvg=;
        b=ELKKzw4WcwE2g74UT8PuJpjp01GZUfay5OZXPAGQKpJMpkhAkXV7i3xAkSRPdC1pRX
         3NgNA19W07MBBUUK+OKT7c1t0RQvTiIzC4JahBwmmHsxZAfoQChiQzp1R4sNM9PKDcS/
         tWFisztoX5IYwXOc2o1PbVp1U4PccXAnQFyzx+eedwW+a8nOLVdc4j59ezSoftk8jRtl
         x7hBnkIdbOEXiPX1KMku+P24lOP6SvGG9IDAq8o0GTxOZV05D4a12zUjelpsxM7tUVKa
         kYCOaOLXRwzfMPba+5hQ53DX6Tl92bKTXVvDVsbO4zNQno5XJ6SOpRIPY91okbitj1h3
         Hjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502478; x=1729107278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyAVjnacB7jC3cIomKyX/c7gAMM1T7N80hTnVLZyTvg=;
        b=abjzDXjoIqbgtlyeuqa624icipAf61IM9L4UNI8jfHBHYtPZ5tRqQrIuZ8jOdqokVv
         s0lIg89fiotTj2AGfiuA195JzFop0/iyxbev4in6L+9xoBn8NfRoTY9DisES52ll84wE
         Ir9FG+zOYd5j+aV/k1npWwQ5BFWxoBGp1fGGiNUcK3j2pvkUh1bQEaaZ6YVmeqXR6iQe
         2oIjhYu0vi7eci2Niu9jL2cY4cX1vHHUNfsRcAKCYtmnESBWwlDhW+2pK7Z1XvuGxld0
         AZV9I4oL2WJJ/K2UZd8csEvCW5So8r5bDCPAAgw1l1FYOOS2d8x/Zn5H6zMYXSveEvVj
         3BxQ==
X-Gm-Message-State: AOJu0YxA3ZxEOdOMkObMwKW6h07eo4MA1FGsmy94hrG6Pzrs6lmxTGFR
	C8MSKLp3gr0ej4x3ZPxYM7FMtLDKkzMahNfJ8Jx8y9FZ7lLlYERqvqbPN7HQfO6V7qpTRFUhKrI
	1Dw==
X-Google-Smtp-Source: AGHT+IHIHDe6Bn7Ahqapi6/P1RufsoIkJbrtXAU0menkMdQ4f9/DCSB+xQkTuuKLU5Q7zJ8hzKyoBN102rY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8c86:b0:717:8ab0:2439 with SMTP id
 d2e1a72fcca58-71e1dc0b7dcmr3314b3a.6.1728502478302; Wed, 09 Oct 2024 12:34:38
 -0700 (PDT)
Date: Wed, 9 Oct 2024 12:34:37 -0700
In-Reply-To: <20241008191555.2336659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241008191555.2336659-1-andriy.shevchenko@linux.intel.com>
Message-ID: <ZwbazZpTSAn9aAC7@google.com>
Subject: Re: [PATCH v2 1/1] x86/reboot: KVM: Guard nmi_shootdown_cpus_on_restart()
 with ifdeffery
From: Sean Christopherson <seanjc@google.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: multipart/mixed; charset="UTF-8"; boundary="Osa6c5ZHj6sBiqsE"


--Osa6c5ZHj6sBiqsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024, Andy Shevchenko wrote:
> The nmi_shootdown_cpus_on_restart() in some cases may be not used.
> This, in particular, prevents kernel builds with clang, `make W=1`
> and CONFIG_WERROR=y:
> 
> arch/x86/kernel/reboot.c:957:20: error: unused function 'nmi_shootdown_cpus_on_restart' [-Werror,-Wunused-function]
>   957 | static inline void nmi_shootdown_cpus_on_restart(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by guarging the definitions with the respective KVM ifdeffery.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v1: suggested by Dave Hansen
> v2: rebased on top of the latest changes in the file
>  arch/x86/kernel/reboot.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)


Heh, I tried fixing this too, and have patches to clean things up, but I ended up
not posting them because I decided the W=1 warning was less ugly than the resulting
code in nmi_shootdown_cpus().

If we're willing to take on a bit of weirdness in nmi_shootdown_cpus(), then much
of the #ifdeffery can go away.  Patches attached (lightly tested).

$ git diff --stat next..HEAD
 arch/x86/kernel/reboot.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

--Osa6c5ZHj6sBiqsE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-x86-reboot-Allow-blindly-calling-nmi_shootdown_cpus-.patch"

From f91d4f1cc04d7955587aac3f919fd6696a648f5f Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 3 Sep 2024 10:14:27 -0700
Subject: [PATCH 1/3] x86/reboot: Allow "blindly" calling nmi_shootdown_cpus()
 without a callback

Warn if nmi_shootdown_cpus() is called after the crash IPI has been issued
if and only if the caller wants to run a specific callback, and drop the
check nmi_shootdown_cpus_on_restart() whose sole purpose was to avoid
triggering the warning.  This will allow removing the "on restart" variant.

Note, the only caller of nmi_shootdown_cpus_on_restart() unconditionally
disables IRQs, i.e. doubling down on disabling IRQs when a crash IPI has
already been issued doesn't affect the resulting functionality.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 615922838c51..25f68952af57 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -915,10 +915,14 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	/*
 	 * Avoid certain doom if a shootdown already occurred; re-registering
 	 * the NMI handler will cause list corruption, modifying the callback
-	 * will do who knows what, etc...
+	 * will do who knows what, etc...  Blindly attempting a shootdown is
+	 * allowed if the caller's goal is purely to ensure a shootdown occurs,
+	 * i.e. if the caller doesn't want to run a specific callback.
 	 */
-	if (WARN_ON_ONCE(crash_ipi_issued))
+	if (crash_ipi_issued) {
+		WARN_ON_ONCE(callback);
 		return;
+	}
 
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
@@ -956,8 +960,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 
 static inline void nmi_shootdown_cpus_on_restart(void)
 {
-	if (!crash_ipi_issued)
-		nmi_shootdown_cpus(NULL);
+	nmi_shootdown_cpus(NULL);
 }
 
 /*

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.47.0.rc1.288.g06298d1525-goog


--Osa6c5ZHj6sBiqsE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-x86-reboot-Open-code-nmi_shootdown_cpus_on_restart-i.patch"

From 5d417af0c51adc11ed0de6a30aa1ddfb2ccba875 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 5 Sep 2024 11:36:45 -0700
Subject: [PATCH 2/3] x86/reboot: Open code nmi_shootdown_cpus_on_restart()
 into its sole user

To fix a W=1 warning due to nmi_shootdown_cpus_on_restart() being unused
if KVM support is disabled, fold nmi_shootdown_cpus_on_restart() into its
one and only user, emergency_reboot_disable_virtualization().

No functional change intented.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409010207.jrH6sNV4-lkp@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 25f68952af57..8c6f6da6ee8e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,8 +528,6 @@ static inline void kb_wait(void)
 	}
 }
 
-static inline void nmi_shootdown_cpus_on_restart(void);
-
 #if IS_ENABLED(CONFIG_KVM_X86)
 /* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
@@ -595,7 +593,8 @@ static void emergency_reboot_disable_virtualization(void)
 		cpu_emergency_disable_virtualization();
 
 		/* Disable VMX/SVM and halt on other CPUs. */
-		nmi_shootdown_cpus_on_restart();
+		if (IS_ENABLED(CONFIG_SMP))
+			nmi_shootdown_cpus(NULL);
 	}
 }
 #else
@@ -958,11 +957,6 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 */
 }
 
-static inline void nmi_shootdown_cpus_on_restart(void)
-{
-	nmi_shootdown_cpus(NULL);
-}
-
 /*
  * Check if the crash dumping IPI got issued and if so, call its callback
  * directly. This function is used when we have already been in NMI handler.
@@ -990,8 +984,6 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	/* No other CPUs to shoot down */
 }
 
-static inline void nmi_shootdown_cpus_on_restart(void) { }
-
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


--Osa6c5ZHj6sBiqsE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-x86-reboot-Delete-CONFIG_SMP-n-stub-for-nmi_shootdow.patch"

From dfbd634a1acafb969794fff9ed027bedcfd187ef Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 3 Sep 2024 10:21:49 -0700
Subject: [PATCH 3/3] x86/reboot: Delete CONFIG_SMP=n stub for
 nmi_shootdown_cpus()

Remove the CONFIG_SMP=n implementation of nmi_shootdown_cpus() as all
callers invoke nmi_shootdown_cpus() if and only if CONFIG_SMP=y.  Keep
the unguarded declaration to play nice with using IS_ENABLED(CONFIG_SMP)
in if-statements (to avoid #ifdefs); thanks to dead code elimination, all
supported compilers will drop the call before linking.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 8c6f6da6ee8e..2c9299394a22 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -979,11 +979,6 @@ void __noreturn nmi_panic_self_stop(struct pt_regs *regs)
 }
 
 #else /* !CONFIG_SMP */
-void nmi_shootdown_cpus(nmi_shootdown_cb callback)
-{
-	/* No other CPUs to shoot down */
-}
-
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


--Osa6c5ZHj6sBiqsE--

