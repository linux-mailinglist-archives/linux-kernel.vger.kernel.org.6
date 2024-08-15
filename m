Return-Path: <linux-kernel+bounces-287526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8949528C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA20287E11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7755893;
	Thu, 15 Aug 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olL28lu+"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2513C90F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698343; cv=none; b=Ax/40lYoRduuiwnx3DmRH4r2qRupivktOkBPQZpuLpNWYg3JjNQfqgEmHLa2KbDbq+VpoDQfbVm+iyjy4EG8suMGeuW/eT7tNC9bF6OhC24vxL9TqQHtsJaBEjv1VvrYUlXVmOmoxct1acrQyU3w36ls6VAmESo7AC0wak8+nZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698343; c=relaxed/simple;
	bh=i3M5S+rUsE+Do4aEAW0zVPstTu46zezdV6XYFzAKFd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/6OwaIsfJDqEn8FZafVVV/U27VvD8fyyjKt5qQeagHuE+XI20pCrc0JW8b2EA3L48fAsDraWkn4Q38HuF2PY6zC2WYWMpJH/TA1fmI8y6ull+Nw6TixorwUs0CMyXVZ9gBats8QK7KxUiMO57n0eF5AP6y4NNOOkKKUK2JMK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olL28lu+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eAu+FADTIrdS5fQdJHfQzYaBndTq6CMzABmov4I1A8=;
	b=olL28lu+B/zDWmkEuIbo69rLnNvVgmsmXU8CRoAVPnl5y2BaGzfXFuxPoLOVcbY0rq6D7C
	8ngmcAcKiy7BJ07ngoQh7T+Um+zErT+SdESm4nRgRT4kPTIwD8f8Cr0ONEhBBEfoMRXMou
	nC2ywtg16+j82Juz7oq0kph1B4s92u0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 7/7] memcg: make PGPGIN and PGPGOUT v1 only
Date: Wed, 14 Aug 2024 22:04:53 -0700
Message-ID: <20240815050453.1298138-8-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently PGPGIN and PGPGOUT are used and exposed in the memcg v1 only
code. So, let's put them under CONFIG_MEMCG_V1.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4b06f26ccfd..9932074c617a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -411,8 +411,10 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
+#ifdef CONFIG_MEMCG_V1
 	PGPGIN,
 	PGPGOUT,
+#endif
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
 	PGSCAN_KHUGEPAGED,
@@ -1461,10 +1463,11 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
 
 	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
+#ifdef CONFIG_MEMCG_V1
 		if (memcg_vm_event_stat[i] == PGPGIN ||
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
-
+#endif
 		seq_buf_printf(s, "%s %lu\n",
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
-- 
2.43.5


