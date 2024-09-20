Return-Path: <linux-kernel+bounces-334299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407097D54E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B681F22B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061A14B972;
	Fri, 20 Sep 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtWyQksf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E2143894
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834838; cv=none; b=KrAEnr+XS9/MeWyczvGm17k5i3LBxjJVVVdxDHjjUQ9aw/FxkR1RZ9U6TV0tGohoPLd0ZnELDTqVP+bYu34xj+127pw2cc/RMZJruMgeEIqeK/zjTRP8aryjsbVfxGvHAMe68yXuP/u/7YTGX2oyGCI0KtTshp3osshRZEwnoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834838; c=relaxed/simple;
	bh=GBuSXc6vX5T2hmGsg5gA3ZVIaKp+Z3zLUYr8b/KLRiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZaNCIm9aNjC0x/QvyFKnDw7zlSIBQvy7aV4Xxzlc7WyhfEOOjqOCQOaUZY/0hZbdAnVYJuqfRmvMUE4L4ssdFoPFNwxNFNqgoZwFmOgwpgSwkaY18WKxlb216CmgP4h8+xPjnhqu85vdVwKH0MVNe6y9xX0QKRqTc3omKz+zqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtWyQksf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7198a7a1c01so1659044b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726834836; x=1727439636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBmgJ3E+zJEFPhajcCAnbmCn511pKS8K43xQBt9qbMc=;
        b=UtWyQksfjLY1sqVh8xwspua0TRjJROkJTeoOXBxXSfsraruLWq9FjjUooMmsRq7WeM
         6rljtqD1nLBfUSxnEDW3IVRQuXutCebSE1t5Gb8PQTG2Znom99txf3lizvq1StAdm00/
         y2Fz0gt2jWa0CVm2GJl9kwqJonfsZlHiii4T/yF0j/8Y1BdC9BcPc64vpAMSZg7x0daL
         9cBQRHdUaFaLx89Oue9kDkMv7n43KwvtyB8D4R24THnfGpccNbP3zCqiMj7aPHs5itNz
         L2b7Srx5pvRIkQvnjpTW/jl0DL6pdRtcMrOvKBmRi8On2TJycTLtF2Edp8+bFLjuIG4p
         x2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726834836; x=1727439636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBmgJ3E+zJEFPhajcCAnbmCn511pKS8K43xQBt9qbMc=;
        b=FYPT2aEm2TeMiA1lWSSud1qQdqNiOO8iaZo47xrxSklE5EdPTFS/yPhW5oXQM+dp2e
         Zz7zcyyrVhmddKEGaJROced0BZPMTBIxQWqfhwnEVSnn2vnIFDZYg8s8EvijdOuBzIQ5
         wF9g/WzpxFnux8rI47Wtl4kxyVo+j87ewOkYre7xD52Ltih4lg4P27XKd8JnF8TLp4UP
         l8zyImjtPnMuvo8ZrnXj0O/QniCGdyj2q352JEhobxIkIK63sRSqmGRHFlwNy4Ydgm/A
         U/48cPLBiJibu4TZl2JLxnGkxrkAYlE7zNAMRWyaXAAVKd0LszE8DZH/ykQgJ5Yiv2lX
         hJUA==
X-Forwarded-Encrypted: i=1; AJvYcCV2QE6f9vrEJsdM7eGf5VCCLgTbf4PpbrzW+7ikhS8w06EgGv54wRHrmqwNaNORrwNoH7r/31X/e4uGHEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDlll6G4MiiWFILlaJr7Ykmf2GxiI8cV21gMm1rhhsElzgR/C
	v0hXzeb2od0zh906E0ZhS19V7xmbGyo1zv6YXkM4MSVeQ/83GeDXF4x4Nw==
X-Google-Smtp-Source: AGHT+IGk1cGR5y1+GjjZv3Z8cfFvB8ZNrHFiohP/FG6vRNw1JdrLfQ1aw74lxhXZDqTOMoWNX8Q1BQ==
X-Received: by 2002:a05:6a21:e8b:b0:1cc:e43e:3a01 with SMTP id adf61e73a8af0-1d30a9be470mr4609792637.33.1726834836430;
        Fri, 20 Sep 2024 05:20:36 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc8310sm9761927b3a.189.2024.09.20.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:20:35 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/page_alloc: Add some detailed comments in can_steal_fallback
Date: Fri, 20 Sep 2024 20:20:30 +0800
Message-Id: <20240920122030.159751-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0aefae4a26b2..8b0634d1728b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1818,6 +1818,13 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	if (order >= pageblock_order)
 		return true;
 
+	/*
+	 * movable pages won't cause permanent fragmentation, so when you alloc small pages,
+	 * you just need to temporarily steal unmovable or reclaimable pages that are closest
+	 * to the request size. After a while, memory compact may occur to form large contiguous
+	 * pages, and the next movable allocation may not need to steal. Unmovable and reclaimable
+	 * allocation need to actually steal pages.
+	 */
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
 		start_mt == MIGRATE_UNMOVABLE ||
-- 
2.34.1


