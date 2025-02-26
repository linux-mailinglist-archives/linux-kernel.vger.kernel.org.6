Return-Path: <linux-kernel+bounces-534615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43EA4692E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BC03AFD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26F233727;
	Wed, 26 Feb 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g88JFDSk"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7C22D4F6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593551; cv=fail; b=KTalHYfQrYvNRglBTVJkpta7H2GpqMazfib0IeGGfBSkOkBbLEI5KVZFf6s47WeopYK8B2ucXy7yAKdzmpUQyKKQ2qA/iYaOpalWgM/x6AWqMG32Rq8/aK2sx+FJqsHSvQVN6IHohog2oMt3eCO2XSSt247fXArcffmZwT6ju14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593551; c=relaxed/simple;
	bh=TQOmg6Fa9TWZYZ/BHtPNuZiypx45MCkPAz8TKlgZZiA=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Dw+aowonheJW4lf6sz3+d91Z9RBQckPk8g8KEXlvYws1V9nK0oSAL5K4+Ti5FJYntqt0Cj4njk+vQxRw6ijV/E6EHYN74KyD1RdiJZwW8kBWvSg08oQG/qTXZP2FbIwRqghQ2ynEhjiIFsL5dqiIctqJK3QU/PazKxh8XXrOu7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g88JFDSk; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBQzSREKWGTlyghUg9XAxhlGbbqKmTRy97wqP3i7U11JSVxIm+smeXjIgxwz/S9rH5AcJ2E5Z6WN3DwF8dNjMBgMi0jXOyShP6b1DeEb/K9muVwRJmES0hlw0TeTLRFRW0Uk+YZWYKqog4QguoYE8U1nDxmWvnBfyqHAVXMdRWlJCe0uIG/ZSZID++gqQbwYocnWopUCG98+MKKDf1RwECXv12E8UzEuj4QQzFgrTmfIVlZOHgvSju8wAZxLhYpQPNG9OFBcF8LRcbDlwnxtRbYbFM3ecDLPZR1AFJMcSMBO7Rhjx1dVQeMAxptJnbikdtgdRVuz0cBgFtj3tis02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3dIkGYLTBMfLkbwonyK1x2f/h+Jr3f47mVxSwIpKko=;
 b=YX/aznFpiygGtibwhbHsuYJrvlTbXLvaaxzq28bWTfAAt67aZN9Ge9w64UsljAS49jQdISPvITF7Vjsi/8I577kWzuM8rlWrrI27EtWD0WOZTUXwJMc6XyVtmgd2H0ICzDR4d2sEu1IcZsJQLmU041DVss8skkXE5Pt5j0iTlEhjRuJxXQhoJXkU9sJbFfFXSmmCzrDExovgnBMO5kwS5iln4rfXk3hMjjNqWer9zNsOyuXcDKobsv9pzx30ZTeuRE63GkVYfWbyvdGcpudzjzaH1Ym0NbUkWSly4j/Gijv4off1WH70az7WbqxNIDGWcEkQ40Y4hGzd3Dnh+mldyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3dIkGYLTBMfLkbwonyK1x2f/h+Jr3f47mVxSwIpKko=;
 b=g88JFDSkbQ3bgaMj3w4X7n2ghq0R80kb9c86fgvFxhx7b9KDxrBpDTNUJl0+TEwnC2PRrNTg1W6WfBcCiJBq3OAdiMKIpvl23HA0olqLjQwiQszImOaQrYMdm58JBYxcWGGDMF/IwSgfN4+YI57OXYjZC9LA9jzPX5wcWl/mT64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Wed, 26 Feb
 2025 18:12:26 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 18:12:26 +0000
Message-ID: <2731f073-d529-7870-6d25-ebd2e44cd10c@amd.com>
Date: Wed, 26 Feb 2025 12:12:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
In-Reply-To: <9086371cfe69760780d67ec279f69e91f65086a7.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:806:28::6) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 25157e4d-77d0-4c94-5332-08dd56911fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDVmcDlnRUF4bFloM3g5cmNQR0tONzVrc0d1WG5zL0VZRTlpa0FzVjB1UVpY?=
 =?utf-8?B?MEJyWWRqSHJtbDUwd0tERHpwcWhzOFFDaFZycFFDY3ZBZXQwMTZsWkxOVFoz?=
 =?utf-8?B?ZTNackxRK2c1Q2llUTYvNlcrdWVIaXpHUXMrVHludFgwVXJ5OHJxZFV6YTR3?=
 =?utf-8?B?NlFTb3lJUXZ2R1RqYjEvdEVNT2Rkb2pxbGNSbEJRbXJiTHJ0TFFmdGYvd0dR?=
 =?utf-8?B?YjJ4RC9EMFAvc280SE1TUmc2ZTk3T2grQ2VTbkZFemJHamlkU3RmQWNVa0JY?=
 =?utf-8?B?VEczcm1SaVJTR1I3UGt5bjlJenpXaVJLTGtSSlI3T0wzZndRN3BxZTZwbXpQ?=
 =?utf-8?B?MFBSQnpSVUZGb1VhakdvckJpeEswVkpmcmV2TVBZYlNGR2hRM05yckNQYUov?=
 =?utf-8?B?bE1KNC9IaFd3SFNweUdFaythNjF2K1QrMSsyZGZtZWFNa292bVlZNnVzMHhU?=
 =?utf-8?B?VkNldDlFOUZVU2xvQm8xOXliTlBGSlFIOVIreEtRaEF0V2RyVUptaEZHY2po?=
 =?utf-8?B?NVhuWEtlbm84eHdsU0VrSDdJNEdwcEV3ejZTaWkxZkpUWThveGY3TnRDNFQ1?=
 =?utf-8?B?UCtUQW81YXY0OWQ2LzVSUnRBTHVIMm9iamFxd0txMlVvL3FoQUdYWDMzQUll?=
 =?utf-8?B?Y3JvaG80N20vNU5QcHpMVzJCbXJSRTFGYVNOam9KenllcERVNmttWG9Cc2Ju?=
 =?utf-8?B?UEFEM3MyNytPRXpReHdxQ3NQRlZBSjJ0dkpZV3dnU0xtWjVYbGpqczA4N1V5?=
 =?utf-8?B?a2tvcmkrT2VlZjBxd2x1bnkzL1RPLzJpN2lrNzZvTkpYRTJiN0hTQ0xUZnFk?=
 =?utf-8?B?OUlvS0I4T09LZUVkTHRZTzliYjdQOEUvOWNnNFREY1V5OEtPUUFPY1YwWStC?=
 =?utf-8?B?UDhWQkU1cXJyZlJ3QldiaFI3djhMZXVKamMzQVZxN0pWWXhKcXk1ZWZOaWw1?=
 =?utf-8?B?N1dOREd0ZllIN2d3NjRaV0ZLZSt4dnlyNmZjN2d6RzB2bUpWUHlLcmlMUFdh?=
 =?utf-8?B?d3ZZVWRNNWdhK1ZldzRDNkduMlU4MU5rWCswSFFKQzl2UmNZZTFjaDdtNFZp?=
 =?utf-8?B?QldzbFlkSkVBdkQ1L1p3ODIrUlpndEZ2aTdGR0daS0c0RkM4WG1PYzIzNDdS?=
 =?utf-8?B?MGVnSFhYNkxuWEZyQlIyTk9JOVhPM3hWSFExRUY3eUhJcmVPRXBrYjNZcFRT?=
 =?utf-8?B?ekh1c2loWGl1eXBwd3BycjFpRjFKeWtBZ1pSdm5mNG53dlphcHFCbGo2OUVL?=
 =?utf-8?B?d0VwOFJ4VGl4cFNVUFVIY3BMeXhabFZ6d1I1c3VCclZNQVRwK202eHNBcWVE?=
 =?utf-8?B?dk1rbkU2bVZKdVpYQ0cySGZYUVNOYVlmWGhRNEp1YnpJdHRtd1BscHpyU3Jp?=
 =?utf-8?B?N09PdTdFeVEyVGlNL2ttNGlwVEpMb2RHQmJ6czdsdGRZSTQ3OWRwRnFrOS9j?=
 =?utf-8?B?VDhUT2VOK0E3L3hPczR6VHozTlJqb2ZCNzlnWk8wT2ZmTGVJeEdqL2c0dU5q?=
 =?utf-8?B?Z2RDQVl6Q0JWWm1ZS2VqSm96Y2tYVXNKRUxERjNPQUJGZlpKUVQ3WjZOczg2?=
 =?utf-8?B?UXBIeExaYlRxaXIvYlozUU4wRWpLTS8rZEVib1VBWnRxc1RJOTlBR1I1MVp1?=
 =?utf-8?B?Y0RWbmVNK2hyMzlZUFd5NWxtTU1KSjMxU3M4TDU0bVJydm9MQ21xVFFZRk5y?=
 =?utf-8?B?SkpxL0trb05vWTZ0SlExbXNjdEdLcEFaMUdKaUFhS0VCT3lxajBmRGg5MHYy?=
 =?utf-8?B?dlpUbm9pbkhQcEJMTys0c2hRREFOTHcvZ3BaSEVlTlN3MkdQQmphcUxXdkov?=
 =?utf-8?B?WS9tZDNkTThhUWJQY1lLYk1LZ3RVUEVaaUNLdEU1a1dXQXgzN1BYSmZkR3J6?=
 =?utf-8?Q?89ck2tY8UgMcx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDU2OEhKQUVNTXNFaE52N0xpVDZrQWhSVllwcDRZZ3dLYkFwRk82TFl4blUx?=
 =?utf-8?B?dm55V2xJMk5oM3NtVVl6eGxLT3lJbUtOZGVOOXlBemNwTUR5bE0ybmxaVnJS?=
 =?utf-8?B?VXF2aGRDSVgxcHY4blpyczBYZk9vVXhpV2Q5enhrYkxVRlZEZ1FtRGo4aE5w?=
 =?utf-8?B?cU1vVDI3d0VMWkxGU0NsektuK0tWc3B6dy94d0xNTmxxcWJ5LzUwNFk1YnBS?=
 =?utf-8?B?bjJ4TFhnU0hzcS85V3RhWnhleVYvbjloTUsxZFBTeFgrU0d1T0xRbitNNDBE?=
 =?utf-8?B?MjRIUTFJOWwycjNhbE4yL2xySWtaZkl1ZTFpR2NFUlZ5UDJKNTFnM0Nya2JZ?=
 =?utf-8?B?QlVMLzI1aStqbklZZFhUNDRZQWprTTl5eXBFczkrZVRxbnZuOTNiem1vTzNZ?=
 =?utf-8?B?Ry96ZlZwM2VwODNheHlhakd3TkdYSzBVeGFJSitzTVdLZHVWcDQ5QUI2UE9Z?=
 =?utf-8?B?ekcrSHZDSlRsdTFYWGd2cjVkQnY4d2wwYWhkdFFhMXZyVzZ3OXpRNHExN0Fk?=
 =?utf-8?B?ZXZGT2FUZUs0U1VqZ3BySHBvUmZlam5OOXRqZHppSXh3Y1grNnBHYktISm1C?=
 =?utf-8?B?NXNZTDhhRnNsVUc3STgvMGxWd0Y5VkdjWC9uclUwbmFXMkVnTkNMUjN4ZlN0?=
 =?utf-8?B?WENpTkFLdzhNakg5Nnp0SlZlZnJnSitjNkVFL0Q5QlJOUW1QbzJiTDlKRFg0?=
 =?utf-8?B?Y2xCWGgxZFN2QTR4V1lEdnRjUUgvVFA3ZldFS2xVb2ZRR3NVZXZzU3BMZUVu?=
 =?utf-8?B?STFkNmZtTUxCYi9vMFdwczMrKzJPWGMzei9YWjJRRkZNNFhFYkRSaTFRc2VW?=
 =?utf-8?B?eG9xWGdDUTNuT1VQUFZBd3VENHRobTl4WkFaYlZBbEZXN2w2ZHRDei9FMWp5?=
 =?utf-8?B?QW42djgyYjM0VTVWYWZ0WlZjK2F3ZWNYdWpUTklCS1hjSHVhZUZ1MTZPRldw?=
 =?utf-8?B?NnZxUDRnTDlKVS9Cek51RVZTTEFvTHpESWswdXJPckx6cVBzc1R2bTB5UUtT?=
 =?utf-8?B?aGNCTkVJYXNCM2xJS1p3a1FhK002d0FGL0hPcnJiU1RYNmpHSEFXSXdJR3kv?=
 =?utf-8?B?eURHY29seUxIRjNwWERpLyt3NUx1dmtyQllWQ0U4cTV1blp2K1ZhTytQY1dR?=
 =?utf-8?B?N0dVT0cxU1o2U1V0RW9oeDhPZUFSbkEyNWMxZS9xb0g1aHlPRGpMc01Ldldl?=
 =?utf-8?B?RktSTWNMTFg4N0pZbUJaU1QvZ2VjNW5zQkZuNGVXQ3FSeWlVU2FCRTBPdHVR?=
 =?utf-8?B?d1BhUlo2YVBpeUx5bVppOWdPZTVGUzc1bklBNk91QjUwMXpSdzRXazJlTmwx?=
 =?utf-8?B?Wm9EVTQyTmwxeTkwd3NkM0c1bkJiRGdwZ0h5cjBlaUdVdnZYVWk1L2JDRHN5?=
 =?utf-8?B?QjI0WnRiamUxLzR5YnVFS3k2R0tFM1lLMG1iWSswQmtNWHJSRllUZk5leVZr?=
 =?utf-8?B?RXlhVkY3MWFLYTc3M29DUHBXM3Y5WnQxc0xiQ3ZQaXlHYzM4S3lYMHZmc2NV?=
 =?utf-8?B?SWFCTW1VL1NqcGpqSGZpOFpqVml4cG1HeEVHZFRxMzNFRzJGUkp2c0dsUFl3?=
 =?utf-8?B?NVVPbDhVSWh0bk1OS3BZMzlQRWpZWG85RmZ2eWs0Kzk0aE9VTmZDMkVFaE50?=
 =?utf-8?B?cTFjWnJhN1hQY2U5bnpOVDJicEdKMWVsQ2tXbjVwWXhnQTBaM01zZUdnN2VT?=
 =?utf-8?B?dTVjMXFiNlRHN1lBaWxlaUQ5UkNwUVBUdVFLNDhlajBDay92c3UwRUtCRGpM?=
 =?utf-8?B?MnlQakpIK0VkSjFrRTF2YmZNM2JCSmc0cVdiVW9yUW1xMHBadVhUaG9XUGE4?=
 =?utf-8?B?S2tsRjF5L3ZpQVM4UVNqN1ZVZ1UxVFlGaENUTzRvTGV2dzNQbnczVjBQZTFX?=
 =?utf-8?B?SkVvU0cyUXN3cTNibXI3U3IyZERhZjFJNnRFM2IyYVl6K1lEbE15K2Y1TXMz?=
 =?utf-8?B?SHBucHhEbFdCU011K1pKYUc1T01TTEtjZFhLZzFUcmh1cHRJeUtoREE2bE1k?=
 =?utf-8?B?aGRYVk5YdVhxUzR0NFVqeHp6d3Z4L09VUndxUy93cU1OR1lENjdwVXpPaUtx?=
 =?utf-8?B?YVl6dHJVZEJkcXJ3RnNpNWo2alRSMW5RbWxvQkFhcCtLdnppTE9ONStheGc4?=
 =?utf-8?Q?aTgliYxMst2Nywzme/0iGznJk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25157e4d-77d0-4c94-5332-08dd56911fac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:12:25.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdh2OxYunm9RDix3TYU2/cJ4NRbAUlswGufzpKMw9KC8BEDmZupDhMeGapHi2DWkS+D6bIMBEsUyE6n79yP08g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

On 2/26/25 11:46, Rik van Riel wrote:
> On Wed, 2025-02-26 at 11:36 -0600, Tom Lendacky wrote:
>>
>> Right, but the ASID valid bit is not set, so the flushing may match
>> more
>> than just host/hypervisor TLB entries.
>>
> Good point, when using SVM these flushes could result
> in flushing more TLB entries than we really want.
> 
> On the flip side, when SVM is not initialized, the
> invlpgb instruction will fail with a general protection
> fault if we have anything at all in the ASID field.
> 
> I don't know whether setting the ASID valid bit in
> rAX will cause a system to crash when SVM is not
> enabled or initialized.

As long as you keep the ASID value in EDX[15:0] as 0, then you won't
#GP. ASID 0 is the host/hypervisor. An ASID > 0 belongs to a guest.

Thanks,
Tom

> 

