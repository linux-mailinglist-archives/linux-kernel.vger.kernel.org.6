Return-Path: <linux-kernel+bounces-310709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA711968055
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081C31C21B31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42135186E20;
	Mon,  2 Sep 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbsWZzPz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490D185B7B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261424; cv=none; b=Hcr08RDjI03m9aKBnoNHMlPzErxulbXENCNXHWpCJQvVIaPGpRnGTqns3JkrF+56SNZtf2Mam5iyvparUiAhpYKz0Ck7l2iUD0d7IthhE5Sngwg+KKujoTTVG4ZxmkDJlVkAxNJuxAxeLbJ6bgXIJyy70Av3SH90Evdjf2qMXXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261424; c=relaxed/simple;
	bh=sa8ddOMDXRaYhp/IOg2wSEnMgXawFHsto5brOpBu4jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg8eJuMONhczNToyZaK/Ah7zGZylbOTHor9RfwlU/cazi8Z+lb5pE8l/KhKLUeXxLbZjiFqZgFXldFapJopULkllDkLObeAZnrE6nOg1FcFqnCnLGQhBAe+3F7h6mKIhmzG4sW/TfQBZcoeLRvFmZ1o18s5GVWBu2EEKX7nQDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbsWZzPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422A2C4CEC8;
	Mon,  2 Sep 2024 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261424;
	bh=sa8ddOMDXRaYhp/IOg2wSEnMgXawFHsto5brOpBu4jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbsWZzPzOYnq9VACFjLbHT0QtTboQMrs9Cl5BnEg42AvkulcCszPJZC4ZgWJ7VBIs
	 aa6jHlKKy7UdoTM3zYo5H5sY1gxJVq8u6gEGeIGVjHyKyvlMx7Jw+fs2WXoRrqOR6k
	 B3lHLvwe6ydPue5clUvlCNMVXV1PbfHaTfNFXvS5C78imrXR4D+wTnakGT8ZwdzMak
	 H1fg402rc99rP4R//IJ5X02R3KMzo1XrNoEQMHSIEhTNiwT7e4352mPk+9CfuKWovi
	 EMzxRlUou3vQ/ZS/xQiscEZrpsDV8+bThb50Mn1FvN2/rNaA8KQJEsw34L71nnOBAY
	 L0XGUwN8m4lWw==
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
Subject: [PATCH v7 09/21] mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
Date: Mon,  2 Sep 2024 15:21:20 +0800
Message-ID: <20240902072136.578720-10-alexs@kernel.org>
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Rename obj_to_page() to obj_to_zpdesc() and also convert it and
its user zs_free() to use zpdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 01c5be6f4c96..90d93cdc5df6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -808,9 +808,9 @@ static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
-static void obj_to_page(unsigned long obj, struct page **page)
+static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
 {
-	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+	*zpdesc = pfn_zpdesc(obj >> OBJ_INDEX_BITS);
 }
 
 /**
@@ -1483,7 +1483,7 @@ static void obj_free(int class_size, unsigned long obj)
 void zs_free(struct zs_pool *pool, unsigned long handle)
 {
 	struct zspage *zspage;
-	struct page *f_page;
+	struct zpdesc *f_zpdesc;
 	unsigned long obj;
 	struct size_class *class;
 	int fullness;
@@ -1497,8 +1497,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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
2.46.0


