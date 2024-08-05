Return-Path: <linux-kernel+bounces-274190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F809474B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D441F213F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91E142904;
	Mon,  5 Aug 2024 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlkKNGh0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE4639
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836147; cv=fail; b=CibjxRIa3/9OeW6AccgWh7jkMm7dX4J+o8fkJ98xnN5xwwLcVC8ENhtvqbj4SqCYadbv1xBQCg/r2W4ggTpB/mYFgCVm0nsPNAAoc2J2damGhCzTi5Gx8giNh8K4HzuHAgXiHADujZ/90XYpuy7LcLFfV36c3zYxjQoiiMzlK1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836147; c=relaxed/simple;
	bh=1iEaXObWHW3OgrS7cEvErnSOOuVPQkrGJ8Sow0Mvtjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f4xHLatEuJyE8hajlplPqigvdFVbRwjonnqyiBcJV2GtLnCLcnojfWNYrn/zZicGDm+nXAop56Wg7b7k1ERuS8iiGcltdYin8Je2Bfz5jzutB23xvzzlthroPxMLDwnlULDZ4Gw33G/OEUNBbURC2e0MJbPQP1CmF8iF6FlKFXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlkKNGh0; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF+qppTAIbUjvhWkrw+BK3Did48CSWzQ353qTBn730LmNPHEedMJ+gocdS5dspggPKROEsNBkzPPTCegAoaFFtcFaRXMNtM9+kGBby3P3224q6dy6mSws7LYd9YIdoCBdUYVQBUX+D0pGJOgFR5DYCqthU8dW1zp5ot7iwpoU6+jraNS2N/YzMAxuN7Wf7/aR+cx8WjCP8yu2v3nuHYfY3Ifg64oiXCe3a7YcvpCObA+dCGpRrpVIaxsr+UTUZmhwgjrH0ijijlfKRqHbU+fJ/pl7E/NDpyMtAf661ZsGkHae6EqB3fv3zR0UkOtppMK6yF3viITLo8nmqf0WVnDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o7CPMLa16omwvYEizE3Jz8uiDs+W4jLddttTUQzNgE=;
 b=LInzyHwrXchd/jDk+GiZF5KV2r/XoGRJxZXYyfX4gaZQM9Om0lG4VRqB8NswWmkd0EVWSdeHoFKCYtVi2s3ajjj38Y2zg1Lla+4CfBFHHPTu/s8NrVNNFR61qwxKoe+ZBwZZAE83FKYi0VoB8mcRCqiUfCBk+ompPluYJUap581V80ehvP0zwuDACG5RMKn/U5eGIXf6MKBPcu88zE+i8IA+gK+9pxxkSSKfg9fZ+Ykc24Dd2aY7tMM8AzLqogf4OlNup3pyvPS4/7zbkLvNO1TwgqSi5/IV6R0/9zKfQ2qUy01k11DAMFLREg3l0A2leZA74yAbvrtcDYAGrj4d5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o7CPMLa16omwvYEizE3Jz8uiDs+W4jLddttTUQzNgE=;
 b=XlkKNGh0QmMg4DD9IIEmys4mUcsQAY6KPSdfGRGJ6mrcRmxuFxr/7pqJZCO4Ibtu7M0uZbaveVwAH2dk0PcG+B2auBbXs2CK9qXdlP5G3zJMzJpg6jHQT4TOqo5KZmOh1URHQOSkgXxMnrkBe3P8ZQaFbCCCU5fEUFwWq1zfi4m9k62lb9oy1UiK6gHN/xYdimG6Xnb+sOqMfuW9uRExqSZ6/WXYjlrjnCJ+oHRasdIrGXBNKieOB+UFBTkjgXLuvMVbHAJTNdLGu2NBuz47YMFLRoUWDo9prb6Sv0STYxaZRQIkj68is2+PxMtGQyRepm0qxutNLKvPDNABBOPp3Q==
Received: from MN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:52d::28)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 05:35:42 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::41) by MN0PR04CA0023.outlook.office365.com
 (2603:10b6:208:52d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 05:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 05:35:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:35:20 -0700
Received: from [172.27.34.119] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:35:03 -0700
Message-ID: <16fbd3eb-92e2-4e6f-b020-4f5a2feee4ad@nvidia.com>
Date: Mon, 5 Aug 2024 08:34:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pci_msix_alloc_irq_at() affinity
To: Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>
References: <ccb1b2ca-0d62-4c74-ada3-89cce13b8de3@nvidia.com>
 <87ttgcuuvi.ffs@tglx>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <87ttgcuuvi.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfb5e2b-dc43-4ef3-61d0-08dcb5107244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dktrVlZIL01iMTF5aXJSQXl3TitsZTdSbUY3SGpRVlFoaGZTbytiQjV4ency?=
 =?utf-8?B?Qll5WnZMbVVReGtrcjhVREVZTlVibmhaUmQyOXg0M3RYT3dJRWtJV1ZBT0xK?=
 =?utf-8?B?RlBCZHUrZkVrVUc3amhMell3cFEzQThUak1CSEVxMU5ZbnpqQ0FOUUtvd0ZW?=
 =?utf-8?B?cnpxNWI1WW9Qc3V5ajJUOHNianUzUDRVMmw3ZWwwL3lhbFRLWnYxZEE2SEtH?=
 =?utf-8?B?WTQ2K2wzYXFTVllsekY3R0VYQTdNNXVVVmF6aVRITUM2UC9qRHdjTTV4eWVF?=
 =?utf-8?B?RWc3RnQrbjI4ak1vWmxTNVl1V2hMTmJCWVZUK01aV3IyT0JZY1pwNmtPUXJ5?=
 =?utf-8?B?UVkrNFloT3ovWGN2VVVBRnZPR055YkljQTlCUW11Y2NxaTBUYStEOVRTSmxx?=
 =?utf-8?B?UEQ2YjlDd1d1SjRwWkszVjVuSkFQQXV0NjBYcFQyOENkY2UvUzFiUkdJMTdS?=
 =?utf-8?B?SHRpSXhIbFNJQzBScnlhTXNWYnBBZHM3dXJvRThOcStiM084WWEyT1F3c3BV?=
 =?utf-8?B?NEUvZDNJYVJzdjNuYlN0Q25XdkFCMk96TlJYVTdEMWx3bHRyeVJWN25qakpR?=
 =?utf-8?B?UjdnSWlsdDlCWnhSRUUxYmIyK280bUtmTUZIMG5LUDdhdWxiMFVVTEJVZERy?=
 =?utf-8?B?d3liaUsyYmZ1OElhNWhjOHRpYk5mc1RRYUNOclB1UUVTMkpxOWJTT09oMG9O?=
 =?utf-8?B?d1BTV2RaZkoyYzBWYTVQR2x0aFZaK3Z2Wm9VTHd4SEgyWm9DK09Ta2hCa3NC?=
 =?utf-8?B?aUk0RENSS2RKY2JQV3JrY1RjZnpRSllsN21YMkI3a3ZWU01MVTRVZldtSUFl?=
 =?utf-8?B?dnk0L3R4Q3NPZWRJaWZLZWZUMFVaNGYwdGtFcTBkNnRuNmJpTFhCbEwrV0Jl?=
 =?utf-8?B?MlQ4eS9qaE1meU1SL05VOHBOZXZEUnVpZHRKZHJJZ2MyNWVhS3JEU25uNTFO?=
 =?utf-8?B?Q0ZucGgvNnUwbGVuWDJHVTNpM1JsWXo1c1g2Sm5NekpiWjlNVHNTdHF1K1J6?=
 =?utf-8?B?SVlPU1FuUm4ya00yRXpDSUZ0R05TVjVlcG11ME51aUN6Zlc5VG1meTY0a0JJ?=
 =?utf-8?B?UDZqdU5JVGJ3VWVQazdzT2lhVnRKbHV3cDlJUjFqWkg0ZEdIeVB2NHJQOGND?=
 =?utf-8?B?NEtLejZucWtyZzE0SEtaNGFuSnF1MVNlOCtLbm1Jckc1aUlvc0hIUHMwMGEr?=
 =?utf-8?B?MC9XWmJsMmY5cEtNLy9iRkJIUEpEOWxheUZmQ1pyUkJhZzdMM3RTL2Nzb3dP?=
 =?utf-8?B?RUt4ajJWSHNrKytqVmdXNThBandUUlAzemwzU1BncEl3MHp4ZHJNaEkyQ2E3?=
 =?utf-8?B?OEhISElaWWJEWFl6czlXWFpjd2FDUWx6UEpuMndYSFlXdytQVGJyREJiTVQv?=
 =?utf-8?B?V0lxUUF3ZVkxKzlHKzExVjVYMHNhUW1SRzZXelR6bEtYR1BYcVZOZ0x3eDIy?=
 =?utf-8?B?NDZWZnlrYTNFWlZEWWRNSTJqN3dBbzdWV1doQmxEc2M3cC9ub2I2U3RDZVlY?=
 =?utf-8?B?SS9ObkJqSU5NR0Z0U05QTVJmVzAwWDBZRmRzTnhlY2VaWnBEVWdmbWhlVjBr?=
 =?utf-8?B?TVlVT2xXN2pQMTBwa0NRWEJMOS9KWnlVRUszSSswdUVscDc2SGw4OUQ2b3FC?=
 =?utf-8?B?OVdZdGo2SHgwakpBVnNQQ0ZLRFZlRjZKbGdnQ0dDRU91SHZ2M0RvU3U4d3Fa?=
 =?utf-8?B?clNJRnJpa2hrZEI1S2syWlA2SGRlTmt0aUw0ZkE4b2p1b2ljQ1VJQU95UVRB?=
 =?utf-8?B?YVVlRkgzdzkrQlNPa1NLZ1ExVlpPd1doTER5dlNZeVd4bS9Ed3VoVkZlN2NI?=
 =?utf-8?B?VlUzK3hzaEdQSUpzQWpyZmN4Vi92b1V1OVpnZ0MrbStBOGo2b0pVMWZNOEpW?=
 =?utf-8?B?cjFqZGJsajR4OXF4Y0Q3dUxabnpRQkpkK0dKNWkxeHZQQ05ORzNXL29JOFQ3?=
 =?utf-8?Q?oAtg3oyKjKQUrpB71mHJFZjloOjzToGb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:35:41.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfb5e2b-dc43-4ef3-61d0-08dcb5107244
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971



On 26/07/2024 16:48, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jul 25 2024 at 08:34, Shay Drori wrote:
>> I did some testing with pci_msix_alloc_irq_at() and I noticed that the
>> affinity provided, via “struct irq_affinity_desc *af_desc”, doesn’t have
>> any affect.
>>
>> After some digging, I found out that irq_setup_affinity(), which is
>> called by request_irq(), is setting the affinity as all the CPUs online,
>> ignoring the affinity provided in pci_msix_alloc_irq_at().
>> Is this on purpose or a bug?
> 
> It's an oversight. So far this has only been used with managed
> interrupts and the non-managed parts at the beginning or end of the
> interrupt group have been assigned the default affinity which makes this
> obviously a non-problem because the startup code uses the default
> affinity too.
> 
>> P.S. The bellow diff honors the affinity provided in
>> pci_msix_alloc_irq_at()
>>
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned
>> int cnt, int node,
>>                                   flags = IRQD_AFFINITY_MANAGED |
>>                                           IRQD_MANAGED_SHUTDOWN;
>>                           }
>> +                 flags |= IRQD_AFFINITY_SET;
>>                           mask = &affinity->mask;
>>                           node = cpu_to_node(cpumask_first(mask));
>>                           affinity++;
> 
> Looks about right, though the diff is whitespace damaged.
> 
> Care to submit a proper patch?


sorry for the late reply, Yes.
on-top of which kernel branch to create the patch?


> 
> Thanks,
> 
>          tglx

