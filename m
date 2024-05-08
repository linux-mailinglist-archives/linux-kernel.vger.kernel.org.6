Return-Path: <linux-kernel+bounces-173908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E08C0770
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E73284453
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2713738DF2;
	Wed,  8 May 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4BoFNAy"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCB24B2F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208141; cv=none; b=As3iHRcbSTZZXP8xrKj7neekEV0Zpupwk9bz/h+yThp8AIoIOVWCqlkMxGeAXCqykVX58LlyWK77qeTGCS5KmtPLt0X39EQJxCQkVt5IAetXJX9US8BezYD8UfFYWzZitidRh9fa3W30UVZ6+5/rzOWtNBCtrDm8Lu3Bb2UF7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208141; c=relaxed/simple;
	bh=3JpFwQMSCq/cMZ/d8Z+jM59pDpM4EAcAV96a2sNlir4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia3unzJCIV6bVxRsvzi9x9diu7nS7kc6a8ykj/neBjkqz0ezvs/kFzUYlvRvJzT8HlroGJ+OaaKyn/mxpmpgSXt+V93tdGLz6UQ4+DOsSadlqZkPA1wdNLnjivJwAt8aaDO5+p5Ld4kaWKU62iHWIPUJnI8RY2xA2ZmgECBDpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4BoFNAy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b2b42b5126so266954a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715208139; x=1715812939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eTHILZ80XouT+1m3vAPlwsDJfF9Pcan8u7a91N/lZo=;
        b=l4BoFNAye3TxOi3+bsrpHuTGDehBVrrZcwM8fvFLdHhV123Ufsup69/yxIK7y5lN5B
         St8ySyP7oHrbYYplf51BkFHgAOr+TF+Mskw199ZiKuzsMuohF+dfHA+x1Wc4M+RJW1dI
         xnQLyBctHI8jgQvn3neE0H9zhjnWSH5/MSOPlEbviZytMT1jMrwTmmdFYgls3VZX06Zr
         DA29mLmDnEvr2vTljXHicF8DpehwnygtkKg3tn1ziQml9WNQ6dT0usGI7Cz4hcIwqD9C
         aVQRTT0rKw1ubfELnZRSzuX4Z6wh5FOlUOzpDcnK/CW4KnMmiR437YqQzSyDGR4RDRbt
         z+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208139; x=1715812939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eTHILZ80XouT+1m3vAPlwsDJfF9Pcan8u7a91N/lZo=;
        b=oPws+0W5pAY/4Yd4amvPsOfk8ABA4tUFjtRGFM39jYWPoYJggXtKR0bG0ciblC8sOs
         ZnL/BKMQm24d63HS2KjfUXa48cU+MwhVChKPE6nqneaUeEIXobfBAqkIRHcmfbZhknn2
         VGy4yxnboe7pY6AwaAdHtkof/orfCFTWDNAxcJbGOJ6yX+KK7fXEkCG2KNs7RovONbyF
         0JhdIUrefuvdXMu8Rt859p3Jyn04muD0x8qygi3uhBjKF/bXLTW00q+uYA5m5fN4I+5o
         8nmCuvZwpgPbu0r1Lt0fb4/l5E/zZs8Q7QQIvzWA0O2YEJo+LphP5pE73z4vQAOI2QkO
         8/1g==
X-Forwarded-Encrypted: i=1; AJvYcCUMdiNAY2RMCMiY+4QcvQyzDhfbPLZERWKCsMgCwzfPH1TF2Lfbe9DT6yJVx9COFB/agsvFCGgCNhOMUbnqejBp3Gtt1e1A6qfyT5Wu
X-Gm-Message-State: AOJu0YyHlk9vabxVSyQ4Zx4224NnUhnSr8LAjiVmLw4SD8ZGnZwTPLtd
	TVJT/4cDEhfIZ651M4U3ym4Enm/lR3lDenCjFpC7EeZpjYzNGao4
X-Google-Smtp-Source: AGHT+IHz0/iZAnfRiaUeJgoYtdpHEy5GFxUrXuxrhikbMPcC7Bwle7yCU/X9SrLM3+bghWb9T3SB5w==
X-Received: by 2002:a17:90a:ce94:b0:2b1:73f8:a013 with SMTP id 98e67ed59e1d1-2b61639d6b2mr3773903a91.2.1715208139383;
        Wed, 08 May 2024 15:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126b666sm102082a91.34.2024.05.08.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:42:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v4 5/6] mm: swap: make should_try_to_free_swap() support large-folio
Date: Thu,  9 May 2024 10:40:39 +1200
Message-Id: <20240508224040.190469-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508224040.190469-1-21cnbao@gmail.com>
References: <20240508224040.190469-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

The function should_try_to_free_swap() operates under the assumption
that swap-in always occurs at the normal page granularity,
i.e., folio_nr_pages() = 1. However, in reality, for large folios,
add_to_swap_cache() will invoke folio_ref_add(folio, nr).  To accommodate
large folio swap-in, this patch eliminates this assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b51c059af0b0..d9434df24d62 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3877,7 +3877,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


