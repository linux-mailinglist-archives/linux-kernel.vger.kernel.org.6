Return-Path: <linux-kernel+bounces-434304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F649E649E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F269818854F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1FA188906;
	Fri,  6 Dec 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHG+t9ch"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49A1CA94;
	Fri,  6 Dec 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454806; cv=none; b=YpB2Tz/BqzdBraaHyEzWoMhd0GFLrXlTniKU6qmAE19XOlhvSWir4PEGBQNu/Mo2snhe9mhpccL9lA/Orq6d848BNatWyjDKzhu1cc/Qgs0juB0E7yE9p0Da31JF0hJ8/Ed39Ly8ixkp//8ssLFvm/16mZCebDIlUfLQRntsjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454806; c=relaxed/simple;
	bh=Joighory19Iblj7Uie5NE/QYRYwk2lMN0L+ZXWc3PY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qRAgFdmUgn62Mclv7jxMptwGvcxG/CzDVVtWi96ry9WSGmJUyJ2LGXaRxs4TXQxVMnE8jvWBu2ZoU9kyInmBnqIuArSp5yG5CFp/JdBWuiYZsGqQTR8D8TuedHo/Ork9coYLXlvjGw+DrOe8ILTHj5OmPrFFxtI4yPVO3fXD+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHG+t9ch; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e1742d0dso1511900b3a.0;
        Thu, 05 Dec 2024 19:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733454804; x=1734059604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt0SCTkvn+YR9UJenhf6zDr8e0FUj6bUNlIsy8Vy6XY=;
        b=RHG+t9chJ6llDd5oFv82iFKQpkEHJhT7JwkP06A84GEjmOB8mgP4E0JMnjytsijv8o
         DUJLzxif0SGpY6R1Q4fgiCIrVQ3njgu6izRsqvqKgDvBK7AAOiTf5u8J8F9VmCo2w4vh
         TRT4k4CC/l3AOPKRLv2ja9EJ3NC4ftEL5Vncezzu1M8HthJBxJmU1VkM/LUqoY3pAmZH
         LC/GgK7YgmmNwp9CTSZALTqYuEwuYRVSe4urjNgUz/fkwac000rIwR0LlwER+ghXfEML
         txZ46Y7O9FLgS+TOtfTVPh79Epbize4Si8fINiqbhr7p6zz1VldHRXXYWWIcDwt+gzjt
         BWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733454804; x=1734059604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt0SCTkvn+YR9UJenhf6zDr8e0FUj6bUNlIsy8Vy6XY=;
        b=G8bIjVRZsrMy/1VKhnM/07n8kxkFOcr/+EBlJKAYhGeGGuBwLJ+HLz+K/ZsHSvEZL2
         GyE6P25+Ot9GSHZtC5EJbi5X7YID1YsqX4Da6lGzK5Q87skBRRg4s/xL3KXVs2WGjmL9
         bG3RzcuoxvT/iWd9KGj13SGdSNV4aGJcHVYqHzE7KLGbe3HnnDKz41rxsdyIOXm1rj0E
         j4UM3IvowjLhAN0537Y0rSosDEDNPynfJV1IzWFNB+pVQZD8oZ0T6pkF3h28ffFWY3Xd
         SYejBbLxqpHwKE4x940bM1vLPIkyuQ1skDL5mZrZFrF6QFzA0dwr91UgeJk1kISGQwQM
         QLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZr69ATtdhCx4mFj1FLuqzlOel3/TN0dThJWLaGjOk2fsBALumN9lkm7vvigseibgQ986o1xP8i3OZ@vger.kernel.org, AJvYcCWjGluVmRgqhj7eHdTeyHkksFh9jUofJPzmIrIVQM1+t06AZMn6BPYU7f0fNpli7lwWZO5m4MfQXvNf9VPK@vger.kernel.org
X-Gm-Message-State: AOJu0YyVq4f145CHAB9nLu0cSYypgDx6uZc8PPJQGY0p4x3pHojYsRBP
	6VDTi08Tj+TOqUhdPZP99yTx8XKyosp6aVXsltBDJIMXhLjVTaTI
X-Gm-Gg: ASbGncvdyrmdz16H3d/W4V54HjV97a3NubH3icvm2C01KUSATsl4uyLsUsMYvegDqUr
	VVVmgU1kDAqjdZdDudmmKvtSH5D2EPeHu3QhqeqM3k0s7hetoOaZOP11YPHdLfajxiByEgHEWI4
	YHPaZqRRSxcPfD4V3yl4Mn57jtIK1X8SwpV55Oe6JPNfK8YjPsJMuwNovya4lBgGGct9rTUb8em
	/rChr5Ds9wePR29a2NwaOTcwCBTHt6Bn1H0E1v1LGHcR3f8Iy9Rs5hyDUnwo6EUdif03H2ojeyT
	JJG/nMh0dAI/WY2KDuUsxGEpt9MqGtTtuOk=
X-Google-Smtp-Source: AGHT+IF7SIhnyAIa2s6klAC+ixAZnJb7XNMJ0xYjIoh2x56kOXx7Y1GiufB+JlFrmxcvjwEpoM/fmg==
X-Received: by 2002:a05:6a00:14d2:b0:71e:a3:935b with SMTP id d2e1a72fcca58-725b820eac5mr2862137b3a.25.1733454804100;
        Thu, 05 Dec 2024 19:13:24 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e9003sm1966791b3a.44.2024.12.05.19.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 19:13:23 -0800 (PST)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nikita.shubin@maquefel.me,
	arnd@arndb.de,
	vkoul@kernel.org,
	esben@geanix.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v11 0/2] Add support for nuvoton ma35 nand controller
Date: Fri,  6 Dec 2024 03:13:16 +0000
Message-Id: <20241206031318.156152-1-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the mtd nand driver for the nuvoton ma35 ARMv8 SoC.
It includes DT binding documentation and the ma35 mtd nand driver.

v11:
  - Update ma35d1 mtd nand driver
    - Fix warnings and checks use --strict.

v10:
  - Update ma35d1 mtd nand driver
    - Add unsupported write page handling.

v9:
  - Update ma35d1 mtd nand driver
    - Remove NAND_NO_SUBPAGE_WRITE flag.
    - Remove of_get_property().
    - Add ecc.write_subpage and ecc.read_subpage.

v8:
  - Update ma35d1 mtd nand driver
    - Rename to nuvoton-ma35d1-nand-controller.c.
    - Use switch case instead of if else.
    - Move some parameters to be set during initialization.
    - Fix the ecc.read_page return value issue.
    - Add enable/disable ECC engine before and after reading/writing the page.
    - Return IRQ_NONE if (isr & INT_DMA) == 0.
    - Move the HW ECC related settings to ON_HOST.
    - Move hw_init() to probe.

v7:
  - Update nuvoton,ma35d1-nand.yaml
    - Remove required 'nand-ecc-step-size' and 'nand-ecc-strength'.
    - Add 'reg' for chip select.
  - Update ma35d1 mtd nand driver
    - Update space and comments style.
    - Add chip select setting from DT.
    - Add switch case which supports various ECC configurations.
    - Set reset before NAND controller enable.

v6:
  - Update ma35d1 mtd nand driver
    - Remove extra blank lines and add comments.

v5:
  - Update ma35d1 mtd nand driver
    - Remove unnecessary definitions and comments.
    - Modified DMA API call sequence.
    - Move the ECC check out of the interrupt handler.
      Check it after reading a page.

v4:
  - Update nuvoton,ma35d1-nand.yaml
    - rename 'nuvoton,ma35d1-nand' to 'nuvoton,ma35d1-nand-controller'.
  - Update ma35d1 mtd nand driver
    - Rewrite the NAND driver using the exec_op API.

v3:
  - Update ma35d1 mtd nand driver
    - Release IRQ handler.
    - Remove unused functions.
    - Remove '.owner'.

v2:
  - Update nuvoton,ma35d1-nand.yaml
    - Adjust the order and remove any unnecessary items.
    - Add 'nand-ecc-step-size' and 'nand-ecc-strength' to the required list.
  - Update ma35d1 mtd nand driver
    - Fix coding style.
    - Use 'devm_clk_get' instead of 'of_clk_get'.
    - Use 'dev_err_probe' instead of 'dev_err'.
    - Remove 'pr_info' and 'of_match_ptr'.
    - Remove 'module_init' and 'module_exit'.


Hui-Ping Chen (2):
  dt-bindings: mtd: nuvoton,ma35d1-nand: add new bindings
  mtd: rawnand: nuvoton: add new driver for the Nuvoton MA35 SoC

 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     |   95 ++
 drivers/mtd/nand/raw/Kconfig                  |    8 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 .../nand/raw/nuvoton-ma35d1-nand-controller.c | 1029 +++++++++++++++++
 4 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c

-- 
2.25.1


