Return-Path: <linux-kernel+bounces-223928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D27911A87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7071C23777
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6B16D335;
	Fri, 21 Jun 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt2liuts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BA16D321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948564; cv=none; b=ntAKgtANPFWixWMbXcYwg9gwhr/JQV4Rwpp4pbI8dxsraJaD5nYMuvwYUqzkDQIJ75Rje1uiDq6VTY/036cEV5ufLArKlZ5ZwtoAPejo9Ov4+fURoJM7XxULIEkrQeSq3mZiThV/+6skfT8xdpCqdvSRXx23YrZPb66WfGuUvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948564; c=relaxed/simple;
	bh=bi1YiTpFhUFGRvPbUZHBdhkxL3sPin4zELQjsCTT+98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoXm8iQzecQZ2d/pKjB2CPV75v0haEBGzjz9kVmKhGWmS0iPiBw44mHMbFyTuZiR5YvyIjZzmkd/T6hpHTWUGubn2c/SvHNVrB4CwIpm0LSqCewlGeAYQJ7xgYYCNae9io/Z6OjJpT61tVwXz53ToJh6PVseH7cwiZCU2KabSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt2liuts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B65C2BBFC;
	Fri, 21 Jun 2024 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948564;
	bh=bi1YiTpFhUFGRvPbUZHBdhkxL3sPin4zELQjsCTT+98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt2liutsK7oexaFQKqUKy8TRoTda3rT7B1LKbaH/xbtnFL/JUig3qUzjaQk64nmTg
	 PE2cpP3SiIOO9DqQehRhtVEbJrvnAKHGFA7kLjug6WlCc81GkT0O/+xWu+LngXcIkN
	 Zhf/+phnJpHf8VFV55ycxsk6RSqieF+MvbbIkKoRdn7zGLAzUlFNmTtBnVOP7DPQha
	 obEjXax3WVszHrEXSNat4nsfockOXEriYwLhkmu/04gFt554Q/iEarrqhvqDcQBPK5
	 v/YIgnYIEZT3L0xDJxF7bGLOLgDUN5ufC6Yavx+16hzKVpXPPPtG0dMjttpfCbAxc8
	 wIqnnJDrjcRsg==
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
Subject: [PATCH 13/15] mm/z3fold: use zpdesc in z3fold_map/z3fold_unmap
Date: Fri, 21 Jun 2024 13:46:53 +0800
Message-ID: <20240621054658.1220796-14-alexs@kernel.org>
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

Convert page to zpdesc in z3fold_map/z3fold_unmap pair, the main purpose
is doing page->private to zpdesc->zppage_flag conversion.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 6283f90d1c22..7d95c0293664 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1175,15 +1175,15 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 {
 	struct z3fold_header *zhdr;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	void *addr;
 	enum buddy buddy;
 
 	zhdr = get_z3fold_header(handle);
 	addr = zhdr;
-	page = virt_to_page(zhdr);
+	zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-	if (test_bit(PAGE_HEADLESS, &page->private))
+	if (test_bit(PAGE_HEADLESS, &zpdesc->zppage_flag))
 		goto out;
 
 	buddy = handle_to_buddy(handle);
@@ -1193,7 +1193,7 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 		break;
 	case MIDDLE:
 		addr += zhdr->start_middle << CHUNK_SHIFT;
-		set_bit(MIDDLE_CHUNK_MAPPED, &page->private);
+		set_bit(MIDDLE_CHUNK_MAPPED, &zpdesc->zppage_flag);
 		break;
 	case LAST:
 		addr += PAGE_SIZE - (handle_to_chunks(handle) << CHUNK_SHIFT);
@@ -1220,18 +1220,18 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
 {
 	struct z3fold_header *zhdr;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	enum buddy buddy;
 
 	zhdr = get_z3fold_header(handle);
-	page = virt_to_page(zhdr);
+	zpdesc = page_zpdesc(virt_to_page(zhdr));
 
-	if (test_bit(PAGE_HEADLESS, &page->private))
+	if (test_bit(PAGE_HEADLESS, &zpdesc->zppage_flag))
 		return;
 
 	buddy = handle_to_buddy(handle);
 	if (buddy == MIDDLE)
-		clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
+		clear_bit(MIDDLE_CHUNK_MAPPED, &zpdesc->zppage_flag);
 	zhdr->mapped_count--;
 	put_z3fold_header(zhdr);
 }
-- 
2.43.0


