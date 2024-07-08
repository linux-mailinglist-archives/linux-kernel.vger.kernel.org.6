Return-Path: <linux-kernel+bounces-244519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BA92A563
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBC91F219A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0E1422C8;
	Mon,  8 Jul 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HpcsYoqe"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88178C9D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451373; cv=none; b=cX73a4TYWWO5c48BzYskf2fRYfZ3ufHnujAIPCQVmVV8jKscHVjp1Kk/G6n0MOQacJFGbKGBZX72ao7T7zlCYlze1TWQQ4qkFlji96HuOGZLG6RyyUz1ls/XWmCjf2s5hJbTkOCsQeyKMvwG4rk4msnrnT/sJQ12Sy8AJk9eNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451373; c=relaxed/simple;
	bh=lqvT1dYN7ZB0d1qXnmXnxkWCk+h2U4ocW9vwYGH0lPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q8Y0xlBDyX398AQbARJn62sOqFVU5BbInKs2wiR+7Wyz0epaIeShlt/LiH2yDGywuSJwxjz8HdceNVc3BcCgNPvpiKsyPo+eUq+/d7kiOCvZXY5zzQ1c0JgqgY/y2aJtqrOcmRinSgVxpWgyloMbtMj8PQYIYzdQMVUVD6HjjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HpcsYoqe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso27497385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720451368; x=1721056168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHgtTL2FfpKC9CyIQDhTjdFjuHR6UF0FQp0swFLrjK0=;
        b=HpcsYoqeA5jkpw8BQgQMkTbOU9GMvcwgkso53WeQAV5NcdPBqyl0hs3bqQ+cqDzX1z
         HiRsY/J3F096Bjj6VcZprLozc9098/UJTR1J3o1hdVcxtZCTYukxgTUYjlS/fhBTIw/B
         2bbIfGcawnmvsgGl+MUMjDwrC3CkJSwdIp8u2x2D70TzAqL4kFKNlwBhppcSnnccyjxp
         NzT6rJWHbAkPDi2SW052TPoIYpZkoM2Q9/qAVhAQvLyGOXAL9fr+BNwF6z4rVQ18VCRY
         RsgcwszTEulz1oc5AUV4osHitMWAZul2mXqYz/UayxFM2j5GkCKz0Y9Z5FXg1BVEPsKJ
         k7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451368; x=1721056168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHgtTL2FfpKC9CyIQDhTjdFjuHR6UF0FQp0swFLrjK0=;
        b=SfbMeAwprAf8dmQplIOHa46qv8LJ9hj/iqDvlZ1anAJSZhEgw4gTDjwR5BRNwqHoBm
         adz3WvFK9LkI40D2vsfLm08hQAhPbgQ+UmZzADwZw5sL1iG7JoDqUJWTbsfpvD92gvSf
         CwU0X10ZoyK2ugi/o/GtWfrjoeuhncYVK7W1yYfpDsDdMrcA2b5pqOhnxLmUXBhujP40
         gfJGxmZe13ONaiWNKpLnkYtBWf2w+pWZcuJEE+3Z/28tD3aPbft4qVzzA5XxBIOVf16g
         20EIwklnn+954FXnbbOWWvKVgPKvhDzTJN84mwGRVy4yaaNwyb2KSFRFu9q8bqhuN6d1
         pr7A==
X-Forwarded-Encrypted: i=1; AJvYcCUnmM7MBbUaGiuZw+3v7eHwPOV0SPld7qxqXayxjE1jzdwuazc2+D5SlnRWiQdZdHtr+g1aJL2rvXU7VrUoQ4ZbX6IWd0IHjp9yPaE1
X-Gm-Message-State: AOJu0YxFHNtFZAorIzGCC8Nx91Bu7fh7dji2YSRyMvZwWUvQl/dC4aIo
	v4M0e0kjAdWwYI0CKkfzzx9gTiPmZ/EVlJXqVaIJu5Xle8YJ2rreVkjAHc28OwQ=
X-Google-Smtp-Source: AGHT+IGiW1ylu5SZzpvnwzViTEuEF31TXpsB9Z00lg/QgYSpWYbmEawF+nKQio6UTA9xOeDqom8XUA==
X-Received: by 2002:a05:600c:4792:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42660b8dc47mr46974655e9.28.1720451368238;
        Mon, 08 Jul 2024 08:09:28 -0700 (PDT)
Received: from localhost (p200300f65f217d00930e0db224f9e8ed.dip0.t-ipconnect.de. [2003:f6:5f21:7d00:930e:db2:24f9:e8ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm1928195e9.40.2024.07.08.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:09:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Mon,  8 Jul 2024 17:09:12 +0200
Message-ID: <20240708150914.18190-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=lqvT1dYN7ZB0d1qXnmXnxkWCk+h2U4ocW9vwYGH0lPg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmjAEa1x3j3S749weZMw9JNuLQsc+Xf30EazMyM j0/yOKeuJyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZowBGgAKCRCPgPtYfRL+ TlQuB/0cKnkxBNqRPN5unAJbHAmnW6lnWF7M9o+zgJeLhRwbiigzmXF+jmNG8U57A5AUOQjq5p/ JzSTZmHMM+AbyVZVvKBmUuW81dZt9dndw2hgLBL4hTJ6ij5GMOUv0r50GLnKkWJRGBAON3KoD03 /zpG8wOEr2gbKo1d6NUilM0/4gRxox2UGSjT/Z85tx3gFaTKDtK/dmbvbKBhtItm1EMXohtZ7KW WU1mPq5mkFmMHwg5AJv8fSqrklN1vJprKsrXZKfZo9pwLG3ypLS8ks/qWsU6W9fugk+WOpNrS3T irjPDWlqNyBR8ZwEdXaN9RwiwzRAzvN9DIDF3MpR+V+HoZcg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While at it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 4 ++--
 drivers/char/ipmi/ipmi_ipmb.c    | 4 ++--
 drivers/char/ipmi/ipmi_ssif.c    | 2 +-
 drivers/char/ipmi/ssif_bmc.c     | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 49100845fcb7..7296127181ec 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -350,8 +350,8 @@ static void ipmb_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ipmb_id[] = {
-	{ "ipmb-dev", 0 },
-	{},
+	{ "ipmb-dev" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, ipmb_id);
 
diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index 4e335832fc26..6a4f279c7c1f 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -561,8 +561,8 @@ MODULE_DEVICE_TABLE(of, of_ipmi_ipmb_match);
 #endif
 
 static const struct i2c_device_id ipmi_ipmb_id[] = {
-	{ DEVICE_NAME, 0 },
-	{},
+	{ DEVICE_NAME },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, ipmi_ipmb_id);
 
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3f509a22217b..96ad571d041a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -2049,7 +2049,7 @@ static int dmi_ipmi_probe(struct platform_device *pdev)
 #endif
 
 static const struct i2c_device_id ssif_id[] = {
-	{ DEVICE_NAME, 0 },
+	{ DEVICE_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssif_id);
diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index ab4e87a99f08..a14fafc583d4 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -852,8 +852,8 @@ static const struct of_device_id ssif_bmc_match[] = {
 MODULE_DEVICE_TABLE(of, ssif_bmc_match);
 
 static const struct i2c_device_id ssif_bmc_id[] = {
-	{ DEVICE_NAME, 0 },
-	{ },
+	{ DEVICE_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssif_bmc_id);
 

base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
-- 
2.43.0


