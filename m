Return-Path: <linux-kernel+bounces-571153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20784A6B9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A095D3B6918
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C3224243;
	Fri, 21 Mar 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdOeBjF+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B32202C27
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556315; cv=none; b=acBJgQKBBWl8tRdV3sF/KcCP+3R+Nh+I//UpndOxIhXaBHSnW2S0kpifBJRT7sH1uF8pBu+Hh+ntu2KneX7bGyRzJubfLIe9ZbiH9HENkTMr4IQ0mdLH1j+6Lw0M1+hDWY7TgOi8O+R3+tVIbvDa9MaHpm/XNMmDW2RAfWXDMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556315; c=relaxed/simple;
	bh=jJntAIfVRU4t714r35ZhKF0V7tnY7tGFqkj4VRR2sUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnDB/LZx0Ud4UCv/eBjlydcS23LQww1J0c1xGlaJT5/QPiAeHBGAYix5azL2oQx5uyIlKlsrQb+/O9kcVj6+IISVO5E3bfsZdDwYQFoLKBw75iApAzoKyt6VqeSb4j/rT8J8lNIOwzbSC7fh2l1wRooxsBZwQObWGQG0utBBVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdOeBjF+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ULjzTuWq4KWWMz5FWBM7gDBkyDsf2B5DDVUjmTkqks=;
	b=LdOeBjF+VwE9Gl39gogjmn+MSCD3kYHdN1RQunE7nnml+qwtio7SaQlH2b+QIA9qKV+RvX
	Psde7GiJjNmC0IJlSEA4tl7cwY9bxJZqvHmJcKTh7cLuDCtk+WDwm8LiLoyCibLSGZEdWl
	W/hZsfylzLNGNSH5RpF8WChS/Hs2Vww=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-sWdaQcbIMZuU33p4OBIaMQ-1; Fri,
 21 Mar 2025 07:25:09 -0400
X-MC-Unique: sWdaQcbIMZuU33p4OBIaMQ-1
X-Mimecast-MFC-AGG-ID: sWdaQcbIMZuU33p4OBIaMQ_1742556307
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CD581945103;
	Fri, 21 Mar 2025 11:25:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.34.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5F87180175B;
	Fri, 21 Mar 2025 11:25:01 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 1/2] mm/kmap: Add kmap_local_page_try_from_panic()
Date: Fri, 21 Mar 2025 12:16:55 +0100
Message-ID: <20250321112436.1739876-2-jfalempe@redhat.com>
In-Reply-To: <20250321112436.1739876-1-jfalempe@redhat.com>
References: <20250321112436.1739876-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

kmap_local_page() can be unsafe to call from a panic handler, if
CONFIG_HIGHMEM is set, and the page is in the highmem zone.
So add kmap_local_page_try_from_panic() to handle this case.

Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 include/linux/highmem-internal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index dd100e849f5e0..5d089b0ca56de 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -73,6 +73,13 @@ static inline void *kmap_local_page(struct page *page)
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_page_try_from_panic(struct page *page)
+{
+	if (!PageHighMem(page))
+		return page_address(page);
+	return NULL;
+}
+
 static inline void *kmap_local_folio(struct folio *folio, size_t offset)
 {
 	struct page *page = folio_page(folio, offset / PAGE_SIZE);
@@ -180,6 +187,11 @@ static inline void *kmap_local_page(struct page *page)
 	return page_address(page);
 }
 
+static inline void *kmap_local_page_try_from_panic(struct page *page)
+{
+	return page_address(page);
+}
+
 static inline void *kmap_local_folio(struct folio *folio, size_t offset)
 {
 	return page_address(&folio->page) + offset;
-- 
2.47.1


