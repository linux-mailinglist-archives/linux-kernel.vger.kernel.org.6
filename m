Return-Path: <linux-kernel+bounces-526235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3359A3FBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB4A188E809
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF34212FAA;
	Fri, 21 Feb 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b="CMNzlDdk"
Received: from s2.avantea.pl (s2.avantea.pl [46.242.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDD1EBA14;
	Fri, 21 Feb 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.242.128.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156009; cv=none; b=oYl0vjFDdPIgd51OsuzShMcXBLF/P9Yyzt337Xmf4Q7rjrvmTny8LSVu8HhaJiVD+78ihqehQpX3xYcPyg5bT5ovEgiyFaNzkrOLPxs9JmqAR74/wgYaLWUhm9ykI1OrFyjyLmTv2koJPEzTBRuJxJ1NZmweKi4eVSJKJupmq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156009; c=relaxed/simple;
	bh=0ZMDRFPUNe4qk8G8SolkBVr1G4m1qg1ow0otgDRhPwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fde2tVnxSz1bMmpmWnkh26E4FA9W5YcbTCKQCP6Aa/50E7k8qL1QFv2/YET4TtWHYuS3ZTtrt+WyCtJzubQQV9r2+HMCsmAT5IyuFIwJodiHCapxulao3FKUVAUVGI/PhatI4cQUt7CuXdZVHjS2Yq+8f4m37fCtgd4/1auMx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl; spf=pass smtp.mailfrom=szczodrzynski.pl; dkim=pass (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b=CMNzlDdk; arc=none smtp.client-ip=46.242.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szczodrzynski.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=szczodrzynski.pl; s=x; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w2E197Qc+tMzoaRduX1xKII3x7kGR5ATZ73uNFSwZtQ=; b=CMNzlDdkHQ6mojLXa6tNiP/3VC
	RkIZGgKGLCLwEE4kPiGTssFxkaN0xfA7iu5WpmszAXMImsPodll8V0+9AC8TDn4YfEsc7Wp+sVXyP
	bw5eGzs6xhuk9T8yiqzR2bKgTIf9mcr2aydxbSSuy9e5FQlKv/eQgku1xjrcD+KHsyrXwB0RX8aOF
	+yPQyPm+M+bXvN+Ih7QHFFDOLh1/NMvVhCBjuWb8/Mr9AHv7Icatpoe8wI8gVs18Vru9xNko2ePe8
	ezPts3Z/Y0LIeJ7RWEUIpJ9F4dU8HijLXrwRyvvCShp5JHvXij14iwDn5G9u79LBlPQChA6Vp66ID
	+GldAbUw==;
Received: from [62.171.184.96] (helo=buildhost.contaboserver.net)
	by s2.avantea.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96-58-g4e9ed49f8)
	(envelope-from <kuba@szczodrzynski.pl>)
	id 1tlVix-00AOLX-1V;
	Fri, 21 Feb 2025 17:17:59 +0100
From: =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>
To: Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] riscv: dts: allwinner: d1s-t113: Add LVDS0 pins
Date: Fri, 21 Feb 2025 17:17:51 +0100
Message-Id: <20250221161751.1278049-6-kuba@szczodrzynski.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
References: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: kuba@szczodrzynski.pl

Add LVDS pins to the PIO since it's now supported on D1s/T113.

Signed-off-by: Kuba Szczodrzyński <kuba@szczodrzynski.pl>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index d241ba306..174b6d8f9 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -78,6 +78,15 @@ dsi_4lane_pins: dsi-4lane-pins {
 				function = "dsi";
 			};
 
+			/omit-if-no-ref/
+			lvds0_pins: lvds0-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD9";
+				function = "lvds0";
+				drive-strength = <30>;
+				bias-disable;
+			};
+
 			/omit-if-no-ref/
 			lcd_rgb666_pins: lcd-rgb666-pins {
 				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
-- 
2.25.1


