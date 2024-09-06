Return-Path: <linux-kernel+bounces-319107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AA96F7CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1176A283A43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28D1D278F;
	Fri,  6 Sep 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVttSJKZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CF1C8FBC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635140; cv=none; b=pWK+C5uEK1JsQ1KQlAq0x8xgMzsE/wKB0oz2hR9Rc8xLINWMHiQN2YdcY2Es1DmgWGFNM10WKku0/w1kPs4pG3/tuik9HU8kM4QUTT2aZASQxRhxvrE0G3cRVWisSREsheGm1lXXzaGF2UkSEfUDOdrtSkG12eTdx9QmMEM0bzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635140; c=relaxed/simple;
	bh=6UvkPauj8ELcrdIfoXv9+128GHjrOlHpvqYEJldyrq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxd3T0RLRNYQolFzEoHknvNYcLjpM6c6Jr/ejCKMTc1c4vmRGDvxuZeW5TsYq6sMyeap2bMjBEL0pgFiJf2ciSCWMyBEsWktMxDP6OKrlXd1Gt6CyYHy0KYn5r4nYrhQH+2pJS63gFrV5fe9D/jrrSSaAWtsWxUJsFC0SiUr39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVttSJKZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725635139; x=1757171139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UvkPauj8ELcrdIfoXv9+128GHjrOlHpvqYEJldyrq8=;
  b=XVttSJKZmEAtiddpYzKtcV2Ad4JiMN+nfxP+qMBrV7SVd+zdILC+DvDT
   yTzQ7fxcm1S6RbHKZGMTDxQym9q6NzLfbBN6HN4oGJE6vCj9QPcDJnckv
   HiE1gcV2pPoQgfSJpmkF58wW/zsZyoD8Hng+p4M7Hzhj62GNjTZaMTmPY
   muPZXza26eokdn4CaX9NzuUJOCiRXLkevAC69GwvhJXVz+zXL5zG890GW
   e7dfhON4AmxgqlEqki7cbhdbgtrUtcpWWaAygIUogx7dWyQ6Qrfv6miCx
   TX0DakicKvHHti+27fu01DFDBhh0vSaehblZMtzZoBbBKoCSeP3MIiu7M
   w==;
X-CSE-ConnectionGUID: hUCQ6GeRQLqJAfUZ7T67xA==
X-CSE-MsgGUID: HfVdpZqmSniufVUxVlxzKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="27322417"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="27322417"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 08:05:38 -0700
X-CSE-ConnectionGUID: 1qsvXPyESNCCCs30gWg0SQ==
X-CSE-MsgGUID: p3OGA9HpQGaybT1wEsCD/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66727029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2024 08:05:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B942213E; Fri, 06 Sep 2024 18:05:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Date: Fri,  6 Sep 2024 18:05:33 +0300
Message-ID: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few functions defined but not used. This, in particular,
prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:

lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
  351 | static inline void *mte_set_full(const struct maple_enode *node)
      |                     ^~~~~~~~~~~~
lib/maple_tree.c:356:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
  356 | static inline void *mte_clear_full(const struct maple_enode *node)
      |                     ^~~~~~~~~~~~~~
lib/maple_tree.c:361:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
  361 | static inline bool mte_has_null(const struct maple_enode *node)
      |                    ^~~~~~~~~~~~

Fix this by dropping unused functions.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Fixes: 6e7ba8b5e238 ("maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean up")
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/maple_tree.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa3a5df15b8e..f7601aa470e0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -348,21 +348,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void *mte_clear_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
-static inline bool mte_has_null(const struct maple_enode *node)
-{
-	return (unsigned long)node & MAPLE_ENODE_NULL;
-}
-
 static __always_inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
-- 
2.43.0.rc1.1336.g36b5255a03ac


