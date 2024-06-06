Return-Path: <linux-kernel+bounces-204728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A58FF2D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C64628D2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9FF198A22;
	Thu,  6 Jun 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoAEr9kp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DD1E87F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692573; cv=none; b=D759rvuBbw0HEJhr5MswFZsOFLpUvWmXyKjB4mpZ7Hl7MKbVBPk/tFx/cz+yWMVvhDPHE9CwjYKW58S69RdYr5UZ0eO06ABJSJHY6hxyETW9OtIcQjFyfd/YN/GcxeHvAbFDZ8DGJsgZIGKlflTAU8hWnWwp48vZbIk1hvfsYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692573; c=relaxed/simple;
	bh=XrBEvZfrYy08JDfr/OU9rx9z8n2umQxHa8nO92Cbhdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvtkI4y2SyqRXqqvwusThHeXhOgTh6WgM2+cNbNtZcOsz2XZ3JHEvYCanCBw/avhLrhLUSYbMvZrdD8XExMlVSyjVEY2vC411JGCBfMiDjo6KH218hTwzblvicote4TbCj/k6P9AX8P38aU+fCaJfKZgc1Dz488iJKpP05kwW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoAEr9kp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692572; x=1749228572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XrBEvZfrYy08JDfr/OU9rx9z8n2umQxHa8nO92Cbhdk=;
  b=VoAEr9kpApU1q582laZbu4lq7zqFn5Mvd+0+aJMK2mIe9Svlaku4qM0z
   gPkmrjkfeG7pyxRrUs1SEP/Vzk7GjfQ3B4BfVJJTl4DH3o6iBtMvBMPJu
   w0pk0YPIC7xsy7ogDl17anKr/vZQOW8TMRYJAz4ZAg+hpbfq92HJsjFy7
   gMd+hTsHSlr8bDGdEs5b2xKSaiIa7cr4b3kHHTrpmA6LfRfxOgYgVwTpA
   Wj/yfSXdEBswJs2KRbN4ZHtftCLHtqDj2V4w1mI2t8i9qnHaMHkGMJiFv
   MIPJ8NFTt5HufObeBXvMbS60iLD1VKG4FGuZa9ClFqg/svxMquWJw38CA
   Q==;
X-CSE-ConnectionGUID: WLrFTqa4TlKRB5OWg6M8kQ==
X-CSE-MsgGUID: Wr9pzzZvSkmE0UO4ALRgIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25009124"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25009124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:49:31 -0700
X-CSE-ConnectionGUID: JtxuEEPEQ3GcFCd72RNG1Q==
X-CSE-MsgGUID: 1zXWF+XFQfyLsRDolKvR1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38591513"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 06 Jun 2024 09:49:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8A7C92A4; Thu, 06 Jun 2024 19:49:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] driver core: platform: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:49:26 +0300
Message-ID: <20240606164926.3031358-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index de89d8ca7cec..0ac3c7fa7f94 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -643,7 +643,7 @@ int platform_device_add_resources(struct platform_device *pdev,
 	struct resource *r = NULL;
 
 	if (res) {
-		r = kmemdup(res, sizeof(struct resource) * num, GFP_KERNEL);
+		r = kmemdup_array(res, num, sizeof(*r), GFP_KERNEL);
 		if (!r)
 			return -ENOMEM;
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


