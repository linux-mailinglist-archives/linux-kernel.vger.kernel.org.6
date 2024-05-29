Return-Path: <linux-kernel+bounces-194009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD918D3558
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22A3B25769
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A7181309;
	Wed, 29 May 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PekxWPKT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F3180A83
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981562; cv=none; b=fzjzt4aMVEeu58uJXsilovQbCc23CyePLBvt1XrKoCxKhPDNTQXsVyGFi2dltUprLA9k9ygXFHrSFuygb9tGYLEmZtGzmzb4V9j3cRPBmu9/R4wxvTtlwZj03+MJWm+ZzypAE/vGthEVCHFUOKZV+4Tj+yeXLUzGrRm6cvIBW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981562; c=relaxed/simple;
	bh=u1TfSxJfb/OshHhAS7cl9CkuPjr/yVjayHR5SnVoIyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipQB+WcZwYthD5S9RcJlzYFQ9jfwr7e6PRqqX8SJiWqyjlkni5XMrNdflZAwCqZmcm/KFECFlbnS+1HCv1xfhO36B5GigzAmCEVg/kcYC+6GsTvaNs9P5WVBPjtDCCZw4p+ZqYAaSMm42WT0EJrzVVIWDJYLOdKQom3Qnj6XpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PekxWPKT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716981560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9wGKMA7pg+ELfK4C46qM4+rq+qnJqY5pRyECiTlobg=;
	b=PekxWPKTRkzVu7/8WIJK3BxLYPPBBF9+F02JjjXzFQB44NDacb7N48NdatcRVhxxaROrQA
	0lWBzRYf9vOQgQv2Jw6/G79NHmmNXYd+ftZfb4JrCifDSXuGCLaPo8Fnq8e1soBxETdJwF
	BDi8C4F+zDMx1zneTgbdUzSWx51Z3Lg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-YyUVCmUjPleKjz5PsgrFIg-1; Wed,
 29 May 2024 07:19:17 -0400
X-MC-Unique: YyUVCmUjPleKjz5PsgrFIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6752B3806701;
	Wed, 29 May 2024 11:19:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA1DAC15BB1;
	Wed, 29 May 2024 11:19:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v2 5/6] mm/filemap: reinitialize folio->_mapcount directly
Date: Wed, 29 May 2024 13:19:03 +0200
Message-ID: <20240529111904.2069608-6-david@redhat.com>
In-Reply-To: <20240529111904.2069608-1-david@redhat.com>
References: <20240529111904.2069608-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Let's get rid of the page_mapcount_reset() call and simply reinitialize
folio->_mapcount directly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ba06237b942d6..9fe5c02ae92e7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -177,7 +177,7 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 				 * and we'd rather not leak it: if we're wrong,
 				 * another bad page check should catch it later.
 				 */
-				page_mapcount_reset(&folio->page);
+				atomic_set(&folio->_mapcount, -1);
 				folio_ref_sub(folio, mapcount);
 			}
 		}
-- 
2.45.1


