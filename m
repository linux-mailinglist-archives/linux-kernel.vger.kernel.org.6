Return-Path: <linux-kernel+bounces-211319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90A904FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6CE1F2156A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA616E898;
	Wed, 12 Jun 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnDoTSHz"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C3A34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186485; cv=none; b=J+HEvAyYdZV1KH4M9ZWFIicS2fX5x88vhi4iLKueuViPfw9HNxef8ZqrjQ6zMGk7O02cKxnc+jh+YsmgYWItclC/hKeeTBXKs2ITJ2c78gWzIjrvHibBAWcCk6WJUPOuG7ZmgM3eI8xH6Kff/SvaGIYcOXBP85CgWRMPjfiTt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186485; c=relaxed/simple;
	bh=eONlZ4ZZXucitjMnx29p/sFsI36wtPsuca6/lJlt/38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqJEQhH79N7yjd3n4H4JrVyeX9sQZL4fBagmU+T3v8vTnJjfwqVhFERW2WW9UQ1Xx6gDkJVi9zNKcr9mroLZLyPU+iogAsrqvmOSh0MUHIIdkYGK+PNIGwDs/IskbgonexY3gKLNt4Vkrycb7RIvvStyKrtGSXGXTes6CEvvZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnDoTSHz; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a145e0bb2so75978977b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718186482; x=1718791282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhgKyJlD2vWJb9JL/Gw5nFT1XfWpW1UuHSEQpsWI+uY=;
        b=XnDoTSHzDOazf0Cr+V9I8mMKSOsvVBLPhgpYT6ViD/bhjLWFXRqhsEFJXgqlXT+epY
         r6gVp8CCwcXJ/rA66D6loL9PZiGXYPJVSzHmrogEmaDbyQhLAz3AvEjju/F0e9NHMmuS
         9uzs6DMUBWL3MiHp6T83ICLvym+NWoV1E2hKQIt3jCBrG7theFlLPkkKRZcP3E+QnMJ/
         88u/hMIG0c5hFQipdqpxK9YZM6LnxH2KtPIGL/l+xcKp93mL26k5No41CYHvdls3GzYR
         oFh2qAzV2ZMwtnAcCM0n0PohP5lFPhJyCkjRtu5LsCqMq4Ob9ZEr072nnbhuIBc459IW
         pOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718186482; x=1718791282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhgKyJlD2vWJb9JL/Gw5nFT1XfWpW1UuHSEQpsWI+uY=;
        b=BVOhnFmqv9NfWnH4Rp8cBlz9y6RjY5T/OyXdmfWQqzyU7toqdyS9dqTb0bNGssUARX
         eJbjx33cBepHyKongapHtjf7VHTsJ6M3k5itar7ucqPKcBXe6wM7MM64HXSvhfsOgIod
         HfG1PF6q0ADeQk+WTd7HEKgANuuRMskN3ryaA+sKkYuyXT9LMyB2GnWH4lKPi/ZeI1b0
         QvAHMyOhzaj35+ZQMx8H4YmODIfN0i8JDzIXydr9pDVCR+ookH7rBZVDVjZNvh+iAgcj
         0q46BAQVZODN+TkXGlFHcpy/jfPaXrNsAYfTx9n4pg5y3rdEZp9yF1f3a7bdua/jRvgD
         Ta1A==
X-Forwarded-Encrypted: i=1; AJvYcCUxGcG8uyVT8KQ/KE26D4BVhELWLGJeC6XZlNJ/boG7syf1eVMOTqNu2rZXDCFqx+CZXLoZj+nPjbxwYpU4gWEKt9bUYl0gsXqwPOHs
X-Gm-Message-State: AOJu0YxOFTTXrD3ERIrQaYhjtBghJM9cxkgyBNJ9eaMWFXSrFTgC+sPp
	f0IssYKl6KtQ2yNKRReygUstVhXtDPnB5iwg5GQTXfrtzPkUcJjOWIhsy3z1KWI=
X-Google-Smtp-Source: AGHT+IE4L0L47QVH3JJIqko79lJt0u2nUHCu1fn9GgPaUuT4L3KK3xB9cYvRMloLBM2cXbGS1VsgNw==
X-Received: by 2002:a0d:c285:0:b0:62f:4149:760f with SMTP id 00721157ae682-62fbd79c03bmr11770277b3.33.1718186482133;
        Wed, 12 Jun 2024 03:01:22 -0700 (PDT)
Received: from localhost (fwdproxy-ash-005.fbsv.net. [2a03:2880:20ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm45026816d6.3.2024.06.12.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 03:01:21 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev,
	willy@infradead.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH] mm: Do not start/end writeback for pages stored in zswap
Date: Wed, 12 Jun 2024 11:01:09 +0100
Message-ID: <20240612100109.1616626-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the work done in folio_start_writeback is reversed in
folio_end_writeback. For e.g. NR_WRITEBACK and NR_ZONE_WRITE_PENDING
are incremented in start_writeback and decremented in end_writeback.
Calling end_writeback immediately after start_writeback (separated by
folio_unlock) cancels the affect of most of the work done in start
hence can be removed.

There is some extra work done in folio_end_writeback, however it is
incorrect/not applicable to zswap:
- folio_end_writeback incorrectly increments NR_WRITTEN counter,
  eventhough the pages aren't written to disk, hence this change
  corrects this behaviour.
- folio_end_writeback calls folio_rotate_reclaimable, but that only
  makes sense for async writeback pages, while for zswap pages are
  synchronously reclaimed.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/page_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a360857cf75d..501784d79977 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 	if (zswap_store(folio)) {
-		folio_start_writeback(folio);
 		folio_unlock(folio);
-		folio_end_writeback(folio);
 		return 0;
 	}
 	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
-- 
2.43.0


