Return-Path: <linux-kernel+bounces-285137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8696F9509B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB6A28714D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A21A2C21;
	Tue, 13 Aug 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuZAGNnx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD761A4F19;
	Tue, 13 Aug 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564910; cv=none; b=eqF9WtYnTDBOArGeQqb7my3XhDYYrLwO2AcLmk3tu7U6E95AiSKIRE88gQXGdIoMnVI9zA8CUxHJiTWY2iu6N16vAynr1q7QvOkd03TSHypl64bu+rfLTnw2NvX5JPhSNEc9DkmGsuR8uNwY8jHqt1b4Zhw2EaMiYW7iuoqKb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564910; c=relaxed/simple;
	bh=e0lFy6FRF2WXlTEkhLmqv9oTDPHM2XOKmZ5WnOizTBw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XIsTtTsEqcwSNZ1NQIPT5wfXdNzhboSAYU3miO9JwoRkx5XMKe5IMq/PY76uOIqIsdYhpQQOmY3BxObSTUNarjfbk0+342amnIjkQeMuIKVGnjWA5Wntfi3ZSxcpXsxs9S1hE07VWdbMc7u1R28ahyhlJclHXh/QCnP3IiYqzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuZAGNnx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564909; x=1755100909;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e0lFy6FRF2WXlTEkhLmqv9oTDPHM2XOKmZ5WnOizTBw=;
  b=WuZAGNnxQfUiFuutQxmQRyTUdgJJ3u+vi/r2I5ekdhJF0NNJQC/TQDCC
   wDbc7csMcIBxBNofY1tlhaPkUnyxjeaSzxcyXV0StfX9SmXLrR6KIlTxV
   p9JSZ2eRBH0t5/LpNfl3fOER+/M1hbyr5z/ypS9XFTKpWZ4hJxKanfNvq
   aLER3wqUu0feikLyOq9Z5DELXweeqIBdiK9SgeMbpEvjPrCr5upa4J8Xs
   Luzp9hOUwDd2yPT5wxJcAK4x0qbrimVWpHQlrfwgxH/J3IIS3CuUqsNcv
   38aIDb7Da7ucCOPEDfO0PtBxszdaQ1B64heyjeBIyCcmmcCn1CphboZuQ
   Q==;
X-CSE-ConnectionGUID: mmAcKH8MSimSwvq6OzI6qw==
X-CSE-MsgGUID: wrWp4pyHSp+Fe+OvDnz80Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21606849"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21606849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:48 -0700
X-CSE-ConnectionGUID: /ugbMIfoRCKlSjzTKc4s2A==
X-CSE-MsgGUID: cQB2c0RMR0OXN7TEuOJXYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="81944400"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Aug 2024 19:01:21 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Create Intel PMC SSRAM Telemetry driver
In-Reply-To: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Message-ID: <ad5e7c93-33fa-4a5e-35af-7f99150dd4be@linux.intel.com>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Xi Pardee wrote:

> This patch series removes the SSRAM support from Intel PMC Core driver
> and creates a separate PCI driver for SSRAM device. The new Intel PMC
> SSRAM driver provides the following functionalities:
>  
> 1. Search and store the PMC information in a structure, including PWRMBASE
> address and devid for each available PMC. Then Intel PMC Core driver
> achieves the PMC information using the API provided by the new driver.
>  
> 2. Search and register Intel Platform Monitoring Techology telemetry
> regions so they would by available for read through sysfs and Intel PMT
> API. Intel PMC Core driver can achieve Low Power Mode requirement
> information from a telemetry region registered by the new driver.
> The above functionalities was previously handled by Intel PMC Core
> driver. Intel PMC Core driver returns -EPROBE_DEFER when trying to read
> data from a telem region that is not available yet. This setup may
> result in an infinite loop of .probe() calls as Intel PMC Core driver
> creates child devices. Creating a separate PCI driver avoids the infinite
> loop possibility.
>  
> Xi Pardee (7):
>   platform/x86:intel/pmc: Remove SSRAM support from PMC Core
>   platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
>   platform/x86:intel/pmc: Add support to get PMC information from SSRAM
>   platform/x86:intel/pmt: Get PMC from SSRAM for available platforms
>   platform/x86:intel/pmt: Create inline version for telemetry functions
>   platform/x86:intel/pmc: Add support to Retrieve LPM information
>   platform/x86:intel/pmc: Get LPM information for available platforms

Hi,

I don't see why the removal first, then re-add approach would be justified 
here. You're basically adding the same code back later in many cases with 
only very minimal changes, and some changes are entirely pointless such as 
pmc_idx -> pmc_index parameter rename. This is just a big pain to review.

I'd suggest you move functions in first patch into core.c. Try to 
avoid logic/code changes other than making making the necessary functions 
non-static and adding the prototypes for them into a header (temporarily).

Then rename the ssram file to its new name in the second change.

Then do the rework on top of that (and make things back static again).

Try to split the rework into sensible chunks, anything that can be taken 
away from the main rework change is less lines to review in that patch.
If you e.g. want to do pcidev -> pdev renames, put them into own separate 
change (and do it consistently then, not just for some of the cases like
currently :-/).

The move patches are nearly trivial to review and take large chunk of 
diff away from the actual rework itself which doesn't seem that 
complicated to review once the 1:1 move bits and trivial rename churn is
eliminated from the diff.

>  drivers/platform/x86/intel/pmc/Kconfig        |  13 +-
>  drivers/platform/x86/intel/pmc/Makefile       |   8 +-
>  drivers/platform/x86/intel/pmc/arl.c          |  36 +-
>  drivers/platform/x86/intel/pmc/core.c         | 216 +++++++++++-
>  drivers/platform/x86/intel/pmc/core.h         |  25 +-
>  drivers/platform/x86/intel/pmc/core_ssram.c   | 326 ------------------
>  drivers/platform/x86/intel/pmc/lnl.c          |  36 +-
>  drivers/platform/x86/intel/pmc/mtl.c          |  34 +-
>  .../platform/x86/intel/pmc/ssram_telemetry.c  | 184 ++++++++++
>  .../platform/x86/intel/pmc/ssram_telemetry.h  |  45 +++
>  drivers/platform/x86/intel/pmt/telemetry.h    |  19 +-
>  11 files changed, 550 insertions(+), 392 deletions(-)
>  delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
>  create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
>  create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h
> 
> 

-- 
 i.


