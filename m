Return-Path: <linux-kernel+bounces-338032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEF985287
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5671F241E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF113155359;
	Wed, 25 Sep 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uXLa+LUl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TSFEwEXM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uXLa+LUl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TSFEwEXM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315015574D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242570; cv=none; b=tYdh91aAMS1bh/e0V0u5guSFzpeyRZT9iRXOpSX0kGIvWw35IpHzhon8YxzohmELpVh6bPl7RYAplqWop4xyAjO6AuwyGeFldv0W2TfLa7iOZGb+S3mORhkNcC5xiq1MrjiGs7f/yzQw7YZCMU5fzlt7NOpn70DvHGgBicveYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242570; c=relaxed/simple;
	bh=3qiBvSTL5KVMcgRfJKD7rY9QeKLgUOpk2C3iJy5L2SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT0uew1D+9Knesr1Unc5VV0hS32KvOO3YErgJs8hm1glPrLZurqxQaFE854ZdYEK0V3a1sNsB/LRM3mDGbf+RtkN7V9oJYMKz28rnzDsWQNAKkyS2E4qK4Kjt8bZhQ3EbCGiDNE2HrkRRqfOJnC9mHvTs0cDX8ZsnJQY9Wq/RI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uXLa+LUl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TSFEwEXM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uXLa+LUl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TSFEwEXM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A51721FD30;
	Wed, 25 Sep 2024 05:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm78a9I/y5Jhx1MOAKRxaG8h/PjpFbsM89I1+Rnyl4w=;
	b=uXLa+LUlmtfGMZUjnR/VznzqrWaNjhXTY9iH33J0BdOBb3M87Y57m/4GgDRngzxx9gfse1
	2z3017jsPIO71UBHb9JiMmVG0QmM1116mHEPzn7BHayKPy6BYB3jzimmNzJ2zIwC3FWroy
	glUXoem89VRqZU2Kf8wmtpdZaBXaOrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm78a9I/y5Jhx1MOAKRxaG8h/PjpFbsM89I1+Rnyl4w=;
	b=TSFEwEXMagcALrZLQZ5RRTxFwqARV7Ti/EpSC7VjutZqQIOVAwMkRL4oZIaeCwI4+ZPV3N
	RxLgfmfrz+FcC1Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm78a9I/y5Jhx1MOAKRxaG8h/PjpFbsM89I1+Rnyl4w=;
	b=uXLa+LUlmtfGMZUjnR/VznzqrWaNjhXTY9iH33J0BdOBb3M87Y57m/4GgDRngzxx9gfse1
	2z3017jsPIO71UBHb9JiMmVG0QmM1116mHEPzn7BHayKPy6BYB3jzimmNzJ2zIwC3FWroy
	glUXoem89VRqZU2Kf8wmtpdZaBXaOrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lm78a9I/y5Jhx1MOAKRxaG8h/PjpFbsM89I1+Rnyl4w=;
	b=TSFEwEXMagcALrZLQZ5RRTxFwqARV7Ti/EpSC7VjutZqQIOVAwMkRL4oZIaeCwI4+ZPV3N
	RxLgfmfrz+FcC1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28CB813A66;
	Wed, 25 Sep 2024 05:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mIj7M0Sh82adUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:36:04 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] sched: Document wait_var_event() family of functions and wake_up_var()
Date: Wed, 25 Sep 2024 15:31:40 +1000
Message-ID: <20240925053405.3960701-4-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925053405.3960701-1-neilb@suse.de>
References: <20240925053405.3960701-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

wake_up_var(), wait_var_event() and related interfaces are not
documented but have important ordering requirements.  This patch adds
documentation and makes these requirements explicit.

The return values for those wait_var_event_* functions which return a
value are documented.  Note that these are, perhaps surprisingly,
sometimes different from comparable wait_on_bit() functions.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 71 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/wait_bit.c  | 30 +++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 723e7bf35747..06ec99b90bf3 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -282,6 +282,22 @@ __out:	__ret;								\
 	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true, only re-checking when a wake up is
+ * received for the given @var (an arbitrary kernel address which need
+ * not be directly related to the given condition, but usually is).
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the given address.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event(var, condition)					\
 do {									\
 	might_sleep();							\
@@ -294,6 +310,24 @@ do {									\
 	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a fatal signal to be received,
+ * only re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is
+ * 0 if the condition became true, or %-ERESTARTSYS if a fatal signal
+ * was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_killable(var, condition)				\
 ({									\
 	int __ret = 0;							\
@@ -308,6 +342,26 @@ do {									\
 			  TASK_UNINTERRUPTIBLE, 0, timeout,		\
 			  __ret = schedule_timeout(__ret))
 
+/**
+ * wait_var_event_timeout - wait for a variable to be updated or a timeout to expire
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ * @timeout: maximum time to wait in jiffies
+ *
+ * Wait for a @condition to be true or a timeout to expire, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the timeout expired and the condition was still false, or the
+ * remaining time left in the timeout (but at least 1) if the condition
+ * was found to be true.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_timeout(var, condition, timeout)			\
 ({									\
 	long __ret = timeout;						\
@@ -321,6 +375,23 @@ do {									\
 	___wait_var_event(var, condition, TASK_INTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a signal to be received, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the condition became true, or %-ERESTARTSYS if a signal was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_interruptible(var, condition)			\
 ({									\
 	int __ret = 0;							\
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index bd2fc750fb1f..22ec270f5ab5 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -196,6 +196,36 @@ void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int
 }
 EXPORT_SYMBOL(init_wait_var_entry);
 
+/**
+ * wake_up_var - wake up waiters on a variable (kernel address)
+ * @var: the address of the variable being waited on
+ *
+ * Wake up any process waiting in wait_var_event() or similar for the
+ * given variable to change.  wait_var_event() can be waiting for an
+ * arbitrary condition to be true and associates that condition with an
+ * address.  Calling wake_up_var() suggests that the condition has been
+ * made true, but does not strictly require the condtion to use the
+ * address given.
+ *
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address will be woken.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the variable is updated (or more accurately, after the
+ * condition waited on has been made to be true) and before this function
+ * is called.  If the variable was updated atomically, such as a by
+ * atomic_dec() then smb_mb__after_atomic() can be used.  If the
+ * variable was updated by a fully ordered operation such as
+ * atomic_dec_and_test() then no extra barrier is required.  Otherwise
+ * smb_mb() is needed.
+ *
+ * Normally the variable should be updated (the condition should be made
+ * to be true) by an operation with RELEASE semantics such as
+ * smp_store_release() so that any changes to memory made before the
+ * variable was updated are guaranteed to be visible after the matching
+ * wait_var_event() completes.
+ */
 void wake_up_var(void *var)
 {
 	__wake_up_bit(__var_waitqueue(var), var, -1);
-- 
2.46.0


