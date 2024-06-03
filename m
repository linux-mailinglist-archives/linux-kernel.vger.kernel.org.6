Return-Path: <linux-kernel+bounces-199401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9708D8D86D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF231C21FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1012D205;
	Mon,  3 Jun 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RsnCLtkA"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FE26AD0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430437; cv=fail; b=Gaz/UuF6r5i585OSYLX70AA0B9d0uiDwrzBfbqkzpNH2Sq64TeUxr2EcDkvtJhwNAY5LZRl8zjOUdSFI5zSSLjury9+Jtca53KP0TZQH+gNic0iMfhaL6P8fq2HyM0SRXfowXuZdmqG8rmto/9iGa0Xqizzans2vZctcx0d9vvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430437; c=relaxed/simple;
	bh=VN7PP6zhrnG+GC8Bzt1gBNYKaje1nytSz3p4ROODqdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sbE+Mze+SPzX/6Ym0qHgr09OAOrOT9oAYe2I1byu8/8aeU46gnRKb9+ehnGA5biSHTpGPSb1ESSqzJH8NAzytvvNfM7FiIPyjgS2V4yiEUjSRmKWrRhwDJX4R7GXff/83K4d9+0Y7k+benq3KCwJ6vpnfBk+MwdCYKRUI/1vobc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RsnCLtkA; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S35Fa43pxzM41Udkd0Ep3OyQPYFgWYmy6zoVHSzt+1YaUAJsWVfPqD59APDdHP1FIv6KmNKU++4i+G/Nw38ni5JzArroxu2iPfE5SVs5WYvBLmG6qZqR5yIS+AwWaRYMb2AdfICHxGrlECIg7cwQjUddl7T1PmX9H2V2wH4M0oq1wRdIwHue0sFDH46s66YImSqHQ4jo3uvaNl48BvVzAUigxndv9TFLIhuoPTtZo3l6BhF1yu6Krtw6bEKpYAyM/M9Psu5YLmVjaCUs9+nKqqiVGmQBxc7pGLsb3MZPX+lvt2VnznD263zyyDEX4uDddGTDiFA8z7f1OYfP4Ag1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brpowqMrq+/kbiC0TDOQYqOnPq5MGkXlCKXuszmyVgw=;
 b=CRR5TGuBN4/mDzzezSJu2p0r+wsp6PGcd4K0dL1DjXXzPDB9brQqx/VeDFthYv/FKNdCMUjJGXug+eJZrzAelTbooYzcyz3zuM4ErRrUZ8wdHAi0acMZJOdVzjPwLxORfcbQESYtgc3y9MxLRQEabOtX1w4Xoa6uN65f0VuIwgxouXvZCvHSJ0IYf+ZRdI+BjtMrkT2BnCEqTHbbujMEnpSJ6HOrbR/uklCHraG4PQAWY1Smv1rlbW0oaGdnoc13opj39utCJCMe5HtZUrslrcIQZ+SRofiJhDEdIpgmuMq9Vn2SOISSfy1c95Lq5mLhMKr6Pp35ulUWwk1xgMoNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brpowqMrq+/kbiC0TDOQYqOnPq5MGkXlCKXuszmyVgw=;
 b=RsnCLtkApJK52PLl5/xbCPkIjBIRNu9w21vbTxSNZUYkUQVRI8VZmH9O9IE7Awy7YeC7gIGJjv2pKi9pfbwiUl955QFYs2/GG9fS/uUaB+8J9bi3FtYG2FWNecuUF5MPXw+/YKbD/+jVD357SNYtar15s3X6PeS+o/tVLLD7+aE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 16:00:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 16:00:25 +0000
Message-ID: <c8d765bc-4e45-40b3-a33d-b4cc1bbd67bd@amd.com>
Date: Mon, 3 Jun 2024 11:00:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] platform/chrome: cros_ec_lpc: Add a new quirk for
 ACPI id
To: Tzung-Bi Shih <tzungbi@kernel.org>, Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-4-ben@jubnut.com> <Zl2NTbhk96dhTV2n@google.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zl2NTbhk96dhTV2n@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:5:54::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c5e1da-fb67-442b-7d8c-08dc83e6481d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3h1SkpxL25Mb1RuUWFhL0ViY25wSE5kQy9NUHZ3SzVzRUdNczdTcEwwTDBS?=
 =?utf-8?B?V2k4em1tL2t1MlU3UjFGOG5YNE9CUjBBYUI5Y2ZhYkd0R3dzOHhwQlNNKzhC?=
 =?utf-8?B?R1Nza2tuZEZiK0lXTUIxT29PYktIYThUM0g5clhZcDBjNU80VXlSTDEzQWRR?=
 =?utf-8?B?SEZuR1l1NWpxU0RXU1MzdjVzS1JadFh5a01tdk5MK1FGZ1hYdXhZdzdTQkZH?=
 =?utf-8?B?d0JEeEVxTmNQV1lzSzZUZmtUNEdKZXMvY1dXcmNYV2hwZERqV1craXlGQTdj?=
 =?utf-8?B?WnQwYTZsWkNoTDd0N1JQK2Q4RitvTGJac3h4MmQzYXYvcktraDBGRzhPSW9D?=
 =?utf-8?B?R0JRUkNNRHJhRHJEWi9CaVl5eHhmWUIwWHo2SGFmOEJOT2crdG9adjFOdlJ2?=
 =?utf-8?B?djRKT09UNGF6S3l4OTNiQm1mUUFxZ3RTUzNIc3U4NERmN2hhN2tQaDJOMTNs?=
 =?utf-8?B?VTdQZTJlR3VLVFpORmdvU1c0ZDd1cEF0UDZhN3FVbUFBMU1SRXdBM2FqbHNw?=
 =?utf-8?B?NjhUeHRqc3RyUS9tQS94MWNpdUMreUkzd2tmei9PTC9reUcvSHUxb2s0V3Bs?=
 =?utf-8?B?SmxITEZHdWZtVFgwRmhvK2tKOFlOQ2JRYm5Zem1vKzFXbXNUcUNzU2FkTjVy?=
 =?utf-8?B?T2lmVU0rQ3UvMlI4WnhrUG1DcHBmblVUekFtdDY5akY1VytXR0E3WDRPZFN1?=
 =?utf-8?B?cnEyTEZqbDEwbkw4VklLbnV5Ymg0Z3FOa1NITWt6dkVEZ1JvbjFPc2RZNzRt?=
 =?utf-8?B?SjRFa1pYUEVJMktyalMyUDdXck1PdmpxcGdoN3NlQlRaeUxSNGZ6T0hLN0VH?=
 =?utf-8?B?dTFjSnBLNmZ3S1c1Mm52bnVWUVBxYWx0WFFaUzJQTGZoN1pmTlRGNmtaRXUx?=
 =?utf-8?B?N2pvay9UWFV0Nnp1NTJNeWhxVUhQL0NqOHcwZE5mTWNtRTg3SnNST0FNZk82?=
 =?utf-8?B?b05HZ2NkSlVqY1VkTjhmdGlaL0lLejZ5M2Vtc3F1bVIyUGxyN3ArcG1IWGRn?=
 =?utf-8?B?SDlCdERJSTFOWHNKTi9aUGhxZUF3dzZ5MnhtSkphZXFtUzdLSzJiWGQyNmNQ?=
 =?utf-8?B?aDNFK0JneEVJYzMwdHNHZHRnM2Z4YXk5QnpjRnBoN3doWU1SeXpVaWppc3U2?=
 =?utf-8?B?dlFhc21TMm9Wd2NwZWFUTUpoNVYvaFhrZ243dGpzeFM5M2pyNmI2SEdhdnFO?=
 =?utf-8?B?bnlSaG1RNnUwVHkxR2JCd013eFo0NzFzY1ZjSWdOK0QvYmJoN0lUVlV6cGVT?=
 =?utf-8?B?THk0Q2Ixd2FGeXJBekxkdmFiSnhwNHRjVlZyeEg3QjBGUSt0dkJFc1FZTHVN?=
 =?utf-8?B?NDI3ekIwZ096UVEydjdFZGUzYWJpTGxNbW9Nb1JDZnA3WnAwOWlESmlaU05x?=
 =?utf-8?B?dC83ckxDMTRWSlQzckJqa1RmZk9BeDZzVlJueUllMnY2MDhyTFZYaHpYaWlK?=
 =?utf-8?B?TGprR0VHWkJsc0RaSTZlR1F1cytFMm40VUZ3U3VCSlY1ZXgxWVl6cldqMFkz?=
 =?utf-8?B?d2dyck04V3o2VGtxYS9ZajNzT0hnOTAySE1GSGZSQ1RpK1c1NjI2T3ljaEdB?=
 =?utf-8?B?S1dyWjRvYVN1dUlMSmt1QUVnakVuVlhZUW5Va1JBNFpOOWd4b1B1Q1Q5MHlX?=
 =?utf-8?B?cHBqREhZU3E2NDRWY25DOEdlVVJZemZRUU5wY1p4VnBHVm1nTWwvWTA3ekVV?=
 =?utf-8?B?UlBtK1ZrMGFqUE5nK1A5cWdUVVNYa3lndXVXemlrT0FsTndKQWtBQnZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGIrekxzYXBEamR0dW9TUXVQdmlBS3JpeFBqYnoxT1pTUXg0K05DaElSajNH?=
 =?utf-8?B?QUllYmNHME9HNWQwMDBTdHQ5dVcrWTRRVHdvLzcvOHlqYlZXOWR1RWQ3Sm1O?=
 =?utf-8?B?ay9IVUc0WFBHT2gzejBrOUhRKzdGUW5lWW0vYmFhUEZOYlJ2QXdKRWV0K1RO?=
 =?utf-8?B?REpBNmw3U0lXYTZvZFJHcEI2QVVaVW4reWw1cXBCa2RGY1kvVE1SMlE3S2pF?=
 =?utf-8?B?V1ozOTRjOTlSWHlVUUxYZnNvOWFWMFZBSGUxeDNsN3BWMU5aQ1R1S0hQWi90?=
 =?utf-8?B?dWpqMnFSb0w1cEFQNlQyaGVyQXVRcUdkL21NbCttQzIxM0k0LytQV0w2d2wv?=
 =?utf-8?B?eVVlbVo4NktyemFlL1BhdnVCL3hFUmxTYzVJZWNaWk9vTkh0MFpnaXExQnFU?=
 =?utf-8?B?d0RzUnJ1QjhMd2JwL2tUMEJQOFd3aG1meUhndWJZVDhjNG5GV2VHVzlwVVV4?=
 =?utf-8?B?dGZxclZwZlhsci96cHJQQUJmMlhpeWJTWjVOU2p5ZVdaNzZ4aGtpeitOM3hi?=
 =?utf-8?B?RVVXZitaWm02OXV5RjNFUGVCTjlLR0t3YnExU0h0cnEvczRvNVdNWUlreXN6?=
 =?utf-8?B?a3FRMW9pQWdzTE1ZUlVwSVNuYmliQzE2WXBGeE4zRjZUWHBsekhZUVFXNFVk?=
 =?utf-8?B?MS9EWldhYlJrUFU2T1NuRXlDWTFSRStISDYwUHg2OTlaaGh1a3hMWW5xcCsv?=
 =?utf-8?B?VUZiV1J4b25yNFRiaGsyNnFuZndaVlBWU2tib1pLbzAzODRJN3QvQ0d1S1FB?=
 =?utf-8?B?SFI1SGVxcnFiYXphbUdRQmhmL2FDUi9QM2x5U0d2NmRQVjFheFgrZ0tXTjI2?=
 =?utf-8?B?REtHVkZPUjBQaGZTTTBHWjJRcThmME9ZNEtTK0FyN2pFTnNreTVTRHR3YVFT?=
 =?utf-8?B?ckt6MDliTlUvRVlmcHA4TitsWkpJWEdsdTZTTzRjYTBVd0c1NDFpMlQ3KzZa?=
 =?utf-8?B?Vm5YbGFjVHNtckZRaWdDWm80aVI4anl6ZGxuVTdFVjkzVmpqeEtDS1VBTk1G?=
 =?utf-8?B?Yi9SVllmMXpDaTYxM0JhbXByc0dUajZUT0txUm1DOXFwdzZsbVU3ZWwyamhy?=
 =?utf-8?B?UzUrVmFZbWwvdXNtd3VkcklWOEp2NXl3OWZEUnZ4N3ZKZ2xJRXIxLzhDcXpl?=
 =?utf-8?B?eU50MXlYcWtYRENYaG5zMnJOaDM3VTZFWlRnZlYzTDEvb1YyYWROV09YUXFQ?=
 =?utf-8?B?V1lRZU1ScVdCSTc0N2pTVXF5QlhDM0grOGtxcUxNTkREZEtUZkJYMFRnM1lx?=
 =?utf-8?B?UnluVU9BMEJiSTBPYnh0aTlnYnFLaXdkemRRU2duS2RwR2JmZThyL0t2RXpo?=
 =?utf-8?B?TWdwMkxIaGkvQUtpMUNNME0yMENtN0JUQ0d5SEt0eUROTnNRNk4zLzgweFUx?=
 =?utf-8?B?cS9PRkRuZlcyWUVVdWtzT2Mrdm9Jc3BOOVk1L3A4SjRxZ3BQUkNUejlXN2Jz?=
 =?utf-8?B?ZlpJOE1EdHJDNjJVRFUxWnFXRGhHTkI4UWtsT2xRUGh4WTcwL2YvZ0p5QW1k?=
 =?utf-8?B?bXF3RVd0V2t0KzAyNGVweFd5anRRdFJTU0l1S1V2RkV6U3pjNVF5OExudGRB?=
 =?utf-8?B?S053ZmZJajdWZnM3SExjTDAyUFBHWGxXVE91ZVQwcjVGOVhYYndPcjhBRS9I?=
 =?utf-8?B?Z2JLZVI5K0ZXdW5EREVUUzVYTmJ5ZTE2UGR2dDYvaXFremladHNLcmFlaVV6?=
 =?utf-8?B?YjExUXZ5d2J5UFlCd1JHR2R6bGdJVUhTZ2VQUVN6RENGMVVXMHcrWTROcGw2?=
 =?utf-8?B?bTc0QzZCY0w1UTdGQjFzbHNsSmNVR3RUZTJIZEx1NFdCMmc5WEtkYWhPUGpK?=
 =?utf-8?B?SVIyWUtEU3FLY0tXRW9ibysyb3B0aE5hWm14VUcwVE90Y3ZGZlZXM1hwUGwy?=
 =?utf-8?B?aGptem5tL2dETncxVjlJenVDTDZIMGQ4c2ZmcFdVbDdvWjI4TS9pR05scVEw?=
 =?utf-8?B?ZjZCWHdFVXAvQTBhUVRxWDh4dk9ZQzRNRm9TUVVUTUVLeU1uWUtMYXBFWEpq?=
 =?utf-8?B?NUlUQ28xY2luZkdjM0hNWTR2MkxZZEtwUElQYzdWZCtLTm1vaDRmVk9kYkhJ?=
 =?utf-8?B?cmY0SUcrdXhMTVhYclFqVFJ2aWRMUDE0MjF3bldmbkY4b1dnM2pTemxwY1hx?=
 =?utf-8?Q?TyvKTi7FDhgktP3lNyFa9lpqJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5e1da-fb67-442b-7d8c-08dc83e6481d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 16:00:25.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EmN76CgeWSa76e2jBLU9zccGLa6UX8AIPm/KsDTumE1YDWoXVQyQ8RzTL9vMZIT7DagMi3BFFOXVB2KqqkbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

On 6/3/2024 04:30, Tzung-Bi Shih wrote:
> On Mon, Jun 03, 2024 at 07:38:32AM +0100, Ben Walsh wrote:
>> @@ -436,6 +463,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>   
>>   	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
>>   
>> +	adev = ACPI_COMPANION(dev);
>> +
> 
> The change is irrelevant to the patch.

It looks relevant to me.  The companion needs to get set before the 
quirk overwrites it.

> 
>> @@ -538,7 +577,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>   	 * Connect a notify handler to process MKBP messages if we have a
>>   	 * companion ACPI device.
>>   	 */
>> -	adev = ACPI_COMPANION(dev);
>>   	if (adev) {
>>   		status = acpi_install_notify_handler(adev->handle,
>>   						     ACPI_ALL_NOTIFY,
> 
> See above comment.


