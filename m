Return-Path: <linux-kernel+bounces-388214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D209B5C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D11F24232
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1791DB55C;
	Wed, 30 Oct 2024 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyL9t6ER"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3C1CFEA0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271522; cv=none; b=UtQuds3VqX/53Jn3++HOpRg8SCpzp2+pkNNUQCMDXRF8aLDTGsL5PgpARWIj2nDBt6rbIeuKT03k+0DEiq/A77of7dD0SizlOj0oK+jjKiF68nB2115DHhorsiWfeO9qlndcGjBw4QRxBqYgO2xfUrBvKitOvGlo0XFfyF+jMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271522; c=relaxed/simple;
	bh=Ukw1AnWM+jT+fekcJrLCD9UNco+64k799Gwz4bNmYr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kdKEhRYSMQw/vx1ht1uVgbtyRlg8IuZ91/Ppe1vSR8q8EudsFWVPBTl70NFfrlc0C2fssz+PJyhbKg+e9ddw9R2/bSZho8w8chBKkcMKMsHWsj6Q99R8XqPKXRaeJUHG6UrMGy/4oBkmQ9e7952UFfdTKaxoUEgyrpyzldUq8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyL9t6ER; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730271520; x=1761807520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ukw1AnWM+jT+fekcJrLCD9UNco+64k799Gwz4bNmYr8=;
  b=WyL9t6ER/QD1XwR9YBmvHalj6ME0F4y6ttsHUjo2uR1d5TAWqhE91qnl
   hErzJ6EspcAtIxa+0o5KnylVS1TnRY1QSnIJixfOrRlY7/yiRvZzNIFhE
   mqnhrFjoFrAdInh1bgC1/Ly7RCEtN4mYO/UQv1epB0LBxd584JC1K8JTg
   IKyVrttiAs/cwC7yDgVx5sY3dTk52uyb8rAaaO5SDTnIIv+d8LXXZJ8W5
   kc9YU/NPLHqLj8qNoclT1fTRGNo79CB5z66nPlJr18tfifooN0nFj+0iZ
   a1+ApWHDI1QvEPyd3Qwadlp2TY40k+cfCFGkQVQ2WqsCJ2DT9TYE1R184
   w==;
X-CSE-ConnectionGUID: 53NzWLe9T92wuPwSdIoqng==
X-CSE-MsgGUID: tB69fKeTRTm/ROUk5D8vxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52516924"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52516924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 23:58:40 -0700
X-CSE-ConnectionGUID: MpzXH2ZCRd2u8Jrfd2RYRw==
X-CSE-MsgGUID: mkcO1FZAQaGp0k+jfmb+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="81769035"
Received: from jraag-nuc8i7beh.iind.intel.com ([10.145.169.79])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2024 23:58:36 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] x86/cpu: Fix x86_match_cpu() doc
Date: Wed, 30 Oct 2024 12:28:04 +0530
Message-Id: <20241030065804.407793-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reword x86_match_cpu() description to possibly what it meant to be.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8e7de733320a..82e5d29a04e2 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -6,7 +6,7 @@
 #include <linux/slab.h>
 
 /**
- * x86_match_cpu - match current CPU again an array of x86_cpu_ids
+ * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
  *         {}.
  *
-- 
2.34.1


