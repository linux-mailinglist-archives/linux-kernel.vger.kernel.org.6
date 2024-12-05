Return-Path: <linux-kernel+bounces-432782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E79E5043
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43A528056F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268A1D516A;
	Thu,  5 Dec 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2gbX+wz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF41C2323
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388755; cv=none; b=aJhiuO2SxOvhFcsf2OMdmm7zXkzqTfnSDGZlrsVizYEnO+c+LDgQ0EaJ5WnLch+0NX652Z9GRlSyH6iFYl3uEGbk0ZXwfwj/U8yg6sLwcJ8ae+/H8Ysn7FkUAZO+DHOLKOVDZVDYBf3/4oNw/SWBiWSFcScueFlTWVOA0QLpkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388755; c=relaxed/simple;
	bh=yQP9CqueRlm+YQ9afptPMf9AE+3AyBDNitTmhZ7+6Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2nVTu7nNi7H6jLVw6l5v6cmC27h34G0SvM5YO1e20CBvP+h1t42l5SAGLWhzeU5BKiJpsVpx0oyuM2T8lXtDEJIGrTIKvRe0m1M7Zh6ScVo/vj+sR9ai9H8IOA2ZkUnlyHYaMhilLYklRUFIUxTFgg4x6flqCRPtPZcF4I2JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2gbX+wz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733388752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZSFDwJlAKXFJSXVwhmhlyEP18MO+pVAWVa/JNjtNys=;
	b=i2gbX+wz2fdNlL/7nXdhv8RREzh70LtcgpubVzHz0Yyhwy7yRfvuKIaF2f1hXzeeO6JoOv
	7CWSVr+4KV9LpHfl9i8Xl+cOJJi0oi4cjQSDujD1x3wVguvckc4OJaAd+inUcjPqh6J94T
	nEKIy90+FVi8Ay+YDf+iXXUJC9f+uJk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-_HdlSJJMNgqYTxIvmncL3A-1; Thu,
 05 Dec 2024 03:52:26 -0500
X-MC-Unique: _HdlSJJMNgqYTxIvmncL3A-1
X-Mimecast-MFC-AGG-ID: _HdlSJJMNgqYTxIvmncL3A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD67819560A2;
	Thu,  5 Dec 2024 08:52:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.64.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6A101956052;
	Thu,  5 Dec 2024 08:52:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 1/2] mm/page_alloc: don't use __GFP_HARDWALL when migrating pages via alloc_contig*()
Date: Thu,  5 Dec 2024 09:52:16 +0100
Message-ID: <20241205085217.2086353-2-david@redhat.com>
In-Reply-To: <20241205085217.2086353-1-david@redhat.com>
References: <20241205085217.2086353-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We'll migrate pages allocated by other contexts; respecting the cpuset of
the alloc_contig*() caller when allocating a migration target does not
make sense.

Drop the __GFP_HARDWALL.

Note that in an ideal world, migration code could figure out the cpuset
of the original context and take that into consideration.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48a291c485df..acadfcf654fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6410,11 +6410,11 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
 	 * for them.
 	 *
-	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
-	 * keep doing that to not degrade callers.
+	 * Traditionally we always had __GFP_RETRY_MAYFAIL set, keep doing that
+	 * to not degrade callers.
 	 */
 	*gfp_cc_mask = (gfp_mask & (reclaim_mask | cc_action_mask)) |
-			__GFP_HARDWALL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+			__GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	return 0;
 }
 
-- 
2.47.1


