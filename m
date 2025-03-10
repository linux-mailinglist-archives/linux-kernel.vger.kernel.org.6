Return-Path: <linux-kernel+bounces-554789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD7A59DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB7316EE32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027F233145;
	Mon, 10 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLodKnMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69051232363
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627406; cv=none; b=kM2JzJAU6WLi7qozuoWE0xztSedKP9KcyV2DBHOr6/gBgSMpZjygV/C1BtdqVCmoTvi8dhZxxR96NdP1AsXzSzhpz/X8EpM750K9gvkDjP7qGeFTICPiRRceineMEMy+wuVxswFmpSKzdnQ8Ic1twmoWVjywTc4KkBHIJEZIrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627406; c=relaxed/simple;
	bh=M9/wAyNFr4MzyO45yCxu/y9IRXgOWJVU4DhwCYnIYO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkknpryWo0jP4p0S29Xo+bbCYjC+cQhYXmps/gbRFodIE8JxoeWGLmyAtIO4a9EwEuIOJMFzzZjEonWJldYpJ7WdRSKOg3jZHla/0c3jy2sdFTfH+q6JdUgcXLdXXykBot4uRwZoA/S157ZkcF9wphIpsRJ0elCYJIAO5076D+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLodKnMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15460C4CEE5;
	Mon, 10 Mar 2025 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627406;
	bh=M9/wAyNFr4MzyO45yCxu/y9IRXgOWJVU4DhwCYnIYO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLodKnMGunZymOsXhiHwJL3CZN56ph7GyHUBQSnqvbfDZM4FdddyE6UwjyywHRHS1
	 cQupnW2BYiokTpHo7gTlm1+TlGjayuwf2a+xu80NDLVwzT7QoRMat5a/pBCcLPviUG
	 I2u/9J8exOAV+qOehvNS3kdd/WwNK1e2uTbFksC+1ZA2Dd+i1z2axiZf4RF4O72SYs
	 rRuDT2HOdcp+kQiTqlDhnnFIhMVXzyLGCSCcIu6/KGDv+TdsZi4dur6hETHZOeiWVw
	 q0K7MtgfIqjtRTafPny8uDtlEfc/dSMYN9Pd++aK1UcAwdsXxrPKtRSMlm5C0KuB18
	 Lwmc/eOHDhANA==
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
Subject: [PATCH 2/9] mm/madvise: split out populate behavior check logic
Date: Mon, 10 Mar 2025 10:23:11 -0700
Message-Id: <20250310172318.653630-3-sj@kernel.org>
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

madvise_do_behavior() has a long open-coded 'behavior' check for
MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
code arguably take longer time to read.  Like is_memory_failure(), split
out the check to a separate function.  This is not technically removing
the additional layer but discourage further extending the switch-case.
Also it makes madvise_do_behavior() code shorter and therefore easier to
read.

[1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local

Signed-off-by: SeongJae Park <sj@kernel.org>
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

