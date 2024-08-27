Return-Path: <linux-kernel+bounces-302971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB39605A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7228482D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7E19D88C;
	Tue, 27 Aug 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VXrKKfho"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066719CD17;
	Tue, 27 Aug 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751132; cv=fail; b=kPVBG5N7gDJqMYaeEWmsKitolZPcjuGre++LLof2en93oSs1J5d2Vk8NXlMn2qas0LO3wRbVUa9VQP4P76U26anG6ZuU/QfAGeQ/Jce8bePJiTdjKJaSE9bb5a3OnZ9uvRfF3L19685LeTBI41wHCjJPM7jhQ2mWuGMIht8ADcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751132; c=relaxed/simple;
	bh=TR7gBE1o5IPZFCBeKYZBHgOGir+qUjEVulWOI4pQWEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BbAcGkOy+/q7ZqDbrskkvplaRpv1jbJfvdKcz0K4S7yhF2GKCz9g3+bij1tK9y3O9JXeFLEizAPcPmp3TAP4G+pdz3tigvUn+MgL3fTe7ZKh6lQS7BX+WY45hr95r+pMAD814D+Tq4vlsgt4KiJPRZ+xckxdqXGj62UnfcDPrF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VXrKKfho; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWJn53yiv7U9xOQFpB0Mcim7YEDN86hQeKnFZGLYw9C/bJhSmjrVx+pL0+oIX8ixXvaCeU4xHA3X9dPeLYeT8ymaObxG2YaCP37IvXTzNOmkWSSSz1r8crZqFdHQNPVJunIQkzj1Vn9uxLzZ0ioScklIDHe3A0Xcd8uwQAd8d40hTNX6ceruQUSKPh15clZqxFhfwiCw2T+i+uzgrVKLqrtiZIB5UCcSY4B6Dm4C84VDS8Z3sXz+fInO5fxNVYQF19p4sqw7sOlOpI/x+EpuDhDio5cUzwsiylOckUXz0ToBbxt3yZVE9hzjq3ZHwv0cRjcGJ4ykGdVxD5adeyeYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbAt0ZSnALDLBb9NsfNASINDD43gVC8MPsuXB90wqb0=;
 b=aRIk7xBxwGp9UY+6eVUo6E3SVVBpQIsw0XLF5YbWzMxp84gBVc5if2G4eY8GzndBKFAeYiHOOsst1FuGmN7DJC2ofVEFCZoQvKHeNrAc2n7M3gAMuGkElNhC1vkvnGOmIXeHxbXShaLK6j1jFYkVkiUdZnATbQaJR02M6MSYalgDsanNzZDAQtNZ9hno+OC6dmeMgKtOQtqrr/bb4tJUQlTcU9ZGV6XxN4MtX2EsuKwor4rvMZDEIT1ciFo3v60sokOgkgquWD+5gR6Ok2xuYINhYHsvHoFHj1FJ9Qv1WiU9JQ88V3k7CjERLViiypXMQAxOR5vi+Eq4+Yf9zxQbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbAt0ZSnALDLBb9NsfNASINDD43gVC8MPsuXB90wqb0=;
 b=VXrKKfhop56iQOUpr3XtHTyP6ewrEZsY2/H2s9wBTrTSPEhuK9bFpxnq54ZJCCDH9Jyk0ZJWRq8zkATivcdf3gu3OGfqaqbJJkjKBQ2qSON75LsHTvw01YVoHBFauV5eQuI5sJ7Fq8u75NYqhiDRUCHKtbC6L9j6SreLN9AlTALMlG+E1JJde8Niy/SsK2ivfzbmA1MYOqgprt9lhm8+jsc1gW7glkfWHjFKNDH/DSJkxirvPrIHP7s2C0Cen5owp8w0g9QGJ/WW4Xy3CVidy1pKXkyDvY0hGCkVNjdGgtARTeFHJ0OQ1zIWKJIT8anwo+SS0XlD2bAQT2iYepUhuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:32:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:32:04 +0000
Message-ID: <2bb6b337-d83b-4cbe-aff2-bbd0c7d17c2b@siemens.com>
Date: Tue, 27 Aug 2024 11:32:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
 <6c28d580-9961-4bac-adcd-1724de68c9fb@siemens.com>
 <0ca0fc20-421e-4bbc-bcda-9e5c2ea3b1b4@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0ca0fc20-421e-4bbc-bcda-9e5c2ea3b1b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3713:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e4c6a6-f1f5-4e0d-15b4-08dcc67b1cbd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmxpcUZZOHJBVklCS2MxNW9SakdUVlNiMGExazV2Wmw1ZW5CNUhUWTZQeVVr?=
 =?utf-8?B?WmYrUUtVQXJGTm14KzAxc01GTXRRQ0VsZS9vQzdaQ1l4Mkc4RUVGWlo0UnJF?=
 =?utf-8?B?Vi84c0c3TkRjUmZCa2dPSkhmNXdMYmZtVzc0eWkwcDI3V0l3U0NWTDcwVTNt?=
 =?utf-8?B?c1dXdmZwRzcyWWprR3hFKzZ3UUNmSDltSGJSOHVneVRObWErdlNiSnNydXZY?=
 =?utf-8?B?RjB3SkI2cUx0V2oxVnNpZWVZeXFQbnJIT3NLSDZDRVQ4eG85dUpTVGE4SHk4?=
 =?utf-8?B?R0ZaOXhWZm5UOHhoQ3o3SG9vOXAvMk5RbDlENzVySVQ5a0piWmJWeE5OSDU3?=
 =?utf-8?B?aVdBeVIwU2tDa1hibnZuV3o2cjFtbmRLU3lGNldEMUFCS2xqK09ROUo0Skd4?=
 =?utf-8?B?elI3NVcwejVPS0JyYVdkRzJtcS9LRDQwMUtWQ1VXWWpsWDRqQmNBZERTTm1u?=
 =?utf-8?B?UmdGL0gzYStrb0I2UktqbDBQcnBBUWVOMkhETlFqODhpNGlEZHZ4bk5JelRS?=
 =?utf-8?B?aGR1SjlCajRma1RDSE5zSUYvMVd3RU9XMHlvZzR4aEQ5S0R2ekpTMG9nZkdr?=
 =?utf-8?B?bG5vSVNJSzlvNC8wZWNRVFFDYUYxKzBCKzgzSzRhZ2NJdDZqUHZibmkrckJi?=
 =?utf-8?B?WGUwNk5vdjIweXdqYTltTUY5d1NoVXBhdTFwR3F5Zk04S0NlT1Z5amxMci81?=
 =?utf-8?B?VGZBWFVyaVlXa2ZMdFFFZGx6U1RsTUs0YmcwU3NMWE5KUk9kL1RQQkUySEw0?=
 =?utf-8?B?M0pvdjArZm9vT3dxWWZCbE4zSzg2UWdUY1JTOStuNTN0b3BnbVNYeGJUTm9n?=
 =?utf-8?B?azIrcUFWSVByejZ4YXZxWjM1QUNTYnBETzZJSGFUd04zbFRkQVlpRXZvL3Bi?=
 =?utf-8?B?VEpZWUp4Z25IWTNpeFdKSDBZV1BZK2EzUmw2QnRwUzdWK2dLc1cvVzQxRnA4?=
 =?utf-8?B?aW9ZMmVOSmxRaWxMaTBYZnhBVktrT2l6eGhSY3pFQldWWWhVK1cwTnVPMlFP?=
 =?utf-8?B?ZTlaUjVUUjZ4Y0M1cjlxZFhpYXRQYlE1RjQyMnVMenBUVlVwdFZDdnJoWmZq?=
 =?utf-8?B?aUpTcWpHQkU0NXZhaXI3QllmT2ttczljTTY3VnNiMkJUdHMwSytBbWpTNWF6?=
 =?utf-8?B?aEY5L2loVXlTMmxLLzJoNTFRcE04dTdjbmpPSzBOczR4VUcwT0pOaXNLc0Zm?=
 =?utf-8?B?S1N4bHArK2kxc05OQmZJS1g1b1VOODVlRkhjeWRFZXZsa0w3VzErc3Ria0NJ?=
 =?utf-8?B?SVZXNkxTbkpKWjNiZGRKcHFncW52N1lvVzhZeWE5SFZhdEd0RXhxa2VtWkVr?=
 =?utf-8?B?ZFBrMG1PNkRuZ3htTEJ6Mlpxa2tGOUVObjBKakY4Ynp4bzJVenBBUFNFbmI1?=
 =?utf-8?B?NFFndEhlUGR1SWQwZWpHaXZSVE5YMGk0ZDRDaDZDY1NKcnEwZkluQjVXUWpS?=
 =?utf-8?B?c2xBdUJTY0REeXNmNkIyYVZXVVVIakpjdDhzWHI0WENKV1BaQ0trVTBuaHFa?=
 =?utf-8?B?ZHBEUlhoaitTcGtYdWlnZUdVNE9ObGlPQ1pKZWYyNjRFaUs1aFordWM5M0Fr?=
 =?utf-8?B?bmJ5WlE4RGk1L2hsV1I2OGRSSm5lQXdEb3dobElzU3hjNnNKaElXMzZ5Qnhx?=
 =?utf-8?B?bjl4b3FZS293MC9UNkN4bE1nZ3N6ZjVzbU1PV01uRHB0UGVCWVNxR0UrNi9Y?=
 =?utf-8?B?b1hPUjJmY2FVdnhGSVEwbktmUnNhYy9Fek5uK3BtWHI0L2loL0t3ZkNrcTU0?=
 =?utf-8?B?em8yZXlscjFGZTBheHlPU0xJSnVSbGNJRUh4djRyWmhVd0xFT3A3TVIwV1dM?=
 =?utf-8?B?azRqdkVnTzJ5SWhScXgrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVF6QlVsS0FlaG9OVmdkSU1RYlVNck9rU2JVOE51TTJTUENReDV0b3psMjFF?=
 =?utf-8?B?S0hKZnltVkNPc3FDOTJ0eTVxUVdESDgvM2QzNkk2MGVDOW5JdWZwUFhPM25X?=
 =?utf-8?B?bkp4eXoxMUNNOHhnTnhZNVJhSTgydEl5WlluYWVkYm5PRDBzV3drNUJFZEtz?=
 =?utf-8?B?M01qbzRNcS9YMnV4djVranFadGVGU2R6Syt3L1hoTEd0Z1VUZjBvQUo4RkdP?=
 =?utf-8?B?b3REa3hsWVk3K3E2bW1CbDBBRkE1cGVJSzNyQ1hadGZVMEVmekRjS1dUTVhl?=
 =?utf-8?B?aHgrTGtMTjN0TlowWm9MSUwvYTJtYWJVVTVUUjZyQng0eWdiRDIyemNTa0JI?=
 =?utf-8?B?enBTOGRxalRveDE2ZzZiUk9qTk1XZytVTTdHYWptTmV5aUM4NHFtc2pERUlD?=
 =?utf-8?B?QWF2ZnFkS3pSS3ZmUU5XR3FHU3RQeXFQT3pNWFZnby85SDc1bXRZaUcvMHl3?=
 =?utf-8?B?RE1JQjlGMmtiekVJZXlMQUlPaU5qSnFSL2ZOU3E1Z1BVS01HTmcwaWJjWEpN?=
 =?utf-8?B?S0k1Y2xKbVQrNDdlN3dsMjRIU3dnSlZVWlZ0UzNoQ3Rla2RPZlJrQ28rYy9q?=
 =?utf-8?B?ZGM4U1NVQjl0WGhSSUhXek12cWswd3hpTzlCNngzV3BqMlRNYmZDQXd2bWFV?=
 =?utf-8?B?ZFhMLy9uRUlQdkhOMm9QdlZzOVZNbXhiY0JLalJZZlRBaEdxZllUdHUzSG90?=
 =?utf-8?B?NktaNTFRNkJSZ3UxaUxTaXd6dndleXBwQ09ySzNCeGdVbmlLZWk4RThMdUtZ?=
 =?utf-8?B?anl0TFJyb0ZyaUxsbVR4RDVGQU5Tek1jUUVNTlBvN2NOdlVXRFppamFGNm0y?=
 =?utf-8?B?anNzQ3BmSnk2YlYweHI4Ri81RTlOMXJ1S09LWnZsQW43N2ovSkRUcWE0N3dO?=
 =?utf-8?B?bXVkaUIvK21WYmswZ3FyN3R0NDE0K0tpZGxsRHpFV001b1k1WVh0enhuS3Ji?=
 =?utf-8?B?ZCtDTVQ4eWtxdy9WeHVoYVhQVzFMdnAvZUNXMWRSeXRJY2FhT3l5T2tRTTQ1?=
 =?utf-8?B?dWRveCtZODUzTVgyRzQzcmVIbjlJbFg1Z2JxeHBtcG5ROWpUSzRaTjBiWnhG?=
 =?utf-8?B?dStsZ0VUM25lU0k4eW50L1VjdituNy9QMnY1MmhoTFZJUUM5MGlhZUlBNlM5?=
 =?utf-8?B?ODhjam4zclJRMlgzNjQra29lMlpjL0wxd3RDNlVLaWdkMmVYS2pWQlNKb2kv?=
 =?utf-8?B?UjNZR0VOc2xZVWN6c1V1bUppeVp6MmpuWmtMUTd6Nnp6aC93L2tzTW5Mb1pT?=
 =?utf-8?B?ZkNwV1FzY1NLNERIQURHTm1vUUZVUmY4M0ZMYmp6azh0TmNxTkZ1ZERNVStB?=
 =?utf-8?B?TEJaaldRNFJEYjZYUHhPeVNoMzc0a0ZRTnNON3Jjay9yMUR0K0E3a3piY0o0?=
 =?utf-8?B?SG1pK3p3ajd2YnhFS0gvbStpMStaSnVkbVp1RXpYWmxDdEVYaEtnS3JXdUJZ?=
 =?utf-8?B?NlhFTWJETUh6YkpEUUhISVhJRjM2Z3AwRnB1N1dXTlFJV0t2Q0FvcHEvcURw?=
 =?utf-8?B?by9oemYwbTJnbWhtbGY5SlV3aUhmWERwTTJJc0JTYkVXMXBhWTQ0Z294NnlL?=
 =?utf-8?B?alBFRjY5Q29HcDFBRk9rME9tbWlUQktyTXcwWkFzN0hjcGNIcG1yRm5sMit1?=
 =?utf-8?B?d0JsRUlQZ1FlR3RKY2N4REdyanR4VXU0UG5RbEY1RmVjcTQrYnBDVTExT25n?=
 =?utf-8?B?TVhKUlJZYlhEd0FhR3kvT0ZJb1pHM2luZFJkcEZWTUZ6aVgvY1JBRVJvWTRR?=
 =?utf-8?B?cEkrRU5kTnIxL1IyaGpVK01PMWtHakxCdFBISktXMGZHQkM1NEV0Rk05ZXRE?=
 =?utf-8?B?M2NHNzl6R2UvWlVKWlBUMEk3T1NQQm9wWkpxelNqVm53N2k3S05tbFlUMzlk?=
 =?utf-8?B?UkxoVlIzVUg0M0d0UGh6V1BkOVBzRk5hTDZYcGpsaytWK1RPY0RyR2dEZmZm?=
 =?utf-8?B?Qzc4bXp2ajVleVVBYjJtZUVhb2NraW81Z3FXTFVFeWlldG9jNnpwY2E1cktx?=
 =?utf-8?B?MkpiQW5iVzhiVlNFQlh4UlJlRkVEOGtXN1o3N2w5OXU1WVpOYmd1eWh3TDlp?=
 =?utf-8?B?QmZhb3BOcGJHaUxIbUlBY1o3SlFVdi9wWThKUTUxanYzc1NrTHBUS0hqNmRQ?=
 =?utf-8?B?ZTZGZGFGMXpNby9Cb003L1laNE1LUWR4L1E2ZmdxaDdwVklrQ01KZGxSMVdt?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e4c6a6-f1f5-4e0d-15b4-08dcc67b1cbd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:32:04.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP5bSK0ldRqmNaYS3VMJ77pty5XIj71QHh+EJJKjwnu/39pWlwFLNu/3Ytxag4BBYyq8pBvFunGCKVNzO2+ITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3713

On 27.08.24 11:29, Krzysztof Kozlowski wrote:
> On 27/08/2024 11:22, Jan Kiszka wrote:
>> On 27.08.24 08:37, Krzysztof Kozlowski wrote:
>>> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Describe also the VMAP registers which are needed in order to make use
>>>> of the PVU with this PCI host. Furthermore, permit to specify a
>>>> restricted DMA pool by phandle.
>>>
>>> That's an ABI break without explanation why it is necessary.
>>>
>>
>> It is needed in order to support the PVU, as written above.
> 
> Above say only that you want a new feature and that's not really
> suitable explanation for ABI break, because answer to this is: add new
> feature without breaking existing users. But maybe there is a bug or
> something does not work or never work or there are no users, don't know.
> 
>>
>> Previous versions of this binding likely didn't consider this use case
>> and therefore didn't describe all registers associated with the hardware.
>>
>> BTW, if you see a way to add the required registers without breaking
>> more than needed, I'm all ears. At least the kernel driver will continue
>> to work with older DTs when you disable PVU support or do not add a DMA
>> pool to the DT.
> 
> If there is no ABI break, because driver still handles correctly old
> DTB, then mention it in the commit msg.

Well, this is strictly spoken not a topic for this commit because this
one should have no clue about what drivers do with DTs according to this
binding. But I can put a hint and go into details in the driver patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


