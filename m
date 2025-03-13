Return-Path: <linux-kernel+bounces-559923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423EEA5FB31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E0882496
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F226A0BE;
	Thu, 13 Mar 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CULB3Q+g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33D26982F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882186; cv=none; b=TrubCSlJWLIxwawfdcyiEaVDsKehjB1yfdFb9vSihZ1t0p7K9ZKaOyWCwQAvSwR6U56922I+pkL+fTTe4xjqpBTjUHnvbzFfG0FMu1lPbd7D/hKL1iy92k9fyuj2Eo5L6aYFFKZLnqNB8r6xH/MinLUy+pC7WTz9tmuiFG+8eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882186; c=relaxed/simple;
	bh=auDF8pytR5WTTccWarG/xxoAvGkcFr1uIFpDCwwFW/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elOwG3z8+pHV1yfSeZZphO7iie40XIBKFW6VvodYlijCbeSx0oEiohEVuwPISoy7U/jxtGEMjaRcYFa+z4nD/utTThUsvZUWMP/jCWZiSxWZUrHDFIkAEEvJdpRUwb87Mb9RscAWxzBCutGIOMZTHB6wRXXDkkTY+WHNey/aUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CULB3Q+g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882184; x=1773418184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=auDF8pytR5WTTccWarG/xxoAvGkcFr1uIFpDCwwFW/g=;
  b=CULB3Q+giYXfmNYAPx/HQmjUOjjfMTXgYNpBoeuL/ZV8ZY1qzqWeY/Ss
   IR83yelm05iFPVQzwr8M1e76VM0MxuI1ktGrLWcgfGu5a9POrCL1NPqTZ
   ODMAahiBJ+b+mU4TXsmN4bY9j/bd4AQmex4KiK5aplyKIk7YG0EX05dwu
   MqRkHlO9U2+0tGgw809ydwnQQGIvppsxPvJNT8rQSNlPV0q+kYpNfQUeP
   P+BEQDKKxl0EpflhTWxQ8rsPyDS1jDLrnyfWKkmz33RVRj6nKvmYvMVfT
   xsCBzBSFNA9mcUesZAzeEJOP3cdOH3/zJvSqs/cAX/uwRU5kaXVaOQICY
   A==;
X-CSE-ConnectionGUID: 2fE0aTj0QFaP8FDK3XsPtw==
X-CSE-MsgGUID: QWm9kfbWT6er1zc6zmzRYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42180080"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42180080"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:09:44 -0700
X-CSE-ConnectionGUID: WEaF+s9TQIq3YIGyERoBmw==
X-CSE-MsgGUID: XPW1XPnFR0WP1sMZz7eBrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121497333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 13 Mar 2025 09:09:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 94301156; Thu, 13 Mar 2025 18:09:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] resource: Split DEFINE_RES_NAMED_DESC() out of DEFINE_RES_NAMED()
Date: Thu, 13 Mar 2025 18:09:40 +0200
Message-ID: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases it would be useful to supply predefined descriptor
of the resource. For this, introduce DEFINE_RES_NAMED_DESC() macro.

While at it, provide DEFINE_RES() that takes only start, size,
and flags.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f437502224cd..a740aebc372d 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -157,15 +157,20 @@ enum {
 };
 
 /* helpers to define resources */
-#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
+#define DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, _desc)	\
 (struct resource) {							\
 		.start = (_start),					\
 		.end = (_start) + (_size) - 1,				\
 		.name = (_name),					\
 		.flags = (_flags),					\
-		.desc = IORES_DESC_NONE,				\
+		.desc = (_desc),					\
 	}
 
+#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
+	DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, IORES_DESC_NONE)
+#define DEFINE_RES(_start, _size, _flags)				\
+	DEFINE_RES_NAMED(_start, _size, NULL, _flags)
+
 #define DEFINE_RES_IO_NAMED(_start, _size, _name)			\
 	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_IO)
 #define DEFINE_RES_IO(_start, _size)					\
-- 
2.47.2


