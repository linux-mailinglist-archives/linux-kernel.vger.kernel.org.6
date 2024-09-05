Return-Path: <linux-kernel+bounces-317576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29A96E09F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3F928586E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73961A08D7;
	Thu,  5 Sep 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1sx1Y/d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6719DF68
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555559; cv=none; b=K8i2hS+ugCWIGgeDSdS2DjV0x5nm0al26w+spDj9f4Lr7yEAAwdiKIKdfZ6G91CxDfZWAJgHPQ1L5NRB2GBOV1HmrmnIrmjT9zMu+Hw2bY0r0Sq7w88Eb4D6MkvXx1FyHy4VDp+5G+p7BdRxBrC/C7rfa7RujijdOVJept0lplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555559; c=relaxed/simple;
	bh=8yPNk1w6gny+tyTSZwwdgp4V17bpRWxeXnuihEyS1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uo0/9uW9Kfi/V8AM/HUL9bjrHgCDLpwr+Exad7GNpL1YaAkuFY80WYfNhyC1TDGHYLdthM2oUBE7Eq7seDzIJ1lB+Wp+sn04JKafHo6of/a7n7slm5jW0YucZxzRwMoiTHoyB0+Eo151NRY5Z6ScQBMEOW/6nbFwLl55zelPVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1sx1Y/d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725555557; x=1757091557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8yPNk1w6gny+tyTSZwwdgp4V17bpRWxeXnuihEyS1DM=;
  b=a1sx1Y/dGNmxDD5R1IljJ/MuMjlFPBhaCPdgI/7sv07AvrvaSl5pbkDX
   aiWZ2zDRmWMghLL6HFtQ3iE0b8f5eHGssE28JywSxlZKVtZCozJKuXKUi
   AErxC8wVii+YWsU+ssY6rst9E31PsiEuViU0AuQyTJunzl2pNgQUM5kEW
   6HY47jjRrh/nCQWqKEhN0up5nVKYHQSvZjb93uzq7eiK6CDThQVhCJ811
   1uCyF3hHlNeqs8rlPj5pgaw3bcjRa+P7357zifctTQbq/oTTWATtuXATr
   PkHhNO6735VTx4cXMJHgrOjvBQt8X8LQm6T2ggL1JZiNUnxzOYterT0lJ
   g==;
X-CSE-ConnectionGUID: kW1bsTctSOGbR1CZNEdJnw==
X-CSE-MsgGUID: RUZ+0OqtQbu7ibK1f9ztyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23844557"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="23844557"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:59:17 -0700
X-CSE-ConnectionGUID: DjP+8LrTTDyfKrNO6OT1VA==
X-CSE-MsgGUID: oaruv8hrQ/+1q9Ii9qCilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="66419963"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Sep 2024 09:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B616F31E; Thu, 05 Sep 2024 19:59:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] x86/cpu: Mark flag_is_changeable_p() with __maybe_unused
Date: Thu,  5 Sep 2024 19:58:58 +0300
Message-ID: <20240905165859.254387-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flag_is_changeable_p() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
  351 | static inline int flag_is_changeable_p(u32 flag)
      |                   ^~~~~~~~~~~~~~~~~~~~

Fix this by marking it with __maybe_unused.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..20051f99a253 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -287,7 +287,7 @@ static int __init cachesize_setup(char *str)
 __setup("cachesize=", cachesize_setup);
 
 /* Standard macro to see if a specific flag is changeable */
-static inline int flag_is_changeable_p(u32 flag)
+static inline __maybe_unused int flag_is_changeable_p(u32 flag)
 {
 	u32 f1, f2;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


