Return-Path: <linux-kernel+bounces-563310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91DA63D45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD83AD35F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE742215040;
	Mon, 17 Mar 2025 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3amPr3e"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBC214A96
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182775; cv=fail; b=cRQD2yWsS3rFwxiLKeTr8tQLBV5UTd0OrYgZnH30BlrwINABUye/TCqr604IlY0pKJ04Nsc6PtZgt8fq4h/wimZtCTx7+WX1JVBBYuSaTTi+7XM/GKKoG/DLmLmDjEROal9vSQFPnVs+/l8dJWzOXwQ1I9Nn8lmnHHFuF+C+X8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182775; c=relaxed/simple;
	bh=qcY+njS6MbEhb+cdaWAPCTOjGwFpcs7g+0hnA5x9fMw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=trzVt1TLGeoo5gpO8OyCfStwOz3NpNAnWzH01R42OjL9NYSXV8cmuBfktkohXfTgRtVClvv5Ik9teSk/7MQaTJ4W7tuQUEhZkzEmX8Ll1pZBcIj/6JED/i89Ce/nSZaXZaQGCkCGj4fOai1AHrYVJJuTEWftv0HM7JYOFAQ1dLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3amPr3e; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9LO3w25UDUBBSnEzkmVB06ZCKoqN22W8zasLjkQrDNka7cify1yBsJJtunVR/PBXitW9RnGQ3pWc0XWSYWdDkwBNVY8hsIkBvwC21fbuHMsGX2dlpOsQWXiAFcsbewhi+zvGDSdKBdyBtNcs9RLrvn4WGQb7t5+bfjPp0+rmNGPe1fV9RKtYPAnBQjmjZwHbetC62JkFXhbSLhUBCd5C/t3EGKmjZDX34365jM90/xvPUtXX6M0kwT3hP6C4Rl2bjxLd8S595p0kQkUqOlF6Bg7hDmar4dXHfWpd3t3h6LoC6KGTI//Y07g86yGvxlMpqIXsYgYStVyc0BkYEeO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxTGqety6DazW7MCqdsFFVl72gIeChlZ9c/aKeXKXAo=;
 b=tGLa/xYWi5cOO39r7Kj8I2zX2kDEisyod8MHHadK0r1NE/lIl5WFawPvwl2k+VrnqYKbQbh/+i5f+PhCdI0T/6JfHRW1A2QIk9vqiwgiwRaVn7uUz9ddoK5IiFGdguYxNrj+oLha/CRDoFqulf8ISOFpxwwT42MZNlkyk5tREcxfENkoAsb32Rh4L2U+ckZt/kIIrv7piW87uw9bd7Euzpd2SZrbGGHI6HynwnCCMHs0FSAwp0k2OyzXs3bac3t+GnE9TdJCc06hfCUb6zNVH4qeFDmt3w0ydBeQsvQdfazMgGMsnn2rIop5MiVFzK5bYxQmpHE57KFnyJ+yI3EbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxTGqety6DazW7MCqdsFFVl72gIeChlZ9c/aKeXKXAo=;
 b=d3amPr3eVm1vMoAJZu3UGCVMVK/zYdyMzf/4tBNWvwGC8a4w8Y7B4c1O7kSa/vylEG3d+n4ltfIO3ztPFpUbF4zMS6KDF0cBtq1cuy7OPjFESGHYKoYcez1RJZ9v8ILO0lYI7rtm6XDrggqUdKv4bVcOzPNWZ7m1YE84HApcjXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 03:39:31 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:39:31 +0000
Message-ID: <b9965654-af90-42c9-8e4b-b29621d11ea7@amd.com>
Date: Mon, 17 Mar 2025 09:09:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
 gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
 jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com,
 nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
 rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
 vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250313164430.bzkfyqmx6a5dj7d2@offworld>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250313164430.bzkfyqmx6a5dj7d2@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: ba04ce14-2650-4cc4-c2f2-08dd650553a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THJmOVdSZlhMTjlFcmJHQ21MOGZFNHZ1OGxmaHFxdEZBTWdqYUJHbHlJRElm?=
 =?utf-8?B?aHdEOTFFRFBHQ2M1cUhNOVdWblhCWEhZSDlpM0lhZk9mcmdGUkRvMnJyOFNX?=
 =?utf-8?B?dW1YM01wZVZpL3VZM0ZIc2Ria1ZYbWYxejNXM1Z6SXplOHFDN3E4RWxXeHR5?=
 =?utf-8?B?MkN2TFY5RWFkVmJwVjEyRTZJamFHL3RNWE12SzMwbUZxS3lHMkk3NlNQeWhX?=
 =?utf-8?B?bjlQayt2TTdGREVvdGZHS0JhblBqRzBvVEtnV2N2SHhNTzlxVTdQMmVyY29C?=
 =?utf-8?B?RlY1YnN2M2pQam1JVlBKR3dBK2FYZ1hoTDBINlZUSTlsSjRHTWVqNldxemZl?=
 =?utf-8?B?VEo4REdSL1ZUSUNLNjBVVkU1bXRubkwzbmE3dTNaeEFWY2x1NUNkbzk4ekd1?=
 =?utf-8?B?TDBodzYvQ3FqZlpVL25wc2s5UGNNb0hYTU5VdXdWV2RBZFppMDFPbndpa2gv?=
 =?utf-8?B?ZmZqbHNoakgyY0JqOXlRSjlhdUhlTkJ4Kzc4b0p2NjVQdk5QWjNNcUg4eFRK?=
 =?utf-8?B?aG56b3BLUTVXQWNwcW12ZTdhSUZtcmdrS0w4aDFwOWhWL25YWE9IcnpwaU41?=
 =?utf-8?B?blgrTUJLbWowWWZIZUlad0FHQ1cxU0swSEhKZWRNSWFqNHJIS1hFQVFEK1dN?=
 =?utf-8?B?bG1WZmxOQldjS0hMNllFUnJXMlQ4ZmY1SVBvRFB3OHk2NnhxUFQyQjR6bmo3?=
 =?utf-8?B?Qm5oMWNTUU5qY0ZOVnhwQUZTVXRhaVRJZlFvMzRUNENBSDRtWnZNMWRQVTVX?=
 =?utf-8?B?OWxzOUlnY092aUI4QWdNeTNzc0NKTk9BbGdtU1JZMFlNa3J5MkoxOE0xMVR4?=
 =?utf-8?B?RCtWSVFYRUFoZFJodEMxZFlwcDNjNE0vNXMrSDdVN0lzdjZUNE54eWZKYlZO?=
 =?utf-8?B?QUdlVlJGWjBnMk5Ka0Z0UGUyOHdLL0Q2ZlJZODk2R1lMNlBtQlNuUXgyUGtp?=
 =?utf-8?B?eElzdWFvenduWnFuUkM2ZHM1VStjTVVFbjFrUmFCWGpPVzVEQ2Vob2F0YjJU?=
 =?utf-8?B?M0t5WU0zemhDdHZnd3czL3BNWG5lTWt2Q01hcDNzaUlSOXdIai8rQWdvbFF5?=
 =?utf-8?B?YTloUzBoSW9wZ3VTMml0ajRPYTNGcnh1VEdBZVJrUFYrOVBONVZsR0pWQWNF?=
 =?utf-8?B?bDdETjlRMkxYQmkrMHNmaGJQbE40MGYyMWZzT0tnY1U4QS96aFBLV0NMa1pj?=
 =?utf-8?B?dFo2bnZMeWdkODJHZFNkMy82UERXd2VwNTlXdFBZNU52QisxQmd4VlRYeW5Y?=
 =?utf-8?B?c2JwdGFnZjVxaURPenlwdEtlcEQ1SEsvVnZJVlR3R1V2cTlKS0NQanlBdHVv?=
 =?utf-8?B?WnNzNXJkbUxsVzNwaTlrdG81Y1htekpUTHZkN3Rjb2NYTmF0ZUhzVXJTRWt5?=
 =?utf-8?B?aWdjUURuazRxT1hZTHN4NWFIZDN6aEpMb255QTZWcEpsb2llK0RTOE9sMlZM?=
 =?utf-8?B?NENLZ2lRTEtiK1FTc1E5WDRPeVRLcDdrUlNscVdPa3dsVjRUZXV5cDQvTWgv?=
 =?utf-8?B?TThJWkdBMnpwc2pYOFJ6R0pIRnlPamNHQTdWQW5mdTFPQjZIVGsvTHNwZ1l4?=
 =?utf-8?B?Yk9YeDZRREhrTnZmSnUyVEEzWHhsMGE5eGVVOEsxVTlHUDErQjlnL1BpdTJi?=
 =?utf-8?B?Z2szVFR0Nit3bDR2WDRGOGpCKzNCbUNqUzY0ZnhzTS92cEk5MFRDODRGT3dp?=
 =?utf-8?B?UUZLeDhTK1p4cEt4b21GejU5TkxSSVQvb2pkR2FnWnVRckhlSTBlakJkdWZO?=
 =?utf-8?B?akFpdGs5UHRndExkTmY2QzBDenY5ZEM3WmwzNnZRQmFlTEZOYWx2K1dGcWE5?=
 =?utf-8?B?UjVpM2hUb0lrMGEwTURxdG0vSUw0bmpHVGNKNUZlYyt1a25GWWtzQ0ptbmlJ?=
 =?utf-8?B?Q1B3dno0d29pMXBJVWw0d1hGVE80ejB0dTlaNExvZU1pZFF1TlFDR0oxS2I3?=
 =?utf-8?Q?jyKK4b+terI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGVIQ2xKakNUTlNWUjl3d0hEUlErUEp4bmt5dmVaZVdPcTBjY0ljU2E3bG4x?=
 =?utf-8?B?VkRGTUdIcXJZK2RHS3NqYmFxZDR3Z2JlbzNLVjJIZlB1YXVTV0tzMEZZMGRC?=
 =?utf-8?B?ejArL2pxOUNUZjBkTzRNNEdiTDdIa2VuSzJySzJqL05DaVBTbmhiS1hlbU1N?=
 =?utf-8?B?TWFpSnNFcGJSQnRBSUpIdzk5OE1Vd3JSTUEwMzRFLysrVzltem1YSmNuNkZS?=
 =?utf-8?B?VmRqdmlUWkRreEEvTHZCMWlXOGV5YmNOZ0VQUnZpSnBoWkpYZk1VVHdWWHRX?=
 =?utf-8?B?NUVyTUZES3BNOVM1UXIzaGQ3Z1B0K29YRklsNSs4bGF3NitkRFI5allGcjQr?=
 =?utf-8?B?VkhkbEE0RUUwZHNLNmJaejB5bzhlL2NReWpmajZwa0FPMVRPRFNYaEszaDcx?=
 =?utf-8?B?Q0phNGx0UkF2bzhWUTNPenpiaVdZVk9jUXZsM3NiWG53SjU5dkZTVEVhNTNK?=
 =?utf-8?B?bzNKanNteWwrYjVSOWl6dDFHQkdNUEZCckxydVVjaDdGakE2UXBHSHVrOHR3?=
 =?utf-8?B?SDdYYWhRc2VSWTJwdHJqSWdjeUlRWkJqQUh5Skd5WFYwaStmdStxS1htaGx5?=
 =?utf-8?B?b1VGdi9KRnY3SDB3aTBXQVQ4RmJvN0N4bUZKK3pJVEJxRGRWeDVQQjVOVm9o?=
 =?utf-8?B?bDdTejNWT1VWcWNMbXg5bGhLdlBqV1NwanJaaGNmQnpDV05BTDk5WGN1b2pv?=
 =?utf-8?B?dVo1UDgwcStKVC9QaTVQRFhEN0ZaUlpyNFpCbkhaRDRPZ2RsZ3Nkc044cWZi?=
 =?utf-8?B?L3NMNjVmbnE2MEh2ZkMrR2lEcEJzam9ua253VXo4ZmlzWkhpTk5YeUtCUDNP?=
 =?utf-8?B?THNTTmpPbEtnb09ma3BKeGEwZjdKSWVLTEdHT29hd1YwM0pOcFZkQzdJRXN2?=
 =?utf-8?B?akR2Vmh5Z1NXc09rSk84Szc3TTF3SzhXTFVlSTIwY3Yvb0xFTjlBbnBrWlgz?=
 =?utf-8?B?eVM1QXYxNjhpQ3ZyYXk5R3EvWjQxN2l0YkFnR3lrRlFPclJQTjYyWmN6SlRU?=
 =?utf-8?B?cGdWU3pRVFE0c3MzRnVKTWlHS2pHaGdEVm94Y3MxMkVLbkhCZUI3NStsd1JY?=
 =?utf-8?B?N2k5RGJ0TFo2NHhHVHBTSnhXWVlxNmlqY1huU3hiSnVDUE1HY01INit5bGZo?=
 =?utf-8?B?NDA5RjRoRVFxYXUraVBCRnFCeHhiVXR6Y2hnRnFjaFpsY1BjZG9adGR6cTFq?=
 =?utf-8?B?cURzajJGM1Q5cGttdVBFNWtjdmFvUkVPcDZ0RE9vYUxIdTBaYUhWakpoY096?=
 =?utf-8?B?N2FhaXpnOVN5QmdQbHZVWGg4S1ppTUNubERwSkd5MzBzQ0FnQ0lNT0xPZFZr?=
 =?utf-8?B?QkZ0OWdEaS9JeWtxR0RzK3FvazlJVzRUZFpNckNMOHVPSit5Z0hoQS9xSjVV?=
 =?utf-8?B?MDV6NWJ5a2Z3dGgxZjJ3SitrbmVTNkEreGZBVC81eWc1bm1BOW5ySXhoN1dr?=
 =?utf-8?B?VnBOaFlpMyswTTh3R0EwQU9KU2RZR2FRTzlFOXJqWVlQVXJWOTRMK2x1c1VB?=
 =?utf-8?B?ZUYrSHhkTEhHSnYwLy9FTGJYcXpoN1VwVW5JQUxwUjJVUm9MbzJTNWJ2OFlE?=
 =?utf-8?B?Q0JKYko0aHp5QkVTR0Evc0JKSEVsMTBDbkRMemVMVGgvTUJvZWxWSUZGbWIr?=
 =?utf-8?B?QnRBOWNkZkFaVXJHdCtYSjZOWkZEcDdMSTl3TUVtY3lwd2k4UVhMbS9hcDA3?=
 =?utf-8?B?QkhDSjhNWUpCK0RBSUV5UDNLdHEwVjdFSm5ESnVMMnJGTnpheFh4ZGdFNWE2?=
 =?utf-8?B?bjJqTHkrSGYwanpMaFl5dmt5bk1oblRlOVAxOXVNYmZwbWVac1RQWHluT2FS?=
 =?utf-8?B?UDNHMzdwY0tEcXFPZHRPdzdHa200N2VJRU8rU2Y2ZkIrNkV6WlFyOVhVdk03?=
 =?utf-8?B?UU1aM1R6ZndSNXMxSUFBRTEyYUVtYWU3WW5UT20xc28wdEZjQmx4QTlZeXp0?=
 =?utf-8?B?Q0MveWZaZ3lpTmhyVWVXelFtUzhXcGFKODhSdnR4UVBxZnVaQitEbCtFalhl?=
 =?utf-8?B?ejZqTDhhTldjenZjdVFaeGc5UDBzUUFwcWlUVkQxcjU3T0pSTDA4dGd2d1Ny?=
 =?utf-8?B?NGFnK0RzRk80aUc0bVdybVJZNHh4cVowRHYvWC8zcGJWaVVjQkxUYlNoM1NS?=
 =?utf-8?Q?YdVn5zQZnB0J0evIeAvM0Zhw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba04ce14-2650-4cc4-c2f2-08dd650553a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 03:39:31.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSojQbjTIYeMEdvE1RjCoyYaZpAPviUGCdSvty8mWVdK1M6NFsslU/SrdaK+YqEHYd6sJbrm9oVjGiA2Ibt2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On 13-Mar-25 10:14 PM, Davidlohr Bueso wrote:
> On Thu, 06 Mar 2025, Bharata B Rao wrote:
> 
>> +static int page_should_be_promoted(struct page_hotness_info *phi)
>> +{
>> +    struct page *page = pfn_to_online_page(phi->pfn);
>> +    unsigned long now = jiffies;
>> +    struct folio *folio;
>> +
>> +    if (!page || is_zone_device_page(page))
>> +        return false;
>> +
>> +    folio = page_folio(page);
>> +    if (!folio_test_lru(folio)) {
>> +        count_vm_event(KPROMOTED_MIG_NON_LRU);
>> +        return false;
>> +    }
>> +    if (folio_nid(folio) == phi->hot_node) {
>> +        count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
>> +        return false;
>> +    }
> 
> How about using the LRU age itself:

Sounds like a good check for page hotness.

> 
> if (folio_test_active())
>     return true;

But the numbers I obtained with this check added, didn't really hit this 
condition all that much. I was running a multi-threaded application that 
allocates enough memory such that the allocation spills over from DRAM 
node to the CXL node. Threads keep touching the memory pages in random 
order.

kpromoted_recorded_accesses 960620 /* Number of recorded accesses */
kpromoted_recorded_hwhints 960620  /* Nr accesses via HW hints, IBS in 
this case */
kpromoted_recorded_pgtscans 0
kpromoted_record_toptier 638006 /* Nr toptier accesses */
kpromoted_record_added 321234 /* Nr (CXL) accesses that are tracked */
kpromoted_record_exists 1380
kpromoted_mig_right_node 0
kpromoted_mig_non_lru 226
kpromoted_mig_lru_active 47 /* Number of accesses considered for 
promotion as determined by folio_test_active() check */
kpromoted_mig_cold_old 0
kpromoted_mig_cold_not_accessed 1373
kpromoted_mig_candidate 319635
kpromoted_mig_promoted 319635
kpromoted_mig_dropped 1599

Need to check why is this the case.

> 
>> +
>> +    /* If the page was hot a while ago, don't promote */
>> +    if ((now - phi->last_update) > 2 * 
>> msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
>> +        count_vm_event(KPROMOTED_MIG_COLD_OLD);
>> +        return false;
>> +    }
>> +
>> +    /* If the page hasn't been accessed enough number of times, don't 
>> promote */
>> +    if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
>> +        count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
>> +        return false;
>> +    }
>> +    return true;
>> +}
> 
> ...
> 
>> +static int kpromoted(void *p)
>> +{
>> +    pg_data_t *pgdat = (pg_data_t *)p;
>> +    struct task_struct *tsk = current;
>> +    long timeout = msecs_to_jiffies(KPROMOTE_DELAY);
>> +
>> +    const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>> +
>> +    if (!cpumask_empty(cpumask))
>> +        set_cpus_allowed_ptr(tsk, cpumask);
> 
> Explicit cpumasks are not needed if you use kthread_create_on_node().

Thanks, will incorporate.

Regards,
Bharata.

