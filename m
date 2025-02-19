Return-Path: <linux-kernel+bounces-520869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB8A3B040
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F93AC083
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B61A2622;
	Wed, 19 Feb 2025 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eo0HPkAw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34889286289;
	Wed, 19 Feb 2025 04:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937985; cv=none; b=iRpmwSOx/mDBLHNLHAhz6YU7ueTZCb3N7HR6cVwS61oKF9cnOVXRTra9K5qqek2M8Di174z/WLQVwOjPlZje65qmXALKdYHEpcyCeWRQ0k2UtaaKdDT9IVsEf25Nhd7zpOYmVY5P7fRdUVb8N8kvoCvwupmQz6ZZNAsj5MivpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937985; c=relaxed/simple;
	bh=3sEbX9qTc/nvIRxGy6mOXvo4BU0S2rDQMIzkqhfrtDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G925UaKHIPg1U8a5JRlrACNt36vQKAQ57818z/EJ/XgOIOROCYD6UDimql0TrAEHaSb0z6FT0n3C3d7yEnOa68q9RNNP7GEkzGg+mOCGR8pGHCTWcoiCA/pNe0+8Ov4N8r6SNoiey/hwoAeMBpEriP4y02Ek4AJfwUDHNOFvaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eo0HPkAw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739937984; x=1771473984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3sEbX9qTc/nvIRxGy6mOXvo4BU0S2rDQMIzkqhfrtDw=;
  b=eo0HPkAwWboO9n2g2Wv3lLfGEMXnvcF0OWq8H6hegmycTQJ/L+NKIFua
   ex2RMQFF1Vzt+cGlna2iUgi+fWWDOaLuVm+AblQ/haooZmOvGTy1MsJTX
   zOgm9+UupXW+KHhL1NHpEIz4AmNiBY1JxSd0rC9Efmlo2OLogkBLFsg+r
   Bgq9JLbx0jR5O4s0Cj3M9mqIYLDseudB3+SayxibqZWumdLervVDJ4hOa
   DhN0wryTG9PpXzk0TidB8LOzsdUQITuM9YlS7vZI/H+XLy3KnUJnzhsJI
   da4Cq95txkSVz4/rG8vbJtzEj1Zw21gH43bcUF96L6d017mNxLMRPfxCo
   A==;
X-CSE-ConnectionGUID: 4DYQlXYjT5ayp9Pl5Hao8g==
X-CSE-MsgGUID: 0TQ2f8QdRYaPmf/2+RQVQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44579137"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44579137"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:06:23 -0800
X-CSE-ConnectionGUID: 6G6vogaASrGDp2ez1bpBEQ==
X-CSE-MsgGUID: DBs9gAB/R42cvO+9GY6cUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119703797"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 20:06:19 -0800
From: subramanian.mohan@intel.com
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	giometti@enneenne.com,
	tglx@linutronix.de,
	corbet@lwn.net
Cc: eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v15 0/4] Add support for Intel PPS Generator
Date: Wed, 19 Feb 2025 09:36:14 +0530
Message-Id: <20250219040618.70962-1-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subramanian Mohan <subramanian.mohan@intel.com>

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

Patch 1 Replaced copy of pps-gen info struct with const pointer in
pps-gen framework..
Patch 2 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 3 documentation and usage of the pps tio generator module.
Patch 4 includes documentation for sysfs interface.

These patches are based on the timers/core branch:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=timers/core
These changes are dependent on patches that are merged in [1].

Please help to review the changes.

Thanks in advance,
Subramanian Mohan

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

Changes from v9:
 - use tio->enabled instead of reading ctrl register.
 - change error code in enable_store to -ENODEV.

Changes from v10:
 - Rebased to latest codebase.

Changes from v11:
 - Rebased to latest codebase.

Changes from v12:
 - As part of pps-gen framework, Replaced copy of pps-gen info struct
   with const pointer.
 - TIO driver adapted to pps-gen framework.
 - Fixed review comments by Andy.
 - Rebased to latest codebase.

Changes from v13:
 - Fixed review comments by Andy.
 - Rebased to latest codebase.

Changes from v14:
 - Fixed review comments by Andy.
 - Rebased to latest codebase.

Subramanian Mohan (4):
  pps: generators: replace copy of pps-gen info struct with const
    pointer
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

 Documentation/ABI/testing/sysfs-pps-gen-tio |   6 +
 Documentation/driver-api/pps.rst            |  27 +-
 MAINTAINERS                                 |   1 +
 drivers/pps/generators/Kconfig              |  16 ++
 drivers/pps/generators/Makefile             |   1 +
 drivers/pps/generators/pps_gen-dummy.c      |   2 +-
 drivers/pps/generators/pps_gen.c            |  14 +-
 drivers/pps/generators/pps_gen_tio.c        | 272 ++++++++++++++++++++
 drivers/pps/generators/sysfs.c              |   6 +-
 include/linux/pps_gen_kernel.h              |   4 +-
 10 files changed, 334 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


