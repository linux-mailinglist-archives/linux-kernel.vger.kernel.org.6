Return-Path: <linux-kernel+bounces-354398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F346993D07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EE1C22024
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7122309;
	Tue,  8 Oct 2024 02:47:12 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6DF9EC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355632; cv=fail; b=CLYQBln91JZ0rbl5KTBnYOBelAxo0XkuykcA5F5VGmm9i1sSVMvzHVX5BUuPDppNgsE/M7NCSRTzgg7bxVVpUUk9V7qWr8k+RQdEtvYOfGTQgE/NQNdg/QU3O9lVJ/YXekp5EHZRrANnxxLbB6zbKJOhX3pkAPigQbDXZlw+qwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355632; c=relaxed/simple;
	bh=Uv88ABS7bjhfmsgPEI/vF9jcriiYayYXqP7WjqEtghA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N8Q+Y81D/qsaXA2CmYNL8OXhQz4Q4lWUEGMGJnMZm7HwAMRrzbR95z/gzoYWVicNqh3Bg6XEQZwICv79CW+H/XFXZs+DQjly0qlUJG+bq8e0z6r/5pXhvIyY0VKGKiM/YOs22sVwFRAChEMvBxckbNNIaDxoLIiq7DCBxLAvZkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBRl12oD5TSlXNvGaWZSLFzIIMZwzfuSKwndvHo6yHgVlVexLQXW5pL5JDWq7NGUbl6z7p6aEW5oZ9MWtVpmSZsvx8XKyCYzPpnVqI3XdsfImq3vrsGhUYDvTIEPwrVttKYapm1q+XbIerHjrQhPg24FYQMJcQ33o/8oXU2tdYmxwb6mBBbLs+RNWZkJumaf7eZrP49iBWS3w2OmZCqeMYswjhD24h7cNXt8R2jTzNqPU53jxkJZiEPcMfPDfW+v9hi7fjYuydR7Xn3C2Opl3xto+B/Tv/B3kAPInsnZ1HpB0OXnpw5/NHioAMvkkr8ATIVz+uCUe2PZysvS7ut3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpopqWYUsWXDFyCNBnY/t7U8DUKL80gYxINIkoa7sA4=;
 b=MKMBqQU0+QjRRw5QWwrClpzKn3g99MjHYAR3lbzM0l6WKI+jzqwaj+4XrD6zqXan4j8wtU2+dj/vJm9qAMuK8dcHyYL9EGIc1qTbeFE2fb+TU0bZ5scF0EcNkl9Lhkk2sFCJ9ljHSihJTd6ocE+VjCATJOyi/cIvkqCBw09T8KPDfxJxcbRIWUhM/zUxbEENnohEL9hevE13xLNhYUlRx0MM8hJVgI2WPjnA1UWHVHs1ZTfZLZ0MbglfwFYmNJ8z6SAQWzDJ7vvT+2X/f778fy1/eZiVpwAYgmuNIJWbH3XJEPBMnkzRR/7AEcug46SiL3kP6uHN83glyoA6/Hi88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0750.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.31; Tue, 8 Oct
 2024 02:13:24 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.8005.031; Tue, 8 Oct 2024 02:13:24 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>, Vinod Koul <vkoul@kernel.org>
CC: Kishon Vijay Abraham I <kishon@kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh+dt@kernel.org>, Conor
 Dooley <conor@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] phy: starfive: jh7110-usb: Fix link configuration
 to controller
Thread-Index: AQHa/SjhiXxDr9AYPEm7hgAwfhkcBrJPVUuAgCz/r7A=
Date: Tue, 8 Oct 2024 02:13:24 +0000
Message-ID:
 <SHXPR01MB0863C2FA75EA8D7621B5AAACE67E2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0750:EE_
x-ms-office365-filtering-correlation-id: 5e80b940-abc0-414a-0dc3-08dce73eca0e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 8DCRbEjdV2zV/CTi+NkR3AjHrsPe6A4VvcYP2AWRb93TdhFpRr9cgDhEwpcL9tCpt8B+QNIEA6jHdDqk9+UVvi+UVv23BoBx/EtgUNYN50vVLMryd3n8T0GNqerqStuXi3LqvyvbLQfpmaSJgtbXqmql10JX2F7BToUMcbmWyaDehoI0fmwOY05uxpT7IL5Ijy9y3eQcWpTkru3E4wEtCD6aXXa6zGPCGT8xudy8tyhktTBUEb52o2DzHHL6tlw1aHK1sssrb5RAhGbpqhED9EGH2rLovo8ps0ho+n84foX4+0T7qPHWTVRDbc+JtpPB8TQ0l6xiqaIGhlvD1PKZy/qO2P+JZSMFjImmYkCG2mtjt8P4ujpnG0gsGzkK+YnWnBGvBFwutUgsiEAMoOAkY9t68qHlOjIbKs3riBwpURALE7lvt2HuXUKB4fL3nQHEnCujlMUDbOsyAMC5PAC8IxhVDSWkBG8GwiKTcpUtnxGE3Ns26wj+M5noYSdKvGP/d0nqLKsrAhMv2SHfA/WNUxrzB8rykGreB2nApPFwmGJqvAIv1jEUBwTFJDB0E5ts065Igx4xGBm0sANlUeu9lxqqT8vaR9j/vRm6tf/QE4MHDGGMmlJPy6QQVImfyKrj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KixYJnoR3lQg3bAghUEH9ycsdrhHjeLNpKg49t9gExdtdY2yRP8L4XwtwmK+?=
 =?us-ascii?Q?F4tWKf6P29vHsmkdnkqgFnqJxF0ySrl1wvMyiIdLdEGgjHkhc/QhnxsLbe3e?=
 =?us-ascii?Q?h5aVRhSFvLsiszA7VsKwHaQYELFiUjOl9EJr8zcO98BJABJw/mjFA39BAOS1?=
 =?us-ascii?Q?S7ILXGAFQJWNg5Z83DY0qp3lkI+HNTl64oWmqnaCYQ49hxqr4tI35jGDLVNH?=
 =?us-ascii?Q?KpU+iZBjkk2t0/AEOa++QrurEo2pBWnSx9cavW0qETogVT24FqsgsxMRPooY?=
 =?us-ascii?Q?xQSSNrYaYqE4DDiAiorV8K8WuzVw4MnC7ODFw78fq0KbcFvszqYMJ8bMPa/r?=
 =?us-ascii?Q?Ho89Tu3IK+wMeeWFo26MoaflMcKXQTmiX86mlH2q30dGTWO99W+mo3IwmWjt?=
 =?us-ascii?Q?nshcnRcCv9zVqHJuaPmJOQTGXrtwUgrBUxwiq8L24lufFRly/I1uaAWSeual?=
 =?us-ascii?Q?uLInh8NaSImmn13PYFGmKbV2zh/mMf/13fNIOWUqd/2sRC0TelMD7Oe1aQ4v?=
 =?us-ascii?Q?Q6/EhtgmCN7QaSVMuV/rPXl9W8VRggnc9/sDSKKCdfMv7RdAQm4Eeb+pxtDY?=
 =?us-ascii?Q?JwFXFQrlDe8yhDdL2Xiw8xGWs3XmmCfr6BqylY0TKzs9N8hNCSyptxlRsyj5?=
 =?us-ascii?Q?x3Pba+flyC9sYY6AbKjmeayUao5FgLHPeXjy2lrqlXFOqzCPBeeoT0k8vzuD?=
 =?us-ascii?Q?T3GJd0LNAmqwMC0pJv3I1LQQm/fVROqE3UnSxQAlF995plKkGVUJznIoJNeR?=
 =?us-ascii?Q?qQikOhqrMbR3L6gTxHGmCekaQUfLHx83/jGTiR1gBZtF6KkCbtE5BKVyuKEv?=
 =?us-ascii?Q?s6BsShCWt1c5CmauPNjJ9yV5JxZ20yL/Ub8lMqvZj2tZj7nUmHV9FMldSjiI?=
 =?us-ascii?Q?7HUF1PgsQjo1I55vxLcpt9AEtVAnRexLst9ZDwPGXNimRuDvhuhqtw7fDovZ?=
 =?us-ascii?Q?x8w3/VEmzY2qyV8N84DvKq/s0dH+DOiq8QwN4D8q+sly6MVZfZibBX2GujGv?=
 =?us-ascii?Q?DNWOOCSZBBq6EOrmlzr88y6yEU+kGwWh+Xh9vDVIdJFeSjuXX9WyW60CRguO?=
 =?us-ascii?Q?jiQUDBrDxemJCNVLeceY+w1HU0JYoox8eG4ZrgKbDChGCAm5Bvl7KgwVjgWl?=
 =?us-ascii?Q?dBoLsiD/g77NE9/mTJ0SH/B1hUC2Yy5+KPCaYxpI+9TGFZ8REH1+/cDe7Xf4?=
 =?us-ascii?Q?M18pzj8bqnODSzTDL8DNFdCTMjzNjbd83Gg4qDLxrGPIm8Ub5q5tTYE84YNk?=
 =?us-ascii?Q?Vmf4RpUKsTeCoDZS6HBJOA4guU8G3I+Gz0BC2nfvtzRd3bOlqGNnRp7cjPDj?=
 =?us-ascii?Q?EoG7712sgdHyM3gHT/fz4sb60RgYqbmheB3Z9jgSZLaXfgJxIndeVfgZNTnJ?=
 =?us-ascii?Q?YVw9HilGQoBkC3PoTwbIl57mLQXEWMIBark/0c+xAXlr3XhXhJ73VPasO1yX?=
 =?us-ascii?Q?wmMel+zzrdJzi3WRrbowPaEvb+I5WC9K2AcFN5GFCXMNtlkhmQyQimKVFyKi?=
 =?us-ascii?Q?OoQomktaYK7sky3TdZgf9063Xy917A3Rx2RY6T4XsDt+prs8oniMBpGFqybg?=
 =?us-ascii?Q?OexcDtB+XhYes0ZK9Wlx9wdKzoX47alQYD/W3wne?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e80b940-abc0-414a-0dc3-08dce73eca0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:13:24.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLZbQgiir0HeXP/EdDHNOwiqqjvfci4Y3I8wTKtcykd4cXK8X9FEHvGgbRANoIEQOd4Zfc82kT2yZtHrJoM3+EKWVtGnL4UfRa/S5EP/Yb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0750



>=20
> On Mon, Sep 02, 2024 at 07:11:27PM +0800, Minda Chen wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > In order to connect the USB 2.0 PHY to its controller, we also need to
> > set "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot
> > versions did that, but upstream firmware does not, and the kernel must
> > not rely on such behavior anyway. Failing to set this left the USB
> > gadget port invisible to connected hosts behind.
> >
> > Link:
> > https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_s
> > yscon__section_b3l_fqs_wsb [1]
> > Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Hi Vinod
   Could you review the new change of this patch? Thanks.

