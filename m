Return-Path: <linux-kernel+bounces-173707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56418C046A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A227F288311
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF813118D;
	Wed,  8 May 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z12DWMn+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13A12F592
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193028; cv=none; b=P5ZiFxqyjT0e+tPywh5d12Ztb7VGIMBRLnwlczjFbLch2WoFsE3UmSigZc9p8vs9aMjs3AmW42YNkfB0XMbBKZbu9se3oFd2Da+P+9YJRugTQNBahq2tPv0AhjA80hnmSMwCW64yTsKxTeN2KlIpvFbcwNHb0NMmyCe6QrpwA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193028; c=relaxed/simple;
	bh=9K4b45laZdNLGOE3PLYC50CesahpPcEoMOXIPZQOUns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDOAwtNzCV6mRHFnj+CkhpES36HRcbcJ3XjHNnovZyWARPa2tqFnP4gvvhRvV3xclZusquYnd3AY4koN1+KShyQ0vmXuBzxtJh8Dl4jwObWqAUi9T1I5THRiaKrJHFdEZqcTMnips6Bcu6kA98q/Y1Ipp8L/xOysiY2M5uFQ4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z12DWMn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euG4H2jLxPWWopJzcZTtbNHrfmvS+4fB/smaR374hd0=;
	b=Z12DWMn+hFkX8bJUFsfwQZQVXBDVAwk7yeCvN0/vxT5HFyzppKlTJ1w8OgvgdPueLVTNPo
	aVFnotTqz2HOXGOhN6EhZQnCpP5R0XlU5OYO11T4WBSGUKSIsW4DO0s3f5PmT2qbTIupok
	BaCVNpt3mgH5hlnJ2qfVTKsz+srNCvY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-NycTvc1nOQeQ14sj1yHBJw-1; Wed,
 08 May 2024 14:30:17 -0400
X-MC-Unique: NycTvc1nOQeQ14sj1yHBJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0BD61C4C39C;
	Wed,  8 May 2024 18:30:16 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39F1F10000AD;
	Wed,  8 May 2024 18:30:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 05/10] s390/uv: update PG_arch_1 comment
Date: Wed,  8 May 2024 20:29:50 +0200
Message-ID: <20240508182955.358628-6-david@redhat.com>
In-Reply-To: <20240508182955.358628-1-david@redhat.com>
References: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

We removed the usage of PG_arch_1 for page tables in commit
a51324c430db ("s390/cmma: rework no-dat handling").

Let's update the comment in UV to reflect that.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 914dcec27329..ecfc08902215 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -495,13 +495,12 @@ int arch_make_page_accessible(struct page *page)
 		return 0;
 
 	/*
-	 * PG_arch_1 is used in 3 places:
-	 * 1. for kernel page tables during early boot
-	 * 2. for storage keys of huge pages and KVM
-	 * 3. As an indication that this small folio might be secure. This can
+	 * PG_arch_1 is used in 2 places:
+	 * 1. for storage keys of hugetlb folios and KVM
+	 * 2. As an indication that this small folio might be secure. This can
 	 *    overindicate, e.g. we set the bit before calling
 	 *    convert_to_secure.
-	 * As secure pages are never huge, all 3 variants can co-exists.
+	 * As secure pages are never large folios, both variants can co-exists.
 	 */
 	if (!test_bit(PG_arch_1, &folio->flags))
 		return 0;
-- 
2.45.0


