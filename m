Return-Path: <linux-kernel+bounces-318075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346A96E806
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3715E284C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737D34CC4;
	Fri,  6 Sep 2024 03:11:57 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8128379
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592317; cv=none; b=dIIw2k2Vjpawj9jACir44Mh7HjKx352ZjfC52MXY7F3Q2rzMzN7NAyI4wxV+lkjlTsl/r2tN8Sw29AFH56qCfw0kZKHwmGu/EHhE4lfnbGOAEaDmi3BY6K7hYut/FBZda1jCEvuprdnyI2CCOvXQ5x1GdlRRcQEyD5by3GgrCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592317; c=relaxed/simple;
	bh=hYbpknmZv1Wf5kY87MzCjpa2/VIs0v7yv/FVVUOCUGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWS4BmFH4p2RvSYV2UdPuCeO93eOVMBUysYIuNwdEwAl9h7rSaJ49QqbZYmb9CxfEfqXwyKcoYmBXFr7uv1T5o5FLnn7l59idH6lQvj7ogKO1PF48kSKmR78UZoc4nTJKtEHXKxv1EtFoZBbelyaMPEMZtq2PM9dbg2Ynuz/Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093b53f315so605084a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725592315; x=1726197115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHWxSRmAIq5y+t+Bsnw0e3+Xv51/57FXG9eUtKPq2dg=;
        b=LuxKr8BJaEQksB7FYjeL7EaeaeJ4Qoti9CCxV/kndk9Zt+BwTdlIertBq0/N5WWeYM
         fFciD8LEhgil6N3XAje7lqq1feCT4PI/rFCSNV3nU1fBviLc61kitF6sjnO0KV3nJXy3
         3aqN/uKcV33ffxiIZqNaYioMNlXPtD5qLeISGiiOoi2m8FHqpfwB7DHTEJ0e+fxbzqRS
         OImgx2rWAyvLkYHFS2K3sLS/zWf90qo3yKwT/5+FhPckEL9nqDvtFKrK1FLBCR/pm1sI
         fpnhaevZeWJverOjw1qN9gKqxWcEdhnnAHKFQ7K2vK+CqtglfMtx6K/vd7kWmFZctpVq
         2lUA==
X-Forwarded-Encrypted: i=1; AJvYcCV6KkFyavlHPwMlo/Bf3NUJn1Wscbs7NFfxRsOHCofZIJRLVJAE0eH5yXZID2zdWDV2qAGjn7Ag5udOh2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuuX5FRPif4g4kQVDypYOHq4AcRi3n4KWEi0yeFlDCm/lyBxD
	dgIJUtgbeeKGpKV5tsq6ZDFlxwEWHD153Z4ejr7ObXKb3yD5CWmd
X-Google-Smtp-Source: AGHT+IGiIJOqPOM3+WDLMgLiBuKcw5W6p2Wxvkgw77bXyGx4kYgLOl7X9U6U2rRwJoGlwAqNa/wNNA==
X-Received: by 2002:a05:6830:61c3:b0:709:3585:fd7e with SMTP id 46e09a7af769-70f5c3d48e5mr31144675a34.12.1725592314754;
        Thu, 05 Sep 2024 20:11:54 -0700 (PDT)
Received: from snowbird.attlocal.net ([2600:1700:7c10:db60:551c:dde1:25ee:9a04])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd84e73sm3425244a12.11.2024.09.05.20.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 20:11:54 -0700 (PDT)
From: Dennis Zhou <dennis@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] percpu: fix data race with pcpu_nr_empty_pop_pages
Date: Thu,  5 Sep 2024 20:11:51 -0700
Message-ID: <20240906031151.80719-1-dennis@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the data race by moving the read to be behind the pcpu_lock. This
is okay because the code (initially) above it will not increase the
empty populated page count because it is populating backing pages that
already have allocations served out of them.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407191651.f24e499d-oliver.sang@intel.com
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..325fb8412e90 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 area_found:
 	pcpu_stats_area_alloc(chunk, size);
+
+	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+		pcpu_schedule_balance_work();
+
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	/* populate if not all pages are already there */
@@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
-		pcpu_schedule_balance_work();
-
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
-- 
2.43.0


