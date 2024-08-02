Return-Path: <linux-kernel+bounces-273011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B854E94635B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF22283491
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162351547C9;
	Fri,  2 Aug 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rcki4EaA"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F81ABECF;
	Fri,  2 Aug 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624555; cv=fail; b=tTvD9m0/SjOSmL3NGJF+eLMGWUpCaL5mtm2GWaloU1IRNAFBTJO5sNh34KVmAM+/8AeS6SRz0LvA1+Eyyuqo3Ovih63QHFw0TNjkd8/xdLXXFiAi8OZDZCWC8BSq7Z0kb5CjXTkmIW0cvsrdB/JZqd62On20h/2YrRcxos/I91A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624555; c=relaxed/simple;
	bh=N0dMDNNsWtEtFY3z0X7ECWilwFd3u74HqX+HOrbn3oo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q6EAkTo1/fdakR/mGXoN3oubzZPD6Ziz5IdzPpymZWmZCiMF4xWD8imL393fe7QQ/0ofp4rv7vzS3HTEuzCG/YIZhPj5nQ9Jkf51eRY8mW+jmJME0QGt4mgwFiU2yf8md2kq+HRDrO24gZ4T4T8kd9r/pTAqLZ72gzZwFPgr4gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rcki4EaA; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+LPMsU/6NWj58DGkxv9aC8Y5gPaVbwwNJlEO4hXppRjMpCGUHZUO5uEukj9FHrIr5sn0yYslEQeVYLBIOqKNdctBh3HgrzJ2VM/WUqsJfQIIdg2+eWpww+tsaNuPNdnDq5qxUS69ZAiZZXaRgBng35Q+z3/KT8599PD1bJ4+9drWM0UBMwCjUCP22N43pwsXpG+V+5IbiOkZzoFaKFs+tRj/2A5V1o/gE2ZvkAzwOHkhYCuOaKOD7zPJ2uV5D5SizVZ/79C3MnD0FpGbVhziGunHjK/Dl+qzdi2GyGb1xBkFkLzQN2hQ9yeii9h53RLrV4JRbDgtrq2cCFsSjNMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBieeW9kXrmGHg96ZePKUt+KOeq4MXvmv+wO4b7KBhY=;
 b=WyjKBVNtbNof1XDs4OAQcjoZ293bKLbJA65+edpgI96FwAYrDhYk575r1iGjaGNcDMBLL3jmLL6b3BPE+YtK18gayQ5GhrNKX822iWbj0fzPB2MYvS9Hn7/hXU2YkG9OtayzsgyeWXi3uz2080xwx/zp7jSKIPKXInDDbLYCmSwxdcepoWXWpjJw0iZJMmWoKuTGc4aKkMVm8wXdU6wB5cLlDsfN/tfj/5gTYSC03rexiVvaGxJ8aaM5dzZO29PgyG7mW4MGuaBA9xoMclo60X+/PxmPMzTblxz6ThLxYoiiScyS9ZcQxF7sBPoIv8YZAhFvTBz5vOLvbiAmJpHdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBieeW9kXrmGHg96ZePKUt+KOeq4MXvmv+wO4b7KBhY=;
 b=Rcki4EaAKR3N0leoHU8Wqafw5d/cdrbsFszKIYCSwsQRA0QUkh2E5JT7b2L8+C6CvDTQYGZUk+7ANL0jXMg82qp2If4we5P8/iW+ew+IjDe21jhLR/DgFjKjhH6GfI8XCw97iXzbRSBTm0MVOgGCAdAC33Dw9Zimjp8nZHyoWbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 18:49:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 18:49:11 +0000
Message-ID: <05786b1c-cc4e-26ea-581d-3aad3b594f91@amd.com>
Date: Fri, 2 Aug 2024 13:49:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:806:125::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd29132-dd07-4481-01b5-08dcb323cc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0t1WkFHN3plNEJFZnpJR1RvZnpueFVsejh4b1JkNlhadkMyMjY2endvUXZT?=
 =?utf-8?B?cllxN2ZJTm1RcEZTTzZaLzlzVWFIQlVjTm54MmFwSnR4TjRPc3lnNzIzVVlK?=
 =?utf-8?B?MUhSbUo0WW4rUUh6UnFuL294Y3RwckZULzR4dUlJOFBqOVc4ajRpa1p3dC9w?=
 =?utf-8?B?RVphS2o2d05pN0VLQWREeWZFL2F6OUpBc0NFMEdwRTZmNlB4UzhKNW5nUDRr?=
 =?utf-8?B?SnluYzk2eVpmenBLL29vVXpObnU3elU4L3NTQWVWWElCRnlGSTlHa3l2SXdE?=
 =?utf-8?B?cUFOQ01kV1RweDllYkQ5dm1udnlBVDl6Y3pSby90aVlJUEM3eU9seUc3cHJr?=
 =?utf-8?B?cVhtRHhpbmV1MEs4UStkdFduTnducWVLYkJDNDFrUnozUXE5OWpjdjdjYS91?=
 =?utf-8?B?eDdrcXJadHpETTgyNTZjcWpHdjBuQTdIZEJOaUpYZGFLWVZqcFIwa2RmMG5Z?=
 =?utf-8?B?dVZLUkJURWFSOUpTWmpZdzd0TzhSNCsvQkFuanR6aUoxWE8wajJQQXRuNC9D?=
 =?utf-8?B?c1VSTHhjN0ZGQVVodXU5VkRXQURTMjAzamdLL1VTbU4ydXpOdFVqbTdsY1NP?=
 =?utf-8?B?RGxVdlM1QnBtV0RMbUNoR2NDWUE3OTRROGl0R3RNRkIvNzREMERjcHdaamcx?=
 =?utf-8?B?YWllbTQ0czVQc3JQU2xrdm5GYlRzZjh0QUxWWFc0d3QyRVFxNTh0KzY3ZzY0?=
 =?utf-8?B?eE1lL1hyU0xsSXplSjA5cERxRUsvVVdVUXkzU2dQUlc1K0JJYXU4ZFd3SStT?=
 =?utf-8?B?M3M5UWJkS2dxMXcwM0NnYlNiQ1A1VmRiUFNLWGN0YnUrMkprSEdTRmJHRDZS?=
 =?utf-8?B?clRXVDQ1RTBMTndhWEthOVl5MUVVa0pScWZiU20vR2pSZyt0KzB1dVl4NXFa?=
 =?utf-8?B?b2FiOG01TThGTDJDNjdLYllES0hwNHBDMGZkTWRPTVc2aXFUTyt1RGo1NmxH?=
 =?utf-8?B?M0UrcW9xWENCckYzVlFjZkN0Z0hFTnI3T0NCaW1yR3A3YW5HOElCWHUzSUh1?=
 =?utf-8?B?Q1dXWUtWWSsrNlhLQnF0TVFpZEd0R0dzMUlvalo5bnNLbUllQ0g2bmJnYVFU?=
 =?utf-8?B?dFJhYXJwekpONmQ2bkJqZmUwUXZkYXBPRVcxMTF6c2VIYXExUTd0Z1JBWVhk?=
 =?utf-8?B?dW54T3k2TGZHR1JZdUhra1ZSV3hKakVDM054WVdVYVhHQURvcmxXS1ZZck9l?=
 =?utf-8?B?cVhCcmhBazRPcHhSclN4cnVDb1ppL1JRTTN5SmxkSHpyeGljQnVLa3FoVXE2?=
 =?utf-8?B?QzF3RjIxTi9jeVRac2N0NURjS1ZRcTJLQ1o5Uk4ra3RWcWk3TW1sT2g5S1FW?=
 =?utf-8?B?TTdPMGdUL25hb2RYbzhHZ0FORlhWZXBOK25SZEFzYXVBOTdMalVYdStqZWxW?=
 =?utf-8?B?am9OMzh6VGRPeU1jUVdwcDZyOUIxeDZwMVlhV3BxQUV4M05ZV2Rsd3ZPWklL?=
 =?utf-8?B?T2NCVWNSSERmZGJpbmFJVHRvb25sN0FBVm4ySldUeWhnL3Jpc3NUWU1jT25U?=
 =?utf-8?B?TnpXNmxLWEVYOUwzRlNLbGFTMXFXNDVaQ1gvSFlNa1NWRmVBUXZ4K0hYMW9R?=
 =?utf-8?B?bTNwVFB1NFI5QnhZVnFaVlI0WmtFeUxGaW9xRXpzMzkvcVlPK1ZQYWRzV1RX?=
 =?utf-8?B?b0trQm50RkplVGtGVHkrQ0pGemsvMXhHeTV5KzlmOVZVY3lmYWVjUi9VYkk2?=
 =?utf-8?B?M2htUFhNYTVRY3RUV0x3UEdyTHJXQzIzalQ5QURpWjJHM3Y2WmpmdVZMbUwv?=
 =?utf-8?B?cThFYkVuR2RiOHJRSFZlNlQxWlIrcU0zUVNYeFNTQnFiRytOakVPdmhqYldi?=
 =?utf-8?B?SWFHZzZrT3ZFYU9OR3ZJQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1pFbDgxVld5Q1hGSTJaMTFKVndMMGFhSmVrQ2llY2FFdnlZd1JIR3FvZUs3?=
 =?utf-8?B?K2w3Sk5YejVmRDBjeEkzS2RyRXIxejZteUozbHI2SllCTXJaYTdJRGt6M2xI?=
 =?utf-8?B?VTRtVkpORTR2SG82Uy9Tbml5YmdFdENtMlVldDNEQURxdkF6SXVyNkJyNzZn?=
 =?utf-8?B?bkljalFlbm05QnZ5dEpWYVlMOXFYNnB0ek5IZURWQlp2M3FFbGtTYTN0WWc2?=
 =?utf-8?B?dnM1MkVBYUtwd1lmN1lrQUpBaytjSWtyV0ZiSUVxa3l4dEtNSWNMalBPaHpC?=
 =?utf-8?B?NmRJQWtjdm1pMzJ3VmZGb0N6dnViUXpaNVkxdkRBdGMzM2RNYnU1aFV0ZU50?=
 =?utf-8?B?ZUd1a0FOWXJsSjNDRHFOdkpFWjFMc0JzaE5vb1VrUXlDR21LSEY0QlI5Tkw4?=
 =?utf-8?B?NitHTWVNaEY0OERZZmNOS21VRkpHc3ZhYVJkS2orenhrZ0VFTDRrN21uYmpG?=
 =?utf-8?B?R0hMaWhORzdaMVpDZFV6MTdhWUJnbDVDT1pBenBEaFdZM09RdGtqNnpIaTdN?=
 =?utf-8?B?dlo0NGh1ZEcwcUJ2OENhb3JhczB3ek1ORlR5S2R4MEhrNEdlZVM1MytQRkZr?=
 =?utf-8?B?b2pMTUpCNk00SFlsNzNhM0lWWG1SMTJWZW94MXlIUFhPY2RHM2FXMnhCV0hs?=
 =?utf-8?B?WXFXWEcybHdvTmVDeTdXdktOdDBuTkh4eE8yYVVPLzR3SUZRRndNSTA5SzhU?=
 =?utf-8?B?VXNHaTIxRmI0K0xHZnp5SWpySXZ4aC8zeDB4VkFoYlRvZTRzYm9ocVJmNUVx?=
 =?utf-8?B?c3ZZZThCTW9uYTUrcHdvdU9QMWZ4VGVvSDRuNlhXRnN1L2xIU0FPZHdZL2Q3?=
 =?utf-8?B?aDBwYU9heUFWWXEveXRIVFdoTXdUUjJ6NXJLQ3FLaFBJVDhmUkd1NDJrVlZK?=
 =?utf-8?B?S3dscENQZ3MvY3dkYWl3VTZQVEhNS2xybHNPTndWTHgycTJQem1Jb3NZNFhr?=
 =?utf-8?B?UVFGcHhqZDgxbzI5UUJpNzdJT0RVTWt6R0daSHRON2ZKb0dDUFVWakovSFNm?=
 =?utf-8?B?MWFPMjdzTG9RdU1NcVM3Q21BVktqd3dhR0k5WW9MZVgrU2djZ1FvejdLM1pq?=
 =?utf-8?B?dHE1ZW52YzdMTFgyditwTnJzcDNFNzk2c0ZhaGNlREU1TlBoRURWQldtdTVM?=
 =?utf-8?B?OVEwNUtYWGk3T08ydmxlc2k5LzlBdS9NVFZpdlp3cmt5THliMHBBYmV6d2gy?=
 =?utf-8?B?RlovNU4wVzRqdGVIanRrcGZNN1R4STJMRC9xRjBiUzBzbnNTbHFjdEd6Z1cv?=
 =?utf-8?B?bnNqdEdVUE9QTldGbGdpMjl3czRMQ1ZKNS9SNWNIOHZsNGNuMXN0WHVrV0l6?=
 =?utf-8?B?U0t6Vkc4Q2ZLUVE3ck5aYUpaaVRWRkpzZVRyWno0ZmNpSjlYa3V0dzVmaDFX?=
 =?utf-8?B?UU8xQXVlWkZ0U2Q2c2p0ZTdYemlhSk5UaU83TFlXd2NvelovWXFKM1NjZmJN?=
 =?utf-8?B?UkxETDY2R09RRlQzNW1jN010U09zRWFPOCsxUWFvUTRnQnNYZkNMZDVGY1Rh?=
 =?utf-8?B?UDc4MjFqaG1KdUZjRnEyL3FOblVZV0k4bGlTQ2N2MXhpNVJMQjVvZE1LUWdE?=
 =?utf-8?B?b1MrUG1zWStnc3ZnTGh0Zkt1ODdPUXVrZmRqTFk1SWdVT2tyNFZBZWZuUXJG?=
 =?utf-8?B?RHV3akpYbTFsNXhTbkRRTDJTTXV4MkNGYnpsYVV2NjFRVEV0bjBld2FkeTVo?=
 =?utf-8?B?WkNKSjhLaUxGdVdmNXl6MG11aXJhVnJpOEd0RmcwQjdTVEt5RVlGNUJ5V1hC?=
 =?utf-8?B?Vk53VXBVVlNuUnU4N1U0SE5SQldVbkNoOFZUcnlReDlBbUFlTXAveVJCODNo?=
 =?utf-8?B?NzU4b0lJbEY3L3ZPMUM1N0J6UnpwbXJJSjl0N1ltbVJpWVVVMm5xbE1IWDRC?=
 =?utf-8?B?dzVCK1FOZjk4UEJFZ01vNDl1MHZicERSdk1CUFFDTVRESWpXSW1kazF2RDVL?=
 =?utf-8?B?QnVJWmh5SXhLa2U3L0FjTXc1VlFKUWtPTnY2K09EbTBvRWdmejN5cUxUNGsr?=
 =?utf-8?B?S0Z5a2NoQ0ptbllzbVVZZXVESDc1SWpsYW5tQVdHMnhUT3M2QUdiYWIyYitF?=
 =?utf-8?B?ajJEc3haZWJ1c01pMUsyaEMvUVJyMDNndVJOTkxkNUNNeTZHQU5MWFlwamhz?=
 =?utf-8?Q?dqoc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd29132-dd07-4481-01b5-08dcb323cc16
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 18:49:11.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXp9ZRmE3SaoJcIuRQFhNSY6p1ncZdewDGYxNPffg/HCxpLBFOM4u3wdNmJnASaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

Hi Peter/Reinette,

On 8/2/2024 11:13 AM, Reinette Chatre wrote:
> Hi Peter,
> 
> On 8/1/24 3:45 PM, Peter Newman wrote:
>> On Thu, Aug 1, 2024 at 2:50 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>> On 7/17/24 10:19 AM, Moger, Babu wrote:
>>>> On 7/12/24 17:03, Reinette Chatre wrote:
>>>>> On 7/3/24 2:48 PM, Babu Moger wrote:
> 
>>>>>> # Examples
>>>>>>
>>>>>> a. Check if ABMC support is available
>>>>>>       #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>
>>>>>>       #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>>>       [abmc]
>>>>>>       legacy
>>>>>>
>>>>>>       Linux kernel detected ABMC feature and it is enabled.
>>>>>
>>>>> How about renaming "abmc" to "mbm_cntrs"? This will match the 
>>>>> num_mbm_cntrs
>>>>> info file and be the final step to make this generic so that another
>>>>> architecture
>>>>> can more easily support assignining hardware counters without 
>>>>> needing to call
>>>>> the feature AMD's "abmc".
>>>>
>>>> I think we aleady settled this with "mbm_cntr_assignable".
>>>>
>>>> For soft-RMID" it will be mbm_sw_assignable.
>>>
>>> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to match
>>> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
>>
>> My users are pushing for a consistent interface regardless of whether
>> counter assignment is implemented in hardware or software, so I would
>> like to avoid exposing implementation differences in the interface
>> where possible.
> 
> This seems a reasonable ask but can we be confident that if hardware
> supports assignable counters then there will never be a reason to use
> software assignable counters? (This needs to also consider how/if Arm
> may use this feature.)
> 
> I am of course not familiar with details of the software implementation
> - could there be benefits to using it even if hardware counters are
> supported?
> 
> What I would like to avoid is future complexity of needing a new 
> mount/config
> option that user space needs to use to select if a single 
> "mbm_cntr_assignable"
> is backed by hardware or software.
> 
>> The main semantic difference with SW assignments is that it is not
>> possible to assign counters to individual events. Because the
>> implementation is assigning RMIDs to groups, assignment results in all
>> events being counted.
>>
>> I was considering introducing a boolean mbm_assign_events node to
>> indicate whether assigning individual events is supported. If true,
>> num_mbm_cntrs indicates the number of events which can be counted,
>> otherwise it indicates the number of groups to which counters can be
>> assigned and attempting to assign a single event is silently upgraded
>> to assigning counters to all events in the group.
> 
> How were you envisioning your users using the control file ("mbm_control")
> in these scenarios? Does this file's interface even work for SW assignment
> scenarios?
> 
> Users should expect consistent interface for "mbm_control" also.
> 
> It sounds to me that a potential "mbm_assign_events" will be false for SW
> assignments. That would mean that "num_mbm_cntrs" will
> contain the number of groups to which counters can be assigned?
> Would user space be required to always enable all flags (enable all 
> events) of
> all domains to the same values ... or would enabling of one flag (one 
> event)
> in one domain automatically result in all flags (all events) enabled for 
> all
> domains ... or would enabling of one flag (one event) in one domain only 
> appear
> to user space to be enabled while in reality all flags/events are 
> actually enabled?
> 
>> However, If we don't expect to see these semantics in any other
>> implementation, these semantics could be implicit in the definition of
>> a SW assignable counter.
> 
> It is not clear to me how implementation differences between hardware
> and software assignment can be hidden from user space. It is possible
> to let user space enable individual events and then silently upgrade it
> to all events. I see two options here, either "mbm_control" needs to
> explicitly show this "silent upgrade" so that user space knows which
> events are actually enabled, or "mbm_control" only shows flags/events 
> enabled
> from user space perspective. In the former scenario, this needs more
> user space support since a generic user space cannot be confident which
> flags are set after writing to "mbm_control". In the latter scenario,
> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
> to rely on it to know which events can be enabled and if some are
> actually "silently enabled" when user space still thinks it needs to be
> enabled the number of available counters becomes vague.
> 
> It is not clear to me how to present hardware and software assignable
> counters with a single consistent interface. Actually, what if the
> "mbm_mode" is what distinguishes how counters are assigned instead of how
> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
> and "mbm_cntr_group_assignable" is used? Could that replace a
> potential "mbm_assign_events" while also supporting user space in
> interactions with "mbm_control"?

If I understand correctly, current interface might work for both the sw 
and hw assignments.

In case of SW assignment, you need to manage two counters at context 
switch time. One for total event and one for local event. Basically, you 
need to calculate delta for both events. You need to do rmid read for 
both events and then calculate the delta.

If the user assigns only one event you do the calculations only for the 
event user is interested in. That will save cycles as well. In this case 
"mbm_control" will report as one one event is assigned.

In many cases user will not interested in both the events. Also events 
are configurable so users can get what they want with just one event.

Does that make sense?

-- 
- Babu Moger

