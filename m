Return-Path: <linux-kernel+bounces-557625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070ADA5DBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B61C3B9CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359B23DE80;
	Wed, 12 Mar 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuXGipWS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2AF233158
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779305; cv=none; b=ONVfj/pJiTCAiIiwVt5aiQ1IqONQ5fCOJWVCnpTK3Tfjoc1sePmYCUNvoOozhKpAImBnaDD2y6/62AU1Zxj/WcSVEjFEuaknhap7Rb0xOAzIgiA23UvgFy9LSNjZOWrVWw2ojdjMoOjSl92x49Fl6Tb+nneZUb0Y3qvnvZ+Nrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779305; c=relaxed/simple;
	bh=G0MmR5iRxBh07af046kGj0hf2GwsQOPoKtevieu66rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWldBKabr/3U22DY3kh3Y+vAG+HduvluGSctulTX0n14QwDJoLVaas8N98brjs9v5Y/Mpj1tJE3zvLZT0qI/S9Ro4Vfvp4xO1Fd0lhB7lpWCjTZ1hc5NnnP2u+WDlyq8vGl8bASnhOC64Ve6HAAGlIztR7CZj7Mn47PNh+MYfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuXGipWS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779304; x=1773315304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0MmR5iRxBh07af046kGj0hf2GwsQOPoKtevieu66rQ=;
  b=JuXGipWSBrSMRqTKfPigXac7XulQL3d2LN5r7DzIhc0N92e964TskbFf
   TsYfocWUy/QInWn7eP6yPSaqcbqhBCIiua2OyI9w0dwcBY4bivnjSyLsK
   gTJ/vNrWOM2PlkaYbVc9+T7udGCzSSYbNIJy7vM2v14xiWtWhl7gnxuOg
   umneOOfG9LBp8WMMC+EUKioAvlm4YQqTCBMX3GGSEwRtiH5vL4/oLuOpO
   q00wYpmNjGFiDWbRj7+lfOrzikMK4B4+/HS7dZKDVDmVUrz+K7eXCcIMd
   IDYljeHGxiMDNlvi4KL3tWcIeUxun4Xey73WR3KQ83d3q+uKMt2b8UiOj
   w==;
X-CSE-ConnectionGUID: ioalGvEwTOGzVq7YhLT0Zg==
X-CSE-MsgGUID: JdSq7KvSSFSdN6I5XYK4DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985198"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985198"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:35:04 -0700
X-CSE-ConnectionGUID: tYeeWgW8SNOS5zbhhCNt1Q==
X-CSE-MsgGUID: 7n0YB7gcQmunXVsJtSyjRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124776128"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:59 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	dwmw@amazon.co.uk,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [RFC PATCH 5/5] x86/virt/tdx: Update the kexec section in the TDX documentation
Date: Thu, 13 Mar 2025 00:34:17 +1300
Message-ID: <2e88fd265c88cb42cef505e89c466c5625f4a5b6.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741778537.git.kai.huang@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX host kernel now supports kexec/kdump.  Update the documentation to
reflect that.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 Documentation/arch/x86/tdx.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 719043cd8b46..8874c210e545 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -142,13 +142,6 @@ but depends on the BIOS to behave correctly.
 Note TDX works with CPU logical online/offline, thus the kernel still
 allows to offline logical CPU and online it again.
 
-Kexec()
-~~~~~~~
-
-TDX host support currently lacks the ability to handle kexec.  For
-simplicity only one of them can be enabled in the Kconfig.  This will be
-fixed in the future.
-
 Erratum
 ~~~~~~~
 
@@ -171,6 +164,16 @@ If the platform has such erratum, the kernel prints additional message in
 machine check handler to tell user the machine check may be caused by
 kernel bug on TDX private memory.
 
+Kexec
+~~~~~~~
+
+Kexec/kdump works normally when TDX is enabled in the kernel.  One
+limitation is if the old kernel has ever enabled TDX the new kernel won't
+be able to use TDX anymore.
+
+One exception is kexec/kdump are disabled on the platform with the TDX
+"tdx_pw_mce" erratum.  This will be enhanced in the future.
+
 Interaction vs S3 and deeper states
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.48.1


