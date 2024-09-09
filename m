Return-Path: <linux-kernel+bounces-321159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FCD971556
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9DEB23B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D01B4C23;
	Mon,  9 Sep 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP9Ui+b3"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F61B3B2A;
	Mon,  9 Sep 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877769; cv=none; b=bWgDavHc9oMangpxAatQNV6d6Gg1Sp7F+RSTZTbKUlPZk1hwrYnzoPhqOkkJqZd/T8RCcOHfMc5enjkMpkHywuESMBOc3Ul1pFREC7VpmU9e2mBuztryduXbkxSVF34xyYPMqpFpuTmXC3WDGMhFsMW1YbTdMNZA0JSITR59Ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877769; c=relaxed/simple;
	bh=SXu+KN414hj/lwNJJEVMgjiKQvEk/dkZL54sBGNdtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vjv6V4ddkB8BHcNW/n4nhk2p0wN8v9YAhcThE9F5EVcfMWVwqagF9vN1PxkJ9Xjpj2kcEufbkUsdyPJVw25mYnZBbPYqYbM3DRrL7crijTV/LAsNU0UhQHaKk7v3igHDF0VFtkFYD+1abalOCOTStk9LKDrjXq2j8P+5xI22M2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kP9Ui+b3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso9486835e9.2;
        Mon, 09 Sep 2024 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725877766; x=1726482566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAsp+hsPUDz1Xlxx3Pt4VK/5oi4jWW+27XM18rtoe0s=;
        b=kP9Ui+b3nzlhwCdEz7nH0dd8Xo3NsAJi/v5hXgg0xiH+KlaRhFW02lsOHntYo1R7KA
         mJH3Mh0Fa3AqQX3ml0Hp/tpmqMUJa8MZoXx1N0QIsOs4cBLtTiCi8tecKhpgbygbIaR/
         1SQbwIvoCahfw1tughaPY/NTwPJLQh4f0cRW9onZ0M5DKRq1u8fTAkTvSTZ108Zmfem1
         rLNeyvPfm0+hbVWFqoMUbErtbtyHAEYl9+DwMWWqa/2rUwUWDz9G7EaOQJFAi5KABkz9
         VSwBoxO+L1TeAvC8WGIUbMb4Q5qiKM8rTKzv+RwVMDPzL9npTDLSzbne0x9Fxa+2zb8g
         hAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877766; x=1726482566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAsp+hsPUDz1Xlxx3Pt4VK/5oi4jWW+27XM18rtoe0s=;
        b=Y54LPGN4rO8A/a0zFp76xYYY2De3IbiI1jjxrSjCBWxbPJ4Lsalr8ubrIGuq+EPQcb
         kqjRpE9WHgcSdWdd/MQLEIUHhE+cYE+nIQtqTGbVUvdOgf8BGZ/GricBhVzV4jc9XPvJ
         Bc7b8Bm5U7nJFBJ5xxlQHAMsjsp6Luv079VmuG/BCxOLSDXA9hDAn4TBUbs/LJi9+0rv
         qhkVO05go7Sd0fjt2TiUwiGVv/K0LsTgeQqOT750F4lYL8UBGnYc4LBBJvBmrRuNh9Y2
         0m0vn1pE/Vit4f15RExIrzuDeoFLiffDum4tbAg/TTKL5W8fJjxWBXa5VJsyJJ59qJMJ
         1+MA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxIrQWWJUVaQvsP9BA7bI1pzpBOW1WKYY/ghTDSHqJsY3JZKmRXA6keYVChkAykuRccpun4Izg4i37Eby1/A=@vger.kernel.org, AJvYcCXVVabmxHxVDwmOzt00J3MS3ufzlu6KPTPznRNQG5Z0DjyZx1Q5/qM8GDB/J1Fe1KtxP4WbLLessqS36lvx@vger.kernel.org
X-Gm-Message-State: AOJu0YzrieYTTba3IVk3MyQBSUfVryBElq+M73K1ewjkaP9Rv+35evmu
	OsWXjH/Uf/5bKlKmMQYDWADL/O6okrZDcKSFyFqvxki/CcbM+cb+
X-Google-Smtp-Source: AGHT+IExMTUofqcguf6fDVu6C3XE4WrbFEN09GsrU/tVFwiMhS7OIZzFORoOXK79ZdwkysUEcI/bPg==
X-Received: by 2002:a05:600c:3155:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42c9f8bf258mr75867495e9.0.1725877765782;
        Mon, 09 Sep 2024 03:29:25 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3765sm5677125f8f.74.2024.09.09.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:29:25 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sami Tolvanen <samitolvanen@google.com>,
	Peter Xu <peterx@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] arm/mm: fix typos
Date: Mon,  9 Sep 2024 13:28:51 +0300
Message-ID: <20240909102907.9187-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 arch/arm/mm/kasan_init.c | 2 +-
 arch/arm/mm/pmsa-v7.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f703136..b394b14838c3 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -215,7 +215,7 @@ void __init kasan_init(void)
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 *
-	 * At first we should unmap early shadow (clear_pgds() call bellow).
+	 * At first we should unmap early shadow (clear_pgds() call below).
 	 * However, instrumented code can't execute without shadow memory.
 	 *
 	 * To keep the early shadow memory MMU tables around while setting up
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 59d916ccdf25..4844ae40d4bc 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -434,7 +434,7 @@ void __init pmsav7_setup(void)
 		/*
                  * In case we overwrite RAM region we set earlier in
                  * head-nommu.S (which is cachable) all subsequent
-                 * data access till we setup RAM bellow would be done
+                 * data access till we setup RAM below would be done
                  * with BG region (which is uncachable), thus we need
                  * to clean and invalidate cache.
 		 */
-- 
2.46.0


