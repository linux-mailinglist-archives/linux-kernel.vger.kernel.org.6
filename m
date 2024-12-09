Return-Path: <linux-kernel+bounces-438087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934F79E9CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EA41881893
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355C14D283;
	Mon,  9 Dec 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVU8bpCX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A7143871
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764098; cv=none; b=bVv/TqE4FGyNgZgj++y91YytBVc1gvojlzXijvyaLxnzT0nk/oRO4WeD/NZ1C2tLFnpR0yT42rUzaAXww4Cxk8uoYZ+gzCI7EDX6UPu7qR3ZBaxf5rTIQ+rzxOu03tQGG/fNAWE7Nklb7Yixc5sy4izs2sueOX2KWCNV4dGmSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764098; c=relaxed/simple;
	bh=+nYjogMqNb5pAlS2lqBICVPaY4egCS2awGI36Tub0mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYWEsiPjk2Vp8LfYBtKUUqV2vClpKtcvcaaX2jyjLMIibSqnanPrNmfh/seBecH3cpa3TuXh9QSellON0vHfMZLzK4RwHRhK/HwgEprCV5Ni4oP16u0KECSzHM6RcEqlWR66jCHju158Rbq2H5bkBDa9owIwbCV3BwIIhv0OaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVU8bpCX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733764097; x=1765300097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+nYjogMqNb5pAlS2lqBICVPaY4egCS2awGI36Tub0mc=;
  b=cVU8bpCXpxJAUWZUUM2hMezoLwx0yxfWllk0Z8wZAd2yMSmRkyFTrr4l
   7oMCyHu6RI2DWlMQ6waGbFGTBA1p+KXNMt6+ItCuAXDnb4Y1yN3HSez/g
   sbjZwsaxHPGUrdVZc8roTyioiB/KS7L5ING9hjtSLUIUQPz7zyOz5vKYK
   rHhR6a/bMtE5pRDUDGhubM0FAn+oBFszBC0boNdeQixYUc6S4eIbOcoea
   4iIx7EZ/n/f7NYNx46S5TDtFIozUNyV7QYQ9QTJVEdHipHCOyPFJpje7j
   Naxp0w3Lc76xkLxkceSBJ+dd535Pp7ix6/MBpP4nUVlJ7ONIIDIImMWQh
   w==;
X-CSE-ConnectionGUID: 6O4MtO9IR+SGW/B7QVvhQQ==
X-CSE-MsgGUID: nnoJC5CiTqySemX2Mk21wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33964384"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33964384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 09:08:17 -0800
X-CSE-ConnectionGUID: xKaIGYAqR5mcNHCvIZYz9g==
X-CSE-MsgGUID: AeGALsELSXybbf0Cxeg0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95610182"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 09 Dec 2024 09:08:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B63C144B; Mon, 09 Dec 2024 19:08:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] lockdep: Mark chain_hlock_class_idx() with __maybe_unused
Date: Mon,  9 Dec 2024 19:08:10 +0200
Message-ID: <20241209170810.1485183-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When chain_hlock_class_idx() is unused, it prevents kernel builds with clang,
`make W=1` and CONFIG_WERROR=y:

kernel/locking/lockdep.c:435:28: error: unused function 'chain_hlock_class_idx' [-Werror,-Wunused-function]

Fix this by marking it with __maybe_unused.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bb65abfcfa71..29acd238dad7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -432,7 +432,7 @@ static inline u16 hlock_id(struct held_lock *hlock)
 	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
 }
 
-static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
+static inline __maybe_unused unsigned int chain_hlock_class_idx(u16 hlock_id)
 {
 	return hlock_id & (MAX_LOCKDEP_KEYS - 1);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


