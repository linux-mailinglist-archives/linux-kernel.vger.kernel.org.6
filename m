Return-Path: <linux-kernel+bounces-361859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C619399AE00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BCF1C22124
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6941D1311;
	Fri, 11 Oct 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ip/DeWEP"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51F10A1F;
	Fri, 11 Oct 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681719; cv=fail; b=JEjQLgwRIqCdZTboNBIq3vL8jWUqxFPPcd+g0ccTjYbjV/581WG5MQBb0eqdTG4oplgnszoZU0WTRE/F5VvLKWs09C4R+rP7xIschUDTOM20UQnxYk34csZuhJDm3u0IJ9ZK0dCAjpFz50gD+wKb0jSNg4E2t/r2LPmLZH65crU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681719; c=relaxed/simple;
	bh=elsG9vNul9HBQp2PxFWLm6mTz9Lja7S2733b9kqwZeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ubQUnEN7FsBMVvXnBxpuA934teX7qm6j0WFATuYr7Fhzc+nea5429Pfh9rQ7BqrXwbUsDABBIui3nIVtowUGOTImhko/IfjzJ2PcoRA+k8kkCCY7sdFfcSd6tQdTk68qd8IcGY1BSItwf2JIKYzfrKjI8eFRNY0jcp/0vRT2zzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ip/DeWEP; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkJqV7+lBhhau6Y9oMRCUvRyA0zThyK/kO0t6RtYV45Wn54oweKY5OYw9Ufxkie4Eb4sGQ9PlKj39DQnBkmhUCZD0dbMQPFSlDGnCbqgJXmlPCNeXbxyrHp+uKmrvzzrsIJUk9qg4A4pNZhIy6GakLpv253jwirNDpzIkwzoEeRwELFl4VTRoGHwj6INVEeXcUSl1LcJHFbG0Yt6MWL6fXqrPtUt+1x8eFMNBH6pbBZkSxxOOMKP06KAVWC2hal8mrKotiVp6FnqcF3buB3sTL2y2BnxwXZnCDJuasxGBLkxR2XagdPGYxYGT4iyrJPyARFeGAjutyTPRBUa8+eWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmooFHd9RBRtX49VMKN5BYNnYng+kf3W20cWmCFF6u4=;
 b=jfOtuFet3KsvzxMTBRBtVybjubcE7QQhyT0p0TLHDdpRJWWEBGHPBwdG6Iute1B8CAieT+vyOfHNuBHNV3Ej3MGWwUjnWJRYIxWGDrd1M+A26DquP2yUnBx9gr8A6pBOvVlsWuC05L8dBpaMzTLHre+dzsuFfTJjhuRTr1XkMK0SGsiV860WXFC5s4/XBfPE7YCFWLSA2RyYwxSBAbHjwE+eiSiC2CW02GI9AM7xc/OxJWbwmwxgo+jTCj6g2uxa0ZfT5CHFPs/eTrF9/cbLkP0opfwKEElKfVs/F8C7wmJ2dtu4be1ckDS0O2rQdCt2/QN9fvohKbhn6Ngux0N5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmooFHd9RBRtX49VMKN5BYNnYng+kf3W20cWmCFF6u4=;
 b=Ip/DeWEP3NV4Zc1oWc+V7BIZt3Srq0ChJjeVFywZQIVm4qhLQFDzkyKm7+CllxYRZETSnaCffS7Ci46Bd83vuAh0hRn0J52LjpFfCu5IITsqGT1gXf34tq+4NHphxtO7JHM4C3EJqsqn4r1wSmclxTryyVW+n4Swxp95+yh9zGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 21:21:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 21:21:54 +0000
Message-ID: <1750ebb4-2b5e-172f-4998-5ca7288e94af@amd.com>
Date: Fri, 11 Oct 2024 16:21:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 20/25] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
 <ZwlfENV_ijDKjUqW@agluck-desk3.sc.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ZwlfENV_ijDKjUqW@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:805:de::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a1b92-7614-4982-880d-08dcea3abac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhDdGd4TCtoblMraXZPSFFUaCtZeWlxZDNSWm4xYkJ6L1hNNXpIZmtSNE5O?=
 =?utf-8?B?OUo5QzRYV0RFeVI4a3pHYlR3SzFxNFNoL1dPbWh3c0JDMkl5aldVYUpDNE1K?=
 =?utf-8?B?UW16YjJMY1NNUnI4VVhBUzJaSW5JUkcxSGtReGxodEQzSnBtbFQrMW1ycnZH?=
 =?utf-8?B?R1FIU21mSGhYZ2E4ckUyMHU3NFgrbFJFTVJHbjBRNlY5YUliVXhvQUg2Sm15?=
 =?utf-8?B?ajYycmVSZ2JqSzljS2pSa0t5RDBDT1hLcVY1T1RKSkFERkZKNW9xUTlhd1FT?=
 =?utf-8?B?eFVDY2VOaWdJdUw1alhNNDV2cXFmVHFQbUVqQnFSUjdlSUZzTkxRMEs0Z25a?=
 =?utf-8?B?cnhkdFpMcHRDWk0yQXFnMmF0TE16VmpjNThSai9adE9sVU1rQmc3aTlaYzJW?=
 =?utf-8?B?SmhYRU9PRkZ0d3YyMGxkeTJWcHNnN3VzR21Sem4rRWxYVFFVMnYrSDFpMnE0?=
 =?utf-8?B?RmkwaGFTZFNaTVBwaGFEa0RXNWJsRnllSUFTTmdaN20zYTJnTXVqK2VUVjlj?=
 =?utf-8?B?dVIrRmwrM2tHZVZDakFnNTZLVUs1SG5mUXpMMzB0cEl2NTBJdWJqN2ZzdXkw?=
 =?utf-8?B?Q1k1bm9iejc2SjlwMFFlL09meTlBQktKU0xZR2VyYm12SHBWYStycHBiQ2ZG?=
 =?utf-8?B?azZuVXhZV1JZbFd3K1FVQTZGM243ZHlva2hFQ0dKMSsvYUZ4YkpnSXhUSHoz?=
 =?utf-8?B?VEo1aWl2UUpQMnQ4T3ZVcUJlbktBb1ZCMHV5bmVsUkZpam4xRGFIeitDWmlR?=
 =?utf-8?B?dkVmTG5pV1M3enJ5N2psVWFGN2M5R1JsWElPeTBnV3hOQzdDNXFzUzY1TzNq?=
 =?utf-8?B?d1IzZXFpUEgzMWlqVzVSVTFBSXNYZjRWYTZ1cHh0VnFxSmxOMXpWNzhYOHlm?=
 =?utf-8?B?bGVoODBWQTZtcFFYQkdkN1hiUCtGbjhyNEwrSkZGTDVoQ055VjBLN2IwM1N5?=
 =?utf-8?B?NUN3Wk8wRTNxY2tiaEppRGZQVE96cDh3TVNmVldEY1B4cVJGYlJCMVBlWmt3?=
 =?utf-8?B?N0MvUVMyVUZHbWp4Z2RUclJjVDlFaXYzZVc2aUZmUHVZMzFxeUNKK0g2MWJx?=
 =?utf-8?B?ZE9UQUY2WW1KTXMwTHZHSnp2UXpWdXpJU2NQSXNRMHowM0J3bjZQR0lDcWZz?=
 =?utf-8?B?UnVRMEdneGl1ZzVNeStaU21peU1WTEN6blN5cHJZQUlOc1VibzFGV0V5eVlF?=
 =?utf-8?B?c2MvRmV0cFJkaHZIVlkySkNsekNseVpzN2w1V2lMbFBlZjdPbFJoa3AzVC9u?=
 =?utf-8?B?eVhzTlAzaUZmbUJXK3VEbFk5VDYyMURCKytKb0hlSWVUYk8wd1hlK1dVd0hY?=
 =?utf-8?B?c3d1TWViMnpEK2NIZHZqOW83NzRhMm55Q3VzMXVZUzVmVEFXcEwreXlCTzRS?=
 =?utf-8?B?cnpqL2Y3VGIxQVl0MjcvbnE0TGRKRTViMjFPZTFUWW5GT2pVbXQwVEFRWGN0?=
 =?utf-8?B?d3VtRW9Cb2k5c2RveVc3NURqNzEwQ3lRdTJDSjhwbEw5WGhPQ0tJUlF0S0dv?=
 =?utf-8?B?VjkrLzdYVkNpZURoY2dvU0xpUW9YTjlHVU1TbWdESkI4ZW45ZUVGb1hGcWFB?=
 =?utf-8?B?VFl4Y2RRMmNFcEIyam5aZUp4UXhEUFhjaEc5TnZNdEdmTkFpa0dNcFJkK09F?=
 =?utf-8?B?WDhITlRubWlkM0ZFTkRmQUFRK25FMmltM3FsNkZ5cVZ3eGNkTjBUZUI3dk9V?=
 =?utf-8?B?R0JSSTV4WUUwNXppTkxtRDFDcnFQSUJ1RkVrRWJ0RFpuck5iQ3VxY2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRaMnl2Mkd3TWF3NGsyRGdKdjFRcWxobTRycnpsYnBBT1FFR0J2dlMvQzN2?=
 =?utf-8?B?WWNiY0pQMG5JYzdpR3ZYNjVXWkYrY01jM1I0bEFLNzNnTENhRTVzRUZUd3NP?=
 =?utf-8?B?RE51alRXSk9Rem1LM1BGWFlZdEhEYnNoc3JoSlVzVm9sVVFtU0tXQnllTHJO?=
 =?utf-8?B?MTcxTWdDSUFyNkhYU2NiYjEyVVhXMkM1bWNucVJna3RCMjJJSmcyOElhZ0h4?=
 =?utf-8?B?WGwrczN3N05DL3JUSS9GL0IwREUzb3BVSEE4SnY3Z2IySDV5STl6RmhxOTNh?=
 =?utf-8?B?NjQzdGxsS3FsRlZ4ZnBkVUZHSHZubWF2NXNwLzN4TngvSWlyQkJ6VHZscEFR?=
 =?utf-8?B?Z1hoVnoxZVFjRmx2TlZoc2hweEdMeVI2NkZGT2RaaXRHeGJwOGZ1R0o2K2d1?=
 =?utf-8?B?a0VpaGhHeWx4WWRFQ1dicndhbkoxVlVIeDJUcGQ4eTk3YVl6V0JnQXJPd2JK?=
 =?utf-8?B?NWtYdHY1b1N1ZW8xbUpEWEV4TVJFeTlQUUljZFJ4a1FaQk1WTWxhVG1UaXdB?=
 =?utf-8?B?c01KdDNmRTBhY05HNGNHWnJSOW5oS3ZueU1GUjIvQmJ3MExaZ0lvWm1Cc2dr?=
 =?utf-8?B?eHhQUVpVM3pYWW5WU0VoSFVXWWJDNDVaeHJzYWtsYVRrSDFaQkFENmZmcW1K?=
 =?utf-8?B?ajNTNW1EMzkycEJpaFRhcGNzZ0wyLzlwRHArQkFmNUFGTmNXWWdsRW9TYWxU?=
 =?utf-8?B?V0cxOTNib0h2di90Qy9uN1FHbVJJdFVoWmNDcXprVDVnTUVKdjdQK0t5ZlhR?=
 =?utf-8?B?M0M3NjRBMnRqU3ZTWDh2UlhpWi96ZHNhQnNaSW0wUnVLdUJBQ3JYSzNMUUFG?=
 =?utf-8?B?UiszU1JLMGZDcUIwLzRzTU5kWVVEb0JEdHNCOVllVEVQOUgwc1o1TDgrTno3?=
 =?utf-8?B?cUpNYlIvVWRpQVZLdmdnekd4YWdob1phbmNkcG9TUkRodTNYcVNvUEpXRnJE?=
 =?utf-8?B?RklPRkViYzY0UEtRREg1UUVscmlVOHp2MkVHRG1pNnNJUVYyN25MSi9EdDV5?=
 =?utf-8?B?bGZINklKTEdvYS9aQVRYaTU5MzBQSlhmN0hzclpyY3RHZlN2bEtyZEw0OXEy?=
 =?utf-8?B?Q09ybExPV2dHb0htUnNHRTNLcUl5Y2VvcmtncXRoYXVwdWJJcjRCTlNIelFm?=
 =?utf-8?B?dmZscWlqSWpJenBPYUpmTDMxMk04Z2w2ZEd6alpSc3ZwajJ3bUkzQ1dDbDJv?=
 =?utf-8?B?eVlic1FRN2hkaHBMWXB5UGtYQzhScHUxSHZ1NGhNay9XNk1ia0JPOXZvN2Zi?=
 =?utf-8?B?K0JpNXNYblB4QVBJc29qMlRmQkR1aUlPZkZ4dWtZM0FZMStjU1NOZ21EazVp?=
 =?utf-8?B?UHdLUlFCckFLQ0p2b2Y5NExmdmNsMktGVTdYd1E5alk0Q1BHZUVsbmt2T3lQ?=
 =?utf-8?B?THNjdytsM0pYNm1rUUhhNlFsQXpMSDE2WjBsaEtVQmRUMVBFYk1QOVdrblR0?=
 =?utf-8?B?dUlJRVFTS1p4NGJUZVdpeG1uV1pBemdPQlBhdmprbXY0MGVqMHlONXh5cHY0?=
 =?utf-8?B?Z1pDcUdmYWx3UVl4NlZlZ2I4UDlsdTZaeTBaMDZMWmJPakNuOS9jVklUNnpI?=
 =?utf-8?B?VWp4ZVpsVThac3FscnlXdkVVY05ST2JnTy9vdmJaRVA5UXRNWDRjVzVpZENV?=
 =?utf-8?B?TmoxWG9lS21XR3dIVlFrT3dlQnZTaEdNRkc0Q1J5VkNzSjR6OWYzbHhHeTB3?=
 =?utf-8?B?VHNUampZL1BYTzNzcHdBUCttY2lkZlJrN3BKb3Q4WG1ORHA2YlRsVDRRTzlw?=
 =?utf-8?B?dHpybnlPMGdCMlNHVjVJaHkxQkVTOXBadFhPT3dXTG5ON0daZEJnbW5nSUVx?=
 =?utf-8?B?TEM3TjhlV0xXWnNGOElNWlhwVWozMUMvUG5sQ2U2VVpVVW1lcitvOG1QSno0?=
 =?utf-8?B?cFdETGRweDlqZTc1N3FPb0U2L3BwQ2UxUnV0K08yZ2NMNzJRN3l6OUVVUTRL?=
 =?utf-8?B?bXBObHdKbUllbmRDclpNY0VIblM0WGtDaUtBV1lyOEx4VUpkS3J6VkRJUFp1?=
 =?utf-8?B?UnJBSCtzYWNJYi85NFVOQlZJeVdpbERTWThrbVRlUlV0MGVHUVJGak5LYi9F?=
 =?utf-8?B?K29KcUNzendQTlErZGdTby8vN1Z1eG8yTmd1T2krSDdsdTFVWXQwR2JNNGVW?=
 =?utf-8?Q?4cyU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a1b92-7614-4982-880d-08dcea3abac9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 21:21:54.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9I88ICzsTyYOnccqGjnHEvlsubmePvSBFDzI1GG8HiY5biGRmJl7r/fO+3hFprH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

Hi Tony,

On 10/11/2024 12:23 PM, Tony Luck wrote:
> On Wed, Oct 09, 2024 at 12:39:45PM -0500, Babu Moger wrote:
>> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>   	evtid = md.u.evtid;
>>   	r = &rdt_resources_all[resid].r_resctrl;
>>   
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
> 
> Better to write this as:
> 
> 	if (resctrl_arch_mbm_cntr_assign_enabled(r) && is_mbm_event(evtid)) {
> 

Sure. will do.
Thanks
- Babu Moger

