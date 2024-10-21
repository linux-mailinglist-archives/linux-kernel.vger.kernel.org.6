Return-Path: <linux-kernel+bounces-373639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101D9A59A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86003B22118
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB77194082;
	Mon, 21 Oct 2024 05:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id6CTLzu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87B20309
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487547; cv=none; b=EpJV1UaUcn48FPf3f1zAWmnIpeCEOm9kjQFf6ncfTDBWD/jRTzzXYVFffTyH0/63wGLJtzES40GQ0Hi09sCDZ7O7AgQJ1B8R/EGDBE4ZwqMaERBURoci05WOf1Ktx5U3H+FDZk5edu3Xj7LIM7JWVG/3zyky3z9+pNzE0gRR9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487547; c=relaxed/simple;
	bh=FH/dzOCM+0RB+hWonVHoCZB+VPJGOudEkzxXg+9wtXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VY2LCC+zXmP7yXbEFlSxE0AIEmsNxnvLGzryicmJyzaTKllU8DABEmb+KPWD51spw6738OexlMub8SjuxrCa0ecWuLTL6n4igVq+nA0eA1xPHvc6i297/4OEnuOjFSWKhq727kQutq4Blleua6UDo3dt9tUglM6GVsXz9JxsbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id6CTLzu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c693b68f5so42530175ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729487545; x=1730092345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsHb9+hp0hI9PDOsgwvZsutcEgaMa7sk2a/4tz58Qi0=;
        b=id6CTLzuo1Ix8K3JEP4qPIRPTbwIAajuTKaQiS3sXqhTMITjzkwhJQPsQo0H8XXaiu
         XGcl9U5ufUAttCNGcMBcObeYiMbWq4J2mx9ATyHgWcjxuRrFD9u9rJv0AUXyCrsEZwvA
         JSLR1WFY79vbGSfH6ijT0CMGDWwwOCRe8QNQlWReHIzVZCDqmTJLAVfYenAOl1tqkwj9
         ZhHO40xP1nHp2eyxKN8H/YqQAqc3M50SFgU+1dkUcqG4LL1B23JgVgK7kMVR9T/uY8Op
         wnUKl5aaJEs1BgMfiltNEvh7FkV/FC4wGA3NlbYiyTyhv55j07EB6S3Aa1jYG0se4r7t
         izkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729487545; x=1730092345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsHb9+hp0hI9PDOsgwvZsutcEgaMa7sk2a/4tz58Qi0=;
        b=L9uEJY2QHS4EcjQ6Cfc6L4ZiXJMsKdSzexSzHVTESNebG6ZywUiMq530L3fFvgqX8a
         Qx/kZfVmHy8V4HLpVe1yZm8IFj3X4DYFZO+8me6ZzuPnVU+14amka9JC/0ePPovEi3fO
         CnZ0WYAwTVyF7Y0SE9JnNTn/uxDH0hCNVo7m0zeNYbdxW36RDtDCdEAXJVC6l+KXnnam
         8ZXMadB+dBlqrMNAR8H1t2jCJXhbH7Hui7LV1h4CVIMIHKQeFVF4o3qCrV3ANQBQqglH
         0FN9MFvWBJ1cdM10HJA3fHHq2YJyIv68EHqV3WrDKCJb/ALvMUmRS6HmeqzRgfu8jzIJ
         Sypg==
X-Forwarded-Encrypted: i=1; AJvYcCU1rpxxcrb3UriULciEUjoK3GNGjPEfd02HkevfMwi6M15j1KKMd4JPi7x5i1iAhNmC1CTcwrxKXxd/tow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzincrkf3iedOAYkzzvaQa/LE/cSTMQoQ6Utc3w5RBsy1cqIsB3
	6qijuj3NOWlAWeCNm1lK9Bpu++CWwpuN4yR7A8KFATtVHr5MdoZjh4Nk7w==
X-Google-Smtp-Source: AGHT+IEEd6fksooFUBRMO+r7hmkAlcF9h4gJUG3DYHqoX0nkc7D5yPu+3IJVk2ia2lpsxmM+TxSuGQ==
X-Received: by 2002:a17:902:d484:b0:20c:98f8:e0f5 with SMTP id d9443c01a7336-20e5a8f3e6emr137246325ad.43.1729487545209;
        Sun, 20 Oct 2024 22:12:25 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([183.197.220.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de39fsm17607485ad.206.2024.10.20.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 22:12:24 -0700 (PDT)
From: Hua Su <suhua.tanke@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hua Su <suhua.tanke@gmail.com>
Subject: [PATCH] memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE
Date: Mon, 21 Oct 2024 13:11:51 +0800
Message-Id: <20241021051151.4664-1-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserved
pages are initialized to MIGRATE_MOVABLE by default in memmap_init.

Reserved memory mainly store the metadata of struct page. When
HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=Y and hugepages are allocated,
the HVO will remap the vmemmap virtual address range to the page which
vmemmap_reuse is mapped to. The pages previously mapping the range will
be freed to the buddy system.

Before this patch:
when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
placed on the Movable list;
When CONFIG_DEFERRED_STRUCT_PAGE_INIT=Y, the freed memory was placed on
the Unmovable list.

After this patch, the freed memory is placed on the Movable list
regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.

Eg:
Tested on a virtual machine(1000GB):
Intel(R) Xeon(R) Platinum 8358P CPU

After vm start:
echo 500000 > /proc/sys/vm/nr_hugepages
cat /proc/meminfo | grep -i huge
HugePages_Total:   500000
HugePages_Free:    500000
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:        1024000000 kB

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

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
---
 mm/mm_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..6dbf2df23eee 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -722,6 +722,10 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
+
+	if (pageblock_aligned(pfn))
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-- 
2.34.1


