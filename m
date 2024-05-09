Return-Path: <linux-kernel+bounces-174236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C08C0BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6C6B2159D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E7149C4C;
	Thu,  9 May 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aqfQ01hI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F4148318
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240035; cv=none; b=mZ2uALJlFAV2jBAHLC0utvxQKtHfgq0/oWphZcDmZSX10kaCFkbuKAr8KRKtNodDShuArIpfKhHYgwXWZ8Xd3WOhT9yzjm4PzJVIstHyjQ5cFGGOczvQNAt2SRQN6IiA+m+eEN3dqbFa7YQNB4eb23qlrCuwhXtvPxjGPZbYBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240035; c=relaxed/simple;
	bh=f1DDzJv3xHeLtz/8Uh38H6uqD2mqnmTd8LGL7fsQk2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGHF8i7IvN9ZQyVhwHbIq1EJ1dt/h2NSj+vQIf7j6tunhXYNn71z8DaQfIamgSEoOqhNtqzcxXOvN7e38C3nDaCjKYi8dO1ue1uLQdsWNkWSPx6SmKio3R8za6QDBcOrh/rvKsA3urr2ytgx2x6dMUC3gRQ+J1YRFKnslx2vp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aqfQ01hI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso4611805ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715240033; x=1715844833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=aqfQ01hIYY6LFNp/UQ5dLvubDCRG2/sLLSALQUBi+Wlplrx5tk2Wx5rdy/FJPMWMLI
         zjGNDZGSl8+Aay5pLWs3V1ncqpUwnPrD8B5bK1pBums+YbqOizIDpn//cX8Do0+moepi
         nuxLZ5uU8tTJlCW5rlfmTQRuqCsEuwpE5T4gZ3mY6BGk+2ls7gNpTFYHp9ZcC49FSO1P
         +bd0pqsih40lvi0ApqXUKbLHdHD5B+6rX89NjUbry4HeyG+ty44px2pK6tzqVqIoGnhO
         lAvnXludBgkIgs/3LQ8O/vJDJeNw/4tFlqK01xHLE/MJR/d410QFFgJVTv7xey3gDFVB
         dOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240033; x=1715844833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aKuxY2Fk4OLcsa0CSr6w7+nYt28fnnuhVioZfggdrc=;
        b=tpqgxT5u50pklICo7KqAf8+7Nr1wcAaTM35VfyLm1LJm2qjdy7Tf0Au7pPPFFrCBh7
         FUHRAOB7K580Cif7WqjO/9btwOOXjSf/h72xHSm5RSaf3Eu/urcvvVj3Fnfm1fX81dIh
         EbNkJtj4T9/g9Z3sJJCZwYxHPvxahh0YVqkl6LInWVQqz/ankvsg/ean7Eu3/1GjSMAf
         jRHXjbH8jaTVEs8OYJC+7GYnhHMkSndSY3fpOBu1CZPsajqXPacmB+x4XhJVbPsirSGn
         l3cRNhoAvUdIDBhaC5R/SL3H0BrMQmvFa/mwrdDlLimW3BCOAbvgmNYzIe9F6/rvap2b
         f1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXF6xLRTgcmDfouOG6oKi+ehSPPz7h4hwVLFuSt/YujEpyEalLSaji2/qKfZTtSzzbE1+ohtRibEA0KPVNSIhHP2AYZ1eKcn8LMKeT+
X-Gm-Message-State: AOJu0YygxPg0z2AbQnyn4j5AVuU+YkWWryTw0vTq3/BVjsi5ifl4ai+b
	NUpkuamXwYCzo78yW3Qan7LilMTYSmDV8zDAQztRbawJ8XBjdjmkk5QbvHdzeRZvfk5EpW01HH3
	jDvM=
X-Google-Smtp-Source: AGHT+IGAYwKBi2oqjWz3LiGpENreMeENH67yYk920FAgS7TcHb0bpY6oL9Li9tUP+YyE2Ur4qM9EGA==
X-Received: by 2002:a17:903:40ce:b0:1ea:9596:11eb with SMTP id d9443c01a7336-1eeb07973fcmr50940325ad.60.1715240032758;
        Thu, 09 May 2024 00:33:52 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcbacsm7519045ad.97.2024.05.09.00.33.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 May 2024 00:33:52 -0700 (PDT)
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
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v5 1/3] riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
Date: Thu,  9 May 2024 15:32:58 +0800
Message-Id: <20240509073300.4968-1-cuiyunhui@bytedance.com>
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


