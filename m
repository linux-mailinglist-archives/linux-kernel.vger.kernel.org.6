Return-Path: <linux-kernel+bounces-329634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B19793E7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7651C21319
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DB20E6;
	Sun, 15 Sep 2024 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bxKp0Af3"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198218D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726362188; cv=none; b=ut6TObbw2cWjaHIyixlSj23xz/6HKCaA0hn3Wbbf2vqutLGjN35R8QmcjMAkRx6V9sNu4Qun8NfFHHd7Sxl4uhmiJWCvogx5JuCxm4RUtyypQahMV/RY06/EpdhGlYGXqf9dFqtPOy3NIvHqFr+1QJsY9vuih5D07AkaEmNc6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726362188; c=relaxed/simple;
	bh=5JUOdbs/0PrjpZq2wWOCu1qSHvLEQ0Ar/Y8lPEyXaZ4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=N15+WZxzUdpuU7Xz+/R6XDgwjQhEMZXm64aP2xK9Kjxc1fqmWoELEKNuv1FmO18tH/mCef72K6w9dLSZ6dTS+L2Aopic+Hl+JQNQ1rYvDnsYs4QncGTiPDEhgh0VR2qXl+deRlxr67hUdMs8zlKDMg2FAfNGB2f+qP2Z6lBZmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bxKp0Af3; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=mn7qb12XU3SlbuhQAOiseJ+pHaTAZ+pcvZrKp8F6Tic=;
	b=bxKp0Af3aMZLMR+hIHF+2XzFaOxlwuct2OX8/EDKNo0LSRROoNsM/bgTLGC2bk
	1RgWi4+Kk3OoLmOONCalbibP6bakvtv4lf6+M1IV33KSAHPaMvsGDC9MQgSESBaL
	X7MbKOMtB58E7Iu173gF0xeYLTPmR5NL2i2T4iSvH2Giw=
Received: from DESKTOPG6SHR7J (unknown [112.10.227.147])
	by gzsmtp3 (Coremail) with SMTP id sigvCgDnsZUtMeZmX2OfAQ--.36272S2;
	Sun, 15 Sep 2024 08:58:22 +0800 (CST)
From: "wang wei" <a929244872@163.com>
To: "'Barry Song'" <21cnbao@gmail.com>,
	<akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Cc: <mhocko@suse.com>,
	<fengbaopeng@honor.com>,
	<gaoxu2@honor.com>,
	<hailong.liu@oppo.com>,
	<kaleshsingh@google.com>,
	<linux-kernel@vger.kernel.org>,
	<lokeshgidra@google.com>,
	<ngeoffray@google.com>,
	<shli@fb.com>,
	<surenb@google.com>,
	<yipengxiang@honor.com>,
	<david@redhat.com>,
	<yuzhao@google.com>,
	<minchan@kernel.org>,
	"'Barry Song'" <v-songbaohua@oppo.com>
References: <20240914063746.46290-1-21cnbao@gmail.com>
In-Reply-To: <20240914063746.46290-1-21cnbao@gmail.com>
Subject: RE: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
Date: Sun, 15 Sep 2024 08:58:27 +0800
Message-ID: <014f01db070a$61976220$24c62660$@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJy7sFNPkNNwxQPmRpO6KjBLXfo2bEoNjVQ
X-CM-TRANSID:sigvCgDnsZUtMeZmX2OfAQ--.36272S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3tr47WrWktFykCw4xGrWDCFg_yoWkGw4rpF
	Z8GwnrArZ5Jr47Grs5Jr4vkF1SkrWrGryUtFyxW342kF1aqaykKa45Kw1UtFWrCr18ZFyS
	va4UGF9rW3WjqrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j72-5UUUUU=
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/1tbiLhBbpmV4Lt7vRQAAsE

> -----Original Message-----
> From: linux-kernel+bounces-329184-a929244872=163.com@vger.kernel.org
> <linux-kernel+bounces-329184-a929244872=163.com@vger.kernel.org> On
> Behalf Of Barry Song
> Sent: Saturday, September 14, 2024 2:38 PM
> To: akpm@linux-foundation.org; linux-mm@kvack.org
> Cc: mhocko@suse.com; fengbaopeng@honor.com; gaoxu2@honor.com;
> hailong.liu@oppo.com; kaleshsingh@google.com; linux-
> kernel@vger.kernel.org; lokeshgidra@google.com; ngeoffray@google.com;
> shli@fb.com; surenb@google.com; yipengxiang@honor.com;
> david@redhat.com; yuzhao@google.com; minchan@kernel.org; Barry Song
> <v-songbaohua@oppo.com>
> Subject: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon
> folios
> 
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This follows up on the discussion regarding Gaoxu's work[1]. It's unclear
if
> there's still interest in implementing a separate LRU list for lazyfree
folios, but I
> decided to explore it out of curiosity.
> 
> According to Lokesh, MADV_FREE'd anon folios are expected to be released
> earlier than file folios. One option, as implemented by Gao Xu, is to
place
> lazyfree anon folios at the tail of the file's `min_seq` generation.
However, this
> approach results in lazyfree folios being released in a LIFO manner, which
> conflicts with LRU behavior, as noted by Michal.
> 
> To address this, this patch proposes maintaining a separate list for
lazyfree
> anon folios while keeping them classified under the "file" LRU type to
minimize
> code changes. These lazyfree anon folios will still be counted as file
folios and
> share the same generation with regular files. In the eviction path, the
lazyfree
> list will be prioritized for scanning before the actual file LRU list.
> 
> [1] https://lore.kernel.org/linux-
> mm/f29f64e29c08427b95e3df30a5770056@honor.com/
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/mm_inline.h |  5 +-
>  include/linux/mmzone.h    |  2 +-
>  mm/vmscan.c               | 97 +++++++++++++++++++++++----------------
>  3 files changed, 61 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h index
> f4fe593c1400..118d70ed3120 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -225,6 +225,7 @@ static inline bool lru_gen_add_folio(struct lruvec
> *lruvec, struct folio *folio,
>  	int gen = folio_lru_gen(folio);
>  	int type = folio_is_file_lru(folio);
>  	int zone = folio_zonenum(folio);
> +	int lazyfree = type ? folio_test_anon(folio) : 0;
>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
> 
>  	VM_WARN_ON_ONCE_FOLIO(gen != -1, folio); @@ -262,9 +263,9
> @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct
folio
> *folio,
>  	lru_gen_update_size(lruvec, folio, -1, gen);
>  	/* for folio_rotate_reclaimable() */
>  	if (reclaiming)
> -		list_add_tail(&folio->lru,
&lrugen->folios[gen][type][zone]);
> +		list_add_tail(&folio->lru, &lrugen->folios[gen][type +
> +lazyfree][zone]);
>  	else
> -		list_add(&folio->lru, &lrugen->folios[gen][type][zone]);
> +		list_add(&folio->lru, &lrugen->folios[gen][type +
> lazyfree][zone]);
> 
>  	return true;
>  }
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h index
> 17506e4a2835..5d2331778528 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -434,7 +434,7 @@ struct lru_gen_folio {
>  	/* the birth time of each generation in jiffies */
>  	unsigned long timestamps[MAX_NR_GENS];
>  	/* the multi-gen LRU lists, lazily sorted on eviction */
> -	struct list_head
> folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> +	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE +
> 1][MAX_NR_ZONES];
This also divides lazy free filio into MAX_NR_ZONES generations. 
The gen of a lazy free filio depends on the gen in the anno list before 
it is marked as lazy free. Whether it will happen that lazy free filios 
are released in an order that is not consistent with the order of the mark?

>  	/* the multi-gen LRU sizes, eventually consistent */
>  	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
>  	/* the exponential moving average of refaulted */ diff --git
> a/mm/vmscan.c b/mm/vmscan.c index 96abf4a52382..9dc665dc6ba9
> 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3725,21 +3725,25 @@ static bool inc_min_seq(struct lruvec *lruvec, int
> type, bool can_swap)
> 
>  	/* prevent cold/hot inversion if force_scan is true */
>  	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
> -		struct list_head *head = &lrugen-
> >folios[old_gen][type][zone];
> +		int list_num = type ? 2 : 1;
> +		struct list_head *head;
> 
> -		while (!list_empty(head)) {
> -			struct folio *folio = lru_to_folio(head);
> +		for (int i = list_num - 1; i >= 0; i--) {
> +			head = &lrugen->folios[old_gen][type + i][zone];
> +			while (!list_empty(head)) {
> +				struct folio *folio = lru_to_folio(head);
> 
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> -			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio),
> folio);
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
> 
> -			new_gen = folio_inc_gen(lruvec, folio, false);
> -			list_move_tail(&folio->lru, &lrugen-
> >folios[new_gen][type][zone]);
> +				new_gen = folio_inc_gen(lruvec, folio,
false);
> +				list_move_tail(&folio->lru, &lrugen-
> >folios[new_gen][type +
> +i][zone]);
> 
> -			if (!--remaining)
> -				return false;
> +				if (!--remaining)
> +					return false;
> +			}
>  		}
>  	}
>  done:
> @@ -4291,6 +4295,7 @@ static bool sort_folio(struct lruvec *lruvec, struct
> folio *folio, struct scan_c
>  	int refs = folio_lru_refs(folio);
>  	int tier = lru_tier_from_refs(refs);
>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
> +	int lazyfree = type ? folio_test_anon(folio) : 0;
> 
>  	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
> 
> @@ -4306,7 +4311,7 @@ static bool sort_folio(struct lruvec *lruvec, struct
> folio *folio, struct scan_c
> 
>  	/* promoted */
>  	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
> -		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> +		list_move(&folio->lru, &lrugen->folios[gen][type +
> lazyfree][zone]);
>  		return true;
>  	}
> 
> @@ -4315,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec, struct
> folio *folio, struct scan_c
>  		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
> 
>  		gen = folio_inc_gen(lruvec, folio, false);
> -		list_move_tail(&folio->lru,
&lrugen->folios[gen][type][zone]);
> +		list_move_tail(&folio->lru, &lrugen->folios[gen][type +
> +lazyfree][zone]);
> 
>  		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
>  			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -
> 4325,7 +4330,7 @@ static bool sort_folio(struct lruvec *lruvec, struct
folio
> *folio, struct scan_c
>  	/* ineligible */
>  	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
>  		gen = folio_inc_gen(lruvec, folio, false);
> -		list_move_tail(&folio->lru,
&lrugen->folios[gen][type][zone]);
> +		list_move_tail(&folio->lru, &lrugen->folios[gen][type +
> +lazyfree][zone]);
>  		return true;
>  	}
> 
> @@ -4333,7 +4338,7 @@ static bool sort_folio(struct lruvec *lruvec, struct
> folio *folio, struct scan_c
>  	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>  	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
>  		gen = folio_inc_gen(lruvec, folio, true);
> -		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
> +		list_move(&folio->lru, &lrugen->folios[gen][type +
> lazyfree][zone]);
>  		return true;
>  	}
> 
> @@ -4377,7 +4382,7 @@ static bool isolate_folio(struct lruvec *lruvec,
struct
> folio *folio, struct sca  static int scan_folios(struct lruvec *lruvec,
struct
> scan_control *sc,
>  		       int type, int tier, struct list_head *list)  {
> -	int i;
> +	int i, j;
>  	int gen;
>  	enum vm_event_item item;
>  	int sorted = 0;
> @@ -4399,33 +4404,38 @@ static int scan_folios(struct lruvec *lruvec,
struct
> scan_control *sc,
>  		LIST_HEAD(moved);
>  		int skipped_zone = 0;
>  		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
> -		struct list_head *head = &lrugen->folios[gen][type][zone];
> -
> -		while (!list_empty(head)) {
> -			struct folio *folio = lru_to_folio(head);
> -			int delta = folio_nr_pages(folio);
> -
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> -			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio),
> folio);
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
> -
> 	VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
> -
> -			scanned += delta;
> +		int list_num = type ? 2 : 1;
> +		struct list_head *head;
In addition, scan_folios will also age lazy free list. Is this necessary?
> +
> +		for (j = list_num - 1; j >= 0; j--) {
> +			head = &lrugen->folios[gen][type + j][zone];
> +			while (!list_empty(head)) {
> +				struct folio *folio = lru_to_folio(head);
> +				int delta = folio_nr_pages(folio);
> +
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
> +
> 	VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
> +
> +				scanned += delta;
> +
> +				if (sort_folio(lruvec, folio, sc, tier))
> +					sorted += delta;
> +				else if (isolate_folio(lruvec, folio, sc)) {
> +					list_add(&folio->lru, list);
> +					isolated += delta;
> +				} else {
> +					list_move(&folio->lru, &moved);
> +					skipped_zone += delta;
> +				}
> 
> -			if (sort_folio(lruvec, folio, sc, tier))
> -				sorted += delta;
> -			else if (isolate_folio(lruvec, folio, sc)) {
> -				list_add(&folio->lru, list);
> -				isolated += delta;
> -			} else {
> -				list_move(&folio->lru, &moved);
> -				skipped_zone += delta;
> +				if (!--remaining || max(isolated,
> skipped_zone) >= MIN_LRU_BATCH)
> +					goto isolate_done;
>  			}
> -
> -			if (!--remaining || max(isolated, skipped_zone) >=
> MIN_LRU_BATCH)
> -				break;
>  		}
> 
> +isolate_done:
>  		if (skipped_zone) {
>  			list_splice(&moved, head);
>  			__count_zid_vm_events(PGSCAN_SKIP, zone,
> skipped_zone); @@ -5586,8 +5596,15 @@ void lru_gen_init_lruvec(struct
> lruvec *lruvec)
>  	for (i = 0; i <= MIN_NR_GENS + 1; i++)
>  		lrugen->timestamps[i] = jiffies;
> 
> -	for_each_gen_type_zone(gen, type, zone)
> +	for_each_gen_type_zone(gen, type, zone) {
>  		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
> +		/*
> +		 * lazyfree anon folios have a separate list while using
> +		 * file as type
> +		 */
> +		if (type)
> +			INIT_LIST_HEAD(&lrugen->folios[gen][type +
> 1][zone]);
> +	}
> 
>  	if (mm_state)
>  		mm_state->seq = MIN_NR_GENS;
> --
> 2.39.3 (Apple Git-146)


