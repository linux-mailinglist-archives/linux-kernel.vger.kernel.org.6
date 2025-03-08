Return-Path: <linux-kernel+bounces-552712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41027A57D45
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A073B29A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD3212B0D;
	Sat,  8 Mar 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRodNPR4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA25214A82
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459024; cv=none; b=jart9von6iTF7cLQFaBBFd9cWVCCLxbFdNMHhcg+o++cqr9gwyXCUn7ANGifZm7MxpDCPDLl4WtP13H1OTWYElsNPedAos+0NovsCtC5PEApT3hlKkQz6sP0Pt99gbcD5O8aHhVc1pzsCuVw+mFfmnKqV8FcRE86jOW1a5F08H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459024; c=relaxed/simple;
	bh=de80fhR1oga+j2cwNsqZ/kApwvosfVY97WNh0bbPtBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuwED/xXX3H9DQJcJpb4XMPivUHLyAuhhqkCDVS1W/Gloliu/rKzYHmj4EEYxnURWGls/z8awcUnTXpc5N5x4NV5GeZBW+mbTIlwW5kRKlF1rQwASLHdSIBSf0P9zR+aqQecPKExHo0ScV6FD6uD8bwZpnYMte+/EOyC+auOnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRodNPR4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459023; x=1772995023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=de80fhR1oga+j2cwNsqZ/kApwvosfVY97WNh0bbPtBs=;
  b=gRodNPR4sMsxZ+URoPmcg7ZOJ335XvDj399Db2HHYa4Vb8KWQnQ8uM07
   9mrLUQwTSiCUX1bB5jNybwJOioI5MxDGmFAKVlZuX/4MYh2Ezk4pLeo2e
   b/awJsCYpiYi9Xslq8djFn/lsBhBlzlP0wL+JIe42UQkKZZnmaVB4gKMb
   6D+6t0TESjV20UhGD2u/ovvtYrOXMt5ubClmDGuhAQ1MUncYtXLFH/4t0
   npCpiZvETtHiSBUh0CEU07zqlG5hXibU34s5rSBUmIueLmjx0EUAVliIR
   v42WfkEWg1IIPmTR3y+qCNvozEjuN8B228gI+mbU5no2GGCHB1DM4+fsr
   w==;
X-CSE-ConnectionGUID: V2s9Vc6GRReyIdPOZ9UBTA==
X-CSE-MsgGUID: lT+E+BIzR8SWmG9uha9/fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42532476"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="42532476"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:36:59 -0800
X-CSE-ConnectionGUID: G5E0+or9QruePWY+lmNb1g==
X-CSE-MsgGUID: 71fqDc/bQBqdPuUluaYXpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150548552"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 10:36:58 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: int340x: processor_thermal: Platform temperature control documentation
Date: Sat,  8 Mar 2025 10:36:55 -0800
Message-ID: <20250308183655.118285-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308183655.118285-1-srinivas.pandruvada@linux.intel.com>
References: <20250308183655.118285-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation of attributes for platform temperature control.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/driver-api/thermal/intel_dptf.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 8fb8c5b2d685..e7e387d60b7e 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -191,6 +191,21 @@ ABI.
 	User space can specify any one of the available workload type using
 	this interface.
 
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_0_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_1_control`
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_2_control`
+
+All these controls needs admin privilege to update.
+
+``enable`` (RW)
+	1 for enable, 0 for disable. Shows the current enable status of
+	platform temperature control feature. User space can enable/disable
+	hardware controls.
+
+``temperature_target`` (RW)
+	Update a new temperature target in milli degree celsius for hardware to
+	use for the temperature control.
+
 DPTF Processor thermal RFIM interface
 --------------------------------------------
 
-- 
2.48.1


