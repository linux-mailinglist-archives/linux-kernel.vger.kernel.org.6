Return-Path: <linux-kernel+bounces-366880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDF99FBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9EAB21E81
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2461D63E8;
	Tue, 15 Oct 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="XK0KZ6uv"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237871D63C7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032885; cv=none; b=Ryu397D3gBsCe7zFqHLdGD+6aNG221cr5uZRpkZW0TgRos7cPVV9dbkkd3MLm/U7graJl5WGucpFjKFnaAjDelGCSxYSqGBdowXdY6x9MfskuHsI8s9agxe6DcuOuc0leIJFHvUbA2NF0kIYDOYVWy7jvQPoe2xEzpvzPp7KgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032885; c=relaxed/simple;
	bh=nMQRNViX6xJHcoQxaJF2VbYXBVB+6r++BfH93n/78n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXCRXHl/Oj+MpPG1NsKdyvgG2xZAOoFw3o7mHcG5QTSnKUA004VrG3gECbv462bd4sfOARpoTKC0pYK7e0ZHQTlFwxDCGAE4P/QbrPzHQdPS7XF28Q6nAJLJGambNZae7tNUM+HmyYG76T+cpDmyfUMlHSQidBGS82SUGIt2vCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=XK0KZ6uv; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF1DF2C03E8;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729032880;
	bh=2E1sJhOJl4dQGZR1QcnlyJlacaJ60TVeM1vYzwx+5Yo=;
	h=From:To:Cc:Subject:Date:From;
	b=XK0KZ6uvR+7ZYWA0PfoH1EYonEzg5raEHY+JVjLmq5szhx528nT5QLcexkYu4Ls2C
	 kxT4w0b8yoYbib+ZsiAXCRdEcWNCjnZvrw4sEtj/lvcrbWx49WxWVJGjQSNm/1veMn
	 DgEmly+xfG+H8joFogDwAu1RLeFPZte5Eew/1uPcQlLx217nm+XNP+JnzraQjVziwH
	 om95TKynCMmp5Jy2L4JMy9L+OCKTV2LpcxkH8OdJ1Rarrbm/J3WftUeHhw50FMd5P0
	 36Gs7PZr9XxDXVbIZYsPhylAUCeatWUtagnTEet778/PEhHJxflfJ7sKlJD6LS6mRY
	 oo+pTWsYR3n6g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670ef2b00000>; Wed, 16 Oct 2024 11:54:40 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9A6AF13ED7B;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 948D02820D4; Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	markus.stockhausen@gmx.de
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/3] Realtek SPI-NAND controller
Date: Wed, 16 Oct 2024 11:54:31 +1300
Message-ID: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670ef2b0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=63fhtx2pClmO-oMQzGgA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds support for the SPI-NAND flash controller on the RTL9300
family of SoCs.

There are 2 physical chip selects which are called SPI_MST_CS0 and SPI_MS=
T_CS1
in the datasheet. Via some pin-strapping these can be assigned to either =
the
SPI-NOR controller or the SPI-NAND controller. Which means you can end up=
 with
the following permutations

  SPI-Flash
  Boot Model SPI_MST_CS0 SPI_MST_CS1
  ---------- ----------- -----------
  NOR x1     NOR-CS0     X
  NOR x2     NOR-CS0     NOR-CS1
  NAND x1    NAND-CS0    X
  NAND x2    NAND-CS0    NAND-CS1
  NOR+NAND   NOR-CS0     NAND-CS0

Chris Packham (3):
  dt-bindings: spi: Add realtek,rtl9301-snand
  mips: dts: realtek: Add SPI NAND controller
  spi: spi-mem: Add Realtek SPI-NAND controller

 .../bindings/spi/realtek,rtl9301-snand.yaml   |  62 +++
 MAINTAINERS                                   |   6 +
 arch/mips/boot/dts/realtek/rtl930x.dtsi       |  13 +
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-realtek-rtl-snand.c           | 405 ++++++++++++++++++
 6 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9301=
-snand.yaml
 create mode 100644 drivers/spi/spi-realtek-rtl-snand.c

--=20
2.47.0


