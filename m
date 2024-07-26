Return-Path: <linux-kernel+bounces-263071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65C93D09B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E5228237C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8DA178CF2;
	Fri, 26 Jul 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTRkgLU4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1F17836C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987256; cv=none; b=hJHA79Jl3psqW16EjcTX8MuSY5X2SCDdNlqLMsmByUTJWHBV/FD+EqN5hMHXwghpbyH+bkAbv/Y7vMJXvSRyR0/W/rNBoDyfJYkIcBlSCD03+ZyPppr69x3OpuQEej5CK4qlJI4zrpcJmHqP4ktaOkxeI7VccB9qAs1IaIAf3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987256; c=relaxed/simple;
	bh=bXOB40B+8P35FLMeevMSsTouLOFbjy0oSgq6ugv5yjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nocms/58LNNenvMM9m5T+c8CPOODVi/1dFf8Tegf8XcJCHm0IsRG+JtHeCfFU2UWbrws1Nvg+VPz5eDDu6m9y/yqd3C8TQIM8i57QKKZ76t/Np/VkpT3d4CRzDMFvtxJ652wJDSYqOwRolIk7F4kbuLnlno+idS+l3wrM0UydVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTRkgLU4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fccdd78so3606985ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721987254; x=1722592054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXeSWJ/2XL0C00VB4D2wsSnDGte33aaztEw6N6+DVHo=;
        b=NTRkgLU4uPMNfQOhmS6daoTqhdwamv1HkJAZgu2DGpyHvsQsD6XKJqv9Tn/+WQEVaS
         KoDwpHKJWD8tnglIuczgZrgjkYrsxjlK629LrXB/Sa8+fwbdpQjBgvasuYJYMzDkTV5F
         08Fwg6CcG3Z/OF2vM62rA00UEqodQ7dkAm56m8G1KIR0TSRP+WKANddGfK9CrQXuii8C
         RS8J5i0kp8sHltXpxbDjiSnQyMRhJWTZdG72SBfi84J0Bkl1fdprfE1L7BaXQGqnDJyI
         O4a1tVdtkOQ1rtsTDG64t5ZZX688WBG41t5MzZCSXz6cTZdwNVVsOqiyvuqQrgZtGNQ2
         p3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987254; x=1722592054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXeSWJ/2XL0C00VB4D2wsSnDGte33aaztEw6N6+DVHo=;
        b=YhRX64vyBxcvZ0L9cbbuhBYPiTuSxAcoGIJaLEp5oT+YVl71cgoXNC3OLGWnz8Rwr7
         GiE1/MTClOiyTe5V+a6rhnM50SZY4uEwvFqw1mhFMuDft85hXBrk50dMCX8zlj9cYeBD
         hOTIytPunc9L2tCtzwtQZ8G/X5NoTmnO2lm6KlMOyT6tL4uRM5bSP4/CBWaU0ZXG82bM
         iDoTj9zU86D73tn1lwnDGSO7UyGXxg/K8SIjQOjnvssxfMtrq89PwNjNTL7fEnvxKV69
         nqneO/bdDLrf4HDbnwYmRNc3LKCZcaZrxj0x8uHfQTgMP5Dl51k6SduWQBkYRYeYZr0Q
         LFFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6mRUv1ajYp/tHHvcHnK2XgDZcYXI8L6SQaxFhT0SRB+GVan5shnvwK1+VUJf6LsXSZ8F++B1PxcvqVJLmGP1Py3IRM1h49AufwBy
X-Gm-Message-State: AOJu0YyMk2fi/OMHbZ4eaZP/6LqO7vn8ZIpEpOVRzsvDkQJNwMX33vc7
	/RVIgyUEfzSpQ2k5VJNGDJZv+M9FTgmq4lUytBTf8CLu0SIhkjf4
X-Google-Smtp-Source: AGHT+IEsB98ir1v1O+pC1M3K6sUPTrlIGX/N1CqYehZBqQeCofKQvFrGpl3C0i9QXGJhDvMHh4MUqQ==
X-Received: by 2002:a17:902:dacc:b0:1fd:95ac:506b with SMTP id d9443c01a7336-1fed3af263fmr68421725ad.64.1721987254203;
        Fri, 26 Jul 2024 02:47:34 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm28127455ad.99.2024.07.26.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:47:33 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ying.huang@intel.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	yosryahmed@google.com
Subject: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Date: Fri, 26 Jul 2024 21:46:18 +1200
Message-Id: <20240726094618.401593-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726094618.401593-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Quote Ying's comment:
A user space interface can be implemented to select different swap-in
order policies, similar to the mTHP allocation order policy. We need
a distinct policy because the performance characteristics of memory
allocation differ significantly from those of swap-in. For example,
SSD read speeds can be much slower than memory allocation. With
policy selection, I believe we can implement mTHP swap-in for
non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understand
the implications of their choices. I think that it's better to start
with at least always never. I believe that we will add auto in the
future to tune automatically, which can be used as default finally.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  6 +++
 include/linux/huge_mm.h                    |  1 +
 mm/huge_memory.c                           | 44 ++++++++++++++++++++++
 mm/memory.c                                |  3 +-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..2e94e956ee12 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -144,6 +144,12 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
 sizes, the kernel will select the most appropriate enabled size for a
 given allocation.
 
+Transparent Hugepage Swap-in for anonymous memory can be disabled or enabled
+by per-supported-THP-size with one of::
+
+	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/swapin_enabled
+	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/swapin_enabled
+
 It's also possible to limit defrag efforts in the VM to generate
 anonymous hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..25174305b17f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -92,6 +92,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
 #define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
+#define TVA_IN_SWAPIN          (1 << 3)        /* Do swap-in */
 
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0167dc27e365..41460847988c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -80,6 +80,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+unsigned long huge_anon_orders_swapin_always __read_mostly;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -88,6 +89,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 {
 	bool smaps = tva_flags & TVA_SMAPS;
 	bool in_pf = tva_flags & TVA_IN_PF;
+	bool in_swapin = tva_flags & TVA_IN_SWAPIN;
 	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
 	unsigned long supported_orders;
 
@@ -100,6 +102,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
 
 	orders &= supported_orders;
+	if (in_swapin)
+		orders &= READ_ONCE(huge_anon_orders_swapin_always);
 	if (!orders)
 		return 0;
 
@@ -523,8 +527,48 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 static struct kobj_attribute thpsize_enabled_attr =
 	__ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
 
+static DEFINE_SPINLOCK(huge_anon_orders_swapin_lock);
+
+static ssize_t thpsize_swapin_enabled_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	int order = to_thpsize(kobj)->order;
+	const char *output;
+
+	if (test_bit(order, &huge_anon_orders_swapin_always))
+		output = "[always] never";
+	else
+		output = "always [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t thpsize_swapin_enabled_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int order = to_thpsize(kobj)->order;
+	ssize_t ret = count;
+
+	if (sysfs_streq(buf, "always")) {
+		spin_lock(&huge_anon_orders_swapin_lock);
+		set_bit(order, &huge_anon_orders_swapin_always);
+		spin_unlock(&huge_anon_orders_swapin_lock);
+	} else if (sysfs_streq(buf, "never")) {
+		spin_lock(&huge_anon_orders_swapin_lock);
+		clear_bit(order, &huge_anon_orders_swapin_always);
+		spin_unlock(&huge_anon_orders_swapin_lock);
+	} else
+		ret = -EINVAL;
+
+	return ret;
+}
+static struct kobj_attribute thpsize_swapin_enabled_attr =
+	__ATTR(swapin_enabled, 0644, thpsize_swapin_enabled_show, thpsize_swapin_enabled_store);
+
 static struct attribute *thpsize_attrs[] = {
 	&thpsize_enabled_attr.attr,
+	&thpsize_swapin_enabled_attr.attr,
 #ifdef CONFIG_SHMEM
 	&thpsize_shmem_enabled_attr.attr,
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 14048e9285d4..27c77f739a2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4091,7 +4091,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * and suitable for swapping THP.
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+			TVA_IN_PF | TVA_IN_SWAPIN | TVA_ENFORCE_SYSFS,
+			BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry), vmf->address, orders);
 
-- 
2.34.1


