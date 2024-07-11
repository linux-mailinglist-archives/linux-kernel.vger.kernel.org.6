Return-Path: <linux-kernel+bounces-248826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3E92E277
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789B628843C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE3155CBA;
	Thu, 11 Jul 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzHR25+"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD41150992
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686785; cv=none; b=giarAHE8SMfkT8NpZHRgN7G+Z3zrWBTt/qtp0LoKNLtUPNj7uATRFJ5Hz/7/E9cOqsh8aA+is7ddZC9UrxducOvGoWHHdCYh3WWR25xi1MrtioTdBNZ6JsEORW1qGO94cEUPYaPAp9hOZvLBaaYNsPnAkCtCzMgmdPc85BcvW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686785; c=relaxed/simple;
	bh=NruwJsFvwsSPkXYLJUwgKr+gFvQvXB2WWXCsPlIzVok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6tWcnesxdG6h5kRT94ELMAg0h9vyH/AaMluIwTtB9IPKD/mzj5m7ugnh2uQBj89kKiUH7gLa9b10mdJGcEKOfmr7W3DfRbqHu9EW9Cwsy/jB0nwfNXTPm3wLwhlSC0nScMBvb9qjCSvkJghXTlb7okmf/qwgP4WgE4PCOBJEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzHR25+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3815eaa136eso2393175ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686783; x=1721291583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1wTEq4Zj0zkb0J+FzMN27F+Tf2xE8G5ye4De2za5ow=;
        b=VOzHR25+L0TY6OSCXYbWF+JB5VYI2LbPbGXiQJMsQgxiRCl1v7l0vmy5/4HYdLSjCp
         QYD1IZYFkzw+sj8j0LpCdoSJd1IIavWmdvzfjq3gipdq4NoKTUTuS9H2tcKfzyHTQAtN
         gNDrzlkLEf2Ouv8sDlO6sE426AQsGlzfdFbWUc0avUDEBPzBbCSY/z1uWBov16zjNX8e
         JPxwYMY1riNCyQYQACM8HJhw9sqN4AbEtLCoH9Wd3Er8JIZRZVolIv2L0QGYVo4fW3CF
         yjVhEv1x4JTKoddIvjw5q3JH+SOMtr+DpxrhEcZh701ejEGKQlRlapvIoLAjt2tmvwdZ
         lZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686783; x=1721291583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1wTEq4Zj0zkb0J+FzMN27F+Tf2xE8G5ye4De2za5ow=;
        b=jssFrq1nsezn80+iRb1KSDksrZcNIbUsnY4YNxa4W7Q7S1gsFCNSRkkixsJb9+JKMQ
         8D5Ozk8/pkEHVtZ+cK7XnAd/q7OP5VYkCizp5MQGx8m5weW5ICF9au5eMLRKxWQsndVA
         1k5JMVI+nv1ZDfXovYSW/6oznXAlU7jRzjns47ODx/pC2VcfYR5bKEjFC8GaWllt8oJE
         prPxy0Z09PbBqooJ7R4xoHbqCFB/m2ZuJtg+I8TalWjDtUHwkpU/VhQKAuqGxqqrVKiZ
         v7elkuYjarTBhGXKnewy4OYIKIEsZmMU1as3TJUqEZqk+5iQ1BGL0qZ1TrVh26gLcyEv
         92Hw==
X-Gm-Message-State: AOJu0Yxc1bAau/TUcZCe03oM+feAO8zTcnCyGb0ecqdk9vXsL4u6pFCz
	A3uB0hypKMrZJMkQkIN9p352R0qRO9P+Zg12WdNmulKRUz96TI3bB862Yw==
X-Google-Smtp-Source: AGHT+IGidlC9pHkyhf3IQ8ixSjKuNzH9IdxH5up1iWrP0qK75V5ZBnOhGrLc2YyQAES6dlkoiVhrGQ==
X-Received: by 2002:a05:6e02:170c:b0:382:325c:f7be with SMTP id e9e14a558f8ab-38a570fb1f2mr96676875ab.4.1720686783107;
        Thu, 11 Jul 2024 01:33:03 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397f32csm5267425b3a.146.2024.07.11.01.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:02 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/7] workqueue: Add wq_online_cpumask
Date: Thu, 11 Jul 2024 16:35:41 +0800
Message-Id: <20240711083547.3981-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The new wq_online_mask mirrors the cpu_online_mask except during
hotplugging; specifically, it differs between the hotplugging stages
of workqueue_offline_cpu() and workqueue_online_cpu(), during which
the transitioning CPU is not represented in the mask.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5d362290c2e8..985ab9230fe0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -444,6 +444,9 @@ static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 
+/* PL: mirror the cpu_online_mask excluding the CPU in the midst of hotplugging */
+static cpumask_var_t wq_online_cpumask;
+
 /* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
@@ -6583,6 +6586,8 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	mutex_lock(&wq_pool_mutex);
 
+	cpumask_set_cpu(cpu, wq_online_cpumask);
+
 	for_each_pool(pool, pi) {
 		/* BH pools aren't affected by hotplug */
 		if (pool->flags & POOL_BH)
@@ -6629,6 +6634,9 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	/* update pod affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
+
+	cpumask_clear_cpu(cpu, wq_online_cpumask);
+
 	list_for_each_entry(wq, &workqueues, list) {
 		struct workqueue_attrs *attrs = wq->unbound_attrs;
 
@@ -7650,10 +7658,12 @@ void __init workqueue_init_early(void)
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
+	BUG_ON(!alloc_cpumask_var(&wq_online_cpumask, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
 
+	cpumask_copy(wq_online_cpumask, cpu_online_mask);
 	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
 	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
 	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TYPE_DOMAIN));
-- 
2.19.1.6.gb485710b


