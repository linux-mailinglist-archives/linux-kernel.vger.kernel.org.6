Return-Path: <linux-kernel+bounces-549879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65526A55824
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A5E3A2D25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E89278107;
	Thu,  6 Mar 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCCf7s/N"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7432755E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294942; cv=fail; b=INr3x3KwRNku12YUWwl/YjO86aCDpNnEH2XISnxfWaWf5Tqge0X//ZIyAoNUjNLa3kv5+sShz6f6Cg7YO1mgEkyQFHJ1OY2HlR+DKp3lpr4WGzVU0Ud47VNeJ03pIimnFR/ytd8AB482jfJm7U36dI3fF4sH+qUX+HrBR6BP6uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294942; c=relaxed/simple;
	bh=a2KOcptbhC7pp5gnsTwVYHA1qOK8ngc0VCWU01lmRfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7e2FtpuoKOls5Kt5cDovclyWUyfs/h65WPg7+/FovAztNT7+x1GAa0XLBgt6cvzctoMTFVcdlQ8T37dEl/UiQW/RMDk5GzOQZ7Fnp6NI/SGeG9AlIpicv1rwGZcfaT0uaGWvsCsaElOD0JIs0HD0wz++QYYmKxavcdeSYZ5Cjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCCf7s/N; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWaS0hx2qvfu2K40x0t8M4K2O9TRYYLvhHDqTXQM/WN0f+n/SS8jajLKl6x93gv1uvJaIjlZCnjoo84c36AIlLrNC/r4vQ6Bng+H9qfEcMz565HXxLmafTymxrcGyCejsbvrX0SW/ZZoFZFUh9x4I7LSLB2Hd2Z/e4qCyRC1i7B9D7D0L5ZoXZ2aJifHou/YhAXDhoAXYymz+BvJe0a/0h3lwCDsoHBJgIsUNrYjxB2NpNQoDSdODL1DrpswfOSy8fJEjuLVLEvar2NoPe8L2Ts1pi/f+GeM1HBSjIUILXD0lCL8sjn3+yRxa8bD/6coQfXUhz/iPC6D1bVJ0qbvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMvoFvAJqqXtARlvDKc9k3ZpsaMfxu43Gj0buccSdXE=;
 b=pUSM7vr9ebLQxbZvB8YE0JilZtTOlHQXCMfnvUR/6qZcqIx3gi3TEbLTdNdo0xaIWMYyEGrgVOra9Jxm0Fu9jCgeZ1uSiRA+gBCXy8Zsw6mqVCKUtaMFs3lNbmm/hnCsELFhK0xfk8I/dFv38zoIGNUBXK7H5H5uTKksaz0ikC19kitF45nLVr8bkYz9HxhApOFmaor3KjMouxmvl2gWCcEDPvwQe7NZk+iDkK8N3yg7xhG2qgcPOQRJgXmoPc6CRytPnVgvbNTWUern6WNbPucKMEavEoDaYcNFDPy/PfwZg7gKkMUlc5ej7YQ00Fk8KgGZOhRosi14Ka0V9NWU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMvoFvAJqqXtARlvDKc9k3ZpsaMfxu43Gj0buccSdXE=;
 b=sCCf7s/N0sD7xFpHapMXpLJzECmP8dGGtzVZLDwfCWIozGYIr4TteVQ7KY3OzZ1EsCI6M1wUBdtgq/rKlBwE6rPPetGJfrU+6Qpu8Cl0d0MxlNQWW4fL7+X5JrYUE3EIA1ZcJRfqxUHJmaBjLMqTcVWA0kH7wp7j2vDeYgqlj7qnOGLRU+L8xikdWmXbjzyvOj8t67UzfSw7rQ9cSqT3evjh0jx32vIabJ5w34/qSpRUP2rKSABMSZtderIxbUsJU77Bl1FOflGW8ZUpOwKYA+R9EUP0mEY3mWbK2FprpM7BrNMfn1uOIbagC24JTqYVr3BXLJW03AR/iM47y/tfLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:02:17 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:02:17 +0000
Message-ID: <1b0aa594-caaa-4096-ba74-e4f0f2a7b5c6@nvidia.com>
Date: Thu, 6 Mar 2025 13:02:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/49] x86/resctrl: Remove data_width and the tabular
 format
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
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-7-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a56f39-137a-44a1-dcc3-08dd5cf22da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MytXV3pUYldZZE4xSWlhOTViYko0ZkszSW01VEVFQWR0aUdmcDRkQ01TNzdQ?=
 =?utf-8?B?YUM5U1FOdXo4R2xjQXRQd2djVUpPTjNQRVJkNlUxS3kraE81anJ2ZG5QV0xO?=
 =?utf-8?B?Yy9zaUtUZytOaXFPd2RWM3VYV1FlWkJyZm1MejBscitMM1haQTBQK29GejYv?=
 =?utf-8?B?RVo4Y3dOUFB6M2JWREJVNHpKZmtJZVJxeDZ5dk14UElaYjZkbUYxWDdFRzhh?=
 =?utf-8?B?bzZNb0IxQkxiQm5FdGh0TWdwTHlGYUhCMzdtNWdqWkpQWEwwR284bURvdFJC?=
 =?utf-8?B?L2gxa1JQT085VktwckYwcUxjZ1o3djM2TU9IeXRvVWtPcEU0V003QWR1VFV3?=
 =?utf-8?B?WnVVNzJWQWJ2UmxGZlRMbHZtSkh3VkYwdElBcXJmRklyN1RpUUhNVEpWdEh4?=
 =?utf-8?B?bUNkd3Q2bHRDM09xYWhTV0NWMWpzVzRSRGtrUWhZckxsbE1sdUlpdkNSdW02?=
 =?utf-8?B?R2FqNFlQVnFoVUpFYk5EeE5YSzMvR1RPUnlOWUJhL3puV0hnUUNlVEs5QnJU?=
 =?utf-8?B?UGRZSHpKbjYyUHFBZndqcDdnQ096bVF6NnVsbFg0b3N4TVdZdEFmckdOQ0Vn?=
 =?utf-8?B?SjBLS25Da0phNURUWWxhMlpPb0VOZjFiRlFOV0NaU3JhTlhBYnltYWtzOE5o?=
 =?utf-8?B?MG94VGR3R1QzUkg5WXovcm5GdjNlUnRxekNUT1VFTklmM3FLeEFvd1lFVmxh?=
 =?utf-8?B?WHRPTk53QmQ4bGczVndqTHRrZTdxVkQwalBWK3FiRndXTkxKSU5RU1FwQTFV?=
 =?utf-8?B?a0VpaEk4Wk9zT0pMUkx0c29wMlFGRktrbXZzQVhwZ2UrNldiOGRHdVgvTGsr?=
 =?utf-8?B?MXYxNHNWdWE0YlprcXdIdVdQVUhuZHc1K0VBQW1XWTFqUGd4TkRGWHBQTDRK?=
 =?utf-8?B?ZHg0MUx6S2NVMTBRdGFydnZWWUtNSmVJNEZtNUc1VFpMb1h4cGgwV3RsSVlm?=
 =?utf-8?B?Vmo1eGw1SnVtZE1lREpFRlozZVByL1ZaUHNZT3R0OUVzZ3RhUkNSMHViRXdn?=
 =?utf-8?B?R1puSDdwbnJKSzNyaTY1anJoeE5mZGJpWDFHYVErVGx6QVJKcGNtOGxycEdD?=
 =?utf-8?B?L2RSUUhFbEVLNlRWZll0Rk16UzZadjJ0WnpwaUx1VXNad09QZENtWVVteDQ1?=
 =?utf-8?B?bk9nS2kyQTRHRmVPdWZSL2JLU1Q3dDAwb214VmtBNnlqSjRVVXRPVUVhMUR4?=
 =?utf-8?B?eUt0Z0QyQ0tLdFA3NDBKMHBJT3NocFZMNTgvNWhaUjNsQ0pEMCtDZUVLTUhw?=
 =?utf-8?B?MXNxU1NHbXl6b3BHRFdtOEQyL3FEbVI3ZDUreHpVUU1iT0Z3Y3B6akoreWhx?=
 =?utf-8?B?d05YdVl2SW1yQ2hIOHpibGF3MGVWVHdiZG5nc3BHNW4zOU8zTUxicUlNUWhy?=
 =?utf-8?B?Y1N0REpXd3BMV0tDajVrM1FlcktiLzJqV2pXU3U1Mk1GTm1Ram41OFlTeEp2?=
 =?utf-8?B?VlVxeEVNT3FJWm9KWEZCNmZYbXV6WE83emdmN1V4dDU3cDBTUXJ2SWtvb2V3?=
 =?utf-8?B?ZU04WWYyb3o3TkNyc1hLU2lKaytKUksyUytsNkY0SlloWkVaWjlvODI0eWNj?=
 =?utf-8?B?enhvOTJzZmx4eEhoeFpzQXFaRVpEdS9rSGJLVnl3b2tkQUNvZlN3cEp2RXIy?=
 =?utf-8?B?aWJjdXVTNHROOHZTRnJYTGpJMmpwSXpjclYxSW03MDQvRFhMVG9pMkNPZlBD?=
 =?utf-8?B?YVpwV0dIblFxYitEcTNQTXg2LzRVZ2dVZGVXc0p5SDJhdWx1dktESU9udFpY?=
 =?utf-8?B?RjJhSjk5ekdFSEJZdW0xaHp1Q28wYnA3emI5NlJzOFpBRS9WZm9yQ2FLZ2Jh?=
 =?utf-8?B?SjVaZFFqNUNZeFBtR01ja2NmQTBWa1VMSDBsUUFJWXVPZ1hmNFJENEV5SlF6?=
 =?utf-8?Q?J+YIVaTggCI1S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JCUkZ0bXdBelFPZlRWcENsbXVUYzNsUlAwbHNnM1Y4Mmd6c2ZoR3BnWmRK?=
 =?utf-8?B?ZXA0RjBYMFljaHhVYUE1NUN6eS9BcTVDNWtGak41cS9ZcDRkNXhyQW5QejEy?=
 =?utf-8?B?ZHNFL1pZWjJOZklVYTBLRnRqcVJCT0Y1QWtuOWxnVjFOVDVDRkNtWmgzK0lL?=
 =?utf-8?B?VFBUOXN3Nmd3dnQ2NXlhczZXU2czQ2pUMnVlT29MZU5LcisvK1k3K1BFNW1B?=
 =?utf-8?B?ZEZQdlN4c2IzYlRkUThMbFkybngxYllsQktNaWRha21rZk11YVNGL29oMGV6?=
 =?utf-8?B?SncwVktNb3ZCUndnek1DeGVyWlpYNHUwQWdzdzBleW1WY3h5WkRNMHZZZzdP?=
 =?utf-8?B?NVNMM09PWHZhSGg4S1daTWZGK3FCRzlsOGphV0QxZTFxMkE3Zko4SzAzQVV2?=
 =?utf-8?B?OE5oRExSa3RidVYydXg1dlpYbFRQNG9hbDlKNlFmbjRsa3BUQzM4SUFuOXNu?=
 =?utf-8?B?WGc1aXNEbGNvMXBNcUUvakJUSE84QW1YUnV2Mmh3azhla0NGQWIwcnEzTnlv?=
 =?utf-8?B?Q1JRYjNZQWxrWGlSTS9KVEpIeU53VFVidDJnLzJTc2JwOEttd1dBdkdsdDlv?=
 =?utf-8?B?aCsyQWIxNWhOMG9oSXFiL2lQWDFJVjQrNGJNRHFkU2hPODdRbWVaWjVLR3pI?=
 =?utf-8?B?ZytXOHNBaXJJRCt0OGlPWUFNbWdJWEs1YmpCVEgzeklBNGo2UmNlVVlTdmtm?=
 =?utf-8?B?NTJvSmdkQm81RWNpeHFVYzVkUjhlYmZrVkxDTWMzcVRsSVhIVUxUQnRmZk9U?=
 =?utf-8?B?Vm9UMnI5ZkJQOGNsNmd3T3FBOG8zQXhzR1lqd3RkbHdtMzNiM3YyZ0dPME5M?=
 =?utf-8?B?OGFXZGgrMUk5aUVSRHhqYVJKVUdKWi9OaDRRYi9NejdtSGdFUUI5clRlRFZI?=
 =?utf-8?B?Ykk3emFueEZIWDUyNEliRnI0MXlVNEFVRXBWY1U1TENqTlFqLzNBT1NLV1I3?=
 =?utf-8?B?ZTNMNGozSXg5RFRDYldhbFdUVXVjL3YzdmZQSUIwT2ZUZHk4cmJvZFpMK21V?=
 =?utf-8?B?NlZ5NlhQc21mY0NKMWZ5RVVzZzhUMTkyY3JYbUN2ODdXMHlNLytvc21WOFhS?=
 =?utf-8?B?bGRZZ2QxQzNvTy9LVmZDdCtRam1jZUVhQk9tMUZDTjVBSWFVTFE5bnkwRkVN?=
 =?utf-8?B?OUhLSm45U2E1Ylo4Syt5cklUSTVvV011WkM2c2pEY2E1aVN5Y2pOU05VOEJF?=
 =?utf-8?B?S2k5OFd5VEp4SlRRQnpRRElKWHFzelA3VTV1ZXFnZkpPVVNkSXZ0NU5GMXh1?=
 =?utf-8?B?N0FMb25sNXI4cExKR3p3K0NUcmZlcU1YNE9UUjVCRFk4aXNZci9aK0dKRUJp?=
 =?utf-8?B?QlRHWS9JR0VhWWxxVDJRYUJVT085L3NGOEJrc01HV1VRUXJiZTE0bmc4cHBE?=
 =?utf-8?B?blF1SjR6dmN4VUVkQklWOWRHQnVBYmM2UzY1aWNsK0d3RVh5TG50Z3lRN1Ir?=
 =?utf-8?B?MnZyN2d3MU9IUjVaWi9TWUdYb1dMUW94MHJZOVpZOEJVVThRQ0FOR3Q4STVQ?=
 =?utf-8?B?WWtsc3NsZGlNTXVORHhTUHhhbzlpdXU3ejluYmVqVndlNVdMckFJUE5ZVXcw?=
 =?utf-8?B?UjhORTd5RmpDQitVZ1NySm5JUTh0ZnNXeGFzVjVHaWpjY1NBZVBNWEcxQkt5?=
 =?utf-8?B?ai9wRkhPcCtVSm9uZUEwa3dHZ3hVMU16V3BEdDVRdnM5dTRYcWhLTjR0S3Rk?=
 =?utf-8?B?VXhkMVBlOGU1K0JXZW9pbmJNMnBkaDg2OUhaUWFmS29QUTMwTWZxUkthYW8y?=
 =?utf-8?B?ck9UdW5Oc1doUXdrYi9ZeHpYY2JlTFRuZUF6K1A4ZXpqaVFsMmdheGk3aGpH?=
 =?utf-8?B?MXlTNDRxZFN5b0pJMm5hL0ZhNFpCN05pL0hhLzYrU0Z2Y2hRQ3BVNGtvVCtI?=
 =?utf-8?B?TTZ3YVByTHZKbnhUMGxtdlE2Q2ViU1ZFMmVtTHRSYytuWXhESmpOZC9RWG9P?=
 =?utf-8?B?SklZQWN1ZkFBR2EwSXZUUXlSK1YvK1RINGJlWTQrd0c3dVF6d2trRFRrTzdz?=
 =?utf-8?B?Zi9YbStwMGFoTGFsSVp4eTAvS1o0ZnlNK09TV3Bmb003SDRtZjFBQTdXampp?=
 =?utf-8?B?SWh5aTBIYUtDZ0JZUjZKUzdTd2RrcFFjeHlzZllpdFZ2b2xaaUtnaURTMEZw?=
 =?utf-8?Q?eXNe+lZ/GSLahYSPoextth/qn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a56f39-137a-44a1-dcc3-08dd5cf22da8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:02:17.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSqmLYJ8vrHckv72b9XQrAjVXqySRluvnUJLnUNsxQcGts8KIjnXTXcVSiOJjU5iageJYFe3C7JgWU5ZbgZkCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> The resctrl architecture code provides a data_width for the controls of
> each resource. This is used to zero pad all control values in the schemata
> file so they appear in columns. The same is done with the resource names
> to complete the visual effect. e.g.
> | SMBA:0=2048
> |   L3:0=00ff
>
> AMD platforms discover their maximum bandwidth for the MB resource from
> firmware, but hard-code the data_width to 4. If the maximum bandwidth
> requires more digits - the tabular format is silently broken.
> This is also broken when the mba_MBps mount option is used as the
> field width isn't updated. If new schema are added resctrl will need
> to be able to determine the maximum width. The benefit of this
> pretty-printing is questionable.
>
> Instead of handling runtime discovery of the data_width for AMD platforms,
> remove the feature. These fields are always zero padded so should be
> harmless to remove if the whole field has been treated as a number.
> In the above example, this would now look like this:
> | SMBA:0=2048
> |   L3:0=ff
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


