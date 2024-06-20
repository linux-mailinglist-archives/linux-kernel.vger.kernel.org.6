Return-Path: <linux-kernel+bounces-222008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C426A90FBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492B01F22F21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AC17545;
	Thu, 20 Jun 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5tprcSG"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D91EA8F;
	Thu, 20 Jun 2024 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853640; cv=fail; b=XmR+i/qoqfUjcbM0VOTPWtG1wSdgmrG1pfmpPBVyBn4yXOpQtA9CYYdXQF9XF/BUaMLCrRC4GxDUDPf4RV+9ztNTSaDwi2O3ApEg0DnPwi6S1B6si52esHpCgzxKV+91iQ+tevEuWqlLOUGvn8WkyTTqts8HxZDAnd4H3PgThHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853640; c=relaxed/simple;
	bh=HJeCgjhhpZ5xYdji/Xl0UxagIHelGNxxGx5Yu/Tlf2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bymYypTVz7oDWnRBKsXXvEknS24biVNQTcTfV/eZOYeHk03XWXXTFBlr2U7vWb4AhV4gzN/AftgLto6jJI90VqK/mI+zi/Iq0eTofquq0shR1aP8YE8c4r3GR+vJMYg6DCphvwsaaEUhb4xSBpe+Es5ctNAbkGiLzdETsJ6BlJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s5tprcSG; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Nh/qTPnnmQorVzreQgsyDEbb+GRE5nB8fEPaHHMVYljpYdADtbdbLXinxmeOF5M720BvGZizN/+sQJAGUd65FWCZyIXZAQdkcQGF/amuU7V22QytC+O1gAwNtC71V3W4tPdBRHFRcuQ5J0CKXQF0xhCVGcYvYc3vytaSvLVPWJ+8ywMEU13SQ1Lko2qlHggKv1pRB0o0UwEXZaElV3NspWMpLFIobewF9TRcDeVkeEIdC9bCmTvf/sPGK6AsPYzSOWXUrDcV2xLLMT7Zp3HQ0vjwcJkNIZxt/0nWGXyApzoIQSa07rs+d5E2gkYUk5aHXnceoP4DxgqCujIBhD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKqaBrwFZr63Jl5pqMnOtQTn3JVDhDiGh5ASzKTBAgA=;
 b=CJ6uSAf/OZRnsQbIql8QwrD0J4b86mVggGUq9Uk++pnniyp446tvT7EuBr2JqI3+5MWeEHNETdtwulXBB+5Q6rF1eP4hkjHtHWyxXQR3TkE1kX4dp9PeHcp50TtGiKhbb2hJiwjKmMEZ9yFrRCuPoBsf4I/THIpu5Y78c67hydtQThy2WFGVYy6rA374DVytA/9Hr6jA+6HAmxXCyo82Kr+HOmsRKA+ye1e5huEJ7sSKrHX5PXZSnBjS/LxXu9O1+Kh61GKzS5gMg22dM9VTKwAw49HRPlTWVXWq/qsaftFTxcIYOQYKmlWn/CSub2BPvMQv7291IGft0nIF4C7fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKqaBrwFZr63Jl5pqMnOtQTn3JVDhDiGh5ASzKTBAgA=;
 b=s5tprcSGomNmZ2RC2Cj0bWsESsZ7Kne5J1Z3LZjmQnMImZojkvhzaBmcUNmWI9mkmHwbJ45a3mOj9aHmxOA/TRVErC3kXs57NwteqmYjRuAGwXi5O3YP8qX0Z/F+3lkwkMoYz2Bqt0aKv6dmDbnMEZBSqWVVFwdmd6r4Ym1pLMM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM9PR04MB8210.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 03:20:35 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:20:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Topic: [PATCH v4 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Index: AQHarbcg8tYP6XkRL0OL5bfUz062erHMaO8AgAO7ZlA=
Date: Thu, 20 Jun 2024 03:20:35 +0000
Message-ID:
 <AM6PR04MB59412EBBB6899EAEAF4CB93E88C82@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-4-dc456995d590@nxp.com>
 <ZnB9ANdbJ9d9MZHD@pluto>
In-Reply-To: <ZnB9ANdbJ9d9MZHD@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM9PR04MB8210:EE_
x-ms-office365-filtering-correlation-id: b396e06d-058d-40fd-f8a3-08dc90d7f331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sfvDcq5hRgiYXUc2mLsw7Eii4FvSPxoSM53VHYS0rXpO7AzP9TMkVSSzMMp1?=
 =?us-ascii?Q?MDvy2pld2yv1A4uyEHC+qVAbfgKJVwp4NMbWq5dkuYvlbyYEMcF9wabK9XHp?=
 =?us-ascii?Q?pr1LAWy72vNvyEyQt8inbaMzQQ95Nh+ckVwEk6zMjv0OuZRrmrfKuryp01pp?=
 =?us-ascii?Q?NTXeqDxs0W4kSJSLRONOuMvs++jwqNSDiJ2Jq0KwDUMVVP4h3oo5gLNbE0Gc?=
 =?us-ascii?Q?YaV4v7DR7LUeNjqF6mQMr6NrOOKNdZESUzEF3NKYWpU57B4BK+ejYmkJ5exp?=
 =?us-ascii?Q?EzJSYbgGWQrR5d93XLEWjV03JFr8nYx0lLNx7g14qdHAciN4CO3Zb2oLL2sg?=
 =?us-ascii?Q?Kxkq4e4iHPy8DaZ/8AgugI1bq1sLjE6UqB6LR8PyNrRaKR026MFw7D3ONcIi?=
 =?us-ascii?Q?vAZe7a5OGC6u6ashG8cravT/L5J8sUVj4Oi2XWL1mh5n4wsb3EvjIjO4EU7g?=
 =?us-ascii?Q?3Yt67AFzeOT9JIejJiIs74Av7NrJhqqKjBBdiwpdY4uz6383v6SuxQAU0Ejx?=
 =?us-ascii?Q?OQUyrLKuvdKs9rTIceKPyU/MkLGfe3wnLGNp9WXYcvTAkkob8ZGE4d2OHsZe?=
 =?us-ascii?Q?hp3cjBUQ6SpAaKkE3FkAS3gnAcnp5CZUGiZDXLdqYD14c98gNd8VXxVEfqkb?=
 =?us-ascii?Q?4Y0nK2LOl0jYKpnlQLO14F96DvUBNQHhGNIS+5jgGBTxvk3l6y9SAMyse0YC?=
 =?us-ascii?Q?+2vcawXPAvkwFbxkuSWU0u0CtEtCMVoJfd/c7CqfLpRP4Zk3SCXrtR2+KL0G?=
 =?us-ascii?Q?1H3pFjGJ8qCqK0WhXyyyjrqArOxEGro7RnX1urtV94WCFz1wtg4lLSa5YuyW?=
 =?us-ascii?Q?xuDuOANHOtRYn5SNhtjt978kZrZrJepUruVob69/ZhfTqK4pnrDLfjPEMu6j?=
 =?us-ascii?Q?QwDPEQ8R9S9F4NvfeOkZ+0eDGipXj/Xv8VDrYzX3Brz/hPHkFXzUV431nEG+?=
 =?us-ascii?Q?CoDFufg+lhVTA/qGiR4uJpjwdb/skaOK+RN8N9AqKAlMwemzUEKicPPEVf4f?=
 =?us-ascii?Q?8yAJDapT7UB7YNQd/xuSG0xi7PJm5Nv1Q/oR1U7sYxuC8/kDB1AUETceimi4?=
 =?us-ascii?Q?1VPO17Oi0uHPlIABN0uoh8asbkUQp9WfaBmfSHKMDt+Dey/REi57nDO3J4CF?=
 =?us-ascii?Q?8h3zMHOq+6GlOdyU4IiX+TfdEjBYch5OpO+eo16sm4qTXZjJnrW2Vfgb6KzB?=
 =?us-ascii?Q?4LL+c5EHWNp14hB/XZnx5ocO3jQV2zy7TIB+8ZbLgsUBQwQ3Dxv3HMhv3HB3?=
 =?us-ascii?Q?X5k/lVqy/hxIgBzKlmVfU7N7FlsJ3TarmmmBFLfY3ctKLmMxp34hfwIqE0fw?=
 =?us-ascii?Q?JLEN8aSQcL7aGbbCCprFRebTjh4ARmiKlbe5t8TFmDPy3LDNKADAlOSsxdeF?=
 =?us-ascii?Q?DGWW15k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ytVWCpwsJGg/7A7EuJm0d0CoekBPESSIvqI2amR/r8Fhqj5ZT75Q8rTYxKZp?=
 =?us-ascii?Q?FC5ZmP7aBennMFkjcPTGRo6t1fl+Y4BXLFp1xhERmNA/mPWy2j1zNsZ36iwr?=
 =?us-ascii?Q?bGUC7k+podhllO390pl0eusum8w2g6VWZ+0+NJsiNP0GUATP1T/lZfDWT7C+?=
 =?us-ascii?Q?AMV5zZm/yjN9/NShOWEMhfbNyQyh8z0UobFYQlkL/OfjkpoJvHCLhaTMBEpm?=
 =?us-ascii?Q?k346OXadr/TkIJNMc7loBWi71P1UV5GokQdm5cXslmZg40SXurnTS9xoCA49?=
 =?us-ascii?Q?rX73QHXDDHOIaQLYUzTl3TxB6EuYw1GLzNEyqpnEzmYGxAWU9tiicNXnYRYX?=
 =?us-ascii?Q?b0g+xEr7m32olfgc4CpqeSHWRwW+9p71k0XPjJyMGTtN2IsuNexutvQvMFoz?=
 =?us-ascii?Q?Wh+8kbkR/8rVRFlxc7QdRd9mjCvBdEn9F1iSbXujFcDdHEvFzd6Gj1gj2HTV?=
 =?us-ascii?Q?DQh9fIElib0mZHgdAOa2YnuO3hpWe3e+YF2q4ce3J0Tu7FkAh4tjKZ9qbJaR?=
 =?us-ascii?Q?vpNQme5gxnBKDFjjf221PWsbGDONSmcVJROK125bfOFjTb2L+6VjRYhCom/G?=
 =?us-ascii?Q?uHwOkRBEkVSnGkXV/nHggoCCBnnU6l07IDCY+tHFoWgsINvGvbrcx6cmMi5J?=
 =?us-ascii?Q?Nbi2UVTgu5Xkshtdnv5AgzdFe7gkCAfBQAf7Jqdn9CrwglX06STuxhLSOHiO?=
 =?us-ascii?Q?pscpYo4n7s94cGeP/jmxB1e42rSg+8kKNzRE99y4J0zvqaBsuz60dxouUvlx?=
 =?us-ascii?Q?E5Wtc7v72BA84fn+TJ/xK+J5LlEGCzVH2n79prkqVi68V5etRScRD2MNbDIq?=
 =?us-ascii?Q?L8O3uwOycZ4gMZs7533ffjtcrPfGJIO0YHBoFrst/cswo4oqz7nWTAyhfCa3?=
 =?us-ascii?Q?a3vzA9A9wjQH7v7UHq5ba00dV3pz/YGyhFAWMaS2adTfTTZSc4F+gufNR/ly?=
 =?us-ascii?Q?oIOZTfSAp98jSylZ2PUU9HbNeWkJ3VAtKEcooHQEDhxvfyY1mZMm+l/GfE5z?=
 =?us-ascii?Q?bJqjzJeR+oMx/9rWiZsyJBDIADPNJkcsgZNQytalxUTUX5BUX1tGatga3sR4?=
 =?us-ascii?Q?jXd7t2H+fo9bLlLbQLXja7fCCHnphBRAHfE5P6ms/eGZkmOZPXnemY0wb6UP?=
 =?us-ascii?Q?86d61vJ7K4eil0lWnTt17U2UnaXxsEYtfBFPiLJeDIYBJNf0x/R9wDO0sQwh?=
 =?us-ascii?Q?VDYhHrn+F49qonjc6ZLhJ2HUI2gQoGZTqdZDvvPUG1cq81ixbGyU3k6GOazt?=
 =?us-ascii?Q?8HEC7BdlFTbZsenb4r4is2Jvcq6qiIJzyQDc+yPOHPILZ1nznAOhfGjCRSxA?=
 =?us-ascii?Q?SMImkokE7/IJ/CfRZdR2w7HvZ+KPdw07ATraUUYv3PIuQK0NfwSB1i8b/EAf?=
 =?us-ascii?Q?/lX7+OUQ/Wg7xeLKpy3Rrwq3FVuebbSgmKmG5J/wSClw1Wpa2nvir6mRmtnQ?=
 =?us-ascii?Q?6mLTmuMQDOqquDHT3sCkWfG3NVeL/3uew5/yII6fJp6/MOGBgX9xFR8pfBWp?=
 =?us-ascii?Q?K8XxiVtlaEsADZkvHvQy22Ctf0TcTSqIaFg6sENDwGdymlnD+rvcAn9jpkN0?=
 =?us-ascii?Q?dgu4Bl2jAfrV6v21JRU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b396e06d-058d-40fd-f8a3-08dc90d7f331
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:20:35.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/rqjbLjD6i2I3lv7qi3OSpboZz+oYU8RCZTz4UqMJyt6FRPB+MNRJ2jTwFeddA/hBwFCd+96TQgkViQyxlExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8210

> Subject: Re: [PATCH v4 4/6] firmware: arm_scmi: add initial support for
> i.MX MISC protocol
>=20
> On Fri, May 24, 2024 at 04:56:46PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 System Manager(SM) firmware includes a SCMI vendor
> protocol,
> > SCMI MISC protocol which includes controls that are misc
> > settings/actions that must be exposed from the SM to agents. They
> are
> > device specific and are usually define to access bit fields in various
> > mix block control modules, IOMUX_GPR, and other General Purpose
> > registers, Control Status Registers owned by the SM.
> >

.....
> > +
> > +static int scmi_imx_misc_ctrl_validate_id(const struct
> scmi_protocol_handle *ph,
> > +					  u32 ctrl_id)
> > +{
> > +	struct scmi_imx_misc_info *mi =3D ph->get_priv(ph);
> > +
> > +	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi-
> >nr_dev_ctrl))
> > +		return -EINVAL;
> > +	if (ctrl_id >=3D BRD_CTRL_START_ID + mi->nr_brd_ctrl)
> > +		return -EINVAL;
>=20
> ...are these conditions fine ?

Yes. they are correct.

 just checking because they seem a bit
> odd...but I am certainly missing something...in case they are ok, is it
> possible to add a comment explaining why those conds lead to -
> EINVAL ?

We have a flag "MISC_CTRL_FLAG_BRD  0x8000U" to indicate it is
board ctrl or non-board ctrl

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_notify(const struct
> scmi_protocol_handle *ph,
> > +				     u32 ctrl_id, u32 evt_id, u32 flags)
> {
> > +	struct scmi_imx_misc_ctrl_notify_in *in;
> > +	struct scmi_xfer *t;
> > +	int ret;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph,
> SCMI_IMX_MISC_CTRL_NOTIFY,
> > +				      sizeof(*in), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	in =3D t->tx.buf;
> > +	in->ctrl_id =3D cpu_to_le32(ctrl_id);
> > +	in->flags =3D cpu_to_le32(flags);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +scmi_imx_misc_ctrl_set_notify_enabled(const struct
> scmi_protocol_handle *ph,
> > +				      u8 evt_id, u32 src_id, bool enable)
> {
> > +	int ret;
> > +
> > +	/* misc_ctrl_req_notify is for enablement */
> > +	if (enable)
> > +		return 0;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_notify(ph, src_id, evt_id, 0);
> > +	if (ret)
> > +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] -
> ret:%d\n",
> > +			evt_id, src_id, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_get_num_sources(const struct
> > +scmi_protocol_handle *ph) {
> > +	return GENMASK(15, 0);
> > +}
>=20
> This is statically defined at compile time..you dont need to provide this
> method, which is just for discover number of possible event sources at
> runtime....just drop it and use .num_sources in scmi_protocol_events
>=20


I see. Fix in v5.

> > +
> > +static void *
> > +scmi_imx_misc_ctrl_fill_custom_report(const struct
> scmi_protocol_handle *ph,
> > +				      u8 evt_id, ktime_t timestamp,
> > +				      const void *payld, size_t payld_sz,
> > +				      void *report, u32 *src_id)
> > +{
> > +	const struct scmi_imx_misc_ctrl_notify_payld *p =3D payld;
> > +	struct scmi_imx_misc_ctrl_notify_report *r =3D report;
> > +
> > +	if (sizeof(*p) !=3D payld_sz)
> > +		return NULL;
> > +
> > +	r->timestamp =3D timestamp;
> > +	r->ctrl_id =3D p->ctrl_id;
> > +	r->flags =3D p->flags;
> > +	if (src_id)
> > +		*src_id =3D r->ctrl_id;
> > +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
> > +		r->ctrl_id, r->flags);
> > +
> > +	return r;
> > +}
> > +
> > +static const struct scmi_event_ops scmi_imx_misc_event_ops =3D {
> > +	.get_num_sources =3D scmi_imx_misc_ctrl_get_num_sources,
> drop
>=20
> > +	.set_notify_enabled =3D scmi_imx_misc_ctrl_set_notify_enabled,
> > +	.fill_custom_report =3D scmi_imx_misc_ctrl_fill_custom_report,
> > +};
> > +
> > +static const struct scmi_event scmi_imx_misc_events[] =3D {
> > +	{
> > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL,
> > +		.max_payld_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_payld),
> > +		.max_report_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_report),
> > +	},
> > +};
> > +
> > +static struct scmi_protocol_events scmi_imx_misc_protocol_events
> =3D {
> > +	.queue_sz =3D SCMI_PROTO_QUEUE_SZ,
> > +	.ops =3D &scmi_imx_misc_event_ops,
> > +	.evts =3D scmi_imx_misc_events,
> > +	.num_events =3D ARRAY_SIZE(scmi_imx_misc_events),
>=20
> 	.num_sources =3D MAX_MISC_CTRL_SOURCES,  // GENMASK(15,
> 0)
>=20
> > +};
> > +
> > +static int scmi_imx_misc_protocol_init(const struct
> > +scmi_protocol_handle *ph) {
> > +	struct scmi_imx_misc_info *minfo;
> > +	u32 version;
> > +	int ret;
> > +
> > +	ret =3D ph->xops->version_get(ph, &version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> > +		 PROTOCOL_REV_MAJOR(version),
> PROTOCOL_REV_MINOR(version));
> > +
> > +	minfo =3D devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> > +	if (!minfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_imx_misc_attributes_get(ph, minfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ph->set_priv(ph, minfo, version); }
>=20
> Same as previous patch please move the init downb below near the
> scmi_protocol struct right after the ops
>=20


Yeah. Fix in v5.

> > +
> > +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle
> *ph,
> > +				  u32 ctrl_id, u32 *num, u32 *val) {
> > +	struct scmi_imx_misc_ctrl_get_out *out;
> > +	struct scmi_xfer *t;
> > +	int ret, i;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET,
> sizeof(u32),
> > +				      0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	put_unaligned_le32(ctrl_id, t->tx.buf);
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		out =3D t->rx.buf;
> > +		*num =3D le32_to_cpu(out->num);
>=20
> To stay even more safer, by guarding from malformed *num fields and
> just bail out upfront with an error
>=20
> 	if (*num >=3D MISC_MAX_VAL ||
> 	    *num * sizeof(__le32) > t->rx.len - sizeof(__le32))
>=20
> and then just
>=20
> 		for (i =3D 0; i < *num; i++)
>=20

ok. looks good. I will fix in v5.

> > +		for (i =3D 0; i < *num && i < MISC_MAX_VAL; i++)
> > +			val[i] =3D le32_to_cpu(out->val[i]);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle
> *ph,
> > +				  u32 ctrl_id, u32 num, u32 *val) {
> > +	struct scmi_imx_misc_ctrl_set_in *in;
> > +	struct scmi_xfer *t;
> > +	int ret, i;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (num > MISC_MAX_VAL)
> > +		return -EINVAL;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET,
> sizeof(*in),
> > +				      0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	in =3D t->tx.buf;
> > +	in->id =3D cpu_to_le32(ctrl_id);
> > +	in->num =3D cpu_to_le32(num);
> > +	for (i =3D 0; i < num; i++)
> > +		in->value[i] =3D cpu_to_le32(val[i]);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct scmi_imx_misc_proto_ops
> scmi_imx_misc_proto_ops =3D {
> > +	.misc_ctrl_set =3D scmi_imx_misc_ctrl_set,
> > +	.misc_ctrl_get =3D scmi_imx_misc_ctrl_get,
> > +	.misc_ctrl_req_notify =3D scmi_imx_misc_ctrl_notify, };
> > +
> > +static const struct scmi_protocol scmi_imx_misc =3D {
> > +	.id =3D SCMI_PROTOCOL_IMX_MISC,
> > +	.owner =3D THIS_MODULE,
> > +	.instance_init =3D &scmi_imx_misc_protocol_init,
> > +	.ops =3D &scmi_imx_misc_proto_ops,
> > +	.events =3D &scmi_imx_misc_protocol_events,
> > +	.supported_version =3D SCMI_PROTOCOL_SUPPORTED_VERSION,
> > +	.vendor_id =3D "NXP",
> > +	.sub_vendor_id =3D "i.MX95 EVK",
> > +};
> > +module_scmi_protocol(scmi_imx_misc);
> > diff --git a/include/linux/scmi_imx_protocol.h
> > b/include/linux/scmi_imx_protocol.h
> > index e59aedaa4aec..e9285abfc191 100644
> > --- a/include/linux/scmi_imx_protocol.h
> > +++ b/include/linux/scmi_imx_protocol.h
> > @@ -13,8 +13,14 @@
> >  #include <linux/notifier.h>
> >  #include <linux/types.h>
> >
> > +#define SCMI_PAYLOAD_LEN	100
> > +
> > +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) /
> sizeof(Y))
> > +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
> >
> You base all of this on this fixed payload length, but the payload really
> depends on the configured underlying transport: you can use the
> ph->hops->get_max_msg_size to retrieve the configured max payload
> length
> for the platform you are running on....nad maybe bailout if the
> minimum size required by your protocol is not available with the
> currently configured transport...wouldnt't be more robust and reliable
> then builtin fixing some payload ?

Your point is valid. But I need check our firmware design and see
if feasible and update.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

