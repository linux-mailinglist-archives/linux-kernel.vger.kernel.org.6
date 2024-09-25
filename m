Return-Path: <linux-kernel+bounces-338030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A2985285
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDFF1C20FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D3155C9E;
	Wed, 25 Sep 2024 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KaPNJ454";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MN6CsAT6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KaPNJ454";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MN6CsAT6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D503153BFC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242556; cv=none; b=Yh0ZCxmDbgIXOdsueIrFe6zhWny32vLk6uAaZTWHQLxdoxvnkZpdV8PQClgFQQ9fpHi2amvRuofDFGKpGhTCUPTA5yEPab6bGt/dsL6N8aaDI2ibMbs5lYM3i58tQBpSTMv4ft0DFd3Ql/h0+sTjrgfdLxOEGkV8/nPZumEIMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242556; c=relaxed/simple;
	bh=UXxvTx1TeCLXwdn7Ve5EZeCAjiffj2i3+zPa9jKyQ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG0W4jToPJjt9hVLQjonq4jwitjCU7/P4m+jI6LQncQ78fcz3hp+K1g4lC5XI/jzatkWvdBFam+dRbiUICtP/N31dBxn59C1yr2hdQZOC1z/4Fg28EwIrN/cdGN8hBpmPmt4dq/ZMe9d0B29VaDOOPzRYJa1TxCcOStQ+MVkta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KaPNJ454; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MN6CsAT6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KaPNJ454; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MN6CsAT6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 817201FD32;
	Wed, 25 Sep 2024 05:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=KaPNJ454qEQfUsBz/7w8x8cwDnxkTE3RQFQ2qqDO1VWrgv7FBm39qqIM+rSpZxcWyMKjKX
	stZRbq3Ivew2fKoFA+qawI2/r2/oP08kV2ydVNkBkEEX//gx3fvcWG2ZwbKh5GPVYq97RO
	O2k/l57yB1Un56SLLS7nHqdfURpgf+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=MN6CsAT6IVnjwS/j5BUfwAkolf/R7XNfqYjQn4wRJ/c+7va/VJe/bH/efXr7a2AnH73xQy
	eYGKEovJE1dzLICg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KaPNJ454;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MN6CsAT6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=KaPNJ454qEQfUsBz/7w8x8cwDnxkTE3RQFQ2qqDO1VWrgv7FBm39qqIM+rSpZxcWyMKjKX
	stZRbq3Ivew2fKoFA+qawI2/r2/oP08kV2ydVNkBkEEX//gx3fvcWG2ZwbKh5GPVYq97RO
	O2k/l57yB1Un56SLLS7nHqdfURpgf+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGE3jRZ/Xz3OFuyHWXitti4fsw2duTAvaS4bioTEIn0=;
	b=MN6CsAT6IVnjwS/j5BUfwAkolf/R7XNfqYjQn4wRJ/c+7va/VJe/bH/efXr7a2AnH73xQy
	eYGKEovJE1dzLICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 022AB13A66;
	Wed, 25 Sep 2024 05:35:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZxhgKjah82aLUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:35:50 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] sched: change wake_up_bit() and related function to expect unsigned long *
Date: Wed, 25 Sep 2024 15:31:38 +1000
Message-ID: <20240925053405.3960701-2-neilb@suse.de>
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
X-Rspamd-Queue-Id: 817201FD32
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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


