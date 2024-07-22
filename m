Return-Path: <linux-kernel+bounces-259244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A467293931A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E341C20FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0616F8FE;
	Mon, 22 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfVkQd6Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+Qjl5jx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044616F0E1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668791; cv=none; b=ZF+HuKjpXcqi7oRNfWWf/tdKvO6pEciEBiXUaEclUcj08lcLT/vIAvGK3znvYmP2EDOBak/+HgQ+pLk6H59M5shcCZohF9fb9r49Vj1wG93rgHRzv8BMqSkZP9wl4gI/qW26fmQbF4atybl3BJpIVnjex6a7dO+bU0I/EP0PaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668791; c=relaxed/simple;
	bh=5fcRvyfyT2XAVwhr3OseZVux1LLmXi29ZOKScT/5qJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkGzeqRXXJyGyf3WQJNOIU5tsbromgoHqMvjf+UENaRHL8le3vPCHuVeSTh6V+wclfVlYc2koFx/bL9OwHyj6JwgPdPpwtH1oVcKCXNHFiP8POqJiOtQWQylHhFJm71tGEaGqlGuJYvrXTkvDsrtuKu5t6A4gAhUdJ2c61EODrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OfVkQd6Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+Qjl5jx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR1ZCxr9HoxSs4tStLYm6lQv2PPsrt9cnd1Oqprb4tU=;
	b=OfVkQd6ZAzaq0V99uh651SPXzyUQ3DBPXzbFcEmrdb2R4p6Yqp3SzMjLjXg4jZ8VM8TKhW
	6zv1twNFtUUo9KCVVAuruazpo1csLqT4+1HTXzfDYTqUWPs5ngwzS2kZ+Fz/7Zkgz9jnau
	QaFlic0g8/N2hJeUg4aQW4zQo1Pf1GJtqRQ+FRtEq4t4xqKZRH5jW3kZQr7TVqzeRMZQ+M
	F/x4Dt1zMjEt6sqjITBGTn63yJbRzptr9YflgXoZeP/isl1E+yU3A61KfpkTlfR5DQtc+T
	AsP7/pBG/3AHUo/mEYmlu0SlqLcjRSdjtnnZSzhx6XR6uRu9V7Cw0/dKri4V5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR1ZCxr9HoxSs4tStLYm6lQv2PPsrt9cnd1Oqprb4tU=;
	b=C+Qjl5jx3dv2M0RQRWctI6hR2I5Mx2akH6a1TTBxpt5B/CUjxLufj07XoXfi1tcAYYpMv3
	uwhDQSIIMqpPwFDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 05/19] printk: Fail pr_flush() if before SYSTEM_SCHEDULING
Date: Mon, 22 Jul 2024 19:25:25 +0206
Message-Id: <20240722171939.3349410-6-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A follow-up change adds pr_flush() to console unregistration.
However, with boot consoles unregistration can happen very
early if there are also regular consoles registering as well.
In this case the pr_flush() is not important because the
regular console manually flushes the boot consoles before
unregistering them.

Allow pr_flush() to fail if @system_state has not yet reached
SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
explosions that would otherwise occur.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 641c2a8b0a09..39db56a32c5e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3946,6 +3946,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	u64 diff;
 	u64 seq;
 
+	/* Sorry, pr_flush() will not work this early. */
+	if (system_state < SYSTEM_SCHEDULING)
+		return false;
+
 	might_sleep();
 
 	seq = prb_next_reserve_seq(prb);
-- 
2.39.2


