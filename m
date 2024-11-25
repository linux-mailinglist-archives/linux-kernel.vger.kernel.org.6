Return-Path: <linux-kernel+bounces-420462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E09D7B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11351B21FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B915666D;
	Mon, 25 Nov 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b20ncJuu"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F12C470;
	Mon, 25 Nov 2024 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512332; cv=none; b=qJZamRqaKMJpoVOWln19V5Jv4KtB5+91QV/RomvsmpBCY9hFLGMMrg/8E1ZM71pGmifoPgajRo6mdHVmgelUjLT9P/ULASo4xEXnae6mXNBvZnavy9sqmW89oaM+MxGS1nXZ+2WY3k0innVkjy9rEc7axRUbn3gL7UePUC59+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512332; c=relaxed/simple;
	bh=X6LD3FmHc+u3nY+0KyYGuWCF4ESD8ARpzF8l7Gk/SLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQuzCralwlU/UneEuw42EStHJK05663AiIIAKt+pDFFYtkYXWtPyT8iZsIbfQDr+NwaDbCKGP7U0Oc5+J4CeSaVme4wYMPdxQIMXenlvNtveLoGhSltVm/YYP3JFQ1H/oKijkhz/ZA/zXB0hyGJ57OaUfHzi8x1vFv4wzdNyKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b20ncJuu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea32bd689eso548843b6e.1;
        Sun, 24 Nov 2024 21:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732512330; x=1733117130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NWNdeipp9Lz+yCgnatMjLdoGegxlT8lsdQAdmeK6GM=;
        b=b20ncJuuWkMsFfY8sRFdzKhcc7AxRXU4EkX7+IcaR6WNZbbpoGlpuOPNzmxHhmkr0W
         DajqkRX4nqGEWd9GvHa1pbiVBL36JYzg06Jq0Z8P4H7iIv8X1b+ZfT4SCZOv3Eo+5Mqx
         KqzVM1wyT5L7mmTh/0ayjrxO49Dz8u/8e2+VrJ1TQYfSHw+ey+VZ58ecOBjPVHnYqZEs
         ERjP+ndEGVpA10yzkrQy9Xa+5PtrmW6I3kHx/1EoFp4quTqOTDZD8rKTFY2RCZbxK97B
         VpcrGbrEoDDSoYjRBcpyLX1keLeiZL6AMnypRa+QhWhvjbW8SH1VwhqN55Ayg8R6xVeP
         /I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732512330; x=1733117130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NWNdeipp9Lz+yCgnatMjLdoGegxlT8lsdQAdmeK6GM=;
        b=NDQry+ZBAyQOPtbmS93SJWFbQ8OB1o+vNBypdmCgaLNVWUDX0EGuV4ZhdEmMai+n3a
         skal8pdc5aCaiQtH6+iqE32BZnNdIDBrLEQ9q2Q8kOfbUdbGC3F0x7OR4zie2g8okPJs
         N5pLnadV30D3zFUpUgQ5gQJn36Qur3jgxNOMjyQYqKdt9CmLoarNKXI9WUNlTYpvPt6a
         wEHyB/U/bDvdRmPzEXSnWEa9S/VcrY8iTuOhtTB9/uKOtbHQwDYnx0x2DI64bG485dWF
         /Pwa4SXiy7KzasvLeLwdD/2kToF14N6BPBXpGsZpocbeHCIDMC5B1m0n0eL+oPlD4Hxy
         lH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlB7uhnITaViCQi2Ow7xQxfrptCm/k6XXlXZ9+RdEPWGJyxxIEBswt7bPJYhTYBveSpE8kwPcLnkAz@vger.kernel.org, AJvYcCXjA9WjPoi3+ydJKbuZ41FNptSOv13qjlvUs/wIL/3tP6n4yitpNRY+qQxOJzEfHuKkE38ogihgdqSBm/oc@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcE7LYc/0BB8yqDqkSb17wIhWJyBFAKavXsXEUelJU8NJJ+fT
	ITPFbJvF1U6iNBtsUTNCMjTiXgOTcp51ovqKLD7mEVv8IKCaerhu
X-Gm-Gg: ASbGncuZIbzLTFAnsUIAXpxrl54LpNFZ48kneg4ejrcWQNMZgkeUB9gC0M13b/8RfF0
	Dl0UoeJ/BKwjC3R1NRdSona8R1JHl5zdAKJScaW7XqmBYlQW4HYpTrrJK/wqjqM0dE2Tee0Q0eR
	Dilq/NZiZRno+KJbB4cGd27XtA998NqDg7nl9IfduRy2cuZgYiAiUyumT8+QrKE794keZ1wwGC3
	ToOitbQZ4W125LwtnKvqtpSbEaptCWGsE87tUVCTJM3IivFh4NfneBL4WxqhwQmMHDNUfd6kT5V
	2DN6klUwULulRPhb60vCE/+BX03qRR7ynlY=
X-Google-Smtp-Source: AGHT+IEThhx0hkE8eNOImQOECxAu4miExvbPkYIPbmiK1xCB8nCLXsvTsOlU0MGcVv6gP4Op5+TxkA==
X-Received: by 2002:a05:6808:14c7:b0:3e5:c7f8:ad7d with SMTP id 5614622812f47-3e915b57082mr10486001b6e.39.1732512330089;
        Sun, 24 Nov 2024 21:25:30 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e2490sm5698557a12.31.2024.11.24.21.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 21:25:29 -0800 (PST)
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
Subject: [PATCH v9 0/2] Add support for nuvoton ma35 nand controller
Date: Mon, 25 Nov 2024 05:25:22 +0000
Message-Id: <20241125052524.135362-1-hpchen0nvt@gmail.com>
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
 .../nand/raw/nuvoton-ma35d1-nand-controller.c | 1024 +++++++++++++++++
 4 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c

-- 
2.25.1


