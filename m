Return-Path: <linux-kernel+bounces-533950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE73A460A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE5A3B0D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8021D3C0;
	Wed, 26 Feb 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JguCOjuJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75521B9D5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576186; cv=none; b=HZrvtpEnxIXmxBEO9/KblXBUraiA5HYSrNSizd7TIONU/NGuCrBMCT688l4ORydFWZ36CQzTzoxRniK1pZjwYnOtBiRuf30Vg4s+m0yB501Npl6eRFFcpxK++2MHSqn7l+ricWEm4TIrjreHS2NH/Jt7r6K50LkvvxUdNXjV+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576186; c=relaxed/simple;
	bh=pEh/GEr2ugLHRSDwWQQUGis0JRuTDl3y04fgg4bL7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE5MjZIjwp97mzQ1466wiC8IzjHfQwjOjP6tiRskt/17S3OJeYtTJEPrSMErprPu+YOimPoy2/xUs1cinmWoYFypWznsSAlekT3UWnRKOVhW7AyV5ebU1KNpyJ0Poh9AKaI/oB27t13R3kVVLkjJ2zHElAOsZq0yoQLpCAp7nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JguCOjuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6orXFeJGAvu/Rrohb/dX/LYlUkQorCUoMUzPFZb2AU=;
	b=JguCOjuJWlTBkTWIaOu9sYLBEAE9tBFBVBbv5YmAf+RvbjmqXQ/qQVoZxaXWfYZ1xx0VB7
	m54bT1beQeX4Avc48+FP0BSax+hnlKCmb7lXgA7JVMQ1vxL8MoB4hKRpftKRQ5A4uqIpoq
	zVaS5kUWk4dZDP+fqVUCb/XOr6al3Bw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-RO3QIkfTPz2kyZ4YaHzAmA-1; Wed, 26 Feb 2025 08:23:02 -0500
X-MC-Unique: RO3QIkfTPz2kyZ4YaHzAmA-1
X-Mimecast-MFC-AGG-ID: RO3QIkfTPz2kyZ4YaHzAmA_1740576181
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so62318385e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576181; x=1741180981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6orXFeJGAvu/Rrohb/dX/LYlUkQorCUoMUzPFZb2AU=;
        b=VMLZS5OHbtOMqAxFQiOrTiHAk7ZxxdBBG9NYC2pY0KXGZIG3SKypD/UhvZIipPeFwp
         0w8mGa04H4ZSqXZD4rukojsVkohg3ao/toLa2YmFatise3sI6xdypF+ajuFR1/qyc0Wh
         J5znomGPqbH3HD9M0cemWUFMKhzDfwI3eXbQJeqslSqIqcMTEiSJ515oLgR0dLV1JGKR
         FZGT04yhrt+sZzW/2Z4SmYudyB2mX5zqhWWPv9oVgWyrXGuwlHpzZW10s4cc0SbCMtZX
         gMlauIDGkCX4vmof0EOHGMr6KBuyCT1Upg6mROEwLdZMNS1/LKFbM7dYHi6SSf+ueuoO
         78Ow==
X-Gm-Message-State: AOJu0YyTRE+fsAoYixHLX7wWM6g2athsWK40eiNKiwtaV8fFdVmMeX7s
	YE09M7Xrip/9FIknzgiwbMAUDP6GJ8aCqsJB/mBIIUeEzESkPSnbxuU3hLyFl5d/7zShvCIrIqI
	F/xSyKKRM5v1/zM29daYKrkNhKrFxHS5aNr54gjbR+/eCIepPTRLK1wUeDH1X1dw1yro2LiqAO3
	OxsxjzX3UvNZQI1hcGS9Lbco1q1xcIAoJxK5IjP7gAmNtU
X-Gm-Gg: ASbGnctU+4jfciu8yJfOw0EKFyoRe7L0On1SkrHv+G6D7hnJotq6EvLRfhpA/MUaKc+
	JIwdGa6ADKFtnQdyKeB7m6LFRoAHGWYhofaXk7T7faayVf3y/JEBHfgLpmFA/PyKFH5fB1SryfQ
	Y94LZzsFGDjA9lt94PtrI67ZdbJspXRxUOtDprSbyvZUEYvQwx26o7yXOAW3bM1wrcRpJquv/JP
	KevotuUK2VFD+HxKo9bAB79KcHBMPq2rsXh0zWbWLX0LoeFk64Fe9aolPVWlJ0M9mINbz9In3zC
	oSFm9UIO7xe6YRj51c3S44i53h//4wFKdh1D/8//KYrlo5NpYBk3KFzQr57i3bsm8oqPejPjgG1
	7
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr78452235e9.18.1740576181095;
        Wed, 26 Feb 2025 05:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTKTUVpjblmKPNOofPuJhCfQ+I0IhzFCw2t/VamjME4II9+wlbxcBhKnNzq4bwr4GFZqWn4g==
X-Received: by 2002:a05:600c:468b:b0:439:9eba:93bb with SMTP id 5b1f17b1804b1-43ab0f42a24mr78451845e9.18.1740576180695;
        Wed, 26 Feb 2025 05:23:00 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba543fdfsm21554525e9.31.2025.02.26.05.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:23:00 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/5] lib/test_hmm: make dmirror_atomic_map() consume a single page
Date: Wed, 26 Feb 2025 14:22:53 +0100
Message-ID: <20250226132257.2826043-2-david@redhat.com>
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

The caller now always passes a single page; let's simplify, and return
"0" on success.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/test_hmm.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 155b18cd9f2af..5b144bc5c4ec7 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -707,34 +707,23 @@ static int dmirror_check_atomic(struct dmirror *dmirror, unsigned long start,
 	return 0;
 }
 
-static int dmirror_atomic_map(unsigned long start, unsigned long end,
-			      struct page **pages, struct dmirror *dmirror)
+static int dmirror_atomic_map(unsigned long addr, struct page *page,
+		struct dmirror *dmirror)
 {
-	unsigned long pfn, mapped = 0;
-	int i;
+	void *entry;
 
 	/* Map the migrated pages into the device's page tables. */
 	mutex_lock(&dmirror->mutex);
 
-	for (i = 0, pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++, i++) {
-		void *entry;
-
-		if (!pages[i])
-			continue;
-
-		entry = pages[i];
-		entry = xa_tag_pointer(entry, DPT_XA_TAG_ATOMIC);
-		entry = xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
-		if (xa_is_err(entry)) {
-			mutex_unlock(&dmirror->mutex);
-			return xa_err(entry);
-		}
-
-		mapped++;
+	entry = xa_tag_pointer(page, DPT_XA_TAG_ATOMIC);
+	entry = xa_store(&dmirror->pt, addr >> PAGE_SHIFT, entry, GFP_ATOMIC);
+	if (xa_is_err(entry)) {
+		mutex_unlock(&dmirror->mutex);
+		return xa_err(entry);
 	}
 
 	mutex_unlock(&dmirror->mutex);
-	return mapped;
+	return 0;
 }
 
 static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
@@ -804,8 +793,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 			break;
 		}
 
-		ret = dmirror_atomic_map(addr, addr + PAGE_SIZE, &page, dmirror);
-		ret = ret == 1 ? 0 : -EBUSY;
+		ret = dmirror_atomic_map(addr, page, dmirror);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.48.1


