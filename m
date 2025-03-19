Return-Path: <linux-kernel+bounces-567671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0BA688E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2834B8872F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E14253B71;
	Wed, 19 Mar 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERa7AVC1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77EF2580F2;
	Wed, 19 Mar 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377690; cv=none; b=arcyrVNeoLZNvxN7mAelfSAYf8VYX81KXY+DaqOgPklQKYu/PUhFR64fQg6bXdst35ZbE/JmycBRvPE1Wb8Mud33zVu2Fbenw+F44npcNW+2s4e2eX/bGt04Ra+L7kl4Ul+vg8CQoAfYCqGC7iZ4SwdtBeHaLWul76fA8kGEtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377690; c=relaxed/simple;
	bh=ScfM3+8+EJIZU5+Lu3q329qWBAmdoTXsh4O0GU3+m3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6w8yxkjiyixg5XnXbTFvY6G8mket3XYwSXsOnh25dGUE94Mb7O9jniFrcCEItrNovWWXWp5bqP+PwnENufdeKCyQJKA2AmRAIiTeVpBwQWczdrnwLwbwssDgBvjxvv0k7qsiwy4iJiwferEHiFHcAJY2NGUTvgykl/xyWX5k+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERa7AVC1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so107973595ad.1;
        Wed, 19 Mar 2025 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742377688; x=1742982488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAPU6J8SAHBswu5KPS/clGE6GclHv6M2l/Gea+md2MI=;
        b=ERa7AVC1fvc0Q+1fX+OGIgC0xSRxunXGFJcjdb8sH62Ldw02nb27xmr0MVDSkdiWgV
         t/Kvyoo4lc7dltZA/50OscwCYnKnnOqBwfGX8BjcEB4OvWM6nS1CyK/g3tipp+noCfw+
         +P90dDaqD0kBcDH2ikyhgRtBXx922kU3Uxmyxaj4sbwHReW/wU2aeMnxy/qHOF91tob3
         GU2zdlVtXpTMEpgSbVw0NzWytPyfS+vAvTXI+17EiDWbqQcFwuYwlgg9gO16+H7ijmYi
         88oHSBR4USHRlYT8ik6Band/VgzeBxbntz18RXo4lu/htwNrb9JVMOKNZ6eP/IOfkAkS
         6VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377688; x=1742982488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAPU6J8SAHBswu5KPS/clGE6GclHv6M2l/Gea+md2MI=;
        b=LRQNflx6YdECT8+xFd/TZwlFnLPvd9X4U6tp1E4hbIN8Goak/3m0r+HyFeNCQhSWHd
         ynK2eTNw5KeIO9QHgm38hMmgF1oQFmK/7drdKkS/S9kRR7EaJem53hZzW+SYIWz3i6/t
         vGVkO3C/RRMdJWnzTaByAlfgi9ijMJyelLY6D7KPClJtxskW0Ndmqp82NhBm3wCrErWd
         VLlBHbUnbg5aZeFE5Rvr2HEIh6aA96z87PXc2Z6zmFK2t1c4L6jKO2faKrOuNKcc05Yr
         qZx25tX8PcLlt9jINlQTCAmV4P8IRsoFNDxWnRIWGb+1FNS2bP6zG1Pm/hJulJm9SiLj
         xp6w==
X-Forwarded-Encrypted: i=1; AJvYcCV/F58C994SpGP21vR4CZdLomHExo2KAXunvccAQ8/l7+lYopZJMQTPkN1N8X2USCmbtBks30LSOXm8@vger.kernel.org, AJvYcCV9oxBLKaKQ28HntbQ/UbZMOobtWsUAhFmtbII7Sio2kLs6260xGdilNft9OZUA4xvKAjI4CGlgN5BjFwrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTmpRdHQfdX2nvdgPouVdAKEK9z/24Xz6P3ifoRn0VOu5lNhU
	F7aKAve9JrNZZL7VfRL0AvcNrT6Xb6PCE2ay1BJTqPGcYgGCzS/d0kIzYg==
X-Gm-Gg: ASbGncuTNgzOVFyuhhVHMDm9LhHjfSoGHOU7ilU7j82JVwODl9Oq/qUjnFKE7+yEcyv
	wVLy1B8y/0rQpjLovDRizra4xgi0kVdxib27t0BxZ+2pf76DWBhaVETgOjAY9VwbEDH8ItzLrVL
	pr5zchZk9oWyZBTmUu6wukZc4r0RmS7tJfKIz7nB36ACN0BUNpbNO84eUVHd21bEMMsIEAlU3O8
	CNpUDrPpIpgg6/kc7P3zf94rOIv1uwSDrTQGIN6FK+OHVsHVeOfllQKjPtDQGQ+t1iMmz/nsW16
	NXiQZcKetnOH1HlA1hF6msrSUcGN8cKkOVJSrt0rTraE7kppVHtp/IUmiG/NBlZhIksYl/0olKa
	pcyZN+/dFSj+CnW4X2nAsP9PVClJGURxC5iaCTQ==
X-Google-Smtp-Source: AGHT+IFwkCGCNCZFHxXbmd2VPJkFvQEuo4pfqxBeGBsinv3TRNIY+NeDJRgxareZ7PlpncQXBtU1wQ==
X-Received: by 2002:a17:902:d2cc:b0:223:33cb:335f with SMTP id d9443c01a7336-2264980c709mr32228935ad.3.1742377687888;
        Wed, 19 Mar 2025 02:48:07 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589bccsm1103483a91.11.2025.03.19.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:48:07 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 19 Mar 2025 18:47:44 +0900
Subject: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
In-Reply-To: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bacem Daassi <Bacem.Daassi@infineon.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742377674; l=1784;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=ScfM3+8+EJIZU5+Lu3q329qWBAmdoTXsh4O0GU3+m3o=;
 b=DIk+3FpIU2asCn6le4wKHaawnoXw5LZpljxg+BE5i1X19lXI0j/ynzbqbU9cWWjzai5dqTp9S
 dboNWFSfmjgA28hk3MPHZcUKUHwe13V4P5xFxpWREkvnVbm4g044gaD
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

There are infineon flashes [1] that require 8 dummy cycles for the
1-1-1 Read ID command. Since the command is not covered by JESD216
or any other standard, get the number of dummy cycles from DT and use
them to correctly identify the flash.

Link: https://www.infineon.com/dgdl/Infineon-CYRS17B512_512_MB_64_MB_SERIAL_NOR_FLASH_SPI_QSPI_3-DataSheet-v07_00-EN.pdf?fileId=8ac78c8c8fc2dd9c01900eee733d45f3 [1]
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi-nor/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 19eb98bd68210f41acd716635c02a8936678a385..6452ae6eecee3325b52cdcc2cc9703355951e0db 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -16,6 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
@@ -2011,9 +2013,14 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 {
 	const struct flash_info *info;
 	u8 *id = nor->bouncebuf;
+	u32 ndummy = 0;
 	int ret;
 
-	ret = spi_nor_read_id(nor, 0, 0, id, nor->reg_proto);
+	if (!of_property_read_u32(nor->dev->of_node, "rdid-dummy-ncycles",
+				  &ndummy))
+		ndummy /= BITS_PER_BYTE;
+
+	ret = spi_nor_read_id(nor, 0, ndummy, id, nor->reg_proto);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
 		return ERR_PTR(ret);

-- 
2.34.1


