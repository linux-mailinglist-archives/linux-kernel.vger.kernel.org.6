Return-Path: <linux-kernel+bounces-395755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FEB9BC26F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D7283485
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313F18EAD;
	Tue,  5 Nov 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZjaRQvf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70814A82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769626; cv=fail; b=tYWItMZheikWBDdoiJDsYIQ7BWzFlK1TR+AoykaqIfwzMT3vjQCA7nnF3/lriI1XWBBKmpYavTwFrqMVjHG+k9uFKJZseiZ5gpvOG3INmFlgnvwN2RKaw0gGaPiPxzSKIfdHL6cLNwM1HE6Gt6JAVvB4nwiSVIRW8V27U63qmn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769626; c=relaxed/simple;
	bh=mL2keNtkrtMi770uJEStXSp9eXVD31Uulgc0gveH0wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AGFX7L9jAZq5AfLLzqWQH6bJ8GJ4KdSDq8mJLQB7kPR/Die6uWvk/g59H3Rt0q62tc3WMwxnvhaaC8g+BJjFYEfo4HqhXv77T6j2x5NSeZnccLyoaBdnthpOisBrptOb/PN2Kbzbrn79KCEInQWHN8gvgxpxYBH2ZvxQA/t2QX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZjaRQvf; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2YS3Szirxrg47PxXzQDzCxwVyZDgdVeqQF4/zLxSjpvOOk/jafPlAMHRT6b7nwxL42sfqbHx83CtUofmE1CZBi35b6nUFO6cfzLfNXweltN8wJpAlPLBpfWEqRJEI/czDs8qdpi1l4PljABUk6TL/hVmS5sMaTyIC0jwvjtVt8jNaz0IaB/OENM6ZZmf09VFZRdAQXrVIGpcyk+VC30uMBAvHIjnFwdzC0GldqZvFuh2GS89/Cd8Q7diHMkpoIONygFOzKQ1FNQ82xeS75BShFhFJszBho95ATjg9xppxVgVKbDbhLFixobVe6wHqaTBNrybqgOjm+DKjFmsIyYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BtiKx0q7x2uoMqzsi5XxcC8pY5pIrnQBbxnUPrWt40=;
 b=HikilfTbS6ZpqwNQDjL08GUoJ2zSl7Iry2jvQmK59yP4WRILsrrJqsFOMfKyY6QtpAtR/XIZc5+WC2kaM38w+Nyo3nVRQBZtcY25r3w2ha1uUGLIe+MdxzZDbRQObZ0bSlXrcDb3OHBIbU8YFTbUO0zAtPLVHiyDhbxOyeJaywPyxD19JDYWYH/1pk/WIpKa03zNX2lEvBhfYExCGclr/bqscdS4P6gX09kBYil6nZimY3Z8bpe9CB6vDnnbgNvIB/Ag5wdCDH4wEA5JkvD9jSSghFV2g1/drrhgG+ipi3EE9McCzNwAyeTzBMwqtNVhQIwp3cwyCOqBnjdbbdF68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BtiKx0q7x2uoMqzsi5XxcC8pY5pIrnQBbxnUPrWt40=;
 b=wZjaRQvfFsxLh95ZN1Zpk1UO05AvWLFFuB3rrSn6lxeRu1kyrUDSeAEYaa8kYSVvMR0nWrz+x37NIzGrZxXBECrHh1cBErrrOIL33h9fMUuMKRFgtRstvyXz0f6HKboLuf78OdpsxeaXOff/RFj/xv8WAzpOJJop4vgjIzjxm9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 01:20:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 01:20:19 +0000
Message-ID: <f8055028-aa92-432e-a950-6851c1d69b60@amd.com>
Date: Tue, 5 Nov 2024 12:20:11 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
Content-Language: en-US
To: "Xing, Cedric" <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
 Mikko Ylinen <mikko.ylinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
 <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
 <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
 <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbb35b3-592e-44dd-eb72-08dcfd3802ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1RwS2hTYnBkY0lWbktDRXNNUVg0LzZoZk5ZbytacGdUWDJkM2F5V3dYYmF3?=
 =?utf-8?B?d3RmK2VhRGwvTkR5L0tVWGNGZ3FtZlNBc2JSU05nYUNjaTRwY2ptNHB0MTlm?=
 =?utf-8?B?ZlpqTGdaN29POWtVV0hrQmw1aURxMUxNQUdJNlZwc3BySTlhclpzL3FqUms0?=
 =?utf-8?B?TlM2WFVuemZjRzgxSXBPSk9mU0p0WHR0WmdiYk0zcnBDcy9ISjloQ2ZITlpW?=
 =?utf-8?B?cGxGSHNTTnY4QzRieGpqQisyb0FIRzBCL1Z3RFRwcnFQUlV2ck1GSmpFNzdB?=
 =?utf-8?B?NmVRdGk2Zk5YbW9hWEhadVlLZTlYZWlDbHY2Wlh2d3pUb2VvVStncmF6cVdk?=
 =?utf-8?B?Y1E5SllVUWFzZmJqRysraHhHdHJkWlJneW14TnhtQXloeTBnUnYyUXpPTTFQ?=
 =?utf-8?B?RGE0dStQbXN3dTl2S1hRWm13cUJabnpVZmFUS3BKcUFjcHorN0ZyZWV2U2hX?=
 =?utf-8?B?ZnN2QVEvSFNnSE5EM3g5OXkyNjN1RU80WXdvWk9xMmNWK0xyUTNVTWVMZXFl?=
 =?utf-8?B?WDFqSGRXYmV6cVV3MEtWRFBXVGJBQVR6V2xhcFM3d0xMVFMwV1pZWFJLa2pa?=
 =?utf-8?B?OUQ4aWJBV1VYS3QvbEsybElpaGU1c0NTc3FwNTlUVTJyZWNDU2NyZVZjMXly?=
 =?utf-8?B?VzhxUnpyYlExUXcxWTM1WXdRR25SYVloRFM3SUl6VGZYOExaejhqeURyc1Bo?=
 =?utf-8?B?UUtOZ3hDV3RoRjZlWE9QWTFMbnR4WFdMWnEyN0hoUGdMOWZBbzhNbUZhV0dW?=
 =?utf-8?B?Y0lEakw5VUk4S1pUK1MzdHJZYmZGWm9aQ3lIL2NjZWl1RkVPcnFNM3Y0NDZq?=
 =?utf-8?B?QW9zM1VhTkxsNGdKMlpTRnd2UFp1ZVRTM2lNclhQaGJqZ1JoNGFvdk5pcWZQ?=
 =?utf-8?B?bTdxWW9Hd05odGVTSFZodWVmZXhpU3hyMGJUMGt4ajVLWFdrOFdZMVNQckRm?=
 =?utf-8?B?eVAwQlV5Y1JiUlIwTTFyUFB6OTJIL0t2SS9FMEVsbGVMQ29LWTFJTVZiVGpn?=
 =?utf-8?B?N1Qxd3p6KzR6STllYkdETlVlNjY2Rm5QeVZwTWNWVm5LZmRqL2RrTGIzVDho?=
 =?utf-8?B?VS8wU0laUjlhY2VFUEZsTjhpSGJPaCtlT3FKdURjelBYUVd6eXV2MXdHdERX?=
 =?utf-8?B?azlydkpNQmpmQytRMGxSb3ROdE1ORHJrQWM2NzBpNjRSWW5HU3RkaC9HZjNY?=
 =?utf-8?B?Mkk0NnpsdS9YSjZIYzNuOEFjL3p3eWQ5dXBZRlAxQWdrUno4WjJLMDYyOGd2?=
 =?utf-8?B?UHE4SUZwQytSNFQ0Q3FSL1EwczZVSTRONDNVTkRYM2pSK1hIa2R2dkJUbi9U?=
 =?utf-8?B?OGRCOFRvT2RpMno2WWRzbTVNdHo3V3JtMFZaakg2WkU5QUJuNkgvWW1ja2dy?=
 =?utf-8?B?WGZBUHIwQVp5dWtPMGtHaitqSFR3WlRQRmp3QXIrRkJlN1hsM3p1ZXhtMjRD?=
 =?utf-8?B?UzMwK0pGMWplQ0xWSVI3TWVObnpTdlBDK3NzZDVqYnhnNno2UU9DUG1CdlVW?=
 =?utf-8?B?cVNZMlkyY2Z4L0EzWG90aWloUkpTSDd6cURLRVB0enQvbWpDV3RCQit6N0li?=
 =?utf-8?B?MDU5cCsyUktqelZvU0hLWGpYVzZyRXlBVXpGaVRuVWdoWjBsZXc2MWJnOGg4?=
 =?utf-8?B?MUFIOG1MdWtqNU93S05yQW9ucmQ0WXR0TCs3ekFDWXVOdURWWlNNYjVUdE8z?=
 =?utf-8?B?dVJJUzBUb2xVYk1DSzJSdkJYS0N3cUMzOURoRktRUHBRRnRWVmVML1FXZlhz?=
 =?utf-8?B?bnFVRithQUtoUzIyVEZ3azNKb3NvVzFXRnk1ZkhhRkdoUkNONG1EdjBXdUpV?=
 =?utf-8?Q?nI8aM0dRnnlFq47eDlUqYn2ocXllyKKB5EOEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STN6NUQrTjJCM0pCT0NYc0l4TXdmTHFzcmpnMEZGbms1NDJKcjVSOUI0Wits?=
 =?utf-8?B?eDl6SDByV1Vra1M5dGRYdGpNd0VkOE5XaXVzUUZCN3Qrc2pjK3Z0SERJL2Fi?=
 =?utf-8?B?NXNFN2hmWHdwV1ZzTzBvT3g0czZUcTAxVDR2SVdYZVJjdXBueGRqZnAvZml3?=
 =?utf-8?B?d0Z0eVgrRG02TnF2MjZWSWtscXUybW42bTFid0FQaWdzTVZtZXEvYmpobWM5?=
 =?utf-8?B?S0lhV3NGTHo5bEJuV3hXOGlMVThCV1NmL1pyc2svT1JzQm8wUzhRZERadno1?=
 =?utf-8?B?dFNxOXpvS2hURENWbzEzckRqbW1ZaCtueElVckdjQ2Z1Wm12cW9SNnZXMVBC?=
 =?utf-8?B?d1lNTGtJTmtHb1RQTHZ1b2pOVjI5OTRKdXNkendMVFptM1BadHhsdkVvZk5w?=
 =?utf-8?B?VjhlZDExd3EwSks4WGRpZE1pMGFJSll6Wi9QYzNtV2JWUzFJMjNrSEJzM3RY?=
 =?utf-8?B?c0FYNU55Qm1aYXlIbWFlWjdHaWRFcUNDWVdBNkFYMWhOeklFNHVwL1Vjd0Zx?=
 =?utf-8?B?MHNGcUtvMHdraHVqeE5mM1BFTEJWMFBwbEpYK0Zyd0NZcWZWVUJDd2R0Tkgy?=
 =?utf-8?B?VWdZdTBsOUM3R1JTZnhxMllQNW80eTBIT0ZiekpDcFlmajhoUEg3MmpkZ2xX?=
 =?utf-8?B?UUJPU1lGSjJURldUM3pna1hBeWNjY3JKQ0IvaGVZUnJGTHRxZHFUZVgrT3A1?=
 =?utf-8?B?TE5JK2tJU2Rxd0pIVk9WRFZVdDY3dTVFdFFWWU9wMC9MRUt1Q3JjTTRlam84?=
 =?utf-8?B?bnI5cDRyeU5uR3p5UytsakZ2M3N2eFdZMTkzM0ZlT2dsK3l2dmd1ZG8rWTNy?=
 =?utf-8?B?NDNiS01UK2I5RFZPRWw4dU5ISHZ2bmJvcDJoZ1hLVTNrYzdVU3FHNnd3d3Fh?=
 =?utf-8?B?cHhJYzZTMDBYWlFPajFmc2VNUkNra3JjTjdxNkNFNVhwYXFwNEpJTDEyWDRN?=
 =?utf-8?B?UTg2MEsxREFhMElLcXZxalQ1RStJSXRwNmV1OFk4SmN6d3NGSWJUY3VkMW13?=
 =?utf-8?B?a1IwYlN2UTA4dWlmY0lBNE5wcmlLbnI4UlNjd2w2KzBQT1VCMURjZldNbUtV?=
 =?utf-8?B?YlRLdnBabHROZWR2S0FzMjlMbThvYTNwS0VnR1QxRGM5UUs0aWhBVjJ2K04z?=
 =?utf-8?B?K1REbWJRbTdVSnZQamxURThWK1hGNTNZck1iMFArY1dlTU4ybkNMbnBuNUxl?=
 =?utf-8?B?eVBDdm9EQ2JIeS91cVk2Z1hBNHYxSUlBOHVYeWY1MjBVRDYrTFFzQmJKRXcr?=
 =?utf-8?B?RDVVOFNSd2JUNkJ3RzdqZEo4OWlVUzNUUlF5bWptUnhJT1F6cCs4SHFQNThE?=
 =?utf-8?B?RjlJdnpPTGVIZC9jWnc4WHF3Z1ZWMy9OZ1VoVjJpaThBYVFYQnJLMXpZUVpr?=
 =?utf-8?B?bmlHSGwrSDZWNGx1cDVZc3ZQU21sYUs0RTN6b3hvRE1Fa241OEdoWnArbkN3?=
 =?utf-8?B?TWF1UkJDQU5mMXh0bUpoSlBhSXN4RWMzdXkxWlNKSlpXdXZ0ZnFCUUdTeWtW?=
 =?utf-8?B?RjhZbEh0ZlJCMlduU0k2eC9OY2pMQmxYUzYxblh4QUpQaE02eXhPNnhqaHVh?=
 =?utf-8?B?SkF5Zyt1MkRuVGRCcFNWME1UWDdSU1JNTWZRVXVvQzRXdFhoV2hqYUlhWnBN?=
 =?utf-8?B?UTQxa2V0dVhXalhodUV4bmN4WUxGSUw4RnNKTkhmWUdrTU4wWGNXL09SM3Zw?=
 =?utf-8?B?akFJakd2WmpKN292YlJJSTJ4d1VzdHZHWlVHTlRnZXUrai9KbW1acWE3MjRq?=
 =?utf-8?B?d1M3NklJY25sU25iV2h6SDZXMm1aUXFWbDJNOUtHN28rOW1MRHc5cEJLbnlp?=
 =?utf-8?B?UFlSTzl2WXJLdmErVngyNGNHc3hvY2Z0dUFqREx3cFFKN09wV1luSVU5cG1s?=
 =?utf-8?B?TEtyU0lSSnNxemViYUFXeHZ4Q2R0ci82cklmYVlJV01McGRmRHk1ZWR5d3J4?=
 =?utf-8?B?dG5EUDQvVW00Q3ZVRTlnY2RFeUtQMTRSNHY0UEs2NXBVS0xKamx2ZVVtT1hx?=
 =?utf-8?B?ODk5a2JFc0NRKzdHOWM0WTdMZnNwRW9ybmpaWnJjOTNvS1FpTkJnZzgyMk5F?=
 =?utf-8?B?R1prNy9VdzZ3TkJNalZaS0ppeTlYVXdkeG5RYWE2OGNmc2ZWMkxScE1WODVw?=
 =?utf-8?Q?R1ua9BZQdqwz3nMHEtUXKYPZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbb35b3-592e-44dd-eb72-08dcfd3802ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 01:20:19.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1FApSEsAmu0x7NBCwWEBiDUGdBniIH5gP4SP8F0s40p5l7eLHJVdCm8q1/OS53VqJKCyhiWY8IbXOtD5Fy5tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927



On 5/11/24 09:14, Xing, Cedric wrote:
> On 11/3/2024 9:51 PM, Alexey Kardashevskiy wrote:
>> On 1/11/24 03:50, Cedric Xing wrote:
>>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-core.c
>>> similarity index 95%
>>> rename from drivers/virt/coco/tsm.c
>>> rename to drivers/virt/coco/tsm-core.c
>>> index 9432d4e303f1..92e961f21507 100644
>>> --- a/drivers/virt/coco/tsm.c
>>> +++ b/drivers/virt/coco/tsm-core.c
>>> @@ -1,8 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> -
>>
>> Why remove it?
>>
> It's not used anywhere...
> 
>>>   #include <linux/tsm.h>
>>>   #include <linux/err.h>
>>>   #include <linux/slab.h>
>>> @@ -166,8 +164,9 @@ static ssize_t 
>>> tsm_report_service_guid_store(struct config_item *cfg,
>>>   }
>>>   CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>>> -static ssize_t tsm_report_service_manifest_version_store(struct 
>>> config_item *cfg,
>>> -                             const char *buf, size_t len)
>>> +static ssize_t
>>> +tsm_report_service_manifest_version_store(struct config_item *cfg,
>>> +                      const char *buf, size_t len)
>>
>> Unrelated change usually goes to a separate preparation patch, 
>> otherwise too much noise.
>>
> You are right. I'll capture all the "noise" in a single preparation commit.


I am not even sure we want necessarily all of this changed, we can have 
100 char lines now.

> 
>>> -MODULE_DESCRIPTION("Provide Trusted Security Module attestation 
>>> reports via configfs");
>>> +MODULE_DESCRIPTION(
>>> +    "Provide Trusted Security Module attestation reports via 
>>> configfs");
>>
>>
>> Seems unrelated.
>>
> Are you suggesting an edit to the module description or simply 
> complaining about unrelated changes in the same commit?

The unrelated change complain.

> 
>>> diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
>>> new file mode 100644
>>> index 000000000000..a84e923a7782
>>> --- /dev/null
>>> +++ b/drivers/virt/coco/tsm-mr.c
>>> @@ -0,0 +1,374 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>>> +
>>> +#include <linux/tsm.h>
>>> +#include <linux/shmem_fs.h>
>>> +#include <linux/ctype.h>
>>> +#include <crypto/hash_info.h>
>>> +#include <crypto/hash.h>
>>> +
>>> +int tsm_mr_init(void);
>>> +void tsm_mr_exit(void);
>>
>> These two should go to drivers/virt/coco/tsm-mr.h, along with 
>> tsm_measurement_register and other TSM_MR_F_*.
>>
> TSM_MR_F_* are part of the module interface and have been defined in 
> include/linux/tsm.h
> 
> These 2 are internal functions called by the module entry/exit points 
> only. Their prototypes appear here merely to avoid the compiler warning.
> 
>>> +
>>> +enum _mrdir_bin_attr_index {
>>
>> Why do so many things have "_" prefix in this file?
>>
> All "_" prefixed symbols are file local. I should have used a more 
> explicit prefix. I'll change this in the next revision.

I do not think you need any prefix here (just mark those "static"), and 
"mr" is there already anyway, imho more than enough.


>>> +    _MRDIR_BA_DIGEST,
>>> +    _MRDIR_BA__COUNT,
>>
>> One underscore would do.
>>
> Are you talking about the double "__" in _MRDIR_BA__COUNT? It isn't part 
> of the enum logically, so I put an extra "_". A precedence is 
> include/uapi/linux/hash_info.h:41 in the existing kernel source.

okay :)

>>> [...]
>>> +static void _mr_provider_release(struct kobject *kobj)
>>> +{
>>> +    struct _mr_provider *pvd;
>>> +    pvd = container_of(kobj, typeof(*pvd), kset.kobj);
>>> +    pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
>>> +    BUG_ON(!list_empty(&pvd->kset.list));
>>
>> Harsh. These days people do not like even WARN_ON :) None of these 
>> BUG_ONs seem bad enough to kill the system, dunno.
>>
> This BUG_ON has helped me catch kobject leaks in my code. I don't have 
> problem removing it. But is there a guideline on what kinds of 
> BUG_ON/WARN_ON should be kept/removed?

Sounds like only hardware faults are okay-ish to be guarded with BUG_ON.

https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

WARN_ON is considered as bad as many use panic_on_oops. Thanks,


>>> [...]
>>> +int tsm_register_measurement(struct tsm_measurement *tmr)
>>> +{
>>> +    static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
>>> +
>>
>> Extra empty line not needed.
>>
>>> [...]
>>> +        for (int j = 0; j < _MRDIR_BA__COUNT; ++j)
>>> +            battrs[j] = &mrd->battrs[j];
>>
>> An empty line missing here.
>>
> Thanks for pointing these out!
> 
>>> [...]
>>> +    pvd = NULL;
>>
>> Is this needed for __free() machinery?
>>
> Yes. I should have put a comment here.
> 
>>> [...]
>>> +    struct kobject *kobj = kset_find_obj(_sysfs_tsm, tmr->name);
>>
>> Empty line missing. scripts/checkpatch.pl should have detected it. 
>> Thanks,
>>
> Will run scripts/checkpatch.pl on the next revision before sending it out.

-- 
Alexey


