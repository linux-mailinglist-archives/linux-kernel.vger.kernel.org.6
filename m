Return-Path: <linux-kernel+bounces-275597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C694877A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B551F26483
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227F770E8;
	Tue,  6 Aug 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eogsWgAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B0762C1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910750; cv=none; b=BAbBGqZRUtTmBbXYmC/Fc6iQ9gX+y0qrz+2bi4ZjLXTzjuVxrg05cs/2C1Kl2KqN6qV8/KyeIwvNK1n5qTDK5y6ZhiF2M2iF8D/O0KEaphAX4MyYAmRqUsrzIDG+EJfrPuj5efgw83s1truR1Y3Vkk+zEkO40WkU9Ux1/oEfwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910750; c=relaxed/simple;
	bh=SIgiyPCW8QCBZtqr5fnMzvbajnde7CasC3gp99UMX7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StnfxI8cPYVc7qR5dx7JMHZY3RBYU/p2sjBEA6jxgKG9Bp6pKYYb8q8EOTp8KChZr4kvY1cZizkGTfOGAB0U/EG2VgXp6C627pppOo8c9vCvgGqtVVjLLyVRytN+S8hATlQssj09X2DJlJe0iNS6GolQtExCBaJH52Iqv0IBwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eogsWgAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4D5C4AF0C;
	Tue,  6 Aug 2024 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722910749;
	bh=SIgiyPCW8QCBZtqr5fnMzvbajnde7CasC3gp99UMX7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eogsWgAJOVMVgMm+88DiD7XkroE1wr8TVvpEQjp6NmnLl30eBFsFWj/nQJK+I8c5I
	 jUhC6+ElxHccYMtnUAdfDvOCrIXJ1xMAi+HSzAgR5yAn1y686RgXFAQo4iYVVx44kJ
	 dBNVnqwpiPqTyTKh3OA5LoUrYXaseNQYH3N0a+Z8E9/IdcZJ72fPC9/LMMjOC5NpMH
	 h46X+x/17nvesgtbZ3mxjDf/f1XGF2Wp8TGFIPucQKhRAFPIUBJxVLCHLlEozMXN/2
	 yHKU2MvKQY37DOnJnxKAUQXYl65JxIApCyH3Cvfj9VuUr49mJFH14C+pH9E5/7j6Ly
	 xUWeJVNSWL3aw==
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
Subject: [PATCH v5 20/21] mm/zsmalloc: introduce zpdesc_clear_first() helper
Date: Tue,  6 Aug 2024 10:23:07 +0800
Message-ID: <20240806022311.3924442-21-alexs@kernel.org>
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

From: Alex Shi <alexs@kernel.org>

Like the zpdesc_set_first(), introduce zpdesc_clear_first() helper for
ClearPagePrivate(), then clean up a 'struct page' usage in
reset_zpdesc().

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0b318db894a8..e92451c6b69c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -253,6 +253,11 @@ static inline void zpdesc_set_first(struct zpdesc *zpdesc)
 	SetPagePrivate(zpdesc_page(zpdesc));
 }
 
+static inline void zpdesc_clear_first(struct zpdesc *zpdesc)
+{
+	ClearPagePrivate(zpdesc_page(zpdesc));
+}
+
 static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
 {
 	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
@@ -824,10 +829,8 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 
 static void reset_zpdesc(struct zpdesc *zpdesc)
 {
-	struct page *page = zpdesc_page(zpdesc);
-
 	__zpdesc_clear_movable(zpdesc);
-	ClearPagePrivate(page);
+	zpdesc_clear_first(zpdesc);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	reset_first_obj_offset(zpdesc);
-- 
2.43.0


