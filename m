Return-Path: <linux-kernel+bounces-240480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E5C926E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34870282AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA7179BF;
	Thu,  4 Jul 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1b+7Sn0"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54D225CB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064808; cv=none; b=NFxBeYcUr0mmwpm4mNJxfS70vfbRVwAoRHPpXC4psVz9T6WV6UOL3CrQUQ6CHo4W8NSoakJgLzXEni4octvUGA7l4phIY3C6wmg5MwZjznON2e+CPD/72HvOx8xsUlcaukRaegW9Um+4UylDRyvhnDHst0s4toSWmx5gS6lifos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064808; c=relaxed/simple;
	bh=F7aCnF4Je6kbJtXhbTta6MUDOKYAmrnnYkqPPL+OdX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcveuSrmvAC9KgckbyiW3NV7IrXwRIvZ4CFzKXRe9EtcFYEHBMRAnrJ5ctbiWSlTpoG6L1QoXIixgUKIncBIuReLMHtGpWVef4F6fH5kpwi5XIlzuM8MSSfxPyReiB3py+F2Wk8QOuaRRPnIsHvWAGuSPjVhxc3J0sA64pwOjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1b+7Sn0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d55ec570a7so141153b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064805; x=1720669605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFc3F8iNdhbsXcR87CPEXGUW+F2Z0/vpYoMjfJU+nAc=;
        b=c1b+7Sn08iKQBxj3vygk2r/8dYDoaGyW1AnuOcFi8ICJZBK7IGr9aJmY/8qW89Ah/O
         30Gxiq5CcyufSQFUzD/MwaamKavgMBjz6nM/LO5FYpYgvhE4Ax8DUA0BnIe5oqS9lvLR
         l1/fK7mf9VWfrnWDIrmZvq/wH6Byno57etzOj2g2laV17Hv0cHfnzsOxJXNRCjPueTe7
         WBDBcDsYpCIMwZHgaCNguCVgbIz01oI1OSKhJG4UOL6+jCcdr+jXiuI1apjLemvS7wNU
         8p08qOzZV/UGGBYHS5jFO0vzFmpuRpN0565l6UccqPPp6fr+ERz4py9gEenIWlZNdri2
         H0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064805; x=1720669605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFc3F8iNdhbsXcR87CPEXGUW+F2Z0/vpYoMjfJU+nAc=;
        b=wHoJGPPpiB5GVaUt68rBe5TtOVDGlIF1PGOL+DHjf3HIWasKAFmIuUURmgZx6QF8r3
         8+CR42ABAmSW7SSviOLMcL7T9RrvvUIBpD1ZRaCrt/+R1nHA/CwXPt9r/jKQEdslbbgL
         fqLr0pachVIteLGyx39j69W5/ZdP7tSN4KHEQhUy538UzHAMpQLeyEyO+EM7dI0UEcn3
         TdXFRDJVcZLM/xCoz+qvFIq90zYGZhK6teQayWdl1Bje9YTF+nixSNEv5M0EVMl9u+tg
         Y6RCbdZ0fsyt8tTCetigyt+24F5SV5hgvEBs5j18/dgVAo3mI97UAGESAQFXJ6SE5MXM
         PYCQ==
X-Gm-Message-State: AOJu0Yw1uZUBxvrne2unrTSARDISO7EDFqnd4qpcT7L78CVsdfAhc7UV
	ofgzqZHortvVaKvPtoak+AqLkFyLL0YKfXul4URZ+yylrNawV2qYeVNdhA==
X-Google-Smtp-Source: AGHT+IHr9kVQSQ0C/2Y1zxG7e5f08OcfVUYRLKIS4fRNxZ4bcWIzCIteoUkl+uki7QIswFN/hozTDA==
X-Received: by 2002:a05:6871:24d4:b0:25b:5032:25c5 with SMTP id 586e51a60fabf-25e2bf885a3mr413520fac.49.1720064805268;
        Wed, 03 Jul 2024 20:46:45 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8ed66sm11198550b3a.194.2024.07.03.20.46.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:44 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.
Date: Thu,  4 Jul 2024 11:49:13 +0800
Message-Id: <20240704034915.2164-5-jiangshanlai@gmail.com>
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
index cb496facf654..5129934f274f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5118,6 +5118,19 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
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
@@ -5429,6 +5442,9 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	bool highpri = wq->flags & WQ_HIGHPRI;
 	int cpu, ret;
 
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&wq_pool_mutex);
+
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
 	if (!wq->cpu_pwq)
 		goto enomem;
@@ -5461,20 +5477,18 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
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
 
@@ -5681,15 +5695,15 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 			goto err_unreg_lockdep;
 	}
 
-	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_node_nr_active;
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
+		goto err_unlock_free_node_nr_active;
 
 	mutex_lock(&wq->mutex);
 	wq_adjust_max_active(wq);
@@ -5697,7 +5711,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	list_add_tail_rcu(&wq->list, &workqueues);
 
-	mutex_unlock(&wq_pool_mutex);
+	apply_wqattrs_unlock();
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -5707,7 +5721,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
-err_free_node_nr_active:
+err_unlock_free_node_nr_active:
+	apply_wqattrs_unlock();
 	/*
 	 * Failed alloc_and_link_pwqs() may leave pending pwq->release_work,
 	 * flushing the pwq_release_worker ensures that the pwq_release_workfn()
@@ -6996,19 +7011,6 @@ static struct attribute *wq_sysfs_attrs[] = {
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


