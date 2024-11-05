Return-Path: <linux-kernel+bounces-395848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2279BC3DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE92B21619
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965C18787B;
	Tue,  5 Nov 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNSwAwKW"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AE18452C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777394; cv=fail; b=gBNgz+9RQ/GFclhkC5ILjzzWZsoOCRHYaFvqi2vmzvH7R4utdxOjh+EPa3NDYSrMKB3N6k2sgOeNN5ZXnSCHt9/WA+JIkDXPS+aL11qzUpeFZDysN3OWnZOl3/0mu1PADXm7Mel+WIsKTvzgOkS3UmWkgKt4q36xcbMpCikqU7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777394; c=relaxed/simple;
	bh=44vRE46Eu/xGwhRYw4B3xct4VyPtJ+egA4l2GD0udJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DdhDuELY4285lYq7pZ80zDozW3HIYxIxCVHvjEe8auBFwQS5wgdy/aQ5UkZWldzLMQZKllKNEkNuMAw//Tzy91StzeNavIdrjCMZBU7ZPdk6CUbmwqZSH8Sr2R8SVTlD8s6Sg1yxibaJQpCzP6muhuI97li5vBhLiMERojwGHTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNSwAwKW; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/8wTtFHWOY8WCxaU8HkI/yiAQudzVdJHBFV92sa7o6ihCOVwUO5XKyepSUB+C3knibSpiVjAqxAVJiYI6yNfZUBV10noa4uFp0j1QPyxi4otj71AFakrs6uNKB8jeOH/A08m08ha044KccT+lEgMdOZAFS9CQSdsY172VTCrqTRIy8YTb/QwplQT7PpaWwe4Rpy3oty/XyiSj5dFLmVC47Tj2onFYBHECgwjfRhA/4KmnXFctl91kvP3hypsE905LjaSMIT1T370TGhPqRqqB8Ca59Ovi6m2A515u68VXQyWFG4NhUoRJSdVH+hlpGtkvQiPNm4YYDM5MBYhQmvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SMMUmKUWMrpwMdn6et7YI8Q82K0AaYpk74A+1JAtSw=;
 b=vFWAU1QPN9HWKNsSOfcS9+Mt0xjgviQGqT+tfDTR/k0tJQjiiBH5vv9SHiyZv8Q0ztx4BCwj126pO9vm1YrlZCgqWjH6cVKxuNo+1/5aVDYOrfkJsht2o0KS8lssxMh4xouwTKgrOQNquUi0al3RLOheA6qZM8WBalIsPeA+LulcKpWI0AOC6vAu95GkyaeglrCRZOL7R5IKZmBQvKX0XyhscjUtzCVuP9aiqhfafIkDrf/ho/CABs1RvSdu5lrO3nm1S88ToJiIvC6yhHAA3vNSbvEl51SYEJlMDq45e3/V6IiFfX3q7e/bpRWo/UJ7grtjshNwJarN0AGIP9/s1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SMMUmKUWMrpwMdn6et7YI8Q82K0AaYpk74A+1JAtSw=;
 b=hNSwAwKWBd5TeZ2KvbFE69hCEYqD6GAf+n/20zYRaQkxdq+j7nTPcrNnPEofzDdjmouLVI1xDk5ZQiXkruwwq0mXTSvXTY6AZd25LSa4ZIDIcHDweqd9epu0yN+OJrClfy89Gf3WWv2RIqHyxqj+NsNRiJvtdzWn1NCPla/RGjIF9zrSD7ihUhYgGU6WY8LMuInnoUyWU4z4+kDGiIvLeJ8fequFu+jXmNkIkWtL168F/eMeiEhS3P5ZerroaM5PpndEskTT34FCU45HaJ5B8JlkKoSjqDEUFNWJG8YTMGgs8z4UNTv+GIMHUqWTB7QZgS68hB+u3WvYLoL8jQSPow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:29:47 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 03:29:47 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-stable@vger.kernel.org
Subject: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases
Date: Mon,  4 Nov 2024 19:29:44 -0800
Message-ID: <20241105032944.141488-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105032944.141488-1-jhubbard@nvidia.com>
References: <20241105032944.141488-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaa6393-bb27-4204-9211-08dcfd4a1950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73Uw5jilhYN/Z3zsyT09vu4XTejwHmU8L/L+LOAovKL9REQumkv74fXl+Y41?=
 =?us-ascii?Q?vfWJUy8lrcWbh1Hsgpij3FUnzveNBpLb1Ce06vOvAqXGUg9+LiOvrO6J/bcK?=
 =?us-ascii?Q?XpOblIPDodAvKk2tfl1mLuPCLZ2OgJPCzcnPkELSYxmvaJ8uO1hzAH2Ccln4?=
 =?us-ascii?Q?GJdHZy8XP/m9ti8tOe+GIpv8mq4xPNyL0rqwmvKbnlOufaHTI39ur+KO4Mqv?=
 =?us-ascii?Q?2zpl6cX30/Mj1S2KfO4eVRTycavMLiW0tQ7qthLaojH0fNkb2GhAWP18+CNE?=
 =?us-ascii?Q?fXI8+uI6Goka8KIbe92WDyna/go22G6b05rnb3H2mQsJTGb+OVS5+5uQb3Cg?=
 =?us-ascii?Q?Gk7L+sTQrycyt1mjtVw8GRaOniYW3ocfjLLU2Jqv7TKJvBrbmsNbzY5FGRFo?=
 =?us-ascii?Q?boXznhtUA3pS8qLu9fZLfCN+fkihCs3ZYacovZ69mrOEjsLZBMGW5tKKj86D?=
 =?us-ascii?Q?T/wgSSanasc266l0yAIcSxqTkcDtIw2HYzW0KXCfOUXdiwCs8qwS8YWiLrdU?=
 =?us-ascii?Q?lmLS52EpsehVqN4xQb/7uxnveIzc9FC4/Lm809ABZrFEck49NwSxLNtXdaZt?=
 =?us-ascii?Q?d0aeCSdfrdLOKk7lpWdKAAHPjJpOkTW+HG3n2BRxPEeUkv04WcCfRalhSY1T?=
 =?us-ascii?Q?LRNi23IJPALKYrBZN0kUm1HG9QtpYVPbebLjIbDrkPA1zGceBVYyLzjkKYaa?=
 =?us-ascii?Q?BSR218c0+LkTolszkcWJ80NMUzUsFlaCYPIoZtzUgUJ9xLJxhU/xoLaud9hc?=
 =?us-ascii?Q?nn/8Bksh03T3C43AwPyh2mHyb7uqU8kEoNElnuLz3RRk+brjQ/x1joL7uhzn?=
 =?us-ascii?Q?MvOa0fTcSKRQWpy10tgI35xdBtsD1LXARxh60jX0fYIzggqUoHcAar5Ut8mb?=
 =?us-ascii?Q?M2ItInq/pWVfKiTpqsowvGfgybEo0IL9QvW+kZNjPtBD4j5DdpWkxLiH3/pd?=
 =?us-ascii?Q?4D/KTC/PIdwZVsaTUFkCSNLrBviAbwhbacJUpWj6HyQwVLu8PvXFoy1tWI+B?=
 =?us-ascii?Q?Q9ev0lNVrJoWcShtuxf0H+Ac2dVTMIPS8e5OOgMBj2+fPaMQL7s9agNu02Zj?=
 =?us-ascii?Q?+KcFvRhAdxipHpA+OiH3LmBnmwoOVqsPNcbak/xGXuc7ZKHizZdSj/410mYl?=
 =?us-ascii?Q?75xWkzgIF85FdsBsv2lG9R+80uIJ09ukseJ2jot386+rD7B2e9L3MGaxe3r/?=
 =?us-ascii?Q?XSFAF/QRIcqF+7IbfZTLKzYApU8EONPbuqiyyjWrbJKGXMbo08IKV42dez4k?=
 =?us-ascii?Q?/XMGpEb+KkxST3tJSd/Vinm76etbdq0cX2YzUOcjptZQlbZ1kvZ4gmWdD19M?=
 =?us-ascii?Q?TwSCHEoaFVffBOV3xyx++Rn/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8luCd9GMSV4XAjPAObcubNnnNyxHh7n4OO96ttca9mpopLxCAGS4oWq9i5Y?=
 =?us-ascii?Q?t5pO6OCOL76HD3vpvQXpErhZz5Q6/FszqBLi64I+3FIzryDMZOLBAMTrU3cU?=
 =?us-ascii?Q?MoteUReOo8hrhg2RrUhgrdBek+Arw1exi/h7243R/xxtLHb5jbbrDsqzMLSo?=
 =?us-ascii?Q?AKL8GZXwHbSVrtiZI00f1ogzCV0q6WXaJxAcbT1e7zHFaPwWwAq3gN36bR8T?=
 =?us-ascii?Q?lWwguil/pzqOgWu18K00zhwzB/wk/Nk8YyKdt2fyhwgCytaas7OI3T5ZX4G0?=
 =?us-ascii?Q?AvEe+ZXu1xRl4PbzAWsBZ3t3T1ltWpshVv3q6rBYTjHvlEo8XdG474G9Mk1c?=
 =?us-ascii?Q?G6E8aCr7BqmDSdfZf5EiyV7DEXlQnavqgxmF7dULf2PKhN7Wp9eSvQdl1Kiw?=
 =?us-ascii?Q?1OGtjDITRHLeaiBHmCqmelqxLZ5NlUmh4mspmhgLEfJ6EiVAY1XhzEtCi99r?=
 =?us-ascii?Q?zxDNc8dlhloG5DE+U2X+tx4BCi+uDkxjfrkw4Ak+PQdR2HwVni/AzcAVr0iY?=
 =?us-ascii?Q?i52Oq+Wov/KXS9Ma+3psSBIflE8FPnOV7L38dkV8mcUrl05FS/oTXg+ITGDO?=
 =?us-ascii?Q?1ZNXYQDsbLmAXxnyVGviMgNsLJTbK8M+OCa4p2ttbVqRzSoQhs2HGbeWOY24?=
 =?us-ascii?Q?z0iuLgetGdDcQY54vcqgPWQqtF4OU3moLHh19HOkWwfN8kvj6NJrKXT966kY?=
 =?us-ascii?Q?e/nPsLsfTcFb9861q/UwHp52LULBOpb5HX+77o8SjIi7Yg3onhpeGZnOtuF1?=
 =?us-ascii?Q?PBTNpt66icFj0dFLJuN9nhe98fAd+E4Hq98wBJ4Ubi8IzRHhFXsziDTtnIMx?=
 =?us-ascii?Q?itep6AKn50rMjZcGS43CXA2m/FN8yezkrBpw+lPeIaxIaQ7VEXXrcSUqptHE?=
 =?us-ascii?Q?Djj2VgNwUr5KAYWqmqLV9eso+u+CJtum4VwJjKaePPzO18diWTAzi+jdEmR+?=
 =?us-ascii?Q?qQtffmK4H7D7CPSG2dQPiPZSU0Y2pectTAIWTXqIPKVhm12Ir2VcUYr7wfZY?=
 =?us-ascii?Q?zDEDawz7n/aX+w0TvCW0MKau+krIRTIFY/Hz1cM0Nnwj9BdY259YF2GtU1Jl?=
 =?us-ascii?Q?B+aM5BdOX+31QK4fPorr2sFyIrqajzcUiDK5onWbSOdkQ717+a7p8m0hO083?=
 =?us-ascii?Q?rNEf4HtILgmH1r12/lM8xJ566I9nED3FP2Sqffz4eKEd+dff+VS1Z5KESo1o?=
 =?us-ascii?Q?Y6alsnel/fSP1y28zRc6z2P7tjuVfyx/eLEeLtnAqPwW5NGZ112Bg/epVoYn?=
 =?us-ascii?Q?tPWDj67m/+Z94VnlJ8iZslrwyN9FD8lO3vmY72oyTpuRk8r3x76cg/CzcJ2T?=
 =?us-ascii?Q?WErwkFp4vP3C8y9v0zT24MZ/wY5WYzHJNtmOQAbhp8VbtvYk3O7gKb50iAdy?=
 =?us-ascii?Q?KTwci6VpnyV2JGECNCS5cwtv8clHiZsjIBgQpnyGUiLPnEwxI7UZ7eM0cVQE?=
 =?us-ascii?Q?e6NV0TbUQPN/WUm6CTsVAoU97WlJbxyKldA0hbKMota+wv1NNryCLshuz5CR?=
 =?us-ascii?Q?hz/AWRFk6W99zzTEMZ4lVLY3hHnTfL/xo/NMKPCkVsQx/4VOzynQ169NdGML?=
 =?us-ascii?Q?0ZFjsFF/+X0YcOmjmJqt3U5rpTGBE1QqlqWV20mq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaa6393-bb27-4204-9211-08dcfd4a1950
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:29:47.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCUQTBHC0mJpI5AoBEAJSKhTxpg6avqGFm7SS/yRuLmw3mAvtia35KSsaxn22ISXE5pshLxDhqnORK7fupfEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

commit 53ba78de064b ("mm/gup: introduce
check_and_migrate_movable_folios()") created a new constraint on the
pin_user_pages*() API family: a potentially large internal allocation
must now occur, for FOLL_LONGTERM cases.

A user-visible consequence has now appeared: user space can no longer
pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
PAGE_SIZE system, when user space tries to (indirectly, via a device
driver that calls pin_user_pages()) pin 2GB, this requires an allocation
of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
kmalloc().

In addition to the directly visible effect described above, there is
also the problem of adding an unnecessary allocation. The **pages array
argument has already been allocated, and there is no need for a
redundant **folios array allocation in this case.

Fix this by avoiding the new allocation entirely. This is done by
referring to either the original page[i] within **pages, or to the
associated folio. Thanks to David Hildenbrand for suggesting this
approach and for providing the initial implementation (which I've tested
and adjusted slightly) as well.

Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: linux-stable@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 116 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4637dab7b54f..0f5121ad0b9f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2273,20 +2273,57 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
+
+/*
+ * An array of either pages or folios ("pofs"). Although it may seem tempting to
+ * avoid this complication, by simply interpreting a list of folios as a list of
+ * pages, that approach won't work in the longer term, because eventually the
+ * layouts of struct page and struct folio will become completely different.
+ * Furthermore, this pof approach avoids excessive page_folio() calls.
+ */
+struct pages_or_folios {
+	union {
+		struct page **pages;
+		struct folio **folios;
+		void **entries;
+	};
+	bool has_folios;
+	long nr_entries;
+};
+
+static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
+{
+	if (pofs->has_folios)
+		return pofs->folios[i];
+	return page_folio(pofs->pages[i]);
+}
+
+static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
+{
+	pofs->entries[i] = NULL;
+}
+
+static void pofs_unpin(struct pages_or_folios *pofs)
+{
+	if (pofs->has_folios)
+		unpin_folios(pofs->folios, pofs->nr_entries);
+	else
+		unpin_user_pages(pofs->pages, pofs->nr_entries);
+}
+
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
 static unsigned long collect_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
 {
 	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio == prev_folio)
 			continue;
@@ -2327,16 +2364,15 @@ static unsigned long collect_longterm_unpinnable_folios(
  * Returns -EAGAIN if all folios were successfully migrated or -errno for
  * failure (or partial success).
  */
-static int migrate_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+static int
+migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
+				   struct pages_or_folios *pofs)
 {
 	int ret;
 	unsigned long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio_is_device_coherent(folio)) {
 			/*
@@ -2344,7 +2380,7 @@ static int migrate_longterm_unpinnable_folios(
 			 * convert the pin on the source folio to a normal
 			 * reference.
 			 */
-			folios[i] = NULL;
+			pofs_clear_entry(pofs, i);
 			folio_get(folio);
 			gup_put_folio(folio, 1, FOLL_PIN);
 
@@ -2363,8 +2399,8 @@ static int migrate_longterm_unpinnable_folios(
 		 * calling folio_isolate_lru() which takes a reference so the
 		 * folio won't be freed if it's migrating.
 		 */
-		unpin_folio(folios[i]);
-		folios[i] = NULL;
+		unpin_folio(pofs_get_folio(pofs, i));
+		pofs_clear_entry(pofs, i);
 	}
 
 	if (!list_empty(movable_folio_list)) {
@@ -2387,12 +2423,26 @@ static int migrate_longterm_unpinnable_folios(
 	return -EAGAIN;
 
 err:
-	unpin_folios(folios, nr_folios);
+	pofs_unpin(pofs);
 	putback_movable_pages(movable_folio_list);
 
 	return ret;
 }
 
+static long
+check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
+{
+	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
+
+	collected =
+		collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
+}
+
 /*
  * Check whether all folios are *allowed* to be pinned indefinitely (long term).
  * Rather confusingly, all folios in the range are required to be pinned via
@@ -2417,16 +2467,13 @@ static int migrate_longterm_unpinnable_folios(
 static long check_and_migrate_movable_folios(unsigned long nr_folios,
 					     struct folio **folios)
 {
-	unsigned long collected;
-	LIST_HEAD(movable_folio_list);
+	struct pages_or_folios pofs = {
+		.folios = folios,
+		.has_folios = true,
+		.nr_entries = nr_folios,
+	};
 
-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       nr_folios, folios);
-	if (!collected)
-		return 0;
-
-	return migrate_longterm_unpinnable_folios(&movable_folio_list,
-						  nr_folios, folios);
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 
 /*
@@ -2436,22 +2483,13 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	struct folio **folios;
-	long i, ret;
+	struct pages_or_folios pofs = {
+		.pages = pages,
+		.has_folios = false,
+		.nr_entries = nr_pages,
+	};
 
-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios) {
-		unpin_user_pages(pages, nr_pages);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < nr_pages; i++)
-		folios[i] = page_folio(pages[i]);
-
-	ret = check_and_migrate_movable_folios(nr_pages, folios);
-
-	kfree(folios);
-	return ret;
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-- 
2.47.0


