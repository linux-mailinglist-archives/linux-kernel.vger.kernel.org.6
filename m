Return-Path: <linux-kernel+bounces-202841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933C8FD1C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE3B29D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245114AD2D;
	Wed,  5 Jun 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObjBWPAK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EC17BCD;
	Wed,  5 Jun 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601763; cv=none; b=VejsY1o5zujx6xj34rmsx27dJkhMTg4zT4spZ0En73wyDT2nbseASOARFNY+eS6QcoEuI/3ZaoICuLb8rLJp1/yjvp4sPquUAQj1ACLttT+VFf2iRId69Qs2F1BkXj7/fCfIke3d7hPRjFEQmrBXoW2JHYB12Yshpsj1TbBKoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601763; c=relaxed/simple;
	bh=GOYpM4/dfC29NdGSB+aunhpkeRtHnHQ0+apnw8FNPqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzpiiR/sP/i5VNcIBu0XTRPvfHlo4nKvFToGwBZhZ1uG7aUkHV4yilfay9Xhw98bHM6XZ0fA2geoEPmoqePbgQtcG88uVBbD3CITHSajRHuSDX57GpsHgZcxZv7bjJPECvcwu52dF7qbMX23bYp/fbvEsioIWl2tOv25Mf/ziZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObjBWPAK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601762; x=1749137762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GOYpM4/dfC29NdGSB+aunhpkeRtHnHQ0+apnw8FNPqM=;
  b=ObjBWPAKG9H7CSFZh3Dj9kpDIEAjp00Jn8hKNiSjDKLfZ7DvPd6ziVch
   MgFVwclAESbdgCz3kf6CRgZu03UFN6dhjUu5+EktTH3Mh+ezm6TfstD/s
   c8zS5rLtErMLBhWmNRn3R/NK6MRwiuYvF2EU764598tgTA3uZ3ZtpKNkS
   vFEjDdNndkPq5eZWe7FHLoDFC0TCInje9S93YV4T94TWB4fsqGi89Wiua
   s/yoOxttkdKE56CS1jxyTw9T1A/ueA6dvduOzhGblMZ8J7kNg0tV0lG5f
   YQlNXvWl32F7jqcYS/ntYLuewBDmmp2Gos6J5tuean0aNSfaLYJpUkrKN
   Q==;
X-CSE-ConnectionGUID: TANsHIgDTxy/nhuLFf84Fw==
X-CSE-MsgGUID: jWUmypBnSDS0XWaGgAevaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14105997"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14105997"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:35:59 -0700
X-CSE-ConnectionGUID: nOM8ICnRQnyGyDu/7ttjHw==
X-CSE-MsgGUID: fNFn4dViR/OmWm9ehxFgJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37765242"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2024 08:35:56 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v9 0/3] Add support for Intel PPS Generator
Date: Wed,  5 Jun 2024 21:05:51 +0530
Message-Id: <20240605153554.11584-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS (Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second (PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.
Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw
 
Patch 1 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 2 documentation and usage of the pps tio generator module.
Patch 3 includes documentation for sysfs interface.

These patches are based on the timers/core branch:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=timers/core
These changes are dependent on patches that are merged in [1].

Please help to review the changes.

Thanks in advance,
Sowjanya

Changes from v2:
 - Split patch 1 to remove the functions in later stages.
 - Include required headers in pps_gen_tio.

Changes from v3:
 - Corrections in Documentation.
 - Introducing non-RFC version of the patch series.

Changes from v4:
 - Setting id in ice_ptp
 - Modified conversion logic in convert_base_to_cs.
 - Included the usage of the APIs in the commit message of 2nd patch.

Changes from v5:
 - Change nsecs variable to use_nsecs.
 - Change order of 1&2 patches and modify the commit message.
 - Add sysfs abi file entry in MAINTAINERS file.
 - Add check to find if any event is missed and disable hardware
   accordingly.

Changes from v6:
 - Split patch 1 into 1&2 patches.
 - Add check for overflow in convert_ns_to_cs().
 - Refine commit messages.

Changes from v7:
 - Split the if condition and return error if current time exceeds
   expire time.
 - Update kernel version and month in ABI file.

Changes from v8:
 - Add function to enable Timed I/O.
 - Changed the updating of tio->enabled to a centralized place in
   disable and enable functions.

Lakshmi Sowjanya D (3):
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 MAINTAINERS                                   |   1 +
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 268 ++++++++++++++++++
 6 files changed, 315 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


