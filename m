Return-Path: <linux-kernel+bounces-424868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0C9DBA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5500D282495
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356171BDAB9;
	Thu, 28 Nov 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4f2V+0R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060D1B85FA;
	Thu, 28 Nov 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807566; cv=none; b=cSHrCEgB+u2oN5n7NYJFnM6qCRPXlaa5dZotnoqAOm6oaMe0TXFQyzQCDmxFeMQOwTb1Ov8c3sKRIrvv1HbHeBxtt+DJsoxG51xAdLCNFLpyHC+dC2yd1r2cmjjaijYB/khsq0r1bMLw9+wCRqn46mIFRryxtE8tpoYjkURG/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807566; c=relaxed/simple;
	bh=1ZmSgvBb2pwzdo6/2+ajRYrL3ptMyaLsPP92DvTk+ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Z5SIOdISKGws4zNyX0O7luZW4Sv4druSfPRUEX/1/GrbcjRZlP3vimRNkJ6R/sb2AituzZeZZGQ1iQ4D5KcDGEyFym8HnEEIOkyvPwKjqOEIdvrBEPkX1qO2/yGLWFFltZRlmD+hf8A1j2zbTui9uNRrwu3qD5pzyBPHM0Yyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4f2V+0R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732807561; x=1764343561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZmSgvBb2pwzdo6/2+ajRYrL3ptMyaLsPP92DvTk+ok=;
  b=U4f2V+0RZ8OATVAuG4cwxPVJ8uZpXktAJlK7fjNnO8k28OmaTJK1Ua54
   wCdOCoH/ibfv9v275HYJhSDVZOuBbhM5XkjAhmUOro74d9w6QXe9SOSpy
   oESgMV35UrNpOAGe2iYOcRsCtZjRWzszayMxYDKyU11ZiT1RCAHh4HR7s
   ZR2BzhBSxErUvVZmq6XXfUvgDfnmdL5V68E4Ioip9QaBrpYFs8cdD/Frr
   z5oPDnIhhVphN8M9/tijglJe+Tg6ZbTlRTzk9dBVDHhPiHlwhIIsfeEuJ
   /WYUGVzRuR/u2qG/K41rFJdMlff1qnUIkm2e/eFCvKTqczQwnFjoGUqXd
   Q==;
X-CSE-ConnectionGUID: OimlX63PRTeFSCvzDQwVKQ==
X-CSE-MsgGUID: iuRUHS3zSfqalAS8XxNohg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43711934"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="43711934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:25:55 -0800
X-CSE-ConnectionGUID: Jswr1ClCTRy57oZIJcfozA==
X-CSE-MsgGUID: 4top4WzTQCGRgcxwvRhuhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="123119571"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Nov 2024 07:25:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AFCA94F4; Thu, 28 Nov 2024 17:25:50 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 3/3] x86/Documentation: Elaborate Intel MID device list
Date: Thu, 28 Nov 2024 17:23:40 +0200
Message-ID: <20241128152546.2396782-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
References: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel MID includes several SoCs in the family, elaborate this
in the respective line of the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/arch/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 069073ecc87e..76f53d3450e7 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -754,7 +754,7 @@ Protocol:	2.07+
   0x00000000	The default x86/PC environment
   0x00000001	lguest
   0x00000002	Xen
-  0x00000003	Moorestown MID
+  0x00000003	Intel MID (Moorestown, CloverTrail, Merrifield, Moorefield)
   0x00000004	CE4100 TV Platform
   ==========	==============================
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


