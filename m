Return-Path: <linux-kernel+bounces-436413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B89E859B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB7281577
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AC14AD2E;
	Sun,  8 Dec 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVRaQpT5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9E13D504
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733667877; cv=none; b=XQiu0Y69i7o8JLI5ShdVZd9WLoCUeAQ62mo5NkHlRPLm9erhT7qd8xtfYmBBQ2vHPBft1HRU6xsNtWkqotjL0y8+xIMdpqHy6Skm0xpG5JRSUqz5unoT5ERhlQbgmd9dbisaWv8iRhY0ygHwdGB7DFghBy2yTolzIoFiBAa7CVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733667877; c=relaxed/simple;
	bh=7XTYfBTFkhAo5OznWJNcm8p2G9mUjJ/27pdAjqAm6n0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kWmsIB4Uff+tGYfhfGWf8E+B0HVRFIe/kjSzW4Shw7fHxulrXKDgimxGICycfe6udspbwxyuhSmngwBZWWPKD5p7WqeRlktvDmk5k3ajW09K9Fi3X6VNmropCgkT4kKqsYEEFKWvALW1LpGCcnMATJ3ELTYZHrMp526IKtdwHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVRaQpT5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215a7e487bfso29215745ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733667875; x=1734272675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0jE3kFC9IRxKSac1Py9vab2hjrB05K0AK8EkacdE64=;
        b=WVRaQpT5UvL5GNv/FL8Z1Kv4J3or9TDlppxgLgyhDYp1XqZbhsfl0gn3QSTfOjbVu5
         hqbNkLjrgg6duGgWg0lr4feKtXsjc3rO1do8awhD+q/tA/EmY2UT/5QMwGShAncTADMq
         CvL2rbFurjekZ6sjm2iGqdtavPTWWavdwEHjq5l5WLDeYLG33Otz4cEL3WBmPyMmxouE
         OQD1XQlV3BsxWl3/5XuX9o5O8BcD9bDLLFmKzckdhSEUSL/iH9wIrmefUyFp5ntXpmhl
         ek4HbuvffpuXpCb/2GBGA9qYCu+5t2nej8ZyrEqeUmzi2t/jDgJr253G1sqtjO8GMTv+
         U7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733667875; x=1734272675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0jE3kFC9IRxKSac1Py9vab2hjrB05K0AK8EkacdE64=;
        b=LuCqs5Q9GiqtVSudqujzQA7WzeeYcDgmSm+FA61dpD3GyIhBCAOAkdT5PuDxyIemPn
         /QgixUmyeVKayWvN0itDIxHqhVE127ZWjB0ErWzMmMGvL3Gm7QDuMEfO7xdqP56/OrR7
         aPecdLgiQqvMD3LYxdFePrxFciccPLxvmU2FmzNI+uaOaFXgos8JGesJBtLM3zWuDaSh
         oUO7BGPEduF5WX9X0/FrN+KaJFAaxVKRTmMhPMAjmx5S+7F/aWUZiJekTdpCopu/f9Ax
         fAl8WejzHq6qhqmC+citpz7rLn3qJXoYiOTdiyvTbPnSqLFWRUsP60tyODGm4/es6M2w
         Tkuw==
X-Gm-Message-State: AOJu0YwpIz47E5U0YMfobTiIkX+5Z8pWfSOwU1cB0iIgX2uHMZpBGdWE
	8fdZUiWHZfYQ4mm8ZsMRGQYQTVGfnDbsADDxJRBjjBFxkRDgQ0kz4GxvAA==
X-Gm-Gg: ASbGncsiKQYsI0k31Ol4Op69i/uuE2s45fX9fAug5F8GQICe83DvSxe8YHVzxuWvY/j
	7YDnhPMmCnWysTCCMl1oSkIS7dGOM+Zq6Fw5sqsqa0vk0R5TSAyJLZKfwdZeUh/DG8CsCweOPJ6
	W146FhxGyqQHda+xs8Yb11qGKA9Ot9NlbFT12QT0BQLfjV7gjhOzRFRXWx+TDQf2GTZ548qRsHg
	fx3B6foNggjMjzSSOgMku8rpng8f2EpyPcdYgjXkGmPNi+weAdgJEUNVX8sxTQ=
X-Google-Smtp-Source: AGHT+IHu4FL1iyMu4mqV57JdALjL3711VjUIT16TNXtRL/9PgLeNQDLzuVPEDdNxPkSWBiGBZqBe8A==
X-Received: by 2002:a17:902:f78b:b0:216:1543:1962 with SMTP id d9443c01a7336-21615431b14mr161362995ad.23.1733667874777;
        Sun, 08 Dec 2024 06:24:34 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:9b5c:d816:d159:869])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e53798asm23288585ad.60.2024.12.08.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 06:24:34 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	akinobu.mita@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] fault-inject: use prandom where cryptographically secure randomness is not needed
Date: Sun,  8 Dec 2024 23:24:15 +0900
Message-Id: <20241208142415.205960-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently get_random*() is used to determine the probability of fault
injection, but cryptographically secure random numbers are not required.

There is no big problem in using prandom instead of get_random*() to
determine the probability of fault injection, and it also avoids acquiring
a spinlock, which is unsafe in some contexts.

Link: https://lore.kernel.org/lkml/20241129120939.GG35539@noisy.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/fault-inject.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 52eb6ba29698..92a54c8a8380 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/debugfs.h>
 #include <linux/sched.h>
 #include <linux/stat.h>
@@ -12,6 +12,24 @@
 #include <linux/stacktrace.h>
 #include <linux/fault-inject.h>
 
+/*
+ * The should_fail() use prandom instead of the normal Linux RNG since they don't
+ * need cryptographically secure random numbers.
+ */
+static DEFINE_PER_CPU(struct rnd_state, fault_rnd_state);
+
+static u32 fault_prandom_u32_below_100(void)
+{
+	struct rnd_state *state;
+	u32 res;
+
+	state = &get_cpu_var(fault_rnd_state);
+	res = prandom_u32_state(state);
+	put_cpu_var(fault_rnd_state);
+
+	return res % 100;
+}
+
 /*
  * setup_fault_attr() is a helper function for various __setup handlers, so it
  * returns 0 on error, because that is what __setup handlers do.
@@ -31,6 +49,8 @@ int setup_fault_attr(struct fault_attr *attr, char *str)
 		return 0;
 	}
 
+	prandom_init_once(&fault_rnd_state);
+
 	attr->probability = probability;
 	attr->interval = interval;
 	atomic_set(&attr->times, times);
@@ -146,7 +166,7 @@ bool should_fail_ex(struct fault_attr *attr, ssize_t size, int flags)
 			return false;
 	}
 
-	if (attr->probability <= get_random_u32_below(100))
+	if (attr->probability <= fault_prandom_u32_below_100())
 		return false;
 
 fail:
@@ -219,6 +239,8 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 	if (IS_ERR(dir))
 		return dir;
 
+	prandom_init_once(&fault_rnd_state);
+
 	debugfs_create_ul("probability", mode, dir, &attr->probability);
 	debugfs_create_ul("interval", mode, dir, &attr->interval);
 	debugfs_create_atomic_t("times", mode, dir, &attr->times);
@@ -431,6 +453,8 @@ static const struct config_item_type fault_config_type = {
 
 void fault_config_init(struct fault_config *config, const char *name)
 {
+	prandom_init_once(&fault_rnd_state);
+
 	config_group_init_type_name(&config->group, name, &fault_config_type);
 }
 EXPORT_SYMBOL_GPL(fault_config_init);
-- 
2.34.1


