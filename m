Return-Path: <linux-kernel+bounces-269341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B779431C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09511F22DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FE1B3740;
	Wed, 31 Jul 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boqsjy/P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957E611E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435207; cv=none; b=n5PcAH3L8XwuxktCTj0TOXTi2yWqwrS9duujHRrGlCU175IapsDJ10D87YR8QQY7Qm7Y7ME0omnJqvr5JQZfe8hRh0NaTPuXtOcCic4tIm6QfZHD0hRtWywSof1zPpburGMCoymCt07on4CZuGuU/Axcovls7+dc/0XaiHX56+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435207; c=relaxed/simple;
	bh=bt7Zp+hPlqhVY4gKIxRF9Y4uW9SkHcvOqqNSDDsGwx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIQekzG7cCN46D/L7SMEHc2uaIOrFGuO+L4eawoas3SkKDBu74T0i+gap7bAjL1yi4RqVK0ATmyjT0W0lhp7HccQOk8SftlhFx9ru+lS/u+NrzljTfQzhuReW6gU3gg1X3UU9GwaJlTz4B4MCYopdLofKZW25qyiNClfqOMbyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boqsjy/P; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435206; x=1753971206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bt7Zp+hPlqhVY4gKIxRF9Y4uW9SkHcvOqqNSDDsGwx0=;
  b=boqsjy/P+7Zz4g8vBdI8YbAX6Uww4hr8m3G1Jt2uZ2ll3fvmK5UGNgPE
   P+22de/HOo7SG9B4+3a6XXFazlSQi/V849lRNSNjUDBQ4O+v+kGC5kFhj
   5/Eu4wIhtc1/+wTWn5BfEgaPAgxgSjPIsTbIO+/7TAOzsx7EmOLfowGJT
   rGloI8EVDSDMM25F5SA/Rkg/9Vbfc9YuV7qxENU6y02Bl/rI9fXDZB3Go
   AeYITx5+YEArpMN8np6ELbMH1FMNXFUOR8SkBtGfD9O0tFX+BrmTriIk3
   GCpQgTfb0NRXRRqyIW+GGhZnxlYGmvnXgR8bX7HEI3jfocIvmAKUBDTME
   w==;
X-CSE-ConnectionGUID: Py02cBrgRiqC/ikD3CckfQ==
X-CSE-MsgGUID: D+mVdfDORIuuVolhLxfDZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20011612"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20011612"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:25 -0700
X-CSE-ConnectionGUID: 78Lk/khBRTCqXg/Kt7Xlyw==
X-CSE-MsgGUID: ic8kpG/LTcinVRcjg5KZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54357880"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2024 07:13:24 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/5] perf/x86/intel/uncore: Add Arrow Lake support
Date: Wed, 31 Jul 2024 07:13:49 -0700
Message-Id: <20240731141353.759643-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of the uncore PMU, the Arrow Lake is the same as
the previous Meteor Lake. The only difference is the event list, which
will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 9e503d861f0e..dd02f505f1ad 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1892,6 +1892,9 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&mtl_uncore_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&mtl_uncore_init),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
-- 
2.38.1


