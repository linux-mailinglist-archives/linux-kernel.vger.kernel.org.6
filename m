Return-Path: <linux-kernel+bounces-529598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962AA42873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC007A6EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893526463B;
	Mon, 24 Feb 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cha1gSw3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7926159A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416174; cv=none; b=q9UrgG7QC7776Tp3Jzhg8uxBf/JrtCE4UsWR3idP2DjljftNhRktgrNZxBzRDnA3mrzrdsUkB3gr8V6SvSuqh0rFSq+Au2Kwv5Wrc25tX+9CAz80v6mEwATMbMQDjWqhrZQKUBzNy814o5CzqZSuoMrTs0So3y3J96WmqaiK0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416174; c=relaxed/simple;
	bh=VmpdZSRRUc/hbRQ4rkKLLuRh8r6J0srT0ICzqEnE21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+tbuL7/DTDnNbn+KoFHFK/LKkudNPWIFH+Zm5g2uDDOIwsnxwtDfrMzW6BM9O9jBgPJVJCu2DAzto9ohHrzuntMRdcyDMCHPYto9fiKKZh3nlG+FUtpaA3fdlF2I6u095CrTwJIVPc1RTLF01x8iuBOiatUOGy4sS9U40DkWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cha1gSw3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yy4w/XZlsv8uxY4mojETBma8CfgELpSYNnd4DKCaPQ=;
	b=cha1gSw3Kiv8Yl+3JboraN1PwPJ2OlR6kRiZz4R8DoHXA8GuLUBzxxGnbEintqA7onK5zB
	y7jczqnG/Qhmqr8IQ0Vi1PpCqE1GWcJsRd7uBY5sRlu6rohkizUhGH8A72pfqfI0JihEw4
	CuAnDbV0iRbFTEsTDzPGtC5/Q1oiK6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-lT5u7ZiNNJe_VyYC6djmTw-1; Mon, 24 Feb 2025 11:56:10 -0500
X-MC-Unique: lT5u7ZiNNJe_VyYC6djmTw-1
X-Mimecast-MFC-AGG-ID: lT5u7ZiNNJe_VyYC6djmTw_1740416168
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso40222405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416168; x=1741020968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Yy4w/XZlsv8uxY4mojETBma8CfgELpSYNnd4DKCaPQ=;
        b=YAcgd9CU138lnoxPKqBwgKoCeYenqxbPJtYpdqvkYS317FiHhEf/rXV524gC3MNxDp
         Of5puFS/XEzIkwzLRvaY/5mCvCHzcn5He1xoUWZ7/ayskypJWyqwyQFIYmf2/IiXbana
         WDQVFYWwTZurvAEq+lRZtzf8LJiPRIDvrOhuAtVckBopdmLZvh9uIO8+yIOCT2PlF6Lz
         zQHP2BzFBRFMGlqSkXb3wLVyXUNnAcpDL+NN6WH+Tnmv3vGOiTPa6Ci+Z7N990FCBoZL
         NB3Tyspn59CA5bYWJwRBfjwKgPrZ+XrDvOMbl4XgaIAlS8STlWUuURsk5aaBNSSNsz+T
         u53A==
X-Gm-Message-State: AOJu0YwefqRfhuJF3VTl8HSv/oHwpysa8JbkTq0VvrsG167krbd5t57Y
	E3fPnW8r4gfVvBqfyfRpBczHCTjiNjMF5YwCPLby2mE2SXg58UzwXQ5/H0mdOwNBHmhYOGTRAH8
	5wdRY6Ge+Fp1GD/gorfpQgvhH9R32LAyK4H4y9Q7+mb0UPkbteLzaqPaGmouubUZCkkfOLRbOcg
	rYayWPJu7AohctLhInCf7R6D5lFwUkH6lj7DvleClyjugF
X-Gm-Gg: ASbGncsJ+j4FeypIUoq6oIeRcNXWW81spZpHmRBIuZBYOtsGvL3K6HShwL66/JUgers
	Eqvsfrs5HWuhzBPcP6r25UFhDrtB7wlzV91nl0RY5YNouMWuixWckf8Gl9qrHebMH5KcSvc879z
	rPX+biE10AOyl9I8B8631WFHCbvaiNyc5tfm/mEIMOPfy4gaHepG3+O2FNb4Fv9PMVEAgFetqI/
	jkvK5owAYr4SNBYfoio2aBPyJH5aTTQeAqm0oIjCf20eqfzjuZpLYKNd0ftIUWmgbi/7LDCxE6q
	bpFmobVE2qoVS2apSYIv3Akb2olBp2DFdn3qLL96Bw==
X-Received: by 2002:a05:6000:1ac7:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f6f0c4523mr13709717f8f.53.1740416167716;
        Mon, 24 Feb 2025 08:56:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrYsCtuTnI9EW4wn4ZrbygGJqAwQI73Wf+OvRO5jakiYr702W8tJwU3BfJXILKECpWzIC3lQ==
X-Received: by 2002:a05:6000:1ac7:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f6f0c4523mr13709656f8f.53.1740416167205;
        Mon, 24 Feb 2025 08:56:07 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259d5e92sm32611493f8f.66.2025.02.24.08.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:06 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Lance Yang <ioworker0@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon, 24 Feb 2025 17:55:43 +0100
Message-ID: <20250224165603.1434404-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Maybe in the future we'll have the order readily available for small and
large folios; in that case, folio_large_order() would simply translate to
folio_order().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d82feabbe44f8..d00214e22a174 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,6 +1194,11 @@ struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1207,7 +1212,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1223,7 +1228,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2139,7 +2144,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2164,7 +2169,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.48.1


