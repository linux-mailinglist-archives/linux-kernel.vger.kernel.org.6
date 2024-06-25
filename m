Return-Path: <linux-kernel+bounces-228496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85DC9160B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3091E1F226AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA2147C80;
	Tue, 25 Jun 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKP6LbDQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8A1474C5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303104; cv=none; b=VfbOrrXb89+9JAS0FjJW461gmrK0H1BbSRYC7eggIQGtrJGsvau3L9OHu2FQzZcXw7VH5CZ+OLNpcufZwQI8z024r6EpjTyzmxCncv9gX7LRCgXE+cYr8IGNfyFPVxWexSM9GVAcgdacCwEoOIZXoVf6CTNfD0H6qiA4qvPpS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303104; c=relaxed/simple;
	bh=8hCraVFkuY7tX/NHvAL5FFlsNwDWPh/3sWYMxZ/I/Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hqlcj3ACkYsoUf3EEuTOqa+MCAKV5aQ/dE4HJ9CKkpTxjeRjbdJdcM51J/t7KV4W5pmNZBWRlklmL3Y6JWGR6MVImo7Yq6plFBwaRTSMZrsuTDmLKbD+73Hn/AqH9mofgRaRO63NzpETKzLC9wwpKj4xL0WVFQGdFRujuGd1LAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKP6LbDQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303102; x=1750839102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8hCraVFkuY7tX/NHvAL5FFlsNwDWPh/3sWYMxZ/I/Ew=;
  b=RKP6LbDQFEjIZ3z2RHoNVp7f5kWNy/C4ZMCkQMhLKjraJ9N1NaGGNV/L
   m1ByZrPk5LABXYsPh6LrmwwgpWQAsRxjDRcSKzT4jZR9wNEWKh4JEq0Km
   AN07kXUURXG1SsCl1nsku8Jm1lqBSECkj1A51Dh2HNQ48iM1EDKUY7bWM
   6JrBg0oqqGOETgBfBFoJBrrCVkdwsC5kDksoHcvejSKUPa4JO3snJgkFL
   Ia5YqzVrJqXfTL5ONKWR4jL5k1D3KJt9STUPGNtH9TVTEQtFTxpJ3/c4C
   qgnNZVKOx4PxwmoZ37dhu0bu/kRwLVJlmTx4or7OALMvMeiVmu6kipFv+
   A==;
X-CSE-ConnectionGUID: lk1DyY3ZQP2lq1FOjpYBbw==
X-CSE-MsgGUID: 7+gHO5sORBS7BFKeuOYslw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232499"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:41 -0700
X-CSE-ConnectionGUID: PnHmRiKdT0qsuOMam5AtWQ==
X-CSE-MsgGUID: 2rTIeigPRayCGOjviYwkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944893"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:40 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v4 0/5] Fix MEI command timeout issue following warm reboot
Date: Tue, 25 Jun 2024 16:10:42 +0800
Message-Id: <20240625081047.4178494-1-wentong.wu@intel.com>
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
some time to become operational. To enhance this, additional sleep time has
been introduced before the initial read operation to prevent a confusing
timeout error in vsc_tp_xfer().

Additionally, this patch set includes several enhancements as well:
1) utilizing the appropriate byte order swap function for data received
from the ROM;
2) correcting a spelling error in a comment;
3) constructing the SPI transfer command as per the specific request.

---
v3 -> v4:
 - remove `Fixes:` in the commit message of comment spelling fix
 - re-write the commit message of change "Enhance SPI transfer of IVSC ROM"
to easy to understand

v2 -> v3:
 - switch code from `ibuf ? tp->rx_buf : ibuf` to `ibuf ? tp->rx_buf : NULL`

v1 -> v2:
 - remove cc spelling fix to stable
 - remove the reset toggling enhancement

Wentong Wu (5):
  mei: vsc: Enhance IVSC chipset stability during warm reboot
  mei: vsc: Prevent timeout error with added delay post-firmware
    download
  mei: vsc: Utilize the appropriate byte order swap function
  mei: vsc: Enhance SPI transfer of IVSC ROM
  mei: vsc: Fix spelling error

 drivers/misc/mei/platform-vsc.c  |  4 ++--
 drivers/misc/mei/vsc-fw-loader.c |  2 +-
 drivers/misc/mei/vsc-tp.c        | 18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.34.1


