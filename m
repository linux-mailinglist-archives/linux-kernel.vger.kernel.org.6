Return-Path: <linux-kernel+bounces-296764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C939195AED1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089AF1C239D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B68165F11;
	Thu, 22 Aug 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hxWbjQo0"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D33165F10
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310859; cv=none; b=Q4phGpmnTJ9WbpQU2ing//m2AZUimrvgBSUYR2rIJ9O/udft8EfdNugpCWO36LUKCQ+Bi1UwcXkiTn4b1axo0tSEQaY0PC4DbSqX8ukZSpzxp1XybYWDEozG9xtBDMiol163L6SPsBlMsYjZEavNlP5evcQyP9rKI7s0ednddHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310859; c=relaxed/simple;
	bh=UCHg2qODrZao5tr4OqATG8KswlV5SkxQ77Nurnm1UwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CF4k0yPAvLJ7d6hMdPruPmeV0ChUlDDLSXuSRZv14D8lfohIR3hArB7S6iW/7HLYOOaUY8NedLfetw2KXdRI8M3eZPWOE6j2tTQadvYe76kPJrRmozptr+KjmLIXjOmYV0SiGL7R5oXxwW8nz2YPGHvYyWNEaoIVF0E6v4GJZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hxWbjQo0; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3dd25b2c3f2so186188b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310857; x=1724915657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toohyZrQNwk2kNUrhQFlaPWHYnggLi3YB3M65Yq8QzA=;
        b=hxWbjQo0YE2V9j1a7iwlLnpHrWGQMTut9q2OYqwMWMlgxX1Mqr33j/9F3E2UOXNEA8
         7fzuC90m77MNgBn7tE1YuwQng47pCktAovnNq6ragMZ8dVQoxutj7EaI7k+OQW4XovM+
         naQ0WcQDr+zImNXGGza6TixfaG80f2mEfy2WQtlbbGVhbJE6GO9mC/vNPATq8pogkkE8
         IW8GbADbqwEknWzXLvDisIcX6XDXoOZf61pGGy7nHej/zk5r4JdI1TC1CRlI/kOr8vMy
         cBW2WC5/2NUUyKeiD130pOxj1r5Sl+X5pKJQhspEDYq8B6HKI1UsINS1WfID02LjaPKJ
         3Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310857; x=1724915657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toohyZrQNwk2kNUrhQFlaPWHYnggLi3YB3M65Yq8QzA=;
        b=AHkxkIwoe9oYZ8uqNWHhu1k5eu/GmeUSFnvSjQhniVRBHF2T40p2YuXcp2CUK7odmO
         tTF7ae/6h/uFVmY1oNqdOyHtSjgBIr1hoUr01FUiYoonB9NkECF9t7DxY1wvnVAoRudU
         MZ3nHCM/SRKvt927x/xGFH6/l6By/0UsI7CUvGmkhSLrbyzwFzUU/b5sSihsEEgz14hG
         NDA1bJvMOtFdBdk/ewfYiGwzCgh53S7gXzu9iBUt+f2eCmBJiU6Xt+T6k6ZuISScA9kC
         BhxlRC4ZiU7FmwKmI37XjethY+Q72fHmtRPnM4o0W4QkbNNPJqHWGL8sxmnzzjip/Zrp
         SqGg==
X-Gm-Message-State: AOJu0YzpmPOj/2UolEmdQkNR/AT3fuSu2fvYJTsp7EH5sL4d+dxjABDi
	6iSggZ78SGWhRDZOwzBzOIWjnyw87DdRvbqpB1XPO7Nk4KJYjQN33dmpSJc80MU=
X-Google-Smtp-Source: AGHT+IGgjighdWtbrKc2Se12Iutexgq8AwJLXy8Rdygo/b6qt6ZS1aEL6K5S14xFU0XlAJpbImifsA==
X-Received: by 2002:a05:6808:179b:b0:3d9:38e2:5392 with SMTP id 5614622812f47-3de195c380emr6158328b6e.36.1724310857179;
        Thu, 22 Aug 2024 00:14:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:16 -0700 (PDT)
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
Subject: [PATCH v2 05/14] mm: khugepaged: __collapse_huge_page_swapin() use pte_offset_map_ro_nolock()
Date: Thu, 22 Aug 2024 15:13:20 +0800
Message-Id: <2b7dceaa12da273c6decf92e3bf2ebc4f4e85ec5.1724310149.git.zhengqi.arch@bytedance.com>
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

In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4a83c40d90538..53bfa7f4b7f82 100644
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


