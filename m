Return-Path: <linux-kernel+bounces-169781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B28BCD93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D821C227CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01277143C4F;
	Mon,  6 May 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaEMlaAh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EE6EB51
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997761; cv=none; b=dBKHqyEzIYyQDwhdVhG6YZNKTtpsv03rMRc/HwO7dOds1dibhY75zxRtjbaLQsmc1ABNpNdtEj7PJqk5l619+nupTW60rEMegDDMWGI8n8XVYYbfHEUWooQXsCF8v+lpRB62/NqnUldxtwScKgf+Jhw6Ad6acmflSJQ8bs5fRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997761; c=relaxed/simple;
	bh=gPCtKS/qlmSozPKm0sB0wF9GZEtKev//fnbnOTTG+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jD0qebp1OgiiMd9j6IMcZGlW31rsjLpVQq/2KbC4DybmEWhPO0miFkM2wS7f6aHwV40Lw1sGEpPqBbaFKsJFWJ5u3GAnM+t89kO9zS1575bn6HCiEL7Bcg3WA8D73hshcnN8zRDUXL6h4KP3Io729Ac+dPCEoVWytedlQKJpnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaEMlaAh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714997758; x=1746533758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gPCtKS/qlmSozPKm0sB0wF9GZEtKev//fnbnOTTG+/Q=;
  b=FaEMlaAhrIUnJie70wp2pvdzSX8RrB6jnbifHxtCfsvzDBBg0U9saOY5
   ROGDqlaR3IgxJ5iyEzHcg7D7E2ZCsfyAFm4YpSyfztXpCDLgfgpHc1wDU
   +BGN0rzB0koorK4Orm3krsHu3yO1kf+5eyPDuML4s2EiBAuaOBzzZWSAT
   I3orzFCTXapBkuKkTSnjbVjHkyyZI5yeFtBSDIhJX4PENPiiBR3Iq+E+l
   7MXCF0u2x1QtBavN7dHf2lpBvLessDZpDHIfn/UXTdKETBCBrWoyFQfoA
   3HbmPZEVqdi2d3ALtMbq54bhezQM/8m+LFm/m26kT67NcTdbxYhOSs6RY
   A==;
X-CSE-ConnectionGUID: ErWSvBqdShyWDEm1/gl7gQ==
X-CSE-MsgGUID: daLNQcVgRSuuShLkXo0FaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="11271841"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="11271841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:15:58 -0700
X-CSE-ConnectionGUID: fYLWpQCORY+I+mxx/Mg7jA==
X-CSE-MsgGUID: f6wpcMCCRdWnHATyGokM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28140599"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2024 05:15:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CF2A320F; Mon, 06 May 2024 15:15:54 +0300 (EEST)
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
Subject: [PATCHv3 0/4] x86/tdx: Adjust TD settings on boot
Date: Mon,  6 May 2024 15:15:49 +0300
Message-ID: <20240506121553.3824346-1-kirill.shutemov@linux.intel.com>
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
  x86/tdx: Handle PENDING_EPT_VIOLATION_V2
  x86/tdx: Enable ENUM_TOPOLOGY

 arch/x86/coco/tdx/tdx.c           | 163 +++++++++++++++++++++++++++---
 arch/x86/include/asm/shared/tdx.h |  21 +++-
 2 files changed, 169 insertions(+), 15 deletions(-)

-- 
2.43.0


