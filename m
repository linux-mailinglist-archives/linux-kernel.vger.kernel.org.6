Return-Path: <linux-kernel+bounces-315510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B5696C381
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1691F26E25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E511DCB1A;
	Wed,  4 Sep 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fnu/wHMo"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D61DEFE6;
	Wed,  4 Sep 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466197; cv=fail; b=Npl2c4CLE0qALhKC0RE1xcR/Ruj5+Nc86lH3buGhdUZCLRpM4EKvq/CFqZ0W2jEEwsJVsu4w4Air4NQ+UVanJhqYIpupUVHCiqvagyJUZc/q4KUmOQ5gcoZyVFjMh9JBeeDc114ZeaN1/uyKRqc54HG7SRl1GUyzH9gRXzFKcGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466197; c=relaxed/simple;
	bh=UuFa7SE7YL5l8x03ruBNqnsFyS2y/tOistJKjqKNrAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGyq5I+c5pk/tO3CtSEXQqtddVo1MsRnSKXojuWpX5R50Ri3cf8TS+5DDXP2Cd2AjFVmu/lS/hGfhhOMMMjye2gmtHgvwDzNoWmMIgxqBTUoq4RZX5BKyO2rqap4uG9RTpcUIcDBwFBFK2+L32be2If/b0DcxHDn2HLYXXyDGcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fnu/wHMo; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUxczjdB0jtxpVzoHaZp7LY2LYC/5Np7Wo6mWx0CI92lvxnru5xxudZKr4vlyC5m5pRmuDDMnaKa6pkQYGKA8LrIiuFlLl+WwqTy35avODe5sp8Ug9AiZKRMq5UCvE+K1+zEOkDnoa1vhO0LhXaITak0TdTUG6QICOk8EiQSjnFGpbRXI0TRzfEOnpl7JvN03tSV/y6MY66JjqNT87Ug/GDWLawQ7wKIGgC56qpLZejmpsijWayyeJ82RgTkNYuQRVnGoLyFeD0W62cyY4jiS7bOxyvSio1lSrIPw+5zdiRLjzVC0gPRaDo7AIFWxLZ7x5AQSLANGkmtMf9u5Oqgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTQkVd08sacbx1jiJY4ESHEhLDpzcAuOe9dEIJLv7PU=;
 b=u1TmjMqm+rpft8X90dWtKKS4dRmjQDHC5wJ0UDXda0qZxgNF6J2AacWzjTOlAvfK2yNLVRJxw4tpIY/ftF54bzoZ6Nj4w8fZeIRMJm8gIcGF/Cy6r7x2fmamcK/a5x4rkL0/gf3sX8kYImoEkrgjDweOOjAnBhAlg+SznsijK6OJQ1RKLczkbTWJ6Mcc1KRQ+/7p/duS5e2rcPmYtl6x9o0i/go8HQxUQfcvwFVA06+l+9LQ/LRUZKj9VNBTfXPxSWCewJVnrs5MdYvP8YrAJdCjZp81WBIe8O4o7O0QrRW6YWBCdcxYTkI2VPWmG8tC+Jp3Dn3rm0LHR8+8wkcqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTQkVd08sacbx1jiJY4ESHEhLDpzcAuOe9dEIJLv7PU=;
 b=Fnu/wHMonRBWUQ7yZdLmilIpcDp4maiAchtS31qz39Rm+DAnABx7rZh5zQr7nYvkIcviOccZd/M2RC/cWv+1vCqAxBmGX+rynO1bCEf9z7GrdnwXZBdDVlcMEKpBKp2InNxY13/Ise/f+WYY2/TMk8M/NzefNzKNXuzS2p/sPggW0FahyHZUJHKUwsgGBblGVpPb9J9MZNMQFLgRSUwSefNcb2mt4xKM0XSF516Z1Me8hsXSC+08JQG4qF2ZI5LgN7QlKFifIY5sh2uuStuDgBVYNTziN8OmdzAoq0GROTxGOj1ZzLBbkiEReV5n2VTdnJiS/jgYaLsbfW+vrMJ94Q==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 16:09:50 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:09:50 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 0/5] Changes in v7:
Thread-Topic: [PATCH v7 0/5] Changes in v7:
Thread-Index: AQHa/rjzauVAcCiZRUeIb8TNGfWiF7JHvwaAgAAMaiA=
Date: Wed, 4 Sep 2024 16:09:50 +0000
Message-ID:
 <AM9PR04MB86049FFFCBB357E3BC1E4C90959C2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <Zth7LdsV/KbjzB2b@lizhi-Precision-Tower-5810>
In-Reply-To: <Zth7LdsV/KbjzB2b@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DB8PR04MB6827:EE_
x-ms-office365-filtering-correlation-id: fac45364-4653-4eda-fd27-08dcccfc0149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b5TgTnbnMXjOWJTFKjIXS02CSaNqzLbcRcapvRus9IDh/JKTEydxYc4d+Zmj?=
 =?us-ascii?Q?UsPdFZeNq6140iRQYJFbI9I/k/LqE8zxilAV+pjdlN2kIDtDxO7M6WcyEKXl?=
 =?us-ascii?Q?TbkHHYKt0JDvuunjnQJy5/AeivcM6HEaFi3h9mNNN908f7Ml17KLQzSRdFOd?=
 =?us-ascii?Q?X6yxU8u60a47FTjwjSLkVpiFe5EwrvBNXh7uRnxQEMo7EPmV9A0Wgs1cybt3?=
 =?us-ascii?Q?yp6+ey9ALe6E0F1tVPZs7x02hHIpy+gYlwID634JifZCBxrVGfKH/wsxYHWP?=
 =?us-ascii?Q?t28Dau5oqL3vzlOtnU7lVMzJY8UYT1e/l5r6fFNmiQWr6xtEprToAMeHrO9+?=
 =?us-ascii?Q?14vV03g2tZqw/FD/jNRsgyrgK7XJ6Zay4xp3rmBQBJ855Buei9A8nZgWe3LT?=
 =?us-ascii?Q?Qx61DPxbr6/As0c9SzBtA4nGP/hIbrMp9UbOexSrowXkvEDodBnHXfOGgecU?=
 =?us-ascii?Q?ZvJbYRtUSyfFg+YuOzKcyOyX0UXu/KzpVrq+kZrzLVoLvQycSTsnFAKrl+yD?=
 =?us-ascii?Q?AOgANFtv7AB18zTLREzaGhluBIQ0glwR4yzGVM8lH8GvW23frL3/Fttha/Xp?=
 =?us-ascii?Q?/FkUUxTviu5WornHQusaiL4pVEVmQRXiaXWdM9jod2hOUOvR4aMZlKHTmqbS?=
 =?us-ascii?Q?ygrJkuzo1X7iuIawlUP3IUeLo7nlAIjnqoqA6cP30u/OslElW3EVnY7XhMVF?=
 =?us-ascii?Q?vlIEoGOZR03VRqbASM1jWOi+HW8C5gAYcEFJpZFrj7mnB+cioqnWJbZ19a7+?=
 =?us-ascii?Q?HXyZpAfnQI36MdkzDkbae6zO528y3N6qKWTc8in4hKcvxU64cP1f1znwnV2L?=
 =?us-ascii?Q?8+FnX43L6rD/Eo8LhxdqM0SiW3s7Bh2WSyKJlFSo26LdG6EcGgZmq92i+2Im?=
 =?us-ascii?Q?9XVAe29GkDftu0/HKutETvvb+icTlWd3ew5338lji2TTclzUxXlpoje8dzbr?=
 =?us-ascii?Q?BrYR8tn5sKl7kodzGR8zFs5l/8lT86kgEaT30A3x7TLGk+moZ0SETJGbC0g1?=
 =?us-ascii?Q?ToK30sW4k4oNInJRsPBwgrJA/0pO6A4sWMtcultYHnilH3ImrrM5NxqS/w3k?=
 =?us-ascii?Q?7H8Q9WDF2/3p/aOubwavQJxjIAZkfJf9PxvMb76Ek98kogyHvpmZFzTZRLTy?=
 =?us-ascii?Q?wUgcsAguXob46qP+q0SIo4NUR49ej7M/DwoSZwvlHw4DiFR9bgGDAytArtrb?=
 =?us-ascii?Q?pSf5ykFA62qcwdgMhBMk5LL2voI10+tdKzQ98WUIa7dkePO0luZSnMZOL+t1?=
 =?us-ascii?Q?ImKwD+XneoTKnrwF7PJj6JwGUN/b4Ib420Nz+5yIz0gR9zdtge65fOurnyZl?=
 =?us-ascii?Q?iSrTJLtdmMPD+zB0NE8CRQXG3rqlrTVcA4QS/XOeC4s2pvDCkiHr9uIBu27d?=
 =?us-ascii?Q?u9CPw68S4zXmpdbzhzugrb+LcL9pFyHP20MJj3xBQZQDXrZW6A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gPJgNfp7+p9+iXM7Xe/EayJgPq4/kfSd7JHdJn4x2XFnXMMq3Fztys3mackR?=
 =?us-ascii?Q?Cev8DqUW08P/YLkAnCcA+pCKtBOzwUtBo38kiz66zqcQKQfGLyMVus5EU9g1?=
 =?us-ascii?Q?IxsU3X7nfvCHg8pYze3ga+OdEa6ZQb02ooMy36xhEc8TB8yW26XI+xrTFLXr?=
 =?us-ascii?Q?BxIbXuUsezMF5/AW0WatbU6/uO7vq6IjFOTdt2uprlyp2UgD1Eck9XhyMitd?=
 =?us-ascii?Q?t5pa/uNwYfszf/ZAa68+T1fNc4MhXb+eEyhziceW24xZWDXkmD/h3rmxROd4?=
 =?us-ascii?Q?bwSE+PTcsGa+bOdfZ31rG1YonHELVioatX7jDj8CyAGVWo3/TxcWGgtQr2eR?=
 =?us-ascii?Q?7oeS0qwgm2BX6D9SH/bRWASM990xJaK3mK3/BQFZG2ELMFtbUIfCh2uCjd+Q?=
 =?us-ascii?Q?kORSX+PlOPLweeenizjK5apGyB0bhH4loULQIs5iNlo+mSitd6Ie3Q8qJygH?=
 =?us-ascii?Q?4R06O5+RAl0cXf3zcW3COo6NOd8HLvjuxEx9L8yjL+Uasv6lLD4KtuWGMDLx?=
 =?us-ascii?Q?8T5NTM/fG4BuH3bvU6nHR+Q1SDzAwoSnI71FIwTbdiWUttQTtj235QuGSZdt?=
 =?us-ascii?Q?7D6t9K0y07tIb2KzFWUKaiO3BU5RstU5sXp4vwgcUfRjO58HxSpmgWV+SPYw?=
 =?us-ascii?Q?Sw30fSNo8QNeFNP1O0URKn4v2/c9bfb6aVzyIoFgBZuRDVT5Ym3kYJmTATBs?=
 =?us-ascii?Q?xFcWHHiBUAYrvKKbNT/rGNH4EI8Ug2xyTymC3/wXemqrkjt/pKasNBw/c+NB?=
 =?us-ascii?Q?AXzDLFjPZpbMqsejKeo9s+1J/Fhi5JV3n/HPDe6E2JwzU1cDalc5r79weuEr?=
 =?us-ascii?Q?dmjouB7ToFXBf0LKq2vMrinY7eCCCk7z1Cd9nqZ2HCNI18E+0HIM8s0j/qFh?=
 =?us-ascii?Q?5veZZ9SXoA3YlP/4LpRK041xs+DJNF71eHxzwx9CWC2AeHQWwyVhCqp1ON3X?=
 =?us-ascii?Q?oE1wyjILx+MRwMMqt9dZYKHOO7ab+Mqzc+hDQgzWxsxOd5jw+08R5wkdMz+p?=
 =?us-ascii?Q?QX2HxmIYgN/giRxGVA1K+138h2tCGa6jtSwPWbZPFfRGBxkmIPb4VdFIffXI?=
 =?us-ascii?Q?5BHUBe1KZ3/w0AYUQai7MkIV8/mSlKsnNUB7pbTuJnHR1ebO8SQjveOEtCPl?=
 =?us-ascii?Q?Q9NA0HQnYDhRcUjJgpcXLEhcw7R1dICEsIdfsmfELtnT3rwrc5EdDBm76kao?=
 =?us-ascii?Q?PyKQ9IVQ0MEszj7C1l3hQzC3BtLtsAa34xBXFimoGZlykLNvmo0UVFTLNCxP?=
 =?us-ascii?Q?l9leqGk6VV8ysi3LneUZf2g3RZP07OAxPSM+mChzc3LrGej9Qu4sHOrFFL3j?=
 =?us-ascii?Q?m/LCfY52h+fjkzJit8+yfQU/Fi1N+jukInBTfoLv3IB1nmFIhVCHr5jY0pOt?=
 =?us-ascii?Q?SLRPuJRjNtgQsJJ0pdPm4T+EC8VOPGeTHzu6NwFoy5M34hOrxbFo/6Q7vlsD?=
 =?us-ascii?Q?KNwfdjnDipsATtFm0E4t/TcOAfV1Uqy4cPcetKKV1216YG0mqNmNYe6THeTO?=
 =?us-ascii?Q?XAPb2km8gQPpSs8GiFzTgwjbv9vr9aAKcM/ppAK/3SXrsK/hcKYS8lBOCTV9?=
 =?us-ascii?Q?/67/0l9lYUzKxZpz/tVd664Vm1x9MAc6IDyU5OWQm7HpAZ5agAu+sAqn7BsY?=
 =?us-ascii?Q?Etn64comAlEPX/nGghhGGgFlib+nIi9lE4m/e3vJZ4Gl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fac45364-4653-4eda-fd27-08dcccfc0149
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 16:09:50.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO8guFkP5nZOGxGg+bknRo5azJGMPUXgkn9K/1zhmKn09wmOt1+gPVxzeCDuWkxwX/yf8x46OTnicmBobblRRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827

>=20
> On Wed, Sep 04, 2024 at 04:21:16PM +0530, Pankaj Gupta wrote:
>=20
> Can you fix subject "[PATCH v7 0/5] Changes in v7"? I remember someone
> already complain this in previous version.

Thanks for pointing it out. Will ensure not to repeat it.

>=20
> Frank
>=20
> > 5/5
> > - struct se_clbk_handle, is added with a member struct se_if_device_ctx
> *dev_ctx.
> > - func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are
> removed.
> > - func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the
> > func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
> > - func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv=
(),
> instead.
> > - Mutext "se_cmd_if_lock", handling is removed from this patch.
> > - func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in
> fops_write.
> > - func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in
> fops_read.
> > - fops_open is modified to create the new dev_ctx instance (using func
> init_device_context()), which is not registered as miscdev.
> > - Only one dev_ctx is registered as miscdev and its reference is stored=
 in the
> struct se_if_priv, as priv_dev_ctx.
> > - Separate func cleanup_se_shared_mem() & func init_se_shared_mem(),
> for shared memory handling part of struct dev_ctx.
> > - Input param for func(s) ele_msg_rcv(), ele_msg_send() &
> ele_msg_send_rcv(), is replaced from struct se_if_priv to struct
> se_if_device_ctx.
> >
> > 4/5
> > - A new structure is defined name struct "se_clbk_handle", to contain
> members processed in mailbox call-back function.
> > - "struct se_if_priv" is modified to contain the two structures of
> "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
> > - func ele_msg_rcv() is modified to take a new additional input referen=
ce
> param "struct se_clbk_handle *se_clbk_hdl".
> > - func ele_msg_send() is modified to take a new additional input tx_msg=
_sz.
> > - func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_s=
z &
> exp_rx_msg_sz.
> > - func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg b=
uffer,
> instead of header value, as input param.
> > - each caller of the func ele_msg_send_rcv(), is sending these two
> additional input params.
> > - func se_if_callback(), is modified to work on two structures of
> "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
> > - Variable "max_dev_ctx", is removed from info & priv struture, as well=
 its
> usage.
> > - New member variable "se_img_file_to_load", is added to structure "pri=
v".
> > - Other member variables - rx_msg(ptr), rx_msg_sz, completion done & li=
st
> of dev_ctxs, is removed from priv struture, along with their usage.
> > - func se_resume(), updated to wakeup the two "wq", part of "struct
> se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl=
.
> >
> > 3/5
> > - Node name is changed from senclave-firmware@0 to "secure-enclave"
> >
> > 2/5
> > - Node name is changed to "secure-enclave".
> >
> > - Link to v6:
> > https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com
> >
> > v6: firmware: imx: driver for NXP secure-enclave
> >
> > 5/5
> > - replaced scope_gaurd with gaurd.
> >
> > 4/5
> > - replaced scope_gaurd with gaurd.
> > - remove reading the regs property from dtb.
> > - Added NULL check for priv data fetched from device, as a sanity
> > check, for ele_base_msg apis)
> >
> > 3/5
> > - replace firmware with senclave-firmware.
> >
> > 2/5
> > - replace firmware with senclave-firmware.
> > - drop description for mbox
> > - Replaced "items:" with maxItems:1 for "memory-region"
> > - Replaced "items:" with maxItems:1 for "sram"
> > - remove regs property.
> > - remove "$nodename"
> >
> > - Link to v5:
> > https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com
> >
> > Changes in v5:
> >
> > 2/5
> > - updated the description of mboxes
> > - updated the description & items for mbox-names.
> > - updated the description of memory-region
> > - move "additional properties: false" after allOf block.
> > - removed other example except one.
> >
> > 4/5
> > - Corrected the indentation in Kconfig.
> > - info members:mbox_tx_name & mbox_rx_name, are replaced with
> macros.
> >
> > 5/5
> > - Replaced "for  secure enclaves", with "for secure enclaves"
> > - Replaced "user space" with "userspace".
> > - End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a
> period.
> >
> > - Link to v4:
> > https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com
> >
> > Changes in v4:
> >
> > 1/5
> > a. Removed - from EdgeLock Enclave.
> >
> > b. Removed , after "Each of the above feature,"
> >
> > c. replace "can exists" with "can exist".
> >
> > d.
> > -messaging units(MU) per SE. Each co-existing 'se' can have one or
> > multiple exclusive -MU(s), dedicated to itself. None of the MU is share=
d
> between two SEs.
> > +messaging units(MU) per SE. Each co-existing SE can have one or
> > +multiple exclusive MUs, dedicated to itself. None of the MU is shared
> between two SEs.
> >  Communication of the MU is realized using the Linux mailbox driver.
> >
> > e.
> > -All those SE interfaces 'se-if' that is/are dedicated to a particular
> > SE, will be -enumerated and provisioned under the very single 'SE' node=
.
> > +Although MU(s) is/are not shared between SE(s). But for SoC like
> > +i.MX95 which has multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE=
(s)
> and their interfaces 'se-if'
> > +that is/are dedicated to a particular SE will be enumerated and
> > +provisioned using the single compatible node("fsl,imx95-se").
> >
> > f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.
> >
> > g. removed ","
> > -  This layer is responsible for ensuring the communication protocol,
> > that is defined
> > +  This layer is responsible for ensuring the communication protocol
> > + that is defined
> >
> > h. removed "-"
> > -  - FW can handle one command-message at a time.
> > +  - FW can handle one command message at a time.
> >
> > i.
> > -  Using these multiple device contexts, that are getting multiplexed
> > over a single MU,
> > -  user-space application(s) can call fops like write/read to send the
> > command-message,
> > -  and read back the command-response-message to/from Firmware.
> > -  fops like read & write uses the above defined service layer API(s)
> > to communicate with
> > +  Using these multiple device contexts that are getting multiplexed
> > + over a single MU,  userspace application(s) can call fops like
> > + write/read to send the command message,  and read back the command
> response message to/from Firmware.
> > +  fops like read & write use the above defined service layer API(s)
> > + to communicate with
> >    Firmware.
> >
> > j. Uppercase for word "Linux".
> >
> > 2/5
> > a. Rephrased the description to remove list of phandles.
> >
> > b. Moved required before allOf:
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mboxes
> > +  - mbox-names
> > +
> > +additionalProperties: false
> > +
> >  allOf:
> >
> > c. replaced not: required: with properties: <property-name>: false.
> >    # memory-region
> > -      not:
> > -        required:
> > -          - memory-region
> > +      properties:
> > +        memory-region: false
> >
> >    # sram
> > -    else:
> > -      not:
> > -        required:
> > -          - sram
> >
> > d. Reduced examples. keeping example of i.MX95.
> > e. node-name is changed to "firmware@<hex>"
> >
> > 3/5
> > - node name changed to "firmware@<hex>".
> >
> > 4/5
> > - used sizeof(*s_info)
> > - return early, rather than doing goto exit, in ele_get_info().
> > - Use upper_32_bits() and lower_32_bits()
> > - use rx_msg here instead of priv->rx_msg
> > - Moved the status check to validate_rsp_hdr. Rename the function to
> "se_val_rsp_hdr_n_status"
> > - typecasting removed header =3D (struct se_msg_hdr *) msg;
> > - Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* an=
d
> se_*, respectively.
> > - Removed the functions definition & declaration for:
> > free_phybuf_mem_pool() & get_phybuf_mem_pool()
> > - removed the mbox_free_channel() calls from clean-up.
> > - Flag "priv->flags" is removed.
> > - Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup()=
.
> > - Replaced NULL initialization of structure members: priv-
> >cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
> > - Removed the function's declaration get_phy_buf_mem_pool1
> >
> > 5/5
> > Changes to Documentation/ABI/testing/se-cdev.
> > a. Removed "-" from "secure-enclave" and "file-descriptor".
> >
> > b. Removed "-" from "shared-library"
> >
> > c. Replaced "get" with "getting".
> >
> > d. Added description for the new IOCTL "send command and receive
> command response"
> >
> > e. Replaced "wakeup_intruptible" with "wait_event_interruptible"
> >
> > f. Removed ";"
> >
> > g. Removd "," from "mailbox_lock,"
> >
> > h. Replaced "free" with "frees"
> >
> > i. In mailbox callback function, checking the buffer size before
> > copying.
> >
> > - Link to v3:
> > https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com
> >
> > Communication Interface to NXP secure-enclave HW IP like Edgelock
> > Enclave
> >
> > Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock
> > Enclave, V2X, SHE etc, is based on the Messaging Unit module that
> > enables processing elements like ARMv8 core, RISC V core, within the
> > SoC to communicate and coordinate by passing messages (e.g., data,
> > status and control) through these interfaces.
> >
> > The NXP i.MX secure enclaves hardware interface kernel driver, is
> > specifically targeted for use between application core and NXP
> > secure-enclave(s) HW. It allows to send/receive messages to/from the
> secure-enclave.
> >
> > Patch-set adds the kernel driver for communication interface to
> > secure-enclave, for exchanging messages with NXP secure enclave HW
> > IP(s) like EdgeLock Enclave, both from:
> > - User-Space Applications via character driver.
> > - Kernel-space, used by kernel management layers like DM-Crypt.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >
> > Changes in v3:
> > 5/5:
> > - Initialize tx_msg with NULL.
> > - memdup_user() returns an error pointer, not NULL. correct it by addin=
g
> check for err_ptr.
> > - new IOCTL is added to send & recieve the message.
> > - replaced the while loop till list is empty, with list_for_each_entry.
> > - replaced __list_del_entry, with list_del.
> > - Removed the dev_err message from copy to user.
> > - Removed the casting of void *.
> > - corrected the typcasting in copy to user.
> > - removed un-necessary goto statement.
> > - Removed dead code for clean-up of memory.
> > - Removed un-mapping of secured memory
> > - Passing se_if_priv structure to init_device_context.
> > - Updated the below check to replace io.length with round_up(io.length)=
.
> > 	if (shared_mem->size < shared_mem->pos|| io.length >=3D
> > shared_mem->size - shared_mem->pos)
> > - Created a function to cleanup the list of shared memory buffers.
> > - Used list_for_each_entry_safe(). created a separate functions:
> > se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()
> >
> > 4/5
> > - Changed the compatible string to replace "-ele", to "-se".
> > - Declaration of imx_se_node_info, is done as const in the whole file
> > - Remove the unused macros from ele_base_msg.h
> > - Remove the function declaration get_phy_buf_mem_pool1, from the
> header file.
> > - Replace the use of dmam_alloc_coherent to dma_alloc_coherent
> > - Check for function pointer, before calling the fucntion pointer in
> > imx_fetch_se_soc_info
> > - Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
> > -  Removed the unused macros WORD_SZ
> > - instead of struct device *dev, struct se_if_priv *priv, is used as
> > argument to the funtions:se_save_imem_state, se_restore_imem_state,
> > imx_fetch_se_soc_info
> > - Removed ret from validate_rsp_hdr.
> > - changed the prefix of the funtion: plat_add_msg_crc and
> plat_fill_cmd_msg_hdr.
> > - indentation correction for info structures.
> > - remove the check for priv not null from se_if_probe_cleanup
> > - Removed the casting of void *.
> > - se_load_firmware function is corrected for not freeing the buffer whe=
n
> allocation fails.
> > - Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
> > - imem.size has type u32. return value from se_save_imem_state() will b=
e
> assigned to imem.size in case of success only.
> > - removed the flag un-setting in case of failure. priv->flags &=3D
> > (~RESERVED_DMA_POOL);
> > - removed the function call for devm_of_platform_populate(dev);
> > - Checking for not-NULL,  before calling the funtion pointer
> se_fetch_soc_info.
> > - Removed the checking for reserved memory flag, before freeing up the
> reserved memory, in se_probe_if_cleanup.
> >
> > 3/5
> > - Changed the compatible string to replace "-ele", to "-se".
> >
> > 2/5
> > - to fix the warning error, replaced the "-ele" & "-v2x" in compatible =
string,
> to "-se".
> > - Added an example for ele@0 for compatible string "fsl,imx95-se"
> >
> > Changes in v2:
> >
> > 4/4
> > - Split this patch into two: 1. base driver & 2. Miscdev
> > - Initialize the return variable "err" as 0, before calling 'return
> > err', in the file ele_common.c
> > - Fix the usage of un-iniitialized pointer variable, by initializing th=
em with
> NULL, in ele_base_msg.c.
> > - Fix initializing the ret variable, to return the correct error code i=
n case of
> issue.
> > - replaced dmam_alloc_coherent with dma_alloc_coherent.
> > - Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
> > - Replaced -1 with -EPERM
> > - Removed the safety check on func-input param, in ele_get_info().
> > - fix the assigning data[1] with lower 32 address, rather than zero, fo=
r
> ele_fw_authenticate API.
> > - Correctly initializing the function's return error code, for file
> ele_base_msg.c.
> > - replaced 'return' with 'goto'.
> > - Use length in bytes.
> > - Corrected the structure se_msg_hdr.
> > - Moved setting of rx_msg  to priv, into the function
> > imx_ele_msg_send_rcv
> > - Will add lockdep_assert_held, to receive path, in v2.
> > - corrected the spacing at "ret  =3D validate_rsp_hdr"
> > - FIELD_GET() used for RES_STATUS
> > - Re-write the structure soc_info, matching the information provided in
> response to this api.
> > - The "|" goes to the end of the previous line.
> > - Moved the locking and unlocking of the command lock to the caller of =
the
> function.
> > - removed the safety check for device private data.
> > - Structure memory reference, used to read message header.
> > - In the interrupt call back function, remove assigning waiting_rsp_dev=
 to
> NULL, in case of response message rcv from FW.
> > - do while removed.
> > - replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
> > - The backslash is removed while assigning the file name with absolute =
path
> to structure variable.fw_name_in_rfs =3D.
> > - Update the 'if' condition by removing "idx < 0".
> > - mbox_request_channel_byname() uses a "char" for the name not a u8.
> Corrected.
> > - devm managed resources, are not cleaned now, in function
> > se_probe_if_cleanup
> > - Used dev_err_probe().
> > - Used %pe to print error string.
> > - remove "__maybe_unused" for "struct platform_device *enum_plat_dev
> __maybe_unused;"
> > - used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG,
> MSG_COMMAND, MSG_SIZE, MSG_VER.
> > - Depricated the used of member of struct se_if_priv, bool
> > no_dev_ctx_used;
> > - Moved the text explaing the synchronization logic via mutexes, from p=
atch
> 1/4 to se_ctrl.h.
> > - removed the type casting of info_list =3D (struct
> > imx_se_node_info_list *) device_get_match_data(dev->parent);
> > - Used static variable priv->soc_rev in the se_ctrl.c, replaced the fol=
lowing
> condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if =
this flow is
> already executed or not.
> > - imx_fetch_soc_info will return failure if the get_info function fails=
.
> > - Removed devm_free from imx_fetch_soc_info too.
> >
> > 3/3
> > - Made changes to move all the properties to parent node, without any
> child node.
> >
> > 2/4
> > - Use Hex pattern string.
> > - Move the properties to parent node, with no child node.
> > - Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x=
:
> failed to match any schema with compatible: ['fsl,imx95-v2x']"
> >
> > 1/1
> > - Corrected the spelling from creats to creates.
> > - drop the braces around the plural 's' for interfaces
> > - written se in upper case SE.
> > - Replace "multiple message(s)" with messages.
> > - Removed too much details about locks.
> >
> > Testing
> > - make CHECK_DTBS=3Dy freescale/imx8ulp-evk.dtb;
> > - make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j8
> > dt_binding_check DT_SCHEMA_FILES=3Dfsl,imx-se.yaml
> > - make C=3D1 CHECK=3Dscripts/coccicheck drivers/firmware/imx/*.* W=3D1 =
>
> > r.txt
> > - ./scripts/checkpatch.pl --git <>..HEAD
> > - Tested the Image and .dtb, on the i.MX8ULP.
> >
> > Reference
> > - Link to v1:
> > https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
> > - Link to v2:
> > https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com
> >
> > ---
> > Pankaj Gupta (5):
> >       Documentation/firmware: add imx/se to other_interfaces
> >       dt-bindings: arm: fsl: add imx-se-fw binding doc
> >       arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
> >       firmware: imx: add driver for NXP EdgeLock Enclave
> >       firmware: imx: adds miscdev
> >
> >  Documentation/ABI/testing/se-cdev                  |   43 +
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
> >  .../driver-api/firmware/other_interfaces.rst       |  121 ++
> >  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
> >  drivers/firmware/imx/Kconfig                       |   12 +
> >  drivers/firmware/imx/Makefile                      |    2 +
> >  drivers/firmware/imx/ele_base_msg.c                |  286 +++++
> >  drivers/firmware/imx/ele_base_msg.h                |   95 ++
> >  drivers/firmware/imx/ele_common.c                  |  318 +++++
> >  drivers/firmware/imx/ele_common.h                  |   51 +
> >  drivers/firmware/imx/se_ctrl.c                     | 1305 ++++++++++++=
++++++++
> >  drivers/firmware/imx/se_ctrl.h                     |  151 +++
> >  include/linux/firmware/imx/se_api.h                |   14 +
> >  include/uapi/linux/se_ioctl.h                      |   94 ++
> >  15 files changed, 2610 insertions(+), 3 deletions(-)
> > ---
> > base-commit: b63ff26648537a5600cf79bd62f916792c53e015
> > change-id: 20240507-imx-se-if-a40055093dc6
> >
> > Best regards,
> > --
> > Pankaj Gupta <pankaj.gupta@nxp.com>
> >

