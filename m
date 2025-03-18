Return-Path: <linux-kernel+bounces-565424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0745A667DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C253AC733
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF21A5BB5;
	Tue, 18 Mar 2025 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lVjQ33x/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FA18871F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270383; cv=none; b=QRUz2vA9sM7nySCFNZaWzpzV+iBdL/HsDWe2GYmsINaha8qp3x8z4Uh55bHTU4w15tn0RKHW5lZvku4cfCsjuebTba690kgRRcMWmV2ImAGgX07ZbBu0NA9FFzC3MVYwWJO4MsM8yGmFbHkcwJwnHozXnHC71bDy3MRMa2/qUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270383; c=relaxed/simple;
	bh=BWCDKEOx5rpXfv2Ehoc4ZbjOk+5fknqmSHI9WUgHxBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qs1DAe0Od4iQ6PKdBtOkesfPAH98o9mzQwhISKceCZhf4955XedbsOu2Jj8YoPNsrKa/eQ8upAUz6CH98MHP0Ua8CnfHQ9n8SXZaiGqIuPLgCMHDfKwvJiMUOwi0ds6EKjkP1G8RnMYjTunipWn/rfQungA9yrsxmdqWNrvQEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lVjQ33x/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso55378125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270380; x=1742875180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+cFskIjc2R+b1eOxd5DFriJfYFabuqe5pHc955ET08=;
        b=lVjQ33x/lLfoUx1MikHXxu9Cn1lOcAcbgtuShDxxxXojdBzHNUPn4kI4V/czMbFrj6
         7n0C7cZUCLNLYq658/gMMmLKnBVrBUbs+OFkdBIt0o/qwBsHISL0yBzfFHrqoMlfmyBj
         7U/pPOF9EQh2u6V4dSYw6rAJdlY2I8sGMQRmKqppMXtawy/Ux6nwKsQAttCKYimpPaAy
         jRYIk5htE+rhtzz+FXfF4V+KBani0BvQ9dp0S7ZUo5T4SfAOlUQoohoH08X5AylG68jw
         4jj1WM7RLWp7eLcFiT3q8SsuhJorlaNNBIP86bRLLMnBuhj2Kib/csQ69M6dZYJxywpg
         uoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270380; x=1742875180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+cFskIjc2R+b1eOxd5DFriJfYFabuqe5pHc955ET08=;
        b=k95sf6tcZljUBOhE/5bxXyQhafFNuTsYQXPkr3CUJwE3/2JCIuJPk54RcGoIj50ENR
         33D+y3yRUCEWIr54evAvsEpaGVoTTkXIyJADefkYMUSCARk7/i78f9YSyZU6HGGpgHLq
         gr4Uksg+LSssBLz4nmLRh9iomdx0nvPvnZUE288XJGnr1NHK7P5lPVvxNl5KjcRV69bV
         LoIhy6Mz2rb1ONVOXkDCdXrsUCkjYkvKSpeV+ZZmUeZwZYdT5RqceocxG/1c7tbmiyOH
         HKapztgsFsbocgPFInBd86JPzeOhWBf5zS/VgGVKkqjTOQ4e6lFfhmCNesKZUI+vgU6x
         89kw==
X-Forwarded-Encrypted: i=1; AJvYcCVWOijJZsJvUR62zzAgOe7MC2vJq2W8TybTZI78OJX2U0iXsvoxCPG5mvRb5n/azQVzT4qcrj+dc86RyAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/LXPSPIuJMvee2uH3ZsguuKCS2Sf81tR/qXAhSOnk+CHZq/K
	UXAQB/ga5HdSKms0/s2c+np+FIH24wakvohoOEIIbxoJc2WJQzTwEvjPHZeZI/o=
X-Gm-Gg: ASbGncucfl97sEaf1+LlsYWlKzqENd2cxfe8FoNdrtpEJjOEqTce1uvkyb1TsRrHNZm
	zrP6loWwZh6uLo3rS2StzhVb+7Q0dSOJ3rA8Oz4KHwYtz1OZv3ndzJ8tNQsyXC1KU62jB65dhj2
	pyrfBzPkeZABSRQWJqHTVgOg7F1VWqX6U9Xa4Ec86EVthz3Mhay+efKVjtT66druXC506DznPwG
	SZ2HyqXgoxjhaDRlLEEHvrzHYVh1zXbVHLjfw5jDWh8R9rPPu8CZxZv8mY6UB7v7Q1GEY/aCkiE
	NKWYMDNJ1BhP940TtM9VbQE+r2SE2kwlKjczLzymMR78E0TUm7V45746HlZ+KE9gGbX5Y+7ZzaL
	BEqY4btcDbjxqvZXifczRgkg2Log=
X-Google-Smtp-Source: AGHT+IEk0ixM7+/HF7HnljxT7v/b8tGkEF42+OaIkk6MZsjKmh92Ti0vM9eEJawaci+e/TCODhf3qw==
X-Received: by 2002:a17:902:ecc3:b0:224:283f:a9ef with SMTP id d9443c01a7336-225e0a62bc8mr145428385ad.6.1742270380177;
        Mon, 17 Mar 2025 20:59:40 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4b30sm83720135ad.235.2025.03.17.20.59.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 20:59:38 -0700 (PDT)
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
	linux-mm@kvack.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND v2 0/4] riscv: iommu: Support Svnapot
Date: Tue, 18 Mar 2025 11:59:26 +0800
Message-Id: <20250318035930.11855-1-luxu.kernel@bytedance.com>
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


