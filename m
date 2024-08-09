Return-Path: <linux-kernel+bounces-281079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978794D2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76221C2089F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790E198836;
	Fri,  9 Aug 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ABlgA7WA"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550C197A65
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215568; cv=fail; b=Z9CbjvjT/sm76vpp8mh537kGlUQ/unqVcwSEBkaMtaNaIg1lb5Jk7v/b6eTbNlRLdCxnYSFjGwVHRXAJMg/5vCqAMod2RDZ9Z94w41+EQ8L+cEHtFFKz2qnjO7jznQTTQZh339ItL8Zj7MZorvdhyAsEYWoCDYs4XvtRRp6g23s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215568; c=relaxed/simple;
	bh=XV+PGHLy0cmaYGKuyG90qfAv+Oq4YuVhpR75rgzlnxE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qie4ebE604TUkHTPABR6trh89274FydhuY5CCZ0uaP/XAog6joYUkRvPuBFv39g17HOwk/YhXpMGcra+yTjcHs5PL6sL4Rpsir7v2pwaIrMOvZt5jw0r2xO2MkARcXBZPOPSyHA3f5HigrFvHIM7m4RAeZIQI9AvoTSp5ICCin0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ABlgA7WA; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knTYJFuqP5bH0G4Wto0ZXoUOg5UGVxt12QGahY/xcbBQ3VsbforsgrjsEoJ1v3cHiG+Xl4nKG7QFY5IwP6LYUXIt3XTf/966e++eLN5JKq4N4vQv9PMyMygK2JdN8gMfOPbs5pWWONdo/79aACPB3yBRhkwioaflrvFnn6kHZApg7I0ie7FK/BLPub/mIgWTniUy+JMtx22f+d4SmLS2FVETm9DHHvTQ61RpbN939VyD0LoRpN8ZRGej8g2WAl5yuujmao/hFvmYjL6NhfXs4Elnk9lyaU+0YP/dXUJDJNgHp4e2y4TmN587jFKvCexvdpmDv0G9KdmzeTpW+qb7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6y+WWE01ALzF8CeNHrZxq4hn1gENaeOzqbSbGYG8tg=;
 b=jGATL+WNQmEfh9zCLnuoZOgBWkv3IqBSO69T3nnYTafWchN40cCD+O6LFRqHub5MS9vNcND/hb3iNCHVNntbAsU116qk5Pxpny5b0nVv86dqFMk5Xi58HMXJ0RVUuupAfka4zW39sG7879I8GQKXjHZOKVj94m4eEgM5FbWQ3632onIuvCcXFrG0VK3OFijUyDN2ZJgTDSLcAQLV5ucZzz5iF1vPAlufoVphNm9CAoH/nonIdu1FcSMZu7bMAfgr44nBECXR9kZgYo5uIBGlBJ1VoIGj+C9Mj0iQDk+QKUMD0lsB0DUz+ePH80Ze7nC6Wm5efgtsfeq11JDZOD0cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6y+WWE01ALzF8CeNHrZxq4hn1gENaeOzqbSbGYG8tg=;
 b=ABlgA7WAJMDJlDUEepOYJE1VuPDsHIK4DPPIjIaxWBAf2EWfAf6UA+SH9Kvt0tOneZ5aA8/KKPZV03Ju757HzRva/y4L+NQyVwOtJtsmgS9vy//qfPkeA24vSPU/gWikXZ6UpdpOQlVka/j9sIZHstp43VRm4yKdqZSgjYeHS0b2bksW5aaaLclxh+lyxkbWL4ScRQrODcPZFZ6cWLtvxPSYHdSa/7He15zfWdId1ADBl24xgefWnD/CyzpRULiz259qfUPQvhZawTOhbZ3TanJsv+oNrb9MoHH+EEVjcsk5p6a2BMTUDzkSWc3R+Jjiy4dtSRghr0eZFnsIjE6x1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:59:18 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:59:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yang Shi <shy828301@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 0/3] do_numa_page(),do_huge_pmd_numa_page() fix and cleanup
Date: Fri,  9 Aug 2024 10:59:03 -0400
Message-ID: <20240809145906.1513458-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 5509dc82-5cd5-46a3-8739-08dcb883d7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWguXBoksF4bMgUdEBbwARaIb8PfBR2Jef2806wBFg/ZHsyEZdOkwbucnMPK?=
 =?us-ascii?Q?kT0QZoWAI8EtwRQHHIN+HKSoPPmZmrD4lyqXJnOcjkgaq7mDjfFI6twETII+?=
 =?us-ascii?Q?hMzF3j0zMd+DvX/BEqtpIlUxdxrEIA76l+FsF1Jo2JBaK7SircdQAiIhHAFX?=
 =?us-ascii?Q?R2VEUy06p13WGflkPUwUiemDWkS7wGoana1jTaOblddOc6UsalP6FwXVJIPj?=
 =?us-ascii?Q?q2IaELMAYXvv8lERs7JgVaoa2ZvDDPKOSI0enMrBTP8oExl/2RZ/6h+Scuqi?=
 =?us-ascii?Q?Z0zBfyR3LkmsMRH604JoYI7dOwQ6TkigCyujJDn2VaiKWtZL1Rf5TTpfweMU?=
 =?us-ascii?Q?AR3+N6BCJIbYENh2JdSTrIBysudEvYPwDPmE5PCqXd2w3ed4Pw2YrjHiB4MO?=
 =?us-ascii?Q?YLV+GR8Vc7j0oqzKmMObiCjYT37m9S8x0HpzC4EKPtDieBEzXAP6mz18prmZ?=
 =?us-ascii?Q?yc5j6j9OvbfC3pG/SjsBlmamM+M0zA6rtt8YaqcaTV/8qa2ImCNJz+qonZOl?=
 =?us-ascii?Q?qPg4AOCeeBz0Ma234cm2tDhIrq3VLzu9D4TjdHAoeV6Llz+9JmLAbGVtlcb8?=
 =?us-ascii?Q?WsdhAX6U1BMYFTUy40MtRUe/Zc5ufWjUqMp0/Tdy63TKd22OrryY0Rb5VBXy?=
 =?us-ascii?Q?ZYLwU4wxTcb0QzxoGEeqdV+fbRGLwSrdwfVbSTuTZq7nFsgs2/l+NMMG9n8K?=
 =?us-ascii?Q?ZJxAMwlhHKc5AcsXxRUTTFFeNHfEo8EHCR4r+PJTw3oRbwmFoBCn76LghRrP?=
 =?us-ascii?Q?FjWFs+Uw6qxRIsLSHGrxgzfT4XSjFho4w7WADOVoHezsifZj1FKW1GP9dpR5?=
 =?us-ascii?Q?poJ4U5E9Ct3nOUTaq4rEhKzoyUhWsMxrug0sl+Gt+OMKEAYbnaX290MISwFP?=
 =?us-ascii?Q?tRiDwNA2vB9gK5JDyLW5FGjOppTdLgs+s3Fyp6E1pPjcr91XZdeES4AjgNzj?=
 =?us-ascii?Q?b3ZZ+jNMksZ9C05uNIAo5LooKhGiBSkk5ugPUWrb1erW7MltOfvh2hIm+YTA?=
 =?us-ascii?Q?SzHg5GxEsaGhSgxXRYB2wSUvJs/L7B3njXZV2GKWZqqazThi9WEqqp5V0SZV?=
 =?us-ascii?Q?kWhmMATD8NQTiWLR5CU/KhFpRQp89LyINOzS8CH8Fadj4r3JW2c3Vwu1H6md?=
 =?us-ascii?Q?3bbTIWppfmq8TIjrqoVxdxjOthBETkeE4laI2rR7ujed3cDb36nOtl7duu2+?=
 =?us-ascii?Q?4QWUyypMS1R8q34+GDwEQw6uoQhIgWYnsT+Z+VPRSZAlSCVDQReFgkPzoYwr?=
 =?us-ascii?Q?Sqi0mxNV52VXIPaXCSlIHQ5Jh83ED0GOniEwmQpQNN8Z3sPARxmoTrX1bls0?=
 =?us-ascii?Q?zrKFMMqPSHXCwTCqZVLNpu3ilUuqf8regi9PWqDjF3QEFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eWvAiC0lWaXQ5RVortu1on1rOeSUdeYwFXoySMvmdIj7JED8ClxWLoNkeNo?=
 =?us-ascii?Q?YyItAeEzMMsBOU01OIuNP6QYsnnoIRLzpRNeSQkhv8ACXQpLePic82W2vl/A?=
 =?us-ascii?Q?CZdQkfipGWsrVMUHqd5Uysvfzh9iPRdzfPZGbckDwRuGS/Mfjhwyg2WUbTVl?=
 =?us-ascii?Q?Ay98XRoAHRuQwj2UxkkuoUaW7t3Aqxv1n4afUVRZnobuSb41PSi6cC89WFwe?=
 =?us-ascii?Q?eXJv6JnP4ptLZlU6vLG6sy5uCditDvJeD5dIHNd2GLB2NGf1BU1UeudAfTAr?=
 =?us-ascii?Q?32Bjpy7LIYuoMV07ch1DkP7924qmvuNPMcur/xTbyoljBRXbbrLKyi12wstF?=
 =?us-ascii?Q?TbW783WRu3l0siPdWYBWeO6qvhDpuOlMIWuCY9gp763wItj9lDDwmLIOLMAP?=
 =?us-ascii?Q?HemqGFsIH/yW0wasEOGoh7sP3UEEyQo1WJIJ5Vr+ySDphBxOR/t0onKGs2Pl?=
 =?us-ascii?Q?JwYDvHPG2I/U01FspwYT1wEQsJUWKysKd9RPG9MxOhCpIpWPnuburmbSppLf?=
 =?us-ascii?Q?tQG96618U7J1yMrXOne7edwp6wbOvzsrGIeqjIr3IC+QExLvzCEvX6tmQcN2?=
 =?us-ascii?Q?kS8EWLf0KUj/aYLyvyEgEeb2rI4wdwHWj0fMKsP36FAIzxNN14fE1Z82ugfw?=
 =?us-ascii?Q?Uv134LnUTAHHRHAYH6ZXQawRekHEaVdccXIecUnmbV3iHruJAJnOfMGIngrL?=
 =?us-ascii?Q?9aTJkWuGNBV3rjuHof0h/qHMcjxuiZX+oplNUZF8CqHwf8EwfwDuA35MtFxC?=
 =?us-ascii?Q?9W+7edt/5Rl70hB1k2eUsfjWRmvhlGX1jqhg8oKLY1iVs6HZ0yegVrC0E5oo?=
 =?us-ascii?Q?EWlg9CtXJ/J+NYUVv06zP8vZlHwUIrE1lSA/5+7BFlPHMm7DCp9v1xngOKrG?=
 =?us-ascii?Q?VWegIjX70sFBX8/AiVItIHjmT77+qr1+zcXPq9f0JkdC8PL7Vox+9Gdnk+8X?=
 =?us-ascii?Q?TIV0iv3wbFTnWRzVZbuDuUPmZK4qeLrPJv/xZkwESDKJpUNekMDj5meo2QES?=
 =?us-ascii?Q?eTk8zrfIuY+G+NztAS0+flb43Rgub+dYoUqFcHxsVsKPPCthfaYwwT7FIRZq?=
 =?us-ascii?Q?ptv4/bDeBVD7k2DtIDLgDSIjmox+TKLMcAMsI1u2AI77/QBa6e4fPSVZci8Y?=
 =?us-ascii?Q?B1sBIwHnXqiHZMR5lmmhrsAsNzoSp2vFhTOQ/K66zJAkb+AfbBxPvUXjhNyE?=
 =?us-ascii?Q?JTCmd+Qnj4wMoubRdFGVcCtEbiC4OXOnsUJO9tsTHoqXlxJlXiX+LfZ1ZaUK?=
 =?us-ascii?Q?Om+UX/9mIpO8k2jWC0xqWpHvBVTcq0gSb4JFktRNhTbkAEw6AdssNOcd/Nwr?=
 =?us-ascii?Q?48rT4qPG4e2YBlssDcyABF4D74Q5x3wOodDibOuTf1aZxa8Pfs9dMDzm4w71?=
 =?us-ascii?Q?FilwYF+3GpsdxN/l/KAE/6jk7mJgHXwTTJsP3d+xpXtCnvPAF/3+5fGRH39x?=
 =?us-ascii?Q?hsnjrri4NRWkYDLXQOSzXjHkthW5Wfon68YBmAswD8F2zSehtRuG6CLYcEME?=
 =?us-ascii?Q?U5Xd8Rcd2y4/jt31i90YHCodBH5y4y+Yx9L7dE1vqukc5Q5WJ//P1b04+COv?=
 =?us-ascii?Q?m29bK/y2vqQnmc6fkd0acHY4BfnEmcKS7HZA079k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5509dc82-5cd5-46a3-8739-08dcb883d7bf
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:59:18.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GGGzGoJWV/xSbAEhZo3w9UAxvWSpyLfaDXMmwO23B5TwFHpmjakUNWtaYbRVomW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

Changes from v1[1] and v2(Patch 2 only)[2]
===
1. Patch 1: Separated do_numa_page() and do_huge_pmd_numa_page() fixes,
since the issues are introduced by two separate commits.

2. Patch 1: Moved migration failure branch code and called task_numa_fault()
and return immediately when migration succeedds. (per Huang, Ying)

3. Patch 2: change do_huge_pmd_numa_page() to match do_numa_page() in
terms of page table entry manipulation (per Huang, Ying)

4. Patch 1: Restructured the code (per Kefeng Wang)

5. Patch 1: Returned immediately when page table entries do not match instead
of using goto (per David Hildenbrand)

[1] https://lore.kernel.org/lkml/20240807184730.1266736-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20240808233728.1477034-1-ziy@nvidia.com/

Zi Yan (3):
  mm/numa: no task_numa_fault() call if PTE is changed
  mm/numa: no task_numa_fault() call if PMD is changed
  mm/migrate: move common code to numa_migrate_check (was
    numa_migrate_prep)

 mm/huge_memory.c | 56 ++++++++++++----------------
 mm/internal.h    |  5 ++-
 mm/memory.c      | 96 ++++++++++++++++++++++++------------------------
 3 files changed, 75 insertions(+), 82 deletions(-)

-- 
2.43.0


