Return-Path: <linux-kernel+bounces-371257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C89A38B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40511C22A59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3B18E374;
	Fri, 18 Oct 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AL8r4oqA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F1188CD8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240685; cv=fail; b=A5YSwgkxA8A9zX5g5V8jb/ro24Nf52/psJgKbyENurnS6wR9iC5oHvU2u1KSfUJMQUMWhLfhOAhhTdomyvrf/Y7NR3WTGFHdtIOPUDua33t7XvqokeYogj6z2BxIjlgDK33WhEm/goJWllzLhoUMwmKm6eYbXTl/UAi6/czH2RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240685; c=relaxed/simple;
	bh=gMIPEdeoMbZ9USQwScuchYDwAuEOMSA0ZQqw1RIGEhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hcawjoq6F7mTlOtoVQ3n3bDDaQ56LCEUAYqjcxBT4S1Vdk4yDb1ehH7vFWBByt4Uf3hvCZOgDwVugpYZHX7ygBgcGaFjl5zF8vKcFKB5UsDpnk5LiSH7QzSb2IAF8TzDZH7rZltILXKptYBOLEjv1g8NeHH7pdtAXUWD8NXkezU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AL8r4oqA; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgKeJe2bzqcGueuAijbAHcJ2Zhxarlfr8w3AoW0IIdU5MZhHHNWT6YEQjdHIGm/B63JhoiKl8RfX5S4MQeyzPHT41BJu0H+CwO6R6whKlwdqq6yMWxqGfFc8LjsED1IpX9R+rlTlu+R8xAMb8eSbaEjOKfDTufqwVh+1tAK9TbnnZcw6w4x5JbHW2nqPo7E9Ka5oJNHSM99iPQi7GonrGW8IXqI+Z+/CHwTQqKMmzNcrDABQlQgP2ZEOgLHcOvLMgizw+DK/cEh2t2OkXkGW3xURYrdeVeR/v9R6lVojwRHZ6uUQt+wZMsF2stNiFCoc5QI2+WYIQZEebLrpPg/ykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4QtVd9IIK304+8UTuc9PoruZ3ZwrbUQNHDXRH4zZA8=;
 b=x0d46s7zSCgiNLvwqB7iVZC+s3qBHPTe3cCSwrPaOaVOpk+MHznv+CTD7XpfqZjC3gvMUm5vS+mrIPoUZ1ks46SRcV2i36JP2JiC7Ht4kRDtyyZBnxmR5DvrLp1Ja0UOZcr/cEf753sLnGtroNq0+byZkK/LKUi+dS9vUSoGiCyFxbdEeTuePM9pWPwS8KVY6+NaSj4KxZEaEb3ChlsHXRKHQHdivlB++WssPqXsK7byJY8kjbcaUoHaYjC6/yfzvf2fgVZBCIr/Bi4Q49BRjNUPztRbmjZ4I3hIjcvo4hUp9di9q9vc5fuu7SLUCk6ioNzXt7MQ/4fHzuHRUCcSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4QtVd9IIK304+8UTuc9PoruZ3ZwrbUQNHDXRH4zZA8=;
 b=AL8r4oqAqwe2yqe+zZUbxXes6kxc3ZY/A08yfw2hrQAJa807oO3H0re9EixFsv9sUMdOc8HVLNMuk9/efz5Trqv0fJZ4oTjiY82WZgR7VWI2IAbRDf2urG+VwocfgOER2VGxFEcoiPgo02aUgBC3i7lP6DyYc0rYMJdl/eTebF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 08:38:00 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 08:38:00 +0000
Message-ID: <4c1198e7-00c8-449e-bbb9-7dcf15e11cfe@amd.com>
Date: Fri, 18 Oct 2024 14:07:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] x86/sev: Add full support for a segmented RMP
 table
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 480a50ff-d7c3-4a83-faef-08dcef502c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BpTnJOK2JzcVJidXlpYURvMm1PYk9RZndXaG85bURrVU5helR1SEhEVkp1?=
 =?utf-8?B?eHBsTWRKMlczVDkvaDkra2EvNTJrQXZMRHBOV2c2VlhKMkkraWZZblo0L0ls?=
 =?utf-8?B?M1NPQ1UwWmgwbUFVem5adExYbXRERDNQQXpwbWs0c09YVGdoVzRZWlNVRExY?=
 =?utf-8?B?R2JVN3hqVXIrT1pnVjF0MzB4bHhLRG13NDhQTTc4U3Q2bEtSaWxHSjRsMGUw?=
 =?utf-8?B?bnFhaitEbHdMWjlUcTVXWE14MW1tcFRFcVI5d1JxK0FUaU0wWnY4VWNWKzlW?=
 =?utf-8?B?bW8yTVhEcUhRbThwNXlFK05zeGlUWUliZGNLNkk0NmtYdHFRakI4bk1QVGRr?=
 =?utf-8?B?cXhlKzdDdThHRmdrMXhhdnV3OWZGSlRxenV4eXdLazBzTnZVZHE0ZVQyanFq?=
 =?utf-8?B?SWxjNFVzNEZpeU4vYTJuU1BKK3BSMlpINFB2UEs0QlRoNXNmR2R0Uk95T1FJ?=
 =?utf-8?B?ZWI5eEg5Y1lDV1ZOYnM4VGduMm1nWTFBY241RlVnb0hFcnU5cWRMTFhDSzRM?=
 =?utf-8?B?V3ZxSG1Wem5ONkllZmRyLzI0NE1jKzBQYUpKNm9NRU9iVGM5M2pleWpWZmho?=
 =?utf-8?B?bXJQSEhOWDRXdHVUbFc4ZWU3U0VxSk9RekhoS0l4OEo3Nkp6NTE4UHhqa3pp?=
 =?utf-8?B?clMxVFZncGdaditVNlJUdzJTSUF2Ump2MU9SdjN6b3ppYkJmNkdGNkhLOHFV?=
 =?utf-8?B?TG5oVXRmTU44YWU5Rm5KRnN1TTBVRFhzSldJb3ptanRtUkZTYm53VFppUFNK?=
 =?utf-8?B?eFdoOWFwZGhOOXVQNEhJR2ZQelJHM3VoRSs3WFJxaWhxRFJmRW5Zb3o3eVVK?=
 =?utf-8?B?bEN2Ynhudm9OSlZYZHFHZU9RY1hnWjR3UDVZbnRoQTdmZ2x4TTlyUGVNL2JU?=
 =?utf-8?B?aysyU3UyKzYzSXRWUE9lazg4UHhuZFhESFduR2J5RmRIa0JXSFNyajVpQTZm?=
 =?utf-8?B?ZjBPOGVEQlhQblNzUmJsT1pRSkFBTEYyVzVHaDNsaVFUbzJ1RGQyNExrMy8z?=
 =?utf-8?B?d2dwcmJWeEgwSC81QitnRWVXNjl6VjZLZjZQbmtJUFlCL3NtVGFoU0plbVkv?=
 =?utf-8?B?Y0JFUHZNaU1Vek5ZRGZKRnFxSk81enFLUW5hYytIMitxb0o2Wk1tbHN0SEVX?=
 =?utf-8?B?KzhsZk1yRDVMbEIvaE9BNXA3a0hBQ0NmVENGR1NheDdDZWJyWkdHZ3cxMHdz?=
 =?utf-8?B?RzRXNmpzbUZCQVQxVUZtcElkejhiZ2tyUlNoa0xEZU0vSkx0ZTZaODhlL1px?=
 =?utf-8?B?L3JwVmlBRnV6ejBpazQyMk9zdm5OekFVUnZzQTk5QXVZbTh2cW5FSUlQT2N4?=
 =?utf-8?B?bVliQ1VZaWN4ZHlUdzBDalVjaUg4SERIdFd4YnhpWlBjVGVLNklGTlpnb1lP?=
 =?utf-8?B?WjNUQ09JaFhIL29Ic0xtUzU3U25Qem1RV05kMkJGcHN1bHFyS24waTlQMUNG?=
 =?utf-8?B?VWRvVWFrT2lBWnF2eVJvZkUwbXgxdGo2aU5SSXJZYmlxQWY5ZmdGazVKTVRq?=
 =?utf-8?B?THRKb2Rscm5ZSTdhMFdCNk9TK0hkWU5vaTBMUFhCYjJobU1vNTRLQURldm5u?=
 =?utf-8?B?Q2RIWERPa1NzdjhTOEZuT2I3Y3dsTFBQVlBIL2VGUUNvOUxhNVYwS3V0K1Vm?=
 =?utf-8?B?bzlkdXNGY2ZwS1JVN1dvckRQeTdOUnNTK0oyRjRIbzFhdUNlQ0JlUERXU2lL?=
 =?utf-8?B?OUNTM0tOVnV3dE5yU3Q1NkNRTTM3QWhXUVZOeE5FbzZHaTl2bis2bHFuMDVk?=
 =?utf-8?Q?y2zxKOtVR/VnDZwlJoIezUao43a2cXuLnlh6ZFs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDlrT3U4UFV2Wit6dEdGaDBraWt0QlRzcEZsTXNrNS9XLzlhSWpsVi96Mkda?=
 =?utf-8?B?UlB4QTlGZTd1T1RGcUJ4N281NEpKYzBpVUJla3lGRWVFTHRsNU4xNUFITito?=
 =?utf-8?B?YnN3cVFtaWRQNXU0RU5aYjdtTGk2K2lJZ0VtY2FneXF5VkxnWlJ5SFJSbGNC?=
 =?utf-8?B?NDFDUkcyV2hCSE5tNmgwaXFlYnRuUm9MNHpKcXBNWHlhYlFoOERubk1KZ25o?=
 =?utf-8?B?M1pVaU9LRlg4RkdaRHpvanpVdmxya1R0M1ZsNEdJRzRVYVRKNnJXaC9LOTlF?=
 =?utf-8?B?TkgrQlZ5WVZOQkxDWVYvTmo3WGJmNnVqRGt0TGFFWUVWaDV3VXBmRjkvSnFs?=
 =?utf-8?B?cHplMndleFcxQlUwMEx5T0tDUjY1Qm9uUmdvZndiN05NLzhMSDVKazEzcEhL?=
 =?utf-8?B?UGdkNllYNC90VWF3OUJwWkJDWnVQVGdWQnJLQWhzOEo1YkliclBPV3JUUUdL?=
 =?utf-8?B?cjFWSWtsL1lQTUZVUjVRVElqOFp6b2huRWlpL3JOVHZxWW5Gd091QmtheG05?=
 =?utf-8?B?MjdZZkZIcmRHVUtvcmI3YnRtbUpPSDZmVnV1cVBFMUdudFM5eTJpdXhUbnUy?=
 =?utf-8?B?TWhHL25MaWp3dnNiRVN4SUt4eDExSEh3eEZCSnIwWHh3MFlCdGpOWFExMVRB?=
 =?utf-8?B?WFY1ejhDUnZsVXhnbkIyVU5XUWcrakU1WGtCTS80NG50Snk2c0taa3p4WnZY?=
 =?utf-8?B?bEtsRWY4UHpTOGRNOXN0RTVzdkRhaE9zWi9haTNrdHJwR1EvdlUwVC9tNEth?=
 =?utf-8?B?ajMwaHFsMjNoZEVGNEtSQVpPZEpuRW9YQ2x0ZmpkaTh1ZlNoTlp4NUNqRVQ0?=
 =?utf-8?B?SEU3MWNTbWZLNnlzVDdkRXY2M2R1SFE1V2MxRlFHZ2g3dVpsS2s3ejhjTXNC?=
 =?utf-8?B?UlZzN3Z2dXZ2NzNGMVBMWW9tbG5NYXd3Y1pDemRzdW94Y2FpNWxjMmRIblFh?=
 =?utf-8?B?NmFKeE80QmlJMmsyT042Um1KUHROaW95dWJDUTNuMmpQREhleDQ5VFJTYll3?=
 =?utf-8?B?N0tJaFhMMHJrd29lK1ZJb0g1bVAzdmxnN2xneUlWcXZ4LzRkZUt1WVE3NVJP?=
 =?utf-8?B?czhDbWFJZ3Q5SkMyQ2xKa3RGUkVrVTUxNGJvMmo4d28waXo3K1psQkJLc1Ns?=
 =?utf-8?B?NVFJTllLaFU3MmJnaTBBS09GZmlRVlpwNmpxeGZwbTlONm80b2N0WUZCS3Fy?=
 =?utf-8?B?NXduVTN2NUE2NWlmQWoxaTBGN3ZlYk5sc0VJeE5sQzZuNS94YXFobUxBZmQ2?=
 =?utf-8?B?RjUyTWlYVjNNRzk1YytKZHVObmZDOXBFR0NQZTVFYmREbG0yQ01VM0tqKytF?=
 =?utf-8?B?c3VSYWRHZHpwelh4M2c5RDNpekE4ajRaOEpCR3E2MXRZR091VWYrTE5WdEJv?=
 =?utf-8?B?MlByTCtqZlRURnYxU0NvaUJ5dzFCRU1xWWFSQkp5U3lCM3FaQU5FWWVhZGpm?=
 =?utf-8?B?UXE2Q3NUbGx2TnBlOE8xeVJnYTM0eEJzN1orKzhyMjIveEdXSG5EVmJZQVUx?=
 =?utf-8?B?eVBVSTJ5emN6S3pPZUhMU1JkYisrbU42VlhSTkdHOENoZ2pLZUxBby8rNUxv?=
 =?utf-8?B?NlU2UVZxNGwvQThDa1VZTnFTYXFQU3N2SU8vMXlHWEdTU05BWTZBZTM1SDE3?=
 =?utf-8?B?WkZlbFBIQnVucGFNRkFDLzJUMU5kT1R5dzRjYjRZbWhPUDN6MU82TFB1Rk5Z?=
 =?utf-8?B?YWxUTy9IVmxOdU5ySTgvVGJnK2tTdnVBZ1hUcnNJZFZZT092Q1EydjJDTXZa?=
 =?utf-8?B?YVZ1YkJsY0JOZk42RUtIWXUvOUpjaEplMDlsOHR1UnFCbDlmSGxvTmc4Mjlk?=
 =?utf-8?B?cU8yVTRhRkNIUk1yU20xb0hYVXg0bUthSEhESmZZVTlYRVVIcm8xVWlBa0NX?=
 =?utf-8?B?cDFRODB4YWRHVUpyeFZ5RWFnYlVuMEJVU2pqU2hUR3NpdFFsWnBMcFJGdXEx?=
 =?utf-8?B?TUlUZkptL3gzZGt1NjFvTFFzRlhBeWZsMDNJZ1ZmZ3d4aHZWQkZEVHllWlcz?=
 =?utf-8?B?M2I5RDlNVXMvWVdJcC91bVF4NXJwZjRURnhZckRhakdnRzhneHlKWmZZR2Er?=
 =?utf-8?B?SVhUR0pUd1BuVVB0dWp3eHNqaElWenRtc0JOdjR4LzNoZjROYmtoQkxMTHVu?=
 =?utf-8?Q?gBsnOQeIni2Z7oFI+15VJA+vJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480a50ff-d7c3-4a83-faef-08dcef502c29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:38:00.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFydUdJaVSEu7+e/Pbdkys7ibXSYu0ehuGL5leqoXD8b7tPu0Q6y2rTnnuBmeY0pk6aRm7I3q6JR1C9Z7OSQRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843



>  
> @@ -196,7 +203,42 @@ static void __init __snp_fixup_e820_tables(u64 pa)
>  void __init snp_fixup_e820_tables(void)
>  {
>  	__snp_fixup_e820_tables(probed_rmp_base);
> -	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
> +
> +	if (RMP_IS_SEGMENTED(rmp_cfg)) {
> +		unsigned long size;
> +		unsigned int i;
> +		u64 pa, *rst;
> +
> +		pa = probed_rmp_base;
> +		pa += RMPTABLE_CPU_BOOKKEEPING_SZ;
> +		pa += RMP_SEGMENT_TABLE_SIZE;
> +		__snp_fixup_e820_tables(pa);
> +
> +		pa -= RMP_SEGMENT_TABLE_SIZE;
> +		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);
> +		if (!rst)
> +			return;
> +
> +		for (i = 0; i < rst_max_index; i++) {
> +			pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
> +			size = RST_ENTRY_MAPPED_SIZE(rst[i]);
> +			if (!size)
> +				continue;
> +
> +			__snp_fixup_e820_tables(pa);
> +
> +			/* Mapped size in GB */
> +			size *= (1UL << 30);

nit: size <<= 30 ?

> +			if (size > rmp_segment_coverage_size)
> +				size = rmp_segment_coverage_size;
> +
> +			__snp_fixup_e820_tables(pa + size);

I might have understood this wrong, but is this call meant to fixup segmented
rmp table end. So, is below is required?

size  = PHYS_PFN(size);
size <<= 4;
__snp_fixup_e820_tables(pa + size);

> +		}
> +
> +		early_memunmap(rst, RMP_SEGMENT_TABLE_SIZE);
> +	} else {
> +		__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
> +	}
>  }
>  

...

> +static bool __init segmented_rmptable_setup(void)
> +{
> +	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
> +	unsigned int i, max_index;
> +
> +	if (!probed_rmp_base)
> +		return false;
> +
> +	if (!alloc_rmp_segment_table())
> +		return false;
> +
> +	/* Map the RMP Segment Table */
> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
> +	if (!rst) {
> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
> +		goto e_free;
> +	}
> +
> +	/* Get the address for the end of system RAM */
> +	ram_pa_max = max_pfn << PAGE_SHIFT;
> +
> +	/* Process each RMP segment */
> +	max_index = 0;
> +	ram_pa_end = 0;
> +	for (i = 0; i < rst_max_index; i++) {
> +		u64 rmp_segment, rmp_size, mapped_size;
> +
> +		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
> +		if (!mapped_size)
> +			continue;
> +
> +		max_index = i;
> +
> +		/* Mapped size in GB */
> +		mapped_size *= (1ULL << 30);

nit: mapped_size <<= 30 ?

> +		if (mapped_size > rmp_segment_coverage_size)
> +			mapped_size = rmp_segment_coverage_size;
> +
> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
> +
> +		rmp_size = PHYS_PFN(mapped_size);
> +		rmp_size <<= 4;
> +
> +		pa = (u64)i << rmp_segment_coverage_shift;
> +
> +		/* Some segments may be for MMIO mapped above system RAM */
> +		if (pa < ram_pa_max)
> +			ram_pa_end = pa + mapped_size;
> +
> +		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
> +			goto e_unmap;
> +
> +		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
> +			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
> +	}
> +
> +	if (ram_pa_max > ram_pa_end) {
> +		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
> +		       ram_pa_max, ram_pa_end);
> +		goto e_unmap;
> +	}
> +
> +	/* Adjust the maximum index based on the found segments */
> +	rst_max_index = max_index + 1;
> +
> +	memunmap(rst);
> +
> +	return true;
> +
> +e_unmap:
> +	memunmap(rst);
> +
> +e_free:
> +	free_rmp_segment_table();
> +
> +	return false;
> +}
> +

...

>  
> +static bool probe_segmented_rmptable_info(void)
> +{
> +	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
> +	u64 rmp_base, rmp_end;
> +
> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> +
> +	if (!(rmp_base & RMP_ADDR_MASK)) {
> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> +		return false;
> +	}
> +
> +	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
> +		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
> +
> +	/* Obtain the min and max supported RMP segment size */
> +	eax = cpuid_eax(0x80000025);
> +	segment_shift_min = eax & GENMASK(5, 0);
> +	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
> +
> +	/* Verify the segment size is within the supported limits */
> +	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
> +	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
> +		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
> +		       segment_shift, segment_shift_min, segment_shift_max);
> +		return false;
> +	}
> +
> +	/* Override the max supported RST index if a hardware limit exists */
> +	ebx = cpuid_ebx(0x80000025);
> +	if (ebx & BIT(10))
> +		rst_max_index = ebx & GENMASK(9, 0);
> +
> +	set_rmp_segment_info(segment_shift);
> +
> +	probed_rmp_base = rmp_base;
> +	probed_rmp_size = 0;
> +
> +	pr_info("RMP segment table physical address [0x%016llx - 0x%016llx]\n",
> +		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
> +

rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);


- Neeraj

> +	return true;
> +}
> +

