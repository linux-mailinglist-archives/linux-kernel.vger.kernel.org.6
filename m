Return-Path: <linux-kernel+bounces-551698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7FA56FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E885C7AA683
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F723ED66;
	Fri,  7 Mar 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QLeJ5Gmj"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020089.outbound.protection.outlook.com [52.101.51.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9561607A4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369901; cv=fail; b=tUAo6LBAK50RvPVyBWzRuJWd3WjVjd1UYX2tyKIjvBCdnxdSlW/fsYXGJ8CepzsAKlmhMlvO/DVgxwnQszIKqlRjuZafvPumPOfQ5GL7okWqNUcbdZGhyH7kWEsqoefWFjBcwv+JuCALKQLpkut9Exx6hu+09HOJhUv+Btdms+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369901; c=relaxed/simple;
	bh=5G5/mIEhz0rLznKyBPh0Co09c5ZzUpTmWQuSRQ4m8ZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4QnlpTnlODwc7UOs1MerxzJgn0XWvpIZRk7AqEhifaSoH7eceXFdaHbsWSZ5bm9t32ZmrJyFqw2EY6mc5Mh7UCbYuIwWGVrapQaEsWNI915ey7r2RTwl36vi6NP8j8ZXuVCPkiUL2HMcMtmLcYVDmlimp2kgWdfpAbI4bTQnGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QLeJ5Gmj; arc=fail smtp.client-ip=52.101.51.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdCczkyYLpWPw8z5o9r81QdawRXW0EqNfriHQW0kK6KsTEJHG2KV11v6x0ukBs5hUOzS0glbd5BCfH9cHtiqBN36u12b7pBCpV1QJ1ivzrwMGH5PJXUjJi6rTEerRvZphvh5zNV6Gk6AJdpkKgSZRbHqf6Vgy0WZpTEzyxzufFp29Q7qj5/dYSvrwAd4NQx5Ci+H12rrySk8zPcrrv+rVOwVpKrbFGKQ6xKFZweroL23tqopndbGC9cMxEV1QXAoXutOiLGnBeSNbFbgTDselhZUgUzUCUeO7r+4fs5SGBTP0CvaWW51r6fNlvzF60wkhDeCNdwBeoWvkf6YLvVZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdCDkXbY1f3imfRhFVvV6/2h5vJpuNyRSAmzbH7gvNM=;
 b=RtxU0h8OqBkHQZ65H1QGFTt/U1LBaHNacsj6ijJ1xu7GMEJ27i1dZO2H7KiPSrrF4Nj5qIeEzqkB1PWKfP5/gZp9uKUhdFMb4CLnz8WJSeoGkvAJwCVZpoelPdisXBHV5Tta++4l/fw6bkcZDuUb0MG6njcw5zoiCRyI1wrwoCIKP2KAqMlDGetucF4eG1NnEeX1JXlWZFvMB37FshzOA8y8saQNkV0RnwN3RHyBzVR11Mrg8yftddf9cv6KismNCf9xbtdlPlEKFaG9rDDQdhOt5miCe8qVx6G5RzD3cphTDWkMz0E5W5eUT+64EaKVIeepQRBQoMy1uDYI4NC9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdCDkXbY1f3imfRhFVvV6/2h5vJpuNyRSAmzbH7gvNM=;
 b=QLeJ5GmjTlG8gxla6MblcPPH8ZBAZ7Gk0nHHqeLhb7YdfV5NiHaA03nB/WgaKykdfjZ6mw9MDUxVGZtB3cvXwLr7qW6V7zQ5JWMdok1XdM2fz07sNf3ggQZVT4vVLSBpwqpz9k77E6T3VeiBcBZMfTXL7mU9tKJCLYwCOYuC2uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS2PR01MB9280.prod.exchangelabs.com (2603:10b6:8:27b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Fri, 7 Mar 2025 17:51:37 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:51:37 +0000
Message-ID: <687513f8-2ed9-479d-a6f8-986cebd562e8@os.amperecomputing.com>
Date: Fri, 7 Mar 2025 09:51:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Pedro Falcato <pedro.falcato@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 oliver.sang@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250306214948.2939043-1-yang@os.amperecomputing.com>
 <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
 <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS2PR01MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe0678d-ef45-43bb-3148-08dd5da0b4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzhKYlM4Y3JoNEd6V1N3bU9CeW92WGxJQ2NRcW1jVjdCeWl4L1hrNDRsSzFS?=
 =?utf-8?B?a1R5cmQ5RitrWWMwYSswZGpVK1hzM1E3RVcwOHhrdVhjY1NOdk1CNFg4ODBT?=
 =?utf-8?B?NXo4elVpV29yU0ZBSDhJY25yQVdRZldLSnk1VU1la0RIcG9QcmFLOUhUUC9R?=
 =?utf-8?B?VzVhSnZGMzVUVnA5SnVCNE9td1JQNWhIU1l4S2tiV3pwVTlCSDhaL3NvQm1J?=
 =?utf-8?B?eHZYKzFvRzJMUzZNeGxhblVzUGlDdzN1eldDcnBjS1YwYmF1c2pZdW9VcDgy?=
 =?utf-8?B?U2hxZ0F4VFdhRkNudmc2MmtxVjBDMFZmZUtPUmFpVk9Rb01iTjRldWREb2xo?=
 =?utf-8?B?bG1SSnA1WkNhMFFNcmJDcy9XVlhJb29OeXNQdk1jaExKdlRoWUtJM01WOFU2?=
 =?utf-8?B?NkhOOUI4RW5xODdoVG5wdHo0TDZ0aGIzVnU5YVI2NXBvWGdMK0JuK1ZoZGdL?=
 =?utf-8?B?bjZGTjFsNTlaSHEwUUd0ZWNQYlo0UTgvbGFNbnJsRWVnL2JWdldUWVBlWkpH?=
 =?utf-8?B?WFgrNGJGNHJnRUMrYjViWWdpN3JMTW9vMXl4Yk5jcFJzY1JzQlNhWFA2SDA1?=
 =?utf-8?B?NVU0b3NKL3c4MEo2bk8rUHlxUDl3VzkrdjN0cndDTDVQTk9xVUY0c1NEa3FV?=
 =?utf-8?B?VDJTV1FtZStsNmxmNk9VT2U4dThXcHJMS3p0L0xVUE5uY1ovVlUxRWdpUCtv?=
 =?utf-8?B?K3dmOHFOd0U2RUt0aWY5Qnp6eHlqaFlVMG81WDAyWlRYRWxIdDBCWkhzN01B?=
 =?utf-8?B?THVWcHd2a2xrdjFTY2N0SlZtQjI2SzJSUFJUVHBmVzdjY2tBRXpLYjBZRnY2?=
 =?utf-8?B?Y2U1Sjlxb3V2UmJtVWxUdlozbGVyZ3U4ekVpU0xiYWRVSUZac24yWnM5aEt0?=
 =?utf-8?B?M0ltc21ZWm5NQitua3h3VVNuREFka0FzUnRzNTl0RmxYQ1pkNnlsQ3hXcFNa?=
 =?utf-8?B?blM3TzRFZUpod3JVSmZQQlF0UXY2TkhBQ2JzS01uQjdsd09iRUVxNXJQRDVr?=
 =?utf-8?B?eERucHdiQkR2VVFzRVVuNmlkamRSeDhSQVZ2NVVpZElVaFBZZ3gvUFdjVkxC?=
 =?utf-8?B?dGNYc2lBNit0ZGsvNlhaMmJ5M0hPbHNXd3hJbG8zNC9Eenc4djlkVzBvb1Jl?=
 =?utf-8?B?Y3czMWJld1FmVjhmTlNOQW9kTzJ2N1h2RWVuL21yN0VFYXVLZ1FyYlkwRVBm?=
 =?utf-8?B?bVVoc3gxbE45Q201TVBPbXlvUWJMcTNaeHhmTkZZVkx3ME45SUI3anB6TUxw?=
 =?utf-8?B?VmVVVXV1WnJpOSsrU3hTcmVSOEhNZjdBcU1jc1o2em5iSGhXN0REKzliRUJr?=
 =?utf-8?B?UVRBSmhlVnBtMzdSOXd4WU1GYTQyY09hTWl0aGtUQ2F3WFdXMzAwQXZ4YkxP?=
 =?utf-8?B?a3lCUkdXN21ESzBFV09pSWFpMGM3c1dqY2RMNFlqVzhBSlVrc1FjL214aDIv?=
 =?utf-8?B?QmQ0Y0l6bHJtbFVVVEFjaFZUZEkvT0pwYWdlOVp0aVFjQ3pkWjRuam1NWk8v?=
 =?utf-8?B?SXE1TmxVQXl6VU9Pb0tEdDJqVmZoOFMxWG92c2JVcVh4TWcxdzlWSnQxTDcw?=
 =?utf-8?B?LzA5R040SVRiU3I5eFJwbW1DaW5UNmg4dGlvdkpzc005SCt5Q3ZLRGcwSlp2?=
 =?utf-8?B?M3g1OHNvZ0gzZ0JqQW03K3V1M1o3YkE2WElqVlp0UFZLSW5zTG82Q0lOSGZ6?=
 =?utf-8?B?RzkrTE85SDNZVnlRTmljcTBxT1h2M3RnWFNrSGxvaksxR1FtMFk0UHhaeU1Y?=
 =?utf-8?B?ekU1MzNUeCtjNWYvdy80cW5aN1dhekRjN1V3dVZlR1NlNTEwTnI5SUI1NTZN?=
 =?utf-8?B?cFhmQlRpWXpNL1pjMDRlVHlNV3ZOMmNvYWlHZGxiVjkzd3RheHg0MzdkKzds?=
 =?utf-8?Q?TcoCwAxUCEB5+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFIwc2pLUzZEQmk4TU1hVWpUb2U0NzRMNXRFbTR4Rkkzb3BDOCtRRnJiRFlR?=
 =?utf-8?B?OG9pMGlJd0RYeEZtWnRxUzN0Uk5tN2JLZWpxNzZVam8vNnNlTzFhZFJIY3Zs?=
 =?utf-8?B?YUU2Z0NtZ0RML2dldmI5S20vSlAyaWhhMS80a3dndjVmdTBCNzZxaFV5WWVJ?=
 =?utf-8?B?ZHJueDZBZnpFK25wQjZNcnJVUFVoSVEreXA1dEd3VnArTkZ4QmxmYUROZHM0?=
 =?utf-8?B?bEdzL29icG12NHdEdXZmWTY4Z3lZNHBHTlg5K3hkeTl6S0cwVlVaTWhyWkxI?=
 =?utf-8?B?NjdBRUQ1K1YzcVZkdjJhbDVRT3NhK2hicFRyeWN6QWRsU2JpeGQ1ZmtzaFJa?=
 =?utf-8?B?NVVsWmRNUFppRVpDRWtETFIvTlpQU0hqT25mZ0ZkWXVyNkNTcXNEd1pEUnRZ?=
 =?utf-8?B?MnNTUXFaZDJpNlp4MWZpSDAwUm5yWERFMnpMSVFGZ0VmUTY2azE4emw1V1c4?=
 =?utf-8?B?NUM1WkNWTVBFYngzTk10aVhENnQ4Zkc5MlBTNWw0ejVaMFpSU0pjenVETE9G?=
 =?utf-8?B?cWpKRkdXWnY0dXIwZy9EeXVMeGtKSU1YdVUxaEcxR2Vja1dRQXhjWW5kb21S?=
 =?utf-8?B?dzBoT0FidlM5MWJLeklEaEdvb2wwdHprbm9tRkF6TndSNmtaV3ZZTlljemsy?=
 =?utf-8?B?OFUvVzYrNFVIa0pDNGVxSTRxV1Yrelg2NWhFQzY4c0t1ay9LTEV3b2ZYSFI2?=
 =?utf-8?B?bnYrdHRsMDJVb3h5azlSb3FjZjlRRGl1YlU2aWZqeXBsSHNtU09YNk5qOElN?=
 =?utf-8?B?Q2xGY2FLS3dZeDlWSzFYdldtNVVMS2lNTlBTdTZhOTdVc3VEcmJTUHBscmMy?=
 =?utf-8?B?YTQ2aXRIWEk4RXFTWUhtU1JBTW84dE5jaW9wL0NRNEJWbzBSZnZSS1p0Z3Nn?=
 =?utf-8?B?R002S0JPdlZoWldWbHJiUm0waFBjMGUrcXZaaUsvSGdBRXZsWHl2TGhmckJF?=
 =?utf-8?B?M0RPOWcvRHI4SmNTOFU0QW5XZVIwd0lBQ280RjdQRms1NGlYeUFUZCs5TjZS?=
 =?utf-8?B?S1lmL3ltU1dTQzFsZ2VQa3lzUGxCQ2ZZcVV1Z1crTnZHSm84eHA0UEtqM3Fw?=
 =?utf-8?B?OTJQNEEwditqd0p4TURtRHViN0FiSXp5alphb2VTM0htQWE0cXVnZDhzYmNp?=
 =?utf-8?B?Yno3eGx3YUtqYU9Edmg0OFgwSVJCSzJZVUZ3ZjlMeHYzeEo2MjFtd2w0Wnl6?=
 =?utf-8?B?QzJ6eWVpZjc4MFpZbTFRV2VlYURHYndaakpsOU45dHNRV05XUldyVytmN2Iw?=
 =?utf-8?B?VGYyUjRYV0MxdTZVdCtwMm1QdFRydGp1LzVYaUNTc3pRWVA0enlPblpsdEtX?=
 =?utf-8?B?L2V0cU5XSmhZL3lPZjllelE5eHYyRGZzVmNvbFp4ZTQ2WU5KczIrSjRKNXRH?=
 =?utf-8?B?OThZTkZBNEU5UHhzbHg4VVJnS0dnVkRtSFJEOGpjY3pSTjhkVENnMUsyWW1x?=
 =?utf-8?B?VkpXMWdzcGZFd1BSakVxTUEycUZIajRYSWVNQlVTR3Jmc0hhYnNnRkwzRmZF?=
 =?utf-8?B?NjRjNjlIM0tXdmRuVnAza3hNZGtiVUxnUTlLeFVjQWFUOXNiS21QSi9waUNB?=
 =?utf-8?B?M0lROFhxaDR3Tll3dU02QVhsY3NBckxNc2F1WldKSFdoYkR0YkVmd0tQM1hC?=
 =?utf-8?B?NmVqOFc3NUhFcXFmeENySHc1ZDlEMXlTZ1FHVWhKTGU5Rmw5MVJJT1g5Sk81?=
 =?utf-8?B?SHZuYnBQZTdONkx6OVlQVU92QnYwR2h6TWx4bUtqMG5qcFZhVnh1Nk5kNTUr?=
 =?utf-8?B?My9ZcFFkbE85eTd6K2JkR2NkVG9sOXpUTHA2VVhpNll3eGFoRXZTMmVQU1dI?=
 =?utf-8?B?eXpsZlA4MXdXelJGcFYyTE9lUXpOeS80RmxYeUo5RnVLeGs5Q2VpWENpUEdl?=
 =?utf-8?B?SUl3T2dwY1VoZEJlUjRDQy8vUEdoQ0xSTlA1UjZqTXZUWWJUdHZ0WEdVWjBq?=
 =?utf-8?B?STBKcUpveXNVRWlOSUx4ZW03ZTlydy9VYVhvaVJMUTE4ZXV3d0hKMEFZYzhJ?=
 =?utf-8?B?enZJSys0WUcvdDhrNEx5a1pKTzlLTEZtcnFPc0tFNDhZNUlaNDRmZFViL3JZ?=
 =?utf-8?B?OXR2dHhoQmlHVUF1dkpvc0JxRFpHa2p4S3hiT1l0N1ZNSUpLQUFNT09pNXJh?=
 =?utf-8?B?dHdnQmZ0bi8waGJnSVF6OWtiTWNYbUliOVBJaHhwY0FhajJ3QTZ0OWIzaTho?=
 =?utf-8?Q?AE0nHtPWmnK20c2AFauRzPg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe0678d-ef45-43bb-3148-08dd5da0b4f0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:51:36.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8y6671PSs34RDUdSEQpcDt8az4TYFjPYlcAhHOcsEqdVgQjwBLqGW0GZC6MoHydebcvBXrN88uBzcMKGx2Vyrqg4dyD/wlbUKO+MZxwbj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9280



On 3/7/25 5:35 AM, Pedro Falcato wrote:
> On Fri, Mar 7, 2025 at 1:12 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>> On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
>>> LKP reported 800% performance improvement for small-allocs benchmark
>>> from vm-scalability [1] with patch ("/dev/zero: make private mapping
>>> full anonymous mapping") [2], but the patch was nack'ed since it changes
>>> the output of smaps somewhat.
>> Yeah sorry about that, but unfortunately something we really do have to
>> think about (among other things, the VMA edge cases are always the source
>> of weirdness...)
>>
>>> The profiling shows one of the major sources of the performance
>>> improvement is the less contention to i_mmap_rwsem.
>> Great work tracking that down! Sorry I lost track of the other thread.
>>
>>> The small-allocs benchmark creates a lot of 40K size memory maps by
>>> mmap'ing private /dev/zero then triggers page fault on the mappings.
>>> When creating private mapping for /dev/zero, the anonymous VMA is
>>> created, but it has valid vm_file.  Kernel basically assumes anonymous
>>> VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
>>> rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
>>> will be inserted to the file rmap tree, this resulted in the contention
>>> to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
>>> to insert it to file rmap tree.
>> Ughhhh god haha.
>>
>>> Skip anonymous VMA for this case.  Over 400% performance improvement was
>>> reported [3].
>> That's insane. Amazing work.
>>
> Ok, so the real question (to Yang) is: who are these /dev/zero users
> that require an insane degree of scalability, and why didn't they
> switch to regular MAP_ANONYMOUS? Are they in the room with us?

I wish I could. Who knows what applications use /dev/zero. But mmap'ing 
private /dev/zero is definitely an established way to create anonymous 
mappings. So we can't rule out it is *NOT* used.

>
>>> It is not on par with the 800% improvement from the original patch.  It is
>>> because page fault handler needs to access some members of struct file
>>> if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
>>> the same cacheline with file refcount.  When mmap'ing a file the file
>>> refcount is inc'ed and dec'ed, this caused bad cache false sharing
>>> problem.  The further debug showed checking whether the VMA is anonymous
>>> or not can alleviate the problem.  But I'm not sure whether it is the
>>> best way to handle it, maybe we should consider shuffle the layout of
>>> struct file.
>> Interesting, I guess you'll take a look at this also?
> ... And this is probably a non-issue in 99% of !/dev/zero mmaps unless
> it's something like libc.so.6 at an insane rate of execs/second.
>
> This seems like a patch in search of a problem and I really don't see
> why we should wart up the mmap code otherwise. Not that I have a huge
> problem with this patch, which is somewhat simple and obvious.
> It'd be great if there was a real workload driving this rather than
> useless synthetic benchmarks.

Inserting an anonymous VMA to file rmap tree is definitely not expected 
by other parts of kernel. This is a broken behavior (or special case) 
IMHO. Making it behave in right way and making no surprise (also less 
special) to other parts of kernel is worth it even though we don't count 
the potential performance gain.

Thanks,
Yang

>


