Return-Path: <linux-kernel+bounces-375388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D09A955A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C07E280DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F587A724;
	Tue, 22 Oct 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VD+5aqiF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CEC8836;
	Tue, 22 Oct 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559760; cv=fail; b=kAF0o3dn1wdzG9Kwd7Qi1aIDzRWU1AkcTijRRMgEIUYc3nnVo9XfbwHWEjZceWs7zGa0eYncMr2yG4Nd7Vs1gqyQLbxPO6xWM3NbVa/U4J+TWG04ZJGVP5ELS+0BQGZmfOewSx1iuLhzNLrE+Z2mX+qgcSFUQNqQDGOvO+ddkCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559760; c=relaxed/simple;
	bh=sxCqhqQ9OqH4KhE8lEvllSTuGI2f8qLOX87vfIjaUo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SuzBh87JMinrDPlQAdhLHApSdD6Y3jmKt+ZYz7U/O/kXRXQestib5yG6oBnx33f0NXvB6+6cn8G8LaCUQnIChR5P/eAdoZ8nYs+MkmVxiroVwO/BkyZXFczcBEw8Hbh5X3xiSz83cphYwPcQm1qY2m6Igduhu4CQp5YGttoUVlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VD+5aqiF; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQej43K5Ias5E90bJ0We020EVG6IQU4x7umcDWwmnSCmWqngpcJutUtzt6VVmFv9Kjfhp+AFNojV4hBCifytgnVJaGb+48StZ4QX7nLu16z1IVVyqvRU4qVZM2jvE3Vy/+rO86UnZccWieXtlSNb9lVZAdTlAJcFCh57Cb+GRC5VC4YmynxkMNE9ewavRH3186mz54tywAwInYiIkfD5EqRhjSdTycEcsR1xcNyn22Kjbh95CBNgQHRjop2UmwrtRL7ve3MRnfsKMWeaykb7gM/O5IMrnDiA3DhFLPaCwsRmw+ijuUhb70BtloR3YKOFMJrkdTfEipx4b/LolHaBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUMnKPouwDyGqMIvDPd0CWDdEi6MbgHequ+l1cbHCZA=;
 b=uk7rafeu/pwpoLQsjEpVTS8yLITkNjQR1iREs7j79G8K3cQ+aTfo4t29tVKYpp6OpXplwgvFTJ/l8Nsd6RBBRUXrbJYOFTYJnx9ZtTdorL7O8+tChkQh19H1eo5b7jiI1p3Wq/JR1g+yDOeGRcd/HtaKmn48aCdqLJ2JfAuTLbdtz4Iw5Oa/bA4vra95mpnv4KcMHIgQnoBxmRcxOcRTkN8GIZoM7uijLGtmO6e48MMxm13bkLnQg/78eqHXLj9F98bfSjf4u5VIeSOsJ5+XG420sBoFwVOeRen3qfVNUxRu6W8ZFhEvjAYZ7yTqr9ZGm2BBppPkyjUZVzitP1U+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUMnKPouwDyGqMIvDPd0CWDdEi6MbgHequ+l1cbHCZA=;
 b=VD+5aqiFmFLYovuAdltxmmW+hRmYl29SabHCWYHXWPy2zLUlz65Wh9ZDMzrBAxq6xsBIFhOWe9j9yyOXEPkLD7zf4AchKU6qylJIJm3I8VnvJv7OS5Au6bZ3AeJKTIufRQZsi0VTQ6+OR4Slft7Ug3XgfKWRtX54p9Kw0fBkXtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 01:15:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 01:15:53 +0000
Message-ID: <2ceed0db-0c23-2902-30dc-eb0dcea0c667@amd.com>
Date: Mon, 21 Oct 2024 20:15:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
 <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
 <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
 <c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com>
 <cfa7ef63-feb2-4afd-b05b-76335af888dd@amd.com>
 <379acb61-0afb-457b-85d8-916f23b39e4b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <379acb61-0afb-457b-85d8-916f23b39e4b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:806:127::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f7f02-3ede-40a5-426a-08dcf23712d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVhydjAzVXFRU0VYQy95ZmZKSksybmpiNjBLWlovdTVBMitQcWlYK1dFUWZT?=
 =?utf-8?B?enVaZzk0bjJQMWNYeWFnOXV5NHJiQXRhNWhXZFJibm5zTktrSWZKK2FxSy9B?=
 =?utf-8?B?bFpzQ1BZS3p1Ykp0Q0F1dW85d2xEaWtYQXNXR3hKckVUbGhPc1VreFJub1ox?=
 =?utf-8?B?ZWdHOS9UU0tGdm9teFJla0lzZnd4ZkdPOUVZYWJsS2ppY0VDZGluS3dYc0hP?=
 =?utf-8?B?RS9sbWVNblNhUEUwSDdEQkZyMzVsYUE2cHNEeGFVRGVVY1JwdW9WSTRXb3Q4?=
 =?utf-8?B?U0J1UjRZS3VGTjIxTUZlU1RPbnE4TUd4U3BaUWJQZzN5UHdRQzlvUUVkZ0xl?=
 =?utf-8?B?SGMrYmtZUFB4WHVnZytXQzlOR2VEVVVPank0bmtqTWZZMzNYaDVwUDNCdU14?=
 =?utf-8?B?ZEJkMXZoWTc3L21lS0Q2ZE1NRE5Hci9jRmM5bkU3eEN3M2ZUSUxuNnBsZ0Zh?=
 =?utf-8?B?bGVCZEtndGMwWDhmSXIza1MxeDM0YU5LV2NPRlF0eTgrWWpVUzNtWFpzTFRB?=
 =?utf-8?B?TEY3d3lYeDhFWjc2T3BxWC93ME9Yd3E4T0JmOG8rcHJxRHh0REFmN2lrVG92?=
 =?utf-8?B?RURXclJVclR2dFIwUG05TWxvVnV4OUZ6YmZJSnJPRVhBKytSUU16S0hHNVF4?=
 =?utf-8?B?aU8zUUVaUDEwQVVzNVpLbXdWeW9lUHUvZGNZUnhYeTJ6YWtqcVBPaDdvNzhQ?=
 =?utf-8?B?VEloZ2poYXZtMjQxR1VndFpGU0hvRHZ0cmJoUk43L2M1TDIvcmU5bThmdWFC?=
 =?utf-8?B?V1FlUEdwNlVoSVVsQmZSNjQwWGhCZGkvWS9pUHlVemVLT0FuYTJpb2tuSm9S?=
 =?utf-8?B?dGI5aTdyZEZLeWNsY0x1ZEZFUENIWlgyVmNaUlI1MlBOV0RzMTRvMG93dTRp?=
 =?utf-8?B?eHlpY2FsYklHSWV3cktIOFdGdjNXUUQrWmtEN0VOZjRTRU43TW9rV1BmZFB5?=
 =?utf-8?B?aXNTUFVMSDdSMlFNQ0FLNFZNSXV4MXh4MU04aTRzZ296SXlaTm1ld0lqY0Rr?=
 =?utf-8?B?VUxnTWhjbE80V2ZWZ29obGRFNzZWNWtKUWNWaEVqMHFva0ZSUU9NT2poSmJm?=
 =?utf-8?B?b3BNVFEwNlZnYkkrRmxBYlJxa1hxMzZlNWNYMVBsUFBoZUxwNitucHdDZEsx?=
 =?utf-8?B?aUJIclNuU1RzWDY1NmpiNjRRWXhrbDdScUdUQW0vL3MxWUcvek93L2xMZEgx?=
 =?utf-8?B?SmdjeHdXRUJGbjQ2RnB4MWd3cmNtajlhM25saUllMlZsS0JsQW5HMzdzQUNO?=
 =?utf-8?B?dnF2blMxV3BaTUVXNGFYYm5FLzdqNVp4QmlSZnNoYm4xZnRzNkQvaDVEL3g1?=
 =?utf-8?B?RmtCQjlxMDdXK2xkTDNYR2FhaGJ5anc4L05zcUVNa3FsTlUxWVRWMU9UQkpq?=
 =?utf-8?B?cHdnQ1dwakR6d0xWRFliZ1lvN3hSWTdtR2o1cUFlUDRqdllWMWNGdUVhT3NK?=
 =?utf-8?B?ZDlETUZyRmJZZUpNdW9IRFptZXF2NFlzVnFHTk1ncTFwTmJLZ212NTdrYktM?=
 =?utf-8?B?K0tSUmRMbGNna2NFL2w3cHI2SVdpWG1meGJWRmpiWlFkRWQwSXZsVnF5RXV5?=
 =?utf-8?B?MWRrbGxTQWdBRTI4cW96L2xJUFFURmpISmZIMXI3VDlSdFNoT0s0ZFM5ZmRT?=
 =?utf-8?B?STdyQkZ1ZXpGL3k5MFp2aEc1b0lSd0NHTnVyUTZrOS8rbTREWTRpemxvbm81?=
 =?utf-8?B?RmpQWEE4ZWtpOUE5NDJhOTNxaXFNZDVsWERoUUxEdk9QV2F3d3g2Q0JrSXJY?=
 =?utf-8?Q?7ja3nowHZWJIHEgA+nvMj9LA7DjvtN6Hq9f3o2N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXVDbUVrZVRUUGxZMEpuSFJpaUZ6NUhKcjY0SFV2OHB6RmR4SDVUbnlLZXkz?=
 =?utf-8?B?YlpJNmpKWS9nVElNRGYwSk9IaHp2TWdLSmoxOUM4ajBhcithWWR3Z01yN1h1?=
 =?utf-8?B?TGF5cE5BMFB6c1lqZitkZE5EcXAyVGFlVm1ZcHM3aGttWlJETnEzd2FLOTU0?=
 =?utf-8?B?STlLb29wTHRpV1VRVWRybUlIYStILzd1NmE3M2loNzFsTE42YmlHaEVPbTgw?=
 =?utf-8?B?VE5CQmUrVkNEbzExWWlybCtLTzR3VXpRV0NpeXYrdTNJajU3aDZHQm1raXVu?=
 =?utf-8?B?S1lReDhGcVJwUmlIMjUwTk5jeFBCUHh3WG9QOS94RXk1dDlvaHNveWY4NGNG?=
 =?utf-8?B?bm1BQ3phRFEvTFJsb3RBek5YY2RtdWJhZ1lFWFdtUG1WeVlSMzBVQUpJNStz?=
 =?utf-8?B?WUZyRlBvWDJVZmdvOGRVeUgzODNwV2c0dTVKRi9xYXV1b0dTNTlhUnRsTTBQ?=
 =?utf-8?B?ZEszL0t0dlcwS3ZWbmcwUG9mRWRDMEtsSkpXUUQ0M2FwZ1hDNm1kaitjSE9F?=
 =?utf-8?B?RjBIUGxEclFXYmFwcU45Q0Y0ekpvdjZpOU9scEZtZjVaMUh3eVB3OERMRVdv?=
 =?utf-8?B?dm9hajdoMlFnTk1LREpQbGxCOG92MllQOEpWU052MFBONmlWVUgwTC9GSTN5?=
 =?utf-8?B?enNZcG56SG9ZUzZUN09QVHliRFRoT3BjZUVWNUh0NmJINnB1Wml0c1ZNTnNE?=
 =?utf-8?B?cGk0Q3luS29HV0FSTUNDZng1TDlCd1lKQmtiL3NyYkh4aHpWakpTWUVWVHRy?=
 =?utf-8?B?SzBTL0VNdytuOUdndlFLOHJxaHBmK0V4bG5pcm1OU0VQMEkzenpENHRWWEp4?=
 =?utf-8?B?cSt3aUJjeUxjaFFaYkwzZk1sTG1ucm5yaXRjZnhzK3Naem1pTlRaeGJrWDBD?=
 =?utf-8?B?NHJ0TTY2TEpwMDk1Z0VoaVIvTlJPLzMzZDRNdEh6OXJYS25NcTNlSTU3ckQ2?=
 =?utf-8?B?T2QyYm5KOFBEL0VTa2FhK1NCZ2Y2YUdBM2NxWDNlTlJsSFY4Skc5T2p5WDA0?=
 =?utf-8?B?d3B1QjRRSXNEaFBsZWFQS2ZybC83VzNuWnNISXR1KzU3bEUxTGVjajJoR0RT?=
 =?utf-8?B?MXgzaVY3LzByNzJtS3gwZitTSHp5cWdPY05VbmJESHNxSzhDbzlURlVMWGtQ?=
 =?utf-8?B?VW5MLzBXdWhSa29UMVcvU0VtbDQwdEZxYlRSUk1wc1E0cHlkODR0V1V4M2Vs?=
 =?utf-8?B?RmRvUTVaN1JEcjFKK2oveVA0Tmp1WkgrSlhkMkwxZEY2UGcwZzc4Yzg0S1Zp?=
 =?utf-8?B?MTRyb2toY01KSUVqQVJXbVhQTGlHem1oNS9xS2hCTVFPdGNkNDFUTDdMdXVy?=
 =?utf-8?B?SnE5b3NwRkhpNTVVODFpS25pVzFDZyt1ancxZm5acitBMmxqSmRCMEZmeGNL?=
 =?utf-8?B?cDQzckF4NWZQL0tNS21uMXhIZWxSY3dCbTFjNWdHWXVtVytJNzdVNHl2WnZO?=
 =?utf-8?B?MWh2eFJmT2Z0cDljKzRYaUVHbWEwd0QzbzRFdDlMczE0TlYrMmt6SUFUV2Rs?=
 =?utf-8?B?ZW9PSUw5NE1TRnBsTnpZcVpOODcrMzEzRmtkTDN0TXRDY00rVFlrZ1NjUVls?=
 =?utf-8?B?Y1JEMHJVTk5aV2hjREJGNGRyL0J0VGYwTjYxMjIyeE5LSkl5ZVY3RkxaVjhD?=
 =?utf-8?B?YjcrQWNqMUtpZmpPcmRqTFBadG04U1EySERxanNuYUJUQUpCVUhhcEZVSWV0?=
 =?utf-8?B?dXExVGlDQyt0TFRCU01LU215ZFNlQi9UUFRiSlc3dkdiU2pJWllLc1FubWxM?=
 =?utf-8?B?WFMyc0hwUFppRHp4MFdONDl6RWZ1Y2VzSyttWEZkNG9uSmZsUmkwWHdmUEpj?=
 =?utf-8?B?TTJtSEFWNnZ0eVM3cGVZLzZQM2t1WUZRZktxR2psY3VFd2FCck9NU1FGZzZC?=
 =?utf-8?B?c25rQ1VVSWQrSmlrM1JnZUlidGxPd0JSWUk3UHEyUmltZFBJTmZZOGlIb1BD?=
 =?utf-8?B?ZDgxcGk0YkFnNVo5bW1rMmpmRnRuUVF2czZXcU1tVWkzNzNGcytJY1E4WW1t?=
 =?utf-8?B?bEZ5b29Jd2dlMkRNOXpvTG1SSENEOWJhY2NmYU5sWHZKdlVlTVduNmpWMFZm?=
 =?utf-8?B?cVY4M0VjK0dXck1zVmdBeXFVNHlTUDJ4NHJPWjAzQ29QRWZaSzZnSTJzUnR2?=
 =?utf-8?Q?APd0ie45L4pq8+MuRfOXs7siT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f7f02-3ede-40a5-426a-08dcf23712d9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 01:15:53.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ogtbV3Be01R4iiwKbWmy6PB60JKf6fhZv+xUBHDaviqHwj02eG7eDvN0m99oJTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

Hi Reinette,

On 10/21/2024 10:31 AM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/21/24 7:40 AM, Moger, Babu wrote:
>> On 10/18/24 10:59, Reinette Chatre wrote:
>>> On 10/17/24 3:56 PM, Moger, Babu wrote:
>>>> On 10/15/2024 10:25 PM, Reinette Chatre wrote:
>>>>> On 10/9/24 10:39 AM, Babu Moger wrote:
>>>
>>>>>> + */
>>>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>>>>> +{
>>>>>> +    int index = MBM_EVENT_ARRAY_INDEX(evtid);
>>>>>> +    int cntr_id = rdtgrp->mon.cntr_id[index];
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Allocate a new counter id to the event if the counter is not
>>>>>> +     * assigned already.
>>>>>> +     */
>>>>>> +    if (cntr_id == MON_CNTR_UNSET) {
>>>>>> +        cntr_id = mbm_cntr_alloc(r);
>>>>>> +        if (cntr_id < 0) {
>>>>>> +            rdt_last_cmd_puts("Out of MBM assignable counters\n");
>>>>>> +            return -ENOSPC;
>>>>>> +        }
>>>>>> +        rdtgrp->mon.cntr_id[index] = cntr_id;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!d) {
>>>>>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>>>>> +            ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>>>>> +                               rdtgrp->closid, cntr_id, true);
>>>>>> +            if (ret)
>>>>>> +                goto out_done_assign;
>>>>>> +
>>>>>> +            set_bit(cntr_id, d->mbm_cntr_map);
>>>>>
>>>>> The code pattern above is repeated four times in this work, twice in
>>>>> rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
>>>>> duplication should be avoided. It can be done in a function that also resets
>>>>> the architectural state.
>>>>
>>>> Are you suggesting to combine rdtgroup_assign_cntr_event() and rdtgroup_unassign_cntr_event()?
>>>
>>> No. My comment was about the following pattern that is repeated four times:
>>> 	...
>>> 	ret = resctrl_arch_config_cntr(...)
>>> 	if (ret)
>>> 		...
>>> 	set_bit()/clear_bit()
>>> 	...
>>>
>>
>> ok.
>>
>>
>>>> It can be done. We need a flag to tell if it is a assign or unassign.
>>>
>>> There is already a flag that is used by resctrl_arch_config_cntr(), the same parameters
>>> as resctrl_arch_config_cntr() can be used for a wrapper that just calls
>>> resctrl_arch_config_cntr() directly and uses that same flag to
>>> select between set_bit() and clear_bit(). This wrapper can then also include
>>> the reset of architectural state.
>>
>> ok. Got it, It will look like this.
>>
>>
>> +/*
>> + * Wrapper to configure the counter in a domain.
>> + */
> 
> Please replace comment with a description of what the function does.

sure.

> 
>> +static int rdtgroup_config_cntr(struct rdt_resource *r,struct
> 
> While it keeps being a challenge to get naming right I do think this
> can start by replacing "rdtgroup" with "resctrl" (specifically,
> "rdtgroup_config_cntr() -> resctrl_config_cntr()") because, as seen
> with the parameters passed, this has nothing to do with rdtgroup.

Sure.

> 
>> rdt_mon_domain *d,
>> +                               enum resctrl_event_id evtid, u32 rmid, u32
>> closid,
>> +                               u32 cntr_id, bool assign)
>> +{
>> +       int ret;
>> +
>> +       ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id,
>> assign);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (assign)
>> +               __set_bit(cntr_id, d->mbm_cntr_map);
>> +       else
>> +               __clear_bit(cntr_id, d->mbm_cntr_map);
>> +
>> +       /*
>> +        * Reset the architectural state so that reading of hardware
>> +        * counter is not considered as an overflow in next update.
>> +        */
>> +       resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
>> +
>> +       return ret;
>> +}
>> +
> 
> Yes, this looks good. Thank you.
> 

Thanks-
- Babu Moger

