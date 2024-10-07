Return-Path: <linux-kernel+bounces-352847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FF992529
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E55BB221B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998615B0E4;
	Mon,  7 Oct 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk/fzNjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49513BC0E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284101; cv=none; b=Pm9sq/QvXbA2oZjn9b3q7V7deYDPgxzY1aGH7PeIzVO+apwObkshZeHxJOnLSl74wSVgMDnIoZlKkbD6OEgmpcYMSaEvOo0spriycb+BxALmB67NWru5cadKDLRHNJnkR71MqVQ6PMSFysrNTMv4nwoPNR8NxpzqP66n1sAsO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284101; c=relaxed/simple;
	bh=JMckp144TuaWpN5phVTiBaTvB68wsTIZYwBFx6r71gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6tzY+yJshbVOK1qy87KsyT64YjgTloaXjDNVktFWh3e/nkQOz9d7QIfww8oor6vtTTBtzChKFd0YhJv/kZgos9hNxEN3qDRYD5UUebnM9fVY+Kil5zY+KfItMaOjmGQKSfazbg/tnG6j/iGJCsPtNIiZQnfr76hlFDyfVan70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk/fzNjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D41FC4CEC6;
	Mon,  7 Oct 2024 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728284101;
	bh=JMckp144TuaWpN5phVTiBaTvB68wsTIZYwBFx6r71gQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nk/fzNjXDtdnFmbxYX4ZuKjYCCdNQePQjTOiKOhPvYgvI9gLTuJNyWFgTkev5jQ6Z
	 rc7qMBPIPfd4P93C7Kk0ZjEb3Bojy6dwb76ZeMFkd7lPcKz0lqaZO6atSctccZXMc2
	 QuI8voPNrlMV2H20D7rpSPG1LiWxP6D424aKceKbG2HgLpQcju4AVVc0JJ02p/p/Mn
	 ngqbcAijXIaiG9dm4vXv1ObgwFivdcPgsL/lLZRA66eNRpFK0j1/UQP1vykMVez7rk
	 AexDSL3d0H4v5fGedtFMfIm7punr7DAF8NA0jbgKzishDEgTEyaIkHDMOLf2SzYjjU
	 jVjG2VfDfZbjw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] lockdep: Use info level for lockdep initial info messages
Date: Mon,  7 Oct 2024 08:54:57 +0200
Message-ID: <20241007065457.20128-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All those:
 Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
 ... MAX_LOCKDEP_SUBCLASSES:  8
 ... MAX_LOCK_DEPTH:          48
 ... MAX_LOCKDEP_KEYS:        8192
and so on are dumped with the KERN_WARNING level. It is due to missing
KERN_* annotation.

Use pr_info() instead of bare print() to dump the info with the info
level.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 536bd471557f..ae8750157099 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6576,17 +6576,17 @@ EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
 void __init lockdep_init(void)
 {
-	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
+	pr_info("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
-	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
-	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
-	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
-	printk("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
-	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
-	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
-	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
+	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
+	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
+	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
+	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
+	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
+	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
-	printk(" memory used by lock dependency info: %zu kB\n",
+	pr_info(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(lock_classes) +
 		sizeof(lock_classes_in_use) +
 		sizeof(classhash_table) +
@@ -6604,12 +6604,12 @@ void __init lockdep_init(void)
 		);
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
-	printk(" memory used for stack traces: %zu kB\n",
+	pr_info(" memory used for stack traces: %zu kB\n",
 	       (sizeof(stack_trace) + sizeof(stack_trace_hash)) / 1024
 	       );
 #endif
 
-	printk(" per task-struct memory footprint: %zu bytes\n",
+	pr_info(" per task-struct memory footprint: %zu bytes\n",
 	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
 
-- 
2.46.1


