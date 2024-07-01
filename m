Return-Path: <linux-kernel+bounces-237045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281FA91EA3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30451F21DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C6174ED1;
	Mon,  1 Jul 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnM+00j4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7D1741E6;
	Mon,  1 Jul 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869046; cv=none; b=Mpfqn/hXZmKxk/2qLPT4wp/Da/QOYC4Z83J2OZmI/BcgXKiq1UNOgliJZIa6XYV0zFYgzRMNnEyOqnpUcgliS7Tp+yBsz9MUvsd3naI45SuCbE9+T1CEQ0TW/QreBoJJn86ikF30SvID1okIdFZCj30M742VcYTomj4SGe++zNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869046; c=relaxed/simple;
	bh=WWqKbPULAyL+L74YBgZ1+0YNecn/uWNBOcNZ8wqjbeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lHSslQG2uROZCI5brCyH28q+AmvbyJfcgtFg04gW2CC0xAB7onb2z9Lq+0/YwTqOCOG35VWCRunzBEWjI6L4s/75Dv0AeTm+m3FogS80eL9i5npamdHqF9Lio/HkKds8o6ficRWVZMuItmtrsh9UOqr+aas4wGhnf+Ujyu7sX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnM+00j4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70670188420so2286437b3a.2;
        Mon, 01 Jul 2024 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869044; x=1720473844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHw3nW5B/4WNQZhvjY2+OxpbgE14RxG/DICilGYvdEM=;
        b=nnM+00j4e7vL6AcMLDnyzy545mlb8vR9DuDX+fk0l2VvqYIPHCQUjlaFUqAszr6y9A
         UxVjGca5Z7usEp7IzlgaeBVpeKP9Zi/heC2wy08jWysCZl5J0aYmARYB6sGAERLpn8L/
         VqHRwb71mcXqylmy3+hYsWHhSE6z5UpOR2px4i5qTugHYpp9z65GlFfLDf5eS+F0vgqE
         x7ugsqKRvGFNs3kFgLM5YLrKg1ozBW4OaokXi5bY1MQOCUdSfFZYB9Cpp2z6msMU6e+b
         TGb3Y6JAUSqIf5dFZkgx1SWEU4cr7J007HmJ/Qp8BHxiICJCLA7pkrQH4JBxJtxdj6m2
         rghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869044; x=1720473844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IHw3nW5B/4WNQZhvjY2+OxpbgE14RxG/DICilGYvdEM=;
        b=lufmdqWJWlcbEcJno3OCALlwWAYW48h8vbiw/nMAIelSRxNIl2TstQgkx8XTG+di/+
         PxZzlr+bUjoFAsx+JP0LiNQQ1o5cVdgrOuhZiTrdIFImheTVO9gqXl5LQkObyC1413tQ
         yiLYrUtvztAzZuqoBqGzXCn9MLjF/jnEE26DW42neN8JOZpSKrSMz3Ag6wOD2lIt081z
         ixzT4BNxUd/RWY2BGGG8XWXXUGn2m795xjWtR3ez3wqnOajDzWui8nzY+x9R746GA591
         pjqd3fajmfektL/w+J4N8YaobKOGUck+QvK5UfvsgPnZ+BoWjaG+lqZAGbjIHrvBJAKy
         uz9g==
X-Gm-Message-State: AOJu0YxbO9O8Aq+AqPVy8J7UZSuxAe5109VPe6rErniamS0DFndutBzy
	hlmsp5g98X10D9YBAFevgnON4MCNKNIurwf3X7fPZcxy0wdAyXt1Lt8/jQ==
X-Google-Smtp-Source: AGHT+IHp1XoYAtCO8bCKKGWm2SNmqXwx3EPn9ba4c3JEwFEqr77NQdEWX5MyqCCrqxnOZOExhp1B8g==
X-Received: by 2002:a05:6a00:1482:b0:706:5cd9:655d with SMTP id d2e1a72fcca58-70aaadd1023mr5573827b3a.22.1719869043565;
        Mon, 01 Jul 2024 14:24:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246ee8bsm6995788b3a.68.2024.07.01.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:24:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 08/11] hwmon: (amc6821) Drop unnecessary enum chips
Date: Mon,  1 Jul 2024 14:23:45 -0700
Message-Id: <20240701212348.1670617-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701212348.1670617-1-linux@roeck-us.net>
References: <20240701212348.1670617-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver only supports a single chip, so an enum
to determine the chip type is unnecessary. Drop it.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index fa9f64c743ff..028998d3bedf 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -36,8 +36,6 @@ module_param(pwminv, int, 0444);
 static int init = 1; /*Power-on initialization.*/
 module_param(init, int, 0444);
 
-enum chips { amc6821 };
-
 #define AMC6821_REG_DEV_ID		0x3D
 #define AMC6821_REG_COMP_ID		0x3E
 #define AMC6821_REG_CONF1		0x00
@@ -945,7 +943,7 @@ static int amc6821_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id amc6821_id[] = {
-	{ "amc6821", amc6821 },
+	{ "amc6821", 0 },
 	{ }
 };
 
@@ -954,7 +952,6 @@ MODULE_DEVICE_TABLE(i2c, amc6821_id);
 static const struct of_device_id __maybe_unused amc6821_of_match[] = {
 	{
 		.compatible = "ti,amc6821",
-		.data = (void *)amc6821,
 	},
 	{ }
 };
-- 
2.39.2


