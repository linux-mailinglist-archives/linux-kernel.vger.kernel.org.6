Return-Path: <linux-kernel+bounces-314164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B196AF8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB7B21A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DAD5339E;
	Wed,  4 Sep 2024 03:51:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAD47A73
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421870; cv=fail; b=strwV4nyY8xLMMs6VAv4iesQF7ORG4KZtgrR43I4wL9ZJL5x4bVxtimBMUn6fFpDIX4ncGT41LsK7OS5X56MPifuNB3GGpYfSDL4SR+mpVKRbYsAKy5dOypc8GfSKt8VCFyQzlQvSnTVKjdoXggu2xWmaUvT5w9MC3leO3Q1Ado=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421870; c=relaxed/simple;
	bh=r8QJOfF5+X4j0ySKUuK6pRuwA/rbpQo9OeLK+63Ow9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ljPWxQMdNYchkG07kFrmSI9z0N5gw+miUTiAdNZ07bnBoyuO3OceJ07VxT5/mUyflFTmkGALH+bp4jNQaeO1L0MWr8qyXJ61Ojg+B3hxXho4lGuV6AJyy0ryeEEFj0pKPOpEBis3ESgFAU2Fo+mDRL90GXAlsgKGAX4F80mvK3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGESMaW5lcJTxipZ+JF+8eDm283O+pyEDYeA8GQKiwHA4Ko1tjt/6AEsRAzx3ED8ZzwJLxaRq9mIdZN5RsJ8vF4sFPBkQFPIJpYnb2FySguW+h+MTAenuIvOJ41N3i8vlyF/hJYlgQnh+Pds41XPqXIGKdWpQ1QgSO2FnYvJPaqHWVLc430HF+ErCJW1+cqHH45ObbOepww9YDuyxjWbcDNx++X1UiTejUaRIP1U/xtfYHz2PofmTxTfr3RyKNeIClnSSNU1CSIKbxrRnM8wcF09L6R7cpKdM+lAwva+VNYuMVuYc2A+yBNptJZ17xMnADiSMOSMnhssK0XDsc8Prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfCHsA8FA99tg4vI+1nS3DWee7AM0o63KFmesVYHK5A=;
 b=UHsJ6WhOqfvy6r5st2dXdXGGeF8esW5+3twQM3H47PxyP76bFAUcxCTblSvVacLhw90msUtml9xbwxEs7jbcwXZyskfLPvjgnWhtx4lWHyZjc3PqWF5j6WcF5amfoHIMWDLD1RaPRImBKdj6GKBwLV5WbTa1uUQq9Ku8C5jjvQCIyApd7e4Tlx20VegZV8GHZTm76Uh2xEoIQxPDa6RMdUjMu237z7bjWb9XyYrNKLsAC2qD0WIatz+YPsL1/ncG5L8qvRHI7kbt3d3ZvB7kZEYL0+QqOcCOBX3XSyVJzKLKfPM7TtOmDUKqO9e2Qu2MHng5G3GNgrrctWOjThRNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1212.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Wed, 4 Sep
 2024 03:35:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7897.029; Wed, 4 Sep 2024
 03:35:04 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Conor Dooley <conor.dooley@microchip.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [v1] reset: starfive: Fixed access the empty member on JH7110 SoC
Thread-Topic: [v1] reset: starfive: Fixed access the empty member on JH7110
 SoC
Thread-Index: AQHa/nSvdgOhD5lu3keAfqu06/G6v7JG9qPQ
Date: Wed, 4 Sep 2024 03:35:04 +0000
Message-ID:
 <ZQ2PR01MB1307F3BE491E2557593BDDE2E69C2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240904024640.809425-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20240904024640.809425-1-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1212:EE_
x-ms-office365-filtering-correlation-id: ba37374e-fe0a-4425-93a1-08dccc92908c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 xjBwq0lGkhbQzj9j3r1QkRgpKk4lpBJnacm0lJS/pWht8pOryI+qoh6zJAcYs9Ugxwl2CXB6XTII1LSu+mNuKSmwhYaG0NQWsaltNRt8TAMu6qjb50+84dBYN1fwqeo54cPE/XOV6qvawnsI7S2ASUjJD4pb/PN1fEcqoM08seh61W2oXTRO9ugp36KUiaTzYqHJ8OY6shKfuD2q7dBiPCTbWAvL9Cmb01pEGdJqocbNcxmVLW1AKCXTWwW+V/sPOw/iDHzeTWSqSozfPZSk/HEjUjjQZ7jVT1ZV6uz8wb2ZG7cmvvbzSrr2MZzYEkWDye0/A6vgM64uswxe8TRfTvYbJj2p1GmlqixB92a0o63EH2Mnjs7nHOry4DNK8ljMcDFiXnue0MPI7fj5IY0LLSXAHiP9Nf4sQjch8o19G9wz0XySXswvLRSG9pn0GSoxMtcry+9+HdPKHhaCgPz+LAukKZZP6HVUmyWDTYL7aXLLgrLnc05OCRYkttKX/ExiKeoXsDH77gY0la9ZbaioYAjJlH4dkOidgd3C90STTdAMDqHgWvIHD8S5mBaMvvh6GWuxoOUqoYB+jUojxYjInV1VKoHQAjSvXW2oubrzGZJE892O30opjuOzrzjL3nhZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DDMkwft8caXUhJ2f56fenvqFit+q/kTaYusLIGqgh9k0HGeRyRHUOHEzM/BA?=
 =?us-ascii?Q?yH5C1L4tF9a9nML79Uovc87Tgaz6dYOaYdRGgIDj3nedU9OeHE58fJg1gcSL?=
 =?us-ascii?Q?CSM0papeyvg7fB03uymgYu6IJy/l5F9bh6vE2Ttc2FKWJlQyknoieT1XDcwt?=
 =?us-ascii?Q?8OIuiNqwKpiwfvJ4VoWtP2uAOoAKel3WVSFnlIONXLJEWX7l60a9Y/yi9IBu?=
 =?us-ascii?Q?zH9WfVpb26t6+XU2Efk2ByqoD14R/MWCAAQix+mMch9IXKT3ABFG3a/jx2dm?=
 =?us-ascii?Q?Cvu7GmFTwWHtu1I67q4gC4Lt6AEETfaKBQijO1PIRjKZfQnE49OZ2YwpbCCV?=
 =?us-ascii?Q?/BPfDyvgFEmisrftW9XRn0oaXJI0iwF4SPWA/XSyv9WfNGzB/C4OZb6Z5wp3?=
 =?us-ascii?Q?s+JPFg0YwyXZi0WoaPtjVOH/GzWPaiuKAO+/krDXT1lnLiAOAGd9pGhNMIBN?=
 =?us-ascii?Q?XezJXE4jl5FBjBDHryXkFnGnnhxx5m4HuY/iEztOh6M3lJBdQlUcSZ2by/jJ?=
 =?us-ascii?Q?5/FP0FjYuw0gBe/b109usWSbk0G+m+w9rUinXKmFlNZwbp6S6XjYtzzvkFrB?=
 =?us-ascii?Q?omkGqNC5fVuXA8IbuCouGTi4SjLQVgMxxStxFr9dUZHL8qBH8fZsejlh9T2Z?=
 =?us-ascii?Q?bI3L8frYfauKWI/aCw90nyD48DtdS6EzfrPKrxc8znHDYjyOfKcnydRZ69zi?=
 =?us-ascii?Q?ZJFJ4mirxuIQPaAOm2cjUDydHWDRWo2v2RHK4oYAR7KPNOLd8ICVFleoYuHZ?=
 =?us-ascii?Q?o/lgoBEZuB8G3Kokv/xbCmvdedIFidTtTG/r5YTWqaHViNGoSGu6Q7TKwnEg?=
 =?us-ascii?Q?UJjaCZTC8WLbApK+oYYaY4rNgvN+L0EqLOaBNDyePC7SJ76raOL+wwWgIYee?=
 =?us-ascii?Q?p10bI3yV2GWaqMKpZhRz41/dyBa2EWoOeflmf9hcJGrzeYHzGUGKgyL8fRju?=
 =?us-ascii?Q?E8F4+e4ovHvCiNxVgZ7WlTj72eGdMFH4CFKouQY46ljzlgosnTa2aD9fdFgK?=
 =?us-ascii?Q?Z8wgb1gOUyYQHoOxFE1YL01GxOIEazCJddMNJkkVOsDGczDzWkZ9eOkaz9RU?=
 =?us-ascii?Q?AMqfhjieDs/oMhJY2EJPByG3xwCXpwXaXFsKxI5Fn9zoPrYdll285swxD3vZ?=
 =?us-ascii?Q?bcGp8ilhWeapjik5JBh7YsALin01VqOmuwclshy0KbiKxRCFmBxEFdWbQbO1?=
 =?us-ascii?Q?/nDuaHVSR+pPZAgXRsqD/1hGoJSKdpRd21sHXic8WjZ1zFymRmaiDlAFfLdE?=
 =?us-ascii?Q?Xg4tepCbpQtRYDOn7yBqgOaR8uxmW+njkFx2jtlBIC2bVzoHoNbv+DOgeFQZ?=
 =?us-ascii?Q?ZxS0dTz+JiqTHjAuLfgjXjq5f3b5NekNHQtZMPvU4NF6tCQ9QwyuIxbYrqzH?=
 =?us-ascii?Q?N1ZhXTI2k/fRW74/6KBWkERwD89qgRXEkQFrtRQtHan/kCGXh47nzDfJbNjb?=
 =?us-ascii?Q?YwJN797syf/8qlnVZphUbtxh3O1NvwC12VEjQauqyJQdzBMMWMVN8XtTSDsr?=
 =?us-ascii?Q?aGSGcQjr457jVGsb0MF0PM+NuW4ER5hnu93zM4PxvWy42W13gZOMwEEV6E0Q?=
 =?us-ascii?Q?MouR2qCH8vGJDRt6ZxtT+Hm8HNwHvCaQT+iCbTNf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ba37374e-fe0a-4425-93a1-08dccc92908c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 03:35:04.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joQU6H42qFwHTX3D2EotlK+1/ejHPJatMfhMLn89uk8k0F6vrIn39IaIt6BxgpLFi+bXyvSxZt1c+sK207ynKaruFyoNggfa1MkbDvpHrwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1212

> On 04.09.24 10:47, Changhuang Liang wrote:
> data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
> ("reset: starfive: Add StarFive JH7110 reset driver") be added. Add the
> judgment conditions to avoid errors.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/reset/starfive/reset-starfive-jh71x0.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c
> b/drivers/reset/starfive/reset-starfive-jh71x0.c
> index 55bbbd2de52c..29ce3486752f 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.c
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
> @@ -94,6 +94,9 @@ static int jh71x0_reset_status(struct
> reset_controller_dev *rcdev,
>  	void __iomem *reg_status =3D data->status + offset * sizeof(u32);
>  	u32 value =3D readl(reg_status);
>=20
> +	if (!data->asserted)
> +		return !(value & mask);
> +
>  	return !((value ^ data->asserted[offset]) & mask);  }

Looks good. Maybe the commit message can be improved.

Acked-by: Hal Feng <hal.feng@starfivetech.com>

