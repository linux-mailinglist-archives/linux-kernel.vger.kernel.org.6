Return-Path: <linux-kernel+bounces-282884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73C94EA09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B3A1F21FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9A16D9DB;
	Mon, 12 Aug 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="GPcNyELp"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1C16D9C7;
	Mon, 12 Aug 2024 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455598; cv=fail; b=qzcuH4KuHoaX5TIfI/TuchxHGszCdkHpLVD2LueZ+bEYXSkybwhw2bjOvDq4v7xgWfcZ/ocnC7b0FrX0Wq+tfusrQbTT1fy9ODva5fNQ7tcwKMd/Zzi8RWHbv+q+q9vjG1fEYecsLMn7jyQrxA9NZdItGqczVDgkexr6ciS05UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455598; c=relaxed/simple;
	bh=HfCsH9FFNLPjz3GGF4Oyxu+oFdDfJWHXPC0tY88yZMs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilTtQoEDpqDU/E5Vr7QoxFT1Xs7TAaEVHlwXGrD5179ti/baaXw+sMBA7LCsxyDWecLwqFBPLZV28o8x6EWsLbYIh2Motk6R5Em8eup7hsF+jTYJuNGRQAGAyhF2m6q0+V2uCv/AfB/eNKYxDBEC3H3I1Cd720FZrdVytwE/Nls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=GPcNyELp; arc=fail smtp.client-ip=40.107.255.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFjaJxsdqroXmbWpmt9D4AorTS/Rl8fqBQSVyaUk0pqRIvndGbzOs0DFupGnTZUieeBjX2p3yHtFg7HY+E/letQDq0KBtohwbwkDx8/+OVJz5PZgjAH+M2lc2DEETC4Wr63fql/LiJzAg8f7Xa2xWt6MTSsHkyuUxp5cLcf6ubcURYSDnn0L9M3pq7P+kI7xOez7zIV118eDUtqPm2UqqfvidNmmQ2hy9nkMCMlATPsCOdKM6pl8YirD1EDK9mAozwR9TbxXQWcXBdek/x6zglalLLLnOjAl5NXJNwy6evdP/jsRzXjr7Ld6YN8BiK13nRvVa7MUP0D+elUo3VN+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfCsH9FFNLPjz3GGF4Oyxu+oFdDfJWHXPC0tY88yZMs=;
 b=gJvl+hd9Fxq+e0RpZ31OtGunPBa2BcxbJFfSY6MHWPcEelD+XMdRzAuGICoz21KlcQNVaGTTd2nCFuDvc+xvzbYG50lsV0JJnMQ45swD2nZqF/YvB91UWGxFgjh6vxOzSC7l4K7vBuBvIeYDklEbKUkzCP83g6XllrFIMGu0HTIdXWlDwdMHuWQEwrrb4IEx6/tcfrpj6DGtUQJDm5CSjau0pcRrafu5nro652VOPxq1jCaRKy0Y6qTNVe/qNUIdSnduZd1W0PT5Xa14VSTMJQOFPtbFOvAubzTttJPx65E2iaHvN18MInZu+ZHja+EOCHxlrxxdZapTdgYV/8urNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfCsH9FFNLPjz3GGF4Oyxu+oFdDfJWHXPC0tY88yZMs=;
 b=GPcNyELpoV887EAy1gB5IjiR0Qj97Ch51pjfMydQ9TKp17E3wJlQxMA2ihk/PUB1oNfiHabnLr/3BEpZ4IG/X9dFZobQcwX0KDfcJ3AMOYQPWttjeHgOk+JfhVqlz2eFuULvPqc5iLcESZIg7sjz7LSKpQs6ad9NA6y7tKAvUcEM7JzFNicYx0U570xxtVOuuULLInS0C1ihFkfMaYcOR7D2VkryQffREet4/rgsvv3KIS+0NTsFBTvqUr5qOXl44jrJJcSDYx4cgO0bcMBZEhctc9IFMKCGQxnaTbnQbqEsm/kREYaH2V3Ky1ZutOLbFCy0ca2GzBBQIoeXMUbCOA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:39:51 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:39:51 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Lee
 Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index:
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwIAADl8g
Date: Mon, 12 Aug 2024 09:39:50 +0000
Message-ID:
 <OS8PR06MB75415EC7A912DBD4D21A0035F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR06MB7330:EE_
x-ms-office365-filtering-correlation-id: 33e38a23-375b-4e7c-3d0a-08dcbab2b69c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEtWUCttNURNY3d6Mm5SNlMzQ0Vtam5tclc3MGJDOVFXUWpLbE1hWWZqZ05l?=
 =?utf-8?B?S3QzT3FGKzJmNE9pdUtNNnJ1QnYwUXRFTWVVVjY2N05ydUFyRlMvd0ZKRmk4?=
 =?utf-8?B?MlNnTk9YSWxUemVtQlpYNVkrMjNrQ2ZHWmFteW5UNWliQ1NrLzBzcG9mWkY2?=
 =?utf-8?B?Ylk1cDVjeFA3Nm9NRXk1UlVEb1RrYnZHR1p1dnkrYW1McXJmZjdvSkhqYVlZ?=
 =?utf-8?B?OXAyZDBhMWNZRFlkQlo2NitvL1Qrb2xSdG02OU9nNmdqRlRWTDVjbUZwMkxM?=
 =?utf-8?B?Q1hXbnlVZ1ZENTgxMVR2Zi9jUURVR1FQQllKNVFmTTNZbHpRQ1RyR2hKYW1G?=
 =?utf-8?B?c2V5d1pTY3Q3U09xd0ZNSG9kUUJDeVRxQWMxY2hNRU96YlVJM2ozM0lwUHZo?=
 =?utf-8?B?aE5nTXV3a0pPVzRwY0NTWkx1ZHVTa1RBMWp4LzJpMk9tT2FtTTZMb0Q1V2xv?=
 =?utf-8?B?R3orM0IxSW5SejVEaXNMck0ydTkzMWZlcDB3TlM2SGxxZjI4QWdoY1lMRkds?=
 =?utf-8?B?NjNkTG0xdXR2UE9OaHhMeUYrcmF2RVhpQ3VjT3RIKzlUTzJneFVBUmpLSUxD?=
 =?utf-8?B?L2w2TmQvbG1yWGM2aFpFTEQrSHJ4eTNiWWFmZktQZmJkZTNOSXJMbHBFUi8y?=
 =?utf-8?B?bDc1WnZYbzI2cW1aWWhIa1pqdWgyTnpQZGt6aE50blpzSG1LK1VESGk0SEVk?=
 =?utf-8?B?cUJpY0NQOXJsdXFRazNKTndOTTNwbUpwcFhGWGJVZjNyL3Z2cVo0N0I3WUFK?=
 =?utf-8?B?L1IrVEc0TENMd253dUVnQUhQSDZCS2xEdlZ0Tis4WHpUakl4Mi8zR2xFeGp1?=
 =?utf-8?B?aERBL1NLMzZQeGp6YnZ0eXJ5KzFLdnZiRTczNzlwT1B4RFI1NEFjRUZ4blpn?=
 =?utf-8?B?SkxIMEZoWHdoQnUveWJ3SmZCWlhFcmxMQlQyTU4xcFpuNWtRRDhJbjhaVU9m?=
 =?utf-8?B?Wk1qSDdvYW0vVlVyMjVaMm5WWHg2VzNLZjFJVThtU3I1N2cwTTFxUHd2V2dj?=
 =?utf-8?B?eFUxQUI4QlNtb2Zqc2VZRTBZK1BVT0FWSzN4RWNoTTVzODNHVm15bFJabzhq?=
 =?utf-8?B?RGJYRTlSTnBJOVVFalozUjJGcHNHSXFjMnRUMDFMSWRaRVdrb1MralA3cjRH?=
 =?utf-8?B?WmV4K2tVdXlyc2VGVHZNQ3lMYnhqckU0RTdsVnRuK3JrdUZTWEk4cnRSMnVZ?=
 =?utf-8?B?OTZqOGNZeU02eXg4WWJYOWsvNmlvZk1pbVpsUGE0TWU0UTNRWlRwYVR0RTFZ?=
 =?utf-8?B?dkhXU3ZlcFNGYlNieTVUTGJEMUR3Vk5xeWd4TlFuKzI5aXp0MDA4ODF6ZGdO?=
 =?utf-8?B?eiszQjd0dU56M1UzY0E2bUpDc3NrckVoN1RnWElsVEdGR2I3R2dHWmZqbXls?=
 =?utf-8?B?MU16VS8zTHpFaFFUMnlrNzloQzRxeVhNSy82S0YwQ0dvR1IrS1JiNlpXNnlQ?=
 =?utf-8?B?MW9IYmpVTHdZd1RJbTJqSnM0VmV5N3ZJY1BidUovMjhoRXYwamxoR1lGSDF2?=
 =?utf-8?B?eUFaVm1iY0pYV2pIMENjeU84ZUFnb1VHcmE4YVZzMzNwN3ZlZ1I1T1ZaeW5I?=
 =?utf-8?B?RVlLampMVVdRYTZaRWNOU2s2NGVjRXRkamcxc1o0d1ZwcmgwNkxWbno4ZGdz?=
 =?utf-8?B?ZHliU3FaSFNsdWI1MDI5bnI0VjFMWGZnbUh2Z0JvVzhjb0xIRVluSGg3UEFq?=
 =?utf-8?B?Wlp5bkprSzNXT3QzVG1meEZaY3QxYlFWeUhxcGdGK3FlMWJSaW9vcXV1LzlZ?=
 =?utf-8?B?ZTZ1ck5HVlF6ZnhoaXdLVUlZM2VhcGNMNHc5eWVSZnJiNEhHWGs1em0vVU1X?=
 =?utf-8?B?b3VSbVhXV3VCWnhFVTlLSkwxbVNvMjIxMkZzNEpEc1VzOG1SSHYwWTVKd3FL?=
 =?utf-8?Q?UAKLUfaBNbUtK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWMyYnVhbTg4dmt6YW5yWVUwOGhnczdmMzBYbEVnYWNNNlA2UFRRR2hmRXdn?=
 =?utf-8?B?dGhPMVNFRDlPcXFPTmNnamcxT0tTVGtKNTQrMG4xS3NvTFZmOEkxZ0hPR2k3?=
 =?utf-8?B?NFpRZyt6amRBdDlxcFRuZmlrMysrVlEvRW53eVpnQml5UnZhNTVRakplVE1u?=
 =?utf-8?B?VGphbEJuMWlEZ2tTb1BIRDE1QmlJeHkxVzQ1OXdYY1o5dTlZMDFiWmFwWjIz?=
 =?utf-8?B?aTZMS2J5d040VVNuWUdpSFgzUHYvZ1Bzemtjd3lzdlFlcUNLTVgxRmJRaUl4?=
 =?utf-8?B?eml3QXdkaVo4YlF3bThPUGRsOWdoUVJQU0FzMjJVQjZWVnZMYjJCSXpmWFVP?=
 =?utf-8?B?WWh2YTAxOXkzd05Ja2F5b1dPNVhsajMydm51ZnpiL0VISG1QTHp0cHQ4N3NC?=
 =?utf-8?B?czRKZkMvdStXQSt3TklkRmM2R1dxZ3RPUlg1ZjlvSkpuV1U0RjlTa1QrUStW?=
 =?utf-8?B?bm54QlJFOU1IdDhsSVVuZnp1SDhEckp2dk5MbUtVSk1VUDcwSzExcHpLZkEv?=
 =?utf-8?B?MTNwMG1abXJyTXhJby9mRHE1QW0yblZCb3hsdWs2eUN3dDJBdzg1ZWFBbjFN?=
 =?utf-8?B?d2ZYUVFUMEFTUGlJUjZLSnJ2d0tCOXNzb21kYUVyb2NQVVJRYS9WZU5mRW1t?=
 =?utf-8?B?aFRzc1I0cHRIWHF3bUVxUWlFRy9iSW9qS3MyMmVQUEJGVG9KbmVqYkRqWnNT?=
 =?utf-8?B?QjhmaFNXL3BTR0dGVEkwY2hGSEdPZjl5aGp2UFRjV3ZsLy9zaEo0YUl5TWpy?=
 =?utf-8?B?WmR2S3h5WE1oUGFkSmh1eWRPVkM1eWppOXc4MXRRTXhQalRSM3FnU05xNlUz?=
 =?utf-8?B?ZkNicEJraldGZDZzZ3hRR1huOXQ2MEx2SFFhb3BmQWdBcTlza0o0NHZZODNl?=
 =?utf-8?B?cS8vN3ZGVlJuT0tJaDloN1djL29PNlhKSDdHSitXNWhhQ25mWmsreTR5TjZB?=
 =?utf-8?B?MkNWWlF4TTZuVjFZVWoyNGFFOUQyMG1zNFNmeGdHQ1Z0MWw3bXhIODV4SzJV?=
 =?utf-8?B?Yk1Lbm9HTlVRM21hV2ZSeVlnVEpMejBJMWZXSGJtZktWRFFiSWlYSnJ1ZFFB?=
 =?utf-8?B?M3hqTFFRWUk1RkhoV2lzREVLdk5IT2M5S1hXTmpETTZBYTk1aFVISWFPbWQw?=
 =?utf-8?B?SmlEV0owelN5R1MxdVhLc1U1TnBhd2lhNTBablJCN1VFTGhQSEcwVitsY1dv?=
 =?utf-8?B?bS9pcXNRNXZveHR3Vlh4cDZyZlZRUmZSNmFwRDFKTDdTTjlHazF3NFdOcUVy?=
 =?utf-8?B?UXBuaW1HT09nM2dST0ZjZkFZeUk0Nnpvb3VhV0xrSmo0cEsyNlA0MDliSEc4?=
 =?utf-8?B?WExHQ2NTc1EzSE9wMk5wcUh3NTY0Q2xuM090S3lhbFRDaGJyMFpuR1J5bVNX?=
 =?utf-8?B?ZkNFQkRRWjZMMTBXK2dRMDRFeU1KbjNqaHhvRDdORk1zT3V4ZkFWVnQ2UVJm?=
 =?utf-8?B?dmx1aW9RVFBTSjNpV0trRXRlNHJwM2hZQjNaNGk0NG1mQm15SzNQOHRtUVVj?=
 =?utf-8?B?YmI4NVV5bzd5RG5oSHc0Y2NnalBGWEVNL0pZa2RDNy8rb2NQUk94WG9Ld3NW?=
 =?utf-8?B?anRyR2M0UGZpL0hZOGcrUkkvWWVLVzJuRWtHMmxRVHByM2h6M3VsMC9pUUor?=
 =?utf-8?B?UEt0cC9BZm01N1pHOGpoak5YZGc5M2FINzhwZGFlTTd6RHR1elRmek1PcGo4?=
 =?utf-8?B?V0ljdUNqOThJRXVPaS8yRFIrWjdTSGZ4SFdNUS9GaEhTbnpNamhxTFdRUXFH?=
 =?utf-8?B?OEhVYVgwOG9SQUl2T29Ram1DM3duSlA5SklpYjdYNE5HMTQ0VWZjemJyQWwr?=
 =?utf-8?B?MWhucTdKOVh4TnZwVjdJekIxVFhMQ2hScGZLV1c5emRuTkVLbHJhNlNJYXpZ?=
 =?utf-8?B?U2FKbHFmY2tNcGw2T2hYSW0yNEFqOXR2MERxYVg5SGRJa2NRTjRoVDZaZEs4?=
 =?utf-8?B?SDBTUXJ2SFR2NDBITVA3eS9lLytjbjJjUldpRnNiaUtTVXF6aWh4TEdaNUsw?=
 =?utf-8?B?MDJlcCtGRTFLZ3MrK2FGQ3RVdmQyMU5ab1Y0NG9kTy83RDgrY1IwcVduWjBT?=
 =?utf-8?B?MmQwQTg3QWlBY213eVRUMEdLWFgvakxxTHRMdG93TUZEcVhnTEFod3ZPN094?=
 =?utf-8?Q?pPpRvEx6XE/0g89L001nC9MU1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e38a23-375b-4e7c-3d0a-08dcbab2b69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 09:39:50.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYQArynqfqYCoyJIrngmXC3z2iQ24k3HD384a+tUhw8se/CbQpP1uEB9Ua6yAwv8wUZln+8ublAON6f71Ju7IskPz4vYbUDf6FuIN2u6u9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7330

PiBTdWJqZWN0OiBSRTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmlu
ZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcwMCBjbG9jaw0KPiA+IGJpbmRpbmdzDQo+ID4NCj4gPiBP
biAxMi8wOC8yMDI0IDEwOjIyLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPj4gU3ViamVjdDogUmU6
IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPiA+
PiBiaW5kaW5ncw0KPiA+ID4+DQo+ID4gPj4gT24gMTIvMDgvMjAyNCAwOToyNiwgUnlhbiBDaGVu
IHdyb3RlOg0KPiA+ID4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCAzLzRdIGR0LWJpbmRpbmdzOiBj
bG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPiA+Pj4+IGJpbmRpbmdzDQo+ID4gPj4+Pg0KPiA+
ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkdC1iaW5kaW5nczogY2xvY2s6IEFkZCBB
U1QyNzAwIGNsb2NrDQo+ID4gPj4+Pj4gYmluZGluZ3MNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IE9u
IDA5LzA4LzIwMjQgMDc6NDcsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+Pj4+Pj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMy80XSBkdC1iaW5kaW5nczogY2xvY2s6IEFkZCBBU1QyNzAwIGNsb2NrDQo+
ID4gPj4+Pj4+PiBiaW5kaW5ncw0KPiA+ID4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+IExlIDA4LzA4LzIw
MjQgw6AgMDk6NTksIFJ5YW4gQ2hlbiBhIMOpY3JpdCA6DQo+ID4gPj4+Pj4+Pj4gQWRkIGR0IGJp
bmRpbmdzIGZvciBBU1QyNzAwIGNsb2NrIGNvbnRyb2xsZXINCj4gPiA+Pj4+Pj4+Pg0KPiA+ID4+
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiA+ID4+Pj4+Pj4+IC0tLQ0KPiA+ID4+Pj4+Pj4+ICAgLi4uL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzcGVlZCxhc3QyNzAwLWNsay5oICAgIHwgMTc1DQo+ID4gPj4+Pj4+PiArKysrKysrKysrKysr
KysrKysNCj4gPiA+Pj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNzUgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4+Pj4+Pj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPj4+Pj4+Pj4gaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+ID4+Pj4+Pj4+DQo+ID4g
Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFz
dDI3MDAtY2xrLmgNCj4gPiA+Pj4+Pj4+PiBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNw
ZWVkLGFzdDI3MDAtY2xrLmgNCj4gPiA+Pj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
ID4+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmFjZjcyMzUyYzNlDQo+ID4gPj4+Pj4+Pj4g
LS0tIC9kZXYvbnVsbA0KPiA+ID4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xv
Y2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPiA+Pj4+Pj4+PiBAQCAtMCwwICsxLDE3NSBAQA0K
PiA+ID4+Pj4+Pj4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBP
UiBCU0QtMi1DbGF1c2UpDQo+ID4gPj4+Pj4+Pj4gKyovDQo+ID4gPj4+Pj4+Pj4gKy8qDQo+ID4g
Pj4+Pj4+Pj4gKyAqIERldmljZSBUcmVlIGJpbmRpbmcgY29uc3RhbnRzIGZvciBBU1QyNzAwIGNs
b2NrIGNvbnRyb2xsZXIuDQo+ID4gPj4+Pj4+Pj4gKyAqDQo+ID4gPj4+Pj4+Pj4gKyAqIENvcHly
aWdodCAoYykgMjAyNCBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQo+ID4gPj4+Pj4+Pj4gKyAqLw0K
PiA+ID4+Pj4+Pj4+ICsNCj4gPiA+Pj4+Pj4+PiArI2lmbmRlZiBfX0RUX0JJTkRJTkdTX0NMT0NL
X0FTVDI3MDBfSCAjZGVmaW5lDQo+ID4gPj4+Pj4+Pj4gK19fRFRfQklORElOR1NfQ0xPQ0tfQVNU
MjcwMF9IDQo+ID4gPj4+Pj4+Pj4gKw0KPiA+ID4+Pj4+Pj4+ICsvKiBTT0MwIGNsay1nYXRlICov
DQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9NQ0xLICgwKSAjZGVmaW5lDQo+
ID4gU0NVMF9DTEtfR0FURV9FQ0xLICgxKQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xL
X0dBVEVfMkRDTEsgICAgICAgICgyKQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfVkNMSyAoMykgI2RlZmluZQ0KPiBTQ1UwX0NMS19HQVRFX0JDTEsNCj4gPiAoNCkNCj4gPiA+
Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZHQTBDTEsgICAgICAoNSkNCj4gPiA+Pj4+
Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JFRkNMSyAgICAgICAoNikNCj4gPiA+Pj4+Pj4+
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1BPUlRCVVNCMkNMSyAoNykgI2RlZmluZQ0KPiA+ID4+
Pj4+IFNDVTBfQ0xLX0dBVEVfUlNWOA0KPiA+ID4+Pj4+Pj4+ICsoOCkNCj4gPiA+Pj4+Pj4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX1VIQ0lDTEsgICAgICAoOSkNCj4gPiA+Pj4+Pj4+PiArI2Rl
ZmluZSBTQ1UwX0NMS19HQVRFX1ZHQTFDTEsgICAgICAoMTApDQo+ID4gPj4+Pj4+Pj4gKyNkZWZp
bmUgU0NVMF9DTEtfR0FURV9ERFJQSFlDTEsgICAgKDExKQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfRTJNMENMSyAgICAgICgxMikNCj4gPiA+Pj4+Pj4+PiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX0hBQ0NMSyAgICAgICAoMTMpDQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NV
MF9DTEtfR0FURV9QT1JUQVVTQjJDTEsgKDE0KQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBf
Q0xLX0dBVEVfVUFSVDRDTEsgICAgICgxNSkNCj4gPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NM
S19HQVRFX1NMSUNMSyAgICAgICAoMTYpDQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtf
R0FURV9EQUNDTEsgICAgICAgKDE3KQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfRFAgICAoMTgpDQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9FMk0xQ0xL
ICAgICAgKDE5KQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfQ1JUMENMSyAg
ICAgICgyMCkNCj4gPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDFDTEsgICAg
ICAoMjEpDQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9WTENMSyAgICAgICAg
KDIyKQ0KPiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRUNEU0FDTEsgICAgICgy
MykNCj4gPiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JTQUNMSyAgICAgICAoMjQp
DQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SVkFTMENMSyAgICAgKDI1KQ0K
PiA+ID4+Pj4+Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVUZTQ0xLICAgICAgICgyNikNCj4g
PiA+Pj4+Pj4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0VNTUNDTEsgICAgICAoMjcpDQo+ID4g
Pj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SVkFTMUNMSyAgICAgKDI4KQ0KPiA+ID4+
Pj4+Pj4+ICsvKiByZXNlcnZlZCAyOSB+IDMxKi8NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IE5vLCB5
b3UgY2Fubm90IHJlc2VydmUgSURzLiBUaGV5IGFyZSBhbHdheXMgY29udGlub3VzLg0KPiA+ID4+
Pj4gSSB0aGluayBmb3IgbWlzLXVuZGVyc3Rvb2QuDQo+ID4gPj4+PiBJIHdpbGwgcmVtb3ZlIHRo
ZSBjb21tZW50Lg0KPiA+ID4+Pj4gQW5kIGtlZXAgaXQgaXMgY29udGludW91cy4gVGhhbmtzLg0K
PiA+ID4+Pj4+DQo+ID4gPj4+Pj4+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gIChTQ1Uw
X0NMS19HQVRFX1JWQVMxQ0xLICsNCj4gPiAxKQ0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gTm8sIG5v
dCBhIGJpbmRpbmcuDQo+ID4gPj4+Pg0KPiA+ID4+PiBJIHdpbGwgbW9kaWZ5IGJ5IGZvbGxvd2lu
Zy4NCj4gPiA+Pj4NCj4gPiA+Pj4gI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICAoMjgp
DQo+ID4gPj4+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBfQ0xLX0dBVEVf
UlZBUzFDTEsgKw0KPiAxKQ0KPiA+ID4+DQo+ID4gPj4gTm90aGluZyBjaGFuZ2VkLiBTdGlsbCBu
b3QgYSBiaW5kaW5nLiBXaHkgZG8geW91IHNlbmQgdGhlIHNhbWUgYW5kDQo+ID4gPj4gZXhwZWN0
IGRpZmZlcmVudCByZXN1bHQ/IERyb3AuDQo+ID4gPj4NCj4gPiA+PiBBZGRyZXNzIGZlZWRiYWNr
IHNlbnQgdG8geW91IGZyb20gcHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIHBhdGNoc2V0Lg0KPiA+
ID4+IFRoZXJlIHdhcyBuZXZlciBhIHJlcGx5Lg0KPiA+ID4gU29ycnksIG1pcy11bmRlcnN0b29k
Lg0KPiA+ID4gU2luY2UgeW91IHRoaW5rICIjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfTlVNIiBub3Qg
YSBiaW5kaW5nLg0KPiA+ID4gRG8geW91IG1lYW4gSSBzaG91bGQgI2RlZmluZSBTQ1UwX0NMS19H
QVRFX05VTSBpbiBjbGsgZHJpdmVyLCBub3QgaW4NCj4gPiBiaW5kaW5nIGhlYWRlciwgYW0gSSBy
aWdodD8NCj4gPg0KPiA+IFdoYXQgZGlkIEkgd3JpdGUgaW4gdGhlIGZpcnN0IEFzcGVlZCAyNzAw
IHBhdGNoPyBTbyB5b3UgYXJlIG5vdCBnb2luZw0KPiA+IHRvIHJlc3BvbmQgdGhlcmU/IEFyZSB5
b3UgZ29pbmcgdG8gaW1wbGVtZW50IGVudGlyZSBmZWVkYmFjayByZWNlaXZlZA0KPiA+IGluIHRo
ZSBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaHNldD8NCj4gDQo+IEFwb2xvZ2l6ZSBhZ2Fpbiwg
SSBkbyB0aGUgaW50ZXJuYWwgZGlzY3Vzc2lvbiwgaXQgc2hvdWxkIG5vdCBzZW5kICJJbnRyb2R1
Y2UNCj4gQVNQRUVEIEFTVDI3WFggQk1DIFNvQyIgc2VyaWVzIHBhdGNoLiBpdCBzaG91bGQgYmUg
c2VwYXJhdGUgc2VyaWVzIHBhdGNoLg0KPiBJdCBzaG91bGQgYmUgYml0ZSBieSBiaXRlLCBleGFt
cGxlIGNsayBkcml2ZXIgcGF0Y2hlcywgcGxhdGZvcm0gcGF0Y2hlcywNCj4gaW50ZXJydXB0IHBh
dGNoZXMuDQo+IFNvIEkgYW0gbm90IGdvaW5nIHRvIHJlc3BvbnNlIHRoZXJlLCBwcmVmZXIgaGVy
ZS4NCj4gDQo+IFNvIEkgc3RpbGwgbm90IHVuZGVyc3Rvb2QgeW91ciBwb2ludCAibm90IGEgYmlu
ZGluZyIgaXMgfg0KPiANCj4gDQpJIHJldmlldyB5b3VyIHBvaW50IG9uIA0KaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWNsay9wYXRjaC8yMDI0MDcyNjExMDM1NS4y
MTgxNTYzLTMta2V2aW5fY2hlbkBhc3BlZWR0ZWNoLmNvbS8NCg0KRG8geW91IG1lYW4gSSBzaG91
bGQgbm90IGJlIGdhdGUgbmFtaW5nIGhlcmUsIGFsbCBzaG91bGQgYmUgY2xrLiANCkV4YW1wbGUg
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9SVkFTMUNMSyAtPiArI2RlZmluZSBTQ1UwX0NMS19SVkFT
MSBhbSBJIHJpZ2h0Pw0KDQo+IA0KPiA+DQo+ID4gRHJvcCBmcm9tIHRoZSBoZWFkZXIuIEkgYW0g
bm90IHNheWluZyB5b3UgbmVlZCB0byBkZWZpbmUgaXQgaW4gdGhlDQo+ID4gZHJpdmVyLCBiZWNh
dXNlIG1heWJlIGl0IGlzIHBvaW50bGVzcyBhbnl3YXkuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMs
DQo+ID4gS3J6eXN6dG9mDQoNCg==

