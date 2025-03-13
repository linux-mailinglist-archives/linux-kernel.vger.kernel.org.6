Return-Path: <linux-kernel+bounces-558761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6CA5EAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5571778BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3813B58B;
	Thu, 13 Mar 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jIFZ5cqM"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738F2F2E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842241; cv=fail; b=cVAdWt20pTJdd07dkFYVICRxmtcQU5fIFdI7sSsu2pvVE8BPwNixxSWpm909QJLOQE9Yvi1ppc/lgHJTGy3SkwIN5YDZz6sgKr6XUVEwcQq1CHJdCt4Tlq6VtgfQ78EHo2FC9TbUJccvmIt3MD3RnXFxIxH9IAfgJIpj18RRBsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842241; c=relaxed/simple;
	bh=0x/98eYRi5F9hwd3yaZb6beko0P+XpXPBwXkrdSHr3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pqa0OQSDCJ3LJ69GtYnTeskiDUTjDWg1b97VMFI1zzhCoFe6oW+9bruCRwNpCdNmfKi4z0uOBG+c0i7v88dbgi/6IDZX0TkImFd6WXjPjSPKP+ncYqPnmWUjBaKmI5kvT3UQkRWQxfxCik+zWEtdUtXfgkLYlAsJ3BkmJpM0dTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jIFZ5cqM; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thephJuQtFhP2OcUZ2eTXyhcj4ph1zqIN2lmhxtJ8znoS+hQQ+v5LF/Morhr2AZceQAH5KKDG4r294tiUUYLC7fGawgv8W1MwBS2n87IM/Ld0CV18kEhx9CYLCGsB7V8xmJGdaMGhvTJXJp1Rcvv8SLoMeSyoPAABejMQVrouximQ/uLMRthhbY8shm25b9WAoeiu2mEwsjqe9a5z6WdbXTRpn3Qq3nmZ76JQ/XvCVu2dNdt4djcdV2Yp125V5Uo2lt3yJLdCRxTQRSbugr6zVzoe3s9gMza03jwJEnFmK+JeJb+Hv+Z2ZHoCTdEo9cCeBcSUmb42rTnLJEFqYJG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgXdiMR+H9/I9dXF1YXDsTEMfl5XDowQGVC/WG0F8rs=;
 b=KlwlusYbvbU5lFPI44f+ZDeiaHRGUhRIugelpjprwphjGIYh3/mQfbxOGq1IGjRSr1cmEAIzIm3c5up3wYRL9gH3jOHMu234fNmuTdSyusOKet4c0vnYpPRG63eunBM5Rn92bfQQ1rpjh7SThgSIH9+iGtgwjZ33MAGBczQsWhXR5SKMnH9jepit8LsgXqWIDna08xsjv33/MNxtaHHi3UtWurFsfs5kd0DGP8l84HkP0RzQrt60iYCcn2uD+BxnZgmjmKEkBOLBTjxdFrUAo1zdkPyktmNztSOVtrSOnU5hasmS0WFOCrUIBG37vOuR07euyXmg01LtpaxAbHaMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgXdiMR+H9/I9dXF1YXDsTEMfl5XDowQGVC/WG0F8rs=;
 b=jIFZ5cqMKPNRN2aBrFVEl6uHszeR/9P40p/74gt/ExZ64HsoNo8agp+wGnfXHxwie3btxu2mgEUsSz804bR3aHJ/9qEKohyqCm+FsDYD6SMX4vUbDvK3sYBZjkYM1uqDF/o7J4Ekm7RvvHgV11nFRHVt+m8RysLQKU1LQ4TFcr/TIo6vSN89A3bu0IOYVp8sa6QUrI41QEh7By+AfMH/b0BKLNl1+gx21RQzLxuKEECJeirYf7vdAintDj6PcvJj/HJ2Vja5n/aYrnDmkFB5gYpOyDhX61ZsKJ4RXiIF7f/01j/M89Daxcbui67AF9bPdrJ/mjgk22iPW1DqohsV+w==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by PAXPR04MB8407.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 05:03:55 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:03:54 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: RE: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Topic: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Index:
 AQHbhmrgLz9oTBo3ckmGrUVlGQqbF7Nc48qAgAjnVUCAAIGuAIABWKqwgAA17oCACMEXYA==
Date: Thu, 13 Mar 2025 05:03:54 +0000
Message-ID:
 <VI1PR04MB10049C80F0A1990551F97E25C8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|PAXPR04MB8407:EE_
x-ms-office365-filtering-correlation-id: b035f0a2-8e1e-4288-5065-08dd61ec745e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3R9BpkFJj6BXHA51IXM54mR817Y4BtD1V1JLZ1bps8+KoNZNIhrOKEGWEDCj?=
 =?us-ascii?Q?EoT32Q1MneJ46UEc8GX96tcFwRUSkctfOMyV6YOL8+/Md/387SMdIi7Gjl9b?=
 =?us-ascii?Q?0HIuuj1spbdkOvaE11x5/FF941rKKzNuiNTGlzHCJxyYcyxFzfN6LFFpBiKV?=
 =?us-ascii?Q?KOP5S/gbwa7xLU1BwAdJ98j3KW3OXZcohLmxu5mxfO8hSHb2McRIbkp/tFRj?=
 =?us-ascii?Q?KCTWissGAHXaO+0uP2oIM1DIbrFfOSGCWFN9qfxom6DjDHYkdw14U+7DPxMm?=
 =?us-ascii?Q?bt7VJP4bS12ECggVIInMf4wGZrk40A6gQwOxl82amrzoGhFE08IY8oD8ycGa?=
 =?us-ascii?Q?tpykMrOZccOqAb1U/E8kTLvwh7wRt5atQTbSgcXxAhGqBfY+JA1VEzRY0VZQ?=
 =?us-ascii?Q?IM9C6A+cpkKqGH5B3qHjav6HCcknl//wXHz/0Y1LUKga3EeCg9LLI1ER9RiJ?=
 =?us-ascii?Q?pwvlB1inDqlKR6wm0B0T4wDp7FUWfSnfGAUF/R71T10SttEy3OfVYWsqLF29?=
 =?us-ascii?Q?A+XjEOtoLVKdVwqxcPCAoYaAQWtbBDZOMAO3DtqRZ/Yk0GNuxm+PFudLWlSU?=
 =?us-ascii?Q?AS4yH4g/86+GtU0uTYlCb0C8QJceeu4oEA/eudFa9fd4k7hM9AVSsZwgiBqW?=
 =?us-ascii?Q?kqJKi/+nz+BL1FGahFgEsaX6O3wwKYNKqOEo73Wk/Z0B9Ud/SSvUPKwEBAj6?=
 =?us-ascii?Q?sx6sRdmqbtj4LzIti9zh1BE/emkogOoVgRy2aUckHy26ZpWU4u5Gnqb782HZ?=
 =?us-ascii?Q?Y83gIp6+/10Q/gkb50yudxH9gMbyB9pabgyVbtrabOLrxhYdOyVtQmHBjdXP?=
 =?us-ascii?Q?WouEGa/Z53nKP/ujtmV7NPp/Bbjt9FUH6L55fxr/r7ow8oRU2uHyYiyzc7K1?=
 =?us-ascii?Q?560awZtIMGbZj8C552Bs1yRARfDfL4SZ2YQZxJ/NxFkEtaOqB/1/W3Baifc/?=
 =?us-ascii?Q?yIoDnXPsB6hUvfbdngPWY0kv3uLAlBQMTWJFCrEqOkrn5YSF6V5RfHTKmR0A?=
 =?us-ascii?Q?A6xuIIuujTOmIIQTFymyUbhP5zDCNRE7+hvRiha30lnI+dzSHiAqnnt2T1y0?=
 =?us-ascii?Q?45d9PVYkqsYAnsEM8+7jO2TZEM9lAChmmrVlHoDgskVyjb3KBDMsQRRnmmsW?=
 =?us-ascii?Q?oC9xERFGhH4aYoqOMor4Rd5VJNHPADlFFF3ocLORFtTkOLD2GN78IoqcRmEF?=
 =?us-ascii?Q?NYT5HlTcK0RDxdqv9hjSykpiiY1dss4jelOVp6txOGzk5KQWZL0NkfQjGZTd?=
 =?us-ascii?Q?OYKcTQpLAe7VIb16jD//RSCEEtv5uUnwolGbu3jCavxsQJSNHlfaUnQZjWJw?=
 =?us-ascii?Q?wxZKr0z02fuGMls9sFYrm3Gek8/9A7XsNVCafU8aIFdpV7zNoh9K8FbsTTNI?=
 =?us-ascii?Q?uyNfs1X2KJiF4rpUCDoUjHjNcBnkzMOKnxvylzDBYb3g+1DASjYk1ufaGTO1?=
 =?us-ascii?Q?PzoHb/VA99COQSAfn935raFmZGqlYOZj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4qK0aqsJ1QPBhYnzcks36uH5sGfQVUJcFiFPf8bngb8rodq+837xwtYh/8Ys?=
 =?us-ascii?Q?GlfMjgdVo3Q/ISZFe2va80n/TEbuPrGiNPze8ijNLkI2YeGp8utOR1DmQpiO?=
 =?us-ascii?Q?qMWeNjMMhBdRz19F4FQ/EniV6D/7iRudvLwZB7BVBddAsr4IORZH9vM6vODA?=
 =?us-ascii?Q?aGt9vwqblK9jkSWyTzW5S2KIBV3BFj29Jd3JwXgJ/IK6G7MJqW0ytcYag7rE?=
 =?us-ascii?Q?SpQUbT0Shv6gt6sru83yJtvlWHUu09V3c2awZG4WiIrravhKogZvzVi4tXr9?=
 =?us-ascii?Q?eX+ZBZXv2taxikKP+ZL+nGeDUD9Qjo97XhlRqo/ZWrljdQM8EroJgD8Ihd+L?=
 =?us-ascii?Q?Jw1CS6mu92GSFORZ8a8qojFAKT43OR6r9JgasqmsUteKlYlB/329vkfIXxcu?=
 =?us-ascii?Q?HQnpgMAQjsUWyg2do3Pjt1MV48cHXrR2Gdd8w1PCkyWEUuwtY0QOReXBkLhC?=
 =?us-ascii?Q?UReIOjyu40cWp066EUQm55ADWPDmwv0gERdprFm9dHaqbfI3Pcf3X3ogmIAN?=
 =?us-ascii?Q?P/BclV3G/JC6hAkvO0lN0yV11oXUl2h5Im57I8ROtpo1DzDilMsdGHAoFSsm?=
 =?us-ascii?Q?zV0ejq0lmu+VXBDmIL1730XL/yg0PrXRX08Zre9VfsxmTcX1wiSVOGvGWx+v?=
 =?us-ascii?Q?CPA/fxZ739EoJjHdXRRdxIL5RLvrpJNu4MbumwVD22RANdxuih2BoWpZ/3Xz?=
 =?us-ascii?Q?DlKC6VDyRKdv8mx8ufjYchpWtT5h8ZQP+GmRHLqiwJeDx+lzMky4ccOM7bPN?=
 =?us-ascii?Q?rpf5X4swZIe8PxLD6FiLLJ1BR+bX8VkkZxjcerI4pj6CK/7BBtix+kUKnc1U?=
 =?us-ascii?Q?s8xtT4EXq46NK/vjgtInbgs/Lu8yuBdcCOKQohLVf8KlJwcEvoTD3lql5fv1?=
 =?us-ascii?Q?LZ7P2Gn8R97blihG2d3N773+I8MK7FMHfUpZCvhTEVJneHlWpf4t5fhHjRfb?=
 =?us-ascii?Q?Jf+D6KA/+7sEFGLex6GNH8DU3y1MzPbFBmCNI1UUIFN5Mfiv+PIXwblPLYlc?=
 =?us-ascii?Q?KnRxzPLbTLe+95qIJ6YZGrPHkSNfpy0ZNuur/a+FMteE8TsXbG1znmMQep7Q?=
 =?us-ascii?Q?X/1PKwkPwxsC2T5/iLAvMM+tVl4c0AT6vQ0SjwXEMstra7jAf8jngrEu733i?=
 =?us-ascii?Q?xn/4YNHt6NK0+J/yUaKsbqMg7nxVNOYVp7CB4UL9peh6Zb/fQoddgfG8JH6d?=
 =?us-ascii?Q?QLSdOH3rFpgGTVDlJH490p8k1NBDj4jIT7ICf0uNw48hAzGkkq1uWv8gywhY?=
 =?us-ascii?Q?HCPm+IWIT+Vi3kBWN2NrumVGq/MEIaR9WZd6IkSImNn03k1WeK7CYZaVHzh+?=
 =?us-ascii?Q?CiwMvN01gCRs91rSCLx5jY4YHxMlxx0obFPmLqFH75/hnXaRtatKIs8ohIdc?=
 =?us-ascii?Q?AuMkr+8isaD8nowB2YK2DASsEf9JnfgDLyFld76oGUVqRjSDcAFwWDNS2cES?=
 =?us-ascii?Q?QNfp0YdU2poegDqwU1cgMrSeYc7y08d/pxEyJ4P+6P/7paVqiIrmnP2RLJQw?=
 =?us-ascii?Q?NnGjOAMSXBE1OooH2kw5D8Mnj6mcR+jYd1bLZGv/PCLOeF3LnL/7PYEF4EKz?=
 =?us-ascii?Q?dLB72upjNEtJ5RHIXzgTaY7ly2DrFD3J5tZNdMyGaWmmwIk8c6gIFrHXyotv?=
 =?us-ascii?Q?VA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b035f0a2-8e1e-4288-5065-08dd61ec745e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 05:03:54.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7zeJxKvgSeqRzzEYTXnA8XtsDDroq0Fx27Q258HEwjJRsSixB++IezJjQogysK7769HfJiOax+wkCI2v/tus4YlQmNI7CTOJocRmVJHK/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Friday, March 7, 2025 8:48 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; rvmanjumce@gmail.com
> Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
>=20
> On Fri, Mar 07, 2025 at 12:34:53PM +0000, Manjunatha Venkatesh wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Thursday, March 6, 2025 9:01 PM
> > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > fixed
> > >
> > > On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh
> wrote:
> > > > Hi Frank,
> > > >
> > > > Please find my inline comments.
> > > >
> > > > Regards,
> > > > Manju
> > >
> > > Avoid top post for linux kernel mail list.
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <frank.li@nxp.com>
> > > > > Sent: Friday, February 28, 2025 9:19 PM
> > > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > > linux- kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > > > fixed
> > > > >
> > > > > Subject should be "Fix read from unreadable memory at
> > > > > svc_i3c_master_ibi_work()"
> > > > > Or like below pattern:
> > > > > 	Do ... to fix ...
> > > > >
> > > > [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > > > > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh
> > > wrote:
> > > > > > I3C Master driver svc-i3c-master
> > > > >
> > > > > Needn't this line.
> > > > >
> > > > [Manjunatha Venkatesh] Removed this line and submitted the new
> > > > patch
> > > > > >
> > > > > > As part of I3C driver probing sequence for particular device
> > > > > > instance, While adding to queue it is trying to access ibi
> > > > > > variable of dev which is not yet initialized causing "Unable
> > > > > > to handle kernel read from unreadable memory" resulting in kern=
el
> panic.
> > > > >
> > > > > Can you provide more detail information why/how this happen?
> > > > > which varible read cause this problem?
> > > > >
> > > > [Manjunatha Venkatesh] : Below is the sequence where this issue
> > > happened.
> > > > 1. During boot up sequence IBI is received at host  from the slave
> > > > device
> > > before requesting for IBI, Usually will request IBI by calling
> > > i3c_device_request_ibi() during probe of slave driver.
> > > > 2. Since master code trying to access IBI Variable for the
> > > > particular device
> > > instance before actually it initialized by slave driver, due to this
> > > randomly accessing the address and causing kernel panic.
> > > > 3. i3c_device_request_ibi() function invoked by the slave driver
> > > >where dev- ibi =3D ibi; assigned as part of function call
> i3c_dev_request_ibi_locked().
> > > > 4. But when IBI request sent by slave device, master code  trying
> > > >to access
> > > this variable before its initialized due to this race condition
> > > situation kernel panic happened.
> > >
> > > Write above reproduce steps to commit message.
> > >
> > [Manjunatha Venkatesh] : Next commit will update this description.
> > > I think it is common problem for i3c framework.
> > >
> > > You'd better change i3c_master_queue_ibi()
> > >
> > > void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct
> > > i3c_ibi_slot *slot) {
> > > 	if (!slot)
> > > 		return;
> > >
> > >         atomic_inc(&dev->ibi->pending_ibis);
> > >         queue_work(dev->ibi->wq, &slot->work); }
> > >
> > [Manjunatha Venkatesh] : Actual issue we have faced with respect to 'de=
v-
> >ibi' variable.
>=20
> How about
> if (!dev->ibi || !slot) {
> 	dev_warning("...");
> 	return;
> }
>=20
[Manjunatha Venkatesh] : dev->ibi is not initialized to null, might be some=
 random value be there.
If it initialized to null at the right place then this check can be added.

> Frank
>=20
> > Pointer variable 'slot' is with respect IBI received from slave device =
context
> and 'dev->ibi' is with respect to initialization of slave driver these 2 =
are
> asynchronous events.
> > dev->ibi =3D ibi; is initialized at i3c_dev_request_ibi_locked(), this =
is invoked as
> part of slave driver IBI init sequence, this is what we want to check bef=
ore
> processing the IBI request from the Slave device.
> > master->ibi.slots[i] this is where all device ibi instance list are sav=
ed, so here
> our slave driver init IBI stored with respect dev->ibi index.
> > So adding 'if (!slot)' will not help to resolve this issue.
>=20
>=20
> Please wrap around at 80 char to read easily.
>=20
>=20
> >
> > > Frank
> > > >
> > > >
> > > > > Need fix tags and cc stable.
> > > > >
> > > > [Manjunatha Venkatesh] : fix tags and cc stable updated in the
> > > > commit
> > > message.
> > > >
> > [Manjunatha Venkatesh] : Last commit message missed to update fix tags
> and cc stable.
> > Will update that information as part of next commit message.
> > > > > Frank
> > > > > >
> > > > > > Signed-off-by: Manjunatha Venkatesh
> > > <manjunatha.venkatesh@nxp.com>
> > > > > > ---
> > > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > > @@ -534,8 +534,11 @@ static void
> > > > > > svc_i3c_master_ibi_work(struct
> > > > > work_struct *work)
> > > > > >  	switch (ibitype) {
> > > > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > > >  		if (dev) {
> > > > > > -			i3c_master_queue_ibi(dev, master-
> >ibi.tbq_slot);
> > > > > > -			master->ibi.tbq_slot =3D NULL;
> > > > > > +			data =3D i3c_dev_get_master_data(dev);
> > > > > > +			if (master->ibi.slots[data->ibi]) {
> > > > > > +				i3c_master_queue_ibi(dev, master-
> > > > > >ibi.tbq_slot);
> > > > > > +				master->ibi.tbq_slot =3D NULL;
> > > > > > +			}
> > > > > >  		}
> > > > > >  		svc_i3c_master_emit_stop(master);
> > > > > >  		break;
> > > > > > --
> > > > > > 2.46.1
> > > > > >
> > > > > >
> > > > > > --
> > > > > > linux-i3c mailing list
> > > > > > linux-i3c@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c

