Return-Path: <linux-kernel+bounces-562339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C4A62395
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C9189AB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5461802B;
	Sat, 15 Mar 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dlELHfv3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73884C8E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742000667; cv=fail; b=BmliUEXRSVlKJL+8RxKR2Kh8Bc9mEETA1TwQJ+8LwaUaDIbKvKAPFIJ361/EtzKmyglC3VmirxhfmSIOiyIcDG+S7MQqxoKeX8ByN+bmTcagY86AE6HdYBtpCm3CJK8rRy4z0b9j43u4BUDzHud6GsYNyOsnw9UOdZpY4TqJmAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742000667; c=relaxed/simple;
	bh=QoCzOjmUACbkpBn10yVCluUHs+BgtzrqrO6bdUHRlnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tETTfimUZgzBCaP5LTrDyfLL4DU5Laj6nKrgMYvOAm6phkaxY1CrFeGA1RoHCw0Yam8wdEtxAN1/uLZCmdaY7gm2357ppSOKovGrX31v1fyKd0sI4X48UJQBiDNpr37kJXGEfPH4kPljd5bFi1RmZBFT6aTt04fuQt1f0CY59LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dlELHfv3; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8B2j5ucrUMIWncjqSof++WAMOZxEtsolkjZoq0YP3D+hbX5OQxq4rj6RcfqIAw+laotuphA87uEVg2lofvRzbs/ADvN+ddLn3UaSutpMLgWshU10b+XDAVKKEXWgLchmCzwuZtICcWF1N3CoZaNlPPaU0QTlPLsG0Y0wjLlCFlHlosC1GeU0C3BixbH/bHv7XPC+mW1yI/khph0cvLNyo04MO7SVT3RnIuQfo0cvRNP2pY5PbDYpNWtURqLgWZy0sfAeH1l7k38B+EDgzNCJTPaylmiD2AjevTXtipD0SGJtqElf6bP5WmwQPG5OvzYsfQDmrXWYknCvgcHniarWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lDp3Dhww9ux7DwcUZVceNWTVp/qoWX1pVHO5beqOHs=;
 b=ZaNeqFQH1mz30FpVZuHRrhimRCxQLZwXSFCaZPy4yMz/NbYC41pu6fmcYpG+x5RL7Ymm3LvVL3oIcsAU12RzApXOloYBpK6keH76QPyEijYZMiDpomL34F17WW9OpF30tY9tNm0Mdu5uR97sQa3XQJgdqhTwFDjIGbYtAa+GOFagptNK7v1+2S9yo1NvRMW65q3eg5HC63vpAq8KR6qJgAKE7J/4YJtcFFSyUsO6xiyfvwvKX4GCRWoTYoWHGeppjeV79TXGDcNhjmw9+MnCsSwhxsSHNgFOKM/MnEx/u5+sgmhVg6VBF54udtCr1YqXBXyGlp1F2WMXqjgTnFFg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lDp3Dhww9ux7DwcUZVceNWTVp/qoWX1pVHO5beqOHs=;
 b=dlELHfv3fesZvd2SExWSFsipi9lVii7yUTiUlXmdgj7frY6vQv4wGohLoFNImWfLidO0xJfFL5yS3oCTMpjkfe9L/SOcxbESRbpMlIwXUQVwTLkf564btsCZxnpGAcufTddE6BZBTqcevDwboPKteZlb32r2A7ICLKnaGkgqFwNHgN13HAhYiPJttPbSw+B0WKbM9bOSIEEisfbeOa4pllMTYuEp2/BeHRl2UK1iunneHpKcajcUXFkthoDX9JPAKDnZ7ATsBde3Omm9ceZ7TSrTMQpCX8xUv25kL4s2QKc+A7xj+1pU0x3x2RJ7i0U3xLZPcp+3R9h7O/N2jIc/4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 01:04:22 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%5]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 01:04:22 +0000
Message-ID: <c45e1bf8-f91b-4383-8c1a-7e11be02743b@nvidia.com>
Date: Fri, 14 Mar 2025 18:04:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
To: David Hildenbrand <david@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 jaewon31.kim@gmail.com, spssyr@gmail.com
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <Z8tVrOezU2q_0ded@casper.infradead.org> <Z9GmYe-bdOZ8LQV5@infradead.org>
 <cd013218-7735-4bc1-b6b6-80d1129e2b76@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <cd013218-7735-4bc1-b6b6-80d1129e2b76@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 81422e1e-78f9-4814-42a5-08dd635d5269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHFnUTBrd051SW9sZzAzUWQ0WFBTeFBBSE9pdWx1WHRSWFM0Q1pyOG1yWjAr?=
 =?utf-8?B?NExZSlZzTGhSRzN4b2t5YmsyOUtTYmpNOXBoWmk2eStxbTdzYW5WbzQvYmNP?=
 =?utf-8?B?VjBHeFh0OElUSzBxUFE3TFA4Ny9qRFFzQUhHYmVpWE1qUFJkWWJyYWtGUXdz?=
 =?utf-8?B?UERjQnZ6dVdlSHd3ZEdRd1doMU15djNtK2VBeXhYRWFlcEJGbWt3NXQzdkpR?=
 =?utf-8?B?blJ4ZTcrNXJtQ0pxNUFWb3BrRTRkMHZhdGw5UWJ3U05uNFVtS0RDYTlkd1pt?=
 =?utf-8?B?K3AwV0lEYWtBc0lURFl0cEVQMXhaU1pLVTkwZGgzT3ppVlFpMGZ6UlRMMExK?=
 =?utf-8?B?ZUw4Q3JaOWVtQ3F5RGw3WDZ3TWh3K0VIQis0VWoyTnpCNXpLc09LTEtNTUl3?=
 =?utf-8?B?NFJkMVltOXBQNkF0MW5WQTlENFVyTkpZdTJzQXcvUm9PWVB4cldWaHZnMTE0?=
 =?utf-8?B?eU9oaHNmSDhBeGlybVQyYXhwdGo5T09Hc3JOTytSRFRWVTJ6cGgwdDk2WU13?=
 =?utf-8?B?OFhHbGh0VWxyWjkwNmtlUll4U0RCUVVWZWFiZjVRbXV4SFlheitoRGVRUFpu?=
 =?utf-8?B?NkdaUnRHUGExeWtWdWRMejFJWGdHK0lxSG1rV3FHM3NDWVV5UUtVZjNHVXo4?=
 =?utf-8?B?SUtRYnlIb0VBaHh6QXk5bzk0QTVnY09jblFBU3ZVdktlTGhCZUJVMjM3SnVW?=
 =?utf-8?B?b2JaUkpYOFV4ZGNtNHFuUmRzQXhtMkNia2lBbVBMYTVpNHpiL1FobENQOUV1?=
 =?utf-8?B?NkllQ3pReGMrenArUlRrSTF1Uzd2UWh5K1c3RnFSSXN3MTI0VXNwTUFRMits?=
 =?utf-8?B?Q0dORGlmRjJRR1Iwb2FqbjVaRnBMVXdUUFRzV0grcHk4SDZNNURBY2V6L0lJ?=
 =?utf-8?B?M1Ewc09MNmlwRkZQeHp5aFgvcUtLMnJvRTdWc0tFZGtpekNHZ0VVeDVzenE2?=
 =?utf-8?B?M1daUXNMa2F3aUNNREI4aW1nRVJLSlo4S3l0UUVoSjA2ZHJxeWJpbGJGTkUv?=
 =?utf-8?B?cTBKSUNUTDJNelQvUk9hNXNZSGppeVVtQ3hxNXhqdnExMTVNbmNjYUFlSVA1?=
 =?utf-8?B?WE1XaUNwNUJMNXlXci8xYS9wTVV4d0k3TmcvaWNYdGlEekZEcGhjcTBJNlFu?=
 =?utf-8?B?R2lxTGtIR3RkUlp6TGxVSTZUZmJZYXZpTDVSRHJtN0h0L3hiMExNNGJWcnow?=
 =?utf-8?B?L0Yyb2s0Y0xlRVZ0NFhsdTdUVXFJcVJIWDB4ZzRTb2N2anMzYVJmYVJBTTFR?=
 =?utf-8?B?SjZHZE4zMm5iYWhTeDRQOFd4Ylp0VGNiZXpReEoyVE44WjR6bFB5TmtkVGd3?=
 =?utf-8?B?QndWdGZ1QzNzK05hUFEyaEdQNmJBRStDTDlDS0x5aExPZktMT25YK3dxUXVW?=
 =?utf-8?B?Rkd1NjRCZDZoTWt0RFRNTFFweTd4RmJiTkFoWjJqWGJ5YkVBNGVQdnE0Y0pK?=
 =?utf-8?B?UEhLRHVtRm5IN3BuTklWSStyZjVIUzJ5dEdpNFBtTlV0OU1ldS9kakpzNUtT?=
 =?utf-8?B?OVNKNXNyMlJVREFtdHVKOGUzeGtReWxkRFdqVUNJTjM1ZU94bSt5dWVBN3lK?=
 =?utf-8?B?eXVYRFd0aFpHREt4YStXUTM2UjIvbDZFRWtXZThXdFZhVVdGMVBqdVVBMU01?=
 =?utf-8?B?L1ZmVDlZSnVZd0V1dWpZTnk4Sm1OWGlmalBhczNPZ0paZG9MRGhOVnRvZDVU?=
 =?utf-8?B?aWJ6TDA5SG4xTWpDeDJndVZQdVBEY2dxSVluY2JWandhTjBXNWViWUE3cVo1?=
 =?utf-8?B?VmJIdUhVdThETm9EZW5MeXZ4M2c5TURiZGI5WEhiQlpwUVpaVUZyZ1Frbk9C?=
 =?utf-8?B?SkRkVGlHQ1N6d0ZNTzRQK1c0c3l5Yjc3U0Rlam9hcHJ0YVJ5S3VHVi9EbUVK?=
 =?utf-8?Q?QMVSoQrG/CMmm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WURVNW9FVTFCd2tLZ0FiZmY5N0hsc2svM2FzZ3pOMER2bHNWVHZsY3pCdTV6?=
 =?utf-8?B?Q1NkQUtUTHB3M2ZWNGZzdjFkbHg3S05jOGs0T1dpbk5uR2c5VHF4TlFIbzAy?=
 =?utf-8?B?b2pBUkp2WUZNWTdMMnBkdFVFU253RW5qa3ZJb1Qvbk9FaDh2Q1dFRjljUmRO?=
 =?utf-8?B?bk9RNmo5SHI5eUE4YkJCY1RIMHc5V1JlMEVKbjdqZmtvRlN0Zy80RnZMZHU0?=
 =?utf-8?B?RVFXL0QzYStJK2hNYlQwTUFTYmRCbGJxMnRTczcyOXJocm9pcDFMMlN6Q2Vz?=
 =?utf-8?B?M1AxQjBvNGJKK1BzY2ZxSmVFQllXSGQvSCtrdTQ0SDBURDllMGF1amFPY2NO?=
 =?utf-8?B?dXdjOXhqYXkxMk1aWEIvaTFOekhoNTcrMFoyRGlaMTFTM0hVVEZJVVpvNFR6?=
 =?utf-8?B?YWhKL1ZMUnZpQko2QlFoT0F5dlhFT0krZ1hKcnZqRVVFdlRWNGNnV1M1WUxk?=
 =?utf-8?B?WHQzMG5Yc0U3U250bXF3VW9TU3lWdHFlZDFGUDlNeUdsVWRXaktpbVJsZUpV?=
 =?utf-8?B?aTc3OWNtWGk1d0xLR1VNbERPSFo5bkIybW9DWGVKc1hWK0QxTVhGM3MvcXJw?=
 =?utf-8?B?U0xjdWNncmNCbzV0VVBVV2I3TVdVaHVlTVhKZE80ZGR2UzJ4VTJtZ0Y3dmtm?=
 =?utf-8?B?czRMMDJTQ0R6eUJDcVB3TmhjQyt5Q2RmR2VaczRRbm44K1VJdEh1QzRNUlNB?=
 =?utf-8?B?Rk5PeGZjdlYzRkVFbjA2Um1PTmFCRCtRV1NwWVRFdFVhUklEdjh0Tm16Qk9H?=
 =?utf-8?B?L0taaWp0R0pyQWxKT25DU3VDUURYNU81aUJrc3Jhb0dZUnJ5bytoUjFGTDdB?=
 =?utf-8?B?UHh3SzVpbldTOUFMd2l0Z1dxRVRpZ2k5SUJPdCszdUJMUE9SZXZvdDVYZXB2?=
 =?utf-8?B?eTF3UFM5NXpSMlZ0ZURHbTVWZjJubUVBVmQ3Qkh0UFJMQXR0aHp3NVlubUxj?=
 =?utf-8?B?ME90N2VVRkFPZUFHem9ZWTdicVEvOUhibXFNZ2Q0bUM2amIxTGJFWGFBdG5W?=
 =?utf-8?B?b2pndzJwRkVmcHZ6NmYzMWZ1VGE0ekF4WUlLSlgzSDd2aDNQejg5ZXMxSEpa?=
 =?utf-8?B?ZkViQjZWZW51REd4aTdnZnI3UlpGQVJKaUI4S1lrSnVOcGk4dThwanNGSzB0?=
 =?utf-8?B?aTg4WGZNN1dtN2RtUVNZUnVXUGR3RUpOaHBsMXJDaTBreGJpRHNHd1YxVjBZ?=
 =?utf-8?B?cS9lekthUDNQbUJFS1ZnejFQaW9WSzA3dWs4ZDhLS3N4T01GSlBDa2JqejB3?=
 =?utf-8?B?bGpta3VYeW9kb1BMUkVnZElwcFZJT044dnBEVnBJWXpOQ2g0TEdVWWo4VjZi?=
 =?utf-8?B?dncwYTRzMkp0dGJRcHk2VDR5aHpuVkMveFBVRmpZemwwOGFYSHRVa1NNbmta?=
 =?utf-8?B?VGtoYU03ajVQUy93V0VqT0MrTzZPYlFpdHFvTlZMQ0Y5YUh4d09OQnBWNWow?=
 =?utf-8?B?WjlGYzRlSnVKZEtDQmwvRkNaTlJJZEw2RW1CeHVtV2dOSmZ5MmF2cjk3T2s4?=
 =?utf-8?B?cFFTRWVST08ySlArUE02QVdZZDFNa0FVcHdjU0pzNnM1ZWFVVkRzUUhNa1dq?=
 =?utf-8?B?VjczaXV1ZmUwT1k1TmtmRm9PeVNaTzhPQ091S2NjMGtGVWlMSTVPc0dDT3hY?=
 =?utf-8?B?VzY4NTkyaEtWWmFwaHRJUll5eGVrTUZ4R3BoSERnQmY2dmdJeXhMNDhIWXlx?=
 =?utf-8?B?amJCeVcxK0ZrbU15K2RXR1Faa1dXVXJNUXpVdEJ4S0lSUUhiNWpoM0hqMk50?=
 =?utf-8?B?cjlxU0Z5dHpnUDBhYjVOMEJWMDhXV3V4UElKZWRBRDNLZGE2dnVYYzZhaHcw?=
 =?utf-8?B?VzBPbkdqNVR2VXZldFRUcWdnRU42OFkvV0R4SFc2ck9PR0lKUnBGUmZ5MjQ4?=
 =?utf-8?B?ZXN5WTZGakZqVFluRnFaZW5iV0l3YXQraElDNXkyQlRxZDhzb2NGejJOMENq?=
 =?utf-8?B?aVQ1K0tUNjBza0IrNUd0RTBWUU1XNmZrSUl0ciszMGUwVjV6TEZYOENIUml4?=
 =?utf-8?B?d0ZpM3FYejA0VW5PeTlsay9TUDFKY0gyRFdlSzcyNjFmZGdRd3I4TWl1SHpk?=
 =?utf-8?B?Qi80ODhWdm5HOWtEWUpzSzRqYytVOFBhTERlazlaUzJLVUZjNW1Zak15ZFRS?=
 =?utf-8?Q?fLik4w23qr8aKeYDEIA/v9qNu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81422e1e-78f9-4814-42a5-08dd635d5269
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 01:04:22.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQCvDQix6clDjq50H2R2c/DXNMLom+qvZQHYb5HGKGxC/ROv5xS5nXhvWxVPIimx4MlilpccB+QnVYiHwuHXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

On 3/13/25 3:49 PM, David Hildenbrand wrote:
> On 12.03.25 16:21, Christoph Hellwig wrote:
>> On Fri, Mar 07, 2025 at 08:23:08PM +0000, Matthew Wilcox wrote:
>>> Howver, the problem is real.
>>
>> What is the problem?
> 
> I think the problem is the CMA allocation failure, not the latency.
> 
> "if a large amount of direct IO is requested constantly, this can make 
> pages in CMA pageblocks pinned and unable to migrate outside of the 
> pageblock"
> 
> We'd need a more reliable way to make CMA allocation -> page migration 
> make progress. For example, after we isolated the pageblocks and 
> migration starts doing its thing, we could disallow any further GUP 
> pins. (e.g., make GUP spin or wait for migration to end)
> 
> We could detect in GUP code that a folio is soon expected to be migrated 
> by checking the pageblock (isolated) and/or whether the folio is locked.
> 

Jason Gunthorpe and Matthew both had some ideas about how to fix this [1],
which were very close (maybe the same) to what you're saying here: sleep
and spin in an killable loop.

It turns out to be a little difficult to do this--I had trouble making
the folio's "has waiters" bit work for this, for example. And then...squirrel!

However, I still believe, so far, this is the right approach. I'm just not
sure which thing to wait on, exactly.
 
[1] https://lore.kernel.org/20240502183408.GC3341011@nvidia.com

thanks,
-- 
John Hubbard


