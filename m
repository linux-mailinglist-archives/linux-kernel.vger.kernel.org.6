Return-Path: <linux-kernel+bounces-369675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567169A20D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41091F2440D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9351DC739;
	Thu, 17 Oct 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tddXxNoy"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87E1DB928
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164044; cv=none; b=cCzvd/myd5ELd6jfHhyL1+SRQ9tmCfBdU24GkF2uSLl6zM9y7Lx0aPj6C9dyZrLTzKzYwmfXWc9l0ukKTGdXuw7+xkThZtNmVw5176pG37b4wkq098ZIRrwImBbmmVS8s6vRvQmZu8KrxBh/8pPkM5p0XN5UXVcTWK8JozlhB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164044; c=relaxed/simple;
	bh=KAP8sNYlHg395CZvSk4JBDKQWzF0UsR5MdlwWexgn+c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sB8hgFPZESjFlb831Z8nJjPa5sPyJsJIVqup56qfurME70zS2Bgy0xNG9QAcktAFPVYtj7HKOwz3msudH7EG06cvLYLZFwUDDYMyGtC4FJrIfpzbGnTztkHi0S/P43A0hIkvg0HY4A/slp6yt+ixRPW5Yrg+qWwrN45e2RBoXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--konrada.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tddXxNoy; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--konrada.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a194d672bso56464066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729164041; x=1729768841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n8lX1GmEtOr6LjU6fqL4HANwkfAPHfX1qh42rxSH5WY=;
        b=tddXxNoy19en9T8ProXOhNcYK026nX3iAyE00HXWpxI0VQQ4v93mUaWzp8O/Mtseex
         CVlQO/VIH72eyluvu6QRNrWScHquCGBSHXKd+PPCx09HVWmjTG0wW4uL7qhAw3g6L3/F
         qp/KKmFgWDm2rcN+a9lpmR+ISmT2tQpEfK2jz/cqK9W+376pKKw61l1PLKU5qQEe96pA
         tD/FviFHEOMZvFX2djNhINm3cj5In51111kGod1TZpFGCDBQjCmHugAWUXy1nIOVUt/B
         9hj3pm9TzOtkCY/gmmuPpuApGR484lT+ZMLpznMmrGm4joOyWmu3m/VNL4ZfhHxBQhr5
         gXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164041; x=1729768841;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8lX1GmEtOr6LjU6fqL4HANwkfAPHfX1qh42rxSH5WY=;
        b=M8mm0cUkGnvV0BwLKYgfy7NtUPGXVd6xlBVOsRrvcgzSitxCCHBRbU0zYre4QnVRbC
         DduWszpICUfhJ9QrN4HuK3vcjM46X/kGWo2YAepoDm6Ld/vSN0QRyKTIe+CT7BXgH3Bt
         OWlQydScs5hqSoal7ZUA5QZynIi4j+/KKnIAmWJ20bG3ciUxv8MPW8cXzho2dab0fHYp
         YSO2MIi0v5JSfbBCxjcVCrHZoK5siNuETC7hNvBljNrZiFr7hox67xZ7Ov0Ax2omyoKz
         8kjmXGqjgAH7nJkwwQ6CfTgjg2fU4SeunMvkbnTCbVjwfmLVO9ctsm9wyZCQtQx5JHg1
         Q2QA==
X-Forwarded-Encrypted: i=1; AJvYcCV5VHsm7KkJ70sGljujuSDkVdcJS/mrL3Qf2f1HfiH8mYaEoXdl2+gQVbfcHdLsHbbr3mt1/rfmqSrSF9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZ2M+D6nXV53aJIAGSh0NYupdzcGMAjpM2wMcoFt2HJ+9cfom
	PTm2hTDHwPQhY+PWIaCzX1WYoWvFfK+gtR353PYGVAvePMjTdrrnSjpP1Sy3oVsNZcgSpa1joIA
	WEmVPSw==
X-Google-Smtp-Source: AGHT+IEDyt+T9WSjQe2tPO5YQX5MHOujfHpdD7iqlf6ce9MuLBoasfebCTsbGQEpakvLtWeTyF2ZgqEh5dA8
X-Received: from al-for-all.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:545])
 (user=konrada job=sendgmr) by 2002:a17:906:bcc5:b0:a99:fe61:adcb with SMTP id
 a640c23a62f3a-a9a34c7ac36mr210566b.1.1729164040346; Thu, 17 Oct 2024 04:20:40
 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:20:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241017112036.368772-1-konrada@google.com>
Subject: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform data
From: Konrad Adamczyk <konrada@google.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: Wojciech Macek <wmacek@google.com>, Konrad Adamczyk <konrada@google.com>
Content-Type: text/plain; charset="UTF-8"

The MT8186 chip supports 35-bit physical addresses in page table [1].
Set this platform flag.

[1] MT8186G_Application Processor Functional Specification_v1.0

Signed-off-by: Konrad Adamczyk <konrada@google.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6a2707fe7a78..c45313c43b9e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1599,7 +1599,7 @@ static const unsigned int mt8186_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK
 static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.m4u_plat       = M4U_MT8186,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
-			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM,
+			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
 	.larbid_remap   = {{0}, {1, MTK_INVALID_LARBID, 8}, {4}, {7}, {2}, {9, 11, 19, 20},
 			   {MTK_INVALID_LARBID, 14, 16},
 			   {MTK_INVALID_LARBID, 13, MTK_INVALID_LARBID, 17}},
-- 
2.47.0.105.g07ac214952-goog


