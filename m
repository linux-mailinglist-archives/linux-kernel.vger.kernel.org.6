Return-Path: <linux-kernel+bounces-291504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5026956366
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0492818E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349C14C58C;
	Mon, 19 Aug 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="j1mbqJ1N"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020094.outbound.protection.outlook.com [52.101.128.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB46171CD;
	Mon, 19 Aug 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724047047; cv=fail; b=Ni7QhY4tMJlfzznYDMctRNs6daAD43WGGVYIzqEfyDtBTdcwird1RBYT9ox9nePJ+ukU6qF654Ewh8nqMgvMmvfPgq6khtj4WtESC2qEL5cYr9vDXhP1fgxoQ01+5JVvnZq+6HPBijbagqZErojleFqCQ/dqIb+eOxoC31NVpY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724047047; c=relaxed/simple;
	bh=bzUuI2TzQpX0vaDMkDjP+3Xfq7K1OY76VDogwoq0P60=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Arz7UTV8M62TIky24LrsMz0j8XBIIkRoeKAchwJjh/r4/WJJ/ZFKDhaZGZLN66soZHEBY3M83OKPGB8Lfd2fVuNg1WRfSFZQ8R2sjdB2rPy9YAbrbf7r6RqHWIl520jhfS6asChxj0cFEiPvhwYrncIAC8++gVfzR7evqc0l89I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=j1mbqJ1N; arc=fail smtp.client-ip=52.101.128.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrHjsBSLJP9Up2e4iVf5Bm6/1/ElcMarfQJ92yJjS9XUXnbeJjZ9Wn0NfVcxq7DTjtKpk8jSDhxJsqs8D3hvZQ558SRso0kPyceeZdmwhQI3sIIfrm8RuBilsxeGoeAc4YbTWQ6FjXGg5uL29ck2vhAyN0meR+9FD0/zkCFDZrc24bi7dAONbwQMA7rNqNdTN4mU7z9MI+b8dVOpmppcx4Iyul2fVCIeKXwgnQ1hEUr81R986/82yZ31ZK9UsHsADVzKhBnRmwJ9C9Ft7CSJyrmWfWSc3NglNT/2pUHerAvS3b06t+tUBywQEChgS+irZ1c6MVPZzyShbVHnzDXGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzUuI2TzQpX0vaDMkDjP+3Xfq7K1OY76VDogwoq0P60=;
 b=vrPDIICm4hnQhrZIoRgulMwyLbwJw5kT9t7bO1i2t/IcAyxH5eTqkDQKfJgZee+2DZbPohsk0VsIiTcMDovYunNYIWfUPuQIJduxbYOh0e7PqGELXwSIpk21B0NyWhm/wkrz3nRi6ZIfIO32RZ91FrUJiKxo/GNz+oXZi8TzSPL3/ACmonruujPxImxIph4AVg7Vl9DbItISmk1lAOIu0Dhxs7p1TZFGnG2OYQRxuUsOnLX1h0cppOYoAYgRyv7kMcyGRHwe8M2WmNcr10NcsyI+mQc9aSjk+6odO524sKwskMyw/mJvn+/PyGDejAiQbL0dzZgNdFYlODtZwsjULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzUuI2TzQpX0vaDMkDjP+3Xfq7K1OY76VDogwoq0P60=;
 b=j1mbqJ1NAHZon7TsRm/D6e5ZduLm/ZCjjoZeBKArIzLpSO3G4TDUg0NW8ry3YE9H68s9EBMRuRtli98J+zg7+mADOqSfjR+qn74EyzdV+ZyZuboQc9S7NPuBitt0TSXj246ihos1QNdDZl/7sXQESy3Ey8rFPpkOCqUP81Lh4Lg4WoTn5CwowUAJAqLA27G6SZ4rsGWkvsASY2epJSPa309sPrgHN8aX6r0m8yxH8u0FpOWCXxR9n7pJrKzL7Fkb6K7QFHJxPy4Om6rMi8H3/kIn6jFQOhseDgxrk4As34KbZAKY1ElTB9WhADB0NSWsCpiAY0Rq1GgAVmO4JsPSGg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5750.apcprd06.prod.outlook.com (2603:1096:820:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 05:57:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:57:17 +0000
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
Subject: RE: [PATCH 4/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 4/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index: AQHa6Wjwl4xNR6r8FUS4yGT/m49yXrIdJasAgBEAqXA=
Date: Mon, 19 Aug 2024 05:57:17 +0000
Message-ID:
 <OS8PR06MB7541B310B81108B9A801AEFEF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-5-ryan_chen@aspeedtech.com>
 <b089c9e5-8640-47f3-a6a3-8919b610f49d@kernel.org>
In-Reply-To: <b089c9e5-8640-47f3-a6a3-8919b610f49d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5750:EE_
x-ms-office365-filtering-correlation-id: 13e34b20-cfb7-47c2-c447-08dcc013c86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWRITUpTL1Q5RDZzbUQxSUdrOFRObHA1UmhRUHVCWVJVK1NmRnhxUUYrbjM5?=
 =?utf-8?B?RGFwZTd3QmJWSkRQdm5jSzd0NUxBdE5Fb0Z1Z2dBVHVzVHptcnVLZlNRaHNh?=
 =?utf-8?B?cmc1RFA1ZWd1YU1RdlFSWjFpVklrS2VCcDBHRFJXaTBsT3IrM2hrRnRnejkv?=
 =?utf-8?B?Z3FyOXhMWFJGWXNhUnZlWnJ5WGRvRG9URkdZS214MVBodHA5Y0VqWWR3cDkv?=
 =?utf-8?B?MythWUZSY25nck1QTW4rbnZrNHRzc0ZhdW1UVGpsM0krdENITmdkcVd0N2o5?=
 =?utf-8?B?WFd4QnJ1R0xzdXBNcWRzZTdQYnB3STk3U3VuT3puNVZjZ3dTRDlDeUMwODln?=
 =?utf-8?B?dkY4TFhVeHI1T3k4STZVVm1uMW0rVjJuQ3FhSU1rMTVHb0JPS1FReEpTYTN0?=
 =?utf-8?B?WWRmWjZWY3I5b1ZCM2IrMStsMmpLajc4UlpBZXlmNjZTeUxhY3R5Y2JUVHlv?=
 =?utf-8?B?aDlIZktqeTZFZ0dWREIzSFdDNDN1K1J1dlA4ckVOSnk1cmhuWXUrMlBVYUs1?=
 =?utf-8?B?ZEFRSCtBWG5VdW5LNTlJWDBvKytKa3poUllSdnhEbUtKL21tcFNwVTJXVW1m?=
 =?utf-8?B?eGNDZE5peUtjVnMvMW9kbTRRR3NEU3BxanNZN2lUaHdiVEIvWG85SC9XU2FI?=
 =?utf-8?B?Y1FSUmViQ2xmZjcySEpMbHZMd2Npb1FrWkk0MVVaUkYzMmQ0eGFvVGdSYUgx?=
 =?utf-8?B?T014b2t5QytVT2pRNjhrRGZuVnJCTk5HbTVKMDlpbUJkUWNxUHB0ai9jRWxE?=
 =?utf-8?B?WDNYOFNJL013QmR0bVdsQm5HVnpRQjZkN1Q4ZEUyL0lGSEVxREh0Y0oyVkc2?=
 =?utf-8?B?Tkc2LzJjbUxZSC8rY3FjSk9XZGF1M295TUFrc1VQWG5pYy8vMzR3eEtScnFD?=
 =?utf-8?B?empicDdTWmFnRlh5U3lwc1k0ZTgzUFVqWk8wWGhkQzQvaDYvNnZXalJjRHUx?=
 =?utf-8?B?Mm41bUYxZkliY0U3bUl4K29SQU9YM0ZmRDhkV0dzYjhLV25QaldMRDdYY21Z?=
 =?utf-8?B?ZDlVRU8wM0pqcHdHaGIraTlPUG9RNFZ2VFVsck1CTHJjMVdiNGM2WSs2b2d4?=
 =?utf-8?B?ejhEN1NYd3l5ZHhuWnplbTJVTHFYZ203OW5oZ0VzeU1BZE9kdkR1Z3JMa1k3?=
 =?utf-8?B?Smx4bjR1dEk1NnQ0SVpsTFYzRW4rdG9YRHNiazBBd0hqcjAzbXJuT211eUdp?=
 =?utf-8?B?K3RYWEpGNmxoT0FsMzNnNU9NaDAzWmQ0RURNSFRCRW5iOE5MMWw3NUltbFk5?=
 =?utf-8?B?d3Q4Y0lQUVJQN0tKMk9pNGZQdkdBZEl4SmRmc0Q3RlVDOTA0WVgrbVNnMElt?=
 =?utf-8?B?cGVmbFRuRzhsWGRsNkRVQTdsR0NJakJzUm5oM0huL3poUzVnYXVjM3liTE9Q?=
 =?utf-8?B?Z1RsU2pMSGg1WjlmZzMrMzVRYi9BNWwzRnNZTEFhM1l3RzdDajJETjAwTzlu?=
 =?utf-8?B?ZFJpeGV6TTluWFNtM2pMa09YZ0J4cGpNTC84clNIZkNVakNSZTQ5TkduTmZM?=
 =?utf-8?B?Z3lMVnhGdDROTVR6NU94cXovSVJ6dE0zaDhvTGJxMnhFbElLdmRsN1lwaytC?=
 =?utf-8?B?TlJzTkV1bXZ4TXFNZmdIbzh6aWJZV1pnTnRkbU1SQXlpVllnMzY1T3lXZVVX?=
 =?utf-8?B?djE2T3RjY21CTEtRd1lOb0NzRUlzN2s1d240b3NlL0U4ZXV3WjlOeGxBUHla?=
 =?utf-8?B?dzZVT01VZkhlaUJhK3ArWGdPNGcvc3hUdUtFZ2k4MXVaQzY3OGJFNi81ZWQ1?=
 =?utf-8?B?QXVJa1lkMFRnYmYvRXNoczNJQ1ZoV0dBOVlyUUJnVXo1VFcvQTlaQk82TEpI?=
 =?utf-8?B?WG51K1ZoVXAyUWJ1enZuY1VyR29zaXliMWxZK1ZocHl6dnA5YzU1M2gvZ1Vk?=
 =?utf-8?B?Tnh5Ylk1N1IvckNKTzcycTE2L01LM2E4b1RpdHdEVGcwa0FvYjNkcTBYZjB1?=
 =?utf-8?Q?DfOUR9JdCY8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFBUSk9XOHNoK3VwSlJ6OHBGNXZZYTdaV3ZOMS9RSStmajN4bGFMOVc1NUV0?=
 =?utf-8?B?cVFDbGROTllwTFNadjR4czIrRHFQZ3p6MmllakNocFBLN29OVGc5QTVuY3Vo?=
 =?utf-8?B?Tjc2KzhXdlBYSVVSRStTdGlwbnEyanVUUTl4YjZ0RTdtVmJzZ3EzRDVXUStE?=
 =?utf-8?B?MkVjUDl6MWhsMkw3M0JwdVB2Mk11cDJoejJWODBQZ3BwQlhGVStwczJPTVha?=
 =?utf-8?B?dmlzY3Y3RlIwMU4zWllIYVBtUDd2NndtS1FJTWVyck1pSm13TEhZaU9PMCtr?=
 =?utf-8?B?VCs5S2ROc0FZYkl5b0J2a2ZhZmtWa1Azalk1Z2JlL2wxY3JhNVJWZC9ibllN?=
 =?utf-8?B?dGswUUZwdC9obHMwU09vazlKakFhbHRwc1R2bllkZCtnUzZGV1pMbDZESVo1?=
 =?utf-8?B?R2MyK2I2cytUOXVLNFoyOC9UVWdoanpJd1NCWDNDNDRpTVVjNGxuckxjT0pK?=
 =?utf-8?B?NzQya0VYdmJsZWlYMjM2Vk9seG9NdEwybTZaV0lLdzVnK0o1bS9QcDd2Ti9u?=
 =?utf-8?B?Y096QS9WcnpqNmtxZEVXSlVIOUlsaHQ1akt3VEcvV0FjdXBSRFFyb1ZpdVVu?=
 =?utf-8?B?UlRxNjIyTzJVMUV4by82cE9BdGYvU1F5NDR3V2lqZ2lMY2drRVlkeDhmSEpL?=
 =?utf-8?B?b3Q2akVKQkV6a0FjZ3R1b0NTK1dFMFhQTXdkUkk3cy9sSEV0ZGFrYTNKVEdy?=
 =?utf-8?B?dG9GQzAvTG84eWNWbk1GSDllSjBhdEQ3dTZ4UHh6VlJaeGtUZDNFMDhraFA4?=
 =?utf-8?B?VVhqRzV5R3dRZXIyaWtMMmhRaDFocEZNbm1VSzYxZjgxK3V2RHFuNzN0aU0r?=
 =?utf-8?B?ektFZ0NVeS9iOGt0UGhSWm9ZVHROdlNpUmlJei9ZRzhxRmozeW95Q25xaGtx?=
 =?utf-8?B?a3E5amRvd05hL0JDeGRFeEJxRlpOeFFYOTBDRWt0Uk1zaDhVbGR0N1VUWFdq?=
 =?utf-8?B?b0QzRGJHM1BJZWVNbTFCd0dPd3NmWHZFUTBnSFhacGN2VmlhNHVhQXlGd2N6?=
 =?utf-8?B?cXpDcGNjeW1VQ2I5TjB2dVdmanFGMnY2SmJCT3NUbHdyZGZ3S0xNZWtrSFpJ?=
 =?utf-8?B?bVhhSHNNRVZ4Y082UGlUMW5nRGhOZ3lOaE9FV0ZzS3ZMYWdtOXdla0VWQTJD?=
 =?utf-8?B?K1RJRWRhVXVPbjRWcUtaSmo1T1V0RUd5VHFPVnNlYkY4aGJvSnc0NTU4WTlX?=
 =?utf-8?B?MXcvYThvOWhheXJ5RGQySjRyVmtrR1B4aHE3ZU5GTi9EMldna3ZXdFdSTDA5?=
 =?utf-8?B?VEg0YXAzR3VsMFMzVXlWOVZ0cGVxajVpaFFYVlpoT2tVTk8vNUhqWkdNd2ts?=
 =?utf-8?B?QWUrWTh1VGdwUWJqbml0ekZYT0FYa0l5NTc2ZkVkNEJwQlJnNC9BV0N5eVdY?=
 =?utf-8?B?N2FqMlJBSDJuRlRHY1dDS0M5c1k0ZFlMbzJOTHBNeDhqeEoxTDRYb0hieC9m?=
 =?utf-8?B?NEswdkU2ZDBqV2NHUUxuZi9va1FHN2NoYnlRSWpEVWhRTlp4MExwdTBWVEtP?=
 =?utf-8?B?M2tRa09NSHo0bmpRWmxaekQ1dXFtTjZnekNOMUR2Z3ZEWlNFVWgxVUxPN2xv?=
 =?utf-8?B?OGliZmNwNFByeW5NaWVoMkxBTGdtUWgrLzVJMVFWaWcxVUY5Y1dRQU04U255?=
 =?utf-8?B?S3ZtTFhYaDZkN1dxT2JzMHpWMkthQTNxYWsvWCtPRlVJMU5vckd3elh0VFA4?=
 =?utf-8?B?dE5IOGQyUlp5MEx3UzlVd25uZlpUL0NDZTR1dTIxQXIzU01wd2Z1Q250M05l?=
 =?utf-8?B?dFBZYWxhaG5HWXZNR1F6NGtVcUYvbkFQVnlGWHZqMzVoYnpzaW1JZS9JUzU2?=
 =?utf-8?B?ZlZqMzAvQVkxZlJqeVRNbU55b3pvVXB3Y2xIV3FReXQySTlMMHgvbFN6Q3JC?=
 =?utf-8?B?b0d4YUpZYU95VzVtNm03RnZuUEQ1UzYwRmo3SHpxV2JScmNtYkpSR3drS2VN?=
 =?utf-8?B?NTZ4V2ZEK0dUUzFMSVhHZ3dqMDA2Q1hWN2FOTitGdVNrSGMxcUNBRDRxWVdt?=
 =?utf-8?B?ZmNoZ0o0UjV0SjRxVVY3Z2toUVZUSXAvVHFXR0FZNi9COXNKcy90aXM0SGpC?=
 =?utf-8?B?MGthZTM2THVQaWsvcVRiNjZHWGg0c2hzY2VJR3NWTWk4Q2d6OWllWFo5UXk4?=
 =?utf-8?Q?CMowqWiQMwU904UJizdLWFSiv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e34b20-cfb7-47c2-c447-08dcc013c86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 05:57:17.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBHpY6oLibPsquAJyfTjtzGMov/FuDfz1ulSpJHTu5vkWVg8x9cc+h/Ol/4Q/taF0BN1uuuvZ7xDYdQRpFb5yoCFIfCtwGmwyN7UvbHcwws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5750

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMDgvMDgvMjAyNCAwOTo1OSwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+IEFkZCBkdCBiaW5kaW5ncyBmb3IgQVNUMjcwMCBjbG9jayBjb250cm9sbGVyDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gDQo+IE5BSywgdGhhdCdzIHdyb25nIG9uIHNvIG1hbnkgbGV2ZWxzLiBUaGVyZSBhcmUg
bm8gYmluZGluZ3MgaGVyZSENCj4gDQo+IFlvdSBpZ25vcmVkIHByZXZpb3VzIGZlZWRiYWNrIGdp
dmVuIHRvIEFzc3BlZC4NCg0KV2lsbCBtb2RpZnkgc3ViamVjdCB0byAiY2xrOiBhc3BlZWQ6IGFk
ZCBhc3QyNzAwIGNsayBkcml2ZXIiDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQo=

