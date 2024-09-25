Return-Path: <linux-kernel+bounces-338022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F8B98527D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1C11C21E04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C415531A;
	Wed, 25 Sep 2024 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WaOTmgiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fu7T08bn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WaOTmgiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fu7T08bn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A714D29C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242480; cv=none; b=ZN51GYfUYA/BfQDRM9+01FJWT2OIDLbigALKwiAScXLfR+InzElMuO/LWbyTDMqyAyympD8sb3HsNyDnVYHP+kKL0614JMorqnNVYVRT89Mhbf2ciV/690y8SZorufrVTXbyYEHFFVZOt5E85Efs23YVUhAZ7oJsjuYHomw6POE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242480; c=relaxed/simple;
	bh=UXxvTx1TeCLXwdn7Ve5EZeCAjiffj2i3+zPa9jKyQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxqgWw81dZKpeC8TmecGyM4/tXgniFHScuMa5dagIOLgmSRZrwVay4uuBoUn4WwhzR+5V0Jggf7r6NwfKQpsVOPbbg+Y9/1+LOp2YnWlwfmGCNjJmbPhB9LH24MCj+cwyJpisFmSDYXd7/ptv0DNgBFgNru7Gzh2OAskVltqFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WaOTmgiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fu7T08bn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WaOTmgiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fu7T08bn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B15D91FD32;
	Wed, 25 Sep 2024 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=WaOTmgiut9PAdvUgTeQelc1xfee/wuA8oD+OX7RxmRHIqrS6GE3bHCx1TSPDzDKzz8sZpZ
	lkTT96S81TWFoNZyMzdkoWyhfe1jSibhPln6pWRzUrhMKtUH0SmOJisa/OzunFWDjp3rxa
	3WUDZukSwbsW3vg602DmTdOZn5Zy8L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=Fu7T08bnkmjKIlbnz2C96yTMjDjuYGpUzX4ZKeKsdeLCRgKcqYAfG1KgSLy8YRWbiOtqUE
	0GDVG8p5p1OTlaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=WaOTmgiut9PAdvUgTeQelc1xfee/wuA8oD+OX7RxmRHIqrS6GE3bHCx1TSPDzDKzz8sZpZ
	lkTT96S81TWFoNZyMzdkoWyhfe1jSibhPln6pWRzUrhMKtUH0SmOJisa/OzunFWDjp3rxa
	3WUDZukSwbsW3vg602DmTdOZn5Zy8L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=Fu7T08bnkmjKIlbnz2C96yTMjDjuYGpUzX4ZKeKsdeLCRgKcqYAfG1KgSLy8YRWbiOtqUE
	0GDVG8p5p1OTlaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36EA313A66;
	Wed, 25 Sep 2024 05:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6JloN+qg82YrUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:34:34 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] sched: change wake_up_bit() and related function to expect unsigned long *
Date: Wed, 25 Sep 2024 15:24:05 +1000
Message-ID: <20240925053118.3956520-3-neilb@suse.de>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

wake_up_bit() currently allows a "void *".  While this isn't strictly a
problem as the address is never dereferenced, it is inconsistent with
the corresponding wait_on_bit() which requires "unsigned long *" and
does dereference the pointer.

Any code that needs to wait for a change in something other than an
unsigned long would be better served by wake_up_var()/wait_var_event().

This patch changes all related "void *" to "unsigned long *".

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 16 ++++++++--------
 kernel/sched/wait_bit.c  | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..48e123839892 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -8,7 +8,7 @@
 #include <linux/wait.h>
 
 struct wait_bit_key {
-	void			*flags;
+	unsigned long		*flags;
 	int			bit_nr;
 	unsigned long		timeout;
 };
@@ -23,14 +23,14 @@ struct wait_bit_queue_entry {
 
 typedef int wait_bit_action_f(struct wait_bit_key *key, int mode);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit);
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit);
 int __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 int __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
-void wake_up_bit(void *word, int bit);
-int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
-int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
-int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
-struct wait_queue_head *bit_waitqueue(void *word, int bit);
+void wake_up_bit(unsigned long *word, int bit);
+int out_of_line_wait_on_bit(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+int out_of_line_wait_on_bit_timeout(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
+int out_of_line_wait_on_bit_lock(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+struct wait_queue_head *bit_waitqueue(unsigned long *word, int bit);
 extern void __init wait_bit_init(void);
 
 int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
@@ -327,7 +327,7 @@ do {									\
  * You can use this helper if bitflags are manipulated atomically rather than
  * non-atomically under a lock.
  */
-static inline void clear_and_wake_up_bit(int bit, void *word)
+static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
 	clear_bit_unlock(bit, word);
 	/* See wake_up_bit() for which memory barrier you need to use. */
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 134d7112ef71..058b0e18727e 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -9,7 +9,7 @@
 
 static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_aligned;
 
-wait_queue_head_t *bit_waitqueue(void *word, int bit)
+wait_queue_head_t *bit_waitqueue(unsigned long *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
 	unsigned long val = (unsigned long)word << shift | bit;
@@ -55,7 +55,7 @@ __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched out_of_line_wait_on_bit(void *word, int bit,
+int __sched out_of_line_wait_on_bit(unsigned long *word, int bit,
 				    wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -66,7 +66,7 @@ int __sched out_of_line_wait_on_bit(void *word, int bit,
 EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched out_of_line_wait_on_bit_timeout(
-	void *word, int bit, wait_bit_action_f *action,
+	unsigned long *word, int bit, wait_bit_action_f *action,
 	unsigned mode, unsigned long timeout)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -108,7 +108,7 @@ __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
-int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
+int __sched out_of_line_wait_on_bit_lock(unsigned long *word, int bit,
 					 wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -118,7 +118,7 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
 
@@ -144,7 +144,7 @@ EXPORT_SYMBOL(__wake_up_bit);
  * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
  * because spin_unlock() does not guarantee a memory barrier.
  */
-void wake_up_bit(void *word, int bit)
+void wake_up_bit(unsigned long *word, int bit)
 {
 	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
 }
-- 
2.46.0


