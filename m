Return-Path: <linux-kernel+bounces-245097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB092AE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93ED1C215A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295841C6C;
	Tue,  9 Jul 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbCI49Br"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4C139F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720492586; cv=none; b=IGncC7ATRjNhwyZQ4SXAoFo0SkENVGW2FIxOguLvo1+bUTyWvy42MouipCMXZQTvDWUdUhwYhCrowtfLSeu/aVa9R01Biu3SQYkJ3p37btXXg/7Rk22pEX9QCzXkGaajFjUEe5oKKkN0+1gzc4xNKldvQET6oBniYRxSQL1lFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720492586; c=relaxed/simple;
	bh=U2y9TXveVhBWBMuO0FZJzQvy2vIbAb4K24/hN1aH3vY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=felq3knaO9rOK8y6C8Y96oTtmmwE9Q6A4lU0Ed76Aa9XlM0XMAgsIfzfhGhEIPi1suzFm9jRDlvdjjagqM3QLjx8HqjiqjAIDQOGm+yI7YygrJEl+NuSXKJ08zQWaW9a09Ey8ncrOwRFsjwKguQqcm1bLs4UwTfl2zA2tzQPOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbCI49Br; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso6095765a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720492582; x=1721097382; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4tyZfQZh13n8WJqaNDrYKT2RH1lvdWq6QqkJMhvWhE=;
        b=CbCI49BrF5ArGaLUz8LpTIcOx+HnqOP+aJw/vWw6NVC8CsWBAATJHXAGnA9ztVqGn1
         0PyLAqY3nhjjYZqO1PQGVhhr5vRMqyUlNnk40JSgv6R/TspoduPwnrUaEOaxC77dz1RO
         boGstXHX7w1KYFZGL0ogROEP0wim42D9SXG8RAZb1GJwmLJSt3BGseWwTXVSiT8k6gYn
         1qzBVrYZqyfxcFKxRDNwKz2hXpGE7rF0guyho58y5+IcC3712j3wDoG8hq1HJE3V+9nF
         hhFiOR9eR9pZZENbAQ+9eRrHYZDYGszIIwz2W5YvGeOpeSYYLhvUwNcUNlBlrILh+iPT
         7u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720492582; x=1721097382;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4tyZfQZh13n8WJqaNDrYKT2RH1lvdWq6QqkJMhvWhE=;
        b=HIOoAUuyvvX9cqwVuEFZ32OMlXl18cw6+DyMQYz5Bs24USJD/oqyxhGZYlLsZtgu4z
         y1He0pMJ5Mz1lRepBV6Q2VIme4/UK68bdJ5PGHPtP8YhL/udXvsLSxbcj2Nb0WO9zHZA
         SOq3FD+atL4uenkNTBYUQZM+i8aciVooOcqlRRo+Oy2yn+OUEYfpVhjNF+OxjeSwY7A5
         wCap/aIItueGp5IljkJ1bzEgbF0R/CV0ILuz0c0Ux8ohd/gLfGYOkMu26X1YHrRXHjvg
         p3k3YI0BdmjPw96fUoUkmBz4sNy3Mpe8nsd4f5ku1Yk1GJEMmlwGVEMMcnO43j68iaNM
         zA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3WPuPG+KtZWbcH3om8SHYosP2SOtLN8hrQOLTBe9i7duRvnC3JoeSJIxq3UTjxmKXVBhJxQWcU571OHfFvo88xM5rfyFtqBGIwyas
X-Gm-Message-State: AOJu0Yz4+DQRsoCjYfB8Wn/AcS0pWPGEmIBuyNJYWdW97UBap72NBrT6
	MWvIduxlKmAb4HgrOANSAGPdMg/XbWFEg9mbKIjfQ9GzxZyyaAd0
X-Google-Smtp-Source: AGHT+IFIX/IbRXxrlYwyIgLKfOuUr+XDE9CmJ5stAxyz6jREZ2FOOXNBpDGe4TNlg6VoOPuhPSALGA==
X-Received: by 2002:a05:6402:33d8:b0:58c:f5bd:eb65 with SMTP id 4fb4d7f45d1cf-594bb674df7mr651675a12.22.1720492582055;
        Mon, 08 Jul 2024 19:36:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bba54ab2sm510868a12.3.2024.07.08.19.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2024 19:36:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	tandersen@netflix.com,
	mjguzik@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 1/3] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
Date: Tue,  9 Jul 2024 02:36:07 +0000
Message-Id: <20240709023609.21332-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During bootup, system may need the number of free pages in the whole system
to do some calculation before all pages are freed to buddy system. Usually
this number is get from totalram_pages(). Since we plan to move the free
pages accounting in __free_pages_core(), this value may not represent
total free pages at the early stage, especially when
CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

Instead of using raw memblock api, let's introduce a new helper for user
to get the estimated number of free pages from memblock point of view.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v5: cleanup the stale name
v4: adjust comment per david's suggestion
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40c62aca36ec..aba7ed9f2531 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index e81fb68f7f88..ae8e58fc4e7f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1729,6 +1729,23 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+/**
+ * memblock_estimated_nr_free_pages - return estimated number of free pages
+ * from memblock point of view
+ *
+ * During bootup, subsystems might need a rough estimate of the number of free
+ * pages in the whole system, before precise numbers are available from the
+ * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
+ * obtained from the buddy might be very imprecise during bootup.
+ *
+ * Return:
+ * An estimated number of free pages from memblock point of view.
+ */
+unsigned long __init memblock_estimated_nr_free_pages(void)
+{
+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+}
+
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.34.1


