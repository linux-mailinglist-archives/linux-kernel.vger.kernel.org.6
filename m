Return-Path: <linux-kernel+bounces-349483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D19F98F6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BC61C21C48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79A1AC448;
	Thu,  3 Oct 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLezQL+G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DE1ABEC5;
	Thu,  3 Oct 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982760; cv=none; b=Hu/TjEtM2R/QV+MvdJr2M5r7LABVW/J1w0JzK+9Q1VZp1Cnm8fNLbH6Vlgov0yN8wB3mOh5Bj/yA1YowOCgOTrPwkD/WK23ODIPSJQxztVcCOL9AEdSsyKCkVwc9gosIncNC9Zxqi8GoOH7uBISsuNTKPhW+rvCQ3/R9T7ACBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982760; c=relaxed/simple;
	bh=hvlsSwwXr3uVgXhII8AsI8In1V5uADcu6NhIrhrEW24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVUwSc2w4WYiv4Gi9D6ZKHz8Ioi+Jo4q9IdcjCHAV0pgvfXXQ2udtgEhFvbpXs1UO8M9uR83jxteBiDLiAXmecSgx3zKxn96sN6hTS1UqRLGqOGkytsUJY2oDTA8UXCrdZ/sWvFFZ2z4e9JSv6sHRmbx5/aPF+6idPyQa+/xbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLezQL+G; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727982759; x=1759518759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvlsSwwXr3uVgXhII8AsI8In1V5uADcu6NhIrhrEW24=;
  b=mLezQL+GlS+bUaojnWhdMBYgaE2xxne6eIO5L1/TY9EgMscWD8+IJbF+
   JiYIek3C7LS0jQf/HXiuR+H6txuFt8V3SdzuIJoY6z8EsSeTFT+X7cNmM
   lSRrLoPZ5jJ8VXqJI45VG0a4t2lLR0BpjtrySFnVcOu2NfYXZ9mxfCr5m
   TQApBCBHmmVrbJdygNazDQ4cvgNjR2eZDAYpaud9dS1QACjVTsGSCWQ0Z
   21sbTs4LDvLiRn8sMfouJz3udyx9urao1DDF8dH5GfGGqyX5L9X+20BD1
   BgcrMzM6YNy+s6nnvXK9n4FNi6byfgDuxq3wuwzQO3S2nIYWCpMVmB2RB
   w==;
X-CSE-ConnectionGUID: O5x8WhJ9R+qhbBz520EUEg==
X-CSE-MsgGUID: Ug0BVAhnR/WJxoB+Ox9y2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27287491"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27287491"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:12:35 -0700
X-CSE-ConnectionGUID: 9eE1duPJQdef+UdkRs0ajQ==
X-CSE-MsgGUID: DjuvuxPXS9eMuLAJp9H6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74031030"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:12:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 0/4] x86/resctrl: mba_MBps enhancements
Date: Thu,  3 Oct 2024 12:12:24 -0700
Message-ID: <20241003191228.67541-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[
	Bringing this old patch series out of hibernation since last December
]

Two changes relating to the MBA Software Controller(mba_sc):

1) Add a new mount option so the user can choose which memory
bandwidth monitoring event to use as the input to the feedback
loop.

2) Update the "mba_MBps" mount option to make use of total memory
bandwidth event on systems that do not support local bandwidth
event.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes since v6: https://lore.kernel.org/all/20231207195613.153980-1-tony.luck@intel.com/

Peter Newman:
	s/"mbm_Local_bytes"/"mbm_local_bytes"/
	Added WARN_ON() to check non-null return from get_mbm_state()
	Don't allow both local and total mount options at same time

Reinette Chatre:
	Use flag (enable_mba_mbps) and value (mba_mbps_event) in
	struct rdt_fs_context. Then pass the value to r->membw.mba_mbps_event
	Ditto Peter's comment to block multiple uses of mount options.
	Use invalfc() for better error reporting to user
	Note in kerneldoc that mba_mbps_event only valid when @mba_sc is true
	Declare mba_sc_event_opt_name() as "const char *"
	Rework resctrl.rst patch based on comments

Babu Moger:
	Clean up calling sequence for set_mba_sc() to avoid dummy 2nd argument

Other changes:
	I split first patch into two parts:
	1) the periodic updates to use r->membw.mba_mbps_event to choose
	   the event
	2) The new mount option

	Also noticed code duplication in mbm_update() as the local
	and total clauses are now identical. Split that code into
	a helper function mbm_update_one_event()


Tony Luck (4):
  x86/resctrl: Make input event for MBA Software Controller configurable
  x86/resctrl: Add mount option to pick input event for mba_MBps mode
  x86/resctrl: Use total bandwidth for mba_MBps option when local isn't
    present
  x86/resctrl: Add new "mba_MBps_event" mount option to documentation

 Documentation/arch/x86/resctrl.rst     | 27 +++++++--
 include/linux/resctrl.h                |  2 +
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 80 ++++++++++++--------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 51 +++++++++++++---
 5 files changed, 102 insertions(+), 59 deletions(-)

-- 
2.46.1


