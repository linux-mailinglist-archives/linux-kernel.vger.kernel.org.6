Return-Path: <linux-kernel+bounces-564876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E06A65C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25533882D23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1571E1E00;
	Mon, 17 Mar 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEa+AA6B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC51D07BA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235260; cv=none; b=jGzJ72mg8h6IPVoCb3avERndZfLR1jcS7jyfRrPz2lOGGBebEWCBmLc2qngqdt8Gyo/bpyWEt0R7m5WzZUkBOEXp6foxe/1KprAVWp35OGXovyi33FpVgsAG/XhSCJPMvk40uzf+djz0mThL/fD9Mw5mHDrbgYvWms4aLorU3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235260; c=relaxed/simple;
	bh=auDF8pytR5WTTccWarG/xxoAvGkcFr1uIFpDCwwFW/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzXr5KvEmRgZgOt3xxWnuWf1/Ftyh+TCWCJYSYMeYdrW3JROmyJL0vHvdf+8/gXtP/YSmSN0rVtOFH40FYdQR+wdzCV49inyHuxaU5DgWS1//jbxfVjo+YVbJW4TgHhSQ1/PnCYrEuG8488dR+O65oekd63Ts/I6/RTfDhGpGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEa+AA6B; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235259; x=1773771259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=auDF8pytR5WTTccWarG/xxoAvGkcFr1uIFpDCwwFW/g=;
  b=kEa+AA6BIsgvL6uQoq5yVoFBXPVAooNf4cxozaMw+dndw5VT7lrAGYaz
   h974LYljQH9l/fiTz6/irEWeDtmcD6A6N+jlwi/BuHf6iNap59gMIGzqg
   pr2glHbz9LNLZd4DNXTeaLeYDDf7BIsWNQOIJc+KdGNTlAnHbSrOfiT8H
   lWsczne6j0rvHO0VH2gToCs+H04Q4bbL9nuaYjfJTchbe2+2vGFRpSdEG
   90tf72oJ5PSaTzEG3a4tJ5jS3yw5wRBpfxR27EF83p7gInHLkv8nppFA6
   vnZK+DojcINegG4btzoWcKS12FDA4x0OQjBfuSllSOKTRPOIlbJK7GvGk
   g==;
X-CSE-ConnectionGUID: w9KH38/pSuGDwST/MOwZhw==
X-CSE-MsgGUID: 4qGuZ/uRQH62DzpHyQbRHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43259465"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43259465"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:14:17 -0700
X-CSE-ConnectionGUID: vdKwKoExSaW+DJ6IR1WWuw==
X-CSE-MsgGUID: IFett5jdTry55XvzbApmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="153007719"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 Mar 2025 11:14:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 156BFDF; Mon, 17 Mar 2025 20:14:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/4] resource: Split DEFINE_RES_NAMED_DESC() out of DEFINE_RES_NAMED()
Date: Mon, 17 Mar 2025 20:11:10 +0200
Message-ID: <20250317181412.1560630-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
References: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
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


