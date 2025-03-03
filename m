Return-Path: <linux-kernel+bounces-540875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C027AA4B60A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92F116BFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522218A6C4;
	Mon,  3 Mar 2025 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RB6R/qRL"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A97198E76
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968692; cv=none; b=PECrNFc8yXanOb4OVe00E3GcSL5XpegBdamBb8m2YgmKBWQgKcqtf2fkfhGgf+Yh7Dt1RkKr8lmgpjRNpGPILfmMFNxdakMIrYdsf0FOKqPLF1fstsHItkGlsiR8AAoBZM/1wrh6r+HsKb32BUBipsbpyH8eWPdYDV4jTmEcMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968692; c=relaxed/simple;
	bh=6cNSwFN+g9dAhAE6jUN8x7pSCR8FfvK/1Zq7Fjm30rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f40UZvPq+CsyTm9NoRWy3ty0RoY+VMdXs8fp4rsg/ZL7GdmQZHQ9VRgbRI8bH0W83y+dv1L5WHvzXNc3uFsBKa40m3b+Cghpzkm4vdJ7U03QSd4hKjHMpxlG9oPm53usmiqRsybZ28FQ2WPncoaJY+GMcpjsvzum5TZ9GKK112k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RB6R/qRL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234e5347e2so76906755ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968690; x=1741573490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZsh5cPaFoEDPyEJH9aQiY1L0urDRF/CUPRrOejpG5k=;
        b=RB6R/qRL5oT6d4GQQvuMi13rGEfhO0u7EebOnwVxoDPxHZiVetiDPY2Rn3P7sK3ydQ
         uGfjWPFB6JIJOAoBkInoj2BogxvunzfEt/hBtzbARJarpLbSDoiQoM23uLOAJ49dmenT
         dX+p1qj+uqITJ5A7kQ0hOL1RsDZHg/WqG9+cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968690; x=1741573490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZsh5cPaFoEDPyEJH9aQiY1L0urDRF/CUPRrOejpG5k=;
        b=l4oNt9Tn5NznV1UOUGgwIKWJ5efC3mOI1zJ10eQPCm9EL3xSMk4jBEDjDU0JbR2glW
         ck+f7AsQZ65Z4Pyw415F4xVEgOW+7LSK1A+QbHMOYRTbaPOUnDOoMHkf416qhWycgGNu
         XXOIysi80Bg6VDeyt8ZfqYQaelJIdh32vXpQf7ewjOXdWFMRgeEMIg8eiyS40spCCBhy
         qAG23uaVd108qO5n9xqFd3ikGP/2UiNLy3MQU+222FBTlfRmeGrHaZrUtM9sJWZG9QmN
         MNesXKE+L7c+5g34J0pYUQ0lwPUso1UbEfxK8D6C7DboDTHCEWXp5YVJKmcIMH6XhxJS
         wEQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1yxTt6b00tcvgwE6xW6QnWAWboH8CcqUonMrYrCn+/FNKqEE+JutJmYIuGuhpKImNmyb7MvJ4kK4zhZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5v7wELS6kFZEt2g7Vawq4+EiCtEQYL4ywKH+UoWexOAy/bznJ
	O9GB0cUYwCW82bChtO2ws9a5LlYewaGliDM/OzuVIG7CiMO6D1pzWL2kqLs/gw==
X-Gm-Gg: ASbGncvLou2M2UjSsu66jaZwel6W6zTRbkyox8uuckeg3vdscyjmqR5mwPi06zRAZtm
	fmFo4ADMw1x46ezAZTTw0tA2NH/1lELvICJou3EVUYLuGLcWn5+/uEgdJ3yZUhV2bfzRi1QfNHw
	nGQ/TiMzE5wfchscUTLv1NoxQd581CDDL1exuxbGzucAdw535JS6p5d8sLYFu+2Sy7Q0JEgOLOI
	rD/H/qAoCvAj4t0YQ+Zz9DbLbBrXDCyb5mgbwktigAbVByI7DZdrRijYWY2NMCh3NOfX2V9A32F
	Lw+iDmHLBeucoq0sUd8Jz8wbdIMc0vPYGVaLbr9T+NjMh0k=
X-Google-Smtp-Source: AGHT+IFRsspYWzVXCyDoL5ZFIh1SjDZmc0euiZ+Gem/pRrrBGftzVfrbZvTQsBlZb+pBOhlTra4AuQ==
X-Received: by 2002:a05:6a20:7289:b0:1ee:6ec3:e82e with SMTP id adf61e73a8af0-1f2f4e3cc66mr16110519637.29.1740968689829;
        Sun, 02 Mar 2025 18:24:49 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af221346042sm3142765a12.28.2025.03.02.18.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:24:49 -0800 (PST)
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
Subject: [PATCH v10 03/19] zram: remove unused crypto include
Date: Mon,  3 Mar 2025 11:03:12 +0900
Message-ID: <20250303022425.285971-4-senozhatsky@chromium.org>
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

We stopped using crypto API (for the time being), so remove
its include and replace CRYPTO_MAX_ALG_NAME with a local
define.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 1 -
 drivers/block/zram/zram_drv.c | 4 +++-
 drivers/block/zram/zram_drv.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 53e4c37441be..cfdde2e0748a 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -7,7 +7,6 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/cpuhotplug.h>
-#include <linux/crypto.h>
 #include <linux/vmalloc.h>
 
 #include "zcomp.h"
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dd669d48ae6f..248dab7cc7f4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
+#define ZRAM_MAX_ALGO_NAME_SZ	128
+
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
 /*
@@ -1148,7 +1150,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	size_t sz;
 
 	sz = strlen(buf);
-	if (sz >= CRYPTO_MAX_ALG_NAME)
+	if (sz >= ZRAM_MAX_ALGO_NAME_SZ)
 		return -E2BIG;
 
 	compressor = kstrdup(buf, GFP_KERNEL);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c804f78a7fa8..7c11f9dab335 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -17,7 +17,6 @@
 
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
-#include <linux/crypto.h>
 
 #include "zcomp.h"
 
-- 
2.48.1.711.g2feabab25a-goog


