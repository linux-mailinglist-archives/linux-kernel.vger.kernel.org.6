Return-Path: <linux-kernel+bounces-294388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B30A958D16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97566B2413F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136721C3798;
	Tue, 20 Aug 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="VsU/yoJg"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6711BA87C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174367; cv=none; b=pdnrRZf2CV+rjifpVJnhvZEOiL+6qIYDq0EjpMBWZdo51uplxpsG22mSSBEbNIwNPVMeEG3VLsSqKNLRme/Fd4NOOmpkV0Kw3Jf3HUrMUCoJJXI8Fu7F6tAP+Q49wuVuOjY9E0Q36EmIA1e9J8olshn+6FkGjdCl8LK+aq+xqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174367; c=relaxed/simple;
	bh=UTkjf8Qx7YX73GC664cH8pYzzWOVSxdsxS9rfj1KedU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuTayGs61Esc9bbsyRByrkpWEM6m8Ju4JfcGkF1TWhESxQV7oWEzm/7fiNKkA+ESOxJ44IY3o2/HjtldrkHUs6nL9Rv29Ytm+GYL3iy6GSi7dR42ybXCZ0i7i93ChohPWDUBc17PE6qA7GPPBlhk6oXQ7uYLg6+HPSoD3OSQtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=VsU/yoJg; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724174356; x=1726766356;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UTkjf8Qx7YX73GC664cH8pYzzWOVSxdsxS9rfj1KedU=;
	b=VsU/yoJgfW03gkDzVaBKRCCsgMeCvFZBA63PTiMYvJiT8SAQO0ItLXL9s6nogabn
	chLt+3tOTBTaL+WW2F0zUG/+IbNOUTr7HhELbLaFd29+hwT5ZNS0911vjRlotfC4
	qE86wNFNdp2O4opbl9UYAJ1vRjzPhwveOJcH22zpPVc=;
X-AuditID: ac14000a-03251700000021bc-16-66c4d013a479
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 30.70.08636.310D4C66; Tue, 20 Aug 2024 19:19:15 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 19:19:15 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH v2 1/3] arm64: dts: freescale: imx8mp-phycore: Add no-rtc overlay
Date: Tue, 20 Aug 2024 19:18:46 +0200
Message-ID: <20240820171848.177926-2-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820171848.177926-1-y.varakala@phytec.de>
References: <20240820171848.177926-1-y.varakala@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8nAqyt84UiawYfnlhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CV8f7NLuaC
	X3wVl05PYGpgnMzbxcjJISFgInF12j0mEFtIYAmTxPKNcV2MXED2U0aJX40/mEESbAL6EivW
	LWIFSYgILGOU+Ha6mwXEYRbYzihxYuI7sHZhgUCJp73X2UFsFgFViRNvO8C6eQWsJN60PGWG
	WCcvsf/gWSCbg4NTwFpi1c8MiM1WEvtX72CEKBeUODnzCQuIzQxU3rx1NjOELSFx8MULZoh6
	RYn3DzvYYUZOO/caanyoxPw139knMArNQjJqFpJRs5CMWsDIvIpRKDczOTu1KDNbryCjsiQ1
	WS8ldRMjKJpEGLh2MPbN8TjEyMTBeIhRgoNZSYS3++XBNCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MXKY3GLq3Rbr8FjJr2T9/ftRLs7KLkyrjbP+G
	phbellzP9uQvH8+7N6kLY6ZI9s88UV2okCFZn9Z5Tiszp2r+c0v3N7ONNl9b6LTse/6iGUaf
	zz/teJmgLLd/R1zP78NGB38tevAnwyFhclTV4YDf8xyWqD5Rzr7zrtvC6HS7iEoR/44ky0IJ
	JZbijERDLeai4kQAgQU1hZQCAAA=

Add devicetree overlay to disable rtc for boards that are
not supported.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
Changes in v2:
- Updated license
- Updated with TAB space in devicetree property

 arch/arm64/boot/dts/freescale/Makefile               |  2 ++
 .../boot/dts/freescale/imx8mp-phycore-no-rtc.dtso    | 12 ++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c1fca1fcedc5..8f41db93c3d9 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -175,7 +175,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+imx8mp-phyboard-pollux-rdk-no-rtc-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-rtc.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-rtc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso
new file mode 100644
index 000000000000..5715404b39d4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&rv3028 {
+	status = "disabled";
+};
-- 
2.34.1


