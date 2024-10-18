Return-Path: <linux-kernel+bounces-372123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD549A44BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2681C20B34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EC204089;
	Fri, 18 Oct 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEr/I+RD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01785205122
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272653; cv=none; b=JaVHGxULrgRHCdfxO3N0cmo2aBfTf7SavwreKHTJVAJ0Ckx+UZhqFW4nb4mZGBpKZPNZz5P537wk+7qZ2Z+otQ/bhB7TEyM6TCvayg1IKuAStr9YeUEpM/HAsztS/YxXcyRui51aOLmtB66UJ9Et2Vh0eXWY+vSp4WaJnSpBlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272653; c=relaxed/simple;
	bh=8xMWMAm2lHPS6fjdW0x2wv3+VGcvv1GToMNZcFopFrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5u34wgpbRk5KuqIXxY/Emr8qNSWCBCYo9C1yVUDxrD8pgEOdx0cF/Yo6LBfOyN/tXyHBDJDOW30C7K4ueQIpNmOza1IE6aJ9k12RRGicjPSNkrFVSu/ylXwjYQfy94WgUHYZL0Wh2MacyxZjiTc1akG3rB3vH1pWOFFcJoeUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEr/I+RD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso1565400b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272651; x=1729877451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yT2xkfY2cuEcnEiccNoddLAZz1lOngFGOhNqKs9rtU=;
        b=nEr/I+RDOtE64fYHtxTHhuDXN3mokG/KJp+cIjI+aqULjQZKr8yX4Z5bDrScr8Bf5j
         9TOM44AVdO5oEl2tu1/qVUQarA5xm41W03I7lbgpaA2X3Pu8mTfufqoLGPsgHGe1MWFL
         AZMbb+rfVxYSrL+UuKF11Wg4L7KMW+jVHf8VRK8EXLxhUGqXffHW/by1oAGi8i1CVA4r
         LPynxyUQV+qKwNrkZ0uCnuNo88ak43Chaczz6lPq48LkFALONL8xyYeZClJ3gjpe+R+7
         Q8NmmN57tLyr7GME/Vdu8eTkPXq91Tu2ik0cbpGhm7XSj7/GppWwSXngo4gDZa5trl39
         ACqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272651; x=1729877451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yT2xkfY2cuEcnEiccNoddLAZz1lOngFGOhNqKs9rtU=;
        b=RofIpk2VQRvJBBe4biTF7wAXiSfSOfzrj5TrYnWNRbp8WpNpqF227FlZPMRC3/Jdxv
         LfQ3xlSKDdMgfcGdYbzl2GyqrYEfiK0qjQ4TMl/bXOr1nTtdP0savLpAA0mH76O0PJQe
         GpUHZnvQL2M2rJWuCp+3HNqfvET6lgEbSP0TbEetrFjuvm7r8YRpRBzCIRmbppSPng0e
         F8viWeCyaQ6xmr6aFilvviMOtmZWzSJj25WPgkbEIu//o/ywiY8rzJTjOML2CTTvJ2fG
         s4P1vRVPj1UYUp/zhTkePlGGjA5Qu1DGWMMDXX/P5ZedCG8scTvNQyrRnga3+cXXQEb2
         t8rw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJFG3zmC7XQs8SvfZmryn0p0U9oz5ahU8727uhwtJTTgYJ4aCO6nVz7iqg9ft+tTuOeZmc/RWTOCjB4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/z6APm7f1aFjZdurhapAJWUJ3MbaXy+ARsg2V+XBAuhtSNdOV
	IpqgYe7rM5flscrwX+dFJGJQv4bIwhrBz/U/ztcZgZdmFFzjSa3M
X-Google-Smtp-Source: AGHT+IHW0pQgponGx/gVpoZ4bowEpREiydwVrhTTv3Smj0fSfHzFmSnPLW4FIXTVD3Eg6sTX/fZl5A==
X-Received: by 2002:a05:6a21:3a96:b0:1d8:fcf2:9ce2 with SMTP id adf61e73a8af0-1d92c57db72mr3781064637.44.1729272651290;
        Fri, 18 Oct 2024 10:30:51 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:50 -0700 (PDT)
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
Subject: [PATCH v3 06/12] book3s64/hash: Refactor hash__kernel_map_pages() function
Date: Fri, 18 Oct 2024 22:59:47 +0530
Message-ID: <0cb8ddcccdcf61ea06ab4d92aacd770c16cc0f2c.1729271995.git.ritesh.list@gmail.com>
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

This refactors hash__kernel_map_pages() function to call
hash_debug_pagealloc_map_pages(). This will come useful when we will add
kfence support.

No functionality changes in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 0b63acf62d1d..ab50bb33a390 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -349,7 +349,8 @@ static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
 		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
 }
 
-int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
+					  int enable)
 {
 	unsigned long flags, vaddr, lmi;
 	int i;
@@ -368,6 +369,12 @@ int hash__kernel_map_pages(struct page *page, int numpages, int enable)
 	local_irq_restore(flags);
 	return 0;
 }
+
+int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	return hash_debug_pagealloc_map_pages(page, numpages, enable);
+}
+
 #else /* CONFIG_DEBUG_PAGEALLOC */
 int hash__kernel_map_pages(struct page *page, int numpages,
 					 int enable)
-- 
2.46.0


