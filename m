Return-Path: <linux-kernel+bounces-364972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4999DBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E3B1F23980
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D01D14FF;
	Tue, 15 Oct 2024 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzd7Oni3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B641A76D0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956092; cv=none; b=AKS4kyolwYzbYgvExhfMbF3GrMa4UmsF09ifu+5jFgQwD8xg1pb7vpX1VsaQe5AloHpALt62QGoRm1KxUhXKsp7R7LJLjK0aswtsv8d/fICL8TWp4dcSVPtVwTsnba16BI14QFNuhJDGDHa5DHXICILIDtmmGo5plBZtrW2kqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956092; c=relaxed/simple;
	bh=7LTcZT2HWVkqoSPK4x+UBfyzXYZc0lzBW4tVD7tCB10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcK8RvwyCOJEsmt7/hX0szCIKfaNn020Z765raooesQ0ZdQmwrkozEucOAO3e2wlATmbUCR4I4H02GpYmnzGctp3jJi1jVZ1ctWEMoRQ1Rti3VqJ0Amp+ULh/wafah2/dMz7YY/GnsDPP64gNgWn+Eb+14HJA/QvbvcM42T0ZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzd7Oni3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so717913b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956090; x=1729560890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG0rlJ7RpNnGy840avhtCY+OIP6FbV4qxEoUkbOoVC0=;
        b=kzd7Oni3JqDs0G0pjwqbI+r8IysOZyhMVkyyRIE28F/6BK6AKT8JZS+leVYZG7PyC6
         RErhU54XohIEY2IzlR2rGGsXDwuYS9L5m6I7e1052QzqKqi0r4r0ukNrTBhDvAPM9ut8
         Q/apGn3qKOPUZnm+DPuzwHDIvJpuwxryqCi1Sypz0G7JwPuXXMCMmMrRenj2N/yIahKd
         Ln+gTuSCm+/StEWF75j1UiQcGXi20KiTnTBpM8hYEDbc+L3T3RIWpwSgSu461ycERaeK
         BXGgad+mUyCVOvjixe70NdXTmOvTv794DLoiPVUi+wycxlcK++hEafQ78dsTy6R1af/A
         l0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956090; x=1729560890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG0rlJ7RpNnGy840avhtCY+OIP6FbV4qxEoUkbOoVC0=;
        b=R1ADbPchIwqjCcsa372IMcov8tms1fL62GRj+2lWf/ZM93YahQCeOCkxDzTPnwy+pX
         BzcCkpBCKmSus14yXhV8nWEKHNbQJMO4X8wT0TIDB0EN0xw7d1jBuR4SX0wclcrwX5Y0
         mL7UMi5ZyVXGgbqXZXrBx+vjRsPx9/x2iCY0gejJY7zlQ755SNzF+YJZ0ozCDlQy0S5T
         prbAQuDcwyFUuVmokKiKCCMYXJhf6LOfATf1Hp2Xf8/S8MbnH1LgXg9xGjiKVRlb2Qmx
         nQ3KGx4bsITcLcLSpz/awIxnT/bvb5XkLKgQMw2U4D4vBpmpwlHpGjDlCv0wKdhgXiMI
         Xubw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFIgTqjYgg36kltw799cym747vGiwPN+sBxWsoOixZtZATA7UlNhRQJ9NncFVfyveD3BzI+K02+0KZ4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKesgXAdbnfGt2vOPHGmmGpeETxc+aVMLkQm/dlMsYxB+9tL6
	qMTFrqFBP8oneUwotGS8+j8XU8NWdLptx8GbyKOTyJu0aoSaiZlf
X-Google-Smtp-Source: AGHT+IFvESYA3zS1GBFZJxbiWhM237fiGLHeDy47xUMjk/AhsGWJAlSSfmCDieCeQukhtrPpShvuWQ==
X-Received: by 2002:a05:6a00:1404:b0:71e:5033:c5 with SMTP id d2e1a72fcca58-71e50330377mr13492824b3a.14.1728956090001;
        Mon, 14 Oct 2024 18:34:50 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:49 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC RESEND v2 13/13] book3s64/hash: Early detect debug_pagealloc size requirement
Date: Tue, 15 Oct 2024 07:03:36 +0530
Message-ID: <6b5deb16494e80703577e20fbb150789c83076a9.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hash_supports_debug_pagealloc() helper to detect whether
debug_pagealloc can be supported on hash or not. This checks for both,
whether debug_pagealloc config is enabled and the linear map should
fit within rma_size/4 region size.

This can then be used early during htab_init_page_sizes() to decide
linear map pagesize if hash supports either debug_pagealloc or
kfence.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b6da25719e37..3ffc98b3deb1 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -329,25 +329,26 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long idx,
 }
 #endif
 
+static inline bool hash_supports_debug_pagealloc(void)
+{
+	unsigned long max_hash_count = ppc64_rma_size / 4;
+	unsigned long linear_map_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
+
+	if (!debug_pagealloc_enabled() || linear_map_count > max_hash_count)
+		return false;
+	return true;
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 static void hash_debug_pagealloc_alloc_slots(void)
 {
-	unsigned long max_hash_count = ppc64_rma_size / 4;
-
-	if (!debug_pagealloc_enabled())
-		return;
-	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	if (unlikely(linear_map_hash_count > max_hash_count)) {
-		pr_info("linear map size (%llu) greater than 4 times RMA region (%llu). Disabling debug_pagealloc\n",
-			((u64)linear_map_hash_count << PAGE_SHIFT),
-			ppc64_rma_size);
-		linear_map_hash_count = 0;
+	if (!hash_supports_debug_pagealloc())
 		return;
-	}
 
+	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	linear_map_hash_slots = memblock_alloc_try_nid(
 			linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
 			ppc64_rma_size,	NUMA_NO_NODE);
@@ -1076,7 +1077,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();
 
-	if (!debug_pagealloc_enabled() && !kfence_early_init_enabled()) {
+	if (!hash_supports_debug_pagealloc() && !kfence_early_init_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
-- 
2.46.0


