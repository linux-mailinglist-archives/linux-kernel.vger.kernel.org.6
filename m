Return-Path: <linux-kernel+bounces-190091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D018CF95D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29FD282507
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882613AA5D;
	Mon, 27 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xh5/Smyz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HR2wR2kd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B64779F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791907; cv=none; b=GB/jyRKHI9iEfMsxH32fVvONLha9VHTRvNiVfFxMmm4FtDTSbu8qKL63enEBbhSJSiZnMAUf4PyvmhpgaY0mdyg+YzV9xfHD3Fm33coF6o//XhMGv29WBkKUV7ej2gm75ejVrExMXdEf1k+EwxVT7761vL1HiyaQ8zhx5WrdXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791907; c=relaxed/simple;
	bh=Rezx37ZAMeSkcTz4eHSQoA8t3LwCmXbSpMIu1F4cxOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rs6zTxkp/xBNijfUccZ7bmHDmRYHEocM6w2ExQHXzwMP1HN+hBKUcUq24pbgfGR7KuEKLTF9sP9GOZfhlX8rJIHpw3nOXsKWivDz+3McCB+9/+eEbURhiYa+cQ86D2VsTa9tcAEhW1wEqhNbk68Smy/8rUCdg/YNbSuJQpilKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xh5/Smyz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HR2wR2kd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZZq8JTDc/bSa5Wad3zQxrhy3UUWwTzRNl4k7bMmCns=;
	b=xh5/Smyz66WOa5rKJmPiOQauOT3TqMznaWocfXJyjoTnOn20ZBluKATxijAWx31SM98ecl
	SqBftizzZ6QfVjfa6YrpqSLEkiJCYu7n72D12QXRkGLiEAeUknFHo10duRE3fQhtzcI2hZ
	emhdkbex3NHpXkZRYh9rzdyDfvGRlR6xvCJb6Usg4btYPcdY3jBpoga3rOArdX+178gq+j
	SZLq8QzKe639Cc+yJlqg1MfwCem1gOiBeSYqPIq01wfAaDH2agVTvet1x36yQI1qAUyxLf
	95N5N3Nija6xxSCIYBeRhyftoVI8s620shZBpNugFR5eNtc7sY8PlgC3wNTXog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZZq8JTDc/bSa5Wad3zQxrhy3UUWwTzRNl4k7bMmCns=;
	b=HR2wR2kdZJdN0Ly+eo6wZ27MD2WRMuHDt8faekNd9Wp5xD3lKzSLuJJyvY0pV6tWHUN587
	tJ/FprpFlr0qvrBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 17/30] printk: Add @flags argument for console_is_usable()
Date: Mon, 27 May 2024 08:43:36 +0206
Message-Id: <20240527063749.391035-18-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 943e8f083609..e2de2d262db4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -90,13 +90,9 @@ void nbcon_free(struct console *con);
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
 
@@ -143,7 +139,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
-static inline bool console_is_usable(struct console *con) { return false; }
+static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3947702b7977..2dd7add07b5d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2942,9 +2942,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
-			if (!console_is_usable(con))
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
@@ -3825,7 +3826,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c))
+			if (!console_is_usable(c, flags))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


