Return-Path: <linux-kernel+bounces-265000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4406A93EB02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A121C2154E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7DE78C9E;
	Mon, 29 Jul 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMUUHY5l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4E7580D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219304; cv=none; b=Tc6AsVAI9OieT54futK7Wwwy3qbKuCSgln/TACJuHWdVKz66p1kSviNYe/4OHiOckSAvRX6kzjtUo4FxR4QvMuhgOBEgZSTJFMpcSD01A4v9u4hPQRbCGACN0WHo9C9o3vutdPH7ao7gYaqI/LZuhiE0aCDjD5dUWEpaX9ZEqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219304; c=relaxed/simple;
	bh=qTE1ouQpp8HPVWJufxVOhzKxtAMJfxKElVlt8vNJxAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fOjtsrdTxtqwxPZySzcc3CiYcRMMxF115dAY4aLwDpyjIRNFv10PYbcFj/hChewhKkmaBofGJgrE1spHOPXz161CLueDsyHJBkLqcg3kOp6uVEn3UL4R16M7WaXjBz38zA13E9KLfdCyOJvsuIgyEd4NwVE+JtRxmZuHMWYKVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMUUHY5l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722219303; x=1753755303;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qTE1ouQpp8HPVWJufxVOhzKxtAMJfxKElVlt8vNJxAU=;
  b=BMUUHY5l5GM86Jz6C/4e3mNvEHEJAHr0PDTw10DqrG9/3Ud8sV6POiSe
   IE2bUxUNc+A+MThRC1iGmaP2IzQvbcfxk1ps0hVCnM+WmbwaU9uoOf38N
   z4U0ojpHsqIPfrTUa5xSYKvRqbm4cZyZc7Lnqq53d45izrwsNlkffHM+B
   HIQ9arlNtNE7Id03LCZiRiFPLt1tA+rMUdj9kRV63DDSo4ibdNfeiXegc
   BwBStFAxIFv14CrGGzRfdpPpaPYh3An4wQ0As8ZIEb1JIufSidNwxf6PW
   x1YhpuKGDExneqHxb6tgs/kY6VeH+niUgzTU7bR6JdnYt9GRttaVwXTeL
   A==;
X-CSE-ConnectionGUID: GTgYAgWtSXe/jRuowq4Ygw==
X-CSE-MsgGUID: f7E/F8n5SYadqcTT4ZUHkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19902177"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19902177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:15:02 -0700
X-CSE-ConnectionGUID: DfNQO7dSTAiVU2uKgYyx/A==
X-CSE-MsgGUID: gGJz1GODQD27o4bO0Qul6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53908228"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:14:59 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,  Matthew
 Wilcox <willy@infradead.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
In-Reply-To: <20240729021306.398286-1-hsiangkao@linux.alibaba.com> (Gao
	Xiang's message of "Mon, 29 Jul 2024 10:13:06 +0800")
References: <20240729021306.398286-1-hsiangkao@linux.alibaba.com>
Date: Mon, 29 Jul 2024 10:11:26 +0800
Message-ID: <87le1l0wxd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

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
> 					// migrate_pages_batch (mm/migrate.c:1734:16)
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
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM,  Thanks for fix the bug!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> v1: https://lore.kernel.org/r/20240728154913.4023977-1-hsiangkao@linux.alibaba.com
> changes since v1:
>  - pass in migrate_mode suggested by Huang, Ying:
>      https://lore.kernel.org/r/87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com
>
>  mm/migrate.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20cb9f5f7446..15c4330e40cd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1479,11 +1479,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>  	return rc;
>  }
>  
> -static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
> +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
> +				  enum migrate_mode mode)
>  {
>  	int rc;
>  
> -	folio_lock(folio);
> +	if (mode == MIGRATE_ASYNC) {
> +		if (!folio_trylock(folio))
> +			return -EAGAIN;
> +	} else {
> +		folio_lock(folio);
> +	}
>  	rc = split_folio_to_list(folio, split_folios);
>  	folio_unlock(folio);
>  	if (!rc)
> @@ -1677,7 +1683,7 @@ static int migrate_pages_batch(struct list_head *from,
>  			 */
>  			if (nr_pages > 2 &&
>  			   !list_empty(&folio->_deferred_list)) {
> -				if (try_split_folio(folio, split_folios) == 0) {
> +				if (!try_split_folio(folio, split_folios, mode)) {
>  					nr_failed++;
>  					stats->nr_thp_failed += is_thp;
>  					stats->nr_thp_split += is_thp;
> @@ -1699,7 +1705,7 @@ static int migrate_pages_batch(struct list_head *from,
>  			if (!thp_migration_supported() && is_thp) {
>  				nr_failed++;
>  				stats->nr_thp_failed++;
> -				if (!try_split_folio(folio, split_folios)) {
> +				if (!try_split_folio(folio, split_folios, mode)) {
>  					stats->nr_thp_split++;
>  					stats->nr_split++;
>  					continue;
> @@ -1731,7 +1737,7 @@ static int migrate_pages_batch(struct list_head *from,
>  				stats->nr_thp_failed += is_thp;
>  				/* Large folio NUMA faulting doesn't split to retry. */
>  				if (is_large && !nosplit) {
> -					int ret = try_split_folio(folio, split_folios);
> +					int ret = try_split_folio(folio, split_folios, mode);
>  
>  					if (!ret) {
>  						stats->nr_thp_split += is_thp;

