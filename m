Return-Path: <linux-kernel+bounces-245152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2492AF06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B5D1F22B60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160C7D07F;
	Tue,  9 Jul 2024 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QWOGnxNQ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEA620
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498899; cv=fail; b=VR7hLwr2ZVVuSd381km0AdXUPYiC+M03JwQLMZKt/Dq0cMHDwKEJ4ucfTcJFYNrTj9XV5zLPQGDE5xQEee3qCBiMEAUVCaPkvu5Nr1aoaBBe+iHcuK72F8AhGkgirRLJBZjKDkRYvFf5N2WXtYIq6w8/QPzUuqJdRjj1AEKOY/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498899; c=relaxed/simple;
	bh=qPdgOgXmJYu5vfj3sBGmjcOSkQOa7tKFMdJosSvh1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NNAPddsW9pBl8JH/KVp2+V0eciY85Px4Oea2idKrbDznjUEdhTy/2m2ED86bzN0KIqel7e5JPg8jmvuq8pBxisjJzoHpD7TF92pQoCiQ1XZmPelmxfNQxGSaOn3cF0X/VgUHM5h7NT6qkfylMd51/UUKd6g/TPtoJJj8am8lgKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QWOGnxNQ; arc=fail smtp.client-ip=40.107.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVkeppecGHHnORZbLggEQCpzVp7GEOWbf1x1lf+stwNleegDs9mxcHD+Agj9dKKRc7N/P5V1OKTeqCFPC6SbpRy24Tq1A9IS/T/THiZeZwV8R+MKjjnEOJznhB93Uo7GbxUxnDa/Bd8idfghRaJw6OXC6EpGl5ibnQO/XiwRpCuemEGiMrXkq9JEWDVxgK6cB3ao23VMDOC0lx2ESJC/1zWViJisuDpXtGGB8re7CKODfwqA0w9DUAjLNikH1lea3no8wOwPLDapFZT9khTlEv/QSF7zrjFS4fgQlLhfhTJJaBkqS3uko+hN0BeoE8Buw2sUBXsMXCXXxI+w/CFwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94uj5Y64TKVoFfTVdzfJcheo7yfz+Asj1b4wLaQMycQ=;
 b=RiV1zqZqsKJgBurcPJI9jraUwAgOWEVqaWacmej7QSugjsqbuzXW3V4wnSO0WLoyYo7AK56fXxb6bHvn4kfWjNhGOdHgWrp4S3UbZtDYjGHqgVx62B7MTMowDgBR6k7j6DCPcgqaU0Cp4OC+m52snKayio9H1wkitM3uAfKTvAXl3Rwzjz+jNB4X80KI9SDMs19oZFEdT+JTmtUQ6PvBvRgIltC+61zH1GWz03Q4qpXjEyG6WriOGUNFtOs0ewhw+1xGuR+ZoXiF/TyYUmWdFeEloxyEdD90RTxNlaMezJs338/jsWDpUzZyy42GeldgI8EYnEHa41m4U7G/ADjjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94uj5Y64TKVoFfTVdzfJcheo7yfz+Asj1b4wLaQMycQ=;
 b=QWOGnxNQ85qEkz2d+E8uJsIkmuc/9Pmp1oM/D6HAQEjJ6Oe3sgvqeN6LcJW+J1rJZA1BJyuutSJnVEloT9Qd5TULaGt0qCTRw41y/z0w+XhW1G24l5iVhxRc78QkSWsU7spLDMMar3eY3kdGxG3nKjKcAt4OsX+u/NzxoGAyQNS7rD1/Fm9nz7iKMTRbLTBJNugjC/0m0ByBF4PxUzNxNHuAM9GYJAakwegs0rUmDGJfpqXHIuBoRfjuf/owapGdPftyGFmrIDHgxNHNifjsOu8wzGU3mRoT8BWsePt0NYOidpZECoJs/oqc78bWnAjrOGyleiGj5t6xgoCZRTEHMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:21:30 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:21:31 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v6] mm: shrink skip folio mapped by an exiting process
Date: Tue,  9 Jul 2024 12:21:22 +0800
Message-ID: <20240709042122.631-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3644e0-3d01-4720-56e7-08dc9fce9c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PNQzNdFd21Az+c/r9/Rm51nYp4YAZmx7HGrqg1DQXz+9R56tGsoHBjGTcTww?=
 =?us-ascii?Q?FijtzlPQSxYapnxRYMZE9VaPbi6yy+CldMrg7t8zB3T8FEAcWmovBygoIfW3?=
 =?us-ascii?Q?7zd4DKJt9nKUB8ztNsNeRFV12Vf7qxSO/7FpUKMFZcUD2hB9sgZLMQPrqJO9?=
 =?us-ascii?Q?GV+kXykZs4VNFPzNLnk5sgu2vUr2uw9CHasO2wTqCdE2vLYLmMdcCf9LpscZ?=
 =?us-ascii?Q?O3VBEqu74w37O0h6qNiRKG+3C3PwizUS3DafmyDdPtnz25GKVNscrgrUBZTs?=
 =?us-ascii?Q?zT/NgiC5lFxWk0gfMLhx1eZlcSpOTD+CuZg461J58jh+k7fPQ/z8UUt3j0vJ?=
 =?us-ascii?Q?Jq68kMM+R9y7RLDbXMfxYqbb/9E7djf/E8qxzlJLpj22HUTi8nZl8rsDg7gc?=
 =?us-ascii?Q?CMT84uKxtKAkAlxUjjOPYC6TyOlH5kuEB44gvtTb+KYQDtdY0NoYM8NzKcqZ?=
 =?us-ascii?Q?uTwHIjOm/1vwEXftnpHHkd01BiOfbmg3tWFB7gGnSVRO1rJzPsu/YSHDPgCh?=
 =?us-ascii?Q?tYLarMx+mPhTagUg2y/7A48TrfKXGGfoMjpE/ZD8fqrWrL5yJ2W/rfpWYqcG?=
 =?us-ascii?Q?9OD8H4+PDSzemS0SMs+SoK55geObJro3cVRJ0I4eyi7CWxJBed5pvS2O6fjM?=
 =?us-ascii?Q?Ea+G71fU0V+JgOpB0KiEmP6FYpr9J3N8RH3iThyvze9mFe7s8w7SgXn2qTE8?=
 =?us-ascii?Q?yVsO+oNkxf64QtnXsFuPjj7JtdpjnPAuX8RtDXI7njoWvMknhhEq8azJ7Ad9?=
 =?us-ascii?Q?SDAN/a7sgEef7co8GCBMJeWnwVYbftuKZLtMc1ValteG50PvCjiQtaCCjAug?=
 =?us-ascii?Q?alSOifnpwjwgNbAbJ+QkG7sKQM6AHHXs06bGPkwlmsAzrq22PLHiTFIj3pN/?=
 =?us-ascii?Q?W17psmlLWTqvSdDZDmrUpMRZ215hi1kiSqwkMZszD8JO2xTXCDrMko+Nc3AX?=
 =?us-ascii?Q?VrEFCjNQqkf9vF5oRdiXqH7EV0/RDaVDx3XTVweWGFqnd/t6MxCqJoLEmMnn?=
 =?us-ascii?Q?gTpufeVC/lDbY/qWINyoaJGOAyyNDB0kmpKO01wED9Tt8Ya0bBTP7wSLjinP?=
 =?us-ascii?Q?C4QLc6DeIFLPLwbfYZAZdtk6DHBSE9/EQJ3UO1CixNbvxXp3zt45kqzChqPN?=
 =?us-ascii?Q?aOLAmhRseDWRcgMWanYUa7v7YeVxxMIe6aesEhju/mdRR8OMC2OLLEqwoulK?=
 =?us-ascii?Q?6X+Ug22Uh2tlgTLZ5V5mQhSHl9+nNO3MfQH7Q8mXxf1oyspdTOlWwIcQ8Qjp?=
 =?us-ascii?Q?zCjoYzQwegO8nBfN3PV7FWTU/HLYUur1EGjn+/LeOKIYvCvA2YE+MlAo2AGh?=
 =?us-ascii?Q?JKBFTnQMTA7A14StoA78O5GcglGLH2r+YARm+FhUcuQ377+TrG9MEY9PlyVL?=
 =?us-ascii?Q?Lh3Ug2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yb4oYsdGCWI09bDd9+RS63bpoPV7looBRgG1iHo01vj2s7/dmMFjUOwliMko?=
 =?us-ascii?Q?vGWqmfhoNJ9+Ow20WVJrdlsnTuRI/zY7LmmRl8YykFn26WhSwE8Okpw+oW6m?=
 =?us-ascii?Q?Lhmn0rAJP19CreAJwaDFLi8+iT+hlq9jVirueKr2Vt6byyyuz7l5WC5LiiAz?=
 =?us-ascii?Q?b3lCk6LTyYv5/Ze3PbRobPE2G2fAe33wTv2+lA+cl1afhELjeCeMrvzWWTn4?=
 =?us-ascii?Q?V3Hdzcazcphkt9afmS4Q5AQwOz+fA3dgzgBkgs8iwIqgpC0Vs8o970PL+tnt?=
 =?us-ascii?Q?3jqkLm4tMf/RBFMMFPZt0HbR5MvyXUhVL+Hr44wo/jRvsa/z5zt7bpzxvqlM?=
 =?us-ascii?Q?KW8XEErr1en3e6xik6soFJLCeUvupvjcxHyKbp+9bYHRe7iRHHwhh3YvbVSS?=
 =?us-ascii?Q?1fCt3UUUCIdeRm73x8ZpOuJPiVO/Oha5ZyqdJ+0qgV892vmm2tkx9PFJq8Lw?=
 =?us-ascii?Q?IG06IUywg85Z5VAnhuam2h5a3TJvTETkqujn0FFoOIx7Uyk+ricuOQQ64j8P?=
 =?us-ascii?Q?bY3vXA0jy0AjiF7JLW4dp2eeNxUeTBQK3HAdt8iDNh2pw7WqhzpWu+7jucHi?=
 =?us-ascii?Q?K90vOWKrBZAS/eS7soU04CEa9AuB87oGVUARGGc2cbBk5yJoiiRGBn18spwf?=
 =?us-ascii?Q?wQy1M2HNeiLJ7cScsBwwazu8QUgrms8CYO8j5QH8PbRK8pyxFD2//FK6bfYN?=
 =?us-ascii?Q?YS11WqL0YpuTPdxrse4JK+leOkw5g3Egg+aIrTNEZwxmEFSEMeC1khXJZX3w?=
 =?us-ascii?Q?F3d0cHPhVXqqPWLwUkN1Z6qGPJZrBkfEsi59pqC/8PJIJjAXHraFEx2y6Bp7?=
 =?us-ascii?Q?TyjAftPy/fX9c3UQhj04EcoGwzqD2UUz78KGp3Zdb9iTepeB52d6Z0xiXF4c?=
 =?us-ascii?Q?77lWQ/BFO2IE2F8f3SsDKJG7/R+lg2AX+VpZFVXL6dEinp+vEa2rNPop/7f7?=
 =?us-ascii?Q?51EDcVNucr+BDWUxw035RNlHwVdrQHjA384f1H8I7vG8lABfde46HIdVj9qT?=
 =?us-ascii?Q?L1owdMGbP+28sJW/EbSCo2k+vDZYc/e3LuC+h27bz0eEDrHpw0mcUhtExjJ8?=
 =?us-ascii?Q?aZn/z0mrN6jr2C/WY5bJbrJPha/Nge5MuOSsYq9WIuPIUywyBMhlYp42QTcf?=
 =?us-ascii?Q?LH+jW2g3q8qnO5DddDt6cO8JpHIFP4GhZ46uN7yLTm20NnY4r769SjMD5hIN?=
 =?us-ascii?Q?K9nwfL85zDxPg8Px0Nos8fntGkyE8DrpjboDSXg2KARQAZwQb/l8knjMK0Gt?=
 =?us-ascii?Q?lWX7T/csjLtvnMKFKCqorFkxXTSj3U5kzR0gThleaxLIqRpgidA6RqP/N+qx?=
 =?us-ascii?Q?l95jpUobCCcrWkxKjICjvEQMXJXdHDGlR9qmSP6IzjOFtl5Q7cTjrpMbjrbm?=
 =?us-ascii?Q?GmMLQXM4pMjv6EU96+ZAFd8n7p8JM7lgXiAOeSjECv2RnJf1RsVcLCeyE/Fy?=
 =?us-ascii?Q?L3T+EUIRcXMigeLKGvBWKQtqoQLWg+WxxQH9WPaxBNAe+yZKTKDPDePLgm2Y?=
 =?us-ascii?Q?A6Yhh4ttBldwJQGVdKnsE2nTmU7S3YD977PKMVHBNI3s7aa3pyYe0yFPzdnb?=
 =?us-ascii?Q?wJJMbBD/LMpZCmssdmhxifdcXF7wh0phx4VHw/GE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3644e0-3d01-4720-56e7-08dc9fce9c20
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:21:31.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI+j0nfJWkkRSj3sxGN4tNoUFb4tRtkf+rfTU+vuMmGu6i8rB30eSp9l6ssBCWZDbaW+NU4iiWG+isyWAkPZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602

The releasing process of the non-shared anonymous folio mapped solely by
an exiting process may go through two flows: 1) the anonymous folio is
firstly is swaped-out into swapspace and transformed into a swp_entry
in shrink_folio_list; 2) then the swp_entry is released in the process
exiting flow. This will result in the high cpu load of releasing a
non-shared anonymous folio mapped solely by an exiting process.

When the low system memory and the exiting process exist at the same
time, it will be likely to happen, because the non-shared anonymous
folio mapped solely by an exiting process may be reclaimed by
shrink_folio_list.

This patch is that shrink skips the non-shared anonymous folio solely
mapped by an exting process and this folio is only released directly in
the process exiting flow, which will save swap-out time and alleviate
the load of the process exiting. 

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Change log:
v5->v6:
1.Move folio_likely_mapped_shared() under the PTL.
2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
3.Remove folio_test_anon(folio).
v4->v5:
1.Further modify to skip non-shared anonymous folio only.
2.Update comments for pra->referenced = -1.
v3->v4:
1.Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.


Comments from participants and my responses:
[v5->v6]:
1.David Hildenbrand <david@redhat.com>
I'm currently working on moving all folio_likely_mapped_shared() under
the PTL, where we are then sure that the folio is actually mapped by
this process (e.g., no concurrent unmapping poisslbe). Can we do the
same here directly? 
-->
You are right. we might use page_vma_mapped_walk_done() to bail out.
(Barry Song)

2.Barry Song <baohua@kernel.org>
By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
automatically has MMF_OOM_SKIP. What is the purpose of this check?
Is there a better way to determine if a process is an OOM target?
What about check_stable_address_space() ?
-->
Sorry, I overlook the situation with if (is_global_init(p)),
MMF_OOM_SKIP is indeed not suitable. It seems feasible for
check_stable_address_space() replacing MMF_OOM_SKIP.
check_stable_address_space() can indicate oom kill, and
!atomic_read(&vma->vm_mm->mm_users) can indicate the normal
process exiting. 

I also think we actually can remove "folio_test_anon(folio)".
-->
Yes, update in patch v6.

[v4->v5]:
1.Barry Song <baohua@kernel.org>
I don't think this is correct. folio_likely_mapped_shared() is almost
"correct" but not always.
Please explain why you set  pra->referenced =  -1. Please address all
comments before you send a new version.
-->
Update in patch v5.

2.Matthew Wilcox <willy@infradead.org>
How is the file folio similar?  File folios are never written to swap,
and they'll be written back from the page cache whenever the filesystem
decides it's a good time to do so.
-->
What do you mean is that the file folio will not have any relevant
identifier left in memory after it is reclamed in the shrink flow,
and it will not be released again during an exiting process? If that's
the case, I think we only need the anon folio is skipped here. 

[v3->v4]:
1.Barry Song <baohua@kernel.org>
This is clearly version 3, as you previously sent version 2, correct?
-->
Yes.

Could you please describe the specific impact on users, including user
experience and power consumption? How serious is this problem?
-->
At present, I do not have a suitable method to accurately measure the
optimization benefit datas of this modifications, but I believe it
theoretically has some benefits.
Launching large memory app (for example, starting the camera) in multiple
backend scenes may result in the high cpu load of the exiting processes. 

Applications?
-->
Yes, when system is low memory, it more likely to occur.

I'm not completely convinced this patch is correct, but it appears to be
heading in the right direction. Therefore, I expect to see new versions
rather than it being dead.
You changed the file mode to 755, which is incorrect.
-->
Solved.

Why use -1? Is this meant to simulate lock contention to keep the folio
without activating it? Please do have some comments to explain why.
I'm not convinced this change is appropriate for shared folios. It seems
more suitable for exclusive folios used solely by the exiting process.
-->
The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
the folios will be freed soon in the exiting process flow.
Yes, the shared folios can not be simply skipped. I have made relevant
modifications in patch v4 and please help to further review.
https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/

2.David Hildenbrand <david@redhat.com>
but what if it is shared among multiple processes and only one of them
is exiting?
-->
Modify to skip only the non-shared anonymous folio mapped solely
by an exiting process in next version v4.

[v2->v3:]
Nothing.

[v1->v2]:
1.Matthew Wilcox <willy@infradead.org>
What testing have you done of this patch?  How often does it happen?
Are there particular workloads that benefit from this?  (I'm not sure
what "mutil backed-applications" are?)
And I do mean specifically of this patch, because to my eyes it
shouldn't even compile. Except on 32-bit where it'll say "warning:
integer constant out of range".
-->
Yes, I have tested. When the low system memory and the exiting process
exist at the same time, it will happen. This modification can alleviate
the load of the exiting process. 
"mutil backed-applications" means that there are a large number of
the backend applications in the system.
The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

 mm/rmap.c   | 14 ++++++++++++++
 mm/vmscan.c |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 88156deb46a6..d8ecb918e59e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio,
 			continue;
 		}
 
+		/*
+		 * Skip the non-shared swapbacked folio mapped solely by
+		 * the exiting or OOM-reaped process. This avoids redundant
+		 * swap-out followed by an immediate unmap.
+		 */
+		if ((!atomic_read(&vma->vm_mm->mm_users) ||
+			check_stable_address_space(vma->vm_mm)) &&
+			folio_test_swapbacked(folio) &&
+			!folio_likely_mapped_shared(folio)) {
+			pra->referenced = -1;
+			page_vma_mapped_walk_done(&pvmw);
+			return false;
+		}
+
 		if (pvmw.pte) {
 			if (lru_gen_enabled() &&
 			    pte_young(ptep_get(pvmw.pte))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80f9a486cf27..1d5f78a3dbeb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
 	if (vm_flags & VM_LOCKED)
 		return FOLIOREF_ACTIVATE;
 
-	/* rmap lock contention: rotate */
+	/*
+	 * There are two cases to consider.
+	 * 1) Rmap lock contention: rotate.
+	 * 2) Skip the non-shared swapbacked folio mapped solely by
+	 *    the exiting or OOM-reaped process.
+	 */
 	if (referenced_ptes == -1)
 		return FOLIOREF_KEEP;
 
-- 
2.39.0


