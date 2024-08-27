Return-Path: <linux-kernel+bounces-303531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D6960D83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08C52845FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94941C4ED1;
	Tue, 27 Aug 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lOtBWMVS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TnIgC49V"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6111A0721;
	Tue, 27 Aug 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768712; cv=none; b=NGd+GNPqWFhGuyJ6eTBUKg2axoL9Uni/N1oqheWpoz0LpoOCrwRtklJoRdcT/RmuSHOcVNjbsiEyoRriiJpCKNSXVeZJmaN/fLW14qWxMvDIw/ll12LSiIUrQXSRYPRmgRm3P00spPPzLLjG5WVmdxTCvdcqMZfrHkRDVyu9kEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768712; c=relaxed/simple;
	bh=LKCUwtSMsgKqtM6IlkHHhLOESS/1JIflJn00AgT7QjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=scuqcS1r2F5dspeIEdRZDWLmTOYlXgdL9vRFLz7ngdiZJZaWB4q1kgrnKnoKUEwlnslB0pLztTgXtymGOrj8Grfz7dmQusHDGQVXViHeZX2GstEJ+s/leimUgsJzJ5O3Ot6PV/qP5a1WGc8IPW+uMJghXAwSPMlAHE5Ombnnpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lOtBWMVS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TnIgC49V reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724768709; x=1756304709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiqpgpwN/DyTQ5enb5aMf0VU14IWuoEiQLnmzGymo1s=;
  b=lOtBWMVSBXJMHxdC4lnPB/V5m8h/6s5sxVnpRqvSGzBzug45JIAi1Ctw
   TPv9LwJhZwoYCi/A12J+mjAybTMklMEt57y4pntgV4f5ue028l/P6T51f
   YcvQy5d4kk8dwFdMdA/rRoUDDGWTSuyeXpQBKJwY4j9+zVpe8Ndw5F4hp
   ofsVUUUKwJ7tMG4CgQ2LFbEKvDnQxmDZKTqVTwiXFhYnI5NAA8MLLRhtB
   nO3ff50x33UoIqaZaKuGIqUUyUysCu7UWwDtuMy6AePj5rHcu6QNfbFey
   exU629ynU0/kaQi3asVKYHgF5GtKo+02Se1i6+UCPxFhbW/qMQ5Mr0qV8
   w==;
X-CSE-ConnectionGUID: HFGwEk9IR++MipMeOMKYtQ==
X-CSE-MsgGUID: FAjgxtP3QNCXixWxFaHeCg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719871200"; 
   d="scan'208";a="38614643"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Aug 2024 16:25:07 +0200
X-CheckPoint: {66CDE1C2-15-22BB8E18-F5F6D0B4}
X-MAIL-CPID: 215C266285C7040C7030EA4E64D12783_5
X-Control-Analysis: str=0001.0A782F23.66CDE1C2.00CE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A466161453;
	Tue, 27 Aug 2024 16:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724768702; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=HiqpgpwN/DyTQ5enb5aMf0VU14IWuoEiQLnmzGymo1s=;
	b=TnIgC49VxJ9z1JMGQOknT5fyoTYzJ/jSBJDOMkYEYyRWHKmB8IMWoUDDqKYRRulw2hYSzV
	DfmtuUUjNIeRO0KjPdBM6skzdeGFVXqNbjNUszG4G47AbdL2IEBI4dXebuPJzfKAeHEWLy
	i3KM6WwNvvcfhUVsp5XWtDdyyv/X5QF93JmYy5KkyTR92uSj38wvcUCnbdQodOOlQlh731
	UnW3JFJ0F3CWkfF7D3CzSWPquWcb0gRAOnrUEZhB7kSsHnxkyJaT5oyUM/xcn0ttNiBMdj
	HkUNqPQak34LJGBZIOZ0V9UlrO0Z0R59H96ZqU6aRgkdOI1exwWMWJNBmeQkXA==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: imx6qdl: Add reserved memory area for CMA memory
Date: Tue, 27 Aug 2024 16:24:58 +0200
Message-Id: <20240827142458.265558-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Default CMA size is too small for HDMI output and VPU usage. Increase the
default size by providing a CMA memory area.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Smallest RAM variant has 512MiB.

 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
index d03f7065ddfd7..8ba3ec27bee07 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
@@ -106,6 +106,20 @@ reg_vcc3v3_audio: regulator-vcc3v3-audio {
 		vin-supply = <&reg_mba6_3p3v>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x14000000>;
+			alloc-ranges = <0x10000000 0x20000000>;
+			linux,cma-default;
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx-audio-tlv320aic32x4";
 		pinctrl-names = "default";
-- 
2.34.1


