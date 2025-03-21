Return-Path: <linux-kernel+bounces-570740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB13A6B413
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A1F189C409
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B591EB9ED;
	Fri, 21 Mar 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJz+BjiH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7381E9B2C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535151; cv=none; b=T8zd4SwXVNe2Igx5vT7GftNqUyJ9Agsb+KGw9bWbKYCs4Jk35Vy9Jy8LkGClJRfJrJ9V6ty7btDNgUE2yVsYHCM6RI8eYi6zoLappwm9M36DhMibYQv2Z5KwmjICx5U/dUiOBSqw9B0IGf5Y8pmA/63C0ewyBmdhtR1LrKrQNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535151; c=relaxed/simple;
	bh=60IBVIW/YE5vet3apCFvtyROr9A+TP8l93hDsSzu2n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeMI+ykeygsQEzchKS71HhMY7xQ2NFdHQ4SZhQ7sfg1Y3yqFl5Mqdpr3I6gNcucTVThmjPyFEzWk0gPi3+p1wVL5i6kxzJjPx9P7nlz6IbihpuZ0wNRP2/Ro/pEUal4YkMiAZVWsWO2Nl5abH2OwWB+4pDeaxflKi1v4de7Yytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJz+BjiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742535148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lpSCB8BhAtQd/roFhxiAeh+Ow96uVGCOGIfu1pyhrw=;
	b=EJz+BjiH7MDxVjCvCMpucyAUTE/zvbzr3/mkRWpYX8nZvChWPBOLQXIuqEstlEMKJAT9Fe
	w9j1a57QAFez4/XgMO05uQwCC+Yp2fBdNtzMgUyTTSbUBqB2CHEb13xveZrrJjJYzDaJwQ
	VR6fRO1Mlnn9RmhnwogLPG/6HZU5U0Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-9WcBLVVEM6WOIlvEUBSJJA-1; Fri,
 21 Mar 2025 01:32:21 -0400
X-MC-Unique: 9WcBLVVEM6WOIlvEUBSJJA-1
X-Mimecast-MFC-AGG-ID: 9WcBLVVEM6WOIlvEUBSJJA_1742535140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D84821800257;
	Fri, 21 Mar 2025 05:32:19 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4CF5192ED65;
	Fri, 21 Mar 2025 05:32:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	vbabka@suse.cz,
	osalvador@suse.de,
	gehao@kylinos.cn,
	shan.gavin@gmail.com
Subject: [PATCH 2/2] mm/debug: Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 15:31:48 +1000
Message-ID: <20250321053148.1434076-3-gshan@redhat.com>
In-Reply-To: <20250321053148.1434076-1-gshan@redhat.com>
References: <20250321053148.1434076-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As the comments of page_mapcount_is_type() indicate, the parameter passed
to the function should be one more than page->__mapcount. However,
page->__mapcount is passed to the function by commit 4ffca5a96678
("mm: support only one page_type per page") where page_type_has_type()
is replaced by page_mapcount_is_type(), but the parameter isn't adjusted.

Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
+ 1).

Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8d2acf432385..b6bd9555ec7b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -71,10 +71,10 @@ static void __dump_folio(struct folio *folio, struct page *page,
 		unsigned long pfn, unsigned long idx)
 {
 	struct address_space *mapping = folio_mapping(folio);
-	int mapcount = atomic_read(&page->_mapcount);
+	int mapcount = atomic_read(&page->_mapcount) + 1;
 	char *type = "";
 
-	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
+	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount;
 	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
-- 
2.48.1


