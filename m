Return-Path: <linux-kernel+bounces-293619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0695820B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC441F217CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EA18C000;
	Tue, 20 Aug 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXOiHDgW"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDC18B493
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145850; cv=none; b=G9ZhgBEpo7aUVsrI1zAPKM1tGSUtqCNDa0eCOnO6xUROTmONjeRvAoCungTxkhg8JEJXwQ6n5tyWYnepEfXGnmAGOXvz8KKXvfYxAQXWJAtYYp0zAd0pfsl6WV9vwtebeY+qYG8SVmn2pkHlHOXsFoYGljzI6jhERKSPqzIY4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145850; c=relaxed/simple;
	bh=FpZJOA0mQK1VicmRU0rcJ+nQ16ARUqQgndYmDsnqQr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHl3Opbina3eFV4efC8ktuhtE5Neo+u4tHBs8BNnU6etsrCE7VyhRk/DCxAG4QF+O1jJkUc/4o/54ZedOzdMEMCCflqevpsvhXikQu+zFOYAYBP6kLAuQfIGbZNKtWpuu3N4DyN12prx8MAbRw9Wh94hMuFwS7KxmBReL86PIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXOiHDgW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d41b082ab8so1645515a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145848; x=1724750648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlt2ID8Y4L9Xxz1JWEnsQz5/O2GKGR4Bos/ESGDaD3o=;
        b=PXOiHDgW+fA9VACiBfEnQT+ZM4xhRTgWtZuqcVz1oYcjDNKB3TzQqzilcupTxfWA+z
         PEwnOl2jj0UKIZ72kj2rEFtjWBaZBbe6HD8+kxpY7WwLV8AYGD6N5qcSAWs12B2Hzb/o
         vsKg0Wy6X9Dg+aXTNIkyp8HAisOZ/MiHW7MiHJ1kI3a7GZKa9QKSmYCUMV45ZrX/qvro
         uNyoq0A1V7MetTZlbC4u14L1yNdmu3BtPq0szL8rHukAC4tTQYfpF36+BucBN65nhSb0
         vT1/19XlEmYO7o4CG0kXZotmYiVxSJ4tC62miy4u20Mnk8ztow24bql5poRPdt3u3qOa
         Eqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145848; x=1724750648;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlt2ID8Y4L9Xxz1JWEnsQz5/O2GKGR4Bos/ESGDaD3o=;
        b=FnyZig9Kns9Wen+uLz2yK0UvEwAXS2Ees3acDVCsu3f7H7zUzXwKBi56LFBOSQRy9C
         Opaw0gYguPwUrdc+h+0RRR3GHX+aVbx8SfSDP5m2xlSJepXTIP2iFpoq1AhxadGLpcZc
         v3SarUJPxS3VSgC1h4JJow4d5S7T5BtsyJvzbmnTdUxGj6hHydUbTE9AcnRdZ1iKBTSo
         9K5ijuXty/NeSSwNfCbCrN7iFtdpEct1N1l6jokBQPLwObguYyT2tkDqJF4qL/BLyBwr
         9ZwENvpi1z61gqyZgKx2iYTNIYiSUEMU7CG/p9ky/CTKsEDenufWImZvz5VxTZcGOxFJ
         zhZw==
X-Forwarded-Encrypted: i=1; AJvYcCUY74a4LOjrmiHFbJqiNWlJ3ZOnq9A5yCKRtfroTpEuemgl6m6pwvcmKMyW4CATQtZbH/okdK2GVPm3wj3XWTod5dc9YxFv4LaGxZbC
X-Gm-Message-State: AOJu0YziqpwdNxaK9ecSgs8EH7sMFiWCMqKie0MKWozpGD9bmHtYQ/8e
	AFwwhrZ43AvrXWo4ReTaz6lriQLeu6hYY4qbMGhjVrYrQc7teXqD
X-Google-Smtp-Source: AGHT+IEq+YodW+Yl15mct3wILrYBBnyd3h7kGqFktIhdOaThlqhTzQftr9fvvZau9+ysLUMgbdZB0Q==
X-Received: by 2002:a17:90b:1107:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2d3dfc377bamr12147223a91.7.1724145847913;
        Tue, 20 Aug 2024 02:24:07 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e317181fsm8828676a91.25.2024.08.20.02.24.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Aug 2024 02:24:07 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/swap, workingset: make anon shadow nodes memcg aware
Date: Tue, 20 Aug 2024 17:23:59 +0800
Message-ID: <20240820092359.97782-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.2
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently, the workingset (shadow) nodes of the swap cache are not
accounted to their corresponding memory cgroup, instead, they are
all accounted to the root cgroup. This leads to inaccurate accounting
and ineffective reclaiming. One cgroup could swap out a large amount
of memory, take up a large amount of memory with shadow nodes without
being accounted.

This issue is similar to commit 7b785645e8f1 ("mm: fix page cache
convergence regression"), where page cache shadow nodes were incorrectly
accounted. That was due to the accidental dropping of the accounting
flag during the XArray conversion in commit a28334862993
("page cache: Finish XArray conversion").

However, this fix has a different cause. Swap cache shadow nodes were
never accounted even before the XArray conversion, since they did not
exist until commit 3852f6768ede ("mm/swapcache: support to handle the
shadow entries"), which was years after the XArray conversion.

It's worth noting that one anon shadow Xarray node may contain
different entries from different cgroup, and it gets accounted at reclaim
time, so it's arguable which cgroup it should be accounted to (as
Shakeal Butt pointed out [1]). File pages may suffer similar issue
but less common. Things like proactive memory reclaim could make thing
more complex.

So this commit still can't provide a 100% accurate accounting of anon
shadows, but it covers the cases when one memory cgroup uses significant
amount of swap, and in most cases memory pressure in one cgroup only
suppose to reclaim this cgroup and children. Besides, this fix is clean and
easy enough.

Link: https://lore.kernel.org/all/7gzevefivueqtebzvikzbucnrnpurmh3scmfuiuo2tnrs37xso@haj7gzepjur2/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>

---

This patch was part of previous series:
https://lore.kernel.org/all/20240624175313.47329-1-ryncsn@gmail.com/

Split out as a fix as suggested by Muchun and Shakeal.

 mm/swap_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4669f29cf555..b4ed2c664c67 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -97,6 +97,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 	void *old;
 
 	xas_set_update(&xas, workingset_update_node);
+	xas_set_lru(&xas, &shadow_nodes);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
@@ -718,7 +719,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
+		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */
-- 
2.45.2


