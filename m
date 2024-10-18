Return-Path: <linux-kernel+bounces-372514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACD9A49B0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E718028442F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47D19004E;
	Fri, 18 Oct 2024 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IC86ihv6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497F18BBAE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290862; cv=fail; b=GJm9mV/ub+wWfkPMGaUsjSqHV4b+P8F9asjhQrbLHaJM3tve3QgLe1eJ7HghY/KGAYAcu8k695uKoFttbHhH46BYFpjuW3nSkkN2Ku1L6k0PzOsXOJ/fIWoPkkfzZyYH/7N0EZh6DdEvIY+VlhMS1Cxilu+v34RVPAcZN1i94WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290862; c=relaxed/simple;
	bh=62fX9DWJPi3ZnlQdVfxrxBWhfc4LTsLoBpNr4TfCCp0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QfydTmBVxkLfAzQGR5dEMPfQvlFO+DG8aX7Hs01xfgMeDxPAjXBqHa8Bo0BkLx7GVOebWcpNjnx+8mOcCfaRdd9nUdZjS++i4OArDSa33zQz1LjG+7dfAo3ZTqEQDjkWZNZmEdoukOv1N1Rrj/pOl8E087erSAA4nN/0uQDv6zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IC86ihv6; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vergSXURYi0+fNr+eiHLW4NVcJOZ9Kom+sdm2GtvsAzLwo9hoDI9eXxdjj3Iw6ta0Im78TDfR1Cl8c4YLFWLRdFDma+96zXYAKYuQ81gw/jLBOSa1tXCSoAk0JSTHyx2ZqglbqvGsbxmufuN8fRZFFhwDlkgl4CQSl2leoRsy5UItLMicXFS0aPa2aJ5xggxAwsZVRNy/X9GtBhxJk0aIIFQfZhrEdwjI+KRc2aPpcdCPAUeWvA1xKCrxSPw28PBcQnu0QL5ABfpYp38pNa3Dy7bMaDZD7swYaGtxMYeWSX83eLFEy7JOogUBimXq8L8q7MlgiQStOGGUMpXj03sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVzzE9PJ88+5Jt6bTYpFS4uzjPfO9T0eul4pMPYXUSY=;
 b=rOIiuBAjBJbPhw/AdfK271QzeyuZOb+Y2gwdz8GYx0WLmBKYLgfeLH+5GumzLTlgUlhVUw+va1p4F6ARoaJIWFKqmBxxdKAW/wxMMigCzq+DV3XGiCKDNEqLx/DFinkQdg675lsTcZCHXR+C42Y1p9j9w2xaB95iV5pgPZ+uk6NpWnB68KzkjGCbJAWunpyBMpeW+b/zanNTgklmbnxBDZUU6YlwRlzlSWV8WTYYT23pviuRNnGxtjU9r8NXf+95frt1OdGOVlu5c9C9rmHq54sydVOwZEYfH/O7c1Rx5c++8nLkzucpOIA+d8OEywb+IgfWGv9IKB2Mlek1GSvGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVzzE9PJ88+5Jt6bTYpFS4uzjPfO9T0eul4pMPYXUSY=;
 b=IC86ihv6uN6GYSY0LFMW07bmAlcz8/UGnvGzHilZPt55q99GrBa+fTPvfX9xc5I3VtKZ1YjimWkayPAaSiD48+p805UQBLzk96LK0ODPyD7yd4rgzISI1C2mIZdKzmnXFRWyyGOtfyLvo5H/YbUIUCJUSip3N+aNhb8+Cl1pr+nRqSqUEZocgBg7eYqlSZRbtABi+9zT4lk5S6rHodWsWJJqUYSOCRrJ9tUaVxtYijq4yutxaXXwPohvdLpuolIj8OwGQSvpd0WbVB79lMRUFyRXFX7GWq1g1d42pgiaGPQ7DA0SwuroryjZRtmymuO0qn16MYR/URoFH76c3R7hVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Fri, 18 Oct
 2024 22:34:15 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 22:34:15 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3] mm/gup: stop leaking pinned pages in low memory conditions
Date: Fri, 18 Oct 2024 15:34:11 -0700
Message-ID: <20241018223411.310331-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: eb06045d-24de-4625-0fa3-08dcefc4ff02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAAf/4FjVdU3ZLO/kOFT7pkddnWMMRjt/MeH5a9jJz1vkZdmkLr8BbGAi/ud?=
 =?us-ascii?Q?Foo32jow/S+7++0vsRsLbwVY9iTe99mPjine8JsLDjk/YE4bxpE+6saU/9Nz?=
 =?us-ascii?Q?wPUMHcWthiozOyU0quYr7P4zkvx1/MPcz/W2ZUqx2vXqbsuCzXm9KA5oYtMu?=
 =?us-ascii?Q?5X5rkh2rqDve6S4eLznJmASz1EJIjO1oIBAVaxrrX92vtmOd3NaLO0WYboSy?=
 =?us-ascii?Q?RtKDrqWKvgrEmakmoB61PqtZ2W+pjLZjf+brLhuf8ZEvjp2zVzmD3jqdNAVS?=
 =?us-ascii?Q?WFe1Z/rvhIFk5pZhJSrrcxFPX0rQfQ7K91/+iTxRyOFtVE6VTLSyfpR87Hbh?=
 =?us-ascii?Q?GBml2kCRfwGuJeoVvOvGcxz8kl1fC4+3c9MPFhsgMNvvfa5ar/4K3Uaa5xdQ?=
 =?us-ascii?Q?J4Ag0cYPSbq+s2dtte6ZRkX2U+9E9/JNMXTqrxj2a7OvB6gGY28mzTQv8Yol?=
 =?us-ascii?Q?lb/h/1FGgKcEFYbRGvZS3PeYtvPeDAteNHq5hCziG3cBJ3jC8tbYogNkydC3?=
 =?us-ascii?Q?5sX7c43f5VQERl9TFYNjeToUcqH4hyOCGNsE7hYS/ixLDs/oEUcUJ/xVCsY5?=
 =?us-ascii?Q?/gUUEqK5MZEhh0HBTfugk71T1Axqfd74fn4pkwCmDMy5RHHUi5EC74tIqjAt?=
 =?us-ascii?Q?wYryABQAsLpbtr1wIEgJGG4Z4rBsDN9Ts0USm4rOj6ZRnoO6pSgs4QZt722d?=
 =?us-ascii?Q?H29f5F4mhocgXTg9WUtkbL8SLJx4dcdtBAptPDhF4GI3WEYLSDMjTSbxlq9I?=
 =?us-ascii?Q?XMTx03PCCeDAlRwIWG09bjEWwFqtOgG0k/qyl3JCAlWwE1SY1lOmnT0TFXFg?=
 =?us-ascii?Q?NCad/SxbAok9rRfKECKpcpig3dOywxXnIXtgFTqk51/O6Rvyu3nRWPNiMB9L?=
 =?us-ascii?Q?FDQVEa3QROiSuK5Np0P0Z1Lod6W2pnQ0WpT+f8kuEvBEiB2fbN63fSlJSuOk?=
 =?us-ascii?Q?WTOakD4QmFDqO6W0FtRvGOff8U7TpOgYsKG3cP6HYsT+3n36FvTkGjZ0p9AG?=
 =?us-ascii?Q?fi6hMChj/MEtcq005NIUUO/sk6lFU7Uwnp7FEkhjBp7ePz48iwE3iqVPUBwg?=
 =?us-ascii?Q?WvYQFpEGHilxP71ShmJo/KCe/p4ZSoD07gz2oKiVUeDW8SPL8TEg0EDuzEDC?=
 =?us-ascii?Q?2Je5bUeXAXHofzYkiax+V+LRprwTHGsigV41DCLIFIOXTZ8AtvEyA1CKcFx3?=
 =?us-ascii?Q?LWXs7SdFhPEW2JzU4SHoUWMNn2NuafSZh8mp2Aze4Q37eZnYtZdl7yHI2PAY?=
 =?us-ascii?Q?jg2aIRRyz7mt6OAdqrLKDBaQAUq8e8Sx/FZK781siTLb/hc4NMoDri6qo57/?=
 =?us-ascii?Q?bAWiYrKm26vRPj7SUUwHMiQI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Q7bOU44HIqjXXdPye7JuEaft2Nv6jLOjNCRxMuc7rDz1FGvmD7P9ob54BQw?=
 =?us-ascii?Q?oJ0ouPibazPOloAvWDM/QKPGWqcCrJ7je2gQLbsBuQK2QN5Pwdl0Pen9m9wp?=
 =?us-ascii?Q?/1odATLeiBVx4G4Tro9V2FUlxOY9cQ2ds3fKK84W6/qTkaQyqIp2yyND872i?=
 =?us-ascii?Q?4lM6v9joSowwrXEZTlRCjoLeCXvZnb4cxt0Y3OEneGgC3uaRLU7mwl2HMAhc?=
 =?us-ascii?Q?VfrBp7UwF1o4QVw4l6q0KsIFqmxo/5HiBdveHq01GzyOnPlGGdBbvkP/h97/?=
 =?us-ascii?Q?4hDr95r5l7ZaBNEiw5056HFm0LZZroTbvBtSvY0OoIHnuvzytVvQvNQS2Lfh?=
 =?us-ascii?Q?V6YChAe9fKh5UyTw/rzgBcjEzhjh/hRbMPEy1sijEgQePslGoNDjMW8MXzxY?=
 =?us-ascii?Q?zErjybuP2HIDNvCUyLeB5qctp7dmsTXqf8yx92ai5Pz+tz+fEBGEXBcSu/Ln?=
 =?us-ascii?Q?1GHGpqwgGL0k35oDdag7JK2ihsgd17RhtNOjeWcKzsTm+FSPcycEwgT05NX+?=
 =?us-ascii?Q?SBZKlFok41cQfcGyT70Dau+KTP//SsFNKSmAz66sHroFoxmIbcLJ7J0+cdRq?=
 =?us-ascii?Q?T8gXEeHl8c/GBXU4u8+E5Idwvx1QVoTL7Xq1pdcxQqFyeCSY6/B53fIbzkMN?=
 =?us-ascii?Q?eyGMe1oSKKWyhUvCPBJnKFwjeoNpNUHXZgb11LkWa5txWrGjB70wDtvw1H00?=
 =?us-ascii?Q?ICY0CH/onzhpNDuydLrQToOIUz1FGVMizA/ae75YFSB/Nk0KHI+UwnIx6JFO?=
 =?us-ascii?Q?Cv/x2IzAPai03WFxgfhvWJigGIySCfjvGnXjLeOFEJ04NtQbALCWYz0tWt+2?=
 =?us-ascii?Q?1+W1jtp3MBBlqa4DfYZ4mWGqvmF3CVxDZbH89FsOTaQ1c+/IiUwb1r08Eo+Z?=
 =?us-ascii?Q?nwZer1HSKAF3rS01t7FH9wK6WBdUoA5++FhQCd2rtFP67fCxi7XAPsPXbBwT?=
 =?us-ascii?Q?zzWJpb3YFgQJGpMNM+aPDVRk93sYgkq+Vx6hQPjbW9FCQNMd/NGJTC2lNHRi?=
 =?us-ascii?Q?8zUaJNu9av6PiWK1RzqJbVlLCR/gUs5S8gtp9h92RcL+Hd5uiG+tPcqhqzsU?=
 =?us-ascii?Q?t0pE/Niu6LRygDtHDNdL9SCQh2ULaLO2wrmrtV867LEOwgg7PEAayWAAdAFV?=
 =?us-ascii?Q?tQhniDIKGldGtHnsRn6+0lr9MfVNl/cHlSYzAeJ5bavJXaXnBNgeQS+76zpK?=
 =?us-ascii?Q?E1dLYRZEcwGw5V7kTadwmaYUK+8YHIEhJbZI4OxAa06Hl+3SRk5A95mcxxmt?=
 =?us-ascii?Q?gV+miskbw6K5bpRhQtd+byaMRyzhbrkB4evPyqU/vA33i6y+JGHb17NV4eNS?=
 =?us-ascii?Q?7ttfxNxvemdfWZ05OTra4CqCTZibpgd/rTBpu4q40AdcAoCLk5VDZ0vrmniq?=
 =?us-ascii?Q?b+IpbYp2pOpSYtlhZzj20ONZc6unrMXpztFyANFHsnkDkF/AOG9X6+Qs20l6?=
 =?us-ascii?Q?JbhfcYeygyYoOg61un4RnE8G3s8R3gXYthYya2KqM8P2WOXPakR3T0vPPI9N?=
 =?us-ascii?Q?k0aGdn29gIV7xJc/Qv+HQpuLA6oJp+ThJ3R7RA90pS+9CvZ5H2xUbafHUWrs?=
 =?us-ascii?Q?VWzTJ8yJKrB9dOZBBluCIPd6Bg62obIZ/IXtkPhx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06045d-24de-4625-0fa3-08dcefc4ff02
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:34:15.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6eTCkVlsJRNYw74y2oXl7UbgzjuXU7k6IbZ8p0RBB1oHJdyaIvp6rKolyFYqux8fKw5oZ11nxBxuxCQ7zKbDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

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

Note that the child routine, check_and_migrate_movable_folios(), avoids
this problem, by unpinning any folios in the **folios argument, before
returning an error.

Fix this by making check_and_migrate_movable_pages() behave in exactly
the same way as check_and_migrate_movable_folios(): unpin all pages in
**pages, before returning an error.

Also, documentation was an aggravating factor, so:

1) Consolidate the documentation for these two routines, now that they
have identical external behavior.

2) Rewrite the consolidated documentation:

    a) Clearly list the three return code cases, and what happens in
    each case.

    b) Mention that one of the cases unpins the pages or folios, before
    returning an error code.

Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v2:

1) Applied the fix to check_and_migrate_movable_pages(), instead of its
caller, as per David Hildenbrand's suggestion (thanks!).

2) Dropped Alistair's reviewed-by tag, because the fix has changed.

3) Reworked the relevant documentation, and commit description, as
described above.

thanks,
John Hubbard


 mm/gup.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..4637dab7b54f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2394,20 +2394,25 @@ static int migrate_longterm_unpinnable_folios(
 }
 
 /*
- * Check whether all folios are *allowed* to be pinned indefinitely (longterm).
+ * Check whether all folios are *allowed* to be pinned indefinitely (long term).
  * Rather confusingly, all folios in the range are required to be pinned via
  * FOLL_PIN, before calling this routine.
  *
- * If any folios in the range are not allowed to be pinned, then this routine
- * will migrate those folios away, unpin all the folios in the range and return
- * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
- * call this routine again.
+ * Return values:
  *
- * If an error other than -EAGAIN occurs, this indicates a migration failure.
- * The caller should give up, and propagate the error back up the call stack.
- *
- * If everything is OK and all folios in the range are allowed to be pinned,
+ * 0: if everything is OK and all folios in the range are allowed to be pinned,
  * then this routine leaves all folios pinned and returns zero for success.
+ *
+ * -EAGAIN: if any folios in the range are not allowed to be pinned, then this
+ * routine will migrate those folios away, unpin all the folios in the range. If
+ * migration of the entire set of folios succeeds, then -EAGAIN is returned. The
+ * caller should re-pin the entire range with FOLL_PIN and then call this
+ * routine again.
+ *
+ * -ENOMEM, or any other -errno: if an error *other* than -EAGAIN occurs, this
+ * indicates a migration failure. The caller should give up, and propagate the
+ * error back up the call stack. The caller does not need to unpin any folios in
+ * that case, because this routine will do the unpinning.
  */
 static long check_and_migrate_movable_folios(unsigned long nr_folios,
 					     struct folio **folios)
@@ -2425,10 +2430,8 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
 }
 
 /*
- * This routine just converts all the pages in the @pages array to folios and
- * calls check_and_migrate_movable_folios() to do the heavy lifting.
- *
- * Please see the check_and_migrate_movable_folios() documentation for details.
+ * Return values and behavior are the same as those for
+ * check_and_migrate_movable_folios().
  */
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
@@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	long i, ret;
 
 	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios)
+	if (!folios) {
+		unpin_user_pages(pages, nr_pages);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < nr_pages; i++)
 		folios[i] = page_folio(pages[i]);

base-commit: b04ae0f45168973edb658ac2385045ac13c5aca7
-- 
2.47.0


