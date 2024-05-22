Return-Path: <linux-kernel+bounces-185778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDA8CBABE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23C01F226F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683277116;
	Wed, 22 May 2024 05:40:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E274435
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356405; cv=none; b=dDhCRJGPxaABbtovTWgpnP07Vs22lVQFXKT6nquhCMIVwXgZnDKSlJ8PU7vo6xd4S25bvVRj7BYwyXDltuXAOpb4na/Bms4e3qYkCZzlP/rP6OEbC3W2KSM3ublutkzMavxtu2MioI4odHYzk3f7FS086x3urVfHx6in9lRxUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356405; c=relaxed/simple;
	bh=yeL7YBidh1ArL5wcz+0g/CtR4XhGDrY13bKz5c9oSjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p/MQsFl5Cg7wXHVJ4OXOdRNyGomiMS0u+MG5VOUMvC32Uh5jGPhZLt0e5nF4ec5OJ7Bc5DHQzcdz3KVgzDT9K+IGvxEGdksok3O6gP850WuES6yUVBPu6m1pw/t6ZSebO/e5gMJHahKBxJZ7lIM7nGMB3HJGJz2PDS6pLzoB/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s9ehj-0003da-JJ; Wed, 22 May 2024 07:39:59 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s9ehg-002U0u-Oa; Wed, 22 May 2024 07:39:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s9ehg-00Dqu2-25;
	Wed, 22 May 2024 07:39:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 0/3] mtd: nand: mxc_nand: Convert to exec_op
Date: Wed, 22 May 2024 07:39:50 +0200
Message-Id: <20240522-mtd-nand-mxc-nand-exec-op-v4-0-75b611e0ac44@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACaFTWYC/43NQQ6CMBAF0KuQrq1pOwWqK+9hXACdQhcU0iLBE
 O5uwYUmGuJmMv8n82YmAb3FQM7JTDyONtjOxSAPCamawtVIrY6ZCCYkkzyn7aCpK5ym7VS9Fpy
 wol1PQZVQKlZJyHMS73uPxk6bfb3F3NgwdP6xvRr52v6jjpwyqrlIM2kwlXi69Ojq++A7Z6ejR
 rLSo3hzKVN7nIhcVuaQxaGAm58cfHBc7nEQOcDMyNRo0Ep8ccuyPAFvzvB/ZQEAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716356396; l=1733;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=yeL7YBidh1ArL5wcz+0g/CtR4XhGDrY13bKz5c9oSjc=;
 b=8QjSfgQpsuuo3+7Et+K2NJ9b8j75hpC3LwsP/NZk6AV/CV9JKgR4BTihtkyMQC+Csl985R+YV
 z0dEjv3zoKRCSdEtTYJ/UIGdCesGXIuZ73mgTe37ZNO7ScWzoGLX5fc
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series converts the mxc_nand driver over to exec_op which gets
us rid of a bunch of legacy code. The motivation for this series is
a board that has a NAND chip connected that needs 4bit ECC whereas the
i.MX27 hardware only supports 1Bit Hamming ECC. With this series the
driver now supports software BCH ECC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v4:
- fix writing partial pages
- Link to v3: https://lore.kernel.org/r/20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de

Changes in v3:
- use monolithic page read/write helpers
- drop exec_op tracing debug functions
- use nand_op_parser_exec_op()
- move copy_spare() out of exec_op()
- fix comment about NFC handling R/B internally
- drop host->column. With using nand_op_parser_exec_op() we can forbid the core
  to issue multiple reads after a command
- Link to v2: https://lore.kernel.org/r/20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de

Changes in v2:
- Enable hw ecc only when needed and leave it disabled otherwise
- Use untangled data/oob layout for software BCH ECC
- Link to v1: https://lore.kernel.org/r/20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de

---
Sascha Hauer (3):
      mtd: nand: mxc_nand: separate page read from ecc calc
      mtd: nand: mxc_nand: implement exec_op
      mtd: nand: mxc_nand: support software ECC

 drivers/mtd/nand/raw/mxc_nand.c | 696 ++++++++++++++++++++--------------------
 1 file changed, 343 insertions(+), 353 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240417-mtd-nand-mxc-nand-exec-op-38b3b80c4377

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


