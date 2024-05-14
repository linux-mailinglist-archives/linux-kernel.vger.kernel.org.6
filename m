Return-Path: <linux-kernel+bounces-178805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5216F8C57E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CA2B22525
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C0145355;
	Tue, 14 May 2024 14:25:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3576144D34
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696750; cv=none; b=PXOYGuCGCLjrYeU/HfnN6SYLpU7ttkVjw9Bo01zN+XKIjwWoGxEGKjeXyhNR9T89kw8wATf8IkN+WrN3q99xymnVr2dw4LYAz6DBairx3W+pMJRBcxByhM9rNZOiTWwg1o/+Dr6yftR9BIfZOOxdaqyqzcF7XQsrkCf2IG0d3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696750; c=relaxed/simple;
	bh=TIeV/E62DXbqh4pIU8p/hTVnaZWv3IIq7Aq4uMoPDQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ifFnBEx5tg1cNg+Y447FnZTsb/hVSfbFttHgkpE6GAjqmAHu4FBF+AiGFPmSxN0ywctLen7QPMYo6n1s4ZPA6FEL+avuLy6Y2mmm/9JNR0ri3zopKoIJfU5frQtDYv9WpxDOfrYacBxePSv7LKmVvS+RRMy09STZGLs2tPaNeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5m-00044Q-7m; Tue, 14 May 2024 16:25:22 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5l-001N6a-7H; Tue, 14 May 2024 16:25:21 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5l-004mXh-0N;
	Tue, 14 May 2024 16:25:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/3] mtd: nand: mxc_nand: Convert to exec_op
Date: Tue, 14 May 2024 16:25:16 +0200
Message-Id: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEx0Q2YC/43NTQ7CIBAF4KsY1mL4a0FX3sO4aGHasig0UAmm6
 d2ldeHCxLiZzHvJfLOgCMFCRJfDggIkG613JfDjAemhcT1ga0pGjDBBBJV4nA12jTN4zPq9QAa
 N/YS5anmriBZcSlTupwCdzbt9u5c82Dj78NxfJbq1/6iJYoINZVUtOqgEnK8TuP4xB+9sPhlAG
 53Yh6uI+sWxwtWt5HUZitPui1vX9QURKGfKFgEAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715696721; l=1577;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=TIeV/E62DXbqh4pIU8p/hTVnaZWv3IIq7Aq4uMoPDQ8=;
 b=QhR9nchAUId6bzTlNyM5dtiSW9Li0QNfunfyDmHWR3kV9eI/RJ78jyFv2dg0/4rCREoUokc3Z
 trGaK23IwNCAbLO/YuI04XUY7D0GGLkYWbNIecXk4+Kv4bMEEoGkfY5
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

 drivers/mtd/nand/raw/mxc_nand.c | 667 +++++++++++++++++++---------------------
 1 file changed, 314 insertions(+), 353 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240417-mtd-nand-mxc-nand-exec-op-38b3b80c4377

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


