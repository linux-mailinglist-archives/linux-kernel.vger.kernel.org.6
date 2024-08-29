Return-Path: <linux-kernel+bounces-305997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037409637CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C494B22527
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC11C6B2;
	Thu, 29 Aug 2024 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KOs079Ox"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B939851;
	Thu, 29 Aug 2024 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895218; cv=fail; b=KtzdUAipPDGGorDFLGhn5RIJ2FesExNjlA9cme0BzxfSs2ymtq4qDhj269vpsr59uM3OG/W1LmRVTXXLJ/2LJlrcaO9q4+1gSe4QR6Ppk5GAb0MTv/cb1K2X0XfnajhmR5MwrefbmC+4TwwFn+cqKAoSh2WglkuwIk0jg7LNO1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895218; c=relaxed/simple;
	bh=ssxP1eI1DFOfyFrRxsAn4aLMOK9YEuJtCY7vX6WgDjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1j5gsOeIN6JhT9EqzgbJGrTV8/EwxJ40v52hJGlo1LgdFmX1y4yLrAu8pDgb3+rn6vhXwxLq2HjO47V3Caix/OMV2nSq5+bQug0LC/WybooGXnw4QADLPWyw6HFr/r5KajJGeSc4IBjnkMmX550iEGziPDOtAZzm838RuNUgzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KOs079Ox; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iftpgrcmsb1utSkLL9glQAeHI1q9+tNaon/ExWMI/4P/QNAmTuzf9hFXl9QwS0vdYICU53u9FIZaEg9gD5KTqIQz/wzbPb33Fn+2cL8Z6mqUi004t630n8KMSZmio0DIV0lyheOzByy9P0g35MEMv0vArKhG9z0VDehErEi6w05p3uk9zFmH0LqCu4yl375DwvMdNSW8dIHgN4LxRdI2X8ZwcMAGIJD8KnXXFZS0gp5Lc6Fva6KaEhGGTeAf0sqbWsb8TuHmcG3kha7Tga4KekspMG8ZQo4xyNEmtFLmGGXToRut99hS/E71G88oSLc8QN18Ph08RuWkNlJvfHqRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7DxTycszJsEBV8KWvLWARM2vT95DJCz/NDpBmQQvsM=;
 b=uryyLgfw3KOdnVSyTZw0H09nVlsR9L2BdctOJb3K3QOlI0RGW+eSL48XiblTFTDVzCweRR9QDNfZbJwjfM/0XpY2W3P8T3swDcnIvpfLbzq/590MHQdM2YmdTbzoKNcldhEdSA64uT4iCiEDfSGZUtf5dUHQ5AYUCAWmJz1MNVqZ55v0I5WUdY2FEyW6P1/9/1n7xtikmNKQ8kXDafe7fS9cJcgv8IWyPJc5agDv/UpYQPwuJ9jOY+gzrHBk5sQ4G/Gq/pwGawgybUvCot1mEefV122LaFv1ZaHx9waMkFlYdjjKu7F4SY/4f7PD6/QLaVFDTG/B+tBv0HQeCsazRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7DxTycszJsEBV8KWvLWARM2vT95DJCz/NDpBmQQvsM=;
 b=KOs079OxDAhW0IAwdmlgR6zRtzrQ9YA7ei3T1xLpCVYuxGctZ8O/URCTy6BA3IiCc10fEyFf52dP6xCvR/AEX7jktZM8nPQJ2bcWfu995Ss3ylI7o+Rz3/v2udLMgjP0dOiHJKuJ3TgywMO+KhWN029yqoipPcOWSJWyPDTxgzzysGJlA1lkmuwlm4NTQ3cCIinBrnlgF3S3fqA3ebrjWCTMxwQJWIFPuhNOBSrgPpwYsobEiH4YpLkPYfwxE2JaJlP/5eeomAIeYLOyYBbjNLBMqybloDtigZjOP5pJzKEEUgMAtDejtD1uxtOFL0QD1UxRRMCh8scSwR2DLPjyCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 01:33:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:33:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v3 2/4] dt-bindings: clock: add RMII clock selection
Date: Thu, 29 Aug 2024 09:18:47 +0800
Message-Id: <20240829011849.364987-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829011849.364987-1-wei.fang@nxp.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: aad54934-6951-4f0c-c9b5-08dcc7ca9868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdhnqNkFHv1NMUKmYUQbPGh0HVz7cUeiPCatPbWzhGP5LeZk2xXCslIG7pfP?=
 =?us-ascii?Q?/N4ONquS7PpSJKfxJIKCXPxxhUfhR/Ja78cVlQcMJ/3qLHObO3MhU33b3Jlf?=
 =?us-ascii?Q?pHCAyZ+RDQvUdl7Y9t6F1EAVPwLaFbfzT9wdy0wQVIGRwQuV588x5WAboD+N?=
 =?us-ascii?Q?/ZRio3IVpPCjKEzrDTJ2g1MIuh/nr6e0W8DtSpbnRgAY1iyIidbUIXYTZ3WQ?=
 =?us-ascii?Q?2YcXN9EOKSoiUfFVGWDdrx/hblwVXvFC5G6U65iaHh7FGbRwnhaNVABl8xYr?=
 =?us-ascii?Q?NDMqzgnfrWFLNxezwb98ktCtp+P1n3aPxFzUExA8rujQR4e3mpycnfZCJBFr?=
 =?us-ascii?Q?HY87yJ9lSSmzyXoC62ZR0fioTHdab+O5zUNlrH2fzgyBfH+d8IPuLva0ZN4T?=
 =?us-ascii?Q?1z12Mvr9fI4w4/qp2g3BbsWCFZvG69pfs04Oaf0+XH9DBTUcA1CNhEYWIE+k?=
 =?us-ascii?Q?o9yc7Lydbx0EdlLbQx1NGWEVQPFob/EcrELkvFArqrfgRXD1x/jt931hyQVa?=
 =?us-ascii?Q?I0bZcx3jSupLsRjjjkrBCLjmmbiKBgb12rsG2t2iWWO5+Dvjgv7io7muI1kR?=
 =?us-ascii?Q?78biEbK9vdFs1zoDTtuNjHBGXuogsddo5ozeU2/ka8cncpRgR7ZaGsUDTxoR?=
 =?us-ascii?Q?UZscBkVQKwo/BwZ3BDzFB8qvjfFfnnB38WGT5e2CVaDnU7uM4BZN48OaZ5i4?=
 =?us-ascii?Q?a0R/IVDglUp1ErWHtYBn3XZzj7u0AaAVVEZn2HY+a6pWAL/JGj36RA2+2Bn9?=
 =?us-ascii?Q?/wr2ZXSA4K7bzC6Izr8EzzfGHwxVsbridi09gCRcYlE3eGYbNVtO7oyjBzoG?=
 =?us-ascii?Q?KWS+Y3A4XFKNu2tB/K6tsdkuEL3LjS2b5movLsI/c6ZYEZfLfyKqnf5Q61Va?=
 =?us-ascii?Q?3MQpiI/6Sf4sNN0uoV2j0jpsMhfkkSpnzehO4Fa/o3Fgm+7p98xU9S0YnPZL?=
 =?us-ascii?Q?bFUe0s64qwOzZTav2rIoo2mELPUAUcTVaO8EUop1grFgW6PHId41B9b7sM05?=
 =?us-ascii?Q?vrh/Wf3IMEG5vLCzULx/hZzRO1qFpu9bZtHS+ksIKO3mmWhAcSFZZLAj8DUd?=
 =?us-ascii?Q?lpn4DEVSERKEf2nwtVSocdJBn/kH4DY6A3Z9VBnBeL3BFkmtEhKQbe9qb9UE?=
 =?us-ascii?Q?baQRxavPk6Or9Cjr6ICm+24vZcaGrT0vcsvEmzHOcdpFizEkRG+dXo5YyMd3?=
 =?us-ascii?Q?fMO82BEzpdXhFFBpzAFF80RkMBsg20LXcGXBhejV2TOxnfYpsXIQJaDgsTO6?=
 =?us-ascii?Q?zYrkTBNV/8eliCgl8gqsIkoya6pQw8qW06KagpP9OEa09/Fk9yKmg8HiaZVW?=
 =?us-ascii?Q?/xvcqr3z9jg+8NPEAfuuKUfo7MdlIa2ptvsBAcjd1F8ufUtf8dXPH8AIOyZA?=
 =?us-ascii?Q?/eHPCB+BUIZgE0Zy9oBBCt6M2zY0qA6Mvbrlkj/1xY7D1dGsPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hhf4VcOu7agniyGR17rVy7z8XtgG210POKwpLHx/LsDuCqoVHfesSPd5qPUg?=
 =?us-ascii?Q?MSpIzvPSE/z6atNLHIS0u9y55g7LpGkRo7o9FlveeWeDLLJACFCldzs/0hHq?=
 =?us-ascii?Q?P+mVEgtv/lamDoatpbx/0v286wbN4Du2R/q1ijkv75qKd0LgvNZCY5fhtVNa?=
 =?us-ascii?Q?wox0zRspjiahGV6qR4nYX20brbFlcp6uyWJ+q5dBxK55miFCwzYp1uX0De3u?=
 =?us-ascii?Q?z6hu46aq02y9EAXKYfgZ9MRsikyyX5Byz1YF5XuvvxiUXDWcJsC/8uKbIaYt?=
 =?us-ascii?Q?dsThd7/eJwcZz6tYH3rFYGb2X2RL6V50t95OUJM9WWLKStH/qPeQm8fQ7+O8?=
 =?us-ascii?Q?C0kkJSGruchH4WVdGd48wEobO2XnVWrBQxsqHNzehkX/mMb2cBgY9AINW0P+?=
 =?us-ascii?Q?fcZX7HPzmbn5p5mLl9pSFJfwmQ9534eH4yhijzWCzlobyebO4Vuy/Xshb2FP?=
 =?us-ascii?Q?MZbevmUxFwNawbZgaFyUMqIcV2Q7BqpNeAVB/5AKIGmksgY/05kfSje+vYur?=
 =?us-ascii?Q?Qtzd8n4gh/Q4R1YeOLqpor0XeDpEvwKgJTcOPgvnGtmrSD+3N5S0eBfO4m7Z?=
 =?us-ascii?Q?4HRS500Xn03D8fZFbgs/kJ81mT9u241kKOnKZV/NUswG0LtywnK5aaBSFyUp?=
 =?us-ascii?Q?90VekUfUCvAfCia3J5hYm02rLULYtCDntM0EJH5i4YX71iL0kdYPhKcijyFG?=
 =?us-ascii?Q?FDDGk/HzgigDN9HkTStDtb5c31XYLczxhUIDtKD+HnHErPel9wjlNuk36iHc?=
 =?us-ascii?Q?rc/LSCs0jy4RhsRqPZ1RQKthRzEn/b6gMluGlUNd+g2NXlX04TT+8PhhWJWp?=
 =?us-ascii?Q?HtdJciEhuTjnurR4ntPtEdGAROYZA6akrA7cUEhXM0SFxDEy3peKrSED0wSD?=
 =?us-ascii?Q?m5h48QjsQcw0u0VfPfRgvDvZ4jINd2JOfBJD3qrId5EB/5EIxA0ugAlonb7u?=
 =?us-ascii?Q?+WUJu6On4GJ7c7t8iPeOD7ilYYvoCIkC1DR4bRzGrLLtkTAQuwbZI89eXUrr?=
 =?us-ascii?Q?OOk22qC97NEVnhcRb/wncItdm2x6Z8+ulNO3hnrxh2P02fetYjX4zlj02taW?=
 =?us-ascii?Q?aTsYaVqzsH9AZHGnh1kohEvED9qxIKmSI44KE/n4K+pHpA56CF46vWX1wOCl?=
 =?us-ascii?Q?H7GeZnREmErUZiX7oE+6aM1WGkOWwsCubfqLp+auHZplh39IAM/l2N659gcC?=
 =?us-ascii?Q?XfMmktBeyXZiT0KJ91xYGofI/pa+OBJx59OZ9tfRn0mTVqu2z91Av9CtB2gP?=
 =?us-ascii?Q?HBxxEJqEMI1Ub6ZyrCA86xZ6pSlg3/o9TYyJBn70HmsayhLAsT/LwRbpwrsi?=
 =?us-ascii?Q?0d5o56hm1qe7AwhzqF3wQnL0uCia86IKLlZQrtZuTpLrZIn7+Rl1ATvg1z4k?=
 =?us-ascii?Q?vUU0pmznHzPUeUnqsK5ehVaIUMSkMSBdS+Nz8P+cuolBprsq0fmtoFpm5IRd?=
 =?us-ascii?Q?3NfvrKQyOX0oEnzvbAOmyQxwHXtCZbI6Oi763ykJT8k/5e414v2ancbrvZaA?=
 =?us-ascii?Q?OCKM9/lACnSzkDXr9q8h/zi0CpM1BRQBS3QhBXLDdFaeDiz3l5ZEZjagTXjn?=
 =?us-ascii?Q?/SDrq76X9PbxsWyT2uYunZMRVdec3RulmTWBnV1B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad54934-6951-4f0c-c9b5-08dcc7ca9868
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:33:33.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm+l5N1MFSvbKobLfu0e8bgKHdHOb/Lm1Q+nFSZzEYPxS1VIpsyLP1oJA2ySaiBtba3JtikeE+c1uLldhq1TFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924

Add RMII clock selection for ENETC0 and ENETC1.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
V3 no changes
---
 include/dt-bindings/clock/nxp,imx95-clock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h b/include/dt-bindings/clock/nxp,imx95-clock.h
index 782662c3e740..b7a713a9ac8c 100644
--- a/include/dt-bindings/clock/nxp,imx95-clock.h
+++ b/include/dt-bindings/clock/nxp,imx95-clock.h
@@ -25,4 +25,7 @@
 #define IMX95_CLK_DISPMIX_ENG0_SEL		0
 #define IMX95_CLK_DISPMIX_ENG1_SEL		1
 
+#define IMX95_CLK_NETCMIX_ENETC0_RMII		0
+#define IMX95_CLK_NETCMIX_ENETC1_RMII		1
+
 #endif	/* __DT_BINDINGS_CLOCK_IMX95_H */
-- 
2.34.1


