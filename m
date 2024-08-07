Return-Path: <linux-kernel+bounces-278470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51494B0A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9EB282C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAB146A6B;
	Wed,  7 Aug 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDinerC7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB2145FF8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060108; cv=none; b=cAiVH6JV4TAKBBLU/dCemJRc3uMWGjSYy2cDHCbm5Ay4DxCvDgir29kaSAr0GZnOj7Xgbxw2zPfaQ9qML19H0Dw2X4DXuLUAXqe2oS0Y7XNt1TrKnPQ5KweABfvroBT6A9v00ME8OlnnBZKJTXBqfqAJUGIjikwJtG4PtGGaYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060108; c=relaxed/simple;
	bh=H+ha3vatbPGARaB174w66no3cvkqymG1Sz3/aRXqIBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR1e15IY5PFjZAEmstqnWXmgr/SJb+HZgksZOS/IY74c9PmnLDyl8pxU4gwndKE4hGCDTybQq+F2wy9p9ZV+MEY4eTRzNmSv3y0i5jJG4cZhZQAHVE5Ux6Zsw6GwOfFNBuYg8HEr7mF8+roEkegrnymLHJS0sHPqtT+neSQ+OhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDinerC7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ts+Sj64QZG1FGRDLVoa9nQimNVqUC6U/k8fGPxCUtI=;
	b=ZDinerC7VKau45MhLovYyeAQugFNd3cWy0DNGtaM4ot2etjA2oNtJdHmXz+MEBkWJAlph4
	vEwW01BF3HG/DOK9qSt0cZ72l6lqBL7Q9CWw1a0zvaldmothBjfPTCxSUVyQSuKjeS1Ysk
	BpzeWdEHq+Qpm8Tfss7B0krTDVhq6G8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-W1Z9KMFdOHyoDAzDjSNAFg-1; Wed, 07 Aug 2024 15:48:25 -0400
X-MC-Unique: W1Z9KMFdOHyoDAzDjSNAFg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7ad98c1f8so389516d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060104; x=1723664904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ts+Sj64QZG1FGRDLVoa9nQimNVqUC6U/k8fGPxCUtI=;
        b=N8qliLU4qkdSdpiB+5s9V8DU6+GhmNmr7+/YNH4Zmr889Kpep87MGdZffhddPFN2z+
         ME3OzeI3WEAdYh2ym462HKyXwd1q4WObS7zSWTK4cLVr4WrnBCUegNybcNJY6xHeA/Og
         d11RpcQ76vzpqInaEF0yb5mF2r+Wm5/bTQRTsz0IbIcEibgE9h/052vOwT6ySer6Op0A
         8bCvavAc0LO2bvIs1cBndR7Dz5N1AmWIYDnlAoGPXjlZu4waBG2e9IilrWJnJvfg7ibS
         UVYtassrgd17gbdh6CCNfQvDQolkjcs+GNKlUz3/Gr1OJxWsIA3lEjITd4W0MmBYj5sz
         QzqA==
X-Gm-Message-State: AOJu0Yze6HH0NP/Q+k6tWzrwLLjHQcxb6zzM+NqSs9UIIXAjNROZ5ult
	4iOw/9mpN0whhGx+syTg7p5RzUa6fuhtIA2zxOR0u1jVe/oGOBYohRBXkitggYTEJBSLEXA4iAS
	xVCLeRjp9xhOXmkc8IfiXBnljHMVz6tc8vqMNoz3u5irczJMRkbrgHFGA3PbViu0+VJ6lcabevD
	jx5lQqZ3GU47kT49oTR+ujWwEUk0kedyWjnwteJMqteKg=
X-Received: by 2002:ad4:5dca:0:b0:6b5:e3bc:af9a with SMTP id 6a1803df08f44-6bb9832d2dbmr147037786d6.2.1723060103845;
        Wed, 07 Aug 2024 12:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqKDpzCy2XKs/l7qwihRy4ZY0EbFICMSu3L2U6zTcNQWVR9cvlOSLvEsobqbXC66x3CvadA==
X-Received: by 2002:ad4:5dca:0:b0:6b5:e3bc:af9a with SMTP id 6a1803df08f44-6bb9832d2dbmr147037356d6.2.1723060103178;
        Wed, 07 Aug 2024 12:48:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	peterx@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v4 4/7] mm/x86: Make pud_leaf() only care about PSE bit
Date: Wed,  7 Aug 2024 15:48:08 -0400
Message-ID: <20240807194812.819412-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807194812.819412-1-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An entry should be reported as PUD leaf even if it's PROT_NONE, in which
case PRESENT bit isn't there. I hit bad pud without this when testing dax
1G on zapping a PROT_NONE PUD.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39311a89bf4..a2a3bd4c1bda 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1078,8 +1078,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define pud_leaf pud_leaf
 static inline bool pud_leaf(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
-		(_PAGE_PSE | _PAGE_PRESENT);
+	return pud_val(pud) & _PAGE_PSE;
 }
 
 static inline int pud_bad(pud_t pud)
-- 
2.45.0


