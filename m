Return-Path: <linux-kernel+bounces-283025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43B94EC21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840EA2820EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E67177981;
	Mon, 12 Aug 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bal3hl0O"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33814EC53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463578; cv=fail; b=laqj8RtVeudj+c16U4/F1NJkAtQhvJfHSRTaZ95YdGcFw2szQiJ/0GzTKK2h4IOYFap7igNufMCnz8pfTdyLTFY9msT29/iC1G6hzdNAz6uO7Y0X3IZOH0UFh+jxMP8Sc06Ud8c6eqSoaUSP+HReeO7EZqmLd+Iso67VpjhFsQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463578; c=relaxed/simple;
	bh=8YpTg5mrSVTCUE2q91SAltlOWA0tmgj25vSNOMI+EP8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=O50CX2CPtqKnTpAsEMIqqaLbTbGrNkjHPSo5nxPGiu1+7eXXLQxeVQYriUkG/Vp7G5LyRYTB9UPC4jKIGpcV9eBgeppNYk+SKfBQ/9P2dGyVezeDPzD5HpB3XCuL6OFfqoS25kdb4jFl24dM7kzfm92HGw2gUmx9eaFOpy15zas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bal3hl0O; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8Yo4ZRDJIfmu/6wOPxVeNPyPlSTNJIJzOorucNl0N7BIp/v+IJLkbMeS1FyxUPWXWAHJHQ9rRQXq/uLABJxxlh7InxjL3aTEzfJFqHympCdpSjGd8yndfapL/AXAkpBI5pGG+7/llTJzF5qAgVMlHf2TKCGyNlChTtc+RW53kK2srQOfzUZW9+17zqdHdFzMDhip48YwPh26AxSq+1MIu/3Ut5fGemsenwY/lCzaX3sdJGFON2D9cg0A8wTziXu6j2a1AcUgZo3WPjIVJywgsXTcYxPew5jJJjF0gYbLLiGruOuMCMvbZSYHuFI9UCdzCkneZ6+2SI51MDny2SSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA9NMPWDN2BTp6YEKhlvXoicSxpJfDWn4tnSI7iFlvU=;
 b=bAhgR7XkB5BKVLQqzvexaReBK8IvtuLZpntu2MvMWYKEsPbfn1bW8yVEorg14RmTc6zwLsF+slBCiXSCyOnUpl4KTVrmfyrATR/Bz3saXCQqkZbGx1fv6kgj1yFQ5scfK6TyuYV6KOediz7P0/z5YoigWnPP29o+mZDB9Lh5tfEXnX6DnPlXxYj2ogSYOFyCyy5Oq8wbq+MZAAO31JwyB3D+VyvBVqnxU28hncR+gNkocYp3/IW2PeSFqQDJCyyrFoUjAK2bdiACMMFMb/GlPg5vKkzxt/lIPElO+F9rbgiDW1kfSHZluG18tiAYvfxEFIz+t0dEmjLqMA42ZkgQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA9NMPWDN2BTp6YEKhlvXoicSxpJfDWn4tnSI7iFlvU=;
 b=Bal3hl0OGuODlDYanhLdtdf5VLLOC6qmaiqM7rxaEFYNA9Vs6Xy4oOM+lOOlehBSakBxtOOD13zXKIC0gqKek+Fi/KIIM6BPNiD2Nvzr+mJ/mtLkZDYOMme+iEvwQg4Z+DsxPP4k+S/sQ4xNFrK+nE7Ns7XPXwN9OdH3f/lE0xmxO9OzR0IXH36pRVIpf1SqvDeSVhuJ0SKH7xgsuM1NaNvTFjavPt37vDC7o0lj0i+pYvso2E+LwwjU+MX1lyvpqO2gD0bSnKLZzReapqP01MVRGyxxAWM8i/+u9UrVv/nGEENWDIwANasnUxnDtN1XN3H0iRLmWuaqK9uxapY5hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 11:52:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:52:53 +0000
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
  Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date: Mon, 12 Aug 2024 21:46:40 +1000
In-reply-to: <87ikw6rrau.ffs@tglx>
Message-ID: <87frra3qlr.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0107.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: ce60db4a-19aa-4a22-a213-08dcbac54c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QI0KY3BI+2zkpVWM+k10zFC0qFlR9VAC4g3mIom9Fghi9E97k+VSyO3QfP/K?=
 =?us-ascii?Q?mUjTq44bquqAMVUISb6baV9GsiEUC3f6i1XCZ0Fiz8GxMHJZz16HLvjGH+ZX?=
 =?us-ascii?Q?GooA0V/tmoygkBrshAUarFl87KRDKHUF8Wb0PwXxNttLuXmH09mOpzr/FpAa?=
 =?us-ascii?Q?6+8jeJb5IoHXYOkODl5rKDb4Veq/7tWrPhYg4bmR47C/9/m8fQEaYVugqBAd?=
 =?us-ascii?Q?7Xb2byf9g7mQHj881j76aE7+wTLw33ognUJbDni0mqeYfR3YYrncttmLrg+b?=
 =?us-ascii?Q?jpAzWdbdxmQVpIg4p1Ua8i+MgEJ4C3cpLeHG0kq2Vd3h6J67YKb6RXvLGcu6?=
 =?us-ascii?Q?TeWcUCvQe2XpRBjBNwHUQg+ZOkLHd8uSn/5QRXfCdfi47IZrg+Jkuix+vRz1?=
 =?us-ascii?Q?0RX04AFsZ3ynNA+bgiuQJyCq3sT6BNeNsGtjnpeNC/HwDY8IlW7OXJbwCFkN?=
 =?us-ascii?Q?rX0xjAIu7DXKPzzlBI5GkR4oLMgreRlgEH65CuYDB9kfYR6/PzNNuwSdZxp1?=
 =?us-ascii?Q?VkqbjkcjPAH2GgvawIBOfQUjOos6RAlX7oqQAd0lZ2wwVywerBWHPj1ZX422?=
 =?us-ascii?Q?oxHsuzu7nztQFU4rY6UQMjEd2dTqiKYXw9Hx9plBPd69L7Vdg+oWVVuOeDp1?=
 =?us-ascii?Q?U1TEkV4EOvL6eqlPIn34SzZpedtG8O3qHzBwsNpgK9DKrLh9W9RqJnryWE2d?=
 =?us-ascii?Q?21oVpYDyVTrl8QHWXXzvEbFKMhjIh6RwP21FvNWUrDKqi2HWWtSM7jYHN7Ph?=
 =?us-ascii?Q?noLmFXOE+Krr+VNQY5jP4+0fu8eFz30m7sMGsQcT8FblbAswrWD31gWihIJg?=
 =?us-ascii?Q?6tNInC0NrryEW5qBHY+ZSTr8EXmBwPQbg/cxJQxZM4zedVXyJp/8LGNbuymp?=
 =?us-ascii?Q?3ngjegBjQ7GLlxqvKsq6xTfdNbRzN9fhDRFwoq/C7roHGXpAY1yCFVTMqOKl?=
 =?us-ascii?Q?7ex/0nik6bwDGqmv7LPR2gv5FmCLj+EbhXEAiuHe5odCcz02dapY+H79/yyk?=
 =?us-ascii?Q?9hwzjdeD4gR890GHGQqO4Tz8wnHvs3lMnk3m53Lo2s4TGQeNElgSfz5pUDRs?=
 =?us-ascii?Q?WjVz9de5D8kIK8dgFPHhKazWLbmQ+eYu9k1nUTeZE49ozR5MOt1h2H6noCpv?=
 =?us-ascii?Q?MidohzmsCaTZU55lJWvxwgJ2r3x8UE9XB83ovtUnMwWQbS8xFuW+U3+aSXf3?=
 =?us-ascii?Q?W7RR528/4yFy2eq1uCJJegDrSBvUSg4IVO9ihem5ARmerHGHrzbZL5/CwaFS?=
 =?us-ascii?Q?R/PgqMWpCStRyPuMxI3CqaMbYCzrQbWNunKSaKAXtROpkk42We6dZ8lQdy2O?=
 =?us-ascii?Q?q3Zl3UijdaA0cSwCSB6zkeOfIIBGWSwMHSjKVfJkSMyawQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0ZNmNQqaErl9RYeiXpAQUPlfd+fLXnD5+YFd6STrOzu6coa8ly9wi4saQFH?=
 =?us-ascii?Q?pMRuAxfcA7c78+RecYNz//P5BjGSl0Cq0ucLA6lprFyNe7nlFvm7xUBiPpbD?=
 =?us-ascii?Q?oBeBBzPS/Q+qZ/Er6dqualNqjuB8Kyp7a8oaz8bDs7VcFpqlOtYPFp4sBKlm?=
 =?us-ascii?Q?x+yjiUYyCQj38mueGRXekiRUaoyDlkqEyKR9vorpFaBa9LbKogQNcji8AkEy?=
 =?us-ascii?Q?KsSi+/dRF5Ykm+S5GpLWKOeTUGIzvn2dzW35vTZ9Q/CKuFIBnPaBO1GCDUJ0?=
 =?us-ascii?Q?GGV2VfNUUQrg94vhGv3R7QkDYcdA0NgjESlFk0U9RgCZpkNmWS33waNFFtIP?=
 =?us-ascii?Q?SgC40BLe/+6Sa+FeoX5SejIMcuc97QbDJkcBTpV5DH0gtuDxxJjvsphR17HI?=
 =?us-ascii?Q?XfHYWzzXHcGsoMhVbDOsMfYjFQmTkICwk7qsMBrQy4CPvTajC7QspBQPEl6k?=
 =?us-ascii?Q?VW+XhvgaSDCwXnd1blEtslRtCrmUEeTOkM3xg9I87mxfYU4AcJObrvj0f48t?=
 =?us-ascii?Q?bRwImkOsrAygUqsbVciQXCVmSoziaCidstLXOz4EvF9tMjPhxjHup7kzXqq9?=
 =?us-ascii?Q?Odo6mSCoCh6Bd28tDYEPOuBUcGmHpAsCPOStaWI+zCh7Qnc2fmYmG9OnPqm6?=
 =?us-ascii?Q?tA/nHCwhTXlMX3DH8LvDikx6C/i53rNEMdFiml3/SkiGPyHlU9V05zLWrXzj?=
 =?us-ascii?Q?+JzHdOUqS9PU70+E4XT9H2HXltxDXy1wt6s3Z55hI87NxsmBLuUxCgzM4Stw?=
 =?us-ascii?Q?rP4VCbcqLYPTij52opW23qkW2amhNYyCu6aCeFIxzbT7eBfI2iYiaweupPFQ?=
 =?us-ascii?Q?zdKh2UhSBr/Q1mywE+796HcKMNigw6czfZXj2E5OB0o0imEuruBQlc12LKVw?=
 =?us-ascii?Q?4aTz3z3riuWiFCeX7Ba+SWRA/w5sCVEWfJv+YTSrhtXI4W/K9fbnD0HEVfO3?=
 =?us-ascii?Q?h8sAt2Mkf7DPNIqiiliKRexFbLiaEU5hAL317zvnX7X3QOKtkaFQqrywEZTt?=
 =?us-ascii?Q?vZnvAceerURL2F5RPQM68AvQre0F7/3O8ITsTiapeL5DhfLzMMyV84g0vYaV?=
 =?us-ascii?Q?jkuY+DPbfoVlLjsYLbR9IepNo8ht/aZHv2S89vgCq7JQnupWKssBzygNMWGb?=
 =?us-ascii?Q?Zvv/bEznrGzcUFYFp1m9CKmZczLZI3Ky4AeSrmmOFazps/8twvfkoFHOjAkG?=
 =?us-ascii?Q?VlNmix4kGIJKiqDJJKiZ6uzM91V1pxiog4a2DF3wUdIKSR0pUPNL+TSPNN5t?=
 =?us-ascii?Q?GPe5JRydbJ/mEQkfnks5AavzXm9QMQsPBQdGK/1yCC6/tjl/GHx/yBZkByqW?=
 =?us-ascii?Q?F/QOvCGbeGovKP+papfrC+7hBGydJtFPpPWFdRAn1sNJlHFI8N/EujOqC4dv?=
 =?us-ascii?Q?YppiTFjXVfWAb+a2QEB/UhsJQGcU3AlNr7Hkm6CaCLrCHYxBmrsRD3WYCUtM?=
 =?us-ascii?Q?JGLRKvrd+/RIaBjJO2rAuv43lG35FcL3as9gGhqIMLgaDRIjKkCcAAaccVo5?=
 =?us-ascii?Q?VuJYDFhG+QB6Gvmgq7QV9dE/ma2QIsZyJ49Q2i+Xz2k9vPTRphAEB7XVqaJl?=
 =?us-ascii?Q?6X14lPULNLNzgfOjIGNlBXctIJmsEZrsjfYTS8GS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce60db4a-19aa-4a22-a213-08dcbac54c2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:52:53.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFZSNe6tTNbTe0g0Rv335F3dmrv25eJJGJtEpE4cjM2CMMBtTz87JnHjcnLD7Xps1KavbuKGNiqcLfauAPFXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297


Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Aug 12 2024 at 17:41, Alistair Popple wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> ---
>>> --- a/arch/x86/include/asm/pgtable_64_types.h
>>> +++ b/arch/x86/include/asm/pgtable_64_types.h
>>> @@ -187,6 +187,8 @@ extern unsigned int ptrs_per_p4d;
>>>  #define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
>>>  #endif /* CONFIG_KMSAN */
>>>  
>>> +#define DIRECT_MAP_END		(VMALLOC_START - 1)
>>
>> If I'm understanding the KASLR implementation correctly then this
>> doesn't seem quite right - the entropy means there is a hole from the
>> end of the direct map (ie. the range PAGE_OFFSET to
>> PAGE_OFFSET+kaslr_regions[0].size_tb) and VMALLOC_START which shouldn't
>> be used.
>>
>> In practice hotplugging memory into that range probably works, but it
>> seems like it would set us up for future bugs. It also means memory
>> hotplug could fail intermittently based on the per-boot entropy.
>>
>> For example with CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING set to 10T one
>> could imagine hotplugging 16T would mostly work except on some system
>> boots if KASLR happens to randomly place VMALLOC_START close to the end
>> of the direct map.
>>
>> Therefore to keep memory hotplug deterministic I think it would be
>> better to define DIRECT_MAP_END as a variable that KASLR sets/updates.
>
> Right. I forgot about the hole.
>
>> This does not look right to me - isn't DIRECT_MAP_END a virtual address
>> where as the resource ranges are physical addresses? Ie. I think this
>> should be:
>>
>> +		end = min_t(resource_size_t, base->end, __pa(DIRECT_MAP_END));
>>
>> The same applies to the rest of the DIRECT_MAP_END users here. Perhaps
>> it would be better to define this as DIRECT_MAP_SIZE and calculate this
>> based off PAGE_OFFSET instead?
>
> Duh, yes. I shouldn't try to write patches at 30C :)

It's a much more plesent 7C in the upside down half of the world atm :)

Anyway I will put together a proper patch to do the above.

