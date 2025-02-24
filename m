Return-Path: <linux-kernel+bounces-530049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D36A42E25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33872178BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25077263C99;
	Mon, 24 Feb 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mi67LZqk"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021119.outbound.protection.outlook.com [40.107.192.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4A3B2A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429638; cv=fail; b=gKFKR7VQNvo73uoJYgcYS+r/mPGVZG8uzwOKhTiIkjGC/osvSlSS00mEZT7ca0Ovfup6fpxUeNGzSY6FsFknarD8Q7f3iVdKpwGiPEprZnlV5lyDT3DbXTMgcYmhyUBbWX7wx2lGZX0fmbsdMwQXy0U4E+VBZvDKZeG8EX7C89g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429638; c=relaxed/simple;
	bh=cEjo1zA6eq30pKRAtNdMPl6vVd21ZYV6LGN6DOA7pCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=auWm1O1S24Y1BG72QquVefhsR1Vv23kkTClORlvZx6F5oqrgG51rW5275WGlMJ880KjO4Dgdd2K0V2/nuWFO3ENk7811DiL+wLy7i4DVqvKG8bRGuYOowCyZc7W7x9vq9QVM2oaHXieTIW4r/0vTOHx5EAJYbvwpqnZnLD+t0O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mi67LZqk; arc=fail smtp.client-ip=40.107.192.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN5ICoEZYGUlqtFRlUkCX9rstubLZQehZlMD60GcVdob2/dungX8Q2umLt2JYUWsYXzIDqgHqu/v5SiYCE4JJRE4AoF6k1cXj64uF+xgUDcfreJ1c3nki77XFWsbA6sll3MMsVye0fZhnOhX1zXRwIj1bllq+UDQK3l8TAd6huenAMX1MhCPcjWbWIrVjNKyh5JA22jbpnoJPmrA560MNfgPvTe/fLimKv9YBzcxAn7F8X/v1kwn0EimBjAaEyPvJ9RgSlHG7I17p67HhIHXoYI72NOfUW4Wt05eqUgdtkuQ/pGFpp0Y33u2tQL891CbWg+lO8w5bwXPUxDwDaV5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/eOqgzyXBsyZZkaoB7ZK68eM4oGn3Ts1XCjfV806+Q=;
 b=ScpSy08vofy/FceWnmlMtl2sGdw90gwZRO87Gv89IzmsDy5TkNCEZ9B4DoA3tN0ljhUFmzhc1q3Dmwpk6qZtYPVqu7E3yjauFgPZLG8IlqKC9Rb+DdLEwy0mUVe3pA/8Fub4snoPkvOfDdjkrAOYRJIRDfh3zrc4ea3xuwEEaWmyx7NLbrEVZ8Uk8VQf9JYxCIg6XzAcE1KS6Z0WOkxqsfEcGVJUhPM/ptrjSuiNrxLUTAEHrSuTxyB5NG9o7xSrHF/EjD2iWmZDFZwkOhSNGEpRrg243bDNFVGTTpO7UDEBLHz19QQPGrKbf8ZQZeAqbd8AS2ESLg8ryY1s1S8KcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/eOqgzyXBsyZZkaoB7ZK68eM4oGn3Ts1XCjfV806+Q=;
 b=mi67LZqk1/VebxWmm2QqXYoC9adwCMkToRLmlXisRJ4D4a53cKL+UdrLAePbJAaRmGBov01hvUeoTd7UoQEDa3IkCwLV1/oNr0GwRvYpwISRRAEtcElEbrd1YYnPrHoljDG5defBngxLs9PHBEYMlJBrEunPRfltT3NLL7qE8uNkjBSt6lNbvBXV58kCPP+2Q1A9DE3U2IpC9qDGDu194NHuCpDIz1Qm9NeWkTZ9KIGWZvg0dDPoVMiCyNU1abzlpJq4EAC6pAbemPqDnaYo93f2lq5OYJRtdQ9FFLKWFR2zJBpUPuAk010yeuzTbeTqX/U4HXlfvKAtBwz+ydgFOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB9221.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 20:40:33 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 20:40:32 +0000
Message-ID: <26dba55c-eb09-4e9e-8460-8adbf75e32cd@efficios.com>
Date: Mon, 24 Feb 2025 15:40:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
To: Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250221191401.464648-1-mjeanson@efficios.com>
 <Z7nQzOQT_-9-Rbr5@gmail.com>
 <974359d5-43f3-483a-89cf-79e9b4965785@efficios.com>
 <Z7nbYcdRKXspX8o2@gmail.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: en-CA
In-Reply-To: <Z7nbYcdRKXspX8o2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::15) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: be4ad6f6-4040-4ecf-3bc5-08dd55137bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWFRTGF5SHpWUHo2Q284UnMrZGIvUWNHOXFGVm1KQldrZzNqZkxrMGFYZ3E0?=
 =?utf-8?B?dnpjUnFFamQ4VFRNZXJhdXZLcEk4OXNLZEplVitiWHVaTEpuRDdoa2laRHds?=
 =?utf-8?B?OUMxejBBYldBckhLdmFVVGliQVIrRXIvekk0eTJ5T1EwaVdsdnorWjNLYyth?=
 =?utf-8?B?TUF1RUQ1OHduZHFEUFdlRnZYWVp3V3E5SzI5VE9TdXJPd21MNU9YNGRONVVS?=
 =?utf-8?B?c0NRTVNzL2ZPbVRDaW1QdFYvbitDMTlXUTFicElUUEJuc1g0YkkvVG9xZWpp?=
 =?utf-8?B?VlpHNzNPVWVKekN4b3NUZWlOYTBZTTFwU2lraE1JMDdQTEd1dTVsbXlWelNW?=
 =?utf-8?B?S0toMXJ3VVd5NXNscXhtOEZib3dEZFdLUUFHZ0ZnbFFIQ014K0pmci9hSmlO?=
 =?utf-8?B?c2VrS2VvVkx6MVB6cUVaWG5kVGszd21ZRzJqaHlOWi9EbU9NN3I3WSt2N2NF?=
 =?utf-8?B?MWRpS1hzUXBOcU1kNGdWVWdubm1idnY2WHFETkNtS2praDZWRGhnTnZReGJl?=
 =?utf-8?B?QWYvaUtTeVdBSGExb0pPb2xqUEpGY1JKYWZPZWRWMUs0UThsVkUxbXRFeUpF?=
 =?utf-8?B?RHhsMTl3eFAyZkhGVUh5VHoydTBacmVVak1QamVlNGpkdHlaMTdXSjdwMzd2?=
 =?utf-8?B?VEQzY1YzSkZFa1FNQjJZcUZIQm5ONkhIM0U4T0N0Z25DRnVjakVqSUJXSnRr?=
 =?utf-8?B?VFVHNzk1bFFSZDBGSWJ6YzQvVmhwa3Nob2xyTmFmWndaWHZCcnF4bzVXNHQ5?=
 =?utf-8?B?L05vdm96RS9UdmtYUGVCSUg2c1JVZGc3VEhoUlhxM0ZMV2RJYmlEZXY3Yk1a?=
 =?utf-8?B?MlpCd0JyTDZnaThmSEdxaEtuTytoM2NqQUtUbzNiNUd4b2Fuc1VQVDJlL0dI?=
 =?utf-8?B?N01rSm45RUF0UzNDeHViYVlZZ29YNmhxZE5OeXQ5K2FSVSsyd1ZXUGZZTk1t?=
 =?utf-8?B?RlVFMklMRldpZVc4QzFHN05JQ0dUMkVxYXhOWCtLYWd2cng4OVlxaWIwWXRO?=
 =?utf-8?B?N1hHSlMvQUI2dFJVdGlUWnhpdlFwSDJIbTlOS1Q3ZGdXVEl1R3p2aVFhc3JR?=
 =?utf-8?B?QlhBaDdqSU9ra003VHlCNmtZQXdpTjY3bk5qNHNGQmNJR3VneEhIQlZuTkNv?=
 =?utf-8?B?dlVuRE5tNTB2MTNnMHhQTXRpcE41cWNJNG9TTHVFMGN3NURLWDhrZ2RwNDRa?=
 =?utf-8?B?Zm1kanV5WXpjUUNyc0VrOGV5MVdLREJoWDlqeWh4ekZTY3JSdjcrOEtOakVM?=
 =?utf-8?B?R3FWWEN6NG1uWUcrWS9tcmR6ZldlVzdxbTQxSi9XZytKSXo2MmY5TUxQenJq?=
 =?utf-8?B?dW9FcU9yeWZPMWFqOEhXYk9lN05YdjBKTncvUzF6UXYrWXNRRDlwRXFHUmkv?=
 =?utf-8?B?ZnFVTEhrM3JFWHZPUm9TeTYrNy9LNk1qNUVVUGRmMERQUG1LR1Brdzhhd21p?=
 =?utf-8?B?Q080ZExBSW1NczZ3Uk9tOGtNZVZWUE9RejJRT3pWcjZDZDFjblA1RzNBUkVG?=
 =?utf-8?B?WTNTV01DMER6SUVCWmg4YjRiNUJUdHFxZit2QXJuOWFVWTNXUTZWTFNhVWFL?=
 =?utf-8?B?dFE1aGFyNmtINUsxNVdSZThBUkNSYXdXZnI4TTlpL0ZIZVJaeTEvN0ROckN4?=
 =?utf-8?B?Q2lEd3NUa2ZIYlhjejZ1Y0trazVCWlFQUC9kZjdQT1RUUU05VU41Q3NXbEtp?=
 =?utf-8?B?eHBjK3dUem1BWE4xWENKcEZJK201RXQzRHBMZHZmUS9xZjlueU03Y0tlbEY3?=
 =?utf-8?B?a1hHRHRnckZWVm85bVRoRFk1RmlyYkt0aTljdXhWckhRaXd5NS9BUFZVYTRr?=
 =?utf-8?B?WGxmM0xnVTBxYURRNFhTMm5uNC8rUlJhak1PdDJUdnEvWUp0VjB0ZmcxcSth?=
 =?utf-8?Q?bmGWOy1bdUiMN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WktISmM5MUZJY0Q0YWV4LytpWG1HelBWS3RXaWhkVGZnT3lKRTQ5YVNibVNP?=
 =?utf-8?B?eExmblFlTDlESGZva2pKajdnd2ZwOUpDT0NIUzVDMEZ4bEhLd1RaeWR3NUFL?=
 =?utf-8?B?dVRybGd5dCt3RjMzMEhYWVlCUkhRWEFrdFNOVW5RUENRODdSZHBUWDJJbU9a?=
 =?utf-8?B?N2dtNlgzb0ExdHlEQ0xJc3ZraVFQUzU5ZzR1ZnBvazFyZmlsTGR5WUhacFBG?=
 =?utf-8?B?c0xHOCtFeGtqZi9BdE1Qc1ZXaTFabTNHbWxBSURibFhiaEhpeTF0MUNVYm9i?=
 =?utf-8?B?QzJNY0dRK3RwZ2pubi9LeWNxVDhvMC9hTG5MYllRQlNVUVFPaWpkOHIzN1Ar?=
 =?utf-8?B?R0lraXQzL0ljZDNFOWtZbnNBYnRURlB0c3lHOENjdlZTZ01oOWlkbEl4TXVy?=
 =?utf-8?B?ekRXTUlYM3BqWjRuUUk5T0VmN0QveUcwcGFNZkRjZXlaQ3dESC9kazRkaEc5?=
 =?utf-8?B?cmZocTBML3VONFZTSDJsaDNlU0xkOWJySXJ6Z1dNVk5taGxZWlFSQ0lGVkFX?=
 =?utf-8?B?cVFwaEtsVEprTi9TRlliNVRZTnl0cWZabUtIQ2h4U0xvR3JXS2ZTR3hyTWdO?=
 =?utf-8?B?ZXpTOWpSRmpPcERKdURURS9Wc1pxS3N4QnlhWlVuRUs4NW5YTDRaTnJHV05s?=
 =?utf-8?B?VUhYSU1FdHIvZC9BcldING9mL3FSL3YzUWhxcERMMHhLZzdSb2lHTFZJRjdN?=
 =?utf-8?B?cmg4QXFTV01VL3hOZGJmbGM3M2J0VnJMdlAwSXplbll1TTI0UldrV0RMbkU1?=
 =?utf-8?B?dEQrOCtmSlBSTkxRaFpkY0ZJSnlrbjRlSnNIUFY3L20xQlRpYzJoeHdUT1hl?=
 =?utf-8?B?azV6c0poZCtGcEw4SXRHZWQzVW9IVEhyMFloZ3dLeDQrRDNYN1FYU25HZGdz?=
 =?utf-8?B?NFpkdkFGK0EzVmM4UVJHUEdNaXBES0tKOUFRUjNIaHZaSHdYTnVTd2xhUEZF?=
 =?utf-8?B?MldaaTV4L0JTc3UvcVVsbUtKa296UDFvTjNINCtmc3lVTGlWLzhkRElURDlp?=
 =?utf-8?B?NVBWKzdjSXpCL2w3K01lQklxelVVREhnNlE4dVpybms0WXYwbzMxV3hqbjdN?=
 =?utf-8?B?alkrbDQxb2ZTRVc0aEJhcU5vZ0Rla1phM0JhK1JjV05lT2k2cjB5N004Vm1i?=
 =?utf-8?B?NDFJand6MWJvZmJWUDJLcHlYRHhMSnFGdTcxZE5WMmhSM09UN3BQTGY2NXpp?=
 =?utf-8?B?V0lMdjRiSnlXaXpwVkJ2QmNDM2d4andzZ2dFM1NTNUhRMXJWM21sdEtadWZt?=
 =?utf-8?B?YVdYdnAvWmtJTFBORGxHbXVkcVpyd3AzSEhjRGx4b0V5T2U5YnM0V2FCMUNi?=
 =?utf-8?B?Qkd3VjJvV3hqR0ZvQ1FYMGp4aUhndWVrcW4yNFhycnF6Ui9FeGNUaDZ6bXZi?=
 =?utf-8?B?QUZ3L0Y4UXdrY0wvNW91cWNGZ0t0Z0pFRFpmUjRDTXdzV2VvcDl4eS9oZWRL?=
 =?utf-8?B?YjV4bFE1dDR4VDdZdGFuYy9OcnZHZTExTEFVaVpHR2NEUm9hSzlLMjVCK1d2?=
 =?utf-8?B?cWpEb29TaHVEVldta21kQ1R1MVhaR2ZBRENQNElBUWlrOWZMSUFzbTlOd1Vp?=
 =?utf-8?B?UGZFWVRNYnNoTnJKNEwyelpOMnpSc1Y5YWNWUkhUODdqaHFMK2hQL3EvaFJZ?=
 =?utf-8?B?Vk5Wd1YyWDhDYkpDNzRtaFNaeWhRUkIwczRWL3NCTlpNNTFBLzBtSXpsVzJM?=
 =?utf-8?B?cHNQTFgxaHMyMCs3ZUd1MUVDZUhmaE1TaUIrd1pWcm5qTnFsY1EwM2pZNGlT?=
 =?utf-8?B?cHU0SHFiRmxZSDNNcGtnYUdsdHlGUmRMYkh4dnlxeUdWaWRJRllFTGJEcDBs?=
 =?utf-8?B?eGpvcXB2dm9GT2hCam41aUZiSzk5RmJvNlJFbmlsRThSVkxHaGZUd0l5M3FV?=
 =?utf-8?B?R3N6K01lbWdGTXQ2OGRlVWtleDFPVTFCdUFsOVR3WVRaZzR0c0ZzVlZOT2xJ?=
 =?utf-8?B?VExTdGw0M3dDVTlHclRZTTFOaEI1SytMcXJ2NWZnTDNuamZCY2twb1RkMEhK?=
 =?utf-8?B?Y3VFWFYxSEdUSElJNU92Z3FpRFVhNVFxRnprUVJVaVhrcTRuNEdhWWdOOVAv?=
 =?utf-8?B?WTdlMGJzR2F6TXRXN2JWWWhaTVpFYjdmWHdSZ1FqU3FKcFJJcEZqR05yZUhU?=
 =?utf-8?Q?mHkc7qvs/RrcEBfq/FRiVUnM2?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4ad6f6-4040-4ecf-3bc5-08dd55137bc1
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:40:32.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GB+NgWZ4fa5BKQ3VY6JkaKHMUxA1r4dOfpWBnA/CXV0RmDe4x2J3qzBGVZWHzvU6qTXvdVbkhAk7O3qI8H4D1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9221

On 2025-02-22 09:12, Ingo Molnar wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>> -	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
>>>> -	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
>>>> -	unsafe_put_user(node_id, &rseq->node_id, efault_end);
>>>> -	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
>>>> +
>>>> +	unsafe_rseq_set_field(t, cpu_id_start, cpu_id, efault_end);
>>>> +	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
>>>> +	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
>>>> +	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);
>>>
>>> Could we please name the new wrapper rseq_unsafe_put_user(), to make it
>>> clear it's a wrapper around unsafe_put_user()?
>>
>> If we do this then need to make sure the order of arguments becomes
>> similar to unsafe_put_user for consistency.
> 
> Absolutely.
> 
>> I always find it odd that the "source" argument comes first and
>> the "destination" argument comes second in all put_user() APIs,
>> compared to memcpy, WRITE_ONCE() and all assignments (e.g.
>> operator "=" LHS vs RHS). Choosing a different argument order
>> therefore made sense with a naming different from "*put_user",
>> but not so much if we use a derived naming.
> 
> Yeah, put_user()'s oddity is a random historic idiosyncrasy that we 
> want to preserve in derived naming to reduce the potential for 
> confusion.

Would that be ok?

  rseq_unsafe_put_user(t, value, field, error_label)

> 
> Thanks,
> 
> 	Ingo


