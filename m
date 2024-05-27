Return-Path: <linux-kernel+bounces-190085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A358CF957
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866771C20C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D30E60882;
	Mon, 27 May 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6XehCcg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6itJR44"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E26374F1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791905; cv=none; b=Z5s5rpjzvhL+OqID/rS6wGJBZ5wQVBbyAed64GnSB9HA3urybjkXxd09XznAUszBEPUClKiiIcOKaOxyn6nwu3Ldm0Galk4kkYSHOMlizJ6mVuv60cM9Xi2nvSwyFDrn1qYTF4tHMSep84Wuh0MNey7lfHq3UPYgfihVDwEN2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791905; c=relaxed/simple;
	bh=E2NKGH/rrfyJNZKSY6nFv6k2pt3uU3cBrXrF7Li/rpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9rR+PlEZKs54pTBTm85NvS7G9cI5V2kDL0+5lE4ejcHyzNH5JD/eFo+j6dR0PSC9eRTJYo/oc3Gt2lkNM/Im7j/9z6yDtE/3TfKCuFYp3t/LVvc6Dv2uGS82tviLSnR5UrIFltdds1YocTxgWLFacTg7++fjoRMKpawJeVpwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6XehCcg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6itJR44; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97ofN7IzRf8lwRnx1TzMt6u0N2QRUJRUSz4BCcorVpk=;
	b=n6XehCcgHhTwjYPGj0PiorRnBHUVBVBIgma4xQzqxFp3Wm8JsAn0F7j7p3L4NYhAFlzjBc
	ndNkrMmUcR/5tWwoY1xuW/f8la5KRQPm2InZ823ATSo7IJSB6q5psI1/rpPCWebLei9uex
	d2kIT+yaDxTh6nDwRxdbYalBapfNI8EugCmSZtgHQDtFPP3l6uIWybGbJ/lqEimZdVj73F
	w7avOxTHYvm1Yq76zTXTOAcGa7uVDKNRNTsDrMWv1z07nvClw3zY2E5+Lm+dyCuip9abLQ
	vNmJ8LUF8Xw6COGeXXuzoYgbmmeSVMDCUryJShSbVcazwP64GFpRukpWMxsm2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97ofN7IzRf8lwRnx1TzMt6u0N2QRUJRUSz4BCcorVpk=;
	b=Q6itJR44VPnIHYU8OgeS1CY8pCui22eWHBUj3zat0xWfe2BXOq+DFtUaPiQ03KdGCIng94
	kdCcgvZA6XE950DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH printk v6 13/30] printk: nbcon: Do not rely on proxy headers
Date: Mon, 27 May 2024 08:43:32 +0206
Message-Id: <20240527063749.391035-14-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The headers kernel.h, serial_core.h, and console.h allow for the
definitions of many types and functions from other headers.
Rather than relying on these as proxy headers, explicitly
include all headers providing needed definitions. Also sort the
list alphabetically to be able to easily detect duplicates.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h          |  8 ++++++--
 kernel/printk/nbcon.c             | 13 ++++++++++++-
 kernel/printk/printk_ringbuffer.h |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 831f95f26d48..6c1d01eabf3b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,11 +2,12 @@
 /*
  * internal.h - printk internal definitions
  */
-#include <linux/percpu.h>
 #include <linux/console.h>
-#include "printk_ringbuffer.h"
+#include <linux/percpu.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
@@ -43,6 +44,9 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+struct printk_ringbuffer;
+struct dev_printk_info;
+
 extern struct printk_ringbuffer *prb;
 
 __printf(4, 0)
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1c03508b90f2..5c75ba28e80c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,13 +2,24 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bug.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include "internal.h"
+#include "printk_ringbuffer.h"
 /*
  * Printk console printing implementation for consoles which does not depend
  * on the legacy style console_lock mechanism.
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 52626d0f1fa3..bd2a892deac1 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -5,6 +5,8 @@
 
 #include <linux/atomic.h>
 #include <linux/dev_printk.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 /*
  * Meta information about each stored message.
-- 
2.39.2


