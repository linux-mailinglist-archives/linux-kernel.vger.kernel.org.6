Return-Path: <linux-kernel+bounces-240481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E22926E30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A8F1C21B73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC249637;
	Thu,  4 Jul 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQglAF+U"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B228689
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064810; cv=none; b=n4VSqaG51Ix5+U0MHNYSlSWsCiRZ+Ins50qD107c0fuRdiUKFSjk8FhJRWVI8izEF62gkW9+ElT1awiDugpL6icjNbdOjg5C/D4YSXni1nf2Xz1QsoxWsAcNefnk2hDZZRMGXyF3x31m85BBLdLKS6bUeYZWQlpL2TniEuWxMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064810; c=relaxed/simple;
	bh=K4rtmrLNi14w4YzsqMgiSYpk3M98BPsm1zUFfbKCC8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXKvOxFYp1S2JIOLoZnYrODtj7JYsXk3e7DIUzSFpPWn0q9ec8RTa7DySeH+c0T+yfwqo/hHSjdGhCVzLVQZdgW9hpkK8Stf4IhLaGlz+/pkuL6ZIQT1VJ79LBOHssXSZp3uBHTinW5ppRy8/vQcj8WfYAqUHfMrQTMywYC0RN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQglAF+U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f65a3abd01so1056765ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064809; x=1720669609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEZIajJ5x1uDp1oDsc7fJuYQkx1ZEDuNq4jcMhzNBkY=;
        b=aQglAF+UePSccC7knU+fO9OZIocXRQ4RyyGgkRPCWwq/veuvTGQYrIkeW+bkgPHrW1
         y+vsmlCFaFqEDVDP89GaDT7bALUCN+iqiR47rOI3qLVqOSgwEbh2qEeRvOwedAChARWP
         pmBnwUPR9mA/ye69H6mdvm4MKNkxiKK6zZXgH8FIWEmU6Xf6r2jfVEMAwUsuP/X5o+cQ
         GJtha/ARRqEv2xH9b4UDdIa5cpf50wIjdPm8alXC50WS/ZCm5pxSebXTBWkDEA4hHpHn
         FYGXEJM77WZ6lYNP8PphxhsySM0Nrui4NKLYomX4LObMtrdy5ZcG/gTyWDkwlv8NexzK
         ANEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064809; x=1720669609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEZIajJ5x1uDp1oDsc7fJuYQkx1ZEDuNq4jcMhzNBkY=;
        b=QER5RPC/OSj+jNt2bWO+u2bELpo6tDZj1X4mL508WlQmfO+GPfupw5paU6cBxpVBxz
         DS1j4DAbr7CKCOWMhR7N94LPEEsrpGVDXvKQUl2PnWaVNcnF8G2H+Xu87x0P2AbejBSi
         q17+Tmym+na/Z7/gBRdwC5xZDb9zlc//bzmqXW+2jMMY+k2xJhmKW+OV3VIDuh3YVLWN
         lfEiR4Kiquz33HNZ1cDaOQ3SzvTCwq1ItokXQ+tcX+nEmTGYoB+VD+fK2Z2jcF5auOlr
         z6ExrRzUoqbuuBlGHlxpHz+2DJhdtICnKC5No5PM+Au5GmcjXblHcVgVCqj2xgMNC4ZC
         +pcQ==
X-Gm-Message-State: AOJu0YxLnvfaiNTI37TNMydaEsBizJoRwhwF3iS61RUraxZxv/EbBFv5
	on7YKREbEhZ3+OG55JaX6vOVpaZbQ8E8Ms4C0Xed9Q1cGVY5fI6K7cSFQw==
X-Google-Smtp-Source: AGHT+IGJCmlV38zkfWrTZnePXV+rycLN0IYhkk8Uty0VL/OySveC3cSxL49MkXd8yDUOHWGMy++Uow==
X-Received: by 2002:a17:902:6548:b0:1fb:32fd:8d61 with SMTP id d9443c01a7336-1fb33f29a00mr3415785ad.68.1720064808485;
        Wed, 03 Jul 2024 20:46:48 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb24fbd598sm13033655ad.199.2024.07.03.20.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:48 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2 5/5] workqueue: Init rescuer's affinities as the wq's effective cpumask
Date: Thu,  4 Jul 2024 11:49:14 +0800
Message-Id: <20240704034915.2164-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240704034915.2164-1-jiangshanlai@gmail.com>
References: <20240704034915.2164-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Make it consistent with apply_wqattrs_commit().

Link: https://lore.kernel.org/lkml/20240203154334.791910-5-longman@redhat.com/
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5129934f274f..8b2a0fe4a85e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5525,6 +5525,8 @@ static int init_rescuer(struct workqueue_struct *wq)
 	struct worker *rescuer;
 	int ret;
 
+	lockdep_assert_held(&wq_pool_mutex);
+
 	if (!(wq->flags & WQ_MEM_RECLAIM))
 		return 0;
 
@@ -5547,7 +5549,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
-		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
+		kthread_bind_mask(rescuer->task, unbound_effective_cpumask(wq));
 	else
 		kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
@@ -5711,10 +5713,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	list_add_tail_rcu(&wq->list, &workqueues);
 
-	apply_wqattrs_unlock();
-
 	if (wq_online && init_rescuer(wq) < 0)
-		goto err_destroy;
+		goto err_unlock_destroy;
+
+	apply_wqattrs_unlock();
 
 	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
 		goto err_destroy;
@@ -5739,6 +5741,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;
+err_unlock_destroy:
+	apply_wqattrs_unlock();
 err_destroy:
 	destroy_workqueue(wq);
 	return NULL;
-- 
2.19.1.6.gb485710b


