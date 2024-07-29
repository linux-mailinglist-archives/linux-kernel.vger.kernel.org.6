Return-Path: <linux-kernel+bounces-265637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541393F3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DFE1F226A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E015530B;
	Mon, 29 Jul 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp7crNGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA32145B37
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252076; cv=none; b=rT0yNRHMzDvy+Onnk4DNHhNf/1ClD9c/SOVb5ImPBB6X3wFhMWELeVcsuTCd5NtdVAbIY4Z5gyXnWvTLcVqldP+BMKI1bJT3dTG/6g8YOrNObVUHEyJLy2p6eELHZhK6rsdIrNgQM/q1y5kr4DeUwTnJ9qrx7ksG0KCPKuv9htY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252076; c=relaxed/simple;
	bh=WC1zVtU8HoKTgwyGG1oBnxz/TQGKFBik73v06jNNZ/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDFmxIhaycwmSxCkmwXbLDuIAbODdz9rJUR8NuAIsuGCJ9L3Bcj83wEjPpTgClvKd23zq+gwGUnafqWvcx8NVKf4GAhjO1eJdgVZrHeCoDN42Q24c6iNK0JSgPViFZG35fdukXUEyE5290ktGq971EygEmpcwKKpVk4iqx+g0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp7crNGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF10C32786;
	Mon, 29 Jul 2024 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252076;
	bh=WC1zVtU8HoKTgwyGG1oBnxz/TQGKFBik73v06jNNZ/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zp7crNGGj8tFuQ+KKFsA4x+ASc1R4kKGuxUypiz+7x5QReIhm0x2m4fG7Jjw/wU+2
	 8asbu0zMOQYtzwO97Hj1gyyuvmxrSeh3uHcz1xtom7DMR1m4wA6K2gKnUWMi44cLC9
	 4RsUSKHEarV7mkuTqCVzvlvPMh9hpvgdyVTqCbqSIzcbTBHmMMk83DNuMPyA1s37Yw
	 HgeUQ654r3M6IAG2fRbj+a5gogYPOcjTax9pkat/I3+H6NocMAmoG8dLxWd6Ke1Fmd
	 TAyY1llDoLoeJjnLyQASqhE6ahUVKMGbJsipzXyx5hy5YgFAomQu8YaHzpo3BHs5Rz
	 8/Ugyd+q+VGcA==
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
Subject: [PATCH v4 18/22] mm/zsmalloc: introduce __zpdesc_clear_movable
Date: Mon, 29 Jul 2024 19:25:30 +0800
Message-ID: <20240729112534.3416707-19-alexs@kernel.org>
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

Add a helper __zpdesc_clear_movable() for __ClearPageMovable(), and use it
in callers to make code clear.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zpdesc.h   | 5 +++++
 mm/zsmalloc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index f64e813f4847..5db4fbe2d139 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -114,6 +114,11 @@ static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
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
index bb8b5f13a966..e1d3ad50538c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -846,7 +846,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
+	__zpdesc_clear_movable(zpdesc);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-- 
2.43.0


