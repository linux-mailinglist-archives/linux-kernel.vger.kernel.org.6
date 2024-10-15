Return-Path: <linux-kernel+bounces-364971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5629799DBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B41C228DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27C18A6AB;
	Tue, 15 Oct 2024 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TESLRL/0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9A1537DA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956088; cv=none; b=q1PwUQXzCVFUEB97f04Sqo1Vfgtwiq4oaTlqtaYxHtw2IYg5xHgXsx8cc2S+Xua+1bqsortqudIj2zgzDNt6gq+jQJcWLezGUNu4zjNqlCGSLR2fr2/PFldG1KpJA2NM0XBoOJSp7tXtgsyVtIPLbLbAXqGzZx3BzDteP24DUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956088; c=relaxed/simple;
	bh=rKAkwnrKqFe/pXWHE++1cg7Hf02Exo4/eTPzv1Uabug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+g8HHH3tu22ETseyjrRKoJFwpRCwUc62MIRJjPBYofuV8dtyQWS8LXmcb4LGZ7Q5ziiTDo7A0wTY8EmuwV+PT2dJSekTbGerO+uVeHxavns2bELaOnNNbFhukyfUtJZq6is86ydphNXF2ISeXF+2T2GFKaD7RYjX9feP1cjQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TESLRL/0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e6f085715so926890b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956085; x=1729560885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5daj1tikBz1GmvjDxbc2gCsvgSNJoz/zYutj+6dtSk=;
        b=TESLRL/0/Cqie+7c69JbbhqzWUYy2Jftn8sBSvAcG1bxAFM9lxGEMACVOREzG6OyLG
         Nc8CGSa0DUqM/smGNeo/61tBaWxXEY4jHiFs4JhNWI9k1fD/KUANi8QwazHpcyjAgow9
         JXRE3HBLaatOfG5oCF4+qEZA7e960JuCT+PsJbBXMPUwXpsf4cpC6xreeBqICtwJ9+tn
         l6S2f+lQjDaRr8P57y3YvUrMIy81JQ3GLnJeKxHiVvEbtOPMFHLKpZdOnBsBRo7yd49k
         qrGadZ0ei8oJX3GD25s/k7UFhhTBKRLtH+2+hqioIC+csz0iHRNHFbPn656byA1SHeuq
         lBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956085; x=1729560885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5daj1tikBz1GmvjDxbc2gCsvgSNJoz/zYutj+6dtSk=;
        b=YIX3j4JPz0JZ4v5SyIlXch3jsX7QUr5a21ZmkrKFYXHIY6/VTZBnoRU8c8+xqr+5JX
         H3ScV8bQWymR1i8gpdYmWb9IYWuQeFczjzMHzQIISK3AjV2nkeKCneXXqhVnNGOTD8tz
         9CmZFohPZzyPG5xQvCjdUXDBWlD6nBqa9XWjHU0GgimK9wyZ5yFdIdm1a0CPQBhXhYpZ
         TxakcOC6s/sFTyb8s6gdEWfo4cq871uw2Dh2vVDgXiBYw5BnKPkvDyd2er64QL22qsVt
         QylswszYN6gUCoxociz1rSKkrV6EmnHmVi94tnwW7bDMn9EsdIgH7KEuxh5S5Cep4Xoe
         A6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCag0jiFj0hnM6SwNPF5Zpu2/Dfqqap9AC2xmcGTLs37M1yDeugMRM8n618n/e9LexWC9wW8v0s0oTEHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoyWGUuqcg3xtUxJMvTV3CrcLbUpbL+KRkg7vF0lOrC7FmqK5
	inwr47K2k5+8xt3VL2ZYMnJ+Hfy7LVRv1bT/V6lAs6KXTlNAe0Cy
X-Google-Smtp-Source: AGHT+IEs2IxrBsPT6YXEgz2epQyHoorcOdT0d4hm7NYr74rGWRI5/0uchu7H7p2tlDXCJav5W/E8eg==
X-Received: by 2002:a05:6a00:3e03:b0:71e:3eed:95c9 with SMTP id d2e1a72fcca58-71e4c1bfba9mr15531178b3a.22.1728956085196;
        Mon, 14 Oct 2024 18:34:45 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:44 -0700 (PDT)
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
Subject: [RFC RESEND v2 12/13] book3s64/hash: Disable kfence if not early init
Date: Tue, 15 Oct 2024 07:03:35 +0530
Message-ID: <29cca55915a923d1823644b37fa571234f9ea549.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
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
index 53e6f3a524eb..b6da25719e37 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -410,6 +410,8 @@ static phys_addr_t kfence_pool;
 
 static inline void hash_kfence_alloc_pool(void)
 {
+	if (!kfence_early_init_enabled())
+		goto err;
 
 	// allocate linear map for kfence within RMA region
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


