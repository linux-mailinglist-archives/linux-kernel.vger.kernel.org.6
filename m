Return-Path: <linux-kernel+bounces-249310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BA92E9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D1F1F20F76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889F15FA68;
	Thu, 11 Jul 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="fP72LOv1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73154CE09
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705223; cv=fail; b=Tyosw0YMQ0nT/trcGRDcHi+pa9BSRgEO4OEv7F0BYm2cak4bnTPoQdT0UYRRhTCkKJmLR/5Zv8jj02dBWDC7UzZcE/jBNfZZIHFAqxUbAIKmzmT4qEbD2Yi4gE83g3TAqipTIC98j32pZMXb6peoTcePlEtDviSvDK/M2MDE4WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705223; c=relaxed/simple;
	bh=CR38Gv6EZKkiLj6L+w1Ma6mzVobtmxfgxT52xLWUQj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eg1N3PYIP3v7vLPQ+dVUEfC2Cbv8uTw8iTdrKsrwNB4K/t6ae9iTxfqbXTjUKyWX+6qH2JY0en7+y2XVx2WdOcMaOmiqvMn7pSE6ZbK/KqxOX85nTHq64R70NLyrZL5ZU+6ZwQwcH56KWYSh/XMK5xEIy5qhYaLGMfy9P2rK9ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=fP72LOv1; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=col0I21kxwtCRbUhwziMqPgHZWY7rEscRNTG0glRuAk+fTS2S1M8l/b/p4D9sWnt01TN4+jLDNgJCarStawdTloJ34jWwjEiq75EaHQxE1G01aD9Nk89vT9AzlvZQBrX6OJHiHu/BSEI/u3Z12KWYwZZMd8iKu1/ZN6i0/v0X9KTgINgIYjNuzm2Tq566ry+nJm0nqWWH+tJdyPLExNbE+Naccv//l3uirZ43xG6bceIgQN19uSt9MQ60skQIt43+93c02y7sufqBXyAnT5e+NqG1W2NKcvDuWkIxBzdT0LxBKQgE7kmSo0p39x6tmPO1Xkht08WVn7XgCRjGNy8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR38Gv6EZKkiLj6L+w1Ma6mzVobtmxfgxT52xLWUQj0=;
 b=V2Fx0zaFBysH4IVEh24l0yZVvcz7YeJ0UKyRIA7cqsn2fSH9X7Xefm/wACDIWmVw4aWITynv6bWq92vsIrE7KqGewmWn5o+ZpMh4PYyZiLaAuynzbjXTyEp75nd48DGsanwZwKKApJpehvshahaQTuSmp0LeJF/Fg8I5ocKabw8DbskKDx6u1huYdyt3V57NxBRZX43rQg9M9b65iQNNJj9YkajOt25yiia3XQw0kaC7DGJRJIp+3XX+1vWazlV5YHgu0AYO3EO/4Li3Fn0ZIZZOfay8Rs1E3dSbBi6CTppBrBJEBZ6PbYCqbnUIwXbB4dNfKso0Vk1Cct2a0pwBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR38Gv6EZKkiLj6L+w1Ma6mzVobtmxfgxT52xLWUQj0=;
 b=fP72LOv1Xr2dkSqIQtjz7MBxtOPJ6lEZg9eFrCDn83APA8zGj1Q0csKd4CnzIAvjDhY2KDzJbY+lTopRKZ2QMEokNleESiVK+GIsi9JO/pUQ1vvHWeLIRryyZQl9KoEe4XBj5BMq9wkSxgb8WFToBUE+HX28IaRaNwCBFHbwQlRwz4PF+SkizsENBaeVc8J1sstvpERiHXs4Y5Evl1jXITa7MxDow7eZcx6T5PbeotUBWQeVJs1EsoiQXSdqJ+gDvDYGDJ7Jn9vuwG/CyyYV5D8AKIppP0Y7+26Aw8+n8qrunhB/4Yp5lLxm193h77Kv516USouYy+1/C1Pne6C/jg==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DBBPR07MB7593.eurprd07.prod.outlook.com (2603:10a6:10:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.6; Thu, 11 Jul
 2024 13:40:17 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%7]) with mapi id 15.20.7784.005; Thu, 11 Jul 2024
 13:40:17 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Thread-Topic: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Thread-Index: AQHa0p4D2W7MMhCsM0ethL853L/GprHwCroAgAACMoCAAD9ZgIABPjgA
Date: Thu, 11 Jul 2024 13:40:17 +0000
Message-ID: <154b60ea-9113-4093-8082-7a471beacfb1@cs-soprasteria.com>
References:
 <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>
 <Zo6e1ILgDn6nuhGC@x1n>
 <b37a0bb5-ba6f-4db3-af8f-83e06eec086d@cs-soprasteria.com>
 <Zo7Vz_LGUgaf9BGN@x1n>
In-Reply-To: <Zo7Vz_LGUgaf9BGN@x1n>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DBBPR07MB7593:EE_
x-ms-office365-filtering-correlation-id: 5d46e65d-9a41-49dd-4a07-08dca1af000d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2NuTVVUVUJCQVBQMS8vMGptSEVVSzNWN094Y3E4VWVKeW5FRTJqWFN1WTc3?=
 =?utf-8?B?cEM2RHAvcncrOG1kZzU4SFRRTHdTMEVCVlhEakU2ZUluR29MKzJtSkRESFFJ?=
 =?utf-8?B?eW1uTzdDYzU3emd3UnozZUFTTnkxei80bWxGQW1Cb2p0MFk3dVA5cXZTS1VO?=
 =?utf-8?B?VmthTHdFYzA2cmdURVIzTmNWSnArRVdvVVYyRGtaR3o4Mlk2VHpZaUhIY1FY?=
 =?utf-8?B?dmJRU25obHh6MUtheC9OeUFvcDVEL1RaR05wcEFNYVZVN1hMTDUvSmdxZWVJ?=
 =?utf-8?B?Qy9KcTVzYkNUbVNBcmxGbVlMSE9iTGJNRU9CdEhFZ1RzYTVEZGxtWTFxTHJD?=
 =?utf-8?B?R2YwUGVBemdCcW5zbGpJdkNQR3VwN3cwWXNYc0hObWNFc0o5NERXVEpQdnJJ?=
 =?utf-8?B?WlRqMmVYai92eTJ3YUVYQWtKRlV2Y3h1V2dTOU1CVXJ3dTZ5cFFtWWhFcVNq?=
 =?utf-8?B?c1VXL2czTENFVFAxVFFCUGs3UDlSR292Y0c4YVBTcExPVHB5SCtqaG5yQ0RG?=
 =?utf-8?B?TVdyUlFaZCsxcEViajRzaFZES3VEeEtDR0pya0RENUNxdStVM3pvbG1oRUdK?=
 =?utf-8?B?TUJzYUlBaWVidU1tL1l2NmQzQStLNjVsVHhPMS9yZ25Ic290RVpzaldlNHBz?=
 =?utf-8?B?RFYyZGs0bVBCVXlaWWJsV08rR3hJQmExZGxXRDhubmtZRjFkSHFxNlRYN3Zm?=
 =?utf-8?B?UTE5Y3BPazdkdmZzQlBiU0V1dy8zcG1ybjJEdU1ER0ZxSlRjL285MjM1Mmd3?=
 =?utf-8?B?N3A2RnhJRzFqYnNmTjdRa2YxUlF1amsyOHhHKzNPME9qRTR3RnV3WHdCbzRz?=
 =?utf-8?B?MlREMDM2Mjh6V3Rjdy9xeVoxZHNFRkZpSFJROU15cHdCUkJJUUExTWRFTGU3?=
 =?utf-8?B?MDVkeFNieTNzQjcybWlwVEc3aXBmc1FzSVVCRTNBVE82dDliQXp3Z0svZkFZ?=
 =?utf-8?B?dFVBMFR4a1pNR3RIdFU5UDN5OHJlOWpNWlFQM2QwUm5RcW9Xb1IvUXg0ZzhS?=
 =?utf-8?B?V2dKUmEzZE1uck0wQTNyTFpBVExaNzRnSGc4QW1zeHdTdGNQYW5Lbjg2TEVK?=
 =?utf-8?B?UGJ3WE0yOXg5ZmtxNHRZdStRaU1lV2RCN2Z3T2JQODZVZ0UwbXpKcHVNQ1Z1?=
 =?utf-8?B?K2x0MisyenRySVg2R1dvK2ZyVGFrVUV0S1hNdFpNK1E4VUtwam1Pd3BRc3pw?=
 =?utf-8?B?SldMNFNFOUhDZGVNSFFJdDA2enc0b0FnaW8rSTZrL0ZmdWFQQ3RNbVoxSWRp?=
 =?utf-8?B?L2RORXNhb0dYeEYyNzh2d1FBY0p3aWRhbXdPY1J4dys1REkwek5rWm5ZYjN3?=
 =?utf-8?B?WHBOQzlGSjQ5L3ZseGVQT3UraGRtbU9hUldQOHlySjRMeThYaFFucmFSV2tW?=
 =?utf-8?B?OU5nbG02U3ZsaHJPcGxUYzhvNGNQL0cyeE8xRGdGSTBFSkN1cDdNOFZqR0t2?=
 =?utf-8?B?QTlBOGE3WS9XdVd1cTBzeXYrZUFHODQzbHA1WGhsTDhaemZaTmNiM2VkNUEv?=
 =?utf-8?B?NGc5RVY2dmdLYk0zZDZFb1ZpcG1KcHZpQndwZUxmZGhZM3NaM2tTcFMwOHNr?=
 =?utf-8?B?ejBaOUZtUWM1TzRCK0lzbEZUY2JsanVQR2ZpUG1EKzV4dXlnTzJ3cXZQdVVL?=
 =?utf-8?B?WEprTmYzbGt1b2FFTTNqcGFSUEYvbFZQVDQrdUVJdFk5aUQ4bEhidVRqQjF6?=
 =?utf-8?B?RWVWckdlcy94S3dFdkg3ZnZnWE9RVnJoQmxGdWhCUzhUQThoRGN4OXdzcDZz?=
 =?utf-8?B?Rk50cDlSN0FYUlhtaStkaEVFaWh5NS9yd3ZuN3llRmJUaVhEbCtURU9wbWdU?=
 =?utf-8?B?SHBXSnJ6WXR2OHhnOE1tVS9veEZQRzFXSUp1YVJBUlN5R1lVS3p5dytXY1NW?=
 =?utf-8?B?MXY1Vm9GUW03WEZlQnVWTXBFZ0l4NWVlVEFtZjR2b2R0NWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MU0yeW1HUk1VYmE4NEdwbGVkUVAzMFVtNmFGV1J6aVpMWklnRjJlUmtKTmVN?=
 =?utf-8?B?cDEyWUF5RDFMSmdiNkt4SmRVaTZCM29ib3JKYVdDSUNOODdiSU5FVjJqZDBi?=
 =?utf-8?B?RWpqV0t6dVFFY1FqOHNOQ1VUbS9MMlVVZXhFMnlnVnk5VnFkdmFnVUpxVjl4?=
 =?utf-8?B?REZVV0V6SVI3SVJwWlhFc2RNVUQwRHc5anczdVJ6VW5EN3hldzJHNUtCL0FT?=
 =?utf-8?B?S3k1eGFQNmo3dk9MQmxKbm13cHhrZHh5dmI0MVdhM1hSZ0FuNHJqbE96K2Y1?=
 =?utf-8?B?anY4WXo3cVAwMXVHNDYxeENBRVZqY3VLeVRnYVg5UExFSFRRSEUxYy9OUzJO?=
 =?utf-8?B?VE95WlJLeEdjV1hQRnlhM1dWK3hIS1lNeFQxVE1WaEJtTUdQNlplRXY2T3Rt?=
 =?utf-8?B?ejBtUXZDTzhBa0dHazhoeWRpU2JZWHVVampVeExSbm40dVB0V0g4dXNxcDRt?=
 =?utf-8?B?TVY0SW5YZUVXR3IrR2ZTZHdxeDVEYkhnZHB1bkdjU2NQbkhQS1dZTGpKSmp3?=
 =?utf-8?B?dWdvT2RuTDVXdjRtSDhTZThFNmxoMnQ4TVJwYWowTTJVTzNlYVU0ZGFWdUMx?=
 =?utf-8?B?SFJleWJCaFUreTRZVnFZU0VhTm9ZT0JMRkJpQk0zZnhndDNlSWdhZXo0R1Qw?=
 =?utf-8?B?ZGhZNmpud1FOa3pKNE9KVnduem5rUFVpZTAvbkUwYzczbGVFaE5IWVNWbitO?=
 =?utf-8?B?a0o0VC96eXM5VWV0VHM4NVJ2ODFhRkVNdDcxbGJSalp5KytESVRUdzRVT0VS?=
 =?utf-8?B?UGMrbzdQQzBKUnJRVHdGdTQwWUFubC9mNDRsQ0x3VmcrdEVUU2E5TjB1TEdh?=
 =?utf-8?B?VlVEaGpyU2cxaE5NSTNwbEovZkMzMmx0K3ozTklGZXZuZlY0aEZuMmFNV2Nw?=
 =?utf-8?B?OGxnNmpzU24vRGlxeUxrVnJGQXQ4cHFYU1hXMmQ3OFhVVDFpa2FzOHlRaytE?=
 =?utf-8?B?K1M0ZWxpdW5BNUxCVnlIWnpUK0cyb3UrNEhKSDh3TGlhRDZjUHo1MFRBTExW?=
 =?utf-8?B?a1dLNmlXdWZoTGtLeTFtK2V5MWxDU0h1WUgrekxwMDE5dCtFMm9CTzYzU1FP?=
 =?utf-8?B?dndwOTNXSkFPVVhRNVdJOG83b0NKOFdRNk1DQTg4VTMxSVhXUW1CWE0veWoz?=
 =?utf-8?B?eUxMdldlWXJFRm03aWt5QlVqUjBIMDhnVGthQ2x6Uk1WMU5vck5mUit0Z2wr?=
 =?utf-8?B?NTJRK0tlczFxR0lVZEZYdG4wNGp6MEZIeWVaWUl1aVEzTVlDQlNoVHFPM0d5?=
 =?utf-8?B?MFJ4QXY0NW5TKysxOWRYQXBLR2R2SGpua1lwZGRLZ2szUm83ZGRnb0JRaG1q?=
 =?utf-8?B?QkhIYS96NXBsd1BkL0ZWZWZlTjdOUE5MZWNGbW1qRS9nNGNRTWhETzMrLzFv?=
 =?utf-8?B?MjZuSm55RE5veXhvejNqbGtqQURoOTlQTi9oZUd4Ty9pTklwU1o3V3BYdHVY?=
 =?utf-8?B?bkk2aDlQVUY0Y2o2REdxTzJHN0FERXBaMUROa1Y5TXRBY3NxaFllR3RBbGpJ?=
 =?utf-8?B?TTNKTHlMb1VINFBEY3ZQbHJTclBZRjN6bTRxdER3NEhRcHNGdkw1cDluMk0y?=
 =?utf-8?B?Z2ZyNlM5RUxGN3YyMEVYOUJyNlVGMjZVZnlKczdJU0NMcUxoQVBIWmN1T2VN?=
 =?utf-8?B?akJMK1drSmgvdUFGQWozbHB0TGhQZXlYNjNHQ1RGd0orRjZJU3dpMnpuODdG?=
 =?utf-8?B?bEFac01GWEZOYzNibjBDUmo1R3dybUZWd08wbFBKbkRPK0dQZ0FNM0g4RlBa?=
 =?utf-8?B?ZFBPY2gweUZUc1lnVzhCSTc2UmxqOHlzY2VtYS9iNGx3WnAxMlp4RnVNNk1K?=
 =?utf-8?B?b0J3VWc5RXVMT09scHdQaFo5QlU2a3V0QkN2bDBKQzZPZEQwbFdHN2VVYWZY?=
 =?utf-8?B?TVdEZTRNRDZXeUh0QnlvU3ZjUWdSR1ROcjI2WnVhMlJXbEFiL1JsL21yMXQ4?=
 =?utf-8?B?azBkTkFSZ1R5RGdta3RnYWF3ejNGYUUranhtTmV5aWFpZ05NUDNkd0xxRFBi?=
 =?utf-8?B?VTRyeWp3dkZTd21oTUs2NjFvSlh6aS9DRDhlVnZlWFhJUmsxRW5NZnV0L3J1?=
 =?utf-8?B?ekF3cy9DMWw2bjg1UHNtN1paODc3TUpDV2J5NjFEV21XUnA4NThDbWVCbmRh?=
 =?utf-8?B?SzBCOUUvZU14TnRsejZIQW5rMVJ1bnNLeE9XRVk0K01OMjZScWtUMmNvQVpJ?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC9742FD38855B41ACEB7BBF0B6117FF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d46e65d-9a41-49dd-4a07-08dca1af000d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 13:40:17.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5JwsrqSbkU0XWPNS8Cq8+5KNLZzXDqmjccRFgZ3hsdy99ChLMONuvd9JPDTmq2bsz3d38KDy5fNS+1mAdAPo3IXrC2axD+Uvm3A2zHHZPSo9BO9EmUJu4zApzvp25v5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7593
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DBBPR07MB7593.eurprd07.prod.outlook.com

DQoNCkxlIDEwLzA3LzIwMjQgw6AgMjA6NDEsIFBldGVyIFh1IGEgw6ljcml0wqA6DQo+IE9uIFdl
ZCwgSnVsIDEwLCAyMDI0IGF0IDAyOjU0OjM2UE0gKzAwMDAsIExFUk9ZIENocmlzdG9waGUgd3Jv
dGU6DQo+Pg0KPj4NCj4+IExlIDEwLzA3LzIwMjQgw6AgMTY6NDYsIFBldGVyIFh1IGEgw6ljcml0
wqA6DQo+Pj4gT24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgMDk6NTE6MjJBTSArMDIwMCwgQ2hyaXN0
b3BoZSBMZXJveSB3cm90ZToNCj4+Pj4gQ29tbWl0IDJjOGE4MWRjMGNjNSAoInJpc2N2L21tOiBm
aXggdHdvIHBhZ2UgdGFibGUgY2hlY2sgcmVsYXRlZA0KPj4+PiBpc3N1ZXMiKSBhZGRlZCBwdWRf
bGVhZigpIGluIGluY2x1ZGUvYXNtLWdlbmVyaWMvcGd0YWJsZS1ub3BtZC5oDQo+Pj4+DQo+Pj4+
IERvIHRoZSBzYW1lIGZvciBwNGRfbGVhZigpIGFuZCBwZ2RfbGVhZigpIHRvIGF2b2lkIGdldHRp
bmcgdGhlbQ0KPj4+PiBlcnJvbmVvdXNseSBkZWZpbmVkIGJ5IGFyY2hpdGVjdHVyZXMgdGhhdCBk
byBub3QgaW1wbGVtZW50IHRoZQ0KPj4+PiByZWxhdGVkIHBhZ2UgbGV2ZWwuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91
cC5ldT4NCj4+Pj4gLS0tDQo+Pj4+IHYyOiBBZGRlZCBwWGRfbGVhZiBtYWNybyBhcyB3ZWxsIGlu
IGFzbS1nZW5lcmljL3BndGFibGUtbm9wWGQuaCB0byBjb2hhYml0IHdpdGggdGhlIGZhbGxiYWNr
DQo+Pj4+IC0tLQ0KPj4+DQo+Pj4gVGhhbmtzLiAgSSdkIGRyb3AgdGhlIGlubGluZSBmdW5jdGlv
bnMsIGJ1dCBubyBzdHJvbmcgb3BpbmlvbnMuDQo+Pg0KPj4gSW5saW5lIGZ1bmN0aW9ucyBlbmFi
bGUgdHlwZSBjaGVja2luZy4NCj4+DQo+PiBXaXRoIGEgbWFjcm8geW91IHdvdWxkIGJlIGFibGUg
dG8gd3JpdGUgcHVkX2xlYWYocGdkKSB3aXRob3V0IHRoZQ0KPj4gY29tcGlsZXIgbm90aWNpbmcg
dGhlIG1pc3Rha2UuDQo+Pg0KPj4gQWxsIG90aGVyIGhlbHBlcnMgaW4gYXNtLWdlbmVyaWMvcGd0
YWJsZS1ub3BYZC5oIGFyZSBmdW5jdGlvbnMgc28gZnJvbQ0KPj4gbXkgcG9pbnQgb2YgdmlldyBp
dCBtYWtlcyBzZW5zZSB0byBrZWVwIHRoZW0gYXMgZnVuY3Rpb25zIG5vdCBtYWNyb3MuDQo+IA0K
PiBXaG9ldmVyIGZhbGxiYWNrcyB0byB0aGUgcGd0YWJsZS5oIHB4eF9sZWFmKCkgd2lsbCBzdGls
bCB1c2UgbWFjcm9zIGFuZA0KPiBsb3NlIHRoZSB0eXBlIGNoZWNrIGFnYWluLiAgSSdkIHJhdGhl
ciByZWx5IG9uIGNyb3NzLWFyY2ggYnVpbGRzIGFuZCBtb3N0DQo+IG9mIHJlYWwgKl9sZWFmKCkg
dXNlcnMgd2lsbCBhbHdheXMgZGV0ZWN0IGEgdHlwZSBtaXNtYXRjaC4NCj4gDQo+IFRvdGFsbHkg
bm8gYmlnIGRlYWwsIGFuZCBJIGFncmVlIGtlZXBpbmcgdGhlbSBtYXRjaCBub3B4ZC5oIHJ1bGVz
IG1ha2VzDQo+IHNlbnNlLg0KPiANCg0KU3VycHJpc2luZ2x5LCBoYXZpbmcgYm90aCBhIG1hY3Jv
IGFuZCBhIHN0YXRpYyBpbmxpbmUgc2ltdWx0YW5lb3VzbHkgDQpkZWZpbmluZyBwdWRfbGVhZigp
IG9uIGxvb25nYXJjaCB3YXMgbm90IGEgcHJvYmxlbSBidXQgYXMgc29vbiBhcyB0aGVyZSANCmFy
ZSB0d28gbWFjcm9zIHRoZSBjb21waWxlciBjcmllcy4NCg0KSSB3aWxsIHdhaXQgYSBiaXQgbW9y
ZSB0byBzZWUgaWYgcm9ib3RzIHJlcG9ydCBhbnl0aGluZyBlbHNlIHRoZW4gSSdsbCANCnNlbmQg
YW4gdXBkYXRlIGZpeC4NCg0KQ2hyaXN0b3BoZQ0K

