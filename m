Return-Path: <linux-kernel+bounces-445124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549359F11A4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AEA2826A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F81E3DF4;
	Fri, 13 Dec 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5pfbAL2e"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438091DE4FF;
	Fri, 13 Dec 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105481; cv=fail; b=Gx9qK5b5B7FnWk82bbl96MdoZzy0c7koyHI2ZdwH85rIPDBHGtn846UOlUKalTfsHeV1cpoZ+EzFbqugRIWC94Ko0LulBNuIMzCT7ZijYopKBH1G4pJ79jWHTaIquaKoG/RGjN5kZj03p0LGWsN1omyQPCkMlTFpjM6AfLRyOi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105481; c=relaxed/simple;
	bh=dkgGzifpvQ+sXyMCfhy40RB8y68YXhHpSKHCsxs2qI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SH6FS4jfy07Bm+SfWVKgTlxkb8bmlkQ2XJezFScKs2amqo/5AaBJOaN2uCKMNYykcouuz6mycznCAXRx+8ssgZu+lfcU/wr/petb20rfGy8e9TQCI8I45nW9hPahtBPD3cVsVQV5EKKIbUkgtUiBealAfuAUYc+yHM5/ECfAg+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5pfbAL2e; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH8RKdPp/3D2HMk6AgeOMfbW1VfbvxJc9h0BnFOZpz9gAaPxkGB42ZLTw7r8PCzh9CjGYziII+EYuW3i1AE9KRsi10PkhCdYsgSSC5qRpY7EdNZArTou7mZtz727KxlbGYWxCc/v07UpgWHAWafb4bQhE2rlP0ToWluJRzvcxvkVmd/kYnOR7tAkTz06hrVoYK28vGhVdEY0vccCfNll4JqR/gK/ggpQ4khJW52QgRJ3J4242FxtHM/Ef3Frnlvxk0wPQCOImSpIybTE8ocgO6vhgV9elSnJ3wgqC6vCD2IGwPeJ7Wf3xBEdFL55eKzr/Ig5GNaQF4pC7T4TNwubAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9y3V4s5HQVVUBHQO6v8bSw67puVvC9BUgwXrdgWxG4=;
 b=tv3ie9wxwSEWS5+WxVLC3whxMO9gkhLD3By8uVOogP+ggFAiPDXl6tfV6tJrbv8P9MHSLMoOi7OtTRfJc25pXCmbmuiJKiAPh2jM6hk++LrVyCekFa/G8Pzdpst0/dEcSAa+qketl3fyYBg1KiTGcCT1idAhqb1RfPlkwUjADOrGog8l/wzUEyKAsuPOHk8OfAt4yOTgpXT9mUZ+yykini3SeucGg0NoILLn/WKvu/t/CaD/HtX6my1ctOVpu9ArHApBiDq6UvTjHXe2jNGZIq6euCgzQD/M4WK2/QPg67uh7Uf+UIMN0Md9Mrd8spFP+Vt41naj6pHDRPHoJzxKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9y3V4s5HQVVUBHQO6v8bSw67puVvC9BUgwXrdgWxG4=;
 b=5pfbAL2eynEUw/ihBtviDK1otcjW7fkGvQxatwrU0isuiKgHPxcpP1RvGO1Q9ipe5y0r59r5XpQ7Et9k+Tu4yQONpVpX8qHoVi7VUKADXI6F8Vy718TK+Lk0MAhrInFlcA+SKlQO6pI8+rUt6x31NQ+0zF1907cEuCdBVhR1CDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:57:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:57:54 +0000
Message-ID: <e43b10b7-60b0-412a-b55f-96271764faa1@amd.com>
Date: Fri, 13 Dec 2024 09:57:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/24] x86/resctrl: Add interface to the assign
 counter
To: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 peternewman@google.com, fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
 andrew.cooper3@citrix.com, ebiggers@google.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com
References: <cover.1734034524.git.babu.moger@amd.com>
 <a72e23d8fe43038cd319403ed68b657fb36e23df.1734034524.git.babu.moger@amd.com>
 <Z1tzyrUYTFR_iHuJ@agluck-desk3>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z1tzyrUYTFR_iHuJ@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:f2::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f94972d-c90d-4f8c-6dbf-08dd1b8ee7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpYaWpCNjVzbEh3NW5JV1d5UlRvQTV5bmRsT3dLS3pYak9pVFJDWmhTODky?=
 =?utf-8?B?bXJGQWx0NTdleS9haTI1VjhVbUl1MmkyRWVySWo0Mk9aWWNKR29CeHkxS2lR?=
 =?utf-8?B?d095RVpEUTNVejFFQzl4aHhURHQ1SWxiSXduUVYvVXlZM21Bb0pObWNhKzlT?=
 =?utf-8?B?SXBUZHE4aGVkelE0czhnQ2FkUDNmYXY5WVVWRitFWStwcW44SFAyT2Y3ekJK?=
 =?utf-8?B?VDcyY21hSlRLam9QcmJPNDNUQUVPQ1JyQ1VzK3RYR2tqb05HUFFiWmNES05a?=
 =?utf-8?B?ZlB6SFVaSG5xL3RQV1FScjY1eWNKNkZTL3E0aHlXR0pkVlZwSDdJSEk1RkNy?=
 =?utf-8?B?cUU0NElZeEpCdzBjUW1DK2RvdEV3SzB3TzRORzcyOW02UnRnV1dsR0xZd1Iz?=
 =?utf-8?B?ZXhrN3ZkRVRYRlZZMkNya0xXQnRGbDllSFR1RzJpdDc2UTZwd01vRHBwd3Fm?=
 =?utf-8?B?L0lzeG9WNDYwZDNhcHhTRDk2ZVZiZ1FuYzFvd2ZQeWhmbEJnZ1RlYWJycVBw?=
 =?utf-8?B?WCtIWUZQemlJaGUyRnZNTHBUck5DdnVyMURBYVIzUjZ4cDBPcXkxVm1EMThs?=
 =?utf-8?B?OFpOUmpiUzk5NVM4Wi8rV0JyYmNOSmVHRmRvQ0w5dnMyY2k1OGQ2TkkybjVW?=
 =?utf-8?B?dEdFZEFaYlBNZFBZcE54ZEd2QUZERTBjc0VSZ2U2RkI4a0ZTY3BJZHc5bjFr?=
 =?utf-8?B?R2xnZmF1V2lQTUdYZGtzZzBOb3J2aDN5TWdZVFJaOSszcGt2U2Vxa0UyUm4x?=
 =?utf-8?B?NEFVbmZCVHBKblNnR2FhbjdZaTlVUFBydlUvMnBaN0JNL29OK3JHNk50akxC?=
 =?utf-8?B?MCtKQ2JhL2xhY1gxaHJhM21Ud0NMbVM0SU1ERksrSDFFakpUMXJyM1dKRzM1?=
 =?utf-8?B?ODZ3UXRBbmdGOVpBSDZnekt2YmxSYVFHVGNMeVk5ZFY0Yko0cU04QUtiS3BS?=
 =?utf-8?B?TzFEVzlyRE41Z0dTRUlZQ05IM3VPN1BHZWUwQksxelJoSlNOOEhCM3YxZ0hy?=
 =?utf-8?B?T2dDSTFWeC96ajBSV1FSL212NjVTTXhrc0VKd05CcFc1VVJzaHBXaG5KOExz?=
 =?utf-8?B?cGVUR29XNTVZcmdBNVdaeVQyWDdyK1Nuakt5TkpRS1Z0VFJpczVpbStMOFZF?=
 =?utf-8?B?VE5sM0ZFelVkcEIrUDVia3pkc0xuei9pMGFZZ0hxY3VQcG5QKzBoUit3YmUv?=
 =?utf-8?B?S2VmcXZLNEFjb0N3eEsxV0cvZE1vL0swMWlzV2QwY3libjI0SlVadEVHUWY0?=
 =?utf-8?B?QlpjbUVmdzhOeG5NMkcxMGZhWWRRakUwNGFTZVQzaGl1WVBWdnNWam5KNHBq?=
 =?utf-8?B?b291bkpCRXlOV01ubkdmYXBiOG9sRytQcDdvd211ZWR0N0QrTTdZQnBUM1lS?=
 =?utf-8?B?b3BLL1VYTnRLc0o0czgyb0ZaMTlUeTRDMnJTZjM4UlZDeGpSTHJLakQwOWJK?=
 =?utf-8?B?ejlmMmxpYmVnQXFVUGVhQ1U3MjZhRE52dkRZT2pUd0p5aXQydldRVTVaWHIr?=
 =?utf-8?B?M3hqQjkvZzZvT3IyUDFqSnpHVjR1c2RIWWp5Q2FRaEJyb2tUbENqV0g4c3d3?=
 =?utf-8?B?b25SVGxCMGdnUnZONXVLQmU0VTR0RmYrT29jejZnc1N6QW8rNVN0ZjhycExq?=
 =?utf-8?B?N3V1VnBJVmRWUE1SdDRZWUFLRWw1bUl0UU1lWmdORmZPemhvckNYMEI2dGsy?=
 =?utf-8?B?NDRtak1KRDZGREVrUGI5SGRBNEJBTTQ5ZSsyV0RNeHpaWHNpNVBxa3lnNzE2?=
 =?utf-8?B?aEFhdHNMRndDVXl0SmtUMTNLTEt4WFpSK0dHcmIwd2orRlk1RGoycUpocHR2?=
 =?utf-8?B?Y1FvT0NMeHM3ZFNKb1N6OEJZakJaSDNZN2s2dG9uTHluSmlJUHRXbHMvSXly?=
 =?utf-8?Q?k9kdSgFf2XNrw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTBnTnRwQUxIVmNQNEdtTGgvajJYN2JURTNzTC9EeXl1VnZRbmlFalBPbStD?=
 =?utf-8?B?dlg3VXBXcTNCNm05RUlqbU0rUm1JL01NUUU2VXgyVzk1Q0E4amtDNXdzQkpw?=
 =?utf-8?B?emdnS2xKQnpNSmlXYWFKc1Zkd1A2d0VteTZOdG1hMjhxZjNtaUMwZmM3WE5u?=
 =?utf-8?B?UHhGL1A0dXVPZi90blcrMDNZUlhyY1N3S1VOVFZONXRlMkpEREhUb3FZdHA0?=
 =?utf-8?B?dk50dlZuL28xNCt5c1lsYXl6UUdqamcxNjNPOVFXTFRPaVUxS1NzTVlIdkxM?=
 =?utf-8?B?TGlWY2twODI4Vnc5VGcweXp6d1ZtZnhEVFlCUXRiencxMUVpQlhGZEwyRCtI?=
 =?utf-8?B?TDFtUStRK3hFVXlkVlA1OGZOdnhDamMwWExDbjVsb085b3RTYVRJTlhBMHgz?=
 =?utf-8?B?RHprQXk3ZWYzNW9TWkx1MkhxeDVyTnI2Q0dnbVZRTWVWSzVKTE1WdGdpTFlu?=
 =?utf-8?B?TXgxUmlLcldPNTV1cnpOdnNWQWJnWWhYRTZ1Q1E1SERVNDdmRU5XdFZObWd6?=
 =?utf-8?B?eEMveHR5bndpTjlXSXEzUi9xYkR3TmY0QmNXWTVWM25GaDZuLzdzTkZhUExT?=
 =?utf-8?B?THNjRDZ6eEp6Tko0MUtZU2JraElScUNGUmQ0OUxTQ0d2SEdDZUdHM25DSjZu?=
 =?utf-8?B?bU9wZ2V6aW4ySDlWTXVMZ0U0M1kwWldiQllsUWFZVy9hMGJPdXpkcGVEekdo?=
 =?utf-8?B?U3lyUENZL1JIblUxUFc4U3JJVHd5SkdYSHVkVlBObG16V0ttQ2RlY1dwQVhU?=
 =?utf-8?B?Vld5R21scFRRbmg0L1FxeG0xbnk0ZWNOQkdvTExScmgzOXBZQ1lVSG1VQmha?=
 =?utf-8?B?eER5QTF1UzNONUNpTXFuaS9xeklPd2NyWjdQRGhiTjhXdW0vaklXYnFtT2FV?=
 =?utf-8?B?WXBHM3JMSGFPc1QwQmxiVEVKY0ZSaTM5b2Zhekp1MXNTS250RWJ1eVAzWFE3?=
 =?utf-8?B?UGtkaW5jcHJmSUNwRm8zbFhVc1Y0d1BLdjBYNzNRdjI3c2hubHVoMVNpaFo5?=
 =?utf-8?B?MC9BVjJwWkRKekUxaEtDTTM5U2s0WU1oeUpCK2NqMzVSeHI3b2tjOThZUnRV?=
 =?utf-8?B?bGxwaUZ2R3F5bWJnNVFpSjJSUm1tRGdlY0dET2dIZjJMTHJOaGpSQkJWZWFS?=
 =?utf-8?B?UWFKaHBiUzNTRjdDblJ0aFZTT256SEM1elRHRHRRTmNRVW1wTElrWndCMHo1?=
 =?utf-8?B?TWh3NnNiOXFDcVZDR2R0QTFRZllpUzA4L0l6bFpQSTZKRTNMQjh4cjd2RXZM?=
 =?utf-8?B?bERhV0dudlRNSGR2VDEwelovb0JsOXhsR1NkK2lVRlhtaklTSFZyZzcxdHB5?=
 =?utf-8?B?T0IrbVBvRXRnRzlvTWhtSzc5QmEwd3BrY0tKYTFtNjRSdWh0aDcrRG1YM05a?=
 =?utf-8?B?dFFtZjgrekVBOU1IeXpTYjhYTmg3eStTbWdLTTM5U1JER0NQWXVZU1dFTGtw?=
 =?utf-8?B?VnJxV05QKzFoZUdTYkJETnRIWnNpczZUanV5SHNzdEtLQU5zRVVDaGFxZmxB?=
 =?utf-8?B?K0FqbTFpMmRCMFlKWGlTdjFQZE5iM3FGWXRRdUZISmYyM2pHZytwR3hXVmRs?=
 =?utf-8?B?V1hBczVPY29URldiUDV2Y3FEenltdk0xUDBVdk40UFRKVThnVDY5WEJod1U2?=
 =?utf-8?B?alRnYm5YN2dRaUNUMVFhdDIrZ21kazhiaXhlMHg4Yy93d0RDT1RveFI3UDBU?=
 =?utf-8?B?VEdwcDdCZGF4a2J4SzFTeStXWEVjQWtsaXU5OUdiK3ZOb3d0a1VIcXBnTkQz?=
 =?utf-8?B?UjNraDZXZnZDdnBjazFjRjYwVTMraDJYc1BZWGxkV1pGUFRtcWpLR1RTSVNm?=
 =?utf-8?B?NlBVNWJHQ0NNbDNrL0dlNWdDT3l4TERhL3FhQmxVQ1QvOHB3U0FxTXdHWlY4?=
 =?utf-8?B?MlJBT0lWTGVmR3VjZ29DNi9Mb25hTzQxelZwQTVFcUNkQ0dUdEV6emdKKzNU?=
 =?utf-8?B?c2dlN0NiR1J2WkdpYjRJZHZzVVBIS1ZJMTQ5c0ExOUtZbnBEMmFSWkJENlhr?=
 =?utf-8?B?MWlCUnhiWlBJaDFmQ0lOT1dqQlM4MXdGL1VGM0ZaU3BGbGhSYWwwcVM4UWUv?=
 =?utf-8?B?SGQrMUE3UlJ0Vi9rUmxOWVJ1QVZyUDBzMjdIMGdSNE55akxsWDFoNkxTWUNS?=
 =?utf-8?Q?J1GWdk7gHoSaOj9z4BKzOZZ18?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f94972d-c90d-4f8c-6dbf-08dd1b8ee7f5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:57:54.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O0xf3Hf9Du0/yToaOmOFDlOZczNR2p48ehDgmzdOQpQ6FC6mCZxx4RvO9ZIpgP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

Hi Tony,

On 12/12/2024 5:37 PM, Luck, Tony wrote:
> On Thu, Dec 12, 2024 at 02:15:19PM -0600, Babu Moger wrote:
>> +/*
>> + * Assign a hardware counter to event @evtid of group @rdtgrp.
>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>> + * else the counter will be assigned to specific domain.
>> + */
>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>> +{
>> +	int cntr_id, ret = 0;
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
>> +				continue;
>> +
>> +			cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
>> +			if (cntr_id <  0) {
>> +				rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");
> 
> Message could be more helpful by including the domain number.

Yes. We can do that. I will to use rdt_last_cmd_printf().

> 
>> +				continue;
> 
> Not sure whether continuing is the right thing to do here. Sure the
> other domains may have available counters, but now you may have a
> confused status where some requested operations succeeded and others
> failed.
> 
>> +			}
>> +
>> +			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						  rdtgrp->closid, cntr_id, true);
>> +			if (ret)
>> +				goto out_done_assign;
>> +		}
>> +	} else {
>> +		if (mbm_cntr_assigned(r, d, rdtgrp, evtid))
>> +			goto out_done_assign;
>> +
>> +		cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
>> +		if (cntr_id <  0) {
>> +			rdt_last_cmd_puts("Domain Out of MBM assignable counters\n");
> 
> Ditto helpful to include domain number.

Sure.

> 
>> +			goto out_done_assign;
> 
> When you run out of counters here, you still return 0 from this
> function. This means that updating via write to the "mbm_assign_control"
> file may return success, even though the operation failed.
> 
> E.g. with no counters available:
> 
> # cat available_mbm_cntrs
> 0=0;1=0
> 
> Try to set a monitor domain to record local bandwidth:
> 
> # echo 'c1/m94/0=l;1=_;' > mbm_assign_control
> # echo $?
> 0
> 
> Looks like it worked!
> 
> But it didn't.
> 
> # cat ../last_cmd_status
> Domain Out of MBM assignable counters
> 
> rdtgroup_assign_cntr_event() does say that it didn't if you think to
> check here.

Yes. Agree.

It is right thing to continue assignment if one of the domain is out of 
counters. In that case how about we save the error(say error_domain) and 
continue. And finally return success if both ret and error_domain are zeros.

    return ret ?  ret : error_domain:


> 
>> +		}
>> +
>> +		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +					  rdtgrp->closid, cntr_id, true);
>> +	}
>> +
>> +out_done_assign:
>> +	if (ret)
>> +		mbm_cntr_free(r, d, rdtgrp, evtid);
>> +
>> +	return ret;
>> +}
> 
> -Tony
> 


thanks
Babu

