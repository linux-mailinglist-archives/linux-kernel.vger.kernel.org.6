Return-Path: <linux-kernel+bounces-394192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901999BAB9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128391F22347
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E4166315;
	Mon,  4 Nov 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIhqdl3d"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346D165F04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692319; cv=fail; b=jtYOKKkaf2EuO2zp9cwT1BGldOPyGXW7MUPq15cY9UtvyxOp5/TdPC9JbJbqTLx48krDvKe/sbObs8BUtI+VNN7QYqt5quJ/b+7NBocXt6d9BlqXVFJcM8bsuf0P7A3Rvfgft9uVK9z/ROiVGts3XoHWSnaQN5M7E5MFwhAnSvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692319; c=relaxed/simple;
	bh=+mfhWLqVL1H2ahqrspP7uSfEDgcWpYEKLAVtdEmm5C0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Npj4jTZrbHIX+xX8KhrjevxCHgGHRhoxQx3YqfuCHpUhzsZdGHrPV2Kh3QShqTL02uZHvIykFCwcOa/uS4POwMMUz7SguY3a9m1drttuyqGj39B+Uq2bvpWWWeABdAYRriH8k/G/t8Ob38+LxMMn2Y7Neh0JQoZIWah6R0xV+Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIhqdl3d; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVagPuhtQ+8CfZJsibfT2a6Dal27RNHvmofUFAR0r0SUeJiUIr/nIAdW482NIIae2cFKzvpHCAjKCJY1q0mXrBI8yQNlengsHgNV1HNiCi/3LKpRhWB7+3tnD40w5GklCe3kcgtJrJp/p0FI/fNcPTQLiBeU2O3x3pM+M6YmKek3gKRoXxH09u3Ai24zw00iNBXVBsSBIVTwN3/3ws/qlG54xJxTCe8JnUd8geJKLoU5WQQ9JKB/YEsugUy2l/9RGo1ekAoS4bNLS8OJ267eriuHUlJpMecXL72Oz0bJoOdQUkHm8y3dlRSjU6cpiXK8mT+CXy4vW2hqLVLvqwMSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/WgiqhmX+dvJWD0L2JfFvOh/VP0d+Qc+9Gi6xSSwfQ=;
 b=vRhCd6u134b9NZRp6/npVCX31z5xZP3oSM3Y8m7Fj8nKRYJjgjs2DHDO/t7L57yfroV9gW3Wt3r0HKJeLmSSGZu9pNtPy2k/Y5XRjmBnqcOhpWJOiOoHbmHYf/XrVJf17e9KUOo2EoyQnzJqZdd+2hy5kWLhc4JZBWhnpTkW9MDsBZN42vsPo0DQ5NYwDEBrvcR69a8dSJnLY2o15u45BSrVQyEKRKRxXBd6Y2p7WEl2jUowhHOU/aBwjagDCh6+2I1C0JWODa0hQR5GRPFMIhGdL7xrNN13tVbJTK4DjnQCV/JsZH2JrNzbF8TZeE4zyW+JR4/tThGmJoTzXWEp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/WgiqhmX+dvJWD0L2JfFvOh/VP0d+Qc+9Gi6xSSwfQ=;
 b=CIhqdl3dygQnqBFb6bRAh5DC1ZG1hPC1lnO/OzuH9q+hPGQfdSMTORoKQ5XeEpTsnqv5Y2Njv7fDQ0MwMleDcJ1SqFrQelHjk4rGk43I9IUrBztEKl3WM8xH+45UI0Z/2OB972Dm951Kfe5T5MazEOCC5SOM3ddDGPvlnouZ7jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 03:51:53 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:51:52 +0000
Message-ID: <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
Date: Mon, 4 Nov 2024 14:51:43 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
Content-Language: en-US
To: Cedric Xing <cedric.xing@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Lukas Wunner <lukas@wunner.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
 Mikko Ylinen <mikko.ylinen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
 <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0047.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: bd73b79d-acb6-495e-edab-08dcfc840446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU1WRmRMbzhKK0F3WFZWUUxXbG1rL3NQbmI1a3pSYytDUkJOSmViYUp6SXhs?=
 =?utf-8?B?Mm1ObE9ISExUd1B5SmY3MDFoTCtQZVBNenlmUkR4M3BpbkMrTlk2T2pxaW1I?=
 =?utf-8?B?c3VLbmFZeEU4ckpaRVdBZ01Bc0xxOW9wV083WGVIaFNmd1hGRE5XNzBpUDR4?=
 =?utf-8?B?OUtqaVZTbzdKWmR2dkVaZFdUbC9jOWtoU2F0d01uQktUWGFIYzI3eUMvaEFv?=
 =?utf-8?B?cTEveXVobHBGa1Z4R2VnZm8reHF3V0F4NmpKMmRoNENsUFhEZHI0ZFVncys0?=
 =?utf-8?B?UW1wU0NHNDNCOTNPa1NqWGdrTS9JREZwMlQyUTh3VU1pSmJIb1dwNkQ3RDZk?=
 =?utf-8?B?NmJUZHc5TzYvYW9JTXdZMlFLOEc4TzYvOUdmcHEvNlFvTTdicHNjMDdwVjBM?=
 =?utf-8?B?U2FWTnlCV0JhczBkeFBvNWRocEVrcjJWbnJYdEJyM2ZOSWZWWTlxMXFBUXEz?=
 =?utf-8?B?VTJHQXJtVklWUk9hdThRaUNDdldpOTdOL2JPK0V2NlN5N2Y3WitJUXRpcnRU?=
 =?utf-8?B?Mmx0elFoMWFFVHVVUXRVVzFPd043bXlQNWtmZFlZQkl5UlExd0Z6ZWZoamxm?=
 =?utf-8?B?NThqcU4wdWV4VnBveWhTejhYbmtBZGJOMEZJN2tCTHhJd25RU3IxMk1nYWpz?=
 =?utf-8?B?cXErK1RIY01NYThZaENIbjg1WndLbC9KeHdZN3ZxSGp4RVA5anVUb3F0dFNY?=
 =?utf-8?B?OU9LRHRmbWxjV2dSN21HWFVrdUl4N0FGaWlINE9YUytjSUVJV3NkbE1sR0pS?=
 =?utf-8?B?am4zYnZoSnBvYWZOMkY0MGZWZUJtNVljNVJPTVZQNmkyNDNFdkJMcTY0NVVm?=
 =?utf-8?B?Yzg2QnFhSEdxcE1vM3hBNW5YNVdtQnFPYUJHcUNwSnBhSVpRMUp3Q01xYWN2?=
 =?utf-8?B?MHpWRUQ5c0hxODFvczh2ZkE2NFEreUd5czMvL2M4by9UL0VXajViOWVHQjNE?=
 =?utf-8?B?clI5MlFLYXJoL3JORC9JY2EzMUVOc1R0bnZWNEtNMGhqenMxSnc4RFkreXA1?=
 =?utf-8?B?YXlQa3ZtYkpLcEpQNUhRWUlhWk5WQmRkc203R3VxaENiYklFdG1jNFlaL0Fy?=
 =?utf-8?B?VEZQMHI0QmxxS25vWEFvbmM3TkV1Sm5zOTZKc3IrWWpiQlpGT1hub3A3ZmY4?=
 =?utf-8?B?b1RjV2hKUjFlcWgreE40WHB3Wm1PRWpsbDJHOXRXY212S21EMTNtYlM3Zzhp?=
 =?utf-8?B?MmdBSExWbFRHUjFzN0ppdUJPZkFuVHMzWkFITCtWT3lJMDl2S3pUNXN0NE5D?=
 =?utf-8?B?VWV3ZkJPOXdDbVMvdjdpT2ZremJZMmZvem5Gak8xbllsYVByLzYvcmZtWTFW?=
 =?utf-8?B?ejllZUxGZk11VlRkZWVobHk0QSswSXBjRjRBYy9PdEpLSitkaHZDclVSNTFZ?=
 =?utf-8?B?QzEvdmFmdFRmV1h5N05LeUtjMkV1czJwOXo2VS8zSi9kenV2Z0VVVEIxbDJW?=
 =?utf-8?B?M1VVc21RdG03TDRsS1Nna01FNVhyNmk5RURHK1dLdGIzQytTWUlYZTVJNWpU?=
 =?utf-8?B?MXlDOU1xS0FpWkRTUDhpTytXSWhHS2VBWjViWjdCTHBKWElZQ2tDZ2RsdTFB?=
 =?utf-8?B?cmY2bWJLdXJlQzUxQkJMekFzRmc5cDhjRmRpVGduV3Q4cnZXV3FWRkgvc1dv?=
 =?utf-8?B?ejEzZllIN0Fxb3VTOG5pU0VJeTlNUE51a0NkUTFOVm1EUVVTRTFsQ2VWVXhH?=
 =?utf-8?B?TS9kUllzc01TOW5VeHdxQ21nMzBjT2lYc3RvL1pyUnNPV1B1aWpaNkY5Uk9X?=
 =?utf-8?Q?qaawrYbQD5xWO0W5hrpJkcYaQcW6J/Y3uNs/3gV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm1GT2JSOEdLNHpUTXZSdldPeDZYdFVGNzIzN1MzUDNNQmFYSEJlQnFiVDdo?=
 =?utf-8?B?NzNvODREOWFmdTNHNEpieHZROHdWVW4yRUMyMzN1V2ZueHVHaDlLdmdJdVBp?=
 =?utf-8?B?OXFFUlVlc3lZbjF6Q1RCWlZaVVNmL0xzR1F4QTBsUFpYWWJqQlEzOExTL21X?=
 =?utf-8?B?eUk1ZTRLdGpyNnBMbXlFdlVTTnp6SmZmbWsxMGRwRlBycU5qeFcyVGNQVFJw?=
 =?utf-8?B?QVEzRDY3NFFQM2xQNC9POFlXN2JTd1RMSVJGY0tNOGpNaVFkZ2NKNnZOaWxW?=
 =?utf-8?B?S0xnNmREdTViMnhSY1ZWQVQ4VVBtV2FVeHNPLzJlUExEZUkwZHJpVHpxTFVy?=
 =?utf-8?B?MFluc3l5ak5oOWpaUXYxVmZySy9pSUZidzhuQkx1bzdXNnFFM0N3cXNWQVA2?=
 =?utf-8?B?aGpabVI2aHBJOWt6VDdGM3JqckdKcVVWYXNoNFRrUXRmMVlqaXVtaU1EV1VO?=
 =?utf-8?B?b2ZLd2tjRWQ1MFRhZENvanhlamo5Vkczd05pTTZxaDljZHAxVzh4dVZOUCtI?=
 =?utf-8?B?MzJGOFoxdi9MTHJKNjlzU2haa2tSdzVEVzJVTTBudW5GVlBGMU9lT3Y0cTQw?=
 =?utf-8?B?VGZlUjdzVUVhUXUyZ3FmczNwaEZjUk15MVFheC8rUGNrVnZJeStEZ3VqbHFs?=
 =?utf-8?B?WDJZVmZmVnFjN1JhQnAzRmxiZ1ovZlNVeWk5L3NncDBaMkptaEh6WEZqbVhx?=
 =?utf-8?B?SjFMbkl3ZkRLaTRpcXFlUkdxMzc0QThJdUthMnBjcWhoa0d5d3hmd2crRDUv?=
 =?utf-8?B?R29YVkFhcEFTQmVJK20zejQ5TUdvNlc3Vlp1eVgyZUx2NFhVTUYrdGxuTHpz?=
 =?utf-8?B?ekUrbDFDWWVONVg3L2dOb3JHZGlmcmpQWU84RWF0RlZUYTVOSXNxWmJ3b2tj?=
 =?utf-8?B?QzViS2ltMmJyUDRmMGVXTTV3b3lpdDFmNUYrci9BbkNtRGpZSnNwb2NrbDMz?=
 =?utf-8?B?YWRQWDU3Y21jZU9QRk13RFpKUURWdHVoTDZOa1hVRCtyZHBNT1ZtMmdHL2Vi?=
 =?utf-8?B?QUJYUXMyUXo5UjA0ZTJaRWNaMnpvUFIrckxZd0EyR3ZEVjZDNHB5QkpjcFJ0?=
 =?utf-8?B?R2ltd2hDWXE0empRZzRYY0ZJRzB1cUJ2dHl3UmxmWTl4UHgyLzQxa1d0dmxX?=
 =?utf-8?B?T0Y4U1I1TVI1WmJ1TlYvcy9uQnRWd1I1b1NxUnJUdzM1Ykx1V1I5d1d4Zmg2?=
 =?utf-8?B?YVR3T1k1OGwxU0JMOE94TnduS3dJK2JNV3Erd0k1dEJpVXVMV01Pd0RnTFVL?=
 =?utf-8?B?RVJQaUJTVVJIaEdsWTNySHJBaXdJWHgvQm8rQnZhNVJxZy9oSzhnVGE2cGY3?=
 =?utf-8?B?aXdMVXFnNUszR21Qdit0Z2czUm8vckZJY0lDRmc0Z05LK215bllJNHVYeUEv?=
 =?utf-8?B?anQyV1dBK0Y4MUJqR0FXWStTWTVldkZLT1owS3kwRmZIdTlpd1RRNXB0dHdF?=
 =?utf-8?B?bzB0Z1ZCUnlyb1NJZUp5bzdMZW4yT0ExQVhIL0RNSDZqcnNTUit3eFdpa0Jw?=
 =?utf-8?B?cVZYc3FQNmo4dkUyN2RyMDJiMXJFdFEvZWlvRDBCekdzdmpJNTdFMXVpM3o1?=
 =?utf-8?B?K0N5MzlONzg0ODQrMVovaHN2Nkc1MnpvSG1sSHhodXEvNXZsUVdOMVZVZi9k?=
 =?utf-8?B?MGpmTng4dVZvaldDQ08rZDN1cjVDK1UzNllZZWUwRkkvcnBMUkNFMmgxOS9s?=
 =?utf-8?B?YU9YVnIvTngrSjByOWh2V3ZMd2VxdDZjQjlGR2dNbDB5TWVXZWZIQWI4VmEw?=
 =?utf-8?B?akFwTzJwM040ZVhFRWNYV0VMZG1MckVGQWJIbnF5R3Q0alViUUVUWmx5RWU4?=
 =?utf-8?B?aUgzMENwUnZWelB3alBXRmt6M3k4QjFoUjhXMkR2SjZib1lwMEVUdEMzYlcw?=
 =?utf-8?B?Rmp0Y0xWZFkwVDRKSHhaQWFxNmgvYVo0VkRuS3Y0LzNCVWNncWNBZlV5N3pi?=
 =?utf-8?B?R0tEemk1UFVTUXB1TWlYZzRWbHAyODNXaW4yVHBWT3pNODY5cmVmWk01L1Ro?=
 =?utf-8?B?N3A3QnVaNStTaDlZNDZDZE40MUlKTTYyakpRbS9lTXV2ZExxTmVGMnNPZjBt?=
 =?utf-8?B?aW4rQWFnQXNCS2JSbW9tUUdBc1JMSXc5N2tnd0YyTkdFZHVNcDRIelhLdXdr?=
 =?utf-8?Q?G0e73CbmmjA5W18OTKRQ7xCgr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd73b79d-acb6-495e-edab-08dcfc840446
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 03:51:52.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMFEMbr7SIWGgcsZWIFjjiyVOfnKjuiaoXzgsLhAimCreNEMkzM45OJ/svkc4nuFV4vCUjhyjJV5VsjD3gcUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

On 1/11/24 03:50, Cedric Xing wrote:
> This commit extends the TSM core with support for CC measurement registers
> (MRs).
> 
> The newly added APIs are:
> 
> - `tsm_register_measurement(struct tsm_measurement *)`
>    This function allows a CC guest driver to register a set of measurement
>    registers with the TSM core.
> - `tsm_unregister_measurement(struct tsm_measurement *)`:
>    This function enables a CC guest driver to unregister a previously registered
>    set of measurement registers.
> 
> `struct tsm_measurement` has been defined to encapsulate the details of
> CC-specific MRs. It includes an array of `struct tsm_measurement_register`s and
> provides operations for reading and updating these registers. For a
> comprehensive understanding of the structure and its usage, refer to the
> detailed comments added in `include/linux/tsm.h`.
> 
> Upon successful registration of a measurement provider, the TSM core exposes
> the MRs through a directory tree in the sysfs filesystem. The root of this tree
> is located at `/sys/kernel/tsm/<MR provider>/`, with `<MR provider>` being the
> name of the measurement provider. Each MR is made accessible as either a
> file or a directory, named after the MR itself. In the former case, the file
> content is the MR value, while in the latter case there will be two files in
> the directory: `digest` and `hash_algo`. The purpose and content of these files
> are self-explanatory.
> 
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> ---
>   drivers/virt/coco/Kconfig               |   3 +-
>   drivers/virt/coco/Makefile              |   2 +
>   drivers/virt/coco/{tsm.c => tsm-core.c} |  26 ++-
>   drivers/virt/coco/tsm-mr.c              | 374 ++++++++++++++++++++++++++++++++
>   4 files changed, 394 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index d9ff676bf48d..0609622cbcb9 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -5,7 +5,8 @@
>   
>   config TSM_REPORTS
>   	select CONFIGFS_FS
> -	tristate
> +	select CRYPTO_HASH_INFO
> +	tristate "Trusted Security Module (TSM) sysfs/configfs support"
>   
>   source "drivers/virt/coco/efi_secret/Kconfig"
>   
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index b69c30c1c720..8192d78dff61 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,6 +2,8 @@
>   #
>   # Confidential computing related collateral
>   #
> +tsm-y				+= tsm-core.o tsm-mr.o
> +
>   obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
>   obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>   obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-core.c
> similarity index 95%
> rename from drivers/virt/coco/tsm.c
> rename to drivers/virt/coco/tsm-core.c
> index 9432d4e303f1..92e961f21507 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -1,8 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -

Why remove it?

>   #include <linux/tsm.h>
>   #include <linux/err.h>
>   #include <linux/slab.h>
> @@ -166,8 +164,9 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>   }
>   CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>   
> -static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
> -							 const char *buf, size_t len)
> +static ssize_t
> +tsm_report_service_manifest_version_store(struct config_item *cfg,
> +					  const char *buf, size_t len)

Unrelated change usually goes to a separate preparation patch, otherwise 
too much noise.


>   {
>   	struct tsm_report *report = to_tsm_report(cfg);
>   	unsigned int val;
> @@ -187,8 +186,8 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>   }
>   CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
>   
> -static ssize_t tsm_report_inblob_write(struct config_item *cfg,
> -				       const void *buf, size_t count)
> +static ssize_t tsm_report_inblob_write(struct config_item *cfg, const void *buf,
> +				       size_t count)

Unrelated change here and below.

>   {
>   	struct tsm_report *report = to_tsm_report(cfg);
>   	int rc;
> @@ -341,7 +340,8 @@ static struct configfs_attribute *tsm_report_attrs[] = {
>   	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
>   	[TSM_REPORT_SERVICE_PROVIDER] = &tsm_report_attr_service_provider,
>   	[TSM_REPORT_SERVICE_GUID] = &tsm_report_attr_service_guid,
> -	[TSM_REPORT_SERVICE_MANIFEST_VER] = &tsm_report_attr_service_manifest_version,
> +	[TSM_REPORT_SERVICE_MANIFEST_VER] =
> +		&tsm_report_attr_service_manifest_version,
>   	NULL,
>   };
>   
> @@ -383,7 +383,8 @@ static bool tsm_report_is_visible(struct config_item *item,
>   }
>   
>   static bool tsm_report_is_bin_visible(struct config_item *item,
> -				      struct configfs_bin_attribute *attr, int n)
> +				      struct configfs_bin_attribute *attr,
> +				      int n)
>   {
>   	guard(rwsem_read)(&tsm_rwsem);
>   	if (!provider.ops)
> @@ -478,6 +479,9 @@ EXPORT_SYMBOL_GPL(tsm_unregister);
>   
>   static struct config_group *tsm_report_group;
>   
> +extern int tsm_mr_init(void);
> +extern void tsm_mr_exit(void);
> +
>   static int __init tsm_init(void)
>   {
>   	struct config_group *root = &tsm_configfs.su_group;
> @@ -497,16 +501,18 @@ static int __init tsm_init(void)
>   	}
>   	tsm_report_group = tsm;
>   
> -	return 0;
> +	return tsm_mr_init();
>   }
>   module_init(tsm_init);
>   
>   static void __exit tsm_exit(void)
>   {
> +	tsm_mr_exit();
>   	configfs_unregister_default_group(tsm_report_group);
>   	configfs_unregister_subsystem(&tsm_configfs);
>   }
>   module_exit(tsm_exit);
>   
>   MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
> +MODULE_DESCRIPTION(
> +	"Provide Trusted Security Module attestation reports via configfs");


Seems unrelated.

> diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
> new file mode 100644
> index 000000000000..a84e923a7782
> --- /dev/null
> +++ b/drivers/virt/coco/tsm-mr.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#include <linux/tsm.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/ctype.h>
> +#include <crypto/hash_info.h>
> +#include <crypto/hash.h>
> +
> +int tsm_mr_init(void);
> +void tsm_mr_exit(void);

These two should go to drivers/virt/coco/tsm-mr.h, along with 
tsm_measurement_register and other TSM_MR_F_*.

> +
> +enum _mrdir_bin_attr_index {

Why do so many things have "_" prefix in this file?

> +	_MRDIR_BA_DIGEST,
> +	_MRDIR_BA__COUNT,

One underscore would do.

> +};
> +
> +struct _mrdir {
> +	struct kobject kobj;
> +	struct bin_attribute battrs[_MRDIR_BA__COUNT];
> +};
> +
> +struct _mr_provider {
> +	struct kset kset;
> +	struct rw_semaphore rwsem;
> +	struct bin_attribute *mrfiles;
> +	struct tsm_measurement *tmr;
> +	bool in_sync;
> +};
> +
> +static inline const struct tsm_measurement_register *
> +_mrdir_mr(const struct _mrdir *mrd)
> +{
> +	return (struct tsm_measurement_register *)mrd->battrs[_MRDIR_BA_DIGEST]
> +		.private;
> +}
> +
> +static inline struct _mr_provider *
> +_mr_to_provider(const struct tsm_measurement_register *mr, struct kobject *kobj)
> +{
> +	if (mr->mr_flags & TSM_MR_F_F)

No definition for TSM_MR_F_F (seems to come later in 2/2), how does this 
compile?


> +		return container_of(kobj, struct _mr_provider, kset.kobj);
> +	else
> +		return container_of(kobj->kset, struct _mr_provider, kset);
> +}
> +
> +static inline int _call_refresh(struct _mr_provider *pvd,
> +				const struct tsm_measurement_register *mr)
> +{
> +	int rc = pvd->tmr->refresh(pvd->tmr, mr);
> +	if (rc)
> +		pr_warn(KBUILD_MODNAME ": %s.extend(%s) failed %d\n",
> +			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
> +	return rc;
> +}
> +
> +static inline int _call_extend(struct _mr_provider *pvd,
> +			       const struct tsm_measurement_register *mr,
> +			       const u8 *data)
> +{
> +	int rc = pvd->tmr->extend(pvd->tmr, mr, data);
> +	if (rc)
> +		pr_warn(KBUILD_MODNAME ": %s.extend(%s) failed %d\n",
> +			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
> +	return rc;
> +}
> +
> +static ssize_t hash_algo_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			      char *page)
> +{
> +	struct _mrdir *mrd;
> +	mrd = container_of(kobj, typeof(*mrd), kobj);
> +	return sysfs_emit(page, "%s", hash_algo_name[_mrdir_mr(mrd)->mr_hash]);
> +}
> +
> +static ssize_t _mr_read(struct file *filp, struct kobject *kobj,
> +			struct bin_attribute *attr, char *page, loff_t off,
> +			size_t count)
> +{
> +	const struct tsm_measurement_register *mr;
> +	struct _mr_provider *pvd;
> +	int rc;
> +
> +	if (off < 0 || off > attr->size)
> +		return -EINVAL;
> +
> +	count = min(count, attr->size - (size_t)off);
> +	if (!count)
> +		return count;
> +
> +	mr = (typeof(mr))attr->private;
> +	BUG_ON(mr->mr_size != attr->size);
> +
> +	pvd = _mr_to_provider(mr, kobj);
> +	rc = down_read_interruptible(&pvd->rwsem);
> +	if (rc)
> +		return rc;
> +
> +	if ((mr->mr_flags & TSM_MR_F_L) && !pvd->in_sync) {
> +		up_read(&pvd->rwsem);
> +
> +		rc = down_write_killable(&pvd->rwsem);
> +		if (rc)
> +			return rc;
> +
> +		if (!pvd->in_sync) {
> +			rc = _call_refresh(pvd, mr);
> +			pvd->in_sync = !rc;
> +		}
> +
> +		downgrade_write(&pvd->rwsem);
> +	}
> +
> +	if (!rc)
> +		memcpy(page, mr->mr_value + off, count);
> +	else
> +		pr_debug(KBUILD_MODNAME ": %s.refresh(%s)=%d\n",
> +			 kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
> +
> +	up_read(&pvd->rwsem);
> +	return rc ?: count;
> +}
> +
> +static ssize_t _mr_write(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *attr, char *page, loff_t off,
> +			 size_t count)
> +{
> +	const struct tsm_measurement_register *mr;
> +	struct _mr_provider *pvd;
> +	ssize_t rc;
> +
> +	if (off != 0 || count != attr->size)
> +		return -EINVAL;
> +
> +	mr = (typeof(mr))attr->private;
> +	BUG_ON(mr->mr_size != attr->size);
> +
> +	pvd = _mr_to_provider(mr, kobj);
> +	rc = down_write_killable(&pvd->rwsem);
> +	if (rc)
> +		return rc;
> +
> +	if (mr->mr_flags & TSM_MR_F_X)
> +		rc = _call_extend(pvd, mr, page);
> +	else
> +		memcpy(mr->mr_value, page, count);
> +
> +	if (!rc)
> +		pvd->in_sync = false;
> +
> +	up_write(&pvd->rwsem);
> +	return rc ?: count;
> +}
> +
> +static void _mrdir_release(struct kobject *kobj)
> +{
> +	struct _mrdir *mrd;
> +	mrd = container_of(kobj, typeof(*mrd), kobj);
> +	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
> +	kfree(mrd);
> +}
> +
> +static struct kobj_type _mrdir_ktype = {
> +	.release = _mrdir_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +static struct _mrdir *_mrdir_create(const struct tsm_measurement_register *mr,
> +				    struct _mr_provider *pvd)
> +{
> +	struct _mrdir *mrd __free(kfree);
> +	int rc;
> +
> +	BUG_ON(mr->mr_flags & TSM_MR_F_F);
> +	mrd = kzalloc(sizeof(*mrd), GFP_KERNEL);
> +	if (!mrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sysfs_bin_attr_init(&mrd->battrs[_MRDIR_BA_DIGEST]);
> +	mrd->battrs[_MRDIR_BA_DIGEST].attr.name = "digest";
> +	if (mr->mr_flags & TSM_MR_F_W)
> +		mrd->battrs[_MRDIR_BA_DIGEST].attr.mode |= S_IWUSR | S_IWGRP;
> +	if (mr->mr_flags & TSM_MR_F_R)
> +		mrd->battrs[_MRDIR_BA_DIGEST].attr.mode |= S_IRUGO;
> +
> +	mrd->battrs[_MRDIR_BA_DIGEST].size = mr->mr_size;
> +	mrd->battrs[_MRDIR_BA_DIGEST].read = _mr_read;
> +	mrd->battrs[_MRDIR_BA_DIGEST].write = _mr_write;
> +	mrd->battrs[_MRDIR_BA_DIGEST].private = (void *)mr;
> +
> +	mrd->kobj.kset = &pvd->kset;
> +	rc = kobject_init_and_add(&mrd->kobj, &_mrdir_ktype, NULL, "%s",
> +				  mr->mr_name);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return_ptr(mrd);
> +}
> +
> +static void _mr_provider_release(struct kobject *kobj)
> +{
> +	struct _mr_provider *pvd;
> +	pvd = container_of(kobj, typeof(*pvd), kset.kobj);
> +	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
> +	BUG_ON(!list_empty(&pvd->kset.list));

Harsh. These days people do not like even WARN_ON :) None of these 
BUG_ONs seem bad enough to kill the system, dunno.

> +	kfree(pvd->mrfiles);
> +	kfree(pvd);
> +}
> +
> +static struct kobj_type _mr_provider_ktype = {
> +	.release = _mr_provider_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +static struct kset *_sysfs_tsm;
> +
> +static struct _mr_provider *_mr_provider_create(struct tsm_measurement *tmr)
> +{
> +	struct _mr_provider *pvd __free(kfree);
> +	int rc;
> +
> +	pvd = kzalloc(sizeof(*pvd), GFP_KERNEL);
> +	if (!pvd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!tmr->name || !tmr->mrs || !tmr->refresh || !tmr->extend)
> +		return ERR_PTR(-EINVAL);
> +
> +	rc = kobject_set_name(&pvd->kset.kobj, "%s", tmr->name);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	pvd->kset.kobj.kset = _sysfs_tsm;
> +	pvd->kset.kobj.ktype = &_mr_provider_ktype;
> +	pvd->tmr = tmr;
> +
> +	init_rwsem(&pvd->rwsem);
> +
> +	rc = kset_register(&pvd->kset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return_ptr(pvd);
> +}
> +
> +DEFINE_FREE(_unregister_measurement, struct _mr_provider *,
> +	    if (!IS_ERR_OR_NULL(_T)) tsm_unregister_measurement(_T->tmr));
> +
> +int tsm_register_measurement(struct tsm_measurement *tmr)
> +{
> +	static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
> +

Extra empty line not needed.

> +	struct _mr_provider *pvd __free(_unregister_measurement);
> +	int rc, nr;
> +
> +	pvd = _mr_provider_create(tmr);
> +	if (IS_ERR(pvd))
> +		return PTR_ERR(pvd);
> +
> +	nr = 0;
> +	for (int i = 0; tmr->mrs[i].mr_name; ++i) {
> +		// flat files are counted and skipped
> +		if (tmr->mrs[i].mr_flags & TSM_MR_F_F) {
> +			++nr;
> +			continue;
> +		}
> +
> +		struct _mrdir *mrd = _mrdir_create(&tmr->mrs[i], pvd);
> +		if (IS_ERR(mrd))
> +			return PTR_ERR(mrd);
> +
> +		struct attribute *attrs[] = {
> +			&_attr_hash.attr,
> +			NULL,
> +		};
> +		struct bin_attribute *battrs[_MRDIR_BA__COUNT + 1] = {};
> +		for (int j = 0; j < _MRDIR_BA__COUNT; ++j)
> +			battrs[j] = &mrd->battrs[j];

An empty line missing here.

> +		struct attribute_group agrp = {
> +			.attrs = attrs,
> +			.bin_attrs = battrs,
> +		};
> +		rc = sysfs_create_group(&mrd->kobj, &agrp);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (nr > 0) {
> +		struct bin_attribute *mrfiles __free(kfree);
> +		struct bin_attribute **battrs __free(kfree);
> +
> +		mrfiles = kcalloc(sizeof(*mrfiles), nr, GFP_KERNEL);
> +		battrs = kcalloc(sizeof(*battrs), nr + 1, GFP_KERNEL);
> +		if (!battrs || !mrfiles)
> +			return -ENOMEM;
> +
> +		for (int i = 0, j = 0; tmr->mrs[i].mr_name; ++i) {
> +			if (!(tmr->mrs[i].mr_flags & TSM_MR_F_F))
> +				continue;
> +
> +			mrfiles[j].attr.name = tmr->mrs[i].mr_name;
> +			mrfiles[j].read = _mr_read;
> +			mrfiles[j].write = _mr_write;
> +			mrfiles[j].size = tmr->mrs[i].mr_size;
> +			mrfiles[j].private = (void *)&tmr->mrs[i];
> +			if (tmr->mrs[i].mr_flags & TSM_MR_F_R)
> +				mrfiles[j].attr.mode |= S_IRUGO;
> +			if (tmr->mrs[i].mr_flags & TSM_MR_F_W)
> +				mrfiles[j].attr.mode |= S_IWUSR | S_IWGRP;
> +
> +			battrs[j] = &mrfiles[j];
> +			++j;
> +
> +			BUG_ON(j > nr);
> +		}
> +
> +		struct attribute_group agrp = {
> +			.bin_attrs = battrs,
> +		};
> +		rc = sysfs_create_group(&pvd->kset.kobj, &agrp);
> +		if (rc)
> +			return rc;
> +
> +		pvd->mrfiles = no_free_ptr(mrfiles);
> +	}
> +
> +	pvd = NULL;

Is this needed for __free() machinery?


> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_register_measurement);
> +
> +static void _kset_put_children(struct kset *kset)
> +{
> +	struct kobject *p, *n;
> +	spin_lock(&kset->list_lock);
> +	list_for_each_entry_safe(p, n, &kset->list, entry) {
> +		spin_unlock(&kset->list_lock);
> +		kobject_put(p);
> +		spin_lock(&kset->list_lock);
> +	}
> +	spin_unlock(&kset->list_lock);
> +}
> +
> +int tsm_unregister_measurement(struct tsm_measurement *tmr)
> +{
> +	struct kobject *kobj = kset_find_obj(_sysfs_tsm, tmr->name);

Empty line missing. scripts/checkpatch.pl should have detected it. Thanks,

> +	if (!kobj)
> +		return -ENOENT;
> +
> +	struct _mr_provider *pvd = container_of(kobj, typeof(*pvd), kset.kobj);
> +	BUG_ON(pvd->tmr != tmr);
> +
> +	_kset_put_children(&pvd->kset);
> +	kset_unregister(&pvd->kset);
> +	kobject_put(kobj);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister_measurement);
> +
> +int tsm_mr_init(void)
> +{
> +	_sysfs_tsm = kset_create_and_add("tsm", NULL, kernel_kobj);
> +	if (!_sysfs_tsm)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void tsm_mr_exit(void)
> +{
> +	kset_unregister(_sysfs_tsm);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Provide Trusted Security Module measurements via sysfs");
> 

-- 
Alexey


