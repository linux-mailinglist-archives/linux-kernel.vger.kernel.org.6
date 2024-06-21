Return-Path: <linux-kernel+bounces-225011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DD912A88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C986B26B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28274155740;
	Fri, 21 Jun 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9nUk9UW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C7154BF7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984635; cv=none; b=vBQftYXBuLS3wLTkuRDqLPJGN3gStnxiji5rix13JiGnr11avPlbcVPfoNc0kk7Lin586AehLgVC7N8PjuIjyYd4wvGDqAU33fp14fLRWdtiVYUuVaZQPNPVvB35bOkiYrXrj+2wFI93n5+uaYUXaLZygIkeXBbJKvZevquk+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984635; c=relaxed/simple;
	bh=1DrAgjkjRS34RHzsYGEcIcm6m4uS2uFdoLQxjcx/f74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkz+6/OPnulAr07NG475mnjFy+2WlMTiPgP6wxRns+KMEHfgL3ferVTH73Nn8l27EGuyKJ++xSquPd1DEzkVT0V/QaPTU0Dyvqx0JWYbWqXKc1EErepPdg6h89iIZ94WxTBv0IkJs7olOj8TUdAj3QMItThEYykULXe7cC3WStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9nUk9UW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424720e73e1so18330705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718984632; x=1719589432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XUHa9iYEbZvmgzqh1U+eUfosgSvcbfpDBPY5qT8YXp8=;
        b=Y9nUk9UWnLA85DbYrD109n0iEciQlX4NArby2rvbKZP3mNwBabLD402S70wQ2+oxOZ
         OFWxCN7O8UfptXZTLa6f1+h3FYPRb4rvMPEX2fFbgy3WZh76RaDnfBSLTN15Ko8cuECL
         0cr/Z4o4bIXDeqJnSR77T2ybInhGVXWDZzVnH0/X/L1nbFmJhrx/cyM99S1Tpg1BipbS
         BdWzSURpRijWZZiwlNMC1FIArN2OfEqfzDqIWgIP1wUXX2Othe2T+FHCk5b8QX8zul4Q
         DNWnBl6HxeT4lQo/nr9lF7KWI7qJu1TqMtvtGlZc7nj3q7KDUdT4iC9yWk62sZQ5eKsh
         gF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984632; x=1719589432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUHa9iYEbZvmgzqh1U+eUfosgSvcbfpDBPY5qT8YXp8=;
        b=b3reyuRVqM1mws9Ech/dugFNO9j+3a3BCOUjIvJAB9HSLwzWwCEipaH38CSxN+J7JJ
         CtpAs2/G71Tbbd67QDA56189geFrSLtm24sN9+ilOAEIMr8cgIGoRTwOgNLL2dLP1oNI
         uB+/xWRmpMfhmNhK0dHG+OCNrModLjeUahoEAnwDiyGhQoGLfXUWeawngqJuElUjCryN
         tyFMBQGiWTSbEJ++SurfbZv7Q7bBUBxLlLpazh+YN8KkmOM4Yhbgl0AiORhi/K+jLP9d
         keEq4kWP0xskFaZcP3Vum1XJJV3I4pw3I2cykEPn9OuIkZESkSTfEtXYvs4tsHiHnEQZ
         Zdyg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvKCbRB8eDXzOPLUUV1km7uQQr4OT3Mpel4p6hg81iB2pkVJY/cC1BgWavHs1dMC2Q4xuL7jwZuGXdI7QN61ZSuYc/OcoVdsQaYmW
X-Gm-Message-State: AOJu0Yy8K6Wgo2PgT63IiyIu8DdyVSR7EqRfZKbHql4uSbxExog/aS7/
	M/pd9jaWOTi5uTb2aG80eXJ3GsVbs3FrDk3PxMDSCBv40lFOxPAbXgXe+scNslE=
X-Google-Smtp-Source: AGHT+IG1+aVWE3k4wUAufsZwNZBqBkpcs8JXEc/TgfjSz4jxP8MTMZYu5EooJRNN1bRl8zXXiNm5ew==
X-Received: by 2002:a7b:c8ce:0:b0:422:1446:372 with SMTP id 5b1f17b1804b1-424752968e6mr63883745e9.27.1718984631762;
        Fri, 21 Jun 2024 08:43:51 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9975sm32075185e9.14.2024.06.21.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:43:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:43:49 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] kdb: Add mdi, mdiW / mdiWcN commands to show
 iomapped memory
Message-ID: <20240621154349.GE285771@aspen.lan>
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid>
 <20240618155938.GG11330@aspen.lan>
 <CAD=FV=VTegKBcHY9pgfFUs7T1Ug5r1yg+CxLE6sBhBBt4csfkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VTegKBcHY9pgfFUs7T1Ug5r1yg+CxLE6sBhBBt4csfkw@mail.gmail.com>

On Tue, Jun 18, 2024 at 12:33:05PM -0700, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 18, 2024 at 8:59 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Jun 17, 2024 at 05:34:47PM -0700, Douglas Anderson wrote:
> > > Add commands that are like the other "md" commands but that allow you
> > > to read memory that's in the IO space.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Sorry to be the bearer of bad news but...
> >
> >
> > > ---
> > > <snip>
> > > +/*
> > > + * kdb_getioword
> > > + * Inputs:
> > > + *   word    Pointer to the word to receive the result.
> > > + *   addr    Address of the area to copy.
> > > + *   size    Size of the area.
> > > + * Returns:
> > > + *   0 for success, < 0 for error.
> > > + */
> > > +int kdb_getioword(unsigned long *word, unsigned long addr, size_t size)
> > > +{
> > > +     void __iomem *mapped = ioremap(addr, size);
> >
> > ioremap() is a might_sleep() function. It's unsafe to call it from the
> > debug trap handler.
>
> Hmmmm. Do you have a pointer to documentation or code showing that
> it's a might_sleep() function. I was worried about this initially but
> I couldn't find any documentation or code indicating it to be so. I
> also got no warnings when I ran my prototype code and then the code
> worked fine, so I assumed that it must somehow work. Sigh...
>
> Looking more closely, maybe this is:
>
> ioremap() -> ioremap_prot() -> generic_ioremap_prot() ->
> __get_vm_area_caller() -> __get_vm_area_node() -> __get_vm_area_node()
>
> ...and that has a kernel allocation with GFP_KERNEL?

To be honest there were a lot of problems, I just simplified.

__get_vm_area_node() already commences with a BUG_ON(in_interrupt())
before it ends up doing a GFP_KERNEL memory allocation.

I think there are multiple calls to might_sleep() (for example from
__get_vm_area_node() -> alloc_vmap_area() ).

However even if we had preallocated some vmap addresses for peek/poke
there are still problems in ioremap_page_range() too. For example:

generic_ioremap_prot()
  -> ioremap_page_range()
    -> find_vm_area()
      -> find_vmap_area()
        -> spin_lock()

We could go further down the rabbit hole and pre-lookup the VM area too
but then we hit.

generic_ioremap_prot()
  -> ioremap_page_range()
    -> vmap_page_range()
      -> vmap_range_noflush()
        -> might_sleep()

It is remotely possible that the only lock vmap_page_range() takes is
init_mm->page_table_lock but I doubt we can be sure of that.


> I guess it also then calls alloc_vmap_area()  which has might_sleep()...
>
> I'll have to track down why no warnings triggered...
>
> > I'm afraid I don't know a safe alternative either. Machinary such as
> > kmap_atomic() needs a page and iomem won't have one.
>
> Ugh. It would be nice to come up with something since it's not
> uncommon to need to look at the state of hardware registers when a
> crash happens. In the past I've managed to get into gdb, track down a
> global variable where someone has already mapped the memory, and then
> use gdb to look at the memory. It's always a big pain, though...
>
> ...even if I could just look up the virtual address where someone else
> had already mapped it that might be enough. At least I wouldn't need
> to go track down the globals myself...
>
> ...anyway, I guess I'll ponder on it and poke if I have time...

I've often thought about implementing longjmp-on-spin-wait for kgdb for
these kind of reasons. For example I have long wanted to be able to let
the user see /proc/interrupts before the usespace comes up but the spin
locks get in the way.

This approach wouldn't make calling ioremap() safe (since we could end
up bailing out halfway through a non-atomic operation) but it could at
least give control back to kdb and let the user know they have ruined
their system.

I know... there is a *reason* I've never quite got round to writing
this!


Daniel.

