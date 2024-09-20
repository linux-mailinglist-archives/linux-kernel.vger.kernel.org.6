Return-Path: <linux-kernel+bounces-334670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91997DA4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01037283549
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019F3BBC9;
	Fri, 20 Sep 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SVtXeV16"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65211862B3;
	Fri, 20 Sep 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868044; cv=fail; b=GDQYc4R1dWqvYtMgIe5MZzWVGNQiIGXYwEIvryJGU/gbkjriDEWQQEzFy4/Xmeb2Fg10WR7oUbmEvbvZfDknN+iZKnOr3CS9liWnod/Z1Dbh+w9By3UHFTd5/SZ1lNqaWtNFLcKiRVSl3InKr8MNEEJfAiVi/h57YABsE1jemTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868044; c=relaxed/simple;
	bh=eskbQafAOFXQFU4pepCwZSv54ql5mdyUSiPKUu5NV88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0W8aVfFKvGNS4GkJhkuBurhsb/G/KQJP6z7I5gzU7PnzF7bta+GNHTBcjI602bnnJzU5SwUTWihSs2GuVRtVhmpl041rj3R8Hyo37y6/rJ/ud4EcdrfOJlzHsCmZtpFgCl0fvE5E9hpjjnFBAyhrFo9LnqCPDSj26XfKqcIAfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SVtXeV16; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoZQp6s7icvWcHnRUHTjb7Jt0DZJ8uZR+cIa23fdymNBiwxFAPvpp9yojqqzliPWP8c0TGZrH6OZoBXYkJNKQyknIGZ6r2GFmI907DZW/KV03wuI0fJh/82ZMF3HvzgmCjwc41irqLGejb/MSlAZKkbk/+hyApPDx04U7R78ZfTfC4vWdlYcDxmUXbZWn3FSf6sIeiILm7Y5o2XdRlMAarLmS3Rp40t1iI/JgetgvyXPLx4B6l5j0P79jzL3zbDDVBB3UGYrk0/C8xi736sLpPtDB6bhaiQBauKwZtl3kyPRjtryMsjklIOWg3P0uUig3jY6UiarbHIRaDVGuTlV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBSsGb1t9EIDlJRh8VDlI1X/dcxxVkpYUcu1lsxocCw=;
 b=EON+0EL5PzEjLb4Ndoq5Ln7SWQmMW7YdjO8/ON98HUhJM1Gh1gloejdJvmZU+GwpotNZSG6YVJc2sjczL0n8hcK7gpHLVMsOds5JZJLGEMkzPNf+QhUKCgT2j3O4zDi0t4VUdcd0myuf8bQFKZcX+ZKg+JLOgq1kvOrmLj/aCc1No6ANzm1xlDu1HhOuwWijLlRXwf2k4p9zhWZ0Z8jEgehIUmgqKojuNPewU0swp9+voTrn4y7ImnB3ygZZIYN0WE4JuslOMIul4lsVm1mrvUYmF9kDWRW+3+ser7/z2IEfUKSSfDnLmZsU4aSDqYyZTNsZV+GQfrJF9FDghZbjyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBSsGb1t9EIDlJRh8VDlI1X/dcxxVkpYUcu1lsxocCw=;
 b=SVtXeV16+jnuv7Dpra0lmfSnFaWlM1ukLK16vl6tYaHD9fE1TUC5rhLiF+IS50t5/xXx4kaPDUt2FrW863WiL7fSB/FsNSaNmUxjW1HzpNbdAOXT0QzLlh9xluLYtQ1B55zMphfLGMbOAFaO1+k7clVA0uHsN7yuxjOiDsKsTiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Fri, 20 Sep
 2024 21:33:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 21:33:57 +0000
Message-ID: <753f8bd2-4bb6-0e78-dcc8-9b1d32c975b1@amd.com>
Date: Fri, 20 Sep 2024 16:33:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 4/7] x86/resctrl: Implement SDCIAE enable/disable
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
 <e85178fb-7258-4bd9-b9a3-0114c1c41111@intel.com>
 <88b93600-ace7-4a0c-a61f-7f11d3f38b0e@amd.com>
 <e26a0a3e-72ea-4284-978a-5d00e2cff20b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e26a0a3e-72ea-4284-978a-5d00e2cff20b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0041.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: cb47e8af-5a9d-4882-6510-08dcd9bbef2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWtDTXlhbkVoUlpCY2h3eTF4ZjN5UFZUY2YzWUdhelVDVVVTeVVreFhNY3Rz?=
 =?utf-8?B?Z2VNMDJISC8ybDV0ZW1DaC91ZVBEcGp0QnVJblBIazB6UHBQTGp5K3Z6OG1F?=
 =?utf-8?B?UjZZWjJOSGxuaGkzSXlPSGZ1ZHArQlhOOVcrN0RodmVsZ3ZMcHQ2M2FFZllr?=
 =?utf-8?B?Mlp5Zk5XN3VFb1Y4eWNvcFJkSHpXZHZZTUQ5TkZpeUJLQ3dIME1YY1djbVZo?=
 =?utf-8?B?dCtSWnlKa2t3bG5pWEQzZ21yZWwzaGtqTUdEQi9kZmtva1c5aHIzQ21oUi9h?=
 =?utf-8?B?UVdOUUdkYmQ2Q0tCNVErWkt4RVBwVlpia1lPK21uN1pWWDlYZE1ocTZvdU1J?=
 =?utf-8?B?OXlJSGQvQ242NWdqTll0NExxRGExb2tJSXhoS3hkYUg3R2tldnBKa1JtUkFO?=
 =?utf-8?B?dXBQeFIwRkxEclpSRzJYT25kWkhyOWQ3NWVlbGpqQ0hRNER6ZFpkajF3SDVl?=
 =?utf-8?B?R3ZHOTIzVmMzaVVxeWY0MmJNNjFWY3dQdDNlcS9XckJwQndLTVhzOG50VWht?=
 =?utf-8?B?bE5qUkJWQ2xQNHpDZncxT0pDL09tRHl5b21Ud2ZJV1Z4bm5qbzdDN2NlMi9q?=
 =?utf-8?B?Q2VmS01tNzBJc2swcXc2eWhrNHIvUHk4QXF0Yzhtb3FjZjRWZ3NXSC9jTjNl?=
 =?utf-8?B?MmVaTG4rOXFFUEZnc0hWYzB0SDN0RldueVgvK0pvaFlSNTlKWE12a1N5dUYw?=
 =?utf-8?B?ZzFwWFVLbk5ndTFNUnNzejRnb0ptejZPOGtsSUJXMG50Vm5PZmNzUkZUdnd1?=
 =?utf-8?B?SHdQS1IzdExrc0pHbjNpRWdieGh1MVk3bWwycUVlSWloZ3VGdGpsNGFKMnZN?=
 =?utf-8?B?NnVUY0R6QTErMzJkQldZWks3czdxKy9zNmdVN284cXRZaGVXK244ZkErRkJT?=
 =?utf-8?B?T0FkNUJGQzZicUszaUY4ZjRjMGs3eXBtY2trRW1MR0oxUjlBdVRxUVVPbjl3?=
 =?utf-8?B?d0d5YjBYWUZYNDdLNk15U0tkV1ZtZFVnV2tMUlBQVnZkMll1ZHlVTnFWNC9i?=
 =?utf-8?B?UHBMYjlRSWFpQnBUSlFhdk5mQVlvNDdPK1Q4aTg1UnJtQVg4Mm5qRmh3TkVk?=
 =?utf-8?B?NnFwd0lhRU90REkwM09rZ3drMzZCcHVKY01YUmtSM0pZMjREZmtOK09kb0lB?=
 =?utf-8?B?RlRCeEgxek9GTE9lSWQrT1JYTjNwcU9Ibk1FSHlBZ0xnUUlHM1VMQ3E3akQ0?=
 =?utf-8?B?NWY3ZUVCaitZRnVCZFNXMFQxSXFERE5NZ3FtcDNZcitYTDl1R2xvNStEc09I?=
 =?utf-8?B?ZFc2TU51S1EvYnZLZ0ZwQjZLckJuOTRHWnJBN2NTTFFhSWdsNmNJTGpZa2Fq?=
 =?utf-8?B?cFZqMzB2NVg2NjZoNklPNFV1aFE2OGxDRWxtQkRQYXBka3A0Uk8vclN0UzJD?=
 =?utf-8?B?Z2JUdWFMOHZFZHJRY3VNWWxkTUkxYWZtOU5qOGs0TUtlV1lCVXNCcDFOZzBy?=
 =?utf-8?B?d2ZFL2pFNEUzMU40RHovTlVzYVpNcFIwU0o1RGI1RS9kV0VxTk0yQWcxNWFM?=
 =?utf-8?B?Nzl4M2dDMUN2U0llVG0wTEhvREtOalRiWUozZ0kvYk04N056UEZpVWI3NEc1?=
 =?utf-8?B?T0JqK0ZEVGQ0ckpsZDhzQXFqV3pTb01wZUpwckp6TUhoUjRXTE14UmNxTFNN?=
 =?utf-8?B?b1pGandjM254SkVvdlQyRW5UU1VabHFzbWF1OFRjdUZyVVJxYWlxRjNjVTJq?=
 =?utf-8?B?c0JNNkpDOHMwR0FsWGN5QjlkSlI2dEhkTzRsb2FEOEFMT1dyRktNSE9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ZOdys5U2FnS1hwcUFWWExIMzRvMWNFRlM4bk4veERNekhRa01hbExJU1cv?=
 =?utf-8?B?L2J2dnFnaVlpd2NmZWFBK2JuZ3hrZ3lvNTAveEJQaXNHZU9TLzBjSkcvMVor?=
 =?utf-8?B?bDh0THpYUWIzaDRKSlphT29FSkhUK2VrQjBNVE1WdUdIWmxGSDk1RGFvamta?=
 =?utf-8?B?SHpIc2xhckNac0pxVlVoNUZ0NEtnVndFaVloKzlEeWxnN1hSQmNYT3MvTXZH?=
 =?utf-8?B?eis1V3AwTmpkdUtyS1ZaTkJFWDZSNnVicGxtU0tHeC9ERm5KUnMzSXpYckN6?=
 =?utf-8?B?TWErejhscXoxVEZrd3VlWVBFQnpjam5PbFZqblluOWJUTHNnSGlFNGE2eTVj?=
 =?utf-8?B?VkR1d1RVenMzZ2pRWDQzNEVkcnpEd1EwdGF2YWZENHljMGZLdEVpd2luQ1p5?=
 =?utf-8?B?WVloZDBMOG1lVTh3SVpTZEJBVmpwMmhqQ2JwMUM5OEt6WE1WVE9Rcmc3azhx?=
 =?utf-8?B?Q1JhNUlKeGNVQkFVWVB2OE5jejJydzgxQkdLeUhIR2tYaFlUVFpJN0R4NlBK?=
 =?utf-8?B?akl5K1FrN2hvQTFSaWRmcXNIMVpWRmpKZlpBU25MejJkZmV6cWRjUWN1ZHJo?=
 =?utf-8?B?dUcyT25hT1h1SThiUlNXUmpOYWFlUXRMdFNFWGxJNWtXdU5iTEFqQ3pDYzRi?=
 =?utf-8?B?MFJINWJpWTcwanc4VWl3QTFqM25Da3RMbUlJNDJCUllyR2RBeGozNXp2dFp0?=
 =?utf-8?B?NE9tV3dUNk9qY25Pamd0Q3o1eElCZFV0SUN3YVRqQzc4T0pUZk5jeXZ1eFpo?=
 =?utf-8?B?VTFDcXRkSEt0aHRvbXgxVnNXR3NsOGtTUEdCWmluYm42STNkQlo2clFkRS8w?=
 =?utf-8?B?emtkSlRFQnpPbXFyN1NKSTQ4bm5wS0Q1TktnM01DU3NMNTNSUGhNc0xOSHpB?=
 =?utf-8?B?UjZkaWZSeklDclEvQm1xY3dzN3NyZVZqWnV3V1hvNlU2cnJCVWtWZjdKQjhU?=
 =?utf-8?B?RWJ2YUI1N3VXem11ZFhHdTNMR0F0RlBUd2QzUTU0RHJDUndIbHBmZTU5VmtD?=
 =?utf-8?B?Mzl3ZE5DRUNuanZ5aDAyS09YQnhNRTBtUnpmdHVSajk0ZUV3ZndzMURJaUg3?=
 =?utf-8?B?RXpKOUlqOFBaby94MUZhSGRjU2tVb3RFRTNFcmhHdlNPNStlVjZNTkUrQmEz?=
 =?utf-8?B?UkNZUlhETzZyakVXRDEvTkhXQjBESVo4UEFCR2R5a1VBMXYzb0RlOEh6d1lp?=
 =?utf-8?B?TGpaYmU2aXdWYklPN1pTd0liTTllbFhhbGhiVC9Sd3pDK2RpTVRvM0IxVmtJ?=
 =?utf-8?B?Vzl5VndTbzR3YkYxeGlBSHJ0aXhXRUh0L0l1NEtYeVhuVDhCU3VTY1ZoTkUz?=
 =?utf-8?B?REVSc3prU3Yva1FDN2RNd0V1NS9hUlQxZFRPb25Ta0RNRGtLSHdDVFBHN1cw?=
 =?utf-8?B?SytIcXhCZmRMWTVzakdJUGJQT0Uxa0xaSGJmYjNQWGNpNGMwSkVUL0tjR1J3?=
 =?utf-8?B?eTlrNnhDeklLMDZERWdWU1dsUEg4MkNQbFZ6WXZBUlFpQVFsTlZOU3p6Y0Jp?=
 =?utf-8?B?QnJ5M2pnbW5pa0VJdVJNbXp4WVNGN1puQmtzcGdpQyt4T1BNRXhNVkozOE9Q?=
 =?utf-8?B?MlBMTHQzWU52Wi9jZnk2OXhsQjNSWXAxd0VuSzU5Wk1yM3hLUjg4U0dnazVL?=
 =?utf-8?B?RnVoUlFkajdZaWpHR1VCMG9XcW1rbmxJSThHNG5sRm9FUDlQaTRydTFQcjBU?=
 =?utf-8?B?ZVpPTC9FRmxoaG9UMVNKbEtYK0lFZEYwL09HZk1NM0RTa2JSNHJld2syOHdB?=
 =?utf-8?B?SlY2NVpYMVliVTlNT25GRjZHZDlwdDBZYjdYUkY2akpIMTNybXdQblBFSDh4?=
 =?utf-8?B?dTdpYmpZenFsRithYTNpTUFHT1hsQWU5ejRCNkxrSkQ4amp5b004cFowR2xy?=
 =?utf-8?B?NzBucTFGK3BQTHFOY0piNkhWNUNXQkovWDVIMVJVN2xsNXdvWDZTVk50RFoz?=
 =?utf-8?B?V0VQVWRWUitNdjdpNExWTGVPaXlDNlRPNU56ZGwwOWZLOHZnVWFJRTBxRUJB?=
 =?utf-8?B?S0lidDB5YnAzZUdGekdjaHk0bXBzbFd5eStrcG90TW11U0hvS2x2MVF5ZTRn?=
 =?utf-8?B?dEcvdStGRUlsVlRqOFlwVnRhUEhMSU1zb0JqMGhyZ2tyTHRiZXBiYnFjenVv?=
 =?utf-8?Q?je7w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb47e8af-5a9d-4882-6510-08dcd9bbef2c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 21:33:57.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDgFatsA6d88sii9D60bKpV5q/lFOu+Esaop51U7qMqZrje3oac4Gs0qXWZYiloN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

Hi Reinette,

On 9/19/2024 10:34 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/18/24 9:26 AM, Moger, Babu wrote:
>> On 9/13/24 15:46, Reinette Chatre wrote:
>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>> SDCIAE feature can be enabled by setting bit 1 in MSR L3_QOS_EXT_CFG.
>>>> When the state of SDCIAE is changed, it must be changed to the updated
>>>> value on all logical processors in the QOS Domain. By default, the SDCIAE
>>>> feature is disabled.
>>>>
>>>> Introduce arch handlers to detect and enable/disable the feature.
>>>>
>>>> The SDCIAE feature details are available in APM listed below [1].
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>>>> Injection Allocation Enforcement (SDCIAE)
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>> ---
>>>>    arch/x86/include/asm/msr-index.h       |  1 +
>>>>    arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
>>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>>>>    3 files changed, 74 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/msr-index.h
>>>> b/arch/x86/include/asm/msr-index.h
>>>> index 82c6a4d350e0..c78afed3c21f 100644
>>>> --- a/arch/x86/include/asm/msr-index.h
>>>> +++ b/arch/x86/include/asm/msr-index.h
>>>> @@ -1181,6 +1181,7 @@
>>>>    /* - AMD: */
>>>>    #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>>>    #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>>>    #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>>>      /* MSR_IA32_VMX_MISC bits */
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 955999aecfca..ceb0e8e1ed76 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -56,6 +56,9 @@
>>>>    /* Max event bits supported */
>>>>    #define MAX_EVT_CONFIG_BITS        GENMASK(6, 0)
>>>>    +/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
>>>> +#define SDCIAE_ENABLE_BIT        1
>>>> +
>>>>    /**
>>>>     * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring
>>>> those that
>>>>     *                    aren't marked nohz_full
>>>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>>>     * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>>>     *            Monitoring Event Configuration (BMEC) is supported.
>>>>     * @cdp_enabled:    CDP state of this resource
>>>> + * @sdciae_enabled:    SDCIAE feature is enabled
>>>>     *
>>>>     * Members of this structure are either private to the architecture
>>>>     * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>>>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>>>        unsigned int        mbm_width;
>>>>        unsigned int        mbm_cfg_mask;
>>>>        bool            cdp_enabled;
>>>> +    bool            sdciae_enabled;
>>>>    };
>>>>      static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>>>> rdt_resource *r)
>>>> @@ -536,6 +541,13 @@ int resctrl_arch_set_cdp_enabled(enum
>>>> resctrl_res_level l, bool enable);
>>>>      void arch_mon_domain_online(struct rdt_resource *r, struct
>>>> rdt_mon_domain *d);
>>>>    +static inline bool resctrl_arch_get_sdciae_enabled(enum
>>>> resctrl_res_level l)
>>>> +{
>>>> +    return rdt_resources_all[l].sdciae_enabled;
>>>> +}
>>>> +
>>>> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool
>>>> enable);
>>>> +
>>>>    /*
>>>>     * To return the common struct rdt_resource, which is contained in struct
>>>>     * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index d7163b764c62..c62d6183bfe4 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -1789,6 +1789,67 @@ static ssize_t
>>>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>>>        return ret ?: nbytes;
>>>>    }
>>>>    +static void resctrl_sdciae_msrwrite(void *arg)
>>>> +{
>>>> +    bool *enable = arg;
>>>> +
>>>> +    if (*enable)
>>>> +        msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>>>> +    else
>>>> +        msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>>>> +}
>>>
>>> (hmmm ... so there is an effort to make the rest of the code not be
>>> resource specific ... but then the lowest level has L3 MSR hardcoded)
>>
>> Not very clear on this.
> 
> The flow starts with functions called with L3 resource as parameter
> while the final function hardcodes programming of L3 resource
> specific MSR making an L3 resource the only supported parameter to begin with.

Oh ok. Got it.

> 
>>
>> I can separate the patch into two, one arch specific and the other FS
>> specific.
>>
>>>
>>>> +
>>>> +static int resctrl_sdciae_setup(enum resctrl_res_level l, bool enable)
>>>> +{
>>>> +    struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>>>> +    struct rdt_ctrl_domain *d;
>>>> +
>>>> +    /* Update  L3_QOS_EXT_CFG MSR on all the CPUs in all domains*/
>>>
>>> (please note some space issues above)
>>
>> Sure.
>>
>>>
>>>> +    list_for_each_entry(d, &r->ctrl_domains, hdr.list)
>>>> +        on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_msrwrite,
>>>> &enable, 1);
>>>> +
>>>> +    return 0;
>>>
>>> It seems that this will be inside the arch specific code while
>>> resctrl_arch_set_sdciae_enabled() will be called by resctrl fs code. It is
>>> thus not clear why above returns an int, thus forcing callers to do
>>> error code handling, when it will always just return 0.
>>
>> Yes. It is returning 0 right now. Keeps the options open for other arch's
>> report error.  Looks like we heading to make this generic feature.
> 
> This is arch specific code though ... other archs will not call this function,
> other archs call (to be renamed) resctrl_arch_set_sdciae_enabled(). As I
> am looking at the ABMC work also this can benefit from using appropriate
> namespaces ... only use "resctrl_" prefix for fs code and then this should
> be more clear.

Sure. I can make code inside the arch to return void.

> 
>>>> +}
>>>> +
>>>> +static int resctrl_sdciae_enable(enum resctrl_res_level l)
>>>> +{
>>>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!hw_res->sdciae_enabled) {
>>>> +        ret = resctrl_sdciae_setup(l, true);
>>>> +        if (!ret)
>>>> +            hw_res->sdciae_enabled = true;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>
>>> Same here ... this will always return 0, no?
>>
>> Yes. it is returns 0 always on AMD. Keeps the options open for other
>> arch's report error.
> 
> This is the arch specific (note the access to struct rdt_hw_resource) AMD callback.
> The function where the return code should be maintained in support of other archs is
> resctrl_arch_set_sdciae_enabled().

Sure. Got it.
- Babu Moger

