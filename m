Return-Path: <linux-kernel+bounces-510568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8635CA31EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F3E18824DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72951FECD2;
	Wed, 12 Feb 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfBRkeHv"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C631FDE29
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341939; cv=none; b=mNXMWdcypE8x1dOJZc5bwqYUIJMJ3SJtBk3XglLB5uvuNSlXDt5+y1CBkMhhkewULD/NkrtQWSGuh2YC8WlG0uDheEbOsAvT8Pf5XAtXJ+ZkGNG/f+8ETBLH1JWAnZIedOrEO9dpXcR2APUXbR362CzY3F+smVQj11c5exVo6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341939; c=relaxed/simple;
	bh=Z+RlvhbxEtZbFxPm2l0VEwmqX4Kk5+EzLmT2i1VTvyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwmb3ud5GOXdTVd9qM/cOoSAtDXPEKoA9os74UfvJm/f6T6VKoAU/9ggjCmegEl/s/qwn0QHW4eoKoWkPG1KvAxJB9MC4TmTsoBGJk/2XYZkOZ2G5JP3SWo6j5tegEPSMmRW5HgDlPVsXunNyy7P8MRstZpeXO39+I3GPzge/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JfBRkeHv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f44353649aso9489449a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341937; x=1739946737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48U7icBiaj5vHELEBDYpmRQUsi6H+QG8AACYxOChctw=;
        b=JfBRkeHv9t+mAGqAMgsJy12nYOvVMzEF+Y49mfanBlv3QJqiXC4AEw9VGBSspNLfpx
         8x2TEEt9wOK+vBByyTJ+LUxuNULB1ta7zJta4ZbPx6JB374oXTtLjHjMlZPpoIM7tswu
         2szBANudApB84b0fnNLgj3AwxuAi/b3iu2ass=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341937; x=1739946737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48U7icBiaj5vHELEBDYpmRQUsi6H+QG8AACYxOChctw=;
        b=pb8aClmbTYhi3TSlg6vBD2qoAaWHQBXP6B6+9qD5ZqQf69lTJFCvj/gG8Iw+jzrkCw
         c4PT0i9mTflothwiRkr2w/xGCrOI3hYx1AmrFpxbfKkrzs637ZVz6yyjFQpqJbWMzBrF
         7hNG0lQtJcAZYOYG0QfOdBpZpz7vMge1P83n2uuYGU+Km1bFbDJWVywvS9RT95T0zwjg
         NQGpOKhTYyvlEedGuestQIBnXs3hHm+SHdxLy39JS8QUocfcGFmmqvyrEgXq3Y4vOeFo
         2SwLEBKkD8RLjdV+wyuC/R/YcnnXAuvlRAzweJic9+WDQc8QCSgwqcnVjFE2ci0b5Rpl
         z2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5NW1IhJaTkLiOwfUUsEcJC/WvGcOb4GdT9EkRFRMYddKFbabtrNdxLyg1Ckk/XgrSK4RKMktB38k9rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CDFiyuO09yGcFxD7yBDflY8Nwg1/zzzg8OFVpoCvceTazGLP
	iuMqX8sN2rczXBxfnlEEvw4UMiglgyf/oFZuH4Fu7rm/D8pu8HJn9XRJDXcxSg==
X-Gm-Gg: ASbGncv/JzsE3qihxxoOtKJ3j3eprlKWlK8h6I5FerI6EcYSGgLGPclXdc1Gv9f2hvO
	EtZGZesqh+1WohHq/mtJTwHEDwtqgkmUFBK4wWMn+5uRl05MDouePlvr2myoCXf/nv2b1Y1l0EQ
	fDfvCAXflSqh8PB1mlod8kELi0QKPpF4wdR6C2e2J/thxxjZgG6srx3QscVogmy+5jt+MEnZGa8
	YkOU+IRdby2+d/uYRAow+p2EcooZyUpDm1K6a43FWmhZ9l76TbOA2fVGVaf/gGAasGDkTMxcBxJ
	3QHJliUBEvg6dQyztg==
X-Google-Smtp-Source: AGHT+IGlZ7sjxw8CKEDe37B21DbU3g+Tt4XgUZOISnGOFp7x2JKzUfH/1KMDV9dAFdU8C0jsA6InIg==
X-Received: by 2002:a05:6a00:1c8e:b0:730:9659:ff4b with SMTP id d2e1a72fcca58-7322c5febedmr3482199b3a.19.1739341937213;
        Tue, 11 Feb 2025 22:32:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ae7c24sm10384533b3a.78.2025.02.11.22.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:16 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 03/18] zram: remove crypto include
Date: Wed, 12 Feb 2025 15:27:01 +0900
Message-ID: <20250212063153.179231-4-senozhatsky@chromium.org>
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

Remove a leftover crypto header include.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 1 -
 drivers/block/zram/zram_drv.c | 4 +++-
 drivers/block/zram/zram_drv.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index e83dd9a80a81..c393243eeb5c 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -8,7 +8,6 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/crypto.h>
 #include <linux/vmalloc.h>
 
 #include "zcomp.h"
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 43f460a45e3e..12fb260e3355 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
+#define ZRAM_MAX_ALGO_NAME_SZ	64
+
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
 /*
@@ -1149,7 +1151,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	size_t sz;
 
 	sz = strlen(buf);
-	if (sz >= CRYPTO_MAX_ALG_NAME)
+	if (sz >= ZRAM_MAX_ALGO_NAME_SZ)
 		return -E2BIG;
 
 	compressor = kstrdup(buf, GFP_KERNEL);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 63b933059cb6..97c98fa07954 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -17,7 +17,6 @@
 
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
-#include <linux/crypto.h>
 
 #include "zcomp.h"
 
-- 
2.48.1.502.g6dc24dfdaf-goog


