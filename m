Return-Path: <linux-kernel+bounces-336583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA38983CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B441F23190
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8378281;
	Tue, 24 Sep 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dh9Awln+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00681745
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158255; cv=none; b=QCMCMpdh6fxH50iyjwivlUJT7t6rZfOCfvnBxQMUW/tOyN/mYOG4AKMGrwOSY82R8RA4oCrHeGEWaDCVOQyH0wr/UE/xp5IZI5J6+qwXgH4YJpOKgCec8xVtsjH8d7Bulky5tYGBwrxESMokC67CKPlWYhBD+OWo9Q8CVX7XlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158255; c=relaxed/simple;
	bh=v+8eBabVrYBW01Qi/P2m8jF8QqAnjVEwJS4a+M2dkLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A917jAdFX8am8lKedrIIguj73Xd41TFz16bYGq3LsUqKo3LFSjKexAm9jgB8D2Ojy2nypaSPdXoVgYW+CGUkPBIVY0YUGH0y3+xsLCeWZY/66KGCdVVXgSmEcSAwJIRDIKmRFoyIzhMqdu6T3DFLfvUgrSZ9m0UZfoAB52qdh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dh9Awln+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2059112f0a7so45869405ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158253; x=1727763053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=dh9Awln+ck7frvMR9eFgW6mXcsdG/pPZPRaOL7rTlLPqtZ+Oxf7Yh4fS9/O67h0TVS
         ve5nKopHKACzqzQwyPk4hoRfrwdM1pYmkbKuurEmmWvGA5iDWYkoEq2rYt3uMHMAGkPL
         BWMWPGrw55eGssug2FsoXPkRkfY6LWNyYox+vCVChbE9U0YEQuSR44CTMVqdUTjOjm1N
         +wyr30YIErAGczPKzzuJl8pYPMLBkoxE4IC6LHezqKD7yAuGTIA1/NWvWOxd7HCygaNo
         u1oZivXxSH0sUZ9n+zHgD3OYIQFJQf5ltx/jELDs25ifJXwN+kPomCyJQ9fefWq30AOw
         bfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158253; x=1727763053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=aTV9+QgVGW3ssdiaDHHsh9BEvrjAhXnNMAhrtw/FSMTuNZTKxJNp1i3b91L0zap9fg
         i41xIsUbi+oMuIvEGeJNoMIsiDJjBsbiicWw9uuMIhLegb1ECnmqTfD1C0/y66fgIG+5
         s1iUkELAXsZ9AjQe/gn0Y28VVSUXwv/VNH0jZdlgFueW3D8KwqFkN6b4HvxKYpcPfa89
         nsCVDODaa4sQZhKFpXHLP4sCAqH5lQHCirh76GmxBxKiKbXpxmjAUvOLmqqXDW0X8eTM
         cb0DFWet/GwZBofbrYZkcR+NNLhkyY2b5frphyK7puu3AdM8Pv3W2SmcWgPc8TtRDWqI
         7URA==
X-Gm-Message-State: AOJu0Yy3+PllhZKqWr/bEVsNcN25G8bUERrwEHS0CP3eMiGreVorjcIE
	KsQqeccgG2Cg7WwfRuKYBRzKuntyL1EgFSuu/TGBcD4/+PeSY/H5ig+JA5pn4zs=
X-Google-Smtp-Source: AGHT+IEXIad82sT4qTFz/mgMdJh1108B7x8i2K/1dZJvW9IHButimBDIW5JZoOsyX1eaQQUsC7JSYg==
X-Received: by 2002:a17:902:c94c:b0:205:4a37:b2ac with SMTP id d9443c01a7336-208d83c8698mr211905735ad.34.1727158253643;
        Mon, 23 Sep 2024 23:10:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:53 -0700 (PDT)
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
Subject: [PATCH v4 04/13] mm: khugepaged: __collapse_huge_page_swapin() use pte_offset_map_ro_nolock()
Date: Tue, 24 Sep 2024 14:09:56 +0800
Message-Id: <69e1c4483c2d679d3e2c8446264e5878e5b52a97.1727148662.git.zhengqi.arch@bytedance.com>
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

In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/khugepaged.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff6..6498721d4783a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1011,7 +1011,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			/*
+			 * Here the ptl is only used to check pte_same() in
+			 * do_swap_page(), so readonly version is enough.
+			 */
+			pte = pte_offset_map_ro_nolock(mm, pmd, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
-- 
2.20.1


