Return-Path: <linux-kernel+bounces-555795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5733A5BCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321827AA327
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72CE230BD1;
	Tue, 11 Mar 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k0fXGAxH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1T0THz04"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2022DFBB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686891; cv=none; b=QwnSgadLERTLv4MFEZVGF9LVnaOkfv0WlQ/qIsoYus7ivEz4TbVMSzE3MXjoUdLCO1YxvinOgtQ4CcupK8ZxiEO3Dm6nvkgMWPMedGB8ooCfcbwtSeb0vU18NKig708zBw/9Wrw0oF2dOXVV2yP9sNzFEBYGvCf/1qLj8Z7PZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686891; c=relaxed/simple;
	bh=Rm3gBLGR8rXFCWjh/nb0jAWcM8JoYIKD2NweN3Bv6Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tM4e4u6kytXXeV+47Rm5EZTtHSKJznPr+QYE4I3xu8l9xpH+RQ1NXRapAuDQm3P43CLrPizAZhtIABmav3Rah5Oj2++2EutwLRuEvhMFzK86lmPgSuPvvsko1kJgYx6f8XgCfAeS04ZRDRKSW6ns2OjfGU+bQjFtKAexMZQgdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k0fXGAxH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1T0THz04; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741686888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VncXVV+ZC0tAtxP77H9byPh6lcNjotXVQpIzjnPjd6Y=;
	b=k0fXGAxHhirNO36IKzdGKzs4kCvyBPN9R8z9au01D8rkJFwKAzX+QJ681NbrGsrdlmGx03
	3rCq/frVMCFjz6SigUHquDl9JjDFy/g9J69K6WFvNkff6az4NnrLNRy/R6fqE98XLvIZtr
	fziFlxnHUlSbcGYoPhwi1DPc5WEOqWzKaho/8rbnCywZqEMKN16/16EvLc9U1YrB3FpSVn
	ZlfADZFkjEBlpRHteypWZ+X2ca7cxoboTDYf3ErTP4Ynmogk9yxhs4u6six1D76kh4XjL+
	B1lCMVwIOYsUCJTYIHhZhDSpQ83JtSu1p0aXlyrjua5y56mrKQf+z3KEyvjTDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741686888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VncXVV+ZC0tAtxP77H9byPh6lcNjotXVQpIzjnPjd6Y=;
	b=1T0THz04y3ppvcSLYA3sTLbUJB0pO7ZXR928JaMnOB5eEPgqcWqUlTjcpBFcgAp0W8ql7N
	ZUCXZkMlROJGSdCw==
Date: Tue, 11 Mar 2025 10:54:47 +0100
Subject: [PATCH] timer_list: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250311-restricted-pointers-timer-v1-1-6626b91e54ab@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGYI0GcC/x3MQQqDMBBG4avIrDvgJLTYXqV0IfFPnYVRZkIRx
 LsbuvwW7x3kMIXTqzvI8FPXtTTIraM0j+UL1qmZQh/ufRRhg1fTVDHxtmqpMOeqC4yzPJ45SIp
 DHKj1myHr/n+/P+d5AQ+xiG9rAAAA
X-Change-ID: 20250311-restricted-pointers-timer-f169f21c3838
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741686887; l=2250;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Rm3gBLGR8rXFCWjh/nb0jAWcM8JoYIKD2NweN3Bv6Js=;
 b=ZnxVZ7dIc7h+L1662UMT1himsq4XryL+xOM6dH0nBHA+LFgScA5muVPTsHj2F+JsWp28KG5Rg
 /T90LwL2brXD2+J0f3NBSAEVudsc8jfK0xVrZNKne74J0knBeAX86MV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This reverts
commit f590308536db ("timer debug: Hide kernel addresses via %pK in /proc/timer_list")

SEQ_printf() either uses the real seq_printf() to write implement a virtual
file or vprintk() to print to the kernel log.
In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer, easier to reason
about and sufficient here.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/timer_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da5074c1cb33027c96638e68a606574a..cfbb46cc4e7613a3d7255b67a941dd05387cf68e 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -98,7 +98,7 @@ print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base,
 static void
 print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 {
-	SEQ_printf(m, "  .base:       %pK\n", base);
+	SEQ_printf(m, "  .base:       %p\n", base);
 	SEQ_printf(m, "  .index:      %d\n", base->index);
 
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250311-restricted-pointers-timer-f169f21c3838

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


