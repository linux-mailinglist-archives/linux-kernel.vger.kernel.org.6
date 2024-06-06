Return-Path: <linux-kernel+bounces-204711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BF8FF2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E672871A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC9198A2F;
	Thu,  6 Jun 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nfclylo3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261419885E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692057; cv=none; b=Z66REWcpvKZNqy9mFlcIF6xCGeVt5Nqo+fYiZIZuORhxtWfJU7qTQikfgDpQqXBmt6DsMfJ2fU8bINZyP+OtEB+I3+CTXpPrY4Ft2NrQIokciP7XQAYHEf5eyX/rbsovpFEoFQAm7TT8vXkevKGRfRA8SEvtJ/xDNPY4XvH010w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692057; c=relaxed/simple;
	bh=Tmd4QY5T/e3nEEkLhLHnslTNEt9LzYjz5iyl8yEdajM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ax3zQSJxU0B/EIoVurvUvdqXf88355R3EgAYTIRf7fOQ3kBJIfHBQjZX1YFGiKtyyOE/vt7YYjKKkdFjoqiXI31ElA4gDaKuLlpGkyN8v4Vlv3moO/qGv62I8LuSvC1ocfAhNFq79omiZG+MPWEupF+VtlfIKlsbhib1GP/BDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nfclylo3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692055; x=1749228055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tmd4QY5T/e3nEEkLhLHnslTNEt9LzYjz5iyl8yEdajM=;
  b=Nfclylo3rYRvAP6s+BhKrJi4/o+A7p02ayOeIsMuQU0zYJm9+asX6702
   vjJAsz5UsggZy0QVy201mZM+nlB77AZMGI0SXrM914gMDLuExX5VitR02
   tp/sZgrpOwRY+l4XhdamURF+Ou24C9+bzW7srSXRqPDXI0CMUQv29Upjg
   78aETfcsg9WdzMNzTS8yojoEXLSmnGJNDz6+7HAJF2fnw6xgGt3lIxi5F
   xbClkuRoGsZLqQQr9ebnsm+EgU/SRdf+v1boKqTAMowDx+PX09Z3xjp7u
   Caqg2FkMNkO1fAyeOeYBK/8ieThT6dIYDc10GfaEYwBGYNwuuHxrORB2C
   g==;
X-CSE-ConnectionGUID: EepVNBW4RaWfYgzaPwL9ww==
X-CSE-MsgGUID: e2NdUwDBTrmPIkD2wSrkHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14214908"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14214908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:40:55 -0700
X-CSE-ConnectionGUID: h3W48DblTlWbxb0o5m/wfA==
X-CSE-MsgGUID: 5QazQ67pT4eIApzhqXCodg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38033088"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:40:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
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
Subject: [PATCH v3 0/2] Add and use get_cpu_cacheinfo_level()
Date: Thu,  6 Jun 2024 09:40:45 -0700
Message-ID: <20240606164047.318378-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper function came up in discussion of the resctrl patches
for Sub-NUMA Cluster (SNC) support. Reinette pointed out[1] that there
are already two places where it would clean things up by avoiding
open coding. The SNC patches will add two additional call sites.

So rather than have this jammed up as part of the SNC series, I'm
posting it as a simple standalone cleanup.

Signed-off-by: Tony Luck <tony.luck@intel.com>

[1] https://lore.kernel.org/all/050c64b3-20b3-4db6-b782-f5124ebaab31@intel.com/

---
Changes since v2:

Add lockdep_assert_cpus_held() to enforce what was simply a comment.

Combine patches 2 & 3. Both functions using get_cpu_cacheinfo_level()
are called inside rdtgroup_kn_lock_live()/rdtgroup_kn_unlock() code
blocks. So cpuhp lock is held.

Tony Luck (2):
  cacheinfo: Add function to get cacheinfo for a given (cpu, cachelevel)
  x86/resctrl: Replace open code cacheinfo searches

 include/linux/cacheinfo.h                 | 25 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 17 ++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++--------
 3 files changed, 31 insertions(+), 25 deletions(-)


base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
2.45.0


