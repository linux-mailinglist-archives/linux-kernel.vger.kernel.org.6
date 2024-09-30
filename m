Return-Path: <linux-kernel+bounces-343281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25AF989916
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4103D283346
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B568489;
	Mon, 30 Sep 2024 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YeYO8Qwq"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021127.outbound.protection.outlook.com [52.101.129.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697B383;
	Mon, 30 Sep 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661893; cv=fail; b=hzFHsoA9kvUu79Ik+D5OQUcf4DNsAP/kuhi1GABx2O0GL2ooYryheA0OyhZ72q7WVpUGLknh+wp8m/wyPuyFzh8IP+FDmLpdd10LNmIKM70Kr0+2smLNlWuYfjIxm3nkDz/lqIdMm7u4z+JfCp1g1pBhxmd6pu68g99GutkC720=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661893; c=relaxed/simple;
	bh=Q+ityNVriyg1NihyEYLRwlH4qAhauIN1Um+8pXe7Hys=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHdUJbXaJRcCrdvaGOwns33AG2C7UEa+uvQMW+LfBswgEicJ357yl4zDz5eOqzu/e5FQGCbZsnxzi8ShXwga566th86TUy7vdSPHeNAu7EMm5hJqQAHXbmYpQXIfy2+EX7vTiF7sIyChNAX5RZyZolj3c+X3Z5L1RNENOLBfzsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YeYO8Qwq; arc=fail smtp.client-ip=52.101.129.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+7AtRfI4BLyv/S6LDDI33Od6XP43E7KJcXAHspjmGt0Wc2/6ZVA+GQDC39ARraD3+OVzhq+vWsgfM1O+4p/KFwvDtl2gwyLQzzlT1Q0esLXpIhjtb05cxXIa92SeXaDYYuELFFGDtIDfVmMHJB2kuIw+QueH4xuixbeUpDWknEDVHmxaeaEGRrKfTO60Scj/x0fkwi/rr08UBN3ues4tlb3fWZv4mAoQlhuURNV0ivfuTV0FS1Lx9OYoGYEP3/8LOL+FmfivBng6pPnB0ra3senIDlDhXCBWqllm/uKO3c26MLlYLRwVgMipPEVmvKISFLT+CzUfg4NUMRZuwkhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVbdhpwUQr90aIme69GmGjCojmEpLntxUkSznmloLZA=;
 b=OPcD2jbJipIsQVESsmaQnsw6ESyoQc4ME1Dwf8umStGdyMFVw5wW3bx62dpJIpYcY7IbUg2bbtWcSrBZp903Os1bslByVEHf+2rSY8B6AVRvAVLtC/FwNEN3a0lY7cCcyMtW8g9myKwPRv34Cimyn8r0iuc/mhkQcIyNiCUBYLA+jaW6SQAlN2+5HSEr1aVz5gT8j5prRiXBpXx/gQwDpbH4wnCnkpAjAej9XhnJjerc9XxELfOH/ctd4dznfyte4HIB9ChuoXepsanVsG03kOIqYQpCmLt4qAljIucGmiu5/zLIiuOwgmH7KoInuBkDQ3Uo2vSNd/hI0KHvdsSZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVbdhpwUQr90aIme69GmGjCojmEpLntxUkSznmloLZA=;
 b=YeYO8QwqFMCJuSlryYaliqWbihOiruz9mtsFu3tHXq+13Z2BSb0uellPjZ5RuFtbO1kUnwWzKBKfnvZPzHdOB9QQgf2CC4qrX8npKi6t1nuVB82zbzmwI3a1MDEcCQ79klgIn4WqGLTFtWs8KQyDC88Zl5mUQO2TK2kziSMAs7uOPVy6o+55UTcuu3qjKB/MRzTGYUIc2WWKYEtE1dqB8pwF6w80dBrNpunmb89MuyJcSJYNpmN0k5LPUiAjS6pvO1fevtvQ3iiPnbBEbtxZ9PQt/a4L0FiAfYPSJxOFJuWD6mR3EJrhjmhJIGJMLTThhzVBEZs1Mkkjmrot0q5PdQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB7186.apcprd06.prod.outlook.com (2603:1096:101:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Mon, 30 Sep
 2024 02:04:39 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 02:04:39 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v4 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Topic: [PATCH v4 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Index: AQHbDY1BFpXGaU48A0W8slmdM9Tjs7Jvnq+Q
Date: Mon, 30 Sep 2024 02:04:39 +0000
Message-ID:
 <OS8PR06MB7541ABE758EBBE61E8FB26B6F2762@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240923075012.2264573-1-ryan_chen@aspeedtech.com>
 <20240923075012.2264573-4-ryan_chen@aspeedtech.com>
In-Reply-To: <20240923075012.2264573-4-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB7186:EE_
x-ms-office365-filtering-correlation-id: f0eacac4-49ef-43b8-c5d7-08dce0f43dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vDuYszlIo49Zco5WQPCY1VdKmDIJ4Mw7n6NmWhFqjCdlKzBfW4RvldnCIuuY?=
 =?us-ascii?Q?c17RZ4aRC30+HRQO1Lk36V3VPtc19Ok/VgzggPN0zjO4HBr+A+GFJ0XRE+Pk?=
 =?us-ascii?Q?0xTFgV2kh6yiMV9g1pPjc/Ow+6U1Dmb6cguIMG4X/jDWFi9HsOOu8J08rm/t?=
 =?us-ascii?Q?uemGUfxek5VK8+4/gUowBlj1JzXjH5de7jkD3h4XCOIUjukXL2zTkrTIeofj?=
 =?us-ascii?Q?ikIzvMdQop+NAq25SU7U24ONhfgYvHU3fvOQEnSJMM1/VPj8eInNNHi9RCD6?=
 =?us-ascii?Q?3gx0Au8xJhH10vFj4V1drsWY5seIhekat6KN9Tl4Xv9o4QwfGka8i/7H0kqd?=
 =?us-ascii?Q?yRy/sQJ6/BdXuN54bVyF+SoBnj+BMUCfHKNFt8Or57+e+sK67sSclYcQEL81?=
 =?us-ascii?Q?p7pyjFrzDXFQ/9uRLFzayAHsPJoaSl7e62PgDXdYCF60WNMwYgEM1WQmmziP?=
 =?us-ascii?Q?2+sqhLXjsaPytLIoGQaBtVwE2BBUlv9Rkrx5/SGjxwpdxHcWDYlqY/4+rsvT?=
 =?us-ascii?Q?vBBDkp8iVScWi+ItOjme7pq7dUeyj4Skuh2xH107OBeb2KH3RBrbEPOE2YN0?=
 =?us-ascii?Q?Dni2Sxne3JkuMN8GbtEbD1K5z1L0pZjlN/ClLowlKWjtA+ynQpatuC9X93Ae?=
 =?us-ascii?Q?i5IzQwJATOe4fkX5ezH61QKofuf3YNbWL4OlMpeeirfVDo6M/fhA9f5+phK+?=
 =?us-ascii?Q?XdYENTs4aG9nmsTH94vc5XH1O1k0oepYPIiiFVcvb7PK/GuJQEPQsCY7ifCA?=
 =?us-ascii?Q?ikfmz1uRrB1fIhs6sog9nz7EEnnmgrB0e+rKOMtSUcfbBzec9KF4eJYeIi+r?=
 =?us-ascii?Q?/itZ/oklvSTvfMV31qin/SdBiRTSpitHR6bLw8me15rY0nZMX3dsjT6Ui1j4?=
 =?us-ascii?Q?Q5FhVyopxSvU2pSy4SuK9FlRvab3F/GNJ5zO+zvUE6y47/+aHaqGlywijv+1?=
 =?us-ascii?Q?PpXVeBEYTtIdFz3tkkPddaBaOmUr3Fn9fYMHpmWMNlBW1Yk0woqqYyFZfsoT?=
 =?us-ascii?Q?I7+OR4hphiucR2AkxoSKd0mUBfHP6ee66NmnaDEwvkpMl6YtjpDQhmAlRGiC?=
 =?us-ascii?Q?xjBdGDEpPSGg5lymQHS0sntBmj+RtDtnZj9blMp3InpIGo156z6+5VMCV3lz?=
 =?us-ascii?Q?gVyMvWCysJkRAwMQ0NZtbqdRqgHkBciJVEkrzLFiIxQuQFT7cqWj7mqG2aSg?=
 =?us-ascii?Q?Pf2HEpimil097jc/hsJUBVXclMt4gw6Gipdf5fc0xMQD1W+Jj0u2/snSGReJ?=
 =?us-ascii?Q?YxY0I1pDMDpWBwctqw8u8L7j5OoNqQD7Pc2BgnmR17Sjq+6e+eBS1eneXGnC?=
 =?us-ascii?Q?BFHBgNwf9yPT+HMYfi+JIZU0mOi91e+y5NGKygPqbXJWQ9MNf2vn/wwIfcuc?=
 =?us-ascii?Q?oiOSxqUw4KzSNnBRmiEi4jw8fIPhF/YEBixwJDeYBAK9XFG39BFi8oEEKTcr?=
 =?us-ascii?Q?Vb1pScWnRbg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3gjTx49qR/YrKm245N4vRYyxyl65vqr1EX/9Xj4EjBsjixs7dbL45GrI48SM?=
 =?us-ascii?Q?X9e0AjGykuqN9KjgVdb6tS/R+tS0NDDl90cBQ4mGfjQWpA3hPsV6BAYV+/YL?=
 =?us-ascii?Q?L5OtbUcUlY+5wMbALClWZUsFIxbqf14vA66vFNpilLTrZL63jn3A3ls2T8rL?=
 =?us-ascii?Q?Jk5Fphyav7yjL4X89r4RPbTl/bUuXic8RkJFNp/6yf0cJGSpGUlfAIDrPJIH?=
 =?us-ascii?Q?uCEKcOLT/MBK3SgrrKJshZ4ywMPTtEhqFsdaUAbbbbecYhslT6meduCwXVxA?=
 =?us-ascii?Q?bmYq3WhaHoT7NDadQzyAf4+bEQVp7N7Sh+Z5oQ0JYxTo/8/+0scMdwTTHAsb?=
 =?us-ascii?Q?d1JPuXNScCaWc5z3mW7Zc4CtKQnDHAVqcfheTSbvvmGZFR6hIbJhn0NCGECI?=
 =?us-ascii?Q?IJ5PpI8tNLvJ4sgBquMWEyuk40Yst3c9kGo/g1sRjQPnKOP5tbDwxG/0l2Kz?=
 =?us-ascii?Q?cGg0knG3ETIsK2hNcShGi2yz6HUC2MIXKtTBcUAMxw0/gaxYFTiA/CNk/ltq?=
 =?us-ascii?Q?F2YaOZnXtOWXhvXcvSWmFlTGhH5eBA+y8KztiZawmhK5mT4j7OHvk7evE8zi?=
 =?us-ascii?Q?YbaaoYyUnlQrXHaadgKjNWOGsVvxdQw0MFZaAC0L8XfUxPW3v9NEqWpruLXf?=
 =?us-ascii?Q?Hp3pnTQMKRGtl0yDEEyOBvA3vaMgje6yEZE8UD/tXoowgje3LUqOZtiN+jx7?=
 =?us-ascii?Q?P7JR8V7rBop8HsuThYmi4EJqk3lmc77D/yZN4Us9XPshuT/8/8icoWvcQXXN?=
 =?us-ascii?Q?zJtnZ0gY67kABPxar66zEc+sSOZ5vdIeLDGL89dPI60XkvRCRUESA99U0277?=
 =?us-ascii?Q?F5Fc4VSsFbp0915FgYGy7ozayP5Kefj0ako09kjRPv+lYY6EtrwV+JLUDg6c?=
 =?us-ascii?Q?JTfp0i1C+cuVW5xP1eNmPWuA3qqpSBENuxCRuww8o47vkSf3W3bZ/dIimOCk?=
 =?us-ascii?Q?7rvTVsSUM8Ta65TGJuYQ7P3+kWNhGonjo/rPleQHvCKiFCO4IUNhUJSRI5W2?=
 =?us-ascii?Q?Ca26I6mhVoxGy6UXd2RnRHwcCskUn2gqsks0Rr0OgmhkqYE/jRsC5fA7W0ca?=
 =?us-ascii?Q?xJAhqqh9ZruoLPk+xC80eeCenlb7QD+280iXmxPXRKgvr5TDY1c2bHwPOn9o?=
 =?us-ascii?Q?M2KN2aE1gz607HJrP6Tltd4XtCcqesNj+uJJQp8UtlZ0fgeWMF7kovSXIHan?=
 =?us-ascii?Q?pnyBIYfIxN612eUVyHIlx/Vmu3vYV16NhUF7Ye7AseaEAVn71C2etnF6sYBH?=
 =?us-ascii?Q?foxV1+MMtpJD0O5WoX+82ZgMNU6uQt3f1qIHo6s5J4Rn8rQXl8xM2exqKsne?=
 =?us-ascii?Q?5EovH/R4D3YvAs7CunnVwjhEqr/PA53Lu7eEsydmjpyPb22z/5reDFnjlaul?=
 =?us-ascii?Q?WHlOxJHaSEULbjGtRcL+sh0TxKOL0AfV1s7O92aCpNmFSYgThMoPUP5GTLXw?=
 =?us-ascii?Q?0Rn+JWUV5h2C4IcfiYIy3n01WM5EtA27zsHg2KeQQlOytPrHN6w7gjiaD8yU?=
 =?us-ascii?Q?sZhE+fO96m96JsRZKqqLzGvJciSPteMO3OiFhmPrbg1LYvQqKWNbbsoFJZFv?=
 =?us-ascii?Q?3qYAmFVYKIrsQzswZLMnph/bLbb3vOj0grzp55Lz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eacac4-49ef-43b8-c5d7-08dce0f43dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 02:04:39.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93GKLS86H4ZjrMqNn5osBJ5Pljm6akdkOG6nQMT5xGeu2QhqoAj+fcqxVXoYC+s2bzQa21ZvdyMALe0loYRqqt+mCu6gEFj7jJOlk3ey2SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7186

Hello Stephen,
	Sorry, do you have chance review my v4 modification?

> Subject: [PATCH v4 3/3] clk: aspeed: add AST2700 clock driver.
>=20
> Add AST2700 clock controller driver and also use axiliary device framewor=
k
> register the reset controller driver.
> Due to clock and reset using the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/Kconfig       |    8 +
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-ast2700.c | 1553
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1562 insertions(+)
>  create mode 100644 drivers/clk/clk-ast2700.c
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> 983ef4f36d8c..4cc35ecba1c0 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -269,6 +269,14 @@ config COMMON_CLK_ASPEED
>  	  The G4 and G5 series, including the ast2400 and ast2500, are
> supported
>  	  by this driver.
>=20
> +config COMMON_CLK_AST2700
> +	bool "Clock driver for AST2700 SoC"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	help
> +	  This driver provides support for clock on AST2700 SoC.
> +	  The driver is responsible for managing the various clocks required
> +	  by the peripherals and cores within the AST2700.
> +
>  config COMMON_CLK_S2MPS11
>  	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
>  	depends on MFD_SEC_CORE || COMPILE_TEST diff --git
> a/drivers/clk/Makefile b/drivers/clk/Makefile index
> f793a16cad40..fe95203c3138 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+=3D clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+=3D clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+=3D clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+=3D clk-ast2600.o
> +obj-$(CONFIG_COMMON_CLK_AST2700)	+=3D clk-ast2700.o
>  obj-$(CONFIG_ARCH_HIGHBANK)		+=3D clk-highbank.o
>  obj-$(CONFIG_CLK_HSDK)			+=3D clk-hsdk-pll.o
>  obj-$(CONFIG_COMMON_CLK_K210)		+=3D clk-k210.o
> diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new fi=
le mode
> 100644 index 000000000000..933b5232d7c1
> --- /dev/null
> +++ b/drivers/clk/clk-ast2700.c
> @@ -0,0 +1,1553 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +
> +#define SCU_CLK_12MHZ 12000000
> +#define SCU_CLK_24MHZ 24000000
> +#define SCU_CLK_25MHZ 25000000
> +#define SCU_CLK_192MHZ 192000000
> +
> +/* SOC0 */
> +#define SCU0_HWSTRAP1 0x010
> +#define SCU0_CLK_STOP 0x240
> +#define SCU0_CLK_SEL1 0x280
> +#define SCU0_CLK_SEL2 0x284
> +#define GET_USB_REFCLK_DIV(x) ((GENMASK(23, 20) & (x)) >> 20) #define
> +UART_DIV13_EN BIT(30) #define SCU0_HPLL_PARAM 0x300 #define
> +SCU0_DPLL_PARAM 0x308 #define SCU0_MPLL_PARAM 0x310 #define
> +SCU0_D0CLK_PARAM 0x320 #define SCU0_D1CLK_PARAM 0x330 #define
> +SCU0_CRT0CLK_PARAM 0x340 #define SCU0_CRT1CLK_PARAM 0x350
> #define
> +SCU0_MPHYCLK_PARAM 0x360
> +
> +/* SOC1 */
> +#define SCU1_REVISION_ID 0x0
> +#define REVISION_ID GENMASK(23, 16)
> +#define SCU1_CLK_STOP 0x240
> +#define SCU1_CLK_STOP2 0x260
> +#define SCU1_CLK_SEL1 0x280
> +#define SCU1_CLK_SEL2 0x284
> +#define UXCLK_MASK GENMASK(1, 0)
> +#define HUXCLK_MASK GENMASK(4, 3)
> +#define SCU1_HPLL_PARAM 0x300
> +#define SCU1_APLL_PARAM 0x310
> +#define SCU1_DPLL_PARAM 0x320
> +#define SCU1_UXCLK_CTRL 0x330
> +#define SCU1_HUXCLK_CTRL 0x334
> +#define SCU1_MAC12_CLK_DLY 0x390
> +#define SCU1_MAC12_CLK_DLY_100M 0x394
> +#define SCU1_MAC12_CLK_DLY_10M 0x398
> +
> +enum {
> +	CLK_MUX,
> +	CLK_PLL,
> +	CLK_GATE,
> +	CLK_MISC,
> +	CLK_FIXED,
> +	CLK_DIVIDER,
> +	CLK_UART_PLL,
> +	CLK_DIV_TABLE,
> +	CLK_FIXED_FACTOR,
> +};
> +
> +struct ast2700_clk_info {
> +	const char *name;
> +	const char * const *parent_names;
> +	const struct clk_div_table *div_table;
> +	unsigned long fixed_rate;
> +	unsigned int mult;
> +	unsigned int div;
> +	u32 reg;
> +	u32 flags;
> +	u32 type;
> +	u8 clk_idx;
> +	u8 bit_shift;
> +	u8 bit_width;
> +	u8 num_parents;
> +};
> +
> +struct ast2700_clk_data {
> +	struct ast2700_clk_info const *clk_info;
> +	unsigned int nr_clks;
> +	const int scu;
> +};
> +
> +struct ast2700_clk_ctrl {
> +	const struct ast2700_clk_data *clk_data;
> +	struct device *dev;
> +	void __iomem *base;
> +	spinlock_t lock; /* clk lock */
> +};
> +
> +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {
> +	{ 0x0, 4 },
> +	{ 0x1, 4 },
> +	{ 0x2, 6 },
> +	{ 0x3, 8 },
> +	{ 0x4, 10 },
> +	{ 0x5, 12 },
> +	{ 0x6, 14 },
> +	{ 0x7, 16 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_rmii_div_table[] =3D {
> +	{ 0x0, 8 },
> +	{ 0x1, 8 },
> +	{ 0x2, 12 },
> +	{ 0x3, 16 },
> +	{ 0x4, 20 },
> +	{ 0x5, 24 },
> +	{ 0x6, 28 },
> +	{ 0x7, 32 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_div_table[] =3D {
> +	{ 0x0, 2 },
> +	{ 0x1, 2 },
> +	{ 0x2, 3 },
> +	{ 0x3, 4 },
> +	{ 0x4, 5 },
> +	{ 0x5, 6 },
> +	{ 0x6, 7 },
> +	{ 0x7, 8 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_div_table2[] =3D {
> +	{ 0x0, 2 },
> +	{ 0x1, 4 },
> +	{ 0x2, 6 },
> +	{ 0x3, 8 },
> +	{ 0x4, 10 },
> +	{ 0x5, 12 },
> +	{ 0x6, 14 },
> +	{ 0x7, 16 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2700_clk_uart_div_table[] =3D {
> +	{ 0x0, 1 },
> +	{ 0x1, 13 },
> +	{ 0 }
> +};
> +
> +static const struct ast2700_clk_info ast2700_scu0_clk_info[] __initconst=
 =3D {
> +	[SCU0_CLKIN] =3D {
> +		.type =3D CLK_FIXED,
> +		.name =3D "soc0-clkin",
> +		.fixed_rate =3D SCU_CLK_25MHZ,
> +	},
> +	[SCU0_CLK_24M] =3D {
> +		.type =3D CLK_FIXED,
> +		.name =3D "soc0-clk24Mhz",
> +		.fixed_rate =3D SCU_CLK_24MHZ,
> +	},
> +	[SCU0_CLK_192M] =3D {
> +		.type =3D CLK_FIXED,
> +		.name =3D "soc0-clk192Mhz",
> +		.fixed_rate =3D SCU_CLK_192MHZ,
> +	},
> +	[SCU0_CLK_HPLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "soc0-hpll",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_HPLL_PARAM,
> +	},
> +	[SCU0_CLK_HPLL_DIV2] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc0-hpll_div2",
> +		.parent_names =3D (const char *[]){ "soc0-hpll", },
> +		.mult =3D 1,
> +		.div =3D 2,
> +	},
> +	[SCU0_CLK_HPLL_DIV4] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc0-hpll_div4",
> +		.parent_names =3D (const char *[]){ "soc0-hpll", },
> +		.mult =3D 1,
> +		.div =3D 4,
> +	},
> +	[SCU0_CLK_HPLL_DIV_AHB] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc0-hpll_div_ahb",
> +		.parent_names =3D (const char *[]){ "soc0-hpll", },
> +		.reg =3D SCU0_HWSTRAP1,
> +		.bit_shift =3D 5,
> +		.bit_width =3D 2,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU0_CLK_DPLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "dpll",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_DPLL_PARAM,
> +	},
> +	[SCU0_CLK_MPLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "soc0-mpll",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_MPLL_PARAM,
> +	},
> +	[SCU0_CLK_MPLL_DIV2] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc0-mpll_div2",
> +		.parent_names =3D (const char *[]){ "soc0-mpll", },
> +		.mult =3D 1,
> +		.div =3D 2,
> +	},
> +	[SCU0_CLK_MPLL_DIV4] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc0-mpll_div4",
> +		.parent_names =3D (const char *[]){ "soc0-mpll", },
> +		.mult =3D 1,
> +		.div =3D 4,
> +	},
> +	[SCU0_CLK_MPLL_DIV8] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc0-mpll_div8",
> +		.parent_names =3D (const char *[]){ "soc0-mpll", },
> +		.mult =3D 1,
> +		.div =3D 8,
> +	},
> +	[SCU0_CLK_MPLL_DIV_AHB] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc0-mpll_div_ahb",
> +		.parent_names =3D (const char *[]){ "soc0-mpll", },
> +		.reg =3D SCU0_HWSTRAP1,
> +		.bit_shift =3D 5,
> +		.bit_width =3D 2,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU0_CLK_D0] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "d0clk",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_D0CLK_PARAM,
> +	},
> +	[SCU0_CLK_D1] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "d1clk",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_D1CLK_PARAM,
> +	},
> +	[SCU0_CLK_CRT0] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "crt0clk",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_CRT0CLK_PARAM,
> +	},
> +	[SCU0_CLK_CRT1] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "crt1clk",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_CRT1CLK_PARAM,
> +	},
> +	[SCU0_CLK_MPHY] =3D {
> +		.type =3D CLK_MISC,
> +		.name =3D "mphyclk",
> +		.parent_names =3D (const char *[]){ "soc0-hpll", },
> +		.reg =3D SCU0_MPHYCLK_PARAM,
> +	},
> +	[SCU0_CLK_PSP] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "pspclk",
> +		.parent_names =3D (const char *[]){"soc0-mpll", "soc0-hpll", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU0_HWSTRAP1,
> +		.bit_shift =3D 4,
> +		.bit_width =3D 1,
> +	},
> +	[SCU0_CLK_AXI0] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "axi0clk",
> +		.parent_names =3D (const char *[]){"pspclk", },
> +		.mult =3D 1,
> +		.div =3D 2,
> +	},
> +	[SCU0_CLK_AHB] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "soc0-ahb",
> +		.parent_names =3D (const char *[]){"soc0-mpll_div_ahb",
> "soc0-hspll_div_ahb", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU0_HWSTRAP1,
> +		.bit_shift =3D 7,
> +		.bit_width =3D 1,
> +	},
> +	[SCU0_CLK_AXI1] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "axi1clk",
> +		.parent_names =3D (const char *[]){ "soc0-ahb", },
> +		.mult =3D 1,
> +		.div =3D 2,
> +	},
> +	[SCU0_CLK_APB] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc0-apb",
> +		.parent_names =3D (const char *[]){ "axi0clk", },
> +		.reg =3D SCU0_CLK_SEL1,
> +		.bit_shift =3D 23,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table2,
> +	},
> +	[SCU0_CLK_GATE_MCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mclk",
> +		.parent_names =3D (const char *[]){ "soc0-mpll", },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 0,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_ECLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "eclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 1,
> +	},
> +	[SCU0_CLK_GATE_2DCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "gclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 2,
> +	},
> +	[SCU0_CLK_GATE_VCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "vclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 3,
> +	},
> +	[SCU0_CLK_GATE_BCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "bclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 4,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_VGA0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "d1clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 5,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_REFCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc0-refclk-gate",
> +		.parent_names =3D (const char *[]){ "soc0-clkin", },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 6,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_U2PHY_REFCLK] =3D {
> +		.type =3D CLK_MISC,
> +		.name =3D "xhci_ref_clk",
> +		.parent_names =3D (const char *[]){ "soc0-mpll_div8", },
> +		.reg =3D SCU0_CLK_SEL2,
> +	},
> +	[SCU0_CLK_U2PHY_CLK12M] =3D {
> +		.type =3D CLK_FIXED,
> +		.name =3D "xhci_suspend_clk",
> +		.parent_names =3D (const char *[]){  },
> +		.fixed_rate =3D SCU_CLK_12MHZ,
> +	},
> +	[SCU0_CLK_GATE_PORTBUSB2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "portb-usb2clk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 7,
> +	},
> +	[SCU0_CLK_GATE_UHCICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uhciclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 9,
> +	},
> +	[SCU0_CLK_GATE_VGA1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "d2clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 10,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_DDRPHYCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "ddrphy-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 11,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_E2M0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "e2m0clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 12,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_HACCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "hac-clk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 13,
> +	},
> +	[SCU0_CLK_GATE_PORTAUSB2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "porta-usb2clk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 14,
> +	},
> +	[SCU0_CLK_UART] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "soc0-uartclk",
> +		.parent_names =3D (const char *[]){"soc0-clk24Mhz",
> "soc0-clk192Mhz", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU0_CLK_SEL2,
> +		.bit_shift =3D 14,
> +		.bit_width =3D 1,
> +	},
> +	[SCU0_CLK_UART4] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "uart4clk",
> +		.parent_names =3D (const char *[]){ "soc0-uartclk", },
> +		.reg =3D SCU0_CLK_SEL2,
> +		.bit_shift =3D 30,
> +		.bit_width =3D 1,
> +		.div_table =3D ast2700_clk_uart_div_table,
> +	},
> +	[SCU0_CLK_GATE_UART4CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart4clk-gate",
> +		.parent_names =3D (const char *[]){"uart4clk" },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 15,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_SLICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc0-sliclk-gate",
> +		.parent_names =3D (const char *[]){	},
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 16,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_DACCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "dacclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 17,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_DP] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "dpclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 18,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_E2M1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "e2m1clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 19,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU0_CLK_GATE_CRT0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "crt0clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 20,
> +	},
> +	[SCU0_CLK_GATE_CRT1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "crt1clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 21,
> +	},
> +	[SCU0_CLK_GATE_ECDSACLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "eccclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 23,
> +	},
> +	[SCU0_CLK_GATE_RSACLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "rsaclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 24,
> +	},
> +	[SCU0_CLK_GATE_RVAS0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "rvasclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 25,
> +	},
> +	[SCU0_CLK_GATE_UFSCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "ufsclk",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 26,
> +	},
> +	[SCU0_CLK_EMMCMUX] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "emmcsrc-mux",
> +		.parent_names =3D (const char *[]){"soc0-mpll_div4",
> "soc0-hpll_div4", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU0_CLK_SEL1,
> +		.bit_shift =3D 11,
> +		.bit_width =3D 1,
> +	},
> +	[SCU0_CLK_EMMC] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "emmcclk",
> +		.parent_names =3D (const char *[]){ "emmcsrc-mux", },
> +		.reg =3D SCU0_CLK_SEL1,
> +		.bit_shift =3D 12,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table2,
> +	},
> +	[SCU0_CLK_GATE_EMMCCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "emmcclk-gate",
> +		.parent_names =3D (const char *[]){ "emmcclk", },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 27,
> +	},
> +	[SCU0_CLK_GATE_RVAS1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "rvas2clk",
> +		.parent_names =3D (const char *[]){ "emmcclk", },
> +		.reg =3D SCU0_CLK_STOP,
> +		.clk_idx =3D 28,
> +	},
> +};
> +
> +static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initconst=
 =3D {
> +	[SCU1_CLKIN] =3D {
> +		.type =3D CLK_FIXED,
> +		.name =3D "soc1-clkin",
> +		.fixed_rate =3D SCU_CLK_25MHZ,
> +	},
> +	[SCU1_CLK_HPLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "soc1-hpll",
> +		.parent_names =3D (const char *[]){ "soc1-clkin", },
> +		.reg =3D SCU1_HPLL_PARAM,
> +	},
> +	[SCU1_CLK_APLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "soc1-apll",
> +		.parent_names =3D (const char *[]){ "soc1-clkin", },
> +		.reg =3D SCU1_APLL_PARAM,
> +	},
> +	[SCU1_CLK_APLL_DIV2] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc1-apll_div2",
> +		.parent_names =3D (const char *[]){ "soc1-apll", },
> +		.mult =3D 1,
> +		.div =3D 2,
> +	},
> +	[SCU1_CLK_APLL_DIV4] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "soc1-apll_div4",
> +		.parent_names =3D (const char *[]){ "soc1-apll", },
> +		.mult =3D 1,
> +		.div =3D 4,
> +	},
> +	[SCU1_CLK_DPLL] =3D {
> +		.type =3D CLK_PLL,
> +		.name =3D "soc1-dpll",
> +		.parent_names =3D (const char *[]){ "soc1-clkin", },
> +		.reg =3D SCU1_DPLL_PARAM,
> +	},
> +	[SCU1_CLK_UXCLK] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uxclk",
> +		.parent_names =3D (const char *[]){ "soc1-apll_div4", "soc1-apll_div2"=
,
> +						 "soc1-apll", "soc1-hpll",},
> +		.num_parents =3D 4,
> +		.reg =3D SCU1_CLK_SEL2,
> +		.bit_shift =3D 0,
> +		.bit_width =3D 2,
> +	},
> +	[SCU1_CLK_UARTX] =3D {
> +		.type =3D CLK_UART_PLL,
> +		.name =3D "uartxclk",
> +		.parent_names =3D (const char *[]){ "uxclk", },
> +		.reg =3D SCU1_UXCLK_CTRL,
> +	},
> +	[SCU1_CLK_HUXCLK] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "huxclk",
> +		.parent_names =3D (const char *[]){"soc1-apll_div4", "soc1-apll_div2",
> +						 "soc1-apll", "soc1-hpll",},
> +		.num_parents =3D 4,
> +		.reg =3D SCU1_CLK_SEL2,
> +		.bit_shift =3D 3,
> +		.bit_width =3D 2,
> +	},
> +	[SCU1_CLK_HUARTX] =3D {
> +		.type =3D CLK_UART_PLL,
> +		.name =3D "huartxclk",
> +		.parent_names =3D (const char *[]){ "huxclk", },
> +		.reg =3D SCU1_HUXCLK_CTRL,
> +	},
> +	[SCU1_CLK_AHB] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc1-ahb",
> +		.parent_names =3D (const char *[]){"soc1-hpll", },
> +		.reg =3D SCU1_CLK_SEL2,
> +		.bit_shift =3D 20,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU1_CLK_APB] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc1-apb",
> +		.parent_names =3D (const char *[]){"soc1-hpll", },
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 18,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table2,
> +	},
> +	[SCU1_CLK_RMII] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "rmii",
> +		.parent_names =3D (const char *[]){"soc1-hpll", },
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 21,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_rmii_div_table,
> +	},
> +	[SCU1_CLK_MAC0RCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mac0rclk",
> +		.parent_names =3D (const char *[]){ "rmii", },
> +		.reg =3D SCU1_MAC12_CLK_DLY,
> +		.clk_idx =3D 29,
> +	},
> +	[SCU1_CLK_MAC1RCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mac1rclk",
> +		.parent_names =3D (const char *[]){ "rmii", },
> +		.reg =3D SCU1_MAC12_CLK_DLY,
> +		.clk_idx =3D 30,
> +	},
> +	[SCU1_CLK_RGMII] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "rgmii",
> +		.parent_names =3D (const char *[]){"soc1-hpll", },
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 25,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_rgmii_div_table,
> +	},
> +	[SCU1_CLK_MACHCLK] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "machclk",
> +		.parent_names =3D (const char *[]){"soc1-hpll", },
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 29,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU1_CLK_GATE_LCLK0] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "lclk0-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 0,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_LCLK1] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "lclk1-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 1,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_ESPI0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "espi0clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 2,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_ESPI1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "espi1clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 3,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_APLL_DIVN] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "soc1-apll_divn",
> +		.parent_names =3D (const char *[]){"soc1-apll", },
> +		.reg =3D SCU1_CLK_SEL2,
> +		.bit_shift =3D 8,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU1_CLK_SDMUX] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "sdclk-mux",
> +		.parent_names =3D (const char *[]){ "soc1-hpll", "soc1-apll", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 13,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_SDCLK] =3D {
> +		.type =3D CLK_DIV_TABLE,
> +		.name =3D "sdclk",
> +		.parent_names =3D (const char *[]){"sdclk-mux", },
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 14,
> +		.bit_width =3D 3,
> +		.div_table =3D ast2700_clk_div_table,
> +	},
> +	[SCU1_CLK_GATE_SDCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "sdclk-gate",
> +		.parent_names =3D (const char *[]){"sdclk", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 4,
> +	},
> +	[SCU1_CLK_GATE_IPEREFCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc1-iperefclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 5,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_REFCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc1-refclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 6,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_LPCHCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "lpchclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 7,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_MAC0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mac0clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 8,
> +	},
> +	[SCU1_CLK_GATE_MAC1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mac1clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 9,
> +	},
> +	[SCU1_CLK_GATE_MAC2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "mac2clk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 10,
> +	},
> +	[SCU1_CLK_UART0] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart0clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 0,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart0clk-gate",
> +		.parent_names =3D (const char *[]){ "uart0clk", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 11,
> +	},
> +	[SCU1_CLK_UART1] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart1clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 1,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart1clk-gate",
> +		.parent_names =3D (const char *[]){ "uart1clk", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 12,
> +	},
> +	[SCU1_CLK_UART2] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart2clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 2,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart2clk-gate",
> +		.parent_names =3D (const char *[]){ "uart2clk", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 13,
> +	},
> +	[SCU1_CLK_UART3] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart3clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 3,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART3CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart3clk-gate",
> +		.parent_names =3D (const char *[]){ "uart3clk", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 14,
> +	},
> +	[SCU1_CLK_GATE_I2CCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i2cclk-gate",
> +		.parent_names =3D (const char *[]){	},
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 15,
> +	},
> +	[SCU1_CLK_GATE_I3C0CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c0clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 16,
> +	},
> +	[SCU1_CLK_GATE_I3C1CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c1clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 17,
> +	},
> +	[SCU1_CLK_GATE_I3C2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c2clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 18,
> +	},
> +	[SCU1_CLK_GATE_I3C3CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c3clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 19,
> +	},
> +	[SCU1_CLK_GATE_I3C4CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c4clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 20,
> +	},
> +	[SCU1_CLK_GATE_I3C5CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c5clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 21,
> +	},
> +	[SCU1_CLK_GATE_I3C6CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c6clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 22,
> +	},
> +	[SCU1_CLK_GATE_I3C7CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c7clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 23,
> +	},
> +	[SCU1_CLK_GATE_I3C8CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c8clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 24,
> +	},
> +	[SCU1_CLK_GATE_I3C9CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c9clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 25,
> +	},
> +	[SCU1_CLK_GATE_I3C10CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c10clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 26,
> +	},
> +	[SCU1_CLK_GATE_I3C11CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c11clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 27,
> +	},
> +	[SCU1_CLK_GATE_I3C12CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c12clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 28,
> +	},
> +	[SCU1_CLK_GATE_I3C13CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c13clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 29,
> +	},
> +	[SCU1_CLK_GATE_I3C14CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c14clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 30,
> +	},
> +	[SCU1_CLK_GATE_I3C15CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "i3c15clk-gate",
> +		.parent_names =3D (const char *[]){ "soc1-ahb", },
> +		.reg =3D SCU1_CLK_STOP,
> +		.clk_idx =3D 31,
> +	},
> +	[SCU1_CLK_UART5] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart5clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 5,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART5CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart5clk-gate",
> +		.parent_names =3D (const char *[]){ "uart5clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 0,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_UART6] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart6clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 6,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART6CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart6clk-gate",
> +		.parent_names =3D (const char *[]){ "uart6clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 1,
> +	},
> +	[SCU1_CLK_UART7] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart7clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 7,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART7CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart7clk-gate",
> +		.parent_names =3D (const char *[]){ "uart7clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 2,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_UART8] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart8clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 8,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART8CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart8clk-gate",
> +		.parent_names =3D (const char *[]){ "uart8clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 3,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_UART9] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart9clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 9,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART9CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart9clk-gate",
> +		.parent_names =3D (const char *[]){ "uart9clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 4,
> +	},
> +	[SCU1_CLK_UART10] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart10clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 10,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART10CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart10clk-gate",
> +		.parent_names =3D (const char *[]){ "uart10clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 5,
> +	},
> +	[SCU1_CLK_UART11] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart11clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 11,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART11CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart11clk-gate",
> +		.parent_names =3D (const char *[]){ "uart11clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 6,
> +	},
> +	[SCU1_CLK_UART12] =3D {
> +		.type =3D CLK_MUX,
> +		.name =3D "uart12clk",
> +		.parent_names =3D (const char *[]){"uartxclk", "huartxclk", },
> +		.num_parents =3D 2,
> +		.reg =3D SCU1_CLK_SEL1,
> +		.bit_shift =3D 12,
> +		.bit_width =3D 1,
> +	},
> +	[SCU1_CLK_GATE_UART12CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "uart12clk-gate",
> +		.parent_names =3D (const char *[]){ "uart12clk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 7,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_UART13] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "uart13clk",
> +		.parent_names =3D (const char *[]){ "huartxclk", },
> +		.mult =3D 1,
> +		.div =3D 1,
> +	},
> +	[SCU1_CLK_UART14] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "uart14clk",
> +		.parent_names =3D (const char *[]){ "huartxclk", },
> +		.mult =3D 1,
> +		.div =3D 1,
> +	},
> +	[SCU1_CLK_GATE_FSICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "fsiclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 8,
> +	},
> +	[SCU1_CLK_GATE_LTPIPHYCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "ltpiphyclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 9,
> +	},
> +	[SCU1_CLK_GATE_LTPICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "ltpiclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 10,
> +	},
> +	[SCU1_CLK_GATE_VGALCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "vgalclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 11,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_UHCICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "usbuartclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 12,
> +	},
> +	[SCU1_CLK_CAN] =3D {
> +		.type =3D CLK_FIXED_FACTOR,
> +		.name =3D "canclk",
> +		.parent_names =3D (const char *[]){ "soc1-apll", },
> +		.mult =3D 1,
> +		.div =3D 10,
> +	},
> +	[SCU1_CLK_GATE_CANCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "canclk-gate",
> +		.parent_names =3D (const char *[]){ "canclk", },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 13,
> +	},
> +	[SCU1_CLK_GATE_PCICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "pciclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 14,
> +	},
> +	[SCU1_CLK_GATE_SLICLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc1-sliclk-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 15,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_E2MCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "soc1-e2m-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 16,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_PORTCUSB2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "portcusb2-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 17,
> +		.flags =3D CLK_IS_CRITICAL,
> +	},
> +	[SCU1_CLK_GATE_PORTDUSB2CLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "portdusb2-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 18,
> +	},
> +	[SCU1_CLK_GATE_LTPI1TXCLK] =3D {
> +		.type =3D CLK_GATE,
> +		.name =3D "ltp1tx-gate",
> +		.parent_names =3D (const char *[]){  },
> +		.reg =3D SCU1_CLK_STOP2,
> +		.clk_idx =3D 19,
> +	},
> +};
> +
> +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void __io=
mem
> *reg,
> +						  const struct ast2700_clk_info *clk,
> +						  struct ast2700_clk_ctrl *clk_ctrl) {
> +	int scu =3D clk_ctrl->clk_data->scu;
> +	unsigned int mult, div;
> +	u32 val;
> +
> +	if (!scu && clk_idx =3D=3D SCU0_CLK_HPLL) {
> +		val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> +		if ((val & GENMASK(3, 2)) !=3D 0) {
> +			switch ((val & GENMASK(3, 2)) >> 2) {
> +			case 1:
> +				return devm_clk_hw_register_fixed_rate(clk_ctrl->dev,
> "soc0-hpll",
> +								       NULL, 0, 1900000000);
> +			case 2:
> +				return devm_clk_hw_register_fixed_rate(clk_ctrl->dev,
> "soc0-hpll",
> +								       NULL, 0, 1800000000);
> +			case 3:
> +				return devm_clk_hw_register_fixed_rate(clk_ctrl->dev,
> "soc0-hpll",
> +								       NULL, 0, 1700000000);
> +			default:
> +				return ERR_PTR(-EINVAL);
> +			}
> +		}
> +	}
> +
> +	val =3D readl(reg);
> +
> +	if (val & BIT(24)) {
> +		/* Pass through mode */
> +		mult =3D 1;
> +		div =3D 1;
> +	} else {
> +		u32 m =3D val & 0x1fff;
> +		u32 n =3D (val >> 13) & 0x3f;
> +		u32 p =3D (val >> 19) & 0xf;
> +
> +		if (scu) {
> +			mult =3D (m + 1) / (n + 1);
> +			div =3D (p + 1);
> +		} else {
> +			if (clk_idx =3D=3D SCU0_CLK_MPLL) {
> +				mult =3D m / (n + 1);
> +				div =3D (p + 1);
> +			} else {
> +				mult =3D (m + 1) / (2 * (n + 1));
> +				div =3D (p + 1);
> +			}
> +		}
> +	}
> +
> +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, clk->name,
> +						 clk->parent_names[0], 0, mult, div); }
> +
> +static struct clk_hw *ast2700_clk_hw_register_uartpll(int clk_idx, void
> __iomem *reg,
> +						      const struct ast2700_clk_info *clk,
> +						      struct ast2700_clk_ctrl *clk_ctrl) {
> +	unsigned int mult, div;
> +	u32 val =3D readl(reg);
> +	u32 r =3D val & 0xff;
> +	u32 n =3D (val >> 8) & 0x3ff;
> +
> +	mult =3D r;
> +	div =3D n * 2;
> +
> +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, clk->name,
> +						 clk->parent_names[0], 0, mult, div); }
> +
> +static struct clk_hw *ast2700_clk_hw_register_misc(int clk_idx, void
> __iomem *reg,
> +						   const struct ast2700_clk_info *clk,
> +						   struct ast2700_clk_ctrl *clk_ctrl) {
> +	u32 div =3D 0;
> +
> +	if (clk_idx =3D=3D SCU0_CLK_MPHY)
> +		div =3D readl(reg) + 1;
> +	else if (clk_idx =3D=3D SCU0_CLK_U2PHY_REFCLK)
> +		div =3D (GET_USB_REFCLK_DIV(readl(reg)) + 1) << 1;
> +	else
> +		return ERR_PTR(-EINVAL);
> +
> +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, clk->name,
> +						   clk->parent_names[0], clk->flags,
> +						   1, div);
> +}
> +
> +static int ast2700_clk_is_enabled(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +	u32 reg;
> +
> +	reg =3D readl(gate->reg);
> +
> +	return !(reg & clk);
> +}
> +
> +static int ast2700_clk_enable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +
> +	if (readl(gate->reg) & clk)
> +		writel(clk, gate->reg + 0x04);
> +
> +	return 0;
> +}
> +
> +static void ast2700_clk_disable(struct clk_hw *hw) {
> +	struct clk_gate *gate =3D to_clk_gate(hw);
> +	u32 clk =3D BIT(gate->bit_idx);
> +
> +	/* Clock is set to enable, so use write to set register */
> +	writel(clk, gate->reg);
> +}
> +
> +static const struct clk_ops ast2700_clk_gate_ops =3D {
> +	.enable =3D ast2700_clk_enable,
> +	.disable =3D ast2700_clk_disable,
> +	.is_enabled =3D ast2700_clk_is_enabled,
> +};
> +
> +static struct clk_hw *ast2700_clk_hw_register_gate(struct device *dev, c=
onst
> char *name,
> +						   const char *parent_name, unsigned long
> flags,
> +						   void __iomem *reg, u8 clock_idx,
> +						   u8 clk_gate_flags, spinlock_t *lock) {
> +	struct clk_gate *gate;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret =3D -EINVAL;
> +
> +	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name =3D name;
> +	init.ops =3D &ast2700_clk_gate_ops;
> +	init.flags =3D flags;
> +	init.parent_names =3D parent_name ? &parent_name : NULL;
> +	init.num_parents =3D parent_name ? 1 : 0;
> +
> +	gate->reg =3D reg;
> +	gate->bit_idx =3D clock_idx;
> +	gate->flags =3D clk_gate_flags;
> +	gate->lock =3D lock;
> +	gate->hw.init =3D &init;
> +
> +	hw =3D &gate->hw;
> +	ret =3D clk_hw_register(dev, hw);
> +	if (ret) {
> +		kfree(gate);
> +		hw =3D ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +
> +static void aspeed_reset_unregister_adev(void *_adev) {
> +	struct auxiliary_device *adev =3D _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static void aspeed_reset_adev_release(struct device *dev) {
> +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static int aspeed_reset_controller_register(struct device *clk_dev,
> +					    void __iomem *base, const char *adev_name) {
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name =3D adev_name;
> +	adev->dev.parent =3D clk_dev;
> +	adev->dev.release =3D aspeed_reset_adev_release;
> +	adev->id =3D 666u;
> +
> +	ret =3D auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ret;
> +	}
> +
> +	ret =3D auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	adev->dev.platform_data =3D (__force void *)base;
> +
> +	return devm_add_action_or_reset(clk_dev,
> aspeed_reset_unregister_adev,
> +adev); }
> +
> +static int ast2700_soc_clk_probe(struct platform_device *pdev) {
> +	struct ast2700_clk_data *clk_data;
> +	struct ast2700_clk_ctrl *clk_ctrl;
> +	struct clk_hw_onecell_data *clk_hw_data;
> +	struct device *dev =3D &pdev->dev;
> +	void __iomem *clk_base;
> +	struct clk_hw **hws;
> +	char *reset_name;
> +	int ret;
> +	int i;
> +
> +	clk_ctrl =3D devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
> +	if (!clk_ctrl)
> +		return -ENOMEM;
> +	clk_ctrl->dev =3D dev;
> +	dev_set_drvdata(&pdev->dev, clk_ctrl);
> +
> +	spin_lock_init(&clk_ctrl->lock);
> +
> +	clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(clk_base))
> +		return PTR_ERR(clk_base);
> +
> +	clk_ctrl->base =3D clk_base;
> +
> +	clk_data =3D (struct ast2700_clk_data *)of_device_get_match_data(dev);
> +	if (!clk_data)
> +		return devm_of_platform_populate(dev);
> +
> +	clk_ctrl->clk_data =3D clk_data;
> +	reset_name =3D devm_kasprintf(dev, GFP_KERNEL, "reset%d",
> +clk_data->scu);
> +
> +	clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> clk_data->nr_clks),
> +				   GFP_KERNEL);
> +	if (!clk_hw_data)
> +		return -ENOMEM;
> +
> +	clk_hw_data->num =3D clk_data->nr_clks;
> +	hws =3D clk_hw_data->hws;
> +
> +	for (i =3D 0; i < clk_data->nr_clks; i++) {
> +		const struct ast2700_clk_info *clk =3D &clk_data->clk_info[i];
> +		void __iomem *reg =3D clk_ctrl->base + clk->reg;
> +
> +		if (clk->type =3D=3D CLK_FIXED) {
> +			hws[i] =3D devm_clk_hw_register_fixed_rate(dev, clk->name,
> NULL,
> +								 clk->flags, clk->fixed_rate);
> +		} else if (clk->type =3D=3D CLK_FIXED_FACTOR) {
> +			hws[i] =3D devm_clk_hw_register_fixed_factor(dev, clk->name,
> +								   clk->parent_names[0], clk->flags,
> +								   clk->mult, clk->div);
> +		} else if (clk->type =3D=3D CLK_PLL) {
> +			hws[i] =3D ast2700_clk_hw_register_pll(i, reg, clk, clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_UART_PLL) {
> +			hws[i] =3D ast2700_clk_hw_register_uartpll(i, reg, clk, clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_MUX) {
> +			hws[i] =3D devm_clk_hw_register_mux(dev, clk->name,
> clk->parent_names,
> +							  clk->num_parents, clk->flags, reg,
> +							  clk->bit_shift, clk->bit_width,
> +							  0, &clk_ctrl->lock);
> +		} else if (clk->type =3D=3D CLK_MISC) {
> +			hws[i] =3D ast2700_clk_hw_register_misc(i, reg, clk, clk_ctrl);
> +		} else if (clk->type =3D=3D CLK_DIVIDER) {
> +			hws[i] =3D devm_clk_hw_register_divider(dev, clk->name,
> clk->parent_names[0],
> +							      clk->flags, reg, clk->bit_shift,
> +							      clk->bit_width, 0,
> +							      &clk_ctrl->lock);
> +		} else if (clk->type =3D=3D CLK_DIV_TABLE) {
> +			hws[i] =3D clk_hw_register_divider_table(dev, clk->name,
> clk->parent_names[0],
> +							       clk->flags, reg, clk->bit_shift,
> +							       clk->bit_width, 0,
> +							       clk->div_table, &clk_ctrl->lock);
> +		} else {
> +			hws[i] =3D ast2700_clk_hw_register_gate(dev, clk->name,
> clk->parent_names[0],
> +							      clk->flags, reg, clk->clk_idx,
> +							      clk->flags, &clk_ctrl->lock);
> +		}
> +
> +		if (IS_ERR(hws[i]))
> +			return PTR_ERR(hws[i]);
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> clk_hw_data);
> +	if (ret)
> +		return ret;
> +
> +	return aspeed_reset_controller_register(dev, clk_base, reset_name); }
> +
> +static const struct ast2700_clk_data ast2700_clk0_data =3D {
> +	.scu =3D 0,
> +	.nr_clks =3D ARRAY_SIZE(ast2700_scu0_clk_info),
> +	.clk_info =3D ast2700_scu0_clk_info,
> +};
> +
> +static const struct ast2700_clk_data ast2700_clk1_data =3D {
> +	.scu =3D 1,
> +	.nr_clks =3D ARRAY_SIZE(ast2700_scu1_clk_info),
> +	.clk_info =3D ast2700_scu1_clk_info,
> +};
> +
> +static const struct of_device_id ast2700_scu_match[] =3D {
> +	{ .compatible =3D "aspeed,ast2700-scu0", .data =3D &ast2700_clk0_data }=
,
> +	{ .compatible =3D "aspeed,ast2700-scu1", .data =3D &ast2700_clk1_data }=
,
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ast2700_scu_match);
> +
> +static struct platform_driver ast2700_scu_driver =3D {
> +	.driver =3D {
> +		.name =3D "clk-ast2700",
> +		.of_match_table =3D ast2700_scu_match,
> +	},
> +};
> +
> +builtin_platform_driver_probe(ast2700_scu_driver,
> +ast2700_soc_clk_probe);
> --
> 2.34.1


