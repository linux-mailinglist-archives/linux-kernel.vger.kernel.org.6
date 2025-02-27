Return-Path: <linux-kernel+bounces-537141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18384A4886E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD014188B1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB226D5AE;
	Thu, 27 Feb 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="St+q02zH"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4D26D5AB;
	Thu, 27 Feb 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682714; cv=fail; b=cgT+Z21YRHnxIq+xEEILclAU/AHcz80gy7/caEk2nkfNAD7NA7asleotH/lGjyhfBLzKwFf5suvPOFuGhODDyGRe7KsJqnb1Z1csQiuKvxKuBY4+UQdj/WHIqkj+Mpmwr5BruXGcS00YUFVsqEdsIolRIpLWaBY7W6L7g39QaEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682714; c=relaxed/simple;
	bh=JJgPmcwR41GTd4qM7UnFMPOzs2ZBMts3/xMWFnoG9LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sEnMI0y5u0SBgm2w7FrGGONXyEQduMhB8bfwEie/3kMu7MjqHykzUWjTZC63wXMj8ndC6S4hP6daLEF5JXSg4GsHd+HqmpY1g5WX6/AVinWTJnaf7hrPsIy9CTBbQJvXO1EkeIvfVfszgHH7L8tnjCnUQGVF7OAOEY8QoVqj6SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=St+q02zH; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR/O3Gc98bUNLsHAyx3f5k5TEJo3vHVQBGcGIwNhLjOa+joPqRzNqUUU45AXC7nKhUTd4jkflAD4SeXFlPhe53paOvYJdzSl7qGDgaEXUCGJOvtBIRpx73OP0o8Z6Fn8NkQv5vKGx9fq+Qtfx7A3qpgHKYtuLzmU4nobiFJJ+MFJu4digP2Dmdh9/nHw4FjQKSR/FpCYRuCoNwaAIW5LQsydmGO5cil8CySEdSzc2nE4h+XlMmYitAnBkcQkm3L5KexZoOQYwPxEummT9jkSZuCKVpI/7CaihAByeM3BKprm42sWtAJfIDhLrAvUfGlNlJ2jfrbfsahcfjCUBgigSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJgPmcwR41GTd4qM7UnFMPOzs2ZBMts3/xMWFnoG9LI=;
 b=qjM7H6RRHZaochh8gch5WjfQKpps/2blHlF20ZZ3p+ggwIHTMKFeaV6bPMokJcov1dFH0TpfYAcXO70FDWk5Evhb2pJ8IuRM4UIb7BGRBrRSkXa1h36c2ZW0IQDyz7WU7o62HC4uixppLooEEftASbp8lVOjhat0lD7XxgUmKfRhXtMm+Z/TGzADxBE5UMK/9edCCr4AA/q/zYG2LZfR6E+Kg+B2A/qbq5Brcf5Mvzm+d7OudP7vPjHV+t9DEEjafWrrRlVEWy2zRM2tmTF4mF29k3qDzIHFJPZl8wx+vDwnCQc5XW5as/wNobGeYyhCjjnLfiOCNJIMK/c8klsV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJgPmcwR41GTd4qM7UnFMPOzs2ZBMts3/xMWFnoG9LI=;
 b=St+q02zHUR0f+iNjAa9lMnaA8SbeUftmBBdw3CE2A6TuWjVY/F/nbRLz7eyoOUbOC661sd7VLx8hiK5YPXnVF9nEgwOZJUEgP9Oaom93ZWGmjDQ7IK7TzZo+SwSPIgnMf/QOLv4Zqm7/oSNbjRHNfZ90/MVwdwLFUI53xyzr1/t4zQlBSKAyiwOFmelWMCGX9wTjmvAKhkjTnay6aEvDHMi83rjJFjweoQ/wS/13ahKjLhk8CgRwQ94xjw/uGxkhMrwVicIOWXUvPVQSt8Vukhwap7tF6bAFV3A1TWBndydwCdnL8Iyy/vU8TwcA8gbfPfI1fRUM69ueuMxtJqg0/w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7934.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 18:58:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:58:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "pmladek@suse.com" <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Topic: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Index: AQHbiOEjzUrALYS3lkmTQCvm8eL6dLNbOimAgAApL4OAAB3pAA==
Date: Thu, 27 Feb 2025 18:58:24 +0000
Message-ID:
 <PN3PR01MB9597D1584C472757EB9F9C26B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597916417D398179C55BD98B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597916417D398179C55BD98B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB7934:EE_
x-ms-office365-filtering-correlation-id: db5a60d6-30a6-400a-e5da-08dd5760b627
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|7092599003|8062599003|461199028|6072599003|12121999004|19110799003|8060799006|41001999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?SjAvNXUvWFhWL0NBVThyZ0gzbjQ1cWFZeUwrTmtMUmtmV2RJakZtMlQyeWxJ?=
 =?utf-8?B?VU9UN2F5QkFtRlllZkZBMWJQWEI2eDBueDcvWWZmcHlhUzVpdjZTRHlTSDZD?=
 =?utf-8?B?WG1vb3hyZWx1YVBVODh5eE1ncTFacHlod1p4NVBYOUk5Ymd1U2NJVWNJdkVF?=
 =?utf-8?B?STJjK0haL0tjdUprRi9CSHRENUJnY3NQM2V6MmFwOERlV25lOTI0Ykl6c09a?=
 =?utf-8?B?RmlkcU1jV29XMjFqVmtXRlBjY2VKcGZKc0JSVmFqSDJud1RKVUcwVXMweTYr?=
 =?utf-8?B?VlNNY0s3N1RpSnY4aisyZWJpZ2g4RXNDSFdjWHlqdlBKcGpCWmJCTDYvWXBT?=
 =?utf-8?B?NnpBcXBmejN0RjFBYnFzVEQ4eUdsUlBXMG5ZcXAwUFBtZzM1ZHhnL05iMnNq?=
 =?utf-8?B?ZEhKaGlxL1U4bjhDcGVTeUdla25YMVRiSG1XWUtvYiswaW9Kd1JDT05DSXFL?=
 =?utf-8?B?ZmJLNGdKSTFmY3ljRURsbUVOaXBObzk0VllyU0RYZXBBQXdoRmR6ZSt5MzI5?=
 =?utf-8?B?dFJqNXpBblpoVW5wQXp2ZzFNd0hpNUtIUzZHYXlUNTJaekdDa0pOQ0cvalM0?=
 =?utf-8?B?blJXR3F0THBxYWszVnVvakxqOXp5TVdZQWdqeXBja3FOVHIxZjNIMStENUY2?=
 =?utf-8?B?NzFmRWV0T1dHemhWYm9SRHIrbEtVeFl1T0FTeDM2cjZhUmJQdVhxSGpBN0Ix?=
 =?utf-8?B?bTFYeU1nOGhQQkFrQlQ5eWRLMkNTb2poakh2c1JacFRKRm9EMHZSb05XU1hw?=
 =?utf-8?B?VTlZY1BkWHBGSWpXdlBML2hrQzdoV3prRmNpUWo4WHFwaVdQSUcxWmw3WmtM?=
 =?utf-8?B?NlhwTHdQWjZSRjhFc0lDRjlKZWlaZFVTbTRGNFFQM1pWWEcyajFqZWJWbjBa?=
 =?utf-8?B?QytkdmR1Y1hIRXBQMk1FOVY3ejl4NDRnbFFIa0lkY00yUVN3VGRqem93QWk3?=
 =?utf-8?B?alllVjZtMTVNYm5mR0QyZ3FhTXF6bzluQmNyV3NhaCthM3F6a0x1dFJmRHB4?=
 =?utf-8?B?L2JiaENTVkIydi9pOFVBRkJqanUwMitLS1lQZmo4bGZXcThZbFJ3ajFzbG5T?=
 =?utf-8?B?bUVNQ0FjbTdiNUZSNTJjZWVwV2ZQdjBlRlVDWXhJMXJ5SXNLM25YelN3bkpr?=
 =?utf-8?B?SzEyZnJHSVNndGptbDRWeThzd2o0T2RlcDlLYUpPeWh2blk4NENZblFwL0kx?=
 =?utf-8?B?M3pYOXZUV1ZkZGM5Z041KzViM0Y1dGpkOVZpbkNDVWdjSXhzanN6MlZmY1FZ?=
 =?utf-8?B?YjRCcDNqMWE1YmZrQUZGUnhBTFZWT2FBMlRBVTNNSVliRGpYR2xkU0prVUdl?=
 =?utf-8?B?akhqK2IyeGw0ZjA5K0kxOWR5QWl3TjUzWEI5ek1hWVVJbjFPSmRoN1pNWERt?=
 =?utf-8?B?amRpNGdjV2JMSGptVHFpaUJEdkpnNEpmdzBHaUtXdFJhYzhmbEVyWTdVbHo2?=
 =?utf-8?B?R2hiOHNsTE5NYlZDQXN0dmNYc05HMFpYRHZaWHNyMmdDZFlPQStOS1FPblVu?=
 =?utf-8?B?MHo3UUh1NGRsMHlUdkVvQlZIZEp5M3E1aDg4NDhzSjNiWU5mRGxUQzRDa1NC?=
 =?utf-8?Q?h5w7dClfZj1lZp/FvCQje/A9A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWovenQ4N3N6cWluSDVrN0xmRWtDcEF5THdMbDNVMlBXVG1PVHhPek5OcndO?=
 =?utf-8?B?VHpXVzlaYk94VDA3NVZTWklwT3RUOGVkTXcyYi95UGpRM0JRcktlN3lKcnFC?=
 =?utf-8?B?OEw1NGlCbHdIelNCYjVicTdoOU8wM3UxMUphUkN1VXBPQVFvK0VBZTczSEtP?=
 =?utf-8?B?L2VNWkRJTk9PaGdEN3BxVVBmZkdqQS91MU5TWDA3MWlnZkFSTHpZUUlPc0NZ?=
 =?utf-8?B?TDhJalFxT0lFRkc5QVpOOWdHcjcrckl2dnFUNHNCcFlHWTFlTXEwTmU1YU82?=
 =?utf-8?B?b3haVHRna3RFRHVLOTJYUDJGQVJTWEFtTEJiVFBLMG1UMHpvSG5TZEdPbkI3?=
 =?utf-8?B?VFY5bVJFc3oweFR5N3JITXY3UGQrL2FQYVFUdXQrSUhYSE1vNmNSaUZjMk9t?=
 =?utf-8?B?Q3FIKzJ0QWNsU256RnM0T0RNeTFBRi9lcDFWNHBzWXhGY2RjemFGc3lsZG5k?=
 =?utf-8?B?WlV6Z3RTUi83ZXRBYTJWQTFZRVpvY2pLL1poVlNTTlBGc2NPRlRIZGRjekJO?=
 =?utf-8?B?b0ZPOGo1eDkzQzBnenRjM0lDTlNLUDBQdC8yTlE2aTh6M1B4bXM5VEtoR3g3?=
 =?utf-8?B?NnpDUDZvZEhpOHlWQ0x5UmpzNmpUSFZkUkxxY1E1aUJ6M1RVT0VxbW1UbVZQ?=
 =?utf-8?B?NHZub0FuN1B0MUpMdWpCRkRyNzJheG5HS3ZVUzZsMHp0TndBbDhudjQ5aUhO?=
 =?utf-8?B?WDlMN2hON0NDQ2xCSkVpRmNKSFB5WC9zdnhWSXoycGNSTlNTZ2IyMnJGaDhE?=
 =?utf-8?B?ekFzd3o0NjMxYm8ydHo4V3ZYUzd0azlRQXNtczRTclA1ZUlZVDFSZCt3UVVj?=
 =?utf-8?B?bjdWZGUzYTdpTlhaL2pXWE1ZaFVyRTNvMENoZmFMUHR1S0FDSDdNMkVjZ2h6?=
 =?utf-8?B?WVpENjhGOTNqY2pBL2JpdWp5N3I5Rzl1bmdQNzF3RGUrcC8yNjl2Qm56V1Yr?=
 =?utf-8?B?RFhkc0YyZUQyUXNwNi9YRXBUU0o0SXpzRWQrRUptNm1WSG5FRGE4KzRFZmRV?=
 =?utf-8?B?VzdFS3d6UEdBa0YrbXlEaUlXOXJoSEFYR1NvQ0hRbGhKaVVUQllwaTgxVmQ1?=
 =?utf-8?B?MUNpMTNTZWNXNzNlU28wKzlkRkh6Z2dZQ2NzVElkRTFtbjlrdmdJVUcxZTVm?=
 =?utf-8?B?RUZrbytBVkRJVk5kTlJDd2wxNkhKQzJkTmVVS245dms1RkNaMVNKcW1ERU0w?=
 =?utf-8?B?SHladUhQLy9LR0lZalEvemNMb3lWbmwvbVFGQVBsdzR6NFkzRzFRc3p1K0Qy?=
 =?utf-8?B?OWFNTkhmS3cwZnFGdUhnNzJseGVHUDFUMnNYMDQyb1pSN1lEY0V0b09RdTR1?=
 =?utf-8?B?UjF3TGxadnVoMWR3WkFXWG1UL0tqQUJTbjllMUZZRmpmUzNjRlBuSTJoaDZr?=
 =?utf-8?B?ZGJSMHBobXdFa216T2p5VGdzYXdFbWNqZXJxckFPck4rNlJ6akJxSGUwRU4w?=
 =?utf-8?B?RDMvbHY3S0grTHFVL2t1cy9zbTZzaWk1REpFT0VQcUYxQjdvS01PK0dlTVRv?=
 =?utf-8?B?cFR6YnV0UDdYbmRhT1UyMFl6c1FMcHRadzJMd3hhOUd6MWxwVk5nbmpTVHRi?=
 =?utf-8?B?NDV3c0d5ME1veFAxVFJBMGxMU09mVy9HZ2FJenQ4cnFMelpVVTNqczdUQVFM?=
 =?utf-8?B?STBVU1BkcStCSXZPeTd5U0YwL1IyRVplZG1hOHJzZHp1TTBZZnV2cjBOaC8x?=
 =?utf-8?B?NHFqdDlPaU5jTlNlcy9QSjVBUG1kMmNwK2RCRnRGNGdsVVZCekhwbGpZT1ZJ?=
 =?utf-8?Q?lUd4rLEUsI0GU92Xtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <0B03533BC5B7F44DAAAEDA62CF4E118F@sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: db5a60d6-30a6-400a-e5da-08dd5760b627
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 18:58:24.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7934

DQoNCj4gT24gMjcgRmViIDIwMjUsIGF0IDEwOjQw4oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IEhpDQo+Pj4gT24gMjcgRmViIDIw
MjUsIGF0IDg6MTPigK9QTSwgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3Rl
Og0KPj4+IA0KPj4+IO+7v09uIFRodSwgRmViIDI3LCAyMDI1IGF0IDA2OjMwOjQ4QU0gKzAwMDAs
IEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IEZyb206IEhlY3RvciBNYXJ0aW4gPG1hcmNhbkBtYXJj
YW4uc3Q+DQo+Pj4gDQo+Pj4gJXA0Y2MgaXMgZGVzaWduZWQgZm9yIERSTS9WNEwyIEZPVVJDQ3Mg
d2l0aCB0aGVpciBzcGVjaWZpYyBxdWlya3MsIGJ1dA0KPj4gDQo+PiBGb3VyQ0MgKGFzIEZvdXIg
aXMgbm90IGFuIGFjcm9ueW0gaXRzZWxmKS4NCj4gDQo+IE9rDQo+PiANCj4+PiBpdCdzIHVzZWZ1
bCB0byBiZSBhYmxlIHRvIHByaW50IGdlbmVyaWMgNC1jaGFyYWN0ZXIgY29kZXMgZm9ybWF0dGVk
IGFzDQo+Pj4gYW4gaW50ZWdlci4gRXh0ZW5kIGl0IHRvIGFkZCBmb3JtYXQgc3BlY2lmaWVycyBm
b3IgcHJpbnRpbmcgZ2VuZXJpYw0KPj4+IDMyLWJpdCBGT1VSQ0NzIHdpdGggdmFyaW91cyBlbmRp
YW4gc2VtYW50aWNzOg0KPj4+IA0KPj4+ICVwNGNoICAgSG9zdC1lbmRpYW4NCj4+IA0KPj4gVG9v
IG1hbnkgc3BhY2VzIDotKQ0KPiANCj4gT2sNCj4+IA0KPj4+ICVwNGNsICAgIExpdHRsZS1lbmRp
YW4NCj4+PiAlcDRjYiAgICBCaWctZW5kaWFuDQo+Pj4gJXA0Y3IgICAgUmV2ZXJzZS1lbmRpYW4N
Cj4+IA0KPj4+IFRoZSBlbmRpYW5uZXNzIGRldGVybWluZXMgaG93IGJ5dGVzIGFyZSBpbnRlcnBy
ZXRlZCBhcyBhIHUzMiwgYW5kIHRoZQ0KPj4+IEZPVVJDQyBpcyB0aGVuIGFsd2F5cyBwcmludGVk
IE1TQnl0ZS1maXJzdCAodGhpcyBpcyB0aGUgb3Bwb3NpdGUgb2YNCj4+PiBWNEwvRFJNIEZPVVJD
Q3MpLiBUaGlzIGNvdmVycyBtb3N0IHByYWN0aWNhbCBjYXNlcywgZS5nLiAlcDRjciB3b3VsZA0K
Pj4+IGFsbG93IHByaW50aW5nIExTQnl0ZS1maXJzdCBGT1VSQ0NzIHN0b3JlZCBpbiBob3N0IGVu
ZGlhbiBvcmRlcg0KPj4+IChvdGhlciB0aGFuIHRoZSBoZXggZm9ybSBiZWluZyBpbiBjaGFyYWN0
ZXIgb3JkZXIsIG5vdCB0aGUgaW50ZWdlcg0KPj4+IHZhbHVlKS4NCj4+IA0KPj4gLi4uDQo+PiAN
Cj4+PiArR2VuZXJpYyBGb3VyQ0MgY29kZQ0KPj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4g
Kw0KPj4+ICs6Og0KPj4+ICsgICAgJXA0Y1tocmJsXSAgICBnUDAwICgweDY3NTAzMDMwKQ0KPj4+
ICsNCj4+PiArUHJpbnQgYSBnZW5lcmljIEZvdXJDQyBjb2RlLCBhcyBib3RoIEFTQ0lJIGNoYXJh
Y3RlcnMgYW5kIGl0cyBudW1lcmljYWwNCj4+PiArdmFsdWUgYXMgaGV4YWRlY2ltYWwuDQo+Pj4g
Kw0KPj4+ICtUaGUgYWRkaXRpb25hbCBgYGhgYCwgYGByYGAsIGBgYmBgLCBhbmQgYGBsYGAgc3Bl
Y2lmaWVycyBhcmUgdXNlZCB0byBzcGVjaWZ5DQo+Pj4gK2hvc3QsIHJldmVyc2VkLCBiaWcgb3Ig
bGl0dGxlIGVuZGlhbiBvcmRlciBkYXRhIHJlc3BlY3RpdmVseS4gSG9zdCBlbmRpYW4NCj4+PiAr
b3JkZXIgbWVhbnMgdGhlIGRhdGEgaXMgaW50ZXJwcmV0ZWQgYXMgYSAzMi1iaXQgaW50ZWdlciBh
bmQgdGhlIG1vc3QNCj4+PiArc2lnbmlmaWNhbnQgYnl0ZSBpcyBwcmludGVkIGZpcnN0OyB0aGF0
IGlzLCB0aGUgY2hhcmFjdGVyIGNvZGUgYXMgcHJpbnRlZA0KPj4+ICttYXRjaGVzIHRoZSBieXRl
IG9yZGVyIHN0b3JlZCBpbiBtZW1vcnkgb24gYmlnLWVuZGlhbiBzeXN0ZW1zLCBhbmQgaXMgcmV2
ZXJzZWQNCj4+PiArb24gbGl0dGxlLWVuZGlhbiBzeXN0ZW1zLg0KPj4gDQo+PiBCdHcsIHRoaXMg
c291bmRzIHRvIG1lIHRoYXQgJ2gnIHNob3VsZCBiZSBhY2NvbXBhbmllZCB3aXRoICduJywgb3Ro
ZXJ3aXNlIGl0J3MNCj4+IGNvbmZ1c2luZyB3aHkgQkUgaXMgdGhlIGhvc3Qgb3JkZXIgb3V0IG9m
IHRoZSBibHVlLg0KPj4gc28sIGl0IG5lZWRzIG1vcmUgaW5mb3JtYXRpb24gdGhhdCB0aGlzIG1p
bWljcyBodG9ubCgpIC8gbnRvaGwoKSBmb3IgbmV0d29ya2luZy4NCj4+IA0KPj4gRG9lcyAncicg
YWN0dWFsbHkgc2hvdWxkIGJlICduJz8NCj4gDQo+IEkgYmVsaWV2ZSB5b3UgbWVhbiBuZWdhdGl2
ZSBlbmRpYW4/IENhbiBiZSBkb25lLg0KPj4gDQo+Pj4gK1Bhc3NlZCBieSByZWZlcmVuY2UuDQo+
Pj4gKw0KPj4+ICtFeGFtcGxlcyBmb3IgYSBsaXR0bGUtZW5kaWFuIG1hY2hpbmUsIGdpdmVuICYo
dTMyKTB4Njc1MDMwMzA6Og0KPj4+ICsNCj4+PiArICAgICVwNGNoICAgIGdQMDAgKDB4Njc1MDMw
MzApDQo+Pj4gKyAgICAlcDRjciAgICAwMFBnICgweDMwMzA1MDY3KQ0KPj4+ICsgICAgJXA0Y2Ig
ICAgMDBQZyAoMHgzMDMwNTA2NykNCj4+PiArICAgICVwNGNsICAgIGdQMDAgKDB4Njc1MDMwMzAp
DQo+Pj4gKw0KPj4+ICtFeGFtcGxlcyBmb3IgYSBiaWctZW5kaWFuIG1hY2hpbmUsIGdpdmVuICYo
dTMyKTB4Njc1MDMwMzA6Og0KPj4+ICsNCj4+PiArICAgICVwNGNoICAgIGdQMDAgKDB4Njc1MDMw
MzApDQo+Pj4gKyAgICAlcDRjciAgICAwMFBnICgweDMwMzA1MDY3KQ0KPj4+ICsgICAgJXA0Y2Ig
ICAgZ1AwMCAoMHg2NzUwMzAzMCkNCj4+PiArICAgICVwNGNsICAgIDAwUGcgKDB4MzAzMDUwNjcp
DQo+Pj4gKw0KPj4gDQo+PiAuLi4NCj4+IA0KPj4+ICsgICAgc3dpdGNoIChmbXRbMl0pIHsNCj4+
PiArICAgIGNhc2UgJ2gnOg0KPj4+ICsgICAgICAgIHZhbCA9IG9yaWc7DQo+Pj4gKyAgICAgICAg
YnJlYWs7DQo+Pj4gKyAgICBjYXNlICdyJzoNCj4+PiArICAgICAgICBvcmlnID0gc3dhYjMyKG9y
aWcpOw0KPj4+ICsgICAgICAgIHZhbCA9IG9yaWc7DQo+Pj4gKyAgICAgICAgYnJlYWs7DQo+Pj4g
KyAgICBjYXNlICdsJzoNCj4+PiArICAgICAgICBvcmlnID0gKF9fZm9yY2UgdTMyKWNwdV90b19s
ZTMyKG9yaWcpOw0KPj4+ICsgICAgICAgIHZhbCA9IG9yaWc7DQo+Pj4gKyAgICAgICAgYnJlYWs7
DQo+Pj4gKyAgICBjYXNlICdiJzoNCj4+PiArICAgICAgICBvcmlnID0gKF9fZm9yY2UgdTMyKWNw
dV90b19iZTMyKG9yaWcpOw0KPj4+ICsgICAgICAgIHZhbCA9IG9yaWc7DQo+Pj4gKyAgICAgICAg
YnJlYWs7DQo+Pj4gKyAgICBjYXNlICdjJzoNCj4+PiArICAgICAgICAvKiBQaXhlbCBmb3JtYXRz
IGFyZSBwcmludGVkIExTQi1maXJzdCAqLw0KPj4+ICsgICAgICAgIHZhbCA9IHN3YWIzMihvcmln
ICYgfkJJVCgzMSkpOw0KPj4+ICsgICAgICAgIHBpeGVsX2ZtdCA9IHRydWU7DQo+Pj4gKyAgICAg
ICAgYnJlYWs7DQo+Pj4gKyAgICBkZWZhdWx0Og0KPj4+ICsgICAgICAgIHJldHVybiBlcnJvcl9z
dHJpbmcoYnVmLCBlbmQsICIoJXA0PykiLCBzcGVjKTsNCj4+PiArICAgIH0NCj4+IA0KPj4gQWN0
dWFsbHkgeW91IGNhbiByZXBsYWNlIGFsbCB0aGVzZSBvcmlnIGNvcGllcyBieSBpbnRyb2R1Y2lu
ZyBhIG5ldyBib29sZWFuLCBwaXhlbF9iZS4NCj4+IA0KPj4gV2lsbCBiZWNvbWUNCj4+IA0KPj4g
ICBzd2l0Y2ggKGZtdFsyXSkgew0KPj4gICBjYXNlICdoJzoNCj4+ICAgICAgIHZhbCA9IG9yaWc7
DQo+PiAgICAgICBicmVhazsNCj4+ICAgY2FzZSAncic6IC8vIG9yICduJyA/DQo+PiAgICAgICB2
YWwgPSBzd2FiMzIob3JpZyk7DQo+PiAgICAgICBicmVhazsNCj4+ICAgY2FzZSAnbCc6DQo+PiAg
ICAgICB2YWwgPSAoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIob3JpZyk7DQo+PiAgICAgICBicmVh
azsNCj4+ICAgY2FzZSAnYic6DQo+PiAgICAgICB2YWwgPSAoX19mb3JjZSB1MzIpY3B1X3RvX2Jl
MzIob3JpZyk7DQo+PiAgICAgICBicmVhazsNCj4+ICAgY2FzZSAnYyc6DQo+PiAgICAgICBwaXhl
bF9mbXQgPSB0cnVlOw0KPj4gICAgICAgcGl4ZWxfYmUgPSBvcmlnICYgQklUKDMxKTsNCj4+ICAg
ICAgIC8qIFBpeGVsIGZvcm1hdHMgYXJlIHByaW50ZWQgTFNCLWZpcnN0ICovDQo+PiAgICAgICB2
YWwgPSBzd2FiMzIob3JpZyAmIH5CSVQoMzEpKTsNCj4+ICAgICAgIGJyZWFrOw0KPj4gICBkZWZh
dWx0Og0KPj4gICAgICAgcmV0dXJuIGVycm9yX3N0cmluZyhidWYsIGVuZCwgIiglcDQ/KSIsIHNw
ZWMpOw0KPj4gICB9DQo+PiANCj4+IEFuZCB3aXRoIHRoaXMgdGhlIGV4aXN0ZW5jZSBvZiAndmFs
JyBub3cgYmVjb21lcyBkb3VidGZ1bCwgd2UgbWF5IHJldXNlICdvcmlnJywNCj4+IGp1c3QgbmFt
ZSBpdCAndmFsJyBldmVyeXdoZXJlLCBubz8NCj4gDQo+IEluIGNhc2UgYywgdmFsICE9IG9yaWcs
IGluIHJlc3QgaXQgaXMuIFdlIGNhbiBqdXN0IHVzZSBwaXhlbF9mbXQgdG8gY2hlY2sgdGhpcyBj
b25kaXRpb24sIGJ1dCBwbGFjZXMgd2hlcmUgd2UgdXNlIG9yaWcsIGFuZCBub3QgdmFsIHdpbGwg
bmVlZCBhbiBpZiBzdGF0ZW1lbnQgb3Igc29tZXRoaW5nIHNpbWlsYXIuIFRiaCwgaXQncyBhbiB1
bmVjZXNzYXJ5IGNvbXBsaWNhdGlvbi4gWW91IG1pZ2h0IHdhbnQgdG8gc2VlIHRoaXMgcGFydCBv
ZiB0aGUgY29kZToNCg0KTW9yZSBlYXNpZXIgSU1PIGNhbiBiZToNCg0KdmFsID0gcGl4ZWxfZm10
ID8gc3dhYjMyKG9yaWcgJiB+QklUKDMxKSkgOiBvcmlnOw0KDQpBdCB0aGUgZW5kIG9mIHRoZSB0
YWJsZQ==

