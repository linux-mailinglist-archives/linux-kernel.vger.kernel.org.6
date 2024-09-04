Return-Path: <linux-kernel+bounces-314576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AC96B551
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB176B297A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E21D016A;
	Wed,  4 Sep 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PxaWHlwc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F91CE710
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439325; cv=none; b=eGsHFPSvqQbdixKRzCJz5cu50H+va9aVdJSnJUo922yFcxZaZ76mUca+MlaFe2ZD8Q6mYb1qu5J9CdKEnzKTum+ENgC64GLD5VXzZD439O/py/0REwlv5d2GFJIl7PR0n0IQ545MdbVvwm10IfIdxzNkRbS0+iGFIk8PuQvdhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439325; c=relaxed/simple;
	bh=My0ULxrplZDhPoFxWfT7wAiiLVrqrf3pw9vNGA5BsnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acrqVUWYEuvFTqjw0zGVk+No5BxlPzaTN0wfypY4cFhcsFURh/D4PTOLsapthSlMPurRVthQP8uAMo1ouhSEzigQHszXPimbc0G1b7ZNcR9O2dhsKBarSvgLar1lT99HNWEsuW+in6zp5UijqD/h6b9CyFmWSoM+Zqvj1giB59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PxaWHlwc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd830e0711so369084a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439323; x=1726044123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4jsyz9eZnVjuIeNrv9jm5llMD04VewCinfUm/XXhZs=;
        b=PxaWHlwcQMfnGVtS0De19fRNHa77B+kN35uTq9FgFz51Ml5DgmmfN6g2Sv2eTwOdU/
         aVeIHP6JaulxMTFkeby8oxSRtMWwQhn4rt7oLZVPla877uYE+lVMaEqO3P1l9CjosthR
         DnKwTbJ8YDuDkIgtyWbWeGNdwWqlSZ/wrMENCOamHQ1mAdAysg/+no1VmgyrrcTXmycu
         qrd1EQRll7rspN0fmaAReA0qJXk2FbqJ9MZAqsiKjsaBv5uVFmgrVKnTNUZrCydUh2Lv
         qY399+DopwYaoEkY0B38oILYqVhvUub9vn5OOX6rDxsXVdeQKQGSNJab/H21Mh0NaPiv
         OTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439323; x=1726044123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4jsyz9eZnVjuIeNrv9jm5llMD04VewCinfUm/XXhZs=;
        b=oQP+qMiYJYPc+3o/IYtMucb1U5kG6DG4HcAC+Oxyftcq8wUSQlhm7fP8cfjkicoaAH
         PkD9ik5qmXm0fHRC+Q3MT4kqczk/rcacuV3sirV+F0WEsBU10eZgMhM009zEe2TswBnr
         P73cb4+gbzp+ex9a/++d4TQ2Z0ifnCofLtF/CpHwmOOS3p3x+DCykaVi8y8fjtV8iJlL
         GtyhHyquQldIoGNrjmiZbogkIyNgLxlrC56qbKTBYBmEf8EQctK+oqsso3Cul9/C0ZQ4
         NS4mqM80zeUeWySlSV3eaeJwX6vA3Dx3ilrS0Iy+kTmcyY4nwSXOqZOCdL0ZHZfZwWXC
         SPnA==
X-Gm-Message-State: AOJu0YxbZRkMMlEn+WJxTyFpzBlrur8bW1lpiR5YbhyVTOFo/Lg4ifet
	AuknFX1rsLsqi4Fj65ztn1J+H2xasZl+A1tSn6qP7qJENkHm8Wck8lx2w2BnTME=
X-Google-Smtp-Source: AGHT+IGXU/qy5PPe2L4ehUmGkYFpO+LVdbh/09mdfTo5RpVJKjaH3T6TEVRYBI0feUcEJkjAodGgeA==
X-Received: by 2002:a17:902:e545:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-206b8341fdfmr24676655ad.15.1725439323059;
        Wed, 04 Sep 2024 01:42:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:42:02 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 12/14] mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:20 +0800
Message-Id: <20240904084022.32728-13-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_pte_range(), we may modify the pte entry after holding the ptl, so
convert it to using pte_offset_map_rw_nolock(). At this time, the
pte_same() check is not performed after the ptl held, so we should get
pmdval and do pmd_same() check to ensure the stability of pmd entry.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9b6a8196f958..36b84e46cd7b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3375,8 +3375,10 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
+	pmd_t pmdval;
 
-	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	pte = pte_offset_map_rw_nolock(args->mm, pmd, start & PMD_MASK, &pmdval,
+				       &ptl);
 	if (!pte)
 		return false;
 	if (!spin_trylock(ptl)) {
@@ -3384,6 +3386,11 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		return false;
 	}
 
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		pte_unmap_unlock(pte, ptl);
+		return false;
+	}
+
 	arch_enter_lazy_mmu_mode();
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
-- 
2.20.1


