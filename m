Return-Path: <linux-kernel+bounces-173704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B948C0462
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D02FB23032
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28491130A7B;
	Wed,  8 May 2024 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrskzZLI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538712E1E5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193019; cv=none; b=TFp2Y1oOJHYBg9G3FLMIzVHMlLZZWcnXU7gnRgujsP03y86JA2KVLOtdfEClZXys40H81Eay2YDfFE1/7Y+Uio8N8j65dZa+t+Ldk9hQQNw89W9z+YW3cCEX4wuPIg2euLbLV2dvtoNTZ5pwMiFzOyfuVBBngfFt/I3nCGCRAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193019; c=relaxed/simple;
	bh=4Ant1hPx1kFJaIwGTzV/S4xrLjPsAStc05zlJcLsxfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCss7c6wcr1AUedTzzj7oY301TQwvQnNfMrTJt/XItpbR+y4QUp8ueTai/Mgt6PPJdyqUKTZM3Yc7/t6BlfFJEuo+n+x2uiqKVv9g83cJdrRhNQ/PruhUbIu+wRkxwfeoDaxWIknSBoSd77tL/J3kBwkCrc9VKdDEKBFdjSlBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrskzZLI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0zJtbHvVl56vNC8QA+cdVl06TDILXjVZh0VBjwQ4rY=;
	b=SrskzZLIgNEd5CwAW37GKmx9aQyqYtSJwLsL3QwclWSIte9zCDvTDwiZxxs4BRYhojpZ1H
	BvBHxTkaVr7AgOGka84Kl5LBn+FK69qiE0aizyi1xduN0Feq9dVHQS6ztWgSC3G6ATMNw0
	UXKu9TdeP/5vL5MBq3sZOVSdI6kcIA4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-Z4KsAZmoMXSB97FxwWbamg-1; Wed,
 08 May 2024 14:30:12 -0400
X-MC-Unique: Z4KsAZmoMXSB97FxwWbamg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F9193C0C492;
	Wed,  8 May 2024 18:30:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 121C010009E6;
	Wed,  8 May 2024 18:30:05 +0000 (UTC)
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
Subject: [PATCH v3 03/10] s390/uv: split large folios in gmap_make_secure()
Date: Wed,  8 May 2024 20:29:48 +0200
Message-ID: <20240508182955.358628-4-david@redhat.com>
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

While s390x makes sure to never have PMD-mapped THP in processes that use
KVM -- by remapping them using PTEs in
thp_split_walk_pmd_entry()->split_huge_pmd() -- there is still the
possibility of having PTE-mapped THPs (large folios) mapped into guest
memory.

This would happen if user space allocates memory before calling
KVM_CREATE_VM (which would call s390_enable_sie()). With upstream QEMU,
this currently doesn't happen, because guest memory is setup and
conditionally preallocated after KVM_CREATE_VM.

Could it happen with shmem/file-backed memory when another process
allocated memory in the pagecache? Likely, although currently not a
common setup.

Trying to split any PTE-mapped large folios sounds like the right and
future-proof thing to do here. So let's call split_folio() and handle the
return values accordingly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 25fe28d189df..3c6d86e3e828 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -338,11 +338,10 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		goto out;
 	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
 		folio = page_folio(pte_page(*ptep));
-		rc = -EINVAL;
-		if (folio_test_large(folio))
-			goto unlock;
 		rc = -EAGAIN;
-		if (folio_trylock(folio)) {
+		if (folio_test_large(folio)) {
+			rc = -E2BIG;
+		} else if (folio_trylock(folio)) {
 			if (should_export_before_import(uvcb, gmap->mm))
 				uv_convert_from_secure(PFN_PHYS(folio_pfn(folio)));
 			rc = make_folio_secure(folio, uvcb);
@@ -353,15 +352,35 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * Once we drop the PTL, the folio may get unmapped and
 		 * freed immediately. We need a temporary reference.
 		 */
-		if (rc == -EAGAIN)
+		if (rc == -EAGAIN || rc == -E2BIG)
 			folio_get(folio);
 	}
-unlock:
 	pte_unmap_unlock(ptep, ptelock);
 out:
 	mmap_read_unlock(gmap->mm);
 
 	switch (rc) {
+	case -E2BIG:
+		folio_lock(folio);
+		rc = split_folio(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+
+		switch (rc) {
+		case 0:
+			/* Splitting succeeded, try again immediately. */
+			goto again;
+		case -EAGAIN:
+			/* Additional folio references. */
+			if (drain_lru(&drain_lru_called))
+				goto again;
+			return -EAGAIN;
+		case -EBUSY:
+			/* Unexpected race. */
+			return -EAGAIN;
+		}
+		WARN_ON_ONCE(1);
+		return -ENXIO;
 	case -EAGAIN:
 		/*
 		 * If we are here because the UVC returned busy or partial
-- 
2.45.0


