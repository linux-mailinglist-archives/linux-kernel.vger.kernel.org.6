Return-Path: <linux-kernel+bounces-432700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DD9E4EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB532814E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491731B87F5;
	Thu,  5 Dec 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5Kd7h3v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9371917EE;
	Thu,  5 Dec 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385139; cv=none; b=QYti37lrj+vy7IZOq4CV3mQI/ttI5uvODKVJvdc+F9q00k5cRCaNDe2uvsYHSPI7kirpMgy3aMkHurip2SS2i3QRrNfua2TBGFHgNl9B9yNM6hDZNRH+ypBRPRkq45Ykdl+6zHd0uAHlWVQLIxLw78eYzXhCLZWHAAY+diZDqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385139; c=relaxed/simple;
	bh=Rwg+PdQJTIPxyGHWfwFOok46HlCIMhTkmYpjLF+8SUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGyTqlBftgcDSkDDkTlJaTNYt+/keyRS3X5ddf9Tk3Pp9XUbvSvPbEZL9EUJb61qG/4g96rh2ifb6kdMlhBrbttkwkXi5kGA3tnXHBaha3GsLi0cydubBmsGdLXpfR7P89K4UIbGnVnI+MUVDZhI3HxFZPOLAjmUHv2UToH7+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5Kd7h3v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733385139; x=1764921139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rwg+PdQJTIPxyGHWfwFOok46HlCIMhTkmYpjLF+8SUE=;
  b=A5Kd7h3vLkw50V+RhgumT/L2wnTXZLz8GV3OGoCHB7PaMmJh4e+Y5unI
   fHcyFUnkIeiRIxraybRxqphfugV8x/ITSxKUazUKejvdxE9XyU0XB+sTj
   XYqwYpRVYcp40tb/eox5km29SGtlXJ9Ks/Q5tgimypVtGgPDOARfX6FCV
   ctjR5/9At/04bLedcSMmHTuI/8SI22DVPomjo5+QKPQG5fHWzwHua0LM7
   eO+nyq+G8YEfWWdwyXku0qs4Bi+d8JWD9OljdrQSSb9SnZXfWdj3fh1ip
   pUW7jjqGxXy3iFSAqQjr9350jaoKrh4SDuf256WpRmmKLRr2YVKzSngk6
   g==;
X-CSE-ConnectionGUID: 59AGbZbfSwKG/uHGr+tiWQ==
X-CSE-MsgGUID: RYprabjpSGOLLbI+cbuLTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33565091"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33565091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:52:18 -0800
X-CSE-ConnectionGUID: vjc3Xd/yS6eWxYigD49s+Q==
X-CSE-MsgGUID: zvR7avF3QqqYDvZbTqQClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="124939312"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 23:52:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJ6ej-0000000418Y-2SmO;
	Thu, 05 Dec 2024 09:52:13 +0200
Date: Thu, 5 Dec 2024 09:52:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: module: DEFAULT_SYMBOL_NAMESPACE must be
 defined before #includes
Message-ID: <Z1Fbrbjx-mNTnV0k@smile.fi.intel.com>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <3dd7ff6fa0a636de86e091286016be8c90e03631.1733305665.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd7ff6fa0a636de86e091286016be8c90e03631.1733305665.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 11:01:11AM +0100, Uwe Kleine-König wrote:
> The definition of EXPORT_SYMBOL et al depends on
> DEFAULT_SYMBOL_NAMESPACE. So DEFAULT_SYMBOL_NAMESPACE must already be
> available when <linux/export.h> is parsed.

> -within the corresponding compilation unit before any EXPORT_SYMBOL macro is
> -used.
> +within the corresponding compilation unit before the #include for
> +<linux/export.h>.

And how do I know where it is included in the current state of affairs with the
dependency hell in the kernel?

I suggest to reword it to something like "before any global inclusions", the
best probably is to repeat the piece from pr_fmt() / dev_fmt() documentation
(if any).

-- 
With Best Regards,
Andy Shevchenko



