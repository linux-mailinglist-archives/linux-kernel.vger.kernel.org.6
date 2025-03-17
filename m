Return-Path: <linux-kernel+bounces-565086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48881A66089
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D006175D65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7879202C47;
	Mon, 17 Mar 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI1gYGAQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EEA1F583E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246995; cv=none; b=cxzkpnjK87GXjfzCUvDuPxKvpeS/STwTvoWtbDhJAcMEDUrNmr6CGZdOISEC0EGZlL588thlsW7UdqyqQAMgf6J73qIoxcY4aC2gkzTIfgfK2TP3eQR+U8YbrnFfRhex1oP9Ryf6qPjKhrmQ+uOv5CuU60IedeX994H3MZ5O+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246995; c=relaxed/simple;
	bh=t6gpFWlqxVlr56aYj3GwChyjcKy0WmrAhR9H5mEFpV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/AZdmA2sZTpakhAJaSnBA1bZwIKBQFHrNBAlpjUUaxIQfzmC+0zFelcebfb5KIaKnqvccd1CLrdNvHDFQn+yMWxS1+DbloNQpr/1bwtaDvuKAwyBxBvWQm2mGRej1ZmdaIdVBr2rGU7QAKEP3DWYzSTA/VXuHZuxBTpU6Nl8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI1gYGAQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742246994; x=1773782994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6gpFWlqxVlr56aYj3GwChyjcKy0WmrAhR9H5mEFpV8=;
  b=LI1gYGAQmgguJaa329gAfkJ7m55+UzOVPiI+MehYkidhw0JsMkbNRA2X
   ZisefQqSGCcidNnA8fXnPeDN5Xm9j9JJ4FeNa6Y1elzP9x2FM9QOGTdy1
   TKLQpRYxaTFgQQSrCUQwRehHxpISI7nKZ5uk4OYsNOb3NB18quIoZlg27
   uiIooBjEZKfBdw68cA67r5hIZSx4DL/Enxmz82KE6pGlP2Ri2NVqW/PVd
   umkL7HrMv3y09ur88a7cj9ftH+0Q0ExVY1QLl/VBQa+VW3xG4oJmmrg66
   mEoXVJkG8yYpiZfqfIIX2DDBVTNYEUzOoDqm3ErGVK9zm+csdJBc4fdZI
   Q==;
X-CSE-ConnectionGUID: sD4ytUU3SzONpICpOzl0/g==
X-CSE-MsgGUID: gNZVD70mQ3SaSaeizPyDoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42539287"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="42539287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 14:29:53 -0700
X-CSE-ConnectionGUID: sSZI6okoTTqFdliDh02G9w==
X-CSE-MsgGUID: O3YVh+OPQoyuAhnF85l7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="122235121"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2025 14:29:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 99163194; Mon, 17 Mar 2025 23:29:50 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH, resend v1 1/1] relay: Use kasprintf() instead of fixed buffer formatting
Date: Mon, 17 Mar 2025 23:29:47 +0200
Message-ID: <20250317212948.1811176-1-andriy.shevchenko@linux.intel.com>
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


