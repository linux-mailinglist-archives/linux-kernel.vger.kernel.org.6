Return-Path: <linux-kernel+bounces-266279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0093FD85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16251F229DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D9187873;
	Mon, 29 Jul 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gggzIkAs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5F187848
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278355; cv=none; b=PdvpFMqsArBZQW7CXpj4VO2RVgJ1tS3Cq+HNRt+e3RBxiyMzyRFR0lEVg9eApaye6UHAIQRpfDd4+xDSZ5GIGNypi6BQw7LzaT+kclujcN9QLvdlxj31i780bhmCq1yGOm86KX8s4P51RkQvCzG7jc35bKQ1upNbtrbq4/gKqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278355; c=relaxed/simple;
	bh=CuI3A3UP7rCuy25/6pPJiotF95Rkz1Dr1he2WDJI2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFMYA8yyNlWERgCEWPX3AdifWFXcXgTy3m1z7V21kc03+cEFiAxtzNUsUNorNfELY4ActVdSB98cvKwcGzsbGi1hRpGSY4Y3yLZT4x4rThkQR4USPr/LZGHqGwVV3Jgn14VD5Y6mSkbXOW2/b1uXO+3db9klxnQAVscJORYNgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gggzIkAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722278353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LweK4YyrJ+GH/WLrm8oiFvHfSVbn4+ENVtw/AVp5dM=;
	b=gggzIkAsWZ3waP+b3d6i3vm8xaWbVj1zB7SRP73Fy98aT9oQR3tbSrhWjGF3LZv/HIn7zq
	XDj9OV6N+gxJTDmC9B1RYu9sgtTN1C7oBiQlXjFVfsnEKhmqD5zo2fcOwF3CmhA7LrvCJw
	BAp0H1AF1aq1rSR17G1b/g6J5P6aEKo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-8Qug9MJyOh6RXOQYIceWMA-1; Mon,
 29 Jul 2024 14:39:09 -0400
X-MC-Unique: 8Qug9MJyOh6RXOQYIceWMA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B279A1955F49;
	Mon, 29 Jul 2024 18:39:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA481955D45;
	Mon, 29 Jul 2024 18:38:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/3] mm: simplify arch_make_folio_accessible()
Date: Mon, 29 Jul 2024 20:38:42 +0200
Message-ID: <20240729183844.388481-2-david@redhat.com>
In-Reply-To: <20240729183844.388481-1-david@redhat.com>
References: <20240729183844.388481-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now that s390x implements HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE, let's turn
generic arch_make_folio_accessible() into a NOP: there are no other
targets that implement HAVE_ARCH_MAKE_PAGE_ACCESSIBLE but not
HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 381750f41767a..bab689ec77f94 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2215,16 +2215,7 @@ static inline int arch_make_page_accessible(struct page *page)
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
-	int ret;
-	long i, nr = folio_nr_pages(folio);
-
-	for (i = 0; i < nr; i++) {
-		ret = arch_make_page_accessible(folio_page(folio, i));
-		if (ret)
-			break;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.45.2


