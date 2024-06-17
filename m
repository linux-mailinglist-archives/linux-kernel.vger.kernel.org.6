Return-Path: <linux-kernel+bounces-217108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2C90AACA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103991F23C82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511431946BA;
	Mon, 17 Jun 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIY7ZwDL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E3194126
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618921; cv=none; b=YbOlUZgA3P5ASwcr7KDCNxWxq8AJah0gvcW5ine9I/fJin700I51KgJxdiUghaCRAJFvmHCIKVguu43/Rku1C7Nmi7RTs4XzVPEZSsqK4FDhdd029zzArlIbJsk6Q7VBCEQsKKsID78nGU3+kIpf7JFjcFT0Jj2NITy3ewIKlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618921; c=relaxed/simple;
	bh=t7IUNj36tGkkfpwGytIoi8bcOp1YsJI/QwTyx7SgimI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbBYJuz0KXUj82uwpH5Qwp1R07ThvqZhSmyV8Oywty0vqmngy/z1Vnd7O67iWoItiCsS/TSAEO1C4dC7tUOOUzGDBvphIWxI7c7kG5mp5lmxenMJPAFqVP5wiqNYWeA5R//9CfkMe6FxXIW8TAr6gnBOYB66TKnG7hzDqJziRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIY7ZwDL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718618921; x=1750154921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t7IUNj36tGkkfpwGytIoi8bcOp1YsJI/QwTyx7SgimI=;
  b=lIY7ZwDLxIwRV/uUVXOrAixUOxxlLFv5/9CKBVW4Mk3ZRCJMC0cFKNDo
   25W0jGXcqj0xZ0WTNP3pyL9ge6YqbZbsMkTDRpCBAAmESX7RHso8m37/w
   DvMLK3v2QmwLz6lYcjljYvnCJ5NyGW4yUWg6JRbK8LtOu97ChgIaE5/E3
   Dgx4FI0KmO6jx0kDzgSSRq27WH85PgQ+BtuSXz9tc3fmmMYWKvEaNlg4K
   J6iO1WpGfS+YFK6mHgHvg+hTyeLX1qQHVftCzmFLL2IkYIfRNcs9Jy4PJ
   zdspyl4x5sWMtT8nylxmtWc7JUhY+qmKQ5OxDNaSYBAkuXLwPzjprQB6/
   w==;
X-CSE-ConnectionGUID: bBQWcNVkTuOKcMwKkmvAXw==
X-CSE-MsgGUID: gMUD9vgWTfm0Hzg9zCPZeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15275080"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15275080"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 03:08:40 -0700
X-CSE-ConnectionGUID: Ib3ENJZyT3md3XNQz4jpxg==
X-CSE-MsgGUID: uYGWRYBNQRy5A5BuWfckOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45596435"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 03:08:38 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8B56411F7E1;
	Mon, 17 Jun 2024 13:08:35 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sJ9Hv-00AX9o-1X;
	Mon, 17 Jun 2024 13:08:35 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 1/1] container_of: Document container_of_const() is preferred
Date: Mon, 17 Jun 2024 13:08:25 +0300
Message-Id: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a warning in kerneldoc documentation of container_of() that
constness of @ptr is lost. While this is a suggestion container_of_const()
should be used instead, the vast majority of new code still uses
container_of():

$ git diff v6.8 v6.9|grep container_of\(|wc -l
788
$ git diff v6.8 v6.9|grep container_of_const|wc -l
11

Make an explicit recommendation to use container_of_const(), unless @ptr
is const but its container isn't.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/container_of.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 713890c867be..7563015ff165 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -13,7 +13,9 @@
  * @type:	the type of the container struct this is embedded in.
  * @member:	the name of the member within the struct.
  *
- * WARNING: any const qualifier of @ptr is lost.
+ * WARNING: any const qualifier of @ptr is lost. container_of() should only be
+ * used in cases where @ptr is const and its container is not and you know what
+ * you're doing. Otherwise always use container_of_const().
  */
 #define container_of(ptr, type, member) ({				\
 	void *__mptr = (void *)(ptr);					\
-- 
2.39.2


