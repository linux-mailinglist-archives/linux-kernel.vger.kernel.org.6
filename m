Return-Path: <linux-kernel+bounces-231459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A9919900
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B837284276
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71195193099;
	Wed, 26 Jun 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mc8l5aJg"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8519306F;
	Wed, 26 Jun 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433562; cv=fail; b=Vq0FbKfdnznjVheMLP/ILUK920MaDBGOOV7NxtN8jgv3enrtFlxjzYQ4ZHiSDpBtJshaQQWBS++baezY4jg4ZsOUrIuc1xTF36eMpXJV86SMe0d4iIpOZ4H5NxIqPICcCsEuKQWSWAOBk7cmHip//xiSpArShXWIOQm5DL3+dhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433562; c=relaxed/simple;
	bh=IPVLqUbaDbueUSY8xjumhbD7YzXdw+x51fH39lWclao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3t+c3ocgSeQGVsxBa9nQp1SFbFpae2KYmBw6eVpF5l45+PaWdhfICrBbOp6ufkV9IeOCQBFX2/suCda/+PC3D0enlhyXeTkNem40QkGpsU4RN4/7zrIu4QXs1mcn9E5dGwmBqjG98H1D3e5XYsegHKA9VlwsllmQhggSxfvV0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mc8l5aJg; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7SvlG8BIqq/+1249nlg4FBv1HQSQSBTQl9RHuESiWGz6ri03rTvjF6NQ4mjPZ/o8g+sg/u9b5kckY/pwwnvuRXPUJqsjUx72vzF3EPSkcxidz13Q2IEeAhvXcKDGWlF7WU+GS8RwYMOtgGj+nnQSSzP44mTiX4E70SEP1yoZ7eYn8Ry7sf5wAEzivVImbkMv/tcl/u/HEAJNbPrLqSU67826PhzgZzrNcWBzn3duRHB/9kIg9DV2RxFmYsv4si1bqgwS1AX/KqItvwMyKBB9Ttj3A4qppS7LJeABUVvTm7h9BRa1l/WAX7kz8o8eH7jw2KGOod+OQZXjmEktHEStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWSI2tbi3GFFZ6bmMEK/wwBxxIW+iKYl0jFC0xwMyEs=;
 b=FbBB+iG3dISxFl6TkEgzicawRTYQDj1a46UMVgIOEu8rEJighWo6VhHwmy9+zT6qUJZyhmEuSPzYePb72KaIkMQhsoX0TzgeTSNUG8hRI3xxv9DUgYHmPo95l8Ntu3MTuzmPNWHwMbBVfbhUbOjPIBAU4o9vJFYFKEBGGFc49erAk3BiVzZzxxLIgpnoiMTj3Qy28tgMfEhD8SPSCGZZoP/0jXgNTwOsALKRDYJsfDLfQzO9CB0jm1rHFgtGVTY0d3/JOeHWk9gxdtrUVfNB6doCKizxXE0xqZojLsnvZAteVcGjvxbIqlCp6Jl80aDri7C2YNdlpIzsfAVoJOtWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWSI2tbi3GFFZ6bmMEK/wwBxxIW+iKYl0jFC0xwMyEs=;
 b=mc8l5aJg9lBDDvR4F6u5Nu4hsmQUpBK5gsuCeOmB2fBUvEmsBgzZZhUFqdfb8ENWkc2tc3k7guAuCt+U6++kUJB8DDMdEzQ2SHVfMJABW6AnZGWBU882dfN5m31Bc8Evf8vUvQLotyok4+dSw5WUj2WZBIyavO/kr7vQhVu14N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:25:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:25:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 03/13] arm64: dts: fsl-lx2160a: fix #address-cells for pinctrl-single
Date: Wed, 26 Jun 2024 16:25:23 -0400
Message-Id: <20240626202533.2182846-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd73bd-6244-4abb-0f48-08dc961e3027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|1800799022|52116012|366014|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUYJKZJ37rkFVzbwvq5Ng23ALQ+b10jroa3Pguohjl3lu8TW0nORhg7uKQ/K?=
 =?us-ascii?Q?EjhoeDBzKGxw2WY6nBw94ZCaE9IO9EC1Wh42i8sFPpY5o3q0l3uURrgFMb8n?=
 =?us-ascii?Q?1dO4YGMU2Sh1Ywy0p1Oqz/ZK+Vh9pUfA1Ao88SUkQj2yWfjdP/9EBKFOzPIB?=
 =?us-ascii?Q?RSI0vV+2dBNrM7lXxTvYokxOSEkpwy8zlos+QN6VbwjF/5GmjToPzuC/XQM4?=
 =?us-ascii?Q?sW0kPDirSVQ++kPJCibmrDPmzIPRW672yfGTf/BBvGoATClUtlhaajpLhFpp?=
 =?us-ascii?Q?TiOjI1MQ318WKJ5uht/txLSJZ3uVk9K+bYFp0WnwuYUt20pFe2j7ixKh/v/l?=
 =?us-ascii?Q?gWP46bUa31U/lMho8kVMTCjI/O9Oek0pvJXHO8pPb+c4VsWN9SvP1S53tC5G?=
 =?us-ascii?Q?auVI4NDG6u7YeYomVL8jKQAXFdNLAqzHy3PlSQr8zJFrwTsOnPO9CCaD4xLx?=
 =?us-ascii?Q?MIpHDDxbvyYQ2YfUqboaIJeXJBgj7iwGrRMPvICQoP/CkLWv1c1H2Q9jdWSC?=
 =?us-ascii?Q?raOup2vPcxbkC3GU78klpDgWvQZ58coHdN5Hd7F4hp/+R7p0F1fguC5QOdVs?=
 =?us-ascii?Q?TFRKm+cZZKZ0rBi1bOEVaXgv2xPtXOOhOGywa0TLFqmawWBiXK4cy4siVnjt?=
 =?us-ascii?Q?QuC5MKhYRRtnrgml6o2oLiLEsmH4ESvUDehvz6X8Aq9CETDLSSS2q7FrXEBu?=
 =?us-ascii?Q?JF87wOa9tZh8w59w5wgDS0ytUR21pZlf823TzBq7urz1ScBPwiujPv27zYu2?=
 =?us-ascii?Q?ZrtnSYRtU5LDyxKpsKwYqVFqwkowgrFsb8RLhARSJTudDlM/a5h8qk/tYYPT?=
 =?us-ascii?Q?zO0vvOyj9GcLOwwK2o9YGZ0hO8ymNUBvw3qiKMsfHLJU1TwQci9jabyp5Pjg?=
 =?us-ascii?Q?O3s97tK7QRWAF7F8P3/d9IbLKezavUhOsPdZx3creXoFuNXRTZhqg5Dgns0R?=
 =?us-ascii?Q?IXBqjgYrkBDFBAuWbAvwlrtP7c9FvCf+cc8BmtUy456Cpkyiz6/2D9OIIjcF?=
 =?us-ascii?Q?wkxt9nDlzDatkpG3S1JKvombIrvmfOvupYQMby72QTu3t/hbc2UENHNHjmia?=
 =?us-ascii?Q?Kdo5J+dTqsB0koDE6dp0xqGIQCwEfa3jMfjLimB/LyRIuYChTXIXrvEMTOFx?=
 =?us-ascii?Q?ZEAwKzXurq4AqLFGZDBP5HQC2dohrEbrOtPEQD614VNNRWW0f+YI34B3SuZC?=
 =?us-ascii?Q?Vmi/SoBX8pJrytkH8nhMPe7pCLxD9lYNvIt3ySUAZPpoSShz7+p/5YktCMiZ?=
 =?us-ascii?Q?x5ZXe+AS3GhfKEgYdW4j9O9IQJ2rH57KDE7uEH5uRym8Bi5Z4yrhAEoDWf+q?=
 =?us-ascii?Q?8OowHZOgBOeAwlqhZtC9h0Mp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(52116012)(366014)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvpliwBwLysY8oXIx2v6yXsMB0ZuwY0SRyH2nT5/8DSs2GQ1yB3kMoKUYu4r?=
 =?us-ascii?Q?8+pjUAXLXN6C1ybTRF2eZ7MQeohXplMcVr9ljPEWECwCW0z6F74xKWdMNdCF?=
 =?us-ascii?Q?PMdv1VaLZN9aBpwcV+YzPCZoNotLZSb6UmK8DYsI/MgxNtyggURwZ8ILLl+A?=
 =?us-ascii?Q?fnDV0LtwqVhaAfMZ8RWVifDzzEjqSWONoJ/Z4MOp7ELju/IFX0gVIcVVUlde?=
 =?us-ascii?Q?2PBgJvC2dRI55iRHSZtW8ydGuBWOIvqwfttRvJzLfJPkbvfSlW6CzMAy6TVM?=
 =?us-ascii?Q?0Eh4u3zd72qBBZYkoSt3WtpDo8Nh+thm34lXTA0y712XXiB6pc63u46j7yDg?=
 =?us-ascii?Q?LPoFmF0Ogcukalj0bVDkcDJxUCoZMTKhFYKP2Hfs8Y/ZrKMtMthXzdoqGOls?=
 =?us-ascii?Q?B24FPuYUVdY9CmENaYm2MZq/xHSxHpKqUNtokWNCkVo7xKHevn6VkqAYFdut?=
 =?us-ascii?Q?Ckrs3KN1hFDNXtKHHb6cITb5IZf19980cGbNQwVUlGznq54s6cKKw+jHpvmf?=
 =?us-ascii?Q?DazdJ3aKkDoTRM4FjADpADn1LrBQOlQTWXWZ4h73iO5ku+AG8Sf2fcBsopEh?=
 =?us-ascii?Q?LdBxGGxHHTFBHJYuXhWClMVBkJl9kIBCr6B0CFGIQoQJUcJ+eRt7EkPMD1as?=
 =?us-ascii?Q?0zyGO2EF/93xbRY44ZRCQRswRliFi7+SpJMjfOPY3x29hsO0k6tN4OS5ZR0H?=
 =?us-ascii?Q?kZNTe4hFMcmj1iz86zU/1g8xtXD/CbywGk2nOrKPGnpjGucQjSaUw4VrhtC0?=
 =?us-ascii?Q?KRsl/Jn+kgGzQha4B8NSUcLW3JmkL9s3P96V4KVGHz0FUZhRd4x89FiToIzY?=
 =?us-ascii?Q?Qj00Dk4Q0ITd1Mi7zt8wr78pPXE2glFVPFNCy9slA0O/2WRushOWARDODpnI?=
 =?us-ascii?Q?5SQYygFGMOgqRmml9Uy2drMkDOpXH2YuCoJrsmY7F52cds4GBtwCK0QI/uvP?=
 =?us-ascii?Q?zLrPxgcuIEbqtD86cVOUVFPKowk23pWnK9YT2K9Q0YWGepISUOuRWf7hG4gg?=
 =?us-ascii?Q?mbPWmQUlplAajlgFK9D+p4SJ7bAofLKfcnWlpNBciXSJ+zBEp4f99LlvxloL?=
 =?us-ascii?Q?HZr+ipopkADi3F71wMFd4cshSPha4/M217fLJ9IEcAeA4fiQTV+GpaTgILH6?=
 =?us-ascii?Q?WSZNFWI8ZRnHdNwBEVGSbujUv49gwiCXxwyZOhDgHNusqEorHN7Ktk1S4nbO?=
 =?us-ascii?Q?53bW4abMoaIO1Zz+9+D3HREVDNKM5jj6aL5gDVxj3XTjFTxoW0T9YObm7kZU?=
 =?us-ascii?Q?NTrSoRs+Drx39l1eRS6opSwE3ZJrqE/0jUKBWnsuIsjDyNhL7Z4XY+kcZZwu?=
 =?us-ascii?Q?3ryhmeligQOy9EVqST4HMK/euAGgOm89abSAd0pA+kRkRpz7ls3Yt0OGb04P?=
 =?us-ascii?Q?H0x6RyGipC9jQWXKtQYCY0I84ZZfeNwzgKxCJa6yvKENcE5am7Mh+GNZf8YQ?=
 =?us-ascii?Q?Mi+bYMWJYbIMxrdyNDL71DNk63UQKL2ePsQIJfn6H1n1SfYkSPEnaT+Lcg0T?=
 =?us-ascii?Q?KBJpwIF4VRk2hCJQtdRWdubV/jqREAveccsTLwblKnE7x665L310jVZJN7Ak?=
 =?us-ascii?Q?pYfYdOzTJngQfuT58aFTZFIGfs0Kp06prjmecM73?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd73bd-6244-4abb-0f48-08dc961e3027
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:25:58.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OxlzNk9QpyaV3g34+KxU0H/dRs7YLHLZ743nw5HnX82TGrZUZDK513BaQtEVzhLDt4R5UKSo2bBqu5uxEinmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012

Change #addres-cells to 1 and #size-cells to 0 to align binding doc
requiremement.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index da49f274e9d5a..12b6ec4926456 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1703,8 +1703,8 @@ pcs18: ethernet-phy@0 {
 		pinmux_i2crv: pinmux@70010012c {
 			compatible = "pinctrl-single";
 			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <2>;
-			#size-cells = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;
-- 
2.34.1


