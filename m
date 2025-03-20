Return-Path: <linux-kernel+bounces-569038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF0A69DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C65427F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4E1E5B6D;
	Thu, 20 Mar 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLZ5QMm2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3651E47A6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435770; cv=none; b=lCZkrda+r0gE0LxmftpI4JrtTWDKebbb8DGtqpyvqhibna4CY9sjHpeCkgaO0gJfgxqe+ijqb4FzJ0J276UiBjtGzdKrXgNMKismibZ/tull8m79xhEw0f1LUauEDIHbubBJgC5PuZoMHg8RW+OMsLE/md1ZOl2xarvnpyyYmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435770; c=relaxed/simple;
	bh=AF86V1HrI+3nybC0FOQlYJgcsXX0wMPkSqNC3XczELI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eg1vDLQVF3MMHSN/xYBReT6agVhLbJdieH3yaq97u6zaevvhuh4WPKaCj33y/ZfvJm8fx3M+RhOBEfVbZAa7CmrSU23HZNgh7ojfzPy9xJQvLZnCjHMTdavc4Wb6BS8pE73qK0blIHFDxDQcQCwLBws9SVoOrA9h/L9AFoqsT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLZ5QMm2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so447174a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435768; x=1743040568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiwjRVxMAh+aRSJQzROvUDuvUP7bfHphETD8QOGYAo8=;
        b=GLZ5QMm28Uj23XSIv3DlUp3Z95Pcn8dxSCDCNc81f1e1zsMTNc3MIa6fw8eVVCrBoq
         N02tzqqOZ2JhiHXdrMuIzRvhc191rQ9/IrP2N045gxeYtGf+rJrpw1/934WvFN7BH9gN
         SydOy0dvVg6vxMzrcy4E5ZWrdtGCNNaIiTDo6l4+PAq3QCr93rt4NhLffuo3E+HGod1/
         T8a6hBPZNLaCx9KsubeF8EWPmL6ApfEa6hHfWAZWxQPfsgyU6LILdquVkyg6Wp9fthWX
         9lXxGyZroCBtAtvZkPoLlNLLTNuH2a1eCat/uoAfHMW3v8a5hv0Nyh69jjHs3HlCGiTD
         x7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435768; x=1743040568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiwjRVxMAh+aRSJQzROvUDuvUP7bfHphETD8QOGYAo8=;
        b=DMKEPKYvEOW209eVCXFtX+nPiFUX579aCY0nr4gDLonbDIaEbbFgJzd+wdUiSp0W/P
         WGfoaOCi7E6NuG1rxe9myYJQsJTRBNJ9gvaP0dsYRsTQrojwjRK/uN4Qufp++5+4S/ig
         vydlnCR9wzUKSeSyvhION8F7mVRz9kQG6HaZiSqCVP+1n0zGFdlkboVAjUnWK/Dvb5H6
         eJLlrJpXzGQS9pKXdf0kJkv1ShMm7yuFrrG+swiXU5V5VM+VL9Vp7N6w9XUJQG+5kfuU
         vCfbEdvS8niOOU6NCYP/gNdByOvkUNZLt8xcRe+AVH4JK35STFnGd7Mgtnk8453sOTOf
         YBcg==
X-Gm-Message-State: AOJu0Yzk7ZhnpUi81/2tSiK3GgRCZt021v7gjx2mirPfi9DilSW+ifEN
	pcVBfylaGSwcOcRJglznsrXgu0x+9eObRbbrqisJINa6r8o/r5Z13CYsIY4FSKEJB0A0d/TCyVj
	eW+5nWagvceECLArSA+UBwkitNLFNR+gmlA3XDjhjTtnpF1n1obmsngsRw0P/1KuVlGLPs7088L
	f4qVNyCpodOCkmCrijJKDiy3/kAJQ3C7hyR31cYLp+eNa5DIUHUO5ue4EWub8rmg==
X-Google-Smtp-Source: AGHT+IEhVbWDRhW3hPJYHJMT+HzW9sk9EOurakKCEQdD5tgMb9uQ2NYyCFbTRsSUUBpQ3kTf4vM/PmcUJOjFZ+gE
X-Received: from pglu36.prod.google.com ([2002:a63:1424:0:b0:af2:22fe:cfb3])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4cc7:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-1fbeaf88adfmr8896191637.7.1742435768113;
 Wed, 19 Mar 2025 18:56:08 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:40 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-6-changyuanl@google.com>
Subject: [PATCH v5 05/16] memblock: introduce memmap_init_kho_scratch()
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

With deferred initialization of struct page it will be necessary to
initialize memory map for KHO scratch regions early.

Add memmap_init_kho_scratch() method that will allow such initialization
in upcoming patches.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h |  2 ++
 mm/internal.h            |  2 ++
 mm/memblock.c            | 22 ++++++++++++++++++++++
 mm/mm_init.c             | 11 ++++++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index a83738b7218b..497e2c1364a6 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -636,9 +636,11 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
+void memmap_init_kho_scratch_pages(void);
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
+static inline void memmap_init_kho_scratch_pages(void) {}
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/internal.h b/mm/internal.h
index 20b3535935a3..8e45a2ae961a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1053,6 +1053,8 @@ DECLARE_STATIC_KEY_TRUE(deferred_pages);
 bool __init deferred_grow_zone(struct zone *zone, unsigned int order);
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+void init_deferred_page(unsigned long pfn, int nid);
+
 enum mminit_level {
 	MMINIT_WARNING,
 	MMINIT_VERIFY,
diff --git a/mm/memblock.c b/mm/memblock.c
index c0f7da7dff47..d5d406a5160a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -945,6 +945,28 @@ __init_memblock void memblock_clear_kho_scratch_only(void)
 {
 	kho_scratch_only = false;
 }
+
+void __init_memblock memmap_init_kho_scratch_pages(void)
+{
+	phys_addr_t start, end;
+	unsigned long pfn;
+	int nid;
+	u64 i;
+
+	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		return;
+
+	/*
+	 * Initialize struct pages for free scratch memory.
+	 * The struct pages for reserved scratch memory will be set up in
+	 * reserve_bootmem_region()
+	 */
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
+		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
+			init_deferred_page(pfn, nid);
+	}
+}
 #endif
 
 /**
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c4b425125bad..04441c258b05 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -705,7 +705,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_deferred_page(unsigned long pfn, int nid)
+static void __meminit __init_deferred_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -739,11 +739,16 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static inline void init_deferred_page(unsigned long pfn, int nid)
+static inline void __init_deferred_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+void __meminit init_deferred_page(unsigned long pfn, int nid)
+{
+	__init_deferred_page(pfn, nid);
+}
+
 /*
  * Initialised pages do not have PageReserved set. This function is
  * called for each range allocated by the bootmem allocator and
@@ -760,7 +765,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_deferred_page(start_pfn, nid);
+			__init_deferred_page(start_pfn, nid);
 
 			/*
 			 * no need for atomic set_bit because the struct
-- 
2.48.1.711.g2feabab25a-goog


