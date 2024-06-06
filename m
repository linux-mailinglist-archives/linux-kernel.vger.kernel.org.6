Return-Path: <linux-kernel+bounces-204854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AAE8FF43D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D8F1F25B27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30719925B;
	Thu,  6 Jun 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDIS5rxm"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DB1991A8;
	Thu,  6 Jun 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697113; cv=none; b=cgz5viwW1odIgRiuJdCe3AN1/DxPQiJoNNu3rqT1yZX7N0CbgIVj3pNwKYbehbTnd9TPRiC/V66+1jFtI+W3vL0vPI4fEERVfzgUmElA/9gagj7zbJhDF0+tZPtZZQPvja+xWqkVCd72GXRteMDdp9q2Y0jKLvp6gPhSBZfMdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697113; c=relaxed/simple;
	bh=M8/CndtovtNZjCnSSKAAn9sDv4W6EwehhscWhv21waI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y9VdxJLEAkeWhzrNqHhhgR+t+EnIp0pKDJOZB9ApfrmSWH3D2uYZb6AfUI85sMrkE3qjzLoR6AMeVLolNd5tH4+ms/QyzOQrNnpYqGozKqg84rxvMiEfaP5J7YvK2soHrPv5HVhLN+bp3LZCI5GGwt7lWy+EHuglg3sJDzNJ5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDIS5rxm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so1034666a91.0;
        Thu, 06 Jun 2024 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717697111; x=1718301911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qqFGxZu8ztkmGXgHXrrzq8s99pAzOJgpzc98UOmJrt0=;
        b=gDIS5rxm2yu068VE8CgxrBEFqpL3ZpQJJVch4ACwtwgUIaAioVovNTwyG0BKwjrrYr
         cDJALxqRtpmNm72BkMC/h9ebpyFyrI+ZpL458ZY38UahjOxD9hNFI7R0UiBBIrNDpHdn
         HnLBYyJ2MubsFdCevfD/d7jtnGM+M41I0a60Sq9+qj1d/TycyB+Am37WxXg+NUxIEw+i
         gOdW+Z/t8pSxrFv8YQ4+HnOf6BAJpxPmRII5OTZHJr3JoCy6U2vHkL7q/KcbVsYo5XJ2
         2/E5FudErxaSuxCVuC4gbyNGZ39m8zXhBZK68SAgKWTGPQk3IKzfj3wNSbsjIzRSOlPR
         09Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697111; x=1718301911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqFGxZu8ztkmGXgHXrrzq8s99pAzOJgpzc98UOmJrt0=;
        b=jgxn6evbzxqjOMTBxhVb/r7pCxWeY3oaVpsjrp5rcI9cGjRMhizeatPQ05v/8qDKw/
         m/nQtrmkAKy/8mNG0CxngW5WUGfHiyatnSa2GljuD2FUwNo4cE0kRB+dQIJ8LiMAOlN/
         cZHucQBwUwFNYd4TgZFfd6XpEhgU+oC44HDV1iY/IE0zyDyQ26yKWUdIisbtWJO9MRCn
         0e3yRTozDQdbXXQmtiLXKg/Nk5EOKUhR1gs400cywmBtdDzuiskB6zJSkFMySauwE5ZZ
         tzcLM7xnpf8ZgLaju/rjm3jPuyt2GmjisJGJxG8dizIwF1LXB+clkqv9kL6xWMbKWk1P
         W10g==
X-Forwarded-Encrypted: i=1; AJvYcCVDa/gOePt5a1/3idsLW7bTBXvgs3GxaYqq6StVQtkLgQI/ikTOsly3CuOKdFy40MPynzUH3OPehl0AtOA3QvhHLk6PrNBaoyxAQr3X9Bps0PGDuQwaClnZ3YwZsgmw6x+Dl9xDIgwHnuo=
X-Gm-Message-State: AOJu0Yxt/6zBdmGYGb3FEDnKeNQtSvpVLzNBOWoibyQxLC0l+AsDj7+g
	YH4c7DHLLeq4iPAEuqSLfW4pgjFJ/1J3sn8Nf6Az5u49n6w1BqcW
X-Google-Smtp-Source: AGHT+IE5A0nf2n9F8l4i5CYuyQzTnGQSlckHO+heltL9kMPPAQX5ntF7cJsqltDvC68OmQfN/1cHgw==
X-Received: by 2002:a17:90b:4f83:b0:2bd:ad66:5b14 with SMTP id 98e67ed59e1d1-2c2bcc058d6mr260340a91.25.1717697110560;
        Thu, 06 Jun 2024 11:05:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d2936sm3870629a91.53.2024.06.06.11.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:05:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
Date: Thu,  6 Jun 2024 11:05:07 -0700
Message-Id: <20240606180507.3332237-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

0-day complains:

drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16

Fix by using a __le16 typed variable as parameter to le16_to_cpu().

Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/cros_ec_hwmon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 41f268fa8260..f586987c3502 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -26,12 +26,13 @@ struct cros_ec_hwmon_priv {
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
 {
 	int ret;
+	__le16 __speed;
 
-	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, speed);
+	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &__speed);
 	if (ret < 0)
 		return ret;
 
-	*speed = le16_to_cpu(*speed);
+	*speed = le16_to_cpu(__speed);
 	return 0;
 }
 
-- 
2.39.2


