Return-Path: <linux-kernel+bounces-536504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C363A480A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6421189ADDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330E23BCE3;
	Thu, 27 Feb 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYeN2jNx"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971023A9A8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665009; cv=none; b=I9rsXQ18P3GCvqidOMCAeAzUQ3Hde4bMwONIO+6q13BUIc67g9IlzrKYxvnl56Dk6tAVELSsgytzOvoE3tzcFgebL1Rw4IuSxMxV4AEYphKnjVvxMje1U5O5Tmg7AckenuLd/9jY7MsksQkNmSd+jpZ26qKAZ07A+UEq0o9pwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665009; c=relaxed/simple;
	bh=CpsQ8gPZhCNNexBNxcXW/ScOiO2pyTQCoBkZQKi+y/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQm5oI9cfMvykHbv8eiyvUopF4Bkygw5ADODwzDyj1osfq940Fc/VNTVcQVZrp3n7xsevWleuuwPMO4zJei3nYPBsOw0Trmz1Nsr1lrxE5v1iB4VDc/zqG1m3H8TZIZ03Bj3qSkFN7eyHNF0Gm2m7SIIRBkykOioY22oJ9jrtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYeN2jNx; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e067bbd3baso886445a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665005; x=1741269805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNcMrV7t1QnfFYP1kD7TtFwTsf7x6jGURXQgshyNxRc=;
        b=PYeN2jNxq8l7jxLv1/NQgeD6n/gC/eDW0YLYPcw9cUyVZk9hMyoY6G3NZyYKpWgDOS
         bRkXvb4eg3kLaG/jH87augO/3SW3jWPdpt/a2/JN/CaPy/Cf7dMJyOdJnl8Xhp0odWS0
         AT4ZB9LBzIb+mqL4N4TVDcw3l5bF8wVCiapHv1Oyo2QknfG7YY7Y/T9c2r9LNDT5G7ge
         vu+bSFuDlq9ewEsNW+zMIZAaSWtikqKzZgsRbK/LiAuuUldmKxu8z3k7cHX6vV6ybVlj
         9Td+iuEja3+G9EEhm+PpTWSEilcqGJYQkpOw3xVysOASwKN0bMmDvCyRuhb0tdv8kudz
         fNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665005; x=1741269805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNcMrV7t1QnfFYP1kD7TtFwTsf7x6jGURXQgshyNxRc=;
        b=TBqVck2MuZoiOA6UqhKKIS6hSS5ghCjUAEQkm7l27Tfc9bR1hzsSXmu5rgh66Bjqyd
         K2jaCs2SElDf9Ji0rPIRIvGEfQgxeyVvvjsR+u9Jrx1X66XIXizZHQ0iqhxBiesRdJH1
         ei3ElfZ7w5fdTjEeREqnZJvROZohbg0K5mH7QnwiNI6J0EjdFYsHP8rj9XKPJAF0jVum
         QitPCfwosPG5tDdyvq5wzwb2Kk/jrQWqN2mTVzfF6qGn9vpFUsl8vSmaHyhkvDGdY10K
         bH9zjr0b7p1U4xjsrh7O9jEqncAIAl8vw3QUMSJEHNELFABwZ7Axnq84/JzTDVBBzsms
         /3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8s2VZDqTNCATp3b10Uj/kpdP9rYJfLSMSG1XU90+Rw0q3vN2CfRyw1rTyhZ/XKz83hGvpjaExTM4anw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAObjYFzpseGFkfJNRBNOpLZrxZuHF03PgKh03Oho0f/8XC2CH
	kjCAOEv/+gQTHjFbRnTJs29rmovT6ggRjChojQNRAJcUyA+8kyn6UqAmgtjOKtjPRmBfWSEH3ow
	1RZai+Q==
X-Google-Smtp-Source: AGHT+IECnDVAUP/qesMVuEzS6Zlg9/xWdmrOeegb9HOJzOIDXshJAI6t0Db6uyA/R2Zo0JsDUzdzaRhPLSfQ
X-Received: from edbio9.prod.google.com ([2002:a05:6402:2189:b0:5de:61a6:f3b9])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5508:b0:5dc:cc02:5d25
 with SMTP id 4fb4d7f45d1cf-5e4a0d71d15mr9506998a12.11.1740665005693; Thu, 27
 Feb 2025 06:03:25 -0800 (PST)
Date: Thu, 27 Feb 2025 15:03:13 +0100
In-Reply-To: <cover.1740664852.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <6873fab2d09be6a4254201391872daf0c455b5cd.1740664852.git.dvyukov@google.com>
Subject: [PATCH v6 2/4] x86/signal: Use write_permissive_pkey_val() helper
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
Changes in v3:
 - restore sig_prepare_pkru with the large comment and
   make it call the new write_permissive_pkey_val
---
 arch/x86/kernel/signal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 5f441039b5725..27a66a0697dd2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -28,6 +28,7 @@
 #include <linux/entry-common.h>
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
+#include <linux/pkeys.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -72,10 +73,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
  */
 static inline u32 sig_prepare_pkru(void)
 {
-	u32 orig_pkru = read_pkru();
-
-	write_pkru(0);
-	return orig_pkru;
+	return write_permissive_pkey_val();
 }
 
 /*
-- 
2.48.1.658.g4767266eb4-goog


