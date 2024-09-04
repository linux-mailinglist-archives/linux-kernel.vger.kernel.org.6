Return-Path: <linux-kernel+bounces-314566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9996B546
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDA0B2922B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569491CF280;
	Wed,  4 Sep 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TU75VRcD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42574194C82
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439258; cv=none; b=TV6Zu6iPfilqSHVMOtngpr20XZWlR8sMzS1FX7w0mHWXcQ0Fy2Diig+LX/AVnXIsFZo2YRPJBBrtHDHU3k+pyEwECimqnqIQeisCAH/9K76n5I3NUb9BTSskKMaC0ZxxSUWZGMBemB+iq7Tw4uh5Hu6IV644LTKdaCgxw3pRzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439258; c=relaxed/simple;
	bh=c/yYCNxp5OWZX71e2ENivdxcb3XkxtbTNr4k4b77EWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7KUCvg0HqwL47oyhbn4HcTO3R2oQhmoKupZWE1UmVwyxo/8s/xkIlmsb+Y3bFCgCuXfj0NHR/4QqFhX6V33oTj4fSuyUlJktBt4RDr77Eux/a1Tn8AoFyYUXQFykqwKfl+dyk8dDShUN23karmZv2dehA7K2XQcwPO3mh+99BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TU75VRcD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206aee4073cso6770375ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439256; x=1726044056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/kyF9mn9oESktxWYdr3s8d2VJ5iyYEZZY3E5BXrvv8=;
        b=TU75VRcD3UjtW+11f2MplaOTrUw+snGqTPk2JncPd1FVYH6k4hKkf5aKmr8XCA9PVv
         Mn8/Xnaft27VKfWMfDM4ndGiYRElvjm06/ctbqsz/SNJ26u2G8wK420Xenr8nWVZUi0d
         0sg0ACmOYbI9O4Wn9BD/4lxJmkfGxl7I9cVl9ZixfVQiiRfjNi+LWNaEmnDQYuKWh0kg
         HjzN08p1u7hMpbY5KUZ6JIJRe4J6MLXKpIXAVFeQSygewMB01MAl7GlPRnXjRoOvCl7N
         wKhqmOrK0H5Q13c1uXqMyzadrR0Sy2aLNBH7Kij7bMmu0/rZPeA4HKJaGz4yCo1k7fGI
         60Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439256; x=1726044056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/kyF9mn9oESktxWYdr3s8d2VJ5iyYEZZY3E5BXrvv8=;
        b=C4kXCFmH70smSCO92nmbbo1ncSAtPNZOLOmq8A8ZV78hsWkmZ2Qlqjquj47e7LgGHx
         DV4dbaaLkecgBvWnqqJkibAY/bVQYGxK73OEF+TJN05GKKUvgr9gu5Rp2OHG+an/aikp
         Jps4kEDtyIfyLZa/xpNv7klKvS9GKm0mgTXrhC7MiXAcguj4sVAY3nEW0pz25RCqVx6w
         LSU1PkLZ8smpScWGoffqdJAvterD0k4UV/EAtq5anfDYTx+eOzlye2igus62v7hMEFrd
         gS+M0eIfaeI/njyDIF9a7XyCcGrLEIt6DWypT8Py44G03rHeEdOTtcLb/ybIeCH/ERuD
         cwdA==
X-Gm-Message-State: AOJu0YywLp7O1gVLj59Nm3xYFPnClD8sykq+qgRXmsdAW1Q9jpn6j6Il
	BGPKuIENp43jDa6tY6ayr+M0qUGW8q5vi3V0Ia82K/mLFf0o3jBQf3zm6UJyzyQ=
X-Google-Smtp-Source: AGHT+IEEdhBdCGQBBk6sF5V8bi+PhpxKTNotIZgwSj7kMgQxLZV/04loActQGvyTL5xDqZZl1Kbj6A==
X-Received: by 2002:a17:902:f547:b0:206:b618:1d7f with SMTP id d9443c01a7336-206b61824c9mr14802495ad.37.1725439256381;
        Wed, 04 Sep 2024 01:40:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:40:56 -0700 (PDT)
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
Subject: [PATCH v3 02/14] arm: adjust_pte() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:10 +0800
Message-Id: <20240904084022.32728-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_adjust_pte(), we may modify the pte entry. The corresponding pmd
entry may have been modified concurrently. Therefore, in order to ensure
the stability if pmd entry, use pte_offset_map_rw_nolock() to replace
pte_offset_map_nolock(), and do pmd_same() check after holding the PTL.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 arch/arm/mm/fault-armv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 831793cd6ff94..de6c7d8a2ddfc 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -94,6 +94,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 	int ret;
 
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -112,16 +113,22 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (pmd_none_or_clear_bad(pmd))
 		return 0;
 
+again:
 	/*
 	 * This is called while another page table is mapped, so we
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
+	pte = pte_offset_map_rw_nolock(vma->vm_mm, pmd, address, &pmdval, &ptl);
 	if (!pte)
 		return 0;
 
 	do_pte_lock(ptl);
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		do_pte_unlock(ptl);
+		pte_unmap(pte);
+		goto again;
+	}
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-- 
2.20.1


