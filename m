Return-Path: <linux-kernel+bounces-314572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6E96B54D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9613328C7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671621CF7AF;
	Wed,  4 Sep 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VYtgc1sL"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF91CF7D7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439297; cv=none; b=SF1le3clKWdFvF8pUrDj6C/GVzIsZCV4U57D8bHRTsq0IOuJ1kC4PrgMwmKZjhUdgVwvAS3VFe+60xRBJUlao7k3O29A+KLCkMejLtLls7DzT0OAjUcRwOxGTw0KlMjPk3AJY4H1uVT2TZ6JRteoyHeFBR5M2Il2WHdLS3HDOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439297; c=relaxed/simple;
	bh=3TVv2wnCxLZA49MglLWh5UzIriJ5sUjCe3cfQyCkNmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=in7xKuTK5+Vh0Qx5m9R0b6/0lRSubgt5rg34D88AKn4a4gywCimcyAvQerH3rPawEIRZmpnpdbGTqQIQ93sjIN2e3dwi0lankOyLaE01Rt7lhdERmnaVsDctQWBU4HaK/bs+9UaAjF+9Q8tnSl5i8+vaYEqH/RK00kX4H2rARXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VYtgc1sL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso1440730a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439296; x=1726044096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffoF6/h1+uprLqHi9escfobEZTHc+3j5UpPJif6C52k=;
        b=VYtgc1sLM4mBjtI0kR77pOz7TTVuOK8zDz2S5PQNbxdJD0/jZ7tsEbeHh78tDlk4pA
         UJiH5VzbL9PuOPTMliKvOTz26Uun9rQnWhJULf9lr51vi0/IWAft1VGKcvLIWY46c0c0
         mzF+QqBqhU8PJqyEzFKRdLYj6sxYDcejN1YblMO8vZIuMtGntOri/y+J0M0bBapUC7hr
         I8wR8OCmg99fxBscvMMnCIpR6dQA5s6mlFO2OhNo1OkaJFK10UFXrQBs2Inc1cTyJNVC
         hjrPomhX9y6OdeZ+6NuPu3sUHYlwOQI4wK1cQuTDZwIddL35TxTLg0s97TqICyhrS9oy
         ilQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439296; x=1726044096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffoF6/h1+uprLqHi9escfobEZTHc+3j5UpPJif6C52k=;
        b=b03cf/Fk7UYrcZuChYIjCrIHRVB+Sl3plltv2F3Zt58laZsdT3as3L6sdl0hcgzE67
         Is8T0i65VCPNNFoSynWbqYRzQ+cJR7KtqdWPdsW9ef4/z1N78bQI4Krrd5Q0HRqZh9Cr
         cWGKBVMQxSBRnnepuXuDrKXptF5dyDWn1Gd/eSRSJs+0B56i6aWmUILIhTczZc5TeyrQ
         3VGST2GL1Uv/grN7ZiAV6mODHwOekOlPcPIspIaSXMws3AIl5r/prpI7ZKfxI5o0oyz5
         Lfv4Zvq9NK3tfS8yA1iu7SySOGzKWO1s869IA2YCD847vTFB1X4nutIOFU3mj1c3GHYZ
         wfww==
X-Gm-Message-State: AOJu0Yy9fcZiZpoVaNN16B3ZhvMU38HYKxeN2nPeYFxx680bACXE26pK
	mosCKl9wQdTTyI1tYZlc4cLZmhznkEbtcmc78FpWKks6VGyZiJubCKhWatr4rFY=
X-Google-Smtp-Source: AGHT+IHnX4UPdOrG4UbMFan2fo99NWoUyUAqXexLL4zg80mEgnx1zTpF+DDeMcB5gD3OIXAOIo10hg==
X-Received: by 2002:a05:6a20:b40a:b0:1ce:f77a:67d4 with SMTP id adf61e73a8af0-1cef77a69e6mr6594806637.6.1725439295802;
        Wed, 04 Sep 2024 01:41:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:35 -0700 (PDT)
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
Subject: [PATCH v3 08/14] mm: copy_pte_range() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:16 +0800
Message-Id: <20240904084022.32728-9-zhengqi.arch@bytedance.com>
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

In copy_pte_range(), we may modify the src_pte entry after holding the
src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we may
free the PTE page in retract_page_tables() without holding the read lock
of mmap_lock, so we still need to get pmdval and do pmd_same() check after
the ptl is held.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Hi Muchun, since the code has changed, I dropped your Reviewed-by tag here.

 mm/memory.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 06674f94b7a4e..47974cc4bd7f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1082,6 +1082,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
+	pmd_t pmdval;
 	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
@@ -1107,13 +1108,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		ret = -ENOMEM;
 		goto out;
 	}
-	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
+
+	/*
+	 * Since we may free the PTE page in retract_page_tables() without
+	 * holding the read lock of mmap_lock, so we still need to do a
+	 * pmd_same() check after holding the PTL.
+	 */
+	src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &pmdval,
+					   &src_ptl);
 	if (!src_pte) {
 		pte_unmap_unlock(dst_pte, dst_ptl);
 		/* ret == 0 */
 		goto out;
 	}
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(src_pmd)))) {
+		pte_unmap_unlock(src_pte, src_ptl);
+		pte_unmap_unlock(dst_pte, dst_ptl);
+		/* ret == 0 */
+		goto out;
+	}
+
 	orig_src_pte = src_pte;
 	orig_dst_pte = dst_pte;
 	arch_enter_lazy_mmu_mode();
-- 
2.20.1


