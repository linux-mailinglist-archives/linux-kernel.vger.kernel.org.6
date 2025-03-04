Return-Path: <linux-kernel+bounces-545621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F2A4EF55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C19C7A5144
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A427BF78;
	Tue,  4 Mar 2025 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp4w0ehV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051C27934B;
	Tue,  4 Mar 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123163; cv=none; b=eu4Mw/kRuMJEHSti5q3MmcaaIC0qGCjnAkzyhnOaIDJjNffyv133KVMXp3RO5bIrZJcWX+dLL3v0vMtNCavcEf8aGJUrd2O6Hn9Qb1zFmDFq9qCNnFKUEHKHbvVEAEIa8+AgbUkK/6mdvU5CGYFgIlpu+KMNw0lPpxI+i+CRlqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123163; c=relaxed/simple;
	bh=aOvI5yHdfp5ge5+cmVoLx0OBIr3elAAL0hmqCGTPnsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tfd86ueN+cfyp7RDHhJW2jcsohWiwEEyAnjvXVuR/wsE7ljZHTlFrwRZxWrAH3JXd+nedlCM2ylmWnKnbSd4HLzOJKMoZBUrx5LETtlj5t/bvvfP8seKYtoh8iahNDX4ulTouDB6t9Q47UVrF61swGWmImF2Ea1Wu9BBqeul+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp4w0ehV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70108C4CEEE;
	Tue,  4 Mar 2025 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123162;
	bh=aOvI5yHdfp5ge5+cmVoLx0OBIr3elAAL0hmqCGTPnsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tp4w0ehVwDNHiFXxn+urIRkFgiKetm8fQ7pasLsvTZn+huWTAPjUcV5hz1WhiyAZo
	 NUhGb3SIWTnkVariAAGLwEyVR562FvrnREZf4I9P3MH29HbQmzwWimSivvIbcd/EVQ
	 MgsvWbit9dDoNIhIJcGlFKZ6afBKXslekyNdGy56yYp3ipfW3bol54BJO4IUB+Qgdr
	 D49+VRBHDBMX/nPqy2Lj9kd269zG0qDdCJZlWukC1f1FT5wN8VGz0fCWFc5+74213G
	 N+K088o+AXVIibDxfa63vZzRLL5S9IkXZiWqtuHhi6b5DEEv1q7GqQxd5On+n7AWpj
	 bkhX/rwxy7spA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/9] mm/damon/paddr: support only damos->ops_filters
Date: Tue,  4 Mar 2025 13:19:09 -0800
Message-Id: <20250304211913.53574-6-sj@kernel.org>
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

DAMON physical address space operation set implementation (paddr)
started handling both damos->filters and damos->ops_filters to avoid
breakage during the change for the ->ops_filters setup.  Now the change
is done, so paddr's support of ->filters is only a waste that can safely
be dropped.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2b1ea568a431..dded659bb110 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -256,10 +256,6 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	if (scheme->core_filters_allowed)
 		return false;
 
-	damos_for_each_filter(filter, scheme) {
-		if (damos_pa_filter_match(filter, folio))
-			return !filter->allow;
-	}
 	damos_for_each_ops_filter(filter, scheme) {
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
@@ -288,12 +284,6 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	struct folio *folio;
 
 	/* check access in page level again by default */
-	damos_for_each_filter(filter, s) {
-		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
-			install_young_filter = false;
-			break;
-		}
-	}
 	damos_for_each_ops_filter(filter, s) {
 		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
 			install_young_filter = false;
@@ -546,8 +536,6 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 {
 	struct damos_filter *f;
 
-	damos_for_each_filter(f, s)
-		return true;
 	damos_for_each_ops_filter(f, s)
 		return true;
 	return false;
-- 
2.39.5

