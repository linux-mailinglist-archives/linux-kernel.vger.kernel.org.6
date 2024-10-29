Return-Path: <linux-kernel+bounces-386708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E497F9B4737
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62656B22CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F02205121;
	Tue, 29 Oct 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="O7new4Pb"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1320492B;
	Tue, 29 Oct 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198870; cv=none; b=crt+/VItRyYEdhV37YK+Pbr97/zQALi81LpesujpvqBrlCgTGkJ9HdK+VSCgRiN40JvSt1PgAMxry9JlTTI+mLIbDMeNfuPtiZeWHx/vSY7CFnt+UwHREhGGoEHhDrrFj42zc63/nSnx8xW2VADr/3PhTImF7QQS9ZvLwS7XA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198870; c=relaxed/simple;
	bh=NytuKTmqmF83y3YuXKAusWIAnYghAPvCvkxkS3y6MRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlSPd/fl5nBk6NtUWcIKf9gl4rZqTi2ilxd5NuhCvgGEfvdNM2IpV3RQtorFY4h1ri952Z0QV0v63TF6O/fiXnw/6Spa05gqnbH6j0e4Nzz9Y2q/snVGNaRhhzDdcGShyIYkvoIV0Uu+Ga/MEOBJWEy4EPAi8w88b1q3ELiy1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=O7new4Pb; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id BC3EE60644;
	Tue, 29 Oct 2024 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JG70TegBMj/ibFZUxIkrxShKc87NYQy7WkHukok4xoE=;
	b=O7new4Pb2Nq6S/vobN0VL74FAHFkpDjBzr9klQ48cO3crw0XnNIn0QXbRTpIJYLfOwmVvw
	YFUFVqyTMXHc0lm3SMYaHGAggtgH0gMjgu4HW0aLZ+u/0JGQDBzPkgJKsAmS6fh4kC/DmF
	KiIbm7wfOG71mCl7nfo12HGPcF77GN4=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 24BBF3600D8;
	Tue, 29 Oct 2024 10:39:48 +0000 (UTC)
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
Subject: [RFC v1 09/14] arm64: dts: mediatek: mt7988: extend efuse node
Date: Tue, 29 Oct 2024 11:39:28 +0100
Message-ID: <20241029103937.45852-10-linux@fw-web.de>
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
X-Mail-ID: 8e66c03e-5b0a-4db8-be5a-f6e0180b4bd9

From: Frank Wunderlich <frank-w@public-files.de>

Add subnodes for efuse containing calibration data for lvts and phys.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 7371cd80a4ff..ed8ce1e6f68b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -330,6 +330,25 @@ efuse: efuse@11f50000 {
 			reg = <0 0x11f50000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			cpufreq_calibration: calib@278 {
+				reg = <0x278 0x1>;
+			};
+			lvts_calibration: calib@918 {
+				reg = <0x918 0x28>;
+			};
+			phy_calibration_p0: calib@940 {
+				reg = <0x940 0x10>;
+			};
+			phy_calibration_p1: calib@954 {
+				reg = <0x954 0x10>;
+			};
+			phy_calibration_p2: calib@968 {
+				reg = <0x968 0x10>;
+			};
+			phy_calibration_p3: calib@97c {
+				reg = <0x97c 0x10>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.43.0


