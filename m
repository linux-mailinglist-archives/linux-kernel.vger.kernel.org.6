Return-Path: <linux-kernel+bounces-385419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC29B36FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE2B28271D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3701DF728;
	Mon, 28 Oct 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="DQR8Qzq8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867E1DF25B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133940; cv=none; b=DQ8DCzLDbrRWex3zR9+0d0gnfSYC7p6bymkSUiP/+JADnFuuYjHCKGPZhr9i557rzdj6ggmMSTpntmr9ZiuKbxcosRZQGnLhDDtMNPGTLn93E9Po1rIBgnOK9jMTZZJ/x90hseGCEqr2pAWi0e428Z8PC/ZK9uiUhbOynYfgYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133940; c=relaxed/simple;
	bh=U+YbVWnIhSxvabD1pM2bJvPXw2gHjIPI4vCrp8Hh14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs1vGDckFZjX6/bw65JwKIQ6jJ1TH3XUKb+RPEIXRS565E6oGzs6aASIhbGCg4uFv71IwEpxCfsnQAefVtMWUpHb1XwQ4btmQR9dUfN/YBV6yW01aBPU/Y+0kW9mc8kgWWryPp9JbZb4OFq8ndl9UmyeTC04+2NTRR6mVUB3M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=DQR8Qzq8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so46718525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133936; x=1730738736; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2OE+Bj68T4jfh3Vb2Xf6arwPQvwLHizVBSSuQacZWA=;
        b=DQR8Qzq81nhoD2+qzFWE4Eyshky+fd8BotFbfU73IOMQ9+Nb6NOicJeDm7ex2IhgPJ
         PI02dHdBovicHIc3oMbWkjLllGcwsIvcr0SzhUGuORF9c6iPP8jT81WXeSZHBUp9otEv
         BKAp/RoG3siJZdIgD5a/nwi+VA4lRDo749GzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133936; x=1730738736;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2OE+Bj68T4jfh3Vb2Xf6arwPQvwLHizVBSSuQacZWA=;
        b=GyCyP+iiScW6sTx0VYByfkPE5ngjRw03Oe9UC2O3QulsQzGX5Uy4+QMzgC/T2G8lRj
         8kB+l1bp0U2VyFjngzJKMUlZBf/y4z4EOfslYHiuGg2SZHqCO+WWQX4A9XozP1MVu2M8
         9hK1mLl3qQCRNtxB+9sadx7ewapH03e7sJf7drZ1t7oPp4TjixPdomtJufg3rKfN6EAS
         j7vfK6lY1NTc55U7gHubAwcHLUtzWyJiUa9O9Xukw1B1J4j9B0jlFc3Yqlw4SoqU92ie
         uHHeiiKggMZyfsEhm4XqY6IgTeJqPLJSgUH9lf1UX50C6MN7BG/aRyyx+IRLaWXXwfC/
         ob8A==
X-Gm-Message-State: AOJu0YwST8t1ouTa5/I6+BT2bHxDnOcxpUvqXxIG2GkXwBBZD+mDuace
	xMyI8i1QoQRmMuETETl1xiv5cfYY3tLJMOGbuxwJGtTtTzrYdEZR+Fsu/JHINrQ=
X-Google-Smtp-Source: AGHT+IFMkr0+rZFHjU0TUe3L2p8vl9KRLvGBk85CApKRdNzYVXf1WhLGnRY0QhCEjrRS2VNCK9WlcA==
X-Received: by 2002:a05:600c:1d1c:b0:431:55bf:fe4 with SMTP id 5b1f17b1804b1-431b17365ffmr12406945e9.24.1730133935814;
        Mon, 28 Oct 2024 09:45:35 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b54303fsm145336145e9.7.2024.10.28.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:35 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:34 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 02/11] printk: Use struct console for suppression and
 extended console state
Message-ID: <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730133890.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

In preparation for supporting per-console loglevels, modify
printk_get_next_message() to accept the console itself instead of
individual arguments that mimic its fields. As part of the upcoming
per-console loglevel support we need the console object here anyway, so
it makes sense to amortise this now.

devkmsg_read() has special behaviour here, but all other consoles follow
the same patterns and can have their extension/suppression states
determined from their struct console.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/printk/internal.h |  4 ++--
 kernel/printk/nbcon.c    |  2 +-
 kernel/printk/printk.c   | 33 ++++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3fcb48502adb..58ad209e0310 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -328,8 +328,8 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
-bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-			     bool is_extended, bool may_supress);
+bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
+			     u64 seq);
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aed..5ae1155c34d3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -974,7 +974,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	if (!nbcon_context_enter_unsafe(ctxt))
 		return false;
 
-	ctxt->backlog = printk_get_next_message(&pmsg, ctxt->seq, is_extended, true);
+	ctxt->backlog = printk_get_next_message(&pmsg, con, ctxt->seq);
 	if (!ctxt->backlog)
 		return nbcon_context_exit_unsafe(ctxt);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d6159f1c5b29..dfe7011b863a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -833,7 +833,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, false)) {
+	if (!printk_get_next_message(&pmsg, NULL, atomic64_read(&user->seq))) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
@@ -850,8 +850,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		 * This pairs with __wake_up_klogd:A.
 		 */
 		ret = wait_event_interruptible(log_wait,
-				printk_get_next_message(&pmsg, atomic64_read(&user->seq), true,
-							false)); /* LMM(devkmsg_read:A) */
+				printk_get_next_message(&pmsg, NULL,
+					atomic64_read(&user->seq))); /* LMM(devkmsg_read:A) */
 		if (ret)
 			goto out;
 	}
@@ -2925,20 +2925,19 @@ void console_prepend_replay(struct printk_message *pmsg)
  * @pmsg will contain the formatted result. @pmsg->pbufs must point to a
  * struct printk_buffers.
  *
+ * @con is the console in question. Only @con->flags and @con->level are
+ * guaranteed to be valid at this point. Note especially well that con->seq is
+ * not yet guaranteed to be consistent with @seq.
+ *
  * @seq is the record to read and format. If it is not available, the next
  * valid record is read.
  *
- * @is_extended specifies if the message should be formatted for extended
- * console output.
- *
- * @may_supress specifies if records may be skipped based on loglevel.
- *
  * Returns false if no record is available. Otherwise true and all fields
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-			     bool is_extended, bool may_suppress)
+bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
+			     u64 seq)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
@@ -2948,6 +2947,14 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	struct printk_info info;
 	struct printk_record r;
 	size_t len = 0;
+	bool is_extended;
+
+	if (con) {
+		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	} else {
+		/* Used only by devkmsg_read(). */
+		is_extended = true;
+	}
 
 	/*
 	 * Formatting extended messages requires a separate buffer, so use the
@@ -2967,8 +2974,8 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 
-	/* Skip record that has level above the console loglevel. */
-	if (may_suppress && suppress_message_printing(r.info->level))
+	/* Never suppress when used in devkmsg_read() */
+	if (con && suppress_message_printing(r.info->level))
 		goto out;
 
 	if (is_extended) {
@@ -3044,7 +3051,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 	*handover = false;
 
-	if (!printk_get_next_message(&pmsg, con->seq, is_extended, true))
+	if (!printk_get_next_message(&pmsg, con, con->seq))
 		return false;
 
 	con->dropped += pmsg.dropped;
-- 
2.46.0


