Return-Path: <linux-kernel+bounces-173167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90C8BFC70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2371C22588
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8887E84038;
	Wed,  8 May 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9Ri9HLB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934C82D89
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168514; cv=none; b=OkvVDE6zjg+oc40b/QRoahX87kDBMv/N1zJ4+Ex3Z/6iMG045JYGmaRceNNPyq7fsNukwG7PSXDNGyZu8kX0J49PvARtIR/+knkHpfHwPGuJtPrzosw71mQ0Hy6qTg68GwT6e+lp5Juf4k5JLLBle0nkr9py9YwTDfHOkhDrlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168514; c=relaxed/simple;
	bh=CZStxRpkyFo0agaLyEf0iQ5LdPI9A9HxfUI2FCgu+2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrHil4rGvL0hFvBCk3st4yqLL7eOYQYxk/cvjJ9UBNTlVr8QpUP1w/f4m/1pF/K6rAnTqjV6nTrw0piFJmNfJ4h+ChkOnq39jtw5QI1jJTcAgJ3672sZQo8km1QQwDm+HxeQHQl6UtjAxWeRUdXWaadwI31moyEamZ0/IKjQkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9Ri9HLB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715168514; x=1746704514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CZStxRpkyFo0agaLyEf0iQ5LdPI9A9HxfUI2FCgu+2U=;
  b=M9Ri9HLB/bgReIoTDRBFZxwwSu9X+bEqpUvCm9x2n+Y7X3WBUUjz2ys0
   s3zTY5N9kHxf6cPu5cOCScg/OlcQ16YrYu02EKoezMRU77on5oRtVFqlj
   jBzXjQavepXcHfGD0TRhMBUkujX9XL3Zx7ZmIJXKtTG1nKpAnSay56d7K
   /xzjQQqqnI7SrM2fNrS0lHMzDidzbIOdmtJI5a8sphbPe/hcUpUDqHe+a
   gKLdG9oyi/Ep3rE0aXFI5GQNERohNkVjG9wGlMa3de5m3bLPOtbNNOMQ2
   RBYpT7butQ7GpDIEhKn5/3DfHf65s6MtR5wQHblv9yWkF0BCrbQAH9yx2
   Q==;
X-CSE-ConnectionGUID: J52T6nSPT4uSu8LIJmqW0Q==
X-CSE-MsgGUID: 6K8vMUSpT5avUk+qHGXJ6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10888988"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10888988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:41:53 -0700
X-CSE-ConnectionGUID: bhKoI+g6QVGwR4M1ZFtl0A==
X-CSE-MsgGUID: UXuw6ZbVRIGXKxVpkWjB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28731338"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 04:41:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A9A5D11F; Wed, 08 May 2024 14:41:50 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] HSI: ssi_protocol: Remove unused linux/gpio.h
Date: Wed,  8 May 2024 14:41:49 +0300
Message-ID: <20240508114150.958025-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hsi/clients/ssi_protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 10926359e6d2..afe470f3661c 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -14,7 +14,6 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <linux/if_phonet.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


