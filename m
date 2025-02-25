Return-Path: <linux-kernel+bounces-530319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC1A431F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B92189B6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE04C8E;
	Tue, 25 Feb 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YTgxOQuI"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021110.outbound.protection.outlook.com [52.101.129.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218597E9;
	Tue, 25 Feb 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444073; cv=fail; b=LuYr/0Uje6ZM6vOSE9QeK5jnF+qp2+nyEVuExxh86l1HQpcSJANWGKy+RQ+A/NiWu+mAd//Y21/KySu6SR/Y7naYid6NPqWdItUY9rVSe3lU5hBoBjVx+/XFNrYTS3l5jdPLOZWCv2Qbao/+0pvp7oZOv0OtBBPlz08jCUZotYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444073; c=relaxed/simple;
	bh=HIzy66yrEeGJbnaf7tVIaFJITlOg3B5txXz4S7MQ08o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iJ2YWH5M0QVvbVhM4M8XKwHOxN9U3+tELwmJ5hOy+TmCLj5SCCI3WNkAuGgj4er1Iz38SHmef4fcyUGsNv2ZU0g4Emxbf3udiqZG91oYdsYoqJAXfOcV0Wjl8NezWHuLRQbKCMOBGTuxptD+jiMtCX1HZq0UOV1qR3m6bApTzCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YTgxOQuI; arc=fail smtp.client-ip=52.101.129.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/jbHIGt5ojCJlYbo3EwXISvkt+ik5iHiHnsMmQFWVXBwvhP35d/0fPUn1ZRAuXWChHX6VQnAyOUlu6JKsWpNi9NNiZqxL7DTKd7cBayss7maaiCn/YZnX55QMhKCiozvC3f01t5JGPBuu5nAaEFIN5PIL/cFFqnRPYtrVKaOYqgHqAvmgKy1fHR5pu5fQGW/w5Nbgj2XGN7OJ40sd0xyxnrKT1f00WBbHiCKONg1R93ajkLaLWBUT3NeYwSzB3mfoThlHV31R74QOc+BqTXLFRNBpecca95uc0Q8DYEN5knGaef+Q1zjrEScaV9G+CraxdWa6wpUVH/BUItLjej9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIzy66yrEeGJbnaf7tVIaFJITlOg3B5txXz4S7MQ08o=;
 b=wL8rqOlCs9DBt5J3Ilku4zalivcMJL0GQdb9wu+SEElqEeRYhUfFz5pNwYromS7914Pdm5JCKdtGUkgv32TcqCWGAknYD6eb3gD2m7hoZOD7S4ULcy5W40i2e8St0flb/3wIo4xeRxlmQjvHmx3wrZAGqg9+zIw+noZ7mi/mPS9dB9AO3HTizm2+MftukTEKxBhNBE+w9qA2p7tbP6S/shN1JSCyOuTDq6x7llDuwSbyhRWUy+z8fUaZDI3/R1F6nnhzLItj9ZhbVjvvLAU9GzmNbQnH91Dnwg5ZQ2aJY+n8muEB0ou6pfNz5wlGFLz6U/0UqhRBTU4zRjquCyIbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIzy66yrEeGJbnaf7tVIaFJITlOg3B5txXz4S7MQ08o=;
 b=YTgxOQuIeFvJ5VuQFm4uQ01VklTgzUSFm0/1JRGGVFQaoFwAjeMDpWbdtjFbdyBUrRaP8rPKfw5nM+ocknD83VFXKNHhJlT0Xhe2w7drr/dWh1h0lUvTVc+mpbZVQVtGkdopsKhUaIc7WfXBMhPKCORYu3LozNlvDZ5eeuKM9pytB9jt7vTISGwmU49nI+FA7SK+fVkNG4JsmD1gDzAkH2dtS1UulIpfCEzNR4ElQREaAUbieRbA69ElnPBJBGZhvdQMq1Kx0dNhJOVK+BLmaS5YUqeckdvxGWmDegcH8nzc7l9jWqHDRc8eNFnVMCbhDgwlzyOxadUiAK5GInKRYQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR06MB6162.apcprd06.prod.outlook.com (2603:1096:820:d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:41:05 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:41:04 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Topic: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Thread-Index: AQHbhqIygZnvzo4Bt0Wa/Nj5P77JfbNWO12AgADwbfA=
Date: Tue, 25 Feb 2025 00:41:04 +0000
Message-ID:
 <OS8PR06MB7541D685A626D300AC730A5BF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
 <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
In-Reply-To: <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR06MB6162:EE_
x-ms-office365-filtering-correlation-id: 1d0a9610-1cbe-4e23-5d8c-08dd5535160d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1FkY0N4dkgzcGY5WGxFVnFUTldzaUFka1VuTk5YeVFhZE5TMFBYRnJsckE2?=
 =?utf-8?B?c0FvYlA4RWZmazB5eVhuby9aLzdDczYyKzA0OVdtSDBwd09nTHBYRDRibVBW?=
 =?utf-8?B?cnFJZG4ydVZtRUN5aHA5MVV6T3Q5blFya3FQRjRZcXgyM09hOUw0Z0ZsNUV0?=
 =?utf-8?B?RG9USlpJbm5yYVA0NWI2NGhVR2JNdUtKSFN3M0ZjRitpV2o4d1JndTQrbk4w?=
 =?utf-8?B?bXZOVU5SZi9MNnUzb0ZGL1pwQ3dqZmN6RHNaUit1d3hVM1lBNkpoUUgxdGlP?=
 =?utf-8?B?Vm9NVmhLdVpQaUdQYUQxYmVISjJ6aFZGZU50NDA3SEo1clFsU2lQUTk5N3Rh?=
 =?utf-8?B?czRJdXdLcnJLVUNQUVBvN0J0WTc0TWZ5eGxqbTBWeGlzUXJ5cThqYkJtcTFM?=
 =?utf-8?B?ZHVCL0RYTTg1ZC9JOSs4L2V4QWZ2UDUrajNsMktqRTdnd2I2N2FBSUszWlVv?=
 =?utf-8?B?VzJZWkFFN1E1Z2ZVeXZyZXd2RUhnbmRYUEdLOU90SHBTM0RESzBiRkJhVUE0?=
 =?utf-8?B?a09LSjdkSlhDK0NWTzMyTVQwelNjbG1SMlQxRS9FdThKTGhNeHc3MENHazZY?=
 =?utf-8?B?OFZHbzUzYi9GUlN5b0FpVU5lZW1JbEY5aHMzRG1PRkxoWElMbGNXc1BGUGU3?=
 =?utf-8?B?ZjU3Z1lILzZJaTE1ZU5yK1JQTHd1SWNveEpFb1pKR3Vjb1R5WnRkK29pdmtJ?=
 =?utf-8?B?eVRTOW9WcUx6Ty9saW5DbXBvYTBZUjY3QzhMT2hFY0xvcTZ1VlRqL1BzTFdx?=
 =?utf-8?B?SVl6Zm93Q1FyQnFHbWpMdnpjNE5QQmczam92STlDVEVobllQZFlobTZjT3RN?=
 =?utf-8?B?Vm9SdWh2NjY1U2Z1RTFQM3d0VklkNmlVcGhleWFiWjJQMG9jclkxcTM1TDUw?=
 =?utf-8?B?MU5Lc0JpQlNhTVkzTlpBVEZhVlNEWWNIWXU0WVFTU0c4a2l5OG9UeEh1TGdM?=
 =?utf-8?B?Y3MrRWtnM01UWWwyeHBnMzIwckxLSG5IWW53Ym55VGVuVEtLWHp2LzlqYkxJ?=
 =?utf-8?B?eEI3V0hJclFLaURobGVlS1ZTVmZBa2piNCtzSTQ1czZ3T1Y3Y01jczhveHRu?=
 =?utf-8?B?aFA5TkFqTXRXY0dQWkJBS3pKQ0ZMU0M5bXpSOCtiSjFQSDhYdlZiNzdDSkJT?=
 =?utf-8?B?d3l4MlF0K0xZZW93b1d4dVhVL0VTNmJrbnV3SkRBcmVKTGdzTk1Bc1FScy9P?=
 =?utf-8?B?Njgzb1NidlNFSExGSU5CcDZpTEl1UytSVmE5MVNYK0FwenM3RmFoWjBVZ2Ft?=
 =?utf-8?B?NGtNcjRWMVVBVXN3RjNNNU40dTk5emhRRWVLcm1uaVZEb2E5KzkzaVhOWlJ3?=
 =?utf-8?B?Y01QSmRXamE1OEFBdmZRVjA0Y1RMcm90aDhoMTBleWlhMGJHT3o2VHcrNmQ4?=
 =?utf-8?B?ajBYZ0RiZHJZWVQ0d0piRm96cDZyaTJ0TWt5Vm9hNU9xOFljNHJsUnFQbjU0?=
 =?utf-8?B?UGRpMkllbFBVQ2NDbmJrcDBBSS9XclloclhSdE4yeS9UL1VTaG9xdXBUdzNw?=
 =?utf-8?B?RldTeWxsK3p1cHhBZmMybndhaXlRLzdRd1FLSWNrV1dzTDJMSkZ5dFNjV2Vr?=
 =?utf-8?B?Q3BwYi9Vb2ZOcFRaeDgxeWhMd0x5UjBPQnV5VHdTMWZ5Q015dG42SkJaMERu?=
 =?utf-8?B?bmpxQUJFa0JCemtiVlpPcHRSekNwREMzY3g2Q0kwZUQ3V2FXaWRSMkJ4cFoy?=
 =?utf-8?B?TWx1aWxOcnVmWndSbGtEdHB2WG8xU08zNUtFSGNYbGswcUErWTR4SThjZFAz?=
 =?utf-8?B?SXVoaFIvSlI0NFBrNURyeVNPV25ZR2J0QlVWMFdrTXlHRjJ4MXVPcmdxRnMr?=
 =?utf-8?B?VWRHT0ZyekYrbExZcmVESWZZWTlzVzhJVlZQRjRKa1EyR1g5SXRTVHh2eDUr?=
 =?utf-8?B?RmpldEhCbVZIRVZXcUlzYWkrZmdnQ081Sm42Z2M4endpVlF5blBkTTJvNmNT?=
 =?utf-8?B?andrN3I4dEthV0M1aVhqVlpxM0k5VDhZcklxUFBUR2wrSmdudjdtLytsb3ZE?=
 =?utf-8?B?VWFvM0J1bWZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmVCM2Ezb1c2ZmVJc01wdmc3bVZLaVdBUDBFaUp4K21QRU9sNWVHYklua0NW?=
 =?utf-8?B?Z3ZabmJpYWVRWXpGK2tYV09iOWVIeGhnaFFPNWNXNzEwRmIrSzBTNmd2dXdq?=
 =?utf-8?B?Slpxend2Y0xRUEd3dEpReWplMXR0K1ozOENMQVlWK0VOZkI5RkpBMmoraEgz?=
 =?utf-8?B?RGtUMGNWek53VThEUWFpZWsyQk9Nd3ZzbzI4NHFpd2xzcVZFcStYWXBWdDBD?=
 =?utf-8?B?aTZRaEdVR2QvY3ZoM0lmaS9oaVdkMFZEQnI1REtnVi9DZzdvOGY5dEJFWVA0?=
 =?utf-8?B?NWhhWlhnd25TZlBYdlJ2enovQnpza3BtUzZ0by96SnhpUEN6c2dhQkhkb1N6?=
 =?utf-8?B?Z1B3ZUJNMjc4VEpGYXZjc3BVVmR3U1l3S3lhYmwxZktHTGk1MTdrYlJXU1dU?=
 =?utf-8?B?eUlzazA3U3o3RVBZeE5ISDJXSXlITmwyeEM1aXRpYVlsT0Rpb1JyWUdUcVpw?=
 =?utf-8?B?OXN1SVNKK2JwZGlPeVM1Uk1CekRwUDlJTEt1SHk4NWFOVDMxbll5V05vbXc1?=
 =?utf-8?B?VWxzTHk1ajVxdTc1V3I3Zzl6VW9QbXNiUlRQOFBYdjZZMHd4OE85ZnhkUVc4?=
 =?utf-8?B?VnRkSnQwNEdrRy9TVmZhNUVJcGVTL1p0aXlMM1cxNXZXMisvTGlZcDB3Q2N4?=
 =?utf-8?B?dG96WUYxV0xPMTZ5amxHTWZoKy9yWi9lY1RvMnZyY2NFU3hKTllvdVZueTJn?=
 =?utf-8?B?cWtkbjB6TDNGWDZHSlhIbkFab0pTTTMvMzhMUzhiYUNZZTIzYjNnenBXcERt?=
 =?utf-8?B?Q3V5cXRocUFQSHVrbVpZY1daUmo1QXc3QzM5TWhwK0hYYVVVcUdHaTIzQy8x?=
 =?utf-8?B?R0xYZmpzMWp6MDhoSU9FUktoNnlTbkxhaFprNHR3Z1Qyc2RDcDlYWVU3VEl5?=
 =?utf-8?B?bFcyRVNKcWduRlJSS1dGM3lvMytjTmxtd3VMaFFsTVVCVTU4YnJxQ1lMdHFa?=
 =?utf-8?B?cG10Uk1uUFdMZGMxeWszdno3RVlTTUkybGppb3hGR05GMzBleWFYVnBhT1Yz?=
 =?utf-8?B?cHlLZWkrS0JUZVpFZ2JXZm1lYUlqWkg5Mk55SXBNWlpIRFlRQ3pwWTBMVlB5?=
 =?utf-8?B?OS9ieE1CQmJaVThFaU1QQmlIaUp4M0F5b25peTZiVW8wTjJkbkNicjRqdmts?=
 =?utf-8?B?eWkramZhRk9FekFVN1FMcXBTVjNSWlJGT1ROeVh1dVkxczg4dU1jYThsSmZD?=
 =?utf-8?B?TFJZN2UwbGx4UEJwMnQraDhmUFRRUUI4bEMvMlg2ci9yWXA3TnNicDNsVy9T?=
 =?utf-8?B?cTFNakgwTW5CbW5QMFZna2kxZVBTaXZDRVUvWmdMd3hRbnBsZUhEWEV6Sisw?=
 =?utf-8?B?NHdQQXlSZDU5M014SUJWUHNZVGM1R1hoaHhxRzluQlZpZDI0TmFyTkJPN0ZY?=
 =?utf-8?B?RW1GeVk4em5KeFZnYk14b21TdnlMWW51OGJEQ280OVdORktTdW1vbnF1Q0FZ?=
 =?utf-8?B?LzBERTNjTDV6cTI3REJOR05ScCtJMTVVeUFYNnkwWTlpWGVtN2poSlp4NVNj?=
 =?utf-8?B?b0NNd0FWcER2UnJNNkEzNXBiWUpyYkVlMkRVV1poQVlBTWlxL2FGblRrQ2V0?=
 =?utf-8?B?WlYwRWx2K2crMENQeFlCdWFWOUo4M0lQTGRJWFd1Y2k5aGlwMjlTRGZicGJk?=
 =?utf-8?B?Y0Z3YnRXL2lhRWsrL2pMdGJRQTc4TjExOVRDdGhNaGRQM3JQT3lzMTUyajJp?=
 =?utf-8?B?eWY4MkdXL1V3a2F3OGZ6a3B3WXFtYXJEYm4yVzNjSTJ5RUd0UGwzUllwdUZH?=
 =?utf-8?B?VjVGakxSVUl0WElOU1VaTEJya2VxS0dNZFEyVTZiSEIyZWg0ODZ6SzhZY2F0?=
 =?utf-8?B?Y05HVEJrVmZGamdMMkE0dDBjL01TQ2FxSWhsL0FtTGtDZFpBS2JmcXVTVDhi?=
 =?utf-8?B?RlB3elRwSTZjRWwvQWpQZmFhL1I4SmhleHFBM05uMWZ0QVRHVmRCRnlrc3E5?=
 =?utf-8?B?VVRFcVE3YW9pV0d3RC9QMnJHSkI3SHZLeDdaTm8xK2RvTVRRWnB0Z20xYUg3?=
 =?utf-8?B?UTFLcmZJZEZiQlNKNnlhR0VmbzZvRHJMQ2lrdmwvQVlLZ1pQVittczU5RHZl?=
 =?utf-8?B?bkhvZEIreVNmb3JjQng3bDBXQzZBdTNYK0JNaXNXdjg1bjk1WWhxZkJ2OElD?=
 =?utf-8?Q?27D06KGF8NLrpKhvsqyH/MxSu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0a9610-1cbe-4e23-5d8c-08dd5535160d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:41:04.7869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp/7mk6/lhCpnGG5b0ctn5PyDWI0FzSV04pnNGNeL7Td9oa9A6GKDeImepL6Ftm+I+s/CiwYP5ssbOTYOj9GEkfWx3baL87/IPb3wvJbXxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6162

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDEvM10gZHQtYmluZGluZzogY2xvY2s6IGFzdDI3MDA6
IG1vZGlmeSBzb2MwLzEgY2xvY2sNCj4gZGVmaW5lDQo+IA0KPiBPbiAyNC8wMi8yMDI1IDEwOjU1
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gLXJlbW92ZSByZWR1bmRhbnQgU09DMF9DTEtfVUFSVF9E
SVYxMzoNCj4gPiBTT0MwX0NMS19VQVJUX0RJVjEzIGlzIG5vdCB1c2UgYXQgY2xrLWFzdDI3MDAu
YywgdGhlIGNsb2NrIHNvdXJjZSB0cmVlDQo+ID4gaXMgdWFydCBjbGsgc3JjIC0+IHVhcnRfZGl2
X3RhYmxlIC0+IHVhcnQgY2xrLg0KPiA+DQo+ID4gLUNoYW5nZSBTT0MwX0NMS19IUExMX0RJVl9B
SEIgdG8gU09DMF9DTEtfQUhCTVVYOg0KPiA+IG1vZGlmeSBjbG9jayB0cmVlIGltcGxlbWVudC4N
Cj4gPiBvbGRlciBDTEtfQUhCIHVzZSBtcGxsX2Rpdl9haGIvaHBsbF9kaXZfYWhiIHRvIGJlIGFo
YiBjbG9jayBzb3VyY2UuDQo+ID4gbXBsbC0+bXBsbF9kaXZfYWhiDQo+ID4gICAgICAgICAgICAg
ICAgICAgLT4gY2xrX2FoYg0KPiA+IGhwbGwtPmhwbGxfZGl2X2FoYg0KPiANCj4gDQo+IEkgY2Fu
IGJhcmVseSB1bmRlcnN0YW5kIGl0IGFuZCBmcm9tIHRoZSBwaWVjZXMgSSBnb3QsIGl0IGRvZXMg
bm90IGV4cGxhaW4gbmVlZA0KPiBmb3IgQUJJIGJyZWFrLg0KPiANCg0KIzEuIFNDVTBfQ0xLX1VB
UlRfRElWMTMgaXMgcmVkdW5kYW50LCBpdCBkb2VzIG5vdCBpbXBhY3QgQUJJIGJyZWFrDQojMi4g
Q2hhbmdlIFNPQzBfQ0xLX0hQTExfRElWX0FIQiB0byBTT0MwX0NMS19BSEJNVVgNCk9sZGVyIGlt
cGxlbWVudCB3aGVyZSBgbXBsbF9kaXZfYWhiYCBhbmQgYGhwbGxfZGl2X2FoYmAgd2VyZSAqKmhh
cmRjb2RlZCBkaXZpZGVycyoqIGZvciBBSEIuDQpJbiAqKnRoZSBuZXcgYXBwcm9hY2ggKHY4KSoq
LCBJIHJlZmFjdG9yZWQgdGhlIGNsb2NrIHRyZWUgdG8gY2xvY2sgdHJlZS4NCkl0IHNob3VsZCBi
ZSBBQkktc2FmZSBjaGFuZ2UNCg0KT3IgeW91IHdhbnQgdG8ga2VlcCBvcmlnaW5hbCBTT0MwX0NM
S19IUExMX0RJVl9BSEIgZGVmaW5lIGFuZCB0aGVuIGFkZCBTT0MwX0NMS19BSEJNVVguDQpUbyBi
ZSAxc3QgcGF0Y2gsIHRoZW4gMm4gcGF0Y2ggcmVtb3ZlIHJlZHVuZGFudCBTT0MwX0NMS19IUExM
X0RJVl9BSEI/DQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

