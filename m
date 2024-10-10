Return-Path: <linux-kernel+bounces-358568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4359980EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EF81C295A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A451C6F7F;
	Thu, 10 Oct 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NuUg1QCt"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A31C68B0;
	Thu, 10 Oct 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549838; cv=fail; b=HZFQa2hvuu6VGUyUtjULE2KPWg5u6xEAeKJ3h58Rn4uHoYLB+9tXFUzrzjs5D+NUHKTUX4Za6sdfFcl8u2XqI+BLqVlAw15LkobHI9DvciUAhsEoisrDjiA0OBSkWSajr3O3if2gAds2ELC8v/chCVYLkRoQ3FMjYAtWHCTUNjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549838; c=relaxed/simple;
	bh=aJNm433CgHpKZf7Eub386YHrGJV09XA914Fs40+FIW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aitfFSn1z+RYmcZkIGhcr+6WnYTw1n7r+vh4J7h6w7xx4y8Buci21gGzkMV+LKfoDseKV0JRukHmjixowMJMD1BYkU7Qd+/24G8XG/K6QnKBGKKmjmeofT2tvGff8lVB8PAl3+GtokXH/RdCxghnIdCbOOx1d06KcTB9Q3A7eSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NuUg1QCt; arc=fail smtp.client-ip=40.107.215.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5I2gIbk/Wv0JYhfNnO8TJZlrhH5osUjUV0ImLScULM2fkeMZK+RLz16LIPJICOYHkZPl6diV9YwAB5IaXt7F+vW8XhnWJVPyo+tnYeYwmyUPzTZc9dTWKiSLergboj6EExRDgcKNQVPTY6njokSNHAoYFCouzWAyws7yat7BMs1uA7/hQGrGkBiuQPjKOC/Ophi/TdeSrHHxpX4j19n4TrAAsZdYM0BCpfTc3WxoMlUr+RkJ1ZTFAfY6977wvF5Y7HK6qhLx8+Z81wwXv6lqXVrARCtV6vf1hnE0YpSrVhGzMK6VTY8CJKS2j3p4RZZfH8wrSjnerrbQqONP+LMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJNm433CgHpKZf7Eub386YHrGJV09XA914Fs40+FIW4=;
 b=Ug9JBx48aR7eG88SotswYy/4sEff8LuYFGizyXH+893UeB4gu6dC0xgnMpABKUtkUlc5X8sFmVzCypw+p2f86Ov0RG5vS+yniMz6v1e9/jnsXpWhJ7vWni5LVVtAUNzk9hu0ZetHntV0XHs8pot3eelDrw2stdw+JGpImKsqB7yNJ97w6TE4KlrBC6f9vtEbdvV7zEneUrMiav9bT3AMUw8jWIUOIkxIv1InWoCxQVzMMZlERp9q3qNWeQJe58btPQogm1rMSfQQtt5YU2IHlKcx8B5jnV2PDbxstQ/NwsnhEKL7KykcyRBBDZLQY4evwj9277UyztqCNgfGZO/V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJNm433CgHpKZf7Eub386YHrGJV09XA914Fs40+FIW4=;
 b=NuUg1QCtHQEJ1q92D0ReoOTLFzRji+m+sb0Njhp0ku4QelFRLAfnVhLUITFKvrGG//a5b+5NDoz6HQh5kuSv0xa7POHIl4+oaUGJNaZLUBi1U0u/Gb2Jz6LYJfxir/9OYCeRoO72ojCp8p6PISEIFwj04oGIAy6f5S1yg1sOfBgnB9ChdlZ3ZPqjmmBm8kryr6WrsM4YmNo0YaEZgQW2yUGgNu7fHDFak3gfINOWJV5mNfLx+pNiokdW4pDJ+GClryRpj/qUcNZog4z8pnbSe/xkRV9gFG15lb5ZN9/6eq1U8UFyIcZFGWg78pLUNnGvFvfF0zbNkFA1A62FbaN39A==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6896.apcprd06.prod.outlook.com (2603:1096:405:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15; Thu, 10 Oct
 2024 08:43:51 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 08:43:51 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogRGlzYWJs?=
 =?utf-8?B?ZSBlcCBiZWZvcmUgc2V0dGluZyBwb3J0IHRvIG51bGwgdG8gZml4IHRoZSBj?=
 =?utf-8?Q?rash_caused_by_port_being_null?=
Thread-Topic: [PATCH] usb: gadget: u_serial: Disable ep before setting port to
 null to fix the crash caused by port being null
Thread-Index: AdsS2sv/KrbNWrYhQLGh2QI0DyN4ggEb3HWAAOYv0QA=
Date: Thu, 10 Oct 2024 08:43:51 +0000
Message-ID:
 <TYUPR06MB62170223B4FB25D483C59407D2782@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB621763AB815989161F4033AFD2762@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uw=PUDHyHgMyPgZWKNsCHg8pNMvJrr1dhLjMF2ouK-QDRQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=PUDHyHgMyPgZWKNsCHg8pNMvJrr1dhLjMF2ouK-QDRQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6896:EE_
x-ms-office365-filtering-correlation-id: e48a1817-e976-4b93-7318-08dce907aa54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFk5ekhsQ2JLUGh5dGR5ZXREeFRjOElmSlJFZm5rMGZ6VjZCTEhITDhYa2Rx?=
 =?utf-8?B?Q3hVbEZmT1ljSnprMEdJbHd3ZFRGN0htWldKSVZ1SlV5aHpYUVBpeS9BWlUx?=
 =?utf-8?B?cmF5a3lQRWN1TVJrOG5SbHlzRUt0YU9OdlpNZVRnbndlQXcwb2lKWkZGb3Vm?=
 =?utf-8?B?ZGkrcU95MlJ3WkhZNXo4aXAyQlpNVmNITzgzeXRPN0tqelpwdjdkZU9qcWV5?=
 =?utf-8?B?V2FPdm1pWWZPRkY5TGVoQVFSNnZkRU9YeXp1RllHVWtjOTFSU3RUeG01RGZQ?=
 =?utf-8?B?UVpVbDJEVXF2T0R5WWxLQ3NvekhKQ0EvZzJiemlyTzhtWi9nNzVtRVFhZ1Fy?=
 =?utf-8?B?a2hhRGJQdklRL3RyVXJadjMwSVNWTHE1TExTZ3BvS1VTeTZaTjVyUWpDdWxv?=
 =?utf-8?B?cDJRR2NYS2lpVWZCcTBpcXFlaU9WVERQN2U2b1IvQUdOZ21lMkY3T0JQVnBa?=
 =?utf-8?B?S1VVaDVXVWY2QW4zbFVvV3hJZVVkbEs3YkltMHVDTjZXSGwrdlYwUUpMREhz?=
 =?utf-8?B?R2ltK2N4Wks0ZHlGNGh2a25ZWWtUMHE3bVlYeklKV0d3bllyTVFvZjFzSjBC?=
 =?utf-8?B?WFNaRTI3bVBZKzBCbW9FVmZ1VU4rWXZiR0ZBa1piMVJENWFSRGdwS2UxWDdB?=
 =?utf-8?B?MFBlM2xHRzkwcGNpZnlXMkxWbWhnRGpLR2tyVFVpaHpyYUVPNlpobmczb3Zk?=
 =?utf-8?B?YXNIekFsczNmTGN6NlI1WjFzV21YZllWV3FIUXNxYkhyZ0oxS1FDQnRIa0Ri?=
 =?utf-8?B?M3JvUFNnTnl6VXliQWFtK210eGlHakFWZzRNRFZ5K2k4aUR6cWdBR0pNUmF4?=
 =?utf-8?B?MkNXSE1FL2J2OThqTWVWNFJrekNrMmZqbGhRVDZtYzlQWGlGWm1ZRGFHbHJQ?=
 =?utf-8?B?NzhGV2hBK2hZRGRjMmlJdFNaUGU0N3VMNi9zTEd1NkJqV09OM2NOUjRoYllO?=
 =?utf-8?B?MmlJeEN3WkhTd0h0N3VrQ2FtSm0yOWxTK3hGeWJuZU52LytFcHF3K0d2WDM4?=
 =?utf-8?B?QWs0T01McS9VSFVLUkh5OXFJOG9raUwycHV3NTlIM2hhS3BQZlhERlNpejZW?=
 =?utf-8?B?U3RRM1VHUkFiYTlVZFBXazNvODlNRG1LcmllMEl4UE5Pb0V1Yi9yUWJ3L2oz?=
 =?utf-8?B?cTdRL2JNaS9QaEpJV1R3SmIwNzBtb2EyZzVxOHNveG1DbGtZMFl6YmNRVXZ5?=
 =?utf-8?B?TVFtOWl0SDNKV2ZlK3lOSjI1eVJjc3JXSndDL2J0V1YrbjFXSVdEd0dUWDJk?=
 =?utf-8?B?d0xHM0U4aUNnZEwvLy9VemRacStGTHl6STg4dHRRTklpTEtDalAxMWxQN1NU?=
 =?utf-8?B?OUtVV0pvMWFGUjY0U29JQkt1U0Z2eGVXc0dQdTBqVWxzeTZuU1R0aTRjc3VK?=
 =?utf-8?B?Q0NCbUFid0lFVHJmVkkvZzU4UDdRbEdnSFVJeHRLZzZLa3Zqb01XNTdKRVZB?=
 =?utf-8?B?RTJoalZJUmM3WkdLa2xHemtDSTNXRWJrdTVYandiVnlvMGdsYTBRajBWSXpP?=
 =?utf-8?B?YllPWkhDbmZJTDRQODF6SlYzSFhsbGdmdFRQcGhIN2l4eVMyYjBKLy9iSEVi?=
 =?utf-8?B?RExrbWNzZlcrWGJJa1J6NlRETEZtdWFVQWlwMFk1N3pNK3pIMTluYXNqVDBD?=
 =?utf-8?B?L3gxRkRNRlE2Y0xBRVVlcFdYb3hMcTJhWUlrT1l3NkdZeXNRTzVvbjN5cFY5?=
 =?utf-8?B?RUx0SjRNMHpHRHZFR0FiU2NWMUVtYWd0NmNqUkJtbGd2QzlBc2RnOGE2WGFv?=
 =?utf-8?B?RlNveE9POTFUNExKaGF5cFVCN2FoSzFUTHlYOXpDcUFjTVBJb2E1cEV0TU8y?=
 =?utf-8?B?b3FodUZFY2pZWXl5N2ZkZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzRNbWZ3dThZZ2xuZmZGZGJyQmdpNVBYK1dUNWVhUmt0eUszcjZ5cWhaNkdV?=
 =?utf-8?B?UGlrMlhDeGFtU0s2a2JaTGpaNE9iUTBnT1pTZXl5eXRHc25LenlxWVJkMnlI?=
 =?utf-8?B?SnM0TVpMVk1mWmpmTDZrMmlTendZSFkvTVNVN2hhbFJEOGxTRU9UNldHcFRP?=
 =?utf-8?B?U3I0cWJVd2swWUh2eUpTb3RMT1l4ejdIaG9SRnpXa0MyL2cvL0pkOTRJSEgy?=
 =?utf-8?B?K1c0UFZGYmZOK2FvVFZ1TGFWeVZqbG4zRmxOTDlBbkdWNFFwZTJoUWk4cHdH?=
 =?utf-8?B?TUZORGllczJhRGNBRlBVUlE0b1d2cVpzWHlQVTNCbWxzZitpcTd1bUQxNWFt?=
 =?utf-8?B?aTRJZUhhT1JoNWcvRk95ZiswQlpPL1hqM1J4M3lrV1o5aTc4ZDkwY0NiVVBX?=
 =?utf-8?B?cGRHVXJuNGdVQVZodzhXbVE4dG1Jck1zSGdNWDRnR3pYNHFrQnUwdVFCeFVF?=
 =?utf-8?B?YnFseTdxRXFrMVBFV2hqbkoyS291SGNRN0hBbDdHeHgxbG02dnR5M28zV3lO?=
 =?utf-8?B?T2RXWEc2YklrWXg3VUdGU1BMK2FCYkltMTRYQUNvZ2pPbTlWejEvN2t5UUlR?=
 =?utf-8?B?YjlRWDZJbjZJZzNNSWlIeVR3SkxJSDhkU0tNK3dtSUMvZWx6MGVtUm13T0NF?=
 =?utf-8?B?bWN1NElub0c3UmdIZ3NHcDZLWkJ5QUhScWZGTFdDbnZSWlEvb1I1c055c1A1?=
 =?utf-8?B?MWdmZ1Vna2c4VjFIZEFwcTFiWVNFcytpay9PemNwaHFSTis0QndNeW1CdmRS?=
 =?utf-8?B?cVdqV0VEVTYrdmFKQVBBdVZ3Yy9zSUx1cW9oQVRGYXlmdi9Bb1VDSkdKNER3?=
 =?utf-8?B?U2RmN1lLaGRHOFNucTBoTGFYYjlyei9TYUZiZll2YTVkdlpKc3dySzhsQU5F?=
 =?utf-8?B?UU1UYWRwUTFobTdqM2FuVzdZL01YK1k2UHRaSVFkMHdVajZ5WFZaa3hlRGE4?=
 =?utf-8?B?NGJ1bFF5RUYyVzZnUmJHUStrLzVndjFWd2JKemx5OTVsNHorczBkbyt4ZFVy?=
 =?utf-8?B?S3kyc0ptcXBYNHdCYmptUVMxamU1Slh2QzdJL21NMkFFQ05yUStldERUMURj?=
 =?utf-8?B?d2NYQ3c3ZzVrNTg4b2xaQUp4TG11TUo4V0VVTTB1TERwUmtWd1luR0FZeGJ4?=
 =?utf-8?B?NlhQVTZiWVAwUWVnU0N2YXk2MVd5WnlJalRDT2dhQUtES09ndjY3NW5ZWElm?=
 =?utf-8?B?Yk9oc3lOcVdlWGU4OCtsZHpQeERVak11bUdFMWpnUVZtUUVHS0tXTnh6NEpZ?=
 =?utf-8?B?Nml0SkowbzZhRCtsYXFkNCsybFlGZ0xJWm15d1RrY2FoeUZhRTJFWE5Lbjc1?=
 =?utf-8?B?VzZrRWRqODRoVHNJWE85akdnYzZtSmtWVTEzZXF6WkRiaU9TMVFwVmJJalFB?=
 =?utf-8?B?SGM1MWNzL09Bd3FUelJPYVFLaE5mbU00YVhwMlg0cjZtWjhVRFpTdkJhdStL?=
 =?utf-8?B?NExIUzFuYTZqbEdKU3dyRE1peXptc0hRbDRjS3owK09DZGpWWnFZczY2Q2R0?=
 =?utf-8?B?QlVLQ2lZRXpWRXR2b1NIL09hNUhMZzd0cWhuUE9pTytvTmh3UTBGOGR1eWo5?=
 =?utf-8?B?ZHZqSC9EUnFwTWF1d2IwYmhXVzFjTzNvZkpIbDkxVjJOSkM0TGJFNUVucUlS?=
 =?utf-8?B?dlltTGZhOEN6TzJaNGM3UEs4eEZqOWQ4alRKU1hQQUFiT3phWUpPZkdBMlg0?=
 =?utf-8?B?VzFybUtmWFZwSE5oZCtxdTRPd054Qm0zMGZKcElwNDNqYWVXNkdFOUh6aXl4?=
 =?utf-8?B?QmlLK21iSEpSQkl3azBURXVCSVRpbUhtYjdWajRxckgyVTRibVcrRmFMWnBR?=
 =?utf-8?B?bEZkV2pMSHRrU0UwUnM3VkNMb05qdFEyY3dGYnpXcE9ybnlpU2VmTFkyTDhS?=
 =?utf-8?B?dlRpOFFQN2l4UDlodlhQZFJ1SDhKT0FybE9kTzl3UDE1a0p3Ym53UG45aERU?=
 =?utf-8?B?dTRUcm56bmszUFY5cXBMdldjbFdDWUtnUmFiQ1dtb2tjVHhydWI4K25xU2tV?=
 =?utf-8?B?YjhSUnFLOWg3MksyZW9ZcG01UU13WTVUQXZWNUtBMVdOTDhucTdSbktOYzQ4?=
 =?utf-8?B?M0YrdjFJVWg2VXhXaVZQTS9RNks4bGtsY01CSTdjUFBjckRVbDlQeFJQM2tT?=
 =?utf-8?Q?bIbc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e48a1817-e976-4b93-7318-08dce907aa54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 08:43:51.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTC3Eb1iqhJGsvf7Vb8j45Izwm6jZQ0UctlzQMBaVv1emZIsM4bx7eCLgnAC9dVbhwHr1mjbV80JzS/kTm0VUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6896

SGkgTWljaGFlbDoNCg0KPj4gRnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0K
Pj4NCj4+IENvbnNpZGVyaW5nIHRoYXQgaW4gc29tZSBleHRyZW1lIGNhc2VzLCB3aGVuIHBlcmZv
cm1pbmcgdGhlIHVuYmluZGluZw0KPj4gb3BlcmF0aW9uLCBnc2VyaWFsX2Rpc2Nvbm5lY3QgaGFz
IGNsZWFyZWQgZ3Nlci0+aW9wb3J0LCB3aGljaCB0cmlnZ2Vycw0KPj4gZ2FkZ2V0IHJlY29uZmln
dXJhdGlvbiwgYW5kIHRoZW4gY2FsbHMgZ3NfcmVhZF9jb21wbGV0ZSwgcmVzdWx0aW5nIGluDQo+
PiBhY2Nlc3MgdG8gYSBudWxsIHBvaW50ZXIuIFRoZXJlZm9yZSwgZXAgaXMgZGlzYWJsZWQgYmVm
b3JlDQo+PiBnc2VyaWFsX2Rpc2Nvbm5lY3Qgc2V0cyBwb3J0IHRvIG51bGwgdG8gcHJldmVudCB0
aGlzIGZyb20gaGFwcGVuaW5nLg0KPj4NCj4+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4+IDAwMDAwMDAwMDAwMDAx
YTggcGMgOiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDAgbHIgOg0KPj4gdXNiX2dhZGdldF9n
aXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4+IHNwIDogZmZmZmZmYzAwZjE1MzljMA0KPj4g
eDI5OiBmZmZmZmZjMDBmMTUzOWMwIHgyODogZmZmZmZmODAwMmEzMDAwMCB4Mjc6IDAwMDAwMDAw
MDAwMDAwMDANCj4+IHgyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAg
eDI0OiBmZmZmZmY4MDAyYTMwMDAwDQo+PiB4MjM6IGZmZmZmZjgwMDJmZjlhNzAgeDIyOiBmZmZm
ZmY4OThlN2E3YjAwIHgyMTogZmZmZmZmODAzYzlhZjlkOA0KPj4geDIwOiBmZmZmZmY4OThlN2E3
YjAwIHgxOTogMDAwMDAwMDAwMDAwMDFhOCB4MTg6IGZmZmZmZmMwMDk5ZmQwOTgNCj4+IHgxNzog
MDAwMDAwMDAwMDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAw
MDAwDQo+PiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDMgeDEzOiAwMDAwMDAwMDAwMDBkNWU4IHgxMjog
MDAwMDAwMDM1NWMzMTRhYw0KPj4geDExOiAwMDAwMDAwMDAwMDAwMDE1IHgxMDogMDAwMDAwMDAw
MDAwMDAxMiB4OSA6IDAwMDAwMDAwMDAwMDAwMDgNCj4+IHg4IDogMDAwMDAwMDAwMDAwMDAwMCB4
NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEyMDAwDQo+PiB4NSA6IDAwMDAw
MDAwMDAwMDAwMDIgeDQgOiBmZmZmZmZjMDBmOWIwN2YwIHgzIDogZmZmZmZmYzAwZjE1MzhkMA0K
Pj4geDIgOiAwMDAwMDAwMDAwMDAwMDAxIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAw
MDAwMDAwMDAxYTggQ2FsbA0KPj4gdHJhY2U6DQo+PiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgy
NDANCj4+IHVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDQwLzB4MTYwDQo+PiBkd2MzX3Jl
bW92ZV9yZXF1ZXN0cysweDE3MC8weDQ4NA0KPj4gZHdjM19lcDBfb3V0X3N0YXJ0KzB4YjAvMHgx
ZDQNCj4+IF9fZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMvMHg3MjANCj4+IGtyZXRwcm9iZV90cmFt
cG9saW5lLmNmaV9qdCsweDAvMHg4DQo+PiBrcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgw
LzB4OA0KPj4gdWRjX2JpbmRfdG9fZHJpdmVyKzB4MWQ4LzB4MzAwDQo+PiB1c2JfZ2FkZ2V0X3By
b2JlX2RyaXZlcisweGE4LzB4MWRjDQo+PiBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3JlKzB4MTNj
LzB4MTg4DQo+PiBjb25maWdmc193cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQo+PiB2ZnNfd3JpdGUr
MHgyZDAvMHg0MGMNCj4+IGtzeXNfd3JpdGUrMHg3Yy8weGYwDQo+PiBfX2FybTY0X3N5c193cml0
ZSsweDIwLzB4MzANCj4+IGludm9rZV9zeXNjYWxsKzB4NjAvMHgxNTANCj4+IGVsMF9zdmNfY29t
bW9uKzB4OGMvMHhmOA0KPj4gZG9fZWwwX3N2YysweDI4LzB4YTANCj4+IGVsMF9zdmMrMHgyNC8w
eDg0DQo+PiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDg4LzB4ZWMNCj4+IGVsMHRfNjRfc3luYysw
eDFiNC8weDFiOA0KPj4gQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAwMjIgMmEwMTAzZTgg
KDg4ZTg3ZTYyKSAtLS1bIGVuZCB0cmFjZQ0KPiA5Mzg4NDczMjdhNzM5MTcyIF0tLS0gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsDQo+PiBleGNlcHRpb24NCj4+DQo+PiBG
aXhlczogYzFkY2E1NjJiZThhICgidXNiIGdhZGdldDogc3BsaXQgb3V0IHNlcmlhbCBjb3JlIikN
Cj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4gU2lnbmVkLW9m
Zi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCA4ICsrKystLS0tDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCj4+IGIvZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCj4+IGluZGV4IGIzOTQxMDVlNTVkNi4u
MTcxMmU5Y2QwOGJlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3Vfc2VyaWFsLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nlcmlh
bC5jDQo+PiBAQCAtMTM5NSw2ICsxMzk1LDEwIEBAIHZvaWQgZ3NlcmlhbF9kaXNjb25uZWN0KHN0
cnVjdCBnc2VyaWFsICpnc2VyKQ0KPj4gICAgICAgICAvKiBSRVZJU0lUIGFzIGFib3ZlOiBob3cg
YmVzdCB0byB0cmFjayB0aGlzPyAqLw0KPj4gICAgICAgICBwb3J0LT5wb3J0X2xpbmVfY29kaW5n
ID0gZ3Nlci0+cG9ydF9saW5lX2NvZGluZzsNCj4+DQo+PiArICAgICAgIC8qIGRpc2FibGUgZW5k
cG9pbnRzLCBhYm9ydGluZyBkb3duIGFueSBhY3RpdmUgSS9PICovDQo+PiArICAgICAgIHVzYl9l
cF9kaXNhYmxlKGdzZXItPm91dCk7DQo+PiArICAgICAgIHVzYl9lcF9kaXNhYmxlKGdzZXItPmlu
KTsNCj4+ICsNCg0KPkFjY29yZGluZyB0byB0aGUgcmV2aWV3IGZyb20gaGVyZQ0KPmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvNjRhZDc2NjEtNDU1MS03YjAwLTYwNGItNmUxNWRhMjNhMWM3
QHF1aWNpbmMuY29tL1QvDQoNCj5HcmVnIGFuZCBJIHN1Z2dlc3QgdG8gYWJvcnQgYmVmb3JlIGJ1
dCBQcmFzaGFudGggSyBjb21tZW50ICAiDQo+Tm90IHN1cmUgYWJvdXQgdGhpcyBjYXNlLCBJIHRo
aW5rIGdlbmVyYWxseSB3ZSBuZWVkIHN0b3AgSU8gYmVmb3JlIGRpc2FibGluZyBFUCwgb3RoZXJ3
aXNlIFRYL1JYIGZ1bmN0aW9ucyBtYXkgcXVldWUgcmVxdWVzdHMgd2hpbGUgRVAgaXMgZ2V0dGlu
ZyBkaXNhYmxlZCwgdGhhdHMgd2h5IGkgdGhpbmsgcG9ydCBpcyByZW1vdmVkIGJlZm9yZSBlcF9k
aXNhYmxlLg0KPk1vcmVvdmVyIHRoZXNlIGNhbGxiYWNrcyAoY29tcGxldGUvc3VzcGVuZC9yZXN1
bWUgZXRjKSBjb21lcyBmcm9tIFVEQyBhbmQgY2FuIGJlIGFzeW5jLCBzbyBiZXR0ZXIgdG8gdXNl
IGxvY2tzIHRvIHByZXZlbnQgdGhlc2Uga2luZCBvZiByYWNlcy4iDQoNCkFmdGVyIG1lcmdpbmcg
dGhlIHR3byBwYXRjaGVzIHNlcGFyYXRlbHkgYW5kIHJldGVzdGluZywgdGhlIHByb2JsZW0gZGlk
IG5vdCByZWN1ci4NCkZyb20gdGhlIGFjdHVhbCB0ZXN0IHNpdHVhdGlvbiwgYm90aCBtZXRob2Rz
IGNhbiBzb2x2ZSB0aGUgY3Jhc2ggcHJvYmxlbSBjYXVzZWQgYnkgY29tcGV0aXRpb24gaGVyZS4N
Cg0KVGhhbmtzDQoNCg==

