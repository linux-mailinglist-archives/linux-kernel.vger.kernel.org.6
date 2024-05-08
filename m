Return-Path: <linux-kernel+bounces-173903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E788C076B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A88D284522
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15332837E;
	Wed,  8 May 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3bMk6RW"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE322338
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208105; cv=none; b=jXUvjLPqsDQeYEnVZ0VN7Z7LQEwaDQZ7wUxgYzxeb9o3mlNVlNoDCZ3lVVW+Un5VW8MGTrGU/3JuNRijSLvsGjoEPpyHQ+4cl8wxoBLYa8EETc5VcCNI/A0LcwkvYGjIyAJGeWMS+/cVFqlcAoBlJE69myH2vzrCCE0zODEb5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208105; c=relaxed/simple;
	bh=81mGqMlPCjnNrz6VDhrLw6nwmThTj1pSx3UbUQy3VQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Btn3jTUdvtrXLi6yl3K4tOYIiPXqybyz5OxKglcq9EaIr3wwldTg3KbLHKZI2KuiUDNoOanBdIGoU4yH0WcYss198W8F2s6jN7DasCL9s0ZVYZYy3bC+maP4UwfRYS0IUCIaXcZr5gWQaYfLiXIYUaAzJ8tQInv41LzHSgoIzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3bMk6RW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so212504a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208103; x=1715812903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fag+0lN5RRIVRREjp5/07+vscB8dKez30/dkSV+vmtA=;
        b=A3bMk6RWGUbGoNouyxr7YszT/2OnCgu60N72zuYr/rFISeVc7ctX0bc7ttYiiSDMlh
         WkIQpWhJsbZBiOmOcrjZ6bHO9fM4UW3LdvX5IlAIu6bevXKNFeKpFMl8ZqsTEsMKDlhu
         mVvmJ5QdwwvfrsdFcUOImbRKRzLHtDl14LezfgQl3iTxrBDbWwWa8sYjFKbpyd2Gfm2F
         4u9OrRDS5L0lycm42qzjTwqt0QvDBGLN646BwBJQt8cxmk7lZOtxE6f75yUBYGHq+QyA
         6osaQUvlSu3bFlukrmfJd3oOwMPiojm++D9LU3njC+CTGCor6P5ct/Mkiqh12bbIleWw
         CCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208103; x=1715812903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fag+0lN5RRIVRREjp5/07+vscB8dKez30/dkSV+vmtA=;
        b=oo49AsOnnisTVRkKnpMELbrcJWlKAjC9iwS26YjCnt87FIe119D/l0MvV/Cq2JzU2k
         /5Wt158rwN3qNAYwdS/fYFU/AKoN29RhAEmvtlc1IySVpft4in6Z86Ltg0/lNe2RaTP3
         CwOu9FbnIuyWYqVjIdkG68aEWjwKZXqqlHtG0tQ/FrSZvDY0Z+dLa5IrdsA+QEG4JvGs
         /+02MVk54CFIrPLyIXv2JVYZ+C59q7gG+b98J5bKbfwphbIOMnj+4sv061UF38IrJsJw
         qSPTrNgLDdAVI9iKezMeISqfajw77ZsqYvk2rV1lmhTOOkfvHYrhWs+LySp5jpzOT4hQ
         qq0g==
X-Forwarded-Encrypted: i=1; AJvYcCXGjZujNR3GmKCBkQrU+YaqrWWH3b2GP5fqpBX3KXOx7AATAxlAthYDloTlrbH72Xftt2STAMSoDzaItPN88Pcqn+Ajat7pBUUVwdUX
X-Gm-Message-State: AOJu0YwZkiZLDNCOIMGJI1Tm+MhauhFmnA3ybdgd9C3BGm1U90jcbNbT
	ZGPulnvUwZ923IQrHeL2+1FcwZlbPz6zEM9HIsaeltQ7IZpjLr0r
X-Google-Smtp-Source: AGHT+IGKR1ePsggrjPqWWWgvw/miwp2Qdt3DWt+R0Wu6Gnj1JkEDzdWmYzUCxtmjFUy1IlZAZMUlBA==
X-Received: by 2002:a05:6a21:3985:b0:1af:ce5e:ca5f with SMTP id adf61e73a8af0-1afce5ecd95mr2461311637.16.1715208103459;
        Wed, 08 May 2024 15:41:43 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:41:43 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v4 0/6] large folios swap-in: handle refault cases first
Date: Thu,  9 May 2024 10:40:34 +1200
Message-Id: <20240508224040.190469-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch is extracted from the large folio swapin series[1], primarily addressing
the handling of scenarios involving large folios in the swap cache. Currently, it is
particularly focused on addressing the refaulting of mTHP, which is still undergoing
reclamation. This approach aims to streamline code review and expedite the integration
of this segment into the MM tree.

It relies on Ryan's swap-out series[2], leveraging the helper function
swap_pte_batch() introduced by that series.

Presently, do_swap_page only encounters a large folio in the swap
cache before the large folio is released by vmscan. However, the code
should remain equally useful once we support large folio swap-in via
swapin_readahead(). This approach can effectively reduce page faults
and eliminate most redundant checks and early exits for MTE restoration
in recent MTE patchset[3].

The large folio swap-in for SWP_SYNCHRONOUS_IO and swapin_readahead()
will be split into separate patch sets and sent at a later time.

-v4:
 - collect acked-by/reviewed-by of Ryan, "Huang, Ying", Chris, David and
   Khalid, many thanks!
 - Simplify reuse code in do_swap_page() by checking refcount==1, per
   David;
 - Initialize large folio-related variables later in do_swap_page(), per
   Ryan;
 - define swap_free() as swap_free_nr(1) per Ying and Ryan.

-v3:
 - optimize swap_free_nr using bitmap with single one "long"; "Huang, Ying"
 - drop swap_free() as suggested by "Huang, Ying", now hibernation can get
   batched;
 - lots of cleanup in do_swap_page() as commented by Ryan Roberts and "Huang,
   Ying";
 - handle arch_do_swap_page() with nr pages though the only platform which
   needs it, sparc, doesn't support THP_SWAPOUT as suggested by "Huang,
   Ying";
 - introduce pte_move_swp_offset() as suggested by "Huang, Ying";
 - drop the "any_shared" of checking swap entries with respect to David's
   comment;
 - drop the counter of swapin_refault and keep it for debug purpose per
   Ying
 - collect reviewed-by tags
 Link:
  https://lore.kernel.org/linux-mm/20240503005023.174597-1-21cnbao@gmail.com/

-v2:
 - rebase on top of mm-unstable in which Ryan's swap_pte_batch() has changed
   a lot.
 - remove folio_add_new_anon_rmap() for !folio_test_anon()
   as currently large folios are always anon(refault).
 - add mTHP swpin refault counters
  Link:
  https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.com/

-v1:
  Link: https://lore.kernel.org/linux-mm/20240402073237.240995-1-21cnbao@gmail.com/

Differences with the original large folios swap-in series
 - collect r-o-b, acked;
 - rename swap_nr_free to swap_free_nr, according to Ryan;
 - limit the maximum kernel stack usage for swap_free_nr, Ryan;
 - add output argument in swap_pte_batch to expose if all entries are
   exclusive
 - many clean refinements, handle the corner case folio's virtual addr
   might not be naturally aligned

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20240322114136.61386-1-21cnbao@gmail.com/

Barry Song (3):
  mm: remove the implementation of swap_free() and always use
    swap_free_nr()
  mm: introduce pte_move_swp_offset() helper which can move offset
    bidirectionally
  mm: introduce arch_do_swap_page_nr() which allows restore metadata for
    nr pages

Chuanhua Han (3):
  mm: swap: introduce swap_free_nr() for batched swap_free()
  mm: swap: make should_try_to_free_swap() support large-folio
  mm: swap: entirely map large folios found in swapcache

 include/linux/pgtable.h | 26 +++++++++++++-----
 include/linux/swap.h    |  9 +++++--
 kernel/power/swap.c     |  5 ++--
 mm/internal.h           | 25 ++++++++++++++---
 mm/memory.c             | 60 +++++++++++++++++++++++++++++++++--------
 mm/swapfile.c           | 48 +++++++++++++++++++++++++++++----
 6 files changed, 142 insertions(+), 31 deletions(-)

-- 
2.34.1


