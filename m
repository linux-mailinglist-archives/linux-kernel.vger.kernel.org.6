Return-Path: <linux-kernel+bounces-549944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC9A558DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B483AE9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CBE207DE0;
	Thu,  6 Mar 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iK6jm5Zm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B00207669
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296879; cv=fail; b=c5SSUK3204Sseza10ZEE+hVQBGLVgGDEn5M8e44A26tQlXxivmOzspTtywHNAaFW/mA2O5jLRuP0RnhoeKIBSV3eo/6efgd6Nan33PlAjhiQdtdFoCQ5tPtVqEERQQSl6csrMDAi7dCVekhqHWznxySWSOurqZV3PCx5I8U+Bz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296879; c=relaxed/simple;
	bh=tO2hdcyeiuRryPBcR7tBoJAEOu6i/ZYSWLVmlMneN50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W26+yKP+1mtnxoM1J+TpSXUp8KSqiMJublRarSbrlXakpJWHEVuHDVsW2t9wYWIlU72ZzmmII4r54/pskDLQASMqsgFXnQm+eJh6d//2REyQMncWicXv4thBdHvD0+BK3Exk4l/blBNajTBrYD3/7YgQkYrJU3xBjiskwbxrwDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iK6jm5Zm; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TB49WEdR+WP/yPYab24tflCTyLmcz/Td6k3PTUQjN6ykB+EDYzV7lqbcQsCNLKWfZohDj2Y5CBUWT9Jp6qrUpMZ7M71FdgIVm8mdEtzik3KHIoNc3m+f8WpsI2OrDZHi6E5tRt8Pxj7BNMJcvLUuwnZBaTibbv+Bi4OEiwr71XLzeqrYx6tdKOmqEgkQaGMevXQvKBS2ZOukyfp+/cHhd37cb3TOBskfwIVHtIVqcd0Ux2UD9EpRK1+OrLilkG+SFypQbMeLl116Ddn+pLvWXe1NOJT8vo2YpvaXeqWZ1Piyk7qOgmbv+u2UdCUdo/gOBH95kd7eysB4tfVwBjA3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO2hdcyeiuRryPBcR7tBoJAEOu6i/ZYSWLVmlMneN50=;
 b=Qh2+xEckyB2Eep3XT9L3FxcU4uzZE7LtWLrdkt+cqC6vMwkmUIqC8Uo4k+60UYStIIrHzO8n65+mK63oRy1SIYbFEybQPl5+NLkoEW8nvOwZTi6l0mbD6npkkhwisaxtudrTaxZg9S+5Av1TxldJIAh1G9owOc5TXGFoNLxFJCRSL22Xk8VBEHzo2uL0OsPrukUHKl1QKt6H4nquiBfJXbvHm7CE7J4coW91FIw25eKt4kM+bUw7FjqW1qsUdqciyfay0Qb+UtvWZtwN6p8KsU/rsIKrNZZvC4i5tvS/F3rtBnY0K6AEZlGepqJF7vKoJuXXvPARzwAEWdVLMBBYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO2hdcyeiuRryPBcR7tBoJAEOu6i/ZYSWLVmlMneN50=;
 b=iK6jm5Zm3dP2XwVib7iJZxcfXisVisFCBtWHc8zNeDW4Uv0ZaHBhGEbpk21akVI7DXnW/RFZ1og61X0JEjjyS/tXEv1YmAtm5iGsV7DM8Jl9fjVRvxPW2RGUa1qfSpN3qGqumCuzllZN5YGEEyFb3hhh5WtF/54EyByxynJio3nyvuIydKp8aY7Mq5Xgso6SRMaEA0xNorXn6cfC1yLkyj2Lig/7+E56Zt+gCnUavovWMtJodnouqM1QvX96mmBYjjsa7wqt89JHXex9cLkJhXv+HdJ+6x2aa3uWzBbAewbYvz7/rj3CZY4LYbN7DzIp7jluPcsXbb5IrlO/nAhBbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:34:35 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:34:35 +0000
Message-ID: <f9e67766-b4e2-469a-a843-1e74e6e2e265@nvidia.com>
Date: Thu, 6 Mar 2025 13:34:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/49] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
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
 <20250228195913.24895-23-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-23-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 005a1f0d-afc0-45d5-24b5-08dd5cf6b0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXlGUnN4QnZ2eGp4TVZuMVV5SWdEbUIrZTRMZW1lRUNWbWJSQkVoYzZuR2NU?=
 =?utf-8?B?cENuVnVrc3YrdGdwN1BsQ1NvVS9BMDdvNlE0NmdtLzhEMi9nK21qakhJYjJi?=
 =?utf-8?B?ZTJ0dGw0Qis5cEJZTEs0UHV6V08vWkVrNnRNUTlFZndZYk4zc3ZxRHFMYnpy?=
 =?utf-8?B?TVNTMndockh4aVRDMTJ1c3RncDBPT2JER1lSbjFKWjc5aTRzRzB4SWJVOVpj?=
 =?utf-8?B?bmF4SFRQU3gwd1B4L0p2d0ltL2xpTDNQdUQ4QkZ1aWJLTnZyV1JqdFpmckVP?=
 =?utf-8?B?SmRqSnorUmljdU1odHl2MDVEck45bHpQL2loOHVxK0hNcm1iY1Jic0w2QkVh?=
 =?utf-8?B?MkxCQmg2N3NldGs5ZmRxd0MrNldoY2M2cEExa2xDM1NabkZVMUJuSjhjV255?=
 =?utf-8?B?ZEVGUFRPajJ1ZmNGT3Z5M2NvSk5FTGh4M0xVUDJaTW4xSzRCNWpGZ2drRmM4?=
 =?utf-8?B?N0NVMGtOZ1dITnc4TTBPVWRrNlhSUW83aXRxK3RuckxFalhURmJEeWNpNHR0?=
 =?utf-8?B?M2thaWZ4WXNmNmN1ZGpnNUJCdzBNSmdQMGZ4aWRLTnFHMEs1TGJiQmp4Yml4?=
 =?utf-8?B?THBicEtBOXllekZXWEZDSkNsOWxjQkQrWlV5MStCNnlYT0lmVFRBaXQrNFd4?=
 =?utf-8?B?anFOV2s2WXBQZXUvTTQ0OVdGRmtkZkRnNGl1amdKbkRhTEpJRzQrKzRKSVhy?=
 =?utf-8?B?V3lzYUFBUG1wckNYOGV6WktrT2RhTStCVGU1Z3F1akl3NW1zRWUvMWc2TU5m?=
 =?utf-8?B?UGlxY3FNNVZKU0ZySng1aHdhRHF3N0MzUHhlYklzQ0c5Szg1ZHVqbVVyL1VE?=
 =?utf-8?B?TExLcmVRYmN1YU02UDltUVJXcFoyTWk4bU9JdjZqeWxIWUFMTGIrMnNnM09s?=
 =?utf-8?B?UGVpUWVHUDRrSHpsMHV3UmRDNTVLYzRiUmcrak5VcjdFRDlVWkVlaUs2Z2Jq?=
 =?utf-8?B?S1lvRllGUUVCazJsbnlQNnZBc2Jpb3Q4RlRkeVRQU3h5bnRGdVZ0M2NZRVBI?=
 =?utf-8?B?amVKQVZYc1QvaVZkMDl3a1FEZGovNzNaczd1aStrVzJmT2ZQTlI0a0tsOVVl?=
 =?utf-8?B?czBUZ05JLzNTNXROY1Z1ZUJETUNFbzU4VHBNeGVnRHhwZzRtNC9oS0EwbWFX?=
 =?utf-8?B?cFM3MFpWS0lFaXZqWVE1NnpFb3pNR3h3RkZMYTZpdXJFaVNNOUdUbStZejdh?=
 =?utf-8?B?Zk42VllaUXlRZ1BuanVpMHNnVnRDMDFMOS9ycGkzWjV0UXp0Zm9MR05GWGZU?=
 =?utf-8?B?ejZ2UjA3Z2dvSE0xc1VNZks2VGE3aTZxbW5paDhTMjZSSm5YLzR2eDVpT2R5?=
 =?utf-8?B?M2wwZ0tnUEUreitwZ2pKcENjQXMrUEQ0Z080cFZSckxWL1I5aTVseFo2d1Bk?=
 =?utf-8?B?bzlBQVhEUkRwa1Q1TFMvakRmT0J1ZktjcENYOGlsckNNZ0JzZU9RNjRSVDlZ?=
 =?utf-8?B?UzJYWkFkL2RlaFVQZGxwb1EzVUxxbEx2Y3h3blBuT3ViUlpJcnk3alFOZldZ?=
 =?utf-8?B?dE5SclJldys2eE92eHNEUGEyUlhXZGg1UzlmaDcrZ0JPSXVsQVlvbXkxdkNS?=
 =?utf-8?B?bmNBN3cxdlZUdEJOQ0pFRGNGcVI5NzlORmlWTjNRUW9xU2pmSlhlR2F4d1Za?=
 =?utf-8?B?UjVxdmQ2cWpVMmk2ck1ndklJQzZ4NFVsOStuY3Bqam5WN1kvWVJXMko2ck1S?=
 =?utf-8?B?TVRZOGN5QkF6YnhGYWEyZGJqQXMrVUc4NGFVVHQ4b2FhYWt6UnNPU3Y3Vlov?=
 =?utf-8?B?K2taSE90SVJSbzFCQnFwM09wQjNOeEVtREZHRVNvMEVnL0VxbzUxb0ZYdmJO?=
 =?utf-8?B?a2V5QmpPb056OFFHSWxGK3RiT2dXalVsa2FUNFFSL1g4Wm5JRWh5RGtOSVdx?=
 =?utf-8?Q?KHYsCmU6pysXG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNQWnVCV2F0aDdob05tUlpidGIzM2E4a1FQNkE4QXlpL3Z5STVQb0g2ZVJO?=
 =?utf-8?B?RGVqaHRXRXRIbGh6Qy9FWWxvMHhYQTQrZWk0OE55Vk9QenA1em43YWNCS0ZX?=
 =?utf-8?B?NmZvajBsd0hJMEhzVG12U2xIaXBXaUl0WE5aeTRKa1pQbjhSMGZnQUpHUStS?=
 =?utf-8?B?MjQrc1NvVzI2bnlSaVErRUUza1RKRW10Y2h0YndBbEtmWEY3OUhiSVE3N1pB?=
 =?utf-8?B?eTl6TUQ3bWhwNWs2WUFsZlRkcnhaSGxOOTRYY0xMT2czVFZPejRnUTJ6bis4?=
 =?utf-8?B?bmZUZkExOVRhV2YrTG5lRUVBbEtkZHNmMHJQRnhUM08wOHBVM3ExVkpYMklV?=
 =?utf-8?B?NUhCR1MrRDVQMFRxOFNocnJFUDZQVC9MVEZkV0FENGxTYjZOWXZ6anhHdllJ?=
 =?utf-8?B?YmpKSW9pQldrdXJQdHRFWTdlTThnVm53ZFBoUnVvL3hVTkU1QldnYXpqTHZQ?=
 =?utf-8?B?Z2dPS3RZRVp3bExWS3cwQSs3RVpTV0VFeXpONjlvY29tenRON3FFOUQyTCtS?=
 =?utf-8?B?ZGVCVFkyWFE3elc4ZjlGdGNIRHNSQlhQUjJzQUFWd2pRTHRKUHlzemo4ZWc5?=
 =?utf-8?B?d3JPd1JmSi9LYk1UZjE1MTZRTmlvelo2QWtpMityRjlEVk9CNnpIV05Zdlp2?=
 =?utf-8?B?QXZPc09OaE1WT1pjSjdncy9mRXBSY2NmcEExUWtVdWhpUU5KR3g1VnQrR1l2?=
 =?utf-8?B?Q2RGVEZnYWRGK0tvZWp2bkU3dVB2TC8rMGpJdXpvdmJWeVBoU3lFYnJ0RElY?=
 =?utf-8?B?WkFqYjFXeWt4MXhzQmx0RFpjMmJIVW4rZ1ZTeHhKOExLMExzZlBVSTlhdzFk?=
 =?utf-8?B?bkJSN0lPWGc1cCtKcWVadXNKQTA3UEVDM2lweUFCQ0FSTHNRU1NPUG56SEpE?=
 =?utf-8?B?cXRpOVJYd1RxUHZvbzdPSkcrclpkQ2FLWFI4VXZ1SnAxQ01JU2VMUnNkQUpr?=
 =?utf-8?B?MjY4dWRQaFZrSGgvelZxSTN1OGxKdFhMclVscUFLV3U1MUphNTAydThjZE9x?=
 =?utf-8?B?K0FpR0ZpVWlsNnB0TWR6eWs3anhkNmR1REZJNExpZWFETnl3czFxQUtsL2FU?=
 =?utf-8?B?aDRjMUtaU0FhbFJiOFFvVks2alJXeWRLRHc1MkE1RFpSVVRGeHA4RUlYUWpU?=
 =?utf-8?B?M1F6cG03VVpDWXFyd0ZMSXc1cWVXVVFPbDgyRWZYc1RtS0J2dzB1b1pKTXcw?=
 =?utf-8?B?UlpRT1FuYlFJSExzamlJSHhZSml1dmN5NDJaZCtNQ3ZIb09IZEpMWmdXK1lu?=
 =?utf-8?B?YXpQMzVnQU1Wcmw3Sm9nVldjOVpwcW13Z0IzNkJ0MGFPOGNTVnEraEpHWjIw?=
 =?utf-8?B?TTJlSk5pUnhSVHVTcWY3SkRJczJuaUFqdnJtRXhPY3k1NXZDUCtMZzNabE1x?=
 =?utf-8?B?OTgrQUZwYkVDcEprNDVra1FJYm1pdnZwckllTWMvVGpmajdjNGdtNm90MUxN?=
 =?utf-8?B?TUZta2g2VUVBbldGRlRoTGFwTW1zL0FzTHdWSHhmNkoyT0xBYW9NS0cyZkV5?=
 =?utf-8?B?Y2R3QzNHYm5XeHBDWkNkdG5FTU1TRXJaWUlGd21uaXhrNEZ5OWZLM2NoYVgr?=
 =?utf-8?B?YTBqMUN1T1VoR05kdG1sL29IT1RKUThNWGxDT3QrV0twNkF2QWh2S3d0WW9V?=
 =?utf-8?B?ZFJmQnA1dWZFd1lhSGxocXZsd21WNE42TU03b2hweEJPditzaDBJUzdkNXRp?=
 =?utf-8?B?eUM2VWl3OWhPMHlXMFJ1QzFsWXFPeFRBdVp4cmFUK2pzQ21TdTBXMGVsY0Nu?=
 =?utf-8?B?ZVlnbVJhMERkekd1WHVabjFwaEFPbi9VbUNHYlhyVng4WDZ6bVdnUG1kWEox?=
 =?utf-8?B?OGZxVkkzaFo1U3pWQzNDbTNJOVBnMlFvbW9Db0ZDQmV4NERZaThINXBLaTFm?=
 =?utf-8?B?eXNuVGU5WEVtUGRLemkyR09iSGppVFIrdjRVNnFabklLNDJHQWV6cU1tTk1G?=
 =?utf-8?B?NDM3RmprN0hOaTZPaVNSWTlRbGhYRUZhRXNMaENDYkZTaUV1ajVabUxLckN1?=
 =?utf-8?B?RUdKZ0dmazlDdUxxMm5pa2hncHRoWm1ON2E4Z2s0aHlBUy9FMkxTWTlFVmRz?=
 =?utf-8?B?VHJaeURqdEx2RW5QUkJRNCtBRmg4b1NzVUJ6OU5BR2JzYStRc2ZhUU9IbWNk?=
 =?utf-8?Q?nqo6iaXyHsJ7+MGF59AVAO7P3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005a1f0d-afc0-45d5-24b5-08dd5cf6b0bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:34:35.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NweCjeJKSb6qc9Fj7z/J9AW/jNgTqYRb/2cX1q6na25lYug5Z42AEmC7IWQgTAClRVaKyh9KOtCV7hx3dJXRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
>
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
>
> Move it to struct rdt_resource.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


