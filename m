Return-Path: <linux-kernel+bounces-183841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDB8C9EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF71F21BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CBE136E3A;
	Mon, 20 May 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="K5JHk9/f"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9B136E1D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215468; cv=none; b=QFEc9pnOFW18B262lc4+WQ0zfK+XW0KjMQUS0TjhTmfw+QHrSuE4kBuKdgd+17/OHpP1VblLg4NI7WGqHuVNg0L0Qi5is+/Pa9zsEduhubufvbJ3odMzZPqPKN2CmM8CluOCWrV7VQ4NH0BtoEY6odVKrzRSQllG9s3sjxwrkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215468; c=relaxed/simple;
	bh=Vark2tHasfjiq5qm7fVNYZJGTwQjSUnZIgp4elkLUqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGuJ/LB5I6hI782oXfGThTPkgkzc1slSPhwMch5D4nzE421uca0orZn9G3AeeoeItiFr+qr7Bi2Ik/ai4itD+a6iecI4ZQvP004ERjui8QMy/fSO3QDpFTthN4gZ7YtNCaaUnAeBKxMF8lJMS/RaCldSU7FBk2UToNiUSr+pORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=K5JHk9/f; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f693306b7cso539688b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215466; x=1716820266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNZVb3aalyckzv+MvkSwf98x3ypuajbAEW8swaTd5w8=;
        b=K5JHk9/fPPa6SXii1GS/N+jC2E0xSgz3/Ay0ru/TCIXO3xFsTEdQFHau/f0cI1EIjh
         0Rnu6vADOkhICeMmk2RAto2r2ReU/aVq6gIVfzD8da2ZJcoM/K0MiiCoZOnFX+AyIIAb
         SOm/w9+LOufmH48Tuk61+eapDZkvddQNqMjR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215466; x=1716820266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNZVb3aalyckzv+MvkSwf98x3ypuajbAEW8swaTd5w8=;
        b=rs0MSZKPwfhIxtUWZ9QwcV4ABBoJzqAZ+r29E3bvO24FCALlB4ouLiqE2b6/x+lQbL
         DetOAom4uUUbrO3W3EXRnEIz3LcoapKIZsDey2sigqp9fw/+gf6pVkke/ygqrY49qLzi
         hbvdmlIurUPoM+LbrLX3kHU5U4GPu82cZrxeVU1pp7f3Je8yIJpPhGWTVt6ecfy7CuY7
         bMiMPWm1GjFCCXdNbzYzcjwLtkPLz7LFXKLINkTBzUEXSd7r1Dr7UOQI+Ho8G7xITmNR
         X8HCUEH6kvT+jfujMVCRwofY5tFvh3B9yeuFYZVqz32rUxsArS9+2rqaLw7EoS9kCESG
         RSiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlrhLQU/oKt8BlXgGPs37lJlnz84aOjsLw0E781NP4grRSPwEvJ7d6QkFAEPSntO472vqU0JPhpUgk4Dz/Rq1bx+wDNjSydRq6K08C
X-Gm-Message-State: AOJu0Ywc5foUoiUpCeq+rhZqzNhmPV4tocRock7HI82S2hmreJlvMh3Y
	j4qwTzBnBccDnDC/BRbwbsj2gMYCZj5V/PQBwW77n7rcYSwEZ6Us3GEJ5yIslauK8xcGklUZKXF
	kXVM=
X-Google-Smtp-Source: AGHT+IGTqWX6KLCAkFgNmkNZOQ7jdXH7YUcuBwf3ViNWwc7ehoGXbRn6Xn9m06QND/xMKX5Gz7ws0g==
X-Received: by 2002:a05:6a00:b4f:b0:6f3:b041:716d with SMTP id d2e1a72fcca58-6f4e0296f83mr37942698b3a.17.1716215466453;
        Mon, 20 May 2024 07:31:06 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:31:06 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 3/3] mm/damon: add NUMA-awareness to DAMON modules
Date: Mon, 20 May 2024 14:30:38 +0000
Message-Id: <20240520143038.189061-4-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520143038.189061-1-tome01@ajou.ac.kr>
References: <20240520143038.189061-1-tome01@ajou.ac.kr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the 'target_nid' parameter of DAMOS watermark, both DAMON_RECLAIM and
DAMON_LRU_SORT modules can set the monitoring range to a specific NUMA
memory node.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/lru_sort.c | 13 +++++++++++++
 mm/damon/reclaim.c  | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3e25a52de..ed136ccba 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -238,6 +238,19 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(ctx, &hot_scheme, 1);
 	damon_add_scheme(ctx, cold_scheme);
 
+	/* Set monitoring range from target node */
+	if (hot_scheme->wmarks.metric == DAMOS_WMARK_NODE_FREE_MEM_RATE) {
+		int target_nid = hot_scheme->wmarks.target_nid;
+
+		if (target_nid == NUMA_NO_NODE)
+			return -EINVAL;
+		monitor_region_start = PFN_PHYS(node_start_pfn(target_nid));
+		monitor_region_end = PFN_PHYS(node_start_pfn(target_nid) +
+				node_present_pages(target_nid) - 1);
+		if (monitor_region_end < monitor_region_start)
+			return -EINVAL;
+	}
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 31b8830a8..9c0c0096b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -192,6 +192,19 @@ static int damon_reclaim_apply_parameters(void)
 	}
 	damon_set_schemes(ctx, &scheme, 1);
 
+	/* Set monitoring range from target node */
+	if (scheme->wmarks.metric == DAMOS_WMARK_NODE_FREE_MEM_RATE) {
+		int target_nid = scheme->wmarks.target_nid;
+
+		if (target_nid == NUMA_NO_NODE)
+			return -EINVAL;
+		monitor_region_start = PFN_PHYS(node_start_pfn(target_nid));
+		monitor_region_end = PFN_PHYS(node_start_pfn(target_nid) +
+					node_present_pages(target_nid) - 1);
+		if (monitor_region_end < monitor_region_start)
+			return -EINVAL;
+	}
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
-- 
2.34.1


