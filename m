Return-Path: <linux-kernel+bounces-173906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA88C076E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6592843EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5D288AE;
	Wed,  8 May 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZx4xXMB"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61444500F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208127; cv=none; b=h1VgJSjqFvgF9DcCqet1tfxcovbq7aT/huaGRKDQgOXXz1Fer1VB/M6+qgmmupP4h3j0ydTg0UCqvFAhFIg246spBk7NBEy9cVsnvN6ZFHvJMopnIHqHillMNtE3PbmScoFkRXljshfsneBYUKd8pu5HmRdedQCjA5fxSyWAXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208127; c=relaxed/simple;
	bh=oNACM1lFXAcyx4Hd2MDWCE00/3JOUNQ8ObZMpTgnYRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0UgRPrXPxNTICIfvwMfuIHkwou+fiEOXKoRSiRPB62Bz8iRNUZBzTxeqiAX4R32XR5VCmIyGV4PiTVCOs0PPSDAJRP+D+RP9NqZ15fjIejOI2duLEKDbS1FL9+uX0iDfo6/N1AJ0KDCAyuwLVpwwRi3n/81ORWvRU2h4blrgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZx4xXMB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so220808a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208125; x=1715812925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYGLEQ5dG8GZxiWnoQtIB+ho0dBRJLc2akdsz5aCuO8=;
        b=WZx4xXMB9w6B1ICK5rlxEXgmoexuZ/uSOlV/trqrOgaK04mni8sIei96ej2vgWEP97
         E2za1hOidU0ExvnLrUFUyeOZ/eyHVAtLONZEyRuGceQK3Wwo/9DmclY8q8TXvdBvFqzV
         ymJn16Pc2zXQGzAUu6KILqVcQWxIydw6+cntef+JMr+lQq+uTxe1NCcDs/Q6i7I6dSgP
         tVRkLpKJv2yDebXRzdVpF1zT6OjbxGyeTxf+Zia4OhnLa2Nzu8WtS2Luw2SRLP1H5K1X
         vCDreMPKBN3TFr0393L8YC4aa/NGBxnO0hzeTUvm92kD3vOKK6+vi0HQYQjpTeLAb77b
         GQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208125; x=1715812925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYGLEQ5dG8GZxiWnoQtIB+ho0dBRJLc2akdsz5aCuO8=;
        b=u8Ki7fgTsYqUBr4Ap6bMaeU6DiB9vW4dmNk9+0DwbTsG0WnJsyzXYonhJ/Sqq8UfKq
         BHWbnmK0Ihfo98HBNsUKeseTlfsm4UMwNGfcnvHGQgcYG/AL2Pe7SiHQSVN63IMnvBhA
         C2HvMHdMNZ/3EaecWPhcI1sDVHmtlbpKgizWf+/QhVa6KKHWmUtrIsRwx49aVSJdGXL6
         W0LT5Na+wYUt9tOKDW7V/poa42o7/31Tl+p8zXiit99VCBTJcn5cbP7H8Rb8aL8iJ+a6
         ECk1dqj+9sg6Nvqwvo2kfoFbRYhDw+m0yBu21YPTJR5QHLo/L9RsOdYxNEX/L2u4Akmo
         yMig==
X-Forwarded-Encrypted: i=1; AJvYcCUHz6wZTsKVkU0+qoNa+pTjhtDobyQmGDdxtefBbYJ9LX1R1CWYmsXQg8DTn47/f0kbvebqeaMfiCoZ8QeXL4IRo6GCn5ACULCQ1cM9
X-Gm-Message-State: AOJu0YwTlHSrcf/PcYOmCV3LGpXXK1aa62NGqazJQb84dCidDalqfCYn
	BtFBWmmU2CuonuUs6HXgqKsqYWao/lwVlxEs3nqmXCurhhN3iFl1
X-Google-Smtp-Source: AGHT+IFAtnVi6xLor2XHGazgK0Nm3nnCaOAaL5JyBksp2vgFvFWPvYOXqRq2Ix3zEh88ZA/XgC19yw==
X-Received: by 2002:a17:90a:db4c:b0:2b4:32be:4442 with SMTP id 98e67ed59e1d1-2b65fa1c4a4mr1504710a91.9.1715208124905;
        Wed, 08 May 2024 15:42:04 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:42:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v4 3/6] mm: introduce pte_move_swp_offset() helper which can move offset bidirectionally
Date: Thu,  9 May 2024 10:40:37 +1200
Message-Id: <20240508224040.190469-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

There could arise a necessity to obtain the first pte_t from a swap
pte_t located in the middle. For instance, this may occur within the
context of do_swap_page(), where a page fault can potentially occur in
any PTE of a large folio. To address this, the following patch introduces
pte_move_swp_offset(), a function capable of bidirectional movement by
a specified delta argument. Consequently, pte_next_swp_offset()
will directly invoke it with delta = 1.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/internal.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..17b0a1824948 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 }
 
 /**
- * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
+ * pte_move_swp_offset - Move the swap entry offset field of a swap pte
+ *	 forward or backward by delta
  * @pte: The initial pte state; is_swap_pte(pte) must be true and
  *	 non_swap_entry() must be false.
+ * @delta: The direction and the offset we are moving; forward if delta
+ *	 is positive; backward if delta is negative
  *
- * Increments the swap offset, while maintaining all other fields, including
+ * Moves the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
  */
-static inline pte_t pte_next_swp_offset(pte_t pte)
+static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
 	swp_entry_t entry = pte_to_swp_entry(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
-						   (swp_offset(entry) + 1)));
+						   (swp_offset(entry) + delta)));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
@@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
 	return new;
 }
 
+
+/**
+ * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
+ * @pte: The initial pte state; is_swap_pte(pte) must be true and
+ *	 non_swap_entry() must be false.
+ *
+ * Increments the swap offset, while maintaining all other fields, including
+ * swap type, and any swp pte bits. The resulting pte is returned.
+ */
+static inline pte_t pte_next_swp_offset(pte_t pte)
+{
+	return pte_move_swp_offset(pte, 1);
+}
+
 /**
  * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
  * @start_ptep: Page table pointer for the first entry.
-- 
2.34.1


