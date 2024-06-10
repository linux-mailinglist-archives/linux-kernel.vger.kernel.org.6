Return-Path: <linux-kernel+bounces-208845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0D9029D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6150A282AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E04D8AD;
	Mon, 10 Jun 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga4HRyK4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1818C36
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050672; cv=none; b=Ei9wwznHrbCHelIMwj7Uen+yQwXugyZz043FQVAN5RW+OrxkVJZC8ZlStLGlEUKiJFEcHFgS3SF380j4iONJ6F4TiUJv+feEmb3lULzMe4PpKsz0YHo63ok3uMBd2OjeMBe0tOPx93lpzRcrNcaUbvmt4AIEyY/p+CagK8FPIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050672; c=relaxed/simple;
	bh=AYTpGtiiDl/GWww+5fNx+6OoZbf8us7Cx62MMH1msxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WBya2UMzKA2Z/v5I/dpGaNoXFjeMKJnFnO+12dpbHmU40EchHdrTvGKMV1I67VmnGS2LNG9nsNQlKEEDQ8RrOA97dV3ZNjv7QBmjED0Dd5O9hYcK8+rhSFGl0HaIDwgYuNmGwk5crlMHz/yasqncYg8q4lmyahDgqQ0XoRjaQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga4HRyK4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050671; x=1749586671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AYTpGtiiDl/GWww+5fNx+6OoZbf8us7Cx62MMH1msxo=;
  b=ga4HRyK493bSKGdqOf0+eoyzGVwoB/Jg8hZmJfbHNFNcvtBs6ZnKyyBK
   SxFt4oMOrdYCpAMs+ljm8YUFEF9LYuJdRYegDgvmBUEYiDV4TCGTGD2VQ
   VagumTpL+HMMQr7YRg4p4Clr+xydHP4PGQkblMbM0Rp03Ps5m1L020jFh
   CPigw5r97mQEg1ndrN56+MF+/a3HnEGpoceETcnHSqpRhrffXWxdwcDIk
   sNYNybenl+qMBu9ZceL7nTeSqT/WJpADxOhg21l3LEKanUJ8aA+prSG2p
   a2TzHgptmudDPofznxAD8bkOop6TTFUmPde8Npk4YuxhfDXR6lVSlI7oB
   A==;
X-CSE-ConnectionGUID: BMj2fPBoT1Os15aaPhvSyA==
X-CSE-MsgGUID: dmErzIqESliBgpnCtJAUzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561502"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561502"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:50 -0700
X-CSE-ConnectionGUID: EeidUscLSGCAm76zB+afAQ==
X-CSE-MsgGUID: EvCfPsOvSZm3tXus72jHDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169064"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:49 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/8] Support HBM and CXL PMON uncore counters
Date: Mon, 10 Jun 2024 13:16:11 -0700
Message-Id: <20240610201619.884021-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The uncore PMON information of both HBM and CXL can be retrieved from
the discovery table. However, the CXL entries break the driver's
assumption for the discovery table. The first 7 patches update the
generic support of the discovery table. The last patch enables the HBM
and CXL PMON uncore counters.

The discovery table support was introduced since commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). It's a
self-describing mechanism for the uncore PerfMon hardware. By reading
through an MMIO page worth of information, SW can ‘discover’ all the
standard uncore PMON registers.

The entire discovery table could be big and contain duplicate
information. To save space, the perf uncore driver only stores some key
data. Others are calculated from the key data. The driver further
assumes that the uncore PMON units are symmetric among dies.
So only the unit control addresses on Die 0 are completely stored.
The addresses on other Dies can be calculated via the address of the
first entry on the Die + a fixed offset.

However, it doesn't work for the CXL PMON units. The CXL PMON units
could be asymmetric among Dies. The offset between CXL PMON units may be
different on different Die.

To address the issue, the complete unit control addresses for all
Dies are stored in an RB tree. For a 2-socket EMR, it requires
at most ~6KB extra space, which should be acceptable.

Kan Liang (8):
  perf/x86/uncore: Save the unit control address of all units
  perf/x86/uncore: Support per PMU cpumask
  perf/x86/uncore: Retrieve the unit ID from the unit control RB tree
  perf/x86/uncore: Apply the unit control RB tree to MMIO uncore units
  perf/x86/uncore: Apply the unit control RB tree to MSR uncore units
  perf/x86/uncore: Apply the unit control RB tree to PCI uncore units
  perf/x86/uncore: Cleanup unused unit structure
  perf/x86/intel/uncore: Support HBM and CXL PMON counters

 arch/x86/events/intel/uncore.c           |  97 ++++---
 arch/x86/events/intel/uncore.h           |   8 +-
 arch/x86/events/intel/uncore_discovery.c | 306 +++++++++++++++--------
 arch/x86/events/intel/uncore_discovery.h |  22 +-
 arch/x86/events/intel/uncore_snbep.c     | 128 ++++++++--
 5 files changed, 388 insertions(+), 173 deletions(-)

-- 
2.35.1


