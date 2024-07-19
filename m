Return-Path: <linux-kernel+bounces-257423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D906B9379B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C22F1F21D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC962282FB;
	Fri, 19 Jul 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbzDQZmB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DC8C06
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402023; cv=none; b=Q2BzKKgFO5FgoQgDlc2ZmaZ5dsjs8u4o6FzU3AGuqdmIX9mYt0PYHXfuw9F57c3lOTgCoNE5Tszaja/qOiqZjGh8+SGtL4Nab8OuRY1rFkyOqqfFBL7AUpumaxz1X2Kohe5ZxY4lINGaXaMdMLBtG09j4RmTYFKjdMWmI43duZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402023; c=relaxed/simple;
	bh=ytqLdrMS/F3PDU9ziZuRLSJ0TIXcMsqlkVRc8Bf9t6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBb6Ru+PHSQF++E5cFiRKtdcSckFrGk8SQBMQd5bjJ4jfCW8Ox6NBTlCrnK34Vbe+gxwdZo2tFX7SZJREvdqUDR3xy6CkuDz5d0vCiLnt4vL1SpYOJzbsLhDwmIx+YqfMsNBHj45y/QfgGFLy1KiRNbIIUAa/EZo5c8Nb2GjtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbzDQZmB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ed741fe46so2293838e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721402019; x=1722006819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kQcaY59gAGaUrXny2ZXu+5o1z8+k1lwNjL8VREpPao=;
        b=jbzDQZmBtBKdPtd6NS1ltALs9yJKxoO+2CquNOwH7J9PgK8FzJC5n9fYZYz/YCl+q6
         C+RXaE+8uBZbOCle4aSVGvghocUonUyO0IeZbqGv7xjfiRw9KLsU1TKWDZOXQWyt023D
         tw7sAVNtiIuyjucwgtWwK3K5MfKIY/N5TzQRKrsDeDwKFulUg+wOEDes+ze8/rSyIPCB
         v/GGRYptDSD7DVZBGMDT5TcchLKA5Sf2mzKupY9/x64YIeqmZe2y55RCRBmR5jqPcP6H
         2WEnoO52TG7rxyF7Vv2w2LxONNDBFTnLeF16NDtqZgXhxRDyfqnV4pHifR1yHPV2l4BM
         iNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402019; x=1722006819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kQcaY59gAGaUrXny2ZXu+5o1z8+k1lwNjL8VREpPao=;
        b=YIqnc+0UThGiyjtAsCBB04RUThgLJxDuNxXHItlhcA+2qPPGuB16Io9A4JZDQNo7Zt
         /6MWOcz9sSMRLs/B//l4Rs5oIysvICuN6RNkMWETF3aultIlUENO+gu3ca2+rp+DmuEw
         HygnAAg+sup8lrns6+UtlXJFZDB+bK8VKm/nOgPfkjBEGb1X/rDq+j8COVa5X46VtNzx
         1lAVN6vb/+wv+3jIeVMRXLP/AfKg6+r82QV6njhdll703XLlJuGs3AaIf2HF6tGpl3xV
         JjHH8GG/lULMjsVpVkzPVEHF85jMHPBomBCuXOtZlY2Fi0+j92MoaTGS+Zq/YXSm1dce
         /YyA==
X-Gm-Message-State: AOJu0Yw/VYeTQPvhW1z4k+3PO0o4iifHbnHXUbxP9IQ601YNi9Zvx6lB
	rkz5nrtI+Khze/t+cKjUkt8t/FpVjZFFT6DLpYsflUThjhQ0+vrI
X-Google-Smtp-Source: AGHT+IHpBqNRlWb+YQdtBgDXpnjAVkgZy+lTxreRSZ95xm3pfr4u9sev5QszOMAxbzTzZkwYgG2+sg==
X-Received: by 2002:a05:6512:280c:b0:52e:764b:b20d with SMTP id 2adb3069b0e04-52ee53dbc96mr6260305e87.28.1721402018891;
        Fri, 19 Jul 2024 08:13:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:c340:aacc:e30c:ef24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c951109sm42728366b.217.2024.07.19.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:13:38 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH v3] drivers: cacheinfo: use __free attribute instead of of_node_put()
Date: Fri, 19 Jul 2024 17:13:35 +0200
Message-ID: <20240719151335.869145-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
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

To introduce this feature, some modifications to the code structure were
necessary. The original pattern:
```
prev = np;
while(...) {
  [...]
  np = of_find_next_cache_node(np);
  of_node_put(prev);
  prev = np;
  [...]
}
```
has been updated to:
```
while(...) {
  [...]
  struct device_node __free(device_node) *prev = np;
  np =  of_find_next_cache_node(np)
  [...]
}
```
With this change, the previous node is automatically cleaned up at the end
of each iteration, allowing the elimination of all of_node_put() calls and 
some goto statements.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
This version is submitted as a regular patch after succesfully testing
the code to ensure that the cleanup function is called correctly at the
end of each iteration of the loop on the `prev` device node.
Testing was conducted on QEMU using KGDB, with modifications to force the
execution path to hit the changed code.

This work follows a previous patch [1] that introduced the same feature
in drivers/base/arch_topology.c .

- [1] https://lore.kernel.org/lkml/20240607163350.392971-1-vincenzo.mezzela@gmail.com/

changes from v1:
- Fixed coding style that was triggering checkpatch.pl
- Link to v1: https://lore.kernel.org/all/20240622152526.131974-2-vincenzo.mezzela@gmail.com/
changes from v2:
- More detailed changelog
- Link to v2: https://lore.kernel.org/all/20240702170241.104934-1-vincenzo.mezzela@gmail.com/

 drivers/base/cacheinfo.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 23b8cba4a2a3..7a7609298e18 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -202,29 +202,24 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
-	np = of_cpu_device_node_get(cpu);
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
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
+			struct device_node *prev __free(device_node) = np;
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
+	struct device_node *next __free(device_node) = of_find_next_cache_node(np);
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
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
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
+		struct device_node *prev __free(device_node) = np;
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


