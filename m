Return-Path: <linux-kernel+bounces-444147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C339F01FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013BD188CC93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3A1A296;
	Fri, 13 Dec 2024 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beu8l2nA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05210F7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052770; cv=none; b=GGPtV0TsCSkeJHtwDJp3dlaNmThNKk5fjjeo+JKZa6DQWdh8gHHo1iY20NUc1cVWslcUEcVRBbGCwx1kPQ00fpjEV+gFoVROoWlWoTOxPL0LY099G3xKGxVySyvcli+dkWvyA94tOvFYbBlT61Spo+nJiAI+kc6G9Hl51872Y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052770; c=relaxed/simple;
	bh=mTvQPKWRQb48JVB/USELHqMNjVP/pf3KTfaBUoBFXDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6mAqHE23bipAlQniy5O3ZytkuyfafBOJrW1Dul5XMo9rpSs88m73tCtWLbqoNDzKsfB/PaVTPorB0lasbnedtTgHBUpLYxB6NQw2CZckbYrAtdFruGUt7MHqvHWF/NlZolLme200MCevEXc71v+pDBjSExMPAozxt4hwzVG6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beu8l2nA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734052768; x=1765588768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mTvQPKWRQb48JVB/USELHqMNjVP/pf3KTfaBUoBFXDQ=;
  b=beu8l2nACiwClrQMs9vQw13QcdC0iK8jPWHY2xENl/sF9cemjh6Ckrmr
   YC/npYaSBWxO1DRLqLcHpYvU2rnwC/y2bIPrVAxrvrjtrmpmTx+Le0OC2
   EpktlRoD2pNDuY+emm5pLz691Y5TKIrosewQLmszZXy5M4MY49U+Y4IKl
   zFQYE3yd48ZB/0lFA/UaOF7drE3H15us2AYzTmsoHaKNUoSDzEBdF48/4
   S8ABe2ongyiP3EUhdy2tYmrRRgqJCz8xrWYlIN9k/0xKF64H4tiVJLbdM
   U09oBXi9JDknSGSyP0yGC2s2TjBei4X6KiOKgJoyClWNveGgY08FfsaL6
   A==;
X-CSE-ConnectionGUID: EWhRixgQQou53ZagrVgrrA==
X-CSE-MsgGUID: SUdntcgKQdSRnKsrhMy51w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45510006"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45510006"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:19:28 -0800
X-CSE-ConnectionGUID: qj52bvHSTcGZQAmfR6PEtw==
X-CSE-MsgGUID: /P110jxPQhW90MwwXKlujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96835604"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 17:19:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.13-rc
Date: Fri, 13 Dec 2024 09:17:49 +0800
Message-ID: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for v6.13-rc:

 - Remove cache tags before disabling ATS
 - Avoid draining PRQ in sva mm release path
 - Fix qi_batch NULL pointer with nested parent domain

They have been reviewed and tested. Please can you consider them for
v6.13-rc?

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Remove cache tags before disabling ATS
  iommu/vt-d: Avoid draining PRQ in sva mm release path

Yi Liu (1):
  iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

 drivers/iommu/intel/cache.c | 34 +++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c |  4 +++-
 drivers/iommu/intel/pasid.c |  3 ++-
 3 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.43.0


