Return-Path: <linux-kernel+bounces-184260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFE8CA4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273CE280E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40413B5BE;
	Mon, 20 May 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEySrn86"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF613C831
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245214; cv=none; b=k7xwZsy8n3M8QatIfPttGmwkqtHY67WX3iK/XfX6xj4l39FY1Nt6XU4DG6zpZHvRPGehrmFzljd0+9GirL5yWegmHKZnZmLjnNrLNBXFcWh9bFT0aIbyKZv2rEtyqhXrjNKcK6i5TL/P4fMwcWeepMeUrXXBe5rnKknoRY2ZwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245214; c=relaxed/simple;
	bh=fYJHYz8V9kimHRbxD5uVEAotpDMXkQsRHlaEWk/P2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPA1YSCy5qxX8o/KOmlyEz4MerfF6IxfBORhC6wflEfOE1mwL+PCex135SQ5bM3F+GRMEnxMD1WOWoJApbPBPNRkpWcYzbgDTZFZMWzRwHd2Liro6pFYI4RezjWYIvzAbqTt30W+Pt7TOHZaV+RR1sZQmf71g9qr6ZhV+FazeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEySrn86; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245212; x=1747781212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYJHYz8V9kimHRbxD5uVEAotpDMXkQsRHlaEWk/P2XA=;
  b=KEySrn86dwqsyzijLjpllKbgsN4B7EkzHVd22rN37+erin7YEAmpVuxE
   VVFgNgzX0ANMpMjhPsCZpG0qZRJZyrD2V/2W8ceoM7BsEQ8AqtAbR3Gal
   jAZJqXFVqG1VAEkJUpsnH3KTb05vS93Ye8snP2YLj6QXACv+HMhOcAd7/
   MlDlCdhaeXbhf3iGdtrA0tB3kl2CcPLhb5uFfv7ibmIpgGSmx/1F+9H5D
   HSypnbYSBeuVh3Ak2A+vpo6spvCYZC0YEMYJdtzNPHQaDoUoFzWbOcUk5
   OrcCeIagdnFFIVZWfjejuRaG/bRSml4PvYEEmaspmABzRPHk6Mg/1s94w
   A==;
X-CSE-ConnectionGUID: 2XrwvG6vSFWm0Hu/LmZxhg==
X-CSE-MsgGUID: NyeKR2a6T7W+/GHC7RLfsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199855"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199855"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
X-CSE-ConnectionGUID: UK2mgWJFRYS6AmhMecX+Iw==
X-CSE-MsgGUID: ElbWYlQcQlKP46GzimvXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593479"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v6 32/49] x86/platform/atom: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:03 -0700
Message-ID: <20240520224620.9480-33-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/platform/atom/punit_atom_debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index 6b9c6deca8ba..44c30ce6360a 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -165,14 +165,13 @@ static void punit_s2idle_check_register(struct punit_device *punit_device) {}
 static void punit_s2idle_check_unregister(void) {}
 #endif
 
-#define X86_MATCH(model, data)						 \
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_MWAIT, data)
+#define X86_MATCH(vfm, data)					 \
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_MWAIT, data)
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	X86_MATCH(ATOM_SILVERMONT,		&punit_device_byt),
-	X86_MATCH(ATOM_SILVERMONT_MID,		&punit_device_tng),
-	X86_MATCH(ATOM_AIRMONT,			&punit_device_cht),
+	X86_MATCH(INTEL_ATOM_SILVERMONT,	&punit_device_byt),
+	X86_MATCH(INTEL_ATOM_SILVERMONT_MID,	&punit_device_tng),
+	X86_MATCH(INTEL_ATOM_AIRMONT,		&punit_device_cht),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_punit_cpu_ids);
-- 
2.45.0


