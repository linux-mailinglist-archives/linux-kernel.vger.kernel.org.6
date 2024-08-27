Return-Path: <linux-kernel+bounces-303843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456389615D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC2A1F259AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E331D1F5C;
	Tue, 27 Aug 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MEw8vtAI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5C1CDA3C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780990; cv=none; b=IBWdfNJGHAcvEVNjmwABlMNOqGBfDDSqgczLKikvJ4b86ac1gvx+zV+3LWmCUix6Fs/w4gffyKZp9vE+BPvcSH5jSXf554C2G1nygyqGWVNQG8P491+ve569BQa9lFZt73MHU98+7kl0zC8W1SGD/wczDb/ylLanaPNzpN10IRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780990; c=relaxed/simple;
	bh=+QDiJFQRjIMeWRIgyt+g1PRn4rR2PN7QCutTsSsZ4RU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngZCOVQOW6Cv/VzQFY1LE3rS1/TF/OgwWP/R92RbcyAZY88z1hrmHBXqADQynLLUs2XlHKMtyVzt6WpF6ykV/vb05eX61qSysim9VnjCFWg0dg2SNyddTlnXKBAnPC597sZPtvdflRItabWP1K6asYzmFClkFiMKQEDNCAKgtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MEw8vtAI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 944B0100002;
	Tue, 27 Aug 2024 20:49:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 944B0100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724780982;
	bh=/E3gedr2wgbmn/YfDZDCnVtSmImQ4g2OtUK6h494324=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MEw8vtAIPwO6rssy5kHuV1zimOL0g9NVwVDYUwhDCFfYcwTK8fcjVk+usRfTNnRBC
	 u4c56HbS82MclLGI5XlheK/758UrSLTbV00EIbk0NSFAS0q9auDDmkb96Kb2PwoF4U
	 FnqSixaPp3eCDl3aKleJBiDD3hz/pr/JAR27e6RBslCMkCO2SZjo6FtdVsk+c/m/Ip
	 EDKQj3cttJrPmWqeKeGBi4hbymC0KlEx8KKHr9wov7rQSS9L4WcaGEBq7oWwoZJMzi
	 a+w2rCoGmqSjmsWGiRIlsASzhNFLdUWWID+BGp9dexik+RG/V519q41cF95VexDeN3
	 DXCYo+k1WBIVw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 27 Aug 2024 20:49:42 +0300 (MSK)
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, "Mark
 Brown" <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Md
 Sadre Alam" <quic_mdalam@quicinc.com>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
	<avromanov@salutedevices.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<kernel@salutedevices.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v2 0/5] mtd: spinand: add OTP support
Date: Tue, 27 Aug 2024 20:48:58 +0300
Message-ID: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187372 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/27 07:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/27 07:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/27 16:21:00 #26445643
X-KSMG-AntiVirus-Status: Clean, skipped

This patchset implements the SPI-NAND OTP functions to allow access to
the SPI-NAND OTP data.
Specific support is added for Micron MT29F2G01ABAGD and ESMT F50L1G41LB/
F50D1G41LB flash chips.

Changelog:
  v2 since v1 at [1]:
    - Make cosmetic changes (Miquel Raynal)

Links:
  [1] https://lore.kernel.org/all/20240617133504.179705-1-mmkurbanov@salutedevices.com/

Martin Kurbanov (5):
  mtd: spinand: make spinand_{read,write}_page global
  mtd: spinand: add OTP support
  mtd: spinand: make spinand_wait() global
  mtd: spinand: micron: OTP access for MT29F2G01ABAGD
  mtd: spinand: esmt: OTP access for F50{L,D}1G41LB

 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  45 +++++--
 drivers/mtd/nand/spi/esmt.c   |  69 +++++++++-
 drivers/mtd/nand/spi/micron.c | 117 ++++++++++++++++-
 drivers/mtd/nand/spi/otp.c    | 232 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  65 ++++++++++
 6 files changed, 519 insertions(+), 12 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

-- 
2.43.2


