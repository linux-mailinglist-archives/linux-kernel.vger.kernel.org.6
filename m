Return-Path: <linux-kernel+bounces-327904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F56977C79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFCB27586
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDB1D6C6B;
	Fri, 13 Sep 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izmkiwK6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD1D6C7B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220647; cv=none; b=ol2VoBgbLXKXns7rE9uuZbHdHuK98JLadUGFkTPfAKhwF/nYdgrb8ZPvaR4YL+GYlMJ53CEGchYWdZaFC8zm/rm5vPejUtGy+fKFH5qtGVENYskiLhSeQbOdRJcJSWm+E5okq9OAs5gC1iqCBXXxgjV0UBrK7xJp6x9pq+EbRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220647; c=relaxed/simple;
	bh=JbXQlyd6uU5TA9I/jmdK6bPkhiY9x/cNbgf+TNxVteU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDt2uynxyX7a8li3WKvwfgyUjue3bTFwTXeYdeJbCd2/LqubsVeetN2FPKMQCSlqOyrWB3PzyqaIY6AOcOnz5kH8NiUcBJ1YLInQmuzM1ksDxchRImJjB30cEaMYcqtHN4JE1Kfz5ldo8mgKCL90b1Xqw3mqcDaPKj6LxnRilpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izmkiwK6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220646; x=1757756646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JbXQlyd6uU5TA9I/jmdK6bPkhiY9x/cNbgf+TNxVteU=;
  b=izmkiwK6+5yECD8k5xo101tmBDL9mW3CPYniZ0OKhLwwbzpqblmeosVO
   +jhetnmyaDuMpxy0sPTiCwqZ07Du3BDjOtFOQgV6b7DxXJp9XvjYN6WqY
   TT9CeSKfug4loiXtl/5A9wKMZVDrdPNl2EcTdxasV6hbvmKhQo8xQSAga
   /7/6CTYcSTaMUnT6FxvqYDTfj/4Ivyt9zMCEo33dY+y8GRQ4vkk/OQXcI
   KQIaSfoWB27j2+aPiD+2dFghL366bI0dUDjTunBo3HAfQjJoV1LmkUAs3
   ApdZ1liNT4DGnqkof5uYm5O+h5zHbhr/SL2MmcEMWtmbq+x8+VH+5aydJ
   A==;
X-CSE-ConnectionGUID: MpMXOXesQ5qlaK14XU8LsA==
X-CSE-MsgGUID: oJLRcD+tQDOE/Sl7+i3Pkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="47629601"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="47629601"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:44:05 -0700
X-CSE-ConnectionGUID: zxTEZhopRWmGm3N6IB7ORg==
X-CSE-MsgGUID: lfeURNkLSQq6IAAH+Lrn3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67619388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:44:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2qQ-00000008FOz-1PXF;
	Fri, 13 Sep 2024 12:44:02 +0300
Date: Fri, 13 Sep 2024 12:44:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Use functionality of irq_get_trigger_type()
Message-ID: <ZuQJYr_-adwBs0jh@smile.fi.intel.com>
References: <20240912235925.54465-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912235925.54465-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 01:59:23AM +0200, Vasileios Amoiridis wrote:
> Use the irq_get_trigger_type() function which internally calls the
> irq_get_trigger_data(), to remove check and remove the irqd_get_trigger_type().
> 
> The series is compile tested.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



