Return-Path: <linux-kernel+bounces-177503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD08C3FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7E286922
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080E14D28E;
	Mon, 13 May 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPgEqe/e"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C214C586;
	Mon, 13 May 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599856; cv=fail; b=pgWWRsXb4r1CuPZqtHpWlcytltPvMWdoRpWTuSozbYQ00HMBu90FSQok9V/vK27scHZdPBy5arOs/MyXmlWa1Z2cE1UhYWaKqxMIlqw6KMNuQjIw0JYvVMiWm8M6XJe8RYLZedC1VcnNKV5YaF2B8MQTxS3AH+o4FKgtR4PZNJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599856; c=relaxed/simple;
	bh=uMjBPVCRo/nDdnOkMy8Y7fuNboOKK1eaHk5KGdl0yz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cj8pq6Z5zFhU/bAqcfRX2X+xacRr25QFod3ioo3R1tzJ9er9qDy9fKlRA4XLVhubenPwvZy6bpVmZV4FpB85TMBARPD18ILsM36Fqk2SyJbhyTMtkmZcw0FamSsbc2UqIhnPUl1vsUOcIAwk4fQhdEva6OLOrC8NRJzqNSIUN0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nPgEqe/e; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIGgjeKiYVkXtx85oOV8eNbBC+OAQnO/08quCMggqi9Zjg7G1w4pJPk+gOv7FXYNwRACoWgxNIpDNeRce9WBDsTm6gfClj9Adrf8BkPeQP8K2Ql/jWY7Ow+BC/uOXPRFYMsvwwp6DE4nK7GceJfn0RaKGoLxK54JnA4qOwgyPO11FUhy4hWL6MFxzL+vD3eCfSbgn+biLcmvhYPzg7U5hBMqgAnXJWHHQqdBGUc9lRhfSv0gEPvJ0hc8aC2WQykespqBX9nmYuVDSqFwqCHjF6HwBsjOa8NTLWgzyii0ZSvCPENpdWz97slwr431Dd4vVLdjY01DS0cMjzY8DU9Ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSpboAHr7ko5kvuxjqhW3gvPilKG9BkY5ZiZTWmaJXk=;
 b=Bx5lrME6tWuCaVN6yxKbtTdYHTsGXK8khIxIc3JwpWiFvKfJqApS6qqwfA4tolqR5Mown9U/NknY4cixvcgbXfQPRoUdAiNdLj1sabTePqD3bcuaFJ6I0unpVGDQtbF4oIvf+DsLeMpT9F4Rbc7i1vZvxrmkepU9vgMFyo6qjmOygqssA78AIL9d7QQAfl/xWOZvQaL5Vc9nvI1sN1rv80/aLfRtyXeU4VlOOrswE5XU6hqebqNP8ZVI4CQwr1StsAFHjbnOYBycuAo84TYucmivemp/4Q3Jj/MhSQFhLfqqhI2k6dJ9OfZNboIyugZvTr1km+UdBZQpjwows7YKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSpboAHr7ko5kvuxjqhW3gvPilKG9BkY5ZiZTWmaJXk=;
 b=nPgEqe/es6yE5Po9ey2sDCxSt1GDmcQEc/5qUxT1U+CLTp6Fza81eIscYRhctjZB/al4bztAO6PexgOTPYt/6mLNqKlZAAtoNqHb5DZfkCC+KQqiGINnI9vSKBYHl0w27DoadhJcsbpN5EbfSJLva6qeafdrvuK6M73aabFOUtg=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:30:48 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:30:47 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Topic: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Index: AQHaot4x2Q7iXJQ+y0OtihGrgo/RRLGU12GAgAAWYOA=
Date: Mon, 13 May 2024 11:30:47 +0000
Message-ID:
 <AM9PR04MB86044C0C60C11839EA79258395E22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
 <ZkHNixUeasNCBjMn@pengutronix.de>
In-Reply-To: <ZkHNixUeasNCBjMn@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DBAPR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 71343856-18e5-41cb-32df-08dc734022d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B3PPEobZixlBePrisac/ivxxoI1TOO8Kcr8rarHeArnUmEHwsTcwfa5QBuFd?=
 =?us-ascii?Q?2laVv6BbEkA7X17SwXMQ/+vlWzCgH8dfFnuummuq5j8EOuG3JZ2iito1YXZZ?=
 =?us-ascii?Q?vhASGLCfS26CCfMGPSXHuv5uRcumvbl7GtxJUxl2lkFTt1zGr3ZgIidy7VOE?=
 =?us-ascii?Q?PVIbC4zplgWTofuPPbR7RP213fdk3Bpy0/LvSdivFXD7gE+FFDUhCceXibyT?=
 =?us-ascii?Q?RJk9pOeTuMLBJ2iz1Bb/a2egppZY2xCwmCcEkfjzRyKQstkS3qrnT6Lhol5j?=
 =?us-ascii?Q?31hmd/DQQFAyO/3ioZ8e0yzpQWA57eG9mxUjJd1pQJp/JmnOwYawgLOJeSI8?=
 =?us-ascii?Q?TVplth+t41shOMSzAdUMSvyCDxMbICthY7m2sj/BVdr9v+xTtJ3f+zQwDCSP?=
 =?us-ascii?Q?JgBGpyObF/Q134CyUfMtysXUXp+/v7/QkZ4IFm/mU52Plp+3txAr+Xgd0/YW?=
 =?us-ascii?Q?nU4D9sAQRUS8AZ3SJ8BtK71ykFHaR3+Big81abOB35c6lmPo9fPAdJPhgtZI?=
 =?us-ascii?Q?ml+NtxqXpUeplkxHtmk5Zbxc5gNwP4rGuIXfWB72eT+vXfNCtYEjGuIK8rvJ?=
 =?us-ascii?Q?W55nEddwHTYe/u5O/P6TvZE1LvGhX8H8QiWxrlxvfFSNlYC2/JMFZCo+4Eaw?=
 =?us-ascii?Q?YFD+E7gqt/LWySuHHq5ia/CckyY77anWnBN27fbnR599A/7VnWYlomajQh9W?=
 =?us-ascii?Q?QBHA0LzPcjRBAxCYraEQYz9+YZtN073Dhef+w3urMj8Gdgfb4OG/COfE5Pe1?=
 =?us-ascii?Q?aPug2tmUY4oxqCcLI74wwwzacHiCfPhoKo54vAIkH/DTlQ0vZ006PNdIZ3C7?=
 =?us-ascii?Q?CVhf/ucRWf6B7nnZESqlVW0Cl6M+4LIEoUi8Rad+wmETT1Xn5YgfAtiub0CJ?=
 =?us-ascii?Q?vHCnaWNVaE/scm1AQYH/6fjav8jVXbyUXW3YcsB4Pp6ghPtQx9DIMovTyKa0?=
 =?us-ascii?Q?0K/Ad5Doc6jiDMSQ9Jwa7iYZkgwOuAExSWCjSY/UJtGFxw1l3669VcEDkzRv?=
 =?us-ascii?Q?gY13uwa2LDPJDN/6ZDOb5DR+4HnEr1jCRVkZFeaLY1g56SF7qr/9F+eB+DxE?=
 =?us-ascii?Q?FaEQzOBBfkO/oQQY/OA8YGUvce/YVAiYf8pCaOf0Pl341tcVr08SUJsUDz0r?=
 =?us-ascii?Q?fXwgQXMGce7yKylzdkvo5BSrrXap6YbmSmx+l5Y5eEmOrQyZPkXxpI4gP68C?=
 =?us-ascii?Q?APE3WHyit+vWjZlELYmu9nkaBUspKUIfxlNSryJ9dzFPQKpy6TmzFnl+Z0JI?=
 =?us-ascii?Q?cEnaIlUUbeF6er1PgSu4CJvRVKnWWVJHSltBgt9HBg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N2V7CSaTC/NNjcdMsPlKEN27IrwX62zGeNFxI+hO0JUkEJDxydaZpGz6iBZ3?=
 =?us-ascii?Q?65pc64hsLv7uifPFI3gTvagpmdq92FaEASj0MEuVc6oSSSCCAF2UKUQAglWd?=
 =?us-ascii?Q?hX9eVL2tIEEaxolXQqyMsTbgUU7M/h3Eb8fgmhYAwGedwn+nJS7uhBe9V8GQ?=
 =?us-ascii?Q?EgOb67MFWY+z5YA1q1iYq34vEs9C1WN5o9Iukna1usjEf4ScuGB9/gly58Po?=
 =?us-ascii?Q?wlA9SGIWBzaB6dvJBKi5Zdvz5KoaKkDrVi3IL7mUwBqW4WrmhCQFXs4UYNPa?=
 =?us-ascii?Q?1Zdst72DIrlIIR5dp7no1KW3Oq8GpaodiLythvpvlouY7FNbL6nx175djE8G?=
 =?us-ascii?Q?Q2CSzhI37aeoqHrxC+2n4e7IqHUoEd4CpNiuQ6FGz2+6+lbLcyZ4URgwW+0A?=
 =?us-ascii?Q?MntplG53tad2VuJiCeI3RwwSZGV56lVJsqSg8nlkihCIkn6lnlIQgcIlLubE?=
 =?us-ascii?Q?jByufvY74os2zh2r6PdXnyYduMigD0lutCmESlxBgWTNhR3+bGUs/Don+S2V?=
 =?us-ascii?Q?v2qTCCPc+5zFYTIzGoLiaU27rCC7rjmd1utXG1E/xOqBk9scNMkshi6uWAXU?=
 =?us-ascii?Q?LYI3DYhPcTpazsSdB3yS58Neiyh8FE9ldCkBBaYXKhi42wWGTkmfCfvH82ZA?=
 =?us-ascii?Q?jd9q0hqTBZeFdqi/MGzWLBmTkA7VftUHOFYO2uy9i564PL5byt3v9sYPf/It?=
 =?us-ascii?Q?6dL6IdWIvADiDjgt9756pRlhR34aANeSGH6WbKZOrkk/K537bR6+Ljwj4G2B?=
 =?us-ascii?Q?NIzeVyWWpPPlvXWUpSb5xuZnzexpIiK1b8El3v9cUZ7z56NwnapHUtgiJyij?=
 =?us-ascii?Q?eU5yPJBIlx03JH7be/oZ6DNuhM8WDwMANXslyiaVi3ZdeyhMOfShSUmUau3w?=
 =?us-ascii?Q?qmqqe27GpnkWqOicxWwlDDjrqqeRCkbp1/mly39d/tw5pdtYNq5De12ulFVq?=
 =?us-ascii?Q?gh7gfX3y1PSfB3WetAfgwb6b0CbRej9fiDH2L9sTJST0YFLIU0nUw4y9B6Tm?=
 =?us-ascii?Q?O832zpgFa4aixQ+X9YqWuxa5Z3/GaPYKgK5wEoyqA1lZaZaACY89v7PaMaJc?=
 =?us-ascii?Q?guDT1HYyxEA2PZa2oB4jTY+dxfwATcDxTGlZsFJEktxv6LCj/O1KLb5MNndI?=
 =?us-ascii?Q?ZkoezNhM3hFgQMBqMnP5x8H/mB+2VwXXf+kSj0cGhd8+ktX4OfCdhtRNRlMJ?=
 =?us-ascii?Q?8s/kDrcGhbx5QcnMlA8vx4UMFW8yfa/llG8kHeMp2AMFtiF8jfqXSuMHAFsP?=
 =?us-ascii?Q?9m6fjubKrwtb9Iif+fP2Lu7c8GykmsOby3QDIt4QYBp0n/iKrcbWyG+Pyrc2?=
 =?us-ascii?Q?mddxGFUMC0dL0cWYd68X0k1jPcEbq0cX3Q37WLENAp+gg3e+j9WgsuhefXEz?=
 =?us-ascii?Q?Cxle2UQsW8F/TJEJL9iu14iJrmFvUeOmY8ClMFkhWyuROfxZMpJzEnBQVWrZ?=
 =?us-ascii?Q?+IdJCC57wkJfBoPz/ILdMuyKWfgoTgR7Zdh8RzTs59wa+9Cn0AmvJIKhnrbP?=
 =?us-ascii?Q?E1HDPXYgiT9QenCSMNyXZITB8Oid+edhdiD37SZD6iaumGlImzbLkWWHyanQ?=
 =?us-ascii?Q?250DrP69bBpGjVelQ27UbLSi8OMJbhi8ZzwH0Eaz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71343856-18e5-41cb-32df-08dc734022d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 11:30:47.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /71cIobkPBQnlNi6Fm3K7RG31LkmB9iyOAvOqpTNGrPVSsqvc+IQxSF6NGXV6R2BNQVAPhWjcg/4pmsb/zCA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, May 13, 2024 1:52 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP EdgeLock
> Enclave
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, May 10, 2024 at 06:57:30PM +0530, Pankaj Gupta wrote:
> > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE), are
> > embedded in the SoC to support the features like HSM, SHE & V2X, using
> > message based communication interface.
> >
> > The secure enclave FW communicates on a dedicated messaging unit(MU)
> > based interface(s) with application core, where kernel is running.
> > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> >
> > This patch adds the driver for communication interface to
> > secure-enclave, for exchanging messages with NXP secure enclave HW
> > IP(s) like EdgeLock Enclave, both from:
> > - User-Space Applications via character driver.
> > - Kernel-space, used by kernel management layers like DM-Crypt.
> >
> > ABI documentation for the NXP secure-enclave driver.
>
> Several review comments inside, but stopping here. I just found v7 of thi=
s
> series. Could it be that you have resent an older version of this series =
instead
> of the new one??
>
> Sascha

No. It is the newer one.
>
> >
> > User-space library using this driver:
> > - i.MX Secure Enclave library:
> >   -- URL:
> > https://gith/
> > ub.com%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%
> >
> 40nxp.com%7C5b0ab58761f6472c092208dc7325b2cd%7C686ea1d3bc2b4c6f
> a92cd99
> >
> c5c301635%7C0%7C0%7C638511852968769687%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%
> >
> 7C&sdata=3D5NVV%2FQQQ6sg0UlTrPa5EeSD68JaDfRxCaCQa7LU%2FPS4%3D&r
> eserved=3D0
> > ,
> > - i.MX Secure Middle-Ware:
> >   -- URL:
> > https://gith/
> > ub.com%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7
> >
> C5b0ab58761f6472c092208dc7325b2cd%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7
> >
> C0%7C0%7C638511852968778134%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sd
> ata=3Dyk
> > cJAdYUUt2wvhRlAaN5EUmdqMmXqPq6srHkbSAqf1A%3D&reserved=3D0
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  Documentation/ABI/testing/se-cdev   |   42 ++
> >  drivers/firmware/imx/Kconfig        |   12 +
> >  drivers/firmware/imx/Makefile       |    2 +
> >  drivers/firmware/imx/ele_base_msg.c |  287 ++++++++
> >  drivers/firmware/imx/ele_base_msg.h |   70 ++
> >  drivers/firmware/imx/ele_common.c   |  341 +++++++++
> >  drivers/firmware/imx/ele_common.h   |   43 ++
> >  drivers/firmware/imx/se_ctrl.c      | 1339
> +++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h      |  151 ++++
> >  include/linux/firmware/imx/se_api.h |   14 +
> >  include/uapi/linux/se_ioctl.h       |   88 +++
> >  11 files changed, 2389 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/se-cdev
> > b/Documentation/ABI/testing/se-cdev
> > new file mode 100644
> > index 000000000000..699525af6b86
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/se-cdev
> > @@ -0,0 +1,42 @@
> > +What:                /dev/<se>_mu[0-9]+_ch[0-9]+
> > +Date:                May 2024
> > +KernelVersion:       6.8
> > +Contact:     linux-imx@nxp.com, pankaj.gupta@nxp.com
> > +Description:
> > +             NXP offers multiple hardware IP(s) for  secure-enclaves l=
ike
> EdgeLock-
> > +             Enclave(ELE), SECO. The character device file-descriptors
> > +             /dev/<se>_mu*_ch* are the interface between user-space NX=
P's
> secure-
> > +             enclave shared-library and the kernel driver.
> > +
> > +             The ioctl(2)-based ABI is defined and documented in
> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>
> > +              ioctl(s) are used primarily for:
> > +                     - shared memory management
> > +                     - allocation of I/O buffers
> > +                     - get mu info
> > +                     - setting a dev-ctx as receiver that is slave to =
fw
> > +                     - get SoC info
> > +
> > +             The following file operations are supported:
> > +
> > +             open(2)
> > +               Currently the only useful flags are O_RDWR.
> > +
> > +             read(2)
> > +               Every read() from the opened character device context i=
s waiting
> on
> > +               wakeup_intruptible, that gets set by the registered mai=
lbox
> callback
> > +               function; indicating a message received from the firmwa=
re on
> message-
> > +               unit.
> > +
> > +             write(2)
> > +               Every write() to the opened character device context ne=
eds to
> acquire
> > +               mailbox_lock, before sending message on to the message =
unit.
> > +
> > +             close(2)
> > +               Stops and free up the I/O contexts that was associated
> > +               with the file descriptor.
> > +
> > +Users:
> https://github/.
> com%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5b0ab58761f64
> 72c092208dc7325b2cd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638511852968783734%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3DJ0Ms9EmUe4pt2x199%2B6wydndbbzYlqg7XjWWgNOuwx8%3D
> &reserved=3D0,
> > +
> https://github/.
> com%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5b0ab58761f6472
> c092208dc7325b2cd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C638511852968788026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%
> 7C&sdata=3DLgk3Hasd5ZbkztPDnhfAel5Ivd1aLZZy26K4KB97rSw%3D&reserved=3D
> 0
> > +             crypto/skcipher,
> > +             drivers/nvmem/imx-ocotp-ele.c
> > diff --git a/drivers/firmware/imx/Kconfig
> > b/drivers/firmware/imx/Kconfig index 183613f82a11..56bdca9bd917
> 100644
> > --- a/drivers/firmware/imx/Kconfig
> > +++ b/drivers/firmware/imx/Kconfig
> > @@ -22,3 +22,15 @@ config IMX_SCU
> >
> >         This driver manages the IPC interface between host CPU and the
> >         SCU firmware running on M4.
> > +
> > +config IMX_SEC_ENCLAVE
> > +     tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmwar=
e
> driver."
> > +     depends on IMX_MBOX && ARCH_MXC && ARM64
> > +     default m if ARCH_MXC
> > +
> > +     help
> > +       It is possible to use APIs exposed by the iMX Secure Enclave HW=
 IP
> called:
> > +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > +          like base, HSM, V2X & SHE using the SAB protocol via the sha=
red
> Messaging
> > +          Unit. This driver exposes these interfaces via a set of file=
 descriptors
> > +          allowing to configure shared memory, send and receive messag=
es.
> > diff --git a/drivers/firmware/imx/Makefile
> > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_IMX_DSP)                +=3D imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)                +=3D imx-scu.o misc.o imx-scu-irq=
o rm.o
> imx-scu-soc.o
> > +sec_enclave-objs             =3D se_ctrl.o ele_common.o ele_base_msg.o
> > +obj-${CONFIG_IMX_SEC_ENCLAVE}        +=3D sec_enclave.o
> > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > b/drivers/firmware/imx/ele_base_msg.c
> > new file mode 100644
> > index 000000000000..0463f26d93c7
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_base_msg.c
> > @@ -0,0 +1,287 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/completion.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +
> > +int ele_get_info(struct device *dev, struct soc_info *s_info) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree);
> > +     struct se_api_msg *rx_msg __free(kfree);
> > +     phys_addr_t get_info_addr;
> > +     u32 *get_info_data;
> > +     u32 status;
> > +     int ret;
> > +
> > +     if (!priv || !s_info)
> > +             goto exit;
>
> ret and get_info_addr are used uninitialized when jumping to the exit lab=
el
> from here.
>
Will fix it in V2.

> > +
> > +     memset(s_info, 0x0, sizeof(*s_info));
> > +
> > +     if (priv->mem_pool_name)
> > +             get_info_data =3D get_phy_buf_mem_pool(dev,
> > +                                                  priv->mem_pool_name,
> > +                                                  &get_info_addr,
> > +                                                  ELE_GET_INFO_BUFF_SZ=
);
> > +     else
> > +             get_info_data =3D dmam_alloc_coherent(dev,
> > +                                                 ELE_GET_INFO_BUFF_SZ,
> > +                                                 &get_info_addr,
> > +                                                 GFP_KERNEL);
> > +     if (!get_info_data) {
> > +             ret =3D -ENOMEM;
> > +             dev_err(dev,
> > +                     "%s: Failed to allocate get_info_addr.\n",
> > +                     __func__);
> > +             goto exit;
> > +     }
> > +
> > +     tx_msg =3D kzalloc(ELE_GET_INFO_REQ_MSG_SZ << 2, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_GET_INFO_RSP_MSG_SZ << 2, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_GET_INFO_REQ,
> > +                                 ELE_GET_INFO_REQ_MSG_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D upper_32_bits(get_info_addr);
>
> How can this work without triggering a NULL pointer exception? struct
> se_api_msg is declared as:
>
> struct se_api_msg {
>         u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
>         u32 *data;
> };
>
> The memory for tx_msg is kzalloced above, so *data is a NULL pointer.

Buffer for tx_msg is allocated for " ELE_GET_INFO_REQ_MSG_SZ".
- First 32bit of this buffer will points to header, and
- From second 32 bit, it will be accessed as data.

Will replace u32* with u32 data[].

>
> > +     tx_msg->data[1] =3D lower_32_bits(get_info_addr);
> > +     tx_msg->data[2] =3D ELE_GET_INFO_READ_SZ;
> > +     priv->rx_msg =3D rx_msg;
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret  =3D validate_rsp_hdr(priv,
> > +                             priv->rx_msg->header,
> > +                             ELE_GET_INFO_REQ,
> > +                             ELE_GET_INFO_RSP_MSG_SZ,
> > +                             true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_GET_INFO_REQ, status);
> > +             ret =3D -1;
>
> Callers seem to expect an error code. Do you intend to return -EPERM here=
?

Accepted will. Intended error was to have "Operation failed.", instead of "=
Operation not permitted".
I think this is the closest.
Will Replace -1 with -EPERM.

>
> > +     }
> > +
> > +     s_info->imem_state =3D (get_info_data[ELE_IMEM_STATE_WORD]
> > +                             & ELE_IMEM_STATE_MASK) >> 16;
> > +     s_info->major_ver =3D
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> > +                             & SOC_VER_MASK) >> 24;
> > +     s_info->minor_ver =3D
> ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> > +                             & SOC_VER_MASK) >> 16) & 0xFF;
> > +     s_info->soc_rev =3D
> (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> > +                             & SOC_VER_MASK) >> 16;
> > +     s_info->soc_id =3D get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
> > +                             & SOC_ID_MASK;
> > +     s_info->serial_num
> > +             =3D (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] <<
> 32
> > +                     | get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF];
> > +exit:
> > +     if (get_info_addr) {
> > +             if (priv->mem_pool_name)
> > +                     free_phybuf_mem_pool(dev, priv->mem_pool_name,
> > +                                          get_info_data, ELE_GET_INFO_=
BUFF_SZ);
> > +             else
> > +                     dmam_free_coherent(dev,
> > +                                        ELE_GET_INFO_BUFF_SZ,
> > +                                        get_info_data,
> > +                                        get_info_addr);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +int ele_ping(struct device *dev)
> > +{
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree);
> > +     struct se_api_msg *rx_msg __free(kfree);
> > +     u32 status;
> > +     int ret;
> > +
> > +     tx_msg =3D kzalloc(ELE_PING_REQ_SZ << 2, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_PING_RSP_SZ << 2, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_PING_REQ, ELE_PING_REQ_SZ,
> > +                                 true);
> > +     if (ret) {
> > +             dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> > +             goto exit;
> > +     }
> > +
> > +     priv->rx_msg =3D rx_msg;
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret  =3D validate_rsp_hdr(priv,
> > +                             priv->rx_msg->header,
> > +                             ELE_PING_REQ,
> > +                             ELE_PING_RSP_SZ,
> > +                             true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_PING_REQ, status);
> > +             ret =3D -1;
> > +     }
> > +exit:
> > +     return ret;
> > +}
> > +
> > +int ele_service_swap(struct device *dev,
> > +                  phys_addr_t addr,
> > +                  u32 addr_size, u16 flag) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree);
> > +     struct se_api_msg *rx_msg __free(kfree);
> > +     u32 status;
> > +     int ret;
> > +
> > +     tx_msg =3D kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ << 2,
> GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ << 2, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_SERVICE_SWAP_REQ,
> > +                                 ELE_SERVICE_SWAP_REQ_MSG_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D flag;
> > +     tx_msg->data[1] =3D addr_size;
> > +     tx_msg->data[2] =3D ELE_NONE_VAL;
> > +     tx_msg->data[3] =3D lower_32_bits(addr);
> > +     tx_msg->data[4] =3D plat_add_msg_crc((uint32_t *)&tx_msg[0],
> > +                                              ELE_SERVICE_SWAP_REQ_MSG=
_SZ);
> > +     priv->rx_msg =3D rx_msg;
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret  =3D validate_rsp_hdr(priv,
> > +                             priv->rx_msg->header,
> > +                             ELE_SERVICE_SWAP_REQ,
> > +                             ELE_SERVICE_SWAP_RSP_MSG_SZ,
> > +                             true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_SERVICE_SWAP_REQ, status);
> > +             ret =3D -1;
> > +     } else {
> > +             if (flag =3D=3D ELE_IMEM_EXPORT)
> > +                     ret =3D priv->rx_msg->data[1];
> > +             else
> > +                     ret =3D 0;
> > +     }
> > +exit:
> > +
> > +     return ret;
> > +}
> > +
> > +int ele_fw_authenticate(struct device *dev, phys_addr_t addr) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree);
> > +     struct se_api_msg *rx_msg __free(kfree);
> > +     u32 status;
> > +     int ret;
> > +
> > +     tx_msg =3D kzalloc(ELE_FW_AUTH_REQ_SZ << 2, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_FW_AUTH_RSP_MSG_SZ << 2, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_FW_AUTH_REQ,
> > +                                 ELE_FW_AUTH_REQ_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D addr;
> > +     tx_msg->data[1] =3D 0x0;
> > +     tx_msg->data[2] =3D addr;
>
> Has this been tested?

Yes, it is tested.
This API is invoked while loading the secondary ELE firmware on i.MX8ULP.
If this API fails, then secondary FW loading failed. The tests that I ran b=
efore submitting this patch-set, will fail too.

> According to the documentation data[0] shall contain
> the upper 32bit of the address and data[1] shall contain the lower 32bit =
of the
> address.
Data[1] is for address extension, which is not used by i.MX8ULP.
Accepted and will correct it in v2.

>There is no data[2] for this call.
Not sure which document are you referring, but it is very much valid. This =
message is a 4 word message request.
Kindly re-check.

data[0], is the address of start of Container Header, that must be accessib=
le to ELE FW.
data[2], is actual address deduced from the array of the images part of con=
tainer.

In the current case, both are same.

>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5b0ab58
> 761f6472c092208dc7325b2cd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638511852968792139%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DhsZ%2B5pasElgn8fbcsSa81yEYT%2BHLKWiymdIlz47w9Uo
> %3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

