Return-Path: <linux-kernel+bounces-233166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC991B31F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D963C1C21270
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35487EDC;
	Fri, 28 Jun 2024 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c+fFKJU2"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBC193;
	Fri, 28 Jun 2024 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533046; cv=fail; b=rVZADUkLoQQAVFegE73psVj9u04sAlBCBwJMJ5y3ufLZKu/FrtiZCLCAT4V4DDMuf5U8P+e8Zc+1HdiIfYFzihF+qKvtGa5h+XyYyjIZEfqi2z5fET0suIReo3z6b36tFl8AfRB0ev7lmV9in2x7Jh0/js0rbbag0cpNh6yJvMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533046; c=relaxed/simple;
	bh=preQlowhpKmqs1Q6Imet8LINVf+YCzNrbUuVfO1SNVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=se8UfJ8krJdqABG5S3WnkxmT36pj2lC52wfE/zLnF41w3ItMxVo3KSxvuAHfazyGelQIl5k5ps7QthzK5MGKiNbr9DaZsKEp8PpwhjJC9lAr69yOnr815WDQkE1YqKm4GblRT2Dn8r0H3dEyYBGSvIPVg7hTYYRK9JAqAr+bkxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c+fFKJU2; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzIeJ1F5PEE8OsIJrRuxLH4tfm6od3eV5ZmUA2wrSwtlwOMlzjzkVqKMK2Yhnrs5pEdNop3i+yiSdqIgc8bnfXnUOsP0wCUhsB0sqSStPUAv9UTS4hRPX/QENVfdyJxFKKlV73CJj8S+UzP3+vcOlw2zMbO1wryiSY3jDQfk6odKtV/PmCWeICXVy4z+wb8hDj1Q+Y8dJoQjJ6pzxmECgfgjWZ0wLRnYIwqUPfcyKh6/b4wP+mOKbBNn0hlWd52uAxhz3vIxj6DTFCFdOLjMhefntttG2NsL+ESELWRKZBVvMBTVToy+/83mDOx4qI5gC9eilLYC7AmrP/WItbiE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=preQlowhpKmqs1Q6Imet8LINVf+YCzNrbUuVfO1SNVQ=;
 b=Rrt3v9nkPznsxCGmct3GGX/g/m8Jbjh236HqI1Zq1xpVTSqTzO6SXVEDSQUxlzfs1NXnRv7wJIQzkfMWZwrrOcPZYYHDee/0bKXoDXFj5gkG+Rc9tNhzNGgB6LSJGsO3rAbWU6rUUH+fnL2kmZm/hJO+2TIDnqMrcjfm9qofUk9JPGLU+nia5tNaUwRy65x2P3ULhS9BE3Y7JrQzKnda1n0EJOqT/bUPwcZqFMLKdofkDLDNaPL7u+0/oB05+66K2TVL7kPsxft77l61rPuSxN+10whpzVFp5EQddt3KQlri26EJoRFYL5RS4RGsddwPpUc7fPVanwhxi3WhSLlpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=preQlowhpKmqs1Q6Imet8LINVf+YCzNrbUuVfO1SNVQ=;
 b=c+fFKJU2CvhEWI2wVgU560wX3C8SWd25dQEtexzqvCnQo8kPHn27l1eGd16kHzQBAytlDyI07JkVSJApOkROFxGMuegM1eHdP5KmaoZpnXjc5eIQ7uFSGuJi/PqSHRyUbIFs+flI5N7c7qQsGD/0QufVwbsgRqaxEM0Uisn0onc=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 00:04:01 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:04:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 4/7] arm64: dts: imx95: add flexspi node
Thread-Topic: [PATCH 4/7] arm64: dts: imx95: add flexspi node
Thread-Index: AQHayN2BZLOkH0Sv40qy4XYTaB9Jz7HcS4VQ
Date: Fri, 28 Jun 2024 00:04:01 +0000
Message-ID:
 <AM6PR04MB5941CBFC4834A88BDB8533EE88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-4-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-4-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBAPR04MB7237:EE_
x-ms-office365-filtering-correlation-id: e4c19041-9db8-4cdc-57bc-08dc9705d11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WB7DOieJheeoZc65UtoW0SeIsw41bO4wWf0vj31qrRGEJH0VIqpCZrQhKe83?=
 =?us-ascii?Q?8eonqZax+qG/W8sZ+/FYWDFicIZNTayqR+rNXzFcUUkBQfLXgUccu4qRurxN?=
 =?us-ascii?Q?ll4+40ca6+NG1iKV1KuBbfG+HGojdnu7nt3bTZq4GJSNXHMjPdOvaXq21r63?=
 =?us-ascii?Q?vUjgW6S5ZBlHBj0aUti+vipnHL87MY4SXWqZ5akcRBkxyrvHYnrYtXwaLliC?=
 =?us-ascii?Q?E8ruLyOyiD667moskWz4cDyJ+13BfwSsDiwiywtCYhl4/Kx57y59T7q4LYfl?=
 =?us-ascii?Q?Ym3G1ehoQtWoc7ev04egWMGjF4j2i5PPAV7XHvZj5kzxV4ySBlEl/Kb31F2q?=
 =?us-ascii?Q?Ns1Xr0bWp9cMR4e+CEwGYUFIECo2LzDSQiknGnoTdD2oFNIuoLl7QF1d5daL?=
 =?us-ascii?Q?jOZpXG0D6BKEFPe9hJn0DjYaxDEFvS8fie50vHN79rD/ts7rt/UEga//2yr5?=
 =?us-ascii?Q?c+iF/J4LNVSk4c+4tl9o82A3QEIL7B9FZUQZnHTGezzaVIJcbI5lxgcBua3C?=
 =?us-ascii?Q?/1G60B35NZ0GhqqL7SIo4Z5GnARDzRi9Nqsm8VyBBdAPlK8JiFevrYQTMasB?=
 =?us-ascii?Q?1ZLUJqJpKO+fS3ASBoVRITurfGiXSuyPDvcFxdoJiV2VIB7wcubT4wLswX27?=
 =?us-ascii?Q?Ri7ExfHC0AF2NZnZtiNhim0RgnCyiZrEz0mh5LJotkUt99pNXd+I/lbNkBI4?=
 =?us-ascii?Q?sr1oblerH5ZRVQKZXguYNMI/wMseREJRv9ca7YRLfEy5RDmamWVvYHaedpzE?=
 =?us-ascii?Q?snSA0MOSzlnMh0Hv4dn+SmEXzWk8d0a0UM0NlbvZ9bOyIhlTaHzlejQ7Zjni?=
 =?us-ascii?Q?3RcS4KVAs1Qjhko0CtdYEQ7vhFiN+QPotutjca0CmGIHugxNQBYvg9+x79Tv?=
 =?us-ascii?Q?xMjoT0/fH+bYC20SFxxYB2STpcpMLun3RvIRsCvM7X6gaUgb08oKW+fEbhJU?=
 =?us-ascii?Q?HKu/3UiVqRsmQh/HMx7L7xaFGPmvsPBTpxh73uNY8uY88Kq4+yZp7NLe1rpf?=
 =?us-ascii?Q?AoJmXdO9CN9ggTLc/jH5tqwQusx8L5SehAgzpnvHxZey9DjgK52aOfQxEfW0?=
 =?us-ascii?Q?JgId8fczD6sDMWnh4I+YDZ5XC9p8ZFYf2OuMnvpnzDUKrTn3aracPv2viMom?=
 =?us-ascii?Q?fqY8mR+ahhmS6UaVTFsNDahLvzKg7XqlE0dAv4Vpwb8ML9LEnyeEEquxzkk6?=
 =?us-ascii?Q?WJv3Be1Y4kcFX5Anx/9UcY2KcDNwOX95uCVycsIUnv14+5oFZUo7koMn5lfx?=
 =?us-ascii?Q?F66AUKj8dSlzQ2VKzyBy3sLWgxf9MM8+mg/03pMUVDw7Dhm7hGtnWC/jJkSj?=
 =?us-ascii?Q?YbmCVYCgE/ysUdF6J9A1o0jQ3IIxrQA9g4o+ZPiIMoowFJw1RrOpSl5XX/Ao?=
 =?us-ascii?Q?EbDn0z13cHq3lfhVepmO5x9v3X5okn4V42uMSRhy5c/J/aE0DCNoE9xqExew?=
 =?us-ascii?Q?1bFAGjd1oSs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ikvbRRS7DPHPByas8K8QIS0rTf8pnoKum7z5MKGuFjzCZV4N1O4ZNN9ATPOA?=
 =?us-ascii?Q?ahdMt92xVM5mgMU8JMdvlspJyhZTP+US7fC6prcqYtaRJJlmwks61IZgEuZP?=
 =?us-ascii?Q?LRndGUd/mIKbErwfVZtCk1i/ENAsHrvg2enckEGLzN4NF+X4a7nq177ynJVV?=
 =?us-ascii?Q?QT0QSLEs0j+RbDCe3Vmu5+BmV3eySVdLoElBop9HEYNjweg/4O3ZtLkYsawv?=
 =?us-ascii?Q?0dJKvzv1aS4zSTdzuQ0KKcT6ARquWa7r9qMg00Q3QVJUf43eYJ1++Mzc4ziT?=
 =?us-ascii?Q?biRgDiWTcsikIFKqom3lIIPRJvRqKgcbDGGrfdKMgHuqLVLDBx8oEzNOTq7h?=
 =?us-ascii?Q?DR+MzI6amk1Mk5kB53IyQkK3f9IJONA/vj/Y5hoM2DhRPtaBxVf1EjGpabqw?=
 =?us-ascii?Q?0tJo4b2RXr469AEzt6ghJGHoxGA2m20/hoUnPc5sbcIBpZgqT4Un73NlEDk2?=
 =?us-ascii?Q?HSQlbd9oC/+HQAxst/BukdAcqyPctFJJzaRarxY7B0sQc8Ln6CTM6xWOiCL6?=
 =?us-ascii?Q?2qFOryuWpDvqrEDaJCTth1hIIkrrNmHnDkv4FmyGOG0u1laCSgtA4CXMEPOQ?=
 =?us-ascii?Q?ndxMint6H7DFn9nxFAYQ9/SK31DSRzv4Md7+cNbu0TAprs+TLWG1+MctU1DW?=
 =?us-ascii?Q?U4xuk5Az9BE/XYwQXH+yRwcKSN7IUS+0Wl+GfI5ZAGhG/K9nev6o73CXum8s?=
 =?us-ascii?Q?KRuBAUMrserVsQ/umNpRo3t64xgKLd/GxDT0lhdZsWj4biBwW5X7mrwSXy4u?=
 =?us-ascii?Q?H64hIRb0T7Oh6ntcN6TP3A/fA+DdNSbiujbBNAm1mS+K8UDV9DM2rin1Lnv5?=
 =?us-ascii?Q?yaEHkzWzq4Uz8JM8ChonpYe7PU4yQqLkhL69fQrw/c8xWhTHw1XrAg0fx9vX?=
 =?us-ascii?Q?yOpKB6MnxNFfHmEFQ9WQoEJvZTPyCXP69lW0Arg2LCpfjmlapW1li7LfdPjl?=
 =?us-ascii?Q?MNV8IvN734++CxV8ywM9ifdKBnjhuKuQE4ZWEjVKkDofK2W0w48ISpfkj+ja?=
 =?us-ascii?Q?0/F1aPqVE7UCaR3hK0Dm5vLkg+HxGafTS7C+HUpOqChwJfO8l+1WWHnK+FxP?=
 =?us-ascii?Q?0KuDy39gCS2nEAcHikaIaUL/qymsnWXB/DQbB5ucgSLJQdSDQBbDqWxvXgEs?=
 =?us-ascii?Q?cQZe59BvOHOaqfAREzoD5P+n7yTvMh3ybO0R7phfdjga+7Pi7qrCxkx6WkhQ?=
 =?us-ascii?Q?7QiMcA0AjYWZaOmR2IloUSEHJkbbcUZTNGNYoFrhm3v9q1fSl8eG9MX8tOvA?=
 =?us-ascii?Q?YCYinh6qbCtqGUMbv2i/GhCcxDGnB1s9Ep8bJz61VDBGCYxd38ix9MECmd6Q?=
 =?us-ascii?Q?o8UDbM4hMktYCczw6ZcBg3XKxt0ZUhrf1VnmeEtKCp4XiXRI3Dpilu4qcNBn?=
 =?us-ascii?Q?+88MpQECy/2QkY2k7hBLj36WLKZ9bc/HQiML/eQWY8pLUxdTcWGFqrQEKtih?=
 =?us-ascii?Q?U3mup3fBTvYvmGugzKu3zJdo/wD+96SIhGK4trjg0yyLTfVx6qfs78+6lnZA?=
 =?us-ascii?Q?He1xPVASNaGAoQj5mJU0CjhQH5l7h1NAlk1CnYearNeqZzdkzi4hJ5eu7twu?=
 =?us-ascii?Q?aVeP/zizRmXEfV/OvjQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c19041-9db8-4cdc-57bc-08dc9705d11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:04:01.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nUZ9H8cCNdDzX23wZkjQaQM3QdrUUsqHOmat5DHGZH/QOpDWGVyY5p4qnkXtFnauDEEeW27itFULjSeAt2QPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

> Subject: [PATCH 4/7] arm64: dts: imx95: add flexspi node
>=20
> Add flexspi support.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

