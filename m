Return-Path: <linux-kernel+bounces-361857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522D99ADFB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D742848B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EB1D1503;
	Fri, 11 Oct 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L3kkqk9x"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E710A1F;
	Fri, 11 Oct 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681489; cv=fail; b=Mu0bobcfW0blt5FIC88qqZkeYS9wxg0lfTyRpZ2lYp3se+KBKiGM13gYFIwt932DWJ0sux9f7LpXSTfPKuV9EuEfDBBaBi3NAQ1/txRiMq6zH0inVYh4o2Ks88rxER7iDwI/67i71MC75iZ+v96X+RwR0rT6XJ8eA8PDNnA9GmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681489; c=relaxed/simple;
	bh=plfQJz7FhKU7KIPRvzxlRb6VVMa9l7SkGcBlOAuqU6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSb+HygEsOgcyNPMz82aXAnBO8Vf9koh+H//yKlgjvpGQ6TlY7xm1/mvw3QkCL5Q/rm4m94O6KXINj2nGM1eShkIiMvqQy9pIPgro3sp8ANXHbtqAPMv1PsTCljjERZHWs0/6M5Q1b6i6ZVKuZRagjC2P33y/TVhBilQ74KLB9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L3kkqk9x; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xealKuSr7D+oCiSbPtWA4Aj9jSSpynZbljbEF9oVstXHY5E3sHZOAxmTBCDqnVtyf3UsmBAIuyzotLDziwiT25705Nb0QqVRRuQvaBHact+7htJ6WJy2BQc0S1Lh9Ol3wkor7ANjhlFzdhEdgVzUvZ7WAtNVQI2cFEdi5/Q9uA1rBkZEUPLgcDZuorg/olBCb9MBSOAKHTdp6dov5DhpaLRAPO5tJozJCsE7g9ysYT1nODJaJhRe4CJSJyCJKHTHAaJpxB79/Apwb0bXoxuiSTkcNLl0sP5yHsIgVA+Ec9NQ5BcmzrwTWlrDzDwHwZL712wWsdRlDGAwfZsrScb/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1WdE4tsvQAmi5pRNjDBdOGJGGQ2S6Qok+O3ujIiApY=;
 b=fPllTa9SR0TIpw+DYjnqgF2+6nh3F+jFrwHhwPoUVIYY1t9+O2XPUgv+dQfFUUJJKbdz0rcFLp+httCiP6KnuaERpkxuMcKp2hWHzvxDqE+ER0H1mXwti0SAIxvnWJL2Y01o4E1Y+t8/LKXKLIBJ5iegLSHrWSwxLW2NU7y9+4ur0oU30LbclR5acCJjZ948FkkK0nfKza5QJzWqcUuCopdqqBtViqMWqd5RTzjuaatHhGmp9FWdU3kmGX+RtGPeKrXO3votwXveHOjUlXAtDGxhUFB2syWHZu2d7tBHCXrjaDUSxlTLtnYbewXGjDhDVms2+bHUys7Avx8P3AUHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1WdE4tsvQAmi5pRNjDBdOGJGGQ2S6Qok+O3ujIiApY=;
 b=L3kkqk9xYj8KyfWMJEuMlyLf6NZE8GobJ3+wuY0gaA8Tjnq8VxJUY5TdE56EwW2neHCnMzR1i79byyVQgleheNE+mfSirdOa4hIUPpz+J2QAYMke2tuTJEmkQ+2uziOXA7Au47GOV+77oursojpuxh298Gyva41BPxfyOaWGMy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 21:18:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 21:18:03 +0000
Message-ID: <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
Date: Fri, 11 Oct 2024 16:17:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:805:66::40) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ab4db7-3fb3-47b4-e6c5-08dcea3a3156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG5oVmFqM2s4NzA3SmhCdnByaEpMV2JXWjdGOExoWDRsUTNVNGpHY0ZaMHBH?=
 =?utf-8?B?T0pvbHg0SVNLdVVuTmdLZUt4bTE5dFgxR2w4eDJxSjlRc0xubFlCcHA2RCt2?=
 =?utf-8?B?QUM3NzJqb0hjNWZlKzBVckZEY1dRTzBJMUgwUmJxelVxbDFwdDMwYlBUNU1o?=
 =?utf-8?B?elU2enA1M28yVThOOGV3djZaMGNsYUtjNGhIeVFYT3pBMFY3cUIwNXZwb1g3?=
 =?utf-8?B?dk9VdTdTS1JqUm5DOGtnTXNzYm4xT0lodUFoM2s4UkU4YmdHZUdOTTgwbzNs?=
 =?utf-8?B?MGNxN0VNdmtvTEJWNWhCSSszSXhabDhNL2sySlZBNkY4NHozSzk4dGhyWk0z?=
 =?utf-8?B?bGFVWDFHdnQ0UjhWMVRWT0xmelltZjZiTG5kMWFjZVoxc09CYTBWTGgydjB2?=
 =?utf-8?B?UWJxRGp1VnRwUmxrNzd3WFhQQkFvQWQyR1prY2JPcGdXaVlkZ3JlM2ZON1V2?=
 =?utf-8?B?S0Y1eHJuVTZSbk9DNE96bTBmbGpJT3FRcEsxcFYrVFlBc3dveDkrdWNOT0k4?=
 =?utf-8?B?M2lNRDdMTGpNWEtWWHVhYzd4YjNOS2xhZGZFYnMyS3JCMHN6K0Z1SWM5dUp1?=
 =?utf-8?B?ZnM1VzBoUjF0V2srVTZaYVk0VDRycDgxemg1RVAvQ3NxVzBVY3pGRDFIbVZ4?=
 =?utf-8?B?akpxbXlnR0VCNEF6UU1yWklBTEh0UE9DS3BqbnM0ODFZa1gyODl2OXA1eC85?=
 =?utf-8?B?c3Q1bWJhUU9uMEloTENqQ3hFeGJmaFdnOG0vSVpEc1NBZVpnTGVUQlI3NlZJ?=
 =?utf-8?B?Y2o5d1h4cDNiYmRBMUVNSVMvSDFwSEl6YlJhYWdnWGwxdlY4SFkzbGw0Y0tT?=
 =?utf-8?B?ZTdsK2VFYStkTkMyZ1RqWmNmakdJMGgrWm9oWElScWJPUjVYZDRscHNxZHho?=
 =?utf-8?B?Y05MNnR3U2t4enNZVG5HaS9CSWdGS1pkajg4NnRUeXdwOEYvSEllb2JUb25s?=
 =?utf-8?B?MHBVV0FqSDJMd0xWQ0l3QUFDM3VNTWN3UWNDYVFIbEtXellSc3JWWUc2TGhi?=
 =?utf-8?B?a2NRaTFVajQ5OUMvT2tidTZsK1VXelptenRrWFE5S3Z3bzUxaXQxaE8zdWpT?=
 =?utf-8?B?Z1JBNDNXeXpzOFBNT215RXhWWk5LeUlvQm9LNGZGOFFWNjB2elJIa21GRFZW?=
 =?utf-8?B?QXdLNHN5UVVIU2M5WDlJRmlkUWVTZlFORlFQQ2t6OSthZ1V1TjFJMGNFTWdF?=
 =?utf-8?B?VDMzdlRvOCt6QkFxaGNxcFh3Q1JCOElaTzBMVlNQZzB5a2d4dDhaMFhSR2Yz?=
 =?utf-8?B?MHdsZjBwY0ovaVQremw0OWVTZUlDNWRPcnBQVkZXVFo4c2pjQzZYUjVRYUZX?=
 =?utf-8?B?T3R4TEtsUDBmR2QvYnZRTGdURE5UZ0taZ0l6T1h4WWw3R3F4L0ZrOUMwVlJJ?=
 =?utf-8?B?eEtJUTdzZWJKdlhZdFJqN05EQXN6R0haeDFIUDBXOVdtdElMY0xXaUpnKzRX?=
 =?utf-8?B?WklsZmpVN2hpQlRsNHk4Kzd6YzVUZmFINzVqR3VBcUluT000a0NtTHhpeThR?=
 =?utf-8?B?ZmJwOTZEMGl6RmlMZG1tOFl0QmJLODdkLzlJNWhjU21ETHhrSzdIWnBCeEVB?=
 =?utf-8?B?bFB5T3NtMUJiNWZCNUlqdy9vNjBRbHVUaUx1ZlVoMGp0NXdydUZDM0hjVUJ1?=
 =?utf-8?B?dGpyb0xqbHg5Q3BQbjZITEtiMkk4MnFFVis3ZFBCVkpaSVRlUWRuRmxVUHBD?=
 =?utf-8?B?a1NTdnVNMFZCeURMZFpJNFMyTFM2WEh1NjAyV3M4MVNTd1RCa2gvNTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUNMRHZGeFRRTExjSW5pVXBVMm1OMUcxNEJKTGM3b0J2ekxQNndwS05CNk94?=
 =?utf-8?B?WkI1eUROdWhxMjBDM3gwRS96R1VKNGovQXdvWnhTZFBFa2pzUWhqMVpvVFpi?=
 =?utf-8?B?MExHbFVlbG9jekVQMHc2RUc5aFJBeVMxcFVZSjAxYk9udWJSQWtIZ0dya0Rm?=
 =?utf-8?B?Z1FwVkdPZXkxa0xHczloQU5iMlk1b0htaUgrWDRBaEdaOS83MkFTQWoyZE1T?=
 =?utf-8?B?eHMxWUxqN2ppdFZkbEIwUm9XcUFUVVExZkhjVmMzNlhzdGRCcjdzYUdhYW9T?=
 =?utf-8?B?MSsvU29JN0RBN1VEbXJqSTg3T3d6aVpUdlArOGk0OUN4a1Aydy9URm5mVllN?=
 =?utf-8?B?a083UmxtZzVJR1c3VFNBc09Yak1NZWozOWpSdG96RHZMdHZrdzdVQlNyUC8r?=
 =?utf-8?B?YWdLd0I1bXQ3ejhVQU9FeHRtUkdTVFRWMCtISlB5ci8wWkpSVERIS0xSZ2Fh?=
 =?utf-8?B?Y3QxdUUrc2Zab3lIMENWWXcvdmdqYkEvRkFzR0ZlMmQ1d2JGWW9QZVc3SGdr?=
 =?utf-8?B?bWd0S3NvbGhKckNvQ1grUWNCejRxd2N4cFcxZm5rN3QweDZHbWNTQXpXUGtS?=
 =?utf-8?B?ZW1KT0c0ZG5WS256aEFUWEVwVmdvSk5VQjlmQ1pneURVVHdMeXZnRWNpNHNh?=
 =?utf-8?B?MEpRL3VISjRndWxVWExraDcwWGc3WEhnMFhMVlpMOUdFb1NvVGsrTnF6Vzg5?=
 =?utf-8?B?M1VqMmo4TVFMeVRPa2FhVUZHK3ErRlZVaG00NGVSb2FmRWJYczl5MWJlYnlU?=
 =?utf-8?B?VFpSamhzV2tqMnlhcFpHNEtTLzJrNXlzcVhlenpKTzl2TGtmN29ySytmY2t5?=
 =?utf-8?B?VU9QRGFKU09Xc3Z3b1IzcTRLQytUbVFHMTNqVmdIeXcrZEcvUHV3MmxTNGR2?=
 =?utf-8?B?SXlHQysrcWxkT3lWRmZVcDEzdFhvaU5TYkNTSnpqWUNPZVExdERmaGw3QXN5?=
 =?utf-8?B?dkNoOGR0NzdlNEVTL0FRSldtVjZDVzJnNHJFVlFrYlo4QlA0Qlg2YjlVaXE4?=
 =?utf-8?B?aGNJeGRRN0JkaUpqZ0VqK0VheW1BY2FqNW4xc1BZVks3Z2FIc2Nyc3ZyMmRF?=
 =?utf-8?B?YmU5T0x3dDNYOGFpZ3J2c0lSdTZabllBSCs0c21LNUR5Q0gxbFdVMm5wemVM?=
 =?utf-8?B?SlIxTVRiSEVDY2U0SEQveE9EUDVMYS9UcUEyZUJqeDJPWXI0VHUrWjFXQjN1?=
 =?utf-8?B?ZExRM2IwMGxiS3VYZlNkYUVzd292OGI3U0dWcjV5NHhTRE5tRUs0a2JhMzhu?=
 =?utf-8?B?ODdVUEx0QVptTnk3Q1pvOUZOT1U3ejFVWHNSeUtMRHVzT0dyTmluU3F1aWJr?=
 =?utf-8?B?S2cvR25uNjhuS0dIZGJqa096SnVWVUluZjl3UkRiZ1BocDc2MW5wYjl3a2wx?=
 =?utf-8?B?aytQUkQxMUdYYlRkd1JES2tJdnhJMkFBVFdUQzdWbXY0UHhXbis3VW1TNnd1?=
 =?utf-8?B?dUFGNmkrOEtiSVRJWEtSZk5Da1RHNkxySVp5Q2pDNWxaVVhoNzVJM054aTQ5?=
 =?utf-8?B?WkhEN25jWVNsTnYrbnhPOHpMRngzRGoyZk9Yai91bUttYm90OFZrbmxTN2s2?=
 =?utf-8?B?ZmZueTJUTGV5OTdxNVp6SmtLMW1Ic2tPTXplNis3QnhpakVhUDNqTVlDYkFN?=
 =?utf-8?B?N0JlZDBydHZJejBwUWtOcUJDTTA4Q0tXdWkrdHNVNnpUbkdXREN5QUdwdEZF?=
 =?utf-8?B?dmozcVJjU0dRb2oyVVpsbXVzdHdGaFBRUmZKTGp5Z2xBVWRSc2M1MlpNZWVW?=
 =?utf-8?B?bEJnMU1oNkJzREYyMGUyK2JVekt6dG40WXVrYU9vTzhPc0V0NFpTQnNOWkhB?=
 =?utf-8?B?TSt0MkZJTU9pODk4d3RmNWJoNlRWY0JWdG9tUnVYMldKWDlkamNkbktna0Vj?=
 =?utf-8?B?Y0FUVUVFMkxiYTl4NHFIblZ1NEV6V3dWY1A0MmlUNHJXNVJHNHRsRExORzh5?=
 =?utf-8?B?cE5CSm9iSXZMUUxyc2RUZnNxalZOSW1sZzlLbjhEc2d0aHNJUXpmM2ZZZ09x?=
 =?utf-8?B?R2pTRnB1WE91WVJLN2oweEJnNGRwdTUydHROYjRrQzFjWjBPZDlBNGRZRGFH?=
 =?utf-8?B?WVpENEFLWUZnZm9tY09QdG1ZN1oxL3dxVGxwL0hnSFhsTnduQkpNSU9tSHVr?=
 =?utf-8?Q?+1cQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ab4db7-3fb3-47b4-e6c5-08dcea3a3156
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 21:18:03.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4NFOXODEz8mAQBU/GeC7eUSDWmX/nwuLAQ7ai+EOE1xeKeXkBdrzoIfluPW2A+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

Hi Tony,

On 10/11/2024 12:17 PM, Tony Luck wrote:
> On Wed, Oct 09, 2024 at 12:39:44PM -0500, Babu Moger wrote:
>> +/*
>> + * Called when a new group is created. If `mbm_cntr_assign` mode is enabled,
>> + * counters are automatically assigned. Each group requires two counters:
>> + * one for the total event and one for the local event. Due to the limited
>> + * number of counters, assignments may fail in some cases. However, it is
>> + * not necessary to fail the group creation. Users have the option to
>> + * modify the assignments after the group has been created.
>> + */
>> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	int ret = 0;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return 0;
>> +
>> +	if (is_mbm_total_enabled())
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (!ret && is_mbm_local_enabled())
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> 
> This overwrites the value from allocating the counter for total event.

Total event and local events have two different indexes.
Can you please elaborate?

> 
>> +
>> +	return ret;
> 
> But none of the callers check the return. Indeed it is ok (and
> expected) that counter allocation can fail.
> 
> Just make this a "void" function and delete the "ret" local variable.

Comment below.
>> +}
>> +
>> +/*
>> + * Called when a group is deleted. Counters are unassigned if it was in
>> + * assigned state.
>> + */
>> +static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	int ret = 0;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return 0;
>> +
>> +	if (is_mbm_total_enabled())
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	if (!ret && is_mbm_local_enabled())
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +	return ret;
> 
> Ditto. No caller checks. Make this a void function. Dig down the
> call chain here. It looks like rdtgroup_unassign_cntr_event() can't
> fail, so it should be a void function too. Ditto resctrl_arch_config_cntr()

It was started a void function. In this case all the call sequence 
return 0. There is a possibility that other architectures can return 
failure(in arch calls resctrl_arch_config_cntr()). Keeping that in mind 
we added the check to handle the return values. Hope that helps.
Thanks
-- 
- Babu Moger

