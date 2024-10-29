Return-Path: <linux-kernel+bounces-386736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D223B9B478D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95704283BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10328205E09;
	Tue, 29 Oct 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ln4NT4jP"
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E6205ADA;
	Tue, 29 Oct 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198963; cv=none; b=fvPjT+1MyjnFt3aRZA4/exixIQ8/r7VTugGtp9plsjPGksuzYyjWy+ExtRk75W+8Xte2cmFGOY3BbRxjpWXJmPrcElq70DZB/rhApWNb/CD42lo9sXcWRTkxccGAJi9mThWCywEqoY/3BVzO5cjUbsnGVL52/q7TpYejryO3kzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198963; c=relaxed/simple;
	bh=Wr9zdHtFjDVGkDJ5VGSqZmjkpK3kNHNCYSXcONLcVSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsVPEr8W7CGdpT6WP9XC/gL8mtP7v741dmbTQhhqJac8X0Cvud4Wnd/KjkCW0wDnj6xT1GtoQE97B+I6GAJmjXXiw1vvsqxyuE+ymU64P7Lt7hm8OOn5MyUDjCqLvNPSraGVyAkqq7EYM5dYse6r7/VvrptNi6viw+Nnp6yMxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=ln4NT4jP; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 5DDAD61645;
	Tue, 29 Oct 2024 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dthOVvsNfRXr3q3blWKOOHKAo/CHNI++jDGd6dc/psE=;
	b=ln4NT4jPhsriKEo6oFajE03/kX5+a1YyRQ055Tt5u/KzoncMfGcBi3QWu1pd4OSWaV2Zdz
	Q1NPtC+1CK4RN7BKYrk+G+2Tsz5jhxxPcRGn+8yvVdP6jOMlfgWsb7zU6hPWMcrbm8fTLV
	XijqEvCSy0z2QV1qIvMJ8lwEoqNL9K8=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id AEDE63600D8;
	Tue, 29 Oct 2024 10:39:45 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v1 05/14] arm64: dts: mediatek: mt7988: add label for pwm node
Date: Tue, 29 Oct 2024 11:39:24 +0100
Message-ID: <20241029103937.45852-6-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 2f832f17-7fb7-415a-b55d-2c417a14bb51

From: Frank Wunderlich <frank-w@public-files.de>

Add Label to allow easier referencing in dtsi and board dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index e5e7951b24f8..0425aec8dacb 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -159,7 +159,7 @@ mux {
 			};
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7988-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
-- 
2.43.0


