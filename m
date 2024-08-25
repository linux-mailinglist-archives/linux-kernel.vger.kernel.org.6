Return-Path: <linux-kernel+bounces-300346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C109B95E2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7F7281DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE474402;
	Sun, 25 Aug 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAff0fs/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205558203
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573900; cv=none; b=brqAtlUWAiy8QE8SJCXdjbIxDcBbW4jotuD/GEA6WxGEHQ+MYy+9vlo2PmodHVuoFYxKafoI1rOMwVRbpWodjNgo8PTg7+iQm7dUT3ty5BV260J4XUm1e4XMdyUWJEWEeuNKGUuZhUXNk+WW3770Hkd6BF9rkUsbAe3EeXr/2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573900; c=relaxed/simple;
	bh=kmi1n5QiSy/LLBcoMn53Y0nqNYOSRw14+cjGatk73uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmCvcN+WUTQjFrLLtoGLgDrbQRGOMiozpMR4HTep+VuBb7XxOdsMx7JN/zp66udF7PhrkHpBBX6zYYBllUFs//xYDIJ+/aYVMEzbmFF4tzhw4TROE5LzxAqCfi6tM4JQ7Dqn1SUhfvkDBB2+HD8ZrnBtTsXLDKIwMz3kzOVn/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAff0fs/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724573899; x=1756109899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmi1n5QiSy/LLBcoMn53Y0nqNYOSRw14+cjGatk73uI=;
  b=DAff0fs/ERC1DoAn9K6sWp1068mwDr4UwY3aGmItPU4vp7KrtzYoVgUT
   b0ZUoovwSVGU0zqSzodG6LGnzKAtjD+Cbs0Ptfk7Y0anAzcsuvGmU2Uzb
   OJ0AWzQQHfq/+3CuDRcPg2i4TXapIRxC/XeslalFR1qMwRgV+cBiJz/1p
   X0mXYV6w0Q7eL4SwrMaVq+C3msykhspW7L2XXbWhVaQmJ+Bhhnih9SfNu
   vRYNgXB6t7BpDddD5yHHXgrZXobBX/4yjH8VV2qeZSwU4SSmxH1PspWRa
   D9diWwJyHhcC1mAtF/v9bY2Btmu9IhnnMRGAD5nc4/SVZXx1WS2Y062a3
   g==;
X-CSE-ConnectionGUID: /nwploDVRk+O4BuSNXJTBg==
X-CSE-MsgGUID: sP5zKx5GSUSIEL12YPI/gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23186608"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="23186608"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:19 -0700
X-CSE-ConnectionGUID: 2LwgFeIdTVOS4rMPrcndhA==
X-CSE-MsgGUID: iN40LHlMRnGRsCXipbXNVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="67014950"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:17 -0700
From: Kai Huang <kai.huang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	peterz@infradead.org
Cc: kirill.shutemov@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Date: Sun, 25 Aug 2024 20:18:05 +1200
Message-ID: <adafdfb1421c88efce04420fc9a996c0e2ca1b34.1724573384.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724573384.git.kai.huang@intel.com>
References: <cover.1724573384.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When relocate_kernel() gets called, %rdi holds 'indirection_page' and
%rsi holds 'page_list'.  And %rdi always holds 'indirection_page' when
swap_pages() is called.

Therefore the comment of the first line code of swap_pages()

	movq    %rdi, %rcx      /* Put the page_list in %rcx */

.. isn't correct because it actually moves the 'indirection_page' to
the %rcx.  Fix it.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 042c9a0334e9..f7a3ca3dee53 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -258,7 +258,7 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
-	movq	%rdi, %rcx	/* Put the page_list in %rcx */
+	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
 	jmp	1f
-- 
2.46.0


