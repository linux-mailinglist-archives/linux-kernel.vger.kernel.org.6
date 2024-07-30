Return-Path: <linux-kernel+bounces-267543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D89412A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35082869C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FDC1A01B9;
	Tue, 30 Jul 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkmI6aSV"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519B19FA66;
	Tue, 30 Jul 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344055; cv=none; b=X3X8IuNowhY67BZZ/gz8wN6qAKF7I8O6CoVz2lZ7SGb7ohYUyctCYfmUHGqgR1Iyjd714QAqmtzOjwPjbwhcYyIGGmnrUrGJfY0Nk1s2i1B7x8Km77fYZWqQyzZfY6cqZN62ejnVChcSpQG/cPGTwNXgPJ5wKNQcdyCRGBBgplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344055; c=relaxed/simple;
	bh=6uE4BoGPX5yYJngTBOVqCfxOgacSJJWc/oHx1yQpmKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwTNZys+dn0H/e27p2jaKS5kBwo3PrJPLg/iMlj3Mjd4Fl3QuoxawzV/7rLdK7jtJXZNrVGKRf2ti6qXm9wLIc28DedSpPJV1v+nS/lflmrNUv1SkqheBa/Q2jRlWgm3FE9kL0CIZxeF/Jw9ksuchO+2wHaqvmAEx9bTm8Bke9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkmI6aSV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1e0ff6871so266750185a.2;
        Tue, 30 Jul 2024 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344053; x=1722948853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktt9C/EJSJHB77GbE72Wr4Bnix41Ywh1hlDOhut1uLE=;
        b=HkmI6aSVBrZm453xQXGDa+5JmVA+TyGerX1YQPc7vP2dhXG8hL9C3xS3hB8vWJcefX
         DStO/mDaB6zSlAk6qBPcIyOnNXLOBNAAFuXSfLBm46b9mWLazkhx86XX6TU4bWF1vOsf
         0wPLbgrTdYbBDz3bQT4X3+01juyh9j/ZCdBgqobSt15CJ9ko11PJdgzV4Djwl1XTVQ+h
         9BwLLRaBcXpHQLCWBCNFltk0tLgtG1DAy+tV7afm2glCfEz8lYpksuHKWA2/pkn+Buna
         OG7s0r3A2zz0A0d//uW+oBCqxjV1JVsGtwrttGJpTnyLqqllZOAANNPqzCJ2oV7KcnDz
         OOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344053; x=1722948853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ktt9C/EJSJHB77GbE72Wr4Bnix41Ywh1hlDOhut1uLE=;
        b=ACBKT6+uYCRi/u7tuzB8Dr5KX8o9sif8Tpcu+BP/8cxbB67z8uayvh4s4bB1AUlNmw
         CcSyLfiQEfk/6vNCLziUx+H55iv366JfDZTmIkYllw2R0A/3X8fgkrEQ3LZxiHxLrCgx
         sGoHutkXu1rtw+I+LJMVAlKsy4x76erCA3dEPH8tX6GjzBWtc62JLlufArWLlVoT8i7T
         tYqglTosk7E6FYa5OEf3h2Uv0smGUlw3baRC/Xg0aobAPyqvV1kMcbbxssd6j1gc80M5
         aNYRBQ4h9xqXPUVbqZ0oLKK1C2e46zgshi1EQPmyQgAioxFi+aP6jTg/Q1X6T7cPM6vQ
         sGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUECjU/MGM6tD/IuYE2zD5KvEUJYrz/qsWtoNPiRPRnVxnrCk+8onfuEoiUh41I70JdJ42tQMqCfFsf3UiprB9++YHF5iIbD88kHGe7UXJ38BQGCV21ooUix9zQhodCuiPYCJunE5e0
X-Gm-Message-State: AOJu0YzGdtHK4qaMnhffGV6ztv1R/s+KgYJQO9rQ4QvftWwrHQQThFx5
	jAeXCX6ucsi1dkjn0gvirSVS0fI49hm994lDrHZ/PBip1o5gP3g9
X-Google-Smtp-Source: AGHT+IGs+7p/NLEKs6R6CF0jeACef2MQxZrB+Zf+vdpZds2BGZMJaXfelQzjq7hVci+EokgCJHDthQ==
X-Received: by 2002:a05:620a:4496:b0:79f:dce:76c7 with SMTP id af79cd13be357-7a1e5302964mr1165797885a.68.1722344053350;
        Tue, 30 Jul 2024 05:54:13 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8171e52sm49968221cf.42.2024.07.30.05.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:13 -0700 (PDT)
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
Subject: [PATCH 3/6] mm: free zapped tail pages when splitting isolated thp
Date: Tue, 30 Jul 2024 13:46:00 +0100
Message-ID: <20240730125346.1580150-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
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
---
 mm/huge_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0167dc27e365..76a3b6a2b796 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2923,6 +2923,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
+	LIST_HEAD(pages_to_free);
+	int nr_pages_to_free = 0;
 
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, order, new_order);
@@ -3007,6 +3009,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		if (subpage == page)
 			continue;
 		folio_unlock(new_folio);
+		/*
+		 * If a tail page has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * tail page was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && page_ref_freeze(subpage, 2)) {
+			VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
+			VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
+			VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
+
+			ClearPageActive(subpage);
+			ClearPageUnevictable(subpage);
+			list_move(&subpage->lru, &pages_to_free);
+			nr_pages_to_free++;
+			continue;
+		}
 
 		/*
 		 * Subpages may be freed if there wasn't any mapping
@@ -3017,6 +3037,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		free_page_and_swap_cache(subpage);
 	}
+
+	if (!nr_pages_to_free)
+		return;
+
+	mem_cgroup_uncharge_list(&pages_to_free);
+	free_unref_page_list(&pages_to_free);
 }
 
 /* Racy check whether the huge page can be split */
-- 
2.43.0


