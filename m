Return-Path: <linux-kernel+bounces-531740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D72A44453
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1702518909BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FA26BD9F;
	Tue, 25 Feb 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="owMVk2wS"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A226BD99
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497185; cv=fail; b=I2npwBT/fNMyuIL/0CQhkt9j1LK3ZnZDN0g9460Yq3GWdLbeHz45kVB6rMK2sd7duL5GGdN+SfD3FKoj1qGlfYCsFJO5JSMcHFnUwHPD/RwP1hblI3jMbfC09e7iJ32XXurZMX5uSMGb6tPazlMbylpEp3KDXaSiL8vAGJA49kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497185; c=relaxed/simple;
	bh=Bm4IjMKMpezNdVi6PMUVv96zykr9aSEc/J7MPuXKYJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CaDBLfb/oEwsI9rZJDmgJQmbQm6J9fi7DbLH8lcofSDijGc+264z3yW+OZj8AqEjfe/1B2AwdjDeLqkTtLyCuX9DlOQsUpXZ/9FFc8h88eSO4ifiQp9E7kSXGNCDsTzCN4jsoWs1ZPGJteV60W0PZVkrYlIFZweD36VM2uy6BwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=owMVk2wS; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjTJgirqyv/s28RCsvJc5CQw4+k/QPFeU9SWDKBXVMpuGmUUyp2felZ/5OsdQy/hAMlhW2B8UOUL8h6Kk5z5IhvvzRx2Xq+IGKz1LpKewrw5ob84EvMhTtgZtFwVGZba1cDBWPtucgSZ54+x8yGFqFp1mAm4ADHuDCrboS1ln6TMtA7aCywSqqKEqAf4dSMRlcUzMRf9Nuj9AYkv28CoYi2oCYY1w0EQ/LNwtDTJr1/KpLNUXKzmstrO+E+LT705qKMQAheZ2kt7bOKg/WzsvaXS+r+ExPdHFWcZkO3cBWGhV7+vBmAvhlnKjcChNm/522sTR4yDUfOq/hBF1ibe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S1CHdgIWVI4VasQrBBev4j4HWGixUfj5iftfk6gxp0=;
 b=Rd9h44heX9P4u2Ytnl/TbZEDoDLComJmWISrTVYv1oyqvHEto/y6UblqCqkKEzC+OsRRCX2ORjP4qW/n0NGq0+ZKqAkhsLLPkfzpsYhxq26e1OUaZI/qn7ZjojtZE1/XQfhEIREhF9g1X2xbjxjmYeYDi4FqXMrKfhc+ucqnUQoVDaHH9S3zfsAdmAIw/8MOInrj7WjCOJhJVEihvgLnhg9G1s4w9BpgyyMFNJiV/+Wudqhfi414InAbPGB7hhBsOPiBrCuEceNbLl+KK2UXuznPEFDoayChH6PKqYufCiA3Ln48RxbwrgtnBVWiAbV4tg3jVvGCw8dH2ezMN3TVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S1CHdgIWVI4VasQrBBev4j4HWGixUfj5iftfk6gxp0=;
 b=owMVk2wS5q/1X2BY5+LQhDYPmTIudssthLwNG8mDFIHc3RRjZc7DjThMXOx1F+9LKhVlWn1ZBzn0TOovDlvOyuGPrfX1OnvKx/jy1aVdrIPrYaT91ias5yB/SitZOcRx4l6+qBrBsbJADCZOvV1/pUA01onS0bdMgcZLto2jaYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:26:14 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 15:26:14 +0000
Message-ID: <1de357f1-1f5e-5442-b2b5-ff562ce450ed@amd.com>
Date: Tue, 25 Feb 2025 09:26:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] dma: Fix encryption bit clearing for dma_to_phys
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
 robin.murphy@arm.com, catalin.marinas@arm.com
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 aneesh.kumar@kernel.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
 <20250219220751.1276854-2-suzuki.poulose@arm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250219220751.1276854-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a9e5f2-a68c-47db-c210-08dd55b0bdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm9GTGJKSXRLa1ZDR2VBbDRGZ2NvY296SzJOT3psMGNtbi85K1pVS3ZlRm1D?=
 =?utf-8?B?YlVQMnUzYS9VSm90dnZEalZRT1ExN2kxeEt4bFV5T0JLeThzeGVuYjN1YUxo?=
 =?utf-8?B?emN5UmZJUC8rV0ZHVXZ3aWFvODVqaW5odnJxWm00RFVnZi9WY3dzWHE0N0JH?=
 =?utf-8?B?VWpBRFl1NWh2eDg3WGMyNW5BWGpZTFlMYUloWG9Xd1NFOGt3N3BmUDRFNnJN?=
 =?utf-8?B?eGw2eVJKSGpZOWRqVkZMa2pmZGxkUWl3OUh2RVhrUmhncDdhRVZwWXVGQUxs?=
 =?utf-8?B?WEVNcnRwcTNRZ0NWRUlWSE5CeEZsaEIzNDIwTzh6Qmk5bUgrNTVvMFVPT0Rz?=
 =?utf-8?B?eW1CSjNmMEloQUkwRzFwcExMaWw2TXRwd2lrOUVQN2ZYbGJHbFFYSXBXeHpB?=
 =?utf-8?B?YTZLMjZnVy9kcnpHdXBtYmpjYllSRVVKTWtDNDJMWjVoL2V4NjVNNkp4ZnN6?=
 =?utf-8?B?LzBCcDlPM3o3NXVxRkd3N3RYRWxGK2xobGJYdEhiRDFZSlZERW9CMTZHNzBv?=
 =?utf-8?B?ZEpsbllBQlRDUVhNWnVCRDF0Yks5UjViL09YeXk0eEhNU0phZUYwUkV1eVZV?=
 =?utf-8?B?TG1ERkF5N0VucVlVMVdHQjFVWWp2L0JCbEJVdGcreGt2QytiUUc0NnNuYnpY?=
 =?utf-8?B?N1Z4NHBnd2FSL3ZlenFiY2RzWGFJaVBJK2tXMlZubDdVTENXeVpzbXFHTTZN?=
 =?utf-8?B?dUFwQ2EvaWlSR242ZDJZcVhzTkRrU3NhSzdKc3c4djBycW1aOGVZVUdhR0py?=
 =?utf-8?B?VDk0eXptakZId0VVYXY3eEROczIvRHM0Wm42S3E2cTYzR29WcGFOdFBmYzlz?=
 =?utf-8?B?TDhJaUd3OW44L21WRnUzenFCRDNNMGtsc2cvQ0xvQlhpbm9HS1FaNWI5Snd0?=
 =?utf-8?B?MXZML2JKZkNwZ21QajFEbk0zMkVXdmxhcjJRZmtYL01FWEJrMkowQmRQaE5Z?=
 =?utf-8?B?VjRteGF6YVlyV01DN0RScjNVRmQ0T1lGOGUxMnpJVXFhTGk1aStGZ3Q0NmNa?=
 =?utf-8?B?SnlwUzl4R2VjK3l2dUVpaFc5MTh0aGszWWpmN2FpNWUrRGF1VUszbDRQUUor?=
 =?utf-8?B?bmdCQXgycnJBK2RVMTFNbjlLVHB0d1JtVk1yY2YvRWxLUzJ2NG9kekNQa3lm?=
 =?utf-8?B?RWdTKzdZZHVyYnUzaW5XQ1E0NGx6NTNCcURVV1RKWS9DbUN0NjRYU1dWelhZ?=
 =?utf-8?B?cXE3RUwvOTMrdDBaR2dTV0YyS3g4Zmd6WlgyZ21ianEraER6c3RQTzN1MzZT?=
 =?utf-8?B?RS9jNjJGUzdPYk01Qm50TmJSWU4xMXlrYXZZWkk4VEs0TGhUcHMzZVJSdkhh?=
 =?utf-8?B?dlRYczZQODFCSWh3UndVdUZRWXdlZ0hPRW9UR21SZXc2eE5FT1FjRVdJNS9w?=
 =?utf-8?B?Vkdwa2dFZzdORTFmTUZvNjhBaXIyYWZyajR2ZVZGakNiQnlQZ0UyMndDTUQ1?=
 =?utf-8?B?NGVLZmJ3MEt0UnFiSFNUTzh0a2dpZlkxVFpkMFRTd0NudjdmbjZCNU5LcUkr?=
 =?utf-8?B?Q2xFZlF6b3JUaFY4UTFRNjd5SzNTUGVKWW0xWjNOZFZidmxaOWJjSFhpdDBM?=
 =?utf-8?B?UEVsVk1SNXBVTnJKYVcvNjNSTkw2ejdVZUNnVzQ2N2xsYmJ6cDhMajh2bmJF?=
 =?utf-8?B?UnZjeGFyQlR1WUE0NEIwemlXbDhUUlBYYklJTHl2MW1qUjNzOExSU0FNVGxy?=
 =?utf-8?B?Yng2MVVYUWNnbjE0RDJDd0JLcmFIcHY2a2EzRjE4QnVhU0JScmJCRUV5K2Fk?=
 =?utf-8?B?alV5NjRRcy9Db2wzL09BMlpTWU9QTFVrbTJmQkhQNVVIdnNld2xYN3Y1U3V2?=
 =?utf-8?B?djg0K3NaQ2o3RmZZeFN4c3RoRUhnSnhpZEZiWHZCamdYWDNib1BXYVhlRGxh?=
 =?utf-8?Q?PZ2fwO1Yv7uRH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NBZlBsK0FycWZzZHdqdXpIVGc0bEc1b3NHMkRkeEdLdkJ4NkVxMUhJYVVP?=
 =?utf-8?B?NVBXL1RYVms2UW1ibEZGVzBheEpncmIwajB1ZlJudlJtbHdmenlISzdFYzl1?=
 =?utf-8?B?TlZtbTAyNzhOVmtHRDhmSFdXY0Q2VUdmcENvSTFSbnhxUVNsSjRSSlZ2OU5o?=
 =?utf-8?B?SlhETW1YV0xORld5U2gyVVo1K0NrY2YyOEI2NUlQZzgva3BJWG5OblhrR3Jq?=
 =?utf-8?B?Y2YwL3NHYjlkQmNZV2FNM0NnbjdJSFFub1kwVllKMWFYYk83V0N5NmduUkpQ?=
 =?utf-8?B?ejRnZkZBOXl5SGRJeVRVZzl2dEJqczJlL2pidXBOU0gxZ3REaXdBMEtmU1VK?=
 =?utf-8?B?QUYwVU9UcGxobks5SzcxYVd3ZGZoSmdiUThaamIzWkZQRE9IWjNKRVVGTjNl?=
 =?utf-8?B?UVdyODAvcStwS3Z0MmNTdzczRmNnY05EdWJqOHNWc2VNUnJGSjYvbjBSZ3Rw?=
 =?utf-8?B?eWo1Q1F6RkxTUUZJejBxR1dlTjNMQkl6MERTdXQ5V1ZnclM0SnVtdCtScE9V?=
 =?utf-8?B?bmxIRG56eVFZNU5iREpaTERWUlJpVlZxVVZVcGpWdlVnaVZIZUdTT05rcEVi?=
 =?utf-8?B?UEdRbWVCR2Jqb0R0dFZlK3k5WmtGUjB5TUZmcFNPZm9Tckk2Zk5hVWgxTkI3?=
 =?utf-8?B?ak5vcEZROTJpUTFoMlFUb1ErUnFuWjVBWUVXRE1WVFBDNDM1d202MHhzeHdS?=
 =?utf-8?B?ZTZlMUs0ZHk4eEFaRVp0dkxJdFBmSWR1VzhlNmh2MU9GOUF1RkQ1c2MwWjRs?=
 =?utf-8?B?Mm1XTHN5M1pLL1ZSTW9RVFRHODl1SjJXeWR6cVF1akV0aU5JN1BFQmJYdExk?=
 =?utf-8?B?TTA5TmphRDRULzNZODV3ZmUrSnY5NFhNV3NrVVkvYXFZTHc5S3pPTFFwNEY0?=
 =?utf-8?B?MlJPelJkclVBamlSWTlNSHE1cmZiVHF4TTcyaTNHK2JmQzkrSExTNWQxemlK?=
 =?utf-8?B?Z0Z3aE1Oam5HdkJTa0NxVnplc3FCcGJzbE1zTVhYcUxJRXFRTDhNSGtUdlJK?=
 =?utf-8?B?SDl5M1FYSFVKT0RzMERSSnRxMlVRTUlzUUVJbG1HcFZuTXJLU2l4VHY0dmNE?=
 =?utf-8?B?Q0hPY29URitoNjJHODhlbm1Cb2k4RHBrQ1hUcFdBLzZpdHVUM2VzWFFWRkxs?=
 =?utf-8?B?VzF2OG9OUDFNTjVEU3VpTGxUYXpBRWtieEliYXVvZGg5dDdoQkMvYUtTaVA1?=
 =?utf-8?B?a3Juc0p2S2picjI0S05yYnJjQ2pydnlHdDROL05hak9GWkh2WWM1YUFrNndz?=
 =?utf-8?B?Y2w5TzEzUWpDN2t4eHgxYUZOMmV1MWczcDhFOWd5bFFNNjZsdUpTTzNNRFJ1?=
 =?utf-8?B?aENDeGZER1lSWlNSWEpCMVpSUHJsMWVnVzJnRkFadmNpZFEzbHRvZndqelZr?=
 =?utf-8?B?N3g3YnBzWUlPQVVJMVcyc3BQbktaWWVvb1JUYlhWbitGN2pjSDBYZ01mVDVT?=
 =?utf-8?B?N280bEg3Z0pZU3N1M0Y2SW40RXFZYnJLVzgwUzZleVVNa2ZJZDdVVzdFbzBG?=
 =?utf-8?B?T3NiS0o2NldvKzVyOTdsSEZkemRlRm1MZVMyZDhqanhSVmZ2Z0k3bkRGM0N5?=
 =?utf-8?B?MHhXcEZYUDdUemxJVWNTTFc2L3gzdE1wVmtCMkRzdU5jdGhVdHRTQlZKZHRZ?=
 =?utf-8?B?N0FuUEdEZGJXNktTS095aURUdDFTVmNTTzNpYWFQNVp3ckt6WFNvVTlvMnJY?=
 =?utf-8?B?aHNVajh5MVJPUW9QYkc1dWM2ZE9VdlVwOTU4dmdGMjlENnRpNDBrSFpCWStE?=
 =?utf-8?B?cVdCQXhHaXQ4Y1BJZGFmSFdkUnBiL1VLQTVBY1lTM3dFYmduOTh6bm1RM2lR?=
 =?utf-8?B?MlF6MXFxdThHTzB4WWdvWW04UDNiR25GMTdMUEwwS2xQdldueWNtalpiaWlN?=
 =?utf-8?B?ekxJUVZSd25yRlJqUmxCRVYyaEhUQlNSaW5JRi9SYWcwWFIyVHVRbDh4cHVK?=
 =?utf-8?B?cXJhYmI0UE5tWG5yOXF3c29CdCtGeDJTNldqR3RvN1phdVdKaUpuM3QxYjBX?=
 =?utf-8?B?MzJ2NWpkUHhXR2QwRDRJYXBUNnNxQS94N1RKMzlNbXV1OFE2eU1wWW9rRUtO?=
 =?utf-8?B?SysyR3R1dWpFYVdGd0hWbHNvSVQrUGd0RmUxWTlQTEsrM243QWVYZ3drNXBS?=
 =?utf-8?Q?ENte3pIJIUqPb6Xgy1RPFKMde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a9e5f2-a68c-47db-c210-08dd55b0bdfb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:26:14.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuEAk8wXjM4ve4Y7idZdBDswZvpDK1H9cQjSs3JNhGpmjR/Z+xhK+EWDNC7L1tdKukpKv8HNBxxwQ1pw535rOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

On 2/19/25 16:07, Suzuki K Poulose wrote:
> phys_to_dma() sets the encryption bit on the translated DMA address. But
> dma_to_phys() clears the encryption bit after it has been translated back
> to the physical address, which could fail if the device uses DMA ranges.
> 
> Hopefully, AMD SME doesn't use it. Anyways, let us fix it, before cleanup
> the infrastructure for supporting other architectures.

I'm not aware of anything using DMA ranges on SME capable hardware. And
as you stated, this would have failed if there was.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Link: https://lkml.kernel.org/r/yq5amsen9stc.fsf@kernel.org
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/dma-direct.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index d7e30d4f7503..d20ecc24cb0f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -101,12 +101,13 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
>  {
>  	phys_addr_t paddr;
>  
> +	dma_addr = __sme_clr(dma_addr);
>  	if (dev->dma_range_map)
>  		paddr = translate_dma_to_phys(dev, dma_addr);
>  	else
>  		paddr = dma_addr;
>  
> -	return __sme_clr(paddr);
> +	return paddr;
>  }
>  #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>  

