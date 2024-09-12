Return-Path: <linux-kernel+bounces-326235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C197654F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4B52851A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6703119C554;
	Thu, 12 Sep 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhrXTs7U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B719006A;
	Thu, 12 Sep 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132567; cv=none; b=CRt6SRCxzmEhRE4MRQgwKRvTZLjiOg1AgnMHoQpVXGI8bNZ/4pk4lKlo/1oCpYNTqyMK62myWhi+fvR9R6ZseVUVysBTB/6tD1O1UUP1Y3M2rBIgZr7bUASOqPtDXGFFgW7U9XXPv81IPDdSNo/lqAwDnFqg7gs/hNOYZgstvYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132567; c=relaxed/simple;
	bh=HFV0R5b3uDVmqv74AJdL7hBc1Nmt1AKrQ971bMO5i+U=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=tERlfe+p+Kutrss4yBZo0CqwosqEC+kh70kF31kgjoIy2A/vIfOxuvV/Qufi+WqID8Hm/rIVaCTW0eluadnS7Ydu/98YXD/QFNUL4LthZkbq6vRpHEfNQGeYd2sj9RpAjoLzIzASwvIHB0bDr3aRaGPCP7urFd6KKBOjMb6ADFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhrXTs7U; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726132561; x=1757668561;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HFV0R5b3uDVmqv74AJdL7hBc1Nmt1AKrQ971bMO5i+U=;
  b=NhrXTs7UtCqqOaPps9Kc/zRZ0bLCFAGhBuQLB22GeGYhRdyUnX+/2dfq
   wTBmRF1T0aj4QKn4IYyf6mK98zB5lG0mX6iBPk1xBsr7JWebVNANi3RQ/
   QiBvRDhB9VXzUDpMtniIQ0kBCcIcg18yPVSHQkl4iWPYNQqHdXkO5JWuV
   NL+DFWUU00+O3Q8NM40B6HUDA/ykOiXgNt+1iSWW4clHeBFDAUdy/lOGV
   fKVcLwK/Gi/AY/KflqQt6D4fBPb+gGXS0cXWAjqI8kspkNubixlma919C
   wRMvR0AyKAwXZjCSDtxX0dBuZcoh5CovgEX8OTrXVCG7LDYUWCFrCkdf+
   Q==;
X-CSE-ConnectionGUID: eHpTxqFAQRy0wSlDfr59CA==
X-CSE-MsgGUID: kNwuZn3IT3a0SXIvqZQcQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27889172"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="27889172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:16:01 -0700
X-CSE-ConnectionGUID: uQ+oGi+rTom0YMZ3SoevjQ==
X-CSE-MsgGUID: 5CILX96cSfqqdm2W++Y/9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67569972"
Received: from johunt-mobl9.ger.corp.intel.com (HELO localhost) ([10.245.245.21])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:15:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 12 Sep 2024 12:14:14 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-7
Message-ID: <pdx86-pr-20240912121414-1198713421@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.11.

Fixes:
- asus-wmi: Disable OOBE that interferes with backlight control
- panasonic-laptop: Two fixes to SINF array handling

Regards, i.


The following changes since commit d34af755a533271f39cc7d86e49c0e74fde63a37:

  platform/x86/amd: pmf: Make ASUS GA403 quirk generic (2024-09-03 17:31:08 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-7

for you to fetch changes up to d6de45e3c6f3713d3825d3e2860c11d24e0f941f:

  platform/x86: asus-wmi: Disable OOBE experience on Zenbook S 16 (2024-09-10 15:43:58 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-7

Fixes:
- asus-wmi: Disable OOBE that interferes with backlight control
- panasonic-laptop: Two fixes to SINF array handling

The following is an automated shortlog grouped by driver:

asus-wmi:
 -  Disable OOBE experience on Zenbook S 16

panasonic-laptop:
 -  Allocate 1 entry extra in the sinf array
 -  Fix SINF array out of bounds accesses

----------------------------------------------------------------
Bas Nieuwenhuizen (1):
      platform/x86: asus-wmi: Disable OOBE experience on Zenbook S 16

Hans de Goede (2):
      platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array

 drivers/platform/x86/asus-wmi.c            | 10 ++++++
 drivers/platform/x86/panasonic-laptop.c    | 58 ++++++++++++++++++++++++------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 58 insertions(+), 11 deletions(-)

