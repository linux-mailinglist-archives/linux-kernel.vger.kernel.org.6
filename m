Return-Path: <linux-kernel+bounces-277342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805CF949F78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4BC1F265A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB1198A39;
	Wed,  7 Aug 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gtLS7Kil"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415A197A97
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010114; cv=none; b=biZl5zYKZZBDi3pFULsE98pL/AULDLjLSLDdOPZV6eKVGPZf9LMGdgrDJnFdacbqj5qha/IEX8vXwHz1BWposM8o1o2gijylLMgaUI3PTpbA+rO/Rm/GvuAjCBRCrTirTjmwXwV2FLOsO2fOPEuAOfDFcF495Mzp4czD0GJGbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010114; c=relaxed/simple;
	bh=2gw9QvYRqtRBab+OFV4Rp2ouTr5WjKwto8HWoLp1gHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrjwqSaOPEOytU+ZGYmSuFGHSF3H6pVInNeoAS2JNSiamMsYn1QIMiq0NngkJrnqzjhNcfwa0Q7LWDCPhbVxzqCi8psFuH6KJ/uxKu5cqnkDOpezR14AcETRel29/cLmZyDt6DCgUSTUuSddVG0sH/ILTYGDZ6N+yKolsK5Pr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gtLS7Kil; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso1070031a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 22:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723010111; x=1723614911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GdVhyQpyLYOhYB5fvYOMRnbsJ+Bwno+rZr/gxKeR4t4=;
        b=gtLS7KilbwMSVzZAx08WPkJMl53I5MiDgRRR4EqQWaiaVCRbE/3uMj+kYEl65lExsq
         /a8a2LsOjEbTyU/G6oV1w/Aqi+D1zWsbqplHl+Pxgur5swgRIIwMIOEMbNvNLWGX/wcY
         +2wtBNx5kUIOGU8s8+moYIn69HT4e5h+shajxb607S6MDf7qeVNRp8gleo63SIXk0Z5C
         VGCplWAX6LCovlpZn16BMA6CsVECzScf3nQJZmqqK300yEXHr3f9QOWFrqYuwB5pmbFv
         QN46fbDceuTLNg6jtL0HUOnJGhHPtRqzrLAd0pTZw+g1w8jX7h5TXenuOUrx0aUTjAiP
         10IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723010111; x=1723614911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdVhyQpyLYOhYB5fvYOMRnbsJ+Bwno+rZr/gxKeR4t4=;
        b=rhYv52aesawqixhgw7PsczjFzc7yzeLFpvxCqP8e0I5QctHdSfS9PFvQdf8A22TscB
         5ALmJcqVcozD3R6NFW/A75QJVhco9JCHKpyvFUsbeY9rqEviVH5D61RXTZnOyz9Tq3KE
         8obyzOk8WOD7jKRd5iYs5oycToCkgrS4Z850GOsOzqLkQ6PIbKBVpKqnB6H1Ock8sDRF
         fG+VjNNYypHIERJ2VjLylJ1wq+RdowSP0786ytAnZ1xv+WBqBPS49eEzmssLplNjXgYH
         z/hdwLG7dHRoMFgbl7k4wRo9COv+ojIbxY781mijjpZu+nmHoXj+znyrvb1EFqwzzqrJ
         vFNA==
X-Gm-Message-State: AOJu0YzANdy09H1QTrplBuCgXAoyfO5J9jGFUOZRoqYZuI4NzFqyfLo9
	7mFvdA7nJM0D6JgF63sUL3CIlnxjl9FewThGIJWX8hWdUmz8Tf0n20XoNID75tI=
X-Google-Smtp-Source: AGHT+IG5FVREIdIHSi/wo1FCywKpZy8w67yn4WoUxHxc1JlUrnptnI7pZdmoWoIbFBNgDuYFpMEoYw==
X-Received: by 2002:a17:90a:3fcf:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2cff9148c7cmr21053224a91.0.1723010111638;
        Tue, 06 Aug 2024 22:55:11 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b1144bsm555615a91.34.2024.08.06.22.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 22:55:10 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:25:05 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: 8250_platform: Fix structure initialization
 warning
Message-ID: <ZrMMOUQai27N-W3T@sunil-laptop>
References: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
 <20240807151352.3d66afe8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807151352.3d66afe8@canb.auug.org.au>

Hi Stephen,

On Wed, Aug 07, 2024 at 03:13:52PM +1000, Stephen Rothwell wrote:
> Hi Sunil,
> 
> On Wed,  7 Aug 2024 09:52:10 +0530 Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> 
> > diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> > index bdfb16bed4f2..d8c3c169a620 100644
> > --- a/drivers/tty/serial/8250/8250_platform.c
> > +++ b/drivers/tty/serial/8250/8250_platform.c
> > @@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
> >  static int serial8250_platform_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct uart_8250_port uart = { 0 };
> > +	struct uart_8250_port uart;
> 
> Does just using "{ }" as an initialiser work without warning?
> 
I tried that and at least on this architecture/compiler combination, the
warning is gone. However, I was not sure about it since gcc man page
indicates such initialization is valid for C++.

Quoting gcc manpage:

-Wmissing-field-initializers

In C this option does not warn about the universal zero initializer ‘{ 0 }’:
struct s { int f, g, h; };
struct s x = { 0 };

Likewise, in C++ this option does not warn about the empty { } initializer, for
example:
struct s { int f, g, h; };
s x = { };

So, I thought doing memset is probably safer which should work across
architectures/compiler combinations.

Thanks,
Sunil

