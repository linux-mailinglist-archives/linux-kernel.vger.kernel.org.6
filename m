Return-Path: <linux-kernel+bounces-306731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB79642A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6EB27AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1418991C;
	Thu, 29 Aug 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy4cP0CF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1152190661
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929598; cv=none; b=KHvk3AaDi0PwgbY1/9JcHHhDn+tkdo/8ICOY70XcxspW8U4VnExnggvaMaZ5JBwOB5WnPCDzZlJc32JY6aRqcu+gWyiSxR3pl6uKBcNW5G6RerkXxvNgCroppb0wDjC0nHi74q7U9Oke6LZUwKyJcPliL71kqRott+WqlCogdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929598; c=relaxed/simple;
	bh=uRpFzjlZ7Ai/nO4F2kVPVYXtCZasLM6bdoo5lTOaLEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM7E7oObNS0AzEKJWxTcyzO+NjzVMPnK7heUtj3UAqx5h3dkO63/9fSraXy/E6ELBVRnLkWQQvrvdHlK+WoU+5ocL+7BMwuYksWRtQaz9XRwAdflUZaTU0dhM2X+2i3n0oCGYR7rQ/z0L6f5G74n+8sYy6QgrVDywEsFd1loKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy4cP0CF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724929598; x=1756465598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uRpFzjlZ7Ai/nO4F2kVPVYXtCZasLM6bdoo5lTOaLEg=;
  b=Dy4cP0CF+ba01FnGOllsowOMk+6y/7sPPchshfcbWtkxYy799wC4qWZF
   AkxJ7R35va+vvwoxauR3LcjbCYBJ2ra0ufdjSilAIykfeicbnf62EKqT7
   D9Su0+yoF8VGAzwvJr9EFkWeMUM5oop8neSA+TMBn1X41q6dlep2rC3n5
   abhP9LC7uxZfMYGUwUba670Rr2rzhoOlKHM7ZewNpQ7OGWdLiKhJ6W8UP
   5kKWfe6lr2gbWz0kno7DGU1xIocZlTTtVWLDH+K5Ue+klXtBASoXiZPms
   v1TkfpV9960Kb3d24HWSlm0Oc3NzBiD1i96ozxkvBegA7TxJEflUFlV0x
   Q==;
X-CSE-ConnectionGUID: O13cDeoBTXuN6q72IbI35Q==
X-CSE-MsgGUID: bKRrwZFgQXGkc80xXkiqMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34170438"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34170438"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:06:37 -0700
X-CSE-ConnectionGUID: g8c8LC+rQquyXsOH+xikeQ==
X-CSE-MsgGUID: ioR/cnlZTrWunCXIi85ahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94278260"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:06:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjcz2-00000002yM2-33B3;
	Thu, 29 Aug 2024 14:06:32 +0300
Date: Thu, 29 Aug 2024 14:06:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: intel-lpss: New LPSS PCI IDs
Message-ID: <ZtBWOC-DKARsQ-XP@smile.fi.intel.com>
References: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 12:57:17PM +0300, Ilpo Järvinen wrote:
> Hi,
> 
> Here are a few LPSS PCI IDs for new platforms. The Arrow Lake-H one was
> sent already in the previous cycle but it might have fallen through the
> crack so resending it here.

I believe that the choices for SPI and I2C (i.e. SSP types and I2C functional
clock rates) were carefully chosen in accordance with the specifications.
With this in mind,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



