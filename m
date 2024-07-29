Return-Path: <linux-kernel+bounces-264958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E593EA99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C097E280E71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A58757F2;
	Mon, 29 Jul 2024 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpCuim6Q"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3279B7E;
	Mon, 29 Jul 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217290; cv=fail; b=Gnh8iFWeyv0xPvhZ4aNKcB5s5XH3fZUR31bWHzAYCb0HQatrsrRCgIf8rkg8efuOgzoorW6y8yEH1reErj6S4y4Bbc10Y7fUUB7peWOeL3njBkiVEz5R6+ME2R1CguBnxuAexC+PXL9aEKp3bIkYs1MVQkvjB/h/K/k3sfQkOG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217290; c=relaxed/simple;
	bh=7lHqV3FAnOmWcDaO7y7HRS8VrEIh/VbRF/h0kKkP1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KW43BAbQc13VJ72i9ENEmZTjykrEneK804pePpKJZzXVy0HsCvNfYdrItgqsR4CFPnLYe/mi/vJA9cv4BUAQPspf/goPintncQT+fl3RLvPReYGBu8qcjKlvPrdbJ+/j+6eHGe4VrYxsM3XT8Nb0bh0kzD4OgSM2E+bzGY+y2uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpCuim6Q; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mah3d6B0dD201W3NeQdjrEjtsZVvMetYrQT4ltcSdWoKbG+DeGRslfQfKmytG7olbziqCJUhtTKDKIiSJP9dcJ0+edKxECaqpPunVbZMqqvLMIOYK7bHX2LsdpOU5X7b07xI1QUl05HC0UrbJk2fmbXmczkGJHf/8qUXRyQRtXBVuPOzMvegbixpOWrvrBb7H1aKJ/n6/Sk3HWO9WsDhLi16MPbTFbleQgUyJzIGOPercEiEk4tM+F8NyINfKhe5hXWkCrEiazzR0eC5kyZXIxrK5aSlak7rVYSyf68kNtoyXv8obqcs/rojAdYVZaAPymUWJOXT1fElDNMydkY7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydnigG2okOf980Uk+QyFWm5acpBAPuOs5Ikqg7fcoBw=;
 b=k0W5dQ33GxjVXiE6fCmW6obG2XgwSWJd8P1FPZO4MxMbjPRxH1b3mzr/QAqjscCmVK0jSSrc+pqBbtFX0br5iYGdgt6Gsi7Bn0z7QuZbiCIhK1KUQnvI8m/8lDXVBnfo8bHPTHUBvFq5d7fFpj6WhOZu5CG4sFH4ANTu3KG5lYogTII31YxllCC4BIcYAJtV8dByV8uq8xvLgUYa4txEkjYt373hwfEka9PjCq9IjTdDmob4kEHFzFLmBdf3Ffx1vDJ/Z55AsKeqDPCJP5X8W3FmtsU8C0y/ft7mNXqJ3wJCXkix0e7haTFt0RRCg4ZXWa+ZKNw5tJZN01lujisfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydnigG2okOf980Uk+QyFWm5acpBAPuOs5Ikqg7fcoBw=;
 b=PpCuim6Q1BYyuBDCSgyL4w6HKAO1HHuOjjG6tXgy57ZyjA6dSfus4vK4WddnzSwWgYKNx4V3zOTeSMN5Nsp5NWbKVfk/S9NAaQ6VV1ZgluMwruGxV8CcJBmKGVYb6Ms3JiawnjLpRUSx9onKsJr9SFAi9XeEimPcw/dtHuhlign6xiw8GiLpFSzpHremw0fEplYmXpkSQHCH3ixuL5VAD35NVQJhojEy4/Z9nh+0Wcr2ETK4YHys57KZqA8d7ip2f+pCGe04UfW/ahY72sjanRvg7p9c0gwDL9s+KqKvQWXnEJAOuLMym+VAYCBbkl2mCM4+uW81oKL83HtrYzj5Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:41:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 01:41:26 +0000
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
Subject: [PATCH v2 RESEND 2/4] dt-bindings: clock: add RMII clock selection
Date: Mon, 29 Jul 2024 09:27:54 +0800
Message-Id: <20240729012756.3686758-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729012756.3686758-1-wei.fang@nxp.com>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: d838f2c3-6705-4309-e06a-08dcaf6f8f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9HnkJmmcCMmYewa8v3UiPb7RlqlynhDyVvHO+1gqtbhDtE1r0LSrbKW9k+E?=
 =?us-ascii?Q?CuVxKEmlsWbf55BEnLLicN2EephjqJS/OVjLmuObepuUl0YgoyUKsw+G777B?=
 =?us-ascii?Q?cWGfiS0e2dVM09nsfwluvAkWTH38epO3b7LVKlTScCgOUeS2Y/ZxW1RslMz9?=
 =?us-ascii?Q?fk+lbDlE5pLHEw+1pAwKivaJO/0WLyP2gwXafTRoeaLst6I89O3m1lZGJbyL?=
 =?us-ascii?Q?h/BA9E6okMiFuL+Wo+UbIxsJmyNVPGdfpaEySz5dhleGUE62ye0sVYbU6fLK?=
 =?us-ascii?Q?NH/cCDXPIBWV6PLZxrDMFGY6Cjja8rEPp6HzYDj5Am25VXenJa7HxhCoDkPg?=
 =?us-ascii?Q?1HcEtaohGAqGY1QJfuQcIDWlXEQP1rp4LfnMp3K2zzT4y6mIKSRrfe1TGmZ9?=
 =?us-ascii?Q?Gp6LHEuHqQWPGh+y9CsETATodAatYKEIGbQ5icEBPzMgcmFVKR6xlt7gi51X?=
 =?us-ascii?Q?MyPvrUTUMYahYY+k6NtC/n8WQ/PwMxJhy5finfhhqALv/GBRozGC2I2snZ+d?=
 =?us-ascii?Q?R8Q8WUio03gMkuGmZIV7xcWVVoJoHXIWErtoziXyEr4yVeaRmFRFF8FtWjUq?=
 =?us-ascii?Q?imMmzUpc48WVlEuKV7tQU0NknvwXUX/ClITwOe/cU0zw/toUpNGnC60Xj7+4?=
 =?us-ascii?Q?sSPB5oxhSARG6bpaCXUbkdq584krclQzDU3BjFpVTIc1UV16ngWuI0xTrR7n?=
 =?us-ascii?Q?5U78QGRVWOBirwCxhO/BsmiZwcGFGx8yaVWUVcxow1RngCsjfI00ChoV4t/E?=
 =?us-ascii?Q?vdbZcqb/PJkxFgBI6gzUk2XD4pyegdP4b8p5VOVmXTWOU5LTCmXJYHZjUdn7?=
 =?us-ascii?Q?/S6Qzlzg8xvIHVuJgzmzkz0sFwSsUyKw1rYcIfHeZH5+0XJjp3dWkkFUvzLD?=
 =?us-ascii?Q?L0DcJJh3V++6zmKUpzP6O5k7oZlRwd5guiMDf1mSaLhLOxpMXrrF1evgPqwq?=
 =?us-ascii?Q?M1FAy2TTtcmhsjunKEzZ1jVm2g55kzTE3Q7xvj1n2FATq1cYw9WPE5kkkE53?=
 =?us-ascii?Q?GlREiNHC6jTSQ3JESI6Xuu5fylA7/dt8/vuSMJ3+0BNVKSp2yIbk66Eg1y4b?=
 =?us-ascii?Q?NgmNoZp0x7252wQ/S9HPLO4XQOfFM+R2KqOhR48k+jWZ8DHwvjMOuXJG4a3W?=
 =?us-ascii?Q?g35iaTnBFRl2/1BIaQiaYX/++DQmmwyaeYiSySSyRAvsCEB8XdN6DN/I6k1P?=
 =?us-ascii?Q?3GMJ/ZBh/IlxeodtbtrckOzR5BLzOxdLM7lD8J8zPD9rFqf591sCgos95e5S?=
 =?us-ascii?Q?awTUk07819vM5jx7wAJ+wQareDw0SqJD0BmDZoFVpWW4tQskhp5EIa6UnCEL?=
 =?us-ascii?Q?X2UkuegDwGlf3XO5jB74vQgOyFcr8HW/Egnr7wRKQdU9+K1bDLaQZszktR9i?=
 =?us-ascii?Q?EHTTgJwRcpyhicDe1tgkJ0yA7CPYO83WilB630Dn2CYNCB8EDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KR4KK0kPyY7Xff2TsPQSGOg37xlsKVEAp2OqtZ0gF5+lzwqQNkYBOERTAawN?=
 =?us-ascii?Q?tL3rSYqU8Qdhhd6hsP5ufnaEJlMF9MvGZ2c9IOeVdIV4Aw1y2Gyso9V46pFY?=
 =?us-ascii?Q?7NchyRZrCWkPOVglQpBxEudkhCsO/RviOb0qgdE+I2qKvoSbhI+Pz57xr1Ha?=
 =?us-ascii?Q?p3q1tLH/85E6m9utxu7CI0tzGGC0+3rjecOVygw10Y0PZTKd05mtoWKrHb0m?=
 =?us-ascii?Q?x81bS9sjndeOjKzLCBKpVX2U8MIsXKzsksxw8HEcrqmu+nitRXt4tQq1YP5K?=
 =?us-ascii?Q?tBIRwCfNAD5M88uMiJwcK3WqVr+T4vyiE+R/dmu6Tw+I7g1Yp0ruUagRDl/s?=
 =?us-ascii?Q?6PbXIW+epTkQJMJ/qet8dMvF1x0EiZBCY43L82H9gDsMmtBY0Ifz5QZsiOSz?=
 =?us-ascii?Q?wwUSPVnZse3ZEAreoOtnYKVZWg5zVRsRhRBaUHO3wFioXVHX8q97pxf9mRnB?=
 =?us-ascii?Q?zdmjMNFdPhnMkq8CBWiOMzV3zKonXxzRvcwec35gQRFFXoZZavqL8r6tJHeI?=
 =?us-ascii?Q?cP2sgn+byxnYDqaRGDWiKC3Mdf3nUZR6/YA31vMHYMGI7Nfbdc9yqfzxAXbg?=
 =?us-ascii?Q?tiF9zXPNMNbcT/KQwMPchw/1LuwlcboeYtTGWXIHnlWt2O+WwDUP1/mTo4GC?=
 =?us-ascii?Q?dg7yfpgbyANUhfqIArGKNSyN86QCmx0e7XsfIy62NbMDahA3+UGU8kq0GXgV?=
 =?us-ascii?Q?cJlyK6YAWGTmlLiKWD6c9tkINU5qfVfRtZf7ORwGHadYfa1mT5l4PyIpcyds?=
 =?us-ascii?Q?uGa8Dwv3rE/NT/DcAYP6X1uWowJhuSuUycVa4OuLnhABeWj7n+4wrhfXq3gF?=
 =?us-ascii?Q?MTS6V1HUT+Dko+u9Z93JxS8cu2rU4ejUXtGzUR//7KBECKERj9D8eLvKUtQZ?=
 =?us-ascii?Q?YwsRKgH5GiwbRWOcEx79n659eOWMpW4T/VHBVe+RFfsg1sTbm6Q4LPQy1M3q?=
 =?us-ascii?Q?erVo4su7cxO7bQWmPJBNRYzoCip2gF9qul0nFFDzHrrG91z7xCDg72sk3Nb5?=
 =?us-ascii?Q?Z4tVpoWCEqCnTQrnYzilkUpdztD3ejZfALz172YsF2NzLYR8Yp23LeGwv5cV?=
 =?us-ascii?Q?Ex3ew3t+EmC0Giu1TXVaDUWEs/l6lXuQzKiiuLg376xcYNJj9qLK+9gEgYb9?=
 =?us-ascii?Q?Z3aAigf74DviOlfPBZa9SgBU3v7IZ1W5HhCOvFdnvTMpwTX2IgIlUHbfV6yu?=
 =?us-ascii?Q?OnQEl6gA9VJlGod/h5fXhY2xdnkf//TJh/Fmy8ovNLbgwWCdr/DMLTZXEfkw?=
 =?us-ascii?Q?alT6PofrAbn5cTasajxiFTnG78YOUtsEdpMPW20SgVzfbtwILjlbyGffnMQb?=
 =?us-ascii?Q?BzAI/qEzU2FUpzDInpIjVzgY6637xJIjg9sV1bTbdJ4y8wmjA5arpxyxmqbO?=
 =?us-ascii?Q?LpJleTCkRoRybjYarUsevjeduqHhSfOXKfjWAyRY5TKiKX4UlPO/RFJ0fERB?=
 =?us-ascii?Q?glicRGsaQcZsw1vuOKc5CEQczgb0aps6j5iEIMdJbikkiMp/NhJv/pvxD7GY?=
 =?us-ascii?Q?GmVDReGbpVCw7nt8iyjEUkfZeohUHzzCYEiokAxpoLOkW5OPTmR1D53dMAxg?=
 =?us-ascii?Q?Ldsnbf/dw/5/Ju/qryifDlBY0yoeVVtqKcjPfjch?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d838f2c3-6705-4309-e06a-08dcaf6f8f1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:41:25.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0//NZTaAvjF943JdWg1MoUCZ66hiE8vcFbsNGoIC2jRMESBH33felpsKTy/VmhL1adVWVmkl1QHpyJuhkT63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610

Add RMII clock selection for ENETC0 and ENETC1.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


