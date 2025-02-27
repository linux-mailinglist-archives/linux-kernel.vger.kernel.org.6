Return-Path: <linux-kernel+bounces-535385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E3A471DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA573AD0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E241922D4;
	Thu, 27 Feb 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjWj45f8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162A18B495;
	Thu, 27 Feb 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621490; cv=none; b=J7QcLfMZconKtGgaZzJhmCQritHbdqST5ZIaQTE3JPE289G9ZzJR1tbyEmYOS8NoB9qsHL0cqa//EeS2pD1KMacP+mzMXObTle7q+bRKIeQsExlRDBWgC1FuWV1RQeMoZALdDP8HwFdTpYMipozv0UIMWN067vAwq4gjMk2+tAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621490; c=relaxed/simple;
	bh=o7Tb1fqSTBTcTFBCmPVioCKVuRP26jC84n9gdZN/Nso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rmq/SEGtJHccUMnwFOqAJgDAmIp8RrjYb4iCJ1bqDVRdNfwoBj17iV/eJVYsIhXrrDgZJJ36zGwSr0yRv+pb9od3mMMpjr+AoqEecpW5a/sFVF0rHvq3+S6E7xMPLTz7Tnk682Xg7LUPw0j8nZx/kcmNECIcx1bJPgqns4kuguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjWj45f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C248FC4CED6;
	Thu, 27 Feb 2025 01:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621489;
	bh=o7Tb1fqSTBTcTFBCmPVioCKVuRP26jC84n9gdZN/Nso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjWj45f8qr9qybW6WhIY7KWi/G9KlZfLpHRUkMdyTAbkuEei4cWOQ3htE9tfpt9yM
	 La6TSblyuWFzAtcsqfzTo//ggqbrT3jquB0NjWz35ZhFhKRT+fcmhqDlWyO44XmENh
	 1c20ENmIjra3EJ2LCQ7QJheQo8AylmISq4gXx95fJ4NrieksEzbjyuVUQBRp2zClyZ
	 NN/uFghaiRogYtUyrVFzf2AtQKC6tI3kqCXvTa7aNoUKF0pmVRiWz/kzD3wmIj2igS
	 yJvd3XrlexS0UxTYRE2f/3aI4wfT16zwn3fCurB10mcV4wYOpSHMMLFoUkHTaknxgc
	 5B7O5uX1B4r9Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Wed, 26 Feb 2025 17:57:52 -0800
Message-Id: <20250227015754.38789-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decide whether to allow or reject by default on core and opertions layer
handled filters evaluation stages.  It is decided as the opposite of the
last installed filter's behavior.  If there is no filter at all, allow
by default.  If there is any operations layer handled filters, core
layer's filtering stage sets allowing as the default behavior regardless
of the last filter of core layer-handling ones, since the last filter of
core layer handled filters in the case is not really the last filter of
the entire filtering stage.

Also, make the core layer's DAMOS filters handling stage uses the newly
set behavior field.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 78126a5145fd..8661f64ab1b4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -864,6 +864,32 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	return 0;
 }
 
+/**
+ * damos_filters_default_reject() - decide whether to reject memory that didn't
+ *				    match with any given filter.
+ * @filters:	Given DAMOS filters of a group.
+ */
+static bool damos_filters_default_reject(struct list_head *filters)
+{
+	struct damos_filter *last_filter;
+
+	if (list_empty(filters))
+		return false;
+	last_filter = list_last_entry(filters, struct damos_filter, list);
+	return last_filter->allow;
+}
+
+static void damos_set_filters_default_reject(struct damos *s)
+{
+	if (!list_empty(&s->ops_filters))
+		s->core_filters_default_reject = false;
+	else
+		s->core_filters_default_reject =
+			damos_filters_default_reject(&s->filters);
+	s->ops_filters_default_reject =
+		damos_filters_default_reject(&s->ops_filters);
+}
+
 static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
@@ -871,7 +897,11 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 	err = damos_commit_core_filters(dst, src);
 	if (err)
 		return err;
-	return damos_commit_ops_filters(dst, src);
+	err = damos_commit_ops_filters(dst, src);
+	if (err)
+		return err;
+	damos_set_filters_default_reject(dst);
+	return 0;
 }
 
 static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
@@ -1490,7 +1520,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		if (damos_filter_match(ctx, t, r, filter))
 			return !filter->allow;
 	}
-	return false;
+	return s->core_filters_default_reject;
 }
 
 /*
-- 
2.39.5

