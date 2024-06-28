Return-Path: <linux-kernel+bounces-234562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72C91C80C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A9A1C20E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AB7D3EF;
	Fri, 28 Jun 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhcPrOFZ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73D7D3F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609786; cv=fail; b=j/QFUHIwy4C5aizfFavTzPir6unGRpuSCncvJLXFrCH3oGU49a94xJHP0JrsbJrBWj22e6ggEEnCDiISRtAX96V1wnesZ/73ixOEIOslKCV0hW2RiZKwxcI7LeaOqggHXGThe2BwJim0iuoa1aXeVUOmKByrxo782pJM11BDkhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609786; c=relaxed/simple;
	bh=8pFjiqeJhmBkOjjSObRLW44O0l+/dO+QJhJOmk4IQK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FoTaMSh57GRwpIKGJNp00Qdp8lb8IIdqS/Ah0UzjPvsvKGJd9nTQYJP1DNr9J6DQAZ2nS8/s5B/bG3LgGset2jWrdN4FaUY1KIC6b+pntYUVJ6kv+XNu5ZJeVqleTpZn0ubd8fp9h7Nogy1PVWeAM6hsEINqwx80WbXVICqZdY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhcPrOFZ; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGcUo+yRC9FfYmm5GUMEdRnuoFdOMHGXn5i0A6DXpl5gCsmJgLRh7avshKIU8TpzbWWFKlzdpGOBu8118v66Xn5pU4GRjEBVogxCpoEyrmqxQfcmwF6BNdgDVw3DPf6/zQF5BDGDKk4eiqoxh9EcSGVe44X3DJaLSLOOeXHTTCy4K3VSulEpd3RzH+Sgi/t0a4dtk2cYrP0GGjd3AiN00+29TNdj4hoiYm2p7QY+BUUgc3gmXjW6eiodgHJ/LJVIziVK44cOou4p8crA8XFwojBIiaFgDEFRAfIl/VOy5/OEwKZqXzYzT39/KrKt7yWUe5Rwlj7ijRsf3UaItOHT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pFjiqeJhmBkOjjSObRLW44O0l+/dO+QJhJOmk4IQK4=;
 b=WkvKU1rfC3JgFXMAuKOQhUiVJnUSqV8EDFnAEziSanS6VJtnuB81Ldm982U4FX2qz3klYLdFlfyGPq7Hphp1SLd3EgCIszQMt4Agfpxi2dw7Pr3ijn2Z7k5iY0/kFzDk+q4/aDjxHJuwWWnAH3KITJGAVgubgcdz7xSn3zoGcjApdqpJtzh1hC3cwQ/p7zjH+uUnPj6PnR0e8qQOc/9gITKuCLGF2Eo+eVmOukkJ58abQ1IP9cYTCDd8NoSD5QfrwyiWgznodLOdaGWks1TiaC5c06uj/yOaohNa0sxIfbO9kR3DIl7T81ggkEShnCHNkFhv2hc92BdRe9BqjjgUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pFjiqeJhmBkOjjSObRLW44O0l+/dO+QJhJOmk4IQK4=;
 b=vhcPrOFZu48gb/Wy53iilOGz6zrIRJisAWCY/WbfXy4brOSd/Z9moZCjy40wy+9meO372iyKYuXH0bzEMBNNSuEPHIjTvMLDG+Wxcy7qtlB1x9hXZqTGEtsRENhXYCEIngmbmoH54y0JbQA2V/AuuvuTvOrQNcUquaSeKEwIH7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 21:23:01 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 21:23:01 +0000
Message-ID: <d24f7bae-9581-4d1a-ae05-2fede38b5e1f@amd.com>
Date: Fri, 28 Jun 2024 16:22:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>
Cc: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>, "Rodel, Jorg"
 <jroedel@suse.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::19) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 82021988-cd1a-44f8-c786-08dc97b87d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L051ZGFlSVM1cGdIWjIyS1VIOTV4OG5XYW80V2RETlg5TEpBZDZONWFRWmUw?=
 =?utf-8?B?eVNmWVNLYlgxL2FWa0JMYy9SbVhQOXBCb3NwdlR3T1ZhYnNvSXZTb1NiWmYz?=
 =?utf-8?B?cVFiRWdQeDIzSnFkbXI3aTkyYUsxZ1RFeWxYR2tRYlByUy85clBPRmpyVHZC?=
 =?utf-8?B?M2hoaDFVSVp5ZkdTcXJJcXhVNGFXaGZGbDB4V21JTkIyU2t1SC9nQ1RMWk9z?=
 =?utf-8?B?dGxCWGp4bkxqM2VSMWcxUUsxdExqZGNFc1JRUVpZbXBmZyt3Mi9STTgrbWMw?=
 =?utf-8?B?RXpCRk0vVUpnMjU3UjhCbzV5M1VXeDVoOCtBd09nbktKQ3dMdFR1OC9HbSs5?=
 =?utf-8?B?ZzhQV2xETVdBcGFieGIxUUZBQzVmTEZSZDVvSnJSd2dhV0FEYmtjMnpra0tq?=
 =?utf-8?B?WmFHNFlRVjNYTFZBVzVMNmdvR0NQVmh4WmdKWVc5emlXc2NGMVlrVmZXTkdG?=
 =?utf-8?B?S3p6b1pQVEhPcTc2c1UzVUNIcG13ZlkxMnNUZlFQMmNMMm9UekhUUXM1K2VN?=
 =?utf-8?B?NUpRODVvYXlmL24wY0xRei85TERDOGxQSWpJM21XR0FWQjU1bzMzSXppQWRT?=
 =?utf-8?B?OXlBVHhwZTBmaFp1UlFjSTd1a1BKM2tSL0dWNDBQVFQ5QW9NaklMTURoUzNS?=
 =?utf-8?B?a092dDQ1aEZab3E4QlZ2VEk5ejJRS1RZb0FVdFhSYkJWeUJWdCtLYUgxaWt5?=
 =?utf-8?B?M3hVM2FwTXh5aFdLellSb0E0ck5xTmFOOGZYQko2SHJwaVppOVBHd2ViTjRj?=
 =?utf-8?B?QktPbDRUSkhkeDBiRC9Vb2xhRVBucUY1U3oxRVJvd0dqYXorTTRsaTVseWYy?=
 =?utf-8?B?Qi9zcTlJa2VyU2dIdGRoUkZIRm1kSm5RZEJLakNwdWo4TysvMkczQzVObTJx?=
 =?utf-8?B?WmhFcjVRSlQvQ21MSGp1NGlMY2l6eEd0di9VS0VMT2tneSt0VGlVRm9RK0lQ?=
 =?utf-8?B?Y0NKYzlBSHYwZUJORnZOTytuSnZ1OVh1M0VlT2owaGl3MGptV2V0amtJci96?=
 =?utf-8?B?S254R0M3NGpJeHVxQ2cydG5pUHI5dlNiNDhNT1RXTkJhdHo3U0VHNHRjYW9s?=
 =?utf-8?B?dStJdVpZZ1NJTVh0a0V2RURVODlqUEJXWU1uWHEwcHhsZXJiTWZHMWVXWE9X?=
 =?utf-8?B?aFljc1FJSlZ2cU9GTmxKMStjQ1BvaXg2YXhwSVNxQzhYRm83SFIwc3RFMUxy?=
 =?utf-8?B?dFlKdFRIS3VhUFVXMHlCeGp3WWlkTmoxTS9XTk5uRDU2eURZdFNNTEZWZUgr?=
 =?utf-8?B?bEJvK2tHK2Vjenp1TTRMYXhOUVhKVVRuWndFdXNYeDZRblhxVTNLRGhKN1h2?=
 =?utf-8?B?WjlCT1VUdFU4MUVvamZHQmhOdW9kTXljUXNHYW54cDNXWnlOOEJEbTUxaUdn?=
 =?utf-8?B?dHFoL1JEYkhLWVE1MXB0WWxsVDRMRnRPT0paaXVVdnhrYlRMNEIxUkJzL0Fv?=
 =?utf-8?B?cXJxZGgzcndIeWFORmRXa1JqOVl1VkVpeCtNWDl2b0Yyb0FkN0dhdnJtd0x4?=
 =?utf-8?B?TXJDdVFyL2JOVS85Z1hFdXJFOHdHQnpTNkxudDMwNTBNUzFibm1ScGhHZldu?=
 =?utf-8?B?WnpnWHAwelVJNVlNZjdRaDFEOVh5aEhaL3ExdmxPa0hhanUyUGJPeUIwSWhy?=
 =?utf-8?B?RkhFOFgwQkhreTFsY1hTYUNWYUFRbmpJRVBzL0dQQktpRHY1djZ0cDhmRnda?=
 =?utf-8?B?YUIyUVZqbGo0ZE0vaERkUGxVQ2dlb2NqWG9wNml4TzdBcnRia0NaNWw2NU5I?=
 =?utf-8?B?UWc5c0JuZGw1T2VmWmkrQ2VSM2hmM3lIR2xSbEdLaUppRURCMFJ0Q25wb0U3?=
 =?utf-8?B?NXRUZzVnOWx2Y0hwZE9DZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVVaUtFMWhNdjgwWVp3U1JkSWZwRm94WllXRmR6MjA4N014QkJnbWhGT3M2?=
 =?utf-8?B?MklJa3VmN2k5bGs0dXhWeERMd2tCZDFUYzdybk5TWFd1Qi82OW40U2ZxUHkz?=
 =?utf-8?B?SnEwZlVpWTVrZFVqUlVaSEJKRGx4Q0Z6NEdreVhmSU42d0oyMmpZYXMxVmlO?=
 =?utf-8?B?Y2M0bmd5MzhQNWxwOFhIRmsvU1FxR3ZKdVh4cG1TVm4xM24vSkVyajhOZmVy?=
 =?utf-8?B?S0tZU1BORUtPWCtPMzZnc0xmdWhrZEFnL3F0Z0ZVVkxRQWQ1bU8rRDYrRTZv?=
 =?utf-8?B?cE83T2NiRjFta28zNngyUDN1d3hJYUdLckIrMmdqVnRwR0tZK3ExenhOVEp2?=
 =?utf-8?B?bWxzbnRTREgyNzZZT3JGSW1SbGlCSUgyTHk4cUdBbTFhREhwN24zWWF4LzNq?=
 =?utf-8?B?ZFM5bGJnMXdrUHc3NnpyUHJvNlNUWXl6T2N5eDdrbUE0WXB5Rm91Mm5VZDlG?=
 =?utf-8?B?MnYxSnFMcExwWkY4ejBoVzd4V3lVOGVHRXZRTlZ1a2JwUGhsdmFia0pjVzJ4?=
 =?utf-8?B?aGlvdi92dExGTHhFeS9ONnZCcGZrajNGRXlQUFZ2a01ZRHhnelZvd0VoUVJ0?=
 =?utf-8?B?MkttNzVzc0h4Nkp3NjF0cWhBREFOaUZJaXA4cTVDWlU2eTg4ZDhxSWpubGNO?=
 =?utf-8?B?RWZ3QWJ3aXRKVlFNc1h4ZDdLWG5Fdk1EUkl6Z1NZWHFsNVNsNTBGL3VmN0Nx?=
 =?utf-8?B?N005K0JieHF4ZkRvY2NrTDRWdk95RVNRNmZ0OGh1U2RwamNEMTlNQ2VTOGFW?=
 =?utf-8?B?OUhQNW1QYXRXa01YUExaUUZiQVJCL2lnNExwRDJMbm1Pa3dldTZnazFWVlpT?=
 =?utf-8?B?QkdJL1JKUytCUUVDVG0ybTcxUzJWejdQYkJEWDhyeUpqTnZvOTZ3ckZOMUFU?=
 =?utf-8?B?cHUyeGxsWWVLTXhnb1ZJRWd6b09hbzkyV2lleUgvaGJIc1hzR2xSTUNKQXR5?=
 =?utf-8?B?UnlTYmlBWGQ3Sm5nSEhiZlRVTWhCcEg5ZmgvSkRDM3R6UjFJb2lZNmFKVDZL?=
 =?utf-8?B?RnNjUElhQWl0YlVhYy9aeDhPOFluc3YxL3l5amlaQm8rb3NEZFc2ZDVuYXEx?=
 =?utf-8?B?T0JJYTBlYTBqMjBoNmVEVDdvVmhyR0N1WWhUTGV2SGNaVmFDdGExZUhPUmdW?=
 =?utf-8?B?VkZVS0NxeFVTenlLNGE3amloTFJlWDJLSGliV1lyUmNZTjYveVJHaFdFUVhP?=
 =?utf-8?B?K3F4NTUwWnF1MnZwUVMvbk1ockZFU0hnRTVUZmN4V2hnaE04TFpwUDJiSnMw?=
 =?utf-8?B?ZnpTMEdjMzdVSEFpUTROU3RqODRabTdSbXlUKzlSbjVyanBnOVpyVndjZlJ1?=
 =?utf-8?B?aURFcWxRRHhNNmxaMThjbnFPT04zSkdzUkVJYzVWejhESi9URWFkUTI1RUt2?=
 =?utf-8?B?a3U5bVh4eWpQNmlPbTRQVWJTSU80aTNDbUNWdEtkeWVtbWg5dStta1BsMXJi?=
 =?utf-8?B?bm5XMHVhbVBDMjRCcURndFhZamJaNG1VT2FpSjNRdGphVklwVnhJem1YKzlu?=
 =?utf-8?B?Q3QxNzg3TnVqd2hhczdJYjZsS3RscGJpTHNoRkRsTTlsVlRnQytrdkhvMHJr?=
 =?utf-8?B?Z2NNdlNRVEUrRWpISmREZ2xLWVJUeUEzTlVOZHdPekE3ekRUQndWS3V5RTZY?=
 =?utf-8?B?T284bUd3VHlIZ1hYTlNSOVBUUWNxWVFGRWE2aXQzRlpoMktkWHZTNDROb2JT?=
 =?utf-8?B?RWgzOWdqUEN0dThOUEtOQ3BzbmxnMHhkNm1idmpNQ2l6REdVRlZyYU9ja0dp?=
 =?utf-8?B?SFZ4d0NMZFlZSVIwRHZkMEVTUVhsclAyNVRSdHFWOW9JMnlhOTRLNTlDeW9u?=
 =?utf-8?B?MUYrcFNzd1Y5VHJ2ekFtSGNVQ2hPMHgzNWZpdjFVQkY2My95QkhLOVFJUXZE?=
 =?utf-8?B?M2Z4K25HcFZIQjlRNlUxUTNYdm1vN2g1RmVqamRYdmJWVDJNajlUU0Q1VG13?=
 =?utf-8?B?ajBlWVRVZEFMU3RnbEF0K1VDV285d0YwNEd6VSs2VFZabUNQR1VWSFJFUHFV?=
 =?utf-8?B?RFpCckwvNE1DanpCOEtNdksydnRLeUVUV280OG0rTlY3bVBHWXQ2ZDRoa09I?=
 =?utf-8?B?UkM0dkpwdE8zQjVIckIyQzZablM1RWlUeHh4aDd6dHZyUTJNdDR4MEdZdEVW?=
 =?utf-8?Q?7rPQc7xozA0sQkRSK5EJUHW6R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82021988-cd1a-44f8-c786-08dc97b87d67
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:23:01.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lqT0N56jT5I5s1Qo4Lj2zGfRw/2kN8C+U2XuiXLa0IrOHmQ/2uS5Rm2YsFqsVF3SK+kuwz5/cvIlaCCKLaX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345


On 6/28/2024 3:58 PM, Edgecombe, Rick P wrote:
> On Fri, 2024-06-28 at 20:52 +0000, Ashish Kalra wrote:
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 443a97e515c0..be8b5bf3bc3f 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned
>> long address,
>>         p4d_t *p4d;
>>         pud_t *pud;
>>         pmd_t *pmd;
>> +       pte_t *pte;
>>  
>>         *level = PG_LEVEL_256T;
>>         *nx = false;
>> @@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned
>> long address,
>>         *nx |= pmd_flags(*pmd) & _PAGE_NX;
>>         *rw &= pmd_flags(*pmd) & _PAGE_RW;
>>  
>> -       return pte_offset_kernel(pmd, address);
>> +       pte = pte_offset_kernel(pmd, address);
>> +       if (pte_none(*pte))
>> +               return NULL;
>> +
>> +       return pte;
> The other levels check for pXX_none() before adjusting *level. Not sure what the
> effect would be, but I think it should be the same behavior for all.

If we are returning NULL, why should adjusting *level matter.

Thanks, Ashish


