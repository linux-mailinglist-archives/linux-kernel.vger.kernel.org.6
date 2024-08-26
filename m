Return-Path: <linux-kernel+bounces-300895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4656995EA37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DDC1C212AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0A12FF71;
	Mon, 26 Aug 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXcf/bD9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513C13BC35
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656628; cv=none; b=shWFbEVwWY5eutvuniBje1x6pgGWENxbgN7ZXRogFG198C1MPqLV72fUBU0Rqc1qlFmxrtHrcp8d66c9Yu8eXDpaEWNGD1SuP3pj2yrL2UPN+a5fyPmdfwG0F69twwvJyvHAdPS3lTUo14G1fhsdfx9qDRbmqQHcCZudsq2Ltt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656628; c=relaxed/simple;
	bh=MZZj2SAvpagdGOtXPGGnDmJg+RAzKw+H3OQrffzD+8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ee4GhZduI6CXyM+zGUzqe6hoTATFiGmD7r5Ksi6ukkF5jlcdx/8MNmo89BNDX+jGyO/j5rJJQ/JYOiydQkhdjaXXhdDDk6vR2ddFwrmWoviQau9c6HHIru39p4ypS3K7oLzf73aClh8/+sEdUsASn/Xv54kDdHeNWUbWH2J2hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXcf/bD9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159159528so6747520276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656626; x=1725261426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=glhE4wUH8upwh3h840zUvzyaLndPAI9WWeySK76KAe4=;
        b=UXcf/bD9d6JZBbxuUTzPYT8zpr4pYMPLj8VX0tGZHpyA2VbKkuvrmS2um2l/mwJDeH
         Leay1xl6dfAHMzrW1HnFf77Qh3jjMOuUtJzp3kEF57furKynJzGY1TZqdzITq+s1AFHa
         IJW8QwuMv5JXbTDt7ZAUT82FGnE/NjcbyUUI/sBu9zPjh7QAKCrABhCxV2zJKXq8PsBR
         iDybzlVeBNuO5T4rAYcenFqVKAerfMfW8J0zybLT5qdmq19ijebqhLQPEvrQ/XdPdUQ3
         RmAiTlM4nrQvvJgm4ejxgJaVl6Ie26IH5DUBtHdRBUvQbPeoJ1afszizfzDT0tDMNHVT
         h2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656626; x=1725261426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glhE4wUH8upwh3h840zUvzyaLndPAI9WWeySK76KAe4=;
        b=XpT6t0oJk/wk3AykEQ9CLQe5mMe+/GdMXlpT7Z4rChp2uqB9umHD83rGZhlY9UG9L/
         qD7uBm+QTUgdFfOV2qjN2dSkSDVQWA06WjgldUPptG1Jk5a+r1OB3Pl0gYOF/wncuMNr
         Dtkdmzv5wleKLjNu6IIBGIVSYoNrqzYRKsVGsQAM4j5DpSD9J1b0dqNt34U21bBQNGPr
         ZNu6xqAcERbItIMm46l9EJEY5GG3nKFQNxp1cKdBA4Lx7QIljdKfcz8lMIFUoXb/LQox
         mjrBd28KRlGg+YLDWRtNVnJMG/TSY7qYUXiq9O2gxe3tJf8p62B7Y07m75S5VSpMEgME
         AQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2aUGzN+cwz4jsH8wOfv4o0/tN+aBSl5RHUGEMIArgZHqd0awJHvs19UAHJMSNybABjIAVUk6yfMb2EBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5po8JhuHDf29ZEczzbxaxMHj3K9fMhcHjsejvmoIfd3fKtqU/
	jMb6dJPCBsueHueAbcYcjpvq6h3IDYu3Us+TSBdzS3tdll25l/z0ERX7THBbuCOYLbFVkA+D4hS
	BnsyxHwvyDfvMOA+0GA==
X-Google-Smtp-Source: AGHT+IHNO2NOT8z5pjPX4FeBdIeAVLHmjqUYd3PJJUwIcYAFNDV3F2bzyhnKkfV2wlyMcU549dbh9KtZHmBsNHWt
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:aa85:0:b0:e11:593b:b8e7 with SMTP
 id 3f1490d57ef6-e17a7a6905amr147799276.3.1724656626199; Mon, 26 Aug 2024
 00:17:06 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:16:41 +0000
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826071641.2691374-5-manojvishy@google.com>
Subject: [PATCH v1 4/4] vfio/type1: Add support for VFIO_DMA_MAP_FLAG_SYS_CACHE
From: Manoj Vishwanathan <manojvishy@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

Introducing the VFIO_DMA_MAP_FLAG_SYS_CACHE flag to control
whether mapped DMA regions are cached in the system cache.

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0960699e7554..c84bb6c8b12f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1562,7 +1562,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		prot |= IOMMU_WRITE;
 	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
 		prot |= IOMMU_READ;
-
+	if (map->flags & VFIO_DMA_MAP_FLAG_SYS_CACHE)
+		prot |= IOMMU_SYS_CACHE;
 	if ((prot && set_vaddr) || (!prot && !set_vaddr))
 		return -EINVAL;
 
@@ -2815,7 +2816,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_SYS_CACHE | VFIO_DMA_MAP_FLAG_VADDR;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
-- 
2.46.0.295.g3b9ea8a38a-goog


