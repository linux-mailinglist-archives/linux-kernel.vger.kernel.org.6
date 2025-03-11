Return-Path: <linux-kernel+bounces-555778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE372A5BCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB63A566D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48B225784;
	Tue, 11 Mar 2025 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="XQs9Fd6Z"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020118.outbound.protection.outlook.com [52.101.128.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73E1E2602;
	Tue, 11 Mar 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686519; cv=fail; b=nMmSOFpyoEW58EhqSecz589OurkyeJGplndxgdbuvNctZxYFOa4I11jxNiUShL2jkAz+ksjCO9O73KVtWcK3wN7xaDTlv+Yp3bBZanb17nQCqQlF7QJ9cc9Qj96BeItnjs+m/vXn1GogcGYsZkQ8CPMC7NcyWQDUl3pf/gLO4zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686519; c=relaxed/simple;
	bh=EmIQur6TUJyUZ7DLZRIcmGjae7YkjS58WKfR+bpB7WI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQVos7MteqVzjIE/i4rqniZ076V5IiqgtQqYm1Q47MVzLm56uey5GoaFgKhdcQJ9fZIo2ccA9YBYgRqNpBXVvh/Lrp6mrnR3ZHzNugXGoB3XHumSzd3QwHW0gAf36Kb77Hxz2WNGE7u0GF5Ft2vdavN8RFmHrC05kbvqGwn5W84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=XQs9Fd6Z; arc=fail smtp.client-ip=52.101.128.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKv3k+US7zEOt2qnlYzgncpUcfcgNEEiAuUOgEVQMkNy8em7y6mLoleaTos9FR3sZGEvtj6PPKSeZwf3WOF3qtCwYdV8J7rQHPhphMe0p+IkXUf02ZZJ0B2W1TCheARw2qc1abEGrULOogeOpTExg18+SzkDp/GOcY6UbozvPh/lKkMXimPVcV8xCUThU9Gx//MRgsBt1iC5uPw8D40VLrWVzaDMmLFnnhOYZQEZCudz23ede+tZq4VnO5FvJj58mh0nlMl6GYwuM7zxckDiwLS1vtJPZl5oBy7WcmEIlGFPk2VPYXuGo38KEsVh6/w/i3OD4VcUTeZAeD45jduFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW2ARwxwhq3Cj1oiqXBG/KkB1sfBqira39/H+TNHTnQ=;
 b=g0NL3lJBahthOYonVTRF+rkYzKZIzLrnzy5fnuHdKXklr4pbxD4oIEmdJaYppWo62WUF0SkDY+I/+FXbvABgMgofbHtQu8bqPLUmkSGESCLOEbxm74ZONBHMKFDABFrUrEiMAHZBLf/YFditX79LOS+zvByg3ROUIpC0GkhQ/WwJ8b5Xn8KzwF/RzpCWttqBKIS8sv5xjUVcmvkHFNmMdDV2f1lsoqj6c2eWjzNIuyRgERui+BZ17o25dAimsLR52MTKyVQXjuddLuTeGOFyOe7j0KCFxWi5gTPBHJnMu26M71ceOXpoyyj/0jabOI/1+Lr1pD3ptr7UjqzPNKvBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW2ARwxwhq3Cj1oiqXBG/KkB1sfBqira39/H+TNHTnQ=;
 b=XQs9Fd6ZmBeaztzuiG2UuuPn5J5AAmahxhI80satXPSY5Z7TTF/lae7pADmVGBpNL8P1eUmBLwtXM7mbWTIJdeQ3yRyys3jooJjY9B2P5za77GPzN3YcPCeN2pMD1z3W1fxOYx2g7A4DIx7ARcR+UxeiI73gbsP4Jacneza7l+KtzEf1axDbOpwys1LTCLt5VNme1nxJhvzJ4qe64nbzMEuVRE9q5ds7P0m3dfkNtuAPHxkq14Cx03Vv0TTDev0CHgSKloT/RL7wKQzoT4K27Y4VswRumaMBJ7dgV/WZMFwIwiJvQU0QnR6/uzESvGwXtj1wnJvGxYkP7o80DX+i3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by KU2PPFDF60C4E4A.apcprd03.prod.outlook.com (2603:1096:d18::42d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:48:30 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:48:30 +0000
Message-ID: <84612c6b-621d-47cc-8a2e-41d1fa42f0fe@amlogic.com>
Date: Tue, 11 Mar 2025 17:48:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: zelong dong <zelong.dong@amlogic.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Rob Herring
	<robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
 <20240918074211.8067-2-zelong.dong@amlogic.com>
 <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>
 <20240918-delirious-skiing-224172be96d4@squawk>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20240918-delirious-skiing-224172be96d4@squawk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|KU2PPFDF60C4E4A:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c43682-bf34-4690-a548-08dd6081e11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1EzRVFiL1JONlNJRkMyeGhMOS9ONGl4QSszRzVNN3NNaDRwRXVidU5WSlJR?=
 =?utf-8?B?bTUwMVd2QWpnaHpoeEs1TnN1Yzc1ZERMVEE4dzBQNmNsRTVYaWdHdUMvRjBz?=
 =?utf-8?B?NS8zdEtXQlZQemc1SHdTR2c0QVpqck9Pdk4xeHlXaGk3MER2dkt3K0c3REkw?=
 =?utf-8?B?WEZ2emJZMFQ0a2dlMW5TNTNabHdiNEQvK29aTkcyZFBOc2ZlVzc2dTdhSGo0?=
 =?utf-8?B?TC9RaFdmdnc3ODZMa2xQVURxMGsxUjFmbndiOWs0cVZZbEZkN0ROelA0bk9h?=
 =?utf-8?B?UEZCWllJZDgvUTRrRDlOZmRick1LN0lPcGtzcTdwWUs3S1NuTjJ2UXp2Ty8v?=
 =?utf-8?B?NXl3Z2RNV1VRSVI4bkdpRDBhekhtVWoxaEVyRjJWZ1NGWm5NSUdlU2dZYnU5?=
 =?utf-8?B?cmJtRHN2Rmx3K1FKcHdyU01FWVJ5VnFjcTUzZ2dURDZvY1NFSEZZWHVFYm5u?=
 =?utf-8?B?RzZzZnU4bVYxUGNEVzJreXE2VE5ZV2NUcVVMN2U0VVRlV09mVGw4ZTF0VGZ2?=
 =?utf-8?B?Z1h5VnRDR0tuYnFqMFcwZlMrUE8yeTd4aytxelUwU21mR2hpb1IrcVFnRWZh?=
 =?utf-8?B?Wm9mWXhyYmIyYkJ3QXcrdXJweXRLZ3NYUWovbnE2bFNnclVHaXdDK2VoTERR?=
 =?utf-8?B?K081d3oxemhSNUdFU3IrazlQOTBSTDJJNjVlYWxUVHJEVDY3Umx4UTd4UFVn?=
 =?utf-8?B?RzJab3ZTanprTE1sSmVEa0RyUHNuMzNvcjB4ODFrWjNsUVdSRXpYMnJNR0s3?=
 =?utf-8?B?UzZWaFRpUFdwSlZ3c0FYcmhBeFZPcjNNcUdTTVU0QW8vMW1vMXVMdVMwQkx2?=
 =?utf-8?B?T1lIaWNsMGswRUF5V2tXdzZlSUdGcHRkTkZyR1hDVFd0cHZScnMzNStpU3BB?=
 =?utf-8?B?Rk5XNG1TVzRTSFJ6ZkY1QnQ2WTdnVXdzZFhteFgrR3hkOSszL3QvV25QN2ZO?=
 =?utf-8?B?OTgzRWtONnBZMmVSYzVGMVFKcFJHaks2MTh6bW5vQytmaDRXa3pjendDd3JH?=
 =?utf-8?B?QXZYY3V1WDJBOWJuRGg1OWdXbEV4bzcxR2hPMWJCRWdURWhEM056Sm83Skgy?=
 =?utf-8?B?MWV5Y3o4bEZFWWRvSXhRYXJMK1RYMkpiZkJZZzJGUzNLWHBadWJMUHpFSlZC?=
 =?utf-8?B?L0h4RlV0VFBxQXR6SG9TT3lRemZDNGNFR29wY3huTER2cVAzSFdscmtsTnpp?=
 =?utf-8?B?Z25jUGQwWVNYdVhNRnZ6cm9mM2QwS0J2RWZQMDNvcmhaa0MvMjYxOFVxa2Vt?=
 =?utf-8?B?L1ZJc2lCVjZWTGFPMGhLUFgyU0RRd05MWlFYYW1BTFBiZDI1bUJOL284dW9U?=
 =?utf-8?B?UDBkTHMyWHlQUnQ4RkxEdStDdnkxMnUyWjljNWRKUVo5UEJZZlRIK1dpaXZ1?=
 =?utf-8?B?TGc3QngxT0JNYnVvZUVoblpSejVucGR2ZnIxV1Jkc3FEZ1RQdVNjaXh4SGRz?=
 =?utf-8?B?QndHck1Sc2k4NnBKU201eG1JNFB6Ti9BVUJVSkJJekZVWS9WVVRwWDZjenJM?=
 =?utf-8?B?VUswSDlXK2ZsNGV5OEZ6TEdQSkoyV3RiSmowMXkwUkx1SWMxSVJjVVhzQUFX?=
 =?utf-8?B?ZjNIY3dBRkhDMnMvMmpOZ25XbDRVaVdueGdyYWI2MWMwcDFWOFBtaGJzOXNK?=
 =?utf-8?B?QXlKN29oZkJsZk16eDk2ekt0R2FRRGRqMW5FY1N3QkRrU2YrdHZNSG0zcFYv?=
 =?utf-8?B?RC9XL1lwSWRlcHVaaTA3UmE2c1NXK2p1SjNHWFBuUEM5T2g2WUdaSHpPZVB0?=
 =?utf-8?B?cHlMcDB6TXNQSGtlckMyUlV6OU15c000clF2dGl0Qm5ua0o1dlJKdGxlTlJX?=
 =?utf-8?B?MUpQS08wRkNacGNNYW81aGJTTFkvcDY3RmRIeEo2OVpSb0tYQXBKYndTRUFZ?=
 =?utf-8?Q?vZ/2OUhswadpa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NrYkxMakNObmFRREF0T0hxOHFjdW1PcXhwQ01RZlQvYVNwWXdoN0hlSkYr?=
 =?utf-8?B?OUNRaUZXRldOWGN1aStZM2tBcnpsc0RnYXJaQ1Nka1F5ZktBS2VsRGV6VzRX?=
 =?utf-8?B?S2hwNG0xZDFWa3FXNE9xcElZYjkvckhyZkZZWkZBTnRmTjFOWCtwRmFXc2I3?=
 =?utf-8?B?cTl3U3pUUm90c25JTUtBY2VUT3lha0ptSTN2eFZKV0ZMbEptMVVzZ2JPS28z?=
 =?utf-8?B?L2NwNTlHZ1ZZUG9aUkN4SVRJRTVUakNza0g0TzV4K3ZKaUJ6TWFybktnbGpp?=
 =?utf-8?B?Tzg1WlNrUVNCWHlWa1JCRDJSSkVYdDdRTTkxcEdhWVRkZkpaYnNWS0NnQzlO?=
 =?utf-8?B?YU1oa01lMVZKaHQ1YUhVUlp2REM0cG5aU0piOFF6eEdIajhZbS96K2M1ZGpo?=
 =?utf-8?B?Y3gremY3R0s4RkdXSEtUSmVnaHF4Y3JMbnpYV0NZSi9HMVpveHMzcnhBYVJU?=
 =?utf-8?B?N0h0V2xQSGRlait5UFZSRU1wMlkzWnpKOFR1R1dSSzROdGh6d3VMUlFlS0NL?=
 =?utf-8?B?S21yOEQ0eVVNNnY5QklWSjBuZTk1ZkZhNG02VmFlN0JMLzlDM1ByVDVpS2cy?=
 =?utf-8?B?Z1MwcEM2MVZDK21CdnBTMVp3Rk1TeEFOZ1lwSk5DSUhnU1QyRlkyOHVpak40?=
 =?utf-8?B?dlptSWkzcWV5b2RkdjZyQXQ3U3YyUytrekFJMG5Kc0xmSnAvdUI2aXYwbGQv?=
 =?utf-8?B?T1gxUlEwSDdxamRhQkYyUjNaOGxwQjNhR05vSXprY3MyRzF5MUMyZ01weWJu?=
 =?utf-8?B?UGhySmRzaS9aU1BYSyt2TWVtZVNzUHBQNDYrMnhKd3FiWDl0cEhQWTlsa1R2?=
 =?utf-8?B?aFJQRmNMWFJPWFZpZmNsaytMKzR6L1laVVpLbnFrb1Z1N0EweTIwMTQwamdN?=
 =?utf-8?B?SkxmcmYvZm1MMjZzUlpFMGpSOWRROE9NRUo5WUtaUTQ5Qm16VTQxSlBIYnhT?=
 =?utf-8?B?dXF2bi8yMyttWnl4SFcrbzd1SUhQaGNSUjlheE1BUDgyK1NWY0JxNFpQQnZO?=
 =?utf-8?B?RXVLS1NTbW1rMlBXZUhiR1EyS3JRYVRNSjNIZjR3QUQ2TmFkVWp1N0VhTm83?=
 =?utf-8?B?UFhQRUcrUCszQk8rTkNqUnhtU2pvRE1LVExkUW9wUzllT1NqT2ZDQVFYTE5P?=
 =?utf-8?B?Z2J3Z203K0pzLytyUU9McGg2SWg2ODRWRW8yWXFkSEZRMm9SQ3RIS0ZKcVhW?=
 =?utf-8?B?QllCZ2R2RS95SmR4MkhNcWZjWDd3dVVYb2l2djlsemJScFRyZHFGMmpWcUNa?=
 =?utf-8?B?K2Q2NHhZdElaSXV6ZzdXRUdPV294T3pTTkd1b2E0REVGb1ljeXFQNXNtNmdQ?=
 =?utf-8?B?b1NjNkdJL0lXNkpBUmVjYkREbW0raDhVaGdQa0JhQU5adUQvT1V6SlA3Uk1k?=
 =?utf-8?B?V28wVi9MZWZmcHAybHdvOU1HV0xyRXZySXNuZ2srNG82anhFb1VJbE1LelJU?=
 =?utf-8?B?eS9qK2xYMGd4OGZBcHhvMTF2Mm1nbG9jb3dXbEJqUXpheHZsV2pUSDNZTmxC?=
 =?utf-8?B?cm8wcEVoYlZJQnpTeEZ1aGQ3b1VlR0FUVUlwb1lrMFBsVC9Odi9ObTkxdTMv?=
 =?utf-8?B?RGVXUmd4bXh5S2VjVjh3aVBHeVphbmhsMHlpN25UMW9QYVNRcHJjN3FZbjZ2?=
 =?utf-8?B?RmM5d2JCTUNSRC9iMU5wSVdaM1ZqbnJKaXl3MnF1RnNKVEs1eDBTOUU2UUZi?=
 =?utf-8?B?Umk0Rld3QmFJeHlab0x1RGtOd1RSNW1UYzJXU1lWOFNRQlZ5UzhKdzU1KzB5?=
 =?utf-8?B?TUdpL3pIcWdlQWN5bCtHLzJjbkxQZlZVWDVqMERWSnp6MUpZUHZ2alZBYlB2?=
 =?utf-8?B?MjIrWjVVUGovbUhqVlIybWdKRmJvdjEzUDhWNmY5c0JYYzEyTlR5eU5Rdm5Y?=
 =?utf-8?B?VStWSEsydGV3V2tYQ1hrRW1IbEVYUVFjUTBpVXJJekZUZGlqMndLRVFrYUZL?=
 =?utf-8?B?RW8xVGpYU3V1M01FeGc3MW1vbzBXTFUvMzQrLzlxbjU3dnJSem1zNTVWYm9Q?=
 =?utf-8?B?eFFyd0FzZnlPNi9iTzhUNHQxOWpnRnNGdHloNklKQXltN2JFa0krNFB2Q3R3?=
 =?utf-8?B?blJ6RncweHZoTEd2aEpoTmdUdU16L1RlSHdKSFl1SlMvTlpJaGNQTkRSOEt3?=
 =?utf-8?B?VzIrenRudDc3ZGQ3OHhMUElmY1VpUDh3R0hyRWhIanBKYWFTY2RGVEdWN0tR?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c43682-bf34-4690-a548-08dd6081e11f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:48:30.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVNKgTu16axxiqE2j+muIWRJvl38twDeBFZ9txH/t4xhMq5XnO9V7Vm/2NSUH7RlBJRoVWel1h27bqdeZdHbygbe53nxEMmwpUwRTs6LIOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDF60C4E4A



On 2024/9/18 16:01, Conor Dooley wrote:
> On Wed, Sep 18, 2024 at 09:51:28AM +0200, Philipp Zabel wrote:
>> On Mi, 2024-09-18 at 15:42 +0800, zelong dong wrote:
>>> From: Zelong Dong<zelong.dong@amlogic.com>
>>>
>>> Add new compatible for Amlogic A4/A5 Reset Controller
>>>
>>> Signed-off-by: Zelong Dong<zelong.dong@amlogic.com>
>>> Acked-by: Conor Dooley<conor.dooley@microchip.com>
>>> ---
>>>   .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++-------
>>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> index 695ef38a7bb3..0ad81fe7b629 100644
>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>> @@ -12,14 +12,21 @@ maintainers:
>>>   
>>>   properties:
>>>     compatible:
>>> -    enum:
>>> -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
>>> -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
>>> -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>>> -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>> -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>> -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>> -      - amlogic,t7-reset
>>> +    oneOf:
>>> +      - items:
>> I'm not well versed in preferred dt-bindings style, but this items
>> looks superfluous to me. It only contains a single enum.
> Oh, ye. Good spot.

Hello Philipp, Conor,
Sorry for the late reply.

Do you mean to use 'amlogic,meson-s4-reset' for A4 and A5 directly, 
without the fallback?

-- 
Best regards,

Kelvin Zhang


