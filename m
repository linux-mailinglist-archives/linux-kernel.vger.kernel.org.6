Return-Path: <linux-kernel+bounces-256953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1393730F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D481F20FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B804374FF;
	Fri, 19 Jul 2024 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T36cmlLr"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E71B86F8;
	Fri, 19 Jul 2024 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721364560; cv=fail; b=YyI8rLUdJMGBQ9uHOO/17DlRtkBR5dpZN4Cwwt9JJpw0mzTjDqaThCpYMme2q6RlLymQKJReBd0rhQKjMEm54Sqj5LLCWGxDNlFoMx4HR/dMlYLGhMY8g6qEhTck4xYXROS3wJKcbmdppt1pajdJRPKOlhc9gCke4eyCjDCaoZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721364560; c=relaxed/simple;
	bh=PEvtlvtfcIvDGAKayeT28wY6QVobQoFimIi+3+keIjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgWFFH6SCy8THypOVRZJFbh/QZn5pHPbSsaSaTKzOz0SnI2X7im4jCeLSvJkeULDXAEt1EJjtXLjGSxg2v8SREWQ6CrQQ4sxSP9pDm7CFWxaehqjYL7/7fgqy4sresTIdA+V33Ud68BpR5QOhdf+q2vd2ZfwuhlqoLRWFUvU4s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T36cmlLr; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVr5we6E8Ht5iIUN8fTTH1Gw6bhLfdWJyh/qDrr69tkEZGVs1OngR2pCUXqGqFQEkh9vH9NZ+o/nkaAkNxRE507y6lTc8HEZaHwixaBzZ6L/rwWO7AnbexWotRDubQipKTfSY5q/qa7sKV2vjbqd81HgkWuSET21it2CXiaekpJa3mMQSCQ0l24zPP9JufrBnAraruG3Zhr3qAQ+3JAwsuLaLJzg7Kv6GfAk+DWCivVYYM/eDyurCGn1M/+CSxs+gY36s3BxykuIS7+6w7FNrrL/jjnrBHrMDCyMaYJ+0ZFLTS28x+SsFcLKxjcC+1Wpf064VtfsejuGOSECXiuwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8uoieJ6ywALqwXkjB/E6gEpOC7kgn75+FlKysKmnZY=;
 b=Edj1BcZfMdlNPdRs+gVOUAp92EIL9pyHwTdwwQ0FxTAiISn02qjcmPg8d9rp9da02azT1QlW+tcb75i6w0VLW8LTu6FwYa4jlkemVy07hoyjeSdqDoIJbPuHvm6xxx4P4rhrowVj3vYKz53FEZRxU+OL8AbMrdEbJFjgb60IyYn6wEAu6nL6Yyf/oGXLqiC0EpYJG3W65DY+6l/Svu/H1dl/zHf3zJp0v0H3qC7ulk/0rmj00pdg95keiEoh7z9e/2pmuyZQpnTbXluFUZP1HxMD2XSh0kYdMRWhZXrj66NIct7btjAzwagn3pSG/YduWnA3s1KnuHyzJquYsnFpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8uoieJ6ywALqwXkjB/E6gEpOC7kgn75+FlKysKmnZY=;
 b=T36cmlLrqWivD1yDtTSE/Lr+6Ho4w1P2vLnKww307ARojkGkn62MekDjIogzl5QpAkac25QQsqTV/FKY7MdTkJ222enIEB1YJLIxpD3Z4N7krnEMsIvyaQBDv/LFvIu38RQSJBZQcCBhVxdpkxQlEynPiC6i0Ub4+VxJ3HK95qY=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV1PR04MB10330.eurprd04.prod.outlook.com (2603:10a6:150:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 04:49:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 04:49:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHawIiZBQsZ0s8620ykCNsfnd2JyLHNMuWAgAm9QpCACrVJgIAWBn9wgAYAwyA=
Date: Fri, 19 Jul 2024 04:49:13 +0000
Message-ID:
 <AM9PR04MB860407B8EEB86B3E7DD1E12695AD2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-4-a7d28dea5c4a@nxp.com>
 <ZnFF_Z48qzpNvPtj@pengutronix.de>
 <AM9PR04MB860446165A0826362E7AF58195D32@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZoJtC-fgyVWQO57C@pengutronix.de>
 <AM9PR04MB86044449C38D1EDBF308491695A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB86044449C38D1EDBF308491695A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|GV1PR04MB10330:EE_
x-ms-office365-filtering-correlation-id: b2d7903a-5502-4b7e-5326-08dca7ae237f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P0TA46aGgRW7mbv2iavMqc2WDKqB+czyzBu9T3wXImlX4n9FUyKops6fYk5p?=
 =?us-ascii?Q?uJIwgXz2d2xrsxUJv4s74dcqKpNOt0c34lY0zAP+7FFWodEUm6pDK8LP/kJz?=
 =?us-ascii?Q?J9+fBLUZmrWlwVBho7gNxv/1+pI7u1C+oMDzYhc/s0OO2Sc6uSLJKcuFe0HD?=
 =?us-ascii?Q?8URDPqknZvNkNUOGkjfkja5VBTZYwioIRsQilixnIF02RqRFxkROZWSIuBxb?=
 =?us-ascii?Q?7VE3zEYTaup7GtHF7bY19UPale08mdYczCTyParZi6yRrykgizf5avWi8vuA?=
 =?us-ascii?Q?OEuC3/jD90+6fcXFDDd+Zbkx01vlwxT/d6mRdvL4IYHnk/NVrzRiqpc0QetJ?=
 =?us-ascii?Q?9uoroV3mB03rgHuW3fgbIrmiT+mylSLgBRVFfCab16/RK+Mmn9fv26vm0wAz?=
 =?us-ascii?Q?8rjUrJhz3Czv8H+4Ax5CC/d1bFVUS1Vo+hJHlHnq2WRsNkEbqrCbP7Fhv9R2?=
 =?us-ascii?Q?shL+Oh79G3czTn44wXY3aBMm01zdrR3sJQfHuaCfmcVyQfF3XzJkQI00Tk8S?=
 =?us-ascii?Q?cZ2ORzMrMI9v/R90j9x888xSl9MgH/dGt62Em9djUo+03y2/lBpig4/4278S?=
 =?us-ascii?Q?2wbh4GRWiMvW5AbNrIwz0HhcrwUZNr54r3rp7Fm1FAcQ6bpGq2KrzcSivsnr?=
 =?us-ascii?Q?vl/KiXfY07k6z0ZiHDyDHhNmp0MPoCMmH3Lj1iiHBuiPrc2QSjkokCcJSuB8?=
 =?us-ascii?Q?bpxY/iBkIxqrB5aFivfx4lCFj250vsMS27t0mzDi0XuhVQ1XBPI//VqWbPBp?=
 =?us-ascii?Q?PeHoSkvR0fIuwNV8TjHUA/0yQBXMYPE1eMgAe4mor9knQJ9NrUXnyqLqujGV?=
 =?us-ascii?Q?CrjAqEriE9+d0d/8O+rP+Kzfhx4MjGe1oqgvcRqGta1RamZZaw9+hT+R5/gg?=
 =?us-ascii?Q?WxPR8if4GUnfEZDIWAD6uMzS1wuw1bNJmm96vRuV4JldplNigmTNyor+CWij?=
 =?us-ascii?Q?2BO3VmfkRUL3HZ5XUIpKpyaU/DjmPw6r6UIoPs6tt1P6WKQDtAz9sIh0K9u5?=
 =?us-ascii?Q?NqebupI7at2Emouwir4m/8lrFk/K05k//R0eW0+S8tbG3Wr4cH/SNQ938klG?=
 =?us-ascii?Q?8xex4yxYbUAgHDE6cELUgYC+WJq5pml+6Nbe3kVwbgZuAht8K3n8YLceN9rr?=
 =?us-ascii?Q?HfVCgss8xY4pxB8D9kce+EUaXXzXQkycEL/TjhptW/xFVtcDK/SHcJZJRLxY?=
 =?us-ascii?Q?Ih/D5CVsJlEoNc4WjHqMYMiCwnyYDq5ZJaLdk3cAa5IeZiHVvHgd2XPezwoa?=
 =?us-ascii?Q?G4VG9ty3b0tHZE0rCUeVw/03jElWAbdySVlHD8oItbDOdKhOLDqPDFtNyuCR?=
 =?us-ascii?Q?5Wk6NfXWg2TnLTYvT+u9okwfjCcbU09oYY8qmkI198UPdelxQ12MjZHe4HRP?=
 =?us-ascii?Q?wwZzAHcPeraIhtsIXnlf+krzBWXgRpVhg/RiJE7i/yNJRZTHuA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pcZo98bB03Spqhe/Sn3LYAgvwei2L6RUj4RPT2NxQpHggDH3Mz6J2arQz+82?=
 =?us-ascii?Q?2Rcz0Mwolt1EhriV3lf+HOgqhc3bChha8gScGu0CLXEuhy6Gn5j1+UMTuWO3?=
 =?us-ascii?Q?+mJYa/3311Eip4DwUidXq6bCepyj3vYxKSt4ygbrLz0dAEm7FK9XIHZLlefR?=
 =?us-ascii?Q?aJFyb53ByVdFT31+HkkgANidcBxEKgAZb9A9nfXBHEkWv95QsdXbQ/yGJ9ib?=
 =?us-ascii?Q?G37ItlMLIFCuQ2LRkaAZfdMsmnr3Nrdyimb1SJqFGM5FH8J3MePugTHZqX/t?=
 =?us-ascii?Q?WgJMvxnfl/zAkA84gq8lUhaKXL7epUaV93e/Y2VVC24awO/wsQTp8cqjS97y?=
 =?us-ascii?Q?hEHZt7pPrKOKka/lgwgi80aGm8Kek/524Lq01e7ag/jen1aChiRnmAuCjXw5?=
 =?us-ascii?Q?FOJpDSWx6JKqq/8SGQqIHho4JpS542UXm0UdE2ATHhU5ah8PNuW1s1gXIgcU?=
 =?us-ascii?Q?GzVAskUOAv6zHMc7OJd1jqfSeFWdfQ/O16hZMOoC7L4Nwd/omi6fJL6rZkxh?=
 =?us-ascii?Q?4aJP5fMKkBMrXl1TakjPtMNiMOd3d9jy75KuOtIJoYelPVqNZLRmXaiPjT+7?=
 =?us-ascii?Q?MsK5kudx+yKAtC0x2U4iM9JY/Un8MBujkHtHQLlXketjh181a2Fga2oIcC9x?=
 =?us-ascii?Q?cp+bMuOZMIi4iyTwmfRIhpiYuTosgzRqTxak6iAc199YoyyfxXT7oESAC+lD?=
 =?us-ascii?Q?u0bgMHcZfYPlyNqdsGZDt1+d4DzszksV+nZkjjplSIEmESKH9bdESQ+PudSN?=
 =?us-ascii?Q?BZmOslOlMekvh1vPAV34hYZoxpI8P/QnZhWtQ0pg7tWDvr7h5y4n5dACv5za?=
 =?us-ascii?Q?FFd5hBSvdMvJoRjl3IxopAcpH1hDIr8EXehMLZvTD8es5SBTVwRK0WEn2ED5?=
 =?us-ascii?Q?IlGHhSb4jGqp8H82dtp95RV60DG/kzQE7MPXOS5jEakHW2fGfqkb2/AmBs2P?=
 =?us-ascii?Q?bt/IwYkUNcB0qX021QZvL3bIuVoY5IT6dFLhyhQYv1dFVGuFaT7FL+dghFe+?=
 =?us-ascii?Q?MRwfu+doeJWo6V6hMOibAqU++BGmzhzMqMBGsSO50Sk68T9ysYWxZ0ts7GrY?=
 =?us-ascii?Q?lBSGh6vzoutcNQgTrlCk24xQzDO/YkJFXXcY999CYzvx/slDblvSQcyzPgVw?=
 =?us-ascii?Q?0jiz78vgXNOYjW7l7dhI0QB/qpMxSPj90jAuCp4PGmn2/n9xIv3o6supQHEQ?=
 =?us-ascii?Q?KBFebnDLghja8oNWDoz705UPh8f+TlneWmxa3ac7m/T60J7zAbT56ptdemTh?=
 =?us-ascii?Q?Oq6FkjdBO1fLeR/d6pwe1KcjdB1OZ585+lCqFeTKx+XrAyMMUln2ddDl0MnA?=
 =?us-ascii?Q?G995QjwqcEW9qtV4k+TjumfWmpBNIKLubnV3mFNTHEJM1laBCboNrnqE+NDA?=
 =?us-ascii?Q?IdENR5dpI3ut+3FLYmDztLgaowceODXVJMwfD1bhckH3mCEkX1mubZAzHtR1?=
 =?us-ascii?Q?ypbqGpzeydI2vNX6Y0lQDcy0z+87cM1jnNpR7+egZQTpJP7aO0PjHQoKWiCu?=
 =?us-ascii?Q?DT1nlH5dZsjFKnNtnM4rd8EMo+o9jLZBgDModZ1QH/5bRx8R+y52Z8mTTdux?=
 =?us-ascii?Q?9i1d1HbcFKjY1OxCpTH3qrBtyjgCiKtNZ3exTaVT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d7903a-5502-4b7e-5326-08dca7ae237f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 04:49:14.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNqz9SkzZfqBuLplXFi2P80hFjj/ebBu+68ZYtUpJDnGMRv5RbbCjaYQlnNiIP3cFCWLLQDeCo3GoxLSFkcgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10330



> -----Original Message-----
> From: Pankaj Gupta
> Sent: Monday, July 15, 2024 2:49 PM
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org=
;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-doc@vger.kernel.org
> Subject: RE: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
> EdgeLock Enclave
>=20
>=20
>=20
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Monday, July 1, 2024 2:17 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
> > devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > linux-doc@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for
> > NXP EdgeLock Enclave
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Mon, Jul 01, 2024 at 07:45:20AM +0000, Pankaj Gupta wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Sent: Tuesday, June 18, 2024 2:02 PM
> > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> > > > Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > > > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > > <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > > > Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
> > > > devicetree@vger.kernel.org; imx@lists.linux.dev;
> > > > linux-kernel@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; linux-doc@vger.kernel.org
> > > > Subject: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for
> > > > NXP EdgeLock Enclave
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > Hi Pankaj,
> > > >
> > > > Here's some review feedback. I think it'll take some more rounds
> > > > to get this into shape.
> > > >
> > > > On Mon, Jun 17, 2024 at 12:59:42PM +0530, Pankaj Gupta wrote:
> > > > > NXP hardware IP(s) for secure-enclaves like Edgelock
> > > > > Enclave(ELE), are embedded in the SoC to support the features
> > > > > like HSM, SHE & V2X, using message based communication interface.
> > > > >
> > > > > The secure enclave FW communicates on a dedicated messaging
> > > > > unit(MU) based interface(s) with application core, where kernel
> > > > > is
> > running.
> > > > > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> > > > >
> > > > > This patch adds the driver for communication interface to
> > > > > secure-enclave, for exchanging messages with NXP secure enclave
> > > > > HW
> > > > > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by
> > > > > kernel management layers like
> > > > > - DM-Crypt.
> > > > >
> > > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > ---
> > > > >  drivers/firmware/imx/Kconfig        |  12 +
> > > > >  drivers/firmware/imx/Makefile       |   2 +
> > > > >  drivers/firmware/imx/ele_base_msg.c | 284 +++++++++++++++++++
> > > > > drivers/firmware/imx/ele_base_msg.h |  90 ++++++
> > > > >  drivers/firmware/imx/ele_common.c   | 233 ++++++++++++++++
> > > > >  drivers/firmware/imx/ele_common.h   |  45 +++
> > > > >  drivers/firmware/imx/se_ctrl.c      | 536
> > > > ++++++++++++++++++++++++++++++++++++
> > > > >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> > > > >  include/linux/firmware/imx/se_api.h |  14 +
> > > > >  9 files changed, 1315 insertions(+)
> > > > >
> > > > > diff --git a/drivers/firmware/imx/Kconfig
> > > > > b/drivers/firmware/imx/Kconfig index 183613f82a11..56bdca9bd917
> > > > > 100644
> > > > > --- a/drivers/firmware/imx/Kconfig
> > > > > +++ b/drivers/firmware/imx/Kconfig
> > > > > @@ -22,3 +22,15 @@ config IMX_SCU
> > > > >
> > > > >         This driver manages the IPC interface between host CPU an=
d the
> > > > >         SCU firmware running on M4.
> > > > > +
> > > > > +config IMX_SEC_ENCLAVE
> > > > > +     tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave
> > > > > +Firmware
> > > > driver."
> > > > > +     depends on IMX_MBOX && ARCH_MXC && ARM64
> > > > > +     default m if ARCH_MXC
> > > > > +
> > > > > +     help
> > > > > +       It is possible to use APIs exposed by the iMX Secure
> > > > > + Enclave HW IP
> > > > called:
> > > > > +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > > > > +          like base, HSM, V2X & SHE using the SAB protocol via
> > > > > + the shared
> > > > Messaging
> > > > > +          Unit. This driver exposes these interfaces via a set o=
f file
> descriptors
> > > > > +          allowing to configure shared memory, send and receive
> messages.
> > > > > diff --git a/drivers/firmware/imx/Makefile
> > > > > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > > > > 100644
> > > > > --- a/drivers/firmware/imx/Makefile
> > > > > +++ b/drivers/firmware/imx/Makefile
> > > > > @@ -1,3 +1,5 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >  obj-$(CONFIG_IMX_DSP)                +=3D imx-dsp.o
> > > > >  obj-$(CONFIG_IMX_SCU)                +=3D imx-scu.o misc.o imx-s=
cu-irq.o
> rm.o
> > > > imx-scu-soc.o
> > > > > +sec_enclave-objs             =3D se_ctrl.o ele_common.o ele_base=
_msg.o
> > > > > +obj-${CONFIG_IMX_SEC_ENCLAVE}        +=3D sec_enclave.o
> > > > > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > > > > b/drivers/firmware/imx/ele_base_msg.c
> > > > > new file mode 100644
> > > > > index 000000000000..5bfd9c7e3f7e
> > > > > --- /dev/null
> > > > > +++ b/drivers/firmware/imx/ele_base_msg.c
> > > > > @@ -0,0 +1,284 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright 2024 NXP
> > > > > + */
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/completion.h>
> > > > > +#include <linux/dma-mapping.h>
> > > > > +
> > > > > +#include "ele_base_msg.h"
> > > > > +#include "ele_common.h"
> > > > > +
> > > > > +int ele_get_info(struct device *dev, struct ele_dev_info
> > > > > +*s_info) {
> > > >
> > > > I think all currently exported functions should take a struct
> > > > se_if_priv
> > > > * as context pointer.
> > > > I can't find any place in which any of these functions is called
> > > > differently than with priv->dev.
> > >
> > > All the API(s) that construct a message to be exchanged over the
> > > device-interface to FW,
> > > - will be the exported symbols in the next patch-set, to be used by
> > > other
> > Linux kernel modules like: NVMEM driver, linux crypto framework,
> > security/keys etc.
> > > - These other Linux layers have to choose from multiple similar
> > > devices per
> > secure-enclave.
> > >
> > > Kindly Consider these API(s), to be the EXPORT SYMBOLS, in later
> > > patches,
> > when used outside of this driver.
> >
> > In that case you could still add a function which translates a struct
> > device * into a struct se_if_priv *.
> >
> > > >
> > > > > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >
> > This function should also include some sanity checks. It's not good
> > that an exported function takes some struct device *, blindly assumes
> > that it is of type se_if_priv, and if not just crashes the Kernel.
>=20
> Will add a wrapper function over "struct se_if_priv *priv =3D
> dev_get_drvdata(dev);", to add some safety checks.
> Will fix this in V6.
>=20

Will add for NULL check for priv data, as a sanity check.

> >
> > > > > +static int imx_fetch_se_soc_info(struct se_if_priv *priv,
> > > > > +                              const struct
> > > > > +imx_se_node_info_list
> > > > > +*info_list) {
> > > > > +     const struct imx_se_node_info *info;
> > > > > +     struct soc_device_attribute *attr;
> > > > > +     struct soc_device *sdev;
> > > > > +     u64 serial_num;
> > > > > +     u16 soc_rev;
> > > > > +     int err =3D 0;
> > > > > +
> > > > > +     info =3D priv->info;
> > > > > +
> > > > > +     /* This function should be called once.
> > > > > +      * Check if the soc_rev is zero to continue.
> > > > > +      */
> > > > > +     if (priv->soc_rev)
> > > > > +             return err;
> > > >
> > > > Just return 0 here. It takes one step less to understand what this =
is about.
> > > Replacing "err" with "ret", in better understanding.
> >
> > What I meant that you should return the constant '0' here instead of
> > the content of a variable. It safes a reader from looking up the value
> > of the variable which means it's one step less for the brain to underst=
and the
> code.
> >
> > > > > +
> > > > > +     if (info->se_fetch_soc_info) {
> > > > > +             err =3D info->se_fetch_soc_info(priv->dev, &soc_rev=
,
> &serial_num);
> > > > > +             if (err < 0) {
> > > > > +                     dev_err(priv->dev, "Failed to fetch SoC Inf=
o.");
> > > > > +                     return err;
> > > > > +             }
> > > > > +     } else {
> > > > > +             dev_err(priv->dev, "Failed to fetch SoC revision.")=
;
> > > > > +             if (info->soc_register)
> > > > > +                     dev_err(priv->dev, "Failed to do SoC regist=
ration.");
> > > > > +             err =3D -EINVAL;
> > > > > +             return err;
> > > > > +     }
> > > >
> > > > i.MX93 doesn't have a info->se_fetch_soc_info. Does this mean it
> > > > doesn't work on this SoC?
> > > >
> > > Yes.
> >
> > Will you fix this?
> For i.MX93, SoC registration is not done through this driver.
> This is implemented as this only. Nothing to be fixed.
>=20
> >
> > > > > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > > +     if (!priv) {
> > > > > +             ret =3D -ENOMEM;
> > > > > +             goto exit;
> > > > > +     }
> > > > > +
> > > > > +     dev_set_drvdata(dev, priv);
> > > > > +
> > > > > +     /* Mailbox client configuration */
> > > > > +     priv->se_mb_cl.dev              =3D dev;
> > > > > +     priv->se_mb_cl.tx_block         =3D false;
> > > > > +     priv->se_mb_cl.knows_txdone     =3D true;
> > > > > +     priv->se_mb_cl.rx_callback      =3D se_if_rx_callback;
> > > > > +
> > > > > +     ret =3D se_if_request_channel(dev, &priv->tx_chan,
> > > > > +                     &priv->se_mb_cl, info->mbox_tx_name);
> > > > > +     if (ret)
> > > > > +             goto exit;
> > > > > +
> > > > > +     ret =3D se_if_request_channel(dev, &priv->rx_chan,
> > > > > +                     &priv->se_mb_cl, info->mbox_rx_name);
> > > > > +     if (ret)
> > > > > +             goto exit;
> > > > > +
> > > > > +     priv->dev =3D dev;
> > > > > +     priv->info =3D info;
> > > > > +
> > > > > +     mutex_init(&priv->se_if_lock);
> > > > > +     mutex_init(&priv->se_if_cmd_lock);
> > > > > +
> > > > > +     priv->cmd_receiver_dev =3D NULL;
> > > > > +     priv->waiting_rsp_dev =3D NULL;
> > > >
> > > > These are NULL already.
> > > For code readability, it is good to know when and with what value it
> > > is
> > initialized.
> > > It will help review the 'if' condition based on these structure
> > > member
> > variable.
> > > Will covert this information into comments.
> >
> > We already know they are NULL because you used kzalloc to allocate the
> > struct. No need to comment that.
> >
> > Sascha
> >
> > --
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       |
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> >
> pengutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cc8b7
> >
> b605e99744ccf94e08dc99aa66f0%7C686ea1d3bc2b4c6fa92cd99c5c30163
> >
> 5%7C0%7C0%7C638554204358183687%7CUnknown%7CTWFpbGZsb3d8e
> >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> >
> D%7C0%7C%7C%7C&sdata=3DNl8R%2FcwuT69VVUxe00AichgoSEEJexZ0TfhjfuI
> > BqoY%3D&reserved=3D0  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

