Return-Path: <linux-kernel+bounces-525490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD7A3F095
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B9C4230B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C18204698;
	Fri, 21 Feb 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E8dni/rU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7604204683
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130743; cv=none; b=cYq0oh7LS75wsrU25KejuUV5dpFbzk5KSjX136ZLTdTXHih2kkfjrTOPM4FI1DEC4CPZvqjnnNAYc4T1TntVey5goIvaiP9s8tpO1HwwXqMhP/49hwLSB7MRTuPLcb3WHb0xdvPJWUvmcl0O/LZXFKjZZnrb9dAjZcq6jHjnujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130743; c=relaxed/simple;
	bh=iHYDRTGSEmzyXdPtUbJDrKvAXv3M7Oc7UQJqSinxIVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwW9unUuhGH5zE2jmfMfAjWkEqq3M4siiLv2AKmljRBEGdWgR6cSXUAgCOnCtJ5zCQa4xAFLsnuWTEu2LR7SgZlGWDPXglbvA6wh6PO78bN7mcNieiNa21XI/iBOc51JL6dbD/Rb6lrorwGdx/Ck7jzeNEDLFhpp2mRnVtWGlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E8dni/rU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso37181975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130741; x=1740735541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1Fr47oZvnwPkNkfXAk51rgR9W9ztXQBGqxFE9BRxTc=;
        b=E8dni/rUkEccZgrFWHVHtuS7o5o2Kwl5a2ukBkdpJZKYBHlx2Zn/AtzRCtsUhgo43c
         bnTxnfyNBalURtGprP/w6pnmM3aZleAM5nM/hPBHT3FCmSQnUH1Kz1z+DBqt1+zBrVZQ
         7tdJHri8Vqp09namveyjWSfww1wVbVTs9TlPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130741; x=1740735541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1Fr47oZvnwPkNkfXAk51rgR9W9ztXQBGqxFE9BRxTc=;
        b=FKT98pTqtXiLqlIZcTgl5zMhyUv5/udoaVg9mR5oT4znaTFdNfzCH5mT5KdQu266P1
         Va7vokydEsPvGZtyPQX8JxByA1CKZKhNfmmphln/7Or7vV+PQNvMQlVz6sAapfJSqgGe
         42Ir9F8258Za3sgrL8dx19JwqDi32g6BfyowCGcALO89jJgA7FTbjJ3UkQusbUtRUWzy
         cw04kz887IEBB24eepEdIlTArrV83gr2ZIUiq8d3QIx8IQHBZ0nmnIJCTegfeRZgZ9T9
         ZKd4nugmpqt+D4Zqonww62u409X4I3aPIjOBJjAh7F9Yry2aR0uXpYx2LD95qifMqRdZ
         RWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbkE78+JzpPHaDTvFg1tVlqsPVDOgLyd3kJ9cG+2yk7iieTyIAAdjbYjzaXHk1wMtcyTZAcRJc6dx4uTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGB/4C74+FnJxjnDKXwn/jd/RWi2BtXqDQaooLkepWDyOHWVCe
	O7TsSk5eMBTh/cIsjwGgasKWgCJVuJ2eoR/BMnrGQQBu6H9PFrDhwuRKA2VlTg==
X-Gm-Gg: ASbGncuQfjOdmdHgfzs8m6I1K7EyOJd7CLs7m5Q5hacVal8kiiKCxI270cAjULaEFr0
	ucJeCjHUTI4Wo/BrjWFLalCetu/pdK94YOoVinEiy3QZCvnZx9Yp1BeTk5bnrVzkh+aJ+gT/W8d
	gqAPFOrbwgjXNaw1jp5ROnIcwpXJB6U2XxelDN7ELBDY93PypK4EqGz6ALvK+Wdy9yUfvmT4OBs
	LcFWc40W0OeWZ+A7zbutqSdAQiL0HuoO+JM559ya30d6QXyOPtX4vmGsjgI1LED47wMe5dopDMV
	hvxAQU+NuCJ7hB915dXeilpQ4XE=
X-Google-Smtp-Source: AGHT+IFRUnCZlCQ55FhwarcrVaKRWTrZj4RkPpnwVEGcDwDMY39AagQltM3YaVXCI6t8ZJ/r6pw83w==
X-Received: by 2002:a05:6a00:4fd3:b0:732:5b10:572b with SMTP id d2e1a72fcca58-73426cb2b0bmr3161816b3a.10.1740130741168;
        Fri, 21 Feb 2025 01:39:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb5813a687sm11978723a12.20.2025.02.21.01.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:00 -0800 (PST)
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
Subject: [PATCH v7 03/17] zram: remove unused crypto include
Date: Fri, 21 Feb 2025 18:37:56 +0900
Message-ID: <20250221093832.1949691-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
index 3fd1608bbe9e..424ed1128fb3 100644
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
@@ -1154,7 +1156,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	size_t sz;
 
 	sz = strlen(buf);
-	if (sz >= CRYPTO_MAX_ALG_NAME)
+	if (sz >= ZRAM_MAX_ALGO_NAME_SZ)
 		return -E2BIG;
 
 	compressor = kstrdup(buf, GFP_KERNEL);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 794c9234e627..2c380ea9a816 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -17,7 +17,6 @@
 
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
-#include <linux/crypto.h>
 
 #include "zcomp.h"
 
-- 
2.48.1.601.g30ceb7b040-goog


