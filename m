Return-Path: <linux-kernel+bounces-514354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F9A355E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E838F7A2FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A79192B65;
	Fri, 14 Feb 2025 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="balfzeqK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B29188704
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508779; cv=none; b=iBjM1cLG3ssdUL1m2lnflHC5lihGi5XFssRFNZtLrfmLWOvBEYrac6nD/aMRr7T2ZRyZA87AP5larC5vyCOdN+u0hMf/c07071upU/tBYjELBZRhl/mj4xWDZ/ACI2avRqT4n21q8II8mT2KXxlDsQHfIkqD+kkYPlYXvxdNp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508779; c=relaxed/simple;
	bh=o6yg0Rm1JkZpxLVpaNCkKzt7lYA5VMorFqotjBdLMOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6coBTOnxPofD7yudzsdzpv3uIhV/xDaW7m9MEgSVESOFHUom96BdcaDCeogsKrnGr6zMl/R3eIAOAbsii/l1hFM+n2aE9fyoxVcShSALNhYU6puKfahl3iiMg89Njz/ixTssrKkCbyIGra6ixDtPEAF7eB/OD6HP5nj5JJDkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=balfzeqK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f7f1e1194so41043555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508777; x=1740113577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJYj+/a+/IqgLXusoRYSgVepNrwhE22l9CBy17XcMXs=;
        b=balfzeqK/iy8QgMIeJHdbvjJEfrMMPBrmacnt24lAuIrTNIJ5gc3920EwptazJ3q/M
         sHkMeSmgof2y62da/odHp/wr2cjXfwdU7eG+oeicE+yS8IVXrMStfTry/V5CDUuVh/WU
         iHic7JpedPWbw/mU8iFlx4OtPkxSj6dehuiXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508777; x=1740113577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJYj+/a+/IqgLXusoRYSgVepNrwhE22l9CBy17XcMXs=;
        b=Evkk7eFTobXRAZVuWMnp+xIicpwfN7o11By+z9ShOHjhoo69RAxbkYNyPcZem0ZkM/
         pC6esMwM16WDE82oItA/Kz6EM5oUM+ycVagY2ZmXyOPtRz24E+93J9zr6ntuQbfuDLTe
         lR5jQ9aHvuXsg84tTcTVcKgEbkLzE/05gnIutypjaWP3bAF0sMVT+MSu/38veer5JP+V
         ipEdPXorYpEY6GLL18NC2lMTsVEOPB4tG1aiMsImK5M5I7jQc/QAyZf4e1u3fFygQR0g
         q91Ng9qZdNt0Pt11MO1V3dhbY8e7NWQdNrohaZyTMi03OOYfbUBviqoI2PbL5yLKdKRE
         Km2A==
X-Forwarded-Encrypted: i=1; AJvYcCULGj9QOhxLDoeobUvMeatYUS2+NQtXzfBXmKR0/+0qBpTWwgs0RTutXWlh2QBgs5OSMF+WxqnrqjqN4ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv9ftW1xxsstHg2rfaCyrLMLWPP8G0RJuf1l9ryCKU6nxrODG
	BudeDRQVL9HFNqyRd8ETdMAGUawa//2A/l8aI7afIUk7wld4zQgekJ51YCH0Sw==
X-Gm-Gg: ASbGncsx4u1/+kwMtOsL6MBua9Rgczf+LXBzciZIx/3qzcYGF0AHwmEqXK9i8Ft0qvz
	vQfRiA7/eEV2HRh/rnJjXOQrLEeBY5JWB841ztE95h/mCnRov8Ma59yOj+7lZT33FGKQBeS5KI7
	SDx3mtu+JKY62M8FdKIKDDbw6kF3zEi0TWJAOztSkMEfMcWBFoJx3KzTKiptN1tJVT+XZ0YhZnW
	Xm7UeZB7Oh9lufx5O2wVel0KTtMt7J3U1eMQdNuozIb9N6U/+1rV9Ca6teof7dgNrhzVGYZf1X+
	eBEqvxKgNCpyiFS2jw==
X-Google-Smtp-Source: AGHT+IFt4PulwuqoCTMVnGkv5xAvCqNUHqsd70C5Y0GLWGm62Ls+ETbNspIM52jswK714tvw53XBug==
X-Received: by 2002:a17:902:f68b:b0:21f:1096:7d5 with SMTP id d9443c01a7336-220bbb209camr155241455ad.17.1739508777155;
        Thu, 13 Feb 2025 20:52:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d558591asm20952015ad.224.2025.02.13.20.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:56 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 07/17] zram: limit max recompress prio to num_active_comps
Date: Fri, 14 Feb 2025 13:50:19 +0900
Message-ID: <20250214045208.1388854-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
index c28e1b97bf92..c11ed2dc23aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2068,16 +2068,19 @@ static ssize_t recompress_store(struct device *dev,
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
@@ -2130,7 +2133,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (prio == ZRAM_PRIMARY_COMP)
 				prio = ZRAM_SECONDARY_COMP;
 
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			prio_max = prio + 1;
 			continue;
 		}
 	}
@@ -2158,7 +2161,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				prio_max = prio + 1;
 				found = true;
 				break;
 			}
@@ -2170,6 +2173,12 @@ static ssize_t recompress_store(struct device *dev,
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


