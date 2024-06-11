Return-Path: <linux-kernel+bounces-209144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D0902DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA1281499
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A38488;
	Tue, 11 Jun 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Beb2hWCG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D4BA46
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067876; cv=none; b=kWKm8Nshy9tO0+sAcMy+DbAnSn/dMLon0ZzaCOC+PcmGfBra9oP7bivxHx7UtCC1mas0dsoIeBt/vsa5Pil8XVg01dsJ7M8uAvMMmZQvwpa7ktTbBpnVQAmR7VZTv9dnJPqADcbEY6eeK8qJ0BqQZ15j3etvmkNWzsBcFbMDy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067876; c=relaxed/simple;
	bh=Kqs5bNdhSUR7SBKGPV75Vb3VNzhoHyhtP1ZoY9wzsWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USkz4twcitSSYD02rLJAI7zYTDRnZyRh3qfI5dm9ZEWsqbdvgPQ5gqp+Qwx2ihE7jRRdHrT00ix4JXZiryIpEl+pijvkx5jK9Ly4NhsrhA0kdxNARs4DPa71ehtEtyRRErA+0qBg7OsUuxEZ9yvBVi4QqDSrlCyZQ1iVeWb3wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Beb2hWCG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70436048c25so1676036b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718067874; x=1718672674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/e1voOxQLnVD8oRgm9L6T4MRE4ZONIiEombO/Pd7l0=;
        b=Beb2hWCGaWEJcsT6NkwiEHipQ3GZMMwlG5P920P+lk+9b4+9ViE7tzP2s3HKA8/P+M
         /yZ40I54dVpKGKOs4T63C7RFDEPynkLmexZoBjDe+e2hS2tDHFXA8yhyPJDEzCYVXI0M
         DnPMhYlY540Pvgv4Cgfx3PUJUZKZhk5nqne9q789CPydwNJ8w8ii0wNzPNHLR2JFveKr
         0mB1dPd7QJoiV9ppEx9gUbcDPJbPRHeEKasZC051Ca7ZY1fGZWmezW3WQr6HTOQm9mFK
         8MfnaNDdt2xUBv2TV3vMwIQWyZ2rUPd+je0kdF3NdWVe5/oeFZgPLHUPsi+1xr37Whvq
         fRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067874; x=1718672674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/e1voOxQLnVD8oRgm9L6T4MRE4ZONIiEombO/Pd7l0=;
        b=VKTsRqbJu+F9Cc3Vqio9Xkchngtyq3YYyxhMXl1Be/hQsiDDGuwhiNzsZVZfrk9XLh
         JueZGOZu5FUgtiZT26UYbUKjOtRNfI8olKoreOZtTsTIHj2LFJnm+sRdhyOwtzccMttB
         B90ANJzAUy6dJFDyBlpM1a68n/wZ0lkTu63Zvq9R6dzpBrexRAHBwgZ+pp2gsGLQjaOU
         hymaJLyuWphFb3oqNuoNcsPMAhZOrtBSSU64i4jtPxATH59Dqk1fZDUItyRZdnZhfX9q
         JSLq+KLza9A2IvStgsDFWfng86vaLDRyN3Oo70bMWTfigG4Lw6KQAGyvJAdPkPOodyYL
         9vgg==
X-Forwarded-Encrypted: i=1; AJvYcCXBpOo6nsPYkJhEvn4WIHYgWFoV+QSeDDlpGRk2crq2X0UqRxATQjlYQo89o/8faaiurDT3gNo2ncHiQyYs5SXArQC2/OuItCxCbzhF
X-Gm-Message-State: AOJu0Yy75kd/F3zP5ImArXeXjJoL5ZCmAeQG5Ki1Dt5qzMclsHti6csA
	CAiiYJ6j/JxoEKqT8NA13cXwi8wtFrRX3U93DlrsN253KrOr+jyS
X-Google-Smtp-Source: AGHT+IFiG0Bki8T01+0oqaiEQJxC+MT42/SLLey1eFmNRn2EjSlxQmSPt8ZWivilxFsnLAYY4kbI/w==
X-Received: by 2002:a05:6a20:6a20:b0:1b5:cf26:ecfd with SMTP id adf61e73a8af0-1b5cf2704e2mr7248815637.24.1718067873837;
        Mon, 10 Jun 2024 18:04:33 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70410b976a9sm6153772b3a.147.2024.06.10.18.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 18:04:33 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com,
	fengwei.yin@intel.com,
	ying.huang@intel.com,
	libang.li@antgroup.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
Date: Tue, 11 Jun 2024 09:04:18 +0800
Message-Id: <20240611010418.70797-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make folio_mlock_step() simply a wrapper around folio_pte_batch(),
which will greatly reduce the cost of ptep_get() when scanning a range of
contptes.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
v2 -> v3:
 - Rebased to mm/mm-unstable
 - https://lore.kernel.org/linux-mm/20240603140745.83880-1-ioworker0@gmail.com/
v1 -> v2:
 - Remove the likely() hint (per Matthew)
 - Keep type declarations at the beginning of the function (per Matthew)
 - Make a minimum change (per Barry)
 - Pick RB from Baolin - thanks!
 - Pick AB from David - thanks!
 - https://lore.kernel.org/linux-mm/20240603033118.76457-1-ioworker0@gmail.com/

 mm/mlock.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cdea89d..52d6e401ad67 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
 static inline unsigned int folio_mlock_step(struct folio *folio,
 		pte_t *pte, unsigned long addr, unsigned long end)
 {
-	unsigned int count, i, nr = folio_nr_pages(folio);
-	unsigned long pfn = folio_pfn(folio);
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	unsigned int count = (end - addr) >> PAGE_SHIFT;
 	pte_t ptent = ptep_get(pte);
 
 	if (!folio_test_large(folio))
 		return 1;
 
-	count = pfn + nr - pte_pfn(ptent);
-	count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
-
-	for (i = 0; i < count; i++, pte++) {
-		pte_t entry = ptep_get(pte);
-
-		if (!pte_present(entry))
-			break;
-		if (pte_pfn(entry) - pfn >= nr)
-			break;
-	}
-
-	return i;
+	return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags, NULL,
+			       NULL, NULL);
 }
 
 static inline bool allow_mlock_munlock(struct folio *folio,
-- 
2.33.1


