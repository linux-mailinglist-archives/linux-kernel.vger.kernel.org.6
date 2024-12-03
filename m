Return-Path: <linux-kernel+bounces-429305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 091219E1A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F091671FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445821E4110;
	Tue,  3 Dec 2024 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="dtMb68y3"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8181E32D8;
	Tue,  3 Dec 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223683; cv=none; b=QXLrJYVo6q0ceBdPJRJV3CA40DgMw6uRIMOBnVYFFTyk27vnRuUr9UFtLgouThXn/T3mdveHD/eH61ZT8lElatphyaX2+IxvsAOGV2Dn97geD2OLbZq6JxZMawklSTDrqlljBPRygXoY3biYBiQDSR+7pRwdNL6NuLWwWJzomUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223683; c=relaxed/simple;
	bh=tvm2U0hPeS+2Z1mu9fUzdXcEDS21EHlstTfYGANzVac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJElH10uXMwVJZpy1tv39xiy9jsjOCRmwpwsw2b8dIRBenPjs3k2NH8uHgqnks0EMK7/JEt8BXS6xXCbZM//SJPuT9+RlvvVRJZ9m6hOMErEAx4n/BRHscxFz9h0s1yk3BvUT925WKpb53RF1LDicaoywJGTcRhk0bKLrMYOO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=dtMb68y3; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GFOo5u8aTRK7DhrsU260UeP6FhrEO8wPjHVlLdKzJ1w=; b=dtMb68y3lpHLKU0c1tR4gkjF+V
	ad1pKfy/m7Ua/q0KSXO8jrUEzMoyOzkz2ocyB13GREkilWMp7Z5RYjxAc8vU95PiOcph+gavbGoh9
	WW8j7vYFHfHB3hOSIqSDEQcscVjYjFc2arm/fkJ3rW/FG3XJUIgMV4VpPf3P6DCskVHBTLeshk+Y4
	/X8stw+PIT+jYpr36osFhs+zTpGI5VhK30uFRjNskZYJZQX9Le1OtgGSUGRnPz/I/Hrbtbj+wzGjQ
	dpUPSGX82cpRRWw8vDUIJKlt5pPT1yvZUG83zCVK9MlcYZE+7BbqwqVCKNO464pp4mwgEfNWRUD/L
	KgUcYraw==;
Received: from [89.212.21.243] (port=52296 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tIQeX-00Bd83-0c;
	Tue, 03 Dec 2024 12:01:13 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 3/3] arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set lvds-vod-swing
Date: Tue,  3 Dec 2024 12:00:54 +0100
Message-Id: <20241203110054.2506123-4-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203110054.2506123-1-andrej.picej@norik.com>
References: <20241203110054.2506123-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Set custom differential output voltage for LVDS, to fulfill requirements
of the connected display. LVDS differential voltage for data-lanes and
clock output has to be between 200 mV and 600 mV.
Driver sets 200 Ohm near-end termination by default.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- no change
Changes in v2:
- use new properties from previous patches
---
 .../boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
index a9de42cf14be..8bf9cc553bea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
@@ -186,6 +186,8 @@ port@2 {
 			reg = <2>;
 			bridge_out: endpoint {
 				remote-endpoint = <&panel_in>;
+				ti,lvds-vod-swing-clock-microvolt = <200000 600000>;
+				ti,lvds-vod-swing-data-microvolt = <200000 600000>;
 			};
 		};
 	};
-- 
2.34.1


