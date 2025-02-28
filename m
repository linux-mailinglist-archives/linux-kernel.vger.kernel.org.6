Return-Path: <linux-kernel+bounces-538747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD1A49CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A897D172480
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE302702DF;
	Fri, 28 Feb 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kpBwjSFK"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020141.outbound.protection.outlook.com [52.101.191.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D06270EA9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754745; cv=fail; b=vEBp++vGC7at6KwnlQi2cK3CjAcQTQ/STUUiuy14BvfdqeCN/rAMCl1YRXtlH8c9gmv7Rzs6Rt72UVtJobbMT1iHL/8IxsJCgZuKGnjByZefPM4mb5/HZJjTkA0l5dpghNwHdG3hdql15NiUEoyDDJXR8k5QIazEewPy3DzVyrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754745; c=relaxed/simple;
	bh=rzgC5yR7CaxcIbrD0XUsCIGY2UDUx8dlL+Mhfsc80t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SR9q3Ss+Uf6RQiZ05NohoUZMj5OUTowMo9tvmi1YtO0yfdgdNLUacLh5UhQYbETqkK7xnvbf2gNJ/26nVg4siy2EfIwkaSq+ZGqAc6JrYgGpmqjGth7IN2NYBfyD99W/BHBn574DhoZjhMxBs/0fR3VZHtopI/mWBZ6cFFancJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kpBwjSFK; arc=fail smtp.client-ip=52.101.191.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKnF3zOkFjCAUGipahjuKBqj8XP+jzPfRJPUAt79Kh/q8Sw14twUoNBFP/s6PbZ7/6zxH7y96sQIdSsPPLesfjD4PugFl3K7NlwlhSzXkog1olbWRw9VVxOG671m7E3NIDPM49sv0Jv76ACDfQJDvSAeVv5gZOayupLeUkQ5/BVSxXTLBJgKTznB5yR3YJ7hQFLdIWZWKt9Z6LiPrLDF2FNOGAMk1j6kQv0CZdC/aR9meeQYdhLCXs5gm+LqhZsGjQslqbYxvBcJi+J1ccwEXg6yRW32oeDeI8/YqpWb+qXvdfuPOnSTxSe+eDrQENh1NbUEx2eMSTU82ezzt6qVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTN+oppHzmJ0/2Rx2chpmxRj1ub8M3a6FNkweDIzfko=;
 b=AYJH1TVM3jAe2d8fcf8blidPW/Uu1DoS4zn0PBjVmYSiqYd52mPT8GboULLGLm8vH/2LStgYOuNk7h0FbZmekJGWmRDM2eYJgVMdusWIuNQRktsgdqQkNgNCP2OQLMPWltomCiV8fdnDYyHtxLIrJQBc9C1HH2hN841FdI7cUSfKOw6UAG1Cj6MDClwBsR1KmOfcIz6URdfqHo4rkXXihg7xg4Qafl5St9n7tBX6/ZGsSoHMriKmpxT+LmLgNnfqIpmeYLCPQbPFpz+V52NFKxy+sgaOu+1YQzPXaRwntFVXIZ+Dmb3f8suKPxaAmi0oEhhDh68MJSS3Mzoq44WqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTN+oppHzmJ0/2Rx2chpmxRj1ub8M3a6FNkweDIzfko=;
 b=kpBwjSFK9fziWwFD7iEBG30OHn/Qh5AQHMijyYDHTUnDpCJ4xfd6UFw3vRzq1X6GSSISOaDoKDyyfiaCUW+6iaCqbweRP7ZPyXAksITiSN/YFudxEGv1LhIrhwBLE7ebuglOYhOhNVbLgeX0aAYQDiOwMHvY1HDOIK1IxOQENN5Ed5NiPrnCn6ytxGvuc6u/8zcSHuueijpwrBqt5IILraSyFvR3YESV1p6vSxFIzFiy2HeaS2s5Zrn2wHADS8T54ZX6BWOcGrgaR/qadl0igm8RvywIO+VlY/oHsHwxl+/wwDdw3whtGsqcHYDwukEJWsZjcqvbYf3dECH1yXWntA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:59:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:59:01 +0000
Message-ID: <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
Date: Fri, 28 Feb 2025 09:59:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::47) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a27049b-e38f-4653-7d40-08dd58086f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDREMTJQV2x1ek5pOGJ2TXdvUGhMM3VvMXh1dHJ0RzFBTHhrYlBFUkJrRUxp?=
 =?utf-8?B?Qld1MDQ5ZjM2Q0VybXEzazJOR2l6eTcrN2NyQjF4WVk3UUYvRG1sdFc5STVR?=
 =?utf-8?B?N1RkQWJuS1BuREs3eXIzaUJKSFhydzU0dUVHK3RIelVpQ09LZFRlQWxQLzZN?=
 =?utf-8?B?MDE4Vks5SzhOTktwZC9sYnd2VTNVNXVVcVJ6YkU2Rm1HTStIbXNHY2IrRmdx?=
 =?utf-8?B?UmxtT1prTVE1eWIwT2Vna0RhR3lXUzd5YjdZY3ZmOVE5TWdqaFdwYkFvSThE?=
 =?utf-8?B?b0VVMmJuNUdvbTQza2tSTkI2V1lRQXNRUFAxWFZWaEt4TW1xVEFzZUVNSFgz?=
 =?utf-8?B?TXJaMDBsOXp6ZDk3WC9IOWs0d2dlL3V1N2k0SmhzZnN4ZWVGTWZzMjlTcmlk?=
 =?utf-8?B?TVBtbFYybTBwSWJ2cVRwTTRUbEl3YXlBb0lmNGpRVjZQVXIxWExWTExNMFlQ?=
 =?utf-8?B?ZTd4ZWZPZWN2U1hzOXFlb2JwbTdSV2dYdEtUWHVKUmRTVWp1NFJtanZLQXRj?=
 =?utf-8?B?SjIxdEFTYVEvZU04bTNSSVF3c1REL2hYMG1iOUpWVWNBOEdhT3d2bWJkMldi?=
 =?utf-8?B?YTNTTjVJL0sxcGtEam9xbm5iOGlDTnNNK3B3dDY3OUh6K0dUZG1kQjloYU01?=
 =?utf-8?B?OUpDVXlSaUVsOWJvc3grRWFKc3YzWDZVUnJZRGRWeW1OaklTVDRsamNVenpv?=
 =?utf-8?B?MENtVk1jK0Q2MkRiSk1NNE9PVmc3RHFlMzl0RkdsSzZnc3p0SndKTkNQWUgy?=
 =?utf-8?B?clVOMEhGVGpqZ3VLWU1xbGkraFFpM0pONWtsNmtOWmFkRG9Fem9keWdPdVFC?=
 =?utf-8?B?cmdWdmlPaVd0WkFCampSVUdIeGhXMk0wdlBsdFdmbzVnVlBCL3hZU0pmN2RN?=
 =?utf-8?B?MDl2TVpWVHMxOGVFZmR2RjBGdHh5dVRnZ09OTUY5TjhsNlF0Rk9McTF4Tmpu?=
 =?utf-8?B?cnVnNUc1ZWNXY0RydG9LYjdBSlliYWVqZThMM2hVNENMODZwOU9zekVUN3RM?=
 =?utf-8?B?d3RYUzFkaU8wb2IvVnlYSnZPS2Q3Rm0vVU5SMVNQeXkzSXVoK1VPNmlXbzhL?=
 =?utf-8?B?Nk1jeEFrV2QxVW5UZmhxN0FGME1IWGhkVWk2Vy9BZUovS3E2VXhuUTlGWHFT?=
 =?utf-8?B?SUFKYjdjckc3Q1hCWHB6bW9KbkE1VkVKd1g0YWN2elV2K25wWnJuL2h5RW1B?=
 =?utf-8?B?RUFxMDBiS1BtVW5LUTkzWHVBdjI3ZmVweXJWb2ZPZStEUjZrV0JhN09uNy94?=
 =?utf-8?B?MDdGY2JPNGVRZzVqVytyUU0rS2V2c0p6U3B0VjFnMzJWOHpTUzY1V2dOTGFF?=
 =?utf-8?B?WEdmWjBzeFY3eFVSUW1NNVJOTVNwSXBNTlcyQzExOC9uMTdEdVEzeDByR1l6?=
 =?utf-8?B?dVloTDlwNTdOenU1SFl5NnBFN0U4NXlNeTZZUHh6QVdETXdiUnRuQ3R4ME9j?=
 =?utf-8?B?ZlIySjFzZm0yNzhKZzR6MHBWRlV5c3QwK0pkYUJHVFBGVWdzOGNYVzlEOHFk?=
 =?utf-8?B?SzJsMjRoNytuOUhtSEI0ZDhRQWxZZnhSNHdMRmdPbTc2bjd4ZmhsV1NXY09Y?=
 =?utf-8?B?aWI0ckJHUjVweldEeCswSUs4RC9xM21iVHhPZ05HUU9yRkNlUDVkemRtejM4?=
 =?utf-8?B?ZXliYnU1aUFkdEVudHVocVlQeStWTU5KTnR5Skt4azRYeG9CbWRFajYyR2FX?=
 =?utf-8?B?dGNnOTJoZ0ZlSzUxbEdEeDNhWndwMmxJVTJlZUhNdUNET2ZQTWpHVHUvWExI?=
 =?utf-8?Q?OuefYNoGiflDGRbRu2SSWtTeJZtlghGV+nAS0vu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0M2WEFGRVhtckV0RmxYNHR2QXVlUUZ4bDFORTB4S1lvTmZ3N1p6eXJ1UWdk?=
 =?utf-8?B?S3BTWERVelNDRmFZTSt3TFdPRzFJZDdJQnRmVkVGbEZIanQwNmZLdzFGQno1?=
 =?utf-8?B?SHd2NW1yTVB1TnFWYWZ3TEJyUDNKUlRZbDdTOFh0VFl2UGE5KzhoYkRlbnhC?=
 =?utf-8?B?bjMrL3pYYjZNOTE3SnRWeXB1d2d5MExMLzBZTDZRWTJUSFBtS3JrZnVSVFZJ?=
 =?utf-8?B?VFlZQURSaUE0bDFrS2JWS21NUTdVQWxUVzlNZFIvUUhUQXBiT2ZSYkliZ1Zq?=
 =?utf-8?B?RFl0WjN2bURubjQrRXJSQ3Urd3BmaVpKQ3Z0d3BNYkg4YTN3ajVldnhyT1BX?=
 =?utf-8?B?RE51a3p2NDZXTTVBL01LVWQ3ZEpvS1pLOWtmdmc2QzkzWGtDYnpaN1RBVXQ4?=
 =?utf-8?B?STJDT1gwRlNWMUNUandXUmFyY09UNHQvOFBhQnpFa2tia2xJOTh5UnZONkZp?=
 =?utf-8?B?eTZMaU83N0ZWSnVLbTVROXE5dWZORE43dGQ1WHdQUmVDL1FBVzFDSmZJbWx0?=
 =?utf-8?B?NDF3Rng4b3phWlBCWW51eUZtT3hqc1RZOUhJcEIraWNEWU1TS0w1MUZaQTBh?=
 =?utf-8?B?SGpUbXN4TGVnTnNnV21jdDNJUGJCZmJLQnVEamNkT0RMdmpLYmpsejN1RTlx?=
 =?utf-8?B?dFZJWDlQUHF5SHI3c0dBcnhKSDlHK0l1UUhjajBaejVyRGZQclJnOXNFVFkv?=
 =?utf-8?B?UGEyUm00WEY1eXNRZTJyektsUkhIMlNUaEp6alhNWWVxY0oxTGJVbGF0ZXRt?=
 =?utf-8?B?VVhqeEhETmlYYVp0VzBCOTEzTmNNajd0WGN2MnZMS2g2aFQwRklNTmgxSGMv?=
 =?utf-8?B?WG91ZWNMQTZPdUtQQktmTHBGM0VhMENseENjd0JROUNxcUlBOVcxYkRNd2JK?=
 =?utf-8?B?L1B1a2JwemoyRGZGT1lZbm8yWHhBOTh2NThjSTMxOUE5dUowM2FENTUrVmtJ?=
 =?utf-8?B?R0h3SDMyNmEvdWZWWkswaWw1VnhZb01xZUQxZWdBWU1waFVtV1RIUExQVzdr?=
 =?utf-8?B?SjRWbGE0K284aUx0SmJiMmdWcndkaXFZT1ozdTdKdS9KMlQxTUQvbU5HMy96?=
 =?utf-8?B?NHQ1Y09Gdysrd0lNMXU1eEdWUlFrSldLcWdRMyswREtQUVVxd2Y2NGsrUEZh?=
 =?utf-8?B?OWRhR0V2bzJQOEh3bFJ1MklNT1poMkdqSXk0OXBUYzdpd3hQR2N3NzAvUXh0?=
 =?utf-8?B?Y0svak5yYkJpVmxPQWpzWkVHaGlyOXllc0VVWURHR1UxRWhhTzRXN1NvdmZa?=
 =?utf-8?B?WTB0dHRCRXVvaEFudmlZeTFoNDRQaWJvUml6UjBXcDlQQkpzM3V1VWFJYkpP?=
 =?utf-8?B?d3dxNTBmM2xyV09iQ1VSb2hrMmNyNytURzRLSzhkNEQ1Vyt4YlA0SHZXYzFp?=
 =?utf-8?B?dWpzTXQvUFRFc3pGS2xVS2FNZktvL2EvVm9PL29RcWRrallPaVg2VERzZW5R?=
 =?utf-8?B?c0tTemZnNCtkUVpMcEoxYTBWOGluL2JtSVpNcUJBS3J5MnoxQlpjS0NIaDZt?=
 =?utf-8?B?MnNMTU12MmFac3d5TCsyM010b3F6Q3lPd3lJemlJRlBBcDVaWW5EVWhqV1pk?=
 =?utf-8?B?V2QzRmRBYkJldUhsUGFLYXY5bnlmQXN3aXE1VEZmc1VrbW9JQzVBMkxXU2lR?=
 =?utf-8?B?ZW9UYURUTWgvT1NHQm5na1RidkhwNldHTmlCN0Z2enJod1psUmY1MnZLYWt1?=
 =?utf-8?B?V0p2Y09VNk5QcHdOTGExK1VIaU1jQ1J6Y3RwQkVXbUQwcnpXVDBlQmgxS0NW?=
 =?utf-8?B?SzVQU1BjMnNpZ2tUekFSckVadm5xMi8rbktvamVQVWZkSktyU1VVZFVvY2dS?=
 =?utf-8?B?QlpHOURHakt0MU9tWkxhK2pPOUJ4T2F5Vk1xREFxeVZxZ2E3L09UbDN3ZGkw?=
 =?utf-8?B?NUZiRHMxYzdLc083d2tWRXg5OHZZNDdieWVGRitVREZQeVlpUExpSm5YM25w?=
 =?utf-8?B?Y1dSTjVvTUNBTmFZd0p2eVl4L090K0dYOVdSWG1OYmRMMjM5K25DejhHQzBN?=
 =?utf-8?B?SXVjekgwTzJLOXpnUFhTbVlhKzRnZUFWMmIybmRuRTVDRmt6eHdXWXgrZ2lI?=
 =?utf-8?B?Zk9Ra1QxN2lYK2g4aWQzRXdOdTFTVFpKSGhNRmR0bHVLSWNNazMzRUhLMm5X?=
 =?utf-8?B?bVNkaXNWYmtYUkVTV05Ecm9hM3FrV0ozbmVWd0oxSEdrOFpCT3VGeHl0eXFD?=
 =?utf-8?B?NkU5V25oUXk2VDlSdTZCbFBSTmxUVWY1SWRxRnVKSzhsdUlqUUUxT3owRnky?=
 =?utf-8?Q?H6wG0ElBdKs/7w3r0E2anpsFTaQVhKsbPw5LxJaAbU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a27049b-e38f-4653-7d40-08dd58086f7d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:59:01.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKphgFEiVtDW/lf0dU93+Bp4wi0WjgWypWr2zsObFHH8IZYB5ESpEoEqMnQe5mxI9QDoVmk66+ufjjH+V9VrCKv0g/7DAVNtCeZ29KJOlpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8665

On 2025-02-28 00:17, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> I'd be fine with SKSM replacing KSM entirely. However, I don't
>> think we should try to re-implement the existing KSM userspace ABIs
>> over SKSM.
> 
> No, absolutely. The only point (for me) for your new synchronous one
> would be if it replaced the kernel thread async scanning, which would
> make the old user space interface basically pointless.
> 
> But I don't actually know who uses KSM right now. My reaction really
> comes from a "it's not nice code in the kernel", not from any actual
> knowledge of the users.
> 
> Maybe it works really well in some cloud VM environment, and we're
> stuck with it forever.
> 

For the VM use-case, I wonder if we could just add a userfaultfd
"COW" event that would notify userspace when a COW happens ?

This would allow userspace to replace ksmd by tracking the age of
those anonymous pages, and issue madvise MADV_MERGE on them to
write-protect+merge them when it is deemed useful.

With both a new userfaultfd COW event and madvise MADV_MERGE,
is there anything else that is fundamentally missing to move
all the scanning complexity of KSM to userspace for the VM
deduplication use-case ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

