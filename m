Return-Path: <linux-kernel+bounces-314027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4296ADE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8451F25647
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F722BA50;
	Wed,  4 Sep 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDzmkmV4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09579DE;
	Wed,  4 Sep 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413339; cv=fail; b=d/baxZAxr48tvRq7JAUtV4oZrfiPhw0f+X89RqwvHaXPxFJnl8oAXiG8DP4BKE2CMaJ207EZxctTkZNLyGxTr85FmaUiLdSDAazaVsa9TAr3mW292xF/4/fvmlIlce9xwP/dnNJFPy/Ar9Sq5hKnFTQQCP2INpjtDXXuom9AoDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413339; c=relaxed/simple;
	bh=KQcfuBM1t6izBuNrehStW4P8NIlfxxSbq9jzu2n+tbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoqkVamsoihvYHQkRA/Yo+sgRFz4LRkDxyi7x41wUc7Lo/L71+svbQOM4iCbfptyMtFx5phcUTI3Y1WD/8Rkg+cjA96qbfHBr+CqQFQ6XZdQkMu9JBhNAQd9rG+WLDHy9wLcfW4MZNXgMYuOfUm7S/M3hjtgRZcq6TeqkBm4i8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gDzmkmV4; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRDYfdoUxp5SRmEYZ3sF5zno7YjsaHAJHEbIqUJVhM3i5OSYnIXTmo3FkcPVHT1jmki0TSqiyOMot9+eHDsORcKv/KS9TYqejyHxokrIq4HuFRYhGiMJZXeEVE3IXYw3YtUMbyilbzqDyBZ0TBucRZFGddptfb0sPanlpI2CD8f1hb7RzJJKrjVuj4VcX6wxvkhodmBlxFeQ5aolialij/4qKOLrAPYG3KibFy2k46DDFIA7ux0KM2a7t5O7hP74epc/xzzA0q7CgnhPSlTkCM+qTSapXs7/Sy725hdLzs8OoCHjzhRjlB75MWyM7LCnVQ0AhAmq0htRNtj1ZR/7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQcfuBM1t6izBuNrehStW4P8NIlfxxSbq9jzu2n+tbk=;
 b=dBfJQsVFFigwKtYoHXosnN67P75SNV2lNlkiyK6+nF5iiuezyZbNuZ9giv3sVc2YDdZtbeitqKMKPIYQkxWgSRC8DvFsPmUPVYlXWHD5X6iIruNR7FwClVRdCEvTrARnbUSTpYaynPbk5ty/GoyMq7bdq9Bu6/eZX4KfvT2M4zXKrPg0URnaa/RfHQXt4yjFuC6+1tRF/sjCpvjC1xEF8nV4bMTC6s4fMd9aAQZjOPleoU3EUohXK/2GYs1EZnoN/Qv5xjkBan4TU7KIVXBu/x3rS8ws2F//8re/yogMoDi97FeYu5erTW2WLtvyWMlanKC7JcVwi6ClhLnAPl152Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQcfuBM1t6izBuNrehStW4P8NIlfxxSbq9jzu2n+tbk=;
 b=gDzmkmV4XfH7sp8Vm8gXMclM2V+fQUPXsmRsz6YVwX+FErfTjPOKHXnExnkj41lJJYUt8mHmxhcAisyMgpbO92BC5Diq3Wh6S3f3OuwpEI1rlPIOxExDks6ykzcRPFUzYYKKrZAnjLqCn2Lg3qSrDOOGxVMOGwn3me992EfnUgwyw7r4lvp/uWjkd2/H+IVgfeDgwWku+LVVW62xxoQWy3+YQ8ppglntmHZmUVkWDxSq5q48NHIOlPpfxXYd/WxeaEOd542Y8ER99KegJKewNN4559dqYGcHUhIxFVYz3XAWMgMnoyshJfG0OCRYTOltIQeuBZr3Sj434NWlC7A0BA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8805.eurprd04.prod.outlook.com (2603:10a6:10:2e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 01:28:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 01:28:54 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Topic: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Index: AQHa/do9Amcx/fZehUKA0S3Ogw2bVrJGBygAgADPcaA=
Date: Wed, 4 Sep 2024 01:28:54 +0000
Message-ID:
 <AS8PR04MB867649FB481BE553560A85168C9C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com>
 <1725350397-19527-2-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5DsUdus8b6F+vz_g7+tZum9e5WPmFCg8zts7qDU6DToTQ@mail.gmail.com>
In-Reply-To:
 <CAOMZO5DsUdus8b6F+vz_g7+tZum9e5WPmFCg8zts7qDU6DToTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8805:EE_
x-ms-office365-filtering-correlation-id: d5f02192-f748-4ae8-e168-08dccc80f0d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXpoN283TkQvV0lpYVJzUzhzWkc1YkMreUZTUlhpSkRFazZwanRSOUdmbkNV?=
 =?utf-8?B?MTZJK2xwbUVtWU45TjR6b0NrWXFrVlJsUFRKaEJ6OVZ0K01oTHZ4REZoSTZN?=
 =?utf-8?B?d3pmQ3VXc3R2TUpkK05VQjFqYm5ZTkRJUXdpMDlOdDJ1aXYycDdIUWpRL3d0?=
 =?utf-8?B?OFVrTkwwaFZvcS9xR21yVnZnQVUyaUxlL1lCeCt1d1Azbk5saTAycEZEUlF1?=
 =?utf-8?B?eXFLT3lvOHEyaXJ4SkdzaEVIVjdxaHRMS2piQ0FqV2V5N29xbVJNcGFnUW15?=
 =?utf-8?B?bTF0ZlNjSUl5c0FLdUJ5NUVkeU9EdEpKaDM5WFVKVzdFUnVBWWJzcGFldXJt?=
 =?utf-8?B?OE8zSllTNFlUWkVkS0tqajAyTjJDWVNkOFNQWnRaMUJiMlBEaFF2bkdEY1BB?=
 =?utf-8?B?MUNFaDFIWFkyWi9uL1FhdnhJdC9hOFRwM2NHelJ4NFpMVjZyeUY5aTNobmxR?=
 =?utf-8?B?cE5xWnlxUmxLaE1aNzZoNFJKUDcwV0hCMm9tbFcxbkdvR3VFcUxaZnp2YXJC?=
 =?utf-8?B?SCtHOTJ4NWxYN2ljaGJ1TnBBVy9MYzlIK25WcUxoS1BTSE9Yb3BEUlJPMDA1?=
 =?utf-8?B?NnRHSzhZRWIvd3dwU3F3blFsS0sxMHppeFZqMmxWUXJocjBJQUswSnNOeHBw?=
 =?utf-8?B?K0pMSGJFaWo4dDlnS09EY1k2Vy9US0hCNGI0My93MUpxOTRNVG01emt0TjY3?=
 =?utf-8?B?UjNnekJJL0lFQWR4VEhaa3VhdkFtOC9OMG5tY21oaW9IY3V2b202TjdXTGo2?=
 =?utf-8?B?L3VmdTAydHRCNjBSSzFGeFdYOEdCcXhNK2oxdllpcFZUWjRpK0NyaG9ndDFu?=
 =?utf-8?B?WnJhc2FHTGc4S1pLc1dmdFczUUlZaEFNcDk5aWV5VzRySnNMZC9JQ1g3QWNG?=
 =?utf-8?B?KzROdC9ocXRScFQzemdlZFdVL0lXNzF2YTk0RlFscHgrMUNHK01YVk5UOHc4?=
 =?utf-8?B?UW51eitNOGhqeHJyM0RMZEhXMFlVek1YZWRaUGYzbk1NK1lIeE1MM1BoUTVJ?=
 =?utf-8?B?MC9BNGVpRDU1V05GcjNoKzYwbEhHQnNFTFdsa0Y5SloyUTBoZEVFUG02Y3Fk?=
 =?utf-8?B?MXEzY2hqVFduQmFGdHFCN0RqaHJFSHBZY3pvTWJ6dFlBNGJsN2dSSzBaYU1W?=
 =?utf-8?B?REVPcUM0Q1FGUXdZRWxnQVdZd2RIQVBiUExHckR0dGZIckI0VEYwY2QzMGd3?=
 =?utf-8?B?ZkhGbDllbHh3S0dKQ3pteWtkN21aSWVJdnAvc2ZQclZJU0I2V2lkRXU5cElQ?=
 =?utf-8?B?T3hRWWVpYTJ6cWRTbkVOTmpFNFVWeFRIcW9MTWkrKzAycXRTTk8xZjlFWk8z?=
 =?utf-8?B?L0srMERRUmVEb081c1NxRUxjSGpVQ2dkVmd3RFVaTFBaNHVTQU9GNnRqRFU4?=
 =?utf-8?B?eUxpYzFaWlVmdW9CK1J1TW5vUDBQSWRXdi9ZMEEvdWUzYWV1Z1NBWmdlOVhi?=
 =?utf-8?B?UmJlQmdid0JLb083S0NYN0Y4NDFrT0p0ZFlwTmZaWmF5c2ZrbXhzMisyNExa?=
 =?utf-8?B?Nm1GZUw1bGRVNlBETW1UQ0dJR1NzZ0VVN3RkWU5xdjlSV2dCMGlSaW9CYTFh?=
 =?utf-8?B?OVJ6Y2hQUVpMQkN2dEovbCtmVkRvaVdXOEtaVEFFVlRWd1JrMjU4MjI1Zm5E?=
 =?utf-8?B?eTVjR1dpY3MvYlgveWlITHNSdXc3NFNLVlc3dDZ4SGRHMHVNVlZtYnV4WEQ4?=
 =?utf-8?B?WUJZa3RsR0V4VDgyT2x4OXo0ZTVabXhtVW9FRkxOeDh2cHhLekpobDBmSDFP?=
 =?utf-8?B?S3dSa21nQjdpcFkxdUpMdDVxTGdDRHJjMmtjRG16WVNzd3luMFgvUjJva0lh?=
 =?utf-8?B?bmdheFJGa1B2SVNybUpEV1lMdE01RCtjcFZ5MzdzcVpQYksvYjhWK3JzUkM2?=
 =?utf-8?B?RGlKVEN0MHBpQTk1WHpRMjlnUTIvUTlpS2g3bFI4SVV2UGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDlQZ3EwdFV5Q3lSMERMRUJUMnB3T29LWU15a2M2ZzBNQzdIUHlrMU4wRW5t?=
 =?utf-8?B?YjBrMFl0WDF2Y0lXZmxNRm4zNC94cEhTZVUyOXpRQzF5Q3BLM0RhQ1E2M0FU?=
 =?utf-8?B?aVFzTXRuaWhkWjVMbmxnZzdCLzlFYys2cmhPWHB0THhSbEtoSVZoMU5oTHJa?=
 =?utf-8?B?bUk1TzFNKzFNV0RTZ01Dd21heXlmaXdZNzlPMlJSQnZBclVPZWUyc0hzd1Mx?=
 =?utf-8?B?Y09YUVJiam1namxucWZmWkFiWGxNSDZ0MVlNaGwwWUNFRHZrb0FVUlUxc0gx?=
 =?utf-8?B?bDg5amxQdGdKNmtlYWpXK0oxR3dMTk0xcmJqN2hrZUM2djZ5UU5BTDZQeHNi?=
 =?utf-8?B?OG8wcStzL3ZkRHdWR0dKMmRhS3V5bHRFL1VHTnIydk1iQ3JmOTBXVGs2TUNS?=
 =?utf-8?B?Rlc1L2ZPc2pBaTRRellEK2ZnazlBRnRJSXowc2pRdW5oalErSlBDRXFIb2Zr?=
 =?utf-8?B?T3pRTlFTTys0dkd5ZGplblhHUEUrczNnNWF6WlhRSUFZSUVGakxQbUpsTURw?=
 =?utf-8?B?K2IvR1lxOWtPNzFVbE5lUDBuVEUzdmlCME83bXluNlFWUHBrOHVPVGsxRk0x?=
 =?utf-8?B?cE9nNXhXWmIySlhrUzZONUVUMWpOVTcyWmhsWkhMbm9PUk9vczA0SnE0OWV3?=
 =?utf-8?B?Wk1ZVm1sZWF6SnZYaGNVTVUxU3BiRkp3MnhvRVBJTVpqbWFXditBQlBmV0RV?=
 =?utf-8?B?ZG1EYlNVT2N5eWtwTVdPSG8xalUxQVZwWXNweVZoSmIrK1JsSlBBVms0VnVY?=
 =?utf-8?B?NWFjSHRXWm80cmdKckRTWUhwemwybzNSRkNrUUJ2bkV3RG5YMTgySngrT0Ra?=
 =?utf-8?B?WWhNWEphM2YrcmhMWVZEdG85Z2ZVUmJoYUZRdkhTalJwOCtYbVgzK1NLN3hu?=
 =?utf-8?B?UkFGbnpDc1FDd1RhL2dTUFg4dXBzdUlPTC9oTjFXcmdtN3Jld21qa2RWTnhs?=
 =?utf-8?B?NllpL29lTzFnNEFPY2N1dVVYUVpaaGhnaWNTZ3MwQi9aMUdnTzhWZjBoVlEr?=
 =?utf-8?B?Z3Nob2ZWUzZpODZHUFB4bnlua09WNEduT1JBaHpJU2JLZDM5bTlmcXQ0SGNX?=
 =?utf-8?B?Ykx3M3Rmc2tLMHZKaVpqVlR5TVVtNnJvWG5vYm81VThXd1ZKUjk5WUF1bXJI?=
 =?utf-8?B?bVpqRnpCaFl0M1JwZzlMTkhQVVI2cjVtZzJqN3FRbS9xdDVJYWxLYW9pWXUw?=
 =?utf-8?B?Ny9KS0U2V29YbFRscTV4c1FBd2hwSVFSVElCR2U4L21hR1dZTk9wSGYybHBN?=
 =?utf-8?B?ZUdncURwcmNKR2o3YUV0Qk85WnAwQXNmSjlkanVSZEQrTHg0dnUxWENDV3pU?=
 =?utf-8?B?NG1KZTZJbnF4blF5TDF1QS90T29wdDBiVjRJUHI1ZFExYmlGUHdqRzNIajQ5?=
 =?utf-8?B?NTdCZ2p1dTNOamtaRUQvUXQ4Um1QdS9xNjBMb1NIeGdzOXlFTlJLY3p2VExT?=
 =?utf-8?B?WjhDNklDMjBUcW9xbmNjNERuL1hhWnB2ZEhlWnljSkdTbEVWTWEyMnpwZ1Rt?=
 =?utf-8?B?YkNKRTUvbkxJSUJnd1E2RWwrNVpPSXBoL25URm1nTkNCU0FMQzZyQkRlOHdU?=
 =?utf-8?B?MFNmUC9Td3RNL0xJSk0vbWJ2Smx0S1JqMXpET3FYdFcybWxpdHZCT3FYNkEx?=
 =?utf-8?B?Sk41NzQyclc2eWhEZzRjYWQxM0NxeEhiZ0pHNExrdjB4Uk1nNGtPRll3UUVz?=
 =?utf-8?B?Z1NobVc5NzJQcVpGdWoveThJOWRjTkc2d0tHSUpLWnZ2aTJscWpQKzNIaW1Z?=
 =?utf-8?B?RmxqclkxVUdHWDd3Mk5CWFJkZFpibHFLSFNZN0dpU2NuWWozZ3A0QUVQVy9G?=
 =?utf-8?B?c1dzQ1prdmQzRFp1Z1QycWFBZjI0Q08wRGwzUTV0MDdxVTBmRWtSOFllY1Az?=
 =?utf-8?B?bFpDK0RqZnQ0Um1pVTlsbklsb1pCMFhLcE1HaHB1RWNmTFlFbGtXWjBSZ2sy?=
 =?utf-8?B?L2hjaVNZQU1HalRPR05tWTNWc0s4MkpnN0JoeGN6WEVCZUM4bSsxSnY1ZHps?=
 =?utf-8?B?K2xQNnAzZTJsNkMwa2lNNno2OFlSMGMvbW01R0RhaGJXL3dwNEhXMlZIcFBB?=
 =?utf-8?B?am1LbVRJT2JVL2hnV1pTWXdaUDlQc281a05KdlBRb0tqZmsyd3ZPektORE9n?=
 =?utf-8?Q?IcHij/lKyZBoKyx10ZNYiJIyj?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f02192-f748-4ae8-e168-08dccc80f0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 01:28:54.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6gZvYeG8gskhg3Fm7fUKzSBL1ihFV7qDaxL+wGfx98AouYmiwGIDgmADgHiYtI8uIyKttXef98/DBwxJndiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8805

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTlubQ55pyIM+aXpSAyMTowMg0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGFiZWx2ZXNhQGtlcm5lbC5v
cmc7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b207IHNib3lkQGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4g
aW14QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogY2xvY2s6IG54cCxpbXg5NS1ibGstY3RsOiBB
ZGQNCj4gY29tcGF0aWJsZSBzdHJpbmcgZm9yIGkuTVg5NSBIU0lPIEJMSyBDVFJMDQo+IA0KPiBI
aSBSaWNoYXJkLA0KPiANCj4gT24gVHVlLCBTZXAgMywgMjAyNCBhdCA1OjIx4oCvQU0gUmljaGFy
ZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBjb21wYXRp
YmxlIHN0cmluZyAibnhwLGlteDk1LWhzaW8tYmxrLWN0bCIgZm9yIGlNWDk1Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svbnhwLGlteDk1
LWJsay1jdGwueWFtbCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svbnhwLGlteDk1LWJsay1jdGwueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jbG9jay9ueHAsaW14OTUtYmxrLWN0bC55YW1sDQo+ID4gaW5kZXggMmRm
ZmMwMmRjZDhiLi42MzgyNDFmNjc0OWYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL254cCxpbXg5NS1ibGstY3RsLnlhbWwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svbnhwLGlteDk1LWJsay1j
dGwueWFtbA0KPiA+IEBAIC0xNyw2ICsxNyw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAg
ICAtIG54cCxpbXg5NS1kaXNwbGF5LWNzcg0KPiA+ICAgICAgICAgICAgLSBueHAsaW14OTUtY2Ft
ZXJhLWNzcg0KPiA+ICAgICAgICAgICAgLSBueHAsaW14OTUtdnB1LWNzcg0KPiA+ICsgICAgICAg
ICAgLSBueHAsaW14OTUtaHNpby1ibGstY3RsDQo+IA0KPiBQbGVhc2Uga2VlcCB0aGUgZW50cmll
cyBpbiBhbHBoYWJldGljYWwgb3JkZXIuDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkkg
Zm9sbG93IHRoZSB0aW1lLXNlcXVlbmNlIHRvIGFkZCB0aGUgY2hhbmdlcyBiZWZvcmUuDQoNCklu
IGN1cnJlbnQgY29tcGF0aWJsZSBpdGVtcywgdGhlIGFscGhhYmV0aWNhbCBvcmRlciBpcyBhbHJl
YWR5IG1lc3NlZC11cC4NCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIGZvbGxvd2luZyBvbmU/
DQoNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9ueHAsaW14
OTUtYmxrLWN0bC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y2xvY2svbnhwLGlteDk1LWJsay1jdGwueWFtbA0KQEAgLTE2LDYgKzE2LDcgQEAgcHJvcGVydGll
czoNCiAgICAgICAgICAgLSBueHAsaW14OTUtbHZkcy1jc3INCiAgICAgICAgICAgLSBueHAsaW14
OTUtZGlzcGxheS1jc3INCiAgICAgICAgICAgLSBueHAsaW14OTUtY2FtZXJhLWNzcg0KKyAgICAg
ICAgICAtIG54cCxpbXg5NS1oc2lvLWJsay1jdGwNCiAgICAgICAgICAgLSBueHAsaW14OTUtdnB1
LWNzcg0KICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1
DQoNCg==

