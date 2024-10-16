Return-Path: <linux-kernel+bounces-368417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206729A0F92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258121C22C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF256210196;
	Wed, 16 Oct 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rk/dDmWv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A0210192;
	Wed, 16 Oct 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095818; cv=fail; b=tq6uzigth6Q1JYu4kXDWV2XAoiue9wr9cbehB+Gf/uHmJuhc2ZOZWNTCmdHgI62vv9MlKC6gSPgF5186tUEuhm5XawMdeMetf3x279P3zPw+lNyEPV2BQNskfMI6LLsWtTwk5jU3N6OgROVbwndJwBuxwOGweAzJR8F7Cq+nwJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095818; c=relaxed/simple;
	bh=8bCTvi7AgU4MQ5HET0AOHmcMvn388Mh4NN86zRFZhtg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C4MW4mmal3BNcbddktl5hSD4eay5HR2tQj93vGavo5JXlCYNmKg/QOQt7lvA0ER3XgmRv2rHeV3MU11RUyvb5AVH0aFUxa0zP810lH0pfdY3I6tub/eeu3Dl0j3z7Y9m1T/yk7c/wyuk6J9YXRsPILW16mbQ9bUSG5m7yd3WOVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rk/dDmWv; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDPmnsi9GjVdp4Yo95AQkuZ8pDxnC6sECJ0mTrUtQqQEGoUx0AIRk+xJsSE76dzarlYJsgTboaOtqit/TXU6bP4G4w2TvVteTED223s1/yOUTtpSbj4jyDAgfws5WqsAn5v90QtcjHe5K0b9GZVMYCyclv4VzoNnWLqpbZvc//0zYQV3ognz5OBZ53D44ax9rkttsUbHV8eTGQBQoKjFfg2y5PjiHro8PDbJMtj+LF+VwG3ggQVUE5vrtuk4YNR1MIe7OzIlfxdtu/gN51Ixw4wKHOywNMxTGjjJnFYiBXdTeUmLPgZgDq8kIq32lKTWC5gpxhD14SDm7fEMNmwtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZoRgTn45yJn+Pnp3LFTUwhkGYSMYn5cLf7fH4YbYkY=;
 b=AtHPWe7cQRmHoRYQdeFBZGJ64i3l1IaYwSMMu+t/MVcjU02F2bZ2Sttr5RHQ1+uSpMpg2ozil5sWEjBltHRSraIgKHlCb411TsUr9hQGxlO/PnG4Ow2xRup4lN5RFf1Dh8QuoY4ApZTyqUEwCMv0VhJxvEg3lIeo687RwG5P2dGPuLuNk5XZizhqla5PITVEGEgNQLnimlY3Jgw89QEKBehWvS5pHAXslRiuDHQx7Np1u9PjfHoyTZiZBt0mDgCgZ9L2vv+/QggyjBj9n3vPg6suQxyCRJSPMpmO5p98vaeA+HS7aEPFA1riDPMTEVaswCoSF65M0wj438GxZ7Tbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZoRgTn45yJn+Pnp3LFTUwhkGYSMYn5cLf7fH4YbYkY=;
 b=Rk/dDmWvLKGalem5ujNroyOSzeD07wMucU0zYnN/aBC45/VGKgZURRz0NB0mnzr+MvAaGZafLOfd5ja9/sIz9jB03EiGCuhMkp72owx9nWVN8VQ2madzjbrcf8eUbfKPy37i2PCyKdfVsTjXx0WmxLtKzlFvYJkdH0WwHsmEL7QH8pJcnYJ+XfUAPCwEWWckSr/GgWzMTQTKuIM0M/GPS0MUlxIl9EL/RIYIrXzhXV+gR8Susin1Z1MXtmwSWosHsTCUJHkX5MTz0JCPd0spAg6lsiOkpbZf7wFo66S/BonbDATAYRHuQKg/JRDbAFo65JZGAfER3Nptk8UBOJtCkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:23:32 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:32 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 16 Oct 2024 21:48:59 +0530
Subject: [PATCH v9 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx-se-if-v9-2-fd8fa0c04eab@nxp.com>
References: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
In-Reply-To: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=3191;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=8bCTvi7AgU4MQ5HET0AOHmcMvn388Mh4NN86zRFZhtg=;
 b=6jC393S6RTAMwrZrDut6I/99L4XpU1HiFdM6iGMaf9iDR2yaItkhSl4u5A7LoIIKDQkibXjFC
 D26TkIbWs9lDQSVJM8oHhBtnX4JYcKZi3YMX5bhzp+Wc4t7kyKiXHLs
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e7f804-8431-41d9-d148-08dcedfee043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG8ydThUR0ttY05rVWcwbEFXc2VSRU9uUGpNQVNTNkVqSnZkc2toY241bkYv?=
 =?utf-8?B?TnN0Q2NYUGZGTmNNUTBBRzVVVVpoVmV0Tks1WVd1YnJDaGFCN2dLSHJWU3dV?=
 =?utf-8?B?dy9yQVNQMmYxUnl6WHZRalo4UjZlczlWUTBGTlduZjdzM3Q5emUvOCtiTkZ2?=
 =?utf-8?B?OXFTMDg1bjd0Y1BJM1pGSzlQTjFZcVg3K3g2bk9BbWxHbU9sd2NPMi9WeUNG?=
 =?utf-8?B?TUxDNTNSUnZjaHRxOUJmNXpJT3lsTG1iMGJJUENUdHZISFNOMElPMGt3SkhX?=
 =?utf-8?B?YmpPWEZYOTRrTnlKYXF5T2pYYWIvWHo5VU1uVlVaOVdNb1hsdzdlZjJmRkJa?=
 =?utf-8?B?a2tXU2o1ekZPU0M5ZGg0eDFLbEx3akN3eHBiNlZzQ3hiQ3d0ajFoSEt5RkxL?=
 =?utf-8?B?QytseEdHTzhLK2o4VmdaZDZueGJKclZGMmVnUjUvU3RDUmVKWVluWXBpT2dx?=
 =?utf-8?B?M2hDTzRIQ2k2Zk5uemNURWx4NFlqZkxVdUE4YUw3aVYrcnVqMTB4NkdFR3pY?=
 =?utf-8?B?YjJ5YzgrQ1lmbStmRzM4aHU5M3FuanhjaXRYOFRJVGFaN2VSeE12eHprS0RH?=
 =?utf-8?B?dmxqUE95YzNHSTRXa0tYTlcxT1I4dFFFMmYrMWlVeUx5SnZIWm1MMnNCclVE?=
 =?utf-8?B?aDNVcG55TWZvOVY0MEV3bzRLMEYzNGRmN3V0MHkxMWFKWUFIWUVZQi9mVDUw?=
 =?utf-8?B?UmNQQTdGem9yWlNZbnNCK0xJUHlpYWlGS0VxOGJOS2lPaVREVElnWXE4Ulkx?=
 =?utf-8?B?L0hBRTJxSitxa1lVMThVSC93RlhsR2pWZWE4RmN1enhsT3JFUXNob2FKZUNu?=
 =?utf-8?B?ZUpQQ0p3bjQ4Skk3c1FyRGFYRzRGMjhPZGdjbDZMOVVTUTgwZHFrbkpqZmwx?=
 =?utf-8?B?N0syVTFZQzRQczVmNXhJb2hGYnk3OXJ2RFV6MnR2dThVcFE2R3g0SFRvdUJO?=
 =?utf-8?B?TnVyVThOeG1OZjR1Vmg4QzlKSzhxQXpKU2hmNE40Vll3S0ZQNUg2RzgxbDBT?=
 =?utf-8?B?SjF6SXh0dytCcGRSWXhmTUM3VEl3dkpqT0tvRlZVVXYydEVkTTdCWTk5YjRo?=
 =?utf-8?B?WU5mdllYK1NtVUV2R3Nqek5uTnpZRDNEVklnVU9mSm9xSGx4NTB1bW1sUUNG?=
 =?utf-8?B?NW9JVmdKVjVKakdoRXBDdlM3ZkRuVDdvb0R6dnNMcFdtbEpWb1R5ZnhUMUpL?=
 =?utf-8?B?S2Npdis4U1dNcVMrMEdva2xpdGZZOUlpZm5Yd1l0bzl4TU1aRWVTUktOb1or?=
 =?utf-8?B?SlNVUUZiZ0tmOTJuN3NWWDZxMzFoOVJJZ0QvYXdZQWFJeUtlMUVNcTN0N3ly?=
 =?utf-8?B?MHAwQVJTY3U2UzE1dnd5V1lvcDRvQjFlclJhQnc4L1ZrbGtlZmdLcjhDZVRp?=
 =?utf-8?B?cGpvNUZTUkxQc3dzUFkrWnQrRGtBczUwKzZTR2xadTFBcmEwSUpjNHFpTHZW?=
 =?utf-8?B?dU9Nd3VOaFVtV1dxUjcrMWJ2NjVBTWluYVdCdWdoYzhUdTkxTm9iT0s0YnF2?=
 =?utf-8?B?MERmeXJ6RkVkdE9UVnZERUE2VWtXdWx3SXdHT2twK0JrNEpoOTNGazRGWUJS?=
 =?utf-8?B?d0s5NjR0dWJwR2ZMOTV2QTVQNDdHYk1SWEh6ZmIwLzFFVkdkT3QzeVZqTjJo?=
 =?utf-8?B?RktheENaaGpsMFdtbENHUGViQkkreVQ2MjdwMW42NEdCSjJrTnJXeE0vcW40?=
 =?utf-8?B?anBaY1VSNVBiNml6Qy84K2x1VGNwUU5mSTc5ZUpKcG5SMDg4NFIwc3B3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L09OR1djcVg5d2RWRWQ5U0RKTzZnY0RUV0cxdUlVRU5rL1hZTEVyV2NsRXhY?=
 =?utf-8?B?Z29KQ2hNM3pZUEovL2NpaTNEOUgwcXRjU0hZZzJPQllKYzBlVzFpa251SjVN?=
 =?utf-8?B?ZVp6VS9ZbjAvQTgyVkRWc1lBN0NkUTAxbUM3NmxrMm5VeTZtSFBmamh2T2th?=
 =?utf-8?B?M3YwdUppNDdaR3E4ek4xeVNyc0JqSDBBdm5LdWtGOWJiK29OeEl3dFVZK2p1?=
 =?utf-8?B?SU05SlRranBuZ1A5cGVsT2pGVzU0UjJaQWErT2YvOHQ0emZGU0JNSk81R3kw?=
 =?utf-8?B?b2xGQWRUOWVGS1ZyNFhkZ0JNWWk1TXlvT240cE5KY0E0ZFFXVSt2V3V1S2tD?=
 =?utf-8?B?SDdVbU5hajFtVy9GWVI5YVFOSUJ5YXRhczdZM3htbDJtKytJdTM3blB5bnQ1?=
 =?utf-8?B?RzFmOGVxdllObnBXWVNNcWpGK3ZEanNxM1lUMERJeWRjcUZUWDBsV0F5cnMw?=
 =?utf-8?B?Rkhkam5sd0VjRmV4YWNMYXE1MlRISjU2clBhSDgzSGt3aHNNQ2Evb1F4K0Va?=
 =?utf-8?B?SjZMeWMxenREamtzaTNnUy9FWlJ4WFE4RjRJQ2VoeUlLQTRtSCtCbXM1dzAz?=
 =?utf-8?B?blBJNldSUzBwSWpOdE9pcjl3U2g5a2dvdWNWVXZuQmtHV0I3cHdLK1U2M25y?=
 =?utf-8?B?Q3VhVEdWQ3BEVDkwbEZUa3NLNTNPMkxnTW5hNXRmelNKbEpobExlOVN6NWRW?=
 =?utf-8?B?M25ZMzFLVHFWclR6T292bzlpeWVqdENCTWxiZkxYR1lGd2Jsb1Z5djNHTHg2?=
 =?utf-8?B?RS94Q3kzSG51RFhmRGVFUnVtQ2Q2QUhUYzdGbTd0K2tZeUZ1clZYN2VlQ2Ju?=
 =?utf-8?B?NmRvUENKMWVOS0VuWVZmUFhKNXRObk5aZlNJY2tDK1lZTy9NUmIrSWthaVNz?=
 =?utf-8?B?ZGJUNUZMdTFJUU14b1FCTElNbldEaU5Land4eTk3YSt0c0h0TUhMZkI4NnA1?=
 =?utf-8?B?T3c3aWdlanlCNE1KU1p3MVpTUlByZWtzaUxmQkhYLzR2UzM3TnZieDFlOTAr?=
 =?utf-8?B?eXRpWkpqc3BqVWFkb1pVQXd2TTJ4Z2t5RDA5ck9YWS81ZzFBNjVUR1VDUlAv?=
 =?utf-8?B?UUlIT2haT0NBTVh0UjlvZEpnRTJmMlJYRmNaMUNEbUlkcnpha1BCTmJYd09P?=
 =?utf-8?B?UGFsaldOekNQL3hQYThrVmxoblM5eVhVUm1YYVZtQWJTbHB5Vy9wQlRzVnI0?=
 =?utf-8?B?VE1lRCtxTmU3R0VqSEFGRnJEdERCVHYzUEVHaVpUSmFjWkxaeDBRejYrK1F5?=
 =?utf-8?B?VUQ2SlZ2ZG1IeFdoakQ3aVJ0U1o5MXB1N3B1VzBNTXBZSHZDaUFJM2QxazNQ?=
 =?utf-8?B?SFRaWFlRTU15bmZvZTBES0duQTIxdTkrVy8zdUZPWmpDeDc1RWRRL3FOaGRv?=
 =?utf-8?B?ZTB2Z3gxWmRkV09lRm5YUEVmYlBkZHVlMVRPOEFLNFVqRjFoeXRqT01jQ3lu?=
 =?utf-8?B?cTNiZzErMnBWODhJWnpzd01LMGNoVjVuNXY3bUZqMnZ4eUVyRHhlMVIvVGpT?=
 =?utf-8?B?MmoxZHE5TWttdllONzBlSUFsYVZudEt0TUpnaEEvSUg0cGllMndGUWEyVm44?=
 =?utf-8?B?aStab24zUmMza1AyMHdhK2Z1K1B6dWtxb3dyMUpUQVBiZVZmUWVqQytIcEtr?=
 =?utf-8?B?a0NHOG9LdWNiaCtBZzNLYkp3YXRZS0xSZDlEUVJzNnZNM2hNY0Y3QUJFVzFt?=
 =?utf-8?B?N2NyNGZaN2VlZUlDc3BUVzhlSDZVUU5Ed2RSMWNBWm43cVA4Zi9ibElGQU0y?=
 =?utf-8?B?b081OGVwaDVxdEF6S1g3MjlWKy9mL3psMG1SR20xbXVBTGc0dkorNkEvcVBF?=
 =?utf-8?B?RTRTQjByN0YyV2NZMDZ3OEdmOGNPU2NwOGhyeGtab2huVGxsZWVWRHpRcTJy?=
 =?utf-8?B?dWZhNEh6VkhuT0ptcTNpNDNGam1LQUt6MW5taXJyTy9tNHdCSi9Ra0JOY3Yy?=
 =?utf-8?B?WkRkZlhTSDQycUhqU3dTeHR1dXlkRmJlQS9vWFVSaHRnUHhwUVN6Z1NlaGt1?=
 =?utf-8?B?ZmZWSXVTWWI5SThZL1RBR1AyZ200VWcwa21PUklBVm4wRXhDdnY0bXFONTh2?=
 =?utf-8?B?bXpvbUpyUkhBZEhHbHJTOFd0UEJ2aXFYSmFnZzZLVERJSW9tTmRDdzNwSW5o?=
 =?utf-8?Q?Eg7jcMe5kMG7yKSlo0TP+zpsE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e7f804-8431-41d9-d148-08dcedfee043
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:32.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoFPoc6nBt72emmSF7MIUTa/GQK2Tl6+TuONCrJJgqfH+gMkSpppqHad+kRDmMZAgf7MgdO2MYky4auS67YYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Conor Dooley <conor@kernel.org>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..0b617f61640f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.34.1


