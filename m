Return-Path: <linux-kernel+bounces-302560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8FD960058
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3C1C2145A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1024EB5E;
	Tue, 27 Aug 2024 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XDmGh5Mc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A06179A8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733377; cv=fail; b=JVn6HVc17CEitLrH9wiQrzmI3/C02nmhtT9uDiZCRDdzAJkZRQPg1OBXjyzm3eJO8Cyn/E+xwGIKZyE302MxBL1HKyAdrZewomuY5tBQnl9dVoEmlAhqv0OIhuyx6lcz18FNw4k+wXJSidA5OFdgz4CPgHTzRGs/v516p0w820A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733377; c=relaxed/simple;
	bh=yURnep3taWfmiWjENGefqIJ1SIc28H39M3SRkOXvl70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hu1U1qP6AqVNGJvUuXi5ZBiP6HOT5zegVqwjnODU63sOWZxUV7/ZGV+mFf8I3IT/+kKuL4397FmZJ4ld7INV9ErDsSQ53v4EIq6kS+OG38NnNfujemMc9InBLT2JdDErxaVTkJxq7geWkdDwp6t5Z3KwMIW+qeShxvewWTq/5+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XDmGh5Mc; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKFgt2smCgn0hp54XYLRSM+8Z24WWNUs76hT4hbiMcLOoCUuXuHO4oexC3gYO5Lu6UijFLyqWNHeRWPkVNZChYFGUpZKGLz90dvflHVSmnZeLeEvtil4/unXzHuMj/iw/q7CbjsqxSZDd5A8JD6GeR6eVILHcwluVlGOJkQEJjRazC293UL2UI+eA3mlnq8Z1EGIAnvn0ujLH7ii7haRLwHLeLeurUZtD30i/cnLMVJt4+0gcT5tTAuRFttDJSWvFZtnlLJpOXWtFamr4iorLtz7j00ysLcMJ5EhdEWeXWzyQSLFybP4Zb6DL6w8m8i5niaxg39UiVJSLYpBpzLZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmGy93y0/TC5A8pPebjCacP4Urz1oisBZE6ZxWWudYg=;
 b=uAekZabH2N1GmOC4hW5TUN+wNPwOPUhah8230eaL+6U14pur36gvp5SP4Ekzoz1UAhAHdbiOzWL7e/l9EF+YowmZiUpZNk8Ylh6C5j+l1yvVmGOMdYeqIperorbqv2HfNUHgQfwMkULPYhasMdGVCWEzEwi7YBjT21SdBEVWZ55Bj+BzQz8N2TjvfJwxL6LwSAsPzPkUk5XtzkfHlNKCidG+6VRdlwT1lYyaCCl7YgagrVDZ4cQFXOrZys/rMeDeQCUl6tTwIn/thOWamSOwbSGmNETlxf+ylX+I+pNRfECoAyBkZrjObDeXIhdW9sfbTMTo8n/S8galUdz03rmaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmGy93y0/TC5A8pPebjCacP4Urz1oisBZE6ZxWWudYg=;
 b=XDmGh5McCysa6YSXdoWw5vA/yrNW5FlrtqEX2TLimclB5Sty+uRQtqTtGFMmoKXUaIMSUJc9yjhR6nZdPBLEveGs/73wkrgTzbMYAMLO51ClI9MnFQkaS+sh6pEbvLeNIolH26yGby9phk21UAf8U/ABsXJZi6OQxk/WqJvBLS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 04:36:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 04:36:11 +0000
Message-ID: <721f055b-d594-4b24-b9e4-6d56475927fd@amd.com>
Date: Tue, 27 Aug 2024 10:05:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] perf/x86: Relax privilege filter restriction on AMD
 IBS
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Ananth Narayan
 <ananth.narayan@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240822230816.564262-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20240822230816.564262-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 947fd000-6cee-41e9-a13d-08dcc651c713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2h1d0NZaVdoYU1TMHVpQ0J6OWQva3hJdEVyQXNXUzViVElzQkVpQmpvS2sr?=
 =?utf-8?B?L2RNLzJJaVkwcWIxMVpNSjdmZUNRWFdyY2l4VFhLWWFVQXNSZUtPdGxPZXI4?=
 =?utf-8?B?WWF1TnlPRmpMZmRvNHFaanVUYnJjRDNTU2I3emFDNGtDdlFMdnBidzN3SVI2?=
 =?utf-8?B?YmQyOXpZUHdQY1NvS3RyRlJCeDJJdy9kWHdNQ3RWUXA1L2VoSjdXTWNzL3dI?=
 =?utf-8?B?c0FZODRiQnlmMkF1N1JvQzY5dGo5SU15M2c5ZU9ibmp0NTdteVEvTlhzZG5U?=
 =?utf-8?B?MVo3cGdaZ1JtZ3krbjBqSHp2N2xnQ1ZPSjZ3b0NjaGZOOGV0SmVsVEhjREFR?=
 =?utf-8?B?cGtEcWZ5WTd3MmFkRFg5Rys2SjlWb1dON2JUK3ptRFJENUhaeVd6M1duNkIv?=
 =?utf-8?B?aVFiQ1poQlN6UGdCSkJZUmZqbVV6TFRJdFFIWUhtSlZLVUxzcEo3TlRCbmc3?=
 =?utf-8?B?MzlVemFYVmdBZDh0SmY3RFpqMDRaZ3gwd00xSzZSK1dSZFpkUFNrajRPRUYx?=
 =?utf-8?B?dFJTdjdEdHdNc3Zicy94VGp1UHdNZzRydDh5YnRwNjRkemJsbDQ3VUZkQ3Bl?=
 =?utf-8?B?MG56eWhGVm8xZEZoT2lhdURyZjl1Q0grOUlvbUgxVWlmVy80c21xNWFENnJk?=
 =?utf-8?B?K1dxSFpoMHgvQzhKTDFrVnI4blljeGlWeEh0Q0ppN2thQmlaYVRIZFhERnIw?=
 =?utf-8?B?WmNGOWtZbTBITnZvckRyS29JTzhVYXZJaS9CbFdNK3VYTjE5aGxxUlhxdlk1?=
 =?utf-8?B?SjlpelBsSVVwdnV3N2FaS1dMdjZMcGNSaGpTMEFGWVNleGMxbjJPT1FGUTY1?=
 =?utf-8?B?b21adVpVN3pSVk4zNVRBRm9lRCtjMkFkNFdYcDRLblZSTGtoaFRudkk4dmxT?=
 =?utf-8?B?Y1d6eG9TYU5UbWJLcmJDN2VlVUxTNjRYUnZRWjliWkNMSkZBVjlHU0loUnBZ?=
 =?utf-8?B?MGs5OGpOc0cyVU9SVG1sYzVkR1F6MEgxMmU5T1VJZStOR004RGlsRklYWUZr?=
 =?utf-8?B?clFpN0JlNzkzQnJZVGFZKzRpOE92Z29haWp2VjVJTmwxM0dqczRYaDRlSDhw?=
 =?utf-8?B?RlRPRnUrTm5aenBycHJJc3RidFZnc0tvMmdFaUlrRkdMN2p0MG9vTXJOMEpz?=
 =?utf-8?B?MXFXQ3RzbmRzM2R1MG1qeE03dlI5OFZabFNkRGxFWW0wOWc2UDhaOTNUWE5m?=
 =?utf-8?B?RFlmWnBnam5EZ2M0SGpaa0dQSEo0N3dySjE4V05GcWc5ZXZhV1NPUjRMaDlw?=
 =?utf-8?B?WCtFNWtRY3dDaStpNkdqcWRzVXl2OTdsaXVZcFUrUnBYUWJQTHp5VGVCMFNQ?=
 =?utf-8?B?NEc0VjZPWWVWakR5bjEzTEI1V2NGUjh2d2ZPRm8xbUZZdmljYlB3Q2xpQ0FX?=
 =?utf-8?B?YVZSakovUFdpaURRcWlLdlhFVUw2RTJJZHBrU2pyK2duMDN5ajJ4NzczLzJS?=
 =?utf-8?B?d2grdGQzR3FhSFFYV2VNSTFhYjZDdTltMlFoMENrU2djNTFIWDFsUStHbEEw?=
 =?utf-8?B?eW5UOFpHVVJzSllrT3ZoeUdaVC9MRHdqTmhiMHkxbWVhaU1jZUpZV1RBWTcy?=
 =?utf-8?B?NUJ6R2M3QzNxcWN1RXNTaGc1eFFkd1R1ZmVOZXByTkhIQnNvRlJabHFVWFBJ?=
 =?utf-8?B?YWhIODJSYlk5TlhMZmJkY0NuMmxtTGlwTXRpME5ZeWdJMDQyN1NOL1crZDJZ?=
 =?utf-8?B?UHVtZzZESWFrQ1Z5R3hnNFZZK1NnSHJVRjR1SnRZYTFmdHduTy9OaVp5MXR0?=
 =?utf-8?B?OURlMWVSSWZWOTZJRTlMOWRyNk51Nzl1aHg2dnQzdFVOcGRTZDFSc2xubUtr?=
 =?utf-8?B?MlI1UDc1b2d2VEpmWTBrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWw2MHdLZkxEN0ViMTFISitrdUtpZTRwL1ZNcnlSRnIycUpnOUN4QWt1VVow?=
 =?utf-8?B?YkJ6NnFsUGhZVU40MWJSWmU0WFZQMVBWMW1LMFMvZDlWWlNWSnlITGJ6QUt1?=
 =?utf-8?B?cGRLeVBxcGUrM04vY2I1aUpDRDJaVVp5VklxN29DK0t0aW9nd2NsUXhWbE54?=
 =?utf-8?B?RkVjVnJTNVVMUm5CYkVBYXlYaEN0ZzNRYVBqWjhlSy9QN1VxM2NsUHVUV1dO?=
 =?utf-8?B?L3Y3M3J2dkd1dDYzZlhqclg3S2J6d1lSMGFHYkFFSFZnb3hjaVBYRDRQN3pQ?=
 =?utf-8?B?TTFvdGhKbGt2U3lUbGFCNVl4Qlk4T041YWpxWGJzYmxScTVNUXpLdEFGTERM?=
 =?utf-8?B?akU4bzNSTEZKZU0yQXNQWi92UkdzdU4yeGo2WEcra0FjT1VBUUlRZUFMLzBl?=
 =?utf-8?B?K3ZQcFdGaEx5MEhTUk53R2hHQkRucXp3Y0taKy8xcUQ0amRDWVRJM25mQTAw?=
 =?utf-8?B?eldXTTkvTlZuRi9UL3lnWFlEaGcybnl5Qm9jOEZ2ZEVORWs4blVGOWtRQ0ZB?=
 =?utf-8?B?bEpwTDl6QTVlQkErcGszd3lPVnJvKzl1YVNUMUY3azlNNlV0azNSOGNUS09Z?=
 =?utf-8?B?eHdCOGRPUzhTb0R3eVJaSHhTRlpRZ2NvR1JLLzhDelFmUitkaTFHWTJSbEtE?=
 =?utf-8?B?RUZRaTlnYXJnUmRidytYU1NNMG9Da3VuNmlNY3I3Q1FIQTg4eFN1ZTZpWjRw?=
 =?utf-8?B?N0hSWUlyZ0V3VjdnSy9ZOWV5UmNieE9GQVNRUCtDM29MbUlGdkRVdGtCUEhk?=
 =?utf-8?B?aHhnUnFMTUhKRm42OEZsS3FaL2ZPTkRWRVptOTlpRmlmVEh4V2xMaWJoOVZJ?=
 =?utf-8?B?d010N2R0MytnTk5pLytrMk1JUVpRSVNTOGdGQ0E3czZIdGl0eUhoYWVPODdJ?=
 =?utf-8?B?bXkzaWlXN1Y5U0k5a3l0c3dxWmZWazNaZGpCdUwzdjB4YmM4QktsUUVDYy9q?=
 =?utf-8?B?Y3hraHZ5K3lyYURQK2xrTTJOZFdIenVvcXFud3JQcnUxUC9pcitLK01PaDYy?=
 =?utf-8?B?aXBsUm9MRXdvdlZTL2JXV2FSU3MzL3F0S04rQXdYeU8yVUNUOS9KTHFpaTZH?=
 =?utf-8?B?VHRjREhmYXN5cEw5ajJIS21GL0xmY3ArdDdueGRaMFh5UWg3aVM3WURsSWFr?=
 =?utf-8?B?NmJaTzlXdlZ3VmphRmZXbk84R2NxTmZ4STB2S3orMEZ2VTJXSkdPZnVjZU9R?=
 =?utf-8?B?ZjdWa1pzdndNYTNmWTF4TWNFOFNONTI3UDFuRGVqQ0RLSjc3Vm9RUHBHZFBQ?=
 =?utf-8?B?L0t1ZFJ2alMxZnh4SGZvc2NtU2dRNElwcnRUZjg5ZzNnbk9WOFNZY0FNL213?=
 =?utf-8?B?U0d4WTNFRTlIalduanM2MTlwcm9GRFFtRmhtaWV5N3EwRTNRVFQrU2FwaXNu?=
 =?utf-8?B?cDF3SVhDaGg1Wkh3M0R1U3BCY0pXREs0MW4yRUN6S3ByRTJrT3BveXNOWm5N?=
 =?utf-8?B?ZXI0TVp5cnF2MDVudUEyWGFkblQyRnd4bG55elZJYWtHMk5WdFVzTWgxL1RT?=
 =?utf-8?B?bm9heVpHYWxEVzdjY0NFU0xuQ0I1RndyTFV4T3k2SGFiSkZTSkltVjVGc0p1?=
 =?utf-8?B?U0ZncVRrQVI5dWQ4enlMWEFRUmtRdTJJdFVBc3VRcjBzcmN2dGRNK2FLS0tX?=
 =?utf-8?B?NzFWd0RJS214cGxhaWYwSmtiVmlTMlNiMjhrSUtkVXJaWVp5dWNGUEpiZ3o5?=
 =?utf-8?B?c2dsWTF2TVRVbzVIL3Fmd2o1VVlKSXBIamdCa0tFNVY3dGtaWmIrRGJ3bDl0?=
 =?utf-8?B?WG1kWENkTU5USjcyeSt4ZzJhZzNFWmlnWGxhS3dhS0xnNXdyaEM5Q21nT2ZX?=
 =?utf-8?B?Wm1YS0F2YTVVSldxWURVaE9uTmNmaU9ZUm1kTjlxam9aeWFYcGxIRGZjZ0hk?=
 =?utf-8?B?c2paaDcrZzRkQyttTmNkL0toYjQ4c1FXRFg0aE16eE4yV1Z5d0pkSFBYZG9r?=
 =?utf-8?B?aXJBL0ZXV2hOTVF0U1N3K1Bhb2dBQlF2RCtaV3hVckpWY21kb0w4T3V4MXJJ?=
 =?utf-8?B?TTI3MUVSbXh0c1JWRUJtSUpDZ01hVkR2ZWE4b0JOeXZ5K3dpWXZURjJZTVg3?=
 =?utf-8?B?QjdORllsSGxzOVEyem5ubWR1cEI0S1Y0YXREN2xMM1VLRmZQRUVubkVnZlI5?=
 =?utf-8?Q?6EnRHVNYmvHlj7WElG6itmmJ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947fd000-6cee-41e9-a13d-08dcc651c713
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 04:36:11.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL7iwt2wL+Ndjlbf8G3gS0YTko5pG60pH5Epiv+uhvvpKRzVCbe//v9+rgnRFuTIoJV6V724sXEvIWtUpZ/Zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

Hi Namhyung,

On 23-Aug-24 4:38 AM, Namhyung Kim wrote:
> While IBS is available for per-thread profiling, still regular users
> cannot open an event due to the default paranoid setting (2) which
> doesn't allow unprivileged users to get kernel samples.  That means
> it needs to set exclude_kernel bit in the attribute but IBS driver
> would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> we want and I've been getting requests to fix this issue.
> 
> This should be done in the hardware, but until we get the fix we may
> allow exclude_{kernel,user} in the attribute and silently drop the
> samples in the PMU IRQ handler.  It won't guarantee the sampling
> frequency or even it'd miss some with fixed period too.  Not ideal,
> but that'd still be helpful to regular users.
> 
> I also think that it should be able to inform the number of dropped
> samples to userspace so I've increased the lost_samples count.  This
> can be read with the PERF_FORMAT_LOST (perf tools set it by default)
> so I didn't emit the PERF_RECORD_LOST_SAMPLES for this.

Samples are discarded not lost. Should we count them as lost?

> I'm not sure if it's acceptable since it might be confusing to figure
> out whether it's because of a lack of the ring buffer or it's dropped
> due to privileges.  Or we can add a new record format for this.  Let me
> know if you have a better idea.
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/events/amd/ibs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e91970b01d62..6f514072c440 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -290,6 +290,11 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* handle exclude_{user,kernel} in the IRQ handler */
> +	if (event->attr.exclude_hv || event->attr.exclude_idle ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
>  	ret = validate_group(event);
>  	if (ret)
>  		return ret;
> @@ -667,7 +672,6 @@ static struct perf_ibs perf_ibs_fetch = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSFETCHCTL,
>  	.config_mask		= IBS_FETCH_CONFIG_MASK,
> @@ -691,7 +695,6 @@ static struct perf_ibs perf_ibs_op = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> -		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSOPCTL,
>  	.config_mask		= IBS_OP_CONFIG_MASK,
> @@ -1062,6 +1065,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	if (!perf_ibs_set_period(perf_ibs, hwc, &period))
>  		goto out;	/* no sw counter overflow */
>  
> +	if ((event->attr.exclude_kernel && !user_mode(iregs)) ||
> +	    (event->attr.exclude_user && user_mode(iregs))) {

Should we use kernel_ip() instead? That would be accurate since RIP is
provided by IBS hw itself.

user_mode() relies on CS which is captured at interrupt time, not at the
sample capture time, and processor might have switched privilege mode by
the time IBS interrupt arrives. We might need to fallback to user_mode()
if ibs_op_data->op_rip_invalid is set.

Wondering, should perf_misc_flags() also switch to kernel_ip() ?

> +		throttle = perf_event_account_interrupt(event);
> +		atomic64_inc(&event->lost_samples);
> +		goto out;
> +	}
> +
>  	ibs_data.caps = ibs_caps;
>  	size = 1;
>  	offset = 1;

Thanks,
Ravi

