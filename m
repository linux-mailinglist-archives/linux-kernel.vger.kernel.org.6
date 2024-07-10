Return-Path: <linux-kernel+bounces-247291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBF92CDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D09B1C2228E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFF17DE0B;
	Wed, 10 Jul 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdPLvofF"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8817C7B1;
	Wed, 10 Jul 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601806; cv=fail; b=C3g+lPeQdYxGj/nDmn/iIkB3fpYDQXHnSodDMCE0/2smKJJA1GcDg+i/SMaGWNrrfMO7PFiqr12OH2YKbi+ZwWG/YkfUXTwAFUwbzFWAMR+I6l34cJaLgi/UYsU5wfEDoK8JQCEOXhfzn+zFc5U1MTQ1xOWKO+5/S33CZeC77OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601806; c=relaxed/simple;
	bh=rwfpEtys2wcJSJOgawaKdAuANF8MM6wCg/GTw+tWDOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9/zcCywH7FIte55KQRycJ6tNFvXytPn1x686UlaBxz1lYI25LItagxrMfxVxTFpksgiu8H/pE+vPIPPodLk4NeCNkcHFabt52hE86exmoEtSTemfwDyMXGzoOCEJ9lLuj8AEX8J5WRnF+ODw/iUolV3vJB68s9XPSxKVmEUA64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZdPLvofF; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF8N1e8Lygst/4FkM/px63S6dUsreVWDWP6/q40HtSlK3QCBzwC2OxoGGdjmVkA9pbBrvjaSdvgadef6T5tXEC0SLIk1aeEgT9j4+NZVTIHbWC152Q2TqIU2t/1hrZrJAihoCo9S+tSXoI+qL/hORWaGAi5Z1+67po44UMWnw2oSrtM8Qpwe1MjG3rUNxNZo03D/5yxkuQIiqlWdkwPMFfw99O/o901Kks9mRxx3KZ16QD30FnSuQLL73cKO0cWdCjG4d62ZNx++MnFF2f0V/9I0cZKDqoi9ehls2yWFjC1zcHH0d0RjMlJxAB0jXnps8m5iEQlqE0TwpqEAWXWbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tubGNx3uW5Z8MaOEsK/j6EFA2qbl6qYuh3tY4hIM4Ho=;
 b=GyZ+P8k1kdJOxzhHRTpEjWvCOswc5FhpsxSuv2UZAxQapzHrSH+BBU9gn3oaKJ+Y08Mxqk0v9S0of1GNnAwGCd40Uy6E4HDMDZO3pBKzbCcmlSCRsK+yKP898QzDiWRlmIeJjvTiHF2a7Zg4JfFw6ILB0MpsyZQXNXA55rRyOAIhyl62lBA4YW2wv9oAM8j3DRyGrZeuMB1GDaB6uRxv6AR4MQYgJgX69SJWXl3Lt1Md062eKd8CrUR/GSe2A0t51RSjTgJd7uQLe0liFHeNXRcGS4NSIeGxrAc3e+hnkUYo77swEmnjOj/r0z+zIqVUbcxJ7KwXro7BCFdPfVxUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tubGNx3uW5Z8MaOEsK/j6EFA2qbl6qYuh3tY4hIM4Ho=;
 b=ZdPLvofFtXUDP2qpww3hDvztw6kYRzVJ7vRrb9K6pgPuUYJujcCsEaaByoeQDS4gf0gXa54N5E0/BkZbxvjc9o4cIcEs6qMJJn6259QpBG7m71LAHmSzthyoe6k0wSkHOY58+vY7w7pQoFHkzxFH+Pbz2BubPXD2aQbJ/KEZh7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:56:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:56:40 +0000
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
Subject: [PATCH v2 1/4] dt-bindings: clock: add i.MX95 NETCMIX block control
Date: Wed, 10 Jul 2024 16:43:42 +0800
Message-Id: <20240710084345.2016687-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710084345.2016687-1-wei.fang@nxp.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6669d9-bc15-46c7-bbf7-08dca0be36e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhn6nvu633FI6EFfo72AzPG/feuikN3FoA/G8U/v+ZAJMbwqwE9U6GmXKWjV?=
 =?us-ascii?Q?ix6wE/lvIqd8j4s9Sske+QVdkKLUfr0K/7DtxttchInDzr9EK/uBgJT80x5t?=
 =?us-ascii?Q?WLPAT/08l18QANqkr79/9cozQouOb78ANP3rYWJEqWJParVOVJjOWA3O+7uX?=
 =?us-ascii?Q?hrwolN/icdeUKh/lWv9sgW+Mq/AchC9ogrDbcLf4yCcOJCKItNYHjq8e25HC?=
 =?us-ascii?Q?PEgBVJ7/t6ONmd/+0DiL4fXRfZ2XPg3xJFpaEOi8tJvh44IQEQxlrEYwHltj?=
 =?us-ascii?Q?AC8t6D+BzWiarmO3LZLFDs+b6zJDT1EQdR0jPj8N5bFOGoNfoO4V3kgoeCJA?=
 =?us-ascii?Q?CJDxrElbGcX/Ang7b/NHiHs9jTouDXOfyr2QF1rtM4OL/46S49b7JSSTUiZM?=
 =?us-ascii?Q?1w4HW7/yLMvf+z7lahBlG+7CH+7KSCw9d5l7wOBw81Q0WBiCY1F/jHKKgfjZ?=
 =?us-ascii?Q?2Mc+oQXoSLQzrzj5lTZXAJCrW6kBfeUg05TTm8mXRK72YqVxphF5cU6nGMiR?=
 =?us-ascii?Q?8iOHYwsYU9xxtyPPUTKpgFp68FsdMl+kRvBxbh3r2Y45XVYY35Z39bi39uEa?=
 =?us-ascii?Q?MzqxRwDw5MfZ5uK+E37/t+EnlLwj+5N9E1906C+/AQUma8u3amJdkWENIw+9?=
 =?us-ascii?Q?N4ehMC2l2MHFHE4jFjspHlgqfFicHyQhT4CbznwhFvGh/x8b6zmKxHKIqX3Q?=
 =?us-ascii?Q?pFz0WbOgGRitrFTJ4Q5bvMk+10Jw45Fam4UMuLHBd7ExYgbF4izUmBO184GU?=
 =?us-ascii?Q?WHkhASxY7F16OYk7wU0HT7ogciPxZ39YpgyYKhz2D1cb/XE84blODDjurzZj?=
 =?us-ascii?Q?e4B6WG4oQwfLPP94ND72UAvfogVPNoRVzAYOtLhchW7e9bF+qLezwtqam2nt?=
 =?us-ascii?Q?tpVfYC+oG+tXF66fR1t+ecUec0ZUxyzyujiC83aVwz5mTERcP179cF3mqePK?=
 =?us-ascii?Q?1JYsOxz3gdLgPqYshw9thgDO/KX/JleOYVIlbL8Y8WLkkVh2fCrJzJ3nng2S?=
 =?us-ascii?Q?knK+Od9dM5f3FYnbiJI1DINidZcB46YUETDInm44wc7OnXOrZFyaZfnq/OF6?=
 =?us-ascii?Q?s4Mjry/KKUHXec40X3giu3MR9ymBhsCjQazQCgBVIKIHCn6utgCOp7pKxRam?=
 =?us-ascii?Q?xnvGEV8mEsgWVWMbJT1AlhbCNwFCwpN5DggInqMsF48ebg9omf3xy7bXDcC7?=
 =?us-ascii?Q?uHZpmLsq9zsUEryKfvBbRiTFH4u7S6O9+qhQuGRKmAfm4wtqT1okD37X07hk?=
 =?us-ascii?Q?XkB06MuWi+OibPrulXZBKKNT+tbMmIVm7UXx790KJxhkuf0XrzEw9LWsekKY?=
 =?us-ascii?Q?1uLDd8XpCKBhMUOho1s3PJoqu+bf3dGT2XpM5wBvB+yA0nO1bxu6NIkrYALA?=
 =?us-ascii?Q?fRexMT0KQoaDo5l/QhA7S8kbSMub+786NoKkFaj1JsdWJCrO3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThsG6tpOBF1CDvuXDvrKq6X57cq6GAb1LdfaN781cAcouF8wamufNlQ9pinE?=
 =?us-ascii?Q?+zSJTPqy8VnCqXAD1WPQETYdrfuoB0tyx59S+0U9x2FOWB+Svs+Tw/9wDNxE?=
 =?us-ascii?Q?xr/uFx3nR/Pu1Sv7jvWdTHktjsE6y3ZYB8tlHJkqaPhWJktUIii8B6I5AuLL?=
 =?us-ascii?Q?Wtu85jlR9EtEMZumsIepzVysB50CI8YEqqZILdQ+vy2Gj/MwAYNJQN9orWMP?=
 =?us-ascii?Q?gdkuGQF0yL41vspKqovzlJDMTlX7bkN/eoxPt5fu5K9JV+2JGhZO7hH0o/y/?=
 =?us-ascii?Q?WYco7FxdhhwrpJ9ccMMh88XunlLZmk8P2cl2taQzDggoaCp/ci53d+guopSV?=
 =?us-ascii?Q?8ICHNAi1P7Broqmhp7+EYmKvVmVTtnZkJh04gWUwcgod3spwZ3rKUu9xwGaq?=
 =?us-ascii?Q?1SZGfHYqlh3g1/+i40Gvu3I7CerfADSWL2j6l0MtyGnMOB2f0T/mTX2SdtE3?=
 =?us-ascii?Q?BivLbYI4+85bBfsIMFrd+aeMBMIgqwpJXWWUUJfhgW+IcqXP190Tw9VfSqBP?=
 =?us-ascii?Q?O7g1kzzaVlQfyMcbdie2ZYvmnfNw1IdGUI+n47lOy92hJmiG+5TTkIzgHX7+?=
 =?us-ascii?Q?psFDs7wPNfI0ucBpj2tpivXDz63ITP1KcvDeuxvGLlIPyTAA+s+1v4J0FZPw?=
 =?us-ascii?Q?vtYpEpdbooC9lr1ePzzsXSSkc9qCEohXcBeDBft3JD6bn4rvoMixGgs5ZcTv?=
 =?us-ascii?Q?Rw8Pg9J77YLsQhS/26GcZaEFpganYz+8D2JjeGvjbItSlx2j4hJ7GCFa1bXY?=
 =?us-ascii?Q?8y7Ru+YRkHhYCLTSoarO2gmenyFskc0kd+AGsy2Q5tDRTLzf6kY9rw6tP7St?=
 =?us-ascii?Q?xr0nUkM+p11cwTC53UWrLuwe5kQrKfkQBBlDH2arX7Ebzr1caHGdeY9lFQ8y?=
 =?us-ascii?Q?KHMLaKlQdlnVmLSeFPc+GjG+C8xCfXCSz1tMgM7b75xI3jo+kax2eHxEdkce?=
 =?us-ascii?Q?N0R/BaoowL+Hg2PjS1ynIWPIr8ago9wir6CpF+gHHdw6lTU7zIHFzC0gNGhK?=
 =?us-ascii?Q?VX++Ovy5KTkTrqonYz1V9n6b3Y3e/ZEMQADt4NP27ZTDu7M9HJh/6aiZAX57?=
 =?us-ascii?Q?Ux6CgnGBXZ/UBdNLFmp7cU9p+Z3M3gHPfJ8hk2+cWuoiToGK0K5lkIz/T92E?=
 =?us-ascii?Q?+iJMDLOy1QJcloVO0WmPuKCy1FEwCYUweUxbu8ElglgAz6EwpLhkGRMU5oho?=
 =?us-ascii?Q?dz1qiVEn2fpy2PCKjoDf1fGa9kGMN4Fad+0j/SDAYYrNy+CN2dyJfeAox8Hu?=
 =?us-ascii?Q?nRnBcaDLVpKo1KKPhMIAGgQcdRZ65wE3hXHcmVAJYG9wYoXOeVROV7Q2+4oT?=
 =?us-ascii?Q?eWDMfQdLgE11JNR7NeD1D0vD4u7INuEiRTkn7cGXF6DQb7YmQcmTumVPg1+6?=
 =?us-ascii?Q?G1pkpFLHyBXR8DSau+InXWMl28ThBL9jg+nONIsa0u1QOtwvCTkL5Rp+qpk1?=
 =?us-ascii?Q?GY5SwESA1YxoQS2qCu2QnP6RNrH467mHRl/mt+Jn+aeyxugqbRawD1VQkuCO?=
 =?us-ascii?Q?+arFz6vZNO7vmOxQj5dG2NIZTcJXe7/VK+fEFdbsdUJqoIwxqifwQdnUOnn6?=
 =?us-ascii?Q?MwYeNyelMOPMTmi4HkyqPGp34047C4gQDRxZPnKM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6669d9-bc15-46c7-bbf7-08dca0be36e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:56:40.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/gDIUf/Vy7UVM3ZuWBq4KPMgRu9tXNunMPBXXe3at8tB/cipQIT3mJXPMHfBgC/QlxIZMVYAEnEHH2cJd3tmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
V2:
No changes.
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..b0072bae12d9 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -17,6 +17,7 @@ properties:
           - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
           - nxp,imx95-vpu-csr
+          - nxp,imx95-netcmix-blk-ctrl
       - const: syscon
 
   reg:
-- 
2.34.1


