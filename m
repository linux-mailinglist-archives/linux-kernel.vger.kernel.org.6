Return-Path: <linux-kernel+bounces-445937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3A9F1DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEDE1884708
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755E187FFA;
	Sat, 14 Dec 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gv8m8mur"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF3186E58
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167046; cv=none; b=fVbK+PzugG+bQRD+LJE1MGPEH9T4pER/+m4OW+sMoNNvRvRef+c6yzePNL+EqUO9RZ794VJt16qC/HnhNUE7mW7wDAVreIYw9u1lZ5vsQCusylyS6zzbAMSigbib9N4YRM3xc+AokmZSdy4OlDoZraw3s3aa5Qu3KKl3Z/La0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167046; c=relaxed/simple;
	bh=1uZWvJuOb4bQfFe2ieD3kaHKgbuZ33TDPnehFQMQRrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZglGtvNChv1EahA+Qwqw1XSo7xeoX8qgd79ZxUwJ9NmgJbahgDLQD3LeD5nsHusuNg6tadoyiCCVyp0mxavuur3RwnYTT2h4YjlkwnqRqIjjtnF0cgFq05pLNtig6sN3r198fpzXCMFYX/E3uzzhos3QyQULScFtD1NgWkbcWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gv8m8mur; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e729562fso2081678b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167044; x=1734771844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyTYWh3zj2l92o0qEOJPcU0U+om/laakNd04Rx8p+XM=;
        b=gv8m8murWGbU5tdHkAGdgQ39VDe+/aUpStOBUmcf9tmjQRCBdrj46nHyqmamOvR379
         WLibRE+jURsk3cj/x61nnwLnoqEA46KIdz3w3hVD7nXO4pkbIes+VoCeU3snsTmfH2Bm
         8HggWCCVXUiaO6rmXDm7SfZfwIntlHWZpuk3b+WqUJmhaHtC6cwFxqrpUw8TVFI43aMK
         /q5fH0rkWZloy13+6c9eS1PP2tuRujVTghaZfxlQFnqJaZSKCfMrTrZ9QiO0wfwZQw1c
         Ss8+0qLxqBs4+yPsGEueYejXMpjVXtDmPGsIDQ7h/PPjymreEYf0LRrVjMpQy22StgT6
         cltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167044; x=1734771844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyTYWh3zj2l92o0qEOJPcU0U+om/laakNd04Rx8p+XM=;
        b=o318ZqJdRhZcKLm8rFpT1X9dHR1ml5tVXECvxiQrn2UP/H0MB8S0TXs01+5DHj43dv
         cQVq84LRUjZBo3Oc1juvllELTkSileDQH3qEHrd9CNn4D4oedxaMNOjNN/+QUgjIk913
         sx+Gz/WsdFwblUrqkpMyyofQEOmkZGwpHQSvMWwXMJ7LaGYnewtgfqs1lKoe4Gc3/eEm
         vxlA4JAYeYULJKuyVfrrqlbeJtIo5e9EGrp2Lv2oddmI0Enhq2VOGvTI5AT4+mPNYy9v
         EDyfH+9UTCZLsg5jSN7xl2cqKbPAwGJTY6qKMck4ewcS+EWXvlLUdeBewzflfKOLhS5x
         MNPg==
X-Forwarded-Encrypted: i=1; AJvYcCVPsEZdv0YlfVS3zVt27dtJ7+2fjtNOGLTGZ4qONSz7+0LxAcVKwiP3eM68YXmdne348nRVJeUNvEGaIPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2wZZfdZ0hiRA3UMFrUV+VdPFHYRWsxG0xKJxHTEbRHUC2n6g
	KhSUlwE/ZmdMFvH42CUC/feDsGISK6I86zTf/qh4eNbxJbFh3w53Xj3PKlDMRDs=
X-Gm-Gg: ASbGncuZ4HccxC7ycULXyLLCFmWWVajExxbShvK2emGzs3uKCSCo0uZNCv7mRpcsVG6
	1zLA1j9RVNbQBI3RZ9M+4l8o5alhtPVh4lb2KZRVGx9MC+y7I77KxQymeGtofH3OVSJwM250Tk6
	wUf1PMXokl0qsNX1FJYHA3bMARBY6Ic8q21e9zPsW8ms6wn14dYZYMqLu2+YsHOhYR/ps4Ymsl7
	Xsv6D9rL8RSKPfvifCiuRoingmfc8qN5ly5CiJaFoqul888rx9QaCu2gAEVNvgVSPIrzgC7sqd/
	I+fsVIwXx2fTzm+ENXTrPjA0uJPm8g==
X-Google-Smtp-Source: AGHT+IFlpyRvtlHG2M4nIIBLJzVMLLLjWf8IFr835Xb0HMOnd3F4yHyM51MIPZOReaS2iWrLwbmGTw==
X-Received: by 2002:a17:902:d481:b0:216:4b66:1f1f with SMTP id d9443c01a7336-21892a7c538mr78037165ad.54.1734167044262;
        Sat, 14 Dec 2024 01:04:04 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:04:03 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/12] arm64: pgtable: use mmu gather to free p4d level page table
Date: Sat, 14 Dec 2024 17:02:49 +0800
Message-Id: <fd2faee37876dc6ea93d0b8dcd001e13d77c3272.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  2 --
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 679c530549327..58cc260b6bee8 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -100,8 +100,6 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	if (pgtable_l5_enabled())
 		__p4d_free(mm, p4d);
 }
-
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1


