Return-Path: <linux-kernel+bounces-293591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F70B9581B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EE6283B99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0118B46B;
	Tue, 20 Aug 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SY9s2y1b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CDF18A95C;
	Tue, 20 Aug 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145042; cv=none; b=XhSvJkbDjjyeOrVN0CStcEQJYyi33kbTI6Eyya1WsRRgg3q4QCYm3ERi7jThkG3M3AR8l3of6i5ZdVecznJbu4QD2zL2GU181Weohu/w4EzTVrgRfZJ2Ki4u5mzAeu8TotJX87wU8lMQslMtnmK/iL7dtVzkRXGw5hbTqUC+iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145042; c=relaxed/simple;
	bh=BX1r3zrfEWOMj2jiP7YkdtjotbuSWMca6CHka2Ive34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyhaI4frCE+Yu3F6jPa4qJHENGIG7DiCO26Szk7XdTJ+fNsIsfGaMmPRGa92ovDkQL87zimJqCpQQyQD9fFyOqRWWnFfVzpA9F8kfFpfNF0NIuHPfmC2e/OTDvvAqcnwa9/Tlmt1WObeDI3nkrEUu2WK+JqWySP4cjnCYki5VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SY9s2y1b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145040; x=1755681040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BX1r3zrfEWOMj2jiP7YkdtjotbuSWMca6CHka2Ive34=;
  b=SY9s2y1bX2cB7+kqOggub7iEUnbQ0y7gZK6wCJgWnBHUCP2QCmmY7Xm5
   l3hXJyFo2HZxc12/JuM9B2YVwnFIzJ3aP4ydk1oBO6YVT+s0HXpIUDB5e
   A/tzyicXpFWFFDPslDMX5wke7ZBS2XNf11ducgUr52kaTzaq+SpJB6/VJ
   OF0Qdm2m++7mS31mqOV1GCn+pUG/H52Nw9hgcii///HSd9q8lTkcCaDti
   YY5DQkKNU4A1aJO79FCKPYcyqvaV5GI+NcBhFEmcztE2a0QcOxr9azOPQ
   zh7WWdkRS61mbJshCNrdfNuV6kq8M6FRLfADPM19atr6K1gcDxXRcsPPc
   w==;
X-CSE-ConnectionGUID: JvaariUJQnCBX7wz1jW8sw==
X-CSE-MsgGUID: PzUPHeTKTfWe3qonYVLZIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39889204"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="39889204"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:10:39 -0700
X-CSE-ConnectionGUID: B1evMYbOQaq6rNpc/HKaNg==
X-CSE-MsgGUID: F3rrUa/vQUOPNKomeCJUlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60504971"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2024 02:10:37 -0700
From: subramanian.mohan@intel.com
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
	thejesh.reddy.t.r@intel.com
Subject: [PATCH v11 0/3] Add support for Intel PPS Generator
Date: Tue, 20 Aug 2024 14:40:32 +0530
Message-Id: <20240820091035.71288-1-subramanian.mohan@intel.com>
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

Patch 1 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 2 documentation and usage of the pps tio generator module.
Patch 3 includes documentation for sysfs interface.

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

Subramanian Mohan (3):
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

 .../ABI/testing/sysfs-platform-pps-tio        |   8 +
 Documentation/driver-api/pps.rst              |  24 ++
 MAINTAINERS                                   |   1 +
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 262 ++++++++++++++++++
 6 files changed, 312 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


