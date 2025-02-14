Return-Path: <linux-kernel+bounces-514350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62052A355E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7523AD895
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262F18C924;
	Fri, 14 Feb 2025 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVtMpFOD"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3E18A6D7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508757; cv=none; b=E6oVfrWhKYDhlEZQRqcnYhKgUO5OlmUwRP7zLgAZpYx3vSN8tjvoENl6bHUJ2R74GQdYn0uB5P+RC8cZGP9kEnQOoIPT6kJzzwod8Wk3CjtKQ1KhbumpjvCpeYCGkgqnusiUUvXEpqCVjDXfPnqgeoW/DcEPD+/4b0RMtKHQbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508757; c=relaxed/simple;
	bh=o4G52ayGrgbwDqZT8PM/VL3I8xDpG9z4TscAzs3WuNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScaSLOKxaTDaRbO3gVAxmLz4YEak17r8CxjkNdO7jGGJYf9fRoOG8kGLqSJLMuUFhBQ+9Uq/mD3V/sgEKlXuqYAz31tHVtKNJwbkPzmX1oHwqIZZK4wGC3B3qnDRq3OVrwX5TLz1pXEaihCA+oqSFKxuKrNsFHknFK+8i1NirpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CVtMpFOD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc11834404so2071862a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508756; x=1740113556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFfEwtj8s2kkg4bqWgjDWMl6rQxMO17ZCkJqcn1sbGY=;
        b=CVtMpFODSATdq7CXM2Kg+BrLUwe/g7G0HH3e+OKl01RsjAd5+0V7TG1GmcPMOGnqkY
         82S2t2Dxh8F0ykG9rkCz+3xCM7cykGsNv78xkYosBxnUFSRHuhnLIzE0FNcvenO7pFPg
         3QtfTu1AJDyjBbIDW4E29aOUMNwVRQXVwlh7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508756; x=1740113556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFfEwtj8s2kkg4bqWgjDWMl6rQxMO17ZCkJqcn1sbGY=;
        b=LI/zqZ870KFmk/hZX8V8xVoOSVs/qglyTORv4tAoMYghVUyOxEsFZGW0o4emFohRDh
         +BeTQEd4D0JzXGZems6z/fQPOgq6WoeqEBnAfBAj1inzB1aTDHMRxFvBVGpfqeCYGlJZ
         jjoX2L2eJ2NO1MBZme39sJAPG6xS9YmyYUe5MlzxVjpBfxG+GODPDN/TSBzGimvRQ4/d
         91/u4xxEAi3a27J6V6EYgcrEuyZ0CMAI0GQcDrEKhHp055De1OGRZcDBPWHL/XzV0Mfi
         NzJhXsoceknbyeqgYurZpd+U+XLuF//seIf1uAP8XkTlTYHKCXCI535QJBzX7nKvM0Me
         T0ig==
X-Forwarded-Encrypted: i=1; AJvYcCVMepOGxOb1CNKe2l5QnPBq5KyK1Ce5ak2oNGDGamZ1X4RJcoUrhm13r2nxSGS0h1lQvX/b1zyMf0uW2Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywarmx9ff5uYtS/wRYudd520XNqJEniodqlDPQln8exDWzFWJDu
	JFLaruirhV7A9JOOjA8ztD+QYpGWdxgT2NAjS+s4EkSJm6R4OhNGsUL7zTuDzw==
X-Gm-Gg: ASbGncuFwtwoPqAUyuT9A1Wl7WsYqOR58AzeTE8pHwjJWbGeC5kV6pw8OfWTBkHy8q2
	422db7jdW0gU/kwCYdJN052UtBuy9jkblGDOA+maOTfemD4AGzX7IWQhlSlwUbC2ygGo0pqIbE6
	/oIBHljqYj/gbhDJ14otYBh84BUYdAILsY22qJitjh+GDbpvJpT5kocHLt0/UW8Tx1bgL3PnzW0
	64MP7UU57rvNKgcX+M68IIoCIGj0r+FtzImu4FYqSCuo7E9T4sAH4s/QVJF5zRQ3Sn4J5rlV4Zy
	bUgUmA3azQz4mvAdrw==
X-Google-Smtp-Source: AGHT+IHXO0KDJFtD3EzFKW9dTfi8p4jF/4dEQXWLK1VPzLY1TsXZB+Jthq5QTwRY8WV4GLgW0+AEXQ==
X-Received: by 2002:a05:6a00:b95:b0:725:df1a:288 with SMTP id d2e1a72fcca58-7322c41b9damr17804053b3a.24.1739508755619;
        Thu, 13 Feb 2025 20:52:35 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761676sm2272540b3a.142.2025.02.13.20.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:35 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 03/17] zram: remove unused crypto include
Date: Fri, 14 Feb 2025 13:50:15 +0900
Message-ID: <20250214045208.1388854-4-senozhatsky@chromium.org>
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
index ca439f3b1b9a..0c8821b2b2d9 100644
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
@@ -1191,7 +1193,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
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


