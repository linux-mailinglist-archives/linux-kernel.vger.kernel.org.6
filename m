Return-Path: <linux-kernel+bounces-304746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B8962445
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E9E1F2526D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99D167296;
	Wed, 28 Aug 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYRNGWIK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A215B57A;
	Wed, 28 Aug 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839518; cv=none; b=DidFkneFafNxNlv1TZMQtZSVFw1e7niqm7FQtk4oVVaipX8SQ1eyr8xdQFpcVbG+qPP+HoVgblNveni0gjkvDM++p2SUOp8kApioenTgf1DPgfGg+KO8XjAQaqIWZxi7pdShMWPbccME6wp4GSX41KY2GHeVw+A7hCSXEt3moDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839518; c=relaxed/simple;
	bh=nbZWOGGs7V+IKSDTacg3uSEez86F3BUFm3ENgDB+gm8=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=KiCkho/24twjruQWZcS+mhK9XPmhbiJEOe29nqQbGcBz2e9a8xIXoRZs73ob28HI4f24TYygfkSeoB1qggT3p435EhoeFzwXssufJy7bD00wpSLtTz7LGWkmZKHi1RYj0SpVcPzwuPNjUA8jOLCvdyqBQsC1j1XhzeIXZlNUEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYRNGWIK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724839517; x=1756375517;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nbZWOGGs7V+IKSDTacg3uSEez86F3BUFm3ENgDB+gm8=;
  b=XYRNGWIK1+aXp97QAPtubM2doBi6L14naQBk6CCp9Zs0OrzlsvJIy3sA
   PJyOJ8j0z2fY2DKuFkQcPgoLB2Cj9kDUcoCxZZeOh+REqsbEUZTC0bzrt
   DGdWnPc5ABTYVq0IrQVrhKSMmGxTum/yQlB7H3yxefC4afrVx9r4Sq5/y
   SE3Bu76vUtjkixCgXrt/YzJXLEMFThqmjpBV9yEr7swyNQWiyfrYQjBuO
   hDlBxnuaKln4O4ls6ZAKDSiS7XpMFUoZ7JiFkXnQ/XB4QMVzUbhMRBkd4
   cM+KHbCofmGe0mDeYVaCjIPsQzN6nVcHNJ+QvYWROHdTpiVYb9tRHmOR9
   Q==;
X-CSE-ConnectionGUID: 70za5EuYRyGra7uBTxVvuQ==
X-CSE-MsgGUID: TA8eoB81SrmV/0WTGFDOpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23521225"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23521225"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 03:05:16 -0700
X-CSE-ConnectionGUID: S2tB1/3/SWqkqfDEFSXA4Q==
X-CSE-MsgGUID: HHLkffQER7SfSSzcVhMr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63507420"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.205])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 03:05:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 28 Aug 2024 12:52:37 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-5
Message-ID: <pdx86-pr-20240828125237-2776213950@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.11. None of the change looks
complicated. In case you wonder, there are more IDs added to AMD PMC in this
PR as it turned out the previous ones were not sufficient.

Changes:
- platform/x86/amd/pmc: AMD 1Ah model 60h series support (2nd attempt).
- asus-wmi: Prevent spurious rfkill on Asus Zenbook Duo.
- x86-android-tablets: Relax DMI match to cover another model.

Regards, i.


The following changes since commit 46ee21e9f59205e54943dfe51b2dc8a9352ca37d:

  platform/x86: ISST: Fix return value on last invalid resource (2024-08-20 14:19:09 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-5

for you to fetch changes up to a3379eca24a7da5118a7d090da6f8eb8611acac8:

  platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict (2024-08-26 14:34:33 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-5

Changes:
- platform/x86/amd/pmc: AMD 1Ah model 60h series support (2nd attempt).
- asus-wmi: Prevent spurious rfkill on Asus Zenbook Duo.
- x86-android-tablets: Relax DMI match to cover another model.

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Extend support for PMC features on new AMD platform
 -  Fix SMU command submission path on new AMD platform

asus-wmi:
 -  Fix spurious rfkill on UX8406MA

x86-android-tablets:
 -  Make Lenovo Yoga Tab 3 X90F DMI match less strict

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Mathieu Fenniak (1):
      platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Fix SMU command submission path on new AMD platform
      platform/x86/amd/pmc: Extend support for PMC features on new AMD platform

 drivers/platform/x86/amd/pmc/pmc.c             |  3 +++
 drivers/platform/x86/asus-nb-wmi.c             | 20 +++++++++++++++++++-
 drivers/platform/x86/asus-wmi.h                |  1 +
 drivers/platform/x86/x86-android-tablets/dmi.c |  1 -
 4 files changed, 23 insertions(+), 2 deletions(-)

