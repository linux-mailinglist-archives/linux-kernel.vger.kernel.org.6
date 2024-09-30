Return-Path: <linux-kernel+bounces-343352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6EF9899F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A558828224A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B114126BFF;
	Mon, 30 Sep 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SFTxUkNM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9aYjEI/E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SFTxUkNM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9aYjEI/E"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2A23BE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673204; cv=none; b=N+DeB8IzuX5K4eiubj75mskwc79HfP6cruKn9NbjRyEGDQik/Sz7JBRQmM4dNldIc8HzsTxYvW5alTeIuxUniLANu7m4KX4QioJFos67J7ucEx7ntW3yBrini6W5rGFXaqHz/LrBJ5JLrNJxTld6WC++11LZl5LfEcTevpnmhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673204; c=relaxed/simple;
	bh=RWwyLtCwBBUGxyyXXURX387njJOPcrqG2UaKKuy4mFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtVFJxFjnR3ng8uVa9dOfBEcShM/7kBkSfo4Ld0/GIi28BwTF2e64NjjMdITxdqB3ozZAFoCgnTZSQqkVvMWqcXUE3KU70sYMdqYoDsZAz/cDFPeCSvwco2dW0mQ52XGRmZzrC20g3RCtUBzhPDmhorgQA5vuYD3oZGyMfDawqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SFTxUkNM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9aYjEI/E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SFTxUkNM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9aYjEI/E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9718F1F7E4;
	Mon, 30 Sep 2024 05:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727673200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxWuKVrz/TO4V/4rk6JKATdkbueRTXD126RNwYUislU=;
	b=SFTxUkNMBs91eE3VO5NWFJSmGndM8uF2epfiisSH6xJ/anEzEx0505gkYvqpZwqJs9TaoL
	isOj4tt0rPsz+INP4/GXZE3O1GeiUYGQMlmMhYBdF1vjg1nXXjMEtOUju7o95c579+jj/p
	pUt6qs3+0LZGWhiwWoTdX5k7SRYAmHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727673200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxWuKVrz/TO4V/4rk6JKATdkbueRTXD126RNwYUislU=;
	b=9aYjEI/ETYeVEdHceJhfXFXGYNbQT8VI7SETZevEAqdqDf5tvumMxe+Vt3MOiCC6MiHkPW
	hEgNQZIc2GJKJkAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727673200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxWuKVrz/TO4V/4rk6JKATdkbueRTXD126RNwYUislU=;
	b=SFTxUkNMBs91eE3VO5NWFJSmGndM8uF2epfiisSH6xJ/anEzEx0505gkYvqpZwqJs9TaoL
	isOj4tt0rPsz+INP4/GXZE3O1GeiUYGQMlmMhYBdF1vjg1nXXjMEtOUju7o95c579+jj/p
	pUt6qs3+0LZGWhiwWoTdX5k7SRYAmHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727673200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxWuKVrz/TO4V/4rk6JKATdkbueRTXD126RNwYUislU=;
	b=9aYjEI/ETYeVEdHceJhfXFXGYNbQT8VI7SETZevEAqdqDf5tvumMxe+Vt3MOiCC6MiHkPW
	hEgNQZIc2GJKJkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDE2A136CB;
	Mon, 30 Sep 2024 05:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fwM/H2wz+mZ+XQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 30 Sep 2024 05:13:16 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Hajime Tazaki <thehajime@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] sched: remove unused __HAVE_THREAD_FUNCTIONS hook support
Date: Mon, 30 Sep 2024 05:09:46 +0000
Message-ID: <20240930050945.30304-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,suse.de,gmail.com,kernel.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

__HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
provide their own task_thread_info(), task_stack_page(),
setup_thread_stack() and end_of_stack() hooks.

Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
conditionals to only check for the former case.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes since v1:
- add Ard's rb tag
- send for linux-next inclusion

 include/linux/sched.h            | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e6ee4258169a0..abf26f1e1447b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1898,7 +1898,7 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 # define task_thread_info(task)	(&(task)->thread_info)
-#elif !defined(__HAVE_THREAD_FUNCTIONS)
+#else
 # define task_thread_info(task)	((struct thread_info *)(task)->stack)
 #endif
 
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index bf10bdb487ddc..2e52cc421bce9 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -33,7 +33,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
 #endif
 }
 
-#elif !defined(__HAVE_THREAD_FUNCTIONS)
+#else
 
 #define task_stack_page(task)	((void *)(task)->stack)
 
-- 
2.43.0


