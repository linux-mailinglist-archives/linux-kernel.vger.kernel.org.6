Return-Path: <linux-kernel+bounces-564671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C94A6590F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D5E1698A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BAE1DD0D5;
	Mon, 17 Mar 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afYQVAIq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F511DD0C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230050; cv=none; b=swOu+GiRJqHfcVRt+/PBjTY0e+Q9CywnO2/+nV1cHIJIZ69QpXMuhhHgkqLroAeUEPsYYpzoSnSjTnKF2Dhb2lxh/KnP8vm0isydZT8bFV0hU9Xzn81Crf/qAy1XxYCGgyaszu8lSYdDVihBmX9SXSrwY5qr7UDlHzI2Fo10Sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230050; c=relaxed/simple;
	bh=bCHSORnW89me9g4PcakXu6c12xa6roHEa5IzL6WKpig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NORAuWI4EA0glaGY5NToaSG0S9GLJealxM5O/QnU7QQXSyWNRhaIevju/itB5uE5XFuLzV0IRJChn1PO2mMmD6fcWoaoEwHu3TSpbPBr2KNuhGOuWytK/EzFPpG4ETntUaCIMlu+F6p7KRxmI/odGNYcV7jOaCTB6ydsBLkXgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afYQVAIq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742230049; x=1773766049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bCHSORnW89me9g4PcakXu6c12xa6roHEa5IzL6WKpig=;
  b=afYQVAIq5dr2x5qGQa4eLO0obH1AtBctToMHbVUuSYGTLYxlEXrAM2HD
   +lJkHDKY3Y8BhARl7SLry8qljHm3JcB/k9Ij4RNOHnQ7tQeXJsJ1W99c3
   G+xx6NrAlKOJM+jugdME77l4SCaGzWIrf1RQxDOdBj8fNdNP4PMAzfE9F
   DbrdJY5hCxlE0D4iOsM6EK9KRlYgdmslFffrvDJa3ewFUPwHE6ssuvtAV
   p0VPBWAS9hoFefZ9zXQ5YZtOEG3pz4C8MXrRMeZYuwHcMM2Gv0ogzwS3G
   JcNHV+472Mlfa4ep+MQmmGwkecRjtlgoluWkp3bVzJCVHFXLCrTw0keAV
   g==;
X-CSE-ConnectionGUID: pybqK6gcQFOAUH650mDM3w==
X-CSE-MsgGUID: 5pdcES/IQr2onSZwzHxIbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42582673"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="42582673"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:47:28 -0700
X-CSE-ConnectionGUID: P4OUCInFQaC1FzVEY+4Qhw==
X-CSE-MsgGUID: JJR+wYaoRG+mjtucAabHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127165363"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:47:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuDcZ-00000003MWR-0JUm;
	Mon, 17 Mar 2025 18:47:23 +0200
Date: Mon, 17 Mar 2025 18:47:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <Z9hSGgu1ZHEWLy7x@smile.fi.intel.com>
References: <20250317155452.2038020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317155452.2038020-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 09:24:52PM +0530, Raag Jadav wrote:
> Currently driver_data user is expecting a pointer to pps_tio while

struct pps_tio

> platform_set_drvdata() is setting a double pointer to it.

"...which will point to the local stack of the probe function."

> Make them
> consistent and fix illegal memory access in driver ->remove() path.
> 
> [  156.254066] BUG: unable to handle page fault for address: ffffc9000117b738

> [  156.254099] #PF: supervisor read access in kernel mode
> [  156.254111] #PF: error_code(0x0000) - not-present page

These lines are not needed...

> [  156.254197] RIP: 0010:hrtimer_active+0x2b/0x60
> [  156.254367] Call Trace:

> [  156.254375]  <TASK>
> [  156.254382]  ? show_regs+0x6d/0x80
> [  156.254393]  ? __die+0x29/0x70
> [  156.254402]  ? page_fault_oops+0x15f/0x4e0
> [  156.254415]  ? hrtimer_active+0x2b/0x60
> [  156.254425]  ? search_exception_tables+0x65/0x70
> [  156.254437]  ? kernelmode_fixup_or_oops.constprop.0+0x61/0x80
> [  156.254451]  ? __bad_area_nosemaphore+0x195/0x2c0
> [  156.254462]  ? __lock_acquire+0xaaf/0x2840
> [  156.254475]  ? bad_area_nosemaphore+0x16/0x20
> [  156.254486]  ? do_kern_addr_fault.part.0+0x64/0x80
> [  156.254498]  ? exc_page_fault+0x190/0x2c0
> [  156.254511]  ? asm_exc_page_fault+0x2b/0x30
> [  156.254527]  ? __pfx_pps_gen_tio_remove+0x10/0x10 [pps_gen_tio]

...neither these.

> [  156.254541]  ? hrtimer_active+0x2b/0x60
> [  156.254551]  hrtimer_cancel+0x19/0x50
> [  156.254561]  pps_gen_tio_remove+0x1e/0x80 [pps_gen_tio]

As I said, ~3-5, okay maybe 7 lines is enough.

> Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
With Best Regards,
Andy Shevchenko



