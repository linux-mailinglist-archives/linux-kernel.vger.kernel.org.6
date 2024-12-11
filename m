Return-Path: <linux-kernel+bounces-440607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E39EC1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4AF163238
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453A13CFBD;
	Wed, 11 Dec 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es3Jh81c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4917736
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881338; cv=none; b=Kln4xs0fb8kdOrkjuOHyIgS7TPZqvk68qu6fec8+fuBFAMhqSfMc40/w/F2SD1bmKgjvB0YjOGFNrAEklUWglY/N+jJDgcj6qjexGBDAnUrisQkgJ2/OSSCoWI3fVOreGFjonxkPQvxFZFOoeDCT0id/qHh2W81nfF6vMHut650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881338; c=relaxed/simple;
	bh=57H56OVlleoffXbP8jWPOJE1INbC7Zl4KRINZxyt8to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftIkYgJDTA6tg+SGWOnm0ufS/+t8aAnY/NyIAt56tXldurdp6v+CqVhPvPo3uUKz0uHkbadDNyFicB28aZ3nj4K/Px8oUWwlPe1AeDv3pdS+5UC+0CZnA62+1wUvIxKlB53qi+yws56vEM4rYvkexftyN+so9tDDR5vHaw5/85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es3Jh81c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881337; x=1765417337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57H56OVlleoffXbP8jWPOJE1INbC7Zl4KRINZxyt8to=;
  b=es3Jh81cAu37pgvTvtMY49kAFwi47DoxKs+iHRHBQ88MaIsNeCMJ87u3
   pyLnLsFaWUq20eJ2dIHGcENEgfSkhJpo9ns5FtnMuuS+6Gj0XOiZgvxvD
   T9ezLwHfqD/THmllZAjgup4Ld92wcxoOa3aZy19dhSToipyxaWDKGb6Bc
   msOuom5OZyluihP6jatjVXhkQoMxf11DpZHtu5mc0l2cSSpvG463h7KF7
   ZyEoNu/iMlG6qJO90CzLvdZW59iRDMYrtwjkaSzlE2laJoE+ZgAVXY6IK
   36v1OsMRZX+H82J3OaC4PK36YcAci9UB9maTdj1PRADsItei8r76M7d78
   w==;
X-CSE-ConnectionGUID: T4p9rAkaThGZjehCkrhT5w==
X-CSE-MsgGUID: qTUwBwOrSmK83Jw/ifejeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570538"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570538"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:16 -0800
X-CSE-ConnectionGUID: f1c19SwZSySpZPj7PuLP0w==
X-CSE-MsgGUID: EecU6/u6RmGHy9WNgEslKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051726"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:15 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 1/6] x86/microcode: Introduce staging option to reduce late-loading latency
Date: Tue, 10 Dec 2024 17:42:07 -0800
Message-ID: <20241211014213.3671-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211014213.3671-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As microcode patch sizes continue to grow, the latency during
late-loading can spike, leading to timeouts and interruptions in running
workloads. This trend of increasing patch sizes is expected to continue,
so a foundational solution is needed to address the issue.

To mitigate the problem, a new staging feature is introduced. This option
processes most of the microcode update (excluding activation) on a
non-critical path, allowing CPUs to remain operational during the
majority of the update. By moving most of the work off the critical path,
the latency spike can be significantly reduced.

Integrate the staging process as an additional step in the late-loading
flow. Introduce a new callback for staging, which is invoked after the
microcode patch image is prepared but before entering the CPU rendezvous
for triggering the update.

Staging follows an opportunistic model: it is attempted when available.
If successful, it reduces CPU rendezvous time; if not, the process falls
back to the legacy loading, potentially exposing the system to higher
latency.

Extend struct microcode_ops to incorporate staging properties, which will
be updated in the vendor code from subsequent patches.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
RFC-V1 -> V1: Rename the function name to the do_something() style (Boris).

Note.

Whether staging should be mandatory is a policy decision that is beyond
the scope of this patch at the moment. For now, the focus is on
establishing a basic flow, with the intention of attracting focused
reviews, while deferring the discussion on staging policy later.

In terms of the flow, an alternative approach could be to integrate
staging as part of microcode preparation on the vendor code side.
However, this was deemed too implicit, as staging involves loading and
validating the microcode image, which differs from typical microcode file
handling.
---
 arch/x86/kernel/cpu/microcode/core.c     | 12 ++++++++++--
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d11e7b6..0967fd15be6e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -676,19 +676,27 @@ static bool setup_cpus(void)
 
 static int load_late_locked(void)
 {
+	bool is_safe = false;
+
 	if (!setup_cpus())
 		return -EBUSY;
 
 	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
 	case UCODE_NEW:
-		return load_late_stop_cpus(false);
+		break;
 	case UCODE_NEW_SAFE:
-		return load_late_stop_cpus(true);
+		is_safe = true;
+		break;
 	case UCODE_NFOUND:
 		return -ENOENT;
 	default:
 		return -EBADFD;
 	}
+
+	if (microcode_ops->use_staging)
+		microcode_ops->stage_microcode();
+
+	return load_late_stop_cpus(is_safe);
 }
 
 static ssize_t reload_store(struct device *dev,
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 21776c529fa9..b27cb8e1228d 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,10 +31,12 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state	(*apply_microcode)(int cpu);
+	void			(*stage_microcode)(void);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
 	unsigned int		nmi_safe	: 1,
-				use_nmi		: 1;
+				use_nmi		: 1,
+				use_staging	: 1;
 };
 
 struct early_load_data {
-- 
2.45.2


