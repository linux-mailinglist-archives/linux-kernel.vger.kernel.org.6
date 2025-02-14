Return-Path: <linux-kernel+bounces-514644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E80A359AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86D91891781
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A722CBF7;
	Fri, 14 Feb 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIqWzvco"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70817211497;
	Fri, 14 Feb 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524100; cv=none; b=uNNwFYgqPX4p8d7oZpW37/5NltZ0MiJa8eis2R2OIAN48s0C1MbIREr0aYaNcZ3PUKQ0EYdtbVQXuTqYyvJDksxU/GKUnF6j42vD/5o0kTj6YzgsFhNVf3UNYtYCxU8iNkG4l89cGYw1qySGoiXGlUvj86TRKa3q5JOR4STqKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524100; c=relaxed/simple;
	bh=0JzTWN6wUPtJeL/o+wpV1b/rj6YfptImOLmfDxUrVzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VX05VzIRQcx+I4qGAInLznYVatvoeuH2h3iWCWpp7Qrp2knXDsE0MdzWYzKsTkxHqSJRE6eEhjpN+DVcrX53ZN4XPJYCJLXK96roqTyH1kQMHVqrvyF3VfpYwL/1NHremYl167SqHeT4SrjVTRz+NDvEyWJ/T87xnDr46iHhAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIqWzvco; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524098; x=1771060098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0JzTWN6wUPtJeL/o+wpV1b/rj6YfptImOLmfDxUrVzw=;
  b=BIqWzvcoy5tUSnqtPBAWswofk8by9aZ+oTv9KPImmxrYKUxTQ5gahzAB
   dfBnd0PChJWsYD2NnRtmGSJp8g71WwQmlyLe8GwfPNwXWF/nZ0MJ/CMMK
   2fy5l+43Ac4Khm525svJUr5WJlUT7lmKUn5aIHxw9SnMOKCqLXO/4uW0M
   56fptTnZtTqdGr9cEqIWVkMcMN9fVYqciINCIHt+xKLhM8Xppik0Q/1VZ
   9bbgTXgVqJajGIvsZ3+gvEhMgbgtunMkuQKdin8vP9AAOhlNAEDw0Mwwx
   CP3vFvaOTP7J6xAJ6CEdmMcWvKBalhbaDLFjqX0FnaJeYff3pVKKlLk7D
   A==;
X-CSE-ConnectionGUID: s1ePcxSQRiaxa/RdFTieUQ==
X-CSE-MsgGUID: mN4VDIhARZ+Z2jho7ldsZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51694738"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51694738"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:17 -0800
X-CSE-ConnectionGUID: HqfMZC/CTr6rJVxU8mrbeQ==
X-CSE-MsgGUID: 0VJu2ws5RzyDUPPMdRkIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114302908"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2025 01:07:56 -0800
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
Subject: [PATCH v14 0/4] Add support for Intel PPS Generator
Date: Fri, 14 Feb 2025 14:37:51 +0530
Message-Id: <20250214090755.37450-1-subramanian.mohan@intel.com>
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

Subramanian Mohan (4):
  drivers pps/generators: replace copy of pps-gen info struct with const
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


