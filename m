Return-Path: <linux-kernel+bounces-288950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710F95408F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90628AA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E56784A35;
	Fri, 16 Aug 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Pi3v++XP"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D3155A21;
	Fri, 16 Aug 2024 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781290; cv=fail; b=or6D0YB1PfjJ21xoD2mua29DyTqYhBhuInL7D+oQXdPDnmMqEMNJQTpgNUPnzjObU8ROYvoL0n6BRZUJEfYGxcbRZNnOYHlz5zkU1BVkUsf0JTrQq2yejHmUap+QnpnUkBMPrDJ6fl+ee/PgMDGSMW3F+lj6zdT4vUnlnBMB12g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781290; c=relaxed/simple;
	bh=gmkdH7t07T64kymHPw35Yud7lXAKBTi16Evq7KB3gcI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=leuZ2HMEURjvEbaUsl3HLgt+VOuoh71LddjXBQZynL5z+NFK7YUnqNLLloAg0xlHGm6duRuoLv09fM+XU4xzVDijDiEBqZcuqcPpD0g7voh86J/6T3Ea3qUO7z4IOrscquAsd/HmQB6vY6SDf3GnmT/GR6fUOVqYE96nXBfX8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Pi3v++XP; arc=fail smtp.client-ip=40.107.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLzsAi0/UnjyzOJhYQcK2RGAIrsOQqzP0OEfdBfQMb1P1q3nCjH2rv4dnf2gfN05TKXAV6XPAg8f36THECPBOcZaTYzNUayhEu/TSzrnOqugjuq10qKC5qV5ZY067b+aiqyMum9TGozrwYWQWcHODfmIkyFG8n3yO3efBv/itKIKvSXqkrAHCgg+p6bGqYAm139NPwJxx7XUkTPd87nt437JWDDqut0Py2TQ8Oz4weMRJaV2qh5XEOFW9DCcrXPYPorwohBM7f8UFmuLKYWMSuOb3klEezh8vjhNqhOd/Xh3HseBIQ6MGGBz7OlJTIrufe1Ixpcd2ZGwMX5pIj7QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmkdH7t07T64kymHPw35Yud7lXAKBTi16Evq7KB3gcI=;
 b=NSSsXvdQgjxkgN/KMo4YdmfUp5tz6auaUxEpbRC0O9uK7pHvgc8RbNjbrIgHfT1+E1c19Hm25hPabK/oIkFds7lPeJV2X2qNaE1+cPxiJJCxQ9cTE8SNK5/K0eomX/5XZzcWq9XZ4pHeqwhT5BxAEZsAfk0mCxDaxYPa4farZS2oHbucQCUqArusxgjooF5xFXgpRIvFP2uFU0s/CRcudc9wUIKSHl82WJotQ4HLUgLkfMF2HpIXc5QKgMzleoSQl5XNQbqH/jImml2CK/nVk9AQePXJoshRLtibwW1jGR/tMWp9j7/Xq7qxKNkRrtawQllS/24D9XWYxkuhfnm7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmkdH7t07T64kymHPw35Yud7lXAKBTi16Evq7KB3gcI=;
 b=Pi3v++XP05RS6try80i7EzaLgkXVu+REslWbSDKA7/U1/vaPhvG33ikevtaiJ/d9A/bhsU+hJPDcGPi3RBBEKW8slyD1vf0mTjvnW/awq/kYLUS+TTlWG1wT9MgjssewQRpubPs0uBAOq1rJyhUElEO0xwBjq+I29ngO/IRHMXhAxc1hoSUB7WwGTwHdvdXjHH8wcoHmozXZ/X5qdRjKnkgXLoym+Zyxr7GoyKhZ1JDlSZz7CcSkCRNSNsCj8uvmT2evpzOwa5CMsVccDQWYam6ExQgB5+e7/yLtkPEzZZ9yn1NZNkbiRkD1X7piGPaPHM29iog6MPlIHexjdHjy+A==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:08:05 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:08:05 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb
 compatible string
Thread-Topic: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add
 aspeed,ast2700-evb compatible string
Thread-Index: AQHa30uNq/e/f5bPiEuBrDgfXf+vPLII244AgCBsrWA=
Date: Fri, 16 Aug 2024 04:08:05 +0000
Message-ID:
 <PSAPR06MB4949F7F617DB4A371567EB4789812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
 <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
In-Reply-To: <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: fc9ae240-f3bf-4914-6fc2-08dcbda90763
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEhyb05wVGdvWkg5b1ZVK0I5elpoUzNqcktMM09zS21zWnN1NU92c2g2bGEw?=
 =?utf-8?B?VnkrRkhJS0pJMmFBYzV5S2xmTkNoSkx3ZHJVRCt1dkxFZGdHSVZNZk9BbDY3?=
 =?utf-8?B?Ny83cDlFb2wzMHpqaXF4OVZWT2VMSEJIOUNMWTZSaVo2NFRwWVM5bkpOa2Nx?=
 =?utf-8?B?VS9jUWIrWHBBdFlwMVNjaVl6NlR6UmUxWHkwTDVtVDN6VWJEL292dFkwUDVF?=
 =?utf-8?B?WDB1WDUrOTJmQUVzcWkvc1UvOE1wTFJjbHMva3AxcXdCNDhvbEhuM3l0YXl6?=
 =?utf-8?B?TFAzV09vajNPTEVWYWtTTVM1TXV4WUNGS2M1VTNCNEVxeEdPaDFjTnlRdWtS?=
 =?utf-8?B?VXdMMkFxZForM0xlRkV2eVFsMnc5YjBLbnQ1anRna2oxdjczYk0rQ3FYMDlS?=
 =?utf-8?B?SythcEZ0ekJCdTVlV1pqMk5vUnBiT3FNOVJqd1dnczZMazgzNTgzNXd0bkJJ?=
 =?utf-8?B?a1pyUTJJZFRhYzc2TGdSN2RwSmVDNHZlazZRbzRYZXRoZXp0RGpFVklVZGFY?=
 =?utf-8?B?ZzYzY2FXZHV3bllNRWxOcnRETTJOUjdDZU9lclRtWXJjOEJwb3d1QzRXdVd6?=
 =?utf-8?B?R21kWFRWT3doenArT0FsekI4OGVrSXVZcnNvTlphOCt5Tm5mTmI4bVdoWjFR?=
 =?utf-8?B?OHY2M0lrUDRlNVBsT1UrTm5SZGdVcXhPc3lxdk1hMHY1d0NtdzRQZi9iT09k?=
 =?utf-8?B?SWxRWjRhZk9VdEJlTzdZbVBXYkIxWkZ2dllRUUszaDlxS1F2Q3d0c0ZHQm02?=
 =?utf-8?B?WHFrU1hlQTFGaUZZRnhDOWduT05HaW5TUlk2THVWN0RCVkpaVmRxb1JPUHY1?=
 =?utf-8?B?eHNUMUYrSjVRdU5nQUNia1IyNUkvd21iQ3FpbTRUeHZmc1dXMmtBWHQ2bFRG?=
 =?utf-8?B?MTVlQkx5UDN1N3FtbE9sSjNJQUd3MitTTzdFWEZLOEFYakkxRTBnZktQbmhB?=
 =?utf-8?B?Nk9CMjRYOFdScmN5cnBidWM5b0RIL3doMjhZdk9reUdhd3A5VWtJQ0hxRTg0?=
 =?utf-8?B?UEJvMWU0ZGpmRDlmMHdPSnFuKzJQZUt2TGZXZElNSjFVZ3UwWGhZanJOak50?=
 =?utf-8?B?VXFZK3Y4N1FzcFkxbDMwdjNTVkpkRmt6Zm43NEJVUlpES2JEUkxiNUFjZ2kx?=
 =?utf-8?B?VXNiK3ZZaTcxTjFYUWNBMVdCeVRpcEJSYnV5eHFPL0pLUXJMd0o4Q2I3d212?=
 =?utf-8?B?dlY1RlV1ekJSakpUclV6U0dpUGp5WWxtRXpVVnY3cmM0NWc0MUJGOVgrTm1R?=
 =?utf-8?B?K0pVK29Hc0RLakdaWm9kUjYxamdoMSs5WEQ5UmxUTFZRYlFQMlhNSTZwOUlJ?=
 =?utf-8?B?aFJIc3VTaVFZdE9NRWZxbDJqL3Y0a2NaRmc1eDBNZTA2Tzd4azhVU0FKVUps?=
 =?utf-8?B?eTNJOFJiV3hEV0h4TDAxNWxldm9VT2dCMVVDYVlCVVgwMWtYYUI0L2tLYlN1?=
 =?utf-8?B?eC9zUFBxRStueXF0aysrazI5YUliUFRwektIdExDQkc3Um1JekM4Zms5TFNE?=
 =?utf-8?B?dHJEWGJuYnVPVkQreWJ4Vk10aGhJakdvcm5RWDJKYmZhSW9UNHZvd2FXeVJp?=
 =?utf-8?B?cnJubmRjOVdUQmVDeExxRzVaVlB1c1lpVTBNOHg5SkJha1ljV3dBN2lRWEp3?=
 =?utf-8?B?cEJNdTZKUHhQd0RmUGJBS09xaVZPV3lkOHN0TC9JQ2ZGVHpqRFlnSVZTcGNC?=
 =?utf-8?B?V2wzUmF3RytpQ1ZjNWVYQUFzbUVJZVFHRzBrMVBoaEQxM202TUN6V3pTMzRH?=
 =?utf-8?B?MU84aTNGM1B3a1hzbUtJU05pM3dQYkVHSzd0ZFNqWDV1WmdHUGJSeXdTUEN3?=
 =?utf-8?B?NVd3bE9KVWJqNWlZdGRHYUV5dmhERDhIekYrRzFDcGtvZHF2S2NWMC9WYlBl?=
 =?utf-8?B?aGpBdXEwTm1ET0ZhWm1lb0V6Vlc5MXhocTJiQmpOZzg3ZDNWNWV4RGo4MmNV?=
 =?utf-8?Q?a5azIffG93o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1JWWWR1M0lXVGhiWWw1RzVZUlZkbmVxT1J3WFp4V1k1cUMvOVpoNW5hWFU0?=
 =?utf-8?B?VjVKc1dTVkJtQzVYbEpsY3RwaGRLRXpwRnJJTVhjQzZUemhxZnlTdHJ3bDBa?=
 =?utf-8?B?bnVGdHF2VEE5RStrcWdlTjEzUUFMQUlzOVp6UGhZMjJXbHZyQXAyK08yYldl?=
 =?utf-8?B?TkNUZ0dZN1B1OGRWZ1hQK3FtVXRxMVprTEI2WE5IRXM1U3pTbUwzTUxrMnVs?=
 =?utf-8?B?WUxhZjY4TlpBUmNVK3ZaL2hOOStwaEJhS0k5Szd1T3V5THFyR0x2TkZTQUVu?=
 =?utf-8?B?VEVrdVYrMDZsRDQ1bHA5cHZ6Rkl6aWF6dW1rSEU5VXRvNm1SNU5wKzI5WFhU?=
 =?utf-8?B?SmtadDJvRlV5UkVJRW5HTzlsRkZkUE03b2JyNGJzU2xsTDZ3RnZ1b3h2VUg2?=
 =?utf-8?B?MXVHcVlHeHFzRFZhci8rT1VMa1hqUzIxTlZZN3VzZlIxY2VBNjQ5UEx0MkdZ?=
 =?utf-8?B?cmFESUZicFkrcVBSQjNhWmdnd3RxUXB5RkN4d1Brd1RlYkdlTS9WNWJyYUhi?=
 =?utf-8?B?K3RPSlRpQkpYNEdJdUhybUdCYTA0TG5HV2h3d1puaHorVVBrNGxLdlFmUlVJ?=
 =?utf-8?B?akVsRVdmdjFEb2V4eU1OZVg1UXFwOHFMZGdxaC9qaGZNSGZpWjNmWDZ4U3hs?=
 =?utf-8?B?aFJYV204SjFjeW8vR3ljVXVKR0g1NHV6SXpoWXJ6RzRzWE96eTVPQkh4bVhR?=
 =?utf-8?B?bHRVZUUwUUpGdzJEV3puTmxFMnRPbGh3VWx5dnQxNy9CaTRIVUpNN0YrMVRv?=
 =?utf-8?B?WjZRcGxKek9tODRST3h5L0JLVnpLRFR2VCtpd094bFE0cFJFdHhkQ29aSkhw?=
 =?utf-8?B?ckRGN1Vrb0owZ01hK0RXdGxXZE02dlNXTXd3cXNtSDAvMzAxM3RrSGhNcWsz?=
 =?utf-8?B?N2ZUeE9YZGMxdWRsTXV4ajlHNC9wSXNiYkpmbU9RSVBUTDArc2pwM0FCbWtj?=
 =?utf-8?B?Vi90ZHlSalZCZXJIS0E3bE5EdWZYRjVabnNRcDdURitGYVN5YThMenU3VnlN?=
 =?utf-8?B?bEhYRlFPdjVCTnRqSjh2N1B1Q0h3eEpqalI3TFRaYjYrVmIzUm1kZTBPRVhO?=
 =?utf-8?B?anRVZDY1ODNzS0paRC9wZHRJd1d3bTVRcCtBLzRheDBaZHJDazdxWEVNNURL?=
 =?utf-8?B?aW5aaDE4NGFCUUIzWkU1TGd2SC9mWWg5SFNiSm15cy9GTmc2UWRaMmRtTm40?=
 =?utf-8?B?T0IrN0N5RktySUxEcEE2emNrelNUK3lUK2VqY0pEeUhJbmdDZ29KRFgwZHdi?=
 =?utf-8?B?NGhHOFNleTcwTkJEcVBWL3VFT0krL3dtR2FFbkdOZDJCaTZSNG0xczgraTds?=
 =?utf-8?B?emkranlIZ2lpc2VaTFpqUzZnalVBclFEV2tuU2w1ODRWQUp5RVg1aWRBMHEv?=
 =?utf-8?B?cEtFUDlBLzBVL1FsTmVYcTFHVkNzOWp2QVZxYU9zbkYxNGRYYWRqcjI3dGsv?=
 =?utf-8?B?MDlXbnRiY1g0Nmg2WjU2czQ3bVliWnFaK2lJL1IwYmN2eEdtSG9Zb0R1cVdo?=
 =?utf-8?B?SS9TbGFVL0IyZ2tzVk9SWTdNZGRzQ3o3TlNYbFJLa09QcTVpMDN2c3U2d3ZQ?=
 =?utf-8?B?blVPSGlxd1hyM3R6VTRndkM5TWdDcmZ2ZFBTOHRzNmhtUTUzdE4wOEdrRXkx?=
 =?utf-8?B?N0FOK2NpczcxVDBpVDFwNE5wSDd4anNFemFqTngyM2dPeXQzQzJRYnNPaTdl?=
 =?utf-8?B?bDNTeGM3c3RFeC82R0dOSEJSN2ZjN1JDUmxBWm9HaDh1VW5CeENRK2svbmRM?=
 =?utf-8?B?NGdzSEh4SmJnKzliMEcvVHlrMnZ1ZThLWHo1elRLbks5emVsQXpHTnZLM2JN?=
 =?utf-8?B?aGpWK0U2VVNYNzk2WGtPSmVEN0dDTXRPdlpibTdnRVhDWklmVW9SRFhtWjc5?=
 =?utf-8?B?b0IvM0UyalVwTjMxSmlZN2plalNqc2ZHQmpvek1EOFQ1QjU3VVpsMHdnNUR3?=
 =?utf-8?B?NmNNVnU2R0c1b1puYU4zaWFrUG9YeUFJTGJYRS8vNlhaS3VqbjFVRHJqUkVi?=
 =?utf-8?B?UjNrOVh2WmtDajBBTTJRYVN4di9SQmVINXRWL1EyUHZ4d09tenFiUnRhY3ZF?=
 =?utf-8?B?YkI0TkxGSWV3WWNERHZ2djdRVGJwbzcxMXUxMEx0djVlaXlKT0JZdm9DRGlm?=
 =?utf-8?Q?8TJM2tjMfu/baqslrFDmlh2lp?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ae240-f3bf-4914-6fc2-08dcbda90763
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:08:05.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnBzQBBjn170O5aJlvvZRTwKw9y6cGy1t/eS0221SdCx1BKvD5YQeSfvN6LwwsI6fBSMPQSYY0TfpwNmRJf0PV8Y6hODRm6e5OuCaLooj+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2FzcGVlZC9hc3BlZWQueWFtbCB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FzcGVlZC9hc3BlZWQueWFtbA0KPiA+IGluZGV4
IDcxYzMxYzA4YThhZC4uYjIxNTUxODE3ZjQ0IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hc3BlZWQvYXNwZWVkLnlhbWwN
Cj4gPiBAQCAtOTksNCArOTksOSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0g
dWZpc3BhY2UsbmNwbGl0ZS1ibWMNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGFzcGVlZCxhc3Qy
NjAwDQo+ID4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogQVNUMjcwMCBiYXNlZCBib2FyZHMN
Cj4gPiArICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAg
ICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLWV2Yg0KPg0KPiBOQUssIHRoaXMgY2Fubm90IGJlIGFs
b25lLiBMb29rIGF0IGFsbCBvdGhlciBleGFtcGxlcy4gV2h5IGFyZSB5b3UgZG9pbmcNCj4gdGhp
bmdzIGRpZmZlcmVudGx5Pw0KRGlzYWdyZWUsIGFzdDI3MDAtZXZiIGlzIDd0aCBnZW5lcmF0aW9u
IElDIGluIEFTUEVFRC4NCkl0IG5vdCBpbiB0aGUgc3ViLXNldCBvZiBBU1QyNDAwL0FTVDI1MDAv
QVNUMjYwMCBiYXNlZCBib2FyZHMuDQoNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0KLS0NCkJlc3QgUmVnYXJkcywNCktldmluLkNoZW4NCioqKioqKioqKioqKiogRW1haWwgQ29u
ZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piOOg0K
5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fm
s5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu7
5a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPl
iKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDku7bj
gILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBh
bnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3Ro
ZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBl
cnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRp
YXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlp
bmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4NCg==

