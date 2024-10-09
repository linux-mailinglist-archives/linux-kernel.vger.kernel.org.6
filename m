Return-Path: <linux-kernel+bounces-356256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E70995E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4940A1F24A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489F14D280;
	Wed,  9 Oct 2024 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIG06mp6"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE42AF11
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448163; cv=none; b=U/r+7OsOBPA5RfJetjXJ9++E3OZIfgD334vWM9fRks3lVEFiTm10YxbsWH959Xi7ge8pDLC2E95r2QRm6iHC+TU4r68KEALj6PYDw4R5sZckgHWtnKuPjkeGewmVqx2FAxWNarzUWFOHP89geC1f5l8IO67eR0veZG5wY/zVxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448163; c=relaxed/simple;
	bh=qxXNTHvHvqr9jXccGgcNrtNmIQlgjL5HL0QZan8mVWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSKdeJbkOO9RC/yTGDMbOS9GHLGTyoclGTd8uOXVWq1Eh27MqTou5X6b/a509tXFhXWdToWHTTaKMctIe7YlFZnX2Ad+OMiohXTYoClyjXT5HbKIaV5E+mEX3kALCL4HoEzJLzwQMkjuenPB6upB1N9L7E5o4qtX5qxMRDJ4qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XIG06mp6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e41eabddffso84743b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728448161; x=1729052961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWZw7AhXbhDBfStQPmq8E3zxD/HkUPf5jwXs5bF+46g=;
        b=XIG06mp6LMYEhq5XUl/fdk8Wdb/kT+J+Br1GA0b+4cJRYEDrvmRPG4jfgtTNZPOPfR
         PuNwUL2v1Lgs+35GdpAZkWPI+r2m1ScL8I+DV6Vi5LiH0xnq1Oc8THiv3tf8gAY/4xak
         erJQeQeY0+VnRwXxQigI6UpVgEh6hKQQhKnjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448161; x=1729052961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWZw7AhXbhDBfStQPmq8E3zxD/HkUPf5jwXs5bF+46g=;
        b=mJuCR+qxX09FQ3AOvcaWfxAAvhyzQfZqWW1GQGKa4o+GzvqmxT1svgjGzOiCy6ODdO
         N0jxRHRVoAs1m/9tBezLd8du8/9FynoH7vAfwlkdIHAP5DPs+HGhlYlc1bHJj74qlaR+
         inYGhSJadtYPFoFYpNq/BfMBcE2YZwloLW6rwkl684qU/JXiN9gGk03THiyQj6i2oPGU
         75WHFbZifmTUhUX/VE0IQDjTk6Den5rMUVs++TfxuXXnYY1J/fy2itz3FJZDHyZv+hCt
         yNP1Mu311HLGrJ7K8fK3K5mVA4+S2Hlnz3PWP8Qw+wNse1JeZ5I8qYDq48v/PHr+HEGV
         HLsw==
X-Forwarded-Encrypted: i=1; AJvYcCU65VeApKnA0ZO193uKI9uGFHPFOONFiqqnVEMTMHjvi+qMB3t+ZTME+1c/1gAAjPjODJ+k6qqHbhaREjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0st1tfHar7tBAfs+gR2S0pIejEUOVyXe2zYPegZtFHFxUi2VW
	gFYrOdGWNruQpoOkfkGZOVD109J6CJhDXQosip4MXoo9Cbs/ISyQwODyjbSDig==
X-Google-Smtp-Source: AGHT+IE1Qrvj55JMTIddo7PkgCXNaYtv2VuRtwH2cPuJEwdWiWEUPldurS9fqIK3xX+J3g1SvoQCmA==
X-Received: by 2002:a05:6808:3097:b0:3e3:97ae:7a76 with SMTP id 5614622812f47-3e3e6750786mr966264b6e.41.1728448160923;
        Tue, 08 Oct 2024 21:29:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd3983sm6872764b3a.87.2024.10.08.21.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:29:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: do not open-code comp priority 0
Date: Wed,  9 Oct 2024 13:28:00 +0900
Message-ID: <20241009042908.750260-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cosmetic change: do not open-code compression priority 0,
use ZRAM_PRIMARY_COMP instead.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 263795c4aef7..e6d12e81241d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2285,7 +2285,7 @@ static void zram_destroy_comps(struct zram *zram)
 {
 	u32 prio;
 
-	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		struct zcomp *comp = zram->comps[prio];
 
 		zram->comps[prio] = NULL;
@@ -2357,7 +2357,7 @@ static ssize_t disksize_store(struct device *dev,
 		goto out_unlock;
 	}
 
-	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


