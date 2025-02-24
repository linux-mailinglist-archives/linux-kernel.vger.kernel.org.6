Return-Path: <linux-kernel+bounces-528072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF051A41333
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355D53B4453
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465D19C56D;
	Mon, 24 Feb 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8VqhdM+"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966923A1CD;
	Mon, 24 Feb 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363047; cv=fail; b=anxoDa8XvsHGNYM1uwrar+DBlWPoPUdEWFY2CHjqufDo2ktlwJy/irAWmkwxcIpuHgITKn+RSY3due/0MSMDoThBWNe6mRObzMocORCLczWkdmHd6yYFBNx2mSwfvHr+IL+RejgwNjJu+hfRIGz/G7DxGMdaRClu4RD+qPV33jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363047; c=relaxed/simple;
	bh=iukSP6hQjbevWO/G5yB/km8mSooW0IQG2lo98jhFvCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1RWdXHULiUBKqRL26XYWxwxHlkz0ZFdL+G4w9AAYlREgE6XqDlq1kbmJeMXngcFHvQKqbM84MOYB6BVWG4HSpbJ57gfLPaZyipjPyWaeGg7bfVwr8Pfma2yXLBivr+Hr1/NKm2Q96Z8ifS6z0SoYbwavZOj+sKSDCN8InvZdsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8VqhdM+; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/+a/VBUKsodzLcNY4yGUWX9+X3bhofOLjwbV1oDRJFEoBO6N3swkMF/sosWsWJbmYsTgT8CcRw75gl7uTfmYsXEPpdRt8T3Nkf9AUqAf14XHhx+EsZBVTc6GUlgWL2Fb0blA1DhKeOYqDZQ7XYWBmTDyjU9FOTC+VoSWQeG2fv5T4CV0VzG+J5b/hhAMOt+ixfeJads6+ehheEVKYVmEbQpAuCg7a7m9X/sEiGI9ryigfkS/EJtwd3Awhipynxko2LMUQrp4YjwmXk/us4gnjnjg7/JZMNnYuGQHXPQKXD4xobLO7/rzIJXBDrEVAmnBgBijkibF3fE+UMXytRSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iukSP6hQjbevWO/G5yB/km8mSooW0IQG2lo98jhFvCA=;
 b=yANraCB8MnOwOP2AdsEjCMbuXAy1KFOhn6fiQoTZpBFoOvgJenA8qkMLTysYNvoHz2sPxFlYlPQhUA0SAD7Y7xeaiPGAuHk0dfAIGGutCzhmXmfbNkLvauo0zdud8UiEI7fYbW5/uCrYyW7Gtp2U+coX7/eFO4FIXC7qhbwK5sfsbOtdpU9E+6q2s4SZDu4x+3BMhuJGKBxbwzMMN17TBF09vYmC1nx2tQdU9ycH5Y+KSSaM0iwPoeGbIAxIBx4SZhjQHOpbjUSq79yclTNewVOXhLsHvnQGjTXnT29kfDTbmAM+zzYY58or1t30DRAfRV6TQrMdl90Xq7EMUgZHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iukSP6hQjbevWO/G5yB/km8mSooW0IQG2lo98jhFvCA=;
 b=a8VqhdM+fsofkoPeFfRwpU1NvyNNgahXLOctD9/U8Og+oTPiAzkvrQX8/VRc1oenxus80RSAmJKr6wn6Us9Ss6wbKdUOsvQPA2Nx3zkN5y4KzHMoC0sBS0Yt0pYB4rT2dm1axlHgk+HGicgKXrqrqCKc6u6b6EdAp5ks2DEqTVEtBAvJbVLqqh3Q4C3NBXHOIzuBJb0w116WVFV1u4h2bb993rDgqunyJfNMzkWlx0BFb/0cIJzq+3BkIiyz7RMTkAC+QQUD9kml7kqqM53q5xJvHs14PX75c0rP6SaK5GjONHb6VXeyXLX1xiKcgts3ijOEHlLxq3LUSKEXnx6Ebg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 02:10:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 02:10:40 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Topic: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Index: AQHbccnn4hz0Vs2DMkCoCWVXyJXaw7NTkVIAgAJM1JA=
Date: Mon, 24 Feb 2025 02:10:40 +0000
Message-ID:
 <AS8PR04MB8676A4DA393EABCFF5DB80948CC02@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <20250128211559.1582598-5-Frank.Li@nxp.com> <Z7nmckvKi1xcb4Qo@dragon>
In-Reply-To: <Z7nmckvKi1xcb4Qo@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: b20f21ab-02de-4528-ce1d-08dd54786ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q3FPSXhOMzdRQTlISllXRE9rNUxoK3BvMEJTK0JDSDFzaHFuMElxL1I5aWk5?=
 =?gb2312?B?cDlrdzJjb1VNb1hHbGNhUXp4L0VQdGpWeE1zOGMycFVzb0hscDNkM3ZSTndp?=
 =?gb2312?B?Y3dxSVcrTHZ2dXIwUEtsNUZ2VTBGd1hMeTJaTnVGalo5cmhTWWk0RjlUMmpp?=
 =?gb2312?B?ajRMd2dpcS84bVR6bUVYMlFrUmxJUXptSHU2TXBxSkxjNlNqbno5ZzZtRVl5?=
 =?gb2312?B?aXBLMDVBc2N4ejdQaUlvSUUvWWQrT2xoUTY1WGQrNFVMaDlCZWFYUVN4cXov?=
 =?gb2312?B?MXR1UnA2MkdMd1d0YmN1WGFtQU5aTEJ0MzljZXJlN0RjUFFVdEFiOG1Rcmdl?=
 =?gb2312?B?a0VMNGZHWlJMbVV2Y3pmbzZ5WUorZzk0Uy9PVEtNWnkyYlBqT1NGZGVKemww?=
 =?gb2312?B?K1ZsNGh5UUVSSUFKSzhxUWpiN3IzV2d3ZTNDelBzQm1GRmlNZ09INlE4MGEx?=
 =?gb2312?B?OVg3NitUSytydDZVZHRWampNMUQ1MXpKMTN4RGxPK3VjYU5TMGhvTWV4a3NV?=
 =?gb2312?B?OW1DQ3Y1eWpUQnlhS3pnRG1KVzZNc05EQXZaQUpKdDhsUS9pa01Ec1J1b1ps?=
 =?gb2312?B?WTd1bTVkMUtvd1VDZmJ5a3VPRFVmSjdYaGpsek9uZHVjQUpWUHkyY3BEeW9C?=
 =?gb2312?B?aGpvQlZBL2RmUDh2b1BXNk1VVGdqMENISVVsUnY2UytQcEN0blVPQXl6U2Rh?=
 =?gb2312?B?VmFZVVlkcDhIcndQY2NjcDhHN1puQVdiRk9nbVl6UW5QcS8rRHlabk1FSnNB?=
 =?gb2312?B?SnArUkl2bEVlWmVLVHpTc2hyMDFLeXYwaXlzWlNXRmV0cUNYMm1PUEk5VFRk?=
 =?gb2312?B?TExZdi9vUFJodmpuNGYxeGFCcGRVWlJXaFJNV2NGc0tNWVVWVDlYb0NSUW1k?=
 =?gb2312?B?aWM2V0dBTy8xL2pSdjZxdWl3SjZyVnVZUUpRT3Y4QkhydmRvS05wZC8xUHF4?=
 =?gb2312?B?TlMwOUtOeFJybDJLaTI5cmxkS1JOUmYyYXorTnF1eVNwZXk3c09KYmpQc2di?=
 =?gb2312?B?SzFsMzdyM3dTYXMzWlJKTk9mQWRvNExwd3B6bDV6OFBmci9SZTZvdmpneURX?=
 =?gb2312?B?UDcwNkZHS3hicVg1WlpJc3BkU1RUZk9qSVQxRWl6S01rRHUzMUtkZWJZcWNK?=
 =?gb2312?B?SUxLN1RBUHVqMEZBVnZMVndTdnd3OHloem1ONmMzV3FQWW5LTFVqN2J1TVhU?=
 =?gb2312?B?MU5HUy9rbVRCQ1F6UlR4VnRnSCs5WE5mS0htU3BOK3Nlb0s4SkFqYU9JZUVV?=
 =?gb2312?B?VnlDdWEzWStsMzFxVHRSbzMxbmhFNTVHdHZ6N3diY2ZqMHlmL1pLNzlLSHZW?=
 =?gb2312?B?YXZkZ1U1aitBK2tQRjJzUW9JaXF3THBGWk5ZbzZYZWdTb21vUFJrQ1RTNmZD?=
 =?gb2312?B?UENOK1FHNHMvYmRIMHJkT2dybCtURnhXNVViVGpwbU5KV2hYT1lFTFZ2Z3pU?=
 =?gb2312?B?RmRmdll0UGoyU0hBcWxiZ1owUStvWlpwUzRVVFloVGVKZzZDZitGb0hHVGxy?=
 =?gb2312?B?VURnRXFwbUFUOUxrOTlOZlFNakV0aXIyS01nWEpqbElBSTlQbkJHSUNjbThL?=
 =?gb2312?B?REptZjUvazRCWFFmTDZwSUFjdGMzbHV2QjNDVjlMMkhnTjdJY3h5N1NwVFow?=
 =?gb2312?B?NUZlZWZlVmlnb0dGdEY0dTVha1pFOUZPNWZSNEY3L1NPWFJ4QVo0Nmo0UUlr?=
 =?gb2312?B?aUtvUlFMRVR3QXJMZGRPMzVDanhKMmxVbmRIb0E2QURDa1dGdS9OdFdMb2c3?=
 =?gb2312?B?ZWVwcy9uTUsvaXBDL2VlOTVET3I1bHNvdEphdWY3Q2d0R2NZTnRZaVljUW5Z?=
 =?gb2312?B?ajBWTjlIWXRoOE9hbTF1Q3QxUDFoTEQrajhscDIveGF5SVJVdzdKbGgwaEx1?=
 =?gb2312?B?Wk5GWkxFS2hycmFhT2lPLy8zWk91d0hJZEZhaDB0QmMyKzZqN1BHdjNWSE1m?=
 =?gb2312?Q?dcsU7AEYq1zEuxJYlmIvCRJ+WuhGsBN8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T3hkZ0VvL3BMWGYweGRmRlIyMGE1ck44TVZiZkVjYVBqc1BaYWVsZ3BKL2JX?=
 =?gb2312?B?REZGTDRwb1pmajZyTTdxSUlMZEhkWm5xK1UvNUJpS1FmeTJ1TFk5Wll3ZjMx?=
 =?gb2312?B?K3dLZ2xSS0hGMTJPeDBza0xuaUJWT0NFRFMwdHVRbFpDREtEVDh5dWV3UEhX?=
 =?gb2312?B?Y21MazhYaFdGSGI4ZlQ5MHJGM1RYQVowWHhKMkdZZlVycUM0YU82U3VWR0ZM?=
 =?gb2312?B?RVRrOEUrKzlIcHZvanUvTGIzUEtjSTByMEZjY3lWSXM3aW5kRHUzWXRMZHhY?=
 =?gb2312?B?dUlaNFUyQUswMWVNa1BPUDkvczZSc1VBWGd1eHNLdXFLemRSajlwK0R0MlZ3?=
 =?gb2312?B?bGthdG1QUGJ2RzFXOUw1MVIwbEM0cG9PMXBFM1lMQURqVXBFTTNScHBGWW85?=
 =?gb2312?B?c09SODVZMHRxYy8zVGg3UU5IUjhBZXo2YXR4ejBnSDhIQThzdDhJekVZd1FI?=
 =?gb2312?B?aWpab05MUTdNZjRyUWJZcExIQ2NadWJlanRRcHFvc09aeDJKRll4ZTN1UXRo?=
 =?gb2312?B?Yit1K1Zxd3BPWVlHM1VBTzFXYU55QzFDNlNHcmNxQUNrVURDVkdtUG8wUzRS?=
 =?gb2312?B?bHZHNEhSUVBnektoNE82aWsyYUVOc1BWWlVBTU9zck8zdVFqbERKbnd5Sy84?=
 =?gb2312?B?VFV0SHpvZ0czTWRpOXZDL0I4WjBkSnN0SkhnM0E0Wjg2V1BlM05mOTMvUzND?=
 =?gb2312?B?TUhmOE5FNVllRG9XeVpUM0l6d2pKTXlMNmFhOWdwdUVVQXduRVNxQW5PNkpV?=
 =?gb2312?B?dGppc0Z0SEd6VUZKMHZYamRtL01HZUZVcWRtOXhqZytMaGpEMTNGR3U5bkFt?=
 =?gb2312?B?bE1FcUdMRmErWXMzeENjMHRTNUNRQk1yQzVyUUROSnJremdKNXQ0VFAwcWJp?=
 =?gb2312?B?ejBaMjdqaDZhNUJZNFFiSWdJZTVIVGxRUnoyc1ZmVFI4Nm9ScldZYlhCRmp1?=
 =?gb2312?B?MVE5VUJUb0kwcWFSa0dsaUZxdTRwblQ5OFYvdko5WXNZdGl6U3hPZjlESVpB?=
 =?gb2312?B?SmtYN2NEWVRQMGNESmsxbW9GNDdwUE5uMnJJV2VuVHR1Z1A1a25WUm5JUzVG?=
 =?gb2312?B?V3B2bGNWSDhNL0o5SHVGZGZiVG9EQ3JLYlFuak1OeHNSNC81ZDVHZjl6SDVH?=
 =?gb2312?B?UVpyTGdiQ2xYVHhjVkwveldFSWJTcVFmckozVk9wbG45bFhGeEV1MkQ2ZDBj?=
 =?gb2312?B?NDFjYW9jM01zNEE4UHZ3eHRacUdFWDV6dzRSRWh2UENGVVFiWXpYekZiUDMz?=
 =?gb2312?B?MC9BMy8vMVBGalEySkdsbjExK1BMU3RsN2xMejNaSjRvYzhCaWhueFF6YWh6?=
 =?gb2312?B?RjFqcE5ET0w1STFKVjBCY3dxM2c4TzBhcWtTcWF4V0lxWnpwNFVubU92NDNJ?=
 =?gb2312?B?cjhkWEVMd1pQOEt3SUtJUGpzdkVrMVk1SGxYNElkbUxYbUtMaVlVMFpHcHFm?=
 =?gb2312?B?Tlc1R3VWWUtBNXZIZXpHNUgxNCs3VUg2N21FR1FEdFMvRnBLdFlWdk9RTFlX?=
 =?gb2312?B?RU9RN3ZLSmRQNyt0aUJta2VmdVFHS3owM1NJUHk4UmtVcytzSEVxeTdGcGE2?=
 =?gb2312?B?b2lNQ0VRQkhxdHNaV0NqUkRoZVhjUzdLcHN4eFQvOSs1MjNZUXFFMURRQ3Nk?=
 =?gb2312?B?cFNTRDAxajBNZUtXc0M4QUx5dmxHMEdzNDNxZFFXU05MUkZCODZFK1h5USt6?=
 =?gb2312?B?d29PRFN0ZHQ1bFg0LzZVelBwdGl6UTVUdktyKzhHVHQ4NTFPWUtZdkM5RWg3?=
 =?gb2312?B?MWVOZEJSbGlXajN3UGVFbEkyTzExZ3N1U1F2cXZXN0pKdGdnVjl4MFZrK3Qr?=
 =?gb2312?B?NzFXUU82S2w5UHdUank0VFF4VFV6azZPVWxxdFNEd0FYWExDWHpLQ2F6ZjJT?=
 =?gb2312?B?bGhSenZxanE2SVRRWnNFK2hEaWViRW5XR2VxOEVseE9DMjJxSGFyM0JpcHp3?=
 =?gb2312?B?aXBBUWtKTDgvMWFHWWlTOFlhMkJGQlBrRHdnN29BZTNiY3FpRjBQSXc3THQ0?=
 =?gb2312?B?ckhyMytWU3pOaWVRZ0JHd05aMGJiMnVoNERNbU1pcjNsZmRUSXJwenR6ajhn?=
 =?gb2312?B?VSsrS21lMzhGZloxNTl3SWhqcHdJaUE0VjNLbFh1ZHN1L01QaUp5azFRS3Fp?=
 =?gb2312?Q?8/jOT50P8gIEPUe88RzEadEfS?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20f21ab-02de-4528-ce1d-08dd54786ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 02:10:40.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3pR+mqk5xpHs4JN8JhVcZX8NFtLNgqCZhyYSQqEDMjNMegSg/AmwBTI7Vy9O9RNrubDgf1KX8ntOOUgWpDrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNcTqMtTCMjLI1SAyMzowMA0KPiBUbzogRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsN
Cj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2Vy
bmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3Rl
dmFtQGdtYWlsLmNvbT47IG9wZW4NCj4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQg
REVWSUNFIFRSRUUgQklORElOR1MNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgb3Bl
biBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTQ0KPiBBUkNISVRFQ1RVUkUgPGlteEBs
aXN0cy5saW51eC5kZXY+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvDQo+IE1Y
QyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
OyBvcGVuIGxpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0gYXJt
NjQ6IGR0czogaW14OTU6IGFkZCByZWYgY2xvY2sgZm9yIHBjaWUgbm9kZXMNCj4gDQo+IE9uIFR1
ZSwgSmFuIDI4LCAyMDI1IGF0IDA0OjE1OjU5UE0gLTA1MDAsIEZyYW5rIExpIHdyb3RlOg0KPiA+
IEFkZCAicmVmIiBjbG9jayBmb3IgaS5NWDk1J3MgcGNpZSBhbmQgZml4IGJlbG93IENIRUNLX0RU
QlMgd2FybmluZ3M6DQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTUtMTl4
MTktZXZrLmR0YjogcGNpZUA0YzMwMDAwMDoNCj4gY2xvY2stbmFtZXM6IFsncGNpZScsICdwY2ll
X2J1cycsICdwY2llX3BoeScsICdwY2llX2F1eCddIGlzIHRvbyBzaG9ydA0KPiA+IAlmcm9tIHNj
aGVtYSAkaWQ6DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGZGV2aWNldHJlZQ0KPiAub3JnJTJGc2NoZW1hcyUyRnBjaSUy
RmZzbCUyQ2lteDZxLXBjaWUueWFtbCZkYXRhPTA1JTdDMDIlN0Nob25neGluDQo+IGcuemh1JTQw
bnhwLmNvbSU3Q2YzNzNlNWVkMWE2YjRjN2FlZmM5MDhkZDUzNTFhNjIwJTdDNjg2ZWExZDNiYzIN
Cj4gYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg3NTgzMzIzMjI3MzE5MzclN0NV
bmtub3duDQo+ICU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3
TGpBdU1EQXdNQ0lzSWxBaU9pDQo+IEpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lm
USUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Z2xxDQo+IHZ3V2VhdnAxU01vNiUyRjhyWiUyRmJH
TVhnSkhDZVlQWUlaVlczdmtURkhzJTNEJnJlc2VydmVkPTANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiANCj4gIzEgfiAjNCBhcmUgYXBwbGll
ZCBhbmQgIzUgZG9lc24ndCBhcHBseS4NCkhpIFNoYXduOg0KQ2FuIHlvdSBoZWxwIHRvIHRha2Ug
dGhlIGxhc3Qgb25lIGR0cyBwYXRjaCBpbiBvbmUgcGF0Y2gtc2V0IGJlbG93IGluc3RlYWQ/DQpo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzIwMjQx
MTI2MDc1NzAyLjQwOTkxNjQtMTEtaG9uZ3hpbmcuemh1QG54cC5jb20vDQpUaGFua3MgaW4gYWR2
YW5jZWQuDQpCVFcsIHRoZSBvdGhlcnMgaGFkIGJlZW4gbWVyZ2VkIGluIFBDSWUgZ2l0IHRyZWUu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IFNoYXduDQoNCg==

