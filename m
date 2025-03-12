Return-Path: <linux-kernel+bounces-557924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC4A5DF60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EA4167E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392614AD2D;
	Wed, 12 Mar 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D1uHTP7u"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0154C9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790819; cv=fail; b=Cw6RMVh/9X5hiLmyE7prHhAEGKm57Uwc2jSV9FV1FkSS5Et35aftGOKx4hAXwGnob806yJxufU+Umc4J/nhDEsm9y+6udqTgK8XOC10rbVp/Tza4t9MMkVBkEZMlwNYIFB3GCgZzEIp+/C5zQ+0pXTtYzdRVxFnUiWAcExFCEKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790819; c=relaxed/simple;
	bh=dfZJoamjBQpC1jpicDxCPDqHTcEvqkGB9VR+YjJu+k0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3ZeMs6iHPYwKEuXpSqFPjYnMnkt5nSOBdnr8jRnxpFow1nQ8oS7aprh53/PMDVFJyG+eYjLoHYB6Mj36Vppocp78vMIRL7UI0Wnl4Q2EjrXM5rMYM2IxyRNCunILhS3ZmImHcuuFQBBqeATsqmbb8NUT8cflhJqZYiITiGHBDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1uHTP7u; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajOFF1ojHHfrabnoeo7V+yp/c8ddo9sPi61UMAPLEp4zgOwk4k892FYBoA+dMQ3lJLvcYV9ldI/cYEuTUUDhKe/YGGxNP6GjgobB6BVYaHFv03YBtzb/C934uV0qsk9nExHDle0Itd2MERrDO2FTFFEVUPMxqJqY/hqMKi79qdxZLyNWkKYQi26qBxLhfOooqy7jaT9iTJaOcFXQgwop5UMR0MmkpPTp+Y6XO8fIgW//GFT7lGbp0Vw09Z3NjpHIIlYdbL8VDWPWeC0iO03xQ72dmEwf7GQJktdSAnQW/LnpMzAZWEcyKV/bMeYYAPFpzgWN5DcotVNhsu2pbLaGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8glSVt8lIGYXyPO9fXFyrM6+9ardAlusCIqyf/xpn2k=;
 b=EVcGe1F7uI57QuGKKnhndvomn3DZuccZcZNznaspG5FT6ai6L3i0SZTHTBrJb5KQJeLBAn7hJbSO61yQz9B5698wy/IlXFgEmIhgZspSKeDA/RdPOKdO7+Nq4nt9NS3BunaqY/3x1VK5AL2U5oxK3t3PyRVLTyVpVbEAu8q53vOib278EN6wydg+hr/VOTj3TOEj7aKG/pefqUDLjCRwKIvMHGMZki0CmbhYteIUL+4i5CEBi2GzkkCSaQD7uWbvle1TkEe9BWKVI9UaAsgqDRSLiCsjRMlppm3+vUufPmxIQV7fQA/EDNTp17mdaTz6azNhEhpynrmEeVGAnnifUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8glSVt8lIGYXyPO9fXFyrM6+9ardAlusCIqyf/xpn2k=;
 b=D1uHTP7uPogWMNKVCnF9bw+2Vpw8KVcQr27rK9GVl+HL/ufrx44oOLbUYzCdKkt07htgatyemGk1drTI9B5W6YFT6fwxK9W7JeYeWde3Wv86V3xaev3iez7LKNyciRQA3tSkTl/h52DGsOtXnAKcR1gT2UFMt4Ixt7sIVmHTyB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:46:53 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:46:53 +0000
Message-ID: <8d58b03e-9017-c800-4379-f2a667fb8a9b@amd.com>
Date: Wed, 12 Mar 2025 09:46:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] x86/sev: Make SEV_STATUS available via SYSFS
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc: hpa@zytor.com, Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
 alexey.gladkov@intel.com, Joerg Roedel <jroedel@suse.de>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-3-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250312144107.108451-3-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:805:de::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7298e0-1f79-49ae-9e2a-08dd6174bac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akRLcHRtS3ZKQzg5eTlidU1YbDhya3dIOEhrU0tGNkFBSkhkL2tjNW10SUpq?=
 =?utf-8?B?R25lY1RoRE1zaXVzMzErdGw5NVZTWmNKR0ZZVnZOZTZKUmdldWdCZnRSbTdB?=
 =?utf-8?B?OEY1MThlK0RqZVdsejl3OHhtY1A0bUtvbVZXZlBNNGErY0tzZ1JYdmtZTkZM?=
 =?utf-8?B?YUIxMTFBNG9PTWRVcU0wc294SHNGOFozZ0w0OHBIdHZEOFhHVXpWcmRuS3Fi?=
 =?utf-8?B?c216c2hRYzJKL2txdWNNOU5aUlcvcWQ4cUVmVmNaV1BDVUJML3hvekJXZjRY?=
 =?utf-8?B?VjU4ZUxpNUxPYUJsbktESTVYODYyaXJ2V0hpeHFjK0NrZys3S25tc0JTczVv?=
 =?utf-8?B?SkJTbUpDMzcyVGFFUTFTUlJQQTB3L3pMUTFLT2hDam9GMVU3RTRNQi9nQndY?=
 =?utf-8?B?c0RzYWVaQzcrelNnTFFlalRhNFRQQ1pBWkJLQmliVTdzNUpsaDUrWXkrd1ZE?=
 =?utf-8?B?RHE1WnliOFg0ZkI0RVdYalRYcVVKWms0TWUvNHlNWlhCYXN5V0piU3JCdmEr?=
 =?utf-8?B?L2w1T3hjNkRXT1FBTm5TSUdxYnJoRnBSbzgzYzNVRXdNU20ydS8yQlVad1Fp?=
 =?utf-8?B?Tjk5anh4b2VMVzd0dEttNDd3Wk1SMkVuajJCWXJKU0R0YksyU1FsVVF5cFhN?=
 =?utf-8?B?bEN0aW9GejByVG5OVVNuN3FGMTZrNVl5OFY3OUg1UmhoeE0xT3dCL2tmSi94?=
 =?utf-8?B?N2djZ1BTODZONUNaNEllNGR4b2tBREx6TXROYmVkME5hWWdrTnNZYW9JUG9k?=
 =?utf-8?B?Qk9WNy9oQVZNTE5LanVsTXMrT0MzUFA3MEthcXZDdmEwQ2FJcTJ0RGo2MTh2?=
 =?utf-8?B?VkZKaXU0eXU2a3VQdUlQcGs1TnEzZ3hIUU02RW92R0NrVnU2NG5DZXkrd3FB?=
 =?utf-8?B?M2ZGRDNvdkQwdlBWRGNIU1MyZmx3R05QcDNSQnNWQk1xQ2JMMlp3Nk03Y05l?=
 =?utf-8?B?dXRJd2VyYnF6akVrQ1lRak83UDFzSC9ldU9WUjc2MHgrUUkzYS9VV0J2TVY3?=
 =?utf-8?B?N0NKMWNhKytPUkZjZGlzZWhrRmpmcDU2TitreHE3VGNaZmREd2UvdXE3eEYy?=
 =?utf-8?B?ZVRQaTRGTk9UL09FaitBK3BHNWdOaERMVGx6d0M5aTRic3Vweis3N0pwN05G?=
 =?utf-8?B?YzNKY3hkSVVWbGJnb01CVENZWHp1bXlFV3FGZ0pQWEJCMUZnWURwZGEwaXht?=
 =?utf-8?B?aGNMNDd1K0R3L3IzUGo1a2pUU1U4NVY0emljMkxXU2ltV3gwWFR2TkVYdkhR?=
 =?utf-8?B?L3o5ajFZampPcGJqVFpKemYvRW93SFlyek0yNWE5NkF5QVJMSWkwalpuWkFy?=
 =?utf-8?B?WFd4K3N6Sm5oQzlKYTZYWWMzNitpVnI2MkVneWJVb2c4VzJYeVR0YjBLUFE2?=
 =?utf-8?B?V3lXRHNwVzVlOWFqOHRRRCtGcWkxUW95dFdEQlZCWU4rZ0J3cU9PR0lzY2lh?=
 =?utf-8?B?T0ZEcEVqb2J3bDFkSGVpSTVoOXVMcEJFNmFvQW04WW41aDQ4c1VlYjB0VG5G?=
 =?utf-8?B?WUNLL1FuQjU4TjBkbFdhaFhWcWpEM2U0SHdCR1BzMTUrMkRwZHZkNVozbmZN?=
 =?utf-8?B?anloanhkMHBpZ0gzdnJGSEluWG9FQUNUay83K3R5M1h5SXZtSlNhaWhPN1Er?=
 =?utf-8?B?Q1o5cFlCcU4rVHdFRUo3L1k2K3I5WFpibFRpeUhaTmlrOXk1LzlSRzZpcEYr?=
 =?utf-8?B?WlFPOVNKYk9EVGJtWUk1RVcyOWtzK2Vxd2tUZ3hVWUlCdTlhQUlwdlk2Z0Mz?=
 =?utf-8?B?eFI0aVE4ek50UVRlMU93YVFDY3pNWjNaTU1pajM3Rjk4UUlkZUJNMWpVQXBD?=
 =?utf-8?B?dXF5OFowcFZpT2w5anh2bG1aL0FPcGlHR0RZaXhkdzU5VW9WYXRFUEJHb0RK?=
 =?utf-8?Q?DmTqYGEKu5luM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTljQ0hUL0RIQlJNTFRmaFphY214OFZId0ljaTZGZExqWjRLSzBhTzRIM1pP?=
 =?utf-8?B?eGpXR3ZWdE5HZUtDUk8rSnVrK1Ywc0ErZERKUjhjZHBqTUtpMnJGRnRWOGFl?=
 =?utf-8?B?MTFRS3JpWW9rbThBa3Vhbm1rUzZrRXhlTWNGK2R5WnNnNW1hbGt2T2V6Mnhk?=
 =?utf-8?B?YVZINjA0NVhQaHRFNERSekFKYnl5Nk11MVhPdjVLczlFK1UxeGJHcmwreVA5?=
 =?utf-8?B?UEw5cCtXRnB3NTdIa2QramVyY1RxeWtTUU1kMDF5Vm1UREZ2Zm1pbE1EVjQy?=
 =?utf-8?B?bXhxQitiWTN5OVg0RTc4MVBVVTNKbWd1UWkxUENLZmdnVXUyNHNiMWtqL2hu?=
 =?utf-8?B?R3oxSWE5bmJZNjNMemIyMTFiUWJSOU1oTDZPZy9qK3NaNVpHZlE0MWhBcjJW?=
 =?utf-8?B?WkRQc1E5TldocXREZlVBUm83bTZ0K3N1WWxSTEMrcGpkUXplRUpSZEE2T2VK?=
 =?utf-8?B?RXZ5QkRCbU1TYnR3RHFkRktVVXhybEpDTVBMYkh4VjlacEE4T05GU3ZBckxy?=
 =?utf-8?B?eTBlUmE5WHBwT0hhZVAxVEY2eHdFM3dCWElmVUFwQXAxS1VsOGk1eXArR2dC?=
 =?utf-8?B?ZW1sTWZqZkZXUlhMdGFuTytKaU9GSERpUkpEY2ZIcFRoWGo1b3d2QTVpaGtU?=
 =?utf-8?B?SFlLQnBWMVZxYnN2RFVGN0toWDdyRU1uVXp0VHdUT0l1Uko4dnJzQ2lBeXZE?=
 =?utf-8?B?STg2YVlEdnZiSjJRdHA3aENrem52Yk9ZQk9KRldNZDhXMElIR0VhVFlCVXh0?=
 =?utf-8?B?eE5DNUxudFhvdWkxQTUzSlMyMnZtRFBJWll4Y3RCWVNJbnV2NnhBczRxanlQ?=
 =?utf-8?B?UnVUcytpWkhBK2ZtbjVkNkRMZ1p6SThYODBZNkgrc0lCczRWWWFDZ1dEVCty?=
 =?utf-8?B?M0xGQ0xvdW91dnpISVZwVUxpU083VWZxbW9LbGdHUm1hK3RPMFBQWUl1Sk03?=
 =?utf-8?B?RXc4aFRjcnFVcjgvb3NQSFM1R0pwMmpBUmIzRVFQNER4R2k3VkhTcHMydmdv?=
 =?utf-8?B?SGRDOWJQclRJTDZYayt2QnVKbjNHaUxkbGlYS0h1VUtBZDNyY003RVdiQUNZ?=
 =?utf-8?B?SUVjUmp3czN2WndkZFduVlpnV3Q3UXNISDNUcUc0TncxeE5YaUduajRNRG1D?=
 =?utf-8?B?c3NXendadDJGRWZiSHcvMFZmdlYyRDFDSkNXSmp6enhjMkIwdC9YUmtQdVE5?=
 =?utf-8?B?S3N2ZzZmT21jUythT1hYbkQ1T0QrZE5mS0gwZkgvU0hpbW5mYTBuamYxSWdn?=
 =?utf-8?B?VldFMlVPRG80eHUzVFY0Ti94R0REV2xUTzlLNkx5eEdqT3JncWcybXdWY09C?=
 =?utf-8?B?dElWZStaK1VwS1FwRTNjTXpwRGI2RC9PTHBic0V0eTJTa0k5YVMzcGNwalZ2?=
 =?utf-8?B?cDFhRDZWdjFaSGV0dm9Bdm00OXMraVlKdi9jQU1uUERkTlFmUTNmNUdtclR0?=
 =?utf-8?B?eDB2bm1jUnhuMFJuTmwxRm1wb0l5ajRJTzIwalI1eUt6MVNzWXh1bEc5Q3g0?=
 =?utf-8?B?b2J1amFrdUV6NEU0a1FjRXlLcnJuTm9VYit5MVlla0xjanhQSWx6QjBYMXBy?=
 =?utf-8?B?ZkoyZmJKWWZPaXJxT2xnbjB3Ri9xRWdCWjNLMENyOEZjZ3FmNEJzZm5hb3l5?=
 =?utf-8?B?bE1Gby9uTlFpRzZ1YTg5czBZdUlJbmdwRkRYUGVtM3JqQnVkaDJxbzJtekVp?=
 =?utf-8?B?Sm0zNVRteStwUTA0REdFOXJ5RVpFeHV5T3NrNFAvdTlpZzEzRkdRYm9RMExw?=
 =?utf-8?B?SytkUEFzOVVpZTNpcVY1dTc4NkVJdGk3NFAzWXg5Q0RNakRkcEJTQUJoOFY0?=
 =?utf-8?B?aVlQdEZ4bHBsamRpUUNvcGtkY0N2c1NuSHdpdlgyN2tBUnlvY2xjelBZeWxn?=
 =?utf-8?B?WmxLWlNKZGZIYnJOaU5NeFA4NFE0Qkw2WVJPZFJDbEFucHd5aUQyVW1JMnJZ?=
 =?utf-8?B?em5HNEpEd1hvb3VjL1VOYVZxSytGRTg5RStadmdpVUJ1cW9GSUs0ZlI4NkdR?=
 =?utf-8?B?N1lKSnJwUWgyNEFiNlR6ejlIZTFuTGR0TS9XUXpoSzA2TDZTNlpMc21ZSUoz?=
 =?utf-8?B?TTVaWitLYnNpY05SbjZtV0syYWJTSWxuOFVyT2lOaHF0cjA5SkNIKzFiTy8r?=
 =?utf-8?Q?tFw5MckQqcBN52c9DrHRNqUvc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7298e0-1f79-49ae-9e2a-08dd6174bac8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:46:53.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkMHrIMMJgkU9fTOQpMUJ/7O+30m/hP3ZRkNqMB9jg/Mss7uLatyl+geu9XCZzVQFYw7qooLfbb1Z9YKknF24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

On 3/12/25 09:41, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Current user-space tooling which needs access to the SEV_STATUS MSR is
> using the MSR module. The use of this module poses a security risk in
> any trusted execution environment and is generally discouraged.
> 
> Instead, provide an file in SYSFS in the /sys/hypervisor/sev/
> directory to provide the value of the SEV_STATUS MSR to user-space.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  Documentation/ABI/testing/sysfs-hypervisor | 5 +++++
>  arch/x86/coco/sev/core.c                   | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
> index aca8b02c878c..54c80899c19c 100644
> --- a/Documentation/ABI/testing/sysfs-hypervisor
> +++ b/Documentation/ABI/testing/sysfs-hypervisor
> @@ -1,5 +1,6 @@
>  What:		/sys/devices/system/cpu/sev
>  		/sys/devices/system/cpu/sev/vmpl
> +		/sys/devices/system/cpu/sev/sev_status
>  Date:		May 2024
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:	Secure Encrypted Virtualization (SEV) information
> @@ -8,3 +9,7 @@ Description:	Secure Encrypted Virtualization (SEV) information
>  
>  		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
>  		      the SEV-SNP guest is running.
> +
> +		sev_status: Reports the value of the SEV_STATUS MSR which
> +		            enumerates the enabled features of an SEV-SNP
> +			    environment.
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 51a04a19449b..3e834ce9badc 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2678,10 +2678,19 @@ static ssize_t vmpl_show(struct kobject *kobj,
>  	return sysfs_emit(buf, "%d\n", snp_vmpl);
>  }
>  
> +static ssize_t sev_status_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%llx\n", sev_status);

Should it be prefixed with '0x'? That would make use of functions like
atoi() and strtol() easier.

Thanks,
Tom

> +}
> +
>  static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
> +static struct kobj_attribute sev_status_attr = __ATTR_RO(sev_status);
> +
>  
>  static struct attribute *vmpl_attrs[] = {
>  	&vmpl_attr.attr,
> +	&sev_status_attr.attr,
>  	NULL
>  };
>  

