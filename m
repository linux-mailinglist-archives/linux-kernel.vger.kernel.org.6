Return-Path: <linux-kernel+bounces-369257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD849A1AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A151C21660
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EE1925B1;
	Thu, 17 Oct 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4va9FYV"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B213D51E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147520; cv=none; b=dgbPWU7MVzJb0Zuk7UbviHb+s+7plp5GfMtyimdKf0441lVRLOuEJETFhzp0sqOMISf+DDgGmW5BKyfrRvaTk/MNAzFf64qhU/4JVcwVnw+mBk1xQzYkhl9gNi0bo70F/qBp6xw/wzyPpMEm02RedhmMh4FRZfSjKh48CtZ9K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147520; c=relaxed/simple;
	bh=mTiZNpoRaPUlM7L9dLj5aDYSAyTi2geoEC6+vR4fGsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GfI7uyVr3P8yxzMcGxkV5aVw+h+XoHLwEr0w3qgTjL5ifXPdlsPVN0jauMwETtur00EQ0ybmbH9g2x5bnNDph2wdr9yK62HMKyQHaWxoNvFR4ZsnSh6kWYQ7oFYsq+ApqXD4Z3de4YlxJoWb0os1pmeF+wUpqimAACwywrrmiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4va9FYV; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5eb5d55cc60so347196eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729147517; x=1729752317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/dARpVJ2zTTx8pkql0HrYbCe1sx56SrqKsQKDyKAU=;
        b=D4va9FYVb20+H2jY7+qMi8XCyi79DRAliz3Z1Dg+NoCz+C9THT730EFv7wl2A/zQ9m
         PUJZsslgXhPjPNJNYB4+Gnabe5x+RVgc8XgwlgF1upDH3vSo650ckOpnl6zPI6m0xCng
         LxXksbn4RwrYHKeonD934Sz9sRVMj0/mdCDfhk0yHG2mPi+dqW4VmxMKY7sMUxNgOdV4
         xIjfmkFMFC647NU1Klbs60XVyNG5udVi0BEZcVRSpfJny60Oz3XtE+LO4i4tj8bT88Vc
         B1DrJ/lHMCNyZBJ34fiHSV+KAQ8IGqsBZ3yGwF6qXvrjoqzFNlX3LxNJD5m7zXVoXxWj
         J+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147517; x=1729752317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eg/dARpVJ2zTTx8pkql0HrYbCe1sx56SrqKsQKDyKAU=;
        b=IZVtxbCgx0/seWTsxi92i9vKT533w/vfpz42DnTiNKgDypWckvMJPnMT7MnyYTE3Hc
         6e/ZTYkxl/x590m6Z9q/BRCfbVN7j9Oywmg4f1gJT3ugVxVlIva5GgsFwFiUAhhGzFPH
         Incvbf1yE7mHMHv+InPPjCyx1ie+W/uLpDTUJm8s8ZVupCRw7vAibarLKmtmCcMnIi0X
         Cb7RenL8Xw30+bE2b5Gr7oEF5BlxxaxctfSj2w3+Fhl1VzMnaQ5U/gqDkigXd9Q5oC0E
         aXwa6Ot/Ls9yAQtMtObErZhXyq1K1yRdENflcYntgGtt/u+lQwp6W5vsuaaoftrAoSGT
         8rMA==
X-Forwarded-Encrypted: i=1; AJvYcCXRJwy1pP4h7KvY6gGxNyPZqNv7GmOX1oy3ZpNJMnCAiAYPj8dgxkzp047P+AX3FdnXea/WxBuQwRtNapU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREnCM0UFGZf2ymiElh4deQgn8v9L4aEcH3USEEOpK3EoUW4LV
	Wo9xCYFfZLwvMlfqir7OAszbuQHPkBEWKJa9I99K0sE0+KOl5JIM
X-Google-Smtp-Source: AGHT+IF1DJW63BwhM/9vKTDCclBnJXSQwNkkDV6bcfzfZaiy4cL0voT2x8uYBIqZgOWO/E9pCDkYjA==
X-Received: by 2002:a05:6358:248f:b0:1b8:6074:b53 with SMTP id e5c5f4694b2df-1c3783f58f7mr579392455d.10.1729147516676;
        Wed, 16 Oct 2024 23:45:16 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([36.112.24.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715c17sm4313391a12.84.2024.10.16.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:45:16 -0700 (PDT)
From: suhua <suhua.tanke@gmail.com>
X-Google-Original-From: suhua <suhua1@kingsoft.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhua.tanke@gmail.com,
	suhua <suhua1@kingsoft.com>
Subject: [PATCH] memblock: Uniform initialization all reserved pages to MIGRATE_MOVABLE
Date: Thu, 17 Oct 2024 14:44:49 +0800
Message-Id: <20241017064449.5235-1-suhua1@kingsoft.com>
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

Reserved memory mainly stores the metadata of struct page. When
HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=Y and hugepages are allocated,
the memory occupied by the struct page metadata will be freed.

Before this patch:
when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
placed on the Movable list;
When CONFIG_DEFERRED_STRUCT_PAGE_INIT=Y, the freed memory was placed on
the Unmovable list.

After this patch, the freed memory is placed on the Movable list
regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.

Eg:
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


