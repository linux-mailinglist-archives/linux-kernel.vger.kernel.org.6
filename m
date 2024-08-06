Return-Path: <linux-kernel+bounces-275591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284A948774
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A4B2860FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B91BDDB;
	Tue,  6 Aug 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC1dagSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244AAD5E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910727; cv=none; b=DxcTe8CutOMOMeN470ATDmJ+40DObt1RxDXP1UwkY6nN24+cBvdtgBcQVTw0oB5Fr5bPkK5234KU4LfDaay38a4BYTvty5HhFtA1+0gv58YYmWGaxFlLFbdDBe2Tr/aiimpMcOG0ev2yf/rRl2RKMjJMhV0WnlyVuv5etziTWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910727; c=relaxed/simple;
	bh=UE8t+seeM35rl2H7JTm6eRVAxobMBm5PBazGBdplkkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwThjgBOUsOSPZ7wTPH3e/be/RH0Gn42fG8Ro1DWa83cNVyPIZnSEdKJYnqPUOhfTGgpA9lZmWQTjL+tQ57TpbVGTMHVKbnhaG1yWsbl2jQlnr7vfhd/+MfU1ajCo9nmEpmFp66zU6uEAcsWDnI8KQz8D3CaH767ctWVKK5+gdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC1dagSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0788FC4AF0F;
	Tue,  6 Aug 2024 02:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910727;
	bh=UE8t+seeM35rl2H7JTm6eRVAxobMBm5PBazGBdplkkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QC1dagSPDYyeNnZc8QopLpLhTX37estqkQpAdmcGKNJbVDWh/qqd4LXDnB9rPkwo8
	 a5aYS0P0SofZMckIif6UjPr4WkZzfpHrUzYIMglACX2iFlDgqrD7MmCC1PSWaPV2XR
	 4s7xbWyqt0Pf2yz0mPj8FaMGg0br36C84Q2I2Sc6N0UVKDmLr9mQ91j5HduyA7RXQf
	 AJgeqEdBcb0yfzmxjDNiltYEvbGvoZFOfiIJiYLj8FzzUrjCgp90Qm3abdIcIP1/U7
	 vHzJUWdv9NoTlwyaXv/hHPPUokBHRBunGFV9102zXdOcI3xZq4MGWE5tUhw0uLYS/A
	 Koq9n6XXYdWFA==
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
Subject: [PATCH v5 14/21] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Tue,  6 Aug 2024 10:23:01 +0800
Message-ID: <20240806022311.3924442-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Use get_first_zpdesc/get_next_zpdesc to replace get_first/next_page. No
functional change.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e6d1bd8969e5..c8a533b516ea 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1616,14 +1616,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	int obj_idx = 0;
-	struct page *s_page = get_first_page(src_zspage);
+	struct zpdesc *s_zpdesc = get_first_zpdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, page_zpdesc(s_page), &obj_idx);
+		handle = find_alloced_obj(class, s_zpdesc, &obj_idx);
 		if (!handle) {
-			s_page = get_next_page(s_page);
-			if (!s_page)
+			s_zpdesc = get_next_zpdesc(s_zpdesc);
+			if (!s_zpdesc)
 				break;
 			obj_idx = 0;
 			continue;
-- 
2.43.0


