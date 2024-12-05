Return-Path: <linux-kernel+bounces-432985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450C9E5296
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F70167D75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED72066DD;
	Thu,  5 Dec 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LEKcgbwR"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A82066EC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395130; cv=none; b=SGLUAwQrGAZC3Igc6qpOsdnTdsu6W8nOArHOeealwHdGz+J3RpqK/h8hTgtZf2tBo5q81gSBXabmb128EVkowPs5VYM/2dh3a2y3P2aXQAMwi7+r874eCXm2fhjRrp21x6zFmlhSXOVHOSmg4YXcWdUBCgUYpIMlZWdmBEoOS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395130; c=relaxed/simple;
	bh=ppeWGXE3JwCtgI11oYFm67q3jViFEy7jG8L4BpO6njk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4WZzObGrUs/Dptzz9fVQM3J+ItqyvM6RZL0vl3SH2eqskKRZf4GzVVt+4Lq+pc/tlMFUFV7pLdtjyhXnbAtmC4KazKyQu9AacgvOtz9LV2RK3iCDLfSVNrQzLlKmAMyPrdwCb0LHAqD4oFejbdN+7qtwOVZUF8wJX44pXtb4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LEKcgbwR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea4c550a3fso414457b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395128; x=1733999928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x95dczg6H/IuNQfp1VlRQgQwszamKCGOevCsmbhARnA=;
        b=LEKcgbwRI36+p/0MwvKqPxQUH0FjNUZJq2m6iy5WcSIVAI7M97AIn7zxwSfQA5yqU9
         FcEv6pf43g6R+Zkr0xMlySwRewCEADEzNwmYY+aScQaDKjn4XUUTwh7zsWsiMh/PSpfP
         DZLZeNnINn+TQhRihZJcvEEGGUejHX2U6tiiufewBtjPGGN2S6WPORXK1oiLJ6ezwnw0
         jox0kvqeHFrVlJnb0kRw/dCNxUBh9I5/eXxDlYREsViQUvGk9QsvqITGjRkd4Ea1znWZ
         CYDNSa2BT9xCytSZGvMgHiRKB5L6mp+Z4IevZrwyCVkLd/B458e6AtWZW97hRvNy4NWC
         vFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395128; x=1733999928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x95dczg6H/IuNQfp1VlRQgQwszamKCGOevCsmbhARnA=;
        b=optlT7ToTNAGF4ApFPQRCwbAnuKpRpdxjIrKmcRhOvqdz/gUmzB7AhuappSNLoUcsy
         84ASbBIKfBw9S7y1J5itr3uY9HD3/UKK6vehzZGh41Prcjj8DqHYWn1dxU2EuRovYthL
         iQqJ+TzY6dSR8G50bi3Cwv6tsMHcuwLKKscyOgSsO82sVK0xGMtHzRclQjEsue+ExR6k
         UW1ZieBsqab8BRyXifoDPwRg2pDRoaCNmMr1+kw6NNAAk5mdmbKzfR43zTcpg6xZ+Oix
         V+Opa7ekXbsnUVIn2wY/ekANZQm2P7oQEWmgHYPhrlKj9sPmySR8eaFLaz9A/L3CL1JU
         W4rw==
X-Forwarded-Encrypted: i=1; AJvYcCXohvqXn5Wfw9kE6OvzeTEsFCOkF4303x/lad8sVPqXFD5kTekjFYDRYX235FjCG6AbPxmvf25weLXcOgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgtPM8u8wEN+zbNCWx3LLHQWtKrT/NsdS9JcCBp/60x85bP86
	ezMUaCN6pS4oGOO85MZvLExKaquYG7+uWSUNb6lQP1zhlkOFkJOc/eCgwT+EQsA=
X-Gm-Gg: ASbGncsuYdSePd5IQgWYytS4vmr39lm30KUSSo7oc6rnFDOB5Eebisci7Ml0NLBxmE3
	SoeuiEpJwEYXx/bViRN+0qO9tpnzc3/aUpCm++skQf8c880Tma8RcpHG02AkivQhlXLwPxTuXa2
	pAa37MdjmGbKhmMMWFEKHJYY9W14Unuln9KlqLm0wKNvXr09Y66b4zR9MPBesUlCvJFcLy/uxOr
	idZFreEcV3e/LNMwmYgHAnZiDqMkoKij/Bno0tgWZuLxn9GRn2v+9eKQMI7ZUArQ8kN0o3t5ujm
	umqLd3zXAvveo6F/KhHYUYFDOaLu6r0+
X-Google-Smtp-Source: AGHT+IFzuODYxPZb1b0Hsra5aByVGtGgW30pbNXl6TXKG3vo0iIQP7jLbPRNzxf3m6EfJtUU2ofomQ==
X-Received: by 2002:a05:6808:bcd:b0:3ea:49a1:cba7 with SMTP id 5614622812f47-3eae50c5186mr8718922b6e.41.1733395128040;
        Thu, 05 Dec 2024 02:38:48 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:47 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 17/21] riscv: mm: Apply Svnapot for base page mapping if possible
Date: Thu,  5 Dec 2024 18:37:25 +0800
Message-Id: <20241205103729.14798-18-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All hardware pages in the same software page point to the same contiguous
memory region (the region size is equal to the software page size) and
has same prots. Thus this commit uses Svnapot extension to optimize the
mapping to software page to reduce tlb pressure.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 16 +++++++++++++++-
 arch/riscv/mm/pgtable.c          |  6 ++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5b2ca92ad833..9f347e5eefeb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -483,13 +483,27 @@ static inline unsigned long __pte_mknapot(unsigned long pteval,
 	return pteval;
 }
 
+static inline unsigned long __pte_denapot(unsigned long pteval)
+{
+	unsigned long prot_mask = ~(_PAGE_HW_PFN_MASK | _PAGE_NAPOT);
+	unsigned long res;
+
+	if (!__pte_napot(pteval))
+		return pteval;
+	res = __page_val_to_hwpfn(pteval);
+	res = res & (res - 1UL);
+	pteval = (res << _PAGE_HWPFN_SHIFT) | (pteval & prot_mask);
+
+	return pteval;
+}
+
 #ifdef CONFIG_RISCV_USE_SW_PAGE
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 {
 	unsigned long pteval = pte_val(pte);
 	unsigned int i;
 
-	pteval = __pte_mknapot(pteval, order);
+	pteval = __pte_denapot(pteval);
 	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
 		pte.ptes[i] = pteval;
 
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 150aea8e2d7a..0bcaffe798d5 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -11,6 +11,12 @@ pte_t __pte(unsigned long pteval)
 {
 	pte_t pte;
 	unsigned int i;
+	unsigned int order;
+
+	if (has_svnapot() && __pte_present(pteval) && !__pte_napot(pteval))
+		for_each_napot_order(order)
+			if (napot_cont_shift(order) == PAGE_SHIFT)
+				pteval = __pte_mknapot(pteval, order);
 
 	for (i = 0; i < HW_PAGES_PER_PAGE; i++) {
 		pte.ptes[i] = pteval;
-- 
2.20.1


