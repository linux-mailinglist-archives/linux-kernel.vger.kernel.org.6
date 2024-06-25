Return-Path: <linux-kernel+bounces-228589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF79161EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE9E1F25BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD814A61B;
	Tue, 25 Jun 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKorV3OK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7327149011
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306462; cv=none; b=rO0rQ1zZrM9ldGepbVkm7nad7hk82dQ/RSihd3lxfZr4iPAczkMn83PM8Qf7c88M+VEKZdDnOddgnfu3RJXUrO2W6i9vUf5f9NZZcbEi52u1A7Q1+mavCtxQ7BJGhhRufjuSQ8xo74mKEKspUo1GLUOntEM3zZQopDCfZVFATus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306462; c=relaxed/simple;
	bh=1BihIDrfzGB5v0YeXyfxenhxGR0GaRUHyvLdE67BmLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVcgJUUPiKGc+xlvHXUiAffgSVpbGSCSKjtHjG3BvPrWJ3gFoVJ0UHc8EI2I1O/Y7EOnscdEysneSgcXsIpKv14vHvWb5hUpp//q95RVh9orN8Dpl16awlvx3D6+zyQgLIxmCOe5yXxjbRKGalCqL/lN+3EtaajJf9Q8i9F1l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKorV3OK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719306459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptlUNcO5mIabfV9LABSh8DDvNkvRbhBbpL84ksizTYg=;
	b=LKorV3OKf4uOi/egV8TL819EBOp5+hgrzxp10VvyvV7J5tbeDuDL5BH16JNTsnenddFsaW
	qlFhJQmWR3/JZL1aI2uc+kXdfc7dBYwbLskIQGQlsLi82qCUzRl7mTWahA4dYhAQcsKn2d
	vKrEqLb5zyNkgQztouI+9xFspDw4S3Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-yOuNp3xGN_WdXUTuwYLdhg-1; Tue,
 25 Jun 2024 05:07:35 -0400
X-MC-Unique: yOuNp3xGN_WdXUTuwYLdhg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 397DE19560AD;
	Tue, 25 Jun 2024 09:07:33 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.67.24.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A8801956087;
	Tue, 25 Jun 2024 09:07:25 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	torvalds@linux-foundation.org,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 3/4] mm/readahead: Limit page cache size in page_cache_ra_order()
Date: Tue, 25 Jun 2024 19:06:45 +1000
Message-ID: <20240625090646.1194644-4-gshan@redhat.com>
In-Reply-To: <20240625090646.1194644-1-gshan@redhat.com>
References: <20240625090646.1194644-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In page_cache_ra_order(), the maximal order of the page cache to be
allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
it's possible the large page cache can't be supported by xarray when
the corresponding xarray entry is split.

For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
is 64KB. The PMD-sized page cache can't be supported by xarray.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..817b2a352d78 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < MAX_PAGECACHE_ORDER)
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	}
+
+	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
-- 
2.45.1


