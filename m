Return-Path: <linux-kernel+bounces-407763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFCE9C74A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4118B273D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D184A35;
	Wed, 13 Nov 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3/Sba87"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2D4C62E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507610; cv=none; b=Wli9julpXjEbzgtyjzfADaJYo4iqadf+phaHd7ZHd28Pmy5UFO3zZAL/yep71Ccj6RbKW5qu7KmLjxZ+LIaWCHcug2gWOvgIyZF7SMMNFn2gfVf9l2/qVDk9CwE7YQ0gF1p8++HxTo+x43hDag5BVRt9TGJsMwN4vUwfIYpv/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507610; c=relaxed/simple;
	bh=f6g85FqXcn6Z52Nz7MtBvnWz9M8L91qrTOo+ze96z/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovRoLRDW8JmXviHg97dhQS+++NJOzvaJCEfH6ljrHWJiXpg0zP/dKp1WrmxknUgh6Z8BShV1dOOHdGK1AJ66nEBYd++GJqOdg4hKsRyNnXm4A9jaoOC1FmAUfftFnBhSi/ffF1q/YJPhOR1hwvZ2JcNBamm39quieBTM+f2375A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3/Sba87; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ce5e3b116so62309305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731507608; x=1732112408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+W5/1/yBRnzApluXvmZS6wnEL9+HSsK6+2J6aji4ic=;
        b=O3/Sba87+Ze7I1lpMTGtGOtXVaf1KijAXgYwjgB89bXhU23CmK7kjoua9tQellLllI
         dXHONaBM7uFxdOd7E6oIvQN3sqNyisi+CySrZeWEFLEqVxRaZc0E8Ug3DGgXun00Rjfl
         gO5PJAcU347ajGNYyjbceLIa0ewrLE2ccXNNcVv/LlJtYdkg6ZNjxoet6z0/4MAByAZE
         tCGySEYMy8lLEeH0bT3C4GrXbv7AziYEj817R6iBtRfeyiYNu2S4mTwcgfZ1OVC/rvhq
         eG07juHdTeOSPcHEKXsrkwM0X8HLf962+PBxXumLufjozO/lsqJRCAJe20GI3/KTMlyA
         t9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507608; x=1732112408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+W5/1/yBRnzApluXvmZS6wnEL9+HSsK6+2J6aji4ic=;
        b=jTehpTuaFf6NdFhZuXJXnUCCm/vbHvl8VpGXLpgreIS1N76V5Rk1SamUV93UvltxGU
         kWSE/ZZlMVCso1PUrBVN4YYczqpVMxUwKIpEz0gnpE7hzQfz+QT/NRqnO3sQEwnWKRD+
         a/88+hD4+WQTP5GHjSwv+Tly7/BNH82/88gQwLC7/MeBpr1rvQnU4W2LeX6GY4N22YxV
         K+f36/A+SpbKyP0x93WVAVXvBYXzVhYu5okwR0t1QKoLalIPQ6GCYqp9YCm45R6WSOfm
         YHTBvMTWzV14lPCl2f/CoBMfMZeMrQEmxf011lgi81jJfBeDW2bnRECjndZV2XY7uil7
         99oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVppTTJNTYqBi4NWZCPMQ/S2ArcNCvcPdqdGijPdq4ThqmDwWYjYBxUzSFxiLLZE1q7Q/ovQo2AQy8npT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YjI7ptU+lm14ipPhLMAIMFxKhydjJuqvnujpU9gI37+zDePE
	ARn/ZjSwGfnZfBDvtsOVkcnwCJRqWkPiwAWq92Yv0g65ODG29lor
X-Google-Smtp-Source: AGHT+IGeOAmmIL3JeGd2B/FeYzTlCYu440XfiAvTwoYmEtolyVkG9FqkwR5NzpR2JeHhiVjtarSHuQ==
X-Received: by 2002:a17:902:ea02:b0:20c:5c13:732e with SMTP id d9443c01a7336-21183e11d8bmr278709445ad.38.1731507607853;
        Wed, 13 Nov 2024 06:20:07 -0800 (PST)
Received: from dw-tp.ibmuc.com ([171.76.87.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6ab8fsm110636045ad.226.2024.11.13.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:20:07 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 -next] cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
Date: Wed, 13 Nov 2024 19:49:54 +0530
Message-ID: <e274344b44d5f80fa54c52f530387257fe99ec65.1731505681.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_init_reserved_mem() checks base and size alignment with
CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
early boot when pageblock_order is 0. That means if base and size does
not have pageblock_order alignment, it can cause functional failures
during cma activate area.

So let's enforce pageblock_order to be non-zero during
cma_init_reserved_mem() to catch such wrong usages.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
RFCv3 -> v4:
1. Dropped RFC tagged as requested by Andrew.
2. Updated the changelog & added background as requested by Andrew [RFCv3]
3. Added acked-by and RBs tags.
4. Small commit msg update.
5. No functional changes.
[RFCv3]: https://lore.kernel.org/all/20241112225902.f20215e5015f4d7cdf502302@linux-foundation.org/

Background -
============
1. This was seen with fadump on PowerPC which was calling
   cma_init_reserved_mem() before the pageblock_order was initialized.
   This is now fixed in the fadump on PowerPC itself. The details of that
   can be found in the patch including the userspace-visible effect of the issue [1].
2. However it was also decided that we should add a stronger enforcement check
   within cma_init_reserved_mem() to catch such wrong usages [2]. Hence this
   patch. This is ok to be in -next and there is no "Fixes" tag required for
   this patch.

[1]: https://lore.kernel.org/all/3ae208e48c0d9cefe53d2dc4f593388067405b7d.1729146153.git.ritesh.list@gmail.com/
[2]: https://lore.kernel.org/all/83eb128e-4f06-4725-a843-a4563f246a44@redhat.com/

 mm/cma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..36d753e7a0bf 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;

+	/*
+	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
+	 * needs pageblock_order to be initialized. Let's enforce it.
+	 */
+	if (!pageblock_order) {
+		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
+		return -EINVAL;
+	}
+
 	/* ensure minimal alignment required by mm core */
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
--
2.46.0


