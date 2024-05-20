Return-Path: <linux-kernel+bounces-183840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C18C9EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA80B21575
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA72136E16;
	Mon, 20 May 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="JY5jGjAO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E4136E03
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215466; cv=none; b=P4u9KBq8xV1Ih1N21ZWuZo+VeC02NMHuHQ+B98ApPJTApDhWOI07nTL4kQWiDdPSZ1TdksOvjXpOWJxpccrm1EU+JmYaXTaneMQtZ0cyCYVnNXk9NHFALAfMb/CooTAKIH+Zgw/tbfg9vzD4Nf0dpus4E5ws7PrJhEyTXqM56Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215466; c=relaxed/simple;
	bh=mDA8v9G7f+U3FaSZiKaYOCWuZt/Ho55XYWskkCZ0qEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uhn4pAkLBgJiyCFf1IzzFQSVbwPm++TUFmEt4FIaJAZW3ATIs4eI6Hst3u0740cJk5xRH9UylA6tf0CHfarQlXS8P+mbp35loz/BzEWdiaOpF5hembeJ+AcWlHpXMe6RxXKYuWV8BRJgkBMojKt0moRf8tIf9KEqsbQU86LeiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=JY5jGjAO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e651a9f3ffso72505125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215463; x=1716820263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+JsgoyJouVNGeodk33FzXnjKwnGHQfbLoITrru7PxI=;
        b=JY5jGjAOkUxwfNHjME4zhPFL/XhUIMwofRGWkoPhXCezBTaUg5WIM7jWIfh4sSGyyB
         gwE5Ou65kyGAW9jpSw5RhdLAVItc7Nk82RJvt46AbkjGbUV4N7mcdsMCpi9on2a5ht4Q
         XZ3viFgT+nPt6gbP7VV2mtBN+QqNZgp1dL4zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215463; x=1716820263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+JsgoyJouVNGeodk33FzXnjKwnGHQfbLoITrru7PxI=;
        b=o/j1EzaRjh4c+P1/xTLzTEANvbovI2dNplxIN8HQR4gMw0uLeCfUZY0BQ4drv2TUfC
         QYTjrDLek+9Qf/AzrEWlN7sk9aBr4aJ6HHIC6QKiroMedylDn/hkekOAHTyXOVyccXaS
         LApi27YS5CLCzNfriET03TXpuCnjD/2m3Q14GEI7gqU9cmAxHN40MezBxg8UNo8EjDph
         ZlpjRjwNOiMMzvLqWv4iagKsl9+5SRm/xFJVPLHV2qIDyUaJwqzeO+DmYwElRHMuYIGE
         6Vtxi8m0MeEU6aN69CjVrqEbBa2K9Fp7Med+xrcGDinUzS0RQv/lmx0x+IG12YDyipCK
         Gbew==
X-Forwarded-Encrypted: i=1; AJvYcCUzvHJkJOdMRCaHXiwc9HQ8kgTOKOt+7fahIwOBKmg3x08o5WKwVoqvgYIEgyQhztJiW2Yc2aC8rzPVgj6H/RdZIkoRxCExz5/6FqGI
X-Gm-Message-State: AOJu0YwXoF8i+GQbyBbii3qeKeaUZJpTgsoCOJen7VDoJmBeRbi6fPkF
	Tljsf4pOjlASCLgut0j9VvhM3YpMLYIHQ0V8S8wwK/Fzo8qFowuCRPGqWmT/89M=
X-Google-Smtp-Source: AGHT+IFEmIm7pgm30gC+GoeJM1s6pb8RIXfriP134g6evyIVXQGX3ZSXJHm7vjFT++H0TqTRHY/rng==
X-Received: by 2002:a05:6a20:7486:b0:1a7:878f:e9a3 with SMTP id adf61e73a8af0-1afde0e6b38mr30695430637.22.1716215463579;
        Mon, 20 May 2024 07:31:03 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:31:03 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 2/3] mm/damon: add module parameters for NUMA system
Date: Mon, 20 May 2024 14:30:37 +0000
Message-Id: <20240520143038.189061-3-tome01@ajou.ac.kr>
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

This patch implements support NUMA-aware DAMON modules by adding kernel
module parameters. With this patch, DAMON_RECLAIM and DAMON_LRU_SORT can
use this feature.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 mm/damon/lru_sort.c       | 1 +
 mm/damon/modules-common.h | 4 +++-
 mm/damon/reclaim.c        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3de2916a6..3e25a52de 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -81,6 +81,7 @@ static struct damos_watermarks damon_lru_sort_wmarks = {
 	.high = 200,		/* 20 percent */
 	.mid = 150,		/* 15 percent */
 	.low = 50,		/* 5 percent */
+	.target_nid = NUMA_NO_NODE,
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_lru_sort_wmarks);
 
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index f49cdb417..b167bb24a 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -27,11 +27,13 @@
 	module_param_named(quota_sz, quota.sz, ulong, 0600);
 
 #define DEFINE_DAMON_MODULES_WMARKS_PARAMS(wmarks)			\
+	module_param_named(metric, wmarks.metric, uint, 0600);	\
 	module_param_named(wmarks_interval, wmarks.interval, ulong,	\
 			0600);						\
 	module_param_named(wmarks_high, wmarks.high, ulong, 0600);	\
 	module_param_named(wmarks_mid, wmarks.mid, ulong, 0600);	\
-	module_param_named(wmarks_low, wmarks.low, ulong, 0600);
+	module_param_named(wmarks_low, wmarks.low, ulong, 0600);	\
+	module_param_named(target_nid, wmarks.target_nid, int, 0600);
 
 #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
 		succ_name, qt_exceed_name)				\
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 66e190f03..31b8830a8 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -68,6 +68,7 @@ static struct damos_watermarks damon_reclaim_wmarks = {
 	.high = 500,		/* 50 percent */
 	.mid = 400,		/* 40 percent */
 	.low = 200,		/* 20 percent */
+	.target_nid = NUMA_NO_NODE,
 };
 DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
 
-- 
2.34.1


