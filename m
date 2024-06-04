Return-Path: <linux-kernel+bounces-201383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DA8FBDD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D6D1C22F87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9898214BFA5;
	Tue,  4 Jun 2024 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9Nl5ed7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC7140375;
	Tue,  4 Jun 2024 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535501; cv=none; b=Y6S1rTzmyzui4aG2YLrR6PiyIVnjghaku1Eiaq7w9r76lUmVjNnPCah6QfmwmVDfQK9r6HkZIbts77622RKwBgZ3AcTkspc0vwCN6v99wZo13SSZVTqvOCvQHSea1kxCMStR8Z5MadtA8eV2cp7UkoeOV9H9RpKH1/ZRUqvnp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535501; c=relaxed/simple;
	bh=EepEPX28KW8cIvWzQ83MU1wIxpKq/a8X93eGHjSQGBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5nGHz0k8jRiZxFXBW22PifRMMyUqJlvbNEYpKCzC3IXUtGuqL2nmhc+nCP89Sr6z7lrGTNtEEkUFWqM/B+5i37/8E4cqcJnxuyzfzUyOLlyudcNtvqQgjzOgejfB6mEELiuyfGr7ae5LVl9Tc+Ig2fno1XkXyb6iP55eJaLn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9Nl5ed7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717535500; x=1749071500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EepEPX28KW8cIvWzQ83MU1wIxpKq/a8X93eGHjSQGBw=;
  b=O9Nl5ed7FkGhsZU/nst992GgsQuuK0SW9KF88ySOtoL3B2Exsf99tQ4h
   0gukoZmp5DG4EjgUZyxEPJ4prl/XOnu7SygEELf7jXZOBzXCoo5v44LD2
   CyMVYbnbNz1+YC9GEZZX/2y4Z63UnuCv8cgxn9cEt+FyICPd2lF7QIpWt
   mNS9mWJYX0ikhnxwEtNd91jnHWQc5DL/pvFm+Gtmo/4gGUuKPRmWj9gBd
   8HMkM6RUDX8TqGCvmRWlQIbjup9RhYUO3z165CSmS2f4/7opek6v6SplR
   56T+uNX3DDAo2EIAJJqcSKGs2inWF5kgPrIoKNEWZjWtDPfieRCIM2r9K
   Q==;
X-CSE-ConnectionGUID: AgyWAgr/QQ+VRT47IIg8zw==
X-CSE-MsgGUID: xURqZQ33RmSWxoe7XJcu4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13955526"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13955526"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:11:39 -0700
X-CSE-ConnectionGUID: HgdQjrOIRQm89ArG8EhTAw==
X-CSE-MsgGUID: EfiKCilPSCK1vmPzNFiB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="68508830"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:11:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sEbRO-0000000DfIN-2tX1;
	Wed, 05 Jun 2024 00:11:34 +0300
Date: Wed, 5 Jun 2024 00:11:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Stanley Chang <stanley_chang@realtek.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: realtek: Use scope-based resource management in
 extcon_rtk_type_c_init()
Message-ID: <Zl-DBkt8sNb9xypq@smile.fi.intel.com>
References: <532aa50e-b8e5-4e8e-a2bd-a05fd81274dc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <532aa50e-b8e5-4e8e-a2bd-a05fd81274dc@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 10:06:14PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 4 Jun 2024 21:55:08 +0200
> 
> Scope-based resource management became supported also for another
> programming interface by contributions of Jonathan Cameron on 2024-02-17.
> See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
> property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").
> 
> * Thus use the attribute “__free(fwnode_handle)”.
> 
> * Reduce the scope for the local variable “fwnode”.

> Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")

The problem here is that the above mentioned API only recently appeared in the
kernel. It will be impossible to backport without backporting a new API, which
is usually contradicts the idea of stable kernels. That's why it's better to
really fix without using a new APIs and then convert to a new one. Hence needs
two patches.

-- 
With Best Regards,
Andy Shevchenko



