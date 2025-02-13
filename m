Return-Path: <linux-kernel+bounces-512325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E659AA3379C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A419A167B43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71C207641;
	Thu, 13 Feb 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1Wl2nbG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCD2063D1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426178; cv=none; b=Y8RAetLyM+Nv5Bc8x8+FU6Wlubr7+VAlX5fwUctB75DYb2c0KpJZszjGed8mNLfgaG9Wpak7+hZ5G+huqqMkuWhkC2+USRWOiN0KNyHwFcE2TRvTf+rVuaBTDKtKulAWJNY92AMF9RQkmAO8NT3uAwHEf1vzQVAs2hFcfFIK2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426178; c=relaxed/simple;
	bh=4bsEwEwBaPTXsQfCwWigVAv+NGsMJr0zZT5B3w8PGJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZMWBwf/PkHSf1GXadxe6m3o1wpBOxhKhu1JCXCQlI31PQCJwsHEhmePS8TozkG7kdO2us8BMtHN0YCPczvsfsW3I+xvSbBOTx5+nifJnaTbGpuQOQAc+xwP1++bbaG8s92FPfXycqvHzjfNrJTgMzZEJ33pju/ApGhU91tFXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1Wl2nbG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739426177; x=1770962177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4bsEwEwBaPTXsQfCwWigVAv+NGsMJr0zZT5B3w8PGJA=;
  b=h1Wl2nbG1a9uAzqSq/5ZreN7GwGkUEckJchh6b3DKJbel7527P1DW1sK
   03GgbBAt7svhMcf7eSogS/kTyBd+8tFLegIFronmnF+LX7ZBzIcwktHR/
   B1wx9iIXl1lPFwyAuu/UeKh/9KrhYPbsX0xuvlayjNAUVTuwdMlB1MLo7
   yuImPHGgu9EK7i36XuRGt86GI20o1kx/2G32A22pmpdgpL7eUp0LxHani
   157Kfs8Qp2NvCZU7ZtACgl9oGVjig4AP/uHVlxt5OXpdlVW4d68XTLGuK
   sjKCJiH5w+gKEn7z4RlaJey6+fIFjOsmQti3oQoRlnQ4v7CO6l4uPVoKg
   A==;
X-CSE-ConnectionGUID: wbL9PzKZRAin+XGZjpxe7A==
X-CSE-MsgGUID: NxE3Mf+ZQkeNKh1L/CzlLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40237395"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40237395"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:56:13 -0800
X-CSE-ConnectionGUID: 7NYo+22XTBCWa0VQrNU6Og==
X-CSE-MsgGUID: R3bOdgDZQyuZkvZglsjCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112887897"
Received: from ubuntu.bj.intel.com ([10.238.156.105])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 21:56:11 -0800
From: Jun Miao <jun.miao@intel.com>
To: kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com
Cc: jun.miao@intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/virt/tdx: Correct the errors in the comments
Date: Thu, 13 Feb 2025 13:56:41 +0800
Message-Id: <20250213055641.2952774-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the comment for config_global_keyid(), the phrase "will fail" is
duplicated. Remove it.

Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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


