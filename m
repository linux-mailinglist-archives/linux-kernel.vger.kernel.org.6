Return-Path: <linux-kernel+bounces-281790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A285494DB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACEF1F21EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB814B090;
	Sat, 10 Aug 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QUc1W8Z5"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2088.outbound.protection.outlook.com [40.92.47.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2D14C587;
	Sat, 10 Aug 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277087; cv=fail; b=X17OtfTnG7sUK19CDbze3QYsPej4jdsmANLxvUPlK83TXfiZWeRnJaUN46CGn3m6h05bL1LCCBjP3kguMk/TLat8rX4fIYXeO/aIvRy27WfUfN7oNgCdNBP06RNAMj4O9Xxld3dj1TbJS/7Hpo09AACtS78d04ZCD3Vc4ICvj9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277087; c=relaxed/simple;
	bh=geJq3s5fiHbTiRFcKHoVOXp0idsDu6lWvk8T6ej/v5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6C9A21OnLaYOV+DNcWCTqD+y5TA3XrOJcMtoTUyYq8EnG/8pPt3akx5gUrF9+OA34jbx/7zzmMm5DH1iaKdPb0Y2Z5JPULpDnWmu6mVTCXLP+8gGK7DINxbOR3setaTtuyx/bfgOu+XWr6PLToTd4lRgxIaaAZTtZfLhcK5rRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QUc1W8Z5; arc=fail smtp.client-ip=40.92.47.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5hD6tnnFiBkc3PFxdjV0bzfqKrvuFvvyQOSSS/6EDiudf/d6/6ZY5Qj/Udkre8cf3/J7bZtK3rzc4A9ZBX6WHxElc6u/QOJR36f0r+mcuv4srDbwiTz9e7UR11x+0bYki7zXRLdY9esc5xeM+ozdsqYLrz4uuzOFh4g7GQQXEeASmRe4ycT63XIAdZFoltuicIpCcn0qqiJoxEb9HDBVaEZwAtRT0IBkUvXTE2eyhXEm4MElcPY2bs9fi9epDXt2D/J13sOwH/o77oWkP0PwGzazoqM5aOXw+D+dPcJKSTspBkbICXxv+9eWxvFfQ+boNRzhsMClKM0LCEj7NFesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHEUQngGJDx0vOokAPvghmYJe9j03nCnYapbJwhGE3s=;
 b=r0l3IWzFaPUcZLMHw3CPHm57RjcFnhygFfFvETmUrsC7O1qy/PEpjM/fh1pMTaCtFJDafXoyQxbvitcHIDR4yUKv6WgY93R+kXPfsbTXK8L2JFhhgMaVnVZWQrWautKxv0rZKBDGQej5qrLdTi6o6iz4JTc2KdrcX6wHU5NBf37gEGpqEP++RAxq5u/sQ3ocS0BH8TE5P0Lzf+t0+5L6i/zkWKjjjrjqqQa/cvbQfUu8fulifZavXP/+DDnTB0LAuKYxNW3T97CpUikGWGSCuKmtF48cuvgFyCE0JLMzIjmY3DdOeXvkPDr8LIFAepf1OLtTCxwywI4BnOO6Y7+2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHEUQngGJDx0vOokAPvghmYJe9j03nCnYapbJwhGE3s=;
 b=QUc1W8Z5LLL8JWHFrRrmEqnu2KYqPf92Nw9egSd0SZfw1W8ouzJwqOBgLwuiCJZ/l/qB3X0BIbyP/bfDQhn0/e2pz47s4apBxIc5m6d7E3ENvAnvZRKw0WpJhN1w9cmyBSi8yFxdkI3jpV64PFcyCARakXXb2IxQMnefZMybpEK1fynGLbo80YBWQze06x8MMjjqweikMbZYsaK3lAqLXiYCBghlH3oHBr/Pi1W31HN/ol7J+TAdIKQ1sNItqOuRSVjGu/zlORnOowNGJh3fK/R0IFAfBfrNwzoTzW5KAoyexEOsZg1eqiGH8oyM6dX7tVaxR6/6eRbsjm8acj869g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5117.namprd20.prod.outlook.com (2603:10b6:510:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 08:04:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:04:41 +0000
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
Date: Sat, 10 Aug 2024 16:03:52 +0800
Message-ID:
 <IA1PR20MB4953D20CDAD64ACE0B98DD10BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VFrc+uNKKfujaNkm18V9MpBRHORk8XoDDgSis5Lqglw=]
X-ClientProxiedBy: TYAPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810080354.387820-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf06a0-ae13-4b79-8acd-08dcb91316bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|5072599009|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	KvAwK6bL6iIDkdOiXk/nHD9CJea2ro66JLNZ6MvMKnpxFMZtnQyBzrN6Ld5pmm5UjjHM2kOrrxnHA1QS++a7Qt1ipMx/xvfiUrVQZUVGj08tQXFra5iiSfMswDrMFQCN3xBKShsjrMj2hATam6IqWeUQKNJ9xfBQz9ysSLPQ3KjcGvBFAQyFyn8FuL52GpBfEfAtbAYWbkyc4spC5HDGpqMM/YJ9XL2QXD9RIUJYrk7OneMAn55Vje1XyWN6SNuUq31qWw1BGL+Yl9B7i5o6yY/ACGKlowKTDljy/zzGNvuxNQF0PVbqHaazY7qiHwTRKx9z2KAlNSaIx2k4kLl87lEBPgVgACILGsf/kOIGKsnqXGY6QQ61q9lPE8e1fmtMnLOi91qBA3fV1b7lluLIhm8aUeIifDKC4f7Z3vqri/yZ2uBm1bThtESb/jJWLO6ZcEO5oQIEH8sYcaq+h7pw2dstWT0yO3NB6w8LvguzE43uLRqJzMiyoUJvi068Cj8WpWBUjCsFhApftPeb+MeJye0bJHz5NUtXi6W5UY8v2JAmaGIWSj63EIrVKiQKmJlVfWU6NS8Ch1o5KbUwzdYw98KLrlM2LrESFxYIYlXoFgn76Sok36noSVNh4xcwUvVO4WF3CZuTPFKY0hQej6yL1+6kGzGM74VTgVvQxyecjfp8VYFdQQQK8FV8nVDgwW3ca3kLDS+DxF8bYpfhMtPfsuI+yvrTjjl5Pmt58ZadAIE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYKguqLwz84ipgfffSMgL0g7qqu4hLokblnPVmVXh+lRDGVBWQWas3UveGUD?=
 =?us-ascii?Q?6AveOG27mY87W5a3n04QdlDR73S4B00FsydX4dliBhmmHXZDgy0vwX80ZBEO?=
 =?us-ascii?Q?VBM/1Mkjxj6CDMTDA7GXeAxSRntFQnwPSH+a4FdRPqZEEUmlx2Tf5QVaOOC+?=
 =?us-ascii?Q?XN9l6++IwBvdMc1zyU3cpS/+c+KUWLbS82El+ORGa47ECkRGP86Eg7ArYrtY?=
 =?us-ascii?Q?7LZXAQ+IXoWnVd+oRtAUN4Kr8PV9NUcS/klzoOciKmrCZQ83/iETABUQq1qP?=
 =?us-ascii?Q?6PUY2dy8VwERzulPiRq5blQ/R+fz7Xn+cP1EVMKd5hVy2rej5d7Zvn+52Pf6?=
 =?us-ascii?Q?HM/S6R+4XcBDllk5r0v/xm/hGQa+mZ6buk8D9UFo02vZKaj+1OH3eFOZtWJL?=
 =?us-ascii?Q?H2vLxnmFBXMVR47LeFk6+1KlcnC4DAoMNUO6UohPPmGWa3JTRAe80NkAGGFC?=
 =?us-ascii?Q?TkyD7cFnHMleES5rEKzy0O7OtMoR1fcMPWhLnERCneW+fR3VT3gN7ymI8E7r?=
 =?us-ascii?Q?1z3YJmvrkiVvXcauVdLDwrmbVD+CpKauh4UUVDHJ5lkDW/qWB25QjHUrgFO8?=
 =?us-ascii?Q?Cr6jejUG508UCa8AODyFho5Oo9qRmLcx4QSGPrEkEOLKnAvJOE1d5fI56hWm?=
 =?us-ascii?Q?9G4YsjEHTa2NikjPCmwClmmdiUuWJuuzeO3twSfSeG+PquoASpXrsrQ5Qy4h?=
 =?us-ascii?Q?I6/Kx0n76ipLDfrqk2Ylf9yvjpqknZESkVNIEANRAl4+0W31jjcjiw3hH2nA?=
 =?us-ascii?Q?m8Dt/lURV7NtKzLR4CxpgFRzwRAa8kTwts8NWZLV4ecCxmmdctUOOPJ7BWlp?=
 =?us-ascii?Q?ix7VgZY+Qyygd9vLVq/c3AlTYiT6NpkN8XK0SnwTsp6Ya8/ZHMC5XsnSLHqr?=
 =?us-ascii?Q?pUUE07rBSIOjkQUcbFT4GnaDvIyufPRXHrLaTQzrp4ODEksYyCWJ44RR7Bcp?=
 =?us-ascii?Q?PCKbf4ySMwgWZ1HRbcdkHznDqBqzLQ1igMSIHZKCgPro/fcweC/DBEpjhgqa?=
 =?us-ascii?Q?LSKA3z5sqqOL3jrpfIihsABUjl2rR8vIEI7jd80TVLyoL5DZv936+28vxUYl?=
 =?us-ascii?Q?r3CW0IL8CHINl5BzKFD61pGJVaA3z5fbs9twKB0/fmWRwgcXgM5hoJD5BygQ?=
 =?us-ascii?Q?OSWSKlPvvoTHyXjbgciQa5jKujMtxri90CmUWcv6PYr/xZTScviGP+wbjotG?=
 =?us-ascii?Q?z/9GKyvKcCp669v8AZNSHsz3w2s3x5tMLVue+bi98hf3xcgupdKIZRBs6R8j?=
 =?us-ascii?Q?qOjcKaN5UxiAmgBPBsJe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf06a0-ae13-4b79-8acd-08dcb91316bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:04:41.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5117

Add mcu device and thermal zones node for Milk-V Pioneer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 80cb017974d8..76375e25a495 100644
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
+					temperature = <80000>;
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
2.46.0


