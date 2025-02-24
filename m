Return-Path: <linux-kernel+bounces-529128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD5A42023
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7617AABE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A7243369;
	Mon, 24 Feb 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZL94gEUp"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03123BD05
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402777; cv=none; b=WvCHzr5NOJR4UXOD1aQ5RGs62KKlF6bB9oB7MHLQBfj2ymC0tQtf6jxtwrtapptA2TShKMFq3CCJlAcv7GAcr0SGp8QLgvPd9x7T9lbJ+/N1ewyCvN1+xrLgtS7yaiZeyLcNBDZLe4SMivY99VNG7Py3b57F3A1YBYwoOXeXYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402777; c=relaxed/simple;
	bh=a3V/FFglewtApLd1eXUZ8GOawNXesI+DyEgpf/StJoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RO0EoPov4M0zMRDnFjuz7LN/HYdnGct6dfnx+vJEtqzcaWLDtG4JyrD8GxizegGkNT2lAbLnd50eZyqmPPeyjQImUN/ySKQBEzYB2i2p3B7wnc30v1BVsaeIfbRnZkwH3ciqwsRTabOiXARFHJFkcxlvl/dacM4MFYEYK1w9RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZL94gEUp; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abba896add9so259969466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402774; x=1741007574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWC2YvY+2JS6MeWd1OOP4PbcYE661MYKY7foNV+9G5E=;
        b=ZL94gEUpaip4EKdIBCCoCUH6G+QVOMPv5CeWZ5gT0nAQeVhjNzwJ2kM7r1cVFQVSLV
         2N62UwNc3CL+Fx+F23REi/gEMcRBnEYUgp0VoedSMBcrg8RSP+2b3esb92kVtALsQrEA
         PjZaWuEsHEksu8sLHqpHVPlDnwy/barquolIKR8B61VNzvw5dEyEvG21xHaci+q8RL7G
         VfZS/FT+rNK84B4N9M6Jq4oZZvFajMmPCSQo+EwOsN2lzyxzijrGUgPm4sic8fFuGgWW
         YLHzfmvZF4Ig1YaxfddtpU2/aSEDDrAH6N42IyMju+SfmzGCm0VKtnG6cp3a1dGFUL0t
         7F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402774; x=1741007574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWC2YvY+2JS6MeWd1OOP4PbcYE661MYKY7foNV+9G5E=;
        b=KRVO6oF2lTnhnTb2MxbbVM2I/M2Uk1eDLMm8zy2VbuunWCUQRRxapcDELgffNIOfw4
         7qIFJbifnqqZ5kp8IBH1KW9SN7Pdq8fKu3U4JN2MP7Df0803fl8AUo+IckhT5w2tN/lo
         Vi6djn+S2TZXvHMmew/pTSjurjBFK9jQVSRQ2191a54rcO7bkGnj6BEYE/UZs7y22XMZ
         NXZ7LU9X+6ca3qxfmlUWWtjeXEChugL3lEzg9p/R60Vj5KLxhwyJpjvziNyxSMohrc3o
         jtDo2HvzHwxKxl8QuJZgtawo9H9UNQM5Hm3KcJH42zqWXr20LAWmcDEZcOJ+ZnL+NEcQ
         TgjA==
X-Forwarded-Encrypted: i=1; AJvYcCVvNOeLxm6zjLbgaAZIoL9iOcxnxkp6HVMiXu528vk6yIgO1AyP5s6sWwwYDt0MzQnl0J6MIszAXYzAHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OKlB/1QLuaD78DRw2HYWbouqT3P8GZL0IkQmHPBmb5KJROSM
	4pr/rxVmtB4LZR72KvBakcfFU9KqmCyX0VTvSqxt3eYUkX8WaS7EI6Coq8nHdCphb8TB9Wx428t
	rs2FQxA==
X-Google-Smtp-Source: AGHT+IHc7aQyhPQisVecha415sXaPFZpbgffa5QjwD/w/F3X2zv8zEfvJ5pslVrvzxvvLaUaR66QMZ7fxZ4O
X-Received: from ejctm15.prod.google.com ([2002:a17:907:c38f:b0:abb:955e:86ef])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7ea0:b0:ab7:d361:11b4
 with SMTP id a640c23a62f3a-abc099b7f3fmr1488001066b.7.1740402774098; Mon, 24
 Feb 2025 05:12:54 -0800 (PST)
Date: Mon, 24 Feb 2025 14:12:29 +0100
In-Reply-To: <cover.1740402517.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740402517.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <2a21bad1eb1276038a3ecee507366552ee09e147.1740402517.git.dvyukov@google.com>
Subject: [PATCH v3 2/4] x86/signal: Use write_permissive_pkey_val() helper
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
2.48.1.601.g30ceb7b040-goog


