Return-Path: <linux-kernel+bounces-213237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C649072E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95C2B216FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC631411C5;
	Thu, 13 Jun 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a2KZbYlA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD451292FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283147; cv=none; b=M0JzkHjxJYD8DEvIKEHBO2KbgGOzudgMJoO3fv1CDoKy7jm0WTsSZqzH+SQ0i4zHXtt37ghZyfKcYxGbWDgJ74ZTEM+jV+usJ/xyrkyDiDY0rgioKGfEBE72gJQqaNa7LKbgeIJq2uKqHrCGpGckAreW5BHTYUW9Hw+ZzE62yAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283147; c=relaxed/simple;
	bh=NA3PjbIsvkVP6oyW+v2/NJP3I64AqTP35xv/CtDasdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5+aIADCfMigIBZ9YxF7t6KQtcZSH3ckAJvVy77EW1burWaiYEEqP3Li48NvZeLd6HTv5i2nX0EMyqRiDltWd4cd7CA9BZDefpGaDHVea7H6pkuAmptfto0ZKne8INR0t/J7FQcC3+u47IifahxRNNQbpkWxxm2G65FCppWghHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a2KZbYlA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so1042189a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718283143; x=1718887943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T357LYYA15aS1q2me6EjKOxnbZxdtMhVzXs26oLeXg8=;
        b=a2KZbYlAYeTwnopKtZ5O1q3+9XcYJfOBsHUIR0fkBLFOmng5w9HJF7MmpvhJtfiP1/
         iQA+WXs6KMjtXK6SYk7xbDrsV/mCCMPBzIBsUMkulQRrZiNbQhnELrGByN7RkDiAzacX
         cwhWJtfWUalapLZX4MMtDQpxZeBS8+8l94lCIxOzWuDSScVQ/+aG9fl2igpMJF/f2Ptn
         xqHdeE1cljr1TTVVIesCcK35dCa7FHe9/Qh6fbXksrM7H3DyP6tx9tcBRBAgX3kK7vfN
         9DPcuYXLzhUh8U/2lOjBl/Ov34bANlN8oOaRFy24mPjjAu8oKy6XZ9HfPqBRuqX7mWL8
         FpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718283143; x=1718887943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T357LYYA15aS1q2me6EjKOxnbZxdtMhVzXs26oLeXg8=;
        b=CM/YXLHEBEIg8++6KgkrHm0uFX/oNdHhfM/OeI6h5R+c6pfgQ61dvtm65BIw/LuUAZ
         sFY+cEOXU5RHhFefBZWnvANiwXFocdqdrLc9GSebtgaVvkpyHC6f3uoUhfaqP7qDRED+
         +cs+1dHDjcxoLcKMGgxaSJnE5Z9qXOuCnur61ia8v7E8b/HTu61eqSB+GdSUQzGujqZs
         8eU5s16QcJFqYs+Ldh8F2wshrlWKq0+Lk2Kh/EGvmJKjTisC6v4YAEjlYwqFprmX234G
         ZzKdyIOqusQkLhh54wGDL77BH1CjhK1fY2ytwLkkm5TGo5eeMNnodp2UnEKqgbpoCB2K
         MXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUmrYwJifTdUTNc3dyS2ebbfImUa06Nj3L8YAp1aiwBopQJzb0P7+eUqgzfcgZ9eacfKTvaYoVhKxwbA+1UFDMvCZcLj+lBemgV4Im4
X-Gm-Message-State: AOJu0YzzkzeVAeAgWeAThAwvw/dpcfWD1UY4AT/TTk/CQH7kzMImL+rW
	vJxvAL01nw3IBvz3LlKJ4Z8hFdXZ0wlcUsF6gu2kPAgA5jAVHTvnIzeVSA1uc2I=
X-Google-Smtp-Source: AGHT+IGgC7C2jdskGu+R+LVZYKrOVZJIPDUEu2ZVMsyFbEH7ishX05RCIYvjF09vAhIYmdV892jZKA==
X-Received: by 2002:a50:8e48:0:b0:57c:610a:6e7f with SMTP id 4fb4d7f45d1cf-57ca9750ac8mr2987217a12.11.1718283142566;
        Thu, 13 Jun 2024 05:52:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da790sm879548a12.35.2024.06.13.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:52:22 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:52:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] printk: nbcon_atomic_flush_pending() is safe only when there
 is no boot console
Message-ID: <ZmrrhCf5GRUdGwh9@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-6-john.ogness@linutronix.de>
 <ZmrpxWxUb8k4swrA@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmrpxWxUb8k4swrA@pathway.suse.cz>

Boot consoles are not serialized with the nbcon consoles via the nbcon
console context or con->device_lock(). The serialization is possible only
via the legacy console_lock().

The decision whether nbcon_atomic_flush_pending() should and can be
called safely is similar and closely related to the decision
whether the legacy loop should be used.

Define printing_via_context_safe symmetrically with printing_via_unlock.
Allow to call nbcon_atomic_flush_pending() only when it is needed and safe.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 10 ++++++++++
 kernel/printk/nbcon.c    |  9 +++++++--
 kernel/printk/printk.c   |  7 ++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 38680c6b2b39..bafec0a27da3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -182,6 +182,7 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool have_nbcon_console;
 extern bool have_legacy_console;
 
 /*
@@ -192,6 +193,15 @@ extern bool have_legacy_console;
  */
 #define printing_via_unlock (have_legacy_console || have_boot_console)
 
+/*
+ * Specifies if printing on nbcon consoles is needed and also safe
+ * when serialized only by the nbcon context. If @have_boot_console
+ * is true, the nbcon consoles must be serialized with the boot
+ * consoles using the legacy console_lock().
+ */
+#define printing_via_context_safe (have_nbcon_console || !have_boot_console)
+
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 89b340ca303c..9b2df848718c 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1404,7 +1404,8 @@ void nbcon_cpu_emergency_exit(void)
 	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
 	 */
 	if (*cpu_emergency_nesting == 1) {
-		nbcon_atomic_flush_pending();
+		if (printing_via_context_safe)
+			nbcon_atomic_flush_pending();
 
 		/*
 		 * Safely attempt to flush the legacy consoles in this
@@ -1446,7 +1447,8 @@ void nbcon_cpu_emergency_flush(void)
 	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
 		return;
 
-	nbcon_atomic_flush_pending();
+	if (printing_via_context_safe)
+		nbcon_atomic_flush_pending();
 
 	if (printing_via_unlock && !is_printk_deferred()) {
 		if (console_trylock())
@@ -1637,6 +1639,9 @@ void nbcon_device_release(struct console *con)
 	 * was locked. The console_srcu_read_lock must be taken to ensure
 	 * the console is usable throughout flushing.
 	 */
+	if (!printing_via_context_safe)
+		return;
+
 	cookie = console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
 	    !con->kthread &&
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 137bd9a721c4..3183db5b4180 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -475,7 +475,7 @@ bool have_legacy_console;
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-static bool have_nbcon_console;
+bool have_nbcon_console;
 
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -2370,7 +2370,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	if (have_nbcon_console && !have_boot_console) {
+	if (printing_via_context_safe) {
 		bool is_panic_context = this_cpu_in_panic();
 
 		/*
@@ -3283,7 +3283,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
-	nbcon_atomic_flush_pending();
+	if (printing_via_context_safe)
+		nbcon_atomic_flush_pending();
 
 	if (printing_via_unlock)
 		console_flush_all(false, &next_seq, &handover);
-- 
2.45.2


