Return-Path: <linux-kernel+bounces-290902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34281955AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B411B21192
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A715B666;
	Sun, 18 Aug 2024 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnOT0RlT"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE9944F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723958023; cv=none; b=cp+/+0KOPa9FryOr6kB0Rg5d1iPQDGXbnqafEJqdIJYqHIW7g1RFYf5tYf4ROX0K36jcaLzjvKVilKQDo3AUSF7CJ+USr5D4b9LJj3T3ZZPlhoyK+vroN2KyAIltyyeFTuKmqAle09784Zlb1LSxVhhCQGyFEmg6Rczv6FdpVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723958023; c=relaxed/simple;
	bh=D6Ff3MtiG9xl7IZdFTFTfaWPQIPG+LoiHKDvTwvYGfk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k+HnJuGkQtUM/02LImRETJuMJ2rK38bsw8GbU2xx1H2T3v1jnlitfbQiOXtP4AiR7DRz849+5X5ffE+cW5a5ofLPFYK86JFEtOq1pIhl6e7+k04pIb5ky4n9bIAHwIeQ8588S4LdikeejmGXziMlkcMaIdwl0YY5sm/WGhYoG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnOT0RlT; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5af7ae388so1916051eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 22:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723958020; x=1724562820; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVvU9xxK5dTeMKAjFl5rkhtM+aF2FRQXOAf4rQRLTtc=;
        b=DnOT0RlTXLvHhhW6V7lBz0DGFUjZ2RJshFPXFyN/ZUQFR4H3/GXmQM6ga1vLwgtqkf
         w9sW09kNTTa+xYs0s4H2Y0+INdYMGg4OlnLDXHGQx27czwqr6fzL/5hSHcoiez//SByg
         IhOe9Aso9e4fTveeP//uY319wA971ZF9ZCZLLum6IVior5vseuoVx2jncyV1TWBRB4sL
         hE5qo7q2ljx368PNbs3uHfzEmetzB0XLNR8M1gQd/+/3HjY6H/b/MOGU+Fm8z18UxBcH
         /u0nE8q+Ja9x4+gdWCPIST8Jk7F2yRMj1Lfe47ZyduGmuJaYAovwCpIYGXS+qDJnpgas
         sD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723958020; x=1724562820;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVvU9xxK5dTeMKAjFl5rkhtM+aF2FRQXOAf4rQRLTtc=;
        b=BUkin9uQFJwf8HL2/AgRpB+w/Arr0HqGQLkj8euZs2cLtRNKi2B7tuHc6AzYRMzw6m
         ofL3oN+bLIB6L8UJtn4mpRqPfdcx/fXXzOWJNYArMA25/0p9q1wec7XWhv07BVcfHv8o
         K0NpdsEeZRTrLu9cnLUJS8XQl3gx3/q0zJNrCGOOfwVsDSAybVZy1j/A7nWmyhB0ThGI
         ZNYaWp2uE6qlSY8ll1mroZkJ8zXnKvSySTQsKoQQKk4sbHrEgRIrpkqYRcP3DOc41tAS
         wyx3oZ5+mB3t8/DkJCEn/YI0NWXyeetpnKCNiGD92LTdkfJKexlXka55au5G48iU2j3/
         Va7A==
X-Forwarded-Encrypted: i=1; AJvYcCXTMoMY63fMErq9dPre7Kf4cVfgGswdnEV5+lkm5IZJaODgryMZD7VcCcHQ6u/ENxkOqyFZXcC083/+hDKZIVKZleh+dgBMsYPFaqAA
X-Gm-Message-State: AOJu0YwR3bKAszNOYPNTqoVAdxdlD8/FMHDHCJ8EsJP2vkC26PIT4m7F
	yfTRJMQsGdG95TDRFoSVb22mRcMw7+bK7B9EY5U28WtM8z6BKUbDPasMps37Fg==
X-Google-Smtp-Source: AGHT+IEnSew4mblQUWx6K7ns+fH3kd0Pjo6bjaib28/wf6243qJPhvm301wZLvvVUMfJCB8msFnOPg==
X-Received: by 2002:a05:6871:e706:b0:25e:b839:cf06 with SMTP id 586e51a60fabf-26fff4b3114mr5701300fac.11.1723958020054;
        Sat, 17 Aug 2024 22:13:40 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cd69811sm1457955eaf.4.2024.08.17.22.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 22:13:38 -0700 (PDT)
Date: Sat, 17 Aug 2024 22:13:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
    riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
    yuzhao@google.com, david@redhat.com, baohua@kernel.org, 
    ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org, 
    ryncsn@gmail.com, ak@linux.intel.com, cerasuolodomenico@gmail.com, 
    corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
    kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] mm: split underutilized THPs
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
Message-ID: <1e6f3b38-d309-e63f-bca0-5093e152f7d7@google.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Aug 2024, Usama Arif wrote:

> The current upstream default policy for THP is always. However, Meta
> uses madvise in production as the current THP=always policy vastly
> overprovisions THPs in sparsely accessed memory areas, resulting in
> excessive memory pressure and premature OOM killing.
> Using madvise + relying on khugepaged has certain drawbacks over
> THP=always. Using madvise hints mean THPs aren't "transparent" and
> require userspace changes. Waiting for khugepaged to scan memory and
> collapse pages into THP can be slow and unpredictable in terms of performance
> (i.e. you dont know when the collapse will happen), while production
> environments require predictable performance. If there is enough memory
> available, its better for both performance and predictability to have
> a THP from fault time, i.e. THP=always rather than wait for khugepaged
> to collapse it, and deal with sparsely populated THPs when the system is
> running out of memory.
> 
> This patch-series is an attempt to mitigate the issue of running out of
> memory when THP is always enabled. During runtime whenever a THP is being
> faulted in or collapsed by khugepaged, the THP is added to a list.
> Whenever memory reclaim happens, the kernel runs the deferred_split
> shrinker which goes through the list and checks if the THP was underutilized,
> i.e. how many of the base 4K pages of the entire THP were zero-filled.
> If this number goes above a certain threshold, the shrinker will attempt
> to split that THP. Then at remap time, the pages that were zero-filled are
> mapped to the shared zeropage, hence saving memory. This method avoids the
> downside of wasting memory in areas where THP is sparsely filled when THP
> is always enabled, while still providing the upside THPs like reduced TLB
> misses without having to use madvise.
> 
> Meta production workloads that were CPU bound (>99% CPU utilzation) were
> tested with THP shrinker. The results after 2 hours are as follows:
> 
>                             | THP=madvise |  THP=always   | THP=always
>                             |             |               | + shrinker series
>                             |             |               | + max_ptes_none=409
> -----------------------------------------------------------------------------
> Performance improvement     |      -      |    +1.8%      |     +1.7%
> (over THP=madvise)          |             |               |
> -----------------------------------------------------------------------------
> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
> -----------------------------------------------------------------------------
> max_ptes_none=409 means that any THP that has more than 409 out of 512
> (80%) zero filled filled pages will be split.
> 
> To test out the patches, the below commands without the shrinker will
> invoke OOM killer immediately and kill stress, but will not fail with
> the shrinker:
> 
> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
> mkdir /sys/fs/cgroup/test
> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> echo 20M > /sys/fs/cgroup/test/memory.max
> echo 0 > /sys/fs/cgroup/test/memory.swap.max
> # allocate twice memory.max for each stress worker and touch 40/512 of
> # each THP, i.e. vm-stride 50K.
> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> # killer.
> # Without the shrinker, OOM killer is invoked immediately irrespective
> # of max_ptes_none value and kills stress.
> stress --vm 1 --vm-bytes 40M --vm-stride 50K
> 
> v2 -> v3:
> - Use my_zero_pfn instead of page_to_pfn(ZERO_PAGE(..)) (Johannes)
> - Use flags argument instead of bools in remove_migration_ptes (Johannes)
> - Use a new flag in folio->_flags_1 instead of folio->_partially_mapped
>   (David Hildenbrand).
> - Split out the last patch of v2 into 3, one for introducing the flag,
>   one for splitting underutilized THPs on _deferred_list and one for adding
>   sysfs entry to disable splitting (David Hildenbrand).
> 
> v1 -> v2:
> - Turn page checks and operations to folio versions in __split_huge_page.
>   This means patches 1 and 2 from v1 are no longer needed.
>   (David Hildenbrand)
> - Map to shared zeropage in all cases if the base page is zero-filled.
>   The uffd selftest was removed.
>   (David Hildenbrand).
> - rename 'dirty' to 'contains_data' in try_to_map_unused_to_zeropage
>   (Rik van Riel).
> - Use unsigned long instead of uint64_t (kernel test robot).
>  
> Alexander Zhu (1):
>   mm: selftest to verify zero-filled pages are mapped to zeropage
> 
> Usama Arif (3):
>   mm: Introduce a pageflag for partially mapped folios
>   mm: split underutilized THPs
>   mm: add sysfs entry to disable splitting underutilized THPs
> 
> Yu Zhao (2):
>   mm: free zapped tail pages when splitting isolated thp
>   mm: remap unused subpages to shared zeropage when splitting isolated
>     thp

Sorry, I don't have time to review this, but notice you're intending
a v4 of the series, so want to bring up four points quickly before that.

1. Even with the two fixes to 1/6 in __split_huge_page(), under load
this series causes system lockup, with interrupts disabled on most CPUs.

The error is in deferred_split_scan(), where the old code just did
a list_splice_tail() under split_queue_lock, but this series ends up
doing more there, including a folio_put(): deadlock when racing, and
that is the final folio_put() which brings refcount down to 0, which
then wants to take split_queue_lock.

The patch I've been using successfully on 6.11-rc3-next-20240816 below:
I do have other problems with current mm commits, so have not been able
to sustain a load for very long, but suspect those problems unrelated
to this series. Please fold this fix, or your own equivalent, into
your next version.

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3270,7 +3270,8 @@ static void __split_huge_page(struct pag
 
 			folio_clear_active(new_folio);
 			folio_clear_unevictable(new_folio);
-			if (!folio_batch_add(&free_folios, folio)) {
+			list_del(&new_folio->lru);
+			if (!folio_batch_add(&free_folios, new_folio)) {
 				mem_cgroup_uncharge_folios(&free_folios);
 				free_unref_folios(&free_folios);
 			}
@@ -3706,42 +3707,37 @@ static unsigned long deferred_split_scan
 		bool did_split = false;
 		bool underutilized = false;
 
-		if (folio_test_partially_mapped(folio))
-			goto split;
-		underutilized = thp_underutilized(folio);
-		if (underutilized)
-			goto split;
-		continue;
-split:
+		if (!folio_test_partially_mapped(folio)) {
+			underutilized = thp_underutilized(folio);
+			if (!underutilized)
+				goto next;
+		}
 		if (!folio_trylock(folio))
-			continue;
-		did_split = !split_folio(folio);
-		folio_unlock(folio);
-		if (did_split) {
-			/* Splitting removed folio from the list, drop reference here */
-			folio_put(folio);
+			goto next;
+		if (!split_folio(folio)) {
+			did_split = true;
 			if (underutilized)
 				count_vm_event(THP_UNDERUTILIZED_SPLIT_PAGE);
 			split++;
 		}
-	}
-
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	/*
-	 * Only add back to the queue if folio is partially mapped.
-	 * If thp_underutilized returns false, or if split_folio fails in
-	 * the case it was underutilized, then consider it used and don't
-	 * add it back to split_queue.
-	 */
-	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
-		if (folio_test_partially_mapped(folio))
-			list_move(&folio->_deferred_list, &ds_queue->split_queue);
-		else {
+		folio_unlock(folio);
+next:
+		/*
+		 * split_folio() removes folio from list on success.
+		 * Only add back to the queue if folio is partially mapped.
+		 * If thp_underutilized returns false, or if split_folio fails
+		 * in the case it was underutilized, then consider it used and
+		 * don't add it back to split_queue.
+		 */
+		if (!did_split && !folio_test_partially_mapped(folio)) {
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
 		folio_put(folio);
 	}
+
+	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	list_splice_tail(&list, &ds_queue->split_queue);
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	/*

2. I don't understand why there needs to be a new PG_partially_mapped
flag, with all its attendant sets and tests and clears all over.  Why
can't deferred_split_scan() detect that case for itself, using the
criteria from __folio_remove_rmap()? I see folio->_nr_pages_mapped
is commented "Do not use outside of rmap and debug code", and
folio_nr_pages_mapped() is currently only used from mm/debug.c; but
using the info already maintained is preferable to adding a PG_flag
(and perhaps more efficient - skips splitting when _nr_pages_mapped
already fell to 0 and folio will soon be freed).

3. Everything in /sys/kernel/mm/transparent_hugepage/ is about THPs,
so please remove the "thp_" from "thp_low_util_shrinker" -
"shrink_underused" perhaps.  And it needs a brief description in
Documentation/admin-guide/mm/transhuge.rst.

4. Wouldn't "underused" be better than "underutilized" throughout?

Hugh

