Return-Path: <linux-kernel+bounces-338031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FB985286
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FD4B23125
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C6914C5A7;
	Wed, 25 Sep 2024 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y8c+yhbn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lm9/PbPR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y8c+yhbn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lm9/PbPR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0C154C04
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242565; cv=none; b=eT+LSR+aEhZE9ogULDTI1vx3a7xlq33J6DdBQ9Spet7zd78yqzH6MKYMxCMVsJCvDfE70/2CvR/rghxYiiysbsK0SslxaIjEwgfPpYoAucL3nLr1OA4HW/b+IUuoGBT/DBaEokYyUxx0rcQKuSDvEIThBs5y5xq7lMi1IumUZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242565; c=relaxed/simple;
	bh=5G8drIKcKc9eVEXrKmaP6lcL1lKGSHzxebmMrtAz1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGYNYBWP2vRFuq3yTS1vLF3IOwfAnKiAMy1Brc1KYwFLStyxgxngTySE8a5urlovC7PozQY9VXQQaceqERk2roC4fHlFzTjqeoImmKli7thu0FZOJ9rzBP5oG14Q8gyIlZt+/b2xY23HcVXsGV3Yr7hR7R51EzbgRTwI/xCUN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y8c+yhbn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lm9/PbPR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y8c+yhbn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lm9/PbPR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEB831FD32;
	Wed, 25 Sep 2024 05:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNdiD1XMKNrft2fFnwEWO+4kNLwMK+cCeQRN0tFRGyQ=;
	b=y8c+yhbnHJFhuTwvcixz11BBXC41xTWX4auyawSKvi9y0NPaJ6xOHL/dfA1l+gocKVVQAM
	6ofu0cNLUyRxmlEPF6sTMPh4RgomcE6iYQ1fQF4gLOcxjjc02fAfre8W0ZpQJzLJ7elyzX
	WDh8cQxp2Fj7rONTmfuJ3sJTK8zTOvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNdiD1XMKNrft2fFnwEWO+4kNLwMK+cCeQRN0tFRGyQ=;
	b=Lm9/PbPR23ctF4WlfvfayLqD/62FwtIaX+7CU/TQGtKuTyWttVx3iUMLLE5PubQF9FdhCn
	Sbnv2DCeoRV6GQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNdiD1XMKNrft2fFnwEWO+4kNLwMK+cCeQRN0tFRGyQ=;
	b=y8c+yhbnHJFhuTwvcixz11BBXC41xTWX4auyawSKvi9y0NPaJ6xOHL/dfA1l+gocKVVQAM
	6ofu0cNLUyRxmlEPF6sTMPh4RgomcE6iYQ1fQF4gLOcxjjc02fAfre8W0ZpQJzLJ7elyzX
	WDh8cQxp2Fj7rONTmfuJ3sJTK8zTOvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNdiD1XMKNrft2fFnwEWO+4kNLwMK+cCeQRN0tFRGyQ=;
	b=Lm9/PbPR23ctF4WlfvfayLqD/62FwtIaX+7CU/TQGtKuTyWttVx3iUMLLE5PubQF9FdhCn
	Sbnv2DCeoRV6GQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBFB013A66;
	Wed, 25 Sep 2024 05:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IQHSJz+h82aWUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:35:59 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] sched: Improve documentation for wake_up_bit/wait_on_bit family of functions
Date: Wed, 25 Sep 2024 15:31:39 +1000
Message-ID: <20240925053405.3960701-3-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This patch revises the documention for wake_up_bit(),
clear_and_wake_up_bit(), and all the wait_on_bit() family of functions.

The new documentation places less emphasis on the pool of waitqueues
used (an implementation detail) and focuses instead on details of how
the functions behave.

The barriers included in the wait functions and clear_and_wake_up_bit()
and those required for wake_up_bit() are spelled out more clearly.

The error statuses returned are given explicitly.

The fact that the wait_on_bit_lock() function sets the bit is made more
obvious.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 159 +++++++++++++++++++++------------------
 kernel/sched/wait_bit.c  |  34 +++++----
 2 files changed, 107 insertions(+), 86 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 48e123839892..723e7bf35747 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -53,19 +53,21 @@ extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit.
- * For instance, if one were to have waiters on a bitflag, one would
- * call wait_on_bit() in threads waiting for the bit to clear.
- * One uses wait_on_bit() where one is waiting for the bit to clear,
- * but has no intention of setting it.
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the target bit, even
+ * if other processes on the same queue are waiting for other bits.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
@@ -80,17 +82,20 @@ wait_on_bit(unsigned long *word, int bit, unsigned mode)
 
 /**
  * wait_on_bit_io - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared.  This is similar to wait_on_bit(), but calls
- * io_schedule() instead of schedule() for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls io_schedule() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
@@ -104,19 +109,24 @@ wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_timeout - wait for a bit to be cleared or a timeout to elapse
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  * @timeout: timeout, in jiffies
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared. This is similar to wait_on_bit(), except also takes a
- * timeout parameter.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared, or for a timeout to expire.  The
+ * clearing of the bit must be signalled with wake_up_bit(), often as
+ * clear_and_wake_up_bit().
  *
- * Returned value will be zero if the bit was cleared before the
- * @timeout elapsed, or non-zero if the @timeout elapsed or process
- * received a signal and the mode permitted wakeup on that signal.
+ * This is similar to wait_on_bit(), except it also takes a timeout
+ * parameter.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal, or %-EAGAIN if the
+ * timeout elapsed.
  */
 static inline int
 wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
@@ -132,19 +142,21 @@ wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
 
 /**
  * wait_on_bit_action - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit waited on
+ * @bit: the bit at that address being waited on
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared, and allow the waiting action to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or the error code returned by @action if
+ * that call returned non-zero.
  */
 static inline int
 wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -157,23 +169,22 @@ wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
 }
 
 /**
- * wait_on_bit_lock - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit
- * when one intends to set it, for instance, trying to lock bitflags.
- * For instance, if one were to have waiters trying to set bitflag
- * and waiting for it to clear before setting it, one would call
- * wait_on_bit() in threads waiting to be able to set the bit.
- * One uses wait_on_bit_lock() where one is waiting for the bit to
- * clear with the intention of setting it, and when done, clearing it.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * This is similar to wait_on_bit(), but sets the bit before returning.
+ *
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or %-EINTR if the process received a signal and
+ * the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
@@ -185,15 +196,18 @@ wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_io - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_io - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to atomically set it.  This is similar
- * to wait_on_bit(), but calls io_schedule() instead of schedule()
- * for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
+ *
+ * This is similar to wait_on_bit_lock(), but calls io_schedule() instead
+ * of schedule().
  *
  * Returns zero if the bit was (eventually) found to be clear and was
  * set.  Returns non-zero if a signal was delivered to the process and
@@ -209,21 +223,19 @@ wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_action - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_action - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to set it, and allow the waiting action
- * to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * This is similar to wait_on_bit_lock(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or the error code returned by @action if that
+ * call returned non-zero.
  */
 static inline int
 wait_on_bit_lock_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -320,12 +332,13 @@ do {									\
 
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
- *
  * @bit: the bit of the word being waited on
- * @word: the word being waited on, a kernel virtual address
+ * @word: the address containing the bit being waited on
  *
- * You can use this helper if bitflags are manipulated atomically rather than
- * non-atomically under a lock.
+ * The designated bit is cleared and any tasks waiting in wait_on_bit()
+ * or similar will be woken.  This call has RELEASE semantics so that
+ * any changes to memory made before this call are guaranteed to be visible
+ * after the corresponding wait_on_bit() completes.
  */
 static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 058b0e18727e..bd2fc750fb1f 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -128,21 +128,29 @@ void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit
 EXPORT_SYMBOL(__wake_up_bit);
 
 /**
- * wake_up_bit - wake up a waiter on a bit
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wake_up_bit - wake up waiters on a bit
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hash-table's accessor API that wakes up waiters
- * on a bit. For instance, if one were to have waiters on a bitflag,
- * one would call wake_up_bit() after clearing the bit.
+ * Wake up any process waiting in wait_on_bit() or similar for the
+ * given bit to be cleared.
  *
- * In order for this to function properly, as it uses waitqueue_active()
- * internally, some kind of memory barrier must be done prior to calling
- * this. Typically, this will be smp_mb__after_atomic(), but in some
- * cases where bitflags are manipulated non-atomically under a lock, one
- * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
- * because spin_unlock() does not guarantee a memory barrier.
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address and bit will be woken, and only if the
+ * bit is clear.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the bit is cleared and before this function is called.
+ * If the bit was cleared atomically, such as a by clear_bit() then
+ * smb_mb__after_atomic() can be used, othwewise smb_mb() is needed.
+ * If the bit was cleared with a fully-ordered operation, no further
+ * barrier is required.
+ *
+ * Normally the bit should be cleared by an operation with RELEASE
+ * semantics so that any changes to memory made before the bit is
+ * cleared are guaranteed to be visible after the matching wait_on_bit()
+ * completes.
  */
 void wake_up_bit(unsigned long *word, int bit)
 {
-- 
2.46.0


