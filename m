Return-Path: <linux-kernel+bounces-233997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BB91C090
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856D2282F73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CB1BF32E;
	Fri, 28 Jun 2024 14:11:59 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200161BE85F;
	Fri, 28 Jun 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583919; cv=none; b=AQRazHUAcc+lhiYaR4c25gsMa5VDcBP/ccYUEVqWfZQr0vT80Ijo4fMBRuYa3T998Lvlbm7IbQRtww9xnlWyKUeWJbgyG0vO4BqJgpLeB5zr1ksXILDNwx+/jicv5k1Bjt1rH9dV3pZI6ouhOeU/E2sRqZQCQhD6I2OJO/x4tQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583919; c=relaxed/simple;
	bh=Ukl6IswPq9u8vcIcLC9yjMxtDPey4eGMS6U5jtPmtWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=He2I2EZqfjtvUilMqjdjuPxmskugC60/9c3RXPglygg2UB6T5GZVNudApp9FQCwZ8vyEWKF1uDeM3vT22WkPgj3IlurBLEsOgJaWgQkOqbyjVdeJlrNP+jpuhx0WspmC3O6D9jnOyU/Tl8i0jwUebjdPryTzbCopL5U2cA/txWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4W9ccK4ZHBzMQKt;
	Fri, 28 Jun 2024 14:04:01 +0000 (UTC)
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
Subject: [PATCH 0/4] Add support for SPI-NOR Macronix OTP
Date: Fri, 28 Jun 2024 16:03:24 +0200
Message-Id: <20240628140328.279792-1-erezgeva@nwtime.org>
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
And add mx25l12833f with OTP.

Erez Geva (4):
  Add generic functions for accessing the SPI chip.
  Add support for SPI-NOR Macronix OTP.
  dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
  Add Macronix SPI-NOR mx25l12833f with OTP.

 .../bindings/mtd/jedec,spi-nor.yaml           |   2 +-
 drivers/mtd/spi-nor/core.c                    | 131 ++++++++----
 drivers/mtd/spi-nor/core.h                    |  27 +--
 drivers/mtd/spi-nor/macronix.c                | 190 ++++++++++++++++++
 include/linux/mtd/spi-nor.h                   |  10 +
 5 files changed, 301 insertions(+), 59 deletions(-)

-- 
2.39.2


