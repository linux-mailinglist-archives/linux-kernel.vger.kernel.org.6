Return-Path: <linux-kernel+bounces-564874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DCA65C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F9D88184D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598611DE2BF;
	Mon, 17 Mar 2025 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhMmunDT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400601A83FB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235258; cv=none; b=Qj6SeviNStAHoCgP266aQMQAV01DouPvTaecJX8rZdfd9ej9Mbr1hnACD/B3x5DXtDHAP1Fl4boQWq+fj6BZNVmLUEcQrq/9LDjBGMcpvsvb5MkpjkV8cZZLR1Ry7B4OyuEY6iejb/hn8QVhTCox7fZ9D5yZIBQaBJtD9wbDq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235258; c=relaxed/simple;
	bh=QLnVtP21rfwr8XiEIOIdle3aMsixDDTklx+56vqT3Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f33FfBVK6Aey4QSQFMTQfioPcGNvJmMRbSTY+DM64M5JMDsl9qYe8t948UxHUzanVCwgOb2xxwpVDuybceWNiZ8WykT1/TmDvmQm5yLe8sZe4tkU5LD5W8fZvSZIM1bwhDBHcklZcwJW+bQuQKqzBeyPAEdVr65oFTTo2tRsW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhMmunDT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235257; x=1773771257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QLnVtP21rfwr8XiEIOIdle3aMsixDDTklx+56vqT3Ag=;
  b=mhMmunDTQABPHHhag+1aBBsf5YaUUemSshLeJJcyBflWc1TCyJ0B/GeE
   4+CQumXAPXyxJXlRf7m7EUSN9xZTPiPab3fjGmwLr5u4149OsfpUSNdEv
   8ACq7aj+Ca7oK0ObeYecfBIt6GWXZL0bWFCvrxoq0a29zohWXvTCE863/
   GlD5/QievmS2jooI3jay0+S4yxEN0APOpX9iRIxutZUpiEEGFdQapGxRU
   n457CV9iM0G/8nI1iOODyfvDlSW5K6e8Rr0UBbz9xgsMj8KsR+vZKRRyR
   m5AHQvxmgSpfbbRADFEmXISZHmAqBbOs5SNQzwEL7ihPZYfXwPxzyq4Vf
   Q==;
X-CSE-ConnectionGUID: 6ZDLBNdLS4SAwoqHmqjoyg==
X-CSE-MsgGUID: 7NZzVO1WQR+W2kVsmVxrGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43259462"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43259462"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:14:17 -0700
X-CSE-ConnectionGUID: dd0itR3aRa2CFXxLm0jVFw==
X-CSE-MsgGUID: Vo7bBy4NRVGmfhXVf5CA5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="153007717"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 Mar 2025 11:14:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 084A1194; Mon, 17 Mar 2025 20:14:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/4] resource: Split and use DEFINE_RES*() macros
Date: Mon, 17 Mar 2025 20:11:09 +0200
Message-ID: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mini-series to replaces open coded variants of DEFINE_RES*() macros.

Note, there are much more possibilities over the kernel and even in
the reources.c, however the latter contains not so trivial leftovers.
That's why the examples cover only straightforward conversions.

In v2:
- added examples of the conversion (Andrew)

Andy Shevchenko (4):
  resource: Split DEFINE_RES_NAMED_DESC() out of DEFINE_RES_NAMED()
  resource: Replace open coded variant of DEFINE_RES_NAMED_DESC()
  resource: Replace open coded variants of DEFINE_RES_*_NAMED()
  resource: Replace open coded variant of DEFINE_RES()

 include/linux/ioport.h |  9 +++++++--
 kernel/resource.c      | 18 ++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.47.2


