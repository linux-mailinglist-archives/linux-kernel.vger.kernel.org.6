Return-Path: <linux-kernel+bounces-248279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C8C92DB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5013B225FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B513C908;
	Wed, 10 Jul 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMPI3tHm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9813B59F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647841; cv=none; b=PhR68Cf3ex8mxKt4WA8Y2V2odIG7sCD1LOgEd1Y8XxcqP9yPsi2o0JZubuQVobvNU/VKgz9lWxw453cYC9vjBgfxg2RFm7IRhNtdpsDEbyhJDJtQk7X6+atdwMZsoyLWqpnLfjaPq0mGe+NmHqNS7udl5WKNMJWV0HRu4istoTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647841; c=relaxed/simple;
	bh=p5xhIyHiaGZPTuQEtxT3iTDeEAVC11/FL4J+Xe5Y9zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b72SYQgE3OggBtlcLFbqfBFj5ES0VUzl8et2of3IySxOAPW+8Dclt5NJhp/7nRJsLjcCdYXlN6QHbuhJq3V2ahx6C6cEQAjYkd/j4Zm5mwlhAjq0DY2ZhN0J9PQKHuHGxz7WHPA7nkLPv7Uc50eJPylO21BqglFzPE+VK839bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMPI3tHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720647838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCutBsp9TgHN4Z+ki1WI/JP8vNYRKZa/toKu4KHF178=;
	b=XMPI3tHmncko92XZUmVyFbCvFne+EYK+kvLBm58JOvjnHjtXpyE37v3+CAvxZG/pfTPomg
	9J+PWJucZwdxl+ZOWXMKHCbJ0Ur64+CVIk2pLVWhdn06INPR3DoUvDQbP7kRu7hE5Z8K7H
	kpzxH4OnzhCs1lrBvF+SkjFjaTzKKa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-LLiKEGtXN6a2CHoPrTor0g-1; Wed,
 10 Jul 2024 17:43:57 -0400
X-MC-Unique: LLiKEGtXN6a2CHoPrTor0g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B80011956080;
	Wed, 10 Jul 2024 21:43:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ABF43000182;
	Wed, 10 Jul 2024 21:43:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm/rmap: cleanup partially-mapped handling in __folio_remove_rmap()
Date: Wed, 10 Jul 2024 23:43:50 +0200
Message-ID: <20240710214350.147864-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's simplify and reduce code indentation. In the RMAP_LEVEL_PTE case, we
already check for nr when computing partially_mapped.

For RMAP_LEVEL_PMD, it's a bit more confusing. Likely, we don't need the
"nr" check, but we could have "nr < nr_pmdmapped" also if we stumbled
into the "/* Raced ahead of another remove and an add? */" case. So
let's simply move the nr check in there.

Note that partially_mapped is always false for small folios.

No functional change intended.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
* Move comment as well; add RB's.
* CC Andrew ;)

---
 mm/rmap.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 8616308610b9..bbf002667e61 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1549,22 +1549,19 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			}
 		}
 
-		partially_mapped = nr < nr_pmdmapped;
+		partially_mapped = nr && nr < nr_pmdmapped;
 		break;
 	}
 
-	if (nr) {
-		/*
-		 * Queue anon large folio for deferred split if at least one
-		 * page of the folio is unmapped and at least one page
-		 * is still mapped.
-		 *
-		 * Check partially_mapped first to ensure it is a large folio.
-		 */
-		if (folio_test_anon(folio) && partially_mapped &&
-		    list_empty(&folio->_deferred_list))
-			deferred_split_folio(folio);
-	}
+	/*
+	 * Queue anon large folio for deferred split if at least one page of
+	 * the folio is unmapped and at least one page is still mapped.
+	 *
+	 * Check partially_mapped first to ensure it is a large folio.
+	 */
+	if (partially_mapped && folio_test_anon(folio) &&
+	    list_empty(&folio->_deferred_list))
+		deferred_split_folio(folio);
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*
-- 
2.45.2


