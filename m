Return-Path: <linux-kernel+bounces-571746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8AAA6C1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189727A9829
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAB22FE07;
	Fri, 21 Mar 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h69hiyIf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297522F3BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578660; cv=none; b=oMvpxbnKXl/BjaWHiTLI/ePrPksNTS6H1YhY6ieZsFcNJbDEAcdY2/Vq5rvhmf1EREHlQvvnNevv4KGa2RWI1VXbMu5QjT684cbudQlRL3hbKg7Ii5RlVZH3vUNu+jRt6Yo/cYdkwA7uf5tnUtKsGBauLfnD7TWRB+Hh41uJe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578660; c=relaxed/simple;
	bh=9t2nY0/hLkwQPwl07fwQz0gTqSMVr2cWsh7a7QESHxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IAhY9EOzka6ZtxAUBcK4l4rTbi/GmHaUvje+I0e74sD2FReyeyd3p9W4Wxa1ZaV/r2VU/+WdHiZad+kzGx9SwLobc1cqfIorWDBeZrYCi7flvN5csIJ0Q7esQ8I0xt8EnqwhoeqDnuJ1hMlTxNBRgvhefafpfgBcu/Y7HSUkS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h69hiyIf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so3571196a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578659; x=1743183459; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhyKuUbIG2qUFhxjEu6Kg0kSJWlrJ10xlnpfsY0CXs8=;
        b=h69hiyIf8+dbSMlhG6Yu6cmF0bmaXuGxibvRbbR2vOP+IaJO33JbYULoHkiyEPY6WP
         kO4gl2YPCJaMaJKWTR53D3Vn4o6fWWRYEqwbb3ahNCsmCjB9r+XowWDBeiD3Uc+vFnrF
         eXvwOi7Y1P1Qmb+CTZvbmg6i1qyIwYhH5TY7WWy0F4rfpM+MqnZ8jSaUztUmybmlo53r
         llEEvv0kp98EhxRzjMjrWTyk7Jd+SQ2b5rlIQ9fU4H5U7zwPMo/RMt+JvLIXyiMouWgN
         DpwQJwbeFiIWkzEbxiva6NKIWTDLF5NXANfUSmjehrwySG2HpvAtoqJiyIykK2zV7p1J
         nPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578659; x=1743183459;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhyKuUbIG2qUFhxjEu6Kg0kSJWlrJ10xlnpfsY0CXs8=;
        b=DdMx32pj095r8LjEF+ciN73/4CW9pbW6aZ2NbHUmNfT3cpCGZBwC5y7yLHfIFtjUcl
         qfct53KHC/fUMBvrU9ENlXHNf8azWAeiD4tSOJklXvVLMYzTtNhobMhp6RYBEuDdTm57
         fVDnE2dSVEApyw220Q/6E64vW7fQSVU3mNqkT8hAA49iVyJ4JN6TIuSs9z+RAXjaABUX
         UemkDGQCd2vS5u+hNr2BTdvWB991OQhHtVLRbOIkalgrOjjda8tymctl8YnM36GD+XIk
         cJmwVgWTkNYGCoc6+UJDqawF15P7bUpmrbrjUGZ7PMZFGks4Yj5ZOBs1/PsLDUDmF3qd
         RhYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOcLLFj/V1Rj+89RrXhWH5fxOD6UOrK7cE+G+6Dom1HARzouCiLVc3XJn9Ya1tUiyp9sywXsEl2wxmjD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXXDDwMo+LUNvBJ2kr2KKtH/8/ftUUePxhX8K3D85g3E3x5Wj
	eRsbqt8SwMZtS62dZOATpxUm5R55Hnf/6+2Apu7a/rzez5aPlIK+lMFJloF7NgHsSP3R+UDvEGV
	asSkPFlwhNPFGjySx6PQeUw==
X-Google-Smtp-Source: AGHT+IErW6hIRZXrutBcTb+9kRL8XmrfeSil0yg5cL4+Y+ZPuvGKGUahbLis4vVKFNz4GDCbx8eM7VDHYQJtpswc8A==
X-Received: from pgar25.prod.google.com ([2002:a05:6a02:2e99:b0:ad7:adb7:8c14])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1582:b0:1f3:2e85:c052 with SMTP id adf61e73a8af0-1fe4330249cmr6556407637.35.1742578658785;
 Fri, 21 Mar 2025 10:37:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:26 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-4-souravpanda@google.com>
Subject: [RFC PATCH 3/6] mm: make Selective KSM partitioned
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Create a sysfs interface to partition the KSM merge space. We add a
new sysfs file, namely add_partition. Which is used to specify the
name of the new partition. Once a partition is created, we would get the
traditional files typcally available in KSM under each partition.

This sysfs interface changes are in preparation of the following patch
that shall actually partition the merge space (e.g., prevent
page-comparison and merging across partitions).

KSM_SYSFS=/sys/kernel/mm/ksm

echo "part_1" >  ${KSM_SYSFS}/ksm/control/add_partition

ls ${KSM_SYSFS}/part_1/
	pages_scanned       pages_to_scan   sleep_millisecs  ...

echo "pid start_addr end_addr" > ${KSM_SYSFS}/part_1/trigger_merge

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 mm/ksm.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b2f184557ed9..927e257c48b5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3832,7 +3832,17 @@ static ssize_t full_scans_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(full_scans);
 
-#ifndef CONFIG_SELECTIVE_KSM
+#ifdef CONFIG_SELECTIVE_KSM
+static struct kobject *ksm_base_kobj;
+
+struct partition_kobj {
+	struct kobject *kobj;
+	struct list_head list;
+};
+
+static LIST_HEAD(partition_list);
+
+#else /* CONFIG_SELECTIVE_KSM */
 static ssize_t smart_scan_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
@@ -4015,15 +4025,22 @@ static struct attribute *ksm_attrs[] = {
 
 static const struct attribute_group ksm_attr_group = {
 	.attrs = ksm_attrs,
+#ifndef CONFIG_SELECTIVE_KSM
 	.name = "ksm",
+#endif
 };
 
-static int __init ksm_sysfs_init(void)
+static int __init ksm_sysfs_init(struct kobject *kobj,
+				 const struct attribute_group *grp)
 {
-	return sysfs_create_group(mm_kobj, &ksm_attr_group);
+	int err;
+
+	err = sysfs_create_group(kobj, grp);
+	return err;
 }
 #else /* CONFIG_SYSFS */
-static int __init ksm_sysfs_init(void)
+static int __init ksm_sysfs_init(struct kobject *kobj,
+				 const struct attribute_group *grp)
 {
 	ksm_run = KSM_RUN_MERGE;	/* no way for user to start it */
 	return 0;
@@ -4031,9 +4048,81 @@ static int __init ksm_sysfs_init(void)
 #endif /* CONFIG_SYSFS */
 
 #ifdef CONFIG_SELECTIVE_KSM
+static ssize_t add_partition_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct partition_kobj *new_partition_kobj;
+	char partition_name[50];
+	int err;
+
+	mutex_lock(&ksm_thread_mutex);
+
+	if (count >= sizeof(partition_name)) {
+		err = -EINVAL;  /* Prevent buffer overflow */
+		goto unlock;
+	}
+
+	snprintf(partition_name, sizeof(partition_name),
+		 "%.*s", (int)(count - 1), buf); /* Remove newline */
+
+	/* Allocate memory for new dynamic kobject entry */
+	new_partition_kobj = kmalloc(sizeof(*new_partition_kobj), GFP_KERNEL);
+	if (!new_partition_kobj) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	new_partition_kobj->kobj = kobject_create_and_add(partition_name,
+							  ksm_base_kobj);
+	if (!new_partition_kobj) {
+		kfree(new_partition_kobj);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = sysfs_create_group(new_partition_kobj->kobj, &ksm_attr_group);
+	if (err) {
+		pr_err("ksm: register sysfs failed\n");
+		kfree(new_partition_kobj);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	list_add(&new_partition_kobj->list, &partition_list);
+
+unlock:
+	mutex_unlock(&ksm_thread_mutex);
+	return err ? err : count;
+}
+
+static struct kobj_attribute add_kobj_attr = __ATTR(add_partition, 0220, NULL,
+						    add_partition_store);
+
+/* Array of attributes for base kobject */
+static struct attribute *ksm_base_attrs[] = {
+	&add_kobj_attr.attr,
+	NULL,  /* NULL-terminated */
+};
+
+/* Attribute group for base kobject */
+static struct attribute_group ksm_base_attr_group = {
+	.name = "control",
+	.attrs = ksm_base_attrs,
+};
+
 static int __init ksm_thread_sysfs_init(void)
 {
-	return ksm_sysfs_init();
+	int err;
+
+	ksm_base_kobj = kobject_create_and_add("ksm", mm_kobj);
+	if (!ksm_base_kobj) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	err = ksm_sysfs_init(ksm_base_kobj, &ksm_base_attr_group);
+	return err;
 }
 #else /* CONFIG_SELECTIVE_KSM */
 static int __init ksm_thread_sysfs_init(void)
@@ -4048,7 +4137,7 @@ static int __init ksm_thread_sysfs_init(void)
 		return err;
 	}
 
-	err = ksm_sysfs_init();
+	err = ksm_sysfs_init(mm_kobj, &ksm_attr_group);
 	if (err) {
 		pr_err("ksm: register sysfs failed\n");
 		kthread_stop(ksm_thread);
-- 
2.49.0.395.g12beb8f557-goog


