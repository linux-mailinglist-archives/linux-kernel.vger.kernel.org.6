Return-Path: <linux-kernel+bounces-273654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2B946BB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137001F24FAA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516D13C9D3;
	Sun,  4 Aug 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4uNr3mt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yk+sXboT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0A28DBC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=GcDpgSlYwLZm/sXe7JFO8EGAFLirxl1gOeCMDJu5jSguZ0495rGtnbHzKamytYMXCGElvE6eG72nUFc90Bd8Vadiu4oQTzzz+pJ9hQuX89COKJ0E/Gfggu/KYRaSwfsgBqJfisf7yttN0eULAq+YdJyhiKvptnGAk8fco0MMJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=rx8JQEOlPSXSGgJH/hN1890GlKdwGsxBTv9ERQw0ehM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC5TPPFw1MgGdkVip72+tE/RugUFDV+Wtqu67IsouiKsTOV5Q4zbvH3XPTiCTZrGE1vLD5pJzTAYUU+ZhtgR2kSwyLVtns1dln8+Bhznzb9kkZZbLhbNlwPo/asku085dwAyzFbkGlij/vBPanBPJJBiUm6X6AGBmp4f76gR+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4uNr3mt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yk+sXboT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtyMYwpXcYpG7D03C8lxtJgU1iwrqHDYPSpb3n5f5II=;
	b=A4uNr3mtns0/fwdqdEI5WlnXILPV/noMt9yPjt5GUk0Bg/oVVlGTF1NJb21A00XooZy/iK
	CmwplsYrkoIwfBgujIQUsfH8cHhdJvprCoYS44zkK/kFYou9HeR6KTMdD1IUR5TglHijgS
	nZ2AzeJT0h0jmAV14fE53QP8wvoBM/gSyhLBwiW2DBfBCImBOn1ZuCzCqjl1VfGiEcFLu9
	v/gUANqD+cF8stT5FFZxyNkuH7pQa3fltks1QuVRIPa7VS/Qrd4iHYzgWpQgHrpkdrSNea
	CW3thc28KWhIiW15Yq2ht3NID3x7FQctfLWIO8dcMU3GYelTvnRky/xltVcADw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtyMYwpXcYpG7D03C8lxtJgU1iwrqHDYPSpb3n5f5II=;
	b=Yk+sXboTJ4zsgdoLYQgpkav19TY9wl/aprDYzF0yshY31cX7VQjpyYLtjmhvq9fMofbRMo
	NPs2gEdS51gwcCCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH printk v7 33/35] panic: Mark emergency section in oops
Date: Sun,  4 Aug 2024 02:57:36 +0206
Message-Id: <20240804005138.3722656-34-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark an emergency section beginning with oops_enter() until the
end of oops_exit(). In this section, every printk() call will
attempt to directly flush to the consoles using the EMERGENCY
priority.

The very end of oops_exit() performs a kmsg_dump(). This is not
included in the emergency section because it is another
flushing mechanism that should occur after the consoles have
flushed the oops messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 5fc44fd3b3dc..0843a275531a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -679,6 +679,7 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -701,6 +702,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
-- 
2.39.2


