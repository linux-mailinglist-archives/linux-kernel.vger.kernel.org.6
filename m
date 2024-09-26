Return-Path: <linux-kernel+bounces-340711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07259876F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99464280E98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021D514AD25;
	Thu, 26 Sep 2024 15:52:03 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7014F126;
	Thu, 26 Sep 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365922; cv=none; b=IdH8dvmtJ1gJzlkjCwJvV64m4FXMaa8BKwIQZgLqhDyk3Ig+eKfkLXeHhlez0iHWxspR3gz8DaKZzbeq87booVeTJ0BRiNW6i3a5uLCP0zL/KpQzKITP6fbUd1cwIIvdyIdytlmEXZ5O2lTN6KkhN4W4fa+z+MOAVHvqI6xCGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365922; c=relaxed/simple;
	bh=CxQY6aXsL1t8BJwX9KZmsKV/ZLGtIfokbmdRVVgDDYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sar97f6dE28KzvnXRIZPgUce/nBLgdqdZKxZjSdicUCnZ4V1KPBhuJQtKECDOyRxmpwN6eQEfUWR4z8+TnaqleIba1hDDQ4d238hR7Ftw/JlM7dZ2bTQoANGFbeAFwIv3n6E5PIwfFyTtU6cCqsGfUNApXEOeyaVWtMcWDwXTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4XDyl71svwzMQYm;
	Thu, 26 Sep 2024 15:51:47 +0000 (UTC)
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
Subject: [PATCH v6 0/3] Add support for SPI-NOR Macronix OTP
Date: Thu, 26 Sep 2024 17:51:24 +0200
Message-Id: <20240926155127.2450246-1-erezgeva@nwtime.org>
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

v2:
Improve description of mx25l12833f.
Add note about mx25l12833f using the same JEDEC ID as mx25l12805d.

v3:
Improve description.
Rename _nor_send_cmd() to spi_nor_send_cmd_internal().
Remove MX25L12833F specific changes.
Add reading SFDP to all Macronix chips.
Add support of reading OTP parameters from device tree.
Reorgenize patches to 2 SPI-NOR patches and 2 Macronix patches.
Testing with MX25L3233F using BeagleBone Black.
Test results are in "mtd: spi-nor: macronix: add manufacturer flags" patch.

v4:
Add DT bindings of new OTP parameters.
Test OTP with 'flash_otp_write' and 'flash_otp_lock'.
Fix macronix_nor_otp_lock() and macronix_nor_otp_is_locked(),
Macronix uses a single flag for all regions.

v5:
Fix DT binding errors.
Fix functions description of Macronix OTP functions.

v6:
Remove DT.
The patch contain the Macronix OTP functions.
But this patch seria do not contain any means to configure the OTP.
As a proper way to do it was not concluded!
I think we do need dynamic OTP for future use.

Erez Geva (3):
  mtd: spi-nor: core: make OTP configuration dynamic
  mtd: spi-nor: core: add generic functions
  mtd: spi-nor: macronix: add support for OTP

 drivers/mtd/spi-nor/core.c     | 134 +++++++++++++++++++-------
 drivers/mtd/spi-nor/core.h     |  29 +-----
 drivers/mtd/spi-nor/macronix.c | 167 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/otp.c      |   6 +-
 drivers/mtd/spi-nor/winbond.c  |   2 +-
 include/linux/mtd/spi-nor.h    |   9 ++
 6 files changed, 283 insertions(+), 64 deletions(-)

-- 
2.39.5


