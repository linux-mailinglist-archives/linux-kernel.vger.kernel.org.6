Return-Path: <linux-kernel+bounces-280419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD694CA41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896321F27840
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB416D303;
	Fri,  9 Aug 2024 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="bfmuUR9E"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020085.outbound.protection.outlook.com [52.101.128.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83E16C86B;
	Fri,  9 Aug 2024 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183927; cv=fail; b=WsJOKCgkAe+iQd4myhw3XZrZeRiSrz+ybklX1m06gtqHkXlHWeYjyTMkd18pKCa5Pn0zyawozV/CDqRnE36g030bh190PINNlOH4uLu12yb69aMLtpTlxpm1wyds+Kc46863EWkps10MZlM8R9ht3U2d6M4/qHBv5v8/d8nWI3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183927; c=relaxed/simple;
	bh=lU0RAjAUpoM89aeqJd8tI8++3cd7OiQon12HxKgLLWk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKvC1VnozmZ8E2HJ3qzhzK+dbrPu8bZrrciA8YzqhJ4I+grA2+tieO0IPAVCKZaUB1EAPgnWSe+utCEQSYCBKPBg0dxQVKimPnUzXe6JLC20i1xrM/b9k6abauyx9BFQEUTUC3J/B+7OlubCriSDyGQQ3UCrjji7R6EVZRe8aU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=bfmuUR9E; arc=fail smtp.client-ip=52.101.128.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFMuxqscFpUF0hZCfe/20Q2ipPiekaclppQmNylH+2LPbhLQ7h3l8IEeSH4AXDEcPbVUCKRThtPuN06DVUG0Q7YRTw1rM12kgv8L6yswwyNi+feZ5VOFbCKdn+FU2kXJSqBFa9+veNLJJhemBFrCkJmcRk4t9o8c//rbNyKgyWX/0JinVX43IFuiL4chV/vLqOoBEhxgdVjouQWVvTeZVJ7N91ONOCdmSUVVouuwo044EIY6g64m889roakwEMcgocJRbYXpISv3kYC0v0mTevL87Y/KrtLAMpCAQfHcQ9JXt+ydEwctOC11b2CBphpDYqqfuZAB+49Hwq67GV/PzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU0RAjAUpoM89aeqJd8tI8++3cd7OiQon12HxKgLLWk=;
 b=UhIuKDI8GWfHy3D5oQzUmydFsQTLBs8sh9ljphAvcjv6F/2dOG/k1gMB45cNjkitaEc3dbhNGpodE8/btn41JQEEf4i86zEohdObV/KYSrf22cnFgcZu73CUrCY2GaTL2t2turngm27ECJVJmy46U3AwP5uglbyT3TrhEldMfXNHiND/YRI2TWDijsi30C7EyY3RxZ3ma40jWQrEN3bq74b8ZkUr31regwNMBR5IYhDCqotWLpbB1A0NgQBABNpT2Th+XW8TP+IxmnYmq3vd86LgPMBrHuBnizHD8yUHOSM4IwsRCJFnFSNgjjkAFbav8lLRlREupSQc2CfSmhrg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU0RAjAUpoM89aeqJd8tI8++3cd7OiQon12HxKgLLWk=;
 b=bfmuUR9EIqB7UlwWzhBnXw44mSw3/KBluZT4/xE1ezbzWBv6EqKcWCeGVpSjhy6K+V4+uduJwWus+9+pfmcVSS5Iu1xalO/p+jMJRU5OcI9SvHyUERQcwMkIuvT0vrEWFOKj8VPg87tqpRDvIIoP20eXa5IZYLWZLMGtjg2wyHA9BexG69gyoOamXvRhQrzyWRK/vWDdjNIwWX8m/lr1T0Vuu+AqZ6+XcQvx/MFY+cwftAhdREsRJ08fp50PCjdZocW5PRs/nXsbAyn2pCEHqID4JOY+AMunFaWml8vz1egQXyvYheS/PterMKp01m2Vn0gkA8mnlIMuEUTMZqUXbQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5720.apcprd06.prod.outlook.com (2603:1096:101:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 06:12:03 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 06:12:02 +0000
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
Subject: RE: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
Thread-Topic: [PATCH 2/4] dt-bindings: reset Add AST2700 reset bindings
Thread-Index: AQHa6Wjv8i1M85vp10KWcohHrZz+5bIdCQeAgAFgwKCAAAg0gIAAAQxQ
Date: Fri, 9 Aug 2024 06:12:02 +0000
Message-ID:
 <OS8PR06MB75413780807BD24C2E281303F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-3-ryan_chen@aspeedtech.com>
 <0f227033-4818-4ff5-9140-851c6d802fb2@wanadoo.fr>
 <OS8PR06MB7541E0944EAD547DED2AE561F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <4f1c275d-63bd-4649-9517-17ac4f20e3bf@kernel.org>
In-Reply-To: <4f1c275d-63bd-4649-9517-17ac4f20e3bf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5720:EE_
x-ms-office365-filtering-correlation-id: 43275ce0-5930-4434-aaa3-08dcb83a2fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ly9MSDMrdms1dUh4Z3BySEFCUlNpYkljRVR6bENUcitxZWpwcEhyMEhNRWhm?=
 =?utf-8?B?cnBsVExkY3BGNnNqRkRwYWFEZ21VRDdRYlV4SmZ4QjJmRFZkY2lYUVNNZW5o?=
 =?utf-8?B?WFNXSEFKUmJOdVpVd3BpZmk1YlBic2p5MmdlNUp0RmU0dXc5VW9VZEE3YWQy?=
 =?utf-8?B?c1ZHK3lHOFFDMW5RMGxkSEp1T00ybFhtc2R0ZTJPM3NvRkRCczJEd05XZVlQ?=
 =?utf-8?B?WXhwYzB4TXZBb1NRR1k3eDBsdmxRSGV3eW43RE00b3VZK3g2T3RIUHJvQ1Jn?=
 =?utf-8?B?UkprUi9UOWJWL2lQeG9lUExTYXU1eTV0dDMxN0x0Tk9BL3V3WENVSlBSLzc4?=
 =?utf-8?B?bFBjOHM1L0pkMGpMazF4WUZlS3hXVHVFSnExK2xIaWthK2kxbVZiVm1KMWc4?=
 =?utf-8?B?WHFFMkRkS3VFRWhJWloxNllUaGRjVFcvK3k5UkNKUHh0QWZmMWJjaW5xU2Z2?=
 =?utf-8?B?MGJ2U0s3K0NPOVpRVzhQbXk5Q3V0Z3FWMmJVOXRtVVVvM3RyamJRcDR6Tjl4?=
 =?utf-8?B?NkZUbjFsL1JLYTlPaDVDdExOdFF5VCtkaGdXczYvRlNDNW5xSVFLK2I1YXM0?=
 =?utf-8?B?OFdOVFdIZHFpeWFKOFRCRXl4elBwS1IzYXRlSmNQU0xCRllwNDZGcWNMd3hD?=
 =?utf-8?B?Q1hqK29NaGNlUnFoRWhBRXdSdS9XL3hzMEMrRE5xOEUzZGpsQzJEaHpDVXl1?=
 =?utf-8?B?OFI2ODlXZnlyMWlTRFg0M2xJSUVQb1BoTi9kbjhLVTZhZHExNGdlY2dUK3hR?=
 =?utf-8?B?YmxHK0dXTTI5K2xnSFMrdm1taVVjNWpTcGZyQ2tpb0JudytIVkJiYmxMKytr?=
 =?utf-8?B?a1pPc2dkdE8xNW1UR1h2dUZmRUZoK0JmOTNVdGpMeFRkUlAzRXNLNHY5Z3Vw?=
 =?utf-8?B?VzRvRlRuK0VvdytuMGlCTVEvUHdvcXpLdktjSmhielR6cVlBZnNuYUtRNUhm?=
 =?utf-8?B?UTRtTkJCN1pVY1E3UGRZcW9peFN1VmtPTHJqQlNmNmJlQ0VSSlNFcjE1K1RV?=
 =?utf-8?B?MW5MczJoeDFML3NSamVjOVI5WDdQejhwUEhxeGp3SEJaaUMwRkFwcC82Sno4?=
 =?utf-8?B?VTNUWG1GaysxUzRQanVHdW5HVGx4SmVUR3J5ZXlOMkFIODdDVlJHcjFHa2tv?=
 =?utf-8?B?YVFvcWo0ZFZ0SE5IbWpJS2xkVWNvUU9ydXhIcFRreE05Zjd6d1lRZUhqYlFW?=
 =?utf-8?B?RHF0U09WVkdsc0gwRysyUGNkLzQrOWZyYjg3MXFlYzdYK2lyVDdWcytrOHlE?=
 =?utf-8?B?eXl2bTNoOTcwZnlCZEFNVUxQNzFEMDl6TWpKdFd5YWNrZGdDY3ova05BcXlm?=
 =?utf-8?B?NG9lL0haWHR5YUFkZWE5T1A5ZktreWdabDdJUERyT2VyS1pQRkxBQkxIS2VK?=
 =?utf-8?B?RVJLYnpVRVptQ29id1ViZG5FZUtYUkZPdzk3eC80L3VYa3Myc3RyRGtVaVlh?=
 =?utf-8?B?M045cloyVjNUQS9tTHJtcU5CWTBLdkdoSzRNZnZ3elRpUFpKM3YvTys5T1dY?=
 =?utf-8?B?ZTMyeStCUFl4ZWhxaExsakJCZGhqOGZ1bzIxQlMxUDRiQStQQU1BeGFhOW5o?=
 =?utf-8?B?K0RxUnhQU24vMVZvYklkZkxaRXJmbC9pemJTaG9yK0xqeGVObERndnRrdnd1?=
 =?utf-8?B?OWZtQ2JrUm9HQ3FUWFpJdGJNb3FRTjNoa3I5dXpVOGpaaFYwYlV1c3RBQmJP?=
 =?utf-8?B?TXZ3emI1NzFJc3FTMDVHQXpOaUNHU3pteFlhekhwQXMrVDR4R09DQUgxTGNo?=
 =?utf-8?B?blpmVXhwb1hFSTFMbUxEcWwvRkxVUFVYTkFOWDFRZk80bFp3djZSMEhYbGc0?=
 =?utf-8?B?aklONEJKd0dQT043aFZHYzh1elNpTnBvU3NlVE9hQkg2Vno5dm1temM5RFdM?=
 =?utf-8?B?bnlweDgyTVZmVSswQUJEejFNalZRdS8vSFRlVDllNTlDZWJVN2ZtOGd1SXJI?=
 =?utf-8?Q?1nbE71cJIBQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVVhM1VreTFxOHcrZ2JJcFcrNHpka2ROb2E3ME43SXpHTjk3SjJpNGx2aWxL?=
 =?utf-8?B?TDRuajZoZGhqT093Tkk5ekZHQWQxVmRsVVMxZkdRMGZCbEJCMUhheU0vbHZZ?=
 =?utf-8?B?cHBpT1pwMTE0Wk52b2I1bmJPUmVBYVFFcTV0Vm05TUdFN3o0aHUrTkNuNjl5?=
 =?utf-8?B?bDlmZG1yL3BNeTExalFzSHZsOU1NYjFKaGd3WXFRVnNsVmlWRE8zUHJ2Tk5k?=
 =?utf-8?B?Zytkc0lFNFg1dzJJZDdxQXA1S1psaS9ZYzJLZXJ4RVg1YldCNnN0cUpaWktj?=
 =?utf-8?B?RXI3UkRJQUF1dkRua3JXc0czdGJvOFozMUpiUXJJOTl1dm5jd2phcXl2dWlR?=
 =?utf-8?B?Q1ZJc01uWXF3SjRaZUYzOWhvZVhWTGpHMjgrNU9paVkrdnU3bFZnRVFuU2Zr?=
 =?utf-8?B?dC8xYVhuVmVZN2ZMQnNnMzRES0pudlJBZCtmcFZhUkJwN3J3WUY5ZVJWOXI0?=
 =?utf-8?B?N3JmcUduNWxrT3I3Nlh0TUQ0VGRYa1Z3ZmVjQTE5Q2d4WENvY2NDNFBoZHcv?=
 =?utf-8?B?Zlo0MU5neXZ6aG1HRVc1WE5qVXB0V0FRUEQvUmpsdHoxeGQ2aTMwT0N2cWJQ?=
 =?utf-8?B?OVJPb0s0OXNlclJjYWp5ODArSHFJUERHT2VwTFllWWo0RXBYOUhRc2ROeDlY?=
 =?utf-8?B?VkU1dDJhVFNTaTR1NUwvZDlaSWsrQWcyNUx5b1JHeHpSR0ZaQzMxQWJVYVRE?=
 =?utf-8?B?VWlkYWRIM242R1I2a2IwNVIzWEhzM21NY1RheG1jQTIvUVAvVU1KTFVqd0JC?=
 =?utf-8?B?WkNRUEw4cDUwcFYwdGVjNUVsMi8xU1BVR29rVndoV05EUUJkMmIwOHU3UTZM?=
 =?utf-8?B?MVZLUEt3THdyVkNibVAwSVNYbTdQczBnRHhKbEVGeGxJNDN6ZHN4U2FxYUsy?=
 =?utf-8?B?cndRcG1LWDRjcDJNbEN4Z2RTL1V2WDl5Z25QRU4rbTB1aHhKRy84T29DbGNy?=
 =?utf-8?B?UTJKeE5nK2RRcUpVREFvakM4ejZ1OXNEVVNCYnp4L2MzYlhTd25uRU1uSGJ1?=
 =?utf-8?B?SDJqUng5U1ovbnQ3QUpFeFRaMDlYNjlGTE9TQkZZcFVwYkpDQkh2eWNGajVZ?=
 =?utf-8?B?OXRjdm90YllDdDBScXpxVEhzakgySFdCbzNkSkc5YzlZdTBPc1ppUU41WkQz?=
 =?utf-8?B?SVpPcVlpampZUmdBY1FQaitWWDVYNS9NajBFZ0tzaHF0SlN1TFhFejFrU1Fp?=
 =?utf-8?B?YmZPNmhCTEgxUklmeGVYU2tuY1BWRzZTdlZsN3hwRWtZOHZ4MVQ5U3YrMUhl?=
 =?utf-8?B?cHV2MUYrelEzNkFnY2V5TVpwZHp3QUVDVysra0dMSHh2QmpQRG5Ucktla1Jo?=
 =?utf-8?B?aDRRRFA2TFJZMGY5bWxKOE5kczA4RTVMcUJRQmFNUWpoVkR5dmozZVg3SC90?=
 =?utf-8?B?NGhDaGU4bHF3RUFLQWZWMTNQZVVTU1Erc2VIcURuSTl4ODhRZnpFS3loQTY2?=
 =?utf-8?B?QXVOdWlaQkVtdjhiSFR5Z00zU005SDJvNjdPdWRIM2dtalNtRWpOMHVKTFhW?=
 =?utf-8?B?d0lyR2R0bWpUNUt4UFlaaXMxb1RPaXdkWGE0bW5tTjFXKzREdVBtdy8wNHRa?=
 =?utf-8?B?d0xlcU1CWFVRU3pvT1Nwc1lIcUNtTXIvRVBLRVp3dmc3dzV6MmJ5SGxSbWZi?=
 =?utf-8?B?ZWpjcUFGSXkyb2MrZ3hKVzBwZjVnVy91N3AxUytWbEFaUjhiN3pIUUdCZWRm?=
 =?utf-8?B?ZmR0UGwzUHFQVHhKVkQ5em9nby9MOTA5cUp0MFVwZk9wZnVuU3VFanNGd0Vk?=
 =?utf-8?B?bHlZb080U1JtUEhXYVhJZzY4TExmTkh5ZWcyNHh4R3dpV3FqbitYYTdCSnR4?=
 =?utf-8?B?Q3hnakZNOEVSMWorYVVNZjEyc3NnS2JIdEZXZW5xbXJVR2NCY1dlcWFnSkhQ?=
 =?utf-8?B?SXlqendGbmVnNitsUjRPZnRMc0FCcnBua3FSNE90aG5NWHpnN21hMVVYNFI2?=
 =?utf-8?B?SWZMMHNYQi92Q2ZSMW1rV3kyT1U3OVhabXJpcmN4Q0Vhck1XSEtVbytpMWJ2?=
 =?utf-8?B?SE1OSFJaeTVTejZqSEpYaXc1VStkMXF5MEIzUWdvREU0RjA0UjV3NEJwcnoz?=
 =?utf-8?B?TFNuOXRoMEtXcHJZb3BqeUZlRFR1MnNZYUViaXlvL3pxRGxJVWdidEJ4S2RW?=
 =?utf-8?Q?lX7sJg0D66He3I7qXnMjF+Z88?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43275ce0-5930-4434-aaa3-08dcb83a2fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 06:12:02.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8zWm8CK6w31zPON4otLORMGfyI0OiRIenb8JtrOvX60l1RxdantTnOIP7PVYhHnwObj/Yfq1bkwLfoJQoTQ3cojGM8vvEbQA5GvwFVFpxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5720

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gZHQtYmluZGluZ3M6IHJlc2V0IEFkZCBBU1QyNzAw
IHJlc2V0IGJpbmRpbmdzDQo+DQo+IE9uIDA5LzA4LzIwMjQgMDc6NDIsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPj4+ICsjZGVmaW5lIFNDVTBfUkVTRVRfUE9SVEFfRUhDSSAgICAgICAgICAgICAgKDM4
KQ0KPiA+Pj4gKyNkZWZpbmUgU0NVMF9SRVNFVF9QT1JUQV9WSFVCMCAgICAgICAgICAgICAoMzgp
DQo+ID4+DQo+ID4+IElzIGhhdmluZyAzOCB0d2ljZSBleHBlY3RlZD8NCj4gPj4gSWYgbm90LCB3
aHkgbm90IHVzZSBhbiBlbnVtLCBCVFc/DQo+ID4+DQo+ID4gWWVzLCBpdCBpcyBleHBlY3RlZC4g
RHVlIHRvIDM4IGlzIHNoYXJlZCByZXNldCBmb3IgMiB1c2IgY29udHJvbGxlci4NCj4gPiBPbmUg
Zm9yIEVIQ0ksIGFub3RoZXIgaXMgZm9yIHZodWIwLiBTbyBJIGRvIGRlZmluZSB0aGUgc2FtZSB2
YWx1ZS4NCj4gPiBUaGF0IEkgY2FuIGRvIG1vcmUgY2xlYXIgaW4gZHRzaSBkZXNjcmlwdGlvbi4N
Cj4gPiBUaGUgZm9sbG93aW5nIHdpbGwgYmUgZXhwZWN0ZWQgZHRzaSBmaWxlIGRlc2NyaXB0Lg0K
Pg0KPiBObywgdGhhdCdzIGNvbmZ1c2luZy4gRG9uJ3QgZG8gdGhpcy4gWW91IGFyZSBoaWRpbmcg
aW5mb3JtYXRpb24gdGhhdCBvbmUgcmVzZXQgaXMNCj4gc2hhcmVkLiBUZXJyaWJsZSBpZGVhLg0K
DQpPSyBJIGNhbiByZW1vdmUgdGhpcy4NClVzZSAjZGVmaW5lIFNDVTBfUkVTRVRfUE9SVEFfVVNC
ICAgICAgICAgICAgICAoMzgpDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCioq
KioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioq
KioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvm
qZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL
5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m8
6YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozp
irfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6
DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkg
cHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3Ug
aGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJl
cGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5r
IHlvdS4NCg==

