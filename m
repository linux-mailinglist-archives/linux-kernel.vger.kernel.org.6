Return-Path: <linux-kernel+bounces-332636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCD97BC46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C4A1C21E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5214118A6B4;
	Wed, 18 Sep 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2/VUG48w"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C118A6BF
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662767; cv=none; b=YCt7fqL7YzFQ1CGDz84rHiRnaTMZPR/r+DgRb0xoE8xlX6KckO+FranSq4nzoFiiBaYNYLb8jk6wxgGjFUzX5W+y+YZshs5MB/qmHelw0uFMZo8MaLK0dZcPZ8IicpKW6boYSOTn2pCCrvQouz0EJsYvNZoZgpLl9tYwjexmUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662767; c=relaxed/simple;
	bh=vKJnZkWWS80Qtmju8Q/9wyDHuf8ljsMViMpaXgjgy/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pThNlF8DUp2NlYUay4m8wNegLGmR+mUe1cCg4KHWKgV51/X/S2TE0PU4F0N8PfpsVGChPTFrojJuwR9hTPzY9zYae6kaais6DK8yOvYwEEpBHMi+7t03TmAWE9B1UoST8/2mfVTaeNR/sxHy+mIy+FF+RkMBbiGhJRPrjSGgcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2/VUG48w; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so8559387a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726662764; x=1727267564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZhliqxgyY7Mq8AOL7Bnvj0uEwOcI/YT63YI4qZtzkU=;
        b=2/VUG48wos5nwvTghv2tYXSIhK9338T4qt85FGhCIK8kHweLkTIMk17i6uMUnFQh9P
         XcIa76XrLmN5OB2OyueeMQs05Jt7nWxVfZrF0h4Xr5dF1dx3c7M0Dc0Ic+snD3GVvB+m
         Ef8jnXRiPzclW1KGaXjlYEbLM1g07joZ4aFMS4qv0JNCymyO4KMwkt3dJ8hc5r/4T+54
         QTpKyW9l8RzBBPDO/2e/l9H6kfWU2wsgkrsF7U10DFOxFn0SYpga/1FlW+sulRT0/HXM
         H866GEKeIG02Qfo9qtx5D7ogKurPG2oLdtDf7W4GqWD7j5oPU2BjA6RgqFFLT4P3P3q8
         qMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662764; x=1727267564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZhliqxgyY7Mq8AOL7Bnvj0uEwOcI/YT63YI4qZtzkU=;
        b=RqRwN6Flb/HDtV9YoEneCvvMvxulPUG9YunkubasDPcvKumNnQ5iLcQLWh0UmcdfIp
         o9Wi9QBr5cMtbcV0UJeX5pbhIt/lx4BITNLn5c2OHooz7GaYzyMLxhYxb0ZKJGdE6LOp
         gfZWw5bdskOhFhYJl6S8DPBrxadu0075dGMcEy0Qt95JsfZKmm/UxJ3AwBrActTVr4qs
         Dn0W/O5Ze3g4k3FMv3FM1E8ZHpIokjHGxBKP6UMEuXmC1+1y97eJ1EwwRvTFuOd/CwLv
         As5LN+yZGej+67+TuEvfnXOe4d9VAzw1RjsqZkrkwdsChmOZf1GtHI1KfciM2inVos1S
         bbyw==
X-Forwarded-Encrypted: i=1; AJvYcCUE5vBct+RT1t9fq60KRYB8Gw0gWmkU3UGdsA+H/Bck4yG+2OQcMMfn+yaZn9xL5SVOazqG+pDAkrvRY1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/PiVsdKAr1fzNV8Td18T3e+2vyAUl8z74SIJj4UrASpzInXz
	p3oah8Sw3oPJBIIHQ6+MjF/tftxZeJ1TYrHbVT+BmJxyOhvdduqWuLCcfjTUEuc=
X-Google-Smtp-Source: AGHT+IEEDVpwRhC6Scvjb+H97Br0hyyr92G4Ib/fmF+/0i4P6aqXZzcuKxCynYAv7kEBWVtqeg7aiw==
X-Received: by 2002:a05:6402:40c4:b0:5c4:23ba:95c4 with SMTP id 4fb4d7f45d1cf-5c423ba9733mr16448765a12.9.1726662763852;
        Wed, 18 Sep 2024 05:32:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a2bb:f619:b5e9:672f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e07sm4851775a12.76.2024.09.18.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:32:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 18 Sep 2024 14:31:52 +0200
Message-ID: <20240918123150.1540161-10-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=vKJnZkWWS80Qtmju8Q/9wyDHuf8ljsMViMpaXgjgy/0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrRXJ1w8dDpM8y8z5jDwORyTZn4WmPqhwennjICZHXItE hlHjrt0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjAR5kfs/6smq/sGl/Xlab2J sP/LE3yI1/l2v/WrgFcqNY6m7/wXOBn87Shg/NEpfd3IptDEe0HP8Xu3kzi6z62JFXjxlimp71w hv+7irQ+SAxY7pN1fdXtVblhl88520YW29++c2++2SjBoq8/P9OKGjcyml6KUtsXammo5JH2W4P osJDJNr9RtiXyBlMRGidg4xgo3nmXmSWIbzdoT9Nm4Zt54Z7BQz3+nlFzmqqeKr34ceNiUqHO0d lVRMNPeHl/DJ5G220/k2mn/O58ky/Yqmpml/TVT+ByNgGa1LQoLH/28nlK51LTY0tyH+3lJ9IPf +tlej757Bt1O+rjj2ORfrP51sWdF0qynXH/64+vGaaEA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/crypto/atmel-ecc.c     | 2 +-
 drivers/crypto/atmel-sha204a.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 590ea984c622..0d48e64d28b1 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -379,7 +379,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 #endif
 
 static const struct i2c_device_id atmel_ecc_id[] = {
-	{ "atecc508a", 0 },
+	{ "atecc508a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index a02d496f4c41..75bebec2c757 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -202,8 +202,8 @@ static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204", 0 },
-	{ "atsha204a", 0 },
+	{ "atsha204" },
+	{ "atsha204a" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_sha204a_id);

base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
-- 
2.45.2


