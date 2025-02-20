Return-Path: <linux-kernel+bounces-523132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE1A3D289
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5E189A139
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2471EA7C1;
	Thu, 20 Feb 2025 07:44:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916231E9B06
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037477; cv=none; b=KZ5y9Xc7747d15S1eHd0fNtxXUbmpewFF2vywJ0gQuanq7L/4iDAN9eft09aWeha48Dz1AiasPirGbijrhSOw8sxJSMyS2wmFQZzNpHkwkx60Kr/EVmS9NWuy8PiyyLRq8CcoLUOj+tNDpbYci6r1E5YNgG+IEwaNpNFxMTIkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037477; c=relaxed/simple;
	bh=oSZ1L+BeRLKuAq0nI7S86bo/LhgGGt+J5L31FlMjqeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odPijVFh7dpO2GTXhyTIj3jWhGW4+eW/kUol3JzFf0mvGOeYt0pHgOhSTF/ylXqg5F99QC+fKDv3zil89GSjgWbwFBsDq9E1BKsDBujFrpU8WjSWjc29B8vbYt30GAMoEDkku+1egiCI7dwSWrz61zcPHlvQaYlNTLjIXzkYmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EV-0004TS-1C; Thu, 20 Feb 2025 08:44:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-001tqS-27;
	Thu, 20 Feb 2025 08:44:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-00CC2O-1t;
	Thu, 20 Feb 2025 08:44:30 +0100
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
Subject: [PATCH v2 4/6] mmc: core: add undervoltage handler for MMC/eMMC devices
Date: Thu, 20 Feb 2025 08:44:27 +0100
Message-Id: <20250220074429.2906141-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220074429.2906141-1-o.rempel@pengutronix.de>
References: <20250220074429.2906141-1-o.rempel@pengutronix.de>
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

Introduce _mmc_handle_undervoltage() to handle undervoltage events for
MMC/eMMC devices. This function interrupts ongoing operations using HPI
and performs a controlled suspend. After completing the sequence, the card
is marked as removed to prevent further interactions.

To support this, introduce __mmc_suspend() and __mmc_resume() as internal
helpers that omit mmc_claim_host()/mmc_release_host(), allowing them to be
called when the host is already claimed. Update mmc_shutdown() to skip the
normal shutdown sequence if the host is flagged as undervoltage to avoid
repeating of the shutdown procedure.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/mmc.c | 81 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 86b608843232..e626213e7a52 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2104,8 +2104,8 @@ static int _mmc_flush_cache(struct mmc_host *host)
 	return err;
 }
 
-static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
-			bool is_undervoltage)
+static int __mmc_suspend(struct mmc_host *host, bool is_suspend,
+			 bool is_undervoltage)
 {
 	unsigned int notify_type;
 	int err = 0;
@@ -2115,8 +2115,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
 	else
 		notify_type = EXT_CSD_POWER_OFF_LONG;
 
-	mmc_claim_host(host);
-
 	if (mmc_card_suspended(host->card))
 		goto out;
 
@@ -2140,7 +2138,18 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
 		mmc_card_set_suspended(host->card);
 	}
 out:
+	return err;
+}
+
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend,
+			bool is_undervoltage)
+{
+	int err;
+
+	mmc_claim_host(host);
+	err = __mmc_suspend(host, is_suspend, is_undervoltage);
 	mmc_release_host(host);
+
 	return err;
 }
 
@@ -2160,6 +2169,20 @@ static int mmc_suspend(struct mmc_host *host)
 	return err;
 }
 
+static int __mmc_resume(struct mmc_host *host)
+{
+	int err;
+
+	if (!mmc_card_suspended(host->card))
+		return 0;
+
+	mmc_power_up(host, host->card->ocr);
+	err = mmc_init_card(host, host->card->ocr, host->card);
+	mmc_card_clr_suspended(host->card);
+
+	return err;
+}
+
 /*
  * This function tries to determine if the same card is still present
  * and, if so, restore all state to it.
@@ -2169,16 +2192,9 @@ static int _mmc_resume(struct mmc_host *host)
 	int err = 0;
 
 	mmc_claim_host(host);
-
-	if (!mmc_card_suspended(host->card))
-		goto out;
-
-	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
-	mmc_card_clr_suspended(host->card);
-
-out:
+	err = __mmc_resume(host);
 	mmc_release_host(host);
+
 	return err;
 }
 
@@ -2189,6 +2205,9 @@ static int mmc_shutdown(struct mmc_host *host)
 {
 	int err = 0;
 
+	if (host->undervoltage)
+		return 0;
+
 	/*
 	 * In a specific case for poweroff notify, we need to resume the card
 	 * before we can shutdown it properly.
@@ -2280,6 +2299,41 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	return mmc_init_card(host, card->ocr, card);
 }
 
+static int _mmc_handle_undervoltage(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	int err = 0;
+
+	mmc_claim_host(host);
+
+	if (!host->card)
+		goto out;
+
+	if (mmc_can_poweroff_notify(host->card) &&
+		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
+		err = __mmc_resume(host);
+
+	if (!err) {
+		err = mmc_interrupt_hpi(card);
+		if (err)
+			pr_err("%s: Interrupt HPI failed, error %d\n",
+				mmc_hostname(host), err);
+
+		err = __mmc_suspend(host, false, true);
+	}
+
+	if (err)
+		pr_err("%s: Undervoltage emergency stop failed\n",
+			mmc_hostname(host));
+
+	mmc_card_set_removed(host->card);
+
+out:
+	mmc_release_host(host);
+
+	return err;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -2292,6 +2346,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.hw_reset = _mmc_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
+	.handle_undervoltage = _mmc_handle_undervoltage,
 };
 
 /*
-- 
2.39.5


