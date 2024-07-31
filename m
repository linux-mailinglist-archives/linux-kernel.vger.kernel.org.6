Return-Path: <linux-kernel+bounces-269105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF613942DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4F21C21B42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD71AE84E;
	Wed, 31 Jul 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IsVtGVwL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E918DF93;
	Wed, 31 Jul 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427436; cv=fail; b=GVOh9cbYra6PMNnYa7h07cbhF4/NVFbcCqxNNLgH6l+NfC8LPmpL8/zVBXXeNjsEYiwkM85Aa1bD/QDZPvFsODIjFt3OtrUr/cco4GfNBJUVWhkqaPN4Kgw5a63H4rdbSJqRovYdXSSMqjZ7c/QA+EY1PxsVaXntgrPZqBSoXrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427436; c=relaxed/simple;
	bh=xSOkatNOjszbMY8PYFDVanbl9D2Lsw5lp61lP5Q9uEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxC9nGiqX5Ra22DHjIpjf5eV7am1jfWTAyvQvQBpkaFqc6UYp3cJUp3B/hHEeLDmnJgZY1iwJ/8G5Oc0HuJYMNYUr8AR6E1KZhJ20CGHdYHd/74Cm44NnbX6aVJtBtGILNU+zUXao1knkHKTKPFyD23UiAhhp9LyYjrWtFmHJlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IsVtGVwL; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi0KFSr35gVYP0Jb7Hmffg/F3JgKAf31/BbEmmPjUqTTgd1ftbEZVwzoxaWP6hd/C7UY7+FQRaLUxF5UG7SMQnsf4uTPOZv7EkJIx4rpgbCS9xvD4eZFf2TPw+ANt2/dAkHlUB+DDNv1kXmgjEBc37GsnU0oQWx4d7WTpbZCLSz+M+yc4XZlcUrPNiB8aX/V6S4dEJb8FPROJzLjtcdNamgyVMwMDpyIRsuiI7YkOZocdXHFX+x3YAPUExf7ZenMrBtN5kH86+L0hZEzZSuTmYGxjhNLz1sERDNGbE+4IniER1pOMdswaPzLFD2id950pvIZntMnrhjqF9BzbL0t6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSOkatNOjszbMY8PYFDVanbl9D2Lsw5lp61lP5Q9uEA=;
 b=Jr+zkC4NfsOlQ4yARmal1vtj8FD898iLLgoc7ES57hJX9d5BtcTSXznTHEdyQQbuDXG0OPimQ8khxKQ3ibHPUh9H7LvW21+O0xdY9ObZE1WyV67l0VBrQwNCzQs67tx187++7kpd3Cu9A4h0bx4WrDIBI2O1FYFoFzbgRzEPxtV6E2yW+d340u+sWbgBDvIWzQA7/sCMVbLiE1U5ppdbmodlJgLbxJdaEB/RKbk0YbKg2qS8qv+wTHSBmE8L221JlG/Yn4ThnN+F6gAByrpOBYIoi5mJRDhvowgdgM6zYjM4jf/9IHw/bbeb1oFbxYavyNCmRngo95fCjbj6ZpO8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSOkatNOjszbMY8PYFDVanbl9D2Lsw5lp61lP5Q9uEA=;
 b=IsVtGVwLba4I3/6xX6fx7dplwsGlAAPqVdVpXeFdV7gNFVQClPtKmSsae5vy4ms/LgWWijWucSTmVQpIw67Nv0oMVOUIAWpEZj0LcFiKPq7wbMKj1Kn5i8GHEqd3xF+7fbHSKqYua8LKBvqH7hMkI/duOob8pKdvdsFjV2HPQQn+fBJuaAtcMa42n0lwshHN8AFvag9oIYMAMA59iD2eNj+hkdxhnAiYlAKUKGXHkBuIF1kNyIrK5+oRCkP8oNPq+ACbmgVkrNVtNMOAJMfesHo7hMTzbBIuOWUj4bejHUbYiLXUIsuLckKBhSJ7Vwt+so042XIsECDyI9hugVr4JA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6341.apcprd06.prod.outlook.com (2603:1096:990:15::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 12:03:50 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:03:50 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2Ml0gdXNiOiBnYWRnZXQ6IHV2Yzog?=
 =?utf-8?B?Rml4ZXMgdGhlIGFibm9ybWFsIGVudW1lcmF0aW9uIHByb2JsZW0gb2YgbW9i?=
 =?utf-8?Q?ile_phone_as_UVC_camera.?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRo?=
 =?utf-8?B?ZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9u?=
 =?utf-8?Q?e_as_UVC_camera.?=
Thread-Index: AdrjPy5L8mvqthR7TX6KWxl0Ter/KwAASxoAAAApW8A=
Date: Wed, 31 Jul 2024 12:03:50 +0000
Message-ID:
 <TYUPR06MB621773E80A1CF0C4DD78CC5AD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024073150-pointless-makeshift-3745@gregkh>
In-Reply-To: <2024073150-pointless-makeshift-3745@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6341:EE_
x-ms-office365-filtering-correlation-id: c5fb3209-e152-437a-6cb8-08dcb158d6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGZrZXRjcjRJZ0Zac1F2bjdCVDBaQU1yNU1BOEQwQVJBQ0t6cmpnK0JsNnBB?=
 =?utf-8?B?ZEtMT3lzYktPVms3Q1dzNnN1UmN0VktiTmc5TUh6ZzVGTWtpbytqMVhLWnpm?=
 =?utf-8?B?U2RKZ0dMZExNRlAwTloxNkJmM0pOOXFlbkF6akV0RERaOWxkMVMwMGI3UEdl?=
 =?utf-8?B?K213Y0h2RDlmbGlCNm0xM2R2TndVRFVWMS9Ybk0wSDc3TW1NS1dCUnhLRGFy?=
 =?utf-8?B?WWl6MXNja1YxSnYvU0o0RUVkK2Y5RkNmaWxUZThkU2FWNTlRay8yK2IwYVJN?=
 =?utf-8?B?Q3Y0elNvWjU2K3FvMFNrRWZweXFvRkFnLy9DTkpXTDYxaiswQk1GNEk3Yys3?=
 =?utf-8?B?U2JUNERrRTN4eFFLcHV0NGNZUWxpS2VGZ3BoRis4R1VFb25CWmxTVjBmTkY0?=
 =?utf-8?B?NGlNbWVqTUg2TTFMYkhEWUNTN0N6TXdFVVdFYlQzVW5LZXdBQVlnUVRvaEE2?=
 =?utf-8?B?R1VtNEFCcUE4N2J3VE95WXVNaGpkMmhiTVFIYWdIOGRxUjhXOW5KTUdVNXRW?=
 =?utf-8?B?amxrY3VHWXovQitUdzZZYjhGWExqR2tPQXdjZHR5d0JDR0REaWs1M3NEWlVn?=
 =?utf-8?B?MFpvRGx1T2d0bGJyWWVyaUFHUVdZZDVCb05CQjIrL3pkSC95SEMzM0VlWThz?=
 =?utf-8?B?TjBEOW90NlRiVDMzZmUxUnJQZURBV29GQUx0Y0YwQUt5K1RaZG5HZFp5eUZU?=
 =?utf-8?B?VVVSYVZ2Tm9QcEllMFZ3Qmk5bTByOVNMMDEwQUdGNTFCeWx0bnhWNnpXaWhM?=
 =?utf-8?B?WmpSREkwU3Y4Q0ZmNmJZckdOc1Ezamp1UjJ5b2hLQTdYOFh2OE9LcW4wcTZD?=
 =?utf-8?B?QVEvSTRmVHFnRDVRbFFjK1VHVkFVNTdIWWo1eDJSajhVeVRyWDUyZjZESUg2?=
 =?utf-8?B?SjVGWkE3eVlWa2k4UExCWkNZMXF1dUVzeTFhMmpRUGhDc1BzUEI0L1RtN1Ni?=
 =?utf-8?B?RnFtM1B3VmZta1pPazBmQ2pRNStJSDYzUU92VStsQzNUbEZPemJDTnlIS0Iw?=
 =?utf-8?B?Z2RkcXhiYWVpd2RGeEVJY1dlRk4wYXAwSjVCeUN6ajB0b1M0QkpDOTU1VW1j?=
 =?utf-8?B?SkZFQUNLYmtFMDdER1EwVjA5N2VoOXl0Y3YwRlVsM1FPb2YvMGJQMGFCdlB1?=
 =?utf-8?B?SjllNFFiRVZRblg1VFIxaDN5ZTliMW9MVmJOZ0JJT201T01mQWlrZTJUNFdv?=
 =?utf-8?B?TXN4ZmVXV1dyQWdSOFlSZUw3enVVai9aUHpmV25KZ0JSSEF4VUcvdkNKdW1s?=
 =?utf-8?B?Q3l1aHpWNUhmUDhFM2cwWU93SE9tckdZdE40ZUxOcnRQVFFGZVU1TFlNS2hw?=
 =?utf-8?B?S2ppSjR3RHdUckZ3dE9qOGZDdCtsemtUa1B5UDRaMXVEYngxU1FsNnNtWG5T?=
 =?utf-8?B?eHR4amN2Z0NNdEd5UzJsUlJQUFBRZlhxcnc0TzVXUFNmVmNWaWtPcFpCTHZp?=
 =?utf-8?B?Ri84OXg0L0RmUjUyODEyTnVyTVIza3JzR0xMUkx0dlVCQVhqRlozdzRCdkpJ?=
 =?utf-8?B?SE1KNHY5WE1tL1NlRTZpVHo2Y251Si9jSGIvbnd0bmUycXRHNFppS01VN3p1?=
 =?utf-8?B?WnZ4YjA1QnU4T0dPekJZMGJab21RNmNnTXFTVEJmemR1ZUd0RWM1dlJNeDBl?=
 =?utf-8?B?SHZMVndUN0hqMFFJYTl4bkFVVDUyVzduZUErMDJ5VFlRaXl6aUZUZm52VHZJ?=
 =?utf-8?B?cVF5RWlUZm5ZZ0NTS2FCVjF6T0ZjdzJZUUs1N1VOd3hBQllQL0p6bmh4OEQ1?=
 =?utf-8?B?MGR0TGVsRnRnQjNSdGkzUFpkdVdFWjBBcHFVMUE3KzRnRW1lNWZNVThlc0Qv?=
 =?utf-8?B?dUxrS2F0cEswd0pJMVk5MzUvcUpWSktqRU03QUt0ck9YWStxYkp3aFVlT21z?=
 =?utf-8?B?Z2wwN1VFMjIvZzlkUVhnb3ZKQldkQS9UQWRiSTZzS0lPNFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHd5MC9MRUlhNzNwNEpJcHhIWnl0aFV5RE1YeVo1ckltVER1cEFvWTl0TVpW?=
 =?utf-8?B?VEVySThuc3kvUjQzamhWWmFILzM1cUFaRXB4NWdOckdoQ1RIVlVMeXdTM2cr?=
 =?utf-8?B?eVFPdzBRZC9SM3djcU04bVRnRjMrY3NQWm15WEdQNDNicFNNdzlFOXJ4T3k0?=
 =?utf-8?B?amh0S1krNWttb0E4a1pNNE9XeXJSbjZNQ251SlEzYU4ramxFOXFSVWdEaCtV?=
 =?utf-8?B?d1NxVjQ2ZjcvcEpTN3V6VEY1cHF6M1hDaGdjM0JHVS8vVjZGVDREd05Kc2du?=
 =?utf-8?B?Qk53UHRwRzFzbiszRFdKZ1J1WlRMVDFjcTY1MGV4aUQzV3ZVdkRpbGhvYmly?=
 =?utf-8?B?WUJBUXBTYVRma283d0ZSRm5RSkhoYTJHa3I1VXJXakpVeUU4ZnlsOGNiWDlr?=
 =?utf-8?B?d3B4R25DQlNSbW50SzJqdzNPVkIydUsrOVhWV0ZMNk5YME43WjRUb1AwTXhQ?=
 =?utf-8?B?S2NDei9BblVGbmg3akJOWmhKMkZNK29ob29BRTNqcllINkIwY3pPd01XdXB6?=
 =?utf-8?B?YmtoNGRCTzBNMExLQkFNWFRmRlkxUUtONDVVVlNOVWc1b1I5RjdSeGRWaERo?=
 =?utf-8?B?N01Kb1c3Sjd1LytaZ0E1NVdpcWNZRm1MSFIzZHNFYXY2Wms3NldsMDVBc2d2?=
 =?utf-8?B?K0dmRnNpUU9HV2hueUNWLzh4N0xTZE41alIrYXJCdlI1R3YwdjBBci9WRWl5?=
 =?utf-8?B?Zm93Wmx3UUdKMVU5dWR1UG1xZU92WmdIRXB2MWpCM21nSnA2bHlNNHBieURO?=
 =?utf-8?B?VXhqdUlLNjR5aUs5SXUzM0l0emNZWTdkTnVxdVB0bm12SHVMMW53Z3Jnd1NX?=
 =?utf-8?B?amVsRXVBeVZoYlpMVmdWOHA2MmR4MmhudjFuMVBvNkdKd240cCtueS92U2JQ?=
 =?utf-8?B?S2pIRkgvQ0hFVWFzU2l1bXVwL0tLbnhhM2tFTkI3czlLckJicU55Yy9wSk5I?=
 =?utf-8?B?em1HYlFscDZBMjdWVS85N0c0QjFiaVAzbFAvNmxJcW5ra0pGY1U1blo1cFZR?=
 =?utf-8?B?a204ZEdoak5ZQVB3akFsdEJ4SEZPUE4rQS9iVmdPSFh0U1IyNVVHQ0tEUjNZ?=
 =?utf-8?B?dXBFQXVjc0VOQ1p3ZUc1Z0x2MWd5aTJsL3FMN0tUMXQ0blpmWWNSQlJqNUVV?=
 =?utf-8?B?U3NEeCtEYUNLSmFWcjVVMDQ1WEErNVBPY0IyNmNvWUFvVWlJWTRhNzRWc0xG?=
 =?utf-8?B?UStQL1ZDRVIzL29HQjdCcHRSTHczL25Hd015dzF2SGNJMXZwU2g4R2VaMUp5?=
 =?utf-8?B?bm9GRExVOURESmZqdW1lQlQwZjFBbnhVcnFIeVQzYlpKMDBQNW5oL3dzTEJ2?=
 =?utf-8?B?TVlaMXZiYytwbzAycFRSNDF2N0JIUGNrYkZ2VzNjSzhOdjBjZ0E0RmFyUnpz?=
 =?utf-8?B?NHl3RmoxK2lmQ2hnWjlwa3FLS2RiQm5Pa3FVYS91K1NWSmxMdXZjRmowbG9a?=
 =?utf-8?B?MkZ4Q2o1WTFZbkZ6RXdYZTFhcUpESGxuUnc1am0vVXNjdWJFMGV3TFVXZTJZ?=
 =?utf-8?B?OTd4TjBlTnhmTERKOXVTN25ZNWNXWS9zeWJJbmlXYllMdW5IV1lDTy92RmJU?=
 =?utf-8?B?Y3RvdTVidkVqOVZZNG5wWTc5aGt4M3IxdElIVTh3QkZxa0tSMklEdXp5a0RB?=
 =?utf-8?B?ZkpLSjFuSnFCazZvVHNmdGgvSFZ6L21ZZ3VtQStlM0tOMkJ1SzFRQmppQ2NL?=
 =?utf-8?B?U1d1VUJpRnFCRCt0dlorVTRNZlY5VlFyQ1pXRTB4S1o4OFBmd1l1NWVxWXZP?=
 =?utf-8?B?N3JOL0dVd21sekRHMGJEci9pZnA4clM2SWVibUQ2cy9kcjVvS1pnVU02L00v?=
 =?utf-8?B?Rm8yY0ZuQ2IzUUJuMzh2aERFdlpGZ2lwa0hGVjEwb0RNb0pGeHFFeVNUVkQz?=
 =?utf-8?B?M3B2YkVOWnphZXBHdXhnZVp5TGZmRkRldmV5T2dxL3EyeXlxVXdPVCtoOGJj?=
 =?utf-8?B?OUlqWFREbUpjOEJuUTZxTXVDaHYwUEFSYTRqMmNMRU5MQnE5dlBPMG8zRHUr?=
 =?utf-8?B?MDVZbHhncWlTVkZCc29abFpTR2JHOXp4bmc0ZUd5UUpUQzVhTUswY0drRUNK?=
 =?utf-8?B?MzFvWFVoRmJaSkdISllGZit1cjRKWHBsV2pON3FHUDYvZDczWHBmNVo4WU51?=
 =?utf-8?Q?MgmQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fb3209-e152-437a-6cb8-08dcb158d6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 12:03:50.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACHbVTeSFLcoiil4Ic9NmmCWar/AEjn63QpBafeyjd9MT6cFjvfA69i3Sdco0sUFMSk2Bi7jyyABVo0r2QMVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6341

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KUTogVGhlcmUgIGlzIG5vIGZpeGVzIHRh
ZyBoZXJlIDooDQpBOiBJcyBpdCBuZWNlc3NhcnkgdG8gYWRkIHRoaXMgZml4ZXMgdGFnPyBJIGN1
cnJlbnRseSBkb27igJl0IGtub3cgaG93IHRvIGFkZCB0aGlzIHRhZy4NCg0KUTogQWxzbyB5b3Ug
aGF2ZSBhIGxvdCBvZiB0cmFpbGluZyB3aGl0ZXNwYWNlIG9uIHRoZSBjb21taXQgY2hhbmdlbG9n
LCBpcyB0aGF0IGludGVudGlvbmFsPw0KQTogVGhlcmUgd2FzIHNvbWV0aGluZyB3cm9uZyB3aXRo
IHRoZSB0ZXh0IGVkaXRvciBJIHdhcyB1c2luZy4NCg0KTm90ZTogVGhpcyBpcyBteSBmaXJzdCB0
aW1lIHN1Ym1pdHRpbmcgYSBwYXRjaCB0byB0aGUgTGludXggY29tbXVuaXR5LiBJIGFtIHN0aWxs
IGZhbWlsaWFyIHdpdGggdGhlIGRldGFpbGVkIHJ1bGVzIGFuZCBmZWVsIHZlcnkgbmVydm91cy4N
Cg0KVGhhbmtzDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiANCuWPkemAgeaX
tumXtDogMjAyNOW5tDfmnIgzMeaXpSAxOTo1NA0K5pS25Lu25Lq6OiDog6Hov57li6QgPGh1bGlh
bnFpbkB2aXZvLmNvbT4NCuaKhOmAgTogbGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29t
OyBkYW4uc2NhbGx5QGlkZWFzb25ib2FyZC5jb207IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4NCuS4u+mimDog
UmU6IOetlOWkjTogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdXZjOiBGaXhlcyB0aGUgYWJub3Jt
YWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZiBtb2JpbGUgcGhvbmUgYXMgVVZDIGNhbWVyYS4NCg0K
T24gV2VkLCBKdWwgMzEsIDIwMjQgYXQgMTE6NDk6MTFBTSArMDAwMCwg6IOh6L+e5YukIHdyb3Rl
Og0KPiBXaGVuIHRoZSBwaG9uZSBpcyBjb25uZWN0ZWQgdG8gdGhlIGNvbXB1dGVyIHRvIHVzZSB0
aGUgd2ViY2FtIA0KPiBmdW5jdGlvbiwgdGhlIHBob25lIG5lZWRzIHRvIGJlIGVudW1lcmF0ZWQg
YXMgYSB1dmMgY2FtZXJhIGZ1bmN0aW9uLg0KPiANCj4gQmVjYXVzZSB1dmMtPmZ1bmMuYmluZF9k
ZWFjdGl2YXRlZCBpcyBjb25maWd1cmVkIGFzIHRydWUgaW4gdGhlIGZfdXZjIA0KPiBkcml2ZXIg
dXZjX2FsbG9jIGZ1bmN0aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlz
IA0KPiBjYWxsZWQgZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0
ZV9iaW5kIGZ1bmN0aW9uIHRvIA0KPiBzZXQgZ2FkZ2V0LT5kZWFjdGl2YXRlZCB0byB0cnVlLCB3
aGljaCBpbiB0dXJuIGNhdXNlcyB0aGUgDQo+IHVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVu
Y3Rpb24gdG8gZmFpbCB0byBjYWxsIHRoZSBjb3JyZXNwb25kaW5nIA0KPiBjb250cm9sbGVyIHB1
bGx1cCBvcGVyYXRpb24gKHN1Y2ggYXM6IGR3YzNfZ2FkZ2V0X3B1bGx1cCwgDQo+IG10dTNfZ2Fk
Z2V0X3B1bGx1cCksIGFuZCB0aGUgVVNCIGNhbm5vdCBiZSBlbnVtZXJhdGVkIG5vcm1hbGx5IHVu
ZGVyIA0KPiB0aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0aW9uLg0KPiANCj4gQWZ0ZXIgYXBwbHlp
bmcgdGhpcyBwYXRjaCwgd2UgbWVhc3VyZWQgdGhhdCB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uLCAN
Cj4gdGhlIGR3YzMgY29udHJvbGxlciBhbmQgdGhlIG10dTMgY29udHJvbGxlciBjYW4gYmUgZW51
bWVyYXRlZCANCj4gbm9ybWFsbHksIGFuZCB0aGUgd2ViY2FtIGZ1bmN0aW9uIGlzIG5vcm1hbC4N
Cj4gDQo+IEZpeGVzIHRoaXMgYnkgcmVtb3ZpbmcgdGhlIHNldHRpbmcgb2YgdXZjLT5mdW5jLmJp
bmRfZGVhY3RpdmF0ZWQgdG8gdHJ1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUg
PGh1bGlhbnFpbkB2aXZvLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgIC0gQWRkICJGaXhlczoiIHRh
ZyBvbiB0aGUgY29tbWl0DQoNClRoZXJlICBpcyBubyBmaXhlcyB0YWcgaGVyZSA6KA0KDQpBbHNv
IHlvdSBoYXZlIGEgbG90IG9mIHRyYWlsaW5nIHdoaXRlc3BhY2Ugb24gdGhlIGNvbW1pdCBjaGFu
Z2Vsb2csIGlzIHRoYXQgaW50ZW50aW9uYWw/DQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

