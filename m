Return-Path: <linux-kernel+bounces-547250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1861A504E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401E117701B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A02253336;
	Wed,  5 Mar 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaKQCGUj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234F191493
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192056; cv=fail; b=PrRM6rRyxY3cbyqUh74G7GO8kA2opXeJkIJAAZ2YWucpoDMsOaEBF2zScGoftHwQwchBkpuzEtP1p3dPYQMSioP5Q0husTdmlTlEq4+1DVga3Wod7EwVDYNKSJpZcNvDJwVssQB0YnIMRGAO7Xsnrm7UYrv+2ih/qxGILEXDWQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192056; c=relaxed/simple;
	bh=3sHcG6lzpg2Hs1mryf6P9GWUGEja4xSqGM73drke7qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pu2wbIbyAHZ/lpG8VwWGIkxrRJiqAMSbHjstivWqhwGi+gcVvwFhERmbcfGmrWW7WubE/DOyAWlDLiDDtLAH0PGmaf0AJn/N3DTWXkQDNOVyF1Nf0ZN0f2s5zjqwXFM1UW4JNaVgMeKJ5JcRYc9HowtFdolDWGBN5kvP1KOdxqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KaKQCGUj; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncWz5gx2ewwbharY/bH43O9dzavjKXfqiiG3r0Z+ItEbdPceRrwPsZ6D5Rbf44NVmsWhxNt3+sgsHTN27K41Pc/uXLVo3IKDC1PqgMY9va9NvY6DsUWlUgryFQq7mAco5UkOvGWrjd9vpOcF/M299EipF0Q2KgHNYA7tsPXgsG5irsbqtVE9poXD3mulb49OCr0SD0uQafULmwSNqI/bkIpBVIag0bmIy4updPIG1SqTGVxtleXFAPQyArmyo+ao62zjhyCFiaamt1dsdIN2sGC8gSSDjKheGehjznVdy/rXrI/vsSWj2zCI23l42u6iOOCSHfMJl9NQ7FomEhoe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5vs2+r4Fen+WbJVcc42ndJBN1O6DcXLhQfE0i7RjFM=;
 b=vISJRNrIrtY4Mz1Pjx5hMuLOalSx5DVrHN+rg49D/DbvlRXOLJ0PzVBKTOWEZtygcN1P/CpEA6GJplCui9+ITo/rlvn51Hcgk6qvNKQeRWK0Kyw57RMm3u8vkd1Eo0DjiIjvW61uV/HclQmBjbJuxLkDPHBDPTDHHxgCyHhc1F4wfDzEdM4T+H65NxWsw/yqJb+K8mYH8DXHhtkzVSbTnZr5k/obLonoPvdI1Z1fc6fqxh4KsWcP1z+UEqcd6DwiqmUyYu7gR6mnV8BB6WZXa3NmUjeHZA+coVZByyFUV7t5FEsEriC0yc6V7N1WrA1nZ6jYPIjlcdSpk4hX8OaE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5vs2+r4Fen+WbJVcc42ndJBN1O6DcXLhQfE0i7RjFM=;
 b=KaKQCGUjw+qyNKUQMcnGgx+WMiGopWIuWR1qxkBmYnEI7cGdy4hROza3jxD9Y9iBRt22uXABS9rzm9vDXkZsl+NPhmYenCPQkW/4FsoczM4wRYkE09Pdk7ooRjKhu4xRQ9SmQM14krYOIKZGmsL+poc4CC9sxjK/Y+hgEUYhisnp7Cei7Pc1aNc4qdqOhiIaJWXBO6scd2Ab5pYT/0cwVBz1Drgue2/XpKgxnS2GaD7Y5b9tBqf/3BrbrPV1iOPQsPUR1Mj6KNPpVwwWiagj+8kRn3KZDvQUnzAWCtGcCtCjj+y3g6AVuVI9v691roU3NjrcIuMwyPOjluWJdSk77Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 16:27:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 16:27:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liu Shixin <liushixin2@huawei.com>, linux-mm@kvack.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Softlockup when test shmem swapout-swapin and compaction
Date: Wed, 05 Mar 2025 11:27:25 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <376D50C9-6DC8-4F58-9C43-173EDCD412DD@nvidia.com>
In-Reply-To: <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6e36c4-cc16-4a5c-26da-08dd5c029ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXFVQjVCVjRSb21LVXhzYmFkellNNkRPWTlrVUt4MlNVZmxyYTZPUnlNTE42?=
 =?utf-8?B?ekN4V2hlaFVFVmNtSnY5ZGFzZDAvU0xrS0UyRUZLdEtHOVN6OXhmU1pUa0ph?=
 =?utf-8?B?ajlzVHBGRmFlQkdxTEVGQXdCbFRBTnBVMjFRRGFxdGNaeGh6SDdlUmtFMnFu?=
 =?utf-8?B?NWI3VzE2VHZoN0dwcFYwL2JpS2tITDFaSERpanArM2RxcURhejViLzJFV2NT?=
 =?utf-8?B?VVN6T2xaaS8vL28xdzdnbDdmaGI3TTlpRlV0emcwY2M3VmJmWVFsVGRaWnZX?=
 =?utf-8?B?Zlg4Y2xOV3MrcllnRG0vQnVxcFB1S0dXSms5TEZLUHdpYVlUQWE3UjdCOWtl?=
 =?utf-8?B?bEJSMDBWQmEySCswbUZEVDBxdy95bVBYNkM0d1ROdDJRN3hPRk1XOTI1VzNH?=
 =?utf-8?B?TmFZbFduNnBseXNuelZTYlVoNUc1VUJydDh0em5tdEhqQlN1b3FvdzJhUVpR?=
 =?utf-8?B?MUdHWmdMZTVUdkdYM1VsNkV1T01XbEc2YnpUb3ZwQm9qV0VaOEdLeXRZWDBH?=
 =?utf-8?B?eDdEcksrb0xETHpiVUl1anJ5MFpFR1JTUlpaaE85V1ZySEo4TnN1ZGhCazl6?=
 =?utf-8?B?N2xrQUNjalJINEVOdVFXcVY5RTVEMDlGb3BUb2l3ZndYNDlKSGQ3MEpJb1d2?=
 =?utf-8?B?NVY2L3Y1ZkF5eVdKTU0vaGxiRU41K1p6VTNZdUVVZllOVUJoMmVmVlVTTEhz?=
 =?utf-8?B?Q0k5TitqczcraTlxbDJtS2dtUmU3WkZGaDFxY2ZEMzRkT0cyb25MWEV0cVZq?=
 =?utf-8?B?NE53MjJqQTQxSnA3dmw2QlY5UGJUeE1HUWwzMVVCL0J3dDBHUXlXMnlLR3Br?=
 =?utf-8?B?ekFhS1R2V0g0NGs1SzNiQ1dWSVVqZ284dk1qN2JMOGgzR3lkaXJjU1M4QWFn?=
 =?utf-8?B?Uk1OcU9Wc2h5SnQ0NW1Qcm1ld2o4UWZ0cldib3QxRTQ5b0xpOEljUTBoNGI4?=
 =?utf-8?B?aFBmVS92RkRlMEVNZ2dob3ZhL1BEekNzbENEZ3F5N2ZOY0pRcGs5a0FHdG5M?=
 =?utf-8?B?WXJGRGJpQ1BYa29ucmVBM29QMElWd1NNcU04YXZNZXpBaGxjbEQwbHNyL0pN?=
 =?utf-8?B?K3B0RWJkV0RUVG04Uk5TV01mUWFTVVc3VFF4SDlPc2phQ242NVNFQ2cvbW5V?=
 =?utf-8?B?SG5EcFVLNjNwcGJoc0xTNnBWUStyMktQbWl1amUxQWk3c01TaTMveHZOZ2pz?=
 =?utf-8?B?Y2FpbXdtZ2hFNkN3MlRyZngxcTNIY1RsU2ZMeUF3L0tnQlduQ2ZwbkUrczhJ?=
 =?utf-8?B?cGU2elpCV3A3Umo0T253RXhTT3pkUzcyaktCYlczZEFueHZOdDlXQlNDRHIx?=
 =?utf-8?B?dDRNVTVCZ0kzT0YwVCtIQnA1bHF3QkRENHhzcnV0cUVSdlAvRzZlN0FUSkVo?=
 =?utf-8?B?YWtQTXI2WllsK0NLRnpFcjBHandMaFdManY2MmFGcTFpNXNzVVA4c1ROUlhU?=
 =?utf-8?B?WXFGWWVML200dkh6NGtMdEM2UmF1TWwvbkU3TldrMitLandvRWVjdjFya1Ar?=
 =?utf-8?B?YzNKcTF5c1dDcW9XVFRCMHF1Z1dzaFhHcTU4VmRmbkVzUjJYdHdUZWpYSlBU?=
 =?utf-8?B?TzBPeG8rc1llV1BoM3RKMGZkMDhWV1hmV3dkaTNmNkNJTUJ0K3Vwbzd1b09Y?=
 =?utf-8?B?T0ZxVzVWSFZEMzNlMmJFOERSTjV1cTBXeVJ1UU8za0lXQ3pjU2VoTHNYcnlC?=
 =?utf-8?B?Skd0VVZEN3p1Z05NWDJFSm1BSHAyaVZIMDgyeldvSXJkQVhIYzNYSHhNNWxK?=
 =?utf-8?B?eTAxd29oVFNrbjJRSUZWWXU2alJhbHNycGhoemx5TzRNSHJWVXVZcGhEeDFY?=
 =?utf-8?B?MlJnQVh3ZENZT3QvSURFNEZHd04vc2lLNVJlMHpRZXh3citoZFhlNjFodDFM?=
 =?utf-8?Q?JmdRgUXSlwgn+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFqV2VHQll2UEkrbEFzYnhBQm5ZVHQ4ZEQ2eEMrUXVCWk5aUGYxZkp4Ly9G?=
 =?utf-8?B?bXFMN1BBYWRtZ1JRWFdrNnB3N082UmFpanMzUWxGSUcwRW00WUJmMGxoSnJp?=
 =?utf-8?B?QWloM3BIeHloL3BDZlpNVEMwdWhiaW1YdDlNbjlweFZWamJiWmtqelN4ejR4?=
 =?utf-8?B?NjBFeDdqejQxeGRzbDVSbE5uR3h5emYrMG8vRmxGV01rYWlyYlgzRmdLOXlY?=
 =?utf-8?B?U3B1Q0FNc2tPR205NW5ZbVZhYjRDck1sYm9za0NXWWd5MmxYWXhOLy9vQkY5?=
 =?utf-8?B?SFNaanJmcmtVdC9oTGpCS3Nwb3R1TDdkRHFzUm4zM2NUZGkwQjl5OGVmM29P?=
 =?utf-8?B?UnpaNU5hOU1TeXlvSHMvVHhxL0NENXNHQ3hvakpCbFhUMFd5T010L3U4UWtT?=
 =?utf-8?B?MGpNY0kyWmhiQ2tKMHlXV2NqY2xnTlJKVHZZTUpJOFVyeXIwZDlQNy9BMWpi?=
 =?utf-8?B?bytjaFJVeGRDMjhZS1F0NDdoZ2kxREEybkRDRmFicFFYeHI3bnVGenJrbVhh?=
 =?utf-8?B?YWdCeTNiZE9zODVsN05yNFU3cWtHdlAxc09lNi9OK041NnlHbXFTc2V0STVE?=
 =?utf-8?B?TXhvb3RDa0g1NjRPbUN2Sllrd2wwbUlJcjVUa1RMaTRMUDI5UXVLWFE5cEZa?=
 =?utf-8?B?YUQwdVBoNUpsanpvSWo4c0VOSWh6ZDlnbml5cWc4UnJ5aXVSTk1ydDNnZ2FW?=
 =?utf-8?B?YWtWMXN2K2pWdndhbE95VkY5QWF5Tno3UDVlNmZPTDBkR3ducDhyRW5DRS9o?=
 =?utf-8?B?aXVTV0lZYThxdG5zUUo3dDR3dUhSdXo1b3piZjVjbGVyTGYzZEsyaEk3NnFO?=
 =?utf-8?B?cmVCc2trUDJiOXNJWXdHVTBqQVYvTkhoaXNuTDBIQ0lGWHI2TVA3RmFSNXZD?=
 =?utf-8?B?TFVjRlBzUE5oSzk3WDUvNmNVYnpkdDY0M1MxTFhaS2ZyRFVUMzhidkd4dDk4?=
 =?utf-8?B?Z3kwNythSW9iSlhYV09ReEh0dXJOSks4VDU1RlJDVEltYzdkNUlvcUhJdzB2?=
 =?utf-8?B?UjdXd2EyTGdGVEUrT3h2RTczdkl6V1BmbUgwQW12L09OeFFzdnRNa0wvR2N4?=
 =?utf-8?B?U1lzSWlPK1BMc0M5Q0xPRUIzT21GSlE1MkdlZEdqd0lEaEx3dlU4L1pCNXds?=
 =?utf-8?B?cllVTG9aUmwyY0QyUFd4eHR0TGpOckNLR0xZZHgyb0FBMGdvNFNDK1EwSk45?=
 =?utf-8?B?U3M4L2tiSEF2OWR2QmhFcnA1QzhTTkxvQnJTUDhHWWpMNjlPNFZ4YWFUbGVo?=
 =?utf-8?B?RURtVDhlNEJ0cWV5TWlyZGRseURjK3k4bldWbWlXZEhTS2w5S3p3K1pVZWpV?=
 =?utf-8?B?SG1RSzlqbC8yb2xDck5VVG5zSG1aUlRMTGY5ajFKaUJNeFcvSUJUSDFZOHRm?=
 =?utf-8?B?dStncWEzYXY4ZndDSk01aW9xMzYzNStJeHc5akxFUDZLZEVwcWdiWkEvMmN6?=
 =?utf-8?B?M2NQcitVbTdGeVFxbG9qMUtiV2tweDk3VUpCZ3lnTng1YUZRODh5cko0S3Qz?=
 =?utf-8?B?U0ovYlU3RzB3T3h2RFRYMWM2RkRiMmI2SzBuOXBKbTFlTEtzeU04SGtURUpr?=
 =?utf-8?B?MFhxZEd6bXQ2Q0I1bHJPaUlyZWxxcm9Qb0w0OGJQRG9ObWNMTHdOcHhBUWQv?=
 =?utf-8?B?NHBoT2dHZHVkVml6UUwrN2RqVjVjT2dwY3A2NWhNaUdoWmRjY0FYR0x4NEYy?=
 =?utf-8?B?cElYWGI1SXZJNjRDeU5sVEJFaE1hY1ErSmNpWmsvL1p0YkdQYzBIbEx1SEc3?=
 =?utf-8?B?Vmt4MmZIYUp5QU5NZHU2VTUxeDBKamdTMWxvVGROT05md20yUmcwQ0ZEZ1l4?=
 =?utf-8?B?d3VvZ2ZUNkZOcGtFdHJhN1F5N0F5ZGxwc3pERzBmR1lkZVpJdktEdjI3NWhV?=
 =?utf-8?B?M0cvRVBFbVFvR292amJmZ0liMTdLUmFaZk1BcFcvTGlhRjJEd3VDTmFVWUFN?=
 =?utf-8?B?Y3ZEeFdSRmNmYzl2KzYyQnVRVjgxV095dHUxdkVPU1VyZ2o0NWFBdVRhbDRG?=
 =?utf-8?B?bXZjVFBvdlVWK0d5KzljNENHblhMdlFOYjA2R3hjbkdVczJaRndOaVFoZE1E?=
 =?utf-8?B?bHN5ZjRxZjBKMUd3cUdDMHN5QWdZOXY0SGluKy9KMTZoaGpYYUEwc0txNk1q?=
 =?utf-8?Q?O5TbiO8K6kP3NCraY0SLHKF42?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6e36c4-cc16-4a5c-26da-08dd5c029ffb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:27:30.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Om2724obFLIejJiegyAbh+QK4xrF8fOPDLWZNPEZNwtOGh/Qg2X+PCe8/y45D7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411

On 26 Feb 2025, at 2:22, Baolin Wang wrote:

> Add Zi.
>
> On 2025/2/26 15:03, Liu Shixin wrote:
>> Hi all,
>>
>> I found a softlockup when testing shmem large folio swapout-swapin and c=
ompaction:
>>
>>   watchdog: BUG: soft lockup - CPU#30 stuck for 179s! [folio_swap:4714]
>>   Modules linked in: zram xt_MASQUERADE nf_conntrack_netlink nfnetlink i=
ptable_nat xt_addrtype iptable_filter ip_tantel_rapl_msr intel_rapl_common =
intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm =
rapl cixt4 mbcache jbd2 sr_mod cdrom ata_generic ata_piix virtio_net net_fa=
ilover ghash_clmulni_intel libata sha512_ssse3
>>   CPU: 30 UID: 0 PID: 4714 Comm: folio_swap Kdump: loaded Tainted: G    =
         L     6.14.0-rc4-next-20250225+ #2
>>   Tainted: [L]=3DSOFTLOCKUP
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ub=
untu1.1 04/01/2014
>>   RIP: 0010:xas_load+0x5d/0xc0
>>   Code: 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 73 1=
8 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d
>>   RSP: 0000:ffffadf142f1ba60 EFLAGS: 00000293
>>   RAX: ffffe524cc4f6700 RBX: ffffadf142f1ba90 RCX: 0000000000000000
>>   RDX: 0000000000000011 RSI: ffff9a3e058acb68 RDI: ffffadf142f1ba90
>>   RBP: fffffffffffffffe R08: ffffadf142f1bb50 R09: 0000000000000392
>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
>>   R13: ffffadf142f1bb48 R14: ffff9a3e04e9c588 R15: 0000000000000000
>>   FS:  00007fd957666740(0000) GS:ffff9a41ac0e5000(0000) knlGS:0000000000=
000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 00007fd922860000 CR3: 000000025c360001 CR4: 0000000000772ef0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    <IRQ>
>>    ? watchdog_timer_fn+0x1c9/0x250
>>    ? __pfx_watchdog_timer_fn+0x10/0x10
>>    ? __hrtimer_run_queues+0x10e/0x250
>>    ? hrtimer_interrupt+0xfb/0x240
>>    ? __sysvec_apic_timer_interrupt+0x4e/0xe0
>>    ? sysvec_apic_timer_interrupt+0x68/0x90
>>    </IRQ>
>>    <TASK>
>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>    ? xas_load+0x5d/0xc0
>>    xas_find+0x153/0x1a0
>>    find_get_entries+0x73/0x280
>>    shmem_undo_range+0x1fc/0x640
>>    shmem_evict_inode+0x109/0x270
>>    evict+0x107/0x240
>>    ? fsnotify_destroy_marks+0x25/0x180
>>    ? _atomic_dec_and_lock+0x35/0x50
>>    __dentry_kill+0x71/0x190
>>    dput+0xd1/0x190
>>    __fput+0x128/0x2a0
>>    task_work_run+0x57/0x90
>>    syscall_exit_to_user_mode+0x1cb/0x1e0
>>    do_syscall_64+0x67/0x170
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   RIP: 0033:0x7fd95776eb8b
>>
>> If CONFIG_DEBUG_VM is enabled, we will meet VM_BUG_ON_FOLIO(!folio_test_=
locked(folio)) in
>> shmem_add_to_page_cache() too.  It seems that the problem is related to =
memory migration or
>> compaction which is necessary for reproduction,  although without a clea=
r why.
>>
>> To reproduce the problem, we need firstly a zram device as swap backend,=
 and then run the
>> reproduction program. The reproduction program consists of three parts:
>>   1. A process constantly changes the status of shmem large folio by the=
se interfaces:
>>          /sys/kernel/mm/transparent_hugepage/hugepages-<size>/shmem_enab=
led
>>   2. A process constantly echo 1 > /proc/sys/vm/compact_memory
>>   3. A process constantly alloc/free/swapout/swapin shmem large folios.
>>
>> I'm not sure whether the first process is necessary but the second and t=
hird are. In addition,
>> I tried hacking to modify compaction_alloc to return NULL, and the probl=
em disappeared,
>> so I guess the problem is in migration.
>>
>> The problem is different with https://lore.kernel.org/all/1738717785.im3=
r5g2vxc.none@localhost/
>> since I have confirmed this porblem still existed after merge the fixed =
patch.
>
> Could you check if your version includes Zi's fix[1]? Not sure if it's re=
lated to the shmem large folio split.
>
> [1] https://lore.kernel.org/all/AF487A7A-F685-485D-8D74-756C843D6F0A@nvid=
ia.com/

Hi Baolin,

With step 2 and 3 above, I hit the error below on mm-everything-2025-03-05-=
03-54.
It hits VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index), folio).
mm-everything-2025-03-05-03-54 does not have my folio_split() nor xas_try_s=
plit()
patches. Can you take a look at it?

What I did:

1. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_memor=
y >/dev/null; done=E2=80=9D to trigger compaction;
2. use zswap with =E2=80=9Cecho Y | sudo tee /sys/module/zswap/parameters/e=
nabled=E2=80=9D;
3. running shmem_aligned_swapin.c you gave me with 128MB SIZE and using
memset(shared_memory, 0xab, SIZE) at the end instead of just setting 0s
(this should not make a difference from your original program).


[   37.591314] page: refcount:2 mapcount:0 mapping:000000000c53d1a6 index:0=
x6687 pfn:0x169420
[   37.592552] memcg:ffff8881781c1800
[   37.593046] aops:shmem_aops ino:c0f
[   37.593586] flags: 0x2ffff000002013d(locked|referenced|uptodate|dirty|lr=
u|active|swapbacked|node=3D0|zone=3D2|lastcpupid=3D0xffff)
[   37.595138] raw: 02ffff000002013d ffffea00058a6b08 ffffea0005a50408 ffff=
88817951cd68
[   37.596207] raw: 0000000000006687 0000000000000000 00000002ffffffff ffff=
8881781c1800
[   37.597305] page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio, =
xas.xa_index))
[   37.598464] ------------[ cut here ]------------
[   37.599119] kernel BUG at mm/filemap.c:2134!
[   37.599729] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   37.600494] CPU: 4 UID: 1000 PID: 1922 Comm: shmem_aligned_s Not tainted=
 6.14.0-rc3-mm-everything-2024-01-29-07-19-no-mglru+ #49
[   37.602267] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-debian-1.16.3-2 04/01/2014
[   37.603557] RIP: 0010:find_lock_entries+0x352/0x360
[   37.604269] Code: 44 24 10 48 8b 4c 24 18 eb b5 48 c7 c6 08 bb 99 82 4c =
89 ff e8 cf e6 03 00 0f 0b 48 c7 c6 70 a3 9c 82 4c 89 ff e8 be e6 03 00 <0f=
> 0b e8 a7 69 ca 00 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 9
0
[   37.606838] RSP: 0018:ffffc900029bba68 EFLAGS: 00010246
[   37.607566] RAX: 000000000000004a RBX: fffffffffffffffe RCX: 00000000000=
00000
[   37.608550] RDX: 0000000000000000 RSI: ffff8882b5d1d900 RDI: ffff8882b5d=
1d900
[   37.609580] RBP: ffffc900029bba88 R08: 00000000ffffdfff R09: ffffffff82d=
238c8
[   37.610566] R10: ffffffff82c73920 R11: 6d75642065676170 R12: ffffc900029=
bbb48
[   37.611551] R13: ffffc900029bbc48 R14: ffff88817951cd68 R15: ffffea0005a=
50800
[   37.612535] FS:  00007f40107cc740(0000) GS:ffff8882b5d00000(0000) knlGS:=
0000000000000000
[   37.613683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.614483] CR2: 00007f40107bf000 CR3: 0000000101c00004 CR4: 00000000003=
70ef0
[   37.615472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   37.616459] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   37.617481] Call Trace:
[   37.617838]  <TASK>
[   37.618183]  ? __die_body.cold+0x19/0x26
[   37.618746]  ? die+0x2a/0x50
[   37.619150]  ? do_trap+0xc6/0x110
[   37.619610]  ? do_error_trap+0x6a/0x90
[   37.620126]  ? find_lock_entries+0x352/0x360
[   37.620711]  ? exc_invalid_op+0x4c/0x60
[   37.621354]  ? find_lock_entries+0x352/0x360
[   37.622075]  ? asm_exc_invalid_op+0x16/0x20
[   37.622647]  ? find_lock_entries+0x352/0x360
[   37.623268]  ? find_lock_entries+0x352/0x360
[   37.623946]  shmem_undo_range+0xf8/0x6a0
[   37.624547]  shmem_evict_inode+0x117/0x2b0
[   37.625145]  evict+0x10b/0x290
[   37.625607]  ? fsnotify_grab_connector+0x42/0x80
[   37.626257]  ? fsnotify_destroy_marks+0x26/0x1a0
[   37.626903]  ? do_raw_spin_unlock+0x49/0xb0
[   37.627489]  __dentry_kill+0x71/0x1a0
[   37.628009]  dput+0xf8/0x1c0
[   37.628427]  __fput+0x143/0x2b0
[   37.628877]  task_work_run+0x58/0xa0
[   37.629428]  syscall_exit_to_user_mode+0x168/0x170
[   37.630099]  do_syscall_64+0x57/0x110
[   37.630619]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   37.631324] RIP: 0033:0x7f40108dc1f7
[   37.631844] Code: 73 01 c3 48 8b 0d 29 9c 0d 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f9 9b 0d 00 f7 d8 64 89 01 4
8
[   37.634424] RSP: 002b:00007ffcad4bd468 EFLAGS: 00000202 ORIG_RAX: 000000=
000000000b
[   37.635466] RAX: 0000000000000000 RBX: 00007ffcad4bd598 RCX: 00007f40108=
dc1f7
[   37.636450] RDX: 0000000008000000 RSI: 0000000008000000 RDI: 00007f40087=
c0000
[   37.637477] RBP: 00007ffcad4bd480 R08: 0000000000000064 R09: 00000000fff=
ffffd
[   37.638460] R10: 0000000000000003 R11: 0000000000000202 R12: 00000000000=
00000
[   37.639442] R13: 00007ffcad4bd5a8 R14: 00007f4010a10000 R15: 000055694d9=
23dd8
[   37.640422]  </TASK>
[   37.640750] Modules linked in:
[   37.641249] ---[ end trace 0000000000000000 ]---


Best Regards,
Yan, Zi

