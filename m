Return-Path: <linux-kernel+bounces-530467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFEA433E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9154217AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C411FAC52;
	Tue, 25 Feb 2025 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Db5U3Vsm"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1B1684AE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455231; cv=none; b=gw4jnOJ2+aETuwCGabW56jEpHUZ6JHxsxTkxzHHpadDI3ghdsYhtG/nf3BLQkfdSbukU2Cv2+SfOWspBvJozwpScoGKVKlkNeAH+cB8t3flx/iRVnqs4P3fD5M83uQ85otuhK2S6U6XT54Rgdv/+TUH+Fz1cm9g5j84edz4wJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455231; c=relaxed/simple;
	bh=uEIt0iOIE1wq+fFnae14pvBZV4BJtIqtLEBiBKsbnt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=od/lOGjk0s/7DXI60hOb83AEQrESB/YvGhXCS+vbiXmLed7X3DfLvzmFgaHGr6aEmJ6ZGIFbcP1s1CLa+wsKMgAoKr8MCVRrkAzFYIndBBDL5DSLk6Zgdet9dL+TrWhIb8jmksQRM0Jo4hC+mtY+Xhkbn5lj2iUwTe6saYwuIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Db5U3Vsm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso5571001a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455228; x=1741060028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=Db5U3Vsmaxgd3fgETnudmM8tmkJMVY7pGwdCHDesrQ2DmxvkCMH24Ej7WIgjzAba5j
         VXZR0IpzmcQrf1Ty36dPjXn1qFLYodTgU515y8LstS9bOvHy6b2XtxPfR/0N1BlisRTl
         IJbghtr79viov51fa80+AjLf6E5t70zAH3FucoA1JgEPDoqQKe62BDFiGsqEKByFEuFp
         O5YdSgepx4wgk4bkgQnwCnvSNfPmOccdfnZ/Zr2+8AVuGOhaIYzW1t4AL7pix9/0MMK9
         2hkYFCgVZUTAEQRkA52rtp+m3NGecfRQYvKjaOFIHSoUxnZE7NePzAFytri072RCc8lp
         58Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455228; x=1741060028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=HJftsaWhYKX9yKMomG3PfTqL5Yz1BAHoUyyYfOTVcy8QTE+/czBwoar/671BOd38/0
         i/cmhTqZq4e2flRhLxJmPfhwveIe4p1b8tl9bpoL8pWewL7vOVnOZeuMcJTP4ORMacBJ
         ZHBgQ+4dVbHhcISQADHOG/MieZ0cQo+ClicP6f1+ER+b5dOZuzNgUd4z+1udT594ofv5
         hyPUTxDBMi1pcC3oEi2Sx8lWIjBsyl0yz71zsmp2PISlCPhS3BxqHKOSQVY99v2pd66g
         1xtIBW/JL1zDxzJ8hFKWi88WJgWjhhohP5k4cJ3aWjL0VuY/ReDHJk+aKtHnbdjmOmR7
         xNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/Z/Z3mesWox3vMUhj8r8kWlnJ9YKDNyrpN5XuNpbMRttw8K8VOdRDU5SA/4av5Y4vO9aekw8FtALzUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxqc+etSkHVfjUqw4UtBYIXVVLY+VJLKK77Nt3BKfASaWMhF/t
	aaPwfUwI+BrLVAydSY1cH9QIDXMtrDkcg8s8HMVSiWqzcOSoGBt9CRZXpu+vfg4=
X-Gm-Gg: ASbGncvtMCVqVrxl1oinOBKmQk8xqrHLSKnadkDCRfywqm2luX0hIdTrDBx9Vbwydpn
	F+hbbs0oB70Dp9exWn+bzL9JI0rYgJruPPY/QB999Xi9f1mxpMcEgL4/3q4wvNFT0jUd+9v4jku
	AeTVrtKgFUjyE6g3BHtXYAZtt2kujbyS8S1/L5xT3exVyRxsMAM6HDYBUu7pfu0QXpBAZ4zvStZ
	SjjQ7ca1+RDjpa2El6PIQcSbQX8gyJhlPSbtYv6iTL9/hTgm1A77/iQf4j3i7kfp9bpp7Fb+jJ+
	a76UVVhPvpVKfencevMObl7A0voHKbKyy36v7zUzygbWj3/r1z4PlNBRPc8HsQDOUw==
X-Google-Smtp-Source: AGHT+IHErQlNtWAOdWTcDw4ZwAn3kttLeu4q3Mf0dru9ScBNUcUevexLBEyVDaZ2sKSBMgz3Y5FwbQ==
X-Received: by 2002:a05:6a21:7a44:b0:1ee:cb9c:9dc9 with SMTP id adf61e73a8af0-1f0fc89a091mr2965600637.35.1740455228677;
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 5/6] x86: pgtable: convert to use tlb_remove_ptdesc()
Date: Tue, 25 Feb 2025 11:45:55 +0800
Message-Id: <36ad56b7e06fa4b17fb23c4fc650e8e0d72bb3cd.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 has already been converted to use struct ptdesc, so convert it to
use tlb_remove_ptdesc() instead of tlb_remove_table().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/mm/pgtable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b1c1f72c1fd1b..f28ddac0f734a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -45,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -59,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.20.1


