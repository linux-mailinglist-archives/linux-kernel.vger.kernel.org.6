Return-Path: <linux-kernel+bounces-259682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39912939B80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC144282B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA4314B08A;
	Tue, 23 Jul 2024 07:10:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414814B084
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718635; cv=none; b=iwLfhCeKg/IfqV+K95q3i13OJV549fkE7Lhrr6tReeGtYJy1pn1e6MdyFBKEK3QQb2WEFw2gaVe4Pf9++vZ5enpT338CX01pYql7F4btPYySkzjIROIfXx7QUpDuxhZcGZgiD2Tki+V1svkDSgPtyQscaSFDBqtQAXBCOnPBs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718635; c=relaxed/simple;
	bh=oKB1C+u6lt9mYbBSIkxen2Mog0cbm+RkCGld+4tThrA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g9CAHqS0g5qWeEalgtXnXjroFLs7xGx/s/J0OP7+8QJkbR1oqfmVK3T8ZUlqIIr35854SKQtYJdGLgC6nQjSaa9qm5UQ5WhYLBGXqC2E5OEXzjzIu2eb1cWWJla7nFa7M/ggD8dXHTPZPe+6kTAbWg40Kep9VU7DkPDi1pjObqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9ev-0007O7-Fv; Tue, 23 Jul 2024 09:10:05 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-001ZAW-Jr; Tue, 23 Jul 2024 09:10:03 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-00FQKO-1h;
	Tue, 23 Jul 2024 09:10:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/3] mwifiex: add support for WPA-PSK-SHA256
Date: Tue, 23 Jul 2024 09:09:56 +0200
Message-Id: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERXn2YC/4XNQQ6CMBCF4auQrq0pU6HqynsYFy2dwsQIpMWCI
 dzdwsrEGJf/S+abmQX0hIGds5l5jBSoa1PIXcaqRrc1crKpGQg4CJWX/DGSI5z42GvehzsPjYa
 i5GBBn1wljSgNS8e9R0fTBl9vqRsKQ+df25+Yr+tfMuZccFFoVMJJZYy89NjWz8F3LU17i2x1I
 3xa6qcFyUJTSFuII5gSvqxlWd55ibyNDQEAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721718603; l=1071;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=oKB1C+u6lt9mYbBSIkxen2Mog0cbm+RkCGld+4tThrA=;
 b=IVvcZ5GMSPrgR00UJwomUwOqdhFLFR1O6jOsFXukIC3j8Eqc0o2vsxyMJJr/VXSdScKjI/RW1
 MstwNH1Yz/5C3loZOElVsRC8Ni31m5pJR+j8gFmoWHujCM4eE/Z56+a
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series adds support for the WPA-PSK AKM suite with SHA256 as hashing
method (WPA-PSK-SHA256)

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v3:
- add patch to replace '=' with '|=' in the key_mgmt setting
- Link to v2: https://lore.kernel.org/r/20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de

Changes in v2:
- set bss_config->protocol to zero to make the code clearer
- Link to v1: https://lore.kernel.org/r/20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de

---
Sascha Hauer (3):
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: fix key_mgmt setting
      wifi: mwifiex: add support for WPA-PSK-SHA256

 drivers/net/wireless/marvell/mwifiex/fw.h      |  1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 32 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240716-mwifiex-wpa-psk-sha256-2d2a9fc3b06b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


