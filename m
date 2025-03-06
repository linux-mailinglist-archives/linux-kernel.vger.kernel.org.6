Return-Path: <linux-kernel+bounces-549473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B84A552FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E4D18926CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31D26FA5A;
	Thu,  6 Mar 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vRWqrmmF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAD26F479
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281776; cv=fail; b=NL63AhVxhjC2QKKTxK7aHQ2AdQtnVSaTFLKYbFmmAYgDFkAg49kAt8uOlctw/sowBFbC9PuuBk0ROCu84JBgHo8gxaniAP6TQKRgVatYwxPh3LwI33S75LyG3tFUD4RRMET1D5keBcY/3LxAbYYRl1jSD7HUnQHBtWeLMsAvUTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281776; c=relaxed/simple;
	bh=1+p6A45p1ylisoJuxdVbyFkX0r9mI17oYG+zVdYQASM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6Eu6FnMXibaHt5ZnNUjN6qDS2vK+lnWPRwgt1KW+wa0ImzI/xQcuNIVEWqEmaM8F88JS9pYA8pgaTfkkXkv9Zr93p8+CvmUyollsZzwXHJJnD+9CHqHUcDaRazceQDsmX6R2Hbck7MHMhz/2pbqwYWRU8t/sBxnb6rx31XI9K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vRWqrmmF; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqVJQX+rIk6z/kHb/PjLxAh6Itl8N37qD7M4QImVlBezbnBbgIJU2S9220SOOENBD2iLVZyaTbci3oiXDfiec+DAv0A6UfAJDgP/8fyWHZQrUi4hYOZiJp27a+OIgYmfGulMNJ02Pev4+WgDKKHGeCSEETiYJu610XTnoJavf6FaKg5Mb1doLbFTD+mUSZmi/kxx/JtPgaBVOOrw08aoA1E+s5Ae5gK/FjpLC3I3EqXZ+qs4qZ2Oz/qu7dPJ1jcCv8kMSbjuX1nG28WjQaLjIMQha6rLWgYvixLYW+oIBqarhuHC84wMOnylVskRsKSC23OR05+naKXCHCqlsrZNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6voyGsVvlUxk6GBL35cIC6gN+eicYl1seBiO3SIbRQ=;
 b=gpW2lr7xc78ow1Y9zTKPpcsPQb9+4FNG6Xe6xi6XfFkD62A9g2u7wJLwsjqqzAFNb6MNr8e1Zdv17t95JqrbKAgnD/HVGjQrn+0wlhsu5BqklHaKBBsSfXd28hOqc4U0Yw+y8KIf/Aha5bHOqjmQ7dugq3gx3qHybwuR5muGzxWapdGcc6jtW82MLz1CqgToj3o9++UdSGrNW4E7iaxjhrQMP4ctbxOr91dF64QQKfnNWbjmHpRqGZg5opUwMa178ejJcK/uGVmmt9cmyLrkTA6QwPBmNtTobQLRzlX2NieyoX5cSqiGK4pvDhKRBVc05XwXXsSibR8fNCgwFpsNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6voyGsVvlUxk6GBL35cIC6gN+eicYl1seBiO3SIbRQ=;
 b=vRWqrmmFqtv0SM7ml8zHCDKN4kMNxxBVwYKRakKSAJ4Uz2+s4hbfatdULsBCFm8Yn/RZnzS3tCtLDQWy+KgPpiKDfG5AvgPa7uFaQymQxKXl4OhfobdzSSodTcQXHx58tGmsgi4cFXNC7ThPNo/a4BSD79yg0XvQDgaFOe5+aRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:22:53 +0000
Received: from SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca]) by SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:22:53 +0000
Message-ID: <5017862d-98d7-4f4a-8272-88bcdfa78fcb@amd.com>
Date: Thu, 6 Mar 2025 11:22:26 -0600
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20250306054532.221138-3-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:130::9) To SA1PR12MB5672.namprd12.prod.outlook.com
 (2603:10b6:806:23c::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecd3915-16f5-412b-0f8f-08dd5cd386e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXhxMEM3cFpGODU4RkpRL3pvVU1BVTZUSUUxZkRpMllHU1hwSm03T21NNkFt?=
 =?utf-8?B?Slg4MHMrS2d3cVhBdW13dE9mdUt0SDRFMVZYdFlJUHdseEMxRDFaYTJsRmFh?=
 =?utf-8?B?bk9oSFRVRG4rL1hNVWh5Wjg3elppSmdqYVFWODZhcDlZaEVSZ2JYcTJqb1k3?=
 =?utf-8?B?L1BrU0tQWC9xMzFpSm92ZTRjelEzQVI1RElmeTk3YUdOVVg4YUFqSldNR29w?=
 =?utf-8?B?d1c1a3VyWlBPTHIrRUJzVW10QTRpLzZBdmNIQXJITXl0T012VFNjeHV4eWR3?=
 =?utf-8?B?ZGdYSHNjM1VSNHJIclFZbVhEUmI0NEpyaDRUNXBWM0RPQ2dybThNSFhrZFM5?=
 =?utf-8?B?RnRzNENYRElOczNrdWl3aWlhTC94OE5zUktGMHV5aUtNazJRQm1mUnppbmhj?=
 =?utf-8?B?MTA3MzQ5aHNJSzRRcG1ITVBnOHhzbnUwTjZVeTg3LzdwZmVPNWltMzhxUWV3?=
 =?utf-8?B?UjRIUWpOVEJ0WXZrRGFOSW1iSklNaWNmNEJQNG5Ld0dPWnFOc0ZyMTRJUXA2?=
 =?utf-8?B?VmxENEt5ZWlMS0d5MElGU1pVK3Y1dGFSNlJ3MXhwbTlPbXpjRzVCSWZWODhW?=
 =?utf-8?B?TVdtZ3M3bmF6NG9Id2RZOTlUN3BkNi9nY3RvY2FzZElndmZWK01mQWNCZGw2?=
 =?utf-8?B?UVZOdXZ0TytISStRTWZ4ZlFTaElHSXVXSWdpKzQ0MVcyWXhNK2tIK0RacTRR?=
 =?utf-8?B?MlBBc3hOeVYrNVUxalB0MnVYNElMcmgra2FnZitzdG1XRHVQSGptYVVKZGV0?=
 =?utf-8?B?MEtFNXRlbFR0R3pUVGRaVFVqR2RLR0oyT21vRVhrNExiWVhQRThST00xU21l?=
 =?utf-8?B?a0VNalZUY3JZZUlsbWVmVWtMTGdqNmszaHpsVGtESGhONHpXVEwwekhQSVUz?=
 =?utf-8?B?bHZSd05ZYXI0RG1FUDlONm5ZWkcyeUhQTGY0SnAyVWF0RWhGQ3p5ZE5RVmRr?=
 =?utf-8?B?ZE1ZeWh5NXl2WlhrVURWZ0F3Zml5RHE5Tm9yS3lOV2NMdWc4d1BsRzU3TXA5?=
 =?utf-8?B?cjZVMGhYRjlTSU9UaXVQOUFRQUZnR0pmOGhrcGdWa1ZRRXYranh5VUNQL2hu?=
 =?utf-8?B?RjdabFpsTzVKSmZxTlBkbGIxSFNsdnZReFFVWGM5dDZCeURlbFpOR1Q5Wktp?=
 =?utf-8?B?UGUvcXdyZGkyNUs2Q3RNd1JTQjlrczd3R0ZFZUhVT3FVVC9zRFFnZWJDMUxB?=
 =?utf-8?B?WkpaTTMvTmRJZTBxNDBMdkJ4S0QxM2d3YzlmKy9xMjJuNHE4TldycDExdWxU?=
 =?utf-8?B?SWZOQjVvTHZ2NjBCVG5FQlRkNitIMXZPZXhTSWFhS0hqK0FHNGxJUXFBY3d4?=
 =?utf-8?B?dGVpOHdQcjk4VFZmak9WWGk1OGl2Tm1mMFQrQkNqNE9PcFdhbzlpWW1BYTlI?=
 =?utf-8?B?c1ZyMS9Jd0F4WnhYY2tyMXVoNDJSclhWNlNmMjVtUkJaeWZlN0ord1lkTGJO?=
 =?utf-8?B?R0tMMUNhbHdHd0x3TktDNVRVVUFzOXp5djQ5RmJMd21ycW9qNlR6TUpXaXQy?=
 =?utf-8?B?R2FGK3JVbnFBYWFoQ2RrMjN0dlNHclBKV1p5dXkxM29ZaVZuQ2Y0TCtIKzZv?=
 =?utf-8?B?MlBFaWV2VlVCcHBBN2gvY1lLa1U2RDc4OGk4ZUJQejYvcWFuMytmTWhuMzFS?=
 =?utf-8?B?Qzc4VGduZzlxVlNSNVZSMDR1Q0dLUUpJS0h0ckZ1UTVMN1h4VHlzZzRnTWtl?=
 =?utf-8?B?Z2tWMzhrM1lnYXRPQTRPNVlxelcrVmRFeXJ0R2kzWlJYbUtQSjNMUDc5OERj?=
 =?utf-8?B?M1BtandjWnNGUkhNeG5GcTYvMlF1NDlxTkdSd1VmeFlEYWV5V25MM2Z5L0lD?=
 =?utf-8?B?RkYvNUVYNDNocnVzM1loOWROc1dZamxxWlY2V0s2QTJZRGp3Z3ZoWWhZZHp1?=
 =?utf-8?Q?H4j98z4bmyh8g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5672.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1pFejdPQm1hWHA1TnlWYWZWK1hHYWVLK3hTOU5aWEd3SEljbDlMN29xdE5W?=
 =?utf-8?B?a3o1bTRDMk5hQnRSeVhmcUdReUhrOVV3cGlQYWdHU2RtNzgwOXFJVG5COHVU?=
 =?utf-8?B?NWQ0dTREU3pGQ3JQNHN4MWxERzhnYWZPNGhvcXh3QWx2VW8xdzZIVzZTdHFC?=
 =?utf-8?B?aEtLOGlaeUU1MG5EdDYwQmdidWMrNEFzK3F2a3JDSzBZMEc0Z1JWSkNvOVV5?=
 =?utf-8?B?ZllZWG9INmhQbGNva1BYUm11TzE3VVZTbUFqcVFpMEFYNHArbGhOK3Q5TjRp?=
 =?utf-8?B?RnJoRW9mZ1AwZnZwUTBMSjFXQ2FaazMzb2htaGVTVVptYVBKVmZheWNoWXRa?=
 =?utf-8?B?NkZpQkoxOFRZZUpLajRHYzhvQlZQYjQrK3N5eDhvRWxUai9lUmEwT3pNb3Ft?=
 =?utf-8?B?OHhYWnp0ajVWL3dNWUFzWWpDcHo1T3psMWtSY0VyQm5tcjkvVG1IRm1pNWw4?=
 =?utf-8?B?Y1dLZE5nK3NEODhFanNvaUkwdi9wZVNNZUJkaWJwOHRzS3JQK3d0ekYxd2sv?=
 =?utf-8?B?bzVCVHNrendqamxLdmRmUjdIdWJJNXFMRnd3Q1p3eU5HR1ZIeTZnWGRIS3Y0?=
 =?utf-8?B?OXVWVlNHblRxT3ZZbkVVNlBTT291YjRtMXgxVjZqbkh3Z1pHT1pqNFhOa3R2?=
 =?utf-8?B?SFhUWTV2Mzlyd0pxSGl5QkMyeVg2VHpVN2JiU3RNbVJ3Vk1kbGlsZ2FLOE1t?=
 =?utf-8?B?bHV6T1J1OGl6MTMva3A2N3BGRnIwL0ZsbmVST2lraVZuMmUyWGNGc2JnT0hR?=
 =?utf-8?B?Y1ZGZ2NVY05WNUV1NVFjcTZKQkFBTHNHd2FoejgrSU5ka1NrYkRCa2svc09M?=
 =?utf-8?B?ME12K1RaUWhIMTJoZGlMdmx2blZwb29RNkw3eng4NUZBTm5zV21PWnhzcnZE?=
 =?utf-8?B?YW1ac0cyS0dla25tcngwVTZEU1J0akp6TkM1M2Q5QjUrdVFCZjRQUEQzNlQ5?=
 =?utf-8?B?dXlmdkMvZnhaRTRrK2gvRWtxeHR5S3NUR2hKUWMyTElqcDloSjJWWWhWRkdp?=
 =?utf-8?B?K1ZxZnVkZ0N3TFNPOHg0OEN6U3hMa1ZvSjZ1bjdHSmxuYTAxVzkzdG1iTFBY?=
 =?utf-8?B?dm5LcitCNFN6MHhXeUlTdWZiUTJ3TmVMbklMZE9hRDJBdGM0RVRxSVN6RVZP?=
 =?utf-8?B?bVF1THJOWFpYbG85dXdub3FyN05JaEZ5MmEwbjNXbVlKNmFCaVkrcTBrK0xM?=
 =?utf-8?B?Zm95ajFSZlpMWVZaVTN6K2dGSWFjYXF0RkFKbk5aY3h2Q3B0blpPUDFRMWRK?=
 =?utf-8?B?UXZ1R3pzTWlmMXhIMmtYREc2RWlCdklmMmZ6Q0R4VS9rYkswazdKY0VjVjhD?=
 =?utf-8?B?RlBzbWxWdDBUUmdoRm8rVUVRQ1N0cDIrZDJRbHZ2c0VPOWtBR0lNd2xuRzlt?=
 =?utf-8?B?L005b1dTQzducnRmNkZadlZzN0t6THZqckIrTVlVeFlBYWdLT2lCc1VjS3Rs?=
 =?utf-8?B?dDlXWEdRRUpzSmUweVJMeWRVRUNwcWdsSVZkSE9GOEtCTC9ubUNUbmRZZ3Yy?=
 =?utf-8?B?RzM2cGc5Qk9rNVFEdjNWUjhGcXZwS0NUTFN3ZkhVSGZwYkRJZkFkRVVHQ09E?=
 =?utf-8?B?akJaeFl3a3ZlZjZUUGU5UGlnSGw3d0lsOW1Md21DckFYUGRmVVBpV2Z1NXA0?=
 =?utf-8?B?T1NPZHJrWlMyK2RiaEE3ckVMNElNSlNDVVJUaCs2bDZnRFV6Wk43bEIrQmN2?=
 =?utf-8?B?bnFkdjRQd2tGWXB2Z2xTdFNPN2pJSEVMaHlLVUMyelh6Y3M5NlV3ZnhsMHBT?=
 =?utf-8?B?Q1NvcEc2bFBRa2NHSTJjSDRZbVBpbU5kOWtkd0x0cDcvNjJjbEVTck1mSlRI?=
 =?utf-8?B?ZzBqVG1NR3dLSTdhL0xLRUxpS2d4SythaGdzVnJ1d09BU0x0SDNkdkRacTdJ?=
 =?utf-8?B?K2JsT1YrV2ZIcE1CZzlWVkRrc3ZUNWtEdFh0QlJ1T0RncUpYS1h5ZTI4Yll5?=
 =?utf-8?B?d1VmdnVFalRGWEthbGZWbjVaVGJXWHRNc1psaWgySkwzNUlEWU4vUVo3T3Bm?=
 =?utf-8?B?QTZUTFdnS2p5UG83UXZoV3k4REZSTnZBRFBXaWZBbDNGTlRqOU1rVUdGdVlj?=
 =?utf-8?B?Syt0bGUxeWhlQkh6WlFXbEFMTTVjakh0Y1lGUkFSdGcreGtxMVlCd1B2dU9v?=
 =?utf-8?Q?EZeuhQGkioJBx9GEPwQ2TM/wi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecd3915-16f5-412b-0f8f-08dd5cd386e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:22:53.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCX78ypGUSDCAQEwhrf15g70wib1WY3xiLmaSTpQ97SbFj6/t64JxF9XVK/+lUwdzUB0OaqitLSA1Ek1T3z0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583



On 3/5/25 23:45, Bharata B Rao wrote:
> +static void kpromoted_migrate(pg_data_t *pgdat)
> +{
> +	int nid = pgdat->node_id;
> +	struct page_hotness_info *phi;
> +	struct hlist_node *tmp;
> +	int nr_bkts = HASH_SIZE(page_hotness_hash);
> +	int bkt;
> +
> +	for (bkt = 0; bkt < nr_bkts; bkt++) {
> +		mutex_lock(&page_hotness_lock[bkt]);
> +		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
> +			if (phi->hot_node != nid)
> +				continue;
> +
> +			if (page_should_be_promoted(phi)) {
> +				count_vm_event(KPROMOTED_MIG_CANDIDATE);
> +				if (!kpromote_page(phi)) {
> +					count_vm_event(KPROMOTED_MIG_PROMOTED);
> +					hlist_del_init(&phi->hnode);
> +					kfree(phi);
> +				}
> +			} else {
> +				/*
> +				 * Not a suitable page or cold page, stop tracking it.
> +				 * TODO: Identify cold pages and drive demotion?
> +				 */
> +				count_vm_event(KPROMOTED_MIG_DROPPED);
> +				hlist_del_init(&phi->hnode);
> +				kfree(phi);
> +			}
> +		}
> +		mutex_unlock(&page_hotness_lock[bkt]);
> +	}
> +}
> +
> +static struct page_hotness_info *__kpromoted_lookup(unsigned long pfn, int bkt)
> +{
> +	struct page_hotness_info *phi;
> +
> +	hlist_for_each_entry(phi, &page_hotness_hash[bkt], hnode) {

Should this be hlist_for_each_entry_safe(), given that kpromoted_migrate() may be
running concurrently?

Mike
> +		if (phi->pfn == pfn)
> +			return phi;
> +	}
> +	return NULL;
> +}

