Return-Path: <linux-kernel+bounces-212671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BF90649F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D1B1C22D38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885421386A5;
	Thu, 13 Jun 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WD6FZFu5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FB13792E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262672; cv=fail; b=KAiYKnvQjo/obvXEcLyJ9QLw7jVZi62pi8kErqmfH0KlH8ZkbVs21KYl7P7/xs+Hyt9WOVgPbM7/qDT7Jds4UGbMSVTZSOw01G3TVpEXs4pEDFgv6kfIP/66ThP5adCzTzv88hqJzNOha8xeTgF9497tdd9unHoINIQT4MugxtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262672; c=relaxed/simple;
	bh=uOAZ+aC+649rgfca9MVD9ygcR9KiL7TZqwb07hYx8cM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNZAMqF2ubA7ImesyoTqljx7h9TnEnplKb5ZmRyavzgoQw2HJbyvo5YoKop0tpLomfVsbVSojzrnjnlUJ0CyA4VMwYQlC9gl8HNi1XwgsrDUzUD4P3+Dsqh4l50pOsqg/FxizPBOXS3pVsQc60R8zwzhPoRFhnZSYfp/dz9Twvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WD6FZFu5; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZWXkmNwbSSehT9R0M/7IJfOZqf1OF/thn/N2yyxdmjExvPjjGkMB1zv7UohKuwtF/y968QMHlTl9x15p1WceZIFZ29ojarlr+gTebpHFeXCZshlLX53uFybYWE25RQwm4TeT6zhZ6aijEtijMn2uIB8+BwBKpZpjE8wS9gK2NYRagGyE6MCAwSovx24uXKH7lbLxwPhkMIoweBKDBXLMVsJ2Zb/9RiS6OWYGX6LnxLMukm0gNUrcPqPXxsW/EmOlNUMwSSO4/Un8SjL9uTq983DNzj1bwQk+d1HBgPG30uCLiuqMA/ruyLjEuHRN3yTXx80vn8W1KGeN40fUKMbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1ac7VH7sYOm/3Qn1ffIyoxpwHf7K48zGfJwQgiv2J8=;
 b=RRGsmkqePw3nXIUplwr8fBxt/rcm6bXBuZGxxV6T0KmH/05NSqtSRE+XyP9LunlvmaaeTnluqWjnYdDBSF1VZgjJuP6+0X75O2QdWClSZAse/bOPf6kB7sIAvoGuY8oKR50jQs7pStyzr4X8cFsJODyW6atkYuPXLY8LwIkBOrkcFFypnCZ83ZsDjIjULA+N9XHIpUI9d5H7DSRV98Wyo8MeboNTKNJj1tXiqH+uu+ub9PLp9p852yHkfs71NwQVuIFsLoXFi8FnClMGGunE8dnijoPTFQIBU03h+6EI1BW3U4tKG7F2shqpU8rMlTO8FHJJjwj09+zhMqS0Zvur2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1ac7VH7sYOm/3Qn1ffIyoxpwHf7K48zGfJwQgiv2J8=;
 b=WD6FZFu51PUUpTjeTKdeImlsy/DPuwGJKzq4b25fx1Cdv1RDoAAFP+0QgHpXMDP5nhKBxUCWt4W8G2xbC3QSL9962Mcb2h2ogR6LxLoMpgEQxLdbK/rpsNY+SkFJI1zWqLho6pkjMmWS1k/tyxvukcUj6CkRTlvuv1Gq99DJK+M=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 07:11:07 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 07:11:07 +0000
From: Zhai He <zhai.he@nxp.com>
To: Barry Song <baohua@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang
	<zhipeng.wang_1@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, Christoph
 Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index:
 AQHavKBGxUJQI1jHm0WeihrG1yRS87HEeMkAgAAvWICAAE1E8IAAFNsAgAAdaCCAABFDAIAAAPqg
Date: Thu, 13 Jun 2024 07:11:07 +0000
Message-ID:
 <AS1PR04MB955988579ADFC6B5CCC8BBB3EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
 <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
 <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|AS8PR04MB8642:EE_
x-ms-office365-filtering-correlation-id: 4146864d-53c5-40a4-a3eb-08dc8b77fef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVNub0orcTcwQWdQYmpSd3IyUWNrQmpoM1A0bnZ0S2dlb2N6dVZqZkUwSnRI?=
 =?utf-8?B?aCtXUU51VGI2Rjd1a0NSenJGQS92dUtwbWFVL3hFRE1jQzFzN1F0Vk5qNHE1?=
 =?utf-8?B?bWV3TVcxbHlvaktqc0RVSmxXL2RaTjFDWjVuSS9rWG9NcXNTYXdJMjZ4Wk5s?=
 =?utf-8?B?eS9CYjE0UE1hblhXWDkvbUs3RkZYUlI0T25QdjVORVV4VkZ2b0lnMGRtRDhl?=
 =?utf-8?B?UHM0c2lJYk9yaERNNDUwVUErN2RzN0x5VURYOWxWbUtpeWM5MFhBSlM0a0h1?=
 =?utf-8?B?N09KeGRYWURPRmpDVmZBTnh2dlpZR0hHK1hkNVN3dDF6U25WZzlxWGh5Z085?=
 =?utf-8?B?M001YWFjNGp6dC80K3g3RGFncFllRndBZVhhMEZaNUxvV0dEY2IvTjNmSHhi?=
 =?utf-8?B?R3ZXZ01veE5IZzBCWFVpUXhRRlZ1T25CcVZwbE1vdkdOUXBBTExEZEI4eEdK?=
 =?utf-8?B?MGRZWVE3OGUyYWpRUVpuSGhLQ0twWjd6NFlnbzBubjhGcEVuYXZLdWU3bE5n?=
 =?utf-8?B?Z3NuQlJGcnZVVW1JNFdLU2J0eGM3MURKQzlaUm5HOXdoMEpmWDRPeDN4am5h?=
 =?utf-8?B?RXJ5M0lza3Yyd2dsQjZLVnhGZmU0OFRjSWRDTGppcENOTVpSNERZL1dCRTFl?=
 =?utf-8?B?d0dkNWlmeUVRUks4a2duZXFWM0xYQzV5OWJDSDVqdVJLK3JjaHo0dE4zdkp6?=
 =?utf-8?B?N0pud3dRcTYyU2QySVNwMGY2L0dFU09mNkcyZzY5M21KWHBoNGpCbTVybWVJ?=
 =?utf-8?B?REltcStJL2R5SFY5RTNrQWJQOE5FcldYK2trQmVrTmhhajhFRG5RN3d0V1pp?=
 =?utf-8?B?OGpiQnJNZFpvbStqNElsMUFYZHVoREY2SWYyNmVqdW5LYlZXMWVjYjJ1aDFr?=
 =?utf-8?B?SnRCRkNLbVgzY0lzOE9oZ2xmaUR6WjhweXAzK1J6aWxzeXFaNTg5ejloR05R?=
 =?utf-8?B?VXZHZGtDalRhTEJRMWI4ejVXbTYvYkNZenpyU2E1MkNNU1pSU1VCaExlQ2Qw?=
 =?utf-8?B?QUtNdit3OEQ1VzhuRVNOaTlmbHV4ZkNpcFNROXA5RHQ2ZDlGY043ZDBYQWJi?=
 =?utf-8?B?VnZJV1VSbnBxdHhEck56RnJiVTRuVGVORlJRc3RtcXFBZnUwM2JjVUZraDJZ?=
 =?utf-8?B?SmFLTHgrRGZ1UjdSK243MzZIbVNLU2RPV0JQQjRUZzRhbURTRW9QSEJrYmlq?=
 =?utf-8?B?K1crSnlaaSszMk9tdkVwZ3BjRXRwZVdvT1p4TWd2Zk04Y1N6VU4wbWRWRDVH?=
 =?utf-8?B?SXpZaEFTTUdvOUhzTGs2d0ZoU0MvV3dXcFVRTVpSdm1FakMwVVc2VGJ0U1dw?=
 =?utf-8?B?a1ptUjJFY2wvd0N2N0hZWEdzbjJ0SmRuVVJtcVRKVkVMbG9aNzVmWEZ1QVNu?=
 =?utf-8?B?Rlc0ZUNueTVTd1p3N0J5OVdRRDdDOEZGd1lwTVJBWnZjSFprK2RuNEJQK0ZL?=
 =?utf-8?B?aVlrRWFUUFhERWxIZXhBQjJ0Vi9oWjNSOW9QSU92OEw2RmdMVi9wUUNLamx0?=
 =?utf-8?B?ZXFlTE42am9aTldMNmQ4aFhZZUVQcFZLc0ZyVkN2WjZITHltMDNsOXEySVpz?=
 =?utf-8?B?YW9HcUFzSlE5M2tXMHRvc0RPQVh6Q0ZHazErQVVRM05pbSsyMlJyQjVqd09S?=
 =?utf-8?B?SDB3aVdERWNUMjVmd1dTZSsreTlQUnNtU2ZVd25lM1A2VyttbFhrbHJMaVpB?=
 =?utf-8?B?SnY4YnRzcGUvVmh2VWxMaEZIbkplZnFvMG5YTEUxM1p0ODRDbEE1ZFJhUFhv?=
 =?utf-8?B?MTFGMFlaNnJ3VEEzcVJPekphNVkwN0lEVy9BdStUV201cFI5YVZiNTVjbW1B?=
 =?utf-8?B?VUh6cVY4dk1WakdNa3F3OEVzTmg1QTllUUxvZ2V5OTZoZzNxK3o4ejhoQkpm?=
 =?utf-8?Q?im+EFV+n3hg5f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3MyNjlmdnkrRDNTM0VtSVd2Nmdzc2tWNHMvbnFmd091Y3dkeHZwclNVdWor?=
 =?utf-8?B?N0JvL01pTm1OaWQ2RnpVSGIrYmlwUUFaZTMrbzNXSVBnZjZBV0NDeUpsTVVt?=
 =?utf-8?B?Y1laWkVjVnRpSkZ3RUlTNmg5OE1xRkhENHlYSXlWR0hWR2kyZUhyVkdVSnVn?=
 =?utf-8?B?SWxUQi9EL0V5cWI0amVQaTBJTUE4VlFVb2Uxdk1PNExLQ0tkK3lZbWNxYi9I?=
 =?utf-8?B?UmVhLzdRZmFLQnJlcStrMnhBTFdiTHBlR0hSVUluMkhJRzNJdWc4RC9QZFBp?=
 =?utf-8?B?ZncrYldLR0lGQkhRMTJDR0tOVlFYMVVLWlkrZDYrSHVOVUw5RzZDWDQzaVZI?=
 =?utf-8?B?WFhRNi92MTlPTDlvYUhsdnNsTy9vY0htMWRadzdXbGpUelh5a2tONjVkSjYr?=
 =?utf-8?B?VnFoclFQZ3Z4Wk5NRTJWengrdzFIbzhHTHVLa0JEbG1GZnUwM25naUI4NHNB?=
 =?utf-8?B?M2ZubW1ZenQxNGJ5c1JwcThzNCtzeGpQNkticDFJdDBpS3JNeDVTNW81dlpp?=
 =?utf-8?B?dFppcmh5byt3V1k2ekNRYTRFVWN2a1ZlL2lGQVV3bCtuYlprL1F5VTNFTVk1?=
 =?utf-8?B?TDRRTVN5SUppNkZRVjBvSG8wNzVMZ3hwUjQ4aitFMERJQzJVTjJacTZ0cnl1?=
 =?utf-8?B?UTV1OHFjR2xiZ29mKzNIV0QzL2tlYjV2Sis5WGN4dlI0QTNWdndhWkNZeG5D?=
 =?utf-8?B?cjRkTzVlRG5qQXVEVlN1bjlyeXY1M01uaDcwaHJvN1l0RU9XYUhsZW1jMDc4?=
 =?utf-8?B?OWpMeDJFbWx0ZklkeHVUN3FkYzh0MzdLM0R1R2NkRkNyYmw1YTZHUXU2WjlE?=
 =?utf-8?B?dUpWMTBkdDhFYVRjK2k2WGRpQk9PZ2VIdTJtRnhabjF3K2lSTzRteVVPYmV3?=
 =?utf-8?B?VUdmck1JQlJjU0RpYmJGWXF4NUxWellLWHJ1eEErcTdQT0prM282NzAyWjFE?=
 =?utf-8?B?T0xHdFk2MHpYUFExcG45WnVxYXBmaFpWdks0QTU4TUZCU290RlRVWEVVYUQ4?=
 =?utf-8?B?WTNMa0RSVlI5SjMwSCtacWRyL2Ewa2ZXQlRFdHRSbDNPZzd3K2V0L2EvL3pQ?=
 =?utf-8?B?ZkJtVnRkTnZzS1VYRWpBbHhTUVFvbWpVcW9yK2labXIxV3ZTZTlhLy9RQnZl?=
 =?utf-8?B?MWdsYWNVNDJZa0hxOVlpMWY0Qk50Nmc2M200STJPcENJZTRDdjBvZ2s1OHNO?=
 =?utf-8?B?UFBMWUtyeGhET1c1VGczeEdKcCtyVkJZS2dja2I1NENpN3A0bkR6RWtlVFdH?=
 =?utf-8?B?TkxFQ1pDWFJoZ1pxQm4wMjhxNWVlZVRNSThjM3JEWHExdUZyN2hQK21nenhC?=
 =?utf-8?B?Tm9zRVcvUWZsTzJNUHVTaS9HelpMUjV1V2R0Tzk4UG13cnBwNDVVZUFVVlB4?=
 =?utf-8?B?WHd5dHdlOXNBYkQ4UVF3cXRRb3NISG43c1czdG1LMW5JSW5LWmFCWHlveEk0?=
 =?utf-8?B?a1hsSHp5TEIxbjAvYnp4T0VQalVKNzV5SjhJTzlrbE1xeEo3aXBBRkhhRW80?=
 =?utf-8?B?Q2o1aVhBSm82S3pUNnZQY1NVYzUzVEt1Y3BkSHZ4SjRjR05udExUL2Z0WXdm?=
 =?utf-8?B?WEZhUEJaQTNSKzl5VXdQTS94aFlldWN6VUFQSHBwR2VUa05Pd1dzZG9nbmNm?=
 =?utf-8?B?WE8ydUhnT0JMRWdmNmVzZU5nUTlucUZ6M3JTd0czN0dESUVkUitzSCtlZEdq?=
 =?utf-8?B?UWZVMjRhZExndFlaamtCVmlSdVpjK2NJRE9VeTRVd243UEVkays2UHpidE84?=
 =?utf-8?B?QlMvRjgyYkI0VUc1Mjc1U2JSZVNkVWtsNmdYQ25UZTQ4RjN4NHFFckJuY1Az?=
 =?utf-8?B?eklvd1hQdjdZMHhNNWtZZnJrbXRkOWZpb0l0UEVGMWpheUJTZXh1RVpEUkIr?=
 =?utf-8?B?SkthSHc1YXFKdjNTRDdRVG9GRmxtSlFOZkdjcThpa3ZpUlIyK0pDWXlyMmhD?=
 =?utf-8?B?Wmp2ZExjQkRlNWo5ZzhMU0IyUVp4T2o4Ry96dWRpY09UL1ArZWIzdDEyWkhN?=
 =?utf-8?B?TG1GcGp4OS9rbERHT214UFRNdXVka0Vad1RBRlBsdmxqbzhqT0dtSHpPMkRn?=
 =?utf-8?B?ZXlSRk1ZdCtoZHJ1cDZOL0toNS9Md3k5YlJMSk9vY05vY0Q1MnpjRDhsOUVO?=
 =?utf-8?Q?Tcq8=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_01A8_01DABDA3.E8AC8430"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4146864d-53c5-40a4-a3eb-08dc8b77fef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 07:11:07.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjF4vrbu+eSBFISb/Jp4NUAZSA4cLHa3fZ5GV4s/HxAwfpOnb/2Pwxa90bKIRtSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8642

------=_NextPart_000_01A8_01DABDA3.E8AC8430
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Barry Song <baohua@kernel.org>
> Sent: Thursday, June 13, 2024 2:15 PM
> To: Zhai He <zhai.he@nxp.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> Hellwig <hch@lst.de>
> Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when =
the
> device-specified CMA memory is not enough.
>=20
> Caution: This is an external email. Please take care when clicking =
links or
> opening attachments. When in doubt, report the message using the =
'Report
> this email' button
>=20
>=20
> On Thu, Jun 13, 2024 at 5:32=E2=80=AFPM Zhai He <zhai.he@nxp.com> =
wrote:
> >
> > > -----Original Message-----
> > > From: Barry Song <baohua@kernel.org>
> > > Sent: Thursday, June 13, 2024 11:28 AM
> > > To: Zhai He <zhai.he@nxp.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > Christoph Hellwig <hch@lst.de>
> > > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA
> > > when the device-specified CMA memory is not enough.
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.com> =
wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Barry Song <baohua@kernel.org>
> > > > > Sent: Thursday, June 13, 2024 5:37 AM
> > > > > To: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org;
> > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> > > > > stable@vger.kernel.org; Zhipeng Wang <zhipeng.wang_1@nxp.com>;
> > > > > Jindong Yue <jindong.yue@nxp.com>; Christoph Hellwig
> > > > > <hch@lst.de>
> > > > > Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA
> > > > > when the device-specified CMA memory is not enough.
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report =
the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > > > <akpm@linux-foundation.org>
> > > > > wrote:
> > > > > >
> > > > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" =
<zhai.he@nxp.com>
> > > wrote:
> > > > > >
> > > > > > > From: He Zhai <zhai.he@nxp.com>
> > > > > >
> > > > > > (cc Barry & Christoph)
> > > > > >
> > > > > > What was your reason for adding cc:stable to the email =
headers?
> > > > > > Does this address some serious problem?  If so, please fully
> > > > > > describe that problem.
> > > > > >
> > > > > > > In the current code logic, if the device-specified CMA
> > > > > > > memory allocation fails, memory will not be allocated from =
the
> default CMA area.
> > > > > > > This patch will use the default cma region when the =
device's
> > > > > > > specified CMA is not enough.
> > > > > > >
> > > > > > > In addition, the log level of allocation failure is =
changed to debug.
> > > > > > > Because these logs will be printed when memory allocation
> > > > > > > from the device specified CMA fails, but if the allocation
> > > > > > > fails, it will be allocated from the default cma area. It
> > > > > > > can easily mislead
> > > developers'
> > > > > > > judgment.
> > > > >
> > > > > I am not convinced that this patch is correct. If
> > > > > device-specific CMA is too small, why not increase it in the =
device tree?
> > > > > Conversely, if the default CMA size is too large, why not =
reduce
> > > > > it via the cmdline?  CMA offers all kinds of flexible
> > > > > configuration options based
> > > on users=E2=80=99 needs.
> > > > >
> > > > > One significant benefit of device-specific CMA is that it =
helps
> > > > > decrease fragmentation in the common CMA pool. While many
> > > > > devices allocate memory from the same pool, they have =
different
> > > > > memory requirements in terms of sizes and alignments. =
Occasions
> > > > > of memory allocation and release can lead to situations where
> > > > > the CMA pool has enough free space, yet someone fails to =
obtain
> contiguous memory from it.
> > > > >
> > > > > This patch entirely negates the advantage we gain from =
device-specific
> CMA.
> > > > > My point is that instead of modifying the core code, please
> > > > > consider correcting your device tree or cmdline =
configurations.
> > > > >
> > > > Because we enabled secure heap to support widevine DRM, and =
secure
> > > > heap requires security configuration, its starting address =
cannot
> > > > be specified arbitrarily, which causes the default CMA to be
> > > > reduced. So we
> > > reduced the CMA, but in order to avoid the impact of reducing the
> > > CMA, we used a multi-segment CMA and gave one segment to the VPU.
> > > >
> > > > However, under our memory configuration, the device-specific CMA
> > > > is not
> > > enough to support the VPU decoding high-resolution code streams, =
so
> > > this patch is added so that the VPU can work properly.
> > > > Thanks.
> > >
> > > I don=E2=80=99t quite understand what you are saying. Why =
can=E2=80=99t you increase
> > > VPU=E2=80=99s CMA size?
> > Thanks for your quick reply.
> > Because we added a secure heap to support Widevine DRM, this heap
> requires hardware protection, so its starting address cannot be =
specified
> arbitrarily. This causes the secure heap to occupy part of the default =
CMA, and
> the default CMA is therefore reduced, so in order to avoid default CMA
> Shrinking introduces other problems. We added a specific CMA area for =
the
> VPU. However, due to the large size of the secure heap and default =
CMA, There
> is no remaining memory available to increase specific CMA for VPU.
>=20
> I assume the secure heap you are referring to is a section of memory =
that
> should only be accessed by TrustZone and not be visible to Linux =
running in
> non-secure mode. How do you allocate this secure heap from the default =
CMA?

No, secure heap is a reserved memory, secure heap is not allocated from =
CMA, secure heap has been reserved during the kernel startup phase.
And this reserved memory is protected by hardware. Only specific =
hardware and secure world can accessed it.
For example:
&{/reserved-memory/} {
        secure_region: secure {
                compatible =3D "imx-secure-ion-pool";
                reg =3D <0x0 0xA0000000 0 0x1EF00000>;
        };
};

> Do you use the cma_alloc() APIs or the dma_alloc_coherent() APIs? =
Given that
> the VPU has its own device-specific CMA, why is this secure heap =
allocated
> from the default CMA instead of the VPU's CMA?
>=20
The VPU driver will use dma_alloc_coherent() to allocate contiguous =
memory. The secure heap is not allocated from the CMA, but because the =
secure heap is enabled, it occupies some contiguous memory, causing the =
default CMA to be reduced.

> If this secure heap was allocated before the kernel booted, why did =
the
> kernel(your dts) fail to mark this area as nomap/reserved to prevent =
the
> default CMA from intersecting with it?
>=20
Secure heap does not intersect with the CMA.
for example:
before secure heap enabled:
0xA000 0000 ~ 0xFFFFFFFF: default CMA
after secure heap enabled:
0x9000 0000 ~0x9FFF FFFF is the CMA specified by VPU,
0xA000 0000 ~0xAFFF FFFF is secure heap, (the start address cannot be =
specified arbitrarily, because this memory is protected by hardware, if =
the start address is 0x9000 0000, uboot will use this memory, but uboot =
can't access this memory because of hardware protection. So we find a =
section of memory that UBOOT will not use as secure heap.=20
Note: The memory of uboot can be adjusted, but avoiding the secure heap =
will limit the memory range that uboot can use, causing problems such as =
the uboot stack)
0xB000 0000 ~0xFFFFFFFF is default CMA.
So default CMA is reduced.

> >
> > > It seems you mean that only in some corner cases do you need a =
large
> > > CMA, but most of the time, you don=E2=80=99t need it to be this =
big? So you have
> to "borrow"
> > > memory from the
> > > default CMA. but why not move that portion from the default CMA to
> > > your VPU=E2=80=99s CMA?
> > >
> > This is a method, but because for VPU, the continuous memory size =
allocated
> by the driver is based on the video stream, we cannot determine the =
maximum
> size of memory required by the VPU. This makes it impossible for us to
> determine the size of the specific CMA assigned to the VPU. Thanks.
>=20
> I don't understand how this can happen. You should precisely know the
> maximum size required for the VPU based on your multimedia pipeline =
and
> resolutions.
>=20
We cannot estimate the maximum contiguous memory required by the VPU =
because it depends on how the video is encoded.
Thanks very much.

> I still don't understand your scenarios or the problem you are facing.


> Thanks
> Barry

------=_NextPart_000_01A8_01DABDA3.E8AC8430
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
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

------=_NextPart_000_01A8_01DABDA3.E8AC8430--

