Return-Path: <linux-kernel+bounces-305535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB396302D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADC2B22039
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2467A1AAE0F;
	Wed, 28 Aug 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BodvBoXv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C901A704D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870329; cv=fail; b=ZVV/3T7Ok74B0KLYKlA1OmNRi59Nvd3JxGnqc7q1u7AgcP4zYmc1u4ej3lvFogLCLVcVlKkppn+eNY1d5z/zZIl6AZ88nhIqCvhJYl+CsYpW9+81MuRg/U8c0Qd3RLVMmMmhUnQyeEiey1jyB52ZknVAskdm7kEIvqesVHFxdNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870329; c=relaxed/simple;
	bh=7luG5fseOMIbGDkUWrGCqnVzLikXuQV4s3OgtZk8p2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mmqc7dKxzUJGegq03ummssbNuenuW3dHn8VTPz+xkMbUAhX4GCsvRLxpfH4PNr+xh3QR3bZKhV85E3tJW1VQOLg8X/zCbU61HKEZOvaJBv12kvHmkgXyeSXEFoLB/3esU+vwmTPMV0X1F1oGRrz4HQEXeek6DkNWSp0gHLwunIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BodvBoXv; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxVdcP0jwkKqXwA7csdtZlnPuMt6LoxV2SnQGnXk0BGbLRSIo1sODJrHI6yrBZq8NFEiE/B0WPEk1hvnp+0cGcvoM/j+Ot2fy/0l0fxat4I/zKipsfSS+xd7AxEWOJ3pxJ6Sg1bB+k3iFn/6RgjaTnTfxuWxxy4m5ll5YZ/qY6XMq539VMTEwlEvUNyikhozwpBnS4ZdQlkuLR5wXaZz0+dCublclcTXikwqY6n/h4mmFSqOQQu/Q3vRUmlDl33nkewjOMqx88fSGlw4+CGbfBiN+7do/BFYTvyN59u/Dyhsfd+JBptJtxkeHuvHWngfIzuxNJ/NblT2+6MuuYCsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPPlkBw9eDnJLEgMiaGkg3lAXtDsfd+WpfBqRZrkXmg=;
 b=eDlbyTS07ISx18/GMGRBdTKNKCoTStlnpaQ7qCzCcy4MNCKPqa4Iz44fofWjgLQHxz9XyzpCu/gCnDGX96zNs7/tWOQbP3J7NqLikgt29AdMKv6theZHgSKlG1BRHmamSi8E/wNj1IVT/HGrSOB3XNemwBaJDKf3S1TcgtWDL+1QItLbYOtF68oXR4x1nkAKnnadeyv/fxo2TQNtiT2wli5cjLjaerUcZYatxY81r6oplWrieo4FWufaEdoeFUKCG9m+KBOogzn8X0j39cOnxqHw5LVtXFL5U/5wp41e+DHcC3s9KjuFp1vvZL/VnP39NmDKOGib14itXY19TqMA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPPlkBw9eDnJLEgMiaGkg3lAXtDsfd+WpfBqRZrkXmg=;
 b=BodvBoXvW+KA6uF5F1eJlIo6AQhjUJA7YKOGvPz+MJ5bxs82s/gmLSIgI9xItvoWsBuK0kXKH/ivY7kpp+WtszYBAZGeo9rdsnQGI6af9oIOiufSAtZKjH9prjIBuzhY+cXpPvTJ28N+Pv85KHbaUhxv9EyH2/RNxVY4GmPY8gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 SJ0PR01MB7464.prod.exchangelabs.com (2603:10b6:a03:3da::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 18:38:36 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 18:38:36 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Alison Schofield
 <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Andrew Morton
 <akpm@linux-foundation.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, patches@amperecomputing.com, Felix
 Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] resource: limit request_free_mem_region based on
 arch_get_mappable_range
In-Reply-To: <668c92e35c677_102cc29475@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240709002757.2431399-1-scott@os.amperecomputing.com>
 <668c92e35c677_102cc29475@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 27 Aug 2024 19:57:01 -0700
Message-ID: <86cyltjqwy.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|SJ0PR01MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 675f4df1-1449-493b-9619-08dcc790a06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s2l4Q7GJxAuh7aH1bFO+tDG8/HSz766tXsF5rNkfV+np+ILyJMv1aOFnXr0O?=
 =?us-ascii?Q?zs66suAZyxk9wgEz8ycD/EZ0BrcjTI/1xyDGDdKFk6Q4uq5sSJUiGWcDjVXP?=
 =?us-ascii?Q?sTMjLvsr+PO20/mnVoJZFuKsZ7MNoF+h4m2kVoE2GLaVcOYpSoqfK1hlAmaF?=
 =?us-ascii?Q?pES0cI0aGJZitZOX7LATBMbfxOiz3zmAoArdfe4zq8t2sJS+OXpJU4dmznPq?=
 =?us-ascii?Q?CLx7e6Dq7pTfLgaMaUxwFwSfoFhEclhk/qoAI1Nk5puhh+vDxVD8UbKMfKD6?=
 =?us-ascii?Q?UigJFp33deQ+6I8lvirjGKhy/432+wOIRRkw14SpfQMs6aQgvjRWyGH5uxbD?=
 =?us-ascii?Q?gL3y8QPYbx+rxUl7osK+bYYwwexONe3mkfLahr4oDcLnCB3cp6pZnv6eqFT8?=
 =?us-ascii?Q?mi+mf+mPehlG/7UgRnP1fGixC6cYrOftBqbnWXFZz9wAy21e6Nas0HOzuEHw?=
 =?us-ascii?Q?9ITfg//4HNbP+4pa95/aHDEFunuraMb/cwEWXiHdY77iIuF+RiAwn5xZrZ6B?=
 =?us-ascii?Q?mEANCvq6Liq6oTow4bSwwDCXPq900JizIEZrclT/USi7JhyOCnFTPCeKRP4y?=
 =?us-ascii?Q?dA6F9NVfI0+/Nzd3IbUYFGEorm59WHZ3yYNaFkYr4RtmgyV6NoQlmMFXs4ku?=
 =?us-ascii?Q?nZUy8FiBbzn3wxV9aXyhKo9+lxX86EJoT6Jl/gea30syyPz3pGdnlKqaVlOZ?=
 =?us-ascii?Q?w2sYNQu9YaQrG9+GMebYjaCd+tb3QV6fLl3wGOsRinPhczbOOipMHvJQDTK1?=
 =?us-ascii?Q?FKGKBYYHdfCI7Zk6ivKvMHe2fcTFn5zyLfhA9EZtJ0qRul18H9jlcRDm3r40?=
 =?us-ascii?Q?fVLwfhZPoexryRR6Cp13SfXZL0acXYIUbhjR46EWzIG8OvvOUCYHLTXYFZCU?=
 =?us-ascii?Q?wOK4qoHQSXnL5Ow5Y/UtlOZfKLBJa457Vfm1bawRhH3WfoPoxwondPUo9Fk4?=
 =?us-ascii?Q?lGTfnwSUwNLkTlYXXbaC9LHZDtnWkZpM7IlqP7KF6AnzEMqZ69oovxC/TkmG?=
 =?us-ascii?Q?y5eqzr4zkYAPu+8acJtAokr8s+gUx//q9UBam3fjvbb249imL0O2YAJ9vOlf?=
 =?us-ascii?Q?RrtD5ww0m6TqLSXqGCWwzUmuEDUQGuSjS+ZMbiWUEnHVIJAHZWEOINWhyIzi?=
 =?us-ascii?Q?pe2NAeITDke+fVTRTaKLFurKXvGkLthKDHNO+qk3CH2/SkBJjBAlketgjFOt?=
 =?us-ascii?Q?ujcyh6Wb7j+9fWP25AuG+q1gCB9N30JOIKYaLpfDyammxtaLtl4G9nm/UWP5?=
 =?us-ascii?Q?Ck7W5n5zKuN0ifBxWyA5ovh31L3P+fzSi5LIP2Pl3eGRAvtOSHMjUfts9KDT?=
 =?us-ascii?Q?5Hbp/TbXfeVcHyYFlp6lc/mJhHxMXSdSt0UIeHr+3oEOcJ4ZQ5DlC8m5222J?=
 =?us-ascii?Q?FPvAd/XghwIsBFcA2P65BOJ/uWJwIQquHZPmuFw22LTHtvzYYlvxsUIaOxYC?=
 =?us-ascii?Q?54cTYV+aKCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?McgIvxMIr+b7Gs+Y3d+uUOvlkqUwLzBf+lZ/Wn1Qp6bjJZYQ7ueBCQHS+PLD?=
 =?us-ascii?Q?88z1RNfLRp+6sEJoDG189g3aiOVXtKZM3QP0JW53vSujPGoPd2/OiJ18EM+C?=
 =?us-ascii?Q?ghwdBBGmGPEHa8Gi0Xvkja1Zw5KGnTLdVUMvEpgXZ/D4mQ7VEPTVc5IkD50D?=
 =?us-ascii?Q?Mkv4fq90b1ZL9QoJPVJiQNxbv3UMtDe1vpKghrz+QHrU4HnetIiN7HbSaVQ3?=
 =?us-ascii?Q?ze0sgCT0CkQ+eYPdL+SeZ0H29utNXBDbNj2OlO3Rd3C0xBWYDRr9vgJ40BDB?=
 =?us-ascii?Q?xhcUpu8ZB1O1NDnxaQOWTaoiu5XPi8Z8jLHEGkuBYbCUnOI/Yw2xDoDYkgR8?=
 =?us-ascii?Q?vxXcriud4xezV7GDpgPf/BPNIJcYc8ggVQloTvt6C6JMa5FpPo6qEU7mxLAg?=
 =?us-ascii?Q?f5l3j+RHMbcoChTYMKaCAeqv4nYOTp5cwEGpObyraO8ctvxepQiBFQgmlC7Q?=
 =?us-ascii?Q?WbiTwo+L7L27kxzm7Z5SpxDD3U75jCHZj2dgFPL7duLjNGXEd1ArIpztdyhm?=
 =?us-ascii?Q?NVGh/PtxsdFG2DoqtfcXKXtGoWGNq9VOMLSzjoDxVh2Mb6zk1Y7/w2YfBaGn?=
 =?us-ascii?Q?3llOp5n6URj4hMYKfmi8rIhBa1NjCG0j2H4+iVNswFNdq/KGCAoUTNcpE4Wp?=
 =?us-ascii?Q?PLE/Uex49HPUnBuzabJ/vBgJq4++Cas5AGW1YLdbKJ3lKpa+/eFnusRtHHDh?=
 =?us-ascii?Q?zWdLi6WC+36S9honEEULp1tlmoyvFeBqHA67jpuhAuJI8zOTrbHCAhDLYBS+?=
 =?us-ascii?Q?BbMlSMMQxgyozYOqwkzU3/+a3OAzMVqsAYaVZrnrZZcugNb2PYts2QiU8TIx?=
 =?us-ascii?Q?JTD1dMqm4gPGKy54/UeuctquFltg9cr04Fezec3DQH/19oDjd07BHNRVvWgc?=
 =?us-ascii?Q?j/DeeSaKE3ZzU7vY9tDif7ZjNvB5lb8XXBUxvHvdSZrHvhtRb1hXF8KwrRs4?=
 =?us-ascii?Q?1mfqJICtqaMvK8llhMNM5/2Z0//u13WLJn2MJ8dUIs/6d3/bzz2gbAm1jUuB?=
 =?us-ascii?Q?XA1NE59BQWOZ0KXWW8DjZPsKNPq1k7oMTrF5Zl5NGN4xguU1b7N9epjEwp8w?=
 =?us-ascii?Q?5nMzqM+5Nflp4/8rZi8d9k0RVSUXAfwuGKmxSTx0zt27aP/AvmIck6qlaTKL?=
 =?us-ascii?Q?8W4NK2QiqwBPHmf1SvKXjtx45mQvdGt2w8yN2oYyniM66OpRRK8XL8mJ1Ixi?=
 =?us-ascii?Q?Nx3u7VTGHI3sTDgCUNK8QqMkp1/ZxlOFDJWYC61lSZGF1PTnV7EP02M5j7Jk?=
 =?us-ascii?Q?6BVqVS4Knpz8k/s/uPN9Xt/wYuFPIybkpkM6n+gJRMM6Ce6OHsxidewKTOYk?=
 =?us-ascii?Q?ZfdHAHT1awqOIk23WK1FT1ITdfNnNqT6mmV7jIPJAYC7Qa/foRMag+0ICyGt?=
 =?us-ascii?Q?/pDWu1ICMbfihWmWGmhAVYQNpBQS79ZtM/BRYy/9eoiLVDr5DieisSZLcCcE?=
 =?us-ascii?Q?QUQnwydgFxIwDuLqK/1xl914tyGPll+6BjF9MWgT1ZDjyAlxEH9PCm+7CXXt?=
 =?us-ascii?Q?1iRwPqMHU+xb447vbRx5JqX3nEbwtTOD8g8mbkmllVIWcXP8rD7hcK1KaLdn?=
 =?us-ascii?Q?O23lC1o7Rw9SGXytkuK4TEV71yet3KwZijKMV7xWoWMFPvK+sqipumHBZd2i?=
 =?us-ascii?Q?qPrtYuuxXFCztK66HtT/TQ0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f4df1-1449-493b-9619-08dcc790a06b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 18:38:36.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv2LestNhCiFjBXe/YmionzXW5rwA7D/O/HEvEF+P+b3fre5GqO8axeqJ/RHwC1LGyl+X44lA+xhtIIuAaGaejeoWWknlICCtjkLTiWlv9TvtT2ubtf21DLECebQFnTV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7464

Dan Williams <dan.j.williams@intel.com> writes:

> D Scott Phillips wrote:
>> On arm64 prior to commit 32697ff38287 ("arm64: vmemmap: Avoid base2 order
>> of struct page size to dimension region"), the amdgpu driver could trip
>> over the warning of:
>> 
>> `WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`
>> 
>> in vmemmap_populate()[1]. After that commit, it becomes a translation fault
>> and panic[2].
>> 
>> The cause is that the amdgpu driver allocates some unused space from
>> iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
>> devm_memremap_pages() it. An address above those backed by the arm64
>> vmemmap is picked.
>> 
>> Limit request_free_mem_region() so that only addresses within the
>> arch_get_mappable_range() can be chosen as device private addresses.
>
> It seems odd that devm_request_free_mem_region() needs to be careful
> about this restriction. The caller passes in the resource tree that is
> the bounds of valid address ranges. This change assumes that the caller
> wants to be restricted to vmemmap capable address ranges beyond the
> restrictions it already requested in the passed in @base argument. That
> restriction may be true with respect to request_mem_region(), but not
> necessarily other users of get_free_mem_region() like
> alloc_free_mem_region().
>
> So, 2 questions / change request options:
>
> 1/ Preferred: Is there a possibility for the AMD driver to trim the
> resource it is passing to be bound by arch_get_mappable_range()? For CXL
> this is achieved by inserting CXL aperture windows into the resource
> tree.
>
> In the future what happens in the MEMORY_DEVICE_PUBLIC case when the
> memory address is picked by a hardware aperture on the device? It occurs
> to me if that aperture is communicated to the device via some platform
> mechanism (to honor arch_get_mappable_range() restrictions), then maybe
> the same should be done here.
>
> I have always cringed at the request_free_mem_region() implementation
> playing fast and loose with the platform memory map. Maybe this episode
> is a sign that these constraints need more formal handling in the
> resource tree.
>
> I.e. IORES_DESC_DEVICE_PRIVATE_MEMORY becomes a platform communicated
> aperture rather than hoping that unused portions of iomem_resource can
> be repurposed like this.

Hi Dan, sorry for my incredibly delayed response, I lost your message to
a filter on my end :(

I'm happy to work toward your preferred approach here, though I'm not
sure I know how to achieve it. I think I understand how cxl is keeping
device_private_memory out, but I don't think I understand the resource
system well enough to see how amdgpu can make a properly trimmed
resource for request_free_mem_region. My novice attempt would be
something like:

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8ee3d07ffbdfa..d84de6d66ac45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1038,7 +1039,14 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
                pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
                pgmap->type = MEMORY_DEVICE_COHERENT;
        } else {
-               res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
+               struct range mappable;
+               struct resource root;
+
+               mappable = arch_get_mappable_range();
+               root.start = mappable.start;
+               root.end = mappable.end;
+               root.child = iomem_resource.child;
+               res = devm_request_free_mem_region(adev->dev, &root, size);
                if (IS_ERR(res))
                        return PTR_ERR(res);
                pgmap->range.start = res->start;

Apart from this being wrong with respect to resource_lock, is that sort
of the idea? or am I missing the sensible way to hoist the vmemmap range
into iomem_resource? or maybe I'm just totally off in the weeds.

