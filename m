Return-Path: <linux-kernel+bounces-280404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0FE94CA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BCC1F2649A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8E16CD17;
	Fri,  9 Aug 2024 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="KTrOF7KC"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021120.outbound.protection.outlook.com [52.101.129.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57606184;
	Fri,  9 Aug 2024 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183603; cv=fail; b=UYR0Jc7rI+81/tiIpZ+cqV0I0az4iVO9z6Pd4YlN9lI0p1eSEl3JTf+/bKU8vcOEgyidvTHRXiaYVtQTda3RAxhucIgsRXe6Q9mewHIP/o9JzQnu+y6uhOFsfEXhWqVqUdPIwhl2mWArKrSFmeLzlybc5tmUorHJsExK1mc1yTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183603; c=relaxed/simple;
	bh=bKDvPzj+qtYkXmMiCl2SR8RU0EeEKrC5A4N6d1pvs5s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQmD+/RRXmMQMgqMonw7EvQFWA7v8+IP7R53uKDZAfENnVg1lCAxnVJtwWkXZpd+5fCPq5+98Jpa/l8zOcyrQ77iznv/Du6JKriwFga0CzHJucxmwd4epzbjjeq+R7PTkEY1hiSeel2dOPh3VYTvZhHnkH3cF+TKoCvZHZMMud8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=KTrOF7KC; arc=fail smtp.client-ip=52.101.129.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA5kB8VcCpxfT4DpHZp2x0z8ayw0O+3Dg4S6kOaF2BnD2OF+8qB5YbanzSyoHT96aFWj5UwhikDYizqWg7P/DNVPLkQ2dFRrmyraCqBaWcL5VM9D8/nUbRFPmCPIkUJF3pe/CFIh5bZ6/5uzAkb2WA04EmdcLQWigbwLSudSs1yFx6MGdJAkuIb7jmbDrzY7jYwmq0gFh05viK0uzyLKI+tUYNn/o0zglTQLuL9Ee044KIhl88eAQrDplYICdpLXRXeAFP320xGGIOPrMeQfX9tIzaehIXBPh1lk33r9Xbr5jSEhhKew6JkAF2N0x+o7yNlCAOhG+vkJ7Prlfj90aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKDvPzj+qtYkXmMiCl2SR8RU0EeEKrC5A4N6d1pvs5s=;
 b=RprMVTrmk0u/yeQ0mynNDh/DLMuUFetzE9kPtpmAoDwIrE9dl7cavFlYL4V6vVAieC/r/ZJrDuRDbRNkoDtJonVdviLO3ZLyykFB8R3R1co1OH91wObdeIJvvGl2y1FtfYC2UV5yyo8qNQxDAqP1McjvmCGsFjFfNV2IYSapAqIotQ8hK877jAl+enomzGJn6XAJ3wAb5ws+733bvvzcrjFmx/ztu4Jbn5VL8HrIzLuP3LB5MSPTqcwndGlWRRf2l2wT7GlhetH5gPTxo0RoTOSim3B8bvORN6BKndjLwGMnkbkNAjhZeXG4I+LaqpuBAbOALCAJn9StGoUhpMGlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKDvPzj+qtYkXmMiCl2SR8RU0EeEKrC5A4N6d1pvs5s=;
 b=KTrOF7KCrp1PqB//lKiPV/ysk6GTBmTgTyoc1z/hBUAoutAAs7xsBTS+Ql+QNl0mxJ43OUS0Ys21hVXN/WaH52swYw3VRHYfsHBkDQQm30bVhwg9GSDjaPxeQ8BDDY87DEhVdiNMt2kC/eWwYQerNmjtKRG7TnFmXcqvSaCgSw/aYli1/+zeCwBLGaiBReJFfI8YtO1tjkl6vTxLGtBGr3wXrjAD7RJrGdWQyqxnBC/5ucDrsbPDTJCAmZCNL95+T54k9kXxqllF9LfvtdurPhKKrX7L5Fnkl1vbdbP1rYpjmUCZNkCtX3Yx7Asz6KP3VM7Jj+/1keHWbVlmkmKCSA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SG2PR06MB5154.apcprd06.prod.outlook.com (2603:1096:4:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 06:06:34 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 06:06:34 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
Thread-Topic: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
Thread-Index: AQHa6Wjv8i1M85vp10KWcohHrZz+5bIdJTsAgAFKuNA=
Date: Fri, 9 Aug 2024 06:06:34 +0000
Message-ID:
 <OS8PR06MB7541B5A820F68E2232377775F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
 <f12dd5c4-3b0f-4997-8368-1eef919d0cb0@kernel.org>
In-Reply-To: <f12dd5c4-3b0f-4997-8368-1eef919d0cb0@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SG2PR06MB5154:EE_
x-ms-office365-filtering-correlation-id: 52be10e4-583b-484d-1f28-08dcb8396bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3F0b0FJZE10bG9XOE1SUHBhbVd5dzBqeDRrMFhMdEVzQ0FHZGVnWDBWcGwr?=
 =?utf-8?B?NlBlTzhNQnBTKzNEbit2c1JtQUkwdmFaVjdBY1R3UlEzV0FyV1p4SGsxNVZ0?=
 =?utf-8?B?dEU3RGhaK2tmd01mSU9xVGh3ak16RDNVd3cxSjIzdUtCQUM3cU9pU1J2eDdk?=
 =?utf-8?B?UUh4NnZYQ2h2a1hEMWJQS0l0bnladEwxR2hBNXFaNTBCOGI1QlhFNm5NY3ZV?=
 =?utf-8?B?dE5hWjRMZ3FDZTZzdHE2bkx0Zmc4Z25GRnhVYVFWSnlnM0p0cENSTFg2eXFR?=
 =?utf-8?B?ZUhqYWMyWjBhVkNsSnZyZFJ0RmsvL3U2MHNPaXc5cWdkREhkRlEyeU16VHUy?=
 =?utf-8?B?VmtNdjhaandUNU1hbWg4UGFtWUxodW9LNVVSWENaWVhSUlJ3cjAzMWxKLzJU?=
 =?utf-8?B?NnBocDY1ckIwMkJzQ0VPTEIzMldoOHhqSWxQNGxlYUpBZ1Z4SVorVm5iemJH?=
 =?utf-8?B?TGQ5WGtTY2wrUWVrOWxnaThNblBhR1U0Z084WGROU29MWjUrT0pGdy9kRGZY?=
 =?utf-8?B?QllCZTJtSGZ2S3k3L3BtYi9mR05lQi9vM1dDWG10dG9YNDExVmhiWEhuT3JY?=
 =?utf-8?B?bGk3VHhaTTBxVm5SbHo5aUVZWUVqT0pGSjRlT0RpSm9Ec3pEaTRTSml2d3Bn?=
 =?utf-8?B?MDdJNXZ2eVQzUzRXWGZvTGxNNFZkTEZIdGx2djNTRHg0L0F2NHBsTE85Wjhy?=
 =?utf-8?B?US9ER2RHbk5wU2RJbzdCbDlwVGxzL2JwWVBWbG41eGxJQXA4SmorOEtuV21I?=
 =?utf-8?B?RTcrUmpFRmpOdkNQUVBmQjM0Z2VlZzl1NmVTdG9HUzNKc09oT1hoN09sSnNV?=
 =?utf-8?B?azR3aVlnWG4yemFIQWNDdWd5ZTI5NG0yRTN1QlpYQ2E4RElsSkJaa2lYa2k0?=
 =?utf-8?B?ZWpyRnJQKzFxZ3FyN3ZCcnFubTZkRndzbkdZRlV2UjhoSlAyYzZGcDlaZmVV?=
 =?utf-8?B?U3pJbzJyNkVUS2o3Ny9Rdm5Td3dTcTE4RUIxSzIxM0tiL3pTZmdvSDRHMks4?=
 =?utf-8?B?cHA3Z2N1S2dZc2VQd01yVGZqcFhVYlFVRTkwbnRzMERWbnpQNUI1Mk15Y3Zt?=
 =?utf-8?B?NVpJemRFOWFaVm4vRWlObzYxLzBiMk5sN1BGb0VkU2RSU1I4YVpTSGVBRkhN?=
 =?utf-8?B?aG5vVnBDV1dXV1h6cFl1dHlGaWw1Z3kvVlR6UFVITDBpTXZySnlIVzRYNGt4?=
 =?utf-8?B?UmI2Qmw4cHRTZ3R5d05kT3NTc3U4UVRRMjU3RjliYXlOZ1IzaER3ZWxiZ2I2?=
 =?utf-8?B?c3UzVDhvTkUvY0phckRxa0ZhVW1NRmNPeG9LUEpwRGJrTnIzcFhjRXEwWGtU?=
 =?utf-8?B?bUVvRnJLdTNaQVdCaWpNVVVkejhBR2FKa0x1OHVZMWZJZStXUVQ0eHdEK1Fa?=
 =?utf-8?B?RVl6czRudnd4QXZ2SWRkaWNTU3RnNjNMUUdRMFdsZzJ2WFp3VkVNb1IwcEF4?=
 =?utf-8?B?Y0pRaUJjS0Y0Q25IbmNjSDQrVmEvcmpYQ2NxL0FTcTlqd0dDdC9XVysxNG5M?=
 =?utf-8?B?QytqZXh4d3RQN0NhT3gxc1RvVDhYNkdNNnFzWm9QNEtKYXpqalY2OHpJdUNY?=
 =?utf-8?B?cDNIUk13OHBSQkhvbkh6ZnJKZ01MK0FjOUE4bzdMY0NrK1lFdG5FNXVyc2My?=
 =?utf-8?B?UFA4cHZjVUJ6R3NzWUhnQXRUYmIwSmhIbDIxWGhiYmF3OHNncm05VkpyNXRZ?=
 =?utf-8?B?akdoMUlNWHJqRTJrRHM0c0tiQkVQRitQQmQrKzF5ZWVCNEpGQ01HSHVndUY5?=
 =?utf-8?B?SEt2NndUY2tRbnVpWUdxUi9pK3J2VGJGWldvVCtja0RHa1FKMTRlSDU4WWR3?=
 =?utf-8?B?RXM4SGhoV2FycDdmZGFzRzdsdnI2NlQ1WHowempQdnMrR3Jsd0kwZTNadkxD?=
 =?utf-8?B?bmlSVzcvZEhYNlJoWi9NQ3c4UzA4dksrRE0vN0ZYdEVjQVhSVHkwc1lZMURZ?=
 =?utf-8?Q?Tj+WMvxf/z4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU9OT0ZXc3dGQmNUT0dWTHBoamZMSnJpUFdEMTNrRzNKNU5KZENGUllYSWFK?=
 =?utf-8?B?U2JTV1krZzFnWVZFaDhJd3pUaWZLMlovUGRvOWNab25jVnY0R2xrd1picHFy?=
 =?utf-8?B?cjRpbm5ZaTFNaGhxcnAwVlh4eDBqR0Z6cG8vQXJRRlBFMm5kWGNVTW1kdm03?=
 =?utf-8?B?QU5jTDBIVFdmVWhJRFpwVXhHOTlIT0J6WUhOaUc3UlJma3lxNXR4VE8vUkZL?=
 =?utf-8?B?LzhwejlyaGxDdWtZY3l5VVBtN29VaU1vbVJGT2lVR3dteE9QenA2QVo5eDdj?=
 =?utf-8?B?cTVjL0hXZTZvalMyOGQ1UkJFMnZ2OTBFUEY0aU5NNHdtVUhnc2JTNE1VTnB3?=
 =?utf-8?B?WXJFbUVSSU1iOVdNNHVYaG02SkJ5UUJ0dXIzNnRsdHd3S1ltQ2NJbnd6dHBL?=
 =?utf-8?B?bUQ4ZWtSbE14aEpIeUpPQ1lFdEtWVzc4cUVWS2g0UHNPZ1Q1aHJXYjN3cVBT?=
 =?utf-8?B?SnZRYTlBbnJ1YkRtVmlEUWhWL3FkSlVWdU1hYWpmNWJIaHpNWFBFNWZ2Nmw4?=
 =?utf-8?B?YTNMQkhMZThTRkVoQzdDSlZLb2FHb25TUEZFU2U0YW91UkFLbVd1dC8vcFlU?=
 =?utf-8?B?RXF2Tnh6UW9mVjFHSVNNNEYxbXNDMVB1SE53eXBTN1hZT05oZlI4UmJlcDVi?=
 =?utf-8?B?S3RzWVpEL282Rm0rVU9RTXhjSnVUK24rNis0Uyt1OVNVTm9uRlEvYStQVU5i?=
 =?utf-8?B?UDI1OFpDTGJYd0l6YXlTTTBZQ2ZoZHRJamllek1LMmp3MGw0dVlvRmJXaW1a?=
 =?utf-8?B?dDUxTTltd3NyTzhNY2pGME9kMjZsVGw5ekdxMnNpV3hvSzd6OEc3c0ZReFIv?=
 =?utf-8?B?dEJQWWhocy9Pak1RaytCeDRRdDB6ZWpVK3Vta2tLM3RnZ2NpakZ3T25Fb1ll?=
 =?utf-8?B?OUZoY2crMWk2VlEzaWhYNjRaYUxyWHhtVmsvMUoreFBxU3A2SVAxZVFLZ21F?=
 =?utf-8?B?N3NEU1hGM25uYVJUOWlMVytBSTlVN29uYjhuT3RLNFRFVEg5czN6N0NhdDBv?=
 =?utf-8?B?TVR3U3BsZityMmhTN3lWT2xadDM4dFB6aC90WTYxNTRQQko4WmswUk8xTmlk?=
 =?utf-8?B?alVTWG1VM28vT2VJM0l2cTVYcksyb2FPSGI2cFo5SUp5Uy9zOWNkcmcra2k5?=
 =?utf-8?B?VUFYeDlWeVZBTEIxc3NOUVhrNGN5bDRaN1F4a2NycERJTXpHWVVWNzgxTTA5?=
 =?utf-8?B?aFNVVjlrRTNBQ2g5UlIwWjNkdUxPM2VGbDZlbW5PeXJyYkkvQ2Ywa3BYOCtR?=
 =?utf-8?B?Qi8rT3JJUjdKQ1R3eHNrWDVSN25rdW9HQ0M3dlpKM0QwRXFMR3RoVVIvTk9P?=
 =?utf-8?B?cHBUQ0ZwZ1JsRDNqK0ZJcmxERWV2MEI0WEU2MDF2bWora1QwSjdZb3VDdkJl?=
 =?utf-8?B?TUVLSmZKNWtBYVlBRVgySnlMK3NVeUxwamZGbC9GRWxBNUtpLzdFSW9LRkRV?=
 =?utf-8?B?V3dzVTlObUZlNm84d2RGdDlqdERqMzFEYWZscFJJOVNxd3lrS1JGcGJiYU1B?=
 =?utf-8?B?UmJFQ3Y4cHFTcHN6UFRlak5paTd4bnNhUHJrd3FuSjlwc0d6dWVrOXVSeTFZ?=
 =?utf-8?B?ZE42VHI1NEVwVnpJbUcxeFFCTENCaWo2MVZwZkppYTdFOVZibmRFMjRuQklq?=
 =?utf-8?B?OW9SeExzVkNWZDlQRHlaVE5WU0I0N05BRmsvbmNIZ0RDV0ZyWE4rQm1kZVd6?=
 =?utf-8?B?aVhrR1dhN1lzamZzSHdhY2FYM3hOVzl2VmJlRklQYzZyNVVEUEhrSUtRN3pE?=
 =?utf-8?B?M0s5QkpwdzNQbTd1SzZ4THhRY1Y4TjVsY1pFa3dWV1l2R0lzQjZ3TmQxd05O?=
 =?utf-8?B?a1RCMGxmY2c4YzVCNzRvdUFNODBycUpsdVNBM1pZcmVMcy9sTGcyOUFaeEhM?=
 =?utf-8?B?SGhBU0d6Q2h2Q3RjaWNLdzVSa3ZHUEJQejlOVXdFWFdVS2trZkNUcVlFK2Yw?=
 =?utf-8?B?R3VCSEFac3I0NzQ0Vno1REMvbWhEdWhVbmN5ZmVqL2NBOC9qU2tKenNyY2dY?=
 =?utf-8?B?WE5wZXBWR3Y4UWdXWENORHlXL2VodUNueUc3eGZkNkV4aTF5Uy9VUEFrajV2?=
 =?utf-8?B?bVREcm05dmdEQmI4aHRZaWpJVk5xOTBjeTREc1JTU01vQlRzSEo1VmMxTWZj?=
 =?utf-8?Q?vUEbjtovWJxmTMNJTjOLNKS/Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52be10e4-583b-484d-1f28-08dcb8396bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 06:06:34.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFRvQonRjx8zvwS1p296NEf4fXBLk4hTCguZjfuAIaUevqLBmU23E0o7/jy+i5phqOrU9vnrYaPB9K7oF4VwSCxhwM4o7jm8k9V/9BhASXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5154

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gZHQtYmluZGluZ3M6IHJlc2V0IEFkZCBBU1QyNzAw
IHJlc2V0IGJpbmRpbmdzDQo+DQo+IE9uIDA4LzA4LzIwMjQgMDk6NTksIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPiBBZGQgZHQgYmluZGluZ3MgZm9yIEFTVDI3MDAgcmVzZXQgZHJpdmVyLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+
DQo+DQo+IE5vLCB0aGF0J3Mgbm90IGhvdyBpdCB3b3Jrcy4gQXNwZWVkIGFscmVhZHkgc2VudCBp
dCBhbmQgcmVjaWV2ZWQgZmVlZGJhY2suIERvDQo+IG5vdCBzZW5kIGR1cGxpY2F0ZWQgcGF0Y2hl
cywgd2l0aG91dCBoaXN0b3J5L2NoYW5nZWxvZy4gWW91IGtlZXAgYXZvaWRpbmcNCj4gZGlzY3Vz
c2lvbiwgZG8gbm90IHJlcGx5IGFuZCB0aGVuIHNlbmQgc29tZXRoaW5nIGFnYWluIHdpdGhvdXQg
Y2hhbmdlcy4NCj4NCj4gUmVzcG9uZCB0byBmZWVkYmFjayB5b3UgZ290IGFuZCBpbXBsZW1lbnQg
aXQuDQo+DQo+IE5BSw0KQXBvbG9naXplIGZvciB5b3VyIG1pcy1sZWFkLCBJIGRvIHRoZSBpbnRl
cm5hbCBkaXNjdXNzaW9uLCBpdCBzaG91bGQgbm90IHNlbmQgIkludHJvZHVjZSBBU1BFRUQgQVNU
MjdYWCBCTUMgU29DIiBzZXJpZXMgcGF0Y2guIGl0IHNob3VsZCBiZSBzZXBhcmF0ZSBzZXJpZXMg
cGF0Y2guDQpOb3QgbWVzcyB0b2dldGhlciBsaWtlIHByZXZpb3VzICJJbnRyb2R1Y2UgQVNQRUVE
IEFTVDI3WFggQk1DIFNvQyIuDQpJdCBzaG91bGQgYmUgYml0ZSBieSBiaXRlLCBleGFtcGxlIGNs
ayBkcml2ZXIgcGF0Y2hlcywgcGxhdGZvcm0gcGF0Y2hlcywgaW50ZXJydXB0IHBhdGNoZXMuDQpU
aGF0IHRoZSByZWFzb24gSSBzZW5kIGNsayBkcml2ZXIgcGF0Y2ggc2VyaWVzIGluIHNlcGFyYXRl
Lg0KQXBvbG9naXplIGFnYWluLg0KDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
CioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioq
KioqKioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXl
kKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a
5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL
55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7bl
kozpirfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlN
RVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2Fs
bHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5
b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5
IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRo
YW5rIHlvdS4NCg==

