Return-Path: <linux-kernel+bounces-405944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A79C592A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A471F234A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119C81487C8;
	Tue, 12 Nov 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UAlXWGQC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DC27083D;
	Tue, 12 Nov 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418372; cv=fail; b=EvL/F00308hXtDDc4sc7gXVKZ6IMPqyRCDy7xd2KqufOpSRDpLLDS0/1ABLSrBrhw0JlG5Bc5akQnGXQPNMKbwDinN9amc3KejNQjb7C/zjVaOFhB7y1ivt29yDIDsH4UqWkeXoXoFz5jSaZZUcLYnJRKUK/nrvd/6IPJqB+z/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418372; c=relaxed/simple;
	bh=zJ9985Z9FH9E170hkopQCYsDjuB1bb182nb0RlssDj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TAzk/ykQKCJ252QmjkepVoVA2GKEulU9Hxp08gZIcKO9DlY9jSkBBHzlbXRWkfCcL+FVxlBlOfSOZuc36zwxZS5xzrydc79c2d52rW/s8o8sEKKaWNUZcO3fdkmA3p3yqwc+bMKiTavVrMRxGJyO92/CRuQ+TU8JIiMSz3S7tWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UAlXWGQC; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIuU6t1/wkqxq8QEbkUdhlDlXgT0BfWSXfdbUlf8eOpHZ01JAYTpnuFCNny7F0zet+uAsn/Cw7IBQ/i0V2eyeKB5pbYtCTNK9R1Vjwf1zr1wBPIHD89SyGUg5PFdGsX8WjpP6K5ZJooFZykdIg0hnQMdkyOQ01zIC/S9G9eVHj2cL07UqmiszfaPNE8vNwZ7oMuoQJ9vsoq1FVsmtky4AfIZdjHgPA/VVd4G6MVYILjrjWi3DyNRrRW5lMFCQeaAyAe+xARG4Ppq/eCVIZTDUL3ir2cXEqSSAIo4IxbQ8bFgB/6PVSbDcdL2Jd4D4L5P/T1EHCK2f16s259gJrZBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn9bDnlJLI6Wpis2ikdyaaaTA5QvDWQXUeiEbo8I7tc=;
 b=A1ni316tLGQc83XWOXeOVmki+eFXiodoLxz2ppDWmjUGrwGkUPKSSucLXBFi6/BnvklPHx2ZQ/ENMSR2Hbt2X5SicEE0JIrFSCW5fPuXHcNzKp8/hOcj3zrpWIn23BubFt4Eow+b33sZ6dH2BGqsaG4bdNHR2SL1AoKJGFqrYI4HKTFhC20Ns5JjA/dy88VqdEN6ooGi7HisUSSaCEHb+4X+MpXVgCdD5gcwqwnxLP+d3t2BpWIbq1b4QMmT2tpURMi9a0pV1WqerRJfvGURzcjv68SmEVj9ZJFKXWEhsYqnPXPUuYLIi3Y30p3UX3/GvZQ50PimHVFYqgg9YTuH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn9bDnlJLI6Wpis2ikdyaaaTA5QvDWQXUeiEbo8I7tc=;
 b=UAlXWGQCzYacaCsEd2YUzvq2MDfh8plCbHlWYyj7UpxQJDpk/sd8o2bhmHPpIB8RZJBZRP/RZ6UMnqV0JTV6MGj2OeLivInSLWjedbwBFDo7jm6FQELIive6kQ1BKUO9E4lu5VpjpUvuNZwifpdkwOt8V5kjUSO5wnzy1GYDjsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 13:32:48 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 13:32:47 +0000
Message-ID: <2a02f0c3-f535-4ac0-d29f-a33e0c45cf4c@amd.com>
Date: Tue, 12 Nov 2024 19:02:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] usb: xhci: quirk for data loss in ISOC transfers
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 linux-kernel@vger.kernel.org
References: <20241112122104.120633-1-Raju.Rangoju@amd.com>
 <2024111226-spender-saturate-dc6e@gregkh>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <2024111226-spender-saturate-dc6e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067EA.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::26) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 17df893c-ed9f-492b-df5f-08dd031e7f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVpNZ0ZJUm9VUVlXOUZvQlpXNTQ3bGhEaExJNjRZckFyWUpObFRDd3Z1UStJ?=
 =?utf-8?B?UW04NVpSeW9JaHgzbWc3V2x6Yjg0akFVa0RaVTgrYkl5ejBDTnRER28yMTBy?=
 =?utf-8?B?bE1SL2EvOHVaVnZSMWorUEl3NFovaUZ1NjQrNVJqNUhNQnhIVDluVDd2Y2Jk?=
 =?utf-8?B?Tm1IbEp4aWVabWFzWmU3eDBtWGFRQXAvY0ZDTThmTHhwY0tsNGN4RTVwNGF6?=
 =?utf-8?B?MEMyQnhadEFSYU03M0VMTzhKbUczQWtOS2NKQlRsd1R2M3BPaENRLzVlSG1Y?=
 =?utf-8?B?bS8xeFByQ3ZWOTBiTW5USjRDWHdHZkJ3M2tEVVI3L1ZQVmd4RTdGWmFPbE5y?=
 =?utf-8?B?ajROMXdMVzZ5Q2JyVVVFOGNMa0ttMGVLcDdGR3pKWVVLQ0JqN05JTjRMZ25F?=
 =?utf-8?B?K2dZZzlCRzdBZEpVR2RQMHpjdmJTWVNCYUFiYTZwQjNmQWpFd1UzRmZaUGZh?=
 =?utf-8?B?bnhGNlZrT1JwSGNWdGpXMHN5bm50aCtreEFSZ282WGNESVgyczJNd1hzRlUy?=
 =?utf-8?B?WnJqM2lQUnpjOFgvb2tyVkI3U0ZrV2sydk15V1QrbldQaGczazZyaUY0dVlQ?=
 =?utf-8?B?WS9hTm4wV1d5ck1VQ0JnV20vYzRMQW5ZbG1meTlRaHN1WWwxSnBoVkVpZFZC?=
 =?utf-8?B?czNRNlVsbFB2MFd2dHI2bFhVWWtEZ1JXSVNKRUZJMGt6YWw5VDYwQXNNTlBT?=
 =?utf-8?B?Tng1T3NkdE1EaEs0KzU3K3FVZ3JqcVU5TnpRQzlORWRiV0hIM0NGK1drQWYz?=
 =?utf-8?B?YVdkdFpuYlhocnA4ZWk2T1ZYYXN4WldNcHR6eXpSWmVWYjd1ZDVKa1lDTkhM?=
 =?utf-8?B?bGFIdllhd2lYOVNUNDZLbzJ3dXNoNTVGdXF4c0xlclduVE5SWjZhODZIVGcy?=
 =?utf-8?B?RGgrRlNRY0x0blFocG9hYjQvNHZWLy85cTRHUXV3SVp2N3BCZk5SOFJvTUVP?=
 =?utf-8?B?bWVjOGhUalBMYk13SWdFaFNKcG9JVUo1Q0NCcEdBNER6Z04ySXdBNGNsYlV4?=
 =?utf-8?B?ZjA4WVdXRlo2TlZaZ0VJZU9IWnFRelk0SnlKaTBGY2RLK2dWZWdsanlJdjJm?=
 =?utf-8?B?QXNvRExGT3d3a3hzbUFTTmJDKzBuS2xkODI2TUlxQmhxMWx4czNKT2Y4MnhN?=
 =?utf-8?B?L2g5UnhVbm9pOGxuVHVOODRWYzVQMDVIUU8zWVk1ZXRHNVlOOFNueTFLamEw?=
 =?utf-8?B?dGc1Z1ZRcXhTTTlRSVBxSHU5NEs3d3lSUnJ4dDRSNlRWV3FpUnpJaGlJWlpl?=
 =?utf-8?B?KzVSZlZRYXJ2ZUNMY252R3A2RGNid0M2bjhEOFMzK2tOZllzbUtER2ZMWEx5?=
 =?utf-8?B?K21tLzJWOFFGeVptaUVmajYwU0hSZHVtV005N1NzNDAxTXRuWUpTVnEvWkRm?=
 =?utf-8?B?UU9OSnBaU1pzNFkxN3pjUVY2UXo2a1lraEJ6dTZLYWVyall6bjJKUG1sTE1w?=
 =?utf-8?B?Rlo0NmNnT1BzM2dGbzlObUFRSTR6WkZaM0xmaHlOamppbW5WVDZNdlB2Z3o2?=
 =?utf-8?B?T212Z2h0NHhXN2w4WWcya3cvQWdjQkt3cVNyV1ZVQzZERHR1aDhuMW11alhP?=
 =?utf-8?B?WnZPTGNTenI2ZXoraDJ5bU9iZm1YaHhIZG90dDhDeUZpaHQ1MHZXZDY3eitl?=
 =?utf-8?B?cXp6OWNxNFZCa1NVaEphTG9WaURCYkVZTU8wUTI5WHdSWUtPWGlKMmQ2OFdR?=
 =?utf-8?B?UVdBbkwwekxJSkZRRlgyOGJWZ3JMcldTTmx6SjNwc3gwRnhNcldlOWNnNEZm?=
 =?utf-8?Q?dPoYNwVNfVor+pJzzKHG7k43qgZO7njAILHtxxb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpFYVdrRXRsK3FNY2xMKzRNRjBuYVNkNWJXdnhCMzVFamovSVhqby9RRHpV?=
 =?utf-8?B?VUxBSmtDYUpiSzBBQkpRQXkwYmlLWGhrTkcyYy9vVjQzS0JDUDEzcC9TaU01?=
 =?utf-8?B?Nkp1Q25nbTNyT3BucjhBcEdMMHJSRkk2ZGhoN2hSdjMxZXVTalRUOFJjbENu?=
 =?utf-8?B?Y09PYzVvdmszajRuT2lrN3RYa1M2V25pcTZ6alRUa3FYd0dLYmJ3Vzkxb3FJ?=
 =?utf-8?B?UndIU28zVDNNOHdhNi9mclg3QmM3UXFIUW1UVzVSakZkS1RzY3FQT1hqVmNT?=
 =?utf-8?B?aVQxUnowWTkrL2I2QndxNWx4dWZhemNSbnlIYWszcEZqT3J0ZUg5OFVBQ0hP?=
 =?utf-8?B?OTMvYWFYb3ZsRkNnWjcycURKWmsyRys2blpTYlVWV1FmZGhTNlIvME5kSFM2?=
 =?utf-8?B?dVE0UU1SaHprK0VPdkdJcnM1THVpaXA3YnlHKzJEMndRb0tBWmsrNGxFOEdq?=
 =?utf-8?B?Skd5R0Vpb1pyN1llWDMxRC9sWWUrUkthNDlUblBreXpUMTNzU0l0WGJhNzZk?=
 =?utf-8?B?UzgwbnY5QmRCdXBPcWtFb1NvNmR0cGI5K2lPRWpEUCs1d3VDYmt1RmNLK1U4?=
 =?utf-8?B?d1M4d25yUW9Qb1ZnTzNqRWJhZTBsTkw5d2tZRitUNzhXZEk5T2g5eXhTczNl?=
 =?utf-8?B?cGxhdExDaDhEK3dGcUNZU0E3QjVBaHdyZlc1KzRPUStXMzQ1dDdmS3VCS0F5?=
 =?utf-8?B?M3lNNlFFbW0yQk5RdGY4ckZsVkZ3RU5HYnJKZ3hPWWhhZGFsemQxVnliYzJy?=
 =?utf-8?B?OEJxNTI1UXhwNUs4VTUyTnczOVowQWJ0bkZ1RVJ2dEd4WlhNTnVndzZZKzNN?=
 =?utf-8?B?ZkJjUTlkUW1wNzVROHNsQlExcVhYRngxY2JuN3pBelM0WndBbDYzd3dkTyts?=
 =?utf-8?B?ditvOGtGN3l4dWRpR2c5MUQ1S1ZyVmhNa2tmcEN5VGxjM25ZZHJGcmwyNitp?=
 =?utf-8?B?K0tvd3ZRenZLK29rUlVoTERNMjc4RTVXbG1UMkpQaEU5UVBPb1lTUWN1anQ4?=
 =?utf-8?B?ejAzU1h2WWN2N1o5d2RHYjVOVHIxelVaUG9aMUdPVzUrVFp3M0duaXEvb0J4?=
 =?utf-8?B?RGNHOUdjTUNCV0NhNWdoOUFTbWpxbno2MDd4NWdTclVQWm05ZnNzSmYrRDlQ?=
 =?utf-8?B?M29GQzRUM09GUFlGQnR4aUw3NFVSeTJ4N1o2cmhRREhwMEkrVmRSVUFwRDZs?=
 =?utf-8?B?c096MEcwOEsrQWtmcG9wSXFodXc0MEM2WkJISk40ZTFRL3JmZlU0M2V5Mlpl?=
 =?utf-8?B?aWpOQUdRUWdLSllSVWNQMW5qZHlZZkhIcUp5dUNRbFBmTlI4Y3ZBdjJiNElP?=
 =?utf-8?B?NUhxdmp2T1NtUnM4aWJubFNDejEvV2ZFcDZXdE5RdXUrR1pnemVad01mTEgw?=
 =?utf-8?B?VkZUS1R5UjQwSWNvRy94TW5nTlpycFpwVFVuUlJKbmY1OHJHT0t2WTZ5M1gv?=
 =?utf-8?B?MGpwTDIwSHpIaGh3MFpvWHpGOHMzZXJ2eW1DMGhrRjR1OURsWEdsZVo2bTdh?=
 =?utf-8?B?Y3dyL2phUCtnMU1CMUVvZkgyZ1oreVl6Vi9qWW5rSWJtakIranNQQ1dNQTNK?=
 =?utf-8?B?dytsdCtqeFRKbmFFMXBJdENic2piUE4wcjZTUkdQZ1ExSDBWZ3V0dWJKRUw0?=
 =?utf-8?B?RzFLOTZaazNCVTRzVTJtemVTUkRYRktTOFc3Qm9wT3d6K1N0OER6MnRaM3I0?=
 =?utf-8?B?a3p5cTQ4NWx4M2orZGQ5c0hFcXRYSnhtL1N5OC83S1pMa1QxSkYrQUxUd2h5?=
 =?utf-8?B?VnFvRG1uQ1d6cHUrakt0NXVwNEVjUVdwQ3VNNzJiVWdveWVrdFRCTGlNTjJk?=
 =?utf-8?B?YTMxRDBQeHl5QVcxZjNycmx2QjI4T3hiUWhPVTg2SGVQYnJQM0dTdWNnVXpJ?=
 =?utf-8?B?RFhucDRaRlVhNzhteDZJNEJiK3hQNzR6OGVqaW5pSDU1SzFscDkvdnhiZ2I3?=
 =?utf-8?B?RERTZ2g0by85WW5tKzMxVnhOd3FxTUdTYnVWYTRwWG9NQWVyeWF0ZWRJbUFw?=
 =?utf-8?B?N0xrdXFjZDdEUmhCT0Fra1J5dWlWOUcrWmtNa2JONDdhcHFhbC9US2VrYkxi?=
 =?utf-8?B?MGRLWFE2b3hMcTJ5VUxrSnAzWmFIQ2J2WlhCNCtEbXRDb0lGdTROMGRxNndo?=
 =?utf-8?Q?A0nRPEkLsH5DBJ0khiKgIedHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17df893c-ed9f-492b-df5f-08dd031e7f1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:32:47.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRGVpCycZd31FWjl0BOtgGF7XKerlGHj+jrjuWU60lbw4pKMdTx226oJ7J/0aO0O+soaxPqhcGIxG075hzIimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462



On 11/12/2024 5:54 PM, Greg KH wrote:
> On Tue, Nov 12, 2024 at 05:51:04PM +0530, Raju Rangoju wrote:
>> During the High-Speed Isochronous Audio transfers, xHCI
>> controller on certain AMD platforms experiences momentary data
>> loss. This results in Missed Service Errors (MSE) being
>> generated by the xHCI.
>>
>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>> being omitted from scheduling. This can happen either when an IN
>> endpoint with a 64ms service interval is pre-scheduled prior to
>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>> endpoint is shorter than that of the IN endpoint. Consequently,
>> the OUT service is neglected when an IN endpoint with a service
>> interval exceeding 32ms is scheduled concurrently (every 64ms in
>> this scenario).
>>
>> This issue is particularly seen on certain older AMD platforms.
>> To mitigate this problem, it is recommended to adjust the service
>> interval of the IN endpoint to not exceed 32ms (interval 8). This
>> adjustment ensures that the OUT endpoint will not be bypassed,
>> even if a smaller interval value is utilized.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> You don't want this backported to any older kernels?  Why not?

Hi Greg, Yes, backporting is needed, but some of products were released 
back in 2018, not sure of the exact commit id to quote here for 
backporting as there were no precise commits that added this initial 
support in the first place.

Would you mind tagging it to all stable kernels. Let me know if the 
patch needs to be respinned.

> 
> thanks,
> 
> greg k-h

