Return-Path: <linux-kernel+bounces-575915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3841A708DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9CB3A8549
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8323264639;
	Tue, 25 Mar 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gozP6g5o"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C125D539
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926433; cv=none; b=JfamYi3RGVhaXpJYcqA47b5RQ7uUF7fo5hMAozCv11IoDEdC2XMnNO0fCGbPmniPGqM5YWicecVzaGLTVYs8QtN4tYgBHzKHxupptke5vWO8J8cuRsxtt3XUHoRMOaCYVOcdSLwkQigItaA6yF04R8r8zFlFmfjnE4jT5Z2VEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926433; c=relaxed/simple;
	bh=XxtWMx0h1GhRC9rVG9N9EbyJKBhgPaq2ZF+sOEoDNc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkWAA+BFduJeOlFLWY//9QJlJBq7mVE61n70FtjKuH2VaxqMbIrWa0zyziHyjr6i06Ti3izaZ4+KW2SZR6I6r7RoBD96DajCDyPeW8aZy5wfliDDjBbIkRJiioK+LG5UJ6YSlI68v29gD8oZPO5dHPOkNQF2Qbb3fI0BmbNrwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gozP6g5o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224341bbc1dso116781165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742926431; x=1743531231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b04qA0GdayEuJfPnsgjb/2GOHnZ8+3OdmWsTaT4XyZI=;
        b=gozP6g5o1ktPMW9soDMX8eR495xYSYCJJ++RIuOSz8hiaG/c0QO2nm9qib7vyI0dsR
         Yp+XzXhkp+ubTKBHnTKReZXDPVJQi0ThgtU2vxeHtjqpulfVGL/ig4c5WJGBfde5watK
         RKp1HKnxiCuKtMew4lZ/NSkRZup55gKgQHLg9PldVJ6TmUbZO/LQ2ec8krs7QyvGFKzH
         sXmf5N+GnEkEAqg37vMHpz7yJqcq6AvnYADsqLU3D9/XYiZB0eYcWzJYLW2IZGs+jMZ1
         H5tw0ltpNplxI49WDDMnq74yH/ZtfdjbtnXHF/0+KN+O9OwXE24/018ECJvYNWM3kpGF
         BhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926431; x=1743531231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b04qA0GdayEuJfPnsgjb/2GOHnZ8+3OdmWsTaT4XyZI=;
        b=uGUTx9z1rW9Fp1Ze72nngmiue0NjZrgFXFuSR1r1LNaRK6yDtvFRC1DaMeWgUqInAR
         8RqUN3KMuHDKG2nlytrZwFwlwcgpmu4u8Oc9NQOhi32O/d+NNisXCXAgDqmJzrWEU4Hr
         heFULEV7xybZEyWTtQF55cddq7mLJqNLQ2wVGuKh6XYr4D1XX2mip9c+zCp2PAWT4ceo
         WygbIux6ElT+GKKeWMmUmMot920lpjv31o4Cm6HJxWj/zSVnK10liFZJ4SzxwcFznd/g
         f/rdssBQSVxzew/yx08Glmp+EGxmHu/+g5BsTJoXtPGh/8j0PgrO3mhhuc3o9LcZYpIZ
         jmFg==
X-Forwarded-Encrypted: i=1; AJvYcCURXZOQxCkrUBxJlRY1V7qO9dm8LsSSEq1zqpX1f6n+swt5Lha4qKz3l4DcjXIxItCY1cUyFJlaTeNKxJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6IH53APzq5c/LhAjdCh+t9dQqUvL9OCbhoA1Buira2pSrfmP
	w7xAUa9hjxZte5SU0scQ7mTc73zZCf6WMWiEl1qJmwd1rhJttIQQB00v7Gfwdg4=
X-Gm-Gg: ASbGnct3YFkDiNmfp1bNcc2jE3KhQuUvMk83AXoQJkVXnnQVTlxKHhvsBct+QcYTs9l
	HhN6nfrJ+UpBcAg02uX/UUuYQ0LQ1vPMRuTqk82FZtvEGXGYX1cI4gI2mCEYL1007hZcbSsOQZm
	6qobfKBUg4C5f6ik3v920/7YVN1Kops/Rg8oYiJFdZv5hR3yVs1Vg4kGjcOnBqJMzAFJA1aM14e
	K48M2EsyK0GKOzfA6iKdYfD2eVy96fBUY/qaF2pVp5a3C+yTEGrJ9DmJUcJ3NUoY3MV0ep3dgVr
	+YS0FH3xE3dCEOzZfLFMCQ6QwtJDCmVjkji1lfOJzmYT+jrncYyV+FZmLaZacs+i6ZRN
X-Google-Smtp-Source: AGHT+IETg6UWjYAW1cvV0jl/eHwPvtciDvRsHD5PIKJOwjY3xsvgNsLH2AEJ6jLjjZAe/XENdPKjpg==
X-Received: by 2002:a17:902:fc4b:b0:226:38ff:1d6a with SMTP id d9443c01a7336-22780c68a1amr288023785ad.7.1742926430950;
        Tue, 25 Mar 2025 11:13:50 -0700 (PDT)
Received: from localhost.localdomain ([223.185.31.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2bcdsm93588755ad.119.2025.03.25.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:13:50 -0700 (PDT)
From: SoumishDas <soumish.das@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SoumishDas <soumish.das@gmail.com>
Subject: [PATCH] Subject: [PATCH] mm: Add kernel-doc comment for free_pgd_range()
Date: Tue, 25 Mar 2025 23:43:25 +0530
Message-Id: <20250325181325.5774-1-soumish.das@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide kernel-doc for free_pgd_range() so it's easier to
understand what the function does and how it is used.

Signed-off-by: SoumishDas <soumish.das@gmail.com>
---
 mm/memory.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4f6d9766a046..6b8f8692a97f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -294,8 +294,17 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 	p4d_free_tlb(tlb, p4d, start);
 }
 
-/*
- * This function frees user-level page tables of a process.
+/**
+ * free_pgd_range - Unmap and free page tables in the range
+ * @tlb: the mmu_gather containing pending TLB flush info
+ * @addr: virtual address start
+ * @end: virtual address end
+ * @floor: lowest address boundary
+ * @ceiling: highest address boundary
+ *
+ * This function tears down all user-level page tables in the
+ * specified virtual address range [@addr..@end). It is part of
+ * the memory unmap flow.
  */
 void free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
-- 
2.34.1


