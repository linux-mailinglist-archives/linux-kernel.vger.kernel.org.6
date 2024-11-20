Return-Path: <linux-kernel+bounces-415139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB79D31EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D76283A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98518035;
	Wed, 20 Nov 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUCKYdOx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04192848C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066368; cv=none; b=NlorHEHF7yssm8FHSIC8ZQCb+e6Pqd/+Daaw9CL/g6ulLqpm+/ISWI1hJ7kpkmBrkFrneX/u6JxumCKFDJKSUYxrgS8wjMnTxAtz2YZAuY9lcDEg49MTFTN2Bx3D0rv6Z6VJMVqqQn/4slMhO/6V6LGLELZQk4F0DNffx///9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066368; c=relaxed/simple;
	bh=w2FO50rpr1hw49SgmuY8WaX0vGq+5OBKa9eQiIAjnto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfMkfipPMMLQT2u6oLiAnG3xuNrEbLOdGuzrlaoW5rHK+o6sDSvqBmlQJFvEwTLo/ie1bm23G3s49l116kDrlKyD+Li6yX3juBaT6CXkxur0WrXuQ2Op3RDEoxVqoAlo6pFCipBidQwZU6+BERbJ2+q4fYQKPxTf2rO1ot4FP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUCKYdOx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732066367; x=1763602367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w2FO50rpr1hw49SgmuY8WaX0vGq+5OBKa9eQiIAjnto=;
  b=lUCKYdOx/PcG4df2NVsoTRX5mtL9yU5ptMhfHt8MsHYZewKD1mcA+vhT
   B+55uj/Izm5P8t62wM8kYqGhUHCHKT5qkZ8Ksa0Ms7lcV4LfGeX/oAprT
   oI+fQHmfkqwq7euncljcEhWrBOPEyT/7EYZX6mmYXsEv9iT3gkNwZh4Df
   NqBTW3bO50gyk+i3usmwqP//DSs+V0fytjLIzyla5ScR9X//5RLEQRtJv
   67PEGPg46qe+a0HkTImThTybyR69+IeMwr7g7rdQTChADKBtf4b6RLyT5
   2aEqMu17MSS+9EGgwxMB6IFfx61FHsMZz50usbjmrSqK2vBMN1SGBDye3
   w==;
X-CSE-ConnectionGUID: 1gi6RCqBRHOVaV6iM8e1tw==
X-CSE-MsgGUID: TSx39cnIS9awPrk+pYdpWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="49532910"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="49532910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:32:46 -0800
X-CSE-ConnectionGUID: k2HraunHS0yDZrMaRxUeUA==
X-CSE-MsgGUID: 9KMAGAEkSIOT78xScdIjCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="90130842"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orviesa007.jf.intel.com with ESMTP; 19 Nov 2024 17:32:47 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.13-rc1
Date: Tue, 19 Nov 2024 17:32:43 -0800
Message-Id: <20241120013243.831531-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull some x86/tdx changes for 6.13-rc1. These essentially
refine some interactions between TDX guests and VMMs.

The first leverages a new TDX module feature to runtime disable the
ability for a VM to inject #VE exceptions. Before this feature, there
was only a static on/off switch and the guest had to panic if it was
configured in a bad state.

The second lets the guest opt in to be able to access the topology
CPUID leaves. Before this, accesses to those leaves would #VE.

For both of these, it would have been nicest to just change the
default behavior, but some pesky "other" OSes evidently need to retain
the legacy behavior.

--

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.13-rc1

for you to fetch changes up to 7ae15e2f69bad06527668b478dff7c099ad2e6ae:

  x86/tdx: Enable CPU topology enumeration (2024-11-07 10:27:45 -0800)

----------------------------------------------------------------
 - Add new infrastructure for reading TDX metadata
 - Use the newly-available metadata to:
  - Disable potentially nasty #VE exceptions
  - Get more complete CPU topology information from the VMM

----------------------------------------------------------------
Kirill A. Shutemov (4):
      x86/tdx: Introduce wrappers to read and write TD metadata
      x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
      x86/tdx: Dynamically disable SEPT violations from causing #VEs
      x86/tdx: Enable CPU topology enumeration

 arch/x86/coco/tdx/tdx.c           | 138 ++++++++++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  13 +++-
 2 files changed, 128 insertions(+), 23 deletions(-)

