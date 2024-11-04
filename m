Return-Path: <linux-kernel+bounces-394570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D89BB144
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561021F22371
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D881B0F39;
	Mon,  4 Nov 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzosgpjQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F21B0F18
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716709; cv=none; b=dfd+f5lL7rowZZCZK1ffjiSvPt/yeEHZG2+iG83AcyH9D7EFSy4k6wHCnV9YOiLvlNPBp6C0BDZC0k2+yDinEzqMOeeGRk4f2L3zqPGCSkNuRRY3h0u8AvC0k5n1mbMWy16iH2HiMYFgzMOTDG51dIBC06CmHni3bsL62clg0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716709; c=relaxed/simple;
	bh=KwHuuFuBR+6v095DyVRU1O5DF+plZXTvenl4o3ussMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cllAnT+uKd92t75JXjt1qtc4c3i3Cqe8oOIqrgrzxyeoqzJAa7c++yPJ8FfnPtvL7z1c6fSP/HocTcEIJRvMcWzomXCIAVDj3eyA9rFolj+OJywZrdhxTOIGGAlElHu2+fnINGfDSu0w9MWW+q+7oqFIFJtW7Aj7NDDFJYTmk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzosgpjQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730716709; x=1762252709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KwHuuFuBR+6v095DyVRU1O5DF+plZXTvenl4o3ussMs=;
  b=UzosgpjQ4Q3riT/mZ846kpKVS1X/cv6JQzdBNKqTiwVpQpGcwS2y1Mc5
   XG7/fP5EmbBWsEiKmbMw7uKvwAFzvFDQpUj8nwVYhQsvc7WFE3aqoIr3W
   JXYsNKatyPnw73H7j8XtYjhkrViajqZKQAFASqPs76kpgp/HZJj/wPXtd
   ea30MeY212f/Vtldn5hv3H+l8Btq8+QYKFX8qzOaTrzfcdoywVuITZ2OR
   nMMz8JIIa7tSdKyxP96cJWb6Rl5wPZrY+COBXmncPWhLO70Ypm9HtIAKR
   4E30DMzdsWFBJcikoN6BrhXjyjjMN/5MyfI84l518t171nG75ilFyvFfG
   g==;
X-CSE-ConnectionGUID: tmnS8NMyQxWoBY1VG0tk1g==
X-CSE-MsgGUID: KMIRYSJtQtSYmehYZqwONQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30509345"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30509345"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 02:38:27 -0800
X-CSE-ConnectionGUID: PcoBlpTsRs6v94NpVyEeWg==
X-CSE-MsgGUID: m2v5tllvSAGLJ2hv0+ZfFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84432995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 04 Nov 2024 02:38:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8B6E31C4; Mon, 04 Nov 2024 12:38:23 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6, RESEND 0/4] x86/tdx: Adjust TD settings on boot
Date: Mon,  4 Nov 2024 12:37:59 +0200
Message-ID: <20241104103803.195705-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adjusts a few TD settings on boot for the optimal functioning
of the system:

  - Disable EPT violation #VE on private memory if TD can control it

    The newer TDX module allows the guest to control whether it wants to
    see #VE on EPT violation on private memory. The Linux kernel does not
    want such #VEs and needs to disable them.

  - Enable virtualization of topology-related CPUID leafs X2APIC_APICID MSR;

    The ENUM_TOPOLOGY feature allows the VMM to provide topology
    information to the guest. Enabling the feature eliminates
    topology-related #VEs: the TDX module virtualizes accesses to the
    CPUID leafs and the MSR.

    It allows TDX guest to run with non-trivial topology configuration.

v5:
 - Rebased to current tip tree;
v4:
 - Drop unnecessary enumeration;
 - Drop TDG.SYS.RD wrapper;
 - CC stable@ for SEPT disable patch;
 - Update commit messages;
v3:
  - Update commit messages;
  - Rework patches 3/4 and 4/4;
v2:
  - Rebased;
  - Allow write to TDCS_TD_CTLS to fail;
  - Adjust commit messages;
Kirill A. Shutemov (4):
  x86/tdx: Introduce wrappers to read and write TD metadata
  x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
  x86/tdx: Dynamically disable SEPT violations from causing #VEs
  x86/tdx: Enable CPU topology enumeration

 arch/x86/coco/tdx/tdx.c           | 140 +++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  13 ++-
 2 files changed, 130 insertions(+), 23 deletions(-)

-- 
2.45.2


