Return-Path: <linux-kernel+bounces-571156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17DA6B9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010E87AA7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC72236E9;
	Fri, 21 Mar 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="LgMfr6RA"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BC1F03F3;
	Fri, 21 Mar 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556360; cv=fail; b=jVAGhK9hxzwedimwMdEGFbzJxbNa5XkVWTgF3XaYi0TqyQor9YDiK8JqMy8cM2AXOU6WiZ+q2GCQEdU/WkVMqhNLTYpMDNBKHtDm0lobm1Sm5P1tuhJdw2ngAyAXeOQ2yo0syX0KtYN7GrWm9IaWoaqhInV/w8aDjGLgbfZ/yu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556360; c=relaxed/simple;
	bh=t7z0APYeJy7yURnQeOtoEC0utGJy816d4d4RVY0E6bI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7y85/1QYXN7918Obi53sgJUqn0vlgE0Z0YUdyZZ3OyDhoXrik7OT1LcFb/0rzD9b4XBVDMYL7Rksd1PtSsnldVRjFyTHe0/WbkSiUkkGykQBkSO25B17JwKtHpI8AFOYhk2RP1R6bQndvYKWx+QL4IENhIPy5jmdWD3Cb/3THA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=LgMfr6RA; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwNykYkXcxSRTuXAvQHbw0QkjFVSlWcVb2cPAPraOeaxGcQpruNYDxI0P+cx0VCW1SJc1Kmhx2qonpj3Dp24zOtpU+NHGbu3sgBw7PZ9Xdk/ZQ75SZ91vJoZ/q26JzRbDSeQn1TSXnXSwLMpleLpy1hcsrI49xihhKXeOSr/hJ8s2X2APRcBwOhcC2/KF8Vib+PDNXYu5uQsHxHVtZF6dZoCX/158mxoRaW7okCta5lgh3aNsWBUl/iHyib/urEpEPExceKEdeEhiKGaTJAAfHMXkDwtAEhkM6Drn6Rfj7XGPaoqZmM55TR3Dk9jRK4KTbqA08AcI6i0j9r00zmMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7z0APYeJy7yURnQeOtoEC0utGJy816d4d4RVY0E6bI=;
 b=Z4CgRUJDYE+i7WYsGX7r0oyM0WdKoLXtp/AmTlj70O4TPnpO+xG6/mjNcmEaMoY1tkRp5vXfAr0bgehLA89HxoLRbtEM6um2iw4wh317J0tPm7ncsu55tjH3Zc0Wpre4WVD3JLRwsnfYdVD8ptwC03WRZqA/Gq8WvqcSXv26E6UJIqyALBLk3heClpibSrGw70VG4ATmSr8x6cD8ySVcxVghU45jReBQ+iCgJ9gsz+LgH/8Yb4+NwNmbWFiFriWXlZERdDWNelM8kxw//cTO5GNuCBN+wi8AFGF0O8NJ0N7zcQ59fRe1xh+mGC+Td3ZMLPkzJf1yLCBFbfrlC7XKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7z0APYeJy7yURnQeOtoEC0utGJy816d4d4RVY0E6bI=;
 b=LgMfr6RAw6xAutDfLW/+p0QGIwAztaumvQ0JlFY2VCYYB4bixS2y6Z4jK7aNs+xerEmVO/3DwYaoEzxjbf/onD+V7mbhxB/61MDUWglyh4Y59F+lcvPbhbJfUeKBTWb5HxT0jI6hcQBA+yJ9OQBmBPRiB+u2yr1eyAo99VRlSYY=
Received: from SA3PR04MB8931.namprd04.prod.outlook.com (2603:10b6:806:381::22)
 by LV3PR04MB9220.namprd04.prod.outlook.com (2603:10b6:408:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 11:25:56 +0000
Received: from SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d]) by SA3PR04MB8931.namprd04.prod.outlook.com
 ([fe80::f323:b482:8b18:af1d%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:25:55 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Min Lin
	<linmin@eswincomputing.com>, Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Yu Chien Peter Lin
	<peterlin@andestech.com>, Charlie Jenkins <charlie@rivosinc.com>, Kanak
 Shilledar <kanakshilledar@gmail.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia
	<a-bhatia1@ti.com>, "rafal@milecki.pl" <rafal@milecki.pl>, Anup Patel
	<anup@brainfault.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Thread-Topic: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Thread-Index: AQHbmlQDH0NeIyhgX0KZua2i5HA+WQ==
Date: Fri, 21 Mar 2025 11:25:55 +0000
Message-ID:
 <SA3PR04MB8931D68EA57B0A4275FDD6E783DB2@SA3PR04MB8931.namprd04.prod.outlook.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311-backdrop-porthole-440ae005e8fa@spud>
 <SA3PR04MB893164FCD6C4CB8924FC8DE583D82@SA3PR04MB8931.namprd04.prod.outlook.com>
 <20250320-uprising-couch-0af012a1fee6@spud>
In-Reply-To: <20250320-uprising-couch-0af012a1fee6@spud>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=e992cc37-5758-4a78-b717-c94def3b5169;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2025-03-21T11:21:58Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR04MB8931:EE_|LV3PR04MB9220:EE_
x-ms-office365-filtering-correlation-id: 99f0678c-ae70-4454-29ee-08dd686b25a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ylvbBuVizme7sNP9mSAv7esia4G9Y51GaV3XvF9/8zmnzaaivudeNc9MyEZc?=
 =?us-ascii?Q?HiIdHeGUGfbf3xtL2WT0zgIZSE3xkMciIz2zEVMZVbMPrx83W+GB3y6P6BdS?=
 =?us-ascii?Q?VW8B4hhqfkAqbQXoWICEZ2UQghZiw7IcC/Y1izADkNHpjFSJ5EFk6jwR0n1w?=
 =?us-ascii?Q?kd2nHRmqR3szpyZB7HG9Zu33/JDu3UNLii2Qzv3nB88/XCI3wED2R4xsPSfT?=
 =?us-ascii?Q?WVzmdGGrWxFIHdKBPNCGvu1Y6Rn1ZRXH2Z/meg0tt0OXGq+aYf704AIDM76p?=
 =?us-ascii?Q?Sw3Kwg4JjIqYuiNCmlIJq66xevJkh88lobtIIHV/p0r/Pi+9n3J8MYDrTUF9?=
 =?us-ascii?Q?aInralk6KPoFoz0Vl59EBW4Lhc4ISUF0/0PqAizS8ZROKQlJowfFKcKTZO3O?=
 =?us-ascii?Q?Pgvi6ryN2XOepW08Z0VSUtBFTZ1iNllk+cjCA6TVrhTmi9PsYHCEooR6CsHd?=
 =?us-ascii?Q?b5Tr5IoSyXMYMBbCd/EnxhkzPfJzjC9Hatd+/hmzJfvShYpIRw0jSCmf3QfC?=
 =?us-ascii?Q?vtPohgaioPE9lWHVOvsVYSbY5wxyOBzUqNHDef6QfObz+JFa1Vxh7srfOGIl?=
 =?us-ascii?Q?JxmQe8kbSp9aLa15knBAbUVY6SOAG0CuFEoBPaZCvd5P2z/t9s7W8TMM1zpE?=
 =?us-ascii?Q?l1YfxhDfO3hGFt1omZeIt8gTtApxyHlZ1lsgjYymP2l3XIaP9lza4rMitzEi?=
 =?us-ascii?Q?Qoph8J4tph7dGn2vaQtRuNSmyoveFlZXXNcDgpWLIKSCDgnTNGIiBibNBJBd?=
 =?us-ascii?Q?EnHIf2MTCLDrUZ8PIuvbVzPSZTACev1hTAkqhd7MwkqNyRZ0avUYqAX60oDx?=
 =?us-ascii?Q?YUOqA8tycx7Qgwu8vR7qki4IInQuhXoc3Q3G/dVWhaONh3jo9WSJJhx3a4qL?=
 =?us-ascii?Q?EhU1Fr4H1nxBpXnqvwm19wKZn1o2iP1/nvUPLOfxPPrkyaydND3FMI6O/39Z?=
 =?us-ascii?Q?uxQKh9dkBGmGieBvr2jGhOIBp5yTC43r1TEHyu+QE7gsttftXO2pKuKK9obl?=
 =?us-ascii?Q?YwB97xZq7R/WedIbK1O2eIVI0kV1TouymLDacaGPNXy6blmw7r4A2hoPi58w?=
 =?us-ascii?Q?hulX+5Fd9Rsq/hPHedbHPZcPZbCCxnkwkGJcNqTMDMlBFpPwxDtjeJhhW5uU?=
 =?us-ascii?Q?pC/df6g8S/weqE8O6hg4nlf/gZA/LR7noxcx2gqcU3zT9l98+nLjfxS9aCJo?=
 =?us-ascii?Q?YYgnxVs/gVvXFbaGK76t28yH8v19mQNe+EnC4NsBuafzYwz1Ft+HE/mAWzJq?=
 =?us-ascii?Q?EmxWLq2fDueJ2BT4Zs8V4qxTOQ00N3gnSvFyq/zuXM77ZvZeKvu1KCoWT5XN?=
 =?us-ascii?Q?4n5/i3XMR/FrOJ8kmvLmrjCNhyYkX8OStbca7iobWXml0PqqsvkKhj3ONrx9?=
 =?us-ascii?Q?Mu9msu6csbEZ7fIpDTOCW+G29HkKVbcRpR/bt5czfIaNctd8gL2LEzuODU2g?=
 =?us-ascii?Q?NJwP7EzHZrkYxv5Dbl8XONX7sa5ksJQE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR04MB8931.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O0fr4hggPqxT2btZ0dyZaE2/HPg4JbKp+Sl3lBEiDTIrnVJ8JiSD9dTG6s7O?=
 =?us-ascii?Q?zZhfW5HWDJmGSHW0CWFYGErwzYVeZHh9rTheXk8rRcl5TMbK7/7ki9g9D4B1?=
 =?us-ascii?Q?qUIteYixh7FFvxLFxz9YF8+7ISJ8j6UDIrA4mOqBlOmh22l3Mn6C/h3PI53e?=
 =?us-ascii?Q?HIENx4/HhIcpAhT+MM+fc7ZjfjpcW3pGWYKNGYcAny7iAkQaSZN6gGkCcnSa?=
 =?us-ascii?Q?/s9Upa2zX9VzX4MPhacHEdwAYC+Fkbd8FOLklNIwXynE6qMRQ+T2HMD0qBui?=
 =?us-ascii?Q?T/uMDlyHnxA99PBqk/yk/nmYtiXv+DyG0W2hxqQEx8UVuncrIcx0TJe5JEXA?=
 =?us-ascii?Q?bF/CzLI+okHLQl5Qdez6KpdTxArVTJLF+c6F3Wl6SOs41aC7tV7S9Jzygy+Y?=
 =?us-ascii?Q?FoG7ypbNhYz4d1JT/ikpuk/oLI2Vu/7nHp9OwsNaEoJEcRhY1ryz9nudrkYo?=
 =?us-ascii?Q?/fSRaDHr2ZBX5i50KFfeCp77HxqPiva33HG9fIsA62sAyvok8jTKUqkdK9lx?=
 =?us-ascii?Q?G1ks8WmyJaTrTD2kHFvpTQ9t6egMs3gHx1PZGrUEsk2n4DGC1dib1oKNW9Xz?=
 =?us-ascii?Q?grYtAvatrgMY4dZX9mYOXhyH1D0fXbrCmds1fwYKlkb5otQnv8PGRPwxvnx9?=
 =?us-ascii?Q?5U+qFZr44xWvq4CKr9x9JnXgE8TehI3NeuLtyPWaspCYxEhbhNyeuczZ2MA9?=
 =?us-ascii?Q?n/MRRInoVhlP66aedjW0ZoP4h4tPY3FsIPtr9xFVtl2TpIGtXWNS1IS0OtH0?=
 =?us-ascii?Q?ShgD/0oIP47nUd1h1KSLpuGrHbRxCLkaA2fJQMsAMvIfsaIYT+oEY0ddTyYm?=
 =?us-ascii?Q?FMEwsBdEPM8+yjoorT0iUhAJGEPKb4wJ31hBZuWInUligaTRsmWmKQlA1rss?=
 =?us-ascii?Q?aRcdFY5cnYnptwpWGjco41hNSTdkfYCHSfyhHrPhnbQeee2QCGhc7qV3DFsv?=
 =?us-ascii?Q?RwlvUZDttXZwrKI6iK+e2k/3owy+A7VkCZMLCx2+3TSSf+SqDd3YfOtFftla?=
 =?us-ascii?Q?E74jyXxh/dcj7W2mluIawDvLBzJGA5iXo5DHMVm40mchHu9TQY40vBLixFfv?=
 =?us-ascii?Q?8qyz5c5Z6jmtil4MJYnt772AMmNv37LVF+NwKrv8AqulAnFBSDam3/5kJgFA?=
 =?us-ascii?Q?SCQ/Y08tW3qQi0wcaAQ20SOCJCyJjzHmBklvvw2Xb6wnXKGwiy0C4nWxnGkd?=
 =?us-ascii?Q?N2UnIxyr7FBpCW8hz5D7tVWTTtqiOxYefF/+3Dykfzz+dFD+68Fs1dLAI/ZT?=
 =?us-ascii?Q?dmjFh01ivvuMQqYicgQSb/KpgzqPOHtaH/1WdlGQp+PqAIik36F1OdPkBxxv?=
 =?us-ascii?Q?cf/f47EwJ+andgEj4jGEGjHZOn8XIH62aiFmDOQgt8XF95KSK4JrbP4sJpFs?=
 =?us-ascii?Q?kFoiVHy9CuTBwGT9E59NNxH64RQ12UOEMZ1+BMWoqolUQftO8SdsFzgVDoxR?=
 =?us-ascii?Q?Vo/JymbqAVEb1ipv4j6ehC+63u07FzDDD9tYMZhzRq76zd32lSd5Zmyahktq?=
 =?us-ascii?Q?qDG+0mjXAbTlxeWKuP/RBIzvf/0WR62qcf+V8GWfx0JTVsQ4kLiE6r1xNdXz?=
 =?us-ascii?Q?c7EcmbfQ88xZObMP1yV0IaXSJDDrS5SAmUL59KLtrX9wCLPc2cS1p9yIDCBp?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR04MB8931.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f0678c-ae70-4454-29ee-08dd686b25a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 11:25:55.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCIy5Q5MznGtXu9mwq4Vf55CuHlXbymyS5RKHdvEoh0QGvQbI4LadXmMjfTjj9gm85lfZ+SSBcJGu34C1Uoxhz9VNzGxfL37uf7DEAausKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9220

Hi Conor,

On Thu, Mar 20, 2025 at 5:31 PM, Conor Dooley wrote:
> On Thu, Mar 20, 2025 at 10:39:52AM +0000, Pinkesh Vaghela wrote:
> > Hi Conor,
> >
> > On Tue, Mar 11, 2025 at 11:38 PM, Conor Dooley wrote:
> > > On Tue, Mar 11, 2025 at 01:04:22PM +0530, Pinkesh Vaghela wrote:
> > > > Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> > > > P550 CPU cluster and the first development board that uses it, the
> > > > SiFive HiFive Premier P550.
> > > >
> > > > This patch series adds initial device tree and also adds ESWIN
> > > > architecture support.
> > > >
> > > > Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive
> > > > Premier
> > > > P550 board using U-Boot 2024.01 and OpenSBI 1.4.
> > >
> > > There's no git tree in your MAINTAINERS entry, nor mention here of
> > > what the story is going to be in terms of sending patches to Arnd.
> > > Who is going to be doing that?
> >
> > We are not currently set up for sending signed pull requests, so for
> > now we plan to send changes to Arnd as separate patches.
>=20
> Undesirable, but sure. You didn't answer the first part of my question th=
ough,
> and there's no git tree listed in your v2 series. That part is not negoti=
able, you
> have to have one and get it included in linux-next.

Thanks for the clarification. I was in impression that if we send patches=20
to @soc then we do not need to mention git URL.
I will add this in v3.

Regards,
Pinkesh

>=20
> Cheers,
> Conor.

