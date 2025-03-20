Return-Path: <linux-kernel+bounces-569382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50935A6A219
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54420160802
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741E214A97;
	Thu, 20 Mar 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oprmage7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E3D2FB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461694; cv=fail; b=AQvYRi2YzPbqtOq3Lp7iXR0TFcEVTBSWgjNf74YpFkDHkrAe4OxUZ3EE7H5yoD+wQekvSSxIjxV1PA/5efd/7koiVdGzTNKXEeI/8NqwJ7h6ZIrQq61JHwvY1weMNu0lNBqOptmS4HFl+szbaqRRqc0NkUr42Ue1jt35xZGXxwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461694; c=relaxed/simple;
	bh=TXttEbS6wF2ctUDwVs6Z45LVrWOMlj36co2UoQJxHH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/45JrAnpG/Qy5gI1nCqJjx5SeUVHCp27tzCPxsr9ResH1m1qVdpXO2/5BeSfMBZL2F0aSj00OO41ezxsLclmhzYT9w4jWM10F1qVnHDUpaGwXdvTyx8EAwvvnWoX/RfkNLmsGDxWRoG4duQaH0Fse4PNboEbwuCaY0C9kv43Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oprmage7; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQyJWzvGRsi6Snw2PFdm0Im0ddwsGr7/x+yE6/GkspkJ3tX3WLqOl5NIsTqOUCIM4sQzypCQl6hONOUMZd+7a2FycwdDOJ/oHE+pBDWKs65BL3CplNO4KGV6PZlqf9shuGjcgyPmkhIkDj2krEl3SpSxpMqXU7WXuvo5fSKG7t52lU6xxNmAqXIEwct5+UyQBzX2wAb0bRqtnctbw6XDEmqVb6vENETHcSgWxT5V5ArKcXQhuVgZpHWvUWVQQvAjEz/1ugvSwHq8qtAWhnqT47z+PmFpkSSGCFcZ0gvtUMJJJ0KgHq6JI4BWEz4fhIHh3+xzaJJuGMg3f1uFwBrYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKeUGta0mvhSOzxyMtnieLJ65dEeZG7qZWo22y9x8yA=;
 b=JtzGqIjYz69Gic78eKdKrNSnWT1RRpb4WV+yhZwpfCYVHgGp8P5pxkqRbtAyomEKMiva15sNSJtH8nHZTKbOIoxlrD8Vp1Ejcyr8JmtKEX12uL4Eig+7WFJZn2caYptKeAa2thT6HcVJ55qBsQTvqWoOtTv99m6QvRUkkSEZ90+4kC198UAlXzG27AfTWflHxvozWDAbzmvAvK9xPBMFPD/BSc2dF/3sccZ3EmNeu7qD3h8ZWoLo88MuVdfRsn/NKnEBtIi6sXJYBszxvNopKzO1zJwDLjetgh8PsfA6vTVmIRAKtg9ZsLPmoWb+yfWkk09q6MSmTrODg0gxY4wdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKeUGta0mvhSOzxyMtnieLJ65dEeZG7qZWo22y9x8yA=;
 b=Oprmage7jEwy2UVn2XOJdBkYTqOf7GANdVK9VKVbcFz34dzyC+aWbiFeJVwgxQZ8IKc9byy8jc+H8yY7qzirV6gsxPlB0Z5MqtbbU0135GEBnuuFYRJ82mkfldIxFM4vIFqzEVAWTlKvhbvjCp2r3mto4Ekvq/QM3Mrrxhrk0V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:08:10 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 09:08:10 +0000
Message-ID: <5673b1ec-d970-4aa5-bd58-b5d3504c4eaf@amd.com>
Date: Thu, 20 Mar 2025 14:37:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot
 pages
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
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
 yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <c6d9bd1c-9ae6-48ff-88ee-1dfe25eab5d4@nvidia.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <c6d9bd1c-9ae6-48ff-88ee-1dfe25eab5d4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 458dd759-4ce1-4573-84ba-08dd678ebc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXpCSVJIWjFmNmRtRWgwUmtHVFZESnJVbDVKU0NvYm5qb3NSS3liSmZneXpv?=
 =?utf-8?B?bjgwS1JVZEdpTHE0UGJSZTczWEM3Umt4TGxYelF2eER2VmxWeWozZWVKMXg3?=
 =?utf-8?B?d2dmUjM3NjhmTHc3ZkY1VTdHcUJnMUlKMHFmQ1dVMW1ZaTcwNHN0S0d2aUdK?=
 =?utf-8?B?S2pZZ08rbk11TW4xSXNDSGpOdFo1ZnhKUjRaKzBVanpjcjdjUHd3T0w1K2Fr?=
 =?utf-8?B?K3VmaG9uMmY1YXNXWGRsK2c5eUxoQ3RBT0dDeXlyTjZQenU5Q1ZSZkhMN01u?=
 =?utf-8?B?ei94b05BRnVmZ0I3YmM2K0tnWDkwTUFxUlZhYis4dXQxckdzSmN4cm1KWGg4?=
 =?utf-8?B?SXVkdHBzMVRUa3NwMm92K2RwNlErRjVpRGhwbC9zMDNaYm5MTzlxM2QveHZ0?=
 =?utf-8?B?Y1lKdTQ2R242SnYzYnJrMWRKM05hMExQTmJ0VDFGMmdzY0IrcjF2MFJRRXRD?=
 =?utf-8?B?K1hrRTI2WXBCT3ZhbGhnQkZXUTI2MHJSbmVuM2s0Qmx4YUtsanR6RDFFQWhx?=
 =?utf-8?B?bmtzNUtMRTQyNzBxUU16QXdkZU1mSDZDZTBVeHcyeG5ETExhRTVtdW5ER1B5?=
 =?utf-8?B?ODlZSXJLNDhqMHNaMzQ0cmdWZjd6UDdQRDZ1Z1hFSU94MmcyVUlFYWIrcCsr?=
 =?utf-8?B?c2hWdURxQXFjSGVIQ25EbDNEZVEwMDdZTXQyWkFtYVVxbVVtc1VRb2RubEMv?=
 =?utf-8?B?VUdscXZvZmp2YXVLUzdDT1g3Z0VOZVpNdUVUSlVnbHRYeG5WdFE3c1hLQmh2?=
 =?utf-8?B?WlNzUXpPTWZPcG9iUUdPaUk5NUkzS1lIQUYrc3JBVG9pYjJvUmVGUUVxZTJa?=
 =?utf-8?B?eWZ0c3F5aEYvVzhISGRhOG9oZ3UwNHNJSjVKWk8zeUVabWNuU2lZRGRhQkNG?=
 =?utf-8?B?Y0FaeEZoZDZPL1k3cTgxbmNHbW9rQzJqd3ZsVUFqOEF3TTZCL2xmMTdjWUF5?=
 =?utf-8?B?SC8xdVB4QSs4WUFHN3g1Z0lqenNVR3IwWEJ6emxtL1ZmTFZPVTcxZEdRaDNl?=
 =?utf-8?B?Rk5YZkRyZFV1UkNtTXhMM0FTSm1jcEpxK0J1OGJFaUhUYkppNEU5REcvdVdx?=
 =?utf-8?B?Y25nTHU5aFNqamZ4NkVkWDgxY0o4bm83RzhlY2YzbG92WHRDeTltb2VETlNw?=
 =?utf-8?B?M2tuRjZaZytFNFo2TklFZEYzK251M0sxQlpXQ0RyWGp6bmFVQVNDQm1aRFMv?=
 =?utf-8?B?TnhPN1VvQWlVWDZhTUtPby9PNDk5SHdYd2szSWtBVmpPSjA3bUY5OThLT1lh?=
 =?utf-8?B?VW1CNHhSYTNnaE1tek9pV1RRc2F2NGVDZFVqSWtnTVZVeWI3Q2FrMU1VL2VC?=
 =?utf-8?B?eGp6dHhuRDk3Y282aExtbUdJNFk2ZStWV0FtSTA3a1EvT3V1VTQvSmlaRkhs?=
 =?utf-8?B?aDRRRFRLWUR6N3JzMzQ1bkFLVy8walN4NTJmUVh5L05hcXYxU0FlMmoxdHJo?=
 =?utf-8?B?aDNWVng5RUNHOFYzRGlsaWJ5MXVTWG54VTJHUVdKNllMZXZQcHMzNE5BcGlJ?=
 =?utf-8?B?WHRaQUxrb254dFlUTjR3V0Nvb1NmRnJDc0dBMDZtMW5CTGsrcTJkT3BpRG1z?=
 =?utf-8?B?OU1zK0ZaZzRIOVpVNlZsR3dGOGo0Mk0yTlJzZnFYMURSSFF5cVc1V3RyQWNL?=
 =?utf-8?B?RUFWNVRQSit2YUMrcTFCa0lGUFZuTjNMVllFTnFZSUo2ZGpsUFZRV3EyVnhq?=
 =?utf-8?B?ckpPV3BlY1gyb1gyUCtqd1hDRitPNzJWQmJYUWdCTDRtYzg4bmxhM1lrZGZp?=
 =?utf-8?B?WjFqN2IwMVc5ZHRJK3FXaGlxT0V4bTNMTUl0dUlyWTAybEY4VlRnY1gydnVK?=
 =?utf-8?B?OE1ac2g1UnRiZlNvT3VDM3ZXQ1VaK1pJcXVKNE9mTCtSZGJPQ1ovUnk2anFl?=
 =?utf-8?Q?/QNzOmlW0cwmf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkpYeUlzWG0vNUxiN2lOL3ZBS0VzbnA1QVBiTXJ5WG0vK004aFRVYnRlS0hW?=
 =?utf-8?B?TytzWXFBOWI3aUFzMjkwVGFlS0NtRTd4MUNqZnZ0WFVPZ3RBRDRmelJyQmZH?=
 =?utf-8?B?TmJwMDFoVlF0S2huWS8wdHhlVmVGaUp5UEdya2w5MEVCRXVrRm40MUZVcXZS?=
 =?utf-8?B?WWhiSGk2dVNaeVpTeUREQnJ6YkRSQXJ0RkpiTjNISUc5TGN6bm5DcWc2ZWNW?=
 =?utf-8?B?MG1OeFNQZHVRUHFQRXlGbGFXdWVENS9lK3ptSG43eFZ6N1p2RXdSRXRvR08w?=
 =?utf-8?B?Rk9UU05PRUdjYXNQMEdQOFloTWNpNGsrcUxOVlhsSEZKYnBSQ2tTenVYdmxS?=
 =?utf-8?B?bXlWNWFCZXoveVNCTVFzdm5yRHE4QlpwdFdXVEczWGM1UlFFblFBTE5ZdEF3?=
 =?utf-8?B?ZDhSLzF4NHJzcHVISFU1Wk5sNWszNldXb3hxNW9ueDZuQzc3Q05aOUVESyta?=
 =?utf-8?B?Z1NOOGVoLzZjaHRqRnd4OW0yS05LOURGUi9VbHNLcEYyVGpuN0k4QUdrVlN2?=
 =?utf-8?B?OTk5YjZHVm4zOUZkNXhjOTE4TUI3dllRd3ljZWoxZGtrMnFFbVJwemNxNHFt?=
 =?utf-8?B?OWRwanRMUXpQcWgvVVZLcHlFRG92VTllc2ZCaUtGS2dyYVh5NXFzMDRHZ0NX?=
 =?utf-8?B?b1BpVmw0d2VHb1dHd2w1bjhUV1YrSHA4L0dCbVdlUTRJSFdLcDMyU28xc09l?=
 =?utf-8?B?L1BuWWtUencxc2VQVlBYaENoR2l3VHJvRDI4ODRhS0p1Vm9mMGFJTFJINnB3?=
 =?utf-8?B?T3F1YlZnQVQ0czZOSTREdXU0V3gwVVExcnBYVFdaK2V5bVRWZEpUaGh4M3Bs?=
 =?utf-8?B?d0RpcXFuQ2xTZU1SaWxLbnQzamgzVEpuVDJNU0pWRGRrdHRJei9IK0crQVI1?=
 =?utf-8?B?SUljV1pDWHFQMDVyc3J1ekMwMDFJWEpqeG9scW8rVStjbHRoKzBFdlVjeklT?=
 =?utf-8?B?VUJPYzRWVllFSEt1aUZVU2tmWHI2TkFwaHVtekQ3R3NGT1VpSG8vVmVYbVBV?=
 =?utf-8?B?VUFZSEwzSDh1OTQweUpuaVBLN0RBaEwzaDc2d0xsQzM3WVBOSEcxcGxFZlhF?=
 =?utf-8?B?L1QrNVR6bUlmNm0rbUFTWGtOTWJXdmsvc1FqVkRSV0lDdU0wNGVZSmRtR1Bx?=
 =?utf-8?B?QkRhcE5EMkxGUmk5OU81NkdtNURlRVd6UE9QbWsvcnVjek5xclNDN3BjU2pn?=
 =?utf-8?B?clduZ3poYTFDN2RidjdPZWJ6NkpSWFd0Y0xreHBoTU1FOHFZRTMrR0N0b2R2?=
 =?utf-8?B?bUNkR2dqaU9RTUFsQWI5OFFjQTlDcjk5b3lqck9EZHM1bjVXeGJnYjJET2ho?=
 =?utf-8?B?ZXMrNTR4NU1xQUlLcWxmZU1Kc3Y1ZGI3MVo4TkpuaVFhaDl6REwwczZILzdy?=
 =?utf-8?B?M3pCRWZJT3NJODBxeGZHQVVEc1d5Z1Q0OGpoeXhaY0d0enlkVUJQcWtTQmtK?=
 =?utf-8?B?Rkx5cXdnK1l1ZUU1MkRvVThKZWtYcllHVTh1d2RFVFU0VGIxaGJJN2pGNjND?=
 =?utf-8?B?Tmtub1doWC8vbmYxSzNTbHIwa1ZRKzFPckRwVGZDK2k1OGRYdFlVRFhwMjJB?=
 =?utf-8?B?c1JCbkszSUVnUkFZWTY4c2pNNkhQemNBZzlkRGtQY3hzZytFZzFqOXVEUVdn?=
 =?utf-8?B?cXlrVnFEVDZrSTlmUWdDRHdoc1BsY3psSGhhaHFpTmlWVVloQjAxTXRnb0xp?=
 =?utf-8?B?K2lEbjIvRWt6ZHQrM0FHMUJIQU15KzJabFNlblVNUW1pS2t3UkpRUVltTHBR?=
 =?utf-8?B?d1VjblhYUkJKY25JOWMvYUdnbzFkdGlhVHFQUkl1MGxxVk9LVDdqTDczZXZO?=
 =?utf-8?B?Skp6SDVoSzBYT2NyU0huaURCeFpyM1AvVTU5dDNMNzg2Wi9Ta1AxQUV0cTVF?=
 =?utf-8?B?QjlJYjFrNDdReldVS1gxSE5HQ1o4QjA4VjNrWHBjZEhsNXh2OTdSdEJHalF1?=
 =?utf-8?B?aDBsRUJEYU5YQXVCdExhalFlbWFyQlFNZ0s1Tk5Bd0lDYWwzaDBvSFVHUnAw?=
 =?utf-8?B?enE4SzlzVytnYURrL1BJV2ZhN2d2Vjl5UTJOa09CUlZveWVrVG1HYWt4M0U3?=
 =?utf-8?B?U1BXbjVEV3VEbEdRY3FQc01HOEh4c0JYbmVyc3lROFRocFk1Nzd5WnlXWlpw?=
 =?utf-8?Q?rq9J6iSb9wsEsnUsa9WxKcpWT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458dd759-4ce1-4573-84ba-08dd678ebc26
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:08:09.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdiqtgOv1xZT/xBz8Nv+i2wJF6raQW1NEZNFDOY/cPWRxFWjJMck0RQt8GRiSCwjz4+gHLtdOnzkRNNs4HXWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

Hi Balbir,

On 18-Mar-25 10:58 AM, Balbir Singh wrote:
> On 3/6/25 16:45, Bharata B Rao wrote:
>> Hi,
>>
>> This is an attempt towards having a single subsystem that accumulates
>> hot page information from lower memory tiers and does hot page
>> promotion.
>>
>> At the heart of this subsystem is a kernel daemon named kpromoted that
>> does the following:
>>
>> 1. Exposes an API that other subsystems which detect/generate memory
>>     access information can use to inform the daemon about memory
>>     accesses from lower memory tiers.
>> 2. Maintains the list of hot pages and attempts to promote them to
>>     toptiers.
>>
>> Currently I have added AMD IBS driver as one source that provides
>> page access information as an example. This driver feeds info to
>> kpromoted in this RFC patchset. More sources were discussed in a
>> similar context here at [1].
>>
> 
> Is hot page promotion mandated or good to have?

If you look at the current hot page promotion (NUMAB=2) logic, IIUC an 
accessed lower tier page is directly promoted to toptier if enough space 
exists in the toptier node. In such cases, it doesn't even bother about 
the hot threshold (measure of how recently it was accessed) or migration 
rate limiting. This tells me that it in a tiered memory setup, having an 
accessed page in toptier is preferrable.

> Memory tiers today
> are a function of latency and bandwidth, specifically in
> mt_aperf_to_distance()
> 
> adist ~ k * R(B)/R(L) where R(x) is relatively performance of the
> memory w.r.t DRAM. Do we want hot pages in the top tier all the time?
> Are we optimizing for bandwidth or latency?

When memory tiering code converts BW and latency numbers into an opaque 
metric adistance based on which the node gets placed at an appropriate 
position in the tiering hierarchy, I wonder if it is still possible to 
say if we are optimizing for bandwidth or latency separately?

>> This is just an early attempt to check what it takes to maintain
>> a single source of page hotness info and also separate hot page
>> detection mechanisms from the promotion mechanism. There are too
>> many open ends right now and I have listed a few of them below.
>>
> 
> 
> <snip>
> 
>> This is just an early RFC posted now to ignite some discussion
>> in the context of LSFMM [2].
>>
> 
> I look forward to any summary of the discussions

Sure. Thanks,
Bharata.

