Return-Path: <linux-kernel+bounces-314570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700D96B54B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AA928C248
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E711CF7B0;
	Wed,  4 Sep 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TzmGGeR4"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7B1CF7AF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439284; cv=none; b=liQxwAiJa3VOyRlGvUZGZbnOR1oXyOyEsTOCguO7wlYXZXEwdStmne3MzTpuLGkWgQgurCVWUgS6xyIav3hYykty6NmZbsxy+ddvG8F6M6EQBSyAxo6rsMsG7vVpBDATcV309CwOVjDEGLF+8YJljHn2Zrta0GyCT7VPEAhWUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439284; c=relaxed/simple;
	bh=hlsEpWmf1qa6LsjjHd7NQfjzneKSvrpzaH+0KKra15I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOK0xI29+Q21XjVjCXNNAHGqMgC22KxjVg2L2KUwTmZ0DSA8AGdUoHPpwMKK6qlRXU2wMKDLdxFEUbQ2izEqAz8xGt0CjKV49j2SlCZ+VjtBlVlwwRtV94D+DKMmk9gnIz2GHsbBOliNgONr4wexwKzmu1gFpbU1a/t9t8H/Mbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TzmGGeR4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3911056a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439282; x=1726044082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGIEfQHzsThgJvUA20OC+gjd0SFgF9+h9gc5ip8dlng=;
        b=TzmGGeR4OjyX+vdh9g+O+p7U0yyJ/FyMALADy2OCaQb2zk/lzTGCVXr+EFq37k2pJ4
         S7n4uaEhKptnQF8CKhAD2cBULWvseCQ944xVQIQUtMpYVeUOX7IUuMPpSHolemlv1KUw
         CaT/4mH/WNBuLR6Qjyojxxr5UdpbKPN67bEiJucMBkarx2uUD3i0aAQz6crTJA1GWf2Z
         e7hY/QAInIwnDppxsA/wl9kardvOy49E3dT2wlJ4kXn646/PRpeIXxYju6fgNaK+BenU
         kT8VGTcYQwo/YpJ83pLJwcqHlxaqutvj964tPqfTzkTs/6NtKmgG3LHX8ZpDp01EQ1Vk
         Icbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439282; x=1726044082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGIEfQHzsThgJvUA20OC+gjd0SFgF9+h9gc5ip8dlng=;
        b=Z0kRY93/bO6Vi65fsGYEno603f10aeRaWdsopG52/VvoDE7FB47hyAIK50Us9SeUoJ
         D6LwqkOnjGZJmr0XHL18Xw/32GaSSCCwPiiUPP+AhXILQARExkK9SmI1809u1WtFqd6j
         RHy7G/1eBwH4LWYf75tVE+JvfLM2Qk2vECq5LmipVp/oxpSb0GNyZ1BT8mDTK5sC9363
         IQcDobfctvf5WYM9F1vJLiHuFqtL7OYYkuPLvVyYTz7We89deobDQwBV5Q5XR09D2HAx
         bVLNGQPSFB3hYNm/BAEo0wBSCp6JWdOux9fs4d0j3zAiAs1r4xNc7T6op87RT5coEyoj
         mwNg==
X-Gm-Message-State: AOJu0YzLVG22pV0wsfE20gaz+0OHvH9ZnlDY95AXS0aWyFZgCqQvBpyJ
	MbRfX73Vjwfsr+wxrYB1H++LLpM9Oe9gfxnM1Rt7wkb4+DTE5w7hsH15dA6e7SU=
X-Google-Smtp-Source: AGHT+IGQLG6wPNgDOgfzFUGIly89eF+GLm9izjxQGbRYP1g8ZSKlFJK5pYdbKQOnPMpn9+eqCP/7EQ==
X-Received: by 2002:a05:6a21:2d86:b0:1c8:b65b:3db8 with SMTP id adf61e73a8af0-1ced607378emr11775108637.9.1725439282360;
        Wed, 04 Sep 2024 01:41:22 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:22 -0700 (PDT)
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
Subject: [PATCH v3 06/14] mm: handle_pte_fault() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:14 +0800
Message-Id: <20240904084022.32728-7-zhengqi.arch@bytedance.com>
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

In handle_pte_fault(), we may modify the vmf->pte after acquiring the
vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
will do the pte_same() check, so there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 42674c0748cba..06674f94b7a4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5498,14 +5498,24 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		vmf->pte = NULL;
 		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
+		pmd_t dummy_pmdval;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd by anon khugepaged, since that takes mmap_lock in write
 		 * mode; but shmem or file collapse to THP could still morph
 		 * it into a huge pmd: just retry later if so.
+		 *
+		 * Use the maywrite version to indicate that vmf->pte may be
+		 * modified, but since we will use pte_same() to detect the
+		 * change of the !pte_none() entry, there is no need to recheck
+		 * the pmdval. Here we chooes to pass a dummy variable instead
+		 * of NULL, which helps new user think about why this place is
+		 * special.
 		 */
-		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+		vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
+						    vmf->address, &dummy_pmdval,
+						    &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
-- 
2.20.1


