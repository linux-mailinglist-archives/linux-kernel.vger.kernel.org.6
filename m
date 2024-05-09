Return-Path: <linux-kernel+bounces-174238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84DC8C0BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E8F2846B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1251149DF8;
	Thu,  9 May 2024 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g1fDjsbs"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC4148318
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240046; cv=none; b=qNtO2QrM+681Ca08nupV8pE01MkHO5DjovstCyQi7ZJ7i3kppLFTLzFromrj+Bn/hFl1yGznvvISrcBqTyNv99qAMwAjFH/M2PIfj29Zc0niyhMgefwtbCq6HVkA+KwCIaglRfXIVMsMm1XTNND86+q0mzVSGj+Q5Z6eQ2ufS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240046; c=relaxed/simple;
	bh=vniUVQGgbZH5XUSS0fWMGrRPi3jnpi6vMBuF5oFpj5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDoK7KaNAoqTc5kAQa2JOaUdBugRPuktfx/CGTGwRmIID2DfcmzTuFzdlhsXbyTwgKiiVzwnHhckgoHXy7CzIom6hxT4Lt0KYaYdKPQl+HNd/DzY8XrC6UrOUL3MB1fY2ycWiELtcZ8rURSzdO3OqD4rLN8yXxH4A2WyJFH5tFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g1fDjsbs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eca195a7c8so4341025ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715240044; x=1715844844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKyIwcUjX1px2GE9S/CV6LaiV7WK04/0FO5MZQuO7/8=;
        b=g1fDjsbst7ad8k8lQWtbN7JGT80QYWnBoTfhclJ8H/Mi3u4Hca3tE9xmdpugMlgUaK
         e88QRRy5Elyzjv7ktZu4+4/azY7viYIBagOskDNKPBBCFyOggo1zLiijIUQ3bY3K7jTe
         Y1PsLoRwVkgr0XDUzNFuvCVOWoHFE6vyXY8oY+naoBIGP1Wb8f4Kdkwwo9yuytR+VpF0
         f5Iv6qHkvzUbjQIqWzia9nQbdDICcbBLYM7Q5jYBaGa8sgtYotwp6ewayy8JDvlhxTmp
         QISBtSfo56bykLMiKLnOfyAXjYrP2VUNKZHM0D2VMaJcazzb6BBmFR8M+uOhrqQqEddN
         ozAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240044; x=1715844844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKyIwcUjX1px2GE9S/CV6LaiV7WK04/0FO5MZQuO7/8=;
        b=e++3Me4mHuTY8TMWw8nOxARochvcON8kud7UwfFOI9RWuVYl3tWzFeY0JyqFMjyGWR
         3ya/iDh3e3iM0Vl0PxY4JwpD8I7nhB6dwzLtwi01L4e/0U6lZfdNlm9+HpvWi4lB1AkD
         fUo20lAE0ckhb4vCZ2fFt6UthWWT8hZu9lQR3wY4V81Q+5QNgpNtsv9N/YhfoLlxmaSb
         MrQ9Mi/bXu46MbJ6ltwfxrgTk2Rb2CgPBH+wmWWih6BLC6lAVCpscvrES8hUfxuMynMg
         PMlGmAEhgAWNwLvaVlaGFR1mp/4ynxC/m/1Xp0JKLhDyR8YmWc4lZKGzvn/wGhLOjy1D
         LTfw==
X-Forwarded-Encrypted: i=1; AJvYcCVnwbkDJVwl+qndUAgS4Ph2Z2btRCak73EZ3wBA+UrfK9hDd9koW65hv+8FcgJ0dIdxgSRxGnUCfTCKeqcWxSJ20flODzeBMkAw83Wa
X-Gm-Message-State: AOJu0YyNnVO7aCHaCHs9H21azgFyvNgF77fHU1s28ihfV1xgPY+itnEC
	E7QiNHHsW3gq82SWpxSAUKM3Ldw9LYgMX+kqLNuKaXnQ730K38TYMcwsSHd/uqM=
X-Google-Smtp-Source: AGHT+IENrFpPXQtPzNwMxYR+E7KfhtE+rzld4e5iGLrKkEoGDyF4zweRjT/2jAKH/f68/NFj3s2ryQ==
X-Received: by 2002:a17:902:d183:b0:1eb:144f:63b7 with SMTP id d9443c01a7336-1eeb078e5bbmr34244655ad.56.1715240044153;
        Thu, 09 May 2024 00:34:04 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcbacsm7519045ad.97.2024.05.09.00.33.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 May 2024 00:34:03 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	sunilvl@ventanamicro.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jhugo@codeaurora.org,
	jeremy.linton@arm.com,
	john.garry@huawei.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v5 3/3] RISC-V: Select ACPI PPTT drivers
Date: Thu,  9 May 2024 15:33:00 +0800
Message-Id: <20240509073300.4968-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240509073300.4968-1-cuiyunhui@bytedance.com>
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f961449ca077..a9ebecd72052 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


