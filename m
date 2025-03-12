Return-Path: <linux-kernel+bounces-557275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1565A5D649
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CBA7A30D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6E1E1C09;
	Wed, 12 Mar 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYMBWqbs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED32C182
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761071; cv=fail; b=Dc1OOPetjqB1pC3+dfBRFOA3xskfkXNdpa6fDdJf6Ru6gG9vYVUMmb9S9l8bxl61WSJEmSU27J3UXGlDsVSPQolUmhD6qoyPQPh8b3v8YoPmGY+miMqNHlCuKxn8fJ3ZxXlXGKETlTA3yxjB0EMoKcr/bduNskXHfScuR9sf+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761071; c=relaxed/simple;
	bh=E2zsSJpgZUJ0s/KVIxYgFUs5tIBEMKZY2bM6bhaTPv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DpWq38H+l2haVXBlN6OFGFWN+sivDc3++mrH6iz5z/ij/1IyiRrHRDz6JoK3pkfdI0BAWKF+GuEVFWp3YgJV7O2rexdbLKCORINPTyDDVamRh+ylsKxMGAk5PJOztXHrQY88Y3beOy+BI4phXHFYdSJAmb48z28xnEG4TyCM/9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYMBWqbs; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLJqO4jrW+W87Cayyw9n9TYDGcBvr8AKX0RnXPsw1OuWnyeCQ8HvcGNnKVV9nkNu+8TPBd6aZQVqenxxerZ7K63rqO+wPtCWVGuDytoa91RAH+LupITGLjq1xHdqLbUVMo8IYZSz+ufL+vovIZ6aAJLIstuYbu264b5S+rXh7qeMrtwb9C5gG0dEU1ndBE6Z8hgCcjYOK3WfUQyqKZElY/0d9EeZmS+JqrUygwBblS8Ya2XgBIx65fC3WyFGWe7/TBlbO3FoSS8Ab0fq2Sjx1osHi1KZEOnf4DE4H1u3yA+1R738edDvDa/s+wzmKfGE7PT28bokSHdVvKQUOVumxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhZRADHY1xEBPC9SsT8TUSw057RP2K65LqSLqcH8t6M=;
 b=Kvhc+XUeOigKZ0/3aC3rzhotaGTF8CpH0HR9JrUD7d+rTj6x/5QrVecdxTnCfmmKynLmKs2IaQPtCFxB9hKFrk4JIX1f49/P6KDZEuag8URdOTUWfkV8HAQSvJ4uvZi4BpzN/EGz4HOWHIWKRku+Bg7BjVyc3snynfVXul2CpK8Ve7iU0g0QUgQKjz3dHlkPRWkXbxzFj6VSp57cmeDL2ROKegMYFp3FqIjjwMdaBRWfetwZLrsK65e9e4Nx+OXtPFuuDl02NAozbJuIzNW0LQpjW6OwyARcSNcvn65H4kOEmOIPztUIEhY/YPyor+RyB+5veze3il395sjPYm24hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhZRADHY1xEBPC9SsT8TUSw057RP2K65LqSLqcH8t6M=;
 b=BYMBWqbsT0hlXtyDhs0ycqzApyjkqGOSq8qlK+qB+mpdsw2IdbjL+0osqvsQNhwxjEYeGtfeQ8nbonXjzLIcruAbvbEXGhNHobYGON9Ha79/pNZAPKTczj9bviqlsIzEDozjHi++eJT88WDwbEQy9wcLknlRFPsEUuPfKaNSyF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:31:08 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:31:08 +0000
Message-ID: <b5a2260f-cedb-4c8c-8435-916d657ee616@amd.com>
Date: Wed, 12 Mar 2025 12:01:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3a 6/7] perf: Rename perf_event_exit_task(.child)
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
 <20250310153742.GE19344@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250310153742.GE19344@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d56a92-30a9-43f3-b79d-08dd612f78fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVpuMkdZTGYveFhoQTdQUUk5ajJvenlvMCtJb3gyNnJpdkZXNlVHWkllYytn?=
 =?utf-8?B?WkRLRmN0bjlTOXo4YnJJekVUTjZUVXlVRmpoQVBTTEMzbUhBSFlkdjVsVnlo?=
 =?utf-8?B?d01KdzhVQnVaY3dia1BLTXliS0Z5blgyMUQxN3kybjgyY1JZQ1IxNGl5ajdK?=
 =?utf-8?B?ZTJONStGdWRFRDEyTzZ2eXAwYktEQWpjdDlXSVM0VE52WGRabjNsNmp4STZE?=
 =?utf-8?B?STRoU1o0WmVIMXhrYnVDeXV3N2U0ZUt3akgxVUdsNld0TXhmUXJBU0p1TVND?=
 =?utf-8?B?YzFKY2g2cGRDbnBRUXkvVjRONlpsZEdmM3JRWUlQWG1MZEI2c3pUb1JsOVpM?=
 =?utf-8?B?NFJCMCs3SkMzRHoyQ0dNb0ZQVG9OcVA4ODcyaXVyN25QeitBdUF5ZHRuS21w?=
 =?utf-8?B?WVY0YXhjRmt3QXN5VUFVMzdTK0ZZUS9kcEN1WTN4WEdlR1lRdWcyOXUxcVNj?=
 =?utf-8?B?bVNNMUlrbGJkai82Q29pVisrSGQ2Q1A2TDVuNlhjaVkrT0QyaFZ3enR6ZHFy?=
 =?utf-8?B?NFdpL1dKT2tXNUwyanpFNnlNaW5KbkxQbGcwR1JjSkdaOWUzQldCak1XODUv?=
 =?utf-8?B?T051cDN6UU0wUlFFVWgzbHJ2T3IxUmVYU1JpMnFCKzArdEs3dnpZN3Fvb1JI?=
 =?utf-8?B?ME02K21Dem5MZnZRQ1UyazlKZkxIQlVPMmRzRXR3eEdSMGdpejU4VXZRYk5E?=
 =?utf-8?B?YjhSZUc0UUZ3MjZnWSt4dU5IZWFSVFdIN0w3dDc3NzZtd0xLZjdDTGl5QmN5?=
 =?utf-8?B?ZEdsUGJ3bnVBejNvV2VtM21oRWlwbDBWL29sTTh5SndBaFlxVTRuYnhWeHN2?=
 =?utf-8?B?dFhkNGEzQ2Nzb29wL3l4WC83SjJBQ2JKRXVVOEk2ZTlsakhkNHduWE0wMmhD?=
 =?utf-8?B?TVhCTEZweDFlM2JCdmZjeWU1b28xd0RVcXFyak9kcTJkZ2pVaUZzUSszSTlW?=
 =?utf-8?B?WWdwVlgyVk4rZkVXMVplZksrRUozb1kwS1VyYjl5TXpDTzBTVTZNcFJBWS9y?=
 =?utf-8?B?NUVXM0hReWVuck9Bd1E1OHB1ZFMrTm5DeldkbktMdzJXY3NQb1RkWGVrcVBP?=
 =?utf-8?B?dFg1bzZ2cE1xeGZUeVdhejdYVEFSNU1yUENLSkY3bXBNRzdBU1FEUmU4dmZa?=
 =?utf-8?B?clFSUnRNYWhKQkM1TlVqOENHVVFPRkRwQmVnKzhEWGZlZmN3ODdCNm1la0NT?=
 =?utf-8?B?TUk3ODNIc2R6QmZPcVQrZ1Q1bmMwMTU1VEJzanY0NHZmT2JPRi95SlBFQkFT?=
 =?utf-8?B?dkhBQmhiZHJLVkJwSmdJTzZiRFdJN0VlQzF4d00rWTJSTUx2R0YwbkhLdnBn?=
 =?utf-8?B?OTVGWjVLdjNFd1owbTZadTNLYjNpNEZ4OHVQQlQzSzVJQ0lTSGRIeEpHL0Ex?=
 =?utf-8?B?UDBHeUFtMkRERUVoRHBkM3M0YTRLWjg0TG9KYU4zeGZhZ1N5Y0o2c3RqMXlY?=
 =?utf-8?B?Q3ZuQ25pdDRVRGdPa09NSGZ2N3FOUEFmK3ZUTlNkb0ppNWRzd2Q5TFl0ejFL?=
 =?utf-8?B?YWM3eG1zbUJzaGdhY09OeXJBNzZaaTRvSWlBd3UwRkhVRmpndGhqakh0NEVR?=
 =?utf-8?B?SW5HMkdTZDU2ZkNhTWxtam14VTBLc0IzeGNkQ2FJODNQTnlHcmtlSllDNlFv?=
 =?utf-8?B?NmdQOXpXVHBpOUgvR2NOTUlZRkplUTA1cmljcnhVUkNuUWhqS1VRRnVxaVFY?=
 =?utf-8?B?aFZaaElrNTJYTEtDOFhQWnliSkNuRlhaRFk4MWE2dE9hQVA1Q0FlaEEzcXV5?=
 =?utf-8?B?RFl2MlpIY1VFbUgrZ2lSYzNGMVZaSmphdU04U3VQT3l2d1BvMHgyb3B0V2xO?=
 =?utf-8?B?MjRjaHZBcXJwZzl4MzN0R0FOMUlodXRHcmUyS0ZBNzVtVjFOU29Qa2NmZFpo?=
 =?utf-8?Q?+VJAUGWsGcs6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjhwQ3M4SFlQYU5iQXVpd3ZLNEhjdHVtRFo3b2E4N3ZBbHd0TWdRcldUdk9x?=
 =?utf-8?B?cnB3U0w2ZE5Gb29jTHAxR0JxTVY1TjhGRVhjcnNhVnpHempZcUpsUGZBUmpr?=
 =?utf-8?B?MW9Wb0xwYzljcm5HWGJzOVlqb2xadTkxV3BJdU5MT081RHJFRHdvdHZOMDJh?=
 =?utf-8?B?ZzJoSzl3RG1HYWpKUDdaZWlvcTZ3b0tPMlltSncxWmgrQzhMMWdNT2xML0dn?=
 =?utf-8?B?cDhBYnRmWGtia0xzYWcyWkxOaWVudUtPcGcvNTNLWk1RTmcvSzN4QTZSSXRz?=
 =?utf-8?B?TUcySTlLNFYyaFRsQVN0Q3JsWjc2aDFEYnJNNkVMNll3NjZxV0dNQTd2T3B5?=
 =?utf-8?B?SXNBU0k3bUxWQXIrVnpSaFhWZkNScy9JdXRIYU5HZVQ0UnlwOXAzcDlWNWxK?=
 =?utf-8?B?SlZ2UjlrQTE1bGVOU0VyYzhSd3ErQ3p5VWNkTTNlTmRmd3dFRnBCdGo5ODI4?=
 =?utf-8?B?YUZ3UUl6QmNGdk1aNTdRcmErQTFyY09tdll3V2I1cnR5cjZDQ2J1MmxUTkMx?=
 =?utf-8?B?OE56am5SZFV1YmdPRktsdFN3eVI0Z1ZOR1ViRzBhRzhjVHlnN2l4QjRqZytH?=
 =?utf-8?B?Y1B0NFQ5VHFKemxBVk9DQmxzMVVQWUZvVUFyQW9zLy8xQzVFSWZDMkE0WG9l?=
 =?utf-8?B?YjZ0eHRyTi9pN1dDbFVKdjlvY2lRNEwyUkwybzFXVHYyTTdOdVlleVN1Zkdz?=
 =?utf-8?B?NTdxd3lIZjlCWkx3UURmcWQ4OGtsV3NDZDh5WFRCT2VmWFViUEg0NlRLT2JL?=
 =?utf-8?B?eGVwcWhHaFg3SzNoVzFuVjlNVjJJM3lUTW5aanB6R0Q4U1ZjSlFCNlovV1hO?=
 =?utf-8?B?Rkl0ZEFlZjhxaWYyQThSRkZ3ZFh4eXJZUVVaUitPT01Kc2JCM2JyNXpSdWpE?=
 =?utf-8?B?eUhBT1pBSmNVbGVSamVPMVVPVUhlYzA1cGJmOTBGbnhvQWVoRTl1RFFUTE1O?=
 =?utf-8?B?Z0xIV1lHOXc3cTRyWmZiUnpMREVZU3JTZ0M0RE5HWkMvZXB2K1JCc2NYMUlK?=
 =?utf-8?B?K1lLMEl6Wm5aY1B2T0xrYk1xdE1RNXJXVXJHYWZNQzVJc1hhRUwxZHVHSkhi?=
 =?utf-8?B?SEo3Y2FrY2g5S2oyMllCc2d6ZVBVKzZvNW05VXdHYWpCQWtyYVoyeU5iNWNk?=
 =?utf-8?B?Yzg2djdVaWNRV20rbG1oelBKYUxPRjQ3NEwzWGo2OVhlTWs4cTJQOExVV3RI?=
 =?utf-8?B?V0h2c0VlOHd1VFlaYk1NcVA5TVpmUlE4SGNUUEc4dUk1eDF6QkI0UjBmMTds?=
 =?utf-8?B?OVF0QVNVNDNoUUI5SzNQaGZpZXUvY0NiN1gxQytjR1pGcVNJYmdyUGRWTXhP?=
 =?utf-8?B?OGJZZk5lQzFQRVozcGV4eld5WUtBeVE0a0FKSlhBY2RLQkhod1BXV0lFMEti?=
 =?utf-8?B?a0IrRXFERUlMY3dkL3M2TkFFbDMzWGE0eU1qaTU2aDdlVXE5dE9lTjlYT29H?=
 =?utf-8?B?bmNvd2kzNkNpVlIvTGJxQXJEUGRTTHNuNXlEMUZYT2g1ZjFOb1M1MW45SGZR?=
 =?utf-8?B?bGpzZWo5UlhlWGlhdU55RGhrdlNaN1hqSnF1ejQ0Y25sSnovQUZJUjA0MTRn?=
 =?utf-8?B?c1hrTFJ6YjdkM3BWek5MdWUydGhRdVltMSs2SjhRb0xVUDF6UVdPaVNhMG9i?=
 =?utf-8?B?UkxIemdZRkg2MDlPR1ZITkVYNk8zQ01VSTFxenpuN3FFNmVwdnBmdy9DUE1G?=
 =?utf-8?B?eVZ3T21nT3dvWUVQbTBoblNkcjVqU2p4c0tONCt1QkNKUTF1MDhoMDBtdkwv?=
 =?utf-8?B?VFJ5MVZNYzFXNXBsallxVEg3c0J6UVd0dWRKU0FDQVE3UHF0YXhwMXQ4R1JD?=
 =?utf-8?B?MWowdWNoQjJrd2ZCR0tyWURjTnZBbk1sbEZPMnVxeEhYUUt5djRBNi9oMS9C?=
 =?utf-8?B?T245OVRnM3RBRnNjOFh5emVQWDBYdEgvYlNtenkrNzYwdjU2QWZkQW1RQWlX?=
 =?utf-8?B?MFFhUXIvTXBQb0c1R1MwTEF6NGI5TUZBT3NhOWlIdXNQREROYWJSWnFkSGUw?=
 =?utf-8?B?UGxXMVF0VkpFZm9ldURZc3B6N0kzT3A1dHBrMGRrcXoycWtxOTJQbXVKNmRC?=
 =?utf-8?B?T0g5d25pa0NOR0xUU2tadG92RExkaWdIOXlid1VWcVNkYzc5K1ByNlZIYWFr?=
 =?utf-8?Q?iPYwnUB03S88SQRqeGRgn8rKG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d56a92-30a9-43f3-b79d-08dd612f78fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:31:08.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmrIdPrmfqlrI6nVU83zxU6nxdPYroeakAxNBnu0FiZwczTydX62FgaphC8UE+9BsERA0d/L96yV6SPDPsNfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

Hi Peter,

> The task passed to perf_event_exit_task() is not a child, it is
> current. Fix this confusing naming, since much of the rest of the code
> also relies on it being current.
> 
> Specifically, both exec() and exit() callers use it with current as
> the argument.

When perf_event_exit_task_context() gets called by perf_event_free_task():

1) task_ctx_sched_out(ctx) function should be avoided because the 'ctx'
   argument is of the (half baked)child task whereas task_ctx_sched_out()
   expects 'ctx' to be the context of 'current'.
2) Similarly, 'task' argument != 'current'.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13573,7 +13573,8 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	 * in.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	task_ctx_sched_out(ctx, NULL, EVENT_ALL);
+	if (exit)
+		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13582,7 +13583,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
 	put_ctx(ctx); /* cannot be last */
 	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+	put_task_struct(task); /* cannot be last */
 
 	clone_ctx = unclone_ctx(ctx);
 	raw_spin_unlock_irq(&ctx->lock);

Thanks,
Ravi

