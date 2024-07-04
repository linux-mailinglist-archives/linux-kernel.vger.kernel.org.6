Return-Path: <linux-kernel+bounces-240763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A31927249
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E771F252F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08591172784;
	Thu,  4 Jul 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r4V8P4QR"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010070.outbound.protection.outlook.com [52.101.229.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610E1AAE08
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083422; cv=fail; b=V6ORHr3ygowv/tmh8ZGrgP8zHrqH8F5ZHWb6a+SSy0JipxAIy/TgNITTbrljN6n38uagk+Jpc86G9qC2rU5A73u8BAiRHvZnfn+IZb1s82QY3rOrWCNoJ9iM78mGMfZQBJ3gziy6H7CnSBB8NTN8CbC9+3+rpmVn48ndZudcENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083422; c=relaxed/simple;
	bh=runXfJIzmXT+PN32YmTO3keCNAKS5NRchXvnMmvuiX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKYwBExhqouCjia3/TqU2yiXQ/z7U64BO8KEm24eAt8qfD5ajEmT2lV6JMA1Le8eB8f9ipINqdYrJmzik2cbPMLfRyoaYSXUe0pISqsHXJJshCnhIDJe94QmeDxX8rq3RXp37dB2FxUTi4ThxXBT97HYtPgSSAoAx9I0gMvZpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r4V8P4QR; arc=fail smtp.client-ip=52.101.229.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCmOER3rmx0wPW8Gnm9KKT7dGK1BCBppoDK/qwV36MqMDLMKq93Mtx0+cZztKX3Bj4q4jj1vD61UAFlZZv61j1mUbl9H7eJmiwR9v23TjWwimkdqR9gFSdANeETR5Y4bsigLsK3t4qwizkZNKe3o8EtY1iFRJWcCHsTFX4UyO+umghOjbE+D4zCAn5mA4wEANT/lm0lh4z7sxh3JE6YhWeXcfj5Kke2lWr7jP1d6rsHV0OhwghyHPEVZ+cpom5g2UDT2NjeoYpnj3UHN0wit7kCSFE9ljCha2kPol00fcSfaLgsUbRyZAp+51nDrf3W3Ow8wJqeSbQL6vfoy0pK1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQV/GpyFfn0WjVyBjejZ+myGLzjrIWLmCAG6cUzUeVg=;
 b=VlmpdzSDsBPRnEPzauv3Y+q57pPT0MaThCvO7QZT2nK1e/S1O47LcxsuwngkrI4M9QDlxtpVtqnAhLmI1u68RSJtEtJCoymKk8M7dhmYQb2iS6i/M2aOSx1T5Gd4jVACcvuZykySn0mLewBgpBdds4VoGT9tS/bG9UoWkzdXOb4YS+ASmxG5l3oW68OLiINZ66ibv9Bupa/+HvPQ4+tlbFSgJVEHTkMPhyp3Mk1pMQhEyZD2M4hZS+wzoFBfals+bRH9UmImRTwlIiQxpY4Eq2e1EbJLLTEwHsbcAk5uugBZP/+tFO9XK8QSMSyhkfWg1Rq4NdLnhugXZWWgbglJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQV/GpyFfn0WjVyBjejZ+myGLzjrIWLmCAG6cUzUeVg=;
 b=r4V8P4QRCNlfEvE86UufAtwgKMQhNar19lEhz5r68WNkA0eZBtOzgGZ/HdEvXPU62/mvQ6TX65pHpJow5a+buC6bmuRiY5sIwbZ7HGjDdl4Pnht7pCCXt/4r8Dt+bKpuJkh0jkQGGcRhGdsEEAMf4IB8DpRBlhXl4gHWVk0qwys=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10886.jpnprd01.prod.outlook.com (2603:1096:400:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 08:56:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 08:56:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Nicolas Pitre <nico@fluxnic.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Thread-Topic: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Thread-Index: AQHazZEUBvMAYbNlJUWAdVEYoNoIYbHmHgxwgAAmfHA=
Date: Thu, 4 Jul 2024 08:56:46 +0000
Message-ID:
 <TY3PR01MB11346B1955B75840FBA892C8C86DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-3-nico@fluxnic.net>
 <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
 <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>
 <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>
 <TY3PR01MB11346F310DEBD3282268154B486DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346F310DEBD3282268154B486DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10886:EE_
x-ms-office365-filtering-correlation-id: f22ec061-2e70-4547-15cc-08dc9c073bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?svQfzLQxkhR+8lwEJe/kTDXZl0rbEJsv6C0c0C7g231r3p2i87tIN9XsHc?=
 =?iso-8859-1?Q?Wh/JFJd/EbxRrKpuJDbGwMkSi6RhxpOA0ZWn0F/7NVfMpnP1FkYTrRWWwl?=
 =?iso-8859-1?Q?UxtqcnhR8WEPtxotLFUP6IG3lI4XVvfVp73pHQU64OsEPjHqRR7/5NeI8W?=
 =?iso-8859-1?Q?ICL3/uGuJIEeTBrjJDXZaTbKyeBvMKwQ5vN2Ei+zKyFXRe/4P8UjkkKNGl?=
 =?iso-8859-1?Q?7cxMrmZ4Qp+pCStqjz9BQPoyCicULdYQ6lhw/WhMyF9TDjSIm/z36O0g0o?=
 =?iso-8859-1?Q?LSxiMse2U89XBdxBWZGM1gJkclP2zXORr0URHnJnTVS7sLW4dFS+hzqY9F?=
 =?iso-8859-1?Q?qUIbqjJldo4Lmr7pMt8X1UqYUBouj+F031qb86R3qC9PHldKyQmXuhi086?=
 =?iso-8859-1?Q?lsu4etZ54juMJXWhRJROaWjp1IhHi4gxovixJTbj6ndWQ9iqX33MHa1lzO?=
 =?iso-8859-1?Q?F0rz5bQ+I80SJOTxKLSIrguEsQkaB1kKN17IHCXGx0/Pbms5nakVzM2lI/?=
 =?iso-8859-1?Q?M2iDxx3E48pt4LITjyF9uDx2wwrrCUHr6+k0G25RwjEhEJ2gCKJjBw00Fr?=
 =?iso-8859-1?Q?X19IrqCIsd3HcX8VDhawmjgb/Cbidio4oZw8KI0juL6yKSbmXgExoW4/x7?=
 =?iso-8859-1?Q?C2+ipa/erppBxuW9U5G9jjT5fCwrsfshd4joB8MYP0lbk3N1cd4zBYEclo?=
 =?iso-8859-1?Q?FUq9qthXtI6XLJqYhIVZYZC1Scr3Av7fmip24s1/7pMY7v3FmnNUYR/tcX?=
 =?iso-8859-1?Q?inaAPxMxWkroi77RL5nvJsHQoOhCWNsCqBQzBAV15o5uxTnYA2aazv/8pL?=
 =?iso-8859-1?Q?sJeJmCVSpxLv9IxUbJ7j6L2qv6y2VbwTwLZXm7bt09dDI0PbuNnlvfIwed?=
 =?iso-8859-1?Q?zW7yV2exe6bs0l7f8TO0hZGUYDfgklwyWlXHpCa15YTDDtXi7Ba2nnXizg?=
 =?iso-8859-1?Q?pB4s9+eZGfujpmQpM2zmMYBsOKt0iw+JgxZn5PFg2RJOrUBlJdtROzdBQV?=
 =?iso-8859-1?Q?qfYCyZXMiU4MPVpLn5MckAUmIvhPZlDalhykRioZ/kq9zV/BkoY1Ztd27h?=
 =?iso-8859-1?Q?goEAc8O1nCobJnuK1biMy7BrKi5oSeqQCZstl27Vib3GW02fTyYBfzyiYZ?=
 =?iso-8859-1?Q?giKHdwL9dKN9WuOYi11ABcaPk4J+TW8a5SOXcn9T/usb0gDJeaILYDWInq?=
 =?iso-8859-1?Q?XKj4lobC1je1Q64kACaiVEEIWN9VEWXKZyYIw8Iz2/ug8a0wQRNlRT7VA5?=
 =?iso-8859-1?Q?6jRSEpuCc7Jn33co4uEPbutXXvbx/zsrZsucgG4TsblOCQ5k8DLoiSkWnP?=
 =?iso-8859-1?Q?I0sUaDOA0iirLCWuoNf0zUpO7YfmPSWTefCqvb48oXZbN0D/I7tdOjd19L?=
 =?iso-8859-1?Q?ux8ipqJAo5r8v14jrO9zM4x9rTmlCtrW5yRA87BlO1Dt1xK9J/kgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vkAHbl3shcZl/PGS17v/ooJub522inUJrTE2+AA2g1JCYDgK3XuOqub/fD?=
 =?iso-8859-1?Q?m6uHs1v6aroUrOAfqyKEBXrEYKdJGl3dvtAE0dXN29FfaJKQmRCQ34BtNU?=
 =?iso-8859-1?Q?eXvYppGj7AU0RSUC9GyeT3zSuGdH94+XRbndYXQUOWnQAEirHiILcFz6nR?=
 =?iso-8859-1?Q?v951E5GbTpHQ3JP17dgRCKwJpHkeJ9jzIBOJ7aJDPrgpEOiFEg3RO3QHpC?=
 =?iso-8859-1?Q?n66SsGBRtgR84KnuEHFJ+E2Pi9hl0wloo2AcTCZn/fJZf3iFD9uyEVzxAw?=
 =?iso-8859-1?Q?GSY5wuhF3xtjb2SAJk7uDuk91CaxoVfHI9klIiXS1UN7BJLc+VCDa/TFnn?=
 =?iso-8859-1?Q?2Q+WnIZ4ZQzInAvmAjlXqFNZxROOGCEYnW/b8xyi6HFqVAfxv4p9yJNFb+?=
 =?iso-8859-1?Q?UGql7s31TkU+d5XNmHoliR1nTysJhwhjX2jCN5IjuGgARG+rtNFivHhV/E?=
 =?iso-8859-1?Q?gScm65uS2iImjGdH11+jz+dWx0t0k695tfKe3FkdFMUgVtRyL5dLxcKP2j?=
 =?iso-8859-1?Q?wT+gi88DmAPM7VttPvWJW+2ZeoiFPshcAwdLfu8ol4JeArfRZ7Dvp/u1tS?=
 =?iso-8859-1?Q?lLxujex3ehGWJg6WdlCUB4HdUn0veRN3XahXvGQsq3YcZIq/7H9jWerksH?=
 =?iso-8859-1?Q?BLBMDJTJLlevBiqeArCJcqJ7np0L1mJysA+54QoCJimLFLQBQx5W4ojqY3?=
 =?iso-8859-1?Q?FsZUGmE3e7vjyNDcicYjPHsNIaTf42YZrvKYMufCPiPCddrEO9HONQJ/H2?=
 =?iso-8859-1?Q?cCb8brTEqDuHuW5oEKFMzlgtoMP+9gsGIGryKMyHbnqtlIfvvNiZRkdxpC?=
 =?iso-8859-1?Q?ErfohcTMiwmZH/BAVS+pBNu818AvQl05vMFhfJeEg2d5NF4X6EImBDem54?=
 =?iso-8859-1?Q?DQchcgYwZXramshLt8HmWca1fbpa7gzzQGViZ400hPVURjcd1MGDvVijlD?=
 =?iso-8859-1?Q?mpI6nF1nCAH2rkUyBFN8PBMaV8NMuXR3XQuk8XVy68MindnLuh4FsOthr+?=
 =?iso-8859-1?Q?RxU+okPly3B/7bmhoxnAj15bfS9unMjua6lCwLI+ApBWUEUcpUnpjV7zLM?=
 =?iso-8859-1?Q?qfR7+RS1RTVsIuVIW5tM7JxP/OXFlxNE76/9CggeakfAjFfnIhZAPaz03C?=
 =?iso-8859-1?Q?vZFgpKQP6eYM6ZiTeoq1VEDSrZzRb0XXsDhY3zO8ZgcKvt80DaQPn4tC7k?=
 =?iso-8859-1?Q?6lrE18nPeSPgikZFSWzjR7VhDq9g9jQdKTA9rRiBwR9i2XJ331A2ZBVN2T?=
 =?iso-8859-1?Q?O0JpF2M9EBOINOcySGy7awfQC0Egb7JWD/lVYMnJ0LtLWme6hTipu2/Sor?=
 =?iso-8859-1?Q?Rjq7vWwCuI55RssOkOd9MLR78U1/zeLlMhjLL1i8W0w5fdvTLMNyPpE54S?=
 =?iso-8859-1?Q?23xNmRyRjlJVLtL99i1dbyp1cUY8LwX2V/s3ub5WOu9a1rCVUsbaOXhiaA?=
 =?iso-8859-1?Q?YLZ6a5eHiaS+44cyuzjdgrC21bGR2p76HCjrtdD1pRduYdxGr0sJGZLzJ5?=
 =?iso-8859-1?Q?xwsoF7J9qR+2FtaFz/I47YUSTwjCGgYnHfpQf59BmXOoOef0987fooNcNv?=
 =?iso-8859-1?Q?SZPm0fmvk2mc5t02zZQsh137mPJ6ZEPnPtB6BsH7ktR3d4wZQamD1MfkSC?=
 =?iso-8859-1?Q?C4dTLE/FDEuuyYvkk5m2jWFOjjoWm3DzlV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f22ec061-2e70-4547-15cc-08dc9c073bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 08:56:46.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvtmQOY5E+JnaKB4ttT20C/b+pr/3xaxDekV3GW0AbDSMNMlbDIqks33udHnJqbXpbp/rR+eJuyuUm32W6lmU9dXn4sjRalav9N5XkhtYHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10886

Hi All,

> -----Original Message-----
> From: Biju Das
> Sent: Thursday, July 4, 2024 7:41 AM
> Subject: RE: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
>=20
> Hi All,
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > Sent: Wednesday, July 3, 2024 10:36 PM
> > Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
> >
> > Hello Andrew,
> >
> > On Wed, Jul 03, 2024 at 01:47:10PM -0400, Nicolas Pitre wrote:
> > > On Wed, 3 Jul 2024, Andrew Morton wrote:
> > >
> > > > On Tue,  2 Jul 2024 23:34:09 -0400 Nicolas Pitre <nico@fluxnic.net>=
 wrote:
> > > >
> > > > > Verify that edge cases produce proper results, and some more.
> > > >
> > > > Awesome, thanks.
> > > >
> > > > Do you know of any situations in which the present implementation
> > > > causes issues?
> > >
> > > Uwe could probably elaborate further, but the example given in the
> > > first commit log is causing trouble for a driver he's working on.
> >
> > Actually the example was a constructed one. I became aware of
> > mul_u64_u64_div_u64() being only an approximation while reviewing a pwm=
 driver by Biju Das:
> >
> > https://lore.kernel.org/linux-
> > pwm/TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.pr
> > od.outlook.com
> >
> > mul_u64_u64_div_u64 is used in various pwm drivers, but in practise
> > the periods used are small enough to not be problematic for the status
> > quo implementation since commit 8c86fb68ffcb
> > ("mul_u64_u64_div_u64: increase precision by conditionally swapping a
> > and b"). At least I think Biju (added to Cc:) only hit this problem dur=
ing testing, and not in a
> real world application.
> >
> > I intend to do a performance test of Nico's code. I hope I get to that =
tomorrow.
>=20
> I should be able to test the new patch[1] with [2] as mul_u64_u64_div_u64=
() used in [2].
>=20
> [1] https://lkml.org/lkml/2024/6/28/1130
> [2] https://lore.kernel.org/linux-renesas-soc/20240614154242.419043-1-bij=
u.das.jz@bp.renesas.com/
>=20
> I will test and provide feedback soon.

I tested the patch [1] with [2] (CONFIG_PWM_DEBUG=3Dy)
I don't see any idempotent issues. So,

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju



