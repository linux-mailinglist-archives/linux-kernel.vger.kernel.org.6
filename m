Return-Path: <linux-kernel+bounces-199055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B008A8D8154
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AB1F2257F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46684A46;
	Mon,  3 Jun 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/moPXJ0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527284A23
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414474; cv=none; b=KDIC47ZGogsRI6pQl48EZdTXM3TVg9Ub0GTQ1MPLyXgrfrpYcBiwH5OjA5xGdJSbHEFD7xkPfPlQX4qVwzR6yRVFQqPN9pnGEWFhxAJfeHOapjASDzMV1bT+k2/4I5pXzQpsMdTX5104ZHLKVhdF0uDIEs9pUeuq01DVXCvS+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414474; c=relaxed/simple;
	bh=PYZ3fAE04wecLkCKNrUMiR9WFirhxYWu3OqH0XHIlAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ig+7HqLZudzBkYKLh6ggTusWGEOE9yBdhwsxb7uMD1tNbTY0FTHSTpVo1Us32XxzNViPRrIjeOMkhnd3NBqf2RIu34rRXRFNoBlHiqxKbHhkX0ns0tCNmpk0Z7stWPOGK4Ci93HLkvJ1agjGkebrHZFVxue0FPRZ5Vyx/cr3u94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/moPXJ0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717414472; x=1748950472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PYZ3fAE04wecLkCKNrUMiR9WFirhxYWu3OqH0XHIlAI=;
  b=e/moPXJ03Jf56LlEwXWIQMU6xEj2COsCht2HFqcldQp5M9cq4gvEOymJ
   iiXF4IDFoVkIb01VmebBbGlyDRs0nPtWS5e0H9pCbws/SvAN4ErhTbhhz
   BOqcaeeuwWQct2JzMjjpEWImKasFeWP/A4bPKPsh1lV31CI1HQxGaOpoe
   ZiSkpGw5xpPW1e66v84wSz2DfB2b1EydbgMJ+6iV3mWQQksPl5zk9zfFa
   jggXCeSOCQgVi9GX4kgDtBk0YAup5l8wtpFBCBq/2zYrzkH92Ttj5bJYn
   sjayeqx4forv6a8xNpxIMMtW55uMMaMIDV4dgbgszSgIgNnpXKiiG5aK3
   Q==;
X-CSE-ConnectionGUID: hibIbrRaTo+Elkghe77myg==
X-CSE-MsgGUID: BXcsZNM8QeWTUnfZ97JCVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13741856"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13741856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 04:34:32 -0700
X-CSE-ConnectionGUID: 6XvhOL2RRr+HfSf5Mcqyqw==
X-CSE-MsgGUID: jc1GOTNPRECClW8quqtyTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36837724"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2024 04:34:30 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] Coccinelle: Add api/list_move.cocci
Date: Mon,  3 Jun 2024 13:35:13 +0200
Message-Id: <20240603113513.48045-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use list_move(_tail) rather than open coding it.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 scripts/coccinelle/api/list_move.cocci | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 scripts/coccinelle/api/list_move.cocci

diff --git a/scripts/coccinelle/api/list_move.cocci b/scripts/coccinelle/api/list_move.cocci
new file mode 100644
index 0000000000000..c157a298cdf57
--- /dev/null
+++ b/scripts/coccinelle/api/list_move.cocci
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Use list_move or list_move_tail rather than list_del or list_del_init
+// followed by either list_add or list_add_tail.
+//
+// Copyright (c) 2023, Intel Corporation
+// Confidence: High
+// Options: --no-includes --include-headers
+//
+// Keywords: list_move, list_move_tail
+//
+
+virtual context
+virtual org
+virtual patch
+virtual report
+
+@rmove depends on !patch@
+expression E, H;
+position p;
+@@
+
+(
+- list_del@p(E);
+|
+- list_del_init@p(E);
+)
+- list_add(E, H);
++ list_move(E, H);
+
+@rmove_tail depends on !patch@
+expression E, H;
+position p;
+@@
+
+(
+- list_del@p(E);
+|
+- list_del_init@p(E);
+)
+- list_add_tail(E, H);
++ list_move_tail(E, H);
+
+@script:python depends on report@
+p << rmove.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for list_move()")
+
+@script:python depends on org@
+p << rmove.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for list_move()")
+
+@script:python depends on report@
+p << rmove_tail.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for list_move_tail()")
+
+@script:python depends on org@
+p << rmove_tail.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for list_move_tail()")
+
-- 
2.34.1


