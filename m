Return-Path: <linux-kernel+bounces-256916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AD93726B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7DD1C20FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6468C06;
	Fri, 19 Jul 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dPLhD9yM"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF7320C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721355095; cv=fail; b=FhrddiGCFl5eyH1G7is+8X74/bbgTxb+zd+GVZQs5TbEcgY3rrznu/BE/CIppjZofQd46Bx+LqfTgi83ps90w8MdWOLtIk6cFfEcUuW0hSdRj2x2uUlkko+T+z3FSXYW0nXR7PJSaBZvK9LfumtJUcb6DAR5gJFOznadkROAhCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721355095; c=relaxed/simple;
	bh=WtvBI80l+ZqYYQtHXeeX1oevzz1+khvVfxuLnLm2MP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTWkWuXqZPKBr8AdfRJt0xuGMi/Hszg3/YMb5V+H8Nq2fHyYErHyRf6710IrfX8eW1GLNd5t9p3QT1rihz9UNwi7HmFqM4oRsGMLibdSKwmSBEiVQIBfWrZRM8dN5PHWXHK374lphtmXTWAokJOOX6pUtxsI8pb+/k1/NkhghsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dPLhD9yM; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKEHOftn7e5NCIhbJGwkDWnXxRq6kOWAaaGcNcQk1ZiIl1fUon+/IL6ZjHUgF1SdmnEdOLtpPifqvPjmccvh0gooJ7VBOep2JPKTgUXiG67Lj9k9zuzQukRPnk/qNEQFRyAZwXICFB87xo3iaUPX4/3dcEaz6ronLRDw8WsQPrH50+jWR1+vV1ysAQuknfd0m53lpNLYQVFnCbrUGH9GlI/XC6CorslUFADg9GaFBuSQ8rUL6J0TNg5TTJPRbRh/5QnXNurkuy0V21gsBJqqaSK2bTRoaxUetRCvbAuYLopN06OQRdV/2HDqJmuSwnk7sQYDl3DqS2nubM7wbyUHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFUI1LD+s2ilXourpGKrxj/pmqrqrAFUu4sZd0SFdNg=;
 b=nIx7v7WH1al6Li4CDJ7Lcf5E2ze4h1joPZiyV9NZ2tCj5Pv9ukevGxyOh/rvuI7AdSUv3XCcjeguANXxDwQhWmXSya4nJyboC3TLKzn6xdO/r1Ceprtzlhi4fQnpwySqalSTOFJ7teAEDWR702HDw6vrPrDxVXmbrUP5wVb4Z+BEej8YQ1jNCKba0tswABtKyAvacjUYSzpwLv5Fi0ZItlUjZV0ZxMZHwhnRLO+uyvketHpTSk7LHS4dn+hMWaw7ZzfnPjUGpx6fl9jklz/k4UCN58h/mf35HTM0JnnUiVz7pzjOaVH61rJ95y3bQZZhwMzEHJrGBYm/kd0YLjWKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFUI1LD+s2ilXourpGKrxj/pmqrqrAFUu4sZd0SFdNg=;
 b=dPLhD9yM7qdtYzLqOYQyihB8lnWKWmlRG58FkKwDE6OS91+U//kinNAQ2inU/gJqRW4rlFjC41Eavpa7n/Cg2fo3u4Z8TKe3Nc+mWscig7f2fcFVtWXbXqAfoqil8nhR1ESZoIwDq1MCjRh9NZ76VzcfMe/D/3FhwnEwpNwEiTE=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS1PR04MB9629.eurprd04.prod.outlook.com (2603:10a6:20b:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 02:11:30 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 02:11:30 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH] i3c: master: svc: adjust the first broadcast speed
Thread-Topic: [PATCH] i3c: master: svc: adjust the first broadcast speed
Thread-Index: AQHa2PK867ZUD3b9m06LiJwiO4dVELH8heUAgADHdoA=
Date: Fri, 19 Jul 2024 02:11:30 +0000
Message-ID:
 <VI1PR04MB5005E4FAAD752A4DFC1CF572E8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240718091329.3788619-1-carlos.song@nxp.com>
 <20240718091329.3788619-2-carlos.song@nxp.com>
 <ZpkhwIoyMj37EZIT@lizhi-Precision-Tower-5810>
In-Reply-To: <ZpkhwIoyMj37EZIT@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|AS1PR04MB9629:EE_
x-ms-office365-filtering-correlation-id: 9f84f340-f3a2-4ff9-c314-08dca7981a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5gPoztbhnJjqadEusjxXrRVw2nvLMwSzMd+azktFfwfMQvGi2RhrXxShrpA6?=
 =?us-ascii?Q?mOaWbuFF92Jef9u4pucLu+NP0rdwU2J/cICaY0BiDYEZ2zBqo8Yvn8HKSpU5?=
 =?us-ascii?Q?czgLMKGnpwQ77gTBCDmhUNJ9Srhh3Q62NNnY/F/f43BRHy7ELiAGycaVD9i4?=
 =?us-ascii?Q?F3Jknlgxw7ka1V0KgGCUOjH50vr1/jmSaBZwBqlF02OquAuYhE1CmYRcjhu7?=
 =?us-ascii?Q?NZtIP4jxEO6MB0UECwwYQCaJCha3pPs+VdJENPscht/A0z2XmlKriX8nLrT4?=
 =?us-ascii?Q?dgu7pa/Ht1gRAsfk0mLHbfkvEVeOmbhA1Ph0X18OMHB/yUlgIUKzz0jjTFzD?=
 =?us-ascii?Q?vc6r3d0iWlALiWskgGcK5U2dn+B5gqjFmhPDwOigiZmvZpDzOOJx4FR+7Qfd?=
 =?us-ascii?Q?iqCx+wgHV+D5yLFkFy1Z7p+R/c/xZB4IEMO5pw+J2Pa7Pw273wSagOO1nsEm?=
 =?us-ascii?Q?E6AiGmWnBzM7HqplcUtUCbES9itkZM8Eh73XerJk5DOWEdr4uA4/ftlo1GEv?=
 =?us-ascii?Q?yXDUa2lxpbJYFM4M/eeFm228vbZ9gg4FoFR30O4PZKnTqVbIalV1dRiCaq4F?=
 =?us-ascii?Q?JM0HGQQtkmuHIQdbKu/CwHRXzKx00ZE19dJaKbqwv5VHLP89AE0y6R20hHcJ?=
 =?us-ascii?Q?MYxj1ZMq1ih2QSrCSYyqLrHe9thsYeQaaUe5/8XmLkUPFTn65c6upnn5JBi2?=
 =?us-ascii?Q?nZYmVpPr4KkakwA5qVMzZ4mH0N71pqTB/iAEuZCJ6DtzYarDoUMoRRwXeP6E?=
 =?us-ascii?Q?/8Ll6I+xY15oRa00CK3DZ4f+XaqFphwi5znlU6EtuoMhr1xgauhfO0WU1wVY?=
 =?us-ascii?Q?V20ha+79MboLLqvFrYDfgbfSITIn0KEt/E282xTQRayZ4hYkBfb9NxAdcI7L?=
 =?us-ascii?Q?OHdqf8vM+21pue8o7iQutcThB7jc1W6T9ub0BohyLvYsyAt/RRArRHzVA8dF?=
 =?us-ascii?Q?+dlgV6WCqb05axdKKZ6IdUaOTC0Y7owXu6MpSYGjqEf9IcpI/xsg7MqFPScu?=
 =?us-ascii?Q?2CU0+Mfimm4HdF8kLI21mD1H30a5gsVZUomzHvhejXdN+gnX+pB5G/70ErwL?=
 =?us-ascii?Q?gzCMtDO+sdYxfRaYyHNH7hNpmIRISufjcti463vTAk/qasO5i3qo9WcyNcaB?=
 =?us-ascii?Q?mkI9edDWVtwD5lX90R9dIX2DvFki18NawBoK4a6/8OQECh7phLTh+FniYaS9?=
 =?us-ascii?Q?p1eTeUfGO1Ma9rgNKn4nVoRNEK3dQdckQeMN6OiRBK28c6TCfCGQbIuyA4qM?=
 =?us-ascii?Q?pMP81u+nNpxqfPYPg16mSCEcPzs36v+IVuFoWp42U2ByUou7iBNvKEXUY9if?=
 =?us-ascii?Q?w0OY2XTGLs2N7hshoN7ukFIiBYsBcZNqiU89OutDQ58fN8zFSwsIQA2fHQpN?=
 =?us-ascii?Q?GxDxavgVCqxzM1LI6+N5LN51auQA/pVzC7fk2D3vms9GUPWrQA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GA6ORD5kys/Ba8UEdpmXxGJ4x9esAQaiYzkmvkv3Vm5w4bjW/Bd2FPcYw83d?=
 =?us-ascii?Q?fvLrljw5agRVqtd+FsExJTTvEzPUqoAD9lLDqNwo8vWzln9K5RQ7SaTeKafR?=
 =?us-ascii?Q?Q8CjvwQq6A8atyuiEJuTi0HIY4uM/1H/vXhkWleHbHvgpIJM30t8TRILMtXy?=
 =?us-ascii?Q?/50c3tAW4HUUG14j7vxpSeyzYE1TGPQd+kQjjLVkKIvIY2m68NZLSRLAprrv?=
 =?us-ascii?Q?2f0n3+PnTBmhSN13MbisInZOP9J44j7pLEV/zAnAGKQ4B0d0/hC8obLNwSVr?=
 =?us-ascii?Q?3KxNMdIE3H5kYYO4ihq6YaJCODYoRbjs0jFiUo0Q4Cu5jVV8BfTioUGSo0TL?=
 =?us-ascii?Q?lPoaqgaN/xjSLZop33lNLomg81qQvtrP/EQ/HeHHhH2aTgqslbpbMfWf54NI?=
 =?us-ascii?Q?ctToBqq3MN+6h14Mb33usxaUBuNBHwKORZ0koJEzMwJvWUTfAHoYw7/1gXxd?=
 =?us-ascii?Q?cxxLwXKZAnot3rPJOeyxaWv0h71hpZQH6JpFxhcUwdonwk9NTlkoMv0wipXE?=
 =?us-ascii?Q?xYTJVgoE4k9qxc0bDKMfMiuQXlMNSrBVt869EjIdqFtccwe5437acLZGcTmM?=
 =?us-ascii?Q?jgDgdiLYZ4d+q3A1pcBj5MEIBosF6h7yhdrMyPOd6gbTNTvn2rqxTLrVqcQ1?=
 =?us-ascii?Q?CwJZLRR7pONg0cNcGXoEUYnmh5+aSNw2TjyjxL6UqRsiQ0WIfqYxMCeo60uy?=
 =?us-ascii?Q?AQK81TLcFQhxgTH91TsLAas2E9TbjV+pomkvUGuP9lek1yItBsuETWlqSKrK?=
 =?us-ascii?Q?fox/YqnO7hB1gkZphdzir0LVLG9jD7yarKxUc1ZkFSaGFBb5zd5KHBnozqHY?=
 =?us-ascii?Q?Pt+tYSzpkhuQ5+gAt1NOf1Q9HGzt3pY+9tIf3roZhe8XE/U4Ov6rSmnawI+c?=
 =?us-ascii?Q?2T+QJjn5LhinDPXGXx+TgCxUJptmQlAPXuoxLr9NI/SZHm0Hby0lNDQPw/Xw?=
 =?us-ascii?Q?+Yr4A/yaf6X9SPnEITJ0y2FEWw9GlkQ1Mj+kLg3iDoLAyGdHva2FhdMSSBKY?=
 =?us-ascii?Q?MhSE6W9MXnX8QDahyEUbs/2P4elS8fK2+8+nyMIJ6U9Ky9pnt/HhpQZPSRLu?=
 =?us-ascii?Q?xVIFF0DK3BimEuzrVu09uwct5JJ+cFiWWf8/cbWx19wGBDB1IFlqmzj0K5i7?=
 =?us-ascii?Q?qM3N3Kkjr9IATD16ECOalrdkBjab54PK3HYS8et7syUqwbaHNg3WFa29nv4p?=
 =?us-ascii?Q?HaJlEzT1nx0m2WG/N1FvYmrXlHAskkDP74Z6i0ZZB11OKlAvF+D2atcwC4Z1?=
 =?us-ascii?Q?9FH+HU60QcSAupWZblVUOufTRHXQMKMyH2Zm6I/MC1Yx+/LE7cwiuA9dY5o8?=
 =?us-ascii?Q?MbQxyoPVBXsgTwIYmIDPD66U0G9sXb4DXEAn1BpGaVuZL30YnOAcPKwy/ECK?=
 =?us-ascii?Q?qGealy6EJ0CZxDQ89lLsew27awRiFGrWWo22dtkqkLJQON/Zvozzm6S9rC3N?=
 =?us-ascii?Q?yfC0vnxKXKBqX/yC/VfDowfpdSEItcwrpFL0TugSXnxyfe71iFf9eYH+vigS?=
 =?us-ascii?Q?1EoLkClTWHO3TzUuNPFcH9PaxwgDpYvARPsjy5/Ams3pkKHe9tSVOAlGbhA9?=
 =?us-ascii?Q?+mnfN8+NeD/+mpExIa0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f84f340-f3a2-4ff9-c314-08dca7981a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 02:11:30.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIy4Y7/m44HU1F59i+KxjyaGAUVoeIn1O71z+HVTaMqTromHzysnNL4nTauBkiSzTEcsTpSaMW/Ja3DGbXGZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9629



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, July 18, 2024 10:08 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] i3c: master: svc: adjust the first broadcast speed
>=20
> On Thu, Jul 18, 2024 at 05:13:29PM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > According to the i3c spec 6.2 Timing Specification, the first
> > broadcast open drain timing should be adjust to High Period of SCL
> > Clock is 200ns at least. I3C device working as a i2c device will see
> > the broadcast to close its Spike Filter to change to i3c mode. After
> > that I3C open drain SCL high level should be adjust to 32ns~45ns.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
>=20
>=20
> If you sent two patch together, it should use "git format -n2", need 1/2,=
 2/2 in
> subject.
>=20
> If create patch seperately, send patch one by one to avoid combine into o=
ne email
> thread.
>=20

Sorry, I will keep the steps in the future.
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 47
> > +++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > b/drivers/i3c/master/svc-i3c-master.c
> > index 78116530f431..2d68c8d34089 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> >  	unsigned int actual_len;
> >  	struct i3c_priv_xfer *xfer;
> >  	bool continued;
> > +	bool slow_address;
> >  };
> >
> >  struct svc_i3c_xfer {
> > @@ -214,6 +215,10 @@ struct svc_i3c_master {
> >  	} ibi;
> >  	struct mutex lock;
> >  	int enabled_events;
> > +
> > +	unsigned long fclk_rate;
> > +	u32 mctrl_config;
> > +	bool first_broadcast;
>=20
> 	slow_speed may be better?

I agree about it.
> >  };
> >
> >  /**
> > @@ -531,6 +536,36 @@ static irqreturn_t svc_i3c_master_irq_handler(int =
irq,
> void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static void svc_i3c_master_set_slow_address_speed(struct
> > +svc_i3c_master *master) {
> > +	struct i3c_bus *bus =3D i3c_master_get_bus(&master->base);
> > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > +
> > +	master->mctrl_config =3D readl(master->regs + SVC_I3C_MCONFIG);
> > +	mconfig =3D master->mctrl_config;
> > +
> > +	/*
> > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> duty-cycle(400K/2500ns),
> > +	 * so that the first broadcast is visible to all devices on the i3c b=
us.
> > +	 * I3C device with 50ns filter will turn off the filter.
> > +	 */
> > +
> > +	ppbaud =3D FIELD_GET(GENMASK(11, 8), mconfig);
> > +	odhpp =3D 0;
> > +	odbaud =3D DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2=
 *
> ppbaud)) - 1;
> > +	mconfig &=3D ~GENMASK(24, 16);
> > +	mconfig |=3D SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > +
> > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
>=20
> 	master->slow_speed =3D true;
> > +}
> > +
> > +static void svc_i3c_master_set_default_speed(struct svc_i3c_master
> > +*master) {
> 	if (master->slow_speed)
> 		writel()
> 		master->slow_speed =3D false
> 	}
>=20
> to avoid set default speed every time.
>=20
Will do it
> > +	/* Whatever, setting the controller to initial configuration */
> > +	writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> > +	master->first_broadcast =3D false;
> > +}
> > +
> >  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
> > {
> >  	struct svc_i3c_master *master =3D to_svc_i3c_master(m); @@ -624,6
> > +659,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controll=
er *m)
> >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> >
> > +	master->first_broadcast =3D true;
> > +	master->fclk_rate =3D fclk_rate;
> >  	/* Master core's registration */
> >  	ret =3D i3c_master_get_free_addr(m, 0);
> >  	if (ret < 0)
> > @@ -1250,6 +1287,8 @@ static void
> > svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> >
> >  	for (i =3D 0; i < xfer->ncmds; i++) {
> >  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> > +		if (cmd->slow_address)
> > +			svc_i3c_master_set_slow_address_speed(master);
>=20
>=20
> 		if (cmd->slow_address)
> 			svc_i3c_master_set_slow_address_speed(master);
> 		else
> 			svc_i3c_master_set_default_speed(master);
>=20
> will be easy understand
>=20

I will try to do it and will send V2
> >
> >  		ret =3D svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> >  					  cmd->addr, cmd->in, cmd->out,
> > @@ -1259,6 +1298,9 @@ static void svc_i3c_master_start_xfer_locked(stru=
ct
> svc_i3c_master *master)
> >  		if (cmd->xfer)
> >  			cmd->xfer->actual_len =3D cmd->actual_len;
> >
> > +		if (cmd->slow_address)
> > +			svc_i3c_master_set_default_speed(master);
> > +
> >  		if (ret)
> >  			break;
> >  	}
> > @@ -1346,6 +1388,11 @@ static int
> svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
> >  	cmd->actual_len =3D 0;
> >  	cmd->continued =3D false;
> >
> > +	if (master->first_broadcast)
> > +		cmd->slow_address =3D true;
> > +	else
> > +		cmd->slow_address =3D false;
> > +
> >  	mutex_lock(&master->lock);
> >  	svc_i3c_master_enqueue_xfer(master, xfer);
> >  	if (!wait_for_completion_timeout(&xfer->comp,
> > msecs_to_jiffies(1000)))
> > --
> > 2.34.1
> >

