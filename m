Return-Path: <linux-kernel+bounces-281665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1694D9A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82461C2172F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770922339;
	Sat, 10 Aug 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6aVO0jN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2649626
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251556; cv=none; b=pZ8lr19v/NFCvNTxt4UZTKxsglDTRwyPvdjYNXfnYudtsnkDet1SH95Sob9Qls8RsRabY4URe7UIS61i8pwJCY9T7yj507mu80b/ovj3iw/aV/jSvS1vU9PVkFymgeLU622JdJ/mCMn8TIluBr4WVyilIbQSQZqHxFVBudsp4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251556; c=relaxed/simple;
	bh=Qd7PQGlgqKWRuWWjokUhPdESXuWBLnqq7/eOi/nr0rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m1cRdANXjWY3Nwk/KtAMVUYmCNXjz4irpEUbrsz6yoR0QvwZEuId9QRLvXQlPNUXhofA4bcH5ijonIBstNVmNR5KU8kpvAlh39dhPwDc2m0QDFpuimNxX2Iq+H08hkogsJMLSSL0I241KWvOxdQZYfCbcJRKEGSpiXsUlrctwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6aVO0jN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3742b309so4369027276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723251554; x=1723856354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzRe7SJD/obU3/qfFI0GbsgavYc/p8tTU00CB2noSOQ=;
        b=n6aVO0jNtyeSS67c4MLhlFLx56vU5XFqtn10BsfgY+Tt7ujnpB00eZRU7lHOPWztGZ
         C7+A7IFxM6h557icDAb+oBGUIybR4X51I8JWZ9cmQ1Wpjwe09n805U6Bvwy7blxAuQyD
         NK6u6DtjYU++XLgDikOUvzVyDDC+S/G8t6LljZ6P1ojQbwa838i8IPx1pQQ32l0ZaOr4
         h/5rti47t1ynIy5GYiC682tRcvu6b9J19DqgWf5ovGmqymDx72Jkrzs6PmOwBGP7E45M
         SvpuphQ09vJB5RoggTnB7gghoO4qPMMCWAN5RRv0FcDqBZti6m3kf7OZBko7UjcHtda/
         VZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723251554; x=1723856354;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzRe7SJD/obU3/qfFI0GbsgavYc/p8tTU00CB2noSOQ=;
        b=ZxLHwsy862vCoNHiyt2Upmf42wDg7LwDp8hI8XWmY43992sml9LDgdfLUn3UiVeCTx
         vz2etEtAnwvpjZIOPPcToYOqmaATxu5tlb7+5j/2JuGYt8rmBsBHJ8IEnTuEH0ME+2E/
         E5Mgk3aS+0uavg+3HE5EHC6Le8VP+ccTylhLHZY/5WNZr7dndzNP/VfpB8WKeR1IHNUT
         XXGiS93YY758kNSFjEkapyER7LNDbnNbEjRZAEoTUxVye9puZi6+4P9qbv5Tpo/Eq0fY
         i36br22Zx0vMmbCeJIbw94wmal3aMrAuNA+T/koR3WvYvmeoL869B3VQjl3MKlIhltf4
         cqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOOCkVWI6yN4R25O9gLFOo+QAbY8J6NHJu7FlDi1biLXuhrlzCMWxQiwK1DArWSBzuuYpHaktGh0DDZMP0/iN8VqHCwphWxJv902ZU
X-Gm-Message-State: AOJu0YwtwE7nErHgnV/r9zHbxveWOk9TmRwlHR9t+eMg3ob1raSHeniB
	aM587uhsic5l+gp5D9HFm/k+FBPBK4kQ8Bbq+zPdXZ2qr35HE8W3zmiqEch3zklpxBoslLeXeph
	1z7CxN2x9WSlzqreB+A==
X-Google-Smtp-Source: AGHT+IHD0Iz9jlKUFUJREyIgq4IGjnZvc8Lz0nEksZRzwjg7ycn2KRHYS2pQ8au66FNFZ3hf1c2NXmzyd8oafA1x
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a5b:c4b:0:b0:e0b:f684:e972 with SMTP id
 3f1490d57ef6-e0eb9a32f37mr29248276.12.1723251553634; Fri, 09 Aug 2024
 17:59:13 -0700 (PDT)
Date: Sat, 10 Aug 2024 00:59:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240810005911.684644-1-yosryahmed@google.com>
Subject: [PATCH] dma-mapping: use bit masking to check VM_DMA_COHERENT
From: Yosry Ahmed <yosryahmed@google.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Reiji Watanabe <reijiw@google.com>, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In dma_common_find_pages(), area->flags are compared directly with
VM_DMA_COHERENT. This works because VM_DMA_COHERENT is the only set
flag.

During development of a new feature (ASI [1]), a new VM flag is
introduced, and that flag can be injected into VM_DMA_COHERENT mappings
(among others).  The presence of that flag caused
dma_common_find_pages() to return NULL for VM_DMA_COHERENT addresses,
leading to a lot of problems ending in crashing during boot. It took a
bit of time to figure this problem out.

It was a mistake to inject a VM flag to begin with, but it took a
significant amount of debugging to figure out the problem. Most users of
area->flags use bitmasking rather than equivalency to check for flags.
Update dma_common_find_pages() and dma_common_free_remap() to do the
same, which would have avoided the boot crashing. Instead, add a warning
in dma_common_find_pages() if any extra VM flags are set to catch such
problems more easily during development.

No functional change intended.

[1]https://lore.kernel.org/lkml/20240712-asi-rfc-24-v1-0-144b319a40d8@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/dma/remap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 27596f3b4aef3..9e2afad1c6152 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -10,8 +10,10 @@ struct page **dma_common_find_pages(void *cpu_addr)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || area->flags != VM_DMA_COHERENT)
+	if (!area || !(area->flags & VM_DMA_COHERENT))
 		return NULL;
+	WARN(area->flags != VM_DMA_COHERENT,
+	     "unexpected flags in area: %p\n", cpu_addr);
 	return area->pages;
 }
 
@@ -61,7 +63,7 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || area->flags != VM_DMA_COHERENT) {
+	if (!area || !(area->flags & VM_DMA_COHERENT)) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
-- 
2.46.0.76.ge559c4bf1a-goog


