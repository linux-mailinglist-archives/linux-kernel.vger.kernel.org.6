Return-Path: <linux-kernel+bounces-304276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B0961D15
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C51F242B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB817149DFA;
	Wed, 28 Aug 2024 03:41:07 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD914265F;
	Wed, 28 Aug 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816467; cv=fail; b=ZIevb4Vkh6MB5IgaIhNis9Mpxbra8Gj3tnJoWKnZDr7H9fAiGPAcew8vL4FBgv7kMUlA0h+u+R2W85uYW7fvzf25r1Ydz2RvTUsdOWJ5RTAqmQJQ0dNVNbiMzWvfsbVGmsDqrqDt6vHjfXezWhmuqxAPSmelXlor3XTmAKHL6Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816467; c=relaxed/simple;
	bh=i1Sfj9qJgZi+QdfCgMETa2x8Nrhf+sWMB4Aw8W7SnEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zg9mffKg5SxM5UZXZJmYRJ42WmCnOexxJnqKJsZp+4f6BwvtkyHbSEr+kr/MNZ4mnZ/oBBRIc6Fq+xR1jLx7vj8LhlwvEueKUE3GtMYQMYYgFbBvXuYCN0phKbL5/5d++Ll4UXZ6/fqFId9U69mtBX3V+sGTAkN+iNPBJrDdiLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP4AkVPAcadByocMr7xKpw0i6RtNbfhBu+7qNdfdPOFQ7tHS0+QlR4fTacaDzQDgYDIHjpTRUHGlaE51DVzzT3wcgBLzycHghrHc40n62AfFWbb4HwC81kZ9VP2JplEk5UAsdPvCPDN5vMBH/i8Ehzdhf6Vu2GVe64aSzp5Z2/wQO57NKE2wrNmUeh70NK1hul+u6QDcpDZ0Hqr5W40ZFqlGGzQi9TciMCwJm9gzShYJ+PTPLaQhb86CQWO1SOXWDJfqPxp61qXsrDEZyN2/aG0eoQHtseVMPlTj86wt9i90sFfwT+bBbXQWK/VttILt8DVBbxeSDzzRF4GMkCYFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1/yXINwA81nMjixGhpNBxFuWNS5aMWklBVqYG9nLGE=;
 b=WgVLEmeTTndG3UbvTsTbzI164OlUsFZkqMC8l28ghm8qpP3+nN35Rx3LteZV5ZcJxO5cbOfkLC9HaXZjiQkTpZ8ZP4xpWQWSnf8zPpIo1qZYdf/V1oKvVhY3TV9LIhfS9Q+IsZEmlBwqWBSGKqwqn0oFARrZe2FFb+Z2HMJtFMaOyM84r2+dEOrPrhQqVWG2lwbnn0gCPR4bqPIkAPkwenDLaT/XT2n627aYkFrx8bMktvlnSGAV3S5X0keaUtLFzRQ48ywPI136V5sZOgo4Z9dXeo9hyYwwTnP+XJCQ8M4M1dVV013NAJTg8SoZnL0HfZF2+ahEtf4Ds/zkZU6nFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7977.apcprd03.prod.outlook.com (2603:1096:400:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 28 Aug
 2024 03:40:59 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:40:59 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	robh@kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	dsimic@manjaro.org,
	conor+dt@kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 2/2] arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible
Date: Wed, 28 Aug 2024 11:39:53 +0800
Message-Id: <20240828033953.967649-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828033953.967649-1-jacobe.zang@wesion.com>
References: <20240828033953.967649-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0185.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: b24ff4ca-9aad-4940-822a-08dcc7133b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kvckncp4+1dRZQthUbRi+3JVH6TclnCVXBA9qnUSmKeaGN2ZNcFH+Z+vddX2?=
 =?us-ascii?Q?HOZoO1Gx4vVjW+aGnUao1Dk+PLaJy752RSpgK8a/++93xFjUpUui39n+OaMY?=
 =?us-ascii?Q?MtJNDquhm8InYjbGuNAg8JUxqZENulL5jK/HS0UHGicNgCrVwGRl2MJ/1S65?=
 =?us-ascii?Q?+1ffgOQ+xOm0T9OovBSVIlzGoQV5qHO7aIdHdiDHuDS257ORrPKkybAiP7D9?=
 =?us-ascii?Q?giKRzvlQuOp7xhJnr/H4VpmQCOVNu5/RIrk/Etu6XSimixCs6KioS5fZ9EdL?=
 =?us-ascii?Q?edL6W3drWIjzmLiThWCxAIqFbhy/PM/rnQ6VsHetMkz+JrFY6mfiOd3T2Jf/?=
 =?us-ascii?Q?eQ2zbV7Xcsk6mm4EEpz3ToWFco8QlrPGg4E/QDHxXNsZu/nur54eqxfDZH/z?=
 =?us-ascii?Q?ZBMbI+f7vcpw9fbLisSc/XjHs/5XI7cOsYe8HugVvfvUY2BD7tDhf1kVo+Xs?=
 =?us-ascii?Q?O0KmsevnMQf8iAHzN53jKuXWUw7GvySb7st5j1AbC4bcUGMIxdi8V+LIbPqL?=
 =?us-ascii?Q?ylloh7/j7Mr3y4E2szFpsLpbZSRGTTozu8lb3pt1wmnj0yiooXDmugtl7Uuw?=
 =?us-ascii?Q?DSG72Xry0nyjZonFosT3627Uw7DPXbnBMSLw3B8OKBkS36D+NsQ58BafVhOY?=
 =?us-ascii?Q?vrXI73k9hn+v1+iFo75Up8yxvQO8JviQ1BrlwOR9q8oN3Y2A5rDaAi5OsYrg?=
 =?us-ascii?Q?Js3QXMR1bSYrjV50y6Cqdl3C5feCFRYvBI7nyPdn0ha/UGjUeqgesPZOnUR1?=
 =?us-ascii?Q?3ZcaDHUcIhqwwlCXrLToVolzqEd6ZlTpZd23Vx/rMU+Vi/OD3YGeJebDfg0X?=
 =?us-ascii?Q?DlNX5EuC2jb5iVJ+ek4dRwN+cGZfK0uhSZxXT/v0Icd7oPjXrvHYUBEUeBRm?=
 =?us-ascii?Q?ViFZpLHRsDd5qbLGRovsJdJLeU2LyHnouSU4H/1takhAyL9h0HCm/G65q3Th?=
 =?us-ascii?Q?1XAOFxpbfWjSPT2orwMWm5Doxhu1tkW03JjHCdGVzzP3DbIjwnUAUlJbY4oF?=
 =?us-ascii?Q?2hwmYpmdlqU2PUrGZwfDqW5lFLTwjvqZ/KqEuogAIxfc+a7Y3TiYHJyD/WXl?=
 =?us-ascii?Q?lDa22i6unCyOkiLTPs9B/J+ij13dpRoTgdnvLZDu8z8u5HJn8X5qj/APe/1Y?=
 =?us-ascii?Q?72E/0weCRZhWVhQ2R+Tel1V8taYH60/vL6li/TqCOUzca91cAFMv6wcFAMEX?=
 =?us-ascii?Q?bP/R3X4kFAia41SlNDISFS2LjhANrXuoZ6uOo06Y5MlUph6m12qRPHkCY+fK?=
 =?us-ascii?Q?f18BwYajIPBBo6zT8LDdOejtxohljXkJAFcHz9ub84Wp6e/SKKKA9wdZkSIg?=
 =?us-ascii?Q?+IZ8XbvlmZewJHq2b5i+aULK5ARDnGLPouoiEqeLgZScw1XusJy0kBJECvdE?=
 =?us-ascii?Q?DC9QEwPyZqEcgBwz789xorgHfv0SrNHm4KiH8kX68PhjNn9f6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Z44O3YfNl2N7M/RqEN0lzTZe/hwB/VoH661GYBSCHExZDbH7bqVQHhJ+FYt?=
 =?us-ascii?Q?VjjlRHRy67k8MkxPTmMdS4ZfNUt2h0dLzaOsNFaYLZDW5Ykftd/SGLK3ZDji?=
 =?us-ascii?Q?K0EkYAZgCiC/B2XjhaQ+OOwVC/gmj5Sc7nEQrMvlzK9H7Wqjlaxun7cUmZdl?=
 =?us-ascii?Q?ns79FmoFa3NoPC78/nMmzKDBpgkrcUWn3xzpRnY6orq3zsTE1trMGC6SPamg?=
 =?us-ascii?Q?tTzyE6XzZFhiKv5hSNQxvZWlekov9Ro+7KWUL+lw1g5gf/NNyH5Q+gVs2Yze?=
 =?us-ascii?Q?6S5+kKrTNKdBIYAEfShMm543TxHK2fxys1knK2MhJiszKNnrsWmUT1dw1RE9?=
 =?us-ascii?Q?TCshcgGySzZuUReUu9FyYzuZoaoajdLBJNdUU5qAbZBsGZYsVsUqt8TLAAiD?=
 =?us-ascii?Q?ixQQXqVAX+zfUO1n8vkliIfuUcLfBV6n3bccbSvviSYDzmGq++PqdgRxAhzf?=
 =?us-ascii?Q?SoAUBVJukhgYcOBVO59VeX+FOwNvzTOg1M4F33Ug0bTIhVj9ro+hK+PQ7ITz?=
 =?us-ascii?Q?hRGv+nzuu7br+G2gLmjuBnifpuHUPG4z10B3OgJmxNUnhfrRlOJIxfLDeOVB?=
 =?us-ascii?Q?yuU9xsmrgkk2gTDFy8DIVsSH25uZwAKxvfoOHeNhDL3IIMZ3iFX4LG44iENQ?=
 =?us-ascii?Q?4TkezzZMyMqAyrZC9AI3IHHuE6m3YQd7d72WoUg8CERemAuqof5tUxBJnVZG?=
 =?us-ascii?Q?HJZ25IYO7/eEztWsUk/b1OoXY8HMxLoDrdrMq1lOXP5aTuV5h4AJ+hMVkvjk?=
 =?us-ascii?Q?FCjLjU+38jVHq2ZXSQ/CD06XLtrTfqog5b5GMv/BB8YcsnR4YCbLEfIdwmGF?=
 =?us-ascii?Q?Qg78idDcS4TXguHLNE24S0qdaYGcqQQMjjYX1azmTytzBBWt20N5C8yUWJUS?=
 =?us-ascii?Q?gwiHySpYjqpCT+7q9NEnuTGIG8pg/Fmi4iscwuZh4Pt8ZD+ZXZB3l8Zk91gN?=
 =?us-ascii?Q?g7wOGQFgv5iGP8MlZkbABWah0yQoLRNHYR60pOwKmFx929mBV8k4hZhji3JY?=
 =?us-ascii?Q?IkFEvvomYtmUzpIGeKfDdPMGSOKAwptLVtca7GaaoRc3GsaezE6T5H299sK4?=
 =?us-ascii?Q?htJQLMf8m1+mJgwyYV9eZs8+2kKLhDuLuUkIBJYxbMTVrwJh+WYxMsfOPHMM?=
 =?us-ascii?Q?gBYZhWjvPEF16cxgYBmWbp8yj0W55YspgGA+OWWkC+QntaXpenD+7zBpVPqp?=
 =?us-ascii?Q?/pZ7J5NKvnth8XbrUiGjkfKoU9kiNqM91LancxLviJAqSMvyEhxtg28e+5FL?=
 =?us-ascii?Q?hgPKpOTwihYsv57HUhJ5VHnPH3CprhvDmZJSN2EKaB8RNVMiNRMYl1KVLsyw?=
 =?us-ascii?Q?Fmr2mPTRjsaTCI8nMmG9+323aKxSaVtyBmojJmsIaBdZfdes8iNtyup/Hjpr?=
 =?us-ascii?Q?CSk90JmobN2r4sneu7PlyGiJAtvqQGoOmxKtML48UczZdoyStUIZdu5fE/My?=
 =?us-ascii?Q?z8LUwWjK5dZULQqNDIV8M0Uv73DUVpukd1+W52uEBVM3dFnepsgBZjR7Tygy?=
 =?us-ascii?Q?MgyhRVhg3w8e8448H59Ly0HXO65HDj2FhB6GNSYfqxrPetvOhmVl9rsRJQ93?=
 =?us-ascii?Q?SRG4BGHvWmDYhwJhj4FowBiMKFctLGQl5j4YBqlB?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24ff4ca-9aad-4940-822a-08dcc7133b38
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:40:59.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIXJ2GRK9omC5Q1E/AeAevDhAftoT1tr4mOYKOXRn1GlVttAYaf0dppPWzqtHP7f0AgU76TajVca6peEKpu4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7977

Broadcom driver need to check "brcm,bcm4329-fmac" compatible. Before
PCIe devices used PCI ID as base compabile so add it as fallback
compatible to pass the check.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts  | 2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 5988a4eb6efaa..4b021626d4692 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -72,7 +72,7 @@ hpm1: usb-pd@3f {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: network@0,0 {
-		compatible = "pci14e4,4425";
+		compatible = "pci14e4,4425", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 00 00 00 00 00];
diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 6f69658623bf8..df2a63d8dd5e9 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -43,7 +43,7 @@ led-0 {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
-		compatible = "pci14e4,4433";
+		compatible = "pci14e4,4433", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 10];
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 0ad908349f554..5f3453e109b85 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -43,7 +43,7 @@ led-0 {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
-		compatible = "pci14e4,4425";
+		compatible = "pci14e4,4425", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 00 00 00 00 00];
-- 
2.34.1


