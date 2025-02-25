Return-Path: <linux-kernel+bounces-531525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A1A44185
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E1E7A62CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B9270EC5;
	Tue, 25 Feb 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPVD7ypB"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1CA26AAAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491650; cv=none; b=h0GhAO9dOudMrQ1NZ+kTppK6sdC8fTkQqVhhp94WpUuR1RW4L1t/69MUDQJcWF8OOpTNzfEIk36SEkIcvb4+jWYbOfxNTHxY+g/+nfVIYLHcTsBU0pOcvbhic88VuB0fkyqJ1KzHytldbkd9gKm3gt6xuHv2ru28PiwvyE1Ttvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491650; c=relaxed/simple;
	bh=CpsQ8gPZhCNNexBNxcXW/ScOiO2pyTQCoBkZQKi+y/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OfhiWawtXT1gV7dF1V5eGfX4c+/C25aKcVOD+GCpJyYp8ySw+ylM1pzJD0yjhwr0Ds34Rm9Cy6kujR+qEehm1PovXzdnBowI58VS/PnD0wi9NuaT54OZn0Dsilk8yUL2CWNQnWiHmE/imHF9kQugOW4q32c5YYDkcUVP5CRBdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPVD7ypB; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5de5172cc5bso4811072a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491647; x=1741096447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNcMrV7t1QnfFYP1kD7TtFwTsf7x6jGURXQgshyNxRc=;
        b=dPVD7ypBEcH2hIWK8HjU8OU6luGYHfP7Yku1IH2wB+ElYfHrExF6rwRTLhM2YW1k7I
         jCGjq6q90FyfixiogqD9EW4ZC6rpyzPFd+ml6smtujYKAVCb76KRC2WKWfv1lops2mhh
         rcK+omkfqTBTWGnr0c4dhJsflpdxcWzg2wWgxcq6PpO7f7p30P1Pgba3Fur83Fp2LmXS
         hinw7qBDGwZqNGN+K3uLdNYCI10DnqdAQo2FTlXWJfVzX0mnJgZFwHxNCFmuqkxxTpTS
         WRT0yWli/tUgQ/FcpWxQOE6iQhxTuqxVke/qnJWc+4evrOqkx//BOMCngZzjr/0yC6pd
         b7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491647; x=1741096447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNcMrV7t1QnfFYP1kD7TtFwTsf7x6jGURXQgshyNxRc=;
        b=lezDXZ1PG8xluB+EuFzwTEV/aKGUPSpcuvqJgOL1mA4ZgkqvujvQXTmChudchjGOr8
         pKmW2UIUnJLPToYkKR+YEs4XhF2NMczQrLcwrtrjPY2AeVEIRAmVsK07XM4HDAUzRi00
         OFmuTLEC3YRGFL064nQRaF/TCY6yITOzsrna1IYKBoxybtd9/piwsSERpuMviMPpxVm2
         yQuf5chxkyRZB/t6yGS/9uy8Bxnfzydrsc+AjYiPXNR/LiBaOQQvRTz5SM5ynKABIAAG
         gkunUik94L2YQ3IkMXd+3r7D0LM2AmihhwjSZ2HISjzc82AhZDP3ZnXG9qm5taqFx5Ep
         eUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWMc7gf7+lukUZKU9LkK5yvhp0H4n2HVct+vsvM/FzEgvmAIBISRQJIDjvB5LX/vfF2fUklBrGzuF6d0/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ElGiNgtEidSuIfNj8Qz5ReWaZRfKiMkznCcojAroDiMIch4l
	vmr6mLTZ65AHPq/eZuMVhZhg768reKfthyWMGfloGIQEYfT7HrQK9wXuYbTclchI4jQfnxmbxF5
	Vauuc9w==
X-Google-Smtp-Source: AGHT+IFxodJDTXypywDkt61TczRf0gGeUjt1+FG8Dyr0eG2KGB3O90aQZqb5frhvH8jrUSKxouqiQUQwpBM/
X-Received: from edbij26.prod.google.com ([2002:a05:6402:159a:b0:5db:e930:604c])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:210d:b0:5df:6a:54ea
 with SMTP id 4fb4d7f45d1cf-5e4457abbc9mr8775424a12.11.1740491647399; Tue, 25
 Feb 2025 05:54:07 -0800 (PST)
Date: Tue, 25 Feb 2025 14:53:44 +0100
In-Reply-To: <cover.1740491413.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740491413.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <d0177bb8afb395366b0432c3541a1a83ba4431fe.1740491413.git.dvyukov@google.com>
Subject: [PATCH v5 2/4] x86/signal: Use write_permissive_pkey_val() helper
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


