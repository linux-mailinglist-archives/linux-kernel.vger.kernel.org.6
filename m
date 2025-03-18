Return-Path: <linux-kernel+bounces-565481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A4A66947
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B6917BA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2951C3BF7;
	Tue, 18 Mar 2025 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tw3d0SEt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022191A8418
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275714; cv=fail; b=gFr1DayVx1KPUrPFvzPrvkDYhwh3P6Jl2B9ZpzHTE43GAJPwan4CBiR+2fvLkGD5e+1FpnvWAPPdIvHoifSUfz2yRJ2PTsSqIxYQboDpJNBFHPG2cp0aQ776mSXo1xBfPuwAuvId8lWjq19MNEUahZ3PLfA/xgNLFyX3L7ronCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275714; c=relaxed/simple;
	bh=cXYGGEaBR5+Fxi7zivzzEIAx1E01vaVxWGxCD/y+TTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7pk+YmEEY257xieAJ47B78FaJf4pBrwb/hvNdsoA9hjsAHlLeErTMeeyCMw/uEGKBq3Qr9KYbGu6rwKY66DjCg7d9ePZq8++dRSXKYtlnq8Ejkwr/8POpw+wXH8jxemY8DCWBNVEnW5zHCEX5Gsnw75MCJHYUK/kChZxRe5Bto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tw3d0SEt; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzKUzWnq/2AXnU4UkDABtu5tDxMFJyTiPhgapj/hZvYN4RSCwPGsMf4cakKWkyRkLGz11rNH5aKHYSoWQqWsw4j58e7WfH7Pk4eCcTJm3EDMVJoiVuRuK/XWppJhHXVRXe5A2zCwndhNc0EpRoyA5IOYofXsSyDFaT1iqVcIqdDT/gl5ulU0dHzppkX79AbuTG1IXo7PczpkKYRddhFewYqrFc/MjdyYn54OaeMaBiAgPqJZ2Tmg1Th4I/WJGJroLlHMmCto5XfI/Tnxf/yk13Tn9KF0+D3hkusWnJbkyx20G4YKldSijjDb+F4RzOw3CPqEYxmfVaEJ9sNEuMhg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN1drYYZTU9Z/REN4P/u9ZBsaEQ1eAS6N2t9UXzVZWs=;
 b=ohLCWav7wmCtZdEEjKxQI1pny0Wl6Y440mRKTVhNTrurjyZ6a/F7cmXAnhe1A0dw73Z73cjaPuvYTcm0icU+132ATJo11XnaNGvI/u3iBwHZb/Jx21iHhPmO1Uh2wAvTv0ivqi78Wx3zBHcdhS6t05RkkE0MFhwKIMv6poJZ+wGUeSdUGGeKtiQVW/vfMcxy3a2oJh+NqPUsGiZWxM7AkIEbm77Ew9ot6DMlFxYEKZxI8MXZatLlOMLxJ2/9PdlFk0xLmyRV9eoSSUjvEDST5d6XnuSON8rxlkqeVfkpaYS1IbLdHVpwKvUnjplO7rx2akXGEbe97XpS8DDtP/fgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN1drYYZTU9Z/REN4P/u9ZBsaEQ1eAS6N2t9UXzVZWs=;
 b=Tw3d0SEtoIKgCSbtMPWxSncdYL17Qg9dlqIyvJebd1sWu0LjQ5HVGtJ3zs1BaLbrPFaeYNbiazswZ0iqjxFRC7dVfXSp+/cwsDlXhI45c6+dEfah/Kv3t6EDxuMHY6VkdwZogAe+rRMk4QIxSPf4Klqf4td0efdf9txgVvCd4YJ8CVNkksCe7LYSZqlau8mujR9M7blTnL7vWBPz+ObcWwnwhul0tH+kc3DbfPVoeg30410/cJxbkuJYl9/o4+4nIJc4Pi59qMHvaW5ZgUuByq1MZYZ2BI0b+mlXgSfBLIxFIyyckETyv3fUeGLHmHn9FXyBTRr0Opr7F2fAovixug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:28:27 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:28:27 +0000
Message-ID: <c6d9bd1c-9ae6-48ff-88ee-1dfe25eab5d4@nvidia.com>
Date: Tue, 18 Mar 2025 16:28:16 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot
 pages
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250306054532.221138-1-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 3973e877-05b5-4dfe-394a-08dd65ddb64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFVQR1RPeXpFRzhudXRoMVlHQjkxditYbXRiU2JmS0lqd1lRaXUvaStjc25y?=
 =?utf-8?B?VFgrNjhUQkxqNE1VR28wUXp2dW1wdFlEWkxQZjFzamorMHRNYXc3amUrNWtM?=
 =?utf-8?B?TFRxczc3QXEzUytKckFUVUZ5b0huYjAwUlBpZ0dXUkpFU0tKU1ZZTkhNWC9x?=
 =?utf-8?B?Ym5yaVBhQmlnTk9PYi9tQ1hFVDlVTlFnM095Y1lHV1dMQy9NaWkrdzMxNFVp?=
 =?utf-8?B?MlkzanNDY1YzR2ZRVS8vblJOQjFqbTZYejB5bWpJenovVmNDMnJ0dFo5QUFD?=
 =?utf-8?B?ZkhTQVZyZDkvN2NXbGxqQmhoa1V5dDBnazI2bU4wZzU1bzRrMkZHZ0lreWM4?=
 =?utf-8?B?TTAydVNJREhDenFqVVIreExxT09kTmZ6T1A0dWZEbTR1MWR6Q2xQT2k3TnYz?=
 =?utf-8?B?K25NOHBIN2VKUXM2a3oxU3BTRGI0OVcvTnkwSkpwM056amJjd3BnWkxCeUhR?=
 =?utf-8?B?VVVRVWZ0a3l3bjlUak05SFNqMzBWNTJ6UGw1RWloWHJGcElEd0ZLcTJGUXVS?=
 =?utf-8?B?RWFTNTErMjdCRk1lTkQyVk9UTHp0U3lYNWNRY2tFYW1SelZzZks0VEpWbXFo?=
 =?utf-8?B?aDJLN1JtZWVYNDRKakp5MmxhcVZuU3dxVmlwcDJvMFFlQzFHNmZST2VzdGJI?=
 =?utf-8?B?LzFSQnZPUzNKSngybUNEY3BGaVRJYllVd2xBYnFETmFNdVJGMk80UXcxWjdT?=
 =?utf-8?B?TmxIQUF4VXRnaDdiZFE5VWoyY3VUQlhKLzF2SE1hNVRTWUlFbWFNQmhZeS9x?=
 =?utf-8?B?NTZUZU9GQlphOW12c2FmVW11OEFNRExzZmVSdU43NTNTLzBQbitBRDFVN0t5?=
 =?utf-8?B?TjlVMDhYQXY3eUxnTnhtRHJqN3krTEdwQmRHRzc2WEVwblpMU25Tc0ZnNmV5?=
 =?utf-8?B?dWdFSzRsRUl1OUpkRGx5RUxobElIaWJSMzlLWkViS1VWVmRsRmFtQmxUd2JO?=
 =?utf-8?B?bUxPY0VNenNGLzJVVm9TQ3NHS1dKL2I4REpxbnlOVnpiZDVxaERxUU5la0VB?=
 =?utf-8?B?bWtsY0Q4YWtIYjhMaXQvNWgrRWczTXN3WHFFQW5XNDh2OFRtcjFVWGsySTFz?=
 =?utf-8?B?LzV2NWpMa0VQU2E4eFdSbWZheHNjVy8zQyt4WWZXRDU2QXQ3cmRnd2FwTnR1?=
 =?utf-8?B?UjlMczcrWFdtcUxyVUhLSnBoY1pYRUZVODk1eVdrS3hIaDFaUnlMKzRwR3h2?=
 =?utf-8?B?WnhBeEpBeXROL3JJUlNRUmJQNTZxRmxUMnBwaFJSM2JGTEZEK29IQzQzTjA1?=
 =?utf-8?B?aXJ3Q1laRnJlZUNUZExid1M3N0FVQmYxUTZrc2NtbjJVVmdweVRnUWlwM0VN?=
 =?utf-8?B?OEk4ZHZKL0ZVZzZWSzBVdGI4Y0MyNlNqOE0zU3ltMC9qTlhMRjhnODJQNVhu?=
 =?utf-8?B?THk0L2pFNENFV0RIdVlIZ0c5Tm1lRWVxZVdDeXdNbEdZUzgrbnM4alM0SnhB?=
 =?utf-8?B?NS9KYnJVM0pDZnVvMkU3bXRnT1pTb3hYQSs4b2I0RE1jY3l4WDc3bDBhVGJr?=
 =?utf-8?B?ZlE2U05XaW5vVW1RSXEvNGl2S1NiL2FJckI2VnlZTDVNNnZkNlVnM2dDS3pw?=
 =?utf-8?B?eFZqbkkzWnVzTTdoRTdPMldkSDV3NnlyOGNiQ043QnBnVkF3dFcxNkxjeUdy?=
 =?utf-8?B?RnlUMmdQa0dMK0VsMWd6blBUSkh5WFM2VDVKc2Z1QVJ2eCtFbHJ4R3hPd0g1?=
 =?utf-8?B?ZGRBOC9Za3RWZWFBUWJ3WGtUZFlEeXQ1VWkybk1LMFJFREhmaFZYOXZuMzJu?=
 =?utf-8?B?aU54T0MvV2ppeC84MEM5bmZjNkVrVitIQUIyN0ozVTRnSll5dkZQTmhMd1pG?=
 =?utf-8?B?b3hwa21ZWU9yUVpteXVjTmNjY1NDN3lNQTdZc2FOdlgrbGtTeEovY3NHNGFi?=
 =?utf-8?Q?aczh4oSJZcUNK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtsVGNBK2xEQWJCcE5NNFY2VTZYVTMxMjUzV1pLMmpjQnJrNUYwZ29pQ0gx?=
 =?utf-8?B?WGxNeGNWZDhFWXMrQy9UQnRDUUVXWDRhWTdHTXZ0OUZ5UVJlRndBb002Tlh4?=
 =?utf-8?B?a1BkRVJzKzZRQnZjZVJMcTZqMG9tdlVPRlNIek4wR1g2c3I3bURwT0I4VmNL?=
 =?utf-8?B?VWliUVFYdXVsTElqK2FsMHp2WVJWRkhpUXg5ZG9ka2ROb0w3NkRwUWdxVXhD?=
 =?utf-8?B?V293QXdCbXltZ3R5V21jYXo3TG1wYm1BekFIb1FwWHhoa0xtRlYwREZya2d3?=
 =?utf-8?B?VDR0eGd4N2QwYkl3SmxBUlNxeVkrcnZyTGg2cW9LUHlRMm9VR2tLOUl5QUpS?=
 =?utf-8?B?OTFvWVlEUk9ncGFVbDROb2hiclN2OHcyOFB5dlhRYnluaFBqOFFqUjFiYmRv?=
 =?utf-8?B?Z1hGZklXcWdud3VaSi9NRFhKWjZEZ0c5MnBsK1VxMkoySmVmc0VKUDBmMzA5?=
 =?utf-8?B?aGZCZEhRT0d4dzF2MW1naUU2VlNGNmZTNmtnbENBY2NKa1VzTWxyb01MTlFH?=
 =?utf-8?B?U21CdjNkdmVmdjZVbVlEdXZYbXlQaXlsNko4SVlnSGVaVG1oNTRGZitiUjBn?=
 =?utf-8?B?S0ZGMG9mSGYwOXlNQi9WelBVVDdGNzNxSG9OeDIxdWlnZklVS3VRaHV5anRh?=
 =?utf-8?B?SGNJdVFueVlIaXlQTDlNcC84UnhWdHp4R1h4bXRHRFZVUThEQjVLNldnYjBw?=
 =?utf-8?B?c2oxSnJ3dmxvRTE1aC9DaU5qaTZnMCtFdWFuV051cmh0ZEhxLzBQalp3ZEtV?=
 =?utf-8?B?dCtTdndRMzg5NHVscjh2aHZ4OXhuZDVXLzRpdWZreEpDUlJUTzZuU2xCcW9X?=
 =?utf-8?B?THpUZTJvc1JEMzk5TGsvaHhsWStld0lBS2lraGs4SjhsWmNSeW5BbUllL0R5?=
 =?utf-8?B?V2NsSlRBdkErWTNDWWFhcG1HYXczRkthL2hUWEJ1QmNKcU53b0lOeDhSLzZ4?=
 =?utf-8?B?NnUxcTRRMWtsV1dlaDVBbVQyZGVXbGF0cGtVRTd6c2J6dkQwWkZKNUtRV0Rk?=
 =?utf-8?B?SDV0MzF6L25aVlFUMFlTZERTUkljYll2VVVqcjNmelY0UEpuSTBIbkNjOVZY?=
 =?utf-8?B?QTh3Z2xScWNqdUxWamQ0anRZaTN5SkNTQklGTUxhRkt0akZ4UmhneXF0cDkw?=
 =?utf-8?B?allDcWI0aXdRME8vQ0paSW12cVllQVJHK2hQcFZrNlBFbnRBMzdmU0RvUGFT?=
 =?utf-8?B?Q1A2YlBCOGY5Nk5nRURrZEdtWm9rL1phQjJEd1Q3bmFVZ0RJd1FONVg2UW5Q?=
 =?utf-8?B?MGwxaVlvOW9KZDF5WlRjdEN0bmh1Zlp4OUVLM25OY2xyUUZ3Y3o2TzZ3Wnhy?=
 =?utf-8?B?MlVlblU3SWlMTVQ5dSt1WXBoekRxZHVXd1Y3KzdMSFUzN01OVkdWdERmYytF?=
 =?utf-8?B?TzlaWUYzWjNFTTJrb3gwU1dMK01jRU5RdnVVSy9UeUtRWmtNNVdNYkNwdERz?=
 =?utf-8?B?cjJkejRURHJFYlI2SG80VGdxdGpaOU1mRnNFK3M3ZG90UWc1L0Ywb3lya1Zm?=
 =?utf-8?B?OXQzWXJiRWFoazVpZW5VcWtIZnJTbTh6RlhvL3prelBIYmc2dXMxMzFCRDIy?=
 =?utf-8?B?bC9mVGR0dnFqNGsyN1pFak5vS3ZHTnVwR3lVcXQ5QVU3QjZMdW9rVDFlaTl5?=
 =?utf-8?B?alFZNDBJeStVM0x1M3BLSjhhdmh4SkNOL0VEblpsWUFkSkNxc2xrNmpwWDhp?=
 =?utf-8?B?cGZka041ejFuODRGNXU5bWp1dUZlVk5iZitJeUo2OG9LZ3VaQmVGRDZ0M0hE?=
 =?utf-8?B?dkFRcGR4Q3JodjZTQ2V4bFFLR1AzT2lmQWtya0hhbDNQcnFTVzNiRFhDWnJi?=
 =?utf-8?B?SXJHSzQwcmJYQTd1UDZiaXRpYjg2RE1CTDhNL0J0d0tSR2tuYUFyWUgvQmhX?=
 =?utf-8?B?R0hKNEp0emhOYm5iMWtoVkN1M0lwV3Z5VzJ5NkIrdU5QSGpXVUdlVzVkVDdv?=
 =?utf-8?B?VXVsVHQzUnpFYU1yQnFieHZPL2JpQXVGM1Y5RUEvMFBleDlrSGZBYTM3TUhx?=
 =?utf-8?B?eVljcmFzVEtaN3JPaVBodE9lMFNWYjNaVkR0RGFBV1R1YXB5VGlqRVpTZVlv?=
 =?utf-8?B?dWJ4QTRoaUg0czZhLysvL3VzeE9iQWtYTG1qVUphY291SkJoSCsrQndhQXdZ?=
 =?utf-8?Q?MN9JJWNFV7TLdTr9ULIAfcPN4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3973e877-05b5-4dfe-394a-08dd65ddb64a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:28:27.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k99l8KQr8aDSjRtig80zMYJO2pVNYrWwPk9eW2FWmG+bjhWEXmf24oMBFKi79JlspDPrgBE5QZC1nb7MYoRbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595

On 3/6/25 16:45, Bharata B Rao wrote:
> Hi,
> 
> This is an attempt towards having a single subsystem that accumulates
> hot page information from lower memory tiers and does hot page
> promotion.
> 
> At the heart of this subsystem is a kernel daemon named kpromoted that
> does the following:
> 
> 1. Exposes an API that other subsystems which detect/generate memory
>    access information can use to inform the daemon about memory
>    accesses from lower memory tiers.
> 2. Maintains the list of hot pages and attempts to promote them to
>    toptiers.
> 
> Currently I have added AMD IBS driver as one source that provides
> page access information as an example. This driver feeds info to
> kpromoted in this RFC patchset. More sources were discussed in a
> similar context here at [1].
> 

Is hot page promotion mandated or good to have? Memory tiers today
are a function of latency and bandwidth, specifically in 
mt_aperf_to_distance() 

adist ~ k * R(B)/R(L) where R(x) is relatively performance of the
memory w.r.t DRAM. Do we want hot pages in the top tier all the time?
Are we optimizing for bandwidth or latency?

> This is just an early attempt to check what it takes to maintain
> a single source of page hotness info and also separate hot page
> detection mechanisms from the promotion mechanism. There are too
> many open ends right now and I have listed a few of them below.
> 


<snip>

> This is just an early RFC posted now to ignite some discussion
> in the context of LSFMM [2].
> 

I look forward to any summary of the discussions

Balbir Singh

