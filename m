Return-Path: <linux-kernel+bounces-273639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20C946BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C7EB21CCC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE83821345;
	Sun,  4 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbyjMvhf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7TnVgsb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325971B947
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732716; cv=none; b=ZOmf6jiCp6hAX+22eCT3dvlcgjC8MpBtWRSZ3SoNcay6C6OkaXwTOX8w4iPfdugOZ0POeuhe9ZLgHUsb1bl50mhIKYsOzXmmSGFoPA+ilyFTGcSpKebPlY7IB8HTi6Ws2ylv7ew+LooNUGy0dGJczb+XWzkDGNx0Hk56IUn2+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732716; c=relaxed/simple;
	bh=G+xWckYC4K1B7DC/KGSgacVTp49duoqdbQIL4F0uaCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFf6tx7U6zbf2esXGpG2LxOxn4491uJdRRF9hIfhYb5tpJhJzwnW+Nmp2kBrKf8gEtATkDJqxGOKjwBf3yFGLdVGoBpoXR66DJL19W6nWC7hbAylgNhwEJhxkwsUaZQ/LdzYQd3Ql6lbbwyQXXdgsP0cdc5zP+kPX0uxkufSzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbyjMvhf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7TnVgsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6M8Gq7LSZt3yh7g7N/GWSaxKEw70meerv1IlbLtxnbM=;
	b=sbyjMvhfevmG6byImWqjZy8X+b/mMUdRs+DYWi36RMorpZobUFurvFq9WXMuBSAIrbxdL2
	uAjSpaGbb93G0O1kvyQ2fcnhCPoraLeNsMKR8Rp+S3QZdFX6ZcwVR/YinRHLNvhVdDrHiv
	Xzw/uk4w3G2mNm6PzpoCQo1iv4Q0gqAqXbIrtIj6oTzNsckUSSkt8RRLof2d+us4UhMGvt
	DHBAGsw3BN5UvgN7VGiw5hd7pDdGrFWVAuy8YtQn+NdaMs4v3/l2Um4Hg6WJyvmZvZcgU6
	/TZ7otggtJmkKf0aWkSWsczcEdleSWthffbInqVOLT8hOhid0lM3TXIDhTV3DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6M8Gq7LSZt3yh7g7N/GWSaxKEw70meerv1IlbLtxnbM=;
	b=u7TnVgsbbdFDFGeCT1uBrfcHoOiN06igilwyvAcln53H2xLW4KSWS1IhFtdTSM0m7ptrt6
	prBn5ogojZmTLIDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 18/35] printk: Add @flags argument for console_is_usable()
Date: Sun,  4 Aug 2024 02:57:21 +0206
Message-Id: <20240804005138.3722656-19-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
index 5a1fa8eebe5a..92703249221e 100644
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


