Return-Path: <linux-kernel+bounces-510707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F6A320DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011201888F53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C8204F8A;
	Wed, 12 Feb 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XEz4919Z"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41427183A;
	Wed, 12 Feb 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348577; cv=fail; b=Qu5ULV3qCRJkQ/SXgnQPN+S0nI2HVCR8/NxMDu0KUOkQA8NXnS9pMgZL67zE3h93RUXIZLkWjz3BiC2N3dRThL1DPW9l2TFptKS42qtmjXJAuosmwCnf3Aaf/81ur2JjjRaEOfeIRPtar2sZC3YJ24YWFFEa0gtxlGJu6thg7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348577; c=relaxed/simple;
	bh=xhdUoz5vcmEWrfrKIyBkv8pXEi/tJbkBvkk6El1lnNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irFg3+ffuK1pLmARtqp9t0py5+LD261uiqKdxS/Bh1xy8vFaJ51LtqMormf7g0ClF6w2D7cPlHmaX6OIdWlulRPD9A5lmFbbbR6MBfJ0PP0G4Ki3BHJtlyiHy2/j+3V7uQLvdzkOWV4ttOtc2k1ws1FVP2JwFTd51x6GpZwfU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XEz4919Z; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq+8wN089RPXSDOV9LdCBTU0eRP//9WLtyf7A/Cq6sfAhD02gEP+djOiHrimv+phMlctprH/AJJWVbxsJ3jk3T8T3e1CAmru012ZfbpSAMij7xtSjyQbxXwtNPEGzuobZ8mHqo2BGR5ZJU1jumJjZ3SKQKRaWaZfgrJzLTqlDcOC3CYX4LZc2ao3m501vz/+3iudKZ3QtD+vA4eqTY62MECMQufW0s4p2BgTSwN9bUEYmSHzom4ZrVjYdpS3iwo9vEawUnjnGDDZEly6QCtaziG7K2MipXfz7e6x8B7IW6lICeCW7cLxRPBpTkT5bj5fba5eUWyNyamk3HCXn2kxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPjwWOxAyuUQSuORlEih2RyIY2haBPXP9JU09eHyH9s=;
 b=jMHC6RHKSYFoZnG3CVGk0c0pqmg+XgNyYCT8zxYHUaDNJCANvm5pIC72MBbcbyIooXbdQIfR2d+l/E0dxlF8HOncRQJsufrtfrxXfSyJN/GNnU1aqkvi6fprPHxYtFh1J6AAnmHilsIEOxcvpAhrERA5qX0yze27b8AxIRT2ZjMZVdqpo76ucVAzPQkgBWgcQKlhX4HXYgPqdw60+uz3S8/fNcMzUYYXAKGy6K29AKaFmkETnD1R/zTT0766PdFIfcBo3Pp7P6DvFV4EAqaiThqtzE7xwbwiGkZu5cv6BTdgf5lGDTaNFdzWpV9jZdE7Kv/Ew/lvg7sS1yNYMrMcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPjwWOxAyuUQSuORlEih2RyIY2haBPXP9JU09eHyH9s=;
 b=XEz4919ZqZCrrYnMPOnSNNVYgwgr9YfutBk8UzPrJOsX9O/p5QvJ3YIDbIfd2384God1I8VLu+fU0UZrN/B38TFyD4uGr6ozGCa9xfdudebchMA0SsJwgPnTT0SNsHQgLXshg6L/cWQjMliDO9zqnZ8UNeCNVUVHp22RnSUPN2BvBrNhqy5/d944INX8LYnrVBjmeVBPKnakL+rz4WxM8E8mFIJnDUIkWxfq8wTaCv2d0XZeo3dxY1Q2fdv1tdnOGXo6j9B0mlfuv1i4vfLbU/JMaKsALr/IM5so41UuHTjIOdhoHe/xbGRXy4zxURWvjdq3aYkjDCKnAJRpgVEwGw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 08:22:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 08:22:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-controller
 references
Thread-Topic: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-controller
 references
Thread-Index:
 AQHbeTucaaMq+IrsykGrfuo2Bh1yRLM7vceAgAAJ2ICABA68EIAA3cMAgADE54CAAd/IgIAAAeJw
Date: Wed, 12 Feb 2025 08:22:52 +0000
Message-ID:
 <PAXPR04MB84594BED300BCA5DEE9DA79E88FC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250207083616.1442887-1-alexander.stein@ew.tq-group.com>
 <2222299.irdbgypaU6@steina-w> <20250211033340.GA13109@localhost.localdomain>
 <10618164.nUPlyArG6x@steina-w>
In-Reply-To: <10618164.nUPlyArG6x@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: 73679fc7-fe9a-44f5-a573-08dd4b3e718a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NVhVFTmT5iKm8XYVKjuEuGGilqj8jcqkhm5K5oqzZY5X3u/oIKcqpJsl6S?=
 =?iso-8859-1?Q?bmd3gIsD5XF9TGasft/dE0IB/Zc743foIimBcM13xt1644VIrw9p/JUd8A?=
 =?iso-8859-1?Q?A9wT86Rk1XM4eaFYqpOdOJLZYjkXqBT4Ke8zaQWkhZf+giTe0Au5rQ6qvt?=
 =?iso-8859-1?Q?DGeJ/dxopaeznOoj6/IGdEw/4bKSlSxK/wveLsmaeINsPklr8ARxImcaUP?=
 =?iso-8859-1?Q?420DBeS7lCrnFjDKwQR9PJoHOaBaMIvOo9hIGWJaxsnv5Pa1KFukMVZx5o?=
 =?iso-8859-1?Q?8BKu0SrHvxx/lrAr4orsNJkc8mtfSONfW3/WBwx95wxyqiO2BTjFUI78Hb?=
 =?iso-8859-1?Q?brF3CP+KZ35XKLobd/ngylfXfGCC3i/qAPvTZiq6SoB93AnMixBoXNpGIP?=
 =?iso-8859-1?Q?LJeWKnhbPdsye2zFv+d4+6VlAk8bitspumUpl8DNuAHBnZSyLtOJH0RxUk?=
 =?iso-8859-1?Q?5im11uwkvp4RLFu/tOsXSkpaZZdmcThByA8N2Kq9zZ7ZJznf66dDx7WsCp?=
 =?iso-8859-1?Q?/5O2OrEpbbO4t374vk16kZqNlnH0Fh7YEmulqHkIPXQhTsqDZ+FEnfXijD?=
 =?iso-8859-1?Q?q1nLn/p4YG1n0Er9jD2aMKqeas1T20Pi64PgGCIPd7QmN4hnVkkOcxw2cN?=
 =?iso-8859-1?Q?GWGijRiPRacv4tduIuvnCnA//RzOzdIObCHsBtHiz18RkdxDNvIhiIHTCJ?=
 =?iso-8859-1?Q?xBscs6xDpfyJajdldmLQoTSAEv6xoEKD/K/q7GGlKnpAG+nuRqR/YD8wmb?=
 =?iso-8859-1?Q?eneq4ch6zNVM2NEVXkBzFRLq7gxisNq3aCBD9M15qcn3dPb/YPK7DMY6X+?=
 =?iso-8859-1?Q?vvrL14oOXHyRoJM0dWNCaDiw26hBj15LNmX80PcnlfmyZuRAW73Vv7nIub?=
 =?iso-8859-1?Q?tI/+S7cFcZH//YQ+nku7a02cT0dXkEY+qMM0cul3ynHR8PVv9VjXfxwoRj?=
 =?iso-8859-1?Q?/cwCF+9jD8hlRiHnRJbwBVoMSGHnJa2lUN7buzL6as4f29xbOhCiuiC4IX?=
 =?iso-8859-1?Q?ez/2HhsHDAB0NtX4ca2q3KQuHl3C9AuwbSfdxUyQ8T7b/roKBQxWYtxhrX?=
 =?iso-8859-1?Q?PEaM2/h8Z62EX4NOcZ/8ABAzTumGq75MgcJjBWg3DRMdc/zBgyr/90kvoV?=
 =?iso-8859-1?Q?6R7O7G6eTpgDeMg0tAghptskRX9yxU2XsxM8pClXz0HTtkl5OXX0iyjzie?=
 =?iso-8859-1?Q?970GkODJrSkhzAZ/Kr7gsX5QHjCEcAB+zchGW6e3QMfHv0cMx7gu/EtGbC?=
 =?iso-8859-1?Q?Zfvq5Rwx1/cQgLkpHlaC+1nA4Or0wJEPK3penYsnyYWFjHVjOJ7ha2rsOL?=
 =?iso-8859-1?Q?e3XD359HgZ/5OQ6NfFA5AI79b89YruLkUWdFPoVAKuzSotFn8yWzt8qnD8?=
 =?iso-8859-1?Q?l6Kh/5HMGauL3ydiSzBOyqGY4GBX4jrDwWoEcNxlfu3AkY4STYyw9PgEmR?=
 =?iso-8859-1?Q?Rcn1Vak2nXpLsj6l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VSmF1mFPuS8rpsZMQbhv/D7d2aDoYoOI0KYgQ/ggXW9ODkQyY1PMtiRGtc?=
 =?iso-8859-1?Q?dKoVo4jMD2FYN07cDgSLHzBLaQlQ2p2nBlKHPCNgACCiWH/wV28u+bwal0?=
 =?iso-8859-1?Q?V/gRH+qJFzFNNGstG4WepwP8slaLSjtB2CJV/uRawkuvWFe8mJtpcPsOda?=
 =?iso-8859-1?Q?E2bBgtJlxpF2sYElK54SMgJCrA1+UtuVR9dZMM/hQzE42oCx0PTcpqRgfu?=
 =?iso-8859-1?Q?FUu9OR7Nk+m7stjg9H96UIjeQW9F5gCaCGA9EbjlcYNKnTmcI9GTMulMBD?=
 =?iso-8859-1?Q?SI0hxlzvomEf09adOXR17LBNxIif1FOQWfjs+UvYcVHPoureJDpwlrlKDe?=
 =?iso-8859-1?Q?+45VltbPth2lP3tSmwO+BKTUic9uqvaxTydznZtIlZ5D8d4vol9dzWz9T1?=
 =?iso-8859-1?Q?BA1+dnekGZO2BsVZ+MnMjKoekEbapp0MlC9sV3qf2p2Z13mNT2vubQ51Qh?=
 =?iso-8859-1?Q?Kak63ycjtSt8ynoFCWorsrOwJlYqHpmrRK8Nfsb6DWRDEjfY4kj3DHFFzL?=
 =?iso-8859-1?Q?sE6ZHaYOKz8kO19UHvfg9SteHt9i/W7hBDVf1KmzPeS9LQ49RBof9cJzi8?=
 =?iso-8859-1?Q?pDU651NtG0xr6bPgDIWGDhzqsRYbs11Z2Ah5vQT2h/73cJWpVTSxj0l6nx?=
 =?iso-8859-1?Q?Yy/2pfVt9EIifw5Td/Xot+7dgsEgZyjT3WmxGmim4VVSfxEYLgHRiPcxzr?=
 =?iso-8859-1?Q?obdffGkM/n/0vmd4OZMT9wx66iFlYBy6z7ikfeS7eGg5YrysnI46RQX3BL?=
 =?iso-8859-1?Q?gexPfGIIzURpx3a2q0qbqV51ZbohNwAkZ4b288WnqYMBRAi+WszCeEjtKe?=
 =?iso-8859-1?Q?fBYWVCiM1OcV41D8B7VuSOcUYxDjNvqeOFviDa3+a28SwR9FB0XlBlnveG?=
 =?iso-8859-1?Q?au5QbFBIw3MmY6Z+8tOnbdES1Q9LnDU2LnWtJuMclctYfiKjUz4tI3l1mP?=
 =?iso-8859-1?Q?VypGFLi6LJyYrAM262B6Hx7UQpCTWFmkSlfmEk1ag+ZauP0++QiFDW18lr?=
 =?iso-8859-1?Q?wSBxeJAvvz2NuNyxnxHj6jyuE2e0XPmM4zl/B3QKsZgqPdqFX3E5Sn4Jzc?=
 =?iso-8859-1?Q?xtdqKmyPiU841HR2Fs81t/TnQDjpllA1NeJMftSCHmgp3B6OKFsiFlWMXY?=
 =?iso-8859-1?Q?50GkrvvM4dexirX/M0pxg7JfG59HZqjbe71PATebgGNxXVyJFoGRTDY1gG?=
 =?iso-8859-1?Q?E6QX1zHsrNJUVUMCBkds+YC/gQF66hH0r8gm1qej2QAZfBuWsZ9i7oZnON?=
 =?iso-8859-1?Q?wVx2+iiG7GQDz+1UU78uR37hh8ZGa/sz4R+1treipF76jAawCNS6kVJ/Pb?=
 =?iso-8859-1?Q?eJ9vHk751YHtGEX6oKeo/rnoxvbEHxmHfNN0WucM2dnptAakMhZ1otOGjV?=
 =?iso-8859-1?Q?N2jpj00nvSbY30odfkC1X7bP5kPt+1enmiVz2fF6Ye5OqkrCvsHi3a0HM9?=
 =?iso-8859-1?Q?rn4dAua93nGRqLWJpoNRsmPxBGgBUoiRGWu2D8uknxQvW14YvfBkz8zdZ9?=
 =?iso-8859-1?Q?vi1CCLIV4CLwMycgq/436POyEskhpE5hnwCav8on6i9GCmMQD3Qq/0oRdS?=
 =?iso-8859-1?Q?WwbdA7Sbox/vGS0UGU+QWalxXzWZ2ETI1UTYba4eB0JNz7+ze0BLVIBwS4?=
 =?iso-8859-1?Q?CX1X6M3IiECqk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73679fc7-fe9a-44f5-a573-08dd4b3e718a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 08:22:52.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUhQXF2uNnKcFTLP+7XHdGYUcqGq0NwqDn6kV1kF8jvLQqZ8E14aVBkhAlG2KMCcOwKAaQeOyUGpv2fDprDLTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897

> Subject: Re: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-
> controller references
>=20
> Am Dienstag, 11. Februar 2025, 04:33:41 CET schrieb Peng Fan:
> >
> > On Mon, Feb 10, 2025 at 04:48:56PM +0100, Alexander Stein wrote:
> > >Am Montag, 10. Februar 2025, 03:36:48 CET schrieb Peng Fan:
> > >> > Subject: Re: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-
> > >> > controller references
> > >> >
> > >> > Hi Peng,
> > >> >
> > >> > Am Freitag, 7. Februar 2025, 13:02:13 CET schrieb Peng Fan:
> > >> > > On Fri, Feb 07, 2025 at 09:36:09AM +0100, Alexander Stein
> wrote:
> > >> > > >Mark ocotp as a access-controller and add references on
> > >> > > >peripherals which can be disabled (fused).
> > >> > >
> > >> > > I am not sure whether gpcv2 changes should be included in
> this
> > >> > > patchset or not. Just add access-controller for fused IP will no=
t
> work.
> > >> >
> > >> > Well, I was able to successfully boot a i.MX8M Nano DualLite.
> > >> >
> > >> > > i.MX8M BLK-CTRL/GPC will hang if the related power domain is
> > >> > > still touched by kernel. The pgc can't power up/down because
> > >> > > clock is
> > >> > gated.
> > >> >
> > >> > Well, with GPU node disabled, no one should enable the power
> domain.
> > >> > But to be on the safe side I would also add access-controllers to
> > >> > the corresponding power domains as well.
> > >> >
> > >> > > This comment also apply to i.MX8MM/P.
> > >> >
> > >> > Sure. Do you have any information what is actually disabled by
> > >> > those fused?
> > >> > It seems it's the IP and their power domains. Anything else?
> > >>
> > >> In NXP downstream there is a patch for
> > >> drivers/pmdomain/imx/imx8m-blk-ctrl.c
> > >>
> > >> soc: imx8m-blk-ctrl: Support fused modules
> > >>
> > >>     For fused module, its pgc can't power up/down and clock is
> gated.
> > >>     Because imx8m-blk-ctrl driver will
> pm_runtime_get_sync/pm_runtime_put
> > >>     all power domains during suspend/resume. So we have to
> remove the
> > >>     pgc and clock of fused module from blk-ctrl DTS node.
> > >>     Update the driver to support such case.
> > >>
> > >> But this patch also needs U-Boot to update device tree nodes, I
> > >> recalled that U-Boot will remove gpc nodes, but not update blk-
> ctrl nodes.
> > >
> > >Does it work, if we add the access-controller as well for pgc_gpu3d
> > >on imx8mp? There is nothing in blk-ctrl AFAICS. But for VPU there is.
> >
> > Adding access-controller under pgc_gpu node will not make
> fwdevlink
> > work for the pgc_gpu nodes. It does not have compatible, and device
> is
> > created by gpcv2 driver using platform_device_alloc. Same to vpu.
> >
> > >Which clock needs to be removed there in case g1 is disabled?
> >
> > Take i.MX8MP VC8000E as example, the vpumix blk ctrl, the vc8000e
> > reference under vpumix blkctrl should be removed, including pd and
> clock.
>=20
> Wait, so you want to remove the last entry from these properties?
>=20
> > clocks =3D <&clk IMX8MP_CLK_VPU_G1_ROOT>,
> > 	 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
> > 	 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
> > clock-names =3D "g1", "g2", "vc8000e";
>=20
> This violates the DT binding.

Not sure whether dt bindings should be different for one SoC
that some modules maybe fused out that not usable. Actually
this is different SoC per my understanding.

Without changing the binding, the idea I am thinking
is to add nvmem =3D <&ocotp X>, <& ocotp Y>, xxxx; for
the node. Then driver could check nvmem to see
whether module avaibable.

But for pgc, we still need the pd available from sw view,
otherwise blk ctrl may not probe because of
fwdevlink.

Regards,
Peng

>=20
> > So for non-blkctrl nodes, it is fine to use access-controller and rely
> > on fwdelink to defer probe. But for blk ctrl nodes, it will not work.
> >
> > For pgc nodes, it may or may not matter, not very sure for now.
> >
> > For blk ctrl nodes, we need provide a generic API saying
> > access_control_check or directly using nvmem API.
>=20
> Reading access-controllers.yaml this should still be feasible for
> providing the necessary information.
> But I'm note sure where to implement this. In e.g. imx-ocotp would be
> a very SoC-specific API.
>=20
> Best regards,
> Alexander
> --
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld,
> Germany Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> www.tq-
> group.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7Ccb387da
> 6989845e6bee608dd4b3ccd2a%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638749446703427130%7CUnknown%7CTWFpbGZ
> sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dd
> OARjpfOaGqV2GNJ9TPiUs7qd703QPOzjUiFFQMRX0s%3D&reserved=3D0
>=20


