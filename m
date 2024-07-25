Return-Path: <linux-kernel+bounces-262006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7259493BF48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87BA1F217B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC8198A36;
	Thu, 25 Jul 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="eTYe/t3c"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC1171E55
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900775; cv=none; b=ftZKCeE+pqdEa7ssx9wxgtiz8xqPv5lE4e6DGnrehNhsesRpS8fux8CSK3na4rs3xvIdnBl2+ecizdwZAAWPZZrqOPCygOMr6sIlZ94YCUXc6aiXrFDThaeK3ABn/NnduTRtUrgv11OSfXG6LR0D9iJa3ZwtNIVd2Lw5P30ilf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900775; c=relaxed/simple;
	bh=OjGsfnkMfigVY2rFR4PTqE+kw96fhC6Bh4QLDVT7IyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwAjcvDWtjLcsXuQvAvt0L92wmEIAQ6yMsgHSPSTuqxgouUjd1zc8CgkEwla/CgpPu6e83fSs4AhxBTR5/9olwUrbQBS12Ax0WhMFVEB1wTf4l7cHkb++yN82hW0c7tVVQiNGNk/LMOYEAgOqmTNwDKG6s0vR5pE3cmLO2ezmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=eTYe/t3c; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1721900762; x=1724492762;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OjGsfnkMfigVY2rFR4PTqE+kw96fhC6Bh4QLDVT7IyA=;
	b=eTYe/t3co+ECMkE2Z0oP+LbJyvHTm6z3MfntHny3XWdZ3rtokN9jq6oPrc8DlA7A
	MraFLjJCSBuadoRMZmO4Vn1BBogZ3DHXEFCDAZFZkXbdc9weVR0TPuRe+CYfz7Wd
	VBmCAgy1VovuWhK8WTgxEmsx5HEb7oWepYg8ABFzt7c=;
X-AuditID: ac14000a-03251700000021bc-ee-66a21edaf421
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B3.CC.08636.ADE12A66; Thu, 25 Jul 2024 11:46:02 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 25 Jul
 2024 11:46:01 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 1/3] arm64: dts: freescale: imx8mp-phycore: Add no-rtc overlay
Date: Thu, 25 Jul 2024 11:44:55 +0200
Message-ID: <20240725094457.37739-2-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725094457.37739-1-y.varakala@phytec.de>
References: <20240725094457.37739-1-y.varakala@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8nAq3tLblGawe01nBZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CV8fHVW/aC
	2XwVN9t3sjQwHuLpYuTkkBAwkZg0aSpzFyMXh5DAEiaJXY9nMoIkhASeMkocmCoMYrMJ6Eus
	WLeIFaRIRGAZo8S3090sIA6zwHZGiRMT3zGBVAkL+En8f70drJtFQFXi7q8WZhCbV8BS4k7j
	EhaIdfIS+w+eBYtzClhJXP/TxASxzVLiX8seNoh6QYmTM5+A1TMD1Tdvnc0MYUtIHHzxghmi
	XlHi/cMOdpiZ0869ZoawQyXmr/nOPoFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUl
	qcl6KambGEHxJMLAtYOxb47HIUYmDsZDjBIczEoivMvuL0wT4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwGg0P+nN8RA2hg+NMhklJs03Z11Yw7pz+17n
	evE6k21lakvfHV1xfqUVJ9tWTv3etVM7ed9lZz9pfNsSVrqgq+0cF/tJdh+GSBHOE19Vs5fL
	vq5Onh/cySytfGGjQljZ6dNPJh93+r2ytj1xu29n4HpVvjNnJkZvDN8SlV1+3IHhu8KLzUbi
	h5RYijMSDbWYi4oTAbehGduVAgAA

Add devicetree overlay to disable rtc for boards that are
not supported.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
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
index 000000000000..396ffd9951b8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-rtc.dtso
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&rv3028 {
+        status = "disabled";
+};
-- 
2.34.1


