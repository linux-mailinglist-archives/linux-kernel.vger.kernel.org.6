Return-Path: <linux-kernel+bounces-223929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAE911A88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4CB1C23CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E316D4EF;
	Fri, 21 Jun 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smo9cGIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4C16D4D9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948567; cv=none; b=jHGBZPCRV77NR9hT3WJFQof8BHYRbDzHRmTCyVE5tg11qreXdQdxnck2S/zFF1xCuCe1LMXJcLuiroa43w671bbtgC6raIPpezoozktZpL+rCaJ306zfcpxLacjBcVyDi0wQyXJ3hPMtoevuZECP/nfwTIfPbw8TA+VCO04zHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948567; c=relaxed/simple;
	bh=ZVUFLxXaSMstqeF9wiClbo0Fyh0HfCRoDm04x2KLjcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKAxbknGh1WKqeyWDUG90BrSZgSfy9dVp35SuBpeIC+AuGD2NAoTQbdcigy13Z6cJLpRFiyimWJrVmxc8OOgajLQcJivoG58O/FLfIMzeTop5kOtodwuO1U0b/wI9H9LnvrGdjEgfrxrckcUatd1d3fAKrmYFMYCWUfw5a/UZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smo9cGIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C11C4AF07;
	Fri, 21 Jun 2024 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948567;
	bh=ZVUFLxXaSMstqeF9wiClbo0Fyh0HfCRoDm04x2KLjcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smo9cGIVWmL2EmyJ8D3bauM2U8VHnP86YPTsc7LWNyv9TNzRXhgzPZGt/BHOQIZzc
	 SZwhipISzcDFOzAYG7tOzqpmjxFuK3oXYwHeoKJ1EY7JJY9P/yvz0lkw9h9CKZ1VG5
	 RtVZEWyyUY/f6CYtFuUuU4SDpViqbTHhTFZkS4vCwcPTliT7zeA4MGNgCNH43Vxn+W
	 O4Pd09FFoTkrvcCROJvWAREpQd71+NTQ5ZHuv1nv8aWR8g8jlRTS0dfYrxhodoIvo8
	 F2I6UKDa/XO/cSmo4+hYNCuEhAJQ7lBNcEMPNrORnwi1syjk0hEgoySbpNH64e6nvR
	 uyORwIdsuKSAA==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 14/15] mm/z3fold: introduce __zpdesc_set_movable
Date: Fri, 21 Jun 2024 13:46:54 +0800
Message-ID: <20240621054658.1220796-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Add a helper __zpdesc_set_movable() for __SetPageMovable(), and use it
in callers.
Since we actually use the page.mapping for 'struct movable_operations'
pointer, we could add it into zpdesc struct now.

Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 6 +++---
 mm/zpdesc.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7d95c0293664..35e48440c517 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1050,11 +1050,11 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 	}
 	if (can_sleep) {
 		zpdesc_lock(zpdesc);
-		__SetPageMovable(zpdesc_page(zpdesc), &z3fold_mops);
+		__zpdesc_set_movable(zpdesc, &z3fold_mops);
 		zpdesc_unlock(zpdesc);
 	} else {
 		WARN_ON(!zpdesc_trylock(zpdesc));
-		__SetPageMovable(zpdesc_page(zpdesc), &z3fold_mops);
+		__zpdesc_set_movable(zpdesc, &z3fold_mops);
 		zpdesc_unlock(zpdesc);
 	}
 	z3fold_page_lock(zhdr);
@@ -1334,7 +1334,7 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 		encode_handle(new_zhdr, MIDDLE);
 	set_bit(NEEDS_COMPACTING, &newzpdesc->zppage_flag);
 	new_zhdr->cpu = smp_processor_id();
-	__SetPageMovable(zpdesc_page(newzpdesc), &z3fold_mops);
+	__zpdesc_set_movable(newzpdesc, &z3fold_mops);
 	z3fold_page_unlock(new_zhdr);
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 9ead7a452f2a..44473382f2cc 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -73,4 +73,10 @@ static inline void zpdesc_unlock(struct zpdesc *zpdesc)
 	folio_unlock(zpdesc_folio(zpdesc));
 }
 
+static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
+					const struct movable_operations *mops)
+{
+	__SetPageMovable(zpdesc_page(zpdesc), mops);
+}
+
 #endif
-- 
2.43.0


