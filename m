Return-Path: <linux-kernel+bounces-225029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92D5912AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FACE289F84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F9839F4;
	Fri, 21 Jun 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0REpenvt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD7208D4;
	Fri, 21 Jun 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985704; cv=fail; b=MNAcqT43WSe3o2xV1ax0uSAy7lNOs5zC4oEmRKc5eQeDN43LwFF1sW9yRyR02FBqPnBuaq+gs2UACJxR+5f8iqky6rMG6kHz9ZebJGmUWID84VmdtDL2rypg6oFvsvpOp5SfMF1gGI9ddjqry5FUT2j63dMSD8GwVCQUs8RqbPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985704; c=relaxed/simple;
	bh=FithvioSXAIMKH9mhg9kpPiW9PePt3NN+TtJHnRExHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/vdTjz3GDJjskyA783azJ4M1B4h4HSrhxKGgyuQ8oJYbOdS9cWhNEW+nSfJCTPaeSHKZcYHpBHaNfk1XhorDe4fqLZpFH5ZvS5+KfUKjPfY3quOTebfFYD3IbPZXVXLLBXvbX3xSF38O2x1CtuGnYD5ZGPnqgLQ77z7b1gozos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0REpenvt; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fySNqKxo27ml0p8wiLryDtN14PWWr8Zt2CrXLSr6JumHDeNqEyVAsl+CIiWisjPrHPBVlEJFveu/7VDe7+MjhDzn34u4GPak+QmcLpy2+n5bbG4zmWXY0R/wM/3nMGUqBTfOc2BKPgFSojIYGpxe3fim5iAfyxwXOpOt8M90+FwEjVXiXQt6lUlNHPmdny4FYmEqWxGuzG6jnW2BLxbybkGucD9D9G7Y2/zrNQi63kpR/McGNVvyNzMg2w0tIpje1Ybjw2hYqQQhSYs2fnAl6pjiK5+mai4TJsy1ijmllMvWV0p/Z1nc//+7lROzytpXhTg/BWeu0Wo0b371Xg6K1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4a0JsZ1vFRRVyPbbj6KgxuTwn4b076lIXw82HRCR4o=;
 b=VqqKQCHyr3pV8Z9ra0khUUbnvtC6u9ustKW+Ax368IJ7uZoMK1spu1YPV5aEJruPFsdYlfzeO144H/bsv6Z99Jzddd5RH47YniICbC3frravp7lNpRGb3mfwSAP7FDsKK9gTSuTxYLx0Ss4TOm0em0wnigqIDqYYBCYaiEaC683/yvhPH5teBcEfSkZOATR2oAQBJ4JgRsoamt0iG6SwNR0piXsUMHQ7yV7I5iU7NvmGjTL8VKJhoVKCIT5ZXN5tTSaIf8XaXkCE6QHUfbjFpipfHUw3Tv22BEUAw7lwUSsZG2jiddY7W9hsK43SU651UwoBlM2mWnsrMo56tdeZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4a0JsZ1vFRRVyPbbj6KgxuTwn4b076lIXw82HRCR4o=;
 b=0REpenvtlMi61YnUTs7ZWdPFZcfR6oKUHcPyvVGXOrdK1FrPmVBPTYUynNTm3sPqr7UDuh5p1fXcCOhXiaTbvb9WmWX0B7Bk9xlQLlOg5SJ/nd+m4kXMw8dTx/1cey7j+8dxeKRgkmuGlL4eJQgwqxADJJ07oyQ3gwlebEz51e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 16:01:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 16:01:38 +0000
Message-ID: <ace7d045-1717-c8fd-8723-59c2cd8feecf@amd.com>
Date: Fri, 21 Jun 2024 11:01:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 09/19] x86/resctrl: Initialize ABMC counters bitmap
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <62fe683f-3a4c-4280-8770-d2aaff478d33@amd.com>
 <5df878a3-2b47-4027-984c-88e8ac34de05@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <5df878a3-2b47-4027-984c-88e8ac34de05@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7555a7e0-367c-45d0-8b38-08dc920b6ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amxSU3BSMTQ1YStvaXk5L1FVWlh0ajhhTGZKcFlwbFJMYWtLZmRpVllUSnA2?=
 =?utf-8?B?LzBTL01qTSt6MWpOaWhEOFpYb2hUTVNJYVBkcjhCbTFFc1NmbExtZWc1YXZw?=
 =?utf-8?B?SkhXbC9JWTRvMXlhclBRZ1hBM2UrWXhaREZneUxObGxnRVZIQVZheGZRajR0?=
 =?utf-8?B?NmVueFRhazRwVUcwTnBvZEYrRWEvZmZSdXgrLzNFbk40SkV3TzdGNEo5YWdT?=
 =?utf-8?B?NTZKREhtVXFCeFFycnBUdmNzMWR0NG1weDdBMHh4SXR6N0w2aFpUTnJ6TndC?=
 =?utf-8?B?M1lTUld6c1BaMnNGeWVRS2lDMlE1VEN0emFxM2dVMisydDEwbTBGZlFyN05n?=
 =?utf-8?B?QnJlc2h2aDZaVkZKQ1JCS3FiM2I3Y05GVGtjMS9xN251RGVBZkdlc1ZMcDlr?=
 =?utf-8?B?Z1VPYTQzcHRsZUoySVhsUVRySkZzQUtnMUcxd09MdDQvMVJqOEpmU2xRNGZh?=
 =?utf-8?B?UHhYeVBKM3o4SE1BbEVpZGFJUHB6QmxjcFVPTzltdm9NZFY3K1BjZjhqamZ0?=
 =?utf-8?B?aFN0MjdmdFNET3JKdkg4NmVadElrUW1LNStHSkFxM2hsWWJyamE3d2Eyb0lK?=
 =?utf-8?B?WDJmYzdLcFZKRGwzeXJQV25PeU02U1VtYXM4bkZOUU4wb05rOHYya3RNZzJs?=
 =?utf-8?B?dWlocHNCUzVNSHlka05mZXhzSStTYkJ6dll6RDNFNFNXTmN4WUVvdGhNTmFq?=
 =?utf-8?B?NFY4T0MwRi9TMWh6VVYza1MrLzdMb2gvVkhyQ0diS2xjOFhzaFdPcWh6b3F1?=
 =?utf-8?B?RlB2VVZFaHdPb0FmbndrNHc0ZUpod01Na0I1blM0enBsalQxekRETWNibkZu?=
 =?utf-8?B?NU54WGV5RWVMVVlLc0RaQnh0UHBJd0JlOWtQSldjSVpOZmo5dks5R2ZYcXMw?=
 =?utf-8?B?TTEva0JTcG90T0lHYWJvV0FIeGcrNXBwL3NMcGdhRDE1cHlLd0NwcU44a0Yw?=
 =?utf-8?B?NUxVYUZ4MHpWMDROVTZoT1ZoYjl1eFZ3Ni8yL3ZpMFZMSVU1UW9UUlZRUHJ5?=
 =?utf-8?B?UktLbVczYlpVdU0rNHh4d3FpUmxYbmNpbFMwNFJMWUlkelBONXRuTWtIbzA0?=
 =?utf-8?B?WmJBaEw0STFqWlF1Zlg2V0doTU9oRTVaNS9Kb2RONjE3akFFSWVneE1jYnNV?=
 =?utf-8?B?ZmxiYSs1KzNCZm5zYWhTVzRidENVTDJvWnF2VDRjbXBvZTZ0K0pjOG5ndmti?=
 =?utf-8?B?VE5WZjc3MkVOOXB4TXpmVGpTNzRjZ3FLTGMyRG9semJjTTNWb0h2Zmh0UExt?=
 =?utf-8?B?Y0NiRDE5OUpLNFlKdVRic3VoTGFHeC9VcnlDWkZvL3lFZ2xYOG1UMWtVNVlo?=
 =?utf-8?B?dTg4Rk5HYjFNLytFYjdNeTBLeGtvakNFTGhXK3Y2a3dXNjd4OFhWamtybWNw?=
 =?utf-8?B?UkdoVldBRWJGKytxSU5WUEpYcnBKYno2SXQ3MmhrNUpITjhtcUt5dDZ0SUlQ?=
 =?utf-8?B?QWR6NGY5RG1JZ1Z5bk5YUnZHWUZvcDhiTkR6V1JSYUR5czF4SFNldUVpMjR1?=
 =?utf-8?B?Y1Z6L1FUSHFrWS9hOW0rMVhZR2ZUbkxQbng0N043QXRlWkFXcjM0ZHRtbVl0?=
 =?utf-8?B?UjkySnJKN2JQT2lBQjhNckpTQVczMW9FbHZPTWR4NUViRHRWT3B0aERwSXFR?=
 =?utf-8?B?RWJ1WGNGU3ltY2J1ckIrS29GcWpUOGdCVHExQUpIclZRS0lCWDMyeWVYK3Uw?=
 =?utf-8?B?eHNPWUdFK2J5RnJHZUU2VmZlK1V3NHlIdmlheVhxTTg1UmpWbzQvQ05WUzUr?=
 =?utf-8?Q?neAhbKp1I4Vigbn1lI5bCJAj19kOfbnFcnHNlOd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0laR3JUSHdtVyt6eG94S245dHR1dnlJQlBkQmpaSDV6Z2dZeDBNQUhlQ1RZ?=
 =?utf-8?B?R0RBMEtJUGIrYXB1NHJ0UE9JeFh5N2hDSHJrMm1nVEwyYkhKQ0F3RnB2WWxr?=
 =?utf-8?B?Y1RGU1JtZkNUOWcxMlBzZEN1L1VkdnJheVlyTUtLaXFNMWJqTTNuUTRIRXpR?=
 =?utf-8?B?TlczN25jUjNvOXQ1OUVuSjRrMzl4UGxoSTJDTk5LU1dyVkxtZ2tnRDJmaExC?=
 =?utf-8?B?bmJxNnJ1aGdaMWd5cVpkQXBjc3pmemJJUXMxNVltU1ZBeEFIYjJlamovck1l?=
 =?utf-8?B?MDl1VGxHeEcvUisxMFJaUG1ieTJ0b092VTJqMDNEZHlEMllkNlhPdm5LV2ZQ?=
 =?utf-8?B?cnR5Yjl2NFhYcVF3bitpcXk0N0hadHlPSzd0K3Q2Z2dCL0JzcUxVeC9RMEp1?=
 =?utf-8?B?OEdqRStYYy9HWHZmcWxEbVhLRkNlRnQrSEdCSDBRdlJNa2NiK2ZJL2lHU3Ez?=
 =?utf-8?B?czRvMHVOaWJEOUxNSkJXNDZSYXFvMnI1UXNwWXRsdHFQZW53Yk9xSkpadDRh?=
 =?utf-8?B?RVp0ZkNoSy9yZEVpTnBuWTM2a2tJVi9KZHlDSW1jRGRYQ2dLZWVZYmdWZjBq?=
 =?utf-8?B?Sml6V0xtcW40em5DMTdGdHl5b1VCa1BHWTBob0hvWnZOSWZHRDhsZWRKOHM2?=
 =?utf-8?B?L0xtb1F2V1dldWQ2bU9YK3NNNkt1bjBYRzdMUlVkeGlWOEJPN2cvQUhIdm1K?=
 =?utf-8?B?TXlxd212c2ttUU91NCtuYnVXMWxlWXN2V3dISGtEWUM4S1F5Z2hQWmROOXMv?=
 =?utf-8?B?d2NLaDkwRWdLQit0RzMvSkpmYkFwQ3gwQ01XWGFNQjF1L1JyWE5URnV6bXZ6?=
 =?utf-8?B?V1F5V0ZqNWF6a1F4Qlp4MzZPOTdYRzM2Z2phWmdTblVZSVN2bjIyL1Nmb2xq?=
 =?utf-8?B?TURCc0xUY0hFQlYvdXlMVW5WeVJkc0xlWm9Lcnk3U1MveUNGWDVQVitaQm5N?=
 =?utf-8?B?RllSVTVrWmt1SllxRkQvRkdFQWExY2N1WlNhY0lSeEVXNm12eTdUL00vYm5t?=
 =?utf-8?B?TFNtS25JUmhBODZwQSs2USthaVk3Ull4OTM5NjZ4MS95L3IycEY4M2VTS1NN?=
 =?utf-8?B?MXErTkhsZGl6Y3VnSTRPVm9rNUVRRjBieUdsZ0g1VWlsL2RuUUc1N0xVTGQy?=
 =?utf-8?B?dWQ2YWdBR002U1JkUmtCZGJudkRTeHliaDkrcWlScUhxOWFDclZVcitXY3pB?=
 =?utf-8?B?Nm9RU0RlS3p6WEJ1K1ZvUktnMnRKN2lENFY4eVdPdXZ4Unh1RmtONnRQVUJm?=
 =?utf-8?B?ZEsxNzN3Y2JwbFIyejhCUDU5QWFSb2RwOE1wK0pQekhxbjVlOFF0d0t3L1VS?=
 =?utf-8?B?eDBXSG5sVlBGNnBTUlVCbVdqcTlKMGthZVlPWnk0cHlzQWRHRVBZa3d4NkVk?=
 =?utf-8?B?MFU3TEZtRXBJUzJCbDNUbDg1RUc0bDNYVGhiUUNDczNtS01Dclp2aXVna2NM?=
 =?utf-8?B?d1hGZ1dnaU9QdFBPSG5xUmZCelpKZ1JlTTdnUVFCS0lIRlpFNlU4bFZ6NGZ2?=
 =?utf-8?B?clNRUkZIZ04zTHhNWnVCc3VpVStzdGNFSmFQeDNGbDZmK0lLSGhHVVY4MFlt?=
 =?utf-8?B?QnFhc1RqY3ZUaEpBM29TL0xoUldaYXBlZGdubys2ZjQ3VEo3VjV1TUk5WnJR?=
 =?utf-8?B?cVIrZ0pNMjArRUdMc296MXZsaGV4eXd4bjNsOFltWkFBamU4THNmcmJuVkNo?=
 =?utf-8?B?dThzTGtmbm1IZkpMWVQ0ek5VSzUvb0thYUtiWDR1WmV2UlVkL1c3bUFkSUhX?=
 =?utf-8?B?UUhUTjF0OG5DWmdYRldyaVorTEVMVDZSMlArdEsvbitQaS9KaE81WldEamNr?=
 =?utf-8?B?WGdieDBBVUV1OGM2YW5wOHB3ODB1N3ZGTUJIVFRsK3llaUVyWGJnQ2hnV2Jw?=
 =?utf-8?B?ZmtOY2pXWEg1K3Q4R09KcWJrZHZGNm14ZUIvSjlaRnJkc0Z6Q1I3RS9jVS9U?=
 =?utf-8?B?TVRpR1NBNCtkTjIvcHBDZEF0TS9IQ1ZESnhqazl3OWRtY2VCdXVLSnVMcEUv?=
 =?utf-8?B?MHV3SndqMFVHV2NRWExvTzlPRldOay9oYzMzNUJBN2IxYThacjl2VC9FNU5J?=
 =?utf-8?B?YWVVODdUUDk4Y1g5YVVSdkhnSy93STcvT21QREpkdE1CcGdWdDBHOVA3R0w1?=
 =?utf-8?Q?HYvQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7555a7e0-367c-45d0-8b38-08dc920b6ea9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:01:38.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+7nZY36SZXAFXeLOXS5E1E3Mywnmms5F7M9pxTRI/fM8J60er8L/eScjLSO9iyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

Hi Reinette,

On 6/20/2024 5:20 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/19/24 10:03 AM, Moger, Babu wrote:
>> On 6/13/24 20:42, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
> 
> ...
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 3071bbb7a15e..400ae405e10e 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -186,6 +186,23 @@ bool closid_allocated(unsigned int closid)
>>>>        return !test_bit(closid, &closid_free_map);
>>>>    }
>>>>    +/*
>>>> + * ABMC Counter bitmap and length for tracking available counters.
>>>> + * ABMC feature provides set of hardware counters for enabling events.
>>>> + * Each event takes one hardware counter. Kernel needs to keep track
>>>> + * of number of available counters.
>>>> + */
>>>> +static unsigned long num_cntrs_free_map;
>>>
>>> Why does variable have "num" in its name? That seems strange. How
>>> about just "mon_cntrs_free_map
>>
>> It came from patch 4/19.
>>
>> struct resctrl_mon {
>>          int                     num_rmid;
>> +       int                     num_cntrs;
>>          struct list_head        evt_list;
>>   };
>>
>> num_cntrs_free_map is a bitmap representing num_cntrs. Kept the matching
>> name for better understanding. Renaming it will loose that connection.
> 
> I disagree. The "num" in "num_cntrs" indicates that this variable stores
> the _number_ of a particular entity. In this case "cntrs" or ... counters.
> This is just like how resctrl uses "num_closid" to indicate how many closid
> are available and then have a separate "closid_free_map" to actually track
> now closids are used ... it is _not_ "num_closid_free_map". Similarly,
> "num_rmid" indicates how many RMID are available and the "rmid_free_lru"
> tracks how RMID are used ... it is _not_ "num_rmid_free_lru".
> 
>> If I rename then I will have to rename both.
> 
> No, you do not.
> 
>>
>> How about mbm_cntrs and mbm_cntrs_free_map?
> 
> "mbm_cntrs" does sound good. It is more specific than "cntrs". I would 
> suggest that
> use "num_mbm_cntrs" to match with "num_rmid" and "num_closid" and then
> you can introduce "mbm_cntrs_free_map".

Sure.

> 
>>>> +static u32 num_cntrs_free_map_len;
>>>
>>> Same comment about "num" ... also, any special reason why u32 is needed?
>>
>> Only reason is, it is supposed to be unsigned.  I can change it "unsigned
>> int".
>>
>>>
>>>> +
>>>> +static void num_cntrs_init(void)
>>>
>>> mon_cntrs_init() ?
>>
>> mbm_cntrs_init?
> 
> Sounds good.
ok

> 
>>
>>>
>>>> +{
>>>> +    struct rdt_resource *r =
>>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +
>>>> +    bitmap_fill(&num_cntrs_free_map, r->mon.num_cntrs);
>>>> +    num_cntrs_free_map_len = r->mon.num_cntrs;
>>>> +}
>>>> +
>>>>    /**
>>>>     * rdtgroup_mode_by_closid - Return mode of resource group with 
>>>> closid
>>>>     * @closid: closid if the resource group
>>>> @@ -2459,6 +2476,12 @@ static int resctrl_abmc_set_all(enum
>>>> resctrl_res_level l, bool enable)
>>>
>>> resctrl_abmc_set_all() was initially created as a complement of
>>> resctrl_abmc_set_one() ... but with more initialization added to
>>> resctrl_abmc_set_all() this relationship becomes vague.
>>
>> Yes. Understood. Let me know if want me to change anything here.
> 
> How about renaming resctrl_abmc_set_all() to _resctrl_abmc_enable()?

Sure.
-- 
- Babu Moger

