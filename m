Return-Path: <linux-kernel+bounces-418690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAED9D6459
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB852834D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DF1DED42;
	Fri, 22 Nov 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xlikbdvd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6C26AEC;
	Fri, 22 Nov 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301652; cv=fail; b=jmSHVmSEN4LHXsKQt/GRlBzVNh89EerWnd/I3af2g1rSr0fqpslxnjyqKT9ufoeTjpw7a/YMf1xIxhuQjnDWZBnOYT1/iyQsYvGMtj5tU+JN9z3NdM82DLhbHuxQX9S3M53GQUB1m9ayQsoIVTH1aMKDr89hCtdnJ8Dmnf25lvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301652; c=relaxed/simple;
	bh=0J+KettMaKNrsdaeUvXRl7TYSSh2eO+UaDeioZlKJXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZM2mR8iHnO1eeyGMML3UWhgCrOlCLryx9Q5qQErsLmt81tuTEMPQNlDJTbdLrDy4ecRB943XOQgW1cOJxjES1NF/o12xmN/5IOVUnf/jxuhEfQo1ju3wfO4DeT+syE3T4Ef2fai6n88UH6v/rDsXmP7EjpGRXIALPBuafOicWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xlikbdvd; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcJNBTHeskwJLZKrWmLJ6yNnfq8cqUk8bbX8AStJKMaZ4jBQsH8N9tVspgJXHtXq/Bs0+CrPfVsCXjgYggYY/x7yqutqd9FXvx6Q50bg/wGVhDop3nXJIAeGwKhdFY5z+NCVLgH7uZ/7yPMEPCp1RfHY8mg37z2UM2K3HtrWNn7gpscWxOUPxJQ7yqPWYmL5s9Pe9+RzS3pY/pPYfiHmv1SG70Xx/MFFhN+HOqpNKfFO47L+TG+DGbvip5XI4K5dStG9HYcdWWZ5dFmYgD0hmSSoIEFVhADI346cmJ4EFaUIYkbp6piQc3Zr4HEpMCpy9e4nfKR/VGUT0gnvDafVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+G5t8rQUP687O8DeFcxuVzgHk9LgzYxP/OSu9X5/cI=;
 b=ZY8JQtMf/gGzv3+os0DRdgUhfcXcoB+SaLXrc3dzJTm3x0TcXCYwgVLscDa34iiUDNK5/x3GMhDmAxwlU7MFfzvchKIflqaaD5DqTzRyISjbtCCbB4cnD2x+YYqmR6e9q3EsEcswuv2Ct9Td1RzZR7gn0PZwKqpZcqcziv4BhXE97QE7yzvCsPH3VAuwBrO8imIR3G7Ly+yaywratI+e0UI4Us3SRyHmu23UxHSxp+huaRHdE2TqZi5vPACnArmZ49JBDJYBIOKYBe6rsGQPjFgnHBlNjlDHoL9HFEQsycwhikvcabqvTOyrH6ckdLRwXQNdgJ75dQHADPnBwtoX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+G5t8rQUP687O8DeFcxuVzgHk9LgzYxP/OSu9X5/cI=;
 b=xlikbdvdlpChvvlJnjKM/PtJvPH9H5tTLRwIvfHWzA58mQjAXQZkineMJvM5v4/cT7FvCeQfUtd4lEXjbItpJdzBiNRBuFpptxfxHrwibCM7GB5BRSGfpvg/xBnTPHknnI8ebC4itMcM0ZELQEaKgS4Xtw+Q2FSHTJHvpkjChiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 18:54:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 18:54:07 +0000
Message-ID: <d7bbc624-75f0-4110-b459-e69dafd9577a@amd.com>
Date: Fri, 22 Nov 2024 12:54:01 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
 <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
 <a1417f89-7d07-4e9c-ace4-1248fb2f668b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a1417f89-7d07-4e9c-ace4-1248fb2f668b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:806:6f::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 565b3504-1e07-452b-d8dc-08dd0b270af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpwQXUxd0xwVk1UUThJeE9kTmxBUmZXSEV0RUkrWkUySzNnRlpVOVVKaGx0?=
 =?utf-8?B?UW9JbHRMdDNiUUJWTml0VWlmNnZZTEtzR2xwUG5neHZZdXRBWGM5eHdDTHFo?=
 =?utf-8?B?RlNkZnRUUnIwczdJb0tOOVh3T01Lay92VEJJYXE0NXU3eDE1c2NyY1hsMjVj?=
 =?utf-8?B?SG9wRGlBV1Y0ODhUejhWd21LNzR4bFRGWGIyTGhnT0NxUEs2Tlg4MzZGQ2NM?=
 =?utf-8?B?bmZncmoxRzVlVWVtQ0tFN1VTaW5VMHNwU2NkQWlBZ3RuKzRsUVlTVE1QV2pF?=
 =?utf-8?B?OE9Gc3NRNmFET2lnL0VhSjNmK0ZZQnlMWHNGRy81UnNPbHdiRXF4NkFkRy9t?=
 =?utf-8?B?MlN4QytRQ05SQ2Jhdkphc09pUnVFR1BqRy8wbW5Ha2JoOFRqODhQZGtpRzZq?=
 =?utf-8?B?dm14QStLTzc4Q1BSdXI2cUo3WDNNRTNCOW9KVG1vY3R0dWs4RU1McDZ5R28w?=
 =?utf-8?B?TExhaEYyNjRVdjl1SFU5Z2RYSzhFekdEN0xLak9mdDVXZUszRE9iSS9PL2dC?=
 =?utf-8?B?REpIQ2wvellic3NiVEZhZkdxOFFqSG9jNHNncWw0dlp4NnpkeGNtckxEZ2Ez?=
 =?utf-8?B?YVJvK1JkQnFTWVdCcVhDdFowS05LT1JHMklzL0ROQ1lQOE5tTjFoOUMzZnZ6?=
 =?utf-8?B?bGNOSXluK3lFMmQxWFVPaUZOVEtONm9rZnhmaTBXeE5WTGU3UEhPQ2lvbHJK?=
 =?utf-8?B?VHNObGZSdXZaQVVEcnFLTDROaU5CSGFOZ0UyM2RkdmkvWDErZ25zdmpsa1ND?=
 =?utf-8?B?YjlneVpadjZqTXZNRFZtR2gxSTlTYXBqc24rZUpQUytvMlNtZ0ZKcDlhVGQ3?=
 =?utf-8?B?anRmLytjd0dBTGR2MERsWlFSRFJ1ZHdKWktmV1d6SXBDQ0I5TDZpVDNmemFv?=
 =?utf-8?B?RXloRFJLdnVXcDJFVHZEQWwvbGJ1WUJMV0kxSEpOYzBzejIrR1VCak1mUTdH?=
 =?utf-8?B?UVRmL2ptaXVsVzY3MWZXSG8vOWswbnVqZGRSTDZpQ1Y3TSt4NEl5ejdleDhu?=
 =?utf-8?B?KzlBcmhYaWswZDJsN2JIVm5LdWxNblJpeWxKbWZoYnh6VVp2MGNTSEF2ZmtQ?=
 =?utf-8?B?Q0xRWTNFTEFGVmx0allSVFV1R3c3eVBOTUl0S0xDSUdnSk5kMzZjYmYydzVq?=
 =?utf-8?B?T1NWNlJsQ1Y3bmpuSDRDbUNST1M5SHU1OTNaODdKQXJ6TlYwcDlhYlJHWktW?=
 =?utf-8?B?VUgraVEwOVdQbUMwRmNtQnlydjhIQjBpeU51UEwwNXE2aGhtTGpJbzgxRHlK?=
 =?utf-8?B?MTVkYkxQNHg5R0QrbFp1WnhydG5SSzQ4cVpxZ2Nubm1xYUU5ZGtzNkxEeFJT?=
 =?utf-8?B?OGlJZ3VlbSt5c0VqRkhOaTl3SXhjT1V2M0lrT2pTOFJreE04NHk1UmJ2d1Rt?=
 =?utf-8?B?SE5pZUw3ek1xRElUTzIyaDBwK2pYQTYzclN0eVFIK25OMEpQOGdXc1BLTTAw?=
 =?utf-8?B?a0YrVDUyVkd1QTdaZVVTMFhPbTFLRGhxVGhUdTVmdG53QnhNSjlQYmNabnM5?=
 =?utf-8?B?U1FNKzFVUkpzTmVBN1N0OTBoRm9UVzZ6NzZZbGhOaUVpSHBjUUd0c1FKdk5E?=
 =?utf-8?B?Y0ZHZ1YzdTBGZTBTemVBUnR3UERSL1hzVy9UQzNFc05BVkVrU2pWNW5ubU9u?=
 =?utf-8?B?UjIwc0o5eEVuWUIycWhOTkRJeDF6MXlsZjNVVkVjUm0xTFNwWWRidFhpRlZK?=
 =?utf-8?B?K1J5Zzkvb2dKK0FobmtXbkhoazh6anJUc1Y0RzFYOEZHdDhvWGRaek9sYTU0?=
 =?utf-8?Q?kS6qYHJs4uH6KQmNn694pWY1ZCKJNQFmCP/gQnr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2gvQkdKOFpTSzUzbVpkZnM5am1pRTFFS3dqSGVBcWRhWU1QYmVTdEVUYlVH?=
 =?utf-8?B?K2lwUjBFWUJmKzl4TFF3TWJFYXN4STNrbUR1NFZMK1lOTlBQYlZHc0hCT3dv?=
 =?utf-8?B?M0VGbWZkU0IvWW1Ob05BbnhHQzZWWEwzMUd2Tm0xZUJudDhZSzFHZHpVUUYx?=
 =?utf-8?B?d2J1VW9ESzNCVFM3TWV3KzhYMkZSVEZRNi9YQWliV3pyZlpCbmY5WlRYVVha?=
 =?utf-8?B?SkI0SFBHQjJRbGdBc2hIZ2d6UEZNM2tEWXRRM21RODFoSjRzaTFTZEg1NXpL?=
 =?utf-8?B?cHBDVzNFK3ZtaWxtRFZGTm9ETE04Ujg3NGRGdFQxOXplUGdXRmhpVWxPYWpp?=
 =?utf-8?B?bDI4bGVVR0NoZ2hUL1lLNlMrYXpaK1RsYmFhQ2V1ZnF5dUJITDFFcHVhcWN1?=
 =?utf-8?B?WjQvd2tuWU1ZbDJXSmNOaFMzdFhIRmYxNjdYQmxLOGVDcm96NTJSSHJqUlcz?=
 =?utf-8?B?NjNCcUVwNkR6VlErOWwwb2xIazUrcFRIVlFQQU1NT1pqTk1QZHErNWJ0U3hB?=
 =?utf-8?B?ZDduVGI0L0hZMXJicm0xeEV5eHRLN0NXYzFWMnQvNzkzV1FyL0tYeVUvT3V6?=
 =?utf-8?B?aEF6RkF6NHh4dlhabmY1RXVkclI4Y1doeExOekQ4QjRrbDRMZUt2NWl2bXRS?=
 =?utf-8?B?SkFiSytLMzZIVVRVK0Z4OXVVdWdrbzlMYUtTL3cwWk04RDBvQTc5elladDVs?=
 =?utf-8?B?a0J4T2hpVkp3blNHRTRWMTFwQUZ2STdIL0NqSU8rVUVxalZwZjI1b0ZwOCtq?=
 =?utf-8?B?cUl3SnVjYkhsWHErK3VzU0o4RnRLVHEwdW5XaUxRVnVOaFpvdGtYektwNElF?=
 =?utf-8?B?UnQvY1FhYUFjMklpTXlXMnVJbVdmdSttM01vRkgva3ZIVnI5OEMrZGhUQ21u?=
 =?utf-8?B?M2M3Vk92Wi9sTG1DQ1l4QXJHbmkyN2hFMHJNQkU4aFJyRjkyMzl6Q2s5YXRV?=
 =?utf-8?B?RHRWY1BCclozekZrNFNyUnNRODdhR1h5TnVHODdBRnEzOWhqcU5vbGROLzVr?=
 =?utf-8?B?Tm1DQTZGTzFUaG94R2JqZXlHcyt1L2xqZnQ5a2xDUGM1NTNiZEcwOHludTdV?=
 =?utf-8?B?MWFyQzN2cVhaWmlyUG5nK0hLZG91aTlmTVZxOFl4M05oendzdkdvYlpJWnRw?=
 =?utf-8?B?OTZiRzMvNGVtZUxDa0pWZU1BcHNEZzVXaEh3NDJjd1dTRTU2UHhaZHpHK0N1?=
 =?utf-8?B?Nlp0YlNFdjRGa25qbk4yc2VGQkNwQjcrSWFBSE9CVG5PTmRPMjRkd01xN3Av?=
 =?utf-8?B?UU1od3JjNm4yM2lsV2JCQWg2aE9oTUV0VE9LU3EvN2kxdWxhWlJNWjEwY1Bl?=
 =?utf-8?B?RmwvMnBhamJqb3VhM1dVZWEyZTNVM0VEUWg3S1hBeGpmemNTbEdRNGowdWNn?=
 =?utf-8?B?bzdsVDBnRmJEQWZROEt3RFFyYlpuYnEyMXUxR0dxWWovTXljS1V1di9jVnYz?=
 =?utf-8?B?WUw0N2FCTlhrQjdBR3RCMzVFVXp1b1V6dEJtNUV2MVEwWlJCY0tnQ3hEaXFa?=
 =?utf-8?B?Q0RtSFd1VHJibklTdzdGeC9LTHUyUy9pSDZ6U2t2Q2xTam1JSjJrMlIwcmh3?=
 =?utf-8?B?MHpsQlc1Z0ZSblZtM05UUERBSmVEdE1GWmtyVjhWUVdSbCtFU0ovOFhPZjdi?=
 =?utf-8?B?T2Qzc2FGY1ZpR01LNmRGUjQyQU50d2VJOXVvKy9pelBzL3lWcG1DMW9RTHdh?=
 =?utf-8?B?SjU2WmxvMTJ1Y0QrY0VHZU1VWDRRa2ZsUmI4T1NUZ0lDS0N2STlvR2RKNWFu?=
 =?utf-8?B?K3ZPdHlxRlE2Nzg2TlFCOUtMakJMbmFSN2RFNGpTc0doelorSUhIaU9PdWFw?=
 =?utf-8?B?Z2RyY1NCUktOTUdRSzVITi9Uemc4RWtTTmRkbkxDL09MeUhnZ0RRcnJNbEdM?=
 =?utf-8?B?ZXlCLzU2MU5hbGxOcThCY1dVcytLWXBMOUtoKzRFTVYwWFdOSHRDQnB0V3U0?=
 =?utf-8?B?N1JEUjh2TTZ3ejl2b3dRcGpEZjFHdER6WmlPeXduelF6TVp6RVVsMDFCK1kv?=
 =?utf-8?B?aEhJRlk0WjdRamFWdHJEMVZYM1BvSWlTbTQ4cGxTNVNBb2hPQ2JvOUtkWXNn?=
 =?utf-8?B?SjBrNEdaUmYyV04rTmNCUndraUJONXY1ekloWjBWV1lQRG5YaW1JNWcvWDRp?=
 =?utf-8?Q?v3ns=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565b3504-1e07-452b-d8dc-08dd0b270af5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 18:54:07.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJp7Cnt+NdJZ3Z+C7TYuoZccGbbSXUUwJ8tls3PcOOX+C8Jf9fZCqrdKQ0ppORnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

Hi Reinette,

On 11/21/2024 2:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/19/24 12:12 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/15/24 18:44, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>> The ABMC feature provides an option to the user to assign a hardware
>>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>>> assigned. The assigned RMID will be tracked by the hardware until the user
>>>> unassigns it manually.
>>>>
>>>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>>>> specifying the counter id, bandwidth source, and bandwidth types.
>>>
>>> needs imperative tone
>>
>> How about this?
>>
>> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and
>> specifying the counter ID, bandwidth source, and bandwidth types.
>>
> 
> ok with me. Exactly what ChatGPT suggests.

Hmm. ):

> 
> Please do note that that first paragraph informs reader that
> a counter is assigned by user to "an RMID, event pair" while the hardware is configured with
> "the counter ID, bandwidth source, and bandwidth types". There thus does not seem
> to be a clear connection between what user assigns and what is programmed to hardware.
> 

Adding RMID in the text might help.

Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and 
specifying the counter ID, RMID, bandwidth source, and bandwidth types.


-- 
- Babu Moger


