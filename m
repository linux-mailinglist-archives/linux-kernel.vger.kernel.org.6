Return-Path: <linux-kernel+bounces-286463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74C951B38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0038C1F21C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5F1B0135;
	Wed, 14 Aug 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sgwzgyaj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB01109;
	Wed, 14 Aug 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640119; cv=none; b=nVmqGj7EouoFgr0kxdbzr0XkcjDKG4kh6PyKuwjE0fRqSnelGOC52/N58V0Q0KG07DeuwSbpOm/QFcaoM1ADZi7BXDmXYaIKyidyBfVDwUNtgau6590CcJmcUltuzFsHlpvVGwq6R3CZo6Oxxc6Qv9RF01aPScphADgePZvi9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640119; c=relaxed/simple;
	bh=TGZhmNsTNOal1mIuFUkoGhPRYuosQ7ALdkGXMacsZEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxYkv7JSHJ4htwiGIIB6W/XySAAf/NXDwu8A6w5Vk2+qqBGDfRKYdPN3GyBq8z0a7BJu8oZJIGsFXZQv2K24hgdgqRqLD94P1ZB/whIvIG7aOrhdZS8nfdZuM6rIukPmVNcHy/HltCUL7B8rkX10ezIt/SbpDu3rLPrhU/vs5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sgwzgyaj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723640118; x=1755176118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TGZhmNsTNOal1mIuFUkoGhPRYuosQ7ALdkGXMacsZEM=;
  b=SgwzgyajdXewkGKbX0yrzOHXyNX/rRs249P7cSiMt2dg1xfnYZd3S1NE
   NK8qMTeM/1s8O7bk76Q0dMPrUvyqhDD2VwMuYMJ2yDEn3LQcaPPhC/s9l
   p/UDLfF1ru+Tcp4StNtjYy6Rqya49WOmKUiDJqMzEhKqIPM+pT2jZn0Pt
   XgGRsJSncLF16oI8A7IR9+2Z4V17ecB4pc9C8lAhnL0HrChaOobvwxuLZ
   EVlAVVXUJYs7UfJKmdRcleJbfWqqG5QJgs28LZU99IJqz0ovRnu53kiSo
   QjuyBRU9xrkQqfPUWgO+XY2qJmVhS8RlDQHcElWJy1dcJPg8kRCoflbsB
   g==;
X-CSE-ConnectionGUID: 9LaICLpqSDGeKmsC/HFJRQ==
X-CSE-MsgGUID: qmqNX8YbQ1muTHoeLihM4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22010665"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="22010665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:55:17 -0700
X-CSE-ConnectionGUID: DpkJ4m2sSL+SXOY/cmbdeg==
X-CSE-MsgGUID: CeIAzp3CQDCljOiQ80Z/nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="89804223"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2024 05:55:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C871D2CC; Wed, 14 Aug 2024 15:55:13 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 0/2] clk: Switch to use kmemdup_array()
Date: Wed, 14 Aug 2024 15:54:06 +0300
Message-ID: <20240814125513.2637955-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded kmemdup_array(), which does an additional
overflow check.

v2:
- dropped upstreamed changes
- fixed a typo in the commit messages

Andy Shevchenko (2):
  clk: mmp: Switch to use kmemdup_array()
  clk: visconti: Switch to use kmemdup_array()

 drivers/clk/mmp/clk-mix.c  | 10 ++++------
 drivers/clk/visconti/pll.c |  6 +++---
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


