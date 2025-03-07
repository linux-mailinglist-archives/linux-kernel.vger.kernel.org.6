Return-Path: <linux-kernel+bounces-551728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A72A56FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E796189241D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84BC23E242;
	Fri,  7 Mar 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hqmEEYtB"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C823E229
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370348; cv=fail; b=PKqpsM4y8bHreZEFI6sRiqeSR2POVGQ3ywB2IKFwP+isz3tCvQ6+/1S5jazibXRpk28h5v0OAhZMGu3QNzcJ3aIgrbaD7pFPzecly1wQ3lb5tsjL1sjOeQoaLc0zNhiUC5v3SSdZ4FOC0S/phwfmPM5UCyOY9bpMCcJYzFhpyJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370348; c=relaxed/simple;
	bh=tbTSaa4YhXmUHh4yk6bsfDs5tAaF4+j94YIfB7KxDr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KE5K32L+I7FwlVteFsDpG7VuUbFzNNE/u8VG9io5BJqL8ujah8np/opFhFTSkxusr+J+6FvinVLMOjLXJJmuad/8JUOj1VGB676gjjCKJetkCPgim2oAYPy1Bg5033vioQEEcYPeUjYYaCni5Vr6T6psgPWQ5fYgcHZ4/HATLrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hqmEEYtB; arc=fail smtp.client-ip=40.107.92.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8FHtjM4xnJOhRVcPUBUQVHF9JfcoBh7BFCInUU+28twjKJIk4+RShU6HDqHlSkoKqZRQzlHOUXid1EkxL6yoNDMtMZIb09MH6ZGKDzWavLA8vfkMn9/EAD3SFIDrBOjiVEMnoJAITF5QIgmO7N5eOWvBYVnhTVIN+tVr2Dg6qsGgr8v3kJqPQfvjtecg8Q/ydC3jYoR8fmnKi72Yaojy61x6o33oDbmjrx2BJjF9b9CZ3uLLIJVRVDaWXcmm/saxx+qhlFCSrImkkS+fhblPOSr/HLbPq2hiFLR2YlWtCHx+J/YqGXriyBYBWDaebHm++YBD/1E9UvLUNIM4hQe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziVMNXpmZCtlHyWedXm1qPaKYBK4sRqkHZnhfB7z9sY=;
 b=GcVPAsxWD1yfCu9xyYRTruEHGxmGCPBp1fUksoTtUT5mH9PwgDJMBf8LYb/qrN94leQFm7KobwaoLBEhKYOeU8/2TNwKNXNawwDGCYSrAHyEMy3fx/QZixLblNyAGcJyKiyfavrzts83vwYsc+d9/P9vbshYSTrYK2qQZECELbnf1IgqgHYnI/1dzpRiy7j0bpS2v8/YsdYc0t+Y5WatcfUyYdhgGtl6pzVsjDNYmZnVcxkZN2KdsRgPY8ErFT1yIVQALhEGa1aYTJwnMLvmTsmY1SNwUzeJ9Rk/6A0zFB6te3hEH5q7gkuujoHeY1RTSD04MRtTHeIsL0bdoFW10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziVMNXpmZCtlHyWedXm1qPaKYBK4sRqkHZnhfB7z9sY=;
 b=hqmEEYtBoL2KSsRtnrRtIcdjpDyu+FZ9HEh2QFhdRrUWb8fBI5XKatY3DgMkhyBstZ4WCec47h+HaphkPgA7PvuPkRkQdeCATulgMUDnaYhjXbqQUmxcadjd1ZlpV0xUAbM9za3Mut5/o+8fjtBP+1nK4IkXvA7rIP+1N784R9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB7187.prod.exchangelabs.com (2603:10b6:610:fb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.23; Fri, 7 Mar 2025 17:59:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:59:00 +0000
Message-ID: <be236fac-08d0-4225-bcb6-e039e1ae3ed1@os.amperecomputing.com>
Date: Fri, 7 Mar 2025 09:58:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pedro Falcato <pedro.falcato@gmail.com>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 oliver.sang@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250306214948.2939043-1-yang@os.amperecomputing.com>
 <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
 <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
 <fdd28cd2-d563-4bdc-8dab-033ed80ae287@lucifer.local>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <fdd28cd2-d563-4bdc-8dab-033ed80ae287@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cf2bad-0fe1-4743-16db-08dd5da1bd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Umk1cGJuQUp4RTFQMm9lMCtLTklvSFhyVGZKTmhHRkVtdVdKeUROTzBVbVF1?=
 =?utf-8?B?SW5iTTV1R0pGV2VsWDYzcEhGMk9na1RhVDQySWhrd0JTK1lpQjJoUXkwSFZz?=
 =?utf-8?B?N3VtV053c0NqVDRzNEdMY01RaVlOQ2JXTVlleCtkb0gzSnhXYkNSbU5id1RH?=
 =?utf-8?B?V2VjZVpZWlJaamlWdExOVUc3Wm0xQmI0cFJhMGcvalFDVnYrTTI5WkRzMURO?=
 =?utf-8?B?UXhqZXZYb2ZoOFdoYWViNlRUbk54ZmszTFlOaWgwOCtacnlMVzI4enBqc0dU?=
 =?utf-8?B?YjNzelNqbFFNRS93MDRnbmU2Z2xpb1I5NEVqbzBnTFhONjRJMzdjVzh2OHA2?=
 =?utf-8?B?aHh5VjFhcXFVTk9RZU14VEdZajBVSmU1VW1JbVAyTDlPRTA1cHU2WXFVN090?=
 =?utf-8?B?MmpSMXFxazhLUUV3dW5kZkcyOEovVVdUdkZCeUFDUDQ3dTRreXZzdGlhMEZV?=
 =?utf-8?B?WEh2aDRZTm5oYjVQMDJYemRyQWdBZmIxMmlQQmE4bUFNdWdRdmFlL0JTdms5?=
 =?utf-8?B?Q2lFOGU4MmRUN1hacHg4ZHFtRmxNbGJ4NGtPNkxmd2xvMFJLSGtkWkxpNFVi?=
 =?utf-8?B?YzhwQnB3VTA5Nko1RjEwS1JIRnVSQjEraVZFK2FHQndNemRtMjllc0YxZEVG?=
 =?utf-8?B?UCtUT3AxU0hiUExJY1lOUmZWSzZMdzRQN0Z0QzRrNjVjU2NDazNMUnRnMWtx?=
 =?utf-8?B?VS9sNGJMbjFjYlo0M0haN2pmcnIrbHd1aVZYTmJoYnNvUWVCU2thcmRLTGtx?=
 =?utf-8?B?WHdHT3NZRHVBM0RRZ3FCZWtoS1BZVDdXVUlHd2ZVYmpYODhEMUhGSW9WY3Qy?=
 =?utf-8?B?K1lWbUVQOG5iS1lwVzQvMVc3TVB3K3lyR25KNUR2Wk1mNm1mTG5wOGVHNlN1?=
 =?utf-8?B?aWV2OXBHMDR3aTBHQ3hnaWZocFYrVzlGd0Yxa0IwSTF0YzVUMXIwN2grcStY?=
 =?utf-8?B?TkRWUlZxWDRjN0lTYm8xc20xRTBBbFBzMW90ZXFyR1lweFRvK3JBVkd6NnhH?=
 =?utf-8?B?ZlFwQkNnNm96ZzNCVjIzMDNraU04dnFqYjllRnptZTJNU09VY2xXR0I3VzNj?=
 =?utf-8?B?c0dWNzg4enlVbTZvN21CQ2RJa1l3NmI2RVVnTzFHTmJ1V01rc09QM3gwcnpo?=
 =?utf-8?B?NFpyYWJKbUF0bkNBY0F3eG40NFI4Wi9GRW9WaFRiVHlNWUc0YUl5UmIrWDVr?=
 =?utf-8?B?c0JrM0JiSVZvTUZPajVoZDJLcmYrS0NFK2RiUUxsWExUYlpPd1Q2ZU16UkQ3?=
 =?utf-8?B?RS91YVhwc1RiOWF0eHpJVEJFK1JpQ2ZvTlVPRmhTRnBDVGJMU0RwWjBQZXBk?=
 =?utf-8?B?ekJ4c201MDhubVhSdEYrN1l6anY1aElCZE44Q1RtWXNNR1E4RFhnRTB0ZHQz?=
 =?utf-8?B?bXM1aGNvbmRDNE9PTjlRQWtPYlpjb2orOUhpOVQxUlBOYytTYkxVNTBIQlY2?=
 =?utf-8?B?dDBMU0hKVmxJVGV6V1BnRW9OSWRzZXVLZDlzWXFvMHFHdzRhOU9xc2crbHJW?=
 =?utf-8?B?RWkxd1lWaU0wanZlcTN5bDhRQkxkRy94aURVSTZrTXR6TmZpVTF1ZG5xS3Vs?=
 =?utf-8?B?N04wY0lUZzJpd1hGMFNZK1lGZFJxKzlwK3MzdWtFNFdUc0pNZThMMTVJSnlQ?=
 =?utf-8?B?U2V1dVB5Ull5VWZuQWl6ZkxSUHA5U3I3ejk5YWJLRDFDdFZla1h6Y1E4eEMv?=
 =?utf-8?B?cHpwWXNITEcrUlc3Qm1FME9FY1FidCtKV092QzBqaEtwZDBCQWlqMk13eVVJ?=
 =?utf-8?B?WnVPeFpMWXhjZ0p4VlJIWW5jZ0xyYkl4c1cyR1BjSkNCVEZvQXJMaVQ3cjFR?=
 =?utf-8?B?VklWWXF5OWZ5L1diMWduLzlRRFc5OWJCZjhBYjkwY2FydWRPMUdyMmpXcUNq?=
 =?utf-8?Q?bffZJkAXrC3oS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDU3Y2dkeVNMUlBMYXN6d2dDb0ZuY2NvenlmTkU0L1R3WXpVdllubGczNnlL?=
 =?utf-8?B?aUxadndXWEM3KzB0OCtFY0FzZVZ1U3QrVDRGVlhZUTBMY2NWVU5TbTQwR0Jo?=
 =?utf-8?B?ZGlydWpvbkdHMmxlL0VObjR0N3oyS0EzV3EzSEdITk1qWjh3bVA2aCtnRHhO?=
 =?utf-8?B?OVhtZ0tWYzlvRmU5MzRob292aUkwRTY2aDVndGpVNFp1Y1FTRzdtL2plb21a?=
 =?utf-8?B?WTF6M3RpeTBrSmkvcTdFTmp2OUsySmlwVE1EMlFGVTJheXZOZXdjTFREbDdE?=
 =?utf-8?B?YXNRSkUvaXNlZlNwWVBwbXh0bm9EVDVIQU1OMzlBdHh0Nlh1aUJXcjFXcURF?=
 =?utf-8?B?TzZXTHllZWZuVm5mRXc3czJqOGxnSWpLeXBnODM0VnhGeVVOL1NqM3JNUm85?=
 =?utf-8?B?ZGgxMjNFd0NCdXovbEJ6bU0rcTFUOHVYN3AyWlhHY0dlN0YzV3RRcjJEbXBD?=
 =?utf-8?B?emViNHM5bXo3bFJYbFdTeTF3a1lEMWNaQ0pHaHJEc3NGekVxSHdCSlFnMHdl?=
 =?utf-8?B?M05HSDF4Um5OWVpMc0lieTk4bStQK0xidFRMNm16QmxEeXpSMmdLbHBpR3lx?=
 =?utf-8?B?ZnpPSisvdnAyZmhIU0FWT2JIYzZWMjAvYk5DUU54NDM3eDdDdlk1bm0rdEht?=
 =?utf-8?B?SmprMVNnd01MT0sxOXJDZWRQWUJRZzRQdHY5UHI5MVdzRjNwZWVpR3R4Mk9h?=
 =?utf-8?B?NXFWUnArWmpSRld1a0RLWGlmZXM0NzRjNkE5c3R3N3cxRjFPb3hvN1B4am9t?=
 =?utf-8?B?cmZlYzN0L3RidVRDRUt1dUJkdE9mWkY1c2tFdzNUNFRBWTZXd0FHdk8rUTZK?=
 =?utf-8?B?QStwelhYbWM3Sk5ZUjFBU2xzTWJMYldHVzBDNmdKaHUxdDNxQWhMWnZZcTZQ?=
 =?utf-8?B?YzNITnBpNXhKc1J0VkNQbXc3SGtobXMySHpBMmoyYlo0bnNCYTRhTEJMeCtR?=
 =?utf-8?B?a3h5eU5hbVV1SWxHR0J4Y3lwbFBqai85QS9jUEU4bG9Fb2JtNDUrcnhpaGFi?=
 =?utf-8?B?SmtwTTQrZHdEN1NndFlMZDJuRVd4R2dMQzR1Y3c2S1V3eHh4Tjg1NWRwSk1P?=
 =?utf-8?B?TVJ5dzlERUsxZGZoZVovRDVKUm9jSWRsS0llVVY4MW54K2FVenFMRzdLeWZD?=
 =?utf-8?B?S1RhR2svSWNPME9MVzErSWhwVWpQb2lldlhBMVZEMTFtL1ZrdmgrZ1BoWkpM?=
 =?utf-8?B?TFNIZGhXUFgzb3p1ZTdRWExsUWg5dXBaUHB5dG9mcWNHVlpNNjBLcTNZZjFF?=
 =?utf-8?B?ZHVITUtObTBrOE1Eem9hTVRjaTBzV0RsYjNueFR0Z3hjeE0xR0xsVXBUb01R?=
 =?utf-8?B?ZzA1SEw4ak4xbWVNbmQvb1h3ZGtOYmNWaE1EanhSMDlVSm55ZFNTQmxkQjlE?=
 =?utf-8?B?T01kdmZqL1FZWE8yOGNleFNXeGdxWXArRjRkN0tuUlFScW9HTlZVWHJuYzJS?=
 =?utf-8?B?QnBZNnVCNHFoWUtxNGIzSEhPd2ZlcmVsWTlqdjFPT05rNmtOSkdwbkNCbEZM?=
 =?utf-8?B?Q2VqL0IxUE9IRUo0cE1hN2lHdTYzS3pMSmRENmsvQ0MwT3JzdW1NR21ZUmdm?=
 =?utf-8?B?MTN3dFgrOUFUNnFZVlEvMHBDYmZMVkR6d2x5SHhoUmViSzkvaThlNVBqYWgx?=
 =?utf-8?B?SDd4QitCa3lMWjJ6MktNQUJCTTFLcEkya21PZ1lsMkwxOUdLZkRLSWFIMEFp?=
 =?utf-8?B?R2pxcWwrQnFSSU42ZGJqOWpOMUFnRHFreXFBc2xkV0ZkSmRLSXE4V2V4aE1K?=
 =?utf-8?B?Q1YvQnQ0MTc3S1Jrbm5weEpsYU9XM3FmekRWRUc2NnlTSEFUVFI5TWY2Y0pU?=
 =?utf-8?B?YjBqYjZNMUpBNjVzSHluSDRIOGxTdEp1NHByZzFUNUlSMUNQamJmdUFwSFZw?=
 =?utf-8?B?WVZYUFJIaTNKSFJHaGJzM01jZGtUSU1SMmQ1ZFdHcWxxeDgxeU1oWmRDWnhN?=
 =?utf-8?B?bWhzUzErbTc5b1NRMFdXV0t2Vk9WQVFCTWFDTFBLSVVrZnA2KzJwcjhrZldj?=
 =?utf-8?B?dDg1VE5udG5UM0FiMXVSenRUNmMxT1Z1eEhPUmZjTUZBRzdIb1A5OURiaXFa?=
 =?utf-8?B?aS8yaENIOFZzV3JuY1l3WFBIeGNNRW15YVc4ZU9GWUl6dFA0WG5KdmtrZCtH?=
 =?utf-8?B?K3pRL2xucmROTW13eU1mblUrUVpUT1k2emJNTnZZZmhBVWFxNmRoelJHUGY1?=
 =?utf-8?Q?sylm3TiOIIfFg/zPcgbDWiM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cf2bad-0fe1-4743-16db-08dd5da1bd48
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:59:00.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz6btVd7enTyiW88kNKsFmwHM9DWEUhyCi1v4hABdlMF6/J8q6h58hRDK58kOJfc5GJnNHmeRpzOoApV+himrsvI2iS9Z2hrt1Vnvs6uEPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7187



On 3/7/25 5:41 AM, Lorenzo Stoakes wrote:
> On Fri, Mar 07, 2025 at 01:35:00PM +0000, Pedro Falcato wrote:
>> On Fri, Mar 7, 2025 at 1:12 PM Lorenzo Stoakes
>> <lorenzo.stoakes@oracle.com> wrote:
>>> On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
>>>> LKP reported 800% performance improvement for small-allocs benchmark
>>>> from vm-scalability [1] with patch ("/dev/zero: make private mapping
>>>> full anonymous mapping") [2], but the patch was nack'ed since it changes
>>>> the output of smaps somewhat.
>>> Yeah sorry about that, but unfortunately something we really do have to
>>> think about (among other things, the VMA edge cases are always the source
>>> of weirdness...)
>>>
>>>> The profiling shows one of the major sources of the performance
>>>> improvement is the less contention to i_mmap_rwsem.
>>> Great work tracking that down! Sorry I lost track of the other thread.
>>>
>>>> The small-allocs benchmark creates a lot of 40K size memory maps by
>>>> mmap'ing private /dev/zero then triggers page fault on the mappings.
>>>> When creating private mapping for /dev/zero, the anonymous VMA is
>>>> created, but it has valid vm_file.  Kernel basically assumes anonymous
>>>> VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
>>>> rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
>>>> will be inserted to the file rmap tree, this resulted in the contention
>>>> to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
>>>> to insert it to file rmap tree.
>>> Ughhhh god haha.
>>>
>>>> Skip anonymous VMA for this case.  Over 400% performance improvement was
>>>> reported [3].
>>> That's insane. Amazing work.
>>>
>> Ok, so the real question (to Yang) is: who are these /dev/zero users
>> that require an insane degree of scalability, and why didn't they
>> switch to regular MAP_ANONYMOUS? Are they in the room with us?
> This could be said about a lot of benchmarks.
>
>>>> It is not on par with the 800% improvement from the original patch.  It is
>>>> because page fault handler needs to access some members of struct file
>>>> if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
>>>> the same cacheline with file refcount.  When mmap'ing a file the file
>>>> refcount is inc'ed and dec'ed, this caused bad cache false sharing
>>>> problem.  The further debug showed checking whether the VMA is anonymous
>>>> or not can alleviate the problem.  But I'm not sure whether it is the
>>>> best way to handle it, maybe we should consider shuffle the layout of
>>>> struct file.
>>> Interesting, I guess you'll take a look at this also?
>> ... And this is probably a non-issue in 99% of !/dev/zero mmaps unless
>> it's something like libc.so.6 at an insane rate of execs/second.
> But the cost of fixing this is...?
>
>> This seems like a patch in search of a problem and I really don't see
>> why we should wart up the mmap code otherwise. Not that I have a huge
>> problem with this patch, which is somewhat simple and obvious.
>> It'd be great if there was a real workload driving this rather than
>> useless synthetic benchmarks.
> Disagree with first part. Disallowing a known-broken situation for very low
> cost in the majority of cases, as well as documenting that such odd
> creatures exist is valuable.

Yes, I agree. This is one of the points of this patch too. The commit 
log may focus too much on the benchmark improvement. I will add more 
words about fixing the special odd behavior.

>
> Improving benchmarks, however synthetic they may be, also valuable.
>
> But on the latter bit, yes it'd be nice if we could get information on
> real-life scenarios where this is an issue if you have it Yang.

I wish I could. As I said in the reply to Pedro, creating anonymous 
mapping via mmap'ing private /dev/zero is an established way. So we can 
not rule out it is *NOT* used.

Thanks,
Yang

>
>> --
>> Pedro
> The patch is fine as-is AFAIC, and I am very happy to reduce lock
> contention on heavily contested locks wherever I can, especially when the
> cost for doing so, in this case, is so low.


