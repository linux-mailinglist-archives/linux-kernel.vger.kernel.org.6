Return-Path: <linux-kernel+bounces-571189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366FA6BA42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696C27A8881
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E722577C;
	Fri, 21 Mar 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HByUaNVM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB0223321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558586; cv=none; b=jl7ixnC3QSLCjZp9ywzJoZq9psE/O6CDM8c0EVQ+nt/fBdauOqLk8aUjukM0BLoQG+l5F/nwHAkw0gUwGayDcQeOCsPW62ekJc2f9IvrNlNsQSJCJG4EsOCdEHLmpaNmRgRCiyZQWIykQbLfIhmTZqQdU6JHKlocRo8qbB1qpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558586; c=relaxed/simple;
	bh=brtBy+arPIjdmr9zw58ZDHd1yGa9AyUExZhR879IGfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyO/vMSvd++rhM1Z1HqMMrGfvcJjJt77SgeSJgGHNarrYoeRHNINVq0wS73kz/Jv/1DuB3+7b+TzDWlQYYl3MPhiV1rhj80gbLeMAwbdSUfbHYMafE2n9DlZA6Or0f2aJ2YRQl2Hj81EsmgYNdgk0mpovlUQUuGx0yBvCE3zLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HByUaNVM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfyBhRJTzJJrkSB7WfOD6keM2Nw7kHit0uDNIvdviMc=;
	b=HByUaNVMK0ZgCaCaTxkxA2T5FRX/1w2kuhgUyyAV++5QkqN7wV4cMH+N5FJm2s+6Fg7DVP
	XK1v8NdazKq8m2yunmywdoPG63ykvLIbspFL/0UP7IpfEB/69afYn+rYMyucrAQNreVgLa
	BmYLSz5FPo/bDrJD91svkJN37VNnTUA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-svVIeqkMOq-3xOm8K140mw-1; Fri,
 21 Mar 2025 08:02:59 -0400
X-MC-Unique: svVIeqkMOq-3xOm8K140mw-1
X-Mimecast-MFC-AGG-ID: svVIeqkMOq-3xOm8K140mw_1742558578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 848051800258;
	Fri, 21 Mar 2025 12:02:57 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3C981801752;
	Fri, 21 Mar 2025 12:02:51 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	vbabka@suse.cz,
	linmiaohe@huawei.com,
	gehao@kylinos.cn,
	shan.gavin@gmail.com
Subject: [PATCH v2 2/2] mm/debug: Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 22:02:22 +1000
Message-ID: <20250321120222.1456770-3-gshan@redhat.com>
In-Reply-To: <20250321120222.1456770-1-gshan@redhat.com>
References: <20250321120222.1456770-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

As the comments of page_mapcount_is_type() indicate, the parameter
passed to the function should be one more than page->_mapcount.
However, page->_mapcount is passed to the function by commit 4ffca5a96678
("mm: support only one page_type per page") where page_type_has_type()
is replaced by page_mapcount_is_type(), but the parameter isn't adjusted.

Fix the parameter for page_mapcount_is_type() to be (page->__mapcount
+ 1). Note that the issue doesn't cause any visible impacts due to the
safety gap introduced by PGTY_mapcount_underflow limit.

Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
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


