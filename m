Return-Path: <linux-kernel+bounces-321950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CF9721DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FC5285122
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4C188CDE;
	Mon,  9 Sep 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgPGmB33"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777CB17C9B6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906581; cv=none; b=b0GEMch4zvU0GMbVJnoDveSDthWTxcs9Do7BQHh0OZgOT/VxRD8aGAQuf/mFKOiE72HRMmhizLYbm3ORqkvvZhG9KEtGU1nfHRie2nGIKWuA+yC+BUfDZSK2pistN+VXkgYOcVP1IjEjW/VXIFlm0O7gNZ/esW0e+Nm/brOOfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906581; c=relaxed/simple;
	bh=8n3tGnSsaS8Ef5btUal4XH/5jEMt+x/gKgan0/azNhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+16BKumR793v9VmqVtUzdGT8e3WJ4aIbyaJX7/aA39aiO/FRBjSel6J7xt2gZyK+bRrNgBX8MRr8rrp5xsIeSoZfBeRPVUNEq/ZnYe3BlOuxqYYtTeSi9uUq7WbGuw8uySclA3K8QeLKXMsxMEEMfAjOwB2EFhPl0FHzO3NOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgPGmB33; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725906578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v6cW4IEecTFnIMvpjFYXEq2ZsoJICYtcdAcWwNGgLhg=;
	b=YgPGmB338Zc6wusrtBZABYS5fwai+DKF7Zc4YRIdwXXVbGMXXxCq4pLvjBCcfUwDYLKrB8
	dVcE1eWLIpwSbsnKvoMro10QBOjNrsmKFrkuEC+xj58yTVvp4wJe3tidxDUxZh4YGmwM8y
	9PdRQALb5pvPIYyWk6NXop1SCekYrNc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-OK7VbwbbPwCk7GjI4CGE9A-1; Mon,
 09 Sep 2024 14:29:33 -0400
X-MC-Unique: OK7VbwbbPwCk7GjI4CGE9A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0BD31944D1A;
	Mon,  9 Sep 2024 18:29:30 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05E631955F65;
	Mon,  9 Sep 2024 18:29:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Move is_rwsem_reader_owned() and rwsem_owner() under CONFIG_DEBUG_RWSEMS
Date: Mon,  9 Sep 2024 14:29:05 -0400
Message-ID: <20240909182905.161156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Both is_rwsem_reader_owned() and rwsem_owner() are currently only used when
CONFIG_DEBUG_RWSEMS is defined. This causes a compilation error with clang
when `make W=1` and CONFIG_WERROR=y:

kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
  187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
      |                    ^~~~~~~~~~~~~~~~~~~~~
kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
  271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
      |                                   ^~~~~~~~~~~

Fix this by moving these two functions under the CONFIG_DEBUG_RWSEMS define.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 33cac79e3994..4b041e9c408f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -181,12 +181,21 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 	__rwsem_set_reader_owned(sem, current);
 }
 
+#ifdef CONFIG_DEBUG_RWSEMS
+/*
+ * Return just the real task structure pointer of the owner
+ */
+static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
+{
+	return (struct task_struct *)
+		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
+}
+
 /*
  * Return true if the rwsem is owned by a reader.
  */
 static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 {
-#ifdef CONFIG_DEBUG_RWSEMS
 	/*
 	 * Check the count to see if it is write-locked.
 	 */
@@ -194,11 +203,9 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
 
 	if (count & RWSEM_WRITER_MASK)
 		return false;
-#endif
 	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
 }
 
-#ifdef CONFIG_DEBUG_RWSEMS
 /*
  * With CONFIG_DEBUG_RWSEMS configured, it will make sure that if there
  * is a task pointer in owner of a reader-owned rwsem, it will be the
@@ -265,15 +272,6 @@ static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
 	return false;
 }
 
-/*
- * Return just the real task structure pointer of the owner
- */
-static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
-{
-	return (struct task_struct *)
-		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
-}
-
 /*
  * Return the real task structure pointer of the owner and the embedded
  * flags in the owner. pflags must be non-NULL.
-- 
2.43.5


