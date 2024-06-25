Return-Path: <linux-kernel+bounces-229550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED69170B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A428BAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767A17C7A6;
	Tue, 25 Jun 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="QHnpEygV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD317E46B;
	Tue, 25 Jun 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341669; cv=fail; b=L962bGxwrFTceJ/djuGP0VZy3XrgVRBfdBFkJb5NRtJ5N1Ile1aWpAv1CK1PyeuFABHUX6RQs+Tw9TmXCwaDg/h/hSOsAW6MMMFjxkwT4wRw+ROT+cnlgtdcxsU0pKHRmwtW2cSIIovezN6VxLWwh7u/6R9VLz9cEXmS4JbPwX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341669; c=relaxed/simple;
	bh=OImTvQatsPLMjRdtjaq6JPE5UTYtXsiDzq/lLJdtgwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUVLc10ii4IQVuoadZ1EZsdw+XTdKKgQca0aLQlPgEgYr5f/cWzgWNRSThfNLSAh5Hj6hA98sxhWqT9MIlCaWwrXyJlQn1F75UtHphPris3bSIlOn1yiIQ3/FMuPMrqaINBCKYJWcdKuW/gNjfhRb5dA7two7JwMNVq6eJzUGo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=QHnpEygV; arc=fail smtp.client-ip=40.107.93.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im6GAVjnBrNhyj9ZT9x0ZVeAa9KXyU/RPQqCnTvqEaYqiwgzM/V/yjoxpJS4hCpL62KjYd2zo30rLQIPP0bAbgqb+GgBz3KZZvac5eDAsP3D9qQXgy371CJ97VzMhJ7awEmMP0lg7bf1c1O5A37eRTat2ett1i+IKpJGuVjB+xRZ1pDimJtjUZlokHZw2WFelBUYnFtzhUiTessYUtf2f+dRFz2hLioy76mxfHhskKLQ2UoHiYuIdPK+DjKm5Do1h52GXfvyBmbFWsKnqbsmG0DjufaaKMCMES/r4HCI6HdCbrogUqKaP24cW9M32V7MiIiAsWregisGKUe7w+AeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeRMweAwVv68NYPh01dopHsPbUzhEI3qliwxY73QuHE=;
 b=ocPGJEMHnZB8cWaZv0HhwixwUlJDbR2OG3GJRGbx3CbQyTzXLnzg7lSuhIjZ9Uqa3OOuPDGaLyFeWvMHC+mWnxXl4YEVvPhTsRY+ORrPFLx7YSTsZH3M0p1Rm1HMNFhc/NTZBf75DCyNXVE3uJuw0WPJxz+mk/ZK2ty+E04LS/bGT4sTDfNDTX2KLP/70YYRrJ64nophaXCTIcZZwGB/wAegq7ngwjgrRYEo5t46O1CNW07e6uwywUO7Wm9LFaPSEB1DImYCle4M3oLaHBRcXwUhVbwGgeANRoEjvZ9l2+omadAUlwuDbKdq8B4xnsZtlN8Q6cIH9r2dSM35T7XwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeRMweAwVv68NYPh01dopHsPbUzhEI3qliwxY73QuHE=;
 b=QHnpEygVFJKBr86yM3uPNsA5ul66kTyO3B624fYCb/fMsONgULpm419v0Rs9qhtzAGY6MicFGttkTnXRTYa8PkXHqTMLoh5KHkL5m/wVqggh7EBIo1CX8q6CcNusD6RdpdNsBUCgQAzPHs8RLytAiTccc/68sTt9dj4EQW3bmIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH0PR22MB3911.namprd22.prod.outlook.com (2603:10b6:510:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 18:54:21 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:54:21 +0000
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
Subject: [PATCH 4/4] arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM62Ax
Date: Tue, 25 Jun 2024 11:54:02 -0700
Message-Id: <20240625185402.1896623-4-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625185402.1896623-1-ggiordano@phytec.com>
References: <20240625185402.1896623-1-ggiordano@phytec.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH0PR22MB3911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7f7938-0943-4b9b-0113-08dc95483959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpRrLXo0OcJjovCOW3ygBYU3nXJJCONPEazera2WIWBA0vDGQZEVC9EuSBIf?=
 =?us-ascii?Q?ImambJWjfsrQTibSJWvB+orWTojmD0poyCRmzM97UzJ7EihHBA1n4NMI/OGI?=
 =?us-ascii?Q?lhdpaMQ+9bpE0s6BUqFbs8xzMOeABY7fkjYDHnOvfOv48Fsf0px+gaqapnz5?=
 =?us-ascii?Q?Mo/TAIZu4LUu/8b4DivQ2Ely7ZT1KWG733bO2J/Utu8u6l3zDh1JOUw/yUQ6?=
 =?us-ascii?Q?Inx5gvNDc431f2jSjDrSKsB6oOYIVyv+zj642ZwXaNAbpa+074o+5m3LeJAm?=
 =?us-ascii?Q?abT6zLWen3XRcqOOZKwP/mazhey26iM4uQtYn2GCLEbODtbiulzhl1aueLTh?=
 =?us-ascii?Q?wcFc0W8SnlxSq/0c0jUr2t+pFWy/t2Zg4kCDlGVrT+1Tl3DPxDiYmCmidGdm?=
 =?us-ascii?Q?u0VE6x0LvweitUeltQAyyJHNSTIPJNkCP0msypkR1ajtt/yqBBS0PHLD8BeV?=
 =?us-ascii?Q?12qZauFjjoftXz1h5r5azu81WK8Nh7hTBtrpZo9kZ23skMOvuLOW22iJgGgz?=
 =?us-ascii?Q?1Zjs+5z+0/nxXITVzOmgC9PtJEQ69LRRCWr6gz4IMPxyRv/D6sRfwZiCNn3t?=
 =?us-ascii?Q?gmqhbY1/6cfgqjerLUveuILh1nHxUvMLP9F1+b7omvlRCWiZllbtbbPNBYAy?=
 =?us-ascii?Q?SVZdVH9feqSWdrKoSdcUQ3AwuPmF3kSUDRhlt9paaXibKl/NzKHkJkDKj6PV?=
 =?us-ascii?Q?e62RyXMXDIEkrvOaOgoYzkN/hdWT0uc+hUtdk1y1DW16ZFZJzttGDtvXzKg0?=
 =?us-ascii?Q?TN/U6cns+OfAANvCDyOf3qRW3i/IRoWvvsFf/tgYfXBmt/7HNJMut4t8g2TW?=
 =?us-ascii?Q?RnqcB4xSZZYza8P3niP0exTlWeVdSiqRyN/9Ro7/VXMnTwAtNkYiOmpYLcg+?=
 =?us-ascii?Q?4PiDpusHJ/wzoTzULXpPFqyenzh3qZCbSRq2lfkjNIrMYnxGMMAHm15DRzYL?=
 =?us-ascii?Q?Yoh70GU+dGu+eHlZg+i5AZk0D+OEusDFo6OyckND5Ga4B1ixVRJW8F1TnC/6?=
 =?us-ascii?Q?VKtnmqEnbW8aalFt9mp2dJzvIq7Yj7mGVWZtDrJ8qOdNoUKvoaWhZk1XZzmH?=
 =?us-ascii?Q?VBpRnABCXyorcM6/wF9miYuZ1m9yWJyjLGYFvcXiduK0lA92j+JeifCsLMUA?=
 =?us-ascii?Q?Ez7KEuELwVdgcY7kthGmEZ5UiRfoKWRwMw5gg+lvUxnXKAGMeeNnIWWFxs8X?=
 =?us-ascii?Q?KLwMVHhSBrL7vGaoK9dOYYpW3d3dwxSeek4CWYRYWWTpTAp2LMlKBW+7lDoa?=
 =?us-ascii?Q?fHzKa3g9W3PVh3EjYzA45a35kqGxuPF63rtU4cOOak2hM9g7fvsMkzmBrzau?=
 =?us-ascii?Q?ra39EnPnL8ytm2KjfpZVNXh5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oW42K/xGJ2ePZ4OEc+DV036cWqT7QXuDOBscu0pQgFyxbv89A2ieYmT80v5J?=
 =?us-ascii?Q?dOTd1Gpfpnd/8KXF98SyCJ63UIhwEYzD7S17adgOmmWqxnY06bEP6VO64bVs?=
 =?us-ascii?Q?SYG4Im/kD2iJNj8HDFK7zM1TnK6+lVWkwooWZeeNb3J3EsrQl6P+KYUx5qwZ?=
 =?us-ascii?Q?2buknA3h6IaZ6zz9Pdk2hWn+PBASjHsqNpYi8d/TDnXkvRAXoo8LlDgRyzuD?=
 =?us-ascii?Q?HrdTniJAryYhqUn679tBnCwqTWu6RHqMt9TGeGBMhdrG498E0OTGyf9Gm7+A?=
 =?us-ascii?Q?uzgeLHEzh8LcQ+p7zpDB95YnMVLIGJEjrcALloN7uVTYklQQ3+slMfIkab+s?=
 =?us-ascii?Q?M7YABk2MYPWDJzygtwLDbSwsWGhipSZEhfHmEy0LQI3HHs4mJ5GcndAGGQ5u?=
 =?us-ascii?Q?lC66NOTQaiIq4nX2RouUZHEPKgLA2M2grBFy9lyVDdEOjHM2gVwm6R3BUk4x?=
 =?us-ascii?Q?Xi+RshEGoApB4e/V7Tn+0MyKvdHm9+QjdGyCWj5i1K7F+yozLk/65t7nmbns?=
 =?us-ascii?Q?UGHUEKEdTQasBvMO8iR8VfitRQQk8rGX5AkcXsVb2NgxhZUtc6qrXn/jayLj?=
 =?us-ascii?Q?sS179DGVuwaTmHShNb1mccFhA3XolO1jduSKtXbAMeALhzW0G/VJIARmwAS7?=
 =?us-ascii?Q?/uh2nj46EIyFPiPG+JVL43k4AJUanY+Xkx4Sln1ocjBzPQU7mIaHy5y5pwqt?=
 =?us-ascii?Q?HBCGAwhWq3zp7cVS/40znDLtc9NmCjch4mVR8oxFivUs/y/9FhfN4tW2OtOH?=
 =?us-ascii?Q?6cYVKqLLbkyfTV/Yr2anPl3cgtq+95OrGftOJ78eKZpEPSh7SUkY/LikL8fK?=
 =?us-ascii?Q?oZBlyEcp2HbG9E5S9wfrldAD5yUQ8GADdswPjS5dZBvVW1cEnfW8KNuZamVn?=
 =?us-ascii?Q?Beysb5VbUoQi+gfDsA4hmqJrXoxi3iKsSkIi5sRjYU4UGrq0+sWMYKMG0BQ6?=
 =?us-ascii?Q?vuoI1aiU39Et7+wZUVr0XO5uKAFr4Vyycb1TCZhWx5pc6t2IWsEvEkMi9kum?=
 =?us-ascii?Q?iV/nw/Bpy4QtvtRmyE0I7dudYrAO8NWIP19cIJcA0Z+Bdde4QXw1UgoUI+W/?=
 =?us-ascii?Q?mkNQo4Q9E7m6d5bUTJgoaNv5dxTQK2lkrYKD+7bA0UlzAWO36o66xAdhHOQB?=
 =?us-ascii?Q?AHd96M8cKZ/qH6tDTgur/nLrCqHII9fOOe8WMg0LW70paNoNS1heug+ew+hC?=
 =?us-ascii?Q?HwsU3fWyZ3SNNcRdllB7SL7EfxuvtoY/q2mIZrrtQYG5k/hjaKdKFsAAgECt?=
 =?us-ascii?Q?hLZWU/HDp0pG9P6iI4xvGkpuy+1K8Mqa/gWxPGVBoqRxsIIKF4cn0a+TXWgF?=
 =?us-ascii?Q?nyPM2yUMLb+pWX6xMAxJ3pilbjvrqwt4OxiFST4iE2c1+pQJGoQcsuaWqEwT?=
 =?us-ascii?Q?h85Ejh8ZcC7EUb9f3k8Q7oq51u8Q8kzj/n1W/1T96Xg90VO6YEce5H2RSZKP?=
 =?us-ascii?Q?+5EwcbZgHVQqssxhrz7IoPBfubp6hNwjYfPMAD0SxpVB2sLt+T7I698ZWZ/3?=
 =?us-ascii?Q?LPmZHF73WKwirvd2FFykR0ByhQ5bjgT8DMPbLDMrea11Wc1I8gQLg4gCsnol?=
 =?us-ascii?Q?+AHqgORBD+PeejysKICwzaw5ruELtg77LWwp0McQ?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7f7938-0943-4b9b-0113-08dc95483959
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:54:21.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBaM99LpQyu5vnRVczM+dW04woFYWm54aiaTOxxzu4KAbwtxi4kNmJ0mR+eFgnbUfo8Ih5V7IBBPEkph5AaaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3911

The phyCORE-AM62Ax [1] is a SoM (System on Module) featuring TI's AM62Ax SoC.
It can be used in combination with different carrier boards.
This module can come with different sizes and models for
DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.

A development Kit, called phyBOARD-Lyra [2] is used as a carrier board
reference design with a mapper board being used to allow the phyCORE-AM62Ax
to fit the phyBOARD-Lyra.

Supported features:
  * Debug UART
  * SPI NOR Flash
  * eMMC
  * 2x Ethernet
  * Micro SD card
  * I2C EEPROM
  * I2C RTC
  * GPIO Expander
  * LEDs
  * USB
  * HDMI
  * USB-C
  * Audio

For more details, see:

[1] Product page SoM: https://www.phytec.com/product/phycore-am62a
[2] Product page CB: https://www.phytec.com/product/phyboard-am62a

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am62a-phycore-som.dtsi     | 330 ++++++++++++++++++
 .../dts/ti/k3-am62a7-phyboard-lyra-rdk.dts    |  18 +
 3 files changed, 350 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..cd6e14edbbea 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-phyboard-lyra-rdk.dtb
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
@@ -173,6 +174,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-phyboard-lyra-rdk += -@
+DTC_FLAGS_k3-am62a7-phyboard-lyra-rdk += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
new file mode 100644
index 000000000000..a5aceaa39670
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 - 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phycore-am62a
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model = "PHYTEC phyCORE-AM62Ax";
+	compatible = "phytec,am62a-phycore-som", "ti,am62a7";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		gpio0 = &main_gpio0;
+		gpio1 = &main_gpio1;
+		i2c0 = &main_i2c0;
+		mmc0 = &sdhci0;
+		rtc0 = &i2c_som_rtc;
+		spi0 = &ospi0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x24000000>;
+			alloc-ranges = <0x00 0xc0000000 0x00 0x24000000>;
+			linux,cma-default;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			no-map;
+		};
+	};
+
+	vcc_5v0_som: regulator-vcc-5v0-som {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V0_SOM";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+	leds_pins_default: leds-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x034, PIN_OUTPUT, 7) /* (K20) OSPI0_CSN2.GPIO0_13 */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (D17) I2C0_SCL */
+			AM62AX_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (E16) I2C0_SDA */
+		>;
+	};
+
+	main_mdio1_pins_default: main-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
+			AM62AX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
+		>;
+	};
+
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (Y6) MMC0_CMD */
+			AM62AX_IOPAD(0x218, PIN_INPUT_PULLDOWN, 0) /* (AB7) MMC0_CLK */
+			AM62AX_IOPAD(0x214, PIN_INPUT_PULLUP, 0) /* (AA6) MMC0_DAT0 */
+			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AB6) MMC0_DAT1 */
+			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (Y7) MMC0_DAT2 */
+			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (AA7) MMC0_DAT3 */
+			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (Y8) MMC0_DAT4 */
+			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (W7) MMC0_DAT5 */
+			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (W9) MMC0_DAT6 */
+			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AB8) MMC0_DAT7 */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x14c, PIN_INPUT, 0) /* (AB16) RGMII1_RD0 */
+			AM62AX_IOPAD(0x150, PIN_INPUT, 0) /* (V15) RGMII1_RD1 */
+			AM62AX_IOPAD(0x154, PIN_INPUT, 0) /* (W15) RGMII1_RD2 */
+			AM62AX_IOPAD(0x158, PIN_INPUT, 0) /* (V14) RGMII1_RD3 */
+			AM62AX_IOPAD(0x148, PIN_INPUT, 0) /* (AA16) RGMII1_RXC */
+			AM62AX_IOPAD(0x144, PIN_INPUT, 0) /* (AA15) RGMII1_RX_CTL */
+			AM62AX_IOPAD(0x134, PIN_OUTPUT, 0) /* (Y17) RGMII1_TD0 */
+			AM62AX_IOPAD(0x138, PIN_OUTPUT, 0) /* (V16) RGMII1_TD1 */
+			AM62AX_IOPAD(0x13c, PIN_OUTPUT, 0) /* (Y16) RGMII1_TD2 */
+			AM62AX_IOPAD(0x140, PIN_OUTPUT, 0) /* (AA17) RGMII1_TD3 */
+			AM62AX_IOPAD(0x130, PIN_OUTPUT, 0) /* (AB17) RGMII1_TXC */
+			AM62AX_IOPAD(0x12c, PIN_OUTPUT, 0) /* (W16) RGMII1_TX_CTL */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
+			AM62AX_IOPAD(0x02c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
+			AM62AX_IOPAD(0x038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
+			AM62AX_IOPAD(0x00c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
+			AM62AX_IOPAD(0x010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
+			AM62AX_IOPAD(0x014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
+			AM62AX_IOPAD(0x018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
+			AM62AX_IOPAD(0x01c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
+			AM62AX_IOPAD(0x020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
+			AM62AX_IOPAD(0x024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
+			AM62AX_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
+		>;
+	};
+};
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&fss {
+	status = "okay";
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vcc_5v0_som>;
+		buck2-supply = <&vcc_5v0_som>;
+		buck3-supply = <&vcc_5v0_som>;
+		ldo1-supply = <&vdd_3v3>;
+		ldo2-supply = <&vdd_1v8>;
+		ldo3-supply = <&vcc_5v0_som>;
+		ldo4-supply = <&vcc_5v0_som>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		ti,power-button;
+		system-power-controller;
+
+		regulators {
+			vdd_3v3: buck1 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_1v8: buck2 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_lpddr4: buck3 {
+				regulator-name = "VDD_LPDDR4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vddshv5_sdio: ldo1 {
+				regulator-name = "VDDSHV5_SDIO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vddr_core: ldo2 {
+				regulator-name = "VDDR_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdda_1v8: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_2v5: ldo4 {
+				regulator-name = "VDD_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+
+	i2c_som_rtc: rtc@52 {
+		compatible = "microcrystal,rv3028";
+		reg = <0x52>;
+	};
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&main_gpio_intr {
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
+
+	serial_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <0>;
+	};
+};
+
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	disable-wp;
+	non-removable;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
new file mode 100644
index 000000000000..3b93409b23e7
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 - 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phyboard-am62a
+ */
+
+#include "k3-am62a7.dtsi"
+#include "k3-am62a-phycore-som.dtsi"
+#include "k3-am62x-phyboard-lyra.dtsi"
+
+/ {
+	compatible = "phytec,am62a7-phyboard-lyra-rdk",
+		     "phytec,am62a-phycore-som", "ti,am62a7";
+	model = "PHYTEC phyBOARD-Lyra AM62A7";
+};
-- 
2.25.1


