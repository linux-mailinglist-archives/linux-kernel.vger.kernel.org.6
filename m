Return-Path: <linux-kernel+bounces-204079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76578FE3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4E21C21ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32509187355;
	Thu,  6 Jun 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7Cejofe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C936187341
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668285; cv=none; b=bhOkIXlKNeALTwtMG8JkfxGTOnUVQpB3RgEtb1fmKsnNGyMjUcb1Zd5TLkgVyDmAdTB2m9r/FEf0c0S/34B8H1eItj77psoXEX4jA/SnnK6YkE9nbs6zqQGW8mzcelHN6BM3NKUmW28Aw6FMvMYZWoYw11ND7QEeCMv7wzztxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668285; c=relaxed/simple;
	bh=8pkhPGy9i6WKfDk/94hgWfLwShB2mZGSNDZDe6PD1Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5teF3f9+3fGeqoHypgBQTliHfojevVRHF/zJW6EINoDzOwCuZJ6CrhCASdnjSPiO+fx38Dwkh7wvmQTUC3R0PD2ui0W8x0+m5btSgsvZGR6gJ2AakXMa4AhYdNHHow5SbqyyxuThEtkm/nfkk8TsQOMMcC6NU7OCxoVk/ErBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7Cejofe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717668284; x=1749204284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pkhPGy9i6WKfDk/94hgWfLwShB2mZGSNDZDe6PD1Ro=;
  b=l7CejofeX//GbxJTn+qZbbbfo9cVHHFRJ7CvNRpP2l3NH14ynVF3eA2h
   UMIoKXtNzIxIJmLqKBxwp7uHz7QCY1VKnkIQx9cMtcKviehRLScl5Yh/I
   ObrjGTQPnp/6NHt4JKRsE+NSdkhDSJN+WAs6HeasH0Tnf4G145zsO8PhC
   77VDQ8VluNJBm9tua60yqzENrYRzoFUn7YW6mMHfk+czekVbZlOixsG+Y
   3QRSHi53CLvYM/tTHyn1lR7J+bKpjFDOtnbOMxcFDG5IMg6hPWcXubjuf
   o1vl+NdwvZGUfjcvaNT7QKon+cgyK6wGyi1cKEQ4SL0ovt09aqy0qFsNa
   w==;
X-CSE-ConnectionGUID: vKI2sX4zRNSfZ7rNSknJQg==
X-CSE-MsgGUID: t7zAuWDSRAi63yFD1s0Nfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="31869390"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="31869390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:04:43 -0700
X-CSE-ConnectionGUID: ZPrF9FMhTHC4ouf6Z+Kc6g==
X-CSE-MsgGUID: 2rHLqjCcR6im6b1SC1yNYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37777058"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:04:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sF9z5-0000000E86J-21Bi;
	Thu, 06 Jun 2024 13:04:39 +0300
Date: Thu, 6 Jun 2024 13:04:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] resource: add a simple test for walk_iomem_res_desc()
Message-ID: <ZmGJt1I4Glvq_Myz@smile.fi.intel.com>
References: <20240606004002.3280960-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606004002.3280960-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 05:39:48PM -0700, Chia-I Wu wrote:
> This mainly tests that find_next_iomem_res() does not miss resources.

Read Submitting Patches documentation on imperative mood and modify the commit
message to follow.

...

> +	/* build the resource tree under the test root:
> +	 *
> +	 *   0x0000-0x0fff: res[0], a match
> +	 *   0x1000-0x1fff: res[1], a non-match
> +	 *   0x2000-0x2fff: a hole
> +	 *   0x3000-0x3fff: res[2], a non-match
> +	 *     0x3800-0x3bff: res[3], a match
> +	 *   0x4000-0x4fff: res[4], a match
> +	 */

/*
 * This is good, but multi-line comment
 * style is broken along with English grammar, i.e.
 * do not forget that sentences are started with
 * a capital letter.
 */

...

Please, do not send a new version this week. Take your time.

-- 
With Best Regards,
Andy Shevchenko



