Return-Path: <linux-kernel+bounces-197410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D98D6A33
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67321B23236
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7617CA03;
	Fri, 31 May 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imrUFFMW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED95380
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185454; cv=none; b=BLEdDMn/QIHcuRH71OnuJIeblXH2S4U1FTJjjj8iNoGnYQTRPk2XIpyEQtAkKccxcteDra6I4kVbrkcAykvHLEqXSe+B29TNZoaEhf2cwj+XNub87K8NbC62J3yKshDMrc6dIX3rOjPRiT4zktGA0zSHA7hxOeDQVtQ47QpDUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185454; c=relaxed/simple;
	bh=/lOtInnt6prvkKlLm8woy26AEwqxaaGOlQ+2tGdoA84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7CaUbXVZPAhQ78h3+eXatY1fLXUyWXC2rfTKuqfZP+dyPFMcoa48wafoMCNLrsb2Ap7MuRBIWkPZmPjQJUsZ+TTM8KNV35uDkqENMAIPFESdKDWFfvmhbHXg6fqATOLSEVC05Rfay6RBM/XjToYD8zSdUi20CkSKAZOoEgYl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imrUFFMW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717185453; x=1748721453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/lOtInnt6prvkKlLm8woy26AEwqxaaGOlQ+2tGdoA84=;
  b=imrUFFMWr/Y3ipD2QcmrXrdICiOhdBc+7zKe25y4dnyISfhFP+rwArfD
   2CBLtNvjhWOfJRH/5w02UKfmE3jTF6/ViCePeihTxiQTPGWMMat1Ml8Wz
   6GxUVU2RaUtOr8EGF0njx+hal4aC1k7WjhSjDkEe1QrV6CwH801RM2Fi6
   w909Ty+KEQ6EKd57afFc5VK7bWeP0muNP6dDIyGYevvAgSBT5Zhy3KodM
   LDPZsrfTD1zYekK1Nr2xIr+RQBOsP/vsjndeSqqs8o36Wco52jwNcVnxj
   czZXetYFofArHbFo0H+06H65Yf5jnDqg3IV55Zvncu1/p82K/kSLXWhWo
   Q==;
X-CSE-ConnectionGUID: kFBGK9PbTma3GhdNjHUViA==
X-CSE-MsgGUID: qpHpCoI6TwKZtw3nzz2SEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13501127"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13501127"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:57:32 -0700
X-CSE-ConnectionGUID: 9CQNwWH2SSebzbLyMWYUOw==
X-CSE-MsgGUID: 3hwgAf8STv+CgTeLHf44Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="59438867"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 12:57:32 -0700
From: Tony Luck <tony.luck@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/3] Add and use get_cpu_cacheinfo_level()
Date: Fri, 31 May 2024 12:57:17 -0700
Message-ID: <20240531195720.232561-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[get_maintainer.pl is vague about who owns <linux/cacheinfo.h>
 to I've scattershooted some of the folks that committed changes
 for this file]

This helper function came up in discussion of the resctrl patches
for Sub-NUMA Cluster (SNC) support. Reinette pointed out[1] that there
are already two places where it would clean things up by avoiding
open coding. The SNC patches will add two additional call sites.

So rather than have this jammed up as part of the SNC series, I'm
posting it as a simple standalone cleanup.

Signed-off-by: Tony Luck <tony.luck@intel.com>

[1] https://lore.kernel.org/all/050c64b3-20b3-4db6-b782-f5124ebaab31@intel.com/

Tony Luck (3):
  cacheinfo: Add function to get cacheinfo for a given (cpu, cachelevel)
  x86/resctrl: Replace open code cacheinfo search in
    pseudo_lock_region_init()
  x86/resctrl: Replace open code cacheinfo search in
    rdtgroup_cbm_to_size()

 include/linux/cacheinfo.h                 | 21 ++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 ++++++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++---------
 3 files changed, 27 insertions(+), 25 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.0


