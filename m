Return-Path: <linux-kernel+bounces-296779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6119495AF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937E51C22B62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF61170A23;
	Thu, 22 Aug 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IHvPHmCH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE2170A0F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310901; cv=none; b=C8Z8Iq8BWQcNnDTwgDy5aXgWjdhH3Blz4WSINjOmnv6r0SE4WcOMeNx/1jlL7Reff2FoBSUeNVZAIaC3FEiqb3PO2tenRYYE3vFSJYXDrBRG5QIyOclCam8kl25Qz58yuHhliPmWv3ZBFBNaeg8RJ6Q3xesN0CyA29Sahb1CpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310901; c=relaxed/simple;
	bh=CEF/qocup8yjgXxjODGjGheQI4te/SVpQzyunVQ4H4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR9SHBHEIMlGEKsAOYa8mFhPm16/BCJDHfeve7/9ja9OR+GqbX0/DQjsB8aJA5ph6XReRFUJGK1IjIZm1y7zenz8YvLAvG1BvbhJnMnHSe8n3kbdCwamAnqbDZrfiLlzm1/h/mSoOmzjdQcs7puXx6NoTms/fo02rm+cTaZ2zUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IHvPHmCH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20202df1c2fso10661905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310897; x=1724915697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKuz+eT/BjM4oBQXjKjArJ5u0hGAcRe4llal02NX1d4=;
        b=IHvPHmCHofjvo1cTkHEKx6d+vtxEQdhRAsvXkDXSx7fEJWRE35xHshqnndWDXLB9BP
         hawJiw1ragErqss2EM1P94ZJqo+ZsnSgE2b+9Ym1eWDft0+YdegE+oeDbYi58TzMK0cl
         PPv00Izn4u+9mRNyEmB6MzwJxUV8dGUIu6pw4vXTB5QDRrGS3n1yKkSOmBz5la9mcrxG
         3NIgXnC4n9PwmPVrVNuTCoyj2RNUOcj0dwtYl7+3a6wtXdd2I1qrWtnpe8uV+2/eJtiW
         PIPyl7JrSjL/rDiWgTX9flwCN7ZOqjXmrnTi4JKBzhrvybSf9PImHwmdiHAJ3TNCPyHO
         /g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310897; x=1724915697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKuz+eT/BjM4oBQXjKjArJ5u0hGAcRe4llal02NX1d4=;
        b=A0wPNAQnJz8IfXZGudiwJiJ63pRtMqZ7A9WhYPaSYcg38RID8RhaKB3t9aTD/Hpo34
         b14Dswdz8UVIHv8rWeacEFNREFQOKpqpJV6JqXuHcE5OKJMTfxqE6J3a78AZqNo80tMV
         7I2+b0kf2CWFXpVWf/FclUYFLsV6/5jL87HDYV5tS+Sjk6j8vxpERmddAU3yRI4tmWDv
         OsZkTk++SvQ6ritlZa87IzFhRAT9my1bqXI1hWoSou75p9Fbbur2A58V0u/Vw8b5iQpP
         lc+geDfvcoDTsUuXmTunlP097lAPkYphQZTCtQ7qy3QIji5/NBRfrO87f59RWEcaA4nc
         Ki6w==
X-Gm-Message-State: AOJu0Yymlum2v4NthbIL4X5c70J7Plol2qbgsRMxNT5PMXC+qEgvtagp
	MZidHIjni3UeLGDIgJ8GZqYEsCodwWlwAlhGcO1pxUvi60PX/tsbqnEHo9vTo+g=
X-Google-Smtp-Source: AGHT+IF6H0tDfgQqKcPaVFXqnNnvtvkdaP6bepcTCK17Vph5rD33YztktUCyS9gQ0weOULsun7jJQw==
X-Received: by 2002:a17:902:e88d:b0:1ff:43a8:22f2 with SMTP id d9443c01a7336-2037fe188b8mr31159405ad.24.1724310896888;
        Thu, 22 Aug 2024 00:14:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:56 -0700 (PDT)
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
Subject: [PATCH v2 12/14] mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:27 +0800
Message-Id: <0e2980e9a31d3503a5dfb350c04f4ede4d05220e.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_pte_range(), we may modify the pte entry after holding the ptl, so
convert it to using pte_offset_map_rw_nolock(). At this time, the write
lock of mmap_lock is not held, and the pte_same() check is not performed
after the ptl held, so we should get pmdval and do pmd_same() check to
ensure the stability of pmd entry.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5dc96a843466a..89ef1ac8eb1a6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3396,8 +3396,10 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
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
@@ -3405,6 +3407,11 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
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


