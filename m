Return-Path: <linux-kernel+bounces-547452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC90A5095D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C8916DA06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC425333D;
	Wed,  5 Mar 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+BXnAC1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BD25291E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198582; cv=none; b=m+VNRCYf3gFvj9n8uHfpArB4Ce3nZ2FpUCFekffOOxeE1lL+rDBLgKIgQhnLQInBTn4N5wLbbL48pjNuQw5EHPfIsFEGgyW0c5UESBn3tz69NFQKaRmzp2mseTCzpDTqMkXF1b9Q7/O5wV+EQSI4F+4BwVwL7b80o28aClrNKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198582; c=relaxed/simple;
	bh=k3u/LxEMkFkS7mrfeSjLL0Nnr2JwC5q9oxYyj2TJeAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qt68Ix/Jb1zX5IsPeAWOCEgDOiO9eoI4dUD9lOVzmC5QJomX0InUfaXXTZhuMGYrM3mtD5eGgdsXN3V8ulFBKsJVlvivhemkPAi7LsHd1FoiUmPF19rQvpPcBPKGzSu7hMbZ1lzO7wf3935K56PsHO5ovHhzNDwQ0eT4TT5Po9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+BXnAC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39959C4CEF2;
	Wed,  5 Mar 2025 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198582;
	bh=k3u/LxEMkFkS7mrfeSjLL0Nnr2JwC5q9oxYyj2TJeAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+BXnAC1TkoainkqZ1u199F1FvvZiZ34Ndk/rNCx/M/1t+E94AGj5Quk5hqfuBfOR
	 M1YClyfRGCUP1WoVAujO8KEYZPzAM5nyE+V9w6X04oqWzXMx1S63w8kjugzVIQPUqT
	 vyzywq6x4ps9bDMoX5nQ0n4xouj/atCwPePYKOQDZ9OKJUcyAhG1rAbQvIxrVUDWuc
	 fUV1pP5jvKW6nsjwv7a+fJk5BM7bKW+1NdufBwSEcLDO2AH5PRhrJ8rKbQOMJzAtor
	 VkesKLWj63wstq8GYdHeUtU7YoUmatCsQXyNU7EPPvlIriyjFwml6cKma9iQLIPNg/
	 DVjdb/F+G4fYA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/16] mm/madvise: split out populate behavior check logic
Date: Wed,  5 Mar 2025 10:15:57 -0800
Message-Id: <20250305181611.54484-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
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
index dbc8fec05cc6..4a91590656dc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1633,6 +1633,17 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
 	return true;
 }
 
+static bool is_memory_populate(int behavior)
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
@@ -1646,16 +1657,11 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	end = start + len;
 
 	blk_start_plug(&plug);
-	switch (behavior) {
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
+	if (is_memory_populate(behavior))
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

