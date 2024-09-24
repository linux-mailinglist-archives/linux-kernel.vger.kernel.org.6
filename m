Return-Path: <linux-kernel+bounces-336581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D11983CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249242835A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3C7A724;
	Tue, 24 Sep 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KrGxiqDx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C078297
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158242; cv=none; b=qpv7eFXkJQzDl2FG8uMhviQw4pewpOFBzSpG0WFggrxNm83HNVveUr2nwtyqvuACKnZRgnt6vBvjNmtxAlwfspGjv7kYHd2pQkH8HWxIaE4UOqlDhSV/4SXmPplEwscJaL5wmxqpqkmydEeUsvqDpTBNbr2xSAi88hjwPNjsP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158242; c=relaxed/simple;
	bh=Ks+ctZjoe6oexIKNJorWHsj/FHxBIY1SArqgBxdFKSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpd6/lMR5fVVy+f33yvT+J++t5Aw4SrvbMbkAj5yZGCfOM8cU4xPNIDHHaOFOj//FiI6iUBevlHRIfwACusw5ZrHGMmaV5bXVHrUph1AtVNf+phP9y0eMG+PPWsXUPFJu6+gjKqx3nTMMt3TRUj7pboVh7WsY2Z0HpW57dQb1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KrGxiqDx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20536dcc6e9so32521965ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158240; x=1727763040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=KrGxiqDxpcYfLBHeknxzWyC5sZBD4Q911Ghn+67/XTWosP5ofOWOIwTuMUUrLwHkAr
         ypp50VXraHx8Jp0spCPhvhvrAmX3Z38iw7AgJ3qtqb3XlW7y2AdleoVH9XzlLjCRAXfk
         y2iqtt2fuHaRn3+mBZWgPvftzaUfvNcJnk2mSSrAJ0wpy9ILSrbnkVoW0chKQ9lCW9TM
         dMS9tcL9NgtVL/c7gtnkaeUHL+VgFGYsRJRxRaQQg4CFN27NbgMUe+A/jxeTmouPoFhr
         K9R1xHFMOMAhuhz1oTaIEeX7UD0GxmLFdrdJLrdMSlWEvCTtFp9Cd5pF+wKXlHItNty9
         WC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158240; x=1727763040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WBwKEY9MWquOlo01BPdpzLz4TZdRIsQgPATlcDwMyk=;
        b=MVxDCZjFNAdnlsmO3m12Po/6dYgAoyMZTKEkCCtWuLYlcRV1/g9MmNz5KiK/TZdDM3
         4MVBciQ8smbxyCrpaRPGwb4DMxQU7+efNamHu6FdVWkJ1JYHFDVnxFWA2fwEeZfd9MVq
         0b/TStGJBDMNN7QxUQxbnBQUzGcqAGwjnjDCl/3vfLc151sPA9GBjQvntwrthkbjqpaL
         gxFzMcPJ7waosU/s9rRlaZU5FBNpqGec1v8hVZsIKF9Oqu7sYaiAwWnl3M9TrO5Fikgl
         w1+ZBaR6rgwDjvFdpOQ21rkinuRl5hC0B+l9tPsd6uf7VF+hsbLJU+USAcX7CTgjNhJJ
         0uMw==
X-Gm-Message-State: AOJu0YwBexzQ6Ipzrl5Rt99WAEojww2jOBO6H/aKjk5vaTJJ9DxyDahD
	sJYBRSx0YHLRwpPUHRwFZi74n3wLx5UFGelcnMqidAELbvepJcbwHHMlgMOFaV/zwH12qKRx4uk
	Ewkg=
X-Google-Smtp-Source: AGHT+IElcy6/dcdtPcpdDMoiIIDu5/E2AQfQDwpdj/dfRLSSVL2tlA+KvKWV7BmaFFYnOD/6ZCb7Sg==
X-Received: by 2002:a17:903:2311:b0:206:a935:2f8 with SMTP id d9443c01a7336-208d832a910mr203885105ad.2.1727158240521;
        Mon, 23 Sep 2024 23:10:40 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:40 -0700 (PDT)
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
Subject: [PATCH v4 02/13] powerpc: assert_pte_locked() use pte_offset_map_ro_nolock()
Date: Tue, 24 Sep 2024 14:09:54 +0800
Message-Id: <597a93841525dbd58fbebcfdc547f2080694835b.1727148662.git.zhengqi.arch@bytedance.com>
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

In assert_pte_locked(), we just get the ptl and assert if it was already
held, so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 arch/powerpc/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396e452d8..61df5aed79894 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -398,7 +398,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	 */
 	if (pmd_none(*pmd))
 		return;
-	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
 	pte_unmap(pte);
-- 
2.20.1


