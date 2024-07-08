Return-Path: <linux-kernel+bounces-244814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A792A9D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F69EB2176B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC31DDF4;
	Mon,  8 Jul 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkmUiGal"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520479FD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467164; cv=none; b=DlIGCyxACugrChMj8EQipsoa4hm0JVj5PwzGa1UjXxrIP6sxUIXW+pCNtFyI3dyoYvPf/C1pVvIgHdnI+fcglJhMbLWbhj3MWSQODCwbJ0rHfnr88wUhVWV7RV8TThetH1oG3dLmcPBumbv4XRMxGvXVjnFu94loIw2YRTFf4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467164; c=relaxed/simple;
	bh=I7nIWX6j1DPFcFgjuzhDlazQBbcqxpzyrEtnjjK/3rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uWHz5aqaITPFP+5DBGU8enWCrnborVQC7XI5pIu0oYgKLyh1FXB5S5T4ED6mQvChPq1nfLZnW5FnxAdsETt7bb6SYh7Y1HGfyzXo8rDoQKIqqWVbD/epEEHVNhnBTZZfFefBK0mxJrig+A+A4Y+s3Xz0qlQCFVp/Amlgrow+qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkmUiGal; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720467163; x=1752003163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I7nIWX6j1DPFcFgjuzhDlazQBbcqxpzyrEtnjjK/3rc=;
  b=PkmUiGalHuLuRnGAY7nwCS2LJDmo3Jb9GfQwU4vSpYLHIZ/AO8BVfKnY
   xjGb8rYeYlU6ik158xrcxlSu9mHLpyLbfQQgE/mFW0UxKnhgpUpIJS+q3
   kWl+pECPP8hFwgOqYSLIPIxPfFK4E+Ihr3PXPQLKpbg0xnVKIMiih9aGY
   1p5Ai/8IydJ57rkYYcSRJs0ibi0hhzmODByyinorpf5ky8ztC3gfYGSTW
   HXEjsMM6TKIShUHDCDdwtXSMgmvof8lfbZ3MRnZleLdO5jjJcndL1U80i
   fcAj9FryDLR8BcldgSKYIZCwUeuY4QHRNg0ode5mRbJUXadQp7HaDVsax
   w==;
X-CSE-ConnectionGUID: ctjPxH63TFiT4BcksdLNyA==
X-CSE-MsgGUID: aKsMjy3uSw+WB350J9iRBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17520482"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17520482"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:32:42 -0700
X-CSE-ConnectionGUID: V0RQ2a37T/GpIMzwCCwCFA==
X-CSE-MsgGUID: rpwdD4NCRymAzYqAMR2X3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48265591"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 08 Jul 2024 12:32:42 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/3] perf/x86/intel: Various small fixes for core PMU
Date: Mon,  8 Jul 2024 12:33:33 -0700
Message-Id: <20240708193336.1192217-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Several small fixes for core PMU were sent in the past few months. They
were buried in the LKML. The patch set is to resend them.

These patches are standalone and can be merged separately.

Patch 1 is to hide unenumerated Topdowm metrics events.
The original patch can be found at
https://lore.kernel.org/lkml/20231219150109.1596634-1-kan.liang@linux.intel.com/

Patch 2 is to add a distinct name for Granite Rapids
The original patch can be found at
https://lore.kernel.org/lkml/20240426150557.2857936-1-kan.liang@linux.intel.com/

Patch 3 is to fix non 0 retire latency on Raptor Lake
The original patch can be found at
https://lore.kernel.org/lkml/20240405143032.1243201-1-kan.liang@linux.intel.com/

Kan Liang (3):
  perf/x86/intel: Hide Topdown metrics events if the feature is not
    enumerated
  perf/x86/intel: Add a distinct name for Granite Rapids
  perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake

 arch/x86/events/intel/core.c | 43 ++++++++++++++++++++++++++++++++----
 arch/x86/events/intel/ds.c   |  8 +++++--
 2 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.38.1


