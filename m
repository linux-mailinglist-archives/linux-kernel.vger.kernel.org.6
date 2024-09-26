Return-Path: <linux-kernel+bounces-339976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898D986CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F45C1F2486D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E4D18E35C;
	Thu, 26 Sep 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Jc1DqtAp"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62C13D276
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333302; cv=none; b=rXbrOceCbr8kdtTCiuANxCw8E2/NRS0UgXFgG9XXgOqlPLlp5GSEeOH4EdjbtL0EodIxRgPGvEj9On4xzAxc+4WxceCodCt1U2LM59npyh92YBh0rTTdEmvrSUXgQjSkdojC+8B116Kg0w0wl2QBoJp1C44Jvj17p/jcUy0DO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333302; c=relaxed/simple;
	bh=KpepB6xnCL6q51Rr8wjzoDqqKsBPVm70U61A9qPEoYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUB61BhouImyNJ0jydJv1lLR9MqFFKEutnYX2C0Vk9R1EeMJqLwa4/Z6yP+1zGq7i1UnEeIj2TENbPTjqHPo/Wzzvopuj/ZQICUzq7fYPEUuIHR9OLIuMng6gUA2qdYtY8uc7RCZVeO+A7KKGSez1Hq8G/ZXYGshg7uqLXFY3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Jc1DqtAp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-458311b338eso4504891cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333300; x=1727938100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKWf8ZYo9tlbP3964sEqp7HhdDy32FNbDdGL8iSt+Ok=;
        b=Jc1DqtApy/SbXyTgs0vmdhDWkpAG72ca1vOOMrZHwwaVMjvLCl62d1MS+lUBqV/7wd
         b9staiftbiSvo61J+bDD7RMymty/bZHE55ZuT8stCiht/3BIO8NU/HyZEEHdnY24ewVD
         Rc/p1hHIz0HVG2wIrLZ8jfSbfIRMtwfdcTWS+NJkDIJb8KspENIeNEy7WChbaTMybOnA
         as7FJ1cqnmxdIbtCK+Q1o0aO/efy2jWHrhWpWVnkoefQ2GwWyhcmvyCsb8kXdIlOYMWf
         Jizcnj+OMmALaNCshsrYw36RcY+3ko1AZ15s/cql6hSePm+HlBY30rY4jHo2ab1ZFwhE
         zcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333300; x=1727938100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKWf8ZYo9tlbP3964sEqp7HhdDy32FNbDdGL8iSt+Ok=;
        b=Rdrsc8FVcnH4wxTFAz1dB4YuPTcLKqgZaavTmoTEiyINisrKuOnHun+FYuFuywJpzy
         ZEvgV3UHfveBrhsXqv/LBkOR4E6iyA9X7TyRmp33kcv7/AtJTg/pmhlcgI8opdFW+59n
         PEqNLuhuQ69kYv96VHZgD3BAbFlJy5rgeAgyDV/9UCSPzi7x00MzABJz2SYYZhHa2NS6
         G50U6RB4OrQq+XOiZLjLoBjZZ/xyRv0EXHB0lFnaTSaGRF7R8c8cvCFx3jyC2nMHhioc
         H/iZu2UPSd3h/5VUn+IlLNRRjhNHFyCs5cddjOTlj8AAK9noHdBrP9KDhpmldtFnhPKS
         Jg1w==
X-Gm-Message-State: AOJu0YzC3SvLMA3klyNi4EuMiqcAtIcGbULL+nmhXk7OAQM7kgNRaLla
	dPvqCPzrQT/fP4CiZ1YcCVcC1pWVdgwjrPGdimsxJcVEX+UbgK6ZV/F/bwVSkhU=
X-Google-Smtp-Source: AGHT+IH0PykjARYOlhRdYD8Ei00ntSXkZvlp+w/DvL/wK29HFMzX/PK1qWz6iq3HMQhndU3PBLr5iA==
X-Received: by 2002:a05:622a:51:b0:458:3e20:65d3 with SMTP id d75a77b69052e-45b5e06627amr81705351cf.60.1727333299714;
        Wed, 25 Sep 2024 23:48:19 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:48:19 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 12/13] mm: multi-gen LRU: walk_pte_range() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:25 +0800
Message-Id: <7e9c194a5efacc9609cfd31abb9c7df88b53b530.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_pte_range(), we may modify the pte entry after holding the ptl, so
convert it to using pte_offset_map_rw_nolock(). At this time, the
pte_same() check is not performed after the ptl held, so we should get
pmdval and do pmd_same() check to ensure the stability of pmd entry.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c745..bdca94e663bc5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3375,8 +3375,10 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
+	pmd_t pmdval;
 
-	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	pte = pte_offset_map_rw_nolock(args->mm, pmd, start & PMD_MASK, &pmdval,
+				       &ptl);
 	if (!pte)
 		return false;
 	if (!spin_trylock(ptl)) {
@@ -3384,6 +3386,11 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		return false;
 	}
 
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		pte_unmap_unlock(pte, ptl);
+		return false;
+	}
+
 	arch_enter_lazy_mmu_mode();
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
-- 
2.20.1


