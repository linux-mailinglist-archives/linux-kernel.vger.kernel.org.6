Return-Path: <linux-kernel+bounces-436097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A639E811C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA77E165919
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A957146000;
	Sat,  7 Dec 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lqzn8ZBJ"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020134.outbound.protection.outlook.com [52.101.191.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495722C6CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590918; cv=fail; b=IK5NiZlySxjwx2cRojloPZUaSjVGu+GCavt+6aqZeLaT4LoRUKqUyiOLnlsYyIbJDKIfziUvgh88MLxpIhPwHQEQNAGulyvv5jfGKvpSHbNheinKraq6tYh3cH0iTI6cCfLdquSpx6YfG4VZ4MleLV3kQFogp7HsLUMNsFU7gjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590918; c=relaxed/simple;
	bh=GmIZSt8mjFSq3I1CF+gF8I1wQNzyHn68Wc42TIR1N4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlY/Seas9zc7JYkkoD70O3py32vLpi6Kwe828L00rluaZxIDXobc1kMy7rTwrKdybq6iLMTLkumUCdIilUpXhWQbGga9pgLHaRQu7Tt71eNWMrFaiD+1SmXilB2RbKLg3+tYQJMOsdqiHkWpLncaLyp356QJjWnQUQk4ePHu3LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lqzn8ZBJ; arc=fail smtp.client-ip=52.101.191.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKSioBecGlthAdyw2f3C36LmE61/C0S9w3gY7Mz/HkNR/vd3WJhhNFeB1f+X1oX8G+QH6LwMlKoUPyuGzJ20PBAtdkJ3dtsRWs6/fPQTRW+6LJ0U2Q5tRunBQBImsWNVb+t2dpuVGesrv0gd7FgwOrdj0hBqA3/gVTG8edwGm8VINem2mnaXzlNSZtSizeZZKVV/GecLPY8YtUVIZxemOheDu/zW4v8k1aY8N044iu8ET7MZ4k9wrVaNpFCor+JqZakGahGVmCFXbgY4h2MQFGZwyD/+FF6BpIO424h/B9XGGVtLu8aqzMNSWbBRBeOUVWc0N0Os/VqHc3TnFKbjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N395xd/vHQKl3jYNGQ/D2En/0GGwiQc2FnRrL6ZIuM=;
 b=hE6WWnUrQUipHV0fLjMGy9Ep4So7hlQllTv3CsplyAX3Xq6qE14LlcSrHSRQfb94H4P4SrWgxnOya/e4QjpU0ctSka0+8Ja9q/l4hxGQ+JGhKvQNCUeAAWvULgK9HqPuzKxAeMLReT6uFRfCDGSNIdezlat+jzorxl5WxUxl/YczOImr1ZEV1o3wpu4TiryjV3iMYlzhPxtZbnUZ75l3u8piDwcGbmcLryU9DSvoOy4Fu4GWDGRXEcI4QabxJqcaLHtW/X7yO2jvdoy+KqZjO1uzsc7vFNk68g728NBrD+py1pU9el+Zl4HdXVsY0BS5WQQkYaQvMbCx+GdxOWrdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N395xd/vHQKl3jYNGQ/D2En/0GGwiQc2FnRrL6ZIuM=;
 b=lqzn8ZBJtv+D56ngUoAb+CIxIc2A/IJ6+W80f9u8GASVvTVgJuJXYrZUEbBFWSkdQw/QnuA3Gkba9Y/JIDJrJTlsnFkMDuxwQQAjri7iRLaNLGIckZDs5qYYqAlvsCMSOSwbalrM9te7+1ojkz9usI8DHsrtSMKgeerCK8e5SK9pyxd+QG6I5wM4ZJzxQiANDlIa04RspUq+7iYkyRkFILnY8EGv3ZzykfQ1IjJeXb9IitZQ+0JcPsD+PDGJBrKY4M7J62EthXrCCnaJKuFm4FSmqInKlEX2XuNlR+J1Awvjnxhcm3U8+W6hD4GyBhR1Z5ICbr64OJx+vBJ9n4g1eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF260681B1A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::625) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sat, 7 Dec
 2024 17:01:53 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 17:01:53 +0000
Message-ID: <a3fd2a24-16ff-4fa5-9510-148f66c19ca9@efficios.com>
Date: Sat, 7 Dec 2024 12:01:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Introduce cpu_icache_is_aliasing() across all
 architectures
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org
References: <20241207165504.2852058-1-ziy@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241207165504.2852058-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF260681B1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dd9358-739b-4d54-c1c8-08dd16e0d989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0tCRmMvTFJwQ1pmUXo1WXpPeURZVkY0a1dpZGNxUzVIU2hEODRHcXZ2TkNZ?=
 =?utf-8?B?V1E1TWN6YldoVUx3dVU3K0pBNEE5b0tyS3RId05oUkVOcmxLbjl1TlQ0dG05?=
 =?utf-8?B?dEVRYWpiN3RmZ0lZeXZOVGhLazZta1E1MVBFVVluNXFIMWpmZlRlcnRZWHRn?=
 =?utf-8?B?RUMzQ0ZDRytMU1BGUWdDVG8rci85U3VvUG5KdGxLZWVCc2dnR05kVURNa2px?=
 =?utf-8?B?RmI5dmY4cERYV3BGcnpzNTlTbE9DZitjZVpHaHFLeW83SlRROWZrZWpFZ04w?=
 =?utf-8?B?YnNrVEM3MEQrQzQwVVFxWk43NFEzajY4d21TU3NXK3h5Qkk5TkxGNUNXS0Ur?=
 =?utf-8?B?U3BXa3QzenlrRzF2ejJPbFQxQ3Vod0swcUxnSDlNU1p6cHU2cEw5bDl2S1Rx?=
 =?utf-8?B?UTgrN0JxRUIxdkhtTVMweU1PdXp6S01rVFZOVlRlTkQ1ZzM4TGVGRG14YWk2?=
 =?utf-8?B?VWRtYmF2TVY3SjA1eFg2QmtLZS9wc2JpSHlaR1Rxd25Cc3FLc3d4SmEySmZM?=
 =?utf-8?B?Z3FqdEFQbkc1RVk1ckUrdVM1TjJ2VjE5VU5PNUhZNmp5QnZkcldBTmhMTm5i?=
 =?utf-8?B?RjM2VGpTUWIrOEp5bDFmVGhFTi9MbisreldPRGJMQzQvK1ZNWU5SUjRWSFF4?=
 =?utf-8?B?amRTc3VhUEM4dml4YXdOQ2MwNCsvRDVnblYzUUN5cVB6YWpJVHZKa2ExVDAx?=
 =?utf-8?B?MUlkZGZ2N3VzdUo0cFdYMHB5MG5VZHdwdDVtaFZNMHVnTGFmdVpJdGhzdTRF?=
 =?utf-8?B?Q0Q3L3lmNHE4eWNsaXhOZHpiOFgrREJuUzd2c3picDd3eGlsbzVuR1FtSDY3?=
 =?utf-8?B?T20xbWMwRU1iOXdZdzBRc1lFNXQ4bHlNbnh1MkRFWGdCREd6SWluT1RyeFor?=
 =?utf-8?B?MnZvT3BqYTh0ejlTblE2S0dRR2MyUnZIaEZ5MFJ6bXVyT3FVNC9rSDVKbkxj?=
 =?utf-8?B?N0VhaGMvcnYvSFdHUEtRRTZMdWVUNmpLb3hUOENzd0o3U2liMHVKQVhjenBu?=
 =?utf-8?B?OFA4b2h1NGh1VWNXVFJXZWs1eFR6NDk4SWMzTWw2aThZK2MwT1M3RWVwZnJJ?=
 =?utf-8?B?bjkrNXJ1Z0VPTWhub1F2RU92MkFsQmk0QzFMbWVTakRXL1F0Yks3QUlHajkw?=
 =?utf-8?B?Z0licE5IR0s3VThYZTdCRUMwalVjWmNFT2N2UnFQZldaOFIyUk13TXg2WnFP?=
 =?utf-8?B?RDMrWUt5OVJRTmcrdzI1MTZ0amhrWGN4elRGTUUzMDQvTUxOL1ZhYWpHY1Zr?=
 =?utf-8?B?ZjBhVEY4cjhKNlNVeENFQkt3RWN3ZlJMcHZaa0M3eUZwdVJTQ3JDcEtMV0lP?=
 =?utf-8?B?MzRlODM4T3pRMThoSGNyZmU1Y2MzbHdvbUhqNjdVYytjMWNpSlVBbkRVTmxW?=
 =?utf-8?B?a0dGMFRadHA5b2NhaTlwRER0WHVoVnlJSkJtNTR6NGJsODFCQ1F6NXJ5VDRD?=
 =?utf-8?B?eitLeHV1TlRtZWpQbWxrcXFGZWw3UklJK3IxSDAzdUVJWU5WbVA3NTNtWGVh?=
 =?utf-8?B?RVkwTTF1aGN1OERWZHc2YnhyeE9rWjVzK0tMU2ZaYU5WcGQ2WTZ5M2xCd2dk?=
 =?utf-8?B?d3ozZmk3SVo1S3N2U1RiS3ZMT0JnaDRhREhkdGZCUjB4R2lGa1YyMWU1NldR?=
 =?utf-8?B?QUlKa21nbzJTQjZwUWRiOTV1M2IzNE93M05ZOEJwOWtuNGZWMEh5V3F1NGFy?=
 =?utf-8?B?dGRkVi9UT3VUUlZnbUJFUjR1ZXhqcjM2OEhGYUZqOXh6Z01KYmtiME80eUJI?=
 =?utf-8?Q?S9cyq35XpxgkfekSZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXVRR1Vrb2hNUXdjeEV3WWFjSnc2SjQzTndwNjlsVVUxcjhmZ2ZrRkN6TnJu?=
 =?utf-8?B?L3MrWUVORVd6V1k5SVpmZ0oxdXlyTTQ1T2h2a0RtZlpGRUM1MG45VTB0UWdU?=
 =?utf-8?B?MlJZdTBldXlFb1hOcFFpazE3S2g2QUZtRm90M25pUjd4UkVOSEh5Q09sUmww?=
 =?utf-8?B?SWtrL3RBRXo2TXJlSExVTEdwcmlpYUFvS1VPdnJxQlNRNExDSEV0Y3JoV29l?=
 =?utf-8?B?R0NncjA3RHpmRjczU05xMlUxQXRZWFgwSkVZeFJHNm9WL0RRM2swYjNYdkVX?=
 =?utf-8?B?anhLT2JlampaL0YvbjJ0ZnFxQ08weFJ6WHFzS0N0Mi9acDRFOVlmUVlnUmcw?=
 =?utf-8?B?SXZtdllIVFZJQ2dwbkZ5RzB1RFE3QWp2d2FLbXRVWkJ4ckg4c2tuYjNlZDdR?=
 =?utf-8?B?a0RSVCtqcElYTjB0VGNYWFpFNW5ySUlWYWZsSS9EMzRSbGpVZHhTdHVzMlJk?=
 =?utf-8?B?eXRGbnFRZXd0OEhFcndoK2h5NStZZGJOQm1DMlQ2THdaalNCajFDZmpsWmsy?=
 =?utf-8?B?bUhONmdEY3FuUkFRVWlCazBKY2VQYXhSQkVzZkErdzdIRmo3N1hNeHMwMWdO?=
 =?utf-8?B?V1p0R1RIZCtmZGRGeDN5alB3UGFrSmgxYjRpdnlQY1dNU2V0NUpaSG1NUk9X?=
 =?utf-8?B?cGRoTVZLQU41cFZGOHBtKzRDRFBZaHRnblFYYURFQzYvd0NobDVYeW9rTFBH?=
 =?utf-8?B?djYvMzlvUVlROW1TWEk0NzI2dUxZZlhsZnk5MzVPRnRJM01Ea2l0ZUJOZDFn?=
 =?utf-8?B?M2FXMHJjQVJDUDBzRXhoSjZ0WUVWTE9MOUQ3ajRVbHRRdTFXdjljZlZJMlhj?=
 =?utf-8?B?dlRiVTRhQnVHT3Q2NkU0VW5rZ1ZtQXY5dm5vUCsrUzhDaklhL1ZSaysycGtB?=
 =?utf-8?B?OW5NZG5ZNkxZcmtxRWhVUHZaeE4xeVRqVmJyZGJmM0lFTkFQbXVuWG51M1JX?=
 =?utf-8?B?bzRmcTUxQUNxcVlaVHZBZzlwTU9ETmkyR2krT2RXa2FOOGdjWjBveEJHU3B4?=
 =?utf-8?B?RHBiSURZSysrUGVHL3hjNFBRNVhzd3NVMmZMeHp6dkY1c2J0THhzTHVxVXV5?=
 =?utf-8?B?akJZdFlYbDRNeTVNZFNla2QwTEw2emZObi9mTGZ3MHFkK1lucno2Q05RQjgw?=
 =?utf-8?B?Z3RsR3RjZ2hEYmNEbEhZVkhlRms3UmtMMUdNUVZNTWhQanRPdGZYbjZHS0tm?=
 =?utf-8?B?MXFtRTRLcVoxVnBSRWYyVVAxejdmS29mMnFmWTlUYnJyb3M4ZkM3SEFQai9P?=
 =?utf-8?B?bjAwN2pyM1oySzdMWmxHb2V5Y1FlK05XNTVjTmVIU3c3ZHZ0RzJvMVV0QTBy?=
 =?utf-8?B?ZWdJRmU1UERrMFl4Szg1K0hzamVoem9CTVZIM0dHM0h0MnFhVWZTSjZCOWR2?=
 =?utf-8?B?N2NYbE1adFZwUktHUnIyZW0rR1k1VkVpRU5UWU1wMU56R3JHalI2SysxSXFH?=
 =?utf-8?B?SHEvUEI3Tm9Nd1h3QzUwQnZXcVlHUE8wdEhMWGRPemJWeWJ3RnFCUUZBaTQw?=
 =?utf-8?B?VmZmWWdLcWszV3pvMmNHNk1YK3RsOUtuZkpEUlhyeTVxNEluL2hLSlRPWUhy?=
 =?utf-8?B?dVVtTFBldnR1aktQbU4xWWs4dlJLSHFBeDVoTHk3c21CS2l2WGdpbU9qNHo2?=
 =?utf-8?B?d0tqQUpFdjBia1R4TTJqTGRqZ0NRcHJLSi9SMUMzOFV4R2tTWUdOZzFQV042?=
 =?utf-8?B?L3JRM3ZIcVVvOGNkSmFJWUtKZnhtdUI4RlJGV1RmZGgrNjZsV2c1bkhMUUdr?=
 =?utf-8?B?OVVlaVdRL3BZRm96Z2xkY0Erazh0WHk4QzNhaEI0NERvc3ZkYkhwY3RnM3gx?=
 =?utf-8?B?MWZycWV4eXRuamdaenZNc2k3b1lTeEF2cWYzZlQ4cEl4UFRNK0dRYThyZzZa?=
 =?utf-8?B?QU55UjFyRHVDaDIyVlZUWGFpTHBsLzFwSHZyMDkwam5JWEZPYlhWZDArY1NB?=
 =?utf-8?B?bVRrN2hudmdncWlGazcvY0Z0cmhXQUxBNjgxN3dqYXVMRE1kSktiY3pmcUJy?=
 =?utf-8?B?T05YT3hrZHpYdm1NYzYrdDFRMnRCL1grNHkrVVZCZXBBVXZFNGdQdU5wTUdp?=
 =?utf-8?B?T09GellxdXlubnlwVzJUdlh5UU0wSlFabUN6Z255WWc0TVkrNzN4NUZodGhX?=
 =?utf-8?B?Y08zZWtOR1BmbGQ5VFcralF6ZFRvSEMzanRsWW0wbkdzT0UxNmNWajRGUnlN?=
 =?utf-8?B?RFVKS2ZBL2VlL2c3dHg5RkRMRnVjN1BnL3FXemVWYVUvSE9BUmxIa05CT0c2?=
 =?utf-8?Q?hIM2mZ6cC/r+3tobJj/BNyFoiKMJ3sg1ZPg6VQihV4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd9358-739b-4d54-c1c8-08dd16e0d989
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:01:53.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hjo/DbOv2KjP1eb/FUuc74xvLnyXw26h1Ynbyhtkl1Ie6KkpOs5+cjxWU9sR6yXU9Y1EqY30cQmggfoUBbwTArAdn8B+ltCKYt3/hTzPyGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF260681B1A

On 2024-12-07 11:55, Zi Yan wrote:
> In commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing
> VIPT)"), arc adds the need to flush dcache to make icache see the code
> page change. This also requires special handling for
> clear_user_(high)page(). Introduce cpu_icache_is_aliasing() to make
> MM code query special clear_user_(high)page() easier. This will be used
> by the following commit.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   arch/arc/Kconfig                 | 1 +
>   arch/arc/include/asm/cachetype.h | 8 ++++++++
>   include/linux/cacheinfo.h        | 6 ++++++
>   3 files changed, 15 insertions(+)
>   create mode 100644 arch/arc/include/asm/cachetype.h
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 5b2488142041..e96935373796 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -6,6 +6,7 @@
>   config ARC
>   	def_bool y
>   	select ARC_TIMERS
> +	select ARCH_HAS_CPU_CACHE_ALIASING
>   	select ARCH_HAS_CACHE_LINE_SIZE
>   	select ARCH_HAS_DEBUG_VM_PGTABLE
>   	select ARCH_HAS_DMA_PREP_COHERENT
> diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
> new file mode 100644
> index 000000000000..acd3b6cb4bf5
> --- /dev/null
> +++ b/arch/arc/include/asm/cachetype.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_ARC_CACHETYPE_H
> +#define __ASM_ARC_CACHETYPE_H
> +
> +#define cpu_dcache_is_aliasing()	false
> +#define cpu_icache_is_aliasing()	true
> +
> +#endif
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 108060612bb8..7ad736538649 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
>   
>   #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
>   #define cpu_dcache_is_aliasing()	false
> +#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
>   #else
>   #include <asm/cachetype.h>
> +
> +#ifndef cpu_icache_is_aliasing
> +#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
> +#endif
> +
>   #endif
>   
>   #endif /* _LINUX_CACHEINFO_H */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


