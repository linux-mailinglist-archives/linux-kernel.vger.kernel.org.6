Return-Path: <linux-kernel+bounces-416026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C69D3F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3040728429C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D613C9C7;
	Wed, 20 Nov 2024 15:44:46 +0000 (UTC)
Received: from mail-m17240.xmail.ntesmail.com (mail-m17240.xmail.ntesmail.com [45.195.17.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1B1369B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117485; cv=none; b=cYuv8cy3uaBp82QyxvXSIyV3WnTFhWZKtolCk8gvsG1DSaY7srmRqPADiqWLFwDx1c+l9M3hc2gXL/rataWcwSkhwxQv9XOAOhi68/P6rq8RcCmif/YwHrYjAq4qoSg6fAXFYxz5XwTNFoQdpdNVEN6nCJqCEadcPQjVV5ncgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117485; c=relaxed/simple;
	bh=gfw5odtvBAYqKoUdAhrkpWf9oN7OlZfeBrbN1RbwbMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYni0faKGIzSEG4sK3qfb4PGjbCRg7eltUm8EkHIB3O3zg4bEMyf+ZlCwy3rNWHUL5VM5V0LH94d7nM7kOwVUGFHX4ipuzp0smNIf7kpDtxT9SeSAHoJhcIB3GzPRteUWoohVyXvJ2Ub4ky2dIkvg8knZTs2hs2Qbv36RU/SXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [180.111.43.56])
	by smtp.qiye.163.com (Hmail) with ESMTP id 19f6630d;
	Wed, 20 Nov 2024 21:22:05 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	oleg@redhat.com,
	catalin.marinas@arm.com,
	brauner@kernel.org,
	zev@bewilderbeest.net
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce contention
Date: Wed, 20 Nov 2024 21:21:56 +0800
Message-Id: <20241120132156.207250-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB8aVkxKHkkeSUsfHh8dS1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKQ0tVSkpKVU9IVU5NWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9349bcba120229kunm19f6630d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46CTo4KDcfFU42Ei4cVj43
	AgwaFB9VSlVKTEhJSktDQklNSEJMVTMWGhIXVQETHhVVFRI7HhoIAggPGhgQVRgVRVlXWRILWUFZ
	SkNLVUpKSlVPSFVOTVlXWQgBWUFKQ0hKNwY+

Refines the lock scope in the do_prlimit function to reduce
contention on task_lock(tsk->group_leader). The lock now protects only
sections that access or modify shared resources (rlim). Permission
checks (capable) and security validations (security_task_setrlimit)
are placed outside the lock, as they do not modify rlim and are
independent of shared data protection.

The security_task_setrlimit function is a Linux Security Module (LSM)
hook that evaluates resource limit changes based on security policies.
It does not alter the rlim data structure, as confirmed by existing
LSM implementations (e.g., SELinux and AppArmor). Thus, this function
does not require locking, ensuring correctness while improving
concurrency.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 kernel/sys.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index c4c701c6f0b4..ef99b654e8d8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1481,18 +1481,20 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
 	rlim = tsk->signal->rlim + resource;
-	task_lock(tsk->group_leader);
 	if (new_rlim) {
 		/*
 		 * Keep the capable check against init_user_ns until cgroups can
 		 * contain all limits.
 		 */
 		if (new_rlim->rlim_max > rlim->rlim_max &&
-				!capable(CAP_SYS_RESOURCE))
-			retval = -EPERM;
-		if (!retval)
-			retval = security_task_setrlimit(tsk, resource, new_rlim);
+		    !capable(CAP_SYS_RESOURCE))
+			return -EPERM;
+		retval = security_task_setrlimit(tsk, resource, new_rlim);
+		if (retval)
+			return retval;
 	}
+
+	task_lock(tsk->group_leader);
 	if (!retval) {
 		if (old_rlim)
 			*old_rlim = *rlim;
-- 
2.20.1


