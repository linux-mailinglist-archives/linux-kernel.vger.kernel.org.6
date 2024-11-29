Return-Path: <linux-kernel+bounces-423952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0B9DAEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F277B2185E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83E202F8B;
	Wed, 27 Nov 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arx1PFHc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B019885D;
	Wed, 27 Nov 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740989; cv=none; b=tlbUPZwAdVRlubdYZawTuD4gjrSwrdxwAjWyNl3lSlGAWEqPv5EOP2UO/eDeR2lq0VagOYWKV8fzJKRRy9E9AbK4BeHXcLqVo/IQyyGMy4ZAKztd7hSNz0GsrSL9ttEM/uodZhA6u9rUubUbDlsiHpxDC2Nn8dBzKCms4yiRqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740989; c=relaxed/simple;
	bh=IsY1p9peZtsuSZmN1lXqkSi2g3xTHsQCxshSsJgZG1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XoKi91oLJA7J6g/N9R6W/5z6b9YTi1za+47tDHF68gRSNLJSm8TSm1obtkd0aXqx3oRvjhIeldVfXmYjJeWVV+oGQTSETHLyVYxzQZUQjYy+lJExMzuM/hyQ954kr3gpsAmp0lHj1BsnOQZ0TWIWryMEgo03j76f2znG4DN/8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arx1PFHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C93C4CECC;
	Wed, 27 Nov 2024 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732740989;
	bh=IsY1p9peZtsuSZmN1lXqkSi2g3xTHsQCxshSsJgZG1w=;
	h=From:To:Cc:Subject:Date:From;
	b=Arx1PFHcSj+PqFbPWIkBHIkiHMkmNsiA+gH8W9NoTAtXL+V6o6tCrs43pca8YTKVc
	 +66/1vUHZ1Dbvgj0UI+AhKnRrIWAtIse6PFMPQP1aDl9YMzgaTz2XKfkg+164BzAni
	 1v+nnYBIWCMmVETcLBfMGUMYrwW0kr4MmUelngWRtWGthYwSpIBBMwpcmsp0fcDxUF
	 nMbEIav25ZUiVxMoZXL3lzwJbzMLPKkC5AsynbEyQmcggMs5z8t/EveVV7IeKhEYb1
	 yfh5RDiRXz8XszRjbf46JcNSA9QsCJFG1nOdNIQbZzzwUbr00MZM5skJvSJ5BEsGM0
	 KYlB5qrlsma6A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon: introduce DAMOS filter type UNMAPPED
Date: Wed, 27 Nov 2024 12:56:24 -0800
Message-Id: <20241127205624.86986-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMOS actions may better to be applied to only mapped, or unmapped
pages.  For example, users might want to use NUMA hint fault based
CXL-memory promotion for mapped pages, and DAMOS-based promotion for
unmapped pages.  For another example, users might want to proactively
reclaim only unmapped page cache, since some people do mmap() for only
performance-important files, to reduce read()/write() system call
overheads.  To support such use cases, introduce a new DAMOS filter type
for unmapped pages.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
It is unclear if the example usages are realistic, and how much benefit
this idea will provide for the example usages.  This is for showing only
more specific shape of the idea, and hence RFC.  No test other than
build on my machine has run.

 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9d8bb6116df4..10fc6df52111 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -315,6 +315,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
+ * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -334,6 +335,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
+	DAMOS_FILTER_TYPE_UNMAPPED,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4733aaddcae8..b3cb2578a201 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -222,6 +222,9 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 		if (matched)
 			damon_folio_mkold(folio);
 		break;
+	case DAMOS_FILTER_TYPE_UNMAPPED:
+		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6cc976b8e363..25356fe99273 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -345,6 +345,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"young",
+	"unmapped",
 	"addr",
 	"target",
 };
-- 
2.39.5


