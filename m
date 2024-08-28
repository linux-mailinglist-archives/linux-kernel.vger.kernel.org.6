Return-Path: <linux-kernel+bounces-304530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4096215B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D01C22656
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AB15C15B;
	Wed, 28 Aug 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="XrrTRnGv"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020087.outbound.protection.outlook.com [52.101.128.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EB15C128;
	Wed, 28 Aug 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830578; cv=fail; b=lKbdAt4kBQAKxOcodTKqGwO0V+yL3F1WmGIZ6PubvL5gOy5u1Q+cjI4kRVvFIpIqj1ILLAEZbzmkST9exRe7EVsso/nG1QCFGaAso8NrVOSbj0FN+s9PuNUScFnyFD7kDQ/yaL71TooBcpVeEwVhRJII9N2qcBUBCcPIcWrhhPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830578; c=relaxed/simple;
	bh=3HTMlq/wzEFgmms2yAYUSnMQ5SbY4UfF+5/qevJuFWY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UBFuIlKL5O+tAZOIiPOFylM1HH0dKSZRMsfEsJcZiHAOf9yh/jx7DQ9W05vUfaLgMnl3JtpwyZBMUq9UDQZjwNMRSL+4sFM+Me9ldgIl/8lrk1ezif/ryGADRy1AVbC/6FRJwV8GehGgEYbgKk2UlYdHIr2PzH+Js/dx/dIZ47g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=XrrTRnGv; arc=fail smtp.client-ip=52.101.128.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLv4d2jm/qpa67g0on+Vgb0qIZXzB8BPV5i33h+2qy/40hGu5Ng+MuBjKZKEfjirpnMAa9koO9ZFI4hEC2BT+8TXlONGz8VKfa1CMimPc+CZDLoPiV6ohaG8Crmm9sNV402OfdtOxTrI61eNcdP8rw3bIgjH2xejBT23ZA4fQ6T0bBQffkfC+k56KP9A1c6CGtHeBDeH5HmIjrf30fwueU2wfxKsYDgnQWxToybfBFx0aexU3MUE2xqueg/Zioycz9lU+99tjnaqAoqfU0be54zYAG8RDh0Vpi3VRqchmKKdb+ZOSm68xRXAcvieFW0CSGOhjJdCGTb1JillJGF3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HTMlq/wzEFgmms2yAYUSnMQ5SbY4UfF+5/qevJuFWY=;
 b=bHq9KBsvkf+9o+vzYEQieLRdu4+ucQfM52b8Pd5XuMTeextcCVOGRE1b3D3PMN5iFk1+0n+JITrdRjZGfeq9QiSn7S24RdmKSQvYm3YB5odto9i0XcDRU90lGHE8c0YwitKDmksQh0BeDg04F+wZ7uIpZO7rvtYob4lP3up9FjXqxaquFwI41E2P9i8eglDeky2fMvQabeBkl44O3P8qAH4o52pL1D8xqsglz2JJq9+BpZW4Z88/dHxHV87haMux4ztjXqNLAXR9AePS8nZkYfV/ADSNdlqSZQfhQJKXvIj0B3o2oRbAQ6WoDDcl7AJo9f2SyuxiyafCE7nuw82xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HTMlq/wzEFgmms2yAYUSnMQ5SbY4UfF+5/qevJuFWY=;
 b=XrrTRnGvivHBu/Oa0506ULzOjIO3iGCxDYspmZPw1BwBSYVsv0hYcE1SwoiqBrdt6VGh6HujhFPdgtYrY9Z3Wi6HDqqerXC7NqR78PCxhRvIGQPnPcM2l0+JyBQ3ZBPdz1mDRZAA6pmj+hIJ6gj0MzU68B0Bx0Gz3d93h2OPS/5T5K5eqC/cKOvOHZwCgqrZf5VxmcfCm7gLy+JXH8nkdkX6nwHL/i4gy/J4H+oR43lPGp5LAGndOyh2IsC8g50a5eNZ6cJ9SLSzeuSkTPD+ocd8d6wYp4ydEkjoNaF/PXFeCUwa8RGsPQKNSF4M28Itc4brrOt0UTw1mrt2wrzcvQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY0PR06MB5284.apcprd06.prod.outlook.com (2603:1096:400:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 07:36:09 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:36:09 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: reset Add AST2700 reset bindings
Thread-Topic: [PATCH v2 1/3] dt-bindings: reset Add AST2700 reset bindings
Thread-Index: AQHa+RNlP+Ev5V3xu0m6p1yNN2O1ErI8RV6AgAABwSA=
Date: Wed, 28 Aug 2024 07:36:08 +0000
Message-ID:
 <OS8PR06MB7541FBC6591CD129D32B4A3DF2952@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-2-ryan_chen@aspeedtech.com>
 <465c04fe-4455-4eee-9d65-43f66434b784@kernel.org>
In-Reply-To: <465c04fe-4455-4eee-9d65-43f66434b784@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY0PR06MB5284:EE_
x-ms-office365-filtering-correlation-id: c630cedd-6278-4f40-5c8b-08dcc734155f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?REZRUk5nNjQ4aG5CNEZiNzBDWk1JS0pkOUsyaU8yTExlb0FFQzFOUENQMVVi?=
 =?utf-8?B?cnJiRUlBSmJ5eDZjVHN5a2FYZm9jUUJmZ3ZJRUQrSUdQRVl3bEZody9wL3l2?=
 =?utf-8?B?MGlIVkVGczh3T1E4dlFlTWlOOVB6Y3RzQmNnQnNaOU1BL3dFNXVuNWQwd3J2?=
 =?utf-8?B?Q1RzRHJjZ09Cc21FK3J1dnNUT1dOL1ltZHNiVlFFUXFkcldRTjZrYnBTVkNi?=
 =?utf-8?B?V2NEQXNWSUFwU3ZnZzlIejBUa01EaGJCdlR1amxnci9yRkVBczFjakw5VjF3?=
 =?utf-8?B?SWRPQzlTdkM2TzZORVMxSG9EZ3dRb3ZCMzJrajJSSjExRWJlQXpkVzhPSExZ?=
 =?utf-8?B?Qk5IUTFEQzB3WXB4enE0eC8vOUxZRXhwZk91OFUwK3JnVEEwZWxUbGpWNEI5?=
 =?utf-8?B?SUxpZmNLMVBvazM3NDFzR2FlQXlyNXEvNENtd1lUVE1Galc1cDJMNkRJZVYx?=
 =?utf-8?B?NERqdDNiVmtOaVplYkMxNEVYU3NQSG84QzRzSkltSjFtMmNJT2FLbndmejJ3?=
 =?utf-8?B?aXNRWmUwUHRDY2MxbVp1bTJkcE44NzlHNGJZbU14YnVVZHlJQmw0bDJ6d3F0?=
 =?utf-8?B?d2hHdDFGcEZHL2F2R0ZqSURLRWdQUUYybDdLdzJIaUJNdjJFQ0RuQ1RwaVQ3?=
 =?utf-8?B?OXhNRzg0UUNhVmQvVFZESlk3emp0bHcwME9iVEljdjhGTjlPVUE3cEJ3QUZq?=
 =?utf-8?B?MDFCMHRXTGlSV0ZIbERFZ244MWJYRDNBUUR4cmpDQ3ByMU55U1VTOHF3NmxM?=
 =?utf-8?B?bkpPaUZpTGpKNHh5VkFSZVBuUTVvTVhTUktnNHFzMXhJZW1JeFlGWURaSlEv?=
 =?utf-8?B?Z0dvcVNRaGdLd1haQmJZT0ZVY0J3UzgwMnY3ZkpncStqUEl6Ylg0WTIycjFC?=
 =?utf-8?B?UFJjSlRNSktCdDlTVTMvQzZEVENHU2dZSVlHbXVRQkJrYS9tVEtEWnZCbEZC?=
 =?utf-8?B?RWpJNXV6VHpRckswQng3YjRGbVBVQ3dpRW9PaEVuSDdKVXBwaGExRU5LK01l?=
 =?utf-8?B?NE9GemJkQ2lHNlJGV3UwL0JPK3MvNGJsU2NuRzl6dExwQXBVOTdwejNrQUxG?=
 =?utf-8?B?Z0syOXhqdUpoTEI5cVRqMkFIZ0dXb3RSS0s5U2tSalJwNlVyMlVvUUM3dXVI?=
 =?utf-8?B?R2JCL0dyejdFaFJ6QWovbmZnWmNMTzQvalB3THptOXpka1VXZVV2MVN4OVVD?=
 =?utf-8?B?QmFjWENjeW1RdnFZOUVRYXRKZ2FPZGlWVWo2dUY1b3VhcEdzdUozU2RIT1ZN?=
 =?utf-8?B?VkY4dWtFOHpBTzdGRmtTL2VaWVJrN3hVWnk5ZGJzbk93Qm1yS3pqcW82K1lq?=
 =?utf-8?B?VHNsOUp4RmVJNUtONWdRSVNPbnBFbWwvRFFRWEllcUVGMnpTdHQ1d1VWWTZR?=
 =?utf-8?B?WWRiWlErNkx2ZWFPS3pvUmVEVTQreDZ0UmF6Wkd0anBYa2swVGVvTlFkVVVW?=
 =?utf-8?B?d1hKNlMvMGhnTGd6Qld0L1FLZmgra1I1dDlpMjE4Z3V0VFMxaTl2NmorMjJ2?=
 =?utf-8?B?dWZxYzBYSkJEcFRNemN0ZHJmdktGMW92MzNPZHdSNXdHQlY0NmlvRStIY0NR?=
 =?utf-8?B?MnBVMk1IR3hwMzNnR2o4NUY5ZHVtdysrN3kwZnhBaURvQ0dpcXBtS0tLUHdR?=
 =?utf-8?B?WWJVYm5pMTFuYkpKWDQ4T0FpcDZqeVVicVVZb0xXTm1XZ3RyZWppWGhPUWQ5?=
 =?utf-8?B?eURiRkxkT20rU0lzblJtbXVRQWNGYVMwTnNvdDF4S3B4b3J6YnJaNUdTdTJr?=
 =?utf-8?B?L2RpSTZPbzhja1Erb3IvWUlLa2pUV3l1YnJ0U3paNlpxT0FNcGN3aFFiM0dB?=
 =?utf-8?B?NkhGL2oyNmZTN2ZpdWJpcmpGVXY1T2w2UTZGdVc1M1d5WFNBRUs3eU04ZjN3?=
 =?utf-8?Q?d63S2F/7db8rx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHBOY0RoL2dNeTJwMDdLNWpaRUhGSkVjdHErTDV0WHAzczB2MGsyNUszQnJG?=
 =?utf-8?B?bm9GMkkwVE9kWjJkUjRLOEJsWG5Hcy9INUNvYzV6dysrZkRpUGFHNjVCZ3RE?=
 =?utf-8?B?NmNrM3BrRHFsRXBtK0FxZitrNDQ0SEZkSHI2aGhqRHRpdW1aN0szaXZFb3lN?=
 =?utf-8?B?ODJFTG9YOTEyNFdGdjVsZW9NWnQyaHFacStka0c5UmVFaVY5S1ZZTENXeTY4?=
 =?utf-8?B?c0VmUW13MUFLS0JVSU1MT0VJdVBjSHBieE1ja1BzSVJYL1FLdTNGNFJDUjRF?=
 =?utf-8?B?OUtiZjcxTndua3FOU0dJWmNnTHNpVDNxMlp3TFdFM3Q1UnBVZXg3OFFqZnBD?=
 =?utf-8?B?QmhxWUIydnJUQnVRckEyd3F2Z3RSWWNCWkVsUlB3c3lmZ21zNzlobzhTNUc2?=
 =?utf-8?B?b3gvcDJmNGtaMGU0RVlYeXFYY3p0ZmY2aXlUQ3F2bWNjWEVwUEQ0UkhOczdq?=
 =?utf-8?B?VS8vRmdzVFBuQkRYU1MxY0M4ZGpvMk9CRDJ3T1ZscVFibFYvVkw2VWl6WWFh?=
 =?utf-8?B?L1JwTU93OHc5T05vU29xOTNpeWs3UmV6MHZZT1NZcmUwQTBROTNoRkp6d1Bv?=
 =?utf-8?B?MVJpK011c1JuRStqYzNQTXQ2Z1Jxc0NPTStUVFErZnV0bmpEWE9xbkwwdVJv?=
 =?utf-8?B?bmw5bWVJZkhWVVBkYnVRT3JZeUxLRGFSZEZnRytNbGxPR1ZpRml2bnlud3lI?=
 =?utf-8?B?ZjRJdWQ0cC8wZ2Rtckx2ZFhsK3pSZUVSSkJoREt4QjJFN2Y0TjJ4My9aL2Zz?=
 =?utf-8?B?aHBqUHl0bHRlMjlIZEU0NDgzRGVqS2k1K25iK3gzWWV1MnlwSU1ydEM4akVE?=
 =?utf-8?B?WWh6MExnZGVCeWRXMW0wVFNYQVBNNFdPa0NJNmxPdDRKbkg4M3MzYzlwL2Zk?=
 =?utf-8?B?TVg4VDQzcTR2azc4aE9WRnNYdTQvYnVLQzh3bEV5UlZwZXlCbk1ET2RFc3FZ?=
 =?utf-8?B?c0RRK0J0eFEyVm01emRlUDRMb2VDTWtDOHd1T3d2c1lLRUxSWVdWaDk1NjI2?=
 =?utf-8?B?dEV3WGFWZ3luNU1rQ0RyeHpMMmZ2dTdqaHpJYzIvNDE1UFd5U0E5Rmt6YitT?=
 =?utf-8?B?bVYzOXhrTHRtUDZGUnRudFFjc2dvdjEzcDRvQ2pUUS92aCtIT0xyWDNEeDJG?=
 =?utf-8?B?ekxZbi90SGlrM1JZTjNvT1VhZTl2VFlUa1pvbU95Uk5jY3hOb2lVRzVyU2tl?=
 =?utf-8?B?VGdIdG8yVFpNWEJUL1ZCM0xWR0FwYWR1dnVka1l3VC9ZUEZ2a0pBcU5CUmVt?=
 =?utf-8?B?RjFQQjIxZ2JZbDNRdkxNb0kvN0lrOGtiSUx1Nys4NFBzb1BxSGI5QlhhYWpK?=
 =?utf-8?B?cXJqQ29TeStiRTFGY3p3YnVHZmZyMElnUmppWGxnQUhPSkJXd0JvSFZMMzJD?=
 =?utf-8?B?UGJEM3NBVTJOeS9zMmNBRExTMGlVU1g2ejNaZmlkRTc4bEtoK0UvYko2cEhZ?=
 =?utf-8?B?YWFFdll4bjJHSUxiWU9aUGd5NWRaWWY4MHZsNmFvRUd3THFiUW9wNmlDSGJF?=
 =?utf-8?B?ZnZOQkVRWE9EbWlXM3VWQ1dLOTNkbWI5L1NZTzU4Yi9Kai9ydWhZSDVFL1JY?=
 =?utf-8?B?M1BRUmVkVmVyY1RpRnd4YjdLb25uc0xoZ2tYRG1ubnRlUHk3azdUKzZaN0E2?=
 =?utf-8?B?aERWQUpzZ21nUVd2NEZNNGppS3BodmFZWUhwS0V6Nlh1Rk04NkNyZlpzME05?=
 =?utf-8?B?WkxhSXhIemhMQXBoejc4T3lZOUlKTjlwYm1KVnJVWTBlbmhaZG5Oc09GbDdZ?=
 =?utf-8?B?SG9rTy9TVlU1VFplbklaOWs1ZzNseW1tMWVuN0lOemhQVnVKaXBWUVdLRkxi?=
 =?utf-8?B?NGx4Vmp2RE9wemJmNlBZMXRqSGhoTTV3aFN3Qy9odGxsdUJLWjJzdExLeVpB?=
 =?utf-8?B?TUhtdGZtZGtDTWdHUk9RVWw4Rm84RnZ2UElha1NXTk9PVkYveXc5SjNCWXV3?=
 =?utf-8?B?WDRtNEFPczhmUTRjVzlEVThJdlp6WHAvMU9Hcnc4YmtHTjc1dWF6ekFhZ01w?=
 =?utf-8?B?UE8yUU9LMFZQZWFTMkVraWFxb2R5czAwamdacTAzbUNqazNQdnZzNWVBWTFi?=
 =?utf-8?B?elhMcVhMN09Rck5zekVoNVVVQVF1c2NCb05qaFFTKy80TTNNTTlPRHVQbGky?=
 =?utf-8?Q?b6p27ABpnCbzeqsPXaFXY4Rqe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c630cedd-6278-4f40-5c8b-08dcc734155f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:36:09.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7kp5PTM7kl/K6eu3+TkyIH8gZEBKaj3mUnFh9vMoPgzI5x0kLRYC3D+OgWcJSQ16KDtDVi3H7tlK2SsC4rOOxKMVXKRE2ofdhzB9077pFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5284

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IHJlc2V0IEFkZCBBU1Qy
NzAwIHJlc2V0IGJpbmRpbmdzDQo+IA0KPiBPbiAyOC8wOC8yMDI0IDA4OjI3LCBSeWFuIENoZW4g
d3JvdGU6DQo+ID4gQWRkIGR0IGJpbmRpbmdzIGZvciBBU1QyNzAwIHJlc2V0IGRyaXZlci4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vZHQtYmluZGluZ3MvcmVzZXQvYXNwZWVkLGFzdDI3MDAtcmVz
ZXQuaCAgfCAxMjUNCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEyNSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJp
bmRpbmdzL3Jlc2V0L2FzcGVlZCxhc3QyNzAwLXJlc2V0LmgNCj4gDQo+IE5BSy4NCj4gDQo+IFlv
dSBzdGlsbCBkaWQgbm90IHJlc3BvbmQgdG8gbXkgcHJldmlvdXMgY29tbWVudHMgYW5kIGRpZCBu
b3QgaW1wbGVtZW50DQo+IHRoZW0uDQo+IA0KPiBNb250aCBhZ28gSSB0b2xkIHlvdSB0aGlzIGlz
IG5vdCBhIHNlcGFyYXRlIHBhdGNoLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L2UxM2MxNmRiLWUxYTctNGVlMC04NjdiLWIxODRkNDIxZGU3ZkBrZXJuZWwNCj4gLm9yZy8NCj4g
DQpTb3JyeSwgSSB0aGluayB5b3VyIHBvaW50IGlzIHN0aWxsIHR3byBmaWxlcywgYnV0IGl0IHNo
b3VsZCBiZSBhdCAxIHBhdGNoLiBhbSBJIHJpZ2h0Pw0KSWYgeWVzLCBJIHdpbGwgcHV0IGFzcGVl
ZCxhc3QyNzAwLXJlc2V0LmggYW5kIGFzcGVlZCxhc3QyNzAwLWNsay5oIHRvIGJlIDEgcGF0Y2gu
DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

