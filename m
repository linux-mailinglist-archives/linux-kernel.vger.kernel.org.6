Return-Path: <linux-kernel+bounces-395387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D59BBD3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B281C22BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5811CACF3;
	Mon,  4 Nov 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h4JgelaA"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C991C9ED1;
	Mon,  4 Nov 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744496; cv=fail; b=Oh9XQF/3LOx9BTxqh6cJ4JnAXmxt6VIAFrdHsMK8sFyr7ZMZFgqlZxlP14pKv9A49tKst2/4jcV7Pe7PdCJ9+ZXYS7qAKjA7vtdyqMqI6E8WMjc0iz7TbrQyqpptRPaweCRHfckAsywUtxVHoUT9LsJEloc/+QPk7qr9XjYFl1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744496; c=relaxed/simple;
	bh=k0eY/361TqgxCbZXAhaFo/2dlbvirFFM3Ly6eeZWEu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6oku4fP74Vv/Fk4e2B9XixHpHV6O7UXuU+Vodp8QGZUfJ5EcKQj42fHpV2au5eRbU98gxvmV8gJJ5LOGedrz5gKpuEMC6EDZNiXv0KPe9NRwz1f7AZbtmsCclL1HN33rdLVvJ/jyt5j9O6zSmqsE+4MNw5o1UT0wYu3MqxaSxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h4JgelaA; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYxMuO1SrjjnkVpHqKDftuNPn3vSs+wIZbOD/8TrWwsAdEx5ZqMj1WHF4ho4GZtV6ERUToYpHVNZ42JdVZN98qInF7D+C17BvLdf9SELBqGO+gE5qS+tXU5+s0kBcOghXVRjUCKFlhpVD5QpyOqtk0qoFblbk+04vlDWQrEDBUTpiVDBSGLtwGI32gNhwsRdIW/CF3M5t9YssJXHMUbF1tF6kH28AxlY55ihucDHJsGUoui5xA5/LXYNVjqQw9BOHxwRPyEZyn+YNbT7JemaMJnnD6CUGsiRBUJA5ubEt3gZKdtKEFUDuTmEm3Xm0vnrJfaO6PsVbIaC3g4SHHh5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2z/fSLpiEJPt7vAFlZGdhFmr/L2eUvuTEkFABlCA7Q=;
 b=toIdT06LV68Vdc5O63rYaXTGGoU+jzmZEVhjvO+iASfmJltMly94UCiH6//glnCcqyA2Zq2Bq0MURqj8YQFiBhHWDR6xiZ68Phb5OdwaO4lV78cnqyGbg8x326QVXptfHMKO7l4Ia6ol8WZaI6HBgHjd4tu5kRBhCV5kWrfgBjT5nsIy8uwNjy+POAUUgF9XEa0FPizCnF9uzuPc258GNE8gvsMPjjdT/UCNdxGMRcxWLyAd4PNOzVC5gRzfXb0hAk1tF5eq3uZDoQHlgzoApdCbGNl7P8S7xmSrTF0ECfVYvd+PveYl3la824YwRnraY60N58McLTWNla8MCwA+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2z/fSLpiEJPt7vAFlZGdhFmr/L2eUvuTEkFABlCA7Q=;
 b=h4JgelaApg5aiT4ldqCQGtalGia/DFUq7lTcXwtb9Oo1TRMUfLjazJIE6soB3W7+HiJh57/CbHTatzQ6NGy+6TvybeV1r2+PVUvmGnk0grl8tjjCn85L676JJa3RUmSLttfppKnTC+MGgSheOGwbC3AkovMdT3Uyda4HlTnKDjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Mon, 4 Nov
 2024 18:21:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 18:21:29 +0000
Message-ID: <6fd12815-98eb-469f-8477-0de12af29aa2@amd.com>
Date: Mon, 4 Nov 2024 12:21:25 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 19/26] x86/resctrl: Add the interface to unassign a MBM
 counter
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
 <CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0106.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 91236730-8ace-4843-3461-08dcfcfd809e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MThYL3dIVFJtRjkxaWNpNlFPUWtPS3VrcnNBVGRGbkE0bU5pNHRoZnVOT3g4?=
 =?utf-8?B?dklpWG01WFE5d3pERld0SkVIc28zd0JjdDF0amZwaDlwejZnOWJoc2dOZEdK?=
 =?utf-8?B?TXRsbmoyTGp5OGVCZm43RmpNRE5kNXZJUjEzT3o4UXdjSHRiL1UyR0VMSmxR?=
 =?utf-8?B?TVBXYk1CZHMzUVloT2xOdlNyM29Sc1ZVOFpvZUZwZXU0QkN2MVFaL1pHaVpy?=
 =?utf-8?B?S2FQUGVNREYxQjkvN2JZbDRWZjlOYkRweEZwUmFVZ2J2OStSKzg5M2x3bEZB?=
 =?utf-8?B?NUtMYVdLU2JBQ1o2aTlZNllhRkdwYUtaMVZJczVXNmN4STJNOUFMZm16MlpS?=
 =?utf-8?B?WHR0WGdPVHJnU3ZTZTBOSUhUYWJqdmhTeWY4TW9pWkRrLzdZZDUyeUx4aExZ?=
 =?utf-8?B?SW1RVmZJeElKak5ib243ZTRxTUxvbzA3eWloeTBqdzIyMzd2U1cwaVk3QW1k?=
 =?utf-8?B?UEhxN3BZaE5qTmRlNEEyNjFhRGxqNXFSRlZWTWNySnhZZUJwM2FCSmNRM3R5?=
 =?utf-8?B?em4wVE9KYjlaOTJPdjhsdGplVHNVdXVxaGZzTzlsU1Fja0RUV2FBVHM0aHBo?=
 =?utf-8?B?SFB3cUxsbzNhZGhuZENXOWlCQk1pN25FeUlSWlFNN1JwZHF2Y2NZUkRrWVgx?=
 =?utf-8?B?U0g2Ti8wMGR6cDIzWEdtcUUvQ3V5eTczcWhtamtWV2l3MEdwZzEvbGRONmNG?=
 =?utf-8?B?ZVpoZHdmWWdIVUtwL1BiVytGdzUyK2s5a3hZa0JodjIvcjQ5bU14MDZiS3NN?=
 =?utf-8?B?Z0tYQUtFS0Rua2YzN0JxdkF6SENETTk5OEppK0dseGYvOVQ0bjN0VkxsQlJQ?=
 =?utf-8?B?VS9ZcmM1cXlaWkZEUmpKVFhSWEZmaTlTVnBVUStrY1Y4NFZCKzJmSEZNdk5a?=
 =?utf-8?B?WFA0OWxCaGg5cHlMUXQ2QkVEQUdadGFOcVJrVm8vdU4yU3YwNFVoOGM1T1JS?=
 =?utf-8?B?SVlBNmgxQ1JMbVljcVEzSTljTnZzdmtsOFl5UzVGeTljTHJXUUxZbElQb2pj?=
 =?utf-8?B?LzBub29qb2tLNVJwdXFiRWxWd1I1WEZxYTBXR1V3b0VWeXNCSm9pT1NES2FQ?=
 =?utf-8?B?dE9oTlRiSk1MSU44TkFhOXc5Y3hwV2xsNitHaFdXUGViazBZMEtPLzhITmtP?=
 =?utf-8?B?T09tM2w1a0J1NVg1NTRmSWFTSjRpdmlqNnhpK1ptazQ3RVcrRXVFVUR4aWJu?=
 =?utf-8?B?VmUwYU5iQ3hCdlBxVUY0ZTNGcUlqL3BwL1Z6ajFPMi9FLzZmY093MTBCYUdh?=
 =?utf-8?B?QTMvc2RTdG45TUVWUHlPakprdVVzSTZ2eXEwTDVkZWkyNkdwZmI5NE50blQv?=
 =?utf-8?B?WUl1d2doSjJWRmROTi9nZmR6SmxhTmQ5cU5yOXFmM2hxcDVPQmFZQ1FpaFJP?=
 =?utf-8?B?cWhXcEtTK1czdHVRWS9rNmpPUzd5VVBUdnhNZjhBdTBHMytnQUNrQ2ZISzF2?=
 =?utf-8?B?bVRFa3ViT0lCMnRqb2VHeHh4V2o1M1U2aGt3OHgwekMzWmxpbzA2SitQcVN1?=
 =?utf-8?B?Q1dScGwwQXk0T3VCbnBnTVVEY1VwNlJKT0o1ZEkwYzQxUWI4MWhUektkOVdF?=
 =?utf-8?B?UXh3SUtaSStnUWhGQVh3Z3dSNUp3Si8rUDd2NkZIL05WNGNUMTFjMkVkcDk3?=
 =?utf-8?B?bHdnS0hoSHYxdTdaay9kS05VeEZIUXhaWU1PekNPWTA4ejBaSmhleXErcGNB?=
 =?utf-8?B?WUhRbkdpQTdLZWo5ZTlmc2FlcU1QV25SWnVWcXA0WXh5NnRHU2NPOTFESklG?=
 =?utf-8?Q?ly1gtzCXpxroXzPStGklIg/pOhxNB6/sT1PkZPk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2Y1L3Q4RDB4S3kzdXFLSitHVDh5TnBYcEJYK3BSK3BDRWNkV1VMd1dzMnB3?=
 =?utf-8?B?SzFRZFhRakQ1eFVwS1lSKzJKRHQzenVlR1IvbllvNDZqUXB3TFpoWGZhQjZw?=
 =?utf-8?B?ek1KeEVINUM2bEEraHlKN3VpMEJ6ekxFRDlZN1N3cUx3SzRjT1drSnl6dVRM?=
 =?utf-8?B?Q1J6MXZlYXR5bDNxTDZNVm02MjEwa0NaUS9qTldpNTBVbEhoSGRHSVpneWtK?=
 =?utf-8?B?a1RlWlFMSi84N2xjbkU0YTFORnFXUzdvaW56N3VjVFRNN2VndUQwYlJSWjB4?=
 =?utf-8?B?b2NXd3RNaFNLdmRyMzlVdzFQYTFnRmtkLzk3dHFERVlFV3UyeitzM2kwUEZu?=
 =?utf-8?B?Y0IzaGlpcVJBclpuaVBGbmpFRVVjRmNpREZScTZlWUlObnQvL2tuTW1ZQWdq?=
 =?utf-8?B?S1pkWm40UWhkMUViTnkweDlONmZDNzUrN3dpZHkwaWNDMmhZZFQydDREN2pD?=
 =?utf-8?B?QlBiMnhNN1l5NkFid2RBeUtvZDJmcCtpbjkvb1FUdHc2N0hrQzNrTzRPc0FC?=
 =?utf-8?B?cGJCSm1MR09LUlBXZjRYOEZZdy8vUVkvTzRlbVlib3JhTmpzUTNLd3Nnbmcz?=
 =?utf-8?B?RnhCTUFSdUtlSXZEcmJGbzdVa3dVK0hzQmZUYndCelRRWmxYZW82eGR1QS9U?=
 =?utf-8?B?bWRUQTg4SSsxWUc2ZElzTUpjS2MxNEVaZDU1WStwS2RTSlQ0cUx1ZW1xejBC?=
 =?utf-8?B?d2NpdURaWU5mTEFKWmxLbEVvNk0vQWpoNURQb3FpOSs5TU5QVklBaVVkVVhh?=
 =?utf-8?B?elVJZDk4ZEJ0TFF4dTROMi92dlpXMUR5OU1GRWZiWmc4TTk1Tmw2ZUpOTERw?=
 =?utf-8?B?QkE5M2RjOGJiOCt3Sm5VbFdkUU90dDU2b082VWZwZjNvcHZoOEZCQU9DUnpk?=
 =?utf-8?B?NkIwNXdGWTk4b2RJdWxOakkwQ0ZUcThuUHVpeHJoSUgreGdZcEExTW5pSE85?=
 =?utf-8?B?Z2tGcHBjU1ZpQWQzeVhyTjNGRnBoVjlLTVVLS1Y5UHg1bU9MT2M5YjUwTHhv?=
 =?utf-8?B?bU9PRzVnWFhsS1UvN3ZDaXhYby9FREMraERwbGdHTXMxaENqQWpOem8yZFJF?=
 =?utf-8?B?bWtCbGhJSTBQN21XOUViTGFFRGdyOVZ6R01uUThVcTFRK2dRM3B4Vnl6anA4?=
 =?utf-8?B?MDNIbmVhV1NvSy9jV0g3dHdzbXZPelpYVW5ONmNlWTdtQXVRdFVCSjRPT2hs?=
 =?utf-8?B?SjNFQTcxa1gxREhpRUdWR21xU3VJNWRydDJrbFRUT2l1RDVadUw5ZVNMazBW?=
 =?utf-8?B?NkNNN2pNTU8zS2xzbm02TEVyYTdWMzhwSFlTVHdRU1gydll2STBCYzdsNWt4?=
 =?utf-8?B?Q3hOMEJNN0JCaFZ5cWs2aW5YWHppYUZ3amlvUnYyYXVKN0d2WlhoUmdSdUJp?=
 =?utf-8?B?RVhqVUd5aU9uWVYySE4za3JCcmlrc3JQU2lXWnV5QkVUdW5BTDdUUVhOL0FV?=
 =?utf-8?B?UklNWUx5UlFCbmVid3YwMmcrdnFmZFRlcEtOTDllMGRKeFFNNGFsOFFIMWo5?=
 =?utf-8?B?ZmtYMDAwaisrVmozcDZ0VS8yM3dLWVJybG4ydm5pcXBSWTRYeTJ0cjdpbDRF?=
 =?utf-8?B?a014dGJxaGl6SEF3ck0wVy9TanA3ZUlEUmEwVlJlaDN1NGlzRmNyWHZaQkVZ?=
 =?utf-8?B?NkxvWjEyNjBoSWxhZEE2bmhRYmxQS3lKb2UwZXB6a0VNZ0ZHSk9VdDZCZVZJ?=
 =?utf-8?B?RlJXeEE2UFM1UmM1dGlObzBSbGJtMGw1R1lCT1ZMNzl4VHBTS0V5dy9MZW0r?=
 =?utf-8?B?L040ZEJ0Mk43WU9LUjBObTIwTmI4NGMvREsrUHdpbVpJMFVpRlNHbmU2WnF5?=
 =?utf-8?B?QUVZZUNXc3cyUFU3V1FFMXlYdWJGZmRGVDJFMlN6Mi9xeGgwbm1CdGYxd0Fk?=
 =?utf-8?B?ZUtrS1M2RGlVSnpsZS9hQlA2OUtlNFhYYnNLWGhBcC80MmxvaTl3WEdJUGU0?=
 =?utf-8?B?MlU1RkRFVE5iVTFaWkE1UStzOVlISkdlRjFwVTAwanVtT2daR2lNWTBOdFpa?=
 =?utf-8?B?M2NVY1Y5RUxrbURYdEhJdFhETjVrUlBmZGVvcERsMVhocTNxTXNJOG84VldW?=
 =?utf-8?B?bnFHK1lOenRGYzV2OTJSVUZXcjN2STNCYUhVcXpvcUtZMml5RVRVczhWblli?=
 =?utf-8?Q?fn4Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91236730-8ace-4843-3461-08dcfcfd809e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 18:21:29.6276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXVo6DHjynCzgoXgsSi/4gt0pp7HIxJwQplhG/s+h9NTWXJWJm+Wu4OmdBg1A7NW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

Hi Peter,

On 11/4/24 08:16, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Oct 30, 2024 at 12:25 AM Babu Moger <babu.moger@amd.com> wrote:
>>
>> The mbm_cntr_assign mode provides a limited number of hardware counters
>> that can be assigned to an RMID, event pair to monitor bandwidth while
>> assigned. If all counters are in use, the kernel will show an error
>> message: "Out of MBM assignable counters" when a new assignment is
>> requested. To make space for a new assignment, users must unassign an
>> already assigned counter.
>>
>> Introduce an interface that allows for the unassignment of counter IDs
>> from both the group and the domain. Additionally, ensure that the global
>> counter is released if it is no longer assigned to any domains.
> 
> This seems unnecessarily restrictive. What's wrong with monitoring
> different groups in different domains?

Yes. User can monitor different groups in different domains. But, they
will have to use different global counter for each group.

Here is an example.

#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
groupA//0=t;1=_;
groupB//0=_;1=l;

Group A - counter 0 (Assigned to total event in Domain 0)
Group B - counter 1 (Assigned to local event in Domain 1)

We allocate two different counters here.  Now we are left with 30 counters
(max 32).


This is similar to CLOSID management we follow in resctrl. This is not a
new restriction,
-- 
Thanks
Babu Moger

