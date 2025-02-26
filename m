Return-Path: <linux-kernel+bounces-533065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212CAA4555A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AA3178228
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE319D884;
	Wed, 26 Feb 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VplUj63z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F029D0E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550560; cv=none; b=frTFgCYArXlJfkVE/vR0U9i628N5jtqMqRjvsHWzVB8rIlWTs0xZ4njxhwMeZGomX6Eowj3TakOL89F5rTjxJld6rkctcTAsOtkwQJNq5p6zqSKplJSa1vyxrl+xilIrVCy3HiCpcbwx7fOhVg93Gym/83vVPUSNzRqpc0lsxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550560; c=relaxed/simple;
	bh=O6xdTY2TSK23kQyeRKeqYcYvMDwIAKPWeHzCD37TqEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAvYj3eA9sXcb3PikZxRC1avM+k4SWpQ2oIYG4mTRLvWn+KZONgeiAbTieCU8f+4ETM5zOHSwithmNmaEeYfVXYuKQHTrBQhiUCTVTvoq37r+grDyEic6gWCSBDxjydd8wGK75smjUQUKKrRZAafRWy1LhAol6OpFcc4GUae038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VplUj63z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550559; x=1772086559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O6xdTY2TSK23kQyeRKeqYcYvMDwIAKPWeHzCD37TqEA=;
  b=VplUj63zwBm6QO/10z+kVduIweubHMTSe1x3tnzRvTnD0PhstKhwMDtZ
   e1gXy37s39VL1yhc2N6C4RuJStOpypY3+MARcpxK/eqgYZWWGa/5qIA0B
   6ddG/qQoWa3eu8NP8jFqk53+NxEhBULvAvZ+8ovpkCb1psU2P2DtbiZRA
   oAVndvs7mUxtp0rhz7X+myKlZ6XWXiNoHnGpWht26ASo0Fz7lEgVbggx7
   pnO7TklL3h91AFaGJiAQdI9rLXvwUV91XAwIbDgajWNbokaPPZ47eCBha
   8+poAYXb5lgPCNFkocX26b8p7MbmddPzK7n9SPd9E2TeMFBYIJRCVu2Lz
   Q==;
X-CSE-ConnectionGUID: s0OsCuaNQM6JIwT8uqUmPw==
X-CSE-MsgGUID: HmX9vGjNQBSQvZO2fjYUIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41636469"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41636469"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:15:58 -0800
X-CSE-ConnectionGUID: sjdJIhmVQBqvL+Mdr8GN5Q==
X-CSE-MsgGUID: 6BsXpdKDSl6TFxbhZSa7hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147434821"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 22:15:55 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lee@kernel.org,
	giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/4] Introduce Intel Elkhart Lake PSE TIO
Date: Wed, 26 Feb 2025 11:45:23 +0530
Message-Id: <20250226061527.3031250-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Elkhart Lake Programmable Service Engine (PSE) includes two PCI
devices that expose two different capabilities of GPIO and Timed I/O
as a single PCI function through shared MMIO.

This series adds MFD driver for them and extends PPS generator driver
to support initial PSE TIO functionality.

Raag Jadav (4):
  pps: generators: tio: split pps_gen_tio.h
  pps: generators: tio: move to match_data() model
  pps: generators: tio: Introduce Intel Elkhart Lake PSE TIO
  mfd: intel-ehl: Introduce Intel Elkhart Lake PSE GPIO and TIO

 MAINTAINERS                          |  5 ++
 drivers/mfd/Kconfig                  |  9 +++
 drivers/mfd/Makefile                 |  1 +
 drivers/mfd/intel-ehl-gpio.c         | 95 ++++++++++++++++++++++++++++
 drivers/pps/generators/pps_gen_tio.c | 74 +++++++++++-----------
 drivers/pps/generators/pps_gen_tio.h | 63 ++++++++++++++++++
 6 files changed, 211 insertions(+), 36 deletions(-)
 create mode 100644 drivers/mfd/intel-ehl-gpio.c
 create mode 100644 drivers/pps/generators/pps_gen_tio.h


base-commit: 264ff8415aed324584acc85740596f6e1df7b663
-- 
2.34.1


