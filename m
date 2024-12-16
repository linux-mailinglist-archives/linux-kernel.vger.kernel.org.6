Return-Path: <linux-kernel+bounces-447578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791C9F346F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89FA163FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95D1494C9;
	Mon, 16 Dec 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4lfS0My"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA8145B0F;
	Mon, 16 Dec 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362670; cv=none; b=GQYJ9Q7xcUqPZz8b7MPV4y1FKmAYw6WCG2uuLOyJ1GrvxqJ9/JuRov3k2M7cjQ0cAGNBfFh2+7ts45xd07eoSamFAb61TjSt3i6h7cghcr2dDRYrw3tVGB82isEvb7Q3O+TZwUaKX0d28Vtk9kW+mu1G6kB8lybGRYUlUjcSAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362670; c=relaxed/simple;
	bh=0d23xLZt8sQeDr7wpfe9AmxI6AbFbgA+WGITRjsS86c=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=jyb4Z91aShUogOyXVaXjkmP2eGdDyaWwQrx1Uc2itwR+YsHwtV+Q2CMwsByIK1fm7VRtUHrmBku3ifnYBee7lsXZl5T4RJmwqQep9EtHkYh0BMDMqVFChpWdmycVOk9YBVrCKccd9vyBBom8iU3dfA9tOIh/rO1E8wUlnHfdXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4lfS0My; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734362669; x=1765898669;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0d23xLZt8sQeDr7wpfe9AmxI6AbFbgA+WGITRjsS86c=;
  b=K4lfS0Myk3v+6TXDMfFNdNmjNR9VD+kwB7pbQKFeOm0sPW9KBSA7zK9V
   6k1LX0e0i8zGksPDhhPv1//+aC4do7DMElcnU/ZcKw03e0p8uKvs+WZek
   1/61W74R/5pvVZFpoMX0XWzTWGVBD/8GdpWTx2xHSa01VL1ksgUO/dNAj
   rBdzkXsY3fJmPRWnt815oyQe9gb5+tLuiNt1YY/xcUpPKiXKptk+0fLGA
   7ULfMArQxVmVF0vc5AsYnLbbJ2wXoOW1HT+m+BahpDGfR2mxtPT8LgYwN
   5aegBz/qLrMfRBiVOFP+QXnc/4nhasFX6lPykIlBqHybN2e+lfui+Amn1
   Q==;
X-CSE-ConnectionGUID: 6++J6pXcQsuCDYiKuzifTQ==
X-CSE-MsgGUID: ntDG2/xdT6+tYKxRVl34fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="46162442"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="46162442"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:24:28 -0800
X-CSE-ConnectionGUID: pi3unQFTTmGZERk7fk26Cw==
X-CSE-MsgGUID: yZ1g/PZeQ9aK/pSHeGRpOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98020181"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 07:24:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 16 Dec 2024 17:22:00 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.13-3
Message-ID: <pdx86-pr-20241216172200-163654424@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.13.

Fixes and new HW support:

 - alienware-wmi: Add support for Alienware m16 R1 AMD.

 - alienware-wmi: Do not setup legacy LED control with X and G Series.

 - intel/ifs: Clearwater Forest support.

 - intel/vsec: Panther Lake support.

 - p2sb: Do not hide the device if BIOS left it unhidden.

 - touchscreen_dmi: Add SARY Tab 3 tablet information.

Regards, i.


The following changes since commit e9fba20c29e27dc99e55e1c550573a114561bf8c:

  platform/x86: asus-nb-wmi: Ignore unknown event 0xCF (2024-12-02 18:57:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-3

for you to fetch changes up to 83848e37f6ee80f60b04139fefdfa1bde4aaa826:

  platform/x86/intel/vsec: Add support for Panther Lake (2024-12-11 16:00:56 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.13-3

Fixes and new HW support:

 - alienware-wmi: Add support for Alienware m16 R1 AMD.

 - alienware-wmi: Do not setup legacy LED control with X and G Series.

 - intel/ifs: Clearwater Forest support.

 - intel/vsec: Panther Lake support.

 - p2sb: Do not hide the device if BIOS left it unhidden.

 - touchscreen_dmi: Add SARY Tab 3 tablet information.

The following is an automated shortlog grouped by driver:

alienware-wmi:
 -  Adds support to Alienware m16 R1 AMD
 -  Fix X Series and G Series quirks

intel/ifs:
 -  Add Clearwater Forest to CPU support list

intel/vsec:
 -  Add support for Panther Lake

p2sb:
 -  Do not scan and remove the P2SB device when it is unhidden
 -  Factor out p2sb_read_from_cache()
 -  Introduce the global flag p2sb_hidden_by_bios
 -  Move P2SB hide and unhide code to p2sb_scan_and_cache()

touchscreen_dmi:
 -  Add info for SARY Tab 3 tablet

----------------------------------------------------------------
Huy Minh (1):
      platform/x86: touchscreen_dmi: Add info for SARY Tab 3 tablet

Jithu Joseph (1):
      platform/x86/intel/ifs: Add Clearwater Forest to CPU support list

Kurt Borja (2):
      alienware-wmi: Fix X Series and G Series quirks
      alienware-wmi: Adds support to Alienware m16 R1 AMD

Shin'ichiro Kawasaki (4):
      p2sb: Factor out p2sb_read_from_cache()
      p2sb: Introduce the global flag p2sb_hidden_by_bios
      p2sb: Move P2SB hide and unhide code to p2sb_scan_and_cache()
      p2sb: Do not scan and remove the P2SB device when it is unhidden

Xi Pardee (1):
      platform/x86/intel/vsec: Add support for Panther Lake

 drivers/platform/x86/dell/alienware-wmi.c | 24 ++++++++--
 drivers/platform/x86/intel/ifs/core.c     |  1 +
 drivers/platform/x86/intel/vsec.c         |  2 +
 drivers/platform/x86/p2sb.c               | 77 ++++++++++++++++++++++---------
 drivers/platform/x86/touchscreen_dmi.c    | 26 +++++++++++
 5 files changed, 103 insertions(+), 27 deletions(-)

