Return-Path: <linux-kernel+bounces-226026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD72913938
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F4928170A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3F7442F;
	Sun, 23 Jun 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsuDg40+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F31DDD6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135142; cv=none; b=uiR074RMym7SDlC9sGd99bKOKRnSTAxBIa/O9IJZ3Qrt6yX2KybIQs/Kwgvg3CrdXL+lStGsRl8R/qGPB5B4BZi17sMaGO46+y8n1KDkOyE2R6+1DqbPoptWVFJzrN1JPUINFz8JiR/F7v6yRW77+YIGOkp+TQsQKwoiJbrpRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135142; c=relaxed/simple;
	bh=PQxWZXqEsLqsOlZlx+2ewUBLcN9yo87a5BlOzDjeegU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luiIRmdDJiDAdYTH4duJhsv1ubdWA1gWjmZ5mNPiH0gP6umhhA1wOgKdVlfk6KPmZGWCXKJ4nSGQxXddrSmpNLQUm2DG2Macagn/SwXO3N5tqqHy2Ei9MN7nQMyWyZIT6FEUYQe6Jbhx7Ztt8IMUKdE8IYd4J7+zv3UYt2X2QKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsuDg40+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135140; x=1750671140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PQxWZXqEsLqsOlZlx+2ewUBLcN9yo87a5BlOzDjeegU=;
  b=NsuDg40+J2OpbYoORL3mJqSe1fYxb2moy1Bo9eBk5gjI63ZJlNyatc9m
   hTbaS1DQrRGcbvsckiLCle9k+RStaOtDndKeHualMTki0Sucn/6oauHYX
   MP+g88BIHvRvXr4TPKLCYqwk66uY93lOoTa3k/YPnH5AOeJsk89sqLgzV
   VKPe0OHmLheG+ir2VwmQENX2d+AuQC5YnViSmBlMb4+RKYMuP5os6Zc6j
   6zVQ6M7yWc47reFHGaAmmJvaqnocFqsTmf2vdG8gcyn8O7Q3Jc4UwR/yY
   YcEBQABqVMYhAPd7nHZjw36W08Se4BvpdTJENEWngZeQjoYqBDL/fTTSk
   w==;
X-CSE-ConnectionGUID: dUvqZxroSaus15/K+E4vQA==
X-CSE-MsgGUID: PoeSSCfVTh+LNQtzDuDV2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089075"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089075"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:20 -0700
X-CSE-ConnectionGUID: hpVrDPigT/GQxg2aeW8E6A==
X-CSE-MsgGUID: O2xxojbSQTeecfj2nQc8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761694"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:19 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH 0/6] Fix MEI command timeout issue following warm reboot
Date: Sun, 23 Jun 2024 17:30:50 +0800
Message-Id: <20240623093056.4169438-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While enabling the IVSC on certain recent commercial products, the chipset
may occasionally enter an unknown state following a warm reboot. This issue
can cause the firmware to fail in responding to the MEI command from the
host, despite the firmware being re-downloaded. To resolve this, the current
patch set incorporates reset logic during system shutdown to ensure that the
IVSC chipset remains in a valid state after a warm reboot.

Furthermore, after the firmware download is complete, the firmware requires
some time to become operational. To address this, additional sleep time has
been introduced before the initial read operation to prevent a confusing
timeout error in vsc_tp_xfer().

Additionally, this patch set includes several enhancements as well:
1) constructing the SPI transfer command as per a specific request;
2) utilizing the appropriate byte order swap function for data received
from the ROM;
3) correcting a spelling error in a comment.

Wentong Wu (6):
  mei: vsc: Enhance IVSC chipset reset toggling
  mei: vsc: Enhance IVSC chipset stability during warm reboot
  mei: vsc: Enhance SPI transfer of IVSC rom
  mei: vsc: Utilize the appropriate byte order swap function
  mei: vsc: Prevent timeout error with added delay post-firmware
    download
  mei: vsc: Fix spelling error

 drivers/misc/mei/platform-vsc.c  |  4 ++--
 drivers/misc/mei/vsc-fw-loader.c |  2 +-
 drivers/misc/mei/vsc-tp.c        | 20 ++++++++++++++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.34.1


