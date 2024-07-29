Return-Path: <linux-kernel+bounces-265015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46B593EB43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CDE1F22031
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE17E799;
	Mon, 29 Jul 2024 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fbW5rHK6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2091.outbound.protection.outlook.com [40.92.42.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604A77F1B;
	Mon, 29 Jul 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219974; cv=fail; b=P8RlRf7v55EhwjSj8Al6ij1GXovOc+IS7MtwVkl+6AEIj1SJntM1p6RyKtPddDySvcSfArpojsqltbVBGBOKjGSVw2rs6r7POHr2H5taZ3KD+mGVhcAem731PxuQGZSvcIQLqMAugrzZzIGagYXCj1iqFhaa0mANajNwzd/M2LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219974; c=relaxed/simple;
	bh=4N1iAkDpHCFbF8MvS36PvOlEaxLbh9TgSbtPmN9vAYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdzaR+U9qZ4VLBe1x75A3AbEw5VOJJwtNsbWXkpI2XsfnARwruIhq8m/44SFm8ehvuF39CZ76zOJK6XcNx+urixY1HbBWlS1Z6lBFZ6RMkMF+pLMsfolP5TzY5l1G3rBqnWzRgUi9HhXGF7utrUBV0ppuI8zlqNTDpP++JXZPRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fbW5rHK6; arc=fail smtp.client-ip=40.92.42.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNa8oXG0Ny/+y/sWev54ItUM11ylg5andKUnADA94VyOD1PbHAX3EYX1I9dsgZ69OOe5vEXH6vvjTAWu2p8sHIM8TvbfpgOxndHBXb722FrJ1QLHkcGsDPaI+3eG1mnTcndSFbboWVrP/fnkQdL04J40aAQYxvXFYldwF0eH0QzC8GSHj3bfNLYaDmAxMII9k5ohFtt6UgQMqQu/dr3HtO00GzBKMcE065+5xyP71gerT11LddCOYz2Fi2h1gErzo+jM7v+PYc0rZMPkJ9I/pedh5XJ5UC+N0wTS5oIY3QZbXhgLvp34EIRxUe/w8fF6yfcONYO6v+vjfDQmUjVU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Tfw1dxS0oeqMmzxgma1iDLTRKCmGYFX8bp+GsGX64=;
 b=RvXW/6VXpkg6VmBxIScknGpfnppRysap6vLJzHkTrR+7YTO07brKSrUsSLtkmdLa04J1OFH/aCO57MEoTm2hwdY0PRy/coOC64RITYVdmyrhRQ0jMs/kA7dYdECAvde5D2AcDuv+3iZYB2vzxNDsqDJfWIA+/tcyPXPYLXQXloLVLMwxklVeDCdYG9iqy+b81eBIfnewk1AsHeWYi575DUZfToGO21sgIwFLfM0yUvcLKzthO9ZCh575A7MUSqkXdUxac1ylgOI1ZiLEWSdO0yvl2R4i00vQaHgb88ScOON21fLn0HEucczaxaZ4iCcG6ljOscz7qsHUIk3PsrWrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Tfw1dxS0oeqMmzxgma1iDLTRKCmGYFX8bp+GsGX64=;
 b=fbW5rHK6TED+vcs6upbJHPZO9Gzs3jGXg1eao57NqgX/VeOGcoQ1RFQZmZeYq6+D79ndJyReAwWoanoumunQEGsSRBHwRbjkS7W987h26fvhvnmBm/FFduKg5NBReCUXkAxcmClS/Z641lE8BUSuGqHboDV4+TFfRA/UOsJv7V1/2McWu/kQtQR6Nbzd7BLQXr+xVxVZvFeUu2C4BD8tFrBynObpmlxdIsdDBBhORgSoiOhk88iX8o2qt2zUXf1FnP9HLsOroT0w6Q/SwXtfZcLI2ch69858T1sywi1zF2cLhJx/3eQL+ENzoloBrjz8P7Qu/sC5YkH0LTb8kOwgdQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:26:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:26:09 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
Date: Mon, 29 Jul 2024 10:25:32 +0800
Message-ID:
 <IA1PR20MB495364EE2CB1A649559761FABBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ENuIffTGGSPrQwvsilyPBA6BhmmSMZneyteFbCwSIv4=]
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729022534.842326-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 236b072e-f723-49d1-7d26-08dcaf75ce7f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599006|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	sumvLJbkEYWUxwLOu2oTbAVwhL3TiXbhm6vL8fG8bMge8sEcTy/epKD+3K9Vkc8zQNqnWrjfkjRkPXij/imsb7YczQrVd4utVsablw6hm7c3q095oCJ4vrpF1QyHCf9997DD30D5+Pf/cdDqVTs3Xmar1ubykcAFPc2z1UvVUVZmfXNV3eouHhoriC6DS7cCFslPXRttk/qUpXXEayiYveYP2zaxtbqp7NuwsGS6tkIiGCVlkQ9mjbqplEhmoU0oeyxfgc4ANRQnzYP9Xr3XIHO9OLmf3rfV+x3WKDZWA2d81l1AaiNiE5RtV+15tefrf83QVpqJeSxnfM1aLiDO+urCR7tMztS8pB9SYGgnSjBKC7Gsl7aEwkHJmrCBoJ44qjPMT0Z99r5H1dn9ORVgcbVq1nfxvDypFSS2Ys0FEL25fEn7I7fw4BWPr/bPWKVZkzoHouxuEBrv1QuWhjhP7jNBEgy8HLcvKU4DLRSoGi8m/u15VXC4jx18DZPdkmaFYSJPQ8YEBuPX8XZygGeZ+y0xzyhf3jXJw3nU6PIJes+qmlmNVHJcWmo6TRVjXaVnAftaumLEVUQKbqNvU2QZJuRXXZbHWbEvWY1X7oQ59ZH4sJXqUW3TyB4nQyJI6zW8f6HLN7/U8vhpWcnEeZln7WXMynd1eoxKyvo1xCoHNYwOYF7bb6mMLMg0FBCi/tZJdVwPCwCKU4amtKEKGEsHEg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zUW0rIQVWVvhNhmmo6WVYu0t16tP7RjEBaUDbsW9rQX4EuBy+2bPhZdJ54nH?=
 =?us-ascii?Q?b5tQ/55iajZCO1l9kBjkptYMr8Yu7nMKp3Ghl10vOHFiCN5Zp5AVtqsp8RUJ?=
 =?us-ascii?Q?AT28W3ZTSBW9u3BfMROZ5cQUkrRE7DNaTCgQo4W5NcilDmUU6sCnQ2kUnRCy?=
 =?us-ascii?Q?Rj8rELK5TW41JaUGTlqyWHR6QPxMb82bkIzcqzmJia3XChRBDnNnXYCVAOR9?=
 =?us-ascii?Q?fHDoTyMWyPfPnUDkQ7j5ohPBmKsxjfAxZHPYfnNwykXuXGufb7gqVpQteqtw?=
 =?us-ascii?Q?SwQMyKfzNJkaH6ngylackcp3Z56O4UV3ENYaiLCRDf6pys3Y1kfBmiN6UAo+?=
 =?us-ascii?Q?uM6LHhHr5gXlx+NuTp+Z1ymo5m4usuWTFuGp7DYIkSnmUyYrCTuMw/5QO1uH?=
 =?us-ascii?Q?x1h2EIq9IezssBNIb9Xp3w+4BWXm5QX72yRUJh1fGoTHKW2k0x+vq4eI9MpF?=
 =?us-ascii?Q?tjylnn6Z1vpt93AxHc8kGple+S42AT1u4MmlpyRlPP7CSyBqh+ZQj6IfKKkc?=
 =?us-ascii?Q?jPWY8mJj9nW3Yo6O0JRgWqgukreNfAh28TkBhWd7Z5R/73MGBiOoSN7jndqA?=
 =?us-ascii?Q?wPtVjnzWb3ewqWnSrF9GHm9PfoP3p6H96Wgm2mba0rBt9dPd1uePvjuLMKms?=
 =?us-ascii?Q?CHPjG1/jUW3nwqLKdIdxex1K8CFAs2zoEqbrlDfzoJaGv20byPfl+p8nO1NX?=
 =?us-ascii?Q?7ZGMOGd/xdEZI7/IH0BH6GzLCtcd6ryGt5YtXy6tiGJRxq/VVL8Cg0WIN6UK?=
 =?us-ascii?Q?b6Sq0wAyqoVMvHHmWnu+wiiqxseNPL5TG2orFC1vsdoMrehAgBzSRfPOwmAj?=
 =?us-ascii?Q?iBmjqvezxgQkoBPdldX9Df68rmJx70AZ/ZApsIHGvCq1ZDZZ9crJC6uZlowg?=
 =?us-ascii?Q?Y8HtvLYSDUmC5yHdkigyLyqPeKHfqgiGeJsEngO9RGgQwotoSiUZvscjq8LX?=
 =?us-ascii?Q?4xVSUFEoxw+D4Gig92GDSOBm29RNsPBIquArGL+8GfwX4iPTDe0R04QvuHWB?=
 =?us-ascii?Q?jLgpHIDSJBEubQSaeSHJnW9Y/SyUmWJimWVUI46mIp3ePg6+7W5YAh6NWucu?=
 =?us-ascii?Q?4kY8rRR7grplfzvIUPAGVuk1fzqJYCSRKGkucXy4XSmNLYduPVIiPFb8Qh7L?=
 =?us-ascii?Q?6Pu7f6jeLqFY/bjXq7Jx44Z7eKU+sVXZ/fVWSAq0wILkouKiIGTizqGe/RY6?=
 =?us-ascii?Q?T09rOU9QHZhx18lL3lgoQNu2+w1En3z1dKG/f7dX9/EQ203yAUvUX9u865p3?=
 =?us-ascii?Q?viUYkdK+ejupOWKekCAn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236b072e-f723-49d1-7d26-08dcaf75ce7f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:26:09.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413

Add mcu device and thermal zones node for Milk-V Pioneer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 80cb017974d8..8b8fdf6243d4 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -26,6 +26,66 @@ &cgi_dpll1 {
 	clock-frequency = <25000000>;
 };

+&i2c1 {
+	status = "okay";
+
+	mcu: syscon@17 {
+		compatible = "sophgo,sg2042-hwmon-mcu";
+		reg = <0x17>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
+
+/ {
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&mcu 0>;
+
+			trips {
+				soc_active1: soc-active1 {
+					temperature = <30000>;
+					hysteresis = <8000>;
+					type = "active";
+				};
+
+				soc_active2: soc-active2 {
+					temperature = <58000>;
+					hysteresis = <12000>;
+					type = "active";
+				};
+
+				soc_active3: soc-active3 {
+					temperature = <70000>;
+					hysteresis = <10000>;
+					type = "active";
+				};
+
+				soc_hot: soc-hot {
+					temperature = <85000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+			};
+		};
+
+		board-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&mcu 1>;
+
+			trips {
+				board_active: board-active {
+					temperature = <75000>;
+					hysteresis = <8000>;
+					type = "active";
+				};
+			};
+		};
+	};
+};
--
2.45.2


