Return-Path: <linux-kernel+bounces-560039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E5A5FCED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC993B4964
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099826A0A6;
	Thu, 13 Mar 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj8X+ex6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3726A096
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885298; cv=none; b=vFdloA0vsT7LihAVYRHq4j47Bmeicpd3Xd49jHP8EdYEQHb4fp8xx/gGdX6AXnJvrj1dfkSPXAZj5wdMUUzzDV20GPerCP+cyy0UW9ojbvvYAmMJ6BbH7iJxZqknb1EKFHC1z33CFVWSvfYZTiIbX1g2kk0DQ2kuc4jCMSSet4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885298; c=relaxed/simple;
	bh=oajwQOVUv0/PpZmcN2o24cOxVdYygFr8ssT56cJN/FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUQcHnjtWydfmvCpMhtiQLN4/nlrgc4kMPI+XYFDr7AKXgKduZMB09tAuqBH0L7qM6qS9LFcSp0GL4PF/iRdfnhBhubUmbgf6t0ixS/B+qrlClVP5i/vlYZ7TpHWsYgtPasMP+of10GL8ZlBK5gYPDOYZ3OpNfzDOpPf8zVHm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj8X+ex6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239aa5da08so25260965ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885297; x=1742490097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=16176wl+Bq4nvhP8cCENJp3OqZKTVE/qLPzCvGc5ZPA=;
        b=Sj8X+ex6AkQD4EcqxVyOv6qPM4wEaX6aPmll6TAlf4bkfTe9wRrx0wAU7dqQNxCnDI
         upWbXH/z60I0uASRc2MGuh4fStbRlMNis7+MgYNYh7QrZbLPJGwmQ3LYDClUNmb0nZkP
         Fh51DFN4EnYX7chiDodwsU0mO8Vy7Qqc/yE6HSyqKH/2hhbYxZ/KcnBK20nrXG5ATb1L
         LZU8pUb8aozo8vfZpF81/fawE2LoJsuzplJjif86f3tZHf+rpHw19daELyV4bjVa86kj
         80ClGSYRAuFgHXz/2C+ls/iMS31wSorHK0Pp7ArPjl6dH0mZV7k6iSY9DsbHg0AKYtXD
         uGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885297; x=1742490097;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16176wl+Bq4nvhP8cCENJp3OqZKTVE/qLPzCvGc5ZPA=;
        b=sJp0gSM7Rzp0NYe+sd5ciYHAGeJxI1/eogansg1sps1g7Vg2C1TeGWKmNaqD9xaBnj
         GbjTTTiiSmkf8DPt9f7qR0ZM7gLOukMLZYU0znz7UU3oEEs5fgihjElaEsZBA2vP51/8
         k8rx4zHBCNhkEyT9LdZFgMTu/xsU9eiLpMTw9io3sz+D4EpaRSF3KuZX1ujNNC70VZH/
         ZqAAa+uQAmlSzzsWE0HdIEjgxoDwDW1GJa8IRhZey54EjPrUQ1iaFJlaQcopI7fJlDcl
         poX0mMvWQRru9Qwa3/RHvouk0sBKV+H9Oh3wGsLwpUqiDDh8tuxie1LujR6rmORXVtJv
         fgtw==
X-Forwarded-Encrypted: i=1; AJvYcCWiMbMAdreF2MJFdAHdkr5UpkLB3icGS3WUm098MkLAJWDHrwnGjXh7ej+S0xCANWZy1bQd8i4szB/VGpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyDwxurnwvUq/MvKq0ZOl1Auo3Oceo1BO3VkN8xOYP5GjDF5K
	0dJmL8HrjB+Mb4KmpxT5h6L0tuk6Z6kOGwBmz7H4Aqo3w+J5TkUi
X-Gm-Gg: ASbGncsjBwVqcKKxtTUHSmLhwm31ra73ClqEl/AZ2jkMpwE5/BN9tJhICwmDK9az6Oz
	tgdCqCJjSvgGOV4STvH+YEwo7L9jV9ubeRBJJhoSyuVULQFHEdNIf5dysBZfM9f1ZGrE9QYxpJu
	pr6agG+LFd+v6+e+OTO4zAr+SWDx0YSoxuwhtpvld0Gviugvjm+d3vd9IJivy/dMA/w3DxguRR5
	rRr+eQ6bw9+1HKaVHf7JepCylAl7kozxVCStaQ26ceP02A8CiJ9b8rjt6f1+bXsoLhd9Kb4eZBQ
	UBIq5Lc9agl5HvrEuCMLOUrr5wxq2vXm803XohaggDAsI/NrDlvpWQ4EdVZ4mZfmdw==
X-Google-Smtp-Source: AGHT+IELVJnU/2w6JxSBVbjYpEvdIkIJJfwul5CyfHieaSFU0AM6vT3TQ+4+KXAwtNXc5aJfM4hBKQ==
X-Received: by 2002:a05:6a00:1885:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-7371f0cc2b1mr361404b3a.3.1741885296524;
        Thu, 13 Mar 2025 10:01:36 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 4/7] mm, swap: don't update the counter up-front
Date: Fri, 14 Mar 2025 00:59:32 +0800
Message-ID: <20250313165935.63303-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The counter update before allocation design was useful to avoid
unnecessary scan when device is full, so it will abort early if the
counter indicates the device is full.  But that is an uncommon case, and
now scanning of a full device is very fast, so the up-front update is not
helpful any more.

Remove it and simplify the slot allocation logic.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6f2de59c6355..db836670c334 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1201,22 +1201,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	int order = swap_entry_order(entry_order);
 	unsigned long size = 1 << order;
 	struct swap_info_struct *si, *next;
-	long avail_pgs;
 	int n_ret = 0;
 	int node;
 
 	spin_lock(&swap_avail_lock);
-
-	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
-	if (avail_pgs <= 0) {
-		spin_unlock(&swap_avail_lock);
-		goto noswap;
-	}
-
-	n_goal = min3((long)n_goal, (long)SWAP_BATCH, avail_pgs);
-
-	atomic_long_sub(n_goal * size, &nr_swap_pages);
-
 start_over:
 	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
@@ -1250,10 +1238,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	spin_unlock(&swap_avail_lock);
 
 check_out:
-	if (n_ret < n_goal)
-		atomic_long_add((long)(n_goal - n_ret) * size,
-				&nr_swap_pages);
-noswap:
+	atomic_long_sub(n_ret * size, &nr_swap_pages);
+
 	return n_ret;
 }
 
-- 
2.48.1


