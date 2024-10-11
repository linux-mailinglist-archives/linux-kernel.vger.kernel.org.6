Return-Path: <linux-kernel+bounces-361348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493A99A714
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0FD1F22A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3B194A68;
	Fri, 11 Oct 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioQumLBe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA9194A59
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658827; cv=none; b=LVx4cFWLMQ2dywxsAPLrdcdUQ539yGgXuyqpMJHTachW2BuxwqeFUAu2gAu0n27s9Oz3V+iKLf9Jonq9jdzijbOgWEUG2EKCZqHaFqj55u0JuUO2hQF/NflpwLSmohlO8PFFM4g1o60pCI4TpLsZE1WKZVUar9lnPOBy+Lbjo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658827; c=relaxed/simple;
	bh=6kElsZ39PO1yTtDfreZ2+ZK16QAo4KxBxZxyRhdadeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZGJ89l/wvCwTMRe8nSb6GRum3jIKe51llTq2IF/yM2pOvGzJUWsWKNet4rGmroiWDiNHCuTPYrx7hFyOzOdRlDLE1fOieM7sUkfzJoZIqs3fU6N99wSE4jscKRfFRztd5jfO2pWNurpIu9LDvAvARNmlTvCdcMbnsUYN6ppNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioQumLBe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e467c3996so274553b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658825; x=1729263625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU6Z8cvJobq05V76diaI6hL+YRyehnIANBYxgVSeFp8=;
        b=ioQumLBeiFduscK+twii4tF3cVx6l6OxezdVUGcpOp7/y074bCoFNPGxM/8Zqjc0FH
         NNzySwe642+1T5ApaxDM0bnvMPAVpi3AfubhFiOMqNaQVRGmEwm6kPKM/gsYeFX4Dg/7
         4ujLXqFHkqL284hNFreswZjRpOwDoTNebJ0ltiKZdF1t8NB/dClnBgk4OtZAoUZjhpLt
         E34+FI6x9nISy6b4I9v1Dx4AX7hA17Jdc85fbz8nuVVjMkmXqWmvfC/C7SZ38J4Oi869
         R3YhkLqFU3vgs1WzROMBLkNeXoMD4XwQ7aqaZLl31ekIRtJ39fKxSYxjt/Wumxb566Ad
         oNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658825; x=1729263625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU6Z8cvJobq05V76diaI6hL+YRyehnIANBYxgVSeFp8=;
        b=b2ARoNdbJA6iOrGTJj2gCmUfXkNCg5bCjmI7/NLu1F8L7Mq1GFMVPIvqB1DsTk3HSG
         /8p9btlq7IDDsCU3LumUv5j31ethMZZiThDnykldmio5IHSUbyqn4F0l7sx5rNTHN8QB
         aqdDSLcz97vVtQ2Xjk8qDFfp23gbXhPbiRe038Qsojv8n7SJbnWVKNMI2zO+UX3BJB+c
         4+AmimXVosXPoa7UVUc6AgnXcU1gYIjjFFtvuryhK7W5J4gZKds/gtAqbgmnnEicpZZb
         AkuMrtdao/hEvAqg1JiW11VuO15DmsblM816hD1If1XRUdmnqMSCJi6z9W9gJ67oab7L
         XjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBh2jBIoTgEvc5pDM+Qo79wooGNMO7mCmWLYzlMpSc0WdIZFLu0BLFO1H5ZqlT8cL2q+z4okLH+obrCro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV11kMZL1DSZ1cWQvMT3s5IzJxkeJi5hdThvtUYHM4p5qRc0R
	rioCcs8nCEIsle4yUhyuDPEJz8OzZt5XPbv1AsgzT2fcs4zncaXR
X-Google-Smtp-Source: AGHT+IHIUtDDWU1ylOOcQb4+U5VINFQKXV7ELQ0WwbOcryePVBd3VxH1zwAA7jKr8WsXcEzg2aapfg==
X-Received: by 2002:a05:6a00:1941:b0:710:5848:8ae1 with SMTP id d2e1a72fcca58-71e37e28ad2mr5574776b3a.4.1728658825459;
        Fri, 11 Oct 2024 08:00:25 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4a2c9767sm146561b3a.85.2024.10.11.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:00:24 -0700 (PDT)
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
Subject: [RFC v3 3/3] fadump: Move fadump_cma_init to setup_arch() after initmem_init()
Date: Fri, 11 Oct 2024 20:30:06 +0530
Message-ID: <759d0fc37d9fedca6cfe78ea7061447ecbf1bc77.1728658614.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
References: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
since pageblock_order is still zero and it gets initialized
later during initmem_init() e.g.
setup_arch() -> initmem_init() -> sparse_init() -> set_pageblock_order()

One such use case where this causes issues is -
early_setup() -> early_init_devtree() -> fadump_reserve_mem() -> fadump_cma_init()

This causes CMA memory alignment check to be bypassed in
cma_init_reserved_mem(). Then later cma_activate_area() can hit
a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
area was not pageblock_order aligned.

Fix it by moving the fadump_cma_init() after initmem_init(),
where other such cma reservations also gets called.

<stack trace>
==============
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10010
flags: 0x13ffff800000000(node=1|zone=0|lastcpupid=0x7ffff) CMA
raw: 013ffff800000000 5deadbeef0000100 5deadbeef0000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(pfn & ((1 << order) - 1))
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:778!

Call Trace:
__free_one_page+0x57c/0x7b0 (unreliable)
free_pcppages_bulk+0x1a8/0x2c8
free_unref_page_commit+0x3d4/0x4e4
free_unref_page+0x458/0x6d0
init_cma_reserved_pageblock+0x114/0x198
cma_init_reserved_areas+0x270/0x3e0
do_one_initcall+0x80/0x2f8
kernel_init_freeable+0x33c/0x530
kernel_init+0x34/0x26c
ret_from_kernel_user_thread+0x14/0x1c

Fixes: 11ac3e87ce09 ("mm: cma: use pageblock_order as the single alignment")
Suggested-by: David Hildenbrand <david@redhat.com>
Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/fadump.h  | 7 +++++++
 arch/powerpc/kernel/fadump.c       | 6 +-----
 arch/powerpc/kernel/setup-common.c | 6 ++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index ef40c9b6972a..3638f04447f5 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -34,4 +34,11 @@ extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 				      int depth, void *data);
 extern int fadump_reserve_mem(void);
 #endif
+
+#if defined(CONFIG_FA_DUMP) && defined(CONFIG_CMA)
+void fadump_cma_init(void);
+#else
+static inline void fadump_cma_init(void) { }
+#endif
+
 #endif /* _ASM_POWERPC_FADUMP_H */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ffaec625b7a8..c42f89862893 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -78,7 +78,7 @@ static struct cma *fadump_cma;
  * But for some reason even if it fails we still have the memory reservation
  * with us and we can still continue doing fadump.
  */
-static void __init fadump_cma_init(void)
+void __init fadump_cma_init(void)
 {
 	unsigned long long base, size, end;
 	int rc;
@@ -139,8 +139,6 @@ static void __init fadump_cma_init(void)
 		fw_dump.boot_memory_size >> 20);
 	return;
 }
-#else
-static void __init fadump_cma_init(void) { }
 #endif /* CONFIG_CMA */
 
 /*
@@ -642,8 +640,6 @@ int __init fadump_reserve_mem(void)
 
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));
-
-		fadump_cma_init();
 	}
 
 	return ret;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4bd2f87616ba..9f1e6f2e299e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -996,9 +996,11 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 
 	/*
-	 * Reserve large chunks of memory for use by CMA for KVM and hugetlb. These must
-	 * be called after initmem_init(), so that pageblock_order is initialised.
+	 * Reserve large chunks of memory for use by CMA for fadump, KVM and
+	 * hugetlb. These must be called after initmem_init(), so that
+	 * pageblock_order is initialised.
 	 */
+	fadump_cma_init();
 	kvm_cma_reserve();
 	gigantic_hugetlb_cma_reserve();
 
-- 
2.46.0


