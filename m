Return-Path: <linux-kernel+bounces-257789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E036937EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711E61C21360
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88817FD;
	Sat, 20 Jul 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cJV0mozm"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222ED30B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721450547; cv=fail; b=Qk5Y2KICo/64pe/fwJg5jYAlEpawsEWJBf1o92i/a/GGCEWd9/uUcdvGpmwljp8jKuJPA7pkNEI7x8GF5ogl8EjB2RJgbWwmhsws2p2V/1kWdI7oHY6hBeUJWgevOZMgZ1MRK37jvIZFyu6KaXlGNXTUfjb3yyjhZZ9xPfCb7Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721450547; c=relaxed/simple;
	bh=lJeuW3MW8nMhqKANzscO/jTTMeczYbTAdGy/Dg18wUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bKGaR5I5Teo9LvV4V+guL4qYxIxm+eQcX9CWRfq+eCzT+Gqe0djA6sNe2Gyo9a7HpQYW08eeULXTtMxCjwOckzZ4FwKQOM5vcUrT8XdqJER1AndnL4LTBd1S7YuL6SMTb+ZEAp90ZebPWT/mhzu6VLMgndjUYd+PEUr+LLpUG5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cJV0mozm; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsYrfI9JRdb9+elZVicS7hJbfyLewHbwvxN1PN2OMCHmb9pjS0ZY4jUPmWI1x7bEo5CNw1ZUQGZD0BFdE5iQfMQympl9CGVBOBx26sDhc1DtWHbsGiQL+8KtT6Oyh+h0tNkJ+OS0qv/NhgA3JcSf9U3l7LK2v4YAh3l/bFPzpIN5u2SaYwu6TUjQd3UCYTtnHREZ4LuAuirINYvpINatUMH9K46PqBqBxXn387l0GFGl8vr4MVTqgWUj0w2CNd9AI151nQjs+ft1vT5vDFkDdtmr1196FStISIlswX3tyV7Eqr7iE61Rzg4cvTPi7qWnYQl4LweiC62/hD47a9tZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSk0Bh75gEr1+Q+J9nvBTPKmsqhZ/NDSU04G+kspn8E=;
 b=kZsVykisNfDUHv7nlJaT2Fln+XE3MomOgfTRvaOPwOqkTSpCUQh+bh8C26B28k+bE0eLl/ld7c8v2eon5GQh7jR/pd5zN3i3DOW7Rj7DiGzT9f8LQDqYRIWMNd0Yay52n/sm0esGAIrYQKQtFuYlF1QU/HPambNBwR+6TwZ1ywlldSY9svkwkBIEJNpf81jD/7PlFl1yjIJqs4Bdo6ZgyiPJhur+AUAqSCcl5ThBonqrnTnJ4ux+Yi7YwxayLE6IgcUlXC6EEjSUwYeIAxMJ5mrj5N7P+0A1uGCouZnBWxT+OGOeYW9TZ1K9F90GMjrFVT9MlXVHSPt7FP67pa5OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSk0Bh75gEr1+Q+J9nvBTPKmsqhZ/NDSU04G+kspn8E=;
 b=cJV0mozmwG/M5+RACXRPQCVp45oOiw5geU4jdpHYEXffxWGukJSJUTEB2NBKiGHb8qik0hpUZuR8eHMi8RuDhiPV9TzqWDnw/X1BGE6RNbfIv1mPnlLk8ybAyt8lAobUbZ9/73QhOfseyyis7IyXMfImsD6AdzbaHdsIP9EXCE8=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PAXPR04MB8717.eurprd04.prod.outlook.com (2603:10a6:102:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 04:42:21 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 04:42:19 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Topic: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Index: AQHa2bIqF20nO4POdEOhWo1zoI6QSbH+JZsAgAAQvNCAACh0gIAApa2g
Date: Sat, 20 Jul 2024 04:42:18 +0000
Message-ID:
 <VI1PR04MB5005A8FA5CF72161C7654DB3E8AE2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240719080351.842848-1-carlos.song@nxp.com>
 <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
 <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
 <Zpqvs+ok7UQtlYkZ@lizhi-Precision-Tower-5810>
In-Reply-To: <Zpqvs+ok7UQtlYkZ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|PAXPR04MB8717:EE_
x-ms-office365-filtering-correlation-id: d573bf67-0abf-4661-cc30-08dca876566a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d4SXnkMXZee0YH10eVeZYKuBkvpRtW2amUIb62mthJ0N2LwRYqZo5bfhBd8d?=
 =?us-ascii?Q?otxy8V8DMiaHhTZVaa6P3Co65A+JGzxySvYiCrEj2DtHPVfGic0Xm31f/iX7?=
 =?us-ascii?Q?YIMz/EFscbwbJ2Bh+zZ09aqP9G8NV/cA8hvobxiINQo0mnlCvLuLZYhruQxz?=
 =?us-ascii?Q?oWcwqsM1FPjgoPr4+8fqDgrEZIZcxGnCFFAf2LZHte6D0kYWebFOii91JaSG?=
 =?us-ascii?Q?exi3c1lX8HuvbaNETvBWDPQ/BgUxbsN6LR6uOh7danp6BY7ywp86C7MFcEW8?=
 =?us-ascii?Q?wvWI/mzN9zryW+LvIpetIF4qL1ZbucjElRsgDUQGeI49YCRRr2yEL60us2W2?=
 =?us-ascii?Q?0OwfnpGGYSbWF1KSB3ky/0n9oenid0O+hijg+b7IvmYfFQBN/beD0eT/rxl3?=
 =?us-ascii?Q?GV0IaKPc3wCEOkHgowN/sbOizDO4MVvCRBeGvD75KpFDxuTgmrhTirntoMq0?=
 =?us-ascii?Q?dBIkSeMsAdF/b1o5onPiMTdzSRSVLA82gdOzvxDEV2cWs/MS6IiIctSBVmIY?=
 =?us-ascii?Q?QYacZQ/jjQcfU3lCnzWZEDqnoPzBAsma4PqDQgGsCyrGaQSiG8J6YYCjDTp8?=
 =?us-ascii?Q?VHU2JcreUPOzhZw8EKEwSdMURf9O4DxH7mivLoaqhjIMoVHQ/hFw0kd5gvVA?=
 =?us-ascii?Q?aJlENaga1FVvzSCyJViYbgSfFGpKs9bJseVUsWR/X8DHA/wIiUJNUO4XRbPM?=
 =?us-ascii?Q?NGelEiGMVY0cfvBx5r5iOcVv3AWz5wYgwhbOpIrjZovDrgidRWQiWBFB27T3?=
 =?us-ascii?Q?PrMSDq9SZ2V54cp05hucL8Qklxj663mqQqpdKxaul+sFJe70v3Gw6NMlD3RQ?=
 =?us-ascii?Q?URJtHtT8iyj6upwXv/Kx81j4wZyddAlIiSTqjFrFNTYtUVzpYM+UG/SjVdvA?=
 =?us-ascii?Q?4+fW9+zSED0nyqQiH7yjV1P8Sa6qOWJNIfvdHnlbzofkB/FxSUGmyBtimo1y?=
 =?us-ascii?Q?Gtx2boQVYtvGOsi7eoFU8BYy7vKsO3pouJwARJXi0aCykvQVzf0FycxBo80i?=
 =?us-ascii?Q?uWE7odns8Tj+4Pn538o0oLS4vp/3YtFQlCIfNYpRfMSDh1Wq7eLe0PNxgKsy?=
 =?us-ascii?Q?RMwQFMVQ39iR0XESneIttKfYPUf6iah+u7LagXhcVSRJGHFafVrYexAM+oP/?=
 =?us-ascii?Q?dcDIPpsFrBr8rSbdhnHJZvtZ22rQjFXYUug6/btUq3oN6N7BVHOcHh5jAuHZ?=
 =?us-ascii?Q?teu1aeCKT2B6JOI8aMY0h1yixwmg+WV3wKNYptBvHXZuAGHmZvmiMF/ptf2Y?=
 =?us-ascii?Q?l7OazWn5ZvxsCY1M+r+A1S1ZsbbqSKD8TPtt9YuQYAIJdsEr0wUwJ9MALrOg?=
 =?us-ascii?Q?/Wb6ywum5IASHMOJjc6q01UYIyUtJl/wg6DPnAARHNTWTf3zgzwxcLuq6szn?=
 =?us-ascii?Q?9ZKxNcziNyJhSsyRUzrPjTodbetpL9Ue0ekrCy+JSkpN+aOB4A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v1F1aJi8hIguF0oJUyytIyvVs4hHogEb7+ZVuugX9knuVY2wMYkCI31HMaYU?=
 =?us-ascii?Q?YS+XM3qIZiJKUcSlX4JpT99KxeqyOSKbUrEfmWaw8k1vC1qIAr+1gpAvB3Ee?=
 =?us-ascii?Q?iPB4habUzajPmpGKFuruvZmz2XbczBAODhCMB4njv3rohaJAVbaNwCsNSxxx?=
 =?us-ascii?Q?d/pBAWsKYAQfeFWP68QAWLYWv7v30oTIIizB52Yw6hO1f36OYMoSubOp0EFH?=
 =?us-ascii?Q?rnZQBPUNdGAPtzvR49pWNfDx/SU6ZtfWoRwghJ+vKzLSib9HT2tsm/qUQCdw?=
 =?us-ascii?Q?6yqP3g73LMFNaR9UXZpw9Ncek1d3TlFJdHRzDG1sGMn/S5tMKzQvxm3jI0Es?=
 =?us-ascii?Q?2WSFIm2PCpCYHXF7BXECF4B15axinLukWeB7uJcId4oCYdLw7ZkB9p/j2/Bm?=
 =?us-ascii?Q?Ilwq7gGWAdlBZhXLU63Nlgu2XLyU8AhfxPB3tkxcGUrv3mZSTzLg2fmnr/S2?=
 =?us-ascii?Q?jPcVEaWtBnT0X4OlL0pz2AELl8kG7Gym5Q6zI9p2DlylArGz6myWvyRuBocZ?=
 =?us-ascii?Q?ZeoqvD+CbZLWP0LKgi+8lfbInV6XhGjTSS/+PjHyfXnCNN/GOg/esa85++St?=
 =?us-ascii?Q?GYFXSOob10RC63JVcduVhLsSNsM9ukzaLksazzO0C/xUf/edm8ki2DSwvOZS?=
 =?us-ascii?Q?ocJGHizr30vlFpOoLkKXVT+JxohLj+qHs1dJWeeroKG5SaOA34F0Js/BGzrx?=
 =?us-ascii?Q?oR9/8Z5Xxu9dLmfF/luNz9YYK8cgx0J1gD5+g3IIdpvM5Ak6BAlE+0Jhwhwq?=
 =?us-ascii?Q?1GVnQIj4pdd8nZeSsVTSsfmMmSuEsfZWmu3409jrn9bWpRt/0Y06q/utgQnl?=
 =?us-ascii?Q?PJJmvFxW82S61lUC3AJvQt/DUi10TONp8NZar3BT5p6dJPH2DSRD80N3kWrj?=
 =?us-ascii?Q?KleHQNXVbeVAxt0lodw0vBxfJA4dMVybXPa4kZG7PKQVBGXcH81CktS/j4nU?=
 =?us-ascii?Q?e+20eLJeBRAIXzxwdA8hBX4n2cofeKjCJw4Mpd3aWoYHy+gC0rSTX9hgT5AQ?=
 =?us-ascii?Q?64XsHovx60C1qfimqhf6DT9vMgthr7DzkajzP99+B1io7Y3NUggCoACmvGlj?=
 =?us-ascii?Q?cbcnLiWu9wWQqe0rx7JKTg2IZm0r/0H6zzzlbOgB6YW5bkE9X1tBkkI1itv3?=
 =?us-ascii?Q?+fmW5Bi5KOkwRM+8M5PozKUOgOBHfxVQ79dPXxF2XMoQ4GqIYMMPSsBjV34q?=
 =?us-ascii?Q?T2PVD/f61EHuCznMASJltR97FmqhsXSpDJmc99VoOz0QMBcSLIpQfzZjN8tB?=
 =?us-ascii?Q?eNUNJFMXutCW3Bkp6SThj5x32G7nYzwlvFSzyrENVRCEUdUtAYr8698y7jiw?=
 =?us-ascii?Q?l5UylczBk2FrB6M1D3RU/8oJO0x99CkHI/E3tPRMUVPZLd1KON7n4MGXdCDl?=
 =?us-ascii?Q?jcxwx8DoC9SBKQaj3lYXhbMNqZexydwZRWbe3sqiILJIPITcxq9vQX0HyNo1?=
 =?us-ascii?Q?Ky2p2Cw/HmE4gs0TRRVWsHR9B3npbXcVNF33zpauRoIRg3AqU933Felvp6FO?=
 =?us-ascii?Q?b7KyO5Mf7nVEuUms4BgV/ggK1peQEOyhrXPk7LEZh7A+WsiK1hZqqjmJ49VU?=
 =?us-ascii?Q?eK928gQnlzGOPM1GPQQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d573bf67-0abf-4661-cc30-08dca876566a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 04:42:18.9086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDMA0FUfo/Uhji6coSzKopYz4os3gK2OBMzrK1Bw08iSHmyaEsAFA9XaKGR+wSV1sAPp4xt/B17hTGpIJikzTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8717



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Saturday, July 20, 2024 2:26 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast spee=
d
>=20
> On Fri, Jul 19, 2024 at 04:37:01PM +0000, Carlos Song wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Friday, July 19, 2024 11:01 PM
> > > To: Carlos Song <carlos.song@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast
> > > speed
> > >
> > > On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wrote:
> > > > From: Carlos Song <carlos.song@nxp.com>
> > > >
> > > > According to the i3c spec 6.2 Timing Specification, the first
> > > > broadcast open drain timing should be adjust to High Period of SCL
> > > > Clock is 200ns at least. I3C device working as a i2c device will
> > > > see the broadcast to close its Spike Filter to change to i3c mode.
> > > > After that I3C open drain SCL high level should be adjust to 32ns~4=
5ns.
> > > >
> > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > ---
> > > > Change for V2:
> > > > - use slow_speed instead of first_broadcast
> > > > - add default_speed variable in svc_i3c_xfer to avoid set default
> > > >   speed every time
> > > > - change start_xfer if else for easy understand
> > > > ---
> > > >  drivers/i3c/master/svc-i3c-master.c | 55
> > > > +++++++++++++++++++++++++++++
> > > >  1 file changed, 55 insertions(+)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > index 78116530f431..7cd3a9a4d7dd 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> > > >  	unsigned int actual_len;
> > > >  	struct i3c_priv_xfer *xfer;
> > > >  	bool continued;
> > > > +	bool slow_address;
> > > >  };
> > > >
> > > >  struct svc_i3c_xfer {
> > > > @@ -214,6 +215,11 @@ struct svc_i3c_master {
> > > >  	} ibi;
> > > >  	struct mutex lock;
> > > >  	int enabled_events;
> > > > +
> > > > +	unsigned long fclk_rate;
> > > > +	u32 mctrl_config;
> > > > +	bool slow_speed;
> > > > +	bool default_speed;
> > >
> > > I think you needn't two varible 'slow_speed' and 'default_speed'.
> > > 	default_speed should always !slow_speed
> > >
> > > Frank
> > >
> >
> > Hi, Frank
> >
> > In fact, I am struggling for using just one variable: slow speed. Addin=
g a
> variable "default_speed "was also a have-to move.
> >
> > If I use "if else" in xfer for easy understand, it means I only can cha=
nge the
> MCTRL register value one time in every xfer. So in the first xfer, I must=
 change
> slow_speed to false, then next xfer cmd->slow_address will be false. So i=
n next
> xfer, I can set initial configuration back to the controller.
> > But the question is I have to set it every time, so I add the extra var=
iable to
> avoid writel in every xfer.
> > It looks bad... Sorry for my poor coding.
> >
> > If only one variable " slow_speed " is used , I think "if else" and "wr=
itel one
> time", only one can be used. Maybe there is a better code method but I do=
n't
> get it?
>=20
> If I understand correct.
>=20
> svc_i3c_master_set_slow_address_speed()
> {
> 	...
> 	master->slow_speed =3D true;
> }
>=20
> svc_i3c_master_set_default_speed()
> {
> 	if (master->slow_speed) {
> 		writel();
> 		master->slow_speed false;
> 	}
> }
>=20
>   if (cmd->slow_address)
> 	svc_i3c_master_set_slow_address_speed(master);
>   else
> 	svc_i3c_master_set_default_speed(master);
>=20

Above logic will never enter the svc_i3c_master_set_default_speed(master);
Because this :
svc_i3c_master_send_bdcast_ccc_cmd(){
   if (master->slow_speed)
		cmd->slow_address =3D true;
   else
		cmd->slow_address =3D false;
}

Then svc_i3c_master_start_xfer_locked(){
	if (cmd->slow_address)
 		svc_i3c_master_set_slow_address_speed(master);
	else
 		svc_i3c_master_set_default_speed(master);
}

In svc_i3c_master_send_bdcast_ccc_cmd, we always need slow_speed to dicide =
cmd->slow_address is true or false. Then in svc_i3c_master_start_xfer_locke=
d,
We use cmd->slow_address to chose set slow_speed or default speed.
when use "if else", it means we put slow_speed true->false into next xfer.

When first xfer finish, slow_speed is still true. So in next svc_i3c_master=
_send_bdcast_ccc_cmd:
then cmd->slow_address=3Dture, so in next xfer it will continue enter the "=
if" branch not the "else" branch:

if (cmd->slow_address)
 	svc_i3c_master_set_slow_address_speed(master);
else
 	svc_i3c_master_set_default_speed(master);

so whatever we need change master->slow_speed =3D false in the first xfer, =
don't put it into next xfer.
This is the reason I always do taht in my V1 V2 patch.

Carlos

> When slow_address is ture, always set slow_speed =3D ture when slow_addre=
ss is
> false, call to set_sefault_speed, if previous
> 	slow_speed is true, then change to default speed, slow_speed will be fal=
se.
> 	when next time call to set_default_speed() do nothing.
>=20
> Frank
> >
> > Carlos
> > > >  };
> > > >
> > > >  /**
> > > > @@ -531,6 +537,43 @@ static irqreturn_t
> > > > svc_i3c_master_irq_handler(int
> > > irq, void *dev_id)
> > > >  	return IRQ_HANDLED;
> > > >  }
> > > >
> > > > +static void svc_i3c_master_set_slow_address_speed(struct
> > > > +svc_i3c_master *master) {
> > > > +	struct i3c_bus *bus =3D i3c_master_get_bus(&master->base);
> > > > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > > > +
> > > > +	master->mctrl_config =3D readl(master->regs + SVC_I3C_MCONFIG);
> > > > +	mconfig =3D master->mctrl_config;
> > > > +
> > > > +	/*
> > > > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> > > duty-cycle(400K/2500ns),
> > > > +	 * so that the first broadcast is visible to all devices on the i=
3c bus.
> > > > +	 * I3C device with 50ns filter will turn off the filter.
> > > > +	 */
> > > > +
> > > > +	ppbaud =3D FIELD_GET(GENMASK(11, 8), mconfig);
> > > > +	odhpp =3D 0;
> > > > +	odbaud =3D DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2
> > > > ++ 2 *
> > > ppbaud)) - 1;
> > > > +	mconfig &=3D ~GENMASK(24, 16);
> > > > +	mconfig |=3D SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > > > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > > > +
> > > > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> > > > +	master->slow_speed =3D false;
> > > > +}
> > > > +
> > > > +static void svc_i3c_master_set_default_speed(struct
> > > > +svc_i3c_master
> > > > +*master) {
> > > > +	/*
> > > > +	 * The bus mode is already determined when the bus is
> > > > +initialized, so
> > > setting initial
> > > > +	 * configuration back to the controller. No need to set it in
> > > > +every transfer,
> > > just
> > > > +	 * restore it once time.
> > > > +	 */
> > > > +	if (!master->default_speed) {
> > > > +		writel(master->mctrl_config, master->regs +
> SVC_I3C_MCONFIG);
> > > > +		master->default_speed =3D true;
> > > > +	}
> > > > +}
> > > > +
> > > >  static int svc_i3c_master_bus_init(struct i3c_master_controller
> > > > *m) {
> > > >  	struct svc_i3c_master *master =3D to_svc_i3c_master(m); @@ -624,6
> > > > +667,8 @@ static int svc_i3c_master_bus_init(struct
> > > > +i3c_master_controller
> > > *m)
> > > >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> > > >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> > > >
> > > > +	master->slow_speed =3D true;
> > > > +	master->fclk_rate =3D fclk_rate;
> > > >  	/* Master core's registration */
> > > >  	ret =3D i3c_master_get_free_addr(m, 0);
> > > >  	if (ret < 0)
> > > > @@ -1251,6 +1296,11 @@ static void
> > > svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> > > >  	for (i =3D 0; i < xfer->ncmds; i++) {
> > > >  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> > > >
> > > > +		if (cmd->slow_address)
> > > > +			svc_i3c_master_set_slow_address_speed(master);
> > > > +		else
> > > > +			svc_i3c_master_set_default_speed(master);
> > > > +
> > > >  		ret =3D svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> > > >  					  cmd->addr, cmd->in, cmd->out,
> > > >  					  cmd->len, &cmd->actual_len, @@ -1346,6
> +1396,11 @@ static
> > > > int
> > > svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
> > > >  	cmd->actual_len =3D 0;
> > > >  	cmd->continued =3D false;
> > > >
> > > > +	if (master->slow_speed)
> > > > +		cmd->slow_address =3D true;
> > > > +	else
> > > > +		cmd->slow_address =3D false;
> > > > +
> > > >  	mutex_lock(&master->lock);
> > > >  	svc_i3c_master_enqueue_xfer(master, xfer);
> > > >  	if (!wait_for_completion_timeout(&xfer->comp,
> > > > msecs_to_jiffies(1000)))
> > > > --
> > > > 2.34.1
> > > >

