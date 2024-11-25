Return-Path: <linux-kernel+bounces-421499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCBF9D8C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5098FB22394
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C21B87C3;
	Mon, 25 Nov 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GTMydJJs"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011036.outbound.protection.outlook.com [52.103.64.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610631B3943
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558967; cv=fail; b=gPlx3iKeNvTu2K7Let6ljE5CxGJajmOz45vQ/zD6azidOaKvnBuD2kVaRcyyejIKeLm4FvVqM7M4UL4+FdWuuXlwBm+SFwrKymlvz90Eu/u6octZ2gGStzXL0A1WxM1WTATEQHILuOV8XDrPCDdoKNffvaTJvlJLRn0J6Us3pvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558967; c=relaxed/simple;
	bh=Jzm4vNGsx5D6qtZNa5S7vxNzhO3d+/949+AOSayQm0g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S1DsyKoaDZ3ypHsFuCikAnHQqmA06++Gq8neNHW0uL1KgnsaYuL7maIrY3k3e0MagZ02d8xnh44v44V/x9vA/F/id0sAkjT8lBBVCxvvPPO+Vczu/yQm0zKRI7AIBNJwzSGmWa07k0msajCbJD9f6eZRqKBYENEAH686uo64T84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GTMydJJs; arc=fail smtp.client-ip=52.103.64.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrGcJTqQo1NKsqKbdskl90VFU+4maFcLMV3NLAFKAyfNSlBrOZdGM2ksIxpnMB8aDx7Zs1aw0UbjOdMH07bYBbCng1wIjqYcGoK4G9DVXusmUd0ubJB1lFp5DA+plHrDenjpR7E4eOjviRE59iFDggCKIQalhgGQxmnVP/ALZPh6qdrGGXcqoNKD1Y3LGqPk/bSAlnojL+Cr5131auzUea5vBHct4GfCRiWbpKQPGMTyiLqJ5K0SSsIiNTXqDtL8X+k+oC+gyn6a0kmvvShavo2HrQhwMTEdAFm6pAc4qMuAhm9KPZhdwEW4RPky6b7QsgM+le5omMpfhpyH48U/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzm4vNGsx5D6qtZNa5S7vxNzhO3d+/949+AOSayQm0g=;
 b=mJi41tHM3blNcwKpGhVb/9QIE5hmhXrGuoQ+MjLJhWMvs5oPxBqPwAOPU9xQice9AI20QSqLiX67LfI8O0SrbB2tpP+JGrn7XEVQyVG11/sRPDUepwS35Ur9H4Ycly6Xnov+f5ppHeldWsdcemYxIzboCJIiUlWlQhwbIOBDAaAcZdwZqE9wPjL1W4+ha4Jb1x/5Da0RO82O12SYpu/87OC1wU9GBfZcdmWEaQWcn3ZUTrfhUh4zAr0uxbXzDCQMaSUkzqJBM+28xWOg1FN/479eNekBouKFjpt1Uq8hEN/YtRf+7cTlh6usq5e/N+C6Za8W2HFgUHlwaD80eeNcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzm4vNGsx5D6qtZNa5S7vxNzhO3d+/949+AOSayQm0g=;
 b=GTMydJJsPDJOjfIfMdbjTJP/8CJcziiOuO1uiIxuB5g4ttAwtHXw3FQCW9YaxbtiO1hNhuS27nvU2srocVFOE0gxhF28mJZo85TjpmD4Px/Ui305ef1c5D+mbHz5Mj/Za/CBvNUcahjmaRzI/9WbVyVQqj8bac8nSd0Qi95Ns1ZbKiqBWtglDeQdcBe5XdyZ2mtAaRENAjUZSmqcq6WjnrB0TnIPbC8AIfgZYtVF51+iwwvCxTGs68v/rvzdkzfH61m3Macmw+7WkAo6attdWI5Tr78+X7tuHmcm+n9SJj8bjewlbbBrkFg6uC1PQlkJj0OW7WnB9tM/evamBGUekQ==
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::12) by SEZPR01MB5674.apcprd01.prod.exchangelabs.com
 (2603:1096:101:131::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:22:42 +0000
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2]) by TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:22:42 +0000
From: Rachel Taylor <rachel.apolloleads@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Taking a look at the NRF Retail Show 2025
Thread-Topic: Taking a look at the NRF Retail Show 2025
Thread-Index: Ads6qYX0u1P3By/8S/Sm1YbjbgHE6AEvXrYg
Disposition-Notification-To: Rachel Taylor <rachel.apolloleads@outlook.com>
Date: Mon, 25 Nov 2024 18:22:42 +0000
Message-ID:
 <TYZPR01MB42090E8E777C8D5A99E958518D2E2@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
References:
 <TYZPR01MB42096D1E5DB5976BFC6968678D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <TYZPR01MB42096D1E5DB5976BFC6968678D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4209:EE_|SEZPR01MB5674:EE_
x-ms-office365-filtering-correlation-id: 83acbc66-62e0-4dce-4634-08dd0d7e26ec
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|7042599007|15080799006|8062599003|19110799003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u5qqXMgtJOSHDJ/Owl0dx3gUuYV2Kb+6Bf3rm8DECJY9QcuJJ7NfMatcUP53?=
 =?us-ascii?Q?kbn+KRn82yHE7/ErpJWm2dcwTOiSjApF8/yqk9NsUaN1rZ4XAmgymOeg8BuQ?=
 =?us-ascii?Q?wuoD3RrNML9Zgui8Hadv6pwW+Epcn4AspAMU36XPhXEzLhi76fyJaB+xJWD0?=
 =?us-ascii?Q?KiOx331b/iUieBmoBIsssn4UJ2f8/Wwpo39mp8RZjbl/xTlomyfRyumme+Mz?=
 =?us-ascii?Q?KhN1Ss651ong0FdoihOLgRplvNP1TSzpqZfcy7vdrUo0pyL4VYhSQgTwaCCb?=
 =?us-ascii?Q?T3UzT3Bzi5UCjwQ9Lt3J9qOu7itjEGtAKWPIX3chjV5ss8TTExa0twByer/E?=
 =?us-ascii?Q?afCnPn7gRgIcMMd5XRJ0oddICuHPvMkx78RLTezblt3f2nEvuGkRajdsRq83?=
 =?us-ascii?Q?fGKWRSlYgBJGGzm50bKt0oO9XKeLJISXULdJ57AeOSFPNc2DT0FQIvNYnMtq?=
 =?us-ascii?Q?pZ3NhKSEz8d09qLF2kGvGmpKplOmCi7KKbJJOAqcOM6Czfc8dyi0Mq7NJPvn?=
 =?us-ascii?Q?RLx+MLpaSpfMf8KOstI+KpRnDEw6In9c56qXwYddZnTTfBlTw2uo9tqNHV7N?=
 =?us-ascii?Q?/Cy6xnPfeEjez5Sd4KuGGIYD8cfb+Wh60AjhzNaUTQ0LyxuqiMmCja4gB+GA?=
 =?us-ascii?Q?+likps0Trvgp8cxDWD84EVTZ4mL7U1ti5fTbbbbrEx0PZZD+tRdfGFJYmWkJ?=
 =?us-ascii?Q?8BzATL4OyNzG6zQ5f10ocP1m4hrJaonL5capwAn6L2PoeYHJbNMrspoln7rS?=
 =?us-ascii?Q?uRuO3D3txj33YxiJO7woVvKylOQ+7Bs3z7hhVKOqNT3oWg3idNd9PLCGGrhR?=
 =?us-ascii?Q?+16Pa6TzodJ5jvNa7wHX8cOr9dkPDCcHe+Z9K9DJ3FWr/ILROHG0DMZyiF25?=
 =?us-ascii?Q?pxfIz0ItOqaA0n5UvArNKYtXNDYbBX+wHZIu0Ai5sDQkoZdmkkQn6pOYkQzW?=
 =?us-ascii?Q?//gmpwLefuYnfza9971HIfaDrceU36c90jRUDV9jcG9I5rQi6oSPYA37bD0Q?=
 =?us-ascii?Q?jSELF0Dw22N2jlduy4iG/urDbrn2zk8Cv/N/NRMvko+0YqQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hyca6vY12LTIfmsIGq8tReJZkFagTaya/SfuDsilR9fEvRoE8QFQLj0v+ZNq?=
 =?us-ascii?Q?TKN6zEvOXFQVXjaVQwuCp5RGH7JZntBhXvBjH/m3YGkg6uUC+WEux3u8tveF?=
 =?us-ascii?Q?XRNAQHosnxFLaDVWeMxsUV8S7ZIpyBQ4p6+CAxPPvx4jhCVaRR81g5BRbT8J?=
 =?us-ascii?Q?e4S4ZDXDenZgmS8ZPPNekU4OUVXg8TAPRPKdkv7xZFODQmQWMsT34a6OwDX2?=
 =?us-ascii?Q?irh39+AdxOILT4QjA2EPVOJIewifLfXOm9mG0Ne6V2LcEwwhQ/ek3TAoTeFI?=
 =?us-ascii?Q?VFDI87YaRq8MokuJ0vqLC/2OCHSVnqotI9hs0AOLRzF4RCTlJRpbCfZ4S/YO?=
 =?us-ascii?Q?fX6yyXr/+NyyrayaltSBUC5TEsV4vFy4hXhuKvpCDPw5dqxc7TXvPoXoaU/7?=
 =?us-ascii?Q?XVISpo3BIHWvKlu/GDlBlQ/ercBWn1jZM0yqAgVc81NRu9vmn6+/0Hrd3Ipw?=
 =?us-ascii?Q?NSYr8/8VObfKnhK1TuFC/x3L6JIY9tQKHkieTR0ofUIW7PrLOehDmPqzcmd/?=
 =?us-ascii?Q?5Rg9pWWjleS9t2zsvolpyc3WOijy4V3clP5JctvWtnnf28QmdZBXzSzaYsBn?=
 =?us-ascii?Q?IrVkxCLxVSzY41C9XEhqtBYazRBMZvOcePm6SoQ9BFkCCWmC2YKS0l8cQilZ?=
 =?us-ascii?Q?kPnbSrpB+93N+skP16R6JTzcVqqQGfu3Lvox+sM3HZpTSiZAUTz40X2BoZP8?=
 =?us-ascii?Q?vLXEgkB6l27IaD7qG33Llsjr3V3Ntay7Od5tmsT/A2zhbUdLjor9i4Ur1dXQ?=
 =?us-ascii?Q?mBhcWyevSSdRj9Wb1gDw7X/iWlZffwdsJbiwqod8qhk05wVnUP/9PhI6boXD?=
 =?us-ascii?Q?TJIdexJfgYiF8+q3Hr6PROYdm1uiw72Ga6O/9pzkzao4vhmxKoiA15/Xxlhr?=
 =?us-ascii?Q?y1ExOKHZkSzOyfD0LkEwpB2UhOIJm45YSUi2SwAvEHkGGhwjSamVpwb7tI7n?=
 =?us-ascii?Q?9XqTu90rQvcqIkyjN0p6uHCewsTUNUCM3tgr8idDvsTvXGF3ObIsmagmF9vz?=
 =?us-ascii?Q?6iLJjvkmD9OcfXe7wG2fL6U8UMvdTSlq2LUN4DQtxI5HumJCHsfgJKSHocpn?=
 =?us-ascii?Q?GVOuB+f2vANdVwp/kAHqxB5qbaBWY1qD9ZybBw9QXil0WJ0x239kSz3WjWas?=
 =?us-ascii?Q?o0CZXxHr/T8eOpWBZTofS7wbv1p4dZxuLjECI5k5dY0dIvE9PDca+cKOeodN?=
 =?us-ascii?Q?J9aJZauRJeQOdowvGwYs3iwxWRet73V/8hGUxZQM16MH95vMjggn2G20vroM?=
 =?us-ascii?Q?9pQ7pkgjztjeRA2JP8KZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4209.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 83acbc66-62e0-4dce-4634-08dd0d7e26ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 18:22:42.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5674

Hi ,

Just wanted to make sure you received my previous email. Can you let me kno=
w if you have any questions or concerns?

If yes please let me know your thoughts, I will be glad to share more infor=
mation for your reference

I'm waiting for your response.

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails

-----Original Message-----
From: Rachel Taylor <rachel.apolloleads@outlook.com>=20
Sent: Tuesday, November 19, 2024 11:09 AM
To: linux-kernel@vger.kernel.org
Subject: Taking a look at the NRF Retail Show 2025

Hi ,

Hope this email finds you well

I am reaching out to let you know that we have a list of attendees in NRF 2=
025 Retail's Big Show=20

Attendees count: 20,000 Leads

Contact Information: Company Name, Web URL, Contact Name, Title, Direct Ema=
il, Phone Number, FAX Number, Mailing Address, Industry, Employee Size, Ann=
ual Sales.

Please let me know if you are interested in acquiring this list, I can shar=
e pricing information for you review

I would like to thank you for never keeping me waiting for your reply

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails


