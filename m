Return-Path: <linux-kernel+bounces-538799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B7A49D34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E9E188F33A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002925D1F6;
	Fri, 28 Feb 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4GTV+l8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C51EF385
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755953; cv=fail; b=MHC1HnQHqgg4VHWX/Do6yG5eooPCSAeYKgsyTm1r1+ao0QwH9ckZca0eSi5SPJsEB2v3qyUIIxS863dY79oMh4fqD35EfGPnNk9BgH+rXCGMBSv28QyW5u8YxiTLYwkoutRbvvzYHQMdoVepwjC5Q4NXVmDQX40dVu0mZxt56Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755953; c=relaxed/simple;
	bh=mgCWDLjL6qiONJeV60nD+FYLNRvOb3zOoQIQAVzGvUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfwLtHmAh78Kq/zTpuZQINu0YbpM7SZSTb8NbeJAhlJTujqGpuIkqVIdOAO9y5fkSAJaiJPIb4VpHphnKYAuEP660fBY+GEbn4oD8up7xCn25Nk6sBGuvgalRVVmHqknWKHHFpnA3k87puHu22p2y1/OdLDnZrUlTkYp0ZXU2Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4GTV+l8; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+4w9NeVkk+MUHAB47emFNObGWcHh+1l0XAOqQZ5YTJMdz0/+LPRr4osGBBHMXR3FeCCwymGk93SVeM/ufO3Pmn6Y4QPrGdU1nqHmu6gkttsEeCmVGzW85fsN2kA+dIBkLIM5DjRI2jUnYCwix2bVh5TG2k+5lSmx++SLVpVE9Ffs3nJzktnaqfYi/cEcz+0obQU2YcnFaSXsjTGdWIssUTBdsAr6RqJioPpwo0BiOFfTLt18yNb+3ztZhwbfnWRQ7fUDQSih93gdvdhT+LEB5cXRsM3GMcia1Sg2E96FlRC1apd1y1J7F1NsOrfeoQelcgZ+sAP/lyZqch47QRhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmdufBo3WZxihXaIMqmnwVdG4Rlv2pCydJ+5pmqvgjg=;
 b=Fr5QWCyaRFPcGY46T24DyKd6cx/yr8Ey6+DzYXUAi5ZHV0P2gHb06F27v8uw13eFqb1k8s7FfAhpnKl0G23Tb3Ll0ydA4ipI4E1t4Gsnh8Ku9SGQjD03ESrQKyLQHhQfe6ac85XzNkNvJR3Z7wUqUwdbv89/xZ8WE/FU7DZbx3I7fppsMPFdgYlPb+GjaLoCZWT0pehwM04bh9Jd2HlvP61T/cHDjV/yz7B9av7jU0XQZTqF9n+exFx5Pr4PufVo+7Cs/rpxXMrWc4U7OeLlR+CtuUV3iml7/b76/XaWXLDyOdi+V/VU6AsI5t5eBOQFt5RIPaM2pMVxPFNnCYcbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmdufBo3WZxihXaIMqmnwVdG4Rlv2pCydJ+5pmqvgjg=;
 b=K4GTV+l8upZ2OlksLWlrxe+5IeXvibpiYYwy6yEnX6I28H2fW+rtWHsueJ0XTpa34qQyYotaiciprrjt8oXtleSZBYBlaAOBBn5xs0wqIUeQ1m2qCmhZfk9UymzF0Uqgb2UmyJf85oFUKkrv2PpHJ0kSzNoXEAJeFpIDaQtUaIi23+V9d+7Fy+oawWJYDuxuj5hfFDp5iqK5WzJ5X66hqfTuGmqD3TjH367fimS2XqAuPZXRS3IPkOrg2pTbGy1qKgNdoH6AmSmUCembODoIIhahqVg4kHpL4/dV2GiCkBf8J2va46CutxRzVRWJBMDHgs+59QFc0XbKfqZykANShg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 15:19:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:19:08 +0000
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
Date: Fri, 28 Feb 2025 10:19:06 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <7D7BD404-83A5-4ADA-9527-74BF929246AA@nvidia.com>
In-Reply-To: <7367bb73-3358-4925-ac9d-e2b90904d15a@linux.alibaba.com>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
 <acbfc1da-f743-b11b-191c-ce6e476f1709@huawei.com>
 <696E1819-D7E3-42BD-B3F0-8B3AC67A8ADB@nvidia.com>
 <7367bb73-3358-4925-ac9d-e2b90904d15a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbb3efd-6055-4268-94ca-08dd580b3f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlRwR1VLeGZlV2o4T1J6Ry9WWitNRU0ybk4xMkxEMllPWlNzREh5WHRUSVBU?=
 =?utf-8?B?UFZFa0d1cW9OTEVJc1dKdEpaaXRlZEdDWnYvQ25uY3BoaWZCOGdQQlZsRHhM?=
 =?utf-8?B?amJwSzRMVWVqVS9OL2hUbGlUZ1RzbmRPR0NUYXRHM0t0YWluNWhrR1lnMCtO?=
 =?utf-8?B?YWxRYzFGcU9Bekltdi9rVHNpeHFaZjZvaDB4cDRwaWNJdkl5L2Jzb3RLOUgz?=
 =?utf-8?B?M3h5Qy9XeFoyRGhSQ3lRNEhsVEVBcVI0djZ4Z1FWYW4zN2ZRNkVyRFlXbVVD?=
 =?utf-8?B?QWt1bTR0Tlk1eVNTVVpHd2V2cTdjLzluaU5zS0RzUXVuSGlDclZYc1ZyRGc1?=
 =?utf-8?B?N01Mc21vcUtTaHVsM1pGVm81b3Z1L3RHaFdsT0dIY2hhQW42bDZEa3AyVWx6?=
 =?utf-8?B?Sk50QXppRjBGTG9STHBpVFhhMjdIdXZSL0JDVDcwZDErdFZCZzhldTg1NG5z?=
 =?utf-8?B?Q0NZMG1sWk9NTWlEVXVqaTkvZjR1R3paYVBNTkM0aWxYZEZLM05DQjdGdTdJ?=
 =?utf-8?B?TUxxVUtMVmJ6bVk0V3NUeGVuQndBYmRCWS9mVEc0NHptcEdYckdFUEZlUFhB?=
 =?utf-8?B?NjM5alFCTVV5QkZCM3RxYlk4QUxyWER1LzJ5NTRmbjFNRkQ2OEw0cE16alhy?=
 =?utf-8?B?K21KOGxPbHZZeFIzYWxwM1d3UW5ua2Rybyt4UlBqb3FkVWJ2eitNVDVxaVZt?=
 =?utf-8?B?eVlwQUY0aU45enVCZ0ZVcVlpQzBzakFCN2VRQTQzNWpSdUwyM1FpSzUyMjho?=
 =?utf-8?B?akx1dHZ2ZER5Z0V3cnVTbzduWFlYckw4M28xT29xYzFhL2lncDRSOERpMUxR?=
 =?utf-8?B?aDl3L1JGZExqdU9HL05EalQ0UTMzc3g2ZFZZdHN3RjhieEZGV0E2Z3lOa0NV?=
 =?utf-8?B?UVcvR05UTHk4S1hOK2lpcjg2OGlyTWF6aVJGb1Q3NVFlVnlFeWdsQ1doUEh1?=
 =?utf-8?B?M04rWmMwRXI4cWExVmo0VWo2RGI2RzNuZUJQTUlMaCtVN0RMYlkwSVZwZnlZ?=
 =?utf-8?B?UlByZys2Rktra1dyVERFN0RkdVJCSVJLaTc0Y1dNUWR5ZDFtS3p4b0VTZVNJ?=
 =?utf-8?B?YmxGK2MwaHIzdHBvb3dVZWZ0REhQREZBRDgxVkxZNmhiMWdhelR2MjkwUTJ5?=
 =?utf-8?B?SDhJeHNFdzZNVFlvaVRjOGhpVnlLMngvVDI4N014ckdnODZaeFY3Szk4UTUv?=
 =?utf-8?B?OS85cHFadnBheXUvRjUzMUhXSnNNQUNQcGhkZjYvZzZBdUZZOXdGQXFYQXA4?=
 =?utf-8?B?WDBTMmREMzZDRjNFdmk3b1JHcGJHc3ZjeldtWjdod092d3dRaThNM1JrTzRN?=
 =?utf-8?B?ZHl6cENFblN6T1Z2d1NQQVNGYUxUQjh6dmZEM3hyblRjUjNwRC9wOWwvOStn?=
 =?utf-8?B?STREa1lFeVg5TTNyK1Zab1FocTY2cVhVSTFhOWxYMmgzQUd6c2pOS0pyNXYv?=
 =?utf-8?B?ZjF4Q3drOVUvZmJ3eE40YngyWEZmKzZsanlNblF5dE9GK3ZobElUSDRhMnI3?=
 =?utf-8?B?UENNeExDdGN0citIVTg2eHVmU1lDRDY1TlBsRDVJeUFyZWVIaWpROGw2OStR?=
 =?utf-8?B?NmRQNm1Xak90YmRtZEtuc3lmRkJ5bE16dTlJNElRWHpiWlBiMHA0V3NmZzFN?=
 =?utf-8?B?YU56dkplTWhkc1ZrbVBSemJBMEhvb2N0QXFZaitaL0d0UlFuVHRCRE5GVk5N?=
 =?utf-8?B?ellFSVgyK1AyRi9aZGdzcHAyY0pyRDdybjIxVXdOUy9EOEo2bFhGakQ5WlNU?=
 =?utf-8?B?Nm5hVHJveXl5U2k4RDBWdE9NVkJ5NU1Rd3NjYWgzSnpCcGU1L0hYTStDd3Ex?=
 =?utf-8?B?eGdLL3RIaGcvREZSWlZCQjBjaE9VUWI2MU1PSFA1UkFqaGtDNVVobHJ3V2pT?=
 =?utf-8?Q?OQV9J0evSEact?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmkzaVVHQzdTZllHYk1vYTQwMFJyWU40L1Z2SU44MkI5d0E5cjJxc0N0SjRD?=
 =?utf-8?B?YmxaeGpoNWdDRzVwdllrTk9KQ2tDaXQ3VWJ0a0VrVzJqSkRGdEVwYTgxY0Vk?=
 =?utf-8?B?OTJCRDcrb2lTTE5FRUFGVlRGKzVwYm5yOUNDbGlZa0lDbHhNcTVwaHJEU0hG?=
 =?utf-8?B?SitxMFpZTGRPU1ZFY05veXRrdjJNb05NanpsWTNpQTRSdVc1SUJTdDBkWU43?=
 =?utf-8?B?ckNCZCtkbmhPRTJtbFBBR21iUXhJS2VLNUZyNnpucUxDZ0QrbzNKNkIyUzZa?=
 =?utf-8?B?diswbWtERVdWZU9ZUEwrdzNDZzh6M1orZmtpREJWSzgvWVI1TUc1eTJvclhJ?=
 =?utf-8?B?bWdwb1hpRVE0dlA2aXN3b1lpZG0rNE5jUVFUQ1Z5WE43T1pnY3IyKzNGMWVl?=
 =?utf-8?B?UndXZnd3dlpsNDJ3R1lLenVoMmw0MVRqYlFSMGVHUVIraFZHTnNYR2U1TXl1?=
 =?utf-8?B?amZDeW5yQ2VoYVFLRFRzOWVZeWFEMk5TVCtSZmxxU1ZYMksyYWRmc2kycWhr?=
 =?utf-8?B?c1NmQWsva1oxUXBQTGZocGlnYWJiMlg4Y0NDZ3k1KzVEMkVMYmJjVWxtanls?=
 =?utf-8?B?Z3N4M011N0l2S0RWWjdJNXptaUZnVlBkVmlsYVBncGQ5Z1FENDVHRlF6c25J?=
 =?utf-8?B?RW9FUE92WUpmM1YvWFpFV29uL01rM0hQaXNJczJMOXdCQkh2Rmx2NnlZYlpP?=
 =?utf-8?B?dnJxVjBwelR3YW1PeUJsUGhiZU4wSXFsQ3JwUzBnaktLZmQvQWtXYkRDMUF3?=
 =?utf-8?B?Z1RpSjY4dE1vVjRhL2hieFdpUVdnLzh1SGxKMVh5SU8rZURIeG5mOVNwRUNP?=
 =?utf-8?B?aFVESU9nR0loOXdPWklWSmFLY3NMaWxON3RRbzRhd1Y4NkV2MFBxcUFkZDJK?=
 =?utf-8?B?QVIwVkRPcWc3UUZXQjM4RWs4LzdJNXViR1lXRHcyWmRCNkJEd2JHSkxnUGxF?=
 =?utf-8?B?K2djd3oxWXBQWSswdzZBRFl1bnlLTU5DVTM5UzFWa05sUHZpNTNOMWlPZEhY?=
 =?utf-8?B?S2dINTROamNROVdiV1BPR2FMMzVTcGZocjFJcU5rb2VLSUh5c3VkY25oWHVR?=
 =?utf-8?B?bDIyeDZBeCs1enM2a2FqdnE3SEZjSUtkVlZUS3V4ZkNmbmpHeEdtRjY1SWxY?=
 =?utf-8?B?Y2E3MGt0N1pRdDRTa1lZZW43eE0vY2xMem9CL1BCaGxObkNxMGhSYUtmZUR6?=
 =?utf-8?B?OUcyd29oZ1F1VTN3WElETTZPY3RxOWh1ODM5c0t5T1E0bVA1RHJOUm5pcDlU?=
 =?utf-8?B?bkF5TlJ0anhGQndsUTcranV4TlovOXZRZGJsa2pVNVVEa05oV0l5eWlqSDVM?=
 =?utf-8?B?dFpIWWRZcUt2VTlEUlNnUkxlVzRHZE9iZEJuRnZpOXpnMlM5a2tQc2VlWUg3?=
 =?utf-8?B?ckM4a2s2cS91cEdIcElZVHJXZ3Z4cDVFZVVQekVLZFFqVkxnMW1rUmwvWTlQ?=
 =?utf-8?B?eUZwNUh3NUxGdm5pVmRaSGVEdTJGZ20zdHhTL05xc05yK1pyMHloNE81K2lw?=
 =?utf-8?B?TW5sNzlaWEN3U3YrZC96R2hBa1RHeGdjaVQrb3ZaajM1Zm9HTXNOYnk3ME1C?=
 =?utf-8?B?OXZTZEFveGhBUU1pcURYQ2twOHNqdlR0V1VZdERwMGlUZ3NvQVlEN1ZKK21C?=
 =?utf-8?B?WGJtYXhEeWFzeXFUWEFtTGozejB1WlNmdk85S09GTzRtV1JPV2MrZHBLQXc4?=
 =?utf-8?B?b0JZNlF6QXErQlBBcDNZSFRlbUdVT0xGa2pkYmZwbFFZZWphYkRJSU9QaEk4?=
 =?utf-8?B?TzBjT0pDTVB3SUNUSWVkZjZEejJYSTg5eVNoUkN2OHJRZTVoOW41cEtMZzJV?=
 =?utf-8?B?UXJnSjZYemlLYmlLN0haN1djanlkVXVtVGpheTU0WlBURzFtSDY0U21Tb1dk?=
 =?utf-8?B?N3I4cDhPVHpnZ0o5VDh6UUxuR1VxNXNkMGNEaGtuWVd4eEpJaUpiazdtUmVw?=
 =?utf-8?B?Wjc2TTV2OG8zbW55MEFXdldwdWpBR056UWJPdm9OSktFZDlaUUdLWE9BdFl6?=
 =?utf-8?B?VlMrVy9OWUxiVVNYRHlxbXNKMnJXOHJMQ0JLOWR6TXJCc240WllUTzd1UVdG?=
 =?utf-8?B?TjJ6QUJZT1ZyeU9DOFVGWVRtUGpHZTRwMk5FS3h6L29zOVl2NVJVcnUrU09n?=
 =?utf-8?Q?SlNcae3yIeOAuVRYDixcdtR0x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbb3efd-6055-4268-94ca-08dd580b3f39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:19:08.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU0KawC8ps4SEN4ruXEk+tdonVrejpCF+oo9a2QR8DPs+ZiipcgG8sUuH76zjZKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297

On 27 Feb 2025, at 22:39, Baolin Wang wrote:

> On 2025/2/28 07:43, Zi Yan wrote:
>> On 27 Feb 2025, at 2:04, Liu Shixin wrote:
>>
>>> On 2025/2/26 15:22, Baolin Wang wrote:
>>>> Add Zi.
>>>>
>>>> On 2025/2/26 15:03, Liu Shixin wrote:
>>>>> Hi all,
>>>>>
>>>>> I found a softlockup when testing shmem large folio swapout-swapin an=
d compaction:
>>>>>
>>>>>    watchdog: BUG: soft lockup - CPU#30 stuck for 179s! [folio_swap:47=
14]
>>>>>    Modules linked in: zram xt_MASQUERADE nf_conntrack_netlink nfnetli=
nk iptable_nat xt_addrtype iptable_filter ip_tantel_rapl_msr intel_rapl_com=
mon intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel =
kvm rapl cixt4 mbcache jbd2 sr_mod cdrom ata_generic ata_piix virtio_net ne=
t_failover ghash_clmulni_intel libata sha512_ssse3
>>>>>    CPU: 30 UID: 0 PID: 4714 Comm: folio_swap Kdump: loaded Tainted: G=
             L     6.14.0-rc4-next-20250225+ #2
>>>>>    Tainted: [L]=3DSOFTLOCKUP
>>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0=
-1ubuntu1.1 04/01/2014
>>>>>    RIP: 0010:xas_load+0x5d/0xc0
>>>>>    Code: 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 =
73 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d
>>>>>    RSP: 0000:ffffadf142f1ba60 EFLAGS: 00000293
>>>>>    RAX: ffffe524cc4f6700 RBX: ffffadf142f1ba90 RCX: 0000000000000000
>>>>>    RDX: 0000000000000011 RSI: ffff9a3e058acb68 RDI: ffffadf142f1ba90
>>>>>    RBP: fffffffffffffffe R08: ffffadf142f1bb50 R09: 0000000000000392
>>>>>    R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
>>>>>    R13: ffffadf142f1bb48 R14: ffff9a3e04e9c588 R15: 0000000000000000
>>>>>    FS:  00007fd957666740(0000) GS:ffff9a41ac0e5000(0000) knlGS:000000=
0000000000
>>>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>    CR2: 00007fd922860000 CR3: 000000025c360001 CR4: 0000000000772ef0
>>>>>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>    PKRU: 55555554
>>>>>    Call Trace:
>>>>>     <IRQ>
>>>>>     ? watchdog_timer_fn+0x1c9/0x250
>>>>>     ? __pfx_watchdog_timer_fn+0x10/0x10
>>>>>     ? __hrtimer_run_queues+0x10e/0x250
>>>>>     ? hrtimer_interrupt+0xfb/0x240
>>>>>     ? __sysvec_apic_timer_interrupt+0x4e/0xe0
>>>>>     ? sysvec_apic_timer_interrupt+0x68/0x90
>>>>>     </IRQ>
>>>>>     <TASK>
>>>>>     ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>     ? xas_load+0x5d/0xc0
>>>>>     xas_find+0x153/0x1a0
>>>>>     find_get_entries+0x73/0x280
>>>>>     shmem_undo_range+0x1fc/0x640
>>>>>     shmem_evict_inode+0x109/0x270
>>>>>     evict+0x107/0x240
>>>>>     ? fsnotify_destroy_marks+0x25/0x180
>>>>>     ? _atomic_dec_and_lock+0x35/0x50
>>>>>     __dentry_kill+0x71/0x190
>>>>>     dput+0xd1/0x190
>>>>>     __fput+0x128/0x2a0
>>>>>     task_work_run+0x57/0x90
>>>>>     syscall_exit_to_user_mode+0x1cb/0x1e0
>>>>>     do_syscall_64+0x67/0x170
>>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>    RIP: 0033:0x7fd95776eb8b
>>>>>
>>>>> If CONFIG_DEBUG_VM is enabled, we will meet VM_BUG_ON_FOLIO(!folio_te=
st_locked(folio)) in
>>>>> shmem_add_to_page_cache() too.  It seems that the problem is related =
to memory migration or
>>>>> compaction which is necessary for reproduction,  although without a c=
lear why.
>>>>>
>>>>> To reproduce the problem, we need firstly a zram device as swap backe=
nd, and then run the
>>>>> reproduction program. The reproduction program consists of three part=
s:
>>>>>    1. A process constantly changes the status of shmem large folio by=
 these interfaces:
>>>>>           /sys/kernel/mm/transparent_hugepage/hugepages-<size>/shmem_=
enabled
>>>>>    2. A process constantly echo 1 > /proc/sys/vm/compact_memory
>>>>>    3. A process constantly alloc/free/swapout/swapin shmem large foli=
os.
>>>>>
>>>>> I'm not sure whether the first process is necessary but the second an=
d third are. In addition,
>>>>> I tried hacking to modify compaction_alloc to return NULL, and the pr=
oblem disappeared,
>>>>> so I guess the problem is in migration.
>>>>>
>>>>> The problem is different with https://lore.kernel.org/all/1738717785.=
im3r5g2vxc.none@localhost/
>>>>> since I have confirmed this porblem still existed after merge the fix=
ed patch.
>>>>
>>>> Could you check if your version includes Zi's fix[1]? Not sure if it's=
 related to the shmem large folio split.
>>>>
>>>> [1] https://lore.kernel.org/all/AF487A7A-F685-485D-8D74-756C843D6F0A@n=
vidia.com/
>>>> .
>>>>
>>> Already include this patch when test.
>>
>> Hi Shixin,
>>
>> Can you try the diff below? It fixed my local repro.
>>
>> The issue is that after Baolin=E2=80=99s patch, shmem folios now use hig=
h-order
>> entry, so the migration code should not update multiple xarray slots.
>
> It is not after my patches. After converting shmem to use folio, shmem ma=
pping will store large order, but during swap, the shmem large folio will b=
e split (whereas my patches allow shmem large folio swap without splitting)=
.

Got it. Sorry for pointing the wrong source.

>
>> Hi Baolin,
>>
>> Is your patch affecting anonymous swapping out? If yes, we can remove
>
> No.
>
>> the for loop of updating xarray in __folio_migrate_mapping().
>
> I think the issue is introduced by commit fc346d0a70a1 ("mm: migrate high=
-order folios in swap cache correctly"), which did not handle shmem folio c=
orrectly.

I agree. What a mess. So right now only swap cache used by anonymous
memory does not use multi-index entry.

>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 365c6daa8d1b..be77932596b3 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -44,6 +44,7 @@
>>   #include <linux/sched/sysctl.h>
>>   #include <linux/memory-tiers.h>
>>   #include <linux/pagewalk.h>
>> +#include <linux/shmem_fs.h>
>>
>>   #include <asm/tlbflush.h>
>>
>> @@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
>>   			folio_set_swapcache(newfolio);
>>   			newfolio->private =3D folio_get_private(folio);
>>   		}
>> -		entries =3D nr;
>> +		/* shmem now uses high-order entry */
>> +		if (folio->mapping && shmem_mapping(folio->mapping))
>
> Nit: we've already checked the 'mapping', and we can simplify it to 'shme=
m_mapping(mapping)'.

Sure.
>
>> +			entries =3D 1;
>> +		else
>> +			entries =3D nr;
>>   	} else {
>>   		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>>   		entries =3D 1;
>
> Good catch. The fix look good to me. Thanks.

Thank you for checking the patch. I will send a proper one out.

Best Regards,
Yan, Zi

