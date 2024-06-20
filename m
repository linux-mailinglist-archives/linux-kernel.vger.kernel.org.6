Return-Path: <linux-kernel+bounces-222683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C49105A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F76D1F26975
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62901ACE92;
	Thu, 20 Jun 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NkabB94j"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04A1E49E;
	Thu, 20 Jun 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889436; cv=fail; b=s7yirjt1vh/Nrb9cG4h5yKDyvlhxS2hqgsM4ST+MFK1ATuFJ24Mx2/cRRL9PuykBem3HeZBiB8sd/WtKMfkBrFj6MN44kzESNf0s8MeJ9RcUJukdyfB0A8gENtZTNVQwSuWThsVjWRkMbqNfnfa8B7m/yiVqjQuj8sCyOZNDlYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889436; c=relaxed/simple;
	bh=VGxvG2y/qaH2vE+REEynWIh1FOOVxLKNR2vjPm78qGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tom/O5wt4whRmhwskH4iKf4xtcN0CJ8cCitv9XG+jWaMkpsic+iIbdP46h3apci8YN5R0ZTAsfMPuKFRbUkQyt1DFHQvvADBm86dw+q0qqMl0j0flHK3SEPGYvabzlaIZmsZNP4Dcq8dya+nqYDOM2SCt2O2lFoh1xkFNlGxV9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NkabB94j; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHRg2ecHulxiwhrC1+pp8vyHCapohBBKaSNKEalC0r3tUHseH48EA0CLHZr8XBIzIMUxmlDZA3GWFgbG4lqohII7M0fmW4KaQXOZXIcnUm7xYENM+ipUINFzxK8Quk7QhRqa4ClNWO50guLuuhjKD/3b7AkpblP5VRSEhH6gOCbZWskz+XXQTzLR4sfxCvWehw0dHG/BVa7OacSgbwLgwEXsVaSJJLtggAlolqvPPuLWcZ/d5vJnj1rTyQ7xDA6OeVPFe0CMWlVH/FYsoYGpP1k0AfOBQ0MuxaAUGiCeUG01Ddr1pzTOO19zzQ0gS2jpu3hwTK1+6HEnYMvYBwyiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns0CKJtvxE7Mktvh8RCiVwj1fTXL+laetSf2yGshRGs=;
 b=gRY78hM6vxJjmKusGeWah7sZN7kp+8fIITTP/cYI+0HF+fZg1oUKygckEuTupn4WYMYX/3oqxQ36fxZmUnnIQ0e3LEwdatYw8lAlmfCceWRJZFOD8+f4G+CRG3Wm4w1psH289u8M1Kpa43kGuFaBaloyIQjlOq17Jg468me4EWtp4EuWKtQvT13xnRs+Ib5nzubWSmr7LUtAnf1JIlr5f7Zkb8It7fkXdazrHRrOKQPqzubsY8543hj2RV23H7NIMRMiPUwI+3qtJw87dSeE+hy8PC3+b54bYM3/1ryAYm5/1W+Y1NISC7FCL6oKXjJGOZauVQJCIUOYeZSQQEQwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns0CKJtvxE7Mktvh8RCiVwj1fTXL+laetSf2yGshRGs=;
 b=NkabB94jEsEounMaVPSYjF12tlTwvOnUEVPBakreRLg5R/a+bskMvtLEJlx2r77fae/70hEjxiLNGoX8h+ORDsCBMeekT7qYSEFPcYHO0sH2+jwN/+D2ewYubPMJ9OKsH+iIZYPyOENcpRiTaI/0FW7M2yZIyN5xZLDve6ld+KM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM9PR04MB8921.eurprd04.prod.outlook.com (2603:10a6:20b:408::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 13:17:10 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 13:17:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 4/5] firmware: imx: support BBM module
Thread-Topic: [PATCH 4/5] firmware: imx: support BBM module
Thread-Index: AQHaVaFXyGFz8Dn2ZE22sFi/LtPU2LEYXMCAgLkSy6A=
Date: Thu, 20 Jun 2024 13:17:09 +0000
Message-ID:
 <AM6PR04MB5941958C71C04525760CF38388C82@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com> <ZdjgSxFx9YRP107y@pluto>
In-Reply-To: <ZdjgSxFx9YRP107y@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM9PR04MB8921:EE_
x-ms-office365-filtering-correlation-id: aaec98ee-0cbf-4386-6d18-08dc912b4a91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w5zfIRkZdtOegTxVqjGbPGQW9LiUsajWuelPniiK5bUW5KQH43p7r0hdXLgi?=
 =?us-ascii?Q?scVWVFrloqTgy/ue5J9dWLxM/9yEpbpzwl989DKaHqovf3Ug2L0PYRbfT7aR?=
 =?us-ascii?Q?wZFDuKAVaIMVt8n+atjs7zHy7DoHO4I24MPxyxli+pleHPPjVS5FE381As4a?=
 =?us-ascii?Q?0+KdCCBMSLyQeMlnsbABsDy0NxW14hLG03VR3lQKvu/qGXFxtbXcCrfvliC5?=
 =?us-ascii?Q?2LgGLVTi2c/YhW3xARsXArdR1qdF9X6vAOTyjXHamt4ukWI8FSoRtjMoGKZx?=
 =?us-ascii?Q?qdTWJ0LACYg3AlCgZB9MoXOLXQmjfGWSScWRTFjt+YHhmZzKmdX22ImWIb6A?=
 =?us-ascii?Q?kEvcD0bg8DF4LR6zSurIPnsk3WkQuluTJ/C9MjHxBiu3WkMcQ5buav9Ee+Mn?=
 =?us-ascii?Q?fnDCM5pfmkfp53sgdvJ/vT89hXWkenfUP8Uz7/140nLa9Vj0mWNPwnJuZ3tq?=
 =?us-ascii?Q?bbf+bj6WbxwkDxF9KML2hLhn9/x3wisgXF2aT61OspGM3R5+IoOHXnKWWniF?=
 =?us-ascii?Q?Z4e1s1rAUlixC/FEZ9rwH3pt4uzR7a/xo05XPOLfW4c16sdJPHCUjwoRFqZm?=
 =?us-ascii?Q?YPe/2x5ZtPPUCSYo3t2mhZFACxIrMJiLHbEOJT4y6iO9IguRjC5r/md6OLaV?=
 =?us-ascii?Q?FaEKtPLsaDao23HnvlnuW7M9sFMRDuGAwmXiRx7QqH/BQ33OK5iV5vYR9Pd7?=
 =?us-ascii?Q?MRLitgevHXSbksfET6NfonthAaUI5eDRtC1dMfpT9jr8fEK2M4nHSgA2g8u5?=
 =?us-ascii?Q?NHYedu//fYqVqhD9lqEeQSpZWb15LZ6gCw0bCSjvK3cAbpOGR79/5mPw0LLd?=
 =?us-ascii?Q?7TGAU6kkXKJLv+zl69VYTW1w/Fq7Vt+dCeZJlcKmQnWaafwFfNrIdHRRaKmR?=
 =?us-ascii?Q?pccKjzObueci57qgztON2g+YZyIsuAwCp3d3QpEUZielhELHUhL7iUF1V+QQ?=
 =?us-ascii?Q?AoGO0up+RANAa8zNKFXrEk/N/qmWBKVvwf7zhFyrkZ2hVmOu1NbvDA6qq++G?=
 =?us-ascii?Q?zlm5GfF2NpWvnt3XwBitwh6xKxLEmljRHzSZejpL2pQbDcSinZCbqz3HMUvj?=
 =?us-ascii?Q?XHUr60U3u4OZ4WBmd4U2zL009bFWupBtnXtPVBvcUaOtNFXSKqXCyI11Q7Zn?=
 =?us-ascii?Q?V5q/0KOAUK4HIN5SiGb3VS89zYTS/Q+30ovjBQpRX08i/EA8QnAVP0It6Cgm?=
 =?us-ascii?Q?TMn6hbmCgZ03eL7lGdyQrzqOZn8AB3wbqxmPnb3LfEaVCYh8WA6ZbCtVT3vS?=
 =?us-ascii?Q?oqocCyBMCJOIIJSQXtkeW87vMJe9EVnTpgzABYgMFCwTqWKHMaeR6c0sNkBo?=
 =?us-ascii?Q?/195XnneAo1GsgWTUi18IoleBbl140paW2H+8Gr1xcmRzwsMfFymyToOw/dz?=
 =?us-ascii?Q?hHiuSGg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZVoQwfwV7TfRDOHIT8jx4PMhEaKHhdui2IMo3V89PvHWMgtrrleEfSzuQ+p0?=
 =?us-ascii?Q?PdG5MOmT/QMhyZSAonBx4loLss/VBFRYLT7yBQ2cNaZ8N5nGknnSbnHb6W6O?=
 =?us-ascii?Q?wX17HI0gPQd8JC2RRWzWlNhS4xnAACFS+FCcove5TW1HioQ6ytgJ79yHo+BE?=
 =?us-ascii?Q?FsbW+7OcdqMF1hL5uH7vNUZ/bvoy0ijrE8g+QL9UFMJabuuGIG6gTRUqoT8y?=
 =?us-ascii?Q?oWyLvNTRwT6NzGyWdkAUUs/xLjb8gEMsAwcW6VS9vOmkljeiCY3e08sOsxV7?=
 =?us-ascii?Q?FZByMe9iBMTDOX7p0iadn+VizCed8ofkiLGwsQR55EmR1fwFwm1Ex66Enwfy?=
 =?us-ascii?Q?K+GHws1ZlzFllZbO9uM/MdAG4F7s35W/o2kFJ6xtbnU45mfBblA6bOxndCmA?=
 =?us-ascii?Q?0n6FkfDGlucRIxlcFlbosocMAvG7T8ifaKO+qYhPyahAFWGCanCz/fM2fqSB?=
 =?us-ascii?Q?TXNNRe4YejiKIrhQ8qdqWJ6H0rT8zbeBgM+P+owm0u6QtOd/Bt2Y0Sw9qw95?=
 =?us-ascii?Q?OgHwqsmt4+hr7/UZXQCalL3XqGTUs94ZaT9M7g4epYKsyi1u/zflDRlNo5vw?=
 =?us-ascii?Q?DHlHWGl98RtosEg39UQUGfDZt5TMrXIlbOjnk/wv2oJzK/E0ZHBhu46P8MWG?=
 =?us-ascii?Q?CAmyrXEEQHdUf8u84qBIkIoYm+r0xPNT4NG6EV+sS6ZeA46x/BXZnuv9s8DL?=
 =?us-ascii?Q?PC4DLZ7c30jxzbtjMNgHLvTf6WAQaox70ggdDj346S2szM6D8s89G9v2THRM?=
 =?us-ascii?Q?AZjm6xQpi8ovdnTbystqGDqL/CrpCEimrbeBgMT466D5CMdgECbH/5feew69?=
 =?us-ascii?Q?+Q5Ma54Cu3XLRXxmjrNlYmyZj6Uv+3k6m5ZrpqJyrolSAd3esUEWES3tT9t8?=
 =?us-ascii?Q?U4XGoVYo97up6K7ePsAkhu45kvrSNNk9KYJ7UIYKc3tah+xs8N317z9b+8tG?=
 =?us-ascii?Q?ZTTPBZukkcNGvhN+1QRYL1YuTxoYDOsZh0HBug2CvE71Z1sIjnOXgYZRBOUP?=
 =?us-ascii?Q?4KQfH0VtT3ozSkN/UlRH4wf7IQ8ME32VQ+QUpsQBPg68M37j/geifEhonpZU?=
 =?us-ascii?Q?Emro/ktQ53kp5ybvVN4rSyv2/Pm7xjQDazOXK6pbyrXdFfzplZIsJHxUnoNf?=
 =?us-ascii?Q?B+DjpJ+f2dID3Y/fScEupA25DjgrDIRSAam1DWP5ZfPo6vpZuGG6LEiuhlT2?=
 =?us-ascii?Q?+VpwacKwdFI6GkkW7lHNHIyZEQetLNPnB6TeMLh+NI8p+ylKRRWyFcoNOI3q?=
 =?us-ascii?Q?WDFmZfusfU5WviaNez1I4mBu/MRRcfDtQ9ewvEdKPTIJ0dW22AnTDFd0oZkl?=
 =?us-ascii?Q?Pq3P1LXf/cPFltYvcp6UCo/GYbewzaAYyeQlcxK/swFMePkqH9txcDgAwPUg?=
 =?us-ascii?Q?XOoHdeqn5dHDmCbDR0ZK7WQsdhXYY/D0luNFWKt33OME2KBWsGPk2qhjM0fr?=
 =?us-ascii?Q?GOqCpQyYVxVs8YGEbPJQHJG0hfkvkfd9iP7Wu9PCCq62ZnNDyzYGm1ohNt1l?=
 =?us-ascii?Q?cEvZxj/wmvKO9kG8aNVSdY0HiZxieT2iT2QEollbtyo0TArCiNzXiLGUp35A?=
 =?us-ascii?Q?j6AgO2ltMX+TBE5sUJQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaec98ee-0cbf-4386-6d18-08dc912b4a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 13:17:10.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ii+/4eYkLxpPvA9PkWOIYsCqYWC3NlC4ptVhXSbH3uVG20mKVyZub7hQ92K5+StnyhOoBdmvJuLqe8tDGwj/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8921

Hi Cristian,

> Subject: Re: [PATCH 4/5] firmware: imx: support BBM module
>=20
....

> > +msecs_to_jiffies(DEBOUNCE_TIME));
> > +
> > +	/*
> > +	 * Directly report key event after resume to make no key press
> > +	 * event is missed.
> > +	 */
> > +	if (bbnsm->suspended) {
>=20
> So this bbnsm->suspended is checked here from inside the SCMI
> notifier and it is set by a couple of pm_ops you provide down below
> which are called by the core PM subsys, so is it not high likely that you
> could have issues with the order of such reads/writes ?
>=20
> Would it be worth to add a READ_ONCE here and WRITE_ONCE in the
> pm_ops...or I am overthinking ?

Just checked other input drivers, only two use READ_ONCE.
It might be good to avoid potential issues with READ/WRITE_ONCE.

Other comments will be addressed. BTW,
I will split rtc and pwr key into two drivers and put
them in input and rtc directory.

Thanks,
Peng

>=20
> > +		bbnsm->keystate =3D 1;
> > +		input_event(input, EV_KEY, bbnsm->keycode, 1);
> > +		input_sync(input);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void scmi_imx_bbm_pwrkey_act(void *pdata) {
> > +	struct scmi_imx_bbm *bbnsm =3D pdata;
> > +
> > +	cancel_delayed_work_sync(&bbnsm->check_work);
> > +}
> > +
> > +static int scmi_imx_bbm_notifier(struct notifier_block *nb, unsigned
> > +long event, void *data) {
> > +	struct scmi_imx_bbm *bbnsm =3D container_of(nb, struct
> scmi_imx_bbm, nb);
> > +	struct scmi_imx_bbm_notif_report *r =3D data;
> > +
> > +	if (r->is_rtc)
> > +		rtc_update_irq(bbnsm->rtc_dev, 1, RTC_AF |
> RTC_IRQF);
> > +	if (r->is_button) {
> > +		pr_debug("BBM Button Power key pressed\n");
> > +		scmi_imx_bbm_pwrkey_event(bbnsm);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev) {
> > +	const struct scmi_handle *handle =3D sdev->handle;
> > +	struct device *dev =3D &sdev->dev;
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +	struct input_dev *input;
> > +	int ret;
> > +
> > +	if (device_property_read_u32(dev, "linux,code", &bbnsm-
> >keycode)) {
> > +		bbnsm->keycode =3D KEY_POWER;
> > +		dev_warn(dev, "key code is not specified, using
> default KEY_POWER\n");
> > +	}
> > +
> > +	INIT_DELAYED_WORK(&bbnsm->check_work,
> > +scmi_imx_bbm_pwrkey_check_for_events);
> > +
> > +	input =3D devm_input_allocate_device(dev);
> > +	if (!input) {
> > +		dev_err(dev, "failed to allocate the input device for
> SCMI IMX BBM\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	input->name =3D dev_name(dev);
> > +	input->phys =3D "bbnsm-pwrkey/input0";
> > +	input->id.bustype =3D BUS_HOST;
> > +
> > +	input_set_capability(input, EV_KEY, bbnsm->keycode);
> > +
> > +	ret =3D devm_add_action_or_reset(dev,
> scmi_imx_bbm_pwrkey_act, bbnsm);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register remove action\n");
> > +		return ret;
> > +	}
> > +
> > +	bbnsm->input =3D input;
> > +
> > +	ret =3D handle->notify_ops->devm_event_notifier_register(sdev,
> SCMI_PROTOCOL_IMX_BBM,
> > +
> SCMI_EVENT_IMX_BBM_BUTTON,
> > +							       NULL,
> &bbnsm->nb);
>=20
> So you are registering for another SCMI event but you want to use the
> same callback and notifier_bock to handle different events, BUT
> internally the SCMI core creates a DISTINCT kernel regular notification
> chain for each event and each resource (or one for ALL resources of an
> event) against which a
> devm_event_notifier_register() has been called AND so, being a
> notification_chain the notifier_blocks that you provide MUST be
> distinct, because the notification chain is indeed a simply-linked list
> and so when you register bbnsm->nb the second time you will indeed
> add the nb to another list at the same....
>=20
> ...thing which I suppose could work in your case since you have only
> nb/callback per event BUT as soon as you (or someone else) will try to
> register another nb for these same events the 2 notification chains will
> start melting together....
>=20
> ...and it will be a hell to debug...
>=20
> so IOW...even if it works now for you, please use 2 distinct nb_pwr.
> nb_rtc notifier blocks with 2 distinct callbacks (to be able to use
> container_of in
> them) to register to 2 distinct events...you can register for multiple
> sources using only one nb BUT you cannot register for multiple events
> using the same nb/callback as of now.
>=20
> With this internal design the queues and the worker threads
> dispatching these notifs are dedicated to a single event and possible to
> a single event/resource...
> ...no event ever queues behind any other...
>=20
> This probably would need better clarification in the SCMI docs, my bad,
> and maybe a new option to register for ANY event the same nb (like
> you can do with src_id if you dont specify one), IF you are fine with the
> possibility that your events notification will be serialized in a single
> queue.
>=20
> > +
> > +	if (ret)
> > +		dev_err(dev, "Failed to register BBM Button
> Events %d:", ret);
> > +
>=20
> So why not failing if you could NOT register the notifications ?
>=20
> > +	ret =3D input_register_device(input);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register input device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_bbm_rtc_init(struct scmi_device *sdev) {
> > +	const struct scmi_handle *handle =3D sdev->handle;
> > +	struct device *dev =3D &sdev->dev;
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	bbnsm->rtc_dev =3D devm_rtc_allocate_device(dev);
> > +	if (IS_ERR(bbnsm->rtc_dev))
> > +		return PTR_ERR(bbnsm->rtc_dev);
> > +
> > +	bbnsm->rtc_dev->ops =3D &smci_imx_bbm_rtc_ops;
> > +	bbnsm->rtc_dev->range_min =3D 0;
> > +	bbnsm->rtc_dev->range_max =3D U32_MAX;
> > +
> > +	ret =3D devm_rtc_register_device(bbnsm->rtc_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bbnsm->nb.notifier_call =3D &scmi_imx_bbm_notifier;
> > +	return handle->notify_ops->devm_event_notifier_register(sdev,
> SCMI_PROTOCOL_IMX_BBM,
> > +
> 	SCMI_EVENT_IMX_BBM_RTC,
> > +
> 	NULL, &bbnsm->nb);
>=20
> As said, this will get mixed up when pwrkey_init tries to register again
> the same nb for a different event...
>=20
> > +}
> > +
> > +static int scmi_imx_bbm_probe(struct scmi_device *sdev) {
> > +	const struct scmi_handle *handle =3D sdev->handle;
> > +	struct device *dev =3D &sdev->dev;
> > +	struct scmi_protocol_handle *ph;
> > +	struct scmi_imx_bbm *bbnsm;
> > +	int ret;
> > +
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	bbnsm =3D devm_kzalloc(dev, sizeof(struct scmi_imx_bbm),
> GFP_KERNEL);
>=20
> sizeof(*bbnsm)
>=20
> > +	if (!bbnsm)
> > +		return -ENOMEM;
> > +
> > +	bbnsm->ops =3D handle->devm_protocol_get(sdev,
> SCMI_PROTOCOL_IMX_BBM,
> > +&ph);
>=20
> proto ops can be global really..since are always the same pointer even
> if this is probed mutiple times... this could be
>=20
> 	bbnsm_ops =3D handle->devm_protocol_get(sdev,
> SCMI_PROTOCOL_IMX_BBM, &bbnsm->ph);
>=20
> with bbnsm_ops static global to this file
>=20
> > +	if (IS_ERR(bbnsm->ops))
> > +		return PTR_ERR(bbnsm->ops);
> > +
> > +	bbnsm->ph =3D ph;
> > +
> > +	device_init_wakeup(dev, true);
>=20
> Not fully familiar with this, but it seems to me that when this is issued
> some wakeup related sysfs entries are created too...so I suppose you
> want to disable this back on failure to have those entries removed.
>=20
> or maybe just move this right before the final return 0....but I am not
> sure if you want to have it called BEFORE the pwrkey notifier if
> registered or AFTER is fine too...potentially loosing some wakeup,
> though.
>=20
> > +
> > +	dev_set_drvdata(dev, bbnsm);
> > +
> > +	ret =3D scmi_imx_bbm_rtc_init(sdev);
> > +	if (ret) {
> > +		dev_err(dev, "rtc init failed: %d\n", ret);
>=20
> like ??
> 		device_init_wakeup(dev, false);
>=20
> > +		return ret;
> > +	}
> > +
> > +	ret =3D scmi_imx_bbm_pwrkey_init(sdev);
> > +	if (ret) {
> > +		dev_err(dev, "pwr init failed: %d\n", ret);
> and...
> 		device_init_wakeup(dev, false);
>=20
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused scmi_imx_bbm_suspend(struct device
> *dev) {
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +
> > +	bbnsm->suspended =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused scmi_imx_bbm_resume(struct device
> *dev) {
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +
> > +	bbnsm->suspended =3D false;
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_ops,
> scmi_imx_bbm_suspend,
> > +scmi_imx_bbm_resume);
> > +
> > +static const struct scmi_device_id scmi_id_table[] =3D {
> > +	{ SCMI_PROTOCOL_IMX_BBM, "imx-bbm" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > +
> > +static struct scmi_driver scmi_imx_bbm_driver =3D {
> > +	.driver =3D {
> > +		.pm =3D &scmi_imx_bbm_pm_ops,
> > +	},
> > +	.name =3D "scmi-imx-bbm",
> > +	.probe =3D scmi_imx_bbm_probe,
> > +	.id_table =3D scmi_id_table,
> > +};
> > +module_scmi_driver(scmi_imx_bbm_driver);
> > +
>=20
> Thanks,
> Cristian

