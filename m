Return-Path: <linux-kernel+bounces-336157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9867597EFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D98282433
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50019F12C;
	Mon, 23 Sep 2024 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0qanL2I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4336124
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113079; cv=none; b=EqI/wl6srA9xloRF/tj2LKn2yjrcSiNoAHLm8BM9/bfNVGa455WfAf9tKeJTaVOORRDRpqqtNuvXsY2JR04b5pqwnM8w77rX2nFdjR9+SKfpurrRsyleodKcuBBEmH4kgUoR7t1tRZTR4ueYtB25cKGxt4z0WAIivpjH0ILmFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113079; c=relaxed/simple;
	bh=X1fWsAcZf0vbkhOtuDK1DITR89lqk4uOXmmpbSYbyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQnTxfkafz19w2nGmhuGbayfLCAv/oNxV/fOT7P2EeLbh6SgZv/yJ6FiL9+16u+AfIsORY2zpQbJ0r9Ms1zPdQ0JOro7kzqXsckqqdnP6ssowS6+6KyfOIaUVqrCs+2S35Li6yYhu7C9dS0FpgU7tlwGBwEvqm8f8iWRiW/iKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0qanL2I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727113077; x=1758649077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X1fWsAcZf0vbkhOtuDK1DITR89lqk4uOXmmpbSYbyoQ=;
  b=O0qanL2I4PpTvLxHHFpQ+Mnn92MCdhy2Z77fUCMwWgEhZDcSNafc8cw8
   bg1OHD/sQTbEdc7o2Z5GksJfui5x1uUkFSKKS51p1rv1c/Ax37g5ntvPT
   i8UYWl2UuZZeF56oJWOGTf2p7by6ZTC6aBT+GamjqsioRBC3pIz1nllEn
   dniAAqL51wTXs8r7xEbjnJgv3lFjNHiGHK/m2mpRnEkXOXXbquNEqpTqa
   dkK/fbn62dnd9lBWCw116cL3OAk5ksnJDy/27QDH93TpkEdq/Aefr8OvD
   mWbXV44Z+yK8Ewwohu74uBSkdLCb9nGbXOsrgJKaw0eBHaD4cKpU6WmON
   g==;
X-CSE-ConnectionGUID: vDp9SLcaR9eZAO5/HGxwkA==
X-CSE-MsgGUID: pMTVHmmaT3mFMD3Qzl5isQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37453839"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37453839"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 10:37:57 -0700
X-CSE-ConnectionGUID: /dl40x+IR0imLTCsrv5r8g==
X-CSE-MsgGUID: SAUYPfOfTPevchEwN1hFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="76071308"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 10:37:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add two Intel CPU model numbers
Date: Mon, 23 Sep 2024 10:37:50 -0700
Message-ID: <20240923173750.16874-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pantherlake is a mobile CPU. Diamond Rapids next generation Xeon.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 44949f972826..1a42f829667a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -135,6 +135,8 @@
 
 #define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
 
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC)
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_ATOM_BONNELL		IFM(6, 0x1C) /* Diamondville, Pineview */
@@ -178,4 +180,7 @@
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 19 */
+#define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
-- 
2.46.1


