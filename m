Return-Path: <linux-kernel+bounces-213950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB4A907CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C48B25DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26461137750;
	Thu, 13 Jun 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Ej01El2W"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E07F48E;
	Thu, 13 Jun 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308232; cv=fail; b=WNPtOTLekf/LBnfv4SdiTWZZbnSfZ67+tlG09uju8JQLJDHZMSMOBvenGRlHXT73x4TyyVnmhgrzAKZEY1e6iJFraGctirYltvPaKliZk0Ye9NDu1EIpYoJSNbGic1IbsHFXZMokppLdfyK84tN4MyWEQZHDWSvIMugyNUjoClU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308232; c=relaxed/simple;
	bh=ITyBUsmhdeHbmC7vWmYYaJDCEBi8avETuRGODVVrB08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFMziuhZa678/Flqk67gdi3/xe5tsYSShpLAYBS/kXMTWqHGwO7vtpK7wK137GK9E06Qplyz5Y66HqJfcCicZVWOL/Rn0U0SFi/8s6vAGfpdptjuq+aqePXJAJ5BHY/FEQoLi5hXG//yX2yyFGRSPRIJsqmmAiIS9B758cuG3Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Ej01El2W; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFHtlu23OtLwZoEbA+4+B2c9d1IH+FhN2VGLcX2BHx8kE6ov6zbxYJCa4lU1oAudVgPKyfMEHoDK++WPnwO2JX8S4T7ywTdhadea80HT4Drsgk9o0H0+/Yr3OrW51/kFND1o+vyp+sZbAdVp9yqWnNWh3fvTxrwEPAw7IDdcK/HCxGPoaqCnXSk+uGs0u15vpnaaMnXYjOVOS4kW5budnvQzPPJENE5RhHZPIXe8DfyXeeBWaYWzQjOZWFMe/mhAtrq5zWdQoJJtUcdYInsHob/7F6v8LS5aG/ZVdPeq6rIgGeKGcV1ike2l+ARwWghu/faYNNh0a3VKbZ/YBc6BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HBG8ZsnNgSF2rIlnDulYDsPfVPlKLec9DkaFID0fAc=;
 b=LSd1mWr3dRWJ1zhfgdk2fHJgqNarbPzsylBMUhI3vten/qYn9rbDiAIJ2O10oAPDuwQ6EmhqO2hWOR45crzPNBnuqo416xFri3vyhsBwMV8kFbpx+IEYbHs8yujqFkbzaWj0cs+XGyrSVJv9xvHOHljyVPUdPnAVLC9IljYaSSRH0NSOkMR3wcdYhccvhPJ6VpIBoKDIESB6hw6ueD7wF6qU3nnblhftZbrtK5HMh8AWpgKOWatuwMq0ShbPE2L95hhEOV0un5o0BWrJwEdRuI6IS6xQvQcp7q8DIMD/lEzHD14L1V1Hm1SvIyrUveuNb8+urJfpqi9L5q3sNIyUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HBG8ZsnNgSF2rIlnDulYDsPfVPlKLec9DkaFID0fAc=;
 b=Ej01El2W68TQtIHnto5H0Hx5wmX/U3RuLgxaX65+go1mLL0aOWwOhmEvRMykLNq2oO1JFmKlil9WlISp44KiOfCFSPNSem81YSJCLYY0KLLrN8xmAj9cxdxB3uCgJI95GmEM1648FZfpCMKY6vR8OI5t89r/nTyEy5u2igvKE/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by LV3PR22MB5145.namprd22.prod.outlook.com (2603:10b6:408:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 19:50:26 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:50:26 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v4 2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
Date: Thu, 13 Jun 2024 12:50:12 -0700
Message-Id: <20240613195012.1925920-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613195012.1925920-1-nmorrisson@phytec.com>
References: <20240613195012.1925920-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:610:119::34) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|LV3PR22MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e9a4d6-74ef-48a0-3b81-08dc8be211fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6ow1A+aS4a6wUCWwN3xtNDtXL1YtOQ8Zvtoxfp+al5DOFwLNd+ntbcz4GPR?=
 =?us-ascii?Q?Sq78Sd0GRZGNCVOBnWlCu2VzNrhzZe4pPjevgO0uF3J++zrEOLr64N9Svvf8?=
 =?us-ascii?Q?dkfgFfaV+dQk1caQKTRh3RpAqpJOfRaakcotW6Puq11WF8yaFVPBojnofmU5?=
 =?us-ascii?Q?pe0xKMO2OyUVqKhqiyZaLnl0xAgrCv0SsMBp6u/IX7mDhLfzfsWGH0azDFff?=
 =?us-ascii?Q?c5f6u4bGJjqNim7v8ve7S9tYI+6e8m1wp/PXN0SFL6VRK3A6Ax0hMPFx6GwA?=
 =?us-ascii?Q?K8VXsTZdPidz3ZMSXYpOo3LgDkQKZSJpAha82iGz+H/Wlqb/f2Oy/ylP/tY1?=
 =?us-ascii?Q?bII4s7c62FYN7NiGdjHlfSxccQrIyWiSobwhRGTVwWiBvGfkWWn53uoHB61/?=
 =?us-ascii?Q?PasozJOQWHth6QUDFDTpBd1bNdgQdDyPn5C4ctEq5wOQR+OhNsTGTgc/gLk0?=
 =?us-ascii?Q?jonhcVCsybrjLSjvDQkgz/wPwHJZ2jihFYmXrLz3fFDQr0WOD/1tOILerELk?=
 =?us-ascii?Q?3EFISvzZ5J1mbD9frWrZDV4Eoy1GbeJ/jeHdFBsqUzMS4TdrFkEG9LA2A6ZQ?=
 =?us-ascii?Q?1aj9792ovzMXCf81/xCjy/Moms7KPULjZtvx6MZJ7Mcz4ZgRiwATT/djWDiv?=
 =?us-ascii?Q?jH3N+UtqODPU0LpHnouYqZ++gPtPtA+hBBzTg3FqbR745R8naNXYreXoGgM8?=
 =?us-ascii?Q?kLslYXJX7UZtQb3LMz73rWr3f0O/9GxfhjMpKQRLyPdozPDe/+dZdTLDNayW?=
 =?us-ascii?Q?g31qOSV67C9lJiPNyV75wvsiQkaiTapooQSEDZyNPnWkRorFq9EE2EPf+6fm?=
 =?us-ascii?Q?PvFEUiyOcm9uoAm5+ur0A367vWvruC8AXjpaEKkwBuhuP7UkKs13CSpfHds2?=
 =?us-ascii?Q?AvV5rZkxZaSjYV96s6PGYFJz6OUKZnS/wgwCRYDROQfILCQFWI7IPdOSbMOB?=
 =?us-ascii?Q?ieX4aAQK0Rkpnobbr5uXNpQYeqj8TGWN4M8ZIj2b7SqWEcNucsPMvVIWXNPW?=
 =?us-ascii?Q?0QW6dwtI9E1W8hq/VS/OHpntGRMZ2C4K2PhMXk1Bkoa8S1hc8QYjYX0w0QJA?=
 =?us-ascii?Q?owDDqGJ/ikxQaOaG7iXVDv09wK8o0GchuDvFPYP8Xq5FxsnNAs+gt+cLoo48?=
 =?us-ascii?Q?GZig/sBN+VkNJZr+12usiLOqNdrrOCE+Ijw6W28DYwdnfNgdNKY4COtQmUWh?=
 =?us-ascii?Q?rHcLLesem3Zy7F8uWjl6/k/VB0ExKY8hD1t9rWxmiBFc5828+WOt/gG4dAFD?=
 =?us-ascii?Q?kBrilumbOcemB9p6S6sXwZFR43bQSRQrhSwZ5YAzJQcJF8OxenQ2MzQMBCf8?=
 =?us-ascii?Q?YF+ucjqV5pCGopFOQuilm5q5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2Z6SDee3yb4C93c1Y3sf5tPCEMnR9vYn267sBABpZzHRPo8zJGFKt/Ftp5u?=
 =?us-ascii?Q?rzBfbq7MKVg4xHc8J0KX5XqDZGbNnJnlPO/5bjU/mKLNQQjvWHNUB8MLcWYL?=
 =?us-ascii?Q?CHxuvb9JxwP0TpCfN3DuhBs3lYFGTOXzNFusksNxY3RpQR54bkMXUzXyiccI?=
 =?us-ascii?Q?V0WwkePgtPh6OAaszJvpltLjskvgHZtEK1VYZWCJrOZIxhl2vcS8wyLeL/0P?=
 =?us-ascii?Q?+J/irrFjHs3TjDyyX3DE3dvjuMzfe8Slc2An4N2Vf+XrlS5fbxi0uREjO6Z3?=
 =?us-ascii?Q?3R2BSu9R3wY8F5D6vIlqlOQXOkioSGFd/BdVjuAAg3Q1qnmhQlrInh+2BNFM?=
 =?us-ascii?Q?YMZzpMl5TFJEBIZXHBQw9hKGrRutis7Qt3j6jerS7KzBSzUCHJHaCDGjyPJM?=
 =?us-ascii?Q?V+a1CiFeu2XFAIXow777IZqhRHvPwz3FiP2mFcS6puwi25eh2yQQTI07dpUN?=
 =?us-ascii?Q?oVHn1geyckvV2Pufjp94moJgxJaMgaKDRJjwPZ7ld8piuLm3GzsxGTOteDeL?=
 =?us-ascii?Q?dDQ4We61Ecv1FIkDyFmQhQmX8M/fhpJh3hIimCEHgqvJZhjJzhOZY8TeeX5l?=
 =?us-ascii?Q?MSYGWT9xT0qNFxowVwN7tC7q0d/iTPT7wJyHTLjmMWTBdxBouSI0XjO1BKao?=
 =?us-ascii?Q?Zxawh2U+vkiix6pq1EHN3tBe6OU+7jm6ZRQXJpZs1R80SyQj5a2p1CetKB8t?=
 =?us-ascii?Q?T4K2y6K4KH88Me8ws2Ackhh4KShBT12DTjQ6K9+MTN2Z5lMqM9w741vW/WpD?=
 =?us-ascii?Q?3FT+Kztj+hGYZSlxo05f8zhvymSs56KHqu/zTLvZQq2aKJbmJGVatX9g0LAY?=
 =?us-ascii?Q?vfGMXZeTXqkeIZ8D54bFY21DFOx5tN2WVUepuiYS1cUXXkHv/FQ6dpBrT6Cp?=
 =?us-ascii?Q?OSjra+zOd2sr268QSIo1Pkyj6f5v5DtDd7SegYTRujzNjvPN6d+R/V1YYVQ3?=
 =?us-ascii?Q?l3CrB9lL4WwUJAXWfQZM9Z9ew6ND5OJFg9P6n4pCTC1QnEMDDIbC5VyYu2ys?=
 =?us-ascii?Q?fuuIcSZKE44awaUJkkl0LdkM8JlpDl4dsXJy6R0UA1ra/NZQo30MSxz9Ej5L?=
 =?us-ascii?Q?7CrpMGQaSNDkzas0Pu2vVstYVhYbxj1W0tpGxqzd171GWHRRYVLqXTmDHZrs?=
 =?us-ascii?Q?qw1dq+DgSQ8OpCSQ9Jf70U9WXkiN3iVWUPPchsk+D7CFr17TUBeJ7sfD/XVm?=
 =?us-ascii?Q?h9KtLl94eXALrNG8/rKqPPibQR+0O42MJcaIdzq1C9Cmeejrh9LV2aBT8jN4?=
 =?us-ascii?Q?bxp14k14SCNt7+SvlFbSBigLjQwvExfCLzXxM2f0jNClkv78T3TV0fXR6NsO?=
 =?us-ascii?Q?s2trhVw72i65TCQMMa6udVL3VtgtAjtEUQUf3fX1zA1QM3Q6QIvfeAxYCcqz?=
 =?us-ascii?Q?KTugAKKFlSF0Lj4NlsSQbl2eAaOfv3iLrkmduCC+N21/tPGBDQy+N0JLvlp5?=
 =?us-ascii?Q?C535FlWYgdqjOTSFNOK41d+9dBllHz3aQ7QsixxsTQx9MGjDUEc2gdOR5t1z?=
 =?us-ascii?Q?+eKC+d+k1p76ed2XJTaiDBWwN2+7rWKRAucECri5Li69HCVP1DBwrxAWEbsg?=
 =?us-ascii?Q?Sxee48eVnef4nN2fcQrZEQNBV2+7uMzAowR1Gx2o?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e9a4d6-74ef-48a0-3b81-08dc8be211fe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:50:26.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEtk3WBCtd1Zio21+YwZ5dTPHrYeDc0w0zaVVysXb9ZAuAthfW8ZtK1zMPjhPLF7/+STtNXy8Fu95TJNdmkh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5145

Add an overlay to enable PCIe on the am642-phyboard-electra. The
serdes is muxed from USB to PCIe, so we are restricted to USB2 while
using this overlay.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
v4:
  - Add explanation for disabling usb3 to commit message

v3:
  - Fix typo from .dtbs to -dtbs in Makefile for overlay testing

v2:
  - Fix double space typo
  - Remove redundant status = okay

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..1906711b9b77 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-gpio-fan.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-pcie-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
@@ -134,6 +135,8 @@ k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
+k3-am642-phyboard-electra-pcie-usb2-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-pcie-usb2.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
 	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
new file mode 100644
index 000000000000..7a5ce4bc02f3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DT overlay for PCIe support (limits USB to 2.0/high-speed)
+ *
+ * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Matt McKee <mmckee@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC - https://www.phytec.com
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+#include "k3-pinctrl.h"
+#include "k3-serdes.h"
+
+&{/} {
+	pcie_refclk0: pcie-refclk0 {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_usb_sel_pins_default>;
+		clocks = <&serdes_refclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&main_gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&main_pmx0 {
+	pcie_usb_sel_pins_default: pcie-usb-sel-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
+		>;
+	};
+
+	pcie_pins_default: pcie-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
+		>;
+	};
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	reset-gpios = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_usb_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+	status = "okay";
+};
+
+&serdes0_pcie_usb_link {
+	cdns,phy-type = <PHY_TYPE_PCIE>;
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
+};
+
+&serdes0 {
+	assigned-clock-parents = <&pcie_refclk0>, <&pcie_refclk0>, <&pcie_refclk0>;
+};
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+/*
+ * Assign pcie_refclk0 to serdes_wiz0 as ext_ref_clk.
+ * This makes sure that the clock generator gets enabled at the right time.
+ */
+&serdes_wiz0 {
+	clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&pcie_refclk0>;
+};
+
+&usbss0 {
+	ti,usb2-only;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+};
-- 
2.25.1


