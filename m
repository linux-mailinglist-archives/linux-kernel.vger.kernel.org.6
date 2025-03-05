Return-Path: <linux-kernel+bounces-547495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC4A50A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B23188874C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEA2517BA;
	Wed,  5 Mar 2025 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mWS/iDvH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51E2512D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200280; cv=fail; b=ucDOh8xS0h9iz/9kR3ZQSkzwS8ha9+IE6g8rmerrhw2aAyazM16zm/4nGJYE6ZuZvPfEjGWMTq7QivEQAJ2PA/wfpX1eODE9YTr7hvjvHt1oScatoNM2345eETpdJje+LdpF0R8XQvkoBgVTTeWleJaeTA0bpiar92YtaKvpUrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200280; c=relaxed/simple;
	bh=XKV+haeGowDKLFHB4/ShL9fDiwTh5ohB7l/8n6t5TWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0gD/WUNlq/x5Zvg0f4v7thQoPqFKb2qWQAA3bVd/gNBa8KPhHVda+4NwPfAFvvt9jTlrm6zlMcRmuRoP8TJmHzmtRDZkZwdrP/W6tCLCCYTTa0LgL4qDY+b74ahCCVa8eCRpnXi2HC/fbLnrzonINkXQW2em2e93r9H29PGm8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mWS/iDvH; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPKDadn8WqSoPDr+AUG/Y+z5WtbKSfNBZWbGZshOLBnJrb6UHXJxSCY47TAfL2HRbRMhQhXQhfv7tDEzzR1J8WgCaMhElwh8Xo5M5HI9wyLwonv50pb9x9m6+3l/kfV6SVeTvpRjl1zY4cT3Du8LubLnHdLEPiGfZpDp2uxppFNKQ5LBqt+gZ/ib+URTAdjUMGT71sO+UY2p1OfhQtbDd5Egzdk8bUiEsImq2DxN0BHRhRdDlzYqNpvcNA3bqfW4tVucsXJzFgY6MgWOB2x4/8zstC+hJdVh2U2z6jM3AGBT1ScqkM+NPnSCoUo+45oI2VyQ6kjVxBuxLt+61GNNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQUeeTTaChxym6Px/FOslSGgKkBC5bK69ZhoM8rAx9Q=;
 b=o9DuKkxbnTYg9JYS7r2yjUVFH6aTJ19glJ+svAh7qz1nvl/bawdbGZ/ubjK/g5jjrGccJ8KG8dWhusHTzReth9u3KOHEfIqmgcen95gN8RJ+Vo8HVK0adMTSrxom23tSwkMRgtyn7bNHfRp66eFJtNHMJUP71YeltPEPMvzXSjr7qk612/M5g2l5Fmj5oMEmDTDFpbqCQIRJccdD7D4NW6JeEBa20uGyS5aGrCEjiUA+7fSimBDSU/MexzVkiBklUGS54YHE56rzG5IJsRbxQdqypEW3iL9e3SFgQ4iT4D1n0g7gvSgUu3CXcMDi2LgsJ6dzMbk3Jpc898ZPm9PaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQUeeTTaChxym6Px/FOslSGgKkBC5bK69ZhoM8rAx9Q=;
 b=mWS/iDvHBidnVCSWkbDKZsEFzHmGicj90SrsTcafu4xVDsGK4jATidU7SEv0xxsBT8oOtmM6HBoWqy9ManxP5LNilDkobQ0df+WzWt40VlfaWOVvqDxVCWKadXl37iUIt7rBhNK7U7Ufp81jCivCo01LelBi6HyWfnnVCF2pBWJtw0PEPvKDBiB7y44OhKRgKQ2u/7wVStuzHKzIVBPYBsC6J/yTORW6tQpfraBYdhpOl0pO3KRwI8BoAMOM7BngNXlOfcWPHMdiJlz4oiAB+mzLCWJ/yVO20kAWce5f36OO0u4R1waUKnBMLs63rwMDFasMcqJPv4UaveYRqcAHOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Wed, 5 Mar 2025 18:44:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 18:44:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liu Shixin <liushixin2@huawei.com>, <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Softlockup when test shmem swapout-swapin and compaction
Date: Wed, 05 Mar 2025 13:44:29 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <3812C3CC-DC05-46D2-9A87-920797227105@nvidia.com>
In-Reply-To: <376D50C9-6DC8-4F58-9C43-173EDCD412DD@nvidia.com>
References: <28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com>
 <c4a07dd6-fffa-41f4-b6ff-3e333d1b5fc2@linux.alibaba.com>
 <376D50C9-6DC8-4F58-9C43-173EDCD412DD@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:510:325::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dde5e63-6f6f-4433-b585-08dd5c15c6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXdqYkRPVVZjZGF2a2w2d0NKUHgva3IrVW9Mek0xS1Q5dWp1TFFOdHpRZWdZ?=
 =?utf-8?B?UTdDU1FOQ2ZSZnl1dVBvNDFjSXBvVi9TZHRKNWVZMVVVNVB3RVBVVnpoZ0dG?=
 =?utf-8?B?NGFpV2t4UjcwS2p2VlROTlhIZERidW9TU0dYSHNuUjdpS2oyMEZjUXUySlBn?=
 =?utf-8?B?aFZuZisvQW5Jb2Z3cjVNUXFuamsyenRQVDhzNWhuZ2hVYjc2SmtZdmdWdFhP?=
 =?utf-8?B?QTQwNWNKNGdPYUhlNnhmU2owTlBxcEhWUXR6V0tXbVRjaC90WjI4WGRqQVJY?=
 =?utf-8?B?S1VaU0t4emhJcVp6amt5U1podDdjbDg0bFVWRlR5Slp6QzRzcHYyeVdyejlP?=
 =?utf-8?B?TWNFcDJJQTlrZWNoSStKTnJwbG0rYXhkVjkvcU9yWklTUVNmTW53MkF3eFZm?=
 =?utf-8?B?UjNnWlhOVmFuYkZtVU8wYnFrc1o1WndOVlBTYlVOMjlJd1lJZzhuaGZKNlUv?=
 =?utf-8?B?WlRCQm04aWZiTE5jQzFnTjU1c1JzVjJJRUd3eG1oTUVMVEplL0JURk10RTF1?=
 =?utf-8?B?SFc3NGdOejZ6Q3dVSmtLSU5NU0RYK0pRYzA0K2ZJa0toYWJZaU13ZEh2K0U1?=
 =?utf-8?B?cDJsZWZ0Z1RBUGlwNkx3N01wNVY0NkgrQXBpN1RMb3pJV1ZIQlF4MkJEekYx?=
 =?utf-8?B?ZEYra2poOFdSODhmZEIzVkhkRlFiUkdPa2VnMWlYMVQvYXFMaVM4OXYxQVJG?=
 =?utf-8?B?OVMyUGNLaE41RUkwTVVtbHFGcEJHU09ZcFpPcXJKS0VEdmdvK1NlUk5SR1pr?=
 =?utf-8?B?UWVvVUx3WXFLbTBOTjMxMnF1cGEwUWk2eFFuUE5yTXByZ2svNmZJajgyTWJi?=
 =?utf-8?B?eGlweDg2UjQwT3AxSVkzeDI1RXRIN3lHSzY0N0ZoVDBvVVZrVEpoVTZtR3Nv?=
 =?utf-8?B?WlBKbmZiT0JrcFRmTzhRajdmMUlIUkRmdTRtZEMzQ0pmdEY0TVJXWVgvZGRJ?=
 =?utf-8?B?Vld5TnZDVzBsYnJnMFEwSy9teHVyYndSZjIzaWR2alhpek1tREhtcytNUXgz?=
 =?utf-8?B?ZlRrTVM3TWpRQ2dRd2dkbVlYbnRiVW56bUhNcGkreHNuWWFoUENUd1F3VWkw?=
 =?utf-8?B?blVWaCtNcVZRemtLaE5XNTNWTUVHMXZVaUZqTy95a2JyUlk0ZkdmZWtrTHFl?=
 =?utf-8?B?QTFlN2ViZ1NXa2Vlc01jcG9XeG9pL0FTTDJzSnpaRUlOTTV5RzE2OUxHK0xk?=
 =?utf-8?B?cktBZ0o2QTR4U1VraUpIalQzUklGUStwUXJYMjJuMGhSSnNXMG42eWRCVmpt?=
 =?utf-8?B?RmtiZ3pnOS8zcGNqSytodHBCT2NhbUhFTkxuVlV1WnpGRTVpQkk5OHBpTFl5?=
 =?utf-8?B?eFlrN1dqUGtTWDFqR1RlVTNuK1VuN1Z1ZWdDTUgxNzlFQmM2citYb2dXMW1a?=
 =?utf-8?B?UzB2R2JUdi9jS1YwVHMzRmNwMEM0Vkg5WmFoc25jRjJ4YnNFMEFSSXJTeGtw?=
 =?utf-8?B?RHdpV0dHWm94V3ZTbU9IZVVCOWtmSGx3ZmRqaU9IdnVBc3pyTXp3N2tmM3BJ?=
 =?utf-8?B?cXdLZndYSHFjU1RwNDByUmFLcXdpMmpacHoyK0ZHWE1NVjNDOFZ0aFJsejBj?=
 =?utf-8?B?aTN2NUIyd0RvYmQzNVd6M0tQYlFoZHFGM2JlOGVielB5Y1V6eTE4U3U0NDRm?=
 =?utf-8?B?bURha2tTT0c2eDdmVXNlRkdLZXR6d2JIYnVDN25zNGkwa0htRE1HUmhHeFNs?=
 =?utf-8?B?aWczY1o2dTBCd0tiZHpwTW5abkk3ejRDVjYvUDNnRHZNY2tzSGNiVXY0eVVk?=
 =?utf-8?B?UWJTaUZSc1NPajhmVEVoaXdpWU0raUYxbU1xWnhBMzNWU1BlcnI3ZVEyak83?=
 =?utf-8?B?cklZWkxrVEtmSlZlRWdZT2Y4ZHVIdkhzc0p3WCtGTkFqelFRK2NPRng0NDBW?=
 =?utf-8?Q?eCJpf9EPGWX61?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmJlTGdMM1VKbjNMSTlxNDVUK21nbHN5V1FyS2NjMUNJVUNyV0NGS2V6aE9F?=
 =?utf-8?B?WGRtNVpjN25jaEtFWGxvVVpheE9XcE9HUk5FYjIvQm1vUzVZcmZjemxiYW00?=
 =?utf-8?B?OVNVSTBGSTdvdFhiNHBHV0tiMWFLYWV2cUhiUkE5dFNRallDZGl6L2tCV1Zt?=
 =?utf-8?B?NFlyRnZ5VmpPTHA3aXY5di9vQUtkc2xSRW9YNWZ6Qi9mbG5lamlYTXphRTFm?=
 =?utf-8?B?UjVJakhtRjdqZDhwNUJ2clFRRGt2WkJteElhZXVkbndsRWVpR2l6RU12bTlw?=
 =?utf-8?B?VlBlelM5OXpZaC9QdXcwbUY2aENXNTRqR2tUajZiWTdsNERiZVNJNzR0Sk11?=
 =?utf-8?B?djhCSHduRnlNcy90WTFoZGhLV1ZMY3JKcHd6ck1uZ0NUZ0hUdjk3dDhVM2pQ?=
 =?utf-8?B?QitQZStrVWdDckFEZHV0b2RndGluOG9kbkFSWFBtbkw0Q01qd00ybVN2ZXVT?=
 =?utf-8?B?cWNaOGYrNXBNV05yK04rWFNRZkdHNW5KZDhKSUlvVXNINDBDSFBlM2xzUjRY?=
 =?utf-8?B?alFzVm9IUmE3Z3EvMDBOWVgwV3hDd2lMa0hwVFVPZU56Rk50WFVkcVZXeita?=
 =?utf-8?B?dzU5OUU2Y1Rra2JTZ3VDZ1Y4T2MxMUJnQUhEUGVMbi8xNmIzZW1hNVFnbGtU?=
 =?utf-8?B?SkxxSURoOU91TjdGVVlEd2dJYnpDdVJ5RW1oV3VDQ0RNa2VXcU90TmowTTJo?=
 =?utf-8?B?b0NjZU4rWW9HY3dKL3Y1Syt5SjVXdlhINUdpd2NacnVuNmhkd1kyV0FUa0R0?=
 =?utf-8?B?VmQ0NG1NNXFPbVhTd05WakR1RUlHR3o2WDFNNDFQQU95OElOYTZVU3lSQmpC?=
 =?utf-8?B?M0NhekhGRHpFbHhCRzFTV2tLSDJscWhjMjgzTmtPZkRiSVJxSXdXNlRTMjVt?=
 =?utf-8?B?VEdkQXV5VDhTQWg2OUs1TFYwTDdVelRsN2tQaHJQcC9LZUtXTDNIcGNQS2FW?=
 =?utf-8?B?RE1qeGNXS0J5VmNGUjl5NnRYaUpKNXhSLzNFWkREVkpJRVFYU0ZQcUlPcW1R?=
 =?utf-8?B?UUd0ZWYvS1loQmhWd1Y1QVNtM012cUtlb2JMTForMktlbjA1MUpZVEVKeFp5?=
 =?utf-8?B?aWtqSW1RSURvMENncExpZTBMZnV6UXZ5bklnQkFPQ3E1REwxeStqbjYrTm9Y?=
 =?utf-8?B?Nmxmdmo0dWx1U0Z0UUd3ZlR3WVQwQVNzTTUwam5nQ3JtUS9aTERMMzVDOC9v?=
 =?utf-8?B?RjB5VWRpdmFKODE0RzlvVVJBV3RKbDJUOUdZdzFENjJ5b2YrcmFkSXZ6L1E1?=
 =?utf-8?B?NjVvR3ZRaFVpRCt1UUpVSXZGdHhmYTJMZzcvTkxJY0l3dnh2dmxCU2ZLSmVr?=
 =?utf-8?B?S25sT0hlMmpxcENjdWZZK29yYnBHdDhNYTJtcmdnRGlkSXhrdDhwQVFzMHNm?=
 =?utf-8?B?QnJtMUR2OGtEQ0lhY210NFZySlVtR2VXamRkNklBc3hxNnAwQ1M4NHhGQjkx?=
 =?utf-8?B?a3ZFby9DWlYwakxFN05Wa0VVaGVlWlZnYnp1Vi85bG5HaElJK3hpQzNHN2NT?=
 =?utf-8?B?Snp5djhnNVo3dGJ0ZFJwMDY3Y2ZlU09LdWc1R1NJZStoN043anp2ZmVFSzF1?=
 =?utf-8?B?SWY4SXIvT2ZlamoyRURSdytQVmY4anRsQmR0Y0FQWEcwT0dOdHlsYnZVd2Vj?=
 =?utf-8?B?ZU0wV1hDejZNc01XWXpIdTE1YkpzMWJ0aWJUNHp1d05rcUJoVFVuRzlGKzF0?=
 =?utf-8?B?bmVrVlJ1K3VlL1dnZFQwNzRqcG9jMVZhSTdscklwcVA3ZnhTOWdqOTFTUzRz?=
 =?utf-8?B?enY4ZWN3YkJOTjlMNEJyWklxYmttUHdOVmxWMW8xd2g0WW1ZaTJNVVdLYS9B?=
 =?utf-8?B?STd0N0NzYjRKc3JuR05xcUplWHR2WXd6cTNCRnJKMENPallSOWxUbHZQOTB3?=
 =?utf-8?B?WkpUNTVMZ0o0MW9vVkN0TVZCaG9EMW9pcXkvYXVlRFBYcWN4NFJDOVBBaE5I?=
 =?utf-8?B?VW4zUWxzS3FqaEZxTW5FOGlZUGV1RTBFTGk1SzVxZG1QeTlWSzdyREtqa2gx?=
 =?utf-8?B?bFM4WVR6TFMvWDN6VTcvdW9rcXQyakkrSm1GeVZEejRpWkx6TFc4ZEdTSHR4?=
 =?utf-8?B?bkFyVWxuWGJtWGJPaVR5VXp6UjBBSTF4WXdtbURxMlNzQWNOQnZwT2E0KzNQ?=
 =?utf-8?Q?EiC4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dde5e63-6f6f-4433-b585-08dd5c15c6bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:44:35.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcjeOiCOC+t/N29U2Niy6U5M+qYqHNlrN52ng4hrFLJIfzNvpJMkp9VT7EHP7Qfk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168

On 5 Mar 2025, at 11:27, Zi Yan wrote:

> On 26 Feb 2025, at 2:22, Baolin Wang wrote:
>
>> Add Zi.
>>
>> On 2025/2/26 15:03, Liu Shixin wrote:
>>> Hi all,
>>>
>>> I found a softlockup when testing shmem large folio swapout-swapin and =
compaction:
>>>
>>>   watchdog: BUG: soft lockup - CPU#30 stuck for 179s! [folio_swap:4714]
>>>   Modules linked in: zram xt_MASQUERADE nf_conntrack_netlink nfnetlink =
iptable_nat xt_addrtype iptable_filter ip_tantel_rapl_msr intel_rapl_common=
 intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel kvm=
 rapl cixt4 mbcache jbd2 sr_mod cdrom ata_generic ata_piix virtio_net net_f=
ailover ghash_clmulni_intel libata sha512_ssse3
>>>   CPU: 30 UID: 0 PID: 4714 Comm: folio_swap Kdump: loaded Tainted: G   =
          L     6.14.0-rc4-next-20250225+ #2
>>>   Tainted: [L]=3DSOFTLOCKUP
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1u=
buntu1.1 04/01/2014
>>>   RIP: 0010:xas_load+0x5d/0xc0
>>>   Code: 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 73 =
18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d
>>>   RSP: 0000:ffffadf142f1ba60 EFLAGS: 00000293
>>>   RAX: ffffe524cc4f6700 RBX: ffffadf142f1ba90 RCX: 0000000000000000
>>>   RDX: 0000000000000011 RSI: ffff9a3e058acb68 RDI: ffffadf142f1ba90
>>>   RBP: fffffffffffffffe R08: ffffadf142f1bb50 R09: 0000000000000392
>>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000011
>>>   R13: ffffadf142f1bb48 R14: ffff9a3e04e9c588 R15: 0000000000000000
>>>   FS:  00007fd957666740(0000) GS:ffff9a41ac0e5000(0000) knlGS:000000000=
0000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00007fd922860000 CR3: 000000025c360001 CR4: 0000000000772ef0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   PKRU: 55555554
>>>   Call Trace:
>>>    <IRQ>
>>>    ? watchdog_timer_fn+0x1c9/0x250
>>>    ? __pfx_watchdog_timer_fn+0x10/0x10
>>>    ? __hrtimer_run_queues+0x10e/0x250
>>>    ? hrtimer_interrupt+0xfb/0x240
>>>    ? __sysvec_apic_timer_interrupt+0x4e/0xe0
>>>    ? sysvec_apic_timer_interrupt+0x68/0x90
>>>    </IRQ>
>>>    <TASK>
>>>    ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>    ? xas_load+0x5d/0xc0
>>>    xas_find+0x153/0x1a0
>>>    find_get_entries+0x73/0x280
>>>    shmem_undo_range+0x1fc/0x640
>>>    shmem_evict_inode+0x109/0x270
>>>    evict+0x107/0x240
>>>    ? fsnotify_destroy_marks+0x25/0x180
>>>    ? _atomic_dec_and_lock+0x35/0x50
>>>    __dentry_kill+0x71/0x190
>>>    dput+0xd1/0x190
>>>    __fput+0x128/0x2a0
>>>    task_work_run+0x57/0x90
>>>    syscall_exit_to_user_mode+0x1cb/0x1e0
>>>    do_syscall_64+0x67/0x170
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   RIP: 0033:0x7fd95776eb8b
>>>
>>> If CONFIG_DEBUG_VM is enabled, we will meet VM_BUG_ON_FOLIO(!folio_test=
_locked(folio)) in
>>> shmem_add_to_page_cache() too.  It seems that the problem is related to=
 memory migration or
>>> compaction which is necessary for reproduction,  although without a cle=
ar why.
>>>
>>> To reproduce the problem, we need firstly a zram device as swap backend=
, and then run the
>>> reproduction program. The reproduction program consists of three parts:
>>>   1. A process constantly changes the status of shmem large folio by th=
ese interfaces:
>>>          /sys/kernel/mm/transparent_hugepage/hugepages-<size>/shmem_ena=
bled
>>>   2. A process constantly echo 1 > /proc/sys/vm/compact_memory
>>>   3. A process constantly alloc/free/swapout/swapin shmem large folios.
>>>
>>> I'm not sure whether the first process is necessary but the second and =
third are. In addition,
>>> I tried hacking to modify compaction_alloc to return NULL, and the prob=
lem disappeared,
>>> so I guess the problem is in migration.
>>>
>>> The problem is different with https://lore.kernel.org/all/1738717785.im=
3r5g2vxc.none@localhost/
>>> since I have confirmed this porblem still existed after merge the fixed=
 patch.
>>
>> Could you check if your version includes Zi's fix[1]? Not sure if it's r=
elated to the shmem large folio split.
>>
>> [1] https://lore.kernel.org/all/AF487A7A-F685-485D-8D74-756C843D6F0A@nvi=
dia.com/
>
> Hi Baolin,
>
> With step 2 and 3 above, I hit the error below on mm-everything-2025-03-0=
5-03-54.
> It hits VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index), folio).
> mm-everything-2025-03-05-03-54 does not have my folio_split() nor xas_try=
_split()
> patches. Can you take a look at it?
>
> What I did:
>
> 1. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_mem=
ory >/dev/null; done=E2=80=9D to trigger compaction;
> 2. use zswap with =E2=80=9Cecho Y | sudo tee /sys/module/zswap/parameters=
/enabled=E2=80=9D;
> 3. running shmem_aligned_swapin.c you gave me with 128MB SIZE and using
> memset(shared_memory, 0xab, SIZE) at the end instead of just setting 0s
> (this should not make a difference from your original program).
>
>
> [   37.591314] page: refcount:2 mapcount:0 mapping:000000000c53d1a6 index=
:0x6687 pfn:0x169420
> [   37.592552] memcg:ffff8881781c1800
> [   37.593046] aops:shmem_aops ino:c0f
> [   37.593586] flags: 0x2ffff000002013d(locked|referenced|uptodate|dirty|=
lru|active|swapbacked|node=3D0|zone=3D2|lastcpupid=3D0xffff)
> [   37.595138] raw: 02ffff000002013d ffffea00058a6b08 ffffea0005a50408 ff=
ff88817951cd68
> [   37.596207] raw: 0000000000006687 0000000000000000 00000002ffffffff ff=
ff8881781c1800
> [   37.597305] page dumped because: VM_BUG_ON_FOLIO(!folio_contains(folio=
, xas.xa_index))
> [   37.598464] ------------[ cut here ]------------
> [   37.599119] kernel BUG at mm/filemap.c:2134!
> [   37.599729] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   37.600494] CPU: 4 UID: 1000 PID: 1922 Comm: shmem_aligned_s Not taint=
ed 6.14.0-rc3-mm-everything-2024-01-29-07-19-no-mglru+ #49
> [   37.602267] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
> [   37.603557] RIP: 0010:find_lock_entries+0x352/0x360
> [   37.604269] Code: 44 24 10 48 8b 4c 24 18 eb b5 48 c7 c6 08 bb 99 82 4=
c 89 ff e8 cf e6 03 00 0f 0b 48 c7 c6 70 a3 9c 82 4c 89 ff e8 be e6 03 00 <=
0f> 0b e8 a7 69 ca 00 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 9
> 0
> [   37.606838] RSP: 0018:ffffc900029bba68 EFLAGS: 00010246
> [   37.607566] RAX: 000000000000004a RBX: fffffffffffffffe RCX: 000000000=
0000000
> [   37.608550] RDX: 0000000000000000 RSI: ffff8882b5d1d900 RDI: ffff8882b=
5d1d900
> [   37.609580] RBP: ffffc900029bba88 R08: 00000000ffffdfff R09: ffffffff8=
2d238c8
> [   37.610566] R10: ffffffff82c73920 R11: 6d75642065676170 R12: ffffc9000=
29bbb48
> [   37.611551] R13: ffffc900029bbc48 R14: ffff88817951cd68 R15: ffffea000=
5a50800
> [   37.612535] FS:  00007f40107cc740(0000) GS:ffff8882b5d00000(0000) knlG=
S:0000000000000000
> [   37.613683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.614483] CR2: 00007f40107bf000 CR3: 0000000101c00004 CR4: 000000000=
0370ef0
> [   37.615472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   37.616459] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   37.617481] Call Trace:
> [   37.617838]  <TASK>
> [   37.618183]  ? __die_body.cold+0x19/0x26
> [   37.618746]  ? die+0x2a/0x50
> [   37.619150]  ? do_trap+0xc6/0x110
> [   37.619610]  ? do_error_trap+0x6a/0x90
> [   37.620126]  ? find_lock_entries+0x352/0x360
> [   37.620711]  ? exc_invalid_op+0x4c/0x60
> [   37.621354]  ? find_lock_entries+0x352/0x360
> [   37.622075]  ? asm_exc_invalid_op+0x16/0x20
> [   37.622647]  ? find_lock_entries+0x352/0x360
> [   37.623268]  ? find_lock_entries+0x352/0x360
> [   37.623946]  shmem_undo_range+0xf8/0x6a0
> [   37.624547]  shmem_evict_inode+0x117/0x2b0
> [   37.625145]  evict+0x10b/0x290
> [   37.625607]  ? fsnotify_grab_connector+0x42/0x80
> [   37.626257]  ? fsnotify_destroy_marks+0x26/0x1a0
> [   37.626903]  ? do_raw_spin_unlock+0x49/0xb0
> [   37.627489]  __dentry_kill+0x71/0x1a0
> [   37.628009]  dput+0xf8/0x1c0
> [   37.628427]  __fput+0x143/0x2b0
> [   37.628877]  task_work_run+0x58/0xa0
> [   37.629428]  syscall_exit_to_user_mode+0x168/0x170
> [   37.630099]  do_syscall_64+0x57/0x110
> [   37.630619]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   37.631324] RIP: 0033:0x7f40108dc1f7
> [   37.631844] Code: 73 01 c3 48 8b 0d 29 9c 0d 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f9 9b 0d 00 f7 d8 64 89 01 4
> 8
> [   37.634424] RSP: 002b:00007ffcad4bd468 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000000b
> [   37.635466] RAX: 0000000000000000 RBX: 00007ffcad4bd598 RCX: 00007f401=
08dc1f7
> [   37.636450] RDX: 0000000008000000 RSI: 0000000008000000 RDI: 00007f400=
87c0000
> [   37.637477] RBP: 00007ffcad4bd480 R08: 0000000000000064 R09: 00000000f=
ffffffd
> [   37.638460] R10: 0000000000000003 R11: 0000000000000202 R12: 000000000=
0000000
> [   37.639442] R13: 00007ffcad4bd5a8 R14: 00007f4010a10000 R15: 000055694=
d923dd8
> [   37.640422]  </TASK>
> [   37.640750] Modules linked in:
> [   37.641249] ---[ end trace 0000000000000000 ]---

OK, it is probably still caused by the __folio_migrate_mapping() bug, since
writing to sibling entries of a multi-index entry breaks the multi-index en=
try.
Thank Matthew for doing the experiments.

I will send a proper fix based on Hugh=E2=80=99s version[1] and cc stable.


[1] https://lore.kernel.org/linux-mm/23d65532-859a-e88f-9c24-06a6c7ff4006@g=
oogle.com/
Best Regards,
Yan, Zi

