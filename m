Return-Path: <linux-kernel+bounces-526142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E47A3FA85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9405F19C024E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BDA20FA91;
	Fri, 21 Feb 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="deQZW3dh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8881DF73A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153979; cv=none; b=KBxuCITIVePEsp3qnWYu7H2nmBd3DvDsiJ5CuJ9srsxOPT22SMTF4e+0PfE6keMD715Ioi7VdLvY0zTq62YjwBAV9d8JFC5JXskw2Gunf9kS4cKnuTUbF3764PF4q57XWGPkVzeq4JRtKERGW7WHgXMgPs7etkUbG4jmA19OYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153979; c=relaxed/simple;
	bh=PfVmD+Ik+4/tjXZKCLh6FwCvjwO81PdnkPtrVB+uvVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx3c2sXIfCjyeEKPH1TUppKkr39PBneiNs2NmW9HD6EDKG2t3VLxiPoOy6da0WBEEMc81f0NLoSFAmGpLtcJEFbgAdjiJgkid+u/bDdiK06yYeDjvzLB+Z+7P5E7b1lcLLgqKah0SlYBv6VLK7agozOP8hW33+7BDgpWBLk/YT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=deQZW3dh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740153978; x=1771689978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PfVmD+Ik+4/tjXZKCLh6FwCvjwO81PdnkPtrVB+uvVk=;
  b=deQZW3dhFypxPYNFp5mgrHOAAXJA+8XEsBixl9sMTxk2Pna1dt8zsz9v
   RboAZ37CLiDEQOp2m1ODGA/k23ulESu2/D89nRbFndH7+nlLaf4YSWiP8
   TGd50Mlfb1Jv434wfSBGuG5AkBMBRaBJMypqaCZrNkj7t7gmswLZMxvZO
   p1qoO6r7FgWuP7JDPkgaWQl1cneZ8x/kPCsVaBp4XQXLgJLwZxSg1gJuq
   93uIqyKbT3/3Q6dvwnqL5iCiSfaoDEIlMV9/B7JluQ3nHWF22H9+gazn/
   9c9C/nPrWcb8Sro6g8YjiPu+mYu+Lw8PGQ4aHJi+nqPlvFdRvtLfjUE+e
   w==;
X-CSE-ConnectionGUID: 8YOrv8voTpe3varejnTn4g==
X-CSE-MsgGUID: 2OlHnjudR4Ov+ZAilZGQ3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="28570914"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="28570914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:06:17 -0800
X-CSE-ConnectionGUID: AmaAwK0OTrO5l+UsSLkcxg==
X-CSE-MsgGUID: 2D53EnSWRpe15VyKLZ4OAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120508633"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:06:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tlVXZ-0000000DgaM-3lqX;
	Fri, 21 Feb 2025 18:06:13 +0200
Date: Fri, 21 Feb 2025 18:06:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] io.h: drop unused headers
Message-ID: <Z7ikdXunA7_uoOsZ@smile.fi.intel.com>
References: <20250220173305.2752125-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220173305.2752125-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 11:03:05PM +0530, Raag Jadav wrote:
> Drop unused headers and type declaration from io.h.

FWIW,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> PS: I'm not very confident about this but thought I'd give it a try.

Sure, I like this change.

-- 
With Best Regards,
Andy Shevchenko



