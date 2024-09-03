Return-Path: <linux-kernel+bounces-312338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D01969524
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0915284919
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839B1D6C61;
	Tue,  3 Sep 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eTmCBx0P"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F411D6783;
	Tue,  3 Sep 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347956; cv=fail; b=bzwZBsGJmX0LCu/nKAFu3EisrRj+qzWZIAkbDUbSVBwGFTm0lydXD8f5xr4C+nq0C2X9CLHbEXa9I4P6HtywyXss/Gdw3+q125IoLLG/H41LRbiIW35JOJ5iH1ldfYYWCHi8v8zreQONjoeao8QD5ko2C+IUKSFy7JeBvu28gjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347956; c=relaxed/simple;
	bh=LtXU75zYHfyf7ZFFf854bYyU0saqiEJ1BiGH/OFZRbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RB9kPvDl+/EddA8LBz11ff7KvpXU3YErXxW8d86puQJasRFh1sJ8R6ePd2fOgsOEVfSvR0wcHCkmaXQyJyQmGzfnmNkTrJZyEXoSxA6vTVjvaEyfN4qhx1FSBU0BhMX3AEtAuzNn/81jqFQY6+kV6cR4LajvfX9jWWNlMlNR+qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eTmCBx0P; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwPSCZrAzN9N8nni3VAs39ARMKvzjxNHSueL0EdDYZnc9iXFMsGSecs0Db6wQoWK5Ilbbdbes7JWar7OBG7+O8vI1VgeXYVG/8hPCnQuMOP6Rsmul6Ni9AWucH4G1Xc98UrdJrq2klEVp556rEj0131OpctSIaUgH5dSyj4YhcMZgI5h9cQvwhKtJZXQtLPLRlu9/BtABgDuBZ4LY+w0GuBc6flmJdkgKZo2d0CUBylhpnoGal1E/xTKrYRUF4EdFDZnnRYXdtoUniXuXBYST12h4WD6Vi3hKFSaqp7eFnNnAwYWRu0dL1bhN/p89J56Lnz5pnb2ls//uO9eQyy0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSK/nJh04S3XizGJDQWOr4p2gjRbJ/NThBUTbFfENno=;
 b=O9yxnFFl6mLJEXvPEWeuNFbQImKAMRjNTsIJIcUvz1pDq3tcVQw2DdufCIRS+okxA8grkvdkuMjk2hzzwjGBhlrS+CQAdyO9M8DkDJZfzTl3zb5GAhBZLfCKaG5LEt4ZEyz4IcWxa9CI/PomiATB7K2rPeSCV2zbixleL3Ow++NFrmpJlNkN3f2VSMu0NJ7NFjN/qu/lr11Fu2JvXkvMAwxS4vJv2CtBR1R3EWTyBZvjkk56lHVcahqcT3JxV06As/KcmEkScW+MNMfw3EGPAzDj0fql1mI/scVrO4FxjVp4X1N1l+rESCkOxsS73IN2zcR9WuBiro2iNPVIxfiSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSK/nJh04S3XizGJDQWOr4p2gjRbJ/NThBUTbFfENno=;
 b=eTmCBx0Pr4GSx3y0ww7WVEThdQemzp3PnWE2lpsQ2bayHWH4LB9AgbRvny8mpPOIqm9Gmxmjj5Tq4swqrnjIlqn+Syj0y3gW8N1Eev9mRyPhnSmLRFyVjX+3UHFRxDtzL7osCb3X+vU4fOon6rAoATUBh/pyL4nfsDKydthIYwU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 07:19:09 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:19:09 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "mka@chromium.org" <mka@chromium.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "wentong.wu@intel.com"
	<wentong.wu@intel.com>, "javier.carrasco@wolfvision.net"
	<javier.carrasco@wolfvision.net>, "stefan.eichenberger@toradex.com"
	<stefan.eichenberger@toradex.com>, "francesco.dolcini@toradex.com"
	<francesco.dolcini@toradex.com>, "jbrunet@baylibre.com"
	<jbrunet@baylibre.com>, "macpaul.lin@mediatek.com"
	<macpaul.lin@mediatek.com>, "frieder.schrempf@kontron.de"
	<frieder.schrempf@kontron.de>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Thread-Topic: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Thread-Index: AQHa/GfAyUa3qy9nHUmC7/PR5nbk5rJFn4QAgAAB7EA=
Date: Tue, 3 Sep 2024 07:19:09 +0000
Message-ID:
 <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
 <2024090312-stool-ergonomic-f2fe@gregkh>
In-Reply-To: <2024090312-stool-ergonomic-f2fe@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BL3PR12MB9049:EE_
x-ms-office365-filtering-correlation-id: 976ac931-7e16-4301-db72-08dccbe8b442
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T60gXtU4sJGGE2fSVeSxVPoiWs0vEY94ETe88paBrToPuJMjkmcX+mjwtB+H?=
 =?us-ascii?Q?5VAnxowmStA1TjbwnlPppMQ7p8Sc0CWq/yukq75Oc8TYK9aUTytofRVLBS+i?=
 =?us-ascii?Q?TOZexv+5EkdVvTDCtMxkbZMBe+ECSlC0owMvbEZghXXYpNmSeHjscFevxlja?=
 =?us-ascii?Q?LdOuCv3UrL8nsWQWuwDajWZRKEE+2xqvrLYI8oGPNb9+aEIZBMEcJ7uvAAl7?=
 =?us-ascii?Q?XIPXNSFH3lKY2HUV1wxtuhg3kPVSm25BRBIeqkGoFyPUdErOGsuAao6rvfMK?=
 =?us-ascii?Q?OZXLTV3A6wQHgwgxUxktBM5kY18h1qTcCzE+sx7iYYmVAu9Ypf65zWlg3h0U?=
 =?us-ascii?Q?x/zAxC6rooOugsutIFXjkMiO9I4NMxiHT6qRY6Ed0aed77UG3ysaOCbCGl58?=
 =?us-ascii?Q?3dbdyhsy+pPGl67X9LZMqoYWJOWrC10hCHg6HdeTy39bCyaH7W2oIqH3CidS?=
 =?us-ascii?Q?w17LhY33WgmMe5blH9gf5phQ4AP9vJnzwqyJ3+8IHIsGaVgEWgQAGbAOiYzk?=
 =?us-ascii?Q?TYb44OtfO4SU4xrLjeKE2gwnnc4vVq3PgdAHc4lvVVj03TZJ6s1Aq/+orl2d?=
 =?us-ascii?Q?SBHkwpfReVfwc4f96qcy6brIZrlklbzPAYEtk/zp/NzoQXjVzGLRO8Pf1uAk?=
 =?us-ascii?Q?fC9xFq6ebDSweGQpH3gbFeXpwFJuhaCEobkFlbCXRQEgjbpQUt7Igx4WCc7j?=
 =?us-ascii?Q?AtKLT2B1jJVlYx7TvPoo5+zcebTx95As3p0LTq6BeNj7orcksIhDCQATpyop?=
 =?us-ascii?Q?5exyeUe7/tSVtmRB8fgIoitJP0ks5pQtieyet8uWbocPeFVth5J5zCUSrbnp?=
 =?us-ascii?Q?A4DvnDiYFMMEIQuXrM36o53POw+8qx+mjBSOaGQZi4sXx0aethx9q7GA1qt5?=
 =?us-ascii?Q?Fg63P4ogE8j1DPPR2l+ABsPloiHzn1eVA+OusVSrMoIshfuDBPVu43iwyo4e?=
 =?us-ascii?Q?jTEviFQ5tjS191Rc3/aBysukOQ99J6vbrtMbQSqwTijGLCVCHcoNxfD0l0nJ?=
 =?us-ascii?Q?kFjNcVQnvsZfuBe2eaG9djK+HkyAGqPfOVafdxP370ICIt3HWbI73bS1pW3R?=
 =?us-ascii?Q?uFGaJPrTtgmfQZUIgRrsNPGfQfpCDG8MyTMYRkXLssXg9ey6QusQiXRDg+gD?=
 =?us-ascii?Q?ypLIuYNwMhAcxY7bsdJio11DfqJfR3LC5hT9ViKTdf6G54mF09BW5TeTGdnB?=
 =?us-ascii?Q?RRq69QoBnHyvspFZNBc9pXKneJWDcsqvl7IihuvNw99poZsf2ZzpnNhu+Lpo?=
 =?us-ascii?Q?nIh6r9Bmy0cvthmzrRjFnXxUBe5KNtxsrwswKs5d75I9QHRF8mHVtoffpOrq?=
 =?us-ascii?Q?ji96Dal9JDW6DdFEVXE2r8mR6wjWP2hEWJ0doufEejQn+nEVnRiH8qWUpAAV?=
 =?us-ascii?Q?Q59gNy8jC4GaLxXx1VFQE54M3COGUeFkIMgrUnNoxGNb/924BA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yO+6b12jynIW+uEdWpFG1uHVjUYrIMcRkB48oOLlPQNcXL3OKscrIv6KqzKn?=
 =?us-ascii?Q?W36E6BSyLWITC/JSf0MgDbig9lLA7PoxcGqCaBHtl9H5d8LlNFC18st1ta9c?=
 =?us-ascii?Q?nx/M2inKS5tnKugbAh2kJBsSTryDUNP6lh3fdpqmygKUT93epv7mSSsWZFM9?=
 =?us-ascii?Q?x9nsKxpP121USzXVo3O4Dm3sbOsw7hxy5188gjm/xv3Ssxur9w7kjMbG4N4D?=
 =?us-ascii?Q?IzMs17OQPQKsfMMCNo5vC7f+DXXpnOtfof8U76fYENmtJbVbxIR98hH23AL9?=
 =?us-ascii?Q?38x6lz+QRQ0vn3Jh2a4Xu/WNM7fi/MbmqdYXZtc0cz1u8rYs+z3ab6OwolmF?=
 =?us-ascii?Q?/QrlzdEgI90UDauADyEhQOWXJNsXmeIks26e0qKQrGvKdPyRI2go4v2HDtJe?=
 =?us-ascii?Q?p4Z5Z6YR0fJRfi5/AmRsKia/WeFFvJEIL847L+lJfu9s23GG+9LN+KTENjMe?=
 =?us-ascii?Q?Qcu0vn2ZqMf05sqNfjj+pghClEN8YHroMS8y+D37WK/suB3UpvAUogXI03Fe?=
 =?us-ascii?Q?uEIPEGnGJdklZQFUDezrM+ZDWMY7q0kntA6ErTXciPau32C+HApxfj+fvE6J?=
 =?us-ascii?Q?Tu+FcYDdw3UoaPX04Ws1f+wey3aNyeqQaW1pRF198q393YsPrSIGIfpUMykr?=
 =?us-ascii?Q?2SwIoNuR8hf3YJw8kGEGTxlAA6+H7s0zy7UeKEhZ1X15joWD9ne6zQU1ub1m?=
 =?us-ascii?Q?zYAslfQqkdDjZC4IAaaX7lg47xpYNSCv35hD7NA0u+g6K0zt92jXpsDADLbC?=
 =?us-ascii?Q?+lQzwwxb5YXx2H7HJsWG02fvUO8J4zjqlDqWPGZZPDwwGD66eXA28159gAxj?=
 =?us-ascii?Q?7GZwPtpqe+wNAJ7fRB+vRLlpsU8recaYwHoifsNhpBkol6yy6SpU05VIb3Ai?=
 =?us-ascii?Q?z+wohN9zVxzdFnqa7cMs0o8ZJWHZYCXLe7OximBMIgBrQZLLYFBw3vnZ5WBr?=
 =?us-ascii?Q?oGcVsZU1yrz6zuvXuv2Q2pX0jZrwiRzO+9bUl/RG5JYerazVcVGkc8oWW0SF?=
 =?us-ascii?Q?eJK4C9aJV7MSkepompOgSPOhMwXh76kMTd3XMgg8A7I3yq9Ixia7sYOKQQ1q?=
 =?us-ascii?Q?IsHiNrmxK+As2q2ahTE6UZtEZT3PwHXULYOQXrYOKu0nPXsJ9m8hmpMaFONW?=
 =?us-ascii?Q?jNKcgy0nvQd2jvsaFB/K9fljzxuQWhdzQ05FUaT++JoqvABaMc0WTNO9KM+x?=
 =?us-ascii?Q?55TVX/GOO5g44BdeSQr4ZYtoFdLPANZIyTFoKZnPDwR2lE+np9jYL1De0h4c?=
 =?us-ascii?Q?rd8mOqVQg+azC2nR8Wx1uEFo+iX25Z8w+HKqVJwT1m3ker5hqnfbOug3oE6O?=
 =?us-ascii?Q?EVz7No8Jg8DnOBTt8uyTMRZRMpcJyABqeEFP4dLM0ul+3Xe0fmWSBSxpyc1w?=
 =?us-ascii?Q?IXdP0E0+nQmlN4oXjBBCH1fBBis2gSLGzU6cF3hCcn9hwN5DRdEBXyrFL2DN?=
 =?us-ascii?Q?4rRdW3n67hhodqhVun7RmBXRlfEVxlCpoy18DKkjazbXbuHiPEap04ZZi3iw?=
 =?us-ascii?Q?ZSbAkw+gKILr7IrsN010gDYperKWNKwJERvSnXra0CwKUWDhO88mUfTz8Po+?=
 =?us-ascii?Q?96YJeAockDRc84V/V9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ac931-7e16-4301-db72-08dccbe8b442
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:19:09.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcPZudbBnrsabuyh4ZZLdRoK/FS/eajmp3yWxjPEvwNOVV3XSsEaC/7XkrTRVTCm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, September 3, 2024 12:10 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: mka@chromium.org; sakari.ailus@linux.intel.com;
> wentong.wu@intel.com; javier.carrasco@wolfvision.net;
> stefan.eichenberger@toradex.com; francesco.dolcini@toradex.com;
> jbrunet@baylibre.com; macpaul.lin@mediatek.com;
> frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip
> usb5744 SMBus programming support
>=20
> On Sun, Sep 01, 2024 at 05:38:39PM +0530, Radhey Shyam Pandey wrote:
> > usb5744 supports SMBus Configuration and it may be configured via the
> > SMBus slave interface during the hub start-up configuration stage.
> >
> > To program it driver uses i2c-bus phandle (added in commit '02be19e914b=
8
> > dt-bindings: usb: Add support for Microchip usb5744 hub controller') to
> > get i2c client device and then based on usb5744 compatible check calls
> > usb5744 i2c default initialization sequence.
> >
> > Apart from the USB command attach, prevent the hub from suspend.
> > when the USB Attach with SMBus (0xAA56) command is issued to the hub,
> > the hub is getting enumerated and then it puts in a suspend mode.
> > This causes the hub to NAK any SMBus access made by the SMBus Master
> > during this period and not able to see the hub's slave address while
> > running the "i2c probe" command.
> >
> > Prevent the MCU from putting the HUB in suspend mode through register
> > write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2
> > register at address 0x411D controls this aspect of the hub. The
> > BYPASS_UDC_SUSPEND bit in register 0x411Dh must be set to ensure that
> the
> > MCU is always enabled and ready to respond to SMBus runtime
> commands.
> > This register needs to be written before the USB attach command is issu=
ed.
> >
> > The byte sequence is as follows:
> > Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> > Slave addr: 0x2d           99 37 00
> > Slave addr: 0x2d           AA 56 00
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> > Changes for v4:
> > - Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
> >   introducing a dependency on I2C_CONFIG. This error is reported
> >   by kernel test on v3 series and usb:usb-testing 20/25 branch.
> >   https://lore.kernel.org/all/2024082503-uncoated-chaperone-
> 7f70@gregkh
> >
> > Changes for v3:
> > - Add comment for UDC suspend sequence.
> > - Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES and
> replace
> >   it with literal + comment.
> > - Move microchip defines to source file.
> >
> > Changes for v2:
> > - Move power on reset delay to separate patch.
> > - Switch to compatible based check for calling usb5755
> >   onboard_dev_5744_i2c_init(). This is done to make
> >   onboard_dev_5744_i2c_init() as static.
> > - Fix subsystem "usb: misc: onboard_usb_dev:..."
> > - Use #define for different register bits instead of magic values.
> > - Use err_power_off label name.
> > - Modified commit description to be in sync with v2 changes.
> > ---
> >  drivers/usb/misc/Kconfig           |  2 +-
> >  drivers/usb/misc/onboard_usb_dev.c | 73
> ++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 50b86d531701..cb5e47d439ab 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
> >
> >  config USB_ONBOARD_DEV
> >  	tristate "Onboard USB device support"
> > -	depends on OF
> > +	depends on OF && I2C
>=20
> This feels wrong.
>=20
> While a single device that this driver supports might need i2c, not all
> of the devices do, so you have the potential to drag in a bunch of code
> here for devices that do not have/need i2c at all, right?
>=20
> Any way to "split this out" into a smaller chunk?  Or better yet, just
> detect at runtime if you need/want to call those i2c functions (and they
> should have no-ops for when i2c is not enabled, right?)

In onboard driver I am calling onboard_dev_5744_i2c_init() by
detecting at runtime if "i2c-bus" phandle is present. But the=20
problem is i2c_smbus_* APIs are declared and defined only for=20
#if IS_ENABLED(CONFIG_I2C).

Do you think we should implement no-ops for I2C smbus APIs
(in linux/i2c.h)? OR a simpler alternative would be to
add #if IS_ENABLED(CONFIG_I2C) check in the onboard_*_i2c_init()
and return error code if CONFIG_I2C is not defined ?=20
Did a grep on #if IS_ENABLED(CONFIG_I2C) and find couple of=20
drivers using this approach.

Thanks,
Radhey


