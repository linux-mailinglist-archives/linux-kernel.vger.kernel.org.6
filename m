Return-Path: <linux-kernel+bounces-185922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1768CBCED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B041F22E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950777FBB7;
	Wed, 22 May 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwcxVZ/M"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1457710B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366455; cv=none; b=IgmJR+JvnDDwnrY5Y/thNdrUuUPpj+r7ItgzaLysP1+KeNpQtjA2wQmRvhSd5134QBVaIG4NkHz28sXOyPanJlndRfOeYos3+4kAHZJFJxR5w5f14RR+G+iln5eKFVWer6Cpg3uIwd7X/i7Fcvac4BaRP8Ga9HdtwKPEZdcZek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366455; c=relaxed/simple;
	bh=OmtWAKQ6saASpj2ARv+RA8pwd2Z/VtPuUOeaHHH/InA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M62SAywPlQIESQdAZDeklMkd/Jk8zFVAFBzeyP2D2gOYvsxZY8TifhioMr+7C42XEb+5P8qpuOQKwQb1uwKz9PQ5Iwaw7Yaup+fR/ecFdxpUERkbuSwLcbK+2lVPqI7lWh3YeLmFDDZO1wsbkqKskuv9OEIY+bmmqQrnBCXCd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwcxVZ/M; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-350513d2c6aso3532713f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366453; x=1716971253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIn2hFlLwHZLk8/r/RwHC6tgKkycOicAcOyv0sMfHLA=;
        b=fwcxVZ/MXHkIfXqEb85f6+vB5kHpp5tFyZcb9KK+kDrNKn+YZC0ye0W9q0zOfVuvMD
         JascecsnzflJOraeSe9tSS5EYIGFflAVVEMKZtxbzPHyRMVPoflVmO/kEGBCOf2oD+Sb
         2axtbkjSYcLKpbwo4Zp0Ze7e0EbP+aFtChyqGUh35DNRpYYKwZTF6UbORrYp2qlWlUb+
         NH8gHVzk9UM5NtgZJAkdE3lpk6u8ah3AzMxYIB/vwXsup3e6mSKFioQBieY/1CpG/1vm
         BEKDXIiL6msExwva+xjKWOCsjg219dYvzxBpTwoSCStEdrP4BlkMxku+NPqZooK8LQsN
         Us8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366453; x=1716971253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIn2hFlLwHZLk8/r/RwHC6tgKkycOicAcOyv0sMfHLA=;
        b=mhvotzUJBd8SZVSkM2Q8WX5fenuZKg0CRT6IiC6T2jb+aR4rsYd9DspvkwL6EWVLw/
         g09ATastQrCW5yKQ4lWTERCdTuijV/HDNmzTgjIE4znVHFxx7GQwL9zcEjcLbiCL5A1P
         HXqbHshZOAouZdMe3PcpLZyc+qKTvOxfHdB9uSzBM3cmKiZfzF9vnwvbC/LLVlOVeblB
         ywVbjoPoPrlty5/g1dk/kjCFhiTWreie2vrvEJFVicWs1F1Xpu31qSJ7lfO8yb3TL1CX
         mToUSPLIAnCOfyESWfjAGUrVeGQe5LvbdPISV40ss77rx1lW6/KVFoNreHw+JDs94les
         mpgg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ca6bN/bTcKn6GjGEnuNlLEjgLDuBquQ6WbQsjjxC5gB6SXXz7VJZXgozkuKNH06sqs/PHeAApMFQpLfhnRAC5xuovXXm7xi51018
X-Gm-Message-State: AOJu0YwD8oLisyUQptbpT8LshGcdPQ5NlIc9kilDFMw8G6tu5FBWivmc
	eoyGKvcHDhifdQUbz2LcDcgH/E+nzSgluu8I/Zx0hxcJDS9efS3e
X-Google-Smtp-Source: AGHT+IEAlFXB8gX+a8kBPrsUUXrnREyr2t/5JJo3GMmaa3M1kWcv5IUaodnL7Q584OTuw2KLgCZvpw==
X-Received: by 2002:a05:6000:2810:b0:354:db7f:a6a8 with SMTP id ffacd0b85a97d-354db7fa7camr699059f8f.55.1716366452466;
        Wed, 22 May 2024 01:27:32 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:31 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/3] iommu/amd: Use try_cmpxchg64() in v2_alloc_pte()
Date: Wed, 22 May 2024 10:26:47 +0200
Message-ID: <20240522082729.971123-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) != old in
v2_alloc_pte().  cmpxchg returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

This is the same improvement as implemented for alloc_pte() in:

  commit 0d10fe759117 ("iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte")

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 78ac37c5ccc1..664e91c88748 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -158,7 +158,7 @@ static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
 
 			__npte = set_pgtable_attr(page);
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte)
+			if (!try_cmpxchg64(pte, &__pte, __npte))
 				iommu_free_page(page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
-- 
2.45.1


