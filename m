Return-Path: <linux-kernel+bounces-561780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B7A61619
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8D418977B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA1202F65;
	Fri, 14 Mar 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GCb4CqD0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688220013C;
	Fri, 14 Mar 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969126; cv=fail; b=ae4myCuedeHQAc2AxOac7WHn06nE7tT1YwGDj6xcgWBpJhuYHEgLJSeRh85Ii4TJ9MVFmBh9qrOYcehceGNUZWtcEz//DYKCkzsi01ZtXdZV6nV7sFMkuGqLzsyu0XlNGTjDThp7lNQRtnrHJv73GEPQXmO5ACcBHaLRwO+jMVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969126; c=relaxed/simple;
	bh=G9wjdzSi9GZ7uCS39dQk/Psnk42DFILCvlOx6ckjGrw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4qYpuecIJ9c3wu4IbmqSNBsGBuGO8mK8xzHjlG3rjBcQdK2OQ00G/feHeg1X9UI17ez1QYQfFzaetkoigu9kf2hbJjGBJsVjlw1YjWHPYckpUK09hnoBTILYiHrOgbyIN5MarzwZAleNDf5KHtUw46/rAqJzyHqy58PX4eLnIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GCb4CqD0; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws8h7r/I+p2SC28t6Qh7MORvj8gl4gsyejrZJnsZScPreHrqUZZtWJSLfkmOP1lq3fvp7Uc42XFGIGSMShiLMQtxITxf3A3AoMfBkCrkm62oAqMur18TAtGRyijGvmvDiCPtPyWGTbje2N4Or85rZVKxdZjLMUu4d8H4ap0tCDcbv6EIBq2d5juv8EZn3yh5JiZIY+w+bUZzZZnDx9CZ/v4rFw+MHurXu4D8E+MXoQVq6sWHcUMeRz0crlIa27ZE9SWtdExkRMuVni1Qf+sV/OUcO0C7eAgGn/hHXnLnbdSOmu0CwrN9dKVk4JAmeHDDEhne6YhIaqlYAvg8c1r/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34PL3Xi1zqhfepf/YT3bKO5lpE/+0YVU4lOhnDRvFEc=;
 b=K1+fg4vgLMuVwA/KE6JLVdh6jDDXUTL+/BCbItD6wiI00BEsgiyN3hmkndPzVp/KAyA93AVTl0PSnFsV1GY2pJ0Rh33S2+w4/SMPWjjIiEaeeVCzXD5509ZI/ryHKQoSlCtymyNTTiOj2tSYQIc1xNrlqWurojKwuElPTDgv+kFe1CY3OQNRaH96yRloZFuNzrl2r3Xgf++S9Is0OuC32+9WWawEaKIQx0/38tEDJJoNZY3W+1Bj129o8tfUFtIihiB69JXkWosoaH1I9Z/N+SZBo08k31v+BkmIIrRcDTN3770dIO+nYCKZpmMguuafKlXu6YeDhzVQX/VOirxBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34PL3Xi1zqhfepf/YT3bKO5lpE/+0YVU4lOhnDRvFEc=;
 b=GCb4CqD0R+5E0boU0rK0Zf7FnAOOCVEk2g5+pj9gRdNo7ozEBuE1draXL7Va9j6gSBPd8pkFhim/ncoq/qrg8AexHGAVO9zoVS8h77chqt9XUyYYYo34KqbeCud9hA6RUykFSUOZm3CpVg9GLHapbrM+F6I/3EJg14ut21CYwtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 16:18:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.028; Fri, 14 Mar 2025
 16:18:41 +0000
Message-ID: <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
Date: Fri, 14 Mar 2025 11:18:33 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
Content-Language: en-US
In-Reply-To: <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0350.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 92494d97-7ba2-4a70-8263-08dd6313e246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG5YMEh4TnlxK1M0cnBWb0NqVk13bW9qWDhNSmJ3cTVjNStNbWZHUDE1OXB3?=
 =?utf-8?B?S2F0bUJFbWhBQUtBMWdiRDUzanhLWStCM0xGK1pVZmdzU2tOWlkvSlE0d1ND?=
 =?utf-8?B?S1FsTit3b1FTWU9HaEhDMmc4MmxmQ3Eyam1IWVZqY3hIOURocW5TZWgxdFdM?=
 =?utf-8?B?T3MyR1hWSHdMM09uOGRVSlBlWjVNQnZKQzRBbzZOaEUzeGNwWGFYTkZsUExR?=
 =?utf-8?B?WDRvQU5LeEtqL2h0cEkyc20vc3lEa2hBdi9kb0k1WDhoNFpuRkd1Rmw5aHNq?=
 =?utf-8?B?TVdDeHhrK1Q5OEZ4TVlCV3A5a1c5U3NNcW1TWEhEVmxVVXJNS2JHZ0xlM3pt?=
 =?utf-8?B?TWFtVVBxc0JVcEpJZ1BnM3dzT3VZUytia1RpendOTEFzN2ptSTVmUWpqMXlL?=
 =?utf-8?B?RGRVSzRycXRBL1Uxazg0NklhNnV6eGNmOUNFRHRVbklid1d4SWV3M2pqVWRW?=
 =?utf-8?B?Q1FtRGlzd0V5R2NOYmMvSnlsY2dZdGEwSVhVQVJjUStZNEdoSG4wb3dva0hE?=
 =?utf-8?B?YTlWYkJ5VHp0VWE1WTBwNDg5N0ZHd2xmaXQwQXVteXhpbVowUTZ0TStLcS9Y?=
 =?utf-8?B?UzFZSDhSZzRYQm9SVkFsWDhtRkxHSzhTSVBVUWZXN3FySFljaU1qclJPTGJW?=
 =?utf-8?B?ZlBkeUJwZDVTR0M0TlNFTHlQYmFTS05paitMbXladWc0ajR4cW5xSm45MHZD?=
 =?utf-8?B?N2h5Z1kxQ3IxZlVINVdnY3cwYkh3ODBPbnBmamhNb0lObEM1cDUxL3hwR1hP?=
 =?utf-8?B?MkExc0lpVzNVenNEaEhQWmx1NThBTHI3SmY0M1hXTmZucnk1c3Jhc2xQR2hI?=
 =?utf-8?B?QW5NcUtUUGFjS3NIcW9GOUN0ejFMUlZCUEwxLzEveU9aU0NmVEdHaVBtQStC?=
 =?utf-8?B?SDZ1V0NmNzd2RlEzZEkrc2d1ZVV2K2xSYnllMHJsVlpRTFFUMjB4L2hPUTJl?=
 =?utf-8?B?Q0dsVkduNGpsL1lwSmhKQ3lwSE5IZGE3UWRDNkNyZFpEakI2N0JaRis5d1VC?=
 =?utf-8?B?djhBYXZTRUNxUXYzTmFmWExXNkxQeHo4WUcrSkNqbUxNbHMxMGpBOXdBMFMw?=
 =?utf-8?B?K2N3M3pFZElqMEVWZjA2Z3BHV09yMXM0bzRzUHRNOElzNG1nVUFMOWN1Z2Jl?=
 =?utf-8?B?MDF1QmN3ZExwdmZ3eFBTWnkwenJKYVBQbG51M1ltd1hsazg2OGRQaVJrZ3kx?=
 =?utf-8?B?c2dLdFNlbERVUmRjcTdhbzhqT3g1WmIzUG9VL1RyUm5xNjNyL0wrVXUvSUlq?=
 =?utf-8?B?MjdmVWNwdDhNNzgzSEduay8wQzhHTXhIVWhMTVJ1Q2hWRHVjbFlQUDNVQjE4?=
 =?utf-8?B?cVdGdXhFVDFNZ21jaUltYW93QkI3VElxd2liU2xUamI4djRPa2lkUFEvYkI1?=
 =?utf-8?B?RTNtK2tMUWhLQzErcEJuQlZnbGcwUVNuMDNNUXBsZHNzTVZXUHFlR1dHWkxq?=
 =?utf-8?B?N00vQWp2bjlOZ3VqaGlOMzc5QkJzWXVGWXNUZnAyZ2x0dzBuUXNUNG8wcFYr?=
 =?utf-8?B?TEsyUXFEZ2NJSkxRdWhhcEcweGM4L2pHSWNIb3JZTWdpQ0E2VzZ2NXFET3JO?=
 =?utf-8?B?SkF3Zk4wNWNaSmhCTmE5Q2dUZXhwV3VIV1pTNCtqOXd1ZHlYMVBwWHNjMzVR?=
 =?utf-8?B?RVBEUkFWWHlnOE1xc2xVcTNvQis2cTRDL2FPY2RRZExMREs5UjhmNGxhMUlY?=
 =?utf-8?B?VmFpc2I2eW5XS3lmRmlwbk5NNW5DTHR4Y2JaMlp3WWcrZ3VPMTg2RmdydDk1?=
 =?utf-8?B?TjhqaGhZdllyN0wzaG1HRU04SGlUUytXNWc3a1orbCtxcjVKQTZtL0x4OW9H?=
 =?utf-8?B?VWpBT2pDdnNHK1l3N3MrUFNTbHR0MDA1bU1LdEcxb05kZmtkd3pmd3hXUWI0?=
 =?utf-8?B?S0pmeit3TS80L0tMVGg3UEdadEU5YkQxWTRIc3BBNlI1U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUk3ZDZpSG5paWxpcVg1dStFYnZ5eVdUbTlYOTNZOFM4cXVQTjVHNVRmT1FB?=
 =?utf-8?B?aXJhelVXU0ZqUWV3anJUcWNYdENnMkkxVVpRTjFoakFSSHR1aWZWbVAxUzRI?=
 =?utf-8?B?OGpRNnB6b0s1elpJUFVydmROaFhQb2JLZnQ4ZW5jNjhHbHh5bDNGUWhvYm0w?=
 =?utf-8?B?ZUwzNnlSb1lVN3VQUTZiT3J5MWxoaXNtSEFLOVpWWUFsOUdvQlBuN3dlc1RN?=
 =?utf-8?B?dGdIS2o5VmxYQWRUcVBkRUYzODlsV0hRMlZ2K2ZOSnhaNjh6WXgvRCtOendW?=
 =?utf-8?B?UzI1Mi85ZGJvQU5DNUNPVnpNdXo5OFpvdThjMHlUL3RFUzJmV2lWTVFIa0Nn?=
 =?utf-8?B?Nm8xb1ppSnZUdTNhVmhWMXdaMnYwSUFJVUZYNGV6QThPY3JGNVk1bmFQNzNY?=
 =?utf-8?B?Z1kwRnU0WnRTKzNUdjN3cGg3dEVWSVFUSUgxY1JIdUJCZksxcEc4TmR2cFE4?=
 =?utf-8?B?alc5RlRXbnQrMkp4czV4MDRJWHFKc281amJIMzJVNVVOUDRDV05ud0pYYkk5?=
 =?utf-8?B?YXl1Wml1bCtEL2JUN1BQVkxsRU5wYmRCSnFGOGlwZnNZZWZnSWRINks2ZHpS?=
 =?utf-8?B?Q1A1UERsTTZ4V21EeWVtQkE2N3pmeHFzNlBtYTAwTW5oei9TWk90V205R0p6?=
 =?utf-8?B?a3N3ZVdtZ1RPWjlVcXhPWjcvS0pCWFY2dDNlYjJMeDFTWHhPMkM1QnIxcEVM?=
 =?utf-8?B?UEo3QnoyYjYzWkp5bkxDeWR6RC9VWUdIWmgzbDBld3NaQ0V1Ync3ZG03dkxn?=
 =?utf-8?B?QkJuNDZ3MkRTd2JtWEh6ckxqZXNybmRKU1lhdk1yUndQM0hsc0R4WkpHZnkw?=
 =?utf-8?B?TXByYkM5eVR1VE5YczZUaUpiQjJ5M0tjTkg3SEJCTmhTREVNYUtLaWtaOHdx?=
 =?utf-8?B?aG96ZjFLNzUxWjR1bWJuRk5kSnpqNVRwdmR5NWk1a3Nnd0hFRmpkSUVzWGNQ?=
 =?utf-8?B?T1AxS2dlc2psQVgwUFBJODU5dTl1VndmdU11c1FFSUErdExqMStmMW5Md21T?=
 =?utf-8?B?NVVXTVE4SjI2VmRNSlBZSmpuZUdLVXVTMzFLNFA0ZThDdnBFMkJqNXJ6RXNI?=
 =?utf-8?B?Q0FHSmdkK1dGN0VEbE5iQnA5OXRFRy9JUk15SVkxRHdwZTBHZENpcDZFZCsy?=
 =?utf-8?B?eEE4NVEwRkx3bkNzMEpuSEpBQ0s4SGFPaHJFazViTEhwQmNUVU5pdGxTZEhh?=
 =?utf-8?B?bHZKVWw0WUpSOXZlT3cyTVdyclk3QncxY0MxMFBPRG5tVjM1YW9Cc1YxbVUz?=
 =?utf-8?B?S0lFWVEwNFRJZkNPeFlQa1FvU2VQQjViLysva1JQTUJsYVBER2hnVmNvZVU5?=
 =?utf-8?B?dXJ5dDNoNTRqcDVrc2Q3NEZnRHFpc0JlVzhvZVU4WW1STEgvdzZlekpNMFYx?=
 =?utf-8?B?U3h6Sk45UmJpTFQ2K2JhRzVUTTFJeXQ1SkQ2ZFU0SUJrUktIU0RORFhJWGhm?=
 =?utf-8?B?aUpOcHV1d1FYK1A0eExjaHNUTUcrT3pBSTBkRCswdFh5TTdjTFRSUG14SS9r?=
 =?utf-8?B?bjNXUnBJNE1sYmhPdGhFaWNTemswVys0eG8razBHb0hRWXQ2TVBZaWNFWHh4?=
 =?utf-8?B?MjJOY2VOVnBpaFhjME51VkdkT0QzTFowby9Dd1BOUE1wQ2FsVkdMWXN3RnlZ?=
 =?utf-8?B?Z0VtcENqSjZiRk9WUjVGMWl0dUdBOEhNK3hDL21ra3Q2RVZ3YVJISWw2RHlI?=
 =?utf-8?B?UnVZb2haVlhRMmRxSyt6MGVTSDYwNVpOSmZ6YWRKeWorbFloVWpKN0NxczNz?=
 =?utf-8?B?M2owU0trRXJzR2pVdW8xUnpyMmdzT3JpY0ljQjZvV0pqdStwWFphTmh4QklS?=
 =?utf-8?B?TTlDUDJmclNFOVdLb1hqTkpJcFZpUmRqUHRPS3RsTy94NnRLNW5JazhuWXgx?=
 =?utf-8?B?RzlRYjdwaDQ5c25MZEhyZlVGdnhsbC9ZS0ZmblR6K2tnTWZhdEhsYnVYWVdj?=
 =?utf-8?B?aUdrY0Uxa1Q4cXorOXBXNUpRaWM4RWViN3JaQ3BCWVFsa0wxVnA1MFFMMURS?=
 =?utf-8?B?UWlOTm04cnZrK2xQRHNFNDZjOW93Q0JCMlQvTVBKK0N4UHBtYVNoY0ZwUkhq?=
 =?utf-8?B?SWIySVlqUndVSG43QnJPM1ZWNTZIUFVodW5XbWJWRVU1dVUvYXVoS0dleWI5?=
 =?utf-8?Q?GDKA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92494d97-7ba2-4a70-8263-08dd6313e246
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:18:41.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWveP5HHGBn+AuUtoldcSLCmxtHjKbyWXp3u6YVWo2Vbtj1rjcWJF4efUnaCfjXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

Hi Reinette,

On 3/13/2025 4:21 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/13/25 1:13 PM, Moger, Babu wrote:
>> On 3/13/25 11:08, Reinette Chatre wrote:
>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
> 
> 
>> Here are the steps. Just copying steps from Peters proposal.
>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
> 
> Thank you very much for detailing the steps. It is starting the fall into place
> for me.
> 
>>
>>
>> 1. Mount the resctrl
>>     mount -t resctrl resctrl /sys/fs/resctrl
> 
> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
> will continue to depend on BMEC.

Yes. ABMC will be enabled by default. ABMC will use the configurations 
from info/L3_MON/counter_configs. ABMC will not depend on BMEC.

> How would the existing BMEC implementation be impacted in this case?

BMEC will only work with pre-ABMC(or default) mode.


> 
> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
> files will remain and user space may continue to use them to change the event
> configurations with confusing expecations/results on an ABMC system.
> 
> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
> llc_occupancy
> mbm_total_bytes
> mbm_local_bytes
> 
> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
> and mbm_local_bytes_config, which may be the simplest to do.

yes.

> 
> To follow that, we should also consider how "mon_features" will change with this
> implementation.

May be

# cat /sys/fs/resctrl/info/L3_MON/mon_features
  llc_occupancy
  mbm_total_bytes
  mbm_local_bytes
  counter_configs/mbm_total_bytes/event_filter
  counter_configs/mbm_local_bytes/event_filter

> 
>>
>> 2. When ABMC is supported two default configurations will be created.
>>
>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>>    These files will be populated with default total and local events
>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>      VictimBW
>>      RmtSlowFill
>>      RmtNTWr
>>      RmtFill
>>      LclFill
>>      LclNTWr
>>      LclSlowFill
> 
> Looks good. Here we could perhaps start nitpicking about naming and line separation.
> I think it may be easier if the fields are separated by comma, but more on that
> below ...
> 
>>
>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>     LclFill,
>>     LclNTWr
>>     LclSlowFill
>>
>> 3. Users will have options to update the event configuration.
>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> We need to be clear on how user space interacts with this file. For example,
> can user space "append" configurations? Specifically, if the file has
> contents like your earlier example:
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill
>   LclNTWr
>   LclSlowFill
> 
> Should above be created with (note "append" needed for second and third):
> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> Is it possible to set multiple configurations in one write like below?
> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

Yes. We should support that.

> 
> (note above where it may be easier for user space to use comma (or some other field separator)
> when providing multiple configurations at a time, with this, to match, having output in
> commas may be easier since it makes user interface copy&paste easier)
> 
> If file has content like:
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclNTWr
>   LclSlowFill
> 
> What is impact of the following:
> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> Is it (append):
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill
>   LclNTWr
>   LclSlowFill
> 
> or (overwrite):
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>   LclFill
> 
> I do think the interface will be more intuitive it if follows regular file
> operations wrt "append" and such. I have not looked into how kernfs supports
> "append".

Just searching quickly, I have not seen any append operations on kernfs.


> As alternative, we can try to work the previous mbm_assign_control syntax in here (use + and -).
> 
> For example:
> 
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> LclNTWr
> # echo "+LclFill,-LclNTWr,+LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> LclFill,LclSlowFill
> 
> With something like above resctrl just deals with file writes as before.

Or without complicating much we can just support basic operations.

# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
   LclFill, LclNTWr, LclSlowFill

# echo "LclFill, LclNTWr, LclSlowFill, VictimBW" > 
info/L3_MON/counter_configs/mbm_local_bytes/event_filter

# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
   LclFill, LclNTWr, LclSlowFill, VictimBW

# echo "LclFill, LclNTWr" > 
info/L3_MON/counter_configs/mbm_local_bytes/event_filter

# cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
   LclFill, LclNTWr

> 
> 
>>
>> 4. As usual the events can be read from the mon_data directories.
>>     #mkdir /sys/fs/resctrl/test
>>     #cd   /sys/fs/resctr/test
>>     #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>>     101010
>>     #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>>     32323
>>
>> 5. There will be 3 files created in each group's mon_data directory when
>> ABMC is supported.
>>
>>     a. test/mon_data/mon_L3_00/assign_exclusive
>>     b. test/mon_data/mon_L3_00/assign_shared
>>     c. test/mon_data/mon_L3_00/unassign
>>
>>
>> 6. Events can be assigned/unassigned by these commands
>>
>>   # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
>>
>>
>> Note:
>> I feel 3 files are excessive here. We can probably achieve everything in
>> just one file.
> 
> Could you please elaborate what your concern is? You mention that it is
> excessive but it is not clear to me what issues may arise by
> having three files instead of one.

All these 3 properties are mutually exclusive. Only one can true at a 
time. Example:
#cat assign_exclusive
0
#cat assign_shared
0
#cat uassigned
1

Three operations to find out the assign state.

Instead of that
#cat mon_l3_assignments
unassigned


> 
> I do think, and Peter also mentioned [1] this, that it may be useful,
> to "put a group/resource-scoped assign_* file higher in the hierarchy
> to make it easier for users who want to configure all domains the
> same for a group."
> 
> Placing *additional* files higher in hierarchy (used to manage counters in all
> domains) may be more useful that trying to provide the shared/exclusive/unassign
> in one file per domain.

Yea. To make it better we can add "mon_l3_assignments" in groups main 
directory. We can do all the operation in just one file.

https://lore.kernel.org/lkml/efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com/


> 
>>
>> Not sure about mbm_assign_control interface as there are concerns with
>> group listing holding the lock for long.
>>
>> -----------------------------------------------------------------------
>> Second phase, we can add support for "mkdir"
>>
>> 1. mkdir info/L3_MON/counter_configs/mbm_read_only
>>
>> 2. mkdir option will create "event_filter" file.
>>     info/L3_MON/counter_configs/mbm_read_only/event_filter
>>
> 
> Got it!
> 
>> 3. Users can modify event configuration.
>>     echo LclFill > info/L3_MON/counter_configs/mbm_read_only/event_filter
>>
>> 4. Users can assign the events
>>
>>    echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
>>
>> 5. Events can be read in
>>
>>     test/mon_data/mon_data/mon_L3_00/mbm_read_only
>>
> 
> Related to comment from Tony [2] about rmdir, please also consider that
> original mbm_local_bytes/mbm_total_bytes could also be removed because at this
> point they should not appear different from other counter configurations ... apart
> from being pre-populated for backward compatibility.

Sure.

> 
> Thank you.
> 
> Reinette
> 
> 
> [1] https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/Z9NB0wd8ZewLjNAd@agluck-desk3/
> 

Thanks
Babu

