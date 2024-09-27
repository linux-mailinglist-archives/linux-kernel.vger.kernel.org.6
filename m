Return-Path: <linux-kernel+bounces-341385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58799987F52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B7280EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510F184554;
	Fri, 27 Sep 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="KO46ctCf"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300014A0A9;
	Fri, 27 Sep 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421824; cv=fail; b=qPk+dAt2/G07ThQRHjq5Wg8ZjGVkAxcZ6c/NliFzfyd3oYCfMhBGXER84UIIw+iDDFGyupDcvPzVGMiChU+gSq31bCjY4hPJg7yo4h6g1a81bk0OvQ1dn2/6QJ9lS14XM5aQJ0JG0w86LrvfxB3WU1GTc4Mbtq+JLJ1+K8zA5KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421824; c=relaxed/simple;
	bh=ZKJRxWe19x/hQ1rg6sGEfoObbxX9FCP1MJ0j7Az92GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JpvXOgc65IX8FRT9s5z5uPLqUHMkV5ENjfBznhjznhU/r5rqFmjRBqfwyDPE/9GC/3h9452uGBTVraB1TcRgjXX+Ns3b/KJmn1FNqjvwLeyE21f/j+gZqu1/VRs2QV2kCnZ6elJa3cjpfvjDGg/JpmQo6hZV7fuzNMfWAGN6sJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=KO46ctCf; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoOxSvTXxnow/he08hqwzXDCWYJix/w9STiQeAVa2useYW+U8o6XmCQBw1OWjZN0MMd+sDblE7SIJb+LwtQeP0gVpUDHEeiv13ZEHOfmtTLisdmdb1833a/Hn6mmleKUXgRx9SsxnoF2/czny9tCn+l0ndtheEuEiugEJsNkoeti0MIwvIooD+6Jnfri2Gzw/lSaWTyk/34RECJeZyLmPuMsr6f69ONCRXmiCsol8E9nPkX0s+fH1WXXcS/fKxJhU12Sj8M7vWaH59fyZHDPmObxiPYyChLvhQGGLc/EUIuWx7UXWLfRR3YXR8ju6wHTaWdLlIVf5SecdjXNrWmPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKJRxWe19x/hQ1rg6sGEfoObbxX9FCP1MJ0j7Az92GI=;
 b=tCpqfePOo+FXc8w3eaIqTlpaYkSz0gIOIFgDFP9esE1SQdr177J9nsIUl0RcVUKByR5iqLnVHCtMJKdNXn5rUDKgbk0/2xjfT3KsM2hxaQMAcn/r5j/4nWvGVDfjG3EKguyofqZfHeZbyRqUMgZxp+v2Xl/b8UXYx4aq2QIrkQMStvMLzP3PFNUIzNXpW+m+RWBhOesCvJ7RC6SLtWkz7UNzF2E/Gniu/Kqs38gvDOXx8AV+CrHWf/nBu5ibSlHGbYsL1c5aebfqAoJovJCYgB8r3N4cbUm6lyXYJjOJ4l0H6HSMK/ZXzp5zvfNVNAIXpOoG3++tvthYvJc5aUnYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKJRxWe19x/hQ1rg6sGEfoObbxX9FCP1MJ0j7Az92GI=;
 b=KO46ctCf09nzSYIXTbwsOTY2EKtf9V6XJxCtqZ5vg9rEA7BlI5FZChxqWkCxuEjcqebtZOKWh87HlUCxkcG1UDXiGZ2j/HF2imy2cHrFDTpYjsRzlhNkhqhOim2Nh32iKSX0D9WVZdc7NaPPbiBtgD92LV5bruwPOq8IbQ9D4PfomxJBUQ3gxWdj2YVxxIVwxX1+z9NwQTssdbloWkmDu+EEQ7lXtEhQlBg1atuGbk6detTMTtEQFX060u00R8GXXMDXIMNcoZB3/5fAi4GfHkK7W2T89ODlIRVZquV24/syNu+FQhpkFqOMNhYVZyZg2b0nsE8ltQ3lByrOWpXq7w==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEZPR04MB6477.apcprd04.prod.outlook.com (2603:1096:101:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 07:23:34 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:23:34 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Index: AQHbD7Q2eW66Wbq4s0SgBTKCf2nHYLJrJbkAgAAE6+CAAALoAIAADvqA
Date: Fri, 27 Sep 2024 07:23:34 +0000
Message-ID:
 <TYZPR04MB58530838D96722E046092C76D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
	 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
	 <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
In-Reply-To:
 <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEZPR04MB6477:EE_
x-ms-office365-filtering-correlation-id: 2484c502-9295-4c1d-4330-08dcdec54bc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFFTWU5zWEppQW94UHN3eDBRSUwwSFpUQkROeDkzV0NpWmRQdGNFZEFnU05U?=
 =?utf-8?B?YnR5c00va04rckVZL2lId2JHV1VsSllmNUVHQ0wwZ2k1cCtIVnNpYUl3T3Bx?=
 =?utf-8?B?cXBDWFg5TGMyZjJuSVluUGE0dS9qM2l2ZTkwZFZNaWRUUVllMllpTGp6amts?=
 =?utf-8?B?SmlGa1AzQm5tRisvSFFpSno2eWlkelZUZWZmUTc3WjNBL0tDT1A4STUyTjd6?=
 =?utf-8?B?TXdyT0l2NWFGdDhkRjBsaGlULzdDRW9GcmF4ZExzVCt1azY5VkttN1d1WDJj?=
 =?utf-8?B?UkFvRENZdG8wazZERTRNeVFJUXFYVlprcXZDb241dTlISXZ0L0NBV1pNUzU1?=
 =?utf-8?B?aFFEZ2JhYytiRU5YL3NXZDhpQUpzY09YNkNxUVBpV1IxRHRpMUtUUXlYUmpv?=
 =?utf-8?B?RTVadGVoVmo1bnBWS1l4VEZlYkRwcGVkeTVZb1JQaHhKRHB1RFUwWXJRK3ZC?=
 =?utf-8?B?OVk3TldGVTM5bUM3Vkt2dlpzblRzRnJPOU14U3dpZ0lKVTQ4cWhuWVkvZ2lY?=
 =?utf-8?B?a05JN2l2bVhEUVoySUovYWY4bUcxWmJucFpKU0Z3eUJMdUh4bWhsZkd4Ymlr?=
 =?utf-8?B?ZCtYWUZYcmlPa2dHN3BlNlpvcTRLZVlIN1hrcEZoSGFuUktxYllUeHBhOE8x?=
 =?utf-8?B?cDBoMDBPM2J3alQ2My9nMmxHZWJiZzZ6V2dVR3d2RFN5Y3NiVWJrMzRkTmNV?=
 =?utf-8?B?Smx6ZXE2ZEoyV09xWmFCWUNhUHJRNi9qZzFvR3RzL0NkMSt0OWhNMGZVRGtV?=
 =?utf-8?B?bUFldnZVSUdPYnZSSGltS0k4UFdNMVZrclpGSk1aZ1Axc3JUNjh2aER2TzVC?=
 =?utf-8?B?RmUxdmZyeUh5c1NuS0pGS25qS2V4cXEvLy9wQkhZaEVaUUZHMlczeURiU3NJ?=
 =?utf-8?B?Y1VGTEtDVXFJQlptWWMzeUFKTlJpYm9YelphZW1wL0lBeTlVbkJ2ZnZRRDk1?=
 =?utf-8?B?WkZVblVnQmY4ZlNLVU5IbHhUMVVnMEhDS1ZBWW5yVjBMYnNLY20wOGNBUVYv?=
 =?utf-8?B?Sy9vdVUxaUE5Z3prRGZoakk4T0RIOUxrQmozOXNCRk1nNkl4OEtGVzlVSzJO?=
 =?utf-8?B?UEpDSGtUcTBFYWJ0dU1uUTZuNTYzc3kxTlRpMEJCdzFGS3B0ZTgvRERROEw3?=
 =?utf-8?B?WUlob3ZSeXpZTkRzd01JY3FBbTRWWS9lR3V5eE1OSTdwUUx3SzJmYW5KZnZS?=
 =?utf-8?B?MEtGU1BnV0FEQjZvNTRvUkppb3pzdU1QTUlseERxZThDa1Nibm94UHlBVEVk?=
 =?utf-8?B?bVdzOTBhZFJKcjR5TTdFTDhLNTFnMEwzRm56Y0FOMUlOeW52OEpBb3VKanNm?=
 =?utf-8?B?TGQ5WFM4MHAvRmNodENpdlpXSTM0a0pvTzF3K2lhWGVDSjJGaG05RG1xY21t?=
 =?utf-8?B?L3dYeS9nRngxWC9pa2VzUzVRN2Y2SmFtM3V3UkF4S1J1U0c5RE9QQ0hiUnpO?=
 =?utf-8?B?dm0zYU5HUUpXdndxVUJVUmVrN21pdWc2RXE5N0UvRXFqWnFEYUJxM25RVmk4?=
 =?utf-8?B?c2xMbzNoSjNWUExoRzlhYWtDb0pUREROYWE4RVVib0YvRVB6elhyZHJTdXNY?=
 =?utf-8?B?SkswclRyR1dzMHd6bUREL2ZaWWRGM0F2SzZUejgvcWUwVDBpRG95cnY2LzZj?=
 =?utf-8?B?QWVDUDlmZ0VjaUJrQTRHNmIyT25PeHU0N0o2bFBaWlFHMU9VWE5FQkFBZzZv?=
 =?utf-8?B?VEdhTkpvZGlOSEFrTFhXQkp3QTZmRGtEZ29xdXc5NzB4aXBLMmwwYjhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGkvZXhrbUFJZmdEZ3NaYm11Y3RNWVBkOW5FK3o3bGZqU2ZsN0psLzI3SDZt?=
 =?utf-8?B?VUJmMDNyYTVvb3JaYTdBWHVaUWc1MEpaUWJLUERBYUZZWmRJVHRDQktXODQw?=
 =?utf-8?B?cmhTRnZxQ1I2aTF3bVFpbE5IT1hZNzdENDJQTXVxMmxGWU50TTZvNTUzVjVB?=
 =?utf-8?B?QWgvMllkbXR2Wk5nMUZuTmkxSHFhY2lObUF3a3Z3ZFNOYWF3T0ZkV0ducG4w?=
 =?utf-8?B?M21DcGtnbjMweHpwQTJrV1lwZnB0bUZENzlqMU81a1B4QXExanNKbm5NZFd1?=
 =?utf-8?B?NDVqUlpqNVBlREJWVmZmRnNMdDlJT1Nna3BUQ3VSU2syUTlua0N2NW5taGJj?=
 =?utf-8?B?UmxvMFR4Q0Z4OFd4MnVVZW1hTzJnQ2lVWXUxcC81QXZ0UFE3UStCY2EzdUNZ?=
 =?utf-8?B?TFk1bnpNSlJIS0hCbDVHQXN2ak5jeWZkOHRVemlta05iRDdudnZXWWRKSVV5?=
 =?utf-8?B?eW1XMWI3UHJjeTVRUDY4R29qZ29Cc0h0ZmxhVWpNM0tUSm4ycjVrTUE0ZGFI?=
 =?utf-8?B?U2luUFFZUmcvelVnZVlkRWd2anVLZGJkL0xkSmpTVE5qbHI1eXF2YlhEMTRj?=
 =?utf-8?B?eHJBenhUR3pTQTlPUndkM25jY2J2MHg3emxaS1JQUnB2Zk95Yng2bnJwRW5O?=
 =?utf-8?B?VkIrWmg5VmxmQlB0Z2tkMXVFWEo1bnNHTWkvc2laNlhHOEtaUnFGa1FzWGN1?=
 =?utf-8?B?WUN5cHNaWDlHK3RjUlZPL0FiVk1sNE9YWitRdEx3QkhQVWliYWhOVU9EM2N2?=
 =?utf-8?B?Ulo3M3IwWW1kKzl4RXo0K0VpVjNZcnlaZ281TnZvVGtCRGpHZWx0OS9WVVBS?=
 =?utf-8?B?NHFtR2JGMjlGdmpGRFlhYUJGMUlybVJIVVgzWE1yc0dqK0xUSlJQam9Cck8z?=
 =?utf-8?B?NnFkaTVCZGNuL1VwNFFtQkV6QWE4YTlvb1NvM2dCSSt5djlPMHRPVGI1SERJ?=
 =?utf-8?B?TXBuOWUzVXRYOS90MGNENGxYbmxvVmV1c2VmLzJOd2M2UVBWNUpXRytRRjhC?=
 =?utf-8?B?RTFEa3U0UXRhYWNhYXd2R1FKYUM3czBaVkQybXdob2tWb3BJNGpIeFNGZjFK?=
 =?utf-8?B?TWxPT1ZubmJSbzlDMGJ1eTFXcHdIeG5YVWJYUnh6RUgwb3lrVlhkODdOalY4?=
 =?utf-8?B?bzhaemE2MEVQZWFmcHhCNzh4aU5DazBnbmZMOEZNNGd1OG5JZnpaSjBRcDBQ?=
 =?utf-8?B?YmhQV3hOcnY1Q2FubGY3L2dyZjVOMlpsTk9DWDdvZW9wd1hUQTM4SkpNMjFG?=
 =?utf-8?B?b05wTWc2dDQ4aHR4K3F4VnZKOGd2NEt4NzEzVjlNVXNtV2k2YnIydERDT1A4?=
 =?utf-8?B?RjlucXdqdVN3VWxsdi9NVWthdnNpSXFPbXJQV1dMWlZ3b3IrMUNvTDQ3blJm?=
 =?utf-8?B?a0Y0OG5hMGl1bS92am1kK1RMYkZRYVNxaS81em5tYmJxdldyaFJkL1lQWGpr?=
 =?utf-8?B?ZlU3TzJLRDNHTGluVWxab3FUamppZ0tyVlY2VWF5djdnN29aY1prWnBBYjRU?=
 =?utf-8?B?d0t5Y3RXSWxWaFpFK3NDVVJIazZRS1lxTFhQMWx6MEZLakJiQ3Iyb0dXdzZ6?=
 =?utf-8?B?WEp3NW5JSzJvQ1VOWTRKdmFMdGZ1N2ZPRTJBUUpUelhVVWxvU0pLaWtSREw4?=
 =?utf-8?B?MkV3eVJ5WmFyaUVNYnBmSmpSZkV5ZFRuQmdUSjJUcTlqbEQ2L0hGWEI1U0dR?=
 =?utf-8?B?Vk9WbUxYNi9rVTU1bVVHV0VLdCtQaS8vK0RtaDZFM2NXV3dVUm13UXFHOVRS?=
 =?utf-8?B?OXhwVXFGWGE3NFQ4UVRmUHRqWmV0WCtrTXBNZmgvNCtIa1RsQkErdXRJYWdM?=
 =?utf-8?B?Rkp2RVJrcEtMTTJDMUk2a1kwWExjMDhMSG95RjRhdGhqVE5XZzlOcy9iclNC?=
 =?utf-8?B?ODJDeVRwd1BVc2xEekNCclg1bmJ3S1MxSWgxZlpRZm1VbHh0bEhjY0pLQ0sv?=
 =?utf-8?B?YkI1MWNRZXl0b2l4Uy9sN2xTRFFsRVRRVVdwcDZQMDVRSDNqdVJsQldQTjIv?=
 =?utf-8?B?N3ZFTnlTV0FiZm4yMFgydzZwc1pNeGsvbWRKY1ltTFRNUTdiWkUyZlUzbGZr?=
 =?utf-8?B?MjYrNU9POEtvUzhFZWc0cWlFMStIS2NYQnduL0VpejNTUldLWXJXYXd0RjRK?=
 =?utf-8?Q?5FvLL8p01SBtwuswwTyWmAB6/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2484c502-9295-4c1d-4330-08dcdec54bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 07:23:34.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fy9CmYVQE2GIc+eWZP4QwfINeumh/AcKetyilJAfuYAmPnwWDUpKDPU3HtQzFjteRXV7AAZA39juISPNRS++hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6477

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjQgMjoyOSBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IGNvcnJlY3QgdGhlIGNvbXBhdGlibGUN
Cj4gc3RyaW5nIG9mIGFkbTEyNzINCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtF
eHRlcm5hbCBTZW5kZXJdDQo+IA0KPiBPbiBGcmksIDIwMjQtMDktMjcgYXQgMDY6MjEgKzAwMDAs
IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1Pg0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIw
MjQgMjowMSBQTQ0KPiA+ID4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4NCj4gPERl
bHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+ID4gPiBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiA+ID4gS296bG93c2tpIDxr
cnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0K
PiA+ID4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gPiA+IENjOiBSaWNreSBDWCBX
dSA8cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4g
bGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2Vt
aXRlNDogY29ycmVjdCB0aGUNCj4gPiA+IGNvbXBhdGlibGUgc3RyaW5nIG9mIGFkbTEyNzINCj4g
PiA+DQo+ID4gPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gPiA+DQo+ID4gPiAgW0V4dGVybmFsIFNl
bmRlcl0NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDIwMjQtMDktMjYgYXQgMDk6MzQgKzA4MDAsIERl
bHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4gPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5j
eC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBSZW1vdmUgdGhlIHJlZHVu
ZGFudCBzcGFjZSBpbiB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2YgYWRtMTI3Mi4NCj4gPiA+DQo+
ID4gPiBJbiB0aGlzIGNhc2UgdGhlIHNwYWNlIGlzIG5vdCByZWR1bmRhbnQsIGl0J3MganVzdCBp
bmNvcnJlY3QsIHRoZQ0KPiA+ID4gY29tcGF0aWJsZSBzdHJpbmcgZG9lc24ndCBtYXRjaCBhbnkg
c3BlY2lmaWVkLiBEbyB5b3UgbWluZCBmaXhpbmcgdGhlDQo+IHdvcmRpbmc/DQo+ID4gPg0KPiA+
IFN1cmUsIEknbGwgZml4aW5nIHRoZSB3b3JkaW5nIGluIHYyLg0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBDWCBXdSA8cmlja3ku
Y3gud3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUg
Q0MgQ2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+ID4NCj4gPiA+IENhbiB5
b3UgcGxlYXNlIGFkZCBhbiBhcHByb3ByaWF0ZSBGaXhlczogdGFnPw0KPiA+ID4NCj4gPiA+IFRo
YW5rcywNCj4gPiA+DQo+ID4gPiBBbmRyZXcNCj4gPiA+DQo+ID4gV291bGQgbGlrZSB0byBhc2sg
d2hlcmUgc2hvdWxkIEkgYWRkIHRoZSBGaXhlczogdGFnPw0KPiA+IFNob3VsZCBJIGFkZCBpbiB0
aGUgcGF0Y2ggdGl0bGUgbGlrZToNCj4gPiBGaXhlczogQVJNOiBkdHM6IGFzcGVlZDogeW9zZW1p
dGU0OiBjb3JyZWN0IHRoZSBjb21wYXRpYmxlIHN0cmluZyBvZg0KPiA+IGFkbTEyNzINCj4gPg0K
PiA+IE9yIHNob3VsZCBJIGFkZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQo+IA0KPiBJdCBnb2Vz
IGluIHRoZSB0cmFpbGVyIGJsb2NrIGFib3ZlIHlvdXIgU2lnbmVkLW9mZi1ieSB0YWcuIEl0IHdp
bGwgYmUgd29ydGggeW91cg0KPiB0aW1lIHRvIHJldmlldyB0aGUgZm9sbG93aW5nIGRvY3VtZW50
YXRpb246DQo+IA0KPiAtDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9wcm9jZXNzLzUuUG9zdGluZy5odG1sKnANCj4gYXRjaC1mb3JtYXR0aW5n
LWFuZC1jaGFuZ2Vsb2dzX187SXchIUo2M3FxZ1hqIUxkcEtUcjM2WVY1ZTRjQ1JseTVsSUk1aUNG
DQo+IG05enNuYXZpX3ZSdWVOV3ZOSEdROFNpbUNmLVlmTDE0ZnhYVFJMM0Z4bmttaWQ0VkxEbEdT
WV9HeGRYQmhTVHJBDQo+ICQNCj4gLQ0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoDQo+IGVzLmh0bWwq
ZGVzY3JpYmUteW91ci1jaGFuZ2VzX187SXchIUo2M3FxZ1hqIUxkcEtUcjM2WVY1ZTRjQ1JseTVs
SUk1aUNGbQ0KPiA5enNuYXZpX3ZSdWVOV3ZOSEdROFNpbUNmLVlmTDE0ZnhYVFJMM0Z4bmttaWQ0
VkxEbEdTWV9HeGQwcEtBWW1VDQo+ICQNCj4gDQo+IFRoZSBleHBlY3RlZCBmb3JtYXQgYW5kIG90
aGVyIGRldGFpbHMgYXJlIGRlc2NyaWJlZCB0aGVyZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEFu
ZHJldw0KSGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24hDQpJJ2xsIGZv
bGxvdyB0aGUgZm9ybWF0IGRlc2NyaWJlZCBpbiB0aGUgZG9jdW1lbnQgYW5kIHNlbmQgdGhlIHYy
IHBhdGNoLg0KDQpSaWNreQ0K

