Return-Path: <linux-kernel+bounces-399323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198D9BFD74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D9D284085
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E01898FC;
	Thu,  7 Nov 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmDuaeBL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F9EC0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730955468; cv=fail; b=BhRWHTzwU9VmK6aoJ3mhKyLc3eXnyVVjOf0x47VIr2N0OA0zJlUDkSiVcc9xu3DRC5H4Ul3JoN02nNbtar/CmT03kX4Ovx+6YthMDdGlk0l1G51bvC62YWXWOT/3+SnL/VgWz9MxnOUp3bmFqFAA9KDDDLhc+6uHXu+G3yEiet0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730955468; c=relaxed/simple;
	bh=IqZPBV0bIOjVPvltzGUM9tn0F7VHOVv+mhmHH3v5Jk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GFNXvg2LNdy7ixUrpgNc5iXQVG6a8GWc4yvRgq4E6wJVK4t5hHdK6HTygQq/9Vo+CD/H9aRnnstCwv9+61544lxKyQazRnVHMyr33YLdz/eZ1ut0leVamLLePVCn0j9AvtmayNpaiFNrgM9HtIqpV/VOtS2JEwd0QHzbBvqCwwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmDuaeBL; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCtFWJFj8mQYOXeg8p/Gd/W/rz4RmwLORVmK2NwS32xOOAmRLnco1e8feQk876oDMSXjYMg24QKVwcuQ/WCqzWntcTNelWmygxOa72zlA7JS8pT4fAWmsrovQv1D5VNd4cdzxEKf7n29cxjlyZ41UPGepoN3B6LjDKGZH9m2TT7UZosTQX4sBysD6Nwmov9ICBP4DKVhsB+UDo+wZ/LrQg4j9ZqlL4DXRjeG46H/6ihDm2/ltEDi4Si2CeZXSwRDoCifqI6s4oz05cE4T34uNwHgw83+cuA1xwDJtPb8fjXNyuo/2l7NNBXDyuf+vbavL/34K5DyuldOQPmmaECDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUEoSiOSst9JkNifn00xI5TE3pWfd+xO+FyxjfbPKuU=;
 b=IFcooKF7h0QJzUsxYIkeS8qZATTt/GVeuBU2+/DNy3KZIjxSP901rkc9wq2L1IjFCgZidzz3OBbQ01VvNKu4xM9aNs95+yJf9O/w/VGmcnqLgpPHyIh4GOzWFDHc0TS0qXO9Kx7quBhZGnEpx/tlgkhQuv04hDYTvwcJ/jq6fJH2I8oyDDv4gEHI+zMIXFu4alNNdOllrRHLuZAjhrbREq95QX7wtw/sqfSW1FZMzTdFjuYASRt7Dl6PZ2KDozbepRvyozqkfNqKVYtA8LCtCPLf+vIw+oy24CSIIwo0cmNpUXFLroA4kJ5A+TqHOZgZ+TuBoQYvdRaE1cLk566Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUEoSiOSst9JkNifn00xI5TE3pWfd+xO+FyxjfbPKuU=;
 b=NmDuaeBL+nCc5hfjoNHAQLMfj15LEkxcjz1VV8lWSAQd27zCeXPbhoLAXiM1en734G4SbL0DLG2KzCSGSVyPrpSR5SuwKyYnNv5NRTfqMoZTIoRxSwwFUcmxZzsJEMzXces0UQT1vw14WG+NNUqoCmKyHsCBS94jZV2VaXfialvf2jLmToLuN3Oh5q6zmjVrPzy0SLHiNyDdQr4VZtlQUjMTnu/BAgxdQcaRgY37kIHKvlJvkgWjSQq1Z4iz2SepHNn5gsz822JfGHotmPisQsaKOWX8dShEneegNgf9ivTn7nID/vPkCPL+8kEF68mJ5FSV1YkeO8lgIfOatoqkZg==
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 04:57:43 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::c9) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 04:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 04:57:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 20:57:26 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 20:57:26 -0800
Message-ID: <8943a8bd-644f-48fe-8502-6150c993c445@nvidia.com>
Date: Wed, 6 Nov 2024 20:57:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/gup: avoid an unnecessary allocation call for
 FOLL_LONGTERM cases
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann
	<kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig
	<hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>, Peter Xu
	<peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins
	<hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>, Mike Kravetz
	<mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>,
	<linux-stable@vger.kernel.org>
References: <20241105032944.141488-1-jhubbard@nvidia.com>
 <f747223e-042f-40f4-841c-1c8019dc8510@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f747223e-042f-40f4-841c-1c8019dc8510@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7265d4-568b-44f0-0621-08dcfee8b6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L043dG9yOWlyemUvSjlrbW83OGFyempxUFZPNFV3c1VvK0hLMnUvUFY1S3B0?=
 =?utf-8?B?T0ZUZ1Bqd3JSazlGMllDeE5qblh3bTJ2VTZucWtGNnF1dDdRSEtqcXhwbGhQ?=
 =?utf-8?B?N1dpVUhMYzhXRnNVVE16akJXUTFGUEVoNklJOUF0VitGcVUxOHU1VElyeXc0?=
 =?utf-8?B?cnE2clhVb3ZqdTVoRDBjRFRTY3BBOTFaYmxEeFdxbm9yTitsL0Z2alFQZG1D?=
 =?utf-8?B?cDQ2M29jaXpUZSsvYU1PeVJBK2gxeHEyQm9VZUlsU01oOUNNaHA4WmRCQ0pi?=
 =?utf-8?B?SXFOR0RJelBvZkJwOVh1UHZ5Zi9rbldIelNvRE5aVVBaNDZOV2JEalB3NEhD?=
 =?utf-8?B?Sm4wRlhEVzhaZkp0YjlOTXRJWGMvTlRIVGRqLytVeEZHU3FCRjMyK2FMSWxs?=
 =?utf-8?B?d1A1eTZXOThPUnBCVmhnR2JJRWpCV2c1NnJTSU1TSkpqQVZ5UDVib0JMaDRN?=
 =?utf-8?B?L0RpSmlFbHYyTmp3YS82Z1lSNGI1VW5zcjZtVEVKd0xiV1o1Yk1ZbEVKVVdC?=
 =?utf-8?B?T0hGMENEVTR2d3RObmNTckFjdEpjZENkUmY0cDJNWFRHZHdZa2QyUnFLOEht?=
 =?utf-8?B?QmExMDdFbVpsSGpiVVdzOWtDUVg1TExSaURrenhLVzNnRmY2MUtnekdPZnly?=
 =?utf-8?B?L1QwWUY3K1o1NkNxeno3UHYzb0V3c3VnSUxxenBRMGRmMXZ0YjlvcUUwdkRV?=
 =?utf-8?B?Vm5qelJWSTZhUnFhR1c2L1BYMFRkSkJYQkJONzJpWVhLRktJOFBsSExNZFl0?=
 =?utf-8?B?ajh6ckg1K1NmVWlPRjhnYnNCeFBHc0ZTdW00SzRhdXBKOE9yd0ovWmFjWGZC?=
 =?utf-8?B?TEE2RXE2V2ZPTU1NN1BPNURPWlVjVG9RL1VsYzMzb0ErMEJtaUFEV1p0RVZq?=
 =?utf-8?B?RE9BUHByWFN5d0dKY0p1MHppVnFuVExVTnNQVXNtQmc0MGYyZ3p6Nzhrdkoy?=
 =?utf-8?B?RWU2cERFWU0rT2NlTlMwVStFY1A5S3lORDM4b0pudENEQmFYNmVaWWJuT2dT?=
 =?utf-8?B?dlNCeVNyYUJScktaZ21hS1ZuZXpBU2ZUMFJLYVA2L0RlS1BYbmNuVXE3THVT?=
 =?utf-8?B?Wk12OGNneUR6MVcrcCs3RTN5SEc4d2JvWlh4cXlPSG1kZTQ5UVJ3UTBUYmoy?=
 =?utf-8?B?MWFucWVUUU5sS050aHpUMFg5SzF0QUdtTVF0RWd6VnNVTWJ4V1d6VTV3SnRv?=
 =?utf-8?B?WG9LaHlmNkFmdXJUcy9yNFNyVjc3NnFwV2tOOCtBcWJtYXFQSUMwOGhQVjJY?=
 =?utf-8?B?VWxXWmZHVHplcm9GSlJKcFlrWVQ0dGxINXRHdW02Nkl3dmJZbHZySCtYeUJN?=
 =?utf-8?B?aVllVGlINjFrNDBSOWJLZ2dBcDNpbjdQaGJhbXhaWStWTDV0d3o3dnRUb0py?=
 =?utf-8?B?WGE4OC96Nk9lcVh1NnJ3d0RpTWhkNUxpWDd1c3N3a0tCZXZWQzA4S2x5dVhO?=
 =?utf-8?B?ZFZUcVM1S2VaY2RNcGlCOS9kTjU1anZCOElvSzR2MGxIb2t3dkV4Z0dveVRR?=
 =?utf-8?B?cEJGa0V4NUtQTTQrUzdQN3Jwd2o1cVk4MFNXOWM1cVVQNURPZDRLdEc1bnlF?=
 =?utf-8?B?ejJMN1FhMm4raDFxWk9vU0hub01KcFRGL3dsQS9OYXdrdWRQaE1nSTl6VkxY?=
 =?utf-8?B?STZvd2ZYcjFzQzdMdTFpWU81aFUyc2pLQittSFFvclY4NDM3Tlc3Z3hIbXI2?=
 =?utf-8?B?Q0JWVVJBT2Uxb1FneHhkSXE1aXEzN3NaMS9aRmUyeGZ4RWVZckloV1N6UU5Y?=
 =?utf-8?B?L2NMMHpadW01SDMzcXFwRWdqOEtYOUdzSXYvUlBmUFlJQUVaUTRMMXNoRzJl?=
 =?utf-8?B?NFBwM2xxWVVpUTg4cnNsbG0yb0ZDdFErQ1VqVldCR0ZQNDdBYkxDUkJWQk1Z?=
 =?utf-8?B?M0cvOUhQTVhnUnVhbDRuVmJtN2xQbjVyVGlnVnJ0TXQ3U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 04:57:43.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7265d4-568b-44f0-0621-08dcfee8b6f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

On 11/5/24 12:42 AM, David Hildenbrand wrote:
> On 05.11.24 04:29, John Hubbard wrote:
...
> Yeah, I was only adding it because I stumbled over it. It might not be a problem, because we simply "skip" if we find a folio that was already isolated (possibly by us). What might happen is that we unnecessarily drain the LRU.
> 
> __collapse_huge_page_isolate() scans the compound_pagelist() list, before try-locking and isolating. But it also just "fails" instead of retrying forever.
> 
> Imagine the page tables looking like the following (e.g., COW in a MAP_PRIVATE file mapping that supports large folios)
> 
>                ------ F0P2 was replaced by a new (small) folio
>               |
> [ F0P0 ] [ F0P1 ] [ F1P0 ] [F0P3 ]
> 
> F0P0: Folio 0, page 0
> 
> Assume we try pinning that range and end up in collect_longterm_unpinnable_folios() with:
> 
> F0, F0, F1, F0
> 
> 
> Assume F0 and F1 are not long-term pinnable.
> 
> i = 0: We isolate F0
> i = 1: We see that it is the same F0 and skip
> i = 2: We isolate F1
> i = 3: We see !folio_test_lru() and do a lru_add_drain_all() to then
>         fail folio_isolate_lru()
> 
> So the drain in i=3 could be avoided by scanning the list, if we already isolated that one. Working better than I originally thought.

Thanks for spelling out that case, I was having trouble visualizing it,
but now it's clear.

OK, so looking at this, I think it could be extended to more than just
"skip the drain". It seems like we should also avoid counting the folio
(the existing code seems wrong).

So I think this approach would be correct, does it seem accurate to
you as well? Here:

diff --git a/mm/gup.c b/mm/gup.c
index ad0c8922dac3..ab8e706b52f0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2324,11 +2324,21 @@ static unsigned long collect_longterm_unpinnable_folios(
  
  	for (i = 0; i < pofs->nr_entries; i++) {
  		struct folio *folio = pofs_get_folio(pofs, i);
+		struct folio *tmp_folio;
  
+		/*
+		 * Two checks to see if this folio has already been collected.
+		 * The first check is quick, and the second check is thorough.
+		 */
  		if (folio == prev_folio)
  			continue;
  		prev_folio = folio;
  
+		list_for_each_entry(tmp_folio, movable_folio_list, lru) {
+			if (folio == tmp_folio)
+				continue;
+		}
+
  		if (folio_is_longterm_pinnable(folio))
  			continue;



I need to test this more thoroughly, though, with a directed gup test (I'm not sure we
have one yet).
  

thanks,
-- 
John Hubbard


