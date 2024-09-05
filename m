Return-Path: <linux-kernel+bounces-316404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC096CF12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9901F2814A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5831891BB;
	Thu,  5 Sep 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK3f94ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0242BB15
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517269; cv=none; b=Zhxw+Rdcf3egx1pE97200RLK8NNHDkT7+Ox9kJD1CkNOCxM03fx1ofgQiFXwRr5eyfPwSuZCU9REdQwszkZqLd88l6rDrVmYtush07YJCce+nQBju5qvyJdmaDRcrWvkC/HgLFqzvmgGrFjjfleyZnv+LCBLjk3KwXhSsrjApbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517269; c=relaxed/simple;
	bh=9G4uSfBJSYvJhSJCNBznlu05STrgif4WeJtvaeHYwnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AhsHuq3e+y8UJpRFz7HVkEbD3a3MUuXO1lJsx6Lx5vjnNmb7/J+5lDhu2CfoGMR+2EhCLYh6uJCEX5lC0qSbLNMVG/DvVR/cZWzXs+k9JzOEX07PlujWvcsS0vkdMGtG8zHOAGA4/6hNdSaSVjkr26I+knjcmrs1uon/pmKL6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK3f94ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9DEC4CEC4;
	Thu,  5 Sep 2024 06:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725517268;
	bh=9G4uSfBJSYvJhSJCNBznlu05STrgif4WeJtvaeHYwnc=;
	h=From:Date:Subject:To:Cc:From;
	b=JK3f94abeR/I2GZxc1EEOZA8jRB5GpzhuZW1jUqfHeZUQFBH+5elVYmkTUkwSZUbB
	 vEy1kRGIWVsxs3qDn76TSaYVujt9Ywr7KbHNU9VFCF87y+Dff916B4xWNjV/oHwrRi
	 4Hf4XRf8APHTgggRhzHUMKNYj2dF8GVEVnirLq5H7A3csnVom5M3vcCCHtXTkDka/z
	 mJTHco564npzEKReeQflovZ/jbIyLeF24hJIP8o/xjMGsPYcv0qvMA23/x84wocaVt
	 uxOn7AdXn+beSIQLKnXf6yke/1T64Hfd+twtI28Vj49J6SFleiwDXL+lm988JLV3+d
	 iKOofR5/GQ8/Q==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 04 Sep 2024 23:21:06 -0700
Subject: [PATCH] mm: vmscan.c: fix OOM on swap stress test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-lru-flag-v1-1-36638d6a524c@kernel.org>
X-B4-Tracking: v=1; b=H4sIANFN2WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMT3ZyiUt20nMR0XaPENKM0S1NTcxODVCWg8oKi1LTMCrBR0bG1tQC
 z1AvvWgAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>
Cc: Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>, 
 Hugh Dickins <hughd@google.com>, baolin.wang@linux.alibaba.com, 
 Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

I found a regression on mm-unstable during my swap stress test,
using tmpfs to compile linux. The test OOM very soon after
the make spawns many cc processes.

It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
(mm/gup: clear the LRU flag of a page before adding to LRU batch)

Yu Zhao propose the fix: "I think this is one of the potential side
effects -- Huge mentioned earlier about isolate_lru_folios():"

I test that with it the swap stress test no longer OOM.

Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/
Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch")
Suggested-by: Yu Zhao <yuzhao@google.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Tested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9b6a8196f95..96abf4a52382 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4323,7 +4323,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx) {
+	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;

---
base-commit: 756ca36d643324d028b325a170e73e392b9590cd
change-id: 20240904-lru-flag-2af2f955740e

Best regards,
-- 
Chris Li <chrisl@kernel.org>


