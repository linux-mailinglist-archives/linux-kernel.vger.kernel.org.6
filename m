Return-Path: <linux-kernel+bounces-529146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A776FA42064
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE5C7A2B16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD866248881;
	Mon, 24 Feb 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WJCr2aw"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77728248862
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403270; cv=none; b=qUE1b+1Zn8nTDKXyDkFF5Vh0MHbN6DZmwHp2H9XAo/yY/rZpPMS8lZaG3OrmQd6oVTt2fsI2X8hCXUBC0M2mRtVCv3sD2bgJdwsAZmhArB8RrCXPRDVgS+tUJ8na/7SCNjehdckqcKTCV5OBStLD7Q7TDdPUDOeOv+GQZK2OS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403270; c=relaxed/simple;
	bh=a3V/FFglewtApLd1eXUZ8GOawNXesI+DyEgpf/StJoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8UnALKRnwBw0xarUWU08GVcRBQN9gacZuiQnp0ozgt9CWBRU+NJffgFYhho+kcFa2kV2a0mQDEXoTOvNQOqh2WtfRiiRy2s3Zk74/PuqJnFVKU+saHhUvg9mEcqwA1CO39UpmlXsHacTuZh35Kf0rdKjUkmEhlYAdBgGGNK7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WJCr2aw; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abbaa560224so420197166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403267; x=1741008067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWC2YvY+2JS6MeWd1OOP4PbcYE661MYKY7foNV+9G5E=;
        b=1WJCr2awJDJWuwf90fSqxTghZo1r2NkeTofFin/As/hX0YA5oA0bxHtzMyGFPxzjCo
         yoNslCKsKay/WPuF67HUnCeZQL8tr8IRWy6/KxP/qpsgGsYUtpd2rTPs0LJ5LyPHefm3
         ox9oMRQeaIrwEUUcbff8ypGot7vYw9A3y/ZkWu31EaOqr6FpQn89HJ3yJDiXyFzVGHjc
         5DcpXpc0iQifJD4S53WN5xw/E+LEAGolPGbcVFB6V+26DiFAy1/uz3WwdDUPG4Pn1hyN
         Kn1tzxfoNpVtEPgxhNHx1vJdbceJoWZ9corIw92ci7Cw/y34WC2d9rpj025MvNc1EIfB
         J/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403267; x=1741008067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWC2YvY+2JS6MeWd1OOP4PbcYE661MYKY7foNV+9G5E=;
        b=UndGxPOqwjMsOXAEAD1b6CxpGRP6FFp+s2PiEoV4Rv7F4EjZRF88aCLFxzqXQ5MwER
         I5o9uys8NJ7vO/UEkLwJWaBM5iETASUopFnv8SXR05wCU5VOkrPQWS4nXRaYO+7MtYBX
         pyMPO+9AFf+M41t838AwxjeRBfFKOMq6II081+aFDhJE9iVNHAQaSH76bwTma4RyXzkp
         FWYYjLwIQHdlNCHgcp7DsDNY3gbQ0XGzvkCxbVpiiKru/jYFqkKIsXD4SB9IAl8y9b+P
         2OXEJPsKRouU6QtULSWQT5RzSX0r3twfzSArdasHDDIZJ8RMJpC9GSks4/z9wX5iWHKV
         GkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdGRCSBMkECzIU6j1ASFBaX62vvBHMx3/bUJKU5KiRxLEHKQFeJvcn9mdEPq4nAXssEblLY4HEKCWN4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJxnUeTqN1R4qP0A1J+ynoEiZtJTPrMpktK+abwLgh1Jw28wL
	D3kXtwDjoJ4Tuq7KM2eDFZDW4xD++2IirlYL6D/ML8UvRMI6OdiUeejbkgzm/fGKoglpireBXEp
	c4Su6vg==
X-Google-Smtp-Source: AGHT+IFZGE0opUZ/Dkxx5K6GjwIKo1W81biuw68NeoFjgZElaZoi12rVvwjpZj3mpasLl4Vo8Kn+Ewsf/hAo
X-Received: from ejcrx18.prod.google.com ([2002:a17:906:8e12:b0:abb:843c:190a])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:3119:b0:abb:d04c:6947
 with SMTP id a640c23a62f3a-abc0d994a14mr975575866b.8.1740403264866; Mon, 24
 Feb 2025 05:21:04 -0800 (PST)
Date: Mon, 24 Feb 2025 14:20:46 +0100
In-Reply-To: <cover.1740403209.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <85372b646f6d316e38578632cb4678f8ce724b95.1740403209.git.dvyukov@google.com>
Subject: [PATCH v4 2/4] x86/signal: Use write_permissive_pkey_val() helper
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


