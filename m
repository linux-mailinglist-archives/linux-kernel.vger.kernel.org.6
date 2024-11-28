Return-Path: <linux-kernel+bounces-424733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4549DB8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A65163658
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE031A9B4C;
	Thu, 28 Nov 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="e+oPs6DI"
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020131.outbound.protection.outlook.com [52.101.188.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7C1A29A;
	Thu, 28 Nov 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800692; cv=fail; b=u7AijhG4yGAkT1SOPssOGuAeYvl2yQsVk43aBme0h+c0qeNSowzPFuUvarlJlo1Q6DjT3+tyyFV+qnxratQUk2VjmIRJG8ybwuC1BkhOkBQI8a842xQ6IhwVTDJjflYkTzIdUuURF/Vbxg4w2v8n7AC18vuic8hzYdewOUFwwKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800692; c=relaxed/simple;
	bh=Kz8cuO0oO3xYy7tzdUg5U4wR+/si2KnJgfn6b8nkP6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sf8joHlCcB0elCDsPPNbswdi+/StLWWUD7aNFjxSEAbmbFdrdAY6yW084nMBZNZHhEFolHK3A3JCuD5UoisgbvjEsxqJWwhdPCq0kCXPFyQ4pr1TftaNWMHNdiQYxWy+GuVDP5/6jFGDL0/WBabB1D9CHDPN/Z3JbHxU4yUDLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=e+oPs6DI; arc=fail smtp.client-ip=52.101.188.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBCFpX8FF/UoV0gDZ0HEDPzTNtPDVJSc2dbR+tZ1eCw0BI7pnq1lOrjFkWwfVlPLlHDhbhv84pU/T6GeSi90VsgqVtOswcFrGA1VXlRqzz9HAlT7SMtzTl6JcT53tU+/OlR7P8BkQM/6nOucKTLGpN0AoEUCw40ODNm9Q7rsKtFApkjux179tVuqijFOULEqniMyn9igirtazPhqzmrUlR6+K+8I+vEHvfhR39vtcVQ8hc2a4YWPJ5qB6VjGUrSs7TUmo0D44WPvExkDi0umi5F7LoCChrUHA1UZNfQxxUbvQorpa+a4PO8RP6VvVgtmrYLSsREmdD8iUksy0S3OZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W+OFBZGLeI/soXLWYMWc7ViCXe/YFxZ22AmWcLxtE0=;
 b=LxcB8svjLnklGjc0dws6TG1j/QTtWIdFgzVPLQCZXoxmakCImrr6PTzYK6v2Dtk5DHpyq3vpe2Itm0LsV7x7OlWX1HjyRcPzotWdMp8EXvkjqUdCpjceJKyQ7tGGDQjVxga920mfbvP93rd35JZZAYj3ieBRantDUWZsyC4AJmR/idUp9dgftDCwqM/jlsm/fH6PWdk2ptdh5rSKKCpOoLSCNiEQmnsXJ2trSIdHxCg7v4qPzyBpckMMtvR2EAHU0yIvn5/BYPeL6Tyc8nVMBXmRbW3tNPvphYhfkn5X2iPAAWbDo4I73b1jnp+JVjypJSVRNWPHfgXfXaHGjtDXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W+OFBZGLeI/soXLWYMWc7ViCXe/YFxZ22AmWcLxtE0=;
 b=e+oPs6DI1NjghzU/Zas1DF1srHg4LhoAKsdiM6w2h1w3KZITcK5eFA9Lei6kGtJ+rl00Eh7k5LL7a+bk8iRz526erqeO7TQYcqjBw4hMCP6esjee6eUfWwqwHuqBpdTGGuF94NDcf3eSwD/GhcW35zIxyPYMNGuxU7wLnMqNCKM=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 GV0P278MB1570.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:62::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Thu, 28 Nov 2024 13:31:22 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 13:31:22 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index:
 AQHbNmuKAbQgSYuDD0+aIkfTlZwMRLK88xQAgAAYJXCACtFsAIAC7fPAgAH3oQCAAAPlEA==
Date: Thu, 28 Nov 2024 13:31:21 +0000
Message-ID:
 <ZR1P278MB10226AAB6D237E96CEEE05719F292@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0hs1ougC6HSt5KO@kuha.fi.intel.com>
In-Reply-To: <Z0hs1ougC6HSt5KO@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|GV0P278MB1570:EE_
x-ms-office365-filtering-correlation-id: 57c6530d-c3b9-4cc7-4502-08dd0fb0f2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Lv6HqhMHrQzVdb3w15lMZMXiT9Tj2zJm7+poQEs9TvSGXLZwWDu0Q0DPYx?=
 =?iso-8859-1?Q?UN7bKcMXmsNSeBwEltyTnz3efOvakoJdJIGs7r0CYPTRgU9/NRB6OXUS4+?=
 =?iso-8859-1?Q?8Ez9hu0J1DUKM9aNzoptZ0+fhOBzTviEuJtjLt1n4fHpZpTebRcXh90o/q?=
 =?iso-8859-1?Q?9gu1Lk7pEEM/veqIdFjuPv0j0SSivXdKgZYkYNZN8IpSpv3EJGPmEO+vwY?=
 =?iso-8859-1?Q?pD2w/K/ccJrNDZb8fc+YCqOn4HsphCsyJsI5GpjFlvPOuAKxXHtkOE+fw9?=
 =?iso-8859-1?Q?AQ9pzWPNZbpk3PWKHqQ56Np/zu09iRnqrb8RE5BXU/41lpUeRwGuC//8EP?=
 =?iso-8859-1?Q?GwRS9ScmPOKH4KQTRKyc7VPk0jre2PIwWdAk2fnyyhGfIjC254mOOWBgFq?=
 =?iso-8859-1?Q?iOA+FJGJRh7XT+RL4UoZB/P7YkXeGz4/r9LnrZHQwN0Rc+pbfL4mUKCaJw?=
 =?iso-8859-1?Q?bS8prH/V35A2Q5jOlUu8sBBkHBNO2pvpwjX5w0xsCbFlDrKti9JLpLJcIu?=
 =?iso-8859-1?Q?sXp5IpUwGeeagivGGDF8ctaOkFP4Id1qkVGQKVi8JTBZAWGkxWVDcyGim0?=
 =?iso-8859-1?Q?4yMdJRpUU/n5a/lpiqci4dcCJFhiDVGmTgYUzUYQoNtM20Jp2lgmjB1ub7?=
 =?iso-8859-1?Q?QMcduOzoBqAwZNJkmSXPV42l/LK97ieaJUQ/lMUV4CX9IPBCdsyiDGKihh?=
 =?iso-8859-1?Q?1aiUiBibljjBVjQ6IaAKGY9FOK1bHVYK8bJuF2YOC4uEUSrebIsA2AlqFa?=
 =?iso-8859-1?Q?EQipe3Hcak/a8vItf/C9FG8GfMeOpMKZB3r5CZJ3EZUFbMLfxPTydalGmf?=
 =?iso-8859-1?Q?etbiDuRzI4SW/9DxNZprXRRlm4zenYZ7RKx7+/ndQfJ0LaQdn3GRHPM5Sr?=
 =?iso-8859-1?Q?B5X8T+FfUX6tL+xqLJH76CasD8ZtCYg8IIVdFc+Ddooj0YEE7ajufWhuqu?=
 =?iso-8859-1?Q?CxnfR7azjWaHZ5EIltRjxu3DoDaS+zqL3Jf8WlXshoHodR+O0i6ydsTYnF?=
 =?iso-8859-1?Q?IVfv5edd9FoBGUyK+087Ood80XR26n9gou4SybJcsUNP8Blv9PZysd9uBo?=
 =?iso-8859-1?Q?bfVjl0/sEcubusDVYzAHAlLHZmAt60oZ75Qv55Hbdp1QKjVYrq7wYVkIkt?=
 =?iso-8859-1?Q?mcK5IBl5mfmj+xApO67Tph4nNX8IX0w6NdktzDxbtXV07eH6wHAsvW0lQ0?=
 =?iso-8859-1?Q?1/+n04lR4Z4OLPvoNsixzjaefete2PFOMSkSfoFYZggYEYfUsIvL+sxlmr?=
 =?iso-8859-1?Q?XgFWcFV3rLwXaDlR0hE88tdz7HPxqAYbBEz5dsdDiSDWe04dtojJOn9E7i?=
 =?iso-8859-1?Q?t6MQ9dxfliFwonUFKlDNzx/RKdeE8+4qFo22uFLPdyV7xbmb/SQTfmON3Z?=
 =?iso-8859-1?Q?bXw9CUi14lPEmC7u5C4MC6wIjF+wJaSSvoJAH4ppbwyPN/3P8WaTSuhFs9?=
 =?iso-8859-1?Q?Rq97oHmjUdubUKQ3NhKt9UDL0O0BJEW23x2m7Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?27H5uXh2QwzQ/ZULw/NY4xOENQcTjra7DOasiL2jW1Kurf8AvJrIydJoZJ?=
 =?iso-8859-1?Q?7Y6dU7vdL252+U3e0rzcJlIX0dxRWlLw9k1yvgQpJMVQGyOwfD4YcOYN7D?=
 =?iso-8859-1?Q?Ua6L3DrqT96FrL3Afmc5kDLDZbw6y3/FPu9NxHIeHdpH+wrN/5ePRcQ7cl?=
 =?iso-8859-1?Q?y1MMrMYo9x1dtsOfZI3fxeJ7vQrCCno4e6CC6V/cbh8kq+1q8WXPBNmyft?=
 =?iso-8859-1?Q?quDuRtOrmBUIhJu9r0qiYvl3XDYMSgAYVy1W3C/dGn44BP8QbygAgUb7gX?=
 =?iso-8859-1?Q?faNAk5YzbLIuNu84YU+sSc24x3m5L/qL8T9kOnit6qf0OxHTyigGnjewM7?=
 =?iso-8859-1?Q?7loFy1AA4V+NugrX7dmMt860oIuV8fqhM6FKzMG4F4+8zXa6HPxYN/xWYQ?=
 =?iso-8859-1?Q?FgzAm6Plh/OQtCy7U6b/5IiOWotGApXeh+iqek+WIxm5SkqW8r62kansPu?=
 =?iso-8859-1?Q?lLmQWKDepjXFpzZP2XUnJizMhxzMMRAeXvdqc6IKNUbiMZd8uIg90VN+MR?=
 =?iso-8859-1?Q?YmjlUoOLu/a020pWTDlTizvTXFWtLGRIHy0hi4Irpe6e0LxHBjOTO96UMs?=
 =?iso-8859-1?Q?Qms5jwmhCx0MBGbJMwft+pLYgrtnN4iWG9UPkhJQK0Hn7fThPxXOk2Z6ET?=
 =?iso-8859-1?Q?W83+ouMDNlg16beZCsSiYD2cdUbO4Yhi+KMs1ChbOohPJeDwnfqnTXvux+?=
 =?iso-8859-1?Q?AVs6t9UrZsnC9pZ900sZxb+rUUcW/Bg05gScjxy9/mxxZWfGag/PMPTyVH?=
 =?iso-8859-1?Q?bbuAEUiNHMG2PS1uEQU54OClwvfnznbLrN1+egqcTI2FxbFSxX/HiqKeON?=
 =?iso-8859-1?Q?rRI+fyLOYt1MrX3BjJpD+DxaALFU2Jl+GswqUKOjf1z4DooOKqLOReYzCW?=
 =?iso-8859-1?Q?bh1ouWiiPoIzzhNm7s2nlBoPRtCfLH+CG5s/zpQ9uGP9dVr9phjiqUC6K/?=
 =?iso-8859-1?Q?L68+qHDPmPpjUJuuggXfz2tgk88kKrz1GnBLSyyJmFSTDgTZANxGq7CQj7?=
 =?iso-8859-1?Q?mXcewq26PLGCvDC6MfHSALE3ObV8uN0LRqKhzYx6mt/IY1liPQRamgFTUc?=
 =?iso-8859-1?Q?iVD1wRIwVLtILty+d8Zsufqjv+w9Te+7qH7d8rp3GtQCIhysN+Kowsz/CH?=
 =?iso-8859-1?Q?9/lW/a3heknCEVt6TdBmkw/UtHSQ08Sbn/KSXOrCAIlotIEKRw6g6x3GZ1?=
 =?iso-8859-1?Q?cH1xXJnu3hAPDD2gGTEVVR6pXyvnfNsNhcb7nT4lhwD1mZQvFAoc2ue7V1?=
 =?iso-8859-1?Q?kKn3ERucvBGBCLjWjZvjFdlaGFKz4oxNR/mTitNo/rPeSkBZCVFxLoa8ah?=
 =?iso-8859-1?Q?C7Hd3t7nrEpXuCf2AsnK6JaLipcK2TPzEJ0fJ/8n1GfZzdWCNbdSUyfOMu?=
 =?iso-8859-1?Q?N4xCih3VIRcSV4b22+BckiMZiU/FzAxLcr4HQAvFxf32IHHaRT92nLKAYM?=
 =?iso-8859-1?Q?sgK39q+QOo8Rzb8a0u6SY11REuEmlLnKx+q3Jx78KosewQDfi1+7S+SjGe?=
 =?iso-8859-1?Q?cYt1BQQ4eDIwkiPq8NWSyQtCDHfBjpibVZXRqzXV06WWu2lxKlyFaG55xq?=
 =?iso-8859-1?Q?GiddKl0lADJBMvhlJXbPiv/kakOfRmrk/R2aIDdoKWhje2hH3sGd124ByA?=
 =?iso-8859-1?Q?gxiigvkK+rBH29ba7IsXtaG/DszcxgEzGHQStc/33wGmGKVj6gZu3IbQ?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c6530d-c3b9-4cc7-4502-08dd0fb0f2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 13:31:22.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctJtfLfR/MPxBitP3+kp1Tcpz8xmJh3zHkE1xMCUM1y9lGAqTzUJVsmhZ8fhGaJrZ7cEOy+AEToLnA9IDhFehygs0+3xKYMqeSKGUemjYuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1570

Hello,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Thursday, November 28, 2024 2:15 PM
> Subject: Re: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring po=
rt
> type
>=20
> Hi,
>=20
> On Wed, Nov 27, 2024 at 08:02:55AM +0000, Facklam, Oliv=E9r wrote:
> > Hi Heikki,
> >
> > > -----Original Message-----
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Sent: Monday, November 25, 2024 11:28 AM
> > >
> > > Hi Oliv=E9r,
> > >
> > > Sorry to keep you waiting.
> > >
> > > On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Oliv=E9r wrote:
> > > > Hello Heikki,
> > > >
> > > > Thanks for reviewing.
> > > >
> > > > > -----Original Message-----
> > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Sent: Monday, November 18, 2024 12:50 PM
> > > > >
> > > > > Hi Oliver,
> > > > >
> > > > > I'm sorry, I noticed a problem with this...
> > > > >
> > > > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > > > The TI HD3SS3220 Type-C controller supports configuring the
> > > > > > port type it will operate as through the MODE_SELECT field of
> > > > > > the General Control Register.
> > > > > >
> > > > > > Configure the port type based on the fwnode property "power-rol=
e"
> > > > > > during probe, and through the port_type_set typec_operation.
> > > > > >
> > > > > > The MODE_SELECT field can only be changed when the controller
> > > > > > is in unattached state, so follow the sequence recommended by
> > > > > > the datasheet
> > > > > to:
> > > > > > 1. disable termination on CC pins to disable the controller 2.
> > > > > > change the mode 3. re-enable termination
> > > > > >
> > > > > > This will effectively cause a connected device to disconnect
> > > > > > for the duration of the mode change.
> > > > >
> > > > > Changing the type of the port is really problematic, and IMO we
> > > > > should actually never support that.
> > > >
> > > > Could you clarify why you think it is problematic?
> > >
> > > It's not completely clear to me what it's meant for. If it was just
> > > for fixing the type of the port to be sink, source or DRP before
> > > connections, it would make sense, but since it can be use even when
> > > there is an actice connection (there is nothing preventing that), it =
can in
> practice be used to swap the role.
> > >
> > > And in some cases in the past where this attribute file was proposed
> > > to be used with some other drivers, the actual goal really ended up
> > > being to be able to just swap the role with an existing connection
> > > instead of being able to fix the type of the port. The commit
> > > message made it sound like that could be the goal in this case as wel=
l, but
> maybe I misunderstood.
> > >
> > > Even in cases where it's clear that the intention is to just fix the
> > > role before connections, why would user space needs to control that
> > > is still not completely clear, at least not to me.
> >
> > The idea is to give the user the possibility to control/restrict how
> > the port is operating even if they have an actual dual-role capable por=
t.
> >
> > Let me clarify. In my use case, I have a DRP port, and in most cases I
> > would like to use it as such.
> > However, there are cases where this operating mode causes additional
> > difficulties -- for example when connecting to another dual-role port
> > implementing the same role preference (e.g. 2 Try.SNK devices
> > connected together). Then the role outcome is random.
> > Since this chip doesn't support PD, there is no way to switch the role
> > from userspace.
> > When I know I'm going to be working with these types of connections,
> > it would be better if I can restrict the operation mode to "sink-only"
> > (for example) for that duration. Without needing to change my device tr=
ee.
> >
> > Sure, the mechanism can be abused to switch the role on an active
> > connection, but that was not the primary idea here.
> > I would even argue that calling a port type change during an active
> > connection terminates that connection, and starts a new connection
> > from scratch with the new behavior.
>=20
> Okay, thanks for the explanation.
>=20
> > > > > Consider for example, if your port is sink only, then the
> > > > > platform almost certainly can't drive the VBUS. This patch would
> > > > > still allow the port to be changed to source port.
> > > >
> > > > In my testing, it appeared to me that when registering a type-c
> > > > port with "typec_cap.type =3D TYPEC_PORT_SNK" (for example), then
> > > > the type-c class disables the port_type_store functionality:
> > > > 	if (port->cap->type !=3D TYPEC_PORT_DRP ||
> > > > 	    !port->ops || !port->ops->port_type_set) {
> > > > 		dev_dbg(dev, "changing port type not supported\n");
> > > > 		return -EOPNOTSUPP;
> > > > 	}
> > > >
> > > > So to my understanding, a platform which cannot drive VBUS should
> > > > simply set the fwnode `power-role=3D"sink"`. Since patch 2/4
> > > > correctly parses this property, wouldn't that solve this case?
> > >
> > > True. I stand corrected.
> > >
> > > > > Sorry for not realising this in v1.
> > > > >
> > > > > I think what you want here is just a power role swap. Currently
> > > > > power role swap is only supported when USB PD is supported in
> > > > > the class code, but since the USB Type-C specification quite
> > > > > clearly states that power role and data role swap can be
> > > > > optionally supported even when USB PD is not supported (section
> > > > > 2.3.3) we need to
> > > fix that:
> > > >
> > > > My interpretation of section 2.3.3 is that the 2 mechanisms
> > > > allowing power role swap are:
> > > > - USB PD (after initial connection)
> > > > - "as part of the initial connection process": to me this is
> > > > simply referring to
> > > the
> > > > 	Try.SRC / Try.SNK mechanism, for which we already have
> > > > 	the "try_role" callback.
> > > >
> > > > Maybe I'm misunderstanding what the intentions are behind each of
> > > > the typec_operations, so if you could clarify that (or give some
> > > > pointer), that would be appreciated. My understanding:
> > > > - "try_role": set Try.SRC / Try.SNK / no preference for a
> > > > dual-role port for initial connection
> > > > - "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
> > > > 	after the initial connection using USB-PD.
> > > > - "port_type_set": configure what port type to operate as, i.e.
> > > > which initial
> > > connection
> > > > 	state machine from the USB-C standard to apply for the next
> > > > connection Please correct me if any of these are incorrect.
> > >
> > > I don't know what's the intention with the port_type attribute file
> > > unfortunately.
> > >
> > > > > diff --git a/drivers/usb/typec/class.c
> > > > > b/drivers/usb/typec/class.c index 58f40156de56..ee81909565a4
> > > > > 100644
> > > > > --- a/drivers/usb/typec/class.c
> > > > > +++ b/drivers/usb/typec/class.c
> > > > > @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct
> > > > > device *dev,
> > > > >                 return -EOPNOTSUPP;
> > > > >         }
> > > > >
> > > > > -       if (port->pwr_opmode !=3D TYPEC_PWR_MODE_PD) {
> > > > > -               dev_dbg(dev, "partner unable to swap power role\n=
");
> > > > > -               return -EIO;
> > > > > -       }
> > > > > -
> > > > >         ret =3D sysfs	_match_string(typec_roles, buf);
> > > > >         if (ret < 0)
> > > > >                 return ret;
> > > > >
> > > > >
> > > > > After that it should be possible to do power role swap also in
> > > > > this driver when the port is DRP capable.
> > > > >
> > > > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > > > ---
> > > > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > > > ++++++++++++++++++++++++++++++++++++++++++-
> > > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > > b/drivers/usb/typec/hd3ss3220.c
> > > > > > index
> > > > >
> > >
> e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > > > 01f311fb60b4284da 100644
> > > > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > > [...]
> > > > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct
> > > > > > typec_port
> > > > > *port, enum typec_data_role role)
> > > > > >       return ret;
> > > > > >  }
> > > > > >
> > > > > > +static int hd3ss3220_port_type_set(struct typec_port *port,
> > > > > > +enum
> > > > > typec_port_type type)
> > > > > > +{
> > > > > > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port);
> > > > > > +
> > > > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > > > >
> > > > > This wrapper seems completely useless. You only need one
> > > > > function here for the callback.
> > > >
> > > > The wrapper is to extract the struct hd3ss3220 from the typec_port.
> > > > The underlying hd3ss3220_set_port_type I am also using during
> > > > probe to configure initial port type.
> > >
> > > Ah, I missed that. Sorry about that.
> > >
> > > > One point worth mentioning here is that if the MODE_SELECT
> > > > register is not configured, the chip will operate according to a
> > > > default which is chosen by an external pin (sorry if this was not
> > > > detailed enough in commit msg)
> > > > >From the datasheet:
> > > > -------------------
> > > > | PORT | 4 | I | Tri-level input pin to indicate port mode. The
> > > > | state of this pin is sampled when HD3SS3220's
> > > > 		ENn_CC is asserted low, and VDD5 is active. This pin is also
> > > sampled following a
> > > > 		I2C_SOFT_RESET.
> > > > 		H - DFP (Pull-up to VDD5 if DFP mode is desired)
> > > > 		NC - DRP (Leave unconnected if DRP mode is desired)
> > > > 		L - UFP (Pull-down or tie to GND if UFP mode is desired)
> > > >
> > > > In our use case, it was not desirable to leave this default based
> > > > on wiring, and it makes more sense to me to allow the
> > > > configuration to come from the fwnode property. Hence the port type
> setting in probe().
> > >
> > > I get that, but that just means you want to fix the type during probe=
, no?
> > > Why do you need to expose this to the user space?
> >
> > I've been thinking a bit more about this "fixing the type during probe"
> feature.
> > My current implementation always fixes the type, even if no device
> > tree entry for "power-role" was found. Could that cause issues for
> > people relying on the configuration through the PORT pin?
> >
> > I could consider a solution where if the property is absent, the type
> > is not reconfigured during the probe. Although then I would have to do
> > manual parsing of that DT property. With typec_get_fw_cap() from patch
> > 2/4, I loose the information about individual properties being
> present/absent.
> > Would be interested in hearing your thoughts.
>=20
> I don't think it's a problem to check does the property exist directly in=
 the
> driver. It sounds like that's what should be done in this case.

Thanks for the input.
I'll shortly send a v3 where I drop patch 2/4, and instead have the parsing
of the relevant property in patch 3/4 and 4/4 respectively.

>=20
> Br,
>=20
> --
> heikki

Thanks
Oliver

