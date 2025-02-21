Return-Path: <linux-kernel+bounces-526163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46233A3FB06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C14B17217B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F70204F8E;
	Fri, 21 Feb 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn7xhSWZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9DD213E9E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154346; cv=none; b=tHqrZmdiYHo4niH/pGnIbL0hPUQNUcDSNfMfkpUqq9q8P+0cVq4yN13jPcP5bToPXDBFIFj9pUIfdQ20Uk9DakcPcCFRbKkRz7/yBjEDxsAn+hg+WIUrwzEL3ua/FDYnPxwks5gi/mlqDtKiim+jC/+UvcjCRvqoSj04LfW6sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154346; c=relaxed/simple;
	bh=mxjeAdq+aNd+avhSnTHUTRgXcTwL1FgHUD13IQX+Cjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqcmIKEY69ICjy1I2aWxoVOZJbbCABGHtqxtWIZVbI3KAI95ZAiNm1ZUCdX3a8t1HVD5b6w+cBRIce/hZ/G46EfGks/sMluHDAQHgeArg8tfl7eAEKorf0pbN46FwwATT2Qf/6biEEnvxtcUNEPvpx1zYTGkXr4WELMN4XNbS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn7xhSWZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740154345; x=1771690345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mxjeAdq+aNd+avhSnTHUTRgXcTwL1FgHUD13IQX+Cjk=;
  b=Nn7xhSWZztZeDzYBGokblTW8CAlC58DX+cPW5vapDNSPDvnt8hZtZ4+U
   uLR8VkmMcHIQxxtZ83MosVZvHnZ06LlG80cV7NLjMETfQmRFQZOXTH+In
   0mYxQ8pQV24EQtv/JHITMCbP5ghzXuw25UyLbibt+2gGqIEIemd6QGIVo
   u/XZhKsNZJUx6eB8dwsAOIRw+Na+LpkbZf79BccqeOQFLx+dMrKnO7DCW
   MrKQbvB1wLM/hUCuNks2A642Mztow0ATJiPmaU+zl60WFIkUa5L1wQgV5
   aUiHuoY3+zLNwkEKdqqUtAVcySzzhXpGk3J7MWXxojdEYdQc4bBJuMbb7
   Q==;
X-CSE-ConnectionGUID: bPBUGCJES+GI9K9xvRirew==
X-CSE-MsgGUID: svWTpMDvQdy9OySjgmuSXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51192656"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="51192656"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:12:25 -0800
X-CSE-ConnectionGUID: dOzPSP9JQTqAExshd1Xbng==
X-CSE-MsgGUID: LWwAZrIOR6Se5JtclW+b5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152601240"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:12:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tlVdT-0000000DgfD-21CW;
	Fri, 21 Feb 2025 18:12:19 +0200
Date: Fri, 21 Feb 2025 18:12:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Message-ID: <Z7il497RBiiga4Js@smile.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221050804.2764553-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 21, 2025 at 10:38:02AM +0530, Raag Jadav wrote:
> In a wider effort to improve build speeds, we're attempting to split/cleanup
> core headers.
> 
> This series attempts to cleanup io.h with "include what you need" approach.
> 
> This depends on earlier modifications available in immutable tag[1]. Feel
> free to carry your subsystem patches with it, or let Andy know if you'd
> rather let him carry them.
> 
> [1] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com/

Oh, you are fast! Please, read my comments in v1 as well an take them into
account.

-- 
With Best Regards,
Andy Shevchenko



