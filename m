Return-Path: <linux-kernel+bounces-300911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23D95EA67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCE61F21E39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A413CFAA;
	Mon, 26 Aug 2024 07:27:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309713A257
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657253; cv=none; b=pufPW5cykVKNvOpkcxSCsew+dw5PN5qeDEiyValYHgXfnA6Gf42wl4LsJm2Wtze3NMIllqIBH7qS4A2RWIG1kdGrny4bjxMBURHOt0Pj6dBJ4rKKLoeBLzD1QqOiFu3ql25yEgQhweFDs3QA+fXCGtVSn4q0aj6nMac/N2YYU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657253; c=relaxed/simple;
	bh=V9JLhApeG+XLvrXqWH7FiK4Fj8BNjLTSEbWxuakGv24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVEhCyvwEOn3NgeQP6ViWw5cDMCHG8vO+HntObEdgAg38ErtuWQW1h2fhu6PZWhMb6h1vqrA/7B3ubgd+E4a7Op6g9IrkEu2+y8bKU2jzDHzRUVED9NtOHZLATvn0KGyEHpZdPHyK507PLnoR5FQcOm5s5hNzGvlnjZxFxoq+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0005HQ-SI; Mon, 26 Aug 2024 09:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0038Ep-2x; Mon, 26 Aug 2024 09:26:53 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7o-000hSF-38;
	Mon, 26 Aug 2024 09:26:53 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/4] wifi: mwifiex: release firmware at remove time
Date: Mon, 26 Aug 2024 09:26:45 +0200
Message-Id: <20240826072648.167004-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With VDLL support the device will request parts of the firmware during
runtime, so instead of releasing the firmware immediately after initial
firmware upload, release it during device deregistration.

FIXME: I am not sure if we run into trouble with the firmware framework
when we don't release the firmware. We might have to copy it over to
some private buffer instead of just keeping it around.

FIXME: we might want to limit the release firmware at remove time to the
devices that actually need it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 96d1f6039fbca..5d02277d35293 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -695,10 +695,6 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 		release_firmware(adapter->cal_data);
 		adapter->cal_data = NULL;
 	}
-	if (adapter->firmware) {
-		release_firmware(adapter->firmware);
-		adapter->firmware = NULL;
-	}
 	if (init_failed) {
 		if (adapter->irq_wakeup >= 0)
 			device_init_wakeup(adapter->dev, false);
@@ -1836,6 +1832,11 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapter)
 		    "info: unregister device\n");
 	if (adapter->if_ops.unregister_dev)
 		adapter->if_ops.unregister_dev(adapter);
+	if (adapter->firmware) {
+		release_firmware(adapter->firmware);
+		adapter->firmware = NULL;
+	}
+
 	/* Free adapter structure */
 	mwifiex_dbg(adapter, INFO,
 		    "info: free adapter\n");
-- 
2.39.2


