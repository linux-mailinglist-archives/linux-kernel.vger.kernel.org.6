Return-Path: <linux-kernel+bounces-534600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41CA468EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC5188CC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400A623959A;
	Wed, 26 Feb 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn9mxMVo"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C2238D38
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593172; cv=none; b=HHMw09vqMqA1T/3Q3NslB+lI2M+eS+0rPsWcIAiBVETCLsUlWYWcs/yYJ9zd6GmaAtFZXSm90ezK+y9IqDeeE5LlOSo3zPDQvMl+kPpwSV5Xbvwa2EtAcvLDTGpP41KL8t8LVG52GbGfuwQH/e/1pFMuZArChWQbNNqmchjJUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593172; c=relaxed/simple;
	bh=+NITKJToEUXuaXK8zS47p3zttszR09n9fFSVaLvRHdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9UYnRBPjSMmbcUoqpi8xYM0IlPoxVmt9VaV9a2AaRrOCe0S3wLSEOzJEMxGMtjELMDyguysQ3VX/qx6zNfAuo1sdkDci6PLUoT9Wd8v1gmy9yIR/PNr0+QXDsSPzEi/D2RZr8ISIQKTcrZ8Rd3LrZ0tmXOf0m/ymYJ67vdXtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn9mxMVo; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fe944a4243so17833eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593170; x=1741197970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzASOhbn/TdUnUq2BoNH4zzSfvXYoXG0ehJxyB+XGAg=;
        b=Yn9mxMVoVEencS7lXzRJU1YL+j7md8nXLHoMXxlzKghYcO1Taf6Zg9S8ujTo7a6aJj
         yEsFeBhR6HbfiOT6kvUtnpgCRSPR6LdC1On6m9+ulWoeAqtPChdF7Sfa9LdB+sWE9665
         MYx7/pa4sPQu+98BD7qfnfZOiQ/Gu68g96I8lyYzScqN/1HXEmXz855Nqr+uVEeWpyNN
         VjVUUlmlMFfZI4XX3WzG8optFFLm4y+UsPFz1luD0iL58wgz9UhZy71JSDaCEx50yBP7
         RC/o5bYOiKtIKT1nEDLvXHXOD1S/1Uro/cxDrcdhOjky+Cjt7F3N3Dpnc7t/5KsOmhP0
         q1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593170; x=1741197970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzASOhbn/TdUnUq2BoNH4zzSfvXYoXG0ehJxyB+XGAg=;
        b=QL41eUK493Rm6ZquMEprrDSI0G46kVigdGLpPNFgPO8ANGHlZL/XI0hulQSCxr0KJ3
         ujJG4/E9oanLcfCuIpykOjkGkyZ/7JQGdM65f6HRxyQJDHZZundbHlD61tC35ttU95uA
         bRiHA8RYrsQpjiclPxJmTMRtiIR55haZd0/MtBmW1YiOmZOEMgKdE7m3hDH0ezBrNpLa
         7E721KvdHdtlzjeig7eq+GdLPBE2BtNu9CtnjS5514jRfIohgt2kNOWPmNH/doZo4pU6
         OAM+1eyzyscG6wXUFhb0XRidGOs3M964dWbx9BP3K4ZbP1Fvxxl/z/HA/r74DQUq4qRP
         arsA==
X-Gm-Message-State: AOJu0YxoS2AUZHbPcS5HrdgYwQ4KvIcD4kanNR2vXPQJzmMYa0wcT7rV
	a5YZmsQFOX5AIYhs3YSeNpNf3o7ftcUnAHgCGrKS8sVttGSq5Zm6pGZL
X-Gm-Gg: ASbGnctmSAhsIlcE6t92uygGkICKUSubWKCWwRtQbAtY+r3dBTiOCWyfEh4g46h+SxW
	TccbA5gbkP+RcRmebLtOe30i5dd6vJwTiR5uitxOoDJuW4zI7t36P7OImw92ERCQNtuVaNnu2TH
	13wVpKlcs6Tb38wqND0RNMlxr/9PuBZDNNlF7V9G12jGLxGCERO6+tqmK3xLTe3hOL7bkbgly4B
	LNzKgUJbbQ4+36oXN3jOp2rFjR5XWirldiFszMoeEfC4x7Bek6K3l9fubw1aOpDNN4/pAu0yavp
	Ht0vI9Q=
X-Google-Smtp-Source: AGHT+IFii8Y/uCMqIDFr/IoOM4XP5abwoUhsViZfg/Vzn8cm5Kj85HSMWVmn3VxiKZKd22QeLpQM+A==
X-Received: by 2002:a05:6820:506:b0:5fd:b85:9b47 with SMTP id 006d021491bc7-5fe937185camr3833158eaf.1.1740593169862;
        Wed, 26 Feb 2025 10:06:09 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:06:09 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 10/11] x86/stackprotector: Move __stack_chk_guard to percpu hot section
Date: Wed, 26 Feb 2025 13:05:29 -0500
Message-ID: <20250226180531.1242429-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb589fcf6..cd761b14eb02 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ac8721a0eb3a..62472b8f798a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2097,7 +2097,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
-- 
2.48.1


