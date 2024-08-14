Return-Path: <linux-kernel+bounces-286679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D17951DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DB11F2216D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C231B4C28;
	Wed, 14 Aug 2024 14:51:04 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2111.outbound.protection.outlook.com [40.107.239.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87A1B3F20;
	Wed, 14 Aug 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647063; cv=fail; b=jWfZaI0YG40rG0SCxVxCIpK7y9A2YRhsLV5eQTX1PxYPJbKCe945DvVL2ozkWs2swzxHuMmtTIe5Z+crApOp+eIm52j/8VPvNkJLO7dg46Gs4NVSoNyOoFG+UpR/UiV7gXg/1eNJxcj0blYhADPcf+0cBwLj45VI8nOnr8r7Bgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647063; c=relaxed/simple;
	bh=f8z2PtpkY9OHFMfBEzR4AsGAlPjOxWN9vYR0/Hhamsk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z9w1hkijrzOeI5A9Bz+uDr441dYtNKNF0HKxhAo3u0DYrRwlXSIrEfbpTA08XOjjZdeC7zm/b/qNO+Lb0NyF9iYFtb9b75RXUK5Uwgy1aFfb6AwHlxjdSUBDCPucXn29cg1Hy9drQmW3W7iBlshjuabP/4JZz90k181ZT1WH+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1GlvtZkhOg6nvGb2lZiJ7nZd2G4VaTFemhuKDcaxu6pv4OWltCxKDHvnStNniOK+t+LpvosXV9/x04b4BIop56D+0WulrZcT+GrTxXkW3HqZiPpjjQdJSILmuPuVSJgbSp2SYuzzjs0qCTvdsslB1oA4igb1G4Da3FIbUAder38Ehn6s/L8Q1KBK0vz7zGETc/hY0YSOHHITkq4eQsR2Zbrj19/3FHyU28/MioADrchaiwQP6Wq8TfmDkoSlSx2ou04p187VByL9VdAWp7EhYV7ysOz2dSKyyNOuglJedhlTxIhF4bg2znL3Vew2TE7jdoBtBKbyLJ+i6FESImkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1UpwaqhLQ36q8A037Tb/VfllMBNxyC+xjuMEH0PY2k=;
 b=Vc8xJczsWvvU9628h+HrZgAokNcwScqoI6Rw0vn0XQptUL1l9jAASCIB9IuKk9YVEcov1IH6lwJY5yKJ/Qb1IVvOocPBlWsKt3gEneV6l8wqb9PbDkR8FymPZRx1XcQEIyHFUwzZdQLWaeiMsftl39h8xw9/7WNb1Hz8KVRqNjfJh22w2TMHjwQo9lbF5qfT/GcdScJgK7HCozu6sRyD1rd7AvNxJpjefJLMLRG0/zs670gNp3W1YBX3358b48gNyVxV8T8hJkYZA9B98yVvzIAcGYCjf+RwGodo7GpcYX0O4bLRamcAJRGMDxdgojlsTMiOOXOGq1Cn37LTdqGT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB2004.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 14:50:58 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 14:50:58 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	festevam@gmail.com
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Wed, 14 Aug 2024 20:19:56 +0530
Message-Id: <20240814144957.93183-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::35) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN0P287MB2004:EE_
X-MS-Office365-Filtering-Correlation-Id: bd721151-8607-438b-1b16-08dcbc7081b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZaprPkgi2ds7lcahMs7tXRhl4c7uReCBQws7qYcnC0MLDPLP6Xo3OKCFMn/3?=
 =?us-ascii?Q?UNdcMHPXaf/Acg2o7wi57VLrvA9QVH01qKTTPVnqNvmRdqi2UaJglIdKrr+n?=
 =?us-ascii?Q?8ZCloe0L7WMRiInEHpUTQLfwSO7WTqpFKuIHFS1kZ93Gn6rZeTf4FDyP1/2n?=
 =?us-ascii?Q?7NO7ibG4T6xyUIcpQGJcuLIjNxvI06MZPi8nx3DriDJcDufuCEZx/o3Xbcy0?=
 =?us-ascii?Q?gFUJkWxTVnQhvRm9kkYL//qs7VOXgwdelFSUKT4XRIK6ewOffJnncHciXZwK?=
 =?us-ascii?Q?ABgGIR9pzBGXwGh+/xbWY+wGldbHX4SMo5KDbFdEEYY+uEokr7dx7ui3QWxI?=
 =?us-ascii?Q?Emnf5Dg2ubavICQ7FyrMm5MOHCD1R7gXRlzD7Fm3Mo3MT+FOy6Sva28mmKO6?=
 =?us-ascii?Q?7P59McXn8lcVJVDELm1U0W8r6JtmkgzCSm2YA/MdsEsxMp0op97aJJTFFyC2?=
 =?us-ascii?Q?AAR6mVrW8xGwpT7lTZqPhXVe4q7x9GjUxVFvdBeTLx7zPEvXmFyoi9KACfwf?=
 =?us-ascii?Q?47OPkP2g+Ksmw2YR9grMHw5ZGJ5QPh1dLRTj2HOFUeIvOER53Ws7Bhg84Igq?=
 =?us-ascii?Q?hVzkg3JenxmxaZzZS+m36+P1XmWKV54ZGAB8TxwUHILFB5fYR5hwaNVW87b8?=
 =?us-ascii?Q?3J4cLTAXQUZPbFk08STDYsCGrXIF6N8LV6NgG4oymMAkH6H35TTwjhuiEfAC?=
 =?us-ascii?Q?myXTUsogetZlaeqSyyjq7ttvQVXlspnC4s/vsylp+sLLognlxPphPo0BSgVZ?=
 =?us-ascii?Q?XlxfVnV/FOKHcqJTeG90uGmFdosmLtED6fFGDS6vads4xp9Dxsq2vuY+jeFP?=
 =?us-ascii?Q?du/w+7e25vJrjOidAP0Z3N0IDobiNVqiwDGJ4McPyq8bZiLyFsvaNU41wLcL?=
 =?us-ascii?Q?ozVR+xbFqphi3P8aYbykeEye4DwJXMEWddMbqgBA2V9/VNtxJrk9HBjN50h/?=
 =?us-ascii?Q?y9E6VxXaCXYSuT4QElvNOwUa9YdTk9xDQvBJ4ZZuFrhlNVfL6ndkVuirklwn?=
 =?us-ascii?Q?kOvetwEafmQraPszI/sgHYWKyNygYyH5upQWdcRkudKfOpqb0TKmbXGvdcsi?=
 =?us-ascii?Q?2THG7XOxjR63Lqp5Fd6bpeulPtbw/vCOJ+YbYwjCdoonFcv0mVpY0EBXcR+8?=
 =?us-ascii?Q?578LgNR0aYIJmNEN5n8BLX6829blNJRgKIQ+5cYK/hYgRdomexE9HPpZzGhs?=
 =?us-ascii?Q?gZsCZt7wuTgzdzN48qTWbT86biPLb4qBpgJfIKiFmgakw4i/x7lf2m7ORHK5?=
 =?us-ascii?Q?lxKn9VyFDomuuQte2zN2NvM4YtOrdErxt2TbZHmdyjr/aiTxcAMNlIJkgbqE?=
 =?us-ascii?Q?XJIbACf3dhyfV8C2xJsYPhFhrcQXqUhnWZQveGFxaSUtnzEwom2BWOkx8Dfg?=
 =?us-ascii?Q?j+obwUhJPM6lxBTqjJrWLrvLlXh9ikXPdUeHvedm4g+M+8GM/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwQKw92bDZqrN0LxVa/8judyzKPyA6HC7ugXQe7fIhfdsh8x4gMRw0IqsnRr?=
 =?us-ascii?Q?G1/4oawZBl0JiAh0r/lC11eXRH7RpKLBCHxjHVQAvwZLZELAbQnOBDeRwGeg?=
 =?us-ascii?Q?eHuwA5cPcp3FUYsI+eKUCbTmMthH2aBvu4mjPcTOcNyqt0Mdgs3vE3W+JtZc?=
 =?us-ascii?Q?PcKjmoMFLQOln0RO8BDwZ6S33+Zo4NeExPs22v6U2gCKWZLrt/8ZdnHatdDj?=
 =?us-ascii?Q?z3z3HrOz4FEcF9+K9GAX8tucVRjec96lRRBEJWk1OGr56cuUngxLIxuQbEad?=
 =?us-ascii?Q?MC27pFGt+ZdZtpXag3EI4sJLyzReUNUvZlQIJmqDEAZFhbTcSYmOLAzfjl+h?=
 =?us-ascii?Q?uTlPr1of/3JIXxTN4/429d4Y8JL9JeBEuYEWSaT2zxUHDhzF1MJNBmw/ZOCW?=
 =?us-ascii?Q?SlYD48iHzJSvZp4LieaTwp77oUmxUVcwmJQwjCsX+bCZULDFM1gTIZcQ/HEC?=
 =?us-ascii?Q?tHVOryUC1RG31eQ3IoQDW7xc4raS7uehCvIKbNg4jk4Ssqm/jrujNOSIzUAm?=
 =?us-ascii?Q?up+VIxrJG6G8HjgO73UpOnRi7sPolZvOxgG2BDpcdxobwtZnXpAGOmVFCwtd?=
 =?us-ascii?Q?U7588cMfC1ez17o1bI6uWp8KwabT/D/PcIUqLtZSrtESmNOFCnhQDZDTdRna?=
 =?us-ascii?Q?hUjQcehyXivG1lkJcJyT/SxEqQ8jEHUsOuNMZ52gnOwAgIFH0MMOhP5TkLpO?=
 =?us-ascii?Q?PpLi9UNDMHpaSh5V8l6dVDKZWtAsSbv6rIp+CueLbec1WRQXQXzcbDowJG1W?=
 =?us-ascii?Q?KnghgauqB5EGGL0JzqNgI2tUg/lbIrnBxEpHF7neRWIj71qb7WmXKOnuNn6h?=
 =?us-ascii?Q?t/BR98HeDMwFI5Zqbum2eNP0tniX01vhImuRuSCTs3PSC6JXnXkoFTMwVk7W?=
 =?us-ascii?Q?nQ0IuOtstoqzQL8tv/XFf9JErm1vxIxWV0rCuEU74d+OmQ2W72d7aJmQ0oEY?=
 =?us-ascii?Q?9g2uVbpcpKWiKevN2Kilw1Pjt9LHHBC0ruqldsW8XNgwp4NsipsusVZQuJ/p?=
 =?us-ascii?Q?sPy/M/OJ/h0qroN/axFT0LALvZsQHlTw+ufIlCrXKPsZ9izMCytvmeAGhfb9?=
 =?us-ascii?Q?AgWZ/aVWhpCq+SCYXwZIPJNuPFUFnleqH2UZGZ0lQYW9RPAfNgm5Jp/O83Fu?=
 =?us-ascii?Q?wUoAXFWWFy7nIJ+SGdkg8SREeDHFfMbdMwxOY5d0LZV+E2XigdKzN6uWY9yI?=
 =?us-ascii?Q?NuyIz8jDnvprupQXffjcltPsZXstgEUjlbPVnsDKC+dTSGLxwYPhS0MJxXz6?=
 =?us-ascii?Q?C7WcBEcINvaNH6E1Rsh4Xv6Q0iq2Y4fghmhEUdx2EYtnDse/IEaS4i0BXzCM?=
 =?us-ascii?Q?Dhh5pfr3zmav61wUB9n6xyVwh5s7qffUcRrwY1/eGDk9j+hL4OZ6+15atkmE?=
 =?us-ascii?Q?QzcO/5bjznx7TSwxdtuWlyBMPJ0dEEEP9S3Z3Yy6aEUq6mQ+KK4z1EzNiJda?=
 =?us-ascii?Q?jp8d+BkeT4OfcG6x/zeSTDKDP7M5udTG5RDbsGIN6OOXPGnR0x41MAxvKb8B?=
 =?us-ascii?Q?lMpWlY4EQEqnYsNptJSoMPpzyd/yHct5XUXa55J5GNFeDWlNzp3ZJTLEcjg9?=
 =?us-ascii?Q?SI30hrmnRKsSVdNLoNnXQsk3S5KnBxBKNVwu82LodPs0wgDJEKaMlu57hboh?=
 =?us-ascii?Q?kEWN9tm6ql/FyOHgmWE2/UI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: bd721151-8607-438b-1b16-08dcbc7081b5
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:50:57.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaNLM8iXjSK0iBnW2BGN7B+w6NeqTsnJ/dOgd1u89V+tWYVgjwm/CHAHOzYlvAH/L6ISJ1wBrv95H7E9MSZ18KZUne/VZSyeNXAyZVgGrks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2004

This adds the following peripherals support for the Emtop i.MX8M Mini Baseboard
	* Wi-Fi
	* Audio
	* SD card
	* RTC
	* CAN bus
	* USB OTG

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 347 ++++++++++++++++++
 .../boot/dts/freescale/imx8mm-emtop-som.dtsi  |   1 +
 2 files changed, 348 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 7d2cb74c64ee..5ce8f21a0b1b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,6 +11,129 @@ / {
 	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
 	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
 		"fsl,imx8mm";
+
+	extcon_usb: extcon_usb1otg {
+	        compatible = "linux,extcon-usb-gpio";
+	        pinctrl-names = "default";
+	        pinctrl-0 = <&pinctrl_extcon_usb>;
+	        id-gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	        enable-gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
+	};
+
+	modem_reset: modem-reset {
+	        compatible = "gpio-reset";
+	        reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+	        reset-delay-us = <2000>;
+	        reset-post-delay-ms = <40>;
+	        #reset-cells = <0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		beep {
+		        label = "beep";
+		        gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		        default-state = "off";
+		};
+
+		canbus_reset {
+			label = "canbus_reset";
+			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	osc_can: clock-osc-can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+		clock-output-names = "osc-can";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_audio: regulator-audio-vdd {
+		        compatible = "regulator-fixed";
+		        regulator-name = "wm8904_supply";
+		        regulator-min-microvolt = <1800000>;
+		        regulator-max-microvolt = <1800000>;
+		        regulator-always-on;
+		};
+
+		reg_wifi_vmmc: regulator@1 {
+			compatible = "regulator-fixed";
+			regulator-name = "vmmc";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+			off-on-delay = <20000>;
+			startup-delay-us = <100>;
+		        enable-active-high;
+		};
+	};
+
+	sound-wm8904 {
+	        compatible = "simple-audio-card";
+	        simple-audio-card,bitclock-master = <&dailink_master>;
+	        simple-audio-card,format = "i2s";
+	        simple-audio-card,frame-master = <&dailink_master>;
+	        simple-audio-card,name = "wm8904-audio";
+	        simple-audio-card,mclk-fs = <256>;
+	        simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Headphone Jack", "MICBIAS",
+			"IN1L", "Headphone Jack";
+
+	        simple-audio-card,widgets =
+	                "Microphone","Headphone Jack",
+	                "Headphone", "Headphone Jack",
+	                "Line", "Line In Jack";
+
+	        dailink_master: simple-audio-card,codec {
+	                sound-dai = <&wm8904>;
+	        };
+
+	        simple-audio-card,cpu {
+	                sound-dai = <&sai3>;
+	        };
+	};
+
+	sound-spdif {
+	        compatible = "fsl,imx-audio-spdif";
+	        model = "imx-spdif";
+	        spdif-controller = <&spdif1>;
+	        spdif-out;
+	        spdif-in;
+	};
+
+};
+
+/* CAN BUS */
+&ecspi2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_ecspi2>;
+        status = "okay";
+
+        canbus: mcp2515@0 {
+                compatible = "microchip,mcp2515";
+                pinctrl-names = "default";
+                pinctrl-0 = <&pinctrl_canbus>;
+                reg = <0>;
+                clocks = <&osc_can>;
+                interrupt-parent = <&gpio1>;
+                interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+                spi-max-frequency = <10000000>;
+                status = "okay";
+        };
 };
 
 &fec1 {
@@ -40,7 +163,130 @@ vddio: vddio-regulator {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	rx8025: rtc@32 {
+		compatible = "rx8025";
+		reg = <0x32>;
+	};
+
+	wm8904: wm8904@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
+		clock-names = "mclk";
+		DCVDD-supply = <&reg_audio>;
+		DBVDD-supply = <&reg_audio>;
+		AVDD-supply = <&reg_audio>;
+		CPVDD-supply = <&reg_audio>;
+		MICVDD-supply = <&reg_audio>;
+		status = "okay";
+	};
+};
+
+/* AUDIO */
+&sai3 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_sai3>;
+        assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
+        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+        assigned-clock-rates = <24576000>;
+        status = "okay";
+};
+
+&spdif1 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_spdif1>;
+        assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
+        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+        assigned-clock-rates = <24576000>;
+        clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
+                <&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+                <&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
+        clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+                "rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+        status = "okay";
+};
+
+/* Wifi */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wifi_vmmc>;
+	pm-ignore-notify;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	non-removable;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	brcmf: brcmf@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "host-wake";
+	};
+};
+
+/* SD-card */
+&usdhc2 {
+        pinctrl-names = "default";      /* "state_100mhz", "state_200mhz"; */
+        pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+        bus-width = <4>;
+        status = "okay";
+};
+
+/* USBOTG */
+&usbotg1 {
+        dr_mode = "otg";
+        extcon = <&extcon_usb>;
+        picophy,pre-emp-curr-control = <3>;
+        picophy,dc-vol-level-adjust = <7>;
+        status = "okay";
+};
+
+&usbotg2 {
+        dr_mode = "host";
+        status = "okay";
+};
+
 &iomuxc {
+
+	pinctrl_canbus: canbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x14
+		>;
+	};
+	pinctrl_extcon_usb: extconusbgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10             0x140   /* otg_id */
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12             0x19    /* otg_vbus */
+		>;
+	};
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SS0_ECSPI2_SS0  		0x82
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+		>;
+	};
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
@@ -60,4 +306,105 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
 			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
 		>;
 	};
+	pinctrl_i2c3: i2c3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL                  0x400001c3
+	                MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA                  0x400001c3
+	        >;
+	};
+	pinctrl_sai3: sai3grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC             0xd6
+	                MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK              0xd6
+	                MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK                0xd6
+	                MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0             0xd6
+	                MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0             0xd6
+	        >;
+	};
+	pinctrl_spdif1: spdif1grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT                0xd6
+	        >;
+	};
+	pinctrl_uart1: uart1grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX             0x140
+	                MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX             0x140
+	                MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B          0x140
+	                MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B          0x140
+	                MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6                0x19
+	        >;
+	};
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                 0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                 0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0             0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1             0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2             0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3             0x1d0
+		>;
+	};
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d4
+		>;
+	};
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d6
+		>;
+	};
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10             0x41    /* wl_reg_on */
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9                0x41    /* wl_host_wake */
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K      0x141   /* LP0: 32KHz */
+		>;
+	};
+	pinctrl_usdhc2: usdhc2grp {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x190
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d0
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d0
+	        >;
+	};
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x194
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d4
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d4
+	        >;
+	};
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x196
+	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d6
+	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d6
+	        >;
+	};
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	        fsl,pins = <
+	                MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x1c4
+	        >;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
index 67d22d3768aa..9b188075921c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
@@ -182,6 +182,7 @@ pinctrl_gpio_led: emtop-gpio-led-grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
 			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
+			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15			0x19    /* canbus_reset */
 		>;
 	};
 
-- 
2.34.1


