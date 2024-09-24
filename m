Return-Path: <linux-kernel+bounces-336592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBD983CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CB5282489
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975E7604F;
	Tue, 24 Sep 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g0aycdaP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A857CAC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158304; cv=none; b=pmTooZXMceRU/H/fxCEDXy2+PrMPfRvCeAdgWaLdbnr39GEX4+lTtS+YJ3G097h5nBcrZzNUW03OEDHR7FsnSU1t7r+Mn9aCDaHAihk6iLiPS4iYlNLpArMLSTja5sPiwVgsAD7R8OINtGtb6fGjdrVgWsYx9F1bHzH6W5UhEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158304; c=relaxed/simple;
	bh=JRuw2Pk6LLh+NGlcp79p62JmtEiArxU8q3vnjCYzwiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auOSgUZ9v0zDVtDeDTHa94FrY2dbZIzpn1Jvy5WTzBMJOM4cHM2DS4txA5oGt0i/4xhU2FPBoEg37jrv4+5Jhhgql5sTXwlRESV6z8Z7lVUPxiBr9kRnHxpjaRfFCgZKFW+ly0vmEfYwOrEIZfcqRtNHszX9S5H4mJ9xox4Zc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g0aycdaP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053525bd90so47137605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158303; x=1727763103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwq8DT6JeNdavhckGZI91GgKWXC+kbG6stmMQ1HgBAg=;
        b=g0aycdaPasdgAj12pnyuSOQ9kmY0v9M+VqyrXfM61dFND85zQJ7z1usITUOVNfMO6H
         dphpLXR9Qa7wzqu+d2PcAk3jxDRFX+UPV1iKuPhL06B2LXCQr+1YTCuSMBVVPYoqarXp
         FjWCcyBiyF7Q3gWvwGxTGjjaWiWVyVb5tfiKk7oYY32l9AOhWHBPkQKFIzGwsjfco5bp
         ZDiU6V9d6N+iF1Odc2Ib0zhA8PZ/pGZme4S83rPx5JixJ8ff7t2m81lNY0jNuXrgRrbe
         WmU5k5A2MJPu2YUYoawTtZGa33hPdio6dzi9gFHuL7LfSjmE44tloAwAHyPya/bU6O9R
         eBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158303; x=1727763103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwq8DT6JeNdavhckGZI91GgKWXC+kbG6stmMQ1HgBAg=;
        b=oFsBOl+psjLCqOouRxzqAZhcS9mg2gLDPl9JL0J6X2vriY2Bu+Z7Hzk+E4X3XzEm5x
         iYnPOjaGNRkqKU7TVhSqOVFhPoYwoJJ1AjeRpl3qKydxVt1M2yCZVhZ7E+BpFupuaiMA
         FQ+5w2jvKiZD+IPJ6afuQL2u64amNYgvzUTQ01INLZuwNBN2F2UqCZE4Jp94f/kvyPPI
         46bpkk888CXIxRNFl/GF6TbKMIoH1y1Mf/xnYnnKBgRertHw6h+tN9ONaGPlZvze2qSq
         7L5MR5zdZW+talCo/U5jZ3ORgB0ziB+IIXxVJ+sTBHYhvoCWzPg6R90wDDvszCLz5fyF
         7uiA==
X-Gm-Message-State: AOJu0Ywg3LySRYIEKihOjE0Ic+3NVSspQTWY9106G72h/RP/Z7ZHaAcf
	CmlSWHJT1p+zMmepkEB78K14Q7g5Wqm+lekMyqq/gOkkpazhCmunMRABh7XUYj8=
X-Google-Smtp-Source: AGHT+IFl5AsK8a8BNnydzmhf2ct6wAj0Fi3O6gM7MY+2JS5/M4Off4jZQYnq6Yk2iDK5ETk+W1TbBw==
X-Received: by 2002:a17:902:ec87:b0:206:b915:58e with SMTP id d9443c01a7336-208d83af7b0mr191498925ad.22.1727158302727;
        Mon, 23 Sep 2024 23:11:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:42 -0700 (PDT)
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
Subject: [PATCH v4 12/13] mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:10:04 +0800
Message-Id: <6efef5316d7468d13ed5f344452a0b872481972b.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c745..bdca94e663bc5 100644
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


