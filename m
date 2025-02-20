Return-Path: <linux-kernel+bounces-524402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B398A3E2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEE170103A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E820E003;
	Thu, 20 Feb 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgDxBYTZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5F1CEEB2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072821; cv=none; b=ISfOCvVI3KAQzNY0iJMQZX/pozHlo8Y3The5t35OEQX3srVPJAA5+JZMKWfklNE34h6BNIQOQImtKajCZ+fcF9zCRRhIydTkiEIw5NC3uJ2Gg+ouEDhScMXayAJ08mXuNIhP4gn2p+myVuPsjd+icS3t786H/M9QqCQrdBdSoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072821; c=relaxed/simple;
	bh=dbuwHJBNxpYNJ5MrycXe8mX1VtRsWYiMT043Qy3MLtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZDfZ/5VqrSGDyTZTUWcVyMH96TbIvMUWEzUnCRqDrm8FFHUZZZq/Kg/O01qTO+koqiqOpATANbEJIoXEpdMUnBxU4dNAklIZYBNZ4Ggz3XKb1AgXVKVojnw1/qhPp1DhpS0evYg+qa/2NjjW+k8UWE/d8Gm1SKw3xdzKRsrnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgDxBYTZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740072819; x=1771608819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dbuwHJBNxpYNJ5MrycXe8mX1VtRsWYiMT043Qy3MLtQ=;
  b=fgDxBYTZUBeeYpc93QvtVd2soEVCta9ujukaYCC0gM30IDpudMs9EDMD
   rI2wpPl48i6gUROiRLZidX4lM+mju81HhNXFtMk4aQRzbcKx83fLZRFwT
   mMeevu+oG0X1Gqp4eWTix68EB9TgPekKgt9w0pArkjcMYARxIJGtFwVc2
   7EymtHGhaLknnvMGmp0mYPG+AP1Wx2h3kFUfjoycJ0pBY6+pTAn/KSQnE
   /IC79nKqqqb67soZReSfImt2XrjUIclRZmQblpKureQotynrbewQygAE/
   rOn0P2cZ9l+GOfTPrMMChjXM4x+9kOXOrny4G3gbQ8FNk2CoxEnbiBTfL
   w==;
X-CSE-ConnectionGUID: wZjkjGKUT1y+Xrf12m5GuA==
X-CSE-MsgGUID: 9axaM8pNRyyueurHlq5k5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40789041"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40789041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:33:38 -0800
X-CSE-ConnectionGUID: d2u1NfQuQj+2QisgyghA4A==
X-CSE-MsgGUID: Ku4x6sndQBu0Mn31l26Aew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116004764"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 20 Feb 2025 09:33:38 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] io.h: drop unused headers
Date: Thu, 20 Feb 2025 23:03:05 +0530
Message-Id: <20250220173305.2752125-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unused headers and type declaration from io.h.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
PS: I'm not very confident about this but thought I'd give it a try.

 include/linux/io.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 40cb2de73f5e..6a6bc4d46d0a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -9,13 +9,10 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/bug.h>
-#include <linux/err.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
 struct device;
-struct resource;
 
 #ifndef __iowrite32_copy
 void __iowrite32_copy(void __iomem *to, const void *from, size_t count);

base-commit: b16e9f8547a328b19af59afc213ce323124d11e9
-- 
2.34.1


