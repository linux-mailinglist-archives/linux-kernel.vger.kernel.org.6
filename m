Return-Path: <linux-kernel+bounces-545619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD34A4EF53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A68D3A95FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF1278164;
	Tue,  4 Mar 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqIpFa+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E1278140;
	Tue,  4 Mar 2025 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123160; cv=none; b=gc2CelzWNRoyHBptfeiPmDf57wn754G/y/eoYfmheApTIPt4aSMCHz+Ucy6Q58MLRdP04kM1qUuSqoXvPeeL5GyrugqrH/2fXwJBQCt7C+6BnMJDKKMOGdOzafi1USnfjSbKvwMTcvFyECPbvtDlOXndVULUrx7UfMKQUHQXrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123160; c=relaxed/simple;
	bh=6FhMRhtfgS5z0o99EQbkeXHgbive43ppIa5gFAsIPKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qq4AiIQW4OZ0AwTVBntELEX9/N5WHf0O0wKnRdHYsN428musZGaH5Ykw3KEVdBKDAA1ba3clRVjjqF882/0iVu52zcfoqIgL4Yrnz2LlAvaW5doQIaRciOyKeB7fJJbTwOlSwqCwJNVzGfyp+v5gTYnzIxkyBTZuKQztBopZTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqIpFa+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FFDC4CEE9;
	Tue,  4 Mar 2025 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123160;
	bh=6FhMRhtfgS5z0o99EQbkeXHgbive43ppIa5gFAsIPKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqIpFa+RIbg45l+WZVNN2pvsN+N5xKLHk5pBg7HNxx8Wvqj9os5jidvQxjr4C3W6Q
	 ElW6wzf8gv1cRgPliHbzAOgnLGmcH22Vti65265Vg7KAv9gHbwljGws8BvO/VXgkZn
	 H74aAIRPmZ7kB2KeuYKh/VnuA+a5bhiOVB4csn2fLiQy3U1RHvK3HAV2LTKZ0NJCAp
	 sbd4TGUdFyvyRqtuzqIhLTamE5avcohCCPPHljPBBvs0G3gxuDtnfBgDzS1uGOOdcx
	 hNpMjlC84+/rIkSjrxxDZFokHNm/r1dhCbW/h5aDQ9rtkKxMzQ+6XV4APWaA/qOA2N
	 dRmILrEr8vJRg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/9] mm/damon/core: support committing ops_filters
Date: Tue,  4 Mar 2025 13:19:07 -0800
Message-Id: <20250304211913.53574-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON kernel API callers should use damon_commit_ctx() to install DAMON
parameters including DAMOS filters.  But damos_commit_ops_filters(),
which is called by damon_commit_ctx() for filters installing, is not
handling damos->ops_filters.  Hence, no DAMON kernel API caller can use
damos->ops_filters.  Do the committing of the ops_filters to make it
usable.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5415b7603d01..1daccccb5d67 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -820,7 +820,7 @@ static void damos_commit_filter(
 	damos_commit_filter_arg(dst, src);
 }
 
-static int damos_commit_filters(struct damos *dst, struct damos *src)
+static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
 	int i = 0, j = 0;
@@ -848,6 +848,44 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 	return 0;
 }
 
+static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
+{
+	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
+	int i = 0, j = 0;
+
+	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
+		src_filter = damos_nth_filter(i++, src);
+		if (src_filter)
+			damos_commit_filter(dst_filter, src_filter);
+		else
+			damos_destroy_filter(dst_filter);
+	}
+
+	damos_for_each_ops_filter_safe(src_filter, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_filter = damos_new_filter(
+				src_filter->type, src_filter->matching,
+				src_filter->allow);
+		if (!new_filter)
+			return -ENOMEM;
+		damos_commit_filter_arg(new_filter, src_filter);
+		damos_add_filter(dst, new_filter);
+	}
+	return 0;
+}
+
+static int damos_commit_filters(struct damos *dst, struct damos *src)
+{
+	int err;
+
+	err = damos_commit_core_filters(dst, src);
+	if (err)
+		return err;
+	return damos_commit_ops_filters(dst, src);
+}
+
 static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 {
 	struct damos *s;
-- 
2.39.5

