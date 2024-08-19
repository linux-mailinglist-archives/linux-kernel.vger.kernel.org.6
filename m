Return-Path: <linux-kernel+bounces-292237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F8956CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F401285563
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D516D9B0;
	Mon, 19 Aug 2024 14:12:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AC16D4DD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076776; cv=none; b=UneC3fv26kY0cvKdhHeuOUvjS18q6r65ujETiX6NhgiWZggY8TeDEL6ELu8rUgfwNaMI2BuSEoPyyugVthg86qKczTWboP0rZhDiK+j1f4V+nXVNx9A4GflRmxJDu+KCSDzxC9py5FXUqwf0mcdfIuxLgVlaRJDwm1zFYsLS8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076776; c=relaxed/simple;
	bh=zUSoNrpWNdMX78WM+XzkuKB3j4Y2R0PpIY8Jix/75UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WusDGsUmt+OMMeZTK7EmNJFFhRl+t8BYYiLfzEFw1wxwlEL5SY2gTfxmLj5PiszNgyCvNKfmy7+46QYHGtmBDYhhGsKawXMxOrXx1epCY6Hy1+0N2ONth36rwHRgg9VeyQpEMJ511DSFJ79hXn1YTNePoDocWQZLBNHMflsYhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37k-0007o6-Cj; Mon, 19 Aug 2024 16:12:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-001YDo-Ox; Mon, 19 Aug 2024 16:12:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-00BNQ4-2G;
	Mon, 19 Aug 2024 16:12:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 1/3] ethtool: Extend cable testing interface with result source information
Date: Mon, 19 Aug 2024 16:12:39 +0200
Message-Id: <20240819141241.2711601-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819141241.2711601-1-o.rempel@pengutronix.de>
References: <20240819141241.2711601-1-o.rempel@pengutronix.de>
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

Extend the ethtool netlink cable testing interface by adding support for
specifying the source of cable testing results. This allows users to
differentiate between results obtained through different diagnostic
methods.

For example, some TI 10BaseT1L PHYs provide two variants of cable
diagnostics: Time Domain Reflectometry (TDR) and Active Link Cable
Diagnostic (ALCD). By introducing `ETHTOOL_A_CABLE_RESULT_SRC` and
`ETHTOOL_A_CABLE_FAULT_LENGTH_SRC` attributes, this update enables
drivers to indicate whether the result was derived from TDR or ALCD,
improving the clarity and utility of diagnostic information.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/networking/ethtool-netlink.rst |  5 +++++
 include/uapi/linux/ethtool_netlink.h         | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3f6c6880e7c48..5ca0b3661379a 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1307,12 +1307,17 @@ information.
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_RESULTS_CODE``        | u8     | result code         |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_RESULT_SRC``          | u32    | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
  | | ``ETHTOOL_A_CABLE_NEST_FAULT_LENGTH``     | nested | cable length        |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR``   | u8     | pair number         |
  +-+-+-----------------------------------------+--------+---------------------+
  | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_CM``     | u32    | length in cm        |
  +-+-+-----------------------------------------+--------+---------------------+
+ | | | ``ETHTOOL_A_CABLE_FAULT_LENGTH_SRC``    | u32    | information source  |
+ +-+-+-----------------------------------------+--------+---------------------+
+
 
 CABLE_TEST TDR
 ==============
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 9074fa309bd6d..ebee3b67055bb 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -573,15 +573,25 @@ enum {
 	ETHTOOL_A_CABLE_RESULT_UNSPEC,
 	ETHTOOL_A_CABLE_RESULT_PAIR,		/* u8 ETHTOOL_A_CABLE_PAIR_ */
 	ETHTOOL_A_CABLE_RESULT_CODE,		/* u8 ETHTOOL_A_CABLE_RESULT_CODE_ */
+	ETHTOOL_A_CABLE_RESULT_SRC,		/* u32 */
 
 	__ETHTOOL_A_CABLE_RESULT_CNT,
 	ETHTOOL_A_CABLE_RESULT_MAX = (__ETHTOOL_A_CABLE_RESULT_CNT - 1)
 };
 
+/* Information source for specific results. */
+enum {
+	/* Results provided by the Time Domain Reflectometry (TDR) */
+	ETHTOOL_A_CABLE_INF_SRC_TDR,
+	/* Results provided by the Active Link Cable Diagnostic (ALCD) */
+	ETHTOOL_A_CABLE_INF_SRC_ALCD,
+};
+
 enum {
 	ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR,	/* u8 ETHTOOL_A_CABLE_PAIR_ */
 	ETHTOOL_A_CABLE_FAULT_LENGTH_CM,	/* u32 */
+	ETHTOOL_A_CABLE_FAULT_LENGTH_SRC,	/* u32 */
 
 	__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT,
 	ETHTOOL_A_CABLE_FAULT_LENGTH_MAX = (__ETHTOOL_A_CABLE_FAULT_LENGTH_CNT - 1)
-- 
2.39.2


