Return-Path: <linux-kernel+bounces-235635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AD91D7BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CC1C22654
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54B6F076;
	Mon,  1 Jul 2024 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4qSn5dZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D26537F8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813354; cv=none; b=ag+Nc/bAnAiHEF2+ASnhOLxN2hZpRqa6KUnuNzAnfes/NBKl7ZO/UdjaolZoSe1VZ4P/xF5QkrjP+fUSIfuzf82FwIv/HB8zUYsktMyBHVfqBcmRfT+VdgAirFHyCWjJAdbtapRArdCpzrl22a0zqNZve9GUwrx0veU4HDrNLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813354; c=relaxed/simple;
	bh=gUiE8KRxzj9b8VvuqgfVhJkXfmAxbHkfKbwEGaWbzOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck6ZuqL2GVL5/wnScJdqoCuEefkxfecqI0SdqyHLO+X+D8oAGvEgMUWIitDlJPcAqk1PuTd6XwvhjTUQTIXl6oq5hZ5MYXlszuBPiTuQ8ysdWn+cWR4fVV14ZCQZYKvYDYe7R3i3SNZAUH32oL/Niql36KBLq3YTMBk2yrEJjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4qSn5dZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LnUMD5VlNWuEiRILZkTBM1jY1yfOCSMcWfOfroRWSW8=; b=i4qSn5dZbELfn6ZJ74YALwHwQS
	iMJnHFsFUSyW2cGgpqlpvAzC54EO2HTGwqk1K/4/UgoLJNskLiZhGkhv4G3j/cA93JGonIVXdXTOK
	T5NwVBqA/3idaBFGguPFsq8pXTA5+X/dYk4zP9xzSPIQp5sFoASbouwSsNxpUmis/vc9e1cZPw9kc
	iyozMBi52wd1zkTgkm0PNlUCJ/M1wKJBqrUcTCjWHMH9lQfjodlZF2KE4zC08lgS+N09n96uL/Vbh
	8lPyuyNGvMRvlp6QcS01VfUoN6hPRhvPWLFmPnFDhx/a8KvwruGdcIRtMRPMFu+34+CKvXICdFi5K
	p0JHyrgA==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOA12-00000001ndE-0cOK;
	Mon, 01 Jul 2024 05:55:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm: unexport get_mem_type
Date: Mon,  1 Jul 2024 07:55:39 +0200
Message-ID: <20240701055542.1315167-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701055542.1315167-1-hch@lst.de>
References: <20240701055542.1315167-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

get_mem_type is only used pci_remap_iospace and ioremap, no need to
export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/mach/map.h | 2 --
 arch/arm/mm/mmu.c               | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 03f456cb53644f..30de16b65297e2 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -50,8 +50,6 @@ extern void debug_ll_io_init(void);
 static inline void debug_ll_io_init(void) {}
 #endif
 
-struct mem_type;
-extern const struct mem_type *get_mem_type(unsigned int type);
 #else
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 3f774856ca6763..fb4835e1046f73 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -350,7 +350,6 @@ const struct mem_type *get_mem_type(unsigned int type)
 {
 	return type < ARRAY_SIZE(mem_types) ? &mem_types[type] : NULL;
 }
-EXPORT_SYMBOL(get_mem_type);
 
 static pte_t *(*pte_offset_fixmap)(pmd_t *dir, unsigned long addr);
 
-- 
2.43.0


