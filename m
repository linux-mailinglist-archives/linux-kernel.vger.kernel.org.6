Return-Path: <linux-kernel+bounces-243908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47845929C42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B721F21B87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B278274;
	Mon,  8 Jul 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9pIQxRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0C77F08
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420195; cv=none; b=Fd92JOG8BYytHzh6rsIGoqbP6oybIpHH9q6PWxroiJ2mKJ5GVeSejA0RvADca80uQ7H0wNoh/ID82LTfCMfei2ZmWuppeUoTbgoxLTRkw2ehiszLuWNcJxPqrzz5Ye0s5SFK4PHpXmjm132xD/7ilBKeGsjG+jAxBAKqLIVkqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420195; c=relaxed/simple;
	bh=YePXlWlhu0t9cQ2FhNb4Tu9YraM33q9YNNO84M2/1AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abf/0bP/z7/Bp2GjuOYPRb8myNWtqWoNfG+oB5SGKE1xPbIZ86tFh972iCWSrjAvKcj9rsJzU19vcKMnOVEOcoLFT2eGKBj8yuxhM1EHe6rM/bewMmSZtcKNbQTctQhfOeCXxZW9DsFpniti4jYrtf5MlJQroHY/ULeNasAVWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9pIQxRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CF3C4AF0B;
	Mon,  8 Jul 2024 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420195;
	bh=YePXlWlhu0t9cQ2FhNb4Tu9YraM33q9YNNO84M2/1AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9pIQxRc74qXODLyeYpN9Usf+mKhKNyEtYaG/uShlHPiP4pI4bAMJ0ZxPksRq+auS
	 Qq89KVFjK+cS/UBpysNLdcOw2E2hcw1sCMvZl3KUc+HOJbs49yZs8V9xBzD7CQpPXk
	 xrf1GXo8qGKrN8Mfj5BxDOcq96OdiaGcpT+j9Z+Vx0xpJbuPHuGsusNl5njig/hpaW
	 a2NyztZknNxisBfbFjaz0C56dqMEDimRCGr7nI1JjNqJV+zZNtkz4BQqyS4XDUDCt+
	 XUshBq06XfyGRAvEqCFVF5NOrrRoaTNdPTkLKW0edIVF8ssJm5jovq14e7nkoO7ZPB
	 O0r04fevGt45g==
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
	42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v3 20/20] mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
Date: Mon,  8 Jul 2024 14:33:41 +0800
Message-ID: <20240708063344.1096626-21-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
References: <20240708063344.1096626-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi (Tencent) <alexs@kernel.org>

Add a helper __zpdesc_set_zsmalloc() for __SetPageZsmalloc(), and use
it in callers to make code clear.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 05def4d45265..06371ce60cd1 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -119,6 +119,11 @@ static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
 	__ClearPageMovable(zpdesc_page(zpdesc));
 }
 
+static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
+{
+	__SetPageZsmalloc(zpdesc_page(zpdesc));
+}
+
 static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
 {
 	__ClearPageZsmalloc(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d88602fb0233..7f8e02df4e3e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1030,7 +1030,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 			cache_free_zspage(pool, zspage);
 			return NULL;
 		}
-		__SetPageZsmalloc(zpdesc_page(zpdesc));
+		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
 		zpdescs[i] = zpdesc;
@@ -1820,7 +1820,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
 	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__SetPageZsmalloc(zpdesc_page(newzpdesc));
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
-- 
2.43.0


