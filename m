Return-Path: <linux-kernel+bounces-171944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A58BEB07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B0D1F21FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EB16D320;
	Tue,  7 May 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbbnKb3K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0516C87C;
	Tue,  7 May 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104874; cv=none; b=aoetPFY2Q7g8Osiyb7XXzY63wLvldGLdzvaI7pfy+gLkQJqvPE4gxdlmxdCkdPseV2NtYQq37fxwrY198zkDzixJu0tEviIM6cLXw9KynJwYH0q+cM4bM2hDWoGjNG/J+vKh67hpIk55rorojj2Rhq+gY/tWmOK5EfNRIXJjnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104874; c=relaxed/simple;
	bh=DARcSI+XMSSPhvXGuNN7vW8nfhZozRoGIw846BVcHu0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSBLYli4K8sTSbWW/E0sYkC3jGbN/ey749bKjKu9J02KdMeCQ/UTarf+nFEFecQd2QFFrOacIcNiLveGHkcZUzMOYuqSf08erMqcdyHK9+eUvb0fS/zW2iNxHY1BDlMPqPxTKTr0PzJCzy4gom14lTN/i3zN6WKCQKi9+GlrmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbbnKb3K; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715104873; x=1746640873;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=DARcSI+XMSSPhvXGuNN7vW8nfhZozRoGIw846BVcHu0=;
  b=gbbnKb3Kwbq6o+9WAN+OfP1DJoU1iB4OMmhAR8uLr81Duo0Nadu4+4CW
   L0I/jD6duEnZobZmOj94GnOsqJ9pDzkq6oOr8uMXosYADmuUG/7GaimoU
   D35eYmTg/yp4Zo53osW3l9mj/4yfyFOqUsIQQ1GpEOw33rWu0aptlKnC1
   muXhHFr0c3cekCWXhY6//kXRf0ehEXJJhyiamK4GXa7on4jPtObTYFNz0
   7OniUfVncdnqe9zFL9Zrg5TMUeZOdHjjCSYdySGO1uz6Y6hrchdIPySQs
   xvdGMO/U53BdOqJz8Q/iWZCZuY6BFv2y3Xc6/4us3f7NnGDTRiIqPxtKC
   A==;
X-CSE-ConnectionGUID: 6nhillbzSFGHS79vK4s46Q==
X-CSE-MsgGUID: dCKphWeNTi+iaT4jU2lWVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22333258"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22333258"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:01:10 -0700
X-CSE-ConnectionGUID: zFZLD8maTeqLw1vPEfzRSg==
X-CSE-MsgGUID: 59jVtVi3SqS9YN7Tigy//Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28491201"
Received: from sayakray-mobl2.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.212.130.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:01:10 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: linux-doc@vger.kernel.org,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH V2 2/3] tools/arch/x86/intel_sdsi: Rework Makefile
Date: Tue,  7 May 2024 11:01:05 -0700
Message-Id: <20240507180106.5218-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507180106.5218-1-david.e.box@linux.intel.com>
References: <20240507180106.5218-1-david.e.box@linux.intel.com>
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


