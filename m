Return-Path: <linux-kernel+bounces-338034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DB985289
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389ABB2311C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0115749C;
	Wed, 25 Sep 2024 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JKCC8MLz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PylAPEUD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JKCC8MLz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PylAPEUD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53115574D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242579; cv=none; b=TvMJM1faUH2dQw+8mHOOnyvLZM9dQPkD96RUSobNBstW0GY39QIVj4xdUxltCQrNNtGcdH1s6QKhSv0r+8dJNoMV3ABLcjP/rS3XeRHasapWEJnhnFoJjciPZCXHrLBDRJlJ8RVWaVd3F8wA22JtzcliGKqCw/q7utnN9sDekaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242579; c=relaxed/simple;
	bh=Ok0FBSdPwSnmqEJ/Nk9GrxxOsJzZZpXDENy218IFJ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUPTyIsZrEWqcTvY4vQa6+Ss2qp5cBFJAXnxLdG9h+UzLNwzU4qRWALbe3Wzk5BTsiInFjffGfJe6gHE4xd9ro2M1jnwI3mRCrHvd2nUx77z0OKxBMHXTZZFTFUCyab50Xlm6yEo9CSKFWwxqATLJWbalLX3upi4NdcsHKod9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JKCC8MLz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PylAPEUD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JKCC8MLz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PylAPEUD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B8E71FD30;
	Wed, 25 Sep 2024 05:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=JKCC8MLzy7Jrxo3kAcFY4+XZHxD4sLBjB0Xzt6qOdJqDM5oG0dT1cII56aVpPSmnq8pec7
	exGu8JtMvQX9RHDllSjPazJU57bG2BBfWeRA6QuQuolh9pZEvP2D2mwVef+SkEW52IHugP
	ugmlu4iPEi6OVrQhg2HwW/nF3by1D5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=PylAPEUDNRdCyhbJ3t47Id/nl5Egk1IOSYxEfql4c1nonY5Qh+QGFsUVIhvQcSdktP4j8t
	PBvaCtbmVo1D6vBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=JKCC8MLzy7Jrxo3kAcFY4+XZHxD4sLBjB0Xzt6qOdJqDM5oG0dT1cII56aVpPSmnq8pec7
	exGu8JtMvQX9RHDllSjPazJU57bG2BBfWeRA6QuQuolh9pZEvP2D2mwVef+SkEW52IHugP
	ugmlu4iPEi6OVrQhg2HwW/nF3by1D5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKw1JB4J5UZuj0DJxVaFneJSr819xZJRg3iiAi5BrmE=;
	b=PylAPEUDNRdCyhbJ3t47Id/nl5Egk1IOSYxEfql4c1nonY5Qh+QGFsUVIhvQcSdktP4j8t
	PBvaCtbmVo1D6vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5B4613A66;
	Wed, 25 Sep 2024 05:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VyJrJk6h82aoUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:36:14 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] sched: Add wait/wake interface for variable updated under a lock.
Date: Wed, 25 Sep 2024 15:31:42 +1000
Message-ID: <20240925053405.3960701-6-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
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


