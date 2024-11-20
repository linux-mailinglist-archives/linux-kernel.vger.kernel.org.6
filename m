Return-Path: <linux-kernel+bounces-415418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C159D35D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF121F21613
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254916F831;
	Wed, 20 Nov 2024 08:48:50 +0000 (UTC)
Received: from mail-m1036.netease.com (mail-m1036.netease.com [154.81.10.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535F15CD46
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092530; cv=none; b=bArn8wFe0830LcDvYf6Usk/wD4sNeCVGmvSvyCm/BA/n/qGCAgwz26undgE7eXeFv6pKj41QnTjVEqLqYly29xV/Z1QNV7PDUonWvzd57Yp4a+ocDBBd95IYo0TrPoZ1rI9QHPMcjpWwQ/gkI9x8N/wSsaY9somxEfKmiHDDRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092530; c=relaxed/simple;
	bh=hoeF13Qc2lboYgNvDI0/z7iT1V56b3rR3mkMJHYsA6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WaCW13pG/cMo2nMcFrIQ//9HZ1hzTbnYqvu1auJKMBdKSwbeHMjutVHXFvsXDduty3cKzH9SzlDYNMkR+3OeeZbm14tAqxIhrw3rsBR1GNbRQGRPcXrOrHwzkxlJmoBHrKfezakzU/sR16YxvEFRLU0rEaipvL9MI/ZMDx8a06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=154.81.10.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [180.111.43.56])
	by smtp.qiye.163.com (Hmail) with ESMTP id 19ce7b53;
	Wed, 20 Nov 2024 16:48:28 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	frederic@kernel.org,
	richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] kernel/fork: Optimize by avoiding unnecessary locking for kernel threads
Date: Wed, 20 Nov 2024 16:48:13 +0800
Message-Id: <20241120084813.193339-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhkfVh8fGh5NQk4eGUpOTlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKQ0tVSkpKVU9IVU5NWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9348c238d40229kunm19ce7b53
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6SDo4QzcfQk8wNkk*PDEe
	HTlPFDpVSlVKTEhJS0JJTktCTkhCVTMWGhIXVQETHhVVFRI7HhoIAggPGhgQVRgVRVlXWRILWUFZ
	SkNLVUpKSlVPSFVOTVlXWQgBWUFKS01DNwY+

Improves the function by checking if the task is a kernel thread
(PF_KTHREAD) before acquiring the task lock. Kernel threads do not
have an associated executable file, so the function now returns NULL
immediately in such cases. This change reduces unnecessary locking
overhead and simplifies the code logic, while maintaining consistent
behavior for regular tasks.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 kernel/fork.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index e58d27c05788..9fadde6c7c98 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1500,12 +1500,13 @@ struct file *get_task_exe_file(struct task_struct *task)
 	struct file *exe_file = NULL;
 	struct mm_struct *mm;
 
+	if (task->flags & PF_KTHREAD)
+		return NULL;
+
 	task_lock(task);
 	mm = task->mm;
-	if (mm) {
-		if (!(task->flags & PF_KTHREAD))
-			exe_file = get_mm_exe_file(mm);
-	}
+	if (mm)
+		exe_file = get_mm_exe_file(mm);
 	task_unlock(task);
 	return exe_file;
 }
-- 
2.20.1


