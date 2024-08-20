Return-Path: <linux-kernel+bounces-293326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B7957E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12031F22DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF881D6191;
	Tue, 20 Aug 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnS0g74o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7ghOinH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1616CD00
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135407; cv=none; b=j79J1hdDLesmLSbFfDuEoP2qsR9f/jheLS8oJ08yOPLpZhWXQx/R0nBKr0varlNHQVzF40OFS9lyQMcdBaZO7ZiqyZI6QlvQicC3GKMmGrZSszSlKjJm9cx1yIvZnenGbD1dvg3oGEoyrgJbIGLE7ed8mfesLhvSe7lzdeo9Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135407; c=relaxed/simple;
	bh=ZYUBmDxg7ePJbHOjwyADo/mbYkOqZlxjeOKTOHdyR9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cd9qcCcG1zs1+H4v5rhaenBwLA/gslx+Z89kc1rwlpL8WgK6wMdX2Qze/bmCIj2JxykJ9tOUq1cysvfkNwdYV+oJfhuQdhngTkzKQFSoB4DIDlzGjt0yFFCDLyPiBjXDQOj55WkwGgduW6xty5q3uWXUjFeQe5E3V+ueBCcjOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnS0g74o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7ghOinH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyxhA2yQeFACcIjjC6BqN3470f9eUfds1tAO0rXMmaM=;
	b=rnS0g74oxhksb0S7JButoYmOJyMBxRSW+jo4X2iYRuLUW/hf/6qd4r4TpXbsEjN9VZJqt0
	U73XJ7Psu6bpc9G+FivQHz+M3B2AGDs0IptTNamq8RPWWq7zQwAaCFZ9Gpgf4uhgVD1eGx
	u7mwHUPOnFHYIZVYkAzZv18SPmqGxSIou1Hfb8+CF5XqDCah24Gcj7gvXU4Wdo2blaF4fJ
	9qKLHUNtwCXl19zFlxMFd/fW3V53XPC8AJqVrhjJ7vmOI7Q2Jqq4yyVLRSmAZnjQL0YG8v
	afvXFAeB98IKiJ/tKgpT51/CuBiq6Je7dWoV7E7jW//qj7NBXehoSFDX9ND7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyxhA2yQeFACcIjjC6BqN3470f9eUfds1tAO0rXMmaM=;
	b=d7ghOinH9j4GehWUysIwg22nMnbRzVDqw1iL1dO9x4r2W5NKoB+1HiJ2wWLebuEAhsD2xJ
	uA9VZCNtV3/V8mDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v8 01/35] printk: Add notation to console_srcu locking
Date: Tue, 20 Aug 2024 08:35:27 +0206
Message-Id: <20240820063001.36405-2-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c22b07049c38..93c67eb7ca9e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
-- 
2.39.2


