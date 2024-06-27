Return-Path: <linux-kernel+bounces-231676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11D919BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01D71C21A72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4214C7C;
	Thu, 27 Jun 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtpQsXJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D299A93D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448845; cv=none; b=Fm5iW3oRSsWkzYr78eufKxWstsefTv+/4iErIqDg2nyriTCDgdCLRVJnSuWOKP+JhO9dLHn7AqsTDN5ZNQzERGr/K9SeS6iWC/mnTZ1VhsK5eRMaC55VZotKYOI5N6GOlqIxBSJE7mfQ9hOblWhLaS6a/65fIBOu5da+BuE81ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448845; c=relaxed/simple;
	bh=1/vTUHqkePMQDhqmfkZcXE+JnHBahBkDKApQ779qjvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1JetTTBqhqk8yHOyEQtWH6vhUkkCoglTOErMxK/dlzTsvyFMW9ZbQn8e5g3KgcL6IHFX3NyAriKyXNtNj9TwwztBNkGQDONtZP5Dle7SUBDn4uRS2TNJCQiXMSgUFU82snaB+1Pw0PMC2dAZz0x4BYxz74n0lC6/4fQXPdVg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtpQsXJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719448843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpi+fgLo1ULqWmpEQ2+qF68D2vMR0O19pRh9JT+w8Y8=;
	b=GtpQsXJQ60YdtF0/ncjnBJ0oe+EWuCRGAPyDSUVW2eDz47SGlxjFf3SCS5faCj85K7napn
	OqLw7x4KaaJAIUk7wg3r78ZbvViHGl0g0+PvEF14Y8v+Ft1fdmAtQYq/hF4POf1aoVhwYT
	IXtwTfd647c1mITw9ZRWHMS04VY/a5U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-R7BSrjyTOliwFewI5PiLbA-1; Wed,
 26 Jun 2024 20:40:39 -0400
X-MC-Unique: R7BSrjyTOliwFewI5PiLbA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AA631956096;
	Thu, 27 Jun 2024 00:40:37 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE1C71956087;
	Thu, 27 Jun 2024 00:40:30 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	hughd@google.com,
	william.kucharski@oracle.com,
	djwong@kernel.org,
	torvalds@linux-foundation.org,
	ddutile@redhat.com,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 2/4] mm/readahead: Limit page cache size in page_cache_ra_order()
Date: Thu, 27 Jun 2024 10:39:50 +1000
Message-ID: <20240627003953.1262512-3-gshan@redhat.com>
In-Reply-To: <20240627003953.1262512-1-gshan@redhat.com>
References: <20240627003953.1262512-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In page_cache_ra_order(), the maximal order of the page cache to be
allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
it's possible the large page cache can't be supported by xarray when
the corresponding xarray entry is split.

For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
is 64KB. The PMD-sized page cache can't be supported by xarray.

Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@kernel.org # v5.18+
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
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


