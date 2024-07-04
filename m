Return-Path: <linux-kernel+bounces-241216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D592785A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DEB22309
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148B1B0115;
	Thu,  4 Jul 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DwICz008"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC91AE0AB;
	Thu,  4 Jul 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103320; cv=fail; b=ciIq6Cxl97DR03l+XIJU677oqFrei+cFScJegpxB3dWOThyWBpyaFLFeEPb4BYmLbWi55gsvR6FditbGMiYpjRuEKOzcucAFNCB8Y5iUXxUasXDdxdw8rElr1Xg0NOT5PO1xwWmU5aUn8EvezQyYZnItaoHwKhpmqT9lnWw5ykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103320; c=relaxed/simple;
	bh=pAWfTArjNxNJpmRKDc00ZNn//V++EwVfj9aRPu0rbXQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=dFwMHBJUC0pZd3E59k3Jwdx0smEfG4HZXqmSP1gsMAMyz5nX/6NxfyznX4t2aSQ0RMxtw9aud0VDC0LwW2MkYBz8CndYdiXb2MET7TSMaDRDrG9Ukr4CPHbPxBC9ij//IloNnd8gWL0Bauq4XJ1V34WZVopX+qx4Oc6s13avyMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DwICz008; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It5Tm4vNdAV6mdaNSVR119tt01mYUToroVyRpiFTvVg+87pTY//274KSzZTZr34YtNRPo3AYBKbAE2afb/+A2tsi6im7P5+Mwe6caPlqsYowsYwYZajvvMZI+mVw64giJCrDh8dsErGzZqoprki2BuODPAfWQ9uwtmnsYNmNLlJsAzVABEKXwpb8GgHFY2RjnxUOz22yTb4aGbzMksDRSBKQAW+frBOt1HaXdEt6ODfRRi6IGV/v19lFeNVp/yTIPz68IGi3XX4E8oBwScz4ZPOD0KxOGlBkMeMibHEN2JhwEMmetBR1UqGsU0wikroz5ABMNfjcH4uWV/SxLXD8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAoX3A4BbXfFr281myTqG82lLMb9Vi6R5P/VPuYpc7U=;
 b=UFBx71KBdMI57I7z3nvIgXXh+FFRfU/rPu38KTCBP/EBQTd97oWkoN6dijd5mZqIHK/81z740xD/DjsknnEjYYspc4HYEH/unnenkQoi8a/ULJkUfsH+Ztia3o7ZYYqvbVhwbDORMYyoLQCRnOpGCGMzxraLgSmbzs6ZkRc+vgCNAM5v0NvLhE3hd1Jizr2iYro6jVIJF7VtP/4hhEFA6t6fshzh2loKfMITBU7pfybFyVY296JhujczUdUQTOUftzPg2nSidaUn/d03lNe2S6AUpOxV3e99YQym6ZSPh9VrxJQt/manLoCQUaVIQTNgYnOUVKeMCrpuq4L0LlLj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAoX3A4BbXfFr281myTqG82lLMb9Vi6R5P/VPuYpc7U=;
 b=DwICz0088P9eJYLSkApd1NxuDJvNKKUJ2YFqDFUVTdFEFTz86xlgNNQ3TZm84ckCml3igl6jeH65mjmwOMUsvSo8McofLBaRK2f2xfs81xygrbn+pt2bsW3oYYNZwTnFCjO6WHGrBqCKBBIRJitN68oEue7mjG2aZ/HZBVtH8lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 14:28:36 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:28:36 +0000
Subject: Re: [PATCH 6/6] misc: sbrmi: Add support for new revision
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-7-akshay.gupta@amd.com>
 <2024070452-bunkbed-example-9dd3@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <e073c615-12c6-5a11-b9c4-aaa772bdd377@amd.com>
Date: Thu, 4 Jul 2024 19:58:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024070452-bunkbed-example-9dd3@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA0PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::15) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3bd59a-5bad-414d-fdff-08dc9c3596c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXIxWVFuWUdReUZIQjl6T1d2WlR3UFYrMVFzYUpaVFJKQTRZa3JjQTlkWEtK?=
 =?utf-8?B?ajRoSTBuR1lmb3ZSL1pvWDZmWnhNbXRpSjdHTTZJdjJyY3FTMkoxbHNHdWRw?=
 =?utf-8?B?eHFkZ3A0L0pyY0JJb0VtWVZmVXpkNFZqb2YyeXI0SENWRVJLa1haK1RaWVRV?=
 =?utf-8?B?L1pmeVduTGR4QWtDRUxpRkU0M0tZbGoxQTdrdG1aMVM1SUVud0kxd21YQy9h?=
 =?utf-8?B?MzB0KzBqVDlIbkNHSnZ4aEN5Z24vdlVSdHJyOEh2T1A3VFF6dEc4c3RWbHMy?=
 =?utf-8?B?R1p4bWNMSjdMaTdmaEJKWXVYMjMyRnVZdm5GNVNBME12NFMrMzJ2RnpuRDRI?=
 =?utf-8?B?OGRLSFA1YW00Z2Y5ZEM5RS9YZXRlQVVrZVVsQXc4T1k3N3d6bHdrdFQzREQ5?=
 =?utf-8?B?WDcvZlJjM0Uwc0JUcVRMWFVOWEg4OXZWbW5aUGtLaHUxSTFGSEVoZ0FLNGtz?=
 =?utf-8?B?K0pSWHZxUUxzQkc5R1IxVnJaVDlGMEd6VVhtckpEMmZsVVpaeGtXbDhOcDBx?=
 =?utf-8?B?dnpqMk5tbG5lclY3dFFiY1ZxNDFMWnowTFdBR201UmNJZ3FENWRLa3BWeFAz?=
 =?utf-8?B?TmV4aWVtd1QrQWFjclJxWTdNa3JSUzczcnJNcFFpN0RUZWRIYTZlblRFMk9L?=
 =?utf-8?B?SDBLT0J1SVNwdWM3U28xTlBLSnJVa3pmVUVzRDVUUlBIN1QwY1BVaElIZ1Ji?=
 =?utf-8?B?SmxUTHJrOGRHT3l0VFo5TXg5OU01cGE2RGFEb2huQWVQb2N1cDRLS1VnbzVq?=
 =?utf-8?B?VHhQU3lMRTJZT3NkRHREZmlNb3VRUFhqcGhlOWpSRDZCUllucHBuV1VrVEd1?=
 =?utf-8?B?eXNoMzJ4K3cxaTBXbU04TFZ6OVpJK01CWGx2RUhZWEJPN2Z2NkxzSHkwOWxn?=
 =?utf-8?B?MjBINUE5dm52UEVNaHQrbi9IVmltNUZlZ2hTM0JkcmgwQmhHZFBTblp3a28r?=
 =?utf-8?B?SVFCMEFPUHMwWENUZVF4bmNOSWJza0dPTnFPYm5SUHBZOVhZQUZLTGQweUQ2?=
 =?utf-8?B?RkZsTHhsMWwybDh5MDl4MjJCN1EzQy9IUHN0ZkZkcXpVaHpualdNK09oQXZv?=
 =?utf-8?B?VlBlNExYamdoRi9kWTRvSGlxVzF5T2h5UWxZTGNPc2R5UStZRTdVY0hHQTAr?=
 =?utf-8?B?WlFSZVNzSm5kMmxiWVpKWk80VmYvdXV3NTdubjkxY2NIRkNmdHh5TUppemg0?=
 =?utf-8?B?R2RyNHVRdm9LTndhTHM5Umx4b0dpMHRoMGNOUVBpeWRUNGxjNHJaandONlZZ?=
 =?utf-8?B?Rk9QR05LTncxa2N0Wkp0Z0xXRHZaY0N2YnN0NzlQclF3TFRWa29hZzdGWGVP?=
 =?utf-8?B?WjQ4Z3pHOEVVUEE0ckR6MVdJcXY3L1kzTXMzSXlVb0dwUTBac2pEWnNuc2tW?=
 =?utf-8?B?L0xKYWhnYWdhSUVZaXhFTHpvcjZ2Uld1Sml4cFp2V1VTNGo0VlFaNjRxZXhk?=
 =?utf-8?B?R2pITHZ0a3FIbXkzWFVOa0lIaEFTdHRMQ3pJYUVtdEdxNCtEK1FRN2NWeTcw?=
 =?utf-8?B?UjJmQXFGRUlmemZ4TDcrQ1RZOER4Wjg0dWpGYXZOY2pMV3Brak1LNDJwR21k?=
 =?utf-8?B?aXRuTEppNnVVK1k3WFRvaVkxR2RSM3gyczF5NmJnaDcvWGdPR2N6MjVoV2J5?=
 =?utf-8?B?a0FVekhaUEdaSFdvU3NKNy9ZNHhmS3JRY1dRZG13QzlTWFZTRkVzTU03eE1j?=
 =?utf-8?B?TWZ6QnMvZ0Q1RnduS1BDSEt4YmUrVkE1MUlrWTRMb3JKU2hoYlUrVSs0TG9D?=
 =?utf-8?B?UXFLRC9LM09rZkQ2elRQeStiN2FZc3l0MVptQ2puZjFURDV0Ny9GNmZiTUtj?=
 =?utf-8?B?aXphN0ZPU2dxNktwc1hqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9uNURDbkpTeTIrZXN2bUtMc3pPenYxSnNNT1lVS0owdnZiVmZJNDhKLzNp?=
 =?utf-8?B?em1MMjdmNUlkWVdGTDdhYnZyNXB1WHBMZ2Q3VlB2OTRDRENDZ3pMREE3U1Ew?=
 =?utf-8?B?Zzl3U3B4TURwOWIxVFlTY3IrQWtRV21KYlM0Qzc5YjkxRk96MlhmUS8yWTZl?=
 =?utf-8?B?UW0wdFJZTTc4VHU0Z2E4WXAybmEwQXVzK2NOeVFuNmVoOVZQSkFIS0FuNmh6?=
 =?utf-8?B?c1RjbFIxUGIyZCswRUR3SGd1bG4yREZGdWxpSWtLL2hPWXNRaW94S2x3RE9J?=
 =?utf-8?B?a0I2Vzltd0FMbk84bDJqM2F3Uy9aYnRSd1R0bE1ITGc0RERXRUFEMysyVE1P?=
 =?utf-8?B?WUdPUmhFZjJDSGVuNmg0RDlzL1RHN0tLVDQrbmFJOEVzb0ZKUWRFL29MNTVM?=
 =?utf-8?B?dnYvZXFTVFkwMmwyVFdtQVZxVjUrY2duNFd6djhJV0tES2s3NEwrZzFFZFk5?=
 =?utf-8?B?d0E1WlkzanV2ckZzbXBOTFREdG5Dck5sblpsS0QzM3NQWFJ5ZVI2RXd1eHQ3?=
 =?utf-8?B?N2QyelhuYVlsQWlpanIrVjRkQXJUaS9kUE9aY1ZYN21yQW83bk11azFwanZW?=
 =?utf-8?B?VTVaM2cxMmVPUTR1M0ZrSm1GdTN4WE44d2J5OHdSVmZZRCtDTmZXaU9vaWM3?=
 =?utf-8?B?SlYweFlLd3E5WVlkejd2QUhabDBMUG5pY0htczM0dUp2ODN1YlVvbnNmRmdM?=
 =?utf-8?B?RmcxUkQ2bnBYUzhJQkRFb3lpWVdtSGtlYzBySU1mUHJTZ0V2NXlXMVFoQU1B?=
 =?utf-8?B?OGxObkxNb0FHUk9BY2x5NzRrNnhvSEtHTmlUSjROQzVrb0NrNW5rSmVDQTJI?=
 =?utf-8?B?Ky9zeHVJS0ExenJaNjMxVVY5UnlZdTVVYlUzMjVmN040Z05yM1VXdmZWU2w1?=
 =?utf-8?B?aHM2OVVHYVNYbnkzOXdBY25TME85dEo5aGhQNmZhTEpEVkc2Zk5kMGJEaEN2?=
 =?utf-8?B?akJxQWJyMFpiVUxqRjQ0T1gwSnhLZVk4STZ0ZTZPcGQxYlNCUWhTdHI2Qm4z?=
 =?utf-8?B?UHlTczdiaWdDSUpPQ2R4TU9McUtra25ObktpaUE1aHhubUFEY0dLVWVndmpQ?=
 =?utf-8?B?dVNxUjVJOFR5TC9tMFFlMnhFRVVBREUyQnovZUNNRk5wZUVsV2RmMFNGeW9z?=
 =?utf-8?B?bFdtN3hMNC9PZVIybkZCZmNLTlE4NUsyRWE1YmpraG5lWTRxaWpVcGhoZE5M?=
 =?utf-8?B?K1VjdVdJSHA1Q3Z4cjVITUJkREM0OHVPVUFxWGNYTzU2RThNQkpBMlpJT2xJ?=
 =?utf-8?B?VFZ0MVQ5SkdxbjUxc1BzbmZVYVY1TlB1cFBFZ09HUkVNcDEyUTQyUXdJaUsv?=
 =?utf-8?B?YmRXN05xSllTeVhYa1BoK3NPQlBjQ1k1RVRJTlFUa3ZiZTV0VzF0Z0JrZzRI?=
 =?utf-8?B?dm03cStCQ0VyR2RyK1FaWDRubm5NdlJyVGRmTkdCVHVWTkVNNG05SFY0NnVR?=
 =?utf-8?B?bHV6T0k1SkU0dFdWVGJIYVc3QUZCc3FGazFDRVVZVXZPU3hYSU5QT1Jja3NZ?=
 =?utf-8?B?YXUwcnJpcy9NdC9uQUZ5N0hQT3V3N3JzZFBQOWF0ZHVMT2g2aUlLbExnWUp6?=
 =?utf-8?B?RVVUbnhpblZpQ0tHNHNNM0RQdFdHR0dHaHZMNlB3MFRuS1hFMHNmeDFPZU1V?=
 =?utf-8?B?eFF2NjV6dmJSajYzaEN2ZTVLaTFmaCtqdjE3b3VGNEEreEl0Mk5hOWlRWkNm?=
 =?utf-8?B?Szc1S3pzdkh1ZFN3c2QrSmNmOUFGWW9YZzJLa0swZ2lRUThGZ01WbXh3SUlH?=
 =?utf-8?B?WkF5bnJyU2ZxRU1ZNUdycTdoTFpMeDFsNktFcVdmUDV4dDMrdXA1eFlVOFhh?=
 =?utf-8?B?b2gycUwvM0ZOdDRoUGxScTc2VUJ5YmVmbGpDMzRuellmMFV3T2kyenl6K1pm?=
 =?utf-8?B?d2x2WEttRWpnVGhHai9lRFAwa2wvUkJpcmhmVlk0aTVxVDlNUjRrNkJWaUVm?=
 =?utf-8?B?ZEpEYWtFZ3Z3MWRtRVdTRUhHdlNSMVhOcVdkUXoyMkpFbmJ1VTJzeXA3Wjc4?=
 =?utf-8?B?WUQvZmRTVkpxQndrT3ZSLzZENXlQZGRYU1dpektBMjFaUDFPdHZDeUl0NlZi?=
 =?utf-8?B?djJsYmpSUjVmS25BTWNhcEtTbEk2SUpTeUhHK2pka3FtQ1dCZnFtbjRkWHk4?=
 =?utf-8?Q?TECq87gr/kOJ6toF/8I6rzwI7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3bd59a-5bad-414d-fdff-08dc9c3596c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:28:35.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRxOAqugfjL70gPLqTGiL6iKTkkqQDs9H+7IoIJgQtD0p93YFTOAKkBiTOsp0KsVyw0gMXsSfNsH9ny22LT5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251


On 7/4/2024 5:24 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Jul 04, 2024 at 11:16:24AM +0000, Akshay Gupta wrote:
>> - RMI device supports v21 on Turin, which has increased register set.
>>    Hence, requires 2byte for register addressing.
>>
>> - Both Genoa and Turin processors are SP5 compatible, often CPUs are
>>    interchanged on the base boards with BMC remaining the same.
>>    Hence, we need to identify correct regmap configuration. A mechanism
>>    was not defined to identify the RMI register address width.
>> - The address width can only be determined if the socket is powered ON.
>> - This patch also addresses CPUID and MCAMSR register read protocol,
>>    the modification is due to the increase in register address size and
>>    the modified thread input.
>>
> When you have to list all of the different things you did in a single
> change, that's a huge hint that it needs to be split up.
>
> Remember, each patch can only do _one_ thing.
>
> Would you want to review something that attempted to do all of this at
> once?
>
> thanks,
>
> greg k-h
I will split and resubmit,
thanks, Akshay

