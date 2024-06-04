Return-Path: <linux-kernel+bounces-200010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CB8FA924
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369F21C21F58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3EC1411C1;
	Tue,  4 Jun 2024 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0kDChGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00C140E58
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474910; cv=none; b=Jv0w2J4F12qSZjMm/KwTZltUto3IlJ4eRjfMQPngh1pJktNtVo2HjggzyCM+m6sWnEOiln25Yc+jRUwBXZPD4vADS2FBFYTfOx/fOT8YWcsF6LIhgMhgHfGiISA7HbeER0jcjfHlqvizJNM8bkk6hXVxzlb0A3n/KK0gBSwrONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474910; c=relaxed/simple;
	bh=r3mq/HoGLqusQ4dyUdx5DxYmG67Uuzo2XB6s67qh+EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ8rf0BOUD4SZHaCDHfrt/2YNyMRdssaafyGIktYRcMhkQSkZZ9DKONC7vw04Lk17DYH9o6506iHuJpCWA6vqWsISfKaSRbf9gbr+KrWT85Qm3EiUqVwDvtfG72y1hN7Iej+zB0fqJxY/1ZX/f1SVzoJtmZTUs72iSHeQc9hE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0kDChGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A0C32786;
	Tue,  4 Jun 2024 04:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474909;
	bh=r3mq/HoGLqusQ4dyUdx5DxYmG67Uuzo2XB6s67qh+EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0kDChGNADArwjFTu0Ecxn/z6ERtbQhoafRczm2xl1DKivY/FBSpOu3M+FIXHE6fF
	 9Q0KEuEWhS6uMtUMtCAR4SdvOqzexhe1KgXmnM9iLbGsMsGOhrlExEnyIhzDOgWHGL
	 cDtkyQewEf1KcrjO6fI9ttmJUheFSRDfKyw5Y508mgtq2AIqf6Dcd037olbbAV+Nct
	 Oojtpd89prXDc+dzsNEoIqTpc7ewALNrTL2+F1hmpea4SqHVs2ba3fufnIKMh5xfPB
	 lykxIhWDHzdJ/3dNwpJ+heYxTFMd68/BX7l3eRuP3lfSY4mAibw2pQq/it3pAyAEGs
	 GYPBMNqRZPP3Q==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 06/10] mm/ksm: remove page_stable_node
Date: Tue,  4 Jun 2024 12:24:48 +0800
Message-ID: <20240604042454.2012091-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Since folio_stable_node could replace page_stable_node now, the latter
function could be removed and save a bit context.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f68779651841..24de562b64e1 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1086,11 +1086,6 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
 	return folio_test_ksm(folio) ? folio_raw_mapping(folio) : NULL;
 }
 
-static inline struct ksm_stable_node *page_stable_node(struct page *page)
-{
-	return folio_stable_node(page_folio(page));
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
@@ -2324,7 +2319,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	bool max_page_sharing_bypass = false;
 	struct folio *folio, *kfolio;
 
-	stable_node = page_stable_node(page);
+	folio = page_folio(page);
+	stable_node = folio_stable_node(folio);
 	if (stable_node) {
 		if (stable_node->head != &migrate_nodes &&
 		    get_kpfn_nid(READ_ONCE(stable_node->kpfn)) !=
@@ -2345,7 +2341,6 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 
 	/* We first start with searching the page inside the stable tree */
-	folio = page_folio(page);
 	kfolio = stable_tree_search(folio);
 	if (kfolio == folio && rmap_item->head == stable_node) {
 		folio_put(kfolio);
-- 
2.43.0


