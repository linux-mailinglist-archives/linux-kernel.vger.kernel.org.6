Return-Path: <linux-kernel+bounces-571188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2533EA6BA41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FC33B843A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEDA227E89;
	Fri, 21 Mar 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL3RrN9q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE6223321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558577; cv=none; b=Hrfu6+K3QwUf1DdwvkkIDj0mBNkoJhdPlRu2D2VCVIYw6GnDus3VBufCan+x1YgIBQZ5JZm0SgLP/v48kuAX/QtDsyffa4bxY7gnJCFNGJ9+ZTFdlxW7CvnefYIoncKQF+sf6dLXFP6G7N6dzx19JUUb0fHyyxhmNQzvadQQUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558577; c=relaxed/simple;
	bh=u1A2nCdQ6yVZaCxmoY5f1VtvidVxXFjscqkoECaO9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs2GBCub8ZjSyfTt8rpNe2I5rEwhHJCsNK53cYDbZMqP3NtUDIfiH0IyU+ebKfgv0O/5QI/VJfrfHiPJRUD65LTBP5+3/c4FnUA07BQWu2LLm42mW42sXwDSPk889rwrqMhMoy0P2i8EU6NwUUIGQSQ5sseUGpuJGDJz3fdn8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL3RrN9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tssdr9ycuQAxVV+JKQvCwDsGSIohsIi0k9uUE/7l9cI=;
	b=PL3RrN9qdgmiP0oOSBtoTKcz4FqBe7XO6T7AJeaZECuNzPizqAHLFntISNH4pZIuZU5uv8
	jUR+HTqH+d6tBY8Jd45C8pjJD6wpbqOhgw08ZXqrJtjeHRBpajYQrsNT1sAtWq3tbc3qxi
	ZfcwQMlFtmjzzG07LnP52f0wxDRijOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-Vi-M0uomOBeNTpdc9FVFGA-1; Fri,
 21 Mar 2025 08:02:53 -0400
X-MC-Unique: Vi-M0uomOBeNTpdc9FVFGA-1
X-Mimecast-MFC-AGG-ID: Vi-M0uomOBeNTpdc9FVFGA_1742558571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2139196D2D8;
	Fri, 21 Mar 2025 12:02:50 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F0E71801752;
	Fri, 21 Mar 2025 12:02:44 +0000 (UTC)
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
Subject: [PATCH v2 1/2] mm: Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 22:02:21 +1000
Message-ID: <20250321120222.1456770-2-gshan@redhat.com>
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
However, page->_mapcount (equivalent to page->page_type) is passed
to the function by commit 4ffca5a96678 ("mm: support only one page_type
per page") page_type_has_type() is replaced by page_mapcount_is_type(),
but the parameter isn't adjusted.

Fix it by replacing page_mapcount_is_type() with page_type_has_type()
in page_has_type(). Note that the issue doesn't cause any visible impacts
due to the safety gap introduced by PGTY_mapcount_underflow limit.

Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..e1a9f84bd5ab 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
 
 static inline bool page_has_type(const struct page *page)
 {
-	return page_mapcount_is_type(data_race(page->page_type));
+	return page_type_has_type(data_race(page->page_type));
 }
 
 #define FOLIO_TYPE_OPS(lname, fname)					\
-- 
2.48.1


