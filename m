Return-Path: <linux-kernel+bounces-405891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20739C5899
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95CF1F22F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839313BC0D;
	Tue, 12 Nov 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJHZLS/p"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613A433C0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416893; cv=fail; b=TwDTZ9aCG/c8ViSoZdFlIJomQ4844u6FFNHqLGlxh3HD2WwesD6Trf1UK20YM5zoZOSpvhHgKaKpifnlbK8GosZFkkv4vhYSdM8njwjplSn2ka+2/v5JCdY81jTmivGnojwxm45xw3CJiLEOGcyYAS3rwLnHXIXwlUDIwuzVNLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416893; c=relaxed/simple;
	bh=wRU1yzTSTdN4PECWaWgYxDJD/CzW+0AT/R3t1gljj5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWqHR2XoValqq/uvVoxwyO1fst9IrDRyQRa+vIZDEhUNnDqjTqstSl9Wlez5Zp1BPvPZUnPI5IjNkySpN/SZ/18LXHSB6oK0Ae8kS18y6wEkfhf0OjoOaBQm9h9fXlE8dX1cvzbQrkJ9gd9G9akiKYfLCfPqu16KiuEvDpP/P3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJHZLS/p; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEU+QBUrOm2rBZ7HAsmSfsjVsGd2cMhYtgQkrbI2hS2DcU21Ej9d1icdeFmrD1heQOxqsN8yjF+oXhcbDQukrF9GbsozHVO+wYvgRkO+afZdWTD7e2lWmStC28x0snexZ9TtoXBVfh+PTg5L2z7JnVnWBWcnqQ4/Qk6bdJwoQYjuXKvzY9WVOZQl+rnJqHkhlm6cYGbTxLnaWU6o6HuA5CtRsbZtT8Jh9pGf+qm3svE2MmGCaSLl0hzaZ6vBzzjX19GyjpjlMJiBLpP3lJtFf791vA/REVDTpU1IYO2nAhnQTzcR6OGgUplYX3StZ3gb78KG1nVWE3fr/2DB6EsxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPlqnH+q6f4XH1fmTqXA8uOKl04ybxXr8CIkdYSrRto=;
 b=Lbxf0zKkk5krLIS58PsdBfc9C7dBa6sZBL2iGq3PWh/PcW8fMQt62/eX/NPLzLbV74qiL2Evhbj52aoqHBSBUTSwaDCVL3Nq1saPq4kZ07gkarCc4s5ZYWBUuTj5BnvbxWokRY+r5VhCm9WwkvkH02v+O0XfLar8xINWkoieNuEu1RuQY+rtLp6qaZORQ7Y5217JD/4djJn7qtCQWCGK1t4xj0E8GIJxna2sGBxiOtVnOHGNZ0458F3IW+ah5mbGTwEw+t+lkTbDAfNP+pS6fHNKPb9zrLRZ2TbeKgXpDNVqZHxkRt2V7f58uAljYGKenXRZRdtOS2DB/Cm9jYWoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPlqnH+q6f4XH1fmTqXA8uOKl04ybxXr8CIkdYSrRto=;
 b=ZJHZLS/pWrTShR3Ciafhf/YKAFhiePb6TNEvlo+14QrKVjgAMrTwrzzhPrhPDY1k0N5dito/mxfes5wkg5Tt7jnVTKOXL97VW/fYBS54hAMlNKWjo0WaXojOR9AgOMTE++89W8KG5l9ZvScOZnXFP7OgAXLTvd5wx4L90neYH1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 13:08:05 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 13:08:05 +0000
Message-ID: <6b3ec964-a756-4d4e-b629-aecaa12a4044@amd.com>
Date: Tue, 12 Nov 2024 18:37:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] i3c: dw: Add support for AMDI0015 ACPI ID
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
 <09cfdd95-c566-4379-be17-2d5e0f0e8357@linux.intel.com>
 <507a8af4-f128-4d73-9d0f-b8a6a15603d3@amd.com>
 <eaca7890-af22-4913-9758-53846ad1ec79@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <eaca7890-af22-4913-9758-53846ad1ec79@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 893f9514-fe2c-4682-680c-08dd031b0bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1loMWgyY2hUOXM2eWdGaFRFVHExaFhGMnVlclZiQVBnRHVIT2ZJRm9Zc0lj?=
 =?utf-8?B?cmk0TmNJRE5ROWZHaUFYSjQyWDlCZkN1MERCYmoyZFRISFo1b1RIb280Mmx5?=
 =?utf-8?B?R0tvbGs0L1ltUTcvWjJUZHlVNEFZU3EwZkxZUWxpVVlDcHVLZE4wb1JWaGQ4?=
 =?utf-8?B?Um5GZUwxQzExV1Q2SjJMNmgzUU9ReW5uSTArRVJGUnArQ3oxQUZ2dWxHSnhF?=
 =?utf-8?B?VDY0QmhiaS9GL3EyYlVmOHo4em9oL0JTa1pkcEtidkdaWnR2bW9BMHVaOVZR?=
 =?utf-8?B?OWpWYnhpdGNIaGJBNHNUZmtCVXRSVXFlTitCZkNpaW5DREk2WkQ3SlJ3Wlds?=
 =?utf-8?B?Y014QzBCdVd6Uks3SExLcmFsM3V6Zy9kMVRnSFlkaXFoc3VWUnRTTjZjaDZs?=
 =?utf-8?B?VXNXZitsYmQwQjhMK2Vickg2R3FvKzhCc0t1SkhQSmVjMkFiYVErN1ZqamlD?=
 =?utf-8?B?dm1FcjhTakN5cFFhNlpWUG8xT0E4RDhCYkVEQ2MrSS85SjJQS3dQZTYwb1ls?=
 =?utf-8?B?azJIeWo1NEludCtVVW5kcXNOUVJEUzJtZHI2UHhTcnE2MzlvcEt1TE83bzlS?=
 =?utf-8?B?dmRsWC80VnBVRnRXZUN0Z25FZ3RNZFNqUnNsVkdINGF2a1RLditybEVCTFBL?=
 =?utf-8?B?YWVaRkJBcE04OG9PSHB4ckpGOTQ4VHJHQVZJV2YvU1ZxclJDS2RwNUNkTlhO?=
 =?utf-8?B?bFc2QnNmQjRoMmRXdUtQVnlUajliVkRmcDcvTy80a0E2Smh5RDQ2dzdtamEy?=
 =?utf-8?B?Umw5clhqcjUydzJrMHFjamFYc09VN0ljc0ZMcEwwM21icjRaTjNMN3VZQ2JN?=
 =?utf-8?B?UDBpVnd1SXk3b3Yrc1AvT1ErcnRYWVk4NXlVMDZNakhKTERwckY1b21EVFYy?=
 =?utf-8?B?RWZOVmFZekc1R244VExuR1pMU3NXVnVVSjhqdnhFczFNVmkzOEdQWmFmOTE1?=
 =?utf-8?B?OXEraEtsQzNMY0x0MWIvcWlUOHV1a3RCYnJuZU5wUStMNXlzVFZBMG9nU3Rl?=
 =?utf-8?B?NEF4ZWYrd2NrdnNFWXVEMUtuNldjemhyNjBBNEpHZFdPalRwMHRaOHordU82?=
 =?utf-8?B?Wk5teE1VcDl5ZFpGSTgrcnJQWncxYUJBYm94T2YyY0lId3JabEhURmFvQ3Zo?=
 =?utf-8?B?WG85aUx2TmlpOWxCVkNmeW05ZnFjQmw5eTdoMW5lUUpJYWo4SnNNNTBZejln?=
 =?utf-8?B?RGhrR2ZpaC9nRGtPY1VEL0IxZEh2OVRtK2dhOTdKY3ZNUnV3ZmV6NFFGeXE4?=
 =?utf-8?B?QjM4VjFRVGRycVd1M0VaUWNUSXd1TkJtUW1zYnRaKzgvUnc4UVZEWUZRZC9K?=
 =?utf-8?B?UEpBZk9NUWV5MHlGZ1BZNzE2ZHpQV1V4YUltWmd6aCtjc0U3cWN3emEzWE1J?=
 =?utf-8?B?TzBCUjJ4ay92c0NpQVRRNXRGZlZZdU5tZnBDSmFXZStHczlMN1hVMGF3MlFW?=
 =?utf-8?B?bXpQVTdOZE1OV2EyL1NYY3h3MmtrYnRMVU5MMm9QaEFyR20vNVdpVlVub1A0?=
 =?utf-8?B?TllTeE10eDZ0TXBDNklzR3JQeWF1K05YT0NvNHpocmtjNWRiSUFBNHRNbUFW?=
 =?utf-8?B?bzRTMy9GOHpFYTRlZW9OWkJRSE1uZlZjTlU0SHIvMmFCNWZKaTUvOXBQVmFk?=
 =?utf-8?B?SjhXN1RHMWdlZGp2L2hNbnVaMHo3ZUNYV2tUZnJXVmdETFdQc1hwakZwK2U2?=
 =?utf-8?B?Vk9Dd2NBRXpld011QWRUekRxSDdlQThVYTJLUnNBNUdtQVNNTkJidVo4SGln?=
 =?utf-8?Q?d6sAEiWDH77xv9wZ/vwrUH7Yod3kNC29hlJltga?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlZ2Vkd4dndxUFhCMk5RaWIyNG5jMjk4TEpXbFdIcDJscUI1WmhYQ3pVL2x2?=
 =?utf-8?B?V29YdFRVM2hFMDB3cFlacy9NOGh0bWdFcWExVm9EZXV6MENGaUwvdjdUeVky?=
 =?utf-8?B?M0UxMVpMZXlIdVFaZW1MVTNreTdrMlIzQmt0S3c0aDZ3bUtrdlR2azRURUF5?=
 =?utf-8?B?Qkd1Z2dGcTFQZnYxdzFxV2Q3TkRmdTc4L3RNS2Z6SGJSaW53YVRpajN2K3Zp?=
 =?utf-8?B?bTN6Z0JoOUp4RzROWTJWcGFQSXVTVnp0bnFyMjBmdGhoSSsrWU1KYTBqNGxN?=
 =?utf-8?B?enljSERqY0NRdmpzVFpmUzdwdkZrNmxaREpMSmphemQvWWozWkt4VDRScVpP?=
 =?utf-8?B?RnJNb3d6WHMxQnNkb1pTQWlRQXhyNmVhTVNQMW96MVhnRXZRZm9OdGhmaTFo?=
 =?utf-8?B?Wk9FUU9kQnVSWGNoTk1LbDFQWVRDeVFnSGFvNEhIMGRWRFdDbGV4cnJpZ3hE?=
 =?utf-8?B?anJ3aVZMZi8zRlRkUHhqUjJxRDNybmRFOWVQaGFlTUZJanUyQjJEeFZBaGxi?=
 =?utf-8?B?MGZRNXYrRDZMTVlZN3NuUnhuWEZ1L0xWeWRpcmR0OTBLQ1ZneExuWm10d0hQ?=
 =?utf-8?B?SmpzdERrQXBpbzIycjFKa3hZNFZuTWYzczNCRVorSi9nWHprK3J1RjhlVXIy?=
 =?utf-8?B?Wmt0WFFZQzhaZVNYMkkrellLc0NCcDR1eXlGblMrdHlBNjdLTTBET093b3hE?=
 =?utf-8?B?Z0dyeUwwYTY0eS9EbHF4UzFzRUk2QWlkOUxpV0lTMHh5ajVSSGdFdlJiZ0tC?=
 =?utf-8?B?dVZZdEdVTlBzL3UrMVB3cXZzaWdneHkvRVMzZHhFTXlDa29lemgzbXkvZWFs?=
 =?utf-8?B?WHBsSERqcVpnaGJiUDN4VVowZTBOVlVCMXUzSXFSTWJlWlIzTkJaSHpMejFT?=
 =?utf-8?B?K1NMQXg0UjNHRjFmWlc3MVVOaVJnRWFvOS9VUDZhejJjQnZId2U4Tkh0dFlG?=
 =?utf-8?B?cVZhV0h5WVBoaHdCV3BrN2ZBRUVYb3R5ejJaN1dudm9NVEJaM2t2VFFFVk9D?=
 =?utf-8?B?YzFhT3krS2c3d1E3aGdzU1MwdjVJZkFoQ1pNd1BjbnZzNkM2MXoxL1RscmFZ?=
 =?utf-8?B?MWRlbnczREFqcnFQYW1VNm1kZGFjazFLZjZrdmNQM2dwaWFheGtkM05LRGRs?=
 =?utf-8?B?NWdxMGZyek9kSTAzc3FYblM1MjZSSVdKYjFyN3UyOEhtelV1QVdJb29lZDRO?=
 =?utf-8?B?emxxZThMbDBSbnpuRmZKeW5zRFlqNzlrK2hqSmwwWTdvdGpJUjZtNHd0cEJX?=
 =?utf-8?B?QUk4V1hMZzVhV2RXbGNsMUdkdU11OWphRmlnQ0VhOG42WFVvb05FbE1JdFQx?=
 =?utf-8?B?QTVtV050SUpPVDZwRStrd014VzRGMDRITnloQ2xqUXRPK0diV1RGT210WnlC?=
 =?utf-8?B?UUVKOUkxSnFvUk1temx2clorT3BPcGxITEh5dlRDazV1OVhCOFB5Zks1czlX?=
 =?utf-8?B?QW9mcjNjYVBvRGJyWWNRak9vUUQ4cDc1NEl1L25RSXVaanlYSk54ZDZEbTE0?=
 =?utf-8?B?M2dPMlJQck04ekMvZVQrakdtL2QrWEdpQjFUOVB4Vk40RWZCUmkyUjhpaWZj?=
 =?utf-8?B?S3ZocVE1dW11c0dRV253WVRFcVZuZGJNOUFIWDk2T1RiWWhBb09HTUlpc3d4?=
 =?utf-8?B?SWdTZlY0OFhZKzY1ZVd3VTVWZkR0LzkwSWN2dkd3NDV5VkFyUncwa2haY0hK?=
 =?utf-8?B?TWxnTWlHT2pnaGJFVVpsNnFUWFMzcnp3LzV4NlN5dG1QL1p1d0szNHR6WEMv?=
 =?utf-8?B?SVRCekF4NmlaL0xIQUJ0THRnOFBrNzVIZGdPc21MT3VxOVNtdCtiYWFNRzJk?=
 =?utf-8?B?SFpnekMxd0hFeXRqVFh3dGxOVW5vRkFuazZNVWJsa0JZRUFlYmhsZm4vVmlU?=
 =?utf-8?B?cXlZbFhscUc4VUhHM0tKOXZzVzhQNHZJYlRzRXA0L0xwblVSM0tpbE90MXI2?=
 =?utf-8?B?aXczSGFMV1Z5YjBjQWV5QjN2Qm9YZER5SERaZ1pTM0QzSTd0d0lRY1I2cUFL?=
 =?utf-8?B?eDJaODl2NVRyNTJ4djhTcHV3NTdFaVl1Q1k5UmNMYWxmZTZUS3NtVXFVU0g1?=
 =?utf-8?B?dGI5QndzM1plS0o1NmJzc3IwRW91NEh1b1BWNFkvUG4vVEovUXBvVTRkMFZM?=
 =?utf-8?Q?5zrPSsyzZLAUod4QyzjIOTlIr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f9514-fe2c-4682-680c-08dd031b0bc2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:08:05.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5E30FYiuNHLY9n/DliQioEre5mW5tCrj5qW8pSQ/GOVngUQyNEKjvWBiIYyYqPedUBY47N3riVTNHkAs7QzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150



On 11/12/2024 15:18, Jarkko Nikula wrote:
> Hi
> 
> On 11/12/24 10:48 AM, Shyam Sundar S K wrote:
>>> Am I right this and patch 5/5 can be independent from rest of the
>>> series?
>>
>> Right. 1/5 and 5/5 can be grouped. But rest of the other patches are
>> equally important because they drive the usecase.
>>
>>>
>>> To me it looks these two patches enable bus communication and thus be
>>> useful without rest of the series while latter need more discussion
>>> (I'll have some notes coming) and Cc'ing linux-acpi.
>>
>> I have Cc'ed linux-acpi in this revision. Do you have any feedback for
>> patches 2-4 ?
>>
> Yes, I'm reviewing them and only the patch 2/5 was Cc'ed to linux-acpi.
> 
> Patchset split would serve better in my opinion enabling basic
> communication and have an other set concentrating more complex
> scenario we were try to get input from ACPI folks.

Ok. I can copy the linux-apci for patches from 2-4 after your feedback
on the current series.

Can atleast patches 1/5 and 5/5 be independently applied for -next so
they we don't miss out this cycle?

Thanks,
Shyam

