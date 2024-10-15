Return-Path: <linux-kernel+bounces-364968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B199DBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8A1B22F89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398C189F30;
	Tue, 15 Oct 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kLlr1n"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642E189BB5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956072; cv=none; b=Bj77Cr9IOWjzQD1qoehL/oECSL1BLiCtqn505SmekWRj+eagVUKyjebuqo6cnSimBDdtjWIPbSicGAlVDCEuirRkU2b3bGLXb5aVhCzcpCX0NyX5M//JeZ5cMvpN2NBX79A4FllUsSdc53HKn+XxZaywuXBbcAFqpoV64gch9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956072; c=relaxed/simple;
	bh=iNTLscZVjBDcYCPDjAxQPKLBjQZrCDHjaFhmiiWrPrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHFM2iWt04SE95R6KSo70hIF0+H1OwXSoCJKEXzER3Q4s2VxjoYe/hwunp1znnrQu8enwRoWXoKYAkiBpJhsd4P5EcXc4yRH0k6OCgdVhr30uX44lMlUgsk+Jun51a8DvwtB/roBT++jCKU8LjatjaSO4xJ0JsBb792bfTIzZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+kLlr1n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3348008a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956071; x=1729560871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwPGGqxMjTTALmPRltkI2obnVC0TIxSM0BTVcrrVEU=;
        b=J+kLlr1nuBJOcBM7Pi+BWPSi8tVDNozUZ1MSUAYizRN3mub93Wjr8ffk9xlY8yKiAr
         8liNmphT7g2J4vziBfpdnUDrimye7j1xdGEt6t8HNEO/5BcTxNavMR79ClpSPhzs3prs
         AbagJdFNwNU77MUFMooZvJJosNjbtkP7eDTMTB+54/xshXyOcfuSLNNwhlrHRN1Ykx8V
         aVDEWnsR+sYHPbZx4FB6GJQ1mbHUfEVuCWstTYoj/anq74zOQg+vpwkmnGV8wzAskDzF
         Mq7MfABmUqAXHmamtD+W8qmLyT42ZKb6kWbKICjRiYlKMgrKRxVae0S7aE+z2jvw+828
         yJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956071; x=1729560871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpwPGGqxMjTTALmPRltkI2obnVC0TIxSM0BTVcrrVEU=;
        b=lp1B/2vcLca3RFGcibrRW8JyNFdLm1EI0x1re+VMM/iLgmoX10sCy8tmMf28SFYHCd
         cS8v+9b3nTmHCj9dVICytcXqWx98Shki3S5D+Lz/I+EYeqRjNQEscsYKo6MEfvUaUtSL
         oGd/b51sovzJXKtRwEReS+jDWZ5XbzUHRMWUJDb7X6jrveLB5izDt2p9PCO6a+63lzwM
         KYK4LNJsN5k7BH1eDIV66VoZzoG78O0ifTFrazv7E6yPCPvfbovSIPe77TRtpkN44obt
         n1ef39or3Jol7JKDKFZ6Zn6gtIoeXmuJxVUJrxO0cVwK0gPTXStocINSPQp72Kvj3Hjf
         F9fg==
X-Forwarded-Encrypted: i=1; AJvYcCUZYSoTTckKJwjoj1glf+4Nv+l0zJqaJqyC9gEiNYM0LEilFKNafg7QqdsTlpzMlCdpezhVjtopOUd9pWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtKRiEB1hARAwlAkmhWq0cm3pf1CEPzmm1n2Q9QFKjDJnfrFI
	qC0mb8+iy9ofZh/Ly8mpNr3U1TKhVFHAg+stJozd8F695TlGK+Ru
X-Google-Smtp-Source: AGHT+IHYwbiuRk5aKKEVmS1LD0xBTPgGenAkQ5XvzCOzwV/g1bm0dITYhUx7OfVFtgaRIRCqBx30PA==
X-Received: by 2002:a05:6a20:c997:b0:1d8:adea:3f7c with SMTP id adf61e73a8af0-1d8bcf18038mr20979021637.14.1728956070636;
        Mon, 14 Oct 2024 18:34:30 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:30 -0700 (PDT)
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
Subject: [RFC RESEND v2 09/13] book3s64/hash: Disable debug_pagealloc if it requires more memory
Date: Tue, 15 Oct 2024 07:03:32 +0530
Message-ID: <79552bdb6dac0d0a39d9c639bdf92f4e66dcaa55.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make size of the linear map to be allocated in RMA region to be of
ppc64_rma_size / 4. If debug_pagealloc requires more memory than that
then do not allocate any memory and disable debug_pagealloc.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index cc2eaa97982c..cffbb6499ac4 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -331,9 +331,19 @@ static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 static inline void hash_debug_pagealloc_alloc_slots(void)
 {
+	unsigned long max_hash_count = ppc64_rma_size / 4;
+
 	if (!debug_pagealloc_enabled())
 		return;
 	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	if (unlikely(linear_map_hash_count > max_hash_count)) {
+		pr_info("linear map size (%llu) greater than 4 times RMA region (%llu). Disabling debug_pagealloc\n",
+			((u64)linear_map_hash_count << PAGE_SHIFT),
+			ppc64_rma_size);
+		linear_map_hash_count = 0;
+		return;
+	}
+
 	linear_map_hash_slots = memblock_alloc_try_nid(
 			linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
 			ppc64_rma_size,	NUMA_NO_NODE);
@@ -344,7 +354,7 @@ static inline void hash_debug_pagealloc_alloc_slots(void)
 
 static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
 {
-	if (!debug_pagealloc_enabled())
+	if (!debug_pagealloc_enabled() || !linear_map_hash_count)
 		return;
 	if ((paddr >> PAGE_SHIFT) < linear_map_hash_count)
 		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
@@ -356,6 +366,9 @@ static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
 	unsigned long flags, vaddr, lmi;
 	int i;
 
+	if (!debug_pagealloc_enabled() || !linear_map_hash_count)
+		return 0;
+
 	local_irq_save(flags);
 	for (i = 0; i < numpages; i++, page++) {
 		vaddr = (unsigned long)page_address(page);
-- 
2.46.0


