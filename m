Return-Path: <linux-kernel+bounces-285820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF495132A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF701B2357A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E63BBCB;
	Wed, 14 Aug 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XFEk3ut3"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C010953;
	Wed, 14 Aug 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606562; cv=fail; b=pqwGynGsEBL5NFhfZFHumED52KDJPWAPscfPCSR4WubcJzlAXqcIizdGh8ANWP3KyaXNagdTUiq/JugVBAWs5l5FzizgHWYBihAwAGQ4WpXZolthPFOcwYTHRAw+GhigzGE4LH7gozVf3GRvTyxIO7IizCZAOjOsjVphSo//FYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606562; c=relaxed/simple;
	bh=2qviyq/DzKruq5vnP54kSmwM88VCotM8eLnye9tRb5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJAHUiJEckGHOdz7fuvuweAPKX+lWUfrgHQmpAfb8xmiunYQ2WRRPvH3qQXLtHwAqM8xfIR3xnHOxV2ulN2tBGhEPOuSZPHNkI6jxJ9SEnCLihq2lW1Y8ZFsRaR9+iPQ4oEBfIklXnbqvGp9M2AgdZ+8w2Eeeg0lx6MjqOprWNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XFEk3ut3; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIhwEQ06iYpWjPyFhEzZjxD+tScIo8LJp2sJoNQQzetUkpNBmINB7T52XUNcMEERyvtHmq9FXqCnmomlHD2WrBjrPrdbBca/VpmXtW8f8lwmVidbg58XgwSnrVnk1m1ni1pKTN5oY3vW0RQYqIrcGQGF2Y22sptPqr7ZBNOyOMrURTNHKEz38hxqG+JddSabflx55VW2eNXSUgJfpvJjCwl1S9PuVHl12hEl0B/rwIFC3wxL9gzKR4dTnERzdJeruBndDy7ZS7p7uMhWYCydzmM+d2txyVud9u3WvJQabIOSTrd50aivZYsjzIPZ5DbFJJqhrD2zLLoRwdNk5wYhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+euUluRDSf8SfCCsTMbYyO4IdrAe3VexelwB7jQ7yx8=;
 b=TqAavPm8BeLsRpkWe/fb0Zj0v3C8JaZVT09Stk16N5Mom3vBnCKENjXqSnIDiedSiYhIZLuIw9owxBMhumsfJyN+XEDAUbwg3smFd5AVskcfbub2NOG/KKiUlJFbJKrAt4UeMNlPX1zyc6Z1eGrYkgmq8w3gDuo49DcFVO87ceTUR5MBOQ5F6pN1m4WdErqFNQyvlxp8qadfErBtK/2eHdaTSjHRmxp1OvovvVfLYjUb+xGzx1+PuCHFVimJDnTuJ5gjKBkhVYbIMQEQ9VyT5Msqu/2lUZnVgP9FPEE3wrGNW32+bjjZet96yPda9cO5PUm0GG0gZBLDheyjO+N76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+euUluRDSf8SfCCsTMbYyO4IdrAe3VexelwB7jQ7yx8=;
 b=XFEk3ut3hXYo8rcfCrKt307FiiEC6nbd0oZgaBJMH9lOLYNBofY1bw7gIYLT34N+gsGOF/Pg6Uf53Pej8ZVzl+IjtjBYLB9ojYRvvDPKq/bgj0xewpdpQW3ft1xX1hp67Bad2Gvb2X4TIP3768J2zBUkF1de1Zd3qchBJtIru4tPKkkBViikZno3W2aErjj2d9PoY63hS2hYnM0QRnMMr2wAC7fVFRqJvPfJID5e6GviPWY/hBVTbAmdzQ8WUWzbNVuGPpGILltRDACZZBAdc9FZap0IqPOPs8ZYa879ZN/nND9U8w5CydzHM0C7Zz9ZkrdHR67OAjKdyUmTWXF1Tw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10669.eurprd04.prod.outlook.com (2603:10a6:10:58e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 03:35:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 03:35:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>
CC: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"saravanak@google.com" <saravanak@google.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Topic: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Index:
 AQHa4YQqp/DPlb92g0GK3FOKE5oYXbIk+n+AgAAWN+CAADhmgIAAAK7QgAAY3oCAAABJcIAAznMQ
Date: Wed, 14 Aug 2024 03:35:56 +0000
Message-ID:
 <PAXPR04MB8459AF9F24D0449A26B2646C88872@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrth0Ypog2TXBlxf@pluto>
 <PAXPR04MB8459B2CF515DC89DE98A1B7C88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrt3P1FH13edqjoC@pluto>
 <PAXPR04MB8459D35BF6FD55B38350E67388862@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459D35BF6FD55B38350E67388862@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10669:EE_
x-ms-office365-filtering-correlation-id: 50823954-3360-4e99-dd74-08dcbc1234ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 2DdEllj//tc5JXrmnolBhTDhVZtULH9iu0OC7dTQkfmt8yfMuutwy2J8RfwPg052+iFrGsCN3MJDO/SnR7y/+/jrj2hhfJYGA5I5QwzzpFvEcWA5edIOSQW2BFG6lRPp8fqL6/vn0fnBapr7pliRKuI+3kQVRjZ6tMgMB2OkY2I3VWxCsXVqvUS7g3RSuzSXRkjY8F+dlPB5lHdtXbjZG6gECDPHpFDOWRFO+HebC5ToS6tRuQT47QI1qfaC4l2ZccDHTimR+DS8NunAOloqkurW5xi/2ZLKHeKpeWrVlQOVmu8Z1udSsTa0ouawKBj5gemLXHHZchqFbLdOIEnFZRA4+RqsosWfOKPk/tf1rq4RmVuXI/Fm5gNth26BrwkWs4oYggA2EbU4WdOOHazjbx1Fe4G8k2VB7OBB2WYyelf5BEpMrOFRnSkFIhgkR+i0zT9a5DSNlC7dGKK+KOBISxLZT3CcfYdLyr9++NisEgsS0Hz6XgGN5SA8nG7+JRF5arLJlGHgldwQcU3X/WSxGrZSrs167p2QmWeyIMVuyKwAqGoMB67IND0mCt9KWr5Ct0wmAWvPiUZhyCARsCTCVLhv2a7V/0IRKBfhGAnJPAi6LoLs1Dh+u1zOEbnam9j+vdjp5MUDmZ1+hrDrqxFBCQLh9D6YKGkOVkqs9exHYt3wY8KHPhsDrKH7oKk+g9fFiZt2ZeiUqKRHTQi1QgyyNWEnptCo8DAcTIQ0XqMtOyF9PwpMh9pkR0Eim3sIVA5oqKghK1SR/OHwY2LIzqjOokLcsDJuYB3uPyJswOW3IBE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hA3Gx5XmzXfaduq6p8qqhhRlW/D4oYypexC2XuyW5jwlaJATuAYMSLKoo/sq?=
 =?us-ascii?Q?z/qii8ztEWGrH5KZNlLymLJo/GcNdC/VD+3Gsv6BMWmx7Mz06nU19BygbQJs?=
 =?us-ascii?Q?VE8pv8/pBHeqcTm7Jn8UyUgcKQ1lJZtlewYwkVB1rW+B4hYwgOZFvRtBr/yO?=
 =?us-ascii?Q?xniBt4djyAM6qTg1QMoWudyZlgTWwt2YN9LqSqOEa3bJdaaetzcIzbFVd0sN?=
 =?us-ascii?Q?eFSRn2FnFSYM/oDLB2OjOtH4Do/rH64BGZ2wXdQAakB22DWfNGmRZutFD55O?=
 =?us-ascii?Q?W6xaPooJw5jzfNyY70K4o1b3E6trSZqkWBmcicJTQUZ2BGyKtKuiOjvp8YgS?=
 =?us-ascii?Q?Fzqd/1Qqx0j2l9Z+SfP2LeurCXNMnEqC1P55mYXZnkvz5z2bsuYVjzSeHIbK?=
 =?us-ascii?Q?+M0v7S8nJIxwXWrNgSYd3k+24qARQkmCLI03582iEL9pFu2mLuhwu/x0zZ4x?=
 =?us-ascii?Q?AXr1eGM+jHYBU+o6j5hrgQdhSOMq8tRIXf4eE498buds1x+AmzdSbwtWVfwd?=
 =?us-ascii?Q?tBXkCdA0xqEWKCSxo8tyyOOAhPlnIiJwK33+l2X5LV1If/vRtCB6VkU4+ghz?=
 =?us-ascii?Q?okegglQsaU8rnKxYVTyAW/ZEJPhd0vKH2MPuKbMTxF25CYF/MZaTB2jcFTtd?=
 =?us-ascii?Q?f0Cxufzr3czrm65FWeuHTw1l/APZAifXGNY/UfSPxrXYUxAygzSmwksZbQg9?=
 =?us-ascii?Q?hYMcXCrj9EsNuhuzzsC7+5Ito8vus17xdgl8XoVb1NZkc+9pbm3/epkbK9XY?=
 =?us-ascii?Q?a97LJLrN36CdnfKZ9CvcvBlPvlbW5mDfGu0NoRYLwUFIBTOACL6mTjXimDpr?=
 =?us-ascii?Q?1L9iCTn7qpVwv64oKrExNKY/X7s117K72Y4hLaerAmdzZGZfmhwZX7mkQO+k?=
 =?us-ascii?Q?4Aq73S7u510iwc4lJTkrJlb/97N58SUcDtZuomMgMb7Z9vCVeILVOotcnZWj?=
 =?us-ascii?Q?t+movSmaiNMAuVtOOe6L0+hAxCMKWpKI2pND059AkSgfMQNI2iBjw2Q5Uj2e?=
 =?us-ascii?Q?4I0nJ8Eft3DSQxtJymjGcgtEprsUj2ijxb21bijcqS/fdYerUu5G4wgLUkbj?=
 =?us-ascii?Q?sORAW+CAlRckujVX3eiMLOOwHDnl54DNtY00fXPWitBvF998yT0oUB8Jpezy?=
 =?us-ascii?Q?IpcN86gXWgNTA/UYa0DOJc1kd3y+0KylLP3G8/CWzPcVpffjq1/V+wg2C98v?=
 =?us-ascii?Q?t2F+G1btVATIIpl5bq5+C0Fnd7wxSqsHEU7N1mVa24Ppi4uGEccsS+0F5rez?=
 =?us-ascii?Q?endG2OUB1NcdLFjiGKhtuyhJ8NSqx+n7IFViIGJRlh0SVGBxHy3ZrfkSGCzm?=
 =?us-ascii?Q?yYz0HdKiH+3WUke4DkK+vd8OHLFqXjiCmKtWtgQWrqURSTfOMt6GVZujaRtn?=
 =?us-ascii?Q?F2ZNFDCaJmZrv46JkkHXTWThjZMfzTFKv4tug/v17gf9fx2hwMLLz+XU7ZB3?=
 =?us-ascii?Q?q0lUZizc6FhEaj0sftHq8n00SLXfT+oe0bOBTMaZdInfYwIeBl5flL7RgDWh?=
 =?us-ascii?Q?4QJA0AJoFT/nwpuZAWtNyXq8Jrwkmm0Xl+zJ+axkngeyJ469dtEuadOmWJZm?=
 =?us-ascii?Q?TIVntscTiTsar3MUNsw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50823954-3360-4e99-dd74-08dcbc1234ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 03:35:56.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVlw5Bzc9tZSe+/C/pmCF4lX2andGBTmX6+3Ut0jaHftr0EQRulvnMvWauVrm7gyA10Ne4GjZt98rIjv5DFsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10669

> Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> for scmi cpufreq
>=20
> > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> for
> > scmi cpufreq
> >
> > On Tue, Aug 13, 2024 at 01:52:30PM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > fwnode
> > > > for scmi cpufreq
> > > >
> > > > On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > > fwnode
> > > > > > for scmi cpufreq
> > > > > >
> > > > > > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both
> use
> > > > > > > SCMI_PROTCOL_PERF protocol, but with different name, so
> > two
> > > > scmi
> > > > > > > devices will be created. But the fwnode->dev could only
> > > > > > > point to one
> > > > > > device.
> > > > > > >
> > > > > > > If scmi cpufreq device created earlier, the fwnode->dev will
> > > > > > > point to the scmi cpufreq device. Then the fw_devlink will
> > > > > > > link performance domain user device(consumer) to the scmi
> > > > > > > cpufreq
> > > > device(supplier).
> > > > > > > But actually the performance domain user device, such as
> > > > > > > GPU,
> > > > > > should
> > > > > > > use the scmi perf device as supplier. Also if 'cpufreq.off=3D=
1'
> > > > > > > in bootargs, the GPU driver will defer probe always, because
> > > > > > > of the scmi cpufreq
> > > > > >
> > > > > > The commit message itself seems very specific to some
> platform
> > > > > > to
> > > > me.
> > > > > > What about platforms that don't atall have a GPU? Why
> would
> > > > they
> > > > > > care about this?
> > > > >
> > > > > It is a generic issue if a platform has performance domain to
> > > > > serve scmi cpufreq and device performance level.
> > > > >
> > > > > >
> > > > > > > device not ready.
> > > > > > >
> > > > > > > Because for cpufreq, no need use fw_devlink. So bypass
> > setting
> > > > > > fwnode
> > > > > > > for scmi cpufreq device.
> > > > > > >
> > > > > > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for
> > the
> > > > > > > scmi_device")
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > ---
> > > > > > >
> > > > > > > V2:
> > > > > > >  Use A!=3DB to replace !(A =3D=3D B)  Add fixes tag  This mig=
ht be
> > > > > > > a workaround, but since this is a fix, it is simple for
> > > > > > > backporting.
> > > > > >
> > > > > > More than a workaround, it feels like a HACK to me.
> > > > > >
> > > > > > >
> > > > > > > V1:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > > > > > b/drivers/firmware/arm_scmi/bus.c index
> > > > > > 96b2e5f9a8ef..be91a82e0cda
> > > > > > > 100644
> > > > > > > --- a/drivers/firmware/arm_scmi/bus.c
> > > > > > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > > > > > @@ -395,7 +395,8 @@ __scmi_device_create(struct
> > > > device_node
> > > > > > *np, struct device *parent,
> > > > > > >  	scmi_dev->id =3D id;
> > > > > > >  	scmi_dev->protocol_id =3D protocol;
> > > > > > >  	scmi_dev->dev.parent =3D parent;
> > > > > > > -	device_set_node(&scmi_dev->dev,
> > of_fwnode_handle(np));
> > > > > > > +	if ((protocol !=3D SCMI_PROTOCOL_PERF) ||
> > strcmp(name,
> > > > > > "cpufreq"))
> > > > > > > +		device_set_node(&scmi_dev->dev,
> > > > > > of_fwnode_handle(np));
> > > > > >
> > > > > > I kind of disagree with the idea here to be specific about the
> > > > > > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus
> > driver
> > > > right?
> > > > > > Why bring in specific code into a bus driver? We will never
> > > > > > fix the actual root cause of the issue this way.
> > > > >
> > > > > The root cause is fwnode devlink only supports one fwnode, one
> > > > device.
> > > > > 1:1 match. But current arm scmi driver use one fwnode for two
> > > > devices.
> > > > >
> > > > > If your platform has scmi cpufreq and scmi device performance
> > > > domain,
> > > > > you might see that some devices are consumer of scmi cpufreq,
> > but
> > > > > actually they should be consumer of scmi device performance
> > > > domain.
> > > > >
> > > > > I not have a good idea that this is fw devlink design that only
> > > > > allows
> > > > > 1 fwnode has 1 device or not. If yes, that arm scmi should be
> fixed.
> > > > > If not, fw devlink should be updated.
> > > > >
> > > > > The current patch is the simplest method for stable tree fixes
> > > > > as I could work out.
> > > >
> > > > So this is the same root cause at the end of the issues you had
> > > > with IMX pinctrl coexistence...i.e. the SCMI stack creates scmi
> > > > devices that embeds the protocol node, BUT since you can have
> > > > multiple device/drivers doing different things on different
> > > > resources within the same protocol you can end with 2 devices
> > > > having the same embedded device_node, since we dont really
> have
> > > > anything else to
> > use
> > > > as device_node, I rigth ?
> > >
> > > I think, yes. And you remind me that with PINCTRL_SCMI and
> > > CONFIG_PINCTRL_IMX_SCMI both enabled, the scmi pinctrl node
> will
> > only
> > > take one to set the fwnode device pointer depends on the order to
> > run
> > > __scmi_device_create.
> > >
> > > So not only perf, pinctrl also has issue here, fwnode devlink will
> > > not work properly for pinctrl/perf.
> >
> > ...mmm ... the standard generic Pinctrl driver and the IMX Pintrcl are
> > mutually exclusive in the code (@probe time) itself as far as I can
> > remember about what you did, so why devlink should have that issue
> > there ?
> > Have you seen any issue in this regards while having loaded
> > pinctrl_scmi and pinctrl_imx_scmi ?
>=20
> No. it works well in my setup. I am just worried that there might be
> issues because fwnode only has one dev pointer, see device_add.
>=20
> >
> > I want to have a better look next days about this devlink issue that
> > you reported...it still not clear to me...from device_link_add() docs,
> > it seems indeed that it will return the old existing link if a link
> > exist already between that same supplier/consumer devices
> pair....but
> > from the code (at first sight) it seems that the check is made agains
> > the devices not their embeded device_nodes, but here (and in
> > pinctrl/imx case) you will have 2 distinct consumer devices (with
> same
> > device_node)...I may have missed something in your exaplanation....
>=20
> It might be false alarm for pinctrl, but it is true issue for perf.

Just give a recheck. Pinctrl has same issue. With PINCTRL_SCMI
and PINCTRL_IMX_SCMI both enabled, two scmi devices
will be created. So it depends on device creation order, 1st
created device will be used as supplier.

On i.MX, there is no issue with both enabled, it is because
the imx scmi device is created first. If the generic pinctrl scmi
device created first, imx will have issue.

In the end, this is generic fw_devlink limitation or arm scmi driver
issue.

Thanks,
Peng.

>=20
> Regards,
> Peng.
>=20
> >
> > Thanks,
> > Cristian


