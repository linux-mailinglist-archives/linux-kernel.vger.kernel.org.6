Return-Path: <linux-kernel+bounces-549899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70114A55857
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10192188DFB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B644207658;
	Thu,  6 Mar 2025 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7g7pWQF"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC72063DD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295331; cv=fail; b=pG/O8veIQWjMhq28G2mRMZeAUvpJJPu/LOJpG/ex2Mx7SD419rU5VUspLxpnJAY4FoQFXhuJGqUs09nNFZbDftWMkKxlhnWuSovkQvI5ScmtCTrUgjRvnZ20+6gKM1kloEyP4lwID6azqmnd1kJbvEv44687ULKB46idUUghbes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295331; c=relaxed/simple;
	bh=5zSepbAbua5bdfRkbE/CPjMRfIl6vOHrlKF28K7FLRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHY1sAiIUCt7en1J/6yeMIHsVORjYsa/HRs+IOQRoGHKs1F+DsDSXTXMZIuTHDzXXCXj2r6aLbbQszZxKbrsrh69c8c92XPKvEKEGhJftHGU0/eo3e2tzdj+tOeTDKPoTAJK5783GBWPKaOCEbVF3lCXWzJ/jyzY5/AJbNy9I2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7g7pWQF; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKMdy1F2Kkr1CdRUsFmIjSSFCon3HXf4SDOVF8JlPF/VYPdV1mueWF8M2HZsp9Lc7XnAMzk+gvoy80Zka4ZXnN0GXlQ2CJAFz9k8E9ZLJQZ1/WOJWMMo14bYeE95e+ySGYp517GM/KE3ARBHZFx9iaFm6WU6qYskDSu3wu8jAual67feItC0ryIhrZZfWx/yuvZB1K0wqCeQvMTUgz0vPYzSxkTZ3L9eHS5QLW+IH9jKSLOORztHLGQBMmv/5kwqT0NvHZveb4QiXGYOfySoeE32HOGPMcuqs7qmDDsEKHaeN0n+2X14eWyW0OFNEdLZuKwseL5EFvytKiOkhaa3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zSepbAbua5bdfRkbE/CPjMRfIl6vOHrlKF28K7FLRM=;
 b=boobY2zlzHF6AU2FvHOgGLPUeRb3c014DLORGg3NbzrKV/HvxM2TXukEzz1ByOBscbVHnZc4P7FSaeyRmI0ig+UWy0tnqJTy331OUsoUjMIYNlH8fBdFOEAbhYMJbZQOQmKh6feqVBeUJFzjgaB9BQa8QPmvrS2fEHjE63J65IYvsZNJvVtoM9ZBo8FJlInO459JkLGcvruKDR9zArQ2KvGj5I8d2dVDeDs1S5m+16fKVgTP4P1fmos0K0HRRJhINjTrSKDt7Anv3M7bXgziIFsX3VMzurU+xx8TijYl/0GW/robh6PG99qWC8EauJ+mRxfXr5ykGzEDtTuK1BwAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zSepbAbua5bdfRkbE/CPjMRfIl6vOHrlKF28K7FLRM=;
 b=d7g7pWQFeGYo64Wddp1DcV9Exs3MKQ3md4az3yiIYazCM46Hz3UncVYowsf4XY04B0nGDUZm57OPzp7gZkMSuPPV82kNMHpv4r6jWwSjtyboyyryg6wrfRDcxvvqLCyN0GXpUxEGbQDw/b58FYFF4KTrrRjnFKH83HdUVhFacnYNEa5m9cmWU1di+hS2m2z9YSkGjk0nt8G1K5zNwSUoSy27Q2YW1pu3ipuILmEzrj6z5gsY7EQvJNx3h5uRw2xnPGNjLsoDBuJEgUw+gl2e0kpOlJrJN8K4pTleGy1ir1fXzB8673FQvp4+I2CQ+7S7sKNio8O5qbQlwl3hbgatyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:08:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:08:44 +0000
Message-ID: <e1711245-ba1f-437c-a126-83130fc0a5c3@nvidia.com>
Date: Thu, 6 Mar 2025 13:08:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/49] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-13-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:a03:333::8) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ccb889-897e-4b99-2a2c-08dd5cf31415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y21jR3JQY2cvclNnSDJ0ZTRaRjgrempXaENYU0c4OW5QWkozL2EwajNVWGNp?=
 =?utf-8?B?SzNpMjdaaWg1R1Y3aHUxRk1pd3pyRTh1ZzlFcjNzaVFOV0tBUzdMcnEzb3I1?=
 =?utf-8?B?MFNsOHorOWJlMTdRVDV2K3pWbm1IVGtINFlkbGpJcFg4RmFZM3R6WTJDWUhG?=
 =?utf-8?B?eHBmK0hNZmhLQVBBaFZuRkNHK0pvemZXMUZIc1dKamprZTk4MklZREpPdVA5?=
 =?utf-8?B?Q2Z3eE5mTThrUHBkWnhaSUIxNmswSWEvS0tlTmhoTEgrQWdpU0lQZ2QvTldT?=
 =?utf-8?B?QkNTVXptMHFtNlJXbmlqdE5VZ2t0RGkyQ3habmI5YnNqUlYxdU4xeW1TWWRQ?=
 =?utf-8?B?eDdkeG9RL2V0Q2tsTVFnaHA5NHk1Q1ZSRnpSUFVVRmY3YVdBeWNjNTN6Q2cy?=
 =?utf-8?B?dmtSK3BJam0vbU84dzFaR1dNelVablNVRFg1NnQ0VmoxUzNjSlpodnBsRzBI?=
 =?utf-8?B?c0l2am1FYitQNStrWE9lK0NSd3JiTXlPL091dlB6TWpFNklwTWlEVHRiMWow?=
 =?utf-8?B?R0duREpEaENhK0VXM2w0elIvU3NnL3BZb1Zoa3pkRXB3WlhrYTdacnFBWkE4?=
 =?utf-8?B?aWhSSS9FNVNlWGR2N0NGVnpaZ3pRalE2MytJamlmazliVER5THhyRm1vVG1M?=
 =?utf-8?B?bmF5amZHeU5RQnJSM3MrVWVRVkZkYU9yWGVDbjBBWlVBMm83UURHV3BHbkdh?=
 =?utf-8?B?UkNMUzlKM3NYKzM2OWpPUmdubWlnZFpoT3YwUHl2SHpiemthTHB0cXlCWWg3?=
 =?utf-8?B?dHpqeVZuUmw1clJ3OGNXVEZUYnVFaTVFU0piOFBSR0ppL3pnMnFLUk1qYzQy?=
 =?utf-8?B?VVZMaFYzK1BhYjh4cko0QzN1TjhiTFc3UUR0MUtDV2MrcDNidHVjeWNNaGlU?=
 =?utf-8?B?eGRLanlHZWZ6aW5LdWFhNzFCN3o5cWpFdE50WW42elJhQmpJWFNRZWM2UEl0?=
 =?utf-8?B?OEwzWmhOUWE1Tm5tNXVOYXdieVdJQ3B3QTE5ejJlNGZzTjVhTW04KzdBNUF3?=
 =?utf-8?B?c3NLRGR1andiY3JiK3hxOVdSdUJKR1E5aFVhQzQ1bUJzVG0xSkp1OHoveHpT?=
 =?utf-8?B?OWhkZVJkSEMvVmE3M0pGTlUyLzkxN3JUN2dnMVNYRnpQWFROQStHRitlcHRj?=
 =?utf-8?B?MHNoaHdSdmNaeEtBQ1FhZmdPakNGTWNxMzVFYXlBUnhaMkU5T05EU25xMlpm?=
 =?utf-8?B?YWNZbWpsUFNhUkFFb09Ndlhja2VnRmx5NVdoOWJRVnk2elI1TlROVlZsNU1Q?=
 =?utf-8?B?dUZWd3BlZ2VwOWFGdU1PVHNSTlUybURwR1R1bjUwSmpQM2FQZ1dkbmpZdFQw?=
 =?utf-8?B?VE1WcndBRkJQd2FyNFVkYWNoTzV3YnFIWGs0ZW8rT2tOS0MxdTlaRzB3aWZB?=
 =?utf-8?B?MmphUGV1K241VWZTRG00bHJnYWdtdStNUU5vZ0w1RFFLTUdpOGFUTy81Nllq?=
 =?utf-8?B?OWZTWGVCYnNQcnNvaXYvSytpeWpoeW9mWjE2eGFGZ1doUXRUU2MzaHIrZFN6?=
 =?utf-8?B?RjdsL3RkblA0clE0NTI5cEpnMkJvMVdyUVlyNDA3OW4vUXI5VHFhL05TcWxz?=
 =?utf-8?B?cUFoWVVESjBTemNYRWlWOHQyUldVNVlCd0dRZWpFalBPdnV0b3VsMmtQYlo2?=
 =?utf-8?B?Y0pId3c1S3BXMHdZa3lFUVVVSzYyeWFWVUp0T1Z3bGY4SkIyQWdMUzhESENN?=
 =?utf-8?B?bjEzNmdXUm5IeUtvTkpYcnA5N09aSW40bHhoOFBnR3FWSTZLaEF4WGc4ZDNZ?=
 =?utf-8?B?NEloY1NyZ1k0Wnd4L0prMHNNZmFaYW1peHR5K0c0eDJtOUNVUGFhTjREWW9V?=
 =?utf-8?B?bGM2bm5yMTFyUEFXdUtwOTJBT0VIWE52WDliTm9EY2xTcXQ3SVFUY1FmK2ps?=
 =?utf-8?Q?7B0rb08grmAtO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWlZM0NvdlNhazJnM2V0M0xtMEg0VWtCSk93OWp4elVHM3FqTmdyTGFUZnpz?=
 =?utf-8?B?ZkMzaWJMNm4xYUxnY3BIRHg1V2NNaVVZaXRvVE1INzhwWmpBTjJ5dGRId09D?=
 =?utf-8?B?N1N6QStSenRHWkdBenBodEhuREFLUWFMVys0S0RMOFJiYytQWmFFSFBoQ0NX?=
 =?utf-8?B?dER5MlE1cjhyODBxSTFrR0RoRkthZ1NJdDF3Y2hWeUJuVUFWOVB2Zk1xWkhU?=
 =?utf-8?B?b2Q1RlNmYlZUMzA1UVUxek01K0t0VUVUK3F6ZmFXU0RIRFhCTDRld3hhRi9N?=
 =?utf-8?B?R0JxQkozNGtIWWs5VHRrckRhdENMY2JqMlFnYjc2Um9CNUtkelJGSVVRckNL?=
 =?utf-8?B?Rm9HN3J2Mjc4NmZvWFppZWVIWjM0ZGlIaEQ4N2hQUjJCekZ6UUxmWDJCczNq?=
 =?utf-8?B?Z1VtaGRFT3R3aFQrNFZNR0xGanNlZFVIZit2VUlwWmtLWUhRTU5xY2RYYmtK?=
 =?utf-8?B?Z2MwanFNWmJud3BVcExGTllxVHJKZzA0ZkhtcU1IMUdvNWZSdFRHbEZmOWpU?=
 =?utf-8?B?RzhoRGlUUVMvaWlHQ3NnNEhseUZPbjRhSGxLOFRNT1gwUUt3eVdiOW52d3dl?=
 =?utf-8?B?Z1NITXdqazZscjZnSk1BajlmQkttWTlGL0I5RnI3UDY3NnNSbjlGWnNGekdB?=
 =?utf-8?B?WWowZ1ROZk9nUFJnU2dqOC93UHJKeDVibFhLYm9iVGp6NkZlT3k3ZkpGaVZl?=
 =?utf-8?B?Rkg3ODhNT0RkTldJbEt5Q092UmlzMVlUWFBaQTZZUUl1WFN3MmJJSWsvNmFS?=
 =?utf-8?B?eER5RHdZWVZTNURrRFBYRWhydXY0MTl6OFMvVEpUOXAzTnZRZEw3NkE1bzhX?=
 =?utf-8?B?L1JzN1F0dG5lVGRjWGE4VENZam8rRHJrWjJURHh3MGZQTzZIUWE0UVBkVWdT?=
 =?utf-8?B?ZGh5ZGllUkJiWDErVXpDT2xYWlFnWitGcTFlTTdtQ1hzRTk2V2lJbWN1Wkw3?=
 =?utf-8?B?eHIwSHlRNGlSMHJ6WnE3T0drYlN0OFB5WlcxUkdZdG1ablhacWRpQnpjS3lM?=
 =?utf-8?B?MFd4akp1MHFFT2dwTUt4ZG8yK1dhQXI5NGtEQmFNYlhrUWlJV1dNSllSV1hm?=
 =?utf-8?B?RTF4SkVIVGhHMlg4S3JBUk1hekEvNUhyZU1ZamlpUHNDL21PUUtVRnpnNXJF?=
 =?utf-8?B?Ymp5MW9Nei85K2h5c0RyY2w0NmZiNGNNc28vZERHWmdhL0RkSDM5cnlQcVlB?=
 =?utf-8?B?ckJidlFPY21rUHRzdTlXTTllbUxrWGpwYmZzaURwWk1YNDlLV3Mvb0dRZGJ3?=
 =?utf-8?B?Yjg1NTF1TUt1MFdXYVpHQm1kYllXdkVjQU9HWkFiMXBXb3dObkNqalJtdS9u?=
 =?utf-8?B?VEtZditHV3lrMVFsajV0R2R1MlBpUVRSaDBnaUtNcnY5Vlg1RWpzcW5RRTZS?=
 =?utf-8?B?QVdMRWZZQXJsUmJvd2lWdWE1OHQ3UlVyL3FNOS9zS3E5dWhpSVFCZlBQTUtK?=
 =?utf-8?B?NUFDVnI2b0dhN1o2ZHgzQkc5NnJDQTcrU1lZaHNuZWh3ZnVmVVRKTkdxRmg4?=
 =?utf-8?B?eDc3cVhlVy9VWXFPb3RIUjdLT2FlUmhGRTlnMi9ZUURObFpNWXFxbGo0RFRF?=
 =?utf-8?B?Y2ZHY2NybWtyR3VXeDEwdDJTZGVVRkF1c3l1V3pFc3ZKUGE4UzRwM2wvdlFs?=
 =?utf-8?B?QWhYT1VzRlZNUVZFNlJONGNjTWpocS9nRVFFQitTeHdiRVlCM3V2Ym5uRHFI?=
 =?utf-8?B?YXBFUWliY09RcHVESGlKVlpoTW1pM3FkbktubmFMTXRLYm0weFdnUG5EbVFi?=
 =?utf-8?B?Z0dyeTY4RE9IWnczQnBRczN3aWxjNU1KeXJMa0pNcWNtSzYwTWE4dzg4L3JE?=
 =?utf-8?B?SDNwak4wblpwWUozbERXckVNd0NkeXFwcE5UanVHMmxlZng1Z0oxeGV0UEhY?=
 =?utf-8?B?OUphTEJOYTZDeURCY0s3RkFvMGM4SUtPblFOallDWEtYWkxDczVJbURZckNq?=
 =?utf-8?B?aGpsb0Y2ek0rcWtibHhJV3VBZlZTbnVKcWh4M2VQSzArbnFHWE1CMzdIbGtG?=
 =?utf-8?B?RlZmVEs0bmcrV2lIRE1mRitPcUVCSTNvSmE3YytFcWpEdk5IcmxWMVJncFpU?=
 =?utf-8?B?QTdnbXlYZ1dDVE5HSjU4NkVPSlowKzR3Y2V5Tm9nUlFkUDVUQXMwNHZ4Tjdz?=
 =?utf-8?Q?TbjJaq7Jfr/Y8qt88psVsOV1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ccb889-897e-4b99-2a2c-08dd5cf31415
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:08:44.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +907ti9Fg2dEydS5pMx+2E7MCtOyXUjURzd3elszqYmF90JOi/rGgC84VpiXkZOCNwVCdcaltfhweJHETuNWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237


On 2/28/25 11:58, James Morse wrote:
> rdt_find_domain() finds a domain given a resource and a cache-id.
> This is used by both the architecture code and the filesystem code.
>
> After the filesystem code moves to live in /fs/, this helper is either
> duplicated by all architectures, or needs exposing by the filesystem code.
>
> Add the definition to the global header file. As its now globally visible,
> and has only a handful of callers, swap the 'rdt' for 'resctrl'. Move
> the function to live with its caller in ctrlmondata.c as the filesystem
> code will not have anything corresponding to core.c.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


