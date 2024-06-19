Return-Path: <linux-kernel+bounces-221511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D8490F4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA08328376E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC96155730;
	Wed, 19 Jun 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qnwupr/h"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053613C676;
	Wed, 19 Jun 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816597; cv=fail; b=N0GJwxqfK8rmOEh+09Qs35c+ZLiRmHI0WOZnQuYvVgVqiWcWt91V5UdPjr/GTKvgwKoxisSkkWBXEvltmu+hOAurH6c9SeLRiCEu5NRllU8PEfTjBghH5jQw5bOqoQfT57mz2frkNIKSDCTxgTJetzHPXqzk+2dCtdWlEwk9GHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816597; c=relaxed/simple;
	bh=wW7I12qcJ7kOXrJKnVIVJlW8CGAjj/ydvuteSuvcz84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anHGrqmtSlhzz7AtEOhP+dqlTRk/o5YcSVkCZKZ0J7R7rb31Q5PRCzu+8C//Wc+5OX7SiW0HwKCc+y1dlGi1zrydZatFZmuaDMd4yEpZrTvvbqJ74osnx20tDP48Wp9zxhOz9c7R2UpCA/toQ6dAONKY2yMZcRyTtIImZcIoAjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qnwupr/h; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRfwULiKy4zYHv0BshpApRDhXGErn5IcXKgMUGTisTUoF4/N2KQEJPFyLK1YOpkI5JwxKtOQpEfo/pM2UEc3wMlvmVnC16oWh+leAtLXigsBw6bdoo7XIO35etD9zBai+jOHz570KADqW4uftzf5Y6w0s2bWQUtid5zA/uavX5cROJF/LYGLuSclOeDM2EL0ORev+0+xjbQnkDbJ/zYOkGVXn6GRP1Aexoj19omlDX0V0D/4BQyzHZgj5ObC9mc2W2JnzBHH+Q7c/zLpVHFZBcYLd3HrWPEWDHbI9v5xVUmWppU0N+O6QI54YfXV1oq1U1Spmq+iZicQVM2FibIAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC7RQXRQOncIb7s5sj1z6+U7iBqlF2SMXO3+pEg0KM4=;
 b=JftCeGLauN5ObYk3KtKxNHFCkbPq7HgPwObRjsSmm7oovBikoqxsBzZAI3zqNHLJviXQ7ivM9haEpx8DFduYbubV77Mkj0XC9kYehmtBOt40P4bZGBNhrN+EOpJVd1Aa1irh60lFbQ8dH7uBa0V+C5aoPA12Dg35FA9u7pmjewgunJ1/0txgW5cIytxt/1ovyoD9Zr7sjmuXn6gjjZKqvmdq4xCZFQdK9BJzQjx6+OEmauE/8mlX3o/DmEpTB8TxPrZ+1U15dHHAYIs7j1KhoqLKH75cx4PvZoY+V5ZhHFete9vT8r2GLOGF0pEmF0vwMVVApOUMcsPoEVYo7bIBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC7RQXRQOncIb7s5sj1z6+U7iBqlF2SMXO3+pEg0KM4=;
 b=Qnwupr/hXohg9p0H51uSlnG93lmpwY1YzQnOmIiTwi7mg7OFwI7wZcaWgZ92Nn0Ct490fovrEUK76IsTj1+ur03+ASm2AKRPs+dCGSCsQi7mUDhVzd865icy8YYZlByAtOGnB1qu5e6eC+kEwBVUqrJV4T/oVK8ifctPHgXM1jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 17:03:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:03:12 +0000
Message-ID: <62fe683f-3a4c-4280-8770-d2aaff478d33@amd.com>
Date: Wed, 19 Jun 2024 12:03:06 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 09/19] x86/resctrl: Initialize ABMC counters bitmap
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <395f8ad5bba4e572cb8bcee11fa19b02cc950253.1716552602.git.babu.moger@amd.com>
 <915bebc0-03bb-453f-b468-6cd8aec08de5@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <915bebc0-03bb-453f-b468-6cd8aec08de5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:130::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb3fff2-e271-4e5b-3a98-08dc9081b393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDg2ajRja0xOOGVlMDJhVmp5aUFTZXRSNHd0SE9IbFJOUEFlbmZYZ3RoTHFh?=
 =?utf-8?B?YnE4NnZ6SG9Tb1VTYXJSMmlSZTZpK096cGlGQkUxSGMrTmVXYmQyT3BjN01y?=
 =?utf-8?B?clZVZGV0T2h1cnFrRkpLVDVMZnE3VXp1dmRwd2U5cmdaaWFXQjNBVldMVUxz?=
 =?utf-8?B?SXV6RHByMExTNGUvWVo3TVdVMytMOWFZOVQ1UUp3Y3RSdWRqSDIwN2I4WHNS?=
 =?utf-8?B?SHhCNTJuN1NENExMWVlwZXpGUHlGN292SzJaTmVVMHM0cXB3Zy9uQ2pNNnNo?=
 =?utf-8?B?UVQ2STdzUXZLT2gxS2NCVGhtVm11ZStuVk5NS25QWG9MRzhRVFhQemtQbHo3?=
 =?utf-8?B?U3NTQldqcGI5K0lVQnBaemZlMWRmZjE1Qnp6UUkxNzhJT2xUSVRwL3N3cXVX?=
 =?utf-8?B?enlIY2V1TGNEejBoZGlvSlZTUmRvQTFrNU1iWGJWQ1RsRGN3aUNaWmRkZWJP?=
 =?utf-8?B?cXMwdkI5OHV5ekEzUmVNYm9LNGRuSCt0ZkhRaGRpTlU4M1VMeFlHOGluOWFT?=
 =?utf-8?B?Vk1ZNnZqZStLWVlIbkRzRzNEQ0ZUZWJMU1d2M2lWSGJoK3R0ek4rUzNRcnFS?=
 =?utf-8?B?Y1JHbW5aVndLVXgwdENkNDVnS2lRQ3JsZ0s4VmJSU3RWN3hpeWpmclBWWk56?=
 =?utf-8?B?ekNqR0xMQWlaMVYzSHVQQ0pQeHlSUUJ4TlgrS2ZUczdRZFBLZnNQd1RVUDF5?=
 =?utf-8?B?YkwrUUZwTlhXNllaNmQyL0RVZXZSV1hmR1QyV3RtMlh3cU9NZ1cvZ1V0Tyt3?=
 =?utf-8?B?NHlXQW8vOFRhb2cxdmp5cDUxdjJPQkZneTFzY1NBKzhtdFI0N3lFV1NkamhO?=
 =?utf-8?B?ZFNWRWFrellaRTdvbjVidGRGQS96cFV5VE9MRmtTTXZ3UzZ2NzFVZG5KUith?=
 =?utf-8?B?NGVZQzhjb2ZEdE1Rbm5WZzNLbE5Sb2ZhaWdGQVpkS3lldUY3SXlodFRnM0hY?=
 =?utf-8?B?SVltTUlvMXlMWFljTVl0aHJFdHlvRE96Rzk1c3R2N25Ia01kRXkwaldnMTZB?=
 =?utf-8?B?Z1pSdnY5ZXA4aFF6aVlYSHJKeTdybWlPdktQdXZ1ZDd3dmRIc2VIdEFiWDRI?=
 =?utf-8?B?TEhUVGF3bCtpazFSVjhmb3hoSjFNb2p3SW5LUkc4T3pKVVU1dzRLWmJiQXdU?=
 =?utf-8?B?U1FoV3RHVXJTcUowN2tXcFlqM3RhamF3cG1RK0tYblFjT0hDY1F2ck8zek92?=
 =?utf-8?B?OWQ1RW9IQkhKRndNdnJ5ZUVYekZWK01oaTVFeTFiYWM3cFhDTGdBRzFLMER2?=
 =?utf-8?B?RXEvNXZxRis1QlBjeElnaWgrNjBhMmdpcmhPclQvUkhLMmtmOHdpTnVYdU5w?=
 =?utf-8?B?TjhvSGpXVk53aVBHdHNsd0JqSmczSSsxRTNrYURhUG9yeldpbktqbUdBazE2?=
 =?utf-8?B?MGxYb2VHQzgxT29BL3pQUXZMc1VzbDkwQ0xESVVpdFoyS1VaeGdCUmI1UkRx?=
 =?utf-8?B?QkxaY2VWZVZDZnlUQmhESHFXY0hYVnZHSmNQcmQ1RmN3TmxFT2EvQWlBRi9P?=
 =?utf-8?B?NzNod0NDV3VkT05LOThrSCs2R3UyZHdFSTJWaVlzbFpocjNWWHp1a3ppSHZR?=
 =?utf-8?B?Y2lqYU9NMGF6TTlnSFphM254RkJsaXJDV3pscmovTjBTVTJBbmY0NllCWVZk?=
 =?utf-8?B?MU9PcE1XTVU3YmYyOURZWi9kR0g0dTFGb1dlZExaOWtjanZaSEkwZzJMKzNM?=
 =?utf-8?B?bkg0MTNUODJQc3lReStobnkzYlBSb0tCc2RteXYydGtqcWpSU2JRWlJQZWh6?=
 =?utf-8?Q?BiuSm9JUC7+lghovTLYYmjj2SyllkU3ImV6lTHT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0VPeTYxYUVScnVaQVNVMXMrb0srczJCMGVuMEVpSk9JZDU4Q05weFh1VXI2?=
 =?utf-8?B?S1BTbnYzeGovYjkydjcwSjlJUDJLcXRyQ3VrQk92djJaWUNWQ3k3aHl5OTd1?=
 =?utf-8?B?TFM3cHFYQnAxU0t1bkhrbzI2UmtCZjM0ZktLY2pTRDFnT1o1cnlmd3FydHg4?=
 =?utf-8?B?MTIyRDZQdDJyWnFESExhSThwd1Z6VmhLMlNTWis1eWZ6a3E0OEFHNW1QMFpt?=
 =?utf-8?B?aEZCTEg0OURYWURqemp0bk0rZU5VbDBzT0V5S3FYcHVXSktLb0FzV1FYZ1Z1?=
 =?utf-8?B?ZUkvZ3VZbjlPbmdPTTVqUTNYS3ZWVUdORmpqNXZpeE5BTWtmM05iVXJGQ0tD?=
 =?utf-8?B?Z3BCYjFJM2pSd2pMNUlJaDFSaE5KcGpiNnN1WjY3VzlvbTF5cjZIWCtFUnlF?=
 =?utf-8?B?NzdhYmNRMHpvYm9JLzR2Mld2aFRSM1M0OTlvZFEwRlhLVEtqN094d0V2YS90?=
 =?utf-8?B?ZWJtZGNtWGxkOG5xRWZUR04vMmlpMmtmWk5TSWRvanJPdmxJdFNCSENKM0F5?=
 =?utf-8?B?UlR1SFZOZjFGL0x6Tmx0dHZjQkd5b3JEbHo5eE9uaW9xS25kMlRBUzVsT1BU?=
 =?utf-8?B?bXMvVU5USGZtMkRBNnlGN3hxNGFoM2FRSHV1UTlBQUpqTWRsZGplY1lQMVI2?=
 =?utf-8?B?alJlNThqRkVhY25rSE85YmpZL3Q4cVVxTm5vTm1JdlBxS2pWbzJYc1UyYXQ4?=
 =?utf-8?B?bktCSnBuZWtlV0JZY1lUa0Z3MGwrQVdZUzZlSllwRlRWNDduRVllSzV4d1Bo?=
 =?utf-8?B?LzFPVlJ3Y05JZGhySzRzMmRveWIzMjJSNTdYSzg0TXc1U0NsdzFnYjRYUWZR?=
 =?utf-8?B?SXR6YllVa3krNlI5NmkvVkg3S1lFU0V2UlVWL1RzWVgzQktjRWF3QjdVSkQx?=
 =?utf-8?B?Z0s3UVRTWm1xN1g5WnlxNXBQQ3V6SmtIckdIbGg4SFdFeTgwbE1jYTZsUncz?=
 =?utf-8?B?czE1anFTcUdZNkwyWW9rZkV4cmF3b0hlT09jUUFDSmN2RG1YQ3E3MHd6bFJJ?=
 =?utf-8?B?Z1g5b0MwRXd3azZ3eE14eVFzVUpWb1M3WEgrVEZEbUVDdXlYSHc5NEgrdTFL?=
 =?utf-8?B?SWxSQW1RcXp1Q3czVUkwaTI1cC9uYWYxVjM0OVc4S1lpejgxcUF2RWVXZ3V1?=
 =?utf-8?B?ZGFFSXo5WFpEZklkdG50eU1TM3VQOXVFS0QzUHBJelp4T0o5T0VVSnFWbFU5?=
 =?utf-8?B?MHZyR0ZKcEJsdm1PV1VZdHpORW1XemxWRVVuNUw4SVNtb0I4SkkxS1ZsaElW?=
 =?utf-8?B?UVMzY2hVbFdmemJjeExQZmlwcG9Sbm5tR0dzWkpCeURib05jdHdpaVB1K3NC?=
 =?utf-8?B?N0YyYmNqdndoMTBkT3FPVU5GZytSNW52M292dVd0VU85Z2F4UmYxQ1V3MlRa?=
 =?utf-8?B?WUd5Qi9Temd5ZVdqcldNNUpDd0VwTXo5TTRHM0RSUHJnWXZLT2NrcEFRWEtE?=
 =?utf-8?B?NDVMMmFRYjdPYWg5djdNMHlkc21FbnFOOFpycHQ2NHFoNG5lV0tBRWlYdnlz?=
 =?utf-8?B?ZWZKdm1JcmZobVNiQUtQZXpQeXEydWVyVlNGRWtGM0Rmay9zckNjMjMzQ2hK?=
 =?utf-8?B?RGdxbWJGdmd6S3g5NStOU0lpVktDN2J0ZThYL1RoRmU0dWtuVGFJUC92S1VU?=
 =?utf-8?B?MTVJTmFJa1FZQnFvZ2h2YXR2RFY2cTBzNmNoZ1M0ZzhvbWVtVjZsUlNNTGo2?=
 =?utf-8?B?MlNPNnZ5dXgwNFNjdHovL3l6elJEcnlPZDE3cmZuMzJ5UE9UaXIxK1RZaTBO?=
 =?utf-8?B?Qm9HdGNVbG5TN2VxRHFLckQwbXdSME9VL0tTQnRweHpiWVg1cm1pMk9ISUUz?=
 =?utf-8?B?Mms3dlpkbGR1RFRxWDE2MStTWW9VdzIvODJhTGJpVm1kbzR4NU1neFVpY2o3?=
 =?utf-8?B?SmFIOVdRWXhnVEhjQmMxdUcvMWM4MkpCZHZHbUgxbXBYL1EzNm53a2QzZ3Bm?=
 =?utf-8?B?bkphUWZFU1oyZWlxdkRwcGNDU0FBazZUT3ZaMXBGQm5MTXRqcDZtL251c1Bq?=
 =?utf-8?B?Q1lqc2ZBdG53bGJmRElFc2w1dm52K0YzL3JWTklUOFByeklZSHBDeXRheEdE?=
 =?utf-8?B?RXVyalNOWnREb01yandUdFlFTFY4RjBXQ2VUdEdGQ1F0N2ZDbERUa3FHS2pH?=
 =?utf-8?Q?NzeU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb3fff2-e271-4e5b-3a98-08dc9081b393
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:03:11.9193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbIn743sZpYxXctwKO+42Sm4DpCyrfGJfpDZ1CBCf5zbAAaifQBeJ2qT/VtowZSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

Hi Reinette,

On 6/13/24 20:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Hardware provides a set of counters when the ABMC feature is supported.
>> These counters are used for enabling the events in resctrl group when
>> the feature is supported.
>>
>> Introduce num_cntrs_free_map bitmap to track available and free counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Changed the name to num_cntrs where applicable.
>>      Used bitmap apis.
>>      Added more comments for the globals.
>>
>> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>>      from the name.
>>
>> v2: Changed the bitmap name to assignable_counter_free_map from
>>      abmc_counter_free_map.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 3071bbb7a15e..400ae405e10e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -186,6 +186,23 @@ bool closid_allocated(unsigned int closid)
>>       return !test_bit(closid, &closid_free_map);
>>   }
>>   +/*
>> + * ABMC Counter bitmap and length for tracking available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
>> + * Each event takes one hardware counter. Kernel needs to keep track
>> + * of number of available counters.
>> + */
>> +static unsigned long num_cntrs_free_map;
> 
> Why does variable have "num" in its name? That seems strange. How
> about just "mon_cntrs_free_map

It came from patch 4/19.

struct resctrl_mon {
        int                     num_rmid;
+       int                     num_cntrs;
        struct list_head        evt_list;
 };

num_cntrs_free_map is a bitmap representing num_cntrs. Kept the matching
name for better understanding. Renaming it will loose that connection.
If I rename then I will have to rename both.

How about mbm_cntrs and mbm_cntrs_free_map?


> 
>> +static u32 num_cntrs_free_map_len;
> 
> Same comment about "num" ... also, any special reason why u32 is needed?

Only reason is, it is supposed to be unsigned.  I can change it "unsigned
int".

> 
>> +
>> +static void num_cntrs_init(void)
> 
> mon_cntrs_init() ?

mbm_cntrs_init?

> 
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    bitmap_fill(&num_cntrs_free_map, r->mon.num_cntrs);
>> +    num_cntrs_free_map_len = r->mon.num_cntrs;
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -2459,6 +2476,12 @@ static int resctrl_abmc_set_all(enum
>> resctrl_res_level l, bool enable)
> 
> resctrl_abmc_set_all() was initially created as a complement of
> resctrl_abmc_set_one() ... but with more initialization added to
> resctrl_abmc_set_all() this relationship becomes vague.

Yes. Understood. Let me know if want me to change anything here.

> 
>>       struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>>       struct rdt_domain *d;
>>   +    /*
>> +     * The bitmap num_cntrs_free_map needs to be reset when switching
>> +     * the monitor mode.
> 
> This comment puts in words what can be understood by just looking at the
> code.
> What would be useful would be to explain _why_ this needs to be done ...
> what happens to the previously assigned counters?

Sure. Will add more details.

> 
> 
>> +     */
>> +    num_cntrs_init();
>> +
>>       /*
>>        * Update QOS_CFG MSR on all the CPUs associated with the resource
>>        * Hardware counters will reset after switching the monotor mode.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

