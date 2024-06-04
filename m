Return-Path: <linux-kernel+bounces-200006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2088FA91F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4935CB24B33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433913DDD5;
	Tue,  4 Jun 2024 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs1MCtQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5D13DDB8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474898; cv=none; b=UaJ0kHAVA0XxIpFRxlnOPCElApdEDz8qmfuzxsty1zq2oII9lbGSUKD4DEWz/OtLfLk/oB9ZpCIpTmyB1Bh+mpalZwvaEL/eDhfGUYxcrxivPEcQFjC8N6JdPVuc5n3z07dx411XETPfI+8tjMpIcgwqKr/6RoXbOhMM/up0bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474898; c=relaxed/simple;
	bh=P0itGeZCXEfvARIWHRoE92wg+ZB0+ncoLLqA7cA6dRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWtsHRRUSQ7ptpGzii289x9xrBgahV25k9JkbMVQedlZHwVCt1vT9lnB4pTNlxuhvdwqxLGaJM2ysU7oiV9dGsFZjR/jK2h9c+AiHVt5kZwXuGXybbEfZZLgCyDvptJ7aHTJ1OUMMF+lT1Za6cGsVnzzqSxOShmKZcfy+GWjwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs1MCtQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F92C4AF0A;
	Tue,  4 Jun 2024 04:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474898;
	bh=P0itGeZCXEfvARIWHRoE92wg+ZB0+ncoLLqA7cA6dRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cs1MCtQ5uXJAEfguDsl9n6PCoX3lPNYo1TZbsFptY7tRN/JeBiGX7aLwjXVkjEjP6
	 gzJtAWsoo23HZ4+Xwld8DivVjPrM/axC3AWBXBgFbVhFye8646fQl0FEVCgnus7ErB
	 +xhs2Tfn2Qkp41rTdPVsTbIPRBi9scA3yz80vVEF60NFVyYUYLBqx+ldEpKMUtAznx
	 QkC9gXYgaUuhdCohrrJoGYJs4e1pF7R0beiZ+UQ+PqqbfZ8KpYJG13ms3sw4fzDZqf
	 x+9aM6ykvs/PQUHdUrVeSR+BU7KapA9qAI2obkv+dWjpqjmNZ7trkgxufE2OkJYsC+
	 SdXnLZW54tSSw==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 02/10] mm/ksm: skip subpages of compound pages
Date: Tue,  4 Jun 2024 12:24:44 +0800
Message-ID: <20240604042454.2012091-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

When a folio isn't fit for KSM, the subpages are unlikely to be good,
So let's skip the rest page checking to save some actions.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 97e5b41f8c4b..e2fdb9dd98e2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2644,6 +2644,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		goto no_vmas;
 
 	for_each_vma(vmi, vma) {
+		int nr = 1;
+
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2660,6 +2662,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 				cond_resched();
 				continue;
 			}
+
+			VM_WARN_ON(PageTail(*page));
+			nr = compound_nr(*page);
 			if (is_zone_device_page(*page))
 				goto next_page;
 			if (PageAnon(*page)) {
@@ -2672,7 +2677,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 					if (should_skip_rmap_item(*page, rmap_item))
 						goto next_page;
 
-					ksm_scan.address += PAGE_SIZE;
+					ksm_scan.address += nr * PAGE_SIZE;
 				} else
 					put_page(*page);
 				mmap_read_unlock(mm);
@@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			}
 next_page:
 			put_page(*page);
-			ksm_scan.address += PAGE_SIZE;
+			ksm_scan.address += nr * PAGE_SIZE;
 			cond_resched();
 		}
 	}
-- 
2.43.0


