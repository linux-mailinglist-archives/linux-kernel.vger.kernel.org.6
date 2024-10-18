Return-Path: <linux-kernel+bounces-370775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89679A31E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D5A1F22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1A53804;
	Fri, 18 Oct 2024 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SakqC0/J"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3B286A1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214243; cv=fail; b=EBnRG5takyfrrSWZjE3EFiflVcAqEOy7KJeQw5yo+aIRp6Ye70NKNU2Ouv2sOojvSb6f8i21iFTtE1pk7Eie7mzDkJEQr+W8ykrCGFhF1P4EUgj7kHExqJ/7Cak4JlvZe/K/d1fV9qSQt4yu1nM18KIu65pvSLg6KiOXB6exzwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214243; c=relaxed/simple;
	bh=ucQrcB5sLjaaFQiumYnym/QhzC5phlyEaG6BndvQLjM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mfSKIADDXXsujdOwHPMQ6hHfCHdi485TUKzkmsWJw7FHVYzad2BFaD13ojbuqt+Fu2r0SLwPNN8EMDDuiHL7ne1WpjAZSmRrn2fdCFPEsnQbWQFqr/2doQTjHe1XhnC2eLgj/I9tJYrGpyf4SkAFGxD9LhITBAbWz+PL5CYy+QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SakqC0/J; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJFgtQPsrAvJwRcCNVW1JyRi4TrchrbH5qE33P469noUWRdVK80YP+D/qd/8roS4y2DshbmP0LekS6cyTNr1XwVGmI+RFzTSWWRDdXroHCiaGbeMcWDUuZHVzFCkybdO6SSIZXLbcbuR5JdLqTOXZkVZii6Mf2fIRQOnXxMiiaE9+JjJyRDyPtz/X4a174vZP4MO5UCmLkHmpS+IOF2/CplI3OZ1sKf4j8p0nyLpSZOUxP7S80sWm21HAynwRRe/jP1TbdEyFDsYGgJ7t8uADKcuAjwLTITaHRH/wj36Bz+8PqzEKNbM/5iCSwmyKNIHIJrZ9Cgic2DhEwvPpTjLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM2DWGmbLBQ34MlomM+F4njIUYWmIq4vToJVdl06T94=;
 b=r+uQbPYpyYUpc6bFPBECBy6xv/DmHZUIZlnWJEeOBtj49eVGAfZYEzIbo/TQNaHfZtajfVOGyUabQhRblDLxVXzdXxOEKOuQbiY66Ouj+L0QWuRJv4XmDqQe9AgVG2e343FBqLw9U+l7uRB3pHBcNwuSHuqX6dOqAAW/cYQx0P7BtCH1ZinUnCNptFf32EXemW3KZzvhPkGgLChdVaqRovi0HEGqMsHYejF5rtP5w4U5VthDZ2qEhFQctNuispnk5566GvL7Pj9ThdQ1xQeoxbw2IxcRZR7LwWLljQKUHrGoT0Ug80Xu+tY41G+XW5/F0Csy0/dGXGbRvwtHR4VTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM2DWGmbLBQ34MlomM+F4njIUYWmIq4vToJVdl06T94=;
 b=SakqC0/JvCV01tS7yZP/CgKsWhxhSnL/o3lGu1b8vP1oN+o8CJpzmzHxLvu2dx/k12UUxFVSve5MlOpGr0iHoOnNRyCJjPN2KWB79sNp8rDhKX31LCiFGCDJ3KEP+joNCsh0Vl3JuppeLONfXiTB2Z5UTrGbV3YJb9L0nVIGALEXnv2rl2liPy3b2rzddSzCDLeRMuYvv2LX1mXx0J9s9DrLYoiONtYbOiEAlv0N5ESpbD0duqSqsTX+F/wvZ//6DlNkxDf0z/F7viJKLnj6iOZhrHt7RW6RZAS1Nk3C2TWkogskPOr7cJk6BFc2yUMbTQ4W0Du/3ULk2QHxviYbZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 01:17:13 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 01:17:12 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alistair Popple <apopple@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Minchan Kim <minchan@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v2 0/2] mm/gup: stop leaking pinned pages in low memory conditions
Date: Thu, 17 Oct 2024 18:17:09 -0700
Message-ID: <20241018011711.183642-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fcc27e-8559-4b34-235d-08dcef129887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WW1683iB5YlSrSX1KrrkRPgRhG7oIJodU6a6QL75sxjR3Opbh6eCXX2ETUuB?=
 =?us-ascii?Q?CJE+swJqjxFr/S4gLxhYN7hnVmqa/poT02V6IQJzN0l8KV+/VNWOCq70x/AG?=
 =?us-ascii?Q?cnOgs4uuserlrja3K9EBhPAtrT51gp+pcyLnFAhukuVjmCFR9vLueVlGWHYX?=
 =?us-ascii?Q?znWcTOD7jEYH0TO5nhBc9oiw4zJ6S0dajkAH2V6cP/wWKv+aksLpT3AqPyRa?=
 =?us-ascii?Q?fNdJQwHPP4hgbRMceHBU2mBTBWm7ycr4y03rw7bDiHTfCg/b1DpvP8K12xlY?=
 =?us-ascii?Q?l7dbnHz4yEmZM8QuiihVLpxDqhcwuOlYiy7xBq1RrjgPlROQo9ALnd3vTITU?=
 =?us-ascii?Q?YvdXMD3ft1qBphJAfdu7SzRNo8JyzNOVZjROHs/eEz7uuTWc6c43SUp6tUpT?=
 =?us-ascii?Q?dS6hCBvt86RpvfYH6e79nnXbYs+H5pAndQkwN7NLASFCJ5JAkOisZlMXjYyG?=
 =?us-ascii?Q?ilPvkE4XsTnFm8r08adLe1jQ8Yh/Z4BH/SPzjn19IP53ur6+7m9e+VqgN2iO?=
 =?us-ascii?Q?hdjKvZrhLRdh8gQPhYNFUXm14XN9aU/jwf0/aCHwV1Dj8KoM275kqEsiLaIS?=
 =?us-ascii?Q?Se8IZnbUyB2zbNfvVo+WlWQ9Hd3ma4HkksFp9KiifhsCMYNdvjfVvR+AOQU+?=
 =?us-ascii?Q?+f2ZHxr2OmVAhcMAuUZ6N5UaGB3wgwBVyTu6VPJeFW2K+FgjV4HNaxQd94/u?=
 =?us-ascii?Q?cyblvr1a+yohWvm1y1EicCf5iXXXL8tFqak9H7PwZe+r6KttB82Yv4Rpr1Hy?=
 =?us-ascii?Q?KoYNo2IN8N+5IBViCn8FXCAfBADPr4KNY9NXwa8Q240FkoXmY85GnjJ7Dwxb?=
 =?us-ascii?Q?vkbq5ktWR6D8Ugw3Ik2DcgT/8EiX5zI/alP1b+q9FF26KEV5CPW1zlWgRhB7?=
 =?us-ascii?Q?zQNPxmOAu0RfN3yaQgml7W/PzTo6c2ZbeoyRMEZuYoLiVVWLx/na6NBkT2mz?=
 =?us-ascii?Q?ygG/P8ZZje4qrcXRREgZULgqQdDP6HTuCP0bu136x0znZ+963dDPT0C9Yd2y?=
 =?us-ascii?Q?O0MMHH6h3ch03/0Xpl5iMlKWvAm2Wy70Lzok2LPuWJol00FYmHtScff4E768?=
 =?us-ascii?Q?8dHiqNaCQzXpYLr8vaWxZSXPDtB1oowrG4Itur6dZ/YOuMmPdKCSRzNeMECa?=
 =?us-ascii?Q?ndvFyXBY89sUvulFn3PRpKL/ds3QLRdNcpuU6bDxhxdNfvN2OIa62UZCYsRy?=
 =?us-ascii?Q?a6BOhUo/KIrfCrqoy5/scco9h7ZYD2z0oRr6ZHksBQA6ZKtq8s7han8xbC81?=
 =?us-ascii?Q?BUtYISteMUWH4qBPEZ+sGTtbDQKw2q+fEr0vfP2ko7l4ovENH52HQZ/6WYD8?=
 =?us-ascii?Q?/8aZKlaillvsiaEuZ7puhbEi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IO4shCffa4xmcJ/nhV1tcBYoe37fzeRRzazuoGn6uc7nSre6esNB+eq01onN?=
 =?us-ascii?Q?iTjD82w0QTJil3oaogFoZD/bIG61OfL5nMUGHcwm0i4muX75EM9Dk+AZIKUr?=
 =?us-ascii?Q?SuN4AEokODVPahLaj4vucRoAt7F9hvHYzrzUn+JMGVPZVU4PVrJga7XTbNGG?=
 =?us-ascii?Q?ZPZhfxmePSqbFdBWXZWg3vgYxdoGcMW4pKmok1qgsv/bgcSj9g5HVsmcOBlT?=
 =?us-ascii?Q?O3refDHnYG9UXdnMMXCG31ET41llB38nhEpg8I2WohYn3g5a/93Hdg5VnFV2?=
 =?us-ascii?Q?wiHEPy2u6XK81BK7Ew+AxqILcao91M/980Yg+PFspVfg2tGL58TJibHJrWYt?=
 =?us-ascii?Q?4zq91OZR7vRbtVn7iWw/2rqUgFcjUsVZTdXM90CZlrs1uZ+oQPY5JLuRTmJj?=
 =?us-ascii?Q?cNF2EpjCzJ01qf42imh5hS7HMx9asvI74dFc9MbObCNN8diWvZ9NbYM/BxlD?=
 =?us-ascii?Q?qA7Om6VuPE6KKQCAtUIEoL0A1cKE9olvQfzfJxmvssZD0yFBN8aEGBNpqoLW?=
 =?us-ascii?Q?ITQq1pWC/6o8axzaecKNcAJH/rAdMFpFf0LGbDuCH8jHikpI08xXl45YBQkY?=
 =?us-ascii?Q?4rLfL72l8JYmGhZkDhjhoP5f2j3rI2UnEzEsdbFl+BuvAULeFCJabOK4xcMs?=
 =?us-ascii?Q?QJE8ucBm0AUAc2baR0DPInqyRZ686j+igZ43kVuKNaGM1NTC60ZV9Ml7WV0E?=
 =?us-ascii?Q?D87aei1m0ubkXorPzklcCXGKZEbti3c8TNDnBqn2WLCUhCrlY+rJZXvwjinM?=
 =?us-ascii?Q?uuJcu5kTu8MTeyPgH5oFpqxp3XNLqik0bFzJ+LIwpOwpWEmvyW690/CJvQDt?=
 =?us-ascii?Q?/DD5ldcUVRbwNr513xE3gSS0ByqtYExjdCuevDQSI+wrSlxJ/MM1nEJW4U5i?=
 =?us-ascii?Q?YRhbPGKfP265amaUDxnBTey+KzEoKa3Y/PNRHp3uM9RjpJlOunkOo2ENVtMc?=
 =?us-ascii?Q?i3xKsOcewh854sjzjvNTpRFEzxIY1UzNv9JpDiMhxnO5AcuxR63vDzbfk0Gc?=
 =?us-ascii?Q?0r5/y4ss+cb1K4EQCjsXrCRUFWpxJNBkmlhPV/XAudjFG8dUVIw7QjBBDtci?=
 =?us-ascii?Q?3U6b1t5pQ/G3ZFp1sBTX/RYq9i141nbgjNcbi1IBziWsXEgxNPWOQT01eyt9?=
 =?us-ascii?Q?II8gpQl0F0cugNQ2P8q1yLvySQyOywDM0r4e6GmEf4dtIhzLxQ1dMGQSlhW4?=
 =?us-ascii?Q?j8gW9icPvqkv7ubhKwS0/NUtw/dytdYprHVxThhhdeXMhBYIZlJ7FllRCmJD?=
 =?us-ascii?Q?WPZgndjd60v4uJd6Udcjp72Xm8AAKh3w+wQ3wqFUue30GC4xpsFKNupm+5h6?=
 =?us-ascii?Q?2IHJgks1uKnB5DvDJ8hoZ4tm9FqDMvbfa/RZyhDLjivl5Xv/6S1rodyFfzxC?=
 =?us-ascii?Q?z3Fc6WsxKJgUmoobCcUMx5JCM5kTgzWwd+L3LZy5Crg1SuZgXMOLG7vvBd3n?=
 =?us-ascii?Q?dUmuag5O/F5OifwQPfqfTbqC4goeHbNXt4TGv7Qi+p516znZ6I/Rl1HOiQRf?=
 =?us-ascii?Q?mbfG90xME5p3m6s1jwGA554t6rwRqQnfdg0UQ8KIU0bL/j9KndyYVFfOw1ZD?=
 =?us-ascii?Q?OonbntTseYR8IwXZyNVXIb4iZjS/8BI/8X8Dm5Yk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fcc27e-8559-4b34-235d-08dcef129887
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 01:17:12.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLPxt2prw79+1YAlclghn/0NSLnZfeQdpXsNhsVT/BeWF1gopxTu9Omv3uyGXi+h/9C89r0Ms0v9FIsLL4+fiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

Changes since v1 [1]:

1) Thanks to David Hildenbrand for this part: added a second patch to
fix the same issue (incomplete error handling for the return value from
check_and_migrate_movable_folios()), but this time in
memfd_pin_folios().

Please note that I am not set up to test memfd things, so at this point
all I can claim is that patch #2 doesn't prevent my test machine from
booting. :)

2) Fixed a typo in the comment, in the first patch.

3) Added review and ack tags.

[1] https://lore.kernel.org/20241016202242.456953-1-jhubbard@nvidia.com

Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>

John Hubbard (2):
  mm/gup: stop leaking pinned pages in low memory conditions
  mm/gup: memfd: stop leaking pinned pages in low memory conditions

 mm/gup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)


base-commit: 274995ffe748bbee39f1ca65c6a31a1800140b27
-- 
2.47.0


