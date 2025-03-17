Return-Path: <linux-kernel+bounces-565083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1882A66083
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C78A3B1E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA89201278;
	Mon, 17 Mar 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzvw45Cu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ACB1F583E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246927; cv=none; b=nPx+WPfZjZOuSX7+ibdQpjsYzSSOo73Nd9zDFiY2GFqpWTiZTwXUu2RUThig6YccSz4f+Qa0BNZHTbrLATbqP7pZ++mdl2gT2QL4cyK9RgEOvM5VkHuzl/Rya+Pd9ew4vukIyooRJG3gGriyLfLq8A1kr4zGiPLygn3Znn600yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246927; c=relaxed/simple;
	bh=t6gpFWlqxVlr56aYj3GwChyjcKy0WmrAhR9H5mEFpV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZO21HLo/gKdA83nXq3DffsPSCNZfHj0YFI4ans8YLbXKOy0h4I1kgJShn3LWfwXvFDAJRyEHDtwdbYRiJ5teINdnjK6PdHRZ8e7gQzMr9Yc6GnNlMKtU585JKJ3zXKun0L/d/dblJVTNP2Pk69U4Qi2dT8VbCCek8kFklMpVXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzvw45Cu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742246925; x=1773782925;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6gpFWlqxVlr56aYj3GwChyjcKy0WmrAhR9H5mEFpV8=;
  b=Tzvw45CumsWEtve6IPR/xqeOJnX56RZNEOCwpkECXOyuxCS+nhC64Ent
   qp22WOszY9nCIqRflgaWi4nrk5r8zdGxwwGzhJmXDxF/JwFLf3Io+Qaxs
   4SxT37tB2Tu8W2hJzKMZBnAOy6Na4EAajadlF8zYE/JvpKq49h/mc+1t+
   pFawt2MtkjK2cjZcWepH5eCB+Tk9hUJgV+IOORSSxkj0/vYr+su/nrU8y
   9epbLRPzH68918kOAQicElnSF1Cr1P4re0dpxnY4FwVt/m8LpYB2l4TVS
   waThrd9/aH4rvYJdOjO/w8hYwb1LG+hBk24SoIHS8T0R+iBY1gLj/u3E3
   w==;
X-CSE-ConnectionGUID: qqxRYS1VTAKf0+OF4dcBEQ==
X-CSE-MsgGUID: Rkvu5jDwQ+mgR2QecdcO9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54033532"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54033532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 14:28:44 -0700
X-CSE-ConnectionGUID: fp8TdFkMSqipMIXt6Kerxw==
X-CSE-MsgGUID: R8RNPy2hRZirjPlHr6Wmyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="122813045"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Mar 2025 14:28:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 71394194; Mon, 17 Mar 2025 23:28:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] relay: Use kasprintf() instead of fixed buffer formatting
Date: Mon, 17 Mar 2025 23:28:41 +0200
Message-ID: <20250317212841.1811124-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Improve readability and maintainability by replacing a hard coded
string allocation and formatting by using the kasprintf() helper.

It also eliminates the GCC compiler warning (with CONFIG_WERROR=y,
which is default, it becomes an error:

kernel/relay.c:357:42: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/relay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index a8ae436dc77e..5ac7e711e4b6 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -351,10 +351,9 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	struct dentry *dentry;
 	char *tmpname;
 
-	tmpname = kzalloc(NAME_MAX + 1, GFP_KERNEL);
+	tmpname = kasprintf(GFP_KERNEL, "%s%d", chan->base_filename, cpu);
 	if (!tmpname)
 		return NULL;
-	snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
 
 	/* Create file in fs */
 	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
-- 
2.47.2


