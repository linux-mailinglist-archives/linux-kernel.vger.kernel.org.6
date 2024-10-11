Return-Path: <linux-kernel+bounces-360658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874FE999DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3149D28711A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846220ADDA;
	Fri, 11 Oct 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne07Xr9w"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8E20A5F1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631424; cv=none; b=sVFKpaeEPnxYm0jqIbyDhalnsZF8XPuALgbMDSTBZPPdQpz3l9ob4lTWjaR7MuOqtzhaY34ezV3LevmGQDh7glCT++mAg3hH4VqOysPozUJRTnChX6iYZ0EGpZX/us8Nnj0BXrADkAwRbOsmFp8jY+3lwsWCvbzXRmv4njCpo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631424; c=relaxed/simple;
	bh=nHxXQVCx+AjI+TCgFGMZIsXkjXhyQedDQPiOWfLR9bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdfdiW6zyINwtixlvHAUVhu8i+rP4622nJ0KXZLgkxhIIF2woA+ouKn5UnQohOzOLBht7fjJP/mSguxIINqlsZmhNaELn04Je/sclOuMyue/SuZnGyUHL8TaiTiLOmmkYPIt+cqf0dA2CnKtsa1/BYHcEyboC7aDo0t6OIhiBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne07Xr9w; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b90ab6c19so17327405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631423; x=1729236223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ubewzzmHjedesx22pwLGzOS0cZPbgARDYakPnaDJMA=;
        b=ne07Xr9wJFMqIwmwHmDwO05fEmJPqEGOm1wcj7TSYfAVORWSQc0ffOQMUd6Lh4hA7q
         N9kYSsrbkDj6LIIif8sXHEw+cUkL2k1YZXIe3va1ioLp7YkUAcsVFNIsMp2ykklILS1/
         sq5buX+xcYCwxBrwsu9mTCRB3dA1sGCDERCMBJ7TCB3k5QinP6DD+jv0/hyXmqrfoYzg
         eMmK+T9d8eCAaJtPzrrCWk8pJhrJLMw27e/rFeZoNIBMJj7C62edehP55a/+dlNQR7La
         ffbVFBt5MRRoyzOa7eKlX1nuogwN+Crx2vvygkJmomJlS7evWgNvbD8PRMHJKA1T5Gp8
         jtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631423; x=1729236223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ubewzzmHjedesx22pwLGzOS0cZPbgARDYakPnaDJMA=;
        b=FA2i8k+TmG/2nHwo7tINsL/9oflP44GN2kZ26dO+SDum5F0wZt/J5UelVHq1h027RQ
         1JjRFE5UVzH0E0FGK5P+HFQY429oYVOrJitnuEnImoODlfuvyPo0vYtp9l/AWHoT0HNN
         a+1RuHUow/iQPTj7GbWv2tFq66EA4uUEjH0aaoFjXcPUjwfJK214ufw/lg0Smn3ByXOc
         SrULf04vuX9cDUMxU0LJOb5GUOAgp0/SfUkg9nMeltu/s8cW0N9k8cHiIlpW0b7a2rVg
         fh6BOBM//Kp+spYm9MCMxca4CSMG1vM2rAxnSngJWcYQbocjFWCIrlP7CPgpB3wZTozm
         qpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiR/WAOyW823sEeKmx7d97o3pFuU1pS6ktZP0OJ+ntlv/wMEQGNm1J7mPESRCYBVtnLwcmnyd9uVXa7/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SwWOIgkkJFS2p3lgdPjOTYp+Rp+m3OqId6qEi2zH42MOTS+U
	5+PIg8fwrF9S0QT7AVd8iyS6kPakuTpvcXFpZXkG/mzDqXeWM+b7
X-Google-Smtp-Source: AGHT+IGf9QK0QpSNxbm45T2FEivaCIusibESERuvwR9YsSh8uK+WhxBRvYeFa70z9Xc08Q9BwN2JgQ==
X-Received: by 2002:a17:902:fc8f:b0:20b:5231:cd61 with SMTP id d9443c01a7336-20ca14732d9mr21408005ad.24.1728631422585;
        Fri, 11 Oct 2024 00:23:42 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad335dsm18825155ad.50.2024.10.11.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:23:41 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 3/4] fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
Date: Fri, 11 Oct 2024 12:53:11 +0530
Message-ID: <4cea3a03fb0a9f52dbd6b62ec21209abf14fb7bf.1728585512.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728585512.git.ritesh.list@gmail.com>
References: <cover.1728585512.git.ritesh.list@gmail.com>
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


