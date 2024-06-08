Return-Path: <linux-kernel+bounces-206890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28C900F5D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 05:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D202834DD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1CFC18;
	Sat,  8 Jun 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nW3AHYnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14420EB;
	Sat,  8 Jun 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717818180; cv=none; b=ayEFTii7QvyJijKG+1pTAX+c3dajkTRcQ6CtwNnpP4UWrGezeE5lO4vPruM8f16sxMLDTsyl9JonQY48XuVwf9UOhCBhB2mBKEur56fIVC6mzAMy/DmjHuIkBGpP16s71sqlj2QiC7Qzu8xbbyFTQTFy5Ofcpi94pnkuCZIIWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717818180; c=relaxed/simple;
	bh=35qLqY6ILBvFLrqxgWSWe4dmulow+DU3fhDcGyF6m2Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTdjemo2uQFNF7yk77GqxPcsC4f+fuwdxo6iSg9lSuZm0iKwp/JuXZBYE43n/E3hShFcxdE/t+x50DbnakQ3THi9c6UjzvCr5Iitnu0+wvpEKNFL89Vw/OREYy5FMJgQKqDxEPa3KcTHUEDe2+ap/qw5A2Fgx8nMet0o8cRzkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nW3AHYnD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717818178; x=1749354178;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=35qLqY6ILBvFLrqxgWSWe4dmulow+DU3fhDcGyF6m2Y=;
  b=nW3AHYnDteMMIOQgbrsGDNYpXrBvOgZrftC7caGexXrYklym8z6J5sVw
   sFDQ5+9aa372kt3u+DkqYIFDoE/bT6NlMqyXcKz0mhuFRVgpWQak22Bit
   4s/m9fyJKBga7qncovYrF8/yTSG4b5LeDtvrFu+/Hw0suFlQWeTfO9gNC
   b5a3KclJ6ne0jVLIqO+Jai+GQu4gS5LoS94MjJbEE4WAjnKRdwZEp0o+o
   xHB0TF3d/xfw0GhV502XOhHQetsP7K6Z5oQrmHGDv78uPzRtriQBoZoiN
   ZzvKWOOCl5VxQFPjpvNI5R5EjyqhBxHMv0wWW37q22w5K3q7ZqNmkEQnm
   A==;
X-CSE-ConnectionGUID: 0LcwAikTR1+2U0DPcSXtMQ==
X-CSE-MsgGUID: Czdt1aOTRCOq1WKOqJh05g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="17483284"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="17483284"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:42:52 -0700
X-CSE-ConnectionGUID: Hgf2f9y5RTSVh/9aNfMNtw==
X-CSE-MsgGUID: M02GoYSlSm2YNU88KLZM6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="43461677"
Received: from lbattagl-mobl1.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.209.70.26])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:42:53 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: linux-doc@vger.kernel.org,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH V4 2/3] tools/arch/x86/intel_sdsi: Rework Makefile
Date: Fri,  7 Jun 2024 20:42:46 -0700
Message-Id: <20240608034247.181843-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240608034247.181843-1-david.e.box@linux.intel.com>
References: <20240608034247.181843-1-david.e.box@linux.intel.com>
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
V4 - No change.

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


