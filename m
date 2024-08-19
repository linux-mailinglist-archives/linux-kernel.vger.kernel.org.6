Return-Path: <linux-kernel+bounces-291800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D504956715
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E886828369A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD815EFBC;
	Mon, 19 Aug 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fBWCZMSs"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5715ECFA;
	Mon, 19 Aug 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059890; cv=fail; b=qvpGtICCaAtY98lnLd+pJxXlHm0wTiyy1sbA/T7oS+IOBia9CEyHer5EHsLSjmbVlfnh+f8kLQx2M4bBieuYwXgSJx35rjo49R/7g9BKfzh80Oc44ec/TOLOpQRjXzOQd5W4zaDPJfott/AmVat6ohw1mhUbTrDAehuqLrinnfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059890; c=relaxed/simple;
	bh=4aB/DiiFQEn1L1sCzCJ8O1uEBSjkbd7Mln4VwuIIyrk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fp60htHh29rqbzQJuSMQCy9GP6L7TAdmqLxu6cnwrxw9PcHfmOg9WXn+kwa1DCAoOl8HVvvHu3r5bAQ4F9sJS5XIQDwu5AG5vm9WCyyMk4UP92fIoCpCU6L6xsvqClYkawluVlzpFg9eSUdsCvhooJ2EkeiiW5xeo/WSdyE/Omw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fBWCZMSs; arc=fail smtp.client-ip=40.107.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1aKKWi0wgWipOL82viTJKmg+z72RkTifGQ5mEkLSFUsMhhMvmiUo/tAD1oE7F9BuUcy6Y1xBTP8DMNXZwv04JeKe8OVlE+P5HpmABww+O++ieN0O/v9MlxBOXg1UMZJn4TVthyriAvxSrK21LtEiPy/b85jfrGkodgu6bjAr0U6QOVy/ODMI5ADIK7UV0oYSS9CUISp4Sf0rtDtR++ynprIjy0PohrNlC+2h8Gpz+43sP0JwU4fqhL+64QyHCz47XVtfB6EhenLSpUErPHfSFDIr6fQ2M/sXKcEwxOSRPC/dmU4tNj2y72OPGjqOFQS1wQFHKYKHmA9Wk3doGAQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aB/DiiFQEn1L1sCzCJ8O1uEBSjkbd7Mln4VwuIIyrk=;
 b=rifKWPeRMkiwQ8/29ScBKi8+EtA9TSQvdSEBDBFzAcccacX13B1R89Ix/vHDVZTNvzEZ2k4Gvjv/pjG9Sn1ohx4VlW9HQKvibQhdFfLbqvU4oY66YCP0mVZ+2ULmPQ8rKYROS/No6StvhyX27paa6/QvSbjlwqTJabORJcmZLVLJ7yabjl5Rs9fNEONEgV2Jlf9S/4jk2r/pKh5GWav5yexqOPjetNnZ0gKWs7AwFPv9rJa+GlS2RxXZwNvyq/nJNW3tbgzkqA5Hj5yskKdYKCtddNtEMKyfdg630ZgJINQ2zMTD41V/T1Rm5ijdXANbUSeXRZQupvP6+4xfgdmHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aB/DiiFQEn1L1sCzCJ8O1uEBSjkbd7Mln4VwuIIyrk=;
 b=fBWCZMSsA1R/UHBdrqBDllq2kWSNovEhqcqUaV7TD4M0w88QxwbM4zTOcOCljXRL1y0edMYKMI8IP3lNqN6LCtPVwMNs+38/6zlFmgi1ukPpm1AjsvalILJzSACu+VdqQEXHgcxiK+gnsrkjv6xkC85H94+KdPnGcqlam6axEWBacoRv80i077ZXzQTUp4prsgkayOLvPUuJUFDOw2eh9Xa+F3LRoin8T9cz74gxFOwlvcslbOlhf6tXKsUu3Pf1v2UB7xswlTWikQiBMWDYOVn25f2sPNCGlq2IavaId3zogBXSRPvAuc3AB8dd9/9f0qRYvyH0Q3Pqdr6SfBoBAA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB7295.apcprd06.prod.outlook.com (2603:1096:990:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:31:21 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:31:21 +0000
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
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwIAADl8ggAAEbQCAAQrHAIAARMOAgAlsyPCAAALngIAACqaQgAAjKwCAAAywQA==
Date: Mon, 19 Aug 2024 09:31:21 +0000
Message-ID:
 <OS8PR06MB754132857973D2AEEE33DF9BF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
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
 <OS8PR06MB7541A7E690A2D72BA671622EF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <929c322e-7385-48da-b925-7f363cf5b6f7@kernel.org>
 <OS8PR06MB7541672B4F9BCAA37E0D4005F28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <a0398ebc-c85c-44b4-afda-5e99a4299b34@kernel.org>
In-Reply-To: <a0398ebc-c85c-44b4-afda-5e99a4299b34@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB7295:EE_
x-ms-office365-filtering-correlation-id: 51c0fbf9-313e-445c-e1db-08dcc031afd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHJobWJvVjZXMytkcTFhaGE1d3RoVkVaZEMvaVFkeG10aC9ZNkVITFd0M0JC?=
 =?utf-8?B?NTB0bDZpemhUOW5MdU16TjZDN3hQQ3JaanJ3VU10M29ybEZGUysxb29JRzlC?=
 =?utf-8?B?Z201THVZZVZpdUFPL29kRHU0TkQ4M3NYVTFVN0pacHgvaGF3czVjaGE4anJ3?=
 =?utf-8?B?SC9YTWNNNW5aK0Q3cDdmNXVUZlNiVmQ1d3dUSXJnUWV6RjR6YUNGVFkvdWs0?=
 =?utf-8?B?TmZPcTZRa3E4Q1RhUlI1ZElaWC91SGhnWVlwcnpwaUEwSHFrR082Z0w2R0FJ?=
 =?utf-8?B?cmhiejRIVGRmVGxHeE9wVUg5Snk2cWpZTnlUOTVteUVVSXZmMmg5Wi8xYm1H?=
 =?utf-8?B?bFdSbkNZVG5VZFRHOE9lN3dZUGNwdm5XVGVEdlZUcDBZSjVxN2E2eGN2ZStD?=
 =?utf-8?B?aXdJdkoycmtvZ1VxZjUyek1DMzR2c0Q3cUwyaXcvbWxVdGFoRDJrMXJLeDl3?=
 =?utf-8?B?cmNBeGpDM3J6TmZicGVTQ1A1Sk5YcWM5SFhjV29ScC9KdkQ1ZjA2MVNiVnpn?=
 =?utf-8?B?QTRWaVpPODR0eXRqU3BmbGJKdTR4T0hQQjBEY3hkWkdXT3lad2VMZ1pjQXRW?=
 =?utf-8?B?THlpdVhib0sySEJTeW5vdDVtdkw2UFhHTHNWTEJaUlMxcExoSVNuZnRnOHYz?=
 =?utf-8?B?Y1hhRHoyTlNvWmsyY2lac1ZCRDhOL1BpZFRja3RON2cybm9BQUVMTDRMVFVt?=
 =?utf-8?B?dU56WVBJR21Sa3BZTnNweVd2a0tVejNGQkFYM3QxaEl5T2JLNUlIQ1pYL3JX?=
 =?utf-8?B?ZStkdGtPMmFNOU5pTU9YOHNNa1pKNGd6ZkM0K0M3TUtRQmh2VWVGUVcxUHEr?=
 =?utf-8?B?cHdKQTVUdmxkdFNrVWt1aUNpcndORUV6ajIybGxweWMwbkljR2VDdzAveTNJ?=
 =?utf-8?B?RGt3amxDdTFsbFF0ZHF1NHBIQW0wdVdEZ2UvZTZncS9Ja21LZ1hoOGFIdzIr?=
 =?utf-8?B?N0pCM2l1dldRU3YyVTJVaTA2VEZVSzdpK2NKM1Z3NHhCM0x5MGJ3MFUxYXNL?=
 =?utf-8?B?aGo4c1FVM1ZoK1B3Qk5QS1Z4a0VJVjhMQWZXZjJ0ckJFM2JGb015L3NJV0xr?=
 =?utf-8?B?UzZScnhZSTNwOTlGT1JMNWp1SUZjS2xlWjBUN1RPbHI4OFN6Y0FNVWZYbXZ4?=
 =?utf-8?B?S292Vm5FYVBIck1IbktrRERmSHZUZWVueGYydFNMZ2RGNml2bHBCZVRkV1ZE?=
 =?utf-8?B?bzMxOFFYNCtyc1ZKOHcyMElYMWh5cUVYaW9yNzFGd0NEMHFhM1lXekwyazRk?=
 =?utf-8?B?THYzRUVodGxIQ3VxbmRUcXYrQ2d3ZHZxMmhxSHdGY1A0cFpncGlrRjhnMHlR?=
 =?utf-8?B?dVdJOHF4MVJSZytGcm1FenBCbENTQ0o4SlkyRlBSazd1Z2VxejVUbGdLb1N6?=
 =?utf-8?B?a1dzakRHelptRFpkeXlBdVNoT2E0bVpERjAvRmVoNjhCTnp6am45ckZWem5C?=
 =?utf-8?B?Nm5sa09DL0dSM0l2TjJvelBrTUVTWUd0MTZaTVc2L0VTRXFTcWxpc0dRcWN0?=
 =?utf-8?B?cGhQaHVSMlpiKytBcmg3akNzL0V4amZqQ05ITk1MS0NVaGtReGFHSERiYW52?=
 =?utf-8?B?d0RCZnJyNGRSU2ZJOENCZ0pPdVdlUjlDNVZueDZjaURERnh5YzUyd0NBYzND?=
 =?utf-8?B?b3BTTHc5TFNGbXN2ekNreDNNQXlLNkdsY3hnSnZmZUNUS3lRdjhybE5vUGRs?=
 =?utf-8?B?WjNRSTJOVCt1ZVJsQXc0cGFvQTBQKzQ5TTRFNTJ3R2ZxQ0ZXcUlKQVArRnFK?=
 =?utf-8?B?MFh0YngwRVNERG1uY1pLVE9vUGYrRWxqL3N1QVNXdTAyeEZjNzdzOEpYNDdI?=
 =?utf-8?B?NVZVamNtL2UyL1o2THNiaVk4cVhzV2V5VE9nM0lJRnl1SS9Zb1hIWXBmeUFK?=
 =?utf-8?Q?NbYUX86OkP47F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akNJa21pa2dXaThoL05GVkl0ZjMrUEw1b1oxL1k4ZTQzdm1JTjNtQTVxYmhx?=
 =?utf-8?B?VFI3SmM3bXRCaUgycHhVWFJNamNQOXVlbzk2SEZCdjhXQ3BudjFTUm4yMFdj?=
 =?utf-8?B?Zy9qSkJMNWNjMEhFbFdNam9nWFRtYWdKQVZLZkw1ay9ISmhvZG14T3loOTJT?=
 =?utf-8?B?aXBmN3RVMnY4cmoxZWRnK3dndlRPZ2VCd3hZam4rTkhxU0h6dnBFQ1dSZ1VB?=
 =?utf-8?B?RWV5anJSaVpKU2NDT2tXa3NMRlEza2U2NFpIY043bUZxOXlhT3FsY0YxdHBS?=
 =?utf-8?B?b2NlSG5ZblRCelArL2NLL3BLamlocE4xTzIxYU9rd1ZsWlJNWlMzQm9PcDh4?=
 =?utf-8?B?RUdZQVlZenVIVFJrNXdQWXo5a1hOZ2dYL3MwUG1QOExaSktqbTVXa09PMHQr?=
 =?utf-8?B?WnlXRG15M2RRZDBxdEFwRlp6RFR2Qmt4NXU0WlphUDVEeE9wVW8xT0xMUld4?=
 =?utf-8?B?LzFualBjS3JNV1QvUk9JYVJsOExGZ3lUMVFaUHZRSGZpVTdzTWttZmN5Y010?=
 =?utf-8?B?MWlieGoyRWJhUmY4bWVreVRURVlKcmZGWkZweWs1TkZncjIranB1OGhCRGkz?=
 =?utf-8?B?VUd6OTdMcEZVQTZLbnVrL05lcnU0YW5kU3Y1L0F5R0tmRWhHdlM5b2Q2aVBW?=
 =?utf-8?B?T3plNnI2aVZRME9zZVZJQlV6YnUzVjg1cUxaclhXRHIvVU9JNks5V2FuV0lm?=
 =?utf-8?B?S2dtT3owUnVpNVFPRThmMnhwUGMyR2FHbnE1aXhwSVBuWEZ1TGg3SUQyY2xO?=
 =?utf-8?B?SXpBajhHWlZMZG80TjVVT1Y0dkNVWVgrNEUxUHNaNEI3bzh6d0dZWmdXM0p5?=
 =?utf-8?B?bzBlV2V6S3NMN2hWdFlBQWovVHJ0Ky94QjExMkh1a0NWSG5LVDhPZm5vVFBt?=
 =?utf-8?B?RHBzMllGTlowQUU0SzlBK1FpZjd4WVc4bGhpVjRVSUhpLzBJRmd6dzNhMjV5?=
 =?utf-8?B?Qmt5SWJ1dTNhSlpxRWsyRHhQajNsNVV5QllEeEZ5cGJOb2VjWkdjYU1MUkpz?=
 =?utf-8?B?Y2JxOGgzYzNCeHZOUzl4czBOWmxZd0RPdUQxWE5adUd4c2xMNVJpUzlBU1hy?=
 =?utf-8?B?bmNLbldPMlgwWHFTRnBYZnZkMStUc2hDZnpmc2JuK2RlcFk1Y0JDaDJwa1dK?=
 =?utf-8?B?ZDZpRlRCN0Zidm95ZGZ2Q3c5Z3JNZ3Vwc3c1SnltKzMweThJd1R2OVgwL3gv?=
 =?utf-8?B?YkJ4N2IwcnU0Uk9YVTdlUTdiV0lqSVZDL0Q3dS83bFBNd1R4czB4UmFFbXQ4?=
 =?utf-8?B?bmhJdFc2dmdOelpHcVl6ekEyd0htUmhWRGM5SmozamxhYUh2WUpjWTV4SVpL?=
 =?utf-8?B?Zm1yVTRKeFRPMS8xcUp6SmVSSGVYMzU0aFQ3ZzZ2Q0hJZ3FxR2dLNGdabGJI?=
 =?utf-8?B?WkZIb1lzeVl2dEtMc0hjZXdCZEw1VVluMVB4Q3dudWxFbmROTGp0U0NTQ2Qr?=
 =?utf-8?B?bFVwVEJKeFBRTWdIczIycXFiUDdLU3NiOXovT3hRY1pUQ3hmUW1kQ1NCaGtC?=
 =?utf-8?B?emxqNlVpeWx3VWpHeUN1cXhLWXpaRHhhQ3J5Tm5YRENab0VpQXBXVmlFaWNM?=
 =?utf-8?B?d1FlQldVRkdUb1VUTmpXcDRvdEw4WkdxZjBLcXlkd0ZEUG9nSlY4U3NVSERt?=
 =?utf-8?B?Umk5cG80VHI2dlJqZC9rdjRKNGZpVWxtZjZSenBhdlhGZGJyalB1T3hBWUZn?=
 =?utf-8?B?cndsSTRtN0U1N1NpNkJ0eDNDWXd5TmdrVE42d0l4L0dVQndwMVVPTWtFSFZP?=
 =?utf-8?B?RWMyTGw4anpJYm9FT2FXY3dyRWNpZUMrR3gzZmt5V0pWSklHaHVUSnFWVG9p?=
 =?utf-8?B?V2pkdlJQVlY5VXJUc01KVllZcTNXMVd2R1g0NzllWXVXZ3U5eU16N25JK201?=
 =?utf-8?B?czRFcmQ2YmY0NWU2V3UwZEpiUkFmQ05EaTNuN0hmZnBETkRIMklFOHRQanZQ?=
 =?utf-8?B?NUVxUXBMUlVNY1NldmJvSlIwRFNvS1VtWFcxb3prNlFtYXQvaDlXUmRRQ0da?=
 =?utf-8?B?bTNuR0lwVmpqOUhLaVRSWDFxNEtOeEFlWmNEMVljRGJ5UFdQaytYajN6Z0s4?=
 =?utf-8?B?RE1PdGxRZUE2Y0hIQ1d6SjkxY2JCeXg5NGJya2lPM0hsd20yM1hsdWhUTXFw?=
 =?utf-8?Q?QhfPdo+iSjlv+//tSSG1qg2T9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c0fbf9-313e-445c-e1db-08dcc031afd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:31:21.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWHskpK3X0uBL0DH9hDhsYPjm2rZbD0Wmn7wq4+mxNaDzNwJ5dNfJZtzhjOr0AmjuRSdvRDxiRquZEC56xF1lKwzdbQZRWWA7QyL0WV6MbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7295

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTkvMDgvMjAyNCAwODo0MiwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jaw0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+PiBPbiAxOS8wOC8yMDI0
IDA3OjU1LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRd
IGR0LWJpbmRpbmdzOiBjbG9jazogQWRkIEFTVDI3MDAgY2xvY2sNCj4gPj4+PiBiaW5kaW5ncw0K
PiA+Pj4+DQo+ID4+Pj4gT24gMTMvMDgvMjAyNCAwMzo1MywgUnlhbiBDaGVuIHdyb3RlOg0KPiA+
Pj4+Pj4gRHJvcCB0aGUgZGVmaW5lIGZvciBudW1iZXIgb2YgY2xvY2tzIGZyb20gdGhlIGhlYWRl
ciwgYmVjYXVzZSBpdA0KPiA+Pj4+Pj4gaXMgbm90IGENCj4gPj4+Pg0KPiA+Pj4+ICpOVU1CRVIg
T0YgQ0xPQ0tTKg0KPiA+Pj4+DQo+ID4+Pj4+PiBiaW5kaW5nLiBZb3UgY2FuIHB1dCBpdCBpbiB0
aGUgZHJpdmVyIG9yIG5vdCwgSSBkb24ndCBjYXJlIGFuZCBkbw0KPiA+Pj4+Pj4gbm90IHByb3Zp
ZGUgZ3VpZGFuY2Ugb24gdGhpcyBiZWNhdXNlIEkgZG9uJ3Qga25vdyBpZiBpdCBtYWtlcyBzZW5z
ZSBhdA0KPiBhbGwuDQo+ID4+Pj4+PiBXaGF0IEkga25vdyBpcyB0aGF0IG51bWJlciBvZiBjbG9j
a3MgaXMgbm90IHJlbGF0ZWQgdG8gYmluZGluZy4NCj4gPj4+Pj4+IEl0IGlzIG5vdCBuZWVkZWQN
Cj4gPj4+Pg0KPiA+Pj4+ICpOVU1CRVIgT0YgQ0xPQ0tTKg0KPiA+Pj4+DQo+ID4+Pj4+PiBpbiB0
aGUgYmluZGluZywgZWl0aGVyLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTb3JyeSwgSSBhbSBjb25mdXNl
ZC4NCj4gPj4+Pj4gaWYgeW91IHRoaW5rIHRoYXQgbnVtYmVyIG9mIGNsb2NrcyBpcyBub3QgcmVs
YXRlZCB0byBiaW5kaW5nLg0KPiA+Pj4+DQo+ID4+Pj4gKk5VTUJFUiBPRiBDTE9DS1MqDQo+ID4+
Pj4NCj4gPj4+Pj4gSG93IGR0c2kgY2xhaW0gZm9yIGNsaz8NCj4gPj4+Pj4gRm9yIGV4YW1wbGUg
aW4gZHRzaS4NCj4gPj4+Pj4gaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3
MDAtY2xrLmg+DQo+ID4+Pj4+IHVzYjNiaHA6IHVzYjNiaHAgew0KPiA+Pj4+PiAuLi4uDQo+ID4+
Pj4+IGNsb2NrcyA9IDwmc3lzY29uMCBTQ1UwX0NMS19HQVRFX1BPUlRBVVNCPjsNCj4gPj4+Pg0K
PiA+Pj4+IEFuZCB3aGVyZSBpcyAqTlVNQkVSIE9GIENMT0NLUyogaGVyZT8gSSBkb24ndCBzZWUg
YW55IHByb2JsZW0uIE5vDQo+ID4+Pj4gdXNlbGVzcyBTQ1UwX0NMS19HQVRFX05VTSBkZWZpbmUg
aGVyZS4NCj4gPj4+Pg0KPiA+Pj4gVW5kZXJzdG9vZCBub3csIEkgd2lsbCByZW1vdmUgdGhvc2Ug
Kk5VTUJFUiBPRiBDTE9DS1MqLg0KPiA+Pj4gQW5kIHdpbGwgcmVwbGFjZSB0bw0KPiA+Pj4gI2Rl
ZmluZSBTQ1UwX0NMS19FTkQgIDM0DQo+ID4+DQo+ID4+IE5BSywgaXQncyBsaWtlIHlvdSBrZWVw
IGlnbm9yaW5nIG15IGNvbW1lbnRzIGVudGlyZWx5LiBFdmVuIGlmIHlvdQ0KPiA+PiBjYWxsIGl0
ICJTQ1UwX0NMS19OT1RfRU5EIiBpdCBkb2VzIG5vdCBjaGFuZ2UuIERvIHlvdSB1bmRlcnN0YW5k
IHRoYXQNCj4gPj4gaXQgaXMgbm90IGFib3V0IG5hbWU/IFJlYWQgbXkgZmlyc3QgY29tbWVudC4N
Cj4gPj4NCj4gPj4+DQo+ID4+PiBSZWZlcjoNCj4gPj4+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibG9iL21hc3Rlci9pbmNsdWRlL2R0LWJpbmRpbmdzL2NsDQo+ID4+PiBvYw0K
PiA+Pj4gay9pbXg4LWNsb2NrLmgjTDg3DQo+ID4+DQo+ID4+IFNvIHlvdSBmb3VuZCBhIGJ1ZyBh
bmQgdGhpcyBhbGxvd3MgeW91IHRvIGNyZWF0ZSB0aGUgc2FtZSBidWc/DQo+ID4+DQo+ID4gU29y
cnksIEkgZG9uJ3Qgc2VlIHRoaXMgaXMgYSBidWcuDQo+IA0KPiBObywgaXQncyBub3QgYSBidWcs
IGJ1dCBJIGRvIG5vdCBhZ3JlZSBmb3IgdXNpbmcgYXJndW1lbnRzIGxpa2UgInNvbWVvbmUgZGlk
IGl0LA0KPiBzbyBJIGNhbiBkbyB0aGUgc2FtZSIuIFdoeSBkaWQgeW91IHBpY2sgdXAgZXhhY3Rs
eSB0aGlzIGV4YW1wbGUgaW5zdGVhZCBvZg0KPiBvdGhlcnMgd2hvIHJlbW92ZWQgdGhlIGNsb2Nr
IG51bWJlcj8NCj4gDQo+ID4gQnV0IEkgdHJ5IHRvIHVuZGVyc3RhbmQgeW91ciBwb2ludCwgeW91
IHByZWZlciBmb2xsb3dpbmcgZm9yIGNsb2NrIG51bXMsIGFtIEkNCj4gY29ycmVjdD8NCj4gPiBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9jbGsv
bWVzb24vZzEyYS5jDQo+ID4gI0w1NTU4LUw1NTU5DQo+IA0KPiBJIHNhaWQgdGhhdCB0aGlzIGlz
IG5vdCBhIGJpbmRpbmcuIERvbid0IGFkZCB0byB0aGUgYmluZGluZyB0aGluZ3Mgd2hpY2ggYXJl
IG5vdCBhDQo+IGJpbmRpbmcuDQo+IA0KPiBJIGRvbid0IGNhcmUgaG93IGRvIHlvdSBpbXBsZW1l
bnQgaW4gZHJpdmVycyAtIHRoZXJlIGFyZSBzZXZlcmFsIHdheXMgaG93IHRvDQo+IGFjaGlldmUg
aXQuDQpVbmRlcnN0b29kLCBJIHdpbGwgcmVtb3ZlICpOVU1CRVIgT0YgQ0xPQ0tTKg0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

