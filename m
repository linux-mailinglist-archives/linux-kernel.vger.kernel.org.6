Return-Path: <linux-kernel+bounces-177397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7798C3DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A04281BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F71487DA;
	Mon, 13 May 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CkyKq9l+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025D1487D0;
	Mon, 13 May 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591783; cv=fail; b=qRDvG9Bpdc+Xl/dpFkDxLJV0ufqlv/HtztoFMaeZqt+Hm6BaLZsg93OgVd8OET+wYhIOMoMZl502NrseJRRrbfSZNx1TSWMZij+cgTd3GSDtaVy6JV6Q2T86OZ0qWY55Qp4/c8q1OFk8oWPYVbQurYAxqWVbETlJlXWl4ph7YWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591783; c=relaxed/simple;
	bh=NI+BymRr3myV815mluliRnazIFS4f2Qcxs1+ApQJ7eU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQdPGPD0vJ6tGDwE+r58DBpBU0nK89tbDFYoDjLL+U79d0oxg516K9bqwkra0zA/WlDXxM0A7mPhR5mGx4Q4xaNtjkbNI1Epx9nbL8ofknUWJIkyH1x/GCDP5R4j52w++8UpYFwPb5J2/LxafCCNPGJafgyovRegb8z2juN8Pi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CkyKq9l+; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/8JdYmzWAJwO4zsqoVtDXujwxZEmiQ4L8dq5XF44OpUBBmiuDYVyalOH0lolsQSYLhD+tmD2khBjpMS838cvu9ftpAh5w0Ytgwsd4Nonn0gTfVRoWiI87QyaVS+b9dIjvRXPM701Huo/rMtYLeYxMvM3YCjMFg0+MxZgeyjC4SU8tNCKthCro7nV7UbMDUFmShAb23LUTWbDCdHaxyituQYAwh31gZfOuMi/ZYdhiMg4XM9gpgZJ8/OzCJhtj+1fAOw7ZZR+FO5+YH77hS92rcSWK9bLs4uYzOx2XXnUe2jinG9vz9RBFyYRMIRhdVN1Fme46aLAYRNo8RXs+QKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9/3Vabw8I/jf3SGirnS/yUStJp+/H7yvRpdMgpa2c4=;
 b=hGMBA/fHMgJ3HItgY29xZl4Dc/qSwd2WQH2R/Di4/fOeDeO1hab8Ro5NtTQrrCz8qDHbhJx+FMnQeSYYY1K0R3H1OdzqMitdNNZQS8VNVOHPx4PsXwNInTl7NMY7mKyD0uvaBShFLFhWTCGhvPKdjacvP3pyupyrG52RXAySR13sj3UwNX+uPG9tQIr3kCKc7cjhowp0w4l+fItsh+tlDSEazHEcGHCSH3sXlI8oDGZSTUNNpJz2+LZ44KjRzSdkYYKomvM6FWcuRw1Hk8zeMQ2yAyzOpReXqPLJeNk9tjpgvnbSu7Nfxi/gWgEeeHm7mgyI3sd7qh9nyoMwcyd/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9/3Vabw8I/jf3SGirnS/yUStJp+/H7yvRpdMgpa2c4=;
 b=CkyKq9l+PtyXZM+3D+hXEfIfld2bePhYkjVZH8hgTNdNcvJF5S2Nsoz4wtC+F0gzOmMQS7vBLgU5gHUcwBPe1Wk7VUq/IwE4Kds3Z5XnlLuplNsb1cL9L4CWzkO6Rn3N9BI7E4zzHChXp21cAt82cIm7gJtUPDP6usXXfvomI6o=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:16:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:16:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Amit Singh Tomar <amitsinght@marvell.com>, Frank Li <frank.li@nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Topic: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Index: AQHaot4x2Q7iXJQ+y0OtihGrgo/RRLGQrACAgAAxxACABAg/0A==
Date: Mon, 13 May 2024 09:16:13 +0000
Message-ID:
 <AM9PR04MB860470D517BAFE0666481AAA95E22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
 <Zj5OKarpv7zvtzs1@lizhi-Precision-Tower-5810>
 <3f8ad6c5-4792-4b83-8c88-06be16031dc9@marvell.com>
In-Reply-To: <3f8ad6c5-4792-4b83-8c88-06be16031dc9@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB9142:EE_
x-ms-office365-filtering-correlation-id: e12a6897-0c22-465c-5c4f-08dc732d5667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cln6hKHaiI5wGSLvKnAyNregzXiQGUidg25A7MXRVibZWYsMX5AGQWMvRKy4?=
 =?us-ascii?Q?aLmCe6LPGDbxAh2nvx6mCf1eDotPZ20puGB+qDNbA+mvswZRm7SXMpfcR/5Z?=
 =?us-ascii?Q?oGYoEeGS0IoQcjbbe2LYFq52/bgrd/y4OpBMgBAh1PYC9lVAf0zkJKXewWZD?=
 =?us-ascii?Q?NRmlFP7hNt9lqRRxAtxNW6tGOgR/aJ4xxe4DB7QJP/XcVNYXzhrDNIEnb8LI?=
 =?us-ascii?Q?tsFa0D5Mpamj+xiJO85PscXU+KDGda57v9kgEZEJp//JF+mFpkrZGh4fbFGx?=
 =?us-ascii?Q?GS5D9rM68Klj2R7v5v1IBGibQjySUTQNp325wUkFYgSan+XTlQTADMMqqS1J?=
 =?us-ascii?Q?Y0LDjE9iEZ4jqjKh2cYlXSmmxtLu4vvL10ISP2M15IfMGKbj2UHpnS4c5Xgq?=
 =?us-ascii?Q?jt2fO/CmqldfHtXPL65y83rYU5RfXHOLLGLhNFeg0jz1BJsOVyMBDPUeohNJ?=
 =?us-ascii?Q?Ar12eDCRU0vlhg6v3IvBDLByE1TKvjljmaXWKHW3gNO8WqtkCkC6ilnX+G/k?=
 =?us-ascii?Q?cKEKNkLGjQfbWLuYvBCKMGOrpcI78N9jRQbiVT4yZFpMN7bGWN5aWc2xGCRG?=
 =?us-ascii?Q?MGuNjabSDeYue6gyU9XxAU3/JsS48WbM5RCuoJMJ77PiSInbdP8JTJBwqds/?=
 =?us-ascii?Q?nHo4oJBgFBYNx/H1+qXEi/QWEMCL5LwyEKIluMY54eK1rHuq8vEDcaKVG6Cr?=
 =?us-ascii?Q?8xX5hgzBOwGO5zv+bpOtfVmirqHmzp1sGlQ5pwnq0uxJA1Yny2ssnfZZW6Ds?=
 =?us-ascii?Q?ez5c5Iwwouaxa8aOHjzq9GE/NjC5nOxyz03w1NxDW5Hug1FKEkOg9VDbKzci?=
 =?us-ascii?Q?tu0a/vHBQ0KFcTOp7AOzeMp6vQEozl1FszED8+6bzS0TEonk8BEC83lSpZPn?=
 =?us-ascii?Q?RHubn+T3IQDuuHBSIPQLI+NXY5bxcGEcv10FKeI2qzxHS2bDXfMa1pU92zuw?=
 =?us-ascii?Q?KzR+GkkEboNPW4HMsdxx1LJFdPjGVGaXDE+UKCDlGstU5y0SbDtE+Vo6Tnct?=
 =?us-ascii?Q?Db4wU7knnLB/G2CLWVFej3f0P5b72RZ0sKXqtc9sgtUTC+RtNI8QJMTcZd0A?=
 =?us-ascii?Q?Zfw8CuYd3GKJrS5zgM51FvqBPa7vWLwxyMQg2wZm9KAEcN9tIaBaWmlJAKRf?=
 =?us-ascii?Q?jy1PGMZRLUIhbKwGV7WvoUCE7K9wUJAgvxeOKqMmy0RtmDNOjRATa59aLLhq?=
 =?us-ascii?Q?RCPhc40j2GV25y39s7X2su844QBYVriPL2RwIXQ77mqUugRkA2tvusDkm0Z7?=
 =?us-ascii?Q?wNCBlqjvCgPp54D6yrExNt8lQV3KyP75qPpg+xiFHM+fZ1kBi8eNxGa6gS+a?=
 =?us-ascii?Q?kQuurmfJujDSfytEPVl7mZex75pJtU9o39K6/4EpRJW3yA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FbJc6w5EzKOIG5TZMiR3W5o891AlbauF3QPZOh7C5GE740tU8GV+bhD3KKo4?=
 =?us-ascii?Q?G9Lug542egcYerxTzIspDpe/xVeRa2XJ3uZMUZghT7arnMd1ddmwN6/1mB0v?=
 =?us-ascii?Q?s73ud/IoIdMsgkltqKJlecJGBH7ABgP2dEGUe1ujaUXf+qkgoEKPnnbfFbNr?=
 =?us-ascii?Q?wsL5Q1nLCYLOUFYGXfOzSkzMuragTWSz7hJVAfFvcZAY6OaEzw6PyHunzsE6?=
 =?us-ascii?Q?Fu9YmtKF0qsIw+7hXG6FaSKvYaYRIu1TE3ZnXYPtAoRN7f0lTr7CYl7tTdF4?=
 =?us-ascii?Q?bL61nCr8TfZjhxjIvh3+yEXwFuIIHBKAuGpTLygI8lm8L19tWsrpEG6pv5/j?=
 =?us-ascii?Q?sMA2+TJEYvWAK25zYXuZ2FSp3ORj23uJeiA8NVdpzYWODOJl1kOJZZROis0F?=
 =?us-ascii?Q?0+WyEKEW9tOKMzcaTtKe1TKPE/6Dfoo0dMMblIqJZ/e6zO0C2uQyz8faFL2e?=
 =?us-ascii?Q?nY75wJ0FFqUn637afnSAKH4OMRCC8LmXU3KKK0wlg3lroF/Hb0ofBPwgLfpk?=
 =?us-ascii?Q?mgLyGsFbQIrtHa/uuiyDc5GT5oA3yPSu43wI1AwHzFul5E11IJ5gA6hw3P0I?=
 =?us-ascii?Q?N+Pk0WNpLYNRAxdRl99h1FS+Or9PJBGjlyZ32fffDjVNA6M4OwU/KmTezl0t?=
 =?us-ascii?Q?Ee85Z9CTME3qzCyY7ACZlPl1txXiVonj+18dJSIVdHWPdZRGJZmoCV5iZCdJ?=
 =?us-ascii?Q?dUHnNDITuYNpdiiyp4sPXGbGQiBpWf6QaH0qil/fTt/Rn34MWIlzs3yF78jS?=
 =?us-ascii?Q?JRiQQrDZJ+D6ab+2BV13uvZqtPPAc7RjqSxGNQtOeOyrofDvJefbiXpgAMQz?=
 =?us-ascii?Q?utF6aKyBNa8plV0laIMMwwGrLSxKrnrC+jmB2WTKfhw2fCyzBj8rAmCu4epZ?=
 =?us-ascii?Q?GR8Xzi2Ib1voSdaWkzAl/EmmAAj23yhiPk5RUA8dZb5gmYMu+9FEEUsYw5Tj?=
 =?us-ascii?Q?CRfVE7TZVKNFRH/iu0KPNhseCjGr7hf96YgYw3HGCzd9AvviUkknQmfbK1yc?=
 =?us-ascii?Q?XLP+3pGRaClL9iyBJnEqqxD1Wh5H8ZQZxTQzmjvPDpmQsWk4o+OAUp40urC4?=
 =?us-ascii?Q?DG1ftEptLYq0ND3xvafwnZ4Qt8ScrgC/Cy2lts7yQIM+5jvNnZUVs3dCDZyK?=
 =?us-ascii?Q?l4LWMl0+2J1PI2xNR15z8EXoM8Pccaqzvu79THs/wdd1mDweVKyN2TN7SVyA?=
 =?us-ascii?Q?kG9cbK2EgIlSAajYEWarp/PNWEu5wC84IEdbT2P/n3SNUVIsdqNKOU3Wi41/?=
 =?us-ascii?Q?Gdm2ToXyNgqmBlwfzApBYJrc8UM6XVM/6NJpVrWB8qvOke5mo4tFPg2YXap0?=
 =?us-ascii?Q?jV4wfGxGZYz4JZ6JVrRnmE4VNwKd3l6xCZNca2IrjPGEK6EtGbY4twpTWcIf?=
 =?us-ascii?Q?gkVX9y6Q/h7elfdJRnbq/d5ApDGUnnWpoZOPbca9vwbW7exJz6cH6PcvAvfO?=
 =?us-ascii?Q?NkKNpfejWYkhkgeOvUNPz4xbNJQeI5hzMnTF2+gAtZIl+TFbxW/Op1FjO/+2?=
 =?us-ascii?Q?u4RqqtitrxbZn41ZBO27GgMgBxHygObwmaFx3HnCM3Vo+S96h2ciJ82h4hNq?=
 =?us-ascii?Q?8vTfSlEQ5I3VsvAfTGQ1wNlSjDVDluGeMiSbXFHK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e12a6897-0c22-465c-5c4f-08dc732d5667
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:16:13.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yU//by109+AMXhrP1oUSLRueangn/mmdVpH6KYmW2hjwj5aEb/tNWS+hjt0VB7TgTILNArREUauf7p2SNu64oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142



> -----Original Message-----
> From: Amit Singh Tomar <amitsinght@marvell.com>
> Sent: Saturday, May 11, 2024 1:09 AM
> To: Frank Li <frank.li@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
> Enclave
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi,
> >
> > ----------------------------------------------------------------------
> > On Fri, May 10, 2024 at 06:57:30PM +0530, Pankaj Gupta wrote:
> >> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> >> are embedded in the SoC to support the features like HSM, SHE & V2X,
> >> using message based communication interface.
> >>
> >> The secure enclave FW communicates on a dedicated messaging unit(MU)
> >> based interface(s) with application core, where kernel is running.
> >> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> >>
> >> This patch adds the driver for communication interface to secure-encla=
ve,
> >> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> Enclave,
> >> both from:
> >> - User-Space Applications via character driver.
> >> - Kernel-space, used by kernel management layers like DM-Crypt.
> >>
> >> ABI documentation for the NXP secure-enclave driver.
> >>
> >> User-space library using this driver:
> >> - i.MX Secure Enclave library:
> >>    -- URL:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
fe
> nse.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3
> DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3DeKFfdy51aVVEAe4I9Lk2CN77y_4Hxf2pI_9fv5pVWLo9DwQNgC
> pca6smAwvwFycf%26s%3DIfKbvjSfdUcqz-
> WEWdhbj1_TnqGryOffX1dV0T5Rf_A%26e%3D&data=3D05%7C02%7Cpankaj.gu
> pta%40nxp.com%7C111dd89e61f149b5f7e708dc71290348%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C638509668202231639%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DFEt3DR2WBF3v8fNgnliJhVB10
> MCCkaf8KYGmLz3fk3A%3D&reserved=3D0 ,
> >> - i.MX Secure Middle-Ware:
> >>    -- URL:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
fe
> nse.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-
> 2Dsmw.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3DV
> _GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3DeKFfdy51aVVEAe4I9Lk2CN77y_4Hxf2pI_9fv5pVWLo9DwQNgC
> pca6smAwvwFycf%26s%3DLLz2plXTM1AS-
> zJ1HlZRKiBE8GmRJBduR_0dnOuFjRo%26e%3D&data=3D05%7C02%7Cpankaj.gu
> pta%40nxp.com%7C111dd89e61f149b5f7e708dc71290348%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C638509668202240209%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DYOBEbhRl7XJeLu%2BdaznovR
> 4lDrbyoOlmxUP9BiYZ330%3D&reserved=3D0
> >>
> >> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >> ---
> >>   Documentation/ABI/testing/se-cdev   |   42 ++
> >>   drivers/firmware/imx/Kconfig        |   12 +
> >>   drivers/firmware/imx/Makefile       |    2 +
> >>   drivers/firmware/imx/ele_base_msg.c |  287 ++++++++
> >>   drivers/firmware/imx/ele_base_msg.h |   70 ++
> >>   drivers/firmware/imx/ele_common.c   |  341 +++++++++
> >>   drivers/firmware/imx/ele_common.h   |   43 ++
> >>   drivers/firmware/imx/se_ctrl.c      | 1339
> +++++++++++++++++++++++++++++++++++
> >>   drivers/firmware/imx/se_ctrl.h      |  151 ++++
> >>   include/linux/firmware/imx/se_api.h |   14 +
> >>   include/uapi/linux/se_ioctl.h       |   88 +++
> >>   11 files changed, 2389 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/se-cdev
> b/Documentation/ABI/testing/se-cdev
> >> new file mode 100644
> >> index 000000000000..699525af6b86
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/se-cdev
> >> @@ -0,0 +1,42 @@
> >> +What:               /dev/<se>_mu[0-9]+_ch[0-9]+
> >> +Date:               May 2024
> >> +KernelVersion:      6.8
> >> +Contact:    linux-imx@nxp.com, pankaj.gupta@nxp.com
> >> +Description:
> >> +            NXP offers multiple hardware IP(s) for  secure-enclaves l=
ike
> EdgeLock-
> >> +            Enclave(ELE), SECO. The character device file-descriptors
> >> +            /dev/<se>_mu*_ch* are the interface between user-space NX=
P's
> secure-
> >> +            enclave shared-library and the kernel driver.
> >> +
> >> +            The ioctl(2)-based ABI is defined and documented in
> >> +            [include]<linux/firmware/imx/ele_mu_ioctl.h>
> >> +             ioctl(s) are used primarily for:
> >> +                    - shared memory management
> >> +                    - allocation of I/O buffers
> >> +                    - get mu info
> >> +                    - setting a dev-ctx as receiver that is slave to =
fw
> >> +                    - get SoC info
> >> +
> >> +            The following file operations are supported:
> >> +
> >> +            open(2)
> >> +              Currently the only useful flags are O_RDWR.
> >> +
> >> +            read(2)
> >> +              Every read() from the opened character device context i=
s waiting
> on
> >> +              wakeup_intruptible, that gets set by the registered mai=
lbox
> callback
> >> +              function; indicating a message received from the firmwa=
re on
> message-
> >> +              unit.
> >> +
> >> +            write(2)
> >> +              Every write() to the opened character device context ne=
eds to
> acquire
> >> +              mailbox_lock, before sending message on to the message =
unit.
> >> +
> >> +            close(2)
> >> +              Stops and free up the I/O contexts that was associated
> >> +              with the file descriptor.
> >> +
> >> +Users:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
fe
> nse.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3
> DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3DeKFfdy51aVVEAe4I9Lk2CN77y_4Hxf2pI_9fv5pVWLo9DwQNgC
> pca6smAwvwFycf%26s%3DIfKbvjSfdUcqz-
> WEWdhbj1_TnqGryOffX1dV0T5Rf_A%26e%3D&data=3D05%7C02%7Cpankaj.gu
> pta%40nxp.com%7C111dd89e61f149b5f7e708dc71290348%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C638509668202246211%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D5Cpw4sCLsKzv%2FRiikt2aA4d
> ILonYXeFzcnMo4UugdQ4%3D&reserved=3D0 ,
> >> +
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
fe
> nse.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-
> 2Dsmw.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3DV
> _GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3DeKFfdy51aVVEAe4I9Lk2CN77y_4Hxf2pI_9fv5pVWLo9DwQNgC
> pca6smAwvwFycf%26s%3DLLz2plXTM1AS-
> zJ1HlZRKiBE8GmRJBduR_0dnOuFjRo%26e%3D&data=3D05%7C02%7Cpankaj.gu
> pta%40nxp.com%7C111dd89e61f149b5f7e708dc71290348%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C0%7C638509668202250817%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dm5NZLmshBmqnnbb2U%2Bm
> cMYYbv7LS8X%2ByzMVTs%2BI7tkI%3D&reserved=3D0
> >> +            crypto/skcipher,
> >> +            drivers/nvmem/imx-ocotp-ele.c
> >> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconf=
ig
> >> index 183613f82a11..56bdca9bd917 100644
> >> --- a/drivers/firmware/imx/Kconfig
> >> +++ b/drivers/firmware/imx/Kconfig
> >> @@ -22,3 +22,15 @@ config IMX_SCU
> >>
> >>        This driver manages the IPC interface between host CPU and the
> >>        SCU firmware running on M4.
> >> +
> >> +config IMX_SEC_ENCLAVE
> >> +    tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmwar=
e
> driver."
> >> +    depends on IMX_MBOX && ARCH_MXC && ARM64
> >> +    default m if ARCH_MXC
> >> +
> >> +    help
> >> +      It is possible to use APIs exposed by the iMX Secure Enclave HW=
 IP
> called:
> >> +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> >> +          like base, HSM, V2X & SHE using the SAB protocol via the sh=
ared
> Messaging
> >> +          Unit. This driver exposes these interfaces via a set of fil=
e descriptors
> >> +          allowing to configure shared memory, send and receive messa=
ges.
> >> diff --git a/drivers/firmware/imx/Makefile
> b/drivers/firmware/imx/Makefile
> >> index 8f9f04a513a8..aa9033e0e9e3 100644
> >> --- a/drivers/firmware/imx/Makefile
> >> +++ b/drivers/firmware/imx/Makefile
> >> @@ -1,3 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>   obj-$(CONFIG_IMX_DSP)              +=3D imx-dsp.o
> >>   obj-$(CONFIG_IMX_SCU)              +=3D imx-scu.o misc.o imx-scu-irq=
o rm.o
> imx-scu-soc.o
> >> +sec_enclave-objs            =3D se_ctrl.o ele_common.o ele_base_msg.o
> >> +obj-${CONFIG_IMX_SEC_ENCLAVE}       +=3D sec_enclave.o
> >> diff --git a/drivers/firmware/imx/ele_base_msg.c
> b/drivers/firmware/imx/ele_base_msg.c
> >> new file mode 100644
> >> index 000000000000..0463f26d93c7
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/ele_base_msg.c
> >> @@ -0,0 +1,287 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/completion.h>
> >> +#include <linux/dma-mapping.h>
> >> +
> >> +#include "ele_base_msg.h"
> >> +#include "ele_common.h"
> >> +
> >> +int ele_get_info(struct device *dev, struct soc_info *s_info)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct se_api_msg *tx_msg __free(kfree);
> >> +    struct se_api_msg *rx_msg __free(kfree);
> >> +    phys_addr_t get_info_addr;
> >> +    u32 *get_info_data;
> >> +    u32 status;
> >> +    int ret;
> >> +
> >> +    if (!priv || !s_info)
> >> +            goto exit;
> >> +
> >> +    memset(s_info, 0x0, sizeof(*s_info));
> >> +
> >> +    if (priv->mem_pool_name)
> >> +            get_info_data =3D get_phy_buf_mem_pool(dev,
> >> +                                                 priv->mem_pool_name,
> >> +                                                 &get_info_addr,
> >> +                                                 ELE_GET_INFO_BUFF_SZ=
);
> >> +    else
> >> +            get_info_data =3D dmam_alloc_coherent(dev,
> >> +                                                ELE_GET_INFO_BUFF_SZ,
> >> +                                                &get_info_addr,
> >> +                                                GFP_KERNEL);
> >> +    if (!get_info_data) {
> >> +            ret =3D -ENOMEM;
> >> +            dev_err(dev,
> >> +                    "%s: Failed to allocate get_info_addr.\n",
> >> +                    __func__);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    tx_msg =3D kzalloc(ELE_GET_INFO_REQ_MSG_SZ << 2, GFP_KERNEL);
> >> +    if (!tx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> It seems like you intended to use goto exit; instead of returning
> directly from here. This would ensure that you can free the buffer
> allocated with get_phy_buf_mem_pool in case of an allocation failure.


Accepted.

> >> +    }
> >> +
> >> +    rx_msg =3D kzalloc(ELE_GET_INFO_RSP_MSG_SZ << 2, GFP_KERNEL);
> >> +    if (!rx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
Will correct here as well.

> >> +
> >> +    ret =3D plat_fill_cmd_msg_hdr(priv,
> >> +                                (struct se_msg_hdr *)&tx_msg->header,
> >> +                                ELE_GET_INFO_REQ,
> >> +                                ELE_GET_INFO_REQ_MSG_SZ,
> >> +                                true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    tx_msg->data[0] =3D upper_32_bits(get_info_addr);
> >> +    tx_msg->data[1] =3D lower_32_bits(get_info_addr);
> >> +    tx_msg->data[2] =3D ELE_GET_INFO_READ_SZ;
> >> +    priv->rx_msg =3D rx_msg;
> >> +    ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> >> +    if (ret < 0)
> >> +            goto exit;
> >> +
> >> +    ret  =3D validate_rsp_hdr(priv,
> >> +                            priv->rx_msg->header,
> >> +                            ELE_GET_INFO_REQ,
> >> +                            ELE_GET_INFO_RSP_MSG_SZ,
> >> +                            true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    status =3D RES_STATUS(priv->rx_msg->data[0]);
> >> +    if (status !=3D priv->success_tag) {
> >> +            dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> >> +                    ELE_GET_INFO_REQ, status);
> >> +            ret =3D -1;
> >> +    }
> >> +
> >> +    s_info->imem_state =3D (get_info_data[ELE_IMEM_STATE_WORD]
> >> +                            & ELE_IMEM_STATE_MASK) >> 16;
> >> +    s_info->major_ver =3D
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> >> +                            & SOC_VER_MASK) >> 24;
> >> +    s_info->minor_ver =3D
> ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> >> +                            & SOC_VER_MASK) >> 16) & 0xFF;
> >> +    s_info->soc_rev =3D
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> >> +                            & SOC_VER_MASK) >> 16;
> >> +    s_info->soc_id =3D get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> >> +                            & SOC_ID_MASK;
> >> +    s_info->serial_num
> >> +            =3D (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] <<
> 32
> >> +                    | get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF];
> >> +exit:
> >> +    if (get_info_addr) {
> >> +            if (priv->mem_pool_name)
> >> +                    free_phybuf_mem_pool(dev, priv->mem_pool_name,
> >> +                                         get_info_data, ELE_GET_INFO_=
BUFF_SZ);
> >> +            else
> >> +                    dmam_free_coherent(dev,
> >> +                                       ELE_GET_INFO_BUFF_SZ,
> >> +                                       get_info_data,
> >> +                                       get_info_addr);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +int ele_ping(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct se_api_msg *tx_msg __free(kfree);
> >> +    struct se_api_msg *rx_msg __free(kfree);
> >
> > If you want __free(kfree) it should be
> >
> > struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> >
> > Or
> >
> > struct se_api_msg *tx_msg __free(kfree) =3D kzalloc(ELE_PING_REQ_SZ << =
2,
> GFP_KERNEL)
> > struct se_api_msg *rx_msg __free(kfree) =3D kzalloc(ELE_PING_RSP_SZ << =
2,
> GFP_KERNEL)
> >
> > otherwise when
> >   if (!tx_msg) {
> >               return ret;
> >
> >           ^^ when go here, rx_msg is random value. So kfree(rx_msg) wil=
l
> > access random address.
> >
> >   }
> >
> >> +    u32 status;
> >> +    int ret;
> >> +
> >> +    tx_msg =3D kzalloc(ELE_PING_REQ_SZ << 2, GFP_KERNEL);
> >> +    if (!tx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >
> >
> > return -ENOMEM
> >
> > Frank
> >
> >> +    }
> >> +
> >> +    rx_msg =3D kzalloc(ELE_PING_RSP_SZ << 2, GFP_KERNEL);
> >> +    if (!rx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +
> >> +    ret =3D plat_fill_cmd_msg_hdr(priv,
> >> +                                (struct se_msg_hdr *)&tx_msg->header,
> >> +                                ELE_PING_REQ, ELE_PING_REQ_SZ,
> >> +                                true);
> >> +    if (ret) {
> >> +            dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> >> +            goto exit;
> >> +    }
> >> +
> >> +    priv->rx_msg =3D rx_msg;
> >> +    ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    ret  =3D validate_rsp_hdr(priv,
> >> +                            priv->rx_msg->header,
> >> +                            ELE_PING_REQ,
> >> +                            ELE_PING_RSP_SZ,
> >> +                            true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    status =3D RES_STATUS(priv->rx_msg->data[0]);
> >> +    if (status !=3D priv->success_tag) {
> >> +            dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> >> +                    ELE_PING_REQ, status);
> >> +            ret =3D -1;
> >> +    }
> >> +exit:
> >> +    return ret;
> >> +}
> >> +
> >> +int ele_service_swap(struct device *dev,
> >> +                 phys_addr_t addr,
> >> +                 u32 addr_size, u16 flag)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct se_api_msg *tx_msg __free(kfree);
> >> +    struct se_api_msg *rx_msg __free(kfree);
> >> +    u32 status;
> >> +    int ret;
> >> +
> >> +    tx_msg =3D kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ << 2,
> GFP_KERNEL);
> >> +    if (!tx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +
> >> +    rx_msg =3D kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ << 2,
> GFP_KERNEL);
> >> +    if (!rx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +
> >> +    ret =3D plat_fill_cmd_msg_hdr(priv,
> >> +                                (struct se_msg_hdr *)&tx_msg->header,
> >> +                                ELE_SERVICE_SWAP_REQ,
> >> +                                ELE_SERVICE_SWAP_REQ_MSG_SZ,
> >> +                                true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    tx_msg->data[0] =3D flag;
> >> +    tx_msg->data[1] =3D addr_size;
> >> +    tx_msg->data[2] =3D ELE_NONE_VAL;
> >> +    tx_msg->data[3] =3D lower_32_bits(addr);
> >> +    tx_msg->data[4] =3D plat_add_msg_crc((uint32_t *)&tx_msg[0],
> >> +                                             ELE_SERVICE_SWAP_REQ_MSG=
_SZ);
> >> +    priv->rx_msg =3D rx_msg;
> >> +    ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> >> +    if (ret < 0)
> >> +            goto exit;
> >> +
> >> +    ret  =3D validate_rsp_hdr(priv,
> >> +                            priv->rx_msg->header,
> >> +                            ELE_SERVICE_SWAP_REQ,
> >> +                            ELE_SERVICE_SWAP_RSP_MSG_SZ,
> >> +                            true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    status =3D RES_STATUS(priv->rx_msg->data[0]);
> >> +    if (status !=3D priv->success_tag) {
> >> +            dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> >> +                    ELE_SERVICE_SWAP_REQ, status);
> >> +            ret =3D -1;
> >> +    } else {
> >> +            if (flag =3D=3D ELE_IMEM_EXPORT)
> >> +                    ret =3D priv->rx_msg->data[1];
> >> +            else
> >> +                    ret =3D 0;
> >> +    }
> >> +exit:
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct se_api_msg *tx_msg __free(kfree);
> >> +    struct se_api_msg *rx_msg __free(kfree);
> >> +    u32 status;
> >> +    int ret;
> >> +
> >> +    tx_msg =3D kzalloc(ELE_FW_AUTH_REQ_SZ << 2, GFP_KERNEL);
> >> +    if (!tx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +
> >> +    rx_msg =3D kzalloc(ELE_FW_AUTH_RSP_MSG_SZ << 2, GFP_KERNEL);
> >> +    if (!rx_msg) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +    ret =3D plat_fill_cmd_msg_hdr(priv,
> >> +                                (struct se_msg_hdr *)&tx_msg->header,
> >> +                                ELE_FW_AUTH_REQ,
> >> +                                ELE_FW_AUTH_REQ_SZ,
> >> +                                true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    tx_msg->data[0] =3D addr;
> >> +    tx_msg->data[1] =3D 0x0;
> >> +    tx_msg->data[2] =3D addr;
> >> +
> >> +    priv->rx_msg =3D rx_msg;
> >> +    ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> >> +    if (ret < 0)
> >> +            goto exit;
> >> +
> >> +    ret  =3D validate_rsp_hdr(priv,
> >> +                            priv->rx_msg->header,
> >> +                            ELE_FW_AUTH_REQ,
> >> +                            ELE_FW_AUTH_RSP_MSG_SZ,
> >> +                            true);
> >> +    if (ret)
> >> +            goto exit;
> >> +
> >> +    status =3D RES_STATUS(priv->rx_msg->data[0]);
> >> +    if (status !=3D priv->success_tag) {
> >> +            dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> >> +                    ELE_FW_AUTH_REQ, status);
> >> +            ret =3D -1;
> >> +    }
> >> +exit:
> >> +
> >> +    return ret;
> >> +}
> >> diff --git a/drivers/firmware/imx/ele_base_msg.h
> b/drivers/firmware/imx/ele_base_msg.h
> >> new file mode 100644
> >> index 000000000000..3b3d2bf04a84
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/ele_base_msg.h
> >> @@ -0,0 +1,70 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright 2024 NXP
> >> + *
> >> + * Header file for the EdgeLock Enclave Base API(s).
> >> + */
> >> +
> >> +#ifndef ELE_BASE_MSG_H
> >> +#define ELE_BASE_MSG_H
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/types.h>
> >> +
> >> +#define WORD_SZ                             4
> >> +#define ELE_NONE_VAL                        0x0
> >> +
> >> +#define ELE_SUCCESS_IND                     0xD6
> >> +
> >> +#define ELE_GET_INFO_REQ            0xDA
> >> +#define ELE_GET_INFO_REQ_MSG_SZ             0x10
> >> +#define ELE_GET_INFO_RSP_MSG_SZ             0x08
> >> +
> >> +#define ELE_GET_INFO_BUFF_SZ                0x100
> >> +#define ELE_GET_INFO_READ_SZ                0xA0
> >> +
> >> +#define DEFAULT_IMX_SOC_VER         0xA0
> >> +#define SOC_VER_MASK                        0xFFFF0000
> >> +#define SOC_ID_MASK                 0x0000FFFF
> >> +struct soc_info {
> >> +    u32 imem_state;
> >> +    u8 major_ver;
> >> +    u8 minor_ver;
> >> +    u16 soc_id;
> >> +    u16 soc_rev;
> >> +    u64 serial_num;
> >> +};
> >> +
> >> +#define GET_INFO_SOC_INFO_WORD_OFFSET       1
> >> +#define GET_INFO_UUID_WORD_OFFSET   3
> >> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> >> +    (GET_INFO_UUID_WORD_OFFSET + 3)
> >> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> >> +    (GET_INFO_UUID_WORD_OFFSET + 0)
> >> +
> >> +#define ELE_PING_REQ                        0x01
> >> +#define ELE_PING_REQ_SZ                     0x04
> >> +#define ELE_PING_RSP_SZ                     0x08
> >> +
> >> +#define ELE_SERVICE_SWAP_REQ                0xDF
> >> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ 0x18
> >> +#define ELE_SERVICE_SWAP_RSP_MSG_SZ 0x0C
> >> +#define ELE_IMEM_SIZE                       0x10000
> >> +#define ELE_IMEM_STATE_OK           0xCA
> >> +#define ELE_IMEM_STATE_BAD          0xFE
> >> +#define ELE_IMEM_STATE_WORD         0x27
> >> +#define ELE_IMEM_STATE_MASK         0x00ff0000
> >> +#define ELE_IMEM_EXPORT                     0x1
> >> +#define ELE_IMEM_IMPORT                     0x2
> >> +
> >> +#define ELE_FW_AUTH_REQ                     0x02
> >> +#define ELE_FW_AUTH_REQ_SZ          0x10
> >> +#define ELE_FW_AUTH_RSP_MSG_SZ              0x08
> >> +
> >> +int ele_get_info(struct device *dev, struct soc_info *s_info);
> >> +int ele_ping(struct device *dev);
> >> +int ele_service_swap(struct device *dev,
> >> +                 phys_addr_t addr,
> >> +                 u32 addr_size, u16 flag);
> >> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
> >> +#endif
> >> diff --git a/drivers/firmware/imx/ele_common.c
> b/drivers/firmware/imx/ele_common.c
> >> new file mode 100644
> >> index 000000000000..dcf7f9034653
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/ele_common.c
> >> @@ -0,0 +1,341 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#include "ele_base_msg.h"
> >> +#include "ele_common.h"
> >> +
> >> +u32 plat_add_msg_crc(u32 *msg, u32 msg_len)
> >> +{
> >> +    u32 nb_words =3D msg_len / (u32)sizeof(u32);
> >> +    u32 crc =3D 0;
> >> +    u32 i;
> >> +
> >> +    for (i =3D 0; i < nb_words - 1; i++)
> >> +            crc ^=3D *(msg + i);
> >> +
> >> +    return crc;
> >> +}
> >> +
> >> +int imx_ele_msg_rcv(struct se_if_priv *priv)
> >> +{
> >> +    u32 wait;
> >> +    int err;
> >> +
> >> +    wait =3D msecs_to_jiffies(1000);
> >> +    if (!wait_for_completion_timeout(&priv->done, wait)) {
> >> +            dev_err(priv->dev,
> >> +                            "Error: wait_for_completion timed out.\n"=
);
> >> +            err =3D -ETIMEDOUT;
> >> +    }
> >> +
> >> +    mutex_unlock(&priv->se_if_cmd_lock);
> >> +    priv->no_dev_ctx_used =3D false;
> >> +
> >> +    return err;
> >> +}
> >> +
> >> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg)
> >> +{
> >> +    bool is_cmd_lock_tobe_taken =3D false;
> >> +    int err;
> >> +
> >> +    if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> >> +            is_cmd_lock_tobe_taken =3D true;
> >> +            mutex_lock(&priv->se_if_cmd_lock);
> >> +    }
> >> +    scoped_guard(mutex, &priv->se_if_lock);
> >> +
> >> +    err =3D mbox_send_message(priv->tx_chan, mssg);
> >> +    if (err < 0) {
> >> +            dev_err(priv->dev, "Error: mbox_send_message failure.\n")=
;
> >> +            if (is_cmd_lock_tobe_taken)
> >> +                    mutex_unlock(&priv->se_if_cmd_lock);
> >> +            return err;
> >> +    }
> >> +    err =3D 0;
> >> +
> >> +    return err;
> >> +}
> >> +
> >> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg)
> >> +{
> >> +    int err;
> >> +
> >> +    priv->no_dev_ctx_used =3D true;
> >> +    err =3D imx_ele_msg_send(priv, mssg);
> >> +    if (err)
> >> +            goto exit;
> >> +
> >> +    err =3D imx_ele_msg_rcv(priv);
> >> +
> >> +exit:
> >> +    return err;
> >> +}
> >> +
> >> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx)
> >> +{
> >> +    struct se_msg_hdr header =3D {0};
> >> +    int err;
> >> +
> >> +    err =3D wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hd=
r !=3D
> 0);
> >> +    if (err)
> >> +            dev_err(dev_ctx->dev,
> >> +                    "%s: Err[0x%x]:Interrupted by signal.\n",
> >> +                    dev_ctx->miscdev.name, err);
> >> +
> >> +    header =3D *((struct se_msg_hdr *) (&dev_ctx->temp_resp[0]));
> >> +
> >> +    if (header.tag =3D=3D dev_ctx->priv->rsp_tag)
> >> +            mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> >> +
> >> +    return err;
> >> +}
> >> +
> >> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> >> +                         void *tx_msg, int tx_msg_sz)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_ctx->priv;
> >> +    struct se_msg_hdr header =3D {0};
> >> +    int err;
> >> +
> >> +    header =3D *((struct se_msg_hdr *) tx_msg);
> >> +
> >> +    /*
> >> +     * Check that the size passed as argument matches the size
> >> +     * carried in the message.
> >> +     */
> >> +    err =3D header.size << 2;
> >> +
> >> +    if (err !=3D tx_msg_sz) {
> >> +            err =3D -EINVAL;
> >> +            dev_err(priv->dev,
> >> +                    "%s: User buffer too small\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            goto exit;
> >> +    }
> >> +    /* Check the message is valid according to tags */
> >> +    if (header.tag =3D=3D priv->cmd_tag)
> >> +            priv->waiting_rsp_dev =3D dev_ctx;
> >> +    else if (header.tag =3D=3D priv->rsp_tag) {
> >> +            /* Check the device context can send the command */
> >> +            if (dev_ctx !=3D priv->cmd_receiver_dev) {
> >> +                    dev_err(priv->dev,
> >> +                            "%s: Channel not configured to send resp =
to FW.",
> >> +                            dev_ctx->miscdev.name);
> >> +                    err =3D -EPERM;
> >> +                    goto exit;
> >> +            }
> >> +    } else {
> >> +            dev_err(priv->dev,
> >> +                    "%s: The message does not have a valid TAG\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EINVAL;
> >> +            goto exit;
> >> +    }
> >> +    err =3D imx_ele_msg_send(priv, tx_msg);
> >> +exit:
> >> +    return err;
> >> +}
> >> +
> >> +/*
> >> + * Callback called by mailbox FW, when data is received.
> >> + */
> >> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> >> +{
> >> +    struct device *dev =3D mbox_cl->dev;
> >> +    struct se_if_device_ctx *dev_ctx;
> >> +    struct se_api_msg *rx_msg;
> >> +    bool is_response =3D false;
> >> +    struct se_if_priv *priv;
> >> +    struct se_msg_hdr header;
> >> +
> >> +    priv =3D dev_get_drvdata(dev);
> >> +    if (!priv) {
> >> +            dev_err(dev, "SE-MU Priv data is NULL;");
> >> +            return;
> >> +    }
> >> +
> >> +    /* The function can be called with NULL msg */
> >> +    if (!msg) {
> >> +            dev_err(dev, "Message is invalid\n");
> >> +            return;
> >> +    }
> >> +
> >> +    header.tag =3D ((u8 *)msg)[TAG_OFFSET];
> >> +    header.command =3D ((u8 *)msg)[CMD_OFFSET];
> >> +    header.size =3D ((u8 *)msg)[SZ_OFFSET];
> >> +    header.ver =3D ((u8 *)msg)[VER_OFFSET];
> >> +
> >> +    /* Incoming command: wake up the receiver if any. */
> >> +    if (header.tag =3D=3D priv->cmd_tag) {
> >> +            dev_dbg(dev, "Selecting cmd receiver\n");
> >> +            dev_ctx =3D priv->cmd_receiver_dev;
> >> +    } else if (header.tag =3D=3D priv->rsp_tag) {
> >> +            if (priv->waiting_rsp_dev) {
> >> +                    dev_dbg(dev, "Selecting rsp waiter\n");
> >> +                    dev_ctx =3D priv->waiting_rsp_dev;
> >> +                    is_response =3D true;
> >> +            } else {
> >> +                    /*
> >> +                     * Reading the EdgeLock Enclave response
> >> +                     * to the command, sent by other
> >> +                     * linux kernel services.
> >> +                     */
> >> +                    spin_lock(&priv->lock);
> >> +                    memcpy(&priv->rx_msg, msg, header.size << 2);
> >> +
> >> +                    complete(&priv->done);
> >> +                    spin_unlock(&priv->lock);
> >> +                    return;
> >> +            }
> >> +    } else {
> >> +            dev_err(dev, "Failed to select a device for message: %.8x=
\n",
> >> +                            *((u32 *) &header));
> >> +            return;
> >> +    }
> >> +    /* Init reception */
> >> +    rx_msg =3D kzalloc(header.size << 2, GFP_KERNEL);
> >> +    if (rx_msg)
> >> +            memcpy(rx_msg, msg, header.size << 2);
> >> +
> >> +    dev_ctx->temp_resp =3D (u32 *)rx_msg;
> >> +    dev_ctx->temp_resp_size =3D header.size;
> >> +
> >> +    /* Allow user to read */
> >> +    dev_ctx->pending_hdr =3D 1;
> >> +    wake_up_interruptible(&dev_ctx->wq);
> >> +
> >> +    if (is_response)
> >> +            priv->waiting_rsp_dev =3D NULL;
> >> +}
> >> +
> >> +int validate_rsp_hdr(struct se_if_priv *priv, u32 header,
> >> +                 uint8_t msg_id, uint8_t sz, bool is_base_api)
> >> +{
> >> +    int ret =3D -EINVAL;
> >> +    u32 size;
> >> +    u32 cmd;
> >> +    u32 tag;
> >> +    u32 ver;
> >> +
> >> +    tag =3D MSG_TAG(header);
> >> +    cmd =3D MSG_COMMAND(header);
> >> +    size =3D MSG_SIZE(header);
> >> +    ver =3D MSG_VER(header);
> >> +
> >> +    do {
> >> +            if (tag !=3D priv->rsp_tag) {
> >> +                    dev_err(priv->dev,
> >> +                            "MSG[0x%x] Hdr: Resp tag mismatch. (0x%x =
!=3D 0x%x)",
> >> +                            msg_id, tag, priv->rsp_tag);
> >> +                    break;
> >> +            }
> >> +
> >> +            if (cmd !=3D msg_id) {
> >> +                    dev_err(priv->dev,
> >> +                            "MSG Header: Cmd id mismatch. (0x%x !=3D =
0x%x)",
> >> +                            cmd, msg_id);
> >> +                    break;
> >> +            }
> >> +
> >> +            if (size !=3D (sz >> 2)) {
> >> +                    dev_err(priv->dev,
> >> +                            "MSG[0x%x] Hdr: Cmd size mismatch. (0x%x =
!=3D 0x%x)",
> >> +                            msg_id, size, (sz >> 2));
> >> +                    break;
> >> +            }
> >> +
> >> +            if (is_base_api && (ver !=3D priv->base_api_ver)) {
> >> +                    dev_err(priv->dev,
> >> +                            "MSG[0x%x] Hdr: Base API Vers mismatch. (=
0x%x !=3D
> 0x%x)",
> >> +                            msg_id, ver, priv->base_api_ver);
> >> +                    break;
> >> +            } else if (!is_base_api && ver !=3D priv->fw_api_ver) {
> >> +                    dev_err(priv->dev,
> >> +                            "MSG[0x%x] Hdr: FW API Vers mismatch. (0x=
%x !=3D 0x%x)",
> >> +                            msg_id, ver, priv->fw_api_ver);
> >> +                    break;
> >> +            }
> >> +
> >> +            ret =3D 0;
> >> +
> >> +    } while (false);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +int se_save_imem_state(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    int ret;
> >> +
> >> +    /* EXPORT command will save encrypted IMEM to given address,
> >> +     * so later in resume, IMEM can be restored from the given
> >> +     * address.
> >> +     *
> >> +     * Size must be at least 64 kB.
> >> +     */
> >> +    ret =3D ele_service_swap(dev,
> >> +                           priv->imem.phyaddr,
> >> +                           ELE_IMEM_SIZE,
> >> +                           ELE_IMEM_EXPORT);
> >> +    if (ret < 0)
> >> +            dev_err(dev, "Failed to export IMEM\n");
> >> +    else
> >> +            dev_info(dev,
> >> +                    "Exported %d bytes of encrypted IMEM\n",
> >> +                    ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +int se_restore_imem_state(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct soc_info s_info;
> >> +    int ret;
> >> +
> >> +    /* get info from ELE */
> >> +    ret =3D ele_get_info(dev, &s_info);
> >> +    if (ret) {
> >> +            dev_err(dev, "Failed to get info from ELE.\n");
> >> +            return ret;
> >> +    }
> >> +
> >> +    /* Get IMEM state, if 0xFE then import IMEM */
> >> +    if (s_info.imem_state =3D=3D ELE_IMEM_STATE_BAD) {
> >> +            /* IMPORT command will restore IMEM from the given
> >> +             * address, here size is the actual size returned by ELE
> >> +             * during the export operation
> >> +             */
> >> +            ret =3D ele_service_swap(dev,
> >> +                                   priv->imem.phyaddr,
> >> +                                   priv->imem.size,
> >> +                                   ELE_IMEM_IMPORT);
> >> +            if (ret) {
> >> +                    dev_err(dev, "Failed to import IMEM\n");
> >> +                    goto exit;
> >> +            }
> >> +    } else
> >> +            goto exit;
> >> +
> >> +    /* After importing IMEM, check if IMEM state is equal to 0xCA
> >> +     * to ensure IMEM is fully loaded and
> >> +     * ELE functionality can be used.
> >> +     */
> >> +    ret =3D ele_get_info(dev, &s_info);
> >> +    if (ret) {
> >> +            dev_err(dev, "Failed to get info from ELE.\n");
> >> +            goto exit;
> >> +    }
> >> +
> >> +    if (s_info.imem_state =3D=3D ELE_IMEM_STATE_OK)
> >> +            dev_info(dev, "Successfully restored IMEM\n");
> >> +    else
> >> +            dev_err(dev, "Failed to restore IMEM\n");
> >> +
> >> +exit:
> >> +    return ret;
> >> +}
> >> diff --git a/drivers/firmware/imx/ele_common.h
> b/drivers/firmware/imx/ele_common.h
> >> new file mode 100644
> >> index 000000000000..6e3a2114bb56
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/ele_common.h
> >> @@ -0,0 +1,43 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +
> >> +#ifndef __ELE_COMMON_H__
> >> +#define __ELE_COMMON_H__
> >> +
> >> +#include "se_ctrl.h"
> >> +
> >> +#define IMX_ELE_FW_DIR                 "imx/ele/"
> >> +
> >> +uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> >> +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv);
> >> +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> >> +                         void *tx_msg, int tx_msg_sz);
> >> +int imx_ele_msg_rcv(struct se_if_priv *priv);
> >> +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg);
> >> +int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *mssg);
> >> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> >> +int validate_rsp_hdr(struct se_if_priv *priv, unsigned int header,
> >> +                 u8 msg_id, u8 sz, bool is_base_api);
> >> +
> >> +/* Fill a command message header with a given command ID and length
> in bytes. */
> >> +static inline int plat_fill_cmd_msg_hdr(struct se_if_priv *priv,
> >> +                                    struct se_msg_hdr *hdr,
> >> +                                    u8 cmd,
> >> +                                    u32 len,
> >> +                                    bool is_base_api)
> >> +{
> >> +    hdr->tag =3D priv->cmd_tag;
> >> +    hdr->ver =3D (is_base_api) ? priv->base_api_ver : priv->fw_api_ve=
r;
> >> +    hdr->command =3D cmd;
> >> +    hdr->size =3D len >> 2;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +int se_save_imem_state(struct device *dev);
> >> +int se_restore_imem_state(struct device *dev);
> >> +
> >> +#endif /*__ELE_COMMON_H__ */
> >> diff --git a/drivers/firmware/imx/se_ctrl.c
> b/drivers/firmware/imx/se_ctrl.c
> >> new file mode 100644
> >> index 000000000000..11c5eaa7353f
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/se_ctrl.c
> >> @@ -0,0 +1,1339 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#include <linux/completion.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/dev_printk.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/export.h>
> >> +#include <linux/firmware.h>
> >> +#include <linux/firmware/imx/se_api.h>
> >> +#include <linux/genalloc.h>
> >> +#include <linux/init.h>
> >> +#include <linux/io.h>
> >> +#include <linux/miscdevice.h>
> >> +#include <linux/mod_devicetable.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/string.h>
> >> +#include <linux/sys_soc.h>
> >> +#include <uapi/linux/se_ioctl.h>
> >> +
> >> +#include "ele_base_msg.h"
> >> +#include "ele_common.h"
> >> +#include "se_ctrl.h"
> >> +
> >> +#define RESERVED_DMA_POOL           BIT(1)
> >> +
> >> +struct imx_se_node_info {
> >> +    u8 se_if_id;
> >> +    u8 se_if_did;
> >> +    u8 max_dev_ctx;
> >> +    u8 cmd_tag;
> >> +    u8 rsp_tag;
> >> +    u8 success_tag;
> >> +    u8 base_api_ver;
> >> +    u8 fw_api_ver;
> >> +    u8 *se_name;
> >> +    u8 *mbox_tx_name;
> >> +    u8 *mbox_rx_name;
> >> +    u8 *pool_name;
> >> +    u8 *fw_name_in_rfs;
> >> +    bool soc_register;
> >> +    bool reserved_dma_ranges;
> >> +    bool imem_mgmt;
> >> +};
> >> +
> >> +struct imx_se_node_info_list {
> >> +    u8 num_mu;
> >> +    u16 soc_id;
> >> +    u16 soc_rev;
> >> +    struct imx_se_node_info info[];
> >> +};
> >> +
> >> +static const struct imx_se_node_info_list imx8ulp_info =3D {
> >> +    .num_mu =3D 1,
> >> +    .soc_id =3D SOC_ID_OF_IMX8ULP,
> >> +    .info =3D {
> >> +                    {
> >> +                            .se_if_id =3D 2,
> >> +                            .se_if_did =3D 7,
> >> +                            .max_dev_ctx =3D 4,
> >> +                            .cmd_tag =3D 0x17,
> >> +                            .rsp_tag =3D 0xe1,
> >> +                            .success_tag =3D 0xd6,
> >> +                            .base_api_ver =3D MESSAGING_VERSION_6,
> >> +                            .fw_api_ver =3D MESSAGING_VERSION_7,
> >> +                            .se_name =3D "hsm1",
> >> +                            .mbox_tx_name =3D "tx",
> >> +                            .mbox_rx_name =3D "rx",
> >> +                            .pool_name =3D "sram",
> >> +                            .fw_name_in_rfs =3D IMX_ELE_FW_DIR\
> >> +                                              "mx8ulpa2ext-ahab-conta=
iner.img",
> >> +                            .soc_register =3D true,
> >> +                            .reserved_dma_ranges =3D true,
> >> +                            .imem_mgmt =3D true,
> >> +                    },
> >> +    },
> >> +};
> >> +
> >> +static const struct imx_se_node_info_list imx93_info =3D {
> >> +    .num_mu =3D 1,
> >> +    .soc_id =3D SOC_ID_OF_IMX93,
> >> +    .info =3D {
> >> +                    {
> >> +                            .se_if_id =3D 2,
> >> +                            .se_if_did =3D 3,
> >> +                            .max_dev_ctx =3D 4,
> >> +                            .cmd_tag =3D 0x17,
> >> +                            .rsp_tag =3D 0xe1,
> >> +                            .success_tag =3D 0xd6,
> >> +                            .base_api_ver =3D MESSAGING_VERSION_6,
> >> +                            .fw_api_ver =3D MESSAGING_VERSION_7,
> >> +                            .se_name =3D "hsm1",
> >> +                            .mbox_tx_name =3D "tx",
> >> +                            .mbox_rx_name =3D "rx",
> >> +                            .reserved_dma_ranges =3D true,
> >> +                            .imem_mgmt =3D true,
> >> +                            .soc_register =3D true,
> >> +                    },
> >> +    },
> >> +};
> >> +
> >> +static const struct of_device_id se_match[] =3D {
> >> +    { .compatible =3D "fsl,imx8ulp-ele", .data =3D (void *)&imx8ulp_i=
nfo},
> >> +    { .compatible =3D "fsl,imx93-ele", .data =3D (void *)&imx93_info}=
,
> >> +    {},
> >> +};
> >> +
> >> +static struct imx_se_node_info
> >> +            *get_imx_se_node_info(struct imx_se_node_info_list *info_=
list,
> >> +                                  const u32 idx)
> >> +{
> >> +    if (idx < 0 || idx > info_list->num_mu)
> >> +            return NULL;
> >> +
> >> +    return &info_list->info[idx];
> >> +}
> >> +
> >> +void *get_phy_buf_mem_pool(struct device *dev,
> >> +                       u8 *mem_pool_name,
> >> +                       dma_addr_t *buf,
> >> +                       u32 size)
> >> +{
> >> +    struct device_node *of_node =3D dev->of_node;
> >> +    struct gen_pool *mem_pool;
> >> +
> >> +    mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> >> +    if (!mem_pool) {
> >> +            dev_err(dev,
> >> +                    "Unable to get sram pool =3D %s\n",
> >> +                    mem_pool_name);
> >> +            return 0;
> >> +    }
> >> +
> >> +    return gen_pool_dma_alloc(mem_pool, size, buf);
> >> +}
> >> +
> >> +void free_phybuf_mem_pool(struct device *dev,
> >> +                      u8 *mem_pool_name,
> >> +                      u32 *buf,
> >> +                      u32 size)
> >> +{
> >> +    struct device_node *of_node =3D dev->of_node;
> >> +    struct gen_pool *mem_pool;
> >> +
> >> +    mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> >> +    if (!mem_pool)
> >> +            dev_err(dev,
> >> +                    "%s: Failed: Unable to get sram pool.\n",
> >> +                    __func__);
> >> +
> >> +    gen_pool_free(mem_pool, (u64)buf, size);
> >> +}
> >> +
> >> +static int imx_fetch_soc_info(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    struct imx_se_node_info_list *info_list;
> >> +    const struct imx_se_node_info *info;
> >> +    struct soc_device_attribute *attr;
> >> +    struct soc_device *sdev;
> >> +    struct soc_info s_info;
> >> +    int err =3D 0;
> >> +
> >> +    info =3D priv->info;
> >> +    info_list =3D (struct imx_se_node_info_list *)
> >> +                            device_get_match_data(dev->parent);
> >> +    if (info_list->soc_rev)
> >> +            return err;
> >> +
> >> +    err =3D ele_get_info(dev, &s_info);
> >> +    if (err)
> >> +            s_info.major_ver =3D DEFAULT_IMX_SOC_VER;
> >> +
> >> +    info_list->soc_rev =3D s_info.soc_rev;
> >> +
> >> +    if (!info->soc_register)
> >> +            return 0;
> >> +
> >> +    attr =3D devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> >> +    if (!attr)
> >> +            return -ENOMEM;
> >> +
> >> +    if (s_info.minor_ver)
> >> +            attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x.%x=
",
> >> +                                       s_info.major_ver,
> >> +                                       s_info.minor_ver);
> >> +    else
> >> +            attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x",
> >> +                                       s_info.major_ver);
> >> +
> >> +    switch (s_info.soc_id) {
> >> +    case SOC_ID_OF_IMX8ULP:
> >> +            attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> >> +                                          "i.MX8ULP");
> >> +            break;
> >> +    case SOC_ID_OF_IMX93:
> >> +            attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> >> +                                          "i.MX93");
> >> +            break;
> >> +    }
> >> +
> >> +    err =3D of_property_read_string(of_root, "model",
> >> +                                  &attr->machine);
> >> +    if (err) {
> >> +            devm_kfree(dev, attr);
> >> +            return -EINVAL;
> >> +    }
> >> +    attr->family =3D devm_kasprintf(dev, GFP_KERNEL, "Freescale i.MX"=
);
> >> +
> >> +    attr->serial_number
> >> +            =3D devm_kasprintf(dev, GFP_KERNEL, "%016llX", s_info.ser=
ial_num);
> >> +
> >> +    sdev =3D soc_device_register(attr);
> >> +    if (IS_ERR(sdev)) {
> >> +            devm_kfree(dev, attr->soc_id);
> >> +            devm_kfree(dev, attr->serial_number);
> >> +            devm_kfree(dev, attr->revision);
> >> +            devm_kfree(dev, attr->family);
> >> +            devm_kfree(dev, attr->machine);
> >> +            devm_kfree(dev, attr);
> >> +            return PTR_ERR(sdev);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/*
> >> + * File operations for user-space
> >> + */
> >> +
> >> +/* Write a message to the MU. */
> >> +static ssize_t se_if_fops_write(struct file *fp, const char __user *b=
uf,
> >> +                            size_t size, loff_t *ppos)
> >> +{
> >> +    struct se_api_msg *tx_msg __free(kfree);
> >> +    struct se_if_device_ctx *dev_ctx;
> >> +    struct se_if_priv *priv;
> >> +    int err;
> >> +
> >> +    dev_ctx =3D container_of(fp->private_data,
> >> +                           struct se_if_device_ctx,
> >> +                           miscdev);
> >> +    priv =3D dev_ctx->priv;
> >> +    dev_dbg(priv->dev,
> >> +            "%s: write from buf (%p)%zu, ppos=3D%lld\n",
> >> +                    dev_ctx->miscdev.name,
> >> +                    buf, size, ((ppos) ? *ppos : 0));
> >> +
> >> +    if (down_interruptible(&dev_ctx->fops_lock))
> >> +            return -EBUSY;
> >> +
> >> +    if (dev_ctx->status !=3D MU_OPENED) {
> >> +            err =3D -EINVAL;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    if (size < SE_MU_HDR_SZ) {
> >> +            dev_err(priv->dev,
> >> +                    "%s: User buffer too small(%zu < %d)\n",
> >> +                            dev_ctx->miscdev.name,
> >> +                            size, SE_MU_HDR_SZ);
> >> +            err =3D -ENOSPC;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    tx_msg =3D memdup_user((void __user *)ppos, size);
> >> +    if (!tx_msg) {
> >> +            err =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    /* Copy data to buffer */
> >> +    if (copy_from_user(tx_msg, buf, size)) {
> >> +            err =3D -EFAULT;
> >> +            dev_err(priv->dev,
> >> +                    "%s: Fail copy message from user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> >> +                         tx_msg, size, false);
> >> +
> >> +    err =3D imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> >> +
> >> +exit:
> >> +    up(&dev_ctx->fops_lock);
> >> +    return err;
> >> +}
> >> +
> >> +/*
> >> + * Read a message from the MU.
> >> + * Blocking until a message is available.
> >> + */
> >> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> >> +                           size_t size, loff_t *ppos)
> >> +{
> >> +    struct se_if_device_ctx *dev_ctx;
> >> +    struct se_buf_desc *b_desc;
> >> +    struct se_if_priv *priv;
> >> +    u32 size_to_copy;
> >> +    int err;
> >> +
> >> +    dev_ctx =3D container_of(fp->private_data,
> >> +                           struct se_if_device_ctx,
> >> +                           miscdev);
> >> +    priv =3D dev_ctx->priv;
> >> +    dev_dbg(priv->dev,
> >> +            "%s: read to buf %p(%zu), ppos=3D%lld\n",
> >> +                    dev_ctx->miscdev.name,
> >> +                    buf, size, ((ppos) ? *ppos : 0));
> >> +
> >> +    if (down_interruptible(&dev_ctx->fops_lock))
> >> +            return -EBUSY;
> >> +
> >> +    if (dev_ctx->status !=3D MU_OPENED) {
> >> +            err =3D -EINVAL;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    err =3D imx_ele_miscdev_msg_rcv(dev_ctx);
> >> +    if (err)
> >> +            goto exit;
> >> +
> >> +    /* Buffer containing the message from FW, is
> >> +     * allocated in callback function.
> >> +     * Check if buffer allocation failed.
> >> +     */
> >> +    if (!dev_ctx->temp_resp) {
> >> +            err =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    dev_dbg(priv->dev,
> >> +                    "%s: %s %s\n",
> >> +                    dev_ctx->miscdev.name,
> >> +                    __func__,
> >> +                    "message received, start transmit to user");
> >> +
> >> +    /*
> >> +     * Check that the size passed as argument is larger than
> >> +     * the one carried in the message.
> >> +     */
> >> +    size_to_copy =3D dev_ctx->temp_resp_size << 2;
> >> +    if (size_to_copy > size) {
> >> +            dev_dbg(priv->dev,
> >> +                    "%s: User buffer too small (%zu < %d)\n",
> >> +                            dev_ctx->miscdev.name,
> >> +                            size, size_to_copy);
> >> +            size_to_copy =3D size;
> >> +    }
> >> +
> >> +    /*
> >> +     * We may need to copy the output data to user before
> >> +     * delivering the completion message.
> >> +     */
> >> +    while (!list_empty(&dev_ctx->pending_out)) {
> >> +            b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out=
,
> >> +                                              struct se_buf_desc,
> >> +                                              link);
> >> +            if (!b_desc)
> >> +                    continue;
> >> +
> >> +            if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> >> +
> >> +                    dev_dbg(priv->dev,
> >> +                            "%s: Copy output data to user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +                    if (copy_to_user(b_desc->usr_buf_ptr,
> >> +                                     b_desc->shared_buf_ptr,
> >> +                                     b_desc->size)) {
> >> +                            dev_err(priv->dev,
> >> +                                    "%s: Failure copying output data =
to user.",
> >> +                                    dev_ctx->miscdev.name);
> >> +                            err =3D -EFAULT;
> >> +                            goto exit;
> >> +                    }
> >> +            }
> >> +
> >> +            if (b_desc->shared_buf_ptr)
> >> +                    memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> >> +
> >> +            __list_del_entry(&b_desc->link);
> >> +            kfree(b_desc);
> >> +    }
> >> +
> >> +    /* Copy data from the buffer */
> >> +    print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> >> +                         dev_ctx->temp_resp, size_to_copy, false);
> >> +    if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> >> +            dev_err(priv->dev,
> >> +                    "%s: Failed to copy to user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    err =3D size_to_copy;
> >> +    kfree(dev_ctx->temp_resp);
> >> +
> >> +    /* free memory allocated on the shared buffers. */
> >> +    dev_ctx->secure_mem.pos =3D 0;
> >> +    dev_ctx->non_secure_mem.pos =3D 0;
> >> +
> >> +    dev_ctx->pending_hdr =3D 0;
> >> +
> >> +exit:
> >> +    /*
> >> +     * Clean the used Shared Memory space,
> >> +     * whether its Input Data copied from user buffers, or
> >> +     * Data received from FW.
> >> +     */
> >> +    while (!list_empty(&dev_ctx->pending_in) ||
> >> +           !list_empty(&dev_ctx->pending_out)) {
> >> +            if (!list_empty(&dev_ctx->pending_in))
> >> +                    b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> >> +                                                      struct se_buf_d=
esc,
> >> +                                                      link);
> >> +            else
> >> +                    b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> >> +                                                      struct se_buf_d=
esc,
> >> +                                                      link);
> >> +
> >> +            if (!b_desc)
> >> +                    continue;
> >> +
> >> +            if (b_desc->shared_buf_ptr)
> >> +                    memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> >> +
> >> +            __list_del_entry(&b_desc->link);
> >> +            kfree(b_desc);
> >> +    }
> >> +
> >> +    up(&dev_ctx->fops_lock);
> >> +    return err;
> >> +}
> >> +
> >> +/* Give access to EdgeLock Enclave, to the memory we want to share */
> >> +static int se_if_setup_se_mem_access(struct se_if_device_ctx *dev_ctx=
,
> >> +                                 u64 addr, u32 len)
> >> +{
> >> +    /* Assuming EdgeLock Enclave has access to all the memory regions=
 */
> >> +    int ret =3D 0;
> >> +
> >> +    if (ret) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Fail find memreg\n", dev_ctx->miscdev.name);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    if (ret) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Fail set permission for resource\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            goto exit;
> >> +    }
> >> +
> >> +exit:
> >> +    return ret;
> >> +}
> >> +
> >> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> >> +                            u64 arg)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> >> +    struct imx_se_node_info *if_node_info;
> >> +    struct se_ioctl_get_if_info info;
> >> +    int err =3D 0;
> >> +
> >> +    if_node_info =3D (struct imx_se_node_info *)priv->info;
> >> +
> >> +    info.se_if_id =3D if_node_info->se_if_id;
> >> +    info.interrupt_idx =3D 0;
> >> +    info.tz =3D 0;
> >> +    info.did =3D if_node_info->se_if_did;
> >> +    info.cmd_tag =3D if_node_info->cmd_tag;
> >> +    info.rsp_tag =3D if_node_info->rsp_tag;
> >> +    info.success_tag =3D if_node_info->success_tag;
> >> +    info.base_api_ver =3D if_node_info->base_api_ver;
> >> +    info.fw_api_ver =3D if_node_info->fw_api_ver;
> >> +
> >> +    dev_dbg(priv->dev,
> >> +            "%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x=
]\n",
> >> +                    dev_ctx->miscdev.name,
> >> +                    info.se_if_id, info.interrupt_idx, info.tz, info.=
did);
> >> +
> >> +    if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed to copy mu info to user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +exit:
> >> +    return err;
> >> +}
> >> +
> >> +/*
> >> + * Copy a buffer of data to/from the user and return the address to u=
se in
> >> + * messages
> >> + */
> >> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_=
ctx,
> >> +                                        u64 arg)
> >> +{
> >> +    struct se_ioctl_setup_iobuf io =3D {0};
> >> +    struct se_shared_mem *shared_mem;
> >> +    struct se_buf_desc *b_desc;
> >> +    int err =3D 0;
> >> +    u32 pos;
> >> +
> >> +    if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed copy iobuf config from user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    dev_dbg(dev_ctx->priv->dev,
> >> +                    "%s: io [buf: %p(%d) flag: %x]\n",
> >> +                    dev_ctx->miscdev.name,
> >> +                    io.user_buf, io.length, io.flags);
> >> +
> >> +    if (io.length =3D=3D 0 || !io.user_buf) {
> >> +            /*
> >> +             * Accept NULL pointers since some buffers are optional
> >> +             * in FW commands. In this case we should return 0 as
> >> +             * pointer to be embedded into the message.
> >> +             * Skip all data copy part of code below.
> >> +             */
> >> +            io.ele_addr =3D 0;
> >> +            goto copy;
> >> +    }
> >> +
> >> +    /* Select the shared memory to be used for this buffer. */
> >> +    if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> >> +            /* App requires to use secure memory for this buffer.*/
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed allocate SEC MEM memory\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    } else {
> >> +            /* No specific requirement for this buffer. */
> >> +            shared_mem =3D &dev_ctx->non_secure_mem;
> >> +    }
> >> +
> >> +    /* Check there is enough space in the shared memory. */
> >> +    if (shared_mem->size < shared_mem->pos
> >> +                    || io.length >=3D shared_mem->size - shared_mem->=
pos) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Not enough space in shared memory\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    /* Allocate space in shared memory. 8 bytes aligned. */
> >> +    pos =3D shared_mem->pos;
> >> +    shared_mem->pos +=3D round_up(io.length, 8u);
> >> +    io.ele_addr =3D (u64)shared_mem->dma_addr + pos;
> >> +
> >> +    if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> >> +        !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> >> +            /*Add base address to get full address.*/
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed allocate SEC MEM memory\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    memset(shared_mem->ptr + pos, 0, io.length);
> >> +    if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> >> +        (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> >> +            /*
> >> +             * buffer is input:
> >> +             * copy data from user space to this allocated buffer.
> >> +             */
> >> +            if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> >> +                               io.length)) {
> >> +                    dev_err(dev_ctx->priv->dev,
> >> +                            "%s: Failed copy data to shared memory\n"=
,
> >> +                            dev_ctx->miscdev.name);
> >> +                    err =3D -EFAULT;
> >> +                    goto exit;
> >> +            }
> >> +    }
> >> +
> >> +    b_desc =3D kzalloc(sizeof(*b_desc), GFP_KERNEL);
> >> +    if (!b_desc) {
> >> +            err =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +copy:
> >> +    /* Provide the EdgeLock Enclave address to user space only if
> success.*/
> >> +    if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed to copy iobuff setup to user\n",
> >> +                            dev_ctx->miscdev.name);
> >> +            kfree(b_desc);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    if (b_desc) {
> >> +            b_desc->shared_buf_ptr =3D shared_mem->ptr + pos;
> >> +            b_desc->usr_buf_ptr =3D io.user_buf;
> >> +            b_desc->size =3D io.length;
> >> +
> >> +            if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> >> +                    /*
> >> +                     * buffer is input:
> >> +                     * add an entry in the "pending input buffers" li=
st so
> >> +                     * that copied data can be cleaned from shared me=
mory
> >> +                     * later.
> >> +                     */
> >> +                    list_add_tail(&b_desc->link, &dev_ctx->pending_in=
);
> >> +            } else {
> >> +                    /*
> >> +                     * buffer is output:
> >> +                     * add an entry in the "pending out buffers" list=
 so data
> >> +                     * can be copied to user space when receiving Sec=
ure-Enclave
> >> +                     * response.
> >> +                     */
> >> +                    list_add_tail(&b_desc->link, &dev_ctx->pending_ou=
t);
> >> +            }
> >> +    }
> >> +
> >> +exit:
> >> +    return err;
> >> +}
> >> +
> >> +/* IOCTL to provide SoC information */
> >> +static int se_ioctl_get_soc_info_handler(struct se_if_device_ctx
> *dev_ctx,
> >> +                                         u64 arg)
> >> +{
> >> +    struct imx_se_node_info_list *info_list;
> >> +    struct se_ioctl_get_soc_info soc_info;
> >> +    int err =3D -EINVAL;
> >> +
> >> +    info_list =3D (struct imx_se_node_info_list *)
> >> +                    device_get_match_data(dev_ctx->priv->dev->parent)=
;
> >> +    if (!info_list)
> >> +            goto exit;
> >> +
> >> +    soc_info.soc_id =3D info_list->soc_id;
> >> +    soc_info.soc_rev =3D info_list->soc_rev;
> >> +
> >> +    err =3D (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(so=
c_info));
> >> +    if (err) {
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed to copy soc info to user\n",
> >> +                    dev_ctx->miscdev.name);
> >> +            err =3D -EFAULT;
> >> +            goto exit;
> >> +    }
> >> +
> >> +exit:
> >> +    return err;
> >> +}
> >> +
> >> +/* Open a character device. */
> >> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> >> +{
> >> +    struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> >> +                                                    struct se_if_devi=
ce_ctx,
> >> +                                                    miscdev);
> >> +    int err;
> >> +
> >> +    /* Avoid race if opened at the same time */
> >> +    if (down_trylock(&dev_ctx->fops_lock))
> >> +            return -EBUSY;
> >> +
> >> +    /* Authorize only 1 instance. */
> >> +    if (dev_ctx->status !=3D MU_FREE) {
> >> +            err =3D -EBUSY;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    /*
> >> +     * Allocate some memory for data exchanges with S40x.
> >> +     * This will be used for data not requiring secure memory.
> >> +     */
> >> +    dev_ctx->non_secure_mem.ptr =3D dmam_alloc_coherent(dev_ctx->dev,
> >> +                                    MAX_DATA_SIZE_PER_USER,
> >> +                                    &dev_ctx->non_secure_mem.dma_addr=
,
> >> +                                    GFP_KERNEL);
> >> +    if (!dev_ctx->non_secure_mem.ptr) {
> >> +            err =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    err =3D se_if_setup_se_mem_access(dev_ctx,
> >> +                                      dev_ctx->non_secure_mem.dma_add=
r,
> >> +                                      MAX_DATA_SIZE_PER_USER);
> >> +    if (err) {
> >> +            err =3D -EPERM;
> >> +            dev_err(dev_ctx->priv->dev,
> >> +                    "%s: Failed to share access to shared memory\n",
> >> +                       dev_ctx->miscdev.name);
> >> +            goto free_coherent;
> >> +    }
> >> +
> >> +    dev_ctx->non_secure_mem.size =3D MAX_DATA_SIZE_PER_USER;
> >> +    dev_ctx->non_secure_mem.pos =3D 0;
> >> +    dev_ctx->status =3D MU_OPENED;
> >> +
> >> +    dev_ctx->pending_hdr =3D 0;
> >> +
> >> +    goto exit;
> >> +
> >> +free_coherent:
> >> +    dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> >> +                       dev_ctx->non_secure_mem.ptr,
> >> +                       dev_ctx->non_secure_mem.dma_addr);
> >> +
> >> +exit:
> >> +    up(&dev_ctx->fops_lock);
> >> +    return err;
> >> +}
> >> +
> >> +/* Close a character device. */
> >> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> >> +{
> >> +    struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> >> +                                                    struct se_if_devi=
ce_ctx,
> >> +                                                    miscdev);
> >> +    struct se_if_priv *priv =3D dev_ctx->priv;
> >> +    struct se_buf_desc *b_desc;
> >> +
> >> +    /* Avoid race if closed at the same time */
> >> +    if (down_trylock(&dev_ctx->fops_lock))
> >> +            return -EBUSY;
> >> +
> >> +    /* The device context has not been opened */
> >> +    if (dev_ctx->status !=3D MU_OPENED)
> >> +            goto exit;
> >> +
> >> +    /* check if this device was registered as command receiver. */
> >> +    if (priv->cmd_receiver_dev =3D=3D dev_ctx)
> >> +            priv->cmd_receiver_dev =3D NULL;
> >> +
> >> +    /* check if this device was registered as waiting response. */
> >> +    if (priv->waiting_rsp_dev =3D=3D dev_ctx) {
> >> +            priv->waiting_rsp_dev =3D NULL;
> >> +            mutex_unlock(&priv->se_if_cmd_lock);
> >> +    }
> >> +
> >> +    /* Unmap secure memory shared buffer. */
> >> +    if (dev_ctx->secure_mem.ptr)
> >> +            devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> >> +
> >> +    dev_ctx->secure_mem.ptr =3D NULL;
> >> +    dev_ctx->secure_mem.dma_addr =3D 0;
> >> +    dev_ctx->secure_mem.size =3D 0;
> >> +    dev_ctx->secure_mem.pos =3D 0;
> >> +
> >> +    /* Free non-secure shared buffer. */
> >> +    dmam_free_coherent(dev_ctx->priv->dev,
> MAX_DATA_SIZE_PER_USER,
> >> +                       dev_ctx->non_secure_mem.ptr,
> >> +                       dev_ctx->non_secure_mem.dma_addr);
> >> +
> >> +    dev_ctx->non_secure_mem.ptr =3D NULL;
> >> +    dev_ctx->non_secure_mem.dma_addr =3D 0;
> >> +    dev_ctx->non_secure_mem.size =3D 0;
> >> +    dev_ctx->non_secure_mem.pos =3D 0;
> >> +
> >> +    while (!list_empty(&dev_ctx->pending_in) ||
> >> +           !list_empty(&dev_ctx->pending_out)) {
> >> +            if (!list_empty(&dev_ctx->pending_in))
> >> +                    b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> >> +                                                      struct se_buf_d=
esc,
> >> +                                                      link);
> >> +            else
> >> +                    b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> >> +                                                      struct se_buf_d=
esc,
> >> +                                                      link);
> >> +
> >> +            if (!b_desc)
> >> +                    continue;
> >> +
> >> +            if (b_desc->shared_buf_ptr)
> >> +                    memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> >> +
> >> +            __list_del_entry(&b_desc->link);
> >> +            devm_kfree(dev_ctx->dev, b_desc);
> >> +    }
> >> +
> >> +    dev_ctx->status =3D MU_FREE;
> >> +
> >> +exit:
> >> +    up(&dev_ctx->fops_lock);
> >> +    return 0;
> >> +}
> >> +
> >> +/* IOCTL entry point of a character device */
> >> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long=
 arg)
> >> +//static long se_ioctl(struct file *fp, u32 cmd, u64 arg)
> >> +{
> >> +    struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> >> +                                                    struct se_if_devi=
ce_ctx,
> >> +                                                    miscdev);
> >> +    struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> >> +    int err =3D -EINVAL;
> >> +
> >> +    /* Prevent race during change of device context */
> >> +    if (down_interruptible(&dev_ctx->fops_lock))
> >> +            return -EBUSY;
> >> +
> >> +    switch (cmd) {
> >> +    case SE_IOCTL_ENABLE_CMD_RCV:
> >> +            if (!se_if_priv->cmd_receiver_dev) {
> >> +                    se_if_priv->cmd_receiver_dev =3D dev_ctx;
> >> +                    err =3D 0;
> >> +            }
> >> +            break;
> >> +    case SE_IOCTL_GET_MU_INFO:
> >> +            err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> >> +            break;
> >> +    case SE_IOCTL_SETUP_IOBUF:
> >> +            err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> >> +            break;
> >> +    case SE_IOCTL_GET_SOC_INFO:
> >> +            err =3D se_ioctl_get_soc_info_handler(dev_ctx, arg);
> >> +            break;
> >> +
> >> +    default:
> >> +            err =3D -EINVAL;
> >> +            dev_dbg(se_if_priv->dev,
> >> +                    "%s: IOCTL %.8x not supported\n",
> >> +                            dev_ctx->miscdev.name,
> >> +                            cmd);
> >> +    }
> >> +
> >> +    up(&dev_ctx->fops_lock);
> >> +    return (long)err;
> >> +}
> >> +
> >> +/* Char driver setup */
> >> +static const struct file_operations se_if_fops =3D {
> >> +    .open           =3D se_if_fops_open,
> >> +    .owner          =3D THIS_MODULE,
> >> +    .release        =3D se_if_fops_close,
> >> +    .unlocked_ioctl =3D se_ioctl,
> >> +    .read           =3D se_if_fops_read,
> >> +    .write          =3D se_if_fops_write,
> >> +};
> >> +
> >> +/* interface for managed res to free a mailbox channel */
> >> +static void if_mbox_free_channel(void *mbox_chan)
> >> +{
> >> +    mbox_free_channel(mbox_chan);
> >> +}
> >> +
> >> +/* interface for managed res to unregister a character device */
> >> +static void if_misc_deregister(void *miscdevice)
> >> +{
> >> +    misc_deregister(miscdevice);
> >> +}
> >> +
> >> +static int se_if_request_channel(struct device *dev,
> >> +                             struct mbox_chan **chan,
> >> +                             struct mbox_client *cl,
> >> +                             const u8 *name)
> >> +{
> >> +    struct mbox_chan *t_chan;
> >> +    int ret =3D 0;
> >> +
> >> +    t_chan =3D mbox_request_channel_byname(cl, name);
> >> +    if (IS_ERR(t_chan)) {
> >> +            ret =3D PTR_ERR(t_chan);
> >> +            if (ret !=3D -EPROBE_DEFER)
> >> +                    dev_err(dev,
> >> +                            "Failed to request chan %s ret %d\n", nam=
e,
> >> +                            ret);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    ret =3D devm_add_action(dev, if_mbox_free_channel, t_chan);
> >> +    if (ret) {
> >> +            dev_err(dev, "failed to add devm removal of mbox %s\n", n=
ame);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    *chan =3D t_chan;
> >> +
> >> +exit:
> >> +    return ret;
> >> +}
> >> +
> >> +static int se_probe_if_cleanup(struct platform_device *pdev)
> >> +{
> >> +    struct device *dev =3D &pdev->dev;
> >> +    struct se_if_priv *priv;
> >> +    int ret =3D 0;
> >> +    int i;
> >> +
> >> +    priv =3D dev_get_drvdata(dev);
> >> +    if (!priv) {
> >> +            ret =3D 0;
> >> +            dev_dbg(dev, "SE-MU Priv data is NULL;");
> >> +            return ret;
> >> +    }
> >> +
> >> +    if (priv->tx_chan)
> >> +            mbox_free_channel(priv->tx_chan);
> >> +    if (priv->rx_chan)
> >> +            mbox_free_channel(priv->rx_chan);
> >> +
> >> +    /* free the buffer in se remove, previously allocated
> >> +     * in se probe to store encrypted IMEM
> >> +     */
> >> +    if (priv->imem.buf) {
> >> +            dmam_free_coherent(dev,
> >> +                               ELE_IMEM_SIZE,
> >> +                               priv->imem.buf,
> >> +                               priv->imem.phyaddr);
> >> +            priv->imem.buf =3D NULL;
> >> +    }
> >> +
> >> +    if (priv->ctxs) {
> >> +            for (i =3D 0; i < priv->max_dev_ctx; i++) {
> >> +                    if (priv->ctxs[i]) {
> >> +                            devm_remove_action(dev,
> >> +                                               if_misc_deregister,
> >> +                                               &priv->ctxs[i]->miscde=
v);
> >> +                            misc_deregister(&priv->ctxs[i]->miscdev);
> >> +                            devm_kfree(dev, priv->ctxs[i]);
> >> +                    }
> >> +            }
> >> +            devm_kfree(dev, priv->ctxs);
> >> +    }
> >> +
> >> +    if (priv->flags & RESERVED_DMA_POOL) {
> >> +            of_reserved_mem_device_release(dev);
> >> +            priv->flags &=3D (~RESERVED_DMA_POOL);
> >> +    }
> >> +
> >> +    devm_kfree(dev, priv);
> >> +    of_node_put(dev->of_node);
> >> +    of_platform_device_destroy(dev, NULL);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int se_probe_cleanup(struct platform_device *pdev)
> >> +{
> >> +    struct device *dev =3D &pdev->dev;
> >> +    struct device_node *if_dn;
> >> +
> >> +    /* Enumerate se-interface device nodes. */
> >> +    for_each_child_of_node(dev->of_node, if_dn) {
> >> +            struct platform_device *if_pdev
> >> +                                    =3D of_find_device_by_node(if_dn)=
;
> >> +            if (se_probe_if_cleanup(if_pdev))
> >> +                    dev_err(dev,
> >> +                            "Failed to clean-up child node probe.\n")=
;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int init_device_context(struct device *dev)
> >> +{
> >> +    const struct imx_se_node_info *info;
> >> +    struct se_if_device_ctx *dev_ctx;
> >> +    struct se_if_priv *priv;
> >> +    u8 *devname;
> >> +    int ret =3D 0;
> >> +    int i;
> >> +
> >> +    priv =3D dev_get_drvdata(dev);
> >> +
> >> +    if (!priv) {
> >> +            ret =3D -EINVAL;
> >> +            dev_err(dev, "Invalid SE-MU Priv data");
> >> +            return ret;
> >> +    }
> >> +    info =3D priv->info;
> >> +
> >> +    priv->ctxs =3D devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_=
ctx,
> >> +                              GFP_KERNEL);
> >> +
> >> +    if (!priv->ctxs) {
> >> +            ret =3D -ENOMEM;
> >> +            return ret;
> >> +    }
> >> +
> >> +    /* Create users */
> >> +    for (i =3D 0; i < priv->max_dev_ctx; i++) {
> >> +            dev_ctx =3D devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNE=
L);
> >> +            if (!dev_ctx) {
> >> +                    ret =3D -ENOMEM;
> >> +                    return ret;
> >> +            }
> >> +
> >> +            dev_ctx->dev =3D dev;
> >> +            dev_ctx->status =3D MU_FREE;
> >> +            dev_ctx->priv =3D priv;
> >> +
> >> +            priv->ctxs[i] =3D dev_ctx;
> >> +
> >> +            /* Default value invalid for an header. */
> >> +            init_waitqueue_head(&dev_ctx->wq);
> >> +
> >> +            INIT_LIST_HEAD(&dev_ctx->pending_out);
> >> +            INIT_LIST_HEAD(&dev_ctx->pending_in);
> >> +            sema_init(&dev_ctx->fops_lock, 1);
> >> +
> >> +            devname =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> >> +                                     info->se_name, i);
> >> +            if (!devname) {
> >> +                    ret =3D -ENOMEM;
> >> +                    return ret;
> >> +            }
> >> +
> >> +            dev_ctx->miscdev.name =3D devname;
> >> +            dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> >> +            dev_ctx->miscdev.fops =3D &se_if_fops;
> >> +            dev_ctx->miscdev.parent =3D dev;
> >> +            ret =3D misc_register(&dev_ctx->miscdev);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to register misc device %d\n=
",
> >> +                            ret);
> >> +                    return ret;
> >> +            }
> >> +
> >> +            ret =3D devm_add_action(dev, if_misc_deregister,
> >> +                                  &dev_ctx->miscdev);
> >> +            if (ret) {
> >> +                    dev_err(dev,
> >> +                            "failed[%d] to add action to the misc-dev=
\n",
> >> +                            ret);
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void se_load_firmware(const struct firmware *fw, void *context=
)
> >> +{
> >> +    struct se_if_priv *priv =3D (struct se_if_priv *) context;
> >> +    const struct imx_se_node_info *info =3D priv->info;
> >> +    const u8 *se_fw_name =3D info->fw_name_in_rfs;
> >> +    phys_addr_t se_fw_phyaddr;
> >> +    u8 *se_fw_buf;
> >> +
> >> +    if (!fw) {
> >> +            if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> >> +                    dev_dbg(priv->dev,
> >> +                             "External FW not found, using ROM FW.\n"=
);
> >> +            else {
> >> +                    /*add a bit delay to wait for firmware priv relea=
sed */
> >> +                    msleep(20);
> >> +
> >> +                    /* Load firmware one more time if timeout */
> >> +                    request_firmware_nowait(THIS_MODULE,
> >> +                                    FW_ACTION_UEVENT, info->fw_name_i=
n_rfs,
> >> +                                    priv->dev, GFP_KERNEL, priv,
> >> +                                    se_load_firmware);
> >> +                    priv->fw_fail++;
> >> +                    dev_dbg(priv->dev, "Value of retries =3D 0x%x.\n"=
,
> >> +                            priv->fw_fail);
> >> +            }
> >> +
> >> +            return;
> >> +    }
> >> +
> >> +    /* allocate buffer to store the SE FW */
> >> +    se_fw_buf =3D dmam_alloc_coherent(priv->dev, fw->size,
> >> +                                     &se_fw_phyaddr,
> >> +                                     GFP_KERNEL);
> >> +    if (!se_fw_buf) {
> >> +            dev_err(priv->dev, "Failed to alloc SE fw buffer memory\n=
");
> >> +            goto exit;
> >> +    }
> >> +
> >> +    memcpy(se_fw_buf, fw->data, fw->size);
> >> +
> >> +    if (ele_fw_authenticate(priv->dev, se_fw_phyaddr))
> >> +            dev_err(priv->dev,
> >> +                    "Failed to authenticate & load SE firmware %s.\n"=
,
> >> +                    se_fw_name);
> >> +
> >> +exit:
> >> +    dmam_free_coherent(priv->dev,
> >> +                       fw->size,
> >> +                       se_fw_buf,
> >> +                       se_fw_phyaddr);
> >> +
> >> +    release_firmware(fw);
> >> +}
> >> +
> >> +static int se_if_probe(struct platform_device *pdev)
> >> +{
> >> +    struct imx_se_node_info_list *info_list;
> >> +    struct device *dev =3D &pdev->dev;
> >> +    struct imx_se_node_info *info;
> >> +    struct se_if_priv *priv;
> >> +    u32 idx;
> >> +    int ret;
> >> +
> >> +    if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> >> +            ret =3D -EINVAL;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    info_list =3D (struct imx_se_node_info_list *)
> >> +                    device_get_match_data(dev->parent);
> >> +    info =3D get_imx_se_node_info(info_list, idx);
> >> +
> >> +    priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +    if (!priv) {
> >> +            ret =3D -ENOMEM;
> >> +            goto exit;
> >> +    }
> >> +
> >> +    dev_set_drvdata(dev, priv);
> >> +
> >> +    /* Mailbox client configuration */
> >> +    priv->se_mb_cl.dev              =3D dev;
> >> +    priv->se_mb_cl.tx_block         =3D false;
> >> +    priv->se_mb_cl.knows_txdone     =3D true;
> >> +    priv->se_mb_cl.rx_callback      =3D se_if_rx_callback;
> >> +
> >> +    ret =3D se_if_request_channel(dev, &priv->tx_chan,
> >> +                    &priv->se_mb_cl, info->mbox_tx_name);
> >> +    if (ret) {
> >> +            if (ret =3D=3D -EPROBE_DEFER)
> >> +                    dev_err(dev, "Mailbox tx channel, is not ready.\n=
");
> >> +            else
> >> +                    dev_err(dev, "Failed to request tx channel\n");
> >> +
> >> +            goto exit;
> >> +    }
> >> +
> >> +    ret =3D se_if_request_channel(dev, &priv->rx_chan,
> >> +                    &priv->se_mb_cl, info->mbox_rx_name);
> >> +    if (ret) {
> >> +            if (ret =3D=3D -EPROBE_DEFER)
> >> +                    dev_err(dev, "Mailbox rx channel, is not ready.\n=
");
> >> +            else
> >> +                    dev_dbg(dev, "Failed to request rx channel\n");
> >> +
> >> +            goto exit;
> >> +    }
> >> +
> >> +    priv->dev =3D dev;
> >> +    priv->info =3D info;
> >> +
> >> +    /* Initialize the mutex. */
> >> +    mutex_init(&priv->se_if_lock);
> >> +    mutex_init(&priv->se_if_cmd_lock);
> >> +
> >> +    priv->cmd_receiver_dev =3D NULL;
> >> +    priv->waiting_rsp_dev =3D NULL;
> >> +    priv->max_dev_ctx =3D info->max_dev_ctx;
> >> +    priv->cmd_tag =3D info->cmd_tag;
> >> +    priv->rsp_tag =3D info->rsp_tag;
> >> +    priv->mem_pool_name =3D info->pool_name;
> >> +    priv->success_tag =3D info->success_tag;
> >> +    priv->base_api_ver =3D info->base_api_ver;
> >> +    priv->fw_api_ver =3D info->fw_api_ver;
> >> +
> >> +    init_completion(&priv->done);
> >> +    spin_lock_init(&priv->lock);
> >> +
> >> +    if (info->reserved_dma_ranges) {
> >> +            ret =3D of_reserved_mem_device_init(dev);
> >> +            if (ret) {
> >> +                    dev_err(dev,
> >> +                            "failed to init reserved memory region %d=
\n",
> >> +                            ret);
> >> +                    priv->flags &=3D (~RESERVED_DMA_POOL);
> >> +                    goto exit;
> >> +            }
> >> +            priv->flags |=3D RESERVED_DMA_POOL;
> >> +    }
> >> +
> >> +    if (info->fw_name_in_rfs) {
> >> +            ret =3D request_firmware_nowait(THIS_MODULE,
> >> +                                          FW_ACTION_UEVENT,
> >> +                                          info->fw_name_in_rfs,
> >> +                                          dev, GFP_KERNEL, priv,
> >> +                                          se_load_firmware);
> >> +            if (ret)
> >> +                    dev_warn(dev, "Failed to get firmware [%s].\n",
> >> +                             info->fw_name_in_rfs);
> >> +    }
> >> +
> >> +    ret =3D imx_fetch_soc_info(dev);
> >> +    if (ret) {
> >> +            dev_err(dev,
> >> +                    "failed[%d] to fetch SoC Info\n", ret);
> >> +            goto exit;
> >> +    }
> >> +
> >> +    if (info->imem_mgmt) {
> >> +            /* allocate buffer where SE store encrypted IMEM */
> >> +            priv->imem.buf =3D dmam_alloc_coherent(dev, ELE_IMEM_SIZE=
,
> >> +                                                 &priv->imem.phyaddr,
> >> +                                                 GFP_KERNEL);
> >> +            if (!priv->imem.buf) {
> >> +                    dev_err(dev,
> >> +                            "dmam-alloc-failed: To store encr-IMEM.\n=
");
> >> +                    ret =3D -ENOMEM;
> >> +                    goto exit;
> >> +            }
> >> +    }
> >> +
> >> +    if (info->max_dev_ctx) {
> >> +            ret =3D init_device_context(dev);
> >> +            if (ret) {
> >> +                    dev_err(dev,
> >> +                            "Failed[0x%x] to create device contexts.\=
n",
> >> +                            ret);
> >> +                    goto exit;
> >> +            }
> >> +    }
> >> +
> >> +    dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> >> +             info->se_name);
> >> +    return devm_of_platform_populate(dev);
> >> +
> >> +exit:
> >> +    /* if execution control reaches here, if probe fails.
> >> +     * hence doing the cleanup
> >> +     */
> >> +    if (se_probe_if_cleanup(pdev))
> >> +            dev_err(dev,
> >> +                    "Failed to clean-up the child node probe.\n");
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int se_probe(struct platform_device *pdev)
> >> +{
> >> +    struct device_node *enum_dev_node;
> >> +    struct device *dev =3D &pdev->dev;
> >> +    int enum_count;
> >> +    int ret;
> >> +
> >> +    enum_count =3D of_get_child_count(dev->of_node);
> >> +    if (!enum_count) {
> >> +            ret =3D -EINVAL;
> >> +            dev_err(dev, "Zero Tx/Rx path MU nodes.\n");
> >> +            return ret;
> >> +    }
> >> +
> >> +    for_each_child_of_node(dev->of_node, enum_dev_node) {
> >> +            struct platform_device *enum_plat_dev __maybe_unused;
> >> +
> >> +            if (!of_device_is_available(enum_dev_node))
> >> +                    continue;
> >> +
> >> +            enum_plat_dev =3D of_platform_device_create(enum_dev_node=
,
> >> +                                                      NULL,
> >> +                                                      dev);
> >> +            if (!enum_plat_dev) {
> >> +                    ret =3D -EINVAL;
> >> +                    of_node_put(enum_dev_node);
> >> +                    dev_err(dev,
> >> +                            "Failed to create enumerated platform dev=
ice.");
> >> +                    break;
> >> +            }
> >> +
> >> +            ret =3D se_if_probe(enum_plat_dev);
> >> +    }
> >> +    return ret;
> >> +}
> >> +
> >> +static int se_remove(struct platform_device *pdev)
> >> +{
> >> +    if (se_probe_cleanup(pdev))
> >> +            dev_err(&pdev->dev,
> >> +                    "i.MX Secure Enclave is not cleanly un-probed.");
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int se_suspend(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    const struct imx_se_node_info *info
> >> +                                    =3D priv->info;
> >> +
> >> +    if (info && info->imem_mgmt)
> >> +            priv->imem.size =3D se_save_imem_state(dev);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int se_resume(struct device *dev)
> >> +{
> >> +    struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >> +    const struct imx_se_node_info *info
> >> +                                    =3D priv->info;
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < priv->max_dev_ctx; i++)
> >> +            wake_up_interruptible(&priv->ctxs[i]->wq);
> >> +
> >> +    if (info && info->imem_mgmt)
> >> +            se_restore_imem_state(dev);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops se_pm =3D {
> >> +    RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
> >> +};
> >> +
> >> +static struct platform_driver se_driver =3D {
> >> +    .driver =3D {
> >> +            .name =3D "fsl-se-fw",
> >> +            .of_match_table =3D se_match,
> >> +            .pm =3D &se_pm,
> >> +    },
> >> +    .probe =3D se_probe,
> >> +    .remove =3D se_remove,
> >> +};
> >> +MODULE_DEVICE_TABLE(of, se_match);
> >> +
> >> +module_platform_driver(se_driver);
> >> +
> >> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> >> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/drivers/firmware/imx/se_ctrl.h
> b/drivers/firmware/imx/se_ctrl.h
> >> new file mode 100644
> >> index 000000000000..76e1ce77c52f
> >> --- /dev/null
> >> +++ b/drivers/firmware/imx/se_ctrl.h
> >> @@ -0,0 +1,151 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#ifndef SE_MU_H
> >> +#define SE_MU_H
> >> +
> >> +#include <linux/miscdevice.h>
> >> +#include <linux/semaphore.h>
> >> +#include <linux/mailbox_client.h>
> >> +
> >> +#define MAX_FW_LOAD_RETRIES         50
> >> +
> >> +#define MSG_TAG(x)                  (((x) & 0xff000000) >> 24)
> >> +#define MSG_COMMAND(x)                      (((x) & 0x00ff0000) >> 16=
)
> >> +#define MSG_SIZE(x)                 (((x) & 0x0000ff00) >> 8)
> >> +#define MSG_VER(x)                  ((x) & 0x000000ff)
> >> +#define RES_STATUS(x)                       ((x) & 0x000000ff)
> >> +#define MAX_DATA_SIZE_PER_USER              (65 * 1024)
> >> +#define S4_DEFAULT_MUAP_INDEX               (2)
> >> +#define S4_MUAP_DEFAULT_MAX_USERS   (4)
> >> +#define MESSAGING_VERSION_6         0x6
> >> +#define MESSAGING_VERSION_7         0x7
> >> +
> >> +#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
> >> +#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
> >> +
> >> +#define SE_MU_IO_FLAGS_USE_SEC_MEM  (0x02u)
> >> +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR       (0x04u)
> >> +
> >> +struct se_imem_buf {
> >> +    u8 *buf;
> >> +    phys_addr_t phyaddr;
> >> +    u32 size;
> >> +};
> >> +
> >> +struct se_buf_desc {
> >> +    u8 *shared_buf_ptr;
> >> +    u8 *usr_buf_ptr;
> >> +    u32 size;
> >> +    struct list_head link;
> >> +};
> >> +
> >> +/* Status of a char device */
> >> +enum se_if_dev_ctx_status_t {
> >> +    MU_FREE,
> >> +    MU_OPENED
> >> +};
> >> +
> >> +struct se_shared_mem {
> >> +    dma_addr_t dma_addr;
> >> +    u32 size;
> >> +    u32 pos;
> >> +    u8 *ptr;
> >> +};
> >> +
> >> +/* Private struct for each char device instance. */
> >> +struct se_if_device_ctx {
> >> +    struct device *dev;
> >> +    struct se_if_priv *priv;
> >> +    struct miscdevice miscdev;
> >> +
> >> +    enum se_if_dev_ctx_status_t status;
> >> +    wait_queue_head_t wq;
> >> +    struct semaphore fops_lock;
> >> +
> >> +    u32 pending_hdr;
> >> +    struct list_head pending_in;
> >> +    struct list_head pending_out;
> >> +
> >> +    struct se_shared_mem secure_mem;
> >> +    struct se_shared_mem non_secure_mem;
> >> +
> >> +    u32 *temp_resp;
> >> +    u32 temp_resp_size;
> >> +    struct notifier_block se_notify;
> >> +};
> >> +
> >> +/* Header of the messages exchange with the EdgeLock Enclave */
> >> +struct se_msg_hdr {
> >> +    u8 ver;
> >> +    u8 size;
> >> +    u8 command;
> >> +    u8 tag;
> >> +}  __packed;
> >> +
> >> +#define SE_MU_HDR_SZ        4
> >> +#define TAG_OFFSET  (SE_MU_HDR_SZ - 1)
> >> +#define CMD_OFFSET  (SE_MU_HDR_SZ - 2)
> >> +#define SZ_OFFSET   (SE_MU_HDR_SZ - 3)
> >> +#define VER_OFFSET  (SE_MU_HDR_SZ - 4)
> >> +
> >> +struct se_api_msg {
> >> +    u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
> >> +    u32 *data;
> >> +};
> >> +
> >> +struct se_if_priv {
> >> +    struct se_if_device_ctx *cmd_receiver_dev;
> >> +    struct se_if_device_ctx *waiting_rsp_dev;
> >> +    bool no_dev_ctx_used;
> >> +    /*
> >> +     * prevent parallel access to the se interface registers
> >> +     * e.g. a user trying to send a command while the other one is
> >> +     * sending a response.
> >> +     */
> >> +    struct mutex se_if_lock;
> >> +    /*
> >> +     * prevent a command to be sent on the se interface while another=
 one
> is
> >> +     * still processing. (response to a command is allowed)
> >> +     */
> >> +    struct mutex se_if_cmd_lock;
> >> +    struct device *dev;
> >> +    u8 *mem_pool_name;
> >> +    u8 cmd_tag;
> >> +    u8 rsp_tag;
> >> +    u8 success_tag;
> >> +    u8 base_api_ver;
> >> +    u8 fw_api_ver;
> >> +    u32 fw_fail;
> >> +    const void *info;
> >> +
> >> +    struct mbox_client se_mb_cl;
> >> +    struct mbox_chan *tx_chan, *rx_chan;
> >> +    struct se_api_msg *rx_msg;
> >> +    struct completion done;
> >> +    spinlock_t lock;
> >> +    /*
> >> +     * Flag to retain the state of initialization done at
> >> +     * the time of se-mu probe.
> >> +     */
> >> +    uint32_t flags;
> >> +    u8 max_dev_ctx;
> >> +    struct se_if_device_ctx **ctxs;
> >> +    struct se_imem_buf imem;
> >> +};
> >> +
> >> +void *get_phy_buf_mem_pool(struct device *dev,
> >> +                       u8 *mem_pool_name,
> >> +                       dma_addr_t *buf,
> >> +                       u32 size);
> >> +phys_addr_t get_phy_buf_mem_pool1(struct device *dev,
> >> +                             u8 *mem_pool_name,
> >> +                             u32 **buf,
> >> +                             u32 size);
> >> +void free_phybuf_mem_pool(struct device *dev,
> >> +                      u8 *mem_pool_name,
> >> +                      u32 *buf,
> >> +                      u32 size);
> >> +#endif
> >> diff --git a/include/linux/firmware/imx/se_api.h
> b/include/linux/firmware/imx/se_api.h
> >> new file mode 100644
> >> index 000000000000..c47f84906837
> >> --- /dev/null
> >> +++ b/include/linux/firmware/imx/se_api.h
> >> @@ -0,0 +1,14 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#ifndef __SE_API_H__
> >> +#define __SE_API_H__
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +#define SOC_ID_OF_IMX8ULP           0x084D
> >> +#define SOC_ID_OF_IMX93                     0x9300
> >> +
> >> +#endif /* __SE_API_H__ */
> >> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioc=
tl.h
> >> new file mode 100644
> >> index 000000000000..f68a36e9da2c
> >> --- /dev/null
> >> +++ b/include/uapi/linux/se_ioctl.h
> >> @@ -0,0 +1,88 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-=
3-
> Clause*/
> >> +/*
> >> + * Copyright 2024 NXP
> >> + */
> >> +
> >> +#ifndef SE_IOCTL_H
> >> +#define SE_IOCTL_H
> >> +
> >> +/* IOCTL definitions. */
> >> +
> >> +struct se_ioctl_setup_iobuf {
> >> +    u8 *user_buf;
> >> +    u32 length;
> >> +    u32 flags;
> >> +    u64 ele_addr;
> >> +};
> >> +
> >> +struct se_ioctl_shared_mem_cfg {
> >> +    u32 base_offset;
> >> +    u32 size;
> >> +};
> >> +
> >> +struct se_ioctl_get_if_info {
> >> +    u8 se_if_id;
> >> +    u8 interrupt_idx;
> >> +    u8 tz;
> >> +    u8 did;
> >> +    u8 cmd_tag;
> >> +    u8 rsp_tag;
> >> +    u8 success_tag;
> >> +    u8 base_api_ver;
> >> +    u8 fw_api_ver;
> >> +};
> >> +
> >> +struct se_ioctl_signed_message {
> >> +    u8 *message;
> >> +    u32 msg_size;
> >> +    u32 error_code;
> >> +};
> >> +
> >> +struct se_ioctl_get_soc_info {
> >> +    u16 soc_id;
> >> +    u16 soc_rev;
> >> +};
> >> +
> >> +/* IO Buffer Flags */
> >> +#define SE_IO_BUF_FLAGS_IS_OUTPUT   (0x00u)
> >> +#define SE_IO_BUF_FLAGS_IS_INPUT    (0x01u)
> >> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM (0x02u)
> >> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR      (0x04u)
> >> +#define SE_IO_BUF_FLAGS_IS_IN_OUT   (0x10u)
> >> +
> >> +/* IOCTLS */
> >> +#define SE_IOCTL                    0x0A /* like MISC_MAJOR. */
> >> +
> >> +/*
> >> + * ioctl to designated the current fd as logical-reciever.
> >> + * This is ioctl is send when the nvm-daemon, a slave to the
> >> + * firmware is started by the user.
> >> + */
> >> +#define SE_IOCTL_ENABLE_CMD_RCV     _IO(SE_IOCTL, 0x01)
> >> +
> >> +/*
> >> + * ioctl to get the buffer allocated from the memory, which is shared
> >> + * between kernel and FW.
> >> + * Post allocation, the kernel tagged the allocated memory with:
> >> + *  Output
> >> + *  Input
> >> + *  Input-Output
> >> + *  Short address
> >> + *  Secure-memory
> >> + */
> >> +#define SE_IOCTL_SETUP_IOBUF        _IOWR(SE_IOCTL, 0x03, \
> >> +                                    struct se_ioctl_setup_iobuf)
> >> +
> >> +/*
> >> + * ioctl to get the mu information, that is used to exchange message
> >> + * with FW, from user-spaced.
> >> + */
> >> +#define SE_IOCTL_GET_MU_INFO        _IOR(SE_IOCTL, 0x04, \
> >> +                                    struct se_ioctl_get_if_info)
> >> +/*
> >> + * ioctl to get SoC Info from user-space.
> >> + */
> >> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> >> +                                    struct se_ioctl_get_soc_info)
> >> +
> >> +#endif
> >>
> >> --
> >> 2.34.1
> >>
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
fe
> nse.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttp-
> 3A__lists.infradead.org_mailman_listinfo_linux-2Darm-
> 2Dkernel%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3DV_
> GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3DeKFfdy51aVVEAe4I9Lk2CN77y_4Hxf2pI_9fv5pVWLo9DwQNgC
> pca6smAwvwFycf%26s%3D187NgAc1LvHOnaB90o76OtTVe5J2eG-
> Y6Xgp05PQpBY%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C1
> 11dd89e61f149b5f7e708dc71290348%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638509668202255142%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C0%7C%7C%7C&sdata=3DsgoXx408lERnChy2nfitsuD8MiGHh%2FN2gTk9cdzqd
> 9w%3D&reserved=3D0


