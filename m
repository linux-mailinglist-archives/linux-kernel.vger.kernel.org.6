Return-Path: <linux-kernel+bounces-284359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CC95002C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD40286A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F119CD1F;
	Tue, 13 Aug 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxpHjX6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78319CD0E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538537; cv=none; b=V36ILyIdY1ZIITct2dovVVCZl6D6qTBQjIx3MNXA7HnFRgG82MyZw4LQK/s1s3cNmaRFkO35viPqDz9DIyuM5Ze3FDQI2X8NVvx3EUiUb8n+rtX/htQawymb7xzAHG6riRg9LyWdDs2M0HfW30SAxJieXE6KzIzsJb3H8VTBmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538537; c=relaxed/simple;
	bh=xc1UgoycHzcMSLrT87O9Jysr++5t0k6ZYOyK9RWDCgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVKbkYz3v61OjJZIHVOF0uHwYYKE43F97Auxk4B7jNRVNJOwzGsNZoz6AolXB3tzcr7ln2eCPUxpav4+wm+mfpCEMoZ62v/jCHUWbBEltI/viAAR9dsWC7ds/2y+IgoP7YRn2w3JjWLkiiIcDnppJPx5GXnrnbBiYvVgROpZkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxpHjX6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CBC4AF15;
	Tue, 13 Aug 2024 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538537;
	bh=xc1UgoycHzcMSLrT87O9Jysr++5t0k6ZYOyK9RWDCgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxpHjX6Dipw7WJGW9x/CzrdZjjx3J2swcfh5GtuduL50FV7HjHZSe+ro4MjvMCUyA
	 PcMTPHKXGAN19nP01URDq5t9Iau8uj9OiNhIq5TxCQZY2yn6OSUljkeCv2ZtSh4LTj
	 u04TdFn20fcNRN0p5vZ+wuShi2vcaTbze1tOo/JWqVvoHy8OyGilw1ZzeTE1cSskNZ
	 4JHIFSL7oKHyZIeEv5GStb+5Rn3G3hQdbzyFDPCE5QIgtRD1iQFYBOSbujz//injjQ
	 G8i7trnT5ZET9efzMHq8kwGTqu7jjEMeVLgB09lYALGXQLbWfO/eCg9vElqgQcPykN
	 cD7JvS6W96uRA==
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
Subject: [PATCH v6 18/21] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Tue, 13 Aug 2024 16:46:04 +0800
Message-ID: <20240813084611.4122571-19-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index a1834d36ccfc..747a2d410a35 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -115,6 +115,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
 	__SetPageMovable(zpdesc_page(zpdesc), mops);
 }
 
+static inline void __zpdesc_clear_movable(struct zpdesc *zpdesc)
+{
+	__ClearPageMovable(zpdesc_page(zpdesc));
+}
+
 static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
 {
 	return PageIsolated(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 8553542edacb..64b9ea011111 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -840,7 +840,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.43.0


