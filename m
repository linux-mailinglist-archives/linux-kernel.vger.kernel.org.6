Return-Path: <linux-kernel+bounces-558128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48EAA5E201
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4992516A602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6324E002;
	Wed, 12 Mar 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/vD7NQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D5247DE1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798078; cv=none; b=uzTwTWFGUmUqbEU3oYgr3B3gHv914G6kmmVRrjZ4c1neti8PY05NA/fVJKUf0P8l6ONKRd/5OOZANNQPtHSxDK/trrNqymdUaBQBtxXbS4F6vo3Byma9LJUoaS0W07sQCxJR8l58ag0/i6tmn2+AXxKuPnQ1VdiynXZu7z3jH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798078; c=relaxed/simple;
	bh=H37g5zw8JYgcEHcrKgCoScNGY44vZwcAGnWDri47ll4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVTU9SzSBeijgGnNj8ovHCOZ+CfUqzwcg7j/9FSeU2fO/z8WJ5QyR0pXB2eVy5PkUK32/f8IGfyeyiADL3B8tJdpz2jenVHQNid+LhUI73rfFruaRVYB2AzfpJ/2vZnEy40JHvI/UwUirq2nGlNu+JRhTBQAqStzuIAzjJDKHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/vD7NQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6438C4CEEB;
	Wed, 12 Mar 2025 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798077;
	bh=H37g5zw8JYgcEHcrKgCoScNGY44vZwcAGnWDri47ll4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/vD7NQyc6drg6smFF+csAqealwJ9oeCp8RBZuR7gdkEm6tK8IQ8s+pJIAND/ar6p
	 PquW8UddAL7JN0XDsZH2HFLFMoWo5r/oN9cBCPfkqxvHvnJ/p0wIDGaGdOJe07CTx1
	 orgRMFPr3iwNZd5q7gV5/8pbAVbEctxUSp9NL5rEYQ2t+vvW+7l2FiISNCaI93IeMs
	 rkiorPIVaI6S3a4TTdptzn+1628Vb6MN3dcPlLLZs06TYjWBWAA0BinMGzNouXH9+o
	 /b3FAzYkUDGMgRdI9BPGPkhIacekGiex1o5ZMjQ/Usfed89xuQkdZf/84b7KCgqQlR
	 d2+OCfyvW+pnQ==
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
Subject: [PATCH 2/4] mm/madvise: split out populate behavior check logic
Date: Wed, 12 Mar 2025 09:47:48 -0700
Message-Id: <20250312164750.59215-3-sj@kernel.org>
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

madvise_do_behavior() has a long open-coded 'behavior' check for
MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
code arguably take longer time to read.  Like is_memory_failure(), split
out the check to a separate function.  This is not technically removing
the additional layer but discourage further extending the switch-case.
Also it makes madvise_do_behavior() code shorter and therefore easier to
read.

[1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c3ab1f283b18..611db868ae38 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1640,6 +1640,17 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
 	return true;
 }
 
+static bool is_madvise_populate(int behavior)
+{
+	switch (behavior) {
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int madvise_do_behavior(struct mm_struct *mm,
 		unsigned long start, size_t len_in, size_t len, int behavior)
 {
@@ -1653,16 +1664,11 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	end = start + len;
 
 	blk_start_plug(&plug);
-	switch (behavior) {
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
+	if (is_madvise_populate(behavior))
 		error = madvise_populate(mm, start, end, behavior);
-		break;
-	default:
+	else
 		error = madvise_walk_vmas(mm, start, end, behavior,
 					  madvise_vma_behavior);
-		break;
-	}
 	blk_finish_plug(&plug);
 	return error;
 }
-- 
2.39.5

