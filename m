Return-Path: <linux-kernel+bounces-354495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B620F993E49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD31F2459B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509613AA3E;
	Tue,  8 Oct 2024 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="IPcGI5/2"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4811DA5F;
	Tue,  8 Oct 2024 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364836; cv=fail; b=kES75Favg91E00JEBZ3ZshCQOmsfi4KryoltCVw+dUjMvGVswwGfx+oicCLhvuA9LfpmCS+4y87XdV0g5S7+MrDgHppIzvc5bGt1sP7CK8GyonAbxjVpba0+LW2WWpyEvBzg1Wd/tyYTD3F7vfvcgEzISpUHoeCC2LQ9CZOJRBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364836; c=relaxed/simple;
	bh=+wW+gq4ebro47WCLbSRYU0yTWakq0pw4JUzJ0M5u4wI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PousQYAhLMwc/DZzduVK4sdqOwas11xotGwuwbPMfIPKu4/HE7LKMpbdwQ7EArnfs3XzDwR0Pd3XtNfoFatw/a80YvYrE4rQaGeMImKdICA/gfzQas83/dTcGMu+V/Z7xwTMLnLp3OxYDuPELOudaGgQ7KwRp4TTsuEPLxZJlZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=IPcGI5/2; arc=fail smtp.client-ip=40.107.42.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnvQPcE7XGt8NROFhwhhQn7zkATciAKfr5oZQ7KevgJoHSFQTxKYYKaHNeYony1czGDgA7i3V3yORz8FBNy6A8JyCEh6knyzHMkHXmOVE63QGQWXc/Hq6oNUARo0ypOeEOwovHYj7nU6TuBYQ3KIhdAMJLXoF0LjQebTQ4OgbxbaKsfljYF8qgWffmka9UTsQ00MbSwvJUOEIutSB7So605PmzrJJZQgQv+Pbu/DYDMoOUHVt1+bTCzUfaSZruXuS774fv/uBa6DFwzD2jMAAOHFOfLCdIFRBocUFBSlnufgugj2xYrfd2urpFMs/WyyoXUNnmKuyeXoei36yI+hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wW+gq4ebro47WCLbSRYU0yTWakq0pw4JUzJ0M5u4wI=;
 b=ptflh1FFvR0gaA2qgSyDcZQ4MkK/ylny9YAChJHcU4hhie75pFK607b2n0pNeNnknS9lB5AbeXa461anxJPLx+FdqukZe1z2x4arezPtsnqYVq0AXNR+3NW2Z8k2SNdEt9b5Te6c5++xVT206AEqOi6HP2LAkV1KxlQyIFaoksNjyoNTZ8f4AY5MNHY+5YTeCpPY/j8jYRFjhsr4yvpfllWjSbGgzNrytYSTy1sDFC8TuFIcH2im2TUBL0odG3XHQKWWkPG/h38+u30ITAKFPzUyVY2J9sMYZQsk5ra2M3u8S6l3gz7aYQUDX8nrokt0IgYtgYHphEdpFTm0e4htpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wW+gq4ebro47WCLbSRYU0yTWakq0pw4JUzJ0M5u4wI=;
 b=IPcGI5/2p41KBoJ4S5GfP3PkpImNrd5o7Z79JeaMihD26ZzcbUinFXyZ+EiOwY7KJYCOfSPo5K/pLZH+nZCVwU4Xx7ijldaMY2Dw7Ddrz/UimZKlxnhOgsfxougTzZ69MX3Uwgy9vZvZgoo50pHbBIL2bshLIK8mxEFsnNGFcVA=
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::5)
 by SEWP216MB3074.KORP216.PROD.OUTLOOK.COM (2603:1096:101:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:20:30 +0000
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::abfa:51df:7a24:2f06]) by SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::abfa:51df:7a24:2f06%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:20:30 +0000
From: =?ks_c_5601-1987?B?KMfQu/0pIMDlwM6x1CAoxMTHu8XNsPjH0LD6KQ==?=
	<ingyujang25@unist.ac.kr>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoc: uniphier: Handle regmap_write errors in
 aio_iecout_set_enable()
Thread-Topic: [PATCH] ASoc: uniphier: Handle regmap_write errors in
 aio_iecout_set_enable()
Thread-Index: AdsZQbQXQbGLNJdMTXOtViVq1iaTHQ==
Date: Tue, 8 Oct 2024 05:20:30 +0000
Message-ID:
 <SE1P216MB2287962B462AE91B26248D19FD7E2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2287:EE_|SEWP216MB3074:EE_
x-ms-office365-filtering-correlation-id: 70bf8c1d-31fc-433c-6fe2-08dce758ed58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?RWFvT0pObzJVWUIyQnVQbWJoaUlKNXNLQ0dDR0Q4elFTa2x4WVV3?=
 =?ks_c_5601-1987?B?dlpuZy9yMTM2Ykw1SnE4UnE5SUlDUkptN2h5RTd4TTEvNkFUZ09L?=
 =?ks_c_5601-1987?B?aFMrVnZNc3YydUczS2lZSklGSFRqNUhZQXRWZUU5MHFVN2JJUjZO?=
 =?ks_c_5601-1987?B?czNvS0w1SkdZRFFvam4xcDYyV2c2VnlGWGlDS1Y1TXB1QjVHejZq?=
 =?ks_c_5601-1987?B?MUdIWXBpc09wZXJVYU51UEtsSXl5Z1dxcGFiV1BublE1NEFDMW9Y?=
 =?ks_c_5601-1987?B?emJuSmQ0dW1TeTNiZFkrKzJqZm51THNLVExSZGFNWEhDYkFYb3R0?=
 =?ks_c_5601-1987?B?UDdTcWtraFpXNlNHMS9nc25MczMrUEVpL1lBSGVsQnZ5TU5oczN5?=
 =?ks_c_5601-1987?B?OEluOGowMzhTNWRPNzJpYmdYbGgrS0ppdVJ1YzFYNGFpY3FxbGpQ?=
 =?ks_c_5601-1987?B?b3o2cEtBdlFHbjd5WmhrTlpjaXlYOWxNNXJvQWNHK3oyRTc3a0Ji?=
 =?ks_c_5601-1987?B?QXNJWHh6MXlCT2dlaVFoWDAxY2NSQmszam82RHk4S3ZjRjlKbUcy?=
 =?ks_c_5601-1987?B?NlpjeUFIOHlaaVZMZGtjMUsvN0VQb3A0ZFRnakR1R016dVZ6TGQz?=
 =?ks_c_5601-1987?B?Y3BCMVZ5MWIyemRaWml4UFNOSEtnZFBYWllFYzhNclhZaVNQOFFH?=
 =?ks_c_5601-1987?B?YkVPT1B5a3BIRHZ0KzRWd2lDVnJFVk9RbWxxNW5CeVdUdnh0RWh3?=
 =?ks_c_5601-1987?B?ZG4wK1dJZmlLbXhudktZQ0lTcGltKzdrMEh6aTZzNkJvbHBNWmFs?=
 =?ks_c_5601-1987?B?TVNlaVN3SGhvQUcyZ0hDYnI2L0lMaTlLNzlLdExsN0ZDc1E3b2hL?=
 =?ks_c_5601-1987?B?R0s1aEM3UGhTK1gwRWVMV3Rnb0dCYUtjMDdMUDlHYU00ZXhHb2hN?=
 =?ks_c_5601-1987?B?OHZiQWk2RzFYVVhDSEErQVJNZHB5ak14UjdhYTdGblFURFJsSnNC?=
 =?ks_c_5601-1987?B?OCtDUkdMcENPRFhxK2RqTkpsaTArd25PRFVVVld6VHh4MDRZT2xF?=
 =?ks_c_5601-1987?B?TnFyc2xOV3FPQzRSUlpDbmxlS3I3cVJUM3h2V1dVYmJVTUV4a3Vk?=
 =?ks_c_5601-1987?B?OExQcUlYNmsxdGNHS2JSU2VyaFJNTWxYWEVoYURRR2JBZWtIRnR0?=
 =?ks_c_5601-1987?B?YVdiUDZIaVpEQVNHd3FQRXRHWFpZUk1sN3ZsZWtPYmJ0UXdjdXVM?=
 =?ks_c_5601-1987?B?a2ZQUUpLYkdReDdkYjB0Q281aTIvZml4SnB1ZjRCOHRVNmpHMktv?=
 =?ks_c_5601-1987?B?cmh4YklpRm9keCs5YXRscFoweXVOTnhSdEpFVE5Mb2RkMUxuaG9I?=
 =?ks_c_5601-1987?B?a2g4Tm5uUm5jTlpCSlhKQ2s0TlV2Y0tEaW1NTVhCSjBLR2crVzN3?=
 =?ks_c_5601-1987?B?aDBTb055SndXc0JwWTIzajJLekJmaHRNS1Y3K1M3ZWFFRmlwNVpZ?=
 =?ks_c_5601-1987?B?Nk5HWVVNcUc0QjR5blcreERjK25KOXdxVSthZi9JeGg0V1RXdDhs?=
 =?ks_c_5601-1987?B?ZkdpSDNSbFVNTzI5SnN2NEZKT2Z2QVlOMXdEbWlwU2VIVTQwNmdS?=
 =?ks_c_5601-1987?B?cGU1dEFLMmx5dTh4d3BTRWZZVGdXSVZsU0NKNXhJcFc5cFhoQmJX?=
 =?ks_c_5601-1987?B?N25kcEl6ZlBEb2N0Yk5KQW1pcjZqWHU4bGhiK2VLbjlYTTRGcjlF?=
 =?ks_c_5601-1987?B?OTZyM05DdDI5emNLb0g0VWJ6dGkvQ1p0WVRDVGRibkVVSmFvWXpj?=
 =?ks_c_5601-1987?B?ODVKZzQ0UFNhbDUxMnV2U0dSdXZ2L3BhdnllcGZSdkNyU2I0anFP?=
 =?ks_c_5601-1987?B?Q3B3Q1ViM1RxQWtqZlBoVGJleW5IWGMySjA3SW1ORXBDelBCdEth?=
 =?ks_c_5601-1987?B?UjFqeXRVcVVZS3YxdVhiN2tZOFpYMlFQc0RXQWtHMWdldnArdkov?=
 =?ks_c_5601-1987?B?bFd3NGh2cEtGTHJQNlhGSUJiM0JkV3JHUDNCUklIMGpZVHhCMnZM?=
 =?ks_c_5601-1987?B?NHZTOVdHZDYrQnBwNFJVV2ZEbGtrazlHK1Z5Ylp0OEsrU1Y3bXFp?=
 =?ks_c_5601-1987?B?UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2287.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?eFVkZExiTHBSbXpMZzdaQUlDRnlkM2NTTTh1a2VqLzZ0Qlp5dkdz?=
 =?ks_c_5601-1987?B?UnhtWFlMVU1lSk5EUjJSQXVzVDRVNDhLWThjaGU0ZlRBYXFvN2h2?=
 =?ks_c_5601-1987?B?ckFFeGtmVVNSay9FVFlrZkxZL3BnMVN6Y1JIRmdzNXczY1VYb3Vk?=
 =?ks_c_5601-1987?B?MDh4UFhYa01KbStNajE1YWFDWTI1cEh2SUlpQndGOWp3UjZzMUlQ?=
 =?ks_c_5601-1987?B?Rm50TnVBMjg4S29meE5jb0xJaWVDUzhXbHpuQmg2Tm42RUkraVdC?=
 =?ks_c_5601-1987?B?WUVmTjcwK2hGUm5RTjlFVTFWV3J1TmFVYWZxMWhRV2NQam1qblhl?=
 =?ks_c_5601-1987?B?bWlIWWVoUklnVy9WcFY2R1N3UmNqV28vTExuOExsaVRCRCtjWU5h?=
 =?ks_c_5601-1987?B?RytSVVRyV1U3UU9EY0E0dktZLzdodnhpN20vYkpXNmJKcWZVbE9q?=
 =?ks_c_5601-1987?B?bGRSQ2FJMERnZklqL29PcXp6bVVwS3dyMTRIK2FsTDk2anBXcC9Q?=
 =?ks_c_5601-1987?B?SitnV0ZZN3ZjSm1ENlZhSUtoamFQR25wVGJYLzdqYlFWL2pLUWs2?=
 =?ks_c_5601-1987?B?QkFMMzd5TE5FYmFQa2tHK3BPbTBKazhuWWQwbnR3a1FLUStxWnBP?=
 =?ks_c_5601-1987?B?c0tGVmc0U0tROG5kRnJRampRN1VpNGlVd0gzdDNFMmp4ZTdnZW5X?=
 =?ks_c_5601-1987?B?N050ZmJNUUs3MU5Zb3poTWVNZUFtdG9xOEphN3NySFRCQmVyWHA0?=
 =?ks_c_5601-1987?B?cysvbG5LenZnb2Y1T0d0dThDN1drU2ZtNWMvSFdEcEtFNHFjQ1ZV?=
 =?ks_c_5601-1987?B?eFVPUWZWdUVvUEdYS1ZseWlIWk1FZ2ljbmFQUnNZWGQ1aUZsMW5G?=
 =?ks_c_5601-1987?B?dktyek9EdlVqZThnMWV5S2lKTFNQUmFrZUFScGRBSGVlVjFFeFdj?=
 =?ks_c_5601-1987?B?cUFXM3J0V2N5VW9pR2pBZ25HQUEwMTJra0RzUS83cFhNcFZLQjRh?=
 =?ks_c_5601-1987?B?Yjl4R3VBMm4waVZtcXVRdmk0MkZmYWlnMVpFQ1k3M1pXNmR1Rngw?=
 =?ks_c_5601-1987?B?WWUvaVN2dFM0MmV0MXZOaVB5Nk1wWkFSMENRcUtkNWxqTkxhREsr?=
 =?ks_c_5601-1987?B?TGdNMnMreXJDQ1hjU0Z6bGVEckhQZjZ3WXpta0xIOHo2dmFoUUF4?=
 =?ks_c_5601-1987?B?SU5kWlVqYklxRzNUbFYyejVSUnhET3VNNlpHT1hsS1NqMGp4Y3Ur?=
 =?ks_c_5601-1987?B?UXBBUXl1bDBJRHIrMC9NeUs4VDRzNVBmOGl3NFlNaWduMW9ZWVJZ?=
 =?ks_c_5601-1987?B?QWNWY3Fzckc0bFgxWUgwM1c1M3VPZHJrZkdOaGVvaHRWSGdDN1BH?=
 =?ks_c_5601-1987?B?a0wvNXEvQlVncFRLSHhVcDlRNTdmRSt6OGYxMVRJdmREa3ZndWdD?=
 =?ks_c_5601-1987?B?S2d1cm12VHVoM1V3ekpKbVZWSGtBZnpQajdmcHJSQUx5RTlFZGpw?=
 =?ks_c_5601-1987?B?NlpreFlvcVp5R2pUbDBzeHlEVklzYTJXZ1dmTENHWW5NMXlIYk5M?=
 =?ks_c_5601-1987?B?ZnduSy81dTdqTEZCcENQR3ZWQTduZDhwZVBIM1prcElxaHR1ek5T?=
 =?ks_c_5601-1987?B?Uk5aTk4zWERjYzVXR0xNaHBDdStwU2RIdnJrS2hOb1U4RG53a3Ir?=
 =?ks_c_5601-1987?B?VW5QZ1JJTDRLWG5LeVlyWTZ3VTFFbE5HMjVYaWMwVVJrcmtkOFdQ?=
 =?ks_c_5601-1987?B?YkIybjBVbStqNjRmQWRhcUVPcE13bUV4bFQ2Y003M1pZTi9jb1ZO?=
 =?ks_c_5601-1987?B?akN1L2ZkaTdOU3JMUVFPKzY4bWdzN252M3lSdTIzTXlmSHZDdjZx?=
 =?ks_c_5601-1987?B?eTcyRUhYSzYyLzNmbDVNNGhsOFpYcnJyL1p6RmpYRnhSOUl6bmdS?=
 =?ks_c_5601-1987?B?amdLcm9qT2NaNkRPTXlpdVlZS0tRNWpTdEZiVExNUmNNUElsYzNG?=
 =?ks_c_5601-1987?B?elF5VkdYaVBpWi9CTmFpNElhS0ExVnpsa3g2VnlrRE1IS2hwSC9z?=
 =?ks_c_5601-1987?B?dXRBb29WdFVYamVSdWxUZFJsQ29RVU5hSjJZcHFQQTdqdFZUKzZE?=
 =?ks_c_5601-1987?B?ZlFZclhQR09JVmNFNE9hbGhFQ08vU0g3ME9NMDF6TVZKSnJlR2xG?=
 =?ks_c_5601-1987?B?Y2RMOFRCR2cxS2QrbHB1cjQ4Z0R1dkpValhSMVRJUDVkN0tzYVZs?=
 =?ks_c_5601-1987?B?MDB5Nnc5N0tCRnhKME9TdEF3Yms1NFNnNW9xWXhMVkRCS0JWMTVk?=
 =?ks_c_5601-1987?B?UFcrNUJPN3VUYUJiZ2RFOXVaalA2UkQwOCtLVER4Q01KZWkvbUMz?=
 =?ks_c_5601-1987?B?U21EUVVMKy9NR05xTzBmV21DYmRrMC9aWjNpNFYxK21MZE5vb2g0?=
 =?ks_c_5601-1987?Q?Xys6eSyDqVTvDOoPjCkT/80CE/qPOmly2vdY+H20?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bf8c1d-31fc-433c-6fe2-08dce758ed58
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 05:20:30.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlLJKIg/o1rjEWMNNS5gqQiF7Wi1i71g4dr1D/g7vq/LeBudGMGkx1p5PRWdUSRTt52INevQNcsTmKtDweiiJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEWP216MB3074

RnJvbSBhZTUwNzk2YmVhYzQ0NzQ2N2U2ZWNmYTA5YmY0MGFjMDJiOTE0ZTQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSW5neXUgSmFuZyA8aW5neXVqYW5nMjVAdW5pc3QuYWMua3I+
DQpEYXRlOiBUdWUsIDggT2N0IDIwMjQgMTQ6MTE6MTEgKzA5MDANClN1YmplY3Q6IFtQQVRDSF0g
QVNvYzogdW5pcGhpZXI6IEhhbmRsZSByZWdtYXBfd3JpdGUgZXJyb3JzIGluDQogYWlvX2llY291
dF9zZXRfZW5hYmxlKCkNCg0KVGhlIGFpb19vcG9ydF9zZXRfc3RyZWFtX3R5cGUoKSBmdW5jdGlv
biBkaWQgbm90IHByZXZpb3VzbHkgY2hlY2sgdGhlDQpyZXR1cm4gdmFsdWVzIG9mIHJlZ21hcF93
cml0ZSgpLg0KSWYgdGhlc2UgZnVuY3Rpb25zIGZhaWwsIGl0IGNvdWxkIGxlYWQgdG8gc2lsZW50
IGZhaWx1cmVzIHdoZW4NCmNvbmZpZ3VyaW5nIHRoZSBhdWRpbyBwbGF5YmFjayBwb3J0LCBjYXVz
aW5nIGltcHJvcGVyIGJlaGF2aW9yIGluIGF1ZGlvDQpzdHJlYW0gb3V0cHV0IHZpYSBTL1BESUYg
d2l0aG91dCBhbnkgaW5kaWNhdGlvbiBvZiBhbiBlcnJvci4NCg0KVGhpcyBwYXRjaCBtb2RpZmll
cyBhaW9fb3BvcnRfc2V0X3N0cmVhbV90eXBlKCkgdG8gY2hlY2sgdGhlIHJldHVybg0KdmFsdWVz
IG9mIHJlZ21hcF93cml0ZSgpLg0KSWYgcmVnbWFwX3dyaXRlKCkgZmFpbHMsIHRoZSBlcnJvciBj
b2RlIGlzIHByb3BhZ2F0ZWQgYmFjayB0byB0aGUgY2FsbGVyDQp0byBlbnN1cmUgcHJvcGVyIGVy
cm9yIGhhbmRsaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBJbmd5dSBKYW5nIDxpbmd5dWphbmcyNUB1
bmlzdC5hYy5rcj4NCi0tLQ0KIHNvdW5kL3NvYy91bmlwaGllci9haW8tY29yZS5jIHwgMTAgKysr
KysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvdW5pcGhpZXIvYWlvLWNvcmUuYyBiL3NvdW5kL3Nv
Yy91bmlwaGllci9haW8tY29yZS5jDQppbmRleCAwZWJhNjA3NTgxMzQuLmQzMzRhNWEwODI3MSAx
MDA2NDQNCi0tLSBhL3NvdW5kL3NvYy91bmlwaGllci9haW8tY29yZS5jDQorKysgYi9zb3VuZC9z
b2MvdW5pcGhpZXIvYWlvLWNvcmUuYw0KQEAgLTgzOCw2ICs4MzgsNyBAQCBpbnQgYWlvX29wb3J0
X3NldF9zdHJlYW1fdHlwZShzdHJ1Y3QgdW5pcGhpZXJfYWlvX3N1YiAqc3ViLA0KIHsNCiAJc3Ry
dWN0IHJlZ21hcCAqciA9IHN1Yi0+YWlvLT5jaGlwLT5yZWdtYXA7DQogCXUzMiByZXBldCA9IDAs
IHBhdXNlID0gT1BPUlRNWFBBVURBVF9QQVVTRVBDX0NNTjsNCisJaW50IHJldDsNCiANCiAJc3dp
dGNoIChwYykgew0KIAljYXNlIElFQzYxOTM3X1BDX0FDMzoNCkBAIC04ODAsOCArODgxLDEzIEBA
IGludCBhaW9fb3BvcnRfc2V0X3N0cmVhbV90eXBlKHN0cnVjdCB1bmlwaGllcl9haW9fc3ViICpz
dWIsDQogCQlicmVhazsNCiAJfQ0KIA0KLQlyZWdtYXBfd3JpdGUociwgT1BPUlRNWFJFUEVUKHN1
Yi0+c3dtLT5vcG9ydC5tYXApLCByZXBldCk7DQotCXJlZ21hcF93cml0ZShyLCBPUE9SVE1YUEFV
REFUKHN1Yi0+c3dtLT5vcG9ydC5tYXApLCBwYXVzZSk7DQorCXJldCA9IHJlZ21hcF93cml0ZShy
LCBPUE9SVE1YUkVQRVQoc3ViLT5zd20tPm9wb3J0Lm1hcCksIHJlcGV0KTsNCisJaWYgKHJldCkN
CisJCXJldHVybiByZXQ7DQorCQ0KKwlyZXQgPSByZWdtYXBfd3JpdGUociwgT1BPUlRNWFBBVURB
VChzdWItPnN3bS0+b3BvcnQubWFwKSwgcGF1c2UpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJl
dDsNCiANCiAJcmV0dXJuIDA7DQogfQ0KLS0gDQoyLjM0LjENCg0K

