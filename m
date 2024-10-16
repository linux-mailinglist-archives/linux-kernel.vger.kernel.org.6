Return-Path: <linux-kernel+bounces-367948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3F9A08B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDBD1C22ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9478207A38;
	Wed, 16 Oct 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNHgbk+6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71918C33F;
	Wed, 16 Oct 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079441; cv=none; b=lANP71GbZ+pt636l/2Qb1l9Pv99psSskqu8CpyCmKoFqNouneSXDGu8/Rt6N7J2FEKvVSUCG2VtUMZSgLpcXDpJmFWW2d6MzRmNxoK0S72xJYo3gjT1D2Lxh+Z9mgl5SHyK9OYf+dvSgX8pS79Uyx4G4IAQLmDgBvHHOOorQb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079441; c=relaxed/simple;
	bh=AdIX7x94/YSfQ5qDkoQXRWauWdQnYVxqvl3g0er6Dvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe9m9zN9wzEIoKJB71k7EwxprJDBRuCyt99+2BSz6dpA0EbbWcqSOvxaz+P6QUKi/9SvRMZro1OWCKeJQBOuvaLitSed8phJGUQpvb/xp58zm22cNvJyZ/0hdOxGDtCLUjT8XVucyipn8t9rNHlcxzc41Q9pkFqMeOVzJFzxR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNHgbk+6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729079439; x=1760615439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AdIX7x94/YSfQ5qDkoQXRWauWdQnYVxqvl3g0er6Dvo=;
  b=QNHgbk+6bhZzOVHJfog7ybV7DfZf5dfZ/G096mi+3GCvNUoFxmgPc7Kf
   ZrET/gQoc8D/hyR3DQP9YNys2UrTYSqJCmRzqZknDzF34EL4RlVUdixKM
   QTv2fAhJKIwFz7Bdt1scW7V6PQ8wo4FXbraWRqfyW5jxbx9lEao3VP9dC
   ZmgT7KzKwLRXP26ZCptweLJJT9ZbTNrZC3J/7oJJBg+5t3yd5IlE6laDe
   qJQciD4gt9CkrsdupZ7RitUbaqLyc2YssxUc3Lz8oUKUmTRW7EQnewMXi
   60nc+vyA4SVZ9svR6wwxDWgBfdaPIfM23ZNrGf7JoqUqrNlOdyqy8Ps7z
   w==;
X-CSE-ConnectionGUID: oDu8/c5vQv2ivkVkBkWKRw==
X-CSE-MsgGUID: b1fuK9d1QYCqxoQ0c7DmlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39069932"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39069932"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:50:39 -0700
X-CSE-ConnectionGUID: wFq5/ZM/QfWyCD6/Jve67g==
X-CSE-MsgGUID: A+xE3dnPQp2M3hNK4Fjeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82974934"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 16 Oct 2024 04:50:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AA893165; Wed, 16 Oct 2024 14:50:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 0/3] platform/x86: intel_scu_ipc: Avoid working around IO and cleanups
Date: Wed, 16 Oct 2024 14:48:23 +0300
Message-ID: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch avoids using a workaround for IO (which seems unneeded).
The rest is a batch of cleanups. Cc'ed to Ferry in hope of testing on
Intel Merrifield (the main platform that uses these APIs).

Andy Shevchenko (3):
  platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
  platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
  platform/x86: intel_scu_ipc: Save a copy of the entire struct
    intel_scu_ipc_data

 drivers/platform/x86/intel_scu_ipc.c | 142 ++++++++++++---------------
 1 file changed, 61 insertions(+), 81 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


