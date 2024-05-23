Return-Path: <linux-kernel+bounces-187382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492B8CD101
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEF81F21AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7099145B3C;
	Thu, 23 May 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HR57gyKi"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7181AC7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462826; cv=none; b=ohzVT/JUJH3QAIwy2t5t4t/ZElfhvRwrpINAEKeRgYyFn0nsYVV3vTGjVxu5VKTXaKiGkVSroArcgzM3MdNfrKLiPap07vC/+TNjFy4hjwx8033kNDZZ2fp0wk6xBoI/RWXpwaQAkLr5qldisa1bNYetfrvMoI3frGjpjw3obUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462826; c=relaxed/simple;
	bh=f1DDzJv3xHeLtz/8Uh38H6uqD2mqnmTd8LGL7fsQk2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rg0cx+/pKZ4Mq2zqNUpI8Js1MTjO0dHh8LL1D8fn1nP9/JuISZqvzVVETKtkcBN54A/YxfOCEDTkRPlDC0b/XF++2hYd8jRYb4mitRc3IVlUX2c/xQ4i1Krx9oxgypljOsHxRatcL7Mz64C43q/ovuvCfgf1jO2iMc20gK2dC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HR57gyKi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f3406f225bso3678665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716462824; x=1717067624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=HR57gyKi5zIzh0IZ1XOhdMr/xGQYMgBsTFhXHRufptcwgNjM+zeUrYCeN2P4blt9Rj
         jxO22nqdFpcFZGKLvV2Fyf4NSvRb9uVhDEi+8C5Qb+q4BMbnQpmBut6FWHvJKMtwTvnv
         IMn5e11KZ4exqSAIYLHOtf8sIWOfgAhh2FNQlLpmHR+tpqGDZWDyGbXA9RmvRlJNkBHH
         eXqtwKQYI63oTBImgDAiKtfGjtsHbxCI23xavOmltUo6BCLpeoQ15qotIMhcEExPwQZb
         AoV5ztfDBFG/cMIVPfnsFYM64a6Wnj2p2Eer4fRPZeVTKdW8sCFNhix1dLPNXYlmB/JS
         WdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462824; x=1717067624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=bKbGC0ur6YYpAxa4aW75qnJgtpknkm7sUGigNXbUq24Uo39byUUKHpGhNqz1oN9nTl
         tFsxVIhm5BithT9zaZiq/+FdPIyWjUDisCdTUvKbxj8eeIzp+S4GPJbAczpn9AL2viJ6
         GWQz5/EQy+sj9S1botLcM9C69fqKCMNpG3mkWeWV43/oP5YrHkamuHj6UPYwo0nZ3/6f
         dcQve2UsQiNIdIT9ZDXWI/j0QemL68rtM5UhtIttY8bT7BQ56HyCrfUSc4AEyQAj/ISF
         Dt1fZvbsiJoSsboqyVeTZJHDe6jlSZMvru/J4+BUpXMgQxRvs3bjkvhcn76CtU1JGpHe
         +F6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdgWYvcVSKk3y2skCr04QJHwmQYg6AM3uLUo94wt3b52d0bZw/EQwo+gDRfqQk+bXFImlaqzWI2n3f3R8SRwiYRM1MfFPEaThHZ9wi
X-Gm-Message-State: AOJu0Yyo0lges3ZZJSTIrzvH1NoXaTAlSfO+TKk6IBz3HYS29zMbpkKO
	yDUQQQq3CpRlXWMUpiuBRNiXdvh5Rj6//RrEEDS+qsvRJwcA40z3mOxqxROOh9M=
X-Google-Smtp-Source: AGHT+IGfvwX4nHErQyEQ6tKcNt4WXio4qE4pV5EfAuWWShz5bnwIL0deO6asuZ7WelH2PvE/SRuq2w==
X-Received: by 2002:a17:903:1104:b0:1e5:3c5:55a5 with SMTP id d9443c01a7336-1f31c95d67emr50609535ad.8.1716462824368;
        Thu, 23 May 2024 04:13:44 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fb4ca0ebsm76399555ad.119.2024.05.23.04.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 May 2024 04:13:44 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	sunilvl@ventanamicro.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH RESEND v5 1/3] riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
Date: Thu, 23 May 2024 19:13:20 +0800
Message-Id: <20240523111322.19243-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ci_leaf_init() is a declared static function. The implementation of the
function body and the caller do not use the parameter (struct device_node
*node) input parameter, so remove it.

Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b88110d1..30a6878287ad 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
 	this_leaf->level = level;
@@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
 	int levels = 1, level = 1;
 
 	if (of_property_read_bool(np, "cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 	if (of_property_read_bool(np, "d-cache-size"))
-		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
 	while ((np = of_find_next_cache_node(np))) {
@@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
 		if (level <= levels)
 			break;
 		if (of_property_read_bool(np, "cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 		if (of_property_read_bool(np, "i-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
 		if (of_property_read_bool(np, "d-cache-size"))
-			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
 	of_node_put(np);
-- 
2.20.1


