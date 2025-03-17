Return-Path: <linux-kernel+bounces-564299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F6A65235
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9588C166501
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC422759C;
	Mon, 17 Mar 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4zMkm+h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0078F43
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220196; cv=none; b=Laf/3hvL2EyuQ4+euvCwL3zwAZRj/qyXlJG1ntRnELOqj5bS49k6K4TSZ/xwpvqkmgAiB4rHT/FgpCIP/FW4zai1SuEUnvV8NLAadhmAafxGcKZn3gAnoNHpjGkzxdXrUNHpTq15CW0NyOvXdVGQtK0EEo8ZxLZi62ibFuajAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220196; c=relaxed/simple;
	bh=ur+3Ka/ftKOuDkT4T1MQ6Jx5LEwesbX4+q1klExtobU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPOp+GrNMLG23vUPOD+YwvDKxi9l5XUqA2A8InXLIR5ICtDHFmCdpnyOY7T3DaRX7KwahxfCjJkHkgCeuq0gP7w8mjOSDqyL1sUlHMSph2BjFAKNfTfxiJMl+Ig6eB0BxQ6mqWyRBwf/CZlToHDn0KP27+lTZMOw61x3sYtnXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4zMkm+h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742220194; x=1773756194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ur+3Ka/ftKOuDkT4T1MQ6Jx5LEwesbX4+q1klExtobU=;
  b=f4zMkm+hGFS0JC9Zu6V8HEtutEUw4FoYxCXqPPRA0en857N8x7c1tvkN
   wEV730sPJ5zI6jCVjKmxsYOxEI/j7Lp7luIi9XiBNcu0Pt7Ax4dEoKKCq
   hRF1CsflzZOQcw7maRhMYwXxGxxXFryQTKLtAQdxkwsdUFw9Zs6nIPYmP
   k1X9lJIZANcIPSTGGluxtLS5X3pBODxENKoRDAbKCmrzXbXiaeELgrNXh
   wKf0ECYOBacy+qmyqzXMmIyvE4hdISVVazU8W3L0gsd3qqOyarloMZRBb
   Fd0oRLjwTYb1Kb9zhDkzSczOp1QzKHOb9LnZLuF5jmPVKqj6hMT4+d5wx
   Q==;
X-CSE-ConnectionGUID: LEuB4sejQzK1pj/84OdtsQ==
X-CSE-MsgGUID: MeewH/E/TLqcqyfudGIPyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43447018"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43447018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:03:14 -0700
X-CSE-ConnectionGUID: 7dDuA3tuRKaVKvMF/PytIA==
X-CSE-MsgGUID: ICsGBP4RT5yVJBvZI8J8Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="152929972"
Received: from spr.sh.intel.com ([10.239.53.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:03:10 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Yang Zhong <yang.zhong@intel.com>,
	Jing Liu <jing2.liu@intel.com>
Subject: [PATCH] x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures
Date: Mon, 17 Mar 2025 22:06:11 +0800
Message-ID: <20250317140613.1761633-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guest FPUs manage vCPU FPU states. They are allocated via
fpu_alloc_guest_fpstate() and are resized in fpstate_realloc() when XFD
features are enabled.

Since the introduction of guest FPUs, there have been inconsistencies in
the kernel buffer size and xfeatures:

1.fpu_alloc_guest_fpstate() uses fpu_user_cfg since its introduction. See:

  commit 69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
  commit 36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")

2.__fpstate_reset() references fpu_kernel_cfg to set storage attributes.

3.fpu->guest_perm uses fpu_kernel_cfg, affecting fpstate_realloc().

A recent commit in the tip-tree [1] partially addressed the inconsistency
between (1) and (3) by using fpu_kernel_cfg for size calculation in (1),
but left fpu_guest->xfeatures and fpu_guest->perm still referencing
fpu_user_cfg.

The inconsistencies within fpu_alloc_guest_fpstate() and across the
mentioned functions cause confusion.

Fix them by using fpu_kernel_cfg consistently in fpu_alloc_guest_fpstate(),
except for fields related to the UABI buffer. Referencing fpu_kernel_cfg
won't impact functionalities, as
1. fpu_guest->perm is overwritten shortly in fpu_init_guest_permissions()
   with fpstate->guest_perm, which already uses fpu_kernel_cfg.
2. fpu_guest->xfeatures is solely used to check if XFD features are enabled.
   Including supervisor xfeatures doesn't affect the check.

Link: https://lore.kernel.org/all/20250218141045.85201-1-stanspas@amazon.de/ [1]
Fixes: 36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")
Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 422c98ca6eb8..1b734a9ff088 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -239,8 +239,8 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_guest	= true;
 
 	gfpu->fpstate		= fpstate;
-	gfpu->xfeatures		= fpu_user_cfg.default_features;
-	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
+	gfpu->perm		= fpu_kernel_cfg.default_features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state

base-commit: d08c0d55110b7cbac186e5fa94b0c6d5f4d7905e
-- 
2.47.1


