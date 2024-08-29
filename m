Return-Path: <linux-kernel+bounces-307253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E5964ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01C3287177
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F21B3F01;
	Thu, 29 Aug 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyyP/xwQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9871B3F07
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947203; cv=none; b=UX9C4knATaTK4ZIsGJXpXVFGGgsMwuKgaeHtlwmuC3PUabO146Qgx4gkRaKiBT2+AVkNEQDKH6Hx9vrYv03x9EkbZa7C74XOCW3zuCvEu5zdLL3cNChXfKmVi+dpYsg4wQ8dOzcocVuvVPUlwNsTdfmgyUy10M4kvZE72fS/w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947203; c=relaxed/simple;
	bh=FZMzouHuGgFWMsyvFfqSWdgkqnTzjcd2HKW5qqix9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t92gqMkyKsO0hczuDD6nION7HT3a4NFSJiUzQaetSU85oliu+a5UFtmR5to473/COEU5MniSyorbPHTay3YChs8ceZt1TrV9bnet9PBhllwqbuLD1GNhIv8aEysASvfp1rWH8NhZTjHNLivB00dv0ni5knR5hH7tkXz987nG/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyyP/xwQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724947202; x=1756483202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZMzouHuGgFWMsyvFfqSWdgkqnTzjcd2HKW5qqix9aE=;
  b=gyyP/xwQ6h6wIjGDWdSm7JRcVSY7TZP59QRupUAIXfT78nHcLWmTSUEY
   j5g8Fyn5yX6NDViXqqlp+AzwFKT/8Akpf1Ip8R1uBed2LBjwpEkUvZgl2
   Vq3YozXwP/KNi8C01A7lWWgdQEmT1Y+jw6hB0QB1BWzWEhZFnjY9lxw3r
   DKcMg/7rYZtaALWyNNiyy2/cxseodWQbl97WD8z2gvR+d1RX02MMHhYmU
   dfsiv6YFK6c2Gw4u2XV3HZayxtweQzlYpcNBqDvqb07ejagrhacR+voPU
   iGRRceU2k0PhS30W4ZnzcZ4e/dIo7U84wsz1skUjxODA/keKugjnyFtdJ
   g==;
X-CSE-ConnectionGUID: 2N+oWOy1QqaWRQwAHRiM9A==
X-CSE-MsgGUID: bQQppncuQ+G+xzQ1NqENPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23695913"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23695913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:00:02 -0700
X-CSE-ConnectionGUID: ji0B6GX1TiCrXeH6j7zzXA==
X-CSE-MsgGUID: uttuXp35TnSqnZou/4qUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68440628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 29 Aug 2024 08:59:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A75D2610; Thu, 29 Aug 2024 18:59:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Date: Thu, 29 Aug 2024 18:58:36 +0300
Message-ID: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
This is due to some unused functions. Hence these quick fixes.

Andy Shevchenko (2):
  drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
  drm/i915/fence: Mark debug_fence_free() with __maybe_unused

 drivers/gpu/drm/i915/i915_sw_fence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


