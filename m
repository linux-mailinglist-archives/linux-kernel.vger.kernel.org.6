Return-Path: <linux-kernel+bounces-309454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C66966AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6786B1C21EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E381BF33A;
	Fri, 30 Aug 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwikqHEn"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F71BCA0A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050880; cv=fail; b=VdujCb2lzmm4lkWG5XusGLzC+E2z8q3qC5FBHhEpzdo9Q0wA0atk5QrYJl3PCjR2FcFUOkBlX+yCqGToTi4hkVtS7J9J+dgPzTJ+th3srya2EEgAXlRsLs9M/BzgTkgw8BS1xN2hj/QqenTCI/cb1QBIGOD3e1Amlfb0sA8J6Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050880; c=relaxed/simple;
	bh=5fNRHYxPF+AckZ63I+kgBgzjepghWnIH05IAul1PEJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbilLPwpE0MBXxQCszzAE7/mj8zb/KI2y9EBv6uaOMFPJsk9liXGiYpFURw/u+UiNfwTvH3rgevXpAStpRkR5ehRq4Lw++392e5Fov2iakPeoSDEFya4EkxqBljlB0dllLvkVJYGBaJOYtVPN0UOFDpRclHrA4PABc/dSEvA1Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwikqHEn; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8whraroUG+LXIztLPsQ8cCHqCXGUjEytAURO+WjD6N8+ZJKtG88a0bMAcOtXKLIiKrIFxPd3wZDeiD43oqidaSwaqRgQgubUXCljTQHPjdZR28RsVUILucoIvROUdoMyCUy5TfCp6tn2/ONNna8IFrqG5yW84XzF12kjm7Zginf8J4wd/jJcJ4wAiCdg0VOoVBXlOcL1fGNTnOGTBqrB7/HAJKpZXwUOviGDfEwWyMoo5oC3zIh87FZbFXREs74Ul5q+XhwLqOdpifY9091jrlaLAzhk0nvBP7cujYBz1l2p0m02NxU6mYGX8+qn1PtbkNdJtOGa6C1RQdMU3YTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9TFSSSAq7HjpaL4d6wAeKl6JhIkIaVfPQK9Go4JyOY=;
 b=Y2PikJcboyaOV4XtzouVRD2CCD7NjXiYTfYp1O+3kxjkNcMvn8xyMoqXhOFom9TtUq50CwlmkXnmH8BzT0bcZWkn0exJsLbmJX4WWZxoCaNAtYSoHc4PWeh/vKl86DNbuHo4j2s2MHPal7MPqMUrSBNlpc/wXY5ty+G6MbRvsNTYBDTQSE2//lo1aiYtn/ySHGCtdX1xd0sd2ON2YxDYvrdnUWEGHR7J5s2ZaC5wj2YVpD9U8fLah8ZvpuTBMQMHFU6zZ8ie8YC2uswzflC0x5z3gdaCKGIOjBzBZLThmQ+11OPEjgp31qMVUusgucfGEBV4BC1vGZNkpXtcifQnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9TFSSSAq7HjpaL4d6wAeKl6JhIkIaVfPQK9Go4JyOY=;
 b=fwikqHEn33J7sgClC2vgDmczMDnW3+2qF+2yGSQvlSzBzwSKZkxFzQSyxtAn1vxs6gg/kceL9ZE0dbsrYiwdhv59jVYDjPADQYxqaKaO+hpkLx1BP4HGsNFdznkvOicRrScSXCFxhwhveTZM7nbEe9+9+u0wJODRy2OiNqa3exw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 20:47:53 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%6]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 20:47:53 +0000
Message-ID: <fe39a04d-2b3a-476f-9505-b874e3ad93b4@amd.com>
Date: Fri, 30 Aug 2024 15:47:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
 <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
 <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
 <e13df309-457a-41fa-9406-22476f9f4e72@amd.com>
 <gnxxp3bzk7cc5eidwvqvqb5hz2ojgjdadujpthweufxms2gjsc@ibcbkjst3pzf>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <gnxxp3bzk7cc5eidwvqvqb5hz2ojgjdadujpthweufxms2gjsc@ibcbkjst3pzf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::20) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ece7c9-1187-43fc-45b8-08dcc93504f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0o4S29KbVlSbFJIWTdTVTZmdmowcWlpdUE5RXJYZWFsR2kzSTYzdTFZajhM?=
 =?utf-8?B?QUJRSUhEa1N5SENkWDJHVUpMOWtPVXlSRlVtWERPcDNFd3lNc084ZkRGdU9V?=
 =?utf-8?B?Tm41TU5kdnRjRWtmY2Qya3dmR3pBbjA4aFcxdWxPMHBRdU9SeGhrcjBPbTVu?=
 =?utf-8?B?dnRlVkVOQlBMSEZ6eG1wZmVaa1Awak8xaU1xTEpuZGIxUXJrV0ltdm1KYXNq?=
 =?utf-8?B?Z1ZWKzJ5VjU1M3U1TFJMSmpnOHZkSlA3M1NPeC9QU2tKeTR1RkFrajdQWWk0?=
 =?utf-8?B?WkowM2lVeERQeExUNTdicUhEUlJVd3pndml6aXJiclF3UVArVzF4d085c0pT?=
 =?utf-8?B?bGU2dmpscHYrM3dNVi9OczU5akZacEhuTi9nVTZYblZwb3YwUDFPNUJuNTJh?=
 =?utf-8?B?NUVpVkVoeVY1N2NBRlA2NlNtMk5WcjhHbDhGbmhTRXFDSk5jeWNENDVPdTVk?=
 =?utf-8?B?a1pXTHZoTm5XQTNDYlZLRURwRVhCWW5aeXJObVY2djJQc0g3UEorWjlhU2Vk?=
 =?utf-8?B?VG9FZUp6RUJULzk5bFp2SEZEY3JjQVkrUnNkTEtIUjRuNzFGM20wcTRXUUVF?=
 =?utf-8?B?SDZmOFdBTnJPQWxuR3h3NkRYY1AxVmQ0T2o0NzJiZUdLS01lQVpvOFN0TEFp?=
 =?utf-8?B?Y0ZNYlJ2UnhiL1lSTndVUUo4YmV6Uk5ad1lvTU8xd0M4TmpvR2dLMWNxTlJV?=
 =?utf-8?B?SEdrUE0xTnUzd0s2b1p5ZThkOWg1YkNsOGZwemNKVk5hakV1MFZaQWF4ZVZR?=
 =?utf-8?B?ME9id2dOcE9NbnJkSDg0WS9uSnVHaGpLUmdLLzJDdThoaXdKeWprYW02Q29G?=
 =?utf-8?B?T212ejlUQkJtTlNSSnF1QitBZnl6SzJnbStnSmt2NXFQQjRmRWd2eWR6R0ZU?=
 =?utf-8?B?aEoyS1BVTkpJcXNpc2FvUDVCQ2FsRExCUytIVEdKZ3ltZlYrT0Rsb1lra0pk?=
 =?utf-8?B?TXB3VncxUUJlWTZXdnNCbitoUGNxZWVkbmZjRlJJUi9abzZXa3JCaUJBRjMz?=
 =?utf-8?B?YnZqNXBqVC9jNXNtNlBPeDUzaUhTTkROc3NEQ2F4dllxZlJnZEgyblF3dkla?=
 =?utf-8?B?bjlGT05qekpwMC9RQVdkbi9aVzFyS0crMDJES0Z1WldBaktaWXlQNFd3Z3dG?=
 =?utf-8?B?bGVoV0MxN2NtSnJrLy8rUWxGUGJvVzk4QUxBakZSZWQ3azd2cHRHSldxUFh5?=
 =?utf-8?B?cHhOSGJXMjlXbVZ2ajRQSzkvZXpqTmNROEpFOThsVlZCL3FFbk9MQUpsS21i?=
 =?utf-8?B?VlVSWUpCNDliSk8yRHJNbFZjVmtIclFxVGsyNnlUZGxoUno1STF1U0RTZTdj?=
 =?utf-8?B?c3QrZGQzVytmS2RjOUNkdmhtKzM2d0JGSDdBT0tQN20vaGt1WmpHODhPOW9D?=
 =?utf-8?B?WjZtZTNYSE9LOTJNZ3VyV3drbm80Rm12bS9BWUk4RkRLUFVaejJJQ0N0Znlx?=
 =?utf-8?B?UC9CODdkSzc3am4wQkZjRjZpQmZIK0RTaFFVbzVKTjBIRmJIOFJndUpiRU9Q?=
 =?utf-8?B?MkgxcmNVNzA0aFFTeE5PNUlzM1FCU1Z3OVVBTWZVQnNJdnBhblZDdzlqSE00?=
 =?utf-8?B?cmxtd2l2c0E2c2gvQzBTTXFBc3Mza3RPblFDT01ZSzhUZkQydzlrOGZlM3ly?=
 =?utf-8?B?b3Z6K0J2cnQ5VnhaUFVqeUM3UCtVRUNXRjRad2pVa2MvbnZZcmNYdmppWXZk?=
 =?utf-8?B?dGVSOXp4UXNQZnN4eWVzYXZ6bGdEWFdZc2MwWkdZZ242UnpsbzJhNlcvK0o2?=
 =?utf-8?B?UUxjWUlSVldpUjZaTS8ya05NcXlXUjkrVXFTSzJTQUcrbm1wamlCVy90b09F?=
 =?utf-8?B?ZXl0K21zUGN2V05YbUtsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWd3TVlmV0NYcmZFV2R1S1ZIaVN2TDRQZlV4blpCdWlGTkpaN1FPZEpqU3ND?=
 =?utf-8?B?ZEd6eEYvM0pidytiMFRmendWV3dYQnk4VGxIclVXZ0hOZGJHSmFVZC9xQWFF?=
 =?utf-8?B?ZnorSmZ0U0RsQzdVZ2FwS3RWZjlSQ2NvYkdIcWpSV2swcFp0SlZjVmlzcnJW?=
 =?utf-8?B?dmxxNDE2QjR0OVRoamtnR1BQTnQ2allBei9ZNVBoQVhCSENnNEtZdWVwSTZD?=
 =?utf-8?B?cDlXUElLQVg3ZEFzcm5wdDhVbnRKNlphaFJpdVhJRmxaQjdsYlJoWFFOYmFM?=
 =?utf-8?B?c3JFV1FpUWlFR092OFM5czN1a2Jvc2tFekZOb2ZXWStpdFBadjRGcEZZQysx?=
 =?utf-8?B?aGtnOWpqamhEZC9wRnpUZWV4ZjJPQ3F6ZmUvVU9LWFVrR3o1aFVEb2VvaXVQ?=
 =?utf-8?B?UXBUb3JOZDc1MjY1bHZsMGcyUjAwUGE4SUNSOVduRzJqd3RWM2UxZFV0cC9n?=
 =?utf-8?B?K0RHS05NK0RjMEdEaE9NUmNoQk1YNVpTZkdVWG4vUlA4dUVReXVFb3ZzTnk5?=
 =?utf-8?B?WnpCc1VvVGpJZ3RSWmdXWHhXMThNNjZtYlo1djljVUNDRE1QVmd4YXFOcWVQ?=
 =?utf-8?B?ajNjb2dsNUIwRGlidHJ4K2xDU2RvMExmUitHNEZDUEJKT1QzdmFrcGxicHRa?=
 =?utf-8?B?am4zWk5PRnh4OXlxeUF2MUVrd1gybHRKK3N1aVNSeHpaak0xWEIvSHhmRVM2?=
 =?utf-8?B?bWNuN2lqdGMyYXNIVU4xcEZGZG5nTGNCaDJiQmppMGoycnppZlZCRFQwOEZh?=
 =?utf-8?B?L3NOd3lIV2pMS0FiN0ZEN1FMeDg4S2dRamszV3piZmFIMlZVK2h5VHpsOUNQ?=
 =?utf-8?B?c29KcW5TS0ppU3RZeEFMMi94MHlaVDVlMGtPRFJrdjR6MXB3WVp6akt6a1R6?=
 =?utf-8?B?UWgwSnNFWiswMHpLRnJxb3Z0NGNtSDVzanhoRTJ1djVPTFpoM25GZWg5d2l3?=
 =?utf-8?B?UmpJeXpqaDE0MkplSVpyNGNINXZyckIzL1ZUMC80Y2xtM205SS82NngrYmt4?=
 =?utf-8?B?aVBncHZyVmdHRVg1Skc0ZGxPTXFPdlMrM3RvYXRnaUtBNkViOHE4UGhKZTdZ?=
 =?utf-8?B?Uk0vN2dXVXorbDZSSk0vcHBQc3NpZGMyVkVEN1JlVlJsKy9SR0lsaDFMcmdw?=
 =?utf-8?B?Rk1ublpJUlQ2aGVvYjQ2M2VON3dlY1dsRk1CcjVHdURsQ0JjMHdZRjB5ZzZS?=
 =?utf-8?B?ZVA4VllkMGxMN01SazRxbDJHZllZOXZhbTl4czRYY3V5b1VLeVZSbzlEVEZm?=
 =?utf-8?B?UDg1enEzV0hpYVloUTU1WmNEeXdoQlBXczM2ZnU1ck9VUUpVYldEWUxPbFZy?=
 =?utf-8?B?ZGswMVpyQ1lrb2pPQkZ6L0F0T1BJTFk3aEFsSjkwcWdBM2ZMVXFFaDhIQXN5?=
 =?utf-8?B?S251YXV2ZUMvQzBPNkZGZWhqYUVCOVVCMW9DT2l0czdWSEE4T3hBNk13NExL?=
 =?utf-8?B?VHRROWsveDNxU2ZML2hldlNBSVFHdG1hMzEwbUFMbjU1WCttQmtuTnpoMlhu?=
 =?utf-8?B?YWNaRkJTTngyTFdYREV2TFpVcERqUmo2NVQ4VjNnVUszWmZ6d0dvWldrOVZ0?=
 =?utf-8?B?WUFya2hJdmdWb3U5RC9wdUZiR2NRN0NoaCtGdDhlWUVhNmo4R1V4SjFNdzNP?=
 =?utf-8?B?VTl6N1hhZE4ySVhRVnZDVlNtWDVGbCs4VUg5d29GVm81QkRKRUI1cER4WFJx?=
 =?utf-8?B?WXF6R3hkZVdpUmtCRUN3TXRHQzVFK0svWFZzY2Z4V1h5SFg4QVpVd0M1SzB0?=
 =?utf-8?B?bmxBZzU5c2FzNHd6bHRraXU3Wkp4Y1BvVk5XUUw0Z1A4VUdjY25RbGVoN2di?=
 =?utf-8?B?dVV5S2Z6czh0emF3U0ovWWc1Q09qdEFWeHBXSjh5ZFJWNUthQzZQZkh2THB2?=
 =?utf-8?B?aUdqcy9rNnJIeHd6MmhWM25ZWFBsUG9lMkxPU2dEbGt2UER3UTRLaVBTb2l4?=
 =?utf-8?B?MEdsUWN1d1lEbENnR1NONkg5WStHbFRrYjY2VUhjQ09vdEdYc29wTDNma0lr?=
 =?utf-8?B?TDJFMmZmc1k1ak9EemUzM3p3NGhLUWRCUmlKVys2QU1KKzIwMXBKejJUYlQx?=
 =?utf-8?B?QTNxb3ZMRHNLUW03T0JEUktPalFTaFkxUi9lR1VhM3VLdWdqV01VZldRbUlC?=
 =?utf-8?Q?JYxTq5/NZsKaZlKjywck13bFX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ece7c9-1187-43fc-45b8-08dcc93504f0
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 20:47:53.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xd6ud/fRRdOsCEJKBeyYrwq7apEbrRKnW3Y/JXRnXcj5oaJDVn+5UTj3AVdT8AtTBRSlAVZJv3YuQTdghGxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673

Hello Kirill,

On 8/29/2024 7:53 AM, Kirill A. Shutemov wrote:
> On Wed, Aug 28, 2024 at 02:43:23PM -0500, Kalra, Ashish wrote:
>> Hello Kirill,
>>
>> On 8/28/2024 1:21 AM, Kirill A. Shutemov wrote:
>>>>>> memremap()
>>>>>>   arch_memremap_wb()
>>>>>>     ioremap_cache()
>>>>>>       __ioremap_caller(.encrytped = false)
>>>>>>
>>>>>> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
>>>>>> case. See the patch below.
>>>>>>
>>>>>> It seems to be working fine on TDX, but I am not sure about SEV.
>>>>>>
>>>>>> Tom, any comments?
>>>>> I haven't dug through the code that thoroughly, but I don't think making
>>>>> arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
>>>>> data, e.g. setup data, is unencrypted and needs to be mapped shared.
>>>>>
>>>>> Let me add @Ashish to the thread and have him investigate this since he
>>>>> has been working on the kexec support under SNP. Can someone provide the
>>>>> specific kernel options that need to be in place?
>>>> As Tom asked for, please provide the specific kernel options to test
>>>> with this configuration.
>>> It is not about testing a specific configuration. The question is if it
>>> safe for memremap() to map all WB memory as encrypted by default.
>>>
>>> Looks like it is safe for TDX, but I am not sure about SME/SEV.
>> For SEV it may make sense, but for SME we don't want memremap() to map
>> all WB memory as encrypted by default.
> Could you elaborate why?
>
> I mean if it is specific memory ranges that can be identified as such we
> could make exception for them.
Looks like that the exception is already made for some of these memory ranges with MEMREMAP_DEC flag set along with MEMREMAP_WB.
>>> Maybe we want a specific flag to make memremap() map WB memory as
>>> decrypted/shared. Make everything encrypted by default seems like a sane
>>> default.
>> What are MEMREMAP_ENC, MEMREMAP_DEC flags being used for currently ?
> Good question.
>
> I see zero use of MEMREMAP_ENC in the kernel. And MEMREMAP_DEC only used
> for setup data which I believe AMD thing.
>
> If it is the only memory that must be decrypted, I guess we can make it
> work with encrypted by default.

Yes, and this looks pretty much covered with:

arch_memremap_can_ram_remap(..)

-> if (CC_ATTR_HOST_MEM_REMAP)

--> memremap_is_setup_data()

---> memremap(.., MEMREMAP_WB | MEMREMAP_DEC);

It does look like that it can work with encrypted by default and any memory ranges which need special handling and need to be setup as decrypted can use MEMREMAP_WB | MEMREMAP_DEC flag.

Thanks, Ashish


