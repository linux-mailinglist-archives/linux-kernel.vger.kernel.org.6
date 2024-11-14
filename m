Return-Path: <linux-kernel+bounces-408790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8C9C8393
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17613B26D32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12075198E96;
	Thu, 14 Nov 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AqMGLjUR"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B91DF72E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567660; cv=none; b=CvRZja37Umhv3AOB/5B9TIuHHvVO9RXvcja3lrdA7OIKExQ1rs0QynxcszV8pJIkyYEwWfkxUGghw4zQCgAjAOIiKc4nyWvDMvIjb281OPFluGgzsC4iTKzd1v3gzOIxyFYD/0T0FC4ZxlPfcG/Y0Gk4QEaZf3S+F0oijM2Qe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567660; c=relaxed/simple;
	bh=HfyPcE4EVfhBh9TW3UzFkypV2P4q5U6i4QfATr5vBm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crbq2HrsKWtvkI8AJhVuVuXtC9aK9G+nJL3VRhFictf+whgUPMgXTUDjusANyEMSh31hiGU8MbMrSBaO/guH+1hu4U5ZutvQDgRtlPCnahjLq5qpHArqLRWD19Ob1ADB9avQxeAwZMBOtDZgbXww5nmnwnsFUU2hJ5wlL/rhF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AqMGLjUR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so252461a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567658; x=1732172458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQVB91K7fAT15psCxftJJTVCdE7dh3d9kskucoAkCus=;
        b=AqMGLjURuTx+he+Ux9DARb+1NwSwKiBh+TbbiCK7NndGGyrKUHWn9zm0wQtZ/s2gdF
         uqOtwYQ+vxDggDlVkPFIIf11cHwVw9mRJSyI0Ghj9F340Ympt/KBNuOXhFGOhdrWyhTr
         k47sKlL/4Y0O398MsI0w3utZUFPYBb88iIPzl6VB9GgPP2iQD/RutOVelaMjd22ZEHPL
         kiUqWqG1SDvaynP7zvKC5PTzgb2p6VlfhoiykN8GQh/+G0n5k6npupqszO/h9aXUcGlA
         Hff1ytNTmE/sv/a2N/YCIPlwNX8p3yaGGduka9rUGJ9ZvJe1e0M49bwxkwDjwDEQsMcx
         2EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567658; x=1732172458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQVB91K7fAT15psCxftJJTVCdE7dh3d9kskucoAkCus=;
        b=d+CC0BlEw41ZuHdjWBt8g9Khh44upEkSEi6szxEumwOvs3olVGx2OtNFf6c4pxCNal
         J/ipKuzi9bDtzCf0mj9+3wcMPsarzI9GRhooPNtbiERpkAIYgd1bLU2MfTK/6XdcJ90G
         yzKbHpP6HpNT/5I4jBGyJwywLcGOOdllXz2yu5UCnIt9ZCJRQfcwHzFPhVho2PlrfJKy
         McCauyNxnb1f7lCOMNY8ZviHb0YUYrL39FfYDij7s48dEPCAjiVXaLspFChWTFi53sBa
         Zam+mkW2xFCOWCNTzZqICE0Mo9DgnIercl2yR3yigI+bbdkI5bt6g7Sw6hHbvo0nxrFB
         R+7A==
X-Forwarded-Encrypted: i=1; AJvYcCWPNJ569OiY31qFAC6btxvZ5kywa7SC7CVeszkROAWBVUXAUWQbei+2yWnJ14VY5VnVMs52XydcKZP4NzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEN/ZBtOXFbtz87wemzXQF3EDGLpvUqpuG2RE328akajlDAB7
	mbl7/ZkCQr4b+lgnMw1jnlApSd4RzDVBcTu7AvRkp3CRH8dFKO09z/ZRfgnLFeI=
X-Google-Smtp-Source: AGHT+IEEOci5upVGjhq10Ml46AvoKHnyJ01pyJF7RhtSq5zmKJYKrXkqxyrBi8tCjSUuj7BETevvWg==
X-Received: by 2002:a17:90b:43:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2e9e4bed427mr12110579a91.18.1731567658258;
        Wed, 13 Nov 2024 23:00:58 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:00:57 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Date: Thu, 14 Nov 2024 14:59:55 +0800
Message-Id: <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces skip_none_ptes() to skip over all consecutive none
ptes in zap_pte_range(), which helps optimize away need_resched() +
force_break + incremental pte/addr increments etc.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index bd9ebe0f4471f..24633d0e1445a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1657,6 +1657,28 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 	return nr;
 }
 
+static inline int skip_none_ptes(pte_t *pte, unsigned long addr,
+				 unsigned long end)
+{
+	pte_t ptent = ptep_get(pte);
+	int max_nr;
+	int nr;
+
+	if (!pte_none(ptent))
+		return 0;
+
+	max_nr = (end - addr) / PAGE_SIZE;
+	nr = 1;
+
+	for (; nr < max_nr; nr++) {
+		ptent = ptep_get(pte + nr);
+		if (!pte_none(ptent))
+			break;
+	}
+
+	return nr;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		pte_t ptent = ptep_get(pte);
 		int max_nr;
 
-		nr = 1;
-		if (pte_none(ptent))
-			continue;
-
 		if (need_resched())
 			break;
 
+		nr = skip_none_ptes(pte, addr, end);
+		if (nr) {
+			addr += PAGE_SIZE * nr;
+			if (addr == end)
+				break;
+			pte += nr;
+		}
+
 		max_nr = (end - addr) / PAGE_SIZE;
 		if (pte_present(ptent)) {
 			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
-- 
2.20.1


