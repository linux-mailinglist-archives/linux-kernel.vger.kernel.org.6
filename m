Return-Path: <linux-kernel+bounces-212662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6B90647E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D5A1C21821
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D18137924;
	Thu, 13 Jun 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B50dbWE4"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47249137933
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261745; cv=none; b=OyPUoA6taygkqtkQS0a2312olZ6TVWZ4X8ywH7eeLRaoPTB3uId6aBUYPzU+Trtv98k1K+5NPNed3ptlZT/FVRyhX4LYC6BvUAVSKBbd7UH2EDD9Lu8G7Xc0mqnqO5zbBYFydJDXg4lkzeZVYKEuQWT74xrQghEyV6v9c9EXmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261745; c=relaxed/simple;
	bh=lKH0bz9WsYwamKoQgyxUqq/befgWPvo0QFCJdZqZAaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz6exmxSjAEkSEocl0woWsfOSXanJLHPqeN7wXlRjwZOk2fXtedVNlwMjP5ZWGBmmo5Ns8Z9wMUdsCtHtRY7qaLdDvqfB0IxVG5Dy4anZ7/U89jc8a7vls76Hfsggx9KzdJqCCuZ960XQ5h77lpXADoqZL3NsHGXseVDwCtyv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B50dbWE4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so490119a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718261743; x=1718866543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlWYFNni2hrEPGxN+kZESH09HLiR3+ntsGQI95h9/gg=;
        b=B50dbWE4D5WijveIdJyHrD3HIkf3fVYtUaUZtjETpkF1YRBVlxFpt2BNGZscXDJfdA
         X30/JFFF7dDsAHZXQ00LnHT327XyCOPeafM1cQRF9jwQsPsUaJqlOKGIMfn9LyTegiEp
         neZSJcQ2Rtbf8DZjWwihVQdhiRqkV5o+0PV1DxE5WSyljUdoqUks+XxTLQm8LazbDG+q
         pxP3+vpS3kfVPWvJN7sKOgeD0Emhd048YtAblZhz/FgnMzfOBcYl18JCbUukliKBgFPd
         ARe35NILTF19vIKZGedx2FT2xUeXhHhJi9xLzmvS3LijgLQccekOl8DNpV9EUl1UlDIr
         chBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261743; x=1718866543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlWYFNni2hrEPGxN+kZESH09HLiR3+ntsGQI95h9/gg=;
        b=NRAj9dGqSFNoHLIQ2GQMdTf0W1l1PSpdpsnTUkM1Q65m8WmIWkLy3lt8kjvh1FBdGt
         2f4SJiNEwzq5+4oKI+aL5mxw2czbyZJ855UJxdVvxPeRVKzvKIOGk111ByGGXPuS9jma
         cxwdcikXwr5LFTiF8D10L52xnA5BpXvdWhWFVsipddVavpdnwJ3Iu1xZWG75FB+N7owY
         aS0/2INbiSNCBpsAhAbZTJxI3bVD+/JdxK06y1S3LnzWyh9YTtlt70gp3DODSu2ly0WX
         lJxktZNvin4AZ2OLmS43olkk0jmQwP49Fg7CPTIOJasZiSoIYDhiUX9jzgxLIa+62A0U
         QMLA==
X-Forwarded-Encrypted: i=1; AJvYcCV0XQzTHMePy+/oGBlnALaOCslk7pr2HNLZWGccszrf0agEZ8x70X9rTZPCAiNZ5N6nshh/obIIAhnFGS19IU4CkYOt4ULw4kx2S+Yt
X-Gm-Message-State: AOJu0YyNaVNZiuIltYEQ8CzLeJmCztr7mksCOhrefNLyBMhpnATQqXxt
	UQJ0zcUvWeIJxX+6lifAjLnkUpK0uPUJKjXiia4HNbMh6JhsI7vv
X-Google-Smtp-Source: AGHT+IHHox0pia+wncnKZphDQikJOEjj2rdonLp0knNk9bk3eR3NJallf9SweyY7CyKgdM3PTgbOng==
X-Received: by 2002:a17:90a:b00b:b0:2c3:1b66:19b2 with SMTP id 98e67ed59e1d1-2c4a7601cd2mr3816779a91.1.1718261743359;
        Wed, 12 Jun 2024 23:55:43 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467ae5esm831570a91.47.2024.06.12.23.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:55:42 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: baolin.wang@linux.alibaba.com,
	david@redhat.com
Cc: ioworker0@gmail.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	fengwei.yin@intel.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maskray@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	sj@kernel.org,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiehuan09@gmail.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH v7 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Thu, 13 Jun 2024 14:55:21 +0800
Message-Id: <20240613065521.15960-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240610120809.66601-1-ioworker0@gmail.com>
References: <20240610120809.66601-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Mon, Jun 10, 2024 at 8:08 PM Lance Yang <ioworker0@gmail.com> wrote:
>
[...]
> +static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
> +                                           unsigned long addr, pmd_t *pmdp,
> +                                           struct folio *folio)
> +{
> +       VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> +       VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
> +       struct mm_struct *mm = vma->vm_mm;
> +       int ref_count, map_count;
> +       pmd_t orig_pmd = *pmdp;
> +       struct page *page;
> +
> +       if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
> +               return false;
> +
> +       page = pmd_page(orig_pmd);
> +       if (unlikely(page_folio(page) != folio))
> +               return false;
> +
> +       if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
> +               folio_set_swapbacked(folio);
> +               return false;
> +       }
> +
> +       orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
> +
> +       /*
> +        * Syncing against concurrent GUP-fast:
> +        * - clear PMD; barrier; read refcount
> +        * - inc refcount; barrier; read PMD
> +        */
> +       smp_mb();
> +
> +       ref_count = folio_ref_count(folio);
> +       map_count = folio_mapcount(folio);
> +
> +       /*
> +        * Order reads for folio refcount and dirty flag
> +        * (see comments in __remove_mapping()).
> +        */
> +       smp_rmb();
> +
> +       /*
> +        * If the folio or its PMD is redirtied at this point, or if there
> +        * are unexpected references, we will give up to discard this folio
> +        * and remap it.
> +        *
> +        * The only folio refs must be one from isolation plus the rmap(s).
> +        */
> +       if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> +               folio_set_swapbacked(folio);
> +
> +       if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
> +               set_pmd_at(mm, addr, pmdp, orig_pmd);
> +               return false;
> +       }
> +
> +       folio_remove_rmap_pmd(folio, page, vma);
> +       zap_deposited_table(mm, pmdp);
> +       add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +       if (vma->vm_flags & VM_LOCKED)
> +               mlock_drain_local();
> +       folio_put(folio);
> +
> +       return true;
> +}
[...]
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b77f88695588..8e901636ade9 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1630,6 +1630,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>         enum ttu_flags flags = (enum ttu_flags)(long)arg;
>         unsigned long pfn;
>         unsigned long hsz = 0;
> +       bool pmd_mapped = false;
>
>         /*
>          * When racing against e.g. zap_pte_range() on another cpu,
> @@ -1676,16 +1677,24 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>                         goto walk_done_err;
>                 }
>
> -               if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> -                       /*
> -                        * We temporarily have to drop the PTL and start once
> -                        * again from that now-PTE-mapped page table.
> -                        */
> -                       split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
> -                                             false, folio);
> -                       flags &= ~TTU_SPLIT_HUGE_PMD;
> -                       page_vma_mapped_walk_restart(&pvmw);
> -                       continue;
> +               if (!pvmw.pte) {
> +                       pmd_mapped = true;
> +                       if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd,
> +                                                 folio))
> +                               goto walk_done;
> +
> +                       if (flags & TTU_SPLIT_HUGE_PMD) {
> +                               /*
> +                                * We temporarily have to drop the PTL and start
> +                                * once again from that now-PTE-mapped page
> +                                * table.
> +                                */
> +                               split_huge_pmd_locked(vma, pvmw.address,
> +                                                     pvmw.pmd, false, folio);
> +                               flags &= ~TTU_SPLIT_HUGE_PMD;
> +                               page_vma_mapped_walk_restart(&pvmw);
> +                               continue;
> +                       }
>                 }
>
>                 /* Unexpected PMD-mapped THP? */
> @@ -1813,7 +1822,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>                          */
>                         if (unlikely(folio_test_swapbacked(folio) !=
>                                         folio_test_swapcache(folio))) {
> -                               WARN_ON_ONCE(1);
> +                               /*
> +                                * unmap_huge_pmd_locked() will unmark a
> +                                * PMD-mapped folio as lazyfree if the folio or
> +                                * its PMD was redirtied.
> +                                */
> +                               WARN_ON_ONCE(!pmd_mapped);

Damn it. I forgot to remap the folio to the page table since we've cleared
the PTE here.

But it seems like we neither need to do that, nor unmark a PMD-mapped folio
as lazyfree in unmap_huge_pmd_locked(); the next block[1] will catch the
folio and do the same thing.

Hi David and Baolin, what do you think?

>                                 goto walk_done_err;
>                         }

[1] https://elixir.bootlin.com/linux/v6.10-rc3/source/mm/rmap.c#L1820

/* MADV_FREE page check */
if (!folio_test_swapbacked(folio)) {
	int ref_count, map_count;

[...]
	/*
	 * The only page refs must be one from isolation
	 * plus the rmap(s) (dropped by discard:).
	 */
	if (ref_count == 1 + map_count &&
	    !folio_test_dirty(folio)) {
		dec_mm_counter(mm, MM_ANONPAGES);
		goto discard;
	}

	/*
	 * If the folio was redirtied, it cannot be
	 * discarded. Remap the page to page table.
	 */
	set_pte_at(mm, address, pvmw.pte, pteval);
	folio_set_swapbacked(folio);
	goto walk_done_err;
}


Thanks,
Lance

>
> --
> 2.33.1
>

