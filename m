Return-Path: <linux-kernel+bounces-423194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD19DA426
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30D71688C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB018F2C3;
	Wed, 27 Nov 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hEe4KOE5"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010033.outbound.protection.outlook.com [52.101.229.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85684145FE4;
	Wed, 27 Nov 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697269; cv=fail; b=AuXS3WnpNAbDc1se5uR3vxk8GgZGfGHaOvuHFF6H62BX3kON+6mAMrS/glvJF0mGVem+EiH9SoUJ3ykxscpQND/twz1T+lLgKUWLsI9p67TjPOCbWGmO/FNZHpJ1gjTxy6sad90NR+enAmgSVx3+LTbEdHYVdMKWxxHYc9I/ubs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697269; c=relaxed/simple;
	bh=zCG4MF0tHOEUGDVP7xqaF/fwx+1m6YViD5QFEyi90Rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuTK680YBeZmLSf5ECP/2qcnmWfcyPd7d6GplAbStdK/RypzVZxCq+4eAWzguk+59UAoFbw62esRGvZDPvcI453prs8plSmlX9Yf921lYuTjhDsiTaknOhLEpJ+cLiVXlKYeoR5H2NPFHPEnbseH9QmHimf9dficgDXTKdGG1wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=hEe4KOE5; arc=fail smtp.client-ip=52.101.229.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkU2ZOZdJ6rFu7RwY2dE0xJvIutNeYzfzMbKX90p2sTUwyhS1YLXYu10BJDL5tOn2/JPpmyyNEUlSbfxuXjC0fNuh8wbZdDyUGeuTyL/EzRA3JPTs7bieiLt7T8Eicu8OaA45qbqUcJct4FGFc7hwqyQ5d7D+XPFsHZgjqOaMtTvIWij2cuCSeZqE1kdQz3srj8fMbF8B1G3pKSH/vPlxbGuO3PaWrgChPG6li+x7F2WpEf3CYAJJ4gTJXWhMSIfi7CL8kM8sYsAV+4x85KrISIirT3Jt4aKx6+fIgeL8DYY2WMnWPRFGWDqLFF+fRbmHO/PiY5cX52CLXQEpbC2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38/ma6sK/NjGbvAVDHWmaVPdlEo+dzKEUGpdxHTDyYI=;
 b=lKMQVd4cpgpxbYQ/FIdkBQDcmEDwpkLwuZ3nh4CHkycjGMl4BRUF70qORFTWJ+Z9BtwAVP5q4ZQ+7e2kX43BvoATDN+OdAQHgFclDeki0oa8hQ4XPQyPUBsw2t+C8IpMoNCRLFXUHVF/rLXwFu7QhFp4cbEfQ290iaaj1GvzQKUJiW+EBv4JUjH3zr9xwA054VYluvQyBpb6zIQcyrnyIIItUhKWb9C3ICj4/Hf+OiO8R76iJzyTAVqrIPvVusa9jVqRrECUSuBWO9FUDj3ID0p1atR5KwuHIh2P3OPNp4KDCTP9t7ssoftfKWfEIujdwv8i1r/V1+MvKAgevtSXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38/ma6sK/NjGbvAVDHWmaVPdlEo+dzKEUGpdxHTDyYI=;
 b=hEe4KOE5+rG/amfhnFDquGJ4oAjmrthWa2EX2URLwg1VZaMohI4oVzSxZYOi1BW1l94Q+QATk0olrsF/741Dr0WRUX0xLrHw8HNomNOubzWFWuefreuTOUvUJSlcLg/uBmwAhFlc14cGI9rxIc3HXJvp4mh69+PcODPm5FP7QTQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8697.jpnprd01.prod.outlook.com (2603:1096:604:151::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 08:47:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 08:47:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index: AQHbNmuSilIo7RjEfU+qZS7GfgvaKrK88xQAgAAkloCACsT7AIAC/AuAgAALKlA=
Date: Wed, 27 Nov 2024 08:47:41 +0000
Message-ID:
 <TY3PR01MB1134648B9A537D826754AFB0486282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To:
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8697:EE_
x-ms-office365-filtering-correlation-id: 2b5163cc-eef0-4a8a-189e-08dd0ec0273d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7PV2eDW4sib+b+P61OCWc87x0izkzhqizbpzB8+kX8dM+oFMt/Dg01f336?=
 =?iso-8859-1?Q?SszwoKZx+VppbWZ2k/i54UIk/7VKN7v8GcoCpuOaIXeNUXg9YpPGUCvCZ6?=
 =?iso-8859-1?Q?WULCyXB+d6CRM0B6tTIQ9dJp3q/uvpVTgoqVh+4gvGxBa+PqaYOG75LENI?=
 =?iso-8859-1?Q?YWdzdul+CnIn3VmVVCo/iBo0GiBsUls9WC3R6PtmoFOhJBr8uFv4cNBmc1?=
 =?iso-8859-1?Q?xVk/hkbZ5bVo9lJpM3C2hqEQ/9RH2GY6dg0K17bf0L0jFBLvlzsUi/ik2G?=
 =?iso-8859-1?Q?1T2eN5PzVhLVzSAPVbBZY1voW7wxmxc1Do+EAg2Ier1qJQFUYkoJ/9HP17?=
 =?iso-8859-1?Q?q9yeg1neSg+vK/LbOKvI9ptPVwm79f1RzS6cNI/aC/0ogA24uQk0cKDoW8?=
 =?iso-8859-1?Q?4YHUVtBomdG0rAImu/rRfsYRA7gSrjwFi5FQBpyObhngTUu+D2+zTbNJhJ?=
 =?iso-8859-1?Q?nGLTMH+0OkvjqSu4ckRcwTtxM4sLIE1TGrg0+0cUAoexUejmGkZwsFt4Mx?=
 =?iso-8859-1?Q?ml6rUVhGBJuX2iKXF27RO0Wi4VScLbf9kSGUWpTI9maR8YBaNK5xxRGkZj?=
 =?iso-8859-1?Q?hOb14h1V2L2ty1NeXAl2XxO6yDnMbpu7LFPPSXOBvCiriCA2D385FI/8Mi?=
 =?iso-8859-1?Q?b+7fkReHmA5PsJW9leMr8iQjLDsQRt2GDaTf9KmuW8Vz4KizePSz3y9nEc?=
 =?iso-8859-1?Q?9lzfWPi5BI9JTzD3GLi0p0FMRqG0ZioGjK2BvGnZ9baNeUBJxYEhHl/5//?=
 =?iso-8859-1?Q?DhQHG6v8K8PPvGAXSfLYqQj/G7EZXhaHHSwQnr4tgi7JQu71VIC/7JioN3?=
 =?iso-8859-1?Q?SpFPqGnYJNkmtJaDtI35yjOzNFvMlE+frtLh1mtZ6JFj+WBrcGyIfIAs/1?=
 =?iso-8859-1?Q?KWelPdTCIKbmnYDKcO8KoUhRUpwucqsuhDjkKakyAPv8gkpkzBk1OnFVpZ?=
 =?iso-8859-1?Q?s4aTdwx+uN1p6Nijqr8/7RHtwTHrtnefA3AjWtqnaBiwD5Rgkz6A5//lPD?=
 =?iso-8859-1?Q?PWb4A0trCtR68BLj2cWVJqt+3gFrKhHnjD671XDyEONuLuYG2YGg8yPZA9?=
 =?iso-8859-1?Q?cpCdqNA7LbUkEZplcC4SqSssjekGF+XUbsINGMk+7ABwrP4f416rIaz6WS?=
 =?iso-8859-1?Q?AISs4KFvjNS3KBk7lv5KVk9f3zdnCpDpu02GvaTlyZE2OsIfy6pKOQCHiv?=
 =?iso-8859-1?Q?yogIAFXt/Bev5v5RgpVYJEqALCMNRs4WmdDBN02dbfMRwxCOSzDM9VR74H?=
 =?iso-8859-1?Q?etGeQU0AG7KOusYXw4Dz4s3gy8T1JdfcjfonHZ8QkVQCJQEVFbzanPwj8o?=
 =?iso-8859-1?Q?jF3vJRWTU5+SFiCYZFuw4y/Q96/SDoiIcBkf9F6gqd2vI/NIWsmLu7t0SG?=
 =?iso-8859-1?Q?ZnAgdErQi2O9l/gMJ6MxZG+DyVeDE7e7siqMbAYqSW16+IagsHNAQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?B2rxXuOqOlmaanUWr6jvUuqsmHbPxEdNz3CTDXovgDqSM0AAmzsS5o2NWJ?=
 =?iso-8859-1?Q?l5TlFOWbvTxQM3qicXUfyABVxQToR6/RaHYS3CQEIQGGjhN2uqPKG3s3Tz?=
 =?iso-8859-1?Q?4TUo19T6mJf03fLn0r41shSF/qJr1iIgqGCoiJHSQS+8g8pbL7UGRCSQYy?=
 =?iso-8859-1?Q?9ObnpEiUNthPS+yxxLrTpG3YWgEK+Fn3oSUjVHJDpAS9CVPV+8hnPpoPId?=
 =?iso-8859-1?Q?Qp+9O0TF+rWQo56b5OO3WpNeUwig8IEddfN3KnUUVk1atH518NAa2KaIj1?=
 =?iso-8859-1?Q?bKlIddO51NspydFUis5FTFjObf5WqPtqEeovlNy9PmT5xrRpnJyouJOyNv?=
 =?iso-8859-1?Q?TKasPctAW/2oSzu1++rFPVOnBJWtsutR+kQLzUb0owsLQ8H7Yjf1VgsMcI?=
 =?iso-8859-1?Q?9YEyJ+dbmsDL3gmLsoEB2m1jN02WAQU+RkVda8MKfK+CO3PHV4smXVFC3p?=
 =?iso-8859-1?Q?7zdaDCSV4Y0g0UcGk2TX0CqpTu3d0hV+XyuSAQX9r59on7EXonQzCqkFoB?=
 =?iso-8859-1?Q?sBZCS4+gK4rO859bK0zQfFVzGzWWGkFwaykoMqNdLG9QvsWwyHmM1fmTlJ?=
 =?iso-8859-1?Q?dvDFOgbVsBYYJhdRI1UvIYZeglBOjbjUZEolkpaeygkq5WW883Ci9g/dci?=
 =?iso-8859-1?Q?EUNLLjH6y5Umyl46ou7gLyQXo5vIJ1jJrS7nAThxMT4zlMh5FekwTvBJcX?=
 =?iso-8859-1?Q?+qQcEd2JVewzn9GyN8wLxkjtVgCeNfH0ubFS1deAm+Lr3qCHzNLEmgB1ze?=
 =?iso-8859-1?Q?U+qVcgfCrRCukZI5vEHJqcR4Hu1XVP6Iw+1tNU4DSwJc/aRiBrrcBQoWMi?=
 =?iso-8859-1?Q?hNreyf0z4ydonxtY2TaglrwpdiD7hkZUkVgNERliON9BOBHI/CVymN4CBB?=
 =?iso-8859-1?Q?dYKZXlXfs/7FRHXX6rgcqrTVcUUIonLi60o8MIaS2P7AXjGb/vClZ3Ucoi?=
 =?iso-8859-1?Q?zrOqHoXlpc5iI55nyDfeydedgWE5KT6JEjyAXQ//dr7xRyD7Jy07Qpz4QR?=
 =?iso-8859-1?Q?nU/vD/CmP3kstGH/+p9gGecxsL+1gKJBodhZFyaO1f0BTDJhk0OK16sjnF?=
 =?iso-8859-1?Q?76oxmcTzzFzoVpwy1pOszhqRamk71wzu8c0IT6Jx2bh389lc0X9tfMmpSo?=
 =?iso-8859-1?Q?RSscRMOp/moYmYfwdiNHNFYBmg3xSDj5NpnuUkodY+8785Upb4lmN6VADr?=
 =?iso-8859-1?Q?AOmovdbPP4KyYatlfOtvejGJaBWKESEsOPrbNfOQ009Q6te2h19eqxqEbN?=
 =?iso-8859-1?Q?7VqHBiF3sKMMkryWoj9NbZv7lgAXnZ6GPIivfQ87pKkclTty/mIDcNvUsP?=
 =?iso-8859-1?Q?JfldUyKap7lCM2+rRLjVvzzKfUHOEHwzBC72zphSGPgbePHRoMQGfSp+60?=
 =?iso-8859-1?Q?x5v9JMtC7rJXTfctwkk9jR3QnyA4uJ5TK323Y7AiWjo9tmh4IZ6jRJO4qW?=
 =?iso-8859-1?Q?wIVDLPYmXKCNxRIBOHcR/bfC3HivVmdqcQab/zwfa4IrHJhKwvj/ZjJ98i?=
 =?iso-8859-1?Q?aGqPKnEFc6vzVW29ThS2HZQZEHc0l1vwxC1xUaBHNdmjti7LAu+ml4rCsI?=
 =?iso-8859-1?Q?oHBh5Yv9616ikO0UtfM47fQcMLrwN04YFzFn+Gq0FyNxWs7HSMq1/XQC/v?=
 =?iso-8859-1?Q?KdgwzeP+U+DeOs3ItzsyWr/XRVVq7iiYXPtT6siIIjHcaEunBtt8oZdg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5163cc-eef0-4a8a-189e-08dd0ec0273d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 08:47:41.0823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibwm2t0tYiyGsUMH2kUwxFXVqX6B8XpHsJdvB3Dsk+V2lfKk0XOX/1sS8AGZnLCIsDAlmHF6uhSaUB9MVFEiinubqVSDpmWZVjIdFz51cjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8697

Hi Facklam, Oliv=E9r,

> -----Original Message-----
> From: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> Sent: 27 November 2024 08:03
> Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring po=
rt type
>=20
> Hi Heikki,
>=20
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Monday, November 25, 2024 11:28 AM
> >
> > Hi Oliv=E9r,
> >
> > Sorry to keep you waiting.
> >
> > On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Oliv=E9r wrote:
> > > Hello Heikki,
> > >
> > > Thanks for reviewing.
> > >
> > > > -----Original Message-----
> > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Sent: Monday, November 18, 2024 12:50 PM
> > > >
> > > > Hi Oliver,
> > > >
> > > > I'm sorry, I noticed a problem with this...
> > > >
> > > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > > The TI HD3SS3220 Type-C controller supports configuring the port
> > > > > type it will operate as through the MODE_SELECT field of the
> > > > > General Control Register.
> > > > >
> > > > > Configure the port type based on the fwnode property "power-role"
> > > > > during probe, and through the port_type_set typec_operation.
> > > > >
> > > > > The MODE_SELECT field can only be changed when the controller is
> > > > > in unattached state, so follow the sequence recommended by the
> > > > > datasheet
> > > > to:
> > > > > 1. disable termination on CC pins to disable the controller 2.
> > > > > change the mode 3. re-enable termination
> > > > >
> > > > > This will effectively cause a connected device to disconnect for
> > > > > the duration of the mode change.
> > > >
> > > > Changing the type of the port is really problematic, and IMO we
> > > > should actually never support that.
> > >
> > > Could you clarify why you think it is problematic?
> >
> > It's not completely clear to me what it's meant for. If it was just
> > for fixing the type of the port to be sink, source or DRP before
> > connections, it would make sense, but since it can be use even when
> > there is an actice connection (there is nothing preventing that), it ca=
n in practice be used to swap
> the role.
> >
> > And in some cases in the past where this attribute file was proposed
> > to be used with some other drivers, the actual goal really ended up
> > being to be able to just swap the role with an existing connection
> > instead of being able to fix the type of the port. The commit message
> > made it sound like that could be the goal in this case as well, but may=
be I misunderstood.
> >
> > Even in cases where it's clear that the intention is to just fix the
> > role before connections, why would user space needs to control that is
> > still not completely clear, at least not to me.
>=20
> The idea is to give the user the possibility to control/restrict how the =
port is operating even if
> they have an actual dual-role capable port.
>=20
> Let me clarify. In my use case, I have a DRP port, and in most cases I wo=
uld like to use it as such.
> However, there are cases where this operating mode causes additional diff=
iculties -- for example when
> connecting to another dual-role port implementing the same role preferenc=
e (e.g. 2 Try.SNK devices
> connected together). Then the role outcome is random.
> Since this chip doesn't support PD, there is no way to switch the role fr=
om userspace.
> When I know I'm going to be working with these types of connections, it w=
ould be better if I can
> restrict the operation mode to "sink-only" (for example) for that duratio=
n. Without needing to change
> my device tree.
>=20
> Sure, the mechanism can be abused to switch the role on an active connect=
ion, but that was not the
> primary idea here.
> I would even argue that calling a port type change during an active conne=
ction terminates that
> connection, and starts a new connection from scratch with the new behavio=
r.
>=20
> >
> > > > Consider for example, if your port is sink only, then the platform
> > > > almost certainly can't drive the VBUS. This patch would still
> > > > allow the port to be changed to source port.
> > >
> > > In my testing, it appeared to me that when registering a type-c port
> > > with "typec_cap.type =3D TYPEC_PORT_SNK" (for example), then the
> > > type-c class disables the port_type_store functionality:
> > > 	if (port->cap->type !=3D TYPEC_PORT_DRP ||
> > > 	    !port->ops || !port->ops->port_type_set) {
> > > 		dev_dbg(dev, "changing port type not supported\n");
> > > 		return -EOPNOTSUPP;
> > > 	}
> > >
> > > So to my understanding, a platform which cannot drive VBUS should
> > > simply set the fwnode `power-role=3D"sink"`. Since patch 2/4 correctl=
y
> > > parses this property, wouldn't that solve this case?
> >
> > True. I stand corrected.
> >
> > > > Sorry for not realising this in v1.
> > > >
> > > > I think what you want here is just a power role swap. Currently
> > > > power role swap is only supported when USB PD is supported in the
> > > > class code, but since the USB Type-C specification quite clearly
> > > > states that power role and data role swap can be optionally
> > > > supported even when USB PD is not supported (section 2.3.3) we
> > > > need to
> > fix that:
> > >
> > > My interpretation of section 2.3.3 is that the 2 mechanisms allowing
> > > power role swap are:
> > > - USB PD (after initial connection)
> > > - "as part of the initial connection process": to me this is simply
> > > referring to
> > the
> > > 	Try.SRC / Try.SNK mechanism, for which we already have
> > > 	the "try_role" callback.
> > >
> > > Maybe I'm misunderstanding what the intentions are behind each of
> > > the typec_operations, so if you could clarify that (or give some
> > > pointer), that would be appreciated. My understanding:
> > > - "try_role": set Try.SRC / Try.SNK / no preference for a dual-role
> > > port for initial connection
> > > - "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
> > > 	after the initial connection using USB-PD.
> > > - "port_type_set": configure what port type to operate as, i.e.
> > > which initial
> > connection
> > > 	state machine from the USB-C standard to apply for the next
> > > connection Please correct me if any of these are incorrect.
> >
> > I don't know what's the intention with the port_type attribute file
> > unfortunately.
> >
> > > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > > index 58f40156de56..ee81909565a4 100644
> > > > --- a/drivers/usb/typec/class.c
> > > > +++ b/drivers/usb/typec/class.c
> > > > @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct
> > > > device *dev,
> > > >                 return -EOPNOTSUPP;
> > > >         }
> > > >
> > > > -       if (port->pwr_opmode !=3D TYPEC_PWR_MODE_PD) {
> > > > -               dev_dbg(dev, "partner unable to swap power role\n")=
;
> > > > -               return -EIO;
> > > > -       }
> > > > -
> > > >         ret =3D sysfs	_match_string(typec_roles, buf);
> > > >         if (ret < 0)
> > > >                 return ret;
> > > >
> > > >
> > > > After that it should be possible to do power role swap also in
> > > > this driver when the port is DRP capable.
> > > >
> > > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > > ---
> > > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > > ++++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > b/drivers/usb/typec/hd3ss3220.c
> > > > > index
> > > >
> > e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > > 01f311fb60b4284da 100644
> > > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > [...]
> > > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct
> > > > > typec_port
> > > > *port, enum typec_data_role role)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +static int hd3ss3220_port_type_set(struct typec_port *port,
> > > > > +enum
> > > > typec_port_type type)
> > > > > +{
> > > > > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port);
> > > > > +
> > > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > > >
> > > > This wrapper seems completely useless. You only need one function
> > > > here for the callback.
> > >
> > > The wrapper is to extract the struct hd3ss3220 from the typec_port.
> > > The underlying hd3ss3220_set_port_type I am also using during probe
> > > to configure initial port type.
> >
> > Ah, I missed that. Sorry about that.
> >
> > > One point worth mentioning here is that if the MODE_SELECT register
> > > is not configured, the chip will operate according to a default
> > > which is chosen by an external pin (sorry if this was not detailed
> > > enough in commit msg)
> > > >From the datasheet:
> > > -------------------
> > > | PORT | 4 | I | Tri-level input pin to indicate port mode. The
> > > | state of this pin is sampled when HD3SS3220's
> > > 		ENn_CC is asserted low, and VDD5 is active. This pin is also
> > sampled following a
> > > 		I2C_SOFT_RESET.
> > > 		H - DFP (Pull-up to VDD5 if DFP mode is desired)
> > > 		NC - DRP (Leave unconnected if DRP mode is desired)
> > > 		L - UFP (Pull-down or tie to GND if UFP mode is desired)
> > >
> > > In our use case, it was not desirable to leave this default based on
> > > wiring, and it makes more sense to me to allow the configuration to
> > > come from the fwnode property. Hence the port type setting in probe()=
.
> >
> > I get that, but that just means you want to fix the type during probe, =
no?
> > Why do you need to expose this to the user space?
>=20
> I've been thinking a bit more about this "fixing the type during probe" f=
eature.
> My current implementation always fixes the type, even if no device tree e=
ntry for "power-role" was
> found. Could that cause issues for people relying on the configuration th=
rough the PORT pin?
>=20
> I could consider a solution where if the property is absent, the type is =
not reconfigured during the
> probe. Although then I would have to do manual parsing of that DT propert=
y. With typec_get_fw_cap()
> from patch 2/4, I loose the information about individual properties being=
 present/absent.
> Would be interested in hearing your thoughts.
>=20
> >
> > > > >  static const struct typec_operations hd3ss3220_ops =3D {
> > > > > -     .dr_set =3D hd3ss3220_dr_set
> > > > > +     .dr_set =3D hd3ss3220_dr_set,
> > > > > +     .port_type_set =3D hd3ss3220_port_type_set,
> > > > >  };
> > > >
> > > > So here I think you should implement the pr_set callback instead.
> > >
> > > I can do that, but based on the MODE_SELECT register description, it
> > > seems to me that this setting is fundamentally changing the
> > > operation mode of the chip, i.e. the state machine that is being run
> > > for initial
> > connection.
> > > So there would have to be a way of "resetting" it to be a dual-role
> > > port again, which the "pr_set" callback doesn't seem to have?
> > > 	This register can be written to set the HD3SS3220 mode
> > > 	operation. The ADDR pin must be set to I2C mode. If the default
> > > 	is maintained, HD3SS3220 shall operate according to the PORT
> > > 	pin levels and modes. The MODE_SELECT can only be
> > > 	changed when in the unattached state.
> > > 	00 - DRP mode (start from unattached.SNK) (default)
> > > 	01 - UFP mode (unattached.SNK)
> > > 	10 - DFP mode (unattached.SRC)
> > > 	11 - DRP mode (start from unattached.SNK)
> >
> > Okay, I see. This is not a case for pr_set.
> >
> > I'm still confused about the use case here. It seems you are not
> > interested in role swapping after all, so why would you need this
> > functionality to be exposed to the user space?
> >
> > I'm sorry if I've missed something.
> >
> > About the port_type attribute file itself. I would feel more
> > comfortable with it if it was allowed to be written only when there is
> > nothing connected to the port. At the very least, I think it should be
> > documented better so what it's really meant for would be more clear to =
everybody.
>=20
> After researching some more about this operation, I came across the drive=
r for TUSB320 [1] which seems
> to have a very similar behavior (also from TI).
> [1] - https://lore.kernel.org/all/20220730180500.152004-1-
> marex@denx.de/T/#ma7a322bc207414e4185c29d257ff30f5769f5d70
>=20
> For one variant of the chip, the implementation relies on the CC disablin=
g like in this patch. A
> different variant tests the current connection status before proceeding.
>=20


Can you please provide your test logs?

Previously I tested 2 devices with
Switching roles host->device->host using=20

echo device > /sys/class/typec/port0/data_role

and

echo host > /sys/class/typec/port0/data_role


Cheers,
Biju

