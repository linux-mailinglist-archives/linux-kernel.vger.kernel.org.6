Return-Path: <linux-kernel+bounces-349249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6198F323
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071201F22FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D21A0BD6;
	Thu,  3 Oct 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6ClPm1t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55515C0;
	Thu,  3 Oct 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970507; cv=none; b=mNnn8yN1alj8UUmm3Fnx/YYNqGFiZFQiGMTPMEJht4ZzlxgergIiZTvEFt8LoEjO1s3WZHkmXBOqjRpTggtnYyD3uz/DupHQCs/SJ7/M+kGfF1nUcIlEbOSKkVEo7wu4ZstE2GxQndU4fsVD0xP+auzJFSjwJef/XrGrKxEG1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970507; c=relaxed/simple;
	bh=qGXbnisv6FQgAAM8fUit3j5hUfQ7+LuzSJKnOXEgYDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIE6RBukpMUAblRdraTrveCjtGWoQhz5W+fHdn6iYQR501FfyFUWCwAT4aCa2tujnfwoNbT0x8K4KW4ggPXdRpn7d/EK8IchJTPJXWac0ZSbSMQmLNrbu1mvapC4KADbH+e22S0nx+Y58MIJ5o9VFzHa5FGhUXdSP8SscKw40JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6ClPm1t; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727970506; x=1759506506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qGXbnisv6FQgAAM8fUit3j5hUfQ7+LuzSJKnOXEgYDc=;
  b=Z6ClPm1tveThLa41w707SveCb7FYmE5LckeCm/f6aBquVxTdclNs4lrE
   9H2sOIHnGla8biVVo1C3cW//KpbhO+Crnoa+R4qNaCv/rzfVMkMtRP4Rm
   mr1gXrlkgHQtEOqA03nNE2YjjkWQm2VT5QqP9MaUAFv/0y26TIXboH7oz
   W35JuFLyJ0cXphh6qsrptM2P/Is0HIXjT2axb29IAu3cd9dQ5JOK2MDV4
   rNpayVd9DclgER/BQ+3F9pWSyqDnCGfegpMTXPxZVTTJsueBZU/6CqgGQ
   GFHWZa3T3z4GwIiy0dOaGET3UsiZoKQSSF4MOCqlTR156pRFiASBMwzsL
   A==;
X-CSE-ConnectionGUID: Tl8FiOE7Qkugl8BAqqPNAQ==
X-CSE-MsgGUID: sKzXEZSqRTy1FrUkMkeaHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38560815"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="38560815"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 08:48:25 -0700
X-CSE-ConnectionGUID: vZhBdgaZQNCIIu8ev34sUQ==
X-CSE-MsgGUID: yedSlvxLSjmlX8mVsPepXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105235383"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Oct 2024 08:48:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F3F637D; Thu, 03 Oct 2024 18:48:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: intel_scu_ipc: Don't use "proxy" headers
Date: Thu,  3 Oct 2024 18:48:19 +0300
Message-ID: <20241003154819.1075141-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/x86/intel_scu_ipc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/platform_data/x86/intel_scu_ipc.h b/include/linux/platform_data/x86/intel_scu_ipc.h
index 0ca9962e97f2..b287627759f7 100644
--- a/include/linux/platform_data/x86/intel_scu_ipc.h
+++ b/include/linux/platform_data/x86/intel_scu_ipc.h
@@ -2,9 +2,13 @@
 #ifndef __PLATFORM_X86_INTEL_SCU_IPC_H_
 #define __PLATFORM_X86_INTEL_SCU_IPC_H_
 
+#include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/types.h>
 
 struct device;
+struct module;
+
 struct intel_scu_ipc_dev;
 
 /**
-- 
2.43.0.rc1.1336.g36b5255a03ac


