Return-Path: <linux-kernel+bounces-374452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F279A6A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE8C1C23916
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548B1F819F;
	Mon, 21 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrYKgI76"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613A1DFFB;
	Mon, 21 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517833; cv=none; b=qb7VzjeHER9dXoJka6CllWMBqNdU0X46l0qwy9pnmbVnQefKKLYw3DFEKLBAGlWKs7ZE/+n6eMn0pS+cNJpfGogeOMoci+s+UgY0dnQxBgCGAgm3HWCyayxy7yOe9WhWIrsITGJkaGWE1rhoLwbP8QJiwp5scoWmv/ZDBlUlzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517833; c=relaxed/simple;
	bh=uYZHheswrTHgSb+HkRFgo7S80MyA3QeQdGOFNEHaRYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8NQDh0muea5WkaiAzLeAMxcDOFMPlQDpa0cA01g3h9Kx4HIFTpC1n5H2g8CVmdZ3ehwJCaE69JPvd2Gw6t9scWh7n+MzErmLhZ79ENXi2mWtNNZplGxVLRmc8Bwl9yGfOsHhV2/fMkTG3r/Nv2b6nuuJo800/NO4Kh0trJRqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrYKgI76; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517832; x=1761053832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uYZHheswrTHgSb+HkRFgo7S80MyA3QeQdGOFNEHaRYM=;
  b=lrYKgI76uKsenvOouQtUKog0bOqXkEmavv9QFhGok9IuXTV4DjAl+YvF
   97905lR3vr4r9srcKgnnJrwcX98iUFYyiVeB9w67onZ+WlJT0Zs9D46gV
   IZfCHHaXIaRx0CXK+wIfPa9j6ID/kmr+yAA2l8MCCzGNgzPx86qfmg2R1
   QQR97TD6i1FaMCSai+mE0pb94YAi/0Cm0G0P7BdDu3FflPHrgXsypu6Ql
   brWVGVPtB8tuade6nIz+497A8Cq2gmYKxbTdwS7QHsNt3IUew5Hw+vcht
   ElxWci5TR5t2e5s/D/Qx+ze+ei5i0pt7br53RcfJjI6MdCeaAL90dV+Km
   A==;
X-CSE-ConnectionGUID: D7+d/i20TSG51n8PaWlnxw==
X-CSE-MsgGUID: 8Xc+W3vLSXSaDOppYiaAkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29119823"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29119823"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:10 -0700
X-CSE-ConnectionGUID: RyYdH7I+RI6gsSAJ4r9f2A==
X-CSE-MsgGUID: DPTCVDmfTnmEhwKcAbTzkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79931176"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 21 Oct 2024 06:37:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 34EEB1E0; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/5] platform/x86: intel_scu_ipc: Avoid working around IO and cleanups
Date: Mon, 21 Oct 2024 16:34:28 +0300
Message-ID: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch avoids using a workaround for IO (which seems unneeded).
The rest is a batch of cleanups. Has been tested on Intel Merrifield
(thanks, Ferry).

v3:
- split patches 1 & 2 to two patches each (Ilpo)
- preserve a comment for reading buffer (Ilpo)
- inherited tags for new patches as the result is the same code wise

v2:
- dropped stray change (Mika)
- elaborated conditional changes in the commit message (Mika)
- gathered tags (Mika, Ferry)

Andy Shevchenko (5):
  platform/x86: intel_scu_ipc: Unify the flow in pwr_reg_rdwr()
  platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
  platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
  platform/x86: intel_scu_ipc: Convert to check for errors first
  platform/x86: intel_scu_ipc: Save a copy of the entire struct
    intel_scu_ipc_data

 drivers/platform/x86/intel_scu_ipc.c | 142 ++++++++++++---------------
 1 file changed, 61 insertions(+), 81 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


