Return-Path: <linux-kernel+bounces-238764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF6924FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5CA1F24B13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A249641;
	Wed,  3 Jul 2024 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8/18Mb3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBC49634
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977791; cv=none; b=JK8ACXRMoEnwDvM9M1vTDH8rn7+lurwy2h2/xgsHmJwFbx+cxmaBocL5j+2wuK0eF2/JrCGBG10a/T/RmM6Dz4c5K5J007Ym0EP+IYruom8mgDzEitMUVTI9CPAnbssqL8hKR7c2J+c6GzSLvAn3MB+q0JghKIb9Cu5eTELZHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977791; c=relaxed/simple;
	bh=BnF5+73szihYvqj0zHvkWllxCXsDLQRml8Xqbpqd6HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnA/oIGDEtppJgPnMGvZW3EWAuVwMhQowHmT/EPrrsy15VBNlq1wB9+NQPAHky03gpVjSRMhrYWhqbv8MoBE9LtwFOY+jT/ns1pppZpyDseYFbUY6K7lT+jWFvIoBNIiyVvh+E4ycvs2OI4OtaPSyooc41fQpk3R5Buiphx7yYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8/18Mb3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7066a4a611dso3172532b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977789; x=1720582589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za6+QBdr6NNfCmuy1fTZl6euOgrMMXbb01qR6g9M+Jc=;
        b=K8/18Mb3jEwjEYwug3+uB1JTy7/7PLaLX4PoUsQkFesXKfELvV6aaVDtvYVM3g74AT
         oVbLC5WUKItEuXFoROO8Ydveg91kE+RejjbWq/l9WclqjNbDm4nlcSvUA2EIkeLCqQUR
         ahsnlg3sEpF3QSywGtPE56K9g5ocf+H6gtr3n/UqRwd9ptum0waQ/Me9wJSog3Y5WNYB
         2HYHUjJIQF8HvC6Kq6qGYGS/YlMR8AlopA1XDNzYBN23hHM2alA0UOik+CEJToE7/y+6
         jSGEtiLkta7fT5wS6FPMUoJPgN5SrrG/WuuMD3Nt9Nc0SOpXkUZ7gGERczIZzkb5IQB9
         tISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977789; x=1720582589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za6+QBdr6NNfCmuy1fTZl6euOgrMMXbb01qR6g9M+Jc=;
        b=ZESmcdy3q+kj7jfWCmDZrRv6q/bqnVklE3YRRqPny3N601gXoNpE1Tcp+q4SIyiRgU
         p7RQKG6uQNVQMHaRegy9mjOYodMerihuzF2VYQeyxXJsjSjVFMWPnOswT2fA10DyOZzw
         uPe0D3ff1WOl6/AkEoTkWGtGEVBtXcM8KMgBdJen4ek0ysZAfNgZdqYenSNeCp1STy1L
         oPGXpZYei2Sjud4785UBhqb7FfJGWvnOZJ3s1mehJdZZQFyFHtCu+GO2uHvFbdB7blvu
         Ez2eZQ3U8mZhNsJfbUOkW9m4f4HGXJPAHvefgpBhoolsbcYYQJ50hAIxa4nx2NQ/UWq5
         k3gQ==
X-Gm-Message-State: AOJu0YwrZyRXVdur8e7ZvDAsUvTm7ZLSbQWXzXfItmxVkehUb/vTLLnE
	J6TWHdDfghnQpKN/mnubxBblr6NWpesKbpzGKLP3NW/YtaGGBCxpF4Atlw==
X-Google-Smtp-Source: AGHT+IFjLx53PQoflrPWAjSDQDEOMNQXgVRKDKckBapjadOSjXPcX6m3NX4U62RjFW31ufOx+sUbsA==
X-Received: by 2002:a05:6a20:3948:b0:1bd:1d6e:d444 with SMTP id adf61e73a8af0-1bef60f3db9mr10995950637.2.1719977788757;
        Tue, 02 Jul 2024 20:36:28 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb19fabe98sm2311925ad.86.2024.07.02.20.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:28 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 6/6] workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.
Date: Wed,  3 Jul 2024 11:38:55 +0800
Message-Id: <20240703033855.3373-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240703033855.3373-1-jiangshanlai@gmail.com>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The PWQ allocation and WQ enlistment are not within the same lock-held
critical section; therefore, their states can become out of sync when
the user modifies the unbound mask or if CPU hotplug events occur in
the interim since those operations only update the WQs that are already
in the list.

Make the PWQ allocation and WQ enlistment atomic.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 54 ++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3203c67ec4cb..c910f3c28664 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5114,6 +5114,19 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 	return pwq;
 }
 
+static void apply_wqattrs_lock(void)
+{
+	/* CPUs should stay stable across pwq creations and installations */
+	cpus_read_lock();
+	mutex_lock(&wq_pool_mutex);
+}
+
+static void apply_wqattrs_unlock(void)
+{
+	mutex_unlock(&wq_pool_mutex);
+	cpus_read_unlock();
+}
+
 /**
  * wq_calc_pod_cpumask - calculate a wq_attrs' cpumask for a pod
  * @attrs: the wq_attrs of the default pwq of the target workqueue
@@ -5425,6 +5438,9 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	bool highpri = wq->flags & WQ_HIGHPRI;
 	int cpu, ret;
 
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&wq_pool_mutex);
+
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
 	if (!wq->cpu_pwq)
 		goto enomem;
@@ -5457,20 +5473,18 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 		return 0;
 	}
 
-	cpus_read_lock();
 	if (wq->flags & __WQ_ORDERED) {
 		struct pool_workqueue *dfl_pwq;
 
-		ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[highpri]);
 		/* there should only be single pwq for ordering guarantee */
 		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
 		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
 			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
-		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
 	}
-	cpus_read_unlock();
 
 	return ret;
 
@@ -5701,15 +5715,15 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_free_node_nr_active;
 
-	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_rescuer;
-
 	/*
-	 * wq_pool_mutex protects global freeze state and workqueues list.
-	 * Grab it, adjust max_active and add the new @wq to workqueues
-	 * list.
+	 * wq_pool_mutex protects the workqueues list, allocations of PWQs,
+	 * and the global freeze state.  alloc_and_link_pwqs() also requires
+	 * cpus_read_lock() for PWQs' affinities.
 	 */
-	mutex_lock(&wq_pool_mutex);
+	apply_wqattrs_lock();
+
+	if (alloc_and_link_pwqs(wq) < 0)
+		goto err_unlock_free_rescuer;
 
 	mutex_lock(&wq->mutex);
 	wq_adjust_max_active(wq);
@@ -5717,14 +5731,15 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	list_add_tail_rcu(&wq->list, &workqueues);
 
-	mutex_unlock(&wq_pool_mutex);
+	apply_wqattrs_unlock();
 
 	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
 		goto err_destroy;
 
 	return wq;
 
-err_free_rescuer:
+err_unlock_free_rescuer:
+	apply_wqattrs_unlock();
 	/*
 	 * Failed alloc_and_link_pwqs() may leave pending pwq->release_work,
 	 * flushing the pwq_release_worker ensures that the pwq_release_workfn()
@@ -7005,19 +7020,6 @@ static struct attribute *wq_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wq_sysfs);
 
-static void apply_wqattrs_lock(void)
-{
-	/* CPUs should stay stable across pwq creations and installations */
-	cpus_read_lock();
-	mutex_lock(&wq_pool_mutex);
-}
-
-static void apply_wqattrs_unlock(void)
-{
-	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
-}
-
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-- 
2.19.1.6.gb485710b


