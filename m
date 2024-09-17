Return-Path: <linux-kernel+bounces-331570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54297AE57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7BD28655D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149815D5B6;
	Tue, 17 Sep 2024 09:56:58 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8215B14F;
	Tue, 17 Sep 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567017; cv=none; b=fMxAjQCjyvLRAhRSDbsLVuItQRq538SVlxeDZbIGjcJkzj7b8l9kQy0bT3FK39snUU7rIBi2S//+9BLMX/JFqJImGUl7ABRbQGiWTNqkneUxRYNEtr0cLyWGa3LqunI5O9DPQjSbkGi/JeafMtZG5I1SiofL0Cod8aSWeXEcs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567017; c=relaxed/simple;
	bh=1kTlPr8Zi6N6v2aW1yLO4ZxloudFm42INysOKZoQ81Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BzMc4z5G8Cm1Tv18eC1S0Zrwut05qAfvjWdcmoBT+2lFSDFD5DeVhQzfeJ/8vL8N/qVLTqL8WaXslSldWFnHYUhpTxwi+dDP0B9Gn11JTjqgEZL1Ltg8JXy0szC3fUGsoOg629Rv1nW8yO7llTSMF7yYrPMebz3wYiK2bDtg07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4X7H8P0bxYzMR3Y;
	Tue, 17 Sep 2024 09:50:28 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v4 0/5] Add support for SPI-NOR Macronix OTP
Date: Tue, 17 Sep 2024 11:49:51 +0200
Message-Id: <20240917094956.437078-1-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add support for SPI-NOR Macronix OTP.
And add MX25L12833F with OTP.

v2:
Improve description of mx25l12833f.
Add note about mx25l12833f using the same JEDEC ID as mx25l12805d.

v3:
Improve description.
Rename _nor_send_cmd() to spi_nor_send_cmd_internal()
Remove MX25L12833F specific changes.
Add reading SFDP to all Macronix chips.
Add support of reading OTP parameters from device tree.
Reorgenize patches to 2 SPI-NOR patches and 2 Macronix patches
Testing with MX25L3233F using BeagleBone Black.
Test results are in "mtd: spi-nor: macronix: add manufacturer flags" patch

v4:
Add DT bindings of new OTP parameters
Test OTP with 'flash_otp_write' and 'flash_otp_lock'
Fix macronix_nor_otp_lock() and macronix_nor_otp_is_locked(),
Macronix uses a single flag for all regions.

Erez Geva (5):
  mtd: spi-nor: core: add manufacturer flags
  mtd: spi-nor: core: add generic functions
  dt-bindings: mtd: spi-nor: add OTP parameters
  mtd: spi-nor: macronix: add support for OTP
  mtd: spi-nor: macronix: add manufacturer flags

 .../bindings/mtd/jedec,spi-nor.yaml           |  37 ++++
 drivers/mtd/spi-nor/core.c                    | 166 +++++++++++++----
 drivers/mtd/spi-nor/core.h                    |  34 +---
 drivers/mtd/spi-nor/macronix.c                | 168 ++++++++++++++++++
 drivers/mtd/spi-nor/otp.c                     |   6 +-
 drivers/mtd/spi-nor/winbond.c                 |   2 +-
 include/linux/mtd/spi-nor.h                   |   9 +
 7 files changed, 354 insertions(+), 68 deletions(-)

-- 
2.39.5


