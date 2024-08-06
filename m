Return-Path: <linux-kernel+bounces-276937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C978949A32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630CE1C21714
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3698176240;
	Tue,  6 Aug 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Fso4eR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921D1741FB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979742; cv=none; b=dnQufy99PmskUZ+YNc4Sp37tpu1EWyNw6hs2C8sgr1RGN2Xw2sGd1eEiWmT8X4j3FoV07Hm9XfADshKgM2iOyEla+5QyY94JXKIAIiQBXF/z/blzB/vrdEYGnMdZJ97IqvSQ3KQNKKI8FZVNORGAP55YbDVUETtf2NYUFNNFRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979742; c=relaxed/simple;
	bh=L8FVdgmpHj6v4+7sau/HBf2TW5wo44A8IhxBSHeWcxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvPsnrEbzCbxw2fr1RGCYIpVZybkAq3pJ3+y0uRJNoD30GVzWJcQLtQRrKVy/zAG9Y4Kyo9NXd0Ml/9UugZwUIqIvsddWCMFkq3HUVpA6reVgTCbdjdVfsJDcrjZ+mIdGjoowKqmjCsbRF+g1TMzw/kUo1WWdIeJWp1IFB7QbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Fso4eR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367963ea053so728247f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979739; x=1723584539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8jkam3zkvOuQdb/UsojC3i3iLSf3z8ynwn24gT0otg=;
        b=i0Fso4eRw+J3JCxEKk+6Gdq8bEvMxCE+tf3pzeGQF0MAJe4wRLW3SiMJukfDB3yL4k
         eU3Y7AytCHVQPxgWoXNI1Qg/0GYr513U+eBifOJgLmRhRqjK/kcjB8ZV9nWfDkTrc1ql
         ahF6dV9yTAOtjpg1AzQ8zpsofbPPg+h3/ILDp/PkwFAmaSHBPmA0AN1H35FCcKOvLhF9
         R/QPaUsSsmc+zsxZggHI6dSzpvPQEJX+yFP8jsTugiF3gHsZZV+HCUBWjkarFymHf0JW
         38zRTIv6EMDhPPmmd4VInJJ6qHdKzXx0+eaTlZaqUdBHeVTpHJTCB/OiGQloL4j9Hyzo
         mkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979739; x=1723584539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8jkam3zkvOuQdb/UsojC3i3iLSf3z8ynwn24gT0otg=;
        b=HEDfe1QCWP9BwoeulUpyE6TLs7XUBjsrR19AkfqZzox4/rRQxFHLpAi1mnMYjbUYhw
         EpIpo9+H3K7j5cfHiVRrD7QufTE0DsRPfzi9PIwVqf3xNh9+fJ1yhKoWhkXrN/WQonrY
         2s4yUQrpOmXnPkOoRyen2H0VCWppf+N1nU78LVXOQCodLTFAq4+rt1R5jFyC2ZX9OD6x
         J82Cizd3krOL9fi+f8SW0Noa1O8u9nLMsmcBaeRwamU6fb9IaBZNBF+AHjcZiFjwZJeX
         xvzeFNZfthGuIDVXpMj4DKtRYL54rMdPWE7l9xG6PhrivsMhb2xSJFzsH/qV2m4W09El
         GMEA==
X-Forwarded-Encrypted: i=1; AJvYcCV5VLS37EKTHSYJHCequX/Qic8a3c63iNhziN1z5YqSpT0gca5eZhPPPBmVFzovH5GGmK+goMIFVWNEMXRi5y4VPtJMV/Y7lbIyKiC5
X-Gm-Message-State: AOJu0YzlBKUK3D6+adA3OwDSc75nc+nCbTmNzxALCzBsQD1lgiPYVo1s
	33U7UybEFKqT+aMfsXoWXhe/gZRuo0nUgpEogWXlMtFpijhJ9twf
X-Google-Smtp-Source: AGHT+IFVhNcJL1XwxIj73p08P6Puvj7uc+dGQgCKNGuIkxBKPnC+MtSj/wcc/Gg8PVOg+3Ww7u7Q+w==
X-Received: by 2002:a5d:63c9:0:b0:368:4e35:76f9 with SMTP id ffacd0b85a97d-36bbc136ddfmr11556658f8f.37.1722979738730;
        Tue, 06 Aug 2024 14:28:58 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:58 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 7/7] mm: Remove can_modify_mm()
Date: Tue,  6 Aug 2024 22:28:08 +0100
Message-ID: <20240806212808.1885309-8-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With no more users in the tree, we can finally remove can_modify_mm().

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h |  8 --------
 mm/mseal.c    | 21 ---------------------
 2 files changed, 29 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4b516618389..e4416f5da2f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1515,8 +1515,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 }
 
 
-bool can_modify_mm(struct mm_struct *mm, unsigned long start,
-		unsigned long end);
 bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
 #else
 static inline int can_do_mseal(unsigned long flags)
@@ -1524,12 +1522,6 @@ static inline int can_do_mseal(unsigned long flags)
 	return -EPERM;
 }
 
-static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
-		unsigned long end)
-{
-	return true;
-}
-
 static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 {
 	return true;
diff --git a/mm/mseal.c b/mm/mseal.c
index fdd1666344f..28cd17d7aaf 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -53,27 +53,6 @@ static bool is_ro_anon(struct vm_area_struct *vma)
 	return false;
 }
 
-/*
- * Check if the vmas of a memory range are allowed to be modified.
- * the memory ranger can have a gap (unallocated memory).
- * return true, if it is allowed.
- */
-bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
-{
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, start);
-
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end) {
-		if (unlikely(!can_modify_vma(vma)))
-			return false;
-	}
-
-	/* Allow by default. */
-	return true;
-}
-
 /*
  * Check if a vma is allowed to be modified by madvise.
  */
-- 
2.46.0


