Return-Path: <linux-kernel+bounces-199821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3C8FA668
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679EF2864B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63F13D2A5;
	Mon,  3 Jun 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hrgq7isc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghjOLD7U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123483CDA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457098; cv=none; b=ESKDFjY/dl54GEYsm4x3fO0EtxypordzQrTMGPAagMBfmmxyrLBxjt0/ffcDle1HL7xBJdjftRh0FKtpRFJ8mHiG/FADri9HPLOpEC9XLuS6EsPwXflP0E4sZos24tzO2s7+L1MCwtAVbLh1yR/+eooUM4VKBHMTRMu4dwTVw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457098; c=relaxed/simple;
	bh=CoTDXitrRtg3CKYBOFPhiaN3QDoc7MLZcZ6bNPspfck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtK8pEyCQvJmQCLMvwh5VoSQjmG83I9REP2twPcML62ifpAaLPL8wDp9F8dfZDxMpHDZTV3Prz5FomXo/WD2uXR9iPANOynPUiQLyKjZdMeYa2ca6JpbAuxHDHzDMxZB2rw4aYeBB5viy/sBqe2quIDI5Q1BddMUi+3WEsJNUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hrgq7isc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghjOLD7U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O88lJwD2wns3puq6qL3k1pydNocnLUHn2VIM40iN7Rs=;
	b=Hrgq7iscYvfmYK7gGW1ZSeX3H9rKcAChumT5PRUonNJE2RGWhpAJuV0afVZwPi8iHs80lC
	S98zNxS5gd+Vx3algVCU+3VFOkDuJCROuYqRbgTZl91rYM1/dsz8GLtT/OSInNsycR8+19
	CeYe2qee+rF8Wb/sqV9+e7krEn64pARFymempzUDgdUIiUyCVi73LUbjfita6cF8maU3Am
	VqiFmmAswPYGn5ZaIdkHOvLlbaN8H8IoItLhsGjzEOcxnb+4DNexvA21DaBqJgSrnsS0TX
	1LwHebWUEp8FIRLdnrYu3m/4B7383U0WHyXudO5Yjj8GeR72ykqLUuctdpskOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O88lJwD2wns3puq6qL3k1pydNocnLUHn2VIM40iN7Rs=;
	b=ghjOLD7UlFmG04LeAsYE6SUgGmx+FhDrWVj4JpVjn2OjvmviUXFnj9PAnwa0fZpuQeWrri
	COl1GlrT/fLkN+CQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 02/18] tty/sysrq: Replay kernel log messages on consoles via sysrq
Date: Tue,  4 Jun 2024 01:30:37 +0206
Message-Id: <20240603232453.33992-3-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreenath Vijayan <sreenath.vijayan@sony.com>

When terminal is unresponsive, one cannot use dmesg to view
the printk ring buffer messages. Also, syslog services may be
disabled, especially on embedded systems, to check the messages
after a reboot. In this scenario, replay the messages in printk
ring buffer on consoles via sysrq by pressing sysrq+R.

The console loglevel will determine which all kernel log messages
are displayed. The messages will be displayed only when
console_trylock() succeeds. Users could repeat the sysrq key when
it fails. If the owner of console subsystem lock is stuck,
repeating the key won't work.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Link: https://lore.kernel.org/r/cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/sysrq.rst |  9 +++++++++
 drivers/tty/sysrq.c                 | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..a85b3384d1e7 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -161,6 +161,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``R``	    Replay the kernel log messages on consoles.
 =========== ===================================================================
 
 Okay, so what can I use them for?
@@ -211,6 +213,13 @@ processes.
 "just thaw ``it(j)``" is useful if your system becomes unresponsive due to a
 frozen (probably root) filesystem via the FIFREEZE ioctl.
 
+``Replay logs(R)`` is useful to view the kernel log messages when system is hung
+or you are not able to use dmesg command to view the messages in printk buffer.
+User may have to press the key combination multiple times if console system is
+busy. If it is completely locked up, then messages won't be printed. Output
+messages depend on current console loglevel, which can be modified using
+sysrq[0-9] (see above).
+
 Sometimes SysRq seems to get 'stuck' after using it, what can I do?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..e5974b8239c9 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -450,6 +450,17 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void sysrq_handle_replay_logs(u8 key)
+{
+	console_replay_all();
+}
+static struct sysrq_key_op sysrq_replay_logs_op = {
+	.handler        = sysrq_handle_replay_logs,
+	.help_msg       = "replay-kernel-logs(R)",
+	.action_msg     = "Replay kernel logs on consoles",
+	.enable_mask    = SYSRQ_ENABLE_DUMP,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -519,7 +530,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* O */
 	NULL,				/* P */
 	NULL,				/* Q */
-	NULL,				/* R */
+	&sysrq_replay_logs_op,		/* R */
 	NULL,				/* S */
 	NULL,				/* T */
 	NULL,				/* U */
-- 
2.39.2


