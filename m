Return-Path: <linux-kernel+bounces-398399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28D9BF0D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169E71C21315
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BB201101;
	Wed,  6 Nov 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bf7bXhox";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bf7bXhox"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54E1CC14B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904899; cv=fail; b=P7iagLWDKPxsWm1KGjDzdrhHo789xD1lkREHWHL41s0s17ZSp8n47Yca1MJ9mmb0sJ64k7InAn3fpYIPv7alaPirz+RwpMHNWM6fQf86xJSvj+PwhxJ/rHGWzLaIKnVw0rTCYWCpT+paetkbPFqW8ralj4wKkOD3sBnT4+nCvYc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904899; c=relaxed/simple;
	bh=xl/TjhPcIX+3xcqVE/AkfxuWFCf9Jb0YPggQg5adQkw=;
	h=Message-ID:Date:Cc:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mSaHNiA1If25y9f4HlXxQK9f1hjIm5CaxAjHQQxesjEVgVdKuYtUYuPl/+dVtp9SGa564GIAomPSkMuHiAk/dQB61pI/RkTZtgaXLGOHKC0v+/3XjjByM2s5osNDc2ymYqL4s3z8c0WLgViVtGnxB85ov4gZR+MVoQfAVjrVJ0o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bf7bXhox; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bf7bXhox; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=x/iCzdxeqH5VScQNs3JF6PYkNemIOsklnjYKtin7zULjppPGd++SGNyRgFBukUGlFvrsMMXrBTRxyoF45RLav9hXlttH+Qd/BMH8HKMnRfCcQmAp4n8E6o6a7SAH8JZ0k7c2BE1LV+2SsHXasT0Fg2/pTwh08vwnm7YwIa4D5oqJpYpj4VdDxoXDigCl1W5rNGhBz6IhQKlANTRx4WMq/QvrKuSeyov2JD4RRH3b0g9EhlvglKP+4xSWWLIYhqY8jYxSm/plchCaryeKF9JdtbJgENtN2BkZJVOG6n3jIyUEj6DXOkmqNlHcqhiS52Y0gf6yXHzWw6lrmRMVxaidrA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNX0UwRv+qLsNsRZwiinlwfPfEA+K3X2Rc5FDmrwnfU=;
 b=y+qpnTD2S7Bghep6XZPgiyHyJtSZn+ITu++/ONJS6Q8BN8F9x48Krd5L57fok28xjxqoVGGJb5x8krmfaKYbeAHjXVHZNSIMPcIHcCMESEH6l3lZGQ+3m3rvFRZYpAYT+2HBcjFtbqYanIGk+SDNBey5S7C5nwM9nvoMsqIwiImYDaXojYRdwgcboApuMBHbiipdhF0F5vNIrGeDYZBtlI/00bQyGmLYwHSO0wCa55nUfEbWD/x2F5fQENr20D+/LD+UZO1m6Fqdh5yBuaQkuaRBXfa7mFAF+Y0WE40++t1DkPO4qer4EhNUMKPYAMxowTMDV3F87Cs4iGf+FmNAHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNX0UwRv+qLsNsRZwiinlwfPfEA+K3X2Rc5FDmrwnfU=;
 b=bf7bXhox5U5Y3GNj9ZZ1qkIDUyVb8dO+Xj2D0gGACgVWjOeNaI8/czvOZf0rUTpiz21uBTMbuS5nL1HxSEghj+PassNWGUQLqiiBIyzlodBdSUcnUrKhRgS12lTWMGHJP8Pxihe0OV9TmqHHJaikKmhALUPEAZElhhB4Jjp2Pzs=
Received: from AM6P193CA0125.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::30)
 by DU0PR08MB8139.eurprd08.prod.outlook.com (2603:10a6:10:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 14:54:50 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:209:85:cafe::fd) by AM6P193CA0125.outlook.office365.com
 (2603:10a6:209:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Wed, 6 Nov 2024 14:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Wed, 6 Nov 2024 14:54:49 +0000
Received: ("Tessian outbound 4a86a9c66651:v490"); Wed, 06 Nov 2024 14:54:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb93ed8f21fdd855
X-TessianGatewayMetadata: 9HrQ6pzOh83UnyzXQy9mILFIph6dYIpfSH0JtQnZuJQ/w2dxtsFwQYRvY4OoljkyBzE74sKlrx3B4uH94s7MjQRhMpaIBdLhr3pZpOMOna2LF2AG1MzYn+KpWYeUDbrkt8RVO4apYjV+oWhubnBFUQGAliguvh5YZeGHezfC8Go=
X-CR-MTA-TID: 64aa7808
Received: from L0df2076e97fa.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CDDF1B90-5F8D-47DC-A1B8-EF702E13F8DE.1;
	Wed, 06 Nov 2024 14:54:23 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0df2076e97fa.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 06 Nov 2024 14:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLCrkckhU0Ihb/1ZwXdwa7h2qFIsUfE0aNw4C6lEKbFPRy3qaauh5m406xd453Z8QHh5cMtVU25FmM1EHNmN0hr9IyxGly4fR2RI5ETCVczA2e34BYahaCQ64Fa3PJJ16Rl9y41XGA8xWPID6Usz5ViS2aJ6RLPhOot+PskQnN1QRGZNsZoEjJXygJMNsFaawZW+5FNrNQ2TYTdYTc/VP1GKE8ns6m0GMtXkeBL2uLdcmuO/Ife3zsng5c4vpw3DFyfwWNeptT7NidGM/0j/PkV9FeHagciBj03jCpxsbETSHFO6/r5TrhtcgQcidVLtlo8MmQHx3FTr+JIA+DFlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNX0UwRv+qLsNsRZwiinlwfPfEA+K3X2Rc5FDmrwnfU=;
 b=uBB0Dcq129Q590hhCD6s72g852ywHsfzEkFlOn9Rsf0rjaIKOx4igdc+tN5JB+vKKNiA36jX2eNTl3dF7dtNPDGpT4DJOAfZ4qT+xwjxQcJiPxpXHQN78Z4LAlmudCWO1y3Yl9bK7Wz2mR3Z+Au6DX0hKIqsJgDb/6nkJUXO5DLrObYkiaggUt9LLrDdQYtQf8y+MYKFNJM+8DQN73HmrN5kew95G6C6lS8H4cPyEkcmj2WStGnJiCARTCDZAvK8WX63HiXIV7p1e3yBh6zf5E+b8jh2BoHFMmiuXOkwDPNDZVRKxUoxGsoCTKU6xeB3EWuGNEElr/Rt3ft15Qftzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNX0UwRv+qLsNsRZwiinlwfPfEA+K3X2Rc5FDmrwnfU=;
 b=bf7bXhox5U5Y3GNj9ZZ1qkIDUyVb8dO+Xj2D0gGACgVWjOeNaI8/czvOZf0rUTpiz21uBTMbuS5nL1HxSEghj+PassNWGUQLqiiBIyzlodBdSUcnUrKhRgS12lTWMGHJP8Pxihe0OV9TmqHHJaikKmhALUPEAZElhhB4Jjp2Pzs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by PAVPR08MB8845.eurprd08.prod.outlook.com (2603:10a6:102:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 14:54:21 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%3]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 14:54:21 +0000
Message-ID: <2f4a5d25-a804-4a3e-b4db-efce774b9692@arm.com>
Date: Wed, 6 Nov 2024 14:54:19 +0000
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
 <4e7bc9e6-f3d8-4e21-94d9-414ff0857553@arm.com>
Content-Language: en-US
In-Reply-To: <4e7bc9e6-f3d8-4e21-94d9-414ff0857553@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0686.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::18) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|PAVPR08MB8845:EE_|AMS0EPF0000019E:EE_|DU0PR08MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: f371f20d-e395-4977-5ba3-08dcfe72f685
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M05nbGhzSEpvMXgxaGt6bEtkL041WExvQStOb0JLVElRQnBiNjgxY3hjNXdo?=
 =?utf-8?B?OTFzZmttd3A0a0RteUpkeXlqVkk0WU1ZbTJYZVUwQU11RTYvYTNNOFZpdTYy?=
 =?utf-8?B?L1pnMWEvb2dHWEdDZllVQVI3bjROeVZKOEUzMjd4dXJDdGJyMUYwMGVoQVJ3?=
 =?utf-8?B?NzI0RHpsU2xGbWw1NDRxLytJSk1OcmZsd1A5SDdJRXJaRDVBc0tYLzU4aXJm?=
 =?utf-8?B?Skl4UWJLTzkrSE5xTzRyMjE1NW5jNEJIaFVtcDQ0QzdpQ2R1NFMrL2hRYTdM?=
 =?utf-8?B?WSt4dnlkOG41U3IzSXNXR1NYbmovV3FqUHdPM0FUS25XSE9QWlIyWUdMT0ta?=
 =?utf-8?B?ZkhyQ043Qnl1NGgyMjAxbkVRNlRGckpVZWpLdm1zYk01YjFhU09abzEzblRx?=
 =?utf-8?B?RTFoMXdmWjY3SU0xMWNXdi8wYlh5RzhEd3Y0YnlaZHNxdjZzUm10WjlyTzhr?=
 =?utf-8?B?bmZNS01zK0dWNGVNNCtiT1Yxc3VkQkRjazRzVUZTV0cyU2FFVDVXOThZa0Yz?=
 =?utf-8?B?R2hhYUVHejNHTzFVVmlvSFhLcnBVaXVGTmNHbzFwSEVTWjNmb2FtSXdvbHZl?=
 =?utf-8?B?dkRFS0JlczAzRUlCdjJBUWlOeWM5Ny96UkRHTkNIRjNyQlFiNVgwd3V5NS8v?=
 =?utf-8?B?ZXlaRjJLZ1lkSnFEeUE0WmV0cFdEc0wrZ3hnSXUvUmlEWVJQZjY3c1JKcGVm?=
 =?utf-8?B?MXJuSnNJYW9zNTNTdU5NeFNpNlhmdnJKK0ZVdUpuNkkyM2E1WGk0cUJlUlBp?=
 =?utf-8?B?bnFYenJ1Q2NEYkJQSjlYMlQ3UG11MGN5dDBZc2ZOZ3IxRFo4WDhMU1FXaDlE?=
 =?utf-8?B?OUZnbGY4SWQzNEZXSXJFd0V2MUk3UUVybUt1MlcxWmtZTjF4S1l6Ulp5UmNB?=
 =?utf-8?B?RGdER1hTc2xEaXcyWkVXNEFjaDFvOGM5RmtIb1JoaEozNFdobFR1ZStOZDkx?=
 =?utf-8?B?Q2NxcmRGazk0WlJ5SGYrZm00djMwRTRYekRUV3Ixa2JOYllVaDU2bUtaUzRI?=
 =?utf-8?B?VFVhR3FVNFBXdmVOdGY0S1RlODV0a21zZEpmTFZIQ25maGZJTUxrdGNKWVFQ?=
 =?utf-8?B?SU9IMUJIOE9FVm93Q3hlZG90cVBwNFBVVDcwOXdiZGJia0pZUjVwQkpqZEFL?=
 =?utf-8?B?cVZyT2JxeWNSd3MvWEtuUEJOL241UUhIQzlXbUR4bERoTkhaSy9QSmZETTVn?=
 =?utf-8?B?UzNCaG9NditRNnM2NWxGQTN6NXFkc2lPVkZSTllJY0VtMHd4MWFSdW5idGR0?=
 =?utf-8?B?cE1reGVLbkxIckVoQWtPR3JtaUsrR1dWM3A4azJwdzY3UHNKaGZnVytiTUNF?=
 =?utf-8?B?VVd0TW8yb3B4ZndGZHNlUUZzZTdlL0FnMnZ2c0tsOFRFdlBnWHFYUzNYZDhu?=
 =?utf-8?B?NGxSVWR2U2sxeEUrUHVrMHhHRUh6VzhMVU9uRkFyMzkvRVV6U1pnUm8xUG0r?=
 =?utf-8?B?aXBxdzErZzZjdXdhaXAxT0ZWRXFLalNUWVV2dkFBdTFBaGNQSnUrV3JmbllJ?=
 =?utf-8?B?YmRKNEhNNVQ0ck9oL2VzZmZSdUprMG5JMVU4WG9CdDJPMXdMVGRpYjBzQlZy?=
 =?utf-8?B?TjRTenNmSlc5UmhycTZBei9LdWRGeEcrNitFV21aZlFNakJrWWZORXdPSWVm?=
 =?utf-8?B?ZkdLL2hnOHB3YW0wUTJuNmExZ2d6UEdkMDRYMVFRS0VuaHNINDRMS25tN1Q1?=
 =?utf-8?B?V25SOHpBRVJKOXZpdUgzdHE3MzFWa1QvV1Z6RTR4cUZxOHl1TkdDSG9UZVlv?=
 =?utf-8?Q?+p5MCLh6deQGivJNtZ4FZCz9X67zdywusgwSO2F?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8845
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6524eaf-2497-4404-aefc-08dcfe72e55c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTUwbjhzVE55N0lZQStzZEZMNG9raGJXN2NTcjRndVJWWW4xOHRlK0pyd2Zl?=
 =?utf-8?B?QWJIb0NrTTYxbHQ3SzQwSVhLcmY2MnV0dXlpQjdlbUM0UG9sSHVISkNyTlJw?=
 =?utf-8?B?aGJxc0NLMk4rT0FnZEtDbGFyOGRiM2dFNHJ4dWVORDl1dGZDZG5YQnprZllF?=
 =?utf-8?B?Z1RmMC9USlRrTmtkS3lWVmZ4SGNUd3JUZnFJNjhKVFhrNHRHbFVzSWhKeVdr?=
 =?utf-8?B?c1VpTDhIYWhvV21YME44TlpBM0FrcktCd2pkak5Zd0E3Vkh2aG9GR1FzM2Fv?=
 =?utf-8?B?TDUrYzdZZTlQVWcyb0cvaEhzS0t2YUZhclU5Y0lMeWV5c3VlQVljaTlYemhY?=
 =?utf-8?B?bjF6TVJNd3BUdTJYM0N1UTQrQ3dHUmpBOGxUb25qQWxIamNYTldUY3Nmb2py?=
 =?utf-8?B?WWlxbXJwMXViSkcxOXBDTFhhN3JDZDUrMU8zdC9GTkduWHRSVCtGWVRHaXRi?=
 =?utf-8?B?QUpvOUt2RUxnRWhMdlVVSDRKbGFUVFRwZWxMVktDWXBxa2pzQVk3OUw1bWV0?=
 =?utf-8?B?YXJ2MnFiUXJsK2tiU1JhSUtjWmJhT1hwbU5XbzBwbmZHYW14VUpqZmtiaGwr?=
 =?utf-8?B?TEVRWGZZTDRWU0lWVkdiWjhlOVQya2tlcnhZL1lLbWcvVnNEbXVGTlNYZklj?=
 =?utf-8?B?ekEwb042VmlBNTlRbzlaTGZOc0VJa21FNDhhUC9MeGV4ZUFRTE4vNUtHTzc4?=
 =?utf-8?B?N3hqQUJubHVteTZnaDhlUmhhaXg0MDNFRm1sbzJEUndiZUtCc1ZTczVJejlO?=
 =?utf-8?B?dHNuUzFQMFNFTUZ6cWlUaTVkYkkrTUlDMENGQi9vOHFWYWpnVGo0SVFjYTd1?=
 =?utf-8?B?YlZyVTFQSFRuUzExMW1xdXFhbERMUWs1bkNxTzUrUXFTOWxKblUxUUw0YUNW?=
 =?utf-8?B?bEhYeG8yT1FjTXc0S0t1NXo1NlhKOVg5ZnBha3k5clkrdkhhSjhOTjNwcEJP?=
 =?utf-8?B?bVFNMnV0UGdldTJiZWlJR1pVZFI1WFFodWR4RTdIOHpleVZuUDdDMmMzWENp?=
 =?utf-8?B?cVhKcUI2d2N6bnR4RXdSRzAzQmNyWWZVbTl0alFoMzV2NjRVYjQ5SEZHQjFr?=
 =?utf-8?B?NGViTFpVOUh6NnVCeEYxTDE2RHdLcy9UNjJDWFBGQXBIOWUvU1c0a2lGWjF6?=
 =?utf-8?B?UXJhc2drbU1CQThvN0JqV040b3lYTEhlUHFnTHFlK0l6YmlhTm1rZWVKeUE0?=
 =?utf-8?B?blBSSUgwVmFPdjcwOW5rQ2VIVi9GYUZhL0lVd3V3MEZIUWw4MmpVRjM3bUpp?=
 =?utf-8?B?OEFQQjNJUzl4cjRBMG5USjFHWlFoMEMzS0xEc1lmdzZVNzA1QTRuZTNSeENM?=
 =?utf-8?B?L1JrK2NKcmpsUkxXVlNEbXlza091WEFRa05iS0ljVkdScDNvTnArUVJ5bWky?=
 =?utf-8?B?bjBSelFjS2tmUjd2WHJvUm5HeVNEbEVyUlVBWVVyd0hkdzI5RS9Ed012S3ZG?=
 =?utf-8?B?VDNmM2NJbERaT2lkU1RLSFFtQTJKQzdKTEtUMUgyTEZ4T0Zzb0o1VkxtcUQ1?=
 =?utf-8?B?TFo5NnZxNytJNVdDR1F2S1VFRlpBd0c1c084TDVqVWU1L1krSk1sVHFtcGJ3?=
 =?utf-8?B?c0hWR2J1Wk1rL1FIelJsL0FLTkc2UmsyMkViTVViSU9pcWtHTG0vVVpsV2Vn?=
 =?utf-8?B?TjZZOE5DZUUvd1Q0OWJLS2RTNFRiZGFZck1SRGNMb2hjcjNzUWdJcVVBOHBv?=
 =?utf-8?B?b0x0SzlQZ1dFc3ErQmtIcUpkOUV5d1JvdFMzWWtBbjd0YmczdmVtZUQveXcz?=
 =?utf-8?B?YjdDZDkzWHlrYzYxU2VqaVRZMFYyeGljS3k5UVRrYXg3azB5SGdwYzlOQTBP?=
 =?utf-8?B?Vkp4RytKVkZ2aWo4VzFqRC9jMHNmMmZ0Y216akk4QzVnNXhmWGdGY2plOGJP?=
 =?utf-8?B?OXlMSGZJV3dNM3EvNlFPVzd5TVZhclhITjltS29kTjN5aWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:54:49.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f371f20d-e395-4977-5ba3-08dcfe72f685
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8139

On 06/11/2024 12:14, Mihail Atanassov wrote:
> Hi Liviu,
> 
> On 06/11/2024 12:07, Liviu Dudau wrote:
>> Similar to cac075706f29 ("drm/panthor: Fix race when converting
>> group handle to group object") we need to use the XArray's internal
>> locking when retrieving a pointer from there for heap and vm.
>>
>> Reported-by: Jann Horn <jannh@google.com>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
>> ---
>>   drivers/gpu/drm/panthor/panthor_heap.c | 15 +++++++++++++--
>>   drivers/gpu/drm/panthor/panthor_mmu.c  |  2 ++
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/ 
>> panthor/panthor_heap.c
>> index 3796a9eb22af2..fe0bcb6837f74 100644
>> --- a/drivers/gpu/drm/panthor/panthor_heap.c
>> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
>> @@ -351,6 +351,17 @@ int panthor_heap_create(struct panthor_heap_pool 
>> *pool,
>>       return ret;
>>   }
>> +static struct panthor_heap *panthor_heap_from_id(struct 
>> pathor_heap_pool *pool, u32 id)

s/pathor/panthor/, but you already know that.

>> +{
>> +    struct panthor_heap *heap;
>> +
>> +    xa_lock(&pool->xa);
>> +    heap = xa_load(&pool->xa, id);
>> +    xa_unlock(&pool->va);

s/va/xa

>> +
>> +    return heap;
>> +}
>> +
>>   /**
>>    * panthor_heap_return_chunk() - Return an unused heap chunk
>>    * @pool: The pool this heap belongs to.
>> @@ -375,7 +386,7 @@ int panthor_heap_return_chunk(struct 
>> panthor_heap_pool *pool,
>>           return -EINVAL;
>>       down_read(&pool->lock);
>> -    heap = xa_load(&pool->xa, heap_id);
>> +    heap = panthor_heap_from_id(pool, heap_id);
>>       if (!heap) {
>>           ret = -EINVAL;
>>           goto out_unlock;
>> @@ -438,7 +449,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>>           return -EINVAL;
>>       down_read(&pool->lock);
>> -    heap = xa_load(&pool->xa, heap_id);
>> +    heap = panthor_heap_from_id(pool, heap_id);
>>       if (!heap) {
>>           ret = -EINVAL;
>>           goto out_unlock;
>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/ 
>> panthor/panthor_mmu.c
>> index 8ca85526491e6..8b5cda9d21768 100644
>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool 
>> *pool, u32 handle)
>>   {
>>       struct panthor_vm *vm;
>> +    xa_lock(&pool->xa);
>>       vm = panthor_vm_get(xa_load(&pool->xa, handle));
>> +    xa_unlock(&pool->va);

s/va/xa/

>>       return vm;
>>   }
> 
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

Lesson learned for me -- at least build-test what you review :).

With the typos fixed up so this patch builds, I can't observe the race 
in `panthor_vm_pool_get_vm` any more.

The other comments on this patch notwithstanding,

Tested-by: Mihail Atanassov <mihail.atanassov@arm.com>

> 

-- 
Mihail Atanassov <mihail.atanassov@arm.com>


