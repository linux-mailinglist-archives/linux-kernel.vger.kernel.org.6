Return-Path: <linux-kernel+bounces-372121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE49A44BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F21CB230C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10FA20495F;
	Fri, 18 Oct 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd9VROW/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C478204F61
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272644; cv=none; b=PoXOnO1R3nfGN5CIWwMBwgYh5n3oBvpcAcw9rxR2xSmKDvPyQcQc54gX1eGE56DcVsOuLa7RiyySpdrBoz1QR9s+DD6R9Nhtic/9vW9jRI2N/CRqrZ9hKpSyATcy3w5jnZQOh/tEvtM68fIvbs+e8/t7nvPIo0v6uapvm7ktqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272644; c=relaxed/simple;
	bh=Eu79YTiDNt99GzvYca1lqmYdNCIQyv54j7t8FXnFaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPbaGxZXPpe9EwvV7NLJdOC2NuB2GI4BI8eNng0zgtK1fPuI/h08AvBzD+LfDCT8jdaek/UorMHmfQfAYvebrjaEuCm7EHp1CgiYQHlXgHbsaLZRFN3ZMjEoPUEX4XqEPSL3AiUERingel67yDNwFHByZXJ/2v2u7+hZiYJ8k/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd9VROW/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so29086b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272641; x=1729877441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw41Uo4vlK/av70SyuzQ/EcBacKxJaXG8uVQm7tNSaA=;
        b=Cd9VROW/chSLaFW65w/Dhp+Sskt0juhr2oLkPTSl65IaAmCKrvOkPvQxtsK2reiUYg
         trY5rseGvFrkgcCfAF946Z4HSOk5NFjF+fcG4QSjQrITMwzeWFcQPEs8LTWe+nfCWtIl
         RWVeOnXyZkWPQAGuHCmyrkHxm+30g4S7HYScD2qiVvoEvJq01H4ODE6J357Wjazdx81A
         LaxOLHek+4h3XeGRtn6wtRKELmcfkuiDquRlP9LXy8jwu/7USORGSo+Mj/NBNUPWU3Vf
         SeDpk9oitHMc4A+WEsO4vhm9T/8rQEcGGmwtyYxhL9MGCw8cF2qujdk5U6XaFzbi+EW1
         TeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272641; x=1729877441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw41Uo4vlK/av70SyuzQ/EcBacKxJaXG8uVQm7tNSaA=;
        b=QZsOq7hSMqe9tNlnALq59Cg2ZmzXGTfNrvf8OR/ffl8q1ivvJeXz192YgcveRY9NIP
         MHzjtzbYSZbWC5kVHhj9Eu0lqsxTB6MkgsSm7Cf9en4e3malMnUsAH2OpBZFe6O99nnO
         xAAN7/WJffYd63OfQ0/ahq2Tn7QTMmRNtZuDcI4dXOHeTMOuh0mlkqu+ySJDkr4VR+uH
         UI/N/ZHKfodXYncO9TYN9iGf9r0/M0g3qG349x3vCML9R9hFYb+XHdmf+Wj5h/6cTjfu
         +johhKMwO3JU3/Fvz+I1h1GrModsOxhAp6wOjbEJ5R1tplnNEJyXbvu9yPxw2VvxPLiM
         Fnjg==
X-Forwarded-Encrypted: i=1; AJvYcCXBu5j0g/JRSOIlocHTyMokbaMaNgh2oHY6Ns+iqGaiV3uLAw+2lrlWXd2a935R2J99GGwnIbXZa0WmgvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/uiKfxWKar1bmnIuA4QaQkZ0W4BC3+xN3oB9sEixd3xW/e/M
	325TY8ZQ2mcTz2DnvZN+kLRA7xyRzeOlTyU1ZE3bioJ0OV3P1Jfv
X-Google-Smtp-Source: AGHT+IHA05XWUstb450eeCq2YkOYG3UKP/gDh/dgZ6794ND1I3UZATF+JDsVTkAs4xXtweTSIyj5Uw==
X-Received: by 2002:aa7:86da:0:b0:71e:b1dc:f255 with SMTP id d2e1a72fcca58-71eb1dcf5e7mr118528b3a.9.1729272641491;
        Fri, 18 Oct 2024 10:30:41 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:40 -0700 (PDT)
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
Subject: [PATCH v3 04/12] book3s64/hash: Add hash_debug_pagealloc_add_slot() function
Date: Fri, 18 Oct 2024 22:59:45 +0530
Message-ID: <026f0aaa1dddd89154dc8d20ceccfca4f63ccf79.1729271995.git.ritesh.list@gmail.com>
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

This adds hash_debug_pagealloc_add_slot() function instead of open
coding that in htab_bolt_mapping(). This is required since we will be
separating kfence functionality to not depend upon debug_pagealloc.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index fb2f717e9e74..de3cabd66812 100644
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


