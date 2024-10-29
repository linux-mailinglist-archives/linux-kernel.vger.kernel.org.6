Return-Path: <linux-kernel+bounces-386711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8649B473C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5F11C2243A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F0205AC1;
	Tue, 29 Oct 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="DX7MikwG"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32B20493E;
	Tue, 29 Oct 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198877; cv=none; b=Nu4kgDxk4UG8AtIYmdre3BgXp59MHH4aNyssVqbF36bwlRx5/fxId61O1jepEV/T9BM8ri0Cts1pi5kBvGy88PiB+2yE3AWtfVFkyga4jnyPU+rzp3ToZOetRE6vMuuupQhd2XOV6Kta9ILFN+4wXWf6JPRMKZ4vK2SeEjHNpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198877; c=relaxed/simple;
	bh=wvlHDEJi6DRMvebJxjBdmXus5GU4EYoUEDwKJTqvdDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3qJZIhDrFIfgVReueSakzyvDLebipPW0rgyaqmcBui1YOefHYVySr3LHuv+ruRAquXcprl+lOXSI0/dFWmPeUAZ3RDZN5cTFQD4/lg0jkGzXrn2Qt6BtrI0gVhOmAU2aKzBEtqLmjhj69taKcLiGk6LH1kxMIcbkjbnSty0ZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=DX7MikwG; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id F0DB41012C7;
	Tue, 29 Oct 2024 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr/RtGMj3Fh0ffteWCfc3vtYrbzu7rRjjzNkbSx1+lc=;
	b=DX7MikwG3UfzTaI+ImYeReqWJdNVaytkwMIlzU6VMC8g5XsXV86QM9VOrQPAfc2XfIyUEQ
	+8b+MvqqUYSzDOAR+Q0rJ8+V5kDi05P+ANMlETITcf5ybN4XQOt6ZqTXcUVyNUFYiA3RaV
	OLg0/32ts/XgmyUCDYPflW9fmZOadN8=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5D87E36056E;
	Tue, 29 Oct 2024 10:39:46 +0000 (UTC)
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
Subject: [RFC v1 06/14] arm64: dts: mediatek: mt7988: add label for efuse
Date: Tue, 29 Oct 2024 11:39:25 +0100
Message-ID: <20241029103937.45852-7-linux@fw-web.de>
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
X-Mail-ID: 99ba07da-9a11-4cff-ac8b-29daa2217353

From: Frank Wunderlich <frank-w@public-files.de>

Add Label to allow easier referencing in dtsi and board dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 0425aec8dacb..777067b326b2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -285,7 +285,7 @@ clock-controller@11f40000 {
 			#clock-cells = <1>;
 		};
 
-		efuse@11f50000 {
+		efuse: efuse@11f50000 {
 			compatible = "mediatek,mt7988-efuse", "mediatek,efuse";
 			reg = <0 0x11f50000 0 0x1000>;
 			#address-cells = <1>;
-- 
2.43.0


