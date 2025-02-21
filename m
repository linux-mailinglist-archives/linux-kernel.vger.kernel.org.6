Return-Path: <linux-kernel+bounces-526745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F25A402AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E738A3BE479
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70E253F3B;
	Fri, 21 Feb 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KH3nY4ad"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337D254AE1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177027; cv=none; b=h/SJt3BgjpYPCGOP8CeZje33uwBBGQgtEBIPJhyGLijaOYI5wtUt3z/aS+zGNUnsS+yw3Sb+fuMOGuhhBW3Bb2v6ISUpqQy+11fo7WTsB2/Cmr+ry8YDbgIwL3q++8ffPb+uNIlyFYIXxMrxOOt2CWM4BnKO47Fb+bbzEkhgjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177027; c=relaxed/simple;
	bh=qwkGomOoYPceUm5zc6PTbNu6qhYp7XYAdVO9aWUT/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6xB8h8vbKEHiLuvLSe/nFUjh0QUxsQTm9r77U87eIvNl0R5j5xioT7zbKes1fZ37n+mprrtjkxiW5QPHs96uv4YL0G8YI2k6lSZNYVgTaedLNWjHhL7jlFePvDKht6VXuYKQ5q49CEeFqk88bp0FkNl5l/yJWUcUBPoNK4fjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KH3nY4ad; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220dc3831e3so59055275ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177025; x=1740781825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRucftKd651mJZM449koMgQbInBtJspHM/LJa8qQfME=;
        b=KH3nY4adPfF0Alc74SRfou6lyRCsJ8SgFYc4VdX7eDkHH4XvC295dO9kejtrq06/0Z
         ZYIsoATpSw8jsOzdH/82m3ry4LtILRoSUqlIpMuH1zDAsONA2x089ciCIV2ybKiSyilx
         8Brlq4vroe56SJ01L0qQfbMYJ4rwoEbrjF12I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177025; x=1740781825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRucftKd651mJZM449koMgQbInBtJspHM/LJa8qQfME=;
        b=JEEvX4y5bAo/FQHEtjXoOkZBvwMQ3j3f846FtfnfyO4aBT+IIgIuQI8AEkAPRPiwX9
         vv94wTH1M3n3HcnPVbcmokApRqN4J2iTL66vESYWMcrJSzOBty9reJ2W6K3wbMlSgC9M
         +XE6dO3zU5YaBOA4pjz06m+p7HZrKtgY0FmphmqWLoWxfayjR2GQ55weuUHiqCbFIOTG
         DYJzlKD0X5o+PYNCyJ+ScEu3oCjOElab2Tp7/FwVNcj+ZIu5g/9+LiecyNKj7vcjrRY5
         JnXtOVrex+Icx7RpivbT/GlByi7PZ6o5W1hflb3/nHOyNqsjq8vicyiMSY0P5HhViWW6
         Nd8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbCJiMr1Qk8R0nt5ZDmjzF0b6w9VZnqU8e+ImlwALKw17HmH60oTK/+Jt7610/41TTiGfK8oT1HnsPgCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jh28hR9v7aqzX+IN9GqkeEAnXs1TSKHfkBrJkVRGyS3HxR3s
	qi038nZPRHiydRpTJwjyUbD5rEonYz8D88Uq3CoUQjCNTLZnyBTxd2fhAA/ZlA==
X-Gm-Gg: ASbGncv14YvCMm2zfUb+K/yPf6uxviaiDo72BpYUe1rUrg7vWJbb1xhyNMSRoxA0d9j
	f3IrgJgeiVPc7vwG0SYYHRicAZpe7bvSmBUSOF60HpRjMqcmsh0dFKj00JNM6lN/8eYfoRtmnlE
	e+86y+/IDH1JweSjS8yYfS39E76zJZ9lkKYHHGobV/D9KFwpNkydrTT5FwgNBvCgI/H0NZfFf5X
	fzZrmunVQ6NV0Tzjgm0/Sc3q9S0Cta4rlZ5p1R3TZA0kBUMYqHAKLrg5q4p28hITLiQ9LaXIKNz
	J+kPez6CJv6knSFyQdqaADXVu70=
X-Google-Smtp-Source: AGHT+IFFK4qHRvCohfvbZU6uo/+Gpmd5dbH/UdpJOgA2xR/BA7bO5JXyADGSM8tFOOuSctitamoWFQ==
X-Received: by 2002:a05:6a20:a11b:b0:1ee:cfec:9e5e with SMTP id adf61e73a8af0-1eef3e1ec9fmr7915821637.21.1740177024780;
        Fri, 21 Feb 2025 14:30:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-addc7e25d20sm11579253a12.30.2025.02.21.14.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:24 -0800 (PST)
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
Subject: [PATCH v8 03/17] zram: remove unused crypto include
Date: Sat, 22 Feb 2025 07:25:34 +0900
Message-ID: <20250221222958.2225035-4-senozhatsky@chromium.org>
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
index 1b5bb206239f..c73d8024f48f 100644
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


