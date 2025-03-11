Return-Path: <linux-kernel+bounces-556111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34DA5C113
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDCA3A37E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111D25B662;
	Tue, 11 Mar 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fNMIKFgC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40274259C98
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695921; cv=none; b=Gao/fP0bXvaugb0uRxUnOcja5m6RLk3ybM5b56oNF00fmIB+N4r/0fzYZ6TGIGL6P+RamjoHCYHwVoVfAWs+hh1NRqUxfH88OgkyymIbhumIEOaLZGySBuhO+nGoDJncrsgryctSR72R7iEeRLIXZpp4WeK1y/ZzZWu+f6qVr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695921; c=relaxed/simple;
	bh=BWCDKEOx5rpXfv2Ehoc4ZbjOk+5fknqmSHI9WUgHxBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KP8lmLFpfy3s4kUfJq0RqeMOKFyhIvmeS3imceomiy9RPlXCp8clpj0XgFM+g14JAnw7lW7+5w7Bsx9uVOZOmmgmEo11oEweosLiQ8lCCpqTmacuGK6Sjuga4XDr7lSFOi1zFSrfXdaAxETLhMiqGgS5DxjNqLBSWN+PeMpX+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fNMIKFgC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso101986415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741695918; x=1742300718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+cFskIjc2R+b1eOxd5DFriJfYFabuqe5pHc955ET08=;
        b=fNMIKFgCS0nD+Ma3C9GSZNyoLbYDajt06hA+e1xANo6RjahNp/xAOaTmZtSTWvQ0To
         iF6YmGI2rmkeSGFcIFUNEwtMshuwp3zYBGsBXBTupHzBXUIBxxz0kzU9fVFH1rLDW9i/
         JRLvEOX1+eANpUnfgNjeXvpIDAlV8jgxctbYExW+qqrqgbu+M8KGpBFvGWci48KChSky
         KrFhJWtkQNS5tLkAVx2TCWJ0ww3nz0rLxO08P0ojhC1jDD5vsru6hYYxUugsTXw6Nhyp
         io9OPxNJxmszRF7OCJwguJnMb0fC/2X6IcMSza4Y/5zR4pKivgoujDLaEqP9WniJhzSd
         OQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695918; x=1742300718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+cFskIjc2R+b1eOxd5DFriJfYFabuqe5pHc955ET08=;
        b=trUpVzEPw5v7MPcPB41cX8fKOec0VcAeeNAQqGENsENhbe+mL1KBshMtsG68SPCZ6v
         iGPobuuy823x4mLMM7v9iG3ors8ImbHjqXaOdlPzhndJk3wWyPWE/6gmgvbOi57ppFnG
         81NwOOnHJudAb5oXrIfmUH1TeRLpEgCGpDU3l8uQ/0xk3JXp2A/B3lSWjTOlA/5p1bQM
         Tz73Lcll3/E1MBl+gZV+LjTdLRLYdY2qOsexFdoT9qwM7AjE6zedOv9/p29q/MvtNMEC
         hF/fErk/jfnn4lHkaSPjYK0qI48lM+CskhzfargiHB1zo7PbvM3al3v8GKessVzHsnzC
         CCAw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3DexOUSTtPqwgPqaRYp5tic5QuUdGB/5KLLcPZj4HJErdAMSDsdS9yzz5xZtdpbn6g2bm43wf3OHqyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6rknjqXOAvvBeoaRwHIFn0pWhiZfQfIrHL0VRBq9/umPzJQD
	NZAj05MZjkZuQ0cPR4TvCWuhKCQ/7T/oKzrsHPKz1bqmnxKtrz8wz9Lykd/qaJ4=
X-Gm-Gg: ASbGncsN/sJywMtv9Z0wptqCQBNASltw2c3neqdWIm0/bR7yjOJO2aXQ9vjSkak+fz4
	t2q0mvi2YG8clJo/AAFH1iJ75XJbm1S7t245JABa6uemwcSsuMTxJpxcG2Gmr8raFnubN9WDjNH
	jElswJXWAtVT8u8saRrzbfpzLXAGjmcCxceXpAWiRCZVhI8K/dMb4/AjXG/lBCiHpdQzyULbJ5S
	lN5c6ifg9aXfPpUT2Fs1aItLa/UrrOY3om2AbpcT2OS4QanY3FMSeY6RFvmJpqYU6rE8b8pHhEw
	C3oqQ220omNubUQGbaZpe3fCkpitSCJ3tptNL/cG3yelh+hl9UdW+tkujaQXanmLiv4zdyjVSsd
	iXMdLzq1XQe1vZ9VXkdkl+u19qVM=
X-Google-Smtp-Source: AGHT+IHG1hIfRPGfeBWtZBg6vmzBDsRxutGZo9a7a1tFhmE6ZGkKIhVjEQFMDqp9Q4XTijdI+P3nug==
X-Received: by 2002:a17:903:32c5:b0:224:249f:9734 with SMTP id d9443c01a7336-2242887ecd7mr261999215ad.4.1741695918352;
        Tue, 11 Mar 2025 05:25:18 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm10226621b3a.80.2025.03.11.05.25.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 05:25:18 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	kirill.shutemov@linux.intel.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 0/4] riscv: iommu: Support Svnapot
Date: Tue, 11 Mar 2025 20:25:06 +0800
Message-Id: <20250311122510.72934-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the RISC-V IOMMU hardware spec, the IOMMU implementation
has the same translation process as MMU and supports Svnapot standard
extension as well. These patches add support for Svnapot in the IOMMU
driver to make 64K also an available page size during DMA mapping.

Changes in V2:
1. Supply more details about huge pte issue in follow_page_pte().
2. Fix some style problems.

Xu Lu (4):
  mm/gup: Add huge pte handling logic in follow_page_pte()
  iommu/riscv: Use pte_t to represent page table entry
  iommu/riscv: Introduce IOMMU page table lock
  iommu/riscv: Add support for Svnapot

 arch/riscv/include/asm/pgtable.h |   6 +
 drivers/iommu/riscv/iommu.c      | 258 +++++++++++++++++++++++++------
 include/linux/pgtable.h          |   8 +
 mm/gup.c                         |  17 +-
 4 files changed, 233 insertions(+), 56 deletions(-)

-- 
2.20.1


