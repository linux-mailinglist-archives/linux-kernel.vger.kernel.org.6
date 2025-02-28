Return-Path: <linux-kernel+bounces-538757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B61A49CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7186164251
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497C1EF396;
	Fri, 28 Feb 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ud8q3eir"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F911EF363
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754949; cv=fail; b=cx8Scj8zHrLZz9bq/gZ9cS28enHAk70BSiYuy1ZJ79/b6Cl2DKSz8tAVpIlPSk9VE6Nv1EI7EZL01sSJZ+io3H8OvjkVwXrtSx0Gx4fUtW1fjWRJljKcoqUQh7ZFeDqpzJ0xND/HkUdbBU+MKT2jo2+WsGynuZYuOR3uu3WBRAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754949; c=relaxed/simple;
	bh=+lAYSAGxnRujCRXFcnCksatpJZ2d4XEw1oTQDQEMIPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cm37+ucMtFhBwo0xojHNOR2iZnPLHxvU0EOOWlIyinCPYMgewjUmckTI2brvbxbDsmi0YMl7rfp9OPX34XQ0Q31/74x9nsh/i1Vq6Xb7ny/ulUTsI3TghkoLjK4fV14i130vDkSW3XXG88OA5UBiFx0G9HX2yyEuRzxzOe9yEjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ud8q3eir; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMSU3tw5lIjQGq8JxgDeFeoBmPrVWm39a9E5YhkbEmdoOpgCsyRN3cAO9w/3vZ9XxVdoTnOgUwiJdEtDfYXr/H1MN38oBB89U4ocUTjni+2Yf6IYqo94uhwnHnOPBkEmAjqBkzDzOj7Oua0HfyDyx/gQPovnhCIJZ5uwS33wqRhsvFjnhF9biX8ZzCvGS3iT9Pfc68v7+nXvpsqRcFTg2HMLTP83p9VTlfw3aDNzmXUrOMOi6RUzDQ0T1ZRAMk2SQtTGvb051PcWV3PwqB482vZm0ey4FHpvzHK6BwtdBwKFnePytTSXsW5c0MjtKsUbWuib8Z57CYoAecWB7y/3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg31Wt5on7HwBAS+T2LXc2WBHd0Hs3fopD/fSgYkxQY=;
 b=ulRrytzY/WPENCzsk8NsllsKcDL4QVpUQRH8vPrSpO/4ahzNPD4xWLPoQv9TttbpxVJWj0v3G0Iza8o3AoKlY8sZNndPdAV/rI0rPAmU3HG8d5a4o/TT7F/fqDHdswMTizG8t8hRe5ttftqW/oyIK2jckAIroi4qJ7md0Yrhf4xUJr8CoE9imjmT6DlkSJi7KOIf6ur/EI+o1SiY8L+7KecAi2I4B3IxFdxEYDSxgrHDdlYLbI292FOkrx8Jjpogv3tbiWnwZ/74CZVCZUdhO8SuoMdDlUNjbn2+Pi8+f9p6C9k/V6CwbXhS6xqmx+86vKLYbINs9rzi7lSuco5gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg31Wt5on7HwBAS+T2LXc2WBHd0Hs3fopD/fSgYkxQY=;
 b=Ud8q3eir/qi/YApj+EtzASlhj1vcbbkGaeNQxfkjHANlRTxgbifX73oTLLSdWbm70w/To0VKfU4S9fxT7VVYbNwzY1KWdNEmwNjXyfzSCI8TKkthY8F2WbEafeCY87nlQ8jNfbasE0JDPj6nGvSKkieFQyWymFNJcEoeLbbYpTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.25; Fri, 28 Feb 2025 15:02:23 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:02:23 +0000
Message-ID: <75e45ec0-25da-45c5-827c-ee048c0ebd86@amd.com>
Date: Fri, 28 Feb 2025 09:02:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
Content-Language: en-US
To: Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
 <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
 <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
 <297b28e9ef9f4cd983ae2e3dd4cf1fce8b74d0f1.camel@surriel.com>
 <059ba03a-a892-6a68-6000-c7db3dd6cf9c@amd.com>
 <9086371cfe69760780d67ec279f69e91f65086a7.camel@surriel.com>
 <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com>
 <c6a38a1b6f27ae787dbfd99df225f464c274590e.camel@surriel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <c6a38a1b6f27ae787dbfd99df225f464c274590e.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:130::31) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: abf0c0de-4b89-4f36-3676-08dd5808e827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXc2NE1NUEJGUXBjRU5adU5UREVZVHB4N252Y3o3VnIxZXpTV2gyT0lIYXZi?=
 =?utf-8?B?Q0h6SmJzeGF0bldBaE5hMWc0dlhDd3JHMkNJelE2TGFxMzJWSlBZQWRBbVM1?=
 =?utf-8?B?UFJvemJwcjAyd1ZrZnlLZm1IeDJIQnZIdTJXZzcwS3lma2xPL3VoWExyaVRl?=
 =?utf-8?B?MnNTLzE2Kyt4Y2hnOTlzVFpYeXhwV25MQXcvY29zSXlPUjJYOEJzTk5wREpI?=
 =?utf-8?B?Z090R3JuSmhIbEZ6elBpREY4RXRBSHUxMGVhWFROVEtWeGwwdzF1cWFPRTlp?=
 =?utf-8?B?eVdRaW04WFZwSk90UnJZQXNIWmM0ZGtvcHJlWTdrRG80a2F1bXVLZjNqZTFN?=
 =?utf-8?B?NW9vWjJjSm54aEMxaHE4YlRZcitLSHpJNExHZk5wMXhPUDZwUEQ1U2x1b0w1?=
 =?utf-8?B?WEZhRzBsVUV6UmpkVWtuUjdZU0UxSkRqREYzVUJuRUM5YWlaNWp6VmxGN1Jv?=
 =?utf-8?B?d0ttL1hkYm5oVTB0NTNGT21LdC9nc0dYTEVaeU1abUxHcVlyR2dVSlRCRWMx?=
 =?utf-8?B?ZllJVUxXSnNaZGFyM2JkdVBabDl6aUpTVVlxTjlHZ0wyV0dRRkJGYXIzSjVS?=
 =?utf-8?B?TzRhQ0QrNVlhdlFlNW81Nk1veWkzZUNJaTRyRTRTTkQ3QUJ3MllleXErckph?=
 =?utf-8?B?TEQwRXlNcEEwNEtOUjZXcFFFQWsrblYrZlpYMERqOGdjL2NWd1grZEVvNTBW?=
 =?utf-8?B?cjRjVmhXOFpnMlpWWmFHZ2lrWm5Pc3N6aWt0SWM1WkozL09ZSHlZOHRtYWJi?=
 =?utf-8?B?VVpBZy9KVWJieG5TYU90aEVyL21XeXB1aFNPOEQwR0dJbnF3OENqOWNOcE1u?=
 =?utf-8?B?S2xVWitzelZPenJ0M3pJU1k1ak81QWRaZlpuVW9tUzUvMHcxcmtQdWVCUmRx?=
 =?utf-8?B?bTBpTHlrZGNkTFlXTE5RazlqNnB4MmhkeXJWeTg2dm9YMy8zSVd3eEJ4TGM1?=
 =?utf-8?B?ZW9nU2ZSdFZwbCtYUmJML3FML1Yxc1RmVzZQZlYzckg1Lys2ejQ4N0Z6dTFZ?=
 =?utf-8?B?ZDE0emRMaVE2RzUzNUhRYUVnQkEwL2JLV1NuZHpFMFVoWW5lTGdaUEtWcDNx?=
 =?utf-8?B?aE9XdU1FUjl0TEpzZnM5cExwM1BsTnJPRTQxNEtTYTFSdFJ6amh4ZERubElq?=
 =?utf-8?B?N2p3eDlKSUR5QXAxT0dHZ3lvcmIreUJPcVdobEUwc0RReWZqcm1SODF2dmh4?=
 =?utf-8?B?V24xYWUzMEhyN1l3UHR2d0NVV3paQ1JPSlBmbVNZUXJrSzY5bkk4R2RFVHl6?=
 =?utf-8?B?MW9WaFBnR1NHZHBMSzNUa29QeFRmMDdWUWl0dmFJMmdGOUNaNVBMVGxFcHI4?=
 =?utf-8?B?bERYekZGdmtaTHJibUxJenc0R1dpU0FoWmdUblpFTVpoMjYzOFBhZGFNTElD?=
 =?utf-8?B?TWVPTWZpclZzaXdzTUlRSjRmd2ttZ1llNTZqNUduTDd2NWhaT1ovbk9ydm5X?=
 =?utf-8?B?REI4N1dGL0tPbngwOWtoS0Y4UUc4UUMxN1o1TU4xMzkrVEphOU9tck10REc2?=
 =?utf-8?B?NHplRVZCbzg0UGlubkwzdkpKK0hWVUxKNSsva2RRQmRsMHNvQjNPemtBRFdZ?=
 =?utf-8?B?WXJGSGlSWDlURCszeEh5NG9wZ05UQVhzVktmNm8rMnp1c2NPcWNqdTVmTEQr?=
 =?utf-8?B?TjRzVXJjK2dRMzNnempwOTI0anNiL1p1SWJoUGdDOWlJUFdVOVpvbFZXYm5h?=
 =?utf-8?B?OVRKWURzVFdlMDJHeGlBTUVFT0ttaTFWc0ZOdjZsMnNUS0JTYkdEMURqZnM5?=
 =?utf-8?B?UzZJbGZCYUFmSWUxZmVQanFuL1JtS0MxOXNjakNMUVZ4RVNQZGhNU0o2RnM4?=
 =?utf-8?B?QlR3RDlaV3UrcjI5NHdYL3NBWEdFczJ6SlhPbDZuenYrdWwxUzJKdzkrcHIr?=
 =?utf-8?Q?ZsDg35ODt3OIO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NElYelNHSFdPeWt4YVcrRUZHNVp5UFpGRzJmQytCTzRjMDEzbmJVVDNBOTFJ?=
 =?utf-8?B?dUNVZjYzVTMzVDBjaEJaZk9YQ2pqVnA1NnFlaG4rNTduTzZwbTFwYjdxVDNW?=
 =?utf-8?B?VnJYZktLaEczczQ5SEp3WFgvWFh5a3BpM2RKSlovL1YrTTJ1dTFSRTVCRzRr?=
 =?utf-8?B?c0wwU0xhSGJMRndoVHRCS3prcTJ2L1ozSXcvNENCN3RUUXB2QithS3RWOFZO?=
 =?utf-8?B?eUd3RlczaER6TThXVGZ4TVBFZ0F1WFVZNEpaYy9KZGtGclNieUxtZ01RNjVj?=
 =?utf-8?B?WEUyVFhmeFRVY1hkRWpOR3g0eW02QUgwcjJOVUF0Vnhzc2h4a3VmZzk1djQw?=
 =?utf-8?B?OGsvclI4Z2xpS3JGN1F4YmhFWUdwUUtOWExvaktDZ0lXTFFVNlExVzYyL25Y?=
 =?utf-8?B?Rm5CV0xjNFZva1Fudk5JSDdrK3pPbUN0aUFlMmNjbFBydDF4cDFTZHFQVy9R?=
 =?utf-8?B?aEYzeEl3dzNkQzdsWlZYa1NkNHdSQ0NUSVFzajd3ZnE1dGdzUVY1Tk0zQnFr?=
 =?utf-8?B?VnBScmxUaU9YKzNBb1JoL1pPMGNnbFlOUG9TT24reE92Y0dUR3lmUThZRkhl?=
 =?utf-8?B?cXVlVDhFaVlnN2w2ejh2YUNSK1cyQ0ZVQWZlV0VQcndZZEhRRm5mWUwrRElS?=
 =?utf-8?B?MmljVVA3d2lkNFd3Zmdkd2JyeHZ2YVpGb3FKaDVOUHA0aEp0ZVRxZ0hOY25i?=
 =?utf-8?B?YlZLS1ZpbzJmd2w1K3hVQzlGVFNJS1ZybWNkWWRUWFVvTytBU2pEWi8xdWFJ?=
 =?utf-8?B?Sml3aWhSVmNNMkRMTEQ5L2p3a1k4dmpIYk9iQ2tud1JIcVBoTnRZeW51LzhW?=
 =?utf-8?B?ODB4Z2tnN0YyZmhTUEhLSWZQbDd2T1hxRWxPaTM4L05HOVYzNnpNRmlJVDF6?=
 =?utf-8?B?SytteXlsT1FSS2pKZDhQVmh2OXVyS1lrV2VMOThFQXNoem1BazRLZ3RsUTVF?=
 =?utf-8?B?ZXN1TnNkZXljMFhHVmt1RWJZNURvZU11TG5RRThUdzI5S040Vk4rM2JZY211?=
 =?utf-8?B?dXRGbWFSODh6aHM5L21WSTJiVlVtREV2YzZGVXBqdFQrbjVhVEVPMkY5elFT?=
 =?utf-8?B?bWhUQlY4QlhHai9Nck8xWjg4Rmdtbi96akF1aHRBV0l2bGs5S3dsREtsR0dO?=
 =?utf-8?B?MDZjbG95V1ZGL3FHRGY5UkFXb0pWYkhZUU5KZXZpbDFXUUVzWWhabzUzV3N3?=
 =?utf-8?B?bjBGK0M4ZXducHAyZmNNdVg1NzAzajF4aFJreUVBTGZieWxYNENBMFBEVjFX?=
 =?utf-8?B?aHVGaWw4M2xvYjYwNjk5cFczenVibUtWWUhoQk1NSm93N3JmVnhZUU9YSGhY?=
 =?utf-8?B?bHBZTGR6dzJYU1RsMWVJTnd5S2hxaStoV2JhT0pHSDY1YXZzanhBcDluV3hR?=
 =?utf-8?B?N3dBNW1rQjJ1aWFrS3V1SHdqMzhwOWxyQm9iV2F0RHdaUjNGQTZFZC9LWW9W?=
 =?utf-8?B?YURLUERxNVlGOVR1R1gvYUs1dm91K0puVk0reDRsbnlUcWk4bVM5THhLSHo0?=
 =?utf-8?B?MXVCUW0wM1dZb084d0FuNmNRUEc3dStqdktLR0pHWVo0cVZTL3h0RTdoeVk4?=
 =?utf-8?B?TnBHRE9tVUE0K3RkdEVxZE52UE40SlRSa0lNaTJteEloOEFLdmRQOUIzdmRv?=
 =?utf-8?B?UVVsb2xOOWE0OUNPT0VDL2FOMzhjTmpVVGYwOWFEQzkrQjRKSEhyUy91VCtD?=
 =?utf-8?B?SjNJSHZzZm9la1p5cTYzbTJ3Wjlmb0NsYTdBZ05GcGhSblFvTXNucGJoVlJM?=
 =?utf-8?B?ME10cXNqTkJ3Kzh6K0RUcmorZkFWUnBIVWdpWC84eURUc3RyYVBiNDNWbFdG?=
 =?utf-8?B?UXc1TjJaQTVRMGtOK1FkazFUVnlqZ3NtTjFseG5TL1U1MUkybVpnanBNZE9M?=
 =?utf-8?B?b2xrS0lGb1NjcDJ4RjdzRlVlSW1nSE1laGRsc0VOUnNVT3FHNnE3TG92ZmdD?=
 =?utf-8?B?bktnemVNQW1rZllRQ0hydU1EQ0tuQnJ4WkVZNU0wOUw5bmhRVkVuS0syQ0dY?=
 =?utf-8?B?ZElVWVQ3aVRGelJQR1I4dTNiTm55b0ZEclpaMU1pMXVrdms0L1pIcm5QSlVn?=
 =?utf-8?B?TWgrV3hEbmd0ZmI1SEhrVlIzTXQvL2FrN1gvUnBmWXYwblNEbllUaFVxOWxV?=
 =?utf-8?Q?5Y0Ty0RtM2QDUA89j/JaXe4um?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf0c0de-4b89-4f36-3676-08dd5808e827
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:02:23.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ObMupVhxba5+TAmmhXefhLAe7Agb+zsBSzd20NPSnzU3Y3MvfLTMOfmRFm+7Zcz3BDjHFfGrpRvQqfJ0zTYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

On 2/27/25 19:13, Rik van Riel wrote:
> On Wed, 2025-02-26 at 12:12 -0600, Tom Lendacky wrote:
>>
>> As long as you keep the ASID value in EDX[15:0] as 0, then you won't
>> #GP. ASID 0 is the host/hypervisor. An ASID > 0 belongs to a guest.
>>
> I've been spending some time reading the KVM code,
> and I don't think invlpgb would be currently useful
> with KVM.
> 
> From reading pre_svm_run(), new_asid(), and svm_vcpu_run(),
> it looks like the ASID number used might be different for
> each VCPU, assigned on a per (physical host) CPU basis.
> 
> It would take some surgery to change that around.
> 
> Some googling around also suggests that the ASID address
> space is even more limited than the PCID address space :(

Right, to support using INVLPGB in guests you need a global ASID, which is
an ASID that doesn't change over the VMs lifetime and is used on all
vCPUs. Global ASIDs are only available and used today with SEV guests. At
that point you would not intercept the instruction and, based on APM vol
3, the ASID value is replaced with the guest ASID value.

"A guest that executes a legal INVLPGB that is not intercepted will have
the requested ASID field replaced by the current ASID and the valid ASID
bit set before doing the broadcast invalidation."

So I'm in the process of verifying that issuing INVLPLG in a guest with
the ASID valid bit set and an ASID value of 0 (EDX[15:0]) won't #GP, but
will just replace the specified ASID value with the guest ASID value in
hardware.

For non-SEV guests, INVLPGB would need to be intercepted and somehow
emulated or just not advertised to the guest so that the IPI path is used.

Thanks,
Tom

> 

