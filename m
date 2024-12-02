Return-Path: <linux-kernel+bounces-427553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEB9E02B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635A2284900
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A8207A1B;
	Mon,  2 Dec 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0b0rI0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4C1FECAA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144315; cv=none; b=n0shGASQ+jU8VRh/7pUDgs1EeuI/4d339BiAcJ5LXIr8M1wf6DkZHWkRK7Ot01p4V4gmCxUQgmXvH5D9P+EP9AerHFqVRcQBN/Eeh99sDYMAjQiuS+q0cuBFcbRd53PiRyMm05UMN3dwdVU4iWNaSJVPTJ6HkWpgHuSoSJwF/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144315; c=relaxed/simple;
	bh=jT///ptJ66DMYpEjj0WY1kVDZTJxuMyXcNesVqC1ljc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ5IXul66dqsiIbDxKs12orVhcPKbw5Oz9Fr+WldSnSABFbmwpePq2gJ2ONcW1OHlybks58EOErd/wrea5EaV7+lR4W+pfLGGBRGxS7OtFSesmCe7v3sB6LKiNWZRU8SaMFUtHBVeIokAv3beR74zmlzcHxtK6URoBmD29ZjJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0b0rI0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733144312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtMsmFE9pgvd9dqP+bKnl486+ttvAdvq1JTdJU/oyis=;
	b=a0b0rI0fQCs0spHgwNZ+nVP5LcUMZO+TgKljuzO2x7vWkOUeIc+49KFwb4c7Q1pShVpsH7
	+AoK76NbPlDlhIRyZFnK4+ylXRcX+U+9ZrruuJob+b7z5epd/Hj89barf0tJGEFkqHhDvT
	8IF4W8bsWA8v1AOdlhTB7q/3T0sQQps=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-W0vdIfGOP66mWzIFy1nl9w-1; Mon,
 02 Dec 2024 07:58:27 -0500
X-MC-Unique: W0vdIfGOP66mWzIFy1nl9w-1
X-Mimecast-MFC-AGG-ID: W0vdIfGOP66mWzIFy1nl9w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32501195FCDD;
	Mon,  2 Dec 2024 12:58:24 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF7E1195605A;
	Mon,  2 Dec 2024 12:58:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v1 1/6] mm/page_isolation: don't pass gfp flags to isolate_single_pageblock()
Date: Mon,  2 Dec 2024 13:58:07 +0100
Message-ID: <20241202125812.561028-2-david@redhat.com>
In-Reply-To: <20241202125812.561028-1-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The flags are no longer used, we can stop passing them to
isolate_single_pageblock().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7e04047977cf..e680d40d96de 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -286,7 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * within a free or in-use page.
  * @boundary_pfn:		pageblock-aligned pfn that a page might cross
  * @flags:			isolation flags
- * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  * @skip_isolation:	the flag to skip the pageblock isolation in second
  *			isolate_single_pageblock()
@@ -306,8 +305,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before, bool skip_isolation,
-			int migratetype)
+		bool isolate_before, bool skip_isolation, int migratetype)
 {
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
@@ -489,7 +487,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	bool skip_isolation = false;
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
-	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false,
+	ret = isolate_single_pageblock(isolate_start, flags, false,
 			skip_isolation, migratetype);
 	if (ret)
 		return ret;
@@ -498,7 +496,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		skip_isolation = true;
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
+	ret = isolate_single_pageblock(isolate_end, flags, true,
 			skip_isolation, migratetype);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
-- 
2.47.1


