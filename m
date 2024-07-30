Return-Path: <linux-kernel+bounces-267469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D37BA9411E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1822B2859F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B61A00CE;
	Tue, 30 Jul 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL4YamNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB419FA8D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342462; cv=none; b=phmv5L6fPQtL9D8v8RIGJxHEHNke+3DPKNdJXG770Ix/VbDob5D0h3goh2huzHdsfogAG5SHUNm1kcNJbqDMW3JRfjJ++DYMqv5/tgB01NOR5okK7GJHlIRmbEwchZRtKLCFkC8vW2pL9SIWEysmfaQOr+4uAyvYbfbkFhqnLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342462; c=relaxed/simple;
	bh=rBOTxVukObDt26c+er7K24D5TzmL/+0zcqF1Wh3ZGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdggzB7R+SBhfiUFSCwjFyy/zdNsReaTdTMn/AOSKzp7R5HRO5QaisFDJS1ASulEbtX1jc2CfvRQ2uMLCAWD+SGvAeQDTUR5mjOcFN9U/cbyhGdnacWq+lDSI4Uo4xJUYvn4amtsVs7jxXu7FwReKTCu9oT1oVpfZhz4HqJUGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL4YamNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC51C32782;
	Tue, 30 Jul 2024 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722342461;
	bh=rBOTxVukObDt26c+er7K24D5TzmL/+0zcqF1Wh3ZGHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CL4YamNWq/Sh4OpNbR8MweHnWdrmkAREEsaoqPREX07MePcgTdhGqtesC1js1Awty
	 qc2hh95WqP5Pu2/aFf9j/Xg+TNY67MMwk9HzZFVMivzAFZogpcGCd76qJ25KXj82d1
	 T3vhlM//Y30II7zafEEvIifpvK/iPqFtr5k+J9fmGCHE9rpIKuPbur7mU/3eyUg4pz
	 VoPNv5r87i0T4jm2kHnDon8VU8AJG4VUOBIUvTgeDhaP9Ym5aL6N1B0iMt2ExmNbnt
	 QwzHKMzrZVJCeO6AAliH+4JF/TsjzXH+2OkCp603oaAukOdkyqqSWT7Iv39JtP/ULI
	 1KluTFaLBQB9A==
From: alexs@kernel.org
To: alexs@kernel.org
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	vitaly.wool@konsulko.com,
	willy@infradead.org,
	yosryahmed@google.com
Subject: [PATCH 23/23] mm/zsmalloc: introduce zpdesc_clear_first() helper
Date: Tue, 30 Jul 2024 20:31:57 +0800
Message-ID: <20240730123157.3761782-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729112534.3416707-1-alexs@kernel.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
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
To: linux-kernel@vger.kernel.org
To: linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 50ce4a3b8279..731055ccef23 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -259,6 +259,11 @@ static inline void zpdesc_set_first(struct zpdesc *zpdesc)
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
@@ -844,10 +849,8 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 
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


