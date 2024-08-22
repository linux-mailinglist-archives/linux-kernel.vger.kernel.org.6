Return-Path: <linux-kernel+bounces-297201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C375595B470
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C7F1C22F64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29D1C9442;
	Thu, 22 Aug 2024 11:59:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4F1C9DD1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327999; cv=none; b=e1KfISl2lSuGVZpmbjF20EForaa5AD0ooDWQTfsChAu9vtneNWtWWttxoyFm1jGijOMeFrVpnyisoAgpq0Y2WaVrGI3qdGBIAdkqBZaUyPS5raV3ge4N3DjYtAMSLRHjTJfdFssiM2nhgMvu9EVqP/OX21Ca14gMcHwR8Tzd18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327999; c=relaxed/simple;
	bh=8TXXf/eTQLgJZWnSCki17NimkK7a7tjGOH+1WMtspB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ici3I1/p6zX8qJVvJsKzmk2mrfTJty5E8WPtxPhJUjjEsXKz5zRq7JOBhyYJIYNRkvICANI4Z+OaBvL+0OFFFfjgvLHOilx9qLH7h4mHbzgOhGMD9+T3Ad9g/q5DEnSAPd7KkGbLQIE79zM1QmGv6uyR73q0U1+33UN5dKTrG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Te-0005ou-WC; Thu, 22 Aug 2024 13:59:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-002EyR-4T; Thu, 22 Aug 2024 13:59:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-005opr-0D;
	Thu, 22 Aug 2024 13:59:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines for link quality metrics
Date: Thu, 22 Aug 2024 13:59:37 +0200
Message-Id: <20240822115939.1387015-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822115939.1387015-1-o.rempel@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
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

Introduce a set of defines for link quality (LQ) related metrics in the
Open Alliance helpers. These metrics include:

- `oa_lq_lfl_esd_event_count`: Number of ESD events detected by the Link
  Failures and Losses (LFL).
- `oa_lq_link_training_time`: Time required to establish a link.
- `oa_lq_remote_receiver_time`: Time required until the remote receiver
  signals that it is locked.
- `oa_lq_local_receiver_time`: Time required until the local receiver is
  locked.
- `oa_lq_lfl_link_loss_count`: Number of link losses.
- `oa_lq_lfl_link_failure_count`: Number of link failures that do not
  cause a link loss.

These standardized defines will be used by PHY drivers to report these
statistics.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/open_alliance_helpers.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/open_alliance_helpers.h b/drivers/net/phy/open_alliance_helpers.h
index 8b7d97bc6f186..f8b392671e20d 100644
--- a/drivers/net/phy/open_alliance_helpers.h
+++ b/drivers/net/phy/open_alliance_helpers.h
@@ -3,6 +3,20 @@
 #ifndef OPEN_ALLIANCE_HELPERS_H
 #define OPEN_ALLIANCE_HELPERS_H
 
+/* Link quality (LQ) related metrics */
+/* The number of ESD events detected by the Link Failures and Losses (LFL) */
+#define OA_LQ_LFL_ESD_EVENT_COUNT		"oa_lq_lfl_esd_event_count"
+/* Time required to establish a link */
+#define OA_LQ_LINK_TRAINING_TIME		"oa_lq_link_training_time"
+/* Time required until the remote receiver is signaling that it is locked */
+#define OA_LQ_REMOTE_RECEIVER_TIME		"oa_lq_remote_receiver_time"
+/* Time required until the local receiver is locked */
+#define OA_LQ_LOCAL_RECEIVER_TIME		"oa_lq_local_receiver_time"
+/* Number of link losses */
+#define OA_LQ_LFL_LINK_LOSS_COUNT		"oa_lq_lfl_link_loss_count"
+/* Number of link failures causing NOT a link loss */
+#define OA_LQ_LFL_LINK_FAILURE_COUNT		"oa_lq_lfl_link_failure_count"
+
 /*
  * These defines reflect the TDR (Time Delay Reflection) diagnostic feature
  * for 1000BASE-T1 automotive Ethernet PHYs as specified by the OPEN Alliance.
-- 
2.39.2


