Return-Path: <linux-kernel+bounces-395413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B49BBD9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D861C21815
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7F1CBA1F;
	Mon,  4 Nov 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKNGqZli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D341CB9E5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747019; cv=none; b=fusFV/X3PfEyL1bWQPx099D7ZyaTvfsI/WJ6ZG6B/GUb3P3nBudtQA8a5Jas2LsH2eo2u54WgIuBfztTKSGcpUceiqic72zjmBmRy3sSL3Fr3a8G5I1UAx9v/Y2CxF4mls9A8KyncUAjb8Dgcn6ZBNRCIdd5Xkzs8GMezlOXk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747019; c=relaxed/simple;
	bh=R0Qg56xIrvqgc08eimMMU708silAc/1YGu+MVJ96B7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEwuBx/IzGC/A31GvU95y+IHfVHdHHMnXKRVpmcDoHLeOAOIVbbPuSaNamibAtTm6vfZnKQRG5Tcp0NS/grsQLcJ5BD+RlMtALjTXU0ex9QUZT92hZH3u04jzepHUTnWHv4BUfCkS+p1JDqB+3zZ5ENX6Ap12/flS2TdWIXcwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKNGqZli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E31C4CECE;
	Mon,  4 Nov 2024 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747019;
	bh=R0Qg56xIrvqgc08eimMMU708silAc/1YGu+MVJ96B7M=;
	h=From:To:Cc:Subject:Date:From;
	b=aKNGqZlihdRw2rke4lTQfc9RRkix/t9RVS6C6QdZmQXc6+doZoNT4gWh75xCaeEoh
	 XUZzqRFVp48X1VMaADhSvFMJroYcQ5UUInU1hjEOIQKtNd0O8nRi/aRemJb4eFz5uZ
	 Xhv7HBno8AkVaaNmr5Ta4nsioYKzPZl9Z/OFQBxigZQNlgfFBuXZBOgK9Sr3jKAupO
	 9omHqSpaJWK8XqN23ZOCsnB5eYyFPRs6kqPmrL0bDQo1jxyg3nk0/KhXckrHc4w24d
	 w/gc5RGSb59FMQaDJQCcho4kes94jjU0hDro1i1pPuYlc6e5cNMyX/KTc8sSW1QFwg
	 t1f0CrX9kx1Yg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: cacheinfo: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:03:13 -0600
Message-ID: <20241104190314.270095-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/riscv/kernel/cacheinfo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index b320b1d9aa01..0115051fa1e1 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -105,11 +105,11 @@ int populate_cache_leaves(unsigned int cpu)
 		return 0;
 	}
 
-	if (of_property_read_bool(np, "cache-size"))
+	if (of_property_present(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-	if (of_property_read_bool(np, "i-cache-size"))
+	if (of_property_present(np, "i-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-	if (of_property_read_bool(np, "d-cache-size"))
+	if (of_property_present(np, "d-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
@@ -122,11 +122,11 @@ int populate_cache_leaves(unsigned int cpu)
 			break;
 		if (level <= levels)
 			break;
-		if (of_property_read_bool(np, "cache-size"))
+		if (of_property_present(np, "cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-		if (of_property_read_bool(np, "i-cache-size"))
+		if (of_property_present(np, "i-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-		if (of_property_read_bool(np, "d-cache-size"))
+		if (of_property_present(np, "d-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
-- 
2.45.2


