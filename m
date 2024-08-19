Return-Path: <linux-kernel+bounces-292028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4363F956A50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B2EB24EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0F16C844;
	Mon, 19 Aug 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FBmALhjl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="a2nTI0Q9"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92716C6B8;
	Mon, 19 Aug 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069057; cv=none; b=LEiFbAumRaxWQjASFRzCGxjvqMl8k5Hcm5SImktj9X144cHQpU9m6UtUEjHfUtplINRcH1k0zEuZNCfSXMlbSSmIGD/PDeWS1bLNvvqwL85QPIrgyO6SuZVlktyfPEgdDR8+1MgDHqJ4n/UKPhfxcC2InVtBk80HfNLxYcV6iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069057; c=relaxed/simple;
	bh=9PSaogeoVfOBnj7iS+YU6TwZaWMkIcLNdvsT0664psQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNc15SLjNTX7jduPh+sm9SluZz9uP3/pSbbhhMxsU0AEBmMTp0dEgU6QhathI670xUnAtjF4JoPtLGvU97M+YCpVExs6rwFHq0oL8X8gIZ6KmPPVlA6IBfPcWk4T0ltopATPIbt5Tct3KQFju8MT6Mq8eiXGFQEBMAsiK/LvI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FBmALhjl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=a2nTI0Q9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069056; x=1755605056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z97hQDsCIiQeQvgBzT5C9odaYU+8ggDam9XAQVeIJCw=;
  b=FBmALhjlreWJRjkCwmJjIPNhH0TCCBHO88ZTeLVENUle0VFvAoZEZciF
   57VN17sZ8gfS51nWpLing0HmtezBjJP3ZBJRJXh+xXc2X6ipbtZQprTNd
   lqGPniQ0F9fx0UbKWyTUuBtjoMYS+yeRaMkRxm7/VFvkyLTAJzPy9Sqjt
   0KD5jgOkWm4DTu+jXPQMUCYcv4QllpAd9mDB1WqhS+sxwnp7aG8tXUwqQ
   Qkihve/uJW7AgmOQqml/78qii2pvdszR3FhiQ/jWf/3hvZl/gX3lHLUxU
   0UeIHkMnhqQgnGUPN+7J9FESZKfSOJC/Wpo+Vuqt4LXbuXs6ArxmJDQuA
   g==;
X-CSE-ConnectionGUID: 9ixCO2EhRZ+n7673WklqQQ==
X-CSE-MsgGUID: zEq4CvzKSJKrzeoJY5K7iw==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467131"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:15 +0200
X-CheckPoint: {66C334BF-A-78509F09-E532FC2E}
X-MAIL-CPID: 57AE9C9B6F318BAE57BCC71B4C2A33DB_1
X-Control-Analysis: str=0001.0A782F1F.66C334BF.0092,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45FC8167DA6;
	Mon, 19 Aug 2024 14:04:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069051; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=z97hQDsCIiQeQvgBzT5C9odaYU+8ggDam9XAQVeIJCw=;
	b=a2nTI0Q9mm6M85yY5iW8SiNCQfL0/JYcIJhvovE669dRiAZx2fkSSEjSsACrXyqZA1m+5X
	lo7aLl1gmAnYRyf9ilaM4dfuCFYQ6jih+0EkkQtKgpeSS6h3oQ8REjn1AqDlebCFOCUHR2
	R9IyRdh95/qzhG8XDsMBXeQFWlGb1/yCIWRsim12VfP0ixlZZBFA1ShBLe0IpjqzD6nOj/
	67D0THtmuv6CIb7FG+XKgg6kT7VTfF7Jpol5GL4ljDOyrc/WYFUEHThsdDbN2ov4ek7bCb
	Z+H1EvlZctci1ZjJU8KU9MRspI32OxOPHBqsrqwxtC7KzzYkQ9EGqwDDnzMq7w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 07/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: Add ethernet aliases
Date: Mon, 19 Aug 2024 14:03:21 +0200
Message-Id: <20240819120328.229622-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

They are used by systemd to rename network interfaces to predictable
interface names, e.g. end0 & end1.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index b3db7175cdd43..643d006fbf8fd 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -26,6 +26,8 @@ chosen {
 
 	aliases {
 		eeprom0 = &eeprom0;
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
 		rtc0 = &pcf85063;
 		rtc1 = &bbnsm_rtc;
 	};
-- 
2.34.1


