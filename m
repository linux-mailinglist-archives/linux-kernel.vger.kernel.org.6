Return-Path: <linux-kernel+bounces-193209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 329508D284D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771FBB26BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70914037C;
	Tue, 28 May 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="B3eC454D"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCA13F437;
	Tue, 28 May 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936718; cv=fail; b=bmadAu8aVz/XiZj5v90m04FW3aSy+5Z98EcQAeL2j++d2FNP3RuBI5EqJ8vRWS60PaQW/3mKtpTxpVWrloMosHOz9iDlk/n5PYBIrFVO8xPdxRXDGiL+yDaZzQZYQAAj7ELc0SnXEHxpu/JJHGSupcMHXsM09GibOd5mY3Mh9iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936718; c=relaxed/simple;
	bh=l5o8zIEntCSGDeBLYmrVsY5MScN4P8uCDt0Lf87vWDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9LcOMwbaGC0cxAe6KeUqT2ZvsOkxtq9J0wc5qjrgTuqnS7TjgEzmYPbdkAO5zlpz8jvO15s7mxti/hIXX0meBWOlM7X9t/EU287NrpQjj/HpN+jzNM67WelVslQykCwK30EFvzMkkieS50wuDLGG6Bpt9Xgzke8R189HEG7mas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=B3eC454D; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knkojL9Ie7VIWpDPiHF9jNJWC+jp5ocetbLZeCvS2fe9JPgCLKvr5q7nSbwRyC6eBLTDS70GQWLrXD9WzfyA22cjakLoUWZ92ioSBXrOamqIp6givoPGJv4SxHWDJViFsiQJdizkUxrxnumc1sAGG3hO4NpNJgnDYnxxjaUiTkUR9nEknRxbL6gUUIIxVvJ2MCqG7uYCeBhzQ5C+vZCo/ZsilEa0gJJP0a/TD9ETjHAasfPTWqOoqf/3RU7xCVAjwGud9MqlUqXPBUMs1zKl9p2aBeDOhXbUt9yIf2U7NqluhGChdfYlIVR76O3ar2u9nhKVMKsPbOJNsz+7o0vOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2DsaPv5lqwpCDJqvV8EC5dpqT4CBz9E3rLbei0+HL4=;
 b=Fp/OxfVubLfPPVY4bigOojRxAulFv0R9FP8G1lQmdZ2WJtPBZfZaJXuVGUPbJqJD5b4w0sZcS+mX5ZaTII/7XIxA7NbqvnZWAC6LhwfIKdi8XxowbG5vrOAfZhoXNkxrU11b5CcSjdZ6pcpfrZ3ZlV3nQLaF0MugoG+r7r34q1c+5JBpIMGnOxq3csua0t3eUWMJhQzTWtqLegPnxZixxosbWve9DMQY8lDVtwtOnE6n5cdpw5xW9ffLwW9zmS66lKWHUQ0FytU1mAxqEWhpaS3syzbZHVhx9lICa1I75LYePoyecA93agL0xV9BXT9l3o969S1vb4xSW7w6CbCaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2DsaPv5lqwpCDJqvV8EC5dpqT4CBz9E3rLbei0+HL4=;
 b=B3eC454DARiVj+rN7PMg5Ycy0OCGnFbb2qOliEZYizgOWs8Xnhw/PON45K2DowV48Cl8uF3H259R95Sobp/XVG2qQw7CmEhOOPhwS088AI6+bT98rHdKvipLiYtJ3VsOyzORPr470Qi8zoilDzQAFn9u2yk7C4jt76kjg4S4a9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by EA2PR22MB5065.namprd22.prod.outlook.com (2603:10b6:303:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:51:54 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 22:51:54 +0000
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
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
Date: Tue, 28 May 2024 15:51:37 -0700
Message-Id: <20240528225137.3629698-5-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528225137.3629698-1-nmorrisson@phytec.com>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|EA2PR22MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ebd197-067c-4dd4-f824-08dc7f68c504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZd7QurRtTcuS/9j25HelnSVsY32ZCpL7u5IHLUj0XAQFE1076B9qKT8ICQa?=
 =?us-ascii?Q?RzsbV157A3bdBHS4TzdUhlUhIF8eDwWS7eOUtr7ePUH9n2TDs9Bavm1Ql7uQ?=
 =?us-ascii?Q?w9nNfChNBTeOomfSEiCwiWLTIxXCOJkweJ4cXDbNU+dmZKpB9xV8zvnKBlUp?=
 =?us-ascii?Q?A6B7MMcduSEP3hi87HMu6QQbQeLJqm8ek7ZImx4edIjFz9PSeUZ8HfwcCdNH?=
 =?us-ascii?Q?QjZJFAK7fsn7OIMf8J3Wn1J9XEr/a0vdgVzZRk1daq6mBNbe7/+ijGoTRuNW?=
 =?us-ascii?Q?OrPiu5w88dyGrJPR8o86EuADcHvWL/mOvhlOO9hHdXGNt1IXB8ND4E6caExy?=
 =?us-ascii?Q?TfKmMY+vPleYWdoLwzY9zX+PPuCHTJZfmGVzQl2Kau79Segsh+VybxfXn6+H?=
 =?us-ascii?Q?iFmyFb1vja+efxkTibMfmICkzqJWcR/DT26bWMlTgL/sCzA7HcqL03f0Os9L?=
 =?us-ascii?Q?zdy04LKRLCoSJaNfUgqe2FKroLzW3n4uqq1Nr0GilIE+bnpvsbxSlSG+tAfV?=
 =?us-ascii?Q?2SIiuuIK5wvPr9redZPU3Yq9DPAGY4qAm4lckhreDm46tiXjHGQs4nZzZdLn?=
 =?us-ascii?Q?/hF/0Z1+rkmbm4bXsI7BCNXd5rub278bdX/NotGcEj4l4adMXi4VIXP2SCTd?=
 =?us-ascii?Q?2D3q8mhnX+sg2GXiIvFzKIPnmTwCs/ZBGq7uqL6mll4cECVikIbLARrhUi1J?=
 =?us-ascii?Q?48us0dmUt3utCvSPbbLMgpeCQ5BZsJnzAzcc4cx2+Xgn4f1t11jWm6CdEyji?=
 =?us-ascii?Q?88bi03BPysNd5ZNg2TuP+Kwlw4rrbW67EEeHazA7C1Yfewwr8wI9l4PZfP6Y?=
 =?us-ascii?Q?OfoGaC3INTYBToc6CDNEc6pxhDroQNVHXHxn9HwYO/jlQAJLACnbtNFQp0EX?=
 =?us-ascii?Q?8bGc/CIP+gpTJvosrAQN6eqlW8f0F3IfHjC2GXWbVE4NhB+x+HCAJFXVQ45s?=
 =?us-ascii?Q?bbd9lOngg+5wGvcXPO3qserObIBuBRDtCgabdi9Lygdcv3cp7yFRz7t0vSTb?=
 =?us-ascii?Q?fHxIYbETtpAio94O8McGQHrp7um5wf2rCBkdp3/eYQI+CJGGSxsZuIqu89Q9?=
 =?us-ascii?Q?4uTTj3i8BUlM7wc4kx/UeB+Ja5OIsqVrteHvMnF/ufxe37xvDoEJeZJwBxHc?=
 =?us-ascii?Q?g187YoTJYwU26+61qSZ3OMwdDWC5HB66K2E9VP6s/hwHi0Hl2E/73aDCkX1Q?=
 =?us-ascii?Q?8Bwyil86Z8xECDF1O4QREVv50yZEdr8+0F+v8Si1zO0nkygeybDAxuz84VzZ?=
 =?us-ascii?Q?++zzJS23DilZ8O16jh4hqDP1X6c0aClTiHYBYFwq6Q2thq5CJrMNuvo9/0Ko?=
 =?us-ascii?Q?zwDjKK0BeiHTV01/Dc4tS5wWVoId1Qh8PGFfUx1ZHnMGIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00aTXlZUKggVVleGpiJen1FgBR4m8kfd1e73KG9gl4yZj6J06fU6aNh0Oen3?=
 =?us-ascii?Q?V+vIgacfaWzkPBvVWBKd3p1efUtb2mVvW47qjNu32Tzncc1KDZIgVt/g6na/?=
 =?us-ascii?Q?QUjTLfmQlpDW/GJ8++qtRk26wZ0ziFy+lXjmVYWdkdX0vYh77H6894E2O8Cv?=
 =?us-ascii?Q?oSYx4QhBJ4TQ8EkJDOY0xB5D60mVaFNuOuaa7YFEUu7U/yQuK+z6yXks8fOc?=
 =?us-ascii?Q?0A2uv+YsxeglsC8eIYP1vt2n0IxQ+0UV9EElWncjq4cVmvFkt4d3eVYQQJ6V?=
 =?us-ascii?Q?UB+yYnm71j9a+wjS8vLmRRiprDVn2QL/DJA05XxySOZb/Ag5ke7y2zU9Sjse?=
 =?us-ascii?Q?H7xefu2dsoTZ7Tm3ObY/d398PNpDXO4Sjrb98zbyEQNRcNd1CYpOitbYZxhD?=
 =?us-ascii?Q?Ux3/ZWXdicJ5wdqAoBGPlF7m6KmwC5tKr6iaqV8Yf5EFm3QSsGis8AMf6Qu6?=
 =?us-ascii?Q?5EzBXOxy20gLr6O7dR5F6Q/3iprNNEn3WODPhp/F0jsOu22k0zss6eikNqGG?=
 =?us-ascii?Q?r5rZ0/3BqhaXaAnEPVHkJIc1EstknO48O2+x4LgYXLbwkh+LpkkOzNPuyWIc?=
 =?us-ascii?Q?7FViqcQaEedGWbSL/sJ+iTegUWYqvDPhnukt3+R1b3vk1JwVQ1YivxjTMEqW?=
 =?us-ascii?Q?URmSLPMda2IdQaduCn1T2Av/8Nn7Gsd9utdTxMBCT61n1LwAkkZlwJCf9jer?=
 =?us-ascii?Q?lwd5x+Qfcn35Bcvj4OSrtbEd1cPpg3QnuuSji4sE3SgZQjgoXZGajEkXL/gR?=
 =?us-ascii?Q?/F7Yu6ffyCe44Gi0KbfttX/EKrYf1nEszCWXcQFzi3sYZ9ih6le1M2h7NUwE?=
 =?us-ascii?Q?XmawqTC7QWQrJGqfJvhB2ErSMyn27EyW25SIyu2OdoRSZWaYi5qHYsikC795?=
 =?us-ascii?Q?lXspWXPOKyV+S7KE6DYKO+WlKA1sWz4ptC6gHJmnhWFQ5b8afrrVottrg1cF?=
 =?us-ascii?Q?b20Ry6WPbu3xSH8Krbhiq36my5XCEOmlZEGoEqbqjZiw1ijsELAIhQwUspQq?=
 =?us-ascii?Q?IkoWOPoeNVb+nZGaVKKhNeXEs5lbBwTnBxVoQqKNfhdLQhVVdnRATPkETedE?=
 =?us-ascii?Q?qo9VHxFcvEqTiH/OT/378lQyFLfuOehiSYRESESkwDfQdVhIMaigsH8CnTuQ?=
 =?us-ascii?Q?CZKZwWx2ZO4GWrg7LvYA573P1ntl/tmbME2CFvj2XjCRRuK4MQ+2Pvd2yb3w?=
 =?us-ascii?Q?zAE2Mmgo/0Ip97a1yBRP5R0tc0k4klH1SVCYlVbBqLSuJBhrvbFsK6zgvORI?=
 =?us-ascii?Q?43DuRfBfY9IhMPTLYBbHZyeIQJn7pjvZf+dqeNPvWHyb9bOKumUIBWlC8hYT?=
 =?us-ascii?Q?8Vj0Ytn3WwK4UMpk96XljJfsbWjOO9dORBSa/t29JyCOEy+tczP6JfIpIknf?=
 =?us-ascii?Q?2FH4ghqpJ5Bu78iCZHAqBlzeAltPa95rQ0rZhOfSeG87Evdo4My1LpbGhTmp?=
 =?us-ascii?Q?WZHiL7Hu2vVvmWtbYb5MVTsQd68kKwFjjy7oxyCJ1Rr+cChTamk1nZigGa4g?=
 =?us-ascii?Q?GlSBEAw+BrHzWAVoZ7FA5f+XG0wqo5CEjsSe8YkDGEuzAX53Gyz41uuScyMu?=
 =?us-ascii?Q?OOU3BX3mFXFWBgOXhb1PHCPJOfP9FQsSzQZ6qsxR?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ebd197-067c-4dd4-f824-08dc7f68c504
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:51:53.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EBmoeF3HOzEyUmfi9e9LiLazVaeh5uYDddMNsP1o8e6rBlPExmYueY5nwDNd7/5GXinPnmRiOVsp71GslrCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5065

Add an overlay to disable the spi nor for all am6xx-phycore-som
boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2:
  - Add build time tests in makefile

 arch/arm64/boot/dts/ti/Makefile                   |  5 +++++
 .../dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 3d0e87a78e09..8d8fc8bfaf7e 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 # Common overlays for the phyCORE-AM6* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-spi-nor.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
@@ -115,6 +116,8 @@ k3-am625-phyboard-lyra-disable-eth-phy-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am625-phyboard-lyra-disable-rtc-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-disable-rtc.dtbo
+k3-am625-phyboard-lyra-disable-spi-nor-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am6xx-phycore-disable-spi-nor.dtbo
 k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
@@ -144,6 +147,8 @@ k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am642-phyboard-electra-disable-rtc-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-rtc.dtbo
+k3-am642-phyboard-electra-disable-spi-nor-dtbs := \
+	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-spi-nor.dtbo
 k3-am642-phyboard-electra-gpio-fan-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am642-phyboard-electra-gpio-fan.dtbo
 k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
new file mode 100644
index 000000000000..cc0cf269b6e4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 PHYTEC America, LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&serial_flash {
+	status = "disabled";
+};
-- 
2.25.1


