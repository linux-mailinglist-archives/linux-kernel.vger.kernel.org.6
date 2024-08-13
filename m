Return-Path: <linux-kernel+bounces-284355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A2950028
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C05B25DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16809197A61;
	Tue, 13 Aug 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD7LH1Td"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB16DEBD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538521; cv=none; b=WuXPRRozUSpv4QvP/LQ84Gq7y4eO3JPSo4Il2XaA87PTYOstZTiXg0chAqQAWEpNo6Rhaw+vxdfKQy2cJKdlxsN6c7zsOpTWVhbsgyvkHqDkbahRpWkAFnxLYcLCj4bU497II6y/pxRh9u8PcDRconFIDEuwHUi70DxVG2QPLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538521; c=relaxed/simple;
	bh=lwqsbsNLYr/NAY4uxgyMtSwAZaoCij/qukX2cmqm4rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eORhOG63M7gIazqA+9WY3RQfcTj/d+llKFh5vRmAIKbOpY4sUSjIqZ0SjM72o4gGpBiMY6MN6F3fC6gadFnaXo5Z3vQ+L73KVZZxoXVgYzLEOtXV4c9yonunka67tngw0kKHPZMCB2aGBFT1XlMkmedBSvswLdKoQELCQqjnOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD7LH1Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BF9C4AF10;
	Tue, 13 Aug 2024 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538521;
	bh=lwqsbsNLYr/NAY4uxgyMtSwAZaoCij/qukX2cmqm4rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FD7LH1TdysUcP3n1SbAE6auP5bdtAyVHXf3rUWPZVQR1EC39qS51lMmMomKTs3fvy
	 7fsB8mSnAG/hgU65T4GMmYCDPKayYBgRSRtWVmfvdU5gEtZA+kPGlUaeTzdQRp8vjf
	 4U7tvJjBF5qFb9kSP0xZrNyJTFcF8lSvOl0NmegGoWZBVevdSVEHorHaBIh5yFkCr4
	 3ob6BNnneg8KHjTpnx2o2raeE/wob3UTFXVqrK0UqM7kJtjrkHE12Xj9jXvQhYoeyQ
	 ktd8xeRN0S6JfPDRmiWXuDQ0JLZs24fIZ42/mgUTS4NExhZ8tTjn+QBkifl5Mj3Nam
	 btW7bLc+cfArw==
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
Subject: [PATCH v6 14/21] mm/zsmalloc: convert migrate_zspage() to use zpdesc
Date: Tue, 13 Aug 2024 16:46:00 +0800
Message-ID: <20240813084611.4122571-15-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813084611.4122571-1-alexs@kernel.org>
References: <20240813084611.4122571-1-alexs@kernel.org>
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
index 9218f1e6e8ef..f93af6e10c3a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1630,14 +1630,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
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


