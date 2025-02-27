Return-Path: <linux-kernel+bounces-535710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46EA4764F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B68188F7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC6122068A;
	Thu, 27 Feb 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzV7ObhN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913221B9E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640106; cv=none; b=CnuVnX8YVjRprYMnUOFVx7JKrJjWnoRKSTJR1bCzknoIQG4ogwhuOr9EeySxTEyoBum9zs0uXK6ZXUZLlQCRQqV1vFWjo2775qs1084oofrgbtDZ2PVIg71/BV3G70kq2Qgm68M+JvbymR64vbozvfrV4eM7wKaKbbDEV1KaLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640106; c=relaxed/simple;
	bh=VLD9AGYPVrzIRyGKCwkTW7NwmELi6gc28QkKz9UEbYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XIJ7282wFyP3uJQmfr3vneD3NB/xj9FS26UtRq+HESC/jA55eepYy/hXKx6wT6W/UH1EW5pE6pEfXhPuM6+1D8rlUKSSxiwY8EyY3gWMAZe+0m9QkJ/9C3CGO8YwqLeZn5H5vHzCL06v2sKEcQHqRS4ZOHSN99DizIfIyzZl2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzV7ObhN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740640105; x=1772176105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VLD9AGYPVrzIRyGKCwkTW7NwmELi6gc28QkKz9UEbYo=;
  b=BzV7ObhNmDNnL5AUH0/gBhZ3JuURXzksLpEYe4nSELl45EtEinG8Shgn
   WxwiSqZUejfP+mue7UpI4/pxSwvfZSbLdKYIvNZqTiUknnOd5t0LgP9vi
   ih18I1NF50qqEe2ZbglNsoehbDhzOQNOXlXZfc3RHy0E4zs4vm6VXrzpH
   ExJrCzxgx9SUTjT1T0JM8yzJ3HW5KKGbfYXVX1Cg4tRAfX4SBoql/gnG+
   YNwG+amhmwW+G9dxxqStin+UHlGrR4075Q4iWKHfvB2CT/kQ6mtsFvkW7
   Fmyw5czVJVOXAhcYkFAXJ2YkWRb/iHg1ITlE3DeXnaRe4O3QvBeBAASo3
   g==;
X-CSE-ConnectionGUID: 3LS8NcLUSAmHtR26SPR1lw==
X-CSE-MsgGUID: ARmc1TLuTtyqCU5Qo1iS3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52505363"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52505363"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:08:24 -0800
X-CSE-ConnectionGUID: NKBHePo0THW+Nc1WzaPAdA==
X-CSE-MsgGUID: oNZ/3igYTZCjER70cxN2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154125491"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2025 23:08:22 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 0/2] Cleanup io.h
Date: Thu, 27 Feb 2025 12:37:45 +0530
Message-Id: <20250227070747.3105451-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series attempts to cleanup io.h with "include what you use" approach.
This depends on changes available on immutable tag[1].

Although this series is too trivial in the grand scheme of things, it is
still a tiny step towards untangling core headers. I have success results
from LKP for this series but there can still be corner cases. So perhaps
we can queue this on a temporary branch which we can use to submit fixes
in case of fallout.

Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
headers.

[1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
[2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
[3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com

v2: Fix sparc build errors
v3: Fix nios2 build errors and re-order patches

Raag Jadav (2):
  drm/draw: include missing headers
  io.h: drop unused headers

 drivers/gpu/drm/drm_draw.c | 2 ++
 include/linux/io.h         | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)


base-commit: b8c38ccb2ca52b9a38cfeb9f89abab5d6e713221
-- 
2.34.1


