Return-Path: <linux-kernel+bounces-377607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F04B9AC12D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A6F1F20C77
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1015C15C;
	Wed, 23 Oct 2024 08:12:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC20158536
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671165; cv=none; b=bf8hFK25EyukU5SgqzImPGl0xrH/my/jemezX/6G0717nEuLHrloCSufCI6rqK73cOx6nKm009plWHVFpOBufpj8q4Q1Ndp+5mgdYMob6+/pP40JSNSDmV/BkbZ/rLvpgyWfg7zpMhWLe7uhaJY0KIsgQST6n6nv83CFbFfnG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671165; c=relaxed/simple;
	bh=lJmLv8QEgZj8qr68MkJgML54hWdN7FQAB/B9Q49TT8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KIBFyUScLL41FyaK5nO7w4ycAyQ8P7gnIpIpg5PIjcHf0RBGsGLEwtKRe/Fj/XSXDqHkfvFz+Ur3M1T2sLtbVYJYVXLEpAVL8W5dtjdXe2lLjyaleK6NZWDfRZjrqbHqK8broMxgboBEkFqOVY5M1EkQaWzvkDXpThqthVz/ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTv-0004YR-3A; Wed, 23 Oct 2024 10:12:39 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTu-0010Hh-1X;
	Wed, 23 Oct 2024 10:12:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1t3WTu-00FrPY-1J;
	Wed, 23 Oct 2024 10:12:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/4] nvmem: imx-ocotp-ele: fix reading from ELE OCOTP
Date: Wed, 23 Oct 2024 10:12:27 +0200
Message-Id: <20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuvGGcC/x3L3QpAQBCG4VvRHJsyS5RbkQM/3zKF1a6kNvduc
 /j09kYK8IpAbRbJ49ag7kiQPKNpHY4FrHMymcJUUpiSdX8YG9hN7jrZ6oPAthmN1NIIBJTO0+M
 Paez69/0AxNLX7mUAAAA=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729671158; l=1527;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=lJmLv8QEgZj8qr68MkJgML54hWdN7FQAB/B9Q49TT8M=;
 b=23/el6pD17uTVtS0E0e8yELD1xfAn93eobVXoT2FIMgXaKQMtd+nxG1fLT827oM2bNGnu+SXE
 Ur/AB/JB5/lAh9m5STiha+xFcrTUCFA3nlQltTXKREjaelINqoQWV0T
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Commits b2ab0edaf484 ("arm64: dts: imx93: add nvmem property for fec1")
and 0d4fbaffbdca ("arm64: dts: imx93: add nvmem property for eqos")
introduced NVMEM cell bindings for reading MAC addresses from the ELE
OCOTP. This doesn't work as expected due to bugs in the driver:

- imx_ocotp_reg_read() interprets the incoming offset as 32bit word
  offset, but it really is in bytes which means the driver reads bogus
  values whenever the offset is non zero
- imx_ocotp_reg_read() reads wrong results when the offset is not 32bit
  word aligned
- MAC addresses are stored in reverse byte order in the ELE OCOTP, we
  have to swap the order before passing them to the upper layer

This likely went through unnoticed because the bootloader normally adds
the MAC addresses to the ethernet nodes and in this case they are
preferred over the NVMEM addresses.

This series fixes these issues.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (4):
      nvmem: imx-ocotp-ele: simplify read beyond device check
      nvmem: imx-ocotp-ele: fix reading from non zero offset
      nvmem: imx-ocotp-ele: fix MAC address byte order
      nvmem: imx-ocotp-ele: set word length to 1

 drivers/nvmem/imx-ocotp-ele.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20241023-imx-ele-ocotp-fixes-f7b216171e1e

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


