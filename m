Return-Path: <linux-kernel+bounces-243776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70284929A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2302811A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E73EDB;
	Mon,  8 Jul 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqV03JSK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80228628
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720400423; cv=none; b=pXZmJLishIoRTCzWhdIMmMgWmZz2GNMTz3A1nXqtoCrJPFk8QlMgkC1+dSl1pT/867ZNlKsDn6K7M4DL4TKF5XFsLesClsvaljRTeYJ8R1ZOSSCXFD18okpKxzAOOoG7aUn9xpYT743CcaUBIqoB/gOoIsZggLL1NVnp/WBV880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720400423; c=relaxed/simple;
	bh=KJNOyTeAgP0fiV8du1sY1ijqlPN56MAk180oNB0RFmw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o+YV+GVqswAA2OHHQ/PE6UYkC5yZGpXcY1yGO/RH5cvsuPK8+90o2+uDBUOcMgLvZTi4KJ9gsQGu3c6P8zyznVQ9X1ECT50FzMSptGLjpw0SPugCtuJbwpVqI+sHxr6ymfPc/WPpEksewfHVwqBHIOkl7dMYD3450tG5cYYI1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqV03JSK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77e392f59fso137959966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720400420; x=1721005220; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3NdiAyId3OkrVUGqOgRgAW66faEghB0UHBtTZW80kM=;
        b=LqV03JSKQUrPdKAr3DkEdeLpoO5KEeiAfNVK678DhoiTAIuOfNxADyngA9pMeKpucv
         dj82rf07KwrrLSzzBIWs5inGgqpU2irAByF2dtu03j++NVsC4Cm6gSQ0M4wN0h95YZcs
         6mL4sQ3+vxqQmaKgBxRgJrND61Rr/HC10WKhyA/PSllcKpj4yP0pJJQvqE44s10pmXD3
         TIs9YOcA59GJzlKI3esywcXKqdDaHH8K29XS4qSbQK0XwNrWbdYkF5UK9i+kP9imRIB5
         oeISPcxf8LlMRAW7PD1bpDcG+ANH3Nw1SzDbis/DokBvIchEd1oCGU/3bqp2Ia7G5Xnz
         l43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720400420; x=1721005220;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3NdiAyId3OkrVUGqOgRgAW66faEghB0UHBtTZW80kM=;
        b=c1N4Fue45FiICcWc6FIlw66LavVBckLm6Rj8rUFuxELesnr/8UgWkM7jl+6Qmk3pnx
         t6s/y6erCusa/+WcHpunD20EuC6Mi+BOxTj54OVLFDDTVF1Y2q2f3R+cdi/RECdp4w8d
         AGwMf9TeuCdTsLE2/3aEVI5H5GNC+NCHfSa43USC8Y3eMLpD8QxctD5En8rgztt7ruwb
         5JnNG1J7zZQfHddGO0GHKiDqz0qkngwCpFnDW5qbRy158fktOf4Lh71QC0JKi5sZ5ujS
         sjCOz3nc+4e+pu30H/cJZCZRt4NlesngshzmQj/ZhI1gJx9vERbkhlXtrLKJBAnN8hMZ
         TNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXI+ldfTGGdHM3wvT1HhdE1F4vXYOjIi7jbp4+oYmmPbnxYxqsTOfvuYnqShrM97GOPDtvaSHwEKI/Xqk5pNyNRYpPG+l+ClV2ovSLB
X-Gm-Message-State: AOJu0YyhsqzPx93XN5YCZAywpkP9WbrNdVT6CTEZb9BGKvAqvO+Mj8sW
	mIK2e9vDJbfk0vpi4lyyfmjM2MhQAVHMV3ugDxLpJZ0Vo4lXrR28
X-Google-Smtp-Source: AGHT+IH0ggJbCGlEbdNIAlUNjEkV2/8ro0xOqCXLERCyOHyPaxPfuby2ZfgoB96xxYv+uuaOgXO/Tg==
X-Received: by 2002:a17:906:34d3:b0:a6f:3155:bb89 with SMTP id a640c23a62f3a-a77ba72759cmr734858766b.70.1720400419585;
        Sun, 07 Jul 2024 18:00:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e3f48abcsm175087666b.186.2024.07.07.18.00.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2024 18:00:19 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 1/3] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
Date: Mon,  8 Jul 2024 01:00:08 +0000
Message-Id: <20240708010010.32347-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During bootup, system may need the number of free pages in the whole system
to do some calculation before all pages are freed to buddy system. Usually
this number is get from totalram_pages(). Since we plan to move the free
pages accounting in __free_pages_core(), this value may not represent
total free pages at the early stage, especially when
CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

Instead of using raw memblock api, let's introduce a new helper for user
to get the estimated number of free pages from memblock point of view.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v4: adjust comment per david's suggestion
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40c62aca36ec..7d1c32b3dc12 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+unsigned long memblock_estimated_nr_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index e81fb68f7f88..26162902789f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1729,6 +1729,26 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+/**
+ * memblock_estimated_nr_free_pages - return estimated number of free pages
+ * from memblock point of view
+ *
+ * During bootup, subsystems might need a rough estimate of the number of free
+ * pages in the whole system, before precise numbers are available from the
+ * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
+ * obtained from the buddy might be very imprecise during bootup.
+ *
+ * While we can get the estimated number of free pages from memblock, which is
+ * good enough for estimation.
+ *
+ * Return:
+ * An estimated number of free pages from memblock point of view.
+ */
+unsigned long __init memblock_estimated_nr_free_pages(void)
+{
+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+}
+
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.34.1


