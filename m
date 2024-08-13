Return-Path: <linux-kernel+bounces-284712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C867495045B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2271C2182E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323B199385;
	Tue, 13 Aug 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwf4KWn0"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EA13B791;
	Tue, 13 Aug 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550627; cv=none; b=g+eQgi+W685/5D17QR0RinCNCTry3Sza8JpkGjxdmkS2O4TsO8MoEvsZwd0aYpadutvraCk3Uw1ARlsZvWPMLgG4bvYkkujjDXfeiRCgb9HIgfL3ij/15MKZ17zNnyFHavmQmfAcHJIWYt5Awj4tEiapnz+Q+saIDCPE0+5UFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550627; c=relaxed/simple;
	bh=s5vMsF1VpXoaCzaOaeRvQSso1xq/xJJHbkJDTudTxGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOhmY8jEc1697xBP9kumjEXaPSWCmM7NANo8r+Bt/MfDmqylOR7G9ViL90GhMiLiV5NJu1Qpzr623w6RgYuITZyiQfUg+RyNeiugM0PDZf3MWkxmeazJmng4s4Y44te4zmLdH+CZvNFvTR5oIt2DXIpyq6MGigAQP/WYztguzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwf4KWn0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so352633385a.2;
        Tue, 13 Aug 2024 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550624; x=1724155424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tRn9HldKKoz64Z505xjl60T+jy+qH2RDb/CoWbJ5vM=;
        b=bwf4KWn0PCeT+OKmmEmEIKjj5GjuxrD6HmD6YMgCIN0VXChCMe67g4cLLQNFRHlp3V
         JnlDr8gDEgFD58cleVAUOgmTidpRCLUEcDSHHMXFEnDO1SFEb+QsCB3j015CtNbsSrpn
         Ga/GZ4n4UXCLt8+wa3+Omvb0voMNItsXtsi4XvJXSJu4bpa1wN1Ep6XjJm94NUw8jBxW
         fJ/94pcZARljWpMEg+OmTZP50OV1NcdP+ZTi1v9ulJFaJ73nPPwAwFyq2goAdT2jjIeq
         PsbIMboGUzcx91K3Ok83rkVLvglyj8o+QmAWNd365FzH73Jolb7Q26dCR0Xy5CaZYmyn
         YTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550624; x=1724155424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tRn9HldKKoz64Z505xjl60T+jy+qH2RDb/CoWbJ5vM=;
        b=BQyfVnNSE4ois3xHyDPNmboS5OoMOqFZxgVeVHVPJ6vcCBlpaOXzW74d1X1lRNcOdC
         qJpVBAjIoqfdO4l96kgcFJP13sR1LUzJ6mpCCYbadBOm2C8I/pPRLtq64SSlV8rnS6OB
         TbToMktEXfZC7bSpTwgttb3yKkhpYBY6yowdL3x6WoFH0D1ia3EkKtFXxAaMHEkH2O4q
         eTVQyrNfiq4Myh0ceBhvrxXh0ZJNhvyEmeDDvuMB8HwHohKvW8sSoI7bT7qB9x+3iE2S
         hRKjLyWC+FWx0m7xIlHwSiY0e1IRjAbdNhhBysadm70Q/HFbQZD2xdnjcXmLarzowK0w
         XZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC8qbZyW3NzTZH1ftMZumJo4gKM1lt1yA5IcmqMBDNjxOn8v8xsTTCWEVobXLnOp9NqDFZYTqlTdnm1bVX@vger.kernel.org, AJvYcCUFebqUBWJm4hpLlc48AI4DWRnE7QwD03xvLhnMB4RfmaGm6Y3jUmq/9z/39pKfG4TWzWIRgVReWAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG08sta8IQB/SyIGSSFCp6/jVhE6koWOsXYFUwiWpG4xm1KZq
	CuOH41RZ7DdQhvkyOTXbWkURXQwOSaeiRkf2ExNT+Vy6PJUloeq8GpMSI1Pj1Aw=
X-Google-Smtp-Source: AGHT+IHCyk5c5SE6e3z0DoyqupXKxHAXubnY9Py1uh22TPysRE3LzZi4VhhYcHmcgCKHwTje7P8Lig==
X-Received: by 2002:a05:620a:4091:b0:79d:9102:554a with SMTP id af79cd13be357-7a4e15011femr407319085a.14.1723550624171;
        Tue, 13 Aug 2024 05:03:44 -0700 (PDT)
Received: from localhost (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c26ec58sm31235081cf.60.2024.08.13.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:43 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 1/6] mm: free zapped tail pages when splitting isolated thp
Date: Tue, 13 Aug 2024 13:02:44 +0100
Message-ID: <20240813120328.1275952-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

If a tail page has only two references left, one inherited from the
isolation of its head and the other from lru_add_page_tail() which we
are about to drop, it means this tail page was concurrently zapped.
Then we can safely free it and save page reclaim or migration the
trouble of trying it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/huge_memory.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04ee8abd6475..85a424e954be 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3059,7 +3059,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
+	struct folio_batch free_folios;
 
+	folio_batch_init(&free_folios);
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, order, new_order);
 
@@ -3143,6 +3145,26 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		if (subpage == page)
 			continue;
 		folio_unlock(new_folio);
+		/*
+		 * If a folio has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * folio was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && folio_ref_freeze(new_folio, 2)) {
+			VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
+
+			folio_clear_active(new_folio);
+			folio_clear_unevictable(new_folio);
+			if (!folio_batch_add(&free_folios, folio)) {
+				mem_cgroup_uncharge_folios(&free_folios);
+				free_unref_folios(&free_folios);
+			}
+			continue;
+		}
 
 		/*
 		 * Subpages may be freed if there wasn't any mapping
@@ -3153,6 +3175,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		free_page_and_swap_cache(subpage);
 	}
+
+	if (free_folios.nr) {
+		mem_cgroup_uncharge_folios(&free_folios);
+		free_unref_folios(&free_folios);
+	}
 }
 
 /* Racy check whether the huge page can be split */
-- 
2.43.5


