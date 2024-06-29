Return-Path: <linux-kernel+bounces-234934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB091CCF3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127361C211DB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF391E4A0;
	Sat, 29 Jun 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0cOJvXB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B587F487
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666391; cv=none; b=FGAqeGyAsVUNASJs3vDJHWBpvlu2BVIpVDkMbVx4AS3n9i9jV6+6PfG3x7kwzD4+gkVO1HgbtYMvquy8s1D9hF2mE4PPJifVosHXJZEfPGN+HJCdHWkyrRiJiZM0cL+sTfkNqa3XJpgPQe/bgLkFjWfwFwIyes4V7JzA16BsI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666391; c=relaxed/simple;
	bh=bzolQ7McCJ0wHotT5r4eTm/vv72nW1TF4Jc1AZfRGbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgjTLqEGT6YbMfsv1BeKgZgBxOCD7fMWMamqRJjbU6OU96qAkIGvenLooMKAxuBAojySDNf3N2Y45Hx58Amku6Z5Hue8+YaS56xy3sShIK1Vv2b+EXWNa9fLhEO56lQ3CdNFIknYYk5F/yz0MmPNL4YMvwDXnDAGt9NlC0fnltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0cOJvXB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719666389; x=1751202389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bzolQ7McCJ0wHotT5r4eTm/vv72nW1TF4Jc1AZfRGbk=;
  b=E0cOJvXBFPUU/Pi4q234lUY9B/HQb3fbubSf2hdFxhJJMSCzdy+2TaaR
   8usMIyheXYWidX05IfSfDENcEFcHLSzZJmGEvHmj7DvapO2JTQPDrlqEn
   NjxNG9cf1KqQrfVu0HaYYTIrpitHynNE57R3aVrUJjGdS3dAPNPtv/CQh
   AvyeiW7dt6Z7K+hcXckZqmMaL8njDpGFR0qjr3o5UkaSD4ErtTImB36Re
   p0JesuKk2BUtWj3aANQOD1HYI4+lkHfERjHAfY/A6D7q6/P/GEML4JSph
   Uo49D4lOOqH9V7Zi85OqLnf3EOQah1dvotHWSFjFGXH633i/tz0bY/QHV
   A==;
X-CSE-ConnectionGUID: gJuas6UtQO6WcHW4HpHDAw==
X-CSE-MsgGUID: zrBMZYQXShGbGzwETX2BkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="39354806"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="39354806"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 06:06:28 -0700
X-CSE-ConnectionGUID: SkeSC493RTSHS6PaAqz9dQ==
X-CSE-MsgGUID: HLSy8GRmTMW595+fHL1oFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="44919239"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 29 Jun 2024 06:06:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 31A3D1BD; Sat, 29 Jun 2024 16:06:23 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tdx: Fix crash on kexec
Date: Sat, 29 Jun 2024 16:06:20 +0300
Message-ID: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function tdx_enc_status_changed() was modified to handle vmalloc()
mappings. It now utilizes slow_virt_to_phys() to determine the physical
address of the page by walking page tables and looking for the physical
address in the page table entry.

However, this adjustment conflicted with the enabling of kexec. The
function tdx_kexec_finish() clears the page table entry before calling
tdx_enc_status_changed(), causing a BUG_ON() error in
slow_virt_to_phys().

To address this issue, tdx_enc_status_change() should use __pa() to
obtain physical addresses whenever possible. The virt_addr_valid() check
will handle such cases, while any other scenarios, including vmalloc()
mappings, will resort to slow_virt_to_phys().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: e1b8ac3aae58 ("x86/tdx: Support vmalloc() for tdx_enc_status_changed()")
---
 arch/x86/coco/tdx/tdx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ef8ec2425998..8f471260924f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -813,8 +813,16 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		step = PAGE_SIZE;
 
 	for (addr = start; addr < end; addr += step) {
-		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
-		phys_addr_t end_pa   = start_pa + step;
+		phys_addr_t start_pa;
+		phys_addr_t end_pa;
+
+		/* The check fails on vmalloc() mappings */
+		if (virt_addr_valid(addr))
+			start_pa = __pa(addr);
+		else
+			start_pa = slow_virt_to_phys((void *)addr);
+
+		end_pa = start_pa + step;
 
 		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
 			return false;
-- 
2.43.0


