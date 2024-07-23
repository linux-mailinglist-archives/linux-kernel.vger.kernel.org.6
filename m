Return-Path: <linux-kernel+bounces-259834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248F939DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244401F230E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015A14F9D4;
	Tue, 23 Jul 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sfMg5s3i"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013037.outbound.protection.outlook.com [52.101.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F414D2BD;
	Tue, 23 Jul 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726918; cv=fail; b=LZWj5bdMMpvPb51jlnSiCA546w+2jUDYp3cF4396iXysi0O2urogkZuWNrV3W/PlP31SsvXSQruSm8zDIDnhLjYoE36utNSvXtABhzYNaFwFrN5184flA78arh9I0KokMOCVeRMw4EJAT1rXpig8cmkDSiRLa/Hr66ACQ7P8wSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726918; c=relaxed/simple;
	bh=kthBrDMTM8K6nezWm5f1E1RFA9R71ZkSDbCXa5kLW88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqiKkjFWzCGMYkPHk/u79EJseZ7Rz6YMPCZ28QCu5OSkpxXiEuTShdC8OmWdugW0m8/UnnhEg1Uwh7c3yqlS5CJGnfuMKbaVmbJFK8aGgQuWEV9K6e8sz6onjvm9REoZZVc7iqgda0j29Z2TdISYvekCoYcjPKhZjDJI8XvfBgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sfMg5s3i; arc=fail smtp.client-ip=52.101.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdxsrtGqQukWdGOwqGr6+mYBPa7Xsxx8Iy6mEjtYdn5yK7HvSsSHGWjjfXCtClL7o0iQw1J+ocIg0ZBH86t3CoHROfvvkq1L8+++JEwF0COnYJlWXp1Mv4ov8+O6ZEiFCfG0UqC+eFAGLTCZE/hl4wJxvpvvg5ASRoUqCbyxs6NkQUdRIFvkBfSFyx8K25fvPJv7TUwrNEvWnxRVOyCPN6XDdTJWdNDJMETQQaD7kTOQRKNDqiv1lz3rVIxCzdKZ0JgosubrrxMXcgtduNp348hCySkDZ4r2kakY/LhnLh8dyYNdpGrGnxh5B0OUbcEJD3Ms/G5PqrVM5mKC4Q3CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuLl15g+XEgQ+ME4GMKG/i3xXuZDakhkMjXnhWANj1U=;
 b=i89YsCdnkrJklEW1ukM8zkQqAZcFStyGCjz3DtVN6/yk3i1/qdo0kqjUt8aPqCK+rA3nq2oXJFx2iRcIrIjP1oPnOiMS1XMXsebh5k+gRVWt3ahF7C51FHJ9yK8pa/tZ8ASgUebSc5Y8JICoNKavBzgvmPsTfhikpnYvO/7YbskGipp3HSNnR5jNZF58MUTbbT7X/s6KeCEKcNQ7fSd0FWA82T1IcXJ+8yNHQomBf4mGhfEIanE4LXPoU/AvHhBmTciqIU/hnEgAcJaYaYvOnXEh2maos6SinKDBJD1BDG8AulZ4T7rGu3oEMiJ9gMewqJd7FHE1Mm1cvfoPNY/8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuLl15g+XEgQ+ME4GMKG/i3xXuZDakhkMjXnhWANj1U=;
 b=sfMg5s3i6UPPZe87VmsTyIFtBKLuJVF5gcjcz/hy7YbcXEtyL+n0Mz8P+v5lOUo/9lyn/Pi0JfBkcECyWo7DdKv7YX/9C9SsHDydN4uw12qLnQbJIsBb7z6p7kOXj07w9kKD6xdQWGW+eIO6+v/+a4YxpMxPU0A/avaeFNCTyZk=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV1PR04MB10331.eurprd04.prod.outlook.com (2603:10a6:150:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 09:28:32 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 09:28:31 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHa2/NU1sJztJxAoEWO7LSlO6AOebIC9paAgADLMzA=
Date: Tue, 23 Jul 2024 09:28:31 +0000
Message-ID:
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
In-Reply-To: <20240722-popper-comfort-7538ea70c77b@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|GV1PR04MB10331:EE_
x-ms-office365-filtering-correlation-id: d9cb037c-f2e4-4d9a-7761-08dcaaf9d194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ChHK+BzS9hFM8v1hikdNjjHytwq66oIsLkHAmwmMLV2v3Ep+oYXIlhADaKVE?=
 =?us-ascii?Q?rAJO8NezGzvC/6HZcRrtPi3vzP6hdGIRwainkdCL462xceurFX0/kaxQ/xca?=
 =?us-ascii?Q?ro1fBOu8UOLYsVuq5zxZugQH1pdF9d+OcjHCKZNUFE6Oz+RYS1w9obKmNAsi?=
 =?us-ascii?Q?ATgv1cB7cP3Oc1r5l5nQY9im5EpPYYC37VOcMDxY+pdXrg1ZhDhHbOfVd1ya?=
 =?us-ascii?Q?YKdGgA8St546mBbU7QSp0quVP83m5D2E0vfu2UEYshM0XN4hLqQkieASJpU5?=
 =?us-ascii?Q?ieHB7cqw464bu84/2PGrgnsa+fPOUr7jVNK48nRg86ZOtPtKtTZmYMDNkC4w?=
 =?us-ascii?Q?mjcLVEfXhTx9m6/vnFl9i8Rpy4eH9CQA91qaF0sOaVKNZoHLvKFq7gW7hVTa?=
 =?us-ascii?Q?V4vzV8VGtozeOtD1fqU0ASLK65d7hy/UvEzsdOa+po6xIhC+VZZeGukO7qmt?=
 =?us-ascii?Q?ktgTDgh64v2OIUrVBwunlRwaXgt7zey9vTEloswNvp8maTs5SLZ66GCPtmNk?=
 =?us-ascii?Q?Bc6I7abZFJRgx+PtJGPtz1rl0G2NwcUjcrEoz1Ar1gzd/CYhC1hftSfSpIBB?=
 =?us-ascii?Q?E9pM2+xkXjiNHgeH5fHMnZPdNAGKoY9ANk30eXkZ6ywWWldbTxhPeb/y95cB?=
 =?us-ascii?Q?baLNGr+lbvZnTVJWm4I7Qn15vcLto+0pn+GYKJjuvhku+Dp2eCSr8BWOKsAL?=
 =?us-ascii?Q?lZaJp7L8qfAxB35tdCeLGPqZ8Ze9aiT/OoQOIOidvXlYS2h7wzJ2jkvckkZs?=
 =?us-ascii?Q?q9Ax7MZrqrCABRZbvvNhQUzzJb/CmjtYQtCLJ901blC82qkj9JhDAAoP9EnM?=
 =?us-ascii?Q?aRvLm9APg9RBKVjPZD97gflQ6eL7RIe/a6LW0Uyx8MyfDcJRsqVsZyw//D6J?=
 =?us-ascii?Q?2yelQuueFPmOM8O9j9PNCn/5XfYX7I2dK0k+XGVVzRhFxjaZEtngisKoVzAo?=
 =?us-ascii?Q?cLtnWAe9jj8aJIJRLMO6zwIjx7W1TrbHEaw/y1VuDDhQAwMVDFCHJ1rqFzQN?=
 =?us-ascii?Q?IRTXdw61e2C7s3KonPBQBynKEaWWGublAvf6FNsGH5+nvwJs3KALb1zClDNo?=
 =?us-ascii?Q?7CNIzu6GZp/5yb01nvVnxheW3mmJZmL6Fx01JIAOfkMzxbMPIl/VIiYpFfGH?=
 =?us-ascii?Q?nJXM8wDn1vjZcSGB1msdsJ8a3HLQx5yn/s9Q5jh8Ah4Y5BLpqGAZXTveyoDO?=
 =?us-ascii?Q?cu4Mm894251vyfsM2rBCM0IWWCYDsXK/l9IzqmwCX7iCKI7KA96Dhx4oTsMn?=
 =?us-ascii?Q?5FKI5nKGwSPefiwVCsFXwmABJJ7EPmDlX1/eK+mt85432GR9bIsWnsDAGYh+?=
 =?us-ascii?Q?SRl885ynXd9Rh+p+cisgGymFr0+PN+7bnMvCoh/gECGUAoYhpU+gu0pxcIry?=
 =?us-ascii?Q?6B4KshY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SQbPyLyhYfG2KMMjwm3LI8BRjcE08g63jvvsVEQIYOQ3rKQoxeGxyKJ7fJDC?=
 =?us-ascii?Q?s/ChElmZKSGxTp7BwTOzmXPk7h5JL0effjK16dv5yUvobEle6XrDPN1e3WOX?=
 =?us-ascii?Q?7/fIa8/THHpX58UJezx9oYQdh7QjxoMEm2bePN/vOHO3HCIx3TL0F2scH//r?=
 =?us-ascii?Q?bkGmL39tYFco3DqXWpkl18JAJEf9E0iWwX07OTjeljk5g4Lbf/b+5WclaaBX?=
 =?us-ascii?Q?vYwPi0KS6I5svMkRcsGxcSrkvtnKPp1/weK4KkS0bpGcIscbDBoFxp0axVfw?=
 =?us-ascii?Q?7u7NfPk/6Un/ETG1kc9NQDEfWMWrIMXg0AgIQr32ER9bHPz63Vw/saC1vxuV?=
 =?us-ascii?Q?0W3eYj2JDLTtXI/5xvwb4mS3OwiRULAXnLgUNCtBo3qdTCSC65dtuzoEk0OK?=
 =?us-ascii?Q?EGnxkfB03sHudDILbUYcKfNQRCjHzKa305cXqWOkGEOewESjSDrUfUmCCGK8?=
 =?us-ascii?Q?gc4oQX5IyAgH32y05DNmqz04850C3EK7Xfhewmb7l1sIsyFxyP8mncL7WD16?=
 =?us-ascii?Q?9gC8btZqbArUSRjdTvLfZgTmYpOk3brq9+eQGO4nPeOIW/9MSr7tx6IsoLSW?=
 =?us-ascii?Q?kxxo2wEvdr+cH03MpFje3FjbMuk9cXcfneib665zAeUbic/yeh7Aj2GbuTw5?=
 =?us-ascii?Q?59n8Zwb0xJ1Z93tDomY+ZK0A/IWQX4aMCUCml2Pp/iqZtwvXDSUrqO6qRc/z?=
 =?us-ascii?Q?ZFHVF9FivJzxuj8X9yDW5AGe+JOuVTcKbhPf35SQr2cYoKclSMeMmMJc9Z/w?=
 =?us-ascii?Q?MK8yufb/pUqitY/Uc4x+MNQbNv/P+1CWDz96mzI6iAGigmyLw6LN3Q3W1OJm?=
 =?us-ascii?Q?SH11SA/ciwvu1PqnuVMQAG10KTcQqBSZvrgfrtVgw057LUH/JOiKSejX0m8f?=
 =?us-ascii?Q?ZjEDd++7Gw5ERPhLs30szoMva0hOjhhIXoj++iJ7ctoJ3VHixxOe+LpsUYAy?=
 =?us-ascii?Q?yK6jR1wKjG3TbxD9Lx0Mrq9gKHHDCpqJnX6iavvp3aR4ZufOLsstCDIXmWy4?=
 =?us-ascii?Q?I4NNoHE+mwpBM22Hxgm56uHMZAEil1+BTDmZrWGIXinhCHNGYUi4Zi2ALq19?=
 =?us-ascii?Q?5ujKSECpHmopiHXu2aCzI+9MWiqwTq1Km2GjIcUVEyGE1zNJQq3EOoMW1HED?=
 =?us-ascii?Q?sLdUeSHE0SPMRl/MaXcwTNnLFuKzCFXVzC/9wYiV3HPYQSEANB/3WSPsN94X?=
 =?us-ascii?Q?QhiSa6blW6zTn33zA74MfepZbfQLDyFXUE5wGgGN8y/QxAadKAqff/7RofX6?=
 =?us-ascii?Q?DJQ50FgY6BbiYqD92Nvfa0eKyOBOvVD9tVXwbfxRC01E/Tk0kbrlqnQcGBkY?=
 =?us-ascii?Q?CyhhTP1u7UiKTu3Mt2B+ZDGbN/RLGen4hcn6siM3ydxzYs+cRDpjUqyNgkyj?=
 =?us-ascii?Q?as7ARu2UsenSiDsFWztKD35C+MN6M2GLMN/uiuC2fXfXcEPzvNvW4iqAgImo?=
 =?us-ascii?Q?2UNrpv2eMl0TvHUjqmW2GWjQMnrLZWdzKVHfwpgtxW96J/UU8W9AuOF6GN9d?=
 =?us-ascii?Q?i3kwjQfU6uOoSdvBSzZwg9d4aorab8M3hh7VQnclnh6UT/WU1xmVgy4v517y?=
 =?us-ascii?Q?cj8vgP/wDWTor3NmkR7C2AtLn4vUmcKMRZOF/ass?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cb037c-f2e4-4d9a-7761-08dcaaf9d194
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 09:28:31.9434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rb35SDQWzHCxFkTZs96HZrqLqz2us8Lbc9jgpyQURwFbrTanUYy/UZ6iJQNhL23pN1hn65VSpZnxzO0T+HXYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10331


> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, July 22, 2024 10:20 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw bi=
nding
> doc
>=20
> On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > creates an embedded secure enclave within the SoC boundary to enable
> > features like:
> > - HSM
> > - SHE
> > - V2X
> >
> > Secure-Enclave(s) communication interface are typically via message
> > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > communication ensuring well defined message sequence protocol between
> > Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications, to be able to communicate over single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91
> ++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > new file mode 100644
> > index 000000000000..7511d0e9cf98
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > +  enables features like
> > +    - Hardware Security Module (HSM),
> > +    - Security Hardware Extension (SHE), and
> > +    - Vehicular to Anything (V2X)
> > +
> > +  Communication interface to the secure-enclaves(se) is based on the
> > + messaging unit(s).
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-se
> > +      - fsl,imx93-se
> > +      - fsl,imx95-se
> > +
> > +  mboxes:
> > +    items:
> > +      - description: mailbox phandle to send message to se firmware
> > +      - description: mailbox phandle to receive message from se
> > + firmware
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +
> > +  sram:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - mbox-names
> > +
> > +allOf:
> > +  # memory-region
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +              - fsl,imx93-se
> > +    then:
> > +      required:
> > +        - memory-region
> > +    else:
> > +      properties:
> > +        memory-region: false
> > +
> > +  # sram
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +    then:
> > +      required:
> > +        - sram
> > +
> > +    else:
> > +      properties:
> > +        sram: false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    senclave-firmware {
>=20
> Last revision this was "firmware", but now you've got something that appe=
ars
> non-generic. Why did you change it?=20

In case you missed, there was a previous email requesting your view on this=
 change.
Having node as "firmware {", is very generic that has wide interpretation.
Hence, replaced firmware with "senclave-firmware".

Why "senclave"?
Like sram, for secure RAM, I proposed senclave for secure enclave.


Moreover, there are plenty of examples of YAML(s), that were already commit=
ted; that are using this:
linux_bkp$:> find Documentation/ -name "*.yaml" | xargs grep -r "\-firmware=
 {"

Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml:      zynqmp_=
firmware: zynqmp-firmware {
Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml:      zyn=
qmp_firmware: zynqmp-firmware {
Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml:    zy=
nqmp-firmware {
 And more...

If you any other suggested word to pre-fix , that narrows down this broad r=
eferenced word "firmware". Please suggest.
=09
> The normal differentiator for multiple
> nodes is -[0-9]*, why can't you use that, if you're worried about multipl=
e
> nodes?
Thanks Conor, for the suggestion this. Will use this. Thanks.

>=20
> > +      compatible =3D "fsl,imx95-se";
> > +      mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > +      mbox-names =3D "tx", "rx";
> > +    };
> > +...
> >
> > --
> > 2.34.1
> >

