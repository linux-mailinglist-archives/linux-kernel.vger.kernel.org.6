Return-Path: <linux-kernel+bounces-570739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCEA6B414
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878213B2E70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165401EA7FD;
	Fri, 21 Mar 2025 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X33O8DD2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3935157A72
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535145; cv=none; b=aKUnArLxpUmNuro99uhHHn86wMnBIGmBmp3vCIOffWDgQT3wSyMSPqde44+2Q7vdR0Dd4OHSxIjtv7ubSOdD6tgxETrRxOsAiHmt61Q2ZgdnL7s2kDyGQr/F8MvFs4aD0Lww2vBZtuX8bRwBJqHJ8NqGXYcWEtLEOy6X6zeLJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535145; c=relaxed/simple;
	bh=GRs07s6mkOcdhyFx0EZ6CVVESgavW8JsGWsoeuipBIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l75cmpmqWQkr9Ap4vBmds/SYqi4xiXDGY4xgfaXlQGe9LzyKBhohWvquPBi0Cqy7ogQMGLl1a1u+Y4XVblV0tXfP0VfERzzks5iyWAJyxbepYEdJySjFnOSi2VJRXaeX8rKL0gA04CMsUMxglYU58CBTbmMgy80UgRHhJBfg2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X33O8DD2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742535142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLmz+StgN3LKOwHPa2A88i6gxamoiRfdCYwKVYk+MWA=;
	b=X33O8DD2ezzPY54TYjX7qdgWRlZb//oepjKzDp/Z9Mub7H1sE1Mzqs3ngi8SdiPEn1F09L
	ztIEp3MaJrh9D331s19RpiGprP8ovo0eE/VP9R46zZVBNeSNupwFRrub+Gi3vYhJx+Q9MA
	zJiiph97UAs1eUKw27+2NZtaraIsOVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-SvgeW2gIMd-HhZRu14cONg-1; Fri,
 21 Mar 2025 01:32:15 -0400
X-MC-Unique: SvgeW2gIMd-HhZRu14cONg-1
X-Mimecast-MFC-AGG-ID: SvgeW2gIMd-HhZRu14cONg_1742535134
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C888B196D2D0;
	Fri, 21 Mar 2025 05:32:12 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBD5C19373C4;
	Fri, 21 Mar 2025 05:32:06 +0000 (UTC)
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
Subject: [PATCH 1/2] mm: Fix parameter passed to page_mapcount_is_type()
Date: Fri, 21 Mar 2025 15:31:47 +1000
Message-ID: <20250321053148.1434076-2-gshan@redhat.com>
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

As the comments of page_mapcount_is_type() indicate, the parameter
passed to the function should be one more than page->__mapcount.
However, page->__mapcount (equivalent to page->page_type) is passed to
the function by commit 4ffca5a96678 ("mm: support only one page_type per
page") where page_type_has_type() is replaced by page_mapcount_is_type(),
but the parameter isn't adjusted.

Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
+ 1).

Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..ad87b4cf1f9a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
 
 static inline bool page_has_type(const struct page *page)
 {
-	return page_mapcount_is_type(data_race(page->page_type));
+	return page_mapcount_is_type(data_race(page->page_type) + 1);
 }
 
 #define FOLIO_TYPE_OPS(lname, fname)					\
-- 
2.48.1


