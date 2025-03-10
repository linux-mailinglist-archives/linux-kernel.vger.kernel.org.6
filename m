Return-Path: <linux-kernel+bounces-553926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B7A590B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C793ABA16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2D225760;
	Mon, 10 Mar 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="oYN8PIMs"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020126.outbound.protection.outlook.com [52.101.128.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D81C6F70;
	Mon, 10 Mar 2025 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601147; cv=fail; b=QWB0tFavhM4xpOlCUU8Ks0N0Q5Tz4d4B72TvIIAsvMuVJM5/l4Eh+97WF25xM4ITH5kTIlY1sBgF4xEedtNSBOkFULEZMXP2YpiIpkdTT95TeNhryON7qZqOtCo0NvP1iiwBT7OCgT/xkMvg0ZAs7xf+2Fxv1+B6MUy/zTVJQhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601147; c=relaxed/simple;
	bh=oloUxo023vL7ww3Ck/7K5stSU/gy4C9SAHX/Pv/Rkqo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cR4bawbZYifE+yR9p2i9dE6zADwDycHeS1Rnt7EnTopK1HQPlSjQ/Gn/oGNlTnCifHKMwjjZH7Ri5wOqGouzR5v26S+4U/xaUe2zsrTHkK+BB+9h6+BqaHekNw2KOK0c044jomtK3Y6yPc7hlu+0AkLAfQTFI8sBL+SR+uvVjiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=oYN8PIMs; arc=fail smtp.client-ip=52.101.128.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANrdYImdFMnQnOQ23MH+FkHl2nCNE1vZOKbiLnk1ylR3LYQ4ljLQYAQIwsLSo6N7iWzc2prTEyZb8e3coZaOUHph4K4hTJLYb1ha9I30dVIok1Yp0/yUrtobqy/T/Uj7yz+NFdANNzKSqZ8/4F8dM8FMFY6OQSISiwjvyjYcwjFtaMb4dhuvuEJglYe5V9tpwKhrjXRH+tHYqz6Z/8UnOJFPwCdBqR5YDKgyG7Xh7v9+eC3zmvusGwjuASymW4tRVfuPiAPlOQi6TJ2bv3WXnGUzkccf+v4014fnculxQPxp2zWIJ6rilxkSf7ASoDGZ+n2hdL/C101H+tXD+efLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oloUxo023vL7ww3Ck/7K5stSU/gy4C9SAHX/Pv/Rkqo=;
 b=UY6UZjaFCJqssVzCpzzqsjB8XtX7Z22pSQNJwWBZhtkJwPvQwUlyCn8GvJZt173kLtmB2ZaMnyf74uG2odqKoqag2L+JRX7/EvXns7U1iYDnXZCehpDtkCaGnPyOqptUNCnAf70BQtpGaY5sjUYDXcYz0ykk1iBN8HcARXuIUlIfmiNgj61Fb95DLGtA9Gf2YdOt/cbEvZv9mOwFRqBf3irciPkMdKb8nwPN6A1raleQ8i5YFsLJL9MQopU6jJ9n11j+WjFUHhss3G80KLOvPjGXwBR765OhmwU9f+31+YIyclClBSXiuhs2qnTUdwwlL3+0qyEKVPH64/zYN8IXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oloUxo023vL7ww3Ck/7K5stSU/gy4C9SAHX/Pv/Rkqo=;
 b=oYN8PIMsq86ALn+kOlDqWiEu847ZyXujJwbM/Qnggc/HnTplnsThlxPDUGXZXlQnnAXFi27CLNlShLLIwrXkonfKjL0VVcNIyOiExnVpsUUj8j8eZYLuHJyVjEzC8qYmww8SEpfOHqK/mqYWB5x68LudhQnbIPGVCF9TtKmLw7xtEtBu7gueytGEikIrIr2gJlzqgnM59X5PfqXMRCzQFTSOPzqlu3ajWudc8NTUXd93vYsg/2M9fk/RNUmHZ0CjVwpQyUJfcowb5KRNRMErOZAvBZP+Swhlj8h6NOtnXNkkoJohu3oQ6of05LEP9lRMGfITffFDc7ZBZXhh25+Pig==
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com (2603:1096:400:134::11)
 by SEYPR06MB6983.apcprd06.prod.outlook.com (2603:1096:101:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:05:37 +0000
Received: from TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e]) by TY0PR06MB4960.apcprd06.prod.outlook.com
 ([fe80::fad5:ac3b:a939:41e%2]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:05:37 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
	<derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Topic: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Index: AQHbjPJ07+dHDPFFS0aC2kKgLnBNFLNizwIAgAlcIwA=
Date: Mon, 10 Mar 2025 10:05:37 +0000
Message-ID:
 <TY0PR06MB496072786197162F19ED7DDD89D62@TY0PR06MB4960.apcprd06.prod.outlook.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-4-kevin_chen@aspeedtech.com>
 <2fd83d68-7104-4755-a0f0-8ce4a2601e09@kernel.org>
In-Reply-To: <2fd83d68-7104-4755-a0f0-8ce4a2601e09@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB4960:EE_|SEYPR06MB6983:EE_
x-ms-office365-filtering-correlation-id: 93e8dc72-7b13-4ac6-9d60-08dd5fbb1b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTlpR0JVNU4xKzRBZzRJM0t0Tjd3ck9FeVl1dk5LS2ZsUnlBODBidjBkdGNs?=
 =?utf-8?B?WE1vZ0ZmNWJsTkJzaCtrUWRESEh4cVZJbGhUZGZkaFEveWpURThEcWxaK3Bw?=
 =?utf-8?B?dWFIb2RCWHFISjNpTFNoUEpPZVNST0pNSS9qNjNqQ2JBeVJnMkU2MmhDVUNt?=
 =?utf-8?B?OGI0dVlKU0hWT3Iwd0hwQ2o0emNUTjlPTHVHNTkveXBBUUlPY2tsMjJvQ1hm?=
 =?utf-8?B?aUJHZFNIUkdONDlSS0tDNC8yY3dQcTlzU3NRbFJlZWhuT0pWcVFWY2R2N2po?=
 =?utf-8?B?cDVEK2hzWTkwS2VUQUxUd28vOTZsdmtzRkJRWGU4Z1FNeE15cWhKdU1PQ1g2?=
 =?utf-8?B?Q1JJKzQvUlo5U3FKRnJXTXdTY3NIU1lJZzZZbjFKM1MwcFhQU2h3Uk0rUXV3?=
 =?utf-8?B?N1RMTGJFakhoaUd2aUlXKytUWXJIdmdjelg0YllpTG41ZU5mYktDV3BndVBY?=
 =?utf-8?B?OERCbFNtWFhJV3dsMXZsc3lmZXFrcVp0V3ErSTJXSDJVa0Npcm9ocGxKQ09k?=
 =?utf-8?B?RmY1K2RUNU9tazJUbFM2OXdPaHZWWVRWREUySXB1QUErREpkbFFiekl0bHY3?=
 =?utf-8?B?Y1pGZHhFd3FpVHhZUnhiOVFkRkhqcXBrMmxieUQrWCt3QkwxYmhGWjFabFdl?=
 =?utf-8?B?b2h1cUwrQ0ZLNHluOWN1KzA1c2swa25pcHFoQTBqUmNEbTNtUXBHTzFCWmVT?=
 =?utf-8?B?aFlpZW94cmczUmw0UGxLaFduZVdwa2xxTEx1OHExdUNOUHBpaWErT0p5TkUx?=
 =?utf-8?B?WDh0aS8rNkV6elB4NWFEYjVWaTJqRC9iN1pqRFpXRVNzRHg1azZuOWhtanow?=
 =?utf-8?B?MTN2NnhEMXliMDB5enpGc2pCVW5ONHlsWWs1dXNyR3BNQmhOK0ExL1daM0RP?=
 =?utf-8?B?UnVkMVBXUitkSlhuOTlYNVRqUCtaZmNjMXVGZWMrVG1vdDV2WkRnc1Q0aWRv?=
 =?utf-8?B?VWZKMU1SUXJJTjZYVzU5TVF2aEJsY0ZNRUhmdTFoODliTUNRcTdxZVBweTlU?=
 =?utf-8?B?Q1lwOVQ3TUprSTMyODgxS2RHZG90dG5mSEZFaVhUcVlYRkpoQ0E3cWk4Nmdj?=
 =?utf-8?B?UkVMYkZFQ2p4YXMrb3dHeTlhN2hkZTBSdk9FaDlBNlVxVGpKTkVNbVpMU0p5?=
 =?utf-8?B?dUJOL3lDaVV1ejVkeVBpOFdrRFFOQjgxVEdBS3RVVTNZYWJIM2U4dTFVeUxS?=
 =?utf-8?B?aDNaSHZURWhpZElRREhGcExIcGdMTzluV0F0aHZGRDBaREszeHhBVnB5bzIw?=
 =?utf-8?B?dnhrOVkyeE5TN211SS9CcEYwSjk3RzdwaTJJekFUcHdhL0o3R1RMaWVqOUZh?=
 =?utf-8?B?R0M2TlhvcHlDZjhWTjI1enBndllUanNXNndHSXNmNnUwbGJZbDB6bnZyd1hj?=
 =?utf-8?B?Zkt2Sjl6QXl4VzAweXZnMFdpZmQ5WkZGeFgzT1RBMmVqN1A3VXpVT0UxdkJG?=
 =?utf-8?B?bmtzY3ZOaVRLbDdmdmI2Qk82bE5YUTBPWjdmS2VOeWQrVERCR0xyV2haWXZI?=
 =?utf-8?B?Z1AvU2l4b0VSalprT0pZQVRjUGtmUWh2WHFjVkxKUkt6T3pMRldmK1k2bmhv?=
 =?utf-8?B?d3VOOElVK2Fmb2I0VmNCb2FyME9WeWhSY3UxNkIvTExtTXkwMTRLZk5VOTI5?=
 =?utf-8?B?bHcyakF0NzgwSzVIbG1iYndZV0ZUWHNQWUJGeGhXeVp4UFU0S2pTMzgvVDBK?=
 =?utf-8?B?Y1FFWmkxSWMrTFBIY3oxeTcrOFlJVDd4QjJWRGxHMnJTandtTzllNXhWdUhP?=
 =?utf-8?B?OHFETHNJWWlUR1FWNWVyQ0lrMXFqdXVFTWFvNFhmSkYwUkZ1cHZzVERFMmV6?=
 =?utf-8?B?QUV5YXpqNjFVeGt3QVg3K2k4eG03bjJQS2UxNTk1Rm43MUUrSVJVU3dVRVl3?=
 =?utf-8?B?bklhMS81NmtSRGZCakdpRXdJR3R2M0xjWDhvc0Z3RXdvRTRrOXl4Zm54bDhx?=
 =?utf-8?B?U0FTbGkrcjNDUU1JcUZiNjlvRlRabzVGNmsxNUNhbDk0eGdkMnd6Q1JDOGQ2?=
 =?utf-8?B?MDBSZGYxQWdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4960.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlRldXNrTE1LU2h6aGV2a1dzUUoxSERPMExHYkJ0dCs1cDYyV3pqNGYxUDdH?=
 =?utf-8?B?Q0VuMEpwYTFKZmFxV1hGa0d2Uk81WkZjcmtoeUg3YW9iVXppZnMvU05SMEZp?=
 =?utf-8?B?WkNicFBzRk83VXAwVzFEcEl0ZFc4aFVFeHN6bWtQMmhOM0l4NERCWmxJdG5O?=
 =?utf-8?B?a2h3b3lQM0pZYlNvbHdXaExQdHhtSUhRbi9OVkh0WXZxYnlOV1VjUXVJbmQ1?=
 =?utf-8?B?RzZjNnd2ZWRGaENlL3FZUlB4WVRaNGRoYUpJaHQrcE5PamVUdGdxelE2Nmkw?=
 =?utf-8?B?ckJBTzlabnI1dFg5Wk9kWnU4Y091WktSZ0F5ajcwTWlmR1BnZWlnRGNGZXlz?=
 =?utf-8?B?Z1Rta2ZZZ2g2bzhGY2lFTWpoMlJNT21lejZiK0MveFFLR2V3MWE4RFdpbzFv?=
 =?utf-8?B?L1RzU3dtUk55ZHVheTh4Z3BKRmZZV09ZT0pxTnBnZzFjQUdmZDJCQVVtRU5i?=
 =?utf-8?B?TlNiYUFFdlp0R0V3Vmg1eEZmbkFHc09YeSt6SDV3Q3dndUczeDF0bzVpQXhG?=
 =?utf-8?B?SEwzQnFkOTBNQXV6bFM3eGNkYmVEa1F1YWNBM3UyU2libGhyWkgyUHNwTGQy?=
 =?utf-8?B?RTZseGNWUXY4WURsOXpaeEFnTm9XTHJmNXZucGNiTzk4a2VPZVVMUjlwS3d4?=
 =?utf-8?B?QTJJdFM5QjQ1di9oblowa2MweWZGN0pVL1Zsa3Naam1Jb0ZUY0hKTXZ5dWNQ?=
 =?utf-8?B?WVRlWHdsaTBUclRDdzlxZGpNRUIwTXJBL0RKZkZWNTNxdTg1MjVYYVlIMlZI?=
 =?utf-8?B?OVl4alo4UW1Ua0V1QzU1ZE16dkVnazJqVGdCMm1XWEFkN21oUkI0dndONW56?=
 =?utf-8?B?UjRIOHp1eTRQRVVvOGMvNHY1ZXp2ay9RS0lPVzVRWm5lRUdQTERUMStTam1E?=
 =?utf-8?B?M3k5RzByMVpWcTdoV0VNdko0R3lSVDBPem1IbFVSZnVsb2tSdEwybVI4dWdT?=
 =?utf-8?B?WWtSM0tPZjF1TnhCWnU4QWZ6QkwrWDZxMDhWbDlPLzNmV3BKNkc2YnA0eDZv?=
 =?utf-8?B?cktlazNhU2ZsblhkU0MzWHBRR2piYVdwMEFLME42RVJWUVRpalJIWGhhc09E?=
 =?utf-8?B?L2hpcTlobUUwUStidTNSWG1QcHFaUlVYMVFCNWhIMFdFMC80Slp3dnlaOWVL?=
 =?utf-8?B?NDF1VFhoaG5UNENuRlByMUh5UEtwb3BRaWJoejhzMXFwdytJdmNYRkRLZ1J3?=
 =?utf-8?B?Rk5wZFcrbVMrN0R5TGdKK3pMOXBiVnNOUThTTXI2MlYwK1JOa1hnVlQ0NG5k?=
 =?utf-8?B?dExZUzJTTUJZYkoxRms4dHA1UDZabEZyKzhXMjVERXIwT3VwSnliSWdvbmdj?=
 =?utf-8?B?VC9vN3hVNlNvTWFrNUl2b2tGVlFLUzRGUXRiL3lTWFVaVXV2VXMxK2RUSmFE?=
 =?utf-8?B?cGVRR0xXMFlZTDQxZE1kOXNTN0pueFhhY3IxV0RXbW5DN09nTmpZK1pmdmpt?=
 =?utf-8?B?VkhXQVVVTzl3cU5JSGhDT0k4N0VrR0R0WVdHbnpjb09RT2lJYkVxTkYwa1VW?=
 =?utf-8?B?c05MUUhFSDFvcTVML1dKdEpleHZkVXNXZ0VsUXRnVllLNVdpNEZyU296YW45?=
 =?utf-8?B?QkNOdGdJd1dGNXZOSVhPRjdsM3lJcWhyQWZJcGExWFdaemhEM1d4aHRXaEF3?=
 =?utf-8?B?bEtEbzdwNGM0TThGYzFzMTZvQWt4QmJHKzEzL3d4a0hmcUYxWW5vMlFSdG13?=
 =?utf-8?B?akhhbmExeEdwSFQ0MERJS2MxR3I3Y2JJNHVpQm5QamlmQ1Jhb2RmZk80bG5B?=
 =?utf-8?B?R0dCN0VvS1YzQ2pQb0tISkdkYVVQOGtZNWZhMEo4MlRUN1RrN0VWUy94N3FZ?=
 =?utf-8?B?ZGozeG9OSW5lZjN6VEZOQ2J6OXJIVXMxS2p5V2JVbWxPN0V6NjRwNFU5S1Bt?=
 =?utf-8?B?KytDNWprWU5TV3E1YU5TbHZhb2FEaUx3TCtzeWs5UTBFZEI0eHdrejZvTDVF?=
 =?utf-8?B?aXBDckplaEk1TDVXeklJdzZVUTNHR1N6dDRITVUveGVuQzZCSWRkMFIrS2xQ?=
 =?utf-8?B?WTBiWE56anY0Q2x3cWc0bHhhWllWek9tMWJYT3ljNFpqdGE3UC9xRGxEQjJQ?=
 =?utf-8?B?VDVPdmtFcmo1d1lNeXlIVEVneHp6TFNRQzlabm9NMTN1WEQ4MVdvMEVjZ1R1?=
 =?utf-8?Q?CIsIAAnkCgc7lF4Vz1bgz6xUw?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4960.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e8dc72-7b13-4ac6-9d60-08dd5fbb1b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 10:05:37.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dt98VaLp280xWHQIxEdJPGA/1/hovv5jz7mR6pkxH3mShXr6dKUc1xErk4IXOhlnZYi2RBUs6Z9hkrm/Eo/NV5fWSFxcBNN7zPskgz06WsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6983

PiBPbiAwNC8wMy8yMDI1IDExOjQ0LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBhc3BlZWRfcGNjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsN
Cj4gPiArCWludCByYzsNCj4gPiArCXN0cnVjdCBhc3BlZWRfcGNjX2N0cmwgKnBjYzsNCj4gPiAr
CXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiArCXVpbnQzMl90IGZpZm9fc2l6ZSA9IFBBR0VfU0la
RTsNCj4gPiArDQo+ID4gKwlkZXYgPSAmcGRldi0+ZGV2Ow0KPiANCj4gVGhpcyBnb2VzIHRvIGRl
Y2xhcmF0aW9uLg0KT0suIEkgd2lsbCBtb3ZlIGl0IHRvIGRlY2xhcmF0aW9uLg0KDQo+IA0KPiA+
ICsNCj4gPiArCXBjYyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnBjYyksIEdG
UF9LRVJORUwpOw0KPiANCj4gTWF5YmUgbXkgcHJldmlvdXMgY29tbWVudCB3YXMgbm90IGNsZWFy
LCBidXQgeW91IGFncmVlZCB3aXRoIGl0LiBBbnl3YXkNCj4gbm90aGluZyBpbXByb3ZlZCBoZXJl
Lg0KQ291bGQgSSByZXNlcnZlIHRoZSBwY2MgdmFyaWFibGUgdXNpbmcgZm9yIHRoZSBwY2NfY3Ry
bCBkYXRhIHN0cnVjdHVyZT8NClBjY19jdHJsIGRhdGEgaW5jbHVkZSB0aGUgcmVnbWFwL2lycS9p
b19wb3J0L2RtYS9rZmlmby4NCklmIEkgY2hhbmdlIHRoZSBuYW1lIHRvIGRldiwgaXQgZG9lcyBu
b3QgbWFrZSBzZW5zZSBmb3IgdGhlc2UgZGF0YSB0byBiZS4NCg0KPiANCj4gSWYgeW91IGhhdmUg
J2RldicgdmFyaWFibGUsIHVzZSBpdC4NCkRvIHlvdSBtZWFuIGp1c3QgdXNlIHRoZSBwZGV2LT5k
ZXYgbm90IGxvY2FsIGRldiB2YXJpYWJsZT8NCg0KPiANCj4gPiArCWlmICghcGNjKQ0KPiA+ICsJ
CXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCXBjYy0+cmVnbWFwID0gc3lzY29uX25vZGVf
dG9fcmVnbWFwKHBkZXYtPmRldi5wYXJlbnQtPm9mX25vZGUpOw0KPiANCj4gc2FtZSBoZXJlIGFu
ZCBldmVyeXdoZXJlIGVsc2UuDQo+IA0KPiA+ICsJaWYgKElTX0VSUihwY2MtPnJlZ21hcCkpIHsN
Cj4gPiArCQlkZXZfZXJyKGRldiwgIkNvdWxkbid0IGdldCByZWdtYXBcbiIpOw0KPiA+ICsJCXJl
dHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJjID0gb2ZfcHJvcGVydHlfcmVh
ZF91MzIoZGV2LT5vZl9ub2RlLCAicGNjLXBvcnRzIiwgJnBjYy0+cG9ydCk7DQo+ID4gKwlpZiAo
cmMpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIm5vIHBjYyBwb3J0cyBjb25maWd1cmVkXG4iKTsN
Cj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyYyA9IGRtYV9z
ZXRfbWFza19hbmRfY29oZXJlbnQoZGV2LCBETUFfQklUX01BU0soNjQpKTsNCj4gPiArCWlmIChy
Yykgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiY2Fubm90IHNldCA2NC1iaXRzIERNQSBtYXNrXG4i
KTsNCj4gPiArCQlyZXR1cm4gcmM7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcGNjLT5kbWEuc2l6
ZSA9IFBDQ19ETUFfQlVGU1o7DQo+ID4gKwlwY2MtPmRtYS52aXJ0ID0gZG1hbV9hbGxvY19jb2hl
cmVudChkZXYsDQo+ID4gKwkJCQkJICAgIHBjYy0+ZG1hLnNpemUsDQo+ID4gKwkJCQkJICAgICZw
Y2MtPmRtYS5hZGRyLA0KPiA+ICsJCQkJCSAgICBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcGNj
LT5kbWEudmlydCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiY2Fubm90IGFsbG9jYXRlIERNQSBi
dWZmZXJcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CWZpZm9fc2l6ZSA9IHJvdW5kdXAocGNjLT5kbWEuc2l6ZSwgUEFHRV9TSVpFKTsNCj4gPiArCXJj
ID0ga2ZpZm9fYWxsb2MoJnBjYy0+ZmlmbywgZmlmb19zaXplLCBHRlBfS0VSTkVMKTsNCj4gPiAr
CWlmIChyYykgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiY2Fubm90IGFsbG9jYXRlIGtGSUZPXG4i
KTsNCj4gDQo+IERyb3ANCkFncmVlLg0KDQo+IA0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCS8qIERpc2FibGUgUENDIHRvIGNsZWFuIHVwIERNQSBidWZmZXIg
YmVmb3JlIHJlcXVlc3QgSVJRLiAqLw0KPiA+ICsJcmMgPSBhc3BlZWRfcGNjX2Rpc2FibGUocGNj
KTsNCj4gPiArCWlmIChyYykgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiQ291bGRuJ3QgZGlzYWJs
ZSBQQ0NcbiIpOw0KPiA+ICsJCWdvdG8gZXJyX2ZyZWVfa2ZpZm87DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcGNjLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsJaWYgKHBj
Yy0+aXJxIDwgMCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiQ291bGRuJ3QgZ2V0IElSUVxuIik7
DQo+IA0KPiBEcm9wLCBjb3JlIGFscmVhZHkgcHJpbnRzIHRoaXMuIERvIG5vdCBkdXBsaWNhdGUg
bWVzc2FnZXMuDQpBZ3JlZS4NCg0KPiANCj4gPiArCQlyYyA9IC1FTk9ERVY7DQo+IA0KPiBXaHkg
bm90IHVzaW5nIHBjYy0+aXJxIGFzIHJjPw0KQWdyZWUuDQoNCj4gDQo+ID4gKwkJZ290byBlcnJf
ZnJlZV9rZmlmbzsNCj4gPiArCX0NCj4gPiArDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo=

