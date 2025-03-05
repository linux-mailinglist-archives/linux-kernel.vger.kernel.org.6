Return-Path: <linux-kernel+bounces-547463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4029A5096A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006B23ABEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC799256C9A;
	Wed,  5 Mar 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7zx6935"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39B256C61
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198595; cv=none; b=JpZwCXMSV/d+8sTS/ZC3gX8rak5zx5dO5qoUb/lhchsFNxZe/2Abk/UPto48taFz27zYGOcehNYrwTqy+wIsnDS3FTt8Bmykb6/lIMu+yh2J+4+dUoyDQ7LMQqn93Rsv1GhNiAGIzxgpsYWvIAUvPm4aDnzKCFnHhpX/nGXQhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198595; c=relaxed/simple;
	bh=8avla5b+KxmfOJySvGj+DodzRtTHcPd16UXdPAbl5pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jC3SSZptJ7helnKHZQmJvUP2iTc1pH+NUafbRAj30GlfVmWziAEWREDQdcrCCTb/4iQNJ1hbIXMlQm9UcrJbvoJ5pkN/l3FrevZM0jBRvmnouNqbPrv0x3MX3qXY2uHpPyOw6yyze4NQG6PJCZmc3sgcRNubvTB+1hhNtoFjNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7zx6935; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FF4C4CED1;
	Wed,  5 Mar 2025 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198595;
	bh=8avla5b+KxmfOJySvGj+DodzRtTHcPd16UXdPAbl5pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7zx6935Lw/ggyahtkH9JuxQGHB7OziMFhKqYpIdYXK1AwF99oacmfuhm/HCW2zjq
	 nMEFh3WjAxFhwaYN+/wR5UnDYbecUDIesx1CWpuYZRcbSNb7C9lZn5+OSoSL+WSxcX
	 emekqO9bfmC/noXO7JmQTP8vEA5gwJWhac81xKU5Q6fnF+k1zykuU24bqfpptTmDJR
	 tYUlA/oEk909vsO7NSImsB/xMvg7XIFT7l+1oQ3sLz9m/YnTeUHYYnHoX6zzrdC9kW
	 SpBemJEY0tvPtLU55sGAYCm3ZMs8jVNAA4aZunXcGqurlEh8EElDLseZVuGQQ2WhnX
	 /pM5FE9fLjbbA==
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
Subject: [RFC PATCH 13/16] mm/madvise: batch tlb flushes for process_madvise(MADV_FREE)
Date: Wed,  5 Mar 2025 10:16:08 -0800
Message-Id: <20250305181611.54484-14-sj@kernel.org>
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

MADV_FREE internal logic can be invoked with batching tlb flushes.
Update vector_madvise(), which is called for process_madvise(), to use
that in the efficient way, by passing an mmu_gather object that it
initializes before starting the work, and flushing the tlb entries at
once after all the internal works are done.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index efa4184d6cf5..f1beadb6176a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -968,7 +968,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		return madvise_dontneed_single_vma(
 				madv_behavior->tlb, vma, start, end);
 	else if (behavior == MADV_FREE)
-		return madvise_free_single_vma(NULL, vma, start, end);
+		return madvise_free_single_vma(
+				madv_behavior->tlb, vma, start, end);
 	else
 		return -EINVAL;
 }
-- 
2.39.5

