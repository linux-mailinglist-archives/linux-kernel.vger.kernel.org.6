Return-Path: <linux-kernel+bounces-333060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82197C2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F74528398E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FB1803E;
	Thu, 19 Sep 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A90dXAbS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932E1F942
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714612; cv=none; b=kzEwBq5OfC4G0Nj826Hjhia51iU7c1fsKjfvcD0M+P6BID+RdN+ZGUwZKN3yawH7zixniikLy6IBcRlCGubVZjwJF1wK5mar9A5Kf56yMI0HGdT3EFXHipslEvQsrFdvQmLV88Rcpr7gd0/+qOkEgpEy9LMTHW6LbnKNkqq6yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714612; c=relaxed/simple;
	bh=lGDU6+XsEZA63vePePBnGkCzitISc6raOI8xarwqjFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpD5WUJaj6sckhWXroESKmZ+aAsRYwPFTXUXF5TV19gWW+1+0n/f3CqW/LCQk0iYTzmqUb4EpsTuR/2kI9MssntPe2ws3UOFbIWGITKzcbyuWIwa/YHwmdZKPD0afbxkH0ufMRP6l6UegUOQWxYDNC42YGiqNAz8WyGQ1wKv0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A90dXAbS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20543fdb7acso3502405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714610; x=1727319410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+q0qzhvgy5Htf+jNoj0jpwh62QEw37SjQucvD3DcJc=;
        b=A90dXAbSzjxDkMBL/p08VdbHN2dcuXq0SxCoCJS38J//j0QZ2oY3M97PEv2jNfSL5d
         02p2cajm94lcs6laej2avDxrQjXnB+5k3b4tkhK0c7FWTjcJHElLphk/RUGk2qNLYbCV
         bLSoqeCFhjN5ti8ITakB3x/+U56K8QDulSW8cWZQuOD8zHmBFCfNdcNyTggMOshNEm4n
         OSxYZqebyRERUBPJzzvJ4at/kfVDU4KDlimit2+yiu0jGUfaCmbR6BxX0mQw3DINiqw8
         nalt0vyDpUYISMOQxBMmfA8WZLPtefod1gEZ2E/JpeIYxi1H9H0RtkY5ZLYYuunjm6qn
         Efrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714610; x=1727319410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+q0qzhvgy5Htf+jNoj0jpwh62QEw37SjQucvD3DcJc=;
        b=PoTr2vW73EGrQWMzwnVr6RcOBNwmu9NOOijPRN7cYLnRAuFDEMakUA0H+57yfIJwDR
         95mHRhifE8ATAvj2T6psn4wTDxOyJseU5Y99QrQJAr01cCf/v3uOOvqzTQorfXUyjoTe
         aHaTVHDdrKk9fHzjnaUVEGoT8bQ9rRtQ666n46wXi/d79Y2v0836s9zC/ilDXatTyXvb
         3opCu/PG/SI59LRg7FaxeUfDFz/afEc9eWjTehUdCEPeeXhjCo8b221P4O9KK24c9gkk
         BGtEsqzjm28izZx6uINDmGFtoVCdzKsAZXU1e9uX/FSu9SzgXa7ino+YiujhczL7A9le
         h+wg==
X-Forwarded-Encrypted: i=1; AJvYcCVUkOIqCb355XxtHobYbz9HMYWGq4JP2rWPrKisIEV5EpXPWPV+36z98Ghp09cmJPThJOjrz/+iW0WHwOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOUWlDvcspSzMoAoJIIcbtiv8sCTqVZNaxOG32kFyD7436xX3
	t0zXvvdzkm44ccECrvNQpywUEOe7tKxW3iWALG1qVjjRqTVJ5Lnp
X-Google-Smtp-Source: AGHT+IHDCEhyE6aDKQMLRWn1dVpCIu8ywaRfsfF6B1LtKOZnRl3x2/5HVbN1RjELYtzDCtK/03wddQ==
X-Received: by 2002:a17:903:2452:b0:200:869c:95e3 with SMTP id d9443c01a7336-20781b42cfcmr332110025ad.4.1726714610017;
        Wed, 18 Sep 2024 19:56:50 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:49 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 05/13] book3s64/hash: Add hash_debug_pagealloc_add_slot() function
Date: Thu, 19 Sep 2024 08:26:03 +0530
Message-ID: <b8a835318147d3b8edd0e3236f5dcaa18789de16.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds hash_debug_pagealloc_add_slot() function instead of open
coding that in htab_bolt_mapping(). This is required since we will be
separating kfence functionality to not depend upon debug_pagealloc.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 82151fff9648..6e3860224351 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -328,6 +328,14 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 				     mmu_kernel_ssize, 0);
 }
 
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+	if ((paddr >> PAGE_SHIFT) < linear_map_hash_count)
+		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
+}
+
 int hash__kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	unsigned long flags, vaddr, lmi;
@@ -353,6 +361,7 @@ int hash__kernel_map_pages(struct page *page, int numpages,
 {
 	return 0;
 }
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot) {}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /*
@@ -513,9 +522,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			break;
 
 		cond_resched();
-		if (debug_pagealloc_enabled() &&
-			(paddr >> PAGE_SHIFT) < linear_map_hash_count)
-			linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
+		hash_debug_pagealloc_add_slot(paddr, ret);
 	}
 	return ret < 0 ? ret : 0;
 }
-- 
2.46.0


