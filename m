Return-Path: <linux-kernel+bounces-573701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF5A6DAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BEF3A6151
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65025DD14;
	Mon, 24 Mar 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaYd0dMe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB62802
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822454; cv=none; b=B/0DCiwhAmE+M8HpahtwEPf7zLcVl+RpPXUEVtjIn6AsFRq/eMo/chWtUkghLJc/3VAN6fpUkZ+G1fppBvbDZeNrGdr6H+/TBjbBKskMlPFciSFrWa9NQH/IhDcGIBXUDkDAebXrFk1PTt8UqYCnCofdR6+31KVaJhe8d+kzfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822454; c=relaxed/simple;
	bh=LDryJ/koN5PVnpPfoeCZiSqHvm1q98AVVU3TBiTrOQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0jvZFBZZotx967bNXwaPoN+Kr5HL71jHiN0IyDiSugkC6qkhMZfSUju5RRoC6/n399FECO4TUHgsDub6H5hI3JfxZEQWuGj05DhoM1PbJOVa+8WFMbNxqJZ7g6uAGawrpEhcR/GdY39kgN/RQe5KgFnBv2B/TpSzY+H+VbIVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaYd0dMe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742822453; x=1774358453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LDryJ/koN5PVnpPfoeCZiSqHvm1q98AVVU3TBiTrOQc=;
  b=WaYd0dMeyZ3LlZjWnhRTGu6Nu/n2hJzEXsDRPQJs634yXWZ8UKHJ0AhX
   FCcW7YavxLnS77dwzLvkfAAL6zFTD5D+oKFJ8VHicvCjT5m8j5Ibzb98D
   NNed12Oq8BkyGIjid96TNvNnROtsu9igYQbH9sSX4kEvMqdHR6Ao7J2NU
   v4Hb4ee+ZwktxxTbf4tAlh4Nb8ys/48PpX1th5NoRkpKLiqyjgLmeUGhw
   2zjtLg45+RxY1XiWpuNT24U2m9KjbaFQKYhWytZkXRi80JrobnXALJgko
   Xje4oxd50mbfViFbIe0aIg/ObTKr+LMSk9WJtutMUBgJcjNHJjyQlK9mA
   g==;
X-CSE-ConnectionGUID: /valnXdvScOc9X/5+M0x/A==
X-CSE-MsgGUID: zhw6TCdfT529IprOMeKmfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54231069"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="54231069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:16:50 -0700
X-CSE-ConnectionGUID: 1/r3lys9Q4OR3UmlFyBOyA==
X-CSE-MsgGUID: PdzfmcdeRnW9AUASALfC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124059963"
Received: from spr.sh.intel.com ([10.239.53.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:16:46 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biggers <ebiggers@google.com>,
	Stanislav Spassov <stanspas@amazon.de>
Subject: [PATCH] x86/fpu: Update the outdated comment above fpstate_init_user()
Date: Mon, 24 Mar 2025 21:19:27 +0800
Message-ID: <20250324131931.2097905-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fpu_init_fpstate_user() was removed in

  commit 582b01b6ab27 ("x86/fpu: Remove old KVM FPU interface").

Update that comment to accurately reflect the current state regarding its
callers.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index b00e4032d75f..91dabfcaea20 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -516,7 +516,7 @@ static inline void fpstate_init_fstate(struct fpstate *fpstate)
 /*
  * Used in two places:
  * 1) Early boot to setup init_fpstate for non XSAVE systems
- * 2) fpu_init_fpstate_user() which is invoked from KVM
+ * 2) fpu_alloc_guest_fpstate() which is invoked from KVM
  */
 void fpstate_init_user(struct fpstate *fpstate)
 {
-- 
2.46.1


