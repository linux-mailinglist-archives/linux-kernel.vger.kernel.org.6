Return-Path: <linux-kernel+bounces-448924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529B9F473E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F6018921BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E11E1C11;
	Tue, 17 Dec 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i6dEwnke"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017631DE883
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427010; cv=fail; b=d0GZCVrpu1GseanjuhwlNS/4YHJe14JsAFpu547zHFjMJCWZ86HLhRuq2Zflr9AKb7vKHaobo4hDbQx/NbD+tOtOAjuvpb6SMliR1rU9miSYg9qmHEZ6fFNcJn/8bw4D2hYueon1LCdpjfntIQjgT8Y7dRieAheQ1iQ20okx18A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427010; c=relaxed/simple;
	bh=kIg3q/t3zle7PZDLmJqJkV7FjdSISInY9yIzthkH9WE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BEopUbOxWo7GCAvVpeLHULBUGbYrp3CydS6J48HEuekAm3cIs2KXQwfoP5KzjsiFifWaNP65LZjcjcwczRlOi59XSq5xvykmFjJoBAJcbeUtSTPK/y0rucyfwgAjXjoImlbbbXeiNchCMrDoD1SWwo+31I7ErEfRYf/Kk8FvCeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i6dEwnke; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRW4Lcs2jco58rHvGhlixmkDCVbyDCBe5dk8waT/+WtX16kcedooQ/ln5sfr0w+EYrv/8gLo0knnz0R2FcHgWhpNuyYwVtegNXYIq5eUZkroE4k+qXKY35cmBn4xSPl+/5itbF+btJ/d5g0zzFqtw/4ZsMQjGj7oDC5UPgXbAGSdfdp4DNDqtpcMTTsWxAUK4scQSElA3qbIIZarL2fCoYQHUIfR5vvmr02UYo73F4IUelTI8sObakyeCAnLyvQIMSWH6H6pv2FEzrIN6n2ODFELxbzsC/A5W8ICl7ek+qyICtmMXphOCBgVRoTNJnlfF/EAibWkrskiqxFk9LrFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qso5OBKQavP4HslI+kydGwkp1eVdXM3Gx5FAw3eZ5mY=;
 b=Dxx21lhORDEa32+LYpK17I3axIjNWE7WGDtl7QCH5xmJGrYTgxCAZhQVnoyCZSO4z1638UfzjAiTu6J4LInMzJVk2r7NC977mv5Jl3UvHzusKnMNQ4xZ+AKE35BpD5WxQlSXkfYGtnfERypbjI5LR31eWfcQMcrlyaxOT8LKq2rfRHBg4Xx/o0l7L6yt7CNbM9LBww1Pfp0QI26frrDWroiYg3J7+9b0pbuHLSWQ5Zx/z8mf6qO44UglMJiAPd6ksPguqmWFy9CmR44dZI5J+xC1VKK4RKZTwua/M5EE+oPLJD4I5Qc4BhiPYOURdW1bBI8zAKkgzRd4j3f5dv5ENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qso5OBKQavP4HslI+kydGwkp1eVdXM3Gx5FAw3eZ5mY=;
 b=i6dEwnkeo1VhaamqjjtZOla9+X5Qe+qm14ttEPJD4uCQ/vf9PuiNZBSE0Cx9OVYY98BmBK4TWVDU2+k3JRa5m8uFqbKLWBYsBHcVixQly3PRhPqHhaxl0cuhZNUJ4plfVrzhF5SpUP9O0tJz6x7zRVTTz8sdvL/sTwUSQK0K10csSeKsV/Lpx9vY8fCCK56pLrBytat/xg8MiB8gjy/L175vo7LQqwHLdA9D6ywr40dxsvhkHqDlQUGiYHylh9T36JM0iAlJbpVDbSFW2lNX3+vgrerueOtDNIePBeyBx9dbMuzAWwfo0IcTmP0b8XQPCWSXLug9DfmoDOQ7C73r0w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 09:16:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 09:16:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "marex@denx.de" <marex@denx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] soc: imx8m: Add remove function
Thread-Topic: [PATCH V2] soc: imx8m: Add remove function
Thread-Index: AQHbUCc8cDc1WI1Wg0iGevKj2ikCS7LqGniAgAANlmA=
Date: Tue, 17 Dec 2024 09:16:43 +0000
Message-ID:
 <PAXPR04MB8459A91EEC932F41E24AE04488042@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241217015826.1374497-1-peng.fan@oss.nxp.com>
 <20241217082637.i2ou6bbr3tc3uvof@pengutronix.de>
In-Reply-To: <20241217082637.i2ou6bbr3tc3uvof@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7331:EE_
x-ms-office365-filtering-correlation-id: 99452640-3714-4f20-318b-08dd1e7b8644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NJNH6HO5jGRuVRnJ/BCP/WQGzoXTehgn5TJMrYkIPlE4XZl520Ai8NugbMyL?=
 =?us-ascii?Q?1UxG/4o0Xfna0NG7+AcvXU0Rkl4uUPn4OLkNE2+FngEiFsCRIYUIat2I73Aj?=
 =?us-ascii?Q?AXDjDUNvMWMV98Vf1mnpj7Rb1WCrO0on2xKSgI5k6D1Wm5vFIPomzj0WaCHW?=
 =?us-ascii?Q?g9wVVBI8468Wz8zA1JQ52uMqDgV2JdnXJd0eNABG4vrRpgJsoPAkQPEa1cb3?=
 =?us-ascii?Q?DMtZOIAy7eG3UYGeoSPS3Ad/mx21InpTbIpzdNNd9NGm2pkzzpWEvxla89Vu?=
 =?us-ascii?Q?P/0YW/uaBwm5An7p3kM5ivNkQMpz3jZHzZUgS0M3dGboZPqOqGT0K91QURDW?=
 =?us-ascii?Q?2RW7CQkS9mWCVLS84ayLJx87X3GXboTN9YJ8IhYq5yBulcJPcYBuQon6HKUT?=
 =?us-ascii?Q?fevRtWm8x08JtxswQorwsm42uTNyJbQrdAbmhRKKHfT7k4d3H4cEdLB72xeU?=
 =?us-ascii?Q?rLY708517NhtrgMFSOZwuL41MXBD88AoDwHmEEdmaXO1gsOvtEbO+AQbeGnK?=
 =?us-ascii?Q?gPoCsE/403F8DcgN3ppSGnSzSJ9+eZ4joXoBiAlLrcNAkBu5oPq3Rz3vNNqH?=
 =?us-ascii?Q?i2uAgjFNCePWdayQxAqXaNgcYdr4V8BXCXgM70yMd3BKuOfxCD8X2UFOrsWE?=
 =?us-ascii?Q?HP/G8VFywYfnkUd46XrFnv6Q+gPD2OX7WMPbMVynBzterwFah1rpqqoBdGUk?=
 =?us-ascii?Q?gapx5krFxe2TzQOty/9HkKhW94nkIcMczjU7i+ErShgzpfsPX2u8Pn0GleWK?=
 =?us-ascii?Q?QG4Y4WWZF4IpSN7t394hELUqv+SPglzylzSsfT/zaQXSyJQIxnH9hJP62/X9?=
 =?us-ascii?Q?OrJgp1A0S7Et2f1OKrlIrjMFbks3fut07vYkKAJBR1LCOYKj4QhYowz6n/SX?=
 =?us-ascii?Q?9vZ8F1rncx0EjcMDr8pHok5+xrsonX1ajn41cIzjwooDnYGkByMvcGmna4iY?=
 =?us-ascii?Q?uJwiaFARf2FRl25xxYdBgN1aZaP53EWajVEA9lPvlRz+sn6i+/KkLZohPscM?=
 =?us-ascii?Q?6Sb1rQqy4Y/8YaooBrwqH8zmodDM//Pc0ugqFUQrLEsjvNivjW6+b1vkqOjf?=
 =?us-ascii?Q?E4now8FEuHn2Q/B4BoTX7gnoaZk//2ZLf+X1sTZLMnOhae4UlF2wX8ERTBE3?=
 =?us-ascii?Q?8IdfEqEPQBSlNTF04q8HuNzUW6RWit1cSnNn8fQhjx6c7lzZaMlIaMUKKCrF?=
 =?us-ascii?Q?I9h3Vb4D110LFrh+Rp1yLnYqApVr9zL2lwQUBftOZWfUEcNwqmMswzu3RL/o?=
 =?us-ascii?Q?mmDBpu4F3dLOOBq44nDJiwbwCFaTpc9kTpD4hhR8qQSiSjkGt7KqHeinGMeP?=
 =?us-ascii?Q?og+TfkUdBIfmtaTkG2kdUOX91rGpEqwi55qd7t6/5CQ2reluDWuBdZwAicjP?=
 =?us-ascii?Q?Dt3meIPUQf+jRkwbmbjamVMaPWLv75SyjgAoKB/VQZhKPNSM6Zp1QJHaUQGD?=
 =?us-ascii?Q?d9Q4w03fOVP6v0SXZELFNLH9vSEuaQ8z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?igqUI6ztyZSJGlI/H50CrXdTVq4uyrYpVM1PZnaEii15wKEyTr4jASY198/L?=
 =?us-ascii?Q?WvSWwnTCo2a1C/8iiGNrSaWYKOwGS90Lc65Z5c/ojfk9toIjvKcrsgg8YWNa?=
 =?us-ascii?Q?gn7RpFHn1W8jSRZwQdBr/mwsW4mUKSR+x0qYVCEps5W/XVXAREAB97lXL18P?=
 =?us-ascii?Q?rf2b1bd8KQrB98iRhjTu865EyUyW77xukbMZQxAIG+VdoEEYkY6N6SgI6jDM?=
 =?us-ascii?Q?sFdX5OEsrfXiPTlx7cz+QbiIhTf+yQhh+JuUOhVhwjO22zSpTcQFQaoxN7Qy?=
 =?us-ascii?Q?fCuGDcWBNlygJiQsBuspBLz6UDg43YZZe0BepogGyDY6Rt/89HfGb0LSEfDd?=
 =?us-ascii?Q?T/pEsuf9pLMB2ASOzMlxlbG3ZzNpPiFtP/1VrFL1CLpjLL0SK6mbFp3yMwL1?=
 =?us-ascii?Q?59MOOXOSxL0EsGS8FYRSfgZ42MXBypBonI9K8GYhfqjRhG3PFZYPx7Uh03DE?=
 =?us-ascii?Q?LjNQP0Tk3orgNhZRaagO5MSEi3tbzNIV6GodfPL+OmyLv0Si8zXeyPpEtcUd?=
 =?us-ascii?Q?YmLhhMd7jB5noJnky3eG1/N5hztd0Bwpvs6UkkpgOmROCytdMY65yN1HEmMZ?=
 =?us-ascii?Q?YMP2ae93SElpQrAmcHikFZTTvDXMpYxdfxTycOjoWgcRVx6O099EAdYm3HV9?=
 =?us-ascii?Q?7OL1dFkKAuhNDVRp4EgsAp5GTFs7Tqkp6c0Lda6UOcLvEKZAjsjxm+RuTYPe?=
 =?us-ascii?Q?q/2zJErgIcp93c3b2n8zba2FO+Q4D8ucwAfrBDnP7onjfODa3+iYiiFTD7iI?=
 =?us-ascii?Q?vcocKPvfMcE372iukpQkupma3wKw1fE4zvWbxKsXNKWn4Z1mXsdNHbW3HCz/?=
 =?us-ascii?Q?10186ttQ/ubX1fEKB6qOM+XMzY2PwAqJxd2PK4oUG94zaibwy/27E5UHWnuV?=
 =?us-ascii?Q?37654LRIrGviEGZfV9cgDCNIjY5a0UfBUw+ze54h7SSf9qfo7x1z0E5Yipsc?=
 =?us-ascii?Q?G+Z+bgP2I9Y0vgvdqWoC5M7N1Ab8bG3oZCm8I5z/VZDEi0YhTT4CJZ0FHdx8?=
 =?us-ascii?Q?6g8E+cU+qehR6EWkPYTumou+V0q3oBRjlznduMx0/3N+qHaBzYeADwiYt9w0?=
 =?us-ascii?Q?rMc5KVqVHrjJ105eaNY9v6Sx1P0hxUNtdny/seBWU40iO1KnalQ23NzyKpAR?=
 =?us-ascii?Q?IAXsykLvurLjmKprsLqt7uLccRVAfQhnYasRM5kWDpcmfvssllSwV+yKVeDB?=
 =?us-ascii?Q?vflTV956hW+dOEsafp8sBJtRpTtKqhqyGu6SMyu9kBhRjZt9AyZop4KlTLWu?=
 =?us-ascii?Q?ZlMMCYuE3/yX01O5XXaA5jAbBmcBRuRGOUC7+6BqcJ3BXeH7uboZ7MI9Hsf6?=
 =?us-ascii?Q?KYqHjl5NbCwVdbEPhA0VoUa5TM19Gtu38woB1U+yxJ++SHfN2l263KQeCKtt?=
 =?us-ascii?Q?0FEApGtU0DFossr1yp35EC9OLZ4eofOBhYZBcmOlggBvMpwlxEtp+VFt+rtt?=
 =?us-ascii?Q?REK6wSM9i4tnW5hMdaw+35xahAlebN3j973gSYXqC1wv6FCnomLrFQtPnmTS?=
 =?us-ascii?Q?mBs7XGXnvC8nSHP7lFXz+rHSkTO7Gegqxia7FBoWrM2IcD5JnW63Rv6rOZWj?=
 =?us-ascii?Q?XOJqXVoZlFncDL0zgVc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99452640-3714-4f20-318b-08dd1e7b8644
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 09:16:43.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoIwTqaKY9bf7TvQKu3PtxbPyEGlSvLScB5PzjPSOWZv88Gjk2bgdVgGQsQiOHSFSrorp460y4DAJMboy7DTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331

> Subject: Re: [PATCH V2] soc: imx8m: Add remove function
>=20
> Hi Peng,
>=20
> thanks for you patch.
>=20
> On 24-12-17, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Unregister the cpufreq device and soc device in remove path,
> otherwise
>=20
> After reconsidiering the patch approach, I think we shouldn't add a
> .remove() function and instead should make use of the
> devm_add_action() mechanism for the proper unregister calls.

Would you please share why devm_add_action is preferred?

Something as below?
+static void imx8m_soc_remove(void *data)
+{
+       struct imx8m_soc_priv *priv =3D data;
+
+       if (priv->cpufreq_dev)
+               platform_device_unregister(priv->cpufreq_dev);
+
+       soc_device_unregister(priv->soc_dev);
+}
+
In Probe:
+       return devm_add_action(&pdev->dev, imx8m_soc_remove, priv);

Regards,
Peng.

>=20
> > there will be warning when do removing test:
> > sysfs: cannot create duplicate filename '/devices/platform/imx-
> cpufreq-dt'
> > CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.13.0-rc1-next-20241204 Hardware name: NXP i.MX8MPlus EVK
> board (DT)
> >
> > Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform
> > driver")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Add err check when create the cpufreq platform device
>=20
> thank you for addressing this.
>=20
> Regards,
>   Marco
>=20
> >  drivers/soc/imx/soc-imx8m.c | 41
> > +++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-
> imx8m.c
> > index 8ac7658e3d52..97c8718c2aa1 100644
> > --- a/drivers/soc/imx/soc-imx8m.c
> > +++ b/drivers/soc/imx/soc-imx8m.c
> > @@ -33,6 +33,11 @@ struct imx8_soc_data {
> >  	int (*soc_revision)(u32 *socrev, u64 *socuid);  };
> >
> > +struct imx8m_soc_priv {
> > +	struct soc_device *soc_dev;
> > +	struct platform_device *cpufreq_dev; };
> > +
> >  #ifdef CONFIG_HAVE_ARM_SMCCC
> >  static u32 imx8mq_soc_revision_from_atf(void)
> >  {
> > @@ -195,10 +200,11 @@ static __maybe_unused const struct
> of_device_id
> > imx8_soc_match[] =3D {  static int imx8m_soc_probe(struct
> > platform_device *pdev)  {
> >  	struct soc_device_attribute *soc_dev_attr;
> > +	struct platform_device *cpufreq_dev;
> >  	const struct imx8_soc_data *data;
> >  	struct device *dev =3D &pdev->dev;
> >  	const struct of_device_id *id;
> > -	struct soc_device *soc_dev;
> > +	struct imx8m_soc_priv *priv;
> >  	u32 soc_rev =3D 0;
> >  	u64 soc_uid =3D 0;
> >  	int ret;
> > @@ -207,6 +213,10 @@ static int imx8m_soc_probe(struct
> platform_device *pdev)
> >  	if (!soc_dev_attr)
> >  		return -ENOMEM;
> >
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> >  	soc_dev_attr->family =3D "Freescale i.MX";
> >
> >  	ret =3D of_property_read_string(of_root, "model",
> > &soc_dev_attr->machine); @@ -235,21 +245,40 @@ static int
> imx8m_soc_probe(struct platform_device *pdev)
> >  	if (!soc_dev_attr->serial_number)
> >  		return -ENOMEM;
> >
> > -	soc_dev =3D soc_device_register(soc_dev_attr);
> > -	if (IS_ERR(soc_dev))
> > -		return PTR_ERR(soc_dev);
> > +	priv->soc_dev =3D soc_device_register(soc_dev_attr);
> > +	if (IS_ERR(priv->soc_dev))
> > +		return PTR_ERR(priv->soc_dev);
> >
> >  	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
> >  		soc_dev_attr->revision);
> >
> > -	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> > -		platform_device_register_simple("imx-cpufreq-dt", -1,
> NULL, 0);
> > +	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
> > +		cpufreq_dev =3D platform_device_register_simple("imx-
> cpufreq-dt", -1, NULL, 0);
> > +		if (!IS_ERR(cpufreq_dev))
> > +			priv->cpufreq_dev =3D cpufreq_dev;
> > +		else
> > +			dev_err(dev, "Failed to create imx-cpufreq-
> dev device: %ld",
> > +				PTR_ERR(cpufreq_dev));
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> >
> >  	return 0;
> >  }
> >
> > +static void imx8m_soc_remove(struct platform_device *pdev) {
> > +	struct imx8m_soc_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	if (priv->cpufreq_dev)
> > +		platform_device_unregister(priv->cpufreq_dev);
> > +
> > +	soc_device_unregister(priv->soc_dev);
> > +}
> > +
> >  static struct platform_driver imx8m_soc_driver =3D {
> >  	.probe =3D imx8m_soc_probe,
> > +	.remove	=3D imx8m_soc_remove,
> >  	.driver =3D {
> >  		.name =3D "imx8m-soc",
> >  	},
> > --
> > 2.37.1
> >
> >
> >

