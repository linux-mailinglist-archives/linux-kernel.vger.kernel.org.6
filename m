Return-Path: <linux-kernel+bounces-186709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707138CC7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27221282EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26C146D67;
	Wed, 22 May 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDK8cwoi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF714146001
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411842; cv=none; b=BbQjWA0Bw1kSZZoGbx3MiYyU/HbPV9cVEo7ukq3Frddoffby+QY+XgYx3oTJvEICRXVDvP4NMTeGuK8xLHc3bbpUttUy7jZmreSTuvZ1/JydZ88jxzSSQKvUXpGmvdJFeTBlzrjVHWCn4yPBOTD+T7/xdEpWzn6f51m/cQtChos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411842; c=relaxed/simple;
	bh=AU3lGkdx+T9Jc19ZDNExTERbtu67kY/YvVysSe7kqEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn4PZ8rdlvgwMzvotFe9OMbzlzH0ptfH4jafdJ9VdXQhEWfBEzFo+k5i7HWa1+24+0N3old+7tzd7GWzKfXNRelel9p6zpEdzz5QIjiI8U3xQDPcOEUttC1ZV9DLIjJtAHknqaLKgNSVY8PJLgt9gBSydtWBtLPZ2jzM+DPsu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDK8cwoi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716411839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UoCowHIZmwbvZhrcmlKDIE01w7msvc9uRa4jOe21Z9s=;
	b=fDK8cwoiQNoatJAyBKfnz+0bvyZsSWKkac4gb7gAS9GPUlN1FBTex9AaOXexKOf2l+PC56
	NxQBLBorZSRODFf/pPrccHwyhW1IIEHJU3xzNkYMErdEmsQFtM2c5WyDDK7cuCrym55/Ht
	qqQiBWG/zwDUKMMFbVdcmMxW6Ahqt0I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-SYtBQfzfNPKl0OuyCBwpzw-1; Wed,
 22 May 2024 17:03:58 -0400
X-MC-Unique: SYtBQfzfNPKl0OuyCBwpzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C62691C05142;
	Wed, 22 May 2024 21:03:57 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8409628E2;
	Wed, 22 May 2024 21:03:55 +0000 (UTC)
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
Subject: [PATCH RFC 5/6] mm/filemap: reinitialize folio->_mapcount directly
Date: Wed, 22 May 2024 23:03:40 +0200
Message-ID: <20240522210341.1030552-6-david@redhat.com>
In-Reply-To: <20240522210341.1030552-1-david@redhat.com>
References: <20240522210341.1030552-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Let's get rid of the page_mapcount_reset() call and simply reinitialize
folio->_mapcount directly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 382c3d06bfb1..c4ac7289e88a 100644
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
2.45.0


