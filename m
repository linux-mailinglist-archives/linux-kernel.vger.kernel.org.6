Return-Path: <linux-kernel+bounces-270570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F6944189
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84675281726
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590E13D283;
	Thu,  1 Aug 2024 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BKlyYfDr"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013023.outbound.protection.outlook.com [52.101.67.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050B132111;
	Thu,  1 Aug 2024 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481676; cv=fail; b=WpIHhc8qlwcAu2Po3j/GCbiq7fWq627Xqr/UVShNHI15aWz+53E0BNKV0OMwiS9HNHrjEThQDMofj4YoOviuDxMmCNYFyn2k62hijr4Ft9/9yOQrhw3u0qWPy9m9/FM2L57QDOiIrHdyZqFmPNQFwefZHrmMa4V3Akq8TmT1mOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481676; c=relaxed/simple;
	bh=Z2eoOgDmzoFs1S2h3tfiCqX3vYr+ODIrIy5u5E56ooE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDZnEKuDBsj9HblOwlfTeyaBKq9I0DmjbATnNUMC1I3jZbN0Ez6evDgLQrKd3AN5RifdoZxXTKglALAKBaElarhQusljZFYBhbQCxuDnsY9EuVAjV+3BG32R789qlHb8JZ9UhChyhTFzB5lILi8eaAWBo0uBKjNxPbpsn4PkezE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BKlyYfDr; arc=fail smtp.client-ip=52.101.67.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmkKWo95onLK5jTGe4CO3LXTB/A1MQenLKpl7J9dR+S6IJVRq8Wn9Y4ELiL+Qlp/my6s/8VCYgXoWWMbNfyCX51M/t3/gH+w7IuDDGBFRI5sh0pPcVv98jfzrzaLOVwu0ooa2/m5tvt36SVd51EyoHLdN9d4B4yG2uxGRUrm2qWuMJdgv+aUAyLeLSky7XpdeBAXznRMabmezchjgRNAiso2BA9RmVAQiL9+uj0rvAOA5KMkoQRmA3aMcQji/LqN4KQrzrTUZ8lLT4vmH50pL/ppEif3SbKfWLmhykaFFbRBVbQehOFRdpUw2uaztGYnQ4plnHbpGGEEaRv0nRm5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2eoOgDmzoFs1S2h3tfiCqX3vYr+ODIrIy5u5E56ooE=;
 b=Qhy3hgAb5AtJRLTCkQGgjRwrZqofogkAG2i3JUvfDH6nruFao8F0+j8DWZCYkiCXu+ivpmqNtE+fLXt123JtBi79SbJuLq4ynXKyatvWT4VhGgMyyKInATahVvrIQ8mtjOppqMftgODDI1g1gJz87Rd8tSCcxMup5KFQpFKfA9TyDIK3VxWpl3941m4dKSwPTTMTqSIbQo3b+3hArgJMxA86a3BAaAgv9ew5pCZnBuP62eNtagltzUA+T7Dn6wOXmW8I+HUtrW9QX86i2qiXvoW1hJ06dbgHDatwq9XRj5+s0dLyJcZO+0kvoamWHwOHXZsMDQMFUfG4xkeeRRQs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2eoOgDmzoFs1S2h3tfiCqX3vYr+ODIrIy5u5E56ooE=;
 b=BKlyYfDrttt7pNGwmcxheV14aNzEe7nKjcjk6+sLT9ZVIQhkcC2wHyrCjZdX7jWwGup62gDrDyUkSR1NyJvIoMH0GNl7r33rvM109346M+8earUQ2KLLNJ9rGbT1FQxu2NZgSUZGgCuEjmAC6jpp3wxwuBzlykNSi0yz40JAZb15lG/nFgvJvjNrb6JBr521eg43Z5le3NIEtFF6sey9YBxpp2W+YaR3bMrbG278SVl/WXgX5WGSZFncyRCzXuHxlXVjpvem+bbySWXSU0VKXDGv0eXwp49l/fiPduMJpXAND8jilKivnK2eHRDoeW6+zZLUT5SHlX3qI80OeBJbDw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:07:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:07:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 add GPIO line names
Thread-Topic: [PATCH 09/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 add GPIO line names
Thread-Index: AQHa3cmfveRFfixhbUykfhYg71wYmbIRxFEg
Date: Thu, 1 Aug 2024 03:07:51 +0000
Message-ID:
 <PAXPR04MB84598BB30909D21F4D30668A88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-10-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-10-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 030a070b-b9f8-40f4-38c5-08dcb1d72150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UINXs5+3th9zOvADyWIUU9rSrKtDRg2Uhl84Fz/U/HiEIP8s3WVqVeNhcw5i?=
 =?us-ascii?Q?SgB9B05rqfemXGMVLbJIsMf1oLESE+9u/wDgCDjH8h/0B3XDJ1DzRf5eSvZ0?=
 =?us-ascii?Q?IB66ZVwRQP8KRlteUSD/vhmLI0bmhvtvir94/B+esh0Y90qybWlQOFdtPUpz?=
 =?us-ascii?Q?axWZwlAOEJs1MKx9phtkOySk7cRDq5NMaG26NXdc0i6gqiaPOA0ib1ya2JCu?=
 =?us-ascii?Q?KZF/jzAX4VOsz6iLmmLz8oT/WEbyxuw9hy/LlRVCcyJnmSUUEQBseqVCLy4X?=
 =?us-ascii?Q?W7/bhJ55LODfolfPLBIJ91QRVhhXdQweLQhl3IK6D4hYkyNd173/y3Np/dA1?=
 =?us-ascii?Q?H1fVGARRMpsS82i5n4QURzriW0AmblxxrqtO8a/qrS/hDG/asvMG/URNQN6u?=
 =?us-ascii?Q?5OAjReyeY0x2QtNGatw7iUI6YNuk8qyl5uNlPIbSYiEoUJZcglOdH6k1JMr3?=
 =?us-ascii?Q?a/vnvo23aze4iRlMGIWo9MEZlilmL2HjfzfrP21xHDptffHn3Og0VRg7Zei0?=
 =?us-ascii?Q?iIyH+mCTsO1XnglVhyDKnzxxUp0o0oDVsqE9RwNbm8G8FFpHD6ptpj/XN5OS?=
 =?us-ascii?Q?JmNDHrmNbQIXReXGJaa7uF3yvStQ+haGlM9qQJ6/IQZxnIrJZjzq6xNonoER?=
 =?us-ascii?Q?jLw4YChiuqcKq3ZnsdlTagbcLt5mOBjqGSqumc6gHZPaqnCP5WcILrIVOnqI?=
 =?us-ascii?Q?Q+AO83CkdY2/770mwJKnqqCrwMmtZ90M+BYgkKBhbqF44VyteJUEQ6VsBUPI?=
 =?us-ascii?Q?5dLNdlzBS7lQkN2G0tpOcYb4ethk5OLLeNhx6IQq4aHzSHsDT9dFHrecmV27?=
 =?us-ascii?Q?+UVP8xoBUDgHt/jsWPrjeSWF6KenZergknJUL+lYcbOCcDGuo5QroSsG+Bv+?=
 =?us-ascii?Q?TpkCQCXmmgUDhvqpUspwwYwHpFptSthQu87kTyCpAa525cBCQk4YkWNshpfV?=
 =?us-ascii?Q?O3DT3vFGXZV4EkHxwZ45f3rksWZoQQokGYTn762wvOOGNwv0iJNS90jGrkyc?=
 =?us-ascii?Q?2ukKwn26o2sg0C3OaS3pPL6kLBY84zFGGN+nEwOaFobNp1flmFf1rrSKQfYz?=
 =?us-ascii?Q?cH1slEwrnah60ZEVgFoM/MUFzLs6OZjUpW8LEmPAjFWA7mxOI9K7rqgbUKQn?=
 =?us-ascii?Q?XIHJogf8B46A6J3jrhAug0nNrJIrZO3KQ1OQQ1pcr+Ic6aASkoieR5y44V7+?=
 =?us-ascii?Q?58dszuBy5DodB8fhKpGqRYcwlLdfknbtC1STUfACWNdeY0bacKXbzN4/TsI0?=
 =?us-ascii?Q?KBhgfhfwzJIxczzG3hg5ryMqj/5bMsDvLxJz5qAAUyfnu7LP8BiA2bIdkbiW?=
 =?us-ascii?Q?sEkp1xerj1geBnY/V57FQhyo/QWkfaUSXKSS7g+ec08TK+iimzrrx6oCkpXG?=
 =?us-ascii?Q?mKv6NLZwjrmn4p5tjSbxhreRQueaNMzNotKZmv8M110GLUJBcQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TUIu4MagcDIprqlTed8YV1MY4mK3BeZ5OciL3Dy0+mgSZ2UXpBmjvLuuXN6/?=
 =?us-ascii?Q?9XXSHkQthQMV9cD1TcZ7ypBE6+H++wHpYl8QBZTqWV0scpVEubOZUrBIKZ6T?=
 =?us-ascii?Q?G+uhFPzZEz5PwTxlg6dAqS+ccFFjbVMQcqKiIWRZWOLM2u8woPWvM9n8FLCJ?=
 =?us-ascii?Q?KALk7iY1l5Sca0L97hDFSmxOp7n16EcoHGeF7H/RcZQfpk50tWU1X14O3YGl?=
 =?us-ascii?Q?djIP6y578J7tULObRAwBTmlWVvnUI9m2Rknh75gzwV6zpkZywSVhiKxTpOZv?=
 =?us-ascii?Q?woVnOlM2FWP5DGf4GVILhBJvegwUUi1ZEYNiKQuUCdMNFNBgeGsH+UcujLlc?=
 =?us-ascii?Q?z10gi6lZ07Ru6bzorxDarpHVYvWe0xvnBhlU1cYrArKeGqVZjuTr2E/u5qbF?=
 =?us-ascii?Q?XJ3IzcphIiLlCEv9r7T1R4H7GhpmSCkQ6n403RCCvro9fEejUdDK0ZuEgfBY?=
 =?us-ascii?Q?X8YmO4Av0Cl04fjmg4rjYZcGDKJ+FvSgdPR1cA23ncIQSqvWTMY2Ifnu9wAq?=
 =?us-ascii?Q?m0YXPRtIEIGhv/oGnrm8Yyjc1qt5JIBCWpBHSe9R2SKJqUA/GNWyP8r/jmN4?=
 =?us-ascii?Q?LqfXaeRSzhYwr9zibcn8fCX0CfEAhE2mFJDhgYhr1wDw4Oba0gEGYuvhiIN7?=
 =?us-ascii?Q?psTrhr0GBBTJRe3ZE8cprASnmjh+rwKvrgpsZLW6zH1mT3gM6thfBZYjR9Af?=
 =?us-ascii?Q?TIFLebYZBWvDu1wfwluhpAKXPSz3yGdFkgH5kzV6J8droF7jIkAHj/0/N+3I?=
 =?us-ascii?Q?eAWA4aJPKczWCjNmx2I3PTkpydDlJ/Upkri0TtYq0MWLTpjaRB9qjNEMnSMl?=
 =?us-ascii?Q?2Kr8w89Wh1JJvDnMdwOeXL2aafU13XVLV5cx03YSMU9LfaZ3tAHVA4O3H4At?=
 =?us-ascii?Q?hCa0Vg+xDlLZRO2UbLQsqcGr+iH7yIyHmzOlyyL9Rvw79MDvH64KtVoPUbrk?=
 =?us-ascii?Q?0CWj7w8RhgB6TAkWmWKgp+BFA4di+nOk4LkBygzYKKVSHHb8thhoDvZJpI+j?=
 =?us-ascii?Q?O/EehNgIino1qiTA3e9zbZTGrbq7T66EPKVoRenLOzW7YxiL3kq8ZrPqFIyd?=
 =?us-ascii?Q?HcN/0qYxTxfeo/eWeuMVjSdPbJ2tKaDxjW0JXwr4CO3OtgZCx/ebRVtWOW2f?=
 =?us-ascii?Q?kN1X+Jl83dsHz8owp8xP/7DmWC+U+mzxwRP3hog8vv0GI7pQs9qFCGAyTkyL?=
 =?us-ascii?Q?TaYGgi0kn9Y6wTxAADzclmI0ZmtbqTVpYrBbYPQHLRPGVYZMQ4dFBfeKzoUP?=
 =?us-ascii?Q?Mmv4Qmj/fh4M/UiXsRlu0tZJKvzhN6qHiqaeXRQenKVj/qtZhJYQcgKaYvre?=
 =?us-ascii?Q?DpvNwItGUhvsbmEmN33/bksSxNI7XvA9tOrqMfXFV++oBFhb5GU9Oipy29Qg?=
 =?us-ascii?Q?amCMaLe+E943aRrvQfJCqjE/ZWhqiTQMM7bnGDCtAcRG+MwZynEFneOs1MD1?=
 =?us-ascii?Q?RZE1Mf4LHA4k0UN+6LiqcoR58lfQnwnuuD9egdq1JxNSksxBTjD2NdY+iI90?=
 =?us-ascii?Q?KcnrS31THMz4bfMgKPPBs7ZnniTx0FhVQ9XbJxsOC+Xo6f94436cRxEmACM4?=
 =?us-ascii?Q?3tFn/CiWUzkTMbhWoEE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 030a070b-b9f8-40f4-38c5-08dcb1d72150
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:07:51.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQWfzdopdb3ldP/TKNy64cUmvLX4zbl6nJynPJxtiJdLKfAhuz79t/+oL8UPBQHh8U5h3TrzcWzvvJFMb0lwJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 09/14] arm64: dts: freescale: imx93-tqma9352-
> mba93xxla: add GPIO line names
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> Provide GPIO line names for userspace usage, e.g. libgpiod.
>=20
> While at it, correct the line-name property for ENET[1,2]_INT# gpio hog
> and LCD_BLT_EN.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

