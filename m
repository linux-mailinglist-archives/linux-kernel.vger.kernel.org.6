Return-Path: <linux-kernel+bounces-400179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B59C0A0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8703B25232
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24A213134;
	Thu,  7 Nov 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="X0BQ2Jxs"
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020127.outbound.protection.outlook.com [52.101.186.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E82101A4;
	Thu,  7 Nov 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993093; cv=fail; b=tG8N+SlSC8J612/jzUcvpTJnMyYm8AEpGzUHCotFFWixGbLmHi82X662U8jGWByM3Eot4uvpTJd01tR4ttXUI7L2wslp8E9Cav2ZrQAiPJ0hOaK7XEcG7LcvMMRAyzfq9RH5DiJiCMIoTXUzugtjUhWgNy6K2uDswC0tMNg9VDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993093; c=relaxed/simple;
	bh=qk0Ocum7fmjkcQ4dsvv7LA9vmffRUc7Mm0II7H0gy7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfsG7Mw4VvHNAIPsHrc4W7ZAi1bEIVjRUq8U/uHvlAs6hEVFJDobJtzKjNdkq4WwxVxrBxiji9sZGNy56YkUHVfLYEQPfrVet+iJofNzH4cjcXSclZAWstyyM8tslaK5p4LFju4XxCfjoU8k6k2Q0G26ENTBXpupStuEhbxrTRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=X0BQ2Jxs; arc=fail smtp.client-ip=52.101.186.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF4d+JgolwyO+yMya5BH/CjnytiO+L1VAxAVgi3mwhcJi5YenhqxIYufNCvxRnb36GUGAlzUNMD03648/cftijZDRbE3VelibNx/aYDXoe0+tAxF4bUVp8UPedWjUI9MR3GSXLTDZCH1Rm2Hhpv+emds/dGo7FNtt8Fb7MoW4TF2+P3AUKEUqHJ4kwMlYQAw2YlYXpZ2c8l+ux5eiatY2qhfriB9ugvSSay8RmJgwb8Robm43SOtUxi4laIwTfkkfZ+OibkXitOG8iRHmlvjsJx2LdFvxKkcLQEmfMgVsTjyEJ/FA6ksSPGd9YKv3kQZQoz/jdxPm9IT0b2Je7oHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB3ZjyJbCFJr4ygRmJJFa6hpifFlf2izZSsVkQqY5OA=;
 b=wX9dnaMWgoPbGBB28aqdse/BvVijDBD++znR0MhWJi56b8ylB+2hdITSeSAZ8KTWWFKbxgKlQYMNxXglflCkU4qBtJDji22+oh+tCWxRev8lo91eWJwHMRCNTQofc13hCgBowI9p75gSwOCTQGMS5FJoQBfX2W1GeJruwQw8Z0B9U4vqodzTkA6DE5CvhlkpisQyRY8N1/8Gv3EeKNMRK46+L5c4x1ufnzIVbZYbWg805VRBfBMZtnDGbhuzCySagJ3QzmsNHsWyyblfG5hk5eeSt9UZwVpa/Qi5pZeFWMeP3OinxRHKcyH42Eq5Nhuw3qEqWql0PK45lIzMpqe3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB3ZjyJbCFJr4ygRmJJFa6hpifFlf2izZSsVkQqY5OA=;
 b=X0BQ2JxskBqIlIPo8JN147AchYwrnR0lePfKoAMQ+y87RNdzt+rTx069/A6gRrkI47zMpB5TnkBZPusQNcuSctsW/fGqTc9oByVkSBPBIv+o69qTI+QpB4aRAupcZBn7acHXaQIRB9syVkPMHq3TvKatfW5pVOGJ5sRILccEQFE=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 GV0P278MB0784.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.21; Thu, 7 Nov 2024 15:24:45 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:24:45 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "von Heyl,
 Benedict" <benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to fill
 typec_cap
Thread-Topic: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to
 fill typec_cap
Thread-Index: AQHbMQpZRMDOf5Sy+EeARSygMyuP/rKr3nQAgAAHWRA=
Date: Thu, 7 Nov 2024 15:24:44 +0000
Message-ID:
 <ZR1P278MB102298AE3011962AEE1BC91E9F5C2@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
 <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>
 <ZyzMzEHA9DPMc_z9@kuha.fi.intel.com>
In-Reply-To: <ZyzMzEHA9DPMc_z9@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|GV0P278MB0784:EE_
x-ms-office365-filtering-correlation-id: 75465ef9-1997-438c-1770-08dcff404f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OpislTQwuiQJlu79jpPm94LXdTe+PGSjOQv0kWamQBP1lDA5evGRPahUeP?=
 =?iso-8859-1?Q?/LxFphDRJPI9z63aSl490F/zWObJCifGZDHwQkLc5SWSvi/m6EyvvtRt/y?=
 =?iso-8859-1?Q?ag5PyefoRMASSPPjm6D6bYi67eBz2LX1e8B9FmvtZX+MmL3FboyOgp590S?=
 =?iso-8859-1?Q?rZLHIbNhY8RL5W/5siuoOBJGQQpgIlroydEbMMlzMWezy9DLibSWGJzpGT?=
 =?iso-8859-1?Q?VqQxJLP7tBg7ToQK+1rz1NAKeoTe1d/qso9RAvaVWIPF1x52WmFYUjGSqx?=
 =?iso-8859-1?Q?gUBPrFSmdooJp6Wv5mhAHQEp2Gv0DjR0FHAjDo6D3UZC7AvkCjxRDGlU6Z?=
 =?iso-8859-1?Q?uiju4a8gxSnSNWWEbSmZx6+rrVlrB9kwe/wylP/H26LrkUKdfecE45UHrg?=
 =?iso-8859-1?Q?YEUZCAHMknPLkezNPmRba2yCcC6MgXNixOtuU8eURIprRbc5NUM5pH2jeq?=
 =?iso-8859-1?Q?3RPN1xTLXq2vLdDZZxhk+xzaGUL0qTtmEajTDV2MxlQ4vlJaDmM1AjKqsa?=
 =?iso-8859-1?Q?gt9rropL+ARbimr0HmCqJQooJHw25X+F10yc0JD/8ZiYZd60mhVR6Z/0ur?=
 =?iso-8859-1?Q?MaPksfZY0bfzYka2GIVrIevrid18SBrGWfi7eBlN22YbUsV8UXZTav6zsv?=
 =?iso-8859-1?Q?36jsE8yT5EadWmXbiztrTSf0JJiB5jaS2SgvZDEeJMXkws+60W3EVR/X79?=
 =?iso-8859-1?Q?7IUBUoDJL5whT3oXIFy8Gb1iCTWGYsj+dfsQj8Lo7rR2JMwMhieXpWanUw?=
 =?iso-8859-1?Q?114zAmcRaa88DzsxE1BOSt3W/TbpDWfBKrhnK3k0AQIUAV74mhKpswuYf3?=
 =?iso-8859-1?Q?eXqNPg6uN8JruOzgFVO69MI4FnTOM8C/5QO5H0i+q+XeP91ezdBY60cS04?=
 =?iso-8859-1?Q?0VdM5jyXcBT9wpjpL3wQEIdFOClN0fN4aFErJWz1HAnbtXX6/fYjiZJacQ?=
 =?iso-8859-1?Q?mG2V4cZrX7jMvMjgTOZWIAy49a14CwFZwMCBff9MHZOUK42eTgWbVRKvsW?=
 =?iso-8859-1?Q?9FYDoCgXhynCLny7RPRph4JzDmTtN8UtAWdaf1ft8rNJJ3mrATvcfRF9du?=
 =?iso-8859-1?Q?7Dqpe7CdC5JegjbnsFfpmwJumycx1EHldUYQ/BywYtgF5J2Z+ksS4Fdi9A?=
 =?iso-8859-1?Q?ZeQpJTDPs7ZKJ0eXSTSYR/YgwDSkFc42n6BbavH/AydOWab7vWbaO+/0SG?=
 =?iso-8859-1?Q?6e/S57wod+qMGpMHgL+p7QRoJeLmZSDlKgh4Ck3VX1Xb+v8wo3Y+rd/q3t?=
 =?iso-8859-1?Q?G5Y98FVeidb8bSw6ZFqPFKyHDVGM3JT82knU4rEAF2HaQU+a8FRFFrgcZI?=
 =?iso-8859-1?Q?QQ/JueeOgix5VWD84pvFmUb0cyGx1hcBcIAA6G6irMysXFGBDLWYzQJYwj?=
 =?iso-8859-1?Q?kwF79TCUXNUkDc+Ffh0ZFzIWu/NvrUPNoGD+JvBlCg4W+Tv8jCnIM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NGYpy14CnS8uKVKzeZy2XUC4QbvPE5uuIGCmucFHAe9dRj+8hL0pnWM1Pv?=
 =?iso-8859-1?Q?tb8Eu4EEpv4iXqGc/eewZ6J6GUVsHWPcj7WwthJkhG/8xlzHdikk9b01yL?=
 =?iso-8859-1?Q?aj+/qkUcwnc6Skq08gMBFMgqjxxMflNXBhXWlzeQ0K6OzDAAbdtOkO/QAi?=
 =?iso-8859-1?Q?6OnfSKA9pOPKJB0mtAZ2h/5qh+n6H1AaTLvCfr5HdmI1sPZX2q0CplnJEB?=
 =?iso-8859-1?Q?twaZTJP7BEFA2Y8KCrRbvL3uxlycwEQY2u4j0Of6HAmXbSZtleZEc/g4Vh?=
 =?iso-8859-1?Q?SiyjgyS91ELjANlNbVgSj1+ZPDBgrHnYCEDJbw70jCW1sJ7KTxb/7TF4ml?=
 =?iso-8859-1?Q?0d/VG861VkdaSzCjOcXnxEK6ckrrUGrUgq1xLIP2Wq7EcEQkbhgGiWqFkp?=
 =?iso-8859-1?Q?+K/HfVm/dLCCFxbIQo6NKo5OjbZ9KuEb7UoVpJ9BEq/6Y6JHogKHJ8V+Ql?=
 =?iso-8859-1?Q?QbA5wtWVYzeWor+soLqBf0MT1brET0cIjykYpt/d4imiR2cqu2zTka4YY8?=
 =?iso-8859-1?Q?sEyzCxVEj/PIWzvd8snh/IC+1/xZgo4gXXsT6WUbWp8WIM+PsBR61svL4s?=
 =?iso-8859-1?Q?YpC6um5Ne/i23smYOrqYGC0ipeXwjh2KZ1HoMaC84+UURlU/G4cq3HtjTd?=
 =?iso-8859-1?Q?c51AKbz+8jX/agh5VrPI3VCJWfkb5IIBdWRzc9zHN0ePO4N3kTHfgEIcNs?=
 =?iso-8859-1?Q?cgaCvwSyim6X/EcKlp5M+i+Khd3tMcIKaW69UdN7WuYIFdkrtcQNE6gs5y?=
 =?iso-8859-1?Q?k1UXqh4C14YSlrXLY/MlFPHbKrw2WICCR/uIPfvvthLa1CrFpjvXhOMfBR?=
 =?iso-8859-1?Q?6RsJlYMuqvcetpZZs4FtFBEjU/bvNmontsz/D0+IZ3YDhVSY1IBfWZvnFT?=
 =?iso-8859-1?Q?pzDUhyvxmMfhlBD1ey2Wgm2imLcsms+tvGSzzqpLGQxp9xRvXWtQMo643Q?=
 =?iso-8859-1?Q?yqV46Okrbss201OP8n+bFBolZpuaNq+URM3pZ/hduqEqpV34N4sJ0SqT7U?=
 =?iso-8859-1?Q?JfbcKUawPGMjgg4VZhE88b+ObT+zoV0p64TLxlqgmc8F6Nkcs/Lqjuxy9K?=
 =?iso-8859-1?Q?XIHGzrHlEhv0xnKrg3QtFqASelRJPjg3OcbAbQcFcNE36Hx0yDQPpsVCgN?=
 =?iso-8859-1?Q?JmRbsWRdtc/E/RgFHpdwb+ZuRFauO23Gil4cxyqOyPtJDRoB9bTcHV1cNi?=
 =?iso-8859-1?Q?2fwIN/13Kao43J6bG7zySOxAaoeU4p4jnEmpa0Go+QFZvsiuVAD4miODrO?=
 =?iso-8859-1?Q?klCpF08DQIeujjmnkOn7hEf4IKxNAEOfa+QN6dpi0K/yJ9n9bLYRAd7VLE?=
 =?iso-8859-1?Q?QqUBosk+qDyUG1ewluYW9FhHHPaooX/AqsuaOKzbvhvVE/sJpY1v+W8qL9?=
 =?iso-8859-1?Q?Tj3u33pC84LYJKMB1WjA1mg4axbdeoW26p7pwBnLfqf46MS8ApCBNEXWUB?=
 =?iso-8859-1?Q?kkfKbomxJnnIP/Vh/LeH4xd1rtKrakwkQleatP3MeJ122FdE7HKcqJ9hD9?=
 =?iso-8859-1?Q?M9At/y3WobvIVs3cSKWIv5jnQHQXhyKeQyDgUN8NuVAzox30ldcVtNC4ng?=
 =?iso-8859-1?Q?T3my3mDwYkJFTiLBZt0aFQ2n9CdM/b/5UmOjh4caI5D/FYxpnGBCrQeLzo?=
 =?iso-8859-1?Q?BRiRZXOGL0bVZ9ZMYpo9/HC7HEjSB6qakg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zuehlke.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 75465ef9-1997-438c-1770-08dcff404f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 15:24:44.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2AbbfIegn8VaRM9a5xILTldgkIHcBeYg/9e05WMB75dzgSNsJ8pfjiCTSUWWyToVdZnyBMq8LY38bJ9C5cJof9WSV8OUxRlMwFCkWVlJ2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0784

Hello Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Thursday, November 7, 2024 3:21 PM
> To: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; von Heyl, Benedict
> <benedict.vonheyl@zuehlke.com>; F=F6rst, Mathis
> <mathis.foerst@zuehlke.com>; Glettig, Michael
> <Michael.Glettig@zuehlke.com>
> Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to=
 fill
> typec_cap
>=20
> Hi Oliver,
>=20
> On Thu, Nov 07, 2024 at 12:43:28PM +0100, Oliver Facklam via B4 Relay
> wrote:
> > From: Oliver Facklam <oliver.facklam@zuehlke.com>
> >
> > The type, data, and prefer_role properties were previously hard-coded
> > when creating the struct typec_capability.
> >
> > Use typec_get_fw_cap() to populate these fields based on the
> > respective fwnode properties.
> >
> > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > ---
> >  drivers/usb/typec/hd3ss3220.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/typec/hd3ss3220.c
> > b/drivers/usb/typec/hd3ss3220.c index
> >
> 56f74bf70895ca701083bde44a5bbe0b691551e1..e6e4b1871b5d805f8c3671
> 31509f
> > 4e6ec0d2b5f0 100644
> > --- a/drivers/usb/typec/hd3ss3220.c
> > +++ b/drivers/usb/typec/hd3ss3220.c
> > @@ -259,12 +259,12 @@ static int hd3ss3220_probe(struct i2c_client
> *client)
> >  		goto err_put_fwnode;
> >  	}
> >
> > -	typec_cap.prefer_role =3D TYPEC_NO_PREFERRED_ROLE;
> > +	ret =3D typec_get_fw_cap(&typec_cap, connector);
> > +	if (ret)
> > +		goto err_put_role;
>=20
> You are not leaving any fallback here. Are you sure all the existing syst=
ems
> supply those properties?
>=20
> There is another problem. At least "data-role" property is optional, but =
that
> will in practice make it a requirement.

I missed that typec_get_fw_cap() was not setting a default if the property =
is absent.

>=20
> I think it would be safer to use the values from the device properties on=
ly if
> they are available. Otherwise simply use default values.

I'll add back the previous values as defaults before calling typec_get_fw_c=
ap().
That will make data-role and try-power-role optional again, as intended.

However, "power-role" seems to be required by the function. Is this expecte=
d?
Or should I write my own fwnode parsing logic?

>=20
> >  	typec_cap.driver_data =3D hd3ss3220;
> > -	typec_cap.type =3D TYPEC_PORT_DRP;
> > -	typec_cap.data =3D TYPEC_PORT_DRD;
> >  	typec_cap.ops =3D &hd3ss3220_ops;
> > -	typec_cap.fwnode =3D connector;
> >
> >  	hd3ss3220->port =3D typec_register_port(&client->dev, &typec_cap);
> >  	if (IS_ERR(hd3ss3220->port)) {
>=20
> thanks,
>=20
> --
> heikki

Best regards,
Oliver

