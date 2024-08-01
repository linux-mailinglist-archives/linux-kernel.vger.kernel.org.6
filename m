Return-Path: <linux-kernel+bounces-270964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318D9447E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA6D1F28C35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7940170A2E;
	Thu,  1 Aug 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C5QhnRwc"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020106.outbound.protection.outlook.com [52.101.61.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4116EB54;
	Thu,  1 Aug 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503572; cv=fail; b=hW/BY2WVT3CwnyvfW/b0ygXkts9i6uD5hSE3RyqjMvFozL1+E4HRfNGWHgBEp7rASLDjGHrTCIYhCL1GBR0+vH+d4pK7ooSMNRCY3lXSitzWWxdTmdvuBZTOwNc/5L4LmZv3Xa8AXCC4opKEW1JD7rrta73XHVX2PKkYI01OgJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503572; c=relaxed/simple;
	bh=ybzbieb1YFGs2DTfGeJ0MoHRs0MG69DM1APtxINECbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kJWeK9kpumKXEKGfD/wSvd6qyR5B3apE1c5dOX/u4O0uDhfD3lQbYeP532toAlX21qKRuC9DSweS+i4CY+1N/LRsaTA++0L3XW3BdMKu9oFyjlKUW7EdaAEAIKowm8py67Trl8aLMbiCX5XHxJt470RQ3rXmY+5HqOffKnj+/HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C5QhnRwc; arc=fail smtp.client-ip=52.101.61.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP6T7U+7H1ovMpH4wyTaxRqBAdP2oMBawoIYMcrokYAvPDv6qKL5ZBDjnp/mqOWwqdCdM5VqeNjvTBB0g0Lc5vWCr6WIm1lbeu/41BNOJZKhLt1hcZt5cMmgL+/2pKHkX37MQ+xsr7kGVrgaJOvfo+wQiH1hWLiCwoRi1H7bGdfyHUqHXOFxLtwudDwTpQXNishH2IZMeTcTq5+uwrncj5PGzXAE/A39igPj3rfVq3LTGqln3Wevshyxbknfw9va5BW5uKvheF4LirCP/xQcd0+0TEkGQi+jlbInHy8dGovXlHX154C60P6NK3Ohx1Zmn06DzpgZtMfriRio41FuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRb9xLeS+xutNZtENfP2k3UyTacyvn6FbIq4C+D0F5I=;
 b=xRY6q3ib47zO+nS9ZaTNocRCGGAXPPhlXBf/M+lZR3TyH/tFkv1M8xLj0kxTi0WtDQquiQ1VuYsp0pW/ER8P9J/YueGq8sldT7uVEkTcpBFqMnGuuFKv923KmGuDArYw+bLr9/rvtfs8jKyjiDZdzvxiPLHGaYYwfuJQ26JiQJ+2VCPbRgQosQKFZs2HRSBgBBY8Am3n5rEkT5wVJHFgaBDVeuKu+2LrkUds/XFqSReQl0qxeeE7xdiLFWxcgDr4wnaYZsP2CSFYXIJoc2dna0LdgYha1jtCQTrdc1UdD98Xtsiv7Gser7s+a5LgtgQ06WkGFPz88Fe4RyZYZRM6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRb9xLeS+xutNZtENfP2k3UyTacyvn6FbIq4C+D0F5I=;
 b=C5QhnRwcC6lvRIBLUmaXsgwNh3x3j6uhw7wRs2VbVWN7typh7ome4Zoygpt+qFECKJ9t8NyKl34H1SFB+Ban2hk4qcWE1r98IA/fsBTGoRAWMZpcto3xKXFmezY/M9QELTmy8PkajZMuljXjj2XYUeV3iORfQd/1ri7molpLRUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 SA1PR01MB6640.prod.exchangelabs.com (2603:10b6:806:1a4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Thu, 1 Aug 2024 09:12:47 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 09:12:47 +0000
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
Subject: [PATCH 0/6] Update the device tree for Ampere's BMC platform
Date: Thu,  1 Aug 2024 09:12:10 +0000
Message-ID: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 77ea84a6-0d12-4dfe-4021-08dcb20a1b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgRif0H3FpDfYxE5ixJpvX4EKyvZhujW25BqKVCuATmHglo9cg9rZAJcyyL6?=
 =?us-ascii?Q?Ko3CfduhquwCDOXQQzpnhKj0Cq2xj18KE9GVNGVYEdIpFZTgR9CU3+smeLrb?=
 =?us-ascii?Q?F5WjDznKKlIEc3a2ifwSuzrvZtsKskksB9QBWbTe/2qHYQD6WKWSkP9lGGem?=
 =?us-ascii?Q?UugelnTbJuO6Rll9XYR3imp42sQJdRQT2v0Ld0NL1UXWeRFmjMX+do9LfEPN?=
 =?us-ascii?Q?3P0sUN+E3d59zr5igdRSK4Mzhx/+vjPmXxa6iZvLkTMtEBo9RIHAQ7f84Unc?=
 =?us-ascii?Q?zqoYf9ynR7tIJcHnvvF/b+s+5njpb+JJn59tYfb+iTsKl77229j7l7VpTBmV?=
 =?us-ascii?Q?/bD2eGtxO3h7kRQjqutLRMflfHHZg/4rENDuNpRVxfsgSoVJhZFWHSyeqsTk?=
 =?us-ascii?Q?D3P/hVJ+0gFJBbY2HIPkRVxnKAuu5eA+Uq848iiVysxVm+FtHxi+oN55byt2?=
 =?us-ascii?Q?l6H0qNvkeCJscLYh5H9g8GUVNqPTxqEEDPxKnv9z42wrs7EMxTsqA+M8soiI?=
 =?us-ascii?Q?zW0Wm4haJZlvIvHEvgsDvYw/vcq9qUbwtjifndR2IGPc3e/kk4OvqVKBxiLw?=
 =?us-ascii?Q?cGeD+BNWk/3uBo4fP+gY9esPGKkBAX/c1WBVTxYpdgiRw3BErulfgJN2dggc?=
 =?us-ascii?Q?1myCLEswvM4X50AT7z9nulbg7xHR/r1KWfj9MRM6G34pGx5CeB7wOpY18Ji8?=
 =?us-ascii?Q?pc135ewoWKN06lVzBas8xKNzTeEOQh7Yfq44TbHOCXdEufryeaCY2dtc/FGQ?=
 =?us-ascii?Q?p1OzpydokUU4VIaeJNdyIhvnV4xMCjmHkmjqBrKDbVvVXvlLM8g8hfgv8IgF?=
 =?us-ascii?Q?mVXuVG+IeBvpaPl7eOlptokAuTSpolQC2m/cjxS3BSAKz2S/vT5UWu5XEFII?=
 =?us-ascii?Q?OjfjR0dSQ92Vo/QZ/h6aZcLVxzK78twgzD2Rm87I+coCPvYIrAv3lvfcADS/?=
 =?us-ascii?Q?00QY9WGVlXeN/qYAXofPWzMNR0nUbZ/OYohBO+GmZEq+gCyqJS1YZeExJj2p?=
 =?us-ascii?Q?AEtqRcJT7NAcp9MiShrVkukfXBLsSVDZ2q5EdxhnV3wudmreFMQI3hgRmAgn?=
 =?us-ascii?Q?jAXSxzmnbPsREZI1vKgFv2Cwj/dZvpjzD+RWVIwaOh+iXMRU2uvrZwPZMhl2?=
 =?us-ascii?Q?VSLaVoUd4Y5GmEpzOlZK29wM50UfDB3Q7fjNqTeOOaEdhwUu29Vn8KALURSM?=
 =?us-ascii?Q?2tG+WJLzQRMKsaHoQ1LD/zPmm7lkn4WHNOW2ceBiDQySmqpxHgyaMPMvsRYQ?=
 =?us-ascii?Q?FRimRRcT614pZf9c6hK4OprjlJEZN+th6kII8CfbW9+Zx6rCARzwoARUdc+N?=
 =?us-ascii?Q?INjdLO8gSmNKXMCV/BZMn8iB5rVm9nsahQHIVdAAxMPDBQ8UsvGhOurzEBso?=
 =?us-ascii?Q?s0oykyqsOOZEQ8PCWRRX7AKrnI2jfGRcGaT4J2AXaeJZMGyOrjCWCrKl1VEb?=
 =?us-ascii?Q?m9IRi5VKqnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJkzsstaaA5zleXfTR+lnSmv/eWFY5V4iHRxd80MZ+Q0zx5a6pnlVBuJBC39?=
 =?us-ascii?Q?jn09m7+21v7d7WBWSFRMcc5g5q7Vvvve5iRMiBNKKbLDWFTcKgBg9TISLwm8?=
 =?us-ascii?Q?wDDYglFTZmaPV+xmML+JrXNvr1cyDxQgWwvBFHj9+nauG9c7i4UrnlGOcKVG?=
 =?us-ascii?Q?KECLdvQkwmbT1DoEop9W6cAJd54dM2P0IIrLV8dVCnOMTjccmCtIHNCXGLuc?=
 =?us-ascii?Q?Ok1of8tQVVRyitEaPvVEnRSyt1lZYjQGdGhsakP5Dy5tR3sPuXab8jYEcZzA?=
 =?us-ascii?Q?a8Xil9oXBQH+YscozKkIfEu9wNvPFzyYFyQR9WDwfhRzYZO1PdZB6IZ07WSx?=
 =?us-ascii?Q?vSLhL3WwGASHtdb0jlxqfCVC0nPE3eFASHxQ5FboK/lek3mvCl7KG1N3UQdt?=
 =?us-ascii?Q?buEaf5bjHj2IdelXHktuK8GHr0pEKpZHGZ76PGNnOm/UWk6nL92p0X3qCR5e?=
 =?us-ascii?Q?H43q69A+0MGEKRAEmOpfsywpuJHGLozy2g4E5aKEfg9gd/9C22gzLYPIXsgd?=
 =?us-ascii?Q?aoo/B+Vp16n48z1aKefYiwq/a3uzR/f4TpfMeOcuoPY3X5WahCptUwWOwZ9X?=
 =?us-ascii?Q?zUlyBNIs+h7h6hxet7DQ3Cvx9+jnCsVrRD1no+A8eOMFeTdr4Eyfbc0CpOGS?=
 =?us-ascii?Q?3sE+1N6cF/Ikt3SgYF3DumCGMbvCccye9s95wXtSY3Wf2cPccfLm5+6Ve47k?=
 =?us-ascii?Q?6JNGkJdLd98NwjScwW1sSRKhuKXqlVLGTy7/5Ng6nsiD6R+hQgDQ+UqMvNUe?=
 =?us-ascii?Q?OIU/UWebQyYGa6JpGRZfhNApSn0y0Mq3ClZVu+VK7ycj2Xmb0HfElea95lcA?=
 =?us-ascii?Q?nQAxhGj4jZF6W47sKhEfWtj7pVNJZvXbFBkciTnBl3d8ibGFiCyMD47dk71S?=
 =?us-ascii?Q?IFsuScKtqkTuGFX0cYc3GmrcH8ZaxMxNUcmfpXAnWVC4CJzWpb5MkpKsa8hm?=
 =?us-ascii?Q?4617PRYYDHAOYKnJaHL59HJ1nIHUTo1w5QF2S9pwUJvkGJoV9OfWuu+dpG95?=
 =?us-ascii?Q?KtkQbcAyu5dbXUXS2KtRrfn05PpKIvuEZE8hSc2NLVEAWKqJN+aRTE36gGkO?=
 =?us-ascii?Q?wN5ZiAiOWFdglOU660fwa6QgA7Aunx+1bUMf+nkbkxdX636QyuJRZNTNojnO?=
 =?us-ascii?Q?v0ygQ7iJ/CGqlh3YwMCUSuoFj2okFXrcDGhzIDokvPLx5fqrfMmHObTskD6H?=
 =?us-ascii?Q?Q1+NUJfXrdAv2CQgRY4hY1MRUjqDVUrVikdb9RyIGMC7FpmzLybDjRiAcJyl?=
 =?us-ascii?Q?qbru8VNDM78UjYboTLl0LmyeTEPZjpFbk7UFaTLZrsGgqwYTkB/unlROz6Sj?=
 =?us-ascii?Q?lyeosIEdQxOS/Orqa0ovZDvVRMRkBKd+VHOlft3m0U2J30SdVqEcc+UciC1P?=
 =?us-ascii?Q?ubtTBc56+gPaAKLuM8kDUBtKAykCL8o/amL4hXadRptoLiZDzzWpA0b6xY8n?=
 =?us-ascii?Q?/lcGPRcGrShzvf4PDkpGR6IK+23wKKpBgLIU3sU7IgqhEkxXQuyzCbPrm6R+?=
 =?us-ascii?Q?Y2K+lBwRqPhEBq0KOJboEW4mEBviuN0hHhWzN8t7I8p/q6XaflXpvbrWxL7J?=
 =?us-ascii?Q?5JP6OTEmKczuqHiDnvlQXkZkBf9+WuM9qzqFAYtRQNs8QQH9bht04FIKNnXe?=
 =?us-ascii?Q?1/qbjfMMHLqZ/SWFxP67OfI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ea84a6-0d12-4dfe-4021-08dcb20a1b94
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:12:46.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/H4KMp7VuFpao4Sdoe/LWhafrurpMBMw3Wac2mDgPwbzEvSX+PV4Wt4qvCWQTlfFvidvPgoWir73rEaH83ZW1y8RsbTyAkXHzC5B857i4CWM8dzalCRa4x+X1rRWK9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6640

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC and Ampere's Mt.Jade BMC.

Chanh Nguyen (6):
  ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
  ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
  ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
  ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
  ARM: dts: aspeed: mtmitchell: Add LEDs
  ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers

 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 152 ++++++++++++++++++
 2 files changed, 168 insertions(+)

-- 
2.43.0


