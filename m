Return-Path: <linux-kernel+bounces-573239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F8A6D4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7E16A6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804552505B8;
	Mon, 24 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XEmFjuJf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aCq86mTl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71C18DB3D;
	Mon, 24 Mar 2025 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800278; cv=none; b=tPl5ELOLOGPx0mrALRNyjzejbnFNAeyBZwoaK4mC5j2vvIdZ9zsPn7St6mr745oImsxFuu4yksELJm/huuggazWl8I4Xw0h8Swgiu0Dj9vxoptiRp4klfUv9PIqm2h6tP8ob8auXXVH0dJHF66XcwzkLNdYpKtClIU9JXZdSzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800278; c=relaxed/simple;
	bh=8np0Zkmy6itg5rwkoCInHPmTfQH1+t/VJrrTjZEeQwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ka9VgVlVFvXmwWOaDwrWHfETJ30oLzwGGL2K6VlpvBaaeFBfF25yQGdPlxSZ0TY9es6LaJbEQNuBi4gpz8pVS4qHKB+ZEF+N97F3Sp4gsZgo5t4tR2+3/a982D9C1yH66fry5eFcFJz6Umub5/QFNcCPurfqXb7EpkvdkGsCz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XEmFjuJf; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aCq86mTl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742800275; x=1774336275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WicwLy8Ia4IgEGPwRCubgPpXY8Bf4XQ7rwKIuQhB4mU=;
  b=XEmFjuJfltCOQMQCyCcQso2rp8/5zToK5/fzH7WV5sYsYLD3BglJntTe
   h3aD0Sim38JkSQqfoNWI/twemdvnehotFrPEQEu9Ym4KgIajJTAl5tAZx
   FqVR9SdUF2War05P2ctIN1s2D74FFRvO0hl58o0urOQPeh+ZAwItW+iIy
   a4PJL4qVztPVdxyw3zitjclxAv1yJA4Bgi07OLBbtcS1qeHxGZpR32V2S
   5sttfvWa3vhuOC6c9JdioSILmX5go4hoNcBDX4lacXy2xE8AlVuQtfu5s
   kb/qRbQ08fygCYysKKx/FiL2GBrPQdWjyTxcvWb07LolhEKBQ544/uO75
   A==;
X-CSE-ConnectionGUID: waMxGU0qSR+ZyXVE3a9JbQ==
X-CSE-MsgGUID: uaNuE4RPReuhCNIaFbgCuQ==
X-IronPort-AV: E=Sophos;i="6.14,271,1736809200"; 
   d="scan'208";a="43112353"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Mar 2025 08:11:12 +0100
X-CheckPoint: {67E10590-4-DC4DC9A0-F4F29281}
X-MAIL-CPID: D351269095FE72D618E19934B7466377_0
X-Control-Analysis: str=0001.0A006376.67E1058B.002F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0412516531A;
	Mon, 24 Mar 2025 08:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742800267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WicwLy8Ia4IgEGPwRCubgPpXY8Bf4XQ7rwKIuQhB4mU=;
	b=aCq86mTlGFfY1qsXJwvQxCt/uMBelhsIwKkcWOgU8bq5mdYmHofCeFfIe7dji1+XIF/b4R
	4ryHu3MMU9VqmXNxGyYVHddx3LRRUCHXcEqBlM3ikDxDL5YCgWuULWugLmQx5WLZ5qAuh1
	3s+NM6iEWtBIOqukJwXpIr+lngDafogzRBmRa6UOE/HNoEonafdMTW/8FOxcfGJVHMNsoy
	TT6yAYtcZDVVtUl4Jmdvl50eZU9TAFUoWnm7hR6p3F9xe1/fwS0Wr3EsyOw8RuxcUaox+2
	GanXLb/NAiLL1+xM9fiXgFCs952qmv/6WPe/zGDoq9FLIob+iTmzrtfUsVpCTA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/2] arm64: dts: imx8mp-tqma8mpql-mba8mp-ras314: Add LVDS device tree overlay
Date: Mon, 24 Mar 2025 08:10:59 +0100
Message-ID: <20250324071102.23765-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Martin Schmiedel <Martin.Schmiedel@tq-group.com>

This adds an overlay for the supported LVDS display tianma tm070jvhg33.
The LVDS interface is the same as for MBa8MPxL so the already existing
overlay can be reused on this platform.

Signed-off-by: Martin Schmiedel <Martin.Schmiedel@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index b6d3fe26d6212..d7ac8dda4bde5 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -247,8 +247,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk-pcie-ep.dtb
 
 imx8mp-tqma8mpql-mba8mpxl-lvds-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
 imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtbo
+imx8mp-tqma8mpql-mba8mp-ras314-lvds-dtbs += imx8mp-tqma8mpql-mba8mp-ras314.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl-lvds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314-lvds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
-- 
2.43.0


