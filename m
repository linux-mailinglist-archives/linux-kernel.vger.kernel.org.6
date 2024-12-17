Return-Path: <linux-kernel+bounces-449191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578369F4B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3662D7A1532
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6E1F37AC;
	Tue, 17 Dec 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SipIxAbe"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD91F03D5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439725; cv=fail; b=BUDWVp2HhcBFjcVtKpgS7AvW0vFh3fjNNhVr4m7T1y8aqIfc0evz3CzMSOMWljLcvYBdGUhdSBeJAWtV06lE2v8KhqfQ/2S9rC5E00sArymXHd7/51ZnMq6KFoisHyL7krbHYt0g4JOR5/06YC9b1UvifLSpJzD80LwJ/aKNwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439725; c=relaxed/simple;
	bh=IjeoggX1+9qy6kiC54wl1mNT2nJnZq7H/fEJTvQEgd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhSzpJgMiatEx/NDy1cxmLly+u3jDKLCNjzJaxinobJaPRqLLeT0UmU0/mZRnmtAcL3YyEg3ZqvWbyqFhNU4bLN+20xcxYgi7mMfiJGGjYqJo7LSasZ7e9sXbWvclnAewUORf3qS0E3aaF7Y8RjasfzB5wOgj1kjhP3uLTLNLYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SipIxAbe; arc=fail smtp.client-ip=40.107.241.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf4c+dk97OOkwKTS3/axtRyoDPCE0FjRg7KavcXSS5l3uvPpi6so9YVhKiS3CDg+tjUHQROYtNPBnxjB+WlUhi913laUZnEdy80o5PE8jiGttw4b/kKN0tqhJV3DmQIIYuIEWMwOixzu0rk8aqgLEJmr/hCVSYF+B/wkEk+zLvRoFwquAiX+KTeyv1sH+XZoP6GMM5ng8sN962ETIIojNiVHygsVcPo1FmwpEiTQVvFe6wg3MfckWAMIwWZi3gZsbQCjTDeUUrHeHeYCmaIpHiZOSTg1VDrGSP0dAZXKk4w4lZVhqrtad8t9jmdoTpNH/aGph2ORvBNfZ7OCJfqBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVFFrlr9VHkg0weFNiRaaF8/RkIXIM9JP5VaTND/I4Y=;
 b=FoLdrVcCLHs19+M8+eMDO6ec4zYZW8jrdVU+YPcEd3ozEYDkbitqlL/eCk/BauKMvulj0Dv7ZA0ZcLpNkHSk+hWfXpLuJE0bur4N5OXCN3koihGRljTGzY+Yls1O426Vs8WJvx6u7t165ZQ9uGpEjDm9DP+OAzQiQ8Lb7Fep2qUdZoyKa2G+qtaGCLdjpdW8Uu1mRxcO299xA2CbhORsMATV7E69iZSEmKrsuUrDc2U4EbvMQZa7lS/ssKwvdsxDGXyRCE0dyRbxW6Iv2PnOtx2mcbSfiuTd+fT8eLjsKoeOFQE8Z2PHxjfAKoHD+WVThUp95n+4Q3sh494eobvKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVFFrlr9VHkg0weFNiRaaF8/RkIXIM9JP5VaTND/I4Y=;
 b=SipIxAbeXHlapmDS5EFwWLT9gPAEtrSG69qSbN5pBs218lBhlDBetBpQ47IZe5b1eD0WI6IB8YKHDDFlBY/jY6yVL38boY1rnWZnyl54hLGKKYZ2Nm8dyMUOhO3G7v8RsNPW51m4ybtR9q8Dr5AAprNfsQH1JjGZK5dbEeS3U0UItbpm6Og07FIN+gZ/vC14LFGAId3aAxLM4uDy148SLsbuTqvRbFJUjqVLExEGpX4a9zufqQEcd1bKcw1cMVgJNNeKiOUoDBXRu/T5f5wyGYTxP+5LcItpyZoMTzKw4venqlIscH/Os0wQGN9i0rWuYOZRrMl7ydP4Nux4zMDZ0g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10744.eurprd04.prod.outlook.com (2603:10a6:10:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 12:48:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 12:48:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"marex@denx.de" <marex@denx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] soc: imx8m: Add remove function
Thread-Topic: [PATCH V2] soc: imx8m: Add remove function
Thread-Index: AQHbUCc8cDc1WI1Wg0iGevKj2ikCS7LqGniAgAANlmCAABmEAIAAIWgQ
Date: Tue, 17 Dec 2024 12:48:38 +0000
Message-ID:
 <PAXPR04MB84594B482B89EE34A900A53E88042@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241217015826.1374497-1-peng.fan@oss.nxp.com>
 <20241217082637.i2ou6bbr3tc3uvof@pengutronix.de>
 <PAXPR04MB8459A91EEC932F41E24AE04488042@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241217104634.2fc7yo6hprhx2wnt@pengutronix.de>
In-Reply-To: <20241217104634.2fc7yo6hprhx2wnt@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10744:EE_
x-ms-office365-filtering-correlation-id: 13a4fbe4-671b-448a-4241-08dd1e99209f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+dZsHtGXmA8sYyUukKkLSfrOXBQCIJdYVRMlEwUTU1m5YCykyoOrczLjR1pl?=
 =?us-ascii?Q?he0duTHp2NeHRKflgVdps/vkH/4gGU5w2OaeN1Dg1c7Gv1u36t9w5BlkZQvw?=
 =?us-ascii?Q?iMGTKnY2NCWc1h3+JJvrdPacDaLiuAh4W3O01vmB0MuQvg+zoEcS0+hm5+Dx?=
 =?us-ascii?Q?njWbGZAgTqgLSOhlplduBPsmaqK4Bj2NA0K6VhEnM3YbDqxrIMULDd08CCfT?=
 =?us-ascii?Q?TOSIEYKvIeCfgUcBVYSWB6cleg/8gNnze/+dqFVBz5a1TwV9/LiZTEiVFTeX?=
 =?us-ascii?Q?zh3gaIUbDYxJHk+COejJIIc7jLHW/JvaFu7oO74Sg72xVOVMiqmiJYjp8Bo3?=
 =?us-ascii?Q?RSSDmS3+0NswtHnq4tPb8xo+ZVLhYvDJwESsGefq3cSIRBwPlbxc6juTbWwO?=
 =?us-ascii?Q?hXZrOPXWl+CGlNIJbZN2oxzpX+AbzEEuR970kbuWHzhsx8SQy/vBIgdHf/1a?=
 =?us-ascii?Q?ikjFrOuTKK5+Tt718DLeWyNyn3Fo60ChV3XOoK9ZssX4xRlhVL4s+rlSFC6K?=
 =?us-ascii?Q?BYFMFE57Gq/ly1R5UbwuNl0KLlMfQ/VYMm2Fz7UlFbjjgePfMwf5HoDASZC9?=
 =?us-ascii?Q?cu1xNU5GDhcdsCYRIzgCX0Juk5S/oYSLXZjPbgTnm8RyQsBjLQ3P1z3GTrxo?=
 =?us-ascii?Q?5nIeZ4nyFeqarqGwq3DA145cDyoD496qag61J9QxnBiGCUcqqxn8VJ6lqlZZ?=
 =?us-ascii?Q?eMEwCWgi6y69vHfM7LGFmGYmKHIdDO41sndQCQYWfXhcpyah85ymv2mCDUKv?=
 =?us-ascii?Q?YEJI1ztzZIbjJZvDnlQusWN/rtxWUS4rVlLtEwXro0+wWt6XMbrgZevw5mSP?=
 =?us-ascii?Q?GpV38JAu14hYbEAoumeX8QXfRbI48GOjSzkBscf7HGoi8DaYAEeOhqTPU8oo?=
 =?us-ascii?Q?4J9rR2YnhY/eOQrycvmFoCrWmY1pAhMmrrx2HtgeyoVHIoDs78g34wmqgg28?=
 =?us-ascii?Q?qRaOJIDTlEl3um7wSBRQyyNh7HkPnJGUyNRNRPvbTfXEH2osZDW3z+l1FTCM?=
 =?us-ascii?Q?92DI8dgYomRpAeu6I9OTYK/qqCTYktchLVWB8RVscta7bAWw+cKYu0CKO3Yb?=
 =?us-ascii?Q?WBMGvXduuz1XpVAJVaUo/XrHpRzB91c0/DhfLY9rXVQX931n4pHyWkQi8wzy?=
 =?us-ascii?Q?dn/juRuO43YRL3o0/Jl99SxZm+3Q+BLDhlEJVpy06dsOD9rpWpqJdeL7qGEm?=
 =?us-ascii?Q?2TContyxmEExd4ZGHf/eYGqU+uw1MhRWOg5PWWBLrtfZ7oHJr6mIt/2tq6xr?=
 =?us-ascii?Q?C4rAugoRPUuQ0JsVov12G+fAPkZ2wGWHbnaRGgAAHTLlwlL+pG+Yj6tG6fln?=
 =?us-ascii?Q?2Yal9Wmh8wiNau4ShheE8AC3knqomNv4pE+iLMpQeVPYLgTW2RM+bwWtGIrk?=
 =?us-ascii?Q?o+O3J7w0OcmsfptIvp8S+pI2jdhl/woBdLBrOg+YCTUbZPo5Qbm67Uti5k4C?=
 =?us-ascii?Q?uKISOO9rQLnzXbtJgTLNSUri3A8NOvvB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y/RrzcKDDXxe/SmcQY2Yo5UQQdsCxivgZhWrl6CsQi4g9BuQZPmUWV9l2H2J?=
 =?us-ascii?Q?dqwCOjw3rs6BX+9eYwjuu/wBDfeQ/kfCJTQ6hVONACpZoZ0gcwRWJtfQyjxs?=
 =?us-ascii?Q?w740O6+s82XY7WuCEx2hr4gLDC/WTOqRZBS4va4bEc80QOsETubTOQ4fCvFx?=
 =?us-ascii?Q?0Q808zgsW8hl+LC2T3TCqimVyhULPkuJ/NlPwZGWRmLMwRsEbzd8xCrYyBo/?=
 =?us-ascii?Q?2/G69w4IlK1qsOMv4pal5zh+eodHjB98pw2fnPLcuL7ZDsPpSB6WDIusYlMj?=
 =?us-ascii?Q?ODr9PLTUHljm8vEImTZBbKXTuOoyeEzvhkjw0yUgUygKNJOZBjToMf6B0dt0?=
 =?us-ascii?Q?ZsrlobRrqZIeKfSQvZ0NOyDSBAgpViWlWM+/3f8XExBGZNGMTvnY1Zup6AnH?=
 =?us-ascii?Q?8cAa/zR6CD1JUXg0D/Pa7zDaEOM7negg0IYbpOZdwDs+vR82qjYxiRXYyhKe?=
 =?us-ascii?Q?WVK1ThULenXRwhir4dA6dblbtJhVhBh9w5rz3R0FkjRP4Lcd5ScsoK7FeLUD?=
 =?us-ascii?Q?sSQtLuV+exv55M+oq9NULqY6Df+qczZyhIU2Y9VG5AKtCXu5Ig+6YU9pW39u?=
 =?us-ascii?Q?AzgLGJOSkC3B7H9kSB3wZLDf9TXZLHo8TL4yofeoj9bdE+QPaCjhKotW2obA?=
 =?us-ascii?Q?e84PaJkNrKP4RriugeGAXKtZ9ooxoFB5BoWWj4FfD+EhQfqkOlAqGqSuRMTu?=
 =?us-ascii?Q?jRHFu3G6zMrxm4hNdSgdPTq55a0VyvIjuqfEzZVXEpuzObyGPL8h9mewL47g?=
 =?us-ascii?Q?R1vHn2BAgYNpG3M2Kpg5GpiK1R5thdJDSPpseMpkhbDSNYvFwwdozubgNX9B?=
 =?us-ascii?Q?3c3ck+nsr33nbwbaHzBF10tqtD5PWtdUpoJ+2tlibl8T4jG7BBZKuzFq52UZ?=
 =?us-ascii?Q?TnSHVYNAxGDR9rtHkKgtKJuMxAKpXJ5PFP155oX1dvQSMW24l9Pi4sb3YJdG?=
 =?us-ascii?Q?qHyAPSu2fzxNQcd0tEvuSoaoXTouCxnQXOPpKhZOtzeLxWFMZNXjTGTwSePF?=
 =?us-ascii?Q?xW33OxUM0ddM6YiEDaBeYRoOzBSK8BTCmZb4pHWXm5mhIq0CAL88LAbwZ1yT?=
 =?us-ascii?Q?Lms/dF9pAxGcGPtDBT7ZJv+hBrQqoOCKeeiSGuJD032REQQ3xoucKj+F0cH+?=
 =?us-ascii?Q?zTj+WScMPovItYdxy7GMt/G0HsZMbgVorefA9gY+4O3t6P47gtKJjYpTa0Xd?=
 =?us-ascii?Q?zLAyv+y5qsVxAklBSVL5hO7pOXVpPlfrCFoBvwVqqIenW1VTfUlMmxomq9E+?=
 =?us-ascii?Q?4VgQYg2DSF/QrD5Htp+Hs1j4sL4NxiYLhPJn8mz8T0NiptiXfLGt4ziJ5ruA?=
 =?us-ascii?Q?ouC71Cw95jv246WfAeYRZzps2Y8SaybP/iVua/b+fqrsRSOs34n2mCWdeFKs?=
 =?us-ascii?Q?K+5/gc/xyNVuJoAhtK2oGZPHJ0Ao68jtXc7YNjSG4It4m9x8OT88sz/Wr78I?=
 =?us-ascii?Q?rzlDN0Qn9dNSuslSjHKEb+ZECV2Aeiirboa2yTGT3/EZbJAG+EoUUzVCRt4Q?=
 =?us-ascii?Q?WRaEftH+YBOs36ajmznSJHp6hImaaYcthKbBr5yDG3jYHLsTJf5H7jKW4OGd?=
 =?us-ascii?Q?7voT/b2Zn17s0t43WPQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a4fbe4-671b-448a-4241-08dd1e99209f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 12:48:38.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9AfNsEwHZl7U7fV7MM7QDPFmccmC5WJmwHkWDD7OqLGa2xyi0rAewnSkL3davGJhv8BhKj5UjnpAMu/EAxxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10744

> Subject: Re: [PATCH V2] soc: imx8m: Add remove function
>=20
> On 24-12-17, Peng Fan wrote:
> > > Subject: Re: [PATCH V2] soc: imx8m: Add remove function
> > >
> > > Hi Peng,
> > >
> > > thanks for you patch.
> > >
> > > On 24-12-17, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Unregister the cpufreq device and soc device in remove path,
> > > otherwise
> > >
> > > After reconsidiering the patch approach, I think we shouldn't add a
> > > .remove() function and instead should make use of the
> > > devm_add_action() mechanism for the proper unregister calls.
> >
> > Would you please share why devm_add_action is preferred?
> >
> > Something as below?
> > +static void imx8m_soc_remove(void *data) {
> > +       struct imx8m_soc_priv *priv =3D data;
> > +
> > +       if (priv->cpufreq_dev)
> > +               platform_device_unregister(priv->cpufreq_dev);
> > +
> > +       soc_device_unregister(priv->soc_dev);
> > +}
>=20
> I would split it into two action functions due to the following reasons:
>  - cleanup during the probe() if something fails afterwards
>  - no need for the if(priv->cpufreq_dev) check.
>=20
> > In Probe:
> > +       return devm_add_action(&pdev->dev, imx8m_soc_remove,
> priv);
>=20
> The actions should be added directly after the succeful device
> registration, e.g.
>  - after soc_device_register(soc_dev_attr) and
>  - after platform_device_register_simple()

With two devm_add_action, I thought below code would work,
devm_add_action(dev, soc_device_unregister, (void *)soc_dev);
devm_add_action(dev, platform_device_unregister, (void *)cpufreq_dev);

But devm_add_action expects: void (*action)(void *),
So I need introduce two functions to wrap soc_device_unregister,
and platform_device_unregister.

This seems not good. Using one devm_add_action just need
one wrap function, comments?

Thanks,
Peng.

>=20
> Regards,
>    Marco
>=20
> >
> > Regards,
> > Peng.
> >
> > >
> > > > there will be warning when do removing test:
> > > > sysfs: cannot create duplicate filename '/devices/platform/imx-
> > > cpufreq-dt'
> > > > CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > > > 6.13.0-rc1-next-20241204 Hardware name: NXP i.MX8MPlus EVK
> > > board (DT)
> > > >
> > > > Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as
> platform
> > > > driver")
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Add err check when create the cpufreq platform device
> > >
> > > thank you for addressing this.
> > >
> > > Regards,
> > >   Marco
> > >
> > > >  drivers/soc/imx/soc-imx8m.c | 41
> > > > +++++++++++++++++++++++++++++++------
> > > >  1 file changed, 35 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-
> > > imx8m.c
> > > > index 8ac7658e3d52..97c8718c2aa1 100644
> > > > --- a/drivers/soc/imx/soc-imx8m.c
> > > > +++ b/drivers/soc/imx/soc-imx8m.c
> > > > @@ -33,6 +33,11 @@ struct imx8_soc_data {
> > > >  	int (*soc_revision)(u32 *socrev, u64 *socuid);  };
> > > >
> > > > +struct imx8m_soc_priv {
> > > > +	struct soc_device *soc_dev;
> > > > +	struct platform_device *cpufreq_dev; };
> > > > +
> > > >  #ifdef CONFIG_HAVE_ARM_SMCCC
> > > >  static u32 imx8mq_soc_revision_from_atf(void)
> > > >  {
> > > > @@ -195,10 +200,11 @@ static __maybe_unused const struct
> > > of_device_id
> > > > imx8_soc_match[] =3D {  static int imx8m_soc_probe(struct
> > > > platform_device *pdev)  {
> > > >  	struct soc_device_attribute *soc_dev_attr;
> > > > +	struct platform_device *cpufreq_dev;
> > > >  	const struct imx8_soc_data *data;
> > > >  	struct device *dev =3D &pdev->dev;
> > > >  	const struct of_device_id *id;
> > > > -	struct soc_device *soc_dev;
> > > > +	struct imx8m_soc_priv *priv;
> > > >  	u32 soc_rev =3D 0;
> > > >  	u64 soc_uid =3D 0;
> > > >  	int ret;
> > > > @@ -207,6 +213,10 @@ static int imx8m_soc_probe(struct
> > > platform_device *pdev)
> > > >  	if (!soc_dev_attr)
> > > >  		return -ENOMEM;
> > > >
> > > > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > +	if (!priv)
> > > > +		return -ENOMEM;
> > > > +
> > > >  	soc_dev_attr->family =3D "Freescale i.MX";
> > > >
> > > >  	ret =3D of_property_read_string(of_root, "model",
> > > > &soc_dev_attr->machine); @@ -235,21 +245,40 @@ static int
> > > imx8m_soc_probe(struct platform_device *pdev)
> > > >  	if (!soc_dev_attr->serial_number)
> > > >  		return -ENOMEM;
> > > >
> > > > -	soc_dev =3D soc_device_register(soc_dev_attr);
> > > > -	if (IS_ERR(soc_dev))
> > > > -		return PTR_ERR(soc_dev);
> > > > +	priv->soc_dev =3D soc_device_register(soc_dev_attr);
> > > > +	if (IS_ERR(priv->soc_dev))
> > > > +		return PTR_ERR(priv->soc_dev);
> > > >
> > > >  	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
> > > >  		soc_dev_attr->revision);
> > > >
> > > > -	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> > > > -		platform_device_register_simple("imx-cpufreq-dt", -1,
> > > NULL, 0);
> > > > +	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
> > > > +		cpufreq_dev =3D platform_device_register_simple("imx-
> > > cpufreq-dt", -1, NULL, 0);
> > > > +		if (!IS_ERR(cpufreq_dev))
> > > > +			priv->cpufreq_dev =3D cpufreq_dev;
> > > > +		else
> > > > +			dev_err(dev, "Failed to create imx-cpufreq-
> > > dev device: %ld",
> > > > +				PTR_ERR(cpufreq_dev));
> > > > +	}
> > > > +
> > > > +	platform_set_drvdata(pdev, priv);
> > > >
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static void imx8m_soc_remove(struct platform_device *pdev) {
> > > > +	struct imx8m_soc_priv *priv =3D platform_get_drvdata(pdev);
> > > > +
> > > > +	if (priv->cpufreq_dev)
> > > > +		platform_device_unregister(priv->cpufreq_dev);
> > > > +
> > > > +	soc_device_unregister(priv->soc_dev);
> > > > +}
> > > > +
> > > >  static struct platform_driver imx8m_soc_driver =3D {
> > > >  	.probe =3D imx8m_soc_probe,
> > > > +	.remove	=3D imx8m_soc_remove,
> > > >  	.driver =3D {
> > > >  		.name =3D "imx8m-soc",
> > > >  	},
> > > > --
> > > > 2.37.1
> > > >
> > > >
> > > >
> >

