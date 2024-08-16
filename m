Return-Path: <linux-kernel+bounces-289512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE479546ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2351F213A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF301991BB;
	Fri, 16 Aug 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ROc4qapO"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5A198A10;
	Fri, 16 Aug 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805371; cv=fail; b=KvCaHt/MeghAGkuuFpNGczIJiOSzYOGH07d/caD+qnCcDt7xQ9d3u4za6rUN7HHgZybtgcPBwiFhb0CwHM8SeGugUh/wOKENbftlEGK1Pq7EAqzzZednkhrYJS3nZenJkEZDsEcN7cREjo2CUNsQL5lYSxf2GVCa2FhNthvOJnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805371; c=relaxed/simple;
	bh=Za5yXHLdQi5QePQgSg8icwBkhVof8mayyEPpTw8Dn1k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rXluF8n4lmE6SYjhQjv25Mgrz5oX+bId9PLix/XvBl77R4ROUbUBxpt8egEYm6U1NzN7YXe71CG4wvfkr+i2mmGo8JAo+diIr5kOmC8pHmaTOotqLAI6V1AIo8+2tkZ3vcUNsB79ts7BKB2mCV7nVDr7Rvnwp0TTLOzb9uBJ5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ROc4qapO; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHT+nWDnAYqDEoIFPJXEcSRjysS0mcw6I2BGU6crpBP3R/RKTG2LsurxkfSv+csCIM4gosTQnW+mtdUgKw+B++U90DNAi5wPT931SR2DPtP54vcJefE6gVBmpNtTn/A1IH9L2o1jbRbv+lQKRaznrXreJb9ZvjCxsEhCL0QHGGC8xx7/YDjeSaqAYuo8RG3fLdWwX1HMtmwCGsLRlNIHACFaAfZO2+g9g5kiCs0Wywam+f9WA4TOkRoM4KQ9olfoUcah6oelNL9LTJWMppNXityrKWeq70soi3GldzGH3FDrMLrpJYduicLr50QQ+1wqmaJ1UG/KT4p6T/Ts4qkKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za5yXHLdQi5QePQgSg8icwBkhVof8mayyEPpTw8Dn1k=;
 b=jL5Ol/7tvdMcYhwLCjiRhZkQr3u6iuYYe3mp6QT9LUN0rmy6e9zAQ0yYyrdtnCus6x0tBlseGHmD+sc4TE2epWozGbhx1rBM2w1aLJ7LzeRBxhgUGxMUHTV0OMh0Gt2KgrGniFzMxELovHFmDaDsvSbpRpi0kS8vXNDHY+YkHXvSaAy+A9v3Ngz+QtevJUgD3u5yuffcUQoCQZmCOx09UzadHquG9voOthG804990HcGoXJTGXv4mE3bfB39MYcSWMfPUK6RbuikBdaiKxwpTtceY234TWVOLpQi9LwWNb2B7bpm9k8fK5Q5y5ouGlk/oxdu6gfP+kyZ5DZodIt7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za5yXHLdQi5QePQgSg8icwBkhVof8mayyEPpTw8Dn1k=;
 b=ROc4qapOwKWNuFil6X56fSrTbd8RdhiKDk3t3zhs6sIhfgVY+vA3WypYmlnlvDqyJKXmKe0u+H9cg0YWO8eebNnR6TQBNR0urHcNfT2WRMSsYV7XC9736kSQQesEMUSRyTO77hfpC/s4pxGzPs6/8NrpurOvtfbR/cVzHtC60P98X24q47/Mrdmqww+MPSG+ymF7imsInU8F+/kIfeo42D6+2TP1SCjCOYMzbY0Qy6XWBvgLkY6SdpEAegjR03d+1WJboTlK+Pk1Y3pCKicRt9BkYGz655hyN1zvZmMrGReyfBjR7Q2EUc1tNvaJz8NhlnVGp7Tfg8M4Tz9Ydw5xUg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5691.apcprd06.prod.outlook.com (2603:1096:101:af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 10:49:19 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 10:49:19 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Subject: [PATCH] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Topic: [PATCH] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Index: AdrvyMyJeJV7tcOcTkOYhAFaznDU/w==
Date: Fri, 16 Aug 2024 10:49:19 +0000
Message-ID:
 <TYUPR06MB62172CC6BA9647EF769D4DF2D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5691:EE_
x-ms-office365-filtering-correlation-id: 49b21422-1c20-4384-164a-08dcbde114ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MmQwZ0pJQWlLem42RHMyZmJqV0hveHVzbkcvMW03eXphQkNZTWdXaXB5V0ty?=
 =?gb2312?B?UzYvYWhHRkJUa2o3WUpUTmpUdnhIUGlzQndFMk5HK3cvWW41NmxlaXZhbmVZ?=
 =?gb2312?B?dEdTOXVzNVYweFpQM2pqWHVWRE5HV04rODcyOHV6QVhlTGRvOGEwMnlybmdr?=
 =?gb2312?B?eWJGc25xUmExZEduVWUwN2twKzh6WkZZZksrVEVNSzBzcDBHQXZQVmxVUVZR?=
 =?gb2312?B?SGxHS29WRTRFWlArQ2VqSHZrcXRTSk9HMnpNN3NsOU5kOGlYRU9sWTJkVkx4?=
 =?gb2312?B?M2NwcDJDMGJsUUdhN2ZETmlPV2hrZWRjQ1BYd3A0WkR3bzlrTmZ5OE9XRjIr?=
 =?gb2312?B?T1VyNys2b3E0T1lHUklueXJtY1RDUEhhRVBZb216WnlRSDdzM2dQUTN6RFNu?=
 =?gb2312?B?a1lHaUZUQ29ST1dzUDVXZ25Fa2lVMmROMll1L0hZRExDSTdLYmQ5MGNxV3d3?=
 =?gb2312?B?MW9sOTBXb0picm5sZk9rait4cVFCaWlzMWl4akFqTmlpbDk5alhxUzZHZDFW?=
 =?gb2312?B?S1o2VTMwRmdBeWZGVUVOWkFudElFNkcrNjJzd2VBUXBraWNPM0FJK0xESE9o?=
 =?gb2312?B?M1Y5N285QzA0cWVEWWE5RzF0RUdzajR5NGN3WXRDMWtIZmtNZHRqNVB1bUZw?=
 =?gb2312?B?d1p0UXBIUkMzbUVkMkg4bDVjMTN6UW1pektaUEtvbGhvbDFIdGNtQlM1RlUz?=
 =?gb2312?B?UHFtbEF6NG9qdGxSTUcxS3dkM2xCV0RpbXRPazM3TXVVOFJqUTRaM1FZSk9n?=
 =?gb2312?B?SE04U2Jha09JSFdWVnM2UWJVaEdEd1RBcDIvcWw1WTRTMERHOTNLbVJGVUFq?=
 =?gb2312?B?Nk9iQkFqQUphZ3pOeVlyNlhhRE9YME9zUTd4eG9acUdxK0IyTUtBdElaYlV4?=
 =?gb2312?B?YTM0bCtEVUtpM3ljZ042bE10Z0RONTlRVmNGeE4vMEtqNkpZUzYxM3BuUnJa?=
 =?gb2312?B?WXhVSzdCb2lEWVdBZTRYU2kxVGxXZ0YyNUFUUld0T2VKSjF2aDFFOUxuRStX?=
 =?gb2312?B?WDc5SlNHV0MwQXZxN2tqbDBWeUxQRHkra2h4Q3E2Y1FPWVpEZk43SHNPaklY?=
 =?gb2312?B?MlRLd3ZaYUQyTU1oTHF5RWpiWkl3bjdISmo4UzdmcnhHelpub0N3d2kxTHlm?=
 =?gb2312?B?NENISGhVSWhIR3ozZTU4TUNUUCtsM0djeWhyREgwdit3QnpMWnhUNkVvSS9U?=
 =?gb2312?B?ZE54ZjBFZXMyVTU4bjYzamhGSTBqUXYzc2NwWVBvYU5HdWV5clJVWTduQVpZ?=
 =?gb2312?B?Ri9SNTFyK2FOUkJnbStQOVFGSXpZVUZWQ013czQrdnh6S3Z5c0VSakh1Rzls?=
 =?gb2312?B?S2wrL1cvU1pKalNFRDRhTWcwcnYzaWNGY3czMkl2elh4ckdsUlN3S29YWWFR?=
 =?gb2312?B?L0F5dzJ3Mi9rTEh0cmorSXkzUFQ4bHpsSEFIT0dqTHp3c21PY255WUh2ck5n?=
 =?gb2312?B?VUZIMjlaazY5Z1ZrdW96VWEzcFA2MUtXQ1N2akVkbFB3NTJZV0NIOVBHTHlU?=
 =?gb2312?B?SHVuZC8yUnBPd2Jnb0ZvREd4NE9tNmx3T0NrdHpHYzFuekN4WEVPanJNckho?=
 =?gb2312?B?TllJY0RkRjA3QnNYQjhpOW1NQ2ZyVGtSYzJJV1E1a0R1bWk0NVYyanQrSnNN?=
 =?gb2312?B?N2JYRUVPY25keUVSNkNMdXkwYmtGZERJNTJiZllrZHk2d1FSa3h5bWZSbmpr?=
 =?gb2312?B?aTE1YXh4QWs3ZHQzcDl0UWViajU0SkR1RXNpZWxSNVNBdndiNldPQWNVMmxh?=
 =?gb2312?B?dlZzb2FnaDFsVUNZZ3BVZlhzd1hHNmYzWVRIQU4zdGI3V05CSnJrdHozY0lU?=
 =?gb2312?B?bGhDUUxWYTBWZXNNZkpNT2dETDRlRGg1eFUrNUZDeUtYeHdKMjErV0wvTE1u?=
 =?gb2312?B?NjcxMldJTVgrV1ZQNFhYVXRXZFhKOVBCM0xCR1hSUlVZNVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RGRnRHh1aXJaR2kxeHlJc1g0ZGQzekc5QnJ4NWxvOG8vZHdmQldDdzlnVDFv?=
 =?gb2312?B?bUt4UnNNV24vNEJVcml1WGZCS0ZUSE4rK1JSTEpBRHBlSXhVR25naU9aTW1z?=
 =?gb2312?B?eFFJQkxOVjcvWGVneUQ1N1c4aXFKT2FoSkpqczN3NGVCSUdLY1dQQzNHcTNn?=
 =?gb2312?B?VkpqWHB6U0VwZ2ljRHNVMTlSc0VDQ2NDVXVKb0RZb1JGa3NtdGdHQlBrQjZj?=
 =?gb2312?B?VUpsZURXSHFBMlA4bVM4YWhLWTBwNFJOaXNuWTZvZDJKUGwzTmt4cTFkNzZH?=
 =?gb2312?B?U1ZkVUdLMTlDUjU2cXpCRi9NWmpHNEVjYldiZEExWE90QjBnUElockxrWE92?=
 =?gb2312?B?Q0dBWHpDQXl4VEFGd2JmWTdOczczSHpaVUxwcXJTeUFWYWI0U1I0YVhIRVNs?=
 =?gb2312?B?V3ZrejVzMlZ2cGZWVXZxcWYyNklEZ09IQi9GSjdKWnFIVmI4VVJZMXpISmpR?=
 =?gb2312?B?aVRsWU1SL212V0E5ZjNFMGdtaFdpbGcyNWczNmNyT3docS9VOUJ5VFBadFFE?=
 =?gb2312?B?NGo5Y0x5S1VXVm9rOGtCWVRlZ3hWQWVCbklyeUJGNEFTaXhYOU1FQTNlV1Fj?=
 =?gb2312?B?LzJ3NFN2UmRKR01BTmhuZjJBaVZxMEdwbFRqSTViTWlsNkpsdHN0NlZNU0Nx?=
 =?gb2312?B?MTExcGszRXdxa1d3am1UbS92SHhwb2srZUszaiswc3lRSGZVNzlnY2l0M1dm?=
 =?gb2312?B?eDhvOHhiZG9Va3BkZlJJb29hSlF5RGV3Z2FmTEduZVpZOEp2cHNPa0x2dEFm?=
 =?gb2312?B?RXBRcUNyR1lMTlZVd1MxTW1Xd2NLb01RT2dJYVVxNGFXUmpKQWoxdTZUOU5Y?=
 =?gb2312?B?ZGVNN1lhL2xheE1oVTFXZ0E3YVNETjRwOTU4bjJidjYxVFpLaTNLSytDVG10?=
 =?gb2312?B?aExURnpDSmVSbDF6aXUwNEdBTWZZOUEwYWl2REs3anRaZHFjcmgxcFhvWXR1?=
 =?gb2312?B?ZFg2bjVONnI1eGRQRTNhbXYvcnQ2VklkK2xJem81RnArdGNZOURyaWh3cVlO?=
 =?gb2312?B?UEtRdEg4TzZXOEkveEpHQk55MzRDTkJCMC9jOVpncU5YRVM2NnpYWWtQT3pz?=
 =?gb2312?B?bHFTWlRmdW90NlZEWWxjd3piMVJMUWRJcDZTR09mWmR4ZlV5NlNKN3dWclI4?=
 =?gb2312?B?SUZSTHhRQ0dDV2JheFAvbTlIRmRRaVczQ3pMQm42N2pBZTFNNFM1VkpuVWFS?=
 =?gb2312?B?aW51WElLd25IWGM3Rkt4ODJ6Uyt0WWVmQnBabXJkMmZPaXBxQVJRbmdGRCtN?=
 =?gb2312?B?VWx3RyswQnpWUi9qNTFpQTY2UkVSU00xMG9vZGNNOVZpZW02Uk5Dc0hxOStG?=
 =?gb2312?B?YWJicUdIbXhWOGMweUhZUkNVY1EyZDVPaCsxTXk4cXZzaUpzK3o1QzlWQmxp?=
 =?gb2312?B?SFJjNjBMZ3NSdGxRSUE2bVhpaWxzUHRxeTAxLzdocU9MTFo1amlYUUdCa24v?=
 =?gb2312?B?bndhTVN4ZG1ma1Rvakt1cmVhdzhxeEVteTFqZC9iZW1yZU9HeGQ0allicEFu?=
 =?gb2312?B?TG1sUy8yRjF6bFM0bHltMW94bnVwanY4MjkxQ3FLZ2VreEVSMkdzOG5QTnpM?=
 =?gb2312?B?NklJY2o4Wm9vSWFwRjBIbFprR3A1dEM2eTRXQnA4L01QZ0RuMTZJU01mSTAr?=
 =?gb2312?B?K0JrdVNnRHg1TnFsMDhWcWlJYkExMG12SGFpWEUyV1lyWnVxejhvUThDTFAx?=
 =?gb2312?B?R3hPT2NGdFduMEZUemxVa2VBZEFNMG9KOEJOdHFqVUZPQ3dkQlRqOGZhcUFH?=
 =?gb2312?B?NnVvdE84Q0RZU0REQVNXWjRpMDQyZjViUDRrNjJpdlVhaVd4a1M5RG5USGRx?=
 =?gb2312?B?Mjl2VXhNQmxPN2tCTjF5NGw3cm9rL2VYZWdxeDB6cGY5MWljTmQ3dXI3WXhv?=
 =?gb2312?B?TWVxaTNXWHRoaUtWajJyY2w5SjJNSWVHTm5mYzg4dGhPWU05YWdmQ1phMlZF?=
 =?gb2312?B?ZXFXWjhlU0NjZ0hwSGRid01YVVZrWGtyMlliYjg1U3N2NHlVYlczMWlWclJz?=
 =?gb2312?B?Z21wV0plVHdncEJTYjU3ekREUHlQbXN4ZWZ6RUhFYUdmMTZCWlJvRXIwVDV5?=
 =?gb2312?B?WnFtbS9zU2d4SmVtTmJlUS9DUmlBbTlSemc0NWdMSUdKN3doWkxacUxiVjdG?=
 =?gb2312?Q?KCuw=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b21422-1c20-4384-164a-08dcbde114ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 10:49:19.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/TiFnZ4ylDaK/iWcWSpPXIm/4WTt1hB/JgHRGhFoZFY8z+czh/NB6EqIycQ/ks4RmHhHMRF3CJ6Hiqy5hVnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5691

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBZGRlZCBudWxsIHBvaW50
ZXIgY2hlY2sgdG8gYXZvaWQgc3lzdGVtIGNyYXNoLg0KDQpVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMWE4DQpwYyA6IGdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MA0KbHIgOiB1c2JfZ2FkZ2V0
X2dpdmViYWNrX3JlcXVlc3QrMHg0MC8weDE2MA0Kc3AgOiBmZmZmZmZjMDBmMTUzOWMwDQp4Mjk6
IGZmZmZmZmMwMGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAw
MDAwMA0KeDI2OiBmZmZmZmY4MDAyYTMwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZm
ZmZmZjgwMDJhMzAwMDANCngyMzogZmZmZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdi
MDAgeDIxOiBmZmZmZmY4MDNjOWFmOWQ4DQp4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAw
MDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KeDE3OiAwMDAwMDAwMDAwMDAxMDAw
IHgxNjogMDAwMDAwMDA4MDAwMDAwMCB4MTU6IDAwMDAwMDBhYzEyMDAwMDANCngxNDogMDAwMDAw
MDAwMDAwMDAwMyB4MTM6IDAwMDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQp4
MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAwMDAw
MDAwMDAwOA0KeDggOiAwMDAwMDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6
IGZmZmZmZjg4N2NkMTIwMDANCng1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5
YjA3ZjAgeDMgOiBmZmZmZmZjMDBmMTUzOGQwDQp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDFhOA0KQ2FsbCB0cmFjZToNCmdzX3Jl
YWRfY29tcGxldGUrMHg1OC8weDI0MA0KdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAv
MHgxNjANCmR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQpkd2MzX2VwMF9vdXRfc3Rh
cnQrMHhiMC8weDFkNA0KX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0Ka3JldHByb2Jl
X3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsw
eDAvMHg4DQp1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCnVzYl9nYWRnZXRfcHJvYmVf
ZHJpdmVyKzB4YTgvMHgxZGMNCmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2MvMHgxODgN
CmNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCnZmc193cml0ZSsweDJkMC8weDQwYw0K
a3N5c193cml0ZSsweDdjLzB4ZjANCl9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KaW52b2tl
X3N5c2NhbGwrMHg2MC8weDE1MA0KZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQpkb19lbDBfc3Zj
KzB4MjgvMHhhMA0KZWwwX3N2YysweDI0LzB4ODQNCmVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODgv
MHhlYw0KZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4DQpDb2RlOiBhYTFmMDNlMSBhYTEzMDNlMCA1
MjgwMDAyMiAyYTAxMDNlOCAoODhlODdlNjIpDQotLS1bIGVuZCB0cmFjZSA5Mzg4NDczMjdhNzM5
MTcyIF0tLS0NCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRp
b24NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0t
DQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAxNiArKysrKysrKysr
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uNjU2MzdkNTNiZjAy
DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KKysrIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCkBAIC00NTQsNiArNDU0LDE0IEBA
IHN0YXRpYyB2b2lkIGdzX3JlYWRfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1
c2JfcmVxdWVzdCAqcmVxKQ0KIHsNCiAJc3RydWN0IGdzX3BvcnQJKnBvcnQgPSBlcC0+ZHJpdmVy
X2RhdGE7DQogDQorCS8qDQorCSAqIFdoZW4gcG9ydCBpcyBOVUxMLCBSZXR1cm4gdG8gYXZvaWQg
cGFuaWMuDQorCSAqLw0KKwlpZiAoIXBvcnQpIHsNCisJCXByX2VycigiJXMsIGZhaWxlZCB0byBn
ZXQgcG9ydFxuIiwgX19mdW5jX18pOw0KKwkJcmV0dXJuOw0KKwl9DQorDQogCS8qIFF1ZXVlIGFs
bCByZWNlaXZlZCBkYXRhIHVudGlsIHRoZSB0dHkgbGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0K
IAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQogCWxpc3RfYWRkX3RhaWwoJnJlcS0+bGlz
dCwgJnBvcnQtPnJlYWRfcXVldWUpOw0KQEAgLTQ2NSw2ICs0NzMsMTQgQEAgc3RhdGljIHZvaWQg
Z3Nfd3JpdGVfY29tcGxldGUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAq
cmVxKQ0KIHsNCiAJc3RydWN0IGdzX3BvcnQJKnBvcnQgPSBlcC0+ZHJpdmVyX2RhdGE7DQogDQor
CS8qDQorCSAqIFdoZW4gcG9ydCBpcyBOVUxMLCBSZXR1cm4gdG8gYXZvaWQgcGFuaWMuDQorCSAq
Lw0KKwlpZiAoIXBvcnQpIHsNCisJCXByX2VycigiJXMsIGZhaWxlZCB0byBnZXQgcG9ydFxuIiwg
X19mdW5jX18pOw0KKwkJcmV0dXJuOw0KKwl9DQorDQogCXNwaW5fbG9jaygmcG9ydC0+cG9ydF9s
b2NrKTsNCiAJbGlzdF9hZGQoJnJlcS0+bGlzdCwgJnBvcnQtPndyaXRlX3Bvb2wpOw0KIAlwb3J0
LT53cml0ZV9zdGFydGVkLS07DQotLSANCjIuMzkuMA0KDQo=

