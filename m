Return-Path: <linux-kernel+bounces-183835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0B8C9EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D783E281C61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB813699A;
	Mon, 20 May 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jx91jR7l"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1613664D;
	Mon, 20 May 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215128; cv=fail; b=EGIoY1nsqdm1SLJQ11/jx+0SdSwx5ckHfNItfy26IDVfQWR5AkwOsJ3zCLyIgtO/iD1WbY/L9of8qUGEWZK5SeKzfsq62szpcxQl7Rh04dMtmTOPte++lLe/o9kzBB3V6aFahB7ofWsWQasm0T6tP8WdJA2Ac1ByRhQrW1Doty0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215128; c=relaxed/simple;
	bh=EFdVXlIQSSS8r23SSTRzfkQaZc+or5B/RRxQorSeLoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=stQW5gzLui3KJmQxe/9wXvcOB3XrFLwf4ix1gA20Zdot2H2nHMxt4rWrlY0Z0ZTe+xlmcbqVHYd2BAu3Kh8bcN7O6AhyB2TVO5ebs6kx192weWkQgW6AFzJIy90Uqml6Qbgg2WIGA7amfE7XKux8UdXpzB0NROGl4HyHEWxIzs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jx91jR7l; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0l1Jgmu8oEQ4LM2ZbMQ1WmJ02Oodg+nYEpJgXzGhAtA/LyyN85CxdTNifSyYpxPYvduyDOa0+c8j7tdSyrzNQSvccmGnU0O6n04geQm3U7WBVlNKhT4dp98aInXeD+yKELYgHA4qJ5K94+elcpcAWmoxtfzgTGgQZR5E3kJUsmS1kBble0+Ds7QbLs/mbToKxxzFSk567bIOvcCKa60klnISWfPAdz5hKp7AnSkpz0R9+7M9E8yR/OIdlnyv7v3OJrPaAAB93iWpDM01hs3ZQEOlgqCNymagdvEiUE3x7LS7IFoJoeL+wQIV5y3kHXeyd1HIPzA3ILBjiZmPwfcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA8J8TYyRGrDH0tyARAwBPUSNrUuHiy5lNxd4CDQ7Xc=;
 b=B8i6J6jVHBZg7Zs4xbBxmTlxw6AOf1VBgzKC4EUVvHoT9PzC7fJRsfSIPk6Zr0ZZrPrbfXkvvuk7Qc++DZ2246Z0SXFwWR8HsIMa8h6SeEAy8QsTfTnBqeO4pbT+obUQOU1KFYKpKisWHMSJmqZyqmS6m/W06LiJaTeIdYF6PlmHEjfQKH/Uuw4xJoDjBqdBVt/6wkKT/APX/oPV9pCTUa3Q6++6Du04TZUpGtnYimit++VDQ63k/+2sU4S0nNWUzmfZAg9KfBSm4/A6ClgQfhXPHLl84Yjl1zBRHSfy/kMViR3GO62ba2UlkUIiLWtTgi8HIDjjM3BUW9H/WR7AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA8J8TYyRGrDH0tyARAwBPUSNrUuHiy5lNxd4CDQ7Xc=;
 b=Jx91jR7lIFuyltgIdhG0+KDCw+7bM1hwqU70LftigIR/h6ByODkBM0RX/35G6WNkOt5mu0a/+1Q8vUy6k71pjJ/NufDvFxqWZTuDBb+AIefBmZ/F84X92oCHb6lfK5Eh+jpBmzCZmbevJ3xFnXUBN4YjjornOcWRfGB2CmsJN7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 14:25:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 14:25:21 +0000
Message-ID: <fae7fd93-27b7-4f94-964b-9c909f85f2fe@amd.com>
Date: Mon, 20 May 2024 09:25:16 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
 <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
 <d7f3c5b1-c39d-4c66-92c3-5b096b9e0579@intel.com>
 <CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:806:121::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 26eed1f4-c545-442e-1ffa-08dc78d8ae21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1lPcTFqOGx0dVY0TERac21VUjJGOElhT2lsZWpXelh0clpubFk5aE9yOTcz?=
 =?utf-8?B?VDNwK0U0OURweHUweDcrUDdjZ0kvZm9TZ2JYQ3NVbXd4b0lhRUNrcHVpUkx3?=
 =?utf-8?B?Q21valk2MjZCWGJaRkVidkJ0UlM4WTU5MmF2c0hxZWFub3h3cDB6cVZHZCt5?=
 =?utf-8?B?VS9uWmJaV2lMQ2dlRGNnNXE1SWtnMUVQTDNNcXZ3c3MveTZQVlpDUndBUm0y?=
 =?utf-8?B?Y0NwOWhxa2djeVJWU1lwNXdRdGJyMk5jeUVqcjliRzl6S3loKzl0YWNWbE5D?=
 =?utf-8?B?aDRZUWF0elhMNHRJODJDeUdaWVdNS3FyZVFXWVk0S3VnTG1nUVkxSE1jbG5a?=
 =?utf-8?B?YWYzM002LzhvS1IxeVY0d1A3S2VWZTIrUmpPSFlCcW81L25tTFNxRVNNMlFZ?=
 =?utf-8?B?d2RkY2lKelJNSXV3SEtqaTFKbUNUcDVmYVYvK2dYMjVUb1BnOGY0aVUyR2xD?=
 =?utf-8?B?OUZlNXlkLzhhbzJZUVNtamMza1VIcEZLdTdteDk0SzdwVTJ0QlhNUkx3NFlO?=
 =?utf-8?B?R3dLU3E5NWdKa0ZvQmhIMkFzc1R4WDRwbEtYdngvRjJtMnVCRkd3UDFUTkVk?=
 =?utf-8?B?bG9oMzgxYWdZN3JmNmZDSllITWlpRS8rSVdCeDJ5djVtU2QwZzNVNW5JQ3l6?=
 =?utf-8?B?MEc3NFFzS3FLQzF4OWQ2UW4vY0puTk5HTi9PdHhvNThqS3drbmFJYmUxbnk1?=
 =?utf-8?B?RTlaazlHVm5QZEFvVEpab1hZSGNRTXhmVWRweDdVV1BoamtRc1J0UGJaNEpT?=
 =?utf-8?B?ZWIvc2NNcVZVajBQZUFWKzgxek5hZmhVTEl2Smo0RThxTEpFUEUyNXlrT243?=
 =?utf-8?B?cHJNZzRmNXJqNnFYWnFnUENPcEx3MnExUU9MaHBQaWc3V01mQW9RaU1vdjN4?=
 =?utf-8?B?S2tOYm9GakRwazF3WWlNRzBxOHNnMW9mckEwVEJpaWRPMW5lZ2tWRk9IOFdl?=
 =?utf-8?B?bFBRWmsyQ2xMOG1Vc2krSXVCNDd5ZkZoTWxRc2VDWlA1T2NqYjJuSWNWMG1j?=
 =?utf-8?B?Ulo2Sm41N1JscTZQbmRNR2ZwalNzSDZCVG9yMjdlM3VYZnVqbTBFWXJHdGx2?=
 =?utf-8?B?cW1idXpieUJ0RGZFVVRIME0reVBHVHZJWkkrSkZYQjdJYXFocUlzdVZrOVdm?=
 =?utf-8?B?M2V5OEhubk5Lc2YxTmF5WWpZTUNldExhWkZPdGZWaVhOZDlsbERXdy8wdjBn?=
 =?utf-8?B?eGNUSlRtejEzVG5pR09uMnhEVHV1dGx4ZGY2cHhaOFhMaXpReXptZ05vbzBX?=
 =?utf-8?B?RnBoL0FUQ3RET1NRUER1MWt6WHIvTjc1OWluQXB6Q21TU1FhZ1JlWC9lSVlI?=
 =?utf-8?B?SS9oMFZ0T0pJVzlvbjY5eWFscXA5UkFLOW40Uk1iazVmU29PNzNIUG9lRmlx?=
 =?utf-8?B?TU1MNzl6MEcvSDZycnZieVN4Y3Fjc3VXellTUTZFV0lvdDQ3eTQ3RzBuUDZv?=
 =?utf-8?B?NDN3UkpaR0RuU2pmUTlXanA4aDhDeGgyRjNyMThSaWJWWGZrMUFvYzMzSWpV?=
 =?utf-8?B?d2ZqNVZWWi9aRUFrRW9GNFZaSDRFTWdtUGFUcnZYQUpnamVmZGFId2hlN3No?=
 =?utf-8?B?OFhTM01BVkhLTnBIOTlJR3UvaHdkTG5BNFgzT2ZZSW1wamdnMWZyTWcvOXl4?=
 =?utf-8?B?ekxZUUNSblVtMU9YMCtIS0tiVTd5bE44N1dLTFBkMHRmc29ERDN1aTNPK2Vi?=
 =?utf-8?B?Z3BPbmRFMU93NXpjeUVtUFl6a0JjMzVGUE5rTHVQNjR0ZGVDNklRNGN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpxNnB1NHNMUDB0eXQrZVM1eUZ2Wko2bjRBelFrZ2Y5bkgvYzl6NU5lUXpl?=
 =?utf-8?B?blRYZ0dOcWZoOFhBNEdZa2hWL2d2VjhsenBwdG0rc0RVZFRGNWNLNHRSenNS?=
 =?utf-8?B?YnRHanNqSDMxT2pjaitxS29FVXVXbUZnTHJKTytGL0JvWGdCU2RmVlpabnpX?=
 =?utf-8?B?UzdxM3lrTkhsL0dhRGsxS0l2REZ2K3BiUUxjSllrRHdTbStrN1l0OVVXYzFN?=
 =?utf-8?B?RldYRTViVUp4RFRYSW9rQkNlaWF6RVlpWlg2ZVluOU5OZzYzbEp3K3VaUWVC?=
 =?utf-8?B?Z0FCZURyTkk0OFlaUTJPanN3NStUVFppcE1FM0ZZOWE4ZEUrelUrYWI5cjFB?=
 =?utf-8?B?NzR5Y1dwQVJvRXRtUGdYemZYK0xwTmh2K3J2N0JqdUJJdkpXMEtZMXdiQi9s?=
 =?utf-8?B?Y1lJeEk2eVQ2NWorM0o4SkozbVFFbGtUV2RyNWg5R0pGMlU0YmdzbHpyY0R6?=
 =?utf-8?B?cFl4VVcwUUR4NXJULzRKVFRES1ZSRlJFdzRQKzhvM2pCMnFUQ3duMXNWOEkw?=
 =?utf-8?B?UkRNcEREeU8zYmdIdk9LdUNiWnJZaStOeWM2ODZ4Nk9wNi9Ddy9WbTJ3WTMz?=
 =?utf-8?B?YU4xdHQ5aStuZ09sbEx5dCsxbm92WHF1MXhpZ0dwaXd6UUFCa21UeFZCMHAx?=
 =?utf-8?B?QUNOam44WmVsWmVTNTNhdGtrU2JJOFNvVDlBT2lobVZ6Tk93QkpaSXRVdHlB?=
 =?utf-8?B?YzZEbmpRTFI3M0dudGpQcU0rdkQyK3gyWnJWazRHZk45TWJYS0N6emxzMnZI?=
 =?utf-8?B?b0d0ZU1YcnlXLzRObVhTci9uVGxKTjh5NzB0RUREZ3JveEYvOTVhN281cXJz?=
 =?utf-8?B?UTF6dXR2UXBLNlZ1QzI2dVJSdEVZSG9RK01jd1FON0ZrZWZHRUtsRjcvTHBP?=
 =?utf-8?B?VXdDamZDcjNFSkREWlNmOUZvaUdlQnFyanVaaTVScEtTSDdHOEpEaEJ1V2g0?=
 =?utf-8?B?eFRBbmhlUUIrNmxpcGd6Z3NVb25xdnFRbnNFa2gybUFoUGphOUNIRlRES3pF?=
 =?utf-8?B?SFhHTFdOdWZ1aVZKMS9wRGdQckJxcFEzODBYTTByQU5hS05UTSsxbFpETGZi?=
 =?utf-8?B?NzVldzJZS1BoSFpHY2VCdWZIcjVLY29VOFVzYWZJdDEzNksxUlNjdk1FaldM?=
 =?utf-8?B?VXl2VnByQzgrLzZjWUNOeEJ2WjF3bGxsT2lZWXZjd2NLVlI0WmpOMUVPZDNy?=
 =?utf-8?B?YlV5blFpWlN0TzdpZlBmbkpReGVOZ1A5dmNVRkNQa3NnRDBCcFFXWVdaN0Vs?=
 =?utf-8?B?M2hraDZXSzVCQ1Z1bW5icmx2ZUw1T2RjbStnVElKZjdZb3VZWFJXaGJmak1J?=
 =?utf-8?B?bDU3cU5KZzg4UjgrZ0NoT216T1BKWHI1VWYrbzg5UDRYM245TFpBV3FSamJO?=
 =?utf-8?B?L3Vmb1M2YWJnSnZOa2N0YlgwZmMwdkNGZS9zYXlBS29NODdZUW0rc1dyU0ZD?=
 =?utf-8?B?eHh3WG9DN1Q0M3h6d041Z2JUMGx4NkNxSVdBcWFPZjVkVHU5S3BLVjhRVklk?=
 =?utf-8?B?QlNVV010NlAranVpZjh5bmxrcU1FZlpBWjdyQ204RERwc1FoazVQZnRURGRm?=
 =?utf-8?B?RVZKb05YUlp0WTc2eHkzRXFTRmdZa1ZNc2Y0dGdnVUw0c3psaUgwTFdCNTFt?=
 =?utf-8?B?RkM4NGozMG9hMTQrdmpzYVAyYzlnaWZmd3dTTk9sMC9Jc2wwSlFIa3hCbllV?=
 =?utf-8?B?dEtsVm92bk11djkrWkNJdjUzY2MwVmFlQUZXYjg0b1ZJbmZBUnJNVFNocjBF?=
 =?utf-8?B?TU5QbUVkZk5ZcUk1b1BJV2lpNzRrc0tNQ0JPa0hjZGo4TFJWTmZvNlQwQit3?=
 =?utf-8?B?Mkg2NWxtenhEaGlKVTJ0NUhDUXdWRjFPdmVYOVFpNkR6eENiWHpRS3dUVlhz?=
 =?utf-8?B?cytqT1dzOWhNbFJwclhvbmZlRUNkV0tWb0dSek1LNEhkNjNoTDJKbGtVMlp1?=
 =?utf-8?B?YzNxcTlGNmdOTHhKZDUvQXJpMnV0S3RXY05YQzNHcXVTaEFoaEd0Nlk4UENV?=
 =?utf-8?B?VGZpdEd5Umc5WFNUb2NibE5XZDBxenoxeHJoWDhrZjZ4M0JTUjdsQWFtem5h?=
 =?utf-8?B?VGFvSUtwSU8yVU0xNGJ2MUZPNWZLK0VFczgrY0NaMHdUSmM5VUhkYU1XZjl3?=
 =?utf-8?Q?UoWw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eed1f4-c545-442e-1ffa-08dc78d8ae21
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 14:25:21.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwMWMyA+L/rc0C46/+zl+cUcwRVAsxxfsO+jgtyTyblUAsHb0s/xOyqEb1CTjyPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547

Hi Peter,

On 5/17/24 16:51, Peter Newman wrote:
> Hi Reinette, Babu,
> 
> On Fri, May 3, 2024 at 2:15 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter,
>>
>> On 5/3/2024 2:00 PM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Fri, May 3, 2024 at 1:44 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 5/2/2024 7:57 PM, Peter Newman wrote:
>>>>> Hi Reinette,
>>>>>
>>>>> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
>>>>>> I do think ABMC should be enabled by default when available and it looks
>>>>>> to be what this series aims to do [1]. The way I reason about this is
>>>>>> that legacy user space gets more reliable monitoring behavior without
>>>>>> needing to change behavior.
>>>>>
>>>>> I don't like that for a monitor assignment-aware user, following the
>>>>> creation of new monitoring groups, there will be less monitors
>>>>> available for assignment. If the user wants precise control over where
>>>>> monitors are allocated, they would need to manually unassign the
>>>>> automatically-assigned monitor after creating new groups.
>>>>>
>>>>> It's an annoyance, but I'm not sure if it would break any realistic
>>>>> usage model. Maybe if the monitoring agent operates independently of
>>>>
>>>> Yes. Its annoyance.
>>>>
>>>> But if you think about it, normal users don't create too many groups.
>>>> They wont have to worry about assign/unassign headache if we enable
>>>> monitor assignment automatically. Also there is pqos tool which uses
>>>> this interface. It does not have to know about assign/unassign stuff.
>>>
>>> Thinking about this again, I don't think it's much of a concern
>>> because the automatic assignment on mongroup creation behavior can be
>>> trivially disabled using a boolean flag.
>>
>> This could be a config option.
> 
> I'd like to work out the details of this option.
> 
> info/L3_MON/mbm_assign_on_mkdir?
> 
> boolean (parsed with kstrtobool()), defaulting to true?

I am thinking is not a big concern. We only have limited (32) counters.
Automatic monitor assignment works only for first 16 groups(2 counters for
each group). When the counters are exhausted auto assignment does not
work. In your case(with more than 16 groups) the auto assignment does not
work. I feel having a config option is really not necessary.

 --
Thanks
Babu Moger

