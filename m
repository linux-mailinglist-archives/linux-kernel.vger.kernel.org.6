Return-Path: <linux-kernel+bounces-291502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BC95635E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B1C1C211B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119DE14BF97;
	Mon, 19 Aug 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LVrtH7JP"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020088.outbound.protection.outlook.com [52.101.128.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33C171CD;
	Mon, 19 Aug 2024 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046967; cv=fail; b=juQK8z0GFA+/BE3KlFmI77ESebz3ivOi9GT14oQxHRUOAHa0OrIV7h6WHfh+b2S1nZWHrItuVRLBU+3bRCSDFwhslN0O42B7S3hDbj+OOovOwJmjDh07aCus35MfqsjXTEKuKbm5hwGZQXqT1Qb4GmReqD+Izdea1nAgdmG53Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046967; c=relaxed/simple;
	bh=UQ/+DRA13emWG1HUaLqVrlEmvSb1YvR2iz6ZKX83ms4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nK5zg9Zpw1go0Hb20nXmXBEjeS+mz5mCbIrLEc2ywsreniw7a6O5JUqnQwVXc+eSdXi5gscscmtmkc2VrdLRmT8Zr4b1sU1mW34O6ojkX+wVxgWpXeq2XN+WQFBU7ibA7czeCJhZ241KxZQ7La+GqAPEPPcSo+40qUCfnKdvtzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LVrtH7JP; arc=fail smtp.client-ip=52.101.128.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQMcvmLd4IKKNusr28sc0WcTv1zX7fwm6MtuFN/HsVdYfI9xwO56kac8mKPvq+nSNM9C7dN722Mgk1GZ4bopnEa45kifIjNH1nU8/0l4tUaLdsYNtc+1wJAPdNWwH5+BJVOR1Sazr3vREsugDk+HZ/JJ8zcnetOo+IsPj7icGq76UA2CpvLGnmJ1Mk51FOfxKQtZjXCRsRKYqfy9RrFSONuI3Dq+9VxgmqGl3FwfApkPQG1RvieQINnyK9ZXmj+s4tIs68b03MN0Ua2pJTUXfOH754nKxVBL3VncjvTjl0QcCHi1dNlNMZ8jAqdQdsB9TJ85LzFfAY7vdsDwXuDi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ/+DRA13emWG1HUaLqVrlEmvSb1YvR2iz6ZKX83ms4=;
 b=BnyuTzG0kmrpCsx43jceQywfO5JouvgHXMNvRz0gXmTpQHCOFvYDOatAkQGJEHu/x/zHB4gwN1xjStyWebmlP2RmXJs0lMUj9VMhm6cu9sTcPvGilJ4lFRbD1S+U8Gi7uZpBT5g4IJgeYsv/u/CHKJsIEDJQJUpj/tZb3Okt0narKB0bnJzOilzLuzV54VI/aYIiGy8Uqf6HbDqBWMldsC9M+eDuC0JcPHeWOD1arOW9MpJLgn8Qq6yJFYY7Z5I567aPC8JetAdJsrqjodQJ61Z+DBaYxUYhQbHKxxc1o5M2cLUh0uoZxph8mKwvneP9EPXYhv4F8sXRS7Fd12UEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ/+DRA13emWG1HUaLqVrlEmvSb1YvR2iz6ZKX83ms4=;
 b=LVrtH7JPI50PKdkuX1UULuDDFTK92sQ/cmWeE09n+D8aLHvxp7aTUwMKviYvM39V2SPu2krkOvS8lLKdv/P7dO2e9c7jdOpDlrvhd9YoHFcMYUeUx7crwJf5Aov2xdQ3+cLnUVLSOSJgw0tWD1fdeGoPuI1J2Z0p1sPXoeK/AmpXse4rnKMORC4NGlKsLAd4CxBARYqmEhS5sDj7bPnUCo0yTrauEWN3a4J0UECL31IXnziiTugdJp3ViTPEQ/15PwskAMCGQWc9FG1v5b7sqfoDwAjt6NP0LI+750AkYek19tzrdV9kCJFQlLUKjovmvuXJF0Mja0fI9kiRCn+1JQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5750.apcprd06.prod.outlook.com (2603:1096:820:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 05:55:55 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:55:54 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index:
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwIAADl8ggAAEbQCAAQrHAIAARMOAgAlsyPA=
Date: Mon, 19 Aug 2024 05:55:54 +0000
Message-ID:
 <OS8PR06MB7541A7E690A2D72BA671622EF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
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
 <OS8PR06MB75415EC7A912DBD4D21A0035F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e3733148-142c-40a1-b250-4502e8726f0c@kernel.org>
 <OS8PR06MB7541D5AB85D8E44E89389BC3F2862@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <26988bcd-4d58-4100-b89c-00e8ef879329@kernel.org>
In-Reply-To: <26988bcd-4d58-4100-b89c-00e8ef879329@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5750:EE_
x-ms-office365-filtering-correlation-id: 1b833329-03c8-4b45-02d9-08dcc01396d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTRVTlNGbmN1czJKcGhsYlpreHZvb1pNVitxV1ZURU85TDBDbWJvTkJrTVBa?=
 =?utf-8?B?akVPUFVHRGc3RGVRTHlDQmxQRER2ZldKYkFTN3RhekNSTXNnbWhZa1poV0Ux?=
 =?utf-8?B?SU9EaU1mZnBnd0VlZjYvNDRLcmJvVTNRRERNZDUxUVBvWVlZT0dCSTRnMEhW?=
 =?utf-8?B?NCtGVEExNkJSeHk2NDNZTEY3cFBid0QzZWo2bE05Nk8ydFZDbUN5ZXlFVm9s?=
 =?utf-8?B?ZGpxMU0ycU4wL1VYSlg0dEszTTIzWGRLY2Q3UHVycXRFdGdtQ0oyaEhBamJS?=
 =?utf-8?B?bE1PZ0pVMEhMUDhJTDJxSWtjcXJHazVnb1Jnc0dYb0JxRndlVG9UN0FXbllz?=
 =?utf-8?B?SlpmL0VCWkQ3bExmSzhrOExJbG9KckE3dmRaWXZRdDRsS0RpY0pGTTliQllw?=
 =?utf-8?B?c0h4dG04MVArN0FoNmpQdVFzdWRqTDJrNFlMcEU0L1Voc1J2VjdjWjB3d05C?=
 =?utf-8?B?N3ZCcTFoelgyeXJiNU9zNlpoZXpTMXY2cTIrWEZWaDV5VWlrK2VCSW5UTVFs?=
 =?utf-8?B?N0Q0NEZWQjk4cVIyZVVETnlqT0Q5YnhlREo2NnA1K1I2VVMvYlB0eG5MTHhs?=
 =?utf-8?B?eCtPcUdibFpySGpKSTRLM2NMU1cydXR0Q0U1dytZbmpPUzN3YWJGVFBKdXg3?=
 =?utf-8?B?ODloOEZmaDNFUUZHU3hadVdsMFFyNnVVWFdnbFNOUjRPZTVLaCt5MzJSNW9R?=
 =?utf-8?B?NzczMGwrZXhuaER2U2M0T2MwVE1iQnpZUHE0R1p6TzJ1OVM2UE1zNGowaldZ?=
 =?utf-8?B?WCtTNGR4bm9xN1BOTzlDMUIzU0lxaDVLbEdkV0NwSEhqSzExRHEwY2ZKNTht?=
 =?utf-8?B?L0V2MURkMEhjUHRObmFCWjJBWXQwcmY5RS9vRmNmS252ODZCZ0tralBZS1lw?=
 =?utf-8?B?QkhVM0pVczRoV3ppT090cjRINllveXg0RStBRkpBdjBKK2UzWU1uV2xmcDdr?=
 =?utf-8?B?M1dMUnNidGxKOVlzS3E4aWQxNm1tS0VXd0wrMnNoWElteEFPanFpd0NIZ3Z1?=
 =?utf-8?B?VFFLeGVVVjNLTi9NZVJMSU9hTGdPd0d5akJBVTVWb2Fvc3hyVFVpWFMwcmdi?=
 =?utf-8?B?U0dZek1KVFFTVHEyUVk1dEkzb091RDByMTZCMzFuL3JYRjJBbGpCR2x3dVJX?=
 =?utf-8?B?S215QXpEUlRDZGw4UGc4MGM0RWNCekZRWDRHb2NkZlIwUzRRU2JXRWRKZzA1?=
 =?utf-8?B?ckswS1pTWmcvSVZ4OStScTJsZFBZcGJXTmlhT2pMcWZ6anQ5azRwaE96R1pv?=
 =?utf-8?B?S3Y4YXlOQ2FBOWdZYm5oZFBlYUwvTDE1TDVkTmRzM0hpd0lCUXZ4M1N4T1ZO?=
 =?utf-8?B?aWhaL3d1R2cyUDkrWGRJWjJyNEJ3ZGpxajdlUk1ETWZRbG9wVjE0SGh0eVgy?=
 =?utf-8?B?TlNTNm5OL004L0NNN1MvMURkb0ZEZEJRTUkzb256V3JmeTQ5VnV6SXl4NjZE?=
 =?utf-8?B?eUJBcVVLczNFTE9NL0NGdTFUNlA5L3p5VWd4L1FrQmxKYytldVduL3NYcmlQ?=
 =?utf-8?B?ZUtpdzR5ODBJM2tNUlFVY0ZQU2J0dWRHOHNKUmxPQVZYdWJhYVZmeUd5UDdt?=
 =?utf-8?B?ZzVtQkhWUUx6UmxmbzZFbUd2ZlRIdk5TTWovYzJJSGVIVHRYOTVkWUVqdzJp?=
 =?utf-8?B?V1lGdUNoTDRiZEthSkg0d2pMTWJmTDdIK240K2pGUkpSakQ2RDJBNjV5bmVJ?=
 =?utf-8?B?R2tHKzkrS1N4b2V3bmp2RmpkMFNQKzdqanIrR2RURFpjZ01lQjdiNU9CWXRi?=
 =?utf-8?B?STcvamtoODN3ZEtjVkZNUjVESzFxOXJsOEE3TG0rZTM2VTBaRVA0Vm81Q2lh?=
 =?utf-8?Q?pCKIxTDt80QMrpFF5eyc7ff/gikn82VnOn6jg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVJlcWRaMXZXSGtHUXJrajNIRVhVbzlRR3ZtTEsxYTBBWHU5QzdaT0JWTDFM?=
 =?utf-8?B?Mi82Z3JIbDRadGlwUHFodWh6VkJpV21qSUYvODd2RkFKeVZCTmt5b1ZTMlhB?=
 =?utf-8?B?elRHSklmVTRTS1l3SURldW93ZklpQ1hTUkY4WXRibWlMNlR4eGkwYmpON2VR?=
 =?utf-8?B?ZHhvSmZwTWNvaHRob2ZxeVZHM3hScUUvODBZVGVaRjFaWUhVZHlHTnFKMkJk?=
 =?utf-8?B?eVJVaFV6aHhhbFVaWFlkUkdKZXZ5ZS8yUlZkbzF0c2lQN1hSc00zN2dIeDJT?=
 =?utf-8?B?Ym5mVDZCUlM0YnU3VEhoT3QvVjZBYTJFdjN3VXk1ZHd6d3lXSzYycXVTMmZN?=
 =?utf-8?B?cFJ5dlo3K3MwRVN6QjBrZmI4bENYZDZBSFVEbkQxa2Ywa0RLY2Z3a0ZkMEVL?=
 =?utf-8?B?Mk4xcnNveW1RN3BoWTZ3OU1CbVFmOEJtaVlXOGpvNjZydUJNUnZVUzh4WkFv?=
 =?utf-8?B?K29oT0FWNGxXcnZibDJsMVVTeW9UeEdxZFJsVEdjSkc3b3VKbERUTklyTURa?=
 =?utf-8?B?citDcWErN2VMNDZWaUc4ZmNZMldvbGR0TGhwNUFIbHB1TTU5VG1xajRleVYr?=
 =?utf-8?B?R2xER2NscVlFK00vYTlMSXcwOVlxVWZEZ2g4U25nM29tQkp1VXh0RzVUREx4?=
 =?utf-8?B?NjQ3MVNZaXhLbXBGTVduUlZpZzVyMjNFbG1PaVpTc3BuVHY3SlFlUTROaXZY?=
 =?utf-8?B?ejlrVWNSVTFZWjgrcmhZRklITzJsc0Mya3BiVDM4V2hzTGluVUQxMXJIRXlC?=
 =?utf-8?B?TXhRV0FyRUlmUm04bmVLSFhtSjFIeGVqZ2VHM0V2OHNmYnVmM09PUHdub0o2?=
 =?utf-8?B?NVBYWUZjOHUxZjE2cUE0NWZpNEhvdzY3dnhYR0NxY21oais3bGQ5dXYzT3Ni?=
 =?utf-8?B?Y3ZjS1kzSU81NUMxN1VpZnROK1V0YUdzb0IxNGlkczB3MEF6R1hCQ2R6TkhL?=
 =?utf-8?B?S0MyQlVJVzQrOTBOY29WSzIrYURQTTlxMVVhNFRGS002SmNRZ1ZRckVGYzlr?=
 =?utf-8?B?bnp1T0V4L0hkSU1sYUtuYTE5Ky9TTFcyUEtabkZXY0c5QVJyUVVYcUo4QS9a?=
 =?utf-8?B?NHZNajRCbHpVMm9mcXhlZHdHc1pENXQ4NDc3VmZwUHpYdW1NM1BYa0RwS2xN?=
 =?utf-8?B?RVdmUG1PUk1BSUkzR0RjVVk3cFJhU3p2MWRGR0toUkxoRkRUUVVuM3N6OHlJ?=
 =?utf-8?B?Ly9xQm0yLytyZWNOcFJ6OXdSTVBYQjk0K3NDNDhrQ1psMmE0ODRaQzd0dVIz?=
 =?utf-8?B?dW4vMUZ5dGZXcXVsTWF3cHJXSW1tMEhWQ2VMRFB1RlA4QUNkMzBKSERGVkVm?=
 =?utf-8?B?OTQ0WWphU0FnZjBTNnpPeFRUaWIrN2hpZ0pncHEyMDRQVWdhVjlaMi82YWdx?=
 =?utf-8?B?ZnI0Rm53YlMrMlpzNndxbGc1UkU3TlFuV2gxLzFJekR4YUhENWtsUHN2YnR2?=
 =?utf-8?B?RTFiZlBUT2FYNjRvckZ0Nm52WERoU3pRcGNzMWQyWExiUDFnWER3THYrVHEv?=
 =?utf-8?B?TkZSTXA5c1daNklhTzNXZUNadVFSZ3VTdGxEOTZhUGdjakVEVjhJUDZKbHN6?=
 =?utf-8?B?Ui9odlJwMFlLZDR1azA2Q2Rnc1lqcWpVc2xUMTNncmtmRGRycDJTUnVBczMy?=
 =?utf-8?B?MVdsQkNNSklSMWZLYXdNYlRGUkhUdUZyVXlFeWJzcDVKaXVuVDdPZ2pMWDlY?=
 =?utf-8?B?UkZJRlh5M0ZlSklRcGZDR3FxVTd5bGUwa1gyQXN4K0d6RjFOWmpmS2VwRlBK?=
 =?utf-8?B?VG9FeXlKRklFRm5HNjl1Tk9LY2UvS2ZsT1FyUVZKamNnS3NlaCtNTzY5V25r?=
 =?utf-8?B?VDB4bkRIdVQzVTE4RzZrUUZNMmJ1cjVSa2NKdTVYVUk3c2ZqM2RJb1pqZm52?=
 =?utf-8?B?UmtNSE9hZ3VLOFM5Zi9saFl0YWhzM29TSzFJYVNkWFJBRSs2ZkhpdldsSloz?=
 =?utf-8?B?QVAwS1RPYTRRVkZsbEJtdStrT1c2SGl4aHZ4bmVHQi9LWXc5NEFrVjdBMS9E?=
 =?utf-8?B?Qis4TXJmWE95WG1ZcGdhaFk0SzdJU3dTM2x2RFF3dmdiTE9TdGEzQ0lhYjgv?=
 =?utf-8?B?dXFObVgvbjhzWGRZR2xNdnJwRkNtMHcrbit6K1AwTHZKNklGK1RGK0pQWGEz?=
 =?utf-8?Q?f7SLFGpBs2JwDqt4bjD5mAk6e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b833329-03c8-4b45-02d9-08dcc01396d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 05:55:54.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HQPiKP8ybZqRAzUNxn8EgMvZY2SMKMwIU3IQPhvurGgNOpcxQN0eC2RDarpchF9zLj/R2xmIXywmcsxlrBayknCsFPVe6BXYEJMcjwyLr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5750

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTMvMDgvMjAyNCAwMzo1MywgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBEcm9wIHRoZSBkZWZpbmUgZm9yIG51bWJlciBvZiBjbG9ja3MgZnJvbSB0aGUg
aGVhZGVyLCBiZWNhdXNlIGl0IGlzDQo+ID4+IG5vdCBhDQo+IA0KPiAqTlVNQkVSIE9GIENMT0NL
UyoNCj4gDQo+ID4+IGJpbmRpbmcuIFlvdSBjYW4gcHV0IGl0IGluIHRoZSBkcml2ZXIgb3Igbm90
LCBJIGRvbid0IGNhcmUgYW5kIGRvIG5vdA0KPiA+PiBwcm92aWRlIGd1aWRhbmNlIG9uIHRoaXMg
YmVjYXVzZSBJIGRvbid0IGtub3cgaWYgaXQgbWFrZXMgc2Vuc2UgYXQgYWxsLg0KPiA+PiBXaGF0
IEkga25vdyBpcyB0aGF0IG51bWJlciBvZiBjbG9ja3MgaXMgbm90IHJlbGF0ZWQgdG8gYmluZGlu
Zy4gSXQgaXMNCj4gPj4gbm90IG5lZWRlZA0KPiANCj4gKk5VTUJFUiBPRiBDTE9DS1MqDQo+IA0K
PiA+PiBpbiB0aGUgYmluZGluZywgZWl0aGVyLg0KPiA+DQo+ID4gU29ycnksIEkgYW0gY29uZnVz
ZWQuDQo+ID4gaWYgeW91IHRoaW5rIHRoYXQgbnVtYmVyIG9mIGNsb2NrcyBpcyBub3QgcmVsYXRl
ZCB0byBiaW5kaW5nLg0KPiANCj4gKk5VTUJFUiBPRiBDTE9DS1MqDQo+IA0KPiA+IEhvdyBkdHNp
IGNsYWltIGZvciBjbGs/DQo+ID4gRm9yIGV4YW1wbGUgaW4gZHRzaS4NCj4gPiBpbmNsdWRlIDxk
dC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaD4NCj4gPiB1c2IzYmhwOiB1c2Iz
YmhwIHsNCj4gPiAuLi4uDQo+ID4gY2xvY2tzID0gPCZzeXNjb24wIFNDVTBfQ0xLX0dBVEVfUE9S
VEFVU0I+Ow0KPiANCj4gQW5kIHdoZXJlIGlzICpOVU1CRVIgT0YgQ0xPQ0tTKiBoZXJlPyBJIGRv
bid0IHNlZSBhbnkgcHJvYmxlbS4gTm8NCj4gdXNlbGVzcyBTQ1UwX0NMS19HQVRFX05VTSBkZWZp
bmUgaGVyZS4NCj4gDQpVbmRlcnN0b29kIG5vdywgSSB3aWxsIHJlbW92ZSB0aG9zZSAqTlVNQkVS
IE9GIENMT0NLUyouDQpBbmQgd2lsbCByZXBsYWNlIHRvIA0KI2RlZmluZSBTQ1UwX0NMS19FTkQg
IDM0DQoNClJlZmVyOg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFz
dGVyL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OC1jbG9jay5oI0w4Nw0KDQo+ID4gLi4u
DQo+ID4gfQ0KPiA+DQo+ID4gSXQgbmVlZCBmb3IgZHRzaSBiaW5kaW5nIGluY2x1ZGUgZm9yIGNs
b2NrIGVuYWJsZS4NCj4gPg0KPiA+IElmIHRoZXJlIGlzIG5vIGJpbmRpbmcgY2xvY2sgaW5jbHVk
ZSBmaWxlLCBob3cgZGV2aWNlIGtub3cgdGhlIGNsb2NrIGluZGV4Pw0KPiANCj4gSnVzdCBsb29r
IGhvdyBBTEwgb3RoZXIgYmluZGluZ3MgZm9yIG5ldyBwbGF0Zm9ybXMgYXJlIGRvaW5nIGl0LiBX
aHkgYXJlIHdlDQo+IGRpc2N1c3Npbmcgb2J2aW91cyBrZXJuZWwgYXNwZWN0cz8gU3BlbmQgdGlt
ZSB0byByZWFkIG90aGVyIGRyaXZlcnMgYmVmb3JlDQo+IHBvc3RpbmcgeW91cnMuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

