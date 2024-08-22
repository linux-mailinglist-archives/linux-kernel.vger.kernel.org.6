Return-Path: <linux-kernel+bounces-297623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665295BB88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BB51C219C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEE1CDFDC;
	Thu, 22 Aug 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVHw6KqR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6691CDA03;
	Thu, 22 Aug 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343304; cv=none; b=FW1uOMvN88TRUoRwqODtY4gu4br51DfTasPz/CJknQWa3AKeZ2Ekho66QbSZpKge5VIWNEiZoLTpFi0yPGUe2VIe9eD0j/F34Hf+Mu1ahSh7yM/rVTwtv7abAR+QJvHaaj1eQxrzu+nQN/7hhzATzwxxCQ404hASWFkNARXglN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343304; c=relaxed/simple;
	bh=BiQaFtE6jfj4M6CFGZsVNVtrgH7CqWb4WyvBAlIW1n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk3OlLOR2bmiIDSm17VPFTc6dVMHnU58Z7A3ZKSCk3B/DssJFSwa+p83xOK1sRrro6zHd5OxxaXYmA60xF6Aujvyyt4cwOAd3OW/IQqgh/8IdQav6q9auZEg4ev7u+jFdlWMKpJPRidZ3XNOfwy8QzhFIEy7BMe5rH4dR2AzN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVHw6KqR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343303; x=1755879303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BiQaFtE6jfj4M6CFGZsVNVtrgH7CqWb4WyvBAlIW1n0=;
  b=DVHw6KqRM210VANO4st970bbaKSlta2ojC351hQ7KS57XcIUhusB6j+r
   MMXBdXNzqo2WPkbBxi1JCWNdmu8fheT8Fbo1W1T17yX+mTFKDPvhoz2lD
   vyUxhukM7jBwECZvBPgFi8MD28dw7O6Cz9+x1AtcNfp672Wk4IEQe2S/q
   9TGV93WtZ9J5pjev9a9siQ/uWMLeGNVC6A14Xr7L6rg1tD2Y1tTHuIpgI
   uuKvj/mP8MkVlqmFpuM9oFtgYu7+lmdLXHzktZ8NaE9jGwera6xxB3jMv
   apnMYBYvwwZIXUFPcEj96/D7TNnock8w8sWnK7C7XN6yS2BYpp1gDdtYX
   Q==;
X-CSE-ConnectionGUID: dWcJWC04S7KUnO4zUzR5xQ==
X-CSE-MsgGUID: KZcFjGicQYW261+H5P5oVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40237260"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40237260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:15:00 -0700
X-CSE-ConnectionGUID: nKN+dnVhTPOeLj5VwyGipw==
X-CSE-MsgGUID: ooWOkUuGSzKjU8xo3sb2Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66425279"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 09:14:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 06E692B3; Thu, 22 Aug 2024 19:14:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v1 0/2] clk: x86: lpss-atom: A couple of cleanups
Date: Thu, 22 Aug 2024 19:14:06 +0300
Message-ID: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups for the clk-lpss-atom driver.
No functional changes intended.

Andy Shevchenko (2):
  clk: x86: lpss-atom: Use predefined constants from units.h
  clk: x86: lpss-atom: Use temporary variable for struct device

 drivers/clk/x86/clk-lpss-atom.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


