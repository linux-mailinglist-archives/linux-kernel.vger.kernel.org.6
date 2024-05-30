Return-Path: <linux-kernel+bounces-196021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0EF8D5628
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8671C24561
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593F181CE5;
	Thu, 30 May 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fJEpEHBp"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5B6F2EB
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110983; cv=none; b=gSNRi7z9JF/dl6z4uyosgVDwTitqrbjCMfjJVGJ3CnNVxepeq0dZBvx2Aiv14HoDn5jdZQJFRdON9sdlRl/qKG8RUrRNgJFouowegvVKZM+cW/vrhLZ9YD1ObKqhrocrrtinPk0e9xvG2bcCLjkFEVNW9XhC3cGN08VArKYE46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110983; c=relaxed/simple;
	bh=S4u2lnOseyQyhqqVEovoQNvutfGLIDIS9kaLR4Y2eCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iehud5hbIa8Yoc5B67YAZLHl0+XsSTJjV/vTiyqFQUT4E7IDRZkfttxm3I4lAAeeW8Z6s6/61vNYFlUQHhHT+Qe8u+jMQhFaHNlJJ1ELQVX48not2zxhc6bZJsauL/9bOZkw9HGklfGVEIkPkId4sgicVayZ6Tv9QuG7hzboxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=fJEpEHBp; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 319FC2C00CF;
	Fri, 31 May 2024 11:16:12 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717110972;
	bh=Gt5oLkFJc6qdBQY80zttif5IVTnL3FhtOtbiLIh7m+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=fJEpEHBpT2Kx2gk7VGeYttijlEvtWf8fGGYHaRcinNdDPztfkaQpWy2jyr4VsqxWV
	 CAEOExpSt9pxkpCcuG+FrYFv/YjRKvziGe0eRxh9xZ2A4ThlQQUaiSlF4GaxIvT5Ri
	 bd8IATJKc5bHodSREgzb+B1isbj3nbgHl6YDgIf214ssX8WkBtdXH7IxM6Xh1Pjsrb
	 9uzkaXvj4zPSNas4TR2bCIT76yWyrB3WjTYVgzQtF86tDe2gTvBrFF3y5YtVQzvRI3
	 Pi1rU6jjFUDCT1CQdan5jd8Hq+5mOf6N4PNFAE8ZRuE+Hcx5aL8EiuiaNP6CIEbYCz
	 UZeNQCfVe2rrw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B665908bc0000>; Fri, 31 May 2024 11:16:12 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id F181413EDFA;
	Fri, 31 May 2024 11:16:11 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id ED746280481; Fri, 31 May 2024 11:16:11 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] ARM: dts: marvell: Add 7-segment LED display on x530
Date: Fri, 31 May 2024 11:16:08 +1200
Message-ID: <20240530231608.3557782-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=665908bc a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=Eze4_Z_RUzIZFoL9sA8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The Allied Telesis x530 products have a 7-segment LED display which is
used for node identification when the devices are stacked. Represent
this as a gpio-7-segment device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
This was originally sent as part of the series that added the seg-led-gpi=
o
driver but wasn't applied with those changes. At the time I said I'd subm=
it
this separately but I forgot about it until now.

 arch/arm/boot/dts/marvell/armada-385-atl-x530.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts b/arch/arm=
/boot/dts/marvell/armada-385-atl-x530.dts
index 5a9ab8410b7b..2fb7304039be 100644
--- a/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
@@ -43,6 +43,17 @@ uart0: serial@12000 {
 			};
 		};
 	};
+
+	led-7seg {
+		compatible =3D "gpio-7-segment";
+		segment-gpios =3D <&led_7seg_gpio 0 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 1 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 2 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 3 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 4 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 5 GPIO_ACTIVE_LOW>,
+				<&led_7seg_gpio 6 GPIO_ACTIVE_LOW>;
+	};
 };
=20
 &pciec {
@@ -149,7 +160,7 @@ i2c@3 {
 			#size-cells =3D <0>;
 			reg =3D <3>;
=20
-			gpio@20 {
+			led_7seg_gpio: gpio@20 {
 				compatible =3D "nxp,pca9554";
 				gpio-controller;
 				#gpio-cells =3D <2>;
--=20
2.45.1


