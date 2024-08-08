Return-Path: <linux-kernel+bounces-279667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9B94C037
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F09285CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FC18F2DB;
	Thu,  8 Aug 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AcENU6DC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0518F2C9;
	Thu,  8 Aug 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128398; cv=fail; b=VHLjj3ppYMUGeNhGJ1fPLZedoUvHgQIopspUy1meuAZljiAFH6lvFXkWPe/DjcaAt8re/0JptuQbkQYQAulFyWvxECQmiC3YDHSl/SlhLZYMpDuT1OPeyq/XTesCMCcLyVGYzoPSIyi8qYN8M5I9+2bmLscASyYO7c9NESPXom0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128398; c=relaxed/simple;
	bh=Q0qnJt9zQ6YomlA8Nlqv/XKabygFi28g8NxFBRE0fAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rS6zxO3HJ+/9RUJLaYmIOPChRWEJFu8nMjceMf4X2NXaEGzOEYonJ8+tFXYc+XUxI9605P7vYB10CE1w5q2VKY9LbEGtB5BwIbjjHtHQVcSafmarjdEcIPSddOiXmUkvfuO4BYmjQTD1C+keYupaSde0aBqfFal73fJob0Pna+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AcENU6DC; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZY9XdzbXRVuzpVXD3K7ibelM2Qu0VqBWziEy053yd9C1cqGCozvvhkir3UTxV5E/kk62KgIbFLvfjxoxRZXSbIRMeDVQrOZjpfYNSBLj3s9DVGQIzBGyTElwQHpMbToTos4AiUnnLMCYen0C2mXFq0fzndKwvRmBbSECCK1vZbxjpn7wEWEl3CuniRKG0j+jBefcDCAk1zegD1iV7tzOSw2bLGEaxnWHf4LKf0R+9Sbb1Vcn34IfIEMM9ZU8T4vEmfamXuYQ6iU/oPD+pq/Pgfh44oDFN2gvCwa23OYPFb8gs6sP4rqETSYhA6kcJBOKvkb6v+5ZxD9wsEKdi0hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoIrgvIjS1LwEew2QPqzSv1IH7EhGX5PVV25jzLVaYE=;
 b=A8kPCAz1kw/9rs1zdFroafavdH+ogDsp6oqO1aCYtYIrCgaYFy5uBxYC/R1rjTRcgJiPj9nvBLU0Pj3tgnFEtgZKB2SzzTs0/sEwPRQwYlEBUuGOIv6Bx5C8boTQCIGxSvy7Z+TdLzlYdfSsZNpysKs8NywzEei0FoOwA4gmnQxVEZbWLjrbdWx0vVXXuGgntAQaO/TGss/Mnt2IMdGF5WGPJWcarLcO/vunWfKE6d2F96+tkXcpIDf8JvZMtEnlNx19f37yGOeY3yf2oMrvEslhUMcw5TRdq9v1/RbU2yT7w0O1rnw0OLLbodShLIvtKWb5ClVw8JLJbJ/GOvtb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoIrgvIjS1LwEew2QPqzSv1IH7EhGX5PVV25jzLVaYE=;
 b=AcENU6DCTwfFwkRQ7zcyh7oi+wrgbpP0o490Oi48fjA9NdIHjCcMSTZc+cUFaSxPC3zbfQprneEh43ih//aZLFXhZftwyvY/wDj8Pb8WbA4FX9Y26LmveqkYiv+0aoGBC3E58+pAz+i6qs/cXQDhP0piozD0KgqweoAVDTB8pvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 14:46:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7849.013; Thu, 8 Aug 2024
 14:46:31 +0000
Message-ID: <b4d01176-d851-48d7-9f52-05b515ed1f03@amd.com>
Date: Thu, 8 Aug 2024 09:46:27 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 01/22] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <72b61576c5101f6d325c2384f838cb475c7aa576.1722981659.git.babu.moger@amd.com>
 <87le182t1a.ffs@tglx>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <87le182t1a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7e0128-d4bd-49c1-4908-08dcb7b8e4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFNKYUhwZWxLMHpNSWd6WVl0d3FsWkhnQW9CUm1qRFBNTXpWaGNEVFVIVkU4?=
 =?utf-8?B?dU1RRy9VT0EzT1F5YlFsbXpGTVFocnhwS2xFekxuTDNOeFZmTFhINnMrbUp0?=
 =?utf-8?B?UGxwbDQzV1ZWejVHRjJlNTNRWmhzRlBEbXhsNXVNMmRHcXFVVm51MG5yTmhS?=
 =?utf-8?B?MmNJY0xuVWFrRmtkVjgzcWJpN1JwZ3dSenB4ZDJGUHF5RzI2MzduSGg3OExE?=
 =?utf-8?B?Tm56TU1zSml5TmRwVUhpc1ZPQnEyNjlLamtyUE5xZG5nUWlOMmpyQjZjQUQy?=
 =?utf-8?B?Q25WNThSdmtQOEFTQmtQcldsY2ZTSjRaNUpTWUlxREJMTDFLdUY2WE5GbjZ2?=
 =?utf-8?B?eDA4aW94dExGcUZ3TVNObW9NYTllc29FQXdNQXc4SGdKYUpiWTkwWi9vcWJx?=
 =?utf-8?B?V0JIbEN5WEJZN3JJTU5HKy9qbnZzUkMzUkV5ZmtWblppTFhHNXpJVFdLYzJw?=
 =?utf-8?B?TGowZXFldVdFUVc5NGkvTjFGb0ttb0RCZ2MzODU5ZklTcHQvSWxycjJxMHU4?=
 =?utf-8?B?dGdtVHAyUHE5a3E0RXE4Ni9MK2UrSGM0bkhjNCt1NXQycmhZdkFaNDFjUnlk?=
 =?utf-8?B?eDdKN2tJMk1qNzNqbURMdzNjZWZWL0lMM01xTXE5V1hIdDRXcUNnVStuZ2U2?=
 =?utf-8?B?YzFqVmJUYlF2cVB0OUQxRjNvSWM4V3czZFBQVXdzNkdaNExoaTN1NE9ITitW?=
 =?utf-8?B?VXgxYUJQNGJicHlzV0w2Zmo2dlBHcDFBam1aZzQvak51TG5jdVpLa0ZMQlFw?=
 =?utf-8?B?WUJrYVpUaDlDUllBSE53eGxscDI0VGRSc1dMazc2bEFiSVpnNnluc1lzcTB5?=
 =?utf-8?B?KzZHdzJ2OUNtYXNLbTJTajdJWGxrNjlwTlE2THhoNDNoU0FOdTVYcElsNXA4?=
 =?utf-8?B?ajUzUTV1bWUrNmRudThsVXhLT0NMaHlyRi83TlQxQkwyV3d1ODhWdmEzMVYx?=
 =?utf-8?B?eFJlcmRSY1JjUVhuVDd1dFVJSERhT0NuZWpYbDQ0VmNEc0hZTnRaWllmSEVm?=
 =?utf-8?B?eWlzVHN3MHVwblpOaE5ZZCs4cWlPY0ZoYU1OZWI2NEVQbXZTQzEwMnF0dnRv?=
 =?utf-8?B?U0wycFVpM2VFdTVhUFRFc2diQnlqQUdJQlNqMDZNZEZVM2xNbnVDQmRNNk9n?=
 =?utf-8?B?Wm42RUZJSUdybkVNY1I1Z0g1WDgrclFKQm4xUWVQL1lQZDZVUXJEVkNQdkZW?=
 =?utf-8?B?UGR5Q3E2UzZwa05GeU9xMjZjU2ttMndpT2RIM043RTNReFpjemhiR0UydG8w?=
 =?utf-8?B?ZkxtTmVGY1R5eFZmRGc5OExVRFFBRjNvc1FGR1RtL1UyeDJyU0Erd1g4NDk2?=
 =?utf-8?B?ZUVMRnYvWnA2bDZQTk9OTGxUSUJNem9DRDA5dnZqa3orK1IzT1Y0dm5qSWVT?=
 =?utf-8?B?Umg3ditXd2pVWGdPQ0tZMlZmRFNWTDVUY05TOEl3N3dSR0xlalVwa05JSjRQ?=
 =?utf-8?B?cmJGd0JuWG5kbk5qU0g5c3UzRW04SDRPMWZFYzY0ZHQyWGRWcFlmSjUrVFl5?=
 =?utf-8?B?UndFbVViWUo3WlluaSt3M2pJbDl3VWNvbytyUjBHRE82RkdjZFB3dnVIeWNa?=
 =?utf-8?B?STNIbzY1T2dFVTVhcTA3L3h4TDJHcUJJN3BMeDVMQTJSZ3Y0SGV0WUUwNkQz?=
 =?utf-8?B?MmtEdjVwQ1hzRUxnczFHQ1BGNU5tc3Z2NS9xeTJMNjZzQUZmbDVVYzhTVnRx?=
 =?utf-8?B?dHJoblpCemZVNVF2eWQ3WTNaQUFWaW5MME5aT2EwYmduMXptTWU1VUswNHJE?=
 =?utf-8?Q?McU2EbmYZn2IrWWrdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmpBTGFBQnlTMVZPZTUxelNjeGRFOW82RUMwQklnbndUNjR4dWwzdjU1cVFC?=
 =?utf-8?B?UERtNC9LS1VqREZKQVdyYS9ZcE10dFZ2cGs1UkNuNTMyTmd4ZHlsNm1aUVJ6?=
 =?utf-8?B?ck9mcWZyQzFLNzFTZk1PMmJRWk1qMzJueUphaGZWd2I3TmI5THRTSTBTMDRL?=
 =?utf-8?B?TmtBdHpKYnh5NldtRnVpcE1MSTNDdWdSMm1DeElHOFNQZFlHd3kxMEhBNTlo?=
 =?utf-8?B?TExVb1BSN3o2ZXFQWEFIRm44b0daTDd0NS9jV1h0Q1pYQ0diRXdBNngxOVlR?=
 =?utf-8?B?eE55bmF2RkpwSTcwSTlWYzV0WG5HUmhCeUQ1VU9sYjhKaTFkWEk3WEk4amRj?=
 =?utf-8?B?empXakljaEp0VVZFRDVFaENpbThqaitkMlJsN2YreE5rV2hURzE0enUyempj?=
 =?utf-8?B?VjEvb2owUmZha0ZzZWJTUHU5R3hlOS9aSmQvcm5NUllHR3g4eXJEbmJMQ1Ux?=
 =?utf-8?B?MnBDOG9NazdONHBmM2tpSmhveG15MlBBRnBUWTlVajlYZEx0WUc5YUNDbmFL?=
 =?utf-8?B?cWd0ajd6V3NxVWE5Vkx4a0FtNnZtUlQzd3VuNnNsd0p2N3VLNW9CaHdoYTI2?=
 =?utf-8?B?bXdqaWpacFRRK3Q4NGEyVzlpVFZkRXkrRHBKU0ZtK0EwZzdBSWQvWHgzOFo5?=
 =?utf-8?B?TVRzUGoreklreHo3RjYyVnQzVnk5bElsRVVSZFJGRXVuV2ZNV0thMUNjaU1R?=
 =?utf-8?B?c01iaUZOV2xRNStkUkxjaHVsNXR5NmRqcjFaWXFUbUFCN3NXWGIyY0dnZm1v?=
 =?utf-8?B?OWlZZWRQTXpUaWwrdUFvelB2RWkvaUw3bXFaWmhlamhwUEZndlV1Skp4Q29p?=
 =?utf-8?B?QUhyVHhjODBxSUgrQXBIWEgrcHJrMlZQZUw0R1lvK0cwNlJ5VlJCSG5GN0Z5?=
 =?utf-8?B?VExnWE95dFVkc0lGZnZkMjBCcmUrYm93akxmNW45Q3dldEc2T3RGSFB4RDRv?=
 =?utf-8?B?dFdYZTNzSXM4bjNjZG5UNUROZVNzOTVaQXRiczE4SUVaR1FCRHp3bHdOUW02?=
 =?utf-8?B?dUxHZkZROGkxTnpmUysyLy9RcE9DTmlsa2UrWXROdlg1Y1VvS1ZEQkpBbHB6?=
 =?utf-8?B?d2FEMUVzVS8rNWwyNm1LVTJzYmlqYkhRa0F0R2N6OUxpV3R6SnhmZmVyT2cy?=
 =?utf-8?B?TWpIdzB2UUhJRkttZFhFcStlaVoxYkNIOCtBS1M4ZEpqRWg2K0x5VnZLT1Zq?=
 =?utf-8?B?YW80RytKaW5TdjUwZnhweW1OUytUcy9WUnZNNTViS0oxZS9NbU9hUDRlakxI?=
 =?utf-8?B?RVNaS0NOZk8weHVRMWZOdEw1cFlsYVJzd1pwY1R1SVA1eFJHdC82V1lTTVFk?=
 =?utf-8?B?NFJ0emFLRkJ2akFPMzBibkJEQjhLeC9rOUtoK3k5bjdxdXZwOXdQNSt6dXpu?=
 =?utf-8?B?VnB1c3YwTU44dElBa0xIKzkwZzhJK1pCTVNobDNQaEx4OU4zMkxwY1c5L1Uz?=
 =?utf-8?B?RHA3WUZTM2JudWljR2VsL051dVRXOEg0N3JQd0sxMkgwdS9EWTFNV29hMWdJ?=
 =?utf-8?B?OFUyMHY2amhJbWllMG9nN1NxUGNqUjUxbW11aHNmTWVxQ2pibStEa0IxTmJD?=
 =?utf-8?B?bmxlclV2ZndTelF1MGlKeVdrUW4yME43bXEweTNTMkhhRDIycldpMnFpSzAv?=
 =?utf-8?B?VTBXamwzaVZqYU5zZURJY2xJRHdZanVML0hSM1M3ZWRlZ3Z0bTJOUXA5am9j?=
 =?utf-8?B?T1JMOXpJN3BZWGZjMFFWS3JBbHgwQmNHTkdTb1JOd1VmeG9vUjl6b1U1SWNI?=
 =?utf-8?B?M3VOOVlYSHlkR3A3YUo3OXFRNGJ2RTNxU3lBUEEyRzduSVRFbmVjclpSazVE?=
 =?utf-8?B?NjRJTVVhNGlkSzNBeU5KelloNklIQWFkM2p6aFFKT0FCTkdRTmVCbzF6blpq?=
 =?utf-8?B?ZjhjSzY4eTUxT05CZHVsRjNWRnZRTG50eGJyVkd3U2E1RDZLK0ZoSkcyMGto?=
 =?utf-8?B?NHUxMDcveTBucDdCWE9WUWlseXBPaGM5ZWE5VERQYVU4bWx2TG1EeDh6cTIv?=
 =?utf-8?B?bWYvbW5EYys2OXhmREg0WkJQMkhWYythQjE3MXRNOUY1Q2hQeWt5Y2pTU2FO?=
 =?utf-8?B?eWsrYmM4S3ZlSmt0cEtlbkZsc1FwMG9IKytZM3hOU283Zml5a21xaEkwdUVD?=
 =?utf-8?Q?A1C4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7e0128-d4bd-49c1-4908-08dcb7b8e4a0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:46:31.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzoaU+FmA6Sxq04vdo6zEqSDFL3Gxi9mk1rriAeQo3nS38/YCpzTq2ai24OX7Luh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125

Hi Thomas,

On 8/7/24 11:32, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 17:00, Babu Moger wrote:
>> Users can create as many monitor groups as RMIDs supported by the hardware.
>> However, bandwidth monitoring feature on AMD system only guarantees that
>> RMIDs currently assigned to a processor will be tracked by hardware. The
>> counters of any other RMIDs which are no longer being tracked will be
>> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
>> that are not tracked by hardware. So, there can be only limited number of
>> groups that can give guaranteed monitoring numbers. With ever changing
>> configurations there is no way to definitely know which of these groups
>> are being tracked for certain point of time. Users do not have the option
>> to monitor a group or set of groups for certain period of time without
>> worrying about RMID being reset in between.
>>
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user unassigns
>> it manually. There is no need to worry about counters being reset during
>> this period. Additionally, the user can specify a bitmask identifying the
>> specific bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can enable a maximum
>> of 2 ABMC counters per group. User will also have the option to enable only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to disable an already
>> enabled counter to make space for new assignments.
>>
>> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
>> Bits Description
>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
> 
> Can you please update the CPUID database with that new bit:
> 
>     https://gitlab.com/x86-cpuid.org/x86-cpuid-db

Sure. Should not be a problem. I have let our management to look at this
new project for contributions.
Thanks
Babu Moger

