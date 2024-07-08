Return-Path: <linux-kernel+bounces-243897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC7929C36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372E21F21B72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F39E3C08A;
	Mon,  8 Jul 2024 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj79AIzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A03BBE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420155; cv=none; b=IZ37p+GrAZ2MaC7xY4E8TbSqGg/jDi4Fpx9Mi5b+zgSK9uc3iB6REx3Y/Wd/fvZ34xndli53sEjjMNGO/bLJMQmCzO8wtGeh0nJ5mbc0F9EsVRPfOZhcmijlCIp/0LrG40oope7GGtwN0cjAu6zEbpwatavsNu0XPmbiQMYAXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420155; c=relaxed/simple;
	bh=+/6M40wiCxzKTfpFU8y734xJ8A1hop+0lKYvujpVbRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3tx3aRiEcKgB9hbPtdxiL36E4KxwUKMZKzxdEXfBAghcXXHKTxhfcYKrAVheniB68mnAaM1OSaUZFsOaw9FzFqJ5aPjmV/ziH1laV/nvpCFtZO5ZUkuAeWOwouDZnsCoCR4bRAn1gdwwKiL0En0wg5Zh20BM9uOwT7Mc0oyDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj79AIzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D9DC116B1;
	Mon,  8 Jul 2024 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420155;
	bh=+/6M40wiCxzKTfpFU8y734xJ8A1hop+0lKYvujpVbRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bj79AIzd5Z96XkWJssrQs+SgHiVAhDvkvP7hybFxHBlia0CX41bCz2dfAe1FEvavy
	 ucW6BDXw013iA/lgkUiD5DgFHRea6EFDOX9+8HM2uM9TPPJNuJ1VH1g5XqEj6bfFTw
	 9mHe15jm4warZWmrhLIn6yMxXXdVaTxcTksSp1MlPWPMoBlnxjIEXt48H/+sYbZVF7
	 GCslgTjIOKhj83dyvlBFsD3uBjPddg4JuIZZAjASa4DLkpp5j746AIFjUg7QXG474a
	 9/l1EE3zbQ1sWJVejTgqd9VqAr9xEOKn1aYKN6KBo+pSfT2RLMFmBjoVb9jsRauqSC
	 rznbzr55ZCVBg==
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
Subject: [PATCH v3 09/20] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Mon,  8 Jul 2024 14:33:30 +0800
Message-ID: <20240708063344.1096626-10-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d3558f3f8bc3..7aa4a4acaec9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -820,9 +820,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1496,7 +1496,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1510,8 +1510,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	 */
 	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
-	obj_to_page(obj, &f_page);
-	zspage = get_zspage(f_page);
+	obj_to_zpdesc(obj, &f_zpdesc);
+	zspage = get_zspage(zpdesc_page(f_zpdesc));
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
-- 
2.43.0


