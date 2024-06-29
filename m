Return-Path: <linux-kernel+bounces-234892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134C91CC1F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A941F222F0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70B4503B;
	Sat, 29 Jun 2024 10:39:44 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17B2BAE2;
	Sat, 29 Jun 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719657584; cv=none; b=diL0yoQ/g5F1Qk2cgUU1Xvn/z7ca2jIzN66XvsMUYAYrc8h9Nzw98aeeCz+vZSCWxrcC/DUkCj6+8HzENkb2NqXkXSD0dK/yNuoKB32x0ns2xYzrVtICwLLwQGAD7/QGIO1jhaU5Vj/t8LGNysc1VYEhqccLRU/vIeIOeVK3/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719657584; c=relaxed/simple;
	bh=a+/X4hYZlHutXcjKIwemfVIvmVRq0OkutqOQqU8VHts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FqyCzk4hqiIbdhPcOOWyjQoAeOgvlHRWMrmmK3JUlvviGzxndPFAqpZmRx2Mv5SVU9NV9TyIsywTTQFBkPGusWqkGjL5YjsN7aYmicJ2srtlLE1cCbPudjSwXMrDjJ0MEPBoxQrosGKZD+PpmxrtpGZE5nbzxP42Dnf8DZGrHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (unknown [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WB81s03wwzMQKt;
	Sat, 29 Jun 2024 10:39:28 +0000 (UTC)
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
Subject: [PATCH v2 0/4] Add support for SPI-NOR Macronix OTP
Date: Sat, 29 Jun 2024 12:39:09 +0200
Message-Id: <20240629103914.161530-1-erezgeva@nwtime.org>
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

v2:
Improve description of mx25l12833f.
Add note about mx25l12833f using the same JEDEC ID as mx25l12805d.

Erez Geva (4):
  Add generic functions for accessing the SPI-NOR chip.
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


