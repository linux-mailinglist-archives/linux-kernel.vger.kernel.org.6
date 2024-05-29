Return-Path: <linux-kernel+bounces-193746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215708D316D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B728D0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDB169AD3;
	Wed, 29 May 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxhtbDgs"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0C169AC5
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971348; cv=none; b=WimsUjsfhrs3rCx78I0C1UkdvPDZceVeN/z5hfxaqJcxVCXDIQsukZdDro0/2P1sCGPH1czIf7Kf2cOG3WXnWEgRzwPeGmW08oG19OTjzI/vwtKstnRRTbRhNnLx23uToqa0vUbgz3U2ZhbfYxWJc/QMznzS92c7U95e8PmM10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971348; c=relaxed/simple;
	bh=W/pul8blKRhwRpm/56/qpb8smBFPTGG2O3j7CEDrGuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxOs+MlBLWI6Hj8VdZRkqT4UPqEoV1Vk2agwr7xuZH5pU1SXXNbhTUtEwc3k1x7UAPw0V7rDP2CAAssrjPtyvgSEE8oEy3YONUS4zwuv1JwIdpuvoIinWdlDEabj+fvevu/c+5/uYqyoYado0k8YE550Z56A1H7eREOyLWhHOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxhtbDgs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8e9878514so1349274b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971346; x=1717576146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83K8bgM725IDCOF3GoIeML6r90yg5uTNSjeWCxUl1nI=;
        b=LxhtbDgs1z6g5170ukJj+5en/otb5UQRPtjt4GaAGlsj4xETJzvySnpRfHPcIs0a3v
         62Nr7ltm/Ikc2YhL9m6+mup715JqpqN3q0zb/prSj0voil9bjmhRBVtMRvye25JecmBu
         KABQmoORuGGspHzFSei+EvxUvNedA0bteh/zsThiu06FJQqks/VCLcpbkSc+HNiXYxLG
         8ocm4GBMcnj2WnMc3Qm4Mz8SLlwzyxbg4JazM2ajBythT6JCWvbB+Ejw2JgCEzZAodI2
         XXcvtfkP+oRJuf48/r3q+VLdRxBG66IB+j8KBmIxK/serwt9uLhw9F/uNVAsINCJO5lk
         IGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971346; x=1717576146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83K8bgM725IDCOF3GoIeML6r90yg5uTNSjeWCxUl1nI=;
        b=qbCkrpERsVJYaaj8u7aMY2CBNLOOn7FQnuANv4Ui28KIWxSbvWa6CYoaUO9hTqFw0Y
         DkSfoR4eKAPGLQUE6e8uR05ovetPPS2c+6/a8M3fYncRA0q1wiQZm4h8vgpYeRJ74NNg
         O9odwhiygmK9RdeNoXb4N3s3KBNaI502iUAKs0C5RDnd7TMqT1JrJA3P/xIHvmWzFIDz
         eVVIBRffKb6LsuqUp4drUtjS5LT8XjZMivO73aZ53+lf9bhehzLuCbd1n4cFSdbUni/D
         CG1yajCl+Exd4IWfnnEXWrXSROUMxxqwcklmUv8pXRHCBQhcrH4IjL+8Zi17znOzRmCe
         nXig==
X-Forwarded-Encrypted: i=1; AJvYcCXJc2GWKsYENzrOn74bmVxppqOIyYyO5dfv5xR0OGXgr3jnYLzhRbT77sCFn+rIbEesU/JDwpMEngbPzWvhrGZ1aKrYpbdzdIkEE7EC
X-Gm-Message-State: AOJu0Yy2n9NE3RgrBs6lTQ8HfU+O3IJKSx3nRW+j2EB5e7DUcgUGkvsy
	KeWClMSEDUOUUiJ9HepBb8/qkPuXsJ3zXTgy93SSqrmaTXPkJpn3
X-Google-Smtp-Source: AGHT+IGUylP38UecAp4ow7R28ofXyse8WlZ1y+8tflbwIT3kfaBZJA8cTz9JYhcDnvYjYa19Kqiapg==
X-Received: by 2002:a05:6a00:4390:b0:6ea:d794:ccee with SMTP id d2e1a72fcca58-6f8f38010e9mr17376300b3a.17.1716971346524;
        Wed, 29 May 2024 01:29:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:29:05 -0700 (PDT)
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
Subject: [PATCH v5 3/6] mm: introduce pte_move_swp_offset() helper which can move offset bidirectionally
Date: Wed, 29 May 2024 20:28:21 +1200
Message-Id: <20240529082824.150954-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
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
index bbec99cc9d9d..3419c329b3bc 100644
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


