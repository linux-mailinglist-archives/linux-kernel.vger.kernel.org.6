Return-Path: <linux-kernel+bounces-203494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A7A8FDC13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8DA1F250EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76315491;
	Thu,  6 Jun 2024 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ2OUvyy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1AEAF6;
	Thu,  6 Jun 2024 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636587; cv=none; b=blRfj75lcPGl+KLYcxIw2RJqSmx3ck0QjR8y8KcNkkZDTmCTIf4xAZYF9oLJ1J5fFdKgx+j8LiwJAVe4E0l4tsB0ssLdCQ2lCCD9Ogi5EjT8JovH93kVo1Ndv/5kk3gsi9Ho4TbkMl6whhkLbTWxPXG/ih+PrSRSzpsJ29cXe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636587; c=relaxed/simple;
	bh=TfmaVO+l4aEIjuvSlImdVeowS4ydIzxgF8BR8XbItwo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cv6A7MIsBJA93MjhR1AT59/enBj6fA36fz2WujUlWLYkXX8pcYrgiURse3Rrm3kbXcytWyFGL9bN2Q/MXbZGuNVudFgjWBwwPGE9qXkw3DQUPETQgbM/vuOi1LAerbVr77y0uinlLUR4EYuA+NKBTDsU+ucyLihtcolv8+8F0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJ2OUvyy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717636586; x=1749172586;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TfmaVO+l4aEIjuvSlImdVeowS4ydIzxgF8BR8XbItwo=;
  b=nJ2OUvyyYF5S+fbpz4FBWadDAVNCke9pQhle6MjyR2DXmI5ybH+rBDSQ
   p3GE7hTqVvo75vQe0z1rUxAlifUxFYSZrx/4QL2J7fWPCAyHExE2Qr1xW
   RKEGEigyPM6hjOayX/Ju0qLResOn9qeXaimDjGmlX/bEwqgINH/d2fLBQ
   0GL0cyJd66dWHs8f4X5Lz4du2wtbVD0R8Ameb16rtsWxkPUsKb3IF9QRm
   b45WqizwftXnR3rJoxNCumHm6xR7JvLwApRc0yLss1HzxD+Z6+Glao0Qz
   50U5JYo1jGyjjQOl2aMl9r6r+1RSSdF/aSonTGe16YehLDz/YRBwOOHym
   A==;
X-CSE-ConnectionGUID: rNul7+4FTbyIJzB1fxt0zw==
X-CSE-MsgGUID: vdT6yZ9ERUudCP+G96JUOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14084176"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14084176"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:23 -0700
X-CSE-ConnectionGUID: Yl9CsTPhSAWVRyVnhEU3/Q==
X-CSE-MsgGUID: TUCFoTDNRpW78RBX3Q2Fsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37889787"
Received: from mhlooi-mobl1.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.212.212.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:23 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: linux-doc@vger.kernel.org,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH V3 2/3] tools/arch/x86/intel_sdsi: Rework Makefile
Date: Wed,  5 Jun 2024 18:16:16 -0700
Message-Id: <20240606011617.557264-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606011617.557264-1-david.e.box@linux.intel.com>
References: <20240606011617.557264-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for more source files, rework the Makefile to handle
prerequisites more generically, making it easier to isolate future changes.
Also update PHONY targets.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - No change.

V2 - New Patch.

 tools/arch/x86/intel_sdsi/Makefile | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/Makefile b/tools/arch/x86/intel_sdsi/Makefile
index 5de2288cda79..47b6fd98372c 100644
--- a/tools/arch/x86/intel_sdsi/Makefile
+++ b/tools/arch/x86/intel_sdsi/Makefile
@@ -1,21 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Intel Software Defined Silicon provisioning tool
-
-intel_sdsi: intel_sdsi.c
-
-CFLAGS = -Wextra
-
+include ../../../scripts/Makefile.include
 BINDIR ?= /usr/sbin
 
-override CFLAGS += -O2 -Wall
+SRCS = intel_sdsi.c
 
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+OBJS = $(SRCS:.c=.o)
+
+override CFLAGS += -O2 -Wall -Wextra
+
+intel_sdsi: $(OBJS)
+	$(CC) $(CFLAGS) $(OBJS) -o $@
+
+%.o: %.c
+	$(CC) $(CFLAGS) -c $< -o $@
 
-.PHONY : clean
 clean :
-	@rm -f intel_sdsi
+	@rm -f intel_sdsi $(OBJS)
 
 install : intel_sdsi
 	install -d  $(DESTDIR)$(BINDIR)
 	install -m 755 -p intel_sdsi $(DESTDIR)$(BINDIR)/intel_sdsi
+
+.PHONY : clean install
-- 
2.34.1


