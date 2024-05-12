Return-Path: <linux-kernel+bounces-176874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E28C366A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4671F212CE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BD224F6;
	Sun, 12 May 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQCZH/lt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BCC142
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516523; cv=none; b=mfvMpdKr/0Ug3RVS0eOolGCNh6wdq3juDB/8j6E8A87oOpqOlIWtyA7VqwV/iL0aEyCyFrXbq/b02S97RE3AzmxeEpcOMujzH6hMwFA41VFRPLI3orsaaay+yI93Frdfh3vfpor/MuD6QUPo9vc5Y+DD9X0ews9zIXCkjPpTUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516523; c=relaxed/simple;
	bh=ZAOvzer8llyTrOIiIsdviMMcEDO6WCpQxbwChqobt5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0lclqLZKRBa+bW1iW2rn6V0HIuYPNbc8yN+NEEYVBpDEo4TOildYkzPG5EYkDnZ14h1bdzSCzZ8rovS8FuMh93SzLgWABIj00FFhnq1bQUg/LUqvVLDvOIQneOGVgfQ5cugLkBTKHk0OOnZ0WLNZ5fM/MMHtA/a1gqR8CPg5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQCZH/lt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516522; x=1747052522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZAOvzer8llyTrOIiIsdviMMcEDO6WCpQxbwChqobt5Y=;
  b=bQCZH/ltCPsIgzCYTUEhr0fzfBdIIHGXCOfh3VwXWWiEc2gCz9RiQzwb
   EHm+MNfP8thf2q7VMVIgatFRLChmMRMfYOGMMar9ZTmCAESn8LU3vO2Yz
   ZhFEfcwC+Y/+m6VLDdfNiUXdYVlevOpuLNGn8L6ALd6pZQvQ9ENAV4n+2
   0+Gue6ohL/b/3B5dqQTZLh8wIz75G4GKReyIXmjhqlUXEZ/LCKY2AUpEK
   RiTe1u3QnMYS7sC3D8ZD5IGKnX1UcGRMhDTJQSIB549B9z1OdtJd5OQsw
   pziEyfkA6FaEVB2TmAgBUkaiHX8qn3KQRQFOjxtkDbUVWUH4izv7jXS+R
   g==;
X-CSE-ConnectionGUID: OcvHXhJkQeKbkgoELu9cig==
X-CSE-MsgGUID: HBVE4/JcRYygb2ObCk49FA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11594193"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11594193"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:22:01 -0700
X-CSE-ConnectionGUID: 9fXbSZ4KShmTdo502S0eig==
X-CSE-MsgGUID: 9A7JvPKEThecxLCiJe4jjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="61258778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2024 05:21:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 03D9424D; Sun, 12 May 2024 15:21:57 +0300 (EEST)
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
Subject: [PATCHv4 0/4] x86/tdx: Adjust TD settings on boot
Date: Sun, 12 May 2024 15:21:50 +0300
Message-ID: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
  x86/tdx: Factor out TD metadata write TDCALL
  x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
  x86/tdx: Dynamically disable SEPT violations from causing #VEs
  x86/tdx: Enable CPU topology enumeration

 arch/x86/coco/tdx/tdx.c           | 140 +++++++++++++++++++++++++-----
 arch/x86/include/asm/shared/tdx.h |  13 ++-
 2 files changed, 130 insertions(+), 23 deletions(-)

-- 
2.43.0


