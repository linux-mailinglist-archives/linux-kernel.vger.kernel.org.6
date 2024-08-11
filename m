Return-Path: <linux-kernel+bounces-282142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D384D94E018
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5351C20C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368E1F945;
	Sun, 11 Aug 2024 05:20:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4351CAB8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353635; cv=none; b=BDfvPm+nBGKFCmPo/kQbqa4brI8sD3K2UjscR2zOFgPRB6P7ngPcV7hD0sufoQBFjc3GbVH/z3nDtc4FYlWxguDKIE/5uKASQTbHXi+nd4MciPWRGABilRqWkC13vcolOLUNtsYIYjT1/xnK47JAHuYhAB6rGEncQk+YgHq002c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353635; c=relaxed/simple;
	bh=xH+1tVN81M+e4xyFM6qGfzT+u7GgJuqkn8x/p5KhbFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ae+lhWF4b+nFkdCc/e89LWbtP2u/9U4AzpOGY4DSpQQuUqrV2PjZSe8Vvj9twcpFobnNPDN6TiufXTFtdp/XXVTy7ws0nxvzxl0JmJMKoqKcwLIK+nRfpfo9bbygAlzDqvepmiGZACZZCuXco3JBR6Amtv6cWyeEo7KYX4tA5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sd0zw-0005xb-It; Sun, 11 Aug 2024 07:20:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sd0zu-0063X2-Ob; Sun, 11 Aug 2024 07:20:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sd0zu-004FfL-2D;
	Sun, 11 Aug 2024 07:20:06 +0200
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
Subject: [PATCH net-next v4 1/3] ethtool: Add new result codes for TDR diagnostics
Date: Sun, 11 Aug 2024 07:20:03 +0200
Message-Id: <20240811052005.1013512-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Add new result codes to support TDR diagnostics in preparation for
Open Alliance 1000BaseT1 TDR support:

- ETHTOOL_A_CABLE_RESULT_CODE_NOISE: TDR not possible due to high noise
  level.
- ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE: TDR resolution not
  possible / out of distance.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/ethtool_netlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 6d5bdcc67631a..fc814c8a5ac47 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -556,6 +556,10 @@ enum {
 	 * a regular 100 Ohm cable and a part with the abnormal impedance value
 	 */
 	ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
+	/* TDR not possible due to high noise level */
+	ETHTOOL_A_CABLE_RESULT_CODE_NOISE,
+	/* TDR resolution not possible / out of distance */
+	ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE,
 };
 
 enum {
-- 
2.39.2


