Return-Path: <linux-kernel+bounces-314569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C096B54A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B8E28BE76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5841CDA1E;
	Wed,  4 Sep 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eW/P+OYT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123811CF5C2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439278; cv=none; b=b+qOfsSj2j713fFoTc/ghWsgZIuniswnVcA6C0FfLC+1zewdiFyzNlpZn1rmK0uGc71QVG6JTNlvAhnEwNefGahykJFqYqY5Rc6n7weK0T4mAMQOYdOpkqEdlh9BcixnLzHkzaSlSco1Afpf0htYkMUKlESmYzGU8rGxp+jMa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439278; c=relaxed/simple;
	bh=v+8eBabVrYBW01Qi/P2m8jF8QqAnjVEwJS4a+M2dkLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jS16LFPb1pZMwwmstUNueq0D0nzzTvhV1xrPwxj/O2NbmBOjfo2F3PD6e/wp4Ni/XHQ1b2KSo6KBcGQEe46e46e7z9A612M4rWmvpVSBVKZSHFviXkqi/moSWSLdscaddwc6ESWAsQWAQ3hgkCH3s0xci+JU6aED8fO8lNc7ChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eW/P+OYT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2057c6c57b5so2891285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439276; x=1726044076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=eW/P+OYTQf9GPSJlWWaaNSIgGyIfTjGNLGTerkP5Kn7aNOYotrzGBxApTJKVCxijP2
         OwUPSf9rKJeDAPUyO/C/5t8iKZ5/vaDJIvQbxB95cBiu/gCrUx8FMIDv4/njP1jLNDbH
         y53o1ZYiNx1Xn84GP7BK8AIR4em5CBuq46ZWABSgsW4Z02eWrFseiRNsXJ6q6yG26EKu
         VqD7sJYRohFbSXcYyO6xJSKDTqZPPoLdFKjxapENqWhdb5Xhne4e5+3wMnWNAjVkh+kg
         GiUXHoCcjMQhq22F0/aWt/tQG8kQiBuqEsUDCm8j/uiKyyrQEzPsElDeM2OrBLTs+fMp
         H6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439276; x=1726044076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6e2rRMn75kFV6Fv258+yl1EB6KpOV48BOzHpMuHQ/Y=;
        b=Sz/ZH3//IlGaCQkv3nDP2nyUAhdn3GA1zWQDtaYlFVXLwU54F3QUsXJ9LLWNu+PAld
         tQ1TwkgPmPx9DqBP5jJE46kwkKpKa3Fa1ijkQTWB72ZqrWhN15VLERdTdAIG/TJwG5vl
         p0rEi8Y3zhsEcJb+T771I1X7bQkPuMSfeT4QhY9Ix2VlWGFAf4wOZZ355Dl72j5NAvph
         ZxMIg1y+gK45VfTt5tLfWTD6vGmRmA9sWjd7DZ1rTZTGlU9OxHUL2L+D9Jf+lPI3NoXV
         OU5f2pZn5TzsarySzkwkOs78sm8iU02lPoqlDdPAd21fCcE0zUOVSZr6nUSu6PdQdiBg
         lI9g==
X-Gm-Message-State: AOJu0YwbWZFrhCrpxpSgGIfaujd4kPxrnfMIX/78Q06ZgYVr93xq5VkX
	qM4mz3cBuUAmWxxV38j/l5eQl/Xd9QzJQ7j4HlJiWEHQSCsejoekFN1Bp9SBjeI=
X-Google-Smtp-Source: AGHT+IEy+qEnEqpj3sReiKH3tPFUkwjqR7spuVkWXeQJodyHWsfCM0cenE/z+pCdCppofQTZA+ekKQ==
X-Received: by 2002:a17:903:283:b0:205:76c1:3742 with SMTP id d9443c01a7336-206b7d00d3amr22901025ad.3.1725439276249;
        Wed, 04 Sep 2024 01:41:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:15 -0700 (PDT)
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
Subject: [PATCH v3 05/14] mm: khugepaged: __collapse_huge_page_swapin() use pte_offset_map_ro_nolock()
Date: Wed,  4 Sep 2024 16:40:13 +0800
Message-Id: <20240904084022.32728-6-zhengqi.arch@bytedance.com>
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

In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
so convert it to using pte_offset_map_ro_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/khugepaged.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff6..6498721d4783a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1011,7 +1011,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			/*
+			 * Here the ptl is only used to check pte_same() in
+			 * do_swap_page(), so readonly version is enough.
+			 */
+			pte = pte_offset_map_ro_nolock(mm, pmd, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
-- 
2.20.1


