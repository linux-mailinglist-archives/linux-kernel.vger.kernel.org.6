Return-Path: <linux-kernel+bounces-521781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41DA3C22F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB807A5DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB211F3BB4;
	Wed, 19 Feb 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLqLVcXh"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A31F3B96
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975472; cv=fail; b=rsjuivWJA2nn3Y6szt4wdp5eBAIJwD2WfWk8MrniAxbfBL2x6ddNTY2ypYZKHl5sLuNrjezJek36ykuFsP8yJNeFbTxLVKvc0T4jcqG+d5XZRNWa2Qqv+MBaArpzY7++UQKhg0CP7g8p7jH1t3TOeZfMKtOZd52VXueuj43St98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975472; c=relaxed/simple;
	bh=PHol6HKbwfsTn0K5YpPZwR/CIlUjqtCnQJClFpHqjBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U572dWAGwURy+VyXgDuqyqDwLr9mjFOupEd7fzPy0PDi0U4Wth53cxLfSfWZaz2RmN27bsXQZADDcP54XKvAIyqPZfi+tTIfoGpUD1+fDQKIZIYHg1E1Mi0P6sHEdhURbn8rq9+JE4cTPQjk7mDBPkOBYut9GVBu53BRLMkMHD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLqLVcXh; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=issgudtZMAzmKz/9mdUynw9ePK7Oq6JQKAHWCt8MZnHL16yHar0ly1lvVRpdan+woIxRw1d7TdIZgsDIsa5e1WwLj9DrRrtiSSe86JyDnR2VZ1neyJOOtskK2N3TRLql7n3YGUl6WKCJ795hDcXxDr4+yWpJd+ZmkliEStZwQ8STXC8ZTiSEIA1wLWQzDL22xl14WfQA9HKoJ8fJ27q/4wl4D0HEyYJ0obFRNeeyysWlIch0OMp2nYI27SDVpcgtVC0F4UyQ3kfdiYB/7RoNG/zSmAJcRFh8O0dXg6r+VBknmv60ddmzRAmw0R+Jv0CBW0E5cI0JSBAh+vs4rx8uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOqZ02XEMRXnnBDY7w2FzZ+uyrLptt8lFnG5eLjJ5do=;
 b=tyHO8+8ikWBaFhinXE7QiIo6G0wzVp/Wnf2HRcWweFb7FDVdnlFsjHgu8Cz20hN/fuWdHNKoJPhUONVShQuUBrYIVq+Z7IO8BGHxu46EctR/tMJmdDSKXuaMAuYAzyLbNQ5r+LY3hf66c5IL44SimVu5vG2gnRvFLlPuoagm6g2EBNPwenLKk8D9FygpRf9ngP9IfozsAwMlag7oaYTZb9uJInneT1jhpWOOBrMdW/PmqCH7iu59fyaHGmkUsl6KpM6C/Sfh0Tz8ID5YJ34X2JQsBRc2j6FQeWOVnsXKbTgVNMBEj4enYjxRTmdkkSr0QpNBzfIIhzGqTKPL3G8Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOqZ02XEMRXnnBDY7w2FzZ+uyrLptt8lFnG5eLjJ5do=;
 b=xLqLVcXhNUNowZt15dO/xj5W73jnBkOz69GYRK14msEuOnX3eE8UqJWIVAmzpFeaLdWOKeQkWN/Cd5biKXNIaVgDWP31K8I8cn4Nl0WQKACY3E3xX/3/QcYE3AvW4lAquI1Z4LbDNc1M0IOr861qXKcyzMxtbcZF21CIFQF9Nn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 14:31:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:31:06 +0000
Message-ID: <3c4ee384-6681-4de3-82e7-64022438e162@amd.com>
Date: Wed, 19 Feb 2025 20:00:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
 <20250214202438.GB2198@noisy.programming.kicks-ass.net>
 <a3b1a1fb-03a4-4f67-9f44-9157ee421913@amd.com>
 <d585f337-5ce7-4a02-b890-5f3888e59ad0@amd.com>
 <e8dfc3df-69d6-46ba-81db-4a04484fb7c3@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <e8dfc3df-69d6-46ba-81db-4a04484fb7c3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::29) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: f88ba5e6-933a-49bf-fc3f-08dd50f20b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThTRGRzeG4vZ0VJY29xWkJMYmpVVXlNL0xCZjNZWjdadjdjaVc5b3JmVUhn?=
 =?utf-8?B?TFNHa0FQa2xjVm90RWJOVVZzcEZPWnBXQjdwTFREcXJxMGEraXZLYVkyRDBE?=
 =?utf-8?B?MmNzVEJITUVMTzNFWlBRK0xsZWhuVjh1Z0oyVnRsK2pRT3J5QjdDcTZQZEs4?=
 =?utf-8?B?NFJCL0dtRys4SkZ2UkVEcjBRaUZ5NkZZWWI3bnpxWnRTdWVvYkIvR3ZJMm1E?=
 =?utf-8?B?akd2ZWkyUi92b3g1ZHhOYnRvQkQwd1UxVVAvQmIyTXpDU1NjZ0djWnZQc01Y?=
 =?utf-8?B?Mi96eFJyVkVyTzk2WmltRXQxWEdBMWIxQy9ueEw1QkY3Vjh5eVcwQzlPRnAr?=
 =?utf-8?B?aXozZmt3emNoU0lDT3J3MWc1TitqcEJqK2YxOGpXaWFGeGNtRWtTbERPbXo2?=
 =?utf-8?B?K3FOYTQ3aWxOOURxYVFrV1IzYTdjVytxUzFMLzZFeHo4cGFUNjluUkFnU3hj?=
 =?utf-8?B?TFYrOUdRcnd1NUwxb0kyakRoY0tkMzhaNEtUSkxqVmI2WGRLRTVVc1M2L0RB?=
 =?utf-8?B?cXhqK1EvQkNUTjhtVDZsVTdkcm50WUVtNE1VRW4wc3p3TkplSjU5ZUJ5dE0v?=
 =?utf-8?B?dE1ydXBTY3ZjQnR4QmgyYXlaQ2dlWXhkMEtOczhKb1VEaHhMZmdRaXNQK3Fv?=
 =?utf-8?B?anpCQlVLTjgxR3loOCsxb2VjQks3cEZpTmZaeFNGSmFPVlArOEdMTlZiVjMx?=
 =?utf-8?B?VHRhcTE3S0tCUGx6M0V5N0VuS3ZJc0QwaFJhVDNFYTRaQWVZNHFaMkZaVDUr?=
 =?utf-8?B?aktXSTZvMkdkY2pwcU0vaWhlTkwrUGhFOGxBbHZGWW00Q0M2RzNaMVZXWUIr?=
 =?utf-8?B?SHhieFJVQlU0WW40RDdGTG5TNngvMDhpaWpNbFB2dnZBUVZUdkM5K0NOTTBh?=
 =?utf-8?B?NHlJTTBZQXc2NldIQW5pVGVFUTZhQmFvOXNoVEN0RmhZVUlOZWszSEdxY0p4?=
 =?utf-8?B?bWU3WldaVnJHditJUWF3MGN4anVnR3ZodUNBNVMrR0hFbDY1RzQyT1hJV1Zt?=
 =?utf-8?B?VC9hYWlUKzAveFJyNnY5UzQ4aC90QkhLcFlScjA0YTl2Z20zRVpnZkNGK3Nz?=
 =?utf-8?B?U0d4YW5NZUR6VWNPMTd4aDlBcjF1aUltUFFvVHpFcjNlWnAweVZOMi94OVJM?=
 =?utf-8?B?QlZmeXFBUkgxaWdzNnhGQ1RnRVo4KzFFemdIMUJNOGcxL3cyNjVHQnVjcEI0?=
 =?utf-8?B?K05seisxZ0ZIU0NmQ1JrbjlZYVJ1aGdLbGJtMUFaS0Y3YmdJN0wyNldmRUtJ?=
 =?utf-8?B?NlRZdjRkSlB4b0h2cUF5Tm9kcTJoV2NTdUFZZVJqUHRUVTlrdUxMdER2dXE2?=
 =?utf-8?B?bHh3emQwTG1Ga1Mwa0l0cW1uMXVHNFBWajZIMFlqbXRUUndVU2p1WjFwVHV2?=
 =?utf-8?B?LzNIQ3NybFlHTUR2Y1JwR2VQam1oaUJTbEplV3VGR0g1bzMrZVIyM2VqNEhz?=
 =?utf-8?B?Z1EyMzZuZ2l2RzhlSENYL2NWNENGcnA5OHlWc3pDdERrenh5NmVCaGpTSmpV?=
 =?utf-8?B?M3JReDJUU042c0VuZGVXUVNCOFdlNnRiRGN5My9pL281R3NCeFlyZitGbnRq?=
 =?utf-8?B?bFI1ZGUxU0xRSXozeFpRaVJYWVNaYnBldmh5a2hueDYybjFyK25aQURKa2hT?=
 =?utf-8?B?bmJ0ejlSNTI1KzlEQjF6bFpUZFVUZ3BoQUp1aExrVCtYRmx4THJPcVd4NGhs?=
 =?utf-8?B?alVXcGh4eWg4dmdOLzRkTGlZOVpsZlBtbXZXRHNVczNTdmxrOWE2N1BQcWtO?=
 =?utf-8?B?ZDFFSjd3RmhYNEMyQ2xkcFJRZGFCRFhuQmJEN0RwVWFnelJoZWNwWC9TVThJ?=
 =?utf-8?B?cy9JTmZzYjNEbC94QzJ0cSs5cnY1bGVyeUlGUElaK0FFMVhxOXBTazlmNWhj?=
 =?utf-8?Q?IqDPiTjwjfTI/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZPbkE5NnMzSGw5L05tc01vWGtPQkhOQTBZbEJjOXBWdG5tU0VPWTlxczlV?=
 =?utf-8?B?MnVOUGtIL2pYT3d5U0hGbXBoQk1RUmlQYk9qcVNjNy9VQThyOFB3c0dIRkFS?=
 =?utf-8?B?M2pXVEdHeHdEcTRsSWtFUVYzVDB3ZmlBOTlIV21HeEdUbFpaa1NEWXdBWHhu?=
 =?utf-8?B?N3Y5K3F6Tk9TaDRXdnBvTFlnanBzV2ZEVjlVNDhxaUl0dSt5bU41czhsdWc0?=
 =?utf-8?B?cDRaRUZEa3hWNVQ5VUtwSnRLTkxRWnYyVWIwUFBaTUl5MUhYMVlMMlNHWXpQ?=
 =?utf-8?B?VTNqNWJ0Q05CZHZudndEYWVvVDFQSTRKMjcrVGF2MitMNVVpRmRCOSsvWjE2?=
 =?utf-8?B?am1xOEJwT3hEUnZkQ2tKa2dyd3ZUQmRjS0o0clo4ZmVRQWNRUVRTeXZWUjV3?=
 =?utf-8?B?K3hEY3lkcGpIamJuVlIwdDVpQlFTZUt2VnJiUDBGU09YeTNsNkR5dHJFVGpv?=
 =?utf-8?B?Q0UwRnJzUk9URjd3U1F5clN4aEorcFJ6Sk56NG45RUxGMlZPV0t1cXIvWDR0?=
 =?utf-8?B?U0lQa1hpTFEweTVKaWd5RUNFeGxWbit1TFhkby9kei9iVWt0UUxmZ1F6enVj?=
 =?utf-8?B?R2VESEJWWUoxMDI2MWw1VThIZ2RmRmtrNWM3bG9rbDd3R2ZQQjR5azFHa0h0?=
 =?utf-8?B?b2szM2dKUEs5OWVPbXVObmdmNmtzZzJuUmczSUZ1Y0RuN21aRWFMTnRrRFcw?=
 =?utf-8?B?NkRzWWE3QTI1eGYwN3g2a1kyNloyUklpOHJ5SEdYTTlCSFovVGtJV1lMSzkv?=
 =?utf-8?B?N2NzWXBIVmJCV3RvUUsvN0FwclN5czgvOHp6a0o0SzhMUXh3NnZRdFdkTGd6?=
 =?utf-8?B?SUpIVTdqNEdBSFdSSzhRVEdod2Y0SUp1MjVib0JYZ3NHWHpkRzJkNnhVODlW?=
 =?utf-8?B?TGh5ZFBZc3ZwbGpoU2cwZUJ3YzZJNDJtMHh0b1dTKzVaTHQ2OTllVFhyOFZm?=
 =?utf-8?B?OXdIS3ZmSDBLODJXamMzanQ2dUdGd3VQNkZmbTJQbWdaUW9lT1dKeDRhanI1?=
 =?utf-8?B?SVhSZjlNYS9qaUd5aEFzb2VIMnJzMnlXMnl6VmxzeTA1T3hpRTBFUExlS0ty?=
 =?utf-8?B?c1h3TmpaS2dvSFVtVjlSSEZiTjdvSGJDK3pGNWo2dkFaT01JZFNzWXhmT2V6?=
 =?utf-8?B?aGFiM29xaXd0WWxONGFiM2UvcDFCSFQ3MFRwY2p2R253NGRjRUVjb2hpZC8v?=
 =?utf-8?B?WXJSeG52WWRvbFY0Wks5UE5sYmF5SDJtQnZBS2hzN0pjbis2dTdpQVN6Ync2?=
 =?utf-8?B?NWk1TGZ6cHVIbVV1ZE1PVGNLTXBYQlFqYmhtUTVBNGJWK0Q3SWh4a3I2ZlBI?=
 =?utf-8?B?SDJuOVdVRzJUK2E2N0taakdBb1pSNHBwOHFvd3M0UjQ4L3FqYzdRMEx4Lzc1?=
 =?utf-8?B?cU4rZDM1M2VhVGkrZzE0b0FkMFpheWI1T1FRUndNZTJaM2NKZ3hzeElKOHdm?=
 =?utf-8?B?VW12M3A1ZTdFa24yQUc4T1ltazlUaTg4clV1endIbFpNV0pDc1pYNUtOcHNQ?=
 =?utf-8?B?bC9vV2ZrRStCYzVoMlNoUFoweVhmZVVTb25nMTAwSytFTWFxbjZYMm5kY0Ns?=
 =?utf-8?B?U21sa0ZOMjhEUlg0ZXA2UEwyV1RwcTdiN3VKUW1RZWdXLzBsRzZnVTBkV0N2?=
 =?utf-8?B?VVU2MzQ1bXZMZHIyOUt2VG1GQ2s2Tkw1dUJid25XT2lpTi9abWtSd1NtZDFl?=
 =?utf-8?B?MHczWGkrOWI3YklCSklaVTFmTjgvR2pwUGtkTmlLanN2a0xUcDVhRHJ0VVJD?=
 =?utf-8?B?aHR4TkFkd1p4SnZpbFJ2WTJGaHhoYjkybE5qdEFWdk5vandmUFhyWFVKOFR3?=
 =?utf-8?B?WXJIYWNNQ2R2ODlEaVI1a3Y1bXRjN3N0bnhoSWExNkpycitwZ1dDZVp6NkJk?=
 =?utf-8?B?eXh2U2pnQ1N4SXFncStSMGRCYVBqM2lJMDUzQy9uejhRVjVZNXZhVWNmMlZM?=
 =?utf-8?B?ZEhIcGJOMllqRG84bHlLN09mSzcvOGZDTE0xcEdmNXlsRTQ2dDdaQ1hLTk1X?=
 =?utf-8?B?T1c2ekRTdEpyTDVsQThjTEh6UG5lTGdKaGNna0dsV1Z3OW9zZ2lZRnRTN3pX?=
 =?utf-8?B?MXM3akdtM2xRQ3BJejJJWmk4emlLaEtPNG1aNlFHci82dUVQTE1seWoyeXNM?=
 =?utf-8?Q?xmQPd0m1T/4Xy+OFuFUPcfnu6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ba5e6-933a-49bf-fc3f-08dd50f20b85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:31:06.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nssj5usOw5srVSNFnSwK/SefIjV5GOVx+f6+JrMPUELykE0D24+GlF6KLWjURTMTn3ccULhfeMpZne4Tfq8uZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

>>>>> Apparently not, it ends up with:
>>>>>
>>>>>   ------------[ cut here ]------------
>>>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
>>>>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:286 event_function+0xd6/0xf0
>>>>
>>>>>    remote_function+0x4f/0x70
>>>>>    generic_exec_single+0x7f/0x160
>>>>>    smp_call_function_single+0x110/0x160
>>>>>    event_function_call+0x98/0x1d0
>>>>>    _perf_event_disable+0x41/0x70
>>>>>    perf_event_for_each_child+0x40/0x90
>>>>>    _perf_ioctl+0xac/0xb00
>>>>>    perf_ioctl+0x45/0x80
>>>>
>>>> Took me a long while trying to blame this on the 'event->parent =
>>>> NULL;', but AFAICT this is a new, unrelated issue.
>>>>
>>>> What I think happens is this perf_ioctl(DISABLE) vs pmu_detach_events()
>>>> race, where the crux is that perf_ioctl() path does not take
>>>> event2->mutex which allows the following interleave:
>>>
>>> This one was only with perf_fuzzer, so pmu_detach_events() code path was
>>> not invoked.
>>
>> I think the issue is, unaccount_event() gets called for the child event
>> after the child is detached. Since event->parent is NULL, unaccount_event()
>> abruptly corrupts the perf_sched_work.
> 
> A different manifestation of the same underlying issue (perf_sched_work
> is getting corrupted because of event->parent = NULL):

Duh! I meant perf_sched_events gets corrupted by invoking perf_sched_work.

Thanks,
Ravi

