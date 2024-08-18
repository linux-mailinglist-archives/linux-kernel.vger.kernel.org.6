Return-Path: <linux-kernel+bounces-291197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33129955EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57A5B20CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC414F9EA;
	Sun, 18 Aug 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXIZXxZA"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62ABE65;
	Sun, 18 Aug 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010394; cv=none; b=ehNbP/B9Okh/uaXd30putuo+naBLWMbvVw3s8Oj0Amfzc98c2j9vk5IaETTTRzLqHqJ+tMR65JAzNbM2b46YC+PorXSr9tJ+b3q5R6W5XFRehV9dAIrQ1uopN/nO//nds6P6x0kGpwLwtzm+rdbujNZZCWOMWpanEgKUrx9HgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010394; c=relaxed/simple;
	bh=BM6s41JmJedvLL14MtGESXr6sqHbSrqDLbRcRuIpuv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ofb0Fl+E+xfSzi7sUBaWB7Na+Xf0GX+VVfuvocJyG7xq/GRXNZX+iN56DQBYZ3J5YC2sIQP3qCPORviOa4j0o6XUHdxppd568HdmGTtQjIC6JvIc0AkV+yvhk2A/WJqRfqRsqterniQlzDUjZtXCNGMicaJ9WkMw3R+C3kJyzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXIZXxZA; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d2044b522so11154555ab.0;
        Sun, 18 Aug 2024 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010391; x=1724615191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfUXewH+ytwMkEyX9ENqJU8XAvuZqVcA2SZhF01FzF4=;
        b=ZXIZXxZAIXlHZeRBkJa2XGnHb5lbaEs6qNOu9ZpbeU5SEzw9N8B4HE9AgU82YEgQe5
         TMKU7yagdgfJAYba6cThyPBtLHy8ZCPfFkKYiIF4W/Uxv2yLCEJzCm/9RJKEgGbbwrdF
         FScZMJNecO+3M0jOFUdMnRy39dtOJJESwuZqDkpYtCSmrsRRF1F8Yvi1g32vpgEKIwIy
         qb3ONDTZBz6p9OMNiL8Og2qMr9w+rFRHeTfMdsM2XEXjbOCGfCuwkG/NZW7geRpbIPcN
         JaRekdhiwsfhhZbuqdyIWHWEYC7u5wQzGMTr2OfIB+DA8J6aW4Be4QvlqCyVhXfu8iba
         jk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010391; x=1724615191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfUXewH+ytwMkEyX9ENqJU8XAvuZqVcA2SZhF01FzF4=;
        b=QTmdTViiXJuBZ4gN3Gf6SP5Rux1tdHD8XkjBZLIKaYRmlwkhpEYar2yta1sgsMhT0o
         JSLcTClrKFPDyugrqA62jdKdxNlQcRZ2nM2qk1qa8vMa/A64NxsmDxIUnhmyn447414w
         LPe3S0fx/CPBGZ+8KTv44rq5vubNqhqate45tEXsW3pakQR3DNtElUZ8uCeXd4W4wjTB
         +zBi7WBJrmesU+F0JbJOMdE2JMiJFO6h3VlXCr454HNxB9LnpErqlJ5YvC5YNA28aOh9
         y/yAP5cPm5hg5RP28Ry5lK8a7p1BDhixmU3YTmM4aIa8wb6TOXAj1QgUxICnV5D6hV70
         hk4w==
X-Forwarded-Encrypted: i=1; AJvYcCVJNSdYDUsEtrZnDG6+VYHZ7qyr6usL5/xn81t/2OYUy3ubgXB9XyNVXp4VEFso9T3pEpzCGeIP6iZFM/38bEqI6zlSkbqt2oD+cShT
X-Gm-Message-State: AOJu0Yyj0RtYMxKcVdD3ALh9Q8S/iHxEr4C0UgbI+U2Z4u+in7Gw+sQg
	izDyAZg/2qi6zOzInZNDG3780widAg3HFPeSm2B4GFuW+fLKoLN5
X-Google-Smtp-Source: AGHT+IHjAsEgoTyuvpMtBKnx5TJrsUdt8c9ZknppeANkM5LmuLjzVUWBc/LGa13QLuQp4RT98srorQ==
X-Received: by 2002:a05:6e02:12e4:b0:39d:25d8:43a9 with SMTP id e9e14a558f8ab-39d26c346b7mr118634195ab.0.1724010391534;
        Sun, 18 Aug 2024 12:46:31 -0700 (PDT)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2020b9ed5bfsm37718635ad.274.2024.08.18.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 12:46:31 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com,
	chou.cosmo@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: [PATCH] hwmon: (pt5161l) Fix invalid temperature reading
Date: Mon, 19 Aug 2024 03:44:01 +0800
Message-Id: <20240818194401.172248-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature reading function was using a signed long for the ADC
code, which could lead to mishandling of invalid codes on 32-bit
platforms. This allowed out-of-range ADC codes to be incorrectly
interpreted as valid values and used in temperature calculations.

Change adc_code to u32 to ensure that invalid ADC codes are correctly
identified on all platforms.

Fixes: 1b2ca93cd059 ("hwmon: Add driver for Astera Labs PT5161L retimer")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 drivers/hwmon/pt5161l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c
index b0d58a26d499..46dd5c1723cf 100644
--- a/drivers/hwmon/pt5161l.c
+++ b/drivers/hwmon/pt5161l.c
@@ -427,7 +427,7 @@ static int pt5161l_read(struct device *dev, enum hwmon_sensor_types type,
 	struct pt5161l_data *data = dev_get_drvdata(dev);
 	int ret;
 	u8 buf[8];
-	long adc_code;
+	u32 adc_code;
 
 	switch (attr) {
 	case hwmon_temp_input:
-- 
2.34.1


