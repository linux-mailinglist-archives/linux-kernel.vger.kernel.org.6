Return-Path: <linux-kernel+bounces-372125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BE9A44C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1989A1F244DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9334205AAE;
	Fri, 18 Oct 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfN757dz"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE73205AA5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272664; cv=none; b=OPaw0hyfmIX+H95HeF2fwXkxsoS2fI1JxNfHEeOPdoT9ajUgSJlq50VFsCLAnX8OaVqVudJqEPD43c/mMM2bBLr2K2xqTeMwEAZXBnmiVDsJX8BjPLj25y/fJZb5/pfkRBsNAUhjCx2rsYh56V9+yaniQtyCg6ED8D7dlIUpKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272664; c=relaxed/simple;
	bh=YLI0r8N5pRa8ImeMxY5MDp0IiftU++zZzlcW81OslQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSBLBYrEfqgLXClt9SKT7Crrtlj2EJ6W8RT4sipSqbIn9JbxF7PgHRJHuTsA2IeOzQzg5bPWgu+agWanTqvJBctrhvJvqHFH38/qcQARM65prfj3Vl/zF38Ehb0vGwH9ysiZryYPzoc2B48BYPJxbk2szPFduJ2f7VEiou2VFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfN757dz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so1998283b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272661; x=1729877461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7nu+U6UkRZF2cuN8FLbB8nvBf84Wg4YjQThyWhRKHk=;
        b=NfN757dzhgwnB7z6Z3tUtmdL3z+R6uma6ge30WORzQzDqvA0AoGuiiOhZW2tTEaAUq
         zBHSCw1BGjwb7AhtvgtgkSearPo45z7fuOLZ/ahl7BWI2mABN9lebYJSlmGknhBK5nvE
         I2vKN5p9/RA51+TwOPsOOugn/YsX4hyy8YXmzuYY3712YhFcZxUIVk2RQzLRj+L/tJ7S
         bqn/lTKJ3egmpqA0oaTE77cI87lyKxzZLr+/MTk8mvTrYVT+AtTkOC5VVXcIgyEucdfX
         eaCcM8fQUQwunS+OIS8p/rHW6t7wfNEV6DrOzOy2wmlotN0SKYdW4JzdKUcN9ywBGSid
         Tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272661; x=1729877461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7nu+U6UkRZF2cuN8FLbB8nvBf84Wg4YjQThyWhRKHk=;
        b=ZZYgsSJ5+Vth1xXZs/Uk+Gj2ckWlSPtxK1ljpJTkUzOiT2YPLrf+Pq6nkzFKIA79vZ
         NR8lwiP/H5kMGr+Hj+gbdz5ANUZlWGGIE7xWy+qAAYwUfBy+9lKWWJIwmQ7Ge9i5w5eq
         TD04k8YIjx4vJKsOKzL3ySce9NeFMFxPyQ6gTn0qABI8yBC6FdDTSk+NeiDYqkDASelH
         jIUt8ELdr13O/0cETMpPtBuQTs55XtxB5dD8eZVTcPcZGNCXoak/Ie9GO1M2Oq0Js/mv
         uQmjyhonr29LETkUgzeHgQwC7VXKpd5TWWElHuGAeP7lPE7lemzsUiIFjDvVtYC2Oyxw
         G4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVayrzL1RDw5rixY/W2BJYQrva1pvovMWhMYYZB97BeCZUtWkZqCc0K7hZk4kZfxbc/ll7R24VjAbSjhME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ07jBDdctKWcnREt1pyIMIf2YfrRWEg8jROKi8UKpBRjyMnVr
	FPtV2UpjdvJRFnFElbJiCL5uvOM4M6L/nHixs1j1CAx/Uz1XpEwn
X-Google-Smtp-Source: AGHT+IHJYrrrqJRfAumO9Q20FqjOKsTO5quh/OtUWisgh37hgw56Q3PPkpt1yyNYXV1te9hYA/UiKQ==
X-Received: by 2002:a05:6a21:1519:b0:1d8:a3ab:7228 with SMTP id adf61e73a8af0-1d92c3323d2mr4881461637.0.1729272661553;
        Fri, 18 Oct 2024 10:31:01 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:31:00 -0700 (PDT)
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
Subject: [PATCH v3 08/12] book3s64/hash: Disable debug_pagealloc if it requires more memory
Date: Fri, 18 Oct 2024 22:59:49 +0530
Message-ID: <e1ef66f32a1fe63bcbb89d5c11d86c65beef5ded.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
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
index 11975a2f7403..f51f2cd9bf22 100644
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


