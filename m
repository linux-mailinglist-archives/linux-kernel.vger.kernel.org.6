Return-Path: <linux-kernel+bounces-370849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F19A32D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9160B1C23AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6956815D5D9;
	Fri, 18 Oct 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay6CekcU"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCB14F136;
	Fri, 18 Oct 2024 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218326; cv=none; b=AqLB2np/TTiu30Ibpq51+5AL/6/2WszFA/mXEtgCM4mB+jmj1X+H5L+zN6A4mXaWvgedRGtX5qM23oBlX9PpAs5G9mgGTywzS19ZW3PjpOlqOVIqzxGobdx8QxyrGROY8QPZh5m4NmyPpsDdNLLsDWHNbWN7rF0GNHzp5qsCA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218326; c=relaxed/simple;
	bh=9eFB4eo+R3pbvL09ypllV2aS6MYbIhkXU0JKz51BjVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hTsj2FQc13orPgkS5xrP4tQaCJnxfzyh/qObhj2C+oDvY3E6HLJPr07pvDA3GGRy9Rt/PSzG+dzWeWugZMnvVwNtBgP7iWC79aUoe7+zf3AYcPOs1ONP/SL78dV1APbIutrnWYwrv6fdunNlSAxJ0Yd5QAWFTDL+bCYs/N6TAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay6CekcU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c1324be8easo2076704a12.1;
        Thu, 17 Oct 2024 19:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729218324; x=1729823124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNblylQP7D+aqyHspg/cSjG3VPPyHXAL3CdZxZWFSSo=;
        b=Ay6CekcUtR3wlEpEQ7Irv6vCNRThpuhsdl9ng2uslVjJD75pFpLJXQGoDYHvrUIH16
         7MXbC5sAcTpJvHXFfHCwLaTNF0IKskr/0ff50X0xgkzhBvmsUgY8TcsdqBaFLkkgAwJd
         Ku4XQ7BY5tVD8AYqCe5zOQOgqUmfrfc1iYbQ7ZWGehMmziJILUToBSLj3d1yPvmjnPmf
         1mLEZIZdzO1uwux/QndZw06CyPZESoRW84QHjWdVCRP/G2T5S+luXMQlo65SMRKBQgqx
         GG24UV22/A8I2dfHY5qdQP8cmU7nXkh9MIC74bZ8zP4mV+2ydV6j1S6ABCyz6Y/1xR8Y
         89TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729218324; x=1729823124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNblylQP7D+aqyHspg/cSjG3VPPyHXAL3CdZxZWFSSo=;
        b=kyax89p91UULl5Cw73m0tmhdsCZbCaDBk8rNmJpOVnQy/9/MEjo0QECYcl8dbhKrol
         qN8WgqYW+H5tG5IAJMlgf2wq+nZ3fKeo6aG3CQP8qY9PqgBdrsXoMP2B+jwlLauEH6Br
         AAdv9bTa4v7qMk9IaFOZdlqpJOXvGs/TO/mHzGKz8OXy372Ylqx8a+qAPCuHcKpoPJtI
         mOD6HCvc5L83sxdEUpbNK7O60LUXxum2300vhFC2zlU/cokOd7O00VbNRQAEVZiq/7W2
         1WTQHGlo+sXxLSegaX2785x7ZneiReZw9iRWrFaEKgMhUnRNgJ7oGuCakf/Et5rqQBVZ
         hu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWewU7mYHw0fdxD8iBBd1Po6Tg51+lo4iFG2bcaJH3KHKje4ay3psw4zDO+yJCGXxOOsZ8pDRLO48RyUX6f@vger.kernel.org, AJvYcCXuvf2E0oLlzg1yYOC91x2Vmqfv6QpH9sCqqS1XrhN5mW0X72uDJRHK1nrOtXaCiqp7dcrT3cACIq8G@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQHyEk7gAEr1aVm0sAkQIIJcWkV2g+rU+UCohrkvlo3Q2i1oM
	KcfBrHgn4MvxzxptpMpFB5yEi/Bw6S9k42bZEsEJlzMH1SECm0ad
X-Google-Smtp-Source: AGHT+IEvQGzO6HN+yhyDUkA6o0/8ovLGioAEj+x/bDhJg51Dnqtq6vMhGDJpCo0s0E4SM2crpz9vaQ==
X-Received: by 2002:a05:6a21:1349:b0:1d8:f97e:b402 with SMTP id adf61e73a8af0-1d92ca59dc0mr1256422637.13.1729218324426;
        Thu, 17 Oct 2024 19:25:24 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34ac42bsm361736b3a.197.2024.10.17.19.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:25:24 -0700 (PDT)
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
Subject: [PATCH v7 0/2] Add support for nuvoton ma35 nand controller
Date: Fri, 18 Oct 2024 02:25:17 +0000
Message-Id: <20241018022519.721914-1-hpchen0nvt@gmail.com>
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

 .../bindings/mtd/nuvoton,ma35d1-nand.yaml     |  95 ++
 drivers/mtd/nand/raw/Kconfig                  |   8 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c    | 919 ++++++++++++++++++
 4 files changed, 1023 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c

-- 
2.25.1


