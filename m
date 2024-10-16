Return-Path: <linux-kernel+bounces-368706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265F19A13B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67D01C2175C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532F2141B9;
	Wed, 16 Oct 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HZvHnBoK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874521E3C2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110170; cv=fail; b=LSKsov5YLgW0kTPDJ25cYpAS6WyJ9eTOpfZxhc2Skj5mfV+ACKPodGm6+Xop1pkxY0qJTuAUvNGhTUYj8Et2KXuQQdD0HIDieVJn1+xwsGBw9+mGGR34c2rE//yH9GT/H9ZFg6XE48d71MsOSqJpGOsWRPHI1ke8LVs15HcDD/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110170; c=relaxed/simple;
	bh=n1WCPZeNroVIQYzUVqPNn9bsg3BWkPT/0AduH0cHQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zvq3v94zDfzlajggQCv6C5TJmKWmwtM7sMV9NLaL7IxIMCKVOOpFTrzDpzfTzm+qDhIelEv6PI2dF3NkHH5ZJRPqAsmUikrPf5Qxz2pH1UNMnNHYRAjpIJtJKcQQtJzCXvZ1EHjOei/W0JVnT1LBQFNMbVybg7AFKynNexIJppQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HZvHnBoK; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkMyPVCSznKtCF8TgIy9XdwUdz9FA9/XPoBBUsmq2SC8ZpYZaMCbm5vFkAesiRmyEk05VZ7ljxc4gTbLxYAExzaxAk5EsLkGw7uNWGwZxqFEKoTtM7NLwkzNDqbN/AEmbbqAMvvUZ6zFsOGtu0Fd/BGEa/VOmH+y6CbGSi1ryI2iKCJ5Or8Fu3UKnPufmbi57izbxVlEcRIZoOFSFdPf4iQQqB/B6A5QdAD5v8tyOEbHp6iLEN1l0RNUn6nvn7BZW54ZiWiafl/Sv9wdIAOyTWV75UB9n6sTdGVuRvTbl3xhJZ+q9L5bXF/DGMEupRAPF6lxTM/7YHse+Nb7LwRDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfYFb1Zfu310SHf6hyaRs/ssZFI/tl+Loje/mHs5xWY=;
 b=VKE4s7swDWt6whwv4Q1DfGUHkyWoePP+nHuj7foWEEGHZsgyVCIuoLrLWR4N4yUEa9Qkqvpxe9Uys/m7HyWhsqyVaS1vbl9QWvOBMt+z1bEa4qPmnKzNhSkJ0r1TDLp3m4ZIFrGiuO6WGePla6thvquVW560vGQqDky1OHuSr6Ws6123oyCFfnaIrl/Wg2qGmONIOSvT5RdFeCIgVDtoX6cw2lSPvEd22r7CO5prwkMLxBvkVwwbT4hDDrDOUnsI18orS/bQVF2qPg7ztpTqju5ePPn4762cpy0nlIkhkfdxXfI1CTlLk0botjXgDdEdxOFwYuxAuG6bprS7ktUnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfYFb1Zfu310SHf6hyaRs/ssZFI/tl+Loje/mHs5xWY=;
 b=HZvHnBoKjxBa34Zl+Tpjku+WvbeQNTjCtzzLfDsJ1Fa0s4u9ccHrd+cMw7Q6zvpdq6eU+5E1mKk8Z0BEwbaLcYxPAYTSPPcngPs4U3aF7rbLBty6vHVpc2i0DcoNs5CJSegBehD3EEr334e0ekggBECJYGTgbr98TvmXOw5YObi8d5s2MKSF1fOd24y2igSBtHb7aWJ2z/mowfmGLxRgDsmgEQaGRDyHer2zGoSKRk3l2V+XKzn47tQi/EvngMcSCp3DKNY/fkins2MCeR+AEwhoaceYgot0UrQFXyuLrqeqo6YuQ8Te73LnWwEr8pPwiZbeDyGCc03ekutMRkgUsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Wed, 16 Oct
 2024 20:22:45 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:22:44 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] mm/gup: stop leaking pinned pages in low memory conditions
Date: Wed, 16 Oct 2024 13:22:42 -0700
Message-ID: <20241016202242.456953-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9176744a-41b2-40fc-2f4f-08dcee204b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yETHfsoPCa5FYtx+/He7Bo54DlADsGUH5mMSakNq1JE8qxkPdmBKJyg4GmlF?=
 =?us-ascii?Q?prZYiu+i3UZ+nKu/Drxs0KpHcKHT+PMEq2lR1NLBRAviIlq6wDig6Y483mdc?=
 =?us-ascii?Q?JqgGTJ3Uua6QlUZS/NILunrRqA/OGjaclsTMtrqz4nUzNKINk1ytDAHoZLsr?=
 =?us-ascii?Q?sFLbZL/cENtsy8lUc98gA4kMhTFjVx4r8qMAd0vu5gx5Gy+jQKx7hWZD0Mbp?=
 =?us-ascii?Q?o19fjPrwgdGE6/zP9DcS1i7Ut8UNVP/UdBtLlZ0PyXyGIk01r6TwqU+30Pkz?=
 =?us-ascii?Q?XSUT/n34CVp5uDFKkl1m/BqEjzkdQ6ZxSydID6Cy7v2jBD9ajAufYk4M/qiZ?=
 =?us-ascii?Q?Y9xfeoo7f2ymhKhQeQmDBwkwXMCj4OJYc2C5auBSp7bf8dOOkjulVpkpZZcP?=
 =?us-ascii?Q?nKLXKlkkSkBmjipM35epBJu4I1JKdoIt680E12IhulLE1LCQsIHMuWMr87Ya?=
 =?us-ascii?Q?4/QgT4R6p0eZsBHUDoszgpH7eMfMgNitYLfRlNdnJb5BZihyx4KDJBxuaoT3?=
 =?us-ascii?Q?AmcDXIxbvOBuqJs5JfZgxKBhDC98qgt1eYSzoVIwfI+zZgfhqUUYf/Aht+mL?=
 =?us-ascii?Q?w5Uxm5m5E3X0HtPZTXw/gxx8ADFd7PoYUHR0W6uzGzDDMUCnqvo6TVlVVjpJ?=
 =?us-ascii?Q?RBpBVHfb55qa0rIvIKgvjv/WOfrJofn6TuJKUAMeDyH7mpyBzbVQzLOOwdyA?=
 =?us-ascii?Q?QttOksO/QUvcQxIsb+NffpNYdSO/4KTGF7CL7f8Co54WdaLacrMKhNQvKCYx?=
 =?us-ascii?Q?pjEnUZIMtsA3jOnCpprm/UckIKTP0sheF7BXnSWdUDMQhakvsh2BQregTahX?=
 =?us-ascii?Q?4gPLpz3MZgW7HrNKYCTSJYSeEJUnRXTSaae4kWQ2NGKoa+w0nxzWkiqAxb0U?=
 =?us-ascii?Q?21w+qpkWLpMVwbjgXF/j0h77TFcxYVsxyxQ8J5qhhXjtztywwYsD9bGArbJC?=
 =?us-ascii?Q?az9AY/s6HPgTlsF13wrL1S8dlnP+hCK/SgWPIHbGOOdRCSM/Y7hS/QrrMgv+?=
 =?us-ascii?Q?uxSpjckQy6KuKxVwRj92EZSlGANRDib7AzDhuiTP8AkTEwqYNSJmQr0CnPh/?=
 =?us-ascii?Q?fiAscUbdaDGa8mVaGBYpUFeFjLEdaU9LITkA6Ib7SwTtKCdwheKwuAMNPIFN?=
 =?us-ascii?Q?CHegCj0X5/LDw2FxPgnQifHEfD9oe31uR+FYD70LOpM4b1O86H80+lxUYo/7?=
 =?us-ascii?Q?YrnX3oTk9JhMP0GMzfyH5rDzGB3U7fiVUB8N5Itftde/iwXpmXrmjlWWtYPj?=
 =?us-ascii?Q?EIvR1zI37YQ5Fg1lFkDE3bfgsLo2rxR1vDLqFLQgdZmWp8S3LEcIhs87oT7Z?=
 =?us-ascii?Q?s2bGUMUhUzyuxpv9hve4+QI9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zfpgh6O4SctJoTgcyizu+8z/nLoY9OpT2/IpW76WTRi0MAoNWxxfpPxzZ7m5?=
 =?us-ascii?Q?UoYO73LWiRljrqsS6rVxvm5eh/P52Cf6ArKcnAyT8FQO+6OD1BBCfpNOe02d?=
 =?us-ascii?Q?V7zKgteALQWc98nT2Bhipm3zKRwNai6/xz4XqRt6un3SU6PX+jTDSKn6GuAv?=
 =?us-ascii?Q?A8Sap3ENgqCZgGXPmnIwdZhSPRrNF+fgKtclDvoxEg3OG9ciuoR4fHdAz2oX?=
 =?us-ascii?Q?b+MWMQdtYHHU3uL55oBpHO6gaI4r+xifvIH/HNQfeqMt+195DkZ2I2WG58m+?=
 =?us-ascii?Q?GXmse+0Y5zaerLNuXM4BlL7RpZ+FaW0ftiHSToVU9hm18LFMBLKABrwo6Rxn?=
 =?us-ascii?Q?KUb+KplgtIaL7F3uOH9ZBjNcoujcXnU2eDgf9lpWmtWNFXKRHvPDXdz6QhFW?=
 =?us-ascii?Q?k92Zfh4lGN3QEZsHY7xBSAIJ4tmlxIIyW7vwhl3F55SXLgoB79wMV//qCSHE?=
 =?us-ascii?Q?HZErwxlY50M6dqL7wsRXtljPCDAiQN+ahdvgMVChO2FA9oDQgJEbltD6myd1?=
 =?us-ascii?Q?q1NajSjbichlXRotjmPBkVzAPAYfDeQf46XZA4bd2b5TLSorvosR9WTMHTvc?=
 =?us-ascii?Q?9Kc5xPTwhH+emVwBuBuEjRilc4xhTp1iF8JBvhkXsW8fkKkV+RRhlCxCUml+?=
 =?us-ascii?Q?QA2f8SAfmpOgc2tPxvcZtc1/PCYwpCRjwW79T1XfdlSgT6/ZJ74iRI9+ImE3?=
 =?us-ascii?Q?92V6eKaP2yQYCp8WRrzvdXfYR0qggXta8pvDFTs6ZJFyHZc6eZZkByAz42gQ?=
 =?us-ascii?Q?b5RpixJkFBhaf+65Rgb6CoD/tcFAwGTX4qieCfj3vfehLgV2WlCtLU3VKptt?=
 =?us-ascii?Q?efRZv42C9o3N7rYITpIRovRXtF/Mvzvp9vM3WGf8RFcV+2y68hJY6gru4Wat?=
 =?us-ascii?Q?lEzDxhi+YJYOJLdDmy4vG5NZ/W775jbn9IozuklsMQgxNGiU4UA2VRHn4F7Z?=
 =?us-ascii?Q?HokrCr24N1vXqjLDC+5zMNXwBFLwzGS2ZRmUCNTtNoJeua0uwOExSH9GsrlX?=
 =?us-ascii?Q?i9kIwfsnLP2UJwhp/I7+reFc26P6Xe0Ue0KLSV+pWAeXG1wFwtcIH9I3lEXS?=
 =?us-ascii?Q?DEBnWLyaM6oU9NjjL+C5fXGZ8qWqondDFPesnPxP1iQs+9gF+lQdXmCwmxJM?=
 =?us-ascii?Q?64XaiLdNmo7FMEyCxqRTFzeDi/rigF4D3EQhdpOh/VGv2OyzEaVRAOu2xxMd?=
 =?us-ascii?Q?QqcBkD07SoIzxy++RPcY2hu11+wS/Nt+YuIW6lV56SWY7ATW/yoewvfDUi6e?=
 =?us-ascii?Q?7742AueJBIYOTJdECHG1n34mYIrHsFlMsi0grB7KW3Wd8Y9VCR3eu5B2CiWf?=
 =?us-ascii?Q?zIK9/BDWodNuA+4PZwGa0oHJpCmv8K68oCzgJvN7fk51Z4GPPzuat01QFugH?=
 =?us-ascii?Q?8KaBz5S6XS2Jzkag23fzaTnBkf2e4fNMeiIRv3O8I0sDcQVrA9yHmSK4aE27?=
 =?us-ascii?Q?BC/Nz9j8bPXHcQcpc8cOot9fdkEvU6z8jXUxcAHbqxREKOYLAUBUg4oamHEG?=
 =?us-ascii?Q?D45Ar+55BWvqqoIqSGiNdqzpU9LT5JgdGX80aePwZ837aEyt1L7pFKyRUh8J?=
 =?us-ascii?Q?uOHi1jsJSUivwWrV8TzAfPQHZ3YnlMUzdETd2Pb9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9176744a-41b2-40fc-2f4f-08dcee204b32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:22:44.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCACIPfPiRADllwnrsOR2U1vZtxUYV/CJyQUJlJDwpoPUDfiu7fbeJIiOjR3UlQy6PbDghqj1RUgT0+JIudztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
family of functions, and requests "too many" pages, then the call will
erroneously leave pages pinned. This is visible in user space as an
actual memory leak.

Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
to exhaust memory.

The root cause of the problem is this sequence, within
__gup_longterm_locked():

    __get_user_pages_locked()
    rc = check_and_migrate_movable_pages()

...which gets retried in a loop. The loop error handling is incomplete,
clearly due to a somewhat unusual and complicated tri-state error API.
But anyway, if -ENOMEM, or in fact, any unexpected error is returned
from check_and_migrate_movable_pages(), then __gup_longterm_locked()
happily returns the error, while leaving the pages pinned.

In the failed case, which is an app that requests (via a device driver)
30720000000 bytes to be pinned, and then exits, I see this:

    $ grep foll /proc/vmstat
        nr_foll_pin_acquired 7502048
        nr_foll_pin_released 2048

And after applying this patch, it returns to balanced pins:

    $ grep foll /proc/vmstat
        nr_foll_pin_acquired 7502048
        nr_foll_pin_released 7502048

Fix this by unpinning the pages that __get_user_pages_locked() has
pinned, in such error cases.

Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..24acf53c8294 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 
 		/* FOLL_LONGTERM implies FOLL_PIN */
 		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
+
+		/*
+		 * The __get_user_pages_locked() call happens before we know
+		 * that whether it's possible to successfully complete the whole
+		 * operation. To compensate for this, if we get an unexpected
+		 * error (such as -ENOMEM) then we must unpin everything, before
+		 * erroring out.
+		 */
+		if (rc != -EAGAIN && rc != 0)
+			unpin_user_pages(pages, nr_pinned_pages);
+
 	} while (rc == -EAGAIN);
 	memalloc_pin_restore(flags);
 	return rc ? rc : nr_pinned_pages;
-- 
2.47.0


