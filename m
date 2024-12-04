Return-Path: <linux-kernel+bounces-430495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A49E319F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5AEB22041
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581326F30F;
	Wed,  4 Dec 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDMIfcw+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC11A35;
	Wed,  4 Dec 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280697; cv=none; b=ONq5ZnB4SjeHFAdwN8r6134pvblabPUFvaVCz1fz9+qnAANSmNWF6+jEiaGKeu9uSlAtQp2Z7DHWwVu207qCOOFY482eNOjeK5z3VbhUtviaIosXtQDfsJEYB6AY2svpPG2HlcTZEMJU71kbwW8Uew/3XiH70JznI+2c99XxJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280697; c=relaxed/simple;
	bh=6eNxp+TStRzVRQra/c6vP9luJl6UHfc7SHgB35Gd7MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlhaUigxZWMjBy2tPDd7RpOJV97hEmev0c5kN1d0Y71/lW0WqrCyYphhihKrY8hUnOB6xru55qU7T+NpZ6AvnhyiCAvS75E2wWiMK6Dk1Q/qKbUHW6nqCZZl9uoS3neKJJ/jpvWhe0s+G1MH3PVLrtoHwlvL5f1f4G8kUUT4HZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDMIfcw+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72577d3b026so2426838b3a.3;
        Tue, 03 Dec 2024 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280695; x=1733885495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jvg0Pg6QADAYKLQ79BSufZAM+8nSNvmFLMFGULrsTo=;
        b=eDMIfcw+6fD96VrorZifO7ehLFv+sw2+Bv3AhSdj6jaUVdN09Vwfe+pbu2QiXXdBom
         EtLwVyuXUFT1C0q/dmFLHMd3el6wyHHaZ7zp07F6xrudHFiyTTFPc2PnN3/5KZ5H5G1G
         pEo/DXqB9f+xtrifCryKQ1pv3xBxOQ4cO+MRn7e4xCSZvIIiBOv3odO8Fv32e7XzZd/s
         5retzLrce60NPCD0NiNfA2EZj1XAzlnrXbS/PPXCbjFIRkRg2qdjXVesO/EhVhadPDs9
         LOUv1RiL/i+pxq6AoZPGjBIxcdu5fR1+coZ61nrVck1w279jZsBd4uE0xS19hzt95MAu
         2yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280695; x=1733885495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Jvg0Pg6QADAYKLQ79BSufZAM+8nSNvmFLMFGULrsTo=;
        b=qSWGDpZ9EUP/hHL5GW6wopErLqzyBUBuW+5Hx0uKAViZpFtJsR8JlAmI+Xhd53pH7F
         kJLa/fUE3qXlmtUW0bwrOSOuGXiEl/wikRFRswc82hXPhhkEOPyhUqALpRFJW/BRDuFa
         fe7IiiyG1DWHD4Qb2suuEzkoXaWmkf1yGzpLFTo2mwcit5KW/FOhGAPnZOi29iaFZvdu
         2Lf6yjrsIqrs4g8TF9vSMIedaUJYBhiougw8NbmUxl/jQV2SDSs7VuY6b0PRxIP8eu6P
         26AOszCGSZF8noS7oDTPBfzFn5aqMDRxx/bnxWFVHWjZNIu6oCxbD/5UscakZxJ7uUXy
         iC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmE+d2TWBw8RWq8mflOg1zpHcyUntzhKhvZfjT9dfsMTcZvR2HxLoy3jt0/BmxrUPq6gypEW0Foj0o@vger.kernel.org, AJvYcCXnJtdO+RYTwk5uzYIm0IDhy3hlky7cZF7C+WB2oKTrG9ZkwUPaJ+W06g+3uSEmofz/i3UODcuq7MeVkeMT@vger.kernel.org
X-Gm-Message-State: AOJu0YxroQTUvht7yLlG5mQaTka4xj0HM3Sv8t7v7Y0Wv4msJA9wPafk
	0kg+pOcMiv0Mr+jxe3Kqr/TMoUoFIiupqtX8W5ihL1p0vff94luE8SS8VQ==
X-Gm-Gg: ASbGncumFrtJyHAJIJ56/ze4quDpcRXs7fYKtb2z+ynbJrphEGWpo3gv+0SZ4uf/Jqe
	UL3qov0jldlSsCfxgCoi9Lt1XACnTO7mxsYDvRzIhsTpvHm1R8q5/4Q+gBc6iMKO6TKjWz28TF3
	hhJABP9plQDRToEmRDxagPSwmB4ah2+1xD2jCvB1Eb4EkMJj6AKSr/bo2fkCb6mZzErrGc6iE7v
	25aEeGXmd1mUFap3k8sEAf5QogFvMcVHNR/bpPULDLDBPRTyDp08dwwer7TD6eMVva8l68PVQI1
	NLHdQF30QzuO3yM/Fb3xUTNQt7Cg2Z8qQAg=
X-Google-Smtp-Source: AGHT+IFttF0U1tgPdpYoD0r2lWciPazvOLOZROv9q651a+C0Xkr8gVLNpSk8YHK8DdvLZdQM5K8iYQ==
X-Received: by 2002:a05:6a00:2e25:b0:71e:4196:ddb2 with SMTP id d2e1a72fcca58-7257fa63975mr5867476b3a.9.1733280695424;
        Tue, 03 Dec 2024 18:51:35 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259114ec35sm74543b3a.126.2024.12.03.18.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:51:35 -0800 (PST)
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
Subject: [PATCH v10 0/2] Add support for nuvoton ma35 nand controller
Date: Wed,  4 Dec 2024 02:51:27 +0000
Message-Id: <20241204025129.150525-1-hpchen0nvt@gmail.com>
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
 .../nand/raw/nuvoton-ma35d1-nand-controller.c | 1032 +++++++++++++++++
 4 files changed, 1136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c

-- 
2.25.1


