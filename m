Return-Path: <linux-kernel+bounces-233305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE891B54C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AD81F21B64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66274BE0;
	Fri, 28 Jun 2024 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvOnLEDk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913A7441A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544075; cv=none; b=owJId4deZTph7+B/mppObMsO7Tvkr0SBc6+2wIVhOHKNst6n+9u49m/KpTuwfVgkqJq307hkVSLIeJ1wtN7UdDsn0m8pFDJNdNUtAw83YCrM12vVnF8d5Kn0qa+A+Nha6ywDNFyhZkT0rOmf9pXa78gUlIXWwK4F9JLWgluOYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544075; c=relaxed/simple;
	bh=fr0OSLBdVEu4PiREH2sgZbNiunlztN2rB5Cg12p8Bfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUzJBIhYqSenohi9jCH+ODyaeeCWmn37/7nitMe/Z352ZFitUo8MviDUbozh1SCvYNv8qDecNOMK5aMF01N4LUw5GbvFY4ud+do+EDFq2LWohrbLa8PfxN4Ey6+727i11jsnH47rXWawPe86axNmhS5kF04GTJCAWgxqTaJ6VSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvOnLEDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8258FC32781;
	Fri, 28 Jun 2024 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719544075;
	bh=fr0OSLBdVEu4PiREH2sgZbNiunlztN2rB5Cg12p8Bfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvOnLEDkbTMaJdXPPoE1HQN7ICZRZxu/wx2iuZ1D7NCvHtiBu/yFUSmpp5eoK+R+Z
	 TvQqHcw2vcNpwhurl3xIfOeKvMoBgVhkiFsLwk0VU4++awCje1qxplJZfPZn0cbjYD
	 5x1ZXJrtgAeHdcFkb8/i8YpR1zJv1PKsrAXbqKRKqZPO0plgI5cGurmLzHbirBSPEc
	 dhk0stZxfzY2xA42dD8R6xyMrrBjAVjxbF2X/2AT1IGkp3TraKKTbrLLOCjiOnZ3+K
	 08leqFILaTWgWWtRcj3nawG+h99Vs1nRjoc37yqyeL2bdDuvr6V5RNmcnnWddzGbGs
	 yfGXWvqCkDi6g==
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
Subject: [PATCH 18/20] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Fri, 28 Jun 2024 11:11:33 +0800
Message-ID: <20240628031138.429622-19-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
References: <20240628031138.429622-1-alexs@kernel.org>
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
index 17941774c46e..c6a44fe04f97 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -102,6 +102,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index 3ce49f0372cc..abecc8a5c566 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -848,7 +848,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.43.0


