Return-Path: <linux-kernel+bounces-256103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E49348FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC331C22D06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9078C8B;
	Thu, 18 Jul 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HF8MgdGj"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087877F2F;
	Thu, 18 Jul 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288127; cv=fail; b=KQOgiZ+wb+XqI7RE8jbcqVYupDqhxGcbGG7Q3jPE0V+/vjmQBhQGubdRLMvFTX6sEQDNsiNfA9yub57eFUCCwngQ7qwrfJ+qOFZkal39HmmjbjuCWh2+7Qz4nYOrxEyQ+VfMUIegC+lnpfn1i4gVOhw1a7+onVk4DxbYkdPjlDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288127; c=relaxed/simple;
	bh=p3TjpqJ950cvFrREjleWZ9pXor0j+KGfFWY64SdBIzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6180cNymK3++xzPJ8EbmV/WWe9qUAwvTnVoG0Q8Sr7tf15FMztv02l0BaB+qg4ddlkikqQMZ9K8yqOlAAkxuZdbiA6Bcw1PRkTefoiHWfUuihzpctTzl0DYfMkBXSUtIs15egKZi+UDqzXOUmepTduwG57naZLmgmyTsn3pw4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HF8MgdGj; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQrewb7sJVIHvtQFmeDDIb2t1T7KNQRae0eT2zJmz/OlxTRX4Va0y9wwCpVLsLXQo9jFwATjsIR+4Gk1VjUYvnWgMR6unjfrtHZOEIkt9I3ZhtPvE7VgQQoGMfV8I7FK2iI0N2VGPp8ZdA5vPVix2Z9cOfU+4LiIddhJB1URO7NaxZWLe4dG6ISm1KApGhTsIPaaqFOkgl0PH3u+nDQxvteBANTAFNLEoOO3Vm+WVxqPXZOn8rgDhkWSWWHhxH/uCBncf/AzsQCMzT+0Gb9pLB/WSCQ1lB0W4Lb3dUAMzAYbVN/Dl9QBBPWL6lS6985U9IMd50SOjWCw+Slh7BDxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEsTjz92mLjxag9P46RaHzxdy0UqaWrIpOX4GFe6YRg=;
 b=FVSi7hLL9wCSZrKaIKacIjR94V74CZV5uYRQuM+MgPOccAe2jc4JuGd4fzjGfVwnrG0Gv9N2kAHpnKcAK8w91QoidU3zCuYe0+Dqea4cPxBIvlMX8DtqU9rJnxES3ggTcbB8VU/5nXmSRBwYL5r2/yPMQtni+7fDco1Y4C62GD4iOW53qyMoeJDcXk+3AunPhuoUc7PljKABKWan/DGLR1Pq/1GAbgKCkkaq8K+sCQ4+u71MJKpT2dxy3ERB9PGr1T9AFZdappkbPX1fkMZLcd3lIHzlrgRtO+jACuw+6BWrWpLYIlUsK/lo6rNdKtLUIjNA5br5aqyVgxsB6S92tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEsTjz92mLjxag9P46RaHzxdy0UqaWrIpOX4GFe6YRg=;
 b=HF8MgdGjgpg65GhM/M0M08xtCseXYY1gHA+7TEdlG1h4MpT4ocf1ZLlWMDEs/ot72S2o51y3MIWc86E35co/y+w2T1Es7UI/vrf4SZ+8/y6EFKefXT2qBlNDsXaLQVTX81FK1TxJJNXwsrnTMUy3NOR6ojkZ5uZeLun5MyXTw8Q=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 07:35:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 07:35:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Topic: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0qcdca2IpPJJJkyywPIhPKTWr7H8JJyQ
Date: Thu, 18 Jul 2024 07:35:21 +0000
Message-ID:
 <PAXPR04MB845905EAE0154106199AB81088AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
 <20240710084345.2016687-4-wei.fang@nxp.com>
In-Reply-To: <20240710084345.2016687-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10716:EE_
x-ms-office365-filtering-correlation-id: b0fbc7f9-ad45-45cd-8c91-08dca6fc2e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BP1tiyd1akIZMPf9CaRSDbwdKw8NwcelIHkBux32rZhrMCLwi5kAcZu4D87f?=
 =?us-ascii?Q?NINR+JPD+xfFx1+SJWu3jfkfTxeEQOajvCmHVapwd2B1u/utXM87AVIIZwZ0?=
 =?us-ascii?Q?kQma/33RY1dp1NybJilxHdtQe1JnJ3ZdpCdhOTBdgfOfYgwjsQ8Glt/xecCa?=
 =?us-ascii?Q?VH1JUu9EBMPMWmQ3oMTpSaCpdJUkdR/5OvSzj2rIZuQN/vOhzcs/Taj8eMGr?=
 =?us-ascii?Q?8e7cQ0b57yj8bXb55+Y+cPVZF6LCr+V3n1hlgRH+oY6g2STmIFgIBlD0U3HC?=
 =?us-ascii?Q?Mk3rO2Wpu1f7mqAKzUrdYKODTJEc245nckRnwt/eJMsjGbL6z0hyAKnvEOeY?=
 =?us-ascii?Q?+pm0tOqjosT9sVhi5Ww/3fk1yM05k9ZOf5F5uRS1lpjymp3re+V7BQu+PwQW?=
 =?us-ascii?Q?OxiLrwZyLUqQz3UxHt5iPWrDJs6debBiS6+ZZNi6Aeu4wJJA7A0J/cqUIeW0?=
 =?us-ascii?Q?YmBxQ5g+whvtslB0ybc1fTHzHCXI/ooweTG7R3usMOIsL1lDKyM5uBlRlkr5?=
 =?us-ascii?Q?QBwtsWTAdOy9lnjxDqJGk1AgBqNIuDeHP5gr9/PnjkrDPdnomz1Vm3sFUAk9?=
 =?us-ascii?Q?8NHGKTGZodjsY6Z3Ek8rrAK31vjRq15nHylA6xhb1z/+Zn6mql3lCbsN6Qo+?=
 =?us-ascii?Q?QQDKbv2UNw2BWlFdC9yz0e/SQE36OK6Iq8eg896BLPKdNLyUP3zw/ONhb8sF?=
 =?us-ascii?Q?/2u6/6qKuUclaMA8xF5ujNg4fffnPGmyJ8SbkD68V5IC/eLvKNyASlnBp2av?=
 =?us-ascii?Q?RYOAFVqxiBgqRxuTE5L5bw6ezx83DpW08IBqqxEutxga4vVzKO516RWYAAEn?=
 =?us-ascii?Q?X5KEGe6iT4+HQUqvLtIo/h+teIcY8rSa70PpZZ8Q0qbAVp9IUyH1qKLzuCH4?=
 =?us-ascii?Q?k3A9txABzFd7GUJoMAFw7/2yYcw06sQuQpPvJlxXVydnnvSnAh9tfiAZ4p6G?=
 =?us-ascii?Q?CkDou6V9Bq7ZElxIlWK5ZmrCXp6SIK30kCM6mL6BsF7WSCfIFKI3E1IC/r8d?=
 =?us-ascii?Q?8pqG9++evzgAYi2wNwRHP7INetcFluV3CuzgZ7DyDqy+ai9UqlqIMq3Quznv?=
 =?us-ascii?Q?7fT29JSAcVem5jiQDGs4BjjRoEfP9bQFbkpm625n9XBPr7sh9McF8y3XxSG0?=
 =?us-ascii?Q?BnE4S0RWJ9Lq0xGVd1xA8+p1FC/f/mIO9qa+EqI9v9X0XxXptbJArN2GWtfH?=
 =?us-ascii?Q?4GOfbz9nqgsDYyuDu1OVg34AypN/7h43An7Ms3UJYuKCLHKJsUOpFeLrPKyD?=
 =?us-ascii?Q?wKNWGHgcUTksXWgaGgA5lArRk8rPgzbfnkl/wGpLkvabbbdrk7mEX0xOhsN7?=
 =?us-ascii?Q?720Q72zfhYPAFfubFMPLXAOt2Zu0QcFEoD2X0Mt+oXTwgU20WG8l4jYTnwXm?=
 =?us-ascii?Q?SzIhHVNcyVMqfV2rGxoKTX6b/HTqxUxMqJSEzIPHDovoyn9hsQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oJ8VJ8CAX1gbvKYZ9utzo221wxa7DRF+rpnW9fwVCHztGKHXRtpAIcDhZ11X?=
 =?us-ascii?Q?4tbb/kKD3RTZXS0kTe4vFZD0ntyCSGW8Ezhv/os/JP8kR+5PVKFkSLyTlLud?=
 =?us-ascii?Q?Hal1XqtTLVXvqLuoyd1q1VKz4XyhtxfJ+ebOMwqfjzwhWZJpHDv+mkCYE3NB?=
 =?us-ascii?Q?VECFsAOZ+3GHkyXAxi0X+ivmawnBWeq3PWRn7Wjysi8XukIE6c2eeakhP70I?=
 =?us-ascii?Q?YKWrvl9+L5/JxZJSeE08jjzlYAlR/4iX/1GLBDnbh+aOePXBWg/II1Y4Oind?=
 =?us-ascii?Q?f/0ga8diKLDifKwIVntMKuLkJ66NQ3wIVyaE/foP5WNv2lrZhR/FoCwBroGM?=
 =?us-ascii?Q?4m+G5LLrjBuxnF6GVSQwXi5HLKOpVfiFWLQFaX7sspqg30tHdP444kXMe+FL?=
 =?us-ascii?Q?72nB7K7KyiVzPmAWiScjv0nmnKXjoag5yIDUqcXu/Y4ULlFMrKEBBqMWSFAH?=
 =?us-ascii?Q?W+14PVC2eHfAhhQU7evJp374Sf+3mMB6utDGYTymMxzQfVRDsYZhF8oUf4Zu?=
 =?us-ascii?Q?Uk87rIZB/ZYXxRFPOLll37ED//wsnKbFDR6HvbKhTvVcLkh67sK4POLC9NZc?=
 =?us-ascii?Q?b5Fd2OsUy8WO9PIGe/Zh1wTU6aDGc8XLJcNgLJ8nFQC83WGEnHOVrln5jd2S?=
 =?us-ascii?Q?YNwtqJuaPzzYDNEUvDGZeeRfqFRE3QMxnLYNBZ0/DZLhpv41BIw+mk420XJc?=
 =?us-ascii?Q?Ei/vUzZI3NLyN+pO64KauDVUeYGZTYXeLwqbJUXxlHRg1roMrC33682vFULU?=
 =?us-ascii?Q?JxVFNiTDsShkr/IsDLmTXBabihwxgg6fMA4e9m0RacdzLzPLpfz+NLq0vwkQ?=
 =?us-ascii?Q?33AUP95aSup8WH4pb0dMGIT/GshgjGO5gSbwkMZ9rv4FD5AcwgSBPTTCYz84?=
 =?us-ascii?Q?HsqdG7KCKKsa/uEJu62B61omiPHdDqdg0SBuGNyxudMcFv4RBvEqHD52AOiZ?=
 =?us-ascii?Q?D0Tsq96W6FsOddIVS8htYSKGBBkfsd9CU2PFgjBCEoBuHslVDGPmyelOhcWV?=
 =?us-ascii?Q?nCpsrqjeAk4mB8XcBUDOhDzw3+syrxx3FbKKxbDWqdfD+89FlWdWdY7L7U9D?=
 =?us-ascii?Q?MksH6AIW8gcfEF/S7ENWV/gxSIv30rhrQPupdp0E4ZM3WJftc6laknlCECWq?=
 =?us-ascii?Q?coDkXwoX2y7AZTG8GbA4Ii1LFeU88HDlK6M9U7UzMBQFWd8Xpz93xcaD0AOl?=
 =?us-ascii?Q?JosTPvXr1B54nLdvCdWiYJuJPTXwYF/0FY8nM3H4lsi6kWvxS4g/nf6At4Cu?=
 =?us-ascii?Q?Lpmk/4u9zp4/PEA7Fs/MqPkEgD7ggEvuvp4SvDlY+EnsRuxEtF1RYYvLOMdc?=
 =?us-ascii?Q?pi7ZFScquhok5PmRb3WfZh9VaEO4RY+tCEtYfg3/9KBxsWK/Yksuj8ZwpygM?=
 =?us-ascii?Q?kwj0aMFE/mbHeg9wPMXeXPYfMon8/dYWdeZLfL5vIrIuxOOhkqwAhcAlZ9uW?=
 =?us-ascii?Q?WWGyI4Td9z7b4wfn/7I22GLReEBShbuVcFtcbwT4XviebXqtixju+oq7Rtr8?=
 =?us-ascii?Q?3C7zYg/OBKIHOuBDV8sF/4xHknZEAvNINjsVAJ1JCZFAK3q6d6RjUON5feDB?=
 =?us-ascii?Q?poict3ZtrYD+T8oiJ6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fbc7f9-ad45-45cd-8c91-08dca6fc2e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:35:21.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7NmbrKv+hJ1/dGZIfi8oIPXmipslh+bbawGfnnCyWfh7PMRi7gaf1A+Pjka/IvajHhkYqNwhm98sy58GIv5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

> Subject: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
> control
>=20
> The NETCMIX block control consists of registers for configuration of
> peripherals in the NETC domain, so enable the clock of NETCMIX to
> support the configuration.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2:
> Add RMII reference clock mux for ENETC0 and ENETC1.
> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 30
> +++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-
> imx95-blk-ctl.c
> index 74f595f9e5e3..19a62da74be4 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -248,6 +248,35 @@ static const struct imx95_blk_ctl_dev_data
> dispmix_csr_dev_data =3D {
>  	.clk_reg_offset =3D 0,
>  };
>=20
> +static const struct imx95_blk_ctl_clk_dev_data
> netxmix_clk_dev_data[] =3D {
> +	[IMX95_CLK_NETCMIX_ENETC0_RMII] =3D {
> +		.name =3D "enetc0_rmii_sel",
> +		.parent_names =3D (const char *[]){"ext_enetref",
> "enetref"},
> +		.num_parents =3D 2,
> +		.reg =3D 4,
> +		.bit_idx =3D 5,
> +		.bit_width =3D 1,
> +		.type =3D CLK_MUX,
> +		.flags =3D CLK_SET_RATE_NO_REPARENT |
> CLK_SET_RATE_PARENT,
> +	},
> +	[IMX95_CLK_NETCMIX_ENETC1_RMII] =3D {
> +		.name =3D "enetc1_rmii_sel",
> +		.parent_names =3D (const char *[]){"ext_enetref",
> "enetref"},
> +		.num_parents =3D 2,
> +		.reg =3D 4,

Both the entry use reg address 4, use a lock to protect?

Regards,
Peng.

> +		.bit_idx =3D 10,
> +		.bit_width =3D 1,
> +		.type =3D CLK_MUX,
> +		.flags =3D CLK_SET_RATE_NO_REPARENT |
> CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct imx95_blk_ctl_dev_data netcmix_dev_data =3D {
> +	.num_clks =3D ARRAY_SIZE(netxmix_clk_dev_data),
> +	.clk_dev_data =3D netxmix_clk_dev_data,
> +	.clk_reg_offset =3D 0,
> +};
> +
>  static int imx95_bc_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> @@ -419,6 +448,7 @@ static const struct of_device_id
> imx95_bc_of_match[] =3D {
>  	{ .compatible =3D "nxp,imx95-lvds-csr", .data =3D
> &lvds_csr_dev_data },
>  	{ .compatible =3D "nxp,imx95-display-csr", .data =3D
> &dispmix_csr_dev_data },
>  	{ .compatible =3D "nxp,imx95-vpu-csr", .data =3D
> &vpublk_dev_data },
> +	{ .compatible =3D "nxp,imx95-netcmix-blk-ctrl", .data =3D
> +&netcmix_dev_data},
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
> --
> 2.34.1


