Return-Path: <linux-kernel+bounces-371391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022129A3A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFB3B224BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D5201039;
	Fri, 18 Oct 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F47xTLbP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F3201020
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245100; cv=none; b=Z1QboQhbKgfYM5HYszD1B/q+99OoSMmCxF3Z6Thh2VHotbwDR8+b5y2jFFjsOS+XXBN7eXfeoxwIJeYggT7KjF/gCvKxOVsjjFbDKv4kyI4lInBjzE4sYF834gQ6ZvlJplbGLbgs4zCoQawnC8s50a7ScTC5aF4FdKsFDoXTWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245100; c=relaxed/simple;
	bh=zB2nL6YlcN2H6tu7PPX7gZOJOCDXq4EG7fQ8xmS8XNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o4QTkmQ9g1KAnNlxFsghpndM5vpRWxR2dNuz010/4vJLZnv+5d2x3Jiz+UL3yVX2qRQy9wOpIB0rBk2MsUoj7lBP1/KIgNoZr1dGucx/r4/Dx7dym2tnCiqIlnni0cI7oW8s7JSixHo7bM8AFhaPRwpg0TgDM7F3bhklAG8YNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F47xTLbP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so23725411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729245097; x=1729849897; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDyS0J1pd4vIGVt6v9Jag9N30v2NScqXZqalv3DOEP4=;
        b=F47xTLbP1q+TNo786+yxJdiSZvWY54SKz5EatYrV0x4TWnyR+xXDhQWD7fdJxJoQUG
         8bat5Tz6qHmDuthm1NN/KkkPO9gt55+WbrlT9AEcqk6PU/8hjU9B4vqWAkEAAriZYEe5
         jktC7ytqK193mZ80tUMPv1AslT19qlbOXCRW98IP1jap+Er8L2eiYx9ICVN+xLcBzZHy
         4UD5kc6LEcQQ1LiGz87NN3Q9SDOU6kd0PT0nnJpC3ibXEVOFoibiqZcwRd32dKb8tqfr
         uJ0GdAKmnckrulDR6PsxDD/4dR9LPYj6E7zveukmQqg86poXfmGG3xX+gVx5ujDlzxF7
         Xtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245097; x=1729849897;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDyS0J1pd4vIGVt6v9Jag9N30v2NScqXZqalv3DOEP4=;
        b=M++YV4FtRGEvSL6wCb5WXBgraO2ASYNkecxKCAJS3vOAWpXho64Svljjg55MmBXrmc
         I4BKdH4uMun8ZrCucPoKvEu6Yko0lubtnI6Uzc2Z1oobaLsKaXYtKPVbaj6KafftDuIQ
         FoBuXzxT1CqBtmzjs1XieJVXbT8WoM9XZp/+iG+/9t6TDrZoEY0BtIcjyAN78Z1Qvdsk
         56pDdhgs2xGWVKJ8YNw7pI70EaNnT1daE6f04zef1bLkgZm42QLO0kprmDyj78Mgra4B
         GK3I7dH+B/NqIKwhVDBog3irjbaRlSVoEjx9tbEYpLzUf+oCMLVNDjGTiSFKr/HvooWH
         cUaA==
X-Forwarded-Encrypted: i=1; AJvYcCWCYopOhtj+01/fvTX4OtAVTLUpWQqq+q7O9AlP33yjDBmqwOpqx17qZIq33UMNvzGT8rQ4VLh1No3kOIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+wmtUY8jys1wCVINr7KXho8mSyts0c2A8Zt7si2EvyTDmluO
	DFKq3SWJd6f+KcHXWsSW6neXvgArdRNB3a8OiGoKWAbwcuQ2SyZg
X-Google-Smtp-Source: AGHT+IEhJfxVayyxRoNDSoLjmVu8Qhwdgii53gm5tk06UmrkUVlirSIR13xwqIUHTLhXDvf349Bsqg==
X-Received: by 2002:a05:6512:39cc:b0:539:948a:aadb with SMTP id 2adb3069b0e04-53a154460f0mr1356938e87.42.1729245096567;
        Fri, 18 Oct 2024 02:51:36 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15204653sm177458e87.210.2024.10.18.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:51:34 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 18 Oct 2024 11:51:19 +0200
Subject: [PATCH] mtd: spi-nor: atmel: add at25sf321b entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-spi-nor-v1-1-d725bfb701ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJYvEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3eKCTN28/CLdlGQjSzNLi5TURIM0JaDqgqLUtMwKsEnRsbW1ADN
 XJvVZAAAA
X-Change-ID: 20241018-spi-nor-dc29698dea0f
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=zB2nL6YlcN2H6tu7PPX7gZOJOCDXq4EG7fQ8xmS8XNM=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnEi+gq2DdE829Xn7ZKAUDpSaaJbhLGC+nBT7/+
 OYlzom++BWJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZxIvoAAKCRCIgE5vWV1S
 MnhUEADCqk2yjn11uEhZ0+drX8Era5Fzmf0Q8O93uSndh9JPBmRGUX3aYBiaWbRQvEt/EKAWEAl
 204lB094Q82kaUDR32UQuYwcVKOC1ukElBhPY4cxrNXfHA1n5cE1LGJ0Y6HpkWl6ftUwixHoWiY
 SRE+gTQK64Tb8Yi/laUQmaJ1mr2pNtDI7AomIvkbqyRX9UlQq7UEaFAMAFw2VoDWx6hBm/EtNAL
 aGGoiLskIk1b38meAzy4vsth+PYf4bOpiza+sHqznw4QAMqi1lxkzAyg06uat5MUiFi0g1FLoiB
 uSl+uWPLhyr0aEe0FrFtD1IEF1PFEjncmVWa1SXIEKltHTsKDHxxXmQ1OKO+k6y2dZcQNOoUomd
 cCnX+M3r732ggmlK+8zLvv2IZNCUjs9fZdaJu41p0bX5EVk2AXhY79D+d4e5+XQ19mIre/YRSJP
 P7VeMznsKeyRLiB0MolGK+nXnHrhrCOGoHpUWlA9FNdcMMRH/u7USuQ+atJXYVHD2i1Ux8Zhr/f
 +3SE/bTmtYQ+EP651TEW4o7nEcXuphHk+7Rm5t3xyCw38NTgz3MOaybGX7e4PUuBgWJs6pfUR8C
 jOVzrLEEs83Bs9bnLmfwBzoMkhzel/kmtaFUr9ttDAiHQdw3x6XpnEo2xIMMx6M2w7YO2364mlx
 MRUVS2B/9cNI2qQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add entry for the at25sf321b 32Mbit SPI flash which is able to provide
SFDP information.

Link:
https://www.renesas.com/en/document/dst/at25sf321b-datasheet?r=1608806

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/mtd/spi-nor/atmel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a07b7c61f46b117311b24ab695038f..e635559711a4b402d23d49da93efc15e6be571dd 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -238,6 +238,12 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &at25fs_nor_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x87, 0x01),
+		.name = "at25sf321b",
+		.size = SZ_4M,
+		.flags = SPI_NOR_HAS_LOCK,
+		.no_sfdp_flags = SECT_4K,
 	},
 };
 

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241018-spi-nor-dc29698dea0f

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


