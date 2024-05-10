Return-Path: <linux-kernel+bounces-175334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A58C1E23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DD21F22B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07756B9C;
	Fri, 10 May 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRNDEWY6"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629F14F9DB
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322831; cv=none; b=oWibonZURYwbUndifBZ1HD/lywMgiitbxTQK1id/lIB4GOJo0bjFOqjDNuZaD0p50sZAfXV361kMrArhrs/Dh/pTfn/qd+EhNsID0LbX5aKu99/cfuKP3PpHMs65kCKBihztIgq9tRU2hjS0h0d1NIMKvLcbLLELwnyOoUrGbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322831; c=relaxed/simple;
	bh=3ofQXbsjDk0lOpjDWHHWp/oM1EqDprLrmM7JVCDltUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFjNfujejSCDDdR518kbeoF8gKfT+ClaEVCA9LGSL/qioR6h/L+WBZR+Ufx/+w3LK9ftluWy9HYuJC8FZLqKMcdLdamFnJwFf+C1WC/5oVmknjzzIApphcLbSOHw1V1R8kVb3+8rfJSdpC2rdxZTcsaZkaNsX2aHfyob5eK1u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRNDEWY6; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso1959375276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 23:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715322829; x=1715927629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HjyroUHxm+tc1k61kbaX+pvdLFB01JEisDgEC4gIWc=;
        b=qRNDEWY6dYUBrPHexTnaHbJYqce5qrjCQIHjS+Dk0Dfoh0ktMRnN5nIRGJn629oAJM
         +5byVELfgUHicW0wMT4UZ4sTeVZJUkQtbUx0YG9MWoQVrjuehFz0qoVY9iF7H44Cbj2Z
         hWo67Twk1dXj4oxHpX2Ge90njHMAEiFodxS5iI/dYCwt+uON6HCOOUST4hXlrOoan3El
         S1Cx8edOTebbiyxUOVtPuF6sPivPlCco3nQhh+GgGbkom5hlOSRDBCIsgkUdgJBVc/0z
         EJeFINILBeqTdkI7eDfr3vAHb3sL/EKBuOKP5JM/c/xFtsIrLiwWK2IsWmlJ+/FvGr7V
         gxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715322829; x=1715927629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HjyroUHxm+tc1k61kbaX+pvdLFB01JEisDgEC4gIWc=;
        b=nMp1dC/2X6xyz9Un2+Rbj99CfBBOEWatgsZ8KUWiqf4SHPXHtrTwMhYiVKQdhBUxK/
         vRAF7QQG056ZOZNtGlS8nhdV6mskvUVj7hj8NxJRhYGYoABUOkTUG9XyWqoSKY3rduHh
         /WXekm4UN1Pj6o2pxnLViN3hs+amaHS/RpOgQu3C8W+vgs7W68Ss8iKubg7T6HYLdey8
         yNnvZ41KGtqZF7GrjaQY8QXZBi3vxe8FpBH8AXkl70U0ApIAxrR5EHgD5WCI1zSa3aB6
         FHhH54sLLkgsUPvzr4pfYEsJ1NdlxZ7QDD4AtAOzKj/1Cz71ugZSPEEu+I+gDJhclyTT
         3vHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmVremgquspmrMw8TTQN6AFnVlqTs21luHHVMlr4zLl1v/FWcz6ARw1AZh8CmFpeg6FZn9ytHopki7PYRl6yQomPk/ejRQrGJX8BPb
X-Gm-Message-State: AOJu0Yzp1x2L3rQ+0dFsjcKsa9UrsS4OhHo3hkHqNvlgFuF8xtVx27Al
	nfcCEB9eDJfrghgp/RvAykfpuZYWH94WkPQ/TEjvtDORsgMzteWV0JDq04/+L+lcbYCPlL0imfi
	1ObQ1X9ZHLCOP+Rg+BO7S/1NWUIGyloUflEXWhyM2pvf0lomO
X-Google-Smtp-Source: AGHT+IHubxzlkUn7k4BARDf3PiCcUoMRimR8a06KBJqzISFFwH5erCzHVVNfk8KRghfBI5OFESiC+PP8hyVD8zDnkao=
X-Received: by 2002:a25:d3c9:0:b0:dcf:30d9:1d7b with SMTP id
 3f1490d57ef6-dee4f4bac01mr1771090276.45.1715322828717; Thu, 09 May 2024
 23:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510153212.246fbf31@canb.auug.org.au>
In-Reply-To: <20240510153212.246fbf31@canb.auug.org.au>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 10 May 2024 08:33:37 +0200
Message-ID: <CACMJSev6EDeLdQ0e7A7f6AMhh08FznA67x5ONG+vSseC5QLt6A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the
 gpio-brgl-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 07:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the gpio-brgl tree got a conflict in:
>
>   drivers/gpio/gpiolib.h
>
> between commit:
>
>   7765ffed533d ("gpiolib: use a single SRCU struct for all GPIO descriptors")
>
> from the gpio-brgl-fixes tree and commit:
>
>   8a7a61032587 ("gpiolib: Get rid of never false gpio_is_valid() calls")
>
> from the gpio-brgl tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpio/gpiolib.h
> index 8e0e211ebf08,7f94580efdbc..000000000000
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@@ -62,8 -61,7 +62,8 @@@ struct gpio_device
>         struct module           *owner;
>         struct gpio_chip __rcu  *chip;
>         struct gpio_desc        *descs;
>  +      struct srcu_struct      desc_srcu;
> -       int                     base;
> +       unsigned int            base;
>         u16                     ngpio;
>         bool                    can_sleep;
>         const char              *label;

Thanks! I will send the fixes upstream today and then pull v6.9 into
my tree before the merge window PR to fix this conflict.

Bart

