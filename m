Return-Path: <linux-kernel+bounces-231110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C791864A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396651F22EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A518F2CE;
	Wed, 26 Jun 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="M6SjxkEu"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2114.outbound.protection.outlook.com [40.107.212.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8818EFC6;
	Wed, 26 Jun 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417207; cv=fail; b=ZW/my33PUI2vSJJynQ2Cz+z+KQxr2LaqnbbPvRqONPmR+GYHCM6V+Q4xFzACPnoaNFaSqevMM8cnVMSa+ukqxt1j/pZnK6Kt4U+Hrhzih98Iw91wAS9ohKIMf+oYh+vhkIyspF5nCmf6R+YMBuIEfne4lAHvvrRTKrTq+Azzl8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417207; c=relaxed/simple;
	bh=o0wsb8SjTpOFgdsnT0Z/Z1SdwJ7+XPzl72T5gHuOMzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmHiSePgipnH7VnXbZvwoH46cwouvAYB0NF1X3xaltmPyGqdCDJjDOEMihZ6rAKIz20gMJzaTSGuH3998aOjiB54LGmFOuSNvROp0h6e6Vbk3DAt13lunNq80hrj32cPP8HlUxTzUtGGypNqL1wPzbJCn8y9XPSgAPcs3+rYSKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=M6SjxkEu; arc=fail smtp.client-ip=40.107.212.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/NbP+hh3xbAuF6lcSIBNXjgjHtZ3SJFaC3bFSXS8UcG9gYdfqZ0joRibylwsPNeg0FDTnlGawYoxQaxPMg9maWIapNRr1SnQedOPHz+j90XIVlqF6nWVA9uBl7s2HReC+T0AwB3XLaViJIQBuVA3EENZuI6PkWUUTzdrX4usS7B/t6MbKPuDwTfCu0Z+l+hskGBtQj+4UoPSYj+2xnP+FNBhoV/gGttPzGc3lE5jUyy5Yn4r+qDG/nuZKCvR0GZH3qMKN34rrnJqvpHeQpn5HETqqYZ9E3ZEaweDgKljhkgo/Fr149tufpw2LedhTMI6lu5fih/TT9aIEupjHv3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajDke4H1A7EzO1tqMSEjmFxTm/U9FvprfShOsuK1cvk=;
 b=niwvOXbfBOP4h505sWNOEyAvvtrCHRxveS/wehpk736U751t5TNDe6DDv6S7vi75LCos4S31KgCcmv3l3hPm4e4cnFfcXUcqtnZdxkTkBHdbusv7PuP/H2OxJ0ZqkDAPGy94ma7P9bYob/C7RHjpb7zu7FjtlW2TeVoF4ds0JXOibxadH5xLkcyYE51uuw8yAKhGYSloLwvNnw+r58OAqGPwGa+ky1kT346Xo6YOM8Dg3OsPjlOlAJ7LCL8FoCA0NRZCjRe2oiGTovmfj62aiNd6lvG9lZnwcj/rrSe/EoZpvoTq8bXgB3WrrSblSGTWLHBycSj75Wl67TkL1f3lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajDke4H1A7EzO1tqMSEjmFxTm/U9FvprfShOsuK1cvk=;
 b=M6SjxkEugSAv2u1bGfvoB856S9eescUO6Euwm2HuXnpv9aE/AMdGi4iphJhYloC4peWN55YmIXPFkU45GOrpnCJ3sRpmc/+or88knlS/NCQIVTYg9L3SxPPw5blqc6Hvua5zRo8nHMwulqG1StlAvhvYuV0gIM+2Zvgq79hTWaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by IA0PR22MB4564.namprd22.prod.outlook.com (2603:10b6:208:48f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:53:15 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:53:15 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 2/4] arm64: dts: ti: Add am62x-phyboard-lyra carrier board
Date: Wed, 26 Jun 2024 08:52:42 -0700
Message-Id: <20240626155244.3311436-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626155244.3311436-1-ggiordano@phytec.com>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:33::35) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|IA0PR22MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 0728f297-48ec-4b19-24c4-08dc95f816fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|1800799022|52116012|376012|7416012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Syu3/EAv1MWQxDEWPO4H3YCe/YuiJJK/+z23+Sg5MRdA/njeEnxjyx1/7dW1?=
 =?us-ascii?Q?ZSFDhcRTrDgYlh706gxC01J/Ql7c/N4NVmfIVtCmlySFLgKvcJx83tTcwQVA?=
 =?us-ascii?Q?Qvls32DOIqTm8Y1cP/oFk7DLo9qWbfeatXdXXYM9Ku+22EDz+mkjThNipWXR?=
 =?us-ascii?Q?iZnAzkgbqC58CP3XSW2ICkKmgWLcBCr8rzDgBu8l9kD6Z/4rw577skxi7l0U?=
 =?us-ascii?Q?746KVqk+/y7gH7/ZpFtoZ1FUsAb2AyXzd8q8rmP5FShPKa/j0vopGxBum/Y7?=
 =?us-ascii?Q?RBLWY2VFkuQY+fBKMIqCMkeUEmpvKYvmaGqmbTfuzUG/rMig90k6krPj4cTh?=
 =?us-ascii?Q?sk0geoRuxleM5CQhZAYX8PtYiQzrPh9bQ6rMPDCM9ZKqefCgMXZBjRxAZAaM?=
 =?us-ascii?Q?OrIXnlD4kwiGNI84l1wMi53UXV2ogngymWAnFYxw8NSt8qgz3w5f2KPKbSl0?=
 =?us-ascii?Q?ScNOvGMg06050wpR6Dmhg+/Hq+AV3Q+/gIE4rcZzAV7gwv8J6wuaFHFPxjnR?=
 =?us-ascii?Q?TeOOcrt2Syl/bbnNpaVDXdmhWzkHEtJ4lTnz+zS9ByNYuYcnfhB3M7hvUOR3?=
 =?us-ascii?Q?3rCn1yoR3PTQDNt99fa4XJBZijVTbh6wGIDIxfdnMdDo+5+OqZjU0b0mDvpX?=
 =?us-ascii?Q?ugnGY0WhZis/0iI3My/QuyeZpflHzvQSNFWUKFYT+UQah1SKaOJi3GUKf2lb?=
 =?us-ascii?Q?LvpkINU81uOjg45myekfcqgoqsaNe74T0YfqnEW84XtkAAA3MxRY/UTlGvrq?=
 =?us-ascii?Q?R+1nXzCBmLTZcrbx6dRH9Hkwg2pk1cNMxIB/ElTGBz83heAKmLXrkjk2TlLR?=
 =?us-ascii?Q?XIGjXdADX5c0YDysbmNpC8PTk/W1M6kRJHQPj1NB6oujQ6zpLc4OzOSA85Us?=
 =?us-ascii?Q?ZuYMKrNpneBWCLMIuhR6s2oo1ZISRUQfg8B15dHUvubfPHQaurp6H4E8/8Rh?=
 =?us-ascii?Q?9Uv5w+de51oeCmHYWIjCU6uzb5rra50ibNeCka/wKNvY1mshL2ch3jVIPeA2?=
 =?us-ascii?Q?Dwbd0ixD6jWZuwdyWa70Bf96fyd2adOH648lNeN0+wzynzMcrchMzTTh/wzC?=
 =?us-ascii?Q?qqMWRfCKUqHb0mSwJ8Zas738+pX6kVOusi70cmyDYE+JDzBvDtRLBmqOf6tb?=
 =?us-ascii?Q?BjuMbG7ZS2TMyfgJZYwkSW1Sbh7FfDtlUx/emhjtlDuVXMYatq8XLf90zPWi?=
 =?us-ascii?Q?jbNihttoS12CDZXOH0OhILL/j6cGJzA8dnuyWRtCExVBfGZqeTE3kzUOaX7U?=
 =?us-ascii?Q?vKEAyAKGTohzgguBZvWqxqL3gg1bOC+LdRNtx8nfak+n9pV52uGXJSG2rjlR?=
 =?us-ascii?Q?oiYhz/d5mgjoEPFj62pf4yIr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(52116012)(376012)(7416012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSRRNsAKhn4OQU8GOLXl8CFlVwpYL4AcfG9LcHRFskgKw8dyJ0/1NjNFp40k?=
 =?us-ascii?Q?qiJnrsDeNU3MPXzdJBA4TpTCe42HhdqP3shQ8g8K9irsDC0tPH7rNgyV+wub?=
 =?us-ascii?Q?qdHkRiGYn4wvi3ty3t/1G3b9tIZnoDESG2XVdCCRHDPfTDeEwbCo2VPGE0KR?=
 =?us-ascii?Q?lyRxXK+z+MEKwN4X+xhZLp52eU1/HLMlsUr/TT7vt43JlY79vuz1w1ghbCp5?=
 =?us-ascii?Q?2ugSM5ztQk2fdCP83ZD/nmNioaSQ2fyfoohB4GNS4dgqNgEDvn0S/7EKZP4f?=
 =?us-ascii?Q?ivOCqaTpdZgolIWWUTvzvWmpRssc6weQ2lJpgweayqPB4Aee4sZNSpKCWn17?=
 =?us-ascii?Q?OqNkwoChVYOv2pJmAlYLGID4EkXUZt5dM0JCdjtcr4FJIIqmnDwcSF4oN7qH?=
 =?us-ascii?Q?DI8qoVDk1uOiY1TreKdIkObOU9zw0dR2KVh184S1C2YGFdXtFm8fBMnnBYDH?=
 =?us-ascii?Q?/epN5wRDPTBHX0+3Bzt57ycP1PMqdVjWxh+gBIGrBw6VC43QReEMRmpYkVk7?=
 =?us-ascii?Q?ERyZrzp/V3+yTZuMX+Jbrid+0kN/Nz57+uC8XxoFf2x6tTDrpk1KIACHbF1P?=
 =?us-ascii?Q?CyXCP/K+PyjUS8nFySsXANIUEdkVfGZHW4WW89hOh4UrqWrDVc3yvcutFkXC?=
 =?us-ascii?Q?XQgOhPPE7goCsn2mY/nXU1sxFeCjUa/2p99aRt4VK9ooPnZ+e70fz+dd83CM?=
 =?us-ascii?Q?bA4mSAO3wkArVQYuDT5r+Ma5aqdzVWSmRsmOxBuDFpZ3ctatUHA6YyDa5TYf?=
 =?us-ascii?Q?LL3kumYsi9pJBAMj4mzwa9DbHbApH1w41H9WiROWjJ2FtFR7Ri709qdvR5S9?=
 =?us-ascii?Q?saVFfugQ6AZ/vVkLZFzyw/3jRwmJjAJ/B8QsXZeyIgRzjjCh8/djIbt/MYnj?=
 =?us-ascii?Q?FUiArUvbXZrMzHt6tlxc6myUfcw0NbdOB+YC21drZdMgHI6yjgV0kuvrWvVN?=
 =?us-ascii?Q?V6rM8WZopTh06k+zAgEOLTOsrgVYpdFW/yfLCC1n68BhJCGmDDXCoMJPIXXY?=
 =?us-ascii?Q?4IvYQWhXKdo8bYpG5oSSu7vx8rafJ9MqDriaPI6ciZ+Z2MKatPI9XyZkXhth?=
 =?us-ascii?Q?VnFYV6dZJx9b3HoF5c3ZHQFyzgP0I+lQ7DadSo+uyXcDzRoSMy7ZzCsZGgz7?=
 =?us-ascii?Q?XTjnTl6AttjbOCLf6D4Safkz2MxFFSc0asBfo3KsSVr3m41XVMguFFk8Fvkj?=
 =?us-ascii?Q?bcV3mYL4PGNKds4yjjSnzQtLSK/Yywvp7s9a3vnlw2kxPn8ZhekNsGUB1VYU?=
 =?us-ascii?Q?GbmxHfo13HYYx9nZA1IiEKJQ0FFI9huiX7nL0APdzy8hxKyIn7mi9CtpdAix?=
 =?us-ascii?Q?ux2HAdLTB7vS4hsBzcNu0gU6PsAKWrBi7rNPl3ZG2DKonVk5kfefyFwQIGTe?=
 =?us-ascii?Q?6q5ZIzViKLTtcbHBNONNfWQ+53mJB6BXoFYngOcFIX5UaJDCNH16UHaH7/Bs?=
 =?us-ascii?Q?F+TRiL4zUHulnnCOMGUhF3et+6MR1M3yFuuR264QQXAucFIu54vHblTTn4VW?=
 =?us-ascii?Q?MiUAqAxhGmKHtBhvs8+vKqxOzWDbTLDUGAJAY3andJDqCT4XlwC2uRNtABKF?=
 =?us-ascii?Q?sydFYiVRiPmVOI7kqKJmxmmpeVw4pD9sbYzDC/Qh?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0728f297-48ec-4b19-24c4-08dc95f816fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:53:15.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DeW+fSF3Be7H7DaI9t2OIlsV3P7eoobPAzQADsXOtcpMWHpXSW5KcdipW+UVn8ehOd6gtWFWtTEE4BX1pDjdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4564

PHYTECs phyBOARD-Lyra carrier board is able to accomidate multiple SoMs.
Refactor k3-am625-phyboard-lyra-rdk.dts into an include file so it can
be reused in combination with our phyCORE-AM62Ax SoM.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
-v2
  - Reformat patches using -B/-M/-C arguments
---
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 501 +-----------------
 ...ra-rdk.dts => k3-am62x-phyboard-lyra.dtsi} |   8 -
 2 files changed, 18 insertions(+), 491 deletions(-)
 rewrite arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts (96%)
 copy arch/arm64/boot/dts/ti/{k3-am625-phyboard-lyra-rdk.dts => k3-am62x-phyboard-lyra.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
dissimilarity index 96%
index 50d2573c840e..4fa5efdffcd7 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -1,483 +1,18 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
- *
- * Product homepage:
- * https://www.phytec.com/product/phyboard-am62x
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
-#include "k3-am62-phycore-som.dtsi"
-
-/ {
-	compatible = "phytec,am625-phyboard-lyra-rdk",
-		     "phytec,am62-phycore-som", "ti,am625";
-	model = "PHYTEC phyBOARD-Lyra AM625";
-
-	aliases {
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		mmc1 = &sdhci1;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		ethernet1 = &cpsw_port2;
-	};
-
-	can_tc1: can-phy0 {
-		compatible = "ti,tcan1042";
-		#phy-cells = <0>;
-		max-bitrate = <8000000>;
-		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
-	};
-
-	hdmi0: connector-hdmi {
-		compatible = "hdmi-connector";
-		label = "hdmi";
-		type = "a";
-
-		port {
-			hdmi_connector_in: endpoint {
-				remote-endpoint = <&sii9022_out>;
-			};
-		};
-	};
-
-	keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pins_default>;
-
-		key-home {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
-		};
-
-		key-menu {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "phyBOARD-Lyra";
-		simple-audio-card,widgets =
-			"Microphone",           "Mic Jack",
-			"Headphone",            "Headphone Jack",
-			"Speaker",              "External Speaker";
-		simple-audio-card,routing =
-			"MIC3R",                "Mic Jack",
-			"Mic Jack",             "Mic Bias",
-			"Headphone Jack",       "HPLOUT",
-			"Headphone Jack",       "HPROUT",
-			"External Speaker",     "SPOP",
-			"External Speaker",     "SPOM";
-		simple-audio-card,format = "dsp_b";
-		simple-audio-card,bitclock-master = <&sound_master>;
-		simple-audio-card,frame-master = <&sound_master>;
-		simple-audio-card,bitclock-inversion;
-
-		simple-audio-card,cpu {
-			sound-dai = <&mcasp2>;
-		};
-
-		sound_master: simple-audio-card,codec {
-				sound-dai = <&audio_codec>;
-				clocks = <&audio_refclk1>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
-
-		led-1 {
-			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-		};
-
-		led-2 {
-			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-		};
-	};
-
-	vcc_1v8: regulator-vcc-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_MMC";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_3v3_sw: regulator-vcc-3v3-sw {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_SW";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&main_pmx0 {
-	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
-		>;
-	};
-
-	gpio_keys_pins_default: gpio-keys-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
-		>;
-	};
-
-	gpio_exp_int_pins_default: gpio-exp-int-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
-		>;
-	};
-
-	hdmi_int_pins_default: hdmi-int-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
-		>;
-	};
-
-	main_dss0_pins_default: main-dss0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
-			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
-			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
-			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
-			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
-			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
-			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
-			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
-			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
-			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
-			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
-			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
-			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
-			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
-			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
-			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
-			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
-			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
-			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
-			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
-			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
-		>;
-	};
-
-	main_mcan0_pins_default: main-mcan0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
-			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
-		>;
-	};
-
-	main_mcasp2_pins_default: main-mcasp2-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
-			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
-			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
-			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
-			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
-			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
-			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
-			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
-			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
-		>;
-	};
-
-	main_rgmii2_pins_default: main-rgmii2-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
-			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
-			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
-			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
-			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
-			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
-			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
-			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
-			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
-			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
-			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
-			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
-		>;
-	};
-
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
-			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
-			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
-			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
-		>;
-	};
-
-	main_usb1_pins_default: main-usb1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
-		>;
-	};
-
-	user_leds_pins_default: user-leds-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
-		>;
-	};
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
-};
-
-&cpsw_port2 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy3>;
-};
-
-&cpsw3g_mdio {
-	cpsw3g_phy3: ethernet-phy@3 {
-		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
-		reg = <3>;
-		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-&dss {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_dss0_pins_default>;
-	status = "okay";
-};
-
-&dss_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	/* VP2: DPI/HDMI Output */
-	port@1 {
-		reg = <1>;
-
-		dpi1_out: endpoint {
-			remote-endpoint = <&sii9022_in>;
-		};
-	};
-};
-
-&main_i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	audio_codec: audio-codec@18 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
-
-		#sound-dai-cells = <0>;
-		compatible = "ti,tlv320aic3007";
-		reg = <0x18>;
-		ai3x-micbias-vg = <2>;
-
-		AVDD-supply = <&vcc_3v3_sw>;
-		IOVDD-supply = <&vcc_3v3_sw>;
-		DRVDD-supply = <&vcc_3v3_sw>;
-		DVDD-supply = <&vcc_1v8>;
-	};
-
-	gpio_exp: gpio-expander@21 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_exp_int_pins_default>;
-		compatible = "nxp,pcf8574";
-		reg = <0x21>;
-		interrupt-parent = <&main_gpio1>;
-		interrupts = <49 0>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-line-names = "", "GPIO1_CAN0_nEN",
-				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
-				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
-				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
-	};
-
-	usb-pd@22 {
-		compatible = "ti,tps6598x";
-		reg = <0x22>;
-
-		connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			self-powered;
-			data-role = "dual";
-			power-role = "sink";
-			port {
-				usb_con_hs: endpoint {
-					remote-endpoint = <&typec_hs>;
-				};
-			};
-		};
-	};
-
-	sii9022: bridge-hdmi@39 {
-		compatible = "sil,sii9022";
-		reg = <0x39>;
-
-		interrupt-parent = <&main_gpio0>;
-		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hdmi_int_pins_default>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				sii9022_in: endpoint {
-					remote-endpoint = <&dpi1_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				sii9022_out: endpoint {
-					remote-endpoint = <&hdmi_connector_in>;
-				};
-			};
-		};
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c02";
-		pagesize = <16>;
-		reg = <0x51>;
-	};
-};
-
-&main_mcan0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcan0_pins_default>;
-	phys = <&can_tc1>;
-	status = "okay";
-};
-
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-	/* Main UART1 may be used by TIFS firmware */
-	status = "okay";
-};
-
-&mcasp2 {
-	#sound-dai-cells = <0>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcasp2_pins_default>;
-
-	/* MCASP_IIS_MODE */
-	op-mode = <0>;
-	tdm-slots = <2>;
-
-	/* 0: INACTIVE, 1: TX, 2: RX */
-	serial-dir = <
-			0 0 1 2
-			0 0 0 0
-			0 0 0 0
-			0 0 0 0
-	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
-	status = "okay";
-};
-
-&sdhci1 {
-	vmmc-supply = <&vcc_3v3_mmc>;
-	vqmmc-supply = <&vddshv5_sdio>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	disable-wp;
-	no-1-8-v;
-	status = "okay";
-};
-
-&usbss0 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usbss1 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usb0 {
-	usb-role-switch;
-
-	port {
-		typec_hs: endpoint {
-			remote-endpoint = <&usb_con_hs>;
-		};
-	};
-};
-
-&usb1 {
-	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb1_pins_default>;
-};
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phyboard-am62x
+ */
+
+#include "k3-am625.dtsi"
+#include "k3-am62-phycore-som.dtsi"
+#include "k3-am62x-phyboard-lyra.dtsi"
+
+/ {
+	compatible = "phytec,am625-phyboard-lyra-rdk",
+		     "phytec,am62-phycore-som", "ti,am625";
+	model = "PHYTEC phyBOARD-Lyra AM625";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
similarity index 97%
copy from arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
copy to arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index 50d2573c840e..e4633af87eb9 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -3,22 +3,14 @@
  * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
  *
- * Product homepage:
- * https://www.phytec.com/product/phyboard-am62x
  */

 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
-#include "k3-am62-phycore-som.dtsi"

 / {
-	compatible = "phytec,am625-phyboard-lyra-rdk",
-		     "phytec,am62-phycore-som", "ti,am625";
-	model = "PHYTEC phyBOARD-Lyra AM625";
-
 	aliases {
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
--
2.25.1


