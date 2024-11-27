Return-Path: <linux-kernel+bounces-423209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE79DA44D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF36B24E01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859018E76B;
	Wed, 27 Nov 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2jq3AjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334E1272A6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698107; cv=none; b=dXDuq/rNxYmmTbz2xRSnByLvFuMkjTigkTxKyAxWzs9jJx15BIOap3515dIZR5v0F3nL5y5Cnl8NMe7fgCiVXANLndxlrXN33yP2jz1uln3BW7gOj+pTYeR7+rRER3ZHIX/nO/AmONSVDmKMQf3vdmHcu9aPsdOK9Yb/K/ZqMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698107; c=relaxed/simple;
	bh=h3CMnL4eliTX9gzLSTV1y6gHQDFmYxmyCKxh3w3Jy2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwSasZaCed3xerWCPfxyGuYh1kCtiGKA8HIvGUyWVwQEcg/zVMTapl16q0X59qFQdkpqwf+uzoOPwsa9eOJaI5p1ff7sIHvp8fvVQAEIJt+CklmG5iQnJEbVIrSda/g0E1TDn3PpSZn0ZiPE44AWkJtn6VfUBL4+YQsFAmGRg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2jq3AjS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732698104; x=1764234104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h3CMnL4eliTX9gzLSTV1y6gHQDFmYxmyCKxh3w3Jy2k=;
  b=F2jq3AjS4JscjvEAH76sLXmrPob24LiasFc1cY/MfUUDZ2oKDaHS0pLj
   4MLf/vFbzLdl0qnzkZzXHxFWzu8+C190vCfVjVnTnXBEVzBv3HVNCgCfb
   d81S5cN00gCpiQEkKXwBNV0TarSrRy95vzRuMuNOJc6733j5YUgxJhv5G
   fAdiISDuP9kbG7pjwrrp0Rmgw7IaK4ykKXWrJ8Fzwlsa8ayc8lY5O1Oeu
   nX2+YzYxSi0xELauEgWMvvEGkRBKevRYJeT1h+IARvCNG3hKyhilg2Cn4
   7JuOshpdtYdcHd5C3o+6l5bEUO6q/li6pyHJjaGIAvMKnrsUGwjwVfPk4
   g==;
X-CSE-ConnectionGUID: gpDpnSeNQsacGbBD12bRxg==
X-CSE-MsgGUID: ricIz3tnTVi76mAzLB8Jkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32642287"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="32642287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 00:54:47 -0800
X-CSE-ConnectionGUID: gornYM1SR22nc/eA2n46mw==
X-CSE-MsgGUID: L7UM9o2cQUaYxolxdRcCog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91826973"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.103])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 00:54:44 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] locking/ww_mutex: Fix ww_mutex dummy lockdep map selftest warnings
Date: Wed, 27 Nov 2024 09:54:30 +0100
Message-ID: <20241127085430.3045-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The below commit introduces a dummy lockdep map, but didn't get
the initialization quite right (it should mimic the initialization
of the real ww_mutex lockdep maps). It also introduced a separate
locking api selftest failure. Fix these.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Maarten Lankhorst <maarten@lankhorst.se>
Cc: Christian König <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Closes: https://lore.kernel.org/lkml/Zw19sMtnKdyOVQoh@boqun-archlinux/
Fixes: 823a566221a5 ("locking/ww_mutex: Adjust to lockdep nest_lock requirements")
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/ww_mutex.h | 4 ++--
 lib/locking-selftest.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index a401a2f31a77..45ff6f7a872b 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -156,8 +156,8 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
-	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
-			 &ww_class->mutex_key, 0);
+	lockdep_init_map_wait(&ctx->first_lock_dep_map, ww_class->mutex_name,
+			      &ww_class->mutex_key, 0, LD_WAIT_SLEEP);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
 	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6e0c019f71b6..ed99344317f5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1720,8 +1720,6 @@ static void ww_test_normal(void)
 {
 	int ret;
 
-	WWAI(&t);
-
 	/*
 	 * None of the ww_mutex codepaths should be taken in the 'normal'
 	 * mutex calls. The easiest way to verify this is by using the
@@ -1770,6 +1768,8 @@ static void ww_test_normal(void)
 	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 
+	WWAI(&t);
+
 	/* nest_lock */
 	o.ctx = (void *)~0UL;
 	ww_mutex_base_lock_nest_lock(&o.base, &t);
-- 
2.47.0


