Return-Path: <linux-kernel+bounces-324014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F69746CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC09B25BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C01BFE17;
	Tue, 10 Sep 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAB17Vqe"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1011BF7E6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011915; cv=none; b=nStzQCML4ECHVuH8DFT/FLaPTvhIBHx2g2MsH6ibFfZktZljwXlHS5MhpEpp7K+EiqjxJoI1CSWTFmumHuElKMvwQxWcA55kPAfXPprPKDTqTNX9ZVr3iPKYZYzlrS49zQIZxW//q6G3bRA1OHepkns2U7m5mGmFtE/pp3Bj71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011915; c=relaxed/simple;
	bh=CrNuBEQB9mPgq5xJPKkAqgO4LUIgHUUw5bIzyAMc5hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FY832xtsFzJZx2p+AUUoY0Ml9qTUTJ9Xo5oHURUlqsb0bdCwqeV821VRPzCNjcW8SCk9n0EGGVkOqns0jlzVcbAJuXOi/PHwcTVuqJRL2BtPtyNHjjSXFIknkbSM/DZpr4L03Hpvxl3t2npWq0UPmMwayx5Kx/Xrc5gM9L7CyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAB17Vqe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-206f405f453so58298025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011913; x=1726616713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJnVJ3hPk966+JzwkBdvbRfaDiCGChJRXNWj1r0A/AI=;
        b=eAB17VqetZI0XT4jygNlCX8pMR14vcPxyhRuQcLYyt6eg0S9H0qD008NNo5spsy5AA
         ime7bd8mNxGh97CCCCtlahSIzm61ItbagYawo/Cu5QOjBpmZb2ufEirv98Zq4100N8J9
         sldeF70I4TXu4SQpkHtlor6uIjPmye5qdDNqQ+J46+149nFjwI+6Ae+uKN+Jt56YL0BX
         lEx9Xy1ah+Uo0rep5GyNHp1CKx09QJ/VSHAVPylQsuV3GqnsBu4R62DlrUXFLzIFmLZF
         AoZ5v945Pw5wW1M2CU3llcg5XnmZo/EKYRkgNgsqNjQXGdcxO24fBC9l0XvOe2Jx3HAA
         BZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011913; x=1726616713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJnVJ3hPk966+JzwkBdvbRfaDiCGChJRXNWj1r0A/AI=;
        b=eDGu1RBv3sLjQHtLOSGPfmsWFX2YXnPPD08QHNY2mVWImRmNslku4ozuvd6HvfF2k0
         rPOg7cIK5vtabrXlHhIVpV4U65mIRD4oQzNsQt0H4vUGFyNNuRsQX0AvzN8DoyHXwnxH
         mlfPLvrslOQQq20nrpLo4hiTatDOVGqnkPmfNSdiM/WUa/CL6e94XBzGTBxn8Ywcjdhy
         x/BN6xeMPzTsGfQ0tYXv//krZZWI4c+3cmtHGcdvDFotM1mlKxlGtHgGfNBNC3pK2jI9
         Pe3UgBnw1R+1lCfSg4OtblC/zLjwHZEeF/pDcPY3S35tUGyYZcpJMJp56Y61soKEciHC
         p1QA==
X-Forwarded-Encrypted: i=1; AJvYcCVTh6MeXTSUoG/gt/LOX3K+kXuEJV2fTe2M6rXTshds0zwph4qs9bAtqcD0Ifucnbco9jyRkjdv5x9zmPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwdELpDXsTu6ViBOK5ybNukcMidWy7BG+pJZCSbGxzCP3AuOr
	3Dvfp6eYK6x4uRYXqSD5iALP5y0uOF35NTg2dGALVFBB6UK9YWEnGCS2WQEicY5GDlhNs3RScEh
	b9OhiWPk+D2M4zVcJY/8euA==
X-Google-Smtp-Source: AGHT+IFupyBy4ChWh4+QQZzDjp/0RDwyZGNbYZlLigdfa+9eTsAjgorPIS9wF7AAjJqg5MMFYi7bl04vejqoUPfawA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:244d:b0:206:cace:ae9c with
 SMTP id d9443c01a7336-2074c6a44aamr66745ad.6.1726011911534; Tue, 10 Sep 2024
 16:45:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:54 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <226a836ca381824cfe17ed42be5cbf9972b09ab1.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 23/39] mm: hugetlb: Expose HugeTLB functions for
 promoting/demoting pages
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

These functions will be used by guest_memfd to split/reconstruct
HugeTLB pages.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/hugetlb.h | 15 +++++++++++++++
 mm/hugetlb.c            |  8 ++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7ba4ed9e0001..ac9d4ada52bd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -298,6 +298,21 @@ static inline void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+bool prep_compound_gigantic_folio(struct folio *folio, unsigned int order);
+void destroy_compound_gigantic_folio(struct folio *folio, unsigned int order);
+#else
+bool prep_compound_gigantic_folio(struct folio *folio, unsigned int order)
+{
+	return false;
+}
+
+static inline void destroy_compound_gigantic_folio(struct folio *folio,
+						   unsigned int order)
+{
+}
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 372d8294fb2f..8f2b7b411b60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1533,8 +1533,7 @@ static void destroy_compound_hugetlb_folio_for_demote(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
-static void destroy_compound_gigantic_folio(struct folio *folio,
-					unsigned int order)
+void destroy_compound_gigantic_folio(struct folio *folio, unsigned int order)
 {
 	__destroy_compound_gigantic_folio(folio, order, false);
 }
@@ -1609,8 +1608,6 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 }
 static inline void free_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
-static inline void destroy_compound_gigantic_folio(struct folio *folio,
-						unsigned int order) { }
 #endif
 
 /*
@@ -2120,8 +2117,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	return false;
 }
 
-static bool prep_compound_gigantic_folio(struct folio *folio,
-							unsigned int order)
+bool prep_compound_gigantic_folio(struct folio *folio, unsigned int order)
 {
 	return __prep_compound_gigantic_folio(folio, order, false);
 }
-- 
2.46.0.598.g6f2099f65c-goog


