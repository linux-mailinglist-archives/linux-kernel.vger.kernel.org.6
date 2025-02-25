Return-Path: <linux-kernel+bounces-530328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55ABA43219
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E57818830F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31A40C03;
	Tue, 25 Feb 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kkmwemNV"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDA1F94C;
	Tue, 25 Feb 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444494; cv=fail; b=YXCCYvEhpuVL9T+D/6oduG+Oh+Uls2w7T4N9sgmQjTJj3zx4ehKmHOjyKCy2+xaC+wIfThS2s4C37vXuG9unYQgJoPJcmrRYkzS/5D7fcyrSPM9EwlTOK0I0+0C5NWYDf+cr5fU8SVlZX8/hfKzduACLsHdjsJbyg+VnvyEBKq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444494; c=relaxed/simple;
	bh=Mv/GNBSXc0CLjp9+bHG2hT5Aq09iRGeHnmWgxMbc/iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YrWF0Z6zy8PEIlHwqiwGJPXK5qB6n/UgpBRez5UCiAu6+iFN+CouI/I5c3GBHti9wdDXLeZ/ftCaYSZw9bwBzlyJVgDLwEqAcdhMQoWwuvT5Tn0i66bwNTGPGSA8TR2H/Pv615U/bQJb2nrEOLNBsu7F15QRb87WNZ2CM3oOMFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kkmwemNV; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKf9p/FgVbC9bUPTjiSWuq393ZjtC4iqMpAtObev4qW4ONhaC7xUEoFe0X8TvQsHlazEv+sATtKs4E/b6BR8YZMbNgTWd85+vPn1ACB59QwpO0pajB5ilo8oIcIkriJg1tf3UDSCvo6xFKHL02RxwWlt+OFAr0wRgfLhAjNJJ+UID+NwmZ5/bONYr2vU2AHKahF+PolCLB9J81o9V44WSqM2t2XCzfJ6dkitIF6bwFI33q+TaGdtY2hUnmvozYTqgI4Giu+o2EBfKnp+I7Z5iq6l/y7DyeOAK0RgGa1C0yQlWg5iFB/+hZLZjO0Z5fgN4/zeREjgHA/8wrMbyXAvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv/GNBSXc0CLjp9+bHG2hT5Aq09iRGeHnmWgxMbc/iQ=;
 b=I/I9kxD35GiXKR/v1nIfyK2Vzpa/K7q4UkMSSp2sSQrIwiT4UsSvAuMQHyOYKVaSJFZ6WgOkHurh06I0ySBpwXpYXzxbbtqsdMBzvNmJaZA3c+o5fVXc3nyHtLlRoZmNI2SNK6/QSsyZWcRx/muIx03ThzERBHEZ0AqXqtYDcnMoDi8C1GueoP4PGripgK/xeJjLXFy810wO1jEuOrqGTPfy9H+9QljkjBmaiqxCK+h2fMxIvnpN18CH1bNFO+bf6muu23bNJfIjZWtm0cLzVc/mTFLf76A+bTUptBr+wTtmp/q22e3oP2FejYOD797BHPoSE6MhPzoNl1uZV8H/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv/GNBSXc0CLjp9+bHG2hT5Aq09iRGeHnmWgxMbc/iQ=;
 b=kkmwemNVZDYSSpd8j142VOLoIg+JtW4prlqaDlJpGMN3hk9LJ90hKoqOG1ROTCjU4eVx4A5enPP7/duW99l22KiAkpxO79FcRtuCYS5tlAMWUdmd5GjoP4f+t7jeknZXkG2mr4LD6grtCvcgi40IYUysltIxnSkNdenf9NbU6dpBN/+oB0fJR6E7+hjs4lYWaUTX1x29zQkfjbuZmAZT6WeQNgFv62lKAv/uu6Aq0nXuCxaNHU4roiTQKcEsnq8FXRu0XSAOzeubV4Nq4vi/GTbAkmuSQ8c/hx8gzLlLsiidLVj9xo/NSN8gduRT1h/Ai4Hx1zvUSAxCj138Q/K/Tg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 00:48:09 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:48:08 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shawn Guo <shawnguo2@yeah.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Topic: [PATCH 5/5] arm64: dts: imx95: add ref clock for pcie nodes
Thread-Index: AQHbccnn4hz0Vs2DMkCoCWVXyJXaw7NTkVIAgAJM1JCAAPycAIAAf3FQ
Date: Tue, 25 Feb 2025 00:48:08 +0000
Message-ID:
 <AS8PR04MB8676E641ADFE7920D0125ED88CC32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <20250128211559.1582598-5-Frank.Li@nxp.com> <Z7nmckvKi1xcb4Qo@dragon>
 <AS8PR04MB8676A4DA393EABCFF5DB80948CC02@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <Z7yoTPAvhzqfBel6@lizhi-Precision-Tower-5810>
In-Reply-To: <Z7yoTPAvhzqfBel6@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA1PR04MB10604:EE_
x-ms-office365-filtering-correlation-id: 0f166a9c-2d0e-42aa-8c17-08dd553612d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHc2bmxhd0ZkSGE1Y041QkJaQXN4dU9wZUNGL09xNHhvTjhEZWNpSlZPVjJK?=
 =?utf-8?B?QnRuL3hQZG02MmkwNUJBWUhxanRUTXliOWlJam10aXZHQXRhUEEvSXZrK0xw?=
 =?utf-8?B?YlR0WmFYUWxTZ1NTM1JYV2xJL2t1ZG5objNzb3Mxd05GMEhXRVVjbVhoTzVa?=
 =?utf-8?B?Y0tCcURJR0JwZUtXeEN1d0lNWlBENHdVKytyaTFiQUJVc3kvbG96bkp1cWdi?=
 =?utf-8?B?Q09aNjNGblJpZ2xWN1VwMHg1QkxRNTl5WnpVSCtxc0wveXBoKzBITHEzTFlR?=
 =?utf-8?B?cXhTZWtSbllUTkVHRGFZQy95eW9TRlhEQ3l4dExkMGNmYXVrWHU4cWwzeWxh?=
 =?utf-8?B?eVdHNmhBWDR3cUk1emtMTUE3clV0RVRKYXV3MVFEQklMMzZzTDRlVG9pTlFt?=
 =?utf-8?B?VjdGdEVvc3Y1Y1lySE1hbFRwQ2hNWmNwUjF1S0I5MXRLTFdKMnlEdm52VXJB?=
 =?utf-8?B?VmM1VVdDalFwSXh4ZU1RcDJKN3RtRnJmUGtnaVdETVhWZ0JoUzd1bmdub0Rm?=
 =?utf-8?B?dHBZU1VzTDFSWElIL0hIbklkaVZ6eWQ3UnJnWUhZa01nNVhRL3lLdjRNb1l1?=
 =?utf-8?B?WXhPbUp6VWsyV04reXFYVGJIemt1T05uaXpoTUUwWVVTSEZRUDl0V2tpd0ZG?=
 =?utf-8?B?U25sQ1ZtbHZDTW9rRElzUktkUFZNVkIwYnl5NDB6b25Fa1c3K2xxc2VjQkMy?=
 =?utf-8?B?bVFpbm1DS0FFNVZIY1orTjVEQkg0YmU3RUYvbWxpaGgyMmlrTG5KbnJ4a2VM?=
 =?utf-8?B?ZVFoVXUzcklVUksyc25QVEZZbmNRV09Ob3p3Ylk1R25zQTZJdDF1bEhYeHNF?=
 =?utf-8?B?cTgrdi82eVNYQUdEOUdoanZjL0Q3ZklBcHFRSGNJUkJZSkJjeGxIck53UVFR?=
 =?utf-8?B?clc3TnQ3eUs0Tnh5V0dWckl5SHlnODQ0OUNnTGJuaGVwN0xQd0JlZ29WcHVl?=
 =?utf-8?B?YjhSdjJqZVBpV09CbXl1WDk5LzlFOWJWa3dMSWtobTN3MXpTdDVQZ2cxLzQz?=
 =?utf-8?B?VkdBOHNCbS9RcTJJdEdXNGhFQXU0bHpxUS9KUWZnWHZXNFZKRC9UZndJcGZJ?=
 =?utf-8?B?VUlsZSs1SmE4VVdNWmd1VFNQZklJSzMyalJ3ZlpsRHhTRWMvaTBsVGVEOG9k?=
 =?utf-8?B?SEUvWERLcUgrMFpMazVLcStGMzFGU1NpZmhjbDM0eTAyMzFPWkN0eUxGemph?=
 =?utf-8?B?STNoMXpIYmJaRy8vTnZ0L1RoVEp4UTcyRlhDSEh0Z1cvcHRPekxwRTNpbFJr?=
 =?utf-8?B?aWhhTzRyUEx4Q0tsVHg4NWRjM3BOS2ZUZzhOWk1YR0ppR0lyUEtTVE1MVzhY?=
 =?utf-8?B?Tnd3NmlPc1hZV2cxelJNSE16WmhYbUFxSHNuck1oUHFqODZBalY2NDNNbWts?=
 =?utf-8?B?YVVVeS9QSEN6SnBocGdpSHV1TFVPc3Z6eGRYVzV6aUh4SzUyekx0V0htUmRQ?=
 =?utf-8?B?b1Noa2NFL0cxOFQwRDVuVWd6YzBWai9SdnRwYjFkaFg5ek9pdktVaWI2blBF?=
 =?utf-8?B?R3I5RG81bWVOZk42cVlrYWFZdldSbmE1dWNkbGhMYXEva2VWVENWMXZUNlJG?=
 =?utf-8?B?dG1EVWdMSVJqTUJjSnJSOFlmK2lxa29VTDhFeWwxeUlPRjRiUFN3ZzY5M1ZV?=
 =?utf-8?B?c3RCUW10bkRUKzNTY1V0V04vZXd0WWljdnBub2pZSU9UMVRBQVRUVGIxQjRs?=
 =?utf-8?B?T3o1U09kNENCN1pNbkQzekM5UWFCS3NWOFB2V2ZIU3p3N0NUNVYxbUFIWDQx?=
 =?utf-8?B?aUJyQ2dsWUdVMHdpV0hQRXJLdzRmNlpYeTlzckRPemRkK2dEL2l3ak55MjB2?=
 =?utf-8?B?MURvL2tteGVJYkwzSlJNckFYVERBVWc3N0NubEljdFIvakQvZTdIY0NWWDF1?=
 =?utf-8?B?YkdtQlJZemxnVXpFNFJZbXMvVklacmx3K1I2MWxRMVB1UThLK0dUWHVIUUgx?=
 =?utf-8?Q?nVBwybQFwttEOLdx5T9DvvyNJi+kbEGq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUdUdFNRd1dyODBOWmU4d0ZxOVE5aVdkUU1rMjhLaC84cU5CVTNpS3RvVDZO?=
 =?utf-8?B?Yk5VOXhmeUVoelpSSERhZXFReXRsSDkzb3Y3Q1VYTWcyaUtFMGlHSWlMR0Q4?=
 =?utf-8?B?T1hEWnYwdm5sdVBPV1VGQmJOVis2MWl3NXg0ZmdvZHp0MVUrSEtOSXdmRkJy?=
 =?utf-8?B?U2pKZXFtK245MDVEZFIrREhnUFArVWVJWVVzQmFwM0diQmNOOEs0Ly9Jd2d2?=
 =?utf-8?B?MDJGWXUrVXdBenNZTGNIL0tlbytFNE5JdGFTNGNPeUdmWGxiWGtnUW9iSzlm?=
 =?utf-8?B?SWoweU9WTEdOcHVFWDJxMUh2TFZaSmM0QUZxdHZ6eFZvbW5YL1hxZVVYYkZW?=
 =?utf-8?B?VUtPckg5azhNZ3lDM2l6Z1orMld6cEdEUXVMOFk2bDhwMDBkeUx3Z1BCc1Vw?=
 =?utf-8?B?bTd4S0NiTEpONEMxVENBWXkxMDgrTkZLdzFLU1UrdG80bWJSUVNTS3dxSlE0?=
 =?utf-8?B?T09BN1JGOXBkTTA0VDRoOVNwOFVPNVMrSUlnSjJzQ3VKQnRhK2dhTHFDeWxY?=
 =?utf-8?B?RlFPMmpKNTB6NFU4VnBzZlduNFdTNTlJaUc5VGZUQ2NFRllQVzZKODQvR2ZB?=
 =?utf-8?B?YXhWSFFBUDBKR1BCbm9CeGVubHJwdVNubXlUQ0hreitQUndpWHJqWjlZdU54?=
 =?utf-8?B?azlUNDZRKy8rV1lLQjE3WnkzK0NEcHlUL2xzQWptSmRKa01CNjMxSDNaVW43?=
 =?utf-8?B?MzM1MlMwZFI1TVNhZW1UQXlWZmlJZEZTY1FvclowODdrK2xKUjh5eFRzVWNP?=
 =?utf-8?B?RHNUVVJmM0h4UmhmeTdSa2tYUHl4K1NDOXlNNVRpb3BMRHphN0RJd3phdFJn?=
 =?utf-8?B?MExlR2VwVXJsNCtoV0FpQnJWRDR6TzRrTXBwRVhHRDgzQmF2NlNmNDNreGUv?=
 =?utf-8?B?SEhPaEplSlVrQnRGTXIwcnBjWEtRc1VMMG41dmtzanJ1WXBJdEd2MlR0U0or?=
 =?utf-8?B?VVQ0bExkWmhxcmc2dWhmdHFoampaOFp6YUpldEhBcVhtTS95dUxSUXl6YU50?=
 =?utf-8?B?UHpCYllLb3J4d2tpam1VY1dXRDFsTVZLM24vNE03bTNYVHd5eGR3aUhGM0Zo?=
 =?utf-8?B?M2ltSHhkMUk3RjdJWDFlcG4yRE9mQ0QzcHBTRHVKMEJkaml0enluR0F3Z3Ji?=
 =?utf-8?B?RnVaODFSZ1FiMHM0Vk1IWWd2ajEwRk5LL2VLL3JzZmFxdHpJcUFWa1FHSEZq?=
 =?utf-8?B?elRpY0ZQUlc5dCttRnoxT1F2SUpWczROc0JyYzU4QnZRUWhaeWpjRGFUNERk?=
 =?utf-8?B?dlpOTm81d0cxUjdzYlBNaXY1bkplZEJUZlVCMU1tMXR6REJFK3R2QUpBMGtt?=
 =?utf-8?B?RS9JRWhzVXNPbFFXZ3ovV05lUDE3dFZTTmZPVVN4VVZTOW9XWE9QQVE1U0o2?=
 =?utf-8?B?MUdzSDQ0L05pcWZBTjF2eTE0OXFpWnBkSnpCUldoc0pFYmJjR2lEaHRQR2p3?=
 =?utf-8?B?V1pOeCtGUG9RVU1FTXZQKzlDRGhMcTBOcUJBVUtNWFE3cmZkWmUzRXFOWElw?=
 =?utf-8?B?OG5CNElYWVE2Tk5nSWI0c2Z0dHJuTmhZZkxRQW9uYTBPYVd5SFhKdm5NcXk1?=
 =?utf-8?B?NU14d0tnd2hNYjFFcFBVQTF0UU01aStPYzViSFVseGhad1diRzV0ZVh3YXpj?=
 =?utf-8?B?elp3OFlCd29XT2tSUjBPQkhZQklDUGZFYjd3L2N3VFVJTll6MXBBUStUTk1n?=
 =?utf-8?B?aE43MlRGMWw4REwzVDZ2Q2xuTm5lcFdBS0dUeno4ZDZwVW9Cak4xTk85cjFD?=
 =?utf-8?B?aHpQVGIxMFJwUmhacDY2Z2dxOGtCc0RJaUxOTlhXMTZQVngzcWZ5UEJKWWwx?=
 =?utf-8?B?dDN5SThMWDVyd1BRSUVBTkZpUVJsR29OSFVyNGExN2QyZlZvYU9qczgvK1BN?=
 =?utf-8?B?MXpsUDR2V292dVF3TnZYeTAvcjBEQnV4YXVTK2pqQmtMck4yOXZ4WFY3ZTc5?=
 =?utf-8?B?eitXa0MzRWcvaGtSTlRxTlArOGxFT01ucEJob2JrcFdWeUhEZzlVWHE5TGpu?=
 =?utf-8?B?T2hNMFgyNk82Y0Y0R1RKQ1UrUzljVEd4cnJSQVA4YmtLQVRtaDJUSGZWdTNP?=
 =?utf-8?B?c0NQVEd4ZmlkMkRBbmZPdzI5Qm1qU1Fndm5YZXM0NlNSQlVKWnc1K1ZpeFFM?=
 =?utf-8?Q?Yw6Wh9SQ1RdL0eZ9smymFyYaz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f166a9c-2d0e-42aa-8c17-08dd553612d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:48:08.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psi+8bPDflhbSi2e1iRqo2eR23ZiDF1OcJb51UBJSH0Ebz32o32aQ9LsLoTXPzWBdGcF68SxG6m9bZZzMFIgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNeW5tDLmnIgyNeaXpSAxOjEyDQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1bzJAeWVh
aC5uZXQ+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+
IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5l
bEBwZW5ndXRyb25peC5kZT47DQo+IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47
IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORA0KPiBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklO
RElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgb3Blbg0KPiBsaXN0OkFSTS9GUkVF
U0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUgPGlteEBsaXN0cy5saW51eC5kZXY+Ow0K
PiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJF
DQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3QgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSBh
cm02NDogZHRzOiBpbXg5NTogYWRkIHJlZiBjbG9jayBmb3IgcGNpZSBub2Rlcw0KPiANCj4gT24g
TW9uLCBGZWIgMjQsIDIwMjUgYXQgMDI6MTA6NDBBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3Rl
Og0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNoYXduIEd1
byA8c2hhd25ndW8yQHllYWgubmV0Pg0KPiA+ID4gU2VudDogMjAyNeW5tDLmnIgyMuaXpSAyMzow
MA0KPiA+ID4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+ID4gQ2M6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4gPiA8a3J6
aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hh
d24gR3VvDQo+ID4gPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT47DQo+ID4gPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA+ID4gPGZlc3RldmFtQGdtYWlsLmNv
bT47IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFDQo+ID4gPiBU
UkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpBUk0v
RlJFRVNDQUxFDQo+ID4gPiBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8aW14QGxpc3RzLmxp
bnV4LmRldj47IG1vZGVyYXRlZA0KPiA+ID4gbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBB
Uk0gQVJDSElURUNUVVJFDQo+ID4gPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnPjsgb3BlbiBsaXN0DQo+ID4gPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIDUvNV0gYXJtNjQ6IGR0czogaW14OTU6IGFkZCByZWYgY2xvY2sgZm9yIHBjaWUNCj4gPiA+
IG5vZGVzDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBKYW4gMjgsIDIwMjUgYXQgMDQ6MTU6NTlQTSAt
MDUwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4gPiA+IEFkZCAicmVmIiBjbG9jayBmb3IgaS5NWDk1
J3MgcGNpZSBhbmQgZml4IGJlbG93IENIRUNLX0RUQlMgd2FybmluZ3M6DQo+ID4gPiA+IGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LTE5eDE5LWV2ay5kdGI6IHBjaWVANGMzMDAw
MDA6DQo+ID4gPiBjbG9jay1uYW1lczogWydwY2llJywgJ3BjaWVfYnVzJywgJ3BjaWVfcGh5Jywg
J3BjaWVfYXV4J10gaXMgdG9vDQo+ID4gPiBzaG9ydA0KPiA+ID4gPiAJZnJvbSBzY2hlbWEgJGlk
Og0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHAlM0ElMkYlMkZkZXYNCj4gPiA+IGljZXRyZWUNCj4gPiA+IC5vcmclMkZzY2hlbWFz
JTJGcGNpJTJGZnNsJTJDaW14NnEtcGNpZS55YW1sJmRhdGE9MDUlN0MwMiU3Q2hvbg0KPiBneGlu
DQo+ID4gPg0KPiBnLnpodSU0MG54cC5jb20lN0NmMzczZTVlZDFhNmI0YzdhZWZjOTA4ZGQ1MzUx
YTYyMCU3QzY4NmVhMWQzYmMyDQo+ID4gPg0KPiBiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzODc1ODMzMjMyMjczMTkzNyU3Q1Vua25vd24NCj4gPiA+ICU3Q1RXRnBiR1pzYjNkOGV5
SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWwNCj4gQWlPaQ0KPiA+
ID4NCj4gSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3
QyU3QyZzZGF0YT1nbHENCj4gPiA+IHZ3V2VhdnAxU01vNiUyRjhyWiUyRmJHTVhnSkhDZVlQWUla
VlczdmtURkhzJTNEJnJlc2VydmVkPTANCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
RnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPg0KPiA+ID4gIzEgfiAjNCBhcmUgYXBw
bGllZCBhbmQgIzUgZG9lc24ndCBhcHBseS4NCj4gPiBIaSBTaGF3bjoNCj4gPiBDYW4geW91IGhl
bHAgdG8gdGFrZSB0aGUgbGFzdCBvbmUgZHRzIHBhdGNoIGluIG9uZSBwYXRjaC1zZXQgYmVsb3cg
aW5zdGVhZD8NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
cGNpL3BhdGNoLzIwMjQxMTI2MDc1NzAyLjQwDQo+ID4gOTkxNjQtMTEtaG9uZ3hpbmcuemh1QG54
cC5jb20vDQo+ID4gVGhhbmtzIGluIGFkdmFuY2VkLg0KPiA+IEJUVywgdGhlIG90aGVycyBoYWQg
YmVlbiBtZXJnZWQgaW4gUENJZSBnaXQgdHJlZS4NCj4gDQo+IFJpY2hhcmQ6DQo+IA0KPiAJU3Rp
bGwgY2FuJ3QgYXBwbHkgd2l0aCB5b3VyIHBhdGNoIGJlY2F1c2UgdXNiMy4wIG5vZGVzIGltcGFj
dCB0aGlzLg0KPiAJSSByZXNlbmQgbXkgcGF0Y2ggYmVjYXVzZSBpdCBpcyBlYXN5IHRvIGZpeCBj
b25mbGljdCBhbmQgYXBwbHkgeW91ciAxMjVtSHoNCj4gaW5wdXQgcGFydC4NCj4gDQo+IAlodHRw
czovL2xvcmUua2VybmVsLm9yZy9pbXgvMjAyNTAyMjQxNzA3NTEuMTQ2ODQwLTEtRnJhbmsuTGlA
bnhwLmNvDQo+IG0vVC8jdQ0KT2theS4NCg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+
IA0KPiBGcmFuaw0KPiANCj4gPg0KPiA+IEJlc3QgUmVnYXJkcw0KPiA+IFJpY2hhcmQgWmh1DQo+
ID4gPg0KPiA+ID4gU2hhd24NCj4gPg0K

