Return-Path: <linux-kernel+bounces-322682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78217972C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11739B2463B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942D1862BD;
	Tue, 10 Sep 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n83w1AAr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA77183CB0;
	Tue, 10 Sep 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957340; cv=none; b=B57DP1I9L0QaVFmxldpGOWEY6N7CzoILVVrUUrSkbQpb5QXFxgqcbeeua/lCMqQ7spDFyRL7bgcQrUkFfKOBAZ/BEwv0orHDGnROXTiXK3EcGrX5gjLP3AHv+BaqBbnFrQMUGCdTGXy3wHrKgDz6n71PvERzyYJGdbiMmybTuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957340; c=relaxed/simple;
	bh=N05fkHtT2/ScRMfQYWTPlP4NhcjC9bT8xvqCn1glVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ig4b6OeGyuygD37LDIZjQkZ5shKZHYhlA30ntI6JXVozNAvx2zCsDRI9K8PCzX/Xhl7Ax26uNNPdJnGk/MN+zPDMh/BiOSDEwtU3Ddhyq3avP3rOdwH3vpzxJLp1h4jpdjYO5sYYLij75S+qZvAmcMCqV7bDck7yp/wKZvRzd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n83w1AAr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725957336;
	bh=N05fkHtT2/ScRMfQYWTPlP4NhcjC9bT8xvqCn1glVvY=;
	h=From:To:Cc:Subject:Date:From;
	b=n83w1AArLAAcKc0BKOsAbcQLGeO9e+2FuSPsTvmdblSGO6B9pwNP4UfGOwQHL8z+j
	 0EqeW8BV7RYEX3q+BeHJvZRjfSC7s6p7ZYNGcB3rZTJiuBUDGaSZpx7oJNSYhA/zkO
	 uuxEDKaT+W90LmdpfRxCunkYUFPhi+7D9kRBZeXPlTk84c8LwBh0Ra66A6vPbrFgHm
	 180m4SXkBw2yK/zMfrUXYqQ5658kISpB79j564rJmfFUyrRRsXMUCsQlDsIupBt9rh
	 isWJ6ZmRpMmPdEVcAJXRW6wwCW19H2KeBoPzY8YQH6xEUzsleetPY/ml20bfd4xIjv
	 WHlTz8Jpq7WSQ==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9915217E0FC3;
	Tue, 10 Sep 2024 10:35:35 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com,
	Martyn Welch <martyn.welch@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ls1028a-rdb: Add iio-hwmon compatibility table
Date: Tue, 10 Sep 2024 09:35:26 +0100
Message-ID: <20240910083527.93473-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an iio-hwmon map to utilise the iio framework and access power
information via the hwmon framework at the same time.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---

Changes since v1:
 - Added missed PATCH keyword in subject
 - Simplified commit message

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 757a34ba7da3..f23cf156734d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -94,6 +94,12 @@ simple-audio-card,codec {
 			system-clock-frequency = <25000000>;
 		};
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ina220 0>, <&ina220 1>,
+			<&ina220 2>, <&ina220 3>;
+	};
 };
 
 &can0 {
@@ -253,8 +259,9 @@ i2c@2 {
 			#size-cells = <0>;
 			reg = <0x02>;
 
-			current-monitor@40 {
+			ina220: current-monitor@40 {
 				compatible = "ti,ina220";
+				#io-channel-cells = <1>;
 				reg = <0x40>;
 				shunt-resistor = <500>;
 			};
-- 
2.45.2


