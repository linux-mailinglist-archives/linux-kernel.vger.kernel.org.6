Return-Path: <linux-kernel+bounces-518755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F9A39409
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2F7175685
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C271D63CE;
	Tue, 18 Feb 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bZDOkz3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF81D5AC0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864691; cv=none; b=LLBi6R7CcLNRibYmGJ723fMPZ9k46qerf0DjuJUDhm9FDzopEjyrQi3g/+H9puIbDo1wExxK86nIdBBOMgbOnfqrwblEMX/p/2Jc2h5OM/lQ9XbqLxAd2Uyr9cOxOo6apJKgUx6/hjdr2MUO7TrPKTNisPox83MslD0SDqH73Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864691; c=relaxed/simple;
	bh=atjs7oei/H9EMWRMSQ5Kko8ZLpW91ISmrkJMwweNwug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKRtl2pskDLIpnKW4yupqBVqOBQii6cGpzLug3DlMZnq1jKInMflMAKDBmJ1lF/IO4AGsZmrtaUfVimsNcyYIz9JlJasUKnDu47fWLYvXBOL9icdkd+AnlbhyO1wZt0OMsH7KF7QSwGl1UmVx0sxfVlDpf8w8BwBXIlFah/OzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bZDOkz3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c747c72so27015705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739864688; x=1740469488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI1xOAxN4gVEotlH+hB1nghImyURmAyLFsg6EIdJCwY=;
        b=0bZDOkz3G05Bvtm+ylxEJPa+p8vY5QikclLmcc8omZMdXp2luKb9vq9VvZx8VnCfky
         axCN+IZ2LP4g+lbJp7gfzGyh0H9YEIzbxRTDQJCPhgyQ8FplTnGxMTZx9sjyXFatpWwg
         vd/RcDXU469SonSf3pX+txmC6+1RRvm6epeL4ML0sfWGi2/NH/lpYKEHdnPk5QDRSJm1
         U9F8stMwVDq0aMSQ8jrTk5UxZ5h4ESvQ1gw6G7Lhw2/hFENSB2Qf31y5/hMK62z+8BXI
         z/BV0ZejrAV21rVtMJ2IiRHiOboCoO+s1qfXfcctWqW7bLoMFw9JI6qpi0bF7T4Bn2yJ
         Q7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864688; x=1740469488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vI1xOAxN4gVEotlH+hB1nghImyURmAyLFsg6EIdJCwY=;
        b=dBNu1lVxetIrIN0sLk7MykqCCBejzpQosmwRYYfEIDkI6aZVgN+5xWgdG4F9y31W+Q
         CBaUflbYoMbwM7g++eDdD4GU0kAFthSN8yKiUGIs888wqVFsYjMk+QUPQMjRJk3sMvsy
         7ZKxSnubFr03+OCH6C6F7I1FoTPseeIe2Tm9mgRHnbRdNiJ8bt0k1szK9Qjj1YqfzLnR
         2j13k5f5ELPpiagR2zoaIcS4l4HBqWTohMyID1A96+AovdLOCub1cRenbth4gChCq/S5
         XKNh+NXMMfLda/OYIuH9rPORQCtlYlspoBLJXNDEAzBjffPT5MY01Rh3fuiitFT6sq2K
         8QSA==
X-Forwarded-Encrypted: i=1; AJvYcCXCL+oRrCPeRxny3scjwC/sG0Z9c39+il10gLbJM4DIttiW6ITHCHCl/iA1Bbm/kmg4gKGrFIQ4k/A4M34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXl9PDy2uvBUZy1jkoNJFAZ091PBtLCOnsGOiUZldChAhlw4Up
	PZrhVZxBQoUiVa16AYBw2UmqNWDXjVe/jWngBPSt8I1kwCaIkc8alFSGL7UTfSMqBoam6xcBIPu
	/Bnmdtw==
X-Google-Smtp-Source: AGHT+IF8q+Im/eAfEUO7BByYSL5hrVf7WPKlVrZ4EuZElIKWJ2NgKt4fjoGqRvhNPA5U4T+el0P+TgcMpebl
X-Received: from wmbjh14.prod.google.com ([2002:a05:600c:a08e:b0:439:93cb:ac43])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1f87:b0:38f:28dc:db58
 with SMTP id ffacd0b85a97d-38f33f11a5fmr11892492f8f.10.1739864688033; Mon, 17
 Feb 2025 23:44:48 -0800 (PST)
Date: Tue, 18 Feb 2025 08:43:46 +0100
In-Reply-To: <cover.1739864467.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739864467.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <7bb667b477a170d241288dd40b26210e08bc98a0.1739864467.git.dvyukov@google.com>
Subject: [PATCH v2 2/4] x86/signal: Use switch_to_permissive_pkey_reg() helper
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


