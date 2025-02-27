Return-Path: <linux-kernel+bounces-535570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FECA474AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EB116FA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85D1EDA1D;
	Thu, 27 Feb 2025 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQaONGUm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36F1E835E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631038; cv=none; b=cHSzO12gmPwuJbRTAEkI+9ohZPhILHdwVyANufDRKIJfrsoAyI5b6of0nILStmMZZa28ouMWgdaqAp/9OrC/hcahi0AFSGIRxGIDBPELKZM8EJaTT+sWrEvSGRtYgaoDTNa5ly0vDJLs+7rVRDiBpNyOR3N+M8s+yMaXSHWcslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631038; c=relaxed/simple;
	bh=aJ6ksABudpk9q3gl+Zo4GQpK2nI63HdK4XLwS8BJ9Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST1kxdCwUi4QKPsFfyxrjOLn6fh7IV/nf9rHhbQCTJUApWAIyLN1qSI/I264+BbpCb2lN9VADLbJ1pmt9yD/HX67k+MioioYaPOvKFsjKZDAfKErov4nXrnkAVOoYmFvUBy7Le5HwXoDNwkO/DbHN+iXjCS4D8VR+Hxaje3YrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kQaONGUm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so8033945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631035; x=1741235835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkdYQ64vEruCdUV2Hjk4Cody4qJgi72PfTkPf6ILG94=;
        b=kQaONGUm7lSz9+Cwl9KkTJoxouiKw6SPuNpYCAqSfJrl21v9Goz1E4GEYyzqghcyeC
         210omjmEx+8ISl/vFcCFtVbSNTYFhOXNLI9D123iTwXxdKWAdy3bef98HKuYRvWBNnP3
         tCuB18GI4dYb6KwJxBmvdNAoxmoDcCOBG826k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631035; x=1741235835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkdYQ64vEruCdUV2Hjk4Cody4qJgi72PfTkPf6ILG94=;
        b=q6CIBm6DTvZsZDzjl46H8xFI6uDNrQy7Ny/R2jj3CQ1uj1fHyj+BE+lzUNYkPs7ZjF
         1TEQnGsv5QXWA++ZiYsLpflY4Y0IaqGGjUX1OHPmb/2Js3W/HPvYDwrWuEhfg4E3qTek
         9LdTQhoCfAEeVeoX7by2wIlv4pi44SYEv5LiRzDkz01hTeEumbIHmdt4tg49YJ7u0HfT
         4AqFHJeVigPT2+vpO3viVkNon3Woh6w7NZrlnCb7Ic195YqPx8GI5bFa7CUaNsgxr36S
         0X+KmwJiNyRnDYCuksmUXNuufriMsn5jbig1o0TM2+fFPGZYkTIMOJEkqBWnzatKe8Ir
         QiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX93LA07s0wrHXPcwOa5kmPSh01hW64uP2gmRTHuEJfx1iwMsjg1TiLm0cwSTTprRFswN9hmY5RnECoBPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7mbjGENzOOuVOxaznZL2Z8qO7m06Mgjv/2a3vHRQ6SVXVeiS
	ZBo4n9+skj5TVC3J+Di8snEko2V8qR0NSMlw1Qx64hWnDaMqPIsPL2iRSyU/TA==
X-Gm-Gg: ASbGncvvpaCWQe0WXcSYa8iZwYtSaUG83PVSAEjlQqQ9oQEI4z20oKVhWKDDyDTnLYw
	zSJGFfylcJCZA2GptySQNLA9oX1AagXQqjRT/tBgvBjoRDkWaI9Z6MwCiIjpU683YVduWG8Sn3X
	+vn6qln5lxXr+RDZfDHWvZ7kuUb/o03QyptPV8CXHN17bA/F4ppW77NXi4f7XE5YwS990lSrlCX
	GpZX+i6ZyTwe+l6gfqOR05Plx2ot6ZZohCV6sr+km5Sn4H+XnE+BaCzQbpbm50MMTMpeHGEWrJs
	RMMfCaEB6RGiGsPLX5o8lneYekYt
X-Google-Smtp-Source: AGHT+IG7ihHLtTFv8mxg66ATtd7LlmNyi9F2oOAdH3uY5mBvX7qlHeuZ1UTku6FwKKmo5fi5m1btJw==
X-Received: by 2002:a17:902:f681:b0:220:cd9f:a180 with SMTP id d9443c01a7336-221a11db956mr390915765ad.53.1740631035318;
        Wed, 26 Feb 2025 20:37:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f98a3sm5049295ad.63.2025.02.26.20.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:14 -0800 (PST)
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
Subject: [PATCH v9 08/19] zram: limit max recompress prio to num_active_comps
Date: Thu, 27 Feb 2025 13:35:26 +0900
Message-ID: <20250227043618.88380-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the actual number of algorithms zram was configure with
instead of theoretical limit of ZRAM_MAX_COMPS.

Also make sure that min prio is not above max prio.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6266884de1d0..12b99a557667 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2027,16 +2027,19 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
-	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
+	u32 prio, prio_max;
 	struct page *page;
 	ssize_t ret;
 
+	prio = ZRAM_SECONDARY_COMP;
+	prio_max = zram->num_active_comps;
+
 	args = skip_spaces(buf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
@@ -2089,7 +2092,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (prio == ZRAM_PRIMARY_COMP)
 				prio = ZRAM_SECONDARY_COMP;
 
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			prio_max = prio + 1;
 			continue;
 		}
 	}
@@ -2117,7 +2120,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				prio_max = prio + 1;
 				found = true;
 				break;
 			}
@@ -2129,6 +2132,12 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
+	prio_max = min(prio_max, (u32)zram->num_active_comps);
+	if (prio >= prio_max) {
+		ret = -EINVAL;
+		goto release_init_lock;
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.48.1.658.g4767266eb4-goog


