Return-Path: <linux-kernel+bounces-533953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EAA460A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49331778C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692C21C177;
	Wed, 26 Feb 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT5GxHxe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614F21E0B2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576191; cv=none; b=hc3IpwxcjRKEIpywFkcygDxmgBvEviGbsXoqb6mko4V4MbwyBJAs7MCqKw6+jah+ThNJ0ZH+3E5DGneGVR2p0xysYz48ZAgQsSNBmOVAiHT5w3fpyrR4rVSfqqxTfC/qNf6l43kOLlRXphrO+075JwfCsQSRSe+8xC4EDYBfQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576191; c=relaxed/simple;
	bh=J7bX3ng3MBFI3uixjZ9NZmXg9rqbq82/FkUeeG0DYh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9onGWA6HoGhwSXmhPHvDZm7CTbyc0q7NSC5FsK0YKweGoKdT4UULu/ftrNiI90LR/O7AAsbBcUUwYW9VGRL8c5NBangid7iP6DFcXDS9xAHQhG/9nzIlVML0kK7kkaVNK+eWigYpBsOoz0yQ3Qiln9FPNrGPPPKftiHqji1qVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jT5GxHxe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjPK0xAhUMwvoTDKlkbg0/+uhvWrRoFGreGRAQOCejI=;
	b=jT5GxHxe7Xo+5EPhWnXXxOWNk6fFwZqk9SpxJ3P7iquuKTmuyZ3QLneG/Y1LT+vi5WLCh3
	RReGKFhyVarg6htlkXlXVuKU0i2uChDpkcfAfhjLI4FN4OZBl95IqNNk7Cnv/S9UtCnWEe
	HY/1JvO7TcQCPQD7Dq3K+P/+g2oZTM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-KBIb2DqZM9K--xSYWvA79A-1; Wed, 26 Feb 2025 08:23:06 -0500
X-MC-Unique: KBIb2DqZM9K--xSYWvA79A-1
X-Mimecast-MFC-AGG-ID: KBIb2DqZM9K--xSYWvA79A_1740576186
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f20b530dfso6806534f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576186; x=1741180986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjPK0xAhUMwvoTDKlkbg0/+uhvWrRoFGreGRAQOCejI=;
        b=IP70+nX79A60RpTyKtmxMW8FvFSkQMSbGXSAVYAerzX/e1h1jeyGNKhP6dnOsn4f6A
         dXqtsSKtxqbVy9prnHxPxJ0nItATou9q9bV8m7/m2r2rhQxZTPCfdDmHhTt2O5kU2w0m
         dUtA9Emw/uTruoEEWgsSdmHd/eKW4oUhr/FaEQ20Khgd+zcngA2QQNIiYVONx/Jddjbq
         jDyyPLCmYFwe+1Ztud/nYapmNyPPnQjyK+IyBFi0CyUGUtRMOlRuUCL3rcb/XTKPFeq/
         DqtRGh5pmAYhetJ/psqP+nxeahYmlPZc8xaRSth1aP84oDQPAVwaVTtC5g7o8VPQuT0i
         Opxw==
X-Gm-Message-State: AOJu0Yya1irhYXGxFEoAUhUW1jEj0r8CWSB+zQgSYu9wU7E+7tBY+dbo
	ql/hWB6ayEj7PppPDNc2FnATm031jqVZBacAzwYi3zcTrYv4PqLFtwhAVHfgrg2kKyn6AXw3QY4
	rfWi4qBFSmaxOF5+qx/jnr+8+tejO0H5m5LUHzv93MFFDrkCD71RyMfEMDPzfpSITZPU+nA66dh
	buJEIPnnMbDSgJEygwcBzIaXGuTcpmFzWorbwcIVG4n2YS
X-Gm-Gg: ASbGnctOW02NDOzzNVi4w+YBZI3DYGQ0e519hPkBDGHwh3B3PKS33SJPc66JT5y7BZg
	B5m5lh3WmT2qthHgkaxICFwh6pwgeTCmGO3olZdyDZ27suwmrPz4Ut+vgKeeFkcGufXvlnrKyy3
	VbafuiOmT0x6Q6kbtZU5vWQua0UyHk7CnzCG/OWLW5kCS4yAJD8vYNWVhgunBbwI4U/RhIVrjjR
	bLhMNgATEjpmm+0qw7aGNWWW5d7q78VZsnmMHoSxVqKzQNQvhN+uKH6h3VOzdW4BGQp6P3OgRAG
	WceeUBoza8tE7htzW4nNRsG1FzpaxOK/6N/1oTe2hB2iI65QNySvSj49LvM+VkJ6g8NToEZhcOW
	B
X-Received: by 2002:a5d:47c2:0:b0:38f:394f:d81 with SMTP id ffacd0b85a97d-38f7078453cmr15164342f8f.2.1740576185758;
        Wed, 26 Feb 2025 05:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5DqfQSz6+Y9W8USCBIUl1fQ02BbqBnpIn4TOEMuvpkG3OWGVNVeF9XVULbWYdy7YAqZOUzw==
X-Received: by 2002:a5d:47c2:0:b0:38f:394f:d81 with SMTP id ffacd0b85a97d-38f7078453cmr15164317f8f.2.1740576185369;
        Wed, 26 Feb 2025 05:23:05 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390cd86cc3csm5704848f8f.33.2025.02.26.05.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:23:04 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 4/5] mm/memory: document restore_exclusive_pte()
Date: Wed, 26 Feb 2025 14:22:56 +0100
Message-ID: <20250226132257.2826043-5-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226132257.2826043-1-david@redhat.com>
References: <20250226132257.2826043-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's document how this function is to be used, and why the folio lock
is involved.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 2a0b4dd858769..50a305d7efcb9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -718,6 +718,32 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+/**
+ * restore_exclusive_pte - Restore a device-exclusive entry
+ * @vma: VMA covering @address
+ * @folio: the mapped folio
+ * @page: the mapped folio page
+ * @address: the virtual address
+ * @ptep: pte pointer into the locked page table mapping the folio page
+ * @orig_pte: pte value at @ptep
+ *
+ * Restore a device-exclusive non-swap entry to an ordinary present pte.
+ *
+ * The folio and the page table must be locked, and MMU notifiers must have
+ * been called to invalidate any (exclusive) device mappings.
+ *
+ * Locking the folio makes sure that anybody who just converted the pte to
+ * a device-exclusive entry can map it into the device to make forward
+ * progress without others converting it back until the folio was unlocked.
+ *
+ * If the folio lock ever becomes an issue, we can stop relying on the folio
+ * lock; it might make some scenarios with heavy thrashing less likely to
+ * make forward progress, but these scenarios might not be valid use cases.
+ *
+ * Note that the folio lock does not protect against all cases of concurrent
+ * page table modifications (e.g., MADV_DONTNEED, mprotect), so device drivers
+ * must use MMU notifiers to sync against any concurrent changes.
+ */
 static void restore_exclusive_pte(struct vm_area_struct *vma,
 		struct folio *folio, struct page *page, unsigned long address,
 		pte_t *ptep, pte_t orig_pte)
-- 
2.48.1


