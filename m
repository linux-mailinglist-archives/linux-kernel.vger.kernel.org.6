Return-Path: <linux-kernel+bounces-551596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE9A56E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5311E7A888C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91418241680;
	Fri,  7 Mar 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qOzmedAz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22E217718
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366252; cv=fail; b=TK4UVIJFORtmPZKkRBgckwsK5KnDBVP9IT10nZD/sboXqAzxkRL+mb3pacIxENDLVqssh6iTfDAE392J0tjKhD1HCAgKr1R6uYPgnG092ibdf+WIL1bBulLPlfEVXh92xsc5yIVR5n0Pu8gazrae7Kyr8Uhx1WjFMXieNPndXWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366252; c=relaxed/simple;
	bh=TYmaLwVD5NhtiUORmHkJFfDtNVc+65J+CWbThEqxmt0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtjgHph0RVO9PyPPXWFqwBll88bC+gy7sHhFUAAti7miJpthVJuXAfAdPcwzmMUcsf6tSFjz/7xghUHtfEOWXvUa96gfmeTrd2SNGgGlsooWwpdcia4Yml5KZu0KP9zQylIMilkv9AccflTJTwjw1Hw4H7t72/9wwM1zwfsAaPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qOzmedAz; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Y2O8n3uvGUX1UMe1aKq4eNtKDWmKwDAYIL91dHHarsaChdyBHy1ej7KiOzuGWEtep8qUEeYmZlyhucGTC8+6UrSNJCPJwc1wVLjIqKef5tYjZK4//AInL88x5kMKUR46OoxkrGfUE0pNPhVwN17pjTEFY+dWtEiN+er6Jpgm+g2KP+LFjDCnmG3Sm13IxRobMRoldYJ5MSPpl5IdUQ2emL5oP7Tjcb5EBjAajbzNpnKToRAZY3p3hwKp5Tr1ghh7sLAzcKespLqsTp3orVmBGyLhpfxp9YWoKopujHUZrT83pqwOcy8aVALXVxNi4JuWzzq1kb7QVnkMTwRZ6hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZZFCq0E9gymc2Ss7i3Yi5cRwoiIFFHQuGjzuXYbPVM=;
 b=UuAxsqGs3mYXe8fCywt7GrSLGn/XxPffUKz+rY98SBEV5uZXOVzJUIJYZY1v7e3qT9/2WqpDlZHe3FblLm5Ex6rQoAvCkdRGis/PQtvspg7mOOqAvmczErbL12qMJQ0+Sf1YYss1884rmEfyga5mBWv4u3Uz4Z7Pa0CuOcOvhNDV8UF4zUo98p/BQWTCQ2wZHpLebn6rTicKxYJ3c3ayQWB+K1/fetv2Ii6VkrYWEXrbOvQltLRojXSJqRWflXBL3GR6enuo3OZ+4uL1PdVZoj7uhrQdzQwa6++UI1/uB37r2fnUfpkjTU5k1rwzUIQ7AVDa8JjM3VfjWpSZ48aLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZZFCq0E9gymc2Ss7i3Yi5cRwoiIFFHQuGjzuXYbPVM=;
 b=qOzmedAzKBeOUrDWmDQhZ7l9eQqgTwZEexMayMCXAGLPP2Ki6IhEYE7yrbLaiGoYHqid2QFyh7JuWKC5/DeGzDyfnl35NhxjOW/0ymFh/wAdPFbzHDis1FM9pYYe1IQK9jc/ORESZ0cPmYwuPUhl0CbXZgwJGvzBqzbvK9slH9LI7L4GaOg5SOhmQn5Pn4cPrwc/Yion4PtT6s5F2fyKfKUpZTKzD+HEiPoLlb57rSIbNUE7pyHcHcK21LIMgmVMqGHG8H/gu8CrDdze30pXVfTdG0qjJOCDFc8lWMTXB1j/oYug4b0MpZUC11ZV7rzGobB4JGXB8S6Wrj4eTDsUYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) by
 CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.23; Fri, 7 Mar 2025 16:50:47 +0000
Received: from DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a]) by DS0PR12MB6606.namprd12.prod.outlook.com
 ([fe80::ee84:cbaf:9af1:3f5a%4]) with mapi id 15.20.8489.028; Fri, 7 Mar 2025
 16:50:47 +0000
Message-ID: <18057287-42b3-4743-bd85-c12c098e98ea@nvidia.com>
Date: Fri, 7 Mar 2025 10:50:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
 <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
 <956a210d-1883-477a-9c90-9667031610e6@nvidia.com>
Content-Language: en-US
In-Reply-To: <956a210d-1883-477a-9c90-9667031610e6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:806:27::26) To DS0PR12MB6606.namprd12.prod.outlook.com
 (2603:10b6:8:d2::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6606:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: a18456b9-c2ef-40e2-01d0-08dd5d9835d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHR6ZkhSN0pNL2UyWFRTVGVkaFpwRk53d3hwSk12OStEbVRLRitxS1BNSnpU?=
 =?utf-8?B?RXpvTCtuRy9KRU0zNmNBNlBDeVd6MDFPMTk3VFlpZVlGN0JuM0FSais2R3gz?=
 =?utf-8?B?MnBLLytYTXZYNWpIUmlaN29kUnJYZU1USG41QzdHR29acCsvcXZTL08zQjJE?=
 =?utf-8?B?cU1EVzJmUUhRTlhNbERybk5RU0N3WmJzckxQSVNaVloxUGFOc3JzYmRMaUts?=
 =?utf-8?B?ODRXN3pKTW5OZ0JNVTltMHdvKzU0OWJnb0tXQmVQWWFQMG1LSWk0T0c0SFYx?=
 =?utf-8?B?LzhqUlNKWEZJdk1QWkF4aVB3OTlBdWVtQzYwRjh1bTJFRWxJeC9uaGpvKys3?=
 =?utf-8?B?empETEJ5WnRLd0tkSEpvTTk3SEh3RkxVVzB2RTMyblhTOU10QldzZlJjTStQ?=
 =?utf-8?B?RUtnbDQ5M3BFNnRLUVViU0p3MkxBcXkvNnFSYWZaeDBERkd3Z1JROFJRakZG?=
 =?utf-8?B?L2VBenB5VG85RHU0SC9zZHIwaTR1WUszMW9VR0JjL3dCWFd2WlZvK05POGNt?=
 =?utf-8?B?MjAxR3RreEhGTmFCWGJheFg4Tk1HdFRXVUVZRW1ZMzdBanJEM1JTcEtWOXpI?=
 =?utf-8?B?NUVxaUZZRmpKN0VOTFgvZlYwWkNiWWhia25mejU0REt1QllnYjJrcktOeU9Z?=
 =?utf-8?B?bFZGRXRzSGJjYlZYVnZhdExXcTlaVkR4NHZTUGh1QjZGVCt2TnBOWkNYeXBn?=
 =?utf-8?B?TWg2cFpKaVdqU3YrZ3NtUzBPbUJFNGZhWGNxUi95OG5UWXNLcWlQMWNoYXdO?=
 =?utf-8?B?Y25RdXJjMDk3K1pjTDZydDVvcTE1emxXNnFzQWYwdzZhcDNrNkI1eHZkempU?=
 =?utf-8?B?bGYyb0dSQlFmK3pNaCtZZ3dlR0hmQXk1c3RnaGVmQysrRzROdm5EalJNRFBZ?=
 =?utf-8?B?QUdXL3lzUWpMWFRBUGlIZkR4TndmRTJCTmRzUFVIVHNWV2hsMVJneWZ0Vjd5?=
 =?utf-8?B?bTYzZEh6NTJQMTUyQVlRWk9aOWdxaXJZVFRIeElISkI2TUs5Tkt0NWp3Nnly?=
 =?utf-8?B?Nzg1cFZBemFLOUFyQUpDaHh5NmlkaVNYdGFvSTRMYmM0ZG5tQ3I1K01JWFZY?=
 =?utf-8?B?eEh6SXJZRTZNVGJJQ2ZOT3QxU1gxQnUxT1hqQzhIRGN2YzRNRUppRG12d09O?=
 =?utf-8?B?aGdCTURtNnN5Mkg5SkZFZUJTbU9Nak41SUprOUhEMm1qc0VzSzkxZEdRNXp3?=
 =?utf-8?B?ZEt0UkFQQkY4SWh6aTNUOXd2aXRWeDRYN3NTbTB0WWxwMkM2V0JIMWgxZ0hQ?=
 =?utf-8?B?bzVpRGxVUzg4VG9HZnk4ZmFxUnBOeWkrV3FPKytOYTFNUnlqcTRLaEFCWHUx?=
 =?utf-8?B?Rk0rWDFUZ29KZWFEMVhGcDFCclNIWjFOT2tCRmVnaFZ5R1l5WElFZSs4dk1G?=
 =?utf-8?B?c2wranJRN29jTkFocEJOdkdJTFFEeVBjRU1UU2dnb0FnTk1OaXFkQXljWVRU?=
 =?utf-8?B?c0phUXhqa05GbkVwK1IwYmc4NWxnYzJod2o1bEx2Q3VKZUloYUNtYXpiVkRn?=
 =?utf-8?B?M0N3VVB2dlAyNmhXcVpmS1FsL1k0WUNzeEVKZ3BvUnBvTVMvNnJwN3FiaXVy?=
 =?utf-8?B?RHpqMDhQOHFMTWxYcmt0bURBK1R4WE9GbzBvNzRXVXd4ZkdxRTZJRGtsNmZ1?=
 =?utf-8?B?bHEraTZqRmZzTTZGRkF0MXQ4WmkyM05pemM4WXpUaU1Wa1pLQWlmVkVvT0lN?=
 =?utf-8?B?elFoWWRWdmRLamRGeWNPUzNaN2NvZllqci80dndsdUFqc0IxeXNSdys4Z2Er?=
 =?utf-8?B?azZ5a0R4RkhqRnA4K0JDUjJBTS9uSll2NTg2N2hPeksvZUxrTVo2SWhwRXpn?=
 =?utf-8?B?VWpLUUIxYkZjZnZ1UWY0WXpoOWR2UXhSNGxrbkFuVHF0R1hVVjNhQzdOaTcy?=
 =?utf-8?Q?n0SHmkgfO7AnR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6606.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjBPRmx0Nmwvb29wNmo4S0hyN1BSMDdOa3BmNGRLLzF1Rkh1RTB3OGFFOTJF?=
 =?utf-8?B?YW1YNHNvQUhtMmNsM1lPUHVERlcvblVlaFM2Rk14SitrMWg2Wm5MaXNGOWov?=
 =?utf-8?B?cXpmT2hocXk3VGZ0cmcxNkR4TkJiU3pPK0QwMnhrRnlOM3IzZnFCYXJ5NHZp?=
 =?utf-8?B?TkRJM0JmbGV3ZENXRGw2R25IRVZPT0wzbHBzNkREMEc0UkhUR0hnbkxjRE5m?=
 =?utf-8?B?NkppT0hrQlpMV0M5aFI0eHlaZlRVTzNwR2Yva2VoZ2IwWFF3Y1pkaVhlaFdj?=
 =?utf-8?B?bzNjWFhYcXY4Uys5K1ltVUY2cGdETVRqNnFnTnRwS0V5c0wwRTYzQTRIUnp3?=
 =?utf-8?B?NTd2OXFna1pPdHNqOHp4aGJOQko4VW92cWZZWWl4Q0tDK2FuVldwQ2ZKMkxW?=
 =?utf-8?B?am12QlVQQ0I2NzhiVUZXb2dUejdLVzhIK1Y1b29jZ1JFSVRVc1QwS2RqdDJV?=
 =?utf-8?B?cmlqclFkeGNmMjlGbzFON2JEaiszNkRRNFlDUFI3SDZlRmVGUy8zZ1d0cm01?=
 =?utf-8?B?V2RVdWIrN1hKSXV0Q0dXbitwdU9hT1RJZFRmRVI0bEI1WFd1VTZwYld3cUcv?=
 =?utf-8?B?ZVBJZUFSMTRFby9MNTZsbm44ZTR5RmZ0bHIweTV6TVhnR1ZHaDBIK3JsYWVq?=
 =?utf-8?B?d3Blb1JYS3d1S3dST2taSm1iSVFoVkFDZ2NGZ0xTcWRtMVFIQmNHamVrRmM2?=
 =?utf-8?B?OXdTd21McXZqYmovdzJLWDZOMWlRbzBmUGFTaXNTMDZrdGFyRFVVVzZFTFYy?=
 =?utf-8?B?cS82eXRzWGsxMi91Y2JiZ3B4Q0w3YnhJckdJZjNVQW0raVFuakJrSGpmZWlh?=
 =?utf-8?B?THZlbXJXcmh5OGYyOXpDL1JxSUdPd1g1LzgxVFdWNVh5ZEdoRzQybmlWMndO?=
 =?utf-8?B?a3Z6cm5zdG1ka040MFFFZE1VRjNON2lGVVdwNm1nb0hzWndEREJ5K0h1Ykx1?=
 =?utf-8?B?RUFjdkZEVDVMTkRDWk1uT1pKSld3ckhLYnRhYmJQQThVR1pNQTA5SjhlM3FR?=
 =?utf-8?B?cko0Q2hRR1JtSDUveUtHR2R0WW5MeVRyUkhtVTRJZkRVSm5ObTNoYmZ1Z1oy?=
 =?utf-8?B?OWwvL1dScWRnSko1dTZVcTgzWmtkd1huNjhaQXhpQWJ3SG1Qb2oxRERXS1Vp?=
 =?utf-8?B?RTYzVm04ZGJrL0ZMMytzUHp4QTQ4bS83Tkcxc3pzaWpCOFN3ZlVkTnIvRWl1?=
 =?utf-8?B?bUJJNU5ETHZRMmduVDF5Z2FsT2pvb1JmSlpNaHF1aWtiZ1ZJZ3BmNTB3TWRC?=
 =?utf-8?B?YjVZVU9aU0hlUjR3M0lONGJZQzQ0d1hMQU1TT2tKMmFLRnVtU2R2UUlBNUlT?=
 =?utf-8?B?ckZQYXd1eVUvYVpOYmRXR3JzdkFzVnAvV2lWQkw4aytmSlJEdEZjYmdmZklx?=
 =?utf-8?B?SnNyT0NNcTVaMmdWZFFjSlVIN2tGK1RYWGFIZ1VsUlUwNkRQWkRxbSszTm5U?=
 =?utf-8?B?WFZCQnFjRCtvZHN0MS9IRHpxRUVLRFNReFNWU1FwZzNXRVFCUVdKTEpTSjBZ?=
 =?utf-8?B?Tm9TWjdodks5am5vNXRwdU5KMmlNSVhMcEFuUndLaGV1RnBHQ1hVWCt5eWxV?=
 =?utf-8?B?SmlETTZmV1YxYjBXdXdPUm1jVU4wNzMzbzVTOU0zTEpVQk00eFNiWndNOUkw?=
 =?utf-8?B?cysyR0NuM3pBdkFjb0lKNWRWNEhseGpaKzd4eTZMMi9DamFFSFZOUXp3WXB5?=
 =?utf-8?B?N3o5U01oZ2oxRzVYaTNMT0VKdk0zSEpuMStkeFE4Rm1sMnBJNElLVTRDNnky?=
 =?utf-8?B?bHhOM2hLb0tzaC9XSFFBQ1lPZVcrU3JlNnVLZXRGWWQ1RDRHemprOENMZjV0?=
 =?utf-8?B?dDUvL2NwUUJ3WW12QWlIYmlFZkJ1QmNkZzYvV3pmRkkyNlZDWlZ0c2pqbDlC?=
 =?utf-8?B?ZjJGNkV2eEdyYUZ6STYxWnFiME9ycmpadmRURU5hdjZRVXRaYWpDU2swVnR1?=
 =?utf-8?B?NXpXV2drM2RkY3MwaTlrN0dqcGs3NEZsOVl3MFptYUVDdEErR2dxREpKRGwr?=
 =?utf-8?B?UmJ6THFXU1pwSWJ6MlppUDZNZVVvODhaOGg5Wmk5eVJvM2VGVkJuc2dhQ2dW?=
 =?utf-8?B?Z1NVdlBXWlZaenE3R3B6ZjgvaERjZFo4b2daY1pHRHpGcUtVR0ZuM3A1algx?=
 =?utf-8?Q?13wDtjzlKFMgJyfyBLWcDzd7t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18456b9-c2ef-40e2-01d0-08dd5d9835d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:50:47.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWpEBBwyq0JJtJLbj3yt6WhurxMC9heE6ifbmgpztxmUwTy5CQYQzdD6PshIYy0U8CYMM2PU2u4OwwulfeO2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872


Typo, tested with MPAM patches.

On 3/7/25 10:38, Shanker Donthineni wrote:
> 
> Hi James,
> 
> I have tested this patch series w/ MPAM patches on the Grace server platform.
> Validated both the features CPOR and MBW, results as expected.
> 
> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> 
> -Shanker

