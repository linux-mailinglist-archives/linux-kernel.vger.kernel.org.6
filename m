Return-Path: <linux-kernel+bounces-285814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64077951311
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A87B21AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA638DC3;
	Wed, 14 Aug 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtGol6g3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9B394
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606058; cv=none; b=Aaqnn+xYV88mLxb6Ao3tuhMGpkyMGBJfQ10yE4tCkzBE4uwUXiH8QNPTXmSvlGm9yNRHqn4pe96dG6eRqQt9+MqGI2KXQxbmsW2ojUfTi0LVhdP8lpG9nONgFmXT1RyBC3wllA2SV1YJKHRH4Yg9C78RTNG6fl+QbdSRljwCAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606058; c=relaxed/simple;
	bh=YRYd9bY2Wzo806pNQLg9GKUQZvbpH0wcIveOrzs37l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E1S/zbM6AzE4CagabDeOw33ocNcfcfu7Np2nHx4AySRkvzD9KOoVXH0Rl4rBYzEjGJQoTXsxwLNlKD5L3jT6E9qpILBzxbqQkqikiwG+g4fbgr2igKY2NLmCbMg1OJj4VQ9+Xl07hMU3fuI2v6KEkUswoYUmC2BI0tqFRQbhxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtGol6g3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723606057; x=1755142057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YRYd9bY2Wzo806pNQLg9GKUQZvbpH0wcIveOrzs37l0=;
  b=gtGol6g3tiPhOrD5saK+IdW+3hQQQdLTum4uLGeEnQ2bMvXNYG6gxoak
   pM7VBA/ZWQzGCysAw1kOAJw6/BZDvEt/7OHLQXUw/bp4bX8mh7UyMfkwp
   QglgdrJIY2ety9AddGae6r2BL3NruRxGooFLdn/YTheS6J/53G2bnZ7zl
   6vApFV+Fbvo50VQL/IcXcIYoiaeyj62Ug3bHxQsP0p440lfZRXo39y1pc
   NlU+8Yp7aoqGka+3iMpNExCFi0fxFm6CECxYgNq7Fi5XVFPcnVNGnDJgs
   hXBkl/9CurPV7gUwuVOb9eTIRN9zCine2jxpQapOc8cRVGlbe/Z4snqPX
   Q==;
X-CSE-ConnectionGUID: TOrD9mz1RsaJyDz81qJBKA==
X-CSE-MsgGUID: /NDXSrZCTVK4bd2i7BGRYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32376618"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32376618"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:27:36 -0700
X-CSE-ConnectionGUID: mkG/WkcnS66scPyRxjZMRQ==
X-CSE-MsgGUID: MCLxLJJvQE6DPdngtF0I9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58562953"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 20:27:33 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de
Cc: torvalds@linux-foundation.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH 1/1] x86/paravirt: Use static_branch_unlikely() for virt_spin_lock_key test
Date: Wed, 14 Aug 2024 11:14:31 +0800
Message-Id: <20240814031431.74015-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87o75wpbub.ffs@tglx>
References: <87o75wpbub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit

  e639222a5119 ("x86/paravirt: Fix incorrect virt spinlock setting on bare metal")

sets virt_spin_lock_key to false by default. Use static_branch_unlikely() for
virt_spin_lock_key test.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/include/asm/qspinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 68da67df304d..b6f336a227da 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -89,7 +89,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 {
 	int val;
 
-	if (!static_branch_likely(&virt_spin_lock_key))
+	if (!static_branch_unlikely(&virt_spin_lock_key))
 		return false;
 
 	/*
-- 
2.17.1


