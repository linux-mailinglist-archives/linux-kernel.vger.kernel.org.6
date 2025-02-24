Return-Path: <linux-kernel+bounces-529606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28CA428B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA23BBA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345A266B64;
	Mon, 24 Feb 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGOYcCRk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0299266599
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416191; cv=none; b=oaJ6fDOFLpBZqGRwbDhgajUDWns3s0HDjBquZHO6QJnq/MTq59W4x4TWlh2FWGajbEh3CCefadCvfIxCPVF5pOclrAeokpm0BDAfjfXa1Y0bdNmlYvX8btrPjvaRy7EahwdCu+naNwyVOi0vJR+/wdMhCQfrUtEwkl9YBPhzSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416191; c=relaxed/simple;
	bh=Ycu3g93agHZ5+lzaLOnuhINjqTNBvJJTMooJF9ouEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjJVMf7hp1DWB6suY2ZtQXFWaya/OVBfF9rELaeaJ86pPZJSC+Ps/QmHEUbKvQ4R8cv9SwF4MZcRt7NmDm0rj1U23hWbERo6OJaSo0ND6kjlKhwZy/x/h4YqGPbb2M5Bwk2PoboeeAixFzBqnOS8HubOgXVEnSK7bqZOBgqmsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGOYcCRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
	b=TGOYcCRk+oScdqIk+XREUk+dL5pqXUK8hLiCLIw05ba26RLYymupLksUFiuT4lotew3cSg
	r6FoLfP+nS7UZA7dvZ49O0sULwD09Hb4LFj88PXy4tRRCO7J2zyulfj9tjPp4dHHR2ja5p
	a5lcaoigxY2Xek6iOw0Vnkx1boRf6Jk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-SXR-YjzYOJqB09zPWAM6hA-1; Mon, 24 Feb 2025 11:56:25 -0500
X-MC-Unique: SXR-YjzYOJqB09zPWAM6hA-1
X-Mimecast-MFC-AGG-ID: SXR-YjzYOJqB09zPWAM6hA_1740416184
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so32900995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416184; x=1741020984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
        b=SwS7q9/j7gd+F9Yk3vWEm9DT0Isa1jd4kvyy+m4Hf98HRJKlxvR3Qv2lnB3yLvKM5K
         YvMbfVNSQt7CN5Q4E3cuQ2LfzGcHAVCy09i56cHy8HDv91OdMsLnXWPhOd6lCIAQfBHK
         ostQo721jaZ/vtWjIWXcMXPTn1yGb/pI/ZNLfm4wzEhUQvd6RUp0LT8U7zc63X0W2k3v
         Ppv7TIfOpDw7u1/HLeRQs64MjD+6Me0oJMsiEQepkcSMB4fShjs39R8NlxGvFJNL6tJB
         yqm2hyYMKx/hP7qRLrkbV6C0LWzio+XQ1rFH7jCnlxkllWUGqyseZ5ReIIyjZ4m3CEHj
         wqwg==
X-Gm-Message-State: AOJu0Yy/UxcCJLj6NT3uswcYCr/pBc4guABdMK7PkiUfBaKrQ485G8nU
	T4QngEcgGi3E5EqkCwcBnr709Krxnm4WEAbddM0dhzUNnK7Ddd/5CkP9/zVrcuTKXFmZwZcWyuH
	upeUlNDGibAmD2ink1jY74FQSlRoRZWsUj/kObucFweenoH/S2QD+mJ7NE0SdXiV19S57yisuaF
	CvtgWj2JG2hNn92qvg7mixHpxtts0p/K3ROtqefZPvOXie
X-Gm-Gg: ASbGnct/YmTGiyzyohqM0zHD4eXKOS1dVcYntJWAjmf2nG3mIXfD8nLk6T869wLAIBm
	0ORipSMhB3U5NxkTc2ov9qMIk4LfQALtXbDn26U3jiuct7EVk67HgixSbX7x3D1F5oXrSQw9YyH
	cn7S3w9W4jSKz6Hiz8ucu9CRQNN+wxUIgnQbb+k++muJjnFylMatku/ysm2rcFbSJkfsWG/6Eb0
	QtlH6EEqpxjzNHDehbBOnapY3RzjKF6pBFPq/KHJvVzvjyk4uMp6PFm+cj97+VD+Vdkqkbmzhnq
	41t/CQIpQ+QD8XG5RYNJPp5M6IcAjGOQ0QB+tZ3Paw==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103615e9.9.1740416184393;
        Mon, 24 Feb 2025 08:56:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELVR15SfmZbX6a5/LWsD6f0rg6Y8hiw7+oMACeve7JZ9CA6HteUq/ZR57fRSUerpUCoh+bqg==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103135e9.9.1740416183869;
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b031b613sm111082365e9.33.2025.02.24.08.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
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
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 09/20] mm/rmap: abstract large mapcount operations for large folios (!hugetlb)
Date: Mon, 24 Feb 2025 17:55:51 +0100
Message-ID: <20250224165603.1434404-10-david@redhat.com>
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

Let's abstract the operations so we can extend these operations easily.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 32 ++++++++++++++++++++++++++++----
 mm/rmap.c            | 14 ++++++--------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e795610bade80..d1e888cc97a58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -173,6 +173,30 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
+static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
+		struct vm_area_struct *vma)
+{
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+}
+
+static inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_add(diff, &folio->_large_mapcount);
+}
+
+static inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_sub(diff, &folio->_large_mapcount);
+}
+
+#define folio_inc_large_mapcount(folio, vma) \
+	folio_add_large_mapcount(folio, 1, vma)
+#define folio_dec_large_mapcount(folio, vma) \
+	folio_sub_large_mapcount(folio, 1, vma)
+
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -352,12 +376,12 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 }
@@ -451,7 +475,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				ClearPageAnonExclusive(page);
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -461,7 +485,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 			ClearPageAnonExclusive(page);
 		}
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a7d023b02e0c..08846b7eced60 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1266,7 +1266,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
 			nr = first;
 
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -1290,7 +1290,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, vma);
 		break;
 	}
 	return nr;
@@ -1556,14 +1556,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 				SetPageAnonExclusive(page);
 		}
 
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, nr - 1);
+		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, 0);
+		folio_set_large_mapcount(folio, 1, vma);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
@@ -1665,7 +1663,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		atomic_sub(nr_pages, &folio->_large_mapcount);
+		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1678,7 +1676,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
-		atomic_dec(&folio->_large_mapcount);
+		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
-- 
2.48.1


