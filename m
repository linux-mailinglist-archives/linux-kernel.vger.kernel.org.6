Return-Path: <linux-kernel+bounces-210593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD59045F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E7288BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440B14D2BF;
	Tue, 11 Jun 2024 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLKY/h2K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85729B657;
	Tue, 11 Jun 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138904; cv=none; b=G31EsQu/wcXvhiYxOq0/grB4MBqv3AnFeTSVmBkaDDupPUhUH7zToy7lnfEc7yrv/Ik3e3e3L2TnQ4dsNeNptPMuwpHmZhei2GS+uk1VJkDftdfio05VT9KVkJgxkitho3NQv0mA24Iz35dqPMhQciZAEQH1YNTShTafFC5mZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138904; c=relaxed/simple;
	bh=1/tqaIGvH2aIdc6qjr6EFO6xMzJH8Sqyn0+Hr1zgwww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAnBpl7VOGqx5mLLiPlfu4fYE5my4pcrwfgAk+03oQ22bRovlvdHo6D4+TgQyp0UHjWI+EvCQ/Ux8FRtD/Pewp6E+fuu24lvEFlbpnPhndnTiYxWzQVIoS4HL/B6nvHua1sf6l/xqYZrQ0a0eNowPUDkHxYxa4uOcJVRE9q3lHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLKY/h2K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718138902; x=1749674902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/tqaIGvH2aIdc6qjr6EFO6xMzJH8Sqyn0+Hr1zgwww=;
  b=OLKY/h2K4+LunhzvahYq0xDmifdZ7PZ1f7wCMV8H98Sw8DwkUREK1stY
   gWpLScVoerzmR1vOWDMoyFEYVzA4Why3309qqM1vxzexHUM13xZuEyVIB
   aYLgNgh8lP/FmP9cmT4bXfRQrBOTuBy1Ao01JXS40X8L6/VGLaJrofaH4
   Y+0FViWf82zkU5Y+Y3fWZrWW4asG05qRy8+voA8Y8ZAUDSUnKo32jrPs+
   eFlzs9UUvpKnoY91QA8tCkBxaIpFQoN5bBGkMyXTxZ6qQM17NnW5QRmSe
   KtA2ymsj4pLx1q6RbtDXMD1Wh8zxwRK/4Qmvcy0/D4zYwjYUVNeVfCZmw
   g==;
X-CSE-ConnectionGUID: BVxKZbSXTjyr5T6bLFPvlg==
X-CSE-MsgGUID: fhS84CTgTEOAm6ljhotteA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25452975"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="25452975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 13:48:21 -0700
X-CSE-ConnectionGUID: ScX/nCj5SmCchozr0VqgOQ==
X-CSE-MsgGUID: FBKMqUEGQ86Ox5eLHbEp+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="77020659"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 13:48:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] Documentation/x86: Switch to new Intel CPU model defines
Date: Tue, 11 Jun 2024 13:48:14 -0700
Message-ID: <20240611204814.353821-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model
so "_FAM6" is no longer used in the #define names.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/cpuinfo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 8895784d4784..6ef426a52cdc 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -112,7 +112,7 @@ conditions are met, the features are enabled by the set_cpu_cap or
 setup_force_cpu_cap macros. For example, if bit 5 is set in MSR_IA32_CORE_CAPS,
 the feature X86_FEATURE_SPLIT_LOCK_DETECT will be enabled and
 "split_lock_detect" will be displayed. The flag "ring3mwait" will be
-displayed only when running on INTEL_FAM6_XEON_PHI_[KNL|KNM] processors.
+displayed only when running on INTEL_XEON_PHI_[KNL|KNM] processors.
 
 d: Flags can represent purely software features.
 ------------------------------------------------
-- 
2.45.0


