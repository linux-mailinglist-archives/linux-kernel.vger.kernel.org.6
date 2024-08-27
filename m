Return-Path: <linux-kernel+bounces-303546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EA960DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40147284260
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06F1C4EE7;
	Tue, 27 Aug 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLCI/Z0a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D781C4ED8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769356; cv=none; b=Jutmsg7sC07dbYd7vPPsgQS7MvqyK5dT2fbT+H3f3C+jRAa6Pc0Zf6OnRKbreVeHnJ86dTWb27ppAmBUERmbb7NnGO6owiTAeSh4Y/jc7L0O+qwPSslaPXAm210nXOkDesBDqRaG09JFf5m4Fm8SAsWLmrvPCRHgVhajiPe1gwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769356; c=relaxed/simple;
	bh=RQV1oOHSHZntSMzGZOx612Dym+b0AKMnQySVvELMUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oldp+/yd8RDm1sQFA45b4OjRdEw02cY1g74c8oae03N+mjws/H1r4a3r/F6KyYHkAgPi0ZDZx9TURQLW6S1tgzQDQJGRRCanukgJ9ZCTYRLCAa/Z9tgD16TL6ojl58fPifUWxzUBj1djA3nlDU2+u+i2T9/JvT2KEZHsKtlWh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLCI/Z0a; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724769355; x=1756305355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQV1oOHSHZntSMzGZOx612Dym+b0AKMnQySVvELMUmQ=;
  b=mLCI/Z0aQdAjOFaJCQVowwHgkzNiaKGbAYVcgqHq9RYJgQSgk9+SFyII
   DMgon8IBxEw8RkqUOUPuTFAJwWTFVZZQy2Hg8SeQID8i6ZLDgG3JYiERd
   sWeCrhNTN6rt3RSJVjs9GJCmQKDSaJd7TFBqtRltHd/UQPJrWrx+Ue96V
   j3iDM5BI2lImzwIv2EEiY9zfUik+C4uDWWW90pvx8+PnWpWUKPOZBMqzN
   GxnnuS+3YmQ9ir9vb5a7a1bX7DI3Yksg0A/OHR8y1imWJqHCNrIHzUOe2
   jIqOogylJWbdZ+TqykNbAWqTFl4tjj9nVdhVp9aH5pd9ZYurUsMnr0YMd
   Q==;
X-CSE-ConnectionGUID: OWKmFpElSjWVmoZy0D42tQ==
X-CSE-MsgGUID: kuIgJtzdTn+DqeNnwoW0sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22777227"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="22777227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:35:54 -0700
X-CSE-ConnectionGUID: cYNwgXZWStCnmp9w4ttyGg==
X-CSE-MsgGUID: b0azcHhARwOiQkQIorZPbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62929320"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 07:35:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sixIU-00000002IPm-1KJl;
	Tue, 27 Aug 2024 17:35:50 +0300
Date: Tue, 27 Aug 2024 17:35:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] regulator: core: Fix
 regulator_is_supported_voltage() kerneldoc return value
Message-ID: <Zs3kRrRW9rrfbSDP@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827095550.675018-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 05:55:42PM +0800, Chen-Yu Tsai wrote:
> The kerneldoc for regulator_is_supported_voltage() states that the
> return value is a boolean. That is not correct, as it could return an
> error number if the check failed.

I don't know what error number means. Is it positive? Negative?

s/error number/negative error code/g
(Here and everywhere else)


> Fix the description by expanding it to cover the true, false and error

true and false are not what is returned, right?

> conditions. The description is also converted to a proper "Return"
> section.

...

> - * Returns a boolean.
> + * Return: 1 if voltage range is support, 0 if not, or error number if

supported

> + *	   voltage can't be changed and voltage readback failed.

-- 
With Best Regards,
Andy Shevchenko



