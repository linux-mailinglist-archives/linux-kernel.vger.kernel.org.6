Return-Path: <linux-kernel+bounces-273258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D6F94668C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FA0282FA4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062D568A;
	Sat,  3 Aug 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LI+PfL47"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959C4C7B;
	Sat,  3 Aug 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722646167; cv=fail; b=tws8EyoTfqY7jBq4kuLtI7JDtdfV1Qz2yf3k8j2jVJpHByT3cPI4UNJ38aaS/vVQj68YTpm5ws/CqEKq906cwflYkWQh5WnnBfA/bmI7QFWnPJlmaVxGhRhl6UmTnLYybi1Ks8wL4KOlTIDncjSyfr2MHtpRgelppsgqB8wip90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722646167; c=relaxed/simple;
	bh=l5lQXAH+lcoqJSUkDpiASrlnGvmLizEwq1t8b451Urw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tAo5R0qa7PaRuoIl652QenPY0W7HWJ/0JQzpOWrL77az+o1K9Wy3ScIRWuuX/DzGF6zzdK4PJI+7oUgoI/VMX3fFodH5A5cuDs43+dzdtifdn6A4nsY9mV6aNYigTjnuaN11IoHtpLMKcqaGVG2td+X4hJFnmWJ0++iykMKIbGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LI+PfL47; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OePL8D+hY3NJQgGgW/44uBpKQTR2nSw8lkoCm3a3mQsBYhr8kOJF5dP/tKJRN7va0xH0NU5GqMaI/hFhlUAa6RSQFaaIlwruoan451qhPEYytDZXRRPeTfzEvUjr5qU1IrCTmmsI7dza+zzrNK8D9du3Bi32Podj1FPrHTtmJ8zbX8/XkhxH12YimtnG8/eJYhCfioY8aSIXkFloL7Yk6QJcr45uinpHgTdiGKxXrcnrnpBn9L5u8HyfYR4iFDPR507wCr3sSrkCLn2gWfJjtvmrWHXeZU7EKGNNzT979RWP1igj7YlRNk+37t+PbMcA8RNVSqcZdfueUWR9TKIrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAaj2toRbCEWPqle7iJVQVwjIa02a+7OKGtLxEDQQSs=;
 b=NQDSHnCZ8+NVZa9m+oyTldCwA+tB84IEiGRKHvYBrD2Fmq6vyBBpIrcX2Y4B8TQL15CwijCU8+knce8MZNb7lAdD1cQyNhEioe4eXGlqr3kz7cJwJTfOHGg+mEtBzpWQ+Uv+/UQbTDZQLekyEdtVGHd6RYzRO9rodyJDJdgqHjfdXkeiWT2nAijpiewJDWcQ9UYl6zu/SiKLXY85ArGVhHyntRuRFdEKuV7//13uV0LqYHPImj2E/zktQdbnrxtIKlryY2EkMU/RcQqB4iim0qNEQtJMFhG9BTEfIWKjWW89s0SyoXdfGj6JlFRMVcEaIw7KdWVv9Bwzx3kNmR2F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAaj2toRbCEWPqle7iJVQVwjIa02a+7OKGtLxEDQQSs=;
 b=LI+PfL47nvrfyEsideUzWUkSt4yYMQ7W6ZtfklY1NUGuZqf0DkT2s7oKh4yTIFVATF0F5K05ICghSlqoIDyqJdNsE7yf/FMKSykaUdaqi7HfB4HFmqLdpC4EAcOfOdLtmc28x0Pl3c66mIkyHx+ERGZx0Kupr1McHXxvUNZk9KI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Sat, 3 Aug
 2024 00:49:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Sat, 3 Aug 2024
 00:49:18 +0000
Message-ID: <19f608a1-8119-79bb-da00-703cee6ea5b5@amd.com>
Date: Fri, 2 Aug 2024 19:49:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
 <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:806:d2::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb86c29-b10a-4113-e948-08dcb3561b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWJGLzhNcThxNm8yUTdDUXZjdTlKRXZUL3NmYllEZjhvZDI4am5lUys0Q2dm?=
 =?utf-8?B?VjBDeWRDcm1BQjZIaXpmaXZWNTNmR1IyOGl4WFhOMDhQYkhOcm1iNnpJeGlI?=
 =?utf-8?B?Q0lEeG8rcEpveldBbFE5bDB1Wk5vcEVhWGZWQTJkZitIOFdmaE1MVDBINERX?=
 =?utf-8?B?c0xVeENTdGhsS3lyTGdxUitaSmttWVRDeXFyUVJDemYxY2hVbFUwUXBuM21y?=
 =?utf-8?B?ZXFWb0lzZVFqS1NVREdJdnZrMFhoSE9IOG94MnUyZC8yQ1dLQ1NvbWNJdTlo?=
 =?utf-8?B?dEFUUUFvREgyRGt3bGZoNmZkYmFIQkk0cWtkd1JNbTVWVmt5MjNqNldTcmwz?=
 =?utf-8?B?L0wzUUFwUTRiL0puNHg1UjY2LzBDdy9sbnl3NHlwN0xsZzlxYVgzUUdwTis4?=
 =?utf-8?B?SmU0TCtFZUNuNEs0Vi91ZmczRTErL1NydmY1VVVCY2dhb1NHMFNsNGJja0Ix?=
 =?utf-8?B?Z3hSYTA2YU9sYUFlRWJzdDluTVF2TVRkWkhMQmUxdTNqMm9uUUtHQ2xvTEFT?=
 =?utf-8?B?dm1RcnBFU2xwcFR1U3hYSU0rd202NXZIZVpHeFl6NnlZcVhUUzBnZVFxcHFv?=
 =?utf-8?B?V2ZPY1M3WjJOM25jY0wyUEhiQ3ZZeGVEN2JJU0duRGt1ZVRUM1M2TTI5L1BS?=
 =?utf-8?B?OVpQWnFqZ1J1N24rQVdsMWp3N3M3S3pxUXRkMlo4VklRRDlwV253b1Nnd1ZY?=
 =?utf-8?B?eGlOdG1LR0V5aWZuR2MyR0F1bXZuK2dlMEFkbTUzaU41TU96TE1EdVQ3YzBp?=
 =?utf-8?B?YllEbkFsdTVSZXY2NThSeE0ybi94MitBMy9OY041K2tEenl4aGhFalVSYXBh?=
 =?utf-8?B?bzFhWElvWmtwY3lSaDVqRnlTNVJXR0xoMUxDQnYwRDQ1RXFhVUFKT1Q5UkxX?=
 =?utf-8?B?NUN1ZG1WdllYSDFoRHYxS29VRHNTUlpJNURFVnZiaUJ5d0FYWjI4R1M4bTR2?=
 =?utf-8?B?WVIyejFQSzNlY3JZMVVPVzArY1p6UXZkTC9yM01EQTJyWG9XaUQrUUVmN0da?=
 =?utf-8?B?ak4wcVVsc3Q5SHZrcWt0eWxLQlQ4dUFneVJpZUZyNTIzd1hnWXo2eGRCenY0?=
 =?utf-8?B?eUVnQUl2a0NJbkZZYytuMSt6eVdpVC8xMm9SbEN1aTlyVWFOOFZuL2J2MVNY?=
 =?utf-8?B?Nm1NSzFRRGdJcVlnVElZYjVyOFZkMjZwRkhRWDhOOUlJSHlwTTVranRZSGpp?=
 =?utf-8?B?NjlranRWMDc0R3pYNWhqTnpUOU9Ya3YvWmU3Y1NEcVZzQjl6cXlzZDZIeEY1?=
 =?utf-8?B?N2IvUWVXamRoQ3daaGdkbWtaMms3UGw2OVpFUmI3bE9uUzBQVkVxTUFCdk1z?=
 =?utf-8?B?QzdNbkVFaGVoNy8yZEVnT1lNa2drcGNPVkh4T0RyZUVWa0ZMT21CQUxXOEpN?=
 =?utf-8?B?bzBkQmQ0aGEyWms2ZWQzamh0Ky9XbTcyZmF0a1NJdGZ6eDBlVUdlOS9QQzdp?=
 =?utf-8?B?Y1BRWElqaldBVnMvVkhmWWdUYTNiQWFmNWFmaTM5SVhUSlJadytidFhYbWVo?=
 =?utf-8?B?enVBc3NjcEZkejhBcXZPeCtWQ0szZjlZSTNiWjhLL0p4UER3WjZETkJka25O?=
 =?utf-8?B?aGZoM3lCV3lpTE56R0RUUnRyQ2wvcXU2TkE1NkpQK3pqRTRmMzZlM2RRa3VY?=
 =?utf-8?B?ZlJJa05DUXlUazhlTGJyYkVVZkRyVktBbmduaFQ3VVlRUGhXTDJOUFY1QWdH?=
 =?utf-8?B?bEFiTEFlVm5Oc3BHK0hhWGtHUU9lVHhOdHhGdmd1YWZpVnpiYlR6cDU1MExP?=
 =?utf-8?B?dE81K0pBTG91VkVSSHVmR0lxbkpaNTFSb2MwdmRMSEh2MlNzMnR6S0FrVzNo?=
 =?utf-8?B?emtucDMySmlYYXdDejRsUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUo0RW5kdXFPQzh0L1ZmNmRITGJLWTZMMTEwZ082eGcyV0JNVHJvb1d4YUxO?=
 =?utf-8?B?Q2M1UXBxSzd0ODVsaWI4VGRob1NZRGxYdmF2WnZpT1E5QjJzbXNITVptdDZO?=
 =?utf-8?B?K0ltMzFBNlQ3MjQvZjcrNXJ4cWVWYXdKeVpMUCtPNDJrRU1kUnB6a0VGbitw?=
 =?utf-8?B?emROZDhOVnhWT3lQQ1FVNW4vN1FpSHFLYlNxT0RTUXhjTFZpeERCR0EzSzc3?=
 =?utf-8?B?R1FqcGJONGRjTlhvYjN5a0xhTFVjek95bFRVRzA4ZnZqNGdKeGdKVUJQeUM0?=
 =?utf-8?B?cmY5aDBEY1FlSWhrbWM4NmRPa1JvTHJrcmkvbTlheEdQWEpEbm1hbnVvVXoy?=
 =?utf-8?B?UklBeUFTdzhtN3ppd2tIcmllOW45dDhJUWlJNHgySnFuY1ZoRjFuclRKQ2tL?=
 =?utf-8?B?aW5JWFVUK0RLNlJVZ045bEV0RWlNcExna2R5ZFFDN2kvQXduaVY1Y1NFK2ZR?=
 =?utf-8?B?Nk9XdmljUG5sNVlzY1k2RUtCd1JaYTJ4bzN3WjRPdUxBWjRvcEZKVjFNNzRx?=
 =?utf-8?B?OTdTblNINjVLM3B4aFRXN2hwUHNyUHVhN0tVNE0vSFZhM1h6bGtPR3NwOFMy?=
 =?utf-8?B?SG0xK01XbHh4bmQreFBrakRQTUNLSmVYbHdzY0VRTmp3dEJ5eGRyYjFqTEla?=
 =?utf-8?B?cHQvTXI2a1lPYUI0ZkN6blNLb0JmZ3lMa2NQaEd0djZ5K1ZoYmZxSGtSaExN?=
 =?utf-8?B?SHFXZSs5Q05IaWdUUVdNWHJqOFgwZG1aTjRDbEZrY3dNTy9jSUNzeS9BdXJU?=
 =?utf-8?B?Mzc1NkdXTnNMOGt2L01QTUEzb0ZTNkZBNnUrU3RhMGJNU0RqVHdQYm9ZV2NX?=
 =?utf-8?B?YTRsd2Z1K1g5WmNvWkdHQlFweDBDbU81UUZvSEFFZGVJa1FmaisrNnlDR0hm?=
 =?utf-8?B?bmR6RFcrWUxwdDA4clJncjU5bUc4NmdiMncxU2JmSW1FMWtUZFlqTGdDbU5K?=
 =?utf-8?B?UnpNWmRyZWxibWN6TkV5Z1VsSFA0MGxmVitHZTJnWktCd2gzOEJNYmtEbDl4?=
 =?utf-8?B?ZXpxQytsNXVZQVFpZDlValI4eDdkOW5HaDYrS3NUSVhJMHVVenJ1YlNyZ0JY?=
 =?utf-8?B?b2JhbmpRdlVPbTIvTGNWLzFIQjh2TjBSTVNzak44REpVT1l2OGZCaFZEa29k?=
 =?utf-8?B?Z1dTUTNDTU1DTVBoZkpHOTJOR3NsZUt5N2orSlhUa3ZXQ1lzV1NranhhL3d5?=
 =?utf-8?B?Tm5sSGNHNlhySGY5VnZXVFZxZkdXSjBsSE82NVQwZkUzbE1SMFJHOW83cVJN?=
 =?utf-8?B?WnF0M0JsdjhJT3g2LzRIYjFZcjBZb1BWUnNsSUxmTTNwbTZFNDRmU1J5THZ3?=
 =?utf-8?B?VkVxZkJNQVlMR2gxbG1GUEJJeXJyV0IzZXYrcU5OTklVMGNtTG9ON2xydllG?=
 =?utf-8?B?dS9LbXV3c1pnc29wSDhmL2FJMHJ0UVVXQXQxazNPQTl2VEY5U0tvWUxKRFAr?=
 =?utf-8?B?dGRkelJmZ1BNMW1HbCtQRVVsYjZSTVJHYjlzNWl3QjRqSHJJSmo4dng0WGdM?=
 =?utf-8?B?eW1BU1NoV2FWcDI3WEhmWUZuWE1YVytpZ3ZKNmo2aG81R2t1aHA4UDd0YXpO?=
 =?utf-8?B?MS9TQ3B5TDZ0VzQvTSsrSVlIT2ZsUFdVNEtVLzVpYVdGUnJlUkZadjdqaFZM?=
 =?utf-8?B?UW5UUlN0bDdoNlMyblZRckdDeW10akUrRlU0SXF0RUVEd2krM0FaNW9KWEpV?=
 =?utf-8?B?WE1MQlRqOXJCRnlaOWJtQkZ3S2RtbkRZWEdaejMrTFZhTU9OMXlYdFBFOFlt?=
 =?utf-8?B?eDhYa2xmckZMeVBMZmRoOUxidzVEN3lMdGtFR2xISDBSdklYMHVTV2c4SkU1?=
 =?utf-8?B?SlZHYjgwMXJaeVpWbUR3USs1M1ZNSjR0cnNlNGM4NG81bGZPY1p1OEQvaXZM?=
 =?utf-8?B?YWZYYWtTVmtVRDVhcEFoTFdESXF0MSt1M1VSTDJKdVI0SVI2SktCd3VLZzFP?=
 =?utf-8?B?TEt4Z3c0VHFUY2JhbXpjeWJSOHV6WFZjUTd6b1ZDUlJjdXU1cHh3c3lqc2hU?=
 =?utf-8?B?eU12MmtOdHYyWkEwTDR0OEtiazBBd2xxazlvU1doN0IyR0Vod0o5N3BXZWcw?=
 =?utf-8?B?aTd1Q2pqMTkyN0tTeUV2NG1VUVVSQWR5bWNBVkFpWmtqMmh4Kzd6R0k1QVNy?=
 =?utf-8?Q?lHmA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb86c29-b10a-4113-e948-08dcb3561b22
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:49:18.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYp3Fi7E/21VsF0AbBH4m1ateWmzGSohNrns9xQ8GT9yYUsFj+I4i+A1xD1lj5Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

Hi Peter/Reinette,

On 8/2/2024 3:55 PM, Reinette Chatre wrote:
> Hi Peter,
> 
> On 8/2/24 11:49 AM, Peter Newman wrote:
>> On Fri, Aug 2, 2024 at 9:14 AM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>> On 8/1/24 3:45 PM, Peter Newman wrote:
>>>> On Thu, Aug 1, 2024 at 2:50 PM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
>>>>> On 7/17/24 10:19 AM, Moger, Babu wrote:
>>>>>> On 7/12/24 17:03, Reinette Chatre wrote:
>>>>>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>>
>>>>>>>> # Examples
>>>>>>>>
>>>>>>>> a. Check if ABMC support is available
>>>>>>>>        #mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>
>>>>>>>>        #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>>>>>        [abmc]
>>>>>>>>        legacy
>>>>>>>>
>>>>>>>>        Linux kernel detected ABMC feature and it is enabled.
>>>>>>>
>>>>>>> How about renaming "abmc" to "mbm_cntrs"? This will match the 
>>>>>>> num_mbm_cntrs
>>>>>>> info file and be the final step to make this generic so that another
>>>>>>> architecture
>>>>>>> can more easily support assignining hardware counters without 
>>>>>>> needing to call
>>>>>>> the feature AMD's "abmc".
>>>>>>
>>>>>> I think we aleady settled this with "mbm_cntr_assignable".
>>>>>>
>>>>>> For soft-RMID" it will be mbm_sw_assignable.
>>>>>
>>>>> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to 
>>>>> match
>>>>> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
>>>>
>>>> My users are pushing for a consistent interface regardless of whether
>>>> counter assignment is implemented in hardware or software, so I would
>>>> like to avoid exposing implementation differences in the interface
>>>> where possible.
>>>
>>> This seems a reasonable ask but can we be confident that if hardware
>>> supports assignable counters then there will never be a reason to use
>>> software assignable counters? (This needs to also consider how/if Arm
>>> may use this feature.)
>>>
>>> I am of course not familiar with details of the software implementation
>>> - could there be benefits to using it even if hardware counters are
>>> supported?
>>
>> I can't see any situation where the user would want to choose software
>> over hardware counters. The number of groups which can be monitored by
>> software assignable counters will always be less than with hardware,
>> due to the need for consuming one RMID (and the counters automatically
>> allocated to it by the AMD hardware) for all unassigned groups.
> 
> Thank you for clarifying. This seems specific to this software 
> implementation,
> and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I 
> remember
> correctly this depends on undocumented hardware specific knowledge.
> 
>> I consider software assignable a workaround to enable measuring
>> bandwidth reliably on a large number of groups on pre-ABMC AMD
>> hardware, or rather salvaging MBM on pre-ABMC hardware making use of
>> our users' effort to adapt to counter assignment in resctrl. We hope
>> no future implementations will choose to silently drop bandwidth
>> counts, so fingers crossed, the software implementation can be phased
>> out when these generations of AMD hardware are decommissioned.
> 
> That sounds ideal.
> 
>>
>> The MPAM specification natively supports (or requires) counter
>> assignment in hardware. From what I recall in the last of James'
>> prototypes I looked at, MBM was only supported if the implementation
>> provided as many bandwidth counters as there were possible monitoring
>> groups, so that it could assume a monitor IDs for every PARTID:PMG
>> combination.
> 
> Thank you for this insight.
> 
>>
>>>
>>> What I would like to avoid is future complexity of needing a new 
>>> mount/config
>>> option that user space needs to use to select if a single 
>>> "mbm_cntr_assignable"
>>> is backed by hardware or software.
>>
>> In my testing so far, automatically enabling counter assignment and
>> automatically allocating counters for all events in new groups works
>> well enough.
>>
>> The only configuration I need is the ability to disable the automatic
>> counter allocation so that a userspace agent can have control of where
>> all the counters are assigned at all times. It's easy to implement
>> this as a simple flag if the user accepts that they need to manually
>> deallocate any automatically-allocated counters from groups created
>> before the flag was cleared.
>>
>>>
>>>> The main semantic difference with SW assignments is that it is not
>>>> possible to assign counters to individual events. Because the
>>>> implementation is assigning RMIDs to groups, assignment results in all
>>>> events being counted.
>>>>
>>>> I was considering introducing a boolean mbm_assign_events node to
>>>> indicate whether assigning individual events is supported. If true,
>>>> num_mbm_cntrs indicates the number of events which can be counted,
>>>> otherwise it indicates the number of groups to which counters can be
>>>> assigned and attempting to assign a single event is silently upgraded
>>>> to assigning counters to all events in the group.
>>>
>>> How were you envisioning your users using the control file 
>>> ("mbm_control")
>>> in these scenarios? Does this file's interface even work for SW 
>>> assignment
>>> scenarios?
>>>
>>> Users should expect consistent interface for "mbm_control" also.
>>>
>>> It sounds to me that a potential "mbm_assign_events" will be false 
>>> for SW
>>> assignments. That would mean that "num_mbm_cntrs" will
>>> contain the number of groups to which counters can be assigned?
>>> Would user space be required to always enable all flags (enable all 
>>> events) of
>>> all domains to the same values ... or would enabling of one flag (one 
>>> event)
>>> in one domain automatically result in all flags (all events) enabled 
>>> for all
>>> domains ... or would enabling of one flag (one event) in one domain 
>>> only appear
>>> to user space to be enabled while in reality all flags/events are 
>>> actually enabled?
>>
>> I believe mbm_control should always accurately reflect which events
>> are being counted.
> 
> I agree.
> 
>>
>> The behavior as I've implemented today is:
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
>> 0
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> test//0=_;1=_;
>> //0=_;1=_;
>>
>> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> test//0=_;1=tl;
>> //0=_;1=_;
>>
>> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> test//0=_;1=_;
>> //0=_;1=_;
>>
>>
> 
> This highlights how there cannot be a generic/consistent interface 
> between hardware
> and software implementation. If resctrl implements something like above 
> without any
> other hints to user space then it will push complexity to user space 
> since user space
> would not know if setting one flag results in setting more than that 
> flag, which may
> force a user space implementation to always follow a write with a read that
> needs to confirm what actually resulted from the write. Similarly, that 
> removing a
> flag impacts other flags needs to be clear without user space needing to 
> "try and
> see what happens".
> 
> It is not clear to me how to interpret the above example when it comes 
> to the
> RMID management though. If the RMID assignment is per group then I 
> expected all
> the domains of a group to have the same flag(s)?
> 
>>>
>>>> However, If we don't expect to see these semantics in any other
>>>> implementation, these semantics could be implicit in the definition of
>>>> a SW assignable counter.
>>>
>>> It is not clear to me how implementation differences between hardware
>>> and software assignment can be hidden from user space. It is possible
>>> to let user space enable individual events and then silently upgrade it
>>> to all events. I see two options here, either "mbm_control" needs to
>>> explicitly show this "silent upgrade" so that user space knows which
>>> events are actually enabled, or "mbm_control" only shows flags/events 
>>> enabled
>>> from user space perspective. In the former scenario, this needs more
>>> user space support since a generic user space cannot be confident which
>>> flags are set after writing to "mbm_control". In the latter scenario,
>>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>>> to rely on it to know which events can be enabled and if some are
>>> actually "silently enabled" when user space still thinks it needs to be
>>> enabled the number of available counters becomes vague.
>>>
>>> It is not clear to me how to present hardware and software assignable
>>> counters with a single consistent interface. Actually, what if the
>>> "mbm_mode" is what distinguishes how counters are assigned instead of 
>>> how
>>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>>> and "mbm_cntr_group_assignable" is used? Could that replace a
>>> potential "mbm_assign_events" while also supporting user space in
>>> interactions with "mbm_control"?
>>
>> If I understand this correctly, is this a preference that the info
>> node be named differently if its value will have different units,
>> rather than a second node to indicate what the value of num_mbm_cntrs
>> actually means? This sounds reasonable to me.
> 
> Indeed. As you highlighted, user space may not need to know if
> counters are backed by hardware or software, but user space needs to
> know what to expect from (how to interact with) interface.
> 
>> I think it's also important to note that in MPAM, the MBWU (memory
>> bandwidth usage) monitors don't have a concept of local versus total
>> bandwidth, so event assignment would likely not apply there either.
>> What the counted bandwidth actually represents is more implicit in the
>> monitor's position in the memory system in the particular
>> implementation. On a theoretical multi-socket system, resctrl would
>> require knowledge about the system's architecture to stitch together
>> the counts from different types of monitors to produce a local and
>> total value. I don't know if we'd program this SoC-specific knowledge
>> into the kernel to produce a unified MBM resource like we're
>> accustomed to now or if we'd present multiple MBM resources, each only
>> providing an mbm_total_bytes event. In this case, the counters would
>> have to be assigned separately in each MBM resource, especially if the
>> different MBM resources support a different number of counters.
>>
> 
> "total" and "local" bandwidth is already in grey area after the
> introduction of mbm_total_bytes_config/mbm_local_bytes_config where
> user space could set values reported to not be constrained by the
> "total" and "local" terms. We keep sticking with it though, even in
> this implementation that uses the "t" and "l" flags, knowing that
> what is actually monitored when "l" is set is just what the user
> configured via mbm_local_bytes_config, which theoretically
> can be "total" bandwidth.
> 
> Reinette
> 
> ps. I will be offline next week.

Thanks for heads up.

Looks like we still need to figure out few things about the interface.

However, I need resolve few issues with v5. I can go ahead and post v6 
next week. We can continue our discussion. That way we are making some 
forward progress in the series. Let me know  what do you think.

Thanks
- Babu Moger

