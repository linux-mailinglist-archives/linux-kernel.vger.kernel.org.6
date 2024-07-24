Return-Path: <linux-kernel+bounces-260588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DC93AB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4061C22A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8C17571;
	Wed, 24 Jul 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZw02FlP"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B371757E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788110; cv=fail; b=uUQ5KdGXaUn21wxxwJZ5rcK90iluEG+LS/D6Nz+TntYgg6sK4mkWVLM3Kd7yaWYSP1xPDNJPc5iCYTVQ4qjiOuU8P1h+air9L4sRjgovIgtpwSSKpyzm0BEV54594ZcC+lbwwgZgZp2TIbTu44nOmZqsDFCRtuEBmDMD8Lj7kR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788110; c=relaxed/simple;
	bh=7UkmAs/Qp/Fw2BYGoHarQY88kvtic5VhloCsWSuDMHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBexUOcgAuoVO7DrMQDbZ5hPHfqAXjsH5B6T4Rj+kmZV6aS95M41vhay+o2daZhzuwMtKSVC+Zkx6PtTAdFwKdhEYh5qIx+mG5NLqZp9RVltvCSuuIRzj+p00ic2qxbaSJaJHlbgjgXIroRBfTYENUi5JF2nhW3R2Ln4weBZxvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dZw02FlP; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHM93IJlDaxqoDCVujzPNe8mBnXfoKmONdCj7lJuH0PFSLjiQTL03v+Gm15QBukcDwYqmLeJUNxeHM4xi7bv8lgZ4funUmMVBjyfb3DJv5oQmoKRxkd+I9D2PE701mJovTXwk2puhqUO0kfBH6N+ch9hbRye7YSOyRiO2tcdBt2FBXrFI73kVJ1Id6VHyuR1jyGkq/MhGtNJccQWrq0yzSdWTDrG7PYa7zn0zCbBze0pRShC1vJqcqzKKKOyAGToySGewMyY2SY6VkHNpUpHasVK2tKyfnzBHpxyOezk6L7MzghY53t2T2c4LsmxK5B0YCC1Tpco3+5/VvlVFNLnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EetpaF5b4ar11Pz08WC0ZvQpCKoIFVNrE2QUNpL0PVs=;
 b=Z6EhqVuRsTNZGodo/FO3G7JHJ25hZPfS176gytuP4V6q08+KYILjclAYo/fjDAchM+3AIjsNuuITNfiM7hdCu70Vvn0WQAgFCJIuITzjUfaOQY8kDUFlvbw5E/vdqsjCDgis8enKda6SOEd5hTv9QwntIe+om6smGxX3mJWyi5SO8VwaUaRVJL/S1/G/ZCmb6+ZNPYSvQ2CHHp4PCRWgZeyH5mJHtr+z2jW4pWN8yBegZT80HPsyjVN4eTZVDfNcEqAVbVNQ4vyMIhgPQUK/6QqJJsHVCmx2JacU5DjznhiK1WcSZEqkr9FAX/b4PH47O8Pk0oIVyz7yaZwwokjN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EetpaF5b4ar11Pz08WC0ZvQpCKoIFVNrE2QUNpL0PVs=;
 b=dZw02FlPkdKvQIHO02L4FaKqseMYXWMVNPjBcsKaXgIFLS5u77Iz17EpYWFm4r+n0hNasBIf1H3TRpXUXwbHwoIgfheclaf6qIACh90jfOy0G15WUO+xpRCoB6smE2HtXRJpEAO7XfZVlB9AQlBX+Rj72/xlCIhJTkLlCSK/qfc=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB8170.eurprd04.prod.outlook.com (2603:10a6:10:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 02:28:24 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 02:28:24 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Topic: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Index:
 AQHa2bIqF20nO4POdEOhWo1zoI6QSbH+JZsAgAAQvNCAACh0gIAApa2ggAPYdQCAASlCgA==
Date: Wed, 24 Jul 2024 02:28:24 +0000
Message-ID:
 <VI1PR04MB500569EA6CB30F6C6807FD57E8AA2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240719080351.842848-1-carlos.song@nxp.com>
 <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
 <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
 <Zpqvs+ok7UQtlYkZ@lizhi-Precision-Tower-5810>
 <VI1PR04MB5005A8FA5CF72161C7654DB3E8AE2@VI1PR04MB5005.eurprd04.prod.outlook.com>
 <Zp50gJvEN0NOsPpm@lizhi-Precision-Tower-5810>
In-Reply-To: <Zp50gJvEN0NOsPpm@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|DB9PR04MB8170:EE_
x-ms-office365-filtering-correlation-id: 75683283-440d-405b-2ff1-08dcab884b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LBC8EVnT+r14ekrvt5+x5h5aWFloMUYQ7o6jSkm72EAcWWj6GmgT0yAsutCu?=
 =?us-ascii?Q?C/BH3JHX/2kFa19hMKlmtBqqXjUH0NKLQ6gaxprJ66kEImiz6TaVeGyREVpd?=
 =?us-ascii?Q?82un4zXb4YWtxfmV3Y4U4Y0gpSRMk4IHTA5ma/YFpxBgkbEuAu0GvrAEtMke?=
 =?us-ascii?Q?GFQCWBon3+aLYGGuvhR+PuG9HIoKNvep9DstiwHmUWm7584FeyAyv/YXX3A7?=
 =?us-ascii?Q?XAXznM4qnkQPEO39cTAk7hptUpOGZAvFyooiuFjIcKTkYdjFt4Od6T9pCQuv?=
 =?us-ascii?Q?d0CO4vT6CZX8aVkdAYPbrtjIboBwNvWNB+IetcnbJpX7LEWLGe4WUm8l7ap2?=
 =?us-ascii?Q?8K/R5+42ze/OquuHDQ2BQ8WP3ymbYXObkfYpdFjG+RidxpsT+oMrNfvvKn+f?=
 =?us-ascii?Q?geInZlUdr4WaoVQwE4ssw2l2KdnLxJ7T6gsZRGiAtR+QI1ZQiBlh/1ffMk1r?=
 =?us-ascii?Q?nl1RqHwLJ61INwAhEBhH4zY4cyrO86gUmKMs5gy3lRxkV47e7vJZiOwf1baf?=
 =?us-ascii?Q?HzHq8RjO2WNN+qg/3g10kixfhPOLH1Qs8LHBlKppCn5447HLLMSd1gHElsNG?=
 =?us-ascii?Q?scfv1i6BwmCJAT5dZRrYsrvn1pscUV8bBPdmF68daOKdFteH+MhsQwk0vkj9?=
 =?us-ascii?Q?FJW8ZeoD9WnQUmrZbxE5Mt+Wpy2bXCS2ZwsfSwKEN20r3TnMhNGwGtAYfvMR?=
 =?us-ascii?Q?WG+1pc0Yt6COH6aQ2FgEkTGuAl8IqApJ+d/JAuhAYglIVYLPArH0Y6zIii1o?=
 =?us-ascii?Q?8USbRQpcEp73e2Jy1HOIuWLx1TLPAbz4YVa5KI1Gmfavnjtf+Nj6egY+FLLt?=
 =?us-ascii?Q?zX7JF1rNrVPIVorjI3g73hkXolgSEgQX09uyLyAZ0ezwecXyeRqCxYgNCdIm?=
 =?us-ascii?Q?QiIm3K106K2RWc/2dbjjZXUrJWxYimW6rZcWebcvX0AfIBiIVW6tukOuFgk0?=
 =?us-ascii?Q?DAGmfeYRGNcdQudP8FGHpK6OvAOCmlm+54Pf1XHNjd7zxf5Mqwhygv1vLBlW?=
 =?us-ascii?Q?n/zRdH2h0hhqqEFvjSmcsGmJ0SInVvUhQdy+YIZr89PcRu2Z704f+ix3yTxo?=
 =?us-ascii?Q?DIq5cqrDv+3gD8J7TLdtMKHtPHTfP5WkwsGZ8QNHrDpVf8gFvHDwzhCskeqb?=
 =?us-ascii?Q?vEWi4VVzDZneIsWqHFfK86+ylKdBts0yAt55DcgrhxLcGfSwmR0Hf2JVQ2yq?=
 =?us-ascii?Q?/MAYh1Rt5oOstUOFdUHCAi0JvgVLrObzOZMpZXzlDDwXT0hrz2H7KaouoiuK?=
 =?us-ascii?Q?ch66q2zY7G1fs30n2nQPY47iimGsFT/w032asRZ2GpCny22vgar/APYu9Hai?=
 =?us-ascii?Q?7COACxHfXB6xuVjwTfQVXoWiWMtft3HFR8BF37L8JZyfnLHot14kPvuaaq8L?=
 =?us-ascii?Q?6MeNPJki9BDjYrRKVsP9MFRteWmCknv8E/uHrV6he9ZJ0iEYew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nkeHORaO7aM1KDqIsc/+OpYx0LoXvlvyTPnNZvvLRXduJ/XkCuum5ktVXcOz?=
 =?us-ascii?Q?n7yRfIa09se0I0MxjZVdeLk1moaK9Ou0a5yAdWWzSuUIk4oFt+36AFQeBhRB?=
 =?us-ascii?Q?lrPQzK4JVE39u3nsbwQE85JwtQ31weJcAkKvgsEonGh16lzBOKkybJBaw7Qm?=
 =?us-ascii?Q?nZw4EeOIDFjYNNm2ZEX++8r3BhCHCadqwIZKBO+lCFMkhh+sXyUBAX4i+8w9?=
 =?us-ascii?Q?vTjIIND9mHepBvmE0iEIcz0hswFVVL7o9G6sEN0vAkwug0KPEtgk8vyfXBtH?=
 =?us-ascii?Q?AHIP8ui8gPGl1yvG7S0tcd6iKb42jx2+ZYR06QjGdt79+6+K/nd6U8Jt0l7n?=
 =?us-ascii?Q?A/huRbhBcEDEi+xbCABW75LKO4VLd0tD3V0zHODKcY3mGt1AFzyA8PgoXzfG?=
 =?us-ascii?Q?ykJh0F8+mRyekMqZ8vnv76ytu8iApTjULp4h2gI2hFhihEysqkmL1iUyEbPZ?=
 =?us-ascii?Q?zlsFEjGXxV7DHOdco/JNI5CuUf094ouZjfUJAj+3cKftjkHPZn0GwqAXSq6F?=
 =?us-ascii?Q?an5dAO4l+ELJScljMtEih+DqX0bJc9DDESJteIbCsaChCpq/s5wp9RgR7Yvx?=
 =?us-ascii?Q?PA36oVMuScalgL1x7fAODkdB8zggYT7HDa34nIDA5FZVQGxSmwdc4IUq5Jmp?=
 =?us-ascii?Q?D3/YOrDJeAAldU2ayz32W0y1dQDcgfHJ6SO39oR18LwC88rq4vDuKIJOE9UF?=
 =?us-ascii?Q?E6nFD+8gzaXdG3HBAGxvyNWpyhtdeJcilLJ6qpMKP8U3doD3bppQieyotG4M?=
 =?us-ascii?Q?hqLVXOfXsNJKyyup4lzjz73AAE7yK+B28CQnN9P9jIjPsjVRtQQ1WYYXIkpz?=
 =?us-ascii?Q?hTfC+gsu9ALuIOOhqYUHAZFNu4ARa4V02ogyEQHIPmssPwJqlXA0QUWTd4we?=
 =?us-ascii?Q?8IiXL2CpGDCORVhK79/of3KOKAx6WfHHiyFXx1OtLGUp4XNSfSRUoD2ez3OQ?=
 =?us-ascii?Q?NWNUYciGoFNW5+/vrfqRf+vQOYzID7HzcoY1SuKa71gHNFr9qGaUaZHs8VW1?=
 =?us-ascii?Q?4bCcRDCMqFU4hV5hVdKRHjWxK6VQcuBshk4Cfb6KLCJhmmE9X8efuY6oxvxn?=
 =?us-ascii?Q?Zf9uXwfdFgwxLyfNWzgUGejSRR5guLROTpio5gf/vJfT8hRIvGcIUH+yFuAx?=
 =?us-ascii?Q?Xoy7AON+WeqwBKi/3bqG55t35x2bTE+x4gKnYkawugI6gCGAsztQ5wJ//3gU?=
 =?us-ascii?Q?IlNEePmsnA0TiPXf3EdEQmnQKxLolQWVLH+Z0qO2VH15TJ8OuSOPIzx+ydx8?=
 =?us-ascii?Q?6TJl3mvuNm8vHRlT5JnVXS+fqv27M8vuVlhxlJTBDN/+GTAZibJM8AOvho1p?=
 =?us-ascii?Q?o/tTISBW3v3XpskSaXVRa7QnsDCmUz51PVG5ZRG8AnGXZ/FTy18oo941GRj0?=
 =?us-ascii?Q?2Re9gt0CNA1aO7P9hQA0wYtqZaLg1tJjW6YhNN7LDtrLFYqjbTWxgYAkkz0+?=
 =?us-ascii?Q?e/AsfIRAx+geM0Drf8aFg9Kr7syxjP0tukInaygFZd9qz3d/McEtgPyJRIlx?=
 =?us-ascii?Q?Vm1xFAfZq01lT+vz9H9XzFtXZtDulcHbmBszWUhcLq1pRJWD+eB1+QOHsVKq?=
 =?us-ascii?Q?TT7C1CClcBaOUgzVQ/I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75683283-440d-405b-2ff1-08dcab884b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 02:28:24.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37kB2EeoRetO7Gv3uXfMapgbmLleYIFzUpVLPt33JqSP0dQcfl3nLhwNq9bg5MKsbZ8jGzbT5anemE9dfAbcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8170



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Monday, July 22, 2024 11:02 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast spee=
d
>=20
> On Sat, Jul 20, 2024 at 04:42:18AM +0000, Carlos Song wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Saturday, July 20, 2024 2:26 AM
> > > To: Carlos Song <carlos.song@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast
> > > speed
> > >
> > > On Fri, Jul 19, 2024 at 04:37:01PM +0000, Carlos Song wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <frank.li@nxp.com>
> > > > > Sent: Friday, July 19, 2024 11:01 PM
> > > > > To: Carlos Song <carlos.song@nxp.com>
> > > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> > > > > <linux-imx@nxp.com>
> > > > > Subject: Re: [PATCH v2] i3c: master: svc: adjust the first
> > > > > broadcast speed
> > > > >
> > > > > On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wro=
te:
> > > > > > From: Carlos Song <carlos.song@nxp.com>
> > > > > >
> > > > > > According to the i3c spec 6.2 Timing Specification, the first
> > > > > > broadcast open drain timing should be adjust to High Period of
> > > > > > SCL Clock is 200ns at least. I3C device working as a i2c
> > > > > > device will see the broadcast to close its Spike Filter to chan=
ge to i3c mode.
> > > > > > After that I3C open drain SCL high level should be adjust to 32=
ns~45ns.
> > > > > >
> > > > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > > > ---
> > > > > > Change for V2:
> > > > > > - use slow_speed instead of first_broadcast
> > > > > > - add default_speed variable in svc_i3c_xfer to avoid set defau=
lt
> > > > > >   speed every time
> > > > > > - change start_xfer if else for easy understand
> > > > > > ---
> > > > > >  drivers/i3c/master/svc-i3c-master.c | 55
> > > > > > +++++++++++++++++++++++++++++
> > > > > >  1 file changed, 55 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > > index 78116530f431..7cd3a9a4d7dd 100644
> > > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> > > > > >  	unsigned int actual_len;
> > > > > >  	struct i3c_priv_xfer *xfer;
> > > > > >  	bool continued;
> > > > > > +	bool slow_address;
> > > > > >  };
> > > > > >
> > > > > >  struct svc_i3c_xfer {
> > > > > > @@ -214,6 +215,11 @@ struct svc_i3c_master {
> > > > > >  	} ibi;
> > > > > >  	struct mutex lock;
> > > > > >  	int enabled_events;
> > > > > > +
> > > > > > +	unsigned long fclk_rate;
> > > > > > +	u32 mctrl_config;
> > > > > > +	bool slow_speed;
> > > > > > +	bool default_speed;
> > > > >
> > > > > I think you needn't two varible 'slow_speed' and 'default_speed'.
> > > > > 	default_speed should always !slow_speed
> > > > >
> > > > > Frank
> > > > >
> > > >
> > > > Hi, Frank
> > > >
> > > > In fact, I am struggling for using just one variable: slow speed.
> > > > Adding a
> > > variable "default_speed "was also a have-to move.
> > > >
> > > > If I use "if else" in xfer for easy understand, it means I only
> > > > can change the
> > > MCTRL register value one time in every xfer. So in the first xfer, I
> > > must change slow_speed to false, then next xfer cmd->slow_address
> > > will be false. So in next xfer, I can set initial configuration back =
to the controller.
> > > > But the question is I have to set it every time, so I add the
> > > > extra variable to
> > > avoid writel in every xfer.
> > > > It looks bad... Sorry for my poor coding.
> > > >
> > > > If only one variable " slow_speed " is used , I think "if else"
> > > > and "writel one
> > > time", only one can be used. Maybe there is a better code method but
> > > I don't get it?
> > >
> > > If I understand correct.
> > >
> > > svc_i3c_master_set_slow_address_speed()
> > > {
> > > 	...
> > > 	master->slow_speed =3D true;
> > > }
> > >
> > > svc_i3c_master_set_default_speed()
> > > {
> > > 	if (master->slow_speed) {
> > > 		writel();
> > > 		master->slow_speed false;
> > > 	}
> > > }
> > >
> > >   if (cmd->slow_address)
> > > 	svc_i3c_master_set_slow_address_speed(master);
> > >   else
> > > 	svc_i3c_master_set_default_speed(master);
> > >
> >
> > Above logic will never enter the
> > svc_i3c_master_set_default_speed(master);
> > Because this :
> > svc_i3c_master_send_bdcast_ccc_cmd(){
> >    if (master->slow_speed)
>=20
> I think, it should be master->first_cmd, which reflect the real means.
> Then it means use two variables.
>=20
Yes, it is.=20
> If it is i3c standard, I prefer it should do by framework to avoid every =
driver add
> similar logic.
>=20
> May Alexandre Belloni can provide comemnts about this.
>=20
> static int i3c_master_bus_init(struct i3c_master_controller *master) {
> 	...
> 	master->ops->set_speed(low);
>=20
> 	ret =3D i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
>=20
> 	master->ops->set_speed(normal);
> 	...
> }
>=20
I agree that. If this can be handled in common code, which can indeed simpl=
ify the i3c controller driver.

Hi, Alexandre Belloni,

Now I am supporting P3T1085 sensor, I meet the issue, I ask help to the sen=
sor engineer, he told me that:
When P3T1085 received I3C 7E header, then it will disable I2C 50 ns filter,=
 and then I3C mode speed is supported.
It's defined in the I3C specification for all I3C target devices. It needs =
at least Thigh > 200 nS to get I3C header 0x7E to work.
The spec requirement in Specification for I3C(11-Jun-2021 Version 1.1.1) in=
 page 495 Table 122 I3C Open Drain Timing Parameter.

As I understand it(if I am not wrong), all I3C target devices wit 50ns filt=
er should be designed to keep the MIPI I3C spec. Slow speed 7e
permits any I3C Target with Spike Filter to detect that it is on an I3C Bus=
, and as a result disable the Spike Filter, then work at I3C timing.

Is there a mistake in my understanding? Can you help evaluate whether slow =
first broadcast should be supported in common code?

Carlos

> > 		cmd->slow_address =3D true;
> >    else
> > 		cmd->slow_address =3D false;
> > }
> >
> > Then svc_i3c_master_start_xfer_locked(){
> > 	if (cmd->slow_address)
> >  		svc_i3c_master_set_slow_address_speed(master);
> > 	else
> >  		svc_i3c_master_set_default_speed(master);
> > }
> >
> > In svc_i3c_master_send_bdcast_ccc_cmd, we always need slow_speed to
> > dicide cmd->slow_address is true or false. Then in
> svc_i3c_master_start_xfer_locked, We use cmd->slow_address to chose set
> slow_speed or default speed.
> > when use "if else", it means we put slow_speed true->false into next xf=
er.
> >
> > When first xfer finish, slow_speed is still true. So in next
> svc_i3c_master_send_bdcast_ccc_cmd:
> > then cmd->slow_address=3Dture, so in next xfer it will continue enter t=
he "if"
> branch not the "else" branch:
> >
> > if (cmd->slow_address)
> >  	svc_i3c_master_set_slow_address_speed(master);
> > else
> >  	svc_i3c_master_set_default_speed(master);
> >
> > so whatever we need change master->slow_speed =3D false in the first xf=
er, don't
> put it into next xfer.
> > This is the reason I always do taht in my V1 V2 patch.
> >
> > Carlos
> >
> > > When slow_address is ture, always set slow_speed =3D ture when
> > > slow_address is false, call to set_sefault_speed, if previous
> > > 	slow_speed is true, then change to default speed, slow_speed will be=
 false.
> > > 	when next time call to set_default_speed() do nothing.
> > >
> > > Frank
> > > >
> > > > Carlos
> > > > > >  };
> > > > > >
> > > > > >  /**
> > > > > > @@ -531,6 +537,43 @@ static irqreturn_t
> > > > > > svc_i3c_master_irq_handler(int
> > > > > irq, void *dev_id)
> > > > > >  	return IRQ_HANDLED;
> > > > > >  }
> > > > > >
> > > > > > +static void svc_i3c_master_set_slow_address_speed(struct
> > > > > > +svc_i3c_master *master) {
> > > > > > +	struct i3c_bus *bus =3D i3c_master_get_bus(&master->base);
> > > > > > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > > > > > +
> > > > > > +	master->mctrl_config =3D readl(master->regs + SVC_I3C_MCONFIG=
);
> > > > > > +	mconfig =3D master->mctrl_config;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> > > > > duty-cycle(400K/2500ns),
> > > > > > +	 * so that the first broadcast is visible to all devices on t=
he i3c bus.
> > > > > > +	 * I3C device with 50ns filter will turn off the filter.
> > > > > > +	 */
> > > > > > +
> > > > > > +	ppbaud =3D FIELD_GET(GENMASK(11, 8), mconfig);
> > > > > > +	odhpp =3D 0;
> > > > > > +	odbaud =3D DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c =
*
> > > > > > +(2
> > > > > > ++ 2 *
> > > > > ppbaud)) - 1;
> > > > > > +	mconfig &=3D ~GENMASK(24, 16);
> > > > > > +	mconfig |=3D SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > > > > > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > > > > > +
> > > > > > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> > > > > > +	master->slow_speed =3D false;
> > > > > > +}
> > > > > > +
> > > > > > +static void svc_i3c_master_set_default_speed(struct
> > > > > > +svc_i3c_master
> > > > > > +*master) {
> > > > > > +	/*
> > > > > > +	 * The bus mode is already determined when the bus is
> > > > > > +initialized, so
> > > > > setting initial
> > > > > > +	 * configuration back to the controller. No need to set it
> > > > > > +in every transfer,
> > > > > just
> > > > > > +	 * restore it once time.
> > > > > > +	 */
> > > > > > +	if (!master->default_speed) {
> > > > > > +		writel(master->mctrl_config, master->regs +
> > > SVC_I3C_MCONFIG);
> > > > > > +		master->default_speed =3D true;
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > >  static int svc_i3c_master_bus_init(struct
> > > > > > i3c_master_controller
> > > > > > *m) {
> > > > > >  	struct svc_i3c_master *master =3D to_svc_i3c_master(m); @@
> > > > > > -624,6
> > > > > > +667,8 @@ static int svc_i3c_master_bus_init(struct
> > > > > > +i3c_master_controller
> > > > > *m)
> > > > > >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> > > > > >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> > > > > >
> > > > > > +	master->slow_speed =3D true;
> > > > > > +	master->fclk_rate =3D fclk_rate;
> > > > > >  	/* Master core's registration */
> > > > > >  	ret =3D i3c_master_get_free_addr(m, 0);
> > > > > >  	if (ret < 0)
> > > > > > @@ -1251,6 +1296,11 @@ static void
> > > > > svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> > > > > >  	for (i =3D 0; i < xfer->ncmds; i++) {
> > > > > >  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> > > > > >
> > > > > > +		if (cmd->slow_address)
> > > > > > +			svc_i3c_master_set_slow_address_speed(master);
> > > > > > +		else
> > > > > > +			svc_i3c_master_set_default_speed(master);
> > > > > > +
> > > > > >  		ret =3D svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> > > > > >  					  cmd->addr, cmd->in, cmd->out,
> > > > > >  					  cmd->len, &cmd->actual_len, @@ -1346,6
> > > +1396,11 @@ static
> > > > > > int
> > > > > svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master
> > > > > *master,
> > > > > >  	cmd->actual_len =3D 0;
> > > > > >  	cmd->continued =3D false;
> > > > > >
> > > > > > +	if (master->slow_speed)
> > > > > > +		cmd->slow_address =3D true;
> > > > > > +	else
> > > > > > +		cmd->slow_address =3D false;
> > > > > > +
> > > > > >  	mutex_lock(&master->lock);
> > > > > >  	svc_i3c_master_enqueue_xfer(master, xfer);
> > > > > >  	if (!wait_for_completion_timeout(&xfer->comp,
> > > > > > msecs_to_jiffies(1000)))
> > > > > > --
> > > > > > 2.34.1
> > > > > >

