Return-Path: <linux-kernel+bounces-330311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DA979C73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27F1B23211
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F013B7AF;
	Mon, 16 Sep 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiNGgjL9"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90701256D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474120; cv=fail; b=NNPQYsvevciUfj3OhhgeHFhEQo4nsaBiYfaWOmHAoZDqTTmmtkUxkh7G129Zosf86ikBroPAtGcL47gG3ZlVgx9rV3qwG1uquodhQJKoMUQAxTfAfrtM3x7VJOZxJDrL8ZBUXGPFhAR1JOkMWtwKE040kznjDNLRJPRbHUPOTuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474120; c=relaxed/simple;
	bh=AwApZOwSjtRye72FKzhPAHt7nIvqR67B+6TMN4p9fxM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=h6epHpDL5QiIpHv17qmpx4g5g30cbE5oRJYiL57sWxC0QqBbTwIgdCggrfeescxRYQeV804SDP2Lx6dSf3wYaacJPBCzvRGWIbLLFGLUE/MFZd/GTcX3aGuebPKbSwofIO4TywYLCYLJoXDfOWf6uM7FG8/78K5wzIrCVfaXvew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiNGgjL9; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPkWvVn+4nXZW47el7dp/dS5zRm9fvZjigAKSc6HDRtf0MLVZA2VHd0XD0aDc2BaTsI9mQSAr3ddSbKQbRi1D9b+YiZ6b045lwg8EC7TvmB8NqjI4JDFM/V8UA4s/ET9zU79oN/TD3SezI4rLHwngjYvl2LsH5rayrMLXiV0HGieetxARXjJBPUAKR56slFqLmFRP9wJeYYvItxbDkcc0b7+4Iwz9tJ9J2fvryGhyxegPLGFtoJSSNM5A9m+YEHsSxA/owiaShKT1U1aS2BLmgUXwVxbn2BM4TOeNin0vC/IYZE2H5ehC0TU2QLHH5Pm5JCeyvurCX36PGEyuJ6GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkKqRdOwpKixdLPopw4Gl9sCM1XQ2W8yFnltQ73FmPo=;
 b=MCluvOjlYK41/PwApDudleWr36ZlkNVRf0Xuc+958eRqPRQvEYPRhRMOmynW6jg9ebeN/wa6O8qdnx0nhti52FEv81f1H5y5udgr5uOKfI3vzq0XsiBoqUNmvkVh8PvWMoP6G9F1K3T+t6AU3eq0n7jqO6oAe72revqIWvxmUkZ1fI4Vmw38h6vu5P/E+JIlFMoxW6jWs0ZsuvI67QkLd0UKEvbdyRLDQ31NH56uo46xoMDlMzNGbdPXsbY0L+f5w7vZRh+atjvFGxMmL7ahOzxHyjAHtYV7vzCiyjRtIIVol9j/HBxo6kNhWnlbM4cplrKmce+BDK9BI3bT/No3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkKqRdOwpKixdLPopw4Gl9sCM1XQ2W8yFnltQ73FmPo=;
 b=BiNGgjL9MbTJQFglaCA/okO253yTcTsjbebqT49R0Cmtioj5FND518eEODbSuSkgr7GYZwiR87IaNnkHYmLOEZ03oh/am3upmB2yzW4s+MftABiA6PAL5wHPKf8eoC8ikNXvWVHxIwtytNhWYAXwfQZxx384Fvg3Tst/6GabbdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 08:08:35 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::235b:4524:308d:ec90]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::235b:4524:308d:ec90%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:08:35 +0000
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Cc: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
From: Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
Date: Mon, 16 Sep 2024 13:38:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fa0a66-da0a-4d8d-a310-08dcd626c302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHlydGFxM0lCVEwxR3dWQ2RsRkR3NDhRTXFPZ2tOS1F5ejdUdXZlbFVnRVFE?=
 =?utf-8?B?Vk9rL2FPRmJraDVkRUpLNmVqM2hVYzRUeUpISFRNcktZSllkZmxWbXVUSjNV?=
 =?utf-8?B?WkdiSUZBMDdEQVdEdEZHeUdHbk9FZzhUcnMrY08rd21MSEY3c2pjb2xyYUpp?=
 =?utf-8?B?RStZMFBKWGtaWlBXMlNSTTRRVDg3NmI4QlBhc2h1M3JsNFFudVRzSHplV1hI?=
 =?utf-8?B?UjZiOW9LdjI1R25IVkM2eUJEOHY4OHBHNXB2Lzl5WHNxSU9uUlRWZ1BVUVhi?=
 =?utf-8?B?eEZWQ0h6MmhSR2UzTkd0b1k5Y2ZIbmFYVm5aMGNaUUN0SElDNjFaVlhwSWFR?=
 =?utf-8?B?YmJaaDYwczk3cmxkeU5WbThoRlFoMW90SFgwV3pjSWR0SFhWcU1jbldqdUJS?=
 =?utf-8?B?cVZCdm8wMVUzd2M1N1hGR2tKdmcxdkJVZlo2YXp6K0tGTm9jQmVMb1lkWXgy?=
 =?utf-8?B?a0YrcytuVlNaTlVPSFE3bWNKR1BsWWdhNkZ6WENXUXVKSnYvVEN2MWNxRnc1?=
 =?utf-8?B?akZ0Yk1IakxGQmRYMzVVQ1JHVmRFWDg3YUNpSERtZURNNGlvWEE4dU5VVmJr?=
 =?utf-8?B?N3V3VGNSZExpaWxZWVNKMy9SQzJMUHZHa3RBZmdXQlpOWlMzYndtVmh3Qnoy?=
 =?utf-8?B?UmIyS2NESUdDenFqcVFoOWtaZ3FWWlJZWGZVVm1MTDd0WWI0b2VTU25NYWpY?=
 =?utf-8?B?VnhoRDVpTGxERVVJUlRhamZJU1ZLdGxJbTVnZUppSjlVUVdxTVJRYXJBektX?=
 =?utf-8?B?ZmVHMXZoVUVTL1V5czlKYzJQYmF6eHJqRTNyOEVCVWNQTVVKWWQwMVB5WlZJ?=
 =?utf-8?B?ejFWcTdIcnVya0JKaHhxZVU4SWEzZ0VxKzN4V2R6QkR2SnVmMWxUbGtldEsw?=
 =?utf-8?B?dytRaU1zU1QyYlI2ZHpxamZ5ckpVd3p4ODFqS2tzZHA3MnFWak04VjlsZ0hj?=
 =?utf-8?B?ck1ZQjBhZ1l5RURwaFNyb0ROOEorVUFEZ1dwaWRMUjZBemhscGpMeGZwUFI5?=
 =?utf-8?B?WUNaNnJtcUpKaEk2NFJmeWVMR0VrcWMyMGM4YjRjZ3ovVUQwOVhsOGNtV0Z2?=
 =?utf-8?B?Y2MyQW52TSt0dFJ3a21ZeDZsQlhQT1FHdVJ1QmE1V2ZZSHlMbUdCWHErOGpD?=
 =?utf-8?B?OVA3MnFsRlBvZnFLUWZKWUd5aTdVZWZJZmNnT1NmQVRtZkpJbVUzZFpnanFn?=
 =?utf-8?B?K1NpR0pMMlBUK0c2czdtQzA4QUR3ZlgreWpyVm9HcEZOd2dyL3pjaU52dFJv?=
 =?utf-8?B?cyt0TWpUNTh3TDRZMTZlSWFlaVAyVjYyM3c0eEx0N2tCRTcyekUwNFo0WGJl?=
 =?utf-8?B?TzIrMGhMeUY2bmptcWJpeFk0MkRHQU9DSGsxdkdndVp0YjlzOU9JK04xaTdj?=
 =?utf-8?B?SVhUKzNNaW5EZjNLaTlQM3cyUUFYVTRqaU1yTVRoNnRWUTJMUW5OYWdtREIr?=
 =?utf-8?B?VEpZNm9Xb0NMWDR1WFB0SjVtR1Y1dHVIOE91alFVWmh3elBLRHFuNTNYRmRQ?=
 =?utf-8?B?YnI5bmVISHFUbEtraERQK3RvVEdQK2w1NXBuUVRNcnBIWkozU2F4aEg0VUNs?=
 =?utf-8?B?amUramlWbnJBUUk4a1g4KzFQNnQ3K2JpK0EyRy8veVZRRUtWVmJUZ3hKcEY5?=
 =?utf-8?B?aE9CaENodGdTdTg5bjVsSnY4WHNnamgvZ2FVTStUSVVIZjdURnpIK0w3bFY2?=
 =?utf-8?B?SVA5RnRGWEo4dHJOSGxYeW50MDdIcG1GbnlKbE5WRWRrYmVGNXl2L1BxSVo2?=
 =?utf-8?B?Q0c0Qyt5TjZUYnJYM3JaSXY1ejUrWGthUVQxYk1tZ3JPU1NIR1VRN0MxNkhh?=
 =?utf-8?B?bU9jNkFXMjUrdmdFeGt1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGVlVk1ZUk9SaHdYYWN1MzFLbDZLcDBOa0JDekRxaWNqZ1JDNjNiRjVHUnNt?=
 =?utf-8?B?RnAwMUNycUZlcHg5dzltSlhiQzQwMVBpNmZ1SXM5cEV2RUtuMW5kZmQwbEtQ?=
 =?utf-8?B?YWdmcGN4RFAvUm1iOWdMZm1WNXFYV3ZnTFpFUTk0ODltM3A1MjlGM1NXU1lE?=
 =?utf-8?B?K2Yrd29EVHFpUjBNcnJ1VVU5L0JqRFVyS0ZkTjBkYkJaQlZCbmxCUDIzTXFL?=
 =?utf-8?B?SCsyRjhpd0orZkp6S0xCZlFzWGVtZ3FBRjl5em41REZGQjdsSHBWekxEZzEy?=
 =?utf-8?B?WGVGM1RGcVBxWWVubXNrMTB6U1hJR3E2NWUvblF3Y1JsZ3BlNkt3ZWY1SGxB?=
 =?utf-8?B?MlhCalpxWmhCM0F4SGtQTUd6eVVyeUMxbURpNVBxTmlYLzRMZmxJLys1bkx1?=
 =?utf-8?B?b2pxZGlaSUM5YnBxUFNVaHhOWmh3WEx5NXVFdWZaamxmTDBiR1AzQ3ArWWll?=
 =?utf-8?B?T2NFbHRPdjJUL0dNdGpwWnRkdFErN0drWDRKMTZEK2kxbFRIM0J1eWE3Q1lF?=
 =?utf-8?B?cTR2MW1qOUNJK3ZOdDZZbHNWbU5vWjB4aEdSMlBZcC9KUytESXd0V1p2NjBl?=
 =?utf-8?B?alhJd054M256K2NWZCtnVlEySDM1bDBjNEFMWDlYZmlLZGFCYW4zejhvWlZz?=
 =?utf-8?B?Z3pBRFRXNCsxd3RKMHp6SGkyNGMzRXprendhYng4aEI5eTlwaExDM3kvQ252?=
 =?utf-8?B?MFVvYVNNbW8zY2x4WUdHMlhjQ2s1QUJRUGV4MlQ5M1c0YjZYWkJOYmNsZW5h?=
 =?utf-8?B?cTJzQWcvQXZVN0hrRkZ4bTNZampOVmxrMWJJOFB6dzRSY2VBcHY4UlhnUDZt?=
 =?utf-8?B?akdSc1huaWUxV1Y3NHlyY3lvZEZzeWNueGhFWGltcWZZNkNXNmZLWHdNM2hC?=
 =?utf-8?B?OVNPOE1OcXg1OERwMXdtZHRMREkvYTJSZ3AxTmI2QTVGR0lyUG9GWDVRbXJL?=
 =?utf-8?B?QXJBTjJQM0owdTE4KzFNUk1QQlVpZkN0VlpRcHdGRGhRcUtpK2NCZVVrUFBY?=
 =?utf-8?B?cElGK21DcGVxS0dib0hZdHpvSnFLQmZCalJDV3BCSjR0TEtaRVlES2NUZE9q?=
 =?utf-8?B?Ung1elc5SEE3eEZZS0VrQUs1MDFDQ2c5S3dLdFlLOXVKZTd4cXovNGM0eW9P?=
 =?utf-8?B?OHRDRitMSjFoWWhxRVZmTm1yWk5RVzZ6M1JTQmNqUUdoYXo3YXZjNkZrcTAz?=
 =?utf-8?B?WUZ3ejEwaTdRRVdTSUppcFlwVUxBNHlTQzFhQy9MdUNIbEtmZ3AxWUlPU28x?=
 =?utf-8?B?SUhQRTVBZGFobmlHQmZpcVJUaFhWakd4UDlJaVMrKzUwZVJRVVI5UkJqVFZU?=
 =?utf-8?B?RGcxanNPSE1yc05TRHpyaDFTSjZUQ0oxYSs3ejBvanArUmFWUWFIWDF5VkJN?=
 =?utf-8?B?VHFydEltcEhYanZTQU5vTFpjV2VIRzg2cHNHT053TDZGK0lsaEl5aVJsbFpu?=
 =?utf-8?B?elBrU3ZUbURKNUViT1l0b1lNeGZLdWk5V2VrYit3MUhoZGlvM2hTV1dzc1lI?=
 =?utf-8?B?RVVCa1BTM0dVcTR3MDZ6L2xYVU9qdFZSN3dPMm5kSUEzeGRrL041cmZBZVZa?=
 =?utf-8?B?K1hNTEJQdnlZWlVKeThSYnc0am1rQ0pjbGw2NytDQ0xLUVY0SmNlZXlNa0ho?=
 =?utf-8?B?ZlJwMmR5akU5aDBWcUpoQjhWSTUxdDZscUs0QXowOFpxOVFaL241Zjc1VUR0?=
 =?utf-8?B?ajRLRURvZEJud0F0UVJPbEExYkdraFF4ZThZWVRSc1lQQkRTR01yeXJHL1BK?=
 =?utf-8?B?akRmOHh1aXBmWmlocCs4MEpUWFAyNktsTEc3YWxZb1Z6YjEva2E2ZmRkRjVP?=
 =?utf-8?B?dDVGQnlVNzNSSy9VVzFBQ1dLMlZKd0xLNGVQMlVNK1I2ajZLSzRobW9KU2Vi?=
 =?utf-8?B?SnR3LzUrOHI1MUZUcEpJRUl3bmZGb2JFWVZqc1lZenprYXBHVlphVi8rdnhx?=
 =?utf-8?B?KzhyVVRpR2JjdVNKWVBHa3JseFhqc3VqRmtiSE5CMUdPMlZ1TUNGdDA0c3ZG?=
 =?utf-8?B?SGorUXhxamhDNDFHUEk3UVgrZlNCaU12ZnlQVitNRzhLeW1za2loOW95dFlo?=
 =?utf-8?B?Z1ZMY0F0U1FrWW5GN1d2eVRKNlVYRHBsQnVOemp0U0FSMXBOZ2U3aElGeTM4?=
 =?utf-8?Q?DORbdv1XrkK/a5UgVxbiCqYzS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa0a66-da0a-4d8d-a310-08dcd626c302
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:08:35.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IKFDZOdKH1KLOuWfjrV0ngyNON5xWYmxkRSuYMbKPmf0lRbvn+juQHiz77OX4cloYM48z+XDYBmEKqbqGlaDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
>> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> Replace the custom approach with the %pUl printk() format specifier.
>>> No functional change intended.
> 
>> Thanks, the patch looks like a nice simplificatrion.
> 
> Thank you for the review.
> 
>> Rijo, Devaraj, does this work for you?
> 
> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
> but in this driver IIUC it's guid_t (UUID LE).
> 

No, this does not work for us. I tested this patch, it does not work as expected.

%pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.

Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
While, in our TA naming we are using 3 hyphens (-).

Thanks,
Rijo

