Return-Path: <linux-kernel+bounces-319003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13E96F661
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEFE286A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E341CFEDE;
	Fri,  6 Sep 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z93iMVIc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599A1CF7C6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631921; cv=none; b=XGinu791xCbCwNayddQ4I0UlBTi8RQilyJ3Ec12rP3kQ0mgsWD1PkTQ9KfnXrF2+DvYX09sSA1wgL8tebcwD+ym5gBvzon9HWWWSJGLlePqvLPr/wOsjeBQsLiyUDQ2+kXkvD4zUCDUUU47Vqut1gDAMM5KUGx+TkZR36nbB6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631921; c=relaxed/simple;
	bh=6sqz9dlyLdZwgv1/yD96Tuz4ORVTks5lKbjFrdaC1Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmbbW2YLCTezK7wAFyIsA0OAxevT1Dh0OJnkf8dvw+2nMNMaKEmvqSy19MRh0VHTCDp/Ed9k8SFG3CvunfTM6zqpUH52rDGeSgMMXXCuoq/b0faVKNz1TdG1Kmd5aLOxnPTijQQWc4NLOID+FBS9my3BLw9LFsKPJPGn53AHgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z93iMVIc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c88128315so2767945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725631917; x=1726236717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rY/cX1sDvoecl4zde6aOZK+bbTd9Imu5xSH9g5UFhc=;
        b=Z93iMVIc4JwCvnjChfdM1I0SNaS5/8M5/UbO9+JVDkYiW+oUyjOepy0Zvfm2aMlJ+S
         GBXQrFYa4LXziVr8wAe3g9k/Fk7WjzL+nz3vvk8PY7m5HMFKt4tapAmdH1ze4NHhDc8+
         FjY6QCaYPMYD/ZqFhHDEDe5hsm2R3s9YYun4HXOdnWeEWYSejQgEkEez6uZyWVISKsNx
         xI9sVah3JdPzKr8Qctfjx0CipFbhzsP6D3oqbPEeBoX8rPyxBCNih6G75XzfN5MVPGZe
         /n2DWIqwf5cUjFGb3Q6fIwVlm5i8OjVa8Dat8snPv2XNQh1+0TeKJaL37xk3kI2ZrnKr
         +O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631917; x=1726236717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rY/cX1sDvoecl4zde6aOZK+bbTd9Imu5xSH9g5UFhc=;
        b=Odtb+tggi9YfY3Zxf6hy+rpOsj6iZIdYVOeEAe3FIERue2TQJo8/rs5mBdUWhy6hKX
         yQv9a3TFL0vwHoOSDksrQdE2O1HZUa+rGwBOVepOTxfWqEDcYvYznfWdiYFVh3YT2pTW
         YvJGI1TZb06s0oOhoqyHs9KbMQIuPtpPvvuw3Fj7Uesh5b7W8A1PzqoN08LArjW1QkUX
         yEs1lzB8HUVsJv6CqSfKWctBA+nE07H9gl7bdZKw81torKZ2aOs5cyS6+sK2wuLAw03j
         yZSq45fqThh3Ylxe1M2qtEkMINz6DUXqqc3WP7Wck8LzN2iSRB7Jb7jGjqaUAd4l0Uen
         tEHg==
X-Forwarded-Encrypted: i=1; AJvYcCW9twq//X4rCYG7ML4ZjoEDXJ5G1c1o/I6cPyFapPl8eIxhHRE5Os6qIXIlxdGzOu4HetfNwvjkt72cHvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Wub/Cb8RAkgbfygRWRNAHAZmdG1+VPwv0/t8CYewILUAeu6F
	8gaKxsueIyVMFsk5gwNYE3GQMX5V/vlIOG648nIrMcIl3KGGh8CoKKpwr75YhpU=
X-Google-Smtp-Source: AGHT+IHpOzGpKPuOL6dQOzBi5tIh74QXi4DaoUpkrKoCEVjzrlOufKnMJau2UTAFPhNh4vvSlkRZgw==
X-Received: by 2002:a05:6000:1f83:b0:374:c8d9:9079 with SMTP id ffacd0b85a97d-3788964f9a8mr1054952f8f.6.1725631917238;
        Fri, 06 Sep 2024 07:11:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789162b5c4sm18072f8f.54.2024.09.06.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:11:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org,
	krzk@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH GIT PULL] w1: ds2482: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri,  6 Sep 2024 16:11:33 +0200
Message-ID: <20240906141135.72080-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

This driver doesn't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240725160909.326143-2-u.kleine-koenig@baylibre.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Hi Greg,

I have only one patch for you in my queue.

Best regards,
Krzysztof

 drivers/w1/masters/ds2482.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index b2d76c1784bd..a2ecbb863c57 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -541,8 +541,8 @@ static void ds2482_remove(struct i2c_client *client)
  * Driver data (common to all clients)
  */
 static const struct i2c_device_id ds2482_id[] = {
-	{ "ds2482", 0 },
-	{ "ds2484", 0 },
+	{ "ds2482" },
+	{ "ds2484" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds2482_id);
-- 
2.43.0


