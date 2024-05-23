Return-Path: <linux-kernel+bounces-187105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590238CCD26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150BC282727
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7B13CA92;
	Thu, 23 May 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwDNTINU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA23B29D;
	Thu, 23 May 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450051; cv=none; b=Ic4Htu/hrYp0jYXaYGobTVreRzyu8jnjdt0E8suZWI+Y9Anq9H6GaCUfc1XtU8dngc5LYKJO95zNE/CnaDIb0yHf4fiRseD768v6z7q7Clq8KowpvKI5vFrvoqk70LML+OFGPSboYWJ26XdZpBknFUS3hgMVkJLXSKmnf+KR8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450051; c=relaxed/simple;
	bh=E60JJKQj79tarD45vd9nwKOwa8ME/OAuxSXYut6eJNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T70QX5xzRUO5xTVLMUtfqhU+TY/LDGd8CsfzSU+wwbrX0Nx9xmBU+kWP1yMrLNZo3UfWEljHoI9zIt7b+WlDrWns/O0FJg/8ihn97SLMjI4XvhqAjhnISr1P4S7eRjvfSyksRMyQ9CtL5wXMDehSVYqifvh6BHoCI/Jbu6spVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwDNTINU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716450050; x=1747986050;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=E60JJKQj79tarD45vd9nwKOwa8ME/OAuxSXYut6eJNc=;
  b=kwDNTINUslHpY5LFAh1jSENZCjJIqIgG5jDNsFpuG/CCm8b7zkqz8R73
   CLK6kuzR9W2nhTOTcHHbQbHGuKMtD5xN4FSLFYHux8SAevyW2PNNgbOq2
   sdDeaf75/HHYp+5y8DOAnujxnQsR/dobqI0qfMNDJqCYah6oHwsZ6phKb
   CwF0BviVUoLCQqjmPQJj94zkHCcyF0ocF3KD+7olwdVkjsP2sF4Q4zTbD
   2GdG5EybhhqMF5g0uYsqeENz1EzSl9nCc2VNyQV/sDXxzupNK9GZnh1Cs
   gE//P54EXu5xS3peIj+Byfalla6ArA7Aa+Q6GSNNHA0kptk0nsBgoPDec
   w==;
X-CSE-ConnectionGUID: 7icMKjkJRCCy1RXQwrC+tQ==
X-CSE-MsgGUID: 0m33cdYfSsCy/q1ZUSSXbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="24156018"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="24156018"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 00:40:49 -0700
X-CSE-ConnectionGUID: P9j9i4QGQiuqeLEWiz7LeQ==
X-CSE-MsgGUID: 2IJEzLeNSnCCg+yHhEOIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="34184095"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.57])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 00:40:46 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc-guide: kernel-doc: document Returns: spelling
In-Reply-To: <20240522224726.10498-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240522224726.10498-1-rdunlap@infradead.org>
Date: Thu, 23 May 2024 10:40:43 +0300
Message-ID: <87o78xou10.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 22 May 2024, Randy Dunlap <rdunlap@infradead.org> wrote:
> scripts/kernel-doc accepts "Return:" or "Returns:" for describing the
> return value of a function or function-like macro, so document this
> alternative spelling and use it in an example.

I probably chose to document only one in a futile effort to standardize
on one of the alternatives in the kernel, all of which are accepted by
kernel-doc:

$ git grep -i "^ *\*[\t ]*returns\?:" | grep -oi "returns\?" | sort | uniq -c | sort -rn
  11711 Return
   3992 Returns
   1095 RETURN
    513 return
    361 returns
    291 RETURNS
      1 RETURNs

Documenting the first two is probably fine. :)

BR,
Jani.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/doc-guide/kernel-doc.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -143,7 +143,7 @@ Return values
>  ~~~~~~~~~~~~~
>  
>  The return value, if any, should be described in a dedicated section
> -named ``Return``.
> +named ``Return`` (or ``Returns``).
>  
>  .. note::
>  
> @@ -337,7 +337,7 @@ Typedefs with function prototypes can al
>     * Description of the type.
>     *
>     * Context: Locking context.
> -   * Return: Meaning of the return value.
> +   * Returns: Meaning of the return value.
>     */
>     typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
>  
>

-- 
Jani Nikula, Intel

