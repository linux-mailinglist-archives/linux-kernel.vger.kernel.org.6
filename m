Return-Path: <linux-kernel+bounces-229547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E250A9170AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9835B28B41C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8317C7CB;
	Tue, 25 Jun 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="fuLSqVSe"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567317C7AE;
	Tue, 25 Jun 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341662; cv=fail; b=XzbHeAH+7W3hV3d8KJOZq2z2mk62U+tciloES9hPXz4VobEaahzZL3W97iZ+oMMtIjJhNuDU1vFNBzaeRcuttb9jb9sLNJ5wOlhNqsMptT6OdpnOqZ8zi9I6ICC0JGviEu7O7kSRfXQWHd5QB/ak71mCA2r5+3GjiDpCXT3SmOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341662; c=relaxed/simple;
	bh=j3jxeSYU4oHxNQfxt6Cx5KPFeIz/pKq/Xop72ejnH9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tph8NIxy1AAUcLwqjnawd5MePY/RizO2SxP+A5qs7S4nNYJoLxr6O8CmyE3fdV29X4l72dmvJx6BVZKxRjlG0Sd1t1LTs+U8foKCSLBMIQ2fx5zy489DaZxSRgk32i6E7qtT7LcmD2KuI/2ZEQsK6JS06NK4ytqieusgD4fws9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=fuLSqVSe; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDFiaq/VE5UTxrDp/erjvOMPHMV/YxCtPucfQ/prymwdYy33K8LIaVk0m03cP++ZbpL8/O+ZukiKHXm0KYabvx+FfMvCF0JNpHF6Apvt3D10qnSwaS+rMG6GTRsJtNd5+pkQvJ15ewgjPJ/uWxBpMFH0C928HmdYLV8SCHEYyIaOPa7oEbrJOfkbq00eASOKdcOR0tNn89LPepxyxOYyv/tWAmvgAPwWYO7RICG6e56yDJPuFM3KT3s4nWKI1HTZ39pV+nilaHOYFV4arsFl7ZkZs5X47darjBFffrs7AV7T9D7/S4P4F1Fp11ArMWKPNo4sr/ze9z+LbteptiveXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GzxWTZAlaE9sSZPFpOubY3prboiJdxPooethzp3Aa0=;
 b=TBfbdaaAB6vsiirgvFl+4k/maEsqIElXkyegucprKrlo1ZcyDiX762e49wB3pZEmvSPq+ctgnR4pbn0UP3p0c9fOQNF2d8FLvJT21ebAU06hPzt9EiNdUSmMmXDyE3pSCyNDrQxtE6pqtk6O3I/Oimkhfo0e9vHoXmcsApBjPHzRcFud3SV2inU1R/O+3Otai9Z4oXG748XyTMU/swFYVxuFV9vO5C52S+BYd3PBdCHpYLcFMxbxCiE7WuNA9bL1KdJKuipc2OPI1GVQk9XshJAOOgMBNflv2w5+3co4JNQr0WsGqyCCGRWliy+8mX9KTNRSzvwmMbrhJow3zab0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GzxWTZAlaE9sSZPFpOubY3prboiJdxPooethzp3Aa0=;
 b=fuLSqVSehMHvXSHVe9hgkPd2fvn1o1ZCNIHGJIEXpcuvL6pOxn0TRMCDOMUHlEviHHiYYEHhMGqB8jmqYqAiceA+hbwHZgCRcxyn9TqZEjLz2BWx/IrWLJ9bfqWNy31DcCVnN/m819Aks5UrGHqH1dkHwB3GacontifdVlWUePU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH7PR22MB4017.namprd22.prod.outlook.com (2603:10b6:510:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 25 Jun
 2024 18:54:16 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:54:16 +0000
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
Subject: [PATCH 1/4] arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
Date: Tue, 25 Jun 2024 11:53:59 -0700
Message-Id: <20240625185402.1896623-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:610:50::31) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH7PR22MB4017:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4a3e5f-8a6e-4d21-094d-08dc9548360c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/r5+iUbcR10zDfPPzlWmCesxC5TWf90u4vS3U7FJoVECk3ykpWrkWWnZZss?=
 =?us-ascii?Q?dtWp4ifzP2i+0Nc8+VXMSBTrKcCeDlGpGDxCY/VC1g1pqQJ1jV/1BcmR1hII?=
 =?us-ascii?Q?8yKXCFmBJaP8m7AjPg9qrynYBupVkxO6dpeM4e6PYg6rFNDVlBq1vbuSGaNg?=
 =?us-ascii?Q?S/N5fEZwqR66Ph0ZWpm+7elfF7BHmM0zTb2dudIr0I9wZE4rFw9h2gaF1ApM?=
 =?us-ascii?Q?Hg6dbvHXENJMlTUaE6curbGNxW8nz5TU2fM1Aq5RigjMoXzsvaodUnZ9kKNL?=
 =?us-ascii?Q?ChRfzxXVua8DZCe6sSfnhU9VdQZOG6SVN1UW5ePk3x+ySdBDacgPidh29b2i?=
 =?us-ascii?Q?UvMlQ+1NQHo1xMRKXbSZshKkpT+2bBV27d8JlmeJPcBM6uykwaNAdEcp+15r?=
 =?us-ascii?Q?Ap38tRQlv1aJGkbf8KBoDwJl8MK21FCiSpNd6SQ06ff+fduDHO3WKYPmEwZC?=
 =?us-ascii?Q?//UIDudWSlvXMlsGvtq5F1qVqVcSdzYU/LmQTzpVC3wbxMiBTOEg3l+HEumw?=
 =?us-ascii?Q?KSb59AxHWAywVHSti+0aIudxEtF0UNcl4ryDFzh5xIN4ku4vGyym9/3HWb/D?=
 =?us-ascii?Q?7/2Z+Vq053sTllR8DBqJTkxAmf7Y3ICJz2VIoOszoahgzT1PnL9e4A39nj8O?=
 =?us-ascii?Q?nMjdetNOPx8yJIZfotKyfgdomOk+YHbKPoppPZe1RluixTWbt9rzmhFcyove?=
 =?us-ascii?Q?h6Oxb7oVaoTq/JcjQmbRcJnz0sV4okC9N8bNfZFmWLNW/iXYf/SVotOHcH0Q?=
 =?us-ascii?Q?WYqai+6Yd/Xf58KrhLC6oEV7t96gKJPojuf4GoL3PalGQr07B3tPXYWAizbP?=
 =?us-ascii?Q?psmr449+Jhz2XNBlCJJUf85keem/tonCNb8a0WAh+cuyZY866NTeQ5Ux0/lO?=
 =?us-ascii?Q?37PCtqwczIO3W1+mDumDL704BcQ51IwAQBjBde1165nJ1x+rSg+OGd6xwu2M?=
 =?us-ascii?Q?PKkAeuEZrIFEL2jWqpLtbaokXYcRsZnEfVMHqv54QzTL3XYgsIj5PhxPgy63?=
 =?us-ascii?Q?wtS+1bB363M+5TJyWNeXpItQOX7Epzm/skQDpGUY+sW8yKKijPDaazqBUmAU?=
 =?us-ascii?Q?NC7prgxOKuZJmmofemUaRvxf3p5MqApZouVy58PGUH7g/Agwyfex3MLPcJyF?=
 =?us-ascii?Q?DFK3G/dL1iM8/JwIELpjW2Zn2VU9to49QCAbxYpKXFiCa9n/ZUW/oEWO9Hyw?=
 =?us-ascii?Q?wq9K98tDn2YjC2g+kiRwXefyY5rrsuVeggAnRpQP/50tJWKdAMxcdMwGr8/A?=
 =?us-ascii?Q?OobFxCmvTiBqD/4imGNCEk/I0ghQOF7lOE3wV8InjRzmufpeJn4saiOlk/wI?=
 =?us-ascii?Q?T0FtkI9xiuyNgc+7VT8VMTzk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+hWjAp74D62+DbWK2p9GDmyaMvnIiR7Ig83B4wnlBE6+gk1R9uhSDytERKj?=
 =?us-ascii?Q?4ygfQaQJyKEoPymquNzI0Yq0gci8joVg0L51gds11c5YzEpALgsoqaxWt7dv?=
 =?us-ascii?Q?xWpTYWD2XBitx9jgtA2pxJN1cNorMpOliL+QhBfNRE/LMs5hDztP/Q6D3Wgw?=
 =?us-ascii?Q?+GoRQpmYjiO8qtfKJVtkuJZYnfgQ6ItUgLt+tQy8sccrCgybjjaY5jENtZtW?=
 =?us-ascii?Q?Uo8NVlHxamDI1MpHABgjpbh2gUJrONS0W/RBy/BU2yF28LO+ZKDz/OCHBvbR?=
 =?us-ascii?Q?ocLd0BXM/5cm4P7RqpAwJBIQ9d2PkpeyEH+n4jrDPRXn/9yNl8txw5aljJy/?=
 =?us-ascii?Q?buRs5pCQO32ysMqShNjFkTI6ty1YpK9t+LsaWDhK6x4qvvrU7kgIgQNPSLfE?=
 =?us-ascii?Q?WOiTeC1Z5MQNw1lbgBdDfgcEe/Vyrm3DRCzOuKj0HMBnWEfQPASmCtWoGqrr?=
 =?us-ascii?Q?k0FhohrlRwZ3KpdMo0zBGapN9gWsiTjvyfozCMxhJz03kVagKm+4jFcNvwz/?=
 =?us-ascii?Q?OpgHg2XprEZjeToxbkuF7uEleeAYt5jaeh+NrgpSFFNk4E7rb/wew8brVtOp?=
 =?us-ascii?Q?FHb6jP9V97NuQD6Qedg4uKDOT59Bo4H9MVX4KMcF6DCppm1IDc4R3F0l8czs?=
 =?us-ascii?Q?RqoxAC9A6QYuAH41puuTKLPlAU5/PDx5AnvMNsThBJ6qa40788kJdFMoaYNv?=
 =?us-ascii?Q?UEo0QvgCSnKf1pug5ePL8o5eyN1Kvb/0gs2b+Q1FfUcxdZDC6S+hYtQiiLcE?=
 =?us-ascii?Q?kSZsxqBr/IS+SgQmGCz7t1Ud3YR413NQChGnDacjI8AgLAlJtyks4lEnXkvn?=
 =?us-ascii?Q?5bEoyvJp5ltJT+UMbh4zs9BqPe2Fat5K6izvt5qIx6P7ENGOzofYav0R86RD?=
 =?us-ascii?Q?u7HNaNDEGo6WxMsGevNr9WTA0XOEJ8birt7OJTmkHLuW1f+wpXQo0KClpNBp?=
 =?us-ascii?Q?KgKKCNUX5Z5tRa+6inkKmF4eFSrybUNnmJUWV9K7uWtg4snWzWDPzt+aqcr7?=
 =?us-ascii?Q?38EHgvhVWg8mxMQCeNWa6NJX/39b3jVYVkmlHoYNWAsQFEoLAlHWw4j4QM5g?=
 =?us-ascii?Q?4Q5adCfQnBSousCdSKcVqoFWEtaaCb+YVZiRxw9UEq6IUjE8BJ0nC4WHi1s7?=
 =?us-ascii?Q?aJHYgRR23ekyIv5TfbL/2FFoM2wW0HXx06bi7HIY41rrhxSDNgkDkxEG++s0?=
 =?us-ascii?Q?hAM/qklTe8/7KaRYEVyDNxLENm/72h3Ez4g9jPf3wyobhOIctjjiCrh22LKi?=
 =?us-ascii?Q?mVdAP/ZerfIN6PD8W2xOIy4LM1ZNoHHDIbyY9rpz2YXBGEpyEnOPivwDSE/0?=
 =?us-ascii?Q?bhSx+k0cgqZQ8IBJdYMhP7j28kSn1XMDTchvHfaB5yo7z6qdMQw4PnCZAtVX?=
 =?us-ascii?Q?hJc76iff894junn9uDuCBtIlrVNEmD69wLTNMfuX8t0dP+T+73YK96DBTvSe?=
 =?us-ascii?Q?BKC48UmHX2QHLyF5O3JB19NMpTYzse3cSYC/MVJL95e9SM51rjKMDO8B/Brm?=
 =?us-ascii?Q?f4qJcF1iQBomA8dcz0I0DLaCN/OS6kbsUjupqjwJSuMZ5QAayyyOiBFds50c?=
 =?us-ascii?Q?O158DrAiURhnFiozYNnU94EgGqoK29yV0MRmzL+F?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4a3e5f-8a6e-4d21-094d-08dc9548360c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:54:15.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn5X0LSn/7OCZKyGqu88+is2M93L/ui8XyL5RkvIZwB1yrvk5hjqkyd4cneptfXvTQht36nbMvPih4k4LCjIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB4017

On AM62a SoCs the AUDIO_REFCLKx clocks can be used as an input to
external peripherals when configured through CTRL_MMR, so add the
clock nodes.

Based on: Link: https://lore.kernel.org/lkml/20230807202159.13095-2-francesco@dolcini.it/
Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index bf9c2d9c6439..2a6e333f752c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -59,6 +59,24 @@ epwm_tbclk: clock-controller@4130 {
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
 		};
+
+		audio_refclk0: clock-controller@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 8>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock-controller@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 10>;
+			assigned-clocks = <&k3_clks 157 10>;
+			assigned-clock-parents = <&k3_clks 157 18>;
+			#clock-cells = <0>;
+		};
 	};
 
 	dmss: bus@48000000 {
-- 
2.25.1


