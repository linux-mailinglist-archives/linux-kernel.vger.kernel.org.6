Return-Path: <linux-kernel+bounces-246683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7892C52B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB397B21E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B0187844;
	Tue,  9 Jul 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KspuhS3t"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F7185607
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559411; cv=none; b=j6Sqd4muRkA2K+4RHU4hZs0RCm93nyEqdbSblKDq1bCIXjMTttlCuI48vvqYsziMUPkC7vxUV4X1rQcBIos0s9BwQ2CBasICJyed56UuqyxTp0EBLvQexc//WjfRQg7PA27x7D6h29C/lFDXMrKcMLRYIOPxtAb2eLqXEX44fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559411; c=relaxed/simple;
	bh=M50cZxEI7XmvhHX52uM0NQ9ap0+nPXJ58Pcd1P6YDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1hMmK8CN5RcHuiHRinlFEXKnxi+THCZvbXn3CBGpwfpa23ZEywV/sK9BIDayEjlcLY/6OtlYZAfzTO5WxB2KOn/QsNYKShGxIs6aFHMqNQ5/+PKCpTZSksJB8zNfq/mkWF2eobL/pM+EZPQ5o045VADO0qcmxEEU37kO4SfbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KspuhS3t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb05b0be01so33476555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720559409; x=1721164209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HchiMOrZAL17tWILJsEYcMV/aX1F31qPCjahGtHK6kc=;
        b=KspuhS3ti/qcZdUvwREKx7SgHmAsJOpWQzrI8tJhJzjnFFt1LIwdt3mF1pKNInctjc
         Nd/CpWc3eJv7lkJgy228qvHnS1UYGEip+hYqHhFegdl7FePWlvy6T/pFa9HM9dRrdUn0
         pnYxGclvWq+bKj8LDlDDSCbvs1S+U6AoclssCOsUl3++XJ6AWe9nV56zRTKXz4WoPD9f
         JaD5rqn2V/q0QsAle6HTgVCAO+0AilAldZZM61I5JcbmLBwR8EMf8p/hjVMJg9sUYQ/n
         klijFpr/pUKM0IHMrXk+YPE+9OgA5f1e1pgXA1UYcV+TBCtW9MNL89qiAvAXSa/nwLK9
         IXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559409; x=1721164209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HchiMOrZAL17tWILJsEYcMV/aX1F31qPCjahGtHK6kc=;
        b=DNMJN/iz3S3QsfVYHPMbOWtEDm6igwb6HB/KdLhyAJz5XyN/cS+Ao9AjF9DJbUiug8
         OOo4/F6GfoHNcW7luKMUpC0eM8vKFDxFIueJtwd6olKCucDJw29WKUi2jd5HuS04D+c1
         pHBRnXvJef3VI6MHG3idWvXXpd1RRcJVM+fZKxbSa7RCb+kPqWpyyr0riDigoSUxUcyH
         ktImyntBjk1j4zI28ZqCX4uQ0vrd3QarVMm9w92vZE2kKDJaO/0oMSUHF5lVFqf4Tni7
         KqOM8ajRB8SiEBMHdrkqp6j9uFA1oWfsdJHXii0KFREQkWpaTgi5QBkoJAiYHxIhqt9T
         RrIQ==
X-Gm-Message-State: AOJu0YwiFp6vtuGmokCMaRFPlZ6rWJmYoqP+SrO52z9RmXTZtzefB1GU
	6X8la/auxBcB5ChwTAFxbW52YOMtCsD97zc6QEvFgRL0VjTvgRws
X-Google-Smtp-Source: AGHT+IHeYTMKwTJ6dcvzmUPv2V2TZgCV1JbLpiDZObRzo6mTzAyQ16BR3Jo3kd0m+l+gihzUJfQ9CQ==
X-Received: by 2002:a17:902:b603:b0:1f9:fca9:7433 with SMTP id d9443c01a7336-1fbb6d59efbmr27095845ad.34.1720559408659;
        Tue, 09 Jul 2024 14:10:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acfca3sm20921465ad.275.2024.07.09.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:10:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Reimplement scx_bpf_reenqueue_local()
Date: Tue,  9 Jul 2024 11:09:42 -1000
Message-ID: <20240709211001.1198145-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709211001.1198145-1-tj@kernel.org>
References: <20240709211001.1198145-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_reenqueue_local() is used to re-enqueue tasks on the local DSQ from
ops.cpu_release(). Because the BPF scheduler may dispatch tasks to the same
local DSQ, to avoid processing the same tasks repeatedly, it first takes the
number of queued tasks and processes the task at the head of the queue that
number of times.

This is incorrect as a task can be dispatched to the same local DSQ with
SCX_ENQ_HEAD. Such a task will be processed repeatedly until the count is
exhausted and the succeeding tasks won't be processed at all.

Fix it by first moving all candidate tasks to a private list and then
processing that list. While at it, remove the WARNs. They're rather
superflous as later steps will check them anyway.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 245254f7081d ("sched_ext: Implement sched_ext_ops.cpu_acquire/release()")
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f16d72d72635..0fabfe19327c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5628,8 +5628,10 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 {
-	u32 nr_enqueued, i;
+	LIST_HEAD(tasks);
+	u32 nr_enqueued = 0;
 	struct rq *rq;
+	struct task_struct *p, *n;
 
 	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
 		return 0;
@@ -5638,22 +5640,20 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	lockdep_assert_rq_held(rq);
 
 	/*
-	 * Get the number of tasks on the local DSQ before iterating over it to
-	 * pull off tasks. The enqueue callback below can signal that it wants
-	 * the task to stay on the local DSQ, and we want to prevent the BPF
-	 * scheduler from causing us to loop indefinitely.
+	 * The BPF scheduler may choose to dispatch tasks back to
+	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
+	 * first to avoid processing the same tasks repeatedly.
 	 */
-	nr_enqueued = rq->scx.local_dsq.nr;
-	for (i = 0; i < nr_enqueued; i++) {
-		struct task_struct *p;
-
-		p = first_local_task(rq);
-		WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=
-			     SCX_OPSS_NONE);
-		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
-		WARN_ON_ONCE(p->scx.holding_cpu != -1);
+	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
+				 scx.dsq_list.node) {
 		dispatch_dequeue(rq, p);
+		list_add_tail(&p->scx.dsq_list.node, &tasks);
+	}
+
+	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
+		list_del_init(&p->scx.dsq_list.node);
 		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+		nr_enqueued++;
 	}
 
 	return nr_enqueued;
-- 
2.45.2


