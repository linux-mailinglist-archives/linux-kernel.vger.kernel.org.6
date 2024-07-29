Return-Path: <linux-kernel+bounces-264960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BFB93EA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854B11C2114D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED87E112;
	Mon, 29 Jul 2024 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIwVbaam"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DC7D095
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217299; cv=none; b=T0jmv7NrWNm9vMIrCsTmfUEXW51rUASw6dvnQxv/lB1uqYPthypaLerYfsAi/1QkKsS5+ae/AUY4hYQYTHKYM0pSBKSUW0nCagpRQ8tcIkpA0J+/ithfArQ6QnlBeK3YGhwhYClrjgVK2pym1i6axNCuPqlEY5gaL7+MVIQkCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217299; c=relaxed/simple;
	bh=uh0eBmCXbZHpjajD6vccLotxjYSai5IciHgQNK5l0+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=to4dvIYMMTt/x0hy+Spj4Ko8J6gDV8z2VeM5i3fcGxt8ZnE1srcCXCDdm1ceKRefcLGer9Sbuh++tpAcGd0hGMfqIee4wk9o7hp0yPY8bOZsF9/srpFRvTFTSqPmU6m3UO/slQI8MDoDK3UzFTwKSWk4LnWq/nP6iXiBzL0S7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIwVbaam; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722217298; x=1753753298;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uh0eBmCXbZHpjajD6vccLotxjYSai5IciHgQNK5l0+U=;
  b=SIwVbaamqh9WDV5vnXhAfxVi9X9BixrtG1EePEpBzI1bI2arzXMUTkPm
   ntpuv5C+Sdo/9qVVM38J4dwpJ4VwPBOdCW1cR5pJGjPEbbJJfX+o1lQif
   9Ho8yv/amFRiEHyCT0kRCi+imIBsUyLsEbfbC4gKbPrhP41hCnvDjd0Ap
   JFk9t7JE7Zx6XwaJm6KTP/Zthe/VdcgozznKS9YtbzkWUyo5W9kfJsO0r
   cgEaIXLnDnX7ZxiEkJwxgJZC2jNBIfZIup/lztrekRtKFPhfYUJauvqg5
   o+r5AH8IiCerszornCvl9KJBZZVF+nsETrDBzqzcVpwRYs8gsHgR95VPR
   Q==;
X-CSE-ConnectionGUID: AQa287JdTEOSoAiOGWJR/Q==
X-CSE-MsgGUID: +0kXzBFcQ5ubliuj+prdiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20079580"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20079580"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 18:41:37 -0700
X-CSE-ConnectionGUID: MVt0tDl5T3yrBqBs+YW+Qw==
X-CSE-MsgGUID: grbf3j9ORR+Xc7ow14Qolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53473307"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 18:41:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
In-Reply-To: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com> (Gao
	Xiang's message of "Sun, 28 Jul 2024 23:49:13 +0800")
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
Date: Mon, 29 Jul 2024 09:38:01 +0800
Message-ID: <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Xiang,

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> Currently, migrate_pages_batch() can lock multiple locked folios
> with an arbitrary order.  Although folio_trylock() is used to avoid
> deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
> asynchronously firstly") mentioned, it seems try_split_folio() is
> still missing.
>
> It was found by compaction stress test when I explicitly enable EROFS
> compressed files to use large folios, which case I cannot reproduce with
> the same workload if large folio support is off (current mainline).
> Typically, filesystem reads (with locked file-backed folios) could use
> another bdev/meta inode to load some other I/Os (e.g. inode extent
> metadata or caching compressed data), so the locking order will be:
>
>   file-backed folios  (A)
>      bdev/meta folios (B)
>
> The following calltrace shows the deadlock:
>    Thread 1 takes (B) lock and tries to take folio (A) lock
>    Thread 2 takes (A) lock and tries to take folio (B) lock
>
> [Thread 1]
> INFO: task stress:1824 blocked for more than 30 seconds.
>       Tainted: G           OE      6.10.0-rc7+ #6
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:stress          state:D stack:0     pid:1824  tgid:1824  ppid:1822   flags:0x0000000c
> Call trace:
>  __switch_to+0xec/0x138
>  __schedule+0x43c/0xcb0
>  schedule+0x54/0x198
>  io_schedule+0x44/0x70
>  folio_wait_bit_common+0x184/0x3f8
> 			<-- folio mapping ffff00036d69cb18 index 996  (**)
>  __folio_lock+0x24/0x38
>  migrate_pages_batch+0x77c/0xea0	// try_split_folio (mm/migrate.c:1486:2)
> 						// migrate_pages_batch (mm/migrate.c:1734:16)
> 		<--- LIST_HEAD(unmap_folios) has
> 			..
> 			folio mapping 0xffff0000d184f1d8 index 1711;   (*)
> 			folio mapping 0xffff0000d184f1d8 index 1712;
> 			..
>  migrate_pages+0xb28/0xe90
>  compact_zone+0xa08/0x10f0
>  compact_node+0x9c/0x180
>  sysctl_compaction_handler+0x8c/0x118
>  proc_sys_call_handler+0x1a8/0x280
>  proc_sys_write+0x1c/0x30
>  vfs_write+0x240/0x380
>  ksys_write+0x78/0x118
>  __arm64_sys_write+0x24/0x38
>  invoke_syscall+0x78/0x108
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x3c/0x148
>  el0t_64_sync_handler+0x100/0x130
>  el0t_64_sync+0x190/0x198
>
> [Thread 2]
> INFO: task stress:1825 blocked for more than 30 seconds.
>       Tainted: G           OE      6.10.0-rc7+ #6
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:stress          state:D stack:0     pid:1825  tgid:1825  ppid:1822   flags:0x0000000c
> Call trace:
>  __switch_to+0xec/0x138
>  __schedule+0x43c/0xcb0
>  schedule+0x54/0x198
>  io_schedule+0x44/0x70
>  folio_wait_bit_common+0x184/0x3f8
> 			<-- folio = 0xfffffdffc6b503c0 (mapping == 0xffff0000d184f1d8 index == 1711) (*)
>  __folio_lock+0x24/0x38
>  z_erofs_runqueue+0x384/0x9c0 [erofs]
>  z_erofs_readahead+0x21c/0x350 [erofs]       <-- folio mapping 0xffff00036d69cb18 range from [992, 1024] (**)
>  read_pages+0x74/0x328
>  page_cache_ra_order+0x26c/0x348
>  ondemand_readahead+0x1c0/0x3a0
>  page_cache_sync_ra+0x9c/0xc0
>  filemap_get_pages+0xc4/0x708
>  filemap_read+0x104/0x3a8
>  generic_file_read_iter+0x4c/0x150
>  vfs_read+0x27c/0x330
>  ksys_pread64+0x84/0xd0
>  __arm64_sys_pread64+0x28/0x40
>  invoke_syscall+0x78/0x108
>  el0_svc_common.constprop.0+0x48/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x3c/0x148
>  el0t_64_sync_handler+0x100/0x130
>  el0t_64_sync+0x190/0x198
>
> Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20cb9f5f7446..a912e4b83228 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1483,7 +1483,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>  {
>  	int rc;
>  
> -	folio_lock(folio);
> +	if (!folio_trylock(folio))
> +		return -EAGAIN;
>  	rc = split_folio_to_list(folio, split_folios);
>  	folio_unlock(folio);
>  	if (!rc)

Good catch!  Thanks for the fixing!

The deadlock is similar as the one we fixed in commit fb3592c41a44
("migrate_pages: fix deadlock in batched migration").  But apparently,
we missed this case.

For the fix, I think that we should still respect migrate_mode because
users may prefer migration success over blocking.

@@ -1492,11 +1492,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	return rc;
 }
 
-static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
+static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
+				  enum migrate_mode mode)
 {
 	int rc;
 
-	folio_lock(folio);
+	if (mode == MIGRATE_ASYNC) {
+		if (!folio_trylock(folio))
+			return -EAGAIN;
+	} else {
+		folio_lock(folio);
+	}
 	rc = split_folio_to_list(folio, split_folios);
 	folio_unlock(folio);
 	if (!rc)


--
Best Regards,
Huang, Ying

