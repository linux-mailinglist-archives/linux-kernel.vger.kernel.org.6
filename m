Return-Path: <linux-kernel+bounces-391226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA89B840D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B2A1C21CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8951CF5FF;
	Thu, 31 Oct 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rCGZ/gDy"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DE19ABB4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405047; cv=none; b=eD+tQHJD18jSdEGoY0neQh28g8DbIOfU5eFdk9sn0gjmK9+Eaqycme6t2F4XNu64AZe8JvH6dvXQdl1NfIMf51XSGj6p+0FtTUaRoDgubMNxV9x6coOa/Wau139LK+iSkUlONRMCXNkAIh9WwyMysY8xHzWROAEAxuN6QsltL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405047; c=relaxed/simple;
	bh=DeB184f4TFb79JnTdhyFsFvAi0f64OZa5QexDRja9ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6PUOkx2KOW8h5g54r8Apda9KSpLuczNboDqEy7MciU2i37WmQKcF65xwrH0JuS4fi6Czoo0cw1p812nQRoLnWpQY5HFVvH8mmT0dRf0L85qf85jnGXQ0F6VSOvb/wnVxIFbqfNOe5QayuJKIitMyG3YkhB0ltdy3cfnl4Z4XdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rCGZ/gDy; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 26D5D2C012B;
	Fri,  1 Nov 2024 09:03:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730405033;
	bh=Y2rVrxEzenf5xW4+rr7fG8RlWJBZNxoLoDtBnZKILFw=;
	h=From:To:Cc:Subject:Date:From;
	b=rCGZ/gDyeyHK0KGrod56Bhs/2FYIqUPQ0umGZEihgzt64oVlDbZlXBv0AsUKNRVqa
	 3fmsfqJ5zclDE1krPa1rnacRhbqhiru1wF/93OOiBaHk6iQu8+bh7lxjgQTfUkmgFI
	 vwr3U2WN3bK0S2CoVqVPN2rN1We2nPaeHGmlCWxhVp5IYfMnw3C46r7yr462Jn3Gvl
	 XvvMcnJVis8GfPhSVwRTWEppDCTyGIEqbYftfoyjx+7GSoR2ksSFnnjXumqe12bK1L
	 FoUV9BOj4ZzVR/f678Al7pOazMFcuitMAK8T9/ykDlfbSzBGFq1HnJvnVdWCkSjTd9
	 ZyY1+sRqiOH/Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6723e2a80000>; Fri, 01 Nov 2024 09:03:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D308B13EE32;
	Fri,  1 Nov 2024 09:03:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id CB832280964; Fri,  1 Nov 2024 09:03:52 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	sre@kernel.org,
	tsbogend@alpha.franken.de
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 0/7] RTL9300 support for reboot and i2c
Date: Fri,  1 Nov 2024 09:03:43 +1300
Message-ID: <20241031200350.274945-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6723e2a8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=Ecff0wTpLh6po_UDYMwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The first two patches have already been applied by Sebastian (thanks),
they're just included for context. At Lee's request I've split the
binding patch so the mfd change can go via a different tree to the i2c
one. As the mfd binding has a $ref to the i2c binding I've put the i2c
patch first. They should apply cleanly but various automated checkers
might complain until they land in the same tree. The mips dts and i2c
driver itself haven't changed since v6 of this series.

--
2.46.1

Chris Packham (7):
  dt-bindings: reset: syscon-reboot: Add reg property
  power: reset: syscon-reboot: Accept reg property
  dt-bindings: i2c: Add Realtek RTL I2C Controller
  dt-bindings: mfd: Add Realtek RTL9300 switch peripherals
  mips: dts: realtek: Add syscon-reboot node
  mips: dts: realtek: Add I2C controllers
  i2c: Add driver for the RTL9300 I2C controller

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  69 +++
 .../bindings/mfd/realtek,rtl9301-switch.yaml  | 114 +++++
 .../bindings/power/reset/syscon-reboot.yaml   |  11 +-
 MAINTAINERS                                   |   7 +
 .../cameo-rtl9302c-2x-rtl8224-2xge.dts        |   2 +-
 arch/mips/boot/dts/realtek/rtl9302c.dtsi      |  15 +
 arch/mips/boot/dts/realtek/rtl930x.dtsi       |  29 ++
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-rtl9300.c              | 425 ++++++++++++++++++
 drivers/power/reset/syscon-reboot.c           |   3 +-
 11 files changed, 683 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/realtek,rtl9301=
-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,rtl9301=
-switch.yaml
 create mode 100644 arch/mips/boot/dts/realtek/rtl9302c.dtsi
 create mode 100644 drivers/i2c/busses/i2c-rtl9300.c

--=20
2.47.0


