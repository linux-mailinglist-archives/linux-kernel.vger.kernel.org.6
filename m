Return-Path: <linux-kernel+bounces-278563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A854594B1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450B91F22A15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C8155325;
	Wed,  7 Aug 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4ljvSC3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CD154454
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065203; cv=none; b=AXIbGM0OFu1jaTlNXczs83nZpASUboDyacX+6ruRSxw3qdd7/c2xkjOUac2LCzWX9WEAXlo1DxWJAKRtpn2WnvlQI82EjGGMv16d0VwzSmza8tuNfDvPRuTF5mbtXu2bVgupWb+Pywn0RIW3bOV0gm+vmo5sjBEvhpDE9qIdBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065203; c=relaxed/simple;
	bh=pJYSobQgCbGeEJ6K4fKi3SLbD7lY8YwAC6x/neI0MLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLXwCWzPIIV7bIdepZPaHMhFWZMeyowIR/e+L7ukeSqZXc8eC7KuGrLhb+bCs3/S2iFCZhUaK87PgSFM1b7XrUskTo4safXVTe6kGaSzhHzqHzJiXjKCS/kv7yiqJNoWKJUOzaFZ5L8GMWB/7fjQVh14SfjX/t4rJHD7RNmpgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4ljvSC3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e3129851so2039935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065200; x=1723670000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TABaTPorFTuyc7X865Uymhaob0hV8HMM8m0h9GmtpBc=;
        b=Z4ljvSC3CRbsQ99InLrqhPDGF/ts7RSZGg81LMMMii0TeI7AhE0U0T1iLwgs01l4O1
         tv35p4O8H0Kzgw5ZV8qmvdsbkk9NWLUV1w3HIwqDx2VwH5oTkeWycxBULSprSi3rgStg
         2o7z2Y4hRdaYlwYcYvsmUes1zitBA8KcB8O5xWn5kMUiMjQVL3vCy+xSNBK1K6FcJ8fg
         mz4syhLVrywYIs12B0FxBkYZUsqA5Hi69IuppHXpiF4J6GATPSphpHL1Y2dx/YZI4Z1m
         RemLLaoJ0PsOEwXMY4eqhB9WMj+qtJ9TnD7U02h2ZZgTDbgCp5Gse0GGacC8DJiRGgyo
         bajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065200; x=1723670000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TABaTPorFTuyc7X865Uymhaob0hV8HMM8m0h9GmtpBc=;
        b=s4UwDvp9OKPVakNpGfxhqS/eUfkbYM9wiNLHzmWQXW4m+u7fS1iS5lCc62n990SMe1
         aBurdFnaPe/rc9daSXggA6yj0vj/rtGnsAtCGISuLNyvidEzBBpPAIO5CLKJvX7PSm42
         w87GA3gfdaLi0nRMXekZlnAwhDs574qJugk0EoKaXUKokFFgYRe6A1ObveIiif1C4kpV
         NNKokmJPFPFBGAoP50tGogTvLSTQde9fXG6CA1EjOcv3Nuts9LOuzQpRScvo0ciIBAWo
         OZKkpetbBbvf7ZyDCMtiElohln52ACW2KrPLDI0bvczz4lkrmumavZ76rk2Wyx7cxEdX
         Iz7w==
X-Forwarded-Encrypted: i=1; AJvYcCWhoguzn+oK+IsFYjFXInswg00HOyZyXg7IakEXTbMrbP1xTse65Nf7F9VoYDFnQqFo+abljVpr7IaxaTXtooZwdFlbKxO02j3mTHWb
X-Gm-Message-State: AOJu0YwPV+JH6U0BR1xQbKeDoX/gwVEgOr4uZcUceIF46itC/Kdlfmkp
	pBbeKMSkYDdZA6D+4zWKuBJnWueAGAdQPRY9S7pXPs/YBxSZEecN+jlfcgEc
X-Google-Smtp-Source: AGHT+IFwpdVWkcLwHGj5wvenjiZWg1uZyL3/Xq+7WmNiTsKHLsk0L9Hfuyl66r/yDQAjPrUMLYNMRg==
X-Received: by 2002:a05:600c:1914:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-4290ae03407mr303875e9.0.1723065200112;
        Wed, 07 Aug 2024 14:13:20 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:19 -0700 (PDT)
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
Subject: [PATCH v2 6/6] mm: Remove can_modify_mm()
Date: Wed,  7 Aug 2024 22:13:09 +0100
Message-ID: <20240807211309.2729719-7-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
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
index 3f9a5c17626..980b613b98c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1371,8 +1371,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 }
 
 
-bool can_modify_mm(struct mm_struct *mm, unsigned long start,
-		unsigned long end);
 bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
 #else
 static inline int can_do_mseal(unsigned long flags)
@@ -1380,12 +1378,6 @@ static inline int can_do_mseal(unsigned long flags)
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
index 6559242dd05..ef4b8a556f7 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -45,27 +45,6 @@ static bool is_ro_anon(struct vm_area_struct *vma)
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


