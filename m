Return-Path: <linux-kernel+bounces-177113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92E8C3A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60B11C20CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6998145B15;
	Mon, 13 May 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqbstO+e"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06563C7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715568562; cv=none; b=t9sY6oCnnVA63XjS/oGO1ZldNhDlMaEemeKhgjOjENZu79dl/dJncj32WIDha/g75aEeZKgRHy7YrMJFOK3jve60DqbDx3jf3UrAjrD3bhJF7dkzXMHmE9rgd1OUwncliY/GwGy1oeF38A++DgzI9m6R412Te43eQ/lui9cvSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715568562; c=relaxed/simple;
	bh=uv8X8+Gl145xhui3xX12RudII8xZnXXoGgxAgefN8l4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QouTyu0sCAupa41rMnxYC8DTp/TAoKhsVQy8ryPVI8fP5xDGZyKPedA7btm51kagcPwZJ1F4FO4LzKtlB8ZHrL8K/4vCbBCRHTHlyO5TlBTsXCQV6jX93Qf4KkkXNcUBl9SwjJ1BtsAdTIXg4IkeT2DXsvQIUMGbU70gf+cXW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqbstO+e; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715568557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oiWYfJlObN+EN3yuvBcS6Xb8P7vMS1auM17xOJ3C2Zc=;
	b=HqbstO+exYdnLA5+vTMuNJYsSwZw/zqdWkaYGscBrct3lCec1gDoDhzWegeS9pLZ5lU3HY
	gvHr4SLlFcgDBTTdH59ihKcMyO/XRQYFowY8vciNDZ1/0f9NjsvG9EfKoeRmrMFNVUyWiD
	hwsfYtUx66HKFYnBLwyiavN/sLIF25o=
From: Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH v2 0/2] mm/ksm: fix some accounting problems
Date: Mon, 13 May 2024 10:48:35 +0800
Message-Id: <20240513-b4-ksm-counters-v2-0-f2520183a8ca@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIR/QWYC/3WNyw6CMBBFf4XM2jHTUgK68j8MCx6DTNSWtNBgC
 P9uZe/ynOSeu0FgLxzgmm3gOUoQZxPoUwbd2NgHo/SJQZM2VFCFrcFneGPnFjuzD0imUmVrqM+
 ZIa0mz4OsR/FeJx4lzM5/joOofvZ/KyokZN1cWpUPJXXF7SV2Wc89R6j3ff8C6uqMR64AAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715568553; l=1143;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=uv8X8+Gl145xhui3xX12RudII8xZnXXoGgxAgefN8l4=;
 b=NyAgMZBxcVKlgH4MXQoDhQf7oetWU+XtiLxrio32jfz7MgWx+tC58yuCKIAo9Da/iRdC1yZyL
 aUO/n5Q1ulRBjpcsGuLzzHu+w6OtSL9SEeDlb24zThLRV1Ly1HxuSXb
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Add Fixes and Acked-by tags from David Hildenbrand, thanks!
- Inline atomic_long_read(&ksm_zero_pages), per David Hildenbrand.
- Don't include the last two optimization patches to keep this fix
  simple.
- Link to v1: https://lore.kernel.org/r/20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev

We encounter some abnormal ksm_pages_scanned and ksm_zero_pages during
some random tests.

1. ksm_pages_scanned unchanged even ksmd scanning has progress.
2. ksm_zero_pages maybe -1 in some rare cases.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm/ksm: fix ksm_pages_scanned accounting
      mm/ksm: fix ksm_zero_pages accounting

 fs/proc/base.c           |  2 +-
 include/linux/ksm.h      | 17 ++++++++++++++---
 include/linux/mm_types.h |  2 +-
 mm/ksm.c                 | 17 +++++++----------
 4 files changed, 23 insertions(+), 15 deletions(-)
---
base-commit: fb0f40125feec3de7ef4524600ac83946207117e
change-id: 20240508-b4-ksm-counters-04817b40d3ee

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>


