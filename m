Return-Path: <linux-kernel+bounces-333064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18797C305
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165CD1F227CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795F14A96;
	Thu, 19 Sep 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHQlPkio"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFB2AF0E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714631; cv=none; b=LJfOALcjPaXLRTAJmpaMSC5WMJY5GRkHDrs+OtSQXmKGlhHipgUL1ix6HuckkaarI2qGrRdLC0HqHagTD55ruIPdbT7RpcnKlCHFziRI3YHRkhRAAYQDxvljw800rAp2+qtVKNACsp/ayqbxV5AVgqSCH563pZPFb89nVDdZqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714631; c=relaxed/simple;
	bh=iNTLscZVjBDcYCPDjAxQPKLBjQZrCDHjaFhmiiWrPrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDsF6KYlUvGKWfFQyH8bcjGO/G20JTCQOBGQU7+NjW7JH5RDPXyTyPOL5UrS70PeOEFAdghCUSX5DgQMIPX7bYZBfhm3EgwZfopPsKYrKVhpWbnyDkG+SDgwFXt7iVDAdxUAH9foGrwfiVpbR1moHYHASevQ//NhkIkme3/yuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHQlPkio; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fee6435a34so4605645ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714629; x=1727319429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwPGGqxMjTTALmPRltkI2obnVC0TIxSM0BTVcrrVEU=;
        b=JHQlPkioXnXQ3JMACqlWzgvoxzUdJSCPeMRb+KRRAqNFoa5nnRXo8he+cWdmK18VkR
         6cc6KnU1ctug1kOpr64UFl2vjNGbu0ang5Rlrx97zTl4bw2uwbzyiYbfXtkU7ifFpjnk
         YAG1Y1PF/8Xt2qGvy3v854UYbjUDTrJsgwZFDhJZpShds9EBuAipRPehxjSrmJbsqrlV
         5r3MTZ6dUSBVDNthQOPGa9tij45rglsgyfKw7IT9/C5ieWxx9I9eMtGNrpuQVLQ1vqXs
         lLAFqg0YBez9fIOJysDYvwGVkvIxXJsA/vsbyse9WPNj9fFqSD0OP7jd33kltcnCX0n3
         8e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714629; x=1727319429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpwPGGqxMjTTALmPRltkI2obnVC0TIxSM0BTVcrrVEU=;
        b=Pf5HPJG4k/IAzfEuODEWMdor2+T+YzvaCChsImhKHyYiPHNgCK3sujHZVCjzmON+9d
         +qHbNEgDPyl9bArmzBAZvm0txsFWHWWSLNjdqxG7VUOuDKzqT+42k+428fXw/dOcY7Ow
         wOvM0//uJQm0XXvDrUahygpl+HNx8H9DMChkbMOwHtnqHMjpz+TvJrVngZxMjKDuzIO2
         CBagx+ZNWUON15U09BCxWzXc+gb5+4j33/GwyVP25Az7z4BnEkMOcyAVkxFinZURk/Qa
         k/kMQS9rrd26Fdbv13VW38vYBc37+gYRQ4UQQHymp9Ci/FUO66AeyZ/CBVFPb9mxbE3v
         hEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjEB71D4OqD+x5WxIMFIB1LpWtphDrRrfQ4o+WlbUYOlVUXMovTmZ08uEf5xhEHxfBD/4ZzSTVil7JGgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlx15YxvTGzBwqxgr/lvlAwnPUvJst9uT5fEYXxfISUYNIJNCo
	NuVQ1MiYzYdDqhkQbCQmMrtZhTx2lbkzNOLLBHYEMYdCqAFLo/vcMG/d8w==
X-Google-Smtp-Source: AGHT+IEYcIlRMeaSd/gWkrGWTytjNF8qHos36tFlvKj7R9gv/PIoeETu5a0NdQvLU3Umw0/gtUoAEg==
X-Received: by 2002:a17:903:2b0d:b0:205:9220:aa37 with SMTP id d9443c01a7336-2076e35f0a0mr358517625ad.22.1726714629566;
        Wed, 18 Sep 2024 19:57:09 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:57:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 09/13] book3s64/hash: Disable debug_pagealloc if it requires more memory
Date: Thu, 19 Sep 2024 08:26:07 +0530
Message-ID: <8fa0c82332bfaa4c4766372ca0573021dbd8a85e.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make size of the linear map to be allocated in RMA region to be of
ppc64_rma_size / 4. If debug_pagealloc requires more memory than that
then do not allocate any memory and disable debug_pagealloc.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index cc2eaa97982c..cffbb6499ac4 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -331,9 +331,19 @@ static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 static inline void hash_debug_pagealloc_alloc_slots(void)
 {
+	unsigned long max_hash_count = ppc64_rma_size / 4;
+
 	if (!debug_pagealloc_enabled())
 		return;
 	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	if (unlikely(linear_map_hash_count > max_hash_count)) {
+		pr_info("linear map size (%llu) greater than 4 times RMA region (%llu). Disabling debug_pagealloc\n",
+			((u64)linear_map_hash_count << PAGE_SHIFT),
+			ppc64_rma_size);
+		linear_map_hash_count = 0;
+		return;
+	}
+
 	linear_map_hash_slots = memblock_alloc_try_nid(
 			linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
 			ppc64_rma_size,	NUMA_NO_NODE);
@@ -344,7 +354,7 @@ static inline void hash_debug_pagealloc_alloc_slots(void)
 
 static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
 {
-	if (!debug_pagealloc_enabled())
+	if (!debug_pagealloc_enabled() || !linear_map_hash_count)
 		return;
 	if ((paddr >> PAGE_SHIFT) < linear_map_hash_count)
 		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
@@ -356,6 +366,9 @@ static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
 	unsigned long flags, vaddr, lmi;
 	int i;
 
+	if (!debug_pagealloc_enabled() || !linear_map_hash_count)
+		return 0;
+
 	local_irq_save(flags);
 	for (i = 0; i < numpages; i++, page++) {
 		vaddr = (unsigned long)page_address(page);
-- 
2.46.0


