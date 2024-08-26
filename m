Return-Path: <linux-kernel+bounces-302170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7167695FACB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7512856FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F519D08C;
	Mon, 26 Aug 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSwD8eln"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26019D07A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705050; cv=none; b=VrCZNx+u0+Tf6Ce6M1Fz556EdBbL2vldbwU1oJZDZw0hlllTI8MRNEGLVI3hHipw/Aq9d9yahfpyxaOjkaZIRShP600Q1Pp6iL8in+KYzQanvsKNgaZEkzTdvaHdJxH8ADUzrNyfvKUwuLnMoNDm0l7UczaK5DMJ/ibUtfAzje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705050; c=relaxed/simple;
	bh=cBR1CRPKBp17TA49iECdr5UwUokaTW4WPHX9nl57T+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkRMMhf9LCbI5moRIWWXJzpojF8hiPhtEtnR4Z6RfxMnI9x4FsVKmWfKVUZNXmsY5cY731hyJyxi4psFv2aTphU2y0PvrSBui+hsppT6OZ9Lynxy18wqxfw0uTv9RKhaLUYJcxPs+E0YDoWbp9uebdjpKltid+xcL4O/ND6WXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSwD8eln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD9ggS8OhpZf/NsZoH3fZjUIikns33eAnWwzmGyUsEI=;
	b=GSwD8elnSkUU0ri/z1c0FtxzSRtc8JfP+apWnD3UZDViRP5kShi4KjQ/I97emBPnEaLyuk
	Q6nZF/TVC8Nsf/aeEfSlj7IFv/CQ63o++L+HG+L4Nzsz5hkHbV7ExIwUMEsIHW7bD27KYQ
	cRhXBI+2yfogAGTver3Y/nwmA9fvIe8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--J0mzlJZMc6ryLmEliJ0aQ-1; Mon, 26 Aug 2024 16:44:03 -0400
X-MC-Unique: -J0mzlJZMc6ryLmEliJ0aQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1d06f8f03so562435485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705043; x=1725309843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD9ggS8OhpZf/NsZoH3fZjUIikns33eAnWwzmGyUsEI=;
        b=Xsa6In5q1W4zWBOOb5XBZ5S5whXugxMRD6mprFdy4uZ/jZDbqcWPYQsNPC+zLcM4Ws
         6VzbfpL6RrnUZUA4iY6llQ+oQ3PnoyEVY+mZ0a7ydVEAnF/BdOrfWbWexM8JRdTuUxjA
         x8Bb90J5oQSd/NC7OVW8oV3nla9pGvYxq8gim6VWMEhe6DmDRUunkfSpQYul0L9ohd07
         19m6f730nZm8UtOmaS+gb49o9CiJCsZsl0wL76v76pdJ4gCfbRS4GD9VHSkzW77xUlmu
         uWCjKFnQ4pj8A9D0L5q7Pr/Z3RV7Q4stoOK8znlAw/8hGtHlB1pcW9wfBq0IHjv6x9nF
         qXDw==
X-Gm-Message-State: AOJu0YyL/llOxfMY6WnSonWrvCum5Mhs6LS5qJxPdzZo+YLsuopjXP1T
	3ZigEm3Dd5xF1QXfhMnXY+dp0zKEfGZaG5vZSLUzSWv7LrfGvZh2e8c9Y5EhQ6H3j2eyDrTli0+
	uWZZKmfXbJ/BVaVuG8NQY05n6cE+aMzkrrwoACAk+fPdeGqF0KKhJUCfZXgytLjv30yrBSSsfAR
	ca+6kInFT/+EJm5CyLu+9Jn1SJ4HoXpE0SCWuLS3yu22I=
X-Received: by 2002:a05:620a:24d5:b0:7a3:6dd9:ef9d with SMTP id af79cd13be357-7a6897c6e76mr1277669085a.62.1724705042739;
        Mon, 26 Aug 2024 13:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIqrjqvJMs9Ym5fhhSHDCZDk2wQ6104PL5R9Vk0hTAFm1CUlIqFGQmzGdyDHGQhWdDyxioXg==
X-Received: by 2002:a05:620a:24d5:b0:7a3:6dd9:ef9d with SMTP id af79cd13be357-7a6897c6e76mr1277664185a.62.1724705042003;
        Mon, 26 Aug 2024 13:44:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 03/19] mm: Mark special bits for huge pfn mappings when inject
Date: Mon, 26 Aug 2024 16:43:37 -0400
Message-ID: <20240826204353.2228736-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need these special bits to be around on pfnmaps.  Mark properly for
!devmap case, reflecting that there's no page struct backing the entry.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3f74b09ada38..dec17d09390f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,6 +1346,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
+	else
+		entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1442,6 +1444,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
+	else
+		entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
-- 
2.45.0


