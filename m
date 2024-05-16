Return-Path: <linux-kernel+bounces-180817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC88C737F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F122E1F211C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833A143720;
	Thu, 16 May 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R1e4yjAW"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB38142E8A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850621; cv=none; b=cZ/XrvgTfkyQVC0HArbHqCzYluhFjoRkZCsQxGkqHuIdyLuaQW6IWE0qBaQy5yB0UnBFiNX2sOrvddJzcFQI+rAbqtflykBqjhgX+VP+/Grpf8t4hrvXvhgeDQme/t2bGRRPW9AVpj5k9mxGaUeJk9W7bnpfx/4NpQOZXGj+9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850621; c=relaxed/simple;
	bh=PUdOanXyPmYs8t1SAQ5CGzSg30ESic3akwCJ1g2YgYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tiINYHrFY1u531UWlhqsqb6p7j4235qxTxBNhc3ULgkOQQCo8+M3BawlRGrYVAp+kCRkCX+sFLzmLuQU9KKE7XW0P/a1GPvHWAz7GrvX3UjXJM8rhpP5kOhVOPBw1wqq/Ne6MJp4M5lJMDrJ8HMAkKTBPnlpz8uNo2y6ooYjIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R1e4yjAW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B564E2000E;
	Thu, 16 May 2024 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715850617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NMV5f3FFSpaQuc9jD0+gvxaq7aY9BJmILcDh48MT9I8=;
	b=R1e4yjAWnRlhnQQiYh4l+wXZsD7GNc34u/Qo89wR2TJ6wIZ7SY3BhnXqfkMKnb7O+7mjAa
	q1X863b3zfHbqIuXTU2crR2Fp5SNYu+NeeDYliIHM4ChGaJAfXvOhSjphiv/UA7PQTFLLZ
	o6pUyrHA+r9F/sCd34boyXHFfZ3iTIz5wrUgiUmNA6iZZLYFpo5qQEc5fXmdEUimL1uoMH
	PV8Hc3uR8NRglmjhF3ms6xPFnKVfHWlyoBq/DBItu0aMlnmrd8CNFmCFyyEhhqUKHx6X4a
	E6REp79DOVxFBOpnCuhWW6GuXW0NHtEF/2D4GlgNeo1zDzMLAvxvaTDIHsj5Og==
Date: Thu, 16 May 2024 11:10:16 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for v6.10-rc1
Message-ID: <20240516111016.10d8abc4@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Linus,

This is the MTD PR for v6.10-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.10

for you to fetch changes up to 552c9380f98fc47950870ef0935f94cf3acec087:

  Merge tag 'nand/for-6.10' into mtd/next (2024-05-16 10:55:36 +0200)

----------------------------------------------------------------
* MTD

Simon Glass wanted to support binman's output properties in order to
check their validity using the binding checks and proposed changes with
the missing properties as well as a binman compatible.

Krzysztof Kozlowski on his side shared a new yaml for describing
Samsung's OneNAND interface.

The interface with NVMEM has also been slightly improved/fixed,
especially now that OTP are also supported in the NAND subsystem.

Along with these changes, small cleanups have also been contributed
around ID tables, structure sizes, arithmetic checks and comments.

* Raw NAND subsystem

Two small fixes, one in the Hynix vendor code for properly returning an
error which might have been ignored and another in the Davinci driver to
properly synchronize the controller with the gpio domain.

* SPI NOR subsystem

SPI NOR now uses div_u64() instead of div64_u64() in places where the
divisor is 32 bits. Many 32 bit architectures can optimize this variant
better than a full 64 bit divide.

----------------------------------------------------------------
Aapo Vienamo (2):
      mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp=
_nvmem_add()
      mtd: core: Don't fail mtd_otp_nvmem_add() if OTP is unsupported

Andy Shevchenko (1):
      mtd: core: Align comment with an action in mtd_otp_nvmem_add()

Bastien Curutchet (1):
      mtd: rawnand: davinci: Add dummy read after sending command

Denis Arefev (1):
      mtd: partitions: redboot: Added conversion of operands to a larger ty=
pe

Erick Archer (1):
      mtd: maps: sa1100-flash: Prefer struct_size over open coded arithmetic

Krzysztof Kozlowski (2):
      dt-bindings: mtd: Add Samsung S5Pv210 OneNAND
      mtd: mchp23k256: drop unneeded MODULE_ALIAS

Maxim Korotkov (1):
      mtd: rawnand: hynix: fixed typo

Michael Walle (1):
      mtd: spi-nor: replace unnecessary div64_u64() with div_u64()

Miquel Raynal (2):
      Merge tag 'spi-nor/for-6.10' into mtd/next
      Merge tag 'nand/for-6.10' into mtd/next

Simon Glass (2):
      dt-bindings: mtd: fixed-partitions: Add alignment properties
      dt-bindings: mtd: fixed-partition: Add binman compatibles

 Documentation/devicetree/bindings/mtd/partitions/binman.yaml    | 53 +++++=
++++++++++++++++
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 72 +++++=
++++++++++++++++++++++++
 .../devicetree/bindings/mtd/samsung,s5pv210-onenand.yaml        | 65 +++++=
+++++++++++++++++++++
 MAINTAINERS                                                     |  5 ++
 drivers/mtd/devices/mchp23k256.c                                |  1 -
 drivers/mtd/maps/sa1100-flash.c                                 |  6 +--
 drivers/mtd/mtdcore.c                                           |  9 +++-
 drivers/mtd/nand/raw/davinci_nand.c                             |  5 +-
 drivers/mtd/nand/raw/nand_hynix.c                               |  2 +-
 drivers/mtd/parsers/redboot.c                                   |  2 +-
 drivers/mtd/spi-nor/core.c                                      |  4 +-
 11 files changed, 212 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman=
yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung,s5pv210-o=
nenand.yaml

