Return-Path: <linux-kernel+bounces-222015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685290FBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9111C2149F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1222331;
	Thu, 20 Jun 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s9D9AQFw"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733B3C00;
	Thu, 20 Jun 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718854232; cv=fail; b=YbcAzDZrgJDoAqzGjlLiFB55GttUJH/Ya2cWsoIgakejTvDx6o9M27RMKoJuSRD85dRgzasECZKGeR7wL1xco35hmcOO5KmIWmMLWek2XCcImD4kt40EDRPAsa0TLn73o2XefXnUhPdFsKCyg0/C8RmU4c5NAOU6q7VAznyqpn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718854232; c=relaxed/simple;
	bh=/tJSytx8DmzcHJgRBTkUr5JvhmhCMIqY6o5yemeKXs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRxcz15Nk91OH4qYztC2gqwfAXVmDw0rFswR9VrDhPCzjg775S7PhBDYmLLqcdR/LwLBJ27+YULLgatDf4Y5RWoxap8iQxwOo1wgMAZr5MvCUx4N1bay3DT4qBKu0cwdElcwjzybdxMdOFCIx4+XLcnNFHqd7KEhzEILQ5bzekw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s9D9AQFw; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqGgkOTbIxZobG2TBw/RHghTyaEbzoVevDTiSnrEjnj00fs06Ltn1n0UqY05zQvibshx1xLBNkSwvN4FxKdsHGudhQEAGqgq/xU2n9KhxrerY0agOQgsH2p7D0YLxbBrO6f4zq2h2H5tE6alImWYRxBOIOvufMFzvixXIdUvweH1bvWLK7Hms3AYz6GT4ykMeG2v0DsXxYcXI+432NfxOGhP59360Em/Fp3Cz+/wsB3ER+zHJ2haluvQSkfAm+EFBGEJunj/DlRS0FQyMv6xML2SEHiHt0qaHGCavCaorvC4H7laS7tNNO1tf5Nc9s5DakbNiEU6aGEnIoL3iJyqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP8EyZYU+mqgrWtKw0hKnh3MQGHB5pAtzRx80evVpwI=;
 b=Defgcab5NHELwadwVlxVGBgi7rqTArt8SQpoQw/PeRCnrONA1iyaDfKYqAk9SZw9+uavciTYdw//Hvsxfmo6PPjvjM2kHcqIUOAeVKg9c+SOcPvxl9fycDy8hIto0RNf9tQBrYUfuooQSzh6gRUSHUfqdjhadAKO06agK/6wrJdpPZp26JrwAZqKZkWLNpvs9gRHkJBJxH+5WVLXY8LM6B3ONKE9n/0RCkz4y7q8lSiAeCOrn59CcyGJOhSTvCOn58su0HNjd0QVlAefZmp5Sh4FQbzjRmsswDfwhYkcbOUU4NoOfTCadZuuE+XWDq66+bHNRGYzLVUyuFuzVRPUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP8EyZYU+mqgrWtKw0hKnh3MQGHB5pAtzRx80evVpwI=;
 b=s9D9AQFw6Z+NbwdcDyMHG6w2K1LCq5Xzy1mJfHuAy2sZMZMIFqpiIu79+S9kvnyEwiPbuDmIdGWobLKUXxptR7Mk3DF6hNDv7qcER7iXjr3Plj/Gbq6zfA5oM0gFYvAtJHQhx2AlfpdE/TqosPAe/4e3OEKMm3yda9ibFVhNcmY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB8626.eurprd04.prod.outlook.com (2603:10a6:20b:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 03:30:26 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:30:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] firmware: imx: support i.MX95 BBM module
Thread-Topic: [PATCH v4 5/6] firmware: imx: support i.MX95 BBM module
Thread-Index: AQHarbcjsuJf2tlyEUupBkFkDz7Jz7HNb20AgAK4mNA=
Date: Thu, 20 Jun 2024 03:30:24 +0000
Message-ID:
 <AM6PR04MB5941F0157D94E57EC6F12DEC88C82@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-5-dc456995d590@nxp.com>
 <ZnFZMt5Xao1u7Ve-@pluto>
In-Reply-To: <ZnFZMt5Xao1u7Ve-@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB8626:EE_
x-ms-office365-filtering-correlation-id: e33226d7-545b-4e4e-88c0-08dc90d95279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|376011|7416011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SLHC1XIOtoJ8NFc8hb7gmpW8FiBukRJ3VexovG9aRwbBT7fT8MxMsb4WKpsq?=
 =?us-ascii?Q?oCDRiXbe1HwDpsWg4piHO6x4dkXVDbPOC77m7yljZxi1McgQb1qq5HgLcn50?=
 =?us-ascii?Q?8K0GICWvttZAKfAwLjqy4bvyK3gOPATslIEzZL/3jKsS9iNJYZbsQdwrwJ7T?=
 =?us-ascii?Q?9cGx4uvqMc+7dJK25jathlOqdieHBCCwclM3LHMjwk/ipIvELdrN+iTKxqFd?=
 =?us-ascii?Q?v5GvOx2LzvJNdVad/7YSNA+9TEsYRfniqdxhp9MO8vHxoCFodPaUmYAcgafw?=
 =?us-ascii?Q?bd/XZQDC+ccRIvRkK/eM0yDntBrDDTkCBN6uH8xByvMO2yheRFgQU0gX3mzX?=
 =?us-ascii?Q?6Czqx0NBBusUBudYWEAMoqu5SQgzxBh7scsRUMShnQSG92BjiBvGSqwkMpvM?=
 =?us-ascii?Q?d1B9T3MlMTc5t0lCGOEJJleeR83Ux9FY7jSk2nWHN/jEeVHYBw8W31hYmheG?=
 =?us-ascii?Q?PP9HPP/9zeaM4wQEhqfXv0RHFDxCFMnhEtZ5i76qM7XCM1CPpSU4JEruI4ed?=
 =?us-ascii?Q?aaWTH/251zNtMopwNSYGDyZkFmv9DQiUYM8YWGQVfkeCTCMblWjNglhfIvOJ?=
 =?us-ascii?Q?mUCRg5Gx75ZI5acS5NInKyeACwpb12/WCIul594f3/S0S7BEYRJYrviYCX2k?=
 =?us-ascii?Q?yyG6zc3B3SxKYrn7CwEC3mqMgC5C7fvXNIKz71mNKwXSAPfOPKkoEGjat7wD?=
 =?us-ascii?Q?Zaermb/rvmdWPunZkW+VG1ALXELDJLObIQtjnz5LNs9GOnawPhVkEgwF1DPr?=
 =?us-ascii?Q?0/ozI0puBt+jtdOru96tpmS7wKfUOIAHHEEzVKxLlm/3Xb1HK9iUocZ+R1rh?=
 =?us-ascii?Q?7gDfA2aIxShyKl5wsQDAZjfExCvFQFnS6DFtFuw4k9dHLEEdwNv17L/qXmrI?=
 =?us-ascii?Q?yjp+wFpWXfX9lWqKxEDyRYbbqhKWt6bQk7cN/MyQ9iB4fTm+nXupVhzHNSGE?=
 =?us-ascii?Q?8q4b9GMNA4C+z9CYbKFk5NHo9Ph8wn+ULaMAknCEuM52bmC1v2MHkaV/eeev?=
 =?us-ascii?Q?feBxjgy5l5uRV3PldkZ86mND8JnuK4F8WNQA+SzOc9lD1ltsoSm8bLRX+ddW?=
 =?us-ascii?Q?xNPhZ37awICka0rA+JmgJ7ZxMJp5ftFRppMOlcXrasyqQhnBYkK3Oh1rjdtO?=
 =?us-ascii?Q?5f3pYlSR6Oa8vn6e+8m1qmS8B1s0Hh7PvhoFrQMqpnYgG19HGGy8fG59Gymh?=
 =?us-ascii?Q?U/9LAlPFLdmdE04QviUctQwMijbhvwfra+V3SAV3XEBVTs5EFR+IM7NHMJxj?=
 =?us-ascii?Q?74N2jvhW0hbBiUwscCDJ/7b7e41MhRR2fb4Lvxqdpb15cNytqG2RIjX21uG/?=
 =?us-ascii?Q?ub5IqMVMQFo5XAZRkDLd5eel?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/TDiBNoRh7mWg4X8a+Yz039UU+4l/uxlYD6la0EDFfci1ztDwAZHSJ6rt0vN?=
 =?us-ascii?Q?nPVYhSmHH6cf67XwiqM3UnQg0DxPgac0rbQPIYSNcppZ4fOysYJTovviDqAB?=
 =?us-ascii?Q?SWN/dR6s50+7o8DVKLF+SUNcCeJVaGvFt7g/4qC1KFK4+sb2zlA0FVspN+NH?=
 =?us-ascii?Q?PRH9ng4GvGbbFrMm3C9toSIJqxQohIe3t6w5ySkmhlFUHIlyS/Aoi044c7kQ?=
 =?us-ascii?Q?VVCjjdA1Kwe6Az8oxDZIo/ArrzNrX9xTW0P9qKU1JpIza5n8ZNR185/PS81O?=
 =?us-ascii?Q?expbHpIbFNCDD8bRuLr7UPIZ2Ap8ZgsbW17vsWZNay8PyCOzLHYkrsWMYTbd?=
 =?us-ascii?Q?wA2Dgsm7fUZMdPFdZ200Aai/Cf1G3DCjW+G/m0NaAxI6XJ7BnmtTr/Ftf1xt?=
 =?us-ascii?Q?dUQ7Dq3Z+0uUp3m5Uvu2gn0tD6iYs/YvYGLd6xhKIJf1SvftWF8M83+oj4Tl?=
 =?us-ascii?Q?N3CO7UjUUAjljiiET/7FLMV/635cYTw0Jfv6W/k4oxARAjLxflXO39W7hwvz?=
 =?us-ascii?Q?QD2PNtUWAQjwzknNfJ39a9GIRp+HYnnl74jzw1o4QTQiFHVAU1KPLGohYLPo?=
 =?us-ascii?Q?TmhBe85U+dJTOK0qgsruqwRcDitaYq2LrIQ9i7bD9PWaVt5g1YrFz6u+l826?=
 =?us-ascii?Q?R1+369DZ3zbAD6V/hnjmVQBZuNZQNV8HT/dox8WBoz0LXfAdBqIc4lXAdDoB?=
 =?us-ascii?Q?l8gIYlHK2sJJRJ9VS9xqXhahIlUBdASZkd1QV+EUT11M/PZamwNI1kleA5GN?=
 =?us-ascii?Q?PLLfaJX0e3KJgsVtXs47r2e5RCLm7i6lkbhgoD+/vTZ6XuaP1LwctQv1bK2Q?=
 =?us-ascii?Q?XSP//lMG18HJT+eeUjZxADrVttxHcTYZgBdvYcZiNspUtaTaxISU3v95Ghr4?=
 =?us-ascii?Q?t0W2nKObB9UO1xP70I3nBIoMcxRJFv2/p+MOWAjVElnKR6bBG98wSGqe5mgq?=
 =?us-ascii?Q?aU1WBmEY+BoGQ8a+P5P+ZZFcpisq2JewffebYduTVcXh8HcLIR7Jyqohjsa0?=
 =?us-ascii?Q?SnFNBS/or2ZuYBuYPHH3d5UOHMPCYG8uyPt4rqOhJvQOF6wYVCtfYHCkUb2m?=
 =?us-ascii?Q?uLQ+Q7oW8GRv3U87JpqT6m7ZYqHqSJLPl3tZVAF2nzLOFO3ab2lwkjCJLxgi?=
 =?us-ascii?Q?8Mf2Z6ntMdR2DH9xcvqvMxZlQxJnW/73LZNWPnCepxC4VVikHkcVMfUeS3W0?=
 =?us-ascii?Q?OCWhnHPCrzTwF67FAweLSYXTDzdhuKIsX5arQIX0tAyuJB6mLz5VGjsysseD?=
 =?us-ascii?Q?wiIOvLGxp7Q9eRQGmXnAjEhkmBrDIR3obOy6X/LGhEo7eovi7zEKCE/6edKq?=
 =?us-ascii?Q?NGVs0/GSBPdbdE2HQvbw8IFsPjUVZ+h8enX81qirtRK1BAHa3Yl4xnC8zuGe?=
 =?us-ascii?Q?9/27I5AmiutXHRDl/AFLmc4S+TdxMGfgIj1fD9rYF5kE3+01ms1K1wNMyOUo?=
 =?us-ascii?Q?kfi95y2WeKfc+Dgj5h7tbzY/VEAIt4XvbMnvBKCoR5PtPjmfrHEFdBmkEFcE?=
 =?us-ascii?Q?vF6pd89FxvOvTpVCOYV+E0idnSn29czkMcGGCz9oxuBVvAvqTXfE7fU/l5ru?=
 =?us-ascii?Q?ZlgqNscrGFgfkIXq0dA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e33226d7-545b-4e4e-88c0-08dc90d95279
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:30:24.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJSGrecANGrla7e9gXvRgwLfLAgGqfFy+wJYGSbxXSXg9thzIkQco4O0Do4KbHN4lyOTBkBz17qqYluI6kn/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8626

> Subject: Re: [PATCH v4 5/6] firmware: imx: support i.MX95 BBM
> module
>=20
> On Fri, May 24, 2024 at 04:56:47PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The BBM module provides RTC and BUTTON feature. To i.MX95, this
> module
> > is managed by System Manager. Linux could use i.MX SCMI BBM
> Extension
> > protocol to use RTC and BUTTON feature.
> >
> > This driver is to use SCMI interface to get/set RTC, enable pwrkey.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/imx/Makefile |   1 +
> >  drivers/firmware/imx/sm-bbm.c | 314
> > ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 315 insertions(+)
> >
> > diff --git a/drivers/firmware/imx/Makefile
> > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..fb20e22074e1
> > 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_IMX_DSP)		+=3D imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-
> irq.o rm.o imx-scu-soc.o
> > +obj-${CONFIG_IMX_SCMI_BBM_EXT}	+=3D sm-bbm.o
> > diff --git a/drivers/firmware/imx/sm-bbm.c
> > b/drivers/firmware/imx/sm-bbm.c new file mode 100644 index
> > 000000000000..5e7083bf8fd3
> > --- /dev/null
> > +++ b/drivers/firmware/imx/sm-bbm.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP.
> > + */
> > +
> > +#include <linux/input.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/rtc.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/scmi_imx_protocol.h>
> > +#include <linux/suspend.h>
> > +
> > +#define DEBOUNCE_TIME		30
> > +#define REPEAT_INTERVAL		60
> > +
> > +struct scmi_imx_bbm {
> > +	struct rtc_device *rtc_dev;
> > +	struct scmi_protocol_handle *ph;
> > +	const struct scmi_imx_bbm_proto_ops *ops;
> > +	struct notifier_block nb;
> > +	int keycode;
> > +	int keystate;  /* 1:pressed */
> > +	bool suspended;
> > +	struct delayed_work check_work;
> > +	struct input_dev *input;
> > +};
>=20
> You could pull out the *ops in a global like
>=20
> static const struct scmi_imx_bbm_proto_ops *bbm_ops;
>=20
> since the protocol ops handle are always the same you will end up
> overwriting it with the same value if this driver is probed multiple
> times (which is harmless)...you will get anyway a different *ph handle
> to operate on that you are already storing...
>=20
> ..up to you really

I prefer to keep as it is

>=20
> > +
> > +static int scmi_imx_bbm_read_time(struct device *dev, struct
> rtc_time
> > +*tm) {
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +	struct scmi_protocol_handle *ph =3D bbnsm->ph;
> > +	u64 val;
> > +	int ret;
> > +
> > +	ret =3D bbnsm->ops->rtc_time_get(ph, 0, &val);
> > +	if (ret)
> > +		dev_err(dev, "%s: %d\n", __func__, ret);
> > +
>=20
> ..so if you fail to get the time via SCMI you just carry on without carin=
g ?
>=20
> > +	rtc_time64_to_tm(val, tm);
>=20
> ... converting some random val from the stack into tm ?
>=20

I will fix in v5, should return an error value.

> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_bbm_set_time(struct device *dev, struct
> rtc_time
> > +*tm) {
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +	struct scmi_protocol_handle *ph =3D bbnsm->ph;
> > +	u64 val;
> > +	int ret;
> > +
> > +	val =3D rtc_tm_to_time64(tm);
> > +
> > +	ret =3D bbnsm->ops->rtc_time_set(ph, 0, val);
> > +	if (ret)
> > +		dev_err(dev, "%s: %d\n", __func__, ret);
> > +
>=20
> same here why you dont report any error ?
>=20

Should return error. Fix in v5.

> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_bbm_alarm_irq_enable(struct device *dev,
> unsigned
> > +int enable) {
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_bbm_set_alarm(struct device *dev, struct
> > +rtc_wkalrm *alrm) {
> > +	struct scmi_imx_bbm *bbnsm =3D dev_get_drvdata(dev);
> > +	struct scmi_protocol_handle *ph =3D bbnsm->ph;
> > +	struct rtc_time *alrm_tm =3D &alrm->time;
> > +	u64 val;
> > +	int ret;
> > +
> > +	val =3D rtc_tm_to_time64(alrm_tm);
> > +
> > +	ret =3D bbnsm->ops->rtc_alarm_set(ph, 0, val);
> > +	if (ret)
> > +		dev_err(dev, "%s: %d\n", __func__, ret);
> > +
>=20
> same ...
>=20
> ....mmm... hang on ... this reminds me of something...
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Flinux-arm-
> kernel%2FZdjgSxFx9YRP107y%40pluto%2F&data=3D05%7C02%7Cpeng.f
> an%40nxp.com%7C91000402f63d4e893d8208dc8f7c9399%7C686ea1
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638543012417198736
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnK
> leYfoIRJtMN13TNQB9xYH8aX1tUYk9UI202tYl49I%3D&reserved=3D0
>=20
> ...I did exactly the same comments on V1 around these 2 BBM/MISC
> SCMI drivers....but you never replied, addressed or disputed those
> issues.
>=20
> You DID address other review/comments in protocols and DT in later
> versions so I suppose you just forget these latter drivers reviewes and
> just rebased on.
>=20
> So, this review stops here for now, please address or reply to my V1
> concerns on these last 2 BBM/MISC drivers.

My bad. I will re-collect all the comments and address in new version.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

