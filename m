Return-Path: <linux-kernel+bounces-290294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEC29551E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A898B22D38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9111BE222;
	Fri, 16 Aug 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iaKylhbJ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C01C2316;
	Fri, 16 Aug 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840764; cv=fail; b=jc7YAFudzryqw0DEpJHjtEO29ZwNS5g3E083R01iE3ZWFHYZ0BoEPkSdk8EG+SuNorVN1YJOTSTqF6QZTadXlU5V+IkXpCxEG1F74FGTZlebsAmZBMnOYRHzL1UIJH8py8W7IUgrmCXgfpPkRQzO/uaY/ZrEqAWZcBAFMS/89wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840764; c=relaxed/simple;
	bh=mgGLf3CC2ScKj2y/Ryx1OUcOPj5eDNIZ0WlllaSHIwU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KeQEw+K6eu2cJJz2LBOLixrCj022z7Nh+dQXOnnV2bBRqiY7RvrxE1MQcTk1fHJOlUZOxokGFJ09Wk7Tn8cELH7X8df87Hbwvv+1Jy31BkP95pc4CdWPpHM81Dn4RfDnZ4zFUdPoHS2Gyxm3svJ4YDYPQ3knceqLXwf8ba4qEqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iaKylhbJ; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0KR0g3aYhw/+OufPznITBm2VJLz55j0bmCH6vkR2NgQjDlF27JdmXmWhFyeJ4NmFkfWl8B4ouyJPTOTzAcrdSvVkgheqYKjnMjOkSoewc09nLR4VFjtB6ZkFsrouIw7AOpvVACxGtTX9OwUyeJ7txZCJiRu28ZrPZWGoRpRpvt3LsRDaKeNpocrUJNuo/8wBipJgnbHvB1MFsKmYyrgo9rc8SUcQAMNPElFFjGF4Ypm9Ot3nXyEipbnih3TSeHWP1R2mDKCyOGqY807jePJ6N+IBFLeSv2Wx0Lu271b892l07MqPEQX7Uw6oA2lK+8MXkYwUHe+MI/XnKJoY52Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG6lj/CSRgwgp+ors4q//gph3trvMlxqddHjRH9HhO4=;
 b=aMayVz55oDUbP7uA44IPbGpivkAGRQecO+E8tBsj0PH5sHDLXJ2xihfFvvrUPYIAJbjZRAFPjtnJ/8NTZjGd2QNjWX2TkOcLKpN+WOZiEixBB0xHiwj37f7dzf8dFyCkzYMdj7WEwJxs/8QkJuEkXeNmcszqfarV0gNYvu4A/98UDqmJmUU9rqLAyHZ4m0a8vgkEIfI2u5QRQikjrtomT031IqgGdbAQyILnYSqpIObpTVyvGl5AFdXMi/JzGwFdwI762oLYsQ+6kB/TFS2msjqu9FkDqCxUzj9dd485+oueFcWf0um79Xtp7Fo5nViV+rGng66yNTKkPKCsuuTUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG6lj/CSRgwgp+ors4q//gph3trvMlxqddHjRH9HhO4=;
 b=iaKylhbJpz1ZuhYqxocpzhvifFwUZSRB8IRPm7gQVS4eov78aJT8XPWqXj8/C5rpD1Zk/PiBjQaRUA7dZHUpKDK4WAaeZJRMtG6cMgHcDjEESkKS+5u3ZjPy41PakXWqY+qIMRhb2hRLfbwVdeY/nDzLE6XJR3sukdN742IEtso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 20:39:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:39:20 +0000
Message-ID: <5310acf5-0d6b-475b-a2e3-8071757d1735@amd.com>
Date: Fri, 16 Aug 2024 15:39:15 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
 <4cce2fc9-2b42-4e10-b923-387611077d6b@arm.com>
Content-Language: en-US
In-Reply-To: <4cce2fc9-2b42-4e10-b923-387611077d6b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 798ed609-32ea-4e50-475f-08dcbe338149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVl6WDhoUDFpNDFwWjFJblZhSFNjQXV1WUc0ZCs2anBhcjN6ZG5yWnRxbFVo?=
 =?utf-8?B?TzdYUFArc2RVNmV4U0xadFAyMW1zWmZKSDVZSUZpRmdyckEwb01xbXlISm1z?=
 =?utf-8?B?eTkxK1grWWR0UzVyellRTWNJNlAxczdMQU80d0d3Y3NibWdzcVlBOXREcjBl?=
 =?utf-8?B?QkhLK29PZTBhemhpbWJubDJvVmNPRjhPa3JOSHNtTE5jckVDRDhhZDE5V3lz?=
 =?utf-8?B?MVVMbEg1SGt1TGgyZVBXMVZxMW91ZDN4UWpVNmNoYTIzVUJxSUdYVHJ4REtp?=
 =?utf-8?B?U1dLaHRhczZHdEQrUzFSM0JiSEpsWXNGK29RaERZSFZxUlg0eVd1SkNNbzd5?=
 =?utf-8?B?YVVTSUt5SHBOMWJUR1hFN0FJYlN5QXI2NzMyOXBVTnRaVkMyMUo3cUtLeHNT?=
 =?utf-8?B?VGkwaElVYUtwUmt6UGR0VEVVSFNSTklRSHRHUEtVL0ZvZDI3d2VoSWg2d2NI?=
 =?utf-8?B?b09qTEx6WGY0OFBIYTRJV2ZqVkN3ME1meEd1TTFHMk55Z2V1RU1xNTQ3dzJD?=
 =?utf-8?B?T2Nza2J4SDErcjAvSkJLaGRZVVl1a09MV21Ed0hiOGJCQVJ2RGN3aG1LVW9N?=
 =?utf-8?B?SWxXZUErbExuRE03UEFlTytFYVlDTUx2U1lhV2J3a3hUamE5NTArRFpJRDlI?=
 =?utf-8?B?clp0NHBhR2dUdE9qdjNaMTllMjNoUWZaQlFWY3NCRUp4YkNDMmxQM2lOaDlM?=
 =?utf-8?B?ZGhLN25Rdk9qOTVjQm5VWlB3dmQyZkFGcWlGWjdiMEZXb29VZ0EvQ1NJTi9K?=
 =?utf-8?B?Nk5NZ2d6L0drMWhsWmM2SW00MU9OV3ZIVU0ySDNlcjJ3aFlSRUdhWDdQZGNo?=
 =?utf-8?B?R0dGbXN5OW1ONXgwSVdqenpUZHF0bFpCMC82OUdLcVlKcW9RQ0orMy9BWDli?=
 =?utf-8?B?L0NqRVlIK29PZ21YLytBOTlnbTRSaEl5ZUl2Ykw3bXdPOEJsdDdoWFFRSzh5?=
 =?utf-8?B?RkxJRTQvZUpZSE1HbnFsQUh5d241OEhCYnNBejArdFV5ZnJUZ1ViU1JxSnFI?=
 =?utf-8?B?RjhoNWFPdkxCZEJwTGJVbE9aUnhhd0Y0K1B4eXI3TjZWbVJiRGZEbHk4WFJW?=
 =?utf-8?B?WXUxdVM0WkpES2c0TW9KWGlKR3BPemFYb1JxaXl6SWhxdWR6SGRuUXl0TnhF?=
 =?utf-8?B?S1A1dDRwTXdoWTdRZDJFdXJVdGJ2SE9CbXZKcTNpalNqUEw3aW4yTUlycVNC?=
 =?utf-8?B?SEpiVGsyd1M5RW5teEx5QVM3Z1lQeEtkdTc2SnNFTUUyOUdrMHZiNUF5cFZh?=
 =?utf-8?B?OGxNUS9MZGV6UWhBSnZVbHAxN1BacUpZdC9GZ0pwSGNtYkJ4T3RKNHNpTVdw?=
 =?utf-8?B?aUJSUjN4TFdUNTdsd2hiQU52QUt1ak1yVWtvbDVnbEcvcTJSeUpzN0RHVUJG?=
 =?utf-8?B?MWRUQnlqMml1NlMxaTZQam9GdDMzNFYzNllmY0cvUVM1YUg3VXZ1YXdacXhC?=
 =?utf-8?B?ZWMvYmhBOFl6RjRSNmd6aHFpTmdTMEQ4eE01TDUxQTQ5Y0tpQTVMMTlzdDE0?=
 =?utf-8?B?b2JFSUt3YU1vZ3FWTW5mUG9rczdLVXNJdStSK2dKOFJGaGNnZElyNENzaFFJ?=
 =?utf-8?B?ZVozQzBreGN5WVhxSVhuaVl1dUcwRy9iMTJqOXdibDJhSVlCMzVxd25IYTA2?=
 =?utf-8?B?RW5GQ1BIcG5vN1hIQ0crNXVaZTBvcUJ3WUdNazRpSjU4WmhOMVM3TEVFWmRF?=
 =?utf-8?B?WmM1MWZMQm5zVHhyZlhVanRGaDFXaG55ZnpXVDNzdlhxTTR1M1RNdldXQ0lY?=
 =?utf-8?B?U3JOdm83T3NVZzc5VVdoblMwMUFEaWtNc21ia1NlNE1rS0ZDYkkvb253OHZV?=
 =?utf-8?B?M01UdXNReTJLODM1c2xqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGNNRWlQeFJDVm5tc2UyTzNSeGxMcVNGcW5Hc0lhRGMyT3RMcnZTbkFCczZj?=
 =?utf-8?B?SGxuZm5NZlUrbEpsQWtZcThGaFN5L2oraEtGMDBOellmMHhiTktqZGNuZHdp?=
 =?utf-8?B?L3RQY3MrOGJDSEsxUFE0VVBMeFV5SUNnN0Y1N1NESTBqd3dBVG1MWlQ0ZG1I?=
 =?utf-8?B?RHVzUkxFNk5DR1N5RjhzNTRvdEZIY3ZHMkljckFRNVhNeXdaQ28xbTIvdVA1?=
 =?utf-8?B?MS9QcjdHbW9rRmRIL25OVXJvajRZb3FWNzA2b00yMkZnY0JLd1FkNllBekUy?=
 =?utf-8?B?SWlNZkdtVXB3SFh4WUUrbXFabk1xNE5Nd1l5TjByYkNFTHMvS2hYMktwVDhN?=
 =?utf-8?B?b0owRVZmQytvVHdPTHJtTHlRWXY3RWJvbUFEczN4SHNLbDNobzBKdmJWZFRP?=
 =?utf-8?B?OVJtNXRjNGYrMUcvbDFrblp0YkN1bEJTQUNqUWtqWWI1VXlNSlhjYXAzT1Fz?=
 =?utf-8?B?cDZ6aTRQUnRxN1Q0ZkJzTVFXdlBtNU5ZckdpVEFXQ3YxQXJIK1JQbXFydjVa?=
 =?utf-8?B?akJ2SHNkUThLTXEvNjNlWXV1TEJKb2E1Tm9JajFqR29DTHFhdXJnY2pya2hJ?=
 =?utf-8?B?eUtzV2JNS2FTN0dTdkRBNTV4Y3Z3dFRYQlk3RDFkd3J2S3NjZmFhek16YkZv?=
 =?utf-8?B?RDdIVXB1eVBpQmQ4STNDK05TS2ZTV0c1amx2Nzg1WDVWUmRBN3ZFUDAxVTNz?=
 =?utf-8?B?Mm5CZ1NUWVdJcjZlRDAyN3Y0U1lvT1JLVGhHQ1BMSzN5cHlrdHkvek42cHJB?=
 =?utf-8?B?TEZuZ2UxanhtbWtmN2pRS3RiUlAwQ2lGYUJIQlpHM0wycXdkY0pLdUNZRk9v?=
 =?utf-8?B?WjYwUWxLRmhhNEdNK2E5Y0JucmY1ekZZeXVIZ1ZWL0ZXUFF6RE5CV3JRQ0ln?=
 =?utf-8?B?OWVBeXkzN3hKRTBvNjJaMGNZVS9RanNURWVCYytLajlWbEQ5Z05MR25JN1FS?=
 =?utf-8?B?Rm0rUURRQy9SNFgrS2IyZUx6NVdrUWllNU1iOXNWQ3UvM3MzTmpRT0V1N25K?=
 =?utf-8?B?aXhsWUdJcW5pcjdGaGwzYmpsS2lTMlZOUXA4WGZqalZWWFRuLzVTVkF6WGln?=
 =?utf-8?B?dE1VMXkxNmxHUnNNcjU3MVJlRHgzRjdEZndLL2hYNkVtRHg2RE5jNXRUb25u?=
 =?utf-8?B?cksvR3l4Vmp4Y0JIN2orZ055RkxBREJHdUZYazlOOEY2dVdKeGNXTEJQSEpV?=
 =?utf-8?B?SncrM0dXelIvYVVCdW1WeGJKcFBTbk9YUzhzSnJ6M2QzQ3I3Q2JWN0hqMWh6?=
 =?utf-8?B?OXJ5TnEvRkNYKzZPQTdNcVZYcG9ONWNudXN6NUY5RnVYNS9RVVRVVzJiWGNK?=
 =?utf-8?B?bmVTYWx0SzNxbzNsaFh3OG1XWmRXSUZSVHpqMm0vcGEvTnJ4bVphV2hBUWV3?=
 =?utf-8?B?VGxvYVFxTXlHK1Y4K1hKb2l3eFpvaW95WlJFQ0NtRkFsbm5nREY4S0R4M2Y5?=
 =?utf-8?B?anRsUVZWWVRVb091SjFqZzBZL2JwT05yWWJaVVBBUFdBUEV1dUpkZ3ErYk9k?=
 =?utf-8?B?bjRUSGk5dnQwN2c1TGNwajcrc0V0TXpyTDdQSGhOTEl5bTh1R25QWE8zYVZM?=
 =?utf-8?B?Zm5laXZuTFRjMFk1U2dhVnRWY3hYT1FTS1ZDUFo3WFZqZjl0Vkx1Nkhaa1JS?=
 =?utf-8?B?V0c3WVlxWHhINnFhMTc3Q1ZWZnUwZ1FuMjhkT054T3lzUis4K0tPUlZSZytt?=
 =?utf-8?B?c2hNa3FqQ2JxbXNCOGNkdEhBMWNSUVh6a3BlS2g5SFBLUEJXbm4vVEErbVpQ?=
 =?utf-8?B?V1VLQy81SDhyLzk0RUxpM2ZQQ3VGZm1vQjI0ZXRtQVNFT1VUdTNiNkVIWExp?=
 =?utf-8?B?NnBaUEtkYUJqMXlBcU5PZ1FPVS9CdHdQRDdFU3prVmJkQys0ZHNQMVc0Nk1L?=
 =?utf-8?B?ZUVrK3NqOEp3Q0phQk14Q2wyOUREZHhXcXFOejNmMytFdTVJV2NDMTVLa0JX?=
 =?utf-8?B?NnJxd01BWG9jSDVUbUdkN0dlTEtQK0RheVp2bDhiYUlZM1Q1RWwwN1RzS3BL?=
 =?utf-8?B?MnZ0YjZlSkFxU1c4V0pDUExyb1A2QzQwVXRPVFBOc1h3UnJOZGh1UW5YZFpn?=
 =?utf-8?B?RE90TjJMQm4vNVdGdEhxYzBEdGtLVFhjeDN1b3JQR01mTmdFaElBdGJsdHFL?=
 =?utf-8?Q?5UPg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798ed609-32ea-4e50-475f-08dcbe338149
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:39:20.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TMVonQ26WZZfLlAh0hfE4D4ZFkwsNUom2jpmHUrjDCa/H9PUZZUMbXsA6oUF90P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Hi James,

On 8/16/24 11:29, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> Hardware provides a set of counters when mbm_cntr_assignable feature is
>> supported. These counters are used for assigning the events in resctrl
>> group when the feature is enabled.
>>
>> Introduce mbm_cntrs_free_map bitmap to track available and free counters
>> and set of routines to allocate and free the counters.
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ab4fab3b7cf1..c818965e36c9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,37 @@ bool closid_allocated(unsigned int closid)
>>  	return !test_bit(closid, &closid_free_map);
>>  }
>>  
>> +/*
>> + * Counter bitmap for tracking the available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
>> + * Each event takes one hardware counter. Kernel needs to keep track
>> + * of number of available counters.
>> + */
>> +static DECLARE_BITMAP(mbm_cntrs_free_map, 64);
> 
> Please make this resctrl limit of '64' a define in linux/resctrl.h so the arch code knows
> what the limit is!
> 
> MPAM platforms may have more than this - and really bad things happen if mbm_cntrs_init()
> passes bitmap_fill() a value greater than 64.
> 
> Even better - could we dynamically allocate this bitmap using the size advertised by the
> architecture code?

Yes. Actually, I was thinking about allocating it dynamically. It needs
few other changes as well. Will do it.

-- 
Thanks
Babu Moger

