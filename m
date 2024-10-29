Return-Path: <linux-kernel+bounces-386694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEDB9B470E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEDF1C217E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A1204F99;
	Tue, 29 Oct 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="JZR4PGid"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FE20494F;
	Tue, 29 Oct 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198395; cv=none; b=i/vZI5p2R0y7eGvZQWicUqS+bnWp2z8Uw9O4q4EcEZ4u3OEXPelebGFAt7S+Z0u19OqC6xly85ML2pgLppfSs8O0ogObpBey7cBtYrvAu96WTu7EbrvSD+D0Isru7KycDeYx56k3XvbEm41Pc7ryqYPojqGl7bi4ZV15htsra0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198395; c=relaxed/simple;
	bh=9aJzfvSyJuTYdEqFIXEHS/I8I7AwIZDJFvvyKtDkpp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWWouNSACpKQA36X5LQW62gYlyoylUGppFLIOJXndlL/+xf+yRST2LgN67py88eUaw9IRZCdQjfnkBTvFsbNl75RWY/zEWk0rIScENWAHRLxgM9YGFpC1Ulo8VupO4Tvk/NSMyvGL+GMTyrXXkzIBaX5elVHKdx/TgnKG7NTjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=JZR4PGid; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 388BA60654;
	Tue, 29 Oct 2024 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aj7eM8Vxd38nB8gdBiCUpncW4jumVYClCzr//il3Z6s=;
	b=JZR4PGidZvahbe0z6LVkkp9GrNSUQqT+yFOOveWLYYIAUwEswz0uY5C7RNxNp941CZKqI+
	tsKEKsG5hwwvzssAqGGrHxKjpQEJu0MXJjXZvMS2G8m1D0zmhvKb8QrGO+/7G5955IEcbj
	2I5YtCgjes/s5pVE5Kg/pSW1PM715z4=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 99D1C3600D8;
	Tue, 29 Oct 2024 10:39:50 +0000 (UTC)
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
Subject: [RFC v1 13/14] arm64: dts: mediatek: mt7988: add mcu-sys node for cpu
Date: Tue, 29 Oct 2024 11:39:32 +0100
Message-ID: <20241029103937.45852-14-linux@fw-web.de>
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
X-Mail-ID: 0665e2ca-e3cb-4b98-9c67-28aac8f7ecb4

From: Frank Wunderlich <frank-w@public-files.de>

Add mcu-sys node which is used later as clock-controller for cpus.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 7721d2ec06ee..e037854666c1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -210,6 +210,12 @@ pwm: pwm@10048000 {
 			status = "disabled";
 		};
 
+		mcusys: mcusys@100e0000 {
+			compatible = "mediatek,mt7988-mcusys", "syscon";
+			reg = <0 0x100e0000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		serial0: serial@11000000 {
 			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11000000 0 0x100>;
-- 
2.43.0


