Return-Path: <linux-kernel+bounces-266521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1D94010C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22651F22F89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC018EFC6;
	Mon, 29 Jul 2024 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbHp6JLj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DF18EFFE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292083; cv=none; b=NCqTe388a2RjEyo7yE4GwYGIZTIGH/PWzf2RUm3Xlian/OX6yoXowzq8oAX9mzGzjqmQ4J4bEeNItDRV5nojiqt2rCLf7t+spEqE7NP6qeFqxdnLDUlkZhWVHggnQzIQ/uu9HU+qJ9zorAJwPIYd4TZDw4JeK55HF5maVExvdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292083; c=relaxed/simple;
	bh=CEko05szOCw0XiJtm9L2zhHDjsOD8IGT7jJQzada6fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qelBAJ/mm4GFHqs6smNoWsoOsuiaLcd9m9ki4EQpdC/QLVhfdweoVoSf1x5oHsf/kM62Wj05hVb8Eyg1KgaaK/rkUi6qltT5rY2cGdPQUruqPawnhOjH2J4KuqiUzBqGAPoI2SQMtdKcD8hZx3x3Xpw1JypEHpudgV6l2/4o/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbHp6JLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722292080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bx7PoZA+3BaXuBlEAlsF0yYgH6+llN/9+YIdocNVsPk=;
	b=UbHp6JLjGIuxpf5ahVQ2PZeX13w0NB1CYdSXojG3MH8biNZNag7kF+sX5o+TZO3+zAsMLk
	cmE+k+/BxcQVzWRh2G8IYgwyS68T3qz1+PvBj6ESOBSVCGdyEXiqe6unBpQ+YJQB/A9egu
	GcCjCOjT1lqPkb0BGcUtnd1eThiIT+4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-zMAMeneGNAWQ5cntbgBMYQ-1; Mon,
 29 Jul 2024 18:27:53 -0400
X-MC-Unique: zMAMeneGNAWQ5cntbgBMYQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA261955F49;
	Mon, 29 Jul 2024 22:27:51 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.10.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 290111955F3B;
	Mon, 29 Jul 2024 22:27:47 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Barry Song <baohua@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Rafael Aquini <aquini@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC 1/2] mm: defer THP insertion to khugepaged
Date: Mon, 29 Jul 2024 16:27:26 -0600
Message-ID: <20240729222727.64319-2-npache@redhat.com>
In-Reply-To: <20240729222727.64319-1-npache@redhat.com>
References: <20240729222727.64319-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

setting /transparent_hugepages/enabled=always allows applications
to benefit from THPs without having to madvise. However, the pf handler
takes very few considerations to decide weather or not to actually use a
THP. This can lead to a lot of wasted memory. khugepaged only operates
on memory that was either allocated with enabled=always or MADV_HUGEPAGE.

Introduce the ability to set enabled=defer, which will prevent THPs from
being allocated by the page fault handler unless madvise is set,
leaving it up to khugepaged to decide which allocations will collapse to a
THP. This should allow applications to benefits from THPs, while curbing
some of the memory waste.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 include/linux/huge_mm.h | 15 +++++++++++++--
 mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..7ef7d3e2f5c6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -45,6 +45,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
 	TRANSPARENT_HUGEPAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+	TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
@@ -125,6 +126,7 @@ static inline bool hugepage_global_enabled(void)
 {
 	return transparent_hugepage_flags &
 			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
+			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG) |
 			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
 }
 
@@ -134,6 +136,12 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+static inline bool hugepage_global_defer(void)
+{
+	return transparent_hugepage_flags &
+			(1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG);
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
@@ -243,13 +251,16 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long tva_flags,
 				       unsigned long orders)
 {
+	if ((tva_flags & TVA_IN_PF) && hugepage_global_defer() &&
+			!(vm_flags & VM_HUGEPAGE))
+		return 0;
+
 	/* Optimization to check if required orders are enabled early. */
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
-
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
-		if (hugepage_global_always() ||
+		if (hugepage_global_always() || hugepage_global_defer() ||
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
 			mask |= READ_ONCE(huge_anon_orders_inherit);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..a2975ad2cd91 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -294,12 +294,15 @@ static ssize_t enabled_show(struct kobject *kobj,
 	const char *output;
 
 	if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags))
-		output = "[always] madvise never";
+		output = "[always] madvise defer never";
 	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags))
-		output = "always [madvise] never";
+		output = "always [madvise] defer never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always madvise [defer] never";
 	else
-		output = "always madvise [never]";
+		output = "always madvise defer [never]";
 
 	return sysfs_emit(buf, "%s\n", output);
 }
@@ -312,13 +315,20 @@ static ssize_t enabled_store(struct kobject *kobj,
 
 	if (sysfs_streq(buf, "always")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+	} else if (sysfs_streq(buf, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG, &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
 	} else if (sysfs_streq(buf, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG, &transparent_hugepage_flags);
 	} else
 		ret = -EINVAL;
 
@@ -817,18 +827,31 @@ static int __init setup_transparent_hugepage(char *str)
 			&transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
+			  &transparent_hugepage_flags);
 		ret = 1;
+	} else if (!strcmp(str, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
+			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
+			  &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
+			  &transparent_hugepage_flags);
 	} else if (!strcmp(str, "madvise")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
+			  &transparent_hugepage_flags);
 		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
-			&transparent_hugepage_flags);
+			  &transparent_hugepage_flags);
 		ret = 1;
 	} else if (!strcmp(str, "never")) {
 		clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
 			  &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
+			  &transparent_hugepage_flags);
 		ret = 1;
 	}
 out:
-- 
2.45.2


