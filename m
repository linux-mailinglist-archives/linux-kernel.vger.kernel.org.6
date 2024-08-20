Return-Path: <linux-kernel+bounces-293358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F148A957E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676D8B21FED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A821C199;
	Tue, 20 Aug 2024 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXXDjsGf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6lybofUR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3020FA97
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135420; cv=none; b=jNw0TCrkaHdxi1PUafsxO/xuIEKRhtNG3TNdCAK9P2wfqk0ey9Z6ih+eQDFVJX3QW3v/h8ebV7RRlOwsfAIC4J3fxpLlxjheBNsZmfjixIVKjhp3f16uJdb5JGWhCRzTVZDLeQHhLz6Z6NWX0estIBqNDQWz+Xi/0zwkpvhmrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135420; c=relaxed/simple;
	bh=T762D7RL3HakOl0umQsumJ5J9F3WoMpofuw07mkyUR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjN3n7k+xsxE5cunD+qlQHteyhHgNhg4qn+SJIsL2a3PqSlbFyi1NJd54VWQuaCSwN4Jz9xTOHkW0FmFJfn6GV9o8va/N2Bfa97Aru+YG6qnuEFdOkeZZtcfvvHsRJwDCe9JYhtvE9MhRDqNR/KdjjMKOfVX2/ke6dujIkLx5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXXDjsGf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6lybofUR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xlXU4AFmqPhM4Dj9J6Ku6slj372f0Acl9vi7a3swrI=;
	b=iXXDjsGf95Kuo/pJ+flFwlxW6OwL7YsRR42Zw/WimG290b+SNhtCs4w7b0pa4GN/4HwGtC
	IWa2MEP7S+gGwUcMvvgt+e4tKB473kzc5ShbPAmXJxqFSLeD8eM8L2QJDVsUI+OdNlWOZB
	n+dWmni4iiYw8jJ9t4X5J8gJ8nFM9CjYrKPe8a2ySdAmQ7hKUN55Yq3z8csLY3eVYdFoiP
	uuSkDUIZhSMw/PKY4pANGh2HXDdvwn999qDSrY6HKYrPpDfMiuYA0h7mD5XmSM5COCEZg8
	RbpTabzeDmAs6D9i1E3oWKc/V7NGHK1u93Lie8+5cW0/SuKHoVMVG99/6UmDgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xlXU4AFmqPhM4Dj9J6Ku6slj372f0Acl9vi7a3swrI=;
	b=6lybofUR9u4syR9zRZ1nvm9ifX6iCGSPyG3ypg8WB0z0tT0yFNT0xspTWEtZZlrdmzJOKZ
	ZXWXclJeatwrAtBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Joel Granados <j.granados@samsung.com>,
	Feng Tang <feng.tang@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH printk v8 33/35] panic: Mark emergency section in oops
Date: Tue, 20 Aug 2024 08:35:59 +0206
Message-Id: <20240820063001.36405-34-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
index 1a10b6e2a855..753d12f4dc8f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -685,6 +685,7 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -707,6 +708,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
-- 
2.39.2


