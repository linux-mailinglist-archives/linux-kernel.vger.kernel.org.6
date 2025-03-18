Return-Path: <linux-kernel+bounces-565718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD7A66E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B25A3AA1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46311F09BA;
	Tue, 18 Mar 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NxLVKuos"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2044.outbound.protection.outlook.com [40.107.255.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6E146D6A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286029; cv=fail; b=Tp8pmpcQL/hAjEEkja+mHG7v0WFSXZQh7+N0yhfRWs9CFbuyoUtQdQljxjSVYX/MxWecpGJjzKKiV/2brE+zTLp2geaheGqjMi9wbec9mt5en7KbrIssQRuquRlLuSswm6rPh5LjPGIUDhPj4X/Tm2A7SpHVUToOZZ/4oBS4eNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286029; c=relaxed/simple;
	bh=e95BwG7zwu62C4UGvE+zfHkotjiwX6uQucKsrBDa/Gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V8DLR9x4MPLfd3TZyGDa2bu4S/8mwl7YKohGm0rjSSenGW+vVFPmlO1MbwDSJ8eJPP4IIPy2gOFMvDwr5tTRKItc0kLj74qDbQNEqXW0FIL6KpM0C5ppXF+6hPeoAmGYtTbIgvFtcco/1qHdzj3q/WpCl0gVo212vc14glS8m08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NxLVKuos; arc=fail smtp.client-ip=40.107.255.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxbn0DkUbljf9Ohmv0m962ALAMd24MZPLeuLhBvHsQvlAZuxeOoePA1SYg7vLuC6s6O7yHHHu1TLt4ezzvDGzq2JPFdqaFjIOKEuSp6z3lDYQsf1U2aqX4r71BPv6qWKXYxB2RbAR1atiNVldArnZKLO3ylGoj4fsfzSQMdUcEKWP3q3gHQPXghLQwhs+mBsjUhLuZsqRXn8QFlbdltNOyIE19gsByzHnoTU21rjpF+pwQVoq6oLLIiKmwfW3+MYGTbg9lIppe+UTdstut48SJYRmKChuBqac42NwI5SJyLJjyt/o2uWIi40B1pGhh5gQqI3gzCDjKl0WfADsh+j1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CxUct535sMz6R136jm1X2XiqvLfw5lCmu3KbF2nz6k=;
 b=hTNn5zkHsPAD+5NEZHOQUoSeluVeIl4l9u7ARsoF3CxDOqIBTYMrmWfDgk2Pprp4dN+0FESb5DImdlQvAU0ie+ve52jblrUQ0O2lmFUyYS4U8st0N2gRy33/S1Z7QYFJgxBbl5+0myz2Incivje6PRLXo3utUZlVwABVOkGm+ftIxa6sWGAJg5OBVxNEhV+9wDIfz75hXuHRGmM+NI/dHyZQmDJE/2WMnLIhdMRzUvxflw1TEhrufopNOkhqEbTQL1lDUG+ks5SeG5tCE84tF432kIFZgfNnjqJAzZ1cw4ZL5cfaIks6kKBhoG7tcngs4MAQZ9Qk1VMvIkmn7+3F+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CxUct535sMz6R136jm1X2XiqvLfw5lCmu3KbF2nz6k=;
 b=NxLVKuos3dySxJuJ3EPAdaq6CwlwdEqt/oKI24Gr9ncXPBfC1+8lntJbMBSdLw5Eg7+f10+TdZKGIduxTA9AhyWqwqaqkRUxBFfm9LQRarvu0PdumCw8eM6+p1aLAa4DX4knkxP9iBv1+VURBD1nIwFCyaxbZPXxX7lYsw/E/Fc9hsOll/8uiuR6hIrUX5/Uy2hbbQB/NPyFnyR/0pWiqRFjeOvBV3o3tpV0mRQ3hNINkCAiVb09hFxmD3hSB7P/niLR8ONJe2IWZuRjmVU/1YRg3SWypXYYb9j0sazo/LpiEKMzaPXxBOBu71yNuwMR389RwgKA/0oV3PR6CkrPlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPFB7AB72C83.apcprd06.prod.outlook.com (2603:1096:308::260) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 08:20:24 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:20:23 +0000
Message-ID: <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
Date: Tue, 18 Mar 2025 16:20:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com,
 vivek.kasireddy@intel.com
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250318064805.GA16121@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PS1PPFB7AB72C83:EE_
X-MS-Office365-Filtering-Correlation-Id: b45c0889-0925-4eec-2607-08dd65f5baf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEo0TERmZDZtNXRPUE9hRXlFWHQ4VVlCc215eFBSNDRmeXl4Vmh6dGdCY0V2?=
 =?utf-8?B?OHlQcEFPR2ZIVldPbVkzY0o3aDJXZ2crdnpsSjhBWkdpdFBFdEpHOWV5UkNx?=
 =?utf-8?B?aVVSVkZpcms4cEl1SGxDQm1YT2tZYmthbG5aQ3p0c1dRNWpUWG9qVXo2OElt?=
 =?utf-8?B?bjBaZzdVOFhVMmJaNDd1S2RtakgzT0k2TFNJa1RnUnJ1K1NDa0VIRGFvMmdz?=
 =?utf-8?B?bklsVm5kRWdPb0ZXQjBVbm40R2xFR0tPZjBRaVBZaGg2d0pRMDhBQ2NsODlI?=
 =?utf-8?B?TWFneW1lVWZDK2VYUUE1OUZVdHMySWNPYWs2TzdOOXM4M1VzRllOTnUrbnRP?=
 =?utf-8?B?WWFyQU9pTTFMMXNTSlJTWUgxQkVySnc1TnoxOWpwTTloWWdLRE42eWYyaFBC?=
 =?utf-8?B?QWJNdFQ3N2NSNW5DZnE0eHZuVnhwRy9IY1dlODc2bHAzekZNMHhyd2dlY2hs?=
 =?utf-8?B?RVNyNm4wd2kwWkZuS1lmK3hCUFQwL1pIUGZicng0YVlaOWQ1Q1RubFAxUVdP?=
 =?utf-8?B?a1hWeFJSek43Z25qb0VlejdiOXRKOE9XYS9jREtVUEkwTU92RXN2dW00RjN6?=
 =?utf-8?B?dTN1eWhuZCthRkdYTTB3cFRyRXZGOGF0MmpqaTlEUWppTkJqTTlEdTlkdGRT?=
 =?utf-8?B?ZllEalpVMkJIYkxIVGZMSHBpd1NjQUJvWHBpUzJpbzVXaThPd3VLbGNCUTBO?=
 =?utf-8?B?UEhCelhPd0lyWDZiaVlpRUxjdUMxUm5pdVBuT1ZwQWE2Nlp2ajdidHdzMkM0?=
 =?utf-8?B?b0NvK1dPU1BCYnJadU93NG5Ic0NDcnVuNmxRWjd0dTBQV2dzaE05T2tuMXR6?=
 =?utf-8?B?cmVzbVdiaW0xcis2WHo4ZUlzajFYcElHTTQ5SWg0MWFTNDltUkU3YUpaTDJk?=
 =?utf-8?B?dDJ6YjQzdG9rRnduWk9QRDBkSEZiZmRYcWpEbjFOY0FxeFp3MXdYZGRhS0dl?=
 =?utf-8?B?KzVlSE5mdTRjQ0tPVnlrZ3Vua1N5d0hqZWhVekxVNno4eTZrSFFGSUZWOVRO?=
 =?utf-8?B?K2EzMldpaXZlc1dFSGVzTE5rNWZZdEN1b1p0YVRHK0FXL3FYanBKbGlkVWNm?=
 =?utf-8?B?Wm5HSVJlbm9hcFNqK1Vxc1Vwd3h6SmYwOGpxU24rU3RlS255ZjlpZFNvVktt?=
 =?utf-8?B?K1UxM3hUZEZoM1drRnJsT1lXTGlHcklYbGcrSGx2OWJNVFhrS0VGcVFoOHYx?=
 =?utf-8?B?QjVJdVpMQ1UwQXJaVE9zalBkeW1YT0pHaGRLYWFnVW9ySU5UNmRYTGZnYXFV?=
 =?utf-8?B?NnFpanR6anV3WFJDZUh1OHRLQjFjTHQ1bGUxajYwcXVCNXZOdHp4V0JkSC9J?=
 =?utf-8?B?NkRibVNQMDhSd21yMytGUnZ6MVkxWklZK0ovNUxOQmlwL1RtT0thRFl0SmZp?=
 =?utf-8?B?aURkMTY0eHo5Nnhta3loQXFKajh4ZDFlOWxFWTBjQTV3WVNHcmJNNFc0d0la?=
 =?utf-8?B?aTBNRFd5R1NLeU1oNVhGdUpWUlJ4d0JMVmFVQ0VmNEQ0UExwMDNzYzV1M0hq?=
 =?utf-8?B?b0tpU3BhVGdlbk1GejRPcEg1ZGNCeXpsdElrM2Q4TEkzTkVOWlJEbStYSWVv?=
 =?utf-8?B?QlBzQzk2bm9GWHpyVVVTSDF0eE1FYXA3bGUyd1FzY0J4V0cwbHdMQXIvdmlk?=
 =?utf-8?B?MkVaT3hhYXNwN3ErLzk3b0hUU2JvRVlDRTh5K2JRTzc0cUI3NzFOUVpnVVdw?=
 =?utf-8?B?TmpiSEhHQUJRV0YwbW1BVVRRQ2FqcHdkL3FXZTdtWHF2bHNneUt2dUJHcEpZ?=
 =?utf-8?B?dHF0SWt1dVE0dFV5YVgyMXV4VW1oZDhPbXJWZVVZaU8vdUlCSDN3elk3SUVp?=
 =?utf-8?B?NUtrK2dSMkZTRWU5KzFrbjVuSXVqNmYxR20yRUZyQzBnVmFVRGY1NGNnUzlp?=
 =?utf-8?B?eFpmQVBtbDNjTUcvMmRBeW5KbVRRa09mTFVIZ0Y2Y0M5bTBsUHp3QUJMeHZ0?=
 =?utf-8?Q?Tu797SGYMvozVFmowwTfgf5zYJmaWLmM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTJnczNkbFlZV0ptOFdOK0FnTE8rZytCUGROZEs1WnV0cHRROVZrd2JkenRq?=
 =?utf-8?B?NEt0UXE2VEEvNWRtSDBpRzV5ZWQyK2ZWRUcrSXU4NjFITVpBTW8vbkxwcTFI?=
 =?utf-8?B?QTNJNnFUQlpoVldUS1hPRWFVSjl6Rm1JTU1vZW5zWjQ2SGhYbnhsdzU4eGFm?=
 =?utf-8?B?WFpVYThEVzBQL2dJWUpNalZMYWVrb3AxS1Bmb05mUGtadGdiZ2ozNzcza1ps?=
 =?utf-8?B?ZDQ5bllkR2ZaemVnVU5FbWg0WVYrbHlhL2JaQlZZTGZhTTU4N3F6Q3BwbXZw?=
 =?utf-8?B?d3ZMWVhTbnQzWThKVzQweUdPYTQyMDdqMTEvNzVzM3NBSEw5aDhReGloTWEz?=
 =?utf-8?B?WlhtdzNRTmRhaTN0SVNlYnc0MGhtVVBXR2ZPOHZLZ1Y1SlJ1aUluWkMzdDVm?=
 =?utf-8?B?SFpwb3R3NmZzS2M3ZHRXYlFadm13Q3h1S2Q0ZW0zTnZXejdZcWI1YWlFclU2?=
 =?utf-8?B?WTdNNDlHYVQ1TElCVjBQT21JMTJxRHJZdHdUZGt1bk5QOUNRbHdBZlVIZTZj?=
 =?utf-8?B?ZlZlbUhBcStrditUOE1ENzMvZWhURnhCTVNZeE9EN1hRZ3pjaWdWcGZ3QUc3?=
 =?utf-8?B?WU9ENUoxTHNHYkVGSUtwd2VoL0NOOStOd2tuVHlQTDNZOU12MzNpeTA3anRv?=
 =?utf-8?B?R2ZBSlJFaWJIMjlwVlJqanNlSWVPSVFCUDRNL2o5elZzMEpKanlhWVZTRlBm?=
 =?utf-8?B?VTVNS3FJZ0M5VitUT1hxam5ETVhuclI3YlZDaXpCT0dSdEViTURKeWhteDJT?=
 =?utf-8?B?bExkVlFLSFZWUWpsMFFkQTNaODdiUVZTczMrVGJZNzF0elh6cTdqaW5XR29W?=
 =?utf-8?B?VWowME5keXRpd3p4bDl1ZjBkMDhMZUV5QXM0Ly9FUEJ1RklWTVNlUEFlVXdx?=
 =?utf-8?B?bXVPc0tIQlFteEhYWUR0aWh6VGRxWlZmWDJkNFkvajQzVmw5VUUzODBhbHBw?=
 =?utf-8?B?ZzRlYkFhVTh1RGJxejVEbmN2UndnZ1NLY1gvTkJTUnhWSDNBUTZKWk05Viti?=
 =?utf-8?B?TWgwb1Y3NEV5QUk0THlmc0NZendudy9UYU8xbmF2Q1dLZE9HMUtOa2RZTFUr?=
 =?utf-8?B?d1BvYnQrN2luSkU5VzRiNjRVYjBGQm43T1owMGxzd0NKR25rUG9rZ2ZpdWkz?=
 =?utf-8?B?UG5ReHpKUFAwaFR5b2Mrb3ZCZ1ZGSE50Z0JRSW55bTdZQjhTZGhhTDdEQ0Jt?=
 =?utf-8?B?UUwvbWhYTC9ZR0FiVW5teDlzWGlKWjVicW5uLzc2Y3NkMFE4cTNNS3M2c1c5?=
 =?utf-8?B?MDcwMlNOY0RWQUhObWwzcWwrdmJHcjlWcVd4dzMwK1ltdDExOVUweFlnZ0Nk?=
 =?utf-8?B?eDlPYWFhR1dTT3JodTh1czZKRjlabzA3bmkvMjU2b3RVSy9ZWXV5RE9sZElG?=
 =?utf-8?B?eVI3UkVSMktXMWpSQ0hFWlFCYTBtcEE5elBHQ0FxVHg0aUFhZlI0Ukh0QUxY?=
 =?utf-8?B?ZlNSSFluZWZQOEN5UytuK2QrU0wrT2FXcmt5RzRDaHdzRkFvMTVES1Rydyt1?=
 =?utf-8?B?SklzWWkwZFh6YTNROHRLeU5jclVTZ3VzU1d3YkluWjBtNW1pYTlKa2lxK29m?=
 =?utf-8?B?NTJaM291UDZJTWhIcytwQ0pZeGs2eEwyeGljalZsazRMbWJnQWZSVVJJSVZp?=
 =?utf-8?B?Y0Q4N1c5RkdKcWliUXFsRHF3UjB1bFJTcHlFWnE1anRjd29lUWZMQnlhTVor?=
 =?utf-8?B?eW5TVnFURno4M2pHSmpmNlNqcmQvS3hRWmVGQ2wxN0NiZndlOFFPTGsyRVI0?=
 =?utf-8?B?YWI1UDJnVmdlMUNuVFVoMDJkaURuU0ZxU0Mwa25iK1JqRk1UK3ZWZGk5QlBO?=
 =?utf-8?B?eFVDTVYyTVJBaUVMTmlXYmt6NFRGdHlvMW82bEY3c2F6ZzMrSWNqTWRVQnRi?=
 =?utf-8?B?NklQOUlHeE12WW1DbEpXWDVVZzBRQVhJbEh2dEJoS01sMHhqZnowQktTNXlq?=
 =?utf-8?B?Z2IrM3l4ZS8yRGFlbWh4R0dGR2p5OGhabG5Ua1hUN3p5WHBYUzRpNEFOZE5k?=
 =?utf-8?B?SVIzZEI2c0pFSnVjY0dNSmo0TlErL3g3UzBPSDNUK0ZoNDZKQzhaWHNBSEQv?=
 =?utf-8?B?cmpSSzJEWFJ1cE1PKzc4SVdqMUNWcVYrTDdqaHEwa0g3TXRXdk5oNnFlTmJv?=
 =?utf-8?Q?G2PTRT3TX+Q5XZQFkg/Fr3CXF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45c0889-0925-4eec-2607-08dd65f5baf9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:20:23.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW2fUrHUuMUE/H8bNQDysTiUwwnhSrDYBMwShS6NBP1DsGerhsqwUag6fqUIxRY7l7XGaDTEywIsG4OMMQw+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFB7AB72C83

HI Christoph

在 2025/3/18 14:48, Christoph Hellwig 写道:
> So you want a folio based version of vmap.  Please work on that instead

The folio-based vmap implementation you mentioned may indeed be necessary, but it has limited

direct relevance to the specific issue I'm currently addressing.

> of doing crazy hacks using vmap_pfns which is just for memory not

I mentioned that if we use HVO-based hugetlb, we cannot access the page structures corresponding to

the physical memory that needs to be mapped.

This prevents us from properly invoking vmap, which is why we have turned to using vmap_pfn instead.

Even if a folio-based vmap is implemented, it still cannot handle mapping multiple folio ranges of physical

memory to vmalloc regions. A range of folio is important, it maybe an offset in memfd, no need entire folio.

So, I still consider vmap_pfn to be the optimal solution for this specific scenario. :)

> historically backed by pages and now folios.

So by HVO, it also not backed by pages, only contains folio head, each tail pfn's page struct go away.

Do I misunderstood this part? Please correct me.

Thank you

Huan Yang



