Return-Path: <linux-kernel+bounces-335899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67B97EC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CAD1C2128D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0C199E84;
	Mon, 23 Sep 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKTYNvG4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD81990DE;
	Mon, 23 Sep 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098035; cv=fail; b=VSOHBRJTTrmI0YcYokQ2s5I6Hwl5N/E2ouWTBrjqwUt2TBt6SxZnJMsEju9mmusD47wJf2lrAhwxVC3q3y6t2q1AKEeNIjYgmTHtbm4TQa7qjj8qBVoIpZ1AXFKeP1Dl+fxL1AxSm04Kisd6nqkZ+G/DPk+xiH9yTxbUPQVE0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098035; c=relaxed/simple;
	bh=pwMWyBwTja5fMdVMYVuIMzkke0ho4UW5h17wxh00aac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qenIO4hctEDQLJjgKA/Q6QR4PAPPtIa9JX4TtzyeUyeV6kD0TYMEo+5GFEibCrU3YdE4oXFSkF55lgP3s2ge8zIpLPwfCoD5ZzCkUiHwD4UVktOZcEPlQcuGUP44aazZpjC+9eR85anlF71LLcmOXj0A4vJFZNacSiv/4U3AAt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKTYNvG4; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cofz9y3xKF9RlaK/eMYRLAUyrB3f2eeoMzbfme0fsQEOy/ywFZ3GliBcVSr5KzhSstTcqsJMO6uQUeKyHPn+sMCE6/hIfHEkHLjR99PvIO/EhRiIXqwZm33BRWVwyL6qdmKxIAMrLEYgWtG/87i30ucdeMaV2P7BL5N9jy+G5XF3fMWuupat2JYDOx5LISrfkgLUvSIWU4J37DX3Q9GwLnRqwxUN6MBVBQf8W0qMD7yrrzCrh9OJtWUsjg8Pt6ZM/J6SQJbcYFwFBwQxz/sjpvJ0bSIfyGVKXIpOE+n/JfEbTP1WzK6e2+xQznuLnMbI69Ebf9GRitVPPrlazGqvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/YvWtqVwwpmQeO7FJgaCVIgQ/UQ76SwRwT0ZKcnDts=;
 b=kk9hhjuPbkC/uXTHiVkSQusZGee2vUiA4oKmEq/AcbRijVUKQF6GaWn3doP+B1qsmkDsWc7XpK7O7mpSOJyeqNKXStiyN5zHGjDR67hEM3ZLgNyppUUpfe9X0qZoyg1uFqI8aJGj3tyjPvCxiZhfdOleLnRjO0YYAxsvJWK0Q1ouvf38aKCgfQVQsHclQj0PoD3FBOI5ySFa9ABzgeI7v0PHh0sqdsO852VLdTAqY9rwadudcLMopUKNvoAWjx3lK19T4hKd4o0Jc6l1hoEGhZRTYoNVwB7KV/dEsrZxpnxhC8qUWZ4KyF5D9qxDOVx4y5hPr9pj2Iq9YDl54CgNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/YvWtqVwwpmQeO7FJgaCVIgQ/UQ76SwRwT0ZKcnDts=;
 b=CKTYNvG4fO/pHZuSfckxqBHvnF8gUJcFv99YTBn9yVfiSAs6gkT2MlKZVE7WI6bYCJKuOSzMf3q3e9v2P/J5r3ltny3VHAPar4F+wAhDHOEcklynH7dhsqj0VmeiX6yybt6HtIMdgvBXHunhv9QL61DKoNIiVGc2qJfb0XYq9wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 13:27:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 13:27:10 +0000
Message-ID: <7c8b8824-2204-448b-92a4-33b27e3df834@amd.com>
Date: Mon, 23 Sep 2024 08:27:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-sysman: add support for alienware
 products
To: Crag Wang <crag0715@gmail.com>, prasanth.ksr@dell.com,
 hdegoede@redhat.com, Dell.Client.Kernel@dell.com
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Crag Wang <crag_wang@dell.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240923063658.411071-1-crag_wang@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 214a33cb-74f0-4676-1995-08dcdbd36d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhROE9SUmdlN2lmSG1lNHJBeHJjM2g2WWQrYzJDVEhGUlBUcWF2di9MWGw1?=
 =?utf-8?B?bmVnQmY0bTg4QnhmQ1ZaQ0ZmWCtJR3plN1lwYms4T0dIUHo5VG1MbGMxaGhq?=
 =?utf-8?B?aEJHRU41bGVCUWxHRE5WQlJVd0NsVHJueWk0WW5pdTJGWnlkWnlzQjNJQWEr?=
 =?utf-8?B?Z0ZMOVlhS3g5RFB5eGtpSmhXOUo4NnhNNWgyaDBOL0VQd21MWFp2dzlQWHh5?=
 =?utf-8?B?NmNob2pieXNZdHo1VDVRQ0hmOWRiVnBERjV0ZmRyVjRWYlhHdWhSMURzSEZL?=
 =?utf-8?B?QkVqLzNyeXZnTjFIOWtCS3dQam5XS2R2QWJ5bjdHZkV4UlpMaWdXRVdqYVZD?=
 =?utf-8?B?NFhHSnZna05JeWl1NmFLQ2RyVFBIN09wL2EycTZiWmwyZEZueGJOSHEzYmNz?=
 =?utf-8?B?eTBBdTd3MkRzOGgySE93VzliZ0JkQzFtMjJ2RUU3R1p4MnBxdVFLZTUyZmJ4?=
 =?utf-8?B?cEcrOEtEd2JVRjJzdDlsVGgwVFdyY0ZFUWE4c1ZRY3hwN0Ura2I0M1R3NFI4?=
 =?utf-8?B?dlExc0grbVlFWk9qbzE2S0JNeEd0ZG1xZ3JoaHZtNGQwWEVrZVhna2s5Tnpq?=
 =?utf-8?B?U1pqQnpNc2VEakx2bmFUVFBxSE5OVU1MWTlnUG0zMXFKZFR1ZnNobElJb3V0?=
 =?utf-8?B?TnQrVjJFMnZOZFc3NzFieHcvRFBpQmpGMUt0WHFDZ01PWjAraE8wQjArNDdV?=
 =?utf-8?B?bExDdGhuNERJVitpbThPYmw3SUNPUFdwVmZ2SEtxcm9Ic04wa0dNRlFVTS9l?=
 =?utf-8?B?bFFyQWhRUUVrSVlXNVJTQm5nb3JJZ0RMZVhMTFJQaVRtZUtvQWVyeWd3QUlm?=
 =?utf-8?B?VzhmK0cvWTdPcTBCRlRwV1pja3JHOWhqQWhiM2w1YkozOUEvKzF4N2pjNS9C?=
 =?utf-8?B?UllQU29mQ3I0b2xKbHB4TnpZbGhYaWQ1OWpVb2FoNmxTV3I0aTRKYkFra0FH?=
 =?utf-8?B?bjVLSjJJUU5LeG5KeDM0d0FuYVJZbHk5bC9vN1QzOWZQZW5SUDhNMkVzNDB3?=
 =?utf-8?B?c25ONGNyZjFRY1pMZ1drLzBPRGh4M0p4OVFvdHErY0NGanZlb1ZmVVRJM0t2?=
 =?utf-8?B?V3FYVTdoZkVzM1Q1QllJUUVPZVkxOUxzNlNDVkZ4TmlITVB3RDY5YlBMNnV6?=
 =?utf-8?B?dlkvRE95SWVDWmwxS0JHQ2dnMElwUWEzdk94T245eFpUTVVOVnVra2NEUTZx?=
 =?utf-8?B?cFp3dHpSWFZoVzFZT2JmOWhMcEpoQkcrK2h2N1dlaU5hU2hyMnJRRTg0RTNZ?=
 =?utf-8?B?dmJCR2xRM3lxbEhqTm55a000QUE5MHl4SGtiRFN2QVNWK3NIYTRibU5ZcUhD?=
 =?utf-8?B?S1piTzlxZlpuZkVsY2xJS3h3SkZHUi90R2hicEZkVE1IclIvTVZUV0dldmhQ?=
 =?utf-8?B?OUwvRDdSUGI1SDMzb1IxT2ZydmNZR205S0NEZ28zam5pQ3YyNldOaDZqVkxi?=
 =?utf-8?B?VDIvNzBaZE9hSG5BN2RVdnVRRTRNTnY3T2ZvMzlJRFl3ekRGaFdpTnlvOEF0?=
 =?utf-8?B?d2FjRU5EK3VzVCtaWWR4WFRsSTBFOS9wYlg4RmRkQ1YyNExNRVJMUzdHdks5?=
 =?utf-8?B?Y05QMzRXWGFDMnltclJ6V3REU0VtbTRxeXVwYVRXYlVzU1JBYzJqbkVTRG5n?=
 =?utf-8?Q?INmmEuYy/EPEisFn2KnmdN1N1ger1NhG4RLBTf/Aowzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWd6UmIxTlBub2RTay9JOTVEK3FCRXBQWk9MVEt3SUtVRnBhZmQrWkY1dllY?=
 =?utf-8?B?ZUFKZy9naWRVVlBtVUE0TTNyVE0zS3hxcnZQZ1ZCTnhSZ2pGVWVqSFBRQ1py?=
 =?utf-8?B?ck5iWk51QncwT2NtM2dhaXl2bWNqd0lPNFVUOHhzT2NDelNVZXd2ZmpaWE8z?=
 =?utf-8?B?RHowWlhGT3RjVWI5UE9FM0pVS3JKT0FhYU5TeEFHdDlnQlR3Qlp4SFFwL3pz?=
 =?utf-8?B?UTVaWE1FUmFZQlhjZmtXSHFhTWlrUWlTQUZRL3FIOXJaWmsvTUFQQ3RnSFBu?=
 =?utf-8?B?VHBQVC9kZnhwMXYzWWpXYnlrMDBNSi9TYzY5bnEwNnozUitaVkhLQ1lVUWx2?=
 =?utf-8?B?SVZaVjNPMzVhQXQvSHpQeGpscWlRR0FEZGZ5amhuNEoyZFpDaVlXSnpleW94?=
 =?utf-8?B?d3psZ0hONE9LdHloclB4V0p1MmxRTFBIOS9mMkpTSVV6eS90bVAyOHF2TU0y?=
 =?utf-8?B?NGNtZjVlcC9QYmNrTncrMVhmUDcwL1gwdHVES0RqM1ErM0NEenZZZ3g2bTMr?=
 =?utf-8?B?NGpBODdHUzdkMmszbVU2TisycmFpVzN1TkdxaWI2U3FNZUg2RlQ5WktiOS9V?=
 =?utf-8?B?blVJSkgwVWJsR1pVYUZrZTE5WHJMWkl1bzFaeXZvbGdicCtnNThtMHhkOW5B?=
 =?utf-8?B?RC93bmxwTFRac0loZFN6RlN5d1Rkc3NQMndkYk1Dd2FkZ2Z6cTI2VHhCVTZn?=
 =?utf-8?B?d01DMmcxWW8yc3pFTEV1SGl1YjNnS1IrZnBuaXBKamFTOE1Zbi9SbWJVTkF0?=
 =?utf-8?B?S2lJMVg4Tm5ZTHRFcWdBdUJRbGRjc1IwcC9BS1hEWGF1Zm1jN204NTRZUDBp?=
 =?utf-8?B?TmFkanROa3ZzendCNlN1OGovR3FqTXdqMUsvS2RzbVJWVEhRNTc2WHA4S2l1?=
 =?utf-8?B?SlI2bEZMam0xdGJRTURYaTVJOVRxUmo2OW9yYmJrb0dGYkg2M0IvZmZvdWxH?=
 =?utf-8?B?eGdvYUlsM1NNMldmbmRJWHJZeDU4UGFPQWNzVVM2cThDbU9HT3g5U0JiUC9u?=
 =?utf-8?B?TUtxRGxjVEwwUktJNFQwWlA2K0JIRDFIM2I2b29DOHN5b1BsSlpzeWQwYUlL?=
 =?utf-8?B?SWI2RXUrOTkrWU9wSjBQQ0xIam5JUjQyVjNld09RZVF6dVdyRHZsTXBXYzFh?=
 =?utf-8?B?aWVJRnJQOHhtUlBUdWcwamJhV2tNUHhTWkRvTjJLM3UxbWZ3MWVrTy9rUEtX?=
 =?utf-8?B?L2VjMUttWGk5M01BU296NTdPSWs3UUxpMVQ3WEJ4Y3F6dXB6d3daWDV2L2xs?=
 =?utf-8?B?anJVelBtVDFENjBvL0pvZDIzTzVKZk9iV1E1c1JCMnZTdXBsM2xrako0cS9E?=
 =?utf-8?B?cnp0VUtZUHF2cGorUmRZSjAzbitXVldOUUFFWHY1SFJCdDFpaDVZWFdkSUdE?=
 =?utf-8?B?WXZjQndLYjNCWnI0NjRNOU02dytvWDhsNzUvSVRtMUxiM0NBNS9oSkpZZ09Y?=
 =?utf-8?B?aFUrU2pBY0dBNjg1MUJCb28zbFZNbC9yTkU5M1cvUGlUMFFaR0h2NGVEeFpG?=
 =?utf-8?B?bHgwczBjckN6WmFMUjkyeW4yVzZZSDEwdFV0amFQSjQ0amxka3IyTktJUXlx?=
 =?utf-8?B?UTUzaVg2ZmRLM1BETklBUHhwaVg2WVNqOGdneCs5TExzYngvVEVtbnNvQXVU?=
 =?utf-8?B?YUxJaVJXZ2RWeWJrN255MzdjOU1mS2RRcG5QdzJId25UaGxIS3pQMzJUQWdE?=
 =?utf-8?B?TU02VGlLc2orMXMxS2FxdXovYmV2VE1Dd3dyc0k0aUZvS1RWdFdlV21CS0RX?=
 =?utf-8?B?V2xLeG5mVkZZcVpVT1d4SWJ2dVc5M3psWFdNekN3RVpndzZCMzRJakd3UzNG?=
 =?utf-8?B?bFVHVGxDWlNyeFRzTDRuTUNwaXdMZlBBU0lpQW5nQ0EyTDNqL3M0OHdzZHdn?=
 =?utf-8?B?R0FMUE1VRmpYTm0rNzJLd2pVTzhOY1Y4dFBDN08va0pHZTIvbktidFArQmho?=
 =?utf-8?B?citTRnBuS0F0b3dDMGxGZEczUzl3RklEMHY1N1VINUtBRjN0UVBDbVhsN1BY?=
 =?utf-8?B?N2xMOElFNHlpZG82a21la2syUmdzZnhYT2xRZnpoN0JPcDh4cG5oRkJGSWFK?=
 =?utf-8?B?aVlpbjJ5c20rRDU4VVJEdTlmZmRQYnlubDI5elFjNUhndEVDbzlBUVFwdk5n?=
 =?utf-8?Q?GDzc1TtwiWtsalRIzGQnMb7pN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214a33cb-74f0-4676-1995-08dcdbd36d86
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:27:10.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVufbQfo4K0DmJkcGa4xYsRc9uVq5Ehn0Jv7r0zDL3gMEzB8C0bX7fu/nb/xx8fPDAJ1dfaAyIduH8IoJEEC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766

On 9/23/2024 01:36, Crag Wang wrote:
> Use SMBIOS Type 1 manfacturer instead OEM strings to verify product
> compatibility. Also, add Alienware products to the support scope.

Alienware systems don't use OEM string "Dell System"?  TIL.

> 
> Signed-off-by: Crag Wang <crag_wang@dell.com>
> ---
>   .../x86/dell/dell-wmi-sysman/sysman.c         | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..2f3f7e307b29 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -516,12 +516,27 @@ static int init_bios_attributes(int attr_type, const char *guid)
>   	return retval;
>   }
>   
> +static const struct dmi_system_id sysman_dev_table[] __initconst = {
> +	{
> +		.ident = "Dell Inc.",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		},
> +	},
> +	{
> +		.ident = "Alienware",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +		},
> +	},
> +	{}
> +};
> +
>   static int __init sysman_init(void)
>   {
>   	int ret = 0;
>   
> -	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> -	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +	if (!dmi_check_system(sysman_dev_table)) {

Would it perhaps make sense to be an && condition instead of remove the 
dmi_find_device() conditions?

IE:

if (!dmi_find_device() && !dmi_find_device() && !dmi_check_system())

Then you can continue to cover anything that has been rebranded too.

>   		pr_err("Unable to run on non-Dell system\n");
>   		return -ENODEV;
>   	}


