Return-Path: <linux-kernel+bounces-526749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7FA402AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72711189E629
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78045253F37;
	Fri, 21 Feb 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bF08CdSU"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C921B9DB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177047; cv=none; b=bhGMts7XGcv9M0fwIZzGbT6nAlyom/efduUBULpYjrEO31FskojZ1JLf2xAYyk2mBkzscpMoOipATuWe3P0Z+/DSSi6XuY7dBP5jq8BPn749dVfDVGoNza26+GK41uVmCpcdPsxhI2+VGJGmmfJQQP2CfDK35zyYF7oxKY+WY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177047; c=relaxed/simple;
	bh=LMsWt4V3/4rrChbG6/1Nu2c/yXGHHG1tlJB7jYuftu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFH30FpAQVuOUshtm6d5MlDRDiSHWFawPk3Ghpsiwg/ig+25/gDCDebaBQnGmWZcYhOe5JfwR/RzsZ6QVXe0RR4LUclzRW1pnDVDoLVkzra1yTswL64rvNeYZsk9iLZbkYP0wV0tkDaInY8OVqWW/pmzZjFI/xqQOIKM7S2iviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bF08CdSU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22100006bc8so47871815ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177046; x=1740781846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkJ2PKd3dLF29fHM+CjpZmmQFILFLiIANo+kf0KnLBg=;
        b=bF08CdSUuMCVLwiS5Wj8E/kvJejeMxrFEvGEbpCgsVS3Ey7R4eXDYA/QkzlClJ49x5
         /utkaPHuJaf46xjFP2WABtRon4Odkz6Sk0zo8HUhZMORg6gcq3SdkotnWJdDkqs1Z6Y5
         IlmZ5wyNA41uSRi9vZTY0NiX+AmHgGnB4Z2BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177046; x=1740781846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkJ2PKd3dLF29fHM+CjpZmmQFILFLiIANo+kf0KnLBg=;
        b=gPkxdpAv+7OACPyz8loLpLxwglYFNhucl96ev9dn5uqEVr55IS/eXEvWjr1VcxPszb
         u8O07lHId+FLxzi2Lhw0KA0jQ/DVFkIJazXI0SZ1ZVe1KSRWKoQrk8ckBV+HiqQQWjLZ
         O0lhMSR0sl2xCewbMtWz63T72LbGoeccKgnKyEIuP8fywMiXqtRXj8AkQeebIoqKlrU6
         pB7Ywg/bdwiSPPi/PaRcHcZVjHO0M88yKLkJ6D5TkXXchbAlE/k1klPihmBCZnK/J3bY
         Rt+Rhsgf142A4sRsWAcZyZg2ma7Hb22OHLanrPI0/S4WOwZZcBWwo4bNvaH0CZQ9kfjd
         UpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Srqhrdo967fGJPqp/2RIyBXKawc9uU3I07P/RkH4rAm0sARv26TyOh6iGL8FpjKiYtLNx1HNP2lfXN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XM3IjDO08CMv9Cp5O7Y1E8jTNoysCME+Tno0VEOGRMgdIwig
	zE8ghkw70LBogl95yfFLQOhh0K76Dlj8Hg81sVPY3d6ONWRKsv+M7Ob/ygdGPA==
X-Gm-Gg: ASbGncuJzlPdISYKowdJZ1WJUAOYrveI0AKe5Te5Jx9afE8xGkfaNSVm5/gOM90M4cn
	FwhAcuJPYs/9fSiRtSLk2TlcRh134CNRNltJkoWONn0nIokpyUj0KkjZV7hT2Sry7xM0Vi1Tfkk
	8xTo7efFg8zL8XoQlFw22KTjNnOvmdWG+BpGRMzq6sYHk+mysmHlTMdUCHiiPJ7QMn7P0ZHHqON
	NPNUXRI0szzkWLIp9L/UMXJKo7YBvA58I9wu4Cxt9jOlmQqPkktzNHHKo+YCr4QemJWLMoXVoY4
	Ac53dE9KYwZ8pXzolRd/HDYd8do=
X-Google-Smtp-Source: AGHT+IGqcuXdJ7OX1zr/wKQrluVdfXffpe/y2wZBMPKg94p0xgvFz73ixWr3hQi6scgLb0vWrXTzXA==
X-Received: by 2002:a17:902:f644:b0:216:6769:9eca with SMTP id d9443c01a7336-2219ffddf80mr74177035ad.37.1740177045827;
        Fri, 21 Feb 2025 14:30:45 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55963c0sm140523665ad.251.2025.02.21.14.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:45 -0800 (PST)
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
Subject: [PATCH v8 07/17] zram: limit max recompress prio to num_active_comps
Date: Sat, 22 Feb 2025 07:25:38 +0900
Message-ID: <20250221222958.2225035-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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
index 710b10c6e336..b32b959046af 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2031,16 +2031,19 @@ static ssize_t recompress_store(struct device *dev,
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
@@ -2093,7 +2096,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (prio == ZRAM_PRIMARY_COMP)
 				prio = ZRAM_SECONDARY_COMP;
 
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			prio_max = prio + 1;
 			continue;
 		}
 	}
@@ -2121,7 +2124,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				prio_max = prio + 1;
 				found = true;
 				break;
 			}
@@ -2133,6 +2136,12 @@ static ssize_t recompress_store(struct device *dev,
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
2.48.1.601.g30ceb7b040-goog


