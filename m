Return-Path: <linux-kernel+bounces-226539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CA914021
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56641C21B43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B84414;
	Mon, 24 Jun 2024 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxx1kG/e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE21FAA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193395; cv=none; b=eXWXJn49/emP6uanjyxWaOF6BVyHWdMUpAoM6+Bu7sLSndQMNsvlt5PNj1XQTvIE/CVN6CaDA/eVF0z2ElSmd1fW8hKVL7113BNp7BsgiRK0P8sKAamaPJH+fDKjPATu52hHtt9R9VghKvpkFlFdJQZuMknObb2OnWvgD8wMGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193395; c=relaxed/simple;
	bh=jCl3O5dV5d6DMpZu3smPaGwRINEJpFKNIlJvn9Fjsfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFh17Xlw0f9dZJ/62T6sPBzUBbyYbfKZFBq73gaWU+lUOmOUgqi1dGROq1j+slK+bIYk6U2AKOcyfF1I5+ML5nvrtqpL8FUC66QBJu/9REc3rKTjz0O7C+yYBGZ+9BxGlTEBMf1RGKYkGpXkEH6mCi2QoOfavS3h8UayptD1BdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxx1kG/e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193394; x=1750729394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jCl3O5dV5d6DMpZu3smPaGwRINEJpFKNIlJvn9Fjsfc=;
  b=Qxx1kG/eIO3tg8PkCiM/G3j8thg610QFnNxonv58JpuHkrssWmzv5XYo
   X/tYUW4vHYOlDOBzU+OsBjeN3U1FJNcmMa08bNao3myR2I/M9tbWjV9vJ
   GfqXzeft6U8zfgF0ycSzCIMMvSKxZ81MxU2j2qAGE4pyKSw/fUQQP21hA
   6oHYHTl4czQxi8iEuPjZV2W7iFeAdAQdRwIhM2savedVRkfNwt0EIvgpH
   83WOAqdVX/zbDRAdU2IHN9RUKHpPml9Q5+iw5wkLDiS8j6O4QoHA1x0pN
   zBUdJWcr7VreWBXonsuTbya2AsMR+O1wL95VfptmmdpMpSdR9XNITO/lc
   w==;
X-CSE-ConnectionGUID: +q2BABtUQR6RBFOf8gzGWQ==
X-CSE-MsgGUID: QbawSHIRTH6iaGzukw8UqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202743"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202743"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:13 -0700
X-CSE-ConnectionGUID: X0yUEwjASBCvhHgL8WGs9g==
X-CSE-MsgGUID: dIVT0Sl6SoOmZLLjm3p3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821140"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:12 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v2 0/5] Fix MEI command timeout issue following warm reboot
Date: Mon, 24 Jun 2024 09:42:18 +0800
Message-Id: <20240624014223.4171341-1-wentong.wu@intel.com>
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
3) Constructing the SPI transfer command as per the specific request.

---
v1 -> v2:
 - remove cc spelling fix to stable
 - remove the reset toggling enhancement

Wentong Wu (5):
  mei: vsc: Enhance IVSC chipset stability during warm reboot
  mei: vsc: Enhance SPI transfer of IVSC rom
  mei: vsc: Utilize the appropriate byte order swap function
  mei: vsc: Prevent timeout error with added delay post-firmware
    download
  mei: vsc: Fix spelling error

 drivers/misc/mei/platform-vsc.c  |  4 ++--
 drivers/misc/mei/vsc-fw-loader.c |  2 +-
 drivers/misc/mei/vsc-tp.c        | 18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.34.1


