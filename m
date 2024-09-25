Return-Path: <linux-kernel+bounces-338420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47894985791
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C651F215E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54029482D8;
	Wed, 25 Sep 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2+f7a93"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD3148FF5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262169; cv=none; b=M8miHh5VVhRwJM68je3lmB0/qc8ntVsHRwFYvoIofjjMt5/pfSe2vlUB1a8YmNrMhl49Roe+atEmkbtON4JiCne+TnmReL0UIugSqPyJTfJ9lZv3s2mR0xPyj4msjGrpA5Hs/ujGvsJZzzQwhumOLmG6kPGTeAJem4urw5Ul+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262169; c=relaxed/simple;
	bh=EHDlqYpRW0WDQcOUHATkbkOv8wtD0AodAdpR3/rivOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bMN9gd02+c96p31TYQIc3QnxD0LGMPn7eJerWrj/TAr1Re5lnKzdAhUFWAF7Teq1cTQIl1orbYmzrC4sJyVyK/FpyU0GgeRE8yHUTncOnxX8LjhHi1BoqUpvEsAFBHW64kSs7bMuSiVkF3ZdUqJE7YOAKv2NrTvBpIPo2O/NgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2+f7a93; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b070ff24dso1075704b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727262167; x=1727866967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ceyj2o9QOKbh7xeEuScadckePN7JH5NC03dCcJMcGQI=;
        b=M2+f7a93qoeppPB7MruXCxR26iZs6wuHxke3/hN8eWbvUEL7EOYjvl8AP7AvjpdlPr
         ENufC5R6gricVCr1pYWm5bbOr8pil3FKD4OiTs+NUIYplXgBZXNYqOLxUfp52p21yRbi
         mGcYezXnJrrSsOewGgCKC3BmGnHZMv7QTo2C3aQf1HeIDyFUYUqLibIfGuAETGjOkN7a
         IavksWyWnz4TfYgwV3q8jpAiNsU3hXNtlJvXVN2DTIAKx8L8+rZMwt+jkoGQbs+i1jdu
         cT/FB0kRhy27xQgkZVPFKtGLAcTJ7oVq6A0gKXHnrZLGNYBt17KvylS4Dts4j2AlAARJ
         +ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262167; x=1727866967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ceyj2o9QOKbh7xeEuScadckePN7JH5NC03dCcJMcGQI=;
        b=klfqRlSEK/Ov7iOMp75gED6ZWJb8pwoVhu+/udFmqDYSxPH4oXt2AjXPmrC9pWUwAB
         6k2DqHbfo4c9y+zRSi3PVTBrxtetWIr7TZo+/FHL4E2mUWdigLsowaYhwYtRGkXnflBG
         VzG3FkzFtHruS8B+8XMErLu3hTFZPC6xHcJ/xI+ELf5jE3ZzXl2BzXUTL+LLicm7QEGu
         nVYLZlhUdF0EXVvD+f/4jidq+ZZ2xmAre0amnUSf7+/UY9RVnxkF/rGqn6t/e22TOGJR
         xWjbVXSyJc//m/eP8jMHr6bbrdgr0CgKfEvqDOhx7mfb2Bxq0nJxgCjXhHypftKALFvc
         jj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6qaBDI1DPdCU9ZjakDyCpswomqs7sR2nGDGWwstJexJ4GVMhNN0s7xE2TRw7v/6BQ65hKrf80QHywN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFOv7qcEnPK7O1niY3ogUDywo7EPpTp6oL3MpUa9IuFznPQpt
	avHG7HYwbE915+LM+TrHUUjfdY7x0/5fj+QEMPoOPRmT4WQdj5qOW/QzVfRObJY=
X-Google-Smtp-Source: AGHT+IFNcyHeyTxm8cb7thd2RC5B6sYdTx/bOe6ID57RG8tqxQBhzZmHrBhkrzBlQIBh3l/rGX0QCQ==
X-Received: by 2002:a05:6a21:78e:b0:1d2:e1cc:649c with SMTP id adf61e73a8af0-1d4d4aaf073mr2902845637.15.1727262167177;
        Wed, 25 Sep 2024 04:02:47 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([36.112.24.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc843571sm2547604b3a.47.2024.09.25.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:02:46 -0700 (PDT)
From: suhua <suhua.tanke@gmail.com>
X-Google-Original-From: suhua <suhua1@kingsoft.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhua <suhua1@kingsoft.com>
Subject: [PATCH v1] memblock: Initialized the memory of memblock.reserve to the MIGRATE_MOVABL
Date: Wed, 25 Sep 2024 19:02:35 +0800
Message-Id: <20240925110235.3157-1-suhua1@kingsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After sparse_init function requests memory for struct page in memblock and
adds it to memblock.reserved, this memory area is present in both
memblock.memory and memblock.reserved.

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set. The memmap_init function
is called during the initialization of the free area of the zone, this
function calls for_each_mem_pfn_range to initialize all memblock.memory,
excluding memory that is also placed in memblock.reserved, such as the
struct page metadata that describes the page, 1TB memory is about 16GB,
and generally this part of reserved memory occupies more than 90% of the
total reserved memory of the system. So all memory in memblock.memory is
set to MIGRATE_MOVABLE according to the alignment of pageblock_nr_pages.
For example, if hugetlb_optimize_vmemmap=1, huge pages are allocated, the
freed pages are placed on buddy's MIGRATE_MOVABL list for use.

When CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, only the first_deferred_pfn range
is initialized in memmap_init. The subsequent free_low_memory_core_early
initializes all memblock.reserved memory but not MIGRATE_MOVABL. All
memblock.memory is set to MIGRATE_MOVABL when it is placed in buddy via
free_low_memory_core_early and deferred_init_memmap. As a result, when
hugetlb_optimize_vmemmap=1 and huge pages are allocated, the freed pages
will be placed on buddy's MIGRATE_UNMOVABL list (For example, on machines
with 1TB of memory, alloc 2MB huge page size of 1000GB frees up about 15GB
to MIGRATE_UNMOVABL). Since the huge page alloc requires a MIGRATE_MOVABL
page, a fallback is performed to alloc memory from MIGRATE_UNMOVABL for
MIGRATE_MOVABL.

Large amount of UNMOVABL memory is not conducive to defragmentation, so
the reserved memory is also set to MIGRATE_MOVABLE in the
free_low_memory_core_early phase following the alignment of
pageblock_nr_pages.

Eg：
echo 500000 > /proc/sys/vm/nr_hugepages
cat /proc/pagetypeinfo

before：
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
…
Node    0, zone   Normal, type    Unmovable     51      2      1     28     53     35     35     43     40     69   3852
Node    0, zone   Normal, type      Movable   6485   4610    666    202    200    185    208     87     54      2    240
Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Unmovable ≈ 15GB

after：
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
…
Node    0, zone   Normal, type    Unmovable      0      1      1      0      0      0      0      1      1      1      0
Node    0, zone   Normal, type      Movable   1563   4107   1119    189    256    368    286    132    109      4   3841
Node    0, zone   Normal, type  Reclaimable      2      2      1     23     13      1      2      1      0      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Signed-off-by: suhua <suhua1@kingsoft.com>
---
 mm/mm_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..e0190e3f8f26 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -722,6 +722,12 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
+
+	if (pageblock_aligned(pfn)) {
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+		cond_resched();
+	}
+
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-- 
2.34.1


