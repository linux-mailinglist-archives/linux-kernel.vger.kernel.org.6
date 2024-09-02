Return-Path: <linux-kernel+bounces-311438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0F968926
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF384282915
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DA20FA97;
	Mon,  2 Sep 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="iqLoBGcL"
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020104.outbound.protection.outlook.com [52.101.171.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880B19C540;
	Mon,  2 Sep 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284900; cv=fail; b=N/pS+8avKT9qJw+1FT6BNvR9mZZ1Qkp6GJ+BKtvM/yRpo+1aqrl5RUxj8dWbkwrMKVTTTtr+ian/x7aJDrPTd8gmdc3eofaGSwcf67IEACwgn737M7Pew2aA8d97BWhkgd8kHU5XiPGv1nr5PVIpYsXIEITAKXyrX+sMqXzHvOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284900; c=relaxed/simple;
	bh=8JgssiNmys47BF0aMIX6V1iI6fSZFd9FNmiwFcxdR5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iumEqu4G5dV4WkjZXYKQx2L6lmQlIW2ET3BcNbsMMoVJlbHxMWlVNoZ86FtsdYzNO73HcPHrKEqx8RrKwlIwxS+RXUvuSq8zkmEfc7XSASWcrHBVCOo8KA1gyvMPVIx/lR8x3FDNm53iw1otVR9+nUCmk7DJ0b/cUnBB6hNkBV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=iqLoBGcL; arc=fail smtp.client-ip=52.101.171.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoZx0FsOLZAMRAh0NUsG36rU0TDwKet40SGlGG6uT75BptNtsAqAXK1UvjYFHNnDtDo3oyMoNBKscwbWl+J1ukSiumw9IiXB3ORFvNYn5zsp1XOEqe8pMSEKfFvFBF8UhZR1N1xadGwWf1zb3j9eLodYVUDHm6Cefj4LjGSGPXYT31icsSwSwgb7NExrty9HTjjYTGsavkLPT6pGDTR3DjM31f8Pb3l0kEkR0Ex6Ik6QbT8fT2WN0URMVn1HltIqI0zTwm3sV39fZ/xcRaDCgHHvJG60eKRT9JeYtiC65c3QuBwqofBw33wj1XN/zAUTHidDKS0YObC2EDsBYh9jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtovIb9ZY60GfgMivD6PAB5hphJxZMyEzL2RhR6GNHA=;
 b=n6oHkqlVdk6NlUqHAwXBhBfphhr24rdKC8ruOSF9STAu9v1+i1Q0acAJlpwRDSOLsMfNsUjMb1jCd9Tgfvoc51lTFPMy/T/QmKZyBpJcVG9J4Z/v/yvkCbCpRxgXwTGK0C5XUmGfNTyc/EH1BDgNjE5CGFbdmEJRn0fEmbjkD70C43ZXsnnO83w6iGNiPMG1NRMopr9/+2Mot+QzGpS1vBxuLItGpQyVRVoQHyZERcgdIpzx/CrrYaoXqQuEtNUAm4vNt2k8613BgQDSJ+RWaQDm+M5EzJ5g8M4vcKlA9Sg6bVzM9tsO2XpOK6JbB7D2PVfluszkNHyu0AnccrP/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtovIb9ZY60GfgMivD6PAB5hphJxZMyEzL2RhR6GNHA=;
 b=iqLoBGcLYEUAsl9q46SfFa/1Kzdl0eplgSLrP4eyxc2Mum6UlQ2bZa6JGcIKos0fBKzpnFb3bI2JrIPQE7od3kAnG3gBHRcvl4myDWSu/QlMkfm5AUdbPWYMaz0qiyiP2BcPzZeLA03y+vJ87Dkx5GKeObAyk6r1UWUuiH7FihZejUQI6oOXwkLd7n9eCeIniGg/D5uNRzWkd2JZjbsiRHnKC8aUUg4UXbV+dKCN+B8LONTVK3na4bgdOE1adzXuNz3J7VWNbAqDNAFV7L993GR/UYO1SW5Bxf555V6ARVrjP140rOy7lknbS3u9XsA60ia/qQo3Nns1YmqYyAzD3g==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:72::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 13:48:13 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:48:13 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>
Subject: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Index: Adr60bwOPjoiJD3QTreu2+tBMAOlGgAnzy+AAHKnFXA=
Date: Mon, 2 Sep 2024 13:48:13 +0000
Message-ID:
 <BE1P281MB24208DE67DB0B1E9A75823ECEF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <ypez4vjmasehqflgi4ylylpicldabf2dc6wwjco34qr2zmkdvx@enejrjjyaulf>
In-Reply-To: <ypez4vjmasehqflgi4ylylpicldabf2dc6wwjco34qr2zmkdvx@enejrjjyaulf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FRYP281MB2969:EE_
x-ms-office365-filtering-correlation-id: aa90ed47-bf52-40f4-031a-08dccb55e3bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lW4Qe0vRLft18+LTuzKGwMly6YElgylNVNIaaWGMeclF/olZVGk7H+/9xMwB?=
 =?us-ascii?Q?8gQh4ThetH5bgE7WZvSEEzZZf0GLvIXv/p8ddRqY/YKxDhbSg70GuSQXM9hi?=
 =?us-ascii?Q?hODHrBvWHU+sl0YgW9BZpiGVxWCgq4Cg3acxXpvBGmeYSGgL/8sKhb45fwEm?=
 =?us-ascii?Q?IHAdaQnRQuxntchY8o52nlgEZghfIoyoe0Q5tdJma4bgBPgPHy8Xsf2aX8op?=
 =?us-ascii?Q?ZUq7JslA+WMxZWZEIEAfvZMIlIb8fNeC3YMEFnhlIq+CiApd6aXfNt3al9vh?=
 =?us-ascii?Q?DziQUuDaZiZJtTJ2KZW1dUmkgpTFf29rhTI4z4HBIVXU9izv0VofsBRZ0DXd?=
 =?us-ascii?Q?L48S/d7+D0NQkDVGR/+DJSJmoAsBtBYlybxKPG4FVu9dvj53TdFjSGoX0zGz?=
 =?us-ascii?Q?e46p1sO4yfZtHsc7ajMSDH2FkiodQ8XVPMOMuJN8jnnrPJBkDE50V1TiLYR0?=
 =?us-ascii?Q?UlyLvQrE0LE5T2Jc6MuM6breqQsnS83TGfTWGFixqCSC4LG0TXOoOuGOqr7W?=
 =?us-ascii?Q?RjXaZ9UwsNxviYksMAWoMckH1ETDSGotY8aEx9Yx51XQX/+BQ99dbdRgmYXk?=
 =?us-ascii?Q?r/WuJhYVmV7vM49mXp/UAycP1ql1bFUnV1/g7GFA4xNoYQYkJ4pzeyOAysz0?=
 =?us-ascii?Q?Itdn9q8vFNRpFuyKo9m2h3tCkHTlkdJyrVy39+tiD5yYwq0aFBnCvp4ktVXK?=
 =?us-ascii?Q?DpzwT6S6TKrIKrWIX36ncmo6x574qCi5uUICkN1X/m5Di8Kr9jjx60fD+uk1?=
 =?us-ascii?Q?Xo69XGMmZUMxs87APlsJ2O+gZJ0Rg8Gk8+g8yaNENKZIxazQOCfaA8y5QVf5?=
 =?us-ascii?Q?N2IHxzD7qDJVbHyK4jKbNsgh1UGwnzJjVyxqkJGtvU9SNI6k1n9eFQ474Te3?=
 =?us-ascii?Q?tAgJeAyaDxQcLVU6rTiGXXW8GfrjKCkv5YtUWLZmWRQjgi3VA5sDsq69HC1p?=
 =?us-ascii?Q?yZIxtzJpma+X1JT38LLJngYi1yM70EdwcRToFrqemppjPIzs3du6byzNc2Dj?=
 =?us-ascii?Q?AtjGORUSQBe8wknKyC//9dhkKwxQK5Q0ReybDOLhUeow8JelZnwfzBtsB0/+?=
 =?us-ascii?Q?9E40RXvxBGaUdKY7eyHy9Nm9i749oneC4ueAW3S1ODHfAepaenVjdxyzzp8K?=
 =?us-ascii?Q?+ME15oim5SwggxyRWbHLmkI7tDBngtJ1kDw/8yQpZkJIZ4/rbwoyfoR0wrV+?=
 =?us-ascii?Q?8qjBMw6nC708idYfvulsT+04BzJrDvs9YNxfKmDb0+mrMZPC3rzJ0WkSZ8P8?=
 =?us-ascii?Q?uRt6Ew/lQR7ESzPbLhJClI8QcxCm+SYHC/E4//vrClpKyO1JEckEv7BJ3aNl?=
 =?us-ascii?Q?D7aS4BP7nXl/gq39E65IDp+DL974+M3O/spyAlyGDKfewsVHGWJMtL7RMzmH?=
 =?us-ascii?Q?IZ43z5/RJD0pBgHBWw9zYx5MkevRctddE2IVCwLNmcO2W7KM0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3k7S0UirIyEgWX6XU+vc0nZC/uWFthsmhqOf7Mvr4ArXOvmC8k7aqUzejEfz?=
 =?us-ascii?Q?4HwbjqKhWM55v/sksKgwWYu3q0ryGr7IopuHTLpsRDL4YUST3HQERgwd742q?=
 =?us-ascii?Q?5FDqlSVuSjPyJGmmcbo20iL7fsD1sZHvOX9EYfQrPYAeN4AfKuZLVpWgNAc6?=
 =?us-ascii?Q?WSF15PnRj+cfTwbzqL34zXACumGzdSC8dNTscM5WdrTEsRJPDNLdTYgNGKZj?=
 =?us-ascii?Q?sxrcwesEl3GOtpAobZM5KyKHEmSLhWJjuamgJLG8GlHi66GJ40J1TcnbFCpA?=
 =?us-ascii?Q?1y6Uib0C0QEyhTaikUucZ0s5yDD+FWGBx8eiAYUVwESmgTYtZY8l4nJzEEzP?=
 =?us-ascii?Q?n7wM2AraFQ3TulI3hSbdTAjquCVfhDw/detQd9psihE5WyojGEs7jeqMi0CV?=
 =?us-ascii?Q?cytHeIbtOFlocNqpvQgjmvdc/C9++MJRFNaKTv/QslrZPi4ky6zdQjP55/yO?=
 =?us-ascii?Q?WBZSrCb2BEu7zWjNDzJKpKTPOkQjZ8hajJZSiq3R/dtw0pI0krS80oZhH2i4?=
 =?us-ascii?Q?/UHD+cJER4UmXG9WRBiQ9GBLxvyWnLJcXoVleS/8w1ec/pk8lQTeNDCeFdaa?=
 =?us-ascii?Q?4AeeSTf6hxdt5fWseLyLoD8Hgn3DOBXVnzFFN+mppM4FNrp8qgETZoFWBE5G?=
 =?us-ascii?Q?uWequ+SmCSpMceVRipZPF0QaULn2AhdKkjBlSdaeu8dXcKozq72y9BkwPa8s?=
 =?us-ascii?Q?8a3d2VttdLCXuwAY+uXFq94ZLkgp5zWM9aNiL2Eso1PWnHmTNUbDRbDurD+P?=
 =?us-ascii?Q?98ms6c4+r8ECKWIOPNjGJr0kBsu2tVjwaCtfP88MwzGD6HTNEQN3zFI5nr/b?=
 =?us-ascii?Q?0kdJ6m97VTeUx0Jt7YDXWZzfgdVL/DEsiizXXO9JweS88CMKrP1fLgJcOzJm?=
 =?us-ascii?Q?iiYcQadWsXS63QQ0saIZlj3waJQEwiRuJ1FJKawUAKhB9j2lE3fAIyENO4N3?=
 =?us-ascii?Q?lgrbWAtryZLBt76egKngzqf4kQX5i7N9EUpm42g7ofwVwRZJl5qyFF2XiByJ?=
 =?us-ascii?Q?I1iyjox9lbnO4NXOyZ4dWaJlBZzcn2Xw7Xlk8x26UWnJFWjfPFgmBW98Gh4K?=
 =?us-ascii?Q?ljXS6vF1QU/99JfVvc40YzU+We0qCEyHsUpT5gZzGPOdpDM8TjxKgoW+3i9v?=
 =?us-ascii?Q?rManIEftYQUBeQcuMPGDFqzZJ3p9nMlMoVP95dUKPn0EEb9q/3KIxq9hjevm?=
 =?us-ascii?Q?/CatMocs0xjRyQecr1XLhOxzC6/XP4H2gidttGIL3+PdT/+mBORuW5sCpvet?=
 =?us-ascii?Q?4owuP3ZSIv88r4I79GJ82Ls5fmryRx6zOvYeYYLEIlZnQWHQ/n7h7QULe2HX?=
 =?us-ascii?Q?3DEL+TCOcVpKF6zsv06vHsOSd28RKNpkZ9Ejp2QEA30s6U4uLYTwNzhbLeRl?=
 =?us-ascii?Q?fzXK0sCAlR+TIvVOgFO7BKQ4RuQtR9z1i4bitcWHUwlLKujB70cTaxWfhok8?=
 =?us-ascii?Q?NUZEtCBgD47ooNcgpsx/K2fmIcnnXyCDVJ5ZcbeWetXEaVLnwRqs+kSOsKBP?=
 =?us-ascii?Q?M1WFAWlY8Vqd8rN7ESM9Tdj5y1Ude4XNhpwduCZuV/9H5z4YpR/AuRUt+xMy?=
 =?us-ascii?Q?N+P721mk4Nk8Yp/oHujdo8EsEH1sfJuHraM7Q57yMRe3arRJKG4vjZ7bUIB5?=
 =?us-ascii?Q?HCjcPuviYnj1YJV2BGPhQXmE2dCAbo/Vk0SIC0xGWjkoEmZ7t5yEvFDqxq6T?=
 =?us-ascii?Q?97FZPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa90ed47-bf52-40f4-031a-08dccb55e3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 13:48:13.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6s8PhiAtseWNnM85qe8etWgTQDKRPauty3hNON4N98LKVXTT7wFy/sHzFT8geV4Tlww5o3OfXpKimP/B3ARbgX/nvNSHhBj4uqGDMHmAgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2969

> On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
> > >From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00
> 2001
>=20
> Some junk ^^^ above. Please investigate how you send patches.

Yeah also saw this line, but of course tried to apply the patch again after=
 sending it
as mail and that worked fine. But just checked again and seems like this li=
ne can be
dropped.
And yes, I sent the patches manually, as we likely have some restrictions f=
or smtp,
but as I was able to apply them again it's fine I guess.

> > From: Tobias Sperling <tobias.sperling@softing.com>
> > Date: Fri, 23 Aug 2024 12:08:33 +0200
> > Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
>=20
> And all this suggests malformed patch.

Why? If I drop this I'm not able to apply the patch, so I think this should=
 be fine.

> >
> > Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-chann=
el
> > analog-to-digital converters. These ADCs have a wide operating range an=
d
> > a wide feature set. Communication is based on an I2C interface.
> > The driver provides the functionality of manually reading single channe=
ls
> > or sequentially reading all channels automatically.
> >
> > Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> > ---
> >  .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
> >  Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
> >  Documentation/hwmon/index.rst                 |   1 +
>=20
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run  and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

Had done this already before submitting the patches (at least without --str=
ict),
but only reports a warning about splitting the patch (which I got wrong her=
e)
and updating the maintainers.
I guess you were about suggesting a second script to run. Which one is that=
?

> > +$id:
> https://deu01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tree.
> org%2Fschemas%2Fhwmon%2Fti%2Cads71x8.yaml%23&data=3D05%7C02%7C%7C
> ff09fedbe2744394f78508dcc9881ee7%7Cfe3606fad3974238999768dcd7851f64
> %7C1%7C0%7C638606833686313557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&sdata=3DvZaCpdaNzELpNNnd6wp5P9MNLQTnAmWXYD%2BNKQYCJ78%
> 3D&reserved=3D0
> > +$schema:
> https://deu01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tree.
> org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7C%7Cff09fedbe2744394f78508dcc
> 9881ee7%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C63860683368
> 6326954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DEJflznuTZYGR
> BRjULwohiHk8gPF9iRusSbmF8CKkl5Q%3D&reserved=3D0
> > +
> > +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (=
ADC)
> > +
> > +maintainers:
> > +  - None
>=20
> Fidn a person... otherwise why would we care?

I know it's not nice, but we are likely not implementing further features, =
but OK, will
add myself then.

> > +    default: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      Only considered in mode 1!
>=20
> What is "considered"? Driver considers? This does not matter. Describe
> the hardware and if this is hardware related, you should have
> allOf:if:then restricting this.

It's possible to define a mode, either manual sampling or autosampling. In =
the
latter mode, also the hardware capabilities change, e.g. the driver is able=
 to
trigger an interrupt so defining the interrupt only makes sense in that mod=
e.
Will have a look to allOf:if:then then.

> > +            compatible =3D "ti,ads7138";
> > +            reg =3D <0x10>;
> > +            avdd-supply =3D <&reg_stb_3v3>;
> > +            ti,mode =3D /bits/ 8 <1>;
> > +            ti,interval =3D /bits/ 16 <1000>;
> > +            interrupt-parent =3D <&gpio2>;
> > +            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> > +            status =3D "okay";
>=20
> Drop

I guess, I shall only drop the "status" not the whole section?

> Best regards,
> Krzysztof

Regards,
Tobias

