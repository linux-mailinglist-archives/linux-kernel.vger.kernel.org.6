Return-Path: <linux-kernel+bounces-240612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA80926FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E741C213CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565791A08C9;
	Thu,  4 Jul 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="upmOxPf+"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7691A08A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075248; cv=fail; b=gNZ3Hf4AT7KAW2+M3p2H5YLbvXNEZ1UzvdteAM6evlzePwkb9ZakrByYVcp0oK8J45hCcF/c/1WKAnuEYEgIA5zWOkQ0+CAaZoqJPdFCocnCrxKyZiRYIJFeiICDA9CLV/eknBAqHT9vSjzKnTt3wU7OHq2Z01QprEa5gY+1TFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075248; c=relaxed/simple;
	bh=Ie+2dgwAAkP3GrTZFizElk0xdCqLneZsN3BWK2EUFfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTqtAxCViaBvFN+LPhnDWVBpIlkcMDwJB4HRtw+z5T2sUuxugD+3OyFCv1Pn+JhR9MK5vzERZ7vRHuyCk+CgmiTTeS1JTTBkIqDjIHKVayygRC3Qvx/Jw+st+b4jtsnwhtnBugUv9EGDkdTsjKKzamVOsEMZ0Zh2mKYZiD8UNkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=upmOxPf+; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6ZnG2aQMQk05kNkifqFFh/76nTX+OF4uKuxvKEWe9hXKut2nTlQRsMKVTm8XaJAuVfyH2hUMKaGKIfy1lyyTm2fwsAMXRFoeN1hJtuVtOvFTCdloGsL36rQcNUgFwKOls+FMEtf/Vj3sIbv7Njij8E+dW42FNYTl26wicIhzV+mzC6BjwzSsPWRCvFwv1NqXk7SL8LXpS0CSepsiVJbnlYRxQH1hMIgmYf7cTbWo6lvQ22aBUYK86fU578UrvdJ3XMNIJ5Oou9EgQBm5p24AE0DQYGYSaReLcNn873zJSH68QQmKa54JGGy4BT4EJtZKD6zO0qgyMKHxFk9IBZknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isEdrcOl6t8UI5qxhLsjvpsAunesIVc08b95/bFV08w=;
 b=I3QDKuPKzZZeUenqcsLJzIV7RbrAXw2jvZrzv6Okx62fI3dMktTT3oskoYVLHgkB5sgbzVVQtsHWM5gBe/Kijmb2xBxUS8A7rw7Sc6Tarugsf0yM4Qc1fe/Jg0YHq7tmqMPwMipS09+uv6ht7BNtN9qdPtVp5DGIP9JgDnhxx5jDS4GNAYCbxNBEe4x2ZKTeuYyf3y/UA39H4p4B9a75izy0WjSOTHIsoJdkMbv2HjVqE1BVx1qjdK+q1nyw+iWP1PFC7as4Z1aINbFL9oVqmefF9np4PLNNZT/OPRtO+xD5AFTE5y6wm+Xo5uQ8vrh0LBEXKmvlfisxjuk4aYvjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isEdrcOl6t8UI5qxhLsjvpsAunesIVc08b95/bFV08w=;
 b=upmOxPf+eTruWYpwkdphAjRsYZMcPeHpImlsHAe4T+wrKaRgsSd6OI4PYfGg9zFxjlimfVjviSIAGeeII5KGyu+YihPLaKQYDyz/2pA8U6EFgdO5t0X4iec1Hn5Kd36AGGecIV52QYi65f/xwNkO6YFqrSBKV15Mce2Cp5ih7rk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8383.jpnprd01.prod.outlook.com (2603:1096:604:192::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Thu, 4 Jul
 2024 06:40:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 06:40:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Andrew
 Morton <akpm@linux-foundation.org>
CC: Nicolas Pitre <nico@fluxnic.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Thread-Topic: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Thread-Index: AQHazZEUBvMAYbNlJUWAdVEYoNoIYbHmHgxw
Date: Thu, 4 Jul 2024 06:40:40 +0000
Message-ID:
 <TY3PR01MB11346F310DEBD3282268154B486DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-3-nico@fluxnic.net>
 <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
 <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>
 <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>
In-Reply-To: <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8383:EE_
x-ms-office365-filtering-correlation-id: a73a5075-642f-4fbc-708e-08dc9bf43876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qy9pE/FYZxic7tZ3GbX1ztXpWlMEmkV215ZeLhKB42NkUecqACDsE/c9y9?=
 =?iso-8859-1?Q?kx2uMZlls0cr25/KTd2onPSIVF/+WBd3LQeMOgD3ixLZrSOS867hHttu7r?=
 =?iso-8859-1?Q?lyNUFV8Z2Nf20wE6DhkkEhXcd3tLKg5pYPICM/IYWGv6DJS62ZY9TyBjWr?=
 =?iso-8859-1?Q?jOpX3u2vuAW8lLTl8o0AQXFnYx4QeFpHIygfg4U7KSpMzdSbXSFPIgiaaF?=
 =?iso-8859-1?Q?LSADG6pJ9RQbRFuqtxKJv9kzFzVOt6hgGD7turTbhpFgdKzuV7XApNBF4p?=
 =?iso-8859-1?Q?Viqgeg1SFErYfuXta+AeuAy14Vy/UljmYktoSGFDkVizgaIpK06F+PRKVc?=
 =?iso-8859-1?Q?qlbC9u8yWS3Vw9Xz/BviXjeGUDL7KgujNDT257fXw1IxnwpTMTRRutmp+r?=
 =?iso-8859-1?Q?DVq4wP2O5QvkKLx/AWnPHYmon0VbRcHm/TTCPZ3MS70DOhpAnNT9TF+Ogu?=
 =?iso-8859-1?Q?Cj8LBl7hBxmZTURxIt0+W8H9a53uraToYC9awSbfzpClTuPwCLO48BPsLp?=
 =?iso-8859-1?Q?Uli5yf2t3DrQQnILbmxWKKr1Bej2S1B/x5xIPCGGh2zoZyvtAQ5x7yetBr?=
 =?iso-8859-1?Q?wvzneGfMuJu4OROaS7sw5WxzwvQEUJ5xHhvvFYds7NTOXVcXmDe7sTR3QU?=
 =?iso-8859-1?Q?FYg9DB9snGO72HZMofJKpTIZ5GNbsXbHoZ9L+AKd5u+E74fQ+FaVe9cDlW?=
 =?iso-8859-1?Q?dnBKvAZNPA7CVENZuJ3Ag78kHtc6HcQOKNl1yF252Ypt6cWiiM2sJqUAWj?=
 =?iso-8859-1?Q?00xFMS5ABq/09e5srYStTwiPeOund5CAxw9D58t4j36xoh39VouP09+rPt?=
 =?iso-8859-1?Q?Jw1JLz3n2VgrwecmftxLHuhU+Vz1fHa+z/VeTR4iuKaR/NPZFWMXQWNQai?=
 =?iso-8859-1?Q?n4bxpWr2pAbWGA7yzeXJItCHkkI2GeWR2a4IO7B1XwicHWsNTkikrKWtGf?=
 =?iso-8859-1?Q?6WzRlX9a9gz7qnx7r8afrwkKFV/0rLMFK/96EzY9my5sjYsqCKD106pLKS?=
 =?iso-8859-1?Q?LB6aroMptPxyk91TPXyoDQR/xqwngjBvE9jdAsIaLwTJ0jTNL6iHcanhik?=
 =?iso-8859-1?Q?UfdbUBXP18FfmgUQ4yYyKEVwdvkhrCcsx9A4QokvLFkLEyYQfZG/mzYRY1?=
 =?iso-8859-1?Q?spova0zsQepKiWnvap1kI1rm7QbmJBrqyAFFGkYYlwJodQBQ8s8++WtQbY?=
 =?iso-8859-1?Q?4JkZVo7aQ5p/WDZpWVpg4Csf6iOq+xiDjU6JqOJNpKzcXZ6vNMgXB9VN6X?=
 =?iso-8859-1?Q?rsrcD2STC5uHZ6wx2o6/dkcu74lWzPfjSg6rgGdj98a22/qBgDhJeENFFq?=
 =?iso-8859-1?Q?HNvFbdeEbkKKXFYm7vztw/w7uk2XEzB9KRE7AlQLjNgOR26P9j20zBfppf?=
 =?iso-8859-1?Q?05I4hXpmxzuelQvNOURjNusOKKMyCUNoIpZfey/j0W4VnAdI5y9eQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3O1AN0FuMsGmo7jnk2535lx7oCTq4jQZRm4AtKkVV2iU+4e8FCKdjwaos5?=
 =?iso-8859-1?Q?5+kkOkScu8NDQHv79tLBIi77zNquXH6KGYoKnpf/8+MJiRE/g61svseQoQ?=
 =?iso-8859-1?Q?a+XoBpfMVBwSJFvOErICW1BuhM9+9kpzYE2dUYG6LTdQsMN5asTaGxlFd4?=
 =?iso-8859-1?Q?RBFaf8SdCQROd8R++rwww54HFAr3ErE74QGifgQQ9gHOCEnnJu2KUCjcw5?=
 =?iso-8859-1?Q?CWW8Z3HPHwZAx+4twJzXv+1JSIL1vtXE4JgMoR0dv7csmEv9r9rRBH+8k+?=
 =?iso-8859-1?Q?2gXaKkIc1V9VBuS4iVZcWJiDptPBe2ZBAI1BAtt40pagZgmbvGzTcgSOVc?=
 =?iso-8859-1?Q?q4ZYQBFTii04m9m6HB9T4O+LYTrsEjd4KS17bqwFafHhw0h/H4VoY5SkYk?=
 =?iso-8859-1?Q?6Qq31i0z/IZBSb4IaR/Dv6WPLKAlc6oTbLsXIkEeV+EckXqJnpUljb2lJS?=
 =?iso-8859-1?Q?Y1llzJIezKZEYdjuOzzmEgBxjj85LZEl1c6MbXObqZ5L4lixNk1IwuJlxw?=
 =?iso-8859-1?Q?/jp3B4CpPJNR4ia2X+HCaEgb2aPtxy/6yARu7yMPZ9xN7fj6HT9TJh3HAl?=
 =?iso-8859-1?Q?/nPSP12NCgxS5Fgltnh33PnWf7wynJs6KD/WeFC+dO+wHKId6eVJfLT+wb?=
 =?iso-8859-1?Q?4CfN0i8MypQmQQGzZdmP1AcfJhUkqryhI6tfepYSL+/uz7Gteg+j1XZx5M?=
 =?iso-8859-1?Q?SBSgPnrjFknLzx9nYT9xJ1BNnUhIDjHhryUX2ezZLSyHgfqHQQRafvG6nZ?=
 =?iso-8859-1?Q?kpwsrfGRF16ynrR9crgN51WlMFvwlx5rIZl52uSc9nCK9xye+DsnxtYcxo?=
 =?iso-8859-1?Q?vEVEXdxEHAEmj3qTVFBoINQO4sFLaz4rmulm4E/Ftr0ofMpYZJi0dtQ1U7?=
 =?iso-8859-1?Q?7IYAZFDRT7NpqlO45rEvei479KCeZJ9ajtWwu2OUsRbtxFTKnIATzzV85G?=
 =?iso-8859-1?Q?IrVtWLy/27xEH4MZ8u+R/27qpRB7GZ5RnMdy1MolqlS8hE6icMEtmYfTpd?=
 =?iso-8859-1?Q?rot4XLgpHMQYNOW03HcgH1yRm5iBaBsoDnUFM3klay6c1cHc/Rk7Yy1n1m?=
 =?iso-8859-1?Q?7dTF/B5wtyn259ZCTqcBQsgkSqm+Uoc303sdgIfWrpyE6kIubFlwbvL78Q?=
 =?iso-8859-1?Q?fJTjubveVCatTC6YtfZFdUfcbN59+j/AqrDUBPzUsSMdg+KkUL4iFN31f2?=
 =?iso-8859-1?Q?oUlEgdBus59tXLwLJpnY5zA+e/HiqFwl2c17P9ODJEKdoIKHZk914hZGRI?=
 =?iso-8859-1?Q?6G5aETVuURBvc9Al0G6NatARyjWpa/TRhl7vXOyQF7yXBnKLYwlfuKRwnL?=
 =?iso-8859-1?Q?ghRvec9KLnHry+F0yCnK+LQcoKSSGfaT6ernItB0QHnM8z1+LsP6C5MTiF?=
 =?iso-8859-1?Q?SWjg5ZiBi47B9/rYg94keiBWxdptoyUxkLrX3K5JwUSaEkg1gpFDr66OJq?=
 =?iso-8859-1?Q?/wUcsYZbniUdeet/WWleKzZE9g/0GbqYYckAunBj36OKAkxvmYuceS9LK4?=
 =?iso-8859-1?Q?zPfIuij8k4NR3cO/9ud8Jl1tmSwQDb5fAUsrZMN/kbSqR03zIqZXlIoNzE?=
 =?iso-8859-1?Q?tpBjA4VspUgiJgy17RNT1Y5xd8+H3vnWIroKXTzwrqn9CkmNcE6N6/QMaD?=
 =?iso-8859-1?Q?ZEG5q8/yG/AHyn1tOvPXSfxG5G34OX+Mrf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a5075-642f-4fbc-708e-08dc9bf43876
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 06:40:40.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTntfPMEv3mO9t0vj20Iv6JT4BCJTMgQuMZfy2dvzUHeUL3LmaNjIqTNVCmBwVrFNRZ261LxoB30eJuxz2vFdk0REQHrheQ3EFOeo8pemUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8383

Hi All,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Wednesday, July 3, 2024 10:36 PM
> Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
>=20
> Hello Andrew,
>=20
> On Wed, Jul 03, 2024 at 01:47:10PM -0400, Nicolas Pitre wrote:
> > On Wed, 3 Jul 2024, Andrew Morton wrote:
> >
> > > On Tue,  2 Jul 2024 23:34:09 -0400 Nicolas Pitre <nico@fluxnic.net> w=
rote:
> > >
> > > > Verify that edge cases produce proper results, and some more.
> > >
> > > Awesome, thanks.
> > >
> > > Do you know of any situations in which the present implementation
> > > causes issues?
> >
> > Uwe could probably elaborate further, but the example given in the
> > first commit log is causing trouble for a driver he's working on.
>=20
> Actually the example was a constructed one. I became aware of
> mul_u64_u64_div_u64() being only an approximation while reviewing a pwm d=
river by Biju Das:
>=20
> https://lore.kernel.org/linux-
> pwm/TYCPR01MB1126992DD51F714AEDADF0A4F868DA@TYCPR01MB11269.jpnprd01.prod.=
outlook.com
>=20
> mul_u64_u64_div_u64 is used in various pwm drivers, but in practise the p=
eriods used are small enough
> to not be problematic for the status quo implementation since commit 8c86=
fb68ffcb
> ("mul_u64_u64_div_u64: increase precision by conditionally swapping a and=
 b"). At least I think Biju
> (added to Cc:) only hit this problem during testing, and not in a real wo=
rld application.
>=20
> I intend to do a performance test of Nico's code. I hope I get to that to=
morrow.

I should be able to test the new patch[1] with [2] as mul_u64_u64_div_u64()=
 used in [2].

[1] https://lkml.org/lkml/2024/6/28/1130
[2] https://lore.kernel.org/linux-renesas-soc/20240614154242.419043-1-biju.=
das.jz@bp.renesas.com/

I will test and provide feedback soon.

Cheers,
Biju

