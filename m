Return-Path: <linux-kernel+bounces-296597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDC95AC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155A11F222C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657B3BB47;
	Thu, 22 Aug 2024 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iEz6BxuT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fgRcYOkt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iEz6BxuT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fgRcYOkt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630428DCC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724301227; cv=none; b=kovabP0VI995obOFhxnbCZ3U50INLlG0enH2A4IEZ9Popj5VUcuaAeYfaaBmEdUEFwym8jjcEjIo+EBrUjGobZpAgWmP5i7OFpWzTbesJiuWN/XZIh7BRyS1qQ0TLzMPnUnylFqVvKicUbHacscx19OsJuSurWzOc4vKDHL5sBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724301227; c=relaxed/simple;
	bh=jkVz6ub2t90tCPvJU2OYmYkvyWismnjyYbBqVe47Mk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLbdje3nxTtIDiLTj8DmwsV4o8GLI6W6/jwW+F/TkZCKHBP8TuMYsSohM76go8cnvoz8r/C72k3kB54iO6Hkf+h/jA8ugcTgf2z4vgSo4+iCSevmwsXIHXn4vzkWxM3P18PvRM/hz53piijH4Z4RCodYMhm9+6FJaGCrgEtHZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iEz6BxuT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fgRcYOkt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iEz6BxuT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fgRcYOkt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0671222499;
	Thu, 22 Aug 2024 04:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724301224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u+50gYUJFGmIA+n4VtDqikJkBoNG7yQ98SFBZ8R9ygQ=;
	b=iEz6BxuTFPtvnVbI2Yu1BUQ0apv8zIoX0zbnFWUWEqpAFpHIkILaY+RuyPZiJc8ajuFi8W
	UL6DeuNeY+ciZB8MMtVmqsVJdZJ+tYLHz0tIgce4ORBVd4bX68u/88Oeoi7m2yiDucb3Nc
	WMkuQR6luRtR8C+Si82aFdD+0ApraPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724301224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u+50gYUJFGmIA+n4VtDqikJkBoNG7yQ98SFBZ8R9ygQ=;
	b=fgRcYOkt2lgxZGRNFQKP1brjkwswdezbv6jsMLKMITvgK0f7VvpwLcnl3WZmEeD7HI/1xq
	l8IPU7PxwPk+TiBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iEz6BxuT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fgRcYOkt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724301224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u+50gYUJFGmIA+n4VtDqikJkBoNG7yQ98SFBZ8R9ygQ=;
	b=iEz6BxuTFPtvnVbI2Yu1BUQ0apv8zIoX0zbnFWUWEqpAFpHIkILaY+RuyPZiJc8ajuFi8W
	UL6DeuNeY+ciZB8MMtVmqsVJdZJ+tYLHz0tIgce4ORBVd4bX68u/88Oeoi7m2yiDucb3Nc
	WMkuQR6luRtR8C+Si82aFdD+0ApraPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724301224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u+50gYUJFGmIA+n4VtDqikJkBoNG7yQ98SFBZ8R9ygQ=;
	b=fgRcYOkt2lgxZGRNFQKP1brjkwswdezbv6jsMLKMITvgK0f7VvpwLcnl3WZmEeD7HI/1xq
	l8IPU7PxwPk+TiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 725CD13A8D;
	Thu, 22 Aug 2024 04:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bh0DCaS/xmZ9JAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 22 Aug 2024 04:33:40 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel-library@freelists.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Hajime Tazaki <thehajime@gmail.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] sched: remove unused __HAVE_THREAD_FUNCTIONS hook support
Date: Thu, 22 Aug 2024 04:33:28 +0000
Message-ID: <20240822043328.4180-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0671222499
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[freelists.org,redhat.com,infradead.org,linaro.org,suse.de,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

__HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
provide their own task_thread_info(), task_stack_page(),
setup_thread_stack() and end_of_stack() hooks.

Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
conditionals to only check for the former case.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 include/linux/sched.h            | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..9dbcdfe173cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1874,7 +1874,7 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 # define task_thread_info(task)	(&(task)->thread_info)
-#elif !defined(__HAVE_THREAD_FUNCTIONS)
+#else
 # define task_thread_info(task)	((struct thread_info *)(task)->stack)
 #endif
 
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..55042ff01a6d 100644
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


