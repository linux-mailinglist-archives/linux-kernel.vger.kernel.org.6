Return-Path: <linux-kernel+bounces-273651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A501E946BB5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A941F2462F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93813AA36;
	Sun,  4 Aug 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3EnH0wFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0w9d3/wB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599311C20
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=KOHuSuq8Qxfh0Ii37olNdfgvtBWA2AZ1yHvLpPO9rxgW3ShWKHbAtp3A7ebWjgGUoZh4mNQtcRHwmdnR2W5jQWviT8f6ybXhYXBCCdQ32mbsXFq0Tuet17O4s0C3TT/buV1KmQqzyALakEjA9ifRF1geoG5mFiV5GZBQ6MCh4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=I9k/HiJhGT4AzKbUgrNWAomwSzWWBar5d3qee4ryVBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qczYaKiM+dmrzio7wqX3MJGkh/VzXscAdTCuDy7aKiIzh7odK2YO3rPOspHk43UaucHrx5/axlHamzW/gYEBB9TObGp6VGd6UfPKAcnEM9djyJuDvUQ9vPMOypLlFHkkKODSDhwix8P0Lbvjg1CyiwBFe4yiTXn8uqS1P47WnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3EnH0wFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0w9d3/wB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdD8sHomyUtD7cE6/iBYkgE6+sjyvW1hdczecD36oTg=;
	b=3EnH0wFwdXjVWyBIftkK4XYAobwfRYg+4OecaGuHLV3YGVPGIXGf/AIW5CxJjo/xY3Dw5o
	Wmy9OC3fsK6gnXV0MEnEogSLmBVOEXonpW/TiEZVqv8eAd+NyIhCIHG1Y2T9R9Kh6lXDm3
	cYYF/WVM4yJmFZ8RQV4q6V1xxODaiqcnq2AKVndVwPZv4XdXpSWzh/f4uV7k9uy+uY6HNG
	SWHdN7cZmqZDEjOxDx+gKs8Ho3DiQgdgWOroWYPQ3jeUXrqoU4t/ms6vzmwvv1tbea+iFa
	JLW00/T4TpxwV1lZRRTeMUtVcc+5xDg7UDB/70d/tci5BSllOKbV0HWAPmbilg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdD8sHomyUtD7cE6/iBYkgE6+sjyvW1hdczecD36oTg=;
	b=0w9d3/wB/iHjcY5UNd/bMc9FL4wQx9gUYjQWLhRN7S23RiPC9Onfg/jH+mJOkgmtgIRjcP
	QsVQtho8Bc3pr8Bw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Baoquan He <bhe@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Joel Granados <j.granados@samsung.com>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH printk v7 32/35] panic: Mark emergency section in warn
Date: Sun,  4 Aug 2024 02:57:35 +0206
Message-Id: <20240804005138.3722656-33-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Mark the full contents of __warn() as an emergency section. In
this section, every printk() call will attempt to directly
flush to the consoles using the EMERGENCY priority.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 84488daa14ce..5fc44fd3b3dc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -712,6 +712,8 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	nbcon_cpu_emergency_enter();
+
 	disable_trace_on_warning();
 
 	if (file)
@@ -747,6 +749,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
-- 
2.39.2


