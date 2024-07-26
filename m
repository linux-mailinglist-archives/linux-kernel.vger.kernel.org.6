Return-Path: <linux-kernel+bounces-263728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52893D9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389C9B22EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49754149C40;
	Fri, 26 Jul 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YtCeW5XM"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992F1428E5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025887; cv=none; b=FGZ2gkjq8mhuel6l66JqGbdCJR1KBP6H9L/lfq6TcNJsR4bOeJaKvjY+NGIoKrXxVYxQ1gX8gC1K7woPLhtyZwpSlytUIQ9zjyzqcACh0+WXZYVhxDKOOgV8xioSwwRt2JvSnVbUubb5qBDYhdYpq6kKMJSLonkouTqzO1CxR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025887; c=relaxed/simple;
	bh=Xc1cwXgKSfsFGPX/7txTHbB2j8FoCOfNDwV4vePxnCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLk85DE5pQ35TVd3PzPGLzTyG3y3WXH5HtcYrBLYjhM0Yirxek4gWtpeGDoEpFODDghOg8FYcFqhl/b6I1xOvAd4Xbyrqm3xmgfBbF3kTTyxq2e2NFyQLYot5us+34tGlQZK5aw9D/c+wjV9szjbt3rxoO2MHT8uTv+F06ptci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YtCeW5XM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722025881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jVngEr7hAv0PSmXL/CDo3XzyDWAw8oWbbYbtru/rxEU=;
	b=YtCeW5XMlpGsaZmd5H5xQV6XaEnKZzhpdX6OhmlW11FG6mbIxzD+jesZ0w1vLWfoHFcqRF
	GBsuDGYgu08+2spEw595rkjItb5yxu5KcSVUu7HFL4csVOLe02SdFmgJvOCeBs/vOjFdOd
	hBeUB+uST2xd4wsLh8+Bnfzqn2bt5Tk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 0/3] mm: memcg: page counters optimizations
Date: Fri, 26 Jul 2024 20:31:07 +0000
Message-ID: <20240726203110.1577216-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset contains 3 independent small optimizations of page counters.

v3:
  - dropped the main part based on a feedback from Johannes
  - rebased on top of current mm-unstable
v2:
  - two page_counter structures per hugetlb cgroup instead of one
  - rebased to the current mm branch
  - many minor fixes and improvements
v1:
  https://lore.kernel.org/lkml/20240503201835.2969707-1-roman.gushchin@linux.dev/T/#m77151ed83451a49132e29ef13d55e08b95ac867f


Roman Gushchin (3):
  mm: memcg: don't call propagate_protected_usage() needlessly
  mm: page_counters: put page_counter_calculate_protection() under
    CONFIG_MEMCG
  mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro

 include/linux/page_counter.h | 16 ++++++++++++++--
 mm/hugetlb_cgroup.c          |  4 ++--
 mm/memcontrol.c              | 16 ++++++++--------
 mm/page_counter.c            | 18 +++++++++++++++---
 4 files changed, 39 insertions(+), 15 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


