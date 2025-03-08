Return-Path: <linux-kernel+bounces-552273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB4A577D3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9067E189887A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C133987;
	Sat,  8 Mar 2025 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ckRa5oRj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2078.outbound.protection.outlook.com [40.92.42.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6EF1392
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741403737; cv=fail; b=S0xuwXWa1U4HXTxTyzF7cjnbUYunieEq8K39lbQh93vdk9ogsUZGhKeYgJd2QtSVCNhCvhsD3o8iCOlzGL28LiOEyRTgP3DbAe6wknOd1TYTi3Iv5XEs3OBuplAx68Jw+L8dsPmPEcucOp7z8Cq+5Uy7kJnX/m42sPyonvcdXQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741403737; c=relaxed/simple;
	bh=ZPGGvxf60b9qGk1nDrbYcWITWtQdi+XuKV4xdUwSagY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7x+UX6sI++SYVYLZOgqYzxkbhn8nzG2ImM+/hG31wnAVqk+FY9GUxELUl20r+qBoamPXVMD3xGRVjhkABtJtoa4va0wiYfrFnbuuGU9bFOG1uWn6ljx1dxkMK9tADqtkM1vEx2noN75SXx7wJ3eK3l5zQ3n0xcCz3ohtMBr4FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ckRa5oRj; arc=fail smtp.client-ip=40.92.42.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghSGicKLKkk4fv16CcDO5/8HQJvtPouehicSEZBpMR+72LRA5XLKchf76tKY3c1k9/e4MJVyJ6w/6ho2X0D5VEYTxf8oxcUiA8QtuuEqGL20vW4kPcw4TUj2LjcjFmZMB+EN8Lzsh8D3lNaAsOPsNTxFbQ4jEeC4PxpfUWCgBYXW5gyZS+ohTZaSfcWW1hB7Dd5oaUcwemV8NWuKR74gYTbSsL4Hv+BxJi6V3CIq9X/UbN1go31Gb8uA5a391DPACL2d1EW0HGx0UDkEa0+Zl2h+Fo3BvdSm6v+fSVLtkc+/AJEL6JQL8/aWLlWeZLlGx8BMxOO2GL02tnFP9GoXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPGGvxf60b9qGk1nDrbYcWITWtQdi+XuKV4xdUwSagY=;
 b=X1G1YjNZOLxuRTnoZh/MfGwYhv2qR5ukC1arCHPvHwAlVTFDV6Stj6hf5lvM/LEbsysFISUZlJEBFoXeEFM9PcjGrN3LXmK5jxPQDLVrPLnFhcdPP0mO2Iepsmd7t7JDmUTMzWFpVh9uQuV8OM/VBDZQo9x2/7t3h9Nm2qbULAnWifVvDEx3FO+esggggNp5BIbIyNM/shkoD5B1D21zBKK+Idnh8f6J80pgrJiSCPC62eceDoaxfN4QFJkWfFzow9L3oHDOJYGNHG/jiO+zmBtpuH6BQVuURPclaWGODVfu3aPcVrcKKSN1K1NzQ0qMxIX5A+bb2F8aolhYo1QA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPGGvxf60b9qGk1nDrbYcWITWtQdi+XuKV4xdUwSagY=;
 b=ckRa5oRjkqCgd2xVHjxJrxaxXbJFrGtYmGjYc/oJlWLqLMwkoxeS49yTLS3w/8steqC9f5pZk0+qv1nZMHvLgb43v6NU/V05xQ2hd1UlfpO3FGY5XFyPFzUlIGQZHFttz6hIPtDpzXs6esw0Dlwh9CmHlS4+hjMKPSzL9vnr+RSw+BqlWMdqtB4XdJdDRUwkrOMn0hNM+1e/x5Zo23vO3zRyt74kbavDR52GkytTjjn3nkgLENx8V/+XaxXoQSXq6TGdYIVyL2N+GaSqDY+o/VrecHOc/I7WtWBG0mG3LIKm+EzFqeQ+z1uU2qgiPawPliZ1wR7OWEv8HFDMZDMQxQ==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 03:15:34 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%6]) with mapi id 15.20.8511.019; Sat, 8 Mar 2025
 03:15:33 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
Thread-Topic: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
Thread-Index: AQHbjzhdEoIDDREG80im9Sg8sdgpJbNnhnaAgAAoW4CAANyvag==
Date: Sat, 8 Mar 2025 03:15:31 +0000
Message-ID:
 <BYAPR12MB32050A4AE88CB1F589E91505D5D42@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <198fe423-e797-4a82-a509-ee06ca05466e@linaro.org>
 <e6cda34e-f363-4fae-897f-f4deb7c6bddc@kernel.org>
 <21ea3de4-ca42-4576-a4ec-b89b3e2a2ac9@linaro.org>
In-Reply-To: <21ea3de4-ca42-4576-a4ec-b89b3e2a2ac9@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|SA1PR12MB8888:EE_
x-ms-office365-filtering-correlation-id: bee2bc0d-d30d-4808-7ae8-08dd5def7c20
x-ms-exchange-slblob-mailprops:
 8U9+OAG/EBLIDl5gZGLk6rO6SW9xG0McyNDeUrqiHhgphYWrQ8v8LI1l5dLNuNNYaN1J2bIuSKSHHxJT8jJxYUwvwvu9CpYTd6ZC7pbNCGzrX460Hj7tB26BMvEGma34579oi5RoTvrsuTHQIYUJRnP8VaU/jOMih9LwFb8wJA+yUW8Dzdimv6ZhNvSMfmGPNU4jpr9CVaHOGw8s50OR5SnhHgRH+O11cZitsVR3FMz80Qy0xIO5XqR+6WCx8nezrc7RLRR4yi6Y22151QMNm1UEqt+rreD5NJ7qv+WVLy0QW2GsMAvalO+h8VE+T4sRqnpGq5JbMNt1sFLfV4t2pMHCUP34SBL8kKHEI2+jszJa+n2FIJKAJsPiyRXEU+6MFiZ0bbW7rzGbVBpPgiMNqTmlcS1MbphlmpbcIJE5kpSJQslbINzXsLvj+OH3IMwOBxZp6OZvGUHlKR+uHd6/WHT/2n2dJSGI6bJ6Yts0WZRzW/yv3vMTvzJq7NS7W7VXFaj2D9FFL5TA7ickbJfj+5kD7RaFPQjIBOxQKVxxu7Rxvq5DTeagn1kFJxwle1WWnYcJXd41RkyARA8BLu3RKWkRjmqnQtfPNT43nObY0TO1Cs2B3V5HzT4x+aFPHOC4+01wvWU7rJJgRkmD+9A+4Ks2qL1hCg5yKkxE/PcefVCTCnr+8UbOsbeBrKemPj30Y1STu6no6cHRrDW8edIdzjH/DyPX3o/PaqrT3C3u511KYPa5Hv0U4TQPvuUukprB+/wV3ybMv+Q8faZ73E/UbOtMVXq32Tko4OwTyE3YSf0eaeJ8W0hcv98YruqcET241b4e2ywcEbiEhOKVZcFlsw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|15030799003|461199028|8062599003|1602099012|3412199025|4302099013|440099028|10035399004|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTNRN0Z4Z05LT3BRVlJ0UElBcFNaL3ZLd3RvSW80VGVpdXZZMW9SSXpPeHZ0?=
 =?utf-8?B?NXZYanVmczl5RUlPT3ByanJVYmYvZHcwU3FQbkZ3RHJwRzd1VjdMZ05hbm1T?=
 =?utf-8?B?aStEOFE0QXVkaVZoWWI0blMrNW43V3lBRytlYzg3SkxBQlVYWXFOdCtjM2t4?=
 =?utf-8?B?eWc5SVRaVjBHZVFxVFZMSlNXbVc2T0Nac1NsMFhQVnQxVkx0SFZVOXE4enRN?=
 =?utf-8?B?L1BFRnk5VzRRZ0d0TVRIWWR5ZlFjK1JCODFCOU9rU1ZWUW0vdVM2ZDlTL0kr?=
 =?utf-8?B?RlRIckl6dHQ0RHRNUlRpOUVLZG9OcG9qOFZHUTVWMHZCT1pDeVB6OERSaGt0?=
 =?utf-8?B?dmV3bDFyTkpWNVU1N0dsQ3lPUFFZMVRmS1Q3aVVJWEFNZEVhTU9wSWxVU3NB?=
 =?utf-8?B?ZXRRVXB2NmZIT0FtZTc3OEdpT1Q0QVAzcTJ3RXZiblJFdGFlMTNBbzMwNkdu?=
 =?utf-8?B?amE4M3k0QkVlZzExRWtxMlFJTzZlcHltb0dpZWNKY2RNMzV3T2J3UGJvZzBU?=
 =?utf-8?B?WFg2TW9JRklLcmlHRWJEdi8zdnl3R282amFrNjUyc0crQW1XZUdRZVZDQTJj?=
 =?utf-8?B?RU4wclN0Q1RaZFVaZjhZM2RqTVlBQmk1WUExdHRYdytvSzBYd1B0djFpMkdy?=
 =?utf-8?B?M2FxVjBvY1B2RkV3QXY0WGZYbVpKNEUrT0h4ZHVOaDBxZ2RaY1k5UFVkdDVC?=
 =?utf-8?B?SWFjNFRSWDViZnhoS29pR0xBTnlwSmdFY0thNDUydFNKQ0lQbzZ2OVUwd3dP?=
 =?utf-8?B?N2tpa1lxdDZycTl1TUg0RnlzaDZvZ1E0ZHZOSFRiUGp4NHFXa2Z1MnErV25F?=
 =?utf-8?B?aC9TdG9YVDJQNGpHRzJ3RHVBaVJwd0JOaTllTTY1N0pSbGV5NTBlZTROQWpz?=
 =?utf-8?B?bHp6d1NydVkrdkE4ak5kS0R4Q0xiWE5XNlNxY2RaTlpGeEREL3dwWkZnR3J3?=
 =?utf-8?B?bU5kRG1DQW9jazltTWwxaWNwbm8wSkZ4eVNyTzlkRVFZL0o3VmtpL0hCS0E2?=
 =?utf-8?B?b2JXUXQyZ3Q4VXRsZWhZZURFNi9RektxUk9RdlNQMEZzUWJpMHVlQmtNa2wx?=
 =?utf-8?B?UERDVzk3V1d2bGlKRUhlNG9sZFFPUUo3NWFEcW50QjJDZTdoVW1pMk00Ui9q?=
 =?utf-8?B?M09rOXQrS3RwV3BhS05id05yY1dpZHR1YkFrRUNzZWVTazBaSDE3VUtuUUZz?=
 =?utf-8?B?YjlzYS9BQ1d0MWlVSndLZTdmVnA1bFBIb3pDYXA0T3oyQWUzallBdGI1bllz?=
 =?utf-8?B?M0NoZjJQditScUd1N1Z2L2drc0tLSUovV04zanJ6R2Q5dHFkT01HeU5TYlpo?=
 =?utf-8?B?a21NY1ZaRXN3dFc0OTZ3OER2NUZDYXJ1WGlZWWx2bmFTdUZVOGd2VTdNTHBL?=
 =?utf-8?B?ZTkwamp0T0xxenNzVkE4UllxUit5amVHTEZjMjRYcVZZbVFJQ015dDhRekM1?=
 =?utf-8?B?K0pxYTcxaFVWQ3BCM2VHeC8zcmpIakdZNkNJZkVtMVk4WWRzelAydVRUZVps?=
 =?utf-8?B?dFhZZTgzcThPQmtDSXRyam90MzRyK2tFa2lJakFUdUFRSmJ0MzlLUjZtNzds?=
 =?utf-8?B?NzZqZncxdlV0cno2L2NDL2UwNisxZnc4YllBTml5MkxpcmxMV0psT1UxT1lM?=
 =?utf-8?Q?NQnOFv0J40tfcHr8zchQPfgH/LsgoSutqoiBOkvSdGj8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGtWKzNoUVFGRzZmQUcvMExLbWs0THZOWkVyaDlTTnhXT1Y1UFUyQzFZVU5u?=
 =?utf-8?B?ajk3MW83eGNOOW9oVjEvYUIvZDZobko3SitRdmQ0cmxBR2h4VFlHa24xYjkz?=
 =?utf-8?B?NmNZdHBtSFVTQmVVUFovcDR0dGZQaTQrUmE2R0lDT281eEhpdUx0dktCdFF4?=
 =?utf-8?B?TjNHZHZjdGZoMHozT3dxQVFvQTdpNjE1b1BQWEVkamlrdG90QXlkK2JocTJF?=
 =?utf-8?B?cTlSS0VMa041K3JBTE9TSGRvemFJU3NqOW1EY1EyejdxbzJKMW1ha3VtUnp4?=
 =?utf-8?B?L2xpclNpN2xocHZ6YkExSTdaRFphOXFaTGJmOVBaYm9iV3NSWFdUcTEzRG02?=
 =?utf-8?B?NzNDdGMyVTZQR1VjRFFaUGJQd2ExS3lZM3lXQjB1c2JUR1BIbGsxZDBlMmpr?=
 =?utf-8?B?V2syRDdWRFo4M0pVY1RzaU1VSW4vVUZZUHY4SktBMFZyK1FLYW9iMlc4TVN3?=
 =?utf-8?B?NTVTT0FCaS9JaGRjUGxaQUM4amNDMUlCVlgwdmhIMUpIeDVNYjJDVStwZldy?=
 =?utf-8?B?MkxkbXpobk8wZzEveUQzVEVFZGorRGNRcTRrNGhWaDRCcXNEZUpRanRDcUJz?=
 =?utf-8?B?U3VRM3RjYXZnaXNJMy9jbGlLcWlQNlcvOHptakJucE1oNWR1UFFxWHR1dGU2?=
 =?utf-8?B?dGhxdzlCNGJHa1VDWVIydFFhMHBmcWpkWjhzRkJXZ1RuSkZxcmYrcWR3YmJy?=
 =?utf-8?B?ZGJvbllPUlBwdDlXZU1ZQ0E3MjFWRVJMcy8xL1RYUUxwZStBakVpQmoxcVlJ?=
 =?utf-8?B?aGhnVE1FZWpjeVZ3V2N6MjVWQkJ1YmIyQnV4Q3RBbm0wRkF4QzdOL3N0YXNN?=
 =?utf-8?B?eGZwdnNpRXFNRHRSL3ZwTlJ3UnlnZnkxMnFDaEhuaW1pZ0Q4Ui95ZDVEa1gw?=
 =?utf-8?B?UnRuanpHaEtQWVBSdEJ5ZTNVZ1RBY05WQWhET0gwVzVlRkE1WHJ6c1pKbCto?=
 =?utf-8?B?aWdEcXoyc1MycWcyRXlFTHJJRG1YNnpGK0h5Q0IvQjhqQjRTaytPNVNMSjRU?=
 =?utf-8?B?T1dkbWNkOWRGVCtLRTJXaXcwbVNaN1d6allIWTZSZmJQYXFRQkY3cWQwNlY2?=
 =?utf-8?B?Sm9LcWZqcnBpdXRhOEZnVW1sS1FkSjZ5anBuM09EdFZsQjUxQ3hCRG41SFl4?=
 =?utf-8?B?OG1LLzJSbkxCK1lIMDlkeXhZYWtaQ1QxeGEvVTkwMmJyTVloNDNLaThsR2VU?=
 =?utf-8?B?bVFMelprbTl3Z3pkdFFraDR4Yk5mZFlQckNlOEhubm1kNitUbTg3V2dLR2hs?=
 =?utf-8?B?RWVMMUJwVFU1N2N5MmFOSnYvc1dHTHV2T3RDbW45Zkl0dTJpTFdPUmUxUERh?=
 =?utf-8?B?QUdtb1RQTDAvdFp6YnpIN3g0d3ZBQk9tTFVqdXQrNzVEZWl3UE1iQWtiQUsv?=
 =?utf-8?B?RmtqSS9DZlhiNzA2eCtQZTU0dlltTHp0VGJqaFJHL09naEU3SWE3Q0p6VnZp?=
 =?utf-8?B?TzQ4OVkrdTAxYk1mZlNGY0d1QVBPUEVYa0c4MElhRVFOU1dNQVlybHFpV1N3?=
 =?utf-8?B?azRNckdIOG95Z2U4TWp3TmhVSldxSzlJZWRKTjN6b2tMVUg1WllMdkt0QXdR?=
 =?utf-8?B?VHo5eWNNT2tMeDFBSkZyK0YyZUJ6QTQ0MFV6d0Y4N2xya1AxeW1rQzY3NFI2?=
 =?utf-8?B?L2R3MU5LekRLWVgyL0JrRTJXM1ZkdGFvZG9tRXZKaFBHcEdSR1NrMTVHd29Z?=
 =?utf-8?Q?M97ZP2w92MCcpECzzdKz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bee2bc0d-d30d-4808-7ae8-08dd5def7c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 03:15:31.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

SGkgRGFuaWVsCgo+IE9oISBUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdyB0aGF0LCBJIGFwcHJl
Y2lhdGUKCj4gSSdsbCBwYXkgZG91YmxlIGF0dGVudGlvbiB0byB0aGUgcGF0Y2hlcy4KCkkgd2Fu
dCB0byBleHBsYWluIHRvIHlvdSB3aGF0IEtyenlzenRvZiBzYWlkIGFib3V0IG15IHBhdGNoIGJl
aW5nIGdlbmVyYXRlZCBieSBBSS4KCkkgaGF2ZSBhbHdheXMgaGFkIGEgd29yc2hpcCBzcGlyaXQg
Zm9yIExpbnV4LiBJIGFkbWl0IHRoYXQgSSB3YXMgYSBsaXR0bGUgYmlhc2VkIHRvd2FyZHMgQUkg
aW4gbXkgcHJldmlvdXMgZW1haWwgcmVwbHksIGJlY2F1c2UgSSB3YXMgd29ycmllZCB0aGF0IHNv
bWUgb2YgbXkgd29yZHMgd291bGQgbWFrZSBrZXJuZWwgY29udHJpYnV0b3JzIGZlZWwgdW5mcmll
bmRseSwgc28gSSBhc2tlZCBBSSB0byBoZWxwIG1lIHBvbGlzaCBteSBhbnN3ZXIsIGJ1dCBJIHdh
cyBpbmRlZWQgbWlzbGVkIGJ5IEFJIGR1cmluZyB0aGUgcG9saXNoaW5nIHByb2Nlc3MuIEkgYWRt
aXQgdGhhdCB0aGlzIHdhcyBteSBwcmV2aW91cyBmYXVsdC4KCkJ1dCB3aGF0IEkgd2FudCB0byBl
eHBsYWluIGFib3V0IHRoaXMgcGF0Y2ggaXMgdGhhdCBJIHJlYWxseSBkZWJ1Z2dlZCBpdCBzdGVw
IGJ5IHN0ZXAgdXNpbmcgcWVtdS4gSWYgbmVjZXNzYXJ5LCBJIGNhbiBwcm92aWRlIGNvbXBsZXRl
IGFuZCBkZXRhaWxlZCBkZWJ1Z2dpbmcgcmVjb3Jkcy4KCkkgY2FuIGZpcnN0IGJyaWVmbHkgZXhw
bGFpbiBob3cgSSBmb3VuZCB0aGlzIHByb2JsZW0uIEkgd2FzIHRyeWluZyB0byBvcHRpbWl6ZSB0
aGUgbWVtYmxvY2tfYWRkIGZ1bmN0aW9uLCBhbmQgSSB3YW50ZWQgdG8ga25vdyBob3cgbG9uZyBp
dCB0b29rIHRvIHJ1bi4gSW4gdGhlIGVhcmx5IGtlcm5lbCwgSSB0cmllZCB0byBnZXQgdGhlIHRz
YyB0aW1lc3RhbXAsIGJ1dCBJIGZvdW5kIHRoYXQgYWxsIEkgZ290IHdlcmUgMCwgc28gSSBzdGFy
dGVkIHRvIGludmVzdGlnYXRlIHN0ZXAgYnkgc3RlcCwgYW5kIGZpbmFsbHkgbG9jYXRlZCB0aGF0
IHZleHByZXNzLXYycC1jYTkgdXNlZCB0aGUgc3A4MDQgZHJpdmVyIGFuZCBkaWQgbm90IHJlZ2lz
dGVyIHRoZSBjdXJyZW50X3RpbWVyLiBJIGFsc28gc3VibWl0dGVkIGFub3RoZXIgcGF0Y2ggZm9y
IHRoaXMgcHJvYmxlbSwgYnV0IHRoZXJlIGlzIG5vIHJlcGx5IHlldC4gSW4gYW5vdGhlciBwYXRj
aCwgSSBhZGRlZCBXQVJOIHRvIHJlYWRfY3VycmVudF90aW1lciB0byBxdWlja2x5IGxvY2F0ZSB0
aGUgcHJvYmxlbSwgYmVjYXVzZSBJIGRpZCBkZWJ1ZyBmb3IgYSB3aGlsZSBhdCB0aGF0IHRpbWUu
IEkgYW0gbm90IHN1cmUgaWYgdGhlIHBhdGNoIEkgc3VibWl0dGVkIGlzIHRoZSBiZXN0LCBidXQg
SSB3YW50IHRvIGV4cGxhaW4gdGhhdCB0aGlzIGlzIGluZGVlZCB0aGUgcGF0Y2ggSSBkZWJ1Z2dl
ZCBhbmQgc3VibWl0dGVkIG15c2VsZi4KCklmIHlvdSB3YW50IHRvIHZlcmlmeSB0aGlzIHByb2Js
ZW0sIGl0IGlzIGFsc28gdmVyeSBzaW1wbGUuIEp1c3QgdXNlIHFlbXUgdG8gcnVuIHZleHByZXNz
X2RlZmNvbmZpZywgdGhpcyBjb25mLCBhbmQgdGhlbiB1c2UgdmV4cHJlc3MtdjJwLWNhOS5kdGIs
IGFuZCB0aGVuIGJyZWFrcG9pbnQgdG8gdGhlIHJlYWRfY3VycmVudF90aW1lciBmdW5jdGlvbiBp
biBxZW11K2dkYiwgYW5kIHlvdSB3aWxsIGZpbmQgdGhhdCBpdCB3aWxsIHJldHVybiAtRU5YSU8K
CkZvciB0aGUgcHJldmlvdXMgc2l0dWF0aW9uLCBJIGFwb2xvZ2l6ZSB0byB0aGUga2VybmVsIG1h
aW50YWluZXJzLCBidXQgcGxlYXNlIGdpdmUgbWUgYSBjaGFuY2UsIGNhbiB5b3Ugbm90IGxpc3Qg
bWUgYXMgQUk/IC4uLi4uCgpUaGFua3MKU3RlcGhlbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkZyb206wqBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4KU2VudDrCoEZyaWRheSwgTWFyY2ggNywgMjAyNSAyMTo0MQpUbzrCoEtyenlzenRv
ZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47IHN0ZXBoZW4gZXRhIHpob3UgPHN0ZXBoZW4u
ZXRhLnpob3VAb3V0bG9vay5jb20+CkNjOsKgdGdseEBsaW51dHJvbml4LmRlIDx0Z2x4QGxpbnV0
cm9uaXguZGU+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPgpTdWJqZWN0OsKgUmU6IFtQQVRDSF0gY2xvY2tzb3VyY2U6IHRpbWVyLXNw
ODA0OiBGaXggcmVhZF9jdXJyZW50X3RpbWVyKCkgaXNzdWUgd2hlbiBjbG9jayBzb3VyY2UgaXMg
bm90IHJlZ2lzdGVyZWQKwqAKCkhpIEtyenlzenRvZiwKCk9uIDA3LzAzLzIwMjUgMTI6MTcsIEty
enlzenRvZiBLb3psb3dza2kgd3JvdGU6Cj4gT24gMDcvMDMvMjAyNSAwOToxMCwgRGFuaWVsIExl
emNhbm8gd3JvdGU6Cj4+Cj4+IEhpIFN0ZXBoZW4sCj4+Cj4+IHRoYW5rcyBmb3IgdGhlIHByb3Bv
c2VkIGZpeAo+Pgo+PiBPbiAyMS8wMi8yMDI1IDA0OjQ2LCBzdGVwaGVuIGV0YSB6aG91IHdyb3Rl
Ogo+Pj4gSGkgZGFuaWVsCj4+Pgo+Pj4gV2hpbGUgZGVidWdnaW5nIG9uIHRoZSB2ZXhwcmVzcy12
MnAtY2E5IHBsYXRmb3JtLCBJIGRpc2NvdmVyZWQgdGhhdCB0aGUgcmVhZF9jdXJyZW50X3RpbWVy
IEFQSSB3YXNuJ3QgZnVuY3Rpb25pbmcgY29ycmVjdGx5LiBUaGUgaXNzdWUgd2FzIHRoYXQgdGhl
IFNQODA0IGRyaXZlciBsYWNrZWQgQVJNMzIgc3VwcG9ydCBhbmQgZGlkIG5vdCByZWdpc3RlciBy
ZWFkX2N1cnJlbnRfdGltZXIuIFRvIGFkZCBBUk0zMiBjb21wYXRpYmlsaXR5LCBJ4oCZdmUgc3Vi
bWl0dGVkIHRoaXMgcGF0Y2guIFdpdGhvdXQgaXQsIHVzaW5nIFNQODA0IGFzIHRoZSB0aW1lciBv
biBBUk0zMiBjYXVzZXMgaXNzdWVzIHdpdGggYm9vdF9pbml0X3N0YWNrX2NhbmFyeSB3aGVuIGlu
c2VydGluZyB0aGUgY2FuYXJ5IHZhbHVlIGludG8gdGhlIGludGVycnVwdCBzdGFjaywgYW5kIGFs
c28gYWZmZWN0cyBlbnRyb3B5IGdlbmVyYXRpb24gYW5kIGNvbGxlY3Rpb24sIHJlc3VsdGluZyBp
biBpbmNvcnJlY3QgcmRzZWVkIHZhbHVlcy4KPj4KPj4gSXQgaXMgYmV0dGVyIHRvIHB1dCB0aGF0
IGluZm9ybWF0aW9uIGluIHRoZSBjaGFuZ2Vsb2cgYW5kIHByb3ZpZGUgYQo+PiBmaXhlZCBmb3Jt
YXQgb2YgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLgo+IERhbmllbCwKPgo+IEluIGNhc2UgeW91IGFj
dHVhbGx5IGNvbnNpZGVyIGFwcGx5aW5nIHRoaXMgLSBzb21lIG9mIHRoZSBwYXRjaGVzIG9yCj4g
dGhlaXIgZGVzY3JpcHRpb25zIHdlcmUgZ2VuZXJhdGVkIGJ5IHNvcnQgb2YgQUkgdG9vbHMsIHRo
dXMgYXBwcm9hY2gKPiB3aXRoIGNhdXRpb24uCj4KPiBJdCB3YXMgYWxyZWFkeSBwb2ludGVkIG91
dCB0aGF0IHBhdGNoZXMgbWlnaHQgYmUgYSBnYXJiYWdlIG91dHB1dCBvZiBBSS4KPiBBbHNvIHRo
ZXkgd2VyZSBub3QgdGVzdGVkLCBldmVuIHRob3VnaCB3aGF0IGlzIGNsYWltZWQgaGVyZSAiZGVi
dWdnaW5nCj4gb24gLi4uIi4KCk9oISBUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdyB0aGF0LCBJ
IGFwcHJlY2lhdGUKCkknbGwgcGF5IGRvdWJsZSBhdHRlbnRpb24gdG8gdGhlIHBhdGNoZXMuCgpU
aGFua3MKCsKgwqAgLS0gRGFuaWVsCgotLQo8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJv
OsKgIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0
dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5h
cm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZw==

