Return-Path: <linux-kernel+bounces-360659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5899999DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9072874BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8120ADFD;
	Fri, 11 Oct 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBkznMmT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5A20ADF4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631430; cv=none; b=teMfc6vnOTaIJta4H6J2TRI8zwLI1zuce0BHnzdzhCQySuubqyisAuR7f9SoDHtfsV5fomtJAWGA3vVTAo1MbxNCcqbTP7Iym2JwtuRMhhozpq3RUZdcgd0821WU1T64baTYBzBoy3PA9vwMjCeAkw2gmb4h/O3XJ+iP9ULSA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631430; c=relaxed/simple;
	bh=IE9QpX5jYmdGcJKm9aBjxfQ0HBiGaeNjeifVxAkzwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNzSEY6tUzhNVDJZ3jfzggp8OsbSNveSe65AmBu3aI74qHaQqlAoKRbxktyzqdzVhutmIMu0zg8z4XxWCKyYZmep3/4nBH87S+IqbvvoR/XsKx3F2BFuIIVbTCN/SyUrYbEdQxFLjnBW2IB97tXWmahZl41rW7XT1lS/eef0mRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBkznMmT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bc2970df5so13676285ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631429; x=1729236229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43KeZkjM4JRDWlxAgOLwxp7bBo4Ct6yjaya1Z8Z5TnE=;
        b=IBkznMmTNrr3mG6LYNStmAa+Tbwqk8m8gDkf80o1ZsyzQKL+GLBb8RuhOyPWv52fNm
         uPedHje7bWN68s3zFai+LcEioHBu6ZDPAAKw8jyGZtI47JVOxTJgRueCH9notrKOvVoj
         ek+wf3G23NiiFjrM6ZAVxenMTiakSzZMziDV1ZYvF+tYh493OLGur+DuTQGxYxugOUb+
         551Avz058sSV64DmAcsuaigDpfNPhJY1vVTPFietlcLiunzh0es2B2gqxMq6Xmpqo1sF
         eiT2nY59SJDQyEhigM+anuXfF8fFLb7deRgoS88CQtMPLqlonXXA6McSG0E2VuWqVVT5
         7Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631429; x=1729236229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43KeZkjM4JRDWlxAgOLwxp7bBo4Ct6yjaya1Z8Z5TnE=;
        b=NYRVoNf0a1bJR6uptVzZums3ekrq75ayU9QK7FJhaFBk6RITo6xrik0d0lLFBzGlMe
         6EgIZXPNa1c0lgduiotzuIu1H3wijS9qDOZvXsygQvt136e9iJiHokuDkGKLUQDkyddy
         ZXvid6pCcF5wPSYnWCPPQTXTqkmLkbFa49/3Z+XKhzzTb2HeOuXX93mNF8igwp0tvPlr
         0pQhDgqH6BJhaGVIqhQz69u/TSK5cyE4teLO0GAdbkxQq5hSlhNX2fr+UTJQVZ2R5dK6
         r5xyHMgVdl3OX9KJNZHwv5SV7yIXqb049z7msWP3arApFJNTA3N/fRP1BrvVBKLdpHzy
         eBfg==
X-Forwarded-Encrypted: i=1; AJvYcCUWHi9ppT0Gh9r4JLfyj19vMOPpb60IWr3EMK7/l/axYnRIVBRBd5dbRJSZrr24kDUILDDp7duxzEXWC7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1vbZ5W3l1aqZSL6MJ4ghU/XWtVGhx8rTHYjkWCs9veLOG2mX
	l7vT0K/UGsFbt8K+zOZsw8KqRuKnntT/9+XVAzEH0RmvYOeWX3RY
X-Google-Smtp-Source: AGHT+IHvKjtMrFH1g3CLZPdSwjhTqkQHVaREuW1zEqrR1VLtKD+N3w5sn140uSYgK0zgLCGlE26s+w==
X-Received: by 2002:a17:903:228b:b0:20b:fa34:7325 with SMTP id d9443c01a7336-20ca16c5acfmr22757985ad.43.1728631428668;
        Fri, 11 Oct 2024 00:23:48 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad335dsm18825155ad.50.2024.10.11.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:23:48 -0700 (PDT)
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
Subject: [RFC v2 4/4] fadump: Move fadump_cma_init to setup_arch() after initmem_init()
Date: Fri, 11 Oct 2024 12:53:12 +0530
Message-ID: <819b34cc6dd63e21f142c1adbc1a88bc57f3db54.1728585512.git.ritesh.list@gmail.com>
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


