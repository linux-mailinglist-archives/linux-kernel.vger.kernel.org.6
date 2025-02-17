Return-Path: <linux-kernel+bounces-517475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C540FA38155
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAFD3A4FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E521773D;
	Mon, 17 Feb 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTP/325z"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FE216600
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790498; cv=none; b=bmuAfWgciJfv+K5mMhJuTH/0GsRTQAdSeAhawZ8fL1qS5cKYfTyDwVG/JDUIHanos0707UX8v1HtvGugW1MtTdNXvIV8qaK5VCilefuc/AZ67/fM+B2RrXnbj6C0YrEQrpbqfIjVHnokPYUVAJSxG9VbWzAzIapPXO9soBcOh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790498; c=relaxed/simple;
	bh=atjs7oei/H9EMWRMSQ5Kko8ZLpW91ISmrkJMwweNwug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEUFpXvNC7xYYtlPAaWxrNq9mAZefnIp+B9kzcjjCYcm6fcvCyl+4m3HUAH2Yvp3py+vDEnXVGtlIkNeGXeAtukoxyNfxEls/sA7MHTiplktUbJdujiZmPLNbQbZpuvC67IzgpHor/hQTvr0MKnAiWmK4O64qN3ufShVfj27/iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTP/325z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso2492165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739790494; x=1740395294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI1xOAxN4gVEotlH+hB1nghImyURmAyLFsg6EIdJCwY=;
        b=YTP/325zKLNdNel0sFLeLpn0VLznFvLVltdGzi/8QX1qJ+IHDETaE0h3FKFFDq0wO2
         mRECkXFIMUFWgtXZ/ATa9xsU/gqTrNy+NBWBPp8EbV2ao8NGV+PHBeuxv6uJJE+cbb1o
         7aadYfzre2xqtMt5dztrwy0cbhgZ3Duios3zcG7mzGgmFt3o6v4bIWQcoZymMhYcUYF1
         zbMxiYcZ0T2Y6GhpIFfh9IK/GHsaBT5xccgcvF2ZlhS9a2zDEUP5ejKTEbkmPaiucpnp
         jmriQGPkeHqbN5YIvov+Dxi8ZED4utWerqMYkyzxVQeAhVZ1ygqPFhSF0DFquB8O9zZJ
         +cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790494; x=1740395294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vI1xOAxN4gVEotlH+hB1nghImyURmAyLFsg6EIdJCwY=;
        b=eSkgVa95NDLUaobTKoXSC0yayHK2CHhJX7igbW6zcjL+2N90cDbTwOT/NDYulWr9eM
         6OXkv00sOgoj6uEG48ZeWM5Evu+4raqNuuELKL5xBD4hZvvKbucHll0C9WiMeKgifeRq
         JitLMiSsRnzJRSuS1+ASuEd5/IC6cCF+5SdKaBMB6gaQjh3AxUZymn+PUe7ocRN8gnST
         nZEJb7UwoeZNij9bgVQvZnFin+axWQ4q+FHJ6k1AHnvBkrrDtTH0Or699D71PSlRgJLU
         O0oajeOGYMX/S9VfGLnMdDqv6LKgf/eTXgsNlkrtYQJ6feff5BPVAUmCMQb9daYvHk6N
         v7QA==
X-Forwarded-Encrypted: i=1; AJvYcCULiphx8rWZ6lPSI510FL9SgO0HFGw0TE5JjzTXapcXq+ppYKno8thnItJTZdsNzR2wL0erC/Ak2YPXYWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBD9XwlbTcwN1+sQZBrp03W2E2P9SV1iwfNHTnctcfOr3syLy+
	/TRRYzhN3v5abuGx4rfhrIj87mchrHSx4GqPn/KJH0TUrhqGNvmjaYdJHQb5zgifNuwhs+rG6ax
	hBF/PDw==
X-Google-Smtp-Source: AGHT+IGSGUNfoh8PbhgoVv+xw7TTBsHTBAYuA6CvA3Pz3DkeXZDM2wCyJ+KhkfICAd8Mpu72pYcC/m+MgZTT
X-Received: from wmbay24.prod.google.com ([2002:a05:600c:1e18:b0:439:8e81:fd03])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:511c:b0:439:4d00:3ade
 with SMTP id 5b1f17b1804b1-4396e765340mr67836275e9.26.1739790494671; Mon, 17
 Feb 2025 03:08:14 -0800 (PST)
Date: Mon, 17 Feb 2025 12:07:31 +0100
In-Reply-To: <cover.1739790300.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <6a97e9986b0fb05935204f55f8d16fc5e66f0ccf.1739790300.git.dvyukov@google.com>
Subject: [PATCH 2/4] x86/signal: Use switch_to_permissive_pkey_reg() helper
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the new switch_to_permissive_pkey_reg() helper instead of the
custom code. No functional changes intended.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/signal.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 5f441039b5725..b753de278257a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -28,6 +28,7 @@
 #include <linux/entry-common.h>
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
+#include <linux/pkeys.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -60,24 +61,6 @@ static inline int is_x32_frame(struct ksignal *ksig)
 		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
 
-/*
- * Enable all pkeys temporarily, so as to ensure that both the current
- * execution stack as well as the alternate signal stack are writeable.
- * The application can use any of the available pkeys to protect the
- * alternate signal stack, and we don't know which one it is, so enable
- * all. The PKRU register will be reset to init_pkru later in the flow,
- * in fpu__clear_user_states(), and it is the application's responsibility
- * to enable the appropriate pkey as the first step in the signal handler
- * so that the handler does not segfault.
- */
-static inline u32 sig_prepare_pkru(void)
-{
-	u32 orig_pkru = read_pkru();
-
-	write_pkru(0);
-	return orig_pkru;
-}
-
 /*
  * Set up a signal frame.
  */
@@ -157,8 +140,18 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 		return (void __user *)-1L;
 	}
 
-	/* Update PKRU to enable access to the alternate signal stack. */
-	pkru = sig_prepare_pkru();
+	/*
+	 * Enable all pkeys temporarily, so as to ensure that both the current
+	 * execution stack as well as the alternate signal stack are
+	 * writeable. The application can use any of the available pkeys to
+	 * protect the alternate signal stack, and we don't know which one it
+	 * is, so enable all. The PKRU register will be reset to init_pkru
+	 * later in the flow, in fpu__clear_user_states(), and it is the
+	 * application's responsibility to enable the appropriate pkey as the
+	 * first step in the signal handler so that the handler does not
+	 * segfault.
+	 */
+	pkru = switch_to_permissive_pkey_reg();
 	/* save i387 and extended state */
 	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru)) {
 		/*
-- 
2.48.1.601.g30ceb7b040-goog


