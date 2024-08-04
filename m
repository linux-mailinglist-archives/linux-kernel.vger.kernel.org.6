Return-Path: <linux-kernel+bounces-273622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A8946B96
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066EA1F21BC6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7725A6116;
	Sun,  4 Aug 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgCkTVh4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="djcNaRff"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF8ED8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732709; cv=none; b=Bg6SzhO+VNUxMYTgFxkWyOIw0/qPmseGPqN9i8WG3NlKxOOkTG04zwncqpycm84hRYV2diLjG47q9PiAaB+5mVQzabSlrGHlzz6X6i5kjnUlzzaadmwlvgFNWouNfHopVCk3DDEbDY6r29xOjqQ2UOoPQYIf0LY5jN7GBaqzW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732709; c=relaxed/simple;
	bh=H69UsiUEtXuKfzx02fwPVHJdeRXFRg3g9GG5RzLVsHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoHiJqEvygGqs7oWXklnGZkP0J7g9aeljyVPORvJY4unHgK1vBZqcj1mWrS7O7IJ28u8jaeTkpWSsxwuJk9LCN78N1M6mssfy6dojsEBK5bs7xLNCPLrLf98zYFobn2O4O9cQLh0IY/me1sbEqhbkhaUXqhXdTMEt1DAxgS2b3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgCkTVh4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=djcNaRff; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3vsoG744Bgw2LY+AobLGckO/izDyansqZqQKin4u6w=;
	b=mgCkTVh4J4rt8N4iYtRzCM5K/+gMB6l2E+k45g5esGHGVlSkPYBsWEkWwlIx+NYBU6KKph
	ZtL0aneL5BIW5a4xGaYr0lcfTu18HzHBhtmT3EUSNkZVn+yesXc8MGV/G8oyD1XS5ZZGr5
	xlxtrTE+oxdPQtQJN0waBX1pX0Pdzr/kdkbux6oPC9ICwnVoqs/MKxa9gssYPezzSNZW6A
	D4De3mEY0nWMccNmHAvu/+9ryG5ge/TxmtcRMcVdDb43ZEEWGZVoWIGMgeh2u21Yta8T5W
	9Mi232MFGkioPXMQXZ/b68/FKZL+KtqxpVdmf+D66ogSUNWHL6YMUhJNpVu9Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3vsoG744Bgw2LY+AobLGckO/izDyansqZqQKin4u6w=;
	b=djcNaRffnbrRQ4EgDfQOb3HESfCXalyw4U+tZPllzPfP5zBGLrPcsv5WJTZ2AUQJo43Nw3
	/hLnktjhzA3BNlAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v7 01/35] printk: Add notation to console_srcu locking
Date: Sun,  4 Aug 2024 02:57:04 +0206
Message-Id: <20240804005138.3722656-2-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
index 054c0e7784fd..b3a4c0363a96 100644
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


