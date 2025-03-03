Return-Path: <linux-kernel+bounces-540878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D66A4B60D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051A16BFC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535CA15853B;
	Mon,  3 Mar 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Egd64HHT"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43B1D54E2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968705; cv=none; b=Tw46G/JBOJhayA2eVl+rnXl2jkhlYXd6clYMlyiY1vDokYECGtq8YMmEoYhBuAjOWDUYDKzLZNz7p2KGwCEeEIf5pmsanW9GfozIcKJhqUFufEcnT7TqKmMByhl931t/GmIY3yUylqyYy5ToFerDzW344YRdf49Z34yIGTwXS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968705; c=relaxed/simple;
	bh=QqMqZBwRwdekx8gHdGlvH68RTT3BuwngwE/XH0oXg0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljBU6mnPL9rCjqUASdI8yg/frNCrqDUvMozkT7bVp+jYadG22kIcZy6rOevYb4etfYJLZvb2Bhm0A3hXWZXCH0A79plOumW6hyk/C09knh3lSQmYrk62hXSreYDmN47iWvW78rXQDPrO0mq3XTSnGI7HaYJSVHopNXFBjB2IMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Egd64HHT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so7678500a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968703; x=1741573503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DytrayV9Mjuo6syNe/AR1TRl5JXW87zNZiaeyGLF4cM=;
        b=Egd64HHTq8M1FnwREeLOcxtVUlz0ogONDR1hYS9C3dVsewHbu6hLncvRbTaWETEp9U
         pMvcwF+KaWaZKhrUOiAcikCpBaAleaknwBy04vYDnr7hqYdYX86W7Ox85gyA9hU8NVWV
         l/X6Qf+rEQGHUqN6kEZccv8AdkwPrqOoCLorM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968703; x=1741573503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DytrayV9Mjuo6syNe/AR1TRl5JXW87zNZiaeyGLF4cM=;
        b=OcJoX6+u+INnJ/MxqpodH7fwSCtliCgE0Q+6BGqgj5JeRIoqTJPw+Xd3V1fuEyvCju
         ORDU/tuD0NLQYhCJ+vvsPaNPZG8iawi7rFrrt+oj+z4TVHvtpSzc5uXhFSCKNu0LiIwA
         IIJFjQu18LjPBzt9QXs5Ql/nWcscjFC9VIIfANoMIaL+THXnJ5PNCIH412IMtNwoWp88
         86H2mpNQlnPeZRuK2X4av9u5qbUWs10ZSkleK7WxJOwDPYNKSWGtU4lvc7pMIQF0mNWP
         TJB10p9YZiZFcuhl6wVhpLYNDyyx3uEWP/i3UXKW6a9nAVqxqjFjLCE1MPTnkAJnDyEC
         GwWg==
X-Forwarded-Encrypted: i=1; AJvYcCVpWoocjQUolp/MBBr/95XBGnMI1B76VZWQO9T2Zoq8RHf2lqMJExIl59zATGO2qY2XEw4sW2abxEzy6MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObSKdIOO/e8oJ5WeoSK5XU5KEZm8quoJWWRW9iffrYC5P8S92
	8cnQbn6ZgMihqIjHFszL90j1toIwqybuPCvg3h85Lig48Lpf1STVNpORsJHHXQ==
X-Gm-Gg: ASbGnct+lhb2k0QyyRkrzOR5voEN45wvCa00k8XYothdA7hPQIK1PmsJUoGERyCJbE1
	m3OXMeQjpnDsRkeQNaAraDB3rFLyOtVmv5xCLpZtZrMP4k42Yp1gmy5QbJZE0hkCcOGMR6tmF7s
	tEX3opJgzPUlUf6FxUWjVMENq8S4NcnAmNA8CspLHfuU9FHo5pYeG9VBHzF1jeTYa1VFbqZ4Fx/
	S6voRdqZH2VSaYNe9PxCpqplKlWn8BuYbh7lsanIZiq5LDc2e+z24jTphQTq3hEdsb4Gab3a6Zt
	aVdKZZuybeqhftY7jM4qAMEP5pGPv4v54Zm1+/JHZLZftGk=
X-Google-Smtp-Source: AGHT+IHl5Crctco8Hu+E8EG5MtD0b7+xg8Bu5mtdXcu6UNEW0JPimU6uMCyi2CRbQ02nGaq5KYpYtQ==
X-Received: by 2002:a17:90b:3ec4:b0:2fa:b84:b31f with SMTP id 98e67ed59e1d1-2febabedb6amr16911551a91.25.1740968703617;
        Sun, 02 Mar 2025 18:25:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea676c4dcsm8609448a91.17.2025.03.02.18.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:03 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 06/19] zram: add GFP_NOWARN to incompressible zsmalloc handle allocation
Date: Mon,  3 Mar 2025 11:03:15 +0900
Message-ID: <20250303022425.285971-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We normally use __GFP_NOWARN for zsmalloc handle allocations,
add it to write_incompressible_page() allocation too.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f043f35b17a4..249a936b6aac 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1691,7 +1691,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	 * like we do for compressible pages.
 	 */
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
-			   GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE);
+			   GFP_NOIO | __GFP_NOWARN |
+			   __GFP_HIGHMEM | __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle))
 		return PTR_ERR((void *)handle);
 
-- 
2.48.1.711.g2feabab25a-goog


