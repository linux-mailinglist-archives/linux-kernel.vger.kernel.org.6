Return-Path: <linux-kernel+bounces-399543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6FF9C0063
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E8E1F216FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2491D79B4;
	Thu,  7 Nov 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OUeKtEap"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDEFBF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969294; cv=fail; b=UvHUoacFiqBWiA9RPVDmk22JTq6sUWtAwiKZg9CsYk0OboKaMGAz58ALbz53DO9wFNBJN7k5KK9PDAqy0ZW7CeRy5Fcxca9PKGyyAXJW/T1knW3L4kSZm/ZozHXMjxAZbPGh2wU47mbyUSOExwlQf6qghnuM51+0uVecLa4pIEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969294; c=relaxed/simple;
	bh=kZr2H4zHEE0GKHIKlPuGPVD1hLxN7/Acni7cSgRAsUE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BCwMJ+2zvrPn460yiAMlva9OfJ7lUwDGW0ETz8wbyOFmq/X7TQvJ6rZta2VIddlf4jjWgcSc96KycG97OMJPAFwFnmMcSg6cN70PSrfdctkNVpSZ3TjV2/UWUUj783RfqK0c1xQRRdX0M5DK4X08np1Y6APtMyOBeDgw/1qZSpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OUeKtEap; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8BjvNGtQbLrAZhDtpCp8Fn3sI+7icreFpfKGWqbRZLUuyq6dymWxuihmRTRWztDBCIeQvQETRpQFZzy9PexGSdsepBBA4VJd8y/DvakVpJtfS2qiD0pf/3iaAXSwQa99twXbZnmKmWflJjT2rZJV+vfh18gOCZeek0Ri3tlANEqag5cuFPgdiAp1lWcdF3fFWDafeEqE84BN9oKRC7R5XloYcbWTCxAkqSEMgsgpznv1NV6eRvuLaQxUMiboKMIWHDdX+6GINUTSv3h27i4BeE1k/HWpe/fnteY+cRgyMykCmNqbIMxtotJOGrS85tihk7w4SV2T51zVhhZ8nY5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbNaF8VUI2Lc+G0/tPNQFi7mhtR13zI6BkIdI+dbYRc=;
 b=IVlV4yOzt2mkF/5h+185ARGnED5xD6vQxFQn584KlrIDOLrF9yaY4ZN1BKDHTn/aXny5XwZtvVtAQ+77+j7LP7gHczRY7CyzaWtKIYv0OsJodnCzmoGFPlhs0NyXrZA2GAlTCQv4JvMcI17ZSqOEzKKSk2JqwiLUaYrHgPzbrYZ9eKfKJc5hbza9WbSxIsGpuLiK1jcfn9V/Au8KLad4dGgX8e585DcvNBb39G4yyl9cw56Blu0g5Cgrbl3PcWGUu5/HmIfwf6tkkQwFBrN+8pzB1OB4LZ5Skpv05ZFQxMGQu4UZuX+MveQwY5J37hxpuvnhdOM+R2fx/xRQOBSu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbNaF8VUI2Lc+G0/tPNQFi7mhtR13zI6BkIdI+dbYRc=;
 b=OUeKtEapreEwaJ2/H4F7AruQVVOfKuUvuYWXQIztt4x0FV0p5DNzOO0ei3IwOq6t6E5LC8jyBUROQCynJfwGZpcO+yE9M57ZpGQ2lYMzezeH74qKm+hExc42H2DQAjjSlIR/anBBbzKmB81JjO8r/xACSzxLfzH6TF/hBjgkVoRrDqQEP2u0NXjkXBw/pvArJvvs7FXmcAm00uM+X6PEzQJZx2Iz3lQ9rm1+NZASk+iYG2h7d2uKJZw5jHudfk6Lrymsm/a+s7sifJQwK1DNUe1lpyw+KzrHjv7yRtr516E12qA06Yhms/KT+/NFF8zIO+Sh5iPAIBWFKOKdB2zy8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Thu, 7 Nov 2024 08:48:10 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 08:48:10 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA optimizations when domains overlap
Date: Thu,  7 Nov 2024 09:48:03 +0100
Message-ID: <20241107084805.120265-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b604aaa-cf78-4054-29d9-08dcff08e7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDljbEJPNlhCMG0rSjNObDQwWHZjTDNYdzFOdVdoWTNWayt5NFFNVG01bThD?=
 =?utf-8?B?a2pUalllTlNlVFhUYmtOMUhEN2IwcE5Xcm5JK04vTUtzeVZEdnJzSjhTMll0?=
 =?utf-8?B?bjZrNnB0bE9WblpkZmZrVEd2T1ZXQWgxMEhvenVWVlM0RTlMeWJwQ0NETGg2?=
 =?utf-8?B?dk1jcGNsYVlaRmpEcTM1YnhVQmw0enhtRGhxK0JqaTByNTlqNlVhSjQwU1E3?=
 =?utf-8?B?NDF1clMvK0JZcGM0bU81MGE0bHJkQVRqbXJqck5Ed043TExOZFNLdGZDRjkx?=
 =?utf-8?B?aVZ2cWkrZXpUYzA5ZFFFbSs3U25nV1FQL1FvVTB2ODlJNEpFdmFwMzRRWGpz?=
 =?utf-8?B?WlJoRzZ6ZVhvLzNHbXJxcXViM1pRR0FIVExlZjY3d2lWQ3NQUm9XNkJ5RWVi?=
 =?utf-8?B?alhYVXNTbTNXSGcxd2RVc05GcGFZRUVSa3hwcGxMa1NmTlFDVG9GWjBSSFFo?=
 =?utf-8?B?S1RoNU5jQ1JFWDRJeFF6S2I2SzhyOG4za3VDRHRyWFFUK2p3bDhHbXVJR0Vn?=
 =?utf-8?B?dmV1d1BaTG1ONXNleWg3RlNNY1ZBRlgvby9tbUc1OGlMNkZXd0RhdVdYWWY4?=
 =?utf-8?B?bGFGbFFFbDdDUWpMbHdYRXhLSFJWYUlNVE9tZzFmcGNBZEFuZzlBQjRFckQw?=
 =?utf-8?B?UlNFTUZPbmtiZFhUTzNwNlA3VlVVaHB6SC9yUUh0Z005MEk4TWdoY2NiWTZi?=
 =?utf-8?B?VWZNQzYxSDlaMlZCeHJuSFZxMVZoaEFrYWVzSEJSQi9WQTJCdExLN0hPU0tL?=
 =?utf-8?B?M0UxWUdvWThpa1dSaTIrZVdsdGxOL1U3OXlydTcyQU5IOGJSV0IwVU8vcStI?=
 =?utf-8?B?Q0NiTEFjejBseityMk03S1pwemdvZzZGNVBrZVJzMXBMemRyZGUwRFhCMVZO?=
 =?utf-8?B?WnliKzlxL2xQTmxyUmgzQXo1cW9wWUFDYkxpMlNNQkJBWjNmYWVwcU5Ubjlv?=
 =?utf-8?B?U1ZUSlVxTU8vYVFSeEZYeWxkcHpNSUJNOUhNWlRpOXFNS1JTczhhQUVwb09N?=
 =?utf-8?B?aTFiK2hSL2RNbUZNQzBRRE9OZnNPSlhRR2VGWXQxVjkrUk84dU93L0tza3Qv?=
 =?utf-8?B?UW8rNVhBd1JzTWFqdGhkS21lR1BpcnQ2NmlUanhZMFN3ZFBMblRhVGczRjMv?=
 =?utf-8?B?VHVJajVGNGRnSmtzdmJibjh6ZGo4K2cxKzlLTndhNXp5VnNIQ0Vsc0Q3SFkz?=
 =?utf-8?B?QWtXMGtkbnVkUytlQjdvRjJyaHhSZDZIaTNZZlpMaHlML2lGYkJJVzQydGl2?=
 =?utf-8?B?eUExaDE4SzliMDU0OWR3akJFa3JYMG1CdkhuQ3BmUXJhVktPRUdsZDhZTndB?=
 =?utf-8?B?YU1aY3Y0MnIyeEJ2TUtmRGsrUDFCaFIzSWFSSmhoVERSNGxlbGxpUFNDR1l6?=
 =?utf-8?B?emJ6ZXp2bVdYYnBzVE1oMXhyclFvVnArZThpMzVDMTFWTjBBSEZzVGRJSjRi?=
 =?utf-8?B?RzZEUXljOU1DS0F4c1kzNHJvTXViNDBVY0o3OVpNNnNZVVlHTjh5VVViL2tV?=
 =?utf-8?B?K3NUNHEzaTd3SGhNL04vSG1kSWZhYURzYVRZeHZUU0xHNkEwY3JJRENTYlNC?=
 =?utf-8?B?L2g2RWkwWE9YdnA1a1ZRbEgzZ3hyR2JXMkN3L2ZoVlI4SHJwRnpJdGc5Sko2?=
 =?utf-8?B?WkVwQWJXaUVTUjM5bW8wU1ZYZEt0VTJuVmJxV0VpRDNtaFdzVFgvNWhvNGFk?=
 =?utf-8?B?ank4cnVRWFZPanNiRnkrTC8rcDdsNnF6ZjVqUkN5VmFxTEo3cHVWc3BUdllK?=
 =?utf-8?Q?58t8NZBM+FdxoudU7iP2Z/AF/ewnwOxJwS8cFNo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVEclgvakdMSEt5OFJVbDFLNzgycFpuM3AwTUN5ZzZsMXN5dWpUSkJuOUZP?=
 =?utf-8?B?K0NMaXZqZ2FDcVFrbzRGSDJPZk5GK2JpMkxVVmZQRWE3eDNCQ1hsNm9TQ3FE?=
 =?utf-8?B?bW5BUkFrYmdQVzdmQnFHTHh6YitQbzJlamR3QkpKSWdCbWJZQWNYeW1zZEJI?=
 =?utf-8?B?cE9ua0pwa29waUlkdE1hNCtRNjNTdFIrZ0djQ091SjlOVkoxWUhZbyt1dkx6?=
 =?utf-8?B?bE9TbWpoRzM0VTdTekNJU25wc1J6R3o4cXNRMTN6bmNHdDZ5UlluWjZPREJv?=
 =?utf-8?B?MzY3c1pmRGJDbWo0Nzh0anZML0JFaXpBaXQwakZLKzRsb1V6cjV2cEJQOWt4?=
 =?utf-8?B?M1MvUVdodkFqOU55a0FqQ0RpTzI4NG5SWEJ5RWpJcUk3V0xqcklpM2d3ZDhL?=
 =?utf-8?B?Slh6dGx2MWJLQVVaNW5Za2RSSGR4RStmQzdLQzNBSitVeFlYSkZ1K2ZiMW85?=
 =?utf-8?B?YUs4ejRkSldFNEdZTlNkYnZaeUVPL3dIbmVQVWY0ejVualdzSHZybFRMZDNS?=
 =?utf-8?B?VWUyZ0tTRXRhVUxlUVU2QUxmZTBqaXBONGdnbXlEYng0Q2VVamJUSWpEKzkv?=
 =?utf-8?B?ajNjOGFQOENmRFU1M2o3RGJidEhDblZqZ3JDWG1LQVFaTE5EcmJQLzF1QllF?=
 =?utf-8?B?Z3IxTGJrMG96MkVmdGFtdXhXdktTYUllMnVQK0YyVGZya21HNXpTSHgrcHd4?=
 =?utf-8?B?dUM5K1hUU0wzQVZpaS9RVTlmelpTWG9IMjRyQXVoS0s5aGtrbzdaaFdaaXNO?=
 =?utf-8?B?NFExR0pFVkt3K2EyNkkwMWdKdUM1WFV2ZVFYcWw3MklhaS9WY2dMc2FBY2xx?=
 =?utf-8?B?cm1hRU9zYWdQVjgrNzJBM2xySGxtbjN1SWk0eUVNNU90UGFVMVdPeUROOFoz?=
 =?utf-8?B?MmxmQ3J5T2t3c09obnVkV2hhYXNwWS9YeU9QWU4yT1ptUFpVNlpHL3FCTDZk?=
 =?utf-8?B?WDRKYUR1eXJuemRxUy9wODNUODRlSkJPR2Q1QlNhYUtZRjRTRlBwVW5uSUdN?=
 =?utf-8?B?QUlwODFPMjZpaFdQdWFQdVFacDhYNk1yM0N4dS9UVHd4OUI4cktOL3JOdXkv?=
 =?utf-8?B?REE3QmR3d0VCOGJZZzJ3N0JScy92RVc1T3dvUVdZYjIyVStKY0ZScDc3WHpj?=
 =?utf-8?B?TjhXL25LcDNTa0tkNG5vU2VBYVI0VUt1VTBDcGQ5U2ZUR2V5Z1RzSnVKZVBq?=
 =?utf-8?B?SDAyWjl3OVN0TE4xdThFclEyVDBvZE5pdTlRaDM0NEJiWEhPZ1U5TGl4Vkh2?=
 =?utf-8?B?Wmd4L3k0dFI0Ny90bTNYUEVmSnRpbis2dGxacEsremJXVHRFUEVVazFQQmFU?=
 =?utf-8?B?VXZOVHRvVE11N2ordEdaUjk2SFpwZlN5Ymhsa2VFeURCUmJxc1luUTZiSDBK?=
 =?utf-8?B?R052Z3ZBQWpUVHBLbXBwekdqQUowWVhYenF4dnJuMDhzYWpBa2U0b3Z3Lzl4?=
 =?utf-8?B?LzJYZUNZbENUbG1CTE9EMUZ0SWJQblRtQ2xSVzM4QUw5MTNKYWZFOFFUS1N3?=
 =?utf-8?B?c1dIcXV2WGV1ckwvWnJvU0RxbUt2cjIxOW04RzF4WFpUTTIzdDErcjlKUHll?=
 =?utf-8?B?bkowZEQ5T2hHZEFwTGEzZkorcUM2N01TSUoybkRwMnZtZm15eGFmYUJmUDhq?=
 =?utf-8?B?VERpOEpWNHhkNS92R2JZQmZ6TXhFazhwc2YvQzJNTTh2K0RYcVUycXpFOEZG?=
 =?utf-8?B?VVRrZVRSQ3MwRFRhN2l6YTkxTHoyN1RJY3FIVVJFTEhwbEZVc3l0eWJRNk4x?=
 =?utf-8?B?dHZ3KzI1cURFVk5Wd1Qzc0d1b05kbnZRMlVWbk5hekJRbWpXZXFVV2NzUTlx?=
 =?utf-8?B?WFV4VlVINXNwS3R3bERYbWw0Uko2MytnM3MzMXdGWVFuNnhCalg1S3RmMWFa?=
 =?utf-8?B?bkYrYVFaRjN2MHlFT1c5dWoyZnU3b3hDTlpqTHEwa05hSlRjMFZtWkU4Ynpz?=
 =?utf-8?B?MXZrYTRRQVA0T1ZEMmdSbCtxSzVndVRYQ1NQN3lMNEhTMEJUM1pFNzRlNzlj?=
 =?utf-8?B?ZVdxU3R5aFRtT2M4QUo3WmFpbXhxNlFaNUdsVXZmdWZxa1d6cFJseHRvcW8z?=
 =?utf-8?B?Q1JQK05iYU5UaWIzcmNlT1RSeHdoOXA0bVl5NEFsL09sSkFjMXIvaXY3Skk2?=
 =?utf-8?Q?rDzLYYiEL+ahN+RlVrQRkbypI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b604aaa-cf78-4054-29d9-08dcff08e7f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:48:10.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SqEO+wBrpVGfLsbPWvMJSYkpshv8m51pWvOCbklaZDv3a6By2PevzcWp6EIg5eNWSpo3MYxlfR/YrkJPDaDTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

When the LLC and NUMA domains fully overlap, enabling both optimizations
in the built-in idle CPU selection policy is redundant, as it leads to
searching for an idle CPU within the same domain twice.

Likewise, if all online CPUs are within a single LLC domain, LLC
optimization is unnecessary.

Therefore, detect overlapping domains and enable topology optimizations
only when necessary.

Moreover, rely on the online CPUs for this detection logic, instead of
using the possible CPUs.

Fixes: 860a45219bce ("sched_ext: Introduce NUMA awareness to the default idle selection policy")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 92 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 7 deletions(-)

ChangeLog v1 -> v2:
  - rely on the online CPUs, instead of the possible CPUs
  - handle asymmetric NUMA configurations (which may arise from CPU
    hotplugging or virtualization)
  - add more comments to clarify the possible LLC/NUMA scenarios

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fc7f15eefe54..a51847f79d01 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3129,12 +3129,77 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Return true if the LLC domains do not perfectly overlap with the NUMA
+ * domains, false otherwise.
+ */
+static bool llc_and_numa_mismatch(void)
+{
+	struct sched_domain *sd;
+	int cpu;
+
+	/*
+	 * We need to scan all online CPUs to verify whether their scheduling
+	 * domains overlap.
+	 *
+	 * While it is rare to encounter architectures with asymmetric NUMA
+	 * topologies, CPU hotplugging or virtualized environments can result
+	 * in asymmetric configurations.
+	 *
+	 * For example:
+	 *
+	 *  NUMA 0:
+	 *    - LLC 0: cpu0..cpu7
+	 *    - LLC 1: cpu8..cpu15 [offline]
+	 *
+	 *  NUMA 1:
+	 *    - LLC 0: cpu16..cpu23
+	 *    - LLC 1: cpu24..cpu31
+	 *
+	 * In this case, if we only check the first online CPU (cpu0), we might
+	 * incorrectly assume that the LLC and NUMA domains are fully
+	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
+	 * domains).
+	 */
+	for_each_online_cpu(cpu) {
+		sd = cpu_rq(cpu)->sd;
+
+		while (sd) {
+			bool is_llc = sd->flags & SD_SHARE_LLC;
+			bool is_numa = sd->flags & SD_NUMA;
+
+			if (is_llc != is_numa)
+				return true;
+
+			sd = sd->parent;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Initialize topology-aware scheduling.
  *
  * Detect if the system has multiple LLC or multiple NUMA domains and enable
  * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
  * selection policy.
+ *
+ * Assumption: under normal circumstances we can assume that each CPU belongs
+ * to a single NUMA domain and a single LLC domain.
+ *
+ * However, in complex or highly specialized systems (e.g., multi-socket,
+ * chiplet-based, or virtualized systems), the relationship between NUMA and
+ * LLC domains can become more intricate, though each CPU is still considered
+ * to belong to a single NUMA and LLC domain in the kernel's internal
+ * representation.
+ *
+ * Another assumption is that each LLC domain is always fully contained within
+ * a single NUMA domain. In reality, in chiplet-based or virtualized systems,
+ * LLC domains may logically span multiple NUMA nodes. However, the kernel’s
+ * internal topology representation does not account for this, so this logic is
+ * also making the assumption that each LLC domain is always fully contained
+ * inside a single NUMA domain.
  */
 static void update_selcpu_topology(void)
 {
@@ -3144,24 +3209,37 @@ static void update_selcpu_topology(void)
 	s32 cpu = cpumask_first(cpu_online_mask);
 
 	/*
-	 * We only need to check the NUMA node and LLC domain of the first
-	 * available CPU to determine if they cover all CPUs.
+	 * Enable LLC domain optimization only when there are multiple LLC
+	 * domains among the online CPUs. If all online CPUs are part of a
+	 * single LLC domain, the idle CPU selection logic can choose any
+	 * online CPU without bias.
 	 *
-	 * If all CPUs belong to the same NUMA node or share the same LLC
-	 * domain, enabling NUMA or LLC optimizations is unnecessary.
-	 * Otherwise, these optimizations can be enabled.
+	 * Note that it is sufficient to check the LLC domain of the first
+	 * online CPU to determine whether a single LLC domain includes all
+	 * CPUs.
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_llc, cpu));
 	if (sd) {
 		cpus = sched_domain_span(sd);
-		if (cpumask_weight(cpus) < num_possible_cpus())
+		if (cpumask_weight(cpus) < num_online_cpus())
 			enable_llc = true;
 	}
+
+	/*
+	 * Enable NUMA optimization only when there are multiple NUMA domains
+	 * among the online CPUs and the NUMA domains don't perfectly overlaps
+	 * with the LLC domains.
+	 *
+	 * If all CPUs belong to the same NUMA node and the same LLC domain,
+	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
+	 * for an idle CPU in the same domain twice is redundant.
+	 */
 	sd = highest_flag_domain(cpu, SD_NUMA);
 	if (sd) {
 		cpus = sched_group_span(sd->groups);
-		if (cpumask_weight(cpus) < num_possible_cpus())
+		if ((cpumask_weight(cpus) < num_online_cpus()) &&
+		    llc_and_numa_mismatch())
 			enable_numa = true;
 	}
 	rcu_read_unlock();
-- 
2.47.0


