Return-Path: <linux-kernel+bounces-235633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3F91D7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE12843FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEA4C634;
	Mon,  1 Jul 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQHOPOIJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FD3D0C5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813351; cv=none; b=WU2oWXnoWoW8QksTeKM88l7q1Fqja/d1mDq+Jvj1L6D1FbJ+PZqPNrF0DFlbied3zCFW9jUBfr+KHLSuMn/a3p648xudcc8UsIIksAGTp0/PTT/91GX+sl9HLlfyhr7lUiP6bQeTABYILqQPZOvBnfus1xkCFKWHpIV5hm2E6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813351; c=relaxed/simple;
	bh=LVvLyM+Kj0crmae/MY+D07rNXaY1DCzEv352SipijCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv6MWMBDfWDnY+nvv4cmGZy9XCR954HZQtiSY4QfotmDrye4bjETU6s2TNdUpCiz5dXNj8mcSCe25CiXxFuySXV1M92jDRb2k/4qn3ejh2Y2gGBJCg4J81IE4aLSHz8KN2WHKX7fb6k1nkbbLPqMEdVdgzH3VCtmiK8JRbwhXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TQHOPOIJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=87r5x8yvk4pmIPSxtncBSZOCnuL3Cqow52VGH9eEERU=; b=TQHOPOIJml216NO08LA4HZjNY/
	cGpNrb+IV9KU46ITWBunBRb2MkDd46FeiPBcMrCVPulLolIsgykI7n7q1lT1oNs2lJCGfIgi7DRHZ
	lqdHYCprXdUyJcBWJldAq1rIC2L/NzrtJ5Z1EpEbog//6CojriHpI9n1M4lRUuFYSdOUHgiiR3MIe
	4NkDFE+8kaoSek342jH0bJ/TNekvMT2+i7Mm9ZYvQxUO2glXcZSfzhq5oX4Y8j6uSc4QMwSS4e4LK
	bBR1/uRhd1xcy5IeanIJvqKF38zJcNULu25zhMeofw5apQ6w54A7Dv120RHHqk169FLwj3jv+rIyJ
	WYD09Mlg==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOA0z-00000001ncT-2Oxg;
	Mon, 01 Jul 2024 05:55:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm: remove ioremap_page
Date: Mon,  1 Jul 2024 07:55:38 +0200
Message-ID: <20240701055542.1315167-2-hch@lst.de>
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

ioremap_page isn't used anywhere, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/mach/map.h | 5 -----
 arch/arm/mm/ioremap.c           | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2b8970d8e5a2ff..03f456cb53644f 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -52,11 +52,6 @@ static inline void debug_ll_io_init(void) {}
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
-/*
- * external interface to remap single page with appropriate type
- */
-extern int ioremap_page(unsigned long virt, unsigned long phys,
-			const struct mem_type *mtype);
 #else
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4c8..6debe27b3a72fb 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -107,14 +107,6 @@ void __init add_static_vm_early(struct static_vm *svm)
 	list_add_tail(&svm->list, &curr_svm->list);
 }
 
-int ioremap_page(unsigned long virt, unsigned long phys,
-		 const struct mem_type *mtype)
-{
-	return vmap_page_range(virt, virt + PAGE_SIZE, phys,
-			       __pgprot(mtype->prot_pte));
-}
-EXPORT_SYMBOL(ioremap_page);
-
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
 	int seq;
-- 
2.43.0


