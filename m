Return-Path: <linux-kernel+bounces-260630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482893AC07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E273A284229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01803EA98;
	Wed, 24 Jul 2024 04:47:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688917C6A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796442; cv=none; b=dkgtGJfERDmduzfocwC4TXivGscOOKbCoozAg/t9+JPnenK6Go3J8ez9kBi1bpzeomrMPl2GFJ0C8ZkLkHOMA3BtpGmr/lFzlKanoZe2ehJ/0G7FWqkFwL6Id80bPd7kdeeWca/z9VoXQSIRi6gioG4IoGX1rqwTaKH3Pz5dr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796442; c=relaxed/simple;
	bh=pn4wVj/IhJTlLRReC+QeumFT75E9CgOJvirz3l/dKwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d+6ZrpQberXCBwUQaS8sK8sAXYRAfpcd9M50uPLYkLWapTKKs1lhNChk4D6al/hzeDXWIjkNBTA7Gt45t4TkpCIEm5OgrC5EjgMWYNWXOnnpn/NfsdexB3fr08mijV8grbS2Qwyu5ORTFYs2qrcWG7zDbSvCM3EVD018rwMXauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F75106F;
	Tue, 23 Jul 2024 21:47:44 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F4433F5A1;
	Tue, 23 Jul 2024 21:47:16 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop PMD_SECT_VALID
Date: Wed, 24 Jul 2024 10:17:12 +0530
Message-Id: <20240724044712.602210-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just drops off the macro PMD_SECT_VALID which remains unused. Because
macro PMD_TYPE_SECT with same value (_AT(pmdval_t, 1) << 0), gets used for
creating or updating given block mappings.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1f60aa1bc750..86e803ea8885 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -135,7 +135,6 @@
 /*
  * Section
  */
-#define PMD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
 #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
 #define PMD_SECT_RDONLY		(_AT(pmdval_t, 1) << 7)		/* AP[2] */
 #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
-- 
2.30.2


