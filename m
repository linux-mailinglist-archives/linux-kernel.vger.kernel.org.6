Return-Path: <linux-kernel+bounces-242230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC2392852F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7237B1C2515B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEB1474A7;
	Fri,  5 Jul 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJLVdpYu"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFB145B29
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172090; cv=fail; b=etUpC87KHbYiojhZ86vIOaPyH/rqwroW8GRERmQ67D4r4ON3rgFWdvEPmSOqIbBOsRKmRjSAAcPA0RKYh0rxUR5q0fGnreSf9CI/UxV4djOQafnW+M/zBwvM0ywlN5aRrRWoCk/Zn+NMJMg9yTapkCW7EpJxy31dv1vvHMjw6Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172090; c=relaxed/simple;
	bh=XLNlDCh/X+Wvb/4xCIRy4cHj01eQiSg4/XQdAnTwt0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=InrvZ8rfjwdvp4/JIWOK3LQ+D+TDBT9aw7QYjAkhGAQoFWEVzgGZ4R2OHljTrTPurBPHjlniqAUM4opLnSfbZkBISToOGeZtt6obvyHczEUdBQ13FSvj88snfBcCgCPl/0R6PXuiWOjMZQOCMeau5NKxoJ9zNp2Ev9EEf0shC1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fJLVdpYu; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1Q+xh0beC95O3ygh942vI9sHDDIOOmFsBOLq60NE61+9MbfZsPn8rkxqM2f/UjcTiTZpZwdUh+FZIJ8rMoGVuzYQasq3hJA9POquxrwBT1VNBBSGNI+eqNdROTHJgdUrkoqQqJUeqCjIYsAEiG6dVkSmkllfS3FQjiR0d0LHUhNLhqQeeaE1G1Lhd5rC7pxDjUImGVs6nngy3bpdatMPTzKKRuuxW30jM/emqVCtMdKPWG1/QuRg6av2jLJu9199hB3jRp9sgp3QyZF5zLT+lfkvIrMpUS6v6zzdPOQAVFkWqKwvh3POKQ7RHYCHLHpZ/kBZLeqbvFQk6oGN4ZHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqpVgMHzt2K5NaVto7ZbjYKSmGprMB17iD2fLPfhvhA=;
 b=Zqnotm5cTdRJ2VWXFMv5FSPlHazxRRQDkTJvjTuLeEtE+VwlITWoBtU/SS2nm9JrYZhFzySTq/IFS8UTTDzmwmT3JtP3u00hpXXYJ2OmTnl6vncUxUs6+uS/y1BB9NwLOYM9DZQ+Iv4EhCxcbZTgn62Im0/AETJWETUhgO6ZS89aecRv31STAMAGx19xBb5AaYjHrSFQv6FrQqDA9cLqpRYFP7igLhw1sd5tC9Rm8JjCDKwYEb2Nlg6HKFSftxSgTzxfd71RkA/MUd2zhy58e2K4l1QKg3zbpvOIw8ihrvGgQ6AokYdVtepfk7uGlU0mg1Q0t7X+I/T3g/CxxWJ8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpVgMHzt2K5NaVto7ZbjYKSmGprMB17iD2fLPfhvhA=;
 b=fJLVdpYuMYnmI3asrBmKAJHwv6jE2y5OWT3Jwk9aC+L3GXozkTx6i9kk3QmcporZiLQJym/QXJv36rEV16jEEich1r3UZiNeJnSCaUDAc0+JQzGl+ahwe/2SSmXscIL0Jo71hEfH2Vu7+BKYU6JZN6hppBtFP04bph1HjsvRYvA=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10663.eurprd04.prod.outlook.com (2603:10a6:800:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 09:34:44 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 09:34:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
Thread-Topic: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
Thread-Index: AQHara6pB5d0fDZleUSTT4bcpXDYYLHNyHvggBpY4dA=
Date: Fri, 5 Jul 2024 09:34:43 +0000
Message-ID:
 <AM6PR04MB594156E8588648AEA72698C488DF2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524075632.1009044-1-peng.fan@oss.nxp.com>
 <AM6PR04MB5941581D46DA309123EE528888CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM6PR04MB5941581D46DA309123EE528888CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI0PR04MB10663:EE_
x-ms-office365-filtering-correlation-id: c8e83eb9-8d38-4fc1-accf-08dc9cd5b3d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NVpe+eFynwTuEDRuhp0UJtmOhQq+6inmURRe1WL2EVSzvbpdH8PRhdqmvVMm?=
 =?us-ascii?Q?6KH9HxglyYV7sr/NptwaoCub1lBR+DEb9sGBwRSC1VKbOrwonVkCknoSbtSb?=
 =?us-ascii?Q?ODX/b62AW9bWn31Gda/oU0ALTAQltJ6LxJZH3hzkpT6oz1BiAXItSoBYaujY?=
 =?us-ascii?Q?9rdcUyC+4OJPAkzH1NEZtI9VV8LeB5OJg853TEDjLykTmHSp9tRbXbFoGhGT?=
 =?us-ascii?Q?FiZb0U1qFnp7xnLhEtXXOF0t4FReHg0oekNgeFiIWJCHn27LvT1d319x7VWj?=
 =?us-ascii?Q?vquWs4TiDnZ+i4Zj961jQtYJ9T/aigQgP7Ih66botB6TPhPB+g3fZwNAtGdJ?=
 =?us-ascii?Q?mIp5JRBjxJvtwY++phAqleydcy4ZUV68iUJSIpjobo6jjfVIvPkxPkVuB5PV?=
 =?us-ascii?Q?epxVai7CkTofSkV0xXrrmpGt7nQutM5Jspvb6mCSUojPJurKS2x4x8LyKCY7?=
 =?us-ascii?Q?NoXGk5chWOHvn5ufzUpMWrjrPjuM/N5g113sdscAxeJkjePkqn1+vDa4dHUZ?=
 =?us-ascii?Q?ZJo8GweHCZNYdNZrunh1pBCjQYdch6t+Fb8GEASusaJA9iq3Vw2lZB7EDUQN?=
 =?us-ascii?Q?dh+kIA0QyuiCW/lSBwIFfrurVO3w3vsjKkmw4UZXJnqjB2eqgrj9+VpqTuYE?=
 =?us-ascii?Q?b7BH+4qDLojxiJH3e0RGM6WOjRBbHb0yAMnIFDw/PDgiLf7stwMF9Ppwn2v+?=
 =?us-ascii?Q?9+59/Wlz7QaqAqplV7etPlAXkPqgpNG3Is6sRZ7d76/dn0aTNjwq7xRrN9H7?=
 =?us-ascii?Q?hRUQBB7CscwIe98A2QeqWwKZhgPSkWhVaBCwSaIs/xX4MnITO4Ju3WIW9mQa?=
 =?us-ascii?Q?6Csn4GSvbUvHzP10+DH57U00Il2til9GOpFuB6JLbwRZ2so01y66LxCEh//N?=
 =?us-ascii?Q?eGaAUHrURdPm7/oi98M6Av8aNqc0R7LyRVgS8H8VE8TuzpdnYrzSlIiSocj2?=
 =?us-ascii?Q?apEpxdW1aNxF2C8Be5Gd4hJBIGCnMTaClX/B9TOBmhnoNz9bh4HFImHLFeJc?=
 =?us-ascii?Q?3qII7A4uaXZc0fYvg3Jb7DVgYCkrbZ/SGVibH0XEFA8tY3eqEycp65QrfCPx?=
 =?us-ascii?Q?UgqObRuukweToMpZQNoU1++sSHxWtIcPrOq+ApUUxaQpqPkhbaHW4H+/a0d9?=
 =?us-ascii?Q?UlZvXrO6IWWQ0iXJaCtkvhg89C0Wu2kS+nFpw93x8OSMCDEgsg9nY+8JlNhp?=
 =?us-ascii?Q?kRAYBxcZsQzZWUi+iPL3Hfb6cm5WrrYXPYISOOX7oF+bLc91UeE+uEeWL9Qf?=
 =?us-ascii?Q?l/ds+jmiL13G22puXEYxJ/MDbr+AHOJlUURY3jg30iWkXmIwglxLkno8FJDw?=
 =?us-ascii?Q?zISNF6PJZN9vzHrB/JKrpB1O2+CPGJOP8cP3IvP0hm0TfpAv9DXBlQA7oqRK?=
 =?us-ascii?Q?ZsyfUuyBgFYEJEv2zygkTnazVZqvFv36zxplnc1KBbY6cH+i5g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KCEWchWf5pNsBY4xbslF83owBtE94RBnY+KmGtbYm/CMbkqWL3fEeMG+nDcD?=
 =?us-ascii?Q?0TH5gCh99+XtZnCUBfF5xLdIAWaaUeRA3t27HiLw2I6VCNwzd9yzBXBQH8O3?=
 =?us-ascii?Q?I4cKG+4JoC5IOjP4YY5s4I4AdKvrYp78MsRUIU7GTCc7d8QLqrMUBQpasLPI?=
 =?us-ascii?Q?QnRWZ+K4WlkJ2w2uU2Y4ndiG9by1XlHB7dCENEbW3fSZTAuLftAF6Y7LPIuq?=
 =?us-ascii?Q?QPyXxjCplWGX4IdnkWgLCIFrGcAhP0YVAxneC2o77wpR4rBp24YY56Z/g5SL?=
 =?us-ascii?Q?nBC58LcPsaB09QrDp9pE13kPk64mRwv0rVJbYdK4Hb3XZunL0NKwOJid/PXT?=
 =?us-ascii?Q?FOFE912NphGzatwYAoQbKYoUYoM3KFwPMHgH+k55sCY1IsBwf7QhIf0fdXBm?=
 =?us-ascii?Q?qFhUopfvLAgfvgPNEQFX55wdVVhoiRaJaMb44y9YiZAOCuxYo5pgmlyHW/uM?=
 =?us-ascii?Q?UkVmIXK5STfVyYnOQI4+dn4HBaArIBZs0LCkIJUxTPF70QbrrEx8el1mKvX7?=
 =?us-ascii?Q?mrd/5lxTFE2eZv0sawscSy3qCvsZrDK/ZBmMubIH19g1VrBdKciI/UQ0Nxar?=
 =?us-ascii?Q?OpTFfB98YIARscVAqGc3ms6/MQdAdM0ZRV2/pxpTBxRvowO256I6jTimkKOq?=
 =?us-ascii?Q?x6vOh4F+kFNsLiEtQ+7m1k4v1Y8Dq9KsaRvyvYqxUhR4D0DUjuDyWV62nfFt?=
 =?us-ascii?Q?q5/zlhRlPVzSHKgaZ56gv0lfGfZHAtyudRnV/BPqUF3QszmLmtqYac5XrDS3?=
 =?us-ascii?Q?EacilAMw2I2mMNSGgMoe0RK5jSb4zwVN/QzwM9/maD63R6LRNj7zxUVhOWjE?=
 =?us-ascii?Q?iZG8ugI6Wlwr07IvTEKrRyeTovmmXntOVRlY9M9ziCgI5PfNHCKqSDRtgYoE?=
 =?us-ascii?Q?yODcA5psv8w7ysrCvFJ7e8yEMkmgU+WeT6zWuhmP1+DBJsdrBlSEyhDVziiR?=
 =?us-ascii?Q?+1LDKghV7F27cRbTOXxEbhZnrAHmOOKrXqC0s/WXhYhaWeLxtf41Jns/wYFt?=
 =?us-ascii?Q?cBnL9oSqPWmNTog3fU+BoQ2qPbT5hT9omPVN69IRSfUWWI/LFUvQONtSnQEh?=
 =?us-ascii?Q?S4r4TmgiiwX79cNoDPCzB4r0hZm+No8sL1jzpW4/URxwlQkrUFXTbGz8+xXy?=
 =?us-ascii?Q?S55wJUvSb3bNukwjJUodR5QLl3Cxm4djxtkhhWGzimRS8t1Jf81PbKsR0YXQ?=
 =?us-ascii?Q?DhOc9ploBajyFrUMZmSrclEXCvL2SdY4qrdrOSBqn54sXTWt2gz6FZWts+HY?=
 =?us-ascii?Q?EAcdgiDqxSNIn9Irx2iILA2dkZftM/p0djM2AqVfKWBBhWIUO9eYRu0RTX5s?=
 =?us-ascii?Q?D7oBvULJi0cVwKSY8qwcq85zkEMtUQSFpdqYTp3YCN538ZP3fDIE9Wq2RBYB?=
 =?us-ascii?Q?PvWagFVfbYjS1IwIfcLS0TFeqjzRtuFqM6tbWwWOYDyRFDoiUGrG9NBnsAsu?=
 =?us-ascii?Q?O4aOJOIL0FjjfrwClhQBlyhRffxzYZWBHGH8sHFyqIOqYikiZbkjI+B9fDaY?=
 =?us-ascii?Q?WwqGytV6WGLBb2iCvHzjJ9XrEd3dc8EsC1ugkFec6v1rKcuQg9ochXK+lfuK?=
 =?us-ascii?Q?tXe490bMaCmLlCHgofQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e83eb9-8d38-4fc1-accf-08dc9cd5b3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:34:43.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwDNBGf0GCTzLOJxf7q5dDloZu+YpWVOkBI9uZ7Y8UDENmsNKRBqeqzUs0YjSLHijGlqyHm6xfe17sGF1+UwkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10663

Hi Jassi,

> Subject: RE: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
>=20
> Hi Jassi,
>=20
> > Subject: [PATCH] mailbox: imx: fix TXDB_V2 channel race condition
>=20
> Ping..

Ping again..

Thanks,
Peng.

>=20
> Thanks,
> Peng.
>=20
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Two TXDB_V2 channels are used between Linux and System
> Manager(SM).
> > Channel0 for normal TX, Channel 1 for notification completion.
> > The TXDB_V2 trigger logic is using imx_mu_xcr_rmw which uses
> > read/modify/update logic.
> >
> > Note: clear MUB GSR BITs, the MUA side GCR BITs will also got
> cleared
> > per hardware design.
> > Channel0 Linux
> > read GCR->modify GCR->write GCR->M33 SM->read GSR----->clear
> GSR
> >                                                 |-(1)-|
> > Channel1 Linux start in time slot(1)
> > read GCR->modify GCR->write GCR->M33 SM->read GSR->clear GSR
> So
> > Channel1 read GCR will read back the GCR that Channel0 wrote,
> because
> > M33 has not finish clear GSR, this means Channel1 GCR writing will
> > trigger Channel1 and Channel0 interrupt both which is wrong.
> >
> > Channel0 will be freed(SCMI channel status set to FREE) in M33 SM
> when
> > processing the 1st Channel0 interrupt. So when 2nd interrupt trigger
> > (channel 0/1 trigger together), SM will see a freed Channel0, and
> > report protocol error.
> >
> > To address the issue, not using read/modify/update logic, just use
> > write, because write 0 to GCR will be ignored. And after write MUA
> > GCR, wait the SM to clear MUB GSR by looping MUA GCR value.
> >
> > Fixes: 5bfe4067d350 ("mailbox: imx: support channel type tx
> doorbell
> > v2")
> > Reviewed-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1: This patch has got R-b inside NXP and could be directly applied to
> >     upstream linux, so I keep the R-b tag from Ranjani.
> >
> >  drivers/mailbox/imx-mailbox.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-
> > mailbox.c index 5c1d09cad761..38abe07babdf 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -224,6 +224,8 @@ static int imx_mu_generic_tx(struct
> imx_mu_priv
> > *priv,
> >  			     void *data)
> >  {
> >  	u32 *arg =3D data;
> > +	u32 val;
> > +	int ret;
> >
> >  	switch (cp->type) {
> >  	case IMX_MU_TYPE_TX:
> > @@ -235,7 +237,13 @@ static int imx_mu_generic_tx(struct
> imx_mu_priv
> > *priv,
> >  		tasklet_schedule(&cp->txdb_tasklet);
> >  		break;
> >  	case IMX_MU_TYPE_TXDB_V2:
> > -		imx_mu_xcr_rmw(priv, IMX_MU_GCR,
> > IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
> > +		imx_mu_write(priv, IMX_MU_xCR_GIRn(priv->dcfg-
> > >type, cp->idx),
> > +			     priv->dcfg->xCR[IMX_MU_GCR]);
> > +		ret =3D readl_poll_timeout(priv->base + priv->dcfg-
> > >xCR[IMX_MU_GCR], val,
> > +					 !(val &
> > IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx)),
> > +					 0, 1000);
> > +		if (ret)
> > +			dev_warn_ratelimited(priv->dev, "channel
> > type: %d failure\n",
> > +cp->type);
> >  		break;
> >  	default:
> >  		dev_warn_ratelimited(priv->dev, "Send data on wrong
> channel type:
> > %d\n", cp->type);
> > --
> > 2.37.1
>=20


