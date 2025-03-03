Return-Path: <linux-kernel+bounces-540880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1AA4B60F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D98F3B00F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD21DC075;
	Mon,  3 Mar 2025 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OkGqLc+y"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1B19CD07
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968715; cv=none; b=l7S8UYUnz0f1RAi40k6Nkhv/QeBI92ZP1CrPW/COqnEyFxPHYSon/UvrPad8fNcEP+PzDDaYEGMfzgUD4uJBIWBz2tIaOkI95B60xkTxtPS01dhvavqHS4SlZTEBAiS8YaH8lSd2hexNJsY/Ig0gH2+DGQwr8SNMsY09GjwRYtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968715; c=relaxed/simple;
	bh=09Qa7iY/cz/uCJcBw8zuCyFMVwvRxKAO3reUrH0m5QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP1ZqEVSENULJNLJieU9mYfynZzKKnVKW1t3GTY5qLZIbG/GFcPlYZS2WX6EZ0iDUcxSdE5wvRxeg6c/tkeP4RTy/Ds9SPN24IC4e4UNRAaWrXHPKLFDNJ2tveQsvzJSOIrGAPDzoumIW5we0M95/aSC+iTZlADjlkEoec/euwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OkGqLc+y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so70240735ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968713; x=1741573513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo+gLdw4ALzCaj1nm0+nyzWVeAdZV8iG/qfb0LErfSY=;
        b=OkGqLc+yiPHADt6hm56o5YtZvjdbBg1w5rAiBhJezzpAnMc+9cOZysd4qrFOqN/7bA
         KD5O9yhNRg8m1BDhs1wJbI34pUos/dDacSQ5ptjHR0dOD7VvMbOQmg6qkf46hdB5EeIK
         Mj7zzJvx4bkX62fyjPZ9it+QLfpz2QJa4N+rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968713; x=1741573513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo+gLdw4ALzCaj1nm0+nyzWVeAdZV8iG/qfb0LErfSY=;
        b=KGIX5MLP+ZojdB4IaToWTBJCulvJ0riXZSjtjvn+t8i491YwO6aM4c2pfPa/jLuL/U
         d94tS464IdcSkMUKrF6s55n/YFaW2IcKbeD+nAJGIlIYBVMAsfDJXVuqM1rYYRVHrIpo
         ZSFglX35MIWOf8SKPxoDSvfDN87vAwGdzLbaMa/KqqZcAjoyRM06vsVBBHLBmMPMSeLb
         Qoj/GcjMhfhhUKNwsRSs2Gf201bc1fl17BFTmgPr9FM18jayrpDeWWEIwi+tC0y+4TuJ
         h37vEyT9bPav7LTUPcWVTij/S7MlbtHsFM0aSjZOZ9fsJwjCtEK3h9fAF2uSe5s0qPu7
         o12Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOKN4woNznw3h50ZJi8YX+CVviYrfrdAVWP8as1/jd14CXSQW0rBgU6jh4OwlvsWWW4OpZF53Cg0hLlQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N3JR53Dss0KZlvNULnc2QIehoGkyQfgM85NL0q3vv4hXi4Qx
	yMuqHmFVYeErwl/z5gosrxZoEa0+qkm+H1u7KpCtxEH6AWRxomMDoGtzVa8QDg==
X-Gm-Gg: ASbGnct+/4Jk/li37X09+obSrUn98nfV5EG0ie4j13W7PD38/zPp+9q2Sufbg8wQ9pP
	IFeoYUCDE6nNuxCatyxfo8/Sl4MQlbey1fFalxN6aQkerNrS/J73ztxwpWtsq7g0Ne3eXXlW987
	VfL+riqIczAwMPaGffTZEjcpjbOyLL9ZCXlYONnq9QYqumNmzLcX2it3fe2lMHs4YSi5hc44clL
	OkkK86tVftA+X7ppQwJQgpTeYE5m24Y5+sYr3Gj5O1RVwe2d8yNvOSFL2mMTGWcDYAHbLslEAc8
	QhtCCiDI5Cail4jEp9p0dUcGfpGl3utKe3UMih32gWUAUEA=
X-Google-Smtp-Source: AGHT+IFnUy2t+MQbv/ON6Qzd6lspOJ7em303a/vGQ6h5MRjg7inxZUPbfNYd5XTa2AnmAT9Ovl5HQw==
X-Received: by 2002:a17:903:1983:b0:223:5ada:891e with SMTP id d9443c01a7336-22368f6a1d9mr130419345ad.7.1740968713338;
        Sun, 02 Mar 2025 18:25:13 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73638e4ab93sm3434904b3a.103.2025.03.02.18.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:13 -0800 (PST)
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
Subject: [PATCH v10 08/19] zram: limit max recompress prio to num_active_comps
Date: Mon,  3 Mar 2025 11:03:17 +0900
Message-ID: <20250303022425.285971-9-senozhatsky@chromium.org>
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

Use the actual number of algorithms zram was configure with
instead of theoretical limit of ZRAM_MAX_COMPS.

Also make sure that min prio is not above max prio.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fc9321af3ef4..776c31606eec 100644
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
2.48.1.711.g2feabab25a-goog


