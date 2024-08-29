Return-Path: <linux-kernel+bounces-307439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4E964D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A494F1F263E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DC1B86DB;
	Thu, 29 Aug 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErWDrzmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D61B86C9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955778; cv=none; b=D+x1ycFFVlYVr+GYwnVtOTnugEZFJzpIQVZEnZUhLguk+N9Qoii91VtTcIScQp75ElbqsEOFNk6pmFe587RCHfWhd7TqXoz6xUVvONTWz525RR7LywGMKkkOat1R4cz3qXhdo7ExuhkHaBQXXLVCkHuqeEwsZ3G7Vk8M8RGf1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955778; c=relaxed/simple;
	bh=DizBn8xXw/cFycbQBGfmHDYKfIcRsOuw62ZWsiuen5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrHtUxBAI/76tNSvA27HT7wq8Hkfypx1fyWH5EC0WcJx8WNXncnfowEKIajwYdr5RdbGxg6Of4UitUfo5teO7TSXFFjPE1vKlTbChMOwWhYj+rnK2LdNx/lmynPS7JDFA2sUovp4GHbEyyLF6H5olBlSDSEbVtdGFLKO/Ve+cYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErWDrzmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F13C4CEC1;
	Thu, 29 Aug 2024 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724955778;
	bh=DizBn8xXw/cFycbQBGfmHDYKfIcRsOuw62ZWsiuen5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErWDrzmCll09v4heo4OXNd0OPzQ1zKlBPXNQOWd36LjiuN4nhCGBoxt/G7eoM37fZ
	 eJtv589/yK+9jpQRcPWcr0nUiYV2XJcEWVhjchmFWNsp/W3GKEwLq3BaZw15KvP8fB
	 mXAKeYRSvxTC8enrhVzN62UYXagHY8yx8bEZZg+NqBuyrAS/V5G8trGVOGcUcicw+p
	 m0AtxKTQH0+v4M0yAfNH+rEk9/wddxwy4T4nubEZooq+NoPKAExiy72tb0NW/qzTol
	 ML8oFj6UptVG0FBx+bMxYEuPfc3fqUIGPTAIkuqLpq+Yff4QGS0A0nlryYgZ7TN4zi
	 YApqmvhgnha4w==
Date: Thu, 29 Aug 2024 11:22:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 0/2] drm/i915/fence: A couple of build fixes
Message-ID: <20240829182255.GA1468662@thelio-3990X>
References: <20240829155950.1141978-1-andriy.shevchenko@linux.intel.com>
 <87cylrwahb.fsf@intel.com>
 <ZtCnhXwtO-gd1fMf@smile.fi.intel.com>
 <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtC5oXSzUuuIgLiQ@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 09:10:41PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2024 at 07:53:25PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 29, 2024 at 07:38:08PM +0300, Jani Nikula wrote:
> > > On Thu, 29 Aug 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > With CONFIG_WERROR=y and `make W=1` build fails on my x86_64 machine.
> > > > This is due to some unused functions. Hence these quick fixes.
> > > 
> > > Since when have we been getting the warnings for static inlines?

Since commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build"). clang warns about unused static inline
functions in .c files, unlike GCC (they both do not warn for functions
coming from .h files). This difference is worked around for the normal
build by adding '__maybe_unused' to the definition of 'inline' but
Masahiro wanted to disable it for W=1 to allow this difference to find
unused/dead code. There have not been too many complaints as far as I am
aware but I can see how it is surprising.

Cheers,
Nathan

