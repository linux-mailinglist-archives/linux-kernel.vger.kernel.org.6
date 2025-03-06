Return-Path: <linux-kernel+bounces-549937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D1A558D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4330D7A278F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0920764B;
	Thu,  6 Mar 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3zGUO0s"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EE1863E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296751; cv=fail; b=LHnzplo+siGEySyEsQEJaoZqodVg6TiE3oBsZqyfQgSWY39TWuAVvAqsFBk6s982JKvcL5aka9U6lxOoCrCN1CZiKW6S9cjJ45I54+HuvGfwIpWBqQDvh/FH/MWwoLev69lOy8tknWqYvRB0+q9qEgdKk3icH9Fp4Gb4cZG0BGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296751; c=relaxed/simple;
	bh=A3nNIL4K/GC94eJVkkevH9OY2zsqCuJ2QpJVox4E0eA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnPcXh0iEHNnm7Wk/lW4JnncF+ZJOKCIIa4rgs9TwJgsNcGMLNi6zEOc6OyTjxrKEFd6qh9P0qt9KPxxkre8AxELI/SRRq6n+20b2hE0UU8nqyaIx19APgEl8T9m1dEmM2K6n6PEfweoYMXBXzE3394HCw19v4FQC820mY3ys9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3zGUO0s; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv5kmpdD1fTt+Dcx1Vx/VR9AWzXcm02inDsNJUwEghxlIoQaV5ykSnxPDHwYJljse5x4ayAn8mGh9dB1OTlX1wDobyyUGVCiHDJCfRnni0kmlg+JboEzmpU4m+QvhwsLBxKCo3WDmwF7N9s1W8u4OYcG5eIiPfytPrAMvCUGk76+AXsivx7xTCfIw481/iKQH70m7/YXpQ94Nzw24IZJ/tMkcYfzAfRPjoOyTpxBSzzcMPogZp/wt0IaIWlxoytXZLftcy6y57enK6mgKCt0prQWre+4fLOZC3hpuybuwDjvz2pPGcVB3/ckIz6vwsrtnS3ntbKFmsX85HvCFXj4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3nNIL4K/GC94eJVkkevH9OY2zsqCuJ2QpJVox4E0eA=;
 b=rcMajT11GH9Sgg0Ni3XhqUSyCGyGa75HGqIZH6VaIs/XZPs/+ggh8wALqB1kIwGntGFb+NEgn6L1KuW0XPF6n8gZxh2eZv/Z7ma8FE6mUrxj7EosYweSp1eGgjCGYRnT2M+yplP3836NY6/q0oLqqAEvOCiqrnPJBLy70m2roUzly9BkmVSlvfTg48WLv2MuPP3RtQOsc8YJEeUcxfxFQcaBEi0iKCOhJdYNR0DbXAJWpHIPqN/4WGBp47xRZLEwwIKMtmMtVV8fcD4WtFSrwCKIZa+wcRQCVvJE2Kpv2o8U9MK4ppOdquFTADCCeMcrl8k75aXK13P1oxqtBMtn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3nNIL4K/GC94eJVkkevH9OY2zsqCuJ2QpJVox4E0eA=;
 b=I3zGUO0sG1IFskvxCnkq1JrRMV+BcJMbzFy2ppWDjtEUpWUyqC9HpGB9LkXSUyWWrBDNtRCWLmfd4bn0bqEg/TgWWzd2IEBIJizwkppX8qI/AcK0wgjrRLvNGPkWBqqjTthFPZ3xgfOrYg1+/CNWSxWVPuK7kXlLrL4pAw4SlZ9ljP4OevQJyPPe+jpIoSu6BK+pbuORXavQi6gbZmdZ/f4JC2LTOnYJscEIHNMZdFWozN1Wuw4ZxhTuY0X24eTzg4kNdwJ7l01aGhXFV3fHBFDX9trQ5Srpp6Aot/wxU8XOpKqDxhpWguZCUe6qFIQEItpOEEACXqQJuTG1yl8eSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:32:27 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:32:27 +0000
Message-ID: <d9ef5c2b-c0d7-4f41-bfc5-b939ed507745@nvidia.com>
Date: Thu, 6 Mar 2025 13:32:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/49] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
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
 <20250228195913.24895-20-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: a847cd63-0468-4761-ecad-08dd5cf6643b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDVQUFdvTXN1dVRXMFNGZWFIYWRPK05GVjRIaHB3UksrN0JnRFAwczRsRENV?=
 =?utf-8?B?TmNVaDZ5V2Z6MVRRNytrcFhsSG9CbXhPdkljUjlxM3R6aDlCTjRxTFJoWnlW?=
 =?utf-8?B?ZW41emc0RVhraXJvblhSTFdJTU96ZFZQRGowOGduUllSTFhzZllBNWVKcWVK?=
 =?utf-8?B?MjB0VlNHV3FSMWNGbDJUS3IrUnlhN1ltREtUTjRqODBDeEpKRWxiclFURmZM?=
 =?utf-8?B?UlM4SGx5aitlS1VVbE9VYWpaaGcwblRQbmhmOXdydnE0cTdhRDJ2R1g0OWRk?=
 =?utf-8?B?TVhGbmdoODBBck1oODNSa3JVeC9nU09rUEhnL3JLalE2S2drMk9KYTQwK3Yv?=
 =?utf-8?B?YzZ6dHR2NzM2RHUxTHVRb3l5M0w3SGhscW5IZUZZb3dMcjN4d3NEdHpmeCsy?=
 =?utf-8?B?T0ZRUWdxakFPZkJZRnR5NzJIMWxlSVdGSUJjWlZ1V2M0WEtQVVpXUGdBNmdx?=
 =?utf-8?B?cUNOa3U2TWdscFRpTC95K0RhTHpzM0hncDBRR3luUXRZSWpBTlN6MGVoNkpD?=
 =?utf-8?B?TXZlR1lXVnBnZWFPZHVFdytQVWhCMG45ckVJVE5hNTNjalpULzZPR2w2K2lK?=
 =?utf-8?B?YVpObnQzTmtWUXVYQmtqNWx1ZHFWVHFUVVFqWlFxY3dYNy9MYkc4OEliWDl3?=
 =?utf-8?B?UFhySHFoclpYRS9DYlBlTFNobWlCNWk2ZitWY3NjVHRlT2QyMGMyQXhVdTNt?=
 =?utf-8?B?RFNjN3cxSndSVzJ1MjU3b0I5SnhjalZLdzh4OWRnNkw4K0ppU1JRcytZdlNu?=
 =?utf-8?B?RnhER1lXKzlSb2h4VXBaeENJcHJ5Vk1GMCtvSHZ5Y1MxMUhZZkcvWDVPL1Ro?=
 =?utf-8?B?N3h6RC9weFQzWVkvcXZOaC94OW9uYXUyb28vWEU4R1JrWjVTZzBqZTk5Szd5?=
 =?utf-8?B?dW43L2tSSVlzblRncVlTeEp0MWx4bW5WcWlUNVF6VlRQZUk0cXl4bXBFc3hW?=
 =?utf-8?B?Tm5QNjF5Um1Ua2c4QWN2MzltZjVMOUZFNytHd3d3VnNoQkc1RjgvYXBTeUJG?=
 =?utf-8?B?NGRPazJkT3JuU0pNSVN0NG9NWktRVm5mVHIxejJrU3pBdTh0THJkMHlxOFdX?=
 =?utf-8?B?cWxnNzZrdlQ5dzR2Q1lsZmg1b014WWY4bml2cHVYUmhmVVhaTzB2RFM0dU9O?=
 =?utf-8?B?M0lrb2VRblRTUVVUQWZ0TGx1RCtPMjc5TjdhbkkxTDIzYXdKaitibGkreVhv?=
 =?utf-8?B?b3BWQUR0bktGZEViZEZNZzJuWFV4emgxY3IveW9QR0tPN2JwOGdoWHBiaUUx?=
 =?utf-8?B?djlPNTllc1RWakpqVjk0TW84UFh2eTdMRmpaZ3dVbGJNa2tucDBHOVNlQUlC?=
 =?utf-8?B?V1o4Z3FuSVJ2RWR3VkJsNUtRMXRkMVR1U21jZmFTRWtsNUphNGdTbGdYZTlw?=
 =?utf-8?B?WGY0NkZPaWlwV3JUKyt4ZWFPMCsySXZ6ZEMxUTh4MjRyOHdCVlg5MVhhSUk0?=
 =?utf-8?B?cFBaZTZDTHFtRVBmQ2dWbXlFSHlnQVFNR0VNc3dlNUlSTkd2RVVUU2VYS28w?=
 =?utf-8?B?aUx6K3BPTU85RWgwSDIydU9TTndsRS9LbG5mUUxhVVRXZ3pTUU4vM2RUazRO?=
 =?utf-8?B?M25TalhQN0lHV0N5ZUtMTnk5dUNSYXlKNFhKQ3pHYzBjVlN4UFpsdHlKbFhE?=
 =?utf-8?B?NlkyU1lWYnRCQVBLRlVUckFZUnRFNkJHd0FtbzJ6bldYQ1U4eXRzcWNCaCtB?=
 =?utf-8?B?a0JrZUVsQVdUc0YzTWlReWNybWxRSVlLQzJ2bE9zVytpM0pJNjdvY0RpakZ1?=
 =?utf-8?B?dWprdG5iRDhDWFZ1U1BSdHo4YmpuZ0llOG1mQ05CME4zNVJpcGp2RnBORVc5?=
 =?utf-8?B?NVpYMXMzbVc2a2lLaFdFOUF2VEVpTUZzY2NGVkwrSjNzRHRabEdwK3QwTlBF?=
 =?utf-8?Q?H0QX5KcRRIlX0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFROZGhJRFg1clBEZmxkOHJuWE12WktTMlF6aE10Q21tZlhGRGN0TVRDQUhM?=
 =?utf-8?B?YzVoeTBIVGNtUHFvaTlkYWwxYVRGN1hPellka3RiRjk3VUd3K0NGZ3dJRkc4?=
 =?utf-8?B?bnV0RUxKRGVJODRMMmcyWmhJQitmdWJSTCswaTZ6Q3VoVHFNbXRRMURneUtE?=
 =?utf-8?B?NXR2a2wrcVNZbDkvWjYxSUsvRmxPWEcxcERjM2RmeVQ2bTJGZHNaR0FnN1gr?=
 =?utf-8?B?Vjd2MlY3VHIzTVBUUDN3WHk0cVpKVjRRZnVKTnJneG1RSHBHa0VqKzNIcXRq?=
 =?utf-8?B?Y2lnZWRFVnVUcXh3NjJlNHBId040WktrMFRWL1laUmFjaVdtM1pndnpKdmIv?=
 =?utf-8?B?eWdNQ3pzS1NMS012djdGek96Q0JlTUg4RmVQa1RvT0NwVUFXWGxkZjhFRk94?=
 =?utf-8?B?SDBXTHE5aFVRdTE4WXB4eHNUYm05KzBnb1RObHNERmEwbXZKUDNKcWlaUjA4?=
 =?utf-8?B?d1ltY2hTcy91WUtTNklqZDlyb1hydnlGbCthSkJGemlUY2dMOTF0OW9CVnJJ?=
 =?utf-8?B?MnFVUFYvM2YzT01uWlh1cFQ4ZjEwc2RQQzREWVFmeHc1Q0szeHZraGRZZ2Jx?=
 =?utf-8?B?Z2Z2NzdIRjBBU1ZFUzFNaG1QZHRkVEozYzVTc1B1cFo0b2Y2U0ZCQW5oYmFo?=
 =?utf-8?B?MkIwVC9uUmlZc1lIMm15SkpyRW1CZFg5VmJGVlp2QVpTMC9ZeEFXM29NWDhF?=
 =?utf-8?B?NWJmelNzNEQ2aUsyeDM0aHAwVXdSck5EbkoveWFBYVNtREZKMjRUbGFGSjBZ?=
 =?utf-8?B?MUQyYy9mMGhLb1h1dmtTSXZENHZiZ2J5cCtodW1qTkRzYkF4b0VWaUNVVzg3?=
 =?utf-8?B?aGxCSGxSWWNZbXdyQW5zVUFidXNJRk90TGtQbzVrN21pNG5aVnplekpGTWdh?=
 =?utf-8?B?MG5iUCtmRVVVNkM1Ymp6WlBVTThMd2VNbFo5NXhyOWZiS2I2M2I4SHJuZVYy?=
 =?utf-8?B?eWEyNUZBeS80WDF4WHpTb1kzQUhDQXlLSldSbEwyVlhCSU5aMlU4aW84OEZm?=
 =?utf-8?B?R0VKbWxoUFE1RWtoczFwNWJwR1hCTy9LeURUNVExWGJ0SExReGE3UVJjQmVG?=
 =?utf-8?B?d1RlczlwWEIrMGk5WkZ3QnhFL0RjeWFsa1dlT0EwMHM2bXhRQW9zV01XNW5W?=
 =?utf-8?B?cnZiZHZQT2F6WnZEQUZnaVNRWUtpVzFVclBQZFFZdWFyYXlMMko4aFRxcGEr?=
 =?utf-8?B?MkVUenh4YllDK1BTNDJ1dFFSUWttRm5PaXByNitNclpPZlBkSEg0OERaV2Jk?=
 =?utf-8?B?ZnRsY0txcDk3T1ZPUDk3Ykxla2dCMVRWWlV1QlBwSk9aN204VDdsNlB4VjlN?=
 =?utf-8?B?d0JrZmZVSGNPOWwwdmRTLzVlVUtsMWYvRW9DbytWSmlxVmYrN2twQkVzRFBp?=
 =?utf-8?B?MlVQTnhKSDN4dkxXdGpFVlJLSjBqSk11QlVkcUtUN1VjTW9Vd1NkbUxjcDg4?=
 =?utf-8?B?YWlmSG5mQnBjaElRbEI1eURDWHdpL1NOdk1BMW9ZTXZYem93aWpVKzJoaXJ2?=
 =?utf-8?B?WHJpNUE0a3VMczZvc3FVZ3FWbzhIQitudVRJNURzUC9VSVpRNDEybzd6SEtV?=
 =?utf-8?B?UzlGQ1JUakpoaTE4S0sxOWQwRHgzcW5xU2xoOEJHTi94cHR2UTU1eldtcjRq?=
 =?utf-8?B?REh2TXlGSFIwbEYxWlpGTkhxV09xYkJPSHlWcXRvNGxiU2p4V3JoUWZKR0pD?=
 =?utf-8?B?czN1cDJ5cXAySmNzemZzZzg0ZGdGcFl3dXZwWkcyZExpRTBremp1VzNuZXpr?=
 =?utf-8?B?VXNpakcxUE5zOFR3M3ovL0Z0WjZjRHJqVi9mN3ZLaVczcW1qM2R0cXFnY1dT?=
 =?utf-8?B?a24zU2FwTFJXWlg0VE0xa0V6ZU9PVWxEbTJCZGZjUjhCSHA5azVtUDlPRGcr?=
 =?utf-8?B?enNCMkdFQXA1S1JONVhsQ3ZoZ2lBTS8valI4NmlHcFZpUVdEYUtHdlhJc04x?=
 =?utf-8?B?UFBIVkMxbktJRVl1MkM3d2g5V2tDbVJoVFY0LytnYjh4SFMweUQwV013cWQ2?=
 =?utf-8?B?OHNtRUNncDNFZlJRSlVXWVhwajRxYklkUjIrYTRHRFoyN1pnaDlOdlA4T2Ur?=
 =?utf-8?B?ZmI4ZzNWWVlCazFCYndvSFFQSkJLME5OaHR1b3FVQ3Zmc3dqaFc2SUtudGFU?=
 =?utf-8?Q?mW4qXDoF3AaG78ONfsfCli+FD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a847cd63-0468-4761-ecad-08dd5cf6643b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:32:27.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OOVouXiQAcWccxuSUQ2HCrrE7Atld5P3I65Ke+aC96ZLB0o5QA5Zruolb3qZGoiG8lTc8C+O2PJO5Cp3SpbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> When BMEC is supported the resctrl event can be configured in a number
> of ways. This depends on architecture support. rdt_get_mon_l3_config()
> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
> the files that allow the configuration.
>
> Splitting this into separate architecture and filesystem parts would
> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
>
> Instead, add resctrl_arch_is_evt_configurable(), and use this from
> resctrl_mon_resource_init() to initialise struct mon_evt and call
> resctrl_file_fflags_init()
> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
> obviously benefit from being inlined. Putting it in core.c will allow
> rdt_cpu_has() to eventually become static.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


