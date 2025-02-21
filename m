Return-Path: <linux-kernel+bounces-525164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66099A3EBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3495E420325
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678F1E98FE;
	Fri, 21 Feb 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FkFoDC5q"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2025.outbound.protection.outlook.com [40.92.23.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E911D7E4C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112605; cv=fail; b=cRuf9UC1pEJ/9Ub+eHZbsd37/owGAp+joj305HS7d+TjlZdV9POK6vvPVezfaztn/NY2ULbofUMHo5bcLM2veQJGID6wTBvsXksRS27Z1CpIaHtvChLfb8MuzzAhddJKZDZNcrE5G4lN9sJWXkRQunc2AjSJacoUStc/vIZsYsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112605; c=relaxed/simple;
	bh=eg0YE1vG/qwkh9p9xTCA8NXhWYdtIocSNA1HjPVieno=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YVDgxSMm9VnS4H9lj6Ifw4ijsHUvoY/VgWhn2/E0IKrc8FF/fnUs+B73V9GP9vV2s9ewq8vuqpfTRxUP9ZWslVfebULvS16jgkkfFRgiPlNZi9qkJZN8+jvYy9g5WoJ80p9ZECUolKZIH3otJWzNL3t/nxGyNZXOwGvKKz/bfbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FkFoDC5q; arc=fail smtp.client-ip=40.92.23.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJAROBAnnUKteuadMQXyj4RNPUF8IGc2+rWpWhC5AsIUgEnMbhHnT2jFPY29LBJvlPIVJXRqd8lv8Vfju/kM9c4pRkSOxATSXn0MhiyH12CB96F3dL+yAS3i8TzBCGXfY7LiehEnk9vthTk1WTzI3/0oYW87iDdphIoMINVC50FCXwEsCrywuuk+WIpwtDCFi5suOdNUp8EDZ9GdI6VPmUf2Gs9fPYn5xBUibWn58NK3/F3F//xVY5092l5ivrTNbJzvPnk4M1nR8eufE2IVN+3MiYNpfcOSS2pQFwWsqMMipVdnFQ0hqQRcL6T+UF4x3pnFVNGuwyLDDLFiB75eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg0YE1vG/qwkh9p9xTCA8NXhWYdtIocSNA1HjPVieno=;
 b=PCDUj9rvmb2NNnQYXeizSD8IJPMPdQ69EqGie2uZAZiissDqUd8aDVMeLvkJYfJDLIzygozSi/cujEU6crO5JcUv99g3JNR7cE4NGj8HN9L2IVULbBbmPj8WyESjSJsfzTcPPxoo36FN/UBJJ73W3wjZxOzIjc40EFj6VZYSfcHoaEI8wGkJElGlwaW/VFKHwa3Wqk2JRBmfMbnks8FGJDyKBh3ilqd0I9IzRwuKAekUHQp3q40SV9mTwEjr7rnQWomxE72+EiO/ytrZDWtVPLJ82rA+galA+22SY8RAnv3ZzijU3EiLhw30l0EWczmkygxZDkGD/LHnXk/eZz9XyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg0YE1vG/qwkh9p9xTCA8NXhWYdtIocSNA1HjPVieno=;
 b=FkFoDC5qw1WwW557BXgiiqegt3EOummaQ8pBQt7x0rLVVX8143sJRazFIxfpnnX/bU59SPzx6NN8piW16Y57NStyQj9Kxe4xePO0LG/r/zNzJ5O1MVgwdw6bFOPtvnH5HSPb57H0Tfs5Mx2tRISlMiwLSASkZ+qBZQmeqkzgMp6TQXra7/WokUAX2oYHua7R+F49HeMtwUuA4f0LbJMub/dZXs0bQ1TQFtiErV38Ix1wUVi7jJMgxN3F+nqm3e+Qaet2GXZG8Ra6h4VVH/N1j86oNFXEZ5pEK+zDWF12PJdnYotqJ7n6+ShxlHkujk9EEmkRhMwkQlXVsvtXuZH6DQ==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 04:36:39 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 04:36:39 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/arm/lib/delay.c: Add warning for unregistered
  delay_timer in read_current_timer()
Thread-Topic: [PATCH] arch/arm/lib/delay.c: Add warning for unregistered
  delay_timer in read_current_timer()
Thread-Index: AQHbg3j3NnWIAArrSEyHNsKAL73Hxw==
Date: Fri, 21 Feb 2025 04:36:39 +0000
Message-ID:
 <BYAPR12MB3205BCE06EA38DC33B84F402D5C42@BYAPR12MB3205.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|PH0PR12MB8773:EE_
x-ms-office365-filtering-correlation-id: 7e5a83a2-8067-4354-3833-08dd52315585
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|8060799006|19110799003|8062599003|7042599007|461199028|15080799006|3412199025|440099028|41001999003|56899033|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejB3WTZLRTlITXBCNjlOZ1dKcmdpWkRaYWNMMS85VDA1MlhvNXVwOTlhRFlV?=
 =?utf-8?B?L3dhdXN4MDVua29rNzVHb2xNTmdndkh5ZFIxenlZZkxYTVlyYXQvN1p1QzEw?=
 =?utf-8?B?TktiamQ0dG1ObjVGalBkd2N0VGZIVmhkdEJkbkZCeWQ2SzhJTWtnb1JtY2do?=
 =?utf-8?B?Z3BxbFZ5TGwrQ2IvcjFnOGNBUDRrWjJwb1BsYkRQT0JBZ0RCWGlXSnQ2dGFH?=
 =?utf-8?B?TU1EOXA5bWMrbituWkFKa2JrMDRCclFQNm4ySnU0YTVQMkEwY09JMzU4NnJQ?=
 =?utf-8?B?K1ZHb1dYWG05cjFjZW5uY1c1UFplS25uTHlSZmVUN0t5aEFVYVQ1Z01VTjhD?=
 =?utf-8?B?VlNDVUZMbm9nL1AvMGQvZmZ4eDBzT3hvREpNOHNpSWtET1hyakNKT1NMeFV3?=
 =?utf-8?B?N2MxMzRZeURwemtMRW04U3crWSs1ckVaUEVPY0VJV3ZaUHErOGdKeURYL3dB?=
 =?utf-8?B?bHlUWEUyTVEvRHFjSGRLcG8wL2owK3BsenhFY2l3Q1hhYmcwNUlLNHB5NU83?=
 =?utf-8?B?eDcwTitUVHozVFp5UkpFY2hHZkpzVDg1Q0oyMkpCMk9XRk9QUHd1RWNOVjA4?=
 =?utf-8?B?My9Ubm9Eb09NMnpOV1BYWm5TODE1RXROSnNoZXZjN29GY1lpUzVEd0JTNC83?=
 =?utf-8?B?V1JCZkpxbGx2OUlDeHY0THNEaUZOUFhUWXFNM0l3L1VkdXJMNGwzSHpaQzRZ?=
 =?utf-8?B?OVRtOGRsRW00dDFHVmRiS1QwZ21KRldBYnRuR2p4MmR5eXhnM285am5DVjJt?=
 =?utf-8?B?QWdTWkYyK3pNbVNNQThPQnE3aGJZY0lYS3FuSThQaDNNU010TEtNS3NuaXdS?=
 =?utf-8?B?WlB5UlM2dnJrdE9xYXZRcFE4UVRBbDhVV3dQZ0dRQ0Fsc1Z5d0podmVmcEN2?=
 =?utf-8?B?NVdiVHBtNnd3R3JUcFo5Qkk3M1lyQ1RwVzJRYUZZNmpyTzRMVGswME1maDhm?=
 =?utf-8?B?am1lajdROTNpcXFPZk5Gcy9PUktiWGo5RU44aWJWRmc0bTU3c3JBc0lvOTd5?=
 =?utf-8?B?ckJNRmhjZTM0a0ZQajRZWmc4YVphSzRWVHc1VnF0N0JhU2JTTmpnS2MzZjhz?=
 =?utf-8?B?bkVIek5FTVBUWjQxR0ozL0NTNlBFUnQ5cXFqU1lNS0pKNnluK1FHOTV2T2xN?=
 =?utf-8?B?d3VPdy9LYUQ1SXltdEczVzhGV1lNUVQ4TTRjenZPZCtqd1NvQk9HNHl6UTJ3?=
 =?utf-8?B?ZmZFU1VQZEhadmlnRGpKWWcvZzlBak16eUd1Wm93bmx5MXBWaTRXNVRsNEhv?=
 =?utf-8?B?Sjk1MGw0MWpVQW8rVzhxSTVaajdxclZOaWVwNWFsOU9HSUxac29EeDI0RW9v?=
 =?utf-8?B?aE53U09FdmpGdTR0UWQvbzZpeHNlQmpLK0hhRElCOTRVTUJjcStPTElSK1Vu?=
 =?utf-8?B?SWsveERpVnpUcEdBeXV6b2M5a3prN05JWm01cUd6OEJ5R3RlK3FveDBYMTVz?=
 =?utf-8?B?M1k0c1RJbVNVbENHUTlKaWgwKzJEcjZMMGVHQllORDhxTG1ETUhqc0JDelpr?=
 =?utf-8?B?Nk9yUEJJT3dLRk00OTBRYWZlOGlUUCtta0F1b2tYeWx6eDBTaU9DN0lIcyt4?=
 =?utf-8?B?c2wwUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHN4bVlCMSs2Z3krRk1ycmRZcXNQOWtaMXA5RkY1RkpsSGpnZ3lUb0h0UkZJ?=
 =?utf-8?B?RDhkcUxtaktDODdQMzh6bEZIZnhEY2FDVjM4V3B0eUYvb3U1OUxZeFVLOEdE?=
 =?utf-8?B?cUV1U0I2TVgxVFNIYXdYUjQ0YS9jMlRwSU43RHVuZHAwNDRpbHluV2pEQVJi?=
 =?utf-8?B?ZHl0d3FhcnZPUHZ1ZmZ3OUMxMzN5U2ExOFJWZFN6Q1MvVHpLTXJET05nNHVo?=
 =?utf-8?B?S0hicjJNTVVMQytibDJQL29yUjZ2OWt4Z3hBTUJYRGgzeHRBeXVMNUxtRDZC?=
 =?utf-8?B?V2psM3VzMUZxNm1YZXZSd1pXV1JKaEhwdDEwQ1pZYVJZZ0UxR282djJUZzk1?=
 =?utf-8?B?V0lzaGpaaGhTSS93em5HZGdGM2VmRjl5N3lSS3R4amZTVVNOUmdqM05nd1Uv?=
 =?utf-8?B?dlpndWxrOEtOV1JTdko0RWZLNHZUaHZFQXdvOCttZzlqOExpdjQzNTlyVmNp?=
 =?utf-8?B?YkhacVZQWnlaR0FvQlFHTm5hY2ZLT3g4REhHQjhuWnIyZWczRW5BaFhuazR0?=
 =?utf-8?B?Ry9LdlVhWG5hdHZvbUJvbFVoWUkweGkvMFBkQnZPaEpteEdOUm5OdVpvS20r?=
 =?utf-8?B?RDhjdEtyUnU4MXVQTnVRb0I3YXoyTjYrR2ovYXR5WjVmNDRRM1k2c0RRVmFs?=
 =?utf-8?B?c1lVTG5veFN1U2tCcFhiSUdQYTAvOW95amROV20ySnRvWkEyeGRhQXJNbWk4?=
 =?utf-8?B?TVc1UCtjMmtuQ2VUY3Z5VVdUWW9VajM4UFprN1R2K0t4SVQ4Nlg2WENiVmZC?=
 =?utf-8?B?UDYvMlhPSGttTndpbEFBSE4wWEJtMW5wSWtsYm5SZ21QSU9XbWY2WDdEdXFt?=
 =?utf-8?B?eTlTenhjeklGY2hMRC8wMVUybUxpeW5QeERTWWJKOERhK20ydEd0ZGpadnpP?=
 =?utf-8?B?QVl5b3NJbHQyZWNpR082WFY1amd6cmJ4WE1wbWVxZmdMcmxHZ0NRcVhmUnc2?=
 =?utf-8?B?TDJaSjJXWG1hKytMa2ppS1hzbEgxUlFFN1RreXR4VTRyTk0zYXBtb0poUVZZ?=
 =?utf-8?B?RE1tVld1NHpxQXhqZ0pWTDdFR1dDQ0NPbHNTeHliQzhDOW1PV1VURmM3Y0hB?=
 =?utf-8?B?aVRMQWNsYkw3ZDhmNmdiVDRxRGR3OUJRVnRacUt2N0MxN1hlUitZMlhzbDlS?=
 =?utf-8?B?YW5jdUpzY0tNWjN2cTNqY2xhbUJRQ0JNM0dNTk0rNmdJWnMycHF6b2ZxMXV6?=
 =?utf-8?B?YTF5SXp6NVZBY2JrQnFocm1zc1ozVWNMYVFoRkNkZVQ3SHlGVS9TNEFxK3dS?=
 =?utf-8?B?cFBPL3RXZWtmOGZsS0lmSnJnVCtxZUJsTFh1MUFqMDlQeXNpNDUzKzlQV2U0?=
 =?utf-8?B?UDRUOHp2bXRJQ3kyZVowTDdUOE5YWHExM2RuK21QZHZSaWFkQjY3TXF1Y3Nv?=
 =?utf-8?B?SUlRVzcxSnRmaVhvRUZmWWRGZ3lYZnlCeUVKRWdHeUw0cG9iSU9jUHorc1NL?=
 =?utf-8?B?cnNhWjNzbXhaWDZxNHZRZ0hpeHJubm1lQldkbmVtbGFiQ2drYkNnNWFnOEVH?=
 =?utf-8?B?ZkFQZGFtR2NlRXJjQTNwcjVFNzJNc0ZPNzRFRjFMZUNxRXlpdktOc1VTVGNm?=
 =?utf-8?B?czBOVnpOdWtZbnhXSy9LTjVhOTN1bnBmb05SdHJlQ3BYMmswVFlHVXFTU2Vj?=
 =?utf-8?B?Z1lCM1VDNS85Z1Y4a1c1bUNHR053QitHQ0NkLzlFKzFsWlB3VVpES0hIUWJl?=
 =?utf-8?Q?+e42V8Mg3dlGxjFWMgg7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5a83a2-8067-4354-3833-08dd52315585
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 04:36:39.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773

SGkgUnVzc2VsbAoKV2hpbGUgZGVidWdnaW5nIExpbnV4LCBJIGZvdW5kIHRoYXQgdGhlIGtlcm5l
bCByZWxpZXMgb24gdGhlIHJlYWRfY3VycmVudF90aW1lciBmdW5jdGlvbiB3aGVuIGluc2VydGlu
ZyBjYW5hcnkgdmFsdWVzIGludG8gdGhlIGludGVycnVwdCBzdGFjayBvciBnZW5lcmF0aW5nIGVu
dHJvcHkuIEhvd2V2ZXIsIGlmIHRoZSBjdXJyZW50IGNsb2NrIHNvdXJjZSBoYXMgbm90IGNhbGxl
ZCByZWdpc3Rlcl9jdXJyZW50X3RpbWVyX2RlbGF5IGZvciBwcm9wZXIgcmVnaXN0cmF0aW9uLCBy
ZWFkX2N1cnJlbnRfdGltZXIgd2lsbCByZXR1cm4gYW4gaW5jb3JyZWN0IHRpbWVyIHZhbHVlLiBU
aGlzIGlzc3VlIGlzIHNvbWV3aGF0IHN1YnRsZSwgYXMgZXZlbiBpZiByZWFkX2N1cnJlbnRfdGlt
ZXIgZG9lc24ndCB3b3JrIHByb3Blcmx5LCB0aGUgZnVuY3Rpb24gdGhhdCB3cmFwcyBpdCBtYXkg
c3RpbGwgcmV0dXJuIDAgd2l0aG91dCB0cmlnZ2VyaW5nIGFueSB3YXJuaW5nIG9yIGVycm9yLgpG
b3IgZXhhbXBsZSwgd2hlbiBnZW5lcmF0aW5nIGVudHJvcHksIHJkc2VlZCBtaWdodCBpbmNvcnJl
Y3RseSBiZSBzZXQgdG8gMC4gU2luY2Ugbm8gb2J2aW91cyB3YXJuaW5nIG9yIGVycm9yIG9jY3Vy
cywgdGhpcyBwcm9ibGVtIG1heSBnbyB1bm5vdGljZWQsIGxlYWRpbmcgdG8gY2FsY3VsYXRlZCB2
YWx1ZXMgdGhhdCBkbyBub3QgbWVldCB0aGUgaWRlYWwgcHNldWRvcmFuZG9tIG51bWJlciByZXF1
aXJlbWVudHMuClRvIG1ha2UgaXQgZWFzaWVyIHRvIGRlYnVnIGFuZCB0cmFjZSB0aGlzIGlzc3Vl
LCBJIGFkZGVkIGEgV0FSTiB3YXJuaW5nIGluIHRoZSByZWxldmFudCBjb25kaXRpb25hbCBjaGVj
a3MuIFRoaXMgaGVscHMgZGV2ZWxvcGVycyBtb3JlIGVhc2lseSB0cmFjZSB0aGUgc3RhY2ssIHF1
aWNrbHkgbG9jYXRlIHRoZSBpc3N1ZSwgYW5kIHNpZ25pZmljYW50bHkgcmVkdWNlIGRlYnVnZ2lu
ZyB0aW1lLgoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpGcm9tIDNi
M2IyY2MyMmFkOWUxYWYwZDMzMjFhYWMyN2UwOWIyNjM3OTdjNTIgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCkZyb206IFN0ZXBoZW4gRXRhIFpob3UgPHN0ZXBoZW4uZXRhLnpob3VAb3V0bG9vay5j
b20+CkRhdGU6IEZyaSwgMjEgRmViIDIwMjUgMTE6NTU6MTggKzA4MDAKU3ViamVjdDogW1BBVENI
XSBhcmNoL2FybS9saWIvZGVsYXkuYzogQWRkIHdhcm5pbmcgZm9yIHVucmVnaXN0ZXJlZArCoGRl
bGF5X3RpbWVyIGluIHJlYWRfY3VycmVudF90aW1lcigpCgpBZGRlZCBhIFdBUk4gdG8gdHJhY2sg
d2hlbiBkZWxheV90aW1lciBpcyBOVUxMIGluIHJlYWRfY3VycmVudF90aW1lci4KClNpZ25lZC1v
ZmYtYnk6IFN0ZXBoZW4gRXRhIFpob3UgPHN0ZXBoZW4uZXRhLnpob3VAb3V0bG9vay5jb20+Ci0t
LQrCoGFyY2gvYXJtL2xpYi9kZWxheS5jIHwgNCArKystCsKgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2xpYi9kZWxh
eS5jIGIvYXJjaC9hcm0vbGliL2RlbGF5LmMKaW5kZXggYjdmZTg0ZjY4YmYxLi5hMTUwMTU4NjFk
MjUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2xpYi9kZWxheS5jCisrKyBiL2FyY2gvYXJtL2xpYi9k
ZWxheS5jCkBAIC0yOSw4ICsyOSwxMCBAQCBzdGF0aWMgdTY0IGRlbGF5X3JlczsKwqAKwqBpbnQg
cmVhZF9jdXJyZW50X3RpbWVyKHVuc2lnbmVkIGxvbmcgKnRpbWVyX3ZhbCkKwqB7Ci3igILigILi
gILigILigIJpZiAoIWRlbGF5X3RpbWVyKQor4oCC4oCC4oCC4oCC4oCCaWYgKCFkZWxheV90aW1l
cikgewor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCV0FSTigxLCAiRGVsYXkgdGlt
ZXIgaXMgTlVMTFxuIik7CsKg4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJu
IC1FTlhJTzsKK+KAguKAguKAguKAguKAgn0KwqAKwqDigILigILigILigILigIIqdGltZXJfdmFs
ID0gZGVsYXlfdGltZXItPnJlYWRfY3VycmVudF90aW1lcigpOwrCoOKAguKAguKAguKAguKAgnJl
dHVybiAwOwotLcKgCjIuMjUuMQoK

