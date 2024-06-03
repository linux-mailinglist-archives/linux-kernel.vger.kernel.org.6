Return-Path: <linux-kernel+bounces-198574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333988D7A77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5D81F214D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D36EAE6;
	Mon,  3 Jun 2024 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="negNszjJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56778BE55
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385508; cv=none; b=oXFRi+IBaf11tNTLqzletabeUhc2nIIi0LurDk9+sHBvOcj8YAfEXkvqN38nA2XZBs5QD2d51EFg/DJvgnbv9hMNb/vEi4ocn1q3HCgbru40N93NAyl0ZOmX6cv1dRbeMpxorb1s27lVh22u/72kJt2QlqOCN0Tl+WB4IuwKoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385508; c=relaxed/simple;
	bh=vMM4le4I/Rh6HCtDPBkC0QTwy5cG+JRqSBCvYNdg4Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pnoxtRYZXEC+p4NYskhoWwLDJ+CuKdn2QjR0q8/WI3ByQHm2dxy1sWBz57Cgyqpd7lmm7066apFaCda3aNKEjiRUae669uCQwTLEUjQEQbNSvm0J+FfiGoryVa1zAPEtfyc8kJXv6xXuv6CG/Hb/3YZtDF32vIuUYgtB0cjqFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=negNszjJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f630e35a01so21581815ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717385507; x=1717990307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnXzlpt+ewq8VcN12LI23XP9wCUpW3QP7SwmLBsuIIs=;
        b=negNszjJx5cuRAW50M8dEjF2hm+EyD77DDiLY/NNjxmwBtYqlcOcVxznH9PFz5YMDD
         U4Tk7GMi5JowhIrmTEETfJZ6qvoBWL+KbjupylaHeM7KpwzwSlvIPYuDAjoMLYRYqh5R
         o2GVKzjtCzCrTcojIS686ITrk0TBvuRch4tPhAfpIYhJzJV+Gz0IKcmrXbvpUuR78wuG
         /dgWmMUujiVaRwUlErTJ/QEIC+f3BQdpWnNhxgzSho20XfMSQOUeWjz33aR6ShJ/Dmxa
         TjmFQabWg0jZS1l5MQNWo8yFFHU2gwq/dpoNdYZzxhH8fudNN1pr5iD8NLvEaOLCC6VX
         43aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717385507; x=1717990307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnXzlpt+ewq8VcN12LI23XP9wCUpW3QP7SwmLBsuIIs=;
        b=iMQisOhg//uhqpDvxz9bB1kMNx1nTprmMo0Hvzp7rQxoPtn4LeBtw1h2YXIiRLyiTH
         xhpfGtpnP/WyqO3Flrp3VKayNaEj/ndyl9pn+T0qjE6OU/KBAlia/CljICJT4uv47G9o
         JaIKk+Vs4nU3K+YiFZRRPKMxduWiozh3bcKajDM/Kju1ilhqJ/erSIQ2dG+CAa/TCOMf
         Cz/wjXQxghsD6u0igoiOlxzDBFijNiYkENdWgV4tw+Pzi77vL80pRtSiL6pnJ9yyFLc7
         aXcn6MCwXnSEUrrBzPfIhGnX794zBZwSyUjZqJn5i2NT93VbMiS5Q+L8Or1NOZfZb9iT
         QVxw==
X-Forwarded-Encrypted: i=1; AJvYcCXrGuUQkZ/FLtx4Lyrzp7m5OZJDELV9MizPYNOO5XeWBGm/AbL9jud8LSgb50yRNTWGkDd/bMxQykDAIvrUAV2Kp5luoQ9lV9e+fgKj
X-Gm-Message-State: AOJu0Ywpl3PcheqM0leiaf5aA8ELh0HiKvf8Weh721b3W3jO/ZQ45nY8
	UKc07PfmBzIFYT+Xz7r3+/W+yWluCWwvMyRS/lS2IBtcC81pTXmj
X-Google-Smtp-Source: AGHT+IEKzX/tqYS1avrxEP31ld9oCkHDAefsyiUM5IBHFIPplNgcj6wzYu7/aa2RlIzfrp+zBiaX5A==
X-Received: by 2002:a17:902:f689:b0:1f6:7e02:6af2 with SMTP id d9443c01a7336-1f67e026dfbmr16656045ad.22.1717385506595;
        Sun, 02 Jun 2024 20:31:46 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::3038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235f88dsm54568635ad.88.2024.06.02.20.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 20:31:46 -0700 (PDT)
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
Date: Mon,  3 Jun 2024 11:31:17 +0800
Message-Id: <20240603033118.76457-1-ioworker0@gmail.com>
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

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/mlock.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cdea89d..1ae6232d38cf 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
 static inline unsigned int folio_mlock_step(struct folio *folio,
 		pte_t *pte, unsigned long addr, unsigned long end)
 {
-	unsigned int count, i, nr = folio_nr_pages(folio);
-	unsigned long pfn = folio_pfn(folio);
-	pte_t ptent = ptep_get(pte);
-
-	if (!folio_test_large(folio))
+	if (likely(!folio_test_large(folio)))
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
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	int max_nr = (end - addr) / PAGE_SIZE;
+	pte_t ptent = ptep_get(pte);
 
-	return i;
+	return folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags, NULL,
+			       NULL, NULL);
 }
 
 static inline bool allow_mlock_munlock(struct folio *folio,
-- 
2.33.1


