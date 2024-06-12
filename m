Return-Path: <linux-kernel+bounces-210971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD55904B80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AA2285247
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC3167D87;
	Wed, 12 Jun 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLncFwkN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34913CAA7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173273; cv=none; b=Sm3dJ5QAHMxAVSBNHMQGCMY2Z7deRMqhe1oE99mKwXMnaY5p8wTgw2+BAPJzvBcEGORgv5pnFke8qj8uXvq1HYYWBnZyaYToM0EVkQru3zpBKzcMzM336Xi/IxrkyeBigsJr+N6qVUAK5Mcl2sLM9XYlcfC4ZsH5KinhwnsuX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173273; c=relaxed/simple;
	bh=htK3JGDzZ50RrcVE9SiM5Fksd2VJ/2WYnYQ5LvzPLBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdqqO5w2DO6GA8v3ThxbyMvTG0ij0UZ6XKxAGogjbYtNWyVEMJvrpjTlHWcfZkrvDmW31hkBBNL6OVOJNTPKv8EdWQpX8e7ucoIMHTfntIi+BjtsJvHvdFnr//wA+2yIwvo2gPcWMO2+9GSmXkEEWRWEyJqKvdNAgF/2xj5sclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLncFwkN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718173271; x=1749709271;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=htK3JGDzZ50RrcVE9SiM5Fksd2VJ/2WYnYQ5LvzPLBY=;
  b=kLncFwkNMl35aqXeCr+1JpYz9QEHENNWCpZLJUmSo145BvSbGvImc0kK
   COMJqDUie5JDgyJkRGn3l9aR/9sN21/EXhIdTSzba+uT7TgI4019FP2lD
   IE+gsz+uWc3f7Xsu4VNwolw6v0w9JiApSHe9kgwjcuG4twJbf+MHBqa/j
   gsGHcKLsPtRdoFIigPeySHx5JiOk82H73FhgtROZVrTg/7bojYFHQ5DJh
   BjaI2ESq0aYB5A3CMtOxaYSK+o+ZmSs5fDLmZh7kwFepqivr8xoIcQiLI
   j4YS3u1/g++l3I2ajgCUS6SukGVhrLgqtPvXrqh7iZQXi78wx5zZkCw1H
   w==;
X-CSE-ConnectionGUID: TWKm0amRQde7OHOnmPZdLw==
X-CSE-MsgGUID: Me833cOrTFCgzBwD1UquDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18699012"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18699012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:21:11 -0700
X-CSE-ConnectionGUID: 3x1SUSrQSIGBA4eo9xt7lQ==
X-CSE-MsgGUID: hNXSG1BbSwK2yLWSV/Ej9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40309738"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:21:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Zi Yan <ziy@nvidia.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at mm/compaction.c:2761!
In-Reply-To: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com> (Hugh Dickins's
	message of "Tue, 11 Jun 2024 22:06:20 -0700 (PDT)")
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
Date: Wed, 12 Jun 2024 14:19:17 +0800
Message-ID: <87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hugh Dickins <hughd@google.com> writes:

> I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();
> and if DEBUG_VM were off, then pages would be lost on a local list.
>
> Our convention is that if migrate_pages() reports complete success (0),
> then the migratepages list will be empty; but if it reports an error or
> some pages remaining, then its caller must putback_movable_pages().
>
> There's a new case in which migrate_pages() has been reporting complete
> success, but returning with pages left on the migratepages list: when
> migrate_pages_batch() successfully split a folio on the deferred list,
> but then the "Failure isn't counted" call does not dispose of them all.
>
> Since that block is expecting the large folio to have been counted as 1
> failure already, and since the return code is later adjusted to success
> whenever the returned list is found empty, the simple way to fix this
> safely is to count splitting the deferred folio as "a failure".
>
> Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> A hotfix to 6.10-rc, not needed for stable.
>
>  mm/migrate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head *from,
>  
>  			/*
>  			 * The rare folio on the deferred split list should
> -			 * be split now. It should not count as a failure.
> +			 * be split now. It should not count as a failure:
> +			 * but increment nr_failed because, without doing so,
> +			 * migrate_pages() may report success with (split but
> +			 * unmigrated) pages still on its fromlist; whereas it
> +			 * always reports success when its fromlist is empty.
> +			 *
>  			 * Only check it without removing it from the list.
>  			 * Since the folio can be on deferred_split_scan()
>  			 * local list and removing it can cause the local list
> @@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head *from,
>  			if (nr_pages > 2 &&
>  			   !list_empty(&folio->_deferred_list)) {
>  				if (try_split_folio(folio, split_folios) == 0) {
> +					nr_failed++;

It appears better to add

        stats->nr_thp_failed++;

too.  Otherwise, if migrate_pages_batch() is called via migrate_pages(,
MIGRATE_ASYNC, ), nr_thp_failed will not increase.  But if
migrate_pages_batch() is called via migrate_pages(, MIGRATE_SYNC*, ),
nr_thp_failed will increase in migrate_pages_sync() via

        stats->nr_thp_failed += astats.nr_thp_split;

That is, they are not consistent.  The issue exists since commit
7262f208ca68 ("mm/migrate: split source folio if it is on deferred split
list").

Otherwise, this looks good to me.  Thanks!

>  					stats->nr_thp_split += is_thp;
>  					stats->nr_split++;
>  					continue;

--
Best Regards,
Huang, Ying

