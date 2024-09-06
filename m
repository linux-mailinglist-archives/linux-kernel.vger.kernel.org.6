Return-Path: <linux-kernel+bounces-318917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1D96F50C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF64B28935D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5D1CDFB9;
	Fri,  6 Sep 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FTsepkii"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487B1E49B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628177; cv=none; b=Tnh/oB1sVADO1Jms7MEWedaYj6Dy2x0EqJelWWtRRve9aLdIAUAdWh+KnJZzUEAbusMz6ZQVnq0C/KLTqa1bvbeN/T4RG4bm7H3o5iLqthhG9LNqvbmHDZiiflIYk7ycXoS8bnJCBDP5TtoK0TFsrQgcReXL7HgXdni9dyk6QvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628177; c=relaxed/simple;
	bh=vkz1j691kOXz9SbOEQCXxyV1wA4jcjrSKVZBqAxbF5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBb1eE6yLa5oKaesdAoJVexesam3q10p+7PfHzvhr2C4LThKDEgEyL4ZbHLb322I5Z0toMqnzlmfte4VmjIVwPb0iaelxMf2fxZgRU2D0sa/TQzyEgAMPsuGoZxT4oNEIfQKUEPX6Lde2d/D5Zf0ieqx59vMArgWfs28OaSznTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FTsepkii; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206bd1c6ccdso18989565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725628174; x=1726232974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJajFCqDzvxotVKyqfFZXW5cvxptzp+3OPXG+GlIUGs=;
        b=FTsepkiiFXxy8UK10j2vY6KbbPpEmp0Q3WtAvUciGK++vG3xyim/FCKaSHr8cLTABE
         1K1Shm2FhXQDSseVn+9xlM7148Md9wdi5voufBff7IIniQaZ/7h34Hb+oD7Nm2IQvi4b
         uP6M8EPbcySZ6Z/y4LNr2isEMNNA+zq4g2hvmxDpAU67x1TFvOb+kzbIosf9o+JF+ahV
         tott1HUSescyfVKRNXnz74VDCTkJWl82MAOuYfrA6QoVP8ndtqpFX/ONg/Um3ma8JiG+
         Rj/DaFtgfyCNDbl7LZbLaP32xkvBwIB0HG+dnn4Hs9yqvOE6DddYef1N426LyFkp0td6
         Ryew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725628174; x=1726232974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJajFCqDzvxotVKyqfFZXW5cvxptzp+3OPXG+GlIUGs=;
        b=qA6GNqmm/zAqXnaxdf408i69ultKyZ4h/lFYdQz4wNEnlgZjk9Ato3qqUbBAps5G23
         /z9PsywIS3mJz9hKf555e6XHHZ7wKFJsB0RPywqzELq7daqiESwKv0IRDP9wDgAx/iZ5
         urkvzWnU9r0WDXAT8GMObD7hqetVnEueE4rvdB0xutFos3YFYQWKidb2h10eGRuLoijk
         tOSiZPGvKoNQGyit0Sb5BaNdBLyXzbouppLpNjxIZTgyKeCwNPNGAoaMsbo2M0zqGB39
         L7yRmSbJUIAD1Jii9Af8nY0B69UejeDJoW59F2SlXyS1k61luuC4altbxCWs8Jkw/p+j
         LHug==
X-Forwarded-Encrypted: i=1; AJvYcCXqEtRYMhbJm4aGVlBMVU5Ip4A/Wy+bN/OO8cPPFOJveQ3P2UXkB/ZxY20sM7hAqX/FiOhuAfdQcAcyi4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXwG5SghLdCz+qi76MYCTZQxbGIvhh38tQd8kPTdSomyWAoT1
	bbaJmFdbTphV23Zfohf365ZTFrYlZBPY+9Zj6DojVNI0KlJR9sULTeH/Guz4bX4=
X-Google-Smtp-Source: AGHT+IEqMvxJYGTr1MplRvnRtTL+3ix6m4N5T1NPlcfCFEpIUvtMlO7Aptwd/qLAnbDIWmwh7qDiXw==
X-Received: by 2002:a17:902:e84a:b0:202:47a4:7a1e with SMTP id d9443c01a7336-206f04e1e09mr24038145ad.16.1725628173870;
        Fri, 06 Sep 2024 06:09:33 -0700 (PDT)
Received: from CWMV1S3.bytedance.net ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55b05sm42764465ad.202.2024.09.06.06.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:09:33 -0700 (PDT)
From: Haiwang Fu <fuhaiwang@bytedance.com>
To: akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	fuhaiwang@bytedance.com
Subject: [PATCH] mm/vmalloc:arm64 support cont-pte huge vmalloc mapping
Date: Fri,  6 Sep 2024 21:09:19 +0800
Message-Id: <20240906130919.3765401-1-fuhaiwang@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fuhaiwang <fuhaiwang@bytedance.com>

Arm64 support contiguous bit which is used to increase the mapping size
at the pmd and pte level.

Now huge vmalloc support PMD and PTE level mapping, and support
multi size at pte level.

arm64: implement the fllowing interface on arm64 to support
cont-pte huge vmalloc mapping.
arch_vmap_pte_supported_shift(*)
arch_vmap_pte_range_map_size(*)

Signed-off-by: fuhaiwang <fuhaiwang@bytedance.com>
---
 arch/arm64/include/asm/pgtable.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc9..3f32e3150680 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1814,6 +1814,34 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
+					u64 pfn, unsigned int max_page_shift)
+{
+	if (end - addr < CONT_PTE_SIZE)
+		return PAGE_SIZE;
+
+	if ((1UL << max_page_shift) < CONT_PTE_SIZE)
+		return PAGE_SIZE;
+
+	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
+		return PAGE_SIZE;
+
+	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
+		return PAGE_SIZE;
+
+	return CONT_PTE_SIZE;
+}
+#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
+
+static inline int arch_vmap_pte_supported_shift(unsigned long size)
+{
+	if (size >= CONT_PTE_SIZE)
+		return CONT_PTE_SHIFT;
+	else
+		return PAGE_SHIFT;
+}
+#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
-- 
2.25.1


