Return-Path: <linux-kernel+bounces-289473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F837954692
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C38B23128
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA49173320;
	Fri, 16 Aug 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GYWRhlCI"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CA81741;
	Fri, 16 Aug 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803258; cv=fail; b=rcBpz4DkRbw9P2Nlt6lvDl/qxN5wIgmN0mL+n/W70icFKrC08Dsxd9n+e2efK9L3hLWkJkPBnaCtHZ5b4r8xiPNSJtIiHzzvpo48V2o8Waar4N/c6HrDzJ5QSd1PxJNqZyIvOirM0TLiDdqwpVwYWGgSvrFR0ZAuJL22GoGC1rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803258; c=relaxed/simple;
	bh=jUFpq66U5KvonrHWqDnPxhAcmlg79ZIXnA+FmWml0y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlARBq/BBqKyoGktPRDWqlwNc3MsjlbwyEPuRki+aFlhV3GF+CHtv6Z6TSKihMYZYQk/WAcXmvraT5QbbI1qjVwaeRXjdp4LEnhG+/S46SxG+LHTQMKT4J03rfekOSfmpcE2own2V7/GiL9URqOFTjs0//QIQZ3NH7BqHi7GU3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GYWRhlCI; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ3xhdsy4XVJTcASU8G7iSw8uqLyWsz4MfYvRXL8wlM7fecdR36BTgDTDrAasjCNTZEhexMFmLQDejYOdJuORm3iRUh3qHnMl/JwjLVh1Nyfz9rLDJxZutBjX+6mWO/BeehVgSvIZQqosXEAhvCWUnrEvj1XEkmk9XUYZJXT1AovIV9sgxO5QgqOarDtA5rQ1f479TKUcwe6py8WKfaiYzkJws56HIF0D6cxPQ5M4b4/gauoW+JXSXGqUTjcCY6gY0UjfKBUzE97ceCBQcLrH2QG3zYqA6/xfBeAjRoKV+ObTsmmYIdFZ1IRpya0aTqcNbuDRObwHJuVyzfIWWFYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUFpq66U5KvonrHWqDnPxhAcmlg79ZIXnA+FmWml0y8=;
 b=tIsWXvCTxDqWo0nkIC9lHjJrBY5jjyIbNEHGyUqJs5i7UVrmWC/SG5B64pb+/qIf6zdRNWD1FkHR5KgXb7SAa+B/NEGBXy1yTJhJ+eKOGqDpOVoX0TI9QGL5R5JObVoRTlbYN7UHccCsyX6/vfq8Upcfbca4hGqfi5r+W/IRNFJqVjgdn+tV32lQvVR/hqJB3WTgw0z4BQR/TZu5jbIIqKU5GUa6Lq7ryURssfP46l3rA3DmW4GrID2nNDYaYc/IwN6EC9VG567fJSFS6eeDMR0s68CqECdNk2QDAR7Gal4g/gnTZ44lkGqvgsrJFFXP0MxJnvWc8QXyNAaR/jmcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUFpq66U5KvonrHWqDnPxhAcmlg79ZIXnA+FmWml0y8=;
 b=GYWRhlCIDsXQk+Q5Y6RsdAI2a/rSpIfG+LmOC8WxTOt82QT6b4ps1YWPAVcg/NofuEu+/O0YxIEINCWj+wj0I0fA3LhbAfskUYuxvduj7yUwFu1sXeTKDZRfyTchqjAXKQgkOdvUiCXJ1zXWCFr7VWuVYrPFTQi3sCXsTKVZkcQJo0KeVDCNAqh50JyiCwNAlH9WQQfFObXe+Benc3jeKTERaF7YA4Hd9PhLh9BLzs/jktN1Ckqr3/I55JC67xoH4e9ZvVBT0MHQSMWGZB5pPrXDCffY/YVwJdc0D8xfr4FcJe71/QHJ2/hd6ADm5QelVPKKgM4wvJ8JJXKZxSV5rQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5093.apcprd06.prod.outlook.com (2603:1096:101:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 10:14:10 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 10:14:09 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>, "sean@mess.org"
	<sean@mess.org>, "alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "knuesel@gmail.com"
	<knuesel@gmail.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYxXSBBTFNBOiB1c2ItYXVkaW86IEFkZCBkZWxheSBx?=
 =?gb2312?Q?uirk_for_VIVO_USB-C-XE710_HEADSET?=
Thread-Topic: [PATCH v1] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Index: AdrskDuj+tueDEmdT8O97cajpGGO0ADNHxtA
Date: Fri, 16 Aug 2024 10:14:09 +0000
Message-ID:
 <TYUPR06MB6217A9C87F641E0D70D40BE1D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62176817F2096C7448636F59D2852@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYUPR06MB62176817F2096C7448636F59D2852@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5093:EE_
x-ms-office365-filtering-correlation-id: 816ee806-1e6a-4386-0c52-08dcbddc2b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?RlB4Sjc4S3VZYWpKTWs5elJpRStyd3dKNjNta3ZwNUlEM0h6SW9SOEp5VExi?=
 =?gb2312?B?MFE3dTNwN3Q5SjJYYTU3RlNqaUF2bDF2UjFqZlg1b3dRTWpmakR5OUEyMlYw?=
 =?gb2312?B?Tmw5Q3dHaTVoVjdncmdVUSs3MW5SZUU1NFZld1Z5QnNPa1FZc1o2L0JiNEtD?=
 =?gb2312?B?QXJ4ZGtLeVlPQWlucmRzcThpVzFrWVFnRVoyNmNvdjN2Wm1CRVpnK3krWENZ?=
 =?gb2312?B?NGp0SjJYL2YycnphV3JLY2dIVlp1UC80Rk5hWi95L3I5QlhZUVdPZnVNbHh0?=
 =?gb2312?B?ODhhdERiYVdXeVZocnByVXI5TDBQYlljcE9xeTJoUGFweCtROGxxRTJKTHNx?=
 =?gb2312?B?alB5TXd2WGQxUDdaL0ttZHVkLzdZdk1WQWNueTQ0MEIxTjNXM2x6Y2o3NVdZ?=
 =?gb2312?B?QzF5ZEpweWRRUzdvZ3RjekFhY1pwcUxlZHhpTlUzTVlDN1NCYlZrTUdYRkc4?=
 =?gb2312?B?cTkzQUJhai9sRXdWTWpFdFFuUjRWOUwxTEJ2UmxkYmpKK3h3SGVWV3M0TmJ3?=
 =?gb2312?B?a3Z5cjFaSlhMM0J5cVNjRzd1WW1jbEcrTndXdjZqekhqSHVGRGU0UWFOWlhy?=
 =?gb2312?B?RU5zYU5Pa0hJMFQ3bXNPNVZVMzNmcm40SjlTVjNtNW1WRllyZXovclFhYXV4?=
 =?gb2312?B?VFJtZTNKcjBSOVZib1lMUXAxeC94SERNbzNqWWlzdm04bGJMMFlCcFFCOHhM?=
 =?gb2312?B?WTQyeGtJZG9qYUp4RVBqSTFWZTBlZkR6R2w0V0VNVmhld0dROFl5Y2xPYldm?=
 =?gb2312?B?c0t4S2xvemZiT0lBQXJyWnYrdWRBdkdXZXh2SEQxY1V6c1pqSGc1bTdRMzBo?=
 =?gb2312?B?QmJES3dEcmVrWkp0aUdXNlloT1hBc2pHM011RWY4OFJUK1ZTd1lYNlBUK3h2?=
 =?gb2312?B?TjRkb0E2OW1Id0o2NlB5aHRMSFRYU1E4U3h1dDhiemV0YThKamNHdHE2Mkg1?=
 =?gb2312?B?TnA0T3JPa2JhbjRHWlpUSmwwVy9LOGRGeERpMHZ1YWhNaVdzLzlEaE0xb0NL?=
 =?gb2312?B?MmJ6cGxiU2IrcktncTVrYk93WFNDNUMrZGY2VmdWK3JScnhtTkRRdG1PQkVy?=
 =?gb2312?B?eGNvdHFlMlJVTzY5eHZVRllNYVRNOGpwc3FYbTVndE1mVWxTWlBDbDBnNWhO?=
 =?gb2312?B?WS9NNjB6WmpoOXplSkdOc3J0THNHbXJtV0g2OVVHaFRtdWlnVEluNlZXUnN2?=
 =?gb2312?B?UjVROUVRbVNnd01Pc1BWQzJWNG1ObjA3Mk9hdXpqeGxDb0d5K3EyekFDM0di?=
 =?gb2312?B?eDFFUlF5V2l6ZEJvTmxFUE9aM3JCdTlCRVBjcFRNc3ZwanpPUG51NGQ4UHlx?=
 =?gb2312?B?MkpPS2xOaVpMSnF3bUFqMmd1N0RqV2FWeHBlOHV5cVNWem5NQXJWeElrRjhi?=
 =?gb2312?B?RmlKV0VmZXRIeUgxT0xDYjkxSFlUTW9pMTcwSFdoRkdRNTkvUlJ5Mmg3ZGVY?=
 =?gb2312?B?Ny9UZytEaWVhRmNVSEJTZDVkalJ3dXpKcHFubmxFOXAwRWRjUlhlSzRMNnpJ?=
 =?gb2312?B?N2txSFpnWjV2RWVxZU1SaWlhcFlQdFd1eG5XYnNZa09PbDJzbVZaOXRVSlFy?=
 =?gb2312?B?OS9mTlBLSWRyKzVQSlhXdEVld2M5U2d3SkFzcDRYd3Z1MjhySnl4dEIyMEp6?=
 =?gb2312?B?MGhaSmx4UldKM0xSWTlheS9mZDNtWVJvNFZEdWhZVHhzWkpvdzVyc3UwMUtZ?=
 =?gb2312?B?dkhndVlFdGVLNWdiQkNpTnhGZmc5ZkMrc2ZpTGt0QWczZ0tnNEQvY2FlMEFF?=
 =?gb2312?B?dXc5SEZVRWYycCtIUlB6M1FwelZvSG5zZFh0MW1yZ3pJMzdUcVREVFUrbFh4?=
 =?gb2312?B?V3lDZnNxTHQ3YmN0ekRmU08xYURFaUhEN1NwK3M3bXRaQVpMbVo1YTUwTnk4?=
 =?gb2312?B?WnNxMjF4cTkva0FLTUE4MGJVTHYzSGNHMFlEMTNBQkMrOEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UlZYdGhBSHJ2Ni9Gc3hST014ZklvWnRzRktsVWh2Y29mRHZpSGtmU2VHNnUz?=
 =?gb2312?B?NXpEVElqZzdKY0VsMFVhaFIvenNKeVpCdGZ6a1lSMXZWT3RtSkZaMEQ0d3Vq?=
 =?gb2312?B?dW1rK00rMm8wVDZGQnUyN2xIbTdNKzZ6c2ZoRVo5ZHZCTDJJM3p0alpxOFdC?=
 =?gb2312?B?V0R3YVE4dHlWQVJTWGVJMTV5dGdpYzdha0ZUNVhWdFNXblAyUkFZTmNXTnVB?=
 =?gb2312?B?TVJEaE5nNFFqTG5EKzg2TUNFNFIyOTRnazBDY1hkWlRhV0pJc1JNN0JyNEVT?=
 =?gb2312?B?NkptZkRZMW5XRHJRQ1p0SGpLelBCNkw2VU5xenN2Ulc0S0hOckxsTm55UXJr?=
 =?gb2312?B?Z3lXOTIvNUhZN1RDME9CQlN3S0xDWEhMdCsyOCtYb0YrN1ZyWGtZK3l1ejVy?=
 =?gb2312?B?ZU4xM2s0Q013ZmR6NmZTZXBBOGZtbkRKd3JIV1ZjSi9teE8vbzJxTlJYL2Fs?=
 =?gb2312?B?UmdxTWovc3JIbDFpbkxaN0J3MzJEdWhFM2dSVG1Ob3hWVWNpWnNrN0Y0Mk9O?=
 =?gb2312?B?V3RzM2Nsc3JoTTRQWWZUMzY1azhlVHVCNmJ1bTZ2aDhQZk9uOU1wZzhLc28r?=
 =?gb2312?B?eHgzNTNsRjJqRUcvS3BNMks2d3hpY2R4ODUrbGE1a1FhdFJ3S3gwcCt3SVdx?=
 =?gb2312?B?U3V6ZHh5cXNiYmFXN1BOaU9rU0prWmF5WjNGMGQzcG50Mk8wZ1ZZSU9kdU4r?=
 =?gb2312?B?QzBQK2c1QnBlalE1WHR2SndyRTlzbURLUGpxV1Fwc0ZyL0RhZlNQLzNrdXh1?=
 =?gb2312?B?QU1mbUdWRzlEU1QyUnpxc1NiOE5OTDJuN3RscmtQam1oZHl4SndFQ2VjQVQr?=
 =?gb2312?B?aXVCQ2kyeEs0UmFONjFXdVhPSGVkSFlwQTJHeTcwMGltWUVlTFNycEpoWHY2?=
 =?gb2312?B?Sk9USkpFK0VMSmtLdHBvNmF1M3k4aHlmMWszTGk3U09TbmdYWXJ4N2J4LzV1?=
 =?gb2312?B?WFhyandsL0tGMWpWSHlpSWcwaTVhVU8wZ0JNcldxWTdkZllrOXhZZWphMU44?=
 =?gb2312?B?M3RNQmZmUldncCt1elpuVG1OWDE1WEhxblFkSVM1cTBkYVJyZzhuMTYxK0tq?=
 =?gb2312?B?bzJxWDNvK2xkZDJKSTJrdG5NMHR1d09xYUpFTWpaaWFxSCtFUnUvdGN1ZURP?=
 =?gb2312?B?bHhVNEJMY0ZONWNrSW9DYUszQmRBRzRQcVFndjU4TWNlaStqREVSaC9RYUpJ?=
 =?gb2312?B?Q0pldU92bDF1dmxTNkNqdGEvbHY0VmV1b3ppaVlNcU1URmhNbWlmYW13cEZV?=
 =?gb2312?B?TmxDYXQwQ1pqMmh6WVRkSEVZS3U5enhjZFRVUTVXWnN6NDZ0UGpCTWVyMVJz?=
 =?gb2312?B?RVk3eS93QmpRK00xc2xCeHluNnczY09OcjM4YmIrTExNSkw0TWxKWDU2am1i?=
 =?gb2312?B?WVh6Ym9OcEJ3Z0lqTzd0TzZwZDF2dVVYajBjVms0U29PcHJlQ2ZlbVJqaExS?=
 =?gb2312?B?b2ZLZ2pES05HMnRIQWI0ZmREYTMyVExOL1J3aGN1emRQUS92VFRBeWZ2NlNY?=
 =?gb2312?B?MnVpc3NvOFVFZ1hCa0NaKzVyWE5Qb3RaWjJxWVNuclJDM2VDNHFJRVpaTGh4?=
 =?gb2312?B?V08wM1NhQXdUL0laczBSRFZuZXJEREtyVVFvaFZTcFBVVW1jQmxPdDRuWHgv?=
 =?gb2312?B?TjAxN1RUanQzWVFhUW96VXNocXNvcUpLeWpBRWJpWnVlalpWcTErbWUySDA1?=
 =?gb2312?B?dlNlVkFYajhYZGppdzRWcTV5Sk5VV29DSkE2RW81a0ptcFZqQnNQUVRBczNP?=
 =?gb2312?B?UFh4Y0lJMWNXN2l4MHZIR1dtSmFVSG1yUWxleDZJYXJEM1RzajB5MWJWVEZy?=
 =?gb2312?B?eFR5ayt3YWxFL0tzaWFIL0hDVVJRcXkvT3Q2S3lkS0Y5Q0NRWmNLeEt5ZUtU?=
 =?gb2312?B?R3VvR2x1K1AzLzVyVnViSUM2L3lmbHpHcW1OUlVMUU1YSXZrbmNkcXFvM3lW?=
 =?gb2312?B?a2FZb1p5M3hIN09Ud2l1aG1NQVc2QjBnQlNRMis1ODU3cmdEcFFCWGpNemt2?=
 =?gb2312?B?c1VyclpRQzl4emtOZmpRUm5Wd2E5NWF2R1NYZEN3QkFpaDJ6Z1hFZ0N2RjMx?=
 =?gb2312?B?OWRQUisvUGF1STlQQjZNTU9LVy96Vk5KQW9NaWppZEYwVWs5SUJGNVRXc0RW?=
 =?gb2312?Q?JTFU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 816ee806-1e6a-4386-0c52-08dcbddc2b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 10:14:09.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrHsPxjWtmy61ix7bWSxlrfyiiihIicm/f9mAceGm0wtCGYFUeIRf6Y3aAAihUhzAcukMcXLjkmgkqdS7i8NHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5093

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCiAgDQogICBXaGVuIGlzIHRoaXMgcGF0Y2gg
ZXhwZWN0ZWQgdG8gYmUgbWVyZ2VkIGludG8gdGhlIExpbnV4IGJyYW5jaD8NCg0KVGhhbmtzDQoN
Ci0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiC6+sGsx9ogDQq3osvNyrG85DogMjAyNMTqONTC
MTLI1SAxNjoxOQ0KytW8/sjLOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQqzrcvNOiBw
ZXJleEBwZXJleC5jejsgdGl3YWlAc3VzZS5jb207IG1iYXJyaW9saW5hcmVzQGdtYWlsLmNvbTsg
d2FuZ2RpY2hlbmdAa3lsaW5vcy5jbjsgc2VhbkBtZXNzLm9yZzsgYWxleGFuZGVyQHRzb3kubWU7
IHhyaXN0b3MudGhlc0BnbWFpbC5jb207IGtudWVzZWxAZ21haWwuY29tOyBsaW51eC1zb3VuZEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5zb3VyY2Uu
a2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmcNCtb3zOI6IFJlOiBbUEFUQ0ggdjFdIEFMU0E6IHVzYi1hdWRpbzogQWRkIGRlbGF5IHF1
aXJrIGZvciBWSVZPIFVTQi1DLVhFNzEwIEhFQURTRVQNCg0KSGVsbG8gIGxpbnV4IGNvbW11bml0
eSBleHBlcnQ6DQoNCiAgT0suDQoNClRoYW5rcw0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7I
yzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPg0Kt6LLzcqxvOQ6IDIwMjTE6jjUwjEyyNUg
MTU6MjMNCsrVvP7IyzoguvrBrMfaIDxodWxpYW5xaW5Adml2by5jb20+DQqzrcvNOiBwZXJleEBw
ZXJleC5jejsgdGl3YWlAc3VzZS5jb207IG1iYXJyaW9saW5hcmVzQGdtYWlsLmNvbTsgd2FuZ2Rp
Y2hlbmdAa3lsaW5vcy5jbjsgc2VhbkBtZXNzLm9yZzsgYWxleGFuZGVyQHRzb3kubWU7IHhyaXN0
b3MudGhlc0BnbWFpbC5jb207IGtudWVzZWxAZ21haWwuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5zb3VyY2Uua2VybmVs
IDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT47IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcN
Ctb3zOI6IFJlOiBbUEFUQ0ggdjFdIEFMU0E6IHVzYi1hdWRpbzogQWRkIGRlbGF5IHF1aXJrIGZv
ciBWSVZPIFVTQi1DLVhFNzEwIEhFQURTRVQNCg0KW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwg
ZnJvbSB0aXdhaUBzdXNlLmRlLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KT24gU3VuLCAxMSBB
dWcgMjAyNCAxMDozMDoxMSArMDIwMCwNCrr6wazH2iB3cm90ZToNCj4NCj4gRnJvbTogTGlhbnFp
biBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPg0KPiBBdWRpbyBjb250cm9sIHJlcXVlc3RzIHRo
YXQgc2V0cyBzYW1wbGluZyBmcmVxdWVuY3kgc29tZXRpbWVzIGZhaWwgb24gDQo+IHRoaXMgY2Fy
ZC4gQWRkaW5nIGRlbGF5IGJldHdlZW4gY29udHJvbCBtZXNzYWdlcyBlbGltaW5hdGVzIHRoYXQg
cHJvYmxlbS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8u
Y29tPg0KPiAtLS0NCj4gdjE6DQo+ICAgLSBNb2RpZnkgdGhlIGNvZGUgcG9zaXRpb24gYW5kIHNv
cnQgYnkgSUQNCg0KVGhhbmtzLCBhcHBsaWVkIHRvIGZvci1saW51cyBicmFuY2ggbm93Lg0KDQoN
ClRha2FzaGkNCg==

