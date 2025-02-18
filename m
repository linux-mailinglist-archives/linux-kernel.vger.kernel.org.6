Return-Path: <linux-kernel+bounces-520586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CBEA3ABCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2C17181D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD71DDC11;
	Tue, 18 Feb 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuI8Tq0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93F1DC9AB;
	Tue, 18 Feb 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918238; cv=none; b=P/JpMn/j6mcWy7XFLXzBGTk6jWYWo+1cvj5Hap5eNGWldAzTLjZJcFk8+mqdSl5zj/HkdPjrURLPCdD6AjheAxfp+/eaG+Er/kUz8ZsOtmoPyHkZ0f9op5SDnWp5Y6otcvz1DUmg+JJktKkI6Jh+PvoZZQp/DupLMSKVXNvTfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918238; c=relaxed/simple;
	bh=OOoII5/zyMHQ8WDLAouq/qJ5GMbnfrXAVmpEUBHSZpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYYrKxF4gYnzCrb6rA97max69Y91qJ3vfA8YU8eH7gdLjsxlT/LQOl/566NWpHtLo4rxuh35qZbOXI2bO74Q6aYS4Q85K2mOvIFO/B021MX7gMfYjEjJhKtfBo4XHbbLrcNqNI92aGu5h6v1iJY26Joi4huwWeN0pjSMRonHUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuI8Tq0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB00BC4CEE2;
	Tue, 18 Feb 2025 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918238;
	bh=OOoII5/zyMHQ8WDLAouq/qJ5GMbnfrXAVmpEUBHSZpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuI8Tq0ba4foWWD4lvXl4DYdj4Krxz2z/eD4csGR4OWL6PUQWFY5sHuYZM1mu8OAZ
	 uVtiaEI4a81O91DCCHk24hMhtS5SwGzxHgfkMAKa1PkPkCPjeajTIVUuQ1BfkJdx4f
	 gCpm3Lv3Zd1Ma2xHWptxpTpftBGLzJbT+SW7AGXoKTgyxr9uAm0rmzv4KXAToX6LMN
	 OX2CLPygyF01mp3R/MAIxD83zI3dCeVG6vGvKPgWUpn15+2IuBk9vkwtmmxBhA5TiW
	 rEj6XaSC5JH1+xpegU2aIofXYTsQyRkCvNXLRTtsqg0VPzQVS0AHzdQE4zrFXzeHc7
	 0UgHS6oLynQCQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] Docs/damon: move DAMOS filter type names and meaning to design doc
Date: Tue, 18 Feb 2025 14:37:06 -0800
Message-Id: <20250218223708.53437-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218223708.53437-1-sj@kernel.org>
References: <20250218223708.53437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs usage doc is describing DAMOS filter type names and their
meanings in short.  The design doc is providing the short meaning and
detailed descriptions, too.  This is unnecessary duplicates and confuses
where to document new DAMOS filter types and features.  Move the details
from usage to design doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 28 +++++++++-----------
 Documentation/mm/damon/design.rst            | 12 ++++-----
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 51af66c208c5..dc37bba96273 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -408,21 +408,19 @@ in the numeric order.
 
 Each filter directory contains nine files, namely ``type``, ``matching``,
 ``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
-and ``target_idx``.  To ``type`` file, you can write one of six special
-keywords: ``anon`` for anonymous pages, ``memcg`` for specific memory cgroup,
-``young`` for young pages, ``addr`` for specific address range (an open-ended
-interval), ``hugepage_size`` for large folios of a specific size range [``min``,
-``max``] or ``target`` for specific DAMON monitoring target filtering.  Meaning
-of the types are same to the description on the :ref:`design doc
-<damon_design_damos_filters>`.
-
-In case of the memory cgroup filtering, you can specify the memory cgroup of
-the interest by writing the path of the memory cgroup from the cgroups mount
-point to ``memcg_path`` file.  In case of the address range filtering, you can
-specify the start and end address of the range to ``addr_start`` and
-``addr_end`` files, respectively.  For the DAMON monitoring target filtering,
-you can specify the index of the target between the list of the DAMON context's
-monitoring targets list to ``target_idx`` file.
+and ``target_idx``.  To ``type`` file, you can write the type of the filter.
+Refer to :ref:`the design doc <damon_design_damos_filters>` for available type
+names and their meanings.
+
+For ``memcg`` type, you can specify the memory cgroup of the interest by
+writing the path of the memory cgroup from the cgroups mount point to
+``memcg_path`` file.  For ``addr`` type, you can specify the start and end
+address of the range (open-ended interval) to ``addr_start`` and ``addr_end``
+files, respectively.  For ``hugepage_size`` type, you can specify the minimum
+and maximum size of the range (closed interval) to ``min`` and ``max`` files,
+respectively.  For ``target`` type, you can specify the index of the target
+between the list of the DAMON context's monitoring targets list to
+``target_idx`` file.
 
 You can write ``Y`` or ``N`` to ``matching`` file to specify whether the filter
 is for memory that matches the ``type``.  You can write ``Y`` or ``N`` to
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a959c081bc59..7360e5ac0d06 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -600,23 +600,23 @@ counted as the scheme has tried.  This difference affects the statistics.
 
 Below ``type`` of filters are currently supported.
 
-- anonymous page
+- anon
     - Applied to pages that containing data that not stored in files.
     - Handled by operations set layer.  Supported by only ``paddr`` set.
-- memory cgroup
+- memcg
     - Applied to pages that belonging to a given cgroup.
     - Handled by operations set layer.  Supported by only ``paddr`` set.
-- young page
+- young
     - Applied to pages that are accessed after the last access check from the
       scheme.
     - Handled by operations set layer.  Supported by only ``paddr`` set.
-- pages that managed in a given size range
+- hugepage_size
     - Applied to pages that managed in a given size range.
     - Handled by operations set layer.  Supported by only ``paddr`` set.
-- address range
+- addr
     - Applied to pages that belonging to a given address range.
     - Handled by the core logic.
-- DAMON monitoring target
+- target
     - Applied to pages that belonging to a given DAMON monitoring target.
     - Handled by the core logic.
 
-- 
2.39.5

