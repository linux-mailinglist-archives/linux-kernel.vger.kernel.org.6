Return-Path: <linux-kernel+bounces-339168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC9986102
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E271C25F44
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1241459E0;
	Wed, 25 Sep 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ0tYGu8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B100145346
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272096; cv=none; b=n1KBBjqnk9KzylhOFNzVtWeaMtRhGlu+s1NGm+lgmI47UpCAs8LA7TGoRqvZQmp9iSi480vH2hbPtCDa2eK7TJ/oIr4F37BU7EnGPxghLoXOMO/wK04WdpytfjBjRGZQL6YwyIMQBxynjPhsPmm7kSlHcGULpITUKYD+XAW+3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272096; c=relaxed/simple;
	bh=pJk0hDrWj7EqPg1IbLCCScrWpFdajUR4OC5eG7d8t8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ry75n54KiZIEYgHOKapmlRptzb0pzomPduez/0t5idtlSRM/GyzbUAUXpgHDFwv/onjZQYAlHAPzAvYamuzn1LBMzufc30fmsu/rqcxxAmzarUf19NrW8T5pLmZt5xt3r4WZsTH2KyzdXdj5bTwWLTLSGSG7P1cmj6zNWXoqtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ0tYGu8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206aee4073cso72610545ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727272094; x=1727876894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ssh+pRrf5L+2e4qG8n4IwFFdzUvMFGa+rHl+gGVC1w=;
        b=jZ0tYGu8lvcpDJo4sqThNxH/bHE+1fRyiFuWfJnY+hyRhxNV1bq3XP4SgWwgjdR/KC
         2CT1xailSrh9+BtQw7Qq7XMbU+19LIVyqYBzORTsH2Hmx9HR+XyijqvMm/62GC7gkzZi
         PbmvwCtKXYX5ILC3NhJZjIds+C5vjT8j8FPipmIRPHFpvl2EYlBRWXkh5MOPD708dGON
         5q/mjewrHfMd1rOFZ4AORd0T9S0/VVIld4lepscDwhM3hXNYfUhpjnVamTbJPhN7W5NE
         uANoJTSINiGxQu/vY+t+w/X1bX2vW53YoG88e+d0nTo3Cf0jZ0LsjZXkfRvZY2dFjceR
         MEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272094; x=1727876894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ssh+pRrf5L+2e4qG8n4IwFFdzUvMFGa+rHl+gGVC1w=;
        b=SVPKLiiqcoZ1PgsyUocCMbr21559/nOTLVaI/CCbtQDdnrMcF1UIz4qSKS/CDGwKZH
         KqTiFm500i7fThIIc9j5YaYVlRpyBObAO+DAr3WAh6X5ZVLDiy/BcY3+4I+rpvuQHGTJ
         lCWap8/nHJYXarfOITmE6yi71E6MWW4NRkmhdyyjdujvC4AgW5zqdilrh3d8hoP3nASb
         dbJT6RuCmGQCiNw69o8G9euyHrRUXrPbhBxukQagXYGzNp2nqNel9SP0Euh/aCghqRNO
         rg7Mx24wMQQS3hzo7UE4wngYHvpEdJe5dBTthPZoDqxnY+gHl37PMftvOxih8hZT18Hi
         nl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEN0Dd+vIR30KeGXT8/jLO4DTgXG7QcInKo9TH4KENkAHm94ugHkY2o6PhOU0EOVDtGASYjE7vpenLBcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNtopiMyv+WHE7dwQ9tS4FZjFYMtDOJp+It1BLYn/Y8mo8PXZ
	VUpZKjORUJkK+wTEDp9po3fvPYXFCnIt5CUswgq/Eg/C7LDnpJ50U/bV9eTX
X-Google-Smtp-Source: AGHT+IFvnb6qaqt/AhKZq9muVdeV36NHVgH5CzP6oOtqs1fRPaV6zcV9zEJsxuZIjVh15Lo5VOT1XA==
X-Received: by 2002:a17:903:234f:b0:209:dc6d:7697 with SMTP id d9443c01a7336-20afc44865bmr34325865ad.24.1727272093509;
        Wed, 25 Sep 2024 06:48:13 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-197-103.dynamic-ip.hinet.net. [220.143.197.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e7f40sm24958805ad.8.2024.09.25.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:48:13 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] kasan, vmalloc: avoid lock contention when depopulating vmalloc
Date: Wed, 25 Sep 2024 21:47:32 +0800
Message-Id: <20240925134732.24431-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When running the test_vmalloc stress on a 448-core server, the following
soft/hard lockups were observed and the OS was panicked eventually.

1) Kernel config
   CONFIG_KASAN=y
   CONFIG_KASAN_VMALLOC=y

2) Reproduced command
   # modprobe test_vmalloc nr_threads=448 run_test_mask=0x1 nr_pages=8

3) OS Log: Detail is in [1].
   watchdog: BUG: soft lockup - CPU#258 stuck for 26s!
   RIP: 0010:native_queued_spin_lock_slowpath+0x504/0x940
   Call Trace:
    do_raw_spin_lock+0x1e7/0x270
    _raw_spin_lock+0x63/0x80
    kasan_depopulate_vmalloc_pte+0x3c/0x70
    apply_to_pte_range+0x127/0x4e0
    apply_to_pmd_range+0x19e/0x5c0
    apply_to_pud_range+0x167/0x510
    __apply_to_page_range+0x2b4/0x7c0
    kasan_release_vmalloc+0xc8/0xd0
    purge_vmap_node+0x190/0x980
    __purge_vmap_area_lazy+0x640/0xa60
    drain_vmap_area_work+0x23/0x30
    process_one_work+0x84a/0x1760
    worker_thread+0x54d/0xc60
    kthread+0x2a8/0x380
    ret_from_fork+0x2d/0x70
    ret_from_fork_asm+0x1a/0x30
   ...
   watchdog: Watchdog detected hard LOCKUP on cpu 8
   watchdog: Watchdog detected hard LOCKUP on cpu 42
   watchdog: Watchdog detected hard LOCKUP on cpu 10
   ...
   Shutting down cpus with NMI
   Kernel Offset: disabled
   pstore: backend (erst) writing error (-28)
   ---[ end Kernel panic - not syncing: Hard LOCKUP ]---

BTW, the issue can be also reproduced on a 192-core server and a 256-core
server.

[Root Cause]
The tight loop in kasan_release_vmalloc_node() iteratively calls
kasan_release_vmalloc() to clear the corresponding PTE, which
acquires/releases "init_mm.page_table_lock" in
kasan_depopulate_vmalloc_pte().

The lock_stat shows that the "init_mm.page_table_lock" is the first entry
of top list of the contentions. This lock_stat info is based on the
following command (in order not to get OS panicked), where the max
wait time is 600ms:

  # modprobe test_vmalloc nr_threads=150 run_test_mask=0x1 nr_pages=8

<snip>
------------------------------------------------------------------
class name con-bounces contentions waittime-min   waittime-max ...
------------------------------------------------------------------
init_mm.page_table_lock:  87859653 93020601  0.27 600304.90 ...
  -----------------------
  init_mm.page_table_lock  54332301  [<000000008ce229be>] kasan_populate_vmalloc_pte.part.0.isra.0+0x99/0x120
  init_mm.page_table_lock   6680902  [<000000009c0800ad>] __pte_alloc_kernel+0x9b/0x370
  init_mm.page_table_lock  31991077  [<00000000180bc35d>] kasan_depopulate_vmalloc_pte+0x3c/0x70
  init_mm.page_table_lock     16321  [<000000003ef0e79b>] __pmd_alloc+0x1d5/0x720
  -----------------------
  init_mm.page_table_lock  50278552  [<000000008ce229be>] kasan_populate_vmalloc_pte.part.0.isra.0+0x99/0x120
  init_mm.page_table_lock   5725380  [<000000009c0800ad>] __pte_alloc_kernel+0x9b/0x370
  init_mm.page_table_lock  36992410  [<00000000180bc35d>] kasan_depopulate_vmalloc_pte+0x3c/0x70
  init_mm.page_table_lock     24259  [<000000003ef0e79b>] __pmd_alloc+0x1d5/0x720
  ...
<snip>

[Solution]
After re-visiting code path about setting the kasan ptep (pte pointer),
it's unlikely that a kasan ptep is set and cleared simultaneously by
different CPUs. So, use ptep_get_and_clear() to get rid of the spinlock
operation.

The result shows the max wait time is 13ms with the following command
(448 cores are fully stressed):

  # modprobe test_vmalloc nr_threads=448 run_test_mask=0x1 nr_pages=8

<snip>
------------------------------------------------------------------
class name con-bounces contentions waittime-min   waittime-max ...
------------------------------------------------------------------
init_mm.page_table_lock:  109999304  110008477  0.27  13534.76
  -----------------------
  init_mm.page_table_lock 109369156  [<000000001a135943>] kasan_populate_vmalloc_pte.part.0.isra.0+0x99/0x120
  init_mm.page_table_lock    637661  [<0000000051481d84>] __pte_alloc_kernel+0x9b/0x370
  init_mm.page_table_lock      1660  [<00000000a492cdc5>] __pmd_alloc+0x1d5/0x720
  -----------------------
  init_mm.page_table_lock 109410237  [<000000001a135943>] kasan_populate_vmalloc_pte.part.0.isra.0+0x99/0x120
  init_mm.page_table_lock    595016  [<0000000051481d84>] __pte_alloc_kernel+0x9b/0x370
  init_mm.page_table_lock      3224  [<00000000a492cdc5>] __pmd_alloc+0x1d5/0x720

[More verifications on a 448-core server: Passed]
1) test_vmalloc module
   * Each test is run sequentially.

2) stress-ng
   * fork() and exit()
       # stress-ng --fork 448 --timeout 180
   * pthread
       # stress-ng --pthread 448 --timeout 180
   * fork()/exit() and pthread
       # stress-ng --pthread 448 --fork 448 --timeout 180

The above verifications were run repeatedly for more than 24 hours.

[1] https://gist.github.com/AdrianHuang/99d12986a465cc33a38c7a7ceeb6f507

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 mm/kasan/shadow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 88d1c9dcb507..985356811aee 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -397,17 +397,13 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 					void *unused)
 {
+	pte_t orig_pte = ptep_get_and_clear(&init_mm, addr, ptep);
 	unsigned long page;
 
-	page = (unsigned long)__va(pte_pfn(ptep_get(ptep)) << PAGE_SHIFT);
-
-	spin_lock(&init_mm.page_table_lock);
-
-	if (likely(!pte_none(ptep_get(ptep)))) {
-		pte_clear(&init_mm, addr, ptep);
+	if (likely(!pte_none(orig_pte))) {
+		page = (unsigned long)__va(pte_pfn(orig_pte) << PAGE_SHIFT);
 		free_page(page);
 	}
-	spin_unlock(&init_mm.page_table_lock);
 
 	return 0;
 }
-- 
2.34.1


