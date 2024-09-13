Return-Path: <linux-kernel+bounces-328682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75C978751
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638FC281334
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC837130ADA;
	Fri, 13 Sep 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="WxowanHw"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2119.outbound.protection.outlook.com [40.107.236.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80A126BE6;
	Fri, 13 Sep 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250218; cv=fail; b=Kp8t0Xfe8h3jkACuvaVFJVa1Xystx8YXISp37T9RmuqTJ31vl3rfGNKTlxyDfGwKrHVgAoRDPKzer7FgD22O9Dc2u80sx3HwfKzS1rq0flnL9sVlItxAtAtRmjLjVZ0aSVmz4TSWaN5WreQbsB2RzCaD+H7CuYwXnN/jekSKwbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250218; c=relaxed/simple;
	bh=U8Pa9kuok6n/UKfsskfJFljjsTFrVe4XSxlempuU0SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xps/vlXHGGiMhbzEWNVc6qx1pcI7roTUAjqOfGh9IPv4AkNg/84d7Je9Mj3gtiuX+Jqy6db3Nn1lMtt6qzPkDoM5H44Rk4fYWMLGisz+1bLX8KyiMUlae6JICT+4/8pUd0rR6fKNLBDr6Xxysji6iW0M+YnEwE6ZKB9ffuNaEis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=WxowanHw; arc=fail smtp.client-ip=40.107.236.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndHIiarLjEordD6vGOeCqguD1sBFk78VZ4VpPxQEJ4LJflbUybxOhz7KAwrpTcJlDjQYykczoygWk/bTNQ7kjD3aTmA9mOONdMks6tcsVGZeM9n2Rj5YrDoJ3d3ca72qSE3HFaedAHPvzF+WFOIUEHdlOrmzEZo1aA4HQoT6t0Rf2Wq8LMSo5X/BAwUrxON7VkYlzyEE/ozwLKu9tXOpZSwOM1IYLic4NJrEkfctwDJrHnUqSkMD9omEMwVtEnNOxGNK8GiFvA3X2eACcavajmfc46yfqEdEiDLaOTRCsxUedrPOklagWiFH3s6JfPgDJ8Q+epFuPStO/zlqZlWj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0gIAgryXRwWSwCjR6EocccnpaGL8eCAzYmGJSIf2AY=;
 b=FsGaBFJCJp9uJkGwEtaWqOODYmWwY2LRkzqJAXMwt6ub4zIsVlMjoL0SttOY6VOrtDvAKIYBWWcmuqakNKNHJR9tuA/m4f7QEVblfzNWv0qH50VgfGqRYgyoLFF8UIb350zTeGpASJOO4pmA8eWGl5GzT+dFF8q5y8bLPKuiY5gBIpfG8qV+3Y12Ar3Ww/+7Icgr72qzkM+d+sxzplzCeb8qVYI0irCKtWUkIj0CwPWhe3olu/gQHaKAKnt0IlMWWTxOe/GmUHAv9OqmpZ2hfuJzrONhCtYHnW1+ahusfmCND3dK80q3YelHsp8ik7tF4ze6wIbPBT2gmjACUym2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0gIAgryXRwWSwCjR6EocccnpaGL8eCAzYmGJSIf2AY=;
 b=WxowanHw7d7E6SpfWnKHTipfUMdVUFE6i5NS+LocHhkMkuKvqvd7CLCShgOT6pJciWI06x7fdGPmc/x9TSOxcRah3q66IWNYVL5scP7Vqz2e/cOyVrlgZBS/pYmGlbpUxJDcXY0tFs1+4JAhbgBkW09+70LUdKMwJ+cjPHcUPMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SA6PR22MB5894.namprd22.prod.outlook.com (2603:10b6:806:411::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 17:56:52 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 17:56:52 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
Date: Fri, 13 Sep 2024 10:56:24 -0700
Message-Id: <20240913175625.3190757-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913175625.3190757-1-ggiordano@phytec.com>
References: <20240913175625.3190757-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SA6PR22MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 611b6fbb-eeec-4fb7-4fcc-08dcd41d7263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+AatTEcbTCkugMpLGvX3bVeUketQC/OC/yUlrzXnMHvHK7fIvBpgBNkq26s?=
 =?us-ascii?Q?xrX3hfkSZE7CNG4AmMff5rqzUfxeTn7VRj6PU4u1DS7GBr0T0Q8mIUAd9lgO?=
 =?us-ascii?Q?9ik5WyTZ7SdmbdGeX0NNEMlNTlV/VjFQwPoAE7FYfhc+ABC4QRIG+fj5B6hb?=
 =?us-ascii?Q?U34lMYsbReZthr3oQLcHy+zXHZe5RTk9TX4E32PAenLtEmXz3BpGtdMBQlBp?=
 =?us-ascii?Q?oXDObFOuvs8kS+X23fonhoTHP68CFHAKkMqcOY1zo3W2SAAVzqEF0XxlN6lt?=
 =?us-ascii?Q?f6IGBaFGhCtsxi/ZqwxTu2NbWHEaogcwkD1BZ9xs4u1nTIwYUxXga2Ux1otQ?=
 =?us-ascii?Q?By7XyCrMi+7ZSlCFVWaeIAnxxvAIufaJr7CXLY9L9M4725KAaQp9D2y4yYep?=
 =?us-ascii?Q?3cf4gALbZA2kF8BSpzEdYtH3Qz09cA2RUKMoJMfnDPGsw8kjy1aJR+qsM3eD?=
 =?us-ascii?Q?6gmYu6iqnuuOVtRGHQ/xOCNqquInfDOzvXmTxAy9MwZey8Vz5ccxKqlgA83w?=
 =?us-ascii?Q?gfy2xrdiecHb2k9Gs5w9NqG4ttZVeSRaFzjLxoSjBezKH9YB+IOoEVeAzEZ3?=
 =?us-ascii?Q?5zNHbomdO24YvkeM2EoVjz56flLu1JaV1H5Gp9yaUSzvG+/Ug4YdLRBwktp6?=
 =?us-ascii?Q?Cna8n141DRCvn7i0njCbY61yhc8PX4lUX11W8zT0wKE1nO0yjztB7YOupSqY?=
 =?us-ascii?Q?oWVJhOgyLyE1ipFlFG9wWqAPOSwFFwNEIAFiwAQGYxA+mM2UG70P4XApGDnS?=
 =?us-ascii?Q?PqqFdCZ0DIiZ+MhQeiud4nJVxh8bcgWbnaWNKs/Mwgwta59D23erOV1joUnj?=
 =?us-ascii?Q?RMCdXMPzQ+l3KiV8yhomJdEU5cRPu9nmbd9XGcJTfB3QEpcu4tMjvI5+/4ht?=
 =?us-ascii?Q?JN74rmQuU67HJ2qYb0wUAD0mgm5o6YaGIe2mfDlqbg5kbQL+qyHZ+7WKFfl7?=
 =?us-ascii?Q?jQUDn9j0UUkqgwvOe6vJH6/kruyI3DVPsnNj2EegdGjdVP6yQ9w9QumZEP4X?=
 =?us-ascii?Q?CZDmEr8AZB9BVcwSBfbxSD7HHKBpbTnP9d2kzbHaBv0gPmoZfdkM7YFSYMQC?=
 =?us-ascii?Q?EBp3Fqkhgic3a+QCzFLQBR54aB3Z8LJKFkOLB/+YyRagjLNRug4W1bImHY6t?=
 =?us-ascii?Q?SHr92XG2rK9/ciOuX/t7KfKhQzWf6aLqCGjg/n7vKjN0Xz135kyQiwiyVnzl?=
 =?us-ascii?Q?iaIgJEkNNDqVeUa9VBoRRM2tW3a557mxrM5YFf2LH2L1ffkzplVNmfpHsiU8?=
 =?us-ascii?Q?G1WimI417WF29N4CibBZSi62jwj0DRXw22Ie2XlQoI3FWE5d2VgnekAOlyde?=
 =?us-ascii?Q?G7bH2jBzzxb9UDbZCeibaDC1fT4l1nk/0OGFy+VyNbOBW+mL8GalqfT3/S79?=
 =?us-ascii?Q?eJ1ZsWyFq3m6es+4tZIrj+9kaq4K6Y1AMmNtsBvb7ZQLR9xElQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lt4mStZaAJBnNALlfU4QgnWb2qHiODPCd03KZQ7OwTUZPvRo/a4ZAq7Q8wE6?=
 =?us-ascii?Q?SPK+NGdj9Gzy7V7XpI35G3ikcRHWK5PFjo4cFwQlE3LfZgggTOmgYS0k45Ju?=
 =?us-ascii?Q?rQrZLy5NULmLCQqcvywd4/UEjt/XcjhFN3XTyPwkUI+Vv8IojaaCE/J0Isnc?=
 =?us-ascii?Q?33TLsPd3B7QBjrphG5fAoAY7GUdUnYBF4udFkwsCxlJ49C176XGVB1IH2edG?=
 =?us-ascii?Q?yNV979wZKYLfFPIpLG6ac3+So5Pv569X2avyVPsZGlP96MJzPvSG5YbfHX78?=
 =?us-ascii?Q?VdERbrVJjEBiTKK+yTSHJ9hijUUWVlUHPI8zmgMSJdUNmVtxVPf/OR1qRssF?=
 =?us-ascii?Q?Hwr7hGpxHaHMMh2bVvMZUhy6L3ljjLZ/IzOscTTfvo1huOzwHOfzVa8v92jj?=
 =?us-ascii?Q?UXp1z3EP+tr7ipdjA+/TM5hrmYaBNEEjfaLmFxGukv2V1XE7+JwQ6VITn/xo?=
 =?us-ascii?Q?X/sQeKKWnoagQM3ltUN/P7SGQOMwPzme/5i4QywjWgehGr5yqS8W5/8OyckQ?=
 =?us-ascii?Q?Yw45rPceNNKo1smMi2igG/bFRXBf6ZNE0O6F3ukpFB5pyEQ3hImPQJsduGOV?=
 =?us-ascii?Q?3QBKKbNIZ/OHbkLpGrNHQR/dq39F/KH/3vX5F1JU0GKdySkG3uENtef1XK/q?=
 =?us-ascii?Q?ST9yN1H+Powe64g8EQvoXTjALJSH/+Xcqdv/cBm6X4cw/mErBZognZ2IvOQ2?=
 =?us-ascii?Q?CPkOel4ElqPMabQJMfBoLYi7Xodxj2LMRXKz56h8Ac0peA+5uxBjhnYUIJM7?=
 =?us-ascii?Q?o1cLFxhJPBeMT/+7ZLE4JFj0AWsrGSXFoQT4Rou13c3+4Ncc/CSmnn/tYi1h?=
 =?us-ascii?Q?cs+Qf08amTRGHsjj9RV3njtcvk8TCeFX81Iy5VGGsEoipiF+pPTnjNz6Ad7/?=
 =?us-ascii?Q?sSGDm4SNCQU2Leq4P4W84UF4m68MyibWVs1GCZ7Q0mxapH5Ck13fNXP9Gf/4?=
 =?us-ascii?Q?3hPUCXf1UiwL67bXitq+jna2kzTxirUiBClOHBrXIkb329g/QNnSyqCVOYlc?=
 =?us-ascii?Q?ed5GR6BSHlGHJD/Ca7tqJmRjU6E2KVYnFy0BsOlE1sKI7J8ExyiS7CnyTEpu?=
 =?us-ascii?Q?M5KQNtC3QY9KiSdcI7AceNuXB3uYkmD6S5c2cc/O8x5JdxCWhCHCn8mLB0Pa?=
 =?us-ascii?Q?WUG0S4ibluUGc2CbKIuplCiWbVUN8LZgxsleEuCpy2rqE4Yq9K0uItQ3z704?=
 =?us-ascii?Q?/tY/NjBUbxgt739Xyf+LFqt7Yhu+uWfBe6iVOWSwcnKUSIZbO0HjOXim8Tyk?=
 =?us-ascii?Q?cnBvMHa0Ojho4oiZrMZx51aDNQ0eA8geYokbKwSNw+sQ3xKdehFV6ibmjY8v?=
 =?us-ascii?Q?nzlCN/ul/Ym2qFqdKRlxzC7iYJmqltT5t+BUxJkBIdNAstXe+J+uM8qItoNq?=
 =?us-ascii?Q?vgPF7F61r8o5JG18eCFHG3JtomWJGiNcvWgbYpv6Rl293056WKFXmBSC6aEn?=
 =?us-ascii?Q?VxB5PmBbSdsxmuYtOPNUs9qB9rAfUdsfZI3TNfxC4xic2uurMTOIzoWFGq2u?=
 =?us-ascii?Q?iZ/+mfgNsGZa6jb5FcP4z6Q+OAcaprMCVxn+gyjrtSpQwFPEihWusLZjVQqU?=
 =?us-ascii?Q?THOHePMdKDMX7YZQaQuVtigZK5QohIWYb5aMOjRi?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b6fbb-eeec-4fb7-4fcc-08dcd41d7263
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:56:52.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfhgHXtgKcWtG1nM2okSrTBXu3wflhYMGgTuu/wYF9xFY1ra7TYb2ifmuGkKgk9S971DxQfQWDVQdeMHBPJ7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5894

The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
from 0.75V to 0.85V. Here we add a 1.4 GHz node to the a53_opp_table and
increase the VDD_CORE voltage accordingly.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index ac8959f3d953..8acbd4facf37 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -205,6 +205,13 @@ AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
 	};
 };
 
+&a53_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-supported-hw = <0x01 0x0004>;
+	};
+};
+
 &mcu_m4fss {
 	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
 	memory-region = <&mcu_m4fss_dma_memory_region>,
@@ -265,8 +272,8 @@ pmic@30 {
 		regulators {
 			vdd_core: buck1 {
 				regulator-name = "VDD_CORE";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.25.1


