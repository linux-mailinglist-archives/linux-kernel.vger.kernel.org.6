Return-Path: <linux-kernel+bounces-189712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F78CF3F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 12:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD1C1F21BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DD9B676;
	Sun, 26 May 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnXk24sW"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048912CA2;
	Sun, 26 May 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716719543; cv=none; b=EwWN8YUQqFsuRuaAdv9NuG52dzTvoqcnvICi/zHZhVXrGenYr8DMlj+dtNzTnyxSsHZmpTmpCEGaJScnyzECDbWyQ7NjNXAuED2akI4RwDgpCOotpgEzfU5qMEFICRebo7X57JvigqwR5Hs9T0WU6bALAMKXeYTLWonT9GuPsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716719543; c=relaxed/simple;
	bh=cM+3m9Vlx+Li31AKKrxvOFnkw6WwfSo8Tpsy25CvwDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyPwI97XTB5aB+6ScWmz9T7GT1rfQfQWd8hmEt2wdVtPHyw9haZgY7fJoDlncMtn19ro4jwelmUmFT4W9wqiz51NZKYlkP+UfQsGbBmZF0xfKHiQLg8nYOv+PDfUYP5u8oHw72pWOEbICdhQLyR/yYXvWkMn6wVU8BUVgJO0KdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnXk24sW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42108822e3cso11278895e9.0;
        Sun, 26 May 2024 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716719540; x=1717324340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHGSRtBgYEwf5XeC+NvJ0ZSO87WeoCCUBD7D/Iu4rNY=;
        b=gnXk24sW1XT2Uj81K/iZ1ZEJne7faC7Ca5l6srSru1g8H7M7+ZwgXxtnKqU4hbNSqj
         zDF1TqrfvNOePEZhYT9aBDFzGDF6hUu1PrnAT7nM6FMC3e7+Bz/Mns3J//N0+Dx/IoVg
         HevzBT+p3cu8pW3bbF7ftGpIOpICXmyHYZDpKaAkR0cvAzhuj/RTRdg+1Ct5GsxGtr8K
         stIYcP34DOA2qUrsol2LgPJCEUxc57KvcxqA5F6sXgOP3I2WRchCO52uWf+r3/w4zEI+
         6jcATQCysroyrPGbR350Touu2PqVWrmYwGUlrYZ9zcdyVL7eGWtsZVSkANXyrDHWur5w
         8rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716719540; x=1717324340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHGSRtBgYEwf5XeC+NvJ0ZSO87WeoCCUBD7D/Iu4rNY=;
        b=btVzTPBt0mv0asvAaylm3Td/4ZE7zDOKbGtBzco5CTqo5Trxr5vb4aZQMsRfzI/ya+
         My10Zgygbk4xTqhqzYdjfNK8SJQAkUctQTZ+yvGO9MQDsMUjZIt5QVhrWs1vk9urQgPV
         bmpeTpXxPLLanEs0X+U1cvLVe5vKsCxPX40RqiQLBpZ1GwiK7PfJ2I/a7es5hjAaEk3x
         X0SpTAd6EBnnTqHvriAL+LenkFbBnOoi7c11Q9//ws0/BYnuXnpk+WRh4EQiAmjMV+wG
         dVtbJJ5F4RwWPB68oPl+k9XpuEU+rNg1PJR9bTdURyXGCWd8qhdIKx1aLvKQ6YsyFQj7
         +Brw==
X-Forwarded-Encrypted: i=1; AJvYcCXsiAFZwmczcZ4jB1/NQ5iNxbHl7lu6EFbC3QLsUIPxp9ynslmE3r1Uyb+YgW7I61kyVPkxcLr1WhiSKpI2fEoCzGiTwFbNBrK6I5ZojjNy2yqlRfMHUwyxytP+w8z2FhUjDXd8vyv+9mLz
X-Gm-Message-State: AOJu0Yyi0nDps2SSU+AUCsMz1DuI9gsPocbOpnR/Yryl64z7Te6nYY+J
	KLYUA/a1NYELxBq6WXgx3lWlOGqLpMy5IBgiXO+MPjzgqpe8l8yb
X-Google-Smtp-Source: AGHT+IH1/zyQQAW2UnztwvjH4KyCVYCCt/wjYrQb76m6DkbN6LiKHaAMA5t5MhdTV9ctjn9Kheh06A==
X-Received: by 2002:a05:600c:4449:b0:41b:f4e1:381b with SMTP id 5b1f17b1804b1-421015a60b9mr93206105e9.2.1716719540014;
        Sun, 26 May 2024 03:32:20 -0700 (PDT)
Received: from 4728cded2e8d.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad638sm106565865e9.29.2024.05.26.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 03:32:19 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: dan.carpenter@linaro.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH] crypto: atmel-sha204a - fix negated return value
Date: Sun, 26 May 2024 10:31:28 +0000
Message-Id: <20240526103128.14703-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix negated variable return value.

Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-crypto/34cd4179-090e-479d-b459-8d0d35dd327d@moroto.mountain/
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-sha204a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 24ffdf505023..2034f6031518 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -106,7 +106,7 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 
 	if (cmd.data[0] == 0xff) {
 		dev_err(&client->dev, "failed, device not ready\n");
-		return -ret;
+		return -EINVAL;
 	}
 
 	memcpy(otp, cmd.data+1, 4);
-- 
2.39.2


