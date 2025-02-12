Return-Path: <linux-kernel+bounces-511840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC49A3306E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350907A06EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0EF201001;
	Wed, 12 Feb 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ+4ud52"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0B1FBC96
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390770; cv=none; b=N9jtK33vmsYWOvEfz04uJPm1aWZgvoZkRsoG24ak+CWG2yr6K70FKJX5r8VbZ6ITIlrxfCKB2GKpholhNIIZqqxb2y2K/AwslWlB4osIixyF19GE51NgBLz5VdVKhLdvp8Br8gZO4eLqBS5/NzZHCJJ2al26cIwaTia/c+EH644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390770; c=relaxed/simple;
	bh=1YJbzurhRAfke5H4H9g/dulbokwhS2QPZpJr6FRO4y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkFuZmToqn4oQmJT6TO7bMvGrb2pRObSWME95Tzb5ZSS+I8F5IFOJxlfzei3EoasJn62DVzTFOqm35Pmr7VopHw4wOYkoliAHShhuBVEN8G7M1wMmhi/8ubf93GOBg5QzAV8J8siXZk27W3qJ4dP26AIwlvYloCW4YB/1Nv/mVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJ+4ud52; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390768; x=1770926768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1YJbzurhRAfke5H4H9g/dulbokwhS2QPZpJr6FRO4y4=;
  b=lJ+4ud523jR0NaVO8PUFNwOEz1htIZW8ivxGD2o1fYfKynYBncslhabF
   F2xfNwbN5Uo8xnsHbFha/rYWQYsahDar7yXrU0yd/QjohyWC10Us89/Zv
   NoF1kcEN9uDfdVFg2Zb+vYCQHdSa5OsHuxuhUFVyGbCykc5XOVv+PAUuy
   ZDDDlKyjkNdESvsdCuyq9dtcipVmwUG9UVOS1N9J/T1oNne/TIpIiN4b5
   a/wRi5enKKMLp+DR1oxMKF9NGc124feVzFexv+412q3AqzA3BoEwotBA4
   Ce7ECEaWek0NeH3ypxwdUNAgYKFe3IqFnKE8CAok6wtI62WRRBnwKvQMc
   g==;
X-CSE-ConnectionGUID: j5yYHmgNQzelAyTLPaoYVg==
X-CSE-MsgGUID: JtICFxkuRaam8QgbT26ikQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718482"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718482"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
X-CSE-ConnectionGUID: fb7QRtBwQRq3P1ire6C55A==
X-CSE-MsgGUID: JTmdfeUPTviGPc3Qxk63qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010751"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:07 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/6] Make devres cleanup and component compatible
Date: Wed, 12 Feb 2025 12:05:36 -0800
Message-ID: <20250212200542.515493-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to convert the xe driver probe sequence to use more devm, I
stumbled upon it not being compatible with component driver that is used
by xe to work with mei and audio.

First patch makes that possible with the 2nd and 3rd being some drive by
improvements.

The last 3 patches here are just to show it being used in xe,
but they require https://lore.kernel.org/intel-xe/20250212193600.475089-1-lucas.demarchi@intel.com/.
If this is acceptable I may even drop the first patch of that series and
convert it straight to devm rather than with an intermediate step.

Lucas De Marchi (6):
  drivers: base: devres: Allow to release group on device release
  drivers: base: devres: Fix find_group() documentation
  drivers: base: component: Add debug message for unbind
  drm/xe: Stop setting drvdata to NULL
  drm/xe: Switch from xe to devm actions
  drm/xe: Drop remove callback support

 drivers/base/component.c                |  3 +
 drivers/base/devres.c                   | 12 +++-
 drivers/gpu/drm/xe/display/xe_display.c |  4 +-
 drivers/gpu/drm/xe/xe_device.c          | 79 -------------------------
 drivers/gpu/drm/xe/xe_device.h          |  4 --
 drivers/gpu/drm/xe/xe_device_sysfs.c    |  6 --
 drivers/gpu/drm/xe/xe_device_types.h    | 17 ------
 drivers/gpu/drm/xe/xe_gsc_proxy.c       |  4 +-
 drivers/gpu/drm/xe/xe_pci.c             | 11 +---
 9 files changed, 20 insertions(+), 120 deletions(-)

-- 
2.48.1


