Return-Path: <linux-kernel+bounces-370253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143729A29E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F96282C70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21321E04A6;
	Thu, 17 Oct 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QF5TBCld"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDA1E0496;
	Thu, 17 Oct 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184133; cv=fail; b=SQZRht/l/n7HdyftnQLUV4rrqDv88v6OSZuHmBGmx7a4MCjc36qX0QUY9/8+vh95hQU8gJT0mRnPGvOf/IOpR/zrnjQsyhhr0+hhZwXAAJNCu4oa4iliPiAYozVqbhDYoiF52VG3UkzxrOiJkBPtXEWmqnpD4YxX82q5NNiLnbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184133; c=relaxed/simple;
	bh=WTe0qejuQrUdDYdHnyxlZH5l450CjKVHJ516nCJRnsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLmGoxgIIZEZieXqjsJHUrPJ6M558yweMfd0gtfPcxeZDvSCJoJ4jYYJFsYKtEyJvvXDGXhLQERm/9Lr6RUX2bzDrz2IJbMYL8Too2uEygutYzVoJ1/NYXOTqyWqW48z4ZwQ+wSVk/iov4H6GrGmQvaol3j1n6BULEiz8Tw9gZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QF5TBCld; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OftqVrGyrCpCTMP2yHPLv4Kefc5x5Vi/ExKAzvQnoYuo6w8Ebra8d37MdUHydn0MoHCU9OaQeKmoGJLFhtv9zQlkRPuxnp///pxqeAiKo6zVuc2gMj+ixLX7Y7vEEPvO+YFhnlp41PKq43Je/jJ9oklzv8MvP+C9cuokNXxR1ocLWsFyvsbx98SL8bxTh/eoqAQYeUGXs91cOhuFQxCdP3aOpZRigrxysAy51JnXrWNCRsYRTwzrtvmNZB7ypsSd5kUoVnNRBFV7ecMS2HjR+SZXNIVy5PLVzStf6DvsX8Uf+dQwfcZHHp3y9eqw/a8apf/b/eylYHELkCQJKNLcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYCRBxsJ8a07anlttDR1jf6X35XR0sWDcVyri9Lq/To=;
 b=jSy2EbXNPlkjaMJjUNRzOq9Hhd76wHcPatk4JFovq/VbWB0F7F57kWmBPRfsjbbmyoqFIWkwb0deSkqAfZoOixLyk7NgwSRGfuS2erAdrYJDprby4i83wk8KxjLm98EJDfM27W4Gs1J/bZN/ZAr2NLqeokqA+zZOtbzceeCemcEyBP97/j/rujBcOoYKDs7C3D7YEH0Sq7AFaqCd3AWdLp/pSP48+ZHtKzNAecioKfwx29ZtyTcM2x7BJ/tcY9XvvZ0ub7X+fGnZF1bwhiY+Z1L059XuwDY2sK+p0BAp9cCqEIIJb8Kj7aBncoBHLk+7GlsQ0CPpsRw6Pdy8mmCUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYCRBxsJ8a07anlttDR1jf6X35XR0sWDcVyri9Lq/To=;
 b=QF5TBCldQ73W8PvS6SJecQwChkEAID0USgcHxEQIhNCNMyfz6It/4hHEWxEPyX3/wVaIbcF4RwnbOvM9lVmptFj+G2l1/CuiGl9MwPGN2YvBB9Iw/5+y4iYK5PrMCP8df0ZWTlM2RYryyJAqzFtu5p9QZL23gVuMm752TZUSPHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 16:55:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 16:55:25 +0000
Message-ID: <b1e66a52-7065-49f3-bc24-9460ed1b8449@amd.com>
Date: Thu, 17 Oct 2024 11:55:20 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 10/25] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <669613777b83bcd4150f2f204311e96198417495.1728495588.git.babu.moger@amd.com>
 <acb1a461-1e2d-40fb-80f5-fbb6a81145e1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <acb1a461-1e2d-40fb-80f5-fbb6a81145e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:806:125::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc8b56a-1f98-4a01-d8a3-08dceecc7eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmhQQjRUWndXZUl4cjFHRlN6UmlVY3dnSS9UWjdlTzFRL05HOVlMKys2enhz?=
 =?utf-8?B?WDIzTGpNWCszclphdHJveHV6enQrOHZIQ0cxcmpRa2lQM3Y1NDFvSFNoeVdj?=
 =?utf-8?B?SmJqQWd4QjZZZ0ZQUmhBMzJSZDNDa1h5NHdrYVB5bnZVaHdTYVdKU1hGdXli?=
 =?utf-8?B?NUhONDVVUUdRVXpkaGpUYUExdFovTnpFQS9CU2QxQktCSWZrVVIza3NpSkY1?=
 =?utf-8?B?QmVYT0R1L1lJaGtkZ2pPM2wyVkd4eFZMNElIbnkxOHh1N0owVVNFWm5TNjdj?=
 =?utf-8?B?MXVyVlcrd0V5a1RXczlpWEtsMWdiclZyRUlUcTkzSkFhQWpqRDE1TkcxYnho?=
 =?utf-8?B?dFgxYWNFZE9CQVpFd2lVQ1FIY0RGUlpGNzY5QUpnczhCWWg4M2JUQ1RSczZ2?=
 =?utf-8?B?b1hGTEcrS2xUMHFYN1c0RkNXekVOcDkzUVVMTW5HdGFUUFNNVHlIWU9RZDRH?=
 =?utf-8?B?S0pKTHJmcHN0ZjBmWUZjSjdsT2trUUJTREdQL2s5Y2hHNm9QeDM1dHRFNGYx?=
 =?utf-8?B?dUg1NnRueVlrYXlPbzlJbDZSdFlYTnEyWG5lTmlOendvQUlkWUFaU0tJOVFm?=
 =?utf-8?B?OVNMS0FodGhrNzYxMkZpQjAyT25QTDJqY2E5bjE2dFBDU1lxWVNGK3JWcVNx?=
 =?utf-8?B?SWppQ1FTZk53Uzh5cFR3YnlCbFV0OXl4WERkQ0tseDRLSk5yTmhPRzl0Rkp1?=
 =?utf-8?B?SHB2MktiK09adDRxSzhMOHFxYSs2TkVVS1pOVFdsd1QxN3NxTU44RWFwNmo4?=
 =?utf-8?B?cXVzK1ZOWTlWd0dwTEp6R0szd3o0SG8ySlNEZXhJaWo1dkd1RnNLakhRbDE3?=
 =?utf-8?B?UDlwTFM0VGxVZjFMalgvQTJpc3Qvc2hhV3lUbUNBaWVDQW9vSXVtNDdTeUxK?=
 =?utf-8?B?a0M4eEJZZE5jUit5cFRNd0M2QTZGWFVCUk5DZ0pqdHVOOTlWQTJIYkpmNHpy?=
 =?utf-8?B?Z0lDV1ZGZFc1OUdTNTZ5VmMya0RnRnFON1ZUbFViQjZhRVNnc1RQMUo5citY?=
 =?utf-8?B?T2dCRFVjeVllSHNjUWxsclJwZStnTEh6NE5rNDA3NzN4QndXd0JFc1J2VzJH?=
 =?utf-8?B?UHh2RE5SbFhYQ3NSMlpjTnRjVmNOYkM4a1kyalJ5Nm4wYUI4bGlPS0lqTkxo?=
 =?utf-8?B?cDZndC9vOE5sNk5vTm82UUEydm5XRzBBT2d6S3ljRmRrUjNKb05zMjFHa0Nh?=
 =?utf-8?B?YUxUZ0FUb0RjRFdQRmxUTnFEU1pzSEVVTlRpaHA1WUljMkw3dTlLRTFuQ0kw?=
 =?utf-8?B?UFY4dVBpOHNnWUlDNE1yWVhWYTNuRkVKWW1LVUVuOWMveldqY3RpbVYvYkRS?=
 =?utf-8?B?d2RQWWhmNkRqSkx2aGw1SmQrRWdoWHdrT2RaVEtEU1Y0bUd6SGl4YzFEQzVE?=
 =?utf-8?B?NzFUd3VPZ3d3T2txYzUvMzhvNzhnT0pMcnFHKzJpbjhwV3RNV2NZbU5pV0py?=
 =?utf-8?B?cGx1V0liM0JJU09FcUVvWVAwSmFES0g4bE1jNGprb05CRXV1UW9vajJBaGI3?=
 =?utf-8?B?aW9YOUFWNVFOMFdLYnBjSVdJNk8xaWZrak9JL0R5T0JkeXM5dDB1VGJhbFZF?=
 =?utf-8?B?bTh2eFJZTi9tdXZFZkdlTGszOXd1QURPbmg3TlRxK3RWbjQzTjB3L1FtWFkr?=
 =?utf-8?B?L3JDTTdwWVJqQWtlaUdualVlZVd5WE5TK21aU3pVemRWd3F2VUk4WGZsOU9a?=
 =?utf-8?B?bStSZ2JFWGs1VmhpM1FHTWU4SmVHbEphZlZWMktjY3JSSzFZbDRzTzV4akhk?=
 =?utf-8?Q?HFvUkgKMIlY92HcbwUJeVs8fCftSTi8X0xIf3wt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3YyRzFrYjlaTzZoVVNKdWZDd0V1ampCSjVjeXNZWjI5UzZ1dzdyMkRlSzh2?=
 =?utf-8?B?bDI5MWhIcStzR0pQcS9BZ3NwNmhwQi9OWGFEa2lEQk1hekYwMExiZGtHcjJh?=
 =?utf-8?B?eUxJK0thMWk0RFIzWDYyN1ZnaWxNYUNvZVFxSHJ2cC9yMGlGK2dibTgrNTJo?=
 =?utf-8?B?SXNTOXMxcHprZ2tQY2RLMmRBRExnMjdmSU0veVk5ajN1emlXeWRQcWlKb0FZ?=
 =?utf-8?B?RzUvd1NmOU1RM1ZNYTY3T2Fwcmg4RnBOQjdIU0lCajlxZWJQaHdaZkQyNHIv?=
 =?utf-8?B?Z2FhUGswVzF3cWN2UjZJU0ZjdHZnYlh0eUcyUm8zQXVUSkxRMTVzVFNzZGdx?=
 =?utf-8?B?UkdnMlVhOG5nckRnUHVySjZ1S1p3dURLcXVsRXBnQkNWRjluWUdOS0grM3lS?=
 =?utf-8?B?c2JQSzlVMGwxOUhlRTUyNVcyaUtLQzQ0d3M5RDdCVnJqV3BWMkhwT3d3ekRo?=
 =?utf-8?B?R3BueGloSE9jdWo3bzFMOW80TFFjTERsV2hQWk1FYllhdFNkK1BhT2JUSHlm?=
 =?utf-8?B?UjRUOERKRFhER2NLTm9aV2tIYVBMR25vSStEc3dlR3Bnd0NObXpHb0pEa0tO?=
 =?utf-8?B?eDh3Q1dEb2ZpRCtINENmT2V1NnRVTHUzb3NKaVkzaUJ4b24wM282QzZWSGZJ?=
 =?utf-8?B?TDkrUjF2RDZydnBzUXppYWFXSUpnWTZvaFVKOUFNUjZVOUdCU0FSNGV4MENS?=
 =?utf-8?B?bGRCTTc1dW1OUDRjYlp3RDBtR2xNWmJCRC93ZHBocThQZXFtMWM1azMwUDc5?=
 =?utf-8?B?ZEVyRVlBRGVxbmtZMFMzQWEweGNEZXVXRFh4MkMxZjhrS0czbEZaOG9PUVpK?=
 =?utf-8?B?c1ZqblBGbytEWDJYQkxEb2JDcDVOaVRiY1VJOUMrWi8yVTJxeCttMXhoZjJr?=
 =?utf-8?B?OXk5cXpHVG54NTV6enRUTSs3MTVxUC9iMHJvWC80TC96OWtqUXdTdG93QzhT?=
 =?utf-8?B?RlJOUWRQTm5PTHJvWVMwQ29CWXZ1Zm9kWVJ0MmI5alNSYjFzSTJUZFk4b3lT?=
 =?utf-8?B?Z2FsWVpndXFsQmJCV3FqSWgyOU5MRzJJTWVyNy9ZaGkwTFZTekFKMzVBOHRK?=
 =?utf-8?B?NWlNNTc4bkc4UzJVaFUxYkJrUEhjNkQ1VDlTRTdjdm9KeEdIZS9hc0Rtbm9l?=
 =?utf-8?B?YmYrTlJxYWJEcUJldlpudFczckx5RGl4MUN2RFJkUXNNZGZmbEhuenBvVEZ2?=
 =?utf-8?B?c2FTTmFoY2J0NDNHNjcvOUh2cnd1MXJJLzUzU0p5cjVZK2cyOC83NVVuTkRs?=
 =?utf-8?B?aWl1VXNIS1FnUytLeDJKQVlqOUlzZURzYzI2TnR3UEZTSE9TdnE0LzMyR1hG?=
 =?utf-8?B?ODZDOUJTeEx0VVg4UlFFU2kyL2FBckRYSHIrZ2NlM2J3RC9oY011Y29hNGVq?=
 =?utf-8?B?M1FRNXAxNnkwMFhHN1doQTdRUHRud2VBdTd0V0VUckYwZytTWTd3VE11bGNu?=
 =?utf-8?B?WkNUT1hPL0luUjFoenJMUUlWSVEwd0JEeG1VZEV0ZlJvQW9KNEFZVi9QL1hq?=
 =?utf-8?B?cGVKSTJsWU94Y1gzN2ZzemJjNkJlaG5DV2UzZDBPNU1mcGU1UDA4WGdVWkda?=
 =?utf-8?B?R2llenFEcHJmRWZZY3cxRkRRMEZpOWoxNHE0azFTZldZc2pZOHo5VmVjOTR3?=
 =?utf-8?B?ejVvTlB2ai9zeldJSEswcVlFR1lFKzkzemtuOUw5c2FnN3AydTdVd2tvL2g1?=
 =?utf-8?B?S3BoNE9ZdlB1RVpYWkkyMzFFUmlTMGhFMUJvYS93L0tWTklmcWh6d3pzYitR?=
 =?utf-8?B?MVd4aVB2UC9ZcCtsSktzdGJNS2xyUzRqVjBJOHNFK3FvNzBkN2NOeUZISWdK?=
 =?utf-8?B?T2toaXh2bHkwQ3VCUGlURGI0OHJ2cmxnL2J3RGRqS29malFJdUlmVGpsWnZa?=
 =?utf-8?B?QW1TQ3A5RFJtdnFMVmRFaEhmaSswYjdkSTlCOXhQZWx5VWRnTFlXNW5jSUQ5?=
 =?utf-8?B?UFExbXpIUm96dUVGZzZtRzc3cUt2RENkWk16Ly8reWF6QVNzV2tOdDhTSkxr?=
 =?utf-8?B?ZklITktwbjNVM0Q5TENxbmtDc25SakpjWnBUOVRBWHZESEVUSXpRbFZ5Y1VB?=
 =?utf-8?B?K3dHVjhRei9mNGVzbFdZNDRTR3ZyTW0vb0t6b1JVOUV4aWlhcHFjM2RZTFQ1?=
 =?utf-8?Q?5AiY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc8b56a-1f98-4a01-d8a3-08dceecc7eeb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:55:25.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9TI4BzuRSMwfdIZTBBj15WOoVXQcmBoFipF2bCzsPkfh8rqmjjPtitXOObWGSrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827

Hi Reinette,

On 10/15/24 22:14, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> Hardware provides a set of counters when mbm_assign_mode is supported.
>> These counters are assigned to the MBM monitoring events of a MON group
>> that needs to be tracked. The kernel must manage and track the available
>> counters.
>>
>> Introduce mbm_cntr_free_map bitmap to track available counters and set
>> of routines to allocate and free the counters. Move dom_data_init() after
>> mbm_cntr_assign detection.
> 
> Regarding "Move dom_data_init() after mbm_cntr_assign detection." - this is
> clear from the patch, please use changelog to explain *why*.

Will change it to.

dom_data_init() requires mbm_cntr_assign state to initialize
mbm_cntr_free_map bitmap. Move dom_data_init() after mbm_cntr_assign
detection.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++++++++++---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++
>>  include/linux/resctrl.h                |  2 ++
>>  4 files changed, 62 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 92eae4672312..99f9103a35ba 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -654,6 +654,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
>>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init resctrl_file_fflags_init(const char *config,
>>  				     unsigned long fflags);
>> +int mbm_cntr_alloc(struct rdt_resource *r);
>> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 66b06574f660..5c2a28565747 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -983,6 +983,27 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
>>  		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>>  }
>>  
>> +/*
>> + * Counter bitmap for tracking the available counters.
>> + * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
>> + * RMID, event pair. Each RMID and event pair takes one hardware counter.
>> + */
> 
> "counters for assigning RMID, event pair" sounds strange and it seems like the same
> thing is mentioned twice.
> How about:
> 	Bitmap tracking the available hardware counters when operating in
> 	"mbm_cntr_assign" mode. A hardware counter can be assigned to a
> 	RMID, event pair.


Sure.

> 
>> +static __init unsigned long *mbm_cntrs_init(struct rdt_resource *r)
>> +{
>> +	r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
>> +						 GFP_KERNEL);
>> +	if (r->mon.mbm_cntr_free_map)
>> +		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
>> +
>> +	return r->mon.mbm_cntr_free_map;
>> +}
>> +
>> +static  __exit void mbm_cntrs_exit(struct rdt_resource *r)
>> +{
>> +	bitmap_free(r->mon.mbm_cntr_free_map);
>> +	r->mon.mbm_cntr_free_map = NULL;
>> +}
>> +
>>  static __init int dom_data_init(struct rdt_resource *r)
>>  {
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>> @@ -1020,6 +1041,17 @@ static __init int dom_data_init(struct rdt_resource *r)
>>  		goto out_unlock;
>>  	}
>>  
>> +	if (r->mon.mbm_cntr_assignable && !mbm_cntrs_init(r)) {
>> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>> +			kfree(closid_num_dirty_rmid);
>> +			closid_num_dirty_rmid = NULL;
>> +		}
>> +		kfree(rmid_ptrs);
>> +		rmid_ptrs = NULL;
>> +		err = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>> +
>>  	for (i = 0; i < idx_limit; i++) {
>>  		entry = &rmid_ptrs[i];
>>  		INIT_LIST_HEAD(&entry->list);
>> @@ -1056,6 +1088,9 @@ static void __exit dom_data_exit(struct rdt_resource *r)
>>  	kfree(rmid_ptrs);
>>  	rmid_ptrs = NULL;
>>  
>> +	if (r->mon.mbm_cntr_assignable)
>> +		mbm_cntrs_exit(r);
>> +
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
>>  
>> @@ -1210,10 +1245,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	 */
>>  	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
>>  
>> -	ret = dom_data_init(r);
>> -	if (ret)
>> -		return ret;
>> -
>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>>  		u32 eax, ebx, ecx, edx;
>>  
>> @@ -1240,6 +1271,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  		}
>>  	}
>>  
>> +	ret = dom_data_init(r);
>> +	if (ret)
>> +		return ret;
>> +
>>  	l3_mon_evt_init(r);
>>  
>>  	r->mon_capable = true;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index c48b5450e6c2..8ffebd203c31 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
>>  	return !test_bit(closid, &closid_free_map);
>>  }
>>  
>> +int mbm_cntr_alloc(struct rdt_resource *r)
>> +{
>> +	int cntr_id;
>> +
>> +	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
>> +				 r->mon.num_mbm_cntrs);
>> +	if (cntr_id >= r->mon.num_mbm_cntrs)
>> +		return -ENOSPC;
>> +
>> +	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
>> +
>> +	return cntr_id;
>> +}
>> +
>> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
>> +{
>> +	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
>> +}
>> +
>>  /**
>>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>   * @closid: closid if the resource group
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index f11d6fdfd977..5a4d6adec974 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -187,12 +187,14 @@ enum resctrl_scope {
>>   * @num_rmid:		Number of RMIDs available
>>   * @num_mbm_cntrs:	Number of assignable monitoring counters
>>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
>> + * @mbm_cntr_free_map:	bitmap of free MBM counters
>>   * @evt_list:		List of monitoring events
>>   */
> 
> Please follow custom of existing doc and have description start with capital letter.

Sure.

> 
>>  struct resctrl_mon {
>>  	int			num_rmid;
>>  	int			num_mbm_cntrs;
>>  	bool			mbm_cntr_assignable;
>> +	unsigned long		*mbm_cntr_free_map;
>>  	struct list_head	evt_list;
>>  };
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

