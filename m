Return-Path: <linux-kernel+bounces-547465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF1A5098F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F21188EF16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5D2571C4;
	Wed,  5 Mar 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODq+EsY3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA2257431
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198597; cv=none; b=ZH8avHdDS0OhTOdZEa1t7SXRg5snUrNEOJ2qKi1qlmAk2Q64k0+UJqmkFnbsV8ZS/UBrDlgj3+kWRbmTP+GMHBq0d1nYNMsS/b6q8OIgF1qjNBtYzL/AjSEu8cp0FKACbpIaTlDOtsKHC2U9MqNf3R7SU1HUrcXiIMYX23bArPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198597; c=relaxed/simple;
	bh=61D1iQafSCEWPTeNlMInbGqRcctkDb5o3v4OcYZ+P3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WM2AEaST/Ao+zhAYyUW8QG4paK8yCtUvkNWpXtML/nDXJ009jDZid0ZFHLXa2l9kinOvGQA5Uq5SWlq8n5BuWrcpt79sLuPzKsbWebj+sSp9GJzkzk4/rxBPX6IsanL4HYcDliFFGqLZ+D93iXKq+LfAwPjrXJnoxCxeGlS9C54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODq+EsY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F51C4CED1;
	Wed,  5 Mar 2025 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198597;
	bh=61D1iQafSCEWPTeNlMInbGqRcctkDb5o3v4OcYZ+P3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODq+EsY3/sWBCSNpxUzI9FMLsZgJlE7Dy483xYT6Kt4Mg9OSOluTVjXkexjRq06BP
	 lMjO/Tvnxa+w8n00c6Ym/vYh9UQPMiZhyyeLvhnrMMamKOSuQlpWlcx0PMFjH/MX6F
	 ytwabLKAQ+ZDeElAuiuMgHvEVF5zBtNbM5TzCIPf1hHdk4ishq53IQaBGF13pVfoYd
	 VQaSMorn8QNtKh1+SKJh+KsAN8iL5J0q9YcWzqrSqxEYLL71uQrH5lDesIYn1ZCwQ4
	 JqI988Cd1g4LAGOkzGZOhhM7/4LgMTyYtyliqk4Pp9IshM7YYxA91Hcnc8DcngECjW
	 ApD3cjLnF7fdw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 15/16] mm/madvise: remove !tlb support from madvise_dontneed_single_vma()
Date: Wed,  5 Mar 2025 10:16:10 -0800
Message-Id: <20250305181611.54484-16-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_dontneed_single_vma() supports both batched tlb flushes and
unbatched tlb flushes use cases depending on received tlb parameter's
value.  Both were supported for safe and fine transition of the usages
from the unbatched flushed to the batched ones.  Now the transition is
done, and therefore there is no real unbatched tlb flushes use case.
Remove the code for supporting the no more being used input case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0d292b8e1a0e..1dd2c25c83d8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -866,10 +866,7 @@ static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
 		.even_cows = true,
 	};
 
-	if (!tlb)
-		zap_page_range_single(vma, start, end - start, &details);
-	else
-		unmap_vma_single(tlb, vma, start, end - start, &details);
+	unmap_vma_single(tlb, vma, start, end - start, &details);
 	return 0;
 }
 
-- 
2.39.5

