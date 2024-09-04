Return-Path: <linux-kernel+bounces-314963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2B96BB97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1721C22140
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EEB1D86ED;
	Wed,  4 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZ94VChK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cuh4Rmlz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638C1D67AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451542; cv=none; b=f3mzRLYHrDQNx+MUqAr5S8inB+GczriObp1xPAfVZbupGm7h1VERFb0hnGT6lySBAuidSer34RILjbUr/xnPzDcxW2kJ3WGkU2HP1jbjl1jholc3OPl1PW5S1QS2wbDtBuh/5YBpiNywNqZ5LBjXhU5PPi0MQry/YQj4drLD/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451542; c=relaxed/simple;
	bh=0PgZmc33n0ImzzEdrZmJFd94ixrtSDUtzS9LhgYwm5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8piZOMnnK80bMHknVs/a1U/BcZ8xXcd73nZjCezzBOiOKgv36G6QI9IDZ7uTIxueBn1Ff/zgkFl6zDXZE+8IpkgxHJzcxQGqziYj0QAx8X98e3fI4wydjcXJpawbeJQM3/VUyVliSlowqAqxo9aiuHZRAN+v2a4urTYtONR3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZ94VChK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cuh4Rmlz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADYc8AoJaMh9wjYacblmb7q1jgHolA4/JLzRo7pYcCE=;
	b=cZ94VChK3uKNYo7xAw7Fx1za2XP0AJ2JCCw0shAmr14rx7RPj/TN4bjlRuEBPRTgGm/Zw0
	0yWiz7gZJZTMmF8qRsQnrQxDCuCY7Fi9zsO22xUq38yZeWTurXqWTM6HKp8V3Q7iWo3oJh
	gLNrRk93l3cK98Fcg4Tz0WDjj1Bxe7Ll8SxoLRyGEKtU3aIJWNk0oIp8a9i5xP73ViBhj/
	nSOqJwZkYbrsqgMhFVHjY5Kjst9oH5e/Yijt9Tgd3bB9iKXFfz5kCbeNTyGYPnYq/qQPsb
	jPMlk4TreJlRhyIapIia8eN2EgOK2qG6YhWo7m1tw3WpmEwJFtJUjXsXk7WjPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADYc8AoJaMh9wjYacblmb7q1jgHolA4/JLzRo7pYcCE=;
	b=Cuh4RmlzGYDY2gat8KgCp3+JRMe2dQ+3/Tzas3TATZXcc4q5uTslQzNg+Z8+/aP2mlI4ns
	i268zst6Xy3Q0lCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 02/17] printk: Fail pr_flush() if before SYSTEM_SCHEDULING
Date: Wed,  4 Sep 2024 14:11:21 +0206
Message-Id: <20240904120536.115780-3-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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
In this case the pr_flush() is not important because all
consoles are flushed when checking the initial console sequence
number.

Allow pr_flush() to fail if @system_state has not yet reached
SYSTEM_SCHEDULING. This avoids might_sleep() and msleep()
explosions that would otherwise occur:

[    0.436739][    T0] printk: legacy console [ttyS0] enabled
[    0.439820][    T0] printk: legacy bootconsole [earlyser0] disabled
[    0.446822][    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
[    0.450491][    T0] 1 lock held by swapper/0/0:
[    0.457897][    T0]  #0: ffffffff82ae5f88 (console_mutex){+.+.}-{4:4}, at: console_list_lock+0x20/0x70
[    0.463141][    T0] Modules linked in:
[    0.465307][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc1+ #372
[    0.469394][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    0.474402][    T0] Call Trace:
[    0.476246][    T0]  <TASK>
[    0.481473][    T0]  dump_stack_lvl+0x93/0xb0
[    0.483949][    T0]  dump_stack+0x10/0x20
[    0.486256][    T0]  __schedule_bug+0x68/0x90
[    0.488753][    T0]  __schedule+0xb9b/0xd80
[    0.491179][    T0]  ? lock_release+0xb5/0x270
[    0.493732][    T0]  schedule+0x43/0x170
[    0.495998][    T0]  schedule_timeout+0xc5/0x1e0
[    0.498634][    T0]  ? __pfx_process_timeout+0x10/0x10
[    0.501522][    T0]  ? msleep+0x13/0x50
[    0.503728][    T0]  msleep+0x3c/0x50
[    0.505847][    T0]  __pr_flush.constprop.0.isra.0+0x56/0x500
[    0.509050][    T0]  ? _printk+0x58/0x80
[    0.511332][    T0]  ? lock_is_held_type+0x9c/0x110
[    0.514106][    T0]  unregister_console_locked+0xe1/0x450
[    0.517144][    T0]  register_console+0x509/0x620
[    0.519827][    T0]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.523042][    T0]  univ8250_console_init+0x24/0x40
[    0.525845][    T0]  console_init+0x43/0x210
[    0.528280][    T0]  start_kernel+0x493/0x980
[    0.530773][    T0]  x86_64_start_reservations+0x18/0x30
[    0.533755][    T0]  x86_64_start_kernel+0xae/0xc0
[    0.536473][    T0]  common_startup_64+0x12c/0x138
[    0.539210][    T0]  </TASK>

And then the kernel goes into an infinite loop complaining about:

1. releasing a pinned lock
2. unpinning an unpinned lock
3. bad: scheduling from the idle thread!
4. goto 1

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6accd1704e73..acf668001096 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3991,6 +3991,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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


