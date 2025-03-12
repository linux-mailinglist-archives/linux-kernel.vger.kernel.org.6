Return-Path: <linux-kernel+bounces-558130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28222A5E203
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F11E178C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5687256C6A;
	Wed, 12 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny47xZvm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF7255E23
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798080; cv=none; b=hgfjObVYrjBDQX6YHm+SsJRDEongO7y054RAuJYtEoQb+ACIuaUWmqINOGjF3BNMKd8kz6Gui0pbOgPInGVhnGkQx85eq6sF6pDusrkUbM9YUbnNsEwR8z7RFTyvMh9lYK8AijjuUvvYqSHorn4FmxTK/TnjBxujP40+1LsFLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798080; c=relaxed/simple;
	bh=rKIbFCwS48nnM6gxh3wFYLS526gq2KkVNyyi1h5+1tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4aMhEbJMHMwkbkPNbLiP4q4y09Ps4Hg9Jc5AHAJ0zMHXq432Ugk4wmSeF0QwAO4zDLTb14p75ZA3OydEW547bkBm1mzRC9igoI0p3Z1ovapxwIHIGLBZilTuoTBGWDwSVDrf3XV1P5x0HFdsfkOr8YVwW2uMO/1uE7FlfczmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny47xZvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44FBC4CEF0;
	Wed, 12 Mar 2025 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798080;
	bh=rKIbFCwS48nnM6gxh3wFYLS526gq2KkVNyyi1h5+1tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny47xZvmQKh38wEZdbd3uE0N8ConIG5EFPo1F10FYLNBMl2IB7y1AwcvcMRRJNiCN
	 6DsaZj+4A+UAe1nWjY/dJ0cEkcnv2ElAewCEm5yRbK0LJ43cOpTWGMc3DLvjIVuwGZ
	 C4CjRpAl0cXtZCgpM0ZJTk0XgnENCfBZNf1f08D3wl7jRV5okrmFCDVt9FKQ37CqxV
	 ie/m5SCf8rDIfPHAr2XDJ5enChHf6IQ8fy6VADpoYh7VuZWaEBgQ6LKivy8SdaDysn
	 sJU5R5O8Qm6vfYacjyZ2KlaOsDamPhHJmb2N0i+USWfjhepz+7RyyS9jm+RB1cUKl9
	 ktIavjNMuGU+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] mm/madvise: remove len parameter of madvise_do_behavior()
Date: Wed, 12 Mar 2025 09:47:50 -0700
Message-Id: <20250312164750.59215-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312164750.59215-1-sj@kernel.org>
References: <20250312164750.59215-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because madise_should_skip() logic is factored out, making
madvise_do_behavior() calculates 'len' on its own rather then receiving
it as a parameter makes code simpler.  Remove the parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ba006d05c7ea..b17f684322ad 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1677,7 +1677,7 @@ static bool is_madvise_populate(int behavior)
 }
 
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, size_t len, int behavior)
+		unsigned long start, size_t len_in, int behavior)
 {
 	struct blk_plug plug;
 	unsigned long end;
@@ -1686,7 +1686,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_failure(behavior))
 		return madvise_inject_error(behavior, start, start + len_in);
 	start = untagged_addr_remote(mm, start);
-	end = start + len;
+	end = start + PAGE_ALIGN(len_in);
 
 	blk_start_plug(&plug);
 	if (is_madvise_populate(behavior))
@@ -1779,8 +1779,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
-			behavior);
+	error = madvise_do_behavior(mm, start, len_in, behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1812,8 +1811,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (madvise_should_skip(start, len_in, behavior, &error))
 			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in,
-					PAGE_ALIGN(len_in), behavior);
+			ret = madvise_do_behavior(mm, start, len_in, behavior);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.39.5

