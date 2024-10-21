Return-Path: <linux-kernel+bounces-373931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A049A5F26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66FE1F21850
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837DF1E32AD;
	Mon, 21 Oct 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PS8dEyx5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB041E2852;
	Mon, 21 Oct 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500626; cv=none; b=VLv75myTntWioh4n3UUOx5DdeZYYBRQPKfk7wIoAP9ITB+g/Oj7OtSAjRVXF5LtZkxDILkWbHjPZB2b2Vec5tRagnf8L1+EqNrTTpEUJbAFvbfWzXRF9zwvbgEgr69aonwUc58kZF015lgKBOTzaxsbCCctH82YjtvHPuCOXfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500626; c=relaxed/simple;
	bh=ljYznu+p6F7JvIl+/lFMuTG9Vfco1IGNVduSQjOikQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryz/DOG+mTkkI25IxKP5zqUAG7XBnap63nWL3p4fi3xg8ptj8tR3OHxRwSz9iOJ/KdUsR1D9pHs5ff+Fv30ERFesRFJ9uCjucR7L8mA9QHSLKo2QbbMibjNpg79dKrmCa2D0zvIOGrt5ya/cVi+Gfa5s1qEjEAmr2R6nHQKUoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PS8dEyx5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500626; x=1761036626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljYznu+p6F7JvIl+/lFMuTG9Vfco1IGNVduSQjOikQw=;
  b=PS8dEyx5uqekXB8S1e0M/A3htCju824lj2+/YWvx7HGIczYEnyADKOzg
   ROCMggpWZaGP6Mc/qY7hTBnD6ByjzAwmuduC87NfudjjkTSqslfVSYVMN
   kUDnbzQiZxZRAjz8txB30CVIrlLRp08HYn0RaaYfv/Ea2TfV0P14Qizgg
   qheXVrwheyxOqgNF0qPPGrESiXHH0151YtYdFTgB0YPNUeLb51aaATeaA
   m15vkvMkCsM1h96Suh7xJsnhvhOjRjjUlSUXVLfMxv/My7tC3noZCn1Bd
   I2QL74ZiAe73SzOkq1VkY1R7wazot85VopOa1IAMKc5ws2XKFc2XvvSh6
   A==;
X-CSE-ConnectionGUID: PC9MNQGgQKG1tkDnRhDMHg==
X-CSE-MsgGUID: 1sCfaTcJTF2WgbsID7I3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32779649"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32779649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:50:25 -0700
X-CSE-ConnectionGUID: lfGGcHr6SYWM8q40aX3pkA==
X-CSE-MsgGUID: vNSM7wWRTI+gO2kUrklwJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84253339"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 21 Oct 2024 01:50:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 985A412B; Mon, 21 Oct 2024 11:50:21 +0300 (EEST)
Date: Mon, 21 Oct 2024 11:50:21 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
Message-ID: <20241021085021.GB275077@black.fi.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com>

On Mon, Oct 21, 2024 at 11:38:52AM +0300, Andy Shevchenko wrote:
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver. The byproduct of this change is that the
> negative conditionals are swapped by positive ones that are being
> attached to the respective calls, hence the code uses the regular
> pattern, i.e. checking for the error first.
> 
> Tested-by: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

