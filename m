Return-Path: <linux-kernel+bounces-191096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A68D068C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3341C21EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1561FF8;
	Mon, 27 May 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/IC84K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5E17E90A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824945; cv=none; b=ryF1xExywNjoO8p11zka3la0TbGKD5syERVM59thfVDHlUNM9wLwaly++hudwGUpgxBxcjRuCZbj4SGJy/FCCWqPP69eieD6ZhhBJgUp0n0J9I5uqwo9isHA1HBSagLimXoKugouwVqazPCkpQVrOSn5aVNjA/bWQtPeos6RLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824945; c=relaxed/simple;
	bh=GxlOGHj1d+fvGjMkPrmkeACoJaShF+IpvrmmxK3sODQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jfz8MDQJYLS8lqnlbjqQo1U+njnbLGzIQoEKXhaemvDJyecDKPkLQvYC/alfXuBwuAmNTjRXCQEk55WSgM5gWyfvRdEtnh5rvEQNDEjHErmv5TMGN9lm8ux+g94Nij7JtfTXDZdLY3fAEpD3yhIHjkwvh0omhQobclmUy7wTyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi/IC84K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yAicwoPMKSSb7qAx+AbzoJUYT/07gUTt/oLzI/9bm7M=;
	b=Fi/IC84KZF3D5j6rX/QsRBfN9/hi8wVVy/s3URxlbJwzDnObdswu/t5ob0rzBHKftoGGhO
	8baDbz8/dItf0HhZvZi5b8BugMIWpGDk+c2JdS0H49EBpPtZwLqXCc+COQLYNWv9cN6AJv
	Z08Ds7n4M7ln4FW3lpCUqoH/eekuyS0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_h4K0s2VNhmbPToFPdTdZA-1; Mon, 27 May 2024 11:48:59 -0400
X-MC-Unique: _h4K0s2VNhmbPToFPdTdZA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ad864825d0so69016d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824939; x=1717429739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAicwoPMKSSb7qAx+AbzoJUYT/07gUTt/oLzI/9bm7M=;
        b=TVgbP6ln30jNXWAmO5KCxTeRTQJ8sC0nZHWsTc2N9yawtWP7uI26aT+bfrzmEAHINx
         XXxxOxokrMrwHk7IM1xad8O6GNEeGMx3rghvCBIcjzX+PmfYqbzejbc/Q8Cm4d016oGJ
         cOg9ykPBaYQdfSzRdTr+rp5gcXnuF7pglLkoe3wJSwgeiN8nJOJJrqlAvCIXtjDkI9vZ
         znqfj7+B8ACfofWiYezU98tdgGgA11Zy1jEH8zpK5bn8RHYoDiesbpXi5mlx25KMGc2Q
         OPUkcGEE5Rm0dfTvlzT/bSpyh+7vKJLihe+GVjP2ieMEMb1LRcLLf+TLQHDNkPqxV1H/
         z0sw==
X-Gm-Message-State: AOJu0YxjBoU/BQ/3LY150akO5kVKuS1GfQtWrKtGSo7DI+SS0dD31dqO
	PAMyDsMENN5Y9bPn4YQsykJ7jGOxrnT5AZZKITXQgRZkbpmBigs5KtM8O4JX+ysZAqmGX5oxdN6
	W/d9HBGx5ZqCnCqyTKDFiFGHkUTsweGBnEDulY+Vys4XFWVSJ3lXJNOUPDTEH4BeLRy85Qx6/zK
	vfSJ2LGqz63SSP2Jdx8COfxNRG6MsQ3ojV09O7WyO8YwQ=
X-Received: by 2002:a05:620a:46a0:b0:793:17f:18ae with SMTP id af79cd13be357-794ab110986mr1258496385a.3.1716824938339;
        Mon, 27 May 2024 08:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmqHDczcrltkmD4V6I6X9MZqEa2VhwAwSvr2qZNwDgwFTlINj7zzFZvIGFpxd0Ohz0I8RPyw==
X-Received: by 2002:a05:620a:46a0:b0:793:17f:18ae with SMTP id af79cd13be357-794ab110986mr1258491285a.3.1716824937466;
        Mon, 27 May 2024 08:48:57 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca63desm305917785a.5.2024.05.27.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:48:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] mm: Drop leftover comment references to pxx_huge()
Date: Mon, 27 May 2024 11:48:55 -0400
Message-ID: <20240527154855.528816-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxx_huge() has been removed in recent commit 9636f055dae1 ("mm/treewide:
remove pXd_huge()"), however there are still three comments referencing the
API that got overlooked.  Remove them.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/mm/arch_pgtable_helpers.rst | 4 ----
 arch/x86/mm/pat/set_memory.c              | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index ad50ca6f495e..af245161d8e7 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -90,8 +90,6 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_leaf                  | Tests a leaf mapped PMD                          |
 +---------------------------+--------------------------------------------------+
-| pmd_huge                  | Tests a HugeTLB mapped PMD                       |
-+---------------------------+--------------------------------------------------+
 | pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
 +---------------------------+--------------------------------------------------+
 | pmd_present               | Tests whether pmd_page() points to valid memory  |
@@ -169,8 +167,6 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_leaf                  | Tests a leaf mapped PUD                          |
 +---------------------------+--------------------------------------------------+
-| pud_huge                  | Tests a HugeTLB mapped PUD                       |
-+---------------------------+--------------------------------------------------+
 | pud_trans_huge            | Tests a Transparent Huge Page (THP) at PUD       |
 +---------------------------+--------------------------------------------------+
 | pud_present               | Tests a valid mapped PUD                         |
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 19fdfbb171ed..8b2164509b4d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1120,8 +1120,8 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		lpinc = PMD_SIZE;
 		/*
 		 * Clear the PSE flags if the PRESENT flag is not set
-		 * otherwise pmd_present/pmd_huge will return true
-		 * even on a non present pmd.
+		 * otherwise pmd_present() will return true even on a non
+		 * present pmd.
 		 */
 		if (!(pgprot_val(ref_prot) & _PAGE_PRESENT))
 			pgprot_val(ref_prot) &= ~_PAGE_PSE;
-- 
2.45.0


