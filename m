Return-Path: <linux-kernel+bounces-549748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB42A556C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171A03A91C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9B271813;
	Thu,  6 Mar 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSTuIyRi"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F84DDA8;
	Thu,  6 Mar 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289435; cv=fail; b=D7sOMOJu9+/feRBP630BoxAFJUD6cuRWLNMcEVe4G9mJK3VB7kgAfsVV/qXo5uaHtjqb75bpvh1zf0EnaKsuoEl1+39FxtLJfJqQhkkcI8n0TwPWRnBS6uR1dygx6fXRwwWZfdEC2+8f2A/nRnTf4hFrxXrarBO4uScYUQTMlnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289435; c=relaxed/simple;
	bh=DQfdWxkDu+nv8JQYO1YxdNIOn9gyDDdttKxXxaRT/9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V2YAIf0jntjQbqLon0dj76duWKPpwdN9nfTNd/0creCjOZwEuwF8E+eSKH8xoBTKeLXr49Nu7Aqpq+lc6vUVZuofkGeuVn6omfbgl5HFdJXagJpQg4EwJiZwJ53VvCqgucCWy8gSKwRiuxGqOcLzW50pZ8tc4SnFc22ENq/Nmdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gSTuIyRi; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxGOEUr8TEPBjqmP+edLEfys6cnBu3aZsWy7rP2SsFST7ZgWyrBbcHUgHeI+sEapmsPJsO1PT/RNIXJT86rdLDPyeZiVDKlc5NUGZQ253mAywNpolup77Ar1Y8RzNcaGnOKz1O77T6wyc3eCTgXGdLW/z4PY0Ita3ZWdyJt4xdil3NHziMhl34EeIGl9+Ahm1QHSgLBmrG8wYo2HajDWk7ZAkCn5G89Cq9MqN66sYO5jc1+NCUnoshvOMI94/gpUl3HkUXJV9hAO9+qmUN9Wg5Yst7BOANytKASPB4olQiG63Ui1mgjf82XCydUbEng72bSPcbd360q7xAIeo4oHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4lZprBsjxfoJKmSJtBmCNOzlyVAap6iteMuzJTK2AE=;
 b=SzKmp4EsNPr3u1e5nT5IgxFEbDF0QmaKFeGtoHYw0st+R9v5xeWN9h/7V6lk86o72VeQaMnPmA65rbwNAuiKhYS0WL0mKN7VepoErLEsrnDtQC74FtqGuU5EvVlPxx9eBbyy2uHzA2I5foZ8Vuv90UZyrRq6DgFpxlPen+bZ0yPVJ5cI/hpgPmjMwWvyzRKrmVwqi/mpH0TwLwjR54KDmw10+GuWbrLWupse5k61FjL6pI8p7mNio7xDijxxtZG2hEn7ZbTgXMBbUUkXnAOJJtoA8PPaSkyaQGynyJOz2oc8IqQ7ve/mOx3hDzRe5hilEJQcWGY5sWOko+czjJs/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4lZprBsjxfoJKmSJtBmCNOzlyVAap6iteMuzJTK2AE=;
 b=gSTuIyRiGLfHltBukqVu0PwyP1WgZS9GKYq+K15MImoJN1ubz0q9uqVdL99N9WNjwGm9XSxkCMJxDrXSiw2VnEvFI9hHHYJ0SDO3n7nw8rGarm2WDvf5Op0vD7tixOqvia9rStpvkqEXbYEtbPy7rqmjSMpaSc1ij7i8zSZAvC2w70g8FroqWuCevsYPm1CoaDdaHT3yQ3g9t2rbJ+xX7Hv4M3z/jm+ZxIIFJXawuDqni3bMozN6vbBfyGdq9nDMi49LecxTCVi/edwd3OpEvl7EZRFGxIUFHvfOu0s7UtxsmzGyOso6+3kuVOqVQdO2W5EeE6f0WAqpX42fvWLSZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:30:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:30:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] arm64: dtsi: imx93: add alias id for bbnsm_rtc
Date: Thu,  6 Mar 2025 14:30:14 -0500
Message-Id: <20250306193014.490091-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e82c337-c1a8-48ba-78b2-08dd5ce55ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bw0xn0zsz8jDQJGCobS9jr3Ch0ju/NWaU1USj0Zy7mXbFm0x9FL+ivufmGgH?=
 =?us-ascii?Q?8gGCQYume1e2uEaTBjKrC5B/vS96VXT0Cv8za/gt+WiypwsliAZmWEVk5WS2?=
 =?us-ascii?Q?KIaJd0MQ59PD21k7/Kjyuf7Xz6JqMhyXdxhWlrIBW9mPgt/VwN3/DoTYBSm6?=
 =?us-ascii?Q?Hv06a1BD5HiAMZD+3P41WkzQu3UCcgzWYYBPE0w75OxYcn382gZ1YGrkJabp?=
 =?us-ascii?Q?EwHKQuKsvZDzkWv3dyc6osLw5vkJyIwnHb8jrFCDAzfVxi0zjTuerRcI/1HF?=
 =?us-ascii?Q?dMuy/4p+v2fsC+D3PIYPz6N9EFgivmyU+3foPfXWrtTa5LlbjikFa4sgjw/p?=
 =?us-ascii?Q?M259nZXhVOWK/TPxHJ3kD+dceR8Koojq/AdrgihkbsOe5eyG1MvUY6WtXhhW?=
 =?us-ascii?Q?OCBWqJYf+Tt9sSFpne9VQDR9oItz73WyWQKFLw7ZoPw3qRSCDPCU4BSbAqTm?=
 =?us-ascii?Q?Rg8VN9HF2o3n7aKTuQC6Pv+VkAS0N+jhZUFYskdlUSoags3v7KPKkrf3C0ZD?=
 =?us-ascii?Q?r63LqTIXv3EULxqWT1dtD8EGwzo+PqMRMkgoRjtUbCEUOaSuzqIjim8TtAbr?=
 =?us-ascii?Q?uywXn/o3FSDLTa9jTq2qfaK7bOM91AmgGOohLWJzjVRwn8K7i0EoZw2wPBFH?=
 =?us-ascii?Q?LkgMxe/Bh7V9zf/6j/accwLQLktpK0RjAGEoTiTnJplT/KF0hSkOBZjtNs/v?=
 =?us-ascii?Q?8IQ9+GDLjcwbS9S4i+wF6uscUMKjbRj1FtO/hoNj3xl9oSS0acMwzOXGI0HN?=
 =?us-ascii?Q?dKK09zpTSsOKpcQjViF3a28hWNxepxS/2UB6eHI8aPqgHVWY7elZhFyN8QAj?=
 =?us-ascii?Q?ikD62UlUu/gCUmXW7ixDOQdG1IQIBl4Q5YjiNnuCcmfIYJzS/gEodIkHQPdD?=
 =?us-ascii?Q?LcP1izTHcuDZRaDeNfMV8eInVzGu6bmUWTsjLsdvHSOyJQsbXs6xJzR2J2/3?=
 =?us-ascii?Q?z3qIhisttlGg07Z4GQBL81jQEIW2GfYn2CLyBYjVdyTyDMxIYXD00cnWYoB4?=
 =?us-ascii?Q?gUoe5WJdLNzhETEP3LMJXdB8c9qfMWe7XX/zkswHXMkkCzkA+7aOQ6w1FqcL?=
 =?us-ascii?Q?IUWPzrAANMRKOHHgh4eudYhyCklfWhgbJMmbdTPy2+HLaiW5fexBnS2VMzTW?=
 =?us-ascii?Q?5GENpQUgTH4YNV57KSATAtz0RDQjLc9WsYCFad+J4heSICr9d5ea6blS8/fQ?=
 =?us-ascii?Q?9y+k1g2zQes9qMsYTzD4afxNXUfAptAdcvvqD2qVL4jXi/S0H07kGYCtItSe?=
 =?us-ascii?Q?61Q463cMyh3exkBjP7179XuiNDo7ff3MqIgx5P+QwFxbf0EDoSNZJgccrRLo?=
 =?us-ascii?Q?2w0hD/D3VaPrNGwEgcAicnggRPkL67EnnAdI1qtoamgrT9qsSHi21JhUP0AN?=
 =?us-ascii?Q?rIxwxqGqRNq1yVmoH6TmAo/Q8/f9KHv9FDxir46SMOzB27fVYedmS9KipROf?=
 =?us-ascii?Q?+PMjpCRguGU2DMX9aPnfQEW407yP3mL98IZvc0bGY3z19dQxS0w64A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5Vnn0nPhvO2Km4M6PM3K5kjHPHi1fzGxYzj+RH0hf1KZvqCVJCGBnLIxUwL?=
 =?us-ascii?Q?1BSnF8vIniSTcOeKra7w/Q8OScpVV6TtlQ9NN7jSOPAAK5i03fQXcXE9WeHV?=
 =?us-ascii?Q?yte/dQ1LmuazOPtoXcQtx75X6swYOwwWpjSDSXQq/Ig7B8XvLuTqzGNzpytT?=
 =?us-ascii?Q?H8Xu1HUT4PGLZwM6OhAWaqSZ7N4YQbq4X/GsYfcTcMExcgSy03qu1S+pifwD?=
 =?us-ascii?Q?ntdHED+Y4r6Ya5NejHxfGZfgb4VoVt/jX+U5UoRumCu8pEi3+jVnkYrKvsJO?=
 =?us-ascii?Q?MpeaGsbl8xSU+iYANRLBCTABLgige9s6UBdpLKwhi5XbmmLwjN8MVxGog/gZ?=
 =?us-ascii?Q?kp7F+kAYo9g/SYV64d8fwk+1wsCSnn6CPCmi/Hm18vXOYT7YizqJT5dmZZbM?=
 =?us-ascii?Q?7ZsH4iS9zh2fFkrkWF7DBOvgbRnBvxZJfLp5Z6kwRsCXh+oLpMgEBpAKALU0?=
 =?us-ascii?Q?g3ABUqDKAQf1E8Y5KJlMYsiBjUOVUysWGwbVbTzjVPePLSBQFMFC9hGoRFAm?=
 =?us-ascii?Q?Z4PiScje1cN/z9Rwg/vTsE5yYHidkl0k6V2nAYR3BdyKwLkJGgXk49tCNEQq?=
 =?us-ascii?Q?o+T75jBGua8WXjZCtqMTnM1xYUsktAh5np73TSezwnmx0tQHrP0ts9RlsU7A?=
 =?us-ascii?Q?mEQ+5GfwWvLnmJrjzzOCKqwXq0gbcdHKPIyY+Lm6df9Dn6fQsY2mZ2nlRggf?=
 =?us-ascii?Q?4o7xWl3iN27TsZyqx2HdE2viA7Ia1n3ps/rARpHp5mL/w6RtrZZNGO/RCYks?=
 =?us-ascii?Q?RAIS0xojUogpeOxfKMlxfGTpsysubK+g2cUR5z1nEemy9zwm8Gncui+aZK9H?=
 =?us-ascii?Q?5N12LvlSRZ518+zkkE4MPrYnmn8ZDzP80qdny/Eqnsf5w7OahM+0WhpOXhlf?=
 =?us-ascii?Q?1P6/B7Xzshah4pf21JyCBuKFXFSyhX7+l/5zb7uaV/3SZhirGrsIi4TlC3E0?=
 =?us-ascii?Q?uISWuIxQmZuxYn1Jnb0nhF0k9W0QJ2qNMlIHhyZ3dJVmCg72e0wxch7jXPzy?=
 =?us-ascii?Q?TT/5RzI4fMSn954GwElcKfZNa2TeT16kDKyIlRVhp2IxxytB9J9X6cqmLzXZ?=
 =?us-ascii?Q?NFKXTInMtlyavS39rXIkSqGA6+lcHkcms+DuJWRLdc3ZzfcH8MTHGjYWdZae?=
 =?us-ascii?Q?4QqdjlrWDuCXrMwuLTwD1d8VgZbTyH4BQtp9x/lzfli4QSAJrnMXIW/smzbG?=
 =?us-ascii?Q?e18ni91ixfRhscuq84pbRZPNPXBZ2DTxHDUz/aktwv+s2AtfvbCDvqvsdMVU?=
 =?us-ascii?Q?6ypguMIjedcCs3mHS8eJKZlYK2fK/asd4TmL+Z/okA7+YkNg2zaFFXbhEEZB?=
 =?us-ascii?Q?Xnu3+0tkNs43trqv2xq4hDmNRskPE0I7lsKu2zdMBkcxDSSMiU/3NDWMCXCX?=
 =?us-ascii?Q?eNihBvknfI91efc0iYfQRt+aPkLp4L8XYh3ePMEJi/tGGrUD4ZXWtJP4d7QU?=
 =?us-ascii?Q?qavLMIBGmCt2rKqrfXek9uCbmHyeK1IVNour+agNOzA2rq2Q8HumT9xR7vQ+?=
 =?us-ascii?Q?tFPUzvDOnkRloz/aRGUxSzeOYYNNVsVQB5iVCeN3LPdTBU9dKfsGZ2JlN3fz?=
 =?us-ascii?Q?mHg34FhqE5ORk8qSqXl/RPjLgUlT5fPRAOYuGYLT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e82c337-c1a8-48ba-78b2-08dd5ce55ae1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:30:30.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aRrnU7EtRL3gPTN6M2h2iTd3sgGkR0wYzrS/0qAw6y3vRN78YGd7FlhI2Z4afkO55Ei/k8j1aIDG6giuwijug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652

From: Joy Zou <joy.zou@nxp.com>

Add rtc0 alias to set bbnsm_rtc as the default rtc.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 56766fdb0b1e5..7d9aa15ebf5d0 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -34,6 +34,7 @@ aliases {
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
+		rtc0 = &bbnsm_rtc;
 		serial0 = &lpuart1;
 		serial1 = &lpuart2;
 		serial2 = &lpuart3;
-- 
2.34.1


