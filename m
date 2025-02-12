Return-Path: <linux-kernel+bounces-510679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EDA32061
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024FB161448
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A4204C35;
	Wed, 12 Feb 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfK8AYYx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6A204C1B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347058; cv=none; b=URLatFOxrp4PBx9OEOmUNn41HqzJsp4IzSQZMiKBcs6/iwOLWy2shO7kLL0wvdtIcAkSf+tkyTG74h97TPirqnUPar1elY2ywvHHpnzkU5AxDuLt3SpR7L4kmbccB0Frla79TEep+DkG9I4aZVc6Yy6pe7snEfMCXgHYC8gocVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347058; c=relaxed/simple;
	bh=03WLSSFoaU02CLxWG0tXeMYv/zQbNS0SuGJ8yfYpC0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQL28iddRIjmP4ZMDS6Z+8hUITZJhzkTeRpvKfaqki6/2SmXSWA8SGxtsEyefx1gpvlAZHkb+LQG8iK3bpSPFglDcQYGKXSeqCrypKdAc0GmW7QOnjAwqYg9biepueWIumFVjZ144GKA6E7Kuxp9/yb9+SyWVqwvk2oV5kj31JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfK8AYYx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347056; x=1770883056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=03WLSSFoaU02CLxWG0tXeMYv/zQbNS0SuGJ8yfYpC0E=;
  b=CfK8AYYx9f+gJE67GzxJS72QpojQL3vbyfd6WSAIbUtcAF3usq53bd38
   7p0KCgEVhOp1yA5vrkOYQrHO/awQ8/DQZZ5urjIiq4K02wJT01+Z3AbWF
   mpAM1K/0hSAl9w8SMbHYXxl1u59oL773YXDf+f/EqTqhhTZicpJn6b9UH
   Zfo1UrCfarfibGu9etEVGg6XwCsCqVYheRQUTbIDdcHdekq4qcFbOJQeg
   59b3/niRoOra/l5mqVz/6Kqm/zJ221W6G69L1STqpZiFM65mYNCM5u8tU
   vo2gOKHFln1YKcSp4MZmI+gCG+zX45u+E85DCgXuD0P1mrg1x/g4mTG92
   Q==;
X-CSE-ConnectionGUID: BR4CZVcASn6KQsf8puinBw==
X-CSE-MsgGUID: h4xboBwsSeS86WhCuXQs6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50633575"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50633575"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 23:57:35 -0800
X-CSE-ConnectionGUID: 13DZUju0SoiMtD+w64Lw0Q==
X-CSE-MsgGUID: +yODgdJLT2uqUBxxM0irSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112700731"
Received: from ubuntu.bj.intel.com ([10.238.156.105])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2025 23:57:34 -0800
From: Jun Miao <jun.miao@intel.com>
To: kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/virt/tdx: Correct the errors in the comments
Date: Wed, 12 Feb 2025 15:58:05 +0800
Message-Id: <20250212075805.2906200-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In comment of config_global_keyid(), the "will fail" is duplicate, delete it.

Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7fdb37387886..2023216a04a9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -961,8 +961,8 @@ static int do_global_key_config(void *unused)
  * Attempt to configure the global KeyID on all physical packages.
  *
  * This requires running code on at least one CPU in each package.
- * TDMR initialization) will fail will fail if any package in the
- * system has no online CPUs.
+ * TDMR initialization) will fail if any package in the system has
+ * no online CPUs.
  *
  * This code takes no affirmative steps to online CPUs.  Callers (aka.
  * KVM) can ensure success by ensuring sufficient CPUs are online and
-- 
2.32.0


