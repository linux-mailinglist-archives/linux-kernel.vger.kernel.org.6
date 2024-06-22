Return-Path: <linux-kernel+bounces-225753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED4E9134D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1382847C6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABF16FF4B;
	Sat, 22 Jun 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGH8T3yJ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7116FF27
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069956; cv=none; b=scav7ZnP/ug9j3ExHbTuOGVMSY4tN6IrF5IXi0yHbUz+8GqqNVIXGz9gxvSzS0DrVxBb3KXej24iDMhxg6eKD5xC+6gIOD/LpxM6aun5pnSzNT6KlTyWu+MUe1ng0waCLTVjlmKTfRgygyWawxfj/sCmgTIaSKuyViGjLwDWOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069956; c=relaxed/simple;
	bh=ZY0kiOAv0soYYQ4EcLrCaEhokPYhsqZm02A35xoJaDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLDhv96FH/jBkpAcOj8tgmy75cm2+0ddmpw7TU/io26GXBzvy8RRaT63cUOekpcvThNcOE/UfYMzlwlH5f0KcA1RhPTvU+rWEiXtxdWSQvIojBpnHkr5AVyz4WuIAEbAAcn17kf20OlMtHlVYjaaEZ+IvRHJEBx0Rmbg8rLvx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGH8T3yJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421b9068274so27086935e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719069953; x=1719674753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkTtkRJJiEuxpoV2bMHoh0FrXUbp1KWkIXI8vJTMHh0=;
        b=jGH8T3yJtworRV44Q8yTiKI6CUGenE6re8c2nFRsxNM8d0J7JKrj3iYH9YTo5ErC6j
         ZEbRDRtH5gka4klEVNejwH7SK8OKZ1h67BcpApkAXhKfN5tN6guwi2iVKGKsgFVVa3Tv
         +lUuEzkLF3/8rQnE4ovEbgIwSznBfq1Bjq4L+rE3dp07ngxSEpkuwO16sdgU5iWXhs96
         RArcz0Vmj+dv3cRpc0TpJcI3xlmWMl/ilyg8bA+nhkIudEF2JWIio2amaSgm4XL2ec/W
         RnQVQY2ZXtkHenUvqVCHD8rwOLHzYQajdmZBRdyz8JnyBulo9NP9Ki6wTSP8cU3//BXs
         +urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719069953; x=1719674753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkTtkRJJiEuxpoV2bMHoh0FrXUbp1KWkIXI8vJTMHh0=;
        b=dra2olTqxlv+WNOVpbmVYdpmM/cA4cN6mfXNj/OW2NZ38ck+UhCWZiX3I/G9zMxdul
         sSbV7mkT1sGP2SFjFG9tzRQE23S2Ns/Gp7BMvS+ASMcpr4tqgulTdEyM6nEhli1dKtI7
         lLdNrSTsUo+tRlDsACO3VBNBInfcHkYXoL168781Xz2j8hPwwC6vaoKUQ/uWe6TPBMQu
         PpwwUmBQsxmxcQKlfSZq2xCkh6AIg0KQVayraf+zYB31vtcrSM3uY+ZhE6b+0Uoi/LTZ
         yK47bZZvzG8yh+tKXIVMA1OpWNxyseNoi0ij5Au7AQPm1MqTovrWiwIGFM7JOKkx7XHg
         ATSA==
X-Gm-Message-State: AOJu0YzvlaRC6EbMVkngn07e26YT0CUzbWoLD6mVpWHqF6dOegvTTTWD
	Pik/TWyT6ureKrNqmmab7ICYbgidKHE7Hw1hkyY0+L082TRMg16S
X-Google-Smtp-Source: AGHT+IEBR/wnvkvGkpsGHlHhz9ccP0WvQg4UfFBJdO7/KyO4pQAb6bCtZS06MQxAAreGDECliLiiog==
X-Received: by 2002:a05:600c:6dd3:b0:421:ad42:c4c2 with SMTP id 5b1f17b1804b1-4248b9575famr6068435e9.10.1719069953130;
        Sat, 22 Jun 2024 08:25:53 -0700 (PDT)
Received: from sacco.. ([217.201.157.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b27sm108053655e9.30.2024.06.22.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 08:25:52 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH 1/1 RFC] drivers: cacheinfo: use __free attribute instead of of_node_put()
Date: Sat, 22 Jun 2024 17:25:26 +0200
Message-ID: <20240622152526.131974-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240622152526.131974-1-vincenzo.mezzela@gmail.com>
References: <20240622152526.131974-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the __free attribute for scope-based resource management.
Resources allocated with __free are automatically released at the end of
the scope. This enhancement aims to mitigate memory management issues
associated with forgetting to release resources by utilizing __free
instead of of_node_put().

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/cacheinfo.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 23b8cba4a2a3..acab52dd7fb8 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -202,29 +202,24 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
-	np = of_cpu_device_node_get(cpu);
+	struct device_node __free(device_node) *np = of_cpu_device_node_get(cpu);
 	if (!np) {
 		pr_err("Failed to find cpu%d device node\n", cpu);
 		return -ENOENT;
 	}
 
 	if (!of_check_cache_nodes(np)) {
-		of_node_put(np);
 		return -ENOENT;
 	}
 
-	prev = np;
-
 	while (index < cache_leaves(cpu)) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		if (this_leaf->level != 1) {
+			struct device_node __free(device_node) *prev = np;
 			np = of_find_next_cache_node(np);
-			of_node_put(prev);
-			prev = np;
 			if (!np)
 				break;
 		}
@@ -233,8 +228,6 @@ static int cache_setup_of_node(unsigned int cpu)
 		index++;
 	}
 
-	of_node_put(np);
-
 	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
 		return -ENOENT;
 
@@ -243,17 +236,14 @@ static int cache_setup_of_node(unsigned int cpu)
 
 static bool of_check_cache_nodes(struct device_node *np)
 {
-	struct device_node *next;
-
 	if (of_property_present(np, "cache-size")   ||
 	    of_property_present(np, "i-cache-size") ||
 	    of_property_present(np, "d-cache-size") ||
 	    of_property_present(np, "cache-unified"))
 		return true;
 
-	next = of_find_next_cache_node(np);
+	struct device_node __free(device_node) *next = of_find_next_cache_node(np);
 	if (next) {
-		of_node_put(next);
 		return true;
 	}
 
@@ -287,12 +277,10 @@ static int of_count_cache_leaves(struct device_node *np)
 int init_of_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
+	struct device_node __free(device_node) *np = of_cpu_device_node_get(cpu);
 	unsigned int levels = 0, leaves, level;
 
 	if (!of_check_cache_nodes(np)) {
-		of_node_put(np);
 		return -ENOENT;
 	}
 
@@ -300,30 +288,27 @@ int init_of_cache_level(unsigned int cpu)
 	if (leaves > 0)
 		levels = 1;
 
-	prev = np;
-	while ((np = of_find_next_cache_node(np))) {
-		of_node_put(prev);
-		prev = np;
+	while (1) {
+		struct device_node __free(device_node) *prev = np;
+		np = of_find_next_cache_node(np);
+		if (!np)
+			break;
+
 		if (!of_device_is_compatible(np, "cache"))
-			goto err_out;
+			return -EINVAL;
 		if (of_property_read_u32(np, "cache-level", &level))
-			goto err_out;
+			return -EINVAL;
 		if (level <= levels)
-			goto err_out;
+			return -EINVAL;
 
 		leaves += of_count_cache_leaves(np);
 		levels = level;
 	}
 
-	of_node_put(np);
 	this_cpu_ci->num_levels = levels;
 	this_cpu_ci->num_leaves = leaves;
 
 	return 0;
-
-err_out:
-	of_node_put(np);
-	return -EINVAL;
 }
 
 #else
-- 
2.43.0


