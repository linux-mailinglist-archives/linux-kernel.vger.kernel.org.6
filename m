Return-Path: <linux-kernel+bounces-217580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84990B1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE941F2A068
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEE1A38E0;
	Mon, 17 Jun 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="q8djABTX"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95F1A2FCD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631334; cv=none; b=oyGqYqX77h4wCFwKxgwba792UWkM2BeVg/9yJGRHB/u/dRfRJekHyNh6epcQ99LtTDrL2ZiPj160UC/siyOaWoo4ZnyogIH2dgjts8N/Kqfc0vWyd2lKuhI3snqxTyHAaBVEsudf2yeHBK2iMODe6LM7fJd5kAZkkI57bjMgJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631334; c=relaxed/simple;
	bh=gvXWnPNP81RFJbxt9dfPpNSQPXb3YqrDs9qsTrp0k7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GselQ5PNH0wQHO96iqZJez+uDhafN4HL1zt5Jy6D/CHLgiS1pJZE4MhJm1JMaZTz/+zxkS504q1MGOPOhZ5j8BfxPe6Oo/KIIjTx/IUdC/UhZXo4d7EAMxWTyXJulRhAMdmDDoRVR+mD+huJrFz3iO0YBcPKk0dwO6NPtP0Nn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=q8djABTX; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3D810100003;
	Mon, 17 Jun 2024 16:35:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3D810100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718631322;
	bh=8FxyRaKeWJqwgkCh0J/SmA262Y/mTap6YRFjgrEtVGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=q8djABTXUS7lmXQBL3d/t9Su5FRjJ5E/+T7yzdlvPQ4RUGUHTaZEYGl3Y9YuOZGXP
	 k6WR9F3zUi6QeW+OQtMdMBhMbyCmDWHegizsIR6McU2rg9D9MvaUKgxa7Q8rlJtNd/
	 XxKSn0skJx3AAKyJSwFDjzDqn75u9fg/1BdfHMe4trOiofr3HoNaPM74H7Fq/+S+x3
	 fzgdU+gMgCqwHG4HmK/srRenwQkIeGduYXAeeCLLd7rGs5iLrPJMyK45NihfYEq5r5
	 6a5MblZ4rRlXOQ5AtY+cwEcP8ye4ewiJQi0WgeBszCI7srlLrH4lGOfoYJ9GqUy8NA
	 ZcKXrVXsEYbAA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 17 Jun 2024 16:35:22 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 17 Jun 2024 16:35:21 +0300
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, Mark
 Brown <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, Md Sadre
 Alam <quic_mdalam@quicinc.com>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
	<avromanov@salutedevices.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<kernel@salutedevices.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 0/5] mtd: spinand: add OTP support
Date: Mon, 17 Jun 2024 16:34:52 +0300
Message-ID: <20240617133504.179705-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185966 [Jun 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/17 11:22:00 #25639124
X-KSMG-AntiVirus-Status: Clean, skipped

This patchset implements the SPI-NAND OTP functions to allow access to
the SPI-NAND OTP data.
Specific support is added for Micron MT29F2G01ABAGD and ESMT F50L1G41LB/
F50D1G41LB flash chips.

Martin Kurbanov (5):
  mtd: spinand: make spinand_{read,write}_page global
  mtd: spinand: add OTP support
  mtd: spinand: make spinand_wait() global
  mtd: spinand: micron: OTP access for MT29F2G01ABAGD
  mtd: spinand: esmt: OTP access for F50{L,D}1G41LB

 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  45 +++++--
 drivers/mtd/nand/spi/esmt.c   |  69 ++++++++++-
 drivers/mtd/nand/spi/micron.c | 117 +++++++++++++++++-
 drivers/mtd/nand/spi/otp.c    | 219 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  65 ++++++++++
 6 files changed, 506 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

-- 
2.43.2


