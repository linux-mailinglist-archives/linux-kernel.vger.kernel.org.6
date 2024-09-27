Return-Path: <linux-kernel+bounces-342036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A539889EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A30E1C2159D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B91C1AC1;
	Fri, 27 Sep 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vNCvMQu1"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532471C1AD6;
	Fri, 27 Sep 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460676; cv=fail; b=Hq01T6O6ghTglDrHVJxSghvcBevMQZHNx6EQ14E1gvoYhbMugTdNgQCDPTitYdUBOAq8zGgKuDwTNcqnBMY+3mjoln1xHi/XPXr5C1FXQYIMl82UCuA4w17Qt9PvdDYa9PgKF8CcXXT8rJa/a3rLIstgBdaFyvzbepd8l8fZZaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460676; c=relaxed/simple;
	bh=ukB0l+LBlPYbrStSkGVfuSiI8FcY10gFr2wWPz8fePQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amgwC6kZQmzKtG1NJ/Vbr6Rj1UVtCDcFAD5f+dE+FFPuFJ8MFHy+dLZ2OqGfu9gUHClnpt7Em26oKYGhl7tND1dZJ2/k90W02ICddmyszU2M6ysj4iLhHriwEMu56zykexBOj8eWT56GRvR2yhxqS8gXZhbLP6Ky/3JHh9C3RFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vNCvMQu1; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/b9V3ep7JTC4N9Ac+58+154DI+79l3gCqV2V9aAJj9WYno/8cd26YoM1fCZmwnhnsACf/qkiM3hp17x67WViz5xzG7nlg1NWNx0tUVjQ5DO19nhc2CBKcbBQCjETj4cXfBZbdB1XrtSNk0byoww1vyEyhyS7iNrDzcYXIRyi95lVBClNhl295iiVIhJBPBiiABUhrOVFIrIN+RMF1z8IRyRuQ0C1xRVKCue2rrGpodz922GakImm6fXqDdmaYXIBMsOmlOSoOIlRUTVoTCMlxC9T4sjRpKor6ZR6Xq0vtNiJ2KUOA9aNqPPF+qYozT6HwfqxvYWjq3kn8A6TeCTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK+RnqXIB1CTAaIT5UWkv7wn6GbTzpyLsGPRBIZVG5g=;
 b=LICJPo+hH9KHfZu4XS8OKaBF3Q4SfaHPRxCCj9yQ5hpigOU9hCR8tNDzXiCGnfUdooympGZSWb7g3SBwtcO6oG0R5DlOUds79JA6FSwPCSo47Gmva5R9NasI065D4IxaasjtruViYKvkgtQEqqdi1docKeMiHOf2kNSHKuvDMgyP8GJpu2cz2JDsbzXi30S9S+GTQTm/rs0KH4TvBelx9rJGShvMH0RjiSfCF9uvYMjt9KdLiK6WX8If0hlGI06nYMQfatZSqw/RqIJMU7qzxxmrO0Cy4P7DPeco8GFiSQ9xad4yWseuY43MljCrxkeatJvVfPQHiZX5593gQLs4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK+RnqXIB1CTAaIT5UWkv7wn6GbTzpyLsGPRBIZVG5g=;
 b=vNCvMQu1vdUQP/HrvXIaeso9I796wKHU1QXeLONz1VLYxAyZR8ElHCALpySYkQrrXQa+/whsHr1CZ/xIYHmqd1R47nQ8XnetJqD3XIHAl5fOt+IbPK2EVZVKvPFs8dPDGcNmk42t9DPwuTrWj+CCmr1e3sj+jNw+srD9xyWeSUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 27 Sep
 2024 18:11:12 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 18:11:12 +0000
Message-ID: <23c04f34-eb70-e73a-7ec5-44a23f152d3b@amd.com>
Date: Fri, 27 Sep 2024 13:11:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 00/24] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <6a806972-568a-4959-811d-7a666901da66@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6a806972-568a-4959-811d-7a666901da66@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6ee57a-1e28-4a84-3e53-08dcdf1fc4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1tSm1PdnRSSkgwU2Mwak0zeGxDK3M1QWx0ak1TWFh0K2pMQmRzM3hTbnoy?=
 =?utf-8?B?cUgxWnJGOVpNdjQ5b0U5QWhjKzlqNjhGMHphTm1ielpwRWpBT1d4MTNkem5B?=
 =?utf-8?B?TWFQY1JtOVhJc2NFMGQ2NkxwWDhyYjREelBMbDlZQVAxSkh3Z2FZdzltYlMv?=
 =?utf-8?B?M3FQUVRZNzlyK1ZJZnlWeUlqaEtkbG4vb0RQU1NJMnNJQnFSOU5tZ2swSGtk?=
 =?utf-8?B?WFhobTlldExEcVlSZmJCTHc4aUxBaGYyTWU4Sm9xN0lXNnM3Ny85V0s4d0l0?=
 =?utf-8?B?UjFuZVlGQVo1ZG13RWlzTkljNDgybXhnZUFIWmRBWW5yc3NTd1FQQlBoYk53?=
 =?utf-8?B?TWo1djNPKzlhWGZKeE1mZUpKaU5nUnk3bVROZDRuYmdQZEVyWFpIRk83b00r?=
 =?utf-8?B?MVJybTNuQnNIeVlpditkT1NDWDUvNzR2Q0xKQitZamg0N0F6aWFXMlA1M2la?=
 =?utf-8?B?MWpTbExnSmRRNlVHa0V1V1hKZFZPNTluVExsVUVkNENaV1poTExWdUJCUCtu?=
 =?utf-8?B?VkVQcExqS1pqZDlYMXphWU9YeTdQRVJGSm5rTzM2S3VjT1hhUlFKNUE3ZDky?=
 =?utf-8?B?Q3VXNUQ5SzNRL2JadUxWYkk1N01zRTUyUnFWZnM2YlhoSk5NS0h5UFJNL3BD?=
 =?utf-8?B?QVNteTdIZGRUWFk4MFFQYjdSTmlUcHlRVDFUd1VQeTFncmo1djBpQzlKUHV6?=
 =?utf-8?B?UDJ4ZVhKRnJOM3d2K25nbHFjWTNvQytQUTBVQmd4WUhXdVJRYUZ1QjV5TmNQ?=
 =?utf-8?B?UW4zM0NGek5UeE5WUmdpWnkweTRManZtUUxLdXZIR0lFQ2dwa2QyOCtveUww?=
 =?utf-8?B?NUFQY3l6aWFCVVdjeCtHWEhheFBVUHVDSXlRMXVmS29HY1ZyTnhaZUljOW50?=
 =?utf-8?B?eGZVNWp6dWNXTnpPZGxMZWp0cmxiZjBWNCsvMjNhUFVnNzBPR3lDT0ZWcjV5?=
 =?utf-8?B?VkZUczdNTTE1R045aHFia2tkUHJkdllONWtEQ0FQd1N3ZnZKN1JidnhKNlZW?=
 =?utf-8?B?VjRNeW1RLzh2T0lCeWxwb1VSVVBZaXVTYVdKbHJyMThFR0tHQzFGa2N0S1Vv?=
 =?utf-8?B?Qy9tTHV4M0FWSVBpM2NpNUhFT0V5V1AxR2o3V2ZQbjA1T2RVNUZsRnFyYkkx?=
 =?utf-8?B?VW5XRWNRTE9qazVtbDByU05IZlZLMFlNQy9WTU1XbUFWdDhQS2RsZGFHbEhL?=
 =?utf-8?B?djJiWDNOdUZpRmtqSmdYU05nZzlzYTZlSFRZZTVPSTgvZEdBMHd0Q1RvY25V?=
 =?utf-8?B?K0c4RlE0dWU2dDJab2h6RTE3eW1UQW9LUXlWZlhHbzRiR2NxeXFlRG12NVBj?=
 =?utf-8?B?NHVyUUdBMDhrck1QRk12d21qT3RsVFhzVlRVa1R1ankzeGQvSm9qZ3RySUhZ?=
 =?utf-8?B?V3Z1RldrTVVwTjRxRVVzNVRVeUhCcUZybVBma3VlNStiSVpPcVQxdUZsQUlw?=
 =?utf-8?B?OERGMTlabHh1b0txVTBUQ211RzF5QmQ3U1FEeUJ6UzJ2ZG9SSktpejBjMUFG?=
 =?utf-8?B?ZXNtVjVCV2ZhclJVOUo4UnBYeE5zZnYzeFF1SWI3MHd6L2xxUlNYTEJiMTBN?=
 =?utf-8?B?QUk1VGkwTmZQNDFhN3hETVZZWkFwd01PU2ZsMC83UjcwMVh6UktiaEhSZUNM?=
 =?utf-8?B?aWNPMy9ZQmJTeFFFbmhNSzJHS285d09RSDlXUFRpQlpybGhCZ1hHRUhFN1c3?=
 =?utf-8?B?THJ5YzdLb3lCaTB6T21UbDY4Nm1WNllNMFY3TVlJQ05iM2hZNTBJMTVucUhE?=
 =?utf-8?B?RENUM2dyUDkrVUJ2Q0JuUDZoMUI5emZyUWtySHdBaC8xd20rdzlhU1JFNjBK?=
 =?utf-8?B?NExkWGF2d3RVUkYwd3lhZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDBxR3VTNnBMK0xSM1cwZFFPaHhVYUd0MHBhNFJzSFVHRWtjcUd1elhjYkxh?=
 =?utf-8?B?Qitqa0RBUndoTExTK1RKd2YrZ0RyZHV5Y0hJMWRGYmJONkZad2ptQzdwSXJ1?=
 =?utf-8?B?a3NOVUVVTXFoWlJHWUZkRHlHTTJNOUZvclZqWlFyUzYxM1ZUTC9yZGRoMlV5?=
 =?utf-8?B?YzVOc3lvTGpoak1VMHRSZ21YOHRPdmJpNGRZdG03RytibGtSYU1ETFM3S0t3?=
 =?utf-8?B?TEQrMGgzYklKMUJqd21TVEVadmtYdFB5V3hVb1FISWNNWmo2R3ZYZFRMK05u?=
 =?utf-8?B?bWtwN2xCZFZyYUhFTE9hZGdHTi9KVkZ4dm50U1ZQaDkvTVJ1bmhkTVNzUVFS?=
 =?utf-8?B?MUE0bnVLaWlUVjRpSlJHdDdUZTRwelRrZzVubHNIMVJYc1NvQVFJZjFuV0Mz?=
 =?utf-8?B?U2NKNWZZdGVKTUdiNjBOeGt2aUJJQ01ZaW9mUlNGSmxVMFowdnUxSEY0UDFT?=
 =?utf-8?B?L290MVNlbzFlc0V3SVRWYUFLem80Yzc0ZFExOWJFODFZTjNXNUkxYUhSRU92?=
 =?utf-8?B?bUNHQ0V4cjlPTGQrUGRTQkgwMGhabHRkV052THhJTFhNd3pVaGRJdXg1UGl4?=
 =?utf-8?B?LzlIMHIrK2lRSkY3RjVyeHo4UklwQnN0QmpvbnNYb1V4UTBjWHI0RVNIS0Vy?=
 =?utf-8?B?RndxTHN3N05ldExSZC9BRWJXZXBlR2RiQTVVUFZPay9NendCQVlCUGJ4dUJ3?=
 =?utf-8?B?eHRMTlRsZUFkVWIrMnZYelF5SmZCQ2dpZ1N1NTdtWHdTL0wrcmYwalk3YjZE?=
 =?utf-8?B?LzA3VS9jU2N2V0RZWG1zaGdPZWs4SFRXK1BwS255TDd4NGR0MTNQQ2lIeHZP?=
 =?utf-8?B?MVRhTWJQMFZDTXlPcmxPS3NFOVNOdzZNa0w2eFZPVmhNSDZYaldPRjJ2VnlJ?=
 =?utf-8?B?ZExHOXpsVVZHbW93aGRmdlY5WHdvQ2FzYzdpTGErck5nZkZ2dG1JYjJvZnYz?=
 =?utf-8?B?R21SWkJlV0lISzIrV29RdHR0S2dhajB3TkZsUnc4R1daZ01WeFdsa3hqa016?=
 =?utf-8?B?VEtGYkdScWNwRVMxYkJvS3ZMUlF0YnV6aldyVXVUTCttbEtSbzRpaUtKVnRL?=
 =?utf-8?B?T2R4aVdWQ1RmUlZPMTFGNVk0NzBYc2hELzI0QWprMWFCVE42d3AydUlIVXd6?=
 =?utf-8?B?Y0dHQjcvZWJlYVgza0xOaWViZG1ud0pwUlBNOHlFUy9qRkxvKzlnajNQbGZ4?=
 =?utf-8?B?YzhXdmZpK3FNc0l6MGRsbEpXek9BRVhJaUJ2MWpLdVFuU09qdCt0ZHdRSkx6?=
 =?utf-8?B?UENaNlorcUZBVTVNUzZFN0d1YWl5cEdLVWxKNUFFUm9tQmZ6SjZHMFdpVCt2?=
 =?utf-8?B?blJYYjM0aThXMXVaR2hscWVwRkV0Znh1UjY3aXlJdldCWnJmbkMvNnZGZU9T?=
 =?utf-8?B?Ui9IMzZkeENlc3ZFOVc1OEZpb1ExRXQ5bmN3ZGxSWUlmamtYaXRrd20zbU03?=
 =?utf-8?B?bHhUU2x4QXRCVFRqbG0zK081TG1UOVMrQjRNejMyaG1OTUVyWGNaT2hrdXI1?=
 =?utf-8?B?L3dJd2JGYitmUGNlMUxqbi9zQkNwMEwwUEJpSEIrZmJUTDNpMVA4cDB0bmtl?=
 =?utf-8?B?Z2QwdmpXaXZtK3ZINjVmczJsWEkxUlZ4d2loVllwRFdlMmNNSWYzcmEzNDVG?=
 =?utf-8?B?SFdSTGdNMHMvYnRZYjBPTjloYXRyc0ZucXVWWHZPQlp1blRabHROMHFoeHRo?=
 =?utf-8?B?RUl1ZFdvUUxoQnY4Z1dGdWtUcXRpbGR3QUhueFhZc2lSWXlRSGQvdHdkdXNG?=
 =?utf-8?B?MUxlNDhROE4zSG9LbWVpT09HU0h3MzFrR05WMisxTlJlWGZiN3JvQmg4YXM5?=
 =?utf-8?B?K0U2c0tEOWxZUTg2aXA3WnhOQWN3eW44Q1VHOXRMdUFqTDhiL3ptaC9XenUr?=
 =?utf-8?B?dG91TGFiV2JQNjBHbGk4ejFINERkSkxHUXA2NVVFak5yN3BEOHc2aHVSTTVU?=
 =?utf-8?B?OGswUDhLL2V2TC9sWWVJU1hRMlR0cFZGVDlzSzdzbnBGcFlURi9XQmQ5UDc5?=
 =?utf-8?B?NlB6TUpoSXpBTDV0aDRVZVN2bE5Ncm5DdG1RTmNCRHIzUkU1bjN1S00zWmIx?=
 =?utf-8?B?K2VydUt0aW5BQjkxUWozTzk4eVdLS3k3ZTcxUGltc3BxZTVvQlBhbk1iRCs2?=
 =?utf-8?Q?7QzWf5Kgyt/AdVngyZaKu/4L+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6ee57a-1e28-4a84-3e53-08dcdf1fc4e4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 18:11:12.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCNdjtK2lzB9E6GV6j5roHRKGDLMbbEaOk/em4JY2dhD0KYh4HL3R/TSxcEK298v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Hi Reinette,

On 9/19/2024 1:00 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> # Linux Implementation
>>
>> Create a generic interface aimed to support user space assignment
>> of scarce counters used for monitoring. First usage of interface
>> is by ABMC with option to expand usage to "soft-ABMC" and MPAM
>> counters in future.
>>
>> Feature adds following interface files:
>>
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode: Reports the list of assignable
>> monitoring features supported. The enclosed brackets indicate which
>> feature is enabled.
>>
>> /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
>> counters available for assignment.
>>
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control: Reports the resctrl group and monitor
>> status of each group. Assignment state can be updated by writing to the
>> interface.
> 
> At this point I think the architecture is settling with the remaining work focusing
> on polishing the code and making it more robust. To get confidence in this big addition
> it will be valuable to hear from Peter and James to confirm if soft-ABMC and
> MPAM can build on this.

Agree. Peter/James, Please let me know if there are any concerns with 
the interface.

> 
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> 	[mbm_cntr_assign]
>> 	default
>>
>> 	ABMC feature is detected and it is enabled.
>>
>> b. Check how many ABMC counters are available.
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>> 	32
>>
>> c. Create few resctrl groups.
>>
>> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>
>>
>> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     to list and modify the group's monitoring states. File provides single place
> 
> "modify the group's monitoring states" -> "modify any group's monitoring states"?

Sure.

> 
>>     to list monitoring states of all the resctrl groups. It makes it easier for
>>     user space to to learn about the used counters without needing to traverse
> 
> "to to learn" -> "to learn"

Sure.

> 
> Reinette
> 

Thanks
- Babu Moger

