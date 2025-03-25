Return-Path: <linux-kernel+bounces-575646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAAEA7052F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EC81889DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8E1A2389;
	Tue, 25 Mar 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9zldzq9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884B1922C6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916932; cv=none; b=Mg04f64y33szliD9esfWKWVa2/UwNn4iAqTZL3xDvL/6mdW5ABbQ1o3KUVoLQcaeLNNdi1Tr6+zMF6GzdV8dLnYnylBYRIrxRnKwbpMsx1mww0soeYUV6nEbFe5UhiJ1SHgwcKEYmnMCHXwlvjUXdyzQtCs9/dXzcWIbw651nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916932; c=relaxed/simple;
	bh=rASjszrGh02cnJN1mczTWnhvEciBmo929b7n0IRMsFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YGIUiYXh1b47ZfdT40UGirSRj6iFkFIrqazUY1zC9fOSlINhUTYTzThePHoPAc+Uy3WC+PVlXJ9f/gUIA0lw/iPdLFBlQ6IOLANwA5w15vR/wVxK173FJCIU40Q+I71mjbweks2OHvB9CkSvTVB2HpZawNkL/a8/8DFuXIw5d3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9zldzq9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742916931; x=1774452931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rASjszrGh02cnJN1mczTWnhvEciBmo929b7n0IRMsFg=;
  b=G9zldzq92VBPwYtcZhci0LNIGJecRXSk/rq7iJudGY9n2AQC1PWEb4zE
   ew1F4bxjyxeXYV8JMx9P8h/RzZpz5taozBnlM7Mj11QItbpj2HHY4nduL
   pyit7NEbyIQlekN7Zrll5giMhU178Vmq0A0ygj4ACEKUL4eob3AnAXWh9
   OrcWxCWn0Msm3qSas2A4wWnWXKwiKMnTIOOL/HFcnQQFVNzEXjeuVs5kN
   D2gzDgK7MOMmo9JChyFh7891mKzWXH1wPpGqCCStUOMAKwpGxqR8ZgTZz
   v3aT5OXxJIOA/zgUHj9IFfKpsNUbblFv1WL3XaKhKjE4X2RCLv6FY8jDV
   g==;
X-CSE-ConnectionGUID: YnvG+/M0TgWJ62ItJCIJIw==
X-CSE-MsgGUID: 1Pjvta6lQDOBBPCCqHm0Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="66627279"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="66627279"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:35:30 -0700
X-CSE-ConnectionGUID: iE7FiNQARtiLkwZVmKFd3Q==
X-CSE-MsgGUID: HjiNYWRERsuLBG9hOp50ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124595850"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 25 Mar 2025 08:35:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BAFA62D8; Tue, 25 Mar 2025 17:35:27 +0200 (EET)
Date: Tue, 25 Mar 2025 17:35:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] auxdisplay for 6.15-1
Message-ID: <Z-LNP8zSHOHSLVhZ@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Hi Linus,

I would say it's an average size PR for this small subsystem. Patches were in
the Linux Next for a while (more than a couple of weeks) without reported issues.
It also includes a merge of an immutable tag from GPIO that is used in one of
the cleanups here. Please, pull for v6.15-rc1.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.15-1

for you to fetch changes up to 67200d70e45982f5120c43b3724f1b6e4a8a01e4:

  Merge patch series "auxdisplay: charlcd: Refactor memory allocation" (2025-03-10 18:03:02 +0200)

----------------------------------------------------------------
auxdisplay for v6.15-1

* Refactor a couple of APIs to reduce amount of calls to memory allocator
* Miscellaneous small fixes and improvements

The following is an automated git shortlog grouped by driver:

charlcd:
 -  Partially revert "Move hwidth and bwidth to struct hd44780_common"

gpiolib:
 -  add gpiod_multi_set_value_cansleep()

hd44780:
 -  Rename hd to hdc in hd44780_common_alloc()
 -  Call charlcd_alloc() from hd44780_common_alloc()
 -  Make use of hd44780_common_free()
 -  Introduce hd44780_common_free()
 -  Fix an API misuse in hd44780.c

lcd2s:
 -  Allocate memory for custom data in charlcd_alloc()

MAX6959 should select BITREVERSE:
 - MAX6959 should select BITREVERSE

panel:
 -  Make use of hd44780_common_free()
 -  Fix an API misuse in panel.c

seg-led-gpio:
 -  use gpiod_multi_set_value_cansleep

----------------------------------------------------------------
Andy Shevchenko (10):
      Merge tag 'gpio-set-array-helper-v6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into auxdisplay
      auxdisplay: panel: Fix an API misuse in panel.c
      auxdisplay: charlcd: Partially revert "Move hwidth and bwidth to struct hd44780_common"
      auxdisplay: lcd2s: Allocate memory for custom data in charlcd_alloc()
      auxdisplay: hd44780: Introduce hd44780_common_free()
      auxdisplay: hd44780: Make use of hd44780_common_free()
      auxdisplay: panel: Make use of hd44780_common_free()
      auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
      auxdisplay: hd44780: Rename hd to hdc in hd44780_common_alloc()
      Merge patch series "auxdisplay: charlcd: Refactor memory allocation"

David Lechner (2):
      gpiolib: add gpiod_multi_set_value_cansleep()
      auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep

Geert Uytterhoeven (1):
      auxdisplay: MAX6959 should select BITREVERSE

Haoxiang Li (1):
      auxdisplay: hd44780: Fix an API misuse in hd44780.c

 drivers/auxdisplay/Kconfig          |  1 +
 drivers/auxdisplay/charlcd.c        |  5 +++--
 drivers/auxdisplay/charlcd.h        |  5 +++--
 drivers/auxdisplay/hd44780.c        | 19 ++++++-------------
 drivers/auxdisplay/hd44780_common.c | 24 ++++++++++++++++--------
 drivers/auxdisplay/hd44780_common.h |  4 +++-
 drivers/auxdisplay/lcd2s.c          | 12 ++++--------
 drivers/auxdisplay/panel.c          | 17 +++++------------
 drivers/auxdisplay/seg-led-gpio.c   |  3 +--
 include/linux/gpio/consumer.h       | 11 +++++++++++
 10 files changed, 53 insertions(+), 48 deletions(-)

-- 
With Best Regards,
Andy Shevchenko



