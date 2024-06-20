Return-Path: <linux-kernel+bounces-221951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5192A90FB05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DA32839BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5213AF9;
	Thu, 20 Jun 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb8y+Fo2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8FD51A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847662; cv=none; b=UeIVTiAC/hAgbMJVpIMEpm7eVlGwYn1XmNT266U+C3b7eGu/sAJ/JK9T9/YOtLfFuaSa8oDbdNLlYTrRCKVe2MM6Rk0tf+XWDiSaj8IwUn8YRuT2/2DrRumQOgWGzONEE9TTE3FjIXEibE5aBvG6JGdVBCc1cQpi1zS0pRUS/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847662; c=relaxed/simple;
	bh=LP2tOkOMhutAVVXDuLDlX3nRyAhc0XWkEXUb6AMUzzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKgI3CTFbPrUzf2KcTl5sRF3/hjWkChSfA6h6ax19pvyhfEdvDlAJ+aWNgA6Sx0j0YQ4BR7jo1fUgYz6yScIVF7/BDjWnxSH0cOmphGIvS55X5+rDzzppPbyhpdLfcqTkJvI0bMGug1R8wyi2TKT09k1MHYpH8yqLrUgbZsPXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb8y+Fo2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718847660; x=1750383660;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LP2tOkOMhutAVVXDuLDlX3nRyAhc0XWkEXUb6AMUzzU=;
  b=Hb8y+Fo2VtKPZzwRpIorZfOgzsPvl2hTySXbjymEC7p9fLAzKbfu0kQ6
   1U/HTEA69Bu95DFYqC9aY0qaiB0WnxZxeV3IRBUWJwW+QDZwh7sGJ43bF
   fu4B4x5h7PWY1fYSf0GR9NvOqVeh9g1faKM7IAxyoizKvK+kX4jepps8t
   6jN1kYZtcaTzTKpxW+JyKzmCLYniexRnrNt4JGJ2J8P1li3Bm+5Oto5eU
   U4+WnwL2h2k9exvlNSdo8wMHSRci9LFD4HBPUNrqnWczF94pW8pLbAM9X
   sF0ITTP5+I3jdDlA++EcwcEfwT2dZEscn4oX8mpAj7AvIvvBBRQzUYcP1
   Q==;
X-CSE-ConnectionGUID: F5XtlrXTRteSC2dS9+p8qg==
X-CSE-MsgGUID: w55il8+9Si2/p9K/P4yomQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15678916"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15678916"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:41:00 -0700
X-CSE-ConnectionGUID: yNQNvFjaTCKUpo5ao7HG3w==
X-CSE-MsgGUID: x10nX40/TgKT/VnrqFOT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46996840"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:40:57 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Hugh Dickins
 <hughd@google.com>,  linux-mm@kvack.org,  Zi Yan <ziy@nvidia.com>,
  "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Yang Shi
 <shy828301@gmail.com>,  David Hildenbrand <david@redhat.com>,  Yin Fengwei
 <fengwei.yin@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: make migrate_pages_batch() stats
 consistent.
In-Reply-To: <20240620012712.19804-1-zi.yan@sent.com> (Zi Yan's message of
	"Wed, 19 Jun 2024 21:27:12 -0400")
References: <20240620012712.19804-1-zi.yan@sent.com>
Date: Thu, 20 Jun 2024 09:39:05 +0800
Message-ID: <874j9o4cli.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
> calling migrate_pages_batch().
>
> Because if not, when migrate_pages_batch() is called via
> migrate_pages(MIGRATE_ASYNC), nr_thp_failed will not be increased and
> when migrate_pages_batch() is called via migrate_pages(MIGRATE_SYNC*),
> nr_thp_failed will be increase in migrate_pages_sync() by
> stats->nr_thp_failed += astats.nr_thp_split.
>
> [1] https://lore.kernel.org/linux-mm/87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com/
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/migrate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 66c74b89d3de..781979567f64 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1645,6 +1645,10 @@ static int migrate_pages_batch(struct list_head *from,
>  			 * migrate_pages() may report success with (split but
>  			 * unmigrated) pages still on its fromlist; whereas it
>  			 * always reports success when its fromlist is empty.
> +			 * stats->nr_thp_failed should be increased too,
> +			 * otherwise stats inconsistency will happen when
> +			 * migrate_pages_batch is called via migrate_pages()
> +			 * with MIGRATE_SYNC and MIGRATE_ASYNC.
>  			 *
>  			 * Only check it without removing it from the list.
>  			 * Since the folio can be on deferred_split_scan()
> @@ -1661,6 +1665,7 @@ static int migrate_pages_batch(struct list_head *from,
>  			   !list_empty(&folio->_deferred_list)) {
>  				if (try_split_folio(folio, split_folios) == 0) {
>  					nr_failed++;
> +					stats->nr_thp_failed += is_thp;
>  					stats->nr_thp_split += is_thp;
>  					stats->nr_split++;
>  					continue;
>
> base-commit: 7c4c5a2ebbcea9031dbb130bb529c8eba025b16a

