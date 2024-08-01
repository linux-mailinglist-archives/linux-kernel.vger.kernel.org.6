Return-Path: <linux-kernel+bounces-270967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF39447F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157681F223FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521AB1A0703;
	Thu,  1 Aug 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T5EinH7z"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020099.outbound.protection.outlook.com [52.101.56.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D1183CBB;
	Thu,  1 Aug 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503604; cv=fail; b=mDOurF9EmaRHEO5LlhyIrZb96f+Xl9DmTaFCbqrBQ08/uaf/o7ZyMa071hfesN/8BDWnIN0vxfFVLSQloqkhTmsQCZoPl4tDM1NzU3Y85xqL0WjE9TpIV/EgBQPmaTUeIz3HYCwAHY4q+QccBQOUZUvfrt28+goR3uKYuOnBEvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503604; c=relaxed/simple;
	bh=XdW7fDPrXtAc1DoFFThrgStCABol7gSb4/B9W6sbAtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+ZwAW/6EBniiJ1K/zckkKfPj92OzOSFOu21FEx3VYcOKEVGV5kGwIOEnFyGtopN+6psCxFkHJ6QpsXhEiJ9GlIhcBN7n87IOBn3d8m1OZNX11X5BXXKmkmUJcwgZonO/DpPV0fTjA59ByVaDgTKtQ+SbHs1YNmoZ4HTaKYK8C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T5EinH7z; arc=fail smtp.client-ip=52.101.56.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBpp7SSm0OYbdBxWUA3wI1wOPg1uucOO2UxmjtbGerXWypb/AvuNZnxmJ4PeCwvtWr2e5Jp+bv7BX3t4SKBvbJUD0uKuSYJouGyxWRDwXOzzhVdTzFpIp9lBrLlNeXWeC2nCu3+XfvQPf1lHU11t0I4dYTt64Vswl+qY4NkVw/JPMzXU24RXY7h6FN59bjZhP6yIbAPFsORbP2gxjjmVVA30hYbCO8k3IBxT+z9mmgOs3LRAiAvqYqwbYYIVqd5ix11ma89AucdtUmyhr7qVkE3O10KDZxFp/O+aQWuMiAzfKF7LHAnvWAS2Mmn/y7AvZpV5z5hq5nrfKoltkb6VXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7+3m9yXzv8Xg1HthSbsK5nBsSkPpK3mqLA5BEckVZU=;
 b=WJJXFnbY/5lGY84m6/ly6yRzk/Gtvu3ZrpauscfoAZO1oiRUdr8ZhpSWwXeNggLqaBfJsCeMrF6UZVoJkzugixSGXrWR2DGJpGisgEERFM6JPMblW4IaIG/LCs1pPwEoWw5uij3JFNtxH0oYl7Xq9Y46rCqmf5jyeis8q3HUP3kqlAKQxdriFOnKoVNZIEfWlPxeNKOw9IDyoalyM6+68f+bmh1WI9MMSr0+Z0wWZIJIwqq7yno07TADJ0YXhODajUSQONS+jZwSyPmTXTHYeqxIGOg/NknZdLoYpsyk6/f35HewQstnVzGrFoKdl8tNJBoetvduyr20P/DL9xu/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7+3m9yXzv8Xg1HthSbsK5nBsSkPpK3mqLA5BEckVZU=;
 b=T5EinH7zo48Dy1mpNR24QaJ8Ow+C5gsAWueWYE7vujRTs9U31wbtgK79uMTS73G6tVR8SDbQtc6vlsm8Q9hfq79mZ2QTZMgWKssC1UXLKH+mnYgmerxRdKwJhYMZrZSKzyjQ4o9hT4p0VAyaVkbMFUkKp1oSA2SltqzlQXj+N8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 SA1PR01MB6640.prod.exchangelabs.com (2603:10b6:806:1a4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Thu, 1 Aug 2024 09:13:19 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 09:13:18 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 3/6] ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
Date: Thu,  1 Aug 2024 09:12:13 +0000
Message-ID: <20240801091217.1408809-4-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
References: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::21) To BL3PR01MB7057.prod.exchangelabs.com
 (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|SA1PR01MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b20f38-2846-41b0-d9ba-08dcb20a2e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O2AlXDEilwHfmM60JVW1+s2NDx+klLSt1ECTa50TmU35Uds9i9us1VCvetYl?=
 =?us-ascii?Q?AdB/2AMONxE3AYy8quoX6ks5vYrJJgSk4iT/+pnwJociHtlMBvebOjw3orXh?=
 =?us-ascii?Q?7Mk0LPKT2Ye8XZsM2ljJF6+f11xIj3MibAe5Prpk9ZMfhW78fVSFvkeRKEY5?=
 =?us-ascii?Q?+Cu4drlqYhPs0sGxkIJ9WhfLmm7MxM6XlEP2PzYZ5UOGqfmiejX1dim0N2C5?=
 =?us-ascii?Q?IHypvIk9rHGsGwKGjUr51OoVr8LpL3Z1Jb4BrfNRsIcVHMaCODFCPcpnO6GE?=
 =?us-ascii?Q?jhIU8/wJ64weqsUG4ro+INapxvoqRrA0R2/WtkoUIQ+X7GGq5rb3HaXn4aUz?=
 =?us-ascii?Q?iMOaD6L1+KAS8GOMW2iXF4ZihqnrRfPwZQ7moP+jV2xRrI2HY7OYGf6a5uWq?=
 =?us-ascii?Q?GiCkVvkHP/8e4bFFml+tPdSD9GfETmhaq7Q4kWD0IYSfTcN/OfHDPXOAgvGh?=
 =?us-ascii?Q?Z/tw2reAePLRiNkz7kM95lZdJgIIoYA3ORMzuao1evLsL2yL7OhkT7Ea6qkx?=
 =?us-ascii?Q?bK90vACGJ/ISCqamDQpQUN4PS2fZdjrE9ZqxZLj+ae890zlg7k4q/XxQB8KJ?=
 =?us-ascii?Q?Y7cm8xgc6a7Gtx1emkgKwpqS5jBgusulR3VvVHqCx7ClIEXKb5y1lDqr7eFL?=
 =?us-ascii?Q?L6XGW7aChHc5xhBHprpf5Eo7+To1B5aaE0LTEMklW/zbfYpoa3z13ptdruzS?=
 =?us-ascii?Q?+fxMqda6KmejAZTqDt4mfCIBpcXFf4tB1OFCcPZB/AwLLUYEvp29dXLBL4zX?=
 =?us-ascii?Q?3Sshu2UxToDxnBAAQyBh+nW8UvpN2ZOT1Os0rtIv16IdWZSt768y9XZ1a66X?=
 =?us-ascii?Q?k8xnT9bZ958Kwv6/UsDPypy7lY5K6ZMS19LKaEybj6KJAUUszzJy1enWMlWM?=
 =?us-ascii?Q?RRvhuvIrIR2GO1ngVnz0+l+57u4SdzLIxffIBaYYkj9TYpHpaLHuSdebMNAS?=
 =?us-ascii?Q?Yrx35elqDbUMN+NLQqku4+cEdqzJsTrRuwIIQDo6vxzNtYmvbXL5Z4vGA7Oz?=
 =?us-ascii?Q?7LX1YhkerD9NporJaMq9cXVSAzG18KnhJMxhNX67ZxXj+SHBYmWJNTzYfI/o?=
 =?us-ascii?Q?Hvwo9CNj3BMuTzI5T5GtH/P1eIq5tZzloe83fh0oBuAu0XcUFxu55MfkXzIc?=
 =?us-ascii?Q?2LzmjbR9+UpWfgSmLIB8hJWG81Y3ERcIYSjI8UKaNGyy0aJS5O1hxusUoJ9x?=
 =?us-ascii?Q?4Hm4/OX+lPrRiwI/WDe3GtQxkyT/eGIpS1oykVhoQOSJl1XsRHOFovDNG7vt?=
 =?us-ascii?Q?ppwUpHndtxDg7FEz4vkcuBSKPlwNjqmLK3ebdAPWthzJU5EFoETJyjrvn98z?=
 =?us-ascii?Q?kjBWTsRZ4sP5Sp37dy2GaYgpUybs9sLTwuKSe6cKpPnQKTKeNd9o9nj8kYuM?=
 =?us-ascii?Q?EBmv/jDubuKFV5ij/KWCN329mOlFiO2FPaI7XUUvgfNpbMKFkQ90B7t23H4x?=
 =?us-ascii?Q?WKdeovy28rs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXehol91NFiOGCmSh/G7skUYw6lAi3XwB+rYYeaLvwNEWZgYqMd9yZj5dwI1?=
 =?us-ascii?Q?KLEHHWJdhbBWqNgyquKbdG4gK/h4nZCb+tC90MF6Pt+ntU5ydurqb+nKQ0yL?=
 =?us-ascii?Q?FHsu90Nb4fusOjc/Mg4kHBle/0mh3364vyEBPGHqwWDMkmB/4HDhOWalhaP0?=
 =?us-ascii?Q?k7BorPBNbW12OY/ZkLBKMqbbTLi3gsnKrioWXKWzjNXrZANpprTdAoIPU0dr?=
 =?us-ascii?Q?yfbsungl1JsZbGFVTInWIjGGOkDD0mUMe52UnbB8oPWp1LSH6XjMTuSiQGGl?=
 =?us-ascii?Q?qbqRZEupW9QwkhMOzsz+uoRxbncKcIFuPoewexjj+ocygKvS/6Rqu34oVOCQ?=
 =?us-ascii?Q?JeFbGxgEGnCNdCga/SIrv9KO8VWRfv4gdNnee772Rj47acFeUJdLiBNpQ9HC?=
 =?us-ascii?Q?TF1jkjop/f968hRxYQH+WpFF9ChN5OrcVgOyXW6RMcfYMhoNzihCgg/37ytC?=
 =?us-ascii?Q?WlcU4XDlz1xF/P6f5bf0P/mDOocIpO8K+CThQ3HBZssXqJQhePY0C/IClajn?=
 =?us-ascii?Q?epIwzwbSoWjsOPFa2dzeVYDcWs8+D0MSLvy60VkX3ulYPLW79g8IrHdy8RZK?=
 =?us-ascii?Q?5YtMJcZyvBD4v1cRBXGaycRdKx3Id1zO/SLQ4b0D212koDN0iNEYG3R/wJy0?=
 =?us-ascii?Q?LZxgVK2WXf/2zj9POXOK53zMsNQpUvj29Uk/eBYdQa3rZdrmn4/2L7KFGKt3?=
 =?us-ascii?Q?d3FBYOk1mznqLjpGAHPvR3FEjx1ci5C4neYHuF6a6oPss6cQr/hYb/Iu46fW?=
 =?us-ascii?Q?G5wT4UQ/mGO/j2pROiuI+bDZzP/Eh8ildtxwCxYjV6SXJP/Dam0jx2B/unca?=
 =?us-ascii?Q?LDU5Uqy8lZxvFBbOIL74NbUFxTDH0+8hDQi0nyEcHCHPDdROKiVPLMbYRbzK?=
 =?us-ascii?Q?x5wFCMvsBO46ousO0NWXnTnyxcB39ASnKtH4RniTin+cD9j/6XEC9kCnOK8S?=
 =?us-ascii?Q?RmpFMu/co/B5HU4/bhqD5fDqXSugCtePtbcimkjHp+m35STBiBexE2Zt4C+l?=
 =?us-ascii?Q?CsRk7BDV4kNHGw3+xf3ogLD/RFZ8YzMuj6XOiUmHAYouMfckLNq9mr70sGWy?=
 =?us-ascii?Q?J8UDEj2iDbaSVuoNMFCahhCuFinMa5PbJz4qpA270/oTo7KSJgcT3h+u0Z+m?=
 =?us-ascii?Q?mMtVimFu9tTGs73ZYPHNsJeGbm2erAAVDZhwILFpEGRrgJwset+bdWYSA0kV?=
 =?us-ascii?Q?6sdD6WuruWXs9fSIVigB8ryFf/Q6xdKyZFcQeigtEa9CKO27Pis+nE8mFpMF?=
 =?us-ascii?Q?njw4Yyn0xNSOZxyd42FUJBtM9hQ+jnEZgfKXNlO31kx49Nkc+M8bE0Zzj999?=
 =?us-ascii?Q?xtLE6PakK/dHxljbPb+921XafLo9vBNC7P69PgCsgslN06anSp+zTpGoirYQ?=
 =?us-ascii?Q?Ah8GUIcdsW4U3Qt6FQwzr7usFdedCDEeMyT3XCJ0F4xCPbX7TWLiVSg/rTX2?=
 =?us-ascii?Q?cC72+n4JiNWEKLa2Cv2JdxGA9Cu1QN0hEC7wDUrOV/MPke0HWNKxThnbE2Lt?=
 =?us-ascii?Q?JW9PFX0ceJeIOlN6qaCZHSokmcJJrAojsNgDygWxqmCGQ6Ni1pqhaeogE+GP?=
 =?us-ascii?Q?Gij648u3sQ8QW2Qhs7eRpodGahOX6TDo0++8rWdezaj5RoWAjYl7N+eewnKP?=
 =?us-ascii?Q?0/VvVQ3aH2B9/mihnkLZutI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b20f38-2846-41b0-d9ba-08dcb20a2e56
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:13:18.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sE38NM49QCbEuP/RwwSv0grI/ytZXf8FZegtzO9aG5oLJL5tIufbLLJHdmXwGKGwkfd+B49tf1Vm3jEIbcD8qgxpZZbpFPRqHRtS2V2ZzD92rlifQSDBUY2pyOgtj1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6640

Define the I2C alias ports for the riser cards.

Besides that, it also adds the i2c muxes to switch to the i2c alias
ports.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 1679911e4fd8..0703b77e438b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -29,6 +29,18 @@ aliases {
 		i2c30 = &ocpslot_0;
 		i2c31 = &ocpslot_1;
 
+		/*
+		 *  i2c bus 32-33 assigned to Riser slot 0-1
+		 */
+		i2c32 = &i2c_riser0;
+		i2c33 = &i2c_riser1;
+
+		/*
+		 *  i2c bus 38-39 assigned to FRU on Riser slot 0-1
+		 */
+		i2c38 = &i2c_riser0_chn_0;
+		i2c39 = &i2c_riser1_chn_0;
+
 		/*
 		 *  I2C NVMe alias port
 		 */
@@ -551,6 +563,46 @@ ocpslot_1_temp: temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 		};
+
+		i2c_riser0: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				i2c_riser0_chn_0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+			};
+		};
+
+		i2c_riser1: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			i2c-mux@72 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				i2c_riser1_chn_0: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.43.0


