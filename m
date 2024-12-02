Return-Path: <linux-kernel+bounces-427112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B69DFCD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39C216198A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94861FA15A;
	Mon,  2 Dec 2024 09:11:29 +0000 (UTC)
Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com [45.254.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F091D6DB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130689; cv=none; b=PEKTJ2vje8g72iCqnVhNBcqVn2CUHl+9CFOhx4a/+69Nujqe7fQ4sTAoFsxKK+lC4rKkcdUxxDcR1ITC9ZsQpoc08ZI/9hJ++BnTXCDLDoiU54YIcEODOXnN2qp/ECEBOytfc4wSsW8Bs0MF2u+Xiv+ZCYt2gUCMLXSP048JPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130689; c=relaxed/simple;
	bh=hoeF13Qc2lboYgNvDI0/z7iT1V56b3rR3mkMJHYsA6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NR5a4Kj3FrEW2t59i2rz3hiL9ILD7geZshGkEsCQdNl60Fs46UVXSqqcHnYBHF7aAc5sKL9fW7a42MA8UoH+Y2z2ZIyVV247YzXFW9+rUT0xu8SQwznTVzSIGw4QFFc6uAr8d/Jsd9dIdQbPzqALYxt9PSKlyfW8X6IgJxiUT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [121.237.111.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2227c8c0;
	Mon, 2 Dec 2024 17:11:05 +0800 (GMT+08:00)
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
Date: Mon,  2 Dec 2024 17:10:55 +0800
Message-Id: <20241202091055.49551-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE1PVh4aSxpOGEtOSkNLSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUpVSUhMVUpKSlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a9386a33ee502adkunm2227c8c0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6TBw6FzcWUTASNRgJCSkB
	Qz1PFE1VSlVKTEhISkhLTU1MSkJLVTMWGhIXVQETHhVVFRI7HhoIAggPGhgQVRgVRVlXWRILWUFZ
	SklKVUlITFVKSkpVQ0hZV1kIAVlBSktNQzcG

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


