Return-Path: <linux-kernel+bounces-290729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DE9557E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5746D1C2139B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116414BFB0;
	Sat, 17 Aug 2024 12:48:42 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E62256E;
	Sat, 17 Aug 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898921; cv=none; b=bjbbBXdXnsYbJpYDR8Im5CVROJff7aRqEOxZ78M1oW3+mMZvgM83/r13N+ezvU1S4KaDtkB2LOC2ChH9eexl5L/lRpQBX6N1ynSmpE+ugduN/FGG7BGG1j8FuCMcXsTrNin7kWqrfD5PH0zdkfjhiLLcc/AsTHw8tjtpwDCDFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898921; c=relaxed/simple;
	bh=drbvFiAknhUQ6rzxBuKf7VCM9GLrY3PfjfFK1BVe9Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Drd6yWm1zfWgXvpwbPfizOxo0B0m1KcEA0ftKP/RBjSPY2Tg3qtT5VGbAlFYTyoaLajy2Dv2Uyyt7GBhFWCQoyueogglmt9nRQtqS54GCtFbt6PSJlSoZwO6T1yD5mjoNRrRNlqeWgxrt9tbhATMnn8sI1lnkF5ltAn+n79hDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip1f10f85d.dynamic.kabel-deutschland.de [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WmJQn06kjzMQgm;
	Sat, 17 Aug 2024 12:42:08 +0000 (UTC)
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
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v3 0/4] Add support for SPI-NOR Macronix OTP
Date: Sat, 17 Aug 2024 14:41:36 +0200
Message-Id: <20240817124140.800637-1-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
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

TODO:
- Test OTP with 'flash_otp_write' and 'flash_otp_lock'
- Question: Do we need documentations on new DT OTP parameters?

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

Erez Geva (4):
  mtd: spi-nor: core: add manufacturer flags
  mtd: spi-nor: core: add generic functions
  mtd: spi-nor: macronix: add support for OTP
  mtd: spi-nor: macronix: add manufacturer flags

 drivers/mtd/spi-nor/core.c     | 166 ++++++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h     |  34 ++----
 drivers/mtd/spi-nor/macronix.c | 186 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/otp.c      |   6 +-
 drivers/mtd/spi-nor/winbond.c  |   2 +-
 include/linux/mtd/spi-nor.h    |  10 ++
 6 files changed, 336 insertions(+), 68 deletions(-)

-- 
2.39.2


