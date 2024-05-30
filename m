Return-Path: <linux-kernel+bounces-195037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11578D46A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BC61C21C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4A1474C3;
	Thu, 30 May 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hm4DW3XD"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37534176AD2;
	Thu, 30 May 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056414; cv=fail; b=kEYMw1Z499669s7618MojDy7iZVRaFIJ44SWHN3pRZHjdOKtOqSwZMSsgBys1W+suDIJpqkAoPk1lnXXwkjImxzuMW48Plx/j2Y1IiG5kvBBcFdPhALig2leIlivMf4MwSulX2+OVW0UhFSAQ4PMfcTjl2vAePhKYEbE+uCg/R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056414; c=relaxed/simple;
	bh=g6o8n3jDxARWG4a3r9hJWV6LOyPNipKq56SpD8OzuA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxGeBp83bwoxha5goAiQtRYxwUGaGmyT5ym6+ErIoqex8Lz7a0H9tryMjpTI2+r33PQgW6e33fE1vOOaut/kLUqmzBhXGco2+DRV/p4tlb7HzfaWZjszTx1bXHmx0SqAzQIOd9DN0zEQEJLv16kqEiOIWyJdKAoiDUhXtoFv9is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hm4DW3XD; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bySWvoCrN8Nq5fpKRG63L598vb01LU9Dk1LWMHmB4t5LIrdXOMtpio74DfOeeKPKZ/2T5t87hBbHD8RyEuVDMIEF1v3/gRksewlH0QX20KA87wXn0QXlfcqzXOgJGI2lgS4kzyEUdcmDZCLQVOz1FlTd4XQpHlQs3juWydy+fevTevnp+C4bBfRUEqXV3l3G+pyBOKOCx1JzVpCLvCrIFrh0YKhL0ITFentKXC4vVMys4onU1P+Yw4E5V4XTYaYfowgo0VtAobtiKRjx87y/4SsNYGnWMEVysH9BXnHTIMGRTHf4YwOS4HKHXWiJW4s0Bh+eoZtwfsprZP9rh7RHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPBhOk8/61OC6v1CzOO8GLJu0YSJgUJztceh5fTxHS8=;
 b=n8hvYkqs/uTIyLq/L/uub2wfq199gXMXVrQm8+tVM9cRUE0WvV6Odm4X0WNjs4exWNy02HBLVzXijUtjnKSWmW1GR+TOhEnugGCUavhpRuRbCMhuQR0WSnMbRR8JTsOGuzv1j8edAfB20WKp0J1FQja/nO+u2kfS6UoY6d0mulzllrzcSGhR/aDvastnVMtYzHvZfH0AUB0jcZrsnOlTZLLrn6puPTBoe1R9uV2tNTAnpmADmi8UrleLon+/EJsk0nXoKMwVviffMSOK4ABmUYSRX+MO6e+kxH8JLct6eH8GvlxM90Ldo81KagMZv9GhLnEqs3X5zMkmUINjm2zumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPBhOk8/61OC6v1CzOO8GLJu0YSJgUJztceh5fTxHS8=;
 b=hm4DW3XDG+PzxBtMt4564hQi8+7wrtmHVo70yWIPYaMrbm+Vua6t2BPr0Mo1kNDqi/i0WN5ZPEp0hO9hT8WxLmEjfA7EGkxwT/FoFT0c3L5lZ7retYOa+fmIAMMX6SuwyD9Z6hQTs+s0KQievrWSliz3d+aEr4nOChLzbNzt5G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by AS8PR02MB8804.eurprd02.prod.outlook.com (2603:10a6:20b:537::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 08:06:48 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 08:06:48 +0000
Message-ID: <08921791-452a-4bb1-950c-2dd7747a1d14@axis.com>
Date: Thu, 30 May 2024 10:06:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ina2xx) Add device tree support to pass alert
 polarity
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-2-77b4b382190f@axis.com>
 <6f2d2e7e-99b4-4f5d-a2c5-523b5534917b@roeck-us.net>
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <6f2d2e7e-99b4-4f5d-a2c5-523b5534917b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::21) To DB9PR02MB9994.eurprd02.prod.outlook.com
 (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|AS8PR02MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 124aad85-7b0e-46f5-5b77-08dc807f7472
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zit3U2RiRGVyQ3ZnNWlKaEpXM01LeStmZTQ3eU9pTzc2T0hxdEkyMlBVQThV?=
 =?utf-8?B?cXF2N2wzZkY3NlZXVExvRXhHVHpwb3QxVlJPUU5SNnZEdEdOSk8xY3pGKytY?=
 =?utf-8?B?T0ZNTmxySldmQlhVR3lDNlkybDNxYmwrZlcrYzlreE9BVDFFdW9oQXIxVi9E?=
 =?utf-8?B?UzdHUEdnTUpERGkzYlZ1ckV6d2pvT3h4dDRmVHdHbFFMSnBUM1pVcU9CbURo?=
 =?utf-8?B?ZVZLREtGZmdFNkovd05ZSWJ1Qmd1WEVWdVBwQjhZZTVURnRIOG1vOEJObVhu?=
 =?utf-8?B?N0NabmU3Znp2MWFzZlR6eTJ4MEhqOXNnTFBMN0Y1YmU0N1NsRzdWb2lLZjVr?=
 =?utf-8?B?anJEZlVmN1VPdGl6RFlkVkVMdVZScE1OZnR6NGllMXR4TjNlbTdkSFUrSmhQ?=
 =?utf-8?B?ckR6dVg1dUZmVlE2dUY3UUJiUTdsQXZjblgzVnpKK2hiNnJaalk2ZzVmcWRJ?=
 =?utf-8?B?ZWpCQlg5SkJFS3IxM2RVdFdqRnhGRXRxUEJlSmdCTDFFWTdVekRqa3lvMlJU?=
 =?utf-8?B?M3IxMHJra2Z5Y1MvWTVyQnJiQUtkMUorQVJtZzJubE56bmtGNnpRclJoZ0ll?=
 =?utf-8?B?TkZqOG9PSkRjRUMxRE5JNWZDY2xQcXIyN3pmUm1JUHlERzJZNENjSmlDOEdI?=
 =?utf-8?B?NEtIamEzMUpVU1l0TjErZm5JNDA0b05MTzUyYVZNbHF6VStHMWFNdjdla1k4?=
 =?utf-8?B?elUveThmN2xPZ1ljaFpQNVFLUVZsZTA3NGVjNGtBbFpyVXR6R0NhWDZWbzJT?=
 =?utf-8?B?ZnFKU3hHZExjQ3FjT1hESmV4M3hnaURtSmZ2eTRwNk5pUDRoTWdTOFFxWkVC?=
 =?utf-8?B?a0hqZlhFTHZqVEEwN3NJZ0kzSVR1L1pkZ3YwMXdEK09BaHNOb1hiQlQ1OW5h?=
 =?utf-8?B?S216Zmlja1dER004aUxDemVuK0MzYTJYZWxnSW81RHR2b2dvaGxWTGs3OHF4?=
 =?utf-8?B?aEtYcmdQNzdmTHd5SktBc3l4Q3dxQWwwQ3hUcUZudThLTWE1NDEzeWZCaUNv?=
 =?utf-8?B?UzE3YWhoMEZEd1NVSk5ZUnVOWVQrREtLTi9LS1dVSWdhQ0lxdEhjalV2alB5?=
 =?utf-8?B?R1BkTTdVQytKdnlqajF1SXcwaEExdFd5U01COVAybWhEZlg2R3dBYjNSaWIv?=
 =?utf-8?B?eUR0YmoxdmJKTWpvMlk1di82UENQeDU5LzJ6TVp4TDdlN3M4S3pSWXo2WGVI?=
 =?utf-8?B?QWI4NWJyY1RPUk5jbmtOdi9PYlhYRCt1anJNOEtmNXRRektLVVBjME12UXZj?=
 =?utf-8?B?OTRZMko5a2dmWjdMcnVGYjI2aC9OeWc4ZmJBcTJWTGV0YTZsdzdtM2dzSWtL?=
 =?utf-8?B?cENrTFRNek83WEg1ckM4cWtCcEh3QXJmTSs0Wk5KQ3lJNk9rYUc2WkM3cStk?=
 =?utf-8?B?RVowN203MThHdmZDMnVGeEpCNTJ4TzdvV2JaWXRGSXJWbkpBd1N3aWFQQW8y?=
 =?utf-8?B?bmE5SXFZZFNxOUpxY0s3bnByMTJIcWNpU0tUN2hCRG4zRk9RQ2lCK2l6K08w?=
 =?utf-8?B?UklUN1ZPc2xzODZVVVV3SFE5WFpUbVViNVZ0ek5xdG5ITG9Xelh0Slo5aFVj?=
 =?utf-8?B?TGV0b09oVUJ5bGRnQStYNjZmTUJMbGhraklMOC9kdXJMWDhYM3B0UlUyTlJu?=
 =?utf-8?B?YndsVW5UYjhsZGRjUG5kd0hhdUNRcTYwdW0ybDcyT2ZEc2VuVnlabDVuVGp0?=
 =?utf-8?B?NEM0TUZQRDAvemhwVm5EcnBSU3RwcjhLZVdnMmsyb2xiMVN1cnMxd2dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1YzOGFwTk5hdGhTTktJSVN2YWRqNVkvUlVJMFlVME5ma2dkYVh0dTlpdnJ4?=
 =?utf-8?B?ZklVWWh0TVRlcUFiVzZtNXpHYlR5WjUxT2w5UjZjRnJjd1ZyUnBVeWNBK0l2?=
 =?utf-8?B?dEx0UG4wUHU5NHhYOXl1SnFKR085cW5xWVMvZzFHRkMxN1ZhQWJPT0VPeWRm?=
 =?utf-8?B?Z3hzWW90SUJFVk1GbzJGMXloZ3Y4SllxTjE1WngxMDBUYktCUjdGODVsaG50?=
 =?utf-8?B?ZHBkM2xHWEtva1BOTTQ5d1J0cXgxaVIzQU8zNGdIU1ZUekVtaW5hd1d0YnlJ?=
 =?utf-8?B?ZUI4cFJVeDJzd0lkZG5DbklQTVZHYzVXb3JjZ0czWkRKTlVLTDNjcVBHOUxZ?=
 =?utf-8?B?MXZNZnRRWE1LNkxJTnZSQlFKL1p6a2g2Wnh5bzVzdThqNUVWZkZRcE1aZTcz?=
 =?utf-8?B?RmlJdzRuTTFqSm5rMWg1Ym9kekZiTm9LaW03WE5wOUpQU3NzWkZvdUp5TUw3?=
 =?utf-8?B?TnlUbDBjMG9zN2ZJampvTEhSenF1bzNQWU1YSkhpTkhWdUdVMjZXMVdDNUZ3?=
 =?utf-8?B?NEQzOG9VM1Q3cjJmbWExcGJTVm5mZjNIT3NsZjZCQ0wxNUkxWEgrR1N3Znl2?=
 =?utf-8?B?UVkvRDlVZnQvc0xRd2xiM1BFbXQ4NkQrSWNwdWpETDk4bEoveS9ONEpJSERw?=
 =?utf-8?B?bnBCNEtJdDJmdmJXWURLNDIrNkRtR1dwamZaTnUrMmlNOUJ5ZHlUaVhvSEVD?=
 =?utf-8?B?Qm41bVZya0dBUlBVKzZFSzdpL2llbXd5QzNMd0ttZCtMMzhqZWVRbkYrcXZw?=
 =?utf-8?B?OVgyWlAzbzA1OWwvQnhaSGlXNjZVLytWLzQzQnIyeUFaUFVFV3pxRlNnYXZl?=
 =?utf-8?B?cGJzOWlqT0tRNWR5Ukh5ZDlETHlxY1piby9IZnhzZGZtdW5qcWR3WXUrdHRI?=
 =?utf-8?B?UUpMT1ZLbjBUTWpCZlVyL2FjREtYcGxHZXBaSTZCaVcxY2JXQkNUYXgvRUdz?=
 =?utf-8?B?WnhsQUkwYVgvTmEwcWUyWldsSmkwS0RIcm9EeUVQd0wzc1ZXS0YrTFpsSVk2?=
 =?utf-8?B?dFZDc0xFQUxDZHorUmlOaDVuMjJ2U0hXenJ1RkFzUng4UUsxcFg0bE4yV0Qz?=
 =?utf-8?B?Ti9vYmkySW5qNTlnTksyS2xma1ZCKzRBaXdSZC82NHVvdlY4bW5CVVFYWmRv?=
 =?utf-8?B?YzBrVzBjWkpzRXFVVE9NSDBEbTZ5QlNicUcvVHIxQ2E2TnJucTJiNXgrN2Nk?=
 =?utf-8?B?Lys5UFRhOFM2SW5ZQjVWeG1sUUduNnBaRXY2UnFjbUZQT3RYeEVGMUdPUkli?=
 =?utf-8?B?RUVvcXhSTWI0TDJsOW03c2xuQlBlNWhyWWhnQkNCeGt6UGMzbWlEc2pVcTB2?=
 =?utf-8?B?VUs4anN4VDUwS2k5cDA2Z2FIcU9OQWxLdXYwOUpnUTI0QmRhMTdEVmVZaFlQ?=
 =?utf-8?B?U2tLdk5TNkV1bHdDUnFZYnAzU1JZY0tGcHFpVnhtRTA3ZzE2QkZTNmp1ZHgr?=
 =?utf-8?B?TFdMMlY5YnBhTzVsL3hKaTVWcEFMOXhCM0ZhRVJvMXFNY3Y0Tk15RDZmUEti?=
 =?utf-8?B?M3BoS0NpS2dRQnZBcHRkQ05lVVVLUFczV1BHUHJtaVM5bjZIenBGa2JnZEdP?=
 =?utf-8?B?eEZhbThLaStaTWp6M3BmU2ZuQS81endyNHBCbXk1NEFGYXJUOWlvSzNqc1V2?=
 =?utf-8?B?VGw3VmZhdm5OcWJxR2lMbFJaRjcxb2JJcjZ5bjI2VkhzRis0N1dQd2E1a0FO?=
 =?utf-8?B?SWN4MUNNNFYzKzBHcnVHVkUwQXdGUkxseC9teU1BWGlERGM1d285cFhZOVBF?=
 =?utf-8?B?M1FnUWdHNHdWRG8xbTI1dkpoZWl1bkhWVUkwM3o3MktTYk1RL1JNVXZrNjdw?=
 =?utf-8?B?R0ZPeStsbDJabzhob0xlNHo5VlN3UXlQdnZSeDFLeUFOVFRTejVWdUczRkxv?=
 =?utf-8?B?bUdlckVCVmlpS2U0SFJzWmRpaG1sZVhrSENpNHEySlVXVU1IQkRoSGJra0ZI?=
 =?utf-8?B?QWpDZnVPS0VEbXRIOERyUmZ0VjIyWUdKVFBrZWZhSTl5VW9Fa1IyZmwzMDdO?=
 =?utf-8?B?bTlJTDlrMFRaUHZCT1RET3REYnRsUVdMVVpYRkttbCtYVklhTmc1bjJKelFB?=
 =?utf-8?B?SzZxQjFZNFhBL1R5dmZZVDRwekZPa1pCT0d0RWRZSFBKMmwweTFKd0dTMm5M?=
 =?utf-8?Q?uZHE=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124aad85-7b0e-46f5-5b77-08dc807f7472
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:06:48.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCJa9HmCb/pzu+wPL4Q/TSV8PhBQfzI5TNQKnnn94aK3+4VyyQF4QpuK1TmniNwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8804

On 5/29/24 16:07, Guenter Roeck wrote:
> On 5/28/24 23:07, Amna Waseem wrote:
>> The INA230 has an Alert pin which is asserted when the alert
>> function selected in the Mask/Enable register exceeds the
>> value programmed into the Alert Limit register. Assertion is based
>> on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
>> It is default set to value 0 i.e Normal (active-low open collector).
>> However, hardware can be designed in such a way that expects Alert pin
>> to become active high if a user-defined threshold in Alert limit
>> register has been exceeded. This patch adds a way to pass alert polarity
>> value to the driver via device tree.
>>
>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>> ---
>>   drivers/hwmon/ina2xx.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>> index d8415d1f21fc..b58e795bdc8f 100644
>> --- a/drivers/hwmon/ina2xx.c
>> +++ b/drivers/hwmon/ina2xx.c
>> @@ -73,6 +73,9 @@
>>   #define INA226_READ_AVG(reg)        (((reg) & INA226_AVG_RD_MASK) 
>> >> 9)
>>   #define INA226_SHIFT_AVG(val)        ((val) << 9)
>>   +#define INA226_ALERT_POLARITY_MASK        0x0002
>> +#define INA226_SHIFT_ALERT_POLARITY(val)    ((val) << 1)
>> +
>>   /* bit number of alert functions in Mask/Enable Register */
>>   #define INA226_SHUNT_OVER_VOLTAGE_BIT    15
>>   #define INA226_SHUNT_UNDER_VOLTAGE_BIT    14
>> @@ -178,6 +181,23 @@ static u16 ina226_interval_to_reg(int interval)
>>       return INA226_SHIFT_AVG(avg_bits);
>>   }
>>   +static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
>> +                     unsigned long val)
>> +{
>> +    int ret;
>> +
>> +    if (val > INT_MAX || !(val == 0 || val == 1))
>
>     if (val != 0 && val !=1)
>
> would be sufficient and much easier to understand.


Agreed.

>
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&data->config_lock);
>
> Pointless lock.
>
>> +    ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
>> +                 INA226_ALERT_POLARITY_MASK,
>> +                 INA226_SHIFT_ALERT_POLARITY(val));
>> +
>> +    mutex_unlock(&data->config_lock);
>> +    return ret;
>> +}
>> +
>>   /*
>>    * Calibration register is set to the best value, which eliminates
>>    * truncation errors on calculating current register in hardware.
>> @@ -659,6 +679,14 @@ static int ina2xx_probe(struct i2c_client *client)
>>       if (ret)
>>           return dev_err_probe(dev, ret, "failed to enable vs 
>> regulator\n");
>>   +    if (!of_property_read_u32(dev->of_node, "alert-polarity", 
>> &val)) {
>> +        ret = ina2xx_set_alert_polarity(data, val);
>> +        if (ret < 0)
>> +            return dev_err_probe(
>> +                dev, ret,
>> +                "failed to set APOL bit of Enable/Mask register\n");
>> +    }
>
> INA219 and INA220 do not support alert pin configuration (or, naturally,
> the mask register in the first place). This will need to be validated.
>
> Guenter
>
Would "of_property_read_bool" be sufficient to check whether the 
property exists or not for different chips? It means that if INA219 and 
INA220 are being used, they will not have a property "alert-polarity" 
defined in their devicetree so of_property_read_bool will return false 
and nothing will happen for these chips.


