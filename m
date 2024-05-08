Return-Path: <linux-kernel+bounces-173105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E488A8BFB99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B8028135B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95ED81ABA;
	Wed,  8 May 2024 11:08:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEE81752
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166529; cv=none; b=DYoDzQgzzYtIpw2zq0cTGStRKcbQWnqvjLg3YCMD4p8FDX8Hd7oXf+hWrbc+1199sNa1EkwdmhuP6MvLv9jhK+TzkqPl4Q8boJfBfc9g45pNheGf+KdKUQ9MSdEztWvwX6F5TxrvFbJicMeryunWTqODxpg+NGp6o0MNG1oZ+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166529; c=relaxed/simple;
	bh=3g8zTdgFTywwXXViLkx93zxG/zs97n+z7Ky9USpA3aE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+o6c/hlMM04WdgL6Yf3n9bhCtua+fqrWaMzZE5y2AwcYOM6F3IxQ8oASpIIc3l8Uu+vXrJaXd9xX3G4f7W52kO/3GFJbCoab94IKKWcvKPt9FO4xoxoVmb0uwucrTVciBrZdgn6khu5+RFkfscogFJZ/KLyXkuqZdAri5pGWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fAA-0001ip-NQ; Wed, 08 May 2024 13:08:42 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000GOB-Es; Wed, 08 May 2024 13:08:41 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000NrM-16;
	Wed, 08 May 2024 13:08:41 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/3] mtd: nand: mxc_nand: Convert to exec_op
Date: Wed, 08 May 2024 13:08:26 +0200
Message-Id: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpdO2YC/42NQQ6CMBBFr2Jm7Zi2FEFX3sOwgHaAWdCSFkkN4
 e5WvIC7/37y398gUmCKcD9tEGjlyN5lUOcTmLF1AyHbzKCE0kLLCqfFomudxSmZX6BEBv2MRd0
 VXS2MLqoK8n4O1HM63M8m88hx8eF9XK3y2/5jXSUKtFKVV91Tqen2mMkNryV4x+liCZp93z/aW
 yC8xwAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715166521; l=1539;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=3g8zTdgFTywwXXViLkx93zxG/zs97n+z7Ky9USpA3aE=;
 b=N5L74TgDef67CwjtaATyuJAF4Lso8l3rkYl1WGWgNxwQp5JwBo+uXOFLja9QKZDhRUwW1z8jp
 hyISxlLnQFXD91m1GVHYmzxXGYWhCfnl1tGAHGkceOTrgfTtKYWkMIn
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

After discussion with Miquel I have now changed the way the data is
written in software BCH ECC mode. The controller normally interleaves
user data with OOB data in a NAND page. In this version I reversed the
interleaving before writing a page and after reading a page. This way
the data on the NAND chip is arranged in the way the NAND layer expects
it and commands like NAND_CMD_RNDOUT work as expected.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- Enable hw ecc only when needed and leave it disabled otherwise
- Use untangled data/oob layout for software BCH ECC
- Link to v1: https://lore.kernel.org/r/20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de

---
Sascha Hauer (3):
      mtd: nand: mxc_nand: separate page read from ecc calc
      mtd: nand: mxc_nand: implement exec_op
      mtd: nand: mxc_nand: support software ECC

 drivers/mtd/nand/raw/mxc_nand.c | 651 ++++++++++++++++++----------------------
 1 file changed, 296 insertions(+), 355 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240417-mtd-nand-mxc-nand-exec-op-38b3b80c4377

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


