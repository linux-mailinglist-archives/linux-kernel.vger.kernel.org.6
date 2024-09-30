Return-Path: <linux-kernel+bounces-343319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C870989987
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1609F282AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5447F53;
	Mon, 30 Sep 2024 03:34:09 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9143C466
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727667249; cv=none; b=bnvDHgG6KAkXw/dM8vHm/j41FTxGzNFPClbQ9HHWihWNiW6DZLHUQCiLKzFrCUBqovMFL42u65dW/mvk7RReWXUjacdzg40gfVct4NUBVKBk8CGlGFIUAoDtv61DBlQD7Ovl5oy68G2qQqN03CLMBt+pnJDgAq0bwebOHELT12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727667249; c=relaxed/simple;
	bh=IYgrHvPl5tjP0nqGuGGoaxLPfHpRnBR3UStz2R8VKCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5TcQHm4iv/0wD3ajsUbaKpYKPIAiVX+yCgtPedg3BKSO+SKUPztFDWiYJQgWzcTOAE3hw2BjCasFZf0axnYTKhzzzF1MIyYA0febOjKN8JX1w/P7aPBFA55fDwGe3O9Cfnhm7ibP1FmcdLnwudmzg6rD+lYNiUvYiJUM2npuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48U3Xvba018146;
	Mon, 30 Sep 2024 05:33:57 +0200
Date: Mon, 30 Sep 2024 05:33:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: compiler: add macro __nolibc_fallthrough
Message-ID: <20240930033357.GA13730@1wt.eu>
References: <20240929-nolibc-fallthrough-v1-1-5ee07ea9a683@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240929-nolibc-fallthrough-v1-1-5ee07ea9a683@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sun, Sep 29, 2024 at 11:49:57PM +0200, Thomas Weißschuh wrote:
> Recent version of GCC and clang gained -Wimplicit-fallthrough,
> warning about implicit fall-through between switch labels.
> As nolibc does not control the compilation flags, this can trigger
> warnings for when built by the user.
> Make use of the "fallthrough" attribute to explicitly annotate the
> expected fall-throughs and silence the warning.

Good idea!

> +#if __nolibc_has_attribute(fallthrough)
> +#  define __nolibc_fallthrough __attribute__((fallthrough))
> +#else
> +#  define __nolibc_fallthrough
> +#endif /* __nolibc_has_attribute(fallthrough) */

In haproxy we're prepending a "do { } while (0)" statement at the
beginning of the macro, first to make sure to have a statement for
the case where it's not supported, and because gcc-7 will emit a
warning if placed after a label (and clang will even error in this
case). I'm covering all known cases with the following:

  #if __has_attribute(fallthrough)
  #  define __fallthrough do { } while (0); __attribute__((fallthrough))
  #else
  #  define __fallthrough do { } while (0)
  #endif

I think you should do the same here since, as you mentioned, we have
no control over the user's toolchain.

Thanks,
Willy

