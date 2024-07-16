Return-Path: <linux-kernel+bounces-253342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F7931FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3103628286E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B4171B6;
	Tue, 16 Jul 2024 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+cwy+bZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8D18E28;
	Tue, 16 Jul 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721105414; cv=fail; b=kgX8MPVfwplvvaOA32qUM14MYNDo5X/cE0NBvsUVUMaXkjItigR3bYUN0EmhK48h7mOezSIR9cAcJTHzBBPRsoq6c5JXh43HEdzAvF5WiXjVHNNCfEdDaxEx/sKCCtLjNutmGwg0sO0Vmho+usH4IgpB3uFhhIaRI2gVDlBINf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721105414; c=relaxed/simple;
	bh=JYWXcNqO9xone1Jal+1+uCqb/ZtrJb2y/QPswBqlbw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQcfFZd71+X4cv6UDMmpsuaeBwRrGDQb8+zNGzc2sJPj5f8UZQTWI90rnQmR2i0JsBWCb/W2dQmCeMvQBMtRZaFo1UJbYA3tagC/TLO21bjWGqr1Ka6MocRiKTF4FZwDVSpfK50shRbUty8HOWuChq3ePU+oKRxjcYikW0Da+do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q+cwy+bZ; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEfRhwjb5dJpiYdlhCnZdpVM2a5xWSkbgygaRhfCoqvtvDFnJaLKq87cxL3o5xQYqSa3eZsvByx5hVgkwJ6WwoBGlwYbjQQRsGCdQ3UgunOCy8hQlb1R6bNpdteStuJP4/wVMk5GbB709GiVQQK4FH3ezK+spO1vfNj7IlvP3FWfGKWKcjcbPPEeMHYh75ljRRXieO3XGavgVGIWooml/zia17rL1hVME/8oYugfJytqTG6411qMLRe8wYmZ11smYvgjQLkCa3wwfNIg/bRyt3JeQssxzVAoEh876nAKyzBqNKeGeL/tja//W9PdveeeEcXtXQeGp4WymbAvK8vTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58DeIG9rWcobkcF3v/VuK3x0RrfkPaxacpuE5NnC1qE=;
 b=m0W9iW/R1F+RKEudZoybvo1w+74qJWCEVq62TtY5y+Ea0bOAtM8Io8qq1jLkBU3+Zr/zGtNRkE4dLxdFJAlXjJq8h8mupXYtQKge06favns0aSuUPkXFBt/JNWVNUFV7ee/FOY87ijDT/rUDd/Zclxkwtpa0psE7C8DbslCcIDOVbnwteKKKP9c7E0muk4VTa2blubcN7A6zEY2e6SG2mYN6c/T0R80301Fiy+TuSTJ3PBb4uwUWGnSKBjB+L8K/C8LFQSji7gZimVN/qyebEVjajTwL5jflxr78F5y7rf9tx17rueEwWZ768BoRBMarDjyl38qlsNhVblFVXREG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58DeIG9rWcobkcF3v/VuK3x0RrfkPaxacpuE5NnC1qE=;
 b=Q+cwy+bZGS7QMpxhi9RPo2J52EjQpfS3yFEMLgwRi+i8c7ZZZ2RqVUSSvAsZNRhAEgTBB7BUChFc1BmGeZLrfFShOWPKeyiniSVqqAqMgfrN0VXQiY+DNN+Adr16Kz0vu2WUYUw0b+kOw4+0u/HXNLbThoOtBtoO1LahQ8daPXU=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 04:50:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 04:50:05 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 5/5] firmware: imx: adds miscdev
Thread-Topic: [PATCH v5 5/5] firmware: imx: adds miscdev
Thread-Index: AQHa1CQHR4SC7DsdikirBdveP8YwE7Hzqs8AgAUjyEA=
Date: Tue, 16 Jul 2024 04:50:05 +0000
Message-ID:
 <AM9PR04MB860496FEE467B7CC7C2DF50895A22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-5-66a79903a872@nxp.com>
 <ZpGr6qKjJKz14J+y@lizhi-Precision-Tower-5810>
In-Reply-To: <ZpGr6qKjJKz14J+y@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB8405:EE_
x-ms-office365-filtering-correlation-id: 98e30c0c-a54a-4e20-f40a-08dca552c31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vx3w6wPdeyeKebNL+x5vARSvdMoqexdcsd0h/zYj2PbCfHpH6W20OKMS24sD?=
 =?us-ascii?Q?5/XaTYkTRY34bDXTpHEj33z2hba5vAA8STBq+SwA0n/b8VWSVKWn6DhuXF2Y?=
 =?us-ascii?Q?I3Lu6Rut6w7dQmKp+l2X27UWoo4S1syFkxzlMeXBBgcsRDDnWvZa05iikPvT?=
 =?us-ascii?Q?PpY/Ze4nAbtRKW13R2EYiSAa2aR66vR4v665B5p2pmVrho7pHUr3Y0lYD5BD?=
 =?us-ascii?Q?S+uyC/293R+zoCg75sMoA5e03uEW2TD5zVRIK6DIDpaLGECfVNfXeSSoZ3hx?=
 =?us-ascii?Q?L/lYj+bQ1IWzjFHvrDU/4xeGIpSMTulg06P2A/IEo8iY06G8lU2ZLsHbGgP0?=
 =?us-ascii?Q?5PVCLlth9bJhIuPJfRwC1c+vLzYWju2e4qYYlLdKZvZBCB6cSHRLP/CZWsMX?=
 =?us-ascii?Q?0+PlXI+cTwbt3HE7qF6NQEOhULDcAfPhAAXcW7cz48vizgQ1cVgmFR87uj/g?=
 =?us-ascii?Q?F7aTutz2c9OrUW5CKHGECe0qfNGgVFYYaoicevjxbzRSHZbDL0fs6wP81tMU?=
 =?us-ascii?Q?CRePmMwgWXDXQgRD7xJ0gd3j6QS64grffCgw5yxeuDpvPYN6lL8bBiAwRQSC?=
 =?us-ascii?Q?b3xUWN+vETH/iO6+93q6jE0pSFL3hfNWErLG0KEIyQfgNHvvak6Apq2pTINm?=
 =?us-ascii?Q?eys8Ni+AR+aFFH8s5AG5HF3LD4FiRSX7BXttVL7gTRtHMZM1q+US6/7wKj2h?=
 =?us-ascii?Q?whmUJXeVEVpsJOMvjDUSRh5ViqeCibyBobifOhT871O2An1J47E7I7AIf3OC?=
 =?us-ascii?Q?IjWbCzh876nkNw2pvHnlxZ1dV6/BztqGatPZqxIFzcPMckWnC1tvJvSJ8sE0?=
 =?us-ascii?Q?no/vsjKMKkml2ItFsmpeOHCXikzTS8YZhJo3vQHPq1gTJdkg+7VcSv9Mq59N?=
 =?us-ascii?Q?hgnC9YEOwBggkdijHSzTZvWhWlukM2H5P8l8aUeoWzKIOgatCrF1qbipnIXl?=
 =?us-ascii?Q?fL4BnRdxUc3hP0MqixwTsdYGu1yxja9BX6HAFsnRJK9XWkt/r18jKw2zHb+/?=
 =?us-ascii?Q?PaDOydMinTrDaJ1nY581ywlF6NpW3LEvdAdS+UckB+5pZg/xSflZjcdJzb8P?=
 =?us-ascii?Q?tUTWjN6r/XvbtdLnaLxHdy3bDyO+iBolJnmXIP0IOCOGw7jaDAFqS42K+MJ6?=
 =?us-ascii?Q?2BUQAeuM5SC9UZudbNwioqTHUySkCUEN8EW4JxEII15i+W1Ts6vXPwd+d/Ez?=
 =?us-ascii?Q?x0OL0m+PU2TFUTA+E3bF6fCKPizWiiswQAysYPNNq2yfomOPvpIfVyigLLOZ?=
 =?us-ascii?Q?FbxupMKzkLw/K+EsI9oB2d6PpgQ4ZqZZxe4cy00OiD8FSC/lCmY4v8fXH42W?=
 =?us-ascii?Q?TGfFF4Lo0Mj8RfS5oAksezzVnos+fUYSgKfYvSaK/Y/UZv+SKhst2bqGwszL?=
 =?us-ascii?Q?Pz67VUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/QPhCW2z30tcEkus7d03w5YFEe1H9JHGI1ZGmEfgLUWX0hGJNBA27+rBHgPL?=
 =?us-ascii?Q?Kdfk7IDZ3mn3Tup03il19ztpRdRgWdKXHtEuSJwH0Q9p02l3gDoDvhqVDyKl?=
 =?us-ascii?Q?9vFfx9vsxJNb4UVtAw09aETLYUw7VeRsN/dt1MqIyfmKHhyeTL0/kRyjxOR1?=
 =?us-ascii?Q?hDie7LZrC5LVu484TkJnUEGb99GZ8EDj8/r7E+QcEOrNwk3nzMRVupe+xVHZ?=
 =?us-ascii?Q?IZq73Jdm1F5rRR5maT7Y9mCh8UT8x/AJA5cfjMmf5idlQafYSNH27E5aG7Kp?=
 =?us-ascii?Q?JDIzS5ag0aclPvxNtb2dqRUVTNe57LNZ/8CTdBfkgCIXtP4SXZIXn8BMhoRi?=
 =?us-ascii?Q?ENZ0e8hKtzoggnL82Ow4QsJLVsbvhWhLF6HwHsXBohbO8GNcv16s1Q+Jw7mK?=
 =?us-ascii?Q?fXFML7pdZCTh1zJMYIqcgv0LUjdVOgFD9eE+ooKkXJUaVVli8+dxlfz2mgPk?=
 =?us-ascii?Q?tBtqVff6UnGzxcgWQKulgzMlrjfp8mtON83gPJAEAeFcth+0BoB9UwteTmbM?=
 =?us-ascii?Q?iKUL+7ipoM+2oMi1SuwToh5z02snSTry3uZaQxnMem5ed36Mz4aDF0oHOICu?=
 =?us-ascii?Q?DlXzqTN60b6TaynO48Xp3FdsH1ciR0miVRsR+yw9/FNUmsttrZdHpiLkUNA1?=
 =?us-ascii?Q?/tgtvUze8xaWO4sFHYAG1pfNNyiGxbScdHF1+KZzh2IdCFg7UWaDJTH9FvEe?=
 =?us-ascii?Q?KFPwXutZjQMDFSJ1zfw4NMHkfy8SelFreH15KcN87fL8tkvqLkhcN795FOty?=
 =?us-ascii?Q?Lmkmv81FZFwg2JFrpYbfai7UoUvjawsHZFIkrRuuUNR1x/+qowJK1xpFT2Ke?=
 =?us-ascii?Q?JmeELQ5xRl6jWi32IEkhT5FeYFO8tW6QXcfB1pPaMmnh4UQRfOcKKhi0XZEL?=
 =?us-ascii?Q?xSbzQBNEenwFsP4dYr4it9f0ni8uJrwR0TtGTcc6Bfu16UtMS8XPjuwdHnbz?=
 =?us-ascii?Q?IKezgGTaUrMOQqKYkmLVTCKdV3a/IEs+hq/pHuVhq473+c1A2CaIgCoEUMeB?=
 =?us-ascii?Q?wr4wg4ya6DZAXZN91wRiOJ69ujmnLItglj5xxcHYqoRzROyMM986fVmSKFwR?=
 =?us-ascii?Q?8AhrK6nWBvAqbZNGOmFvlgGDdw+m6xK9OSsQ5tZn+PRyoBhOlG1qfvgCkhaW?=
 =?us-ascii?Q?Nwxy/hvJBaN8/3rbYt8QHsz0lGmY2caWDm63LP5dkrLDqjWUHN9PxNaolCjx?=
 =?us-ascii?Q?UvpNelnmGR+3dRPsbTOxZPKHh/glEb4zAo80hvwY6PVNLykqMc0Ln6KkqCc8?=
 =?us-ascii?Q?dPH1AbNsTGKa8fxNsdTvVLyvqE6lMd7yNWv0UCs7nAvWwARBjHG6Bf8f7mlc?=
 =?us-ascii?Q?yfv721iowoV9vxw0oxYUmrM/omNI3gW8H4Ut/t+w4I+nndGIiYfmBS02HiHU?=
 =?us-ascii?Q?la7vRaS2GfodZK9kwh7FXDwyKtcAmfoP3oXEy/PYF5YkoX90MKBpDHDTtjxl?=
 =?us-ascii?Q?iW+n1Jg0ECuJfYMVyffMH0gbnhT5to8T/PRG7Gf4cgdqdR3/dMPqqHNFdtex?=
 =?us-ascii?Q?nPqZ06eRloF6vMSMC54f4wbaiaykJcgwK/4cXpWyOuGfEOuaxAz5Jg9ftHwL?=
 =?us-ascii?Q?ifrKIU7KeNGx5ARDNkgK5rj9tMyQ87/CtksqJjKR?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e30c0c-a54a-4e20-f40a-08dca552c31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 04:50:05.8909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDlEDOR8/+4IzQ7YqNKSLlbZrxc1c5s7Yeew5d8QbgE+pHAcABOXdE2PuGneL7M/dN9ZzU+wisuAVH9cNNFXvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Saturday, July 13, 2024 3:49 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v5 5/5] firmware: imx: adds miscdev
>=20
> On Fri, Jul 12, 2024 at 11:50:00AM +0530, Pankaj Gupta wrote:
> > Adds the driver for communication interface to secure-enclave, for
> > exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> > Enclave from:
> > - User-Space Applications via character driver.
> >
> > ABI documentation for the NXP secure-enclave driver.
> >
> > User-space library using this driver:
> > - i.MX Secure Enclave library:
> >   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> > - i.MX Secure Middle-Ware:
> >   -- URL: https://github.com/nxp-imx/imx-smw.git
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  Documentation/ABI/testing/se-cdev |  43 +++
> > drivers/firmware/imx/ele_common.c | 192 ++++++++++-
> >  drivers/firmware/imx/ele_common.h |   4 +
> >  drivers/firmware/imx/se_ctrl.c    | 697
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h    |  49 +++
> >  include/uapi/linux/se_ioctl.h     |  94 +++++
> >  6 files changed, 1076 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/se-cdev
> > b/Documentation/ABI/testing/se-cdev
> > new file mode 100644
> > index 000000000000..3451c909ccc4
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/se-cdev
> > @@ -0,0 +1,43 @@
> > +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> > +Date:		May 2024
> > +KernelVersion:	6.8
> > +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> > +Description:
> > +		NXP offers multiple hardware IP(s) for secure enclaves like
> EdgeLock-
> > +		Enclave(ELE), SECO. The character device file descriptors
> > +		/dev/<se>_mu*_ch* are the interface between userspace
> NXP's secure-
> > +		enclave shared library and the kernel driver.
> > +
> > +		The ioctl(2)-based ABI is defined and documented in
> > +		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > +		ioctl(s) are used primarily for:
> > +			- shared memory management
> > +			- allocation of I/O buffers
> > +			- getting mu info
> > +			- setting a dev-ctx as receiver to receive all the
> commands from FW
> > +			- getting SoC info
> > +			- send command and receive command response
> > +
> > +		The following file operations are supported:
> > +
> > +		open(2)
> > +		  Currently the only useful flags are O_RDWR.
> > +
> > +		read(2)
> > +		  Every read() from the opened character device context is
> waiting on
> > +		  wait_event_interruptible, that gets set by the registered
> mailbox callback
> > +		  function, indicating a message received from the firmware on
> message-
> > +		  unit.
> > +
> > +		write(2)
> > +		  Every write() to the opened character device context needs
> to acquire
> > +		  mailbox_lock before sending message on to the message
> unit.
> > +
> > +		close(2)
> > +		  Stops and frees up the I/O contexts that were associated
> > +		  with the file descriptor.
> > +
> > +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
> > +		https://github.com/nxp-imx/imx-smw.git
> > +		crypto/skcipher,
> > +		drivers/nvmem/imx-ocotp-ele.c
> > diff --git a/drivers/firmware/imx/ele_common.c
> > b/drivers/firmware/imx/ele_common.c
> > index b2be32550e9b..88169cd8f369 100644
> > --- a/drivers/firmware/imx/ele_common.c
> > +++ b/drivers/firmware/imx/ele_common.c
> > @@ -78,6 +78,149 @@ int ele_msg_send_rcv(struct se_if_priv *priv, void
> *tx_msg, void *rx_msg)
> >  	return err;
> >  }
> >
> > +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
> > +			void *rx_buf,
> > +			int rx_buf_sz)
> > +{
> > +	struct se_msg_hdr *header;
> > +	int err;
> > +
> > +	err =3D wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr !=
=3D
> 0);
> > +	if (err) {
> > +		dev_err(dev_ctx->dev,
> > +			"%s: Err[0x%x]:Interrupted by signal.\n",
> > +			dev_ctx->miscdev.name, err);
> > +		goto exit;
> > +	}
> > +
> > +	header =3D (struct se_msg_hdr *) dev_ctx->temp_resp;
> > +
> > +	if (header->tag =3D=3D dev_ctx->priv->rsp_tag) {
> > +		if (dev_ctx->priv->waiting_rsp_dev && dev_ctx->priv-
> >waiting_rsp_dev !=3D dev_ctx) {
> > +			dev_warn(dev_ctx->dev,
> > +			"Dev-ctx waiting for response mismatch
> (%s !=3D %s).\n",
> > +			dev_ctx->miscdev.name, dev_ctx->priv-
> >waiting_rsp_dev->miscdev.name);
> > +			err =3D -EPERM;
> > +			goto exit;
> > +		}
> > +	}
> > +
> > +	dev_dbg(dev_ctx->dev,
> > +		"%s: %s %s\n",
> > +		dev_ctx->miscdev.name,
> > +		__func__,
> > +		"message received, start transmit to user");
> > +
> > +	/*
> > +	 * Check that the size passed as argument is larger than
> > +	 * the one carried in the message.
> > +	 *
> > +	 * In case of US-command/response, the dev_ctx->temp_resp_size
> > +	 * is set before sending the command.
> > +	 *
> > +	 * In case of NVM Slave-command/response, the dev_ctx-
> >temp_resp_size
> > +	 * is set after receing the message from mailbox.
> > +	 */
> > +	if (dev_ctx->temp_resp_size > rx_buf_sz) {
> > +		dev_err(dev_ctx->dev,
> > +			"%s: User buffer too small (%d < %d)\n",
> > +			dev_ctx->miscdev.name,
> > +			rx_buf_sz, dev_ctx->temp_resp_size);
> > +		 dev_ctx->temp_resp_size =3D rx_buf_sz;
> > +	}
> > +
> > +	/* We may need to copy the output data to user before
> > +	 * delivering the completion message.
> > +	 */
> > +	err =3D se_dev_ctx_cpy_out_data(dev_ctx, true);
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	/* Copy data from the buffer */
> > +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +			     dev_ctx->temp_resp, dev_ctx->temp_resp_size,
> false);
> > +	if (copy_to_user(rx_buf, dev_ctx->temp_resp, dev_ctx-
> >temp_resp_size)) {
> > +		dev_err(dev_ctx->dev,
> > +			"%s: Failed to copy to user\n",
> > +			dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +	err =3D dev_ctx->temp_resp_size;
> > +exit:
> > +	if (err < 0)
> > +		se_dev_ctx_cpy_out_data(dev_ctx, false);
> > +
> > +	/* free memory allocated on the shared buffers. */
> > +	dev_ctx->secure_mem.pos =3D 0;
> > +	dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +	dev_ctx->pending_hdr =3D 0;
> > +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> > +
> > +	return err;
> > +}
> > +
> > +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +			 void *tx_msg, int tx_msg_sz)
> > +{
> > +	struct se_if_priv *priv =3D dev_ctx->priv;
> > +	struct se_msg_hdr *header;
> > +	u32 size_to_send;
> > +	int err;
> > +
> > +	header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +	/*
> > +	 * Check that the size passed as argument matches the size
> > +	 * carried in the message.
> > +	 */
> > +	size_to_send =3D header->size << 2;
> > +
> > +	if (size_to_send !=3D tx_msg_sz) {
> > +		err =3D -EINVAL;
> > +		dev_err(priv->dev,
> > +			"%s: User buf hdr(0x%x) sz mismatced with input-sz
> (%d !=3D %d).\n",
> > +			dev_ctx->miscdev.name, *(u32 *)header,
> size_to_send, tx_msg_sz);
> > +		goto exit;
> > +	}
> > +
> > +	/* Check the message is valid according to tags */
> > +	if (header->tag =3D=3D priv->rsp_tag) {
> > +		/* Check the device context can send the command */
> > +		if (dev_ctx !=3D priv->cmd_receiver_dev) {
> > +			dev_err(priv->dev,
> > +				"%s: Channel not configured to send resp to
> FW.",
> > +				dev_ctx->miscdev.name);
> > +			err =3D -EPERM;
> > +			goto exit;
> > +		}
> > +	} else if (header->tag =3D=3D priv->cmd_tag) {
> > +		if (priv->waiting_rsp_dev !=3D dev_ctx) {
> > +			dev_err(priv->dev,
> > +				"%s: Channel not configured to send cmd to
> FW.",
> > +				dev_ctx->miscdev.name);
> > +			err =3D -EPERM;
> > +			goto exit;
> > +		}
> > +		lockdep_assert_held(&priv->se_if_cmd_lock);
> > +	} else {
> > +		dev_err(priv->dev,
> > +			"%s: The message does not have a valid TAG\n",
> > +			dev_ctx->miscdev.name);
> > +		err =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +	err =3D ele_msg_send(priv, tx_msg);
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	err =3D size_to_send;
> > +exit:
> > +	return err;
> > +}
> > +
> >  static bool exception_for_size(struct se_if_priv *priv,
> >  				struct se_msg_hdr *header)
> >  {
> > @@ -99,6 +242,7 @@ static bool exception_for_size(struct se_if_priv
> > *priv,  void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> > {
> >  	struct device *dev =3D mbox_cl->dev;
> > +	struct se_if_device_ctx *dev_ctx;
> >  	struct se_if_priv *priv;
> >  	struct se_msg_hdr *header;
> >  	u32 rx_msg_sz;
> > @@ -114,8 +258,50 @@ void se_if_rx_callback(struct mbox_client
> *mbox_cl, void *msg)
> >  	header =3D msg;
> >  	rx_msg_sz =3D header->size << 2;
> >
> > -	if (header->tag =3D=3D priv->rsp_tag) {
> > -		if (!priv->waiting_rsp_dev) {
> > +	/* Incoming command: wake up the receiver if any. */
> > +	if (header->tag =3D=3D priv->cmd_tag) {
> > +		dev_dbg(dev, "Selecting cmd receiver\n");
> > +		dev_ctx =3D priv->cmd_receiver_dev;
> > +		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> > +		 * as the NVM command are initiated by FW.
> > +		 * Size is revealed as part of this call function.
> > +		 */
> > +		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> > +			dev_err(dev,
> > +				"%s: Msg recvd hdr(0x%x) with greater[%d]
> than allocated buf-sz.\n",
> > +				dev_ctx->miscdev.name,
> > +				*(u32 *) header,
> > +				rx_msg_sz);
> > +		} else
> > +			memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
> > +
> > +		/* NVM buffer size are not known prior receiving it from FW.
> > +		 */
> > +		dev_ctx->temp_resp_size =3D rx_msg_sz;
> > +
> > +		/* Allow user to read */
> > +		dev_ctx->pending_hdr =3D 1;
> > +		wake_up_interruptible(&dev_ctx->wq);
> > +
> > +		return;
> > +	} else if (header->tag =3D=3D priv->rsp_tag) {
> > +		if (priv->waiting_rsp_dev) {
> > +			dev_dbg(dev, "Selecting rsp waiter\n");
> > +			dev_ctx =3D priv->waiting_rsp_dev;
> > +			if (rx_msg_sz !=3D dev_ctx->temp_resp_size
> > +				&& !exception_for_size(priv, header))
> > +				dev_err(dev,
> > +					"%s: Msg RSP hdr(0x%x) with
> different sz(%d !=3D %d).\n",
> > +					dev_ctx->miscdev.name,
> > +					*(u32 *) header,
> > +					rx_msg_sz, dev_ctx->temp_resp_size);
> > +			else
> > +				memcpy(dev_ctx->temp_resp, msg,
> rx_msg_sz);
> > +
> > +			/* Allow user to read */
> > +			dev_ctx->pending_hdr =3D 1;
> > +			wake_up_interruptible(&dev_ctx->wq);
> > +		} else {
> >  			/*
> >  			 * Reading the EdgeLock Enclave response
> >  			 * to the command, sent by other
> > @@ -132,8 +318,8 @@ void se_if_rx_callback(struct mbox_client
> > *mbox_cl, void *msg)
> >
> >  			complete(&priv->done);
> >  			spin_unlock(&priv->lock);
> > -			return;
> >  		}
> > +		return;
> >  	}
> >
> >  	dev_err(dev, "Failed to select a device for message: %.8x\n", diff
> > --git a/drivers/firmware/imx/ele_common.h
> > b/drivers/firmware/imx/ele_common.h
> > index 5ef775a42ab3..7b1c6bfc138b 100644
> > --- a/drivers/firmware/imx/ele_common.h
> > +++ b/drivers/firmware/imx/ele_common.h
> > @@ -17,6 +17,10 @@ uint32_t se_add_msg_crc(uint32_t *msg, uint32_t
> > msg_len);  int ele_msg_rcv(struct se_if_priv *priv);  int
> > ele_msg_send(struct se_if_priv *priv, void *tx_msg);  int
> > ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
> > +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
> > +			void *rx_msg, int rx_msg_sz);
> > +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +			 void *tx_msg, int tx_msg_sz);
> >  void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);  int
> > se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> >  			    struct se_msg_hdr *header,
> > diff --git a/drivers/firmware/imx/se_ctrl.c
> > b/drivers/firmware/imx/se_ctrl.c index a844794d2b39..8fb2af0f0dd3
> > 100644
> > --- a/drivers/firmware/imx/se_ctrl.c
> > +++ b/drivers/firmware/imx/se_ctrl.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/sys_soc.h>
> > +#include <uapi/linux/se_ioctl.h>
> >
> >  #include "ele_base_msg.h"
> >  #include "ele_common.h"
> > @@ -196,6 +197,608 @@ static int se_soc_info(struct se_if_priv *priv,
> >  	return 0;
> >  }
> >
> > +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx
> *dev_ctx,
> > +					    u64 arg)
> > +{
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +	int err =3D 0;
> > +
> > +	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
> > +			   sizeof(cmd_snd_rcv_rsp_info))) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed to copy cmd_snd_rcv_rsp_info from
> user\n",
> > +			dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: User buffer too small(%d < %d)\n",
> > +			dev_ctx->miscdev.name,
> > +			cmd_snd_rcv_rsp_info.tx_buf_sz,
> > +			SE_MU_HDR_SZ);
> > +		err =3D -ENOSPC;
> > +		goto exit;
> > +	}
> > +
> > +	rx_msg =3D kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
> > +	if (!rx_msg) {
> > +		err =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	tx_msg =3D memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
> > +			     cmd_snd_rcv_rsp_info.tx_buf_sz);
> > +	if (IS_ERR(tx_msg)) {
> > +		err =3D PTR_ERR(tx_msg);
> > +		goto exit;
> > +	}
> > +
> > +	if (tx_msg->header.tag !=3D priv->cmd_tag) {
> > +		err =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	scoped_guard(mutex, &priv->se_if_cmd_lock);
>=20
> You totally wrong use scoped_guard in whole patch.
>=20
> fun()
> {
>      guard(); //which means lock here
>      ...
>      return; // unlock here
> }
>=20
> scoped_guard()
> {     // lock here
>       ...
>       //unlock here
> }
>=20
> your code scoped_guard(mutex, &priv->se_if_cmd_lock); is equal to
>=20
>       mutex_lock();
>       mutex_unlock();
>=20
> Nothing protected by mutex lock at all.
>=20
> Frank Li

Thanks for the explanation, Frank.
Will replace scope_guard with guard().

>=20
>=20
> > +	priv->waiting_rsp_dev =3D dev_ctx;
> > +	dev_ctx->temp_resp_size =3D cmd_snd_rcv_rsp_info.rx_buf_sz;
> > +
> > +	/* Device Context that is assigned to be a
> > +	 * FW's command receiver, has pre-allocated buffer.
> > +	 */
> > +	if (dev_ctx !=3D priv->cmd_receiver_dev)
> > +		dev_ctx->temp_resp =3D rx_msg;
> > +
> > +	err =3D ele_miscdev_msg_send(dev_ctx,
> > +				   tx_msg,
> > +				   cmd_snd_rcv_rsp_info.tx_buf_sz);
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	cmd_snd_rcv_rsp_info.tx_buf_sz =3D err;
> > +
> > +	err =3D ele_miscdev_msg_rcv(dev_ctx,
> > +				  cmd_snd_rcv_rsp_info.rx_buf,
> > +				  cmd_snd_rcv_rsp_info.rx_buf_sz);
> > +
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	cmd_snd_rcv_rsp_info.rx_buf_sz =3D err;
> > +
> > +exit:
> > +	dev_ctx->temp_resp_size =3D 0;
> > +	priv->waiting_rsp_dev =3D NULL;
> > +	if (dev_ctx !=3D priv->cmd_receiver_dev)
> > +		dev_ctx->temp_resp =3D NULL;
> > +
> > +	if (copy_to_user((void *)arg, &cmd_snd_rcv_rsp_info,
> > +			 sizeof(cmd_snd_rcv_rsp_info))) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed to copy cmd_snd_rcv_rsp_info from
> user\n",
> > +			dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +	}
> > +	return err;
> > +}
> > +
> > +/*
> > + * File operations for user-space
> > + */
> > +
> > +/* Write a message to the MU. */
> > +static ssize_t se_if_fops_write(struct file *fp, const char __user *bu=
f,
> > +				size_t size, loff_t *ppos)
> > +{
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_if_device_ctx *dev_ctx;
> > +	struct se_if_priv *priv;
> > +	int err;
> > +
> > +	dev_ctx =3D container_of(fp->private_data,
> > +			       struct se_if_device_ctx,
> > +			       miscdev);
> > +	priv =3D dev_ctx->priv;
> > +	dev_dbg(priv->dev,
> > +		"%s: write from buf (%p)%zu, ppos=3D%lld\n",
> > +			dev_ctx->miscdev.name,
> > +			buf, size, ((ppos) ? *ppos : 0));
> > +
> > +	if (down_interruptible(&dev_ctx->fops_lock))
> > +		return -EBUSY;
> > +
> > +	if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +		err =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	if (size < SE_MU_HDR_SZ) {
> > +		dev_err(priv->dev,
> > +			"%s: User buffer too small(%zu < %d)\n",
> > +				dev_ctx->miscdev.name,
> > +				size, SE_MU_HDR_SZ);
> > +		err =3D -ENOSPC;
> > +		goto exit;
> > +	}
> > +	tx_msg =3D memdup_user(buf, size);
> > +	if (IS_ERR(tx_msg)) {
> > +		err =3D PTR_ERR(tx_msg);
> > +		goto exit;
> > +	}
> > +
> > +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +			     tx_msg, size, false);
> > +
> > +	err =3D ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> > +
> > +exit:
> > +	up(&dev_ctx->fops_lock);
> > +	return err;
> > +}
> > +
> > +/*
> > + * Read a message from the MU.
> > + * Blocking until a message is available.
> > + */
> > +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> > +			       size_t size, loff_t *ppos)
> > +{
> > +	struct se_if_device_ctx *dev_ctx;
> > +	struct se_if_priv *priv;
> > +	int err;
> > +
> > +	dev_ctx =3D container_of(fp->private_data,
> > +			       struct se_if_device_ctx,
> > +			       miscdev);
> > +	priv =3D dev_ctx->priv;
> > +	dev_dbg(priv->dev,
> > +		"%s: read to buf %p(%zu), ppos=3D%lld\n",
> > +			dev_ctx->miscdev.name,
> > +			buf, size, ((ppos) ? *ppos : 0));
> > +
> > +	if (down_interruptible(&dev_ctx->fops_lock))
> > +		return -EBUSY;
> > +
> > +	if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +		err =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	err =3D ele_miscdev_msg_rcv(dev_ctx, buf, size);
> > +
> > +exit:
> > +	up(&dev_ctx->fops_lock);
> > +	return err;
> > +}
> > +
> > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > +				u64 arg)
> > +{
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +	struct se_if_node_info *if_node_info;
> > +	struct se_ioctl_get_if_info info;
> > +	int err =3D 0;
> > +
> > +	if_node_info =3D (struct se_if_node_info *)priv->info;
> > +
> > +	info.se_if_id =3D if_node_info->se_if_id;
> > +	info.interrupt_idx =3D 0;
> > +	info.tz =3D 0;
> > +	info.did =3D if_node_info->se_if_did;
> > +	info.cmd_tag =3D if_node_info->cmd_tag;
> > +	info.rsp_tag =3D if_node_info->rsp_tag;
> > +	info.success_tag =3D if_node_info->success_tag;
> > +	info.base_api_ver =3D if_node_info->base_api_ver;
> > +	info.fw_api_ver =3D if_node_info->fw_api_ver;
> > +
> > +	dev_dbg(priv->dev,
> > +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> > +			dev_ctx->miscdev.name,
> > +			info.se_if_id, info.interrupt_idx, info.tz, info.did);
> > +
> > +	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed to copy mu info to user\n",
> > +				dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	return err;
> > +}
> > +
> > +/* Need to copy the output data to user-device context.
> > + */
> > +int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool
> > +do_cpy) {
> > +	struct se_buf_desc *b_desc, *temp;
> > +
> > +	list_for_each_entry_safe(b_desc, temp, &dev_ctx->pending_out, link)
> {
> > +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr &&
> do_cpy) {
> > +
> > +			dev_dbg(dev_ctx->dev,
> > +				"%s: Copy output data to user\n",
> > +				dev_ctx->miscdev.name);
> > +			if (copy_to_user(b_desc->usr_buf_ptr,
> > +					 b_desc->shared_buf_ptr,
> > +					 b_desc->size)) {
> > +				dev_err(dev_ctx->dev,
> > +					"%s: Failure copying output data to
> user.",
> > +					dev_ctx->miscdev.name);
> > +				return -EFAULT;
> > +			}
> > +		}
> > +
> > +		if (b_desc->shared_buf_ptr)
> > +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +		list_del(&b_desc->link);
> > +		kfree(b_desc);
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Clean the used Shared Memory space,
> > + * whether its Input Data copied from user buffers, or
> > + * Data received from FW.
> > + */
> > +void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
> > +{
> > +	struct list_head *dev_ctx_lists[] =3D {&dev_ctx->pending_in,
> > +						 &dev_ctx->pending_out};
> > +	struct se_buf_desc *b_desc, *temp;
> > +	int i;
> > +
> > +	for (i =3D 0; i < 2; i++) {
> > +		list_for_each_entry_safe(b_desc, temp,
> > +					 dev_ctx_lists[i], link) {
> > +
> > +			if (b_desc->shared_buf_ptr)
> > +				memset(b_desc->shared_buf_ptr, 0, b_desc-
> >size);
> > +
> > +			list_del(&b_desc->link);
> > +			kfree(b_desc);
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * Copy a buffer of data to/from the user and return the address to
> > +use in
> > + * messages
> > + */
> > +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_c=
tx,
> > +					    u64 arg)
> > +{
> > +	struct se_shared_mem *shared_mem =3D NULL;
> > +	struct se_ioctl_setup_iobuf io =3D {0};
> > +	struct se_buf_desc *b_desc =3D NULL;
> > +	int err =3D 0;
> > +	u32 pos;
> > +
> > +	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed copy iobuf config from user\n",
> > +				dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +	dev_dbg(dev_ctx->priv->dev,
> > +			"%s: io [buf: %p(%d) flag: %x]\n",
> > +			dev_ctx->miscdev.name,
> > +			io.user_buf, io.length, io.flags);
> > +
> > +	if (io.length =3D=3D 0 || !io.user_buf) {
> > +		/*
> > +		 * Accept NULL pointers since some buffers are optional
> > +		 * in FW commands. In this case we should return 0 as
> > +		 * pointer to be embedded into the message.
> > +		 * Skip all data copy part of code below.
> > +		 */
> > +		io.ele_addr =3D 0;
> > +		goto copy;
> > +	}
> > +
> > +	/* Select the shared memory to be used for this buffer. */
> > +	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> > +		/* App requires to use secure memory for this buffer.*/
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed allocate SEC MEM memory\n",
> > +				dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	} else {
> > +		/* No specific requirement for this buffer. */
> > +		shared_mem =3D &dev_ctx->non_secure_mem;
> > +	}
> > +
> > +	/* Check there is enough space in the shared memory. */
> > +	if (shared_mem->size < shared_mem->pos ||
> > +		round_up(io.length, 8u) >=3D (shared_mem->size -
> shared_mem->pos)) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Not enough space in shared memory\n",
> > +				dev_ctx->miscdev.name);
> > +		err =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	/* Allocate space in shared memory. 8 bytes aligned. */
> > +	pos =3D shared_mem->pos;
> > +	shared_mem->pos +=3D round_up(io.length, 8u);
> > +	io.ele_addr =3D (u64)shared_mem->dma_addr + pos;
> > +
> > +	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> > +	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> > +		/*Add base address to get full address.*/
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed allocate SEC MEM memory\n",
> > +				dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +	memset(shared_mem->ptr + pos, 0, io.length);
> > +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> > +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> > +		/*
> > +		 * buffer is input:
> > +		 * copy data from user space to this allocated buffer.
> > +		 */
> > +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> > +				   io.length)) {
> > +			dev_err(dev_ctx->priv->dev,
> > +				"%s: Failed copy data to shared memory\n",
> > +				dev_ctx->miscdev.name);
> > +			err =3D -EFAULT;
> > +			goto exit;
> > +		}
> > +	}
> > +
> > +	b_desc =3D kzalloc(sizeof(*b_desc), GFP_KERNEL);
> > +	if (!b_desc) {
> > +		err =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +copy:
> > +	/* Provide the EdgeLock Enclave address to user space only if
> success.*/
> > +	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed to copy iobuff setup to user\n",
> > +				dev_ctx->miscdev.name);
> > +		kfree(b_desc);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +	if (b_desc) {
> > +		b_desc->shared_buf_ptr =3D shared_mem->ptr + pos;
> > +		b_desc->usr_buf_ptr =3D io.user_buf;
> > +		b_desc->size =3D io.length;
> > +
> > +		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> > +			/*
> > +			 * buffer is input:
> > +			 * add an entry in the "pending input buffers" list so
> > +			 * that copied data can be cleaned from shared
> memory
> > +			 * later.
> > +			 */
> > +			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
> > +		} else {
> > +			/*
> > +			 * buffer is output:
> > +			 * add an entry in the "pending out buffers" list so data
> > +			 * can be copied to user space when receiving Secure-
> Enclave
> > +			 * response.
> > +			 */
> > +			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
> > +		}
> > +	}
> > +
> > +exit:
> > +	return err;
> > +}
> > +
> > +/* IOCTL to provide SoC information */ static int
> > +se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> > +					     u64 arg)
> > +{
> > +	const struct se_if_node_info_list *info_list;
> > +	struct se_ioctl_get_soc_info soc_info;
> > +	int err =3D -EINVAL;
> > +
> > +	info_list =3D device_get_match_data(dev_ctx->priv->dev);
> > +	if (!info_list)
> > +		goto exit;
> > +
> > +	soc_info.soc_id =3D info_list->soc_id;
> > +	soc_info.soc_rev =3D dev_ctx->priv->soc_rev;
> > +
> > +	err =3D (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_in=
fo));
> > +	if (err) {
> > +		dev_err(dev_ctx->priv->dev,
> > +			"%s: Failed to copy soc info to user\n",
> > +			dev_ctx->miscdev.name);
> > +		err =3D -EFAULT;
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	return err;
> > +}
> > +
> > +/* Open a character device. */
> > +static int se_if_fops_open(struct inode *nd, struct file *fp) {
> > +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> > +							struct
> se_if_device_ctx,
> > +							miscdev);
> > +	int err =3D 0;
> > +
> > +	/* Avoid race if opened at the same time */
> > +	if (down_trylock(&dev_ctx->fops_lock))
> > +		return -EBUSY;
> > +
> > +	/* Authorize only 1 instance. */
> > +	if (dev_ctx->status !=3D SE_IF_CTX_FREE) {
> > +		err =3D -EBUSY;
> > +		goto exit;
> > +	}
> > +
> > +	/*
> > +	 * Allocate some memory for data exchanges with S40x.
> > +	 * This will be used for data not requiring secure memory.
> > +	 */
> > +	dev_ctx->non_secure_mem.ptr =3D dmam_alloc_coherent(dev_ctx-
> >dev,
> > +					MAX_DATA_SIZE_PER_USER,
> > +					&dev_ctx-
> >non_secure_mem.dma_addr,
> > +					GFP_KERNEL);
> > +	if (!dev_ctx->non_secure_mem.ptr) {
> > +		err =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	dev_ctx->non_secure_mem.size =3D MAX_DATA_SIZE_PER_USER;
> > +	dev_ctx->non_secure_mem.pos =3D 0;
> > +	dev_ctx->status =3D SE_IF_CTX_OPENED;
> > +
> > +	dev_ctx->pending_hdr =3D 0;
> > +
> > +	goto exit;
> > +
> > +	dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> > +			   dev_ctx->non_secure_mem.ptr,
> > +			   dev_ctx->non_secure_mem.dma_addr);
> > +
> > +exit:
> > +	up(&dev_ctx->fops_lock);
> > +	return err;
> > +}
> > +
> > +/* Close a character device. */
> > +static int se_if_fops_close(struct inode *nd, struct file *fp) {
> > +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> > +							struct
> se_if_device_ctx,
> > +							miscdev);
> > +	struct se_if_priv *priv =3D dev_ctx->priv;
> > +
> > +	/* Avoid race if closed at the same time */
> > +	if (down_trylock(&dev_ctx->fops_lock))
> > +		return -EBUSY;
> > +
> > +	/* The device context has not been opened */
> > +	if (dev_ctx->status !=3D SE_IF_CTX_OPENED)
> > +		goto exit;
> > +
> > +	/* check if this device was registered as command receiver. */
> > +	if (priv->cmd_receiver_dev =3D=3D dev_ctx) {
> > +		priv->cmd_receiver_dev =3D NULL;
> > +		kfree(dev_ctx->temp_resp);
> > +	}
> > +
> > +	/* check if this device was registered as waiting response. */
> > +	if (priv->waiting_rsp_dev =3D=3D dev_ctx) {
> > +		priv->waiting_rsp_dev =3D NULL;
> > +		mutex_unlock(&priv->se_if_cmd_lock);
> > +	}
> > +
> > +	/* Unmap secure memory shared buffer. */
> > +	if (dev_ctx->secure_mem.ptr)
> > +		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> > +
> > +	dev_ctx->secure_mem.ptr =3D NULL;
> > +	dev_ctx->secure_mem.dma_addr =3D 0;
> > +	dev_ctx->secure_mem.size =3D 0;
> > +	dev_ctx->secure_mem.pos =3D 0;
> > +
> > +	/* Free non-secure shared buffer. */
> > +	dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> > +			   dev_ctx->non_secure_mem.ptr,
> > +			   dev_ctx->non_secure_mem.dma_addr);
> > +
> > +	dev_ctx->non_secure_mem.ptr =3D NULL;
> > +	dev_ctx->non_secure_mem.dma_addr =3D 0;
> > +	dev_ctx->non_secure_mem.size =3D 0;
> > +	dev_ctx->non_secure_mem.pos =3D 0;
> > +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> > +	dev_ctx->status =3D SE_IF_CTX_FREE;
> > +
> > +exit:
> > +	up(&dev_ctx->fops_lock);
> > +	return 0;
> > +}
> > +
> > +/* IOCTL entry point of a character device */ static long
> > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > +	struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_data,
> > +							struct
> se_if_device_ctx,
> > +							miscdev);
> > +	struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> > +	int err =3D -EINVAL;
> > +
> > +	/* Prevent race during change of device context */
> > +	if (down_interruptible(&dev_ctx->fops_lock))
> > +		return -EBUSY;
> > +
> > +	switch (cmd) {
> > +	case SE_IOCTL_ENABLE_CMD_RCV:
> > +		if (!se_if_priv->cmd_receiver_dev) {
> > +			err =3D 0;
> > +			se_if_priv->cmd_receiver_dev =3D dev_ctx;
> > +			dev_ctx->temp_resp =3D kzalloc(MAX_NVM_MSG_LEN,
> GFP_KERNEL);
> > +			if (!dev_ctx->temp_resp)
> > +				err =3D -ENOMEM;
> > +		}
> > +		break;
> > +	case SE_IOCTL_GET_MU_INFO:
> > +		err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> > +		break;
> > +	case SE_IOCTL_SETUP_IOBUF:
> > +		err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> > +		break;
> > +	case SE_IOCTL_GET_SOC_INFO:
> > +		err =3D se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> > +		break;
> > +	case SE_IOCTL_CMD_SEND_RCV_RSP:
> > +		err =3D se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
> > +		break;
> > +
> > +	default:
> > +		err =3D -EINVAL;
> > +		dev_dbg(se_if_priv->dev,
> > +			"%s: IOCTL %.8x not supported\n",
> > +				dev_ctx->miscdev.name,
> > +				cmd);
> > +	}
> > +
> > +	up(&dev_ctx->fops_lock);
> > +	return (long)err;
> > +}
> > +
> > +/* Char driver setup */
> > +static const struct file_operations se_if_fops =3D {
> > +	.open		=3D se_if_fops_open,
> > +	.owner		=3D THIS_MODULE,
> > +	.release	=3D se_if_fops_close,
> > +	.unlocked_ioctl =3D se_ioctl,
> > +	.read		=3D se_if_fops_read,
> > +	.write		=3D se_if_fops_write,
> > +};
> > +
> > +/* interface for managed res to unregister a character device */
> > +static void if_misc_deregister(void *miscdevice) {
> > +	misc_deregister(miscdevice);
> > +}
> > +
> >  /* interface for managed res to free a mailbox channel */  static
> > void if_mbox_free_channel(void *mbox_chan)  { @@ -233,6 +836,7 @@
> > static void se_if_probe_cleanup(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct se_if_priv *priv;
> > +	int i;
> >
> >  	priv =3D dev_get_drvdata(dev);
> >
> > @@ -252,6 +856,17 @@ static void se_if_probe_cleanup(struct
> platform_device *pdev)
> >  		priv->imem.buf =3D NULL;
> >  	}
> >
> > +	if (priv->ctxs) {
> > +		for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +			if (priv->ctxs[i]) {
> > +				devm_remove_action(dev,
> > +						   if_misc_deregister,
> > +						   &priv->ctxs[i]->miscdev);
> > +				misc_deregister(&priv->ctxs[i]->miscdev);
> > +			}
> > +		}
> > +	}
> > +
> >  	/* No need to check, if reserved memory is allocated
> >  	 * before calling for its release. Or clearing the
> >  	 * un-set bit.
> > @@ -259,6 +874,74 @@ static void se_if_probe_cleanup(struct
> platform_device *pdev)
> >  	of_reserved_mem_device_release(dev);
> >  }
> >
> > +static int init_device_context(struct se_if_priv *priv) {
> > +	const struct se_if_node_info *info =3D priv->info;
> > +	struct se_if_device_ctx *dev_ctx;
> > +	u8 *devname;
> > +	int ret =3D 0;
> > +	int i;
> > +
> > +	priv->ctxs =3D devm_kzalloc(priv->dev, sizeof(dev_ctx) * priv-
> >max_dev_ctx,
> > +				  GFP_KERNEL);
> > +
> > +	if (!priv->ctxs) {
> > +		ret =3D -ENOMEM;
> > +		return ret;
> > +	}
> > +
> > +	/* Create users */
> > +	for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +		dev_ctx =3D devm_kzalloc(priv->dev, sizeof(*dev_ctx),
> GFP_KERNEL);
> > +		if (!dev_ctx) {
> > +			ret =3D -ENOMEM;
> > +			return ret;
> > +		}
> > +
> > +		dev_ctx->dev =3D priv->dev;
> > +		dev_ctx->status =3D SE_IF_CTX_FREE;
> > +		dev_ctx->priv =3D priv;
> > +
> > +		priv->ctxs[i] =3D dev_ctx;
> > +
> > +		/* Default value invalid for an header. */
> > +		init_waitqueue_head(&dev_ctx->wq);
> > +
> > +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> > +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> > +		sema_init(&dev_ctx->fops_lock, 1);
> > +
> > +		devname =3D devm_kasprintf(priv->dev, GFP_KERNEL,
> "%s_ch%d",
> > +					 info->se_name, i);
> > +		if (!devname) {
> > +			ret =3D -ENOMEM;
> > +			return ret;
> > +		}
> > +
> > +		dev_ctx->miscdev.name =3D devname;
> > +		dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +		dev_ctx->miscdev.fops =3D &se_if_fops;
> > +		dev_ctx->miscdev.parent =3D priv->dev;
> > +		ret =3D misc_register(&dev_ctx->miscdev);
> > +		if (ret) {
> > +			dev_err(priv->dev, "failed to register misc
> device %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +
> > +		ret =3D devm_add_action(priv->dev, if_misc_deregister,
> > +				      &dev_ctx->miscdev);
> > +		if (ret) {
> > +			dev_err(priv->dev,
> > +				"failed[%d] to add action to the misc-dev\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static void se_load_firmware(const struct firmware *fw, void
> > *context)  {
> >  	struct se_if_priv *priv =3D (struct se_if_priv *) context; @@ -427,6
> > +1110,16 @@ static int se_if_probe(struct platform_device *pdev)
> >  		ret =3D 0;
> >  	}
> >
> > +	if (info->max_dev_ctx) {
> > +		ret =3D init_device_context(priv);
> > +		if (ret) {
> > +			dev_err(dev,
> > +				"Failed[0x%x] to create device contexts.\n",
> > +				ret);
> > +			goto exit;
> > +		}
> > +	}
> > +
> >  	dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> >  		 info->se_name);
> >  	return ret;
> > @@ -467,6 +1160,10 @@ static int se_resume(struct device *dev)  {
> >  	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >  	const struct se_if_node_info *info =3D priv->info;
> > +	int i;
> > +
> > +	for (i =3D 0; i < priv->max_dev_ctx; i++)
> > +		wake_up_interruptible(&priv->ctxs[i]->wq);
> >
> >  	if (info && info->imem_mgmt)
> >  		se_restore_imem_state(priv);
> > diff --git a/drivers/firmware/imx/se_ctrl.h
> > b/drivers/firmware/imx/se_ctrl.h index 4be2235d2170..b49346372746
> > 100644
> > --- a/drivers/firmware/imx/se_ctrl.h
> > +++ b/drivers/firmware/imx/se_ctrl.h
> > @@ -13,15 +13,62 @@
> >  #define MAX_FW_LOAD_RETRIES		50
> >
> >  #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> > +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
> > +#define MAX_NVM_MSG_LEN			(256)
> >  #define MESSAGING_VERSION_6		0x6
> >  #define MESSAGING_VERSION_7		0x7
> >
> > +#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> > +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> > +
> >  struct se_imem_buf {
> >  	u8 *buf;
> >  	phys_addr_t phyaddr;
> >  	u32 size;
> >  };
> >
> > +struct se_buf_desc {
> > +	u8 *shared_buf_ptr;
> > +	u8 *usr_buf_ptr;
> > +	u32 size;
> > +	struct list_head link;
> > +};
> > +
> > +/* Status of a char device */
> > +enum se_if_dev_ctx_status_t {
> > +	SE_IF_CTX_FREE,
> > +	SE_IF_CTX_OPENED
> > +};
> > +
> > +struct se_shared_mem {
> > +	dma_addr_t dma_addr;
> > +	u32 size;
> > +	u32 pos;
> > +	u8 *ptr;
> > +};
> > +
> > +/* Private struct for each char device instance. */ struct
> > +se_if_device_ctx {
> > +	struct device *dev;
> > +	struct se_if_priv *priv;
> > +	struct miscdevice miscdev;
> > +
> > +	enum se_if_dev_ctx_status_t status;
> > +	wait_queue_head_t wq;
> > +	struct semaphore fops_lock;
> > +
> > +	u32 pending_hdr;
> > +	struct list_head pending_in;
> > +	struct list_head pending_out;
> > +
> > +	struct se_shared_mem secure_mem;
> > +	struct se_shared_mem non_secure_mem;
> > +
> > +	struct se_api_msg *temp_resp;
> > +	u32 temp_resp_size;
> > +	struct notifier_block se_notify;
> > +};
> > +
> >  /* Header of the messages exchange with the EdgeLock Enclave */
> > struct se_msg_hdr {
> >  	u8 ver;
> > @@ -80,4 +127,6 @@ struct se_if_priv {
> >  	struct se_imem_buf imem;
> >  };
> >
> > +int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx, bool
> > +do_cpy); void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx
> > +*dev_ctx);
> >  #endif
> > diff --git a/include/uapi/linux/se_ioctl.h
> > b/include/uapi/linux/se_ioctl.h new file mode 100644 index
> > 000000000000..c2d0a92ef626
> > --- /dev/null
> > +++ b/include/uapi/linux/se_ioctl.h
> > @@ -0,0 +1,94 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR
> > +BSD-3-Clause*/
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef SE_IOCTL_H
> > +#define SE_IOCTL_H
> > +
> > +/* IOCTL definitions. */
> > +
> > +struct se_ioctl_setup_iobuf {
> > +	u8 *user_buf;
> > +	u32 length;
> > +	u32 flags;
> > +	u64 ele_addr;
> > +};
> > +
> > +struct se_ioctl_shared_mem_cfg {
> > +	u32 base_offset;
> > +	u32 size;
> > +};
> > +
> > +struct se_ioctl_get_if_info {
> > +	u8 se_if_id;
> > +	u8 interrupt_idx;
> > +	u8 tz;
> > +	u8 did;
> > +	u8 cmd_tag;
> > +	u8 rsp_tag;
> > +	u8 success_tag;
> > +	u8 base_api_ver;
> > +	u8 fw_api_ver;
> > +};
> > +
> > +struct se_ioctl_cmd_snd_rcv_rsp_info {
> > +	u32 *tx_buf;
> > +	int tx_buf_sz;
> > +	u32 *rx_buf;
> > +	int rx_buf_sz;
> > +};
> > +
> > +struct se_ioctl_get_soc_info {
> > +	u16 soc_id;
> > +	u16 soc_rev;
> > +};
> > +
> > +/* IO Buffer Flags */
> > +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> > +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> > +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> > +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> > +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> > +
> > +/* IOCTLS */
> > +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> > +
> > +/*
> > + * ioctl to designated the current fd as logical-reciever.
> > + * This is ioctl is send when the nvm-daemon, a slave to the
> > + * firmware is started by the user.
> > + */
> > +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> > +
> > +/*
> > + * ioctl to get the buffer allocated from the memory, which is shared
> > + * between kernel and FW.
> > + * Post allocation, the kernel tagged the allocated memory with:
> > + *  Output
> > + *  Input
> > + *  Input-Output
> > + *  Short address
> > + *  Secure-memory
> > + */
> > +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> > +					struct se_ioctl_setup_iobuf)
> > +
> > +/*
> > + * ioctl to get the mu information, that is used to exchange message
> > + * with FW, from user-spaced.
> > + */
> > +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> > +					struct se_ioctl_get_if_info)
> > +/*
> > + * ioctl to get SoC Info from user-space.
> > + */
> > +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> > +					struct se_ioctl_get_soc_info)
> > +
> > +/*
> > + * ioctl to send command and receive response from user-space.
> > + */
> > +#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
> > +					struct
> se_ioctl_cmd_snd_rcv_rsp_info) #endif
> >
> > --
> > 2.34.1
> >

