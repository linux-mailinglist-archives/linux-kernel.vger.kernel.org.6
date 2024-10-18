Return-Path: <linux-kernel+bounces-372128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194A9A44C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900561C22DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0C205E3B;
	Fri, 18 Oct 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3MCwPtK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9F205E06
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272679; cv=none; b=lNwUeyZQT9K03tgfhju4YBAAzHo2Cij38TkDX1MRQpMiOZ51Eo9atqmgHIa5FThpZxoxwnrqtLE3oZk0UBVjvl0PljIsXi8luMhFhYXhcuFA4cMgIyw0v2pCOdHbwyYryo5tW2PMg2R8HJp0eD3BLDsGI26aBJhgKZqvcPu5lSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272679; c=relaxed/simple;
	bh=dfXVagvKCrtVIK4lQC9jHDb/cboUbJl9srs8w+qOFtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBk6xmf/CsFizCAYVwz+IEPy+6Wbu5QeGBL4/xt+d/wlCHdo6v68LiPVL4sFopSaLW7Z71c6esyTDSKVl+YKoZM8DbBUUKCjDjPsPp2pIYo5MsKJGQ0CT4o8hsnCGC4XSoSEseJHbfRi2QD8kuO3rwy/LxhePf2RY+nqoNvsE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3MCwPtK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1573523a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272677; x=1729877477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+pQKseSbUwQ7nDgMGbwYxJsHyJez2ZBxycyN9iER7I=;
        b=N3MCwPtKI+88BAI0jeG6mPQUyvz/qGEHP7FKzjIPuwtsn91S8IHAYIBCdda3smj5xA
         81o8bS6++qYOP30cfoVicxQTrOhl+Xnphc5uZb63u3/5IA9zFeG9K/Vy3F91RI6e+LTF
         uN2M20QsWc0/R4mJgunLGE3bk1ppKPFGLgZoUb+VxCtrRkCZHYr68RycfyogiRjl5aNI
         w5Nr9z2NkVAepoXrgjdDRo3j2gYRwJHUyTq4YW7y9rJMdMp7m5iA6ANhqOEp4LPr3HII
         3STAh3X+t/SXsPoPRiry4XZDlo77GEdex6R2qln5uMorjED01HvooAJlcqdhOW2o/uCX
         RgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272677; x=1729877477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+pQKseSbUwQ7nDgMGbwYxJsHyJez2ZBxycyN9iER7I=;
        b=gejKZGgvJccDUnFZWFkARByHuQndJPCNK6loDsDZ9pQtBuOdjsuF3DkMAqrP3hkQg5
         6wA8T8lHX6z3uNC+kbxJCxbkUsuJJ03fzKtgm+TP2LXX3hWIXeefPsk3ryFvSpAW5gml
         BaWmV/fVif6erRz8sQ+3r5obxtWlTPVJ7VC08jfEdMUBHWtweu8e76fF5itTvOB5l/iU
         5tLGWb+pLd0/YSmwvc1RKU4EjZITY9JRDboE7cIk/kQyaS9/Zi8AVKdOjb7S4VXY3bHo
         LQnmsl9afL6++e25gALGNz3vcnmRx8rz2WMR47S7rp4LOP4NrOouyhcyeEqRQ54/APx7
         oc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXN8dD/MEqAQBrtlE2GaY5MfofkM1+NXFg+6nSwE6qepczG+ZXwR4rO32ogKecLUFVtSJSoNLh1s84L4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFao/XWw2t1rjeJDmyyOJckwt1WZkXQtIy7Dtoytm7Mxo8zRLQ
	5BhjGc/hPjK4gEhXe5o3z8KV0Ap1+EQ0L7TQfd+Dk8F5kyu4kkhG
X-Google-Smtp-Source: AGHT+IFVWe1xUi/sLyBKrxUXKe/50HIPEi+N9laTmy/mjDBIPEDqbRrd1jNCsq8LdLHdy/KQ/lg9Ig==
X-Received: by 2002:a05:6a21:168d:b0:1d9:61b:9607 with SMTP id adf61e73a8af0-1d92c4a0231mr4271987637.6.1729272677039;
        Fri, 18 Oct 2024 10:31:17 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:31:16 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 11/12] book3s64/hash: Disable kfence if not early init
Date: Fri, 18 Oct 2024 22:59:52 +0530
Message-ID: <4a6eea8cfd1cd28fccfae067026bff30cbec1d4b.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable kfence on book3s64 hash only when early init is enabled.
This is because, kfence could cause the kernel linear map to be mapped
at PAGE_SIZE level instead of 16M (which I guess we don't want).

Also currently there is no way to -
1. Make multiple page size entries for the SLB used for kernel linear
   map.
2. No easy way of getting the hash slot details after the page table
   mapping for kernel linear setup. So even if kfence allocate the
   pool in late init, we won't be able to get the hash slot details in
   kfence linear map.

Thus this patch disables kfence on hash if kfence early init is not
enabled.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 558d6f5202b9..2f5dd6310a8f 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -410,6 +410,8 @@ static phys_addr_t kfence_pool;
 
 static inline void hash_kfence_alloc_pool(void)
 {
+	if (!kfence_early_init_enabled())
+		goto err;
 
 	/* allocate linear map for kfence within RMA region */
 	linear_map_kf_hash_count = KFENCE_POOL_SIZE >> PAGE_SHIFT;
@@ -1074,7 +1076,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();
 
-	if (!debug_pagealloc_enabled_or_kfence()) {
+	if (!debug_pagealloc_enabled() && !kfence_early_init_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
-- 
2.46.0


