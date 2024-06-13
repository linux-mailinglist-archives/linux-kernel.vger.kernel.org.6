Return-Path: <linux-kernel+bounces-212397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6838905F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D266283573
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3FEECC;
	Thu, 13 Jun 2024 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtqGFxq0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F965382
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237288; cv=none; b=B+NZWxhJytnKe1BazPe3jG6GTWWOPEciN2ArDL6U5Qr/hxb48ERkNsQfuPlFZfuxGvvtWh/Xqd8y71EPVsAhyQthBaVijw5jB7EwnmA9XIAHbE9vxUvpG6lKuooGCAdkX04lzYI+S/NuzOEE49qKoOmGvuW5nxNABV65C+0mPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237288; c=relaxed/simple;
	bh=WND7e/sneIYamSwVZtwK+Jk7CqxRkWKfBklPXPWTRbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLNpxDjvDsOPfCvczYmtH02Q4lwtVyicJqDKq71B8mxDPxqCZqpXMtkh6qABqYXSgJLWNpej9wBJYs+khHRvu4+N4TJvb/bFrJYu0AjaFUrKyv6gVmKGB4dLO4z4pX8QU7DGu6SKYy2njpxxzUmzgUGU2hIzHl95aQwUVk5xiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtqGFxq0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70509b811so3275615ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237286; x=1718842086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCCgBtm4kYdnlOxW6KC7ddfNlNkcCijSw9u/7Ny6adI=;
        b=mtqGFxq0s718aGq/qUQq+dCjlxcPFZxeudcZvKeSJcHLfa8qh3mLWs+iA0ejWTNeQ+
         qPbBt36H+IZs5hN4h28886tw7/FqxlSg7ezsFCcE7FLj8dBSAFDo39p1f58qPXZUl17a
         yxc5rgCqwK574hHH0SsgSU00QUX83X84JgR369wCD428RoezejV1yTt1/JVpH6u+yJ+X
         sDd4a829IAGcLpHD82XPPQuK2C4Qjqo5tH687qNPlEy1CHaqbcY6Q/ifNMhr+ZEoTYSB
         PWhfvxs/T9p7FtPI/XCOw5VGg014d+aERSrSPH2SqXxxn4dssEjLgUP89KFL5f0U+YIq
         MhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237286; x=1718842086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCCgBtm4kYdnlOxW6KC7ddfNlNkcCijSw9u/7Ny6adI=;
        b=MzBRylS1H96gIYacn5Q2nsSPlSn/Moz1JBL/lIjlwmVHK756tCfPINfMpYL7ljZCB7
         RTLsTSfTqZ6oG6jcp4cJejfLLoMVFweoJeL7Ld1i8NYRe4kNTnbhwTIynQHDoazIsO/Y
         Af0QHLQxdOVcdPWoppXaNSo5QuDSiI1EL4nsDWDtnHZas+OfIKvAlshK6+BicItP2qF+
         xr3zX5UIbvXYeGLvtBXnQ3ji1/yllVJEZJ+bqwehG5VzkOJ6jAr3u2rT/0l+SoVHTxXo
         tHMXj/NE4ADYq3a61J11rU2xiH8yXYl/V54yYoAUKtpN90E4W6JW7ZP3G2u9m+EdE19Q
         WbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33UfnXD/B3ubdxpKPnTczz7QKjPcV06CKcklg1a4JI9AXobFax65iOfB8zbKICPNVjTzXlVwYSxlz/v/LMjIp6LlZ6+Jo8YfGcc5A
X-Gm-Message-State: AOJu0Yxvn7VWPWuLaACntAR9++NlpMym/nnGU+QqOLstIcYzGgPzXBTH
	kZBgqGlnSoUk4+pxXvAO3Kh+J4idWPNNukU93lfpd7LLO+uw+PJZ
X-Google-Smtp-Source: AGHT+IF3arrhaKJraeaVPGonKcs+bjSohtVRGhBzdoUWTP+KTk/DXUJQQ7qlrLIgRjj+zyClZOrwPA==
X-Received: by 2002:a17:903:188:b0:1f7:1c84:13cc with SMTP id d9443c01a7336-1f83b713848mr38288865ad.42.1718237286072;
        Wed, 12 Jun 2024 17:08:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1af16sm525515ad.246.2024.06.12.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:08:05 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	yosryahmed@google.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yuzhao@google.com
Subject: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
Date: Thu, 13 Jun 2024 12:07:21 +1200
Message-Id: <20240613000721.23093-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613000721.23093-1-21cnbao@gmail.com>
References: <20240613000721.23093-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The folio_test_anon(folio)==false case within do_swap_page() has been
relocated to folio_add_new_anon_rmap(). Additionally, two other callers
consistently pass anonymous folios.

stack 1:
remove_migration_pmd
   -> folio_add_anon_rmap_pmd
     -> __folio_add_anon_rmap

stack 2:
__split_huge_pmd_locked
   -> folio_add_anon_rmap_ptes
      -> __folio_add_anon_rmap

__folio_add_anon_rmap() only needs to handle the cases
folio_test_anon(folio)==true now.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/rmap.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e612d999811a..e84c706c8241 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1299,21 +1299,10 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
 
-	if (unlikely(!folio_test_anon(folio))) {
-		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
-		/*
-		 * For a PTE-mapped large folio, we only know that the single
-		 * PTE is exclusive. Further, __folio_set_anon() might not get
-		 * folio->index right when not given the address of the head
-		 * page.
-		 */
-		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
-				 level != RMAP_LEVEL_PMD, folio);
-		__folio_set_anon(folio, vma, address,
-				 !!(flags & RMAP_EXCLUSIVE));
-	} else if (likely(!folio_test_ksm(folio))) {
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
+	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
-	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
-- 
2.34.1


