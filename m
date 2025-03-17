Return-Path: <linux-kernel+bounces-563453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8653A6420C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D933AB6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54C1DE3B5;
	Mon, 17 Mar 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfVHK3PA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0A154C0D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194161; cv=fail; b=o2+IHek66tqAIjZBL/pKW6oz4E3ijUVDHFkIEs9YNVJMgCMIg56JgdVErObRKGniT4UZQVm1V35aZcUD+fmIzzSqvwBz9IZKCRhvocG4PE/Ykr5I1X5x5HCDF3G1avOyHOW09bypBmpkkfQ507cK+VaDx8llY0w3129mGd7KtH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194161; c=relaxed/simple;
	bh=9aRIlM79g7hnBw8Q65k3ImBV/fcge7gtYoYpPxS+16M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZxJMs6ECZX4HyZ3xhuojWRRLjw+xV0meJTXWYZu1AmGC4HuR/YNcPU2kcCH5RQ6iHDsDxLrrFbBxAm3PJZcNVn+aPzJyOLJXvySqXMul0TuOccxPEqbIh2Msx2n/6KX/2STCnRXDXEYpu7L6GWGUkzsy/lxjWObpTfntP17GlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfVHK3PA; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUvps7n9zOuMAAC/aEFPSNEgdJcOPVe1fk8QfB0I811PfISCqr8tDqdxHXybYW1xhDcd7xxN0iJ1IHXkeQZz71Ds4dhbpAMUh2k+g/oE2BAYTZbd1XuqoSL165nTb0mZNy0rYw05swR8QEflaQOeQqWql3oszhEZKjlD7WgjCLLpIDVMePbV82RK5YYKRJES4cb+tvAnxo10TYGDWf9LPpOor4wrwp+ucOweypjRqvDuL6qai1Qb9P1BQK7M9V9cDiwADPaz+UxsDtt9AzaaNH63OT4A4oCBrHPl1YoK7cCyXEOQCcz4nI0HBmjUoxzumnTm/B53Sfad/mgMUmSijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DDwVFUvZuzl/Yd6/UVChjY7Zn6po1vZQdDWKZc0z7o=;
 b=tCeicmTS+ujQV58Z0CA9PP8ODC31MbrxOUCjHutfAp2xqK1oeXTBmhK36qowdd8/m41F5EL7hSQLP02lgPK46F1EJViuuqgvmHp0ao2CdJ9t2MSS7mY4EuzehVhhVY0aJG8yu5VxW369yrAqHigyg3SkSHUoh+uzvzq9O8txIebfoHD3G+7ufM0i13OQtCRdYSZuadkNB1yzxEupi8OYbGsMQhR9p+Wq+kWuCrIfTYG/ZP0ulJUHIIxiF64Ph1tySSSYc6dezt78zd9QJype0MG6MNFWcxet9ydEjlSFNxYIzhw+l4HAnHqSA621BS8I1jmKlWFUU2r37myJGSy6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DDwVFUvZuzl/Yd6/UVChjY7Zn6po1vZQdDWKZc0z7o=;
 b=YfVHK3PAKL/cGTn9jlSA6sn7BACDw0kI5p8K588xxmocwlp5GKWu2iaTe7F528DfgidoNgoIVfpPrSi/nGNQWaywW/YsqNQHsLE32RAwtAPdT3xjXOgSbWVXCTzwMUEB+o6yZ2qz0idGoRo84JSu7jZmYOsN1r6MHzZEX+nO55o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:49:16 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:49:16 +0000
Message-ID: <1d9d8520-bb4d-4af3-a395-4a4e594e67e8@amd.com>
Date: Mon, 17 Mar 2025 12:19:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] perf: Simplify perf_event_free_task() wait
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.044499344@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250307193723.044499344@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fcb011-5d70-44bf-5400-08dd651fd5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVc5VFBUcUlZK3hTVUtrMXVuYU14c0gzY0k3TS9MMnhmeHVSd2J4VEIwc2ln?=
 =?utf-8?B?V2xReDJvVGh3WW5TOWtkdjN5STkzZ21hYkVYa2xZaEMzV2MyQ1R2QzRJT3oz?=
 =?utf-8?B?OUVqaVRKMG1nZ0tBaTdaYVJZQVh0U0JsNmZUeWlPc1ZKOXdoVkkrQ2Y4TzhS?=
 =?utf-8?B?R1QyekVjbXBNQnRITUtEWGtUckRJeWw2bTZHcUMyRHVvVk1zUTMrSlRWaGpI?=
 =?utf-8?B?UEdWSFBVQUxHUUdsN1BCSU1RR3EzV1hmRkh4TitXS0g3ZUFqaWlORUphUUQ3?=
 =?utf-8?B?bS9jbVVoZUUzN1Q5b0lCT0ErUlVrZGVsejRSYWhDRlpBbDNQK1o3Q0NFRHFT?=
 =?utf-8?B?ZEJxRnlUTjZ3TXN6b1M1MGN4b1VxSm5Vb2NwSnUzYnRKTkxZWXpaMmZjZXY3?=
 =?utf-8?B?aWJqSUlHTTRMSXNIdDRINTdMaTRiQXBDOHZvWjZGTldzS3ppeVEvQkdGVWw1?=
 =?utf-8?B?U09XSWp1VnR1emwzWEU2YTFkem44YlZSS1VPZjZFRlluRnZVWTh5SXMxYWxm?=
 =?utf-8?B?QnZtWktieFNjVWlPV2UyKzhUa09kbjIzQlNDSENFcXBLTzlqWTh5Q2Rua2FF?=
 =?utf-8?B?bWc1cmQ5VjVKNDRWSlJ1MC8ybXVWeGRwVjltUVFGQkRWZk9HUkpyd1ZnamZX?=
 =?utf-8?B?Ujdsa1B4Z2V3Vm44c0RqVFFiUzJUSmZYUlgvT05uUzFnL29lKzZtbmx0WTNR?=
 =?utf-8?B?VnRyZU8rVVBtMmpUUjc5YTNKL2lPa3pwSHM3TEFUUGFmNXNkd3lHYzBsemN2?=
 =?utf-8?B?ZTF6N1pPKzFuZmF0cUh4N2tnY3cxSWE0cnQrY3V5NUlRVS8yeTNTamcvdFp4?=
 =?utf-8?B?VGlkUnd1S1c5OW81QzhuUTNBWHl6SEhVSHovcTR0NDNUbTgzM3Z0WVFrYWor?=
 =?utf-8?B?NzIyOUh2S2Z5Q0k5eldVcVJicEZMcjFubzNzaTZsbXkxSUJKSDZwaXRtVXho?=
 =?utf-8?B?anlyUHZ6TkdsOXJyZTBlaWM4SVQ5bkw3MVljTWlkSGFtRS9yVVBRTWxxZEdo?=
 =?utf-8?B?WWgrSlkwa2NlZjN2eS80N0V0b2VUMmlKZzVpR3hyNXVkaWUra3U2SnNJV3J2?=
 =?utf-8?B?QjJOUUNsMXZkZFQyMlZrNXVLaDhrYWJwbWpmd29qV2grV2UwS25RK0srNGtU?=
 =?utf-8?B?YnRTQmp4TXpia1pMQlpCS0lpcVRoNVVqd1N6ZXVkUkQ5eG1LRnBpSG9GdkRs?=
 =?utf-8?B?cFZvODhTbHdmcWhaNXc5MUNVTzRtWEVWQjBxSnN4TkJFNUQ2eW5yTVJSMW51?=
 =?utf-8?B?eC9DTnVXYkNPS0lmd3JQUUo5cHZTVlFlNm9ESktWOHNiS24wZTRKMEFrZGc1?=
 =?utf-8?B?TlFoNVlLVm5XdlJnQW9LQjQxQWdsNmxZYlNSbmlsS3grSFJDMTFXckhRNnZD?=
 =?utf-8?B?MGJpcVZqU3gwZ05zUDVtZ2QvMDNHdTd3R3pMK29UNFFMTWNzVlBWK25PQVlM?=
 =?utf-8?B?bTZycU1TelUyc1Rod3k0SVFTdERNalhPelh3RlZuWGVDbTVWWDM1VHN6aFBJ?=
 =?utf-8?B?NStQN0ZJVDM1c0VVbWdKdGxna3VrUTZWdUlHV0xjNW5yYTBjOGlDVUZwcWVj?=
 =?utf-8?B?M0E5dDI1Rk5FR1FvZ3J3dGp6Sk92Zy8rdVZ5SlBLODE5Q3lvQ3NvVlczSk9y?=
 =?utf-8?B?dDZrNzZEK2l4UUk0ZmJ3NXRaYUw0TFJESE1EejZrVSs0b1I1dXg4YmVwWm5j?=
 =?utf-8?B?TE5iS3FTSVVjL25LY0dzYjFmQnZnTmVmMndKN2VWa2ZZWnhSSzcyNDJ2dlVK?=
 =?utf-8?B?aCtjejh1dXYxam1xZzZoNzZhVTk3NHVRbWNqN0syd1JBa1ZGVGl0TGtMYUZ3?=
 =?utf-8?B?dmp0NFg2cFVWbmdEalJacHlmS2pwTG5rSUl0aEtvY2NoS3d5RzQ3TE9xSXcr?=
 =?utf-8?Q?J1vJXPKrW/xrf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUMrdWh2TDR0QWUxTFkzcEFMc2tyY21seENVOVRJaTJHWE8wazAvRFNaU3hZ?=
 =?utf-8?B?Z1FSdGFCY294OFlaeTMyU0FqRTVFNGt0ZFRhaldWc0s5MEdUQVVkK2hqYzdQ?=
 =?utf-8?B?RVRYV1JWRWlZMmNOSUQ3bVBiTVhRZUVJWWZ1L2JYcW9oZ2djUGhHWHcwdkVL?=
 =?utf-8?B?TkoybXF1djE4OEMvSzFOL0pVNUk4Ky82eldOUE9uMGMwODZPYTNTMGUyWXFZ?=
 =?utf-8?B?aTBPZGI2Ni9BeklMSVZtOFM4NWh3Vm12ZklmRlBrZUw3RUUyZmx5bWQ2a0Iv?=
 =?utf-8?B?WjlaTUo0ak1LSWFKdzBzcmVhTGd3cTRoT3J2RzdxSFRxWG1jOUV5amVmMWcz?=
 =?utf-8?B?S2VhNFEyVlJtRVpGSWhteDl3dTE1RlFaV3Zub3BPS2tTdnR6RVBsWDF0MGpj?=
 =?utf-8?B?cnBFZUdkNHp6MCtseG9CanAvbzVHaDAvc3FsOWtYR0VoVEE5OU84enB3NzV5?=
 =?utf-8?B?bS81dnI1ckQ1NnhReWM5Yk9qTzZ6NE1qMHF1YTBpWWloT2M3bkNzZXNmNGtX?=
 =?utf-8?B?dEUzK01hK3M0aS9IN0c1YmZRWWJQTjZNVS9JaVpFSzZSUE13eGpZL3hGM3Av?=
 =?utf-8?B?OHVURkZ5UnVYYzFsTFd2TVZxSkN3bUE2cmRQUXdNUHZGdDBnbkhCTkE1SDdN?=
 =?utf-8?B?dnlBTTZqN0tIL1BJbndkWktYNUVQbXlHOEwvZGZhUVAyWkdkQXVqN09oQkZP?=
 =?utf-8?B?VVRFcUdsNENYS25UWUtvaEJMOVBER1hZdHVrT3liQk8zaGNNbWVuZDRhdWhz?=
 =?utf-8?B?WGFDMThQOVY2UDl2L21lSU85S3ZPR21ZQVRVVW85UUZ3OHlIWUo1SHhJWWtw?=
 =?utf-8?B?d09JUGtoQ3VIWnZpOE1iUkRFYXJaYjNESERvUDBQa2NXcEFEazZodmZRV1BI?=
 =?utf-8?B?aUx5NnFtYUpRNCtETUVLdEZoOHdIRXViZEpiRGVRZlF6Sjl3LzVPMllvalc0?=
 =?utf-8?B?MnEzcFl3YjVIbkNlcmZaajZZbGxTRlg2Z2RpSEdZZ0ZYNGVCblgwOU85dXBp?=
 =?utf-8?B?a2dRUVRERGxpTk5JWmRBWEpDWWc5LzlVSmYyemlYQnhvdHpRTno0WXN0bFho?=
 =?utf-8?B?aE9od1RMQ1UrekFKbnJIRlpaWUtYcW10aWJlbG1OTHVhNkZsT2pSU29GM2Jx?=
 =?utf-8?B?UnR3VmxJNEtPVUdKdjdUcEc1S1Z5cXZUM1AzS3FIb2M3YVB0cjh0ZGhhZDUv?=
 =?utf-8?B?K0E1cUpmSDVtamRabFFtNzYxaDBPT0JRYmlGTVhJTXJzR3Z3OTUwWXJCeXoy?=
 =?utf-8?B?V1NxVHowQm4zazNSNG1EbG1BVXFvdk45aEo3STYxdmpqMWpVc0hWVHVEb3Nz?=
 =?utf-8?B?RVdMbUh4M2g5YkNmVDU0RjNwN1NlZU0xVkJDaUs5dVQyeTNzZDc0Y3c1aHhV?=
 =?utf-8?B?bGEvWEM2MmpBbVpDOUEvRDdnRS9Bb3p3NTBRSC9jL2tXTGJQdGIvcVZ0eW1n?=
 =?utf-8?B?NDJReThhTDVtZFo5Ym9JN0ZGV2RKSVBnUXFjbU9zNnV5djRPcjVwZmMxL0lO?=
 =?utf-8?B?M1JRaEorUElISlRYeDg5WHExQXB0Y0lIMTFLanNpWCt3azB0SFNFTGtsT1Ez?=
 =?utf-8?B?Vkh4dFU1K3FETGdwZjQwbmtSbDdRT1ZLbFBTc01UdTErMXY0c0ttQVlQYlE3?=
 =?utf-8?B?K2VQYkZzTnlTbExNWWtpZE9aTGtIUFV2V3V5WEQ0TjBhcWpxYWxhbUx0OVE4?=
 =?utf-8?B?SXNmOG93a3M5Wlp5Z2NXR3dRQXFmUU82dmRCN3lqQ3U2RTNwS2tWRnNieWND?=
 =?utf-8?B?eHVDUzFWVnhtUnhZM1BhQzh5Q1FjOU9JN0RHK2NZZzdKRGgrTEpweWRnd3Ix?=
 =?utf-8?B?SnE1TWpHMW92Zy8zV0lXUWczeTVjcWZMeTMxK1NPaHRRSkd0SWc2WTY1V3hz?=
 =?utf-8?B?UnkrbHlmZXhzWmQwdy9CUjRVd29tNkdqZVRRNXZvUFh3OEZGd0VJL2xBbU5W?=
 =?utf-8?B?U1JuU29LYU5NaVJ1MnVkeVVrdnZybXBYY1czU25hRks0RTc2a3dCc2V2UG9C?=
 =?utf-8?B?OWR0RXZUK3JXblNDeWZrN3JkQ3ZWdEd4Q1hVbHBFSXlUdUtVcWZkb05VeENs?=
 =?utf-8?B?NmRFdW03b1lDM3pZcTRYc3JLUWUySkY3T29sb3pLeklRcm43WWJSZ0hqcjNV?=
 =?utf-8?Q?nR/kyN9cG6JCZjtpFubnjBtGf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fcb011-5d70-44bf-5400-08dd651fd5c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 06:49:16.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+KLtbRkKPvwSwKgcS5nb+TS7HXigOHPSNbKYDvTZsu5DWkolwiuhLWjiNDUB38c9Xhcy53wjhaPT7LwVDvLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Hi Peter,

> @@ -1223,8 +1223,14 @@ static void put_ctx(struct perf_event_co
>  	if (refcount_dec_and_test(&ctx->refcount)) {
>  		if (ctx->parent_ctx)
>  			put_ctx(ctx->parent_ctx);
> -		if (ctx->task && ctx->task != TASK_TOMBSTONE)
> -			put_task_struct(ctx->task);
> +		if (ctx->task) {
> +			if (ctx->task == TASK_TOMBSTONE) {
> +				smp_mb(); /* pairs with wait_var_event() */
> +				wake_up_var(&ctx->refcount);

perf_event_free_task() waits on "ctx->refcount == 1". But moving
wake_up_var() under refcount_dec_and_test() will cause
perf_event_free_task() to wait indefinitely. Right? So, shouldn't
wake_up_var() be outside? something like:

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1281,15 +1281,14 @@ static void put_ctx(struct perf_event_context *ctx)
 	if (refcount_dec_and_test(&ctx->refcount)) {
 		if (ctx->parent_ctx)
 			put_ctx(ctx->parent_ctx);
-		if (ctx->task) {
-			if (ctx->task == TASK_TOMBSTONE) {
-				smp_mb(); /* pairs with wait_var_event() */
-				wake_up_var(&ctx->refcount);
-			} else {
-				put_task_struct(ctx->task);
-			}
-		}
+		if (ctx->task && ctx->task != TASK_TOMBSTONE)
+			put_task_struct(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
+	} else {
+		if (ctx->task == TASK_TOMBSTONE) {
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(&ctx->refcount);
+		}
 	}
 }

Thanks,
Ravi

