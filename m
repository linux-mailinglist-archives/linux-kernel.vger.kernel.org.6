Return-Path: <linux-kernel+bounces-301917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB595F75C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A68B1C216EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB42197A8A;
	Mon, 26 Aug 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="s1C0OeFp"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020136.outbound.protection.outlook.com [52.101.56.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71319580A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691780; cv=fail; b=eC/qGnwpFNQkRQuY3PSTPyJ2JU2ucd17179fKbUpshXWT+qmnxl4p3HdQ1pKwt7cZPfoMzh2T7rmuiRjr0ClfMh5S10aABZGsFLE0nNejNRvjVoewuYOVeKchkRvYkRodNxr/D/oqR8jQYuRASwP7oboTSTGP8hTtHHUaxTQssE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691780; c=relaxed/simple;
	bh=wrld/htk9z/hMVYqZoihP2RtH6zZ3hrMkMzBL1lpdXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdPlkKiY+L+Dq4iy/q3nEV42JOSH2INvJNU5GSXmVNOprH2cY5T8cW8rOK339Ub6VFqmzmOeT2MzV5OZxTPmj8NuEpUF4t6jtbtesZuAJWu3mQbz57o9L9WOUOsLhAFMcK3YJDN8VNfEbw7Z9Kd9tEGqAJE+f+78e8ofg7mXsJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=s1C0OeFp; arc=fail smtp.client-ip=52.101.56.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuEs5BC4iUwyaIMUmFO+lqqaJM69s+ceSx+DbYRYTXIvHMTrU/+DKE/4gwRX5XIyV+16pLq3DKw86RRAMm/MQNeX6zN+26okxVPU3hmKAaLT478brqHIUgJdnLlEzXb6rjt9zbGUoJTF2rUU0hbWOHZdDfcDg4utu2Z34uW02KL0IU3ZcoPq7kx64U3l/6XQjbkuHIMwkOB66SS2eBS8P/2sOBk6aVA29h7yVyo0fqeO0gi/jIfxBborZ3Ra0dQJ3x8Ko0uatgS2iXe2uLbRL8GXvK6sTpP6KwxvU7qmqdO0H2LVbybEPxKryfVhNAVwYdxTo2XfhdS084mXBAgU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgotbLRSqoWUgngY7mT1kLxNUr9SkledlMRuzt7UAHM=;
 b=DDksuXuh/bXHcdT0MPZIAZ4HMp71korgF0ZvKViHRh9A/YtG4y2uiSAvMH7FBan4wzHY/eMB5JfELui6RjE9+dNDBaU5oHNRz0iV3H/585lgZeJHEWiEFxH2ZmqCBOS5n3I5znNCCoG6w3GIp4EGXnU4uqy0Q5NxZqg9Dk1Fgkm2l2DTOctZV32QfPSHGqbKx2ZCcFjNw9ejdi7/PzbCJ/+6KvjcOnjt9eWy/Q/IBfMdaZf8DJDps8r5ZEyleJFe/rEjBwL3sAflv7XNIc/hikMrThUwn2GJp0H/PlP87unhkpQAvsdgESyJ1q39yhe1nEmBvn17k4gnlNVsIsEcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgotbLRSqoWUgngY7mT1kLxNUr9SkledlMRuzt7UAHM=;
 b=s1C0OeFpKy5X94O4uDGeiZBH9am1hSu3s43c4YIWd7Uqp7Pm5Kx+gdR580rgziqvH2FrDcDDMIqmDKiorin3O+q7Xu8j+z4YcTzUyzTtsaNX93j0G3wUvTFhXunVOHyuFPZn1kZy54HKjmtdd/nGATNvEk8aaTJoFb2abBHBThA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8206.prod.exchangelabs.com (2603:10b6:a03:545::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 17:02:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 17:02:50 +0000
Message-ID: <9b9b07cf-8edb-4779-96f8-324f81434d6d@os.amperecomputing.com>
Date: Mon, 26 Aug 2024 10:02:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] hugetlb: arm64: add mte support
To: kernel test robot <lkp@intel.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
 <202408261816.ACEJvgZw-lkp@intel.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <202408261816.ACEJvgZw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:806:f2::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: a64c1a31-b76f-4a4a-d1c1-08dcc5f0ead5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0N3SzNQRG8ramZGbXBHWmgydEZDZ2VyOFh0YXBJb0V6UUhFR2d5N0k0N1ZS?=
 =?utf-8?B?c3huL2NTOEMxTGpNYjhxNWRNQURSRkI3TG5GcmpvM29ua3BOWFZpS2ZmREZR?=
 =?utf-8?B?aVlZWTgyZW5UUmphRnV5ZDNuMkJSSkpQRzVvQVNHQm03UEpvVDc5OEE0UDJY?=
 =?utf-8?B?c2cyVHh2VDJ6L0ZyQ0IvSnhyRFpkSWpidjBETTl1cWtvOW5lbkFQODc0eFlU?=
 =?utf-8?B?RDFwVlBLMlRPVlEyWFpndDBDZEFHbU9XRVdEZkpJT3Y3NEhITE1SM1dKaDlD?=
 =?utf-8?B?c3ViYnk5MXlTNGVzV0xrYlBiTklRRThtZnByZDdaUjd6WEl4eFltZGdKdTYw?=
 =?utf-8?B?Z2NOK1B1UnJNTmZQU0dZNG1wM2pBb1p0aTJLbENJZzdhaDNYSFNqUStoaDFC?=
 =?utf-8?B?RUxGMFUyblV3Qm03SjZZb05nazBlVkg5VklvTS9IT05sbXMxTlI0b09sRVVD?=
 =?utf-8?B?MFNHdVpVMHJ4UTNuRjRsTUpvcmNCNy90TGUyVVE4Vk9rd05tc0FrK1RPRUhF?=
 =?utf-8?B?bVNvMFZiZXJsMXFvZjFjMHVDNHp2b2JSL2JTTlIvVENRN1oyRGFvcFpwS2JZ?=
 =?utf-8?B?NHFQYm4zTTNlUEwwZ2ZvRDNna3RaVyszUEl2TnpYR3FlV1d3RjJUSFlnbzhi?=
 =?utf-8?B?TFZtaHJRdGJUbjMyVXV5RHJRQ0RLUk1lVXcxTkpuZmJ0WDhBT1lDUmtnb25k?=
 =?utf-8?B?QWp0T21mNDVrcVhhU01LUVBRZGZNVVFzMk9HTjJVZTQxVU01WXRHR0Q4eW9P?=
 =?utf-8?B?TVVWSmEraFNHUEF2N01HMXI1a0t0NHNTYjd2N0xHOWdnbzAybEhET0g3bi9v?=
 =?utf-8?B?VGlOQzFOVkplaWc1czdSdEVoSUhUdnk3WkNKbXpsOVFXOEdyQ0ZCTWdFUzdm?=
 =?utf-8?B?bHJVbk1nWCt3bE4ydi9udy9Qamw0S3N6K1lKKzFic25DNXZ5SGlCUUhYT1A3?=
 =?utf-8?B?bGZFT0FlSnpwaE5PM0krY2NXU05EaFNMZXV6ZzVCOSthY0ZEdWhoUExkc3M0?=
 =?utf-8?B?M3p5aitVTnhzVUQ0S3V5Z1FEWEdob1g4cmNxa2ExNXJhOEo5bXNEdFF5b0g1?=
 =?utf-8?B?cjZjOUZZRGF5UFBCNDZZLzl6UVo0THV6UlZDTE9XVkh4aHNsazhmZXFHdWV2?=
 =?utf-8?B?T1lONmtnemw1K2NoZzZVVXdHeGQ4bHJFRWhNcE1pbXl6UDlQUlJoeVFiR2lH?=
 =?utf-8?B?bWlXNm54TU9CeEVCRVhLV3FYSHd3MWxsaUdDbno3MXdRQWllUzYxVUFYQmxU?=
 =?utf-8?B?K25KQzNvVFJBZHh5Um1VNmgyajk5aUQwbzB5MnFaZjJ2SW4yd2RMYVVza0Jz?=
 =?utf-8?B?QjVMeElJd29vdTdaN0cvcWNSZXcwdG1DSDRDblhBRGtPQ1BlRlZxY2s4UW1w?=
 =?utf-8?B?UXZzcXpUSnJlYlN5d0hNRko5NHNuWTNSTE1VSVBkZ0VyOUE0MFlhM0VIRTZa?=
 =?utf-8?B?UW9LUkFZNDRjNVdYUXo3aFhTOTFzUHpaenNmZUVwY1RaZGltRVpjZXhlUnpX?=
 =?utf-8?B?cExjUW5YMTJXSzE2UitnTitiZnRnUDY1U2hWdnBqU296S2c5MFJheldBeCtJ?=
 =?utf-8?B?K1ZXOXpLUWh2emFydS9zcDVuam9TclRtNk5SQlJDZnlmZXpOWThIR1piQklv?=
 =?utf-8?B?YUF2YnppUUxibFNhTGVVVWVmL0MvYWJsVnovczZReVVKUi9uaWd5RUppYjhK?=
 =?utf-8?B?aUFUdENwVk5MTk1BNlVHWUlackJQVHhxSUxrYys4TDhHMWZmOFV3T1A0M3JN?=
 =?utf-8?Q?syEa5cM6hWGzBRkz1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFAyeWpoRVVmakdFSW0rVVpsYXdkRHF2WEU2VmQ5ZExSZFV0OEczdFUxbFU1?=
 =?utf-8?B?K0VNWmNMa2JVZzNTYVNOYkV2bE9MK2luZUFvd01Oc2cwaVZPb0xVWnRHeWdE?=
 =?utf-8?B?Q08zMjJVVGdHaEVrWWh6YzhJQ0dkS3VtUmVUM0RTNDhMTWNmMmxyNU51MENI?=
 =?utf-8?B?SWt6Y2FuM1pyakNYSGp2NnVCZ2VIcUtlSmlTa2I3VEF0VkdNMU9sd3BaUVh3?=
 =?utf-8?B?ZWVIaC9XZzdZdnFsZGNpc3dOYmxkeEtzU0I0QVlLYzVIUDRaclc2Ly9RUTBv?=
 =?utf-8?B?RG51ei9MSXNtc0pQZzVIdzdRSmhhTjFaR1VMVXJiRmhHaENQTURqOVplenVX?=
 =?utf-8?B?ZW8yaFFCTlRXN2cyQVVNQWVBbi9lWHl5ZEJzeTRqcVVLUU5ITzY4R1p1ajM4?=
 =?utf-8?B?azluLzc0UFBFajlKNVFrczdLdno4U05aV2xMTTFobWh2OU9ZaS9iUThmbWYv?=
 =?utf-8?B?N2dmSHl2ZGhQaG5rU2J6Q2NxL0tyR0Z2Ty9IUnZOTjBRRTZzanNFS2VQODd5?=
 =?utf-8?B?WTc2dmtUUDRSN2g3cnhaMjAyb2JCRlloZmRaWE5BWFpONFpLUnl6dFlUUVJk?=
 =?utf-8?B?b1h6MGw5cWk5OVY5d0tOYnJZZFZqOW81R3ZyMXltbVZ6a0J2R211dXNpZnFM?=
 =?utf-8?B?alp3Sk1HUUh1M1RnSTJDOE9YVzFyRWhzYlQ0aW9OY014UWFqb2FOWmdwT09v?=
 =?utf-8?B?STlrL2FVazVsMTh6Z2tUTHNicjI5SVpEZkVwanV4ZldhYXNRY1NBYTlWd3NV?=
 =?utf-8?B?cytnNE5kTmFtL3VmejVLZFE0L0V4WGg3WXZkSThpYVpWU01lMnhOOTBocS90?=
 =?utf-8?B?VXJPWTFQZmxveS9sdG9pOFZqOVhKTFl4dDdYdDQ4SkozOUVBVVI0NU5RUWpy?=
 =?utf-8?B?WkxtY2NuQWhSZEZkakxCMWx5d1pPTGRmeXY3SHJiUnIrYStJcmZRbVZNR0Fy?=
 =?utf-8?B?SzZPanVKTTB0RjZUa2h4dkRkbk1lY0c3NjVvcUo1WXJoWmxxMkovcnorZ1p5?=
 =?utf-8?B?allFMjU5VmFtWkMrR2dhUGhJMjltVDNoVGJwNkhJWWZBYkZ4VW95dWlUc2tJ?=
 =?utf-8?B?ZUVqZHNDeGtReFd1d0VSODFFK1JBbjRSeWpsd05MeU1UbnlMMWNoRk41WFRH?=
 =?utf-8?B?UlFqUllCZmlKUnRNMzdxZVZTVTZrOXlaYm9yNnBwSjNxTkVNbkUwUzYxRDFV?=
 =?utf-8?B?Z1dCRUVndjNCTXVlOG51YVBKQ09DMVRDWjd6MEtEMFFCN0ZYcjk4NUpTSzR0?=
 =?utf-8?B?UDNpaTVlQTNsLzFCMlREMTA0ekQ0ODVkRGJsVmoxZGN4bDZNdWhNSWJkS1NJ?=
 =?utf-8?B?S2FOVmZwYkJhbTFxd0lpNGFmQ3Z2V0hxUEFVQzhCZllqRFJ3SUJpakQ2ekNw?=
 =?utf-8?B?TDY0V1RqTE9iOTBMdSt2V3hMK3Zqb2kyNVBqZU83czUzb2syVVZrR3V5L3ZE?=
 =?utf-8?B?WFhPWFZCUE81Yy92RUZNd2d4anNhcGQwaEdtVkNIQjAxVFZYY0pneGNSckpu?=
 =?utf-8?B?Tm9QUmcramJvU1dkbDZKRzdOcVgrTzg4OXZNVXhnNzU5cHljdHdWbUVDQk9n?=
 =?utf-8?B?OW9WZ040QncrSnN6S3ExV01ZMjJJUjJaRHR6c0ZjOXlPV3VWUExnMGNRejR6?=
 =?utf-8?B?TURtREZ2alJTYi8rYVVlUm9KWC9rTFBGd0dwbDRiR2c0Tkd1Nzc1WWhzOUV0?=
 =?utf-8?B?VC9ZUmZNL1NKZE53bFFZdGlNeHVoaEdFQ1V6SUN6YUoxSVV0bDdVcVNpVG94?=
 =?utf-8?B?Rm0vUjVwNkdpdnhOeGJuMjM0b3U0WUN0MTcxdVUrVGRDOHZwYTlMOEFuV0Jt?=
 =?utf-8?B?U2srMC9PRHFrM1pHS3M0WWxqR2F4VmNtaVRhQ29EWTJlblNUbDUxU1ZCVWNt?=
 =?utf-8?B?TW5HT3czcFdQZVFaQlEyaW9TSUlSZ1BUVVhSa3JkNjY5NWQzZmtvczBqMjZh?=
 =?utf-8?B?aXI0M3diZlRVK2lGbVBTR0VEWjJ5ZGdlSjE0cUxEMlh3dXFmbDJOOERKcWxw?=
 =?utf-8?B?THhkSE1yUktpR3JuQlM0b3pnLzRNaWJHd1ZvallWOTdFb0xsQkZzV2VSTGps?=
 =?utf-8?B?cUpRbVlDQzU3WUtaNEFRMnpaVTNoVjgvRGdBL1NEVGF2M0dZMW5HL0ZQNWNj?=
 =?utf-8?B?Nmw1RVNNT3dYUW1KQlhBc3JVYndiRzhuNUVYTFdwN29ISFB6ZzZ3Mk9jajRz?=
 =?utf-8?Q?EpqsevageQIrvscWU7WQ52Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64c1a31-b76f-4a4a-d1c1-08dcc5f0ead5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 17:02:50.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WJcmscioNZYT5cI13ai9Aa2GY892ReszQT8yHfowkJjkzgrUTkE0b7ey+NG2z5WydixCJS4qFXa3fqcqwwYEG4KM28wChcMgdWeL6Lq7RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8206



On 8/26/24 4:15 AM, kernel test robot wrote:
> Hi Yang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on kvmarm/next akpm-mm/mm-everything linus/master v6.11-rc5 next-20240823]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/selftests-arm64-add-hugetlb-mte-tests/20240822-024935
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20240821184752.3535276-1-yang%40os.amperecomputing.com
> patch subject: [v2 PATCH 1/2] hugetlb: arm64: add mte support
> config: arm64-randconfig-004-20240824 (https://download.01.org/0day-ci/archive/20240826/202408261816.ACEJvgZw-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261816.ACEJvgZw-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408261816.ACEJvgZw-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from mm/gup.c:7:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/gup.c:18:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);

Thanks for the report. It is because the config has CONFIG_MTE disabled. 
I will fix this. But I'd prefer the response from the maintainers then 
fix all them together.

>           |                                          ^
>     In file included from mm/gup.c:20:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     6 warnings and 1 error generated.
> --
>     In file included from mm/swap.c:17:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/swap.c:26:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/swap.c:36:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     6 warnings and 1 error generated.
> --
>     In file included from mm/shmem.c:28:
>     In file included from include/linux/ramfs.h:5:
>     In file included from include/linux/fs_parser.h:11:
>     In file included from include/linux/fs_context.h:14:
>     In file included from include/linux/security.h:33:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/shmem.c:39:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     In file included from mm/shmem.c:58:
>     include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:159:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       159 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     6 warnings and 1 error generated.
> --
>     In file included from mm/mprotect.c:12:
>     In file included from include/linux/pagewalk.h:5:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/mprotect.c:13:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     In file included from mm/mprotect.c:15:
>     include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:159:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       159 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     In file included from mm/mprotect.c:30:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     8 warnings and 1 error generated.
> --
>     In file included from mm/show_mem.c:8:
>     In file included from include/linux/blkdev.h:9:
>     In file included from include/linux/blk_types.h:10:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:8:
>     In file included from include/linux/cacheflush.h:5:
>     In file included from arch/arm64/include/asm/cacheflush.h:11:
>     In file included from include/linux/kgdb.h:19:
>     In file included from include/linux/kprobes.h:28:
>     In file included from include/linux/ftrace.h:13:
>     In file included from include/linux/kallsyms.h:13:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/show_mem.c:12:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     4 warnings and 1 error generated.
> --
>     In file included from mm/mremap.c:11:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/mremap.c:12:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/mremap.c:13:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     In file included from mm/mremap.c:16:
>     include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:159:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       159 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     8 warnings and 1 error generated.
> --
>     In file included from mm/huge_memory.c:8:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/huge_memory.c:14:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     In file included from mm/huge_memory.c:19:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/huge_memory.c:27:
>     include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:159:9: warning: division by zero is undefined [-Wdivision-by-zero]
>       159 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>           |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>           |                     ^ ~~~~~~~~~~~~~~~~~
>     8 warnings and 1 error generated.
> --
>     In file included from mm/vmscan.c:15:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     In file included from mm/vmscan.c:30:
>     include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>           |                                    ~~~~~~~~~~~ ^ ~~~
>     include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>        49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>           |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>     In file included from mm/vmscan.c:42:
>     In file included from include/linux/migrate.h:8:
>     In file included from include/linux/hugetlb.h:798:
>>> arch/arm64/include/asm/hugetlb.h:25:28: error: use of undeclared identifier 'PG_mte_lock'
>        25 |                 BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>           |                                          ^
>     mm/vmscan.c:401:51: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       401 |                         size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>           |                                                       ~~~~~~~~~~~~~~~~ ^ ~~~
>     mm/vmscan.c:1729:4: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
>      1729 |                         __count_zid_vm_events(PGSCAN_SKIP, zid, nr_skipped[zid]);
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:135:34: note: expanded from macro '__count_zid_vm_events'
>       135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
>           |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
>     mm/vmscan.c:2232:51: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      2232 |         inactive = lruvec_page_state(lruvec, NR_LRU_BASE + inactive_lru);
>           |                                              ~~~~~~~~~~~ ^ ~~~~~~~~~~~~
>     mm/vmscan.c:2233:49: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      2233 |         active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
>           |                                            ~~~~~~~~~~~ ^ ~~~~~~~~~~
>     mm/vmscan.c:6247:3: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
>      6247 |                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:135:34: note: expanded from macro '__count_zid_vm_events'
>       135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
>           |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
>     11 warnings and 1 error generated.
> ..
>
>
> vim +/PG_mte_lock +25 arch/arm64/include/asm/hugetlb.h
>
>      21	
>      22	static inline void arch_clear_hugetlb_flags(struct folio *folio)
>      23	{
>      24		const unsigned long clear_flags = BIT(PG_dcache_clean) |
>    > 25			BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>      26	
>      27		if (!system_supports_mte()) {
>      28			clear_bit(PG_dcache_clean, &folio->flags);
>      29			return;
>      30		}
>      31	
>      32		folio->flags &= ~clear_flags;
>      33	}
>      34	#define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>      35	
>


