Return-Path: <linux-kernel+bounces-316581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451496D181
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0AF28105A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29E19ADA6;
	Thu,  5 Sep 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxLC40y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1484197A6C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523704; cv=none; b=NMsEYogAuzakPy0nfkrudRp1vthk6JS/MLgjyRAHFzFr8zlxS3nzOGjOah8XjnketCcX2rw5eFaIN4yxc8O9em4N0QhTE+B4Ztvy6YxGf1XmZfeVvPWCbWWc5oBhMmoN9UoHgUYEbJZLLavU6Ag+iL7fSxBIndXs+KAkItb1CWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523704; c=relaxed/simple;
	bh=pq4mgLOgPtjR7988qotE7KO6q3NyEFvajJ+jBZy0/Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YoSX+GeI4x4CZj09s61iVc1XFj+U1qBZhOVDtOkW4W+fzvQi5FP0uF2c9+dbOlU9lSlg1Wocs5Ae10MqzRAX6NMPXv/BY5nif+zrLZVi/I4v0IAAHCeBb4J7fGBMDn/HYezpBgPgOm9cCsBVTySoZ3FnMpC7BOivqKBXrUKZDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxLC40y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E6BC4CEC7;
	Thu,  5 Sep 2024 08:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523704;
	bh=pq4mgLOgPtjR7988qotE7KO6q3NyEFvajJ+jBZy0/Sw=;
	h=From:Date:Subject:To:Cc:From;
	b=HxLC40y4Wy5DCF2zi8WOTcbrT1aMCw3+A+bRHtHlZ7BbCgLQgSbIDVsIKa4dcCy+z
	 42bxu4Uc5+QPtkiLXeBhBbvvIv/dvKO7yZIuadnkPq7skPgUHkkl+qgJz5LW8U13DI
	 aVSwXa/yOuq0FZmOZdL/Dj4fZHQb0LeCjVO+Tw4ZfG+egaVYJEP7rj3auRRBWniqiy
	 amLD77Mt+gyeZAlC7hW66Qjcr2dwi8H+PdG6orWprIsFW61O40w3QnOVdoI6h6ykeh
	 +ruH9YxPdXL0YpWxKKMocr8y77BpjqMLWfPNhjgcCsWqntGhUdrh88fbCLDkr325GU
	 FdqxQrjyA3Z3g==
From: Chris Li <chrisl@kernel.org>
Date: Thu, 05 Sep 2024 01:08:17 -0700
Subject: [PATCH v2] mm: vmscan.c: fix OOM on swap stress test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-lru-flag-v2-1-8a2d9046c594@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPBm2WYC/23MQQ7CIBCF4as0sxYDFNC68h6mC9IOlEioGZRoG
 u4udu3yf3n5NshIATNcug0IS8hhTS3koYNpsckjC3NrkFwqPnDFIr2Yi9YzaZ10g9YnxRHa/UH
 ownunbmPrJeTnSp9dLuK3/kGKYIL1xvTn2Vgt1XS9IyWMx5U8jLXWLxKtoimhAAAA
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
Closes: https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/
Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v2:
- Add Closes tag suggested by Yu and Thorsten.
- Link to v1: https://lore.kernel.org/r/20240904-lru-flag-v1-1-36638d6a524c@kernel.org
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


