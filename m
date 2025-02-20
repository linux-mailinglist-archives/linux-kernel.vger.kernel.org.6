Return-Path: <linux-kernel+bounces-523133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6400A3D285
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36343B1DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34B1E9B3C;
	Thu, 20 Feb 2025 07:44:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82D1E98FF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037477; cv=none; b=oGY71lgQMq8E95Dvm/pGAY/GIT6uGmBmpTo2Sh2RH+n6N0d5JWhPyBiAiP4u/lz+tcu7WsHFiqteCZVZ2DRWcOvqfGvI2aYTrfB4RXCXG8sYQM7t0gThm2G1aUJoXFM2/0A7HemQf2+1ZZejEP9H3gMNrWN1cyM4rd2lklE3gjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037477; c=relaxed/simple;
	bh=G5incWbHtDEe7N+cSOTb3Owqxt38o2con0kl3Rz0mSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzRJxNbfaKQ2v5entrjJIIp+pzPkP7StPNK8qnXQZEZ38JDiCwWM3ewKPzOYwC11LXO+dIsWVzT08rrcjhBbJ5FzKbbm2d+U8zYJLt488BbHI6LGHe/yGWuAxlf6MOX8aKqTb+HjWAzvVZv26PTP+XRKE8cwIPNAaCSK3iohYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EV-0004TU-1C; Thu, 20 Feb 2025 08:44:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-001tqX-2F;
	Thu, 20 Feb 2025 08:44:30 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tl1EU-00CC2j-21;
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
Subject: [PATCH v2 6/6] mmc: sdhci: prevent command execution after undervoltage shutdown
Date: Thu, 20 Feb 2025 08:44:29 +0100
Message-Id: <20250220074429.2906141-7-o.rempel@pengutronix.de>
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

Introduce an emergency_stop flag in struct mmc_host to block further
MMC/SD commands after an undervoltage shutdown. If emergency_stop is
set, sdhci_send_command() will reject new requests with -EBUSY and log a
warning. This helps diagnose and identify code paths that may still
attempt writes after the undervoltage shutdown sequence has completed.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/mmc.c   | 1 +
 drivers/mmc/host/sdhci.c | 9 +++++++++
 include/linux/mmc/host.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e626213e7a52..8aa5881293d8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2326,6 +2326,7 @@ static int _mmc_handle_undervoltage(struct mmc_host *host)
 		pr_err("%s: Undervoltage emergency stop failed\n",
 			mmc_hostname(host));
 
+	host->emergency_stop = 1;
 	mmc_card_set_removed(host->card);
 
 out:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4a7733a8ad2..8d67f27e7d9e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1658,6 +1658,15 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
+	if (host->mmc->emergency_stop) {
+		pr_warn("%s: Ignoring normal request, emergency stop is active\n",
+			mmc_hostname(host->mmc));
+		WARN_ON_ONCE(1);
+
+		cmd->error = -EBUSY;
+		return true;
+	}
+
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4e147ad82804..5dfe2cdde59f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -501,6 +501,7 @@ struct mmc_host {
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 	unsigned int		undervoltage:1;	 /* Undervoltage state */
+	unsigned int		emergency_stop:1; /* Emergency stop. No transfers are allowed. */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.39.5


