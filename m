Return-Path: <linux-kernel+bounces-510573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B85A31EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41FB1882D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024A1FDE31;
	Wed, 12 Feb 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqN0C7uF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AE1FCFCC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341959; cv=none; b=r+AahBcHu84wu/AxSRQtnBliQG1XVY1tAx/tQVcJvYaL0mAHiNTe3G3ysIbTjg/zFko4XEUTPAWLy5+aHVyNTs0ewrUDOeJS2u4i3SWGGWTeJwax/h6JT323AmKplDUUM+ZrCSeZ9KQHLOfFowL+aamziHo5ixOqpWGX19rziAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341959; c=relaxed/simple;
	bh=LrH528wQy0dtsPj1OFdH0HvdanwSwv/enQHWZGzdxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igzFdR7HzblImxwX/E4UZkZNQZqFE3yJTy0l3GTXWRqQMlQeEiGTetMZICz+k2WLTqiryIvAoy/ONe27LYJnesucTx3zmWDvxB6p1pbRIjTCEFv7GywyyE55mHJyswRooVRqcXVM/sP8Ccq2QOrtdYG2X1pzso6K9Z5Cb4WkWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqN0C7uF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f61b01630so7534955ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341957; x=1739946757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyCqO8rpD053xgod9EGtthWwAT9KzKKgkQ9kmE/51BA=;
        b=WqN0C7uF9o/2m1wgBjwNybNGYsn4mB1vFXJQxgTDFFzwB33QiH4QkZyZuWFUpu4Ei8
         CaE0kZi21iJ3VLgFPrqlpqZuvjf61Tblbu0NjaCAXm0j24R09UYTXb0W+Kkvr7gxlKxE
         Y36sk06Mxs8doGOiB9Cwx5muT1PpiASGrQCjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341957; x=1739946757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyCqO8rpD053xgod9EGtthWwAT9KzKKgkQ9kmE/51BA=;
        b=D7S5PTiSj7HjvRbiO1zTBbofw5OowsoqcpMTvIO9xXYGXDwgrLtKK6BnK9ptt6fpH+
         0RpkklR9z05NeGnah/LQftvcv2AmlNe+/VzG1KY3cDkp/cRUGxO9yDlMJgU7T/Y90KRl
         ZUC8IjIMACipyUz1RnEg/SlLtcVRnkPyavTiPsY0uKJhpV6W6SbPuz9/8u37pZ+aPtYh
         ObufRbsqMMZ1ZXxKXnqlJJ6Q/URHOf6h+B+7M/2480CC0bMYw4UjeXB/46GCQlt2a3JG
         Q4tn2oLOG2ZbLTq2Y21hFvKVEtagPNpdlX4mLgA4DbaIzZBYq/67R1kd3OxDA7568som
         TaCA==
X-Forwarded-Encrypted: i=1; AJvYcCWDfkWj6HTWRjSbP3l07j/llF2EZka1NCIsYXV6nf45Nal4ZcDb9sXDvyepqXr9fGVMfJvLiWJIxoUBbjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu/PGSxnpYbW7F0c2P2R2530Te9JCxl7QNW6Q45fdSUtv7yq6
	iVCJKGyM098T/9kAIshhUk65MMNk9cRSYXyLvNe/d2o2ZLxWIhkyYbh5Yzvsgg==
X-Gm-Gg: ASbGncvh9cOFiCDRxfikA6Uk7E3o2vidV9vqHZuzpcLvviiDJ6Ty0eo9U+YQBtkfqiz
	TjnTMNYnjTzq053Np3tAJCvaTIBLv80Eo6yDs8UnPx6tl2/pOy2a286oT4ZnatrzAbj8ktr4rPc
	yKAuXN1VRsHYTWC2uPaZWsFBQlEbstMX5HTmckM4Mb4IG6rCp0SrcewjUJNJHuheSdZS07O2k8q
	2ipD0KLj5a4v/dlPLlkO9adde2jFRUpEbaq3yr/gjap6rWRTQXvlNXLpCYX/hwnV0YNQky+BY7O
	ssjicoFWfU48czV1KA==
X-Google-Smtp-Source: AGHT+IEC8Cc8dAP8Ht+pVcdn6EfMAD6X2400PsIqNRPLot1jyPj+LyGyqkVdRWRCN4K6E/Zgz3CsHA==
X-Received: by 2002:a05:6a21:150d:b0:1e0:d5be:bf75 with SMTP id adf61e73a8af0-1ee5cf4b707mr3005496637.17.1739341957604;
        Tue, 11 Feb 2025 22:32:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad5489a2ddesm5668053a12.53.2025.02.11.22.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:37 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 07/18] zram: limit max recompress prio to num_active_comps
Date: Wed, 12 Feb 2025 15:27:05 +0900
Message-ID: <20250212063153.179231-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index 7e2694079760..27148f3e5ae9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2026,16 +2026,19 @@ static ssize_t recompress_store(struct device *dev,
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
@@ -2088,7 +2091,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (prio == ZRAM_PRIMARY_COMP)
 				prio = ZRAM_SECONDARY_COMP;
 
-			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+			prio_max = prio + 1;
 			continue;
 		}
 	}
@@ -2116,7 +2119,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
+				prio_max = prio + 1;
 				found = true;
 				break;
 			}
@@ -2128,6 +2131,12 @@ static ssize_t recompress_store(struct device *dev,
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
2.48.1.502.g6dc24dfdaf-goog


