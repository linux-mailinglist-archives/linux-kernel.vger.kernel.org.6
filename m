Return-Path: <linux-kernel+bounces-239721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4F926485
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1494B23224
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29D17E46A;
	Wed,  3 Jul 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9Dcw2B/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038B1DA319
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019479; cv=fail; b=XKjvzODqjRb6GYHGJtXrV4nVsJeZGJIdz0twP/lgC8lypF3h1oLCbERws0rLFm6JxLvm2K6LlDK2JxiYtR38o4YYxH1/ZjGPILvfhk1gQDHP7Yq8TyJGc7bRbZ8VSp/UkZR0jbv8YnFdJkydsbCm3GOkZhF9FOEMwcxPHtIzEJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019479; c=relaxed/simple;
	bh=V8s5zxuEAJNYUGNWhOOOAVfJfwn9PCJptbxI3DR5dCY=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=AyHgejhSRXKhfAUVJwJZjq4nBcJGwW+hCE2HwZV5/wxfe78u6HumVI+al01b23i0iX0jC+J08INJdHlZNZ6pNFDOpsja2CziaEwJgUh4N9XLOeaqti4ZkPzK9BlLd1TFiw+DNIBJO13MsZb3+5MrMwQzHQo3nI1F9vCKEqqBWiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9Dcw2B/; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3pZNj9nx38BFv5CjRJ7d32LyCp6K7rCNTO+zXBGCxALy1xJ9b6BGHkIxdNn+UhLcpM6Cu/Wniv6tjiyjVPUryMgVceTVIBABJc8I9D0CEK0P/VlhATwsWgk5wW/vOMCIlfLU7Z/wd3W4TPjVFq+gbFAPQ/O0NdPTu82WM2IrGGq2I6X/LADx/r386eSBSZk9T3w6Y9dkEpuGzv1CIIHwvPF3t4weoxDrXRhAstRvnO4QXnoA0NPrqcP9hl9ySaVu5KU6bjeSS0hMCuQ0eFArrdFrfKByxBmwXvCiUXtvhP9M3QpK5UnowfdDxz9ta0zedlFk+Y3ZPKJAHcBXgVuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81LjLLEv++VMpY0sT99Sm7X9w+KR+VgHEZkFQJNPyNo=;
 b=D95eSguuQZ0lfmYpeuy//9e4UUoXOfcM7DFfYuV2G8OigdrjKVEOkJGFxPh40y5wNO2ZjGGDryF1VhI4N2BZHvVtf3t/sPHLsilpCFUEE2NLScpOcYuh8Jz4TekMddSHtni3LaovrY71dBpFbu+JMvoUaRyWEx7sfpUPKGPzbQEKSbjdyp453Xsk4ls5zKLzOJciqwiya1XN6PmS9Vfab1ytTLAWY0KZPkNCNELLvyCLpulBNu+NxEBZuPS/bY9JP1nDsryeG4RCEhRx3k4ooBr6wnjSnM3QIgT5yvfkBtmIJczgVRMjjO5Bl5RJdJ/em5XeXlebImNG0ok1Yje4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81LjLLEv++VMpY0sT99Sm7X9w+KR+VgHEZkFQJNPyNo=;
 b=d9Dcw2B/Y+xkA68eZ0fJPMD1RH84M9NRQBBh3gr1J1miLa9sjZuxsdDvUPPB88tvuuCR6MhSvpetzwkT4cGDF9uMgLZhXR7TOIE/n7CrICJ8p+SN97KcsERaJxW0fl4rppRRTd5nMgzzuVp1XYje00VYaRmbQnG3lq20dn0qGNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 15:11:12 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 15:11:12 +0000
Message-ID: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
Date: Wed, 3 Jul 2024 20:41:03 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>
Subject: Hard and soft lockups with FIO and LTP runs on a large system
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 047d0a29-4e83-4c88-20c2-08dc9b72600d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHF2Q2dXdGlpakFPaFN5MlV2V3ptaU0yT1dkb3NGdzJvdWlJQ1lTNndnQVZr?=
 =?utf-8?B?dVNNY1ZNNG1BRCt6VXdxOEFhNG4yaGx2QmdtQUxnL3FWdS9MUU5SRE9rd2tp?=
 =?utf-8?B?RU5UOUw5Und2eDRKZFgxVHV3RUxsR0dQTWViaGpIL2QyMDdIeFpqaDJXNDRS?=
 =?utf-8?B?NHdyaDNSMDVRSW9zV0lOellHd0YzNWFFUm9qUFBUd1Z6NGRLSDlJNUlNa0h4?=
 =?utf-8?B?aTdjbzNMNktOdzVGT08xVTlsOFltUktScVB6dkhGQk5Ub0xZanpEazZvTWta?=
 =?utf-8?B?d3dla0l5U0JscGtGSTJJMmpsT3NzQWZ6Rit5RVh4SzJpWDZQYzg0b3lyZ3dP?=
 =?utf-8?B?U2VuNzc0VDEyc1N2WWtQKzJvVUltbUFWQ0ZwNDZ3K2I5b2ZEdmFCZW8rVWh5?=
 =?utf-8?B?Q0ZPczF6U091SDdjdkhZR3paTUpOQ09QQk1oZ3pNbDM3a2FJaUpieXcyU3JI?=
 =?utf-8?B?R2QxMDNaWHJiVE9pbk9IcG1lTWtodzBYV3Bveno1UC9jYUtnWUk5YTU5WTRO?=
 =?utf-8?B?WlMxSVVSa29xcU44N0Q3YU1PSDE0MENzanVTWXBDQ0xzMTB3RE8vNk9jQ3BM?=
 =?utf-8?B?S2x1eWZ1VkQ5V1BGLzA1M2pHZ3l1L3ZsNHVkbEJGb0VXaUJHTlVWWm1Wczlp?=
 =?utf-8?B?OTI5YU5zZHEzMnZ4YktVQ05RU1VReVpKN09KakpHN0FIVTRVM04vL0JyUTJz?=
 =?utf-8?B?UUlJZW11UHc2bXdIQkFqdlZHNkVERk9aR3dDK0tJMzFuVmdnd0JuR1VWNkFm?=
 =?utf-8?B?bEF1dElabjdaNEZucmx0U3BuYW5RK3FMODhiT2FxNDROVUJFTDJ0blBiSE50?=
 =?utf-8?B?cFRBV3ZYRnNTdUhHWE1IakdqWXgzRHdSMndlQlUxRlFJUngrU1QrVitieHYv?=
 =?utf-8?B?MkRGSWhCenFyMXhEUm5lYkIyQno1Nkc0aWRaMEFuaTZLUEFDbmlNb0hzQ3RX?=
 =?utf-8?B?UlJqSDBqWEMrbHRkOXdqb1RFbUVjKzlBWi84dVdraCtQQmJkY01uck1vWGRI?=
 =?utf-8?B?NmhYenI3Z3JnRE50NDJqeXZVd3VUQlNGRWxDTEN4RWptRnR0d2xlWm5oN0h0?=
 =?utf-8?B?T2lqV3o3SWdvS00zdWhxczZqSjNvcjQ5V0YxVWMrcmZQRC9XYWwya3NxeCtW?=
 =?utf-8?B?Y0hQcVdlQTNsSjYwSC8rZ1BhR0MxaUR4bEZkS052anZqcGVWY1UrVW5RUUxq?=
 =?utf-8?B?UE5yWlNVYW5lU0c1MmZ4cGxDNCtLYUlZcFRQWUh6ckhNYUd0c2E4d2o5WGpG?=
 =?utf-8?B?RCtuTHNEZURIaGhQNXdMVUg3MGNINlRUV3hnc0NBNkx0UVJXVEI2My8xaEZG?=
 =?utf-8?B?bFlzdDFITC9kREZnY3NEQU1rMFJFSi9uaU85Um5JR2R1OGorVTZMUjF5bDFx?=
 =?utf-8?B?VnpkeGMzSU9EZGxmc1RBVm1zeVpiL0FQT2FObTU2c0lLNkMzY2NRQSt5ajR2?=
 =?utf-8?B?TXFDb0hBWE5oS2U2M1MwUEY3alB1OFF4SUZsNGZlMGxGOU1NY3JSM2phSmVs?=
 =?utf-8?B?YjhvYlNkcHUvYmpFdFJvV0RZbVk2QVBtaUlrYVd0VEhZMFR1ekYwNWNyb0lW?=
 =?utf-8?B?NmROZ1BHVlJwMmVFUzVVOENFbnFCUjB0ZmdTMmtTVE8rUEpsZWxsWktnalBR?=
 =?utf-8?B?SktLbUh1aVNqNUQ3Qmt3ZW0zT2pTMlNMOW54Sjdid2x2MnBvUTZaL1BhUnRv?=
 =?utf-8?B?SE1ESWZ1Vk85TUFNR3ZId0FvbHlXZ1Z3ZVdDU3hYUmNjY0p5YXVEVGlpd25I?=
 =?utf-8?B?cWE5UDBXQ2VEdDdhRnloV1ZIMTR3bTlxbUpPQmh0ZGNCYnZhTnd6RnYzd0xQ?=
 =?utf-8?B?c0JjT2pSWExLSVJGOTh6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZWME9LNzNRblVRNnlSV0dYMGFQS1BKUG1nRFpnc05BQXhkSDRQcDFYa3Jz?=
 =?utf-8?B?RUJLaWRZVmJXaFBNRmxtU1Zxc2YrRXI3b2JmckxrNHpPQTNFUHJ5bGR5VW1y?=
 =?utf-8?B?R0xremRVY3lScnMvaG5xTk5mWHY5Q3hMZVVaRWM0TnJORENyMmpWMGdQMEZS?=
 =?utf-8?B?dUxBSktDdDMxeEhVeVd1eC91RjlIYnhRcEpRZFJOMWNyd3FiVFFpaU80bnJJ?=
 =?utf-8?B?Qis5c1RRTDhST3BXSDgrVVNlbTRLYlU3Y2hlbFo4OGVJTlorSkxFWmJHT1Nq?=
 =?utf-8?B?aWdVYTlIaEJkL285OG85YUhtdGtyc1ZsazhzMHlyVzBBckloQnhjVUhveEtm?=
 =?utf-8?B?bTZ5UW1wS2ZOaDlRUVZOLzlGcGlLWk1VWEY2TE0vQnpOSCtvUldQTWVUeUpM?=
 =?utf-8?B?cHlQa2MxMnZGL29VdWkyaVRFSWxHWXlNZWtwMlFxd2lJRkQ2M0ZSdmFqY2lO?=
 =?utf-8?B?eXd2eWxEcTg0UTNzZm5OcFJSUTA5cDVNWXF1UWp1OWo2eFFicTBhSXZEQTUy?=
 =?utf-8?B?d2lSSjJ5T1l0eFp2MElFekNoMTBQaVFKdlgvaWU4cFJ1cmI2LzdLZUdzeHNp?=
 =?utf-8?B?YTVCcDI1WjIzcFN5ejFuTjhXME95akdPQ3REK3MwYnNydTMwL3JOSUJwTXlH?=
 =?utf-8?B?a1NqVEJMaWl3RytlS0d2aDdyeEduVGt1ZExHcWswWUVWRGozYzZvbUl0VFdL?=
 =?utf-8?B?S0tOd1ozMXpFTmFnS28yN090SVh6V0lTQmtYNHZVbnVtMmRyZEZLZzh4SVNu?=
 =?utf-8?B?Tm5SRFd3VmdxcHBrbGNYUGM3dlVlV2c4TVlieWFtNjM1UUsyRzUzaVFQeDRL?=
 =?utf-8?B?TXJIOTdubXFYZ1NpRkdRai9JaVdoYUZ2dXVFRHhzMXJ1NktkZWEvNU1IMEds?=
 =?utf-8?B?VFlUMGlybk5lcXltWTBsamhMOWg2eFVMZlFMRWQxYUZ6R0hBaElEMVR1cGNM?=
 =?utf-8?B?OWJIVzJvem8rMktEWG1PYkM4TDRFM1FDTnE2MWhMREV0MVRWM3JaeWhQZlhN?=
 =?utf-8?B?NHNHdWJLL2RWSkxselhMK21xdlpqYzhlRThvRks5VnlsQWJ1dzBET2xUK1lx?=
 =?utf-8?B?dGFFalRBSk5OWkMrL284dEwzOTJ5bWtBOXZwV0RQbUQvWGttZWtaNHIxWlBL?=
 =?utf-8?B?a3NodmRpbXJ6a0JQbm45NDltWmhTVjdwaFNURHRycUlnWEhkR0ttV0FjV3Vv?=
 =?utf-8?B?U3F1T1pmUitvMGc1ZE8yQWZxVDFiWFcrR25WcUxVUko5MWo0azQ1TEhXenkr?=
 =?utf-8?B?V3ZHQ0dIb0dnY2FjZjVjd0plb2ZXaUsrV1prVXhtVTFuWEUrMnlpNU42cm05?=
 =?utf-8?B?YndSd1k5SFdlRUxWaENTQnFEU2cwa1lzUTNkaVRrUE96NDJ3a1FFVVZJajNW?=
 =?utf-8?B?b3ZVREYxcys1bjIxall3K3NrTjNOV0xOK1VFNlBWclpCLzVCTUkwcEI2cEJL?=
 =?utf-8?B?WGZ5UDA3L2VPQkY5KzNPaFB5STJwdWYzSFA0ckR2Mmk3cnpVRXBmQjZYV042?=
 =?utf-8?B?TzFKaWZ0UnRDZ2s2eHkvaTh1c2RVaFQ3bzcyckFwREZjaUVXWFlTS1psNjNW?=
 =?utf-8?B?L3lFNEJnbStpVjdXUkZQNWQxSTBtUk5RR2V1aFlFNHEvOC9xQm5WNGFyYlVp?=
 =?utf-8?B?bVZHbTQ0V1NIRXBIOXJBNmZ4eDh0VERpQjBGSStJcmpNSlBVTUZkeHJCa3ZM?=
 =?utf-8?B?eDNVa0JESzk4RlhSSkEyaERCaUZ4b2xUQkZudzJUdXlVcXYrSHpOWU1ERXIx?=
 =?utf-8?B?TDU3NWxWc1RVL1pibkc3Nm4vdkY1UmZseEJMemZSRjdRekVYK21GWTFBTlBJ?=
 =?utf-8?B?ZFIxNjZOek42ZlBXTnB2YU5wOGphSmdXT0xnY3ZUQVlnQWZaTGxSN2NCNUN1?=
 =?utf-8?B?R2tRQjdBcldPN2J0bzNqRXpPN3dtYTI1S0t5OG0yTjJTdGtzY1k2UnJaWnl4?=
 =?utf-8?B?aE9Ta1QvU1h0WWxpS1hzVURyTWsza3A3OHZ3NGNJSWpDODNtSnFqOWtjVGVH?=
 =?utf-8?B?M0NKRmFaVXBPNnZ4eFdZTEUyT0pyUjNhTEl5c21zOUdMTWlHTUQrMDVtUTky?=
 =?utf-8?B?eS9PZzR0aUl2UU8wL2xmL2lIcFpySDlINW1ETlJzeHFZQjE3bEpUK0phOTIx?=
 =?utf-8?Q?lILyKpoX6uMssT5vxyeRxz/2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047d0a29-4e83-4c88-20c2-08dc9b72600d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 15:11:12.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbCqoihxqyXmvIDR6Y6/iG0fN0WpAzlR41L3zoiP99mCd6DqaukEOT3axvtDBo8+9A7VXqz5tF39Jv/aR1/AxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

Many soft and hard lockups are seen with upstream kernel when running a 
bunch of tests that include FIO and LTP filesystem test on 10 NVME 
disks. The lockups can appear anywhere between 2 to 48 hours. Originally 
this was reported on a large customer VM instance with passthrough NVME 
disks on older kernels(v5.4 based). However, similar problems were 
reproduced when running the tests on bare metal with latest upstream 
kernel (v6.10-rc3). Other lockups with different signatures are seen but 
in this report, only those related to MM area are being discussed.
Also note that the subsequent description is related to the lockups in 
bare metal upstream (and not VM).

The general observation is that the problem usually surfaces when the 
system free memory goes very low and page cache/buffer consumption hits 
the ceiling. Most of the times the two contended locks are lruvec and 
inode->i_lock spinlocks.

- Could this be a scalability issue in LRU list handling and/or page 
cache invalidation typical to a large system configuration?
- Are there any MM/FS tunables that could help here?

Hardware configuration
======================
Dual socket  AMD EPYC 128 Core processor (256 cores, 512 threads)
Memory: 1.5 TB
10 NVME - 3.5TB each
available: 2 nodes (0-1)
node 0 cpus: 0-127,256-383
node 0 size: 773727 MB
node 1 cpus: 128-255,384-511
node 1 size: 773966 MB

Workload details
================
Workload includes concurrent runs of FIO and a few FS tests from LTP.

FIO is run with a size of 1TB on each NVME partition with different 
combinations of ioengine/blocksize/mode parameters and buffered-IO. 
Selected FS tests from LTP are run on 256GB partitions of all NVME 
disks. This is the typical NVME partition layout.

nvme2n1      259:4   0   3.5T  0 disk
├─nvme2n1p1  259:6   0   256G  0 part /data_nvme2n1p1
└─nvme2n1p2  259:7   0   3.2T  0 part

Though many different runs exist in the workload, the combination that 
results in the problem is buffered-IO run with sync engine.

fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=1024G \
-rwmixwrite=30  --norandommap --randrepeat=0 -ioengine=sync -bs=4k \
-numjobs=400 -runtime=25000 --time_based -group_reporting -name=mytest

Watchdog threshold was reduced to 5s to reproduce the problem early and 
all CPU backtrace enabled.

Problem details and analysis
============================
One of the hard lockups which was observed and analyzed in detail is this:

kernel: watchdog: Watchdog detected hard LOCKUP on cpu 284
kernel: CPU: 284 PID: 924096 Comm: cat Not tainted 6.10.0-rc3-lruvec #9
kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
kernel: Call Trace:
kernel:  <NMI>
kernel:  ? show_regs+0x69/0x80
kernel:  ? watchdog_hardlockup_check+0x19e/0x360
<SNIP>
kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
kernel:  </NMI>
kernel:  <TASK>
kernel:  ? __pfx_lru_add_fn+0x10/0x10
kernel: _raw_spin_lock_irqsave+0x42/0x50
kernel: folio_lruvec_lock_irqsave+0x62/0xb0
kernel: folio_batch_move_lru+0x79/0x2a0
kernel: folio_add_lru+0x6d/0xf0
kernel: filemap_add_folio+0xba/0xe0
kernel: __filemap_get_folio+0x137/0x2e0
kernel: ext4_da_write_begin+0x12c/0x270
kernel: generic_perform_write+0xbf/0x200
kernel: ext4_buffered_write_iter+0x67/0xf0
kernel: ext4_file_write_iter+0x70/0x780
kernel: vfs_write+0x301/0x420
kernel: ksys_write+0x67/0xf0
kernel: __x64_sys_write+0x19/0x20
kernel: x64_sys_call+0x1689/0x20d0
kernel: do_syscall_64+0x6b/0x110
kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e	kernel: RIP: 
0033:0x7fe21c314887

With all CPU backtraces enabled, many CPUs are waiting for lruvec_lock 
acquisition. We measured the lruvec spinlock start, end and hold 
time(htime) using sched_clock(), along with a BUG() if the hold time was 
more than 10s. The below case shows that lruvec spin lock was held for ~25s.

kernel: vmscan: unlock_page_lruvec_irq: stime 27963327514341, etime 
27963324369895, htime 25889317166
kernel: ------------[ cut here ]------------
kernel: kernel BUG at include/linux/memcontrol.h:1677!
kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
kernel: CPU: 21 PID: 3211 Comm: kswapd0 Tainted: G        W 
6.10.0-rc3-qspindbg #10
kernel: RIP: 0010:shrink_active_list+0x40a/0x520

And the corresponding trace point for the above:
kswapd0-3211    [021] dN.1. 27963.324332: mm_vmscan_lru_isolate: 
classzone=0 order=0 nr_requested=1 nr_scanned=156946361 
nr_skipped=156946360 nr_taken=1 lru=active_file

This shows that isolate_lru_folios() is scanning through a huge number 
(~150million) of folios (order=0) with lruvec spinlock held. This is 
happening because a large number of folios are being skipped to isolate 
a few ZONE_DMA folios. Though the number of folios to be scanned is 
bounded (32), there exists a genuine case where this can become 
unbounded, i.e. in case where folios are skipped.

Meminfo output shows that the free memory is around ~2% and page/buffer 
cache grows very high when the lockup happens.

MemTotal:       1584835956 kB
MemFree:        27805664 kB
MemAvailable:   1568099004 kB
Buffers:        1386120792 kB
Cached:         151894528 kB
SwapCached:        30620 kB
Active:         1043678892 kB
Inactive:       494456452 kB

Often times, the perf output at the time of the problem shows heavy 
contention on lruvec spin lock. Similar contention is also observed with 
inode i_lock (in clear_shadow_entry path)

98.98%  fio    [kernel.kallsyms]   [k] native_queued_spin_lock_slowpath
    |
     --98.96%--native_queued_spin_lock_slowpath
        |
         --98.96%--_raw_spin_lock_irqsave
                   folio_lruvec_lock_irqsave
                   |
                    --98.78%--folio_batch_move_lru
                        |
                         --98.63%--deactivate_file_folio
                                   mapping_try_invalidate
                                   invalidate_mapping_pages
                                   invalidate_bdev
                                   blkdev_common_ioctl
                                   blkdev_ioctl
                                   __x64_sys_ioctl
                                   x64_sys_call
                                   do_syscall_64
                                   entry_SYSCALL_64_after_hwframe

Some experiments tried
======================
1) When MGLRU was enabled many soft lockups were observed, no hard 
lockups were seen for 48 hours run. Below is once such soft lockup.

kernel: watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
kernel: CPU: 29 PID: 2701649 Comm: fio Tainted: G             L 
6.10.0-rc3-mglru-irqstrc #24
kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
kernel: Call Trace:
kernel:  <IRQ>
kernel:  ? show_regs+0x69/0x80
kernel:  ? watchdog_timer_fn+0x223/0x2b0
kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
<SNIP>
kernel:  </IRQ>
kernel:  <TASK>
kernel:  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
kernel:  _raw_spin_lock+0x38/0x50
kernel:  clear_shadow_entry+0x3d/0x100
kernel:  ? __pfx_workingset_update_node+0x10/0x10
kernel:  mapping_try_invalidate+0x117/0x1d0
kernel:  invalidate_mapping_pages+0x10/0x20
kernel:  invalidate_bdev+0x3c/0x50
kernel:  blkdev_common_ioctl+0x5f7/0xa90
kernel:  blkdev_ioctl+0x109/0x270
kernel:  x64_sys_call+0x1215/0x20d0
kernel:  do_syscall_64+0x7e/0x130

This happens to be contending on inode i_lock spinlock.

Below preemptirqsoff trace points to preemption being disabled for more 
than 10s and the lock in picture is lruvec spinlock.

     # tracer: preemptirqsoff
     #
     # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstrc
     # --------------------------------------------------------------------
     # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, SP:0 
HP:0 #P:512)
     #    -----------------
     #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
     #    -----------------
     #  => started at: deactivate_file_folio
     #  => ended at:   deactivate_file_folio
     #
     #
     #                    _------=> CPU#
     #                   / _-----=> irqs-off/BH-disabled
     #                  | / _----=> need-resched
     #                  || / _---=> hardirq/softirq
     #                  ||| / _--=> preempt-depth
     #                  |||| / _-=> migrate-disable
     #                  ||||| /     delay
     #  cmd     pid     |||||| time  |   caller
     #     \   /        ||||||  \    |    /
          fio-2701523 128...1.    0us$: deactivate_file_folio 
<-deactivate_file_folio
          fio-2701523 128.N.1. 10382681us : deactivate_file_folio 
<-deactivate_file_folio
          fio-2701523 128.N.1. 10382683us : tracer_preempt_on 
<-deactivate_file_folio
          fio-2701523 128.N.1. 10382691us : <stack trace>
      => deactivate_file_folio
      => mapping_try_invalidate
      => invalidate_mapping_pages
      => invalidate_bdev
      => blkdev_common_ioctl
      => blkdev_ioctl
      => __x64_sys_ioctl
      => x64_sys_call
      => do_syscall_64
      => entry_SYSCALL_64_after_hwframe

2) Increased low_watermark_threshold to 10% to prevent system from 
entering into extremely low memory situation. Although hard lockups 
weren't seen, but soft lockups (clear_shadow_entry()) were still seen.

3) AMD has a BIOS setting called NPS (Nodes per socket), using which a 
socket can be further partitioned into smaller NUMA nodes. With NPS=4, 
there will be four NUMA nodes in one socket, and hence 8 NUMA nodes in 
the system. This was done to check if having more number of kswapd 
threads working on lesser number of folios per node would make a 
difference. However here too, multiple  soft lockups were seen (in 
clear_shadow_entry() as seen in MGLRU case). No hard lockups were observed.

Any insights/suggestion into these lockups and suggestions are welcome!

Regards,
Bharata.

