Return-Path: <linux-kernel+bounces-282804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961894E8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBA1C215D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372016B3B9;
	Mon, 12 Aug 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RMPm7Bak"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3CC14EC40;
	Mon, 12 Aug 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452360; cv=fail; b=eKo2abJ58ngDosHCKhEaz7gP7vD7jSrC9EkHCrq/ClAvWM/pE4Lucz85ijXLb0h0v0ohAMlHSs8TfkmXRnAjBZNiTZEnk7AGl3Irwv70viKIpp7CQIQLXNgd4m9h1RsjJsh39I7BIIsueTtEMXjM+gJhfgtLim3se3ngw1KHiwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452360; c=relaxed/simple;
	bh=pMWdI8596/HlAQ/FzjIj7Ztte2YTscBXh6JoMPtRh8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpcXPYTuyIJ0T/3F8ukOFlYUN2InhRRwzDi/ik+eJ9/ISXd1TIfEw2ELbXY0gcyIMVmjsAZ8QFSo+UM4MdnFDK4XOEaJYXj0HvKDkPJ+b5ZqrJMTlWrecyEg3HGivViMMjd45ZuszDi8vbDu24ar4mn+0DwzXekv45mwqEjGds4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RMPm7Bak; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5tz03rimkJQMLZmlPeOEKM4Af3X28rgzP40dNHuhTQ6TXtbF+waFYDnZhbo/QReEvfVuXviuMs0Voem5eNxRRuQMk9SleYAkXeOlZXqD+eZFWvHiWw6CsuRigEm8C9EPT2Bq3SwfmEQ+DSx0sdNBBsvqp8Gm8Yd1nJhapuU6BYfM9T8sI1+0jY74NIOdrzpdkVxY3Gi9XAPBr43j58WfH2oz4n+hg21mb4LJiFAxFoOOD4xeASUmxKAYHdvyw9EIconZLel3Pwlf8Isqu4UDKfxvRHuwRo/7rMNUsHRnxKhfy08FzKnvgLAMXjSIrUev99CZBQZneN3S1zQwNL5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMWdI8596/HlAQ/FzjIj7Ztte2YTscBXh6JoMPtRh8s=;
 b=ClW/phKlh5xmcMhhy+x/8dY5TFYZAhFG1ehmWUeRdf6U4G0gfwM+zrUMvczpFNl1//x60t6CKO4Au/mwuLlS0h88bzxSioY4vFvDH73+4NyBCdn4ffJx9jqAp6KSsmPbkKMpHRy0ro3HdjFqX3T7v57jGCZnmpETs5eLfMiK7Lmf0xMPotGMdB9cU6Cdm0wPkqnyI7XhBuJRFU43VrjnXoWGlx70/50psU8bS8q74xJHfOmuTCNVxkfBLqOch3m0U3Cr6YVcEu5d4m8/Km8LW70wGnK1wH5WnRRiLzz1sRXwGGxnHfMQKJEdc3hirJjyYc4bTwHThQzcbH9+Il1ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMWdI8596/HlAQ/FzjIj7Ztte2YTscBXh6JoMPtRh8s=;
 b=RMPm7BakObGXrgk3n/bDZ6K61fPGz7F+EZK/qM9CUcbqWO8Xlw+2WE+h42/aghpt4L7WtrY+l+2lomtdHq27sPzVEqBUSMlbUNGNFttcRvox7MPw4xOGLXTtn3VnB43kuwjcIl56QIIyp0dB+CCwcnlbWuSWioHZyCMyZHhokdEhPsoJeocSm61AcjN+Jrssle0PZSxfkjahNqYUOXSUglVcdTOdj23gKKaWc3ESK7KwPv8Uqzhq/w4WkJc5ZAVtHLMmQczD4RQJVDL2OjhoPEQIEmNJM8561SYAHYk3dope5x758rdY4ir5fRQt9S6AZXPD8NKGhOI3Xn9xd1wuPw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Mon, 12 Aug
 2024 08:45:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:45:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Thread-Topic: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Thread-Index: AQHa6XHouLNBTaAoSE2f9Hb6szCBJrIjVMtw
Date: Mon, 12 Aug 2024 08:45:54 +0000
Message-ID:
 <PAXPR04MB8459C55F49C08A6B6A0239E988852@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240808090326.425296-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240808090326.425296-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9437:EE_
x-ms-office365-filtering-correlation-id: 9f6d0179-db64-45f9-0b00-08dcbaab2d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Guu78Rqdz3rMxlhKqL5MNxmMTlQbSbOaHp29BjQ9qEua4dbc2bqdffrcIiSC?=
 =?us-ascii?Q?R5/bywieOZlOtvYWVNHPYVIXpWmKStaXSTHCtWOWMC1jcwbsv4Na7apxFiPm?=
 =?us-ascii?Q?4yyQWVweDBWAStLRlgsfBkP7YBce9/ZWHfDc0vtjgO42PD4Ql9fZsovVeUP9?=
 =?us-ascii?Q?/9Xg+EtTqW47YsPSbwqDKQTe9nEzujjp5/AbuPDfQqurXqcODX5Qdu2FxZnq?=
 =?us-ascii?Q?JNSLChlkanlp9j+np3v8ib43e1/2IXlvBDjPwa5KhxGz0plMTRsxTDkKREPw?=
 =?us-ascii?Q?DsL/rRbyRfrXa+lI++e+JVe8jRyu9isDTv+exh1mzNfRggbHSO8BLJJ4IgJj?=
 =?us-ascii?Q?/iZ9cNPKqnnFkVcayvprJgsUvAfRcqCH8gDodATmD5HnrWSelf1MSU/oIun9?=
 =?us-ascii?Q?P9ksg50gixG1BIL032x2dwxQogbCbx9Q3Sk6/3tCeCuwCeeAY2TaAht+gvDi?=
 =?us-ascii?Q?5l1N05yvVSp0U2ZZMxOBSMvFLqF01lqZSQvOIt2CETOg0cdN6bO/3+lm5n7i?=
 =?us-ascii?Q?hxYxf8wn9jlUuEY75VEighpYuLe+VEXmY0Zdxcenar2OuUIJ8X12UTP5aQvE?=
 =?us-ascii?Q?uWGhP0tDCp/KxPziknveJkgTqQV47cCQtwXTLHCJoYAc2mYwLcVW/ZnYCi/7?=
 =?us-ascii?Q?cmu23cTWnpv+nXy3y9kMpyu/ppBrK95tdISiMfWIVtQPqD+6Bx303mhcFIIm?=
 =?us-ascii?Q?Up/oMk1RU3V2Zz//Kuw1d76XecTA7xPjuVhsUgPvs0sGL+gvuPpdpQdAao6x?=
 =?us-ascii?Q?FiCOFRQNKh4rkG76cff/75jEzsYSQGDB7R1kRln+flgPwDxBW7povDDlzuf/?=
 =?us-ascii?Q?yuMgPiiu5NT2y2NYDVeB1Vuh2ov24E+Q7OXNfX5Yp327KzhC/2vQhW03bx9n?=
 =?us-ascii?Q?/IeHpmOzQ7qIJE393kEfDjOj6U25erUSUbBEzFYUYTPxbVPCPFPWtoPfVpUo?=
 =?us-ascii?Q?6QEsvtMxB7W4+pLZjW45jyFm75Ek7qC0Ux2kUXvwxWJasCKcbBm/EpTf1ndh?=
 =?us-ascii?Q?79kwLKcJ5sc3WNrZ4y+N5WSsOYgFkEs5+l7Wn+9/yyld44+36Y8opyFD6yM6?=
 =?us-ascii?Q?Li7lZRymGQJ8DsvDepETWMvb499GMn7h7HzESeOGGE6GDoTo6adktvvlq7xo?=
 =?us-ascii?Q?/SfZG6PMR/oDBBzAzFNJwcJrp9Fr/u57V07fSr7lf7V9VwLyXCkIfEuAwURG?=
 =?us-ascii?Q?5J7mIyIBNhDP1VLiumMkBIi/Rbswxjox9o3WjRhw1pBMzPnIooDWrrZ9INgz?=
 =?us-ascii?Q?qI6iK8hd1j0co408o/SSweHZxxcjm1HJh7pVLkHTrwExV0u89PSM0V8ke5OU?=
 =?us-ascii?Q?uc+irB/eJ2zwJNzfSfPuFyvjJ5RFrLEpf3JWlGRd8+aQZJmp3yq4XBTQbegf?=
 =?us-ascii?Q?cFIqsBVjYp26xY7VMBff+0TVe9GyuxYZDy+g+78uK17tsu7eNA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y/Knytn9Hg3l7fHAiDJq7I5zIGHK0P4Sx6wngcHd9ytIZONmrE12FVMTxr7C?=
 =?us-ascii?Q?pBZi5lP8F0nWzuyPl20V5DmfbswaYeGe8r6uBwcQYsvitpUtFvIdlPgsf1hO?=
 =?us-ascii?Q?ddxKESPs4eLUkUKFBbc4lR66/zoEyPZ5X94PcpFp9uymbOyqDvBTbt+quwVR?=
 =?us-ascii?Q?MGhwDrSC16Wujte2Mh59piYrr5jKELIRT3S4D0dlA4A3VJFP2nmVKo0Gpa+g?=
 =?us-ascii?Q?JpcVbEXZWSCxy4HS8Q2Z+22KORZ2N/iWEFDW9QBQYDC9TM60HgwTOTNI9LRj?=
 =?us-ascii?Q?3gXOTwrCqQzKUHpkR4hQYDKO4QmT0QAKRk/XZdB41gkPhAS1L9GsopHVUNQW?=
 =?us-ascii?Q?5vRLJeIpuP9OFwEkhk3jGSP3u8QGm72d2oHyFwews2O8QuvEjx7bYlhBoyMx?=
 =?us-ascii?Q?R/BSIWTcIr26HQrMS16ODjPzks4JT4TgWo9QEPj1L9CLnure6skiH+I6Jn/0?=
 =?us-ascii?Q?nqbY43ktLq3SZcP9NeGTU7y+qQKTDCUuUUxF9dxG+UGTpoI02+Pz7MC3+Aly?=
 =?us-ascii?Q?tg6vMrY0M258iwwLI2Zl7qzkWCzGxaQ3AZMMdSTlU7x7aXp3lbxLGA6eKr/Z?=
 =?us-ascii?Q?6Pg3Jjk8NBFMrSzc+uR8v31RBc/e3XR10dJptf6bWYKvTIsDRz3zPbhDr5OE?=
 =?us-ascii?Q?9/lj602JrArglicRGNwFrjnDF028n6mZoWXHON9RJQrYLDROa1yUopDdE6Ue?=
 =?us-ascii?Q?9N4GT/xqY+PyUg2+lKampypajlBgcpKlMKo6RPkf/q2pKUkx5xR8dMSt4XkN?=
 =?us-ascii?Q?qNRNuf+2aLXTfSEL+bbChs2yKM1IYvw/6bvwiKANZ8PCLobNcaQKvhP/1swP?=
 =?us-ascii?Q?BejXiv7ozUnnE3+AQ/uFMcsNS88uM1DroNAg7jbMIQhyDw4YgQZL9cEKyUmx?=
 =?us-ascii?Q?aYeuibeknRAwGHLlMHL2lS/RM8u0CP184CI7VcUiuFC2E8IaE3Mf/w31Tbt3?=
 =?us-ascii?Q?6s+CdQY3/UgXPyGQymPrQCR92NGDB2YFL1OE6csiUdx8esqCOLCqT2eWWrEb?=
 =?us-ascii?Q?qEC5GLxI6QuFCwq/Kia2SKIGNi+vfwzEP+5gopr+SLaAMLnMItr7FZLCWvDe?=
 =?us-ascii?Q?tAusVsYthTtLkR+w4X9PRJSjZ9bnJ//M4Gz+t01MAVEA34DkNognQfJJzcNH?=
 =?us-ascii?Q?wANyfomJO0zbr5+PK9IbWO+oN1Fc3XP7nMPd18h4rJz7WuosF5/mQQkzwf6E?=
 =?us-ascii?Q?kootq1nx1NGuAWp03iTz5yw8UzkEk2AUgLgtoKS6tMMlh+qr2J2iic7BXugc?=
 =?us-ascii?Q?HnVTfPBCh/tUMHNSRn6HyEEKeGNoZCNx13o/mzFFqUW+EOZwBUFnJkrJxlAu?=
 =?us-ascii?Q?hPOuFNlP/nZYh+CI7m4nQ+HCaoAg6yBixGuv+nu7O1zNcguYaC/x24AARYDX?=
 =?us-ascii?Q?pgORvsOBLOtW6tbkufl2Dy3G2Ed5zmep8l3YSHKhTVD1LnBus9WlVl+0lLtL?=
 =?us-ascii?Q?/n57mh8i2iPRraCp7h/X5ozH1bMBggX8nDfQbHsR/mfPlRqu218Pk6rNEaCJ?=
 =?us-ascii?Q?8q54rayjMAFW52rjm4qERP4L3+Yu/fLB5Eux2q/epsrb9G2K0IuHAnRxbq1O?=
 =?us-ascii?Q?FnxJgD4G1OOh0ziUJBo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d0179-db64-45f9-0b00-08dcbaab2d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:45:54.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM5kUKWGQRR25UT8pmhdKoL134jjtARmrJ1Wh8n9/hKVFBLfMaOIkbNuikSuToRU2CimfEr+s/vZ0h3hGAf+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437

> Subject: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
>=20
> imx8-ss-vpu only contained imx8qxp IRQ numbers, only mu2_m0 uses
> the correct imx8qm IRQ number, as imx8qxp lacks this MU.
> Fix this by providing imx8qm IRQ numbers in the main imx8-ss-vpu.dtsi
> and override the IRQ numbers in SoC-specific imx8qxp-ss-vpu.dtsi,
> similar to reg property for VPU core devices.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> I did not include a Fixes tag as adding support for imx8qxp and imx8qm
> is split into several commits. It's at lease the combination of the
> following commits:
>=20
> 0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec
> entries") b4efce453f0ca ("arm64: dts: imx8qm: add vpu decoder and
> encoder")

If you are using one patch to try to fix upper two commits, I think
it would be better to separate the patch to fix the error of
each upper commit and include Fixes tag.

Regards,
Peng.


