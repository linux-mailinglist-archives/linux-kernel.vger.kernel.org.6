Return-Path: <linux-kernel+bounces-541007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE7A4B760
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9727E16C2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E11B85FD;
	Mon,  3 Mar 2025 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X1tkI8U5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE57AD27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978429; cv=fail; b=mHAvB2Xe5bUvkgvUV0HXVZZ3uBnSWO0rNRVO0ZDbWWC96H6XXgwMXt5kA2YvMsyK/JXHrw202J47BPa4sGA4EPtMnknLjql7yx2yV2I7XNfZtLDti/pTvWywpGSg4mGMjAUHpO7RojnO/NXjqUwmDZVFES+2qj/ubfDrqFR0TOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978429; c=relaxed/simple;
	bh=nUkS7KdM/AnSdyptZRAxBLPd6M+hx8dyXDihZFKf688=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qj2pyIVxKbhsRwy6OHvO7vDlrReCZOus5tmOfWiyaUYwsA2r+KM1EnT1SZJU0BFN0xpx7jGjqb1xFINJCl9MnqyaCUfHSC7jymcgvX8syHrvraTvD3m/aHJVh89a1Y7n6qYsVkOHDqA+1JRR/sQPjC/yPKQ1w30U9DR86HGa3Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X1tkI8U5; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoQyy9+XsuPWny3QD1KRJm6PlYvnChUC/CHBis3wmSlpGR6yKZhsPNaTV0BeYr98FeXAv7Ca8RjkaBzGGoZ1+hWTRSBsdzkA8YJlbjMgwYAU2XQLJZBtVQJpc7HQoHZ8/++sBEzeHliDnydzV8X0Ym2YoqhMFtCSO3P/r4UQ4yp3HGOKv2X7LKRs4fkRb/A+gME8LDHaIE9K60i9lggCCf6Lp132YcuMBU8cpgqIiPIhnIvNj++Q7cKkj8phI6xu5SgRz2zK8/jyO9PImoGu6NwM+QHE7MsS+wT84UjzT47Txt3wioouCNG9MhwM2BTowZ8dROpUH1FqSHtychzU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1674ICgVE/zEsY9kaoK7VO7PWMsvOK2wAkhT/fB9Ulc=;
 b=ZfZ93Vf1AezhGaFopm4adXOh5gcfEVHsILZFaUdF2wE3C5OMBfHJDi7hbVTa7TV3sl2vTZDU44e4J6orUpfA0klDSI0pGKyy92DeR9YtfU28Slt1JMA9aZYVKVNEzMoNKhfDe0ldYuO7dl3pw1VHcXAj2lyEJ+O7+hH/0ZS4RsVIQ1vhBS2kBShoVz0tvLv6optYs2u3/43WqMhmBCYkvtA8PO16n9rSHVFcpiBoCggeMw+06jcDOhYSaG4DeQWqrLGfHSN95xkMlpQb969V1xCpyzYI1j5gNnrOToYbIeuuca0eWbOXuAXX0O+uEM92maeNfdQMIiSOkhBnXcRIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1674ICgVE/zEsY9kaoK7VO7PWMsvOK2wAkhT/fB9Ulc=;
 b=X1tkI8U5ZyAWzcw1XB3HDv73w6NDFnU/JlXffOfHfaC2WUr9wQluJn9LcnwgMOwUmNsgoAUkoBXncusoju4Ttxb03wTzJdTrdodCr0nii8vewsl60E2uEL5rEYvYs8nEWFKzSbdEX/dD3ZVDMGTMGcUSjAS/fT2bXFwWsqfjc99R9mVOPvWbQRYd68mmfGhlPT+CZHUWhQofqPxsB7S8bP5c+YSZpZ6MEYLrKYSRMwpcpzd5uNH6wYFMva0BTsMazs7kMHDmMViqfhs+AXqozuW3dCERbN4VmPXuuLuHKd6W7DppCAddkMGC5VJruFD66XozZS3Mo6Al9n6WLxYz0g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 05:07:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 05:07:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: kernel test robot <lkp@intel.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>
Subject: RE: drivers/remoteproc/omap_remoteproc.c:732: warning: Function
 parameter or struct member 'is_iomem' not described in 'omap_rproc_da_to_va'
Thread-Topic: drivers/remoteproc/omap_remoteproc.c:732: warning: Function
 parameter or struct member 'is_iomem' not described in 'omap_rproc_da_to_va'
Thread-Index: AQHbivhIKfgrboY4KUaSYYetbjTpHrNg3fcw
Date: Mon, 3 Mar 2025 05:07:03 +0000
Message-ID:
 <PAXPR04MB84590CDADF15777AF08B426288C92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <202503020637.6SBId7IR-lkp@intel.com>
In-Reply-To: <202503020637.6SBId7IR-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB7184:EE_
x-ms-office365-filtering-correlation-id: f040afde-bdc5-4d5e-4c84-08dd5a113cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xiFnAQS3sJ7+Xh9KOB3ftMrjUaEixLUq4vP0nKwrvYjiz6NI6wsPuvEJ8NQM?=
 =?us-ascii?Q?negoQ17O4SsQJhs3uUOiKwMnbSFlG49si/cGOyf063mtMU9E4vgM+2XqaAGz?=
 =?us-ascii?Q?ceyJC+wVjWZ6uwTASMzn6ZnQ6vXETyu7YK/C84YivQ+2/h4Sdw9B9b7rZwuZ?=
 =?us-ascii?Q?VkoBnqMlbb+K7Q+triccBn8NPcm3+lv846Ht1nCnaSRLB5kiT24Zzdh2TLCQ?=
 =?us-ascii?Q?m7psXam7stNRVAvQvjNEC+bVqkMLJgiGLYV23wDJMb4UOMTgNWSPOLpB8k+m?=
 =?us-ascii?Q?akTRJmli53UbT44uXusj3nmoeHvPXPlTMb16llT5efBctAFXL+Rn6wTP7m9C?=
 =?us-ascii?Q?UmoN0ytoX3bkUfhP062fuPdY69KFB96hbhzvPHola4t+Xhh+v9mC6zI6LtO5?=
 =?us-ascii?Q?8Ik9bSpc0SibhnoaAVrHZg/gP7gwhDmljAFRz7f9TjmhS0c+RU7hhtd5uNtX?=
 =?us-ascii?Q?0Vo9PFgzTSwLiksmnpxaF2K9uLYqn0z7lApzrB3onuzyt8MtvsfV5qMqaSVg?=
 =?us-ascii?Q?M8j7oUkFt+8uQihZaCYOIvDXloI+tGSqgmiPgQ4b7Xsv09tAJoUnLLm1Pb7h?=
 =?us-ascii?Q?GD6gb1MkIX52LpiZoG5DhKzDbRi+D0590dHes8bVJcJUTFglaAMGcrOufmfc?=
 =?us-ascii?Q?Idn+DAdUWic4GQb1gFtv4aKxYJL1wWDtV0r6YJqPH8jvKpXNfbzgrdbN5YB4?=
 =?us-ascii?Q?iku6Npft596wWL9EhOV+MC61J8eyNi4jNAv95p6zS+kiNFKAIEGRg7a6B0lM?=
 =?us-ascii?Q?V3blm6+/nZwRJKpGDXoCOqbu+MkqZUVPCr3dsjuEJikrSdH6LxRhxGlfbTBW?=
 =?us-ascii?Q?K1Z+u4Z9Qy2rGhEu3XGebJ+Ng+dT4eMUACtS2mPL5BPqw3I8F320YJVnAH10?=
 =?us-ascii?Q?Iqt7SNv06RJeSdQ4T7/iYswaM07tWYTna5OP1WBFbd7DiHuPknrRv2u88zY5?=
 =?us-ascii?Q?DhvoOWeONjflCx8jVXCDWN3N7RbefCK2KCvGOJ6FDzly5DiCDMyY7ASWTqCf?=
 =?us-ascii?Q?oosirGb2EeLhcJzLcwB3Xw/8v9iZ3LrtBiFM3Zy+XO0c1W3qT5J2CpaOiqT0?=
 =?us-ascii?Q?oegx0QX6B1LDLD+wgbQOwRkhoZ5OFmSiDLLwIUVVNu9bdIASs5CAaTec0yiZ?=
 =?us-ascii?Q?C2x2lZMxXVAzOJcdjPu+jpZqAVJ4HbzipcvLFaK8C3qCW6t3c9Hga+k4WPuq?=
 =?us-ascii?Q?4IEr7db5q0xmn8Zd1Ja9SqaN0usHqJw/1C/dr8Ugdpz3mmpsDtXUHLzv0vbL?=
 =?us-ascii?Q?D9NZutbrP5RCiZd6rTerTJcCYVlDOOqJhcS0sXzwIQUKaoQq0bQaVDJZRljU?=
 =?us-ascii?Q?vppjUIULFOKsjFoFtiZiTFVtzqfIcyzZWqoAbLPuELTf+yHe43yEuUTyNrxr?=
 =?us-ascii?Q?7aftBqP19HnW2n5OoVHqq0qn/k9u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fVJFJ0AUBMS/lu15fiTOu1/dADd1LITghQsS+rscIxGvPwlJ22e7jTtYOG1N?=
 =?us-ascii?Q?ddp7OINxlflM/GRzKGFzn01kRwiUBN1jYf2xrySipDwRswJYWgDXAdaHZnv+?=
 =?us-ascii?Q?OAMPzYSlE0gmL3qYH5hDMOEJlUa4c8L4h35uOgHn9wGVQi66KI5rfhNSb/gP?=
 =?us-ascii?Q?op5aUNi5mg1jYPjNfCsa95bP2quTo0WbOCGK6jg60GNhbFU1Wgj05L1cneiJ?=
 =?us-ascii?Q?TNtNW9MfsUY+3ZUpvD3LL2l/s2+jfSWLcvjmyYiqddS0i+umr/ngDoWaISdg?=
 =?us-ascii?Q?tUtADs+VxoKXisBA1I3PXxylizmFtjmHmYVqEeVtbva+gy6z0XUHUe+ZNJ+J?=
 =?us-ascii?Q?qosStvvYyCOBEOqRLpkR9z1z/LrKoW7ju8++fBtxyiXEWHvKgrKalVqkHijJ?=
 =?us-ascii?Q?tSR0jnDlp2Yk6Cdmfy2raYbAebhCinVITbTLJQlXHHxiS0KqFXTUgrMTevZz?=
 =?us-ascii?Q?NIttU7yzP3jz+obTCeBuDUVyi3z8z12+DqferNlIM1Z+I7jHS4tLEMtq2ivy?=
 =?us-ascii?Q?cAjppCSHCJMV1ow4uUkpJiAsJOCRIqTSvOs2WnRm1C03ZqYTVW0QJDftmAQw?=
 =?us-ascii?Q?mEj1CepjpqKbEicS005syaT13SP93DD+QL+IW1H+tTa1la8B1dxVdyXH7Lpl?=
 =?us-ascii?Q?Y1+wokDMhZ7mtxROWAY7HcAdSfFrPU1G3MNWbedW+zKs+ssY37v1j57uC+fx?=
 =?us-ascii?Q?0O5giVUIy2Hvz4ftp9NZOuDDCsAqR6oDp7bBMa5QC1O4XnbFa25PCt3uYk9W?=
 =?us-ascii?Q?g6D3oPtYKNrQWiIu9M7QK4b0JYViluiI9OCAnP6j3MSwiHpx53/TN/9ohJR1?=
 =?us-ascii?Q?cjCFeqlqGL6MfqaIQgjhwycQc6bmdb9HME+Nm5tBvVzBb/Ssg6wg6k3N6Lu7?=
 =?us-ascii?Q?Joo+7b50vEM0PYRG9iHsjDqmqP9zsJkbuiDUvJLFFVrIppyo4sL2LaTQ/eIC?=
 =?us-ascii?Q?Cgwwuq78rmGIGeKG/rZlXOn9jxffsNlqYojk/vf6UUQlsAmpBS1wTVDLtNqZ?=
 =?us-ascii?Q?TSAC1dchwvNGxdMjc7ASgGME8sYvD1fL5Rp4A2hMey2VtZUqGX6CWJAUt9uC?=
 =?us-ascii?Q?9GvoMm/m0f4pgYOM99Va8p4LApG1sPiDQfCGs96FzAvIUzU28Lpgcu8HK4Jv?=
 =?us-ascii?Q?UL/FMWIk7t/gZ1tz+sCSfRIfVYekSzurlcDkS/VBcbF+QltJXHiXTDrPxYHk?=
 =?us-ascii?Q?18HFNYFn8I+XweCSIbfz1NR5b2ESnKWFkuIn88IAb2iJJ4Q4/RxfxOCp7g9y?=
 =?us-ascii?Q?8qWH0eN9YuYwBv/qQEIROUzhOmSG3mOXUFilJp+qsNcabIGDFesAHC9L+5OA?=
 =?us-ascii?Q?6VPqcSBf2n/i7/jv21BQJrpoabRGCfp5+OifPT9N7CJL8ueH156o4PWpTxRl?=
 =?us-ascii?Q?8MGa+oWX3spFS5dfhoC0i69fiv4TMjff5G6eX1nuuaViobo2SD/KQ2JdKwPu?=
 =?us-ascii?Q?O5q2jWK4Ne+gVYSc761qf+wo9FcZD+QGlOdbZxs9DskoytVihHCaI8U6YaPk?=
 =?us-ascii?Q?ZGC7kFnKAB3EHf1oD2hAGDmnlGjV7Kca8/0wVcqFQqW7IWHRdl6v4zvpKofh?=
 =?us-ascii?Q?yB74MA1+o1MGhCWQlYU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f040afde-bdc5-4d5e-4c84-08dd5a113cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 05:07:03.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YaBtPZH8zglFqNqQiqd41iYpJD5iANZZqJCEjQqx2DmqltSWY6RlQxgSlEsm18QM4CMAYmd1lBHddKfjD0L2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184

> Subject: drivers/remoteproc/omap_remoteproc.c:732: warning:
> Function parameter or struct member 'is_iomem' not described in
> 'omap_rproc_da_to_va'

Please drop this warning, Fix has been picked up, see
https://lore.kernel.org/all/Z7yc4vxYkTMhSWni@p14s/

Thanks,
Peng

>=20
> Hi Peng,
>=20
> FYI, the error/warning still remains.
>=20
> tree:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> git.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2
> Flinux.git&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C50009dcabea4
> 4860b0c008dd590f683f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638764644912563206%7CUnknown%7CTWFpbGZsb3d8e
> yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsI
> kFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DqoPgVy
> Jgg36vRNE5HECHYX%2FpAc0T471cj5162D7pc0o%3D&reserved=3D0
> master
> head:   df87d843c6eb4dad31b7bf63614549dd3521fe71
> commit: 40df0a91b2a5228ded8e5f75b80d28c96c6831cd remoteproc:
> add is_iomem to da_to_va
> date:   4 years ago
> config: arm-randconfig-c041-20230507
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> Fdownload.01.org%2F0day-
> ci%2Farchive%2F20250302%2F202503020637.6SBId7IR-
> lkp%40intel.com%2Fconfig&data=3D05%7C02%7Cpeng.fan%40nxp.com
> %7C50009dcabea44860b0c008dd590f683f%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C638764644912581628%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC
> IsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C
> %7C&sdata=3DFEvXgw%2BRm6Io1k9t9QKIdZwSqOgoQDtX9XPZtQLaWO
> M%3D&reserved=3D0)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0 reproduce (this is a W=3D1
> build):
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> Fdownload.01.org%2F0day-
> ci%2Farchive%2F20250302%2F202503020637.6SBId7IR-
> lkp%40intel.com%2Freproduce&data=3D05%7C02%7Cpeng.fan%40nxp.c
> om%7C50009dcabea44860b0c008dd590f683f%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638764644912593266%7CUnknow
> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C&sdata=3DiDgsV8XXWjRwQftnAuBAzWJFZDAzZyfGcwgXitoHYao%3
> D&reserved=3D0)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> | .kernel.org%2Foe-kbuild-all%2F202503020637.6SBId7IR-
> lkp%40intel.com%2F
> |
> &data=3D05%7C02%7Cpeng.fan%40nxp.com%7C50009dcabea44860b0c
> 008dd590f683f%
> |
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6387646449
> 12604520%7CUnkn
> |
> own%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
> AwMCIsIlAiOiJX
> |
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3DOOJ0eCr4Co
> | iX2DC3nTDyKIKUGLIS8Z7Lbnm140ZB7uk%3D&reserved=3D0
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/remoteproc/omap_remoteproc.c:732: warning: Function
> parameter or struct member 'is_iomem' not described in
> 'omap_rproc_da_to_va'
>=20
>=20
> vim +732 drivers/remoteproc/omap_remoteproc.c
>=20
> 34ed5a33b1218e Ohad Ben-Cohen 2011-10-20  716
> 530a1b57e8590f Suman Anna     2020-03-24  717  /**
> 530a1b57e8590f Suman Anna     2020-03-24  718   *
> omap_rproc_da_to_va() - internal memory translation helper
> 530a1b57e8590f Suman Anna     2020-03-24  719   * @rproc: remote
> processor to apply the address translation for
> 530a1b57e8590f Suman Anna     2020-03-24  720   * @da: device
> address to translate
> 530a1b57e8590f Suman Anna     2020-03-24  721   * @len: length of
> the memory buffer
> 530a1b57e8590f Suman Anna     2020-03-24  722   *
> 530a1b57e8590f Suman Anna     2020-03-24  723   * Custom function
> implementing the rproc .da_to_va ops to provide address
> 530a1b57e8590f Suman Anna     2020-03-24  724   * translation
> (device address to kernel virtual address) for internal RAMs
> 530a1b57e8590f Suman Anna     2020-03-24  725   * present in a DSP
> or IPU device). The translated addresses can be used
> 530a1b57e8590f Suman Anna     2020-03-24  726   * either by the
> remoteproc core for loading, or by any rpmsg bus drivers.
> 530a1b57e8590f Suman Anna     2020-03-24  727   *
> 530a1b57e8590f Suman Anna     2020-03-24  728   * Return:
> translated virtual address in kernel memory space on success,
> 530a1b57e8590f Suman Anna     2020-03-24  729   *         or NULL on
> failure.
> 530a1b57e8590f Suman Anna     2020-03-24  730   */
> 40df0a91b2a522 Peng Fan       2021-03-06  731  static void
> *omap_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool
> *is_iomem)
> 530a1b57e8590f Suman Anna     2020-03-24 @732  {
> 530a1b57e8590f Suman Anna     2020-03-24  733  	struct
> omap_rproc *oproc =3D rproc->priv;
> 530a1b57e8590f Suman Anna     2020-03-24  734  	int i;
> 530a1b57e8590f Suman Anna     2020-03-24  735  	u32 offset;
> 530a1b57e8590f Suman Anna     2020-03-24  736
> 530a1b57e8590f Suman Anna     2020-03-24  737  	if (len <=3D 0)
> 530a1b57e8590f Suman Anna     2020-03-24  738
> 	return NULL;
> 530a1b57e8590f Suman Anna     2020-03-24  739
> 530a1b57e8590f Suman Anna     2020-03-24  740  	if (!oproc-
> >num_mems)
> 530a1b57e8590f Suman Anna     2020-03-24  741
> 	return NULL;
> 530a1b57e8590f Suman Anna     2020-03-24  742
> 530a1b57e8590f Suman Anna     2020-03-24  743  	for (i =3D 0; i <
> oproc->num_mems; i++) {
> 530a1b57e8590f Suman Anna     2020-03-24  744  		if
> (da >=3D oproc->mem[i].dev_addr && da + len <=3D
> 530a1b57e8590f Suman Anna     2020-03-24  745
> oproc->mem[i].dev_addr + oproc->mem[i].size) {
> 530a1b57e8590f Suman Anna     2020-03-24  746
> 	offset =3D da - oproc->mem[i].dev_addr;
> 530a1b57e8590f Suman Anna     2020-03-24  747
> 	/* __force to make sparse happy with type conversion */
> 530a1b57e8590f Suman Anna     2020-03-24  748
> 	return (__force void *)(oproc->mem[i].cpu_addr +
> 530a1b57e8590f Suman Anna     2020-03-24  749
> 				offset);
> 530a1b57e8590f Suman Anna     2020-03-24  750  		}
> 530a1b57e8590f Suman Anna     2020-03-24  751  	}
> 530a1b57e8590f Suman Anna     2020-03-24  752
> 530a1b57e8590f Suman Anna     2020-03-24  753  	return NULL;
> 530a1b57e8590f Suman Anna     2020-03-24  754  }
> 530a1b57e8590f Suman Anna     2020-03-24  755
>=20
> :::::: The code at line 732 was first introduced by commit
> :::::: 530a1b57e8590f2ebbb6a35effa0efa988aabf6c remoteproc/omap:
> Add the rproc ops .da_to_va() implementation
>=20
> :::::: TO: Suman Anna <s-anna@ti.com>
> :::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> --
> 0-DAY CI Kernel Test Service
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> github.com%2Fintel%2Flkp-
> tests%2Fwiki&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C50009dcab
> ea44860b0c008dd590f683f%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C638764644912615595%7CUnknown%7CTWFpbGZsb
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dhtf
> oNpSwSE0sF4eFyya%2FIWJTpP3HrMDmELJYuTCRiVA%3D&reserved=3D0

