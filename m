Return-Path: <linux-kernel+bounces-577128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9C7A718A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592DF3AE4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67826AD0;
	Wed, 26 Mar 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RLgpivZE";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RLgpivZE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441151C8638
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999786; cv=fail; b=im8l4qOea91SqFhuo0zWjfUFb/cmLgZQ1PU1RqGIBr6rj3eU4z/I7N58Oy9vE4ROsYS/spPDfg4aK4ANkjj/EsotaaMrIolK2kP84Ln4rmRGwnDA2fMT/x/ZtZoP1CwJx77TE+rdUEOpxKMceofccAGTterR3rXQ3DXKnQ16ro0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999786; c=relaxed/simple;
	bh=v3odNvBQhplSv/DavxOhF2myQ1c0T0sX+PQn5HfXmIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GTtCnderreVCUN1M9qEn33qhvFtTKt9gEHI9BZXMgZFOED9K2FMM8We7MIpwVXh0uGwp4FF+t0eM5f6e3l7+nOZjd6+x1qrbe2fUaL8P1+OI/MsOrFzCOli/UYiYjxreEAvRIZOi7fmLIyZ4xlY8lrDnwUwF4njJG/lMBhvlx1U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RLgpivZE; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RLgpivZE; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qYBgp+ICPT/kHLBagwAW7ZnX+yBGo3T2WxTp93xu/+iAEv3PQacpiBtPJYy2485nrI3VnCdfSsk8nSSzJEPumxSAia0jXRfCH7Djxyb08N+H7VpwPWG2tg271tOFwbdXrGT2Ict45Z4N73Zp6MHszvHmAzbCIPDgiwxMQToUPxPfafH9gn7YxKbYOBlxm6f6mqiPIK2gFyUKi5GbmitRhfWjweSo3gC9rkwwpqIz3cpx+hECz8v6iPWSrWl1F/UNbMj+4pasFjGxasuXEqEZEKe1YQ/Qtp4EL9MzxAzRwzjkYf7F2xIlf1FPtfeiHhj3m1Xg4C4d7+weHwOWQLE9oA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Hqa+XH9OrYmp5gWR3fLRz+2TuIaIwPM3ofpp3q2Lc=;
 b=i1U7L4Q7EXWadEXtj2j8YGapLUYXXb9VV+BFAGHtS7TR8U8w2r86rrGmRrEiNlneAMLvg4dVtU8KyQfleRhCWXJR+0mQyGT3n7LQNaWTJ5KIYeHfAvG9Idwi8Xru2OWANI7rbHhFFXCPcgAmuDmheKpDXGYp5pf4p5oZh6QC24MImlJarA2HQ5L2nNl4u7OniZDsJoJp0BFHKuUuVMt8Wadmtvpkohs6qgcqWB6wlrss3KB71CqcpNCuJJEQ2cdVxzG8MA4ls2MC9/YjDa0utcCmjbmwE8Pwj8/GK3oKy7zmUopC3C68ZWBzo6YU/3/0/v+/K9ngZmCZF1vAr9Jh9g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Hqa+XH9OrYmp5gWR3fLRz+2TuIaIwPM3ofpp3q2Lc=;
 b=RLgpivZEQtnD5ngjQuY6Ffd6jEy7K3vHEiPGooqEREsBQVpbugQkREzSdjoBIs4cKZMDUJy8yq3IOgiS+UlWoHmbJ9q8IA7JDwPXlqSDTVNGjyVhnFVMGCcuou4PhTLdEa/ArZFzvb9UpYHM7tSOmJ7Vk3aNNG+dRSI2K9/N9jM=
Received: from DUZPR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::29) by AS4PR08MB7760.eurprd08.prod.outlook.com
 (2603:10a6:20b:517::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:36:17 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::d4) by DUZPR01CA0118.outlook.office365.com
 (2603:10a6:10:4bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 14:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 26 Mar 2025 14:36:17 +0000
Received: ("Tessian outbound 93207444acda:v604"); Wed, 26 Mar 2025 14:36:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e35a4b72b9370164
X-TessianGatewayMetadata: pM4DY1aZ10gomDuuY6qUhfXiPN0JuG8+AEfZiMEUulm65dnW9TQjWMRUbmbwJxuaTq5n64VW8Zj0qHBZPu8BNS1Zb/l+CTuT3ZJiFD7vF4jLrQ/Va6SIumOjh3s6z+g6YNoTMGw4oCcyHwsPcnoEeTzJ+GgeQxQSoM3MMIX0FA4=
X-CR-MTA-TID: 64aa7808
Received: from L634c22fcda5f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 609D3804-C2E8-4D84-ADA5-4FD0BFDAA1CC.1;
	Wed, 26 Mar 2025 14:36:07 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L634c22fcda5f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 26 Mar 2025 14:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWuc6ZQMLEP5f3wpV5yhZsoFojro9Bmvl0sbnCuEVhLTaeZciDyPkgFndULVMGa5JOl8npBH3jJOrfkZcSHqAQeO35+rEhxGRrUk7ladzIeZkYCOBnKWJbiAM/UWSAoeUS6N3NmwHl//riWDa6q/O0quzpv8CrPFfV97CGq/jBD8j3z0Fn+RmRtWgQxjF+Fef9z5GQTYa138OYbLYyMOsEPB5alfg3GTEttt004JtZVXzvg/1H+HJ5GVzW5wcwzncwaRCsnZ/+ugPkIQjSK/RRiwtf6E8OxxHgnz10j7U3Tz/gWoYtzpkEVlP8QFoQKMylCVJ7Otw6Ipuw+tHxaSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Hqa+XH9OrYmp5gWR3fLRz+2TuIaIwPM3ofpp3q2Lc=;
 b=yV5NiXj6AS0TMCBHIPwer8gAzJsItJRqr6lGr8ZhH70AoiaTnCHDFmbg3DegjT21TzGwUOHmuC5qvQUB7W49LU9rCPSF6IxuuXOw+3EueJbqEUH3k6YbvKH/oWW8CVv8qq65kP5C0bDBwgVbaE2i/UrftSsw4wnC00epNhNEKBY0I2hQzIgrTGTFpx+jbIt65CrfoTs2Fif7Q95q3wE+/4pUCpkHvr1/u38ZHBUzP6MbkwyspaFVsC/LwTgF3+8qnZxea2YlV5pL099Mvd+RLFuzGiUql/yEXIDs6XPrV2qTyLWKEbJt1U8tEVXPo3nFqEjP+j0stT377vQB9NcIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Hqa+XH9OrYmp5gWR3fLRz+2TuIaIwPM3ofpp3q2Lc=;
 b=RLgpivZEQtnD5ngjQuY6Ffd6jEy7K3vHEiPGooqEREsBQVpbugQkREzSdjoBIs4cKZMDUJy8yq3IOgiS+UlWoHmbJ9q8IA7JDwPXlqSDTVNGjyVhnFVMGCcuou4PhTLdEa/ArZFzvb9UpYHM7tSOmJ7Vk3aNNG+dRSI2K9/N9jM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3315.eurprd08.prod.outlook.com (2603:10a6:208:5c::16)
 by DB9PR08MB6425.eurprd08.prod.outlook.com (2603:10a6:10:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:36:04 +0000
Received: from AM0PR08MB3315.eurprd08.prod.outlook.com
 ([fe80::42a0:1b6e:cf98:d8fc]) by AM0PR08MB3315.eurprd08.prod.outlook.com
 ([fe80::42a0:1b6e:cf98:d8fc%6]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 14:36:04 +0000
Message-ID: <a6791291-e40f-4a41-a84a-74afeaecf0e5@arm.com>
Date: Wed, 26 Mar 2025 14:36:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/8] drm/panthor: Add panthor_perf_init and
 panthor_perf_unplug
Content-Language: en-GB
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mihail Atanassov <mihail.atanassov@arm.com>, nd@arm.com
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
 <20241211165024.490748-4-lukas.zapolskas@arm.com>
 <lgdrzylx2pf3t3ive7tcmuqlqu2vpjuvf5ztnyuoyrb6onecgh@6vieyyz5jzoj>
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
In-Reply-To: <lgdrzylx2pf3t3ive7tcmuqlqu2vpjuvf5ztnyuoyrb6onecgh@6vieyyz5jzoj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To AM0PR08MB3315.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB3315:EE_|DB9PR08MB6425:EE_|DB1PEPF000509F7:EE_|AS4PR08MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4e72b4-08be-48a6-d76e-08dd6c7391c2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SUpRdWdiNTVscG5JWGJPNEFMYnF0RTR1RitTN2UyRXdRd0xmRHZpNVJvNmpW?=
 =?utf-8?B?b0Z6WXppRFQ2a2VYR2RWQlkvTEdnZVJJUkhlQ1Y4K2o3RjdDOXo1bDE5b3hS?=
 =?utf-8?B?NEFVTjdJUHovWXoyaW9HVk9jd3grQ1JHcVpjQnlIV3h6L3lHTVlhYXppMGZh?=
 =?utf-8?B?cXE4b2R2UlpMN3hIZ3dBWnh2dTBmMVAyNlliM2JYeUd4VnhWLzc2aFNONFFT?=
 =?utf-8?B?MmlJZEVEOW9WcUtic1J5K3ZwbUc5V0lEVkpvN0M0dW14VllvV094aVozZ2JI?=
 =?utf-8?B?R3BKeVB4SlQxZFBIakJWZUdKQWVCVjh1RTFCZlRnWHVMZmJQY25xd0R0cm5y?=
 =?utf-8?B?RFBodGdKYXNmN2lQdFRvWCtmMmRzTjYxbEdqQ3J5SjJ6Um8zbmxKbk1kSHBT?=
 =?utf-8?B?c3RnNVZGTml6dk1QTmpiUFdrczJLaUJ3Nkw1OEFRdE1VVVlaMXdDY210TTFZ?=
 =?utf-8?B?VGJaWGdXSDhsWE13c3hGdU4xRk9DczAxVzkvS3IrdStIaXY3TTJNU1NEenZN?=
 =?utf-8?B?QjNpRTBCbkt3VUZhOTdJQUpIMHFpVy9Id0UxZFh2bmt3Ump4dGh4a0F5T21k?=
 =?utf-8?B?byswRHN1MEJ5SzN3WlpCVkJFTm9hTTF1b3JxcjVqSFdkRWhJalQrRFlsVkgy?=
 =?utf-8?B?cHY5ay9EU2MwRnF3eXVpeURUR2F5SHh1OXFrdHh3aE13MTVsbzZTS09ReE55?=
 =?utf-8?B?RnhBVkt3aDF3VUlIcDNpc3A1bHZVOUdmSlpaUVVVKzYxNUEwcXhvSldXVVNn?=
 =?utf-8?B?aHpPenhKRzdxVktHd2JlNURxalZIcThFWGZna05TQVdnUXZCcmpzNmE1VTJK?=
 =?utf-8?B?bm9ueWdFSzUvb3ZjSWZSOVV2OXZYRktPdDB6TFhKaDVyZ1FoZ0RHZ0p6ejFq?=
 =?utf-8?B?RnZCbmpjRUhqSkNzOGV3ZlliSTdMM3Q1Slh6c1F5TW9MZEcyRUZ4NkE0bDdK?=
 =?utf-8?B?UHJlbUk2QXlDVU5vZy85bEtlM2ZvdFI2SFIwMWNtdVI3MlZGbjgxeENIeE9Q?=
 =?utf-8?B?ZVVibHUvNUE2T2k4TnREQ0ZSRVh6SFcxWmdiVlE0Y09TUWlqdit3eXlxdEVz?=
 =?utf-8?B?cnVoaWdZbmhNQWpGYmpTTWNaWEdUd1RnUkZUOFV5L1NrdVAwbVM2QmRPQTg4?=
 =?utf-8?B?aHlMeDAyZXdkcVlOQnlaVGU4SnNxYTFCNE80NURueW9CTmtnWmVFTHcrR2FQ?=
 =?utf-8?B?RnNJQVQ1RWVBRUJER0FoZHBRZG9nVGlRNTV2TzlncjB6NW9YQzZidng1djg4?=
 =?utf-8?B?NG5KR043ckVhYU1ObWZ6VWg5Q2JpZWVsNXdPWnhWSmxuK3NlcTlTeUsweUE5?=
 =?utf-8?B?WjV5aVdkbFpINGlrNXlvUFNzUXQ4bG5rd3Y2RjduNDhMMDJjcndLSVF2WFY4?=
 =?utf-8?B?Qyt4UENMTVRxb0FXL1BKUng5cmF1UnZNQzRsa29wV0liRjRzUkI3bnIxbkFy?=
 =?utf-8?B?QnJSU2JlaXlYVFExMkhhTUhaTkxVbEhOVnNTNFJkQUFHSmd0RHJPdjR2QTFp?=
 =?utf-8?B?ZGlSMmZGdWFzaDJWMUxDVnlrbnlWbEsrd2FvUUtKUWw2dzJacTV1ME1zZXlh?=
 =?utf-8?B?Z2NtclZrZTlZdUZkMDh4Mk9wZWFYZG9tc1J0TTlxOE9sSTFMMEVvVVZWTUtw?=
 =?utf-8?B?T1U2NVJtaDZseW5kR0dUZGFLUnlyaEN6dVhYQXA4ejRNaE1oT0NrSlZkajRm?=
 =?utf-8?B?MTJrTGhZYVFyVjdRU3I5bjNEeEtXbS9sd0lCcStNUHZDNldzclVKa2U5eXFo?=
 =?utf-8?B?bms2dXBvd21udENhT3UyRXVlTndBWThEUzNYNkEvK1o1d2QrUTN5YXZJS2Yx?=
 =?utf-8?B?YnVRdTZENjlNdXdxdGxLRDUyTVNJYXB1QSt3L2FsVngybE5NSDdUTjU4L0o1?=
 =?utf-8?Q?OR8q92nvsr0YH?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3315.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6425
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:208:5c::16];domain=AM0PR08MB3315.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	51c6776d-4dfc-4742-86d8-08dd6c7389a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|376014|35042699022|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWxKekYxNU5tYU5lRDhzRzE3TllSbWZPdFBDU1RDV0xhZjJEeHQ1Rm9MaFM3?=
 =?utf-8?B?TllxYlpLM3JhQjMxZGxtRTk1Y3UrTVBNY0NBWHdrSThiaEJkTlZwa2tzd1hR?=
 =?utf-8?B?MHpIQllERU1udXlPMXVKLzVZWGVxV2lIR0ZNTUtmK1J3SjZ4UFg5ZHB0TkY2?=
 =?utf-8?B?WnZmMDhVelJOQktOd3lxdjFIRlJOZUxIUklheU9xcW15dGtEWDcwM2FDdVg4?=
 =?utf-8?B?ejBPcVYzSjY1bGxMbEZkMUVxOEtTbXR3dFV5MlhIcVAwOU5UWGQ4d25sYk9p?=
 =?utf-8?B?RHFtTi9YVlZZT0toOHptSTUxNWtsa05IRy9oMDlvK1RaQVJyaUhVT3UvOEF3?=
 =?utf-8?B?QllrT0FnRlovbzdVMS9aOGJaZXhySEYyN1VyajFwbmdRaStZSTZPUzdLOUI2?=
 =?utf-8?B?Qmg4bU1hTjh2SFR2dGVaRHJhaGVzRExsRnU5VHVsOFpmaVIwOGpXTjlFSkFy?=
 =?utf-8?B?cTEvWXh6Mnljbk5QVUltZ3EzOC9ST2hBS2VYTmJKeE9UODBhUjNzdHkyVjBq?=
 =?utf-8?B?M1VPRERmcCtUSmluY0xrT0IvRjBzU3d1RDhubDZJMGlBak02K1pPcHQvNzZQ?=
 =?utf-8?B?SzVSQUtoa01HekFZZzZaVUVSTzV4emdsUmFiMHBBNnlzaEsyZ043OVR5elZR?=
 =?utf-8?B?TjZyaVZKZTZnekJETWduZGMwb1NZVzRiWm9ieCtxYjVrWVRXZjhRSm5NNlVs?=
 =?utf-8?B?S1lZRi81VklTQzFzM3FBSTJEb21pcUhJMGRxU0k5b09vNU0zbE5RVmtrckNN?=
 =?utf-8?B?eDc2dWVnRjBRRjMwamhWU3VRc2NyNklBY2hzUnVJUE8xeTFWLzllUXBYNXJC?=
 =?utf-8?B?cTZLOG5NcU5qRjE0aVgyMGdpM3ZWUnptT2Nac1A4dDhodFY4eWRYSGVHN3lR?=
 =?utf-8?B?cXl4U3FaOE1GN3FJZzhmc3dUa1VaNEptc0x4WDc1aUFPYkxwL20rbis3MUp0?=
 =?utf-8?B?c0Q3M010bUFxVGNPUkVHcmNCaEhWK0NDbWtnendJelljMWxsWFJmMjE1WUtk?=
 =?utf-8?B?U0h2UlhIdytvL1N3VUdFaklwTnNucWtIcmthOTZrdkFGYzlqd2IyU2JlbEQ2?=
 =?utf-8?B?NjlrWTFwTFNnOWovaHV3eng0TXVVYjh4RzBoRmRJYmlDbXNrN29PYTFDbzJ0?=
 =?utf-8?B?ZEJPTTZKelRNUU4zVDJjRi9SVGdVdjBNMmVkTXRoWlRoQ3RyNXJKM1N2Q1VE?=
 =?utf-8?B?bjIvS05xYUNYN1RXOWJvbjQxQW4xckZFN2R6TVpab0RjSFhMMkYxWGJvUzRZ?=
 =?utf-8?B?L0t1b0ZWRDI3SUkwOVNyUkRjM3d2VzltWVFrTkFveC9CRHZhY3FIMXVHejJy?=
 =?utf-8?B?aUYxeUxRQmgvc1E3YXFUR0E5MVpMM1BIYml5RWRXRVR4T2JqVFczU1pSSVdV?=
 =?utf-8?B?QVBGNFFCMVZPUE5DR1RHeHdoZGtEOVdZUHpyeTA5Yjl1dFRINzZkSURmSVJ3?=
 =?utf-8?B?QzdscHErVEo5bkIyZy9CMGZhVEJxcFR5ZTNDS2EyR2d6Vm1PcGQ3Y2xaNFJ1?=
 =?utf-8?B?OFVGeWc3ZVpKSkErU21Ha1FCR3cwY09USG95S0l0M0dwR0Y3RnhMTGRaNU9r?=
 =?utf-8?B?QUZFSWdFRUlVSFZ3QzJWTlNkM0k4K3FQRWQ1ZnQ5WG5MVEl2MjNpN2RnV1lN?=
 =?utf-8?B?STlzVEJ6WFdKM1dBTVVrWlhvMHZCbnc5RE1wTHlMbitheDdCSHFia3dVVmNm?=
 =?utf-8?B?UStEZzlBMGhJRlhCMlVTMDNlUHgvdStZRXlyeHJrbU13Q2FIeUtlT3FqNGlO?=
 =?utf-8?B?TGZIZmNEd04vS1plcG9WNmttc2w2WmpyTFFoTGZYbXNKRWVBNldNZXBlM3VL?=
 =?utf-8?B?N3QrMXNRTTJIS092UDJNVnFxUXhwN1lQZHZEWFVqRXlFNldHSm5VTmNjMjRk?=
 =?utf-8?B?aEhaSU5tZWt4cHkxa0pxNjM5MlhXck5jaFBHd3pXa0pCMEw1bkRTUHBIWjVS?=
 =?utf-8?B?QU9WZSthQ0ZGUDhiQ3Bsc1QybFRmeGhxc3pGa2YwNmM5bDNtb0V2VGc3dDdY?=
 =?utf-8?Q?kQYVClb8OKmjw8kUXDF7b1YnTDlnNk=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(376014)(35042699022)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:36:17.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4e72b4-08be-48a6-d76e-08dd6c7391c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7760


(please excuse the line-wrapping on the previous email,
it seems that it was soft-wrapped).

On 27/01/2025 12:46, Adrián Larumbe wrote:
> On 11.12.2024 16:50, Lukas Zapolskas wrote:
>> Added the panthor_perf system initialization and unplug code to allow
>> for the handling of userspace sessions to be added in follow-up patches.
>>
>> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
>> ---
>>   drivers/gpu/drm/panthor/panthor_device.c |  7 +++
>>   drivers/gpu/drm/panthor/panthor_device.h |  5 +-
>>   drivers/gpu/drm/panthor/panthor_perf.c   | 77 ++++++++++++++++++++++++
>>   drivers/gpu/drm/panthor/panthor_perf.h   |  3 +
>>   4 files changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
>> index 00f7b8ce935a..1a81a436143b 100644
>> --- a/drivers/gpu/drm/panthor/panthor_device.c
>> +++ b/drivers/gpu/drm/panthor/panthor_device.c
>> @@ -19,6 +19,7 @@
>>   #include "panthor_fw.h"
>>   #include "panthor_gpu.h"
>>   #include "panthor_mmu.h"
>> +#include "panthor_perf.h"
>>   #include "panthor_regs.h"
>>   #include "panthor_sched.h"
>>   
>> @@ -97,6 +98,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>>   	/* Now, try to cleanly shutdown the GPU before the device resources
>>   	 * get reclaimed.
>>   	 */
>> +	panthor_perf_unplug(ptdev);
>>   	panthor_sched_unplug(ptdev);
>>   	panthor_fw_unplug(ptdev);
>>   	panthor_mmu_unplug(ptdev);
>> @@ -262,6 +264,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>>   	if (ret)
>>   		goto err_unplug_fw;
>>   
>> +	ret = panthor_perf_init(ptdev);
>> +	if (ret)
>> +		goto err_unplug_fw;
>> +
>>   	/* ~3 frames */
>>   	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
>>   	pm_runtime_use_autosuspend(ptdev->base.dev);
>> @@ -275,6 +281,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>>   
>>   err_disable_autosuspend:
>>   	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
>> +	panthor_perf_unplug(ptdev);
>>   	panthor_sched_unplug(ptdev);
>>   
>>   err_unplug_fw:
>> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
>> index 636542c1dcbd..aca33d03036c 100644
>> --- a/drivers/gpu/drm/panthor/panthor_device.h
>> +++ b/drivers/gpu/drm/panthor/panthor_device.h
>> @@ -26,7 +26,7 @@ struct panthor_heap_pool;
>>   struct panthor_job;
>>   struct panthor_mmu;
>>   struct panthor_fw;
>> -struct panthor_perfcnt;
>> +struct panthor_perf;
>>   struct panthor_vm;
>>   struct panthor_vm_pool;
>>   
>> @@ -137,6 +137,9 @@ struct panthor_device {
>>   	/** @devfreq: Device frequency scaling management data. */
>>   	struct panthor_devfreq *devfreq;
>>   
>> +	/** @perf: Performance counter management data. */
>> +	struct panthor_perf *perf;
>> +
>>   	/** @unplug: Device unplug related fields. */
>>   	struct {
>>   		/** @lock: Lock used to serialize unplug operations. */
>> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
>> index 0e3d769c1805..e0dc6c4b0cf1 100644
>> --- a/drivers/gpu/drm/panthor/panthor_perf.c
>> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
>> @@ -13,6 +13,24 @@
>>   #include "panthor_perf.h"
>>   #include "panthor_regs.h"
>>   
>> +struct panthor_perf {
>> +	/**
>> +	 * @block_set: The global counter set configured onto the HW.
>> +	 */
>> +	u8 block_set;
> 
> I think this field is not used in any further patches. Only in the sampler
> struct definition later on you include the same field and assign it from
> the ioctl setup arguments.

Will have to correct that, it should be used for the FW programming and
checking whether a session creation request can be satisfied.

> 
>> +	/** @next_session: The ID of the next session. */
>> +	u32 next_session;
>> +
>> +	/** @session_range: The number of sessions supported at a time. */
>> +	struct xa_limit session_range;
>> +
>> +	/**
>> +	 * @sessions: Global map of sessions, accessed by their ID.
>> +	 */
>> +	struct xarray sessions;
>> +};
>> +
>>   /**
>>    * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
>>    * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
>> @@ -45,3 +63,62 @@ void panthor_perf_info_init(struct panthor_device *ptdev)
>>   	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
>>   }
>>   
>> +/**
>> + * panthor_perf_init - Initialize the performance counter subsystem.
>> + * @ptdev: Panthor device
>> + *
>> + * The performance counters require the FW interface to be available to setup the
>> + * sampling ringbuffers, so this must be called only after FW is initialized.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +int panthor_perf_init(struct panthor_device *ptdev)
>> +{
>> +	struct panthor_perf *perf;
>> +
>> +	if (!ptdev)
>> +		return -EINVAL;
>> +
>> +	perf = devm_kzalloc(ptdev->base.dev, sizeof(*perf), GFP_KERNEL);
>> +	if (ZERO_OR_NULL_PTR(perf))
>> +		return -ENOMEM;
>> +
>> +	xa_init_flags(&perf->sessions, XA_FLAGS_ALLOC);
>> +
>> +	/* Currently, we only support a single session at a time. */
>> +	perf->session_range = (struct xa_limit) {
>> +		.min = 0,
>> +		.max = 1,
>> +	};
> 
> I guess at the moment we only allow a single session because periodic sampling
> isn't yet implemented. Does that mean multisession support will not be made
> available for manual samplers in the future?

The RFC was intended to purely give a functional implementation without
periodic or multi-client sampling. Multi-client will be available for
both periodic and manual sessions, once periodic is implemented.

>> +
>> +	drm_info(&ptdev->base, "Performance counter subsystem initialized");
>> +
>> +	ptdev->perf = perf;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * panthor_perf_unplug - Terminate the performance counter subsystem.
>> + * @ptdev: Panthor device.
>> + *
>> + * This function will terminate the performance counter control structures and any remaining
>> + * sessions, after waiting for any pending interrupts.
>> + */
>> +void panthor_perf_unplug(struct panthor_device *ptdev)
>> +{
>> +	struct panthor_perf *perf = ptdev->perf;
>> +
>> +	if (!perf)
>> +		return;
>> +
>> +	if (!xa_empty(&perf->sessions))
>> +		drm_err(&ptdev->base,
>> +				"Performance counter sessions active when unplugging the driver!");
>> +
>> +	xa_destroy(&perf->sessions);
>> +
>> +	devm_kfree(ptdev->base.dev, ptdev->perf);
> 
> If we always call devm_kfree, then what is the point of allocating ptdev->perf
> with devm_kzalloc?

You're right, it's not necessary. The panthor_perf object could in
theory be allocated with devm, since the lifetime matches that of the
panthor_device, but it's simpler to drop the devm allocations.

> 
>> +	ptdev->perf = NULL;
>> +}
>> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
>> index cff537a370c9..90af8b18358c 100644
>> --- a/drivers/gpu/drm/panthor/panthor_perf.h
>> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
>> @@ -9,4 +9,7 @@ struct panthor_device;
>>   
>>   void panthor_perf_info_init(struct panthor_device *ptdev);
>>   
>> +int panthor_perf_init(struct panthor_device *ptdev);
>> +void panthor_perf_unplug(struct panthor_device *ptdev);
>> +
>>   #endif /* __PANTHOR_PERF_H__ */
>> -- 
>> 2.25.1
> 
> 
> Adrian Larumbe


