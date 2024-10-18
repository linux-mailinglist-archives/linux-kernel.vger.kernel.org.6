Return-Path: <linux-kernel+bounces-372031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CF9A438C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2491D1F24A22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437EB1D0DF7;
	Fri, 18 Oct 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9EOfwJT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD492036F2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268301; cv=none; b=cKiX8H5Z3pFmwrpwL2y2O6tNVuPrCRu9CqMZxv90ayQC7S3wIN2/HyFR47pux8UE9181CqmOB8ehhh71kmqYEoJJ12C6LZRbWJIkgO9SZqYHDrFF6Az4R0/AS11FabQaSWSk68lCPHWWbeE+NJBOuwR2fycgwQ/etygE31nq3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268301; c=relaxed/simple;
	bh=6KOCsTgpGduGzHU6PK9px6UvJTBJLdRMhtEU7IVZgBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6EkKnRqAER1qTXNgZFkVbvwLCsdq9zJnIWeEn4yGgfC0K7qWE4fCCF4mY8WapIKtxE8AyO/yLdaSBat8Xfc5NxtqXXZBW1gCF2Txt9icbGV+yqWEAbRYwe5Q/svubD8KFoaTdANunZQWdtgCBG58elxKIqYTCWpC+n07E6GsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9EOfwJT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1610018b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729268299; x=1729873099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OVm1aMfcJH+C5h2HeT9933XrsU2qvy2OkpNXm8z7tg=;
        b=E9EOfwJTdQGxAEvTrxst+C01/LgzzzR96X/QwDhlwggV5LB/eXjkruU3CoSsCtzB22
         PmvTqawIsJnFw0h1UgZXsPt1L9ifSV8QuL0BjMovcDwa68FRmxkBMMwK2wLqXmxMcO4Z
         ScJUNPh1pDHJ1cunUpqXkwYI7GePvw1OyxzzEjmMJKEjMdDpc7knRA8PdI1PEQ8UgGsu
         a682bjgULazsGpG6K+/KSYLafbyG45bjxxwRtnf7gecLuYy53YFx/0xF/ybJ3C0e99Fe
         pVT6RZKx1E+zadY/6yC9UCXx3wB3sZD6WhhQdAtu91JubuDPCbFRsOfG0dTSkloXlsFt
         Exsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268299; x=1729873099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OVm1aMfcJH+C5h2HeT9933XrsU2qvy2OkpNXm8z7tg=;
        b=C3lbUBEuegh8LUfqEoyVVwZkOYIHqZUu+krDwDDje+nLr2dfB+Bj0/eiUedffHLpXw
         M+Z9hZ1S8vA1BFNVMye4GuLC163xMmDV5sBFQXSaEXK7BH5l8gtDMfF0T5S2G4h7tz7K
         oW2cDIk82le/3GgDqdcLpmEe6Xv0JH4os6IeCWfKNi5+GASa32B7REDcpcMZrFadLZH0
         L/jzaKou2/SZWjRwLu3XXr0HiRm9RDB/W2f3qLqKS48rgxwkaG2e10FkrICePmWaBu9Q
         d2K8YSXrvS5do0r816I6vl1WlO1aWEkJugStuLwpcnJrSGPzud64/OXbGHwJLSlwAwJ7
         KHDA==
X-Forwarded-Encrypted: i=1; AJvYcCWDzAcBok5TLDt8scEMwfQE0uEEC4hDwxxNTRbbtnKrhQzj8X4SEHTi0dZcjxbBbFzMKAeo+hE5VzdqmGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuXomjvxOBZ1avEkvWcDhAZ15NSdwKazbMEXXsjw7zFvghvk7
	uLeg40ii3YJGiI6BqEHullTFygZzlZkWasea8MfBEZQuTj9P8nJi
X-Google-Smtp-Source: AGHT+IFYn+jHU87+CuAdiC2bANQdqGrWOhnXYjaGpsSCpU5oDVmDDYqIstLDV3L6h3hQlUt3per1nw==
X-Received: by 2002:a05:6a00:c84:b0:71e:58be:3604 with SMTP id d2e1a72fcca58-71ea31923b9mr4310756b3a.4.1729268298529;
        Fri, 18 Oct 2024 09:18:18 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345677asm1692140b3a.147.2024.10.18.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:18:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 2/3] powerpc/fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
Date: Fri, 18 Oct 2024 21:47:56 +0530
Message-ID: <805d6b900968fb9402ad8f4e4775597db42085c4.1729146153.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <a2afc3d6481a87a305e89cfc4a3f3d2a0b8ceab3.1729146153.git.ritesh.list@gmail.com>
References: <a2afc3d6481a87a305e89cfc4a3f3d2a0b8ceab3.1729146153.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refactors all CMA related initialization and alignment code
to within fadump_cma_init() which gets called in the end. This also means
that we keep [reserve_dump_area_start, boot_memory_size] page aligned
during fadump_reserve_mem(). Then later in fadump_cma_init() we extract the
aligned chunk and provide it to CMA. This inherently also fixes an issue in
the current code where the reserve_dump_area_start is not aligned
when the physical memory can have holes and the suitable chunk starts at
an unaligned boundary.

After this we should be able to call fadump_cma_init() independently
later in setup_arch() where pageblock_order is non-zero.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 162327d66982..ffaec625b7a8 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -80,7 +80,7 @@ static struct cma *fadump_cma;
  */
 static void __init fadump_cma_init(void)
 {
-	unsigned long long base, size;
+	unsigned long long base, size, end;
 	int rc;

 	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
@@ -92,8 +92,24 @@ static void __init fadump_cma_init(void)
 	if (fw_dump.nocma || !fw_dump.boot_memory_size)
 		return;

+	/*
+	 * [base, end) should be reserved during early init in
+	 * fadump_reserve_mem(). No need to check this here as
+	 * cma_init_reserved_mem() already checks for overlap.
+	 * Here we give the aligned chunk of this reserved memory to CMA.
+	 */
 	base = fw_dump.reserve_dump_area_start;
 	size = fw_dump.boot_memory_size;
+	end = base + size;
+
+	base = ALIGN(base, CMA_MIN_ALIGNMENT_BYTES);
+	end = ALIGN_DOWN(end, CMA_MIN_ALIGNMENT_BYTES);
+	size = end - base;
+
+	if (end <= base) {
+		pr_warn("%s: Too less memory to give to CMA\n", __func__);
+		return;
+	}

 	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
 	if (rc) {
@@ -116,11 +132,12 @@ static void __init fadump_cma_init(void)
 	/*
 	 * So we now have successfully initialized cma area for fadump.
 	 */
-	pr_info("Initialized 0x%lx bytes cma area at %ldMB from 0x%lx "
+	pr_info("Initialized [0x%llx, %luMB] cma area from [0x%lx, %luMB] "
 		"bytes of memory reserved for firmware-assisted dump\n",
-		cma_get_size(fadump_cma),
-		(unsigned long)cma_get_base(fadump_cma) >> 20,
-		fw_dump.reserve_dump_area_size);
+		cma_get_base(fadump_cma), cma_get_size(fadump_cma) >> 20,
+		fw_dump.reserve_dump_area_start,
+		fw_dump.boot_memory_size >> 20);
+	return;
 }
 #else
 static void __init fadump_cma_init(void) { }
@@ -553,13 +570,6 @@ int __init fadump_reserve_mem(void)
 	if (!fw_dump.dump_active) {
 		fw_dump.boot_memory_size =
 			PAGE_ALIGN(fadump_calculate_reserve_size());
-#ifdef CONFIG_CMA
-		if (!fw_dump.nocma) {
-			fw_dump.boot_memory_size =
-				ALIGN(fw_dump.boot_memory_size,
-				      CMA_MIN_ALIGNMENT_BYTES);
-		}
-#endif

 		bootmem_min = fw_dump.ops->fadump_get_bootmem_min();
 		if (fw_dump.boot_memory_size < bootmem_min) {
--
2.46.0


