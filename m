Return-Path: <linux-kernel+bounces-193743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36788D3168
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4E28CD79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B715CD52;
	Wed, 29 May 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR0L3okB"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58844C7B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971326; cv=none; b=AUyiNBgLPXow9kNULLoHLhOtN6Ky3AFn8blzkmxQdsdi5iUFuZ+QT5GFXDR7h7GxISfC/nseHocrArCejt8BCxbfCBu25ZI9ULf2ULDpcxqvjcYzOpjOomvRyc4rKhfhwZdyuJYqfyJF2GA+iwPXYbVjHvX7uCzP6HKMCjqTv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971326; c=relaxed/simple;
	bh=UlPPzuqGSwEhmI/VU350FnDdRaqL17RoW3KSjn0a/k4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfpKHPGtULVBZCbgBNrxWnzj6Fznw2e4RkSuHu7VTfdd/L6GK0wQ1jTCZ8mWKvpmbapK7+Bp6y6vnWq9fcWPLNUXMdd45hac9zXPywgwBA3IKj22CUaphknDonNL1+LJWUvKtAmsZ3H8kjvBEv7nMvLk3CQEp6+K4bRA9HF+1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR0L3okB; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24cbb2b71b4so760569fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971324; x=1717576124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewOefsnjLcZF9k8X2fk5+VmjOrQKwuSB4YjvYAvVnjc=;
        b=BR0L3okBZzk6kDmEZNxn8L7ZR2A5To+203a2dOsTaFAHG1164aKYTm2ve6aLGv7Jvm
         rp0CsKLMmv3+Z94nATMIRoBD/uSSe5ORVMmhmc2A87Hrncq4kdUne1Wqa8vynkInXW9W
         P5XZEOcOY2zbIs6s+Oa8xAFfoTn7IHk9STEVPHzF6/XxKzUFmr6YQ77B8qQeLXhToJ7A
         59jIRs3E7303bl+QyaD3aQ6w6w/AgGLR1W3f68dEjFbouIk3UIufBGvsmDMWeZYiYuW6
         TpByvxcJEHweb/ekfw86Yv+nfCmlvUrgu+tKdCTV3QooddyXDJRXYaX4YVPjcoHePrPQ
         Tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971324; x=1717576124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewOefsnjLcZF9k8X2fk5+VmjOrQKwuSB4YjvYAvVnjc=;
        b=vBhCYbxN8Q23f+4G2wcinOK9/TpMK7KrZgE2rQ9aYHXf4ZWDF69J0ZWh6qxvJfuVKb
         50tKUb+i9cv8smrbGnaOCaoZfhm2x5p9WelZ+hC4n8mzsyTIITv6r6tVH92OYa0Cyt/W
         Kk8jBW4AwiNUqumiYfqoO8jFcI2QsoJdJm48TfL0S2kA7iGBsaF1bmI6w4nPdGew1tQT
         Me6/uHxttAc0UUBrW20nTTYkfdWiwqAQBbO6YBmdbVdL6PxV7oC+EX+++tFFSABTuPWe
         5j9Ht84U21GXJCCNf8kwonvbIRhRBxb6xMpMFohV8YSAKuYYb/4ddBD74KpvkNZUXDie
         dA0A==
X-Forwarded-Encrypted: i=1; AJvYcCXCGOWqQEf1fLjRSuOZtADMmCbUsbUGFAwHJSaCAVFzTELF/cisQVJY+y0jid+yKUAdtfHvZURRm9t+Kd8D/wQ+xBD/R9fZN6afTfgu
X-Gm-Message-State: AOJu0Yx+A97wGoP341jxBrYhdIlLZyvtU5AGlwHUQkQfojhtzsIESf1n
	pWi2b5HDscTkxiMK01dPr1hoGhDtchMkthbDoSSIGfcHcqOF9FUu
X-Google-Smtp-Source: AGHT+IH3UNmleoitLaaWKEkGkztsqlk0g2xMkG4KbUUl9w4zYCJXpK0DOsfwuTA5F3olq/PwYIKyfA==
X-Received: by 2002:a05:6870:4722:b0:24e:4fef:61df with SMTP id 586e51a60fabf-24e4fef737fmr12412326fac.54.1716971324013;
        Wed, 29 May 2024 01:28:44 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:28:43 -0700 (PDT)
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
Subject: [PATCH v5 0/6] large folios swap-in: handle refault cases first
Date: Wed, 29 May 2024 20:28:18 +1200
Message-Id: <20240529082824.150954-1-21cnbao@gmail.com>
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

-v5:
   collect reviewed-by of Ryan, "Huang, Ying", thanks!

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


