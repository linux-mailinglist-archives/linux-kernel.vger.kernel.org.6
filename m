Return-Path: <linux-kernel+bounces-554792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA4A59DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15559170163
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1A235354;
	Mon, 10 Mar 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GElwyusP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1192343C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627409; cv=none; b=O2hjtiSDzkl0CZIvAsoNdEBoz+HGTd4F6qC3aGFfv7/ui4bf8N5h1kch1xh1zXeRA/jr5OPd5wX07t1VK5+ynsxNthJ6qAByBTXS6t2Pc68J9YzFgWZ1/jfzkJLaYEhssomzp70/M/twryCya2qvrZIbGgNlIMq/xymIiE1NYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627409; c=relaxed/simple;
	bh=Z3sSqaG1uhkCQqbFP7NKK185LV7FFPBVBGM4l1BKW9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqgtaKHuSGpsvR+3esnN5O3u33YqFActA1xJdsuUE4RqIQ9Z8j16ihlFNif2n7idpMN2dAtWaKFa5wO83oWgcsP5EGSCTs7efl7z+BZCi8TwDP/EVx7sPQPTIb6ARKll+/dkjt7DRh1x8jB+hWd/cToPg2lB96vj8cAkD6jfIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GElwyusP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6388BC4CEEC;
	Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627408;
	bh=Z3sSqaG1uhkCQqbFP7NKK185LV7FFPBVBGM4l1BKW9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GElwyusP/WtY+XI/onO9LKP/4XGLXdBGbtjzZdwAGOE+F2xfTt6R/VDsNLdlx+0oZ
	 BBKfLvM7iAu/KTC55Szh02Mfi4ajdSBhMaMRPxk7Dju5LCrOFP4yvqRnEraUQNijrT
	 85tjmyujh2l7Yj4mEk5zlXDgXBw3pseUyDEbTrDQ7NCSP0ohbe/IpYetUZD5quIBFk
	 WRytS3AOLmgHHaThSSqghYVqfm03VCfkdjN9OGQZ0M63Ipvt6NLtyTfhQNsTGzenTU
	 eASBFEQCg+i6eFPetX/VEhwS5Qx/W4Quts1/SEA7O6vOaH/e+/YIqOC6CeMogn+Gmz
	 0+QB8QKk5/H8Q==
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
Subject: [PATCH 4/9] mm/madvise: remove len parameter of madvise_do_behavior()
Date: Mon, 10 Mar 2025 10:23:13 -0700
Message-Id: <20250310172318.653630-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310172318.653630-1-sj@kernel.org>
References: <20250310172318.653630-1-sj@kernel.org>
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
---
 mm/madvise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 764ec1f2475b..469c25690a0e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1673,7 +1673,7 @@ static bool is_madvise_populate(int behavior)
 }
 
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, size_t len, int behavior)
+		unsigned long start, size_t len_in, int behavior)
 {
 	struct blk_plug plug;
 	unsigned long end;
@@ -1682,7 +1682,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_failure(behavior))
 		return madvise_inject_error(behavior, start, start + len_in);
 	start = untagged_addr_remote(mm, start);
-	end = start + len;
+	end = start + PAGE_ALIGN(len_in);
 
 	blk_start_plug(&plug);
 	if (is_madvise_populate(behavior))
@@ -1775,8 +1775,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
-			behavior);
+	error = madvise_do_behavior(mm, start, len_in, behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1808,8 +1807,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
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

