Return-Path: <linux-kernel+bounces-302956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF5960586
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D231F23331
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9AB19DF61;
	Tue, 27 Aug 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VNW+U1t9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C671805A;
	Tue, 27 Aug 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750810; cv=fail; b=j+JTLUaYtBzDO18ttF49xMUdeVqZJpMPiGqTotAzWq7kAsuNhiOSncOODNyM2leko5Qu24KxkEHCmReN3e2SMU4BOTmf+kZVkRpU5fbgS8Bs7lGtlr6PC9EnfdR6ObtHmi3HLyb5JjWjokcJsVceL+q97xRgBeBpyke9H6ccNSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750810; c=relaxed/simple;
	bh=K5duU1uh9blPUlo+ETsCWzE3uY601j5qDBGN/mzvSPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=keq1hJYEpONXytnmBqHZw2hVuBLWrw6DnXRfvmj6haTykNQscP98c9hKM0JwvbUHhMyqbdX4k/EDpDfN/PtkOhGIRnYN4eX3yFORV4yKuMpIsQKwAs6gd8Pi17aOsJlltMZkwKGQ1aqMMOCQuWMHYHDBJkapmrtQMzZivA3bEFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VNW+U1t9; arc=fail smtp.client-ip=40.107.255.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoE9kDMCT9VqgUcS3QXUeUOOoa7okf2fRFbP8aqLcUI9AC+IKDx3N/km4riKbt+UobKneYJPt4KpJNc1a3G3/839199tP/hcZxn9EhUYTDXq1rvG/RwHcv2Np+I68CzZVI2a7X2lm8sYSyDkUzXmpNiavuex3/7pXpxS4hjpOV29R17ivNl/qiT4cyt/cBTSTSP9o10HcZ7zLMb/tcH1iSt1bX1ToRo6WRkse/6FSzYvzqylwhAB3Yi0YuMe2d9hH7uwsaqY18Dx2ugFhNkCSqK5R2jFLlnTijVPiHHrcwm/AWfoXFpjw7/NO7yVIFOsKCxCBp9TfpPIvOodLl8kJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5duU1uh9blPUlo+ETsCWzE3uY601j5qDBGN/mzvSPM=;
 b=ads5yWmrRip2ng9g+t2iROjspQDU7uBFLctpuoGEbJSYVKF3oDLcdr3mXrh8V4jRvEjK2mP7DIuxH8JXh23XLy0lHVo8Mp5FLzUU81bko3fJzGB2WMHgowepomgyQPxAo8XiIwibiTCj6O784D6pfInV6FlZ9LQYUS5C60PqdmxBIJpFewEeEgw83feCgL4YqjV7OCaIgLSv3OJdUw1A3CyQSfCKNRjyxmtl3oq4HM48XB22/axz9pp5I2TfEJK56hONGqlvdIIqCKEU/CJJDPnLrjnMp1Ce7h/wJoeoZA1U+NvHgmbXgtmP5nedVzQTvh6CJKWJxQZ1cKUulOJThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5duU1uh9blPUlo+ETsCWzE3uY601j5qDBGN/mzvSPM=;
 b=VNW+U1t9n0KhtVd/4tk+RQYt+o7cKAH80krzIGrlNQg/7Pg2Aroe1cA4jwaGfqpY4j/ifkGY0RNeCNtUR/ZiV0NpK4uw7YBCapJOTvcCzTEW1JYKlkeDAzDqbxLEqHB/4ygTszpsbCrKM1JBv2Pxw1bX4j52wdy0CuELzI89+uhUY3NOncJazo0YWp658DnwVYf+pH4T9npltzcDOOzsyU1h8M9PJ4lccTe5/DRRu+gQVPwUJHy9W0QmIukbbCEAe9Y+mxRmwN7fbW1Uajruj5oATFo0dh/ts5Xu+SX3EQAtidwbnhS+yV0Iyhr0Lt6zSt6mndFmI4vxXbhqetrJzA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB6641.apcprd06.prod.outlook.com (2603:1096:101:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 09:26:42 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:26:42 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjddIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v7] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr2x1AMNHz5/SWqR8iMW+/vxX+BagBmmX2AAAAqAqA=
Date: Tue, 27 Aug 2024 09:26:42 +0000
Message-ID:
 <TYUPR06MB621749D055B54BC2730310CFD2942@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217989A40FA4E18598DC694D28A2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <33fe50c8-cf98-bd04-87b7-06ec07cc9277@quicinc.com>
In-Reply-To: <33fe50c8-cf98-bd04-87b7-06ec07cc9277@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB6641:EE_
x-ms-office365-filtering-correlation-id: cd8bb2fd-8712-474b-eec7-08dcc67a5cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTdBNkZod04xc2tnWmZsZlRPM0wrU1JVVEM4NFU0eWx1VXB1Wmk4ZlN3ZUow?=
 =?utf-8?B?N3QwZ1gwR1Z3cE5XYUtkaDZpWmJxem9haWl1dStwVVVzSk9zSy9NUmpLYjZk?=
 =?utf-8?B?L1V0REJ4R1RxNElGcjAvS0FZSmVBRldueFBZWXhTNWR0MG1RYUdGY0VHOHQ1?=
 =?utf-8?B?SlJvZCtoTFZqL25DOENoR0x5MS81aFpRc2JMZzZJd3VIcThZa2lTWGNqeHRu?=
 =?utf-8?B?WFZ6Q3oxbTY4dmtXeW8xT2VEcksxNGxqRXVMMzRqbnBtUUVJRlAvZnVSNGI5?=
 =?utf-8?B?ekxpd1ptWEpSdVZqSURDZEtjV0ZoVTlVY3RaUFJUUkZETzg4T3VOTTE5c1hL?=
 =?utf-8?B?VWp1OFJ3c1BROW1UeDVqNnk5Sm4vUTU1V055RWRUQUJ3NCtlUmN6LzJ5WU50?=
 =?utf-8?B?bStnVUVQSFcyTzdEeS9USmdIZHlCSmw1dWo5WFJnS3h3dmpFd1lVM2t2UnJq?=
 =?utf-8?B?bEVBN2VCZDA5MG9VOHB1alZWNW5yMEdVT1BsY053ajZuUFhBTDNSUC9sdTRO?=
 =?utf-8?B?REJjcGRrV2VYWkpETWtSU3JxTGdSaFQ1L0tSd3J2aVhBUTIybVVyMTFwNWRP?=
 =?utf-8?B?cGJwMmJjY0hkMWVXVm80bmc4L0VkSjhEaVRZd2x0SjhJYkpZK0NXRUJJU2dw?=
 =?utf-8?B?NHp3aFlDR1NWQUJldW9oSjFCeDNaNEU5VHZFa1FUSHpmRjVibGRkcTZSdWx3?=
 =?utf-8?B?b1dPQkF6S3BUVGZpYXFMTjdINmZ0UCtsdkJwQTNvaUREQUlvOWE0OWpZMm8v?=
 =?utf-8?B?ZkxOdHpqS3BoRjh4QWJFdCtmZXM2SCtweWFGRUoydnE3RThIZEt5cmtsUXVX?=
 =?utf-8?B?OS9IUU5RMnNndHliL2dmb2IzZlF0K0dZVjZZd2VrU2E5aFJUMnhtYm5jRUgv?=
 =?utf-8?B?aW9wMWxpRlpwRGpvMEphdWxrYWFDTzZwU3MxUUtuNzhEeVAwMS9XRjM0b2NH?=
 =?utf-8?B?emhkT21XOG10L1dZU1d6YWFlVm9KV3JaQUxtZldJS0JEKzN3anBQRHZjOWx0?=
 =?utf-8?B?WlBVRE4wRkxLUE5IR0VBZUNoT1Njc0lrTkg3T0c2TDNXeWpFVjhqcURrand2?=
 =?utf-8?B?cFBuQVh5MWVyTkdycDJVUzhUZ29CaExaY21TWVBNVEhyYW41b0toM1RpZlU4?=
 =?utf-8?B?N3plMDI5UElSa1dEY0oxd2hZb2prcjZpalN1QXZ2ekRLbC96bC9EeVB5a01F?=
 =?utf-8?B?VGR0YmJVTXE5OE9ZSnA5RWVTTmtyRGlmeFVuaFNXWFB5aGswSWQycXVaTERP?=
 =?utf-8?B?U0Q0dWtHRzFMNXA1TkVDb1R5NGJCektjcFRHOEUxcWl3UGg1aWZTdVhzQkNk?=
 =?utf-8?B?M1ZBWHhoSmVnc0dha0FrSWlUczRnV09DQnRrTVdVWStYMU5nWW56aU9iTmZH?=
 =?utf-8?B?UkNnWmhDbGxwTHpXOHVHRkV0TUhvR0kxR1QwQVFIeXZaSTNRSXR1cVViVnoz?=
 =?utf-8?B?akp6czFianNSdklGU1dxdk5wVnU0RlZFZ1IrYWcvMDgrME1UODJaRzFYTE9Y?=
 =?utf-8?B?dmY4Skt5ZjM1NEpacjhLSHZ0ZENhSzUrM1FFNlBoZVBCVnZYZ0ZWYllGMy9Q?=
 =?utf-8?B?Qk84alFWZGNuT3YzUEs0NU1NZGhZOUI3UWVxK3dzbVhLNGp4OEFlanR1YlBR?=
 =?utf-8?B?TnAwRjI4RUV4S0pPQjYrNlVrbkJZV3lLTDZiai9IbkxyTE9YS2cyMXU4d2ZL?=
 =?utf-8?B?NnVmdjlFSEhvTEtMaTEyN2RlTVN5NDVvNkFlOUlrbGN6V2VjWWRQZDZVeFdP?=
 =?utf-8?B?MlZSUStYaHoxTy9GbnVTQ0ZnZmhFV1dYSmlwS2JxdFFiTUdBSWpPV0xGSlBW?=
 =?utf-8?B?SHU3Rm00SGU5OURwYVYzMEhwdHRadjJFK3BGUGhZZ0N5c0V3MnM1dkgxOXBs?=
 =?utf-8?B?MnRRbmZXd1V0L3ppMWsrTXVXLzM2b3pFOTFwYmVmNGYraWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDd1N1VpY1Y4MEdZYXhudVNJd3hBOUJxa01OVThhTnZ3TXdVVTNLaVNLSTBB?=
 =?utf-8?B?WmhaNmxPRHFweWM2VkpkVExRZFQ5dy9YSnhBSXlNS0RrTVJDWWRHU0J0WDVL?=
 =?utf-8?B?SzQ4TW4reWtFQzRGdmgxTXlxOU1BOCtpOVFIdEhKdmFEUUhSYUJJTGJJdTRt?=
 =?utf-8?B?ek1tWFFCSElFQUdEck56SnlCN0lHdUJZM2tEb1VqSTEyUFBRY2pMVUJtbDNS?=
 =?utf-8?B?L1FIVnZiR2ZuSG0weE42SUROQSt5RkZZaXlsM2h3VmtMTjl5K1pyYktUbzFD?=
 =?utf-8?B?c1p4emQ4MnFmaUp4OWFpWVBsOW1WdERXUEFVaVZEQ3ExMjBZQ1JaVFZIWS9v?=
 =?utf-8?B?V1RFbGY5UUF3aWxsRGV0dlpabHVYTkFZeEdjTjI0clpxSjB0b1VsZHFNUUxR?=
 =?utf-8?B?bHBtUzlRNVpCdHMzVzhpcmpreUIyb25vSUEwSzQ5VkxlOE9BY0poNTI5WCsv?=
 =?utf-8?B?YTJKejBTRjREVktRTEZtQXdZUUxmTWRiYkp6Mko0RE52U1NDM09OREs2Z284?=
 =?utf-8?B?NFZJRyszeEtFeFNLRUN1cVlmY0tybFZxVjhCVVZRdm94TlRWSnJKLzUyRThF?=
 =?utf-8?B?L0E4bEwrTW9VOFZkdmhEemtyVFZ5WHg4REZTaGtWTEl5TENjUXlOMVZyYjFL?=
 =?utf-8?B?bTc2SExqY0h1Y3pEWEFzMFBKYkdJNmlZYndDektCVWJSNUtqemdqRktsNXhu?=
 =?utf-8?B?bUx0TXpwTitzZytMb2dsQjBYSlZUaW9FUWViOG5WSVgzd0lEdFRlRmozN09V?=
 =?utf-8?B?TmU3WDh5WnJXdXYxWGhMSkY1SUJrMmZ6Z3hsckEzSFcwRnhRcU5SWUNYaGVQ?=
 =?utf-8?B?OEF0N1YrU3poTWV4RkJZWkE0VW1JbEZvVXpqNFo2dk52MlhBVDBtYjRXUDNV?=
 =?utf-8?B?YlZ3eEZGZlNUZXRCYVZ0R0h6QWJrZHR4Z0JFQjNtTDVqL1hwelJWeXRnYW9t?=
 =?utf-8?B?ODh6UzI2YklpODExTG40dG5YSzgyRlNOaEpSZWVUT1QrdDc0MnEweUtQL21U?=
 =?utf-8?B?aFRkeHVBOVNqRlZ4N2Z0OFMxVHZmWDNsWjZEeE1QbTRDRElEaGJYa252T0xm?=
 =?utf-8?B?OXpRNHI1TlRiL0tldHYwUnJydE16d0g5cjJycCt4azdvUkhkZWxTOVZpQ1l3?=
 =?utf-8?B?T2VFSzcybEJjeDFqWk8zb0lxZmRPd2cycEVRVzltOTVlcTFmUjNQd216QmZi?=
 =?utf-8?B?L1h3dVEwMDVtNSt0MjQzRS8ycUJlbTBkcEFycWRjSkdqUytGVnpRU3JwYTlo?=
 =?utf-8?B?Z3JNaG5EeWVWWERHNkdzdGVPU0VoQWd1VXBCbDFtRFRGVFhrSktuNFVPbHFY?=
 =?utf-8?B?NFdvbjBMWmxoS2NPUStGREFQcjJPSGtDeExFdW9sckplM1FMU2ZscXdadEpm?=
 =?utf-8?B?SEtHZGJ4OVp5Q2FVczRCb1J4Y292VytiM2wvMXZtc2RlaTl4UE51NVNFanVZ?=
 =?utf-8?B?czdCakh5czBJSWtqWmtEeEVUY050OU0zWk1xUGRraHNZdUVESm9SY2k2bFdG?=
 =?utf-8?B?c1BXeC9ONEZsNWszY0ZzODhCK2NqRGpnQXpicVpqRHJSZi9JbnJzTERNcVhI?=
 =?utf-8?B?YXpwWmhVQk5OSGNETjB1WnMrN3JDMGtTbFBuNTVBS2RwV1BEV1RzRkRpUVZI?=
 =?utf-8?B?RVE1MStJMHdjbkNiZzJtV2o3RjFjSStKeXB5YU8zWWxuWVR6VlF5VGM2RU5y?=
 =?utf-8?B?Q0ZiOFZ0UDhmTnA0U0V5RUNKdlE1ZXNvMmRaa1c1WGZqckNvRWhTSzhTbUlr?=
 =?utf-8?B?WExyMWFiWkhteTV6WG9TTWhncWJBZVRHY0ViTTQ2eG9zZlV2SjJPUS9nZkEy?=
 =?utf-8?B?UHZoMEtQWUxIb2ZIclhTNm42SHYrZ1dhQkRxOXRUTkQwYnArdXRaSW82RnFz?=
 =?utf-8?B?UHpjVW55bmxOYllXVlFtVmNsMkZkQ0thSjlpZjdmTUMyQUZaNUtqbWhIcStx?=
 =?utf-8?B?WEF6L201eW9NYmFpeCtRbXNpZmIvakNWTStNanZRU3lFcEJpSWtsTFQzVGdP?=
 =?utf-8?B?MXU5UkxIMXhMV1ovOEpVZVEyTlhQMUlVaFBIS3EyNldBcFZkejNiL21zck9j?=
 =?utf-8?B?RFI4d3dOcUgrVzRTOHFKejREMk9VVUlaT0lRdlN2R2hnK042TE5abXhCWnFN?=
 =?utf-8?Q?hl60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8bb2fd-8712-474b-eec7-08dcc67a5cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 09:26:42.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGW8wIdLXyd1Zk3TExCU2fZ/8MHq+3puYE7aI6+5XELdj2alFaSqPFAoJBTnlDJuj38o7pzR6LHCZGBOLkuTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6641

SGkgUHJhc2hhbnRoOg0KDQo+PiBDb25zaWRlcmluZyB0aGF0IGluIHNvbWUgZXh0cmVtZSBjYXNl
cywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbiBpcyANCj4+IGJlaW5nIGV4ZWN1dGVkLCBnc2Vy
aWFsX2Rpc2Nvbm5lY3QgaGFzIGFscmVhZHkgY2xlYXJlZCBnc2VyLT5pb3BvcnQsIA0KPj4gYW5k
IHRoZSBjb250cm9sbGVyIGhhcyBub3Qgc3RvcHBlZCAmIHB1bGx1cCAwLCBzeXMudXNiLmNvbmZp
ZyBpcyByZXNldA0KDQo+QXMgbWVudGlvbmVkIGJ5IE1pY2hhZWwgZWFybGllciwgYXZvaWQgYW5k
cm9pZCBzcGVjaWZpYyAoc3lzLnVzYi5jb25maWcpIG9wZXJhdGlvbnMuDQogT0ssIEknbGwgbmVl
ZCB0byBzdWJtaXQgdGhlIGRlc2NyaXB0aW9uIGxhdGVyLg0KDQo+PiBhbmQgdGhlIGJpbmQgb3Bl
cmF0aW9uIHdpbGwgYmUgcmUtZXhlY3V0ZWQsIGNhbGxpbmcgZ3NfcmVhZF9jb21wbGV0ZSwgDQo+
PiB3aGljaCB3aWxsIHJlc3VsdCBpbiBhY2Nlc3NpbmcgZ3Nlci0+aXBvcnQsIHJlc3VsdGluZyBp
biBhIG51bGwgDQo+PiBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGQgYSBudWxsIHBvaW50ZXIgY2hl
Y2sgdG8gcHJldmVudCB0aGlzIHNpdHVhdGlvbi4NCj4+IA0KPj4gQWRkZWQgYSBzdGF0aWMgc3Bp
bmxvY2sgdG8gcHJldmVudCBnc2VyLT5pb3BvcnQgZnJvbSBiZWNvbWluZyBudWxsIA0KPj4gYWZ0
ZXIgdGhlIG5ld2x5IGFkZGVkIGNoZWNrLg0KPj4gDQo+PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCg0KWy4uLl0NCj4+IA0KPj4gRml4ZXM6IGMx
ZGNhNTYyYmU4YSAoInVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIpDQo+PiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVs
aWFucWluQHZpdm8uY29tPg0KPj4gLS0tDQo+PiB2NzoNCj4+ICAgLSBSZW1vdmUgY29kZSBjb21t
ZW50cw0KPj4gICAtIFVwZGF0ZSB0aGUgY29tbWl0IHRleHQNCj4+ICAgLSBBZGQgdGhlIEZpeGVz
IHRhZw0KPj4gICAtIENDIHN0YWJsZSBrZXJuZWwNCj4+ICAgLSBBZGQgc2VyaWFsX3BvcnRfbG9j
ayBwcm90ZWN0aW9uIHdoZW4gY2hlY2tpbmcgcG9ydCBwb2ludGVyDQo+PiAgIC0gT3B0aW1pemUg
Y29kZSBjb21tZW50cw0KPiA+ICAgLSBEZWxldGUgbG9nIHByaW50aW5nDQoNCj4gV2UgdXN1YWxs
eSBpbmRpY2F0ZSB3aGF0IGhhZCBjaGFuZ2VkIGluIGVhY2ggdmVyc2lvbnMuDQo+IHY3OiBSZW1v
dmUgY29kZSBjb21tZW50cw0KPiB2NjogeHgNCj4gdjU6IHh4DQo+IHY0OiB4eA0KPiB2MzogeHgN
Cj4gdjI6IERlbGV0ZSBsb2cgcHJpbnRpbmcNCiBPSywgSSB3aWxsIG1vZGlmeSB0aGUgdmVyc2lv
biBpbmZvcm1hdGlvbiBhY2NvcmRpbmcgdG8gdGhlIGFib3ZlIHJlcXVpcmVtZW50cywgc28gdGhh
dCB5b3UgY2FuIHNlZSB0aGUgY2hhbmdlcyBpbiBlYWNoIHZlcnNpb24gbW9yZSBpbnR1aXRpdmVs
eS4NCg0KPj4gLS0tDQo+Tm8gbmVlZCBmb3IgdGhpcyAnLS0tJyBoZXJlLCBqdXN0IGxlYXZlIGFu
IGVtcHR5IGxpbmUNCiBJIHJlbW92ZWQgdGhlICItLS0iIGFuZCBjaGFuZ2VkIGl0IHRvIGEgYmxh
bmsgbGluZS4NCg0KPj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwg
MzMgDQo+PiArKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAy
OCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgDQo+PiBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+PiBpbmRleCBiMzk0MTA1ZTU1ZDYuLmU0M2Q4MDY1
ZjdlYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nlcmlh
bC5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPj4g
QEAgLTQ1MiwyMCArNDUyLDQzIEBAIHN0YXRpYyB2b2lkIGdzX3J4X3B1c2goc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KDQpUaGFua3MNCg==

