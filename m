Return-Path: <linux-kernel+bounces-285949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6679514BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C845B21920
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC8136E2E;
	Wed, 14 Aug 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="qYfXin9o"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13438488;
	Wed, 14 Aug 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617350; cv=fail; b=kgP4rloCi6gigu7tVmuwtFgNlD/d/IpS9frX/hxyOLIynayJ4K7oZEVpNxbnwVjwFSLpQ+Onz2dB0g5JlAaZGluHGxJNllnuMNCaWEkdWf9UM9G/KbuU5M9sePrH8kdvRnogy3u+i8oW+gMYWDbe1hSsLDteyWOuGnk4otERqho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617350; c=relaxed/simple;
	bh=r1kt4AYwag5bAGvBdUaBafUzi55zzD6cqwQ4l7wnlbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgO3aD2e5v9N+JecU2VumcaMn8jHXqFTjZcIBnMDts0YGM8fMqA4WqBORS+5iExoK0plgmWw09bHxa25ueBT/FUvWO4vtEmPbHAUY9CRUW3Q5gNGS9woTG/Kebsaaw5SlK6ggdOMFuZ0Uu+SBYgP5cgNATTB6ncEsTWHJEZOI48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=qYfXin9o; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh0rWwJI/rmWXBiIB547ZQoxH1iJR/HRfny3zoiI/j/HEJq7HcC6ny5CRwppjXW62TV7kjrw26OnNWZqAAqt+qAuOavegj7eCb+wzd3wwmDVb42xyNSLfRgdT3opyCX40va1t6bYgDI6KIOxiuWEvq9dfkbX8OQ8vOGSkqO4gspil5UfK+GUGg1RzWFI/oclmaCJeMHbYq+1n0LKOyNzzHz5hAlTIDcJ/3dN0rVwa5lv4wieivrRCKEHIc9uxHewyc7dSCUB6lvCnK+8MuAHPwkn4+ubxUkjcTztBVO6NnUelUfXuLrXJouwM3GzfaCimTaLGUQwlOygW1lhCWqADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVkmv2kj2b5KAJ2inO2I5QDEHLuZYQm+madsOrVV0tg=;
 b=ddEyjabNw2m2woYp1O/kVSZYQUk8HRuQf5SMLJXK0zXnlZbKU6lSLRAnpowcPB8WhYg1Mv8j1j4FcjWbD0aWCRo8YCS1xVY71gHfZR6oLqYBPznzNYPiTezrp5VLGhLZf22Xog2/uVzIKhBUAxH/pbAVlrjwWot04L3i5ab+6ngG73kgQVtXXc+6pAHKROEyBSLHahUmbffTlN0UNULi+7ehAyuRsIl+u4B3YBomUlW9crQZMLxh4ZmSlAw2SG18YrvXJNNKY8+VVzirVDWFcc1U8fyiOdK+KFmr6DffNnh2wZSMMfP9wONiF250RamhMS/Lk2yB/ZPEgSlk8R9FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVkmv2kj2b5KAJ2inO2I5QDEHLuZYQm+madsOrVV0tg=;
 b=qYfXin9o2rLt7qw2oS7wdSBVY7cuKb8X6qeGyZm6bTHkO8jPm6iO1sftOfAEOAzdUf2rZ8GyN3y9ec0/pKKNSG7klbwMdM+BMSoIpYR4+KWq05+cGjdSgWLRjzDASD3JEDox6l00yUc66sahSkwnlPE9D7HT2GK5WfwKRMYp0M/g9At+GDlonMV6u6Wd4cB3eNi27DVw1d8oNJ/Wp3Yhkqwsd/ZAJ40SSFrndYlXTNy9XRMgAarOaeGCXnc/irU75qmkcq226MVSraoFTFiPs95lhbFUGeP9rbu8yw8I8CTOqpF8ljkM/VTenyTp8riSb2XVSGmJAToG9OudJqdsbw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB6998.apcprd06.prod.outlook.com (2603:1096:101:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 06:35:38 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 06:35:38 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index:
 AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAclgACAAL3qcA==
Date: Wed, 14 Aug 2024 06:35:37 +0000
Message-ID:
 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <20240813191454.GA1570645-robh@kernel.org>
In-Reply-To: <20240813191454.GA1570645-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB6998:EE_
x-ms-office365-filtering-correlation-id: af10710c-1f2e-41a3-c714-08dcbc2b4f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zhGjoiwSW76+mf9r9Vt00zuzqNahtaTZx0RqTVwlqsSeHSIMKXCld61q7Ty8?=
 =?us-ascii?Q?uE2h/7FWlWDngXZNeStyETOpumjgtN74TdJ13Cw+V8jhvSmTdVQ0oDPiBdiC?=
 =?us-ascii?Q?/vdKo9MhAtzpYs7+D5Lg4XEnq6VlQZDdZjWZBzVBnWQ1z0zfPZwV18BTXXTX?=
 =?us-ascii?Q?dhlgIS0tVASjs3FQ61rwhWwpCa6fu+GBLRB5khXqItUlw0HaQRXp1CA+KPCW?=
 =?us-ascii?Q?tfffHoRbM26Hzwzl4LNBr/CGbSpZuKGB13BnV6onwp70c8LqeU1heAV0z0WY?=
 =?us-ascii?Q?oobG+C9P/6Ezms15RbZm+TklqWTcJH2IuSl7waodr/N+/TX8ZIpBPngsdDZA?=
 =?us-ascii?Q?3uL8Af1XLtMf8O+4uJoBseXOyCmOxN0zNXOhnLWGBNAT84QN9XffGECLb/yo?=
 =?us-ascii?Q?YPn2KC4+3TN3Z+8hP8vlthIcTqjIhslirKiEpp7wWl8/kAkY/0FhDJSLarSj?=
 =?us-ascii?Q?K5jPpQxTyg/iFfLqv4z94VyzO9c/fPGw4IbcI5e2axEu9AbVP4TBDYqbIjkN?=
 =?us-ascii?Q?Kztuk2vn9WoQ5bek3Za0BTj/N/3UX5yLKgSGW45XX5pg7DYGCNItz+ouuQBr?=
 =?us-ascii?Q?O72q4ffEi5tLE5OnYxTnVBnArrEsvhzo2fX2jfAyPMzwn1xMJ8bJmfzGjniQ?=
 =?us-ascii?Q?MBu49e77bkzsNnnBUkCN3muDoluunL0yvFidDfR7mNCE+VkQsvjG2cLAINGK?=
 =?us-ascii?Q?AGbwUQUbgUgorgIk3iSrISX8JTI9CiRRJ5WgxZyzszotJLNSpCs9om1HEHRh?=
 =?us-ascii?Q?OOoIolUNT9EZoieM+hadADr5bi0I2/1nb6G1tadcpwNuRKhZLFuPKOgG6m48?=
 =?us-ascii?Q?2+igOV02FPNIN6X+OwAWT2X1m0WhiMbMoVG22EUiONtbYpEi/d4xXzVWztTE?=
 =?us-ascii?Q?/n4q6gZ/7kfv8kvu9Y60theT2SW8jNTqsJJyiKyWUSLLd4UUehfAvHB6vIQK?=
 =?us-ascii?Q?A8N4guqmGc0B7fWS5vJLFDwnEAJAZ1OeUTTz8U9l6JIG0gNQEZixTnRfW68q?=
 =?us-ascii?Q?vXPVPyy2NjmV0YTCu3bSag3KycW4TTJ1Pq/TkylBT0yBrE2u5aNjgvv6C7Z3?=
 =?us-ascii?Q?x0B03wH6hZYvFXEdYspA0WH4EVQgU9xQLa4Gkg/+MoJaSM1h9NANYra4gJ6c?=
 =?us-ascii?Q?4+UyoW8U8YjBn69aqXSJ/86ZucEpzsO8jCFc+0Xb+cHYkaJ2eJFLKK0izMIt?=
 =?us-ascii?Q?bsC0T8wjgOnV7eoHCIXoG53H79AzhZT+kTclbVKAgMRZ3kqEyWabwl7aNvy7?=
 =?us-ascii?Q?FD4Wr8UT5bEn/ygaV0u3Jg5Tibqo3MLs+DgJHKhCoA8Nw5V0nsrUwCJc4Uep?=
 =?us-ascii?Q?Sif3UyTvSAHPHEnWkauuGyV61ByczqsvG4vSeU7XxFoWuyZktakuaOmJX//l?=
 =?us-ascii?Q?vyE94on4jIKiW4rlG5fWpS4l1azsB5nhHqY7FLagrrGS0c6Faw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cOWb+9ZsIW9gI5VJwc7Ul9WQSFX7ZcbopOqe4nhGHTj6BIrarLqKI//sHaid?=
 =?us-ascii?Q?H80Z7CwnlWcU6aF3Cb8dX8mQPBxHKGjoaMyOmNqSNTDLpo9u9l5dCgcgeYIl?=
 =?us-ascii?Q?eNVlSKL/kKxRuh/TGucEqrsz4L5h1uDyTFPF/ri/baOqoBl++RGGR0OYDZsH?=
 =?us-ascii?Q?hhUxjC+cPDCTrXMsssqyWetS9qfMwUkzm1sl+gyEAsHNLiT5r/qqkpFShdjd?=
 =?us-ascii?Q?MZyFxRaJBqPJVSDBh38uu+ZQnMWkH8Gm+LUqb+PuWoQaivHCaKlZBuOiLnYW?=
 =?us-ascii?Q?Wsb/wKpqwQAmt3wdL01g8JJuCQ19gR8rsDSgOnjRBuLtJMlUr+wecH6ydZ0a?=
 =?us-ascii?Q?Ogyqc9bfXeUbRPC4I1ejuHhSk8lIlAtLGUi1OdC9mgjG605pBpCeONkDGL4r?=
 =?us-ascii?Q?OlibvTW74XnlU0aLQiTEPN3ph0/7gQYBqhUKCykBTgmyWibtG1T3lLDSgNG6?=
 =?us-ascii?Q?G/ASmSZTxT+gcxsytyrJdSXTetwY1DPgQwerqj1fT0D99nWt2x2YGIrbICK4?=
 =?us-ascii?Q?Ot9x+QCCuNQEiTLRqZ3jVPRSf7y/Ew5+csVccDHVqYzxXjq/dX1tHKrg+8XF?=
 =?us-ascii?Q?zZvrEk/Kv8XYtUAtAVExPhGZXH7hz7fTqHpkkJJrZ8c+L9npOs08JvfWZ+Sy?=
 =?us-ascii?Q?93Zh273xBupBVv+f7Hil8V/qBmyDuEVbk31gtygT2WrZzV5wd1WL6w5SPIlD?=
 =?us-ascii?Q?xvtGe6NhhDsCc+9qGoGyd4wJ1aE1EGI8Ous+J4dRF+1wEqQgdjIMuUGBixop?=
 =?us-ascii?Q?rU0bWA4+ZkzABF14ZfeP9LQIkHKUFqRubz51ZsG2unOMsGE9K7sT6CiLI/QL?=
 =?us-ascii?Q?4ySutO70RhyT9cNu8fIYATHnf5fZhbklgELiSrJVW13r+xHqye0VhUy6u//E?=
 =?us-ascii?Q?BkNjXUHLvYb4io8veS3QwztFm1vZotuYY/V/MmXLfsl088xoZ8jzpHAlJ78U?=
 =?us-ascii?Q?OtbbtWCH0HEbzioVFkWYaOAWd6ksm7zSn4I47fL4/nPcBcbmQzukPqiAYQnK?=
 =?us-ascii?Q?n64qHIghlbhCbK89o++95Wvr1YL9lo3xI8PGbQl3Angf9jUKNHVVsWKadGQG?=
 =?us-ascii?Q?HfI9IadDl42DYloPjbPBDWsRNM1j7ASOWdPorxnML5/0CKas0TCCuuVwqV6Z?=
 =?us-ascii?Q?PR4m2ac7+oeK+isU8C8D54JyycIrEfN/kzvfQ6BT1zxPM3vZJ6vv2ObDN84f?=
 =?us-ascii?Q?bYZrZku1eK2FNfHVzo+fXon0Lr+qkBb2UnlCef5m45p38NLvYAvpll9C8mLO?=
 =?us-ascii?Q?H1Pln8mAGc8bTgV1pOTSIGgGRQt0YRZ36fKq1aBKtFiO2qk0NVduqc+EK7nu?=
 =?us-ascii?Q?5jvAfTconzzV5PF5OALo3bnuPqcY0EpPRqya5h5eorlL4Ye05dLJlKgnzVcL?=
 =?us-ascii?Q?RUp+OlqdW7DEwanRpZ5fkoTDHbmxp5JMuCHVX0IU2PD6HtUinx55do+LufUs?=
 =?us-ascii?Q?d73pO12t5d2oncg+8EAfWL5bxZ3KxBZvinWEcKzuIPKmL+pnrsYXDe75xNfj?=
 =?us-ascii?Q?N4sdg+HheQDfsAkgZhc9pGPS8pNiG2ykflBSL9LZ3fR5CS71LiGAPnZWFjO4?=
 =?us-ascii?Q?CGbluDPc4eYe/5vvnYkh3irX1nkwvmm+Er4tT4we?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af10710c-1f2e-41a3-c714-08dcbc2b4f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:35:37.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXANUK+hIYGvuPkG/aWmZ0Encas5IcPNCp3PH7/TV3OIs75dE/EtnEDqIXDVTBMLAOxU9gxlD4qpI2dXFP7qJisXBjtucvsXmE/194Mjv04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6998

> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
>=20
> On Fri, Aug 09, 2024 at 06:10:22AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > > AST2700
> > >
> > > On 09/08/2024 07:55, Ryan Chen wrote:
> > > >> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > > >> AST2700
> > > >>
> > > >> On 08/08/2024 09:59, Ryan Chen wrote:
> > > >>> Add compatible support for AST2700 clk, reset, pinctrl,
> > > >>> silicon-id and example for AST2700 scu.
> > > >>>
> > > >>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > >>> ---
> > > >>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
> > > >> +++++++++++++++++--
> > > >>>  1 file changed, 29 insertions(+), 2 deletions(-)
> > > >>>
> > > >>> diff --git
> > > >>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > >>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > >>> index 86ee69c0f45b..c0965f08ae8c 100644
> > > >>> ---
> > > >>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > >>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.y
> > > >>> +++ aml
> > > >>> @@ -21,6 +21,8 @@ properties:
> > > >>>            - aspeed,ast2400-scu
> > > >>>            - aspeed,ast2500-scu
> > > >>>            - aspeed,ast2600-scu
> > > >>> +          - aspeed,ast2700-scu0
> > > >>> +          - aspeed,ast2700-scu1
> > > >>
> > > >> What are the differences between these two?
> > > >
> > > > The next [PATCH 4/4] is scu driver that include ast2700-scu0 and
> > > > ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
> > > > "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
> > > > CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
> > > > ast2700_soc1_clk_init);
> > >
> > > What are hardware differences? Entirely different devices?
> >
> > AST2700 have two soc die connected each other.
> > Each soc die have it own scu, so the naming is ast2700-scu0 for soc0,
> another is ast2700-scu1 for soc1.
>=20
> Didn't I see in another patch one die is cpu and one is io? Use those in =
the
> compatible rather than 0 and 1 if so.
>=20
Sorry, I want to align with our datasheet description.=20
It will but scu0 and scu1 register setting.=20

> Rob


