Return-Path: <linux-kernel+bounces-273195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF8946594
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766D6283CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068F113D245;
	Fri,  2 Aug 2024 21:49:31 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64A1ABEBB;
	Fri,  2 Aug 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635370; cv=fail; b=DW7IAL+nFYMKAZH1hMrLUTIHsuPdooqvHoyfFzwJiHDrPAv6zEcTZvzkIPDcd+0ubny6EzRF01PDgsw1hba9KLeRSF7vNRNdDpjuSkOHvpPw/NxV8Yyb/0DUtWED16phbVEACMBHH1pD91rK8KroyXwWYfiioUbdStjCUUtXzvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635370; c=relaxed/simple;
	bh=g1cKfDVObtZvXl3hP1RaUjgzbMJxFUeO9iFzJWx/tGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIgn0P9LFp77G1zt1JvPYbghuuYU8Izjy82SYz54xnymaPPnfZnBqEOCqDxAnjzEyL0oMdWgCF+J8u9V3ipSVFqqKxkybmod4R9/RQIzw5/fb1PgocFMdwtmGgFp0VrZ/M7Ji+17IDLate2W0CAqMaBi2ETXkUx/5XjYGlP0M64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from SHXPR01MB0816.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::13) by BJXPR01MB0807.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.36; Fri, 2 Aug
 2024 21:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUlAAkw+imckZBknabpQC9ycK+ws4l7Jx9WYw9cJqHty31F3u77SX60lBZ8h2X7gpgQ6y+f6B009720ESrekAnayrmaMF6FLJkK/Rt7K9xSqbkVlrfzj6FwKyXvxW2hLzq4e+Bfi81J+CrLTkgnObnKU49zGdFf0PDqVPipTdXVXpNocnWWHK8cl1XteCnN2RnlZHDNf9C4C3PbsF5bwl/SGcZJj2LC9vbEo/3uedQJJ3dKGN51WpYDKJqEwtNEd3FYZiUdhqV6ImyXtTtdNHrf+Xd8J2pZc3Kim1sEihSHqHI4YJn6e2gRS9BdNALv9I46PFvMsDYbaKgbb2+EWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHL10LLLXWiRdF0hzWiED6n6yxEuw89N+osOUzCN40U=;
 b=QO83toeYGjQliLGzZtfIWjdrDZpBZE5XFfqInqIkc2uEy9knrE+l7SJd70y7Eo4BQvEaUrqjE2GAFq8u9pEXfPHklBW3ZdqnGk4kQBZ5+D+zjCaXpE2VvqV117XQwid3ILw+gXW41viuO1/L/kaZu+hXbfWiESA2IvSuspw1m4vlziQTlLpHlRrTh9iro0QES1QHnK+Een7o6I/7D6FzRCc8bOp0/JkizjiDeuhNFwlns77B0OJe62FKn5Na1WlPXlhmMUpb42U7Skvds8C7g7sdMzytIOGiFuxeyKCoL3O9mRAQIK0SbqMZKDdjvhOf5lIgdcKiPW7DaYw+yCPuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0816.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.36; Fri, 2 Aug
 2024 10:45:27 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7762.035; Fri, 2 Aug 2024 10:45:26 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Vinod Koul <vkoul@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] phy: starfive: jh7110-usb: Fix link configuration to
 controller
Thread-Topic: [PATCH 3/3] phy: starfive: jh7110-usb: Fix link configuration to
 controller
Thread-Index: AQHa44beFBe0N3E+hkqRZPdRqPN1srITyxyg
Date: Fri, 2 Aug 2024 10:45:26 +0000
Message-ID:
 <SHXPR01MB086373887A29C696747FB365E6B32@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <cover.1722457123.git.jan.kiszka@siemens.com>
 <cd7b125c8c797f9d63440944df7121f9db0a49ad.1722457123.git.jan.kiszka@siemens.com>
In-Reply-To:
 <cd7b125c8c797f9d63440944df7121f9db0a49ad.1722457123.git.jan.kiszka@siemens.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	SHXPR01MB0863:EE_|SHXPR01MB0816:EE_|BJXPR01MB0807:EE_
x-ms-office365-filtering-correlation-id: 47a68594-9609-4331-9676-08dcb2e03844
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 Jq6paCtcyWPSUJV0MzRAF9ylkv9DcQfB5JlYjbm+AhQIJ/NdTQO5wgXv8eJ4yvGFRmHzY5eXkef5cTG63Y2KrmO+4nW8OHkTeTae4GFQGvg4QkjNE+5+w+6asl/d3xvT1NADce+LimEY8iO2WB5TxwJ51wFzTSk6VqkKyeSryxgB7KeWs8HTBk0f6YlUz+DI3X1dVn5tdHIDrwI/nmfPoIFKGsx20DF7Mr15Qqdo4qnAGj/TsukA18S29bPU8SCtegyNF08i27xwLieV6CFpHJyMR07uD8RdkTeBBy3ZR0CKJ5NPWBPiskHnyv3FCady/ufJZh6qpFdY4JjPlc/DDr71fTnYZx023brNSAlaMoHZTxzD31uLjDlNl71yGA9012MrIoLZpStHB8iQCtOfUk323oAfzjmIyV4n8/wMiSkcbRPD5x5F+ZnHOCr1djxz/QQvbcZdzpOSE6AX6ygqlXg26hDLbK3d2dMLtxcBgZsq8UtC3MJ1SJUm5mog16Xz4tRdkWmuMGSgoJLGnk3Bw+dcPCpsI+AGLeAx7RKJYTSWUWJ4mBrqxAYb0s8TC6Zjj4dC+pH26USW1FhxIR+IdWLkWTVpVnkPWZxKv5XL/+W2uWGZI8PSFeeBkYSWBkHN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0BgDyyiTO1EjdL2gauF+36+gbzpjDzuYOi4be1GhKqhk3ew3btE+TnX0AjsX?=
 =?us-ascii?Q?bdrCZD+4vHxvvw++oLWO41VCPJ5LaeqdyGkvGQASamPe6bdLyxjfkCo9bQ3/?=
 =?us-ascii?Q?e0imPFz0KHcNdg4x4kbMloRdFb5jUj3VaigLAPEw/IeUwY3VYqG2gqjQ5/Wa?=
 =?us-ascii?Q?HAcRP26rb0CHrAFqHlrsvhdWot8ok7Op8igN76LWpPciQrOsj/y0esEliZPQ?=
 =?us-ascii?Q?8NAOPuXv7W8ZvAlrruoiwv2bWBQH3yqpqWsWVu751at882pSJBJ9iq+LdMQg?=
 =?us-ascii?Q?fljVLZvD6w91Z25NSIQ+nEXpvTTeIshxG8M3BGjeBULNuJbfochgHSsRF3tk?=
 =?us-ascii?Q?t8h1MAXdU+xtv6PYRQ0Aw4HWpmgh2Y0ndn46pybnUnrTO29RoSvG90HEynlR?=
 =?us-ascii?Q?3rgamYxx6uNi6GNI3fHtZ/Byy21SLi2ie5C0+IJxRmhOXet8VJLvtRN2EdTQ?=
 =?us-ascii?Q?n+9+eC3b0Yhj5hMex6xLQ34cCawj8agb3EcxAcepCH7xoiFj+Ch+bpKzt2sI?=
 =?us-ascii?Q?db06AOtuNDAAjOZ1csYChOaPh1pX0t0/RyivKVMs/ejyaphgtM4GJZVhY6hw?=
 =?us-ascii?Q?uK05GqwsI6N57K0WQAVY6Inky4z0b0WsAzO7mWEDa89ex4Sw6TTx7Jq/lQ+4?=
 =?us-ascii?Q?zZAUxCkkF78n1Lny9qi3HmB9RCr/szmxifqzk+DaOEPESAtPfTYMsYXnKdqo?=
 =?us-ascii?Q?y28MeLbflJDUPqCKUg0me8pXigBoAhWrNVnkPWhpg9ULdZzAFrF2oTs0o/DM?=
 =?us-ascii?Q?WpP7QrCBPUhZJwuvXxo/J9ic31EQbJQ1OjSkHxS/LvDGCf+d9efr8hg4alje?=
 =?us-ascii?Q?IKb360BSWj39zLbfyb/wpm3Wd2mNXcN3UV7xpuKGGQfZyVk60xCbysNlgoy8?=
 =?us-ascii?Q?idvNF5QInydYP8PvUwWezka4qIqwXiPLgF0nsTrnBUaOrkzrK7Ltvs7FhNfn?=
 =?us-ascii?Q?M5ljAFT8TeA7/KPlPsrC5Q4611LHkHBwRLScE61Dc6xG7rSEUKGhmfzVvHQ6?=
 =?us-ascii?Q?hViAqvYziDJkTcb61gmcG+pWbHYzwS+hU/FflfZe59KD6YHk8VXbX/tRYN/B?=
 =?us-ascii?Q?As1aJnTU7S8KGwWyvzCutdIBepfcqeo6bWFJtiMrj4fkxMzIj6t9TDdkcYFB?=
 =?us-ascii?Q?kijwq7QQMixbetr+VGLO5BwXdOXl4qAQaAht35QD10Jh0Pa239RXK6tRbroe?=
 =?us-ascii?Q?nK/Qk2OcbcrYvURaUu7NNeW/3L56+wyNbcu97Dyw0ZxsE8bMbFweIurhstP/?=
 =?us-ascii?Q?XqyqB0vM1xBl2P06SvqLvFZiKx60qA9DS4P3lZnVjXfzPy52/l321v5/vqyA?=
 =?us-ascii?Q?BG3v6ljsDZbHqiNRdRWXrk0yExY1pKtsyV0gYzkbPjHonZYwlhI+GVoy8v79?=
 =?us-ascii?Q?VeSQ3FJ4Dh2xFuECHFI1p6VnqXGQTSyII1JH3TaIIriYcyaYp/9eA7TIQP+5?=
 =?us-ascii?Q?IAnuSNPz+zXn8pDrZKuT+YXVAwopWZvvjDr+S5nU0eIUVoqjZpvBBETX+O0f?=
 =?us-ascii?Q?byWJlbIEAj/ocGNhlxknmI8YdlFMGYP+/qaj1OMp+MvUphNbkDe8m9j6M18+?=
 =?us-ascii?Q?1eziTi5U3hI3e1ES6nLWGt+hZiGMUYU9usjNNjx0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a68594-9609-4331-9676-08dcb2e03844
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 10:45:26.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jQoqXdmDKjsWgTQf04yO0KeJMsi/gFJnOqrEuDFbdjGhfjKt5lKCC57ANlTXlC+hpryNq3RHz9CR+prN2eP3BU/TdQROt+ZHNmqoHjPQbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0816
X-OriginatorOrg: starfivetech.com



>=20
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> In order to connect the USB 2.0 PHY to its controller, we also need to se=
t
> "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot versions
> did that, but upstream firmware does not, and the kernel must not rely on=
 such
> behavior anyway. Failing to set this left the USB gadget port invisible t=
o
> connected hosts behind.
>=20
> Link:
> https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_sys
> con__section_b3l_fqs_wsb [1]
> Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/phy/starfive/phy-jh7110-usb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/phy/starfive/phy-jh7110-usb.c
> b/drivers/phy/starfive/phy-jh7110-usb.c
> index 633912f8a05d..67882bc4cebc 100644
> --- a/drivers/phy/starfive/phy-jh7110-usb.c
> +++ b/drivers/phy/starfive/phy-jh7110-usb.c
> @@ -10,18 +10,24 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/usb/of.h>
>=20
>  #define USB_125M_CLK_RATE		125000000
>  #define USB_LS_KEEPALIVE_OFF		0x4
>  #define USB_LS_KEEPALIVE_ENABLE		BIT(4)
>=20
> +#define USB_PDRSTN_SPLIT		BIT(17)
> +
>  struct jh7110_usb2_phy {
>  	struct phy *phy;
>  	void __iomem *regs;
> +	struct regmap *sys_syscon;
> +	u32 sys_phy_connect;
>  	struct clk *usb_125m_clk;
>  	struct clk *app_125m;
>  	enum phy_mode mode;
> @@ -61,6 +67,10 @@ static int usb2_phy_set_mode(struct phy *_phy,
>  		usb2_set_ls_keepalive(phy, (mode !=3D PHY_MODE_USB_DEVICE));
>  	}
>=20
> +	/* Connect usb 2.0 phy mode */
> +	regmap_update_bits(phy->sys_syscon, phy->sys_phy_connect,
> +			   USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
> +
>  	return 0;
>  }
>=20
> @@ -101,6 +111,7 @@ static int jh7110_usb_phy_probe(struct
> platform_device *pdev)
>  	struct jh7110_usb2_phy *phy;
>  	struct device *dev =3D &pdev->dev;
>  	struct phy_provider *phy_provider;
> +	u32 args[1];
>=20
>  	phy =3D devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>  	if (!phy)
> @@ -129,6 +140,15 @@ static int jh7110_usb_phy_probe(struct
> platform_device *pdev)
>  	phy_set_drvdata(phy->phy, phy);
>  	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate=
);
>=20
> +	phy->sys_syscon =3D
> +		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
> +						     "starfive,sys-syscon",
> +						     1, args);
> +	if (IS_ERR(phy->sys_syscon))
> +		return dev_err_probe(dev, PTR_ERR(phy->phy),
> +			"Failed to get sys-syscon\n");
> +	phy->sys_phy_connect =3D args[0];
> +
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>=20
Reviewed-by: Minda Chen <minda.chen@starfivetech.com>


