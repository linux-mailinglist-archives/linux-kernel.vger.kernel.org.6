Return-Path: <linux-kernel+bounces-196540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC258D5DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732621F26B20
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F92156967;
	Fri, 31 May 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfDdo6B0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584315688F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146305; cv=none; b=FtJHDS/53IsxH6Tr2Cp60BribFq3cwoJUkzgU9JJy4vITEzen/s2oiDeiIwBpuka66rnBIBV2CILImLTfCzs8X7N4Jqtn7WauA9i8+aWUgw2jD1Ei9odHFFNYB9IW4Q9zxJ8tpHVxQraqqeA9nLbpSh9X5ctuW63rNdGyjnRVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146305; c=relaxed/simple;
	bh=aO3h9HmNwc1+wkz7rcJJoUBS3/VMC4mHtmeMrSAirCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjgiCRngJf1LCR5Y3ygakwKoKAM5gcucKww/BcD5hhVM3BkhnW0klGzjmwP7VQhlDI0d0SF8o2Edd76iTCTu+SzlqUK01bRuuRT0jQxWDeUhCvbao/6cR2ekKfgPtrC9j7P/ilOk/AZYgvYWaZS8rpUBEYHPaug7F93fuAdZKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfDdo6B0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146304; x=1748682304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aO3h9HmNwc1+wkz7rcJJoUBS3/VMC4mHtmeMrSAirCg=;
  b=TfDdo6B05i+OKoJyRJWtVC+ef5HmXbSWYADeAmnHyqdW/EF72fc2ywLc
   r6KCUVJkSNn54JxBXImYP7ekCOjezrOMFBGceeE+CRMyGhGJnCfxUQBom
   WIu24RDJxLcqCq1L7UGVpcJ8CRMHeN2pMQuetF6tOLxIbjjNhEPizqmWo
   UDx3Gj26p7daPy8AtpuvsyTm01+CuL2SPzgx8311AEFoLgKzG7tbDyKna
   pG3Qnr/Ujn/1lL4n0Zq6jX1rzpKQpN3a9pLgaakcUOKNt0ORHFG8kzpK8
   OOkMbMNVEP9EC2ng0mFN1DCen7ikOZcGrvQR0z2V7rxhywnknk9x5kpDN
   g==;
X-CSE-ConnectionGUID: 3uBVvjboQDiVs9RimENm/Q==
X-CSE-MsgGUID: iceKwFcnRm6VX7alKvi0AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39074062"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="39074062"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:03 -0700
X-CSE-ConnectionGUID: VmiYVtuTTSWqYvycE9W1Hg==
X-CSE-MsgGUID: TgKrv+yzSoO4SRCSJnn7uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40543218"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:02 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [PATCH 0/4] kernel/panic: add more descriptive logging of kernel taints
Date: Fri, 31 May 2024 12:04:53 +0300
Message-Id: <cover.1717146197.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Resend of
https://lore.kernel.org/r/cover.1711380724.git.jani.nikula@intel.com

A few years back there was a discussion about it being difficult to
remember all the taint flags [1].

Time flies. I stumbled on my old branch, brushed it up, and here it is.

I'm not entirely happy with the static buf (which was there to begin
with) or how to decide on its size. Thoughts?

BR,
Jani.

[1] https://lore.kernel.org/r/YmvU+/RUhOcL+B1p@kroah.com

Jani Nikula (4):
  kernel/panic: return early from print_tainted() when not tainted
  kernel/panic: convert print_tainted() to use struct seq_buf internally
  kernel/panic: initialize taint_flags[] using a macro
  kernel/panic: add verbose logging of kernel taints in backtraces

 include/linux/panic.h |   8 +--
 kernel/panic.c        | 116 ++++++++++++++++++++++++++++--------------
 lib/dump_stack.c      |   3 ++
 3 files changed, 87 insertions(+), 40 deletions(-)

-- 
2.39.2


