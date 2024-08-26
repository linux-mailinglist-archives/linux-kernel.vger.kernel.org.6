Return-Path: <linux-kernel+bounces-302173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB795FAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21270B21EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628A19AA75;
	Mon, 26 Aug 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy1+1mTn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F819DF63
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705055; cv=none; b=RSJIS9mep3eLT4pMNXGk4/mc6OjwSaiQhVAWg6sPTaElQ8NAH7cIDPgzs7LM8v2883xVkYwRWkQV9n81MGdT7zswjVsfz3QGEJ2s8j4GULHHw+5IBXROfHd/Zu7Cg86/Ys7eXFfoLkj0vOisnbdYK1dKQohcZUJQjVtjDPksV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705055; c=relaxed/simple;
	bh=2o5q081kpM9gqW6xM+rZ8YlKEO3D1caJMlb8NRd33tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+oJvauFTbROxYbviheuE3QuzzWXK3oQH5Gw7p5PqbvYi26yWsZ73EAyI4sJSNDg2YCatRZIsry6DwC5szYwn6I+B+Yli8h3Bl/LFqdPRgtKtGkIXjrJZdWBD/Su9ujUvHsDJVGOiSRkCY4y9mk/wGp1QsihIA4uBPd/skCIizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy1+1mTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xat90K+7laktWlKWrEYj2NKDd4TQak32OHmU5MtaKmE=;
	b=Qy1+1mTnSQYinUC9F85qYc1/PEjUphn6hb+QD4bflomoRRA7oJlFCVudTO4KVrOmWsF5+u
	J0+rgyjha/jVo9QBkRHtAU7uxEraq0hKtzVtDBLEHpCPSTA3Zj4/P/h3i5Z6U7cxpFhYNf
	gyjSs/6A6BTXBbcntD2h8Wlif+h39+U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-QXd0yMaDNFyWmn_51Lu7dg-1; Mon, 26 Aug 2024 16:44:11 -0400
X-MC-Unique: QXd0yMaDNFyWmn_51Lu7dg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6b41e02c293so94039777b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705051; x=1725309851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xat90K+7laktWlKWrEYj2NKDd4TQak32OHmU5MtaKmE=;
        b=kYKo+zy+3qhqq9+/PPkTdrUjeqCPvrTP3uMRdnOdcvGDCN7n6ol+z/KcM0UeOqwewo
         1dCqJsEAFgtvCc1+WswX7t23kf2xTRFrPrW7KWiPig112T8uSZkyB4f7eWCS77bHxjKJ
         ceIR7+vHlxed1FyLtuWE4baIhusRa9Tb1tox8lV0bITeRan7ohR5u6FZ89egcMgrJzjJ
         wG+a9WJxvplYB1yGMt3Zvn/1NFot7css1jglgYyQlJvpsIswyuf7UCeNCpn75PbZHn4z
         Af2wR70ymMjXt0PqnlHBTC6tg17BbK5NHXw/3f2S6CWBTt9piVFxNTqygRZeNToLNOUj
         htqg==
X-Gm-Message-State: AOJu0YwopCi9H+teXa/7NQcaq1ak005oXnJQ9Ult71Ju77Lha/Y/j4qx
	y4gxhjoTPbkv3Sl8iWK2ggt25B/EtAQbfysfcj6he0MlEmdWWFpq+1D5iBsxVJBZzc1Eu0W4Zlw
	qOwfBzlRXNQICDbc1978f25tadM3yaSZTZxww9I2jnb3DBR9aZ/bIbYg7zntv8Jc+GxVvBExSgw
	egTEeabG/chOHyFs7sf2xhGmtN+IIhelecu7nCu7nnOy0=
X-Received: by 2002:a05:690c:380b:b0:6c1:2b6d:1964 with SMTP id 00721157ae682-6c62906557cmr136660897b3.38.1724705050785;
        Mon, 26 Aug 2024 13:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVQdSmnkARvKpk+I4g97hETTq/PaNGcO/OaJoau0YQSMQm37evWRXkCU2N5l4bob/h1UXyLw==
X-Received: by 2002:a05:690c:380b:b0:6c1:2b6d:1964 with SMTP id 00721157ae682-6c62906557cmr136660497b3.38.1724705050419;
        Mon, 26 Aug 2024 13:44:10 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:09 -0700 (PDT)
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
Subject: [PATCH v2 07/19] mm/fork: Accept huge pfnmap entries
Date: Mon, 26 Aug 2024 16:43:41 -0400
Message-ID: <20240826204353.2228736-8-peterx@redhat.com>
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

Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
much easier, the write bit needs to be persisted though for writable and
shared pud mappings like PFNMAP ones, otherwise a follow up write in either
parent or child process will trigger a write fault.

Do the same for pmd level.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e2c314f631f3..15418ffdd377 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1559,6 +1559,24 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pgtable_t pgtable = NULL;
 	int ret = -ENOMEM;
 
+	pmd = pmdp_get_lockless(src_pmd);
+	if (unlikely(pmd_special(pmd))) {
+		dst_ptl = pmd_lock(dst_mm, dst_pmd);
+		src_ptl = pmd_lockptr(src_mm, src_pmd);
+		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+		/*
+		 * No need to recheck the pmd, it can't change with write
+		 * mmap lock held here.
+		 *
+		 * Meanwhile, making sure it's not a CoW VMA with writable
+		 * mapping, otherwise it means either the anon page wrongly
+		 * applied special bit, or we made the PRIVATE mapping be
+		 * able to wrongly write to the backend MMIO.
+		 */
+		VM_WARN_ON_ONCE(is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd));
+		goto set_pmd;
+	}
+
 	/* Skip if can be re-fill on fault */
 	if (!vma_is_anonymous(dst_vma))
 		return 0;
@@ -1640,7 +1658,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_clear_uffd_wp(pmd);
-	pmd = pmd_mkold(pmd_wrprotect(pmd));
+	pmd = pmd_wrprotect(pmd);
+set_pmd:
+	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1686,8 +1706,11 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * TODO: once we support anonymous pages, use
 	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
 	 */
-	pudp_set_wrprotect(src_mm, addr, src_pud);
-	pud = pud_mkold(pud_wrprotect(pud));
+	if (is_cow_mapping(vma->vm_flags) && pud_write(pud)) {
+		pudp_set_wrprotect(src_mm, addr, src_pud);
+		pud = pud_wrprotect(pud);
+	}
+	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
-- 
2.45.0


