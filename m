Return-Path: <linux-kernel+bounces-341477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F8F9880AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D312B1F22439
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793018B46E;
	Fri, 27 Sep 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeQwRBOz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+Jn09j0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BA189F4B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426930; cv=none; b=LObtSj0VK5NRfLG3c3Bz8ko3OlHqGGSTl5xsoJcUvPeTJP1+aLGzhomAzAypWXjpjSin7UR4IoWKd4LHMHhpl/vfWfn2WZr3/3W7z8vYEQarxfz4qICyyIIT+d6s3IFrgMBz18g7yMvhhCsgFzTSWAQg84R3CDOdixj66RK8KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426930; c=relaxed/simple;
	bh=2EY36ZPw9Bk/FILeYTge588GXUMBVDbi+K7dEpepmeY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ulKDz6Ock7IRZ5cvJWCjtY0oY6IJ8GV5GIKWKqQE/rC/UyF577ZJbql9butn77AaKn7AdTDFx/T/UbYuwOmPoFrAkU2EdgneUpGFUYQrt/OHslxyaDJPD7fNiIKH7bzyc9AUHnjO6uoXGYXbZdSfDQdVHIz6KgAOVr5uU+KfIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeQwRBOz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+Jn09j0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.014903652@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T+btbZAWH26XQNm65rNe9WbaHh1YRJhaO/jWuR8/ACU=;
	b=EeQwRBOzS+25vhB1Ey0RULol7GE27wkxZr3vTFlSfeh0VKeqcgmlyiLsByGcSJaQVmy2V0
	hZiSy060fcSeRZDiJHzYW7rLL2xnJZjti6jlHaWbOEeI1cxfq5ItVjmmIu0LxnSHQjQAee
	kkjRCEk6T9ZZKBcPm7iFvXQ06WyHZcyghMprJqx2NZGw0At0R1XL+o7BI3s8Vvzd05Lkn+
	fVrF/b9MIL3uNmmkAkxaMYkpLFHTCe35M0cc3iyancf86hK+bzLZZD1xnhb4Trbb0WXjx8
	AUmovWM+VagVibZmiLfKr3d2r8Jt+YiiLK2lKlVjuuMJQUeAi8E8In0tUgqW2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T+btbZAWH26XQNm65rNe9WbaHh1YRJhaO/jWuR8/ACU=;
	b=b+Jn09j0O+akSHWGtgH9AWFKy7siUkLKoBTbo32rlz1bTMTiqinIaiNpNYThAJd8uIKhiv
	uTcYpjRKrwJL1KAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 02/27] signal: Prevent user space from setting
 si_sys_private
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:41 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

The si_sys_private member of siginfo is used to handle posix-timer rearming
from the signal delivery path. Prevent user space from setting it as that
creates inconsistent state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 8 ++++++++
 1 file changed, 8 insertions(+)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index a83ea99f9389..7706cd304785 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3354,6 +3354,14 @@ int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from)
 static int post_copy_siginfo_from_user(kernel_siginfo_t *info,
 				       const siginfo_t __user *from)
 {
+	/*
+	 * Clear the si_sys_private field for timer signals as that's the
+	 * indicator for rearming a posix timer. User space submitted
+	 * signals are not allowed to inject that.
+	 */
+	if (info->si_code == SI_TIMER)
+		info->si_sys_private = 0;
+
 	if (unlikely(!known_siginfo_layout(info->si_signo, info->si_code))) {
 		char __user *expansion = si_expansion(from);
 		char buf[SI_EXPANSION_SIZE];


