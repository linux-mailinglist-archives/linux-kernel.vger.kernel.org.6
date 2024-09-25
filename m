Return-Path: <linux-kernel+bounces-338026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D5985281
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FB21C22E70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D11537B9;
	Wed, 25 Sep 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k5Z38Qdo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c6RM9qOl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k5Z38Qdo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c6RM9qOl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCF14C5A7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242512; cv=none; b=cOyHLb/8H2LZ4/f0PX2C4UVq+iVtRc5myTRzD2c7xIY1kkSWK+aW5n23GRyrBZTLtjz4MhO85/Rr1f9s5E/GroMCC5N2PucqlBJdPRWQq0i47DMMIgb/CQMi6DpG/jU6QVbDalShQcmOHXiWUb0v1f1BNqgcasiVEnjUcgd781Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242512; c=relaxed/simple;
	bh=Ok0FBSdPwSnmqEJ/Nk9GrxxOsJzZZpXDENy218IFJ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEfUsc0Iw1Rq9F1SP0LxvYW60YNnVGq37+zfhxA+D2FHFq/00tIhQzvEegTL+hP/EQ23gRZoLsG+GiH7SG8AcE7r/ZJKg0xUgAhi3qGzRlTuig0inH1+cueWVbDQT92u09vsytHfHJdyI7HF3PCnDlYrEVx3bTmzaZe0K+kKLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k5Z38Qdo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c6RM9qOl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k5Z38Qdo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c6RM9qOl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D35DF1FD32;
	Wed, 25 Sep 2024 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=k5Z38Qdo3p44GQ5JTm+Rw13A4aORP/0F4owOOdOK+Hx2ZcCh0tryh//cMpgoEc18znee6F
	K2ZF3LM0k4HxzVbfoiB5hUPNNh1en5IzqObICUWmfQWy2sxZinxFRShjWeKkG+SJ8mbgK6
	R2vlRzKsZqFGfcKqDyhqcwbj1VTkeYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=c6RM9qOlUHrxe4FkuwXEkXP5SryRc54nf79pn0D6YqHu/nIXdJdgm7VzMTNhOHBKEXSkBV
	LwcKVJ8xNtCaNeAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k5Z38Qdo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c6RM9qOl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=k5Z38Qdo3p44GQ5JTm+Rw13A4aORP/0F4owOOdOK+Hx2ZcCh0tryh//cMpgoEc18znee6F
	K2ZF3LM0k4HxzVbfoiB5hUPNNh1en5IzqObICUWmfQWy2sxZinxFRShjWeKkG+SJ8mbgK6
	R2vlRzKsZqFGfcKqDyhqcwbj1VTkeYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=c6RM9qOlUHrxe4FkuwXEkXP5SryRc54nf79pn0D6YqHu/nIXdJdgm7VzMTNhOHBKEXSkBV
	LwcKVJ8xNtCaNeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5826413A66;
	Wed, 25 Sep 2024 05:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHSKAwuh82ZZUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:35:07 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] sched: Add wait/wake interface for variable updated under a lock.
Date: Wed, 25 Sep 2024 15:24:09 +1000
Message-ID: <20240925053118.3956520-7-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925053118.3956520-1-neilb@suse.de>
References: <20240925053118.3956520-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D35DF1FD32
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Sometimes we need to wait for a condition to be true which must be
testing while holding a lock.  Correspondingly the condition is made
true while holding the lock and the wake up is sent under the lock.

This patch provides wake and wait interfaces which can be used for this
situation when the lock is a mutex or a spinlock, or any other lock for
which there are foo_lock() and foo_unlock() functions.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 106 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 0272629b590a..6aea10efca3d 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -401,6 +401,112 @@ do {									\
 	__ret;								\
 })
 
+/**
+ * wait_var_event_any_lock - wait for a variable to be updated under a lock
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @lock: the object that is locked to protect updates to the variable
+ * @type: prefix on lock and unlock operations
+ * @state: waiting state, %TASK_UNINTERRUPTIBLE etc.
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a lock.  The variables assessed in the condition will normal be updated
+ * under the same lock, and the wake up should be signalled with
+ * wake_up_var_locked() under the same lock.
+ *
+ * This is similar to wait_var_event(), but assumes a lock is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given lock is held and the lock will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.  The functions used to
+ * unlock and lock the object are constructed by appending _unlock and _lock
+ * to @type.
+ *
+ * Return %-ERESTARTSYS if a signal arrives which is allowed to interrupt
+ * the wait according to @state.
+ */
+#define wait_var_event_any_lock(var, condition, lock, type, state)	\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__ret = ___wait_var_event(var, condition, state, 0, 0,	\
+					  type ## _unlock(lock);	\
+					  schedule();			\
+					  type ## _lock(lock));		\
+	__ret;								\
+})
+
+/**
+ * wait_var_event_spinlock - wait for a variable to be updated under a spinlock
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @lock: the spinlock which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a spinlock.  The variables assessed in the condition will normal be updated
+ * under the same spinlock, and the wake up should be signalled with
+ * wake_up_var_locked() under the same spinlock.
+ *
+ * This is similar to wait_var_event(), but assumes a spinlock is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given lock is held and the lock will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_spinlock(var, condition, lock)			\
+	wait_var_event_any_lock(var, condition, lock, spin, TASK_UNINTERRUPTIBLE)
+
+/**
+ * wait_var_event_mutex - wait for a variable to be updated under a mutex
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @mutex: the mutex which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a mutex.  The variables assessed in the condition will normal be
+ * updated under the same mutex, and the wake up should be signalled
+ * with wake_up_var_locked() under the same mutex.
+ *
+ * This is similar to wait_var_event(), but assumes a mutex is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given mutex is held and the mutex will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_mutex(var, condition, lock)			\
+	wait_var_event_any_lock(var, condition, lock, mutex, TASK_UNINTERRUPTIBLE)
+
+/**
+ * wake_up_var_protected - wake up waiters for a variable asserting that it is safe
+ * @var: the address of the variable being waited on
+ * @cond: the condition which afirms this is safe
+ *
+ * When waking waiters which use wait_var_event_any_lock() the waker must be
+ * holding the reelvant lock to avoid races.  This version of wake_up_var()
+ * asserts that the relevant lock is held and so no barrier is needed.
+ * The @cond is only tested when CONFIG_LOCKDEP is enabled.
+ */
+#define wake_up_var_protected(var, cond)				\
+do {									\
+	lockdep_assert(cond);						\
+	wake_up_var(var);						\
+} while (0)
+
+/**
+ * wake_up_var_locked - wake up waiters for a variable while holding a spinlock or mutex
+ * @var: the address of the variable being waited on
+ * @lock: The spinlock or mutex what protects the variable
+ *
+ * Send a wake up for the given variable which should be waited for with
+ * wait_var_event_spinlock() or wait_var_event_mutex().  Unlike wake_up_var(),
+ * no extra barriers are needed as the locking provides sufficient sequencing.
+ */
+#define wake_up_var_locked(var, lock)					\
+	wake_up_var_protected(var, lockdep_is_held(lock))
+
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
  * @bit: the bit of the word being waited on
-- 
2.46.0


