Return-Path: <linux-kernel+bounces-219698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57590D6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9E1F2270F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03323DB89;
	Tue, 18 Jun 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpk4Ikfd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0ED482C6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723438; cv=none; b=u0jYVsPJDUli0rVHb95Fi8WctPNck150/lv7UvndOJbrs/HUwNYtPn+2VjkOk6suOxqhkkTfuOolB38AelZ2b5+s8CHR27lPoneIbCHu41M6lQr1WzxZ3DoD4sNacFERwIVP8W+esLZvHIg7qSVdsj9f8A+xua1MLMobPu4V+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723438; c=relaxed/simple;
	bh=AxiGyfC55u2RtY0Ev8YK8wIoUOAdy0LeEA5TKxtRv5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXaw76JaUoJ5n+/B+AotjiS8XVP7j7okpC5P5qSJqlFK0k09PAoXexTrOOiizNidA+kNTpXhs0rUcBKao3oWZ/+Esfq4zjGZgiNdDVKpXfTl/PJUbKfLA5CMfhhjxozGMQd0yN/PdwX0IGdee2U8kktE55UftcGWMzbCd9BtVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hpk4Ikfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718723435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1es3ECOkdNs+2hzIuvv3Jx9YKFXHOd3EXF7iaYcF0ds=;
	b=Hpk4Ikfd/5feiK9crtxKDEo0hsrZxHPuF5EkontHSzGFsNNes3DmY8ishsDJrehX6tcQBh
	VVFLJyvrHUzr9LLru1BK7uX6qtJXC5GeqK2xsKcsPkaxUtZdzVb8GKp50WRU8hM+7k+K1P
	jov5yVDhWA5ZFf1tyWJiHW91yhavQiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-1udAHGKsNN68fESFhGYFag-1; Tue,
 18 Jun 2024 11:10:31 -0400
X-MC-Unique: 1udAHGKsNN68fESFhGYFag-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B95C19560B1;
	Tue, 18 Jun 2024 15:10:30 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.208])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67D8D1956057;
	Tue, 18 Jun 2024 15:10:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v1] mm/rmap: cleanup partially-mapped handling in __folio_remove_rmap()
Date: Tue, 18 Jun 2024 17:10:26 +0200
Message-ID: <20240618151026.521019-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Let's simplify and reduce code indentation. In the RMAP_LEVEL_PTE case, we
already check for nr when computing partially_mapped.

For RMAP_LEVEL_PMD, it's a bit more confusing. Likely, we don't need the
"nr" check, but we could have "nr < nr_pmdmapped" also if we stumbled
into the "/* Raced ahead of another remove and an add? */" case. So
let's simply move the nr check in there.

Note that partially_mapped is always false for small folios.

No functional change intended.

Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index afec4b6800caf..aa900e46cdf82 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1551,11 +1551,12 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			}
 		}
 
-		partially_mapped = nr < nr_pmdmapped;
+		partially_mapped = nr && nr < nr_pmdmapped;
 		break;
 	}
 
-	if (nr) {
+	if (partially_mapped && folio_test_anon(folio) &&
+	    list_empty(&folio->_deferred_list))
 		/*
 		 * Queue anon large folio for deferred split if at least one
 		 * page of the folio is unmapped and at least one page
@@ -1563,10 +1564,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 *
 		 * Check partially_mapped first to ensure it is a large folio.
 		 */
-		if (folio_test_anon(folio) && partially_mapped &&
-		    list_empty(&folio->_deferred_list))
-			deferred_split_folio(folio);
-	}
+		deferred_split_folio(folio);
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*
-- 
2.45.2


