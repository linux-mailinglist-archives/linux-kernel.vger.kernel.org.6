Return-Path: <linux-kernel+bounces-169554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A138BCA4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C801F22C19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259A1422D8;
	Mon,  6 May 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwO+VGBT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056684FB3;
	Mon,  6 May 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714986609; cv=none; b=RH0Py7NQWgLX4hpfAsZap3wfx4iTsYMcTFDk+DGbJuA0ry2b4pft+Mt+ajLDJHoST2P/2o2R17P/MsGIpb4ub0UJsO34Bk2qv/ZHDnBd6470GC7pJ4+SSv8ORxvieL1kVY2+kUQOVApH2ORd1V53D2YOazJcJxTMrHbTRIHFpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714986609; c=relaxed/simple;
	bh=YA+PqKXQufJxmyHAOnZoOHyB5sVLggaHsdUl1m+YNxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irCr3REV7txiQRaSAFIV5BUoqL7C60GjV7a6DA8Ox1YX771cAr2RzyAMiQJzdjmp6WmmWqC7PpZUteKIWHezcxAhGK2bCWhNJz/6CwS04Fg/Uwappi+ZVjFBRnmNJn1xzJMy8xWF70zd3KqlVVmBc3cr12QZYCOocpw6dJgOCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwO+VGBT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714986608; x=1746522608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YA+PqKXQufJxmyHAOnZoOHyB5sVLggaHsdUl1m+YNxo=;
  b=QwO+VGBTYBnxVEDIYxt0km+sRwFQ4qDT6aVFQaN6jRcJ4JdUh9WOmZid
   I0utXLQ4/0JzM6hktwvlnUfdXyiO9B4C8HWxQERt9F4iwBkuZ6bXoUAVk
   K38S6lAPlC+LTTm/RKsrR4YVNfwW2yZM7QRvXfcrQim/m2EFpEeycODt+
   6YZLTrohydi+WI6vokFQuMRuqcg79R12jGO5BKiKF9tpmY0EX50AEUh++
   IY96HopqppLG+qylvAA3lJsXxfdBzyF4KZEe2x6N+rtH2ZCN2ygrYkNRx
   W0+NjficKH5iveSc7KA1peAoXhbCzIEsHuCBm0ThqPqZwSVYHt52feAEL
   Q==;
X-CSE-ConnectionGUID: xPwMsaksQeWiyrf4kPKCjQ==
X-CSE-MsgGUID: mq84FVOeRP2diTVqIIIYBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21278018"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21278018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:10:08 -0700
X-CSE-ConnectionGUID: uHSgHqskT1KwoDnfI7kSLw==
X-CSE-MsgGUID: FB1/rAPdS8SFAXEgAhMfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="58986313"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 02:10:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0E5319BA; Mon, 06 May 2024 11:52:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	baojun.xu@ti.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ALSA: Correct the kernel object suffix of target
Date: Mon,  6 May 2024 11:52:19 +0300
Message-ID: <20240506085219.3403731-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct suffix is 'y' for the kernel code and
'objs' for the user space. Update documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 2d2998faff62..801b0bb57e97 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3976,7 +3976,7 @@ Driver with A Single Source File
 
    Suppose you have a file xyz.c. Add the following two lines::
 
-     snd-xyz-objs := xyz.o
+     snd-xyz-y := xyz.o
      obj-$(CONFIG_SND_XYZ) += snd-xyz.o
 
 2. Create the Kconfig entry
@@ -4019,7 +4019,7 @@ located in the new subdirectory, sound/pci/xyz.
 
 2. Under the directory ``sound/pci/xyz``, create a Makefile::
 
-         snd-xyz-objs := xyz.o abc.o def.o
+         snd-xyz-y := xyz.o abc.o def.o
          obj-$(CONFIG_SND_XYZ) += snd-xyz.o
 
 3. Create the Kconfig entry
-- 
2.43.0.rc1.1336.g36b5255a03ac


