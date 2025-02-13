Return-Path: <linux-kernel+bounces-512200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B759AA3357D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667BA1661D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352841FA15E;
	Thu, 13 Feb 2025 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEkWbPxa"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401741C6A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413518; cv=none; b=iONfCSSHrMyhYfl3IkEaV3A1Pd6oC/s/HGP4MhqXX9eJ5GaqcVuhF/WHv1nMz6H1x70hG7hogf8kTkmNYesgSEC5OHjsgHFCdP6ZFm7yh0H7bg1Fgu23vF7M+RA0BI5CqVj33nnrMql2qDFkvUQdMrp3efFjgLyCdWZzYuMVHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413518; c=relaxed/simple;
	bh=5OvR+RJfu+sx8Z8S6QIx4lN0DZP+O/icU5pvC/4XksE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BLkfUANzqxFa+CnUJjlddbpp5V2cCJ2WTBqY6Cfdsqs40hSKXiB0k9rfPUa4+hIkDU9TAiLdzmXPH26piXz2JjpiSo6BxRWer+mDI5cMlS3MRX/HXSMfkN5NGVOhcWnFd4GmuX2lE15jDc9QIo1agUvhFRwfkEzucnMHivz1G98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEkWbPxa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e2460c6f05so715646d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739413516; x=1740018316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArAshzXLr0TjIJ16OpF+I8q1C3m2NQ4+psgUP47Q78k=;
        b=IEkWbPxai4TxOsN2ZRTw/C/x5JPJQds0AWmW7UCSRTlsr0e4p3sSHPLzPg7j0vx3sU
         djDCWd/BUxhQ2G6PlUN76+XVPgLO2vagDTZszGADALz98N47y/bsgOVTw2f/4+lrex1O
         Mm2cSFOqrVsPk7xPg6iYb6YaieGou6WGd9mvDftj8d8pwbxbSomXRzAJsc7GJmT6gteS
         uqZdamZmcEWBYO1RY+tWTVSn4+mNnJEoumt5tI5ZGEcZzIOxrEie4s7IzaZwgsSLQ8Y8
         EWfjDXmWCbg4UW0V72G78pL+cyi90dfznkItw/0CgWjWbRwFRex4OUYOl1g0xgX7OQEp
         n2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739413516; x=1740018316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArAshzXLr0TjIJ16OpF+I8q1C3m2NQ4+psgUP47Q78k=;
        b=YA4vN0Mc7DgM1AUnpZcvMYgly8UHkUwJJiXOmGy//vNMO5g19d7zKU7t4h/Y6yjYmK
         8wIVoAGHVok12xq1DPzM2Vc8n6NF3H6j1KNM+03yHrJXYdhD/SQzlZojJo1o8Lxw1n9Q
         8AUM3HSoG7dPbubm4UXra/Rd1aTR8p6HbLM507APhtjnShd+CYAcCImSEog8b3VvryQ3
         bBO5ERycsR6o7ktBeg94kjNPrRqZ0/nv6tpkXSFrdh0xoVMm295WWuwYuei51aplzuFO
         uVaxzk1AnMb8n58zhmG2V8dYPc/1RRU9NVfObpfoEEu9ytR8ms9mLGPdDRopmnfXExYG
         dEOA==
X-Gm-Message-State: AOJu0YxpqzOTgYARdzxp+3Cb9WgBhoZsCxBXXaOB3YmgS3YIXjOZTDZ+
	8sdwpGhN/mPZohV3x5c+O/q1F0lPDv4G+WPV9BPHIF2IYX/yX4tG14ZY
X-Gm-Gg: ASbGncsFp5A4wbgN+n+M57AK4+LMKtg12V/8528Zrbc4d9/OARh5NuqsbsuJxE6Nchi
	a0Wua7N79wtBtRN7WpXu1HHAeLPnn+cYaqlYpdcoODKn0XHkGlHK77YOh33xKsAJrv9a9CY4DGb
	b50m0b/dd5Ra/VpBfXf7lEt/8ZbBWsj1jDb1x1h5hvjZK9oYftk7IRVSBnVjp2lYbkTO8v+17QJ
	Aq9MzvtUR4uhTGmseuf6BnjXgCOGfBNmzt7X7fbjFpzA2e/tEaRazzlGwl57DIP53tdnYr4R2/L
	roW/7IgSbGgd
X-Google-Smtp-Source: AGHT+IEddrKkWbXG4voDQYWCCcRelBeJmZg5bVtja+dBu/e6uHjsbYV/yFzXoZ8aO3fB/mQ4hN0ehQ==
X-Received: by 2002:a05:6214:1d0e:b0:6d8:967a:1a60 with SMTP id 6a1803df08f44-6e46ed93ca3mr36081746d6.2.1739413515952;
        Wed, 12 Feb 2025 18:25:15 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f36bdsm2635766d6.79.2025.02.12.18.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:25:14 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: lee@kernel.org,
	lkundrak@v3.sk
Cc: linux-kernel@vger.kernel.org,
	zzjas@gmail.com,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH v2] mfd: ene-kb3930: Fix potential NULL pointer dereference
Date: Wed, 12 Feb 2025 20:25:09 -0600
Message-Id: <20250213022509.2154603-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The off_gpios could be NULL. Add missing check in the kb3930_probe().
This is similar to the issue fixed in commit b1ba8bcb2d1f
("backlight: hx8357: Fix potential NULL pointer dereference").

Fixes: ede6b2d1dfc0 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Suggested-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index fa0ad2f14a39..9460a67acb0b 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -162,7 +162,7 @@ static int kb3930_probe(struct i2c_client *client)
 			devm_gpiod_get_array_optional(dev, "off", GPIOD_IN);
 		if (IS_ERR(ddata->off_gpios))
 			return PTR_ERR(ddata->off_gpios);
-		if (ddata->off_gpios->ndescs < 2) {
+		if (ddata->off_gpios && ddata->off_gpios->ndescs < 2) {
 			dev_err(dev, "invalid off-gpios property\n");
 			return -EINVAL;
 		}
-- 
2.34.1


