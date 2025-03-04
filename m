Return-Path: <linux-kernel+bounces-543779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D5A4D9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B9316E04A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043EC1FCFDB;
	Tue,  4 Mar 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JgS6NNDh"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023073.outbound.protection.outlook.com [40.107.159.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DF225D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083060; cv=fail; b=rlQjmXzl036HsvkQx0O0qNJ0LGhad/N78Pf81/LSUJG82TcxpvtxCd/NVcThJL6fOQOcMfUEvpTXiuA72VfPnizaKq/3iDcWCNBadKt3PEt6ajDrOco57MBW8pUMPKw0y37E64rQOQ8h5/TqJbKKisFAgsiWq1vYjbwiO7wtatM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083060; c=relaxed/simple;
	bh=wb+2s0FHKQxWZ7gvb01C/er3i7sLHrpuAYZQQInXYak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kpDa/OZXWGBB419/1vqbvDvcuW+7TC80yaX3JPyfZc3ntnNMPKQt7nipmhr1nx66EqdzL68MIz7tqLdcLG90ipBU56WCMpxulSXROnggHhk9jwfiAZXG0Or/QC4uhm2tyB6DwqXnqMRwyLB7JyNQ0Epo594klfSfwsOOwgps1qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JgS6NNDh; arc=fail smtp.client-ip=40.107.159.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEsmGkT7rBC3bjr9W9NBTxilOMtCRxxWZwPwi6EtKsRe40OAoblnT1q0SDAKiQed4olR/0fbLlUr83vdTvGnZ8I5BMvBJfOMRyaavzWkSMfFnlyQjXpoIA/cEHiqyC/2VwgalKZuLAIuIIieWhobsLCePwhJ3tccI2hMMdly2Ox7agJxGTOCEbuM0VzVijSZK1X7PZ+8JCsVASrJld8m5ZW1btjBXh05T2Zzewntm/ng4Jv1m+LOAISJnWHqDOrDE+mSfd0uYVZudU/WJTiKyebq2zhZc08vqWiiV+9x+UJV7ve3moAogSW/dGdGY1v2GoQaEc8/OH78bnAwGrLJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4WI6SHThyl0kFjXJzqGWgt6gDcdIM3nFzXE8ry6LHQ=;
 b=JClFlDekVOAesX3kWGErNEey2ZNkmGntvZTljU7CYbqSbkYfeIXliAn+Pyit8fq4iOjVusL0OOGluu1PudmzXYMB9JwyilWucXI4QAYU3Y9xBRWB1DRKco/gt2Vy8XF5lFT2JNOZDu8KtZ7bM/ArJU7B6eHl3ZBZ9oPD7glBD6tXSCsZzksKKs2TjTLdHsUFQO99+FhEzVaN50d3g0r31/y5MbJTsKyIXwunhHnptw71CLcVxxkrLAhpsMBCyvznFra3szspXWikp+0sapIXIBig6KSlBV3kfKhoe84V1JE0lV02Jjd7nsZxZFn779IrvF8aDXLu5o8EKqnJML9/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4WI6SHThyl0kFjXJzqGWgt6gDcdIM3nFzXE8ry6LHQ=;
 b=JgS6NNDhoTWCeC0DPQGvUBBeLqv4YAu5GzVY+m+CSjW9qahZvpXliuJq3urX1AFiVC/ZZZgdm17HviMLVBaBG48T0WxmaF52jisCYKpkRwkITWHIfVL6955O3zgEohhD3K1fqbkTlBxMe+wDQjbbHYV9Vcuq+oZUMMBBR7tbkLVcmxUOq4vXWArlH+lxgtrV5vW/nsn7K4wPBMptnfk0dy/LzSDhepT9m8noAVluwMAGn8ISlsqHhtFW1aJg7Mb91eaoTFKhRhP0H9y720S8djHCnfRup8dOg8fXKUllPMgWXGsbnFUmLxbwAkJ+1GD4Nth1cDaqQoq+/f3on0qCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM9PR08MB6099.eurprd08.prod.outlook.com (2603:10a6:20b:286::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 10:10:54 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 10:10:53 +0000
Message-ID: <3e38af8c-1d06-49bd-aa30-f4e8b0263492@virtuozzo.com>
Date: Tue, 4 Mar 2025 18:10:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/17] posix-timers: Rework timer removal
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.416552300@linutronix.de>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20250302193627.416552300@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM9PR08MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7a792b-44f4-4db0-4e0a-08dd5b04d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0U3aDhPMnFRb2hMTEVqWE9iZlRkMGVidUFLaEdGbjZSRExSOXBTUlFlQTR0?=
 =?utf-8?B?eG9wdWlWZTJzc01xanlwWlVuRWpiVWpLT2hpM1ZkMVBrMWMvN2psMGNKMitq?=
 =?utf-8?B?NHdNR0t6U2YrcU5pc1ZxeXMyR29vZFZPQ0lkMkJkT3RxYmVQYnZGRkdXa2lW?=
 =?utf-8?B?VDdWbmREUmdMUlhqWkQvbmdtNkZGSEV3c3VNMW45TEpxdXFjbVNnTjl6YThE?=
 =?utf-8?B?Q1gyYkZMNnMwRWtTNHFUS3hSb0RSOXV6MmJVbmVla2M0U0ZzL1ZndXdqZXoz?=
 =?utf-8?B?TGdWYStRRFYzc2lqbzBFa1NPcmVPRTlTUFFnQThWVUx0Ym9qMGR4ZVZ1cDlY?=
 =?utf-8?B?dWRRb2dQZ0dodWJlaUQ0c1FNclRmSlYxcDc5QUtwSWNsMzlodk1JenJvNmpw?=
 =?utf-8?B?eFlnUlpGdkhaQkJlQ0M3MElvdDVhSGlJRnh5UXNFRTV4V2N6K2RQNSsycklL?=
 =?utf-8?B?Z210V1NEVkJIY3k3Zkh1STZCOCtiVmVyd0dRdDU2NGptVEZzZFFORE52VEF2?=
 =?utf-8?B?K20zb2ovN2YxcmtaK0tCbmVjWmpucHVIVU5wUDFXaGRLdTE3dncvQjVtVlVB?=
 =?utf-8?B?RmcwODZxZTBsSUxvbFdEanJKYVJ1TmhnSm5xRnFrNFVmQzNnOFhNcXVRRGtp?=
 =?utf-8?B?c29wSVN0TUhOVkdNbjJiTGN3bklZRXJkZXNTVUlYbW1YRzluaW40VmhHNFli?=
 =?utf-8?B?eVg1MWVnWHljQ0RKSWRaQUlCQ3ZvT3FSOThlS3I3N0RFalltcFJFZFpZaHVi?=
 =?utf-8?B?c0I0MkZmVm9KK1FvcWdtNVh1eXlrTks4cllmd1NKSU1FZkRzVkRkSzExYTZY?=
 =?utf-8?B?cGRQaWpiQ0ExMVlBeHRPSnE3aHg1MnB2M1h6R2dxWklhM0ZuU2poMkpDNHRh?=
 =?utf-8?B?NVhIOFZ3WDJQYUZLbkc2Z2plNW9EcmxFWHR0ZS9Qb01BLzkxWWFNVUI1Uk41?=
 =?utf-8?B?TVdOcjRUcnh5eCtXYk55VXFHSUQ0TFVoYUx2N3o3TFRETzRkNnJzMUc1S25i?=
 =?utf-8?B?eElySS9laEh5QVV6U2NvaHo2ZnU4a0UzdTJEallOVC94RW82OHNkN1FNZzVZ?=
 =?utf-8?B?cDZ2S0U1RXlvd3FabUxYR24zRzN1dTJsbFZkUkhuWEhKQzUrbU1lMWNPcFFS?=
 =?utf-8?B?QXVsNnJQVUtrZ2N0M1ZIV21jWG1nQWQzZkxiZDltcUEwdU5CY2w2K1hoZlBR?=
 =?utf-8?B?aEw5SGN4ZHNCUHNWZElWa3VoNTIwUUVRaDhhN0ZlMm9sejdjaVltSkVEWE83?=
 =?utf-8?B?TXZ5WXFSVjdhMUY5cms0Z1lKSGEyNlZCbmp6T0JBc3pnc3c1Z2NvRmdteFF6?=
 =?utf-8?B?Q2xGSzFseFYyM1pFNHdZS045L3RwUExNeHdlZjdNNXFFQ25oY2c0VnpYeEgr?=
 =?utf-8?B?Q2ZZTWJnYmZ5TGRyUm9WajVGd1IweVhoeElCL2hnVDFZN3Z2WjVXa1ZleVJn?=
 =?utf-8?B?aENqYyt3N1BlRnZCT2tnZ2c4emFTQ05JbzJYM0VoY1VTZXdSbGVNb1Zia3Np?=
 =?utf-8?B?cm4xRy8ycGFwRmVMcGRmZFFrbHlDWHRzbkpuN2EvcjZvSTdLVjdkZE1xNEds?=
 =?utf-8?B?SU40VzgvamNmZGZsN3BrZmZMaG12dUsxTmN6R1c4RWdQbTNGeDRTY3BIK0Ux?=
 =?utf-8?B?WlgxTDdsUmo5Q0F1ZUVHQXFjcDQ1QVZKcU5LSmM2YU1QS05xb2FSaEFTZk9Z?=
 =?utf-8?B?RVF1RzdFbUJFYzRLbUk3cExDRHBGemxyWmp4dkN4MzVsVWoyeW1ZQXV5eTFs?=
 =?utf-8?B?Y3paQk15MUU1TksrUzhpOHhYMjArNkF4NkhKMEdNTUQxVTVzSW1scjBvRGhl?=
 =?utf-8?B?bnB6RCthenRiU1pxcU0zbmdKL0V3bjY5RVlpREpiem9hWTFnR0lFSjdkTEh5?=
 =?utf-8?Q?YacgMKNfo7zfb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dndNelBwNmxZbGY4aHREMllJNWV0WnZlL3ZWWEN0UHRjdnZSMUpZekpJbXNO?=
 =?utf-8?B?blJuNlNoQWtLOFlPNWJpekhtK05QNjYyRkc1QzIzdmhzdE9HTDg3WHFvdUdH?=
 =?utf-8?B?ZmZ2QVBRdWVCNHZ6NWlWUDJMbklTWCtZVjluU1FnR3FmanQ0cHd4V2ZBUm9a?=
 =?utf-8?B?d0djd3Q3enFVZnVyYWlzQ01oMHJGYXlwUFRrR1U3dUhzUS9sSkgyYk03UzRx?=
 =?utf-8?B?NDNRZ25rOXpYdERrT0NmTVE4RDhKRGU4ZFNuTVRuWmdGNlFUWlg1UEpETXFs?=
 =?utf-8?B?MjJ6eVhvc1FpSDNxVzBWQ3l4aCtQcEhqUFl5Mkt0T3JjOVdvdG9hd2VrSG9R?=
 =?utf-8?B?R1V3NHN2RWFqKzNSbVEvdVdESUtsSWtEWFc0RExiZkVuQkhKZ1RWYlR3czZo?=
 =?utf-8?B?bEo2WTQxYUVETEtONDlzaTRYUGhJNjhVTnJoNWxDb1dnM3Z4aDd2TmlFZFQ2?=
 =?utf-8?B?WURNeHN1RXYxWW0ya3cxT0NlemV4OHZPTjFFODlTRW1YdEc4bStZaWxGVSsr?=
 =?utf-8?B?NWNSOXlrdDhjRTBmTk1Tb3I1VXFiR1ZnVWo0aXQ3TWJHc3p2N3NKSXJuN09x?=
 =?utf-8?B?K2FoUEYycy9xYkFLaEMwRmpzbkg0d1BNUGMwQnZHNWtxMDhCRjkzdmV6UXRh?=
 =?utf-8?B?Y2FoQ0I0RElLVUI1NXYyeTZMd2l4bjg4UFJOVlcxTmxkSHNNZHlmSXF5Z3lJ?=
 =?utf-8?B?bDUzKzBHZHc5alRhb2sxSzlyV1dsUWZKMmV5M0ZHVy9HUTdBbkUzbjJXR01E?=
 =?utf-8?B?T1BsUE15dUZia1Q4a3NjMG5FOERSUGxYMGh3ZWdDeXhaeVRGUU4wakdydDNr?=
 =?utf-8?B?b3IzR2V6cXhPcy9vM25ZZ2ZrMURuTVcraGVYWHFyYy9yaGZaQktEUnpVbUpN?=
 =?utf-8?B?d1J3OEcyMUgyZWU2Q2U0dTMvb1VQQTVteXBKeGtMeHc4ejMyaE9SSW1HTnQ1?=
 =?utf-8?B?N2tCL3JQU0tpZEZMQW5BdFN2aGRJVlpXQ05VS3Axd3p2YzVZRVJoWWFHWFJL?=
 =?utf-8?B?QTMrblB5VFZzUU0zR0Q4QW5jci9JS3Jhc01zbDRGUVFId0c2MEYvTTVaT0h2?=
 =?utf-8?B?Nkcvanlkbi80WU8yTnZSZXpuVzlkbFdTbzNDVlhOWHZCTm9YcXpQNjFneDlS?=
 =?utf-8?B?UHZTRVNTaVIwaExNU21Qem5yUlM0NUdDY29DcFJGamh0WUV6bkxhazNEVWxB?=
 =?utf-8?B?WWRBMjcrK1hlbHlRQnhGbUxCS3lYNmlBb1BaZ01VVmsrSWpmSzBKOTQ1Ni83?=
 =?utf-8?B?bFhkdGxaZ2d6R1NrMmFGbGFsN01Ldkt5Yzh2WEcySVB0a0JreUFnVXNTLzlk?=
 =?utf-8?B?bzRuYUdyWkxOWHhuRW5vcFJiVWJybnR3WG40MXZCdFNsT2tZZUxJR05wRkNv?=
 =?utf-8?B?azVrY3dpVFVRR2VXWHdHR3gzaFlrR1lWTUNWQldOUXpSMTRYendZaXVWc3Aw?=
 =?utf-8?B?YjBTbGc1MGZlMWJsTi9rcHhKMU05dTJhVHU1V3lGNUFBQXFZMzd2TkFudlk4?=
 =?utf-8?B?UmFBNUZvbkY4R3VvQnR1OVJ3MStpVEl6K0MyVlUrb29DaE50Y054SGxjWUtG?=
 =?utf-8?B?UWhNakkxMXJsL0JzOFNzQVZ4Q25lNU5hTEtaaDVvVnZBUmNweXE5SS93UWx0?=
 =?utf-8?B?WUZGM0R2eW9QdFIxOHovZXhJdXV1ZFBqbGdSQ0tUYXJIb2REVlRrNkxRZjdV?=
 =?utf-8?B?TG9PTXJJa2hsMTJPN1dHNDBZU3cyTTM5NjNQYUI4cFczeWtUK1Y3a2oxTklT?=
 =?utf-8?B?aXpKU3RueUhoMXFUQ3A1aXNQbkVlOUx5dlVxaUJlZFZkbm5MQURIM1EwL01K?=
 =?utf-8?B?OHUwSjRRMTBkWVBPTFRzeEhJRDNSOVRLbG1ZVG50WUdDL2FHZW9WY1UvMzNi?=
 =?utf-8?B?aVlXaDZjOFp6Myt5Qjd6YW1JRVBoZC8wMlFLSHZqMzVXMW9ZeVNEV0ZaNk1O?=
 =?utf-8?B?cGZmbnJLZkwwcnRZUDNaNlhiNFViWWxHTmdIY2JEVFlGM0lTcyswTmNzNnV1?=
 =?utf-8?B?cG5mdWhHRnFTYmxDSjZGSE1WNW16d2ZJUVVpeGRWc2s4T1I3RzBxVlpGTGM5?=
 =?utf-8?B?VHhPYUc0dVo3UmtHa0ZKaGFBb05wZEhMT3MxM3dwYXpQRndNQWw1QkpMWk5h?=
 =?utf-8?B?c1ZKNHpXWXpKK3ZvdllaTkF5cTZnRjBGS3R5QkNxWDhkbGJ6NlN6NjRselVi?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7a792b-44f4-4db0-4e0a-08dd5b04d8b1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:10:53.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSJmR9lE+bFIdPRNRkaXAB7FzjrxCpLxOAUGPrIWh5HecQ2w1k75Hbn0jjKSssyE3IDAzszUpMMumg5ZE9NuV9xDvmvoM4ks2F9C/ivROHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6099

   > -/* Delete a POSIX.1b interval timer. */
> -SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
> +static void posix_timer_delete(struct k_itimer *timer)
>   {
> -	struct k_itimer *timer = lock_timer(timer_id);
> -
> -retry_delete:
> -	if (!timer)
> -		return -EINVAL;
> -
> -	/* Prevent signal delivery and rearming. */
> +	/*
> +	 * Invalidate the timer, remove it from the linked list and remove
> +	 * it from the ignored list if pending.
> +	 *
> +	 * The invalidation must be written with siglock held so that the
> +	 * signal code observes timer->it_valid == false in do_sigaction(),
> +	 * which prevents it from moving a pending signal of a deleted
> +	 * timer to the ignore list.
> +	 *
> +	 * The invalidation also prevents signal queueing, signal delivery
> +	 * and therefore rearming from the signal delivery path.
> +	 *
> +	 * A concurrent lookup can still find the timer in the hash, but it
> +	 * will check timer::it_signal with timer::it_lock held and observe
> +	 * bit 0 set, which invalidates it. That also prevents the timer ID
> +	 * from being handed out before this timer is completely gone.
> +	 */
>   	timer->it_signal_seq++;
>   
> -	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
> -		/* Unlocks and relocks the timer if it still exists */
> -		timer = timer_wait_running(timer);
> -		goto retry_delete;
> -	}
> -
>   	scoped_guard (spinlock, &current->sighand->siglock) {
> +		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
> +
> +		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
>   		hlist_del(&timer->list);
>   		posix_timer_cleanup_ignored(timer);
> -		/*
> -		 * A concurrent lookup could check timer::it_signal lockless. It
> -		 * will reevaluate with timer::it_lock held and observe the NULL.
> -		 *
> -		 * It must be written with siglock held so that the signal code
> -		 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
> -		 * which prevents it from moving a pending signal of a deleted
> -		 * timer to the ignore list.
> -		 */
> -		WRITE_ONCE(timer->it_signal, NULL);
>   	}
>   
> -	unlock_timer(timer);
> -	posix_timer_unhash_and_free(timer);
> -	return 0;
> +	while (timer->kclock->timer_del(timer) == TIMER_RETRY) {
> +		guard(rcu)();
> +		spin_unlock_irq(&timer->it_lock);

Maybe "guard(spinlock_irq)(&timer->it_lock);", since we already use 
guard constructions everywhere else?

> +		timer_wait_running(timer);
> +		spin_lock_irq(&timer->it_lock);
> +	}
>   }
>

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


