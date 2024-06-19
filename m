Return-Path: <linux-kernel+bounces-220733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E391890E667
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF01F2360F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373637E0FB;
	Wed, 19 Jun 2024 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIE9d3Cv"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C112139B1;
	Wed, 19 Jun 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787493; cv=fail; b=mrbTU6XZckba+J383G3MRWhy6vPm4todxV/uGCVXKmnqtmHIo54gmDs4w0+ixDAOvcOzvzlG5pPdi4jPX1nc8X+M07W3dHTNx3PPfN67AqTYfK0WwmySkTWtd961CBLwaEw9aHko8Fp5X813964O5OImU24WyXC/6miXhME0yJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787493; c=relaxed/simple;
	bh=HlCDSD+Gjto737z50W0d6FKCq62eiKLWfQmm2pReDBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUr/NC61qam1CI0UaXBRcaHnbXNjsgGQQpUBtE0OktJbDEn47kAAqelZb9NkZYpm5H/ZJOfelMjS0I7Na/tEac5rCegV2XYNcNWcUcjB6yUH6VGDC7zGRH2py7iR3mPb2m5hjT8YuRknCTIl/bUfzqWVyaupbgzIywzbBTuKANM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIE9d3Cv; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7lfGpdkeXg+VK7HY6sivD5i3qLKilLmeUGOe7HwTE/YIWMfdkZ6rDcGfE954Jj3hHKY+uLwOB/rQY1JLcD1bLouMooXvEJ8ON5VL4mzryS3Wxy1VQHL4jCAZd6GhcZ4Am6djpr7mDe82uk4OTMM6ISYhoHaQKbSbcW9oNK0main74PDfzK0MBgOYp7dx1VsgOKeILef3jLlaDyArsjAG4GZS6F96KIo/aq6g36nFZszenl0ZiwLXE8BUNHj/br+h/9B2Tcg7WIKeVa3TDO3/i8DzuDD8qZaF8z9q/QgP4JixQNBOZ8QwHf+GGn5blF7SpyU1R9jlDjIXsqPKG7rOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEM+BrA+wHEhSyS2rIT+prmu5nj9bkCHY7DgbZbx6a0=;
 b=ZsF0wiMT2hu81MOVC1rOdATdbm6rjTcUHZnIkaybPgWbQB8jGGDOdimNrMNzSBCFOYvDn/zWDDjJZmhO14r9qocBsbDRieKHaOozth4XnOJQxLmVO7VgNFzPRYPZjX6OaKg7aFxZjp/lvNIiZoQhYheraUIIa5mEseukBk/+itylPtpVTe674F0dmwKdaycBukgncExRa72Mle0/1DnvVaQr5FfsjYiRtIJwXKEug/zG+HtAgMx66GQ/67plV839lGYimoYzfuKhasRZ22im8SIiQvlx5dIIn0M52aqJVRpSmTL3HSkEu0MOfTRCJOETtS8MJZW0nfvAIPRuWPqJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEM+BrA+wHEhSyS2rIT+prmu5nj9bkCHY7DgbZbx6a0=;
 b=JIE9d3CvlJGCYqmpr8UPxGySPEFRvj+IujH+BwKUpxBhWTnn0FIU04XY77v34/LAl1V2RwzcvVgM+gcdRU0dZ/kKDWSfpr7DGRS/AHGSx0EE64KKwuVNKtnuTZ11YR1HtmbQiA5uWyhwthn/5MhvIcqMdIv1bG+0XnsEoQZqAMA=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 08:58:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 08:58:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
Thread-Index: AQHawIicdamSKXolo0+7SySlWnKHebHOC/YAgACy2FA=
Date: Wed, 19 Jun 2024 08:58:05 +0000
Message-ID:
 <AM9PR04MB860454A456480393E53199E995CF2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
 <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
In-Reply-To: <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PA4PR04MB7727:EE_
x-ms-office365-filtering-correlation-id: bd89a14f-10b0-41ce-d543-08dc903def3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|366013|376011|1800799021|38070700015|921017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R7srlbLtfQP7cFd03fULZLNfvYN7taRYK8jGiXZimbOdoCS3kHOQxzCWayEN?=
 =?us-ascii?Q?w7MW2k17XOvX24ZT94NMsWjylGEB5hzaxFYoKMxJlnDcW2dd+ofHJpUzQxVT?=
 =?us-ascii?Q?+WbFfycWUK2T4FlHeAdCGhQWkHBjQ5PuDhYHDMJVbFyl8bya2lVomN8Cw9kx?=
 =?us-ascii?Q?ejEfvQ2/5zrNpuKn+up0AzPod6c4Grthb5Ye6/kZN83ncPg6b7377caHGvZy?=
 =?us-ascii?Q?VsGw8LYtsPRd39Hc5aWwDnZxkdJ98HR+ZI3JMSyrLwBkWUG+4gCVD52a8dkb?=
 =?us-ascii?Q?jmo15u8PAHQs9UodIOfzpn0dlJzMxZAdoG/m88LLsZ/0EYBI5swsarMWMKZG?=
 =?us-ascii?Q?Owf12AHL8VN+R5pXHkeTRdD5l2UNzkfmEVDT+C3KFLK9loXPpldBJZ2yhpPi?=
 =?us-ascii?Q?qGRRoaBU5uqJ2Ye1nLkPGnSFAwPhL5iqbk2i9pe4l6euy2YLnk2Ac4PS39X9?=
 =?us-ascii?Q?KWzP8x5KJ+CF++APF+iISyQyP496Jl+xvvqKBLv+ZyUkYyIc5sk1Cnuspd8m?=
 =?us-ascii?Q?F9U4xSld511lqwpkbkn7sXaByQTzDOmQKui+VuyAWKX0fq+Sk3HPLAr0R7UM?=
 =?us-ascii?Q?QvuTz5aQ0nbgJTWh5ze7mUqMacJMLOu9PkmSQiydPqtdaSW25IxH8n/pIene?=
 =?us-ascii?Q?4U0aVTWbMXlRpFC1W1H/CN7U2dNCHsrxlokbluoHHdDMs4SZvZKGBWyDNe8z?=
 =?us-ascii?Q?Qn2ClCMXncg4W4+z7UJI9hJ3BRvxXzQFh31I2ZXaEHbpp20ATm5GMx04Y1tK?=
 =?us-ascii?Q?Iuq0QckfMHq4OdAGoVK6CQa62oIXQk4e8eyt9eMun+/kUo/iKdzD1UqkQ4fN?=
 =?us-ascii?Q?izrvBMUbEYbYd9iJ2Xg1cs0LpJgCZU2XSLOtQ8rmk6AB2xRr/HlpL72CqxSN?=
 =?us-ascii?Q?jcocq8hzD9rnWtB7VaA02HSduOqWSuF9Indynhidg1kgbfQ96JJ1CCVx0OZM?=
 =?us-ascii?Q?rzO2n5ltNx26HrlqYav48I3AlNKZkSq5a4VNyZaqm8DIy/s+WObG1DfVXiwA?=
 =?us-ascii?Q?iQbhYFwxbSLuzytTTQZ+CRMXOsfOu+BQ2Bmh4zZqCMFA2FbFhLLAaT7NN7WZ?=
 =?us-ascii?Q?ZQIm1cXiibkZ4RYiHE4wlngFhFC3TttLjHtShVJHmzSWGvkWhKMTo8FhEvuh?=
 =?us-ascii?Q?BJZ7sTBCutREAHQkojMWam+qkeQFwq8zhu/uMfrPfi9DJJI9kqlDoO7QHdfn?=
 =?us-ascii?Q?m3bkIEYw4pU32wPzhq4Qn7TZ7ee3c8fiFKT12L1axeT7bQAICU+EFZMBQ/HU?=
 =?us-ascii?Q?R375DA3R3jeJiq8F0IauZLNYW5+bU1ZftVqvqkdNtDI2z84ddFKhCOmkmG/C?=
 =?us-ascii?Q?JPz/Df8/C99QcYGwzYIXj/piLZX5icZ0rgchan0es+qnLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O0FZcne5jt2VDVi5z8dkSFmhVevfO26DQAr4KJQvhf4lk8tQx8X851vBnyIS?=
 =?us-ascii?Q?I1wqfxlYirnrILBaZZPdGUeaVBPUbMNcIyrYfCFb6t4+osQrakFLnbnoNzHm?=
 =?us-ascii?Q?25vXkL8V2MmN5D1qQIVYJOMfi3rlyzIpmMAyD3zL5ymU55Ec5eRXovFI8dPZ?=
 =?us-ascii?Q?oN2vKa0qX7mjJDRzo3x9FgwMOhVP/VFZe/XUQmxIDw9ic1Hw1T9VceZcrVIB?=
 =?us-ascii?Q?Udp/ilxAXXsF1NR9Tu4Nl2m1LTFy/AOx2XApQs6GctasNaAKAd78ZQ8TdYFG?=
 =?us-ascii?Q?hR8Yx0Fkka03n4/VBEiOTRTHgR1U7QRQ+5Nt87UTWVCErEoufztS84y5ZynI?=
 =?us-ascii?Q?Lt7ggiSMOfKm4oeF5dvblh310lahuyXsxB76f0kTQ+NsBFIW3cFpbIHdxp1i?=
 =?us-ascii?Q?pA7+mG9s1PBUDdf1/2iZsdMgc3ag4xJeXMapbYDNGW1D7oCT4izLH2KUTTN0?=
 =?us-ascii?Q?5DO1ytsL5xvJ6L9azIuNtD4rBIf0XzoCm8KZkmqnMEF3k4oS80gLG5OupL6W?=
 =?us-ascii?Q?k7N/23rKCx1PIu3A59OT3QnL152tIGP94i0y7auVUNXv7DVE1M8PdbCwy1e5?=
 =?us-ascii?Q?k88pX+NDxDbUpvixZY9fdYGAJIc+NDdy/5vo1NuCwOYmJra2Hq/W9m81ZEhx?=
 =?us-ascii?Q?suyzIWcdQzE8vDxg4RNlb3DRbpSRe+w6DIl1/NunQqi6VPvgIgSVHrPEMD5p?=
 =?us-ascii?Q?1RMSNinQKtjVT+S5sk5WRLbX8tccIKuJBVtE5YgPYAvle171R1ZBo7850HTS?=
 =?us-ascii?Q?dZi2Jbv9MhkzoiPmowNPpziqj+IZCW/v4FxC/u/sZus9V2BKrb+z1YNYt/lg?=
 =?us-ascii?Q?WYXxR1eXkAXrYWtpBsos29FbuXfo9natnajTk8OOaQ8Q5m6KgaNBzOQ7nnl9?=
 =?us-ascii?Q?qYqs+7UqvChJ7rtE2Qwzlv9qvhAmlImMH6EFzbU+2RinZFsTK/uWXIJUsMRN?=
 =?us-ascii?Q?W2z7tY2HEH78aJNcmOwxp609tqEa/vWI7JjG0EIiqNQFjM3iYnwtTSCDgmT3?=
 =?us-ascii?Q?5T16Iw7hycx9LQt3Is5+l3sMMvbt7UjcyOorzj/azXQK7VqsaoXuoyrHytAz?=
 =?us-ascii?Q?Kmn/ejElGY4UqBwwuGuR2FCbstbice4KrnA11NE/uR7uqSZJEG8awK9yqFjo?=
 =?us-ascii?Q?sNnJvyUHERtVePRTfDkIxkK2vwVcRGLMWMnKY0kQRM0b0A3thya+nuFd4y8z?=
 =?us-ascii?Q?9q0+0PLM6AXC691l6HJXz8NWDjfICwUtqPhJVr4BWMjgZl91QRCrVk4a9r9j?=
 =?us-ascii?Q?RSNNUULEJXf7LbXNOVwG6nPqg7X0S/3rIbn03UFFDIxa4GeLWOF2PBN0T2Jc?=
 =?us-ascii?Q?9Ef1l1Px+mlFf9AFYe6TMux74HnebNJUfHhKYUXDnXHUvdnKftlIb1cTVwHj?=
 =?us-ascii?Q?fubGfRShl41IcFBTlyFPIGbpxuSzwcsRGcp/Gycs6Ydj7oKh6ELzXTwvD/H8?=
 =?us-ascii?Q?BC43f2L+hojU0lG7N4bspfO18MJCpgqOmDi9Z1vs9MigdB4mdWHu9lpWJmer?=
 =?us-ascii?Q?l/NltWHxMgFdvB7ESryq51Z6yEbZXe3iseqxCx8paBFvj0EXVmHq7TU8P6+x?=
 =?us-ascii?Q?B+2mHqGlZ7PmQ3zAMmGIN06bjBFEORwryUiHDmOl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd89a14f-10b0-41ce-d543-08dc903def3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:58:06.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6xIrTCOE67UerOa/mm1NA8TOrdoqN+7ku1Lah18gAxUNjT8h1Y2es7Hd/4SlFyZ6SRPjsWvNr1roQsuk3fXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Wednesday, June 19, 2024 2:59 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hi--
>
> On 6/17/24 12:29 AM, Pankaj Gupta wrote:
> > Adds the driver for communication interface to secure-enclave, for
> > exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> > Enclave from:
> > - User-Space Applications via character driver.
> >
> > ABI documentation for the NXP secure-enclave driver.
> >
> > User-space library using this driver:
> > - i.MX Secure Enclave library:
> >   -- URL:
> > https://gith/
> > ub.com%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%
> >
> 40nxp.com%7Cd87070a111b24f3791e208dc8fdda85c%7C686ea1d3bc2b4c6fa9
> 2cd99
> >
> c5c301635%7C0%7C0%7C638543429374404433%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%
> >
> 7C&sdata=3DIYktUuoqdZgqHC%2FR1DbjAjQfhKDSjb%2Butki3j8LKBIk%3D&reserve
> d=3D0
> > ,
> > - i.MX Secure Middle-Ware:
> >   -- URL:
> > https://gith/
> > ub.com%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7
> >
> Cd87070a111b24f3791e208dc8fdda85c%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7
> >
> C0%7C0%7C638543429374411486%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdat
> a=3DGM
> > BlK9xKKdk6dAOMAMhaPoCRGFr%2FJTeuL9omwMvV49I%3D&reserved=3D0
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  Documentation/ABI/testing/se-cdev |  42 +++
> > drivers/firmware/imx/ele_common.c | 153 ++++++++-
> >  drivers/firmware/imx/ele_common.h |   4 +
> >  drivers/firmware/imx/se_ctrl.c    | 694
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h    |  49 +++
> >  include/uapi/linux/se_ioctl.h     |  94 ++++++
> >  6 files changed, 1034 insertions(+), 2 deletions(-)
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
> > +             NXP offers multiple hardware IP(s) for  secure-enclaves
> > +like EdgeLock-
>
>                                                    for secure enclaves
Accepted.
>
> > +             Enclave(ELE), SECO. The character device
> > + file-descriptors
>
>                                                          file descriptors
>
Accepted.
> and what is SECO?
There are multiple NXP IP(s) for secure enclaves.
Like: 1. EdgeLock Enclave(i.MX8ULP, i.MX9x),
         2. SECO(i.MX8DXL),
         3. V2X-HSM(i.MX8DXL/QXP/ULP, i.MX9x),
         4. V2X-SHE(i.MX8DXL/QXP/ULP, i.MX9x),

>
> > +             /dev/<se>_mu*_ch* are the interface between user-space
> > + NXP's secure-
>
>                                                             userspace    =
    secure
>
> > +             enclave shared-library and the kernel driver.
>
>                         shared library
>
Accepted.
> > +
> > +             The ioctl(2)-based ABI is defined and documented in
> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>
> > +              ioctl(s) are used primarily for:
> > +                     - shared memory management
> > +                     - allocation of I/O buffers
> > +                     - get mu info
>
>                         - getting mu info
>
Accepted.

> > +                     - setting a dev-ctx as receiver that is slave to =
fw
> > +                     - get SoC info
>
>                         - getting SoC info
Accepted.

>
> > +
> > +             The following file operations are supported:
> > +
> > +             open(2)
> > +               Currently the only useful flags are O_RDWR.
> > +
> > +             read(2)
> > +               Every read() from the opened character device context i=
s waiting on
> > +               wakeup_intruptible, that gets set by the registered
> > + mailbox callback
>
>                   typo in that name?
>                 or is it something that this patch series introduces?
>
Replaced "wakeup_intruptible" with "wait_event_interruptible".

> > +               function; indicating a message received from the
> > + firmware on message-
>
>                   function,
>
Accepted.

> > +               unit.
> > +
> > +             write(2)
> > +               Every write() to the opened character device context ne=
eds to
> acquire
> > +               mailbox_lock, before sending message on to the message =
unit.
>
>                   mailbox_lock before
>
Accepted.
> > +
> > +             close(2)
> > +               Stops and free up the I/O contexts that was associated
>
>                             frees up                 that were associated
>
Accepted.
> > +               with the file descriptor.
> > +
> > +Users:
> https://github.c/
> om%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cd87070a111b24f3
> 791e208dc8fdda85c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38543429374416161%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata
> =3DyEk2XgoKnQM6HqBqrI3Pu%2BYMSRld%2FY%2B1GCSyRgeM%2FAw%3D&rese
> rved=3D0,
> > +
> https://github.c/
> om%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cd87070a111b24f379
> 1e208dc8fdda85c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 543429374419836%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Du
> ND49ren%2FYcUM3kDOBRBYj6S8vbGbNDmzj2%2BZU5Xy18%3D&reserved=3D0
> > +             crypto/skcipher,
> > +             drivers/nvmem/imx-ocotp-ele.c
>
>
> --
> ~Randy

