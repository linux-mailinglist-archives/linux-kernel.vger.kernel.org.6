Return-Path: <linux-kernel+bounces-224064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E85911CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AE1F22D79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B716D33F;
	Fri, 21 Jun 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edU3hlkR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91316B75B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954999; cv=none; b=VHYfqiOgrslxJqtmOSDMr9AxJ+EL6GTI0+8LbMNp4b7Wk3eIY4WLRMT825RmCWI5atX4JLzhpI32zdSQB4dy/y+e490DbxdtqxxcTeVuz8jZcUraCJvxIubj7p4S+Y2cVx8bhnBBa6DUmw3n/F9EhlSAhsnhDic4FkAflnDBnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954999; c=relaxed/simple;
	bh=YjU2g1+wutM3QV7zQCcyIGcj/Ah5HqR145W3+dp7nGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1/2Ea3DrPJ6iqtasiXwekOo9JTTL5AXR8u1b1daS9iZxn/IB/sl3VwD2265330kq+ZSS6rQxHr15qSIEJoZqhgdNRLKXpopVcnfFzAUyopW312v3lYzK45D4Ce3PlU7IiC/mrTPW9kVKOt4LhwYrMqr4viqzvNYINQa6yTanE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edU3hlkR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705fff50de2so1200316b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954997; x=1719559797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeZC5A5/V+xzjKS1B6H8sOnZGAk45J9pzGB5ap2eybo=;
        b=edU3hlkRNJ7EquW52ZmX92KnrRKIVc8UwJXloElbUi8sh0vu1eC1NeWy2T8pp+BtkQ
         3kPZXmjnp+EL/er4m1xtlGS3VKNN6aL80LzAtDYXkJK7vUT63jyKC5Asa/FHAe8BWK2j
         YdBUjr+Xp0Dl+IXKHbfvsS0izeNNZy/HCBfdys9QN2xI3YT+rmC2jiu+sxrftbyCVuIN
         MN1c7UAMDs+ryaK9HzaPtr82JLWONIkXKRb4PQf7wXU2GT8jzjnOUjqQM47ykbzjCJzO
         tF9LZS7W48gAcEn/h96DQBRSK8vEaVOON9RYZIlJg8TImuCzFChU7nrBP+cDd5zRxrQs
         atSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954997; x=1719559797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeZC5A5/V+xzjKS1B6H8sOnZGAk45J9pzGB5ap2eybo=;
        b=cnFOc21tVz6MzrVVsX6uEO0/Rc8iS2Py+WO9cwY7xPL0DEdaLQ1qC5ZhAIL9VtjqhU
         HzF284MffZibC87ug/uDhlPrANrk854FiVMtjEwgiOVWhSu/T4xuxq0Zk7URudMw5hpa
         t/9MmZB6sj7susHMA2LxXKy4wPgGLN7AtDEFXOmJttUcnE/BTzISWpNbwi1YS9+tC064
         qmXmHOuuUPm7Sja9OQze1hH2FhKjoTtTd0OhSjUSvSfmSqd3hITO+944zoyS0byqkIp3
         rGsxqMdfTDCeDGe8biBil6fNfwU6Wkov47PGetFXeu0YFlpRdCve2VsohbOshahHh331
         aS6Q==
X-Gm-Message-State: AOJu0YyjSJrxdhb67dzZQdAhzIcC7k2c/4bWU0QIqSYeoooAPToGv3NP
	DkEegvxboBs+zmyAW7jY38JQJt0xCdk/9/fgeHgJbtIgOyCbSrv3exX7ew==
X-Google-Smtp-Source: AGHT+IEEm0KzKTm3QDcstJ8dzqqFHta5cOn9wM2z2Po/BXblNDT78pefyekYmDwGwgapjoYIbGUoQg==
X-Received: by 2002:a62:e309:0:b0:706:1ff1:c5ff with SMTP id d2e1a72fcca58-70628f770f3mr10844624b3a.1.1718954996685;
        Fri, 21 Jun 2024 00:29:56 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512cb0d8sm757616b3a.167.2024.06.21.00.29.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:29:56 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/4] workqueue: Remove useless pool->dying_workers
Date: Fri, 21 Jun 2024 15:32:25 +0800
Message-Id: <20240621073225.3600-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240621073225.3600-1-jiangshanlai@gmail.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

A dying worker is first moved from pool->workers to pool->dying_workers
in set_worker_dying() and removed from pool->dying_workers in
detach_dying_workers().  The whole procedure is in the some lock context
of wq_pool_attach_mutex.

So pool->dying_workers is useless, just remove it and keep the dying
worker in pool->workers after set_worker_dying() and remove it in
detach_dying_workers() with wq_pool_attach_mutex held.

Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e9ca42ef425a..dc9acf8ecd0c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -215,7 +215,6 @@ struct worker_pool {
 
 	struct worker		*manager;	/* L: purely informational */
 	struct list_head	workers;	/* A: attached workers */
-	struct list_head        dying_workers;  /* A: workers about to die */
 
 	struct ida		worker_ida;	/* worker IDs for task name */
 
@@ -2862,7 +2861,6 @@ static void set_worker_dying(struct worker *worker, struct list_head *list)
 	worker->flags |= WORKER_DIE;
 
 	list_move(&worker->entry, list);
-	list_move(&worker->node, &pool->dying_workers);
 
 	/* get an extra task struct reference for later kthread_stop_put() */
 	get_task_struct(worker->task);
@@ -4721,7 +4719,6 @@ static int init_worker_pool(struct worker_pool *pool)
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
 	INIT_LIST_HEAD(&pool->workers);
-	INIT_LIST_HEAD(&pool->dying_workers);
 
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
-- 
2.19.1.6.gb485710b


