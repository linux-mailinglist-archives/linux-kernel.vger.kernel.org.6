Return-Path: <linux-kernel+bounces-310720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDC968062
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89314280A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947A11885AC;
	Mon,  2 Sep 2024 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXaocgJo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDA18595B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261463; cv=none; b=oHvwWADIb7vjIBDMsOpVx7ZSMeTm2bD6QsdrpRReF2P7TkAGYjj/+giZ8/QBqLitbn5EK9NpgkEzlPKZM5T5BHa7PGcfLI1x5j+YO6hwq2cOnEBhM5JAtmEb/EeF8EJoRYsq46SNnbSIEQ1KBaQovL5kBCv19gnGINFhPX+o5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261463; c=relaxed/simple;
	bh=CFikcVVBkO0fkQwhPbTnJD5oTr7539f6hYvWeSZonkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM657irNOKGmPXuL0eVqAccgucCiiWkdaHPWdAQ/MNOM+nPwoW3oCnURwFF+vQPy66Pk0XE1z5JGq07vJOrLE7MV0YKTWJLh3xmNvPj2jvKLtwmXJ6b2qQGFMSUNTy3DpDdnjH9We/XvYF6UkY8Aui8aEMg4k+JIaxGKq8EazoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXaocgJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEAC4CECA;
	Mon,  2 Sep 2024 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261462;
	bh=CFikcVVBkO0fkQwhPbTnJD5oTr7539f6hYvWeSZonkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXaocgJoKA1eC/mSBuf6h0+NhqRTKodMvnfs6tgPCGpmDK4W4Jfjf9Czj01vbzrB/
	 DwYWluMcU0nesvSRU1Oqa1i029m3hnIFjyRTlL7TRvoigsU1Si26+BxCZc1SMjXIrF
	 m8JNHWz09WGPalcymX1yQO9CKN4uFTcN5ZwiKrsNbby8/9FA6yhG34TCuT7gTWM6JZ
	 4eNIM4jaA9E2e8kdSXAVYxorYAyipYDD1upXQF8a+L4fO1c3qgzq4wHVID461UIOfs
	 gualGxbb0eMWhlydjmBwg9c78Xyb5/cKmORueJ+b6iqsiOJdA1wuJN/Osv7wlfjcdS
	 AHBIjdJyXo26Q==
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
Subject: [PATCH v7 20/21] mm/zsmalloc: introduce zpdesc_clear_first() helper
Date: Mon,  2 Sep 2024 15:21:31 +0800
Message-ID: <20240902072136.578720-21-alexs@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902072136.578720-1-alexs@kernel.org>
References: <20240902072136.578720-1-alexs@kernel.org>
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
index 411621f00a02..849f192d4937 100644
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
@@ -832,10 +837,8 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 
 static void reset_zpdesc(struct zpdesc *zpdesc)
 {
-	struct page *page = zpdesc_page(zpdesc);
-
 	__zpdesc_clear_movable(zpdesc);
-	ClearPagePrivate(page);
+	zpdesc_clear_first(zpdesc);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
 	__zpdesc_clear_zsmalloc(zpdesc);
-- 
2.46.0


