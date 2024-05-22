Return-Path: <linux-kernel+bounces-186249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E842D8CC1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EB1F21782
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85F8249A;
	Wed, 22 May 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWj6gAJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60513F42C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382647; cv=none; b=X0YLadc5H+qIZw+vCHs6tBm6UH6OYoS+kIpEmC1+g3Ez8XAedwn+F3VJ78CzW6gI0US9TWFf/TdiC0q30G0P6QwJhyV4RiadfNnMuO6fX+yYsTo6wh1s1FqqG3Fz2Q7NoY7RiYYNdPfXOkvPMCevdkDtiS+x8H86xKKB17nWvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382647; c=relaxed/simple;
	bh=7gZc1lemhEx1oyQ2ybmtLVTSnwoyms1w8WxZ4R/dFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io61QZYMUE2/ZAYjsDlmrnj8+ntK+nzFCA8Yz22kcWNIGcLC3NyE79C1Fu3rPtD7/uhFfx2zilDvqK2La++9OG9JV3eyCQsvtHDG3m8km22O+Z500Yd7BC7EjCvFTu1agkfz/DKTMzcOfta9jTQmke1VTehw4iyBL6ZD0noCj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWj6gAJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716382643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt4DlmVVsqb/QNq76vNlwwGXNiph41eusgcJK0KNhok=;
	b=UWj6gAJtHKV8q48z16ksk3WNFCaCwI0THTIbg6wAMhB+GwJf/bXCtDqVSiD3uAdxShmUC+
	adeDhMp8AbxY0MESE9pgx6IguK8UVLyJkW6kNdUX/BiWuvxhGVBQVY6fPAPVfjMtgV/XWd
	AfciP7/xlcb2paJod+PhOyJpmIRAwq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-66OPK548MCiiS05cIhsAWg-1; Wed, 22 May 2024 08:57:20 -0400
X-MC-Unique: 66OPK548MCiiS05cIhsAWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 905F7800169;
	Wed, 22 May 2024 12:57:19 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CCEC40C6CB7;
	Wed, 22 May 2024 12:57:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 3/3] mm/rmap: sanity check that zeropages are not passed to RMAP
Date: Wed, 22 May 2024 14:57:13 +0200
Message-ID: <20240522125713.775114-4-david@redhat.com>
In-Reply-To: <20240522125713.775114-1-david@redhat.com>
References: <20240522125713.775114-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Using insert_page() we might have previously ended up passing the zeropage
into rmap code. Make sure that won't happen again.

Note that we won't check the huge zeropage for now, which might still
end up in RMAP code.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7229b9baf20d..5cb0d419a1d7 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -200,6 +200,9 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
 	/* hugetlb folios are handled separately. */
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 
+	/* When (un)mapping zeropages, we should never touch ref+mapcount. */
+	VM_WARN_ON_FOLIO(is_zero_folio(folio), folio);
+
 	/*
 	 * TODO: we get driver-allocated folios that have nothing to do with
 	 * the rmap using vm_insert_page(); therefore, we cannot assume that
-- 
2.45.0


