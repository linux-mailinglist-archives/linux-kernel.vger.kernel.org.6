Return-Path: <linux-kernel+bounces-525499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA794A3F0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC03416DB85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736B205E20;
	Fri, 21 Feb 2025 09:39:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A41205E16
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130771; cv=none; b=nqsBaDh57tVOVgBkR807Un7WZWdszLGpd6qTCMbvxnj1Zw5hJjxysxwKPptpcS02Ta9F/+jy+7hV0o/xx560rCCgxWj3aCricJm0fPskdJViYb6GL8Is1hKlqOcZVzcpUWQohLlQlGg78sV0K6fy6XzcBYfkovj6IGcJHPY8NRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130771; c=relaxed/simple;
	bh=Adh/Q3rnUh98xXUXofXQcb8ZYwFqHSH9eh8GRfjl3Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2mqx+CHks8iYs1o7oQJW6QENGdrSmsnSl9RkC/NG+ZmYFhs0LSd+MEwKmOU3CtQFCIxHK5a4WLoPGTB9O9Uyp3MRwyQLHNFjW+n7XxwXmN8SZjTs1or10/he6PcZk+ZDQu1L8RBx0fudJ8NJypz7BONA5c/x44oGHqB/NibxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0001zU-QE; Fri, 21 Feb 2025 10:39:19 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-0024uu-1G;
	Fri, 21 Feb 2025 10:39:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tlPV9-00GXbZ-13;
	Fri, 21 Feb 2025 10:39:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v3 2/6] mmc: core: make mmc_interrupt_hpi() global
Date: Fri, 21 Feb 2025 10:39:14 +0100
Message-Id: <20250221093918.3942378-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093918.3942378-1-o.rempel@pengutronix.de>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Make mmc_interrupt_hpi() non-static. This enables usage of HPI outside
mmc_ops.c and will be used in a follow-up patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 drivers/mmc/core/mmc_ops.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5c8e62e8f331..dbb1b5ec4132 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -903,7 +903,7 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
  *	Issued High Priority Interrupt, and check for card status
  *	until out-of prg-state.
  */
-static int mmc_interrupt_hpi(struct mmc_card *card)
+int mmc_interrupt_hpi(struct mmc_card *card)
 {
 	int err;
 	u32 status;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 0df3ebd900d1..a16361dc5909 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -37,6 +37,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
+int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
-- 
2.39.5


