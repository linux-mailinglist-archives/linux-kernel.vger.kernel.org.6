Return-Path: <linux-kernel+bounces-372032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E829F9A438D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E7284C42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677312038D3;
	Fri, 18 Oct 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFes32Bt"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B51D1E64
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268305; cv=none; b=c8AUCzz59lBeNc+3KkzpTYSOmjAaSjZfujTPpd89lBgAmrAdISU33f7X2kaSSspOupqkAmo4AKBjDbG7sPDGDnBg9eYQDNL80n2D6CelQJ5kPhLKS2RLxkkLCaG1F0Tzqnv5Rh6vdcU+ARZffDDxwmMIL3gHjZ/nvj962eWnSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268305; c=relaxed/simple;
	bh=ElIhMcpDEU4KMqOKT7SEuHBXUQdSoZwSu4Uca1PCNoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6mUDOw/IOSlqiSAxJjZPPa/xwuII57hnrpkvVZyVLIqwIKF6glVKhXKkIfaLF1klsVUyu++87Ufau0OrgOHToNhZMYjj+qFGW3UKzxCsXOPP58+xOCPJfj5KKg2YnqbFTAttN9zX67tqGbND6L1lm+dmmFM0b3dE4haCQITqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFes32Bt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso1615891a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729268303; x=1729873103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLmZcdH3+iUB7uSULBBt8ADH32xOpUfbglYzjMZPi2A=;
        b=bFes32Btj2Z+8eM5J4fbIOPrlPPaIQnoca4XjoXhHXoNeSZpmPUSfdA+RyUAQ4kbcx
         OwMec5qPI2dPSutFlVgVO9oKf/drtXTA4fPh1Xxos+f5TqMEKRxNJEZ9aijp5oXsSjvX
         0ls1wxHFn82IwRzKQ1tB6TFnRyOth06y3uD2Es4Wec9LoSoVi8s9p7RvAE8gipoh7wIi
         xWPPCXyqHSyJkCfcHV411DpMT8cUAQs774E6j43wMq4pAXTg9ANGgMHJHKBRAiGd9DN8
         r3IMMpI+qCrSQgMBRbOPRJsiItASrCMpWmltuOAsypUCCTKtonylBAbCDgg26LYaqxTV
         wyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268303; x=1729873103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLmZcdH3+iUB7uSULBBt8ADH32xOpUfbglYzjMZPi2A=;
        b=gIgYYKxodZFR18P75R5z2zHsnHmPKpj2OTU9H82Oz59yyvy7di5w8wi/QPapsCJCni
         oQFZh4Br436jOyf4gEfg73KHF257pAYgR2FyLkVq3J/uy4DhRfq93o2pN7aQ1EE4VE4s
         mKiJ7wa8JlM609dDdWZqXC3C06CMlCxUgh7pAKzqZWl+VvYx8C7e4XklHbdH0u6mzrXZ
         gIPcVNQcI/Px4RvkBJvXcxEUhhQ/6uJLhkRGoOmyD1pG13iVFHc+M1c2WAGlEnfsJwr7
         pffZto1MsaA1SGBxTcTZVsXopuR/JjRrsd1NA7UrfqoLar3ie5JGb33vXSIwQfBsMDrl
         fN4w==
X-Forwarded-Encrypted: i=1; AJvYcCW2ziOmC8PvhiPPcabRc73jKUullA+rRRQ58VOwou8mu2OJqYJBCn9ssnTkv4MAITocFrQGgDVuU8brCYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6gv74Sa9vvUDqhZnywVO3YD5rQzVhSkaOIaRnOF88zTP/Ign
	8hI8TolLHsdB0n1JT2+FdG5wTAnxx2qylHXzok0MPy5I9LojRAxl
X-Google-Smtp-Source: AGHT+IFFH2dXD4/u8KGoMcsdlAu0XJqAkbNBFR0eSBy3BkBtBCA1KnsX++lMxG2V+BFH8gOUwBq8xQ==
X-Received: by 2002:a05:6300:668a:b0:1d9:2992:d6c2 with SMTP id adf61e73a8af0-1d92c49fc95mr3759338637.2.1729268303039;
        Fri, 18 Oct 2024 09:18:23 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345677asm1692140b3a.147.2024.10.18.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:18:22 -0700 (PDT)
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
Subject: [PATCH v4 3/3] powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
Date: Fri, 18 Oct 2024 21:47:57 +0530
Message-ID: <3ae208e48c0d9cefe53d2dc4f593388067405b7d.1729146153.git.ritesh.list@gmail.com>
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

During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
since pageblock_order is still zero and it gets initialized
later during initmem_init() e.g.
setup_arch() -> initmem_init() -> sparse_init() -> set_pageblock_order()

One such use case where this causes issue is -
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
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
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
index 943430077375..b6b01502e504 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -997,9 +997,11 @@ void __init setup_arch(char **cmdline_p)
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


