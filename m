Return-Path: <linux-kernel+bounces-439215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444B9EAC73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BF118878AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D022330E;
	Tue, 10 Dec 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR09sli1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4269223303
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823286; cv=none; b=W2knfAIw2N6gH1N405U0Uch6QMGmdzZYt0YELb39DZQigr0xd3yHdvyh2YVvmeBxkIWd3Bcd07531/dTYDufBBeN1yhvVhbD2pNRyCVl76qLak3ZEbZx2KNkjrHRPqlrkOUL57eNKtXeQAean06lxD2IPnnpS9PWJBiIwMK9LpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823286; c=relaxed/simple;
	bh=ElXP8yFZ6wrLbaHVXnASfKVk5yiYGrY60JXxHO8wEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SARGBCiutFd8pXG6fF5aF552h3b+uZYjz44rCq6xNri3zuNKxEzT75mjxjyhtVcJMxXI3s+HxhJsuEvd5TW/yWg+FuYbFNXiOzoocFSdelGHvEVNuUl2QtMx/sVg+IjH7AjhrxTGOiEw1KYlNBjRTBRxCgTtooICdhOw/8m0fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iR09sli1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aJTE5aAWIDEa6vwoKjHOaUlIQUcp6L018sbCgFuL3Us=;
	b=iR09sli18370tAwj7rHyxi/Xs5nU8JmBmne4jUOPj64JMAITTJZDiPqxz2FDBHaC5Wk7ZS
	VcGfK1gh6l0eJ/p75CzVkMOSysUrU3+qVlowDi05KQZJr+BDd3rfREG6fdJM+bbgNrDBsH
	ahpa4f4mVP5RSQvghdxtj2CIaPHYk4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367--gn-KHU5OPOJt5HHlx1yLw-1; Tue, 10 Dec 2024 04:34:41 -0500
X-MC-Unique: -gn-KHU5OPOJt5HHlx1yLw-1
X-Mimecast-MFC-AGG-ID: -gn-KHU5OPOJt5HHlx1yLw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f5573794so12403305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823280; x=1734428080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJTE5aAWIDEa6vwoKjHOaUlIQUcp6L018sbCgFuL3Us=;
        b=LUYsxgNYVr7If0JWPwqlUyJJaS3TCxM7BgonogU8c/qp4KgIfhiiBSYHFcuGW8q0bj
         LDdiLPqRsdqvZi1wjjqVmJ9AVKsZvy56en7kWE5/Ka537fv8BkuxZ3Xn3jwiTQq4g5Al
         6mRyBANIqD6kYg4R+TaRrUs3NQS0jwWEZt9X6vIbZMOQCnG+jKLaoOM0suLJhlrcKYx6
         sQWp5Jdbwss6vMo8frOY8vUG+fb/csm3JEhN6gPY2IUHR7Bizrn0Ky5q3AvzwQuDSrNb
         ZWegRJa9BDFErtJMGlUwsMDFpubWheDdHYzmk1ctj2zLPYkHNefwK6elTFucBLfscqeV
         Yg/w==
X-Gm-Message-State: AOJu0Yw0ARj5rmqHizpXztJ+WFvA37kqK6/4TJJe8UF9dRBILS9ivDW5
	J0TlGbq/JMVztN+vNvunF7vtxjg/IsijDEEKyMedvX5df9NDb7tHPqAZKqtj8bHoKy9rilQWrMj
	L8iPGcoOJHiNbZI3GEeDsLCPZ5rzZXIZAUib7JKAwQaud/fT2MATedv69/NGNcNJwbRwA1oElnF
	qr23kKJQdDznDH0YTO1RhhLIH69NzwbVeNlOX2NjZkRw==
X-Gm-Gg: ASbGncsY+9bX9Mb0N8RROt3rh3OZEjPBGp3fK9CvGrgtJKQFE9pQgEPB97GeZTRKM1A
	2seDsKxzVHrqFIPOaB39jHzT2ggr+5RqXXkuIJ4YfRZJ1KzTbrgAcUkV1HNI9VFbGe+o4YharwI
	I2l9F6mUOacamVVc2T1Xqp3eDsFrxr83/ZXHRV+9l3T5P6x+Le8/l2qmqPcTRIunOpGhOxZiLjT
	kgwGYMawCwSTxY3c+Y+bog2cIeoiWivh6MbQ/g+v/xer4kVphjo6tI4sOW6jifQR0rd0piwC6L1
	Yk1x+vVmA+GP6HCGgqCEhTByQr1pvsZ4dhLXmD0=
X-Received: by 2002:a05:600c:46c6:b0:434:fddf:5c13 with SMTP id 5b1f17b1804b1-434fff4b38bmr31213495e9.14.1733823280371;
        Tue, 10 Dec 2024 01:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiSIcThERj1j+yIda8YMpOdaSblizl8osiTYt8iJ3IApoHVuyuGpAwgTEfZiyREhYWF3Jphg==
X-Received: by 2002:a05:600c:46c6:b0:434:fddf:5c13 with SMTP id 5b1f17b1804b1-434fff4b38bmr31213175e9.14.1733823279931;
        Tue, 10 Dec 2024 01:34:39 -0800 (PST)
Received: from localhost (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434faeda409sm54729765e9.7.2024.12.10.01.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:34:39 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly non-existent PFN in split_large_buddy()
Date: Tue, 10 Dec 2024 10:34:37 +0100
Message-ID: <20241210093437.174413-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In split_large_buddy(), we might call pfn_to_page() on a PFN that might
not exist. In corner cases, such as when freeing the highest pageblock in
the last memory section, this could result with CONFIG_SPARSEMEM &&
!CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
and __section_mem_map_addr() dereferencing that NULL pointer.

Let's fix it, and avoid doing a pfn_to_page() call for the first
iteration, where we already have the page.

So far this was found by code inspection, but let's just CC stable as
the fix is easy.

Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48a291c485df4..a52c6022c65cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1238,13 +1238,15 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	if (order > pageblock_order)
 		order = pageblock_order;
 
-	while (pfn != end) {
+	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
+		if (pfn == end)
+			break;
 		page = pfn_to_page(pfn);
-	}
+	} while (1);
 }
 
 static void free_one_page(struct zone *zone, struct page *page,
-- 
2.47.1


