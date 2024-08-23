Return-Path: <linux-kernel+bounces-299702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A995D8F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024CF1C2167E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F01C86F6;
	Fri, 23 Aug 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3rZdI0Pn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6890191F6B;
	Fri, 23 Aug 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450658; cv=fail; b=fE7SUhiKxwnn6X1yND9IgX1oyi3/J32CrG4jI3dr/QkXRelMnd8JbbtP3GK79bFjfReIHug/KGZCtrOeqKJIV3yO2kNAf4EaJ4MGr791+zfUyVqN+dWvY8wjsbRCrNxQbbQ0vw39UgQjrnErZJG8ivPCp8y7Z8jMz3Yz+56syyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450658; c=relaxed/simple;
	bh=Jqa8nLzAdw1jR4s/i40a1g0VIwNN4j4t+LTsp6aSccU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ4+IlVnej2ERn2ptaqYHONdMxQb1atnFDotgUwyaJ8urbnNiaErx7fFu7sVU5CNtLxqIGHmImlOQA8iTm+GUUzD/K0+AUtjkrKnm+X8JQqEr3wDtwuGU5aYv10Cj8gMC5bzCSbzAbbPoIAyUq3E9d/rkEU/Ias63fetnvpBoBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3rZdI0Pn; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S80YkQQv0eyfy2vOOyUQ/mjCb8aa10fcOUJLdxiSFnX6K+O6nbGGn54LZgn1zg51z1qePhVRNMGav28bH29Is52HwHY2kxdrNVp0C02n80tOincZ9ls/aEpYT097KEYEUynwdDThLLLGok8h7n/q+F/G+IPssKga7lXsegyXs2mB6alqcGoJXQzSQnhz47GII4D6qy67gC/xQ/OhRMOfsNkH4aGR4UCOk5EXoi0IWbee9WKoMgaEpCVTOrj1/xX2Cg4M7sZ9vwrD2jNBnflxL6vhbvvzNkuwgl44JTcZ4AFrR/4gQQQJGTbTXUhxdAkNhZGOfaTTUFyDmLGFnCFqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rgv7TV2haOcEZVYVnEdtDxM/igY9qhRLR2cQP86eCU=;
 b=kKJ+CatA6ql0xsECNxBTfUTL+lDGcOlhREO+VwKqoQzyYkdpAjLoM8W72/lXNZYMQbjBAhgo34wlz5+C/RABj1ZKuQDED2lx8Af+sxPm9Wyr9/VRZkgO8iWkJGcYAuHEdQhwsEpI3ROoU6PH4uyyHHJDTJW1OWt88SbkQws12GWa366LMj/s+3RZWsNlmXcWHUGeuiPMebvMue0kFpRwRvrLm2MtNaE2VeXr/DZdYm0egIyDnGSuzhR/hm4a6TEzfNvVnHiICUmoMfEXSES2lAx2tj2P2Ep85gPyKnTdUD0vnPLOCevO9aLKoSJoI3PZwqfH7SwFHSPphCJcsI/P0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rgv7TV2haOcEZVYVnEdtDxM/igY9qhRLR2cQP86eCU=;
 b=3rZdI0PnieyBNgxkPKfOT/ntN2qVCBBuB1OSQqJ1+KKA9mc0uPUx1SMCt9VW3ga2RxVwhB7Nk25zIQnvkgaFVMX7x4uaxTUgtaceE94q7Lnys/cwJzhuWstY3yPScePna6p7r5ca701ZYFXdog0nN5Tr6BdDD4gkrINKAb3ATU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 22:04:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 22:04:13 +0000
Message-ID: <41d7e325-c290-5bf5-5427-c3bf6e6e4f98@amd.com>
Date: Fri, 23 Aug 2024 17:04:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 22/22] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <30a946c5ec042e66db675e9e57fe2cff971f570e.1722981659.git.babu.moger@amd.com>
 <d4873add-ac24-47dd-be45-28af3698c334@intel.com>
 <d8259097-3ccb-4989-aa1e-6b5c564240f5@amd.com>
 <df257c05-ef8c-4e31-9ab8-0d396e1b40f7@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <df257c05-ef8c-4e31-9ab8-0d396e1b40f7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:610:e7::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a73a17-a99f-41e7-f3db-08dcc3bf85e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmpNVlpaUDYyWnlrQzFveVlWbENpTW5KNCt5UTJkSXdHaWVMekx1a0hrSm9C?=
 =?utf-8?B?Sk5MaVlVT21jMTlkZ2k2OEpEKzhlQThDTUV0R2lNMW9DUnA2WmliL09zVjJ3?=
 =?utf-8?B?NVZLaEROVm43cFFSeE9wZjdZdDBkU2NpbDgvTUtoZlZkMW5GbFJBTzVFYmZz?=
 =?utf-8?B?QTlsbzdqYlI1L3dlMTNKZ005a0V4WjJvZ1RnKzVQc3dLMjhIMXlTUDRpVzlu?=
 =?utf-8?B?LzBaVmpDbG5LY2s5d2FDRjNFUC9CeWo0YWZxaGdrOHgxV2YrSU8wNTcwalZK?=
 =?utf-8?B?VjF1YkUzMnRrNmVOUWRqellIYzEzQ09mZ2tVNjltc3F4MmtvSEt4MlpwcWVv?=
 =?utf-8?B?SGpvN0IzQ1JnVDY1SlE0Um5CNExLSC9BbmtSUG41eS9QMWs4YXgzSWRmVERP?=
 =?utf-8?B?ZnBYQ2FjQTRlbTRqakdPN3g3YVZhUG8wOU5SNkczYUp2NG44OEhVUGo2OFJp?=
 =?utf-8?B?ZGJ4OGR6V0w4VnBBMWp2YXlOaU13VmI4ZllrS0RrM3VHalZHcXBNSi9FbjZm?=
 =?utf-8?B?TmxENHNtZVQ3bUk1L3dJMitST0xGemlESzd6YndDamF4VGczZXdiTm96RFNM?=
 =?utf-8?B?ODVnVFloajVYeUZtc3FiVzA2NXU0S3NtdTNRRVpmbW83NDFuVWdHVWpQVjV1?=
 =?utf-8?B?WElpYnR0bzlQSEJnaERybUdvTEVsL0Y1elI0WFdPQ3h1L0VCV0xyYzVKRkV6?=
 =?utf-8?B?dlZpdHFoanBPbG0wSE5YQk52SFdPKzNxR0tCTUxDR3RkcFlTSjZPTXZsN3pT?=
 =?utf-8?B?VWo2QjlNeTFrZ21WUmM4QW1xdjZRTy9HVFZxRDQ3ZURLNlg3SjU4b1NmMVRU?=
 =?utf-8?B?L0JSclVkaWxhY0UrMFFpYnpiQzFUU3AvYUlOWUwxUGdkV2VIb1FseC9vY1Zu?=
 =?utf-8?B?TVlVTGpwYWdBNWRLUWVQeGliOTZVRm90ZmpKZ1pORU1YOUJLSG9OOFE5VzdC?=
 =?utf-8?B?K2tMRXJ6R253TWlBYUxRWngzaFRLRlgweitqbjBXN1V5QlArdTY3SDdxM2VZ?=
 =?utf-8?B?VXRJSEIxa0J1Q1FmWlZNSjh0SGhwZEl4WVFBcCtlM25rVGpiT2lqY0VBRkV0?=
 =?utf-8?B?djEzMWJHRkU5TkVVRWowbmVSeEpQa2NyR2hjTkpPNGd2ajJZZFRvVm9CWVEx?=
 =?utf-8?B?bEhRckw5czhkQzRUWXdwcWR5NTQ1ZlkxK2M2N3poaG1ldjYwejc1cllYQ1Bq?=
 =?utf-8?B?R3RqVmFRd1lLSXBHYUpMb3VsVkFMM3Iybk1ud2dyWW5ybi9GbjRxeXUwbHV5?=
 =?utf-8?B?ZjBFQjI5U05ucUV3UzJiN0ZaRlFETU81OUlJb1BlaXc2MTlNc3NaZ044NHlR?=
 =?utf-8?B?amE0NGw3YXFCOUpEOEhBNm1xcUdmeW9FOXRRb1RIOWRrUTNkS1JPY0FTUjVu?=
 =?utf-8?B?VHhhZXpGZGtDYzZ0dWJ0WHJJQ2E1S25hNExUVys0RUNVRG9ybVVzVVF1S0g3?=
 =?utf-8?B?Q3lYU3VUS0lPUC9RajNCbnZvN0YrM0E4MzBqOXlNOUprRTFEYm1MTnVVdzAr?=
 =?utf-8?B?RHZ4QitYSXVVYndvcjhrWFFoOTlEUEdGZUZOOWdTblhRczhUSDFaTTMzZVd2?=
 =?utf-8?B?MTlGVnhxZDloSEF6bllrOWVhV2p2dThWTzJXaU1mU1hHSHllT2RhZWtFcUNP?=
 =?utf-8?B?bkJDZXY5M1ZNc0lEWmhiNzJJczNkQjFCQVc2TzJJN1k0WCtFaXliNy9KZ05i?=
 =?utf-8?B?b0QvVkd6Qm9wR3RSK2Yra090QWprc2dhalpyQnFBVXh5YVgyQW1QNTYrTzlF?=
 =?utf-8?B?VE9qMWhRRzdab3djVGVZYUViU3djN1NJKzVWYS9wVms3MkpsNWhlWVdFYmdQ?=
 =?utf-8?B?MmxpMTJBSUN3R0U5MjdSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1ZzM1dzUEEvRmtKMFdDRmlNeWJhQmZ0QUEyS0NzVk9PL3lCZ1BmTFZ0MlNr?=
 =?utf-8?B?UGsrdndaUy9ndG91N3JoUEJHSnVOeW5WYnJ1K0tKSEJsTnRQM0Z4RldVZlJB?=
 =?utf-8?B?TWUzL3RyWVlGS0FvOHFRaGJHOEhySW1PV2tSUFdBV1lWSXZndG53UVBvTmd2?=
 =?utf-8?B?QlRKYzEvSmYvTVF2QU1rTmtVWmE3TVVhUWc2Z1ozRHNtcmNYUndTZjU5eDF6?=
 =?utf-8?B?dDN1dVRIWUNCZnFpQk9YTUxFdktaRnB5REJEaDlaYjQ0YmorUlh1bzhPLzhh?=
 =?utf-8?B?S3lVMVRvV3lKNVd0OERLMHU0eG5KdEJvckd0UmhzenE3THQ3bEdoeUx3ZEUr?=
 =?utf-8?B?MmdtL2RyZk9LNjFyUnBQc1B2Q2N0d1gwd1JGTmtLSjNMbFRhR0htR1NaWEk4?=
 =?utf-8?B?ODJzaEZ1T2lYTHRSaHEzQ3JwOTdudWVld2g0aWVxc24rVXRwK09mK3dXYnla?=
 =?utf-8?B?VlFIb3l2V1p0bUxhb0ZsYVcraTVkZFcrcjZIZnNUcGJMY3V6VVN3OXVkQlhW?=
 =?utf-8?B?Yk9qMmw1bk9yWFJzMG5VNmQ5Z01hdWhKMkNhTTdtMVVuRVUzeE83bWdwdVlj?=
 =?utf-8?B?UmZ4NXBuOHdNV1p5MGcrcDR4eEhSanpoVGc5UTlmSExSbWNuQ2Vmd3Vhcksz?=
 =?utf-8?B?eEl4M3RlTmVrN1FtR2hORWNreFZodVRNcjc2WHhSc3h4dGQ1cTA2dXdlVk5p?=
 =?utf-8?B?dkU1T1NocTFwVjd2OXNXRXdVODIyaTJnMGFyRUZwMExJYkRCdlpsL2RyUGN1?=
 =?utf-8?B?U3FZaEFrNGsrbEh2Z0s3UlpDYW5zYXdSYUF2WFVlRGJQL1RteEdFQzF4VDlN?=
 =?utf-8?B?VmJkYXB2aWs2SVpyWTF5SnF4U2YyWk1HMFZic3lCRjM4SUlSS0VLZmo4TGk1?=
 =?utf-8?B?dnVHSFdnckdDRUhsSGFaOTQrbGZqZW5jc3MvKzloR3F3czFtU3ErdFRWQ013?=
 =?utf-8?B?SWdNWUxzVTVJc0YwaTlqWUZVcFFLOHE4MHRSL3pyUDZWbTNEMXo4eWdDTGVE?=
 =?utf-8?B?eS9IdXJ5Q2Nld2F1Z2ZYUDczK0kvQnROL2NFdjBiOExFaWd6UU9KNHJScG5K?=
 =?utf-8?B?d2oyd1dTZWkyKzZSR3pvNCtERnFOTFpFUGMwZHlCYzA5TDJ2VzFvVGNUSWN4?=
 =?utf-8?B?WitpZi9IUmNDTFhiclM5bUlDbktDMHo3SlUvWlVPTkZSbzM2d0kwSGdQUTdC?=
 =?utf-8?B?OVdFSkdudjZJbXhNb0txS1hvTkVWczV2WEdoMFJCZndXOUNFV0FRZzN1TUR4?=
 =?utf-8?B?Z00xWWJHMlcrUTlyTDBvMU00WnUvR081aGNESWJpSmtIeFJqRlgvQnpvbzg1?=
 =?utf-8?B?bWxYbTVLTllUWGxXMlU4R1N3cm00SGRkSkdSVTJBZCtFZ0U0VC91a1o0QW9G?=
 =?utf-8?B?ZVlyRHRLSmkySUFVckw1Z0RuRnFZcDhENWs3Y0hJUlRJOFJkeG9wYUZkeHh4?=
 =?utf-8?B?d0MySjIrNzRxdExob2JZWWRsa1JxU1B5a1FjL3FWb0g2clphR3Q2WjZOdkc3?=
 =?utf-8?B?dVhKZ3JMajZpRVFuc0dhZnliZ2UwaU8zSFpSVTZkQzFyTTkwUFVCRlphRzMy?=
 =?utf-8?B?VzdPS2dzakl6MHBZT3VuZ2xJZjFoSTNCMEIrK1VjNSs2ODlSQ2RJNGFieUJl?=
 =?utf-8?B?OEd3SlBrS05zbEplRmZRMVdaT3hJdFprdnhhK2FmMEl5N3UxMjVHNldLMUFw?=
 =?utf-8?B?Wmk2cjBndkwzZEQxTVdLdUhFd2pHVTV1RnNDRzZTUHRta25qSGg1Qit3YUtD?=
 =?utf-8?B?bC9LL0k1UC9uV3kxbjk4SEY0U2wwN0FxYW5oZnNGU1ZBVCtlcGlSdXhQSHlO?=
 =?utf-8?B?SXN1eCs4TWJudnNPZVMzVS9lTzBqWG40Q1hnWGxUaGIydmVYdWZCcjNOeldG?=
 =?utf-8?B?cjlwc1JZeEVYRE9ieGdGK2ZsaWVkQXFoRGF4MURzSVQyV2Vad1Z6eFdHQjRo?=
 =?utf-8?B?azdKd2krVFo0cy9nWTl2cDZQeWpUT1pCN3RNNERrRU4wRjBlY2NLemtMV0lx?=
 =?utf-8?B?WUFIU3pLVytKNlk4SHZic1FWb3BwUmhiM09mSzc0ODlkN1JMNGhWcS9oTFdj?=
 =?utf-8?B?SHByS2hNM2pFNTQ1K1k5QVQrNXZNb0hFZWZ0UnpGVHA1eDl3RTVTSC8xb0Zp?=
 =?utf-8?Q?zeg9dlLYQ0dGol2v+Kc++OCSt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a73a17-a99f-41e7-f3db-08dcc3bf85e2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 22:04:13.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTCBOOoai29G0teIE+/5ICxzSAFTXymmrk/nLkm+HmnwA5vVd37XOWedNIPRjmgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

Hi Reinette,

On 8/23/2024 3:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/24 1:11 PM, Moger, Babu wrote:
>> On 8/16/24 17:33, Reinette Chatre wrote:
>>> On 8/6/24 3:00 PM, Babu Moger wrote:
> 
> ...
> 
>>>> +
>>>> +static int rdtgroup_str_to_mon_state(char *flag)
>>>> +{
>>>> +    int i, mon_state = 0;
>>>> +
>>>> +    for (i = 0; i < strlen(flag); i++) {
>>>> +        switch (*(flag + i)) {
>>>> +        case 't':
>>>> +            mon_state |= ASSIGN_TOTAL;
>>>> +            break;
>>>> +        case 'l':
>>>> +            mon_state |= ASSIGN_LOCAL;
>>>> +            break;
>>>> +        case '_':
>>>> +            mon_state = ASSIGN_NONE;
>>>> +            break;
>>>
>>> It looks like this supports flags like "_lt", treating it as assigning
>>> both local and total. I expect this should remove all flags instead?
>>
>> This is a cobination of flags.
>> "_lt"  This will assign both local and total.
>> "lt_"  This with remove both the flags.
>>
>> It seems alright to me. Do you want me to change the bahaviour here?
> 
> This looks like undefined behavior to me. A request to set individual flags
> and also clear all flags looks like a contradiction to me.

Ok. Will address this in v7.

> 
>>
>>
>>>
>>>> +        default:
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return mon_state;
>>>> +}
>>>
>>> hmmm ... so you removed assigning mon_state to ASSIGN_NONE from default,
>>> but that did not change what this function returns since ASSIGN_NONE 
>>> is 0
>>> and mon_state is initialized to 0. Unknown flags should cause error so
>>> that it is possible to add flags in the future. Above prevents us from
>>> ever adding new flags.
>>
>> May be I am missing something here. How about this?
>>
>> enum {
>>          ASSIGN_NONE = 0,
>>          ASSIGN_TOTAL,
>>          ASSIGN_LOCAL,
>>          ASSIGN_INVALID,
>> };
>>
>>
>> static int rdtgroup_str_to_mon_state(char *flag)
>> {
>>          int i, mon_state = ASSIGN_NONE;
>>
>>          for (i = 0; i < strlen(flag); i++) {
>>                  switch (*(flag + i)) {
>>                  case 't':
>>                          mon_state |= ASSIGN_TOTAL;
>>                          break;
>>                  case 'l':
>>                          mon_state |= ASSIGN_LOCAL;
>>                          break;
>>                  case '_':
>>                          mon_state = ASSIGN_NONE;
>>                          break;
>>                  default:
>>             mon_state = ASSIGN_INVALID;
>>                          goto out_done;
>>                 }
>>          }
>>
>> :out_done:
>>          return mon_state;
>> }
>>
>> Then handle the ASSIGN_INVALID from the caller.  Is that what you think?
> 
> Why not return an error?

Sure.
> 
>>
>>>
>>>> +
>>>> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype,
>>>> char *p_grp, char *c_grp)
>>>
>>> rdtgroup_find_grp() -> rdtgroup_find_grp_by_name()?
>>>
>>>> +{
>>>> +    struct rdtgroup *rdtg, *crg;
>>>> +
>>>> +    if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>>>> +        return &rdtgroup_default;
>>>> +    } else if (rtype == RDTCTRL_GROUP) {
>>>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>>>> +            if (!strcmp(p_grp, rdtg->kn->name))
>>>> +                return rdtg;
>>>> +    } else if (rtype == RDTMON_GROUP) {
>>>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>>> +            if (!strcmp(p_grp, rdtg->kn->name)) {
>>>> +                list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>>>> +                            mon.crdtgrp_list) {
>>>> +                    if (!strcmp(c_grp, crg->kn->name))
>>>> +                        return crg;
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>>>> +                  enum rdt_group_type rtype,
>>>> +                  char *p_grp, char *c_grp, char *tok)
>>>> +{
>>>> +    int op, mon_state, assign_state, unassign_state;
>>>> +    char *dom_str, *id_str, *op_str;
>>>> +    struct rdt_mon_domain *d;
>>>> +    struct rdtgroup *rdtgrp;
>>>> +    unsigned long dom_id;
>>>> +    int ret, found = 0;
>>>> +
>>>> +    rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
>>>> +
>>>> +    if (!rdtgrp) {
>>>> +        rdt_last_cmd_puts("Not a valid resctrl group\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +next:
>>>> +    if (!tok || tok[0] == '\0')
>>>> +        return 0;
>>>> +
>>>> +    /* Start processing the strings for each domain */
>>>> +    dom_str = strim(strsep(&tok, ";"));
>>>> +
>>>> +    op_str = strpbrk(dom_str, "=+-");
>>>> +
>>>> +    if (op_str) {
>>>> +        op = *op_str;
>>>> +    } else {
>>>> +        rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    id_str = strsep(&dom_str, "=+-");
>>>> +
>>>> +    /* Check for domain id '*' which means all domains */
>>>> +    if (id_str && *id_str == '*') {
>>>> +        d = NULL;
>>>> +        goto check_state;
>>>> +    } else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>>>> +        rdt_last_cmd_puts("Missing domain id\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    /* Verify if the dom_id is valid */
>>>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>>> +        if (d->hdr.id == dom_id) {
>>>> +            found = 1;
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (!found) {
>>>> +        rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +check_state:
>>>> +    mon_state = rdtgroup_str_to_mon_state(dom_str);
>>>
>>> Function should return error and exit here.
>>
>> No. This is case to skip checking for domain when '*' is passed to apply
>> assignment to all the domains.
> 
> Using "*" for a domain still requires valid flags, no?

Yes. Flags will be process as usual.

> 
> Reinette
> 

-- 
- Babu Moger

