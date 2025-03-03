Return-Path: <linux-kernel+bounces-541037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2EA4B7B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDD13ACEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965B1DED52;
	Mon,  3 Mar 2025 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m5b0jDSK"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC11DDA3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980389; cv=fail; b=HvwSFuji5iohK/41B90g88Q+NKOGYc3jzC+UALJvAmTRBknagmD+p7GCPk0H+8cc9mOuBCrzHZlnf/Jg7LqZHQiMz/tPtBmQVCxtKTV253tPP0E/+rdOwzuTo1588nCwoS3N7mQga/Nl7RzBVt/kLnKdmx55WV070MIEtlB4bLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980389; c=relaxed/simple;
	bh=Lyshc6M/95YaCZtki+AgQPBwg7EEGL7NMiRZpoo2Y+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DN+Y9AjsC4SNAL+aTpUJip8ICz/JXJwDBo8L7x0EQYDX54rE+dWLGQo+tg7hSG93/Vsaj+5OGE7ADx1zrSlEPjzWwoLJkvLJtbzoisPDfsk0CHkXZWFEQxVJriadUd6yJDDI/bNSBQp+WLBlqB37ozPl8aDcRl11pfAHooz5T7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m5b0jDSK; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhOGevYYc13v7fYikDkGLCwbTe2u1kD4MoKb4KDMMJW/cyDwSwD3uyNPZ7MFSQhJpwRIvTqNzOhYPMkepO7IC3ROWfbZs4/2NikE4UEVTw1YVIXjmrrqgWnfyl71TodGGo4ZWv7P6MDNy/fGVhcmeeqyzYNe5omJ0ZqgbQMNZ2AgoPErxzRt1TlmakHWl4o+AcuB+KRzYTDaU2GCSxadNZybWk0T5iJUJcO6Z105+b+byuX+l6uM7vXuarT17H95BTvoapP1R0y+mLJKxqfR/if5ZzkmEbz1VlgHBPyA15V2Evc4WOz5oyBIMS783QDHC9HSw09XcT74xHyLiy19XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX7kMqUyDCNwNA36sUaVgEradOUzPjdleAuggbA1F8A=;
 b=JV6+tLZHNbXHM8TSARJlkEkkgxvSWksbLK6uzxXaf6xxjMOV6NY/rVkGjVmMBrh48XqVy6LnphfNe1z9VkZ4bQvmWxKReyuwJAGfpURTAHj6zCAKCqVFYkm+JtiW8ToBV9kWuL5jFAyMhjwm/b97dcD7ZzpGe+Cn5tSWkAEhdk/PjFGWHiJ0E6FUZ/eknbqu30AMJq1fx4jtQZLbLj/wHZwGIO3hLx/vNuK1/N3VzEr+exc99kGBWrIEESQejjxhByTskaRGZ3N/QMTCxqhkeaCFtYBUsF0q3olkCGLu5uvJ5B2fM6zz+6slyqR03R4QVPiQQLJV8wKD3umvMKP6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX7kMqUyDCNwNA36sUaVgEradOUzPjdleAuggbA1F8A=;
 b=m5b0jDSKDrxNY0zrUlfQzal+3PBIlFIQZiqSxkzb+z3ysE8lpg5cqTU43GS1FyFlN6EcxCNpxpq7mWelJnyX14HdGfUDNVVrid2++J3yCPocnLjN+ZiDoveOipMqVXeGkVrU6ZiZ6w0rRgNyDJVXu9CGKa2DD2qe+4VQPO8t42g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 05:39:45 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 05:39:45 +0000
Message-ID: <932e26ff-0654-442e-b6a9-166a7da03fd7@amd.com>
Date: Mon, 3 Mar 2025 11:09:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/24] perf: Simplify perf_mmap() control flow
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, mingo@kernel.org,
 lucas.demarchi@intel.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.350989371@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250205102450.350989371@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: b48ee0e3-0ad1-4e25-c9b3-08dd5a15cd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWNBOUIwZUNsZmRSazhOZU9aR0NaYXltSTZEcThwTEE4YUsxNjZHQjk1UkIr?=
 =?utf-8?B?aFlJa3RYTUxGR2hHaWU4L1hIc3VJUUpBNlFYZlNZZHZJSXQrRU96ajk0Ynd2?=
 =?utf-8?B?QktZb3J2eDlqcjhGMk15M0lWRlFiWGJqZk5PenNieHNjUkhRN0NyMzhhdEds?=
 =?utf-8?B?TlZ1ZzVlRHBBTWNZNC9Ib2FLeWk0UHlSYWlPbndQbm1icTNDRkg4MVprU2Vx?=
 =?utf-8?B?VHFkN3FLUkY1UXc3clJVc1Ivc2ZqbVVTQnZRdGdXRHRxUkdJTy96bXpmQzlO?=
 =?utf-8?B?ZmxpQmo4cjdSZkR3ckFGM1IxNHVMUUptSmdIbk9MbnhQUEdINS9WKzErdi9n?=
 =?utf-8?B?Y21RcnROSDRqeW4vdDZ2dVM5Tng5cFY0VHZLYWJtUHJ1VmwxVnhHcm9FVG05?=
 =?utf-8?B?RTdTeHp3V0NJTHdpdkN5dVJMZWhMRjAwbFQvNkJGckZLK29hTVowSkpsNExp?=
 =?utf-8?B?ZlBUS3YwOFBGNG00aFhKamxQanBkOW91d3EybkdFRzZBL1dmWEV4UFFQRit4?=
 =?utf-8?B?Qno2YnFYMmh6d3JsVGNKbnUxNGxnRkM3V1NFWm5Rbk01QWh5aUc3QVlycjlC?=
 =?utf-8?B?VkxJRmZnWTF4K3JIbFVIeGZxMExucjEyV2lFL3BqNE4raFNRUDBMMmtyeGFQ?=
 =?utf-8?B?Ry9QUEdzcnlvWUhqZ1I4ZjQydzZ0cFJxVXNmcW9tUGZQYnA1alBzdnkvMFky?=
 =?utf-8?B?MFJ4STlNUUVwWUlnUHJXdGxvZnFhVWpjeXVUMmhLU01jSVF0YU5aZzBMNTlM?=
 =?utf-8?B?RFF1TDJjN2o4M2ppbzk0SDZGOW03WmQzU0kvS0FRa0xOT0JGY0pPUTA0a1R1?=
 =?utf-8?B?ZkpZY1lJZzZZY0pqR1FMY1dqYklpaythL25hejhKeFdudkluQ1dkS1dKYU9S?=
 =?utf-8?B?c1czSStSc2swc2FkUGtUQkxaL2VmbEt5c1M4aGcyeXpVeXhYSGVDd3FXN2pZ?=
 =?utf-8?B?R2lnTnZLWGdLU0lJaDk2aFZzakRoejBKSXpTanA2b2x1YjQ3dEFrcDlGcERi?=
 =?utf-8?B?NVlhaFJidzFwMENmVlI1WS80NWhMbXRYdmdxOXVTb2J3Tnd5ZzJ6ZUI2eG9Q?=
 =?utf-8?B?OVFROThNUzVkTjdQUVVuMlBnZmRRUi84WTQ1clVBVEcvTEVET0FPTkdnWC8v?=
 =?utf-8?B?RUsxWTdNK3luL0pIaXpHUzFVa3ZROFpNb1A0d1ZGdHcweTNhQk5oZGo2Wk5F?=
 =?utf-8?B?WDRCZXI1Q1lmWEFZL3c1Vy92aU9pbFFtMEVabmlZeVhUd1pySjVNNmMrZ1kx?=
 =?utf-8?B?ci9pK3JXRm11amxJYVMyeEZRM2lhdWZaYTAvcS9pYmdrdjQxRysyY2pCWUxH?=
 =?utf-8?B?TEFHb1ladVpTSE1wTG9oeStMc3dnS2pBbmRrOVFFMU5Mc2dPdngycU50Q1Zt?=
 =?utf-8?B?aEVMYzlhcGk3VWNpbWVkY1NSWmZuK1FGck41UmdpbUo2L251VTd1bmI0TnBX?=
 =?utf-8?B?U2RDeFlEVTM1VWhDdzhTUGJzbEh1TUVkUmFIR0ZZSnhweVYrZjZoQWNvR2k5?=
 =?utf-8?B?b2xQSExOUTV3NkxuTjluQlBLMnd2dDRhV3pZS2FNUFhZL29FRmR4RHNFUVNB?=
 =?utf-8?B?YzRuYytTUCt0dytpNXMxaHZmNGdVMVlxLzIwK2tTbTA3YnU0RmE2Q3FOZ3JP?=
 =?utf-8?B?dG5RRzIvWmhlUWpzaWx6Tm41NGNFcDV6RHE5bTZDc09iemhQWmU4M1d1aDNh?=
 =?utf-8?B?dUViZjBTTE5QdWF5SXFnK2diRUhnaEdPcVlmM25yaWRqZkhnbjFqamxSUmZV?=
 =?utf-8?B?L2NVZmlRcWEzdzhtZnFEQ0NCOHVoZVo4RFBxUVd5UUR1bzBlaW55UzRsMENI?=
 =?utf-8?B?L3lWSkNjQ09la0ZiSloyRmZkYkdvZ2UyZmovQjVVajRuVlU2UThzMUxhOUU5?=
 =?utf-8?Q?1yJ5OQvehJRLQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHdXSlJWNWtKbWVtVXU5Si9NWDI2NUZRUzFKVlFneEdnOGxXK04yWENab2l2?=
 =?utf-8?B?WEN5Z2JkUnJLY3BpQ1FHNHFaOWpaSEdqMjExSjdudE5Nc3gvbjdwYzZlb25H?=
 =?utf-8?B?dGg2TXVRbnpIYU9WbmliakZxZ2xlQUFZZG9SYnVNbEtyWEFpS29UUDdMcTNq?=
 =?utf-8?B?RkJrNG5MZ0pSMVVjUVlkRG5lempRanFMOHg2clNNODdDUEEwc2RKUmhoVDNU?=
 =?utf-8?B?b3hXdm1TNWhFb0xxbm05aUwxQnc1NmFrSjVEb2RmWENQUzRFMEFBVGdvTmZC?=
 =?utf-8?B?NEs0ZjdQT0M3MUp5WVdpeXJEZjg3VVdIWURkZ3NjU3ZBcHhicTdUdnZMSTRr?=
 =?utf-8?B?aWRPdTUvVnV6bXFvdG0xZklOeGtTUFhDTHVKanpxcU9mWHdjNUJmUTNMMDFj?=
 =?utf-8?B?TTk2Ym55WGdndk1JUFNaVFRPbFZvUEJORDdUaUVzeUUvMG1GUzhnRysyT1hs?=
 =?utf-8?B?MmpPWnpWZWFuU1pubTNMRHMxOXc5MTc2dXdjOG1PdURTUVc4bis4ejdxaElT?=
 =?utf-8?B?Zloya2lnRGVQaTBDZEhMZE83Qkl3bFdXREE0K1FSZGZnMTJ6b293MmI0Vktk?=
 =?utf-8?B?RElTU05lRHZxa0FqQVNxVUVhOFlmTXBMdURWNlNTaG5BWjZ5NHpEKzFFRUhr?=
 =?utf-8?B?akc5cjRrWDFwWnRpa2JvTTlHZWE5dWIzL2lDaCtobGw0b2U2R2g5VG5zYzNo?=
 =?utf-8?B?MHNqcjNWRmt4RkNncThkT0lSODBDUEFvNW1uNXU0UUJQSFFZaHp1bEFYakhE?=
 =?utf-8?B?NUR6NXB4SWUyR1FTWXhrSlVhb1hVa3ZYUmxtMlZQYjBBeFBQcDJOazVOM3Ru?=
 =?utf-8?B?RmtVL2l5VzNhVEtBT3ZZMnZWSFU4UXNRVnQ3SHU0dkFoS3o2clN5elJIei83?=
 =?utf-8?B?dTlUUm1uTG5LalhscHh2TG9SRVVHa0ZYQnZZbGZOdG9XdlliSmNIRktQcGtW?=
 =?utf-8?B?UmMrV2lmbVNkNXBUNWRrYjNQUFdUcU5OZmFxbms5K2MwMU1TNForaFNTUHcz?=
 =?utf-8?B?QUxoZjArQ1BhMXpLcHo0dVBkc1pjNG9TWVVDekJVWERieDhoRVp6dzhzN2w0?=
 =?utf-8?B?YW9PRFBSUlRRcVhGWTVrVmJ3cDVxek5LWVhCbUUzam1OY1piTG53TXZtZnN3?=
 =?utf-8?B?U3BJNEJnZHYwSVJXcEtLbkNHVTN3M3BTTlIxT2FBWlZhS2NDWE1BeVU0Z0ZL?=
 =?utf-8?B?WkxxaFpoZjgrbHJvWFFZRFZ2TFlDcW9PR3hNRUJ5VmZ3UmNvZjZ1Ym9EeDdi?=
 =?utf-8?B?YVZvRmkyMW1tZG5XcWQ5bFI0ZTgxdmhXOW9CL0Nuc3B0aHZKMWJSeE91aWwv?=
 =?utf-8?B?dFJHN0tNUU12NVQ3K2NEWUlnaGFOalNsdGVlZjJkN05oa3l4eUZWelhwT3p0?=
 =?utf-8?B?cytWdllJS2VyUFgyQjZqTjQ0STVCNjdvTHErV2JhQUlOSjhDbjdNWUR3Wk92?=
 =?utf-8?B?TTlMaElFVjBFd08yV2J3anlSVkdXczVuZ3EwbHJuNUNDZzZhN1E3VTVORXE3?=
 =?utf-8?B?ck9MZEdncDdyVmdSUjJFNkgzTy9VQzJuMWd1TkFmY0VPa3JpMExISm5GSndG?=
 =?utf-8?B?akt3L0tDeHpqUTZHU2F0WjhTbUpGK1JYbTF0NE04TUlUd3EzMVNZbjZ0d0lJ?=
 =?utf-8?B?RE1nRzJ6TXg1ZnY2OFBRUXNYdm0veElKckorcHRZeDc3a0JKMWY0VlJRVXhE?=
 =?utf-8?B?NlFtTzZWdTNRSjU3MG16MDFDbTJqcWdyTk9hcFA2b1BRK1FFNy9ybm9tbWph?=
 =?utf-8?B?NEh2MG1jMEZVNWgyNDRZUWZhci94TFZIUWtkZE0rS3o2K3pWMUoyeGlIYXFY?=
 =?utf-8?B?ZWluY0VmekkvUS8xamg1d2g3V3J0Q2RnZkNTWDFCejdMOTFrRkxrSm4zdjNn?=
 =?utf-8?B?TXNYbXpLcnpNT1BzVU5NTWZia1B2SVB0SXkrNUVLSlpCaExCbUlmYy9weE5y?=
 =?utf-8?B?SHVISGRwRlQxR2YvOFpjSVh2SE00MmRpVytUVENUWHdmL2J5OE9XQzQrZnF5?=
 =?utf-8?B?dy9RTmx1TlB6VTgySHBkMGJsTUlOQlRRWGVWbks1RllYTVBlcnE1cVJNTVk2?=
 =?utf-8?B?VmtmWGNLdG1CMm5UcktQMjE2bURxL2YvUTk3emV1NGlDT0dGYWI0NTlGM09P?=
 =?utf-8?Q?G9TkuRGFtpPng82cR3JUeDV1W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ee0e3-0ad1-4e25-c9b3-08dd5a15cd8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 05:39:44.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBPU9xoHqb8Z+pRVifyMnnQeJ23kndAyUxyQuQcu7rAEWScP4X+L3brqumSL21b3qv954zDMnT5j2MJiKZnDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

Hi Peter,

Minor nit below:

> +			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
> +				/*
> +				 * Raced against perf_mmap_close(); remove the
> +				 * event and try again.
> +				 */
> +				ring_buffer_attach(event, NULL);
> +				mutex_unlock(&event->mmap_mutex);
> +				goto again;
> +			}
> +

here ...

> +			rb = event->rb;
> +			goto unlock;
> +		}
> +
> +		user_extra = nr_pages + 1;
>  	} else {
>  		/*
>  		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
> @@ -6723,47 +6758,9 @@ static int perf_mmap(struct file *file,
>  
>  		atomic_set(&rb->aux_mmap_count, 1);
>  		user_extra = nr_pages;
> -
> -		goto accounting;
>  	}
>  
> -	/*
> -	 * If we have rb pages ensure they're a power-of-two number, so we
> -	 * can do bitmasks instead of modulo.
> -	 */
> -	if (nr_pages != 0 && !is_power_of_2(nr_pages))
> -		return -EINVAL;
> -
> -	if (vma_size != PAGE_SIZE * (1 + nr_pages))
> -		return -EINVAL;
> -
> -	WARN_ON_ONCE(event->ctx->parent_ctx);
> -again:
> -	mutex_lock(&event->mmap_mutex);
> -	if (event->rb) {
> -		if (data_page_nr(event->rb) != nr_pages) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -
> -		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
> -			/*
> -			 * Raced against perf_mmap_close(); remove the
> -			 * event and try again.
> -			 */
> -			ring_buffer_attach(event, NULL);
> -			mutex_unlock(&event->mmap_mutex);
> -			goto again;
> -		}
> -
>  		/* We need the rb to map pages. */

                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This comment should also go up. Keeping it here is misleading.

> -		rb = event->rb;
> -		goto unlock;
> -	}
> -
> -	user_extra = nr_pages + 1;
> -
> -accounting:
>  	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
>  
>  	/*

Thanks,
Ravi

