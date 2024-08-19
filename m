Return-Path: <linux-kernel+bounces-291361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09243956134
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C91C2084F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C31282FE;
	Mon, 19 Aug 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQrw/4hB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06247DF49
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035402; cv=fail; b=dnHGeqsD+NtWTcOItgA6D1eAnvB5wO+HMCDf3cIDskBF2vvPpmsXzYTcXxqIXzB22IQefyJ91t2KoGF6sDPYDNvFUuVW+B6Dg6xP9qbku7vgfP3z49WzIYusdGGKHOW8pgpZvdkU5+chVFvfXMb5rwP02lp9Hm5Uzt202hYXue0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035402; c=relaxed/simple;
	bh=NSSvhSkeaBQxoJ6urgdssOR6rI5McPGjVJWJFHFqufg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=at1tMstoU+K32jwlqDdSFB+2l8FPx8kZgd9yxEOu3ahQ8W2Gcsd3Lcx1bVts0+kpdWmWQ2FTTGhwFEVO+7HrjHZd16MA/i5UgUAYmhg6K+CGH/dwDSJUJ+YXG22dwFriE9He4GdQb3wBKlo1LDWjGSB+fKJmLxzoT8v2E3PMGM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BQrw/4hB; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r11TwrgdFMpFvOXki5eKy5jLuKevEGHgjWv6R9HBTvl9pTI+sNl3ROI2fDEkrCfbVrOoJhrTyeEKo+D3nuA92oE7A8kYjDgo3dlpYM5O/KUxdOuRMFBlGRd9pWnOkkhX7PWH3VYATEloC6etEQ8nEqv7m8cgIZUtIH2UXxp+mCLzYiLGWWbjlsfQGs8AO78pDPcuab4VusoIxpkz0rtQSBLT/nDMJHPS6z99QhhOzDw3yROghjPLjJ6VZiE9Z8diVnkDuo2h8gDbs34wbfgKvkNHdKlORPnRq0JCAFO4zmSWEzKlVzSDb8qm39sCaYf9lUchpFullSjWWu3DOQBx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m59DUiM6ViDkj8tOKH4yMWF1VJ9MkvGYhVU8Zyz1XNU=;
 b=AEXMGN/307/gW6NngjBc4h648Se5/GQDbJI88QbXeKA9Ym3v/RtVztHykSzmayCvkGCq/CUWRF00uiO31keYuLvMBw4xAfQzE5e8bzbcWUORXSPaSLy9uwAzw3g2Kl6Pat3++dPSOHRhaRuKMdwuPR4dfDkgrnfNd7J8zSV6oYgMZAiK7KczkrSJOVozoCjlf5YTQdn8WFdcjkz+rLUDgzI7L0TM4IWYRTTouY3JtTEmBOFI8d4p/fj6qLajrc3oLNSQQeveV7IDyxxRwd70E9l+VQ3lYQGx1qwvJmieaBW2V7N+KyXYW53AqH7vLMZgwPveObIPh9La5Dj/WmKpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m59DUiM6ViDkj8tOKH4yMWF1VJ9MkvGYhVU8Zyz1XNU=;
 b=BQrw/4hBPPJL8W5vC+NPIbaXSD4qmAJdrMUf/h3aBhHD+yto2iPfWNQphdAatOK38+TFqXLz9t54o78DRtufY2Zlmb+lRjgH45Q+CawCoTJuAeT2xEDzzz5u/vslLNZcKrQlaOoquD0zfSr1L+fO5SSzcEd9TsAH8EigMq7QCS/eCo38CqzB+imot10ZhrDyHhqXkA19HxbwJdjpWrhTzcLeNt9gDPdHZ5vSCtkFhrfgpd9JJh9u5biegLmfQThuZXKIMK8se5omzQEVmA/z/e0G9acyK0p6IuWjsNIONOI5vb9A5pRLfiX8q+8BccZK7KaeATuestIMV9ecTQUYwA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:43:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 02:43:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: RE: [PATCH v3] slub: Fixes freepointer encoding for single free
Thread-Topic: [PATCH v3] slub: Fixes freepointer encoding for single free
Thread-Index: AQHamvJ26Vy9T/PVuE+oL9dVbp5tmrIujI8A
Date: Mon, 19 Aug 2024 02:43:16 +0000
Message-ID:
 <PAXPR04MB84594764DBDBEFB124CA9994888C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <ZjDXY74yS6UyQPxv@archlinux>
In-Reply-To: <ZjDXY74yS6UyQPxv@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB7539:EE_
x-ms-office365-filtering-correlation-id: 540ce626-5290-4d71-bda8-08dcbff8ad7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iZWG6FHgo+XrAtfc1bLCX52O8DsunipLO2B1medlIb1pN94Lm5ETL87WSQ+f?=
 =?us-ascii?Q?h5997XgR2PE6qY8jsECkAS0OkulvmSLpFNh8dUW/Syte4JKAjYp+A7U2OUvB?=
 =?us-ascii?Q?zsxuiQ8ey+Hu2qcq5M683jPj7ZYQFAKP1IQOIUXzJcLwLWDhqflOtSJVI7Ug?=
 =?us-ascii?Q?NuQZaiE+FrNpAf1JcJOhWywO28StTwFH4epxfJpfrq5UFy7fM1+3eg/+1qll?=
 =?us-ascii?Q?pKVj6uQC0n1ZPecG7XKQGjm4c7hzYdShLedUapy55zoyiMiSpXCz9CDdc5Wy?=
 =?us-ascii?Q?8KzdjGfdC5cHk3sp9irsLD08h8IIcMa8NB1vMRC28/1CRz75C0WIGQjnNegX?=
 =?us-ascii?Q?jHfZNRkeN3DxfLOlzY9bJb3aR2Tv8UJsapxFmL04Z2iyr37F6GRSpr63Vcck?=
 =?us-ascii?Q?QLh3mclag1bXBX6YBkopura4PAYxR+ah4mWfkBSB5ZeLosnRBTCtKgRouAsH?=
 =?us-ascii?Q?Jiw10lrU40cuy2lXG9d/XQ+sGjG2xt2N58l3lvUgMLByTAiwULbaR6tQHxpM?=
 =?us-ascii?Q?CV93/EcaZ4R8tvBi5j5/+Cek+pZkX51JDfCHM6ftFXA/Pva/8NEK4yXSojqh?=
 =?us-ascii?Q?dbEKlslNP3Mo3qhRM19AtLkK0mRUW56t2/QlGNml2GadoC0y+qgvHAcdWKgU?=
 =?us-ascii?Q?djygD15JXCAhacZlqTai0WC/S1FC6N9l2GYd0mvX/NT6hbPl6qBtk1kNGRwt?=
 =?us-ascii?Q?XSOgz217aB4csh9COLQ0724U0eCeP/pfjvDAYbV93XftUyChzcQy+ycvQ55I?=
 =?us-ascii?Q?pEYvc9iMwuAmReK+pu24Ut5RkkU2mDH9YzB0h6Zu8JeQ3NqwrOEJ4fqNMHEk?=
 =?us-ascii?Q?7lBcPVxby0C/4GCOmIlc4c8Z2MH1hrJ9MxJGHSKDS+YXAe1ICkPN8xvt+JVs?=
 =?us-ascii?Q?5VhjclRJGiK7kI7fdLUC97f34aJIa7f4+iYW3rd24/TfZ0Ao2qjwJbnYN0bp?=
 =?us-ascii?Q?lTEJF7mZlvrS2qzXUlhKz1u5sbIYgsMG+37bJAIYtRffhMcFtxE2d41+/ktG?=
 =?us-ascii?Q?oSaEGkPuUW2keGUqTtbiDpWmPKYkz/ZZ+7SbRpR+XBqCK6vCgnUXNKHSemAN?=
 =?us-ascii?Q?//4MfMeEp3Qc8Gj8SewhJIjBmMzBBJWR87ADxXvl99Og1FixSJ8GRko5lnmB?=
 =?us-ascii?Q?fJjdb7EYHfJ7P+E/Lr15YLqwEQRThflzwi3eJMtish8vIOvkR2BlcFblyR/b?=
 =?us-ascii?Q?+WyTO5lg42NnIIcPffuibb4oxpgZlsvR8IlnrDd3AZWkha/ZGJ4yE/m4R5MH?=
 =?us-ascii?Q?WsQPq52oKFkwalDvLnjIZB4/rse62WhSwI49ECL4onZOa/oenhI3JYkIxGm9?=
 =?us-ascii?Q?9rGnqnzP3NKpMHAiwWatVxkc4os/y51CXLhZZi+Nn0bWOhlZKKzCTCs3ZhUm?=
 =?us-ascii?Q?Tq8wYKo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ydSeFd1v8mXJZvly67jJ4V37uDJXbpwoI44h+X/WfHfACxB5iUM0DpL4TRTZ?=
 =?us-ascii?Q?LmJyUdB/qMJYr48qeV/11ma5MfSAXzKcJQGKFAAqrbXKiegKykmC0aEklQg/?=
 =?us-ascii?Q?9vlpkhpr4M00B8lyvLv/1DDkZnXCwy4aJ1Svq3ofUx2Pk0e10xl1PvQb6eaP?=
 =?us-ascii?Q?QzYemW0rlsJ2NvKdvnQn4qnBN0EmHVKINq/9wSKd4ifHSFAAhu2w1jmVJqIY?=
 =?us-ascii?Q?w1PR1s8o3Svusbz6duE6XX2FHT1Wp6pfP7C38ifkhJxcpb4GdJG6oUGZMBM1?=
 =?us-ascii?Q?SDhCf6jgm2tUCfPzvBfbJ50GjC2YRvh+3ZOXtrEn/XhlcrF0PW24ZFo5vGNg?=
 =?us-ascii?Q?oYqPp7YYbGmR8tfXuGTm9z1vvSASFxlBRrG3OXNeYkIqz4fvXydSJI2qDP83?=
 =?us-ascii?Q?2+E4Gg58u5d5kzVoeZkJhhBjdE8H7c1JgKANPCIS6Vq61vhkmdt1iHapODbP?=
 =?us-ascii?Q?CxS5Cp3p+A95iN3rGK5sp+cmke5sv4P12jjjQR3jnI0sCD1tlP3E0wA+K+fs?=
 =?us-ascii?Q?Jd0T3lAFN2mXVcEL/R+jQLi8Jpjxx253gE3LfGgj2gfFcWBorZDIqOvBkviD?=
 =?us-ascii?Q?IfrLybZ57cjC5NTYjzc5bpDp8VIjNMkrFjhjPC2VRY90jroAD8tCskAlBBtk?=
 =?us-ascii?Q?qu3hOXONmL1WQK2Op8cG2cHYkjefrUVsq6bQQpnhjwl3rVwJPJ59QVte+VGn?=
 =?us-ascii?Q?wk099th1hwjCOIZOpSSsiSBIUMuA1DrRGf2Gek6gJP31EINpWzfJ/Nj2nqDK?=
 =?us-ascii?Q?ZplITBL00wOGR5UAK9iIkZD4dbytfXsiAuTeCiIfLSGsc6EKWaMkgjonIZ3G?=
 =?us-ascii?Q?6tZ1Ldl8aEAFSCpmcbtWpGmRYy7j8fl4WuGfrm6EtspZhiDblyyc31pBCktr?=
 =?us-ascii?Q?gT+WxfMpXVsR6nykS6h7m2WMwb2OADkI7kriX0dwsSA/7CKjdU+6MoEB48TJ?=
 =?us-ascii?Q?ltxnl+8SHVDPil9cgYEvc6OCslh0MPuOXG8+tqYYv56++Z/UcZ6PpXQdFYLy?=
 =?us-ascii?Q?vFf4voms/zstvQf6VerTOxo0XcQWssxXVksjbgqvuI7j8zfj6ZlNSbYcn3vb?=
 =?us-ascii?Q?YrTYo3pD0/mS4UqUQFVUMrzkPkfFj6n4QXgaUBRE0MzqVZCyKGQOt8Gb1e7j?=
 =?us-ascii?Q?M/1uDWn7XP0P9tm45KTImELOu9570eH78/vFdI39nD7ia/eR2GrB6GUdShtD?=
 =?us-ascii?Q?dZT2g3KX6Ix3/6VrXw6etz6usNnRmCth4mHN1n7AzLk5cKYvVwFryhcDoO01?=
 =?us-ascii?Q?8X/5hqRc+EYrMA24Bqe/F1cUVX267/ewKqLs7t58Z7S5JIfAY8mFeOwH+0rv?=
 =?us-ascii?Q?hCJs+3/k+XBklGlYvt+doVeuGWkXnbBbfAasY8o0SdKFO9N+iod6yMqiw0RK?=
 =?us-ascii?Q?/voGWuhdZZBO4Z9FkE/Mx/U4K54M/xR/9YZAoEU6jXHC/1G3eQ2gVYVXcUgu?=
 =?us-ascii?Q?GowjY2hs2LsSAyWFj7E5aqzcpuTfuVcDO1tATqBscUv1+c23oxhbVyE7rjT2?=
 =?us-ascii?Q?SOT+y78w0u9dmfGPlTpR3NhMYCa/SETSCNld11PPPIOViOMeYvXsEimcGQOv?=
 =?us-ascii?Q?S6ftwFNGwQM2FzUbuaQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ce626-5290-4d71-bda8-08dcbff8ad7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 02:43:16.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBwkvbF0073PUV9YKZGthVJsYdYWrs57M57yvz4cjDg993j5GhhnmwIFN5EbX2xIfj5Mnkn7zCK4JSp+lF8yBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539

Hi Nicolas,
> Subject: [PATCH v3] slub: Fixes freepointer encoding for single free
>=20

With slub_debug=3DFUZ init_on_free=3D1 loglevel=3D7, I see error
In 6.6 kernel. Should this patch be backported to 6.6?

I also had a hack together with your patch applied to 6.6
diff --git a/mm/slub.c b/mm/slub.c
index 96406f9813e8..ff8cdc737722 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1209,7 +1209,8 @@ static int check_object(struct kmem_cache *s, struct =
slab *slab,
                        if (s->object_size > orig_size  &&
                                !check_bytes_and_report(s, slab, object,
                                        "kmalloc Redzone", p + orig_size,
-                                       val, s->object_size - orig_size)) {
+                                       slab_want_init_on_free(s) ? 0 : val=
,
+                                       s->object_size - orig_size)) {
                                return 0;
                        }
                }

Thanks,
Peng.

> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>=20
> Commit 284f17ac13fe ("mm/slub: handle bulk and single object
> freeing
> separately") splits single and bulk object freeing in two functions
> slab_free() and slab_free_bulk() which leads slab_free() to call
> slab_free_hook() directly instead of slab_free_freelist_hook().
>=20
> If `init_on_free` is set, slab_free_hook() zeroes the object.
> Afterward, if `slub_debug=3DF` and `CONFIG_SLAB_FREELIST_HARDENED`
> are set, the do_slab_free() slowpath executes freelist consistency
> checks and try to decode a zeroed freepointer which leads to a
> "Freepointer corrupt" detection in check_object().
>=20
> During bulk free, slab_free_freelist_hook() isn't affected as it always
> sets it objects freepointer using set_freepointer() to maintain its
> reconstructed freelist after `init_on_free`.
>=20
> For single free, object's freepointer thus needs to be avoided when
> stored outside the object if `init_on_free` is set. The freepointer left =
as
> is, check_object() may later detect an invalid pointer value due to
> objects overflow.
>=20
> To reproduce, set `slub_debug=3DFU init_on_free=3D1 log_level=3D7` on the
> command line of a kernel build with
> `CONFIG_SLAB_FREELIST_HARDENED=3Dy`.
>=20
> dmesg sample log:
> [   10.708715]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ):
> Freepointer corrupt
> [   10.712695] ----------------------------------------------------------=
-------------------
> [   10.712695]
> [   10.712695] Slab 0xffffd8bdc400d580 objects=3D32 used=3D4
> fp=3D0xffff9d9a80356f80
> flags=3D0x200000000000a00(workingset|slab|node=3D0|zone=3D2)
> [   10.716698] Object 0xffff9d9a80356600 @offset=3D1536
> fp=3D0x7ee4f480ce0ecd7c
> [   10.716698]
> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00
> 00                                      ....
> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600
> not freed
>=20
> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
> Changes since v2:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2FZjCxZfD1d36zfq-
> R%40archlinux%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C38af
> dff178a0422aeddc08dc690996f5%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638500737122575573%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DQ4Vs38E%2F7HSIETGC2hYD
> 07gN6U8hkVZR764Yn4TFWlw%3D&reserved=3D0
>=20
> * Reword commit message in order to clarify the patch approach as
> suggested by Vlastimil Babka
>=20
> Changes since v1:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2FZij_fGjRS_rK-
> 65r%40archlinux%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C38
> afdff178a0422aeddc08dc690996f5%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C638500737122594077%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DxWgnIygCHwUPjnFENutIai
> cMTk0HQTne8hQfOqIzbA0%3D&reserved=3D0
>=20
> * Jump above out of object freepointer if init_on_free is set instead of
> initializing it with set_freepointer() as suggested by Vlastimil Babka.
>=20
> * Adapt maybe_wipe_obj_freeptr() to avoid wiping out of object on
> alloc freepointer as suggested by Chengming Zhou.
>=20
> * Reword commit message.
> ---
>  mm/slub.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 3aa12b9b323d..173c340ec1d3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2102,15 +2102,20 @@ bool slab_free_hook(struct kmem_cache
> *s, void *x, bool init)
>  	 *
>  	 * The initialization memset's clear the object and the
> metadata,
>  	 * but don't touch the SLAB redzone.
> +	 *
> +	 * The object's freepointer is also avoided if stored outside the
> +	 * object.
>  	 */
>  	if (unlikely(init)) {
>  		int rsize;
> +		unsigned int inuse;
>=20
> +		inuse =3D get_info_end(s);
>  		if (!kasan_has_integrated_init())
>  			memset(kasan_reset_tag(x), 0, s->object_size);
>  		rsize =3D (s->flags & SLAB_RED_ZONE) ? s->red_left_pad :
> 0;
> -		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
> -		       s->size - s->inuse - rsize);
> +		memset((char *)kasan_reset_tag(x) + inuse, 0,
> +			s->size - inuse - rsize);
>  	}
>  	/* KASAN might put x into memory quarantine, delaying its
> reuse. */
>  	return !kasan_slab_free(s, x, init);
> @@ -3789,7 +3794,7 @@ static void *__slab_alloc_node(struct
> kmem_cache *s,  static __always_inline void
> maybe_wipe_obj_freeptr(struct kmem_cache *s,
>  						   void *obj)
>  {
> -	if (unlikely(slab_want_init_on_free(s)) && obj)
> +	if (unlikely(slab_want_init_on_free(s)) && obj &&
> +!freeptr_outside_object(s))
>  		memset((void *)((char *)kasan_reset_tag(obj) + s-
> >offset),
>  			0, sizeof(void *));
>  }
> --
> 2.44.0
>=20


