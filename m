Return-Path: <linux-kernel+bounces-417042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5A09D4E31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F65C283366
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE581D86F6;
	Thu, 21 Nov 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKiP7tqS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8274068
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197521; cv=none; b=s2anwWuWdojTW7JOxDlwzD/jkeEZ8qmrfOaFVlR/ndi/fGsPqIVAXPPMYUpLNFPQ5r8bP2j3AGnX2izjpdZTErH0j16mhrzkLMsFZZbfODHulVnX6pl7X6lSNUKadPkb0nW+TMOabG9xiukRC474rrVyTgihVIZURRbxxVSGAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197521; c=relaxed/simple;
	bh=1XDV6Qj7eyNs2FZm81waRioZ1tN6Wz3fQrqKYvnRq3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrXFFgdvBbM9tv1kT77+1w9o/iShKGAjh2FQKBFui4O9kjoZ8wuhS9vcdbr4fjqtlhW8WyV9p7mrYhJiBNSYpTbhthITMR0f21f45ziSH8pMmHnjLmZW89UtNqlyxZUNW/DtCPTWzfgVA0mMIzG5HgTIiSFKS6vfkhJiOjFlGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKiP7tqS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732197519; x=1763733519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1XDV6Qj7eyNs2FZm81waRioZ1tN6Wz3fQrqKYvnRq3s=;
  b=CKiP7tqSUAuzirssJ0JhRw2BZ5XOFkIk+S0RpVC1DcZxymm4a69Z+Woz
   Ggb/q0Mv+qdeHCSRnaLKlTxGYu6+OvKdrkF2zHMGOn8dh6i9UTtPPym38
   sD3NivjdhIp5wGDB4nzYj3h0GuDQu7xzaZD7rzna2b6TUwxR7gJDZGWry
   J88vk7GK+1tTfcwgMUDmaiNg/oQxEaGXEAFxZ7BCF0Yg2C2FSPnttqSqj
   U+c8y8Rj2C9LzNBfe5J2SabAb+FmQ3ToJfn4ZJVDudl9q9eH4Klq/OZIy
   57QMIYtImUAoeHaMkHA0j8q2UEtR59TV8n3wpBXZ+6tooDFI7rJIl8B0s
   w==;
X-CSE-ConnectionGUID: pG0UI7BfQVy5uSOxpfCHiA==
X-CSE-MsgGUID: /JN0+EbiQjin3jIUrJq5tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="49732496"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="49732496"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 05:58:39 -0800
X-CSE-ConnectionGUID: wpAzhqApSWqWuZlm0e00gw==
X-CSE-MsgGUID: 8Ul0LmMCSC6tv0pPYeQs9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="94706865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 21 Nov 2024 05:58:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1E9ED2CA; Thu, 21 Nov 2024 15:58:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v1 1/1] kcsan: debugfs: Use krealloc_array() to replace krealloc()
Date: Thu, 21 Nov 2024 15:58:34 +0200
Message-ID: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use krealloc_array() to replace krealloc() with multiplication.
krealloc_array() has multiply overflow check, which will be safer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/kcsan/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 53b21ae30e00..be7051d0e7f4 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -166,10 +166,10 @@ static ssize_t insert_report_filterlist(const char *func)
 	} else if (report_filterlist.used == report_filterlist.size) {
 		/* resize filterlist */
 		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
+		unsigned long *new_addrs;
 
+		new_addrs = krealloc_array(report_filterlist.addrs,
+					   new_size, sizeof(*new_addrs), GFP_ATOMIC);
 		if (new_addrs == NULL) {
 			/* leave filterlist itself untouched */
 			ret = -ENOMEM;
-- 
2.43.0.rc1.1336.g36b5255a03ac


