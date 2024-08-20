Return-Path: <linux-kernel+bounces-293342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C8957E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7880E1C22EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC81EB4B6;
	Tue, 20 Aug 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/uUHHV/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXaYfQFV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28581E4EF3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135414; cv=none; b=HheCV+opr65O7V6pguwV+teF90EeidpkAEduVZUTRhX/WZXG1335jqTrMJa+ybGenrafq5ali32P3tytNURfD9j9OVzBozbuLuGjv5WxPe77RLcVqIbfFy7nQiDL/vVXMW+kxH0ZRoxE24vLSA/+Jw1TX66BDutkTd43xXDJxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135414; c=relaxed/simple;
	bh=hXh/TJgb2s2zfy88CaQ5/PRIrBuFxv4v4MygOAxP0yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIKE5/BlSeEbFx3b78wHYE/ImDDq696Puqdvjt4U6QuJMZgNg/Rz8O49NAZ3Kg9+vpk94vRM3+NIx30oZkqrIUkCuXDUFgbU5Y9olDcA4Oz9KGyZUtHa0S0UpJxYCia9X+sHkiyTvS3wMw9tjl17o7nVpLS431eiopCR4DT57RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/uUHHV/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXaYfQFV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgO7+cd3pHG2MFQkGz4hwE9bO+9wd08GVla14v/2FVE=;
	b=0/uUHHV/SO8+J5qVZUmlg8qBk85kbVq+RgUZ71/rPjdSuXNXkIE1qh0DVCWhkyj0nir8Nj
	7eI7G8lYlSbSFKt0hlLiYB4ByJ5IwwGwATobwkHPuxGWvVo7CN4HqEJ4Yy5wyAjCB/bTHO
	iNYFzfEo7/K+rCtokajrihgCfY1J5WQ6WRJzNpZrmRFHukjL8t9CJvn1wdlFlBf79LGGCn
	bZajdn76T4LHFxPCyeYs36Bb1p4b5pwYVssqp5pmEUzfBkF9G2Ev0fXsGc+cqyX1uCIKme
	LuM/frxfWTZCxX3I6kCli0X+oxY2FTlQOS7EEk25I/Nl5O2USHtumujdCQGlyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgO7+cd3pHG2MFQkGz4hwE9bO+9wd08GVla14v/2FVE=;
	b=gXaYfQFVVXcuCfEZgd/vJa/jVlJtt7IDre8UJM2LmYXMTAn1z2djb85/U39Vup8jw6qQ38
	HsF9AfyrUkcjlLBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 18/35] printk: Add @flags argument for console_is_usable()
Date: Tue, 20 Aug 2024 08:35:44 +0206
Message-Id: <20240820063001.36405-19-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller of console_is_usable() usually needs @console->flags
for its own checks. Rather than having console_is_usable() read
its own copy, make the caller pass in the @flags. This also
ensures that the caller saw the same @flags value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 8 ++------
 kernel/printk/printk.c   | 5 +++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 448a5fcd5228..fe8d84d78f1c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -89,13 +89,9 @@ void nbcon_free(struct console *con);
  * records. Note that this function does not consider the current context,
  * which can also play a role in deciding if @con can be used to print
  * records.
- *
- * Requires the console_srcu_read_lock.
  */
-static inline bool console_is_usable(struct console *con)
+static inline bool console_is_usable(struct console *con, short flags)
 {
-	short flags = console_srcu_read_flags(con);
-
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -141,7 +137,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b9c8fff9a493..ffb56c2150b0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3012,9 +3012,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3925,7 +3926,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


