Return-Path: <linux-kernel+bounces-535564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34609A4748F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C137A1839
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709761EFF8A;
	Thu, 27 Feb 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULpE2ptc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5301EFF84
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631009; cv=none; b=GPf46vGA/ESXaWTj+TGzUrOVKmGvKg6cWVfJhrBQktWs7eRxK8C+7FJr//jmmmf38uaC3BgRgHeAxYyZxz5Hn+n1vRmfu/qlQKxtCaelyeTBEdv1VwBbfYCprvBLW/mL8weKbHNYIJIghrV5OFdzoeHg17oSvZl72Dnzf0JIJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631009; c=relaxed/simple;
	bh=0ebbS3dnmrYHdEmX8v8UM+4m+e+/JpKPeeS2maLbOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgITai4LYxVRJuYLZ7mbeiTaKnLYVRJC4SRR1skeCowyNCqNmOjCsbdwuFIMaY8Mv26Kra0O76ZjOXQuzKg8GqMxWBERCIOwMZPRmP+mu+8mbdH+AWhyHWouFfjKNzFKAzkult1vkFeDw0j1o7r3S/mC/zWhaFxy18T8EaOoXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ULpE2ptc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so892785a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631008; x=1741235808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56O4ZNY5k4tishEKpit5ayGqrbKDM0LZTadKzr6R7CY=;
        b=ULpE2ptcuNMxuAS4T6pO1MLgaP2iVEno3Q0ukdJuaecNlKYsZ6EioGqGWEiM/t88F2
         MIZ2Q/NnMgOoBhB/Bi1N/UzeORyZt1EiiKNIioZOuMqCqJk7TskR+TkTHhOO0Xyvw4ir
         4UkfhB3K1mH/WNHZZ602nIZYU4fgmAIY8p3a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631008; x=1741235808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56O4ZNY5k4tishEKpit5ayGqrbKDM0LZTadKzr6R7CY=;
        b=SvABHM2+49c0q03FO1uLf7QYUOze70/9FHWDyTYQ/CMaqVEzl9V/lMrMDK3KaKpPrk
         f+Nbb7qppNa/EvnDdOeoblHNJ7ktxuQBXPKRbnmso6HReZm345VuM4P4E30tXPGqKoCa
         6oF30pgKGkptjTxOHNkokb17Tfrz7eIJV0p1zYvOiAycDoD67WKbk36K/y+KqaQ6uq/+
         2u8jf5wddmFD127L+uxBRdHrNFgFuirPWfaAC/nZRSIV9ji9APu7cM52vMyr5Z+XSaIq
         mHPehYHl+QIdR4CDSP9c62YywfxzK9DsGgehkpnnxb8DcC/pLJQbmj45d+It+4tR9XeV
         TD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXTj8YLE3FAQUJ7uDclBtD5Ph2gTd/cSKlXzqmag/HnOr1N0AciWWM0N43MVqpvfF6x9xzC57RfK7+ZrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2O3vGJIvfZmv0+IhNp3gC7kalR/FexyVvhrFXbqJgaPuLwUzc
	ENbdgcQh3DaYykyKclxJY+KHo5hec3vrVvEPUnSgI/ZvciG4L4y3FhbSMBYRnw==
X-Gm-Gg: ASbGnctQkomwdRQoOcMh76uSb1ZCN49HgBVOS7Idl5bnz5LYudqBPK0OdABuLU+aa0g
	6nFSM7H3uiI79+e5KOzEzzQm48Olh3nMvG9ls6d9qAWk6aEOTjE+SXTAKTH4EJqhml3V49qyP0u
	PIgpHTk+jUBkenk9SUS2XWNWe+MzFqxn+siIWuyi6oXu5MiFR0HtFIrwFE2VMouMTb6yqebXMCv
	+V5JWqYvl7apj3aP/HoigsuSrQWQawoEchD3JiIPwBG+GzNoGMfTmYJ/XIEIzVtwsL4Upy9opUO
	eZDjZ+Q3eqHTv97EVBkBMj2yM8jH
X-Google-Smtp-Source: AGHT+IGMIGgkdrOdgCZypYyXDBfzfhMe1xi1OCaXSVRhVGjTG8sqvOZYXxtnCpOaAmEsvUhAKgiqvA==
X-Received: by 2002:a17:90a:c2c7:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2fe68ad9a18mr16247712a91.10.1740631007917;
        Wed, 26 Feb 2025 20:36:47 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe8284f064sm2587811a91.40.2025.02.26.20.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:47 -0800 (PST)
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
Subject: [PATCH v9 03/19] zram: remove unused crypto include
Date: Thu, 27 Feb 2025 13:35:21 +0900
Message-ID: <20250227043618.88380-4-senozhatsky@chromium.org>
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
index 545e64ee6234..ff662144b98b 100644
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
index 8a7d52fbab4d..8b66af0d162d 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -17,7 +17,6 @@
 
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
-#include <linux/crypto.h>
 
 #include "zcomp.h"
 
-- 
2.48.1.658.g4767266eb4-goog


