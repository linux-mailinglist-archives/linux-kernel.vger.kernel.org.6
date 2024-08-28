Return-Path: <linux-kernel+bounces-304681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DF962387
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EFD28314F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17297158DDC;
	Wed, 28 Aug 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8rcGRyc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A566158214
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837717; cv=none; b=h2ASuDTt6mYbJ9PkCVf79he/GVG7yU/oyad2E5Xb7SBvkFmwAzch4xCXNVQCZQ2Pb9qkgeOYwwmlg8y7NH4i4OxfjvoJAmiUrvX9AfOfOerJ8iH//W73f3zwmiIRAvjGYPvEmjtdFHl/1kAuuVqYNcL7KNr7ucw3Uh2sCg6xuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837717; c=relaxed/simple;
	bh=t8JNuYfwtOeTK9Dg36GtLBeI0Y10Y8AjR6Ydwcr+7SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qV48ExZl2GR1C/bpnHaanizCD9+3XeYawnQH7SJoKxtdGVnN+/i2GGWnTxxiB5aKd2YiOoWvr2Pa6Z+9XcWC1iXshsWq6SO7aoz54KBAA8h7d6LE0eVlGBqUqhLXEI85z8g8bTCUknzJBMb1MN3SOtdor9CE94xMR1yiFkfxjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8rcGRyc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837715; x=1756373715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8JNuYfwtOeTK9Dg36GtLBeI0Y10Y8AjR6Ydwcr+7SY=;
  b=N8rcGRyc1KppR9P1CYIUoGPrqab+ToelQZwFc+YnbrfX7j3XkPki1H4i
   5DUstVsJOQ7GgRxj58PYggiG2aA32E1ZZ5CzCHPEDM0+aHkTk3SslFgCS
   79d2psqk+CLPekCBTPklIpVnK3x3swJ2fP/9NHFMnRk5mmBBkBxpGyhZg
   qaomWqcgYKLDSQBaNmOk5NgoVjkmWUAylhlXXmC8LTcv+9kOl0jxPDdB2
   LDY6FG6m3Rce4tYd6hRLVbYxSaPByicp9uRZGcNr60e2JaAdmB60h46kN
   0FsEveQ9pHPwXKamE23eY0/YOKVP8MvWqB5JCC/RJgNVUPvVAq6UtTy/V
   g==;
X-CSE-ConnectionGUID: gP4KZ8VmQlOzVZjfGnTyeQ==
X-CSE-MsgGUID: jMDZAOAoRumBQOqV5xSFKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27123849"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27123849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:14 -0700
X-CSE-ConnectionGUID: l7hfddM3RLe/MAIoF30TWA==
X-CSE-MsgGUID: nX/iouNOQsetzRo4GI2VZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="93879076"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Aug 2024 02:35:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 64761142; Wed, 28 Aug 2024 12:35:10 +0300 (EEST)
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
Subject: [PATCHv6 0/4] x86/tdx: Adjust TD settings on boot
Date: Wed, 28 Aug 2024 12:35:01 +0300
Message-ID: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
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

v6:
 - Updated commit messages and comments;
 - Acks from Kai;
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


