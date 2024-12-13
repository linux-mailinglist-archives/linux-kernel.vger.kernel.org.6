Return-Path: <linux-kernel+bounces-444556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F779F08B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE93168F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0F1DF741;
	Fri, 13 Dec 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lFu4s1La"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6621DF258
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083635; cv=none; b=R7EdviVGuwmLWLueMwap/XDh1od4/In46pEM1/Pm3Tche5P4TkfWIN4gpR75arBMHrKbM2nt/GILxwjeOT0JSzRsXejrGey72FmJm2W2/OO5cLYs9/iql5hIuLRpCljmwVamA+HQOGjlvG167bnCCJjfKKTDuaad42eeR3P8Dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083635; c=relaxed/simple;
	bh=RDbpqS+5p5jc2vCJhV1pqr0/MR5QesXG0JXc5E364WM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StBiVHA2KPJIcJ8jaBZ7F2zsGXnKmlHiBjpBwbOZUFCtLIOMfvQ7IBLpvhuUmDywUdkOa0G+MEFJHUK0UiUx4RYJ8qQ7YXbi2xfGzdyS9BimZdj71CF6onNfeEoXYAeT2DpqncCdvk0ZHk4WFQEUGwPDiDJvcCtxqmFpb42amkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lFu4s1La; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fYQCG
	T5BhK2YiHwv+9QN3ezva5CB4PtsRASZ1Lx+Iqk=; b=lFu4s1La8W3lLt6IgofRk
	GaQrQU33XzyqumBq+FTdeGDDZRs2ZT3MFS3cyzm/UHJ6cOwd3MXkiqMou0qSqKog
	EvT7aOvk8TnlEi518Pdf/AZ7VBnkiZvIfda47fmYpYwWP4xPkumd9JTgPAyCxifu
	pRcP9D9p+2aQxX8I/IaYl4=
Received: from hello.company.local (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXvxn5A1xnmCCqBA--.30634S2;
	Fri, 13 Dec 2024 17:52:58 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: tj@kernel.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH] sched_ext: Use sizeof_field for key_len in dsq_hash_params
Date: Fri, 13 Dec 2024 17:52:54 +0800
Message-Id: <20241213095254.1577635-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXvxn5A1xnmCCqBA--.30634S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr15XFyUCF4DuF1rGF45ZFb_yoWDWFX_Zw
	4FyrnFk3WDJr92qa15GF4fJr97t34ft3Z5uw4kGFWDX34kJr4qvwn5GFZ3J34DZrZ7KFyU
	ArnagF15Aw15WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb1lkDUUUUU==
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNh20IGdb-kdn4gAAs-

From: Liang Jie <liangjie@lixiang.com>

Update the `dsq_hash_params` initialization to use `sizeof_field`
for the `key_len` field instead of a hardcoded value.

This improves code readability and ensures the key length dynamically
matches the size of the `id` field in the `scx_dispatch_q` structure.

Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fff1d045477..4bd964fc7bbb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -960,7 +960,7 @@ static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
 static struct scx_dispatch_q **global_dsqs;
 
 static const struct rhashtable_params dsq_hash_params = {
-	.key_len		= 8,
+	.key_len		= sizeof_field(struct scx_dispatch_q, id),
 	.key_offset		= offsetof(struct scx_dispatch_q, id),
 	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
 };
-- 
2.25.1


