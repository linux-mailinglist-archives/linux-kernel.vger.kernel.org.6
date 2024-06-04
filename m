Return-Path: <linux-kernel+bounces-201081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A18FB954
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E260B268D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CB1487E7;
	Tue,  4 Jun 2024 16:33:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587A1EEE0;
	Tue,  4 Jun 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518818; cv=none; b=ffUn4mbT2uo+oO2ogz4PoBYqZpGY0WGg8fkb4Qc7Mbdc7fe0DBY6UY12uyj8pDTCQW975dHIXOkNGTWjs913XeHNM2lvoqL24wZ6foDo6uWsoUeEFN5TD4xMn82DJ/hDEhVjqCCWJ6bZhKxBO8EdAlYb71Udyf3vIXgrq8L7ID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518818; c=relaxed/simple;
	bh=kAzhAjn6QK5JsICYxRyX4n5pzxt+vb1SJWA2/ETD7r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAwRGZMgxKBL2lKJ5+J4Wx74uKz5ZezyGws0dzUwsiYowwOHSxnmYfDkW4RY+2D+2nrLkZVaJj2s5MEkAO8doUJ/t8ledfS2khbCbz+sMpP3+090VV6X7je+A9H6WcOvM2qu7WeYiCzctn7LHYhsD087lw1pBKTKFOiPbezkXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: i3mNSQoqSiurHRMFTgXRJA==
X-CSE-MsgGUID: F0MNUQgER1qPJFef7s43AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13887589"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13887589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:33:37 -0700
X-CSE-ConnectionGUID: qvogQ/vhSEq74oPdDOHlFA==
X-CSE-MsgGUID: eAvhOdHAQ+W9V6JKKT7IeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37876183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:33:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sEX6K-0000000DbcS-0kEx;
	Tue, 04 Jun 2024 19:33:32 +0300
Date: Tue, 4 Jun 2024 19:33:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] auxdisplay: ht16k33: Drop device node reference after
 registration failure in ht16k33_led_probe()
Message-ID: <Zl9B2zqbJqVAf83d@smile.fi.intel.com>
References: <0fc79fe9-da49-4cbe-a7ff-6443ad93f120@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc79fe9-da49-4cbe-a7ff-6443ad93f120@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 04, 2024 at 05:15:37PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 4 Jun 2024 17:02:15 +0200
> 
> A failed call of the function “devm_led_classdev_register_ext”
> can be reported.
> Add a call of the function “fwnode_handle_put” for this error case.

Replace double quotes by parentheses, so the reference to the functions
will look like func().

...

>  	err = devm_led_classdev_register_ext(dev, led, &init_data);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "Failed to register LED\n");
> +		fwnode_handle_put(init_data.fwnode);
> +	}

There are two issues with this approach:
1) there is the same issue in ->remove(), isn't it?
2) it potentially might mess up the ordering if any other devm call happens
   in beetween.

But, by design we don't use reference counting after we registered LED, hence
both error and successful paths need to have this, so add another
fwnode_handle_put() after this branch.

-- 
With Best Regards,
Andy Shevchenko



